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

User Function CABA150A()

/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±± Declaração de cVariable dos componentes                                 ±±
Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/
*/
Private cCptEnvGbl := Space(1)
Private cCptEnvMen := Space(1)
Private cCptEnvV   := Space(1)
Private cDetSibLoc := ' ' 
Private cDetSibMen := ' ' 
Private cDtEnvGbl  := Space(1)
Private cDtEnvMen  := Space(1)
Private cDtEnvV    := Space(1)
Private cEnviadoV  := Space(1)
Private cMensg    
Private cQtdAcatV  := 0
Private cqtdAFAns  := Space(1)
Private cqtdAFOpe  := Space(1)
Private cqtdAtvAns := Space(1)
Private cQtdEnvV   := 0
Private cqtdExcGbl := Space(1)
Private cqtdExcMen := Space(1)
Private cqtdIFAns  := Space(1)
Private cqtdIFOpe  := Space(1)
Private cqtdInatAn := Space(1)
Private cqtdIncGbl := Space(1)
Private cqtdIncMen := Space(1)
Private cQtdproV   := 0
Private cqtdReaGbl := Space(1)
Private cqtdReaMen := Space(1)
Private cqtdRetGbl := Space(1)
Private cqtdRetIMe := Space(1)
Private cSeqV      := Space(1)
Private cTpSibV    := Space(1)
Private lSibBlo    := .F.
Private lSibGlobal := .T.
Private lSibInc    := .T.
Private lSibMensal := .T.
Private lSibMuc    := .F.
Private lSibRea    := .F.
Private lSibRet    := .F.


*///////////////////*

private cSibEnv150 := GETMV("MV_SIBENV") // 1 - Sib SIM  , 0 - Sib NAO  

Private cEnvSibt   := Iif(cSibEnv150 == 1, 'Sim','Não')

Private cqtdAtvAns := Space(1)
Private cqtdAtvOpe := Space(1)

Private cSequencia := Space(1)
Private cTpSib     := Space(1)

private nTotProc   := 0
private nTotEnv    := 0
private nTotAcat   := 0

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
Private cAliastmp11  := GetNextAlias()
Private cAliastmp12  := GetNextAlias()
Private cAliastmp13  := GetNextAlias()
PRIVATE cCodEmp      :=  Iif(cEmpAnt == '01', 'C', 'I')

Private nFaz         := 1

Private lSibInc := IIf(GetMv("MV_SIBINC")== 1 ,.T.,.F.)
Private lSibRet := IIf(GetMv("MV_SIBRET")== 1 ,.T.,.F.)
Private lSibBlo := IIf(GetMv("MV_SIBEXC")== 1 ,.T.,.F.)
Private lSibRea := IIf(GetMv("MV_SIBREA")== 1 ,.T.,.F.)
Private lSibMuc := IIf(GetMv("MV_SIBMUC")== 1 ,.T.,.F.)    

private cTpSib    := Iif(substr(dtos(date()),7,2) < '06' , 'Sib Mensal', 'Sib Global')  

private lContExec:= .T. // controla se pedi ou não autorização para execuTAR
private cLcOrig:= '01'
/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±± Declaração de Variaveis Private dos Objetos                             ±±
Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/

SetPrvt("oDlg150","oGrp2","oSay3","oSay4","oSay5","oSay10","oSay11","oSay12","oGet7","oGet8","oGet9","oGet10")
SetPrvt("oGet12","oBtn25","oGrp3","oSay1","oSay2","oSay6","oSay7","oSay8","oSay9","oGet1","oGet2","oGet3")
SetPrvt("oGet5","oGet6","oBtn26","oGrp4","oSay13","oSay14","oGet13","oGet14","oBtn23","oGrp5","oBtn7")
SetPrvt("oBtn13","oBtn14","oBtn15","oBtn16","oBtn17","oBtn18","oBtn19","oBtn20","oBtn21","oBtn2","oBtn3")
SetPrvt("oBtn5","oBtn6","oBtn8","oBtn9","oGrp6","oSay15","oSay16","oGet15","oGet16","oBtn22","oGrp1")
SetPrvt("oGrp7","oCBox1","oCBox2","oCBox3","oCBox4","oCBox5","oBtn11","oGrp8","oSay17","oSay18","oSay19")
SetPrvt("oSay21","oSay24","oSay25","oSay26","oGet17","oGet18","oGet19","oGet20","oGet21","oGet24","oGet25")
SetPrvt("oBtn24","oGrp9","oCBox6","oCBox7","oBtn1","oGrp10","oSay22","oSay23","oGet22","oGet23","oBtn12")
SetPrvt("oMGet2","oGrp12","oMGet3")


If msgyesno("ATENÇÃO! Deseja Carregar dados Informativos do Sib , Esta opção pode levar Varios Mnutos")
   Processa({||fcarTela()}, "Aguarde !!!!", " Carregando Dados do Servidor", .T.) 
EndIf 

/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±± Definicao do Dialog e todos os seus componentes.                        ±±
Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/

oDlg150    := MSDialog():New( 000,282,703,1178,"Central Sib ",,,.F.,,,,,,.T.,,,.T. )
oGrp2      := TGroup():New( 034,096,066,440,"Status de Envio do SIB Global ",oDlg150,CLR_HRED,CLR_WHITE,.T.,.F. )
oSay3      := TSay():New( 042,383,{||"Qt Exclusões"},oGrp2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,042,008)
oSay4      := TSay():New( 042,335,{||"Qt Retificações "},oGrp2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,044,008)
oSay5      := TSay():New( 042,278,{||"Qt Exclusões"},oGrp2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,042,008)
oSay10     := TSay():New( 042,222,{||"Qt Inclusões"},oGrp2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,040,008)
oSay11     := TSay():New( 042,165,{||"Dta Ultimo Envio "},oGrp2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,043,008)
oSay12     := TSay():New( 042,109,{||"Compt Envio"},oGrp2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oGet7      := TGet():New( 052,385,{|u| If(PCount()>0,cqtdReaGbl:=u,cqtdReaGbl)},oGrp2,040,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cqtdReaGbl",,)
oGet8      := TGet():New( 052,336,{|u| If(PCount()>0,cqtdRetGbl:=u,cqtdRetGbl)},oGrp2,040,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cqtdRetGbl",,)
oGet9      := TGet():New( 052,279,{|u| If(PCount()>0,cqtdExcGbl:=u,cqtdExcGbl)},oGrp2,040,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cqtdExcGbl",,)
oGet10     := TGet():New( 052,222,{|u| If(PCount()>0,cqtdIncGbl:=u,cqtdIncGbl)},oGrp2,040,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cqtdIncGbl",,)
oGet11     := TGet():New( 052,165,{|u| If(PCount()>0,cDtEnvGbl:=u,cDtEnvGbl)},oGrp2,040,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cDtEnvGbl",,)
oGet12     := TGet():New( 052,108,{|u| If(PCount()>0,cCptEnvGbl:=u,cCptEnvGbl)},oGrp2,036,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cCptEnvGbl",,)

oBtn25     := TButton():New( 054,432,"?",oGrp2,{||fInfo('02')},005,008,,,,.T.,,"Informações . . .",,,,.F. )

oGrp3      := TGroup():New( 000,096,032,440,"Status de Envio do SIB Mensal ",oDlg150,CLR_HRED,CLR_WHITE,.T.,.F. )
oSay1      := TSay():New( 008,165,{||"Dta Ultimo Envio "},oGrp3,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,043,008)
oSay2      := TSay():New( 008,109,{||"Compt Envio"},oGrp3,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay6      := TSay():New( 008,222,{||"Qtd Inclusoes"},oGrp3,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,040,008)
oSay7      := TSay():New( 008,278,{||"Qt Exclusões"},oGrp3,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,042,008)
oSay8      := TSay():New( 008,383,{||"Qt Reativações"},oGrp3,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,044,008)
oSay9      := TSay():New( 008,335,{||"Qtd Retificações "},oGrp3,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,044,008)
oGet1      := TGet():New( 018,108,{|u| If(PCount()>0,cCptEnvMen:=u,cCptEnvMen)},oGrp3,036,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cCptEnvMen",,)
oGet2      := TGet():New( 018,222,{|u| If(PCount()>0,cqtdIncMen:=u,cqtdIncMen)},oGrp3,040,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cqtdIncMen",,)
oGet3      := TGet():New( 018,165,{|u| If(PCount()>0,cDtEnvMen:=u,cDtEnvMen)},oGrp3,040,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cDtEnvMen",,)
oGet4      := TGet():New( 018,279,{|u| If(PCount()>0,cqtdExcMen:=u,cqtdExcMen)},oGrp3,040,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cqtdExcMen",,)
oGet5      := TGet():New( 018,385,{|u| If(PCount()>0,cqtdReaMen:=u,cqtdReaMen)},oGrp3,040,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cqtdReaMen",,)
oGet6      := TGet():New( 018,336,{|u| If(PCount()>0,cqtdRetIMen:=u,cqtdRetIMen)},oGrp3,040,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cqtdRetIMen",,)
oBtn26     := TButton():New( 020,432,"?",oGrp3,{||fInfo('03')},005,008,,,,.T.,,"Informações ",,,,.F. )
oGrp4      := TGroup():New( 067,096,124,176,"Ativos ",oDlg150,CLR_HRED,CLR_WHITE,.T.,.F. )
oSay13     := TSay():New( 076,104,{||"ANS"},oGrp4,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay14     := TSay():New( 100,105,{||"Operadora"},oGrp4,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oGet13     := TGet():New( 086,104,{|u| If(PCount()>0,cqtdAtvAns:=u,cqtdAtvAns)},oGrp4,028,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cqtdAtvAns",,)
oGet14     := TGet():New( 111,105,{|u| If(PCount()>0,cqtdAtvOpe:=u,cqtdAtvOpe)},oGrp4,028,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cqtdAtvOpe",,)
oBtn23     := TButton():New( 111,168,"?",oGrp4,{||fInfo('04')},005,008,,,,.T.,,"Informações . . .",,,,.F. )
oGrp5      := TGroup():New( 000,000,340,092,"Opções ",oDlg150,CLR_HRED,CLR_WHITE,.T.,.F. )

oBtn7      := TButton():New( 170,004,"Consulta Base Do Sib ANS",oGrp5,{||fCABR260()},080,016,,,,.T.,,"Cabr260 - Consulta Base Do Sib ANS",,,,.F. )
oBtn10     := TButton():New( 008,004,"Seleção Tipo de  Envio Sib",oGrp5,{||fCABA140()},080,016,,,,.T.,,"CABA140 - opção de selecionar qual movimentação cadastral que sera envia",,,,.F. )
oBtn13     := TButton():New( 098,004,"Controle de Envio",oGrp5,{||fCABA145A()},080,016,,,,.T.,,"CABA145A - possibilidade de selecionar matricula / Cod CCo / Nome de usuarios para ser monstrado no browser de controle de envio",,,,.F. )
oBtn14     := TButton():New( 206,004,"Mapa Controle de Envio",oGrp5,{||fCABA144()},080,016,,,,.T.,,"CABA144 - sintetico das matricula processadas pelo sib , com varias formatações e filtros",,,,.F. )
oBtn15     := TButton():New( 188,004,"Atual. Tab. Conferencia Sib",oGrp5,{||fCABA143()},080,016,,,,.T.,,"CABA143 - faz atualização do Arquivos de conferencia do sib e atualiza totais por mês de vidas Ativas ",,,,.F. )
oBtn16     := TButton():New( 134,004,"Mapa Operadora  X  ANS",oGrp5,{||fCABA142()},080,016,,,,.T.,,"CABA142 - demonstra a distribuição de todas as matriula da operadora em relação a situação na ANS",,,,.F. )
oBtn17     := TButton():New( 152,004,"Preparo Sib Global",oGrp5,{||fCABA131()},080,016,,,,.T.,,"CABA131 - seleciona e trata matricula com inconformidades  na base ANS confrontadas com a base da operadora para preparo do sib Global",,,,.F. )
oBtn18     := TButton():New( 116,004,"Manut. Param. Envio ",oGrp5,{||fCABA148()},080,016,,,,.T.,,"CABA148 - manutenção das variáveis que controlarão o envio da matricula",,,,.F. )
oBtn19     := TButton():New( 242,004,"Log e Manut.  Paran. Do Sib ",oGrp5,{||fCABA149()},080,016,,,,.T.,,"CABA149 - browser que demonstras as açoes e que usuario sofreu , Permite manutenções nas variaveis de controle  ",,,,.F. )

oBtn20     := TButton():New( 080,004,"Retorno Do Sib  Operadora",oGrp5,{||fCABA147()},080,016,,,,.T.,,"CABA147 - Grava no arquivo de controle de envio , data do retorno da ans , operador , arquivos , criticas , e copia para area segura do arquivo processado",,,,.F. )

oBtn21     := TButton():New( 044,004,"Relatorio de Pre Critica ",oGrp5,{||fCABR171()},080,016,,,,.T.,,"CABR171 - Relatório de Pre Critica ",,,,.F. )

oBtn2      := TButton():New( 224,004,"Rel. Dif. ANS X Operadora ",oGrp5,{||fCABR263A()},080,016,,,,.T.,,"CABR263A - Rel. Dif. ANS X Operadora ",,,,.F. )

oBtn3      := TButton():New( 026,004,"Gera SIB XML",oGrp5,{||fPLSA782()},080,016,,,,.T.,,"PLSA782 - Gera SIB XML",,,,.F. )

oBtn4      := TButton():New( 314,004,"Sair",oGrp5,{||oDlg150:End()},080,016,,,,.T.,,"Sair do Sistema",,,,.F. )

oBtn5      := TButton():New( 062,004,"Vago (sem Função) ",oGrp5, ,080,016,,,,.T.,,"Vago para novas implementações ",,,,.F. )

oBtn6      := TButton():New( 260,004,"Ext. Inclusoes / exclusoes",oGrp5,{||fCABR272()},080,016,,,,.T.,,"CABR272 - Relatorio de Vidas ativas na caberj e nao existem na ans , e inativas na caberj e ativas na Ans",,,,.F. )
oBtn8      := TButton():New( 296,004,"Vago (sem Função)",oGrp5,,080,016,,,,.T.,,"Vago para novas implementações ",,,,.F. )
oBtn9      := TButton():New( 278,004,"Reinicializa Sib",oGrp5,{||fCABA158()},080,016,,,,.T.,,"CABA158 - Limpa os lancamento sde controle permitindo que seja regerado o sib totalmente",,,,.F. )

oGrp6      := TGroup():New( 067,178,124,258,"Dif. Entre Base - Ativos ",oDlg150,CLR_HRED,CLR_WHITE,.T.,.F. )
oSay15     := TSay():New( 076,182,{||"Falta Operadora "},oGrp6,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,040,008)
oSay16     := TSay():New( 100,183,{||"Falta na ANS"},oGrp6,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,035,008)
oGet15     := TGet():New( 086,182,{|u| If(PCount()>0,cqtdAFOpe:=u,cqtdAFOpe)},oGrp6,028,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cqtdAFOpe",,)
oGet16     := TGet():New( 111,183,{|u| If(PCount()>0,cqtdAFAns:=u,cqtdAFAns)},oGrp6,028,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cqtdAFAns",,)
oBtn22     := TButton():New( 111,250,"?",oGrp6,{||fInfo('06')},005,008,,,,.T.,,"Informações . . .",,,,.F. )
oGrp1      := TGroup():New( 288,096,340,440,"Mensagem do Sistema",oDlg150,CLR_HRED,CLR_WHITE,.T.,.F. )
oMGet1     := TMultiGet():New( 296,100,{|u| If(PCount()>0,cMensg:=u,cMensg)},oGrp1,336,040,,,CLR_BLACK,CLR_WHITE,,.T.,"",,,.F.,.F.,.T.,,,.F.,,  )
oGrp7      := TGroup():New( 068,343,124,440,"Controle de Tipo de Envio ",oDlg150,CLR_HRED,CLR_WHITE,.T.,.F. )
oCBox1     := TCheckBox():New( 076,348,"Inclusões",{|u| If(PCount()>0,lSibInc:=u,lSibInc)},oGrp7,040,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
oCBox2     := TCheckBox():New( 085,348,"Exclusões",{|u| If(PCount()>0,lSibRet:=u,lSibRet)},oGrp7,048,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
oCBox3     := TCheckBox():New( 094,348,"Retificações",{|u| If(PCount()>0,lSibBlo:=u,lSibBlo)},oGrp7,048,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
oCBox4     := TCheckBox():New( 103,348,"Reativações",{|u| If(PCount()>0,lSibRea:=u,lSibRea)},oGrp7,048,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
oCBox5     := TCheckBox():New( 112,348,"Mudança Contratural",{|u| If(PCount()>0,lSibMuc:=u,lSibMuc)},oGrp7,059,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
oBtn11     := TButton():New( 112,431,"?",oGrp7,{||fInfo('07')},005,008,,,,.T.,,"Informações . . .",,,,.F. )
oGrp8      := TGroup():New( 128,096,160,340,"Status Sib Vigente",oDlg150,CLR_BLACK,CLR_WHITE,.T.,.F. )
oSay17     := TSay():New( 136,100,{||"Tipo do Sib"},oGrp8,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay18     := TSay():New( 136,140,{||"Compte  "},oGrp8,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,036,008)
oSay19     := TSay():New( 136,164,{||"Seq."},oGrp8,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,012,008)
oSay20     := TSay():New( 136,185,{||"Dt Envio"},oGrp8,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,024,008)
oSay21     := TSay():New( 136,220,{||"Enviado"},oGrp8,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,020,008)
oSay24     := TSay():New( 136,245,{||"Qtda Proc."},oGrp8,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,027,008)
oSay25     := TSay():New( 136,274,{||"Qtda Env."},oGrp8,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,030,008)
oSay26     := TSay():New( 137,303,{||"Qtda Acatada"},oGrp8,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,033,008)
oGet17     := TGet():New( 146,100,{|u| If(PCount()>0,cTpSibV:=u,cTpSibV)},oGrp8,032,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cTpSibV",,)
oGet18     := TGet():New( 146,138,{|u| If(PCount()>0,cCptEnvV:=u,cCptEnvV)},oGrp8,022,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cCptEnvV",,)
oGet19     := TGet():New( 146,165,{|u| If(PCount()>0,cSeqV:=u,cSeqV)},oGrp8,011,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cSeqV",,)
oGet20     := TGet():New( 146,183,{|u| If(PCount()>0,cDtEnvV:=u,cDtEnvV)},oGrp8,031,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cDtEnvV",,)
oGet21     := TGet():New( 146,218,{|u| If(PCount()>0,cEnviadoV:=u,cEnviadoV)},oGrp8,020,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cEnviadoV",,)
oGet24     := TGet():New( 146,244,{|u| If(PCount()>0,cQtdproV:=u,cQtdproV)},oGrp8,024,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cQtdproV",,)
oGet25     := TGet():New( 146,275,{|u| If(PCount()>0,cQtdEnvV:=u,cQtdEnvV)},oGrp8,021,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cQtdEnvV",,)
oGet26     := TGet():New( 146,304,{|u| If(PCount()>0,cQtdAcatV:=u,cQtdAcatV)},oGrp8,020,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cQtdAcatV",,)
oBtn24     := TButton():New( 148,332,"?",oGrp8,{||fInfo('08')},005,008,,,,.T.,,"Informações . . .",,,,.F. )
oGrp9      := TGroup():New( 128,344,160,440,"Tipo de Sib Para Envio",oDlg150,CLR_HRED,CLR_WHITE,.T.,.F. )
oCBox6     := TCheckBox():New( 136,348,"Mensal",{|u| If(PCount()>0,lSibMensal:=u,lSibMensal)},oGrp9,040,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
oCBox7     := TCheckBox():New( 148,348,"Global",{|u| If(PCount()>0,lSibGlobal:=u,lSibGlobal)},oGrp9,040,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
oBtn1      := TButton():New( 148,432,"?",oGrp9,{||fInfo('09')},005,008,,,,.T.,,"Informações . . .",,,,.F. )
oGrp10     := TGroup():New( 067,260,124,341,"R E S E R V A D O",oDlg150,CLR_HRED,CLR_WHITE,.T.,.F. )
//oSay22     := TSay():New( 076,264,{||"Falta Operadora "},oGrp10,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,040,008)
//oSay23     := TSay():New( 100,265,{||"Falta na ANS"},oGrp10,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,035,008)
//oGet22     := TGet():New( 086,264,{|u| If(PCount()>0,cqtdIFOpe:=u,cqtdIFOpe)},oGrp10,028,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cqtdIFOpe",,)
//oGet23     := TGet():New( 111,265,{|u| If(PCount()>0,cqtdIFAns:=u,cqtdIFAns)},oGrp10,028,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cqtdIFAns",,)
oBtn12     := TButton():New( 111,332,"?",oGrp10,{||fInfo('10')},005,008,,,,.T.,,"Informações . . .",,,,.F. )
oGrp11     := TGroup():New( 162,096,284,268,"Detalhes Sib Mensal / Global ",oDlg150,CLR_HRED,CLR_WHITE,.T.,.F. )
oMGet2     := TMultiGet():New( 170,100,{|u| If(PCount()>0,cDetSibMen:=u,cDetSibMen)},oGrp11,164,108,,,CLR_BLACK,CLR_WHITE,,.T.,"",,,.F.,.F.,.F.,,,.F.,,  )
oGrp12     := TGroup():New( 162,272,284,441," Status de Sib (LocSib)",oDlg150,CLR_HRED,CLR_WHITE,.T.,.F. )
oMGet3     := TMultiGet():New( 170,276,{|u| If(PCount()>0,cDetSibLoc:=u,cDetSibLoc)},oGrp12,160,108,,,CLR_BLACK,CLR_WHITE,,.T.,"",,,.F.,.F.,.F.,,,.F.,,  )

oDlg150:Activate(,,,.T.)

Return

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
oGrp10:Disable     
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

   U_Cabr263a()      
     
Return 

Static Function fCabr272()

   U_Cabr272()      
     
Return 

Static Function fCaba158()

   U_Caba158()      
 
Return 

Static Function fplsa782()  

   cMensg:='Geração do arquivo de envio do Sib , rotina padrão'
 //  oMGet1:refresh()   

   plsa782C()   
   
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
   oBtn2:Disable()
   oBtn3:Disable()
   oBtn4:Disable()
   oBtn5:Disable()
   oBtn6:Disable()
   oBtn7:Disable()
   oBtn8:Disable()
   oBtn9:Disable()
   oBtn10:Disable()
   oBtn13:Disable()
   oBtn14:Disable()
   oBtn15:Disable()   
   oBtn16:Disable()
   oBtn17:Disable()
   oBtn18:Disable()
   oBtn19:Disable()
   oBtn20:Disable()   
else 
   oBtn2:enable()
   oBtn3:enable()
   oBtn4:enable()
   oBtn5:enable()
   oBtn6:enable()
   oBtn7:enable()
   oBtn8:enable()
   oBtn9:enable()
   oBtn10:enable()
   oBtn13:enable()
   oBtn14:enable()
   oBtn15:enable()   
   oBtn16:enable()
   oBtn17:enable()
   oBtn18:enable()
   oBtn19:enable()
   oBtn20:enable()

 EndIf 

oGet21:refresh() // verificar 

Return()

static Function fcarTela()

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
 
   cQuery := "select max(sib_dt_atu) DtAte, count(*) qtda from confsib_int where  sib_situac = '1'    " 

Else 
  
   cQuery := "select max(sib_dt_atu) DtAte, count(*) qtda  from confsib_cab where  sib_situac = '1'    "

EndIf                                

If Select(cAliastmp3) <> 0 
   cAliastmp3->(DbCloseArea())  
Endif 


TcQuery cQuery New Alias cAliastmp3

  cQuery := " SELECT COUNT(*) QTDA   FROM  " + RetSqlName('BA1') + " BA1" 	   + CRLF
  cQuery += "  WHERE BA1_FILIAL = '" + xFilial('BA1') + "'
  cQuery += "    and ba1_locsib not in('2','5') and ba1_codcco <> ' ' )" 	+ CRLF
  cQuery += "    AND BA1_INFANS <> '0' AND BA1_ATUSIB <> '0' AND BA1_INFSIB <> '0' " + CRLF

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

cQuery9 := CRLF + " SELECT PD5_TPENVI TPENVI ,  "  
cQuery9 += CRLF + "        pd5_Compte Compte, "
cQuery9 += CRLF + "        pd5_sequen Seq, "
cQuery9 += CRLF + "        pd5_tpacao TpAcao, "
cQuery9 += CRLF + "        decode(pd5_Critic,'T','Sim', 'Não') Critica, "
cQuery9 += CRLF + "        decode(pd5_enviad,'T','Sim', 'Não') Enviado, "
cQuery9 += CRLF + "        count(*) Qtda  "

 cQuery9 += CRLF + "   FROM " + RetSqlName('PD5') + " PD5" 		    
 cQuery9 += CRLF + "  WHERE PD5_FILIAL = '" + xFilial('PD5') + "' AND PD5.D_E_L_E_T_ = ' ' "
 
    cQuery9 += CRLF + " AND ((PD5_COMPTE = '" + trim(cCptEnvMen) + "'" 
    cQuery9 += CRLF + " AND PD5_TPENVI = 'Sib Mensal') " 			  
   
    cQuery9 += CRLF + " or (PD5_COMPTE = '" + trim(cCptEnvGbl) + "'" 
    cQuery9 += CRLF + " AND PD5_TPENVI = 'Sib Global')) " 			 
 
cQuery9 += CRLF+ "  GROUP BY PD5_TPENVI,  pd5_compte , pd5_sequen, pd5_tpacao , pd5_Critic , pd5_enviad "
cQuery9 += CRLF+ "  order by PD5_TPENVI,  pd5_compte , pd5_sequen, pd5_tpacao , pd5_Critic , pd5_enviad "

If Select(cAliastmp9) <> 0 
   cAliastmp9->(DbCloseArea())  
Endif 

TcQuery cQuery9 New Alias cAliastmp9

While cAliastmp9->(!EOF())
  
   cDetSibMen:= cDetSibMen + CRLF + ;
                'Tpe Envio --> ' + Trim(cAliastmp9->TPENVI)  + CRLF + ;
                'Compte    --> ' + Trim(cAliastmp9->COMPTE)  + CRLF + ;
                'Sequen.   --> ' + Trim(cAliastmp9->seq)     + CRLF + ;
                'Tp Ação   --> ' + Trim(cAliastmp9->TpAcao)  + CRLF +;
                'Critica   --> ' + Trim(cAliastmp9->Critica) + CRLF + ;
                'Enviado   --> ' + Trim(cAliastmp9->Enviado) + CRLF + ;
                'Quant.    --> ' + transform((cAliastmp9->Qtda),"@E 99,999") + CRLF
     
     cAliastmp9->(dbSkip())

  EndDo
   

cQuery11 := CRLF+ "SELECT decode(trim(ba1_codcco),'', 'Sem CCo','Com CCo') comcco , " 
cQuery11 += CRLF+ "       decode(ba1_locsib,'0','0-Há ENVIAR' , " 
cQuery11 += CRLF+ "                         '1','1-ATIVO' ,  "
cQuery11 += CRLF+ "                         '2','2-EXCLUÍDO' ,  "
cQuery11 += CRLF+ "                         '3','3-ENV. INCLUSÃO' , "
cQuery11 += CRLF+ "                         '4','4-ENV. ALTERAÇÃO' ,  "
cQuery11 += CRLF+ "                         '5','5-ENV. EXCLUSÃO' ,  "
cQuery11 += CRLF+ "                         '6','6-FORÇAR INCLUSÃO' ,  "
cQuery11 += CRLF+ "                         '7','7-FORÇAR ALTERAÇÃO' , " 
cQuery11 += CRLF+ "                         '8','8-FORÇAR EXCLUSÃO' , "  
cQuery11 += CRLF+ "                         '9','9-ENV. MUDANÇA CONTR.' , " 
cQuery11 += CRLF+ "                         'A','A-ENV. REATIVAÇÃO' ,  "
cQuery11 += CRLF+ "                         'B','B-FORÇAR MUDANÇA CONTR.' , "  
cQuery11 += CRLF+ "                         'C','C-FORÇAR REATIVAÇÃO' , "
cQuery11 += CRLF+ "                         'Outros - Não Previsto')  stcab , " 
cQuery11 += CRLF+ "       count(*) qtda  "
cQuery11 += CRLF+ "  FROM " + RetSqlName('BA1') + " BA1" 
cQuery11 += CRLF+ " where ba1.D_E_L_E_T_ = ' ' and ba1_filial = ' ' "      
cQuery11 += CRLF+ "   AND BA1_INFANS <> '0' AND BA1_ATUSIB <> '0' AND BA1_INFSIB <> '0' "
cQuery11 += CRLF+ " GROUP BY decode(trim(ba1_codcco),'', 'Sem CCo','Com CCo') , "
cQuery11 += CRLF+ "       decode(ba1_locsib,'0','0-Há ENVIAR' , " 
cQuery11 += CRLF+ "                         '1','1-ATIVO' ,  "
cQuery11 += CRLF+ "                         '2','2-EXCLUÍDO' ,  "
cQuery11 += CRLF+ "                         '3','3-ENV. INCLUSÃO' , "
cQuery11 += CRLF+ "                         '4','4-ENV. ALTERAÇÃO' ,  "
cQuery11 += CRLF+ "                         '5','5-ENV. EXCLUSÃO' ,  "
cQuery11 += CRLF+ "                         '6','6-FORÇAR INCLUSÃO' ,  "
cQuery11 += CRLF+ "                         '7','7-FORÇAR ALTERAÇÃO' , " 
cQuery11 += CRLF+ "                         '8','8-FORÇAR EXCLUSÃO' , "  
cQuery11 += CRLF+ "                         '9','9-ENV. MUDANÇA CONTR.' , " 
cQuery11 += CRLF+ "                         'A','A-ENV. REATIVAÇÃO' ,  "
cQuery11 += CRLF+ "                         'B','B-FORÇAR MUDANÇA CONTR.' , "  
cQuery11 += CRLF+ "                         'C','C-FORÇAR REATIVAÇÃO' , "
cQuery11 += CRLF+ "                         'Outros - Não Previsto')   " 
cQuery11 += CRLF+ " order by 2 "

If Select(cAliastmp11) <> 0   
   cAliastmp11->(DbCloseArea())  
Endif 

TcQuery cQuery11 New Alias cAliastmp11

While cAliastmp11->(!EOF())
 
  
   cDetSibLoc:= cDetSibLoc + CRLF + ;
                ' Cco          --> ' + Trim(cAliastmp11->comcco)  + CRLF + ;
                ' Status Envio --> ' + Trim(cAliastmp11->stcab)  + CRLF + ;
                ' Quant.       --> ' + transform((cAliastmp11->Qtda),"@E 99,999") + CRLF
     
   cAliastmp11->(dbSkip())

EndDo

// diferença de ativos na caberj que nao estao ativos na ANS 

cQuery12 := CRLF+ " select count(*) qtda  from ( "
cQuery12 += CRLF+ " select ba1_codcco "
cQuery12 += CRLF+ "  FROM " + RetSqlName('BA1') + " BA1" 
cQuery12 += CRLF+ " where ba1.D_E_L_E_T_ = ' ' and ba1_filial = ' ' "      
cQuery12 += CRLF+ "   AND BA1_INFANS <> '0' AND BA1_ATUSIB <> '0' AND BA1_INFSIB <> '0' "
cQuery12 += CRLF+ "   and ba1_locsib not in('2','5') and ba1_codcco <> ' ' "
cQuery12 += CRLF+ "minus "
cQuery12 += CRLF+ "   select sib_codcco "
If cCodEmp =='C'
   cQuery12 += CRLF+ "   from confsib_cab "
Else 
   cQuery12 += CRLF+ "   from confsib_int "
EndIf      
cQuery12 += CRLF+ "    where sib_situac = '1') "


If Select(cAliastmp12) <> 0   
   cAliastmp12->(DbCloseArea())  
Endif 

TcQuery cQuery12 New Alias cAliastmp12

cqtdAFAns:= cAliastmp12->qtda 


// diferença de ativos na ANS que nao estao ativos na caberj 

cQuery13 := CRLF+ " select count(*) qtda  from ( "
cQuery13 += CRLF+ "   select sib_codcco "
If cCodEmp =='C'
   cQuery13 += CRLF+ "   from confsib_cab "
Else 
   cQuery13 += CRLF+ "   from confsib_int "
EndIf      
cQuery13 += CRLF+ "    where sib_situac = '1'
cQuery13 += CRLF+ "minus "
cQuery13 += CRLF+ " select ba1_codcco "
cQuery13 += CRLF+ "  FROM " + RetSqlName('BA1') + " BA1" 
cQuery13 += CRLF+ " where ba1.D_E_L_E_T_ = ' ' and ba1_filial = ' ' "      
cQuery13 += CRLF+ "   AND BA1_INFANS <> '0' AND BA1_ATUSIB <> '0' AND BA1_INFSIB <> '0' "
cQuery13 += CRLF+ "   and ba1_locsib not in('2','5') and ba1_codcco <> ' ' ) "

If Select(cAliastmp13) <> 0   
   cAliastmp13->(DbCloseArea())  
Endif 

TcQuery cQuery13 New Alias cAliastmp13

cqtdAFOpe:= cAliastmp13->qtda

cMensg:= "Escolha uma Opção " 
///oMGet1:refresh()
oMGet2:refresh()
oMGet3:refresh()
Ftpsib()

cCptEnvMen:= cCptEnvMen
/////////////////////////////////

cQuery10 := CRLF+ " SELECT PD5_TPENVI TPENVI , pd5_Compte Compte, "
cQuery10 += CRLF+ "        pd5_sequen Seq , "
cQuery10 += CRLF+ "        substr(pd5_DtEnv,7,2)||'/'|| substr(pd5_DtEnv,5,2)||'/'||substr(pd5_DtEnv,1,4) DtEnv , "
cQuery10 += CRLF+ "        decode(pd5_enviad,'T','Sim','Não') Enviado , "
cQuery10 += CRLF+ "        count(*) QtdaProc , " 
cQuery10 += CRLF+ "        sum(decode(pd5_enviad,'T',1,0)) qtda_Env ,"
cQuery10 += CRLF+ "        sum(decode(pd5_enviad,'T',(decode(trim(pd5_crians),null,1,0)),0)) acatado "
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

cEnviado := cAliastmp10->Enviado 
cTpSibV := cAliastmp10->TPENVI
cCptEnvV:= cAliastmp10->Compte
cDtEnvV   := cAliastmp10->DtEnv 


While cAliastmp10->(!EOF())
      If cEnviado <> 'Sim'
         cEnviado := cAliastmp10->Enviado 
      EndIf 
      If cDtEnvV == cAliastmp10->DtEnv .and. cEnviado == 'Sim'
         cDtEnvV   := cAliastmp10->DtEnv
      EndIf 
      if cSeqV !=  cAliastmp10->Seq      
         cSeqV := cAliastmp10->Seq
         nTotProc := 0
         nTotEnv  := 0
         nTotacat := 0
      EndIf 

      nTotProc :=  nTotProc + cAliastmp10->QtdaProc
      nTotEnv  :=  nTotEnv  + cAliastmp10->qtda_Env
      nTotacat :=  nTotacat + cAliastmp10->acatado

      cAliastmp10->(dbSkip())

EndDo

cQtdproV :=  nTotProc   
cQtdEnvV :=  nTotEnv    
cQtdAcatV:=  nTotAcat   



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



static function fInfo(cLcOrig)

   local cOrigem:= cLcOrig

   If cOrigem = '03'
    
      Alert("Status de Envio do SIB Mensal"+CRLF+ "Informações sobre o ultimo envio do Sib Mensal a ANS")

      Mensg:="Status de Envio do SIB Mensal"+CRLF+ "Informações sobre o ultimo envio do Sib Mensal a ANS"

   ElseIf cOrigem = '02' 

      Mensg:="Status de Envio do SIB Global"+CRLF+ "Informações sobre o ultimo envio do Sib Mensal a ANS"

   ElseIf cOrigem = '04' 

       Mensg:="Ativos "+CRLF+ "Quantidades de Ativos na Operadoara e na ANS"

   ElseIf cOrigem = '06' 

       Mensg:="Dif. Entre Base - Ativos "+CRLF+ "Quantidades de Ativos na Operadoara que Não Esta na ANS" 

   EndIf                  

Return 

static Function Ftpsib()
    
    If cTpSib == 'Sib Mensal'
        lSibMensal:=.T.
        lSibGlobal:=.F. 
    Else     
        lSibMensal:=.F.
        lSibGlobal:=.T.
    EndIf     
Return()










