#INCLUDE 'PROTHEUS.CH'
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

User Function caba414() 

/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±± Declaração de cVariable dos componentes                                 ±±
Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/
Private cAssunto   := Space(100)
Private cAssunto   := Space(100)
Private cidonus    := Space(6)
Private cMenOrig  
Private cMenUsr   
Private cNumCab    := Space(10)
Private cNumCompP  := Space(20)
Private cNumproc   := Space(30)
Private cUsuario   := Space(1)
Private dDtEnv     := CtoD(" ")

/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±± Declaração de Variaveis Private dos Objetos                             ±±
Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/
SetPrvt("oDlg1","oGrp13","oBtn1","oBtn4","oBtn2","oGrp1","oSay19","oSay18","oSay20","oSay3","oSay2","oSay1")
SetPrvt("oGet8","oGet22","oGet21","oGet23","oGet1","oGet2","oGet3","oGet6","oGrp2","oMGet1","oGrp3","oMGet2")
SetPrvt("oMGet3","oGrp5","oGet4","oGrp6","oMGet4","oGrp7","oGet5")

/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±± Definicao do Dialog e todos os seus componentes.                        ±±
Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/
oDlg1      := MSDialog():New( 086,229,701,1203,"Controle de Email  ",,,.F.,,,,,,.T.,,,.T. )
oGrp13     := TGroup():New( 000,420,056,480,"Controles",oDlg1,CLR_BLACK,CLR_WHITE,.T.,.F. )
oBtn1      := TButton():New( 010,424,"Enviar",oGrp13,,048,012,,,,.T.,,"",,,,.F. )
oBtn4      := TButton():New( 038,424,"Sair",oGrp13,{||oDlg1:End()},048,012,,,,.T.,,"",,,,.F. )
oBtn2      := TButton():New( 024,424,"Reenvio",oGrp13,,048,012,,,,.T.,,"",,,,.F. )
oGrp1      := TGroup():New( 000,000,032,416,"Identificação da Mensagem",oDlg1,CLR_BLACK,CLR_WHITE,.T.,.F. )
oSay19     := TSay():New( 008,044,{||"Num. Caberj"},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay18     := TSay():New( 008,096,{||"Num. Processo "},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,040,008)
oSay20     := TSay():New( 008,177,{||"Num. Compl."},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,040,008)
oSay3      := TSay():New( 008,340,{||"Hora Envio "},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay2      := TSay():New( 008,300,{||"Data Envio"},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay1      := TSay():New( 008,236,{||"Autor da Mens."},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,040,008)
oSay4      := TSay():New( 008,372,{||"Status "},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oGet8      := TGet():New( 014,004,{|u| If(PCount()>0,cidonus:=u,cidonus)},oGrp1,036,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cidonus",,)
oGet22     := TGet():New( 014,044,{|u| If(PCount()>0,cNumCab:=u,cNumCab)},oGrp1,044,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"Num sequencial do processo na Caberj / Integral",,,.F.,.F.,,.T.,.F.,"","cNumCab",,)
oGet21     := TGet():New( 014,094,{|u| If(PCount()>0,cNumproc:=u,cNumproc)},oGrp1,074,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"Numero do processo",,,.F.,.F.,,.T.,.F.,"","cNumproc",,)
oGet23     := TGet():New( 014,175,{|u| If(PCount()>0,cNumCompP:=u,cNumCompP)},oGrp1,057,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"Numero do processo",,,.F.,.F.,,.T.,.F.,"","cNumCompP",,)
oGet1      := TGet():New( 014,236,{|u| If(PCount()>0,cUsuario:=u,cUsuario)},oGrp1,060,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cUsuario",,)
oGet2      := TGet():New( 014,300,,oGrp1,036,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","",,)
oGet3      := TGet():New( 014,340,,oGrp1,028,008,'@!99:99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","",,)
oGet6      := TGet():New( 014,372,,oGrp1,040,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","",,)
oGrp2      := TGroup():New( 088,000,160,480,"Mensagem Original ",oDlg1,CLR_BLACK,CLR_WHITE,.T.,.F. )
oMGet1     := TMultiGet():New( 096,004,{|u| If(PCount()>0,cMenOrig:=u,cMenOrig)},oGrp2,472,060,,,CLR_BLACK,CLR_WHITE,,.T.,"",,,.F.,.F.,.T.,,,.F.,,  )
oGrp3      := TGroup():New( 220,000,299,480,"Mensagem Do Usuario  ",oDlg1,CLR_BLACK,CLR_WHITE,.T.,.F. )
oMGet2     := TMultiGet():New( 228,004,{|u| If(PCount()>0,cMenUsr:=u,cMenUsr)},oGrp3,472,068,,,CLR_BLACK,CLR_WHITE,,.T.,"",,,.F.,.F.,.F.,,,.F.,,  )
oGrp4      := TGroup():New( 056,000,088,480,"Destinatario(s) Originais",oDlg1,CLR_BLACK,CLR_WHITE,.T.,.F. )
oMGet3     := TMultiGet():New( 064,004,,oGrp4,472,020,,,CLR_BLACK,CLR_WHITE,,.T.,"",,,.F.,.F.,.T.,,,.F.,,  )
oGrp5      := TGroup():New( 032,000,055,416,"Assunto Original",oDlg1,CLR_BLACK,CLR_WHITE,.T.,.F. )
oGet4      := TGet():New( 040,004,{|u| If(PCount()>0,cAssunto:=u,cAssunto)},oGrp5,408,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cAssunto",,)
oGrp6      := TGroup():New( 188,000,220,480,"Destinatario(s)  Do Usuario ",oDlg1,CLR_BLACK,CLR_WHITE,.T.,.F. )
oMGet4     := TMultiGet():New( 196,004,,oGrp6,472,020,,,CLR_BLACK,CLR_WHITE,,.T.,"",,,.F.,.F.,.F.,,,.F.,,  )
oGrp7      := TGroup():New( 164,000,187,480,"Assunto Do Usuario ",oDlg1,CLR_BLACK,CLR_WHITE,.T.,.F. )
oGet5      := TGet():New( 172,004,{|u| If(PCount()>0,cAssunto:=u,cAssunto)},oGrp7,472,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cAssunto",,)

oDlg1:Activate(,,,.T.)

Return

