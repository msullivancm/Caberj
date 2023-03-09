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

User Function caba122(cAlias,nReg,nOpc) 

/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±± Declaração de cVariable dos componentes                                 ±±
Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/

Private cClsRed    := Space(1)
Private cContSe2   := Space(1)
Private cCptAn1    := Space(1)
Private cCptAn2    := Space(1)
Private cCptAn3    := Space(1)
Private cCptAt0    := Space(1)
Private cCptPgt    := Space(1)
Private cDescPg    := Space(1)
Private cSeq       := Space(1)
Private cSldRec    := Space(1)
Private cTp        := Space(1)
Private nAtv0      := ' '
Private nAtv1      := ' '
Private nAtv2      := ' '
Private nAtv3      := ' '
Private nCptRec    := 0
Private nOrdena    := ' '
Private nPercCus   := 0
Private nPreCal    := 0
Private nPrecSd    := 0
Private nPrEst0    := 0
Private nPrEst1    := 0
Private nPrEst2    := 0
Private nPrEst3    := 0
Private nPrRea0    := 0
Private nPrRea1    := 0
Private nPrRea2    := 0
Private nPrRea3    := 0
Private nSlEst0    := 0
Private nSlEst1    := 0
Private nSlEst2    := 0
Private nSlEst3    := 0
Private nStatus    := ' '
Private nVlEst0    := 0
Private nVlEst1    := 0
Private nVlEst2    := 0
Private nVlEst3    := 0
Private nVlrTot    := 0
Private nVlTRec    := 0
Private nVRea0     := 0
Private nVRea1     := 0
Private nVRea2     := 0
Private nVRea3     := 0

private nAtv       := ' ' 
///////

PRIVATE  nRecno    := 0

/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±± Declaração de Variaveis Private dos Objetos                             ±±
Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/
SetPrvt("oDlg1","oGrp1","oSay1","oSay2","oSay3","oSay6","oSay5","oSay10","oSay11","oSay16","oSay46","oSay8")
SetPrvt("oGet2","oGet3","oGet6","oGet5","oGet10","oGrp2","oSay4","oSay22","oCBox3","oGet8","oGrp4","oSay17")
SetPrvt("oSay19","oSay20","oSay21","oGet17","oGet18","oGet19","oGet20","oGet4","oGrp5","oBtn13","oBtn8")
SetPrvt("oBtn9","oBtn10","oCBox1","oCBox2","oGrp8","oSay24","oSay26","oCBox5","oGet16","oGrp11","oSay32")
SetPrvt("oCBox6","oGet27","oGrp14","oSay39","oSay40","oCBox7","oGet33","oGet39","oGrp7","oSay23","oSay25")
SetPrvt("oGet21","oGrp6","oSay12","oSay9","oSay7","oGet12","oGet9","oGet7","oGrp10","oSay30","oSay31")
SetPrvt("oGet26","oGrp9","oSay27","oSay28","oSay29","oGet22","oGet23","oGet24","oGrp13","oSay37","oSay38")
SetPrvt("oGet32","oGrp12","oSay34","oSay35","oSay36","oGet28","oGet29","oGet30","oGrp16","oSay44","oSay45")
SetPrvt("oGet38","oGrp15","oSay41","oSay42","oSay43","oGet34","oGet35","oGet36","oGet13")


If nopc == 3 
   cNumCab:=fProxNum() 
else       
   	 dbselectarea("PCI")
     DbGoto(nReg)
     fMovArqVar()
EndIf             

/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±± Definicao do Dialog e todos os seus componentes.                        ±±
Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/
oDlg1      := MSDialog():New( 095,320,661,1060,"Parametros de Pagamento ",,,.F.,,,,,,.T.,,,.T. )
oGrp1      := TGroup():New( 000,000,276,364,"Manutenção dos Parametros",oDlg1,CLR_BLACK,CLR_WHITE,.T.,.F. )
oSay1      := TSay():New( 012,088,{||"Compet/Emissão"},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,044,008)
oSay2      := TSay():New( 032,012,{||"Descrição Item Pagto   "},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,064,008)
oSay3      := TSay():New( 056,064,{||"Vlr Total a Priorizar "},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,048,008)
oSay6      := TSay():New( 056,139,{||"% Custo  "},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,029,008)
oSay5      := TSay():New( 012,008,{||"Seq."},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,016,008)
oSay10     := TSay():New( 012,040,{||"Tipo"},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay11     := TSay():New( 012,144,{||"Status"},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay16     := TSay():New( 056,196,{||"Ordenar por : "},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay46     := TSay():New( 056,008,{||"Clas. Rede"},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay8      := TSay():New( 056,292,{||"Controle "},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oGet1      := TGet():New( 020,088,{|u| If(PCount()>0,cCptPgt:=u,cCptPgt)},oGrp1,044,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cCptPgt",,)
oGet2      := TGet():New( 040,008,{|u| If(PCount()>0,cDescPg:=u,cDescPg)},oGrp1,208,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cDescPg",,)
oGet3      := TGet():New( 064,064,{|u| If(PCount()>0,nVlrTot:=u,nVlrTot)},oGrp1,048,008,'@E 9,999,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrTot",,)
oGet6      := TGet():New( 064,140,{|u| If(PCount()>0,nPercCus:=u,nPercCus)},oGrp1,028,008,'@E 999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nPercCus",,)
oGet5      := TGet():New( 020,008,{|u| If(PCount()>0,cSeq:=u,cSeq)},oGrp1,012,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cSeq",,)
oGet10     := TGet():New( 020,040,{|u| If(PCount()>0,cTp:=u,cTp)},oGrp1,032,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cTp",,)
oGrp2      := TGroup():New( 108,004,148,086,"Competencia Atual",oGrp1,CLR_BLACK,CLR_WHITE,.T.,.F. )
oSay4      := TSay():New( 116,040,{||"Prioridade"},oGrp2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay22     := TSay():New( 116,005,{||"Competencia"},oGrp2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oCBox3     := TComboBox():New( 128,040,{|u| If(PCount()>0,nAtv0:=u,nAtv0)},{"Sim","Não"},044,010,oGrp2,,,,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,,nAtv0 )
nAtv := nAtv0  
oCBox3:bLostFocus:={|| fverifatv(nAtv, 0 ) }  
oGet8      := TGet():New( 128,005,{|u| If(PCount()>0,cCptAt0:=u,cCptAt0)},oGrp2,032,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cCptAt0",,)
oGrp4      := TGroup():New( 076,004,108,356,"Receita",oGrp1,CLR_BLACK,CLR_WHITE,.T.,.F. )
oSay17     := TSay():New( 082,088,{||"Vlr Receita Total "},oGrp4,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,056,008)
oSay18     := TSay():New( 084,248,{||"% Destinado "},oGrp4,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,040,008)
oSay19     := TSay():New( 082,020,{||"Comp da Receita "},oGrp4,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,048,008)
oSay20     := TSay():New( 084,312,{||"% Saldo "},oGrp4,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,040,008)
oSay21     := TSay():New( 084,168,{||"Saldo Receita "},oGrp4,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,044,008)
oGet17     := TGet():New( 092,088,{|u| If(PCount()>0,nVlTRec:=u,nVlTRec)},oGrp4,060,008,'@E 9,999,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlTRec",,)
oGet18     := TGet():New( 092,248,{|u| If(PCount()>0,nPreCal:=u,nPreCal)},oGrp4,036,008,'@E 999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nPreCal",,)
oGet19     := TGet():New( 092,020,{|u| If(PCount()>0,nCptRec:=u,nCptRec)},oGrp4,036,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nCptRec",,)
oGet20     := TGet():New( 092,312,{|u| If(PCount()>0,nPrecSd:=u,nPrecSd)},oGrp4,040,008,'@E 999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nPrecSd",,)
oGet4      := TGet():New( 092,168,{|u| If(PCount()>0,cSldRec:=u,cSldRec)},oGrp4,060,008,'@E 9,999,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cSldRec",,)
oGrp5      := TGroup():New( 004,220,052,356,"Menu ",oGrp1,CLR_BLACK,CLR_WHITE,.T.,.F. )
oBtn13     := TButton():New( 036,224,"Sair",oGrp5,{||oDlg1:End()},044,012,,,,.T.,,"",,,,.F. )
oBtn8      := TButton():New( 024,224,"Deleta",oGrp5,{ ||fDeletaArq() },044,012,,,,.T.,,"",,,,.F. )
oBtn7      := TButton():New( 012,224,"Grava",oGrp5,{ ||fMovVarArq() },044,012,,,,.T.,,"",,,,.F. )
oBtn9      := TButton():New( 012,304,"Liberar",oGrp5,{ ||u_caba124(cCompEmi,substr(cDescItPg,1,4) , cClsRed ,  1 ), oDlg1:End() },044,012,,,,.T.,,"",,,,.F. )
oBtn10     := TButton():New( 036,304,"Borderô",oGrp5,{ ||u_caba124(cCompEmi,substr(cDescItPg,1,4) , cClsRed ,  2 ) },044,012,,,,.T.,,"",,,,.F. )
oCBox1     := TComboBox():New( 064,196,{|u| If(PCount()>0,nOrdena:=u,nOrdena)},{"Vlr Maior -> Menor","Vlr Menor -> Maior ","Num Titulos","Cod Fornecedor ","Cod Rda ","Vencimento"},072,010,oGrp1,,,,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,,nOrdena )
oCBox2     := TComboBox():New( 020,144,{|u| If(PCount()>0,nStatus:=u,nStatus)},{"Ativo","Concluido","Suspenco ","Cancelado"},072,010,oGrp1,,,,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,,nStatus )
oGrp8      := TGroup():New( 150,004,189,086,"Competencia Anterior 1",oGrp1,CLR_BLACK,CLR_WHITE,.T.,.F. )
oSay24     := TSay():New( 158,040,{||"Prioridade"},oGrp8,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay26     := TSay():New( 158,005,{||"Competencia"},oGrp8,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oCBox5     := TComboBox():New( 170,040,{|u| If(PCount()>0,nAtv1:=u,nAtv1)},{"Sim","Não"},044,010,oGrp8,,,,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,,nAtv1 )    
nAtv := nAtv1  
oCBox5:bLostFocus:={|| fverifatv(nAtv, 1 ) } 
oGet16     := TGet():New( 170,005,{|u| If(PCount()>0,cCptAn1:=u,cCptAn1)},oGrp8,032,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cCptAn1",,)
oGrp11     := TGroup():New( 191,004,230,086,"Competencia Anterior 2",oGrp1,CLR_BLACK,CLR_WHITE,.T.,.F. )
oSay32     := TSay():New( 199,040,{||"Prioridade"},oGrp11,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay33     := TSay():New( 199,005,{||"Competencia"},oGrp11,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oCBox6     := TComboBox():New( 211,040,{|u| If(PCount()>0,nAtv2:=u,nAtv2)},{"Sim","Não"},044,010,oGrp11,,,,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,,nAtv2 )
nAtv := nAtv2  
oCBox6:bLostFocus:={|| fverifatv(nAtv, 2 ) } 
oGet27     := TGet():New( 211,005,{|u| If(PCount()>0,cCptAn2:=u,cCptAn2)},oGrp11,032,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cCptAn2",,)
oGrp14     := TGroup():New( 232,004,271,086,"Competencia Anteriores 3",oGrp1,CLR_BLACK,CLR_WHITE,.T.,.F. )
oSay39     := TSay():New( 240,040,{||"Prioridade"},oGrp14,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay40     := TSay():New( 240,005,{||"Competencia"},oGrp14,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oCBox7     := TComboBox():New( 252,040,{|u| If(PCount()>0,nAtv3:=u,nAtv3)},{"Sim","Não"},044,010,oGrp14,,,,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,,nAtv3 )
nAtv := nAtv3  
oCBox7:bLostFocus:={|| fverifatv(nAtv, 3 ) } 
oGet33     := TGet():New( 252,005,{|u| If(PCount()>0,cCptAn3:=u,cCptAn3)},oGrp14,032,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cCptAn3",,)
oGet39     := TGet():New( 064,008,{|u| If(PCount()>0,cClsRed:=u,cClsRed)},oGrp1,028,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cClsRed",,)
oGrp7      := TGroup():New( 109,241,148,356,"Realizado Atual",oGrp1,CLR_BLACK,CLR_WHITE,.T.,.F. )
oSay23     := TSay():New( 117,245,{||"Vlr Total Priorizar  "},oGrp7,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,045,008)
oSay25     := TSay():New( 117,305,{||" %"},oGrp7,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,029,008)
oGet11     := TGet():New( 129,245,{|u| If(PCount()>0,nVRea0:=u,nVRea0)},oGrp7,048,008,'@E 9,999,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVRea0",,)
oGet21     := TGet():New( 129,306,{|u| If(PCount()>0,nPrRea0:=u,nPrRea0)},oGrp7,043,008,'@E 999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nPrRea0",,)
oGrp6      := TGroup():New( 109,088,148,240,"Estimado Atual",oGrp1,CLR_BLACK,CLR_WHITE,.T.,.F. )
oSay12     := TSay():New( 117,092,{||"Vlr Total Priorizar  "},oGrp6,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,045,008)
oSay9      := TSay():New( 117,144,{||"Saldo a Priorzar "},oGrp6,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,048,008)
oSay7      := TSay():New( 117,192,{||" %"},oGrp6,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,029,008)
oGet12     := TGet():New( 129,092,{|u| If(PCount()>0,nVlEst0:=u,nVlEst0)},oGrp6,048,008,'@E 9,999,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nVlEst0",,)  
If nVlEst0 > 0
   oGet9      := TGet():New( 129,144,{|u| If(PCount()>0,nSlEst0:=u,nSlEst0)},oGrp6,043,008,'@E 9,999,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nSlEst0",,)
   oGet9:bLostFocus:={|| fFazSaldo() } 
Else                                                                                                                                                                              
   oGet9      := TGet():New( 129,144,{|u| If(PCount()>0,nSlEst0:=u,nSlEst0)},oGrp6,043,008,'@E 9,999,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nSlEst0",,)
EndIf         
oGet7      := TGet():New( 129,193,{|u| If(PCount()>0,nPrEst0:=u,nPrEst0)},oGrp6,043,008,'@E 999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nPrEst0",,)
oGrp10     := TGroup():New( 150,241,188,356,"Realizado Ant1",oGrp1,CLR_BLACK,CLR_WHITE,.T.,.F. )
oSay30     := TSay():New( 159,245,{||"Vlr Total Priorizar  "},oGrp10,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,045,008)
oSay31     := TSay():New( 159,305,{||" %"},oGrp10,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,029,008)
oGet25     := TGet():New( 170,245,{|u| If(PCount()>0,nVRea1:=u,nVRea1)},oGrp10,048,008,'@E 9,999,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVRea1",,)
oGet26     := TGet():New( 170,306,{|u| If(PCount()>0,nPrRea1:=u,nPrRea1)},oGrp10,043,008,'@E 999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nPrRea1",,)
oGrp9      := TGroup():New( 150,088,188,240,"Estimado Ant1",oGrp1,CLR_BLACK,CLR_WHITE,.T.,.F. )
oSay27     := TSay():New( 159,092,{||"Vlr Total Priorizar  "},oGrp9,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,045,008)
oSay28     := TSay():New( 159,144,{||"Saldo a Priorzar "},oGrp9,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,048,008)
oSay29     := TSay():New( 159,192,{||" %"},oGrp9,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,029,008)
oGet22     := TGet():New( 170,092,{|u| If(PCount()>0,nVlEst1:=u,nVlEst1)},oGrp9,048,008,'@E 9,999,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nVlEst1",,)
If nVlEst1 > 0
   oGet23     := TGet():New( 170,144,{|u| If(PCount()>0,nSlEst1:=u,nSlEst1)},oGrp9,043,008,'@E 9,999,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nSlEst1",,)
   oGet23:bLostFocus:={|| fFazSaldo() } 
Else                                                                                                                                                                              
   oGet23     := TGet():New( 170,144,{|u| If(PCount()>0,nSlEst1:=u,nSlEst1)},oGrp9,043,008,'@E 9,999,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nSlEst1",,)
EndIF 
oGet24     := TGet():New( 170,193,{|u| If(PCount()>0,nPrEst1:=u,nPrEst1)},oGrp9,043,008,'@E 999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nPrEst1",,)
oGrp13     := TGroup():New( 192,241,231,356,"Realizado Ant2",oGrp1,CLR_BLACK,CLR_WHITE,.T.,.F. )
oSay37     := TSay():New( 200,245,{||"Vlr Total Priorizar  "},oGrp13,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,045,008)
oSay38     := TSay():New( 200,305,{||" %"},oGrp13,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,029,008)
oGet31     := TGet():New( 212,245,{|u| If(PCount()>0,nVRea2:=u,nVRea2)},oGrp13,048,008,'@E 9,999,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVRea2",,)
oGet32     := TGet():New( 212,306,{|u| If(PCount()>0,nPrRea2:=u,nPrRea2)},oGrp13,043,008,'@E 999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nPrRea2",,)
oGrp12     := TGroup():New( 192,088,231,240,"Estimado Ant2",oGrp1,CLR_BLACK,CLR_WHITE,.T.,.F. )
oSay34     := TSay():New( 200,092,{||"Vlr Total Priorizar  "},oGrp12,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,045,008)
oSay35     := TSay():New( 200,144,{||"Saldo a Priorzar "},oGrp12,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,048,008)
oSay36     := TSay():New( 200,192,{||" %"},oGrp12,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,029,008)
oGet28     := TGet():New( 212,092,{|u| If(PCount()>0,nVlEst2:=u,nVlEst2)},oGrp12,048,008,'@E 9,999,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nVlEst2",,)
If nVlEst2 > 0
   oGet29     := TGet():New( 212,144,{|u| If(PCount()>0,nSlEst2:=u,nSlEst2)},oGrp12,043,008,'@E 9,999,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nSlEst2",,)
   oGet29:bLostFocus:={|| fFazSaldo() } 
Else 
   oGet29     := TGet():New( 212,144,{|u| If(PCount()>0,nSlEst2:=u,nSlEst2)},oGrp12,043,008,'@E 9,999,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nSlEst2",,)
EndIf 

oGet30     := TGet():New( 212,193,{|u| If(PCount()>0,nPrEst2:=u,nPrEst2)},oGrp12,043,008,'@E 999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nPrEst2",,)
oGrp16     := TGroup():New( 232,241,272,356,"Realizado Anteriores Ant3",oGrp1,CLR_BLACK,CLR_WHITE,.T.,.F. )
oSay44     := TSay():New( 240,245,{||"Vlr Total Priorizar  "},oGrp16,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,045,008)
oSay45     := TSay():New( 240,305,{||" %"},oGrp16,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,029,008)
oGet37     := TGet():New( 252,245,{|u| If(PCount()>0,nVRea3:=u,nVRea3)},oGrp16,048,008,'@E 9,999,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVRea3",,)
oGet38     := TGet():New( 252,306,{|u| If(PCount()>0,nPrRea3:=u,nPrRea3)},oGrp16,043,008,'@E 999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nPrRea3",,)
oGrp15     := TGroup():New( 232,088,272,240,"Estimado Anteriores Ant3",oGrp1,CLR_BLACK,CLR_WHITE,.T.,.F. )
oSay41     := TSay():New( 240,092,{||"Vlr Total Priorizar  "},oGrp15,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,045,008)
oSay42     := TSay():New( 240,144,{||"Saldo a Priorzar "},oGrp15,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,048,008)
oSay43     := TSay():New( 240,192,{||" %"},oGrp15,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,029,008)
oGet34     := TGet():New( 252,092,{|u| If(PCount()>0,nVlEst3:=u,nVlEst3)},oGrp15,048,008,'@E 9,999,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nVlEst3",,)

If nVlEst3 > 0
   oGet35     := TGet():New( 252,144,{|u| If(PCount()>0,nSlEst3:=u,nSlEst3)},oGrp15,043,008,'@E 9,999,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nSlEst3",,)   
   oGet35:bLostFocus:={|| fFazSaldo() } 
Else                                                                                                                                                                                  
   oGet35     := TGet():New( 252,144,{|u| If(PCount()>0,nSlEst3:=u,nSlEst3)},oGrp15,043,008,'@E 9,999,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nSlEst3",,)   
EndIf    
         
oGet36     := TGet():New( 252,193,{|u| If(PCount()>0,nPrEst3:=u,nPrEst3)},oGrp15,043,008,'@E 999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nPrEst3",,)
oGet13     := TGet():New( 064,292,{|u| If(PCount()>0,cContSe2:=u,cContSe2)},oGrp1,060,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cContSe2",,)

oDlg1:Activate(,,,.T.)

Return

Static function fMovArqVar()      
//Transform(nValTot  ,"@R  999,999,999.99")

 cClsRed    := PCI->PCI_CLSRED                                                  
 cCptAn1    := PCI->PCI_CPTAN1   
 cCptAn2    := PCI->PCI_CPTAN2    
 cCptAn3    := PCI->PCI_CPTAN3   
 cCptAt0    := PCI->PCI_CPTAT0   
 cCptPgt    := PCI->PCI_CPTPGT   
 cDescPg    := PCI->PCI_DESCPG   
 cSeq       := PCI->PCI_SEQ      
 cSldRec    := PCI->PCI_SLDREC   
 cTp        := PCI->PCI_TIPO     

 nAtv0      := PCI->PCI_ATV0   
// oCBox3:ctrlrefresh()    
 nAtv1      := PCI->PCI_ATV01 
// oCBox5:ctrlrefresh()      
 nAtv2      := PCI->PCI_ATV02     
// oCBox6:ctrlrefresh()
 nAtv3      := PCI->PCI_ATV03    
// oCBox7:ctrlrefresh()          

 nCptRec    := PCI->PCI_CPTREC   
 nOrdena    := PCI->PCI_ORDENA     
 nPercCus   := PCI->PCI_PERCUS   
 nPreCal    := PCI->PCI_PRECAL   
 nPrecSd    := PCI->PCI_PRECSD   
 nPrEst0    := PCI->PCI_PREST0   
 nPrEst1    := PCI->PCI_PREST1   
 nPrEst2    := PCI->PCI_PREST2   
 nPrEst3    := PCI->PCI_PREST3   
 nPrRea0    := PCI->PCI_PRREA0   
 nPrRea1    := PCI->PCI_PRREA1   
 nPrRea2    := PCI->PCI_PRREA2   
 nPrRea3    := PCI->PCI_PRREA3   
 nSlEst0    := PCI->PCI_SLEST0   
 nSlEst1    := PCI->PCI_SLEST1   
 nSlEst2    := PCI->PCI_SLEST2   
 nSlEst3    := PCI->PCI_SLEST3   
 nStatus    := PCI->PCI_STATUS      
 nVlEst0    := PCI->PCI_VLEST0   
 nVlEst1    := PCI->PCI_VLEST1   
 nVlEst2    := PCI->PCI_VLEST2   
 nVlEst3    := PCI->PCI_VLEST3   
 nVlrTot    := PCI->PCI_VLRTOT   
 nVlTRec    := PCI->PCI_VLTREC   
 nVRea0     := PCI->PCI_VLREA0   
 nVRea1     := PCI->PCI_VLREA1   
 nVRea2     := PCI->PCI_VLREA2   
 nVRea3     := PCI->PCI_VLREA3    
 cUsrlog    := PCI->PCI_LOGINC  
 dDtLog     := PCI->PCI_LOGDT   
 cHoraLog   := PCI->PCI_HORALO      
 //nRecno     := PCI->R_e_c_n_o_  
 cContSe2   := PCI->PCI_CPTPGT + substr(PCI->PCI_DESCPG,1,4) + trim(PCI->PCI_CLSRED) + strzero(PCI->PCI_SEQ,2)
Return
                                 
Static function fMovVarArq()    
   
 reclock("PCI",.F.)    
 
 PCI->PCI_CLSRED :=  cClsRed    
 PCI->PCI_CPTAN1 :=  cCptAn1    
 PCI->PCI_CPTAN2 :=  cCptAn2     
 PCI->PCI_CPTAN3 :=  cCptAn3    
 PCI->PCI_CPTAT0 :=  cCptAt0    
 PCI->PCI_CPTPGT :=  cCptPgt    
 PCI->PCI_DESCPG :=  cDescPg    
 PCI->PCI_SEQ    :=  cSeq       
 PCI->PCI_SLDREC :=  cSldRec    
 PCI->PCI_TIPO   :=  cTp        
 PCI->PCI_ATV0   :=  nAtv0      
 PCI->PCI_ATV01  :=  nAtv1        
 PCI->PCI_ATV02  :=  nAtv2      
 PCI->PCI_ATV03  :=  nAtv3        
 PCI->PCI_CPTREC :=  nCptRec    
 PCI->PCI_ORDENA :=  nOrdena      
 PCI->PCI_PERCUS :=  nPercCus   
 PCI->PCI_PRECAL :=  nPreCal    
 PCI->PCI_PRECSD :=  nPrecSd    
 PCI->PCI_PREST0 :=  nPrEst0    
 PCI->PCI_PREST1 :=  nPrEst1    
 PCI->PCI_PREST2 :=  nPrEst2    
 PCI->PCI_PREST3 :=  nPrEst3    
 PCI->PCI_PRREA0 :=  nPrRea0    
 PCI->PCI_PRREA1 :=  nPrRea1    
 PCI->PCI_PRREA2 :=  nPrRea2    
 PCI->PCI_PRREA3 :=  nPrRea3    
 PCI->PCI_SLEST0 :=  nSlEst0    
 PCI->PCI_SLEST1 :=  nSlEst1    
 PCI->PCI_SLEST2 :=  nSlEst2    
 PCI->PCI_SLEST3 :=  nSlEst3    
 PCI->PCI_STATUS :=  nStatus       
 PCI->PCI_VLEST0 :=  nVlEst0    
 PCI->PCI_VLEST1 :=  nVlEst1    
 PCI->PCI_VLEST2 :=  nVlEst2    
 PCI->PCI_VLEST3 :=  nVlEst3    
 PCI->PCI_VLRTOT :=  nVlrTot    
 PCI->PCI_VLTREC :=  nVlTRec    
 PCI->PCI_VLREA0 :=  nVRea0     
 PCI->PCI_VLREA1 :=  nVRea1     
 PCI->PCI_VLREA2 :=  nVRea2     
 PCI->PCI_VLREA3 :=  nVRea3       
 
 PCI->(MsUnlock())

Return() 

Static function fFazSaldo()

local nVlrNov:= 0

nVlrNov:= nSlEst0+nSlEst1+nSlEst2+nSlEst3           

cSldRec := nVlrNov         

If nSlEst0 > 0
   nAtv0      := 'Sim'   
Else     
   nAtv0      := 'Não'
EndIf       

If nSlEst1 > 0
   nAtv1      := 'Sim'   
Else     
   nAtv1      := 'Não'
EndIf   

If nSlEst2 > 0
   nAtv2      := 'Sim'   
Else     
   nAtv2      := 'Não'
EndIf       
        
If nSlEst3 > 0
   nAtv3      := 'Sim'   
Else     
   nAtv3      := 'Não' 
EndIf     
 
  nPrEst0 := Iif (trim(nAtv0) == 'Sim' , Iif(nSlEst0 > 0 , (nSlEst0*100)/nVlEst0  , 0.00) , 0.00)     
  nPrEst1 := Iif (trim(nAtv1) == 'Sim' , Iif(nSlEst1 > 0 , (nSlEst1*100)/nVlEst1  , 0.00) , 0.00)     
  nPrEst2 := Iif (trim(nAtv2) == 'Sim' , Iif(nSlEst2 > 0 , (nSlEst2*100)/nVlEst2  , 0.00) , 0.00)    
  nPrEst3 := Iif (trim(nAtv3) == 'Sim' , Iif(nSlEst3 > 0 , (nSlEst3*100)/nVlEst3  , 0.00) , 0.00)       

 oCBox3:refresh()    
 oCBox5:refresh()      
 oCBox6:refresh()
 oCBox7:refresh()     
 oGet4:Refresh()   
 oGet7:Refresh()  
 oGet24:Refresh()  
 oGet30:Refresh()  
 oGet36:Refresh()  
 
return()

Static function fverifatv( nAtv, num )
if natv == 'Sim'
 a:='b'	
elseif natv == 'Não'
 a:='b'
EndIf    
return()

/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
         