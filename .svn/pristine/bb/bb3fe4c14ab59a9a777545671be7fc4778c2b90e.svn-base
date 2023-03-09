#Define CRLF Chr(13)+Chr(10)
#INCLUDE "PROTHEUS.ch"                                                                                                                                  
#INCLUDE "TOPCONN.ch"
#INCLUDE "PLSMGER.CH"                                                                                   
#Include "Ap5Mail.Ch"      
#Include 'Tbiconn.ch'           
#INCLUDE 'RWMAKE.CH'
#INCLUDE 'FONT.CH'
#INCLUDE 'COLORS.CH'

User Function CABA183A()

/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±± Declaração de cVariable dos componentes                                 ±±
Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/

Private cCResumo  
Private cHistLibPg
Private cHistNLib 
Private cHistNPgt 

Private nQtdaTit   := 0
Private nVlrImp    := 0
Private nVlrpagto  := 0
Private nVlrtiti   := 0
Private nQtdaVidas := 0

Private nQtdaTitB  := 0
Private nVlrImpB   := 0
Private nVlrpagtoB := 0
Private nVlrtitiB  := 0
Private nQtdaVidaB := 0

Private nQtdaTitT  := 0
Private nVlrImpT   := 0
Private nVlrpagtoT := 0
Private nVlrtitiT  := 0
Private nQtdaVidaT := 0


Private nQtdaTitV  := 0
Private nVlrImpV   := 0
Private nVlrpagtoV := 0
Private nVlrTitiV  := 0
Private nQtdaVidaV := 0

Private nQtdaTitG  := 0
Private nVlrImpG   := 0
Private nVlrpagtoG := 0
Private nVlrTitiG  := 0
Private nQtdaVidaG := 0

Private nQtdaTitNG  := 0
Private nVlrImpNG   := 0
Private nVlrpagtNG  := 0
Private nVlrTitiNG  := 0
Private nQtdaVidNG  := 0

Private nQtdaTitNL  := 0
Private nVlrImpNL   := 0
Private nVlrpagtNL  := 0
Private nVlrTitiNL  := 0
Private nQtdaVidNL  := 0

PRIVATE cAliastmp    := GetNextAlias()
PRIVATE cAliastmp1   := GetNextAlias()
PRIVATE cAliastmp2   := GetNextAlias()

PRIVATE cAliastmp3   := GetNextAlias()
PRIVATE cAliastmp4   := GetNextAlias()
PRIVATE cAliastmp5   := GetNextAlias()


PRIVATE cPerg        := "CABA183A"
PRIVATE cAno         := ' ' 
private cMes         := ' ' 
PRIVATE cTitulos     := ' '
PRIVATE cTitulos1    := ' '
private nPgto1       := 0
Private _cUsuario    := SubStr(cUSUARIO,7,15)
private cDthr        := (dtos(DATE()) + "-" + Time())    

Private _cIdUsuar    := RetCodUsr()
Private _cIdUsuar    :='000047'

//PRIVATE nVlrImp      := 0
If Pergunte(cPerg,.T.) = .F.
	Return
Endif 

cAno         := Mv_par02 
cMes         := Mv_par01

fConsulta()

/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±± Declaração de Variaveis Private dos Objetos                             ±±
Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/
SetPrvt("oDlg183","oSay14","oGrp1","oGrp2","oSay1","oSay2","oSay3","oSay4","oSay5","oGet1","oGet2","oGet3")
SetPrvt("oBtn2","oBtn3","oGet4","oGet5","oGrp3","oSay6","oSay7","oSay8","oSay9","oSay10","oSay11","oSay13")
SetPrvt("oGet6","oGet7","oGet8","oGet9","oGet10","oGet11","oGet12","oGet13","oGet14","oGet15","oGet21")
SetPrvt("oGet23","oGet24","oGet25","oGrp4","oMGet1","oGrp5","oSay12","oSay15","oSay16","oMGet2","oMGet3")

/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±± Definicao do Dialog e todos os seus componentes.                        ±±
Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/
oDlg183    := MSDialog():New( 108,257,726,1066,"AUTORIZAÇÃO DE PAGAMENTOS DE COMISSÃO",,,.F.,,,,,,.T.,,,.T. )
oGrp1      := TGroup():New( 000,000,300,396,"Autorização de Pagamentos de Comissão ",oDlg183,CLR_BLUE,CLR_WHITE,.T.,.F. )
oGrp2      := TGroup():New( 008,004,064,392,"Dados da Liberação ",oGrp1,CLR_BLUE,CLR_WHITE,.T.,.F. )
oSay1      := TSay():New( 016,012,{||"Quantidade de Titulos "},oGrp2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,056,008)
oSay2      := TSay():New( 016,176,{||"Valor Total dos Titulos "},oGrp2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,056,008)
oSay3      := TSay():New( 016,088,{||"Quantidade de Vidas Comissão "},oGrp2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,076,008)
oSay4      := TSay():New( 016,252,{||"Valor Total dos Tribiuto "},oGrp2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,060,008)
oSay5      := TSay():New( 016,325,{||"Valor Total à Pagar "},oGrp2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,056,008)
oGet1      := TGet():New( 028,012,{|u| If(PCount()>0,nQtdaTit:=u,nQtdaTit)},oGrp2,060,008,'@E 999,999',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nQtdaTit",,)
oGet2      := TGet():New( 028,176,{|u| If(PCount()>0,nVlrtiti:=u,nVlrtiti)},oGrp2,060,008,'@E 9,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrtiti",,)
oGet3      := TGet():New( 028,094,{|u| If(PCount()>0,nQtdaVidas:=u,nQtdaVidas)},oGrp2,060,008,'@E 999,999',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nQtdaVidas",,)

oBtn1      := TButton():New( 044,024,"Autoriza",oGrp2,{||fAutor(),oDlg1:End()},037,012,,,,.T.,,"",,,,.F. )
oBtn2      := TButton():New( 045,182,"Demonstra",oGrp2,{||fDemonst() },037,012,,,,.T.,,"",,,,.F. )
oBtn3      := TButton():New( 045,337,"Sair ",oGrp2,{||oDlg183:End()},037,012,,,,.T.,,"",,,,.F. )

oGet4      := TGet():New( 028,254,{|u| If(PCount()>0,nVlrImp:=u,nVlrImp)},oGrp2,060,008,'@E 9,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrImp",,)
oGet5      := TGet():New( 028,324,{|u| If(PCount()>0,nVlrpagto:=u,nVlrpagto)},oGrp2,060,008,'@E 9,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrpagto",,)
oGrp3      := TGroup():New( 065,005,148,392,"Historicos de Liberações  ",oGrp1,CLR_BLUE,CLR_WHITE,.T.,.F. )
oSay6      := TSay():New( 073,013,{||"Quantidad de Titulos "},oGrp3,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,056,008)
oSay7      := TSay():New( 073,177,{||"Valor Total dos Titulos "},oGrp3,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,056,008)
oSay8      := TSay():New( 073,077,{||"Quantidade Vidas Comissionadas "},oGrp3,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,088,008)
oSay9      := TSay():New( 073,257,{||"Valor Total dos Tributos"},oGrp3,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,076,008)
oSay10     := TSay():New( 073,334,{||"Valor Total à Pagar "},oGrp3,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,056,008)
oSay11     := TSay():New( 081,006,{||"--------------------------------------------------------------------------------------------- Falta Visto ------------------------------------------------------------------------------------"},oGrp3,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,584,008)
oSay13     := TSay():New( 102,006,{||"------------------------------------------------------------------------------------------- Bloqueadados ----------------------------------------------------------------------------------"},oGrp3,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,584,008)
oSay17     := TSay():New( 123,006,{||"-------------------------------------------------------------------------------------- Totais da Competência -----------------------------------------------------------------------------"},oGrp3,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,584,008)
oGet6      := TGet():New( 089,009,{|u| If(PCount()>0,nQtdaTitV:=u,nQtdaTitV)},oGrp3,060,008,'@E 999,999',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nQtdaTitV",,)
oGet7      := TGet():New( 089,177,{|u| If(PCount()>0,nVlrTitiV:=u,nVlrTitiV)},oGrp3,060,008,'@E 9,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrTitiV",,)
oGet8      := TGet():New( 089,091,{|u| If(PCount()>0,nQtdaVidaV:=u,nQtdaVidaV)},oGrp3,060,008,'@E 999,999',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nQtdaVidaV",,)
oGet9      := TGet():New( 089,255,{|u| If(PCount()>0,nVlrImpV:=u,nVlrImpV)},oGrp3,060,008,'@E 9,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrImpV",,)
oGet10     := TGet():New( 089,329,{|u| If(PCount()>0,nVlrpagtoV:=u,nVlrpagtoV)},oGrp3,060,008,'@E 9,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrpagtoV",,)
oGet11     := TGet():New( 110,329,{|u| If(PCount()>0,nVlrpagtoB:=u,nVlrpagtoB)},oGrp3,060,008,'@E 9,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrpagtoB",,)
oGet12     := TGet():New( 110,255,{|u| If(PCount()>0,nVlrImpB:=u,nVlrImpB)},oGrp3,060,008,'@E 9,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrImpB",,)
oGet13     := TGet():New( 110,091,{|u| If(PCount()>0,nQtdaVidaB:=u,nQtdaVidaB)},oGrp3,060,008,'@E 999,999',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nQtdaVidaB",,)
oGet14     := TGet():New( 110,177,{|u| If(PCount()>0,nVlrtitiB:=u,nVlrtitiB)},oGrp3,060,008,'@E 9,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrtitiB",,)
oGet15     := TGet():New( 110,009,{|u| If(PCount()>0,nQtdaTitB:=u,nQtdaTitB)},oGrp3,060,008,'@E 999,999',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nQtdaTitB",,)
oGet21     := TGet():New( 131,329,{|u| If(PCount()>0,nVlrpagtoT:=u,nVlrpagtoT)},oGrp3,060,008,'@E 9,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrpagtoT",,)
oGet22     := TGet():New( 131,255,{|u| If(PCount()>0,nVlrImpT:=u,nVlrImpT)},oGrp3,060,008,'@E 9,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrImpT",,)
oGet23     := TGet():New( 131,177,{|u| If(PCount()>0,nVlrtitiT:=u,nVlrtitiT)},oGrp3,060,008,'@E 9,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrtitiT",,)
oGet24     := TGet():New( 131,091,{|u| If(PCount()>0,nQtdaVidaT:=u,nQtdaVidaT)},oGrp3,060,008,'@E 999,999',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nQtdaVidaT",,)
oGet25     := TGet():New( 131,009,{|u| If(PCount()>0,nQtdaTitT:=u,nQtdaTitT)},oGrp3,060,008,'@E 999,999',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nQtdaTitT",,)
oGrp4      := TGroup():New( 224,006,296,392,"Resumo Faturamento ",oGrp1,CLR_BLUE,CLR_WHITE,.T.,.F. )
oMGet1     := TMultiGet():New( 232,008,{|u| If(PCount()>0,cCResumo:=u,cCResumo)},oGrp4,382,060,,,CLR_BLACK,CLR_WHITE,,.T.,"",,,.F.,.F.,.F.,,,.F.,,  )
oGrp5      := TGroup():New( 148,006,224,392,"Historicos de Liberações  ",oGrp1,CLR_BLUE,CLR_WHITE,.T.,.F. )
oSay12     := TSay():New( 156,263,{||"                  Titulos Liberados e Pagos "},oGrp5,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,116,008)
oSay15     := TSay():New( 156,135,{||"                  Titulos Liberados Não Pagos "},oGrp5,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,116,008)
oSay16     := TSay():New( 156,015,{||"                       Titulos Não Liberados "},oGrp5,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,116,008)
oMGet2     := TMultiGet():New( 164,267,{|u| If(PCount()>0,cHistLibPgt:=u,cHistLibPgt)},oGrp5,116,056,,,CLR_BLACK,CLR_WHITE,,.T.,"",,,.F.,.F.,.F.,,,.F.,,  )
oMGet3     := TMultiGet():New( 164,139,{|u| If(PCount()>0,cHistNPgt:=u,cHistNPgt)},oGrp5,116,056,,,CLR_BLACK,CLR_WHITE,,.T.,"",,,.F.,.F.,.F.,,,.F.,,  )
oMGet4     := TMultiGet():New( 164,015,{|u| If(PCount()>0,cHistNLib:=u,cHistNLib)},oGrp5,116,056,,,CLR_BLACK,CLR_WHITE,,.T.,"",,,.F.,.F.,.F.,,,.F.,,  )

oDlg183:Activate(,,,.T.)


Return()


static Function fConsulta() 

local ret       := 0
local  cQuery   := " "   
local  cQuery1  := " "   
local  cQuery2  := " "

local  cQuery3  := " "
local  cQuery4  := " "

cQuery :=  "SELECT COUNT(*) TOTVDA, SUM(bxq_bascom) BasCom , SUM(bxq_vlrcom) VlrCom "
cQuery += CRLF+ "  from  " + RetSqlName("SE2") +" SE2 ," + RetSqlName("BXQ") + " BXQ "
cQuery += CRLF+ " WHERE SE2.d_e_l_e_t_ = ' ' AND E2_FILIAL = '"+xFilial('SE2')+ "' " 
cQuery += CRLF+ "   AND BXQ_FILIAL     = '"+xFilial('BXQ')+ "'  and BXQ.D_E_L_E_T_ = ' ' " 

cQuery += CRLF+ "   and BXQ_ANO    = '"+cAno+"'"
cQuery += CRLF+ "   AND BXQ_MES    = '"+cMes+"'" 
cQuery += CRLF+ "   AND BXQ_CODVEN NOT in ('000174','0001ms72','000171','000191','000177','000215' )"
  
cQuery += CRLF+ "   and BXQ_REFERE = BXQ_PAGCOM "
cQuery += CRLF+ "   and E2_FORNECE = BXQ_E2FORN "  
cQuery += CRLF+ "   and E2_PREFIXO = BXQ_E2PREF "
cQuery += CRLF+ "   and E2_YLTITC <> '2' "
   
cQuery += CRLF+ "   and E2_NUM     = BXQ_E2NUM "
cQuery += CRLF+ "   and E2_PARCELA = BXQ_E2PARC "
cQuery += CRLF+ "   and E2_TIPO    = BXQ_E2TIPO "
cQuery += CRLF+ "   and E2_LOJA    = BXQ_E2LOJA "
cQuery += CRLF+ "   and e2_baixa   = ' ' "

cQuery += CRLF + "    AND nvl(( SELECT COUNT(*) QTDA "
cQuery += CRLF + "                FROM siga."+RetSQLName("PDT")+" PDT  "
cQuery += CRLF + "               WHERE PDT_FILIAL = '" + xFilial('PDT') + "' 
cQuery += CRLF + "                 AND D_e_l_e_t_ = ' ' "
cQuery += CRLF + "                 AND PDT_PREFIX = se2.e2_prefixo "
cQuery += CRLF + "                 AND PDT_NUM    = se2.e2_num "
cQuery += CRLF + "                 AND PDT_PARCEL = se2.e2_parcela "
cQuery += CRLF + "                 AND PDT_TIPO   = se2.e2_tipo  "
cQuery += CRLF + "                 AND PDT_FORNEC = se2.e2_fornece "
cQuery += CRLF + "                 and pdt_aprov  = '000047'),0) = 0 

cQuery += CRLF + "    AND nvl(( SELECT COUNT(*) QTDA "
cQuery += CRLF + "                FROM siga."+RetSQLName("PDT")+" PDT  "
cQuery += CRLF + "               WHERE PDT_FILIAL = '" + xFilial('PDT') + "' 
cQuery += CRLF + "                 AND D_e_l_e_t_ = ' ' "
cQuery += CRLF + "                 AND PDT_PREFIX = se2.e2_prefixo "
cQuery += CRLF + "                 AND PDT_NUM    = se2.e2_num "
cQuery += CRLF + "                 AND PDT_PARCEL = se2.e2_parcela "
cQuery += CRLF + "                 AND PDT_TIPO   = se2.e2_tipo  "
cQuery += CRLF + "                 AND PDT_FORNEC = se2.e2_fornece "
cQuery += CRLF + "                 and pdt_aprov  = '001495'),0) > 0 "
  
If Select((cAliastmp)) <> 0 

   (cAliastmp)->(DbCloseArea())  

Endif                          

  
TCQuery cQuery New Alias (cAliastmp)   

    (cAliastmp)->( DbGoTop() )  

    nQtdaVidas   := (cAliastmp)->TOTVDA
    nVlrtiti     := (cAliastmp)->VlrCom
    
  
cQuery1 :=  "  select COUNT(*) TOTTIT      , "
cQuery1 += CRLF+ "    sum(e2_irrf)    VLRIR, "
cQuery1 += CRLF+ "    sum(e2_inss)    VLINS, "
cQuery1 += CRLF+ "    sum(e2_iss)     VLISS, "
cQuery1 += CRLF+ "    sum(e2_vretpis) VLPIS, " 
cQuery1 += CRLF+ "    sum(e2_vretcsl) VLCSL, "
cQuery1 += CRLF+ "    sum(e2_vretcof) VLCOF, "
cQuery1 += CRLF+ "    SUM(e2_valor )  VLTIT, "
cQuery1 += CRLF+ "    SUM(e2_saldo)  VLPGTO  "
cQuery1 += CRLF+ "  from  " + RetSqlName("SE2") +" SE2 ,"

cQuery1 += CRLF+ "  (SELECT distinct BXQ_E2FORN , "
cQuery1 += CRLF+ "                   BXQ_E2PREF , "
cQuery1 += CRLF+ "                   BXQ_E2NUM  , " 
cQuery1 += CRLF+ "                   BXQ_E2PARC , "
cQuery1 += CRLF+ "                   BXQ_E2TIPO , "
cQuery1 += CRLF+ "                   BXQ_E2LOJA   "
cQuery1 += CRLF+ "  from " + RetSqlName("BXQ") + " BXQ "
cQuery1 += CRLF+ "   WHERE  BXQ_FILIAL     = '"+xFilial('BXQ')+ "'  and BXQ.D_E_L_E_T_ = ' ' " 

cQuery1 += CRLF+ "   and BXQ_ANO    = '"+cAno+"'"
cQuery1 += CRLF+ "   AND BXQ_MES    = '"+cMes+"'" 
cQuery1 += CRLF+ "   and bxq_e2num <>  ' ' "
cQuery1 += CRLF+ "   AND BXQ_CODVEN NOT in ('000174','000172','000171','000191','000177','000215' )) bxq1 "
  
cQuery1 += CRLF+ " WHERE SE2.d_e_l_e_t_ = ' ' AND E2_FILIAL = '"+xFilial('SE2')+ "' " 
  
cQuery1 += CRLF+ "   and E2_FORNECE = bxq1.BXQ_E2FORN "
cQuery1 += CRLF+ "   and E2_PREFIXO = bxq1.BXQ_E2PREF "
cQuery1 += CRLF+ "   and E2_YLTITC <> '2' "
   
cQuery1 += CRLF+ "   and E2_NUM     = bxq1.BXQ_E2NUM  "
cQuery1 += CRLF+ "   and E2_PARCELA = bxq1.BXQ_E2PARC "
cQuery1 += CRLF+ "   and E2_TIPO    = bxq1.BXQ_E2TIPO "
cQuery1 += CRLF+ "   and E2_LOJA    = bxq1.BXQ_E2LOJA  "
cQuery1 += CRLF+ "   and e2_baixa   = ' ' "

cQuery1 += CRLF + "    AND nvl(( SELECT COUNT(*) QTDA "
cQuery1 += CRLF + "                FROM siga."+RetSQLName("PDT")+" PDT  "
cQuery1 += CRLF + "               WHERE PDT_FILIAL = '" + xFilial('PDT') + "' 
cQuery1 += CRLF + "                 AND D_e_l_e_t_ = ' ' "
cQuery1 += CRLF + "                 AND PDT_PREFIX = se2.e2_prefixo "
cQuery1 += CRLF + "                 AND PDT_NUM    = se2.e2_num "
cQuery1 += CRLF + "                 AND PDT_PARCEL = se2.e2_parcela "
cQuery1 += CRLF + "                 AND PDT_TIPO   = se2.e2_tipo  "
cQuery1 += CRLF + "                 AND PDT_FORNEC = se2.e2_fornece "
cQuery1 += CRLF + "                 and pdt_aprov  = '000047'),0) = 0 "

cQuery1 += CRLF + "    AND nvl(( SELECT COUNT(*) QTDA "
cQuery1 += CRLF + "                FROM siga."+RetSQLName("PDT")+" PDT  "
cQuery1 += CRLF + "               WHERE PDT_FILIAL = '" + xFilial('PDT') + "' 
cQuery1 += CRLF + "                 AND D_e_l_e_t_ = ' ' "
cQuery1 += CRLF + "                 AND PDT_PREFIX = se2.e2_prefixo "
cQuery1 += CRLF + "                 AND PDT_NUM    = se2.e2_num "
cQuery1 += CRLF + "                 AND PDT_PARCEL = se2.e2_parcela "
cQuery1 += CRLF + "                 AND PDT_TIPO   = se2.e2_tipo  "
cQuery1 += CRLF + "                 AND PDT_FORNEC = se2.e2_fornece "
cQuery1 += CRLF + "                 and pdt_aprov  = '001495'),0) > 0 "
  

If Select((cAliastmp1)) <> 0 
   (cAliastmp1)->(DbCloseArea())  
Endif                          

TCQuery cQuery1 New Alias (cAliastmp1)   

    (cAliastmp1)->( DbGoTop() )  

    nVlrImp:=((cAliastmp1)->VLRIR + ;
              (cAliastmp1)->VLINS + ;
              (cAliastmp1)->VLISS + ;
              (cAliastmp1)->VLPIS + ;
              (cAliastmp1)->VLCSL + ;
              (cAliastmp1)->VLCOF )

    nQtdaTit     := (cAliastmp1)->TOTTIT 

    nVlrImp      := nVlrImp
    nVlrpagto    := (cAliastmp1)->VLPGTO



cQuery2 :=  " SELECT distinct bxq1.BXQ_E2FORN , "
cQuery2 += CRLF+ "                   bxq1.BXQ_E2PREF , "
cQuery2 += CRLF+ "                   bxq1.BXQ_E2NUM  , " 
cQuery2 += CRLF+ "                   bxq1.BXQ_E2PARC , "
cQuery2 += CRLF+ "                   bxq1.BXQ_E2TIPO , "
cQuery2 += CRLF+ "                   bxq1.BXQ_E2LOJA   "

cQuery2 += CRLF+ "  from  " + RetSqlName("SE2") +" SE2 ,"

cQuery2 += CRLF+ "  (SELECT distinct BXQ_E2FORN , "
cQuery2 += CRLF+ "                   BXQ_E2PREF , "
cQuery2 += CRLF+ "                   BXQ_E2NUM  , " 
cQuery2 += CRLF+ "                   BXQ_E2PARC , "
cQuery2 += CRLF+ "                   BXQ_E2TIPO , "
cQuery2 += CRLF+ "                   BXQ_E2LOJA   "

cQuery2 += CRLF+ "  from " + RetSqlName("BXQ") + " BXQ "
cQuery2 += CRLF+ "   WHERE  BXQ_FILIAL     = '"+xFilial('BXQ')+ "'  and BXQ.D_E_L_E_T_ = ' ' " 

cQuery2 += CRLF+ "   and BXQ_ANO    = '"+cAno+"'"
cQuery2 += CRLF+ "   AND BXQ_MES    = '"+cMes+"'" 
cQuery2 += CRLF+ "   and bxq_e2num <>  ' ' "
cQuery2 += CRLF+ "   AND BXQ_CODVEN NOT in ('000174','000172','000171','000191','000177','000215' )) bxq1 "
  
cQuery2 += CRLF+ " WHERE SE2.d_e_l_e_t_ = ' ' AND E2_FILIAL = '"+xFilial('SE2')+ "' " 
  
cQuery2 += CRLF+ "   and E2_FORNECE = bxq1.BXQ_E2FORN "
cQuery2 += CRLF+ "   and E2_PREFIXO = bxq1.BXQ_E2PREF "
cQuery2 += CRLF+ "   and E2_YLTITC <> '2' "
   
cQuery2 += CRLF+ "   and E2_NUM     = bxq1.BXQ_E2NUM  "
cQuery2 += CRLF+ "   and E2_PARCELA = bxq1.BXQ_E2PARC "
cQuery2 += CRLF+ "   and E2_TIPO    = bxq1.BXQ_E2TIPO "
cQuery2 += CRLF+ "   and E2_LOJA    = bxq1.BXQ_E2LOJA "
cQuery2 += CRLF+ "   and e2_baixa   = ' ' "  

cQuery2 += CRLF + "    AND nvl(( SELECT COUNT(*) QTDA "
cQuery2 += CRLF + "                FROM siga."+RetSQLName("PDT")+" PDT  "
cQuery2 += CRLF + "               WHERE PDT_FILIAL = '" + xFilial('PDT') + "' 
cQuery2 += CRLF + "                 AND D_e_l_e_t_ = ' ' "
cQuery2 += CRLF + "                 AND PDT_PREFIX = se2.e2_prefixo "
cQuery2 += CRLF + "                 AND PDT_NUM    = se2.e2_num "
cQuery2 += CRLF + "                 AND PDT_PARCEL = se2.e2_parcela "
cQuery2 += CRLF + "                 AND PDT_TIPO   = se2.e2_tipo  "
cQuery2 += CRLF + "                 AND PDT_FORNEC = se2.e2_fornece "
cQuery2 += CRLF + "                 and pdt_aprov  = '000047'),0) = 0 "

cQuery2 += CRLF + "    AND nvl(( SELECT COUNT(*) QTDA "
cQuery2 += CRLF + "                FROM siga."+RetSQLName("PDT")+" PDT  "
cQuery2 += CRLF + "               WHERE PDT_FILIAL = '" + xFilial('PDT') + "' 
cQuery2 += CRLF + "                 AND D_e_l_e_t_ = ' ' "
cQuery2 += CRLF + "                 AND PDT_PREFIX = se2.e2_prefixo "
cQuery2 += CRLF + "                 AND PDT_NUM    = se2.e2_num "
cQuery2 += CRLF + "                 AND PDT_PARCEL = se2.e2_parcela "
cQuery2 += CRLF + "                 AND PDT_TIPO   = se2.e2_tipo  "
cQuery2 += CRLF + "                 AND PDT_FORNEC = se2.e2_fornece "
cQuery2 += CRLF + "                 and pdt_aprov  = '001495'),0) > 0 "

If Select((cAliastmp2)) <> 0 
   (cAliastmp2)->(DbCloseArea())  
Endif                          

TCQuery cQuery2 New Alias (cAliastmp2)   

    (cAliastmp2)->( DbGoTop() )  

    While !(cAliastmp2)->(Eof())


        cTitulos  += trim((cAliastmp2)->BXQ_E2NUM )+"|"
					
       (cAliastmp2)->(DbSkip())
	
	Enddo		

	cTitulos1 := FormatIn(cTitulos ,"|")

///// consultas as liberadas e pagas e nao pagas 

cQuery3 := CRLF+ " Select Sum(Bxq.Totvda) Totvda, Sum(Bxq.Bascom) Bascom , Sum(Bxq.Vlrcom) Vlrcom , " 
cQuery3 += CRLF+ "        Sum(Se2.Qtdtit) Tqtdtit , "
cQuery3 += CRLF+ "        Sum(Se2.Saldo) Tsaldo , "
cQuery3 += CRLF+ "        Sum(Se2.Valor) Tvalor , "
cQuery3 += CRLF+ "        Sum(Se2.Irrf)  Tirrf , "
cQuery3 += CRLF+ "        Sum(Se2.Inss) Tinss , "
cQuery3 += CRLF+ "        Sum(Se2.Pis) Tpis , "
cQuery3 += CRLF+ "        Sum(Se2.Csll) Tcsll , "
cQuery3 += CRLF+ "        Sum(Se2.Cofins) TCofins , "
cQuery3 += CRLF+ "        Sum(Se2.Iss) TIss , "
cQuery3 += CRLF+ "        Decode (Se2.Titlib , 2, 'Bloq' , 'Lib') Titlib , "
cQuery3 += CRLF+ "        Decode (Pdt1.Aprovador ,Null, 'Nao' , 'Sim') Liberado , "
cQuery3 += CRLF+ "        Decode (Pdt2.Vistador  ,Null, 'Nao' , 'Sim') Vistado , "
cQuery3 += CRLF+ "        Decode (Se2.Saldo ,0 , 'Sim' , 'Nao') Pagto "
cQuery3 += CRLF+ " From "
  // comissao 
cQuery3 += CRLF+ " (Select Bxq_E2pref ,Bxq_E2num , Bxq_E2parc ,Bxq_E2tipo , Bxq.Bxq_E2forn , Bxq.Bxq_Codemp , "
cQuery3 += CRLF+ "         Count(*) Totvda , "
cQuery3 += CRLF+ "         Sum(Bxq_Bascom) Bascom , " 
cQuery3 += CRLF+ "         Sum(Bxq_Vlrcom) Vlrcom   "
cQuery3 += CRLF+ "    From " + RetSqlName("BXQ") + " BXQ " 
cQuery3 += CRLF+ "   Where Bxq_Filial = '"+xFilial('BXQ')+ "' And Bxq.D_E_L_E_T_ = ' ' "  
cQuery3 += CRLF+ "     and BXQ_ANO    = '"+cAno+"' "
cQuery3 += CRLF+ "     AND BXQ_MES    = '"+cMes+"' "
cQuery3 += CRLF+ "     And Bxq_Codven Not In ('000174','000172','000171','000191','000177','000215' ) "
cQuery3 += CRLF+ "     And Bxq_Refere = Bxq_Pagcom "
cQuery3 += CRLF+ "     and bxq_e2num <>  ' ' "
cQuery3 += CRLF+ "   Group By  Bxq_E2pref ,Bxq_E2num , Bxq_E2parc ,Bxq_E2tipo, Bxq.Bxq_E2forn , Bxq.Bxq_Codemp "
cQuery3 += CRLF+ "   Order By Bxq_Codemp ) Bxq , "
  // titulos(se2)        
cQuery3 += CRLF+ " (Select E2_Prefixo ,E2_Num , E2_Parcela ,E2_Tipo , E2_Fornece , " 
cQuery3 += CRLF+ "         E2_Baixa Baixa , "
cQuery3 += CRLF+ "         E2_Yltitc Titlib , "
cQuery3 += CRLF+ "         Count(*) Qtdtit , "
cQuery3 += CRLF+ "         Sum(E2_Saldo) Saldo , " 
cQuery3 += CRLF+ "         Sum(E2_Valor) Valor , " 
cQuery3 += CRLF+ "         Sum(E2_Irrf) Irrf , "
cQuery3 += CRLF+ "         Sum(E2_Inss) Inss , "
cQuery3 += CRLF+ "         Sum(E2_Vretpis) Pis , " 
cQuery3 += CRLF+ "         Sum(E2_Vretcsl) Csll , "
cQuery3 += CRLF+ "         Sum(E2_Vretcof)Cofins , "
cQuery3 += CRLF+ "         Sum(E2_ISS) Iss  "
cQuery3 += CRLF+ "    From " + RetSqlName("SE2") +" SE2 " 
cQuery3 += CRLF+ "   Where E2_Filial   = '"+xFilial('SE2')+ "' " 
cQuery3 += CRLF+ "     And Se2.D_E_L_E_T_     = ' '  "
cQuery3 += CRLF+ "     And E2_Tipo     = 'DP' "
cQuery3 += CRLF+ "     And Trim(E2_Prefixo)  = 'COM' "
cQuery3 += CRLF+ "     And E2_Emissao >= '20200101' "
cQuery3 += CRLF+ "   Group By E2_Prefixo ,E2_Num , E2_Parcela ,E2_Tipo , E2_Fornece , E2_Baixa ,E2_Yltitc ) Se2 , "
  // Aprovação  
cQuery3 += CRLF+ " ( Select Pdt_Prefix , Pdt_Num , Pdt_Parcel , Pdt_Tipo , Pdt_Fornec , "
cQuery3 += CRLF+ "          Pdt_Aprov  Aprovador "
cQuery3 += CRLF+ "      FROM siga."+RetSQLName("PDT")+" PDT  "
cQuery3 += CRLF+ "    WHERE PDT_FILIAL = '" + xFilial('PDT') + "' "
cQuery3 += CRLF+ "      And D_E_L_E_T_ = ' ' "
cQuery3 += CRLF+ "      And Pdt_Aprov(+)  = '000047' "
cQuery3 += CRLF+ "    Order By Pdt_Prefix , Pdt_Num , Pdt_Parcel , Pdt_Tipo , Pdt_Fornec) Pdt1 , "
  // Visto
cQuery3 += CRLF+ " ( Select Pdt_Prefix , Pdt_Num , Pdt_Parcel , Pdt_Tipo , Pdt_Fornec , "
cQuery3 += CRLF+ "          Pdt_Aprov  Vistador "
cQuery3 += CRLF+ "     FROM siga."+RetSQLName("PDT")+" PDT  "
cQuery3 += CRLF+ "    WHERE PDT_FILIAL = '" + xFilial('PDT') + "' " 
cQuery3 += CRLF+ "      And D_E_L_E_T_ = ' ' "
cQuery3 += CRLF+ "      And Pdt_Aprov(+)  = '001495' "
cQuery3 += CRLF+ "    Order By Pdt_Prefix , Pdt_Num , Pdt_Parcel , Pdt_Tipo , Pdt_Fornec ) Pdt2 "   

cQuery3 += CRLF+ "    Where Se2.E2_Num     = Bxq.Bxq_E2num "
cQuery3 += CRLF+ "      And Se2.E2_Parcela = Bxq.Bxq_E2parc "
cQuery3 += CRLF+ "      And Se2.E2_Tipo    = Bxq.Bxq_E2tipo  "  
cQuery3 += CRLF+ "      And Pdt1.Pdt_Prefix(+) = Se2.E2_Prefixo " 
cQuery3 += CRLF+ "      And Pdt1.Pdt_Num(+)    = Se2.E2_Num  "
cQuery3 += CRLF+ "      And Pdt1.Pdt_Parcel(+) = Se2.E2_Parcela "
cQuery3 += CRLF+ "      And Pdt1.Pdt_Tipo(+)   = Se2.E2_Tipo  "
cQuery3 += CRLF+ "      And Pdt1.Pdt_Fornec(+) = Se2.E2_Fornece "
cQuery3 += CRLF+ "      And Pdt2.Pdt_Prefix(+) = Se2.E2_Prefixo "
cQuery3 += CRLF+ "      And Pdt2.Pdt_Num(+)    = Se2.E2_Num "
cQuery3 += CRLF+ "      And Pdt2.Pdt_Parcel(+) = Se2.E2_Parcela "  
cQuery3 += CRLF+ "      And Pdt2.Pdt_Tipo(+)   = Se2.E2_Tipo  "
cQuery3 += CRLF+ "      And Pdt2.Pdt_Fornec(+) = Se2.E2_Fornece "
cQuery3 += CRLF+ " Group By Decode (Se2.Titlib , 2, 'Bloq' , 'Lib') , " 
cQuery3 += CRLF+ "          Decode (Pdt1.Aprovador ,Null, 'Nao' , 'Sim') , "
cQuery3 += CRLF+ "          Decode (Pdt2.Vistador  ,Null, 'Nao' , 'Sim') , "
cQuery3 += CRLF+ "          Decode (Se2.Saldo ,0 , 'Sim' , 'Nao') "
  
If Select((cAliastmp3)) <> 0 

   (cAliastmp3)->(DbCloseArea())  

Endif    


nQtdaTitB  := 0
nVlrImpB   := 0
nVlrpagtoB := 0
nVlrtitiB  := 0
nQtdaVidaB := 0

nQtdaTitT  := 0
nVlrImpT   := 0
nVlrpagtoT := 0
nVlrtitiT  := 0
nQtdaVidaT := 0

nQtdaTitV  := 0
nVlrImpV   := 0
nVlrpagtoV := 0
nVlrTitiV  := 0
nQtdaVidaV := 0

nQtdaTitG  := 0
nVlrImpG   := 0
nVlrpagtoG := 0
nVlrTitiG  := 0
nQtdaVidaG := 0

nQtdaTitNG  := 0
nVlrImpNG   := 0
nVlrpagtNG  := 0
nVlrTitiNG  := 0
nQtdaVidNG  := 0

nQtdaTitNL := 0
nVlrImpNL   := 0
nVlrpagtNL  := 0
nVlrTitiNL  := 0
nQtdaVidNL  := 0


TCQuery cQuery3 New Alias (cAliastmp3)   

    (cAliastmp3)->( DbGoTop() )            

    While !(cAliastmp3)->(Eof())

        nQtdaTitT  += (cAliastmp3)->Tqtdtit
        nVlrImpT   +=((cAliastmp3)->TIRRF + ;
                      (cAliastmp3)->TINSS + ;
                      (cAliastmp3)->TISS  + ;
                      (cAliastmp3)->TPIS  + ;
                      (cAliastmp3)->TCSLL + ;
                      (cAliastmp3)->TCOFINS )
        nVlrpagtoT += (cAliastmp3)->TVALOR 
        nVlrtitiT  += nVlrImpT + nVlrpagtoT 
        nQtdaVidaT += (cAliastmp3)->Totvda

        If (cAliastmp3)->Liberado == 'Nao' .and. (cAliastmp3)->Vistado  == 'Sim'

            nQtdaTitB  += (cAliastmp3)->Tqtdtit
            nVlrImpB   +=((cAliastmp3)->TIRRF + ;
                          (cAliastmp3)->TINSS + ;
                          (cAliastmp3)->TISS  + ;
                          (cAliastmp3)->TPIS  + ;
                          (cAliastmp3)->TCSLL + ;
                          (cAliastmp3)->TCOFINS )
            nVlrpagtoB += (cAliastmp3)->TVALOR 
            nVlrtitiB  += nVlrImpB + nVlrpagtoB 
            nQtdaVidaB += (cAliastmp3)->Totvda

        EndIf 

        If (cAliastmp3)->Vistado  == 'Nao'

            nQtdaTitV  += (cAliastmp3)->Tqtdtit
            nVlrImpV   +=((cAliastmp3)->TIRRF + ;
                          (cAliastmp3)->TINSS + ;
                          (cAliastmp3)->TISS  + ;
                          (cAliastmp3)->TPIS  + ;
                          (cAliastmp3)->TCSLL + ;
                          (cAliastmp3)->TCOFINS )
            nVlrpagtoV += (cAliastmp3)->TVALOR 
            nVlrtitiV  += nVlrImpV + nVlrpagtoV 
            nQtdaVidaV += (cAliastmp3)->Totvda

        EndIf 

    If (cAliastmp3)->Vistado  == 'Sim'
        
        If (cAliastmp3)->LIBERADO == 'Sim' .and. (cAliastmp3)->PAGTO == 'Sim'

            nQtdaTitG  += (cAliastmp3)->Tqtdtit
            nVlrImpG   +=((cAliastmp3)->TIRRF + ;
                          (cAliastmp3)->TINSS + ;
                          (cAliastmp3)->TISS  + ;
                          (cAliastmp3)->TPIS  + ;
                          (cAliastmp3)->TCSLL + ;
                          (cAliastmp3)->TCOFINS )
            nVlrpagtoG += (cAliastmp3)->TVALOR 
            nVlrtitiG  += nVlrImpG + nVlrpagtoG 
            nQtdaVidaG += (cAliastmp3)->Totvda

        EndIF

        If (cAliastmp3)->LIBERADO == 'Sim' .and. (cAliastmp3)->PAGTO == 'Nao' 

            nQtdaTitNG  += (cAliastmp3)->Tqtdtit
            nVlrImpNG   +=((cAliastmp3)->TIRRF + ;
                          (cAliastmp3)->TINSS + ;
                          (cAliastmp3)->TISS  + ;
                          (cAliastmp3)->TPIS  + ;
                          (cAliastmp3)->TCSLL + ;
                          (cAliastmp3)->TCOFINS )
            nVlrpagtNG += (cAliastmp3)->TVALOR 
            nVlrtitiNG  += nVlrImpNG + nVlrpagtNG 
            nQtdaVidNG += (cAliastmp3)->Totvda

        EndIF

        If (cAliastmp3)->LIBERADO == 'Nao' .and. (cAliastmp3)->PAGTO == 'Nao' 

            nQtdaTitNL  += (cAliastmp3)->Tqtdtit
            nVlrImpNL   += ((cAliastmp3)->TIRRF + ;
                            (cAliastmp3)->TINSS + ;
                            (cAliastmp3)->TISS  + ;
                            (cAliastmp3)->TPIS  + ;
                            (cAliastmp3)->TCSLL + ;
                            (cAliastmp3)->TCOFINS )
            nVlrpagtNL += (cAliastmp3)->TVALOR 
            nVlrtitiNL += nVlrImpNL + nVlrpagtNL 
            nQtdaVidNL += (cAliastmp3)->Totvda

        EndIF

    EndIf          
    				
       (cAliastmp3)->(DbSkip())
	
	Enddo

    cHistLibPgt:= 'Quatidade de Titulos   : '+Space(13-len(alltrim(Transform(nQtdaTitG  , '@E 999,999'))))       + Transform(nQtdaTitG  , '@E 999,999')      + CRLF
    cHistLibPgt+= 'Quatidade de Vidas     : '+Space(13-len(alltrim(Transform(nQtdaVidaG , '@E 999,999'))))       + Transform(nQtdaVidaG , '@E 999,999')      + CRLF 
    cHistLibPgt+= 'Total dos Titulo       : '+Space(13-len(alltrim(Transform(nVlrtitiG  , '@E 99,999,999.99')))) + Transform(nVlrtitiG  , '@E 99,999,999.99')+ CRLF 
    cHistLibPgt+= 'Valor Impostos         : '+Space(13-len(alltrim(Transform(nVlrImpG   , '@E 99,999,999.99')))) + Transform(nVlrImpG   , '@E 99,999,999.99')+ CRLF  
    cHistLibPgt+= 'Valor Pago             : '+Space(13-len(alltrim(Transform(nVlrpagtoG , '@E 99,999,999.99')))) + Transform(nVlrpagtoG , '@E 99,999,999.99')+ CRLF   
 

    cHistNPgt:= 'Quatidade de Titulos     : '+Space(13-len(alltrim(Transform(nQtdaTitnG , '@E 999,999'))))       + Transform(nQtdaTitnG , '@E 999,999')      + CRLF
    cHistNPgt+= 'Quatidade de Vidas       : '+Space(13-len(alltrim(Transform(nQtdaVidNG , '@E 999,999'))))       + Transform(nQtdaVidNG , '@E 999,999')      + CRLF
    cHistNPgt+= 'Total dos Titulo         : '+Space(13-len(alltrim(Transform(nVlrtitiNG , '@E 99,999,999.99')))) + Transform(nVlrtitiNG , '@E 99,999,999.99')+ CRLF
    cHistNPgt+= 'Valor Impostos           : '+Space(13-len(alltrim(Transform(nVlrImpNG  , '@E 99,999,999.99')))) + Transform(nVlrImpNG  , '@E 99,999,999.99')+ CRLF 
    cHistNPgt+= 'Valor Pago               : '+Space(13-len(alltrim(Transform(nVlrpagtNG , '@E 99,999,999.99')))) + Transform(nVlrpagtNG , '@E 99,999,999.99')+ CRLF 


    cHistNLib:= 'Quatidade de Titulos     : '+Space(13-len(alltrim(Transform(nQtdaTitnL , '@E 999,999'))))       + Transform(nQtdaTitnL , '@E 999,999')      + CRLF 
    cHistNLib+= 'Quatidade de Vidas       : '+Space(13-len(alltrim(Transform(nQtdaVidNL , '@E 999,999'))))       + Transform(nQtdaVidNL , '@E 999,999')      + CRLF  
    cHistNLib+= 'Total dos Titulo         : '+Space(13-len(alltrim(Transform(nVlrtitiNL , '@E 99,999,999.99')))) + Transform(nVlrtitiNL , '@E 99,999,999.99')+ CRLF 
    cHistNLib+= 'Valor Impostos           : '+Space(13-len(alltrim(Transform(nVlrImpNL  , '@E 99,999,999.99')))) + Transform(nVlrImpNL  , '@E 99,999,999.99')+ CRLF
    cHistNLib+= 'Valor Pago               : '+Space(13-len(alltrim(Transform(nVlrpagtNL , '@E 99,999,999.99')))) + Transform(nVlrpagtNL , '@E 99,999,999.99')+ CRLF 
 
    cCResumo   := 'TESTE DE RESUMO'

Return (ret)

Static Function fAutor()

   (cAliastmp2)->( DbGoTop() )  

        DBSELECTAREA("PDT")   
        PDT->(dbSetOrder(1))

        While !(cAliastmp2)->(Eof())
	
            PDT->(Reclock("PDT",.T.))

				PDT_FILIAL   := xFilial('PDT')  
				PDT_PREFIX   := (cAliastmp2)->BXQ_E2PREF
				PDT_NUM      := (cAliastmp2)->BXQ_E2NUM  
				PDT_PARCEL   := (cAliastmp2)->BXQ_E2PARC
				PDT_TIPO     := (cAliastmp2)->BXQ_E2TIPO
				PDT_FORNEC   := (cAliastmp2)->BXQ_E2FORN  
				PDT_APROV    := '000047'  
				PDT_TPAPRO   := 'A'  
				PDT_DTAPRO   := DATE()  
				PDT_LIBERA   := 'S'  
				PDT_MODULO   := 'COM'  
				PDT_GRPAPR   := '909098'  
				PDT_NOMAPV   := 'Suexe1 - Dr   Haroldo '         
				PDT_LOG      := "Usuario : " +_cUsuario + " Data Hora Geração " +cDthr
				PDT_ACAO     := 'A'

			PDT->(MsUnlock())

			//where (e2_mtblcm <> ' ' or E2_LGBLCM <> ' ' ) E2_YNAPRO ->SE2->E2_APRUSR:=

            nPgto1++
              
            (cAliastmp2)->(DbSkip())
   
        Enddo		

        MsgAlert("Todas os titulos de comissõs foram Liberados para pagamento !!","Atencao!")

Return()

static function fDemonst()

    nPgto1:=0 

    nPgto1:= u_CABA182( 1 , ctitulos , ctitulos1)

    If nPgto1 > 0
       
       MsgAlert("Foram feitas Liberações  Pontuais  !!","Atencao!")

       fConsulta()

       oGet1:Refresh
       oGet2:Refresh
       oGet3:Refresh
       oGet4:Refresh
       oGet5:Refresh  
    
    EndIf
Return()


