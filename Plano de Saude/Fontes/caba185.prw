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

User Function caba185()

/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±± Declaração de cVariable dos componentes                                 ±±
Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/
Private cCodEmp    := Space(4)
Private cContFinal := Space(12)
Private cContInic  := Space(12)
Private cImplant   := Space(1)
Private cNCFinal   := Space(1)
Private cNCInic    := Space(1)
Private cNomEmp    := Space(1)
Private cNomVend1  := Space(50)
Private cNomVend2  := Space(50)
Private cNSCFinal  := Space(1)
Private cNSCInic   := Space(1)
Private cObserv   
Private cSituacao  := Space(1)
Private cSubContFi := Space(9)
Private cSubContIn := Space(9)
Private cUsuar     := Space(1)
Private cVend1     := Space(6)
Private cVend2     := Space(6)
Private dVigFim    := CtoD(" ")
Private dVigFim1   := CtoD(" ")
Private dVigFim10  := CtoD(" ")
Private dVigFim2   := CtoD(" ")
Private dVigFim3   := CtoD(" ")
Private dVigFim4   := CtoD(" ")
Private dVigFim5   := CtoD(" ")
Private dVigFim6   := CtoD(" ")
Private dVigFim7   := CtoD(" ")
Private dVigFim8   := CtoD(" ")
Private dVigFim9   := CtoD(" ")
Private dVigInic1  := CtoD(" ")
Private dVigInic10 := CtoD(" ")
Private dVigInic2  := CtoD(" ")
Private dVigInic3  := CtoD(" ")
Private dVigInic4  := CtoD(" ")
Private dVigInic5  := CtoD(" ")
Private dVigInic6  := CtoD(" ")
Private dVigInic7  := CtoD(" ")
Private dVigInic8  := CtoD(" ")
Private dVigInic9  := CtoD(" ")
Private lAgenc1    := .F.
Private lAgenc10   := .F.
Private lAgenc2    := .F.
Private lAgenc3    := .F.
Private lAgenc4    := .F.
Private lAgenc5    := .F.
Private lAgenc6    := .F.
Private lAgenc7    := .F.
Private lAgenc8    := .F.
Private lAgenc9    := .F.
Private lContDAte  := .F.
Private lContTodo  := .T.
Private lSContDAte := .F.
Private lSContTodo := .T.
Private lVend11    := .F.
Private lVend110   := .F.
Private lVend12    := .F.
Private lVend13    := .F.
Private lVend14    := .F.
Private lVend15    := .F.
Private lVend16    := .F.
Private lVend17    := .F.
Private lVend18    := .F.
Private lVend19    := .F.
Private lVend21    := .F.
Private lVend210   := .F.
Private lVend22    := .F.
Private lVend23    := .F.
Private lVend24    := .F.
Private lVend25    := .F.
Private lVend26    := .F.
Private lVend27    := .F.
Private lVend28    := .F.
Private lVend29    := .F.
Private nParcDe1   := 0
Private nParcDe10  := 0
Private nParcDe2   := 0
Private nParcDe3   := 0
Private nParcDe4   := 0
Private nParcDe5   := 0
Private nParcDe6   := 0
Private nParcDe7   := 0
Private nParcDe8   := 0
Private nParcDe9   := 0
Private nParcFim1  := 0
Private nParcFim10 := 0
Private nParcFim2  := 0
Private nParcFim3  := 0
Private nParcFim4  := 0
Private nParcFim5  := 0
Private nParcFim6  := 0
Private nParcFim7  := 0
Private nParcFim8  := 0
Private nParcFim9  := 0
Private nPercent1  := 0
Private nPercent10 := 0
Private nPercent2  := 0
Private nPercent3  := 0
Private nPercent4  := 0
Private nPercent5  := 0
Private nPercent6  := 0
Private nPercent7  := 0
Private nPercent8  := 0
Private nPercent9  := 0

//private _cUsuar     := ' ' 
Private _cUsuar  := SubStr(cUSUARIO,7,15)
Private _cIdUsuar  := RetCodUsr()
private cDthr      := (dtos(DATE()) + "-" + Time())       


/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±± Declaração de Variaveis Private dos Objetos                             ±±
Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/
SetPrvt("oDlg1","oGrp1","oSay3","oSay4","oSay8","oSay9","oSay10","oSay11","oGet3","oGet4","oGet8","oGet9")
SetPrvt("oCBox6","oGrp2","oSay7","oSay2","oSay1","oSay21","oSay22","oGet7","oGet1","oGet2","oGet16","oGet33")
SetPrvt("oGet55","oCBox3","oGrp4","oSay16","oSay17","oSay18","oSay19","oSay20","oGet12","oGet13","oGet14")
SetPrvt("oGet17","oCBox7","oCBox15","oCBox16","oCBox2","oCBox8","oCBox9","oGet18","oGet19","oGet20","oGet21")
SetPrvt("oCBox10","oCBox11","oCBox12","oGet23","oGet24","oGet25","oGet26","oGet27","oCBox13","oCBox14")
SetPrvt("oGet28","oGet29","oGet30","oGet31","oGet32","oCBox18","oCBox19","oCBox20","oGet34","oGet35")
SetPrvt("oGet37","oGet38","oCBox21","oCBox22","oCBox23","oGet39","oGet40","oGet41","oGet42","oGet43")
SetPrvt("oCBox25","oCBox26","oGet44","oGet45","oGet46","oGet47","oGet48","oCBox27","oCBox28","oCBox29")
SetPrvt("oGet50","oGet51","oGet52","oGet53","oCBox30","oCBox31","oCBox32","oGet56","oGet57","oGet58")
SetPrvt("oGet60","oCBox33","oCBox34","oCBox35","oGet62","oGet63","oGet64","oGet65","oGet66","oGrp5","oSay23")
SetPrvt("oBtn2","oBtn1","oGet61","oBtn3","oBtn4","oBtn5","oBtn6","oGet67","oGrp6","oMGet1","oGrp3","oSay5")
SetPrvt("oSay12","oSay13","oSay14","oSay15","oGet5","oGet6","oGet10","oGet11","oCBox4","oCBox5")

/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±± Definicao do Dialog e todos os seus componentes.                        ±±
Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/
oDlg1      := MSDialog():New( 141,236,814,1054,"Cadastro de Regra de Comissões ",,,.F.,,,,,,.T.,,,.T. )
oGrp1      := TGroup():New( 063,000,103,401,"Identificação  do contrato",oDlg1,CLR_BLACK,CLR_WHITE,.T.,.F. )
oSay3      := TSay():New( 078,015,{||"Contrato "},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,024,006)
oSay4      := TSay():New( 078,076,{||"Nome Contrato "},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,042,006)
oSay8      := TSay():New( 070,006,{||"Do Contrato De "},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,040,006)
oSay9      := TSay():New( 078,250,{||"Nome Contrato "},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,042,006)
oSay10     := TSay():New( 078,189,{||"Contrato "},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,025,006)
oSay11     := TSay():New( 070,172,{||"Ao  Contrato Ate "},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,040,006)

//oGet3      := TGet():New( 087,015,{|u| If(PCount()>0,cContInic:=u,cContInic)},oGrp1,053,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"BQCC18","cContInic",,)

oGet3      := TGet():New( 087,015,{|u| If(PCount()>0,(cContInic:=u,fConscont(1),oGet3:refresh()),cContInic)},oGrp1,053,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"BQCC18","cContInic",,)

oGet3:Disable()
oGet4      := TGet():New( 087,075,{|u| If(PCount()>0,cNCInic:=u,cNCInic)},oGrp1,107,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cNCInic",,)
oGet4:Disable()
oGet8      := TGet():New( 087,249,{|u| If(PCount()>0,cNCFinal:=u,cNCFinal)},oGrp1,107,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cNCFinal",,)
oGet8:Disable()

//oGet9      := TGet():New( 087,189,{|u| If(PCount()>0,cContFinal:=u,cContFinal)},oGrp1,051,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"BQCC18","cContFinal",,)

oGet9      := TGet():New( 087,189,{|u| If(PCount()>0,(cContFinal:=u,fConscont(2),oGet9:refresh()),cContFinal)},oGrp1,051,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"BQCC18","cContFinal",,)

oGet9:Disable()
oCBox1     := TCheckBox():New( 078,367,"Todos ",{|u| If(PCount()>0,lContTodo:=u,lContTodo)},oGrp1,029,006,,{||fValidMarca(1)},,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
oGrp2      := TGroup():New( 027,000,061,401,"Identificação empresa / Vendedore(s)",oDlg1,CLR_BLACK,CLR_WHITE,.T.,.F. )
oSay7      := TSay():New( 036,003,{||"Implantação"},oGrp2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,040,006)
oSay2      := TSay():New( 036,077,{||"Nome da Empresa "},oGrp2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,047,006)
oSay1      := TSay():New( 036,036,{||"Cod. Empresa "},oGrp2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,037,006)
oSay21     := TSay():New( 038,208,{||"Vend 1"},oGrp2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,020,006)
oSay22     := TSay():New( 047,208,{||"Vend 2"},oGrp2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,020,006)
oGet7      := TGet():New( 046,003,{|u| If(PCount()>0,cImplant:=u,cImplant)},oGrp2,031,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cImplant",,)
oGet7:Disable()

//oCC1       := TGet():New( 040,327,{|u| If(PCount()>0,(cCC1:=u,fConsulCC(cCC1,1),oCC1:refresh()),cCC1)},oGrp1,017,008,'', ,CLR_BLACK,CLR_WHITE,,,,.T.," ",,,.F.,.T.,,.F.,.F.,"CTTJUR","cCC1",,)    
oGet1      := TGet():New( 046,036,{|u| If(PCount()>0,(cCodEmp:=u,fConsEmp(cCodEmp),oGet1:refresh()),cCodEmp)},oGrp2,034,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"185EMP","cCodEmp",,)
oGet2      := TGet():New( 046,076,{|u| If(PCount()>0,cNomEmp:=u,cNomEmp)},oGrp2,130,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cNomEmp",,)
oGet2:Disable()
oGet2:refresh()

oGet16     := TGet():New( 033,230,{|u| If(PCount()>0,(cVend1:=u,fConsVend(cVend1,1)),cVend1)},oGrp2,034,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"SA3","cVend1",,)
oGet33     := TGet():New( 033,273,{|u| If(PCount()>0,cNomVend1:=u,cNomVend1)},oGrp2,125,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cNomVend1",,)
oGet33:Disable()
oGet33:refresh()

oGet55     := TGet():New( 046,231,{|u| If(PCount()>0,(cVend2:=u,fConsVend(cVend2,2)),cVend2)},oGrp2,033,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"SA3","cVend2",,)
oGet54     := TGet():New( 046,273,{|u| If(PCount()>0,cNomVend2:=u,cNomVend2)},oGrp2,125,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cNomVend2",,)
oGet54:Disable()
oGet54:refresh()

oCBox3     := TCheckBox():New( 088,367,"De  Ate ",{|u| If(PCount()>0,lContDAte:=u,lContDAte)},oDlg1,029,006,,{||fValidMarca(2)},,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
oGrp4      := TGroup():New( 143,000,256,401,"Regras de Comissão",oDlg1,CLR_BLACK,CLR_WHITE,.T.,.F. )
oSay16     := TSay():New( 152,006,{||"Inicio da Vigencia "},oGrp4,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,043,006)
oSay17     := TSay():New( 152,060,{||"Fim da Vigencia "},oGrp4,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,043,006)
oSay18     := TSay():New( 152,120,{||"Parc De "},oGrp4,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,031,006)
oSay19     := TSay():New( 152,152,{||" Parc Ate "},oGrp4,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,031,006)
oSay20     := TSay():New( 152,192,{||"%"},oGrp4,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,010,005)
oGet12     := TGet():New( 159,007,{|u| If(PCount()>0,dVigInic1:=u,dVigInic1)},oGrp4,040,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","dVigInic1",,)
oGet13     := TGet():New( 159,060,{|u| If(PCount()>0,dVigFim1:=u,dVigFim1)},oGrp4,039,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","dVigFim1",,)
oGet14     := TGet():New( 159,121,{|u| If(PCount()>0,nParcDe1:=u,nParcDe1)},oGrp4,018,008,'@E 999',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nParcDe1",,)
oGet15     := TGet():New( 159,153,{|u| If(PCount()>0,nParcFim1:=u,nParcFim1)},oGrp4,019,008,'@E 999',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nParcFim1",,)
oGet17     := TGet():New( 159,188,{|u| If(PCount()>0,nPercent1:=u,nPercent1)},oGrp4,018,008,'@E 999,99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nPercent1",,)

oCBox7     := TCheckBox():New( 159,223,"Agenciamento ?",{|u| If(PCount()>0,lAgenc1:=u,lAgenc1)},oGrp4,049,006,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
oCBox15    := TCheckBox():New( 159,289,"Vendedor 1",{|u| If(PCount()>0,lVend11:=u,lVend11)},oGrp4,039,006,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
oCBox16    := TCheckBox():New( 159,345,"Vendedor 2",{|u| If(PCount()>0,lVend21:=u,lVend21)},oGrp4,045,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
oCBox2     := TCheckBox():New( 168,345,"Vendedor 2",{|u| If(PCount()>0,lVend22:=u,lVend22)},oGrp4,045,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
oCBox8     := TCheckBox():New( 169,289,"Vendedor 1",{|u| If(PCount()>0,lVend12:=u,lVend12)},oGrp4,039,006,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
oCBox9     := TCheckBox():New( 168,223,"Agenciamento ?",{|u| If(PCount()>0,lAgenc2:=u,lAgenc2)},oGrp4,049,006,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
oGet18     := TGet():New( 168,188,{|u| If(PCount()>0,nPercent2:=u,nPercent2)},oGrp4,018,008,'@E 999,99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nPercent2",,)
oGet19     := TGet():New( 169,153,{|u| If(PCount()>0,nParcFim2:=u,nParcFim2)},oGrp4,019,008,'@E 999',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nParcFim2",,)
oGet20     := TGet():New( 169,121,{|u| If(PCount()>0,nParcDe2:=u,nParcDe2)},oGrp4,018,008,'@E 999',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nParcDe2",,)
oGet21     := TGet():New( 169,060,{|u| If(PCount()>0,dVigFim2:=u,dVigFim2)},oGrp4,039,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","dVigFim2",,)
oGet22     := TGet():New( 169,007,{|u| If(PCount()>0,dVigInic2:=u,dVigInic2)},oGrp4,040,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","dVigInic2",,)

//oCBox5:bLostFocus:={|| fverifatv(nAtv, 1 ) } 

oCBox10    := TCheckBox():New( 178,345,"Vendedor 2",{|u| If(PCount()>0,lVend23:=u,lVend23)},oGrp4,045,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
oCBox11    := TCheckBox():New( 178,289,"Vendedor 1",{|u| If(PCount()>0,lVend13:=u,lVend13)},oGrp4,039,006,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
oCBox12    := TCheckBox():New( 178,223,"Agenciamento ?",{|u| If(PCount()>0,lAgenc3:=u,lAgenc3)},oGrp4,049,006,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
oGet23     := TGet():New( 178,188,{|u| If(PCount()>0,nPercent3:=u,nPercent3)},oGrp4,018,008,'@E 999,99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nPercent3",,)
oGet24     := TGet():New( 178,153,{|u| If(PCount()>0,nParcFim3:=u,nParcFim3)},oGrp4,019,008,'@E 999',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nParcFim3",,)
oGet25     := TGet():New( 178,121,{|u| If(PCount()>0,nParcDe3:=u,nParcDe3)},oGrp4,018,008,'@E 999',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nParcDe3",,)
oGet26     := TGet():New( 178,060,{|u| If(PCount()>0,dVigFim3:=u,dVigFim3)},oGrp4,039,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","dVigFim3",,)
oGet27     := TGet():New( 178,007,{|u| If(PCount()>0,dVigInic3:=u,dVigInic3)},oGrp4,040,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","dVigInic3",,)
oCBox13    := TCheckBox():New( 187,345,"Vendedor 2",{|u| If(PCount()>0,lVend24:=u,lVend24)},oGrp4,045,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
oCBox14    := TCheckBox():New( 188,289,"Vendedor 1",{|u| If(PCount()>0,lVend14:=u,lVend14)},oGrp4,039,006,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
oCBox17    := TCheckBox():New( 187,223,"Agenciamento ?",{|u| If(PCount()>0,lAgenc4:=u,lAgenc4)},oGrp4,049,006,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
oGet28     := TGet():New( 187,188,{|u| If(PCount()>0,nPercent4:=u,nPercent4)},oGrp4,018,008,'@E 999,99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nPercent4",,)
oGet29     := TGet():New( 188,153,{|u| If(PCount()>0,nParcFim4:=u,nParcFim4)},oGrp4,019,008,'@E 999',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nParcFim4",,)
oGet30     := TGet():New( 188,121,{|u| If(PCount()>0,nParcDe4:=u,nParcDe4)},oGrp4,018,008,'@E 999',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nParcDe4",,)
oGet31     := TGet():New( 188,060,{|u| If(PCount()>0,dVigFim4:=u,dVigFim4)},oGrp4,039,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","dVigFim4",,)
oGet32     := TGet():New( 188,007,{|u| If(PCount()>0,dVigInic4:=u,dVigInic4)},oGrp4,040,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","dVigInic4",,)
oCBox18    := TCheckBox():New( 196,345,"Vendedor 2",{|u| If(PCount()>0,lVend25:=u,lVend25)},oGrp4,045,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
oCBox19    := TCheckBox():New( 197,289,"Vendedor 1",{|u| If(PCount()>0,lVend15:=u,lVend15)},oGrp4,039,006,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
oCBox20    := TCheckBox():New( 196,223,"Agenciamento ?",{|u| If(PCount()>0,lAgenc5:=u,lAgenc5)},oGrp4,049,006,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
oGet34     := TGet():New( 196,188,{|u| If(PCount()>0,nPercent5:=u,nPercent5)},oGrp4,018,008,'@E 999,99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nPercent5",,)
oGet35     := TGet():New( 197,153,{|u| If(PCount()>0,nParcFim5:=u,nParcFim5)},oGrp4,019,008,'@E 999',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nParcFim5",,)
oGet36     := TGet():New( 197,121,{|u| If(PCount()>0,nParcDe5:=u,nParcDe5)},oGrp4,018,008,'@E 999',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nParcDe5",,)
oGet37     := TGet():New( 197,060,{|u| If(PCount()>0,dVigFim5:=u,dVigFim5)},oGrp4,039,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","dVigFim5",,)
oGet38     := TGet():New( 197,007,{|u| If(PCount()>0,dVigInic5:=u,dVigInic5)},oGrp4,040,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","dVigInic5",,)
oCBox21    := TCheckBox():New( 205,345,"Vendedor 2",{|u| If(PCount()>0,lVend26:=u,lVend26)},oGrp4,045,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
oCBox22    := TCheckBox():New( 206,289,"Vendedor 1",{|u| If(PCount()>0,lVend16:=u,lVend16)},oGrp4,039,006,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
oCBox23    := TCheckBox():New( 205,223,"Agenciamento ?",{|u| If(PCount()>0,lAgenc6:=u,lAgenc6)},oGrp4,049,006,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
oGet39     := TGet():New( 205,188,{|u| If(PCount()>0,nPercent6:=u,nPercent6)},oGrp4,018,008,'@E 999,99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nPercent6",,)
oGet40     := TGet():New( 206,153,{|u| If(PCount()>0,nParcFim6:=u,nParcFim6)},oGrp4,019,008,'@E 999',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nParcFim6",,)
oGet41     := TGet():New( 206,121,{|u| If(PCount()>0,nParcDe6:=u,nParcDe6)},oGrp4,018,008,'@E 999',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nParcDe6",,)
oGet42     := TGet():New( 206,060,{|u| If(PCount()>0,dVigFim6:=u,dVigFim6)},oGrp4,039,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","dVigFim6",,)
oGet43     := TGet():New( 206,007,{|u| If(PCount()>0,dVigInic6:=u,dVigInic6)},oGrp4,040,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","dVigInic6",,)
oCBox24    := TCheckBox():New( 214,345,"Vendedor 2",{|u| If(PCount()>0,lVend27:=u,lVend27)},oGrp4,045,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
oCBox25    := TCheckBox():New( 215,289,"Vendedor 1",{|u| If(PCount()>0,lVend17:=u,lVend17)},oGrp4,039,006,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
oCBox26    := TCheckBox():New( 214,223,"Agenciamento ?",{|u| If(PCount()>0,lAgenc7:=u,lAgenc7)},oGrp4,049,006,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
oGet44     := TGet():New( 214,188,{|u| If(PCount()>0,nPercent7:=u,nPercent7)},oGrp4,018,008,'@E 999,99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nPercent7",,)
oGet45     := TGet():New( 215,153,{|u| If(PCount()>0,nParcFim7:=u,nParcFim7)},oGrp4,019,008,'@E 999',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nParcFim7",,)
oGet46     := TGet():New( 215,121,{|u| If(PCount()>0,nParcDe7:=u,nParcDe7)},oGrp4,018,008,'@E 999',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nParcDe7",,)
oGet47     := TGet():New( 215,060,{|u| If(PCount()>0,dVigFim7:=u,dVigFim7)},oGrp4,039,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","dVigFim7",,)
oGet48     := TGet():New( 215,007,{|u| If(PCount()>0,dVigInic7:=u,dVigInic7)},oGrp4,040,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","dVigInic7",,)
oCBox27    := TCheckBox():New( 224,345,"Vendedor 2",{|u| If(PCount()>0,lVend28:=u,lVend28)},oGrp4,045,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
oCBox28    := TCheckBox():New( 224,289,"Vendedor 1",{|u| If(PCount()>0,lVend18:=u,lVend18)},oGrp4,039,006,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
oCBox29    := TCheckBox():New( 224,223,"Agenciamento ?",{|u| If(PCount()>0,lAgenc8:=u,lAgenc8)},oGrp4,049,006,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
oGet49     := TGet():New( 224,188,{|u| If(PCount()>0,nPercent8:=u,nPercent8)},oGrp4,018,008,'@E 999,99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nPercent8",,)
oGet50     := TGet():New( 224,153,{|u| If(PCount()>0,nParcFim8:=u,nParcFim8)},oGrp4,019,008,'@E 999',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nParcFim8",,)
oGet51     := TGet():New( 224,121,{|u| If(PCount()>0,nParcDe8:=u,nParcDe8)},oGrp4,018,008,'@E 999',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nParcDe8",,)
oGet52     := TGet():New( 224,060,{|u| If(PCount()>0,dVigFim8:=u,dVigFim8)},oGrp4,039,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","dVigFim8",,)
oGet53     := TGet():New( 224,007,{|u| If(PCount()>0,dVigInic8:=u,dVigInic8)},oGrp4,040,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","dVigInic8",,)
oCBox30    := TCheckBox():New( 233,345,"Vendedor 2",{|u| If(PCount()>0,lVend29:=u,lVend29)},oGrp4,045,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
oCBox31    := TCheckBox():New( 233,289,"Vendedor 1",{|u| If(PCount()>0,lVend19:=u,lVend19)},oGrp4,039,006,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
oCBox32    := TCheckBox():New( 233,223,"Agenciamento ?",{|u| If(PCount()>0,lAgenc9:=u,lAgenc9)},oGrp4,049,006,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
oGet56     := TGet():New( 233,188,{|u| If(PCount()>0,nPercent9:=u,nPercent9)},oGrp4,018,008,'@E 999,99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nPercent9",,)
oGet57     := TGet():New( 233,153,{|u| If(PCount()>0,nParcFim9:=u,nParcFim9)},oGrp4,019,008,'@E 999',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nParcFim9",,)
oGet58     := TGet():New( 233,121,{|u| If(PCount()>0,nParcDe9:=u,nParcDe9)},oGrp4,018,008,'@E 999',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nParcDe9",,)
oGet59     := TGet():New( 233,060,{|u| If(PCount()>0,dVigFim9:=u,dVigFim9)},oGrp4,039,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","dVigFim9",,)
oGet60     := TGet():New( 233,007,{|u| If(PCount()>0,dVigInic9:=u,dVigInic9)},oGrp4,040,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","dVigInic9",,)
oCBox33    := TCheckBox():New( 242,345,"Vendedor 2",{|u| If(PCount()>0,lVend210:=u,lVend210)},oGrp4,045,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
oCBox34    := TCheckBox():New( 243,289,"Vendedor 1",{|u| If(PCount()>0,lVend110:=u,lVend110)},oGrp4,039,006,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
oCBox35    := TCheckBox():New( 242,223,"Agenciamento ?",{|u| If(PCount()>0,lAgenc10:=u,lAgenc10)},oGrp4,049,006,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
oGet62     := TGet():New( 242,188,{|u| If(PCount()>0,nPercent10:=u,nPercent10)},oGrp4,018,008,'@E 999,99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nPercent10",,)
oGet63     := TGet():New( 243,153,{|u| If(PCount()>0,nParcFim10:=u,nParcFim10)},oGrp4,019,008,'@E 999',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nParcFim10",,)
oGet64     := TGet():New( 243,121,{|u| If(PCount()>0,nParcDe10:=u,nParcDe10)},oGrp4,018,008,'@E 999',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nParcDe10",,)
oGet65     := TGet():New( 243,060,{|u| If(PCount()>0,dVigFim10:=u,dVigFim10)},oGrp4,039,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","dVigFim10",,)
oGet66     := TGet():New( 243,007,{|u| If(PCount()>0,dVigInic10:=u,dVigInic10)},oGrp4,040,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","dVigInic10",,)
oGrp5      := TGroup():New( 000,000,028,401,"Controle",oDlg1,CLR_BLACK,CLR_WHITE,.T.,.F. )
oSay23     := TSay():New( 006,069,{||"Usuario da ação "},oGrp5,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,043,006)
oSay24     := TSay():New( 006,010,{||"Situação"},oGrp5,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,025,006)

oBtn2      := TButton():New( 015,237,"Excluir",oGrp5,{||fExclui()},050,009,,,,.T.,,"",,,,.F. )
oBtn1      := TButton():New( 005,344,"Implantar",oGrp5,{||fImplanta()},050,009,,,,.T.,,"",,,,.F. )
oGet61     := TGet():New( 012,009,{|u| If(PCount()>0,cSituacao:=u,cSituacao)},oGrp5,055,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cSituacao",,)
oGet61:Disable()
oBtn3      := TButton():New( 015,290,"Aprovar",oGrp5,{||fAprova()},050,009,,,,.T.,,"",,,,.F. )
oBtn4      := TButton():New( 005,290,"Revisada",oGrp5,{||fRevisa(),fVerAlt()},050,009,,,,.T.,,"",,,,.F. )
oBtn5      := TButton():New( 015,344,"&Sair",oGrp5,{||oDlg1:End()},050,010,,,,.T.,,"",,,,.F. )
oBtn6      := TButton():New( 005,237,"Gravar",oGrp5,{||fGrava()},050,009,,,,.T.,,"",,,,.F. )

oGet67     := TGet():New( 012,068,{|u| If(PCount()>0,cUsuar :=u,cUsuar )},oGrp5,160,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cUsuar",,)
oGet67:Disable()
oGrp6      := TGroup():New( 258,000,328,400,"Obsevações",oDlg1,CLR_BLACK,CLR_WHITE,.T.,.F. )
oMGet1     := TMultiGet():New( 264,003,{|u| If(PCount()>0,cObserv:=u,cObserv)},oGrp6,393,062,,,CLR_BLACK,CLR_WHITE,,.T.,"",,,.F.,.F.,.T.,,,.F.,,  )
oGrp3      := TGroup():New( 104,000,144,402,"Identificação  do  Sub Contrato",oDlg1,CLR_BLACK,CLR_WHITE,.T.,.F. )
oSay5      := TSay():New( 119,015,{||"Sub Contrato "},oGrp3,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,034,006)
oSay6      := TSay():New( 119,076,{||"Nome Sub Contrato "},oGrp3,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,048,006)
oSay12     := TSay():New( 111,006,{||"Do Sub Contrato De "},oGrp3,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,049,006)
oSay13     := TSay():New( 119,250,{||"Nome Sub Contrato "},oGrp3,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,051,006)
oSay14     := TSay():New( 119,189,{||"Sub Contrato "},oGrp3,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,036,006)
oSay15     := TSay():New( 111,172,{||"Ao  Sub Contrato Ate "},oGrp3,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,058,006)

//oGet5      := TGet():New( 127,015,{|u| If(PCount()>0,cSubContInc:=u,cSubContInc)},oGrp3,053,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"BQC185","cSubContInc",,)
oGet5      := TGet():New( 127,015,{|u| If(PCount()>0,(cSubContInc:=u,fConscont(3),oGet5:refresh()),cSubContInc)},oGrp3,053,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"BQC185","cSubContInc",,)

oGet5:Disable()
oGet6      := TGet():New( 127,075,{|u| If(PCount()>0,cNSCInic:=u,cNSCInic)},oGrp3,107,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cNSCInic",,)
oGet6:Disable()
oGet10     := TGet():New( 127,249,{|u| If(PCount()>0,cNSCFinal:=u,cNSCFinal)},oGrp3,107,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cNSCFinal",,)
oGet10:Disable()
oGet11     := TGet():New( 127,189,{|u| If(PCount()>0,(cSubContFim:=u,fConscont(4),oGet11:refresh()),cSubContFim)},oGrp3,051,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"BQC185","cSubContFim",,)

oGet11:Disable()
oCBox4     := TCheckBox():New( 119,367,"Todos ",{|u| If(PCount()>0,lSContTodo:=u,lSContTodo)},oGrp3,029,006,,{||fValidMarca(3)},,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
oCBox5     := TCheckBox():New( 128,367,"De Ate",{|u| If(PCount()>0,lSContDAte:=u,lSContDAte)},oGrp3,029,006,,{||fValidMarca(4)},,,CLR_BLACK,CLR_WHITE,,.T.,"",, )

fVerBoton()

oDlg1:Activate(,,,.T.)

Return


static  Function fValidMarca(Ident)

If Ident == 1
    
    if  lContTodo 
    
        lContDAte:= .F.
        oCBox1:ctrlrefresh() 
        oCBox3:ctrlrefresh()
        oGet4:Disable()
        oGet3:Disable()
        oGet8:Disable()   
        oGet9:Disable()
        cNCInic :='Todos '
        cNCFinal:='Todos ' 
        cContInic:='000000000001'
        cContFinal:='999999999999'

    Else 

        lContTodo:= .T.   
        oCBox1:ctrlrefresh() 
        oCBox3:ctrlrefresh()  
        cNCInic :=' '
        cNCFinal:=' ' 
        cContInic:=' '
        cContFinal:=' '

    EndIf 

ElseIf Ident == 2
    
    If lContDAte 
    
        lContTodo := .F.
        oCBox1:ctrlrefresh() 
        oCBox3:ctrlrefresh()
        oGet3:Enable()
        oGet9:Enable()

    Else

            lContDAte:= .T.
            oCBox1:ctrlrefresh() 
            oCBox3:ctrlrefresh()     

        EndIf     

    ElseIf Ident == 3

        if lSContTodo 

            lSContDAte := .F.
            oCBox5:ctrlrefresh() 
            oCBox4:ctrlrefresh()
            oGet5:Disable()
            oGet6:Disable()
            oGet10:Disable()   
            oGet11:Disable()
            cSubContInc:= '000000001'
            cSubContFim:= '999999999'
            cNSCInic:='Todos'
            cNSCFinal:='Todos'

        Else 

            lSContTodo:= .T.
            oCBox5:ctrlrefresh() 
            oCBox4:ctrlrefresh()
            cSubContInc:= ' '
            cSubContFim:= ' '
            cNSCInic:='  '
            cNSCFinal:=' '

        EndIf     

    ElseIf  Ident == 4

        if  lSContDAte  

            lSContTodo := .F.
            oCBox5:ctrlrefresh() 
            oCBox4:ctrlrefresh()
            oGet5:Enable()
            oGet11:Enable()

        Else 

            lSContDAte:=.T.
            oCBox5:ctrlrefresh() 
            oCBox4:ctrlrefresh() 

        EndIf    

    EndIf

return


static function fExclui()

cDthr      := (dtos(DATE()) + "-" + Time())   

cSituacao:= 'Excluida'
cUsuar := "Usuario : "+_cIdUsuar+' - ' +_cUsuar + " Data Hora Ação " +cDthr

fGvObs(1)

fVerBoton()

Return()

static Function fImplanta()

cDthr      := (dtos(DATE()) + "-" + Time())   

cSituacao:= 'Implantada'
cUsuar := "Usuario : "+_cIdUsuar+' - ' +_cUsuar + " Data Hora Ação " +cDthr

fGvObs(1)

fVerBoton()

Return()

static function fAprova()

cDthr      := (dtos(DATE()) + "-" + Time())   

cSituacao:= 'Aprovada '
cUsuar := "Usuario : "+_cIdUsuar+' - ' +_cUsuar + " Data Hora Ação " +cDthr

fGvObs(1)

fVerBoton()

Return 

Static Function fRevisa()

cDthr      := (dtos(DATE()) + "-" + Time())   

cSituacao:= 'Revisada'
cUsuar := "Usuario : "+_cIdUsuar+' - ' +_cUsuar + " Data Hora Ação " +cDthr

fGvObs(1)

fVerBoton()

Return 

Static Function fGrava()

fcritica1() 

cDthr      := (dtos(DATE()) + "-" + Time())   

cSituacao:= 'Incluida'
cUsuar := "Usuario : "+_cIdUsuar+' - ' +_cUsuar + " Data Hora Ação " +cDthr

fGvObs(1)

fVerBoton()

Return 

static Function fGvObs(Idetobs)

If Idetobs == 1
   cObserv+= CRLF + '--> Ação ' + cSituacao  
   cObserv+= CRLF + '-->' + cUsuar  
endIf 

Return 

STATIC Function fVerAlt()

Return

Static Function fVerBoton()

    If empty(cSituacao)
    
        oBtn2:Disable()
        oBtn1:Disable()
        oBtn3:Disable()
        oBtn4:Disable()
        oBtn6:Enable()
        oBtn5:Enable()

    ElseIf trim(cSituacao) =='Excluida'
    
        oBtn2:Disable()
        oBtn1:Disable()
        oBtn3:Disable()
        oBtn4:Disable()
        oBtn6:Disable()
        oBtn5:Enable()
        fbloqexec()

    ElseIf trim(cSituacao) =='Incluida'
    
        oBtn2:Enable()
        oBtn1:Disable()
        oBtn3:Disable()
        oBtn4:Enable()
        oBtn6:Disable()
        oBtn5:Enable()

    ElseIf trim(cSituacao) =='Revisada'
    
        oBtn2:Enable()
        oBtn1:Disable()
        oBtn3:Enable()
        oBtn4:Disable()
        oBtn6:Disable()
        oBtn5:Enable()

    ElseIf trim(cSituacao) =='Aprovada'
    
        If _cIdUsuar == '000310'
            oBtn2:Enable()
        Else 
            oBtn2:Disable()
        EndIf  

        oBtn1:Enable()
        oBtn3:Disable()
        oBtn4:Disable()
        oBtn6:Disable()
        oBtn5:Enable()

    ElseIf trim(cSituacao) == 'Implantada'
    
        oBtn2:Disable()
        oBtn1:Disable()
        oBtn3:Disable()
        oBtn4:Disable()
        oBtn6:Disable()
        oBtn5:Enable()
    EndIf                         

Return

Static Function fbloqexec()

oGet3:Disable()
oGet4:Disable()
oGet8:Disable()
oGet9:Disable()
oCBox1:Disable()
oGet7:Disable()
oGet1:Disable()
oGet2:Disable()
oGet16:Disable()
oGet33:Disable()
oGet54:Disable()
oGet55:Disable()
oCBox3:Disable()
oGet12:Disable() 
oGet13:Disable() 
oGet14:Disable() 
oGet15:Disable() 
oGet17:Disable() 
oCBox7:Disable() 
oCBox15:Disable()
oCBox16:Disable()
oCBox2:Disable()
oCBox8:Disable()
oCBox9:Disable()
oGet18:Disable()
oGet19:Disable()
oGet20:Disable()
oGet21:Disable()
oGet22:Disable()
oCBox10:Disable()
oCBox11:Disable()
oCBox12:Disable()
oGet23:Disable()
oGet24:Disable()
oGet25:Disable()
oGet26:Disable()
oGet27:Disable()
oCBox13:Disable()
oCBox14:Disable()
oCBox17:Disable()
oGet28:Disable()
oGet29:Disable()
oGet30:Disable()
oGet31:Disable()
oGet32:Disable()
oCBox18:Disable()
oCBox19:Disable()
oCBox20:Disable()
oGet34:Disable()
oGet35:Disable()
oGet36:Disable()
oGet37:Disable()
oGet38:Disable()
oCBox21:Disable()
oCBox22:Disable()
oCBox23:Disable()
oGet39:Disable()
oGet40:Disable()
oGet41:Disable()
oGet42:Disable()
oGet43:Disable()
oCBox24:Disable()
oCBox25:Disable()
oCBox26:Disable()
oGet44:Disable()
oGet45:Disable()
oGet46:Disable()
oGet47:Disable()
oGet48:Disable()
oCBox27:Disable()
oCBox28:Disable()
oCBox29:Disable()
oGet49:Disable()
oGet50:Disable()
oGet51:Disable()
oGet52:Disable()
oGet53:Disable()
oCBox30:Disable()
oCBox31:Disable()
oCBox32:Disable()
oGet56:Disable()
oGet57:Disable()
oGet58:Disable()
oGet59:Disable()
oGet60:Disable()
oCBox33:Disable()
oCBox34:Disable()
oCBox35:Disable()
oGet62:Disable()
oGet63:Disable()
oGet64:Disable()
oGet65:Disable()
oGet66:Disable()
oGet61:Disable()
oGet67:Disable()
oMGet1:Disable()
oGet5:Disable()
oGet6:Disable()
oGet10:Disable()
oGet11:Disable()
oCBox4:Disable()
oCBox5:Disable()

return 


Static Function fConsEmp(cCod )

cCompara:='0001'+cCod
cNomEmp:= Posicione("BG9",1,xFilial("BG9")+cCompara,"BG9_DESCRI")

return(cCod)


Static Function fConsVend( cVend , ind )

If ind == 1
   cNomVend1:=Posicione("SA3",1,xFilial("SA3")+cVend,"A3_NOME")
Else 
   cNomVend2:=Posicione("SA3",1,xFilial("SA3")+cVend,"A3_NOME")
EndIf   

return(cVend)


Static Function fCritica1()

Local lret := .T.

if empty(dVigInic1)
   Alert("Data de Vigencia Inicial Não pode ser branco - DATA INVALIADA ")
   lret := .F.
ElseIf dVigInic1 > dVigFim1 .and. !empty(dVigFim1) 
   Alert("Data de Vigencia Inicial Não pode ser Maior que a DATA FINAL - DATA FINAL INVALIADA ")
   lret := .F.
EndIf 

If (!lVend11 .and. !lVend12)
   Alert("O vendedor deve ser apontado , vendedor 1 , vendedor 2 ou os dois vendedores - VENDEDOR NAO APONTADO ")
   lret := .F.
EndIf 

If nPercent1 == 0
   Alert("Percentual Nao pode ser ZERO - PRECENTUAL ZERADO ")
   lret := .F.
EndIf 

If nParcDe1 == 0
   Alert("Percela De Nao pode ser ZERO - PARCELA DE IGUAL A ZERO ")
   lret := .F.
EndIf

If nParcDe1 > nParcFim1
   Alert("Percela De Nao pode maior que a parcela ATE - PARCELA DE MAIOR QUE PARCELA ATE ")
   lret := .F.
EndIf

If nPercent1 > 10 .and. !lAgenc1 
   Alert("Percentual Maior que 10 % e nao é Agenciamento , Por Favor Verifique -AGENCIAMENTO NAO MARCADO ")
EndIf    

Return

Static Function fCritica2()

Local lret := .T.

if empty(dVigInic2)
   Alert("Data de Vigencia Inicial Não pode ser branco - DATA INVALIADA ")
   lret := .F.
ElseIf dVigInic2 > dVigFim2 .and. !empty(dVigFim2) 
   Alert("Data de Vigencia Inicial Não pode ser Maior que a DATA FINAL - DATA FINAL INVALIADA ")
   lret := .F.
EndIf 

If dVigInic1 > dVigInic2 
   Alert("Data de Vigencia - 2 Inicial Não pode ser Maior que a Vigencia 2 - DATA VIGENCIA 2 INVALIADA ")
   lret := .F.
EndIf 

If dVigFim1 > dVigFim2 
   Alert("Data de Vigencia - 2 Final Não pode ser Maior que a Vigencia 2 - DATA VIGENCIA 2 INVALIADA ")
   lret := .F.
EndIf 

If dVigInic1 == dVigInic2 .and. dVigFim1 != dVigFim2 
   Alert("Data de Vigencia - Inicial igual a anterior , mas Vigencia Final Não pode ser Diferente a Vigencia Aneterior - DATA VIGENCIA INVALIADA ")
   lret := .F.
EndIf 

If (!lVend21 .and. !lVend22)
   Alert("O vendedor deve ser apontado , vendedor  , vendedor 2 ou os dois vendedores - VENDEDOR NAO APONTADO ")
   lret := .F.
EndIf 

If nPercent2 == 0
   Alert("Percentual Nao pode ser ZERO - PRECENTUAL ZERADO ")
   lret := .F.
EndIf 

If nParcDe2 == 0
   Alert("Percela De Nao pode ser ZERO - PARCELA DE IGUAL A ZERO ")
   lret := .F.
EndIf

If nParcDe1 > nParcFim2
   Alert("Percela De Nao pode maior que a parcela ATE - PARCELA DE MAIOR QUE PARCELA ATE ")
   lret := .F.
EndIf
If nPercent2 > 10 .and. !lAgenc2 
   Alert("Percentual Maior que 10 % e nao é Agenciamento , Por Favor Verifique -AGENCIAMENTO NAO MARCADO ")
EndIf    

Return

static function fConscont(IND)

If Empty(cCodEmp)

   Alert("Informe A Empresa , Por Favor Verifique - Identificação da Empresa NÃO pode ser Branco")

   cContInic  := ' ' 
   cContFinal := ' '
   cSubContInc:= ' ' 
   cSubContFim:= ' '

Else 

    If  ind == 1 

        If  Empty(cContInic)

            Alert("Informe o Contrato Inicial  , Por Favor Verifique - Identificação do Contrato Inicial NÃO pode ser Branco")

        Else

            cNCInic:=Posicione("BQC",1,xFilial("BQC")+'0001'+cCodEmp+cContInic+'001',"BQC_DESCRI")

        EndIf     

    ElseIf  ind == 2  

        If  Empty(cContFinal)

            Alert("Informe o Contrato Final , Por Favor Verifique - Identificação do Contrato Finall NÃO pode ser Branco")

        Else

           cNCFinal:=Posicione("BQC",1,xFilial("BQC")+'0001'+cCodEmp+cContFinal+'001',"BQC_DESCRI")

        EndIf

    ElseIf  ind == 3 

        If  Empty(cSubContInc) 

            Alert("Informe o SubContrato Inicial  , Por Favor Verifique - Identificação do SubContrato Inicial NÃO pode ser Branco")
        
        Else

            cNSCInic:=Posicione("BQC",6,xFilial("BQC")+'0001'+cCodEmp+cContInic+cSubContInc,"BQC_DESCRI")

        EndIf     

    ElseIf  ind == 4 

        If  Empty(cSubContFim) 

            Alert("Informe o SubContrato Inicial  , Por Favor Verifique - Identificação do SubContrato Inicial NÃO pode ser Branco")
        
        Else

            cNSCFinal:=Posicione("BQC",6,xFilial("BQC")+'0001'+cCodEmp+cContInic+cSubContFim,"BQC_DESCRI")

        EndIf     

   EndIf   

EndIf

Return()

static function fCalDat(Ddata)

local cDia := Val(substr(Ddata,7,2))
local cMes := Val(substr(Ddata,5,2))
local cAno := Val(substr(Ddata,1,4))

If  cMes $( '03|05|07|09|11' )

    If cDia++ > 30
   
       cMes++
       cDia:= 01
    
    Else 
   
       cDia++
   
    EndIf      

ElseIf  cMes $( '01|03|06|08|10|12' )

    If  cMes != 12
    
        If  cDia++ > 31    
    
            cMes++
            cDia:= 01
    
        Else 
    
            cDia++
    
        EndIf

    Else

        If  cDia++ > 31    
    
            cMes:= 01
            cDia:= 01
            cAno++
    
        Else 
    
            cDia++
    
        EndIf  
    EndIf     

ElseIf  cMes == '02'

    If  cDia++ > 28    
   
        cMes++
        cDia:= 01
   
    Else 
   
        cDia++
   
    EndIf  

EndIf

Return(strzero(cAno)+strzero(cMes)+strzero(cDia))