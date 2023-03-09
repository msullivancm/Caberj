#Define CRLF Chr(13)+Chr(10)
#INCLUDE "PROTHEUS.ch"                                                                                                                                  
#INCLUDE "TOPCONN.ch"
#INCLUDE "PLSMGER.CH"                                                                                   
#Include "Ap5Mail.Ch"      
#Include 'Tbiconn.ch'           
#INCLUDE 'RWMAKE.CH'
#INCLUDE 'FONT.CH'
#INCLUDE 'COLORS.CH'

User Function CABA183()

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

Private nVlrBasA   := 0
Private nVlrBasR   := 0
Private nVlrBasT   := 0
Private nVlrBasV   := 0

Private nVlrComA   := 0
Private nVlrComR   := 0
Private nVlrComT   := 0
Private nVlrComV   := 0

Private nVlrMedA   := 0
Private nVlrMedR   := 0
Private nVlrMedT   := 0
Private nVlrMedV   := 0

Private cIncCom    := 0
Private cNIncCom   := 0
Private cTotFat    := 0

Private nVlrTotA   := 0
Private nVlrTotR   := 0
Private nVlrTotT   := 0
Private nVlrTotV   := 0
Private nPecMedT   := 0


PRIVATE cAliastmp    := GetNextAlias()
PRIVATE cAliastmp1   := GetNextAlias()
PRIVATE cAliastmp2   := GetNextAlias()

PRIVATE cAliastmp3   := GetNextAlias()
PRIVATE cAliastmp4   := GetNextAlias()
PRIVATE cAliastmp5   := GetNextAlias()
PRIVATE cAliastmp6   := GetNextAlias()

PRIVATE cPerg        := "CABA183A"
PRIVATE cAno         := ' ' 
private cMes         := ' ' 
PRIVATE cTitulos     := ''
PRIVATE cTitulos1    := ''
private nPgto1       := 0
Private _cUsuario    := SubStr(cUSUARIO,7,15)
private cDthr        := (dtos(DATE()) + "-" + Time())    

Private _cIdUsuar    := RetCodUsr()

Private _cIdUsuar    :='000047'
Private _cIdUsr1     :='000026'
Private _cIdUsr2     :='000310'

Private _cUsuario    := SubStr(cUSUARIO,7,15)
private _UserLog     := RetCodUsr()

//PRIVATE nVlrImp      := 0
If Pergunte(cPerg,.T.) = .F.
	Return
Endif 

cAno         := Mv_par02 
cMes         := Mv_par01


/* 
for i:=1 to 55
    IncProc('Aguarde Buscando dados no Servidor  ....')
next             
*/
    Processa({||Processa1()},"Buscando Dados no Servidor", "Aguarde ....", .T.)   

    MsgInfo("Processo finalizado")

return()

Static Function Processa1()

fConsulta()

/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±± Declaração de Variaveis Private dos Objetos                             ±±
Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/
SetPrvt("oDlg183","oSay14","oGrp1","oGrp2","oSay1","oSay2","oSay3","oSay4","oSay5","oGet1","oGet2","oGet3")
SetPrvt("oBtn2","oBtn3","oGet4","oGet5","oGrp3","oSay6","oSay7","oSay8","oSay9","oSay10","oSay11","oSay13")
SetPrvt("oGet6","oGet7","oGet8","oGet9","oGet10","oGet11","oGet12","oGet13","oGet14","oGet15","oGet21")
SetPrvt("oGet23","oGet24","oGet25","oGrp4","oMGet1","oGrp8","oSay26","oSay27","oSay28","oSay29","oSay30")
SetPrvt("oGet32","oGet33","oGet34","oGet35","oGrp7","oSay15","oSay22","oSay23","oSay24","oSay25","oGet26")
SetPrvt("oGet28","oGet29","oGet30","oGrp6","oSay16","oSay18","oSay19","oSay20","oSay21","oGet16","oGet17")
SetPrvt("oGet19","oGet20")

SetPrvt("oDlg183","oSay14","oGrp1","oSay12","oGrp2","oSay1","oSay2","oSay3","oSay4","oSay5","oGet1","oGet2")
SetPrvt("oBtn1","oBtn2","oBtn3","oGet4","oGet5","oBtn4","oBtn5","oGrp3","oSay6","oSay7","oSay8","oSay9")
SetPrvt("oSay11","oSay13","oSay17","oGet6","oGet7","oGet8","oGet9","oGet10","oGet11","oGet12","oGet13")
SetPrvt("oGet15","oGet21","oGet22","oGet23","oGet24","oGet25","oGrp4","oSay38","oSay39","oSay40","oGet48")
SetPrvt("oGet50","oGrp8","oSay26","oSay27","oSay28","oSay29","oSay30","oGet31","oGet32","oGet33","oGet34")
SetPrvt("oGrp7","oSay15","oSay22","oSay23","oSay24","oSay25","oGet26","oGet27","oGet28","oGet29","oGet30")
SetPrvt("oSay16","oSay18","oSay19","oSay20","oSay21","oGet16","oGet17","oGet18","oGet19","oGet20","oGrp5")
SetPrvt("oSay49","oSay50","oSay51","oSay52","oSay53","oSay54","oGet56","oGet57","oGet58","oGet59","oGet60")
SetPrvt("oGet62","oGet63","oGet64","oGet65","oGet66","oGet67","oGrp9","oSay45","oSay46","oSay47","oSay65")
SetPrvt("oSay67","oGet54","oGet55","oGet76","oGet77","oGet78")

/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±± Definicao do Dialog e todos os seus componentes.                        ±±
Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/
If  Mv_par03 == 1 
    oDlg183    := MSDialog():New( 088,292,704,1098,"AUTORIZAÇÃO DE PAGAMENTOS DE COMISSÃO - COMPETÊNCIA "+cMes+"/"+cAno,,,.F.,,,,,,.T.,,,.T. )
Else     
    oDlg183    := MSDialog():New( 088,292,704,1098,"VISUALIZAÇÃO DE PAGAMENTOS DE COMISSÃO - COMPETÊNCIA "+cMes+"/"+cAno,,,.F.,,,,,,.T.,,,.T. )
EndIF    
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

oBtn1      := TButton():New( 044,024,"Autoriza",oGrp2,{||fAutor()},037,012,,,,.T.,,"",,,,.F. )
oBtn2      := TButton():New( 045,130,"Estatistica ",oGrp2,{||fRodape()},037,012,,,,.T.,,"",,,,.F. )
oBtn3      := TButton():New( 045,230,"Demonstra",oGrp2,{||fDemonst()},037,012,,,,.T.,,"",,,,.F. )
oBtn4      := TButton():New( 045,337,"Sair ",oGrp2,{||oDlg183:End()},037,012,,,,.T.,,"",,,,.F. )

oGet4      := TGet():New( 028,254,{|u| If(PCount()>0,nVlrImp:=u,nVlrImp)},oGrp2,060,008,'@E 9,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrImp",,)
oGet5      := TGet():New( 028,324,{|u| If(PCount()>0,nVlrpagto:=u,nVlrpagto)},oGrp2,060,008,'@E 9,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrpagto",,)
oGrp3      := TGroup():New( 065,005,148,392,"Historicos de Liberações  ",oGrp1,CLR_BLUE,CLR_WHITE,.T.,.F. )
oSay6      := TSay():New( 073,013,{||"Quantidad de Titulos "},oGrp3,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,056,008)
oSay7      := TSay():New( 073,177,{||"Valor Total das Comissões "},oGrp3,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,056,008)
oSay8      := TSay():New( 073,077,{||"Quantidade Vidas Comissionadas "},oGrp3,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,088,008)
oSay9      := TSay():New( 073,257,{||"Valor Total dos Tributos"},oGrp3,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,088,008)
oSay10     := TSay():New( 074,334,{||"Valor Total à Pagar "},oGrp3,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,056,008)

oSay11     := TSay():New( 081,006,{||"--------------------------------------------------------------------------------------------- Falta Visto ------------------------------------------------------------------------------------"},oGrp3,,,.F.,.F.,.F.,.T.,CLR_BLUE,CLR_WHITE,584,008)
oSay13     := TSay():New( 102,006,{||"------------------------------------------------------------------------------------------- Bloqueadados ----------------------------------------------------------------------------------"},oGrp3,,,.F.,.F.,.F.,.T.,CLR_BLUE,CLR_WHITE,584,008)
oSay17     := TSay():New( 123,006,{||"-------------------------------------------------------------------------------------- Totais da Competência -----------------------------------------------------------------------------"},oGrp3,,,.F.,.F.,.F.,.T.,CLR_BLUE,CLR_WHITE,584,008)
oSay12     := TSay():New( 148,005,{||"------------------------------------------------------------------------------------- Historicos de Liberações --------------------------------------------------------------------------"},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLUE,CLR_WHITE,584,008)

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

oGrp8      := TGroup():New( 155,268,221,392,"Titulos Liberados e Pagos",oGrp1,CLR_BLUE,CLR_WHITE,.T.,.F. )
oSay26     := TSay():New( 163,276,{||"Quantidade de Titulos "},oGrp8,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,056,008)
oSay27     := TSay():New( 175,276,{||"Quantidade de Vidas "},oGrp8,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,056,008)
oSay28     := TSay():New( 187,276,{||"Total dos Titulos "},oGrp8,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,056,008)
oSay29     := TSay():New( 198,276,{||"Valor dos Impostos "},oGrp8,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,056,008)
oSay30     := TSay():New( 210,276,{||"Total Pago "},oGrp8,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,056,008)
oGet31     := TGet():New( 161,332,{|u| If(PCount()>0,nQtdaTitG :=u,nQtdaTitG )},oGrp8,056,008,'@E 999,999',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nQtdaTitG ",,)
oGet32     := TGet():New( 173,332,{|u| If(PCount()>0,nQtdaVidaG:=u,nQtdaVidaG)},oGrp8,056,008,'@E 999,999',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nQtdaVidaG",,)
oGet33     := TGet():New( 185,332,{|u| If(PCount()>0,nVlrtitiG:=u,nVlrtitiG)},oGrp8,056,008,'@E 99,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrtitiG",,)
oGet34     := TGet():New( 197,332,{|u| If(PCount()>0,nVlrImpG:=u,nVlrImpG)},oGrp8,056,008,'@E 99,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrImpG",,)
oGet35     := TGet():New( 209,332,{|u| If(PCount()>0,nVlrpagtoG:=u,nVlrpagtoG)},oGrp8,056,008,'@E 99,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrpagtoG",,)
oGrp7      := TGroup():New( 155,138,221,262,"Titulos Liberados Não Pagos ",oGrp1,CLR_BLUE,CLR_WHITE,.T.,.F. )
oSay15     := TSay():New( 164,146,{||"Quantidade de Titulos "},oGrp7,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,056,008)
oSay22     := TSay():New( 175,146,{||"Quantidade de Vidas "},oGrp7,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,056,008)
oSay23     := TSay():New( 187,146,{||"Total dos Titulos "},oGrp7,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,056,008)
oSay24     := TSay():New( 198,146,{||"Valor dos Impostos "},oGrp7,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,056,008)
oSay25     := TSay():New( 210,146,{||"Total Pago "},oGrp7,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,056,008)
oGet26     := TGet():New( 161,202,{|u| If(PCount()>0,nQtdaTitnG:=u,nQtdaTitnG)},oGrp7,056,008,'@E 999,999',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nQtdaTitnG",,)
oGet27     := TGet():New( 173,202,{|u| If(PCount()>0,nQtdaVidNG:=u,nQtdaVidNG)},oGrp7,056,008,'@E 999,999',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nQtdaVidNG",,)
oGet28     := TGet():New( 185,202,{|u| If(PCount()>0,nVlrtitiNG:=u,nVlrtitiNG)},oGrp7,056,008,'@E 99,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrtitiNG",,)
oGet29     := TGet():New( 197,202,{|u| If(PCount()>0,nVlrImpNG :=u,nVlrImpNG )},oGrp7,056,008,'@E 99,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrImpNG ",,)
oGet30     := TGet():New( 209,202,{|u| If(PCount()>0,nVlrpagtNG :=u,nVlrpagtNG )},oGrp7,056,008,'@E 99,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrpagtNG ",,)
oGrp6      := TGroup():New( 155,004,221,132,"Titulos Não Liberados ",oGrp1,CLR_BLUE,CLR_WHITE,.T.,.F. )
oSay16     := TSay():New( 164,012,{||"Quantidade de Titulos "},oGrp6,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,056,008)
oSay18     := TSay():New( 175,012,{||"Quantidade de Vidas "},oGrp6,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,056,008)
oSay19     := TSay():New( 187,012,{||"Total dos Titulos "},oGrp6,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,056,008)
oSay20     := TSay():New( 198,012,{||"Valor dos Impostos "},oGrp6,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,056,008)
oSay21     := TSay():New( 210,012,{||"Total Pago "},oGrp6,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,056,008)
oGet16     := TGet():New( 161,068,{|u| If(PCount()>0,nQtdaTitnL:=u,nQtdaTitnL)},oGrp6,056,008,'@E 999,999',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nQtdaTitnL",,)
oGet17     := TGet():New( 173,068,{|u| If(PCount()>0,nQtdaVidNL:=u,nQtdaVidNL)},oGrp6,056,008,'@E 999,999',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nQtdaVidNL",,)
oGet18     := TGet():New( 185,068,{|u| If(PCount()>0,nVlrtitiNL:=u,nVlrtitiNL)},oGrp6,056,008,'@E 99,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrtitiNL",,)
oGet19     := TGet():New( 197,068,{|u| If(PCount()>0,nVlrImpNL:=u,nVlrImpNL)},oGrp6,056,008,'@E 99,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrImpNL",,)
oGet20     := TGet():New( 209,068,{|u| If(PCount()>0,nVlrpagtNL:=u,nVlrpagtNL)},oGrp6,056,008,'@E 99,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrpagtNL",,)

oGrp4      := TGroup():New( 224,006,296,132,"Valores Faturados",oGrp1,CLR_BLUE,CLR_WHITE,.T.,.F. )
oSay38     := TSay():New( 236,010,{||"Incide Comissão"},oGrp4,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,040,008)
oSay39     := TSay():New( 256,010,{||"Nâo Incide Comissão"},oGrp4,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,051,008)
oSay40     := TSay():New( 276,010,{||"Total Faturamento"},oGrp4,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,051,008)
oGet48     := TGet():New( 236,064,{|u| If(PCount()>0,cIncCom:=u,cIncCom)},oGrp4,046,008,'@E 99,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cIncCom",,)
oGet49     := TGet():New( 255,064,{|u| If(PCount()>0,cNIncCom:=u,cNIncCom)},oGrp4,046,008,'@E 99,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cNIncCom",,)
oGet50     := TGet():New( 274,064,{|u| If(PCount()>0,cTotFat:=u,cTotFat)},oGrp4,046,008,'@E 99,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cTotFat",,)

oGrp5      := TGroup():New( 224,235,296,392,"Valor Comissão Para Autorização de Pagto",oGrp1,CLR_BLUE,CLR_WHITE,.T.,.F. )
oSay48     := TSay():New( 234,263,{||"Valor Comissão"},oGrp5,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,040,008)
oSay49     := TSay():New( 234,320,{||"Valor Base"},oGrp5,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,027,008)
oSay50     := TSay():New( 234,356,{||"Perc. Médio "},oGrp5,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,031,008)
oSay51     := TSay():New( 247,247,{||"A "},oGrp5,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,008,008)
oSay52     := TSay():New( 260,247,{||"R"},oGrp5,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,008,008)
oSay53     := TSay():New( 272,247,{||"V "},oGrp5,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,008,008)
oSay54     := TSay():New( 285,239,{||"Total"},oGrp5,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,016,008)
oGet56     := TGet():New( 245,259,{|u| If(PCount()>0,nVlrComA:=u,nVlrComA)},oGrp5,040,008,'@E 99,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrComA",,)
oGet57     := TGet():New( 258,259,{|u| If(PCount()>0,nVlrComR:=u,nVlrComR)},oGrp5,040,008,'@E 99,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrComR",,)
oGet58     := TGet():New( 270,259,{|u| If(PCount()>0,nVlrComV:=u,nVlrComV)},oGrp5,040,008,'@E 99,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrComV",,)
oGet59     := TGet():New( 283,259,{|u| If(PCount()>0,nVlrComT:=u,nVlrComT)},oGrp5,040,008,'@E 99,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrComT",,)
oGet60     := TGet():New( 283,307,{|u| If(PCount()>0,nVlrBasT:=u,nVlrBasT)},oGrp5,041,008,'@E 99,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrBasT",,)
oGet61     := TGet():New( 270,307,{|u| If(PCount()>0,nVlrBasV:=u,nVlrBasV)},oGrp5,041,008,'@E 99,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrBasV",,)
oGet62     := TGet():New( 258,307,{|u| If(PCount()>0,nVlrBasR:=u,nVlrBasR)},oGrp5,041,008,'@E 99,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrBasR",,)
oGet63     := TGet():New( 245,307,{|u| If(PCount()>0,nVlrBasA:=u,nVlrBasA)},oGrp5,041,008,'@E 99,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrBasA",,)
oGet64     := TGet():New( 283,355,{|u| If(PCount()>0,nVlrMedT:=u,nVlrMedT)},oGrp5,029,008,'@E 9,999.99%',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrMedT",,)
oGet65     := TGet():New( 270,355,{|u| If(PCount()>0,nVlrMedV:=u,nVlrMedV)},oGrp5,029,008,'@E 9,999.99%',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrMedV",,)
oGet66     := TGet():New( 258,355,{|u| If(PCount()>0,nVlrMedR:=u,nVlrMedR)},oGrp5,029,008,'@E 9,999.99%',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrMedR",,)
oGet67     := TGet():New( 245,355,{|u| If(PCount()>0,nVlrMedA:=u,nVlrMedA)},oGrp5,029,008,'@E 9,999.99%',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrMedA",,)

oGrp9      := TGroup():New( 224,136,296,232,"Valor Comissão",oGrp1,CLR_BLUE,CLR_WHITE,.T.,.F. )
oSay45     := TSay():New( 229,184,{||"Valor Comissão"},oGrp9,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,044,008)
oSay46     := TSay():New( 275,141,{||"Total"},oGrp9,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,016,008)
oSay47     := TSay():New( 264,140,{||"Vitalício(V)"},oGrp9,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,041,008)
oSay65     := TSay():New( 252,140,{||"Recuperação(R)"},oGrp9,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,041,008)
oSay66     := TSay():New( 240,140,{||"Agenciamento(A)"},oGrp9,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,043,008)
oSay67     := TSay():New( 287,141,{||"Perc. Médio"},oGrp9,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,034,008)
oGet54     := TGet():New( 272,185,{|u| If(PCount()>0,nVlrTotT:=u,nVlrTotT)},oGrp9,040,008,'@E 99,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrTotT",,)
oGet55     := TGet():New( 260,185,{|u| If(PCount()>0,nVlrTotV:=u,nVlrTotV)},oGrp9,040,008,'@E 99,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrTotV",,)
oGet76     := TGet():New( 249,185,{|u| If(PCount()>0,nVlrTotR:=u,nVlrTotR)},oGrp9,040,008,'@E 99,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrTotR",,)
oGet77     := TGet():New( 238,185,{|u| If(PCount()>0,nVlrTotA:=u,nVlrTotA)},oGrp9,040,008,'@E 99,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrTotA",,)
oGet78     := TGet():New( 284,185,{|u| If(PCount()>0,nPecMedT:=u,nPecMedT)},oGrp9,040,008,'@E 9,999.99%',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nPecMedT",,)

oBtn1:SetFocus()

  //   If  ApMsgYesNo("Desenja Caregar Dados Estatisticos, Esta operação levar alguns minutos . Deseja proseguir excluir","SIMNAO")
       
  //      fRodape()

  //	EndIf

  	If ( _UserLog != _cIdUsuar  .and. _UserLog != _cIdUsr1  .and. _UserLog != _cIdUsr2) .or.  Mv_par03 == 2 .or. nQtdaTit == 0 
  		oBtn1:DISABLE()  
  	EndIf

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
cQuery += CRLF+ "   AND BXQ_CODVEN NOT in ('000174','000172','000171','000191','000177','000215' )"
  
cQuery += CRLF+ "   and BXQ_REFERE = BXQ_PAGCOM "
cQuery += CRLF+ "   and E2_FORNECE = BXQ_E2FORN "  
cQuery += CRLF+ "   and E2_PREFIXO = BXQ_E2PREF "
cQuery += CRLF+ "   and E2_YLTITC <> '2' "
   
cQuery += CRLF+ "   and E2_NUM     = BXQ_E2NUM "
cQuery += CRLF+ "   and E2_PARCELA = BXQ_E2PARC "
cQuery += CRLF+ "   and E2_TIPO    = BXQ_E2TIPO "
cQuery += CRLF+ "   and E2_LOJA    = BXQ_E2LOJA "

///////////////////////////altamiro 
cQuery += CRLF+ "   AND E2_FORNECE ='INPWJ3' "

If  Mv_par03 == 1 

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

EndIf 

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
///////////////////////////altamiro 
cQuery += CRLF+ "   AND E2_FORNECE ='INPWJ3' "

If  Mv_par03 == 1 

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

EndIf 

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
///////////////////////////altamiro 
cQuery += CRLF+ "   AND E2_FORNECE ='INPWJ3' "

If  Mv_par03 == 1 
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
EndIF 

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

	cTitulos1 := FormatIn(trim(cTitulos) ,"|")

///// consultas as liberadas e pagas e nao pagas 

cQuery3 := CRLF+ " Select Sum(Nvl(Bxq.Totvda,0)) Totvda , "
cQuery3 += CRLF+ "        Sum(Nvl(Bxq.Bascom,0)) Bascom , "
cQuery3 += CRLF+ "        Sum(Nvl(Bxq.Vlrcom,0)) Vlrcom , " 
cQuery3 += CRLF+ "        Sum(Nvl(Se2.Qtdtit,0)) Tqtdtit , "
cQuery3 += CRLF+ "        Sum(Nvl(Se2.Saldo,0))  Tsaldo , "
cQuery3 += CRLF+ "        Sum(Nvl(Se2.Valor,0))  Tvalor , "
cQuery3 += CRLF+ "        Sum(Nvl(Se2.Irrf,0))   Tirrf , "
cQuery3 += CRLF+ "        Sum(Nvl(Se2.Inss,0))   Tinss , "
cQuery3 += CRLF+ "        Sum(Nvl(Se2.Pis,0))    Tpis , "
cQuery3 += CRLF+ "        Sum(Nvl(Se2.Csll,0))   Tcsll , "
cQuery3 += CRLF+ "        Sum(Nvl(Se2.Cofins,0)) TCofins , "
cQuery3 += CRLF+ "        Sum(Nvl(Se2.Iss,0))     TIss , "
cQuery3 += CRLF+ "        Decode (trim(Se2.Titlib), null,'Lib' , 2, 'Bloq' , 'Lib') Titlib , "
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
cQuery3 += CRLF+ "  ) Bxq , "
//cQuery3 += CRLF+ "   Order By Bxq_Codemp ) Bxq , "
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
///////////////////////////altamiro 
cQuery += CRLF+ "   AND E2_FORNECE ='INPWJ3' "

cQuery3 += CRLF+ "   Group By E2_Prefixo ,E2_Num , E2_Parcela ,E2_Tipo , E2_Fornece , E2_Baixa ,E2_Yltitc ) Se2 , "
  // Aprovação  
cQuery3 += CRLF+ " ( Select Pdt_Prefix , Pdt_Num , Pdt_Parcel , Pdt_Tipo , Pdt_Fornec , "
cQuery3 += CRLF+ "          Pdt_Aprov  Aprovador "
cQuery3 += CRLF+ "      FROM siga."+RetSQLName("PDT")+" PDT  "
cQuery3 += CRLF+ "    WHERE PDT_FILIAL = '" + xFilial('PDT') + "' "
cQuery3 += CRLF+ "      And D_E_L_E_T_ = ' ' "
cQuery3 += CRLF+ "      And Pdt_Aprov(+)  = '000047' "
//cQuery3 += CRLF+ "    Order By Pdt_Prefix , Pdt_Num , Pdt_Parcel , Pdt_Tipo , Pdt_Fornec) Pdt1 , "
cQuery3 += CRLF+ " ) Pdt1 , "
  // Visto
cQuery3 += CRLF+ " ( Select Pdt_Prefix , Pdt_Num , Pdt_Parcel , Pdt_Tipo , Pdt_Fornec , "
cQuery3 += CRLF+ "          Pdt_Aprov  Vistador "
cQuery3 += CRLF+ "     FROM siga."+RetSQLName("PDT")+" PDT  "
cQuery3 += CRLF+ "    WHERE PDT_FILIAL = '" + xFilial('PDT') + "' " 
cQuery3 += CRLF+ "      And D_E_L_E_T_ = ' ' "
cQuery3 += CRLF+ "      And Pdt_Aprov(+)  = '001495' "
//cQuery3 += CRLF+ "    Order By Pdt_Prefix , Pdt_Num , Pdt_Parcel , Pdt_Tipo , Pdt_Fornec ) Pdt2 "   
cQuery3 += CRLF+ " ) Pdt2 "   
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
cQuery3 += CRLF+ " Group By Decode (trim(Se2.Titlib), null,'Lib' , 2, 'Bloq' , 'Lib') , " 
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

nQtdaTitNL  := 0
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
        nVlrtitiT  += (cAliastmp3)->TVALOR +;
                      (cAliastmp3)->TIRRF  + ;
                      (cAliastmp3)->TINSS  + ;
                      (cAliastmp3)->TISS   + ;
                      (cAliastmp3)->TPIS   + ;
                      (cAliastmp3)->TCSLL  + ;
                      (cAliastmp3)->TCOFINS   
        nQtdaVidaT += (cAliastmp3)->Totvda

        If (cAliastmp3)->Titlib  == 'Bloq' //.and. (cAliastmp3)->Vistado  == 'Sim'

            nQtdaTitB  += (cAliastmp3)->Tqtdtit
            nVlrImpB   +=((cAliastmp3)->TIRRF + ;
                          (cAliastmp3)->TINSS + ;
                          (cAliastmp3)->TISS  + ;
                          (cAliastmp3)->TPIS  + ;
                          (cAliastmp3)->TCSLL + ;
                          (cAliastmp3)->TCOFINS )
            nVlrpagtoB += (cAliastmp3)->TVALOR 
            nVlrtitiB  += (cAliastmp3)->TVALOR +;
                          (cAliastmp3)->TIRRF  + ;
                          (cAliastmp3)->TINSS  + ;
                          (cAliastmp3)->TISS   + ;
                          (cAliastmp3)->TPIS   + ;
                          (cAliastmp3)->TCSLL  + ;
                          (cAliastmp3)->TCOFINS   
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
            nVlrtitiV  += (cAliastmp3)->TVALOR +;
                          (cAliastmp3)->TIRRF  + ;
                          (cAliastmp3)->TINSS  + ;
                          (cAliastmp3)->TISS   + ;
                          (cAliastmp3)->TPIS   + ;
                          (cAliastmp3)->TCSLL  + ;
                          (cAliastmp3)->TCOFINS   
            nQtdaVidaV += (cAliastmp3)->Totvda


        EndIf 

    If (cAliastmp3)->Vistado  == 'Sim'
        
       // If (cano+cMes) >='202012' .and. (cAliastmp3)->LIBERADO == 'Sim' .and. (cAliastmp3)->PAGTO == 'Sim' ;
       //   .or. (cano+cMes) <'202012' .and.  (cAliastmp3)->PAGTO == 'Sim'
        If (cAliastmp3)->PAGTO == 'Sim'

            nQtdaTitG  += (cAliastmp3)->Tqtdtit
            nVlrImpG   +=((cAliastmp3)->TIRRF + ;
                          (cAliastmp3)->TINSS + ;
                          (cAliastmp3)->TISS  + ;
                          (cAliastmp3)->TPIS  + ;
                          (cAliastmp3)->TCSLL + ;
                          (cAliastmp3)->TCOFINS )
            nVlrpagtoG += (cAliastmp3)->TVALOR 
            nVlrtitiG  += (cAliastmp3)->TVALOR +;
                          (cAliastmp3)->TIRRF  + ;
                          (cAliastmp3)->TINSS  + ;
                          (cAliastmp3)->TISS   + ;
                          (cAliastmp3)->TPIS   + ;
                          (cAliastmp3)->TCSLL  + ;
                          (cAliastmp3)->TCOFINS  
            nQtdaVidaG += (cAliastmp3)->Totvda

        EndIf  

        //If (cano+cMes) >='202012' .and. (cAliastmp3)->LIBERADO == 'Sim' .and. (cAliastmp3)->PAGTO == 'Nao' ;
        //   .or. (cano+cMes) <'202012' 
        If (cAliastmp3)->LIBERADO == 'Sim' .and. (cAliastmp3)->PAGTO == 'Nao'
            nQtdaTitNG  +=  (cAliastmp3)->Tqtdtit
            nVlrImpNG   += ((cAliastmp3)->TIRRF + ;
                            (cAliastmp3)->TINSS + ;
                            (cAliastmp3)->TISS  + ;
                            (cAliastmp3)->TPIS  + ;
                            (cAliastmp3)->TCSLL + ;
                            (cAliastmp3)->TCOFINS )
            nVlrpagtNG  +=  (cAliastmp3)->TVALOR 
            nVlrtitiNG  +=  (cAliastmp3)->TVALOR + ; 
                            (cAliastmp3)->TIRRF  + ;
                            (cAliastmp3)->TINSS  + ;
                            (cAliastmp3)->TISS   + ;
                            (cAliastmp3)->TPIS   + ;
                            (cAliastmp3)->TCSLL  + ;
                            (cAliastmp3)->TCOFINS 
            nQtdaVidNG  +=  (cAliastmp3)->Totvda

        EndIF

        If (cAliastmp3)->LIBERADO == 'Nao' 
            nQtdaTitNL  += (cAliastmp3)->Tqtdtit
            nVlrImpNL   += ((cAliastmp3)->TIRRF + ;
                            (cAliastmp3)->TINSS + ;
                            (cAliastmp3)->TISS  + ;
                            (cAliastmp3)->TPIS  + ;
                            (cAliastmp3)->TCSLL + ;
                            (cAliastmp3)->TCOFINS )
            nVlrpagtNL  += (cAliastmp3)->TVALOR 
            nVlrtitiNL  += (cAliastmp3)->TVALOR + ;
                           (cAliastmp3)->TIRRF  + ;
                           (cAliastmp3)->TINSS  + ;
                           (cAliastmp3)->TISS   + ;
                           (cAliastmp3)->TPIS   + ;
                           (cAliastmp3)->TCSLL  + ;
                           (cAliastmp3)->TCOFINS 
            nQtdaVidNL  += (cAliastmp3)->Totvda

        EndIF

    EndIf       
    				
       (cAliastmp3)->(DbSkip())
	
	Enddo

Return (ret)

Static Function fAutor()

        Processa({||Processa2()},"Fazendo Liberação (Aprovações)  ", "Aguarde ....", .T.)   

Return()

Static Function Processa2()

oBtn1:disable()
oBtn2:disable()
oBtn3:disable()
oBtn4:disable()

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

        fConsulta()

        MsgAlert("Todas os titulos de comissõs foram Liberados para pagamento !!","Atencao!")

        oBtn1:ENABLE()
        oBtn2:ENABLE()
        oBtn3:ENABLE()
        oBtn4:ENABLE()
Return()

static function fDemonst()

    Processa({||Processa3()},"Buscando dados no servido (Demonstrações)  ", "Aguarde ....", .T.) 

Return()

Static Function Processa3()

    nPgto1:=0 

    nPgto1:= u_CABA182( 1 , trim(ctitulos) , Trim(ctitulos1) , cAno , cMes, Mv_par03, mv_par04 , mv_par05 )

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


static function fRodape()

 Processa({||Processa4()},"Buscando dados no servido (Estatistica)  ", "Aguarde ....", .T.)   

Return()

Static Function Processa4()

Local cQuery99 := ' ' 
Local cQuery88 := ' ' 

local cAVlCom    := 0.00
local cRVlCom    := 0.00
local cVVlCom    := 0.00
local cTotvlCom  := 0.00

local cAVlBas    := 0.00
local cRVlBas    := 0.00
local cVVlBas    := 0.00
local cTotvlBas  := 0.00

local cAVlMed    := 0.00
local cRVlMed    := 0.00
local cVVlMed    := 0.00
local cTotvlMed  := 0.00

local cAVlTot    := 0.00
local cRVlTot    := 0.00
local cVVlTot    := 0.00
local cTotvlTot  := 0.00

cQuery88 :=       "       SELECT BM1_ANO||BM1_MES MES_ANO , "
cQuery88 += CRLF+ "              decode(BFQ_COMISS,'1',decode(c,1,'Incide Comissão','Não Incide Comissão'),'Não Incide Comissão') tipo , "
cQuery88 += CRLF+ "              Sum(Decode(BM1_CODTIP,101,BM1_VALOR,0))+Sum(Decode(BM1_CODTIP,101,0,Decode(BM1_TIPO,1,BM1_VALOR,0)))-Sum(Decode(BM1_TIPO,2,BM1_VALOR,0))TOTAL "
cQuery88 += CRLF+ "         FROM "+ RetSqlName("BM1") + " D, "+ RetSqlName("SE1") + " SE1, "+ RetSqlName("BFQ") + " BFQ , "
cQuery88 += CRLF+ "              (select sign(count(*)) c,bxq_codemp "
cQuery88 += CRLF+ "                 from "+ RetSqlName("BXQ") + " BXQ "  
cQuery88 += CRLF+ "                where bxq_filial= '"+xFilial('BXQ')+ "' " 

cQuery88 += CRLF+ "                  and bxq_ano = '"+cAno+"' "
cQuery88 += CRLF+ "                  and bxq_mes = '"+cMes+"' "
cQuery88 += CRLF+ "                  and d_e_l_e_t_=' ' "
cQuery88 += CRLF+ "                group by bxq_ano, bxq_mes,bxq_codemp) "
cQuery88 += CRLF+ "        WHERE BM1_FILIAL= '"+xFilial('BM1')+ "' "   
cQuery88 += CRLF+ "          AND BFQ_FILIAL= '"+xFilial('BFQ')+ "' " 
cQuery88 += CRLF+ "          AND E1_FILIAL = '"+xFilial('SE1')+ "'  "
cQuery88 += CRLF+ "          AND E1_PREFIXO= BM1_PREFIX "
cQuery88 += CRLF+ "          AND E1_NUM=BM1_NUMTIT "
cQuery88 += CRLF+ "          AND E1_PARCELA=BM1_PARCEL "
cQuery88 += CRLF+ "          and E1_TIPO=BM1_TIPTIT "
cQuery88 += CRLF+ "          AND BM1_CODTIP=BFQ_PROPRI||BFQ_CODLAN "
cQuery88 += CRLF+ "          and bxq_codemp(+)=bm1_codemp "
cQuery88 += CRLF+ "          and BM1_ANO= '"+cAno+"' "
cQuery88 += CRLF+ "          and BM1_MES='"+cMes+"'  "
cQuery88 += CRLF+ "          AND D.D_E_L_E_T_   <> '*' "
cQuery88 += CRLF+ "          AND SE1.D_E_L_E_T_ <> '*' "
cQuery88 += CRLF+ "          AND BFQ.D_E_L_E_T_ <> '*'  " 
cQuery88 += CRLF+ "          AND BM1_PREFIX<>'RLE'    "
cQuery88 += CRLF+ "          AND bm1_codtip <> '111' "
cQuery88 += CRLF+ "          AND BM1_VALOR <> 0 "
cQuery88 += CRLF+ "          GROUP BY BM1_ANO||BM1_MES , "
cQuery88 += CRLF+ "          decode(BFQ_COMISS,'1',decode(c,1,'Incide Comissão','Não Incide Comissão'),'Não Incide Comissão') "

If Select((cAliastmp6)) <> 0 
   (cAliastmp6)->(DbCloseArea())  
Endif                          

TCQuery cQuery88 New Alias (cAliastmp6)   

(cAliastmp6)->( DbGoTop() )  

    While !(cAliastmp6)->(Eof())
        
        If (cAliastmp6)->tipo $('Não Incide Comissão') 
            cNIncCom +=(cAliastmp6)->TOTAL    
        Else 
            cIncCom  +=(cAliastmp6)->TOTAL
        EndIf       
        
        (cAliastmp6)->(DbSkip())
	Enddo		
/*
cQuery99 :=  "         SELECT SUM(VLRCOM) OVER (PARTITION BY  CORRETORA,TITULO,perc,TP) VLRCOM , "
cQuery99 += CRLF+ "           SUM(VALBASE) OVER (PARTITION BY  CORRETORA,TITULO,perc,TP) VALBASE ,TP TP" 
*/
cQuery99 :=  "         SELECT SUM(VLRCOM) OVER (PARTITION BY  CORRETORA,TITULO,perc,TP) VLRCOM , "
//cQuery99 += CRLF+ "           SUM(VLRCOM) OVER (PARTITION BY  CORRETORA,TITULO,perc,TP) VLRCOM , "
cQuery99 += CRLF+ "           VLRTIT ,   "
cQuery99 += CRLF+ "           IMPOSTOS , "
cQuery99 += CRLF+ "           SUM(VALBASE) OVER (PARTITION BY  EMPRESA,CORRETORA) VALBASEtot , "
cQuery99 += CRLF+ "           SUM(VALBASE) OVER (PARTITION BY  CORRETORA,TITULO,perc,TP) VALBASE , "
//cQuery99 += CRLF+ "           sum(VIDAS_COMISSAO ) OVER (PARTITION BY  CORRETORA,TITULO,perc,TP)VIDAS_COMISSAO , "
cQuery99 += CRLF+ "           TP , " 

cQuery99 += CRLF+ "           SALDO , "  

If  cEmpant =='02'
    cQuery99 += CRLF+ "           RETORNA_VALOR_FATURA_EMP ('"+cMes+"','"+cAno+"','2') FATURA "
Else 
    cQuery99 += CRLF+ "           RETORNA_VALOR_FATURA_EMP ('"+cMes+"','"+cAno+"','1') FATURA "
EndIF                                                              
cQuery99 += CRLF+ "   FROM( "    
cQuery99 += CRLF+ "         select "
cQuery99 += CRLF+ "                BXQ_ANO||BXQ_MES REF , "
cQuery99 += CRLF+ "                BXQ_CODEMP EMPRESA , "

cQuery99 += CRLF+ "                BXQ_PERCOM PERC , "
cQuery99 += CRLF+ "                BXQ_E2FORN ||' - '||TRIM(DECODE(BXQ_E2FORN,'125276','GESTORES CABERJ', E2_NOMFOR)) CORRETORA , " 
cQuery99 += CRLF+ "                BXQ_E2PREF||BXQ_E2NUM || BXQ_E2PARC||BXQ_E2TIPO TITULO , "
cQuery99 += CRLF+ "                SUM(BXQ_VLRCOM) VLRCOM ,"
cQuery99 += CRLF+ "                Sum(BXQ_BASCOM) VALBASE , "
cQuery99 += CRLF+ "                (NVL( E2_IRRF,0) + NVL( E2_ISS,0) + NVL( E2_VRETPIS,0) + NVL( E2_VRETCOF,0) +NVL( E2_VRETCSL,0)) IMPOSTOS , " 
cQuery99 += CRLF+ "                NVL( E2_VALOR,0) VLRTIT , "                                       
cQuery99 += CRLF+ "                NVL(E2_SALDO,0) SALDO , "
cQuery99 += CRLF+ "                NVL((SUBSTR(E2_BAIXA,7,2)||'/'||SUBSTR(E2_BAIXA,5,2)||'/'||SUBSTR(E2_BAIXA,1,4)),'') BAIXA , "
//cQuery99 += CRLF+ "                Count (DISTINCT BXQ_CODEMP||BXQ_MATRIC||BXQ_TIPREG||BXQ_DIGITO)  VIDAS_COMISSAO , "
cQuery99 += CRLF+ "                BXQ_CODVEN , "

If  cEmpant =='02'
//    cQuery99 += CRLF+ "                RETORNA_SINISTRAL_EMP_MS_CAB('I','S','01/"+cMes+"/"+cAno+"','01/"+cMes+"/"+cAno+"',BXQ_CODEMP,null) SINISTRALIDADE , "
    cQuery99 += CRLF+ "                RETORNA_TIPO_COMISSAO ( 'I', BXQ_CODEMP, BXQ_PERCOM,BXQ_SEQBXO,BXQ_NUMPAR ) TP ,"
//    cQuery99 += CRLF+ "                RETORNA_DESCRI_GRUPOEMP ( 'I', BXQ_CODEMP) DESC_EMPRESA , "
Else 
//    cQuery99 += CRLF+ "                RETORNA_SINISTRAL_EMP_MS_CAB('C','S','01/"+cMes+"/"+cAno+"','01/"+cMes+"/"+cAno+"',BXQ_CODEMP,null) SINISTRALIDADE , "
    cQuery99 += CRLF+ "                RETORNA_TIPO_COMISSAO ( 'C', BXQ_CODEMP, BXQ_PERCOM,BXQ_SEQBXO,BXQ_NUMPAR ) TP ,"
//    cQuery99 += CRLF+ "                RETORNA_DESCRI_GRUPOEMP ( 'C', BXQ_CODEMP) DESC_EMPRESA , "
EndIf 

cQuery99 += CRLF+ "                E2_YLTITC,E2_YNAPRO,E2_MTBLCM,E2_LGBLCM  "
cQuery99 += CRLF+ "    From " + RetSqlName("SE2") + " SE2 , "+ RetSqlName("BXQ") + " BXQ "  
// cQuery99 += CRLF+ "           from SE2020 SE2 , BXQ020 BXQ "
cQuery99 += CRLF+ "          where BXQ_FILIAL = ' ' "
cQuery99 += CRLF+ "            and BXQ.D_E_L_E_T_ = ' ' " 
cQuery99 += CRLF+ "            and E2_FILIAL = '01' "
cQuery99 += CRLF+ "            and SE2.D_E_L_E_T_= ' ' " 

cQuery99 += CRLF+ "            and BXQ_ANO    = '"+cAno+"'"
cQuery99 += CRLF+ "            AND BXQ_MES    = '"+cMes+"' "

cQuery99 += CRLF+ "            and E2_PREFIXO = 'COM' "      
cQuery99 += CRLF+ "            and E2_TIpo   <>'NDF' "
cQuery99 += CRLF+ "            AND BXQ_CODVEN NOT IN ('000174','000172','000171','000191','000177','000215' )"
//cQuery99 += CRLF+ "            AND E2_SALDO > 0 "
cQuery99 += CRLF+ "            AND TRIM(BXQ_E2FORN)=TRIM(BXQ_E2FORN) "
cQuery99 += CRLF+ "            and BXQ_REFERE = BXQ_PAGCOM  "
cQuery99 += CRLF+ "            and E2_FORNECE = BXQ_E2FORN  "  
cQuery99 += CRLF+ "            and E2_PREFIXO = BXQ_E2PREF  "

cQuery99 += CRLF+ "            AND NVL( "
cQuery99 += CRLF+ "       ( SELECT COUNT(*) QTDA " 

cQuery99 += CRLF+ "    From " + RetSqlName("PDT") + " PDT " 

cQuery99 += CRLF+ "          WHERE PDT_FILIAL = '01' " 

cQuery99 += CRLF+ "            AND D_E_L_E_T_ = ' ' "
cQuery99 += CRLF+ "            AND PDT_PREFIX = SE2.E2_PREFIXO " 
cQuery99 += CRLF+ "            AND PDT_NUM    = SE2.E2_NUM  "
cQuery99 += CRLF+ "            AND PDT_PARCEL = SE2.E2_PARCELA " 
cQuery99 += CRLF+ "            AND PDT_TIPO   = SE2.E2_TIPO  "
cQuery99 += CRLF+ "            AND PDT_FORNEC = SE2.E2_FORNECE " 
cQuery99 += CRLF+ "            AND PDT_APROV  = '001495'),0) > 0 "

cQuery99 += CRLF+ "            and E2_NUM     = BXQ_E2NUM  "
cQuery99 += CRLF+ "            and E2_PARCELA = BXQ_E2PARC "
cQuery99 += CRLF+ "            and E2_TIPO    = BXQ_E2TIPO "
cQuery99 += CRLF+ "            and E2_LOJA    = BXQ_E2LOJA "
cQuery99 += CRLF+ "       group by BXQ_ANO||BXQ_MES , BXQ_PERCOM, BXQ_CODEMP , "
cQuery99 += CRLF+ "                BXQ_E2FORN ||' - '||TRIM(DECODE(BXQ_E2FORN,'125276','GESTORES CABERJ', E2_NOMFOR)) , "
cQuery99 += CRLF+ "                BXQ_E2PREF||BXQ_E2NUM || BXQ_E2PARC||BXQ_E2TIPO , NVL(E2_VALOR,0) , "
cQuery99 += CRLF+ "                NVL( E2_IRRF,0) , NVL( E2_ISS,0) , NVL( E2_VRETPIS,0), NVL( E2_VRETCOF,0),NVL( E2_VRETCSL,0) , "
cQuery99 += CRLF+ "                NVL(E2_SALDO,0) , NVL((SUBSTR(E2_BAIXA,7,2)||'/'||SUBSTR(E2_BAIXA,5,2)||'/'||SUBSTR(E2_BAIXA,1,4)),'') , "
cQuery99 += CRLF+ "                BXQ_CODVEN, E2_YLTITC,E2_YNAPRO,E2_MTBLCM,E2_LGBLCM , "

If cEmpant =='02'
   cQuery99 += CRLF+ "                RETORNA_TIPO_COMISSAO ( 'I', BXQ_CODEMP, BXQ_PERCOM,BXQ_SEQBXO,BXQ_NUMPAR ) "
ElseIf cEmpant =='01'   
   cQuery99 += CRLF+ "                RETORNA_TIPO_COMISSAO ( 'C', BXQ_CODEMP, BXQ_PERCOM,BXQ_SEQBXO,BXQ_NUMPAR ) "
EndIF    

//cQuery99 += CRLF+ "       order by 4,3,1,2 )"
cQuery99 += CRLF+ " )"
If Select((cAliastmp5)) <> 0 
   (cAliastmp5)->(DbCloseArea())  
Endif                          

TCQuery cQuery99 New Alias (cAliastmp5)   

(cAliastmp5)->( DbGoTop() )  

    While !(cAliastmp5)->(Eof())

        If alltrim((cAliastmp5)->Tp) == 'A'
            
            If (cAliastmp5)->Saldo > 0
                cAVlCom    += (cAliastmp5)->VLRCOM
                cAVlBas    += (cAliastmp5)->VALBASE       
            EndIf 

            cAVlTot += (cAliastmp5)->VLRCOM

        ElseIf alltrim((cAliastmp5)->Tp) == 'R' 
            
            If (cAliastmp5)->Saldo > 0
                cRVlCom    += (cAliastmp5)->VLRCOM
                cRVlBas    += (cAliastmp5)->VALBASE        
            EndIf 
            cRVlTot += (cAliastmp5)->VLRCOM
        
        ElseIf alltrim((cAliastmp5)->Tp) == 'V'

            If (cAliastmp5)->Saldo > 0
                cVVlCom    += (cAliastmp5)->VLRCOM
                cVVlbas    += (cAliastmp5)->VALBASE        
            EndIf 
    
            cVVlTot += (cAliastmp5)->VLRCOM
        
        EndIf   
    
         
        If (cAliastmp5)->Saldo > 0
            cTotVlCom    += (cAliastmp5)->VLRCOM
            cTotvlBas    += (cAliastmp5)->VALBASE
            cTotFat      := (cAliastmp5)->FATURA      
        EndIf

         cTotvlTot  += (cAliastmp5)->VLRCOM
         cTotFat    := (cAliastmp5)->FATURA

       (cAliastmp5)->(DbSkip())
	
	Enddo		
    
    cTotVlTMed := ( cTotVlTot / cTotFat  ) * 100 
    
    cAVlMed    := ( cAVlCom   / cAVlBas  ) * 100
    cVVlMed    := ( cVVlCom   / cVVlBas  ) * 100
    cRVlMed    := ( cRVlCom   / cRVlBas  ) * 100
    
 nVlrBasA   := cAVlBas
 nVlrBasR   := cRVlBas 
 nVlrBasV   := cVVlbas
 nVlrBasT   := (cAVlBas+cRVlBas+cVVlBas)

 nVlrComA   := cAVlCom
 nVlrComR   := cRVlCom
 nVlrComV   := cVVlCom
 nVlrComT   := (cAVlCom+cRVlCom+cVVlCom)

   cTotVlMed  := ( (cAVlCom+cRVlCom+cVVlCom)  / (cAVlBas+cRVlBas+cVVlbas) ) * 100

 nVlrMedA   := cAVlMed
 nVlrMedR   := cRVlMed
 nVlrMedT   := cTotVlMed
 nVlrMedV   := cVVlMed

 nVlrTotA   := cAVlTot
 nVlrTotR   := cRVlTot
 nVlrTotV   := cVVlTot
 nVlrTotT   := (cAVlTot+cRVlTot+cVVlTot)
 nPecMedT   := cTotVlTMed

Return()
