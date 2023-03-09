/*********************************** */
#Define CRLF Chr(13)+Chr(10)
#INCLUDE "PROTHEUS.ch"                                                                                                                                  
#INCLUDE "TOPCONN.ch"
#INCLUDE "PLSMGER.CH"                                                                                   
#Include "Ap5Mail.Ch"      
#Include 'Tbiconn.ch'           
#INCLUDE 'RWMAKE.CH'
#INCLUDE 'FONT.CH'
#INCLUDE 'COLORS.CH'

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³         ³ Autor ³                       ³ Data ³           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Locacao   ³                  ³Contato ³                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Aplicacao ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Analista Resp.³  Data  ³                                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³              ³  /  /  ³                                               ³±±
±±³              ³  /  /  ³                                               ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

User Function CABA202()

/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±± Declaração de cVariable dos componentes                                 ±±
Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/
Private cCCompte   := ' '
Private cEqExec   
Private cEqVend   

Private nQtdaCol   := 0
Private nVlrTot    := 0

Private _cUsuario    := SubStr(cUSUARIO,7,15)
private cDthr        := (dtos(DATE()) + "-" + Time())    

Private _cIdUsuar    := RetCodUsr() 

//Private _cIdUsuar    :='000214'
//Private _cIdUsuar    :='000081'
//Private _cIdUsuar    :='000026'

PRIVATE cAliastmp    := GetNextAlias()
PRIVATE cAliastmp1   := GetNextAlias()
PRIVATE cAliastmp2   := GetNextAlias()

PRIVATE CAPROV1      := space(8)
PRIVATE CAPROV2      := space(8)
PRIVATE CAPROV3      := space(8)

private cAproN1      := ""
private cAproN2      := ""
private cAproN3      := ""
private cAproN4      := ""


private cCompeFol    :=  dtos(DATE()) //GetNewPar("MV_COTFOL"," ")   
PRIVATE    cAno      := ' ' 
PRIVATE    cMes      := ' '

fBusAlc('909097')

   cAno         := Substr(cCompeFol,1,4) 
   cMes         := Substr(cCompeFol,5,2)

    Processa({||Processa1()},"Buscando Dados no Servidor", "Comissão Colaboradores, Guarde ....", .T.)   

    MsgInfo("Processo finalizado")

return()

Static Function Processa1()

/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±± Declaração de cVariable dos componentes                                 ±±
Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/

Private cCargExC1  := Space(1)
Private cCargExC10 := Space(1)
Private cCargExC11 := Space(1)
Private cCargExC12 := Space(1)
Private cCargExC13 := Space(1)
Private cCargExC14 := Space(1)
Private cCargExC2  := Space(1)
Private cCargExC3  := Space(1)
Private cCargExC4  := Space(1)
Private cCargExC5  := Space(1)
Private cCargExC6  := Space(1)
Private cCargExC7  := Space(1)
Private cCargExC8  := Space(1)
Private cCargExC9  := Space(1)

Private cCargInt1  := Space(1)
Private cCargInt10 := Space(1)
Private cCargInt11 := Space(1)
Private cCargInt12 := Space(1)
Private cCargInt13 := Space(1)
Private cCargInt14 := Space(1)
Private cCargInt2  := Space(1)
Private cCargInt3  := Space(1)
Private cCargInt4  := Space(1)
Private cCargInt5  := Space(1)
Private cCargInt6  := Space(1)
Private cCargInt7  := Space(1)
Private cCargInt8  := Space(1)
Private cCargInt9  := Space(1)

Private cCargVD1   := Space(1)
Private cCargVD10  := Space(1)
Private cCargVD11  := Space(1)
Private cCargVD12  := Space(1)
Private cCargVD13  := Space(1)
Private cCargVD14  := Space(1)
Private cCargVD2   := Space(1)
Private cCargVD3   := Space(1)
Private cCargVD4   := Space(1)
Private cCargVD5   := Space(1)
Private cCargVD6   := Space(1)
Private cCargVD7   := Space(1)
Private cCargVD8   := Space(1)
Private cCargVD9   := Space(1)

Private cCCompte   := Space(1)

Private cCorInt1   := Space(1)
Private cCorInt10  := Space(1)
Private cCorInt11  := Space(1)
Private cCorInt12  := Space(1)
Private cCorInt13  := Space(1)
Private cCorInt14  := Space(1)
Private cCorInt2   := Space(1)
Private cCorInt3   := Space(1)
Private cCorInt4   := Space(1)
Private cCorInt5   := Space(1)
Private cCorInt6   := Space(1)
Private cCorInt7   := Space(1)
Private cCorInt8   := Space(1)
Private cCorInt9   := Space(1)

Private cCorVDir1  := Space(1)
Private cCorVDir10 := Space(1)
Private cCorVDir11 := Space(1)
Private cCorVDir12 := Space(1)
Private cCorVDir13 := Space(1)
Private cCorVDir14 := Space(1)
Private cCorVDir2  := Space(1)
Private cCorVDir3  := Space(1)
Private cCorVDir4  := Space(1)
Private cCorVDir5  := Space(1)
Private cCorVDir6  := Space(1)
Private cCorVDir7  := Space(1)
Private cCorVDir8  := Space(1)
Private cCorVDir9  := Space(1)

Private cExecCnt1  := Space(1)
Private cExecCnt10 := Space(1)
Private cExecCnt11 := Space(1)
Private cExecCnt12 := Space(1)
Private cExecCnt13 := Space(1)
Private cExecCnt14 := Space(1)
Private cExecCnt2  := Space(1)
Private cExecCnt3  := Space(1)
Private cExecCnt4  := Space(1)
Private cExecCnt5  := Space(1)
Private cExecCnt6  := Space(1)
Private cExecCnt7  := Space(1)
Private cExecCnt8  := Space(1)
Private cExecCnt9  := Space(1)

Private cQtdaCol   := Space(1)

Private nqtdAprN2  := 0 //Space(1)
Private nqtdAprN3  := 0 //Space(1)
Private nqtdBloN2  := 0 //Space(1)
Private nqtdBloN3  := 0 //Space(1)
Private nqtdDefN2  := 0 //Space(1)
Private nqtdDefN3  := 0 //Space(1)
Private nqtdSinN2  := 0 //Space(1)
Private nqtdSinN3  := 0 //Space(1)
Private nqtdTotN2  := 0 //Space(1)
Private nqtdTotN3  := 0 //Space(1)

Private cVlrTot    := 0 //Space(1)

Private lCkCI1     := .F.
Private lCkCI2     := .F.
Private lCkCI10    := .F.
Private lCkCI11    := .F.
Private lCkCI12    := .F.
Private lCkCI13    := .F.
Private lCkCI14    := .F.
Private lCkCI3     := .F.
Private lCkCI4     := .F.
Private lCkCI5     := .F.
Private lCkCI6     := .F.
Private lCkCI7     := .F.
Private lCkCI8     := .F.
Private lCkCI9     := .F.

Private lCkEC1     := .F.
Private lCkEC10    := .F.
Private lCkEC11    := .F.
Private lCkEC12    := .F.
Private lCkEC13    := .F.
Private lCkEC14    := .F.
Private lCkEC2     := .F.
Private lCkEC3     := .F.
Private lCkEC4     := .F.
Private lCkEC5     := .F.
Private lCkEC6     := .F.
Private lCkEC7     := .F.
Private lCkEC8     := .F.
Private lCkEC9     := .F.

Private lCkVD1     := .F.
Private lCkVD10    := .F.
Private lCkVD11    := .F.
Private lCkVD12    := .F.
Private lCkVD13    := .F.
Private lCkVD14    := .F.
Private lCkVD2     := .F.
Private lCkVD3     := .F.
Private lCkVD4     := .F.
Private lCkVD5     := .F.
Private lCkVD6     := .F.
Private lCkVD7     := .F.
Private lCkVD8     := .F.
Private lCkVD9     := .F.

Private nPerAprN1  := 0
Private nPerAprN2  := 0
Private nPerAprN3  := 0

Private nPerBlqN1  := 0
Private nPerBlqN2  := 0
Private nPerBlqN3  := 0

Private nPerDefN1  := 0
Private nPerDefN2  := 0
Private nPerDefN3  := 0

Private nPerSinN1  := 0
Private nPerSinN2  := 0
Private nPerSinN3  := 0

Private nPerTotN1  := 00.00
Private nPerTotN2  := 00.00
Private nPerTotN3  := 00.00

Private nqtdAprN1  := 0
Private nqtdBloN1  := 0
Private nqtdDefN1  := 0

Private nqtdSinN1  := 0
Private nqtdTotN1  := 0
Private nVlrAprN1  := 0
Private nVlrAprN2  := 0
Private nVlrAprN3  := 0
Private nVlrBloN1  := 0
Private nVlrBloN2  := 0
Private nVlrBloN3  := 0
Private nVlrDefN1  := 0
Private nVlrDefN2  := 0
Private nVlrDefN3  := 0
Private nVlrExC1   := 0
Private nVlrExC10  := 0
Private nVlrExC11  := 0
Private nVlrExC12  := 0
Private nVlrExC13  := 0
Private nVlrExC14  := 0
Private nVlrExC2   := 0
Private nVlrExC3   := 0
Private nVlrExC4   := 0
Private nVlrExC5   := 0
Private nVlrExC6   := 0
Private nVlrExC7   := 0
Private nVlrExC8   := 0
Private nVlrExC9   := 0
Private nVlrInt1   := 0
Private nVlrInt10  := 0
Private nVlrInt11  := 0
Private nVlrInt12  := 0
Private nVlrInt13  := 0
Private nVlrInt14  := 0
Private nVlrInt2   := 0
Private nVlrInt3   := 0
Private nVlrInt4   := 0
Private nVlrInt5   := 0
Private nVlrInt6   := 0
Private nVlrInt7   := 0
Private nVlrInt8   := 0
Private nVlrInt9   := 0
Private nVlrSinN1  := 0
Private nVlrSinN2  := 0
Private nVlrSinN3  := 0
Private nVlrTotN1  := 0
Private nVlrTotN2  := 0
Private nVlrTotN3  := 0
Private nVlrVDir1  := 0
Private nVlrVDir10 := 0
Private nVlrVDir11 := 0
Private nVlrVDir12 := 0
Private nVlrVDir13 := 0
Private nVlrVDir14 := 0
Private nVlrVDir2  := 0
Private nVlrVDir3  := 0
Private nVlrVDir4  := 0
Private nVlrVDir5  := 0
Private nVlrVDir6  := 0
Private nVlrVDir7  := 0
Private nVlrVDir8  := 0
Private nVlrVDir9  := 0

///////////////////////// variaveis de trabalho 

private cMatFExc1  := Space(1)
private cMatFExc2  := Space(1)
private cMatFExc3  := Space(1)
private cMatFExc4  := Space(1)
private cMatFExc5  := Space(1)
private cMatFExc6  := Space(1)
private cMatFExc7  := Space(1)
private cMatFExc8  := Space(1)
private cMatFExc9  := Space(1)
private cMatFExc10 := Space(1)
private cMatFExc11 := Space(1)
private cMatFExc12 := Space(1)
private cMatFExc13 := Space(1)
private cMatFExc14 := Space(1)

private cMatFInt1  := Space(1)
private cMatFInt2  := Space(1)
private cMatFInt3  := Space(1)
private cMatFInt4  := Space(1)
private cMatFInt5  := Space(1)
private cMatFInt6  := Space(1)
private cMatFInt7  := Space(1)
private cMatFInt8  := Space(1)
private cMatFInt9  := Space(1)
private cMatFInt10 := Space(1)
private cMatFInt11 := Space(1)
private cMatFInt12 := Space(1)
private cMatFInt13 := Space(1)
private cMatFInt14 := Space(1)

private cMatFVD1  := Space(1)
private cMatFVD2  := Space(1)
private cMatFVD3  := Space(1)
private cMatFVD4  := Space(1)
private cMatFVD5  := Space(1)
private cMatFVD6  := Space(1)
private cMatFVD7  := Space(1)
private cMatFVD8  := Space(1)
private cMatFVD9  := Space(1)
private cMatFVD10 := Space(1)
private cMatFVD11 := Space(1)
private cMatFVD12 := Space(1)
private cMatFVD13 := Space(1)
private cMatFVD14 := Space(1)

PRIVATE cCodEqEc1 := ' ' 
PRIVATE cCodEqEc2 := ' ' 
PRIVATE cCodEqEc3 := ' ' 
PRIVATE cCodEqEc4 := ' ' 
PRIVATE cCodEqEc5 := ' ' 
PRIVATE cCodEqEc6 := ' ' 
PRIVATE cCodEqEc7 := ' ' 
PRIVATE cCodEqEc8 := ' ' 
PRIVATE cCodEqEc9 := ' ' 
PRIVATE cCodEqEc10 := ' ' 
PRIVATE cCodEqEc11 := ' ' 
PRIVATE cCodEqEc12 := ' ' 
PRIVATE cCodEqEc13 := ' ' 
PRIVATE cCodEqEc14 := ' ' 

PRIVATE cCodEqIt1 := ' ' 
PRIVATE cCodEqIt2 := ' ' 
PRIVATE cCodEqIt3 := ' ' 
PRIVATE cCodEqIt4 := ' ' 
PRIVATE cCodEqIt5 := ' ' 
PRIVATE cCodEqIt6 := ' ' 
PRIVATE cCodEqIt7 := ' ' 
PRIVATE cCodEqIt8 := ' ' 
PRIVATE cCodEqIt9 := ' ' 
PRIVATE cCodEqIt10 := ' ' 
PRIVATE cCodEqIt11 := ' ' 
PRIVATE cCodEqIt12 := ' ' 
PRIVATE cCodEqIt13 := ' ' 
PRIVATE cCodEqIt14 := ' ' 

PRIVATE cCodEqVd1 := ' ' 
PRIVATE cCodEqVd2 := ' ' 
PRIVATE cCodEqVd3 := ' ' 
PRIVATE cCodEqVd4 := ' ' 
PRIVATE cCodEqVd5 := ' ' 
PRIVATE cCodEqVd6 := ' ' 
PRIVATE cCodEqVd7 := ' ' 
PRIVATE cCodEqVd8 := ' ' 
PRIVATE cCodEqVd9 := ' ' 
PRIVATE cCodEqVd10 := ' ' 
PRIVATE cCodEqVd11 := ' ' 
PRIVATE cCodEqVd12 := ' ' 
PRIVATE cCodEqVd13 := ' ' 
PRIVATE cCodEqVd14 := ' ' 

Private IndVInt    := 0
Private IndVDir    := 0
Private IndExtC    := 0

cCCompte   := cMes+"/"+cAno

fConsulta()

/////////////////////////


/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±± Declaração de Variaveis Private dos Objetos                             ±±
Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/
SetPrvt("oDlg1","oGrp1","oSay1","oSay2","oSay3","oGet1","oGet2","oGet3","oGrp2","oBtn1","oBtn2","oBtn3")
SetPrvt("oSay4","oSay5","oSay6","oSay13","oGet4","oGet5","oGet8","oGet9","oGet10","oGet11","oGet12","oGet13")
SetPrvt("oGet15","oGet16","oGet17","oGet18","oGet19","oGet20","oGet21","oGet22","oGet23","oGet24","oGet25")
SetPrvt("oGet27","oGet28","oGet29","oGet30","oGet31","oGet32","oGet33","oGet34","oGet35","oGet36","oGet37")
SetPrvt("oGet39","oGet40","oGet41","oGet42","oGet43","oGet44","oGet45","oGet6","oGet7","oCBox1","oCBox2")
SetPrvt("oCBox4","oCBox5","oCBox6","oCBox7","oCBox8","oCBox9","oCBox10","oCBox11","oCBox12","oCBox13")
SetPrvt("oGrp4","oSay7","oSay8","oSay9","oSay14","oGet46","oGet47","oGet48","oGet49","oGet50","oGet51")
SetPrvt("oGet53","oGet54","oGet55","oGet56","oGet57","oGet58","oGet59","oGet60","oGet61","oGet62","oGet63")
SetPrvt("oGet65","oGet66","oGet67","oGet68","oGet69","oGet70","oGet71","oGet72","oGet73","oGet74","oGet75")
SetPrvt("oGet77","oGet78","oGet79","oGet80","oGet81","oGet82","oGet83","oGet84","oGet85","oGet86","oGet87")
SetPrvt("oCBox16","oCBox17","oCBox18","oCBox19","oCBox20","oCBox21","oCBox22","oCBox23","oCBox24","oCBox25")
SetPrvt("oCBox27","oCBox28","oGrp5","oSay10","oSay11","oSay12","oSay15","oGet88","oGet89","oGet90","oGet91")
SetPrvt("oGet93","oGet94","oGet95","oGet96","oGet97","oGet98","oGet99","oGet100","oGet101","oGet102")
SetPrvt("oGet104","oGet105","oGet106","oGet107","oGet108","oGet109","oGet110","oGet111","oGet112","oGet113")
SetPrvt("oGet115","oGet116","oGet117","oGet118","oGet119","oGet120","oGet121","oGet122","oGet123","oGet124")
SetPrvt("oGet126","oGet127","oGet128","oGet129","oCBox29","oCBox30","oCBox31","oCBox32","oCBox33","oCBox34")
SetPrvt("oCBox36","oCBox37","oCBox38","oCBox39","oCBox40","oCBox41","oCBox42","oGrp6","oSay16","oSay17")
SetPrvt("oSay19","oSay20","oSay21","oSay22","oSay23","oGet130","oGet131","oGet132","oGet133","oGet134")
SetPrvt("oGet136","oGet137","oGet138","oGet139","oGet140","oGet141","oGet142","oGet143","oGet144","oGrp7")
SetPrvt("oSay25","oSay26","oSay27","oSay28","oSay29","oSay30","oSay31","oGet145","oGet146","oGet147")
SetPrvt("oGet149","oGet150","oGet151","oGet152","oGet153","oGet154","oGet155","oGet156","oGet157","oGet158")
SetPrvt("oGrp8","oSay32","oSay33","oSay34","oSay35","oSay36","oSay37","oSay38","oSay39","oGet160","oGet161")
SetPrvt("oGet163","oGet164","oGet165","oGet166","oGet167","oGet168","oGet169","oGet170","oGet171","oGet172")
SetPrvt("oGet174")

/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±± Definicao do Dialog e todos os seus componentes.                        ±±
Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/
oDlg202    := MSDialog():New( 023,033,725,1318,"Aprovação de Comissões Lançamentos na Folha de pagamentos ",,,.F.,,,,,,.T.,,,.T. )
oGrp1      := TGroup():New( 000,000,036,364,"Identificação dos Lançametnos ",oDlg1,CLR_BLACK,CLR_WHITE,.T.,.F. )
oSay1      := TSay():New( 008,020,{||"Competencia de Aprovação"},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,072,008)
oSay2      := TSay():New( 008,280,{||"Valor Total"},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay3      := TSay():New( 008,152,{||"Quantidade de Colaboradores"},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,076,008)
oGet1      := TGet():New( 020,020,{|u| If(PCount()>0,cCCompte:=u,cCCompte)},oGrp1,060,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cCCompte",,)
oGet2      := TGet():New( 020,280,{|u| If(PCount()>0,nVlrTot:=u,nVlrTot)},oGrp1,060,008,'@E  999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrTot",,)
oGet3      := TGet():New( 020,152,{|u| If(PCount()>0,nQtdaCol:=u,nQtdaCol)},oGrp1,060,008,'@E  99,999',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nQtdaCol",,)
oGrp2      := TGroup():New( 000,368,036,636,"Ações ",oDlg1,CLR_BLACK,CLR_WHITE,.T.,.F. )

oBtn1      := TButton():New( 016,380,"&Aprovar",oGrp2,{||fLanca1(), oDlg202:End()},064,012,,,,.T.,,"",,,,.F. )
oBtn2      := TButton():New( 016,468,"Demonstrar",oGrp2,{||u_caba2022(1, _cIdUsuar )},064,012,,,,.T.,,"",,,,.F. )
oBtn3      := TButton():New( 016,556,"Sair",oGrp2,{||oDlg202:End()},064,012,,,,.T.,,"",,,,.F. )

oGrp3      := TGroup():New( 040,000,236,212,"Corretores Internos ",oDlg1,CLR_BLACK,CLR_WHITE,.T.,.F. )
oSay4      := TSay():New( 048,004,{||"Colaborador"},oGrp3,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,052,008)
oSay5      := TSay():New( 048,093,{||"Cargo"},oGrp3,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,052,008)
oSay6      := TSay():New( 049,156,{||"Valor "},oGrp3,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,034,008)
oSay13     := TSay():New( 048,192,{||"Selec."},oGrp3,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,016,008)
oGet4      := TGet():New( 056,004,{|u| If(PCount()>0,cCorInt1:=u,cCorInt1)},oGrp3,084,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cCorInt1",,)
oGet5      := TGet():New( 056,093,{|u| If(PCount()>0,cCargInt1:=u,cCargInt1)},oGrp3,055,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cCargInt1",,)
oGet8      := TGet():New( 068,093,{|u| If(PCount()>0,cCargInt2:=u,cCargInt2)},oGrp3,055,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cCargInt2",,)
oGet9      := TGet():New( 068,004,{|u| If(PCount()>0,cCorInt2:=u,cCorInt2)},oGrp3,084,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cCorInt2",,)
oGet10     := TGet():New( 082,154,{|u| If(PCount()>0,nVlrInt3:=u,nVlrInt3)},oGrp3,034,008,'@E  99,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrInt3",,)
oGet11     := TGet():New( 081,093,{|u| If(PCount()>0,cCargInt3:=u,cCargInt3)},oGrp3,055,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cCargInt3",,)
oGet12     := TGet():New( 081,004,{|u| If(PCount()>0,cCorInt3:=u,cCorInt3)},oGrp3,084,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cCorInt3",,)
oGet13     := TGet():New( 094,154,{|u| If(PCount()>0,nVlrInt4:=u,nVlrInt4)},oGrp3,034,008,'@E  99,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrInt4",,)
oGet14     := TGet():New( 093,093,{|u| If(PCount()>0,cCargInt4:=u,cCargInt4)},oGrp3,055,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cCargInt4",,)
oGet15     := TGet():New( 093,004,{|u| If(PCount()>0,cCorInt4:=u,cCorInt4)},oGrp3,084,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cCorInt4",,)
oGet16     := TGet():New( 107,154,{|u| If(PCount()>0,nVlrInt5:=u,nVlrInt5)},oGrp3,034,008,'@E  99,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrInt5",,)
oGet17     := TGet():New( 106,093,{|u| If(PCount()>0,cCargInt5:=u,cCargInt5)},oGrp3,055,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cCargInt5",,)
oGet18     := TGet():New( 106,004,{|u| If(PCount()>0,cCorInt5:=u,cCorInt5)},oGrp3,084,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cCorInt5",,)
oGet19     := TGet():New( 119,154,{|u| If(PCount()>0,nVlrInt6:=u,nVlrInt6)},oGrp3,034,008,'@E  99,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrInt6",,)
oGet20     := TGet():New( 118,093,{|u| If(PCount()>0,cCargInt6:=u,cCargInt6)},oGrp3,055,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cCargInt6",,)
oGet21     := TGet():New( 118,004,{|u| If(PCount()>0,cCorInt6:=u,cCorInt6)},oGrp3,084,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cCorInt6",,)
oGet22     := TGet():New( 132,154,{|u| If(PCount()>0,nVlrInt7:=u,nVlrInt7)},oGrp3,034,008,'@E  99,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrInt7",,)
oGet23     := TGet():New( 131,093,{|u| If(PCount()>0,cCargInt7:=u,cCargInt7)},oGrp3,055,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cCargInt7",,)
oGet24     := TGet():New( 131,004,{|u| If(PCount()>0,cCorInt7:=u,cCorInt7)},oGrp3,084,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cCorInt7",,)
oGet25     := TGet():New( 144,154,{|u| If(PCount()>0,nVlrInt8:=u,nVlrInt8)},oGrp3,034,008,'@E  99,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrInt8",,)
oGet26     := TGet():New( 143,093,{|u| If(PCount()>0,cCargInt8:=u,cCargInt8)},oGrp3,055,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cCargInt8",,)
oGet27     := TGet():New( 143,004,{|u| If(PCount()>0,cCorInt8:=u,cCorInt8)},oGrp3,084,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cCorInt8",,)
oGet28     := TGet():New( 157,154,{|u| If(PCount()>0,nVlrInt9:=u,nVlrInt9)},oGrp3,034,008,'@E  99,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrInt9",,)
oGet29     := TGet():New( 156,093,{|u| If(PCount()>0,cCargInt9:=u,cCargInt9)},oGrp3,055,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cCargInt9",,)
oGet30     := TGet():New( 156,004,{|u| If(PCount()>0,cCorInt9:=u,cCorInt9)},oGrp3,084,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cCorInt9",,)
oGet31     := TGet():New( 169,154,{|u| If(PCount()>0,nVlrInt10:=u,nVlrInt10)},oGrp3,034,008,'@E  99,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrInt10",,)
oGet32     := TGet():New( 182,154,{|u| If(PCount()>0,nVlrInt11:=u,nVlrInt11)},oGrp3,034,008,'@E  99,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrInt11",,)
oGet33     := TGet():New( 194,154,{|u| If(PCount()>0,nVlrInt12:=u,nVlrInt12)},oGrp3,034,008,'@E  99,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrInt12",,)
oGet34     := TGet():New( 207,154,{|u| If(PCount()>0,nVlrInt13:=u,nVlrInt13)},oGrp3,034,008,'@E  99,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrInt13",,)
oGet35     := TGet():New( 219,154,{|u| If(PCount()>0,nVlrInt14:=u,nVlrInt14)},oGrp3,034,008,'@E  99,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrInt14",,)
oGet36     := TGet():New( 218,093,{|u| If(PCount()>0,cCargInt14:=u,cCargInt14)},oGrp3,055,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cCargInt14",,)
oGet37     := TGet():New( 206,093,{|u| If(PCount()>0,cCargInt13:=u,cCargInt13)},oGrp3,055,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cCargInt13",,)
oGet38     := TGet():New( 193,093,{|u| If(PCount()>0,cCargInt12:=u,cCargInt12)},oGrp3,055,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cCargInt12",,)
oGet39     := TGet():New( 181,093,{|u| If(PCount()>0,cCargInt11:=u,cCargInt11)},oGrp3,055,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cCargInt11",,)
oGet40     := TGet():New( 168,093,{|u| If(PCount()>0,cCargInt10:=u,cCargInt10)},oGrp3,055,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cCargInt10",,)
oGet41     := TGet():New( 218,004,{|u| If(PCount()>0,cCorInt14:=u,cCorInt14)},oGrp3,084,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cCorInt14",,)
oGet42     := TGet():New( 206,004,{|u| If(PCount()>0,cCorInt13:=u,cCorInt13)},oGrp3,084,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cCorInt13",,)
oGet43     := TGet():New( 193,004,{|u| If(PCount()>0,cCorInt12:=u,cCorInt12)},oGrp3,084,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cCorInt12",,)
oGet44     := TGet():New( 181,004,{|u| If(PCount()>0,cCorInt11:=u,cCorInt11)},oGrp3,084,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cCorInt11",,)
oGet45     := TGet():New( 168,004,{|u| If(PCount()>0,cCorInt10:=u,cCorInt10)},oGrp3,084,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cCorInt10",,)
oGet6      := TGet():New( 056,154,{|u| If(PCount()>0,nVlrInt1:=u,nVlrInt1)},oGrp3,034,008,'@E  99,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrInt1",,)
oGet7      := TGet():New( 068,154,{|u| If(PCount()>0,nVlrInt2:=u,nVlrInt2)},oGrp3,034,008,'@E  99,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrInt2",,)
oCBox1     := TCheckBox():New( 056,196," ",{|u| If(PCount()>0,lCkCI1:=u,lCkCI1)},oGrp3,012,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
oCBox2     := TCheckBox():New( 068,196," ",{|u| If(PCount()>0,lCkCI2:=u,lCkCI2)},oGrp3,012,007,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
oCBox3     := TCheckBox():New( 094,196," ",{|u| If(PCount()>0,lCkCI4:=u,lCkCI4)},oGrp3,012,007,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
oCBox4     := TCheckBox():New( 082,196," ",{|u| If(PCount()>0,lCkCI3:=u,lCkCI3)},oGrp3,012,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
oCBox5     := TCheckBox():New( 144,196," ",{|u| If(PCount()>0,lCkCI8:=u,lCkCI8)},oGrp3,012,007,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
oCBox6     := TCheckBox():New( 132,196," ",{|u| If(PCount()>0,lCkCI7:=u,lCkCI7)},oGrp3,012,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
oCBox7     := TCheckBox():New( 119,196," ",{|u| If(PCount()>0,lCkCI6:=u,lCkCI6)},oGrp3,012,007,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
oCBox8     := TCheckBox():New( 107,196," ",{|u| If(PCount()>0,lCkCI5:=u,lCkCI5)},oGrp3,012,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
oCBox9     := TCheckBox():New( 194,196," ",{|u| If(PCount()>0,lCkCI12:=u,lCkCI12)},oGrp3,012,007,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
oCBox10    := TCheckBox():New( 182,196," ",{|u| If(PCount()>0,lCkCI11:=u,lCkCI11)},oGrp3,012,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
oCBox11    := TCheckBox():New( 169,196," ",{|u| If(PCount()>0,lCkCI10:=u,lCkCI10)},oGrp3,012,007,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
oCBox12    := TCheckBox():New( 157,196," ",{|u| If(PCount()>0,lCkCI9:=u,lCkCI9)},oGrp3,012,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
oCBox13    := TCheckBox():New( 207,196," ",{|u| If(PCount()>0,lCkCI13:=u,lCkCI13)},oGrp3,012,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
oCBox14    := TCheckBox():New( 219,196," ",{|u| If(PCount()>0,lCkCI14:=u,lCkCI14)},oGrp3,012,007,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
oGrp4      := TGroup():New( 040,213,236,424,"CorretoresVenda Direta ",oDlg1,CLR_BLACK,CLR_WHITE,.T.,.F. )
oSay7      := TSay():New( 048,217,{||"Colaborador"},oGrp4,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,052,008)
oSay8      := TSay():New( 048,306,{||"Cargo"},oGrp4,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,052,008)
oSay9      := TSay():New( 049,369,{||"Valor "},oGrp4,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,034,008)
oSay14     := TSay():New( 048,405,{||"Marca"},oGrp4,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,016,008)
oGet46     := TGet():New( 056,217,{|u| If(PCount()>0,cCorVDir1:=u,cCorVDir1)},oGrp4,084,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cCorVDir1",,)
oGet47     := TGet():New( 056,306,{|u| If(PCount()>0,cCargVD1:=u,cCargVD1)},oGrp4,055,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cCargVD1",,)
oGet48     := TGet():New( 068,306,{|u| If(PCount()>0,cCargVD2:=u,cCargVD2)},oGrp4,055,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cCargVD2",,)
oGet49     := TGet():New( 068,217,{|u| If(PCount()>0,cCorVDir2:=u,cCorVDir2)},oGrp4,084,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cCorVDir2",,)
oGet50     := TGet():New( 082,367,{|u| If(PCount()>0,nVlrVDir3:=u,nVlrVDir3)},oGrp4,034,008,'@E  99,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrVDir3",,)
oGet51     := TGet():New( 081,306,{|u| If(PCount()>0,cCargVD3:=u,cCargVD3)},oGrp4,055,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cCargVD3",,)
oGet52     := TGet():New( 081,217,{|u| If(PCount()>0,cCorVDir3:=u,cCorVDir3)},oGrp4,084,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cCorVDir3",,)
oGet53     := TGet():New( 094,367,{|u| If(PCount()>0,nVlrVDir4:=u,nVlrVDir4)},oGrp4,034,008,'@E  99,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrVDir4",,)
oGet54     := TGet():New( 093,306,{|u| If(PCount()>0,cCargVD4:=u,cCargVD4)},oGrp4,055,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cCargVD4",,)
oGet55     := TGet():New( 093,217,{|u| If(PCount()>0,cCorVDir4:=u,cCorVDir4)},oGrp4,084,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cCorVDir4",,)
oGet56     := TGet():New( 107,367,{|u| If(PCount()>0,nVlrVDir5:=u,nVlrVDir5)},oGrp4,034,008,'@E  99,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrVDir5",,)
oGet57     := TGet():New( 106,306,{|u| If(PCount()>0,cCargVD5:=u,cCargVD5)},oGrp4,055,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cCargVD5",,)
oGet58     := TGet():New( 106,217,{|u| If(PCount()>0,cCorVDir5:=u,cCorVDir5)},oGrp4,084,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cCorVDir5",,)
oGet59     := TGet():New( 119,367,{|u| If(PCount()>0,nVlrVDir6:=u,nVlrVDir6)},oGrp4,034,008,'@E  99,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrVDir6",,)
oGet60     := TGet():New( 118,306,{|u| If(PCount()>0,cCargVD6:=u,cCargVD6)},oGrp4,055,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cCargVD6",,)
oGet61     := TGet():New( 118,217,{|u| If(PCount()>0,cCorVDir6:=u,cCorVDir6)},oGrp4,084,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cCorVDir6",,)
oGet62     := TGet():New( 132,367,{|u| If(PCount()>0,nVlrVDir7:=u,nVlrVDir7)},oGrp4,034,008,'@E  99,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrVDir7",,)
oGet63     := TGet():New( 131,306,{|u| If(PCount()>0,cCargVD7:=u,cCargVD7)},oGrp4,055,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cCargVD7",,)
oGet64     := TGet():New( 131,217,{|u| If(PCount()>0,cCorVDir7:=u,cCorVDir7)},oGrp4,084,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cCorVDir7",,)
oGet65     := TGet():New( 144,367,{|u| If(PCount()>0,nVlrVDir8:=u,nVlrVDir8)},oGrp4,034,008,'@E  99,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrVDir8",,)
oGet66     := TGet():New( 143,306,{|u| If(PCount()>0,cCargVD8:=u,cCargVD8)},oGrp4,055,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cCargVD8",,)
oGet67     := TGet():New( 143,217,{|u| If(PCount()>0,cCorVDir8:=u,cCorVDir8)},oGrp4,084,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cCorVDir8",,)
oGet68     := TGet():New( 157,367,{|u| If(PCount()>0,nVlrVDir9:=u,nVlrVDir9)},oGrp4,034,008,'@E  99,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrVDir9",,)
oGet69     := TGet():New( 156,306,{|u| If(PCount()>0,cCargVD9:=u,cCargVD9)},oGrp4,055,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cCargVD9",,)
oGet70     := TGet():New( 156,217,{|u| If(PCount()>0,cCorVDir9:=u,cCorVDir9)},oGrp4,084,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cCorVDir9",,)
oGet71     := TGet():New( 169,367,{|u| If(PCount()>0,nVlrVDir10:=u,nVlrVDir10)},oGrp4,034,008,'@E  99,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrVDir10",,)
oGet72     := TGet():New( 182,367,{|u| If(PCount()>0,nVlrVDir11:=u,nVlrVDir11)},oGrp4,034,008,'@E  99,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrVDir11",,)
oGet73     := TGet():New( 194,367,{|u| If(PCount()>0,nVlrVDir12:=u,nVlrVDir12)},oGrp4,034,008,'@E  99,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrVDir12",,)
oGet74     := TGet():New( 207,367,{|u| If(PCount()>0,nVlrVDir13:=u,nVlrVDir13)},oGrp4,034,008,'@E  99,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrVDir13",,)
oGet75     := TGet():New( 219,367,{|u| If(PCount()>0,nVlrVDir14:=u,nVlrVDir14)},oGrp4,034,008,'@E  99,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrVDir14",,)
oGet76     := TGet():New( 218,306,{|u| If(PCount()>0,cCargVD14:=u,cCargVD14)},oGrp4,055,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cCargVD14",,)
oGet77     := TGet():New( 206,306,{|u| If(PCount()>0,cCargVD13:=u,cCargVD13)},oGrp4,055,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cCargVD13",,)
oGet78     := TGet():New( 193,306,{|u| If(PCount()>0,cCargVD12:=u,cCargVD12)},oGrp4,055,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cCargVD12",,)
oGet79     := TGet():New( 181,306,{|u| If(PCount()>0,cCargVD11:=u,cCargVD11)},oGrp4,055,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cCargVD11",,)
oGet80     := TGet():New( 168,306,{|u| If(PCount()>0,cCargVD10:=u,cCargVD10)},oGrp4,055,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cCargVD10",,)
oGet81     := TGet():New( 218,217,{|u| If(PCount()>0,cCorVDir14:=u,cCorVDir14)},oGrp4,084,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cCorVDir14",,)
oGet82     := TGet():New( 206,217,{|u| If(PCount()>0,cCorVDir13:=u,cCorVDir13)},oGrp4,084,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cCorVDir13",,)
oGet83     := TGet():New( 193,217,{|u| If(PCount()>0,cCorVDir12:=u,cCorVDir12)},oGrp4,084,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cCorVDir12",,)
oGet84     := TGet():New( 181,217,{|u| If(PCount()>0,cCorVDir11:=u,cCorVDir11)},oGrp4,084,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cCorVDir11",,)
oGet85     := TGet():New( 168,217,{|u| If(PCount()>0,cCorVDir10:=u,cCorVDir10)},oGrp4,084,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cCorVDir10",,)
oGet86     := TGet():New( 056,367,{|u| If(PCount()>0,nVlrVDir1:=u,nVlrVDir1)},oGrp4,034,008,'@E  99,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrVDir1",,)
oGet87     := TGet():New( 068,367,{|u| If(PCount()>0,nVlrVDir2:=u,nVlrVDir2)},oGrp4,034,008,'@E  99,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrVDir2",,)
oCBox15    := TCheckBox():New( 056,409," ",{|u| If(PCount()>0,lCkVD1:=u,lCkVD1)},oGrp4,012,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
oCBox16    := TCheckBox():New( 068,409," ",{|u| If(PCount()>0,lCkVD2:=u,lCkVD2)},oGrp4,012,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
oCBox17    := TCheckBox():New( 094,409," ",{|u| If(PCount()>0,lCkVD4:=u,lCkVD4)},oGrp4,012,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
oCBox18    := TCheckBox():New( 082,409," ",{|u| If(PCount()>0,lCkVD3:=u,lCkVD3)},oGrp4,012,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
oCBox19    := TCheckBox():New( 144,409," ",{|u| If(PCount()>0,lCkVD8:=u,lCkVD8)},oGrp4,012,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
oCBox20    := TCheckBox():New( 132,409," ",{|u| If(PCount()>0,lCkVD7:=u,lCkVD7)},oGrp4,012,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
oCBox21    := TCheckBox():New( 119,409," ",{|u| If(PCount()>0,lCkVD6:=u,lCkVD6)},oGrp4,012,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
oCBox22    := TCheckBox():New( 107,409," ",{|u| If(PCount()>0,lCkVD5:=u,lCkVD5)},oGrp4,012,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
oCBox23    := TCheckBox():New( 194,409," ",{|u| If(PCount()>0,lCkVD12:=u,lCkVD12)},oGrp4,012,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
oCBox24    := TCheckBox():New( 182,409," ",{|u| If(PCount()>0,lCkVD11:=u,lCkVD11)},oGrp4,012,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
oCBox25    := TCheckBox():New( 169,409," ",{|u| If(PCount()>0,lCkVD10:=u,lCkVD10)},oGrp4,012,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
oCBox26    := TCheckBox():New( 157,409," ",{|u| If(PCount()>0,lCkVD9:=u,lCkVD9)},oGrp4,012,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
oCBox27    := TCheckBox():New( 219,409," ",{|u| If(PCount()>0,lCkVD14:=u,lCkVD14)},oGrp4,012,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
oCBox28    := TCheckBox():New( 207,409," ",{|u| If(PCount()>0,lCkVD13:=u,lCkVD13)},oGrp4,012,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
oGrp5      := TGroup():New( 040,426,236,636,"Executivos de Contas",oDlg1,CLR_BLACK,CLR_WHITE,.T.,.F. )
oSay10     := TSay():New( 048,430,{||"Colaborador"},oGrp5,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,052,008)
oSay11     := TSay():New( 048,519,{||"Cargo"},oGrp5,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,052,008)
oSay12     := TSay():New( 049,582,{||"Valor "},oGrp5,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,034,008)
oSay15     := TSay():New( 049,618,{||"Marca"},oGrp5,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,016,008)
oGet88     := TGet():New( 056,430,{|u| If(PCount()>0,cExecCnt1:=u,cExecCnt1)},oGrp5,084,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cExecCnt1",,)
oGet89     := TGet():New( 056,519,{|u| If(PCount()>0,cCargExC1:=u,cCargExC1)},oGrp5,055,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cCargExC1",,)
oGet90     := TGet():New( 068,519,{|u| If(PCount()>0,cCargExC2:=u,cCargExC2)},oGrp5,055,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cCargExC2",,)
oGet91     := TGet():New( 068,430,{|u| If(PCount()>0,cExecCnt2:=u,cExecCnt2)},oGrp5,084,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cExecCnt2",,)
oGet92     := TGet():New( 082,580,{|u| If(PCount()>0,nVlrExC3:=u,nVlrExC3)},oGrp5,034,008,'@E  99,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrExC3",,)
oGet93     := TGet():New( 081,519,{|u| If(PCount()>0,cCargExC3:=u,cCargExC3)},oGrp5,055,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cCargExC3",,)
oGet94     := TGet():New( 081,430,{|u| If(PCount()>0,cExecCnt3:=u,cExecCnt3)},oGrp5,084,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cExecCnt3",,)
oGet95     := TGet():New( 094,580,{|u| If(PCount()>0,nVlrExC4:=u,nVlrExC4)},oGrp5,034,008,'@E  99,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrExC4",,)
oGet96     := TGet():New( 093,519,{|u| If(PCount()>0,cCargExC4:=u,cCargExC4)},oGrp5,055,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cCargExC4",,)
oGet97     := TGet():New( 093,430,{|u| If(PCount()>0,cExecCnt4:=u,cExecCnt4)},oGrp5,084,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cExecCnt4",,)
oGet98     := TGet():New( 107,580,{|u| If(PCount()>0,nVlrExC5:=u,nVlrExC5)},oGrp5,034,008,'@E  99,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrExC5",,)
oGet99     := TGet():New( 106,519,{|u| If(PCount()>0,cCargExC5:=u,cCargExC5)},oGrp5,055,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cCargExC5",,)
oGet100    := TGet():New( 106,430,{|u| If(PCount()>0,cExecCnt5:=u,cExecCnt5)},oGrp5,084,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cExecCnt5",,)
oGet101    := TGet():New( 119,580,{|u| If(PCount()>0,nVlrExC6:=u,nVlrExC6)},oGrp5,034,008,'@E  99,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrExC6",,)
oGet102    := TGet():New( 118,519,{|u| If(PCount()>0,cCargExC6:=u,cCargExC6)},oGrp5,055,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cCargExC6",,)
oGet103    := TGet():New( 118,430,{|u| If(PCount()>0,cExecCnt6:=u,cExecCnt6)},oGrp5,084,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cExecCnt6",,)
oGet104    := TGet():New( 132,580,{|u| If(PCount()>0,nVlrExC7:=u,nVlrExC7)},oGrp5,034,008,'@E  99,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrExC7",,)
oGet105    := TGet():New( 131,519,{|u| If(PCount()>0,cCargExC7:=u,cCargExC7)},oGrp5,055,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cCargExC7",,)
oGet106    := TGet():New( 131,430,{|u| If(PCount()>0,cExecCnt7:=u,cExecCnt7)},oGrp5,084,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cExecCnt7",,)
oGet107    := TGet():New( 144,580,{|u| If(PCount()>0,nVlrExC8:=u,nVlrExC8)},oGrp5,034,008,'@E  99,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrExC8",,)
oGet108    := TGet():New( 143,519,{|u| If(PCount()>0,cCargExC8:=u,cCargExC8)},oGrp5,055,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cCargExC8",,)
oGet109    := TGet():New( 143,430,{|u| If(PCount()>0,cExecCnt8:=u,cExecCnt8)},oGrp5,084,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cExecCnt8",,)
oGet110    := TGet():New( 157,580,{|u| If(PCount()>0,nVlrExC9:=u,nVlrExC9)},oGrp5,034,008,'@E  99,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrExC9",,)
oGet111    := TGet():New( 156,519,{|u| If(PCount()>0,cCargExC9:=u,cCargExC9)},oGrp5,055,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cCargExC9",,)
oGet112    := TGet():New( 156,430,{|u| If(PCount()>0,cExecCnt9:=u,cExecCnt9)},oGrp5,084,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cExecCnt9",,)
oGet113    := TGet():New( 169,580,{|u| If(PCount()>0,nVlrExC10:=u,nVlrExC10)},oGrp5,034,008,'@E  99,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrExC10",,)
oGet114    := TGet():New( 182,580,{|u| If(PCount()>0,nVlrExC11:=u,nVlrExC11)},oGrp5,034,008,'@E  99,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrExC11",,)
oGet115    := TGet():New( 194,580,{|u| If(PCount()>0,nVlrExC12:=u,nVlrExC12)},oGrp5,034,008,'@E  99,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrExC12",,)
oGet116    := TGet():New( 207,580,{|u| If(PCount()>0,nVlrExC13:=u,nVlrExC13)},oGrp5,034,008,'@E  99,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrExC13",,)
oGet117    := TGet():New( 219,580,{|u| If(PCount()>0,nVlrExC14:=u,nVlrExC14)},oGrp5,034,008,'@E  99,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrExC14",,)
oGet118    := TGet():New( 218,519,{|u| If(PCount()>0,cCargExC14:=u,cCargExC14)},oGrp5,055,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cCargExC14",,)
oGet119    := TGet():New( 206,519,{|u| If(PCount()>0,cCargExC13:=u,cCargExC13)},oGrp5,055,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cCargExC13",,)
oGet120    := TGet():New( 193,519,{|u| If(PCount()>0,cCargExC12:=u,cCargExC12)},oGrp5,055,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cCargExC12",,)
oGet121    := TGet():New( 181,519,{|u| If(PCount()>0,cCargExC11:=u,cCargExC11)},oGrp5,055,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cCargExC11",,)
oGet122    := TGet():New( 168,519,{|u| If(PCount()>0,cCargExC10:=u,cCargExC10)},oGrp5,055,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cCargExC10",,)
oGet123    := TGet():New( 218,430,{|u| If(PCount()>0,cExecCnt14:=u,cExecCnt14)},oGrp5,084,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cExecCnt14",,)
oGet124    := TGet():New( 206,430,{|u| If(PCount()>0,cExecCnt13:=u,cExecCnt13)},oGrp5,084,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cExecCnt13",,)
oGet125    := TGet():New( 193,430,{|u| If(PCount()>0,cExecCnt12:=u,cExecCnt12)},oGrp5,084,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cExecCnt12",,)
oGet126    := TGet():New( 181,430,{|u| If(PCount()>0,cExecCnt11:=u,cExecCnt11)},oGrp5,084,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cExecCnt11",,)
oGet127    := TGet():New( 168,430,{|u| If(PCount()>0,cExecCnt10:=u,cExecCnt10)},oGrp5,084,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cExecCnt10",,)
oGet128    := TGet():New( 056,580,{|u| If(PCount()>0,nVlrExC1:=u,nVlrExC1)},oGrp5,034,008,'@E  99,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrExC1",,)
oGet129    := TGet():New( 068,580,{|u| If(PCount()>0,nVlrExC2:=u,nVlrExC2)},oGrp5,034,008,'@E  99,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrExC2",,)
oCBox29    := TCheckBox():New( 056,622," ",{|u| If(PCount()>0,lCkEC1:=u,lCkEC1)},oGrp5,012,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
oCBox30    := TCheckBox():New( 068,622," ",{|u| If(PCount()>0,lCkEC2:=u,lCkEC2)},oGrp5,012,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
oCBox31    := TCheckBox():New( 082,622," ",{|u| If(PCount()>0,lCkEC3:=u,lCkEC3)},oGrp5,012,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
oCBox32    := TCheckBox():New( 094,622," ",{|u| If(PCount()>0,lCkEC4:=u,lCkEC4)},oGrp5,012,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
oCBox33    := TCheckBox():New( 144,622," ",{|u| If(PCount()>0,lCkEC8:=u,lCkEC8)},oGrp5,012,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
oCBox34    := TCheckBox():New( 132,622," ",{|u| If(PCount()>0,lCkEC7:=u,lCkEC7)},oGrp5,012,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
oCBox35    := TCheckBox():New( 119,622," ",{|u| If(PCount()>0,lCkEC6:=u,lCkEC6)},oGrp5,012,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
oCBox36    := TCheckBox():New( 107,622," ",{|u| If(PCount()>0,lCkEC5:=u,lCkEC5)},oGrp5,012,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
oCBox37    := TCheckBox():New( 194,622," ",{|u| If(PCount()>0,lCkEC12:=u,lCkEC12)},oGrp5,012,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
oCBox38    := TCheckBox():New( 182,622," ",{|u| If(PCount()>0,lCkEC11:=u,lCkEC11)},oGrp5,012,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
oCBox39    := TCheckBox():New( 169,622," ",{|u| If(PCount()>0,lCkEC10:=u,lCkEC10)},oGrp5,012,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
oCBox40    := TCheckBox():New( 157,622," ",{|u| If(PCount()>0,lCkEC9:=u,lCkEC9)},oGrp5,012,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
oCBox41    := TCheckBox():New( 219,622," ",{|u| If(PCount()>0,lCkEC14:=u,lCkEC14)},oGrp5,012,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
oCBox42    := TCheckBox():New( 207,622," ",{|u| If(PCount()>0,lCkEC13:=u,lCkEC13)},oGrp5,012,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
oGrp6      := TGroup():New( 240,000,340,212," Aprovações N1 - "+trim(CAPROV1),oDlg1,CLR_BLACK,CLR_WHITE,.T.,.F. )
oSay16     := TSay():New( 264,008,{||"Aprovados "},oGrp6,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay17     := TSay():New( 279,008,{||"Bloqueados "},oGrp6,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay18     := TSay():New( 294,008,{||"Bloqueados Definitivo"},oGrp6,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,059,008)
oSay19     := TSay():New( 309,008,{||"Bloqueados Sinistralidade"},oGrp6,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,062,008)
oSay20     := TSay():New( 324,008,{||"Totais da Comissões "},oGrp6,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,055,008)
oSay21     := TSay():New( 252,080,{||"Quantidade "},oGrp6,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay22     := TSay():New( 252,153,{||"Valor"},oGrp6,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,015,008)
oSay23     := TSay():New( 252,186,{||"%"},oGrp6,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,010,008)
oGet130    := TGet():New( 264,080,{|u| If(PCount()>0,nqtdAprN1:=u,nqtdAprN1)},oGrp6,028,008,'@E  99,999',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nqtdAprN1",,)
oGet131    := TGet():New( 264,120,{|u| If(PCount()>0,nVlrAprN1:=u,nVlrAprN1)},oGrp6,048,008,'@E  9,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nVlrAprN1",,)
oGet132    := TGet():New( 264,176,{|u| If(PCount()>0,nPerAprN1:=u,nPerAprN1)},oGrp6,024,008,'@E  999.99%',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nPerAprN1",,)
oGet133    := TGet():New( 279,176,{|u| If(PCount()>0,nPerBlqN1:=u,nPerBlqN1)},oGrp6,024,008,'@E  999.99%',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nPerBlqN1 ",,)
oGet134    := TGet():New( 279,120,{|u| If(PCount()>0,nVlrBloN1:=u,nVlrBloN1)},oGrp6,048,008,'@E  9,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nVlrBloN1",,)
oGet135    := TGet():New( 279,080,{|u| If(PCount()>0,nqtdBloN1:=u,nqtdBloN1)},oGrp6,028,008,'@E  99,999',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nqtdBloN1",,)
oGet136    := TGet():New( 294,176,{|u| If(PCount()>0,nPerDefN1:=u,nPerDefN1)},oGrp6,024,008,'@E  999.99%',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nPerDefN1",,)
oGet137    := TGet():New( 294,120,{|u| If(PCount()>0,nVlrDefN1:=u,nVlrDefN1)},oGrp6,048,008,'@E  9,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nVlrDefN1",,)
oGet138    := TGet():New( 294,080,{|u| If(PCount()>0,nqtdDefN1:=u,nqtdDefN1)},oGrp6,028,008,'@E  99,999',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nqtdDefN1",,)
oGet139    := TGet():New( 309,176,{|u| If(PCount()>0,nPerSinN1:=u,nPerSinN1)},oGrp6,024,008,'@E  999.99%',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nPerSinN1",,)
oGet140    := TGet():New( 309,120,{|u| If(PCount()>0,nVlrSinN1:=u,nVlrSinN1)},oGrp6,048,008,'@E  9,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nVlrSinN1",,)
oGet141    := TGet():New( 309,080,{|u| If(PCount()>0,nqtdSinN1:=u,nqtdSinN1)},oGrp6,028,008,'@E  99,999',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nqtdSinN1",,)
oGet142    := TGet():New( 324,176,{|u| If(PCount()>0,nPerTotN1:=u,nPerTotN1)},oGrp6,024,008,'@E  999.99%',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nPerTotN1",,)
oGet143    := TGet():New( 324,120,{|u| If(PCount()>0,nVlrTotN1:=u,nVlrTotN1)},oGrp6,048,008,'@E  9,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nVlrTotN1",,)
oGet144    := TGet():New( 324,080,{|u| If(PCount()>0,nqtdTotN1:=u,nqtdTotN1)},oGrp6,028,008,'@E  99,999',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nqtdTotN1",,)
oGrp7      := TGroup():New( 240,213,340,425," Aprovações N2 - "+trim(CAPROV2),oDlg1,CLR_BLACK,CLR_WHITE,.T.,.F. )
oSay24     := TSay():New( 264,221,{||"Aprovados "},oGrp7,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay25     := TSay():New( 279,221,{||"Bloqueados "},oGrp7,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay26     := TSay():New( 294,221,{||"Bloqueados Definitivo"},oGrp7,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,059,008)
oSay27     := TSay():New( 309,221,{||"Bloqueados Sinistralidade"},oGrp7,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,062,008)
oSay28     := TSay():New( 324,221,{||"Totais da Comissões "},oGrp7,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,055,008)
oSay29     := TSay():New( 252,293,{||"Quantidade "},oGrp7,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay30     := TSay():New( 252,366,{||"Valor"},oGrp7,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,015,008)
oSay31     := TSay():New( 252,399,{||"%"},oGrp7,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,010,008)
oGet145    := TGet():New( 264,293,{|u| If(PCount()>0,nqtdAprN2:=u,nqtdAprN2)},oGrp7,028,008,'@E  99,999',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nqtdAprN2",,)
oGet146    := TGet():New( 264,333,{|u| If(PCount()>0,nVlrAprN2:=u,nVlrAprN2)},oGrp7,048,008,'@E  9,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nVlrAprN2",,)
oGet147    := TGet():New( 264,389,{|u| If(PCount()>0,nPerAprN2:=u,nPerAprN2)},oGrp7,024,008,'@E  999.99%',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nPerAprN2",,)
oGet148    := TGet():New( 279,389,{|u| If(PCount()>0,nPerBlqN2:=u,nPerBlqN2)},oGrp7,024,008,'@E  999.99%',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nPerBlqN2",,)
oGet149    := TGet():New( 279,333,{|u| If(PCount()>0,nVlrBloN2:=u,nVlrBloN2)},oGrp7,048,008,'@E  9,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nVlrBloN2",,)
oGet150    := TGet():New( 279,293,{|u| If(PCount()>0,nqtdBloN2:=u,nqtdBloN2)},oGrp7,028,008,'@E  99,999',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cqtdBloN2",,)
oGet151    := TGet():New( 294,389,{|u| If(PCount()>0,nPerDefN2:=u,nPerDefN2)},oGrp7,024,008,'@E  999.99%',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nPerDefN2",,)
oGet152    := TGet():New( 294,333,{|u| If(PCount()>0,nVlrDefN2:=u,nVlrDefN2)},oGrp7,048,008,'@E  9,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nVlrDefN2",,)
oGet153    := TGet():New( 294,293,{|u| If(PCount()>0,nqtdDefN2:=u,nqtdDefN2)},oGrp7,028,008,'@E  99,999',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nqtdDefN2",,)
oGet154    := TGet():New( 309,389,{|u| If(PCount()>0,nPerSinN2:=u,nPerSinN2)},oGrp7,024,008,'@E  999.99%',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nPerSinN2",,)
oGet155    := TGet():New( 309,333,{|u| If(PCount()>0,nVlrSinN2:=u,nVlrSinN2)},oGrp7,048,008,'@E  9,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nVlrSinN2",,)
oGet156    := TGet():New( 309,293,{|u| If(PCount()>0,nqtdSinN2:=u,nqtdSinN2)},oGrp7,028,008,'@E  99,999',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nqtdSinN2",,)
oGet157    := TGet():New( 324,389,{|u| If(PCount()>0,nPerTotN2:=u,nPerTotN2)},oGrp7,024,008,'@E  999.99%',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nPerTotN2",,)
oGet158    := TGet():New( 324,333,{|u| If(PCount()>0,nVlrTotN2:=u,nVlrTotN2)},oGrp7,048,008,'@E  9,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nVlrTotN2",,)
oGet159    := TGet():New( 324,293,{|u| If(PCount()>0,nqtdTotN2:=u,nqtdTotN2)},oGrp7,028,008,'@E  99,999',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nqtdTotN2",,)
oGrp8      := TGroup():New( 240,426,340,638," Aprovações N3 - "+trim(CAPROV3),oDlg1,CLR_BLACK,CLR_WHITE,.T.,.F. )
oSay32     := TSay():New( 264,434,{||"Aprovados "},oGrp8,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay33     := TSay():New( 279,434,{||"Bloqueados "},oGrp8,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay34     := TSay():New( 294,434,{||"Bloqueados Definitivo"},oGrp8,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,059,008)
oSay35     := TSay():New( 309,434,{||"Bloqueados Sinistralidade"},oGrp8,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,062,008)
oSay36     := TSay():New( 324,434,{||"Totais da Comissões "},oGrp8,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,055,008)
oSay37     := TSay():New( 252,506,{||"Quantidade "},oGrp8,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay38     := TSay():New( 252,579,{||"Valor"},oGrp8,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,015,008)
oSay39     := TSay():New( 252,612,{||"%"},oGrp8,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,010,008)
oGet160    := TGet():New( 264,506,{|u| If(PCount()>0,nqtdAprN3:=u,nqtdAprN3)},oGrp8,028,008,'@E  99,999',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nqtdAprN3",,)
oGet161    := TGet():New( 264,546,{|u| If(PCount()>0,nVlrAprN3:=u,nVlrAprN3)},oGrp8,048,008,'@E  9,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nVlrAprN3",,)
oGet162    := TGet():New( 264,602,{|u| If(PCount()>0,nPerAprN3:=u,nPerAprN3)},oGrp8,024,008,'@E  999.99%',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nPerAprN3",,)
oGet163    := TGet():New( 279,602,{|u| If(PCount()>0,nPerBlqN3:=u,nPerBlqN3)},oGrp8,024,008,'@E  999.99%',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nPerBlqN3",,)
oGet164    := TGet():New( 279,546,{|u| If(PCount()>0,nVlrBloN3:=u,nVlrBloN3)},oGrp8,048,008,'@E  9,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nVlrBloN3",,)
oGet165    := TGet():New( 279,506,{|u| If(PCount()>0,nqtdBloN3:=u,nqtdBloN3)},oGrp8,028,008,'@E  99,999',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nqtdBloN3",,)
oGet166    := TGet():New( 294,602,{|u| If(PCount()>0,nPerDefN3:=u,nPerDefN3)},oGrp8,024,008,'@E  999.99%',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nPerDefN3",,)
oGet167    := TGet():New( 294,546,{|u| If(PCount()>0,nVlrDefN3:=u,nVlrDefN3)},oGrp8,048,008,'@E  9,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nVlrDefN3",,)
oGet168    := TGet():New( 294,506,{|u| If(PCount()>0,nqtdDefN3:=u,nqtdDefN3)},oGrp8,028,008,'@E  99,999',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nqtdDefN3",,)
oGet169    := TGet():New( 309,602,{|u| If(PCount()>0,nPerSinN3:=u,nPerSinN3)},oGrp8,024,008,'@E  999.99%',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nPerSinN3",,)
oGet170    := TGet():New( 309,546,{|u| If(PCount()>0,nVlrSinN3:=u,nVlrSinN3)},oGrp8,048,008,'@E  9,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nVlrSinN3",,)
oGet171    := TGet():New( 309,506,{|u| If(PCount()>0,nqtdSinN3:=u,nqtdSinN3)},oGrp8,028,008,'@E  99,999',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nqtdSinN3",,)
oGet172    := TGet():New( 324,602,{|u| If(PCount()>0,nPerTotN3:=u,nPerTotN3)},oGrp8,024,008,'@E  999.99%',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nPerTotN3",,)
oGet173    := TGet():New( 324,546,{|u| If(PCount()>0,nVlrTotN3:=u,nVlrTotN3)},oGrp8,048,008,'@E  9,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nVlrTotN3",,)
oGet174    := TGet():New( 324,506,{|u| If(PCount()>0,nqtdTotN3:=u,nqtdTotN3)},oGrp8,028,008,'@E  99,999',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nqtdTotN3",,)


If ( _cIdUsuar != cAproN3 .and. _cIdUsuar != cAproN4)

     oBtn1:Disable()

EndIf      

oDlg202:Activate(,,,.T.)

Return

static Function fConsulta() 

local ret       := 0
local  cQuery   := " "   

/*
If _cIdUsuar == '000026'

    cQuery :=       " select Pdu_Codeqp "
    cQuery += CRLF+ "   From Pdu010 Pdu , Sra010 Sra , pdx010 pdx " 
    cQuery += CRLF+ "  Where Pdu_Filial = ' ' "
    cQuery += CRLF+ "   And Pdu.D_E_L_E_T_ = ' ' " 
    cQuery += CRLF+ "   And Ra_Filial ='01' "
    cQuery += CRLF+ "   And Sra.D_E_L_E_T_ = ' ' " 
    cQuery += CRLF+ "   And Pdx_Filial = ' ' " 
    cQuery += CRLF+ "   And Pdx.D_E_L_E_T_ = ' ' "
    cQuery += CRLF+ "   And Pdu_Pgto = 'N' "
                        
    cQuery += CRLF+ "   and substr(pdx_datini,1,6) <= PDU_COMPTE " 
    cQuery += CRLF+ "   and substr(pdx_datFim,1,6) <> ' ' "

    cQuery += CRLF+ "      and (PDX.PDX_PARINI = ' ' and 1=1" 
    cQuery += CRLF+ "       or (PDX.PDX_PARINI <> ' ' and pdu_numpar >=  PDX.PDX_PARINI and pdu_numpar <=  PDX.PDX_PARFIM))"

    cQuery += CRLF+ "   and Pdx_codigo = Pdu_Codeqp "
    cQuery += CRLF+ "   and Pdx_matfuc = Pdu_Matfuc "
    cQuery += CRLF+ "   And Ra_Mat = Pdu_Matfuc "

    cQuery += CRLF+ "     and PDU_STATUS  <>  'X' "

    cQuery += CRLF+ "     and PDU_STATU2  = 'A'   "
    cQuery += CRLF+ "     and PDU_STATU3  = ' '   "
    cQuery += CRLF+ "     and PDU_STATUS  = 'A'   "
    
    cQuery += CRLF+ "     and (PDU_PGTO    = 'N' AND PDU_STATUS <> 'S') " 

    cQuery += CRLF+ "   And Ra_Demissa = ' '  "
    cQuery += CRLF+ " Group By Pdu_Codeqp , Pdu_Matfuc , Pdu_Nome , pdx_cargo , pdu_verba , pdx_ccusto , "
    cQuery += CRLF+ "       CASE WHEN SUBSTR(Pdu_Codeqp,1,1)= 'X' THEN 'EX' "
    cQuery += CRLF+ "            WHEN SUBSTR(Pdu_Codeqp,1,1)= 'E' THEN 'DI' "
    cQuery += CRLF+ "            WHEN SUBSTR(Pdu_Codeqp,1,1)= 'C' THEN 'IN' "
    cQuery += CRLF+ "       ELSE 'N/I ' END  "
    
    cQuery += CRLF+ " Order By Pdu_Codeqp  ,Pdu_Matfuc , Pdu_Nome, Sum(Pdu_Vlrpgt) " 

    If Select((cAliastmp)) <> 0 
        (cAliastmp)->(DbCloseArea())  
    Endif                  

    TCQuery cQuery New Alias (cAliastmp)   

    if !(cAliastmp)->(Eof())
        cAproN3 := '000026'
        cAproN4 := ''
    endif

endif
*/

cQuery :=       " select Pdu_Codeqp Codeqp , " 
cQuery += CRLF+ "        Pdu_Matfuc Matfuc , "
cQuery += CRLF+ "        Pdu_Nome  Nome    , "
cQuery += CRLF+ "        pdx_cargo cargo   , "
cQuery += CRLF+ "        pdu_verba verba   , "
cQuery += CRLF+ "        pdx_ccusto ccusto , " 
cQuery += CRLF+ "        CASE WHEN SUBSTR(Pdu_Codeqp,1,1)= 'X' THEN 'EX' " 
cQuery += CRLF+ "             WHEN SUBSTR(Pdu_Codeqp,1,1)= 'E' THEN 'DI' "
cQuery += CRLF+ "             WHEN SUBSTR(Pdu_Codeqp,1,1)= 'C' THEN 'IN' "
cQuery += CRLF+ "        ELSE 'N/I ' END TPDOC , "
//cQuery += CRLF+ "        PDU_COMPTE COMPTE , "
cQuery += CRLF+ "        Sum(Pdu_Vlrpgt) totcol "

cQuery += CRLF+ "   From Pdu010 Pdu , Sra010 Sra , pdx010 pdx " 
cQuery += CRLF+ "  Where Pdu_Filial = ' ' "
cQuery += CRLF+ "   And Pdu.D_E_L_E_T_ = ' ' " 
cQuery += CRLF+ "   And Ra_Filial ='01' "
cQuery += CRLF+ "   And Sra.D_E_L_E_T_ = ' ' " 
cQuery += CRLF+ "   And Pdx_Filial = ' ' " 
cQuery += CRLF+ "   And Pdx.D_E_L_E_T_ = ' ' "
cQuery += CRLF+ "   And Pdu_Pgto = 'N' "
                    
cQuery += CRLF+ "   and substr(pdx_datini,1,6) <= PDU_COMPTE " 
cQuery += CRLF+ "   and substr(pdx_datFim,1,6) <> ' ' "

//cQuery += CRLF+ "      and (pdu_numpar = ' ' and 1=1 " 
//cQuery += CRLF+ "       or (pdu_numpar <> ' ' and pdu_numpar >=  PDX.PDX_PARINI and pdu_numpar <=  PDX.PDX_PARFIM)) "

cQuery += CRLF+ "      and (PDX.PDX_PARINI = ' ' and 1=1" 
cQuery += CRLF+ "       or (PDX.PDX_PARINI <> ' ' and pdu_numpar >=  PDX.PDX_PARINI and pdu_numpar <=  PDX.PDX_PARFIM))"

cQuery += CRLF+ "   and Pdx_codigo = Pdu_Codeqp "
cQuery += CRLF+ "   and Pdx_matfuc = Pdu_Matfuc "
cQuery += CRLF+ "   And Ra_Mat = Pdu_Matfuc "

cQuery += CRLF+ "     and PDU_STATUS  <>  'X' "


If _cIdUsuar == cAproN3
   
   cQuery += CRLF+ "     and PDU_STATU2  = 'A'   "
   cQuery += CRLF+ "     and PDU_STATU3  = ' '   "
   cQuery += CRLF+ "     and PDU_STATUS  = 'A'   "
   
ElseIf _cIdUsuar == cAproN4
   
   cQuery += CRLF+ "     and PDU_STATU3  = 'A'   "
   cQuery += CRLF+ "     and PDU_STATU4  = ' '   "
   cQuery += CRLF+ "     and PDU_STATUS  = 'A'   "
   
EndIf    
//cQuery += CRLF+ "     and PDU_PGTO    = 'N'   "

cQuery += CRLF+ "     and (PDU_PGTO    = 'N' AND PDU_STATUS <> 'S') " 

//cQryPEG += CRLF+ "     and PDU->PDU_PGTO  not In ('C','S')

cQuery += CRLF+ "   And Ra_Demissa = ' '  "
cQuery += CRLF+ " Group By Pdu_Codeqp , Pdu_Matfuc , Pdu_Nome , pdx_cargo , pdu_verba , pdx_ccusto , "
cQuery += CRLF+ "       CASE WHEN SUBSTR(Pdu_Codeqp,1,1)= 'X' THEN 'EX' "
cQuery += CRLF+ "            WHEN SUBSTR(Pdu_Codeqp,1,1)= 'E' THEN 'DI' "
cQuery += CRLF+ "            WHEN SUBSTR(Pdu_Codeqp,1,1)= 'C' THEN 'IN' "
cQuery += CRLF+ "       ELSE 'N/I ' END  "
//cQuery += CRLF+ "           , PDU_COMPTE  "
cQuery += CRLF+ " Order By Pdu_Codeqp  ,Pdu_Matfuc , Pdu_Nome, Sum(Pdu_Vlrpgt) " 
 

If Select((cAliastmp)) <> 0 

   (cAliastmp)->(DbCloseArea())  

Endif                  
  
TCQuery cQuery New Alias (cAliastmp)   

(cAliastmp)->( DbGoTop() )  

While !(cAliastmp)->(Eof())

        if  substr((cAliastmp)->Codeqp,1,1) == 'X' 
            IndExtC++
        Elseif substr((cAliastmp)->Codeqp,1,1) == 'C'
            IndVInt++
        Elseif substr((cAliastmp)->Codeqp,1,1) == 'E'        
            IndVDir++
        EndIf 

    if substr((cAliastmp)->Codeqp,1,1) == 'X' 
      
        If  IndExtC == 1

            cExecCnt1  := (cAliastmp)->Nome
            cCargExC1  := (cAliastmp)->Cargo
            nVlrExC1   := (cAliastmp)->totcol
            cMatFExc1  := (cAliastmp)->Matfuc
            cCodEqEc1  := (cAliastmp)->Codeqp
            lCkEC1     := .T.

        ElseIf  IndExtC == 2

            cExecCnt2  := (cAliastmp)->Nome
            cCargExC2  := (cAliastmp)->Cargo
            nVlrExC2   := (cAliastmp)->totcol
            cMatFExc2  := (cAliastmp)->Matfuc
            cCodEqEc2   := (cAliastmp)->Codeqp
            lCkEC2     := .T.

        ElseIf  IndExtC == 3
        
            cExecCnt3  := (cAliastmp)->Nome
            cCargExC3  := (cAliastmp)->Cargo
            nVlrExC3   := (cAliastmp)->totcol
            cMatFExc3  := (cAliastmp)->Matfuc
            cCodEqEc3   := (cAliastmp)->Codeqp
            lCkEC3     := .T.

        ElseIf  IndExtC == 4
        
            cExecCnt4  := (cAliastmp)->Nome
            cCargExC4  := (cAliastmp)->Cargo
            nVlrExC4   := (cAliastmp)->totcol
            cMatFExc4  := (cAliastmp)->Matfuc
            cCodEqEc4   := (cAliastmp)->Codeqp
            lCkEC4     := .T.

        ElseIf  IndExtC == 5
        
            cExecCnt5  := (cAliastmp)->Nome
            cCargExC5  := (cAliastmp)->Cargo
            nVlrExC5   := (cAliastmp)->totcol
            cMatFExc5  := (cAliastmp)->Matfuc
            cCodEqEc5   := (cAliastmp)->Codeqp
            lCkEC5     := .T.

        ElseIf  IndExtC == 6
        
            cExecCnt6  := (cAliastmp)->Nome
            cCargExC6  := (cAliastmp)->Cargo
            nVlrExC6   := (cAliastmp)->totcol
            cMatFExc6  := (cAliastmp)->Matfuc
            cCodEqEc6   := (cAliastmp)->Codeqp
            lCkEC6     := .T.

        ElseIf  IndExtC == 7
        
            cExecCnt7  := (cAliastmp)->Nome
            cCargExC7  := (cAliastmp)->Cargo
            nVlrExC7   := (cAliastmp)->totcol
            cMatFExc7  := (cAliastmp)->Matfuc
            cCodEqEc7   := (cAliastmp)->Codeqp
            lCkEC7     := .T.
        
        ElseIf  IndExtC == 8
        
            cExecCnt8  := (cAliastmp)->Nome
            cCargExC8  := (cAliastmp)->Cargo
            nVlrExC8   := (cAliastmp)->totcol
            cMatFExc8  := (cAliastmp)->Matfuc
            cCodEqEc8   := (cAliastmp)->Codeqp
            lCkEC8     := .T.
        
        ElseIf  IndExtC == 9
        
            cExecCnt9  := (cAliastmp)->Nome
            cCargExC9  := (cAliastmp)->Cargo
            nVlrExC9   := (cAliastmp)->totcol
            cMatFExc9  := (cAliastmp)->Matfuc
            cCodEqEc9   := (cAliastmp)->Codeqp
            lCkEC9     := .T.
        
        ElseIf  IndExtC == 10
        
            cExecCnt10 := (cAliastmp)->Nome
            cCargExC10 := (cAliastmp)->Cargo
            nVlrExC10  := (cAliastmp)->totcol
            cMatFExc10 := (cAliastmp)->Matfuc
            cCodEqEc10   := (cAliastmp)->Codeqp
            lCkEC10     := .T.

        ElseIf  IndExtC == 11
        
            cExecCnt11 := (cAliastmp)->Nome
            cCargExC11 := (cAliastmp)->Cargo
            nVlrExC11  := (cAliastmp)->totcol
            cMatFExc11 := (cAliastmp)->Matfuc
            cCodEqEc11   := (cAliastmp)->Codeqp
            lCkEC11     := .T.

        ElseIf  IndExtC == 12
        
            cExecCnt12 := (cAliastmp)->Nome
            cCargExC12 := (cAliastmp)->Cargo
            nVlrExC12  := (cAliastmp)->totcol
            cMatFExc12 := (cAliastmp)->Matfuc
            cCodEqEc12  := (cAliastmp)->Codeqp
            lCkEC12    := .T.

        ElseIf  IndExtC == 13
        
            cExecCnt13 := (cAliastmp)->Nome
            cCargExC13 := (cAliastmp)->Cargo
            nVlrExC13  := (cAliastmp)->totcol
            cMatFExc13 := (cAliastmp)->Matfuc
            cCodEqEc13   := (cAliastmp)->Codeqp
            lCkEC13    := .T.

        ElseIf  IndExtC == 14
        
            cExecCnt14 := (cAliastmp)->Nome
            cCargExC14 := (cAliastmp)->Cargo
            nVlrExC14  := (cAliastmp)->totcol
            cMatFExc14 := (cAliastmp)->Matfuc 
            cCodEqEc14   := (cAliastmp)->Codeqp
            lCkEC14    := .T.
        
        EndIf      

    Elseif substr((cAliastmp)->Codeqp,1,1) == 'E'
        
        If IndVDir    == 1

           cCorVDir1  := (cAliastmp)->Nome
           cCargVD1   := (cAliastmp)->Cargo
           nVlrVDir1  := (cAliastmp)->totcol
           cMatFVD1   := (cAliastmp)->Matfuc
           cCodEqVd1  := (cAliastmp)->Codeqp 
           lCkVD1     := .T.
           
        ElseIf IndVDir == 2
         
           cCorVDir2  := (cAliastmp)->Nome
           cCargVD2   := (cAliastmp)->Cargo
           nVlrVDir2  := (cAliastmp)->totcol
           cMatFVD2   := (cAliastmp)->Matfuc
           cCodEqVd2  := (cAliastmp)->Codeqp
           lCkVD2     := .T.

        ElseIf IndVDir == 3
         
           cCorVDir3  := (cAliastmp)->Nome
           cCargVD3   := (cAliastmp)->Cargo
           nVlrVDir3  := (cAliastmp)->totcol
           cMatFVD3   := (cAliastmp)->Matfuc
           cCodEqVd3  := (cAliastmp)->Codeqp
           lCkVD3     := .T.

        ElseIf IndVDir == 4
         
           cCorVDir4  := (cAliastmp)->Nome
           cCargVD4   := (cAliastmp)->Cargo
           nVlrVDir4  := (cAliastmp)->totcol
           cMatFVD4   := (cAliastmp)->Matfuc
           cCodEqVd4  := (cAliastmp)->Codeqp
           lCkVD4     := .T.

        ElseIf IndVDir == 5
         
           cCorVDir5  := (cAliastmp)->Nome
           cCargVD5   := (cAliastmp)->Cargo
           nVlrVDir5  := (cAliastmp)->totcol
           cMatFVD5   := (cAliastmp)->Matfuc
           cCodEqVd5  := (cAliastmp)->Codeqp
           lCkVD5     := .T.

        ElseIf IndVDir == 6
         
           cCorVDir6  := (cAliastmp)->Nome
           cCargVD6   := (cAliastmp)->Cargo
           nVlrVDir6  := (cAliastmp)->totcol
           cMatFVD6   := (cAliastmp)->Matfuc
           cCodEqVd6  := (cAliastmp)->Codeqp
           lCkVD6     := .T.

        ElseIf IndVDir == 7
         
           cCorVDir7  := (cAliastmp)->Nome
           cCargVD7   := (cAliastmp)->Cargo
           nVlrVDir7  := (cAliastmp)->totcol
           cMatFVD7   := (cAliastmp)->Matfuc
           cCodEqVd7  := (cAliastmp)->Codeqp
           lCkVD7     := .T.

        ElseIf IndVDir == 8
         
           cCorVDir8  := (cAliastmp)->Nome
           cCargVD8   := (cAliastmp)->Cargo
           nVlrVDir8  := (cAliastmp)->totcol
           cMatFVD8   := (cAliastmp)->Matfuc
           cCodEqVd8  := (cAliastmp)->Codeqp
           lCkVD8     := .T.

        ElseIf IndVDir == 9
         
           cCorVDir9  := (cAliastmp)->Nome
           cCargVD9   := (cAliastmp)->Cargo
           nVlrVDir9  := (cAliastmp)->totcol
           cMatFVD9   := (cAliastmp)->Matfuc
           cCodEqVd9  := (cAliastmp)->Codeqp
           lCkVD9     := .T.

        ElseIf IndVDir == 10
         
           cCorVDir10  := (cAliastmp)->Nome
           cCargVD10   := (cAliastmp)->Cargo
           nVlrVDir10  := (cAliastmp)->totcol
           cMatFVD10   := (cAliastmp)->Matfuc
           cCodEqVd10  := (cAliastmp)->Codeqp
           lCkVD10     := .T.
        
        ElseIf IndVDir == 11
         
           cCorVDir11  := (cAliastmp)->Nome
           cCargVD11   := (cAliastmp)->Cargo
           nVlrVDir11  := (cAliastmp)->totcol
           cMatFVD11   := (cAliastmp)->Matfuc
           cCodEqVd11  := (cAliastmp)->Codeqp
           lCkVD11     := .T.

        ElseIf IndVDir == 12
         
           cCorVDir12  := (cAliastmp)->Nome
           cCargVD12   := (cAliastmp)->Cargo
           nVlrVDir12  := (cAliastmp)->totcol
           cMatFVD12   := (cAliastmp)->Matfuc
           cCodEqVd12  := (cAliastmp)->Codeqp   
           lCkVD12     := .T.

        ElseIf IndVDir == 13

           cCorVDir13  := (cAliastmp)->Nome
           cCargVD13   := (cAliastmp)->Cargo
           nVlrVDir13  := (cAliastmp)->totcol
           cMatFVD13   := (cAliastmp)->Matfuc
           cCodEqVd13  := (cAliastmp)->Codeqp
           lCkVD13     := .T.

        ElseIf IndVDir == 14
         
           cCorVDir14  := (cAliastmp)->Nome
           cCargVD14   := (cAliastmp)->Cargo
           nVlrVDir14  := (cAliastmp)->totcol
           cMatFVD14   := (cAliastmp)->Matfuc
           cCodEqVd14  := (cAliastmp)->Codeqp
           lCkVD14     := .T.

        EndIf      

    Elseif substr((cAliastmp)->Codeqp,1,1) == 'C'
        
        If  IndVInt    == 1

            cCorInt1   := (cAliastmp)->Nome
            cCargInt1  := (cAliastmp)->Cargo
            nVlrInt1   := (cAliastmp)->totcol
            cMatFInt1  := (cAliastmp)->Matfuc
            cCodEqIt1 := (cAliastmp)->Codeqp
            lCkCI1     :=.T.

        ElseIf  IndVInt    == 2

            cCorInt2   := (cAliastmp)->Nome
            cCargInt2  := (cAliastmp)->Cargo
            nVlrInt2   := (cAliastmp)->totcol            
            cMatFInt2  := (cAliastmp)->Matfuc
            cCodEqIt2 := (cAliastmp)->Codeqp
            lCkCI2     :=.T.

        ElseIf  IndVInt    == 3

            cCorInt3   := (cAliastmp)->Nome
            cCargInt3  := (cAliastmp)->Cargo
            nVlrInt3   := (cAliastmp)->totcol            
            cMatFInt3  := (cAliastmp)->Matfuc
            cCodEqIt3 := (cAliastmp)->Codeqp
            lCkCI3     :=.T.

        ElseIf  IndVInt    == 4

            cCorInt4   := (cAliastmp)->Nome
            cCargInt4  := (cAliastmp)->Cargo
            nVlrInt4   := (cAliastmp)->totcol            
            cMatFInt4  := (cAliastmp)->Matfuc
            cCodEqIt4 := (cAliastmp)->Codeqp
            lCkCI4     :=.T.

        ElseIf  IndVInt    == 5

            cCorInt5   := (cAliastmp)->Nome
            cCargInt5  := (cAliastmp)->Cargo
            nVlrInt5   := (cAliastmp)->totcol
            cMatFInt5  := (cAliastmp)->Matfuc
            cCodEqIt5 := (cAliastmp)->Codeqp
            lCkCI5     :=.T.

        ElseIf  IndVInt    == 6

            cCorInt6   := (cAliastmp)->Nome
            cCargInt6  := (cAliastmp)->Cargo
            nVlrInt6   := (cAliastmp)->totcol            
            cMatFInt6  := (cAliastmp)->Matfuc
            cCodEqIt6  := (cAliastmp)->Codeqp
            lCkCI6     :=.T.
            
        ElseIf  IndVInt    == 7

            cCorInt7   := (cAliastmp)->Nome
            cCargInt7  := (cAliastmp)->Cargo
            nVlrInt7   := (cAliastmp)->totcol            
            cMatFInt7  := (cAliastmp)->Matfuc
            cCodEqIt7 := (cAliastmp)->Codeqp
            lCkCI7     :=.T.
            
        ElseIf  IndVInt    == 8

            cCorInt8   := (cAliastmp)->Nome
            cCargInt8  := (cAliastmp)->Cargo
            nVlrInt8   := (cAliastmp)->totcol            
            cMatFInt8  := (cAliastmp)->Matfuc
            cCodEqIt8  := (cAliastmp)->Codeqp
            lCkCI8     :=.T.
            
        ElseIf  IndVInt    == 9

            cCorInt9   := (cAliastmp)->Nome
            cCargInt9  := (cAliastmp)->Cargo
            nVlrInt9   := (cAliastmp)->totcol
            cMatFInt9  := (cAliastmp)->Matfuc
            cCodEqIt9  := (cAliastmp)->Codeqp            
            lCkCI9     :=.T.
            
        ElseIf  IndVInt    == 10

            cCorInt10   := (cAliastmp)->Nome
            cCargInt10  := (cAliastmp)->Cargo
            nVlrInt10   := (cAliastmp)->totcol            
            cMatFInt10  := (cAliastmp)->Matfuc
            cCodEqIt10  := (cAliastmp)->Codeqp            
            lCkCI10     :=.T.
            
        ElseIf  IndVInt    == 11

            cCorInt11   := (cAliastmp)->Nome
            cCargInt11  := (cAliastmp)->Cargo
            nVlrInt11   := (cAliastmp)->totcol                
            cMatFInt11  := (cAliastmp)->Matfuc
            cCodEqIt11  := (cAliastmp)->Codeqp            
            lCkCI11     :=.T.
            
        ElseIf  IndVInt    == 12

            cCorInt12   := (cAliastmp)->Nome
            cCargInt12  := (cAliastmp)->Cargo
            nVlrInt12   := (cAliastmp)->totcol            
            cMatFInt12  := (cAliastmp)->Matfuc
            cCodEqIt12  := (cAliastmp)->Codeqp            
            lCkCI12     :=.T.
            
        ElseIf  IndVInt    == 13

            cCorInt13   := (cAliastmp)->Nome
            cCargInt13  := (cAliastmp)->Cargo
            nVlrInt13   := (cAliastmp)->totcol            
            cMatFInt13  := (cAliastmp)->Matfuc
            cCodEqIt13  := (cAliastmp)->Codeqp            
            lCkCI13     :=.T.
            
        ElseIf  IndVInt    == 14

            cCorInt14   := (cAliastmp)->Nome
            cCargInt14  := (cAliastmp)->Cargo
            nVlrInt14   := (cAliastmp)->totcol
            cMatFInt14  := (cAliastmp)->Matfuc
            cCodEqIt14  := (cAliastmp)->Codeqp            
            lCkCI14     :=.T.
              
        EndIf 
    
    EndIf

        nQtdaCol   := nQtdaCol+1
        nVlrTot    += (cAliastmp)->totcol

        (cAliastmp)->(DbSkip())

	Enddo	

////////
// acumula por bloqueio 

cQuery :=       " select Pdu_Codeqp Codeqp , " 
cQuery += CRLF+ "        Pdu_Matfuc Matfuc , "
cQuery += CRLF+ "        Pdu_Nome  Nome    , "
cQuery += CRLF+ "        pdx_cargo cargo   , "
cQuery += CRLF+ "        pdu_verba verba   , "
cQuery += CRLF+ "        pdx_ccusto ccusto ,pdu_codemp codemp ,nvl(pdu_statu1,' ') statu1, nvl(pdu_statu2,' ') statu2 , nvl(pdu_statu3,' ') statu3 , " 
cQuery += CRLF+ "        CASE WHEN SUBSTR(Pdu_Codeqp,1,1)= 'X' THEN 'EX' " 
cQuery += CRLF+ "             WHEN SUBSTR(Pdu_Codeqp,1,1)= 'E' THEN 'DI' "
cQuery += CRLF+ "             WHEN SUBSTR(Pdu_Codeqp,1,1)= 'C' THEN 'IN' "
cQuery += CRLF+ "        ELSE 'N/I ' END TPDOC , "
//cQuery += CRLF+ "        PDU_COMPTE COMPTE , "
cQuery += CRLF+ "        Sum(Pdu_Vlrpgt) totcol ,  "
cQuery += CRLF+ "        substr(pdu_aprov1,1,8)aprov1 ,"
cQuery += CRLF+ "        substr(pdu_aprov2,1,8)aprov2 ,"
cQuery += CRLF+ "        substr(pdu_aprov3,11,8)aprov3  "
cQuery += CRLF+ "   From Pdu010 Pdu , Sra010 Sra , pdx010 pdx " 
cQuery += CRLF+ "  Where Pdu_Filial = ' ' "
cQuery += CRLF+ "   And Pdu.D_E_L_E_T_ = ' ' " 
cQuery += CRLF+ "   And Ra_Filial ='01' "
cQuery += CRLF+ "   And Sra.D_E_L_E_T_ = ' ' " 
cQuery += CRLF+ "   And Pdx_Filial = ' ' " 
cQuery += CRLF+ "   And Pdx.D_E_L_E_T_ = ' ' "
cQuery += CRLF+ "   And Pdu_Pgto = 'N' "

cQuery += CRLF+ "      and (PDX.PDX_PARINI = ' ' and 1=1" 
cQuery += CRLF+ "       or (PDX.PDX_PARINI <> ' ' and pdu_numpar >=  PDX.PDX_PARINI and pdu_numpar <=  PDX.PDX_PARFIM))"
                    
cQuery += CRLF+ "   and substr(pdx_datini,1,6) <= PDU_COMPTE " 
cQuery += CRLF+ "   and substr(pdx_datFim,1,6) <> ' ' "

cQuery += CRLF+ "   and Pdx_codigo = Pdu_Codeqp "
cQuery += CRLF+ "   and Pdx_matfuc = Pdu_Matfuc "
cQuery += CRLF+ "   And Ra_Mat = Pdu_Matfuc "

cQuery += CRLF+ "     and PDU_STATUS  <>  'X' "


If _cIdUsuar == cAproN3
//   cQuery += CRLF+ "     and PDU_STATU2  = 'A'   "
   cQuery += CRLF+ "     and PDU_STATU3  = ' '   "
//   cQuery += CRLF+ "     and PDU_STATUS  = 'A'   "
   
ElseIf _cIdUsuar == '000026'
//   cQuery += CRLF+ "     and PDU_STATU3  = 'A'   "
   cQuery += CRLF+ "     and PDU_STATU4  = ' '   "
//   cQuery += CRLF+ "     and PDU_STATUS  = 'A'   "
   
EndIf    

cQuery += CRLF+ "     and PDU_PGTO    = 'N'   "

cQuery += CRLF+ "     AND ((pdu_statu1 = 'S' AND SUBSTR(PDU_DTAPRO,1,6) >='"+CANO+CMES+"') "
cQuery += CRLF+ "     OR pdu_statu1 = 'A')"

cQuery += CRLF+ "   And Ra_Demissa = ' '  "
cQuery += CRLF+ " Group By Pdu_Codeqp , Pdu_Matfuc , Pdu_Nome , pdx_cargo , pdu_verba , pdx_ccusto , pdu_codemp ,pdu_statu1 , pdu_statu2 ,pdu_statu3 ,"
cQuery += CRLF+ "       CASE WHEN SUBSTR(Pdu_Codeqp,1,1)= 'X' THEN 'EX' "
cQuery += CRLF+ "            WHEN SUBSTR(Pdu_Codeqp,1,1)= 'E' THEN 'DI' "
cQuery += CRLF+ "            WHEN SUBSTR(Pdu_Codeqp,1,1)= 'C' THEN 'IN' "
cQuery += CRLF+ "       ELSE 'N/I ' END  ,"
cQuery += CRLF+ "        substr(pdu_aprov1,1,8) ,"
cQuery += CRLF+ "        substr(pdu_aprov2,1,8) ,"
cQuery += CRLF+ "        substr(pdu_aprov3,11,8)  "
//cQuery += CRLF+ "           , PDU_COMPTE  "
cQuery += CRLF+ " Order By Pdu_Codeqp  ,Pdu_Matfuc , Pdu_Nome, Sum(Pdu_Vlrpgt) " 

If Select((cAliastmp)) <> 0 

   (cAliastmp)->(DbCloseArea())  

Endif                  
  
TCQuery cQuery New Alias (cAliastmp)   

(cAliastmp)->( DbGoTop() )  

While !(cAliastmp)->(Eof())

If (cAliastmp)->statu1 = 'A'
   
   nqtdAprN1 := nqtdAprN1 + 1 
   nVlrAprN1 := nVlrAprN1 + (cAliastmp)->totcol

ELSEIf (cAliastmp)->statu1 = 'B'   

   nVlrBloN1 := nVlrBloN1 + (cAliastmp)->totcol
   nqtdBloN1 := nqtdBloN1 + 1

ELSEIf (cAliastmp)->statu1 = 'B'   

   nVlrDefN1 := nVlrDefN1 + (cAliastmp)->totcol
   nqtdDefN1 := nqtdDefN1 + 1

ELSEIf (cAliastmp)->statu1 = 'S'   

   nVlrSinN1 := nVlrSinN1 + (cAliastmp)->totcol
   nqtdSinN1 := nqtdSinN1 + 1

EndIf 

If (cAliastmp)->statu1 != ' '

    nVlrTotN1 := nVlrTotN1 + (cAliastmp)->totcol
    nqtdTotN1 := nqtdTotN1 + 1 

EndIf  

If (cAliastmp)->statu2 = 'A'
   
   nqtdAprN2 := nqtdAprN2 + 1 
   nVlrAprN2 := nVlrAprN2 + (cAliastmp)->totcol

ELSEIf (cAliastmp)->statu2 = 'B'   

   nVlrBloN2 := nVlrBloN2 + (cAliastmp)->totcol
   nqtdBloN2 := nqtdBloN2 + 1

ELSEIf (cAliastmp)->statu2 = 'B'   

   nVlrDefN2 := nVlrDefN2 + (cAliastmp)->totcol
   nqtdDefN2 := nqtdDefN2 + 1

ELSEIf (cAliastmp)->statu2 = 'S'   

   nVlrSinN2 := nVlrSinN2 + (cAliastmp)->totcol
   nqtdSinN2 := nqtdSinN2 + 1

EndIf 

If (cAliastmp)->statu2 != ' '

    nVlrTotN2 := nVlrTotN2 + (cAliastmp)->totcol
    nqtdTotN2 := nqtdTotN2 + 1 

EndIf  


If (cAliastmp)->statu3 = 'A'
   
   nqtdAprN3 := nqtdAprN3 + 1 
   nVlrAprN3 := nVlrAprN3 + (cAliastmp)->totcol

ELSEIf (cAliastmp)->statu3 = 'B'   

   nVlrBloN3 := nVlrBloN3 + (cAliastmp)->totcol
   nqtdBloN3 := nqtdBloN3 + 1

ELSEIf (cAliastmp)->statu3 = 'B'   

   nVlrDefN3 := nVlrDefN3 + (cAliastmp)->totcol
   nqtdDefN3 := nqtdDefN3 + 1

ELSEIf (cAliastmp)->statu3 = 'S'   

   nVlrSinN3 := nVlrSinN3 + (cAliastmp)->totcol
   nqtdSinN3 := nqtdSinN3 + 1

EndIf 

If (cAliastmp)->statu3 != ' '

    nVlrTotN3 := nVlrTotN3 + (cAliastmp)->totcol
    nqtdTotN3 := nqtdTotN3 + 1 

EndIf  

If empty(CAPROV1)
   CAPROV1      := (cAliastmp)->aprov1
EndIf    
If empty(CAPROV2)
   CAPROV2      := (cAliastmp)->aprov2 
EndIf    
If empty(CAPROV3)
   CAPROV3      := (cAliastmp)->aprov3
EndIF 

(cAliastmp)->(DbSkip())

Enddo

nPerAprN1 := (nVlrAprN1 / nVlrTotN1 ) * 100
nPerBlqN1 := (nVlrBloN1 / nVlrTotN1 ) * 100
nPerDefN1 := (nVlrDefN1 / nVlrTotN1 ) * 100
nPerSinN1 := (nVlrSinN1 / nVlrTotN1 ) * 100
nPerTotN1 := 100.00

nPerAprN2 := (nVlrAprN2 / nVlrTotN2 ) * 100
nPerBlqN2 := (nVlrBloN2 / nVlrTotN2 ) * 100
nPerDefN2 := (nVlrDefN2 / nVlrTotN2 ) * 100
nPerSinN2 := (nVlrSinN2 / nVlrTotN2 ) * 100
nPerTotN2 := 100.00

nPerAprN3 := (nVlrAprN3 / nVlrTotN3 ) * 100
nPerBlqN3 := (nVlrBloN3 / nVlrTotN3 ) * 100
nPerDefN3 := (nVlrDefN3 / nVlrTotN3 ) * 100
nPerSinN3 := (nVlrSinN3 / nVlrTotN3 ) * 100
nPerTotN3 := 100.00

Return (ret)

//////////////////////////////////////

Static Function fLanca1()

If  lCkCI1  
    fLanca(cMatFInt1, cCodEqIt1)  
EndIf
If  lCkCI2  
    fLanca(cMatFInt2, cCodEqIt2)  
EndIf
If  lCkCI3  
    fLanca(cMatFInt3, cCodEqIt3)
  EndIf
If  lCkCI4  
    fLanca(cMatFInt4, cCodEqIt4)  
EndIf
If  lCkCI5  
    fLanca(cMatFInt5, cCodEqIt5)  
EndIf
If  lCkCI6  
    fLanca(cMatFInt6, cCodEqIt6)  
EndIf
If  lCkCI7  
    fLanca(cMatFInt7, cCodEqIt7)  
EndIf
If  lCkCI8  
    fLanca(cMatFInt8, cCodEqIt8)  
EndIf
If  lCkCI9  
    fLanca(cMatFInt9, cCodEqIt9)  
EndIf
If  lCkCI10 
    fLanca(cMatFInt10, cCodEqIt10) 
EndIf
If  lCkCI11 
    fLanca(cMatFInt11, cCodEqIt11) 
EndIf
If  lCkCI12 
    fLanca(cMatFInt12, cCodEqIt12) 
EndIf
If  lCkCI13 
    fLanca(cMatFInt13, cCodEqIt13) 
EndIf
If  lCkCI14 
    fLanca(cMatFInt14, cCodEqIt14) 
EndIf


If  lCkEC1 
    fLanca(cMatFExc1, cCodEqEc1)   
EndIf
If  lCkEC2 
    fLanca(cMatFExc2, cCodEqEc2)   
EndIf
If  lCkEC3 
    fLanca(cMatFExc3, cCodEqEc3)   
EndIf
If  lCkEC4 
    fLanca(cMatFExc4, cCodEqEc4)   
EndIf
If  lCkEC5 
    fLanca(cMatFExc5, cCodEqEc5)   
EndIf
If  lCkEC6 
    fLanca(cMatFExc6, cCodEqEc6)   
EndIf
If  lCkEC7 
    fLanca(cMatFExc7, cCodEqEc7)   
EndIf
If  lCkEC8 
    fLanca(cMatFExc8, cCodEqEc8)   
EndIf
If  lCkEC9 
    fLanca(cMatFExc9, cCodEqEc9)   
EndIf
If  lCkEC10 
    fLanca(cMatFExc10, cCodEqEc10) 
EndIf
If  lCkEC11 
    fLanca(cMatFExc11, cCodEqEc11) 
EndIf
If  lCkEC12 
    fLanca(cMatFExc12, cCodEqEc12) 
EndIf
If  lCkEC13 
    fLanca(cMatFExc13, cCodEqEc13) 
EndIf
If  lCkEC14 
    fLanca(cMatFExc14, cCodEqEc14) 
EndIf

If  lCkVD1  
    fLanca(cMatFVD1, cCodEqVd1)   
EndIf
If  lCkVD2  
    fLanca(cMatFVD2, cCodEqVd2)   
EndIf
If  lCkVD3  
    fLanca(cMatFVD3, cCodEqVd3)   
EndIf
If  lCkVD4  
    fLanca(cMatFVD4, cCodEqVd4)   
EndIf
If  lCkVD5  
    fLanca(cMatFVD5, cCodEqVd5)   
EndIf
If  lCkVD6  
    fLanca(cMatFVD6, cCodEqVd6)   
EndIf
If  lCkVD7  
    fLanca(cMatFVD7, cCodEqVd7)   
EndIf
If  lCkVD8   
    fLanca(cMatFVD8, cCodEqVd8)   
EndIf
If  lCkVD9  
    fLanca(cMatFVD9, cCodEqVd9)   
EndIf
If  lCkVD10 
    fLanca(cMatFVD10, cCodEqVd10)  
EndIf
If  lCkVD11
    fLanca(cMatFVD11, cCodEqVd11)  
EndIf
If  lCkVD12 
    fLanca(cMatFVD12, cCodEqVd12)  
EndIf
If  lCkVD13 
    fLanca(cMatFVD13, cCodEqVd13)
EndIf
If  lCkVD14
    fLanca(cMatFVD14, cCodEqVd14)  
EndIf

Return()

Static Function fLanca(cMatfunc , cEquipe)

local  cQuery1  := " "   

  // FGrvSRK()

cQuery1 :=       "   Select pdu.R_E_C_N_O_ pdurec "  
cQuery1 += CRLF+ "     From Pdu010 Pdu , pdx010 pdx , Sra010 Sra"
cQuery1 += CRLF+ "    Where Pdu_Filial = ' ' "
cQuery1 += CRLF+ "      And Pdu.D_E_L_E_T_ = ' ' " 
cQuery1 += CRLF+ "      And Pdx_Filial =' ' "
cQuery1 += CRLF+ "      And pdx.D_E_L_E_T_ = ' ' " 
cQuery1 += CRLF+ "      And Pdu_Pgto = 'N' "
cQuery1 += CRLF+ "      and pdx_codigo = pdu_codeqp "
cQuery1 += CRLF+ "      And pdx_Matfuc = Pdu_Matfuc " 
//cQuery1 += CRLF+ "     And pdx_datfim = ' ' " 
cQuery1 += CRLF+ "      And Ra_Mat = Pdu_Matfuc " 
cQuery1 += CRLF+ "      And Ra_Demissa = ' ' "

//cQuery1 += CRLF+ "      and (pdx_parini= ' ' and 1=1 " 
//cQuery1 += CRLF+ "       or (pdx_parini= ' ' <> ' ' and pdu_numpar >=  PDX.PDX_PARINI and pdu_numpar <=  PDX.PDX_PARFIM)) "

cQuery1 += CRLF+ "     And Pdu_Matfuc = '"+cMatfunc+"'"
cQuery1 += CRLF+ "     And Pdu_codeqp = '"+cEquipe+"'"

cQuery1 += CRLF+ "      and (PDX.PDX_PARINI = ' ' and 1=1" 
cQuery1 += CRLF+ "       or (PDX.PDX_PARINI <> ' ' and pdu_numpar >=  PDX.PDX_PARINI and pdu_numpar <=  PDX.PDX_PARFIM))"


cQuery1 += CRLF+ "     and PDU_STATUS  In ('A','S')   "
cQuery1 += CRLF+ "     and PDU_STATU2  = 'A'   "
//cQuery1 += CRLF+ "     and (PDU_STATU2  = 'A' OR PDU_STATU1  = 'S') "    
If  _cIdUsuar == cAproN3
   cQuery1 += CRLF+ "     and PDU_STATU3  = ' '   "

Elseif _cIdUsuar == cAproN4
   cQuery1 += CRLF+ "     and PDU_STATU4  = ' '   "

EndIF 

cQuery1 += CRLF+ "     and PDU_PGTO    = 'N'   "

If Select((cAliastmp1)) <> 0 

   (cAliastmp1)->(DbCloseArea())  

Endif                  
  
TCQuery cQuery1 New Alias (cAliastmp1)   

(cAliastmp1)->( DbGoTop() )  

dbselectarea("PDU")

While !(cAliastmp1)->(Eof())

    Dbgoto((cAliastmp1)->pdurec)


        RecLock("PDU",.F.)     

        If  _cIdUsuar == cAproN4
            
            If  PDU_STATUS  == 'A' 
   	            PDU_PGTO    := 'S'
                PDU_PGTFOL  := "Aprovador : "+_cIdUsuar +' - ' +_cUsuario + " Em  " +cDthr         
            ElseIf PDU_STATUS  == 'S'
  	            PDU_PGTO        := 'C'
            EndIf 
        
        EndIf     

//        PDU_PGTFOL      := "Aprovador : "+_cIdUsuar +' - ' +_cUsuario + " Em  " +cDthr      

    If  _cIdUsuar == cAproN4
        If  PDU->PDU_STATU3 == 'A'
            PDU->PDU_STATU4 := 'A'
            PDU->PDU_APROV4 := "Usuario : " +_cUsuario + "- Aprovação Em " +cDthr 
        EndIf 
    ElseIf  _cIdUsuar == cAproN3

        PDU->PDU_STATU3 := 'A'
        PDU->PDU_APROV3 := "Usuario : " +_cUsuario + "- Aprovação Em " +cDthr 
 
    EndIF         

    PDU->PDU_DTAPRO := Date()

    PDU->(MsUnLock())    

   (cAliastmp1)->(DbSkip())

EndDo

return()

static Function fBusAlc(cAlc)

Local cQryPEG	:= ""
Local cAliasPEG	:= GetNextAlias()

cQryPEG := CRLF + "       SELECT AK_USER , AK_NOME, AL_COD , AL_DESC , AL_LIBAPR , AL_USERSUP , AK_LIMMIN ,AK_LIMMAX , AL_NIVEL nivel"  
cQryPEG += CRLF + "         FROM "+RetSQLName("SAL")+" SAL , "
cQryPEG += CRLF + "              "+RetSQLName("SAK")+" SAK   "
cQryPEG += CRLF + "        WHERE AL_FILIAL  = '" + xFilial('SAL') + "'  AND SAL.D_E_L_E_T_ = ' ' " 
cQryPEG += CRLF + "          AND AK_FILIAL  = '" + xFilial('SAK') + "'  AND SAK.D_E_L_E_T_ = ' ' "
cQryPEG += CRLF + "          AND AL_COD = '"+cAlc+"' "
cQryPEG += CRLF + "          AND AK_COD = AL_APROV   "
cQryPEG += CRLF + "          order by NIVEL  "

TcQuery cQryPEG New Alias (cAliasPEG)  

(cAliasPEG)->(dbGoTop())    

While !(cAliasPEG)->(EOF())

	If trim((cAliasPEG)->nivel) == "1"
	    If  !empty(cAproN1)
	        cAproN1  +="|"
		EndIf 	
		cAproN1      += trim((cAliasPEG)->ak_user)
	Elseif   trim((cAliasPEG)->nivel) == "2"
	    If  !empty(cAproN2)
	        cAproN2  +="|"
		EndIf 	
		cAproN2      +=trim((cAliasPEG)->ak_user)
	Elseif   trim((cAliasPEG)->nivel) == "3"
	    If  !empty(cAproN3)
	        cAproN3  +="|"
		EndIf 	
		cAproN3      += trim((cAliasPEG)->ak_user)
	Elseif   trim((cAliasPEG)->nivel) == "4"
	    If  !empty(cAproN4)
	        cAproN4  +="|"
		EndIf 	
		cAproN4      += trim((cAliasPEG)->ak_user)
	EndIf 

	(cAliasPEG)->(DbSkip())

EndDo 

Return()
