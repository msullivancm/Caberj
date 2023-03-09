#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'RWMAKE.CH'
#INCLUDE 'FONT.CH'
#INCLUDE 'COLORS.CH'
#include "PLSA090.ch"                                                                                                                                                                                                                                  
#INCLUDE 'TOPCONN.CH'    
#Include "Ap5Mail.Ch"    

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³         ³ Autor ³                     ³ Data ³           ³±±
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

User Function CABA150()

/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±± Declaração de cVariable dos componentes                                 ±±
Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/
/*
Private cCptEnvGbl := Space(1)
Private cCptEnvMen := Space(1)
Private cDtEnvGbl  := Space(1)
Private cDtEnvMen  := Space(1)
Private cqtdExcGbl := Space(1)
Private cqtdExcMen := Space(1)
Private cqtdIncGbl := Space(1)
Private cqtdIncMen := Space(1)
Private cqtdReaGbl := Space(1)
Private cqtdReaMen := Space(1)
Private cqtdRetIGbl := Space(1)
Private cqtdRetIMen := Space(1)
*/
Private cCompteEnv := Space(1)
Private cCptEnvGbl := Space(1)
Private cCptEnvMen := Space(1)
Private cDtEnvGbl  := Space(1)
Private cDtEnvMen  := Space(1)
Private cDtEnv     := Space(1)
Private cqtdAtvAns := Space(1)
Private cqtdAtvOpe := Space(1)
Private cqtdExcGbl := Space(1)
Private cqtdExcMen := Space(1)
Private cqtdInatAn := Space(1)
Private cqtdInatOp := Space(1)
Private cqtdIncGbl := Space(1)
Private cqtdIncMen := Space(1)
Private cqtdReaGbl := Space(1)
Private cqtdReaMen := Space(1)
Private cqtdRetIGbl:= Space(1)
Private cqtdRetIMen:= Space(1)
Private cTpSib     := Space(1)
Private cMensg    
Private cMgMensal  := ' ' 
Private cMgGobsal  := ' '

private cSibEnv150 := GETMV("MV_SIBENV") // 1 - Sib SIM  , 0 - Sib NAO  

Private cEnvSibt   := Iif(cSibEnv150 == 1, 'Sim','Não')

Private cqtdAtvAns := Space(1)
Private cqtdAtvOpe := Space(1)

Private cSequencia := Space(1)
Private cTpSib     := Space(1)
private totProc := 0
private catvans := 0
private catvope := 0

Private cAliastmp1 	 := GetNextAlias()
Private cAliastmp2 	 := GetNextAlias()
Private cAliastmp3 	 := GetNextAlias()
Private cAliastmp4 	 := GetNextAlias()
Private cAliastmp5 	 := GetNextAlias()
Private cAliastmp6 	 := GetNextAlias()
Private cAliastmp7 	 := GetNextAlias()

Private cAliastmp8 	 := GetNextAlias()
Private cAliastmp9 	 := GetNextAlias()
Private cAliastmp10  := GetNextAlias()

PRIVATE cCodEmp      :=  Iif(cEmpAnt == '01', 'C', 'I')

Private nFaz         := 1

Private lSibInc := IIf(GetMv("MV_SIBINC")== 1 ,.T.,.F.)
Private lSibRet := IIf(GetMv("MV_SIBRET")== 1 ,.T.,.F.)
Private lSibBlo := IIf(GetMv("MV_SIBEXC")== 1 ,.T.,.F.)
Private lSibRea := IIf(GetMv("MV_SIBREA")== 1 ,.T.,.F.)
Private lSibMuc := IIf(GetMv("MV_SIBMUC")== 1 ,.T.,.F.)    

private lContExec:= .T. // controla se pedi ou não autorização para execuTAR
/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±± Declaração de Variaveis Private dos Objetos                             ±±
Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/
SetPrvt("oDlg150","oGrp2","oSay3","oSay4","oSay5","oSay10","oSay11","oSay12","oGet7","oGet8","oGet9","oGet10")
SetPrvt("oGet12","oGrp3","oSay1","oSay2","oSay6","oSay7","oSay8","oSay9","oGet1","oGet2","oGet3","oGet4")
SetPrvt("oGet6","oGrp4","oSay13","oSay14","oGet13","oGet14","oGrp5","oBtn7","oBtn10","oBtn13","oBtn14")
SetPrvt("oBtn16","oBtn17","oBtn18","oBtn19","oBtn20","oBtn21","oBtn2","oBtn3","oBtn4","oGrp6","oSay15")
SetPrvt("oGet15","oGet16","oGrp1","oMGet1","oGrp7","oCBox1","oCBox2","oCBox3","oCBox4","oCBox5","oGrp8")
SetPrvt("oSay18","oSay19","oSay20","oSay21","oGet17","oGet18","oGet19","oGet20","oGet21")

If msgyesno("ATENÇÃO! Deseja Caregar dados Informativos do Sib , Esta opção pode levar Varios Mnutos")
   Processa({||u_fcarTela()}, "Aguarde !!!!", " Carregando Dados do Servidor", .T.) 
EndIf 

/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±± Definicao do Dialog e todos os seus componentes.                        ±±
Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/

oDlg150    := MSDialog():New( 094,254,688,1152,"Central do SIB",,,.F.,,,,,,.T.,,,.T. )
oGrp2      := TGroup():New( 056,096,108,440,"Status de Envio do SIB Global ",oDlg150,CLR_HRED,CLR_WHITE,.T.,.F. )
oSay3      := TSay():New( 067,391,{||"Qt Retificações"},oGrp2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,042,008)
oSay4      := TSay():New( 067,335,{||"Qt Retificações "},oGrp2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,044,008)
oSay5      := TSay():New( 067,278,{||"Qt Exclusões"},oGrp2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,042,008)
oSay10     := TSay():New( 067,222,{||"Qt Inclusões"},oGrp2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,040,008)
oSay11     := TSay():New( 067,165,{||"Data Envio"},oGrp2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay12     := TSay():New( 067,109,{||"Compt Envio"},oGrp2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oGet7      := TGet():New( 079,393,{|u| If(PCount()>0,cqtdReaGbl:=u,cqtdReaGbl)},oGrp2,040,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cqtdReaGbl",,)
oGet8      := TGet():New( 079,336,{|u| If(PCount()>0,cqtdRetIGbl:=u,cqtdRetIGbl)},oGrp2,040,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cqtdRetIGbl",,)
oGet9      := TGet():New( 079,279,{|u| If(PCount()>0,cqtdExcGbl:=u,cqtdExcGbl)},oGrp2,040,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cqtdExcGbl",,)
oGet10     := TGet():New( 079,222,{|u| If(PCount()>0,cqtdIncGbl:=u,cqtdIncGbl)},oGrp2,040,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cqtdIncGbl",,)
oGet11     := TGet():New( 079,165,{|u| If(PCount()>0,cDtEnvGbl:=u,cDtEnvGbl)},oGrp2,040,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cDtEnvGbl",,)
oGet12     := TGet():New( 079,108,{|u| If(PCount()>0,cCptEnvGbl:=u,cCptEnvGbl)},oGrp2,036,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cCptEnvGbl",,)
oGrp3      := TGroup():New( 000,096,055,440,"Status de Envio do SIB Mensal ",oDlg150,CLR_HRED,CLR_WHITE,.T.,.F. )
oSay1      := TSay():New( 010,165,{||"Data Envio"},oGrp3,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay2      := TSay():New( 010,109,{||"Compt Envio"},oGrp3,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay6      := TSay():New( 010,222,{||"Qtd Inclusoes"},oGrp3,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,040,008)
oSay7      := TSay():New( 010,278,{||"Qt Exclusões"},oGrp3,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,042,008)
oSay8      := TSay():New( 010,391,{||"Qt Reativações"},oGrp3,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,044,008)
oSay9      := TSay():New( 010,335,{||"Qtd Retificações "},oGrp3,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,044,008)
oGet1      := TGet():New( 022,108,{|u| If(PCount()>0,cCptEnvMen:=u,cCptEnvMen)},oGrp3,036,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cCptEnvMen",,)
oGet2      := TGet():New( 022,222,{|u| If(PCount()>0,cqtdIncMen:=u,cqtdIncMen)},oGrp3,040,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cqtdIncMen",,)
oGet3      := TGet():New( 022,165,{|u| If(PCount()>0,cDtEnvMen:=u,cDtEnvMen)},oGrp3,040,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cDtEnvMen",,)
oGet4      := TGet():New( 022,279,{|u| If(PCount()>0,cqtdExcMen:=u,cqtdExcMen)},oGrp3,040,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cqtdExcMen",,)
oGet5      := TGet():New( 022,393,{|u| If(PCount()>0,cqtdReaMen:=u,cqtdReaMen)},oGrp3,040,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cqtdReaMen",,)
oGet6      := TGet():New( 022,336,{|u| If(PCount()>0,cqtdRetIMen:=u,cqtdRetIMen)},oGrp3,040,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cqtdRetIMen",,)
oGrp4      := TGroup():New( 115,096,162,204,"Ativos ",oDlg150,CLR_HRED,CLR_WHITE,.T.,.F. )
oSay13     := TSay():New( 131,112,{||"ANS"},oGrp4,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay14     := TSay():New( 132,157,{||"Operadora"},oGrp4,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)

oGet13     := TGet():New( 143,112,{|u| If(PCount()>0,cqtdAtvAns:=u,cqtdAtvAns)},oGrp4,028,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cqtdAtvAns",,)
oGet14     := TGet():New( 143,157,{|u| If(PCount()>0,cqtdAtvOpe:=u,cqtdAtvOpe)},oGrp4,028,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cqtdAtvOpe",,)


oGrp5      := TGroup():New( 000,000,287,092,"opções ",oDlg150,CLR_HRED,CLR_WHITE,.T.,.F. )
oBtn7      := TButton():New( 184,004,"Consulta Base Do Sib ANS",oGrp5,{||fCABR260()},080,016,,,,.T.,,"Cabr260 - Consulta Base Do Sib ANS",,,,.F. )
oBtn10     := TButton():New( 008,004,"Seleção Tipo de  Envio Sib",oGrp5,{||fCABA140()},080,016,,,,.T.,,"CABA140 - opção de selecionar qual movimentação cadastral que será envia",,,,.F. )
oBtn13     := TButton():New( 047,004,"Controle de Envio",oGrp5,{||fCABA145A()},080,016,,,,.T.,,"CABA145A - possibilidade de selecionar matricula / Cod CCo / Nome de usuários para ser mostrado  no browser de controle de envio",,,,.F. )
oBtn14     := TButton():New( 067,004,"Mapa Controle de Envio",oGrp5,{||fCABA144()},080,016,,,,.T.,,"CABA144 - sintetico das matricula processadas pelo sib , com varias formatações e filtros",,,,.F. )
oBtn15     := TButton():New( 203,004,"Atual. Tab. Conferencia Sib",oGrp5,{||fCABA143()},080,016,,,,.T.,,"CABA143 - faz atualização do Arquivos de conferencia do sib e atualiza totais por mês de vidas Ativas ",,,,.F. )
oBtn16     := TButton():New( 145,004,"Mapa Operadora  X  ANS",oGrp5,{||fCABA142()},080,016,,,,.T.,,"CABA142 - demonstra a distribuição de todas as matrícula da operadora em relação a situação na ANS",,,,.F. )
oBtn17     := TButton():New( 164,004,"Preparo Sib Global",oGrp5,{||fCABA131()},080,016,,,,.T.,,"CABA131 - seleciona e trata matricula com inconformidades  na base ANS confrontadas com a base da operadora para preparo do sib Global",,,,.F. )
oBtn18     := TButton():New( 106,004,"Manuten. Paran. Envio Sib ANS",oGrp5,{||fCABA148()},080,016,,,,.T.,,"CABA148 - manutenção das variáveis que controlarão o envio da matricula",,,,.F. )
oBtn19     := TButton():New( 086,004,"Log e Manut.  Paran. Do Sib ",oGrp5,{||fCABA149()},080,016,,,,.T.,,"CABA149 - browser que demonstra as ações e que usuário sofreu , Permite manutenções nas variáveis de controle  ",,,,.F. )
oBtn20     := TButton():New( 125,004,"Retorno Do Sib  Operadora",oGrp5,{||fCABA147()},080,016,,,,.T.,,"CABA147 - Grava no arquivo de controle de envio , data do retorno da ANS , operador , arquivos , criticas , e copia para área segura do arquivo processado",,,,.F. )
oBtn21     := TButton():New( 224,004,"Relatório de Pre Critica ",oGrp5,{||fCABR171()},080,016,,,,.T.,,"CABR171 - Relatório de Pre Critica ",,,,.F. )
oBtn2      := TButton():New( 245,004,"Rel. Dif. ANS X Operadora ",oGrp5,{||fCABR263A()},080,016,,,,.T.,,"CABR263A - Rel. Dif. ANS X Operadora ",,,,.F. )
oBtn3      := TButton():New( 027,004,"Gera SIB XML",oGrp5,{||fPLSA782()},080,016,,,,.T.,,"PLSA782 - Gera SIB XML",,,,.F. )

oBtn4      := TButton():New( 266,004,"Sair",oGrp5,{||oDlg150:End()},080,016,,,,.T.,,"Sair do Sistema",,,,.F. )
oGrp6      := TGroup():New( 115,209,162,316,"Diferenças Entre Base",oDlg150,CLR_BLACK,CLR_WHITE,.T.,.F. )
oSay15     := TSay():New( 131,217,{||"Falta na operadora "},oGrp6,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,048,008)
oSay16     := TSay():New( 131,278,{||"Falta na ANS"},oGrp6,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,035,008)
oGet15     := TGet():New( 143,217,{|u| If(PCount()>0,cqtdInatOp:=u,cqtdInatOp)},oGrp6,028,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cqtdInatOp",,)
oGet16     := TGet():New( 143,278,{|u| If(PCount()>0,cqtdInatAn:=u,cqtdInatAn)},oGrp6,028,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cqtdInatAn",,)

oGrp1      := TGroup():New( 196,096,288,440,"Mensagem do Sistema",oDlg150,CLR_BLACK,CLR_WHITE,.T.,.F. )
oMGet1     := TMultiGet():New( 204,100,{|u| If(PCount()>0,cMensg:=u,cMensg)},oGrp1,336,080,,,CLR_BLACK,CLR_WHITE,,.T.,"",,,.F.,.F.,.F.,,,.F.,,  )

oGrp7      := TGroup():New( 115,320,192,440,"Controle de Tipo de Envio ",oDlg150,CLR_BLACK,CLR_WHITE,.T.,.F. )

oCBox1     := TCheckBox():New( 123,325,"Inclusões",{|u| If(PCount()>0,lSibInc:=u,lSibInc)},oGrp7,040,008,,{||fSX6('I')},,,CLR_BLACK,CLR_WHITE,,.T.,"",, )

oCBox2     := TCheckBox():New( 137,325,"Exclusões",{|u| If(PCount()>0,lSibBlo:=u,lSibBlo)},oGrp7,048,008,,{||fSX6('E')},,,CLR_BLACK,CLR_WHITE,,.T.,"",, )

oCBox3     := TCheckBox():New( 151,325,"Retificações",{|u| If(PCount()>0,lSibRet:=u,lSibRet)},oGrp7,048,008,,{||fSX6('R')},,,CLR_BLACK,CLR_WHITE,,.T.,"",, )

oCBox4     := TCheckBox():New( 165,325,"Reativações",{|u| If(PCount()>0,lSibRea:=u,lSibRea)},oGrp7,048,008,,{||fSX6('A')},,,CLR_BLACK,CLR_WHITE,,.T.,"",, )

oCBox5     := TCheckBox():New( 179,325,"Mudança Contratural",{|u| If(PCount()>0,lSibMuc:=u,lSibMuc)},oGrp7,059,008,,{||fSX6('M')},,,CLR_BLACK,CLR_WHITE,,.T.,"",, )

oGrp8      := TGroup():New( 163,096,192,316,"Sib ",oDlg150,CLR_BLACK,CLR_WHITE,.T.,.F. )

oSay17     := TSay():New( 168,108,{||"Tipo do Sib"},oGrp8,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay18     := TSay():New( 168,156,{||"Compte Envio "},oGrp8,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,036,008)
oSay19     := TSay():New( 168,200,{||"Sequen."},oGrp8,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,024,008)
oSay20     := TSay():New( 168,233,{||"Dt Envio"},oGrp8,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,024,008)
oSay21     := TSay():New( 167,276,{||"Envia Sib"},oGrp8,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)

oSay17     := TSay():New( 168,108,{||"Tipo do Sib"},oGrp8,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay18     := TSay():New( 168,156,{||"Compte Envio "},oGrp8,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,036,008)
oSay19     := TSay():New( 168,200,{||"Sequen."},oGrp8,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,024,008)
oSay20     := TSay():New( 168,233,{||"Dt Envio"},oGrp8,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,024,008)
oSay21     := TSay():New( 167,276,{||"Envia Sib"},oGrp8,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oGet17     := TGet():New( 178,108,{|u| If(PCount()>0,cTpSib:=u,cTpSib)},oGrp8,040,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cTpSib",,)
oGet18     := TGet():New( 178,158,{|u| If(PCount()>0,cCompteEnv:=u,cCompteEnv)},oGrp8,032,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cCompteEnv",,)
oGet19     := TGet():New( 178,200,{|u| If(PCount()>0,cSequencia:=u,cSequencia)},oGrp8,024,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cSequencia",,)
oGet20     := TGet():New( 178,234,{|u| If(PCount()>0,cDtEnv:=u,cDtEnv)},oGrp8,031,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cDtEnv",,)
oGet21     := TGet():New( 178,276,{|u| If(PCount()>0,cEnvSibt:=u,cEnvSibt)},oGrp8,032,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cEnvSibt",,)

/*

oSay17     := TSay():New( 168,112,{||"Tipo do Sib"},oGrp8,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay18     := TSay():New( 168,180,{||"Compte de Envio "},oGrp8,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,052,008)
oSay19     := TSay():New( 168,240,{||"Sequen."},oGrp8,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,024,008)
oSay20     := TSay():New( 168,277,{||"Dt Envio"},oGrp8,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,024,008)
oGet17     := TGet():New( 178,112,{|u| If(PCount()>0,cTpSib:=u,cTpSib)},oGrp8,060,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cTpSib",,)
oGet18     := TGet():New( 178,180,{|u| If(PCount()>0,cCompteEnv:=u,cCompteEnv)},oGrp8,048,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cCompteEnv",,)
oGet19     := TGet():New( 178,240,{|u| If(PCount()>0,cSequencia:=u,cSequencia)},oGrp8,024,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cSequencia",,)
oGet20     := TGet():New( 178,277,{|u| If(PCount()>0,cDtEnv:=u,cDtEnv)},oGrp8,031,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cDtEnv",,)

*/
fVerif171()

oDlg150:Activate(,,,.T.)

Return

Static Function fCabr260()
 
   U_Cabr260()      
     
//  oDlg150:End()   
 

Return 
    
Static Function fCaba131()
   
   cMensg:='Preparo do Sib Global , com forçando os envios '

  // oMGet1:refresh()

   U_Caba131()      
     
Return 

Static Function fCaba140()
  
   U_Caba140()   
   
lSibInc := IIf(GetMv("MV_SIBINC")== 1 ,.T.,.F.)
lSibRet := IIf(GetMv("MV_SIBRET")== 1 ,.T.,.F.)
lSibBlo := IIf(GetMv("MV_SIBEXC")== 1 ,.T.,.F.)
lSibRea := IIf(GetMv("MV_SIBREA")== 1 ,.T.,.F.)
lSibMuc := IIf(GetMv("MV_SIBMUC")== 1 ,.T.,.F.)       

oCBox1:refresh()
oCBox2:refresh()
oCBox3:refresh()
oCBox4:refresh()
oCBox5:refresh()
     
   cMensg:='Manutenção nos paramentos de envio '

  // oMGet1:refresh()  
   
Return 
Static Function fCaba142()
  
   U_Caba142()      
     
Return 

Static Function fCaba143()

//if cCodEmp =='C'
  
   U_Caba143()    
   
//else

 //  cMensg:='Manutenção nos paramentos de envio '
       
Return 
Static Function fCaba144()
 
   U_Caba144()      
      
Return 
Static Function fCaba145A()

   U_Caba145A()      
     
  
Return 
Static Function fCaba147()

   U_Caba147()      
     
  
Return 
Static Function fCaba148()

   U_Caba148()      
     
  
Return 

Static Function fCaba149()

   U_Caba149()      
     
  
Return 

Static Function fCabr171()

   cMensg:='Pre critica do Sib , inclusão automática nas tabela de controle'

  // oMGet1:refresh()

   U_Cabr171()      
   
   cSibEnv150 := GETMV("MV_SIBENV") // 1 - Sib SIM  , 0 - Sib NAO     
   
   Fverif171()
     
  
Return 

Static Function fCabr263a()

   U_Cabr0263a()      
     
  
Return 

Static Function fplsa782()  

   cMensg:='Geração do arquivo de envio do Sib , rotina padrão'
 //  oMGet1:refresh()   

   u_plsa782C()   
   
   cSibEnv150 := GETMV("MV_SIBENV") // 1 - Sib SIM  , 0 - Sib NAO     
   
  Fverif171()
  
If  cSibEnv150 == 1

    cEnvSibt   := Iif(cSibEnv150 == 1, 'Sim','Não')
    
    cMensg+= CRLF + CRLF + '                                  - - - >    A T E N Ç Ã O   < - - -  '
    cMensg+= CRLF + CRLF + ' GERAÇÃO DE ARQUIVOS PARA ENVIO DO SIB FINAL , É OBRIGATORIO PASSAR PELO PROGRAMA PRE CRITICA DO SIB '
  
EndIf       
  //  oDlg150:End()   
  
Return 

static function fVerif171()

If cSibEnv150 == 1
   oBtn3:Disable()
   oBtn2:Disable()
   oBtn20:Disable()
   oBtn19:Disable()
   oBtn18:Disable()
   oBtn17:Disable()
   oBtn16:Disable()
   oBtn13:Disable()
   oBtn14:Disable()
   oBtn15:Disable()
   oBtn10:Disable()
   oBtn7:Disable()   
else     
   oBtn3:enable()
   oBtn2:enable()
   oBtn20:enable()
   oBtn19:enable()
   oBtn18:enable()
   oBtn17:enable()
   oBtn16:enable()
   oBtn13:enable()
   oBtn14:enable()
   oBtn15:enable()
   oBtn10:enable()
   oBtn7:enable()    
 EndIf 

oGet21:refresh() // verificar 

Return()


 user Function fcarTela()

local cQrySeq    := ' '
local nRet       := 0

cQrySeq := "SELECT PD5_TPENVI TPENVI, NVL(MAX(PD5_compte),'200101') COMPTE  "  + CRLF
cQrySeq += "FROM " + RetSqlName('PD5') + " PD5 " 		    + CRLF
cQrySeq += "WHERE PD5_FILIAL = '" + xFilial('PD5') + "'"	+ CRLF
//cQrySeq += "  AND PD5_TPENVI = 'Sib Mensal'" 			    + CRLF 
cQrySeq += "  AND PD5_ENVIAD = 'T' " 				        + CRLF 
cQrySeq += "  AND PD5.D_E_L_E_T_ = ' ' " 					+ CRLF 
cQrySeq += "  group by PD5_TPENVI " 				    	+ CRLF


TcQuery cQrySeq New Alias cAliastmp1

While cAliastmp1->(!EOF()) 
   If trim(cAliastmp1->tpenvi) =='Sib Global'

      cCptEnvGbl := trim(cAliastmp1->COMPTE)

   Else

      cCptEnvMen :=trim(cAliastmp1->COMPTE)

   EndIf
   cAliastmp1->(dbSkip())
EndDo 


// comptencia sib mensal 
 cQuery := " SELECT PD5_TPENVI tpenv , pd5_tpacao tpacao , count(*) qtda , MAX(PD5_DTENV) dtenv " + CRLF
 cQuery += " FROM  " + RetSqlName('PD5') + " PD5" 		    + CRLF
 cQuery += " WHERE PD5_FILIAL = '" + xFilial('PD5') + "'"	+ CRLF
 cQuery += " AND PD5_COMPTE = '" + trim(cCptEnvMen) + "'" + CRLF
 cQuery += " AND PD5_TPENVI = 'Sib Mensal' " 			    + CRLF 
 cQuery += " AND PD5_ENVIAD = 'T' " + CRLF
 cQuery += " AND PD5.D_E_L_E_T_ = ' ' " + CRLF 	
 cQuery += " GROUP BY PD5_TPENVI  , PD5_TPACAO " + CRLF


If Select(cAliastmp2) <> 0 
   cAliastmp2->(DbCloseArea())  
Endif 


TcQuery cQuery New Alias cAliastmp2


// comptencia sib global  
 cQuery := " SELECT PD5_TPENVI tpenv , pd5_tpacao tpacao , count(*) qtda , MAX(PD5_DTENV) dtenv " + CRLF
 cQuery += " FROM  " + RetSqlName('PD5') + " PD5" 		    + CRLF
 cQuery += " WHERE PD5_FILIAL = '" + xFilial('PD5') + "'"	+ CRLF
 cQuery += " AND PD5_COMPTE = '" + trim(cCptEnvGbl) + "'" + CRLF
 cQuery += " AND PD5_TPENVI = 'Sib Global' " 			    + CRLF 
 cQuery += " AND PD5_ENVIAD = 'T' " + CRLF
 cQuery += " AND PD5.D_E_L_E_T_ = ' ' " + CRLF 	
 cQuery += " GROUP BY PD5_TPENVI  , PD5_TPACAO " + CRLF


If Select(cAliastmp7) <> 0 
   cAliastmp7->(DbCloseArea())  
Endif 

TcQuery cQuery New Alias cAliastmp7


If cEmpAnt == '02'
 
   cQuery := "select count(*) qtda from confsib_int where  sib_situac = '1'    " 

Else 
  
   cQuery := "select count(*) qtda  from confsib_cab where  sib_situac = '1'    "

EndIf                                

If Select(cAliastmp3) <> 0 
   cAliastmp3->(DbCloseArea())  
Endif 


TcQuery cQuery New Alias cAliastmp3

  cQuery := " SELECT COUNT(*) QTDA   FROM  " + RetSqlName('BA1') + " BA1" 	   + CRLF
  cQuery += " WHERE BA1_FILIAL = '" + xFilial('BA1') + "' AND BA1_LOCSIB = '1' AND BA1_CODCCO <>  ' '"	+ CRLF

If Select(cAliastmp4) <> 0 
   cAliastmp4->(DbCloseArea())  
Endif 


TcQuery cQuery New Alias cAliastmp4

/////////

cdatfim:= '30'+'/'+substr(cCptEnvMen,5,2)+'/'+substr(cCptEnvMen,1,4)

cQuery7 := CRLF+ " SELECT SIB_MATRIC Matric , SIB_CODCCO CODCCO ,BA1_LOCSIB , BA1_DATBLO  , BA1_INFANS " 
cQuery7 += CRLF+ "   FROM  " 
If cEmpAnt == '02'
   cQuery7 += CRLF+ " confsib_int" 
Else    
   cQuery7 += CRLF+ " confsib_cab" 
EndIf   
cQuery7 += CRLF+ " ," + RetSqlName("BA1") +" BA1 "
cQuery7 += CRLF+ "  WHERE BA1.D_E_L_E_T_ = ' ' AND BA1_FILIAL = '"+xFilial('BA1')+ "'  "

cQuery7 += CRLF+ "  AND BA1_CODINT = SUBSTR(SIB_MATRIC,1,4) AND BA1_CODEMP = SUBSTR(SIB_MATRIC,5,4) "
cQuery7 += CRLF+ "  AND BA1_MATRIC = SUBSTR(SIB_MATRIC,9,6) AND BA1_TIPREG = SUBSTR(SIB_MATRIC,15,2)"
cQuery7 += CRLF+ "  AND BA1_DIGITO = SUBSTR(SIB_MATRIC,17,1) "

cQuery7 += CRLF+ "    AND BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG||BA1_DIGITO = SIB_MATRIC " 
cQuery7 += CRLF+ "    AND SIB_SITUAC = '1' " 
cQuery7 += CRLF+ "          
cQuery7 += CRLF+ "         MINUS "
cQuery7 += CRLF+ "          
cQuery7 += CRLF+ " SELECT  BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG||BA1_DIGITO  MATRIC_CABERJ , BA1_CODCCO   ,BA1_LOCSIB , BA1_DATBLO , BA1_INFANS "
cQuery7 += CRLF+ "   FROM  " + RetSqlName("BA1") +" BA1 " 
cQuery7 += CRLF+ "  WHERE  BA1_FILIAL='"+xFilial('BA1')+ "'  "
cQuery7 += CRLF+ "    
If cEmpAnt == '01'
   cQuery7 += CRLF+ "         AND BA1_CODEMP NOT IN ('0004','0009') "
EndIf 	  
cQuery7 += CRLF+ "    AND  DECODE(BA1_ATUSIB,'0','NAO ENVIA',DECODE(BA1_INFSIB,'0','NAO ENVIA',DECODE(BA1_INFANS,'0','NAO ENVIA','ENVIA')))='ENVIA' "
cQuery7 += CRLF+ "    AND  VERIFBLOQANS_MS (BA1_CODINT, BA1_CODEMP, BA1_MATRIC, BA1_TIPREG,TO_CHAR(TO_DATE('"+cdatfim+"','dd/mm/yyyy'),'YYYYMMDD'),'"+cCodEmp+"')=0  "
cQuery7 += CRLF+ "    AND  TO_DATE(TRIM(BA1_DATINC),'YYYYMMDD') <= TO_DATE('"+cdatfim+"','dd/mm/yyyy') " 
cQuery7 += CRLF+ "    AND  BA1_CONEMP<>' '  "
cQuery7 += CRLF+ "    AND  BA1.D_E_L_E_T_= ' ' " 

If Select(cAliastmp5) <> 0 
   cAliastmp5->(DbCloseArea())  
Endif 


TcQuery cQuery7 New Alias cAliastmp5


//////
cQuery8 := CRLF+ " SELECT  BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG||BA1_DIGITO  MATRIC , BA1_CODCCO  CODCCO ,BA1_LOCSIB , BA1_DATBLO , BA1_INFANS "
cQuery8 += CRLF+ "   FROM  " + RetSqlName("BA1") +" BA1  " 
cQuery8 += CRLF+ "  WHERE  BA1_FILIAL='"+xFilial('BA1')+ "'  "
If cEmpAnt == '01'
   cQuery8 += CRLF+ "         AND BA1_CODEMP NOT IN ('0004','0009') "
EndIf 	  
cQuery8 += CRLF+ "    AND  DECODE(BA1_ATUSIB,'0','NAO ENVIA',DECODE(BA1_INFSIB,'0','NAO ENVIA',DECODE(BA1_INFANS,'0','NAO ENVIA','ENVIA')))='ENVIA' "
cQuery8 += CRLF+ "    AND  VERIFBLOQANS_MS (BA1_CODINT, BA1_CODEMP, BA1_MATRIC, BA1_TIPREG,TO_CHAR(TO_DATE('"+cdatfim+"','dd/mm/yyyy'),'YYYYMMDD'),'"+cCodEmp+"')=0  "

cQuery8 += CRLF+ "    AND  TO_DATE(TRIM(BA1_DATINC),'YYYYMMDD') <= TO_DATE('"+cdatfim+"','dd/mm/yyyy') " 

cQuery8 += CRLF+ "    AND  BA1_CONEMP<>' '  "
cQuery8 += CRLF+ "    AND  BA1.D_E_L_E_T_= ' ' " 

cQuery8 += CRLF+ "         MINUS "

cQuery8 += CRLF+ " SELECT SIB_MATRIC , SIB_CODCCO ,BA1_LOCSIB , BA1_DATBLO  , BA1_INFANS " 
cQuery8 += CRLF+ "   FROM  " 
If cEmpAnt == '02'
   cQuery8 += CRLF+ " confsib_int" 
Else    
   cQuery8 += CRLF+ " confsib_cab" 
EndIf   
cQuery8 += CRLF+ " ," + RetSqlName("BA1") +" BA1 "
cQuery8 += CRLF+ "  WHERE SIB_SITUAC = '1' "

cQuery8 += CRLF+ "  AND BA1_CODINT = SUBSTR(SIB_MATRIC,1,4) AND BA1_CODEMP = SUBSTR(SIB_MATRIC,5,4) "
cQuery8 += CRLF+ "  AND BA1_MATRIC = SUBSTR(SIB_MATRIC,9,6) AND BA1_TIPREG = SUBSTR(SIB_MATRIC,15,2)"
cQuery8 += CRLF+ "  AND BA1_DIGITO = SUBSTR(SIB_MATRIC,17,1) "

cQuery8 += CRLF+ "    AND BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG||BA1_DIGITO = SIB_MATRIC " 
cQuery8 += CRLF+ "    AND BA1.D_E_L_E_T_ = ' ' AND BA1_FILIAL = '"+xFilial('BA1')+ "'  "


If Select(cAliastmp6) <> 0 
   cAliastmp6->(DbCloseArea())  
Endif 


TcQuery cQuery8 New Alias cAliastmp6

/////////////////////////////////

for Faz := 1 to 2
cQuery9 := CRLF + " SELECT PD5_TPENVI TPENVI ,  "
cQuery9 += CRLF + "        pd5_Compte Compte, "
cQuery9 += CRLF + "        pd5_sequen Seq, "
cQuery9 += CRLF + "        pd5_tpacao TpAcao, "
cQuery9 += CRLF + "        decode(pd5_Critic,'T','Criticado', 'Sem Critica') Critica, "
cQuery9 += CRLF + "        decode(pd5_enviad,'T','Enviado','Não Enviado') Enviado, "
cQuery9 += CRLF + "        count(*) Qtda  "

 cQuery9 += CRLF + "   FROM " + RetSqlName('PD5') + " PD5" 		    
 cQuery9 += CRLF + "  WHERE PD5_FILIAL = '" + xFilial('PD5') + "' AND PD5.D_E_L_E_T_ = ' ' "
 
 If Faz == 1
   
    cQuery9 += CRLF + " AND PD5_COMPTE = '" + trim(cCptEnvMen) + "'" 
    cQuery9 += CRLF + " AND PD5_TPENVI = 'Sib Mensal' " 			  
  
 Else   

    cQuery9 += CRLF + " AND PD5_COMPTE = '" + trim(cCptEnvGbl) + "'" 
    cQuery9 += CRLF + " AND PD5_TPENVI = 'Sib Global' " 			 

EndIf
 
cQuery9 += CRLF+ "  GROUP BY PD5_TPENVI,  pd5_compte , pd5_sequen, pd5_tpacao , pd5_Critic , pd5_enviad "
cQuery9 += CRLF+ "  order by PD5_TPENVI,  pd5_compte , pd5_sequen, pd5_tpacao , pd5_Critic , pd5_enviad "

If Select(cAliastmp9) <> 0 
   cAliastmp9->(DbCloseArea())  
Endif 

TcQuery cQuery9 New Alias cAliastmp9

While cAliastmp9->(!EOF())
 
 If Faz == 1 
  
    cMgMensal:= Trim(cAliastmp9->TPENVI)  +' '+ ;
                Trim(cAliastmp9->COMPTE)  +' '+ ;
                Trim(cAliastmp9->seq)     +' '+ ;
                Trim(cAliastmp9->TpAcao)  +' '+ ;
                Trim(cAliastmp9->Critica) +' '+ ;
                Trim(cAliastmp9->Enviado) +' '+ ;
                transform((cAliastmp9->Enviado),"@E 9999")+ CRLF
     
  Else              
  
    cMgGobsal:= Trim(cAliastmp9->TPENVI)  +' '+ ;
                Trim(cAliastmp9->COMPTE)  +' '+ ;
                Trim(cAliastmp9->seq)     +' '+ ;
                Trim(cAliastmp9->TpAcao)  +' '+ ;
                Trim(cAliastmp9->Critica) +' '+ ;
                Trim(cAliastmp9->Enviado) +' '+ ;
                transform((cAliastmp9->Enviado),"@E 9999")+ CRLF
  EndIf 
     cAliastmp9->(dbSkip())
  EndDo
  
Next  
/////////////////////////////////

cQuery10 := CRLF+ " SELECT PD5_TPENVI TPENVI , pd5_Compte Compte, "
cQuery10 += CRLF+ "        pd5_sequen Seq , "
cQuery10 += CRLF+ "        substr(pd5_DtEnv,7,2)||'/'|| substr(pd5_DtEnv,5,2)||'/'||substr(pd5_DtEnv,1,4) DtEnv , "
cQuery10 += CRLF+ "        decode(pd5_enviad,'T','Sim','Não') Enviado , "
cQuery10 += CRLF+ "        count(*) QtdaProc , " 
cQuery10 += CRLF+ "        sum(decode(pd5_enviad,'T',1,0)) qtda_Enviado "
cQuery10 += CRLF + "  FROM " + RetSqlName('PD5') + " PD5" 		    
cQuery10 += CRLF + " WHERE PD5_FILIAL = '" + xFilial('PD5') + "' AND PD5.D_E_L_E_T_ = ' ' "

If trim(cCptEnvMen) > trim(cCptEnvGbl)
   
    cQuery10 += CRLF + " AND PD5_COMPTE = '" + trim(cCptEnvMen) + "'" 
    cQuery10 += CRLF + " AND PD5_TPENVI = 'Sib Mensal' " 			  
  
 Else   

    cQuery10 += CRLF + " AND PD5_COMPTE = '" + trim(cCptEnvGbl) + "'" 
    cQuery10 += CRLF + " AND PD5_TPENVI = 'Sib Global' " 			 

EndIf 

cQuery10 += CRLF + " GROUP BY PD5_TPENVI , pd5_Compte , pd5_sequen , "
cQuery10 += CRLF + "          substr(pd5_DtEnv,7,2)||'/'|| substr(pd5_DtEnv,5,2)||'/'||substr(pd5_DtEnv,1,4) , "
cQuery10 += CRLF + "          decode(pd5_enviad,'T','Sim','Não') "
cQuery10 += CRLF + "    order by PD5_TPENVI , pd5_Compte , pd5_sequen , "
cQuery10 += CRLF + "          substr(pd5_DtEnv,7,2)||'/'|| substr(pd5_DtEnv,5,2)||'/'||substr(pd5_DtEnv,1,4) , "
cQuery10 += CRLF + "          decode(pd5_enviad,'T','Sim','Não') "


If Select(cAliastmp10) <> 0 
   cAliastmp10->(DbCloseArea())  
Endif 

TcQuery cQuery10 New Alias cAliastmp10

While cAliastmp10->(!EOF())

      cEnviado := cAliastmp10->Enviado 

      totProc :=  totProc + cAliastmp10->QtdaProc

      cAliastmp10->(dbSkip())

EndDo

/////////////////////////////////


cqtdAtvAns := cAliastmp3->qtda
cqtdAtvOpe := cAliastmp4->qtda

While cAliastmp7->(!EOF())  
        
   If cAliastmp7->tpacao =='CANC'
       If cDtEnvGbl  < cAliastmp7->dtenv
          cDtEnvGbl  := cAliastmp7->dtenv
       EndIf    
       cqtdExcGbl := cAliastmp7->qtda
   ElseIf cAliastmp7->tpacao =='INCL' 
       If cDtEnvGbl  < cAliastmp7->dtenv
          cDtEnvGbl  := cAliastmp7->dtenv
       EndIf
       cqtdIncGbl := cAliastmp7->qtda
   ElseIf cAliastmp7->tpacao =='REAT' 
       If cDtEnvGbl  < cAliastmp7->dtenv
          cDtEnvGbl  := cAliastmp7->dtenv
       EndIf
       cqtdReaGbl := 0
   ElseIf cAliastmp7->tpacao =='RETI' 
       If cDtEnvGbl  < cAliastmp7->dtenv
          cDtEnvGbl  := cAliastmp7->dtenv
       EndIf
       cqtdRetIGbl := cAliastmp7->qtda
   Endif 
   
   cAliastmp7->(dbSkip()) 
 
 EndDo   
   
While cAliastmp2->(!EOF())  

   If cAliastmp2->tpacao =='CANC'
       If cDtEnvMen  < cAliastmp2->dtenv
          cDtEnvMen  := cAliastmp2->dtenv
       EndIf       
       cqtdExcMen := cAliastmp2->qtda
   ElseIf cAliastmp2->tpacao =='INCL' 
       If cDtEnvMen  < cAliastmp2->dtenv
          cDtEnvMen  := cAliastmp2->dtenv
       EndIf
   
       cqtdIncMen := cAliastmp2->qtda
   ElseIf cAliastmp2->tpacao =='REAT' 
       If cDtEnvMen  < cAliastmp2->dtenv
          cDtEnvMen  := cAliastmp2->dtenv
       EndIf
       cqtdReaMen := 0
   ElseIf cAliastmp2->tpacao =='RETI' 
       If cDtEnvMen  < cAliastmp2->dtenv
          cDtEnvMen  := cAliastmp2->dtenv
       EndIf
       cqtdRetIMen := cAliastmp2->qtda
   Endif 

cAliastmp2->(dbSkip()) 
 
 EndDo
 
 While cAliastmp5->(!EOF())  
 
   catvans++
 
   cAliastmp5->(dbSkip()) 
 EndDo

cqtdInatOp := catvans
 
 While cAliastmp6->(!EOF())  
 
   catvope++
 
   cAliastmp6->(dbSkip()) 
 
 EndDo

 cqtdInatAn := catvope
 
return ()	  

Static Function fSX6(cTipo)

DbSelectArea("SX6")
DbSetOrder(1)

If cTipo =='I'
   If DbSeek('  '+"MV_SIBINC")
      RecLock("SX6",.F.)
      SX6->X6_CONTEUD :=  iif(lSibInc,'1','2')
      MsUnLock()
   Endif
      cMensg:='O Parâmetro que controla o Envio da(s) INCLUSÕES Foi Alterado'
 ElseIf cTipo =='R' 
   If DbSeek('  '+"MV_SIBRET")
      RecLock("SX6",.F.)
  	  SX6->X6_CONTEUD :=  iif(lSibRet,'1','2')
      MsUnLock()
   Endif 
      cMensg:='O Parâmetro que controla o Envio da(s) RETIFICAÇÕES Foi Alterado'
ElseIf cTipo =='E'
   If DbSeek('  '+"MV_SIBEXC")
      RecLock("SX6",.F.)
  	  SX6->X6_CONTEUD :=  iif(lSibBlo,'1','2')
      MsUnLock()
   Endif
      cMensg:='O Parâmetro que controla o Envio da(s) EXCLUSÕES Foi Alterado'
ElseIf cTipo =='A'    
   If DbSeek('  '+"MV_SIBREA")
      RecLock("SX6",.F.)
  	  SX6->X6_CONTEUD :=  iif(lSibRea,'1','2')
      MsUnLock()
   Endif 
      cMensg:='O Parâmetro que controla o Envio da(s) REATIVAÇÕES Foi Alterado'
ElseIf cTipo =='M'   
   If DbSeek('  '+"MV_SIBMUC")
      RecLock("SX6",.F.)
  	  SX6->X6_CONTEUD :=  iif(lSibMuc,'1','2')
      MsUnLock()
   Endif
      cMensg:='O Parâmetro que controla o Envio da(s) MUDANÇAS CONTRATUAIS Foi Alterado'
Endif    
//oMGet1:refresh()
Return()

/*

for Faz :=1 to 2
cQuery9 := CRLF+ " Select    
cQuery9 += CRLF+ " case when (ba1_datblo > '20170101'  and ba1_datblo < '20190601' and ba1_codcco <> ' ' ) then '2 - Bloq'
cQuery9 += CRLF+ "      when (ba1_datinc > '20170101'  and ba1_datinc < '20190601' and ba1_codcco = ' '  ) then '1 - Incl'
cQuery9 += CRLF+ " else  ' ' End  acao , 
cQuery9 += CRLF+ " Ba1.Ba1_Traori,Ba1.Ba1_Trades,                                                            
cQuery9 += CRLF+ " Ba1_Codcco Codcco , Ba1_Cpfusr Cpf,Ba1_Nomusr Nomusr,  
cQuery9 += CRLF+ " Ba1_Codint||Ba1_Codemp||Ba1_Matric||Ba1_Tipreg||Ba1_Digito Matric ,    
cQuery9 += CRLF+ " substr(Ba1_Datinc,7,2)||'/'||substr(Ba1_Datinc,5,2)||'/'||substr(Ba1_Datinc,1,4) Datinc ,  
cQuery9 += CRLF+ " substr(Ba1_Datblo,7,2)||'/'||substr(Ba1_Datblo,5,2)||'/'||substr(Ba1_Datblo,1,4) DatBlo ,  
cQuery9 += CRLF+ " Ba1.Ba1_Motblo Motblo ,decode(Ba1_Consid,'U','Usuario', 'F', 'Familia', 'S', 'Sub Cont', ' ')  NivBloq,           
cQuery9 += CRLF+ " decode(BA1_LOCSIB,'0','0-HA ENVIAR', 
cQuery9 += CRLF+ " '1','1-ATIVO', 
cQuery9 += CRLF+ " '2','2-EXCLUIDO',  
cQuery9 += CRLF+ " '3','3-ENVIADO INCLUSAO', 
cQuery9 += CRLF+ " '4','4-ENVIADO ALTERACAO',
cQuery9 += CRLF+ " '5','5-ENVIADO EXCLUSAO',  
cQuery9 += CRLF+ " '6','6-FORCAR INCLUSAO',
cQuery9 += CRLF+ " '7','7-FORCAR ALTERACAO', 
cQuery9 += CRLF+ " '8','8-FORCAR EXCLUSAO', 
cQuery9 += CRLF+ " '9','9-MUDANCA CONTRATUAL',
cQuery9 += CRLF+ " 'A','A-REATIVACAO',
cQuery9 += CRLF+ " 'B','B-FORCAR MUD. CONTR.', 
cQuery9 += CRLF+ " 'C','C-FORCAR REATIVACAO') LocSib ,   
cQuery9 += CRLF+ " decode(BA1_ATUSIB,'0','Não','Sim') AtuSib ,
cQuery9 += CRLF+ " decode(BA1_INFSIB,'0','Não','Sim') InfSib , 
cQuery9 += CRLF+ " decode(BA1_INFANS,'0','Não','Sim') InfAns ,     
cQuery9 += CRLF+ " Decode(Trim(Ba1_Motblo),'', 'sem Bloq',( Decode(Trim(Case When Ba1_Consid = 'U' Then Nvl(Blqu.Descri, ' ' )   
cQuery9 += CRLF+ " When Ba1_Consid = 'F' Then Nvl(Blqf.Descri, ' ' )     
cQuery9 += CRLF+ " When Ba1_Consid = 'S' Then Nvl(Blqs.Descri, ' ' )   
cQuery9 += CRLF+ " Else 'S/Descriçao' End),Null,'Bloq Temp','Bloq Def')))  Bloq_Ans ,
cQuery9 += CRLF+ " Case When Ba1_Consid = 'U' Then Nvl(Blqu.Blqans, ' ' )   
cQuery9 += CRLF+ "      When Ba1_Consid = 'F' Then Nvl(Blqf.Blqans, ' ' )     
cQuery9 += CRLF+ "      When Ba1_Consid = 'S' Then Nvl(Blqs.Blqans, ' ' )   
cQuery9 += CRLF+ " Else 'S/Descriçao' End  inf_Ans , ba1_motblo

cQuery9 += CRLF+ " From + RetSqlName("BA1") +" BA1 , "
cQuery9 += CRLF+ " ( Select 'usuario' Origem  , Bg3_Codblo Codblo , Bg3_Desblo Descri , Bg3_Blqans  Blqans  From + RetSqlName("BG3") +" BG3  Where Bg3_Filial= '"+xFilial('BG3')+ "' And Bg3.D_E_L_E_T_ = ' ') Blqu , 
cQuery9 += CRLF+ " ( Select 'familia' Origem  , Bg1_Codblo Codblo , Bg1_Desblo Descri , Bg1_Blqans  Blqans  From + RetSqlName("BG1") +" BG1  Where Bg1_Filial= '"+xFilial('BG1')+ "' And Bg1.D_E_L_E_T_ = ' ') Blqf ,  
cQuery9 += CRLF+ " ( Select 'sub_cont' Origem , Bqu_Codblo Codblo , Bqu_Desblo Descri , Bqu_Blqans  Blqans  From + RetSqlName("BQU") +" BQU  Where Bqu_Filial= '"+xFilial('BQU')+ "' And Bqu.D_E_L_E_T_ = ' ') Blqs   
				
cQuery9 += CRLF+ " Where  Ba1_Filial = '"+xFilial('BA1')+ "'   And BA1.D_E_L_E_T_ = ' '        
cQuery9 += CRLF+ " And Ba1_Codint||Ba1_Codemp||Ba1_Matric||Ba1_Tipreg||Ba1_Digito in  
cQuery9 += CRLF+ " ( select Ba1_CODINT || Ba1_CODEMP || Ba1_MATRIC || Ba1_TIPREG || Ba1_DIGITO 
cQuery9 += CRLF+ "     from + RetSqlName("BA1") +" BA1  " 

If nFaz == 1
   if cCodEmp =='C'
      cQuery9 += CRLF+ "        , confsib_cab SIB
   Else 
      cQuery9 += CRLF+ "        , confsib_int SIB
   EndIf    
EndIf   

cQuery9 += CRLF+ "    where ba1_filial ='"+xFilial('BA1')+ "'   and d_E_L_E_T_ = ' ' 

If nFaz == 1
   cQuery9 += CRLF+ "      and ba1_datblo > '20170101'  and ba1_datblo < '20190601' and ba1_codcco <> ' ' 
   cQuery9 += CRLF+ "      and Ba1_CODINT || Ba1_CODEMP || Ba1_MATRIC || Ba1_TIPREG || Ba1_DIGITO   = SIB_MATRIC
   cQuery9 += CRLF+ "      and SIB_SITUAC(+) = '1'
Else 
   cQuery9 += CRLF+ "      and ba1_datinc > '20170101'  and ba1_datinc < '20190601' and ba1_codcco = ' ' 
EndIf 
cQuery9 += CRLF+ " ) 
cQuery9 += CRLF+ "      And Ba1_Motblo = Blqu.Codblo(+)   
cQuery9 += CRLF+ "      And Ba1_Motblo = Blqf.Codblo(+)   
cQuery9 += CRLF+ "      And Ba1_Motblo = Blqs.Codblo(+) 

if Faz == 1
   cQuery9 += CRLF+ "Union All "
Else 
   cQuery9 += CRLF+ "      order by 1 "
EndIf 

*/



				