#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'RWMAKE.CH'
#INCLUDE 'FONT.CH'
#INCLUDE 'COLORS.CH'
#include "TOPCONN.CH"
#define CRLF Chr(13) + Chr(10) 
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

User Function caba148(cMatr145, opc)     
/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±± Declaração de cVariable dos componentes                                 ±±
Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/
Private cASibAn    := Space(3)
Private cCodCco    := Space(1)
Private cDtBloq    := Space(1)
//Private cDtBloq    := Space(1)
Private cDtIncl    := Space(1)
Private cIAnsAn    := Space(3)
Private cIAnsAt    := Space(3)
Private cISibAn    := Space(3)
Private cISibAt    := Space(3)

Private cLocsibHist:= '0-HA ENVIAR' + CRLF + ;
                      '1-ATIVO ' + CRLF +     ;
                      '2-EXCLUIDO ' + CRLF +   ;
                      '3-ENVIADO INCLUSAO ' + CRLF +   ;
                      '4-ENVIADO ALTERACAO ' + CRLF +   ;
                      '5-ENVIADO EXCLUSAO ' + CRLF +   ;
                      '6-FORCAR INCLUSAO ' + CRLF +    ;
                      '7-FORCAR ALTERACAO ' + CRLF +   ;
                      '8-FORCAR EXCLUSAO ' + CRLF +    ;
                      '9-MUDANCA CONTRATUAL ' + CRLF + ;
                      'A-REATIVACAO ' + CRLF  +        ;
                      'B-FORCAR MUD. CONTR ' + CRLF +  ;
                      'C-FORCAR REATIVACAO ' + CRLF  
                      
private chist1:=      '___________________________________________'+ CRLF  + ;  
                      ' ** Só Serão Enviados se TODAS as Variaveis'+ CRLF  + ;
                      'InfAns ,InfSib , AtuSib estiverem como Sim '+ CRLF  + ;
                      '(Informa ANS)InfAns ,(Informa SIB) InfSib ,'+ CRLF  + ;
                      '(Atualiza SIB)'+ CRLF

Private cLSibAn    := Space(1)
Private cMatric    := cMatr145
Private cMotblo    := Space(1)
Private cCritOpe   := Space(1)
Private cCritANS   := Space(1)
Private cNomUsr    := Space(1)
Private nASibAt   
Private nLSibAt  

private PD7USUARIO := SubStr(cUSUARIO,7,15) 
private PD7DTHR    := Dtoc(dDataBase) + " " + StrTran(Time(),':','')
Private cQuery     := " "      
Private cQuery1    := " "  
Private cQuery2    := " " 
Private cQuery3    := " "  
Private cQuery4    := " " 
Private cAliastmp  := GetNextAlias()   
Private cAliastmp1 := GetNextAlias()    
Private cAliastmp2 := GetNextAlias()  
Private cAliastmp3 := GetNextAlias()  
Private cAliastmp4 := GetNextAlias() 
private lAchou     := .F.
private cLocconf   := ' '      

Private cCodprod   := Space(1)
Private cCpfUser   := Space(1)
Private cDtatual   := Space(1)
Private cDtInclans := Space(1)
Private cSituacao  := Space(1)  
Private cDtCancel  := Space(1)
                                 
Private cLocSibAnt := Space(1) 
Private cTpAcao    := Space(1)
Private cTpEnvio   := Space(1)  
Private cCompte    := Space(1)
Private cDtGera    := Space(1)     
Private cDtEnvio   := Space(1)
Private cDtRetorno := Space(1)
Private cCritAnsp5 := Space(1)
Private cCritOpep5 := Space(1)
PRIVATE cSequenP5  := Space(1)  
Private cNivBloq   := Space(1)
private lSai       := .F.

PRIVATE cCompteseq := ' '        
private cUsuar148  := SubStr(cUSUARIO,7,15) 
/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±± Declaração de Variaveis Private dos Objetos                             ±±
Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/

SetPrvt("oDlg148","oPanel1","oSay1","oSay2","oSay11","oSay12","oSay13","oSay14","oSay15","oSay16","oGet1")
SetPrvt("oGrp1","oSay3","oSay5","oSay6","oSay7","oGet3","oGet4","oGet5","oGet6","oGrp2","oSay4","oSay10")
SetPrvt("oSay8","oCBox1","oGet9","oGet8","oCBox2","oGrp3","oMGet1","oGet10","oGet11","oGet12","oGet13")
SetPrvt("oBtn1","oBtn2","oBtn3","oGet7","oGet14","oGet2","oGrp4","oSay17","oSay18","oSay19","oSay20","oSay21")
SetPrvt("oGet15","oGet16","oGet17","oGet18","oGet19","oGet20","oGrp6","oSay23","oSay24","oSay26","oSay27")
SetPrvt("oSay29","oSay30","oSay25","oSay31","oGet21","oGet22","oGet24","oGet25","oGet26","oGet27","oGet28","oSay32","oSay32")
SetPrvt("oGet29","oGet30","oGet31","oSay33")

 /*  
oSay33     := TSay():New( 108,156,{||"Nivel Bloq"},oPanel1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,028,008) 
oSay12     := TSay():New( 108,077,{||"Data Bloqueio "},oPanel1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,036,008)
oGet31     := TGet():New( 120,156,{|u| If(PCount()>0,cNivBloq:=u,cNivBloq)},oPanel1,036,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cNivBloq",,)  
oGet11     := TGet():New( 120,077,{|u| If(PCount()>0,cDtBloq:=u,cDtBloq)},oPanel1,060,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cDtBloq",,)
  */

 
if Empty(cMatric)  
   cMatric:= space(17)
EndIf    

/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±± Definicao do Dialog e todos os seus componentes.                        ±±
Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/
/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±± Definicao do Dialog e todos os seus componentes.                        ±±
Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/
oDlg148     := MSDialog():New( 109,338,662,1050,"Manutenção Controles do SIB - ANS",,,.F.,,,,,,.T.,,,.T. )
oPanel1    := TPanel():New( 000,000," ",oDlg148,,.F.,.F.,,,348,204,.T.,.F. )
oGrp5      := TGroup():New( 004,212,032,344,"Opções ",oPanel1,CLR_RED,CLR_WHITE,.T.,.F. )
oBtn1      := TButton():New( 012,216,"Gravar",oGrp5,{||fgrava()},037,012,,,,.T.,,"",,,,.F. )
oBtn2      := TButton():New( 012,260,"Descartar",oGrp5,{||fDescatar()} ,037,012,,,,.T.,,"",,,,.F. )
oBtn3      := TButton():New( 012,304,"Sair",oGrp5,{||fsair()},037,012,,,,.T.,,"",,,,.F. )   
oSay1      := TSay():New( 004,004,{||"Matricula"},oPanel1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,028,008)
oSay2      := TSay():New( 004,144,{||"Codigo Cco"},oPanel1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay11     := TSay():New( 108,004,{||"Data Inclusao "},oPanel1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,036,008)   
oSay12     := TSay():New( 108,077,{||"Data Bloqueio "},oPanel1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,036,008)
//oSay12     := TSay():New( 108,109,{||"Data Bloqueio "},oPanel1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,036,008)
oSay13     := TSay():New( 136,004,{||"Motivo do Bloqueio"},oPanel1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,048,008)
oSay14     := TSay():New( 024,004,{||"Nome Usuario "},oPanel1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,040,008)    

oSay15     := TSay():New( 161,004,{||"Critica de Envio - Operadora / Camp. Retificados"},oPanel1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,120,008)
  
oSay16     := TSay():New( 182,004,{||"Critica de Envio - ANS"},oPanel1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,075,008)

oGet1      := TGet():New( 012,004,{|u| If(PCount()>0,cMatric:=u,cMatric)},oPanel1,076,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F., ,.F.,.F.,"BA1SIB","cMatric",,)
If !lSai   
  oGet1:bLostFocus:={|| fLerArq(cMatric)}   
EndIf     

oGet2      := TGet():New( 012,144,{|u| If(PCount()>0,cCodCco:=u,cCodCco)},oPanel1,060,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F., ,.T.,.F.,"","cCodCco",,)
oGrp1      := TGroup():New( 048,004,104,104,"Controles Anterior (De)",oPanel1,CLR_BLACK,CLR_WHITE,.T.,.F. )
oSay3      := TSay():New( 056,008,{||"LocSib Anterior"},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,056,008)
oSay5      := TSay():New( 076,008,{||"Informa Ans"},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay6      := TSay():New( 077,041,{||"Informa Sib"},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay7      := TSay():New( 077,073,{||"Atualiza sib"},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,027,008)
oGet3      := TGet():New( 064,008,{|u| If(PCount()>0,cLSibAn:=u,cLSibAn)},oGrp1,080,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cLSibAn",,)
oGet4      := TGet():New( 084,008,{|u| If(PCount()>0,cIAnsAn:=u,cIAnsAn)},oGrp1,028,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cIAnsAn",,)
oGet5      := TGet():New( 084,041,{|u| If(PCount()>0,cISibAn:=u,cISibAn)},oGrp1,028,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cISibAn",,)
oGet6      := TGet():New( 084,073,{|u| If(PCount()>0,cASibAn:=u,cASibAn)},oGrp1,028,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cASibAn",,)
oGrp2      := TGroup():New( 048,107,104,211,"Controles Atual (Para)",oPanel1,CLR_BLACK,CLR_WHITE,.T.,.F. )
oSay4      := TSay():New( 056,111,{||"LocSib Atual"},oGrp2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,056,008)
oSay10     := TSay():New( 076,111,{||"Informa Ans"},oGrp2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,028,008)
oSay9      := TSay():New( 076,143,{||"Informa Sib"},oGrp2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,028,008)
oSay8      := TSay():New( 076,175,{||"Atualiza sib"},oGrp2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,028,008)
oCBox1     := TComboBox():New( 064,113,{|u| If(PCount()>0,nLSibAt:=u,nLSibAt)},{" " , "0-HA ENVIAR ","1-ATIVO ","2-EXCLUIDO ","3-ENVIADO INCLUSAO  ","4-ENVIADO ALTERACAO ","5-ENVIADO EXCLUSAO ","6-FORCAR INCLUSAO ","7-FORCAR ALTERACAO","8-FORCAR EXCLUSAO","9-MUDANCA CONTRATUAL ","A-REATIVACAO ","B-FORCAR MUD. CONTR ","C-FORCAR REATIVACAO "},072,010,oGrp2,,,,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,,nLSibAt )

/*
oCBox1_0    := TComboBox():New( 076,114,{|u| If(PCount()>0,nLSibAt:=u,nLSibAt)},{"0-HA ENVIAR","6-FORCAR INCLUSAO"},072,010,oGrp2,,,,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,,nLSibAt ) 
oCBox1_1    := TComboBox():New( 076,114,{|u| If(PCount()>0,nLSibAt:=u,nLSibAt)},{"1-ATIVO","7-FORCAR ALTERACAO","8-FORCAR EXCLUSAO"},072,010,oGrp2,,,,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,,nLSibAt )
oCBox1_2    := TComboBox():New( 076,114,{|u| If(PCount()>0,nLSibAt:=u,nLSibAt)},{"2-EXCLUIDO","C-FORCAR REATIVACAO"},072,010,oGrp2,,,,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,,nLSibAt )
oCBox1_3    := TComboBox():New( 076,114,{|u| If(PCount()>0,nLSibAt:=u,nLSibAt)},{"3-ENVIADO INCLUSAO"},072,010,oGrp2,,,,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,,nLSibAt )
oCBox1_4    := TComboBox():New( 076,114,{|u| If(PCount()>0,nLSibAt:=u,nLSibAt)},{"4-ENVIADO ALTERACAO"},072,010,oGrp2,,,,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,,nLSibAt )
oCBox1_5    := TComboBox():New( 076,114,{|u| If(PCount()>0,nLSibAt:=u,nLSibAt)},{"5-ENVIADO EXCLUSAO"},072,010,oGrp2,,,,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,,nLSibAt ) 
oCBox1_6    := TComboBox():New( 076,114,{|u| If(PCount()>0,nLSibAt:=u,nLSibAt)},{"6-FORCAR INCLUSAO",0-HA ENVIAR"},072,010,oGrp2,,,,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,,nLSibAt ) 
oCBox1_7    := TComboBox():New( 076,114,{|u| If(PCount()>0,nLSibAt:=u,nLSibAt)},{"7-FORCAR ALTERACAO","1-ATIVO"},072,010,oGrp2,,,,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,,nLSibAt )
oCBox1_8    := TComboBox():New( 076,114,{|u| If(PCount()>0,nLSibAt:=u,nLSibAt)},{"8-FORCAR EXCLUSAO","1-ATIVO"},072,010,oGrp2,,,,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,,nLSibAt )
oCBox1_9    := TComboBox():New( 076,114,{|u| If(PCount()>0,nLSibAt:=u,nLSibAt)},{"9-MUDANCA CONTRATUAL"},072,010,oGrp2,,,,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,,nLSibAt )
oCBox1_a    := TComboBox():New( 076,114,{|u| If(PCount()>0,nLSibAt:=u,nLSibAt)},{"A-REATIVACAO"},072,010,oGrp2,,,,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,,nLSibAt )
oCBox1_b    := TComboBox():New( 076,114,{|u| If(PCount()>0,nLSibAt:=u,nLSibAt)},{"B-FORCAR MUD. CONTR","1-ATIVO"},072,010,oGrp2,,,,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,,nLSibAt ) 
oCBox1_c    := TComboBox():New( 076,114,{|u| If(PCount()>0,nLSibAt:=u,nLSibAt)},{"C-FORCAR REATIVACAO","2-EXCLUIDO"},072,010,oGrp2,,,,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,,nLSibAt )
*/

oGet9      := TGet():New( 084,111,{|u| If(PCount()>0,cIAnsAt:=u,cIAnsAt)},oGrp2,028,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cIAnsAt",,)
oGet8      := TGet():New( 084,143,{|u| If(PCount()>0,cISibAt:=u,cISibAt)},oGrp2,028,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cISibAt",,)
oCBox2     := TComboBox():New( 084,175,{|u| If(PCount()>0,nASibAt:=u,nASibAt)},{"Sim","Nao"},032,010,oGrp2,,,,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,,nASibAt )
If !lSai
   oCBox2:bLostFocus:={|| fFazpara()}   
EndIf   
oGrp3      := TGroup():New( 036,212,140,344,"Nota(s) Esplicativa(s) - LocSib Possiveis  ",oPanel1,CLR_RED,CLR_WHITE,.T.,.F. )
oMGet1     := TMultiGet():New( 044,216,{|u| If(PCount()>0,cLocsibHist:=u,cLocsibHist)},oGrp3,124,088,,,CLR_BLACK,CLR_WHITE,,.T.,"",,,.F.,.F.,.T.,,,.F.,,  )
oGet10     := TGet():New( 120,004,{|u| If(PCount()>0,cDtIncl:=u,cDtIncl)},oPanel1,060,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cDtIncl",,) 
oGet11     := TGet():New( 120,077,{|u| If(PCount()>0,cDtBloq:=u,cDtBloq)},oPanel1,060,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cDtBloq",,)
//oGet11     := TGet():New( 120,109,{|u| If(PCount()>0,cDtBloq:=u,cDtBloq)},oPanel1,060,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cDtBloq",,)
oGet12     := TGet():New( 144,004,{|u| If(PCount()>0,cMotblo:=u,cMotblo)},oPanel1,340,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cMotblo",,)
oGet13     := TGet():New( 036,004,{|u| If(PCount()>0,cNomUsr:=u,cNomUsr)},oPanel1,204,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cNomUsr",,)


oGet7      := TGet():New( 169,004,{|u| If(PCount()>0,cCritOpe:=u,cCritOpe)},oPanel1,340,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cCritOpe",,)
oGet14     := TGet():New( 190,004,{|u| If(PCount()>0,cCritANS:=u,cCritANS)},oPanel1,340,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cCritANS",,)

oGrp4      := TGroup():New( 206,000,238,348,"Dados ANS",oDlg148,CLR_RED,CLR_WHITE,.T.,.F. )
oSay17     := TSay():New( 214,004,{||"Situação "},oGrp4,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay18     := TSay():New( 214,064,{||"Dt Ultima Atua. "},oGrp4,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,044,008)
oSay19     := TSay():New( 214,173,{||"Cod Produto"},oGrp4,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,047,008)
oSay20     := TSay():New( 214,117,{||" Data Inclusão "},oGrp4,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,044,008)
oSay21     := TSay():New( 214,226,{||"Cpf Usuario"},oGrp4,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay22     := TSay():New( 214,293,{||"Data Cancel "},oGrp4,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,044,008)
oGet15     := TGet():New( 222,004,{|u| If(PCount()>0,cSituacao:=u,cSituacao)},oGrp4,052,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cSituacao",,)
oGet16     := TGet():New( 222,062,{|u| If(PCount()>0,cDtatual:=u,cDtatual)},oGrp4,048,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cDtatual",,)
oGet17     := TGet():New( 222,171,{|u| If(PCount()>0,cCodprod:=u,cCodprod)},oGrp4,048,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cCodprod",,)
oGet18     := TGet():New( 222,117,{|u| If(PCount()>0,cDtInclans:=u,cDtInclans)},oGrp4,048,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cDtInclans",,)
oGet19     := TGet():New( 222,226,{|u| If(PCount()>0,cCpfUser:=u,cCpfUser)},oGrp4,060,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cCpfUser",,)
oGet20     := TGet():New( 222,292,{|u| If(PCount()>0,cDtCancel:=u,cDtCancel)},oGrp4,048,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cDtCancel",,)
oGrp6      := TGroup():New( 238,000,269,349,"Dados Ultimo Envio",oDlg148,CLR_RED,CLR_WHITE,.T.,.F. )      

oSay23     := TSay():New( 246,004,{||"Tp Acao "},oGrp6,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,024,008)
oSay24     := TSay():New( 246,063,{||"Compte"},oGrp6,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,021,008)
oSay26     := TSay():New( 246,112,{||"Data Geraçao"},oGrp6,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,036,008)
oSay27     := TSay():New( 246,252,{||"Crit Oper"},oGrp6,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,024,008)
oSay28     := TSay():New( 246,153,{||"Data Envio"},oGrp6,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,044,008)
oSay29     := TSay():New( 247,029,{||"Tp Envio"},oGrp6,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,024,008)
oSay30     := TSay():New( 247,206,{||"Data Retorno"},oGrp6,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,044,008)
oSay25     := TSay():New( 247,281,{||"Crit ANS"},oGrp6,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,023,008)
oSay31     := TSay():New( 247,306,{||"Loc Sib  Ant Env"},oGrp6,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,042,008)
oSay32     := TSay():New( 246,092,{||"Seq"},oGrp6,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,012,008)


/*
oSay23     := TSay():New( 246,004,{||"Tp Acao "},oGrp6,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,024,008)
oSay24     := TSay():New( 246,068,{||"Compte"},oGrp6,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,028,008)
oSay26     := TSay():New( 246,096,{||"Data Geraçao"},oGrp6,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,036,008)
oSay27     := TSay():New( 246,248,{||"Crit Oper"},oGrp6,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,024,008)
oSay28     := TSay():New( 246,141,{||"Data Envio"},oGrp6,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,044,008)
oSay29     := TSay():New( 247,033,{||"Tp Envio"},oGrp6,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,024,008)
oSay30     := TSay():New( 247,194,{||"Data Retorno"},oGrp6,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,044,008)
oSay25     := TSay():New( 247,277,{||"Crit ANS"},oGrp6,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,023,008)
oSay31     := TSay():New( 247,306,{||"Loc Sib  Ant Env"},oGrp6,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,042,008)
*/

oGet21     := TGet():New( 254,002,{|u| If(PCount()>0,cTpAcao:=u,cTpAcao)},oGrp6,024,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cTpAcao",,)
oGet22     := TGet():New( 254,062,{|u| If(PCount()>0,cCompte:=u,cCompte)},oGrp6,024,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cCompte",,)
oGet24     := TGet():New( 254,111,{|u| If(PCount()>0,cDtGera:=u,cDtGera)},oGrp6,040,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cDtGera",,)
oGet25     := TGet():New( 254,253,{|u| If(PCount()>0,cCritOpep5:=u,cCritOpep5)},oGrp6,024,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cCritOpep5",,)
oGet26     := TGet():New( 254,154,{|u| If(PCount()>0,cDtEnvio:=u,cDtEnvio)},oGrp6,047,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cDtEnvio",,)
oGet27     := TGet():New( 254,029,{|u| If(PCount()>0,cTpEnvio:=u,cTpEnvio)},oGrp6,031,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cTpEnvio",,)
oGet28     := TGet():New( 254,203,{|u| If(PCount()>0,cDtRetorno:=u,cDtRetorno)},oGrp6,046,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cDtRetorno",,)
oGet23     := TGet():New( 254,280,{|u| If(PCount()>0,cCritAnsp5:=u,cCritAnsp5)},oGrp6,024,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cCritAnsp5",,)
oGet29     := TGet():New( 254,306,{|u| If(PCount()>0,cLocSibAnt:=u,cLocSibAnt)},oGrp6,038,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cLocSibAnt",,)
oGet30     := TGet():New( 254,088,{|u| If(PCount()>0,cSequenP5:=u,cSequenP5)},oGrp6,020,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cSequenP5",,)
 
oSay33     := TSay():New( 108,156,{||"Nivel Bloq"},oPanel1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,028,008) 
oGet31     := TGet():New( 120,156,{|u| If(PCount()>0,cNivBloq:=u,cNivBloq)},oPanel1,036,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cNivBloq",,)  
 
/*
oGet21     := TGet():New( 254,004,{|u| If(PCount()>0,cTpAcao:=u,cTpAcao)},oGrp6,024,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cTpAcao",,)
oGet22     := TGet():New( 254,068,{|u| If(PCount()>0,cCompte:=u,cCompte)},oGrp6,024,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cCompte",,)
oGet24     := TGet():New( 254,096,{|u| If(PCount()>0,cDtGera:=u,cDtGera)},oGrp6,040,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cDtGera",,)
oGet25     := TGet():New( 254,248,{|u| If(PCount()>0,cCritOpep5:=u,cCritOpep5)},oGrp6,024,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cCritOpep5",,)
oGet26     := TGet():New( 254,141,{|u| If(PCount()>0,cDtEnvio:=u,cDtEnvio)},oGrp6,048,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cDtEnvio",,)
oGet27     := TGet():New( 254,033,{|u| If(PCount()>0,cTpEnvio:=u,cTpEnvio)},oGrp6,031,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cTpEnvio",,)
oGet28     := TGet():New( 254,194,{|u| If(PCount()>0,cDtRetorno:=u,cDtRetorno)},oGrp6,048,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cDtRetorno",,)
oGet23     := TGet():New( 254,277,{|u| If(PCount()>0,cCritAnsp5:=u,cCritAnsp5)},oGrp6,024,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cCritAnsp5",,)
oGet29     := TGet():New( 254,306,{|u| If(PCount()>0,cLocSibAnt:=u,cLocSibAnt)},oGrp6,038,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cLocSibAnt",,)
*/
oDlg148:Activate(,,,.T.)

Return


///////////////////////////////////////////
/*
oCBox1_0    := TComboBox():New( 076,114,{|u| If(PCount()>0,nLSibAt:=u,nLSibAt)},{"0-HA ENVIAR ","6-FORCAR INCLUSAO "},072,010,oGrp2,,,,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,,nLSibAt ) 
oCBox1_1    := TComboBox():New( 076,114,{|u| If(PCount()>0,nLSibAt:=u,nLSibAt)},{"1-ATIVO ","7-FORCAR ALTERACAO","8-FORCAR EXCLUSAO"},072,010,oGrp2,,,,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,,nLSibAt )
oCBox1_2    := TComboBox():New( 076,114,{|u| If(PCount()>0,nLSibAt:=u,nLSibAt)},{"2-EXCLUIDO ","C-FORCAR REATIVACAO "},072,010,oGrp2,,,,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,,nLSibAt )
oCBox1_3    := TComboBox():New( 076,114,{|u| If(PCount()>0,nLSibAt:=u,nLSibAt)},{"3-ENVIADO INCLUSAO  "},072,010,oGrp2,,,,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,,nLSibAt )
oCBox1_4    := TComboBox():New( 076,114,{|u| If(PCount()>0,nLSibAt:=u,nLSibAt)},{"4-ENVIADO ALTERACAO "},072,010,oGrp2,,,,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,,nLSibAt )
oCBox1_5    := TComboBox():New( 076,114,{|u| If(PCount()>0,nLSibAt:=u,nLSibAt)},{"5-ENVIADO EXCLUSAO "},072,010,oGrp2,,,,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,,nLSibAt ) 
oCBox1_6    := TComboBox():New( 076,114,{|u| If(PCount()>0,nLSibAt:=u,nLSibAt)},{"0-HA ENVIAR ","6-FORCAR INCLUSAO "},072,010,oGrp2,,,,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,,nLSibAt ) 
oCBox1_7    := TComboBox():New( 076,114,{|u| If(PCount()>0,nLSibAt:=u,nLSibAt)},{"1-ATIVO ","7-FORCAR ALTERACAO"},072,010,oGrp2,,,,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,,nLSibAt )
oCBox1_8    := TComboBox():New( 076,114,{|u| If(PCount()>0,nLSibAt:=u,nLSibAt)},{"1-ATIVO ","8-FORCAR EXCLUSAO"},072,010,oGrp2,,,,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,,nLSibAt )
oCBox1_9    := TComboBox():New( 076,114,{|u| If(PCount()>0,nLSibAt:=u,nLSibAt)},{"9-MUDANCA CONTRATUAL "},072,010,oGrp2,,,,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,,nLSibAt )
oCBox1_a    := TComboBox():New( 076,114,{|u| If(PCount()>0,nLSibAt:=u,nLSibAt)},{"A-REATIVACAO "},072,010,oGrp2,,,,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,,nLSibAt )
oCBox1_b    := TComboBox():New( 076,114,{|u| If(PCount()>0,nLSibAt:=u,nLSibAt)},{"1-ATIVO ","B-FORCAR MUD. CONTR "},072,010,oGrp2,,,,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,,nLSibAt ) 
oCBox1_c    := TComboBox():New( 076,114,{|u| If(PCount()>0,nLSibAt:=u,nLSibAt)},{"2-EXCLUIDO ","C-FORCAR REATIVACAO "},072,010,oGrp2,,,,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,,nLSibAt )
*/

Static Function fSair() 

 lSai:= .T. 
 oDlg148:End()

Return()
  
static function fLerArq(cChave)     
local cQuery := ' '  
    If !empty(cChave)    
		cQuery := "   Select Distinct Ba1.Ba1_Traori,Ba1.Ba1_Trades, "                                                           
		cquery += CRLF + "   Ba1_Codcco Codcco , Ba1_Cpfusr Cpf,Ba1_Nomusr Nomusr, " 
		cQuery += CRLF + "   Ba1_Codint||Ba1_Codemp||Ba1_Matric||Ba1_Tipreg||Ba1_Digito Matric , "   
		cQuery += CRLF + "   substr(Ba1_Datinc,7,2)||'/'||substr(Ba1_Datinc,5,2)||'/'||substr(Ba1_Datinc,1,4) Datinc , " 
		cQuery += CRLF + "   substr(Ba1_Datblo,7,2)||'/'||substr(Ba1_Datblo,5,2)||'/'||substr(Ba1_Datblo,1,4) DatBlo , " 
		cQuery += CRLF + "   Ba1.Ba1_Motblo Motblo ,decode(Ba1_Consid,'U','Usuario', 'F', 'Familia', 'S', 'Sub Cont', ' ')  NivBloq, "          
		
		cquery += CRLF + "   decode(BA1_LOCSIB,'0','0-HA ENVIAR', "
		cquery += CRLF + "                     '1','1-ATIVO', "  
		cquery += CRLF + "                     '2','2-EXCLUIDO', " 
		cquery += CRLF + "      			   '3','3-ENVIADO INCLUSAO'," 
		cquery += CRLF + "                     '4','4-ENVIADO ALTERACAO'," 
		cquery += CRLF + "                     '5','5-ENVIADO EXCLUSAO',"  
		cquery += CRLF + "                     '6','6-FORCAR INCLUSAO',"
		cquery += CRLF + "                     '7','7-FORCAR ALTERACAO'," 
		cquery += CRLF + "                     '8','8-FORCAR EXCLUSAO'," 
		cquery += CRLF + "                     '9','9-MUDANCA CONTRATUAL'," 
		cquery += CRLF + "                     'A','A-REATIVACAO',"
		cquery += CRLF + "                     'B','B-FORCAR MUD. CONTR.'," 
		cquery += CRLF + "                     'C','C-FORCAR REATIVACAO') LocSib , "  
		cquery += CRLF + "   decode(BA1_ATUSIB,'0','Não','Sim') AtuSib ," 
		cquery += CRLF + "   decode(BA1_INFSIB,'0','Não','Sim') InfSib ," 
		cquery += CRLF + "   decode(BA1_INFANS,'0','Não','Sim') InfAns ,"     
		cQuery += CRLF + "        Decode(Trim(Ba1_Motblo),'', 'sem Bloq',( Decode(Trim(Case When Ba1_Consid = 'U' Then Nvl(Blqu.Descri, ' ' ) "  
		cQuery += CRLF + "        When Ba1_Consid = 'F' Then Nvl(Blqf.Descri, ' ' )  " 
		cQuery += CRLF + "        When Ba1_Consid = 'S' Then Nvl(Blqs.Descri, ' ' )  " 
		cQuery += CRLF + "        Else 'S/Descriçao' End),Null,'Bloq Temp','Bloq Def')))  Bloq_Ans  "
		
		cQuery += CRLF + "   From "+ RetSqlName("BA1") + " BA1 ,  "
		cQuery += CRLF + "        ( Select 'usuario' Origem  , Bg3_Codblo Codblo , Bg3_Desblo Descri , Bg3_Blqans  Blqans  From "+ RetSqlName("BG3")+" Bg3 Where Bg3_Filial= '"+xFilial('BG3')+ "' And Bg3.D_E_L_E_T_ = ' ') Blqu , "
		cQuery += CRLF + "        ( Select 'familia' Origem  , Bg1_Codblo Codblo , Bg1_Desblo Descri , Bg1_Blqans  Blqans  From "+ RetSqlName("BG1")+" Bg1 Where Bg1_Filial= '"+xFilial('BG1')+ "' And Bg1.D_E_L_E_T_ = ' ') Blqf , " 
		cQuery += CRLF + "        ( Select 'sub_cont' Origem , Bqu_Codblo Codblo , Bqu_Desblo Descri , Bqu_Blqans  Blqans  From "+ RetSqlName("BQU")+" Bqu Where Bqu_Filial= '"+xFilial('BQU')+ "' And Bqu.D_E_L_E_T_ = ' ') Blqs   "
		
		 
   	    cQuery += CRLF + "  Where  Ba1_Filial = '"+xFilial('BA1')+ "' And BA1.D_E_L_E_T_ = ' ' "   
	    cQuery += CRLF + " And Ba1_Codint||Ba1_Codemp||Ba1_Matric||Ba1_Tipreg||Ba1_Digito = '"+cChave+"'"        
		   
		cQuery += CRLF + "    And Ba1_Motblo = Blqu.Codblo(+)   
		cQuery += CRLF + "    And Ba1_Motblo = Blqf.Codblo(+)   
		cQuery += CRLF + "    And Ba1_Motblo = Blqs.Codblo(+)   
		    
		If Select((cAliastmp)) <> 0 
		   (cAliastmp)->(DbCloseArea())  
		Endif 
		
		TCQuery cQuery  New Alias (cAliastmp)   
		
		(cAliastmp )->(dbGoTop())                          
		
		if (cAliastmp)->(!Eof())
			cMatric:= (cAliastmp)->Matric 
			cCodCco:= (cAliastmp)->Codcco
			
			cLSibAn:= (cAliastmp)->LocSib
			nLSibAt:= (cAliastmp)->LocSib
            fContStS()			
			cIAnsAn:= (cAliastmp)->InfAns
			cIAnsAt:= (cAliastmp)->InfAns
			
			cISibAn:= (cAliastmp)->InfSib
			cISibAt:= (cAliastmp)->InfSib
			
			cASibAn:= (cAliastmp)->AtuSib
			cASibAt:= (cAliastmp)->AtuSib
			
			cNomUsr:= (cAliastmp)->Nomusr
			cDtIncl:= (cAliastmp)->DatInc
			cDtBloq:= (cAliastmp)->DatBlo  
			cNivBloq := (cAliastmp)->NivBloq
			cMotblo:= trim((cAliastmp)->Motblo) + " - " + (cAliastmp)->Bloq_Ans     
		
		    fbusdadPd4 ()
					         
			oDlg148:ctrlrefresh()
					
			 oGet1:ctrlrefresh()  
			 oGet2:ctrlrefresh() 
			 oGet3:ctrlrefresh() 
			 oGet4:ctrlrefresh() 
			 oGet5:ctrlrefresh() 
			 oGet6:ctrlrefresh() 
			 oGet9:ctrlrefresh() 
			 oGet8:ctrlrefresh() 
			 oGet10:ctrlrefresh() 
			 oGet11:ctrlrefresh() 
			 oGet12:ctrlrefresh() 
			 oGet13:ctrlrefresh()  
			 oGet14:ctrlrefresh() 
			// oMGet1:ctrlrefresh() 
			oCBox1:setfocus()
			
		Else 
		   MsgAlert("Matricula  não Localizado !!! Verifique os parametros Informados .","Atencao!")
		   oGet1:Setfocus()     
		EndIf  
	Else 
       MsgAlert("Matricula Não Informada  !!! Informe a Matricula.","Atencao!")
	   oGet1:Setfocus()  
	EndIf	    
	 
return()     


static function fGrava() 
                          
If fCritica() .or. cUsuar148=='Altamiro Totta '
	dbselectarea("PD7")
	PD7->(DbSetOrder(1))
	    RecLock("PD7",.T.)     
	       fMovVarArq()  
	     Msunlock("PD7") 
	     fGravaBa1() 
         fDescatar() 	     
        oGet1:Setfocus() 
Else          
  oCBox1:setfocus()
EndIf   

RETURN()      

static function fGravaBa1() 
                          
	dbselectarea("BA1")
	BA1->(DbSetOrder(2))
   If dbSeek(xFilial("BA1")+cMatric )      
	  RecLock("BA1",.F.)     
	    fMovVarBA1()  
      Msunlock("BA1") 
   EndIf 
RETURN()     
                              
static Function  fMovVarBA1()

Local cTpGvBa1:=Iif(nASibAt == "Sim" , 'Envio p/ Sib' , 'Nao Envio p/ Sib')  

     If MsgYesNo("Confirma Marcação de "+cTpGvBa1+" do registro selecionado?")

		If trim(nASibAt) == "Sim"
		   BA1->BA1_ATUSIB  := '1'  
  	       BA1_INFANS       := '1'
  	       BA1_INFSIB       := '1' 
		ElseIf trim(nASibAt) == "Nao"
		   BA1_ATUSIB  := '0'
		   BA1_INFANS  := '0' 
		   BA1_INFSIB  := '0'
		EndIf               

        BA1_LOCSIB := SUBSTR(nLSibAt,1,1)
     EndIf               
RETURN()
static Function  fFazpara()   

If trim(nASibAt) == "Sim"
   cIAnsAt := "Sim"
   cISibAt := "Sim" 

Else               
  
   nASibAt := "Nao"
   cIAnsAt := "Nao"
   cISibAt := "Nao" 

EndIf  

Static Function  fMovVarArq()
local Ret := .F.             

PD7_FILIAL := xFILIAL("PD7")    
PD7_MATRIC := cMatric
PD7_CODCCO := cCodCco 
PD7_LSIBAN := cLSibAn 
PD7_LSIBAT := nLSibAt
PD7_IANSAN := cIAnsAn  
PD7_IANSAT := cIAnsAt  
PD7_ISIBAN := cISibAn  
PD7_ISIBAT := cISibAt  
PD7_ASIBAN := cASibAn 
PD7_ASIBAT := cISibAt  
PD7_USUARI := PD7USUARIO                                    
//PD7_DTHR   := Dtoc(dDataBase) + " " + StrTran(Time(),':','') 
PD7_DTHR   := Dtoc(dDataBase) + " " + Time()

return()

static function fCritica()                                                
If trim(nLSibAt) $ cLocconf

   Ret:= .T.

Else        

   Ret:= .F.
   MsgAlert("Manutenção Não Permitida  !!! Verifique Valores Validos P/ o campo Locsib Atual.","Atenção!")      

EndIf
Ret:= .T.
return(Ret)

static function fDescatar()                                        

 cASibAn    := Space(3)                                      
 cCodCco    := Space(1)
 cDtBloq    := Space(1)
 cDtBloq    := Space(1)
 cDtIncl    := Space(1)
 cIAnsAn    := Space(3)
 cIAnsAt    := Space(3)
 cISibAn    := Space(3)
 cISibAt    := Space(3)

cLocsibHist:= '0-HA ENVIAR' + CRLF + ;
                      '1-ATIVO ' + CRLF +     ;
                      '2-EXCLUIDO ' + CRLF +   ;
                      '3-ENVIADO INCLUSAO ' + CRLF +   ;
                      '4-ENVIADO ALTERACAO ' + CRLF +   ;
                      '5-ENVIADO EXCLUSAO ' + CRLF +   ;
                      '6-FORCAR INCLUSAO ' + CRLF +    ;
                      '7-FORCAR ALTERACAO ' + CRLF +   ;
                      '8-FORCAR EXCLUSAO ' + CRLF +    ;
                      '9-MUDANCA CONTRATUAL ' + CRLF + ;
                      'A-REATIVACAO ' + CRLF  +        ;
                      'B-FORCAR MUD. CONTR ' + CRLF +  ;
                      'C-FORCAR REATIVACAO ' + CRLF  
                      
chist1:=      '--------------------------------'+ CRLF  + ;  
                      ' ** Só Serão Enviados se TODAS as Variaveis '+ CRLF+;
                      'InfAns ,  InfSib , AtuSib  estiverem como Sim '+ CRLF  

 cLSibAn    := Space(1)
 cMatric    := Space(17)
 cMotblo    := Space(1)
 cCritOpe   := Space(1)
 cCritANS   := Space(1)
 cNomUsr    := Space(1)
 nASibAt    := Space(3)
 nLSibAt    := Space(3)     
 
 cCodprod   := Space(1)
 cCpfUser   := Space(1)
 cDtatual   := Space(1)
 cDtInclans := Space(1)
 cSituacao  := Space(1)  
 cDtCancel  := Space(1)
 
 cLocSibAnt := Space(1) 
 cTpAcao    := Space(1)
 cTpEnvio   := Space(1)  
 cCompte    := Space(1)
 cDtGera    := Space(1)     
 cDtEnvio   := Space(1)
 cDtRetorno := Space(1)
 cCritAnsp5 := Space(1)
 cCritOpep5 := Space(1) 
 cSequenP5  := Space(1)      

PD7DTHR    := Dtoc(dDataBase) + " " + StrTran(Time(),':','')


return() 

static function fbusdadPd4()  

/*local cQuery1 := ' '                     
local cQuery2 := ' ' 
local cQuery3 := ' '                                                                              ?
local cQuery4 := ' '                                                        
*/        
local cTp     := 0
 
//If !empty(cCodCco)
If 1==2          
    cQuery4 := CRLF + " select max(pd5_compte||pd5_sequen||PD5_TPENVI) CompSeq , 1 tp "
    cQuery4 += CRLF + " from "+ RetSqlName("PD5") + " PD5  "
    cQuery4 += CRLF + " WHERE  PD5_Filial = '"+xFilial('PD5')+ "' And PD5.D_E_L_E_T_ = ' ' AND pd5_CODCCO  = '"+cCodCco+"' "    
                             
   If Select((cAliastmp4)) <> 0 
      (cAliastmp4)->(DbCloseArea())  
   Endif 

   TCQuery cQuery4  New Alias (cAliastmp4)   

   (cAliastmp4)->(dbGoTop())    
                                
       cCompteseq := (cAliastmp4)->CompSeq 
       cTp := (cAliastmp4)->tp    
Else                
      cQuery4 := CRLF + " select max(pd5_compte||pd5_sequen||PD5_TPENVI) CompSeq , 2 tp"
      cQuery4 += CRLF + " from "+ RetSqlName("PD5") + " PD5  "
      cQuery4 += CRLF + " WHERE  PD5_Filial = '"+xFilial('PD5')+ "' And PD5.D_E_L_E_T_ = ' ' AND pd5_MATRIC = '"+cMatric+"'"    
                             
      If Select((cAliastmp4)) <> 0 
         (cAliastmp4)->(DbCloseArea())  
      Endif 

      TCQuery cQuery4  New Alias (cAliastmp4)   

     (cAliastmp4)->(dbGoTop())    
      if trim((cAliastmp4)->CompSeq)!=''                                 
          cCompteseq := (cAliastmp4)->CompSeq 
          cTp := (cAliastmp4)->tp    
      Else              
         cCompteseq := ' '           
         cTp := 0     
      EndIf  
EndIf 
 
IF ctp == 1
   cQuery1 := CRLF + "  Select NVL(PD4_CRITIC,'') CRITIC , NVL(PD4_CRIANS,'') CRIANS" 
   cQuery1 += CRLF + "    From "+ RetSqlName("PD4") + " PD4 " 
   cQuery1 += CRLF + "   Where   PD4_Filial = '"+xFilial('PD4')+ "' And PD4.D_E_L_E_T_ = ' ' "   
   cQuery1 += CRLF + " And PD4_CODCCO = '"+cCodCco+"'"                                                                                                                                       
   cQuery1 += CRLF + " and pd4_compte||pd4_sequen||PD4_TIPENV = '"+cCompteseq+"'"
//   cQuery1 += CRLF + " and pd4_compte||pd4_sequen = ( select max(pd5_compte||pd5_sequen) from "+ RetSqlName("PD5") + " PD5 WHERE  PD5_Filial = '"+xFilial('PD5')+ "' And PD5.D_E_L_E_T_ = ' ' AND pd5_CODCCO  = '"+cCodCco+"') "    
    
   If Select((cAliastmp1)) <> 0 
      (cAliastmp1)->(DbCloseArea())  
   Endif 

   TCQuery cQuery1  New Alias (cAliastmp1)   

   (cAliastmp1)->(dbGoTop())    
   if (cAliastmp1)->(!Eof()) 
	  cCritOpe:= (cAliastmp1)->CRITIC
	  cCritANS:= (cAliastmp1)->CRIANS  
   EndIF 	

 // CONSULTA PD5  codcco
 
cQuery3 := CRLF + "   SELECT  pd5_tpacao  TpAcao ,  "
cQuery3 += CRLF + "           pd5_tpenvi TpEnvio ,  "
cQuery3 += CRLF + "           pd5_compte  compte ,  "
cQuery3 += CRLF + "           substr(PD5_DTCRIA,7,2)||'/'||substr(PD5_DTCRIA,5,2)||'/'||substr(PD5_DTCRIA,1,4) DTGERA, "
cQuery3 += CRLF + "           substr(PD5_DTENV,7,2)||'/'||substr(PD5_DTENV,5,2)||'/'||substr(PD5_DTENV,1,4) DTENV,     "
cQuery3 += CRLF + "           substr(PD5_DATRET,7,2)||'/'||substr(PD5_DATRET,5,2)||'/'||substr(PD5_DATRET,1,4) DATRET, "
cQuery3 += CRLF + "           DECODE(PD5_CRITIC,'F','NÃO','SIM') CRITOPE ,  "
cQuery3 += CRLF + "           DECODE(TRIM(PD5_CRIANS),'','NÃO','F','NÃO','SIM') CRITANS ,"

cquery3 += CRLF + "   decode(pd5_LOCSIB,'0','0-A ENVIAR' ,"
cquery3 += CRLF + "                     '1','1-ATIVO'    ,"  
cquery3 += CRLF + "                     '2','2-EXCLUIDO '," 
cquery3 += CRLF + "      			    '3','3-ENV INCLU'," 
cquery3 += CRLF + "                     '4','4-ENV ALTER'," 
cquery3 += CRLF + "                     '5','5-ENV EXCLU',"  
cquery3 += CRLF + "                     '6','6-F. INCLU' ,"
cquery3 += CRLF + "                     '7','7-F. ALTER' ," 
cquery3 += CRLF + "                     '8','8-F. EXCLU' ," 
cquery3 += CRLF + "                     '9','9-MUD CONT'," 
cquery3 += CRLF + "                     'A','A-REATIVAC' ,"
cquery3+= CRLF + "                      'B','B-F M CONTR'," 
cquery3 += CRLF + "                     'C','C-F. REATIVA') LOCSIBP5 , "  

cQuery3 += CRLF + "           PD5_SEQUEN SEQUEN  "
cQuery3 += CRLF + "      From "+ RetSqlName("PD5") + " PD5 " 
cQuery3 += CRLF + "     WHERE PD5_FILIAL = '"+xFilial('PD5')+ "' AND PD5.D_e_l_e_t_ = ' ' " 
//cQuery3 += CRLF + "       and pd5_compte||pd5_sequen = '"+cCompteseq+"'"
cQuery3 += CRLF + " and pd4_compte||pd4_sequen||PD4_TIPENV = '"+cCompteseq+"'"

//cQuery3 += CRLF + "       AND pd5_compte||pd5_sequen = ( select max(pd5_compte||pd5_sequen) from "+ RetSqlName("PD5") + " PD5 WHERE  PD5_Filial = '"+xFilial('PD5')+ "' And PD5.D_E_L_E_T_ = ' ' AND pd5_MATRIC  = '"+cCodCco+"' ) "    
cQuery3 += CRLF + "       AND PD5_CODCCO = '"+cCodCco+"'"

   If Select((cAliastmp3)) <> 0 
      (cAliastmp3)->(DbCloseArea())  
   Endif 

   TCQuery cQuery3  New Alias (cAliastmp3)   

   (cAliastmp3)->(dbGoTop())    
   if (cAliastmp3)->(!Eof())  
   
		 cLocSibAnt := (cAliastmp3)->LOCSIBP5
		 cTpAcao    := (cAliastmp3)->TpAcao
		 cTpEnvio   := (cAliastmp3)->TpEnvio
		 cCompte    := (cAliastmp3)->compte
		 cDtGera    := (cAliastmp3)->DTGERA
		 cDtEnvio   := (cAliastmp3)->DTENV
		 cDtRetorno := (cAliastmp3)->DATRET
		 cCritAnsp5 := (cAliastmp3)->CRITANS  
		 cCritOpep5 := (cAliastmp3)->CRITOPE                          
		 cSequenP5  := (cAliastmp3)->SEQUEN
   
   EndIF 

     
ElseIf cTp == 2     
       cQuery1 := CRLF + "  Select NVL(PD4_CRITIC,'') CRITIC , NVL(PD4_CRIANS,'') CRIANS" 
       cQuery1 += CRLF + "    From "+ RetSqlName("PD4") + " PD4 " 
       cQuery1 += CRLF + "   Where   PD4_Filial = '"+xFilial('PD4')+ "' And PD4.D_E_L_E_T_ = ' ' "     
       cQuery1 += CRLF + " And PD4_MATRIC = '"+cMatric+"'"         

//       cQuery1 += CRLF + " and pd4_compte||pd4_sequen = '"+cCompteseq+"'"
       cQuery1 += CRLF + " and pd4_compte||pd4_sequen||PD4_TIPENV = '"+cCompteseq+"'"
	  // cQuery1 += CRLF + " and pd4_compte||pd4_sequen = ( select max(pd5_compte||pd5_sequen) from "+ RetSqlName("PD5") + " PD5 WHERE  PD5_Filial = '"+xFilial('PD5')+ "' And PD5.D_E_L_E_T_ = ' ' AND pd5_MATRIC  = '"+cMatric+"' ) "    
    
	   If Select((cAliastmp1)) <> 0 
	      (cAliastmp1)->(DbCloseArea())  
	   Endif 
	
	   TCQuery cQuery1  New Alias (cAliastmp1)   
	
	   (cAliastmp1)->(dbGoTop())    
	   if (cAliastmp1)->(!Eof()) 
           cCritOpe:= (cAliastmp1)->CRITIC
	       cCritANS:= (cAliastmp1)->CRIANS  
	   Else                                 
	      cCritOpe:= ' '
	      cCritANS:= ' '                  
	   EndIf            
	   

 // CONSULTA PD5  codcco
 
cQuery3 := CRLF + "   SELECT  pd5_tpacao  TpAcao ," 
cQuery3 += CRLF + "           pd5_tpenvi TpEnvio ,"
cQuery3 += CRLF + "           pd5_compte  compte ," 
cQuery3 += CRLF + "           substr(PD5_DTCRIA,7,2)||'/'||substr(PD5_DTCRIA,5,2)||'/'||substr(PD5_DTCRIA,1,4) DTGERA, "
cQuery3 += CRLF + "           substr(PD5_DTENV,7,2)||'/'||substr(PD5_DTENV,5,2)||'/'||substr(PD5_DTENV,1,4) DTENV,     "
cQuery3 += CRLF + "           substr(PD5_DATRET,7,2)||'/'||substr(PD5_DATRET,5,2)||'/'||substr(PD5_DATRET,1,4) DATRET, "
cQuery3 += CRLF + "           DECODE(PD5_CRITIC,'F','NÃO','SIM') CRITOPE , " 
cQuery3 += CRLF + "           DECODE(PD5_CRIANS,'F','NÃO','SIM') CRITANS , "    

cquery3 += CRLF + "   decode(pd5_LOCSIB,'0','0-A ENVIAR' ,"
cquery3 += CRLF + "                     '1','1-ATIVO'    ,"  
cquery3 += CRLF + "                     '2','2-EXCLUIDO '," 
cquery3 += CRLF + "      			    '3','3-ENV INCLU'," 
cquery3 += CRLF + "                     '4','4-ENV ALTER'," 
cquery3 += CRLF + "                     '5','5-ENV EXCLU',"  
cquery3 += CRLF + "                     '6','6-F. INCLU' ,"
cquery3 += CRLF + "                     '7','7-F. ALTER' ," 
cquery3 += CRLF + "                     '8','8-F. EXCLU' ," 
cquery3 += CRLF + "                     '9','9-MUD CONT'," 
cquery3 += CRLF + "                     'A','A-REATIVAC' ,"
cquery3+= CRLF + "                      'B','B-F M CONTR'," 
cquery3 += CRLF + "                     'C','C-F. REATIVA') LOCSIBP5 , "  

//cQuery3 += CRLF + "           PD5_LOCSIB LOCSIBP5 ,"
cQuery3 += CRLF + "           PD5_SEQUEN SEQUEN "
cQuery3 += CRLF + "      From "+ RetSqlName("PD5") + " PD5 " 
cQuery3 += CRLF + "     WHERE PD5_FILIAL = '"+xFilial('PD5')+ "' AND PD5.D_e_l_e_t_ = ' '" 
//cQuery3 += CRLF + "       and pd5_compte||pd5_sequen = '"+cCompteseq+"'"
cQuery3 += CRLF + " and pd5_compte||pd5_sequen||PD5_TPENVI = '"+cCompteseq+"'"

//cQuery3 += CRLF + "       ANS pd5_compte||pd5_sequen = ( select max(pd5_compte||pd5_sequen) from "+ RetSqlName("PD5") + " PD5 WHERE  PD5_Filial = '"+xFilial('PD5')+ "' And PD5.D_E_L_E_T_ = ' ' AND PD5_MATRIC = '"+cMatric+"' ) "    
cQuery3 += CRLF + "      AND  PD5_MATRIC = '"+cMatric+"'"

   If Select((cAliastmp3)) <> 0 
      (cAliastmp3)->(DbCloseArea())  
   Endif 

   TCQuery cQuery3  New Alias (cAliastmp3)   

   (cAliastmp3)->(dbGoTop())    
   if (cAliastmp3)->(!Eof())  
   
		 cLocSibAnt := (cAliastmp3)->LOCSIBP5
		 cTpAcao    := (cAliastmp3)->TpAcao
		 cTpEnvio   := (cAliastmp3)->TpEnvio
		 cCompte    := (cAliastmp3)->compte
		 cDtGera    := (cAliastmp3)->DTGERA
		 cDtEnvio   := (cAliastmp3)->DTENV
		 cDtRetorno := (cAliastmp3)->DATRET
		 cCritAnsp5 := (cAliastmp3)->CRITOPE
		 cCritOpep5 := (cAliastmp3)->CRITANS
		 cSequenP5  := (cAliastmp3)->SEQUEN                    

	Else
	
	     cLocSibAnt := ' ' 
		 cTpAcao    := ' '
		 cTpEnvio   := ' '
		 cCompte    := ' '
		 cDtGera    := ' '
		 cDtEnvio   := ' '
		 cDtRetorno := ' '
		 cCritAnsp5 := ' '
		 cCritOpep5 := ' '                    
	EndIf 	  	         
 
EndIf

//   ----- consulta confsib 
   cQuery2 := CRLF + " Select DECODE(SIB_SITUAC,'1','Ativo', 'Bloqueado') situacao , SIB_NUMPLA codpla, SIB_CPFUSR cpfusr ,"
   cQuery2 += CRLF + "substr(SIB_DT_ATU,7,2)||'/'||substr(SIB_DT_ATU,5,2)||'/'||substr(SIB_DT_ATU,1,4) dtatua , " 
   cQuery2 += CRLF + "substr(SIB_DATCON,7,2)||'/'||substr(SIB_DATCON,5,2)||'/'||substr(SIB_DATCON,1,4) dtincl , " 
   cQuery2 += CRLF + "substr(SIB_DATCAN,7,2)||'/'||substr(SIB_DATCAN,5,2)||'/'||substr(SIB_DATCAN,1,4) dtcanc  " 
   if  cEmpAnt == '01'   
       cQuery2 += CRLF + "    From confsib_cab SIB "  
   Else 
       cQuery2 += CRLF + "    From confsib_int SIB "     
   EndIf    
   
   cQuery2 += CRLF + "   Where   (SIB_matric = '"+cMatric+"'"                                                                                                                                       
   cQuery2 += CRLF + "   or      SIB_CODCCO = '"+cCodCco+"')"                                                                                                                                           
   If Select((cAliastmp2)) <> 0 
      (cAliastmp2)->(DbCloseArea())  
   Endif 

   TCQuery cQuery2  New Alias (cAliastmp2)   

   (cAliastmp2)->(dbGoTop())    
   if (cAliastmp2)->(!Eof()) 
   
      cCodprod   := (cAliastmp2)->codpla
      cCpfUser   := (cAliastmp2)->cpfusr
      cDtatual   := (cAliastmp2)->dtatua
      cDtInclans := (cAliastmp2)->dtincl
      cSituacao  := (cAliastmp2)->situacao
      cDtCancel  := (cAliastmp2)->dtcanc
      
   Else
   
   	  cCodprod   := ' '
      cCpfUser   := ' ' 
      cDtatual   := ' ' 
      cDtInclans := ' '
      cSituacao  := ' '                 
      cDtCancel  := ' '
       
   EndIF 

cTp := 0  	       
return()   


static function fContStS() 

If trim(cLSibAn) =="0-HA ENVIAR"
      cLocsibHist:='0-HA ENVIAR' + CRLF + ;
                   '6-FORCAR INCLUSAO ' + CRLF 
      cLocconf  := '0-HA ENVIAR|6-FORCAR INCLUSAO'                   

ElseIf trim(cLSibAn) =="1-ATIVO"
          cLocsibHist:='1-ATIVO '            + CRLF + ;
                       '7-FORCAR ALTERACAO ' + CRLF + ;
                       '8-FORCAR EXCLUSAO  ' + CRLF + ;
                       'C-FORCAR EXCLUSAO  ' + CRLF                       
          cLocconf  := '1-ATIVO|7-FORCAR ALTERACAO|8-FORCAR EXCLUSAO|C-FORCAR EXCLUSAO' 

ElseIf trim(cLSibAn) =="2-EXCLUIDO"
          cLocsibHist:='2-EXCLUIDO ' + CRLF +   ; 
                       '8-FORCAR EXCLUSAO' + CRLF +   ;
                       'C-FORCAR REATIVACAO ' + CRLF                       
           cLocconf  := '2-EXCLUIDO|8-FORCAR EXCLUSAO|C-FORCAR REATIVACAO' 
           
ElseIf trim(cLSibAn) =="3-ENVIADO INCLUSAO"
          cLocsibHist:='3-ENVIADO INCLUSAO ' + CRLF 
           cLocconf  :='3-ENVIADO INCLUSAO'
            
ElseIf trim(cLSibAn) =="4-ENVIADO ALTERACAO" 
          cLocsibHist:='4-ENVIADO ALTERACAO ' + CRLF 
           cLocconf  :='4-ENVIADO ALTERACAO' 
           
ElseIf trim(cLSibAn) =="5-ENVIADO EXCLUSAO"
          cLocsibHist:='5-ENVIADO EXCLUSAO ' + CRLF 
           cLocconf  :='5-ENVIADO EXCLUSAO' 
           
ElseIf trim(cLSibAn) =="6-FORCAR INCLUSAO"
          cLocsibHist:='0-HA ENVIAR' + CRLF + ;
                       '6-FORCAR INCLUSAO ' + CRLF 
           cLocconf  :='0-HA ENVIAR|6-FORCAR INCLUSAO' 
                                
ElseIf trim(cLSibAn) =="7-FORCAR ALTERACAO"
          cLocsibHist:='0-HA ENVIAR' + CRLF + ;
                       '7-FORCAR ALTERACAO ' + CRLF 
           cLocconf  :='0-HA ENVIAR|7-FORCAR ALTERACAO'
                     
ElseIf trim(cLSibAn) =="8-FORCAR EXCLUSAO"
          cLocsibHist:='1-ATIVO ' + CRLF +     ;
                       '8-FORCAR EXCLUSAO ' + CRLF
           cLocconf  :='1-ATIVO|8-FORCAR EXCLUSAO'
                          
ElseIf trim(cLSibAn) =="9-MUDANCA CONTRATUAL"
          cLocsibHist:='0-HA ENVIAR' + CRLF + ;
                       '6-FORCAR INCLUSAO ' + CRLF + ;
                       '9-MUDANCA CONTRATUAL ' + CRLF
           cLocconf  :='0-HA ENVIAR|6-FORCAR INCLUSAO|9-MUDANCA CONTRATUAL' 
                       
ElseIf trim(cLSibAn) =="A-REATIVACAO"
          cLocsibHist:='A-REATIVACAO ' + CRLF  
           cLocconf  :='A-REATIVACAO'
                     
ElseIf trim(cLSibAn) =="B-FORCAR MUD. CONTR"
          cLocsibHist:='1-ATIVO ' + CRLF +     ;
                       'B-FORCAR MUD. CONTR ' + CRLF 
           cLocconf  :='1-ATIVO|B-FORCAR MUD. CONTR'
                                             
ElseIf trim(cLSibAn) =="C-FORCAR REATIVACAO" 
          cLocsibHist:='1-ATIVO ' + CRLF +     ;
                       '2-EXCLUIDO ' + CRLF +   ;
                       '7-FORCAR ALTERACAO ' + CRLF + ;
                       'C-FORCAR REATIVACAO ' + CRLF  
           cLocconf  :='1-ATIVO|2-EXCLUIDO|7-FORCAR ALTERACAO |C-FORCAR REATIVACAO' 
            
EndIF
  
  cLocsibHist:='       AÇÃES POSSIVEIS     '+ CRLF +   CRLF + cLocsibHist + CRLF +   CRLF + chist1

/*   

oCBox1:Disable() 
oCBox1_0:Disable() 
oCBox1_1:Disable() 
oCBox1_2:Disable() 
oCBox1_3:Disable() 
oCBox1_4:Disable() 
oCBox1_5:Disable() 
oCBox1_6:Disable() 
oCBox1_7:Disable() 
oCBox1_8:Disable() 
oCBox1_9:Disable() 
oCBox1_a:Disable() 
oCBox1_b:Disable() 
oCBox1_c:Disable() 
               
oCBox1:hide()
oCBox1_0:hide()
oCBox1_1:hide()
oCBox1_2:hide()
oCBox1_3:hide()
oCBox1_4:hide()
oCBox1_5:hide()
oCBox1_6:hide()
oCBox1_7:hide()
oCBox1_8:hide()
oCBox1_9:hide()
oCBox1_a:hide()
oCBox1_b:hide()
oCBox1_c:hide()

If trim(cLSibAn) =="0-HA ENVIAR"
   oCBox1_0:enable()  
   oCBox1_0:Show()        
ElseIf trim(cLSibAn) =="1-ATIVO"
   oCBox1_1:enable()  
   oCBox1_1:Show() 
ElseIf trim(cLSibAn) =="2-EXCLUIDO"
   oCBox1_2:enable()
   oCBox1_2:Show() 
ElseIf trim(cLSibAn) =="3-ENVIADO INCLUSAO"
   oCBox1_3:enable()
   oCBox1_3:Show() 
ElseIf trim(cLSibAn) =="4-ENVIADO ALTERACAO" 
   oCBox1_4:enable() 
   oCBox1_4:Show()  
ElseIf trim(cLSibAn) =="5-ENVIADO EXCLUSAO"
   oCBox1_5:enable()   
   oCBox1_5:Show() 
ElseIf trim(cLSibAn) =="6-FORCAR INCLUSAO"
   oCBox1_6:enable() 
   oCBox1_6:Show() 
ElseIf trim(cLSibAn) =="7-FORCAR ALTERACAO"
   oCBox1_7:enable() 
   oCBox1_7:Show() 
ElseIf trim(cLSibAn) =="8-FORCAR EXCLUSAO"
   oCBox1_8:enable() 
   oCBox1_8:Show() 
ElseIf trim(cLSibAn) =="9-MUDANCA CONTRATUAL"
   oCBox1_9:enable() 
   oCBox1_9:Show() 
ElseIf trim(cLSibAn) =="A-REATIVACAO"
   oCBox1_a:enable() 
   oCBox1_a:Show() 
ElseIf trim(cLSibAn) =="B-FORCAR MUD. CONTR"
   oCBox1_b:enable() 
   oCBox1_b:Show() 
ElseIf trim(cLSibAn) =="C-FORCAR REATIVACAO" 
   oCBox1_c:enable()  
   oCBox1_c:Show()     
EndIF  
oCBox1_0:ctrlrefresh()
oCBox1_1:ctrlrefresh()
oCBox1_2:ctrlrefresh()
oCBox1_3:ctrlrefresh()
oCBox1_4:ctrlrefresh()
oCBox1_5:ctrlrefresh()
oCBox1_6:ctrlrefresh()
oCBox1_7:ctrlrefresh()
oCBox1_8:ctrlrefresh()
oCBox1_9:ctrlrefresh()
oCBox1_a:ctrlrefresh()
oCBox1_b:ctrlrefresh()
oCBox1_c:ctrlrefresh() 
 */
Return()
            
///////////////////////////////////  
