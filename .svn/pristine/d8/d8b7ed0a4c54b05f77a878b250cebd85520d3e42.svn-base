#include "PROTHEUS.CH"                                                                                                                                   
#Include 'PLSMGER.CH'
#include "PLSMGER2.CH"
#include "PLSMCCR.CH"                                               
#include "topconn.ch"
#INCLUDE "TOTVS.CH"
#INCLUDE 'RWMAKE.CH'
#INCLUDE 'FONT.CH'
#INCLUDE 'COLORS.CH'  

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ                  
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABA411   ºAutor  ³ Altamiro	         º Data ³  19/06/2015 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Tela de browser do sistema juridico                        º±±
±±º          ³ 															  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/


User Function caba411(cNCab411,cNproc411,cNCompP411)                 

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta matriz com as opcoes do browse...                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE aRotina	:=	{	{ "&Visualizar"	, "U_Cab411a"		, 0 , 1	 },; 
					  	{ "&Alteracao"	, "U_Cab411a"		, 0 , 2  },;
                        { "&Incluir"	, "U_Cab411a"		, 0 , 3	 },;
                        { "Legenda"		, "U_LEGPROSb"	    , 0 , 3	 }}  
						
						

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Titulo e variavies para indicar o status do arquivo                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE cCadastro	:= "Browser do Sistema juridico "

PRIVATE aCdCores	:= { 	{ 'BR_VERDE'    ,'Processo Incluido '         },;
							{ 'BR_AZUL'     ,'Processo Com Decissão'      },; 
							{ 'BR_VERMELHO' ,'Processo Arquivado'         },;							
							{ 'BR_AMARELO'  ,'Processo Audiencia Marcada' },;
							{ 'BR_PRETO'    ,'Processo Desdobramento' }}

PRIVATE aCores	:= {{'!empty(PBX_NUMCOM)', aCdCores[5,1]},;
                    {'!empty(PBX_NUMPRO)', aCdCores[1,1]},;
					{'!empty(PBX_NUMPRO)', aCdCores[2,1]},;
					{'!empty(PBX_NUMPRO)', aCdCores[3,1]},;
					{'!empty(PBX_NUMPRO)', aCdCores[4,1]} }
//PRIVATE cPath  := ""                        
PRIVATE cAlias := "PBX" 

PRIVATE cPerg	:= "CABA411"

PRIVATE cNomeProg   := "CABA411"
PRIVATE nQtdLin     := 68
PRIVATE nLimite     := 132
PRIVATE cControle   := 15
PRIVATE cTamanho    := "G"
PRIVATE cTitulo     := "Controle de processos judiciais - Audiencias e Prazos "
PRIVATE cDesc1      := ""
PRIVATE cDesc2      := ""
PRIVATE cDesc3      := ""
PRIVATE nRel        := "caba411"
PRIVATE nlin        := 100
PRIVATE nOrdSel     := 1                                             
PRIVATE m_pag       := 1
PRIVATE lCompres    := .F.
PRIVATE lDicion     := .F.
PRIVATE lFiltro     := .T.
PRIVATE lCrystal    := .F.
PRIVATE aOrdens     := {} 
PRIVATE aReturn     := { "", 1,"", 1, 1, 1, "",1 }
PRIVATE lAbortPrint := .F.
PRIVATE cCabec1     := "Controle de Processo judiciais - Audiencias e Prazos "
PRIVATE cCabec2     := ""
PRIVATE nColuna     := 00  
private nopc411n    := 0 
//private cUsuario    := SubStr(cUSUARIO,7,15)  
private cAssunto    := ' '
private aDados      := {}        
private aDados1      := {}


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Starta mBrowse...                                                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ     
dbselectarea("PBX")
PBX->(DBSetOrder(1))       
 
SET FILTER TO (PBX_NUMPRO == cNCab411 .AND. PBX_PROCES == cNproc411 .AND. PBX_NUMCOM == cNCompP411) 
//PBW->(mBrowse(006,001,022,075,"PBW" , , , , , Nil    , aCores, , , ,nil, .T.))  
PBX->(mBrowse(006,001,022,075,"PBX" , , , , , 2    , aCores, , , ,nil, .F.)) 
//mBrowse(6, 1, 22, 75, "PBW",,,,,,aCores)
PBX->(DbClearFilter())
DbCloseArea()
Return()
              

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±±
±±³Funcao    ³ CBIMPLEG   ³ Autor ³ Jean Schulz         ³ Data ³ 06.09.06 ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±±
±±³Descricao ³ Exibe a legenda...                                         ³±±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function LEGPROSb()
Local aLegenda

	aLegenda 	:= { 	{ aCdCores[1,1],aCdCores[1,2] },;
						{ aCdCores[2,1],aCdCores[2,2] },;
						{ aCdCores[3,1],aCdCores[3,2] },;
	              	{ aCdCores[4,1],aCdCores[4,2] },;
	              	{ aCdCores[5,1],aCdCores[5,2] } }

	                     	
BrwLegenda(cCadastro,"Status" ,aLegenda)

Return

User Function cab411a(cAlias,nReg,nOpc)  


/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±± Declaração de cVariable dos componentes                                 ±±
Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/
Private cAssAud    := Space(50)
Private cCcDesc1   := Space(20)
Private cCcDesc2   := Space(20)
Private cCcDesc3   := Space(20)
Private cCcDesc4   := Space(20)
Private cCcEnv1    := Space(6)
Private cCcEnv2    := Space(6)
Private cCcEnv3    := Space(6)
Private cCcEnv4    := Space(6)
Private cEmailenv1 := Space(120)
Private cEmailenv2 := Space(120)
Private cEmailenv3 := Space(120)
Private cEmailenv4 := Space(120)
Private cHoraDist  := 0
Private cHoraFim   := 0
Private cHoraInc   := 0
Private cHoraRec   := 0
Private cIdPrazo   := Space(6)
Private cmObsPrazo
Private cNomeEnv1  := Space(40)
Private cNomeEnv2  := Space(40)
Private cNomeEnv3  := Space(40)
Private cNomeEnv4  := Space(40)
Private cNumCab    := 0
Private cNumCompP  := Space(20)
Private cNumproc   := Space(30)
Private cTpAut     := Space(30)
Private cTpProc    := Space(30)
Private dDtFim     := CtoD(" ")
Private dDtInc     := DATE()
Private dDtRec     := CtoD(" ")
Private lEmail1    := .F.
Private lEmail2    := .F.
Private lEmail3    := .F.
Private lEmail4    := .F.
Private nMotass   
Private nTpEnv1   
Private nTpEnv2   
Private nTpEnv3   
Private nTpEnv4   

Private nStAud

private dDtAtu      := dDataBase
                                       

/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±± Declaração de Variaveis Private dos Objetos                             ±±
Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/
SetPrvt("oDlg2","oGrp2","oSay8","oSay10","oSay12","oSay13","oSay4","oEmail1","oCcDesc1","oCC1","oGet7")
SetPrvt("oCBox3","oCBox4","oGet3","oGet4","oGet5","oGet6","oCBox5","oCBox6","oGet9","oGet10","oGet11")
SetPrvt("oCBox7","oCBox8","oGet13","oGet14","oGet15","oGet16","oCBox9","oGrp1","oMGet1","oGrp3","oCBox10")
SetPrvt("oSay5","oSay34","oSay35","oSay7","oSay9","oSay14","oSay15","oDtDist","oHoraDist","oGet17","oGet18")
SetPrvt("oGrp8","oGrp5","oGet20","oGrp6","oBtn3411","oBtn5411","oBtn6411","oGrp7","oSay16","oSay17","oSay18","oSay19")
SetPrvt("oSay39","oSay40","oSay20","oSay21","oGet21","oGet22","oHoraRec","oDtRec","oGet23","oGet1","oGet2","oCBox1")

dbselectarea("PBX")          


nopc411n:=nopc

If nopc411n == 3 
  cIdPrazo:=fPrNPbx()
else       
   	 dbselectarea("PBX")
     DbGoto(nReg)
     fMArqVar()    
    
EndIf                    
     fMPBWVar()

/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±± Definicao do Dialog e todos os seus componentes.                        ±±
Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/ 

oDlg2      := MSDialog():New( 119,317,596,1158,"Controle de Audiências ,  Prazos e Acompanhamentos     Caba411  v1.00",,,.F.,,,,,,.T.,,,.T. )
oGrp2      := TGroup():New( 108,004,184,416,"Envolvido(S)",oDlg2,CLR_BLACK,CLR_WHITE,.T.,.F. )
oSay8      := TSay():New( 120,068,{||"Nome"},oGrp2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,056,008)
oSay10     := TSay():New( 120,184,{||"Email "},oGrp2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay12     := TSay():New( 120,288,{||"C.Custo"},oGrp2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay13     := TSay():New( 120,316,{||"Descrição "},oGrp2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay4      := TSay():New( 120,008,{||"Tipo"},oGrp2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oEmail1    := TCheckBox():New( 128,385,"Email ?",{|u| If(PCount()>0,lEmail1:=u,lEmail1)},oGrp2,027,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
oCcDesc1   := TGet():New( 128,317,{|u| If(PCount()>0,cCcDesc1:=u,cCcDesc1)},oGrp2,068,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cCcDesc1",,)

//oCC1       := TGet():New( 128,289,{|u| If(PCount()>0,cCcEnv1:=u,cCcEnv1)},oGrp2,017,008,'', ,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.T.,,.F.,.F.,"CTT","cCcEnv1",,)
oCC1       := TGet():New( 128,289,{|u| If(PCount()>0,(cCcEnv1:=u,fConsulCC(cCcEnv1,1),oCcDesc1:refresh(), oGet8:refresh(), oGet7:refresh()),cCcEnv1)},oGrp2,017,008,'', ,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.T.,,.F.,.F.,"CTTJUR","cCcEnv1",,)
oGet7      := TGet():New( 128,065,{|u| If(PCount()>0,cNomeEnv1:=u,cNomeEnv1)},oGrp2,116,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cNomeEnv1",,)
oGet8      := TGet():New( 128,185,{|u| If(PCount()>0,(cEmailenv1:=u,fMarcEm(cEmailenv1,1)),cEmailenv1)},oGrp2,100,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cEmailenv1",,)
oCBox3     := TComboBox():New( 128,005,{|u| If(PCount()>0,nTpEnv1:=u,nTpEnv1)},{" " ,"Preposto","Testemunha","Comp. Audiencia","Subsídios","Assist. Tecnico","Outro"},056,010,oGrp2,,,,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,,nTpEnv1 )

oCBox4     := TCheckBox():New( 141,385,"Email ?",{|u| If(PCount()>0,lEmail2:=u,lEmail2)},oGrp2,027,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
oGet3      := TGet():New( 141,317,{|u| If(PCount()>0,cCcDesc2:=u,cCcDesc2)},oGrp2,068,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cCcDesc2",,)

//oGet4      := TGet():New( 141,289,{|u| If(PCount()>0,cCcEnv2:=u,cCcEnv2)},oGrp2,017,008,'', ,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.T.,,.F.,.F.,"CTT","cCcEnv2",,)
oGet4      := TGet():New( 141,289,{|u| If(PCount()>0,(cCcEnv2:=u,fConsulCC(cCcEnv2,2),oget3:refresh()),cCcEnv2)},oGrp2,017,008,'', ,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.T.,,.F.,.F.,"CTTJUR","cCcEnv2",,)

oGet5      := TGet():New( 141,185,{|u| If(PCount()>0,(cEmailenv2:=u,fMarcEm(cEmailenv2,2)),cEmailenv2)},oGrp2,100,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cEmailenv2",,)
oGet6      := TGet():New( 141,065,{|u| If(PCount()>0,cNomeEnv2:=u,cNomeEnv2)},oGrp2,116,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cNomeEnv2",,)
oCBox5     := TComboBox():New( 141,005,{|u| If(PCount()>0,nTpEnv2:=u,nTpEnv2)},{" " ,"Preposto","Testemunha","Comp. Audiencia","Subsídios","Assist. Tecnico","Outro"},056,010,oGrp2,,,,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,,nTpEnv2 )

oCBox6     := TCheckBox():New( 155,385,"Email ?",{|u| If(PCount()>0,lEmail3:=u,lEmail3)},oGrp2,027,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
oGet9      := TGet():New( 155,317,{|u| If(PCount()>0,cCcDesc3:=u,cCcDesc3)},oGrp2,068,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cCcDesc3",,)

oGet10     := TGet():New( 155,289,{|u| If(PCount()>0,(cCcEnv3:=u,fConsulCC(cCcEnv3,3),oget9:refresh()),cCcEnv3)},oGrp2,017,008,'', ,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.T.,,.F.,.F.,"CTTJUR","cCcEnv3",,)
//oGet10     := TGet():New( 155,289,{|u| If(PCount()>0,cCcEnv3:=u,cCcEnv3)},oGrp2,017,008,'', ,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.T.,,.F.,.F.,"CTT","cCcEnv3",,)

oGet11     := TGet():New( 155,185,{|u| If(PCount()>0,(cEmailenv3:=u,fMarcEm(cEmailenv3,3)),cEmailenv3)},oGrp2,100,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cEmailenv3",,)
oGet12     := TGet():New( 155,065,{|u| If(PCount()>0,cNomeEnv3:=u,cNomeEnv3)},oGrp2,116,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cNomeEnv3",,)
oCBox7     := TComboBox():New( 154,005,{|u| If(PCount()>0,nTpEnv3:=u,nTpEnv3)},{" " , "Preposto","Testemunha","Comp. Audiencia","Subsídios","Assist. Tecnico","Outro"},056,010,oGrp2,,,,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,,nTpEnv3 )

oCBox8     := TCheckBox():New( 168,385,"Email ?",{|u| If(PCount()>0,lEmail4:=u,lEmail4)},oGrp2,027,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
oGet13     := TGet():New( 168,317,{|u| If(PCount()>0,cCcDesc4:=u,cCcDesc4)},oGrp2,068,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cCcDesc4",,)

oGet14     := TGet():New( 168,289,{|u| If(PCount()>0,(cCcEnv4:=u,fConsulCC(cCcEnv4,4),oget13:refresh()),cCcEnv4)},oGrp2,017,008,'', ,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.T.,,.F.,.F.,"CTTJUR","cCcEnv4",,)

oGet15     := TGet():New( 168,185,{|u| If(PCount()>0,(cEmailenv4:=u,fMarcEm(cEmailenv4,4)),cEmailenv4)},oGrp2,100,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cEmailenv4",,)
oGet16     := TGet():New( 168,065,{|u| If(PCount()>0,cNomeEnv4:=u,cNomeEnv4)},oGrp2,116,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cNomeEnv4",,)
oCBox9     := TComboBox():New( 167,005,{|u| If(PCount()>0,nTpEnv4:=u,nTpEnv4)},{" " ,"Preposto","Testemunha","Comp. Audiencia","Subsídios","Assist. Tecnico","Outro"},056,010,oGrp2,,,,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,,nTpEnv4 )
oGrp1      := TGroup():New( 184,004,236,416,"Observações ",oDlg2,CLR_BLACK,CLR_WHITE,.T.,.F. )
oMGet1     := TMultiGet():New( 192,008,{|u| If(PCount()>0,cmObsPrazo:=u,cmObsPrazo)},oGrp1,404,036,,,CLR_BLACK,CLR_WHITE,,.T.,"",,,.F.,.F.,.F.,,,.F.,,  )
oGrp3      := TGroup():New( 084,004,108,416,"Motivo/Assunto",oDlg2,CLR_BLACK,CLR_WHITE,.T.,.F. )
oCBox10    := TComboBox():New( 094,008,{|u| If(PCount()>0,nMotass:=u,nMotass)},{" " ,"Audiencia ","Intimação ","Petição", "Subsídios","Pericia" },404,010,oGrp3,,,,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,,nMotass )

oGrp4      := TGroup():New( 000,088,028,240,"Prazos",oDlg2,CLR_BLACK,CLR_WHITE,.T.,.F. )
oSay5      := TSay():New( 004,120,{||"Início"},oGrp4,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,016,008)
oSay34     := TSay():New( 007,096,{||"Data"},oGrp4,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,016,008)
oSay35     := TSay():New( 024,362,{||"Hora"},oGrp4,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,018,008)
oSay7      := TSay():New( 007,140,{||"Hora"},oGrp4,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,020,008)
oSay9      := TSay():New( 004,196,{||"Fim "},oGrp4,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,020,008)
oSay14     := TSay():New( 007,217,{||"Hora"},oGrp4,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,020,008)
oSay15     := TSay():New( 007,177,{||"Data"},oGrp4,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,016,008)
oDtDist    := TGet():New( 014,096,{|u| If(PCount()>0,(dDtInc:=u,fValDt(1)),dDtInc)},oGrp4,032,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","dDtInc",,)
//oHoraDist  := TGet():New( 048,376,{|u| If(PCount()>0,cHoraDist:=u,cHoraDist)},oGrp4,016,008,'@E 99:99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cHoraDist",,)
oGet17     := TGet():New( 014,140,{|u| If(PCount()>0,cHoraInc:=u,cHoraInc)},oGrp4,024,008,'@E 99:99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cHoraInc",,)
oGet19     := TGet():New( 014,173,{|u| If(PCount()>0,(dDtFim:=u,fValDt(2)),dDtFim)},oGrp4,032,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","dDtFim",,)
oGet18     := TGet():New( 014,213,{|u| If(PCount()>0,cHoraFim:=u,cHoraFim)},oGrp4,024,008,'@E 99:99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cHoraFim",,)
oGrp5      := TGroup():New( 000,004,028,084,"Identificação ",oDlg2,CLR_BLACK,CLR_WHITE,.T.,.F. )
oGet20     := TGet():New( 012,008,{|u| If(PCount()>0,cIdPrazo:=u,cIdPrazo)},oGrp5,060,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cIdPrazo",,)

oGrp6      := TGroup():New( 000,308,028,416,"Controles",oDlg2,CLR_BLACK,CLR_WHITE,.T.,.F. )
oBtn3411   := TButton():New( 010,312,"Grava",oGrp6,{||fgrava()},032,012,,,,.T.,,"",,,,.F. )
oBtn5411   := TButton():New( 010,346,"Deleta",oGrp6,{||fDeleta()},032,012,,,,.T.,,"",,,,.F. )
oBtn6411   := TButton():New( 010,380,"Sair",oGrp6,{||oDlg2:End()},032,012,,,,.T.,,"",,,,.F. )

oGrp7      := TGroup():New( 032,004,084,416,"Identificação do Processo",oDlg2,CLR_BLACK,CLR_WHITE,.T.,.F. )
oSay16     := TSay():New( 040,204,{||"Tipo Autor "},oGrp7,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay17     := TSay():New( 040,264,{||"Tipo Processo "},oGrp7,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,044,008)
oSay18     := TSay():New( 040,060,{||"Num. Processo "},oGrp7,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,040,008)
oSay19     := TSay():New( 040,008,{||"Num. Caberj"},oGrp7,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay38     := TSay():New( 035,360,{||"Recebimento"},oGrp7,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay39     := TSay():New( 041,391,{||"Hora"},oGrp7,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,024,008)
oSay40     := TSay():New( 041,353,{||"Data"},oGrp7,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,020,008)
oSay20     := TSay():New( 040,145,{||"Num. Compl."},oGrp7,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,040,008)
oSay21     := TSay():New( 060,009,{||"Assunto :"},oGrp7,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,023,008)
oGet21     := TGet():New( 050,058,{|u| If(PCount()>0,cNumproc:=u,cNumproc)},oGrp7,076,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"Numero do processo",,,.F.,.F.,,.T.,.F.,"","cNumproc",,)
oGet22     := TGet():New( 050,008,{|u| If(PCount()>0,cNumCab:=u,cNumCab)},oGrp7,044,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"Num sequencial do processo na Caberj / Integral",,,.F.,.F.,,.T.,.F.,"","cNumCab",,)
oHoraRec   := TGet():New( 050,392,{|u| If(PCount()>0,cHoraRec:=u,cHoraRec)},oGrp7,016,008,'@E 99:99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cHoraRec",,)
oDtRec     := TGet():New( 050,353,{|u| If(PCount()>0,dDtRec:=u,dDtRec)},oGrp7,032,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","dDtRec",,)
oGet23     := TGet():New( 050,143,{|u| If(PCount()>0,cNumCompP:=u,cNumCompP)},oGrp7,057,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"Numero do processo",,,.F.,.F.,,.T.,.F.,"","cNumCompP",,)
oGet1      := TGet():New( 050,204,{|u| If(PCount()>0,cTpAut:=u,cTpAut)},oGrp7,052,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cTpAut",,)
oGet2      := TGet():New( 050,264,{|u| If(PCount()>0,cTpProc:=u,cTpProc)},oGrp7,080,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cTpProc",,)
oGet24     := TGet():New( 068,008,{|u| If(PCount()>0,cAssAud:=u,cAssAud)},oGrp7,396,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cAssAud",,)

oGrp8      := TGroup():New( 000,244,028,304,"Status Audienc.",oDlg2,CLR_BLACK,CLR_WHITE,.T.,.F. )
oCBox1     := TComboBox():New( 014,248,{|u| If(PCount()>0,nStAud:=u,nStAud)},{"Agendada","Suspensa","Redesignada"},052,010,oGrp8,,,,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,,nStAud )

If nopc411n == 2    

   if !empty(dDtFim)  .and. dDtFim < dDtAtu  
      MsgAlert("Prazo Vencido , Não é Possivel Alterar ou apagar lançamento !!! ","Atencao!")      
    //  oBtn3411:Disable()
      oBtn5411:Disable()   
   else        

      oBtn5411:enable()

   EndIf   

   fConsulCC(cCcEnv1,1)
   fConsulCC(cCcEnv2,2)
   fConsulCC(cCcEnv3,3)
   fConsulCC(cCcEnv4,4)
   
   oDtDist:Disable() 
   oGet17:Disable() 
   oGet19:Disable() 
   oGet18:Disable()
   
   If nopc411n == 3
   
  //    oBtn3411:Disable()
      oBtn5411:Disable()    
   
   EndIf    

EndIf      
     
oDlg2:Activate(,,,.T.)  
          
Return    
        
static function fMPBWVar()                                       
                              
local ret       := 0
local cAliastmp := GetNextAlias()  
local cQuery    := " "   

cQuery := "select PBW_NUMPRO , PBW_PROCES , PBW_NUMCOM , PBW_TPAUTO , PBW_TPACAO , PBW_DTRECB , PBW_HRRECB , PBW_ASSPRO "
cQuery += CRLF+ " from  " + RetSqlName("PBW") +" PBW "
cQuery += CRLF+ " where PBW_filial = '"+xFilial('PBW')+ "' and PBW.d_E_L_E_T_ = ' ' "  
cQuery += CRLF+ " and PBW_NUMPRO = "+ str(cNCab411,6,0) +"  and  PBW_PROCES ='"+cNproc411+"' and  PBW_NUMCOM ='"+cNCompP411+"' "    

If Select((cAliastmp)) <> 0 
   (cAliastmp)->(DbCloseArea())  
Endif                          

TCQuery cQuery New Alias (cAliastmp)   

(cAliastmp)->( DbGoTop() )     
	

cNumCab  := (cAliastmp)->PBW_NUMPRO 
cNumproc := (cAliastmp)->PBW_PROCES 
cNumCompP:= (cAliastmp)->PBW_NUMCOM 
cTpAut   := (cAliastmp)->PBW_TPAUTO 
cTpProc  := (cAliastmp)->PBW_TPACAO 
dDtRec   := (cAliastmp)->PBW_DTRECB 
cHoraRec := (cAliastmp)->PBW_HRRECB 
cAssAud  := (cAliastmp)->PBW_ASSPRO             

(cAliastmp)->(DbCloseArea())                                

Return()           

static function fMArqVar()

 cIdPrazo  := PBX_IDACPR
 
 cNumCab   := PBX_NUMPRO     
 
 cNumproc  := PBX_PROCES     
 cNumCompP := PBX_NUMCOM
 dDtInc    := PBX_DTINCP
 cHoraInc  := PBX_HRINCP
 dDtFim    := PBX_DTFIMP
 cHoraFim  := PBX_HRFIMP
 nMotass   := PBX_ASSPRO
 nTpEnv1   := PBX_TPSMT1
 nTpEnv2   := PBX_TPSMT2
 nTpEnv3   := PBX_TPSMT3
 nTpEnv4   := PBX_TPSMT4
 cNomeEnv1 := PBX_NMPMT1
 cNomeEnv2 := PBX_NMPMT2
 cNomeEnv3 := PBX_NMPMT3
 cNomeEnv4 := PBX_NMPMT4
 cEmailenv1:= PBX_EMLMT1
 cEmailenv2:= PBX_EMLMT2
 cEmailenv3:= PBX_EMLMT3
 cEmailenv4:= PBX_EMLMT4
 cCcEnv1   := PBX_CCTMP1
 cCcEnv2   := PBX_CCTMP2
 cCcEnv3   := PBX_CCTMP3
 cCcEnv4   := PBX_CCTMP4
 lEmail1   := PBX_EMCCT1
 lEmail2   := PBX_EMCCT2
 lEmail3   := PBX_EMCCT3
 lEmail4   := PBX_EMCCT4
 cmObsPrazo:= PBX_OBSACP

nStAud     := PBX_STAUD

Return()   

static function fMVarArq()

PBX_IDACPR := cIdPrazo  
PBX_NUMPRO := cNCab411      
PBX_PROCES := cNproc411  
PBX_NUMCOM := cNCompP411 
PBX_DTINCP := dDtInc    
PBX_HRINCP := cHoraInc  
PBX_DTFIMP := dDtFim    
PBX_HRFIMP := cHoraFim  
PBX_ASSPRO := nMotass   
PBX_TPSMT1 := nTpEnv1   
PBX_TPSMT2 := nTpEnv2   
PBX_TPSMT3 := nTpEnv3   
PBX_TPSMT4 := nTpEnv4   
PBX_NMPMT1 := cNomeEnv1 
PBX_NMPMT2 := cNomeEnv2 
PBX_NMPMT3 := cNomeEnv3 
PBX_NMPMT4 := cNomeEnv4 
PBX_EMLMT1 := cEmailenv1
PBX_EMLMT2 := cEmailenv2
PBX_EMLMT3 := cEmailenv3
PBX_EMLMT4 := cEmailenv4
PBX_CCTMP1 := cCcEnv1   
PBX_CCTMP2 := cCcEnv2   
PBX_CCTMP3 := cCcEnv3   
PBX_CCTMP4 := cCcEnv4   
PBX_EMCCT1 := lEmail1   
PBX_EMCCT2 := lEmail2   
PBX_EMCCT3 := lEmail3   
PBX_EMCCT4 := lEmail4   
PBX_OBSACP := cmObsPrazo

 PBX_STAUD := nStAud   

Return()        
 
static function fLimpVar()

 cIdPrazo  := 0
 cNumCab   := 0   
 cNumproc  := ' '
 cNumCompP := ' '
 dDtInc    := ' '
 cHoraInc  := ' '
 dDtFim    := ' '
 cHoraFim  := ' '
 nMotass   := ' '
 nTpEnv1   := ' '
 nTpEnv2   := ' '
 nTpEnv3   := ' '
 nTpEnv4   := ' '
 cNomeEnv1 := ' '
 cNomeEnv2 := ' '
 cNomeEnv3 := ' '
 cNomeEnv4 := ' '
 cEmailenv1:= ' '
 cEmailenv2:= ' '
 cEmailenv3:= ' '
 cEmailenv4:= ' '
 cCcEnv1   := ' '
 cCcEnv2   := ' '
 cCcEnv3   := ' '
 cCcEnv4   := ' '
 lEmail1   := ' '
 lEmail2   := ' '
 lEmail3   := ' '
 lEmail4   := ' '
 cmObsPrazo:= ' '

Return() 

Static Function fMarcEm(cEmail , Num)
        if Num == 1 .and.  cEmail != ' '    
           lEmail1:= .T.    
        elseif Num == 2 .and. cEmail != ' '    
           lEmail2:= .T.    
        elseif Num == 3 .and. cEmail != ' '    
           lEmail3:= .T.    
        elseif Num == 4 .and. cEmail != ' '    
           lEmail4:= .T.    
        elseif Num == 5 .and. cEmail != ' '    
           lEmail5:= .T.                                                    
        EndIf   
Return()

Static Function fConsulCC(cCC, Num)

local lRet := .T.              
local _cCcDesc1 := ' '
If !Empty(cCC)   
	dbselectarea("CTT")
	dbsetorder(1)
    If dbseek(xFilial("CTT")+cCC)
        if Num == 1
           cCcDesc1:= ctt_desc01   
           lEmail1:= .T.    
            If empty(trim(cEmailenv1))
               cEmailenv1:= trim(LOWER(CTT_EMAIL))
            EndIf   
        elseif Num == 2
           cCcDesc2:=ctt_desc01               
           lEmail2:= .T.
           If empty(trim(cEmailenv2))
              cEmailenv2:= trim(LOWER(CTT_EMAIL))
           EndIf       
        elseif Num == 3
           cCcDesc3:=ctt_desc01                           
           lEmail3:= .T.    
           If empty(trim(cEmailenv3))
              cEmailenv3:=trim(LOWER(CTT_EMAIL))
           EndIf       
        elseif Num == 4
           cCcDesc4:=ctt_desc01                          
           lEmail4:= .T.    
           If empty(trim(cEmailenv4))
              cEmailenv4:= trim(LOWER(CTT_EMAIL))
           EndIf                  
        elseif Num == 5
           cCcDesc5:=ctt_desc01
           lEmail5:= .T.
           If empty(trim(cEmailenv5))
              cEmailenv5:= trim(LOWER(CTT_EMAIL))
           EndIf                                                                      
        EndIf   
  	else           
  	   If Num == 1
          cCcDesc01:=  ' ' 
       ElseIf Num == 2   
          cCcDesc02:=  ' '
       ElseIf Num == 3       
          cCcDesc03:=  ' '  
       ElseIf Num == 4   
          cCcDesc04:=  ' '
       ElseIf Num == 5      
          cCcDesc05:=  ' '  
       EndIf    
    EndIF   
        
EndIf

Return(substr(ctt->CTT_CUSTO,1,6))      

Static Function fValDt( cSeq	)

local ret:= .F.

If cSeq = 1 

   if empty(dDtInc)
      MsgAlert("Data de Inicial em Branco !!! ","Atencao!")
      ret:= .T.
   Elseif PBW->PBW_DTRECB >= dDtInc
      MsgAlert("Data de Inicial MENOR que Data de Recebimento do processo !!! ","Atencao!")  
      ret:= .T.
   EndIf

Else

   If dDtInc > dDtFim    
      MsgAlert("Data de Inicial MAIOR que Data fIM !!! ","Atencao!")  
      ret:= .T.
   ElseIf empty(dDtFim)
      MsgAlert("Data de Final em Branco !!! ","Atencao!")
      ret:= .T.               
   EndIf    
      
EndIf

If ret 
   odtdist:setfocus()
EndIf

Return()         

Static Function fGrava()
		dbselectarea("PBX")
		PBX->(DbSetOrder(1))   
	    dbSeek(xFilial("PBX")+str(cIdPrazo,6,0)+str(cNumCab,6,0)+cNumproc+cNumComPr)         
	    
	    fMonEmail(nopc411n)

         If nopc411n == 2 

            RecLock("PBX",.F.)     
	        fMVarArq()
	        Msunlock("PBX")   

	        oDlg2:End() 
         else 	                   
	        RecLock("PBX",.T.)     
            fMVarArq()
	   	    Msunlock("PBX")  
   
	   	    oDlg2:End()                                       
  	     EndIf 	              
  	     
  	     
           
return() 


Static Function fPrNPbx()
local ret        := 0
local cAliastmp  := GetNextAlias()  
Private cQuery   := " "   

cQuery := "select nvl(max(PBX_IDACPR), 0 ) NUMMAX "
cQuery += CRLF+ " from  " + RetSqlName("PBX") +" PBX "
cQuery += CRLF+ " where PBX_filial = '"+xFilial('PBX')+ "' and PBX.d_E_L_E_T_ = ' ' " 
cQuery += CRLF+ " and PBX_NUMPRO = "+ str(cNCab411,6,0) +"  and  PBX_PROCES ='"+cNproc411+"' and  PBX_NUMCOM ='"+cNCompP411+"' "        

If Select((cAliastmp)) <> 0 
   (cAliastmp)->(DbCloseArea())  
Endif                          

TCQuery cQuery New Alias (cAliastmp)   

    (cAliastmp)->( DbGoTop() )  
     ret:= ((cAliastmp)->NUMMAX+1)
	(cAliastmp)->(DbCloseArea())
			
Return( ret )     

Static Function fDeleta()   

local cMensagem := ' ' 

If dDtAtu > dDtFim .and. !empty(dDtFim)
   cMensagem := "Lançamento com Data Limite Já Ultrapassada ,  Deseja excluir o Registro mesmo Assim ?."
Else 
   cMensagem:= "Deseja excluir o Registro. Deseja excluir"
EndIf   
 //      If ApMsgYesNo("Deseja excluir o Registro. Deseja excluir","SIMNAO")    
       If ApMsgYesNo(cMensagem,"SIMNAO")   
           
          MsgAlert("Prazo/Audiencia APAGADO com Sucesso  !!! - Email Informando Exclução sera Emitido","Atençao!")    
     	   
     //     fEnmail("DEL")
     
      //      fMonEmail(3)   
           
          PBX->(RecLock("PBX",.F.))
          PBX->(DbDelete())
          PBX->(MsUnlock())   
    	   
          oDlg2:End()                  
       EndIf
 Return()       
 
/*--------------------------------------------------------*/ 

static function fMonEmail(opc)

 local cDest := ' '  
 Local _cMensagem := ""                                                   
 local ccCC := '' 
 private aDados:= {}
 /*                  
 If susbtr(cTpProc,1,3) == 'ANS
    ccCC := '' 
 EndIf    
  */
    if (!empty(trim(cEmailenv1)))
        cDest += alltrim(cEmailenv1)+','     
        // aAdd(aDados,{cDest})  
    EndIf 
    if (!empty(trim(cEmailenv2)))
        cDest += alltrim(cEmailenv2)+','  
        // aAdd(aDados,{cDest}) 
    EndIf  
    if (!empty(trim(cEmailenv3)))
        cDest += alltrim(cEmailenv3)+','  
        // aAdd(aDados,{cDest}) 
    EndIf 
    if (!empty(trim(cEmailenv4)))
        cDest += alltrim(cEmailenv4)+',' 
       //  aAdd(aDados,{cDest})  
    EndIf                               
    
    aDados1 := separa(cDest,',',.T.)     
    for ind1:=1 to len(adados1)     
        If !empty(adados1[ind1])
            aAdd(aDados,{adados1[ind1]}) 
        EndIf
    Next         
     
      // Replace(adados1[ind1],'$$','ANS')
       
 if substr(cTpProc,1,3) == 'ANS'       

    If nMotass == 'Subsídios'  

// equipe do  regulatorio 
    
       aAdd(aDados,{"paulacorrea.juridico@caberj.com.br"}) 
       aAdd(aDados,{"paulahees.juridico@caberj.com.br"}) 
       aAdd(aDados,{"luanna.maquieira@caberj.com.br"}) 
       aAdd(aDados,{"fabiola.silva@caberj.com.br"}) 
       aAdd(aDados,{"clarissa.santos@caberj.com.br"})
     
       If cCcEnv1 == '430001' .or. cCcEnv2 == '430001' .or. cCcEnv3 == '430001' .or. cCcEnv4 == '430001'  //DIRETORIA ADJUNTA COMERCIAL                
          aAdd(aDados,{"darem.ans@caberj.com.br"})      
       EndIf     
       If cCcEnv1 == '510001' .or. cCcEnv2 == '510001' .or. cCcEnv3 == '510001' .or. cCcEnv4 == '510001'  //DIRETORIA ADJUNTA operações                 
          aAdd(aDados,{"daope.ans@caberj.com.br"})      
       EndIf     
       If cCcEnv1 == '410001' .or. cCcEnv2 == '410001' .or. cCcEnv3 == '410001' .or. cCcEnv4 == '410001'  //DIRETORIA ADJUNTA tecnica                  
          aAdd(aDados,{"datec.ans@caberj.com.br"})      
       EndIf            
       If cCcEnv1 == '420001' .or. cCcEnv2 == '420001' .or. cCcEnv3 == '420001' .or. cCcEnv4 == '420001'  //DIRETORIA ADJUNTA previ                 
          aAdd(aDados,{"daprev.ans@caberj.com.br"})      
       EndIf    
       
       
       for I:=1 to len(aDados) 
                                       
           u_EnvEmail1( fBcoEmail( 1 , opc) , adados[I,1] , cAssunto, ' ' )
      
       Next
    
    EndIF 
 Endif        
 
 If (substr(cTpProc,1,4) $ "ALER|DECO|MINI|PROC|RECE|ACAO|EXEC")
//ElseIf cTpProc $ "ALERJ|DECON|MINISTERIO PUBLICO|PROCESSO CIVEL|PROCESSO CRIMINAL|PROCESSO TRABALHISTA|PROCESSO TRIBUTARIO|PROCON|RECEITA FEDERAL|ACAO ANULATORIA|EXECUCAO FISCAL"
              
   If Substr(nMotass,1,4) $ 'Subs|Peri|Audi'    
       
      If !empty(nTpEnv1) .and. Substr(nTpEnv1,1,4) $ 'Prep|Test|Assi|Subs'
          
      // equipe do juridico judicial 
        aAdd(aDados,{"fabio.vianna@caberj.com.br"})
        aAdd(aDados,{"fabiola.silva@caberj.com.br"})  
      //  aAdd(aDados,{"altamiro@caberj.com.br"})  
      // aAdd(aDados,{"hugo.paiva@caberj.com.br"})  
      // dr. jose paulo onão contemplado por orientação.        
  
      // If  substr(cTpProc,1,14) == 'PROCESSO TRABA' 
      // // equipe da consultrab
      
      //    aAdd(aDados,{"rodrigo.pessoa@consultrab.com.br"})
      //    aAdd(aDados,{"ricardo@consultrab.com.br"}) 
      //    aAdd(aDados,{"guilherme.kling@consultrab.com.br"}) 
      //    aAdd(aDados,{"protocolo@consultrab.com.br"})  
         
      // ElseIf cempant == '01'
      // // equipe do juridico maquieira 
      
      //    aAdd(aDados,{"luizfelipe@maquieira.adv.br"}) 
      //    aAdd(aDados,{"reaias@maquieira.adv.br"}) 
      //    aAdd(aDados,{"newton@maquieira.adv.br"})    
      //    aAdd(aDados,{"michelle@maquieira.adv.br"}) 
      //    aAdd(aDados,{"ricardo@maquieira.adv.br"})    
      
      // Else 
      // // equipe van  erven 
         
      //    aAdd(aDados,{"area.medica@vscadvogados.com.br"})
      //    aAdd(aDados,{"conrado@vscadvogados.com.br"})
      //    aAdd(aDados,{"josefina.martins@vscadvogados.com.br"})
      //    aAdd(aDados,{"rodrigo.bastos@vscadvogados.com.br"})
      
      // Endif
    
 
       If cCcEnv1 == '430001' .or. cCcEnv2 == '430001' .or. cCcEnv3 == '430001' .or. cCcEnv4 == '430001'  //DIRETORIA ADJUNTA COMERCIAL                
          aAdd(aDados,{"darem.judicial@caberj.com.br"})      
       EndIf     
       If cCcEnv1 == '510001' .or. cCcEnv2 == '510001' .or. cCcEnv3 == '510001' .or. cCcEnv4 == '510001'  //DIRETORIA ADJUNTA operações                 
          aAdd(aDados,{"daope.judicial@caberj.com.br"})      
       EndIf     
       If cCcEnv1 == '410001' .or. cCcEnv2 == '410001' .or. cCcEnv3 == '410001' .or. cCcEnv4 == '410001'  //DIRETORIA ADJUNTA tecnica                  
          aAdd(aDados,{"datec.judicial@caberj.com.br"})      
       EndIf            
       If cCcEnv1 == '420001' .or. cCcEnv2 == '420001' .or. cCcEnv3 == '420001' .or. cCcEnv4 == '420001'  //DIRETORIA ADJUNTA previ                 
          aAdd(aDados,{"daprev.judicial@caberj.com.br"})      
       EndIf    
       
     If len(aDados) > 0
       for I:=1 to len(aDados) 
                                       
           u_EnvEmail1( fBcoEmailJ( 1 , opc) , adados[I,1] , cAssunto, ' ' )
      
       Next       
     EndIf     
    EndIf 
    
   EndIf    

EndIf  

Return()     

STATIC FUNCTION fBcoEmail( NUM, nOpc ) // REGULATORIO - ANS      

 Local _cMensagem := ""  
 local cEmCopia   := ' '  

If NUM == 1                        

    cAssunto  := "Solicitação de Subsídios "
    
    If nOpc == 2                            
    
       cAssunto  += " - Reenvio por alteração " 
    
    Else  //If nOpc == 3                            
    
       cAssunto  += " " //- Reenvio por deleção "    
    
    EndIf    

//   _cMensagem +=  Chr(13) + Chr(10) +  " Encaminhamos a/o  "+trim(cTpProc)+"  nº "+ str(cNumCab,6,0)  + ' - ' + cNumproc  + ' - ' + cNumComPr    
   _cMensagem +=  Chr(13) + Chr(10) +  " Encaminhamos a/o  "+trim(cTpProc)+"  nº "  + cNumproc  + ' - ' + cNumComPr       
   _cMensagem +=  Chr(13) + Chr(10) +  Chr(13) + Chr(10)+ "Prezados ,  "    
   _cMensagem +=  Chr(13) + Chr(10) +  "Informamos que o processo acima identificado foi recebido  na data de "+ substr(dDtRec,7,2)+"/"+ substr(dDtRec,5,2)+"/"+ substr(dDtRec,1,4)+"."
   _cMensagem +=  Chr(13) + Chr(10) +  " O arquivo em PDF do processo está disponível em G:\PROCESSOSDOJURIDICO\Jurídico - ANS. "
    

   _cMensagem +=  Chr(13) + Chr(10) + Chr(13) + Chr(10)+ " Assunto: " + cAssAud    
   _cMensagem +=  Chr(13) + Chr(10) + Chr(13) + Chr(10)+ " Teor: "

   _cMensagem +=  Chr(13) + Chr(10) + '"'      
   _cMensagem +=  Chr(13) + Chr(10) + u_FMntEmail(2) //_cMenspro
   _cMensagem +=  Chr(13) + Chr(10) + '"'                                                   
   _cMensagem +=  Chr(13) + Chr(10) + Chr(13) + Chr(10)+ " Tendo como Autor o , " + nTpAutor+": "       
   _cMensagem +=  Chr(13) + Chr(10) + u_FMntEmail(1)  
   
   _cMensagem +=  Chr(13) + Chr(10) + Chr(13) + Chr(10)+ " Nesse sentido , solicito os seguintes subsídios : " 
   _cMensagem +=  Chr(13) + Chr(10) + Chr(13) + Chr(10)+ cmObsPrazo    
   
   
   _cMensagem +=  Chr(13) + Chr(10) + Chr(13) + Chr(10) + Chr(13) + Chr(10) +  " Os subsídios devem ser disponibilizados em PDF no diretório G:\PROCESSOSDOJURIDICO,"
   _cMensagem +=  Chr(13) + Chr(10) +  " na pasta da respectiva diretoria, Subsídios ANS "             

   _cMensagem +=  Chr(13) + Chr(10) + Chr(13) + Chr(10) +  "<b> Prazo para retorno dos subsídios : </b>" +  substr(dtos(dDtFim) ,7,2)+"/"+ substr(dtos(dDtFim) ,5,2)+"/"+ substr(dtos(dDtFim) ,1,4)+"."              
   
   
   for Ind := 1 to len(adados) 
       cEmCopia+= adados[Ind,1] +' , '
   next 
       
   _cMensagem +=  Chr(13) + Chr(10) + Chr(13) + Chr(10)+ 'Ps.: Em Copia :' + cEmCopia      
   
   _cMensagem +=  Chr(10) + Chr(13) + Chr(10) + Chr(13)+ Chr(10) + Chr(13) + Chr(10) + Chr(13)+"                    Rio de Janeiro , " +  DtoC( Date() ) 
   
     

EndIf 
 
 return(_cMensagem)
 
 
 /*--------------------------------------------------*/ 
 
STATIC FUNCTION fBcoEmailJ( NUM, nOpc ) // JUDICIAL       

 Local _cMensagem := ""  
 local cEmCopia   := ' '  
 local cNsent     := ' ' 

If NUM == 1                        

   for Ind := 1 to len(adados) 
       cEmCopia+= adados[Ind,1] +' , '
   next


   If Substr(nTpEnv1,1,4) == 'Subs'    
      cAssunto  := "Solicitação de Subsídios "
      cNsent    := 'Nesse sentido , solicito os seguintes subsídios : '


//   _cMensagem +=  Chr(13) + Chr(10) +  " Encaminhamos a/o  "+trim(cTpProc)+"  nº "+ str(cNumCab,6,0)  + ' - ' + cNumproc  + ' - ' + cNumComPr    
   _cMensagem +=  Chr(13) + Chr(10) +  " Encaminhamos a/o  "+trim(cTpProc)+"  nº "  + cNumproc  + ' - ' + cNumComPr       
   _cMensagem +=  Chr(13) + Chr(10) +  Chr(13) + Chr(10)+ "Prezados ,  "    
   _cMensagem +=  Chr(13) + Chr(10) +  "Informamos que o processo acima identificado foi recebido  na data de "+ substr(dDtRec,7,2)+"/"+ substr(dDtRec,5,2)+"/"+ substr(dDtRec,1,4)+"."
   _cMensagem +=  Chr(13) + Chr(10) +  " O arquivo em PDF do processo está disponível em G:\PROCESSOSDOJURIDICO\Jurídico - JUDICIAL. "
    
   _cMensagem +=  Chr(13) + Chr(10) + Chr(13) + Chr(10)+ " Assunto: " + cAssAud    
   _cMensagem +=  Chr(13) + Chr(10) + Chr(13) + Chr(10)+ " Teor: "

   _cMensagem +=  Chr(13) + Chr(10) + '"'      
   _cMensagem +=  Chr(13) + Chr(10) + u_FMntEmail(2) //_cMenspro
   _cMensagem +=  Chr(13) + Chr(10) + '"'                                                   
   _cMensagem +=  Chr(13) + Chr(10) + Chr(13) + Chr(10)+ " Tendo como Autor o , " + nTpAutor+": "       
   _cMensagem +=  Chr(13) + Chr(10) + u_FMntEmail(1)  
   
   _cMensagem +=  Chr(13) + Chr(10) + Chr(13) + Chr(10)+ cNsent  //" Nesse sentido , solicito os seguintes subsídios : " 
   _cMensagem +=  Chr(13) + Chr(10) + Chr(13) + Chr(10)+ cmObsPrazo    
   
   
   _cMensagem +=  Chr(13) + Chr(10) + Chr(13) + Chr(10) + Chr(13) + Chr(10) +  " Os subsídios devem ser disponibilizados em PDF no diretório G:\PROCESSOSDOJURIDICO,"
   _cMensagem +=  Chr(13) + Chr(10) +  " na pasta da respectiva diretoria, Subsídios JUDICIAL"             

   _cMensagem +=  Chr(13) + Chr(10) + Chr(13) + Chr(10) +  "<b> Prazo para retorno dos subsídios : </b>" +  substr(dtos(dDtFim) ,7,2)+"/"+ substr(dtos(dDtFim) ,5,2)+"/"+ substr(dtos(dDtFim) ,1,4)+"."              
   
/*   for Ind := 1 to len(adados) 
       cEmCopia+= adados[Ind,1] +' , '
   next 
  */     
   _cMensagem +=  Chr(13) + Chr(10) + Chr(13) + Chr(10)+ 'Ps.: Em Copia :' + cEmCopia      
   
   _cMensagem +=  Chr(10) + Chr(13) + Chr(10) + Chr(13)+ Chr(10) + Chr(13) + Chr(10) + Chr(13)+"                    Rio de Janeiro , " +  DtoC( Date() ) 
   
  ElseIf Substr(nTpEnv1,1,4) == 'Test'
    cAssunto  := "Solicitação de Testemunha "
    cNsent    := Chr(13) + Chr(10) +  Chr(13) + Chr(10)+ "Prezados ,  "   
    cNsent    += Chr(13) + Chr(10) +  Chr(13) + Chr(10)+ ' Comunicamos que a Audiencia do processo '+trim(cTpProc)+'  nº  ' + cNumproc  + ' - ' + cNumComPr +', será realizada em '+ substr(dDtRec,7,2)+'/'+ substr(dDtRec,5,2)+'/'+ substr(dDtRec,1,4)+', as '+ transform(cHoraInc,"@E 99:99") + ' Horas .'
    cNsent    += Chr(13) + Chr(10) +  'Solicitamos a indicação de Testemunha em ate 48 horas' 

   _cMensagem := cNsent  
   _cMensagem +=  Chr(13) + Chr(10) + Chr(13) + Chr(10)+ cmObsPrazo   
   _cMensagem +=  Chr(13) + Chr(10) + Chr(13) + Chr(10)+ 'Ps.: Em Copia :' + cEmCopia      
   _cMensagem +=  Chr(10) + Chr(13) + Chr(10) + Chr(13)+ Chr(10) + Chr(13) + Chr(10) + Chr(13)+"                    Rio de Janeiro , " +  DtoC( Date() ) 
       
  ElseIf Substr(nTpEnv1,1,4) == 'Assi' 
    cAssunto  := "Solicitação de Assist. Tecnico "

    cNsent    :=  Chr(13) + Chr(10) +  Chr(13) + Chr(10)+ "Prezados ,  "   
    If Substr(nMotass,1,4) == 'Peri' 
       cNsent    +=Chr(13) + Chr(10) +  Chr(13) + Chr(10)+' Comunicamos que a Pericia do processo '+trim(cTpProc)+'  nº  ' + cNumproc  + ' - ' + cNumComPr +', será realizada em '+ substr(dDtRec,7,2)+'/'+ substr(dDtRec,5,2)+'/'+ substr(dDtRec,1,4)+', as '+ transform(cHoraInc,"@E 99:99") + ' Horas .'
    else    
       cNsent    += Chr(13) + Chr(10) +  Chr(13) + Chr(10)+' Comunicamos que a Audiencia do processo '+trim(cTpProc)+'  nº  ' + cNumproc  + ' - ' + cNumComPr +', será realizada em '+ substr(dDtRec,7,2)+'/'+ substr(dDtRec,5,2)+'/'+ substr(dDtRec,1,4)+', as '+ transform(cHoraInc,"@E 99:99") + ' Horas .'
    EndIf  
       cNsent    += Chr(13) + Chr(10) +  'Solicitamos a indicação de Assist. Tecnico em ate 48 horas' 
     
     _cMensagem := cNsent  
     _cMensagem +=  Chr(13) + Chr(10) + Chr(13) + Chr(10)+ cmObsPrazo    
     _cMensagem +=  Chr(13) + Chr(10) + Chr(13) + Chr(10)+ 'Ps.: Em Copia :' + cEmCopia      
     _cMensagem +=  Chr(10) + Chr(13) + Chr(10) + Chr(13)+ Chr(10) + Chr(13) + Chr(10) + Chr(13)+"                    Rio de Janeiro , " +  DtoC( Date() ) 
   
  ElseIf Substr(nTpEnv1,1,4) == 'Prep'
    cAssunto  := "Solicitação de Preposto  "
    
    cNsent    := Chr(13) + Chr(10) +  Chr(13) + Chr(10)+ "Prezados ,  "   
    cNsent    += Chr(13) + Chr(10) +  Chr(13) + Chr(10)+' Comunicamos que a Audiencia do processo '+trim(cTpProc)+'  nº  ' + cNumproc  + ' - ' + cNumComPr +', será realizada em '+ substr(dtos(dDtInc),7,2)+'/'+ substr(dtos(dDtInc),5,2)+'/'+ substr(dtos(dDtInc),1,4)+', as '+ transform(cHoraInc,"@E 99:99") + ' Horas .'
    cNsent    += Chr(13) + Chr(10) +  'Solicitamos a indicação de Preposto  em ate 48 horas' 

    _cMensagem := cNsent  
    _cMensagem +=  Chr(13) + Chr(10) + Chr(13) + Chr(10)+ cmObsPrazo    
    _cMensagem +=  Chr(13) + Chr(10) + Chr(13) + Chr(10)+ 'Ps.: Em Copia :' + cEmCopia      
    _cMensagem +=  Chr(10) + Chr(13) + Chr(10) + Chr(13)+ Chr(10) + Chr(13) + Chr(10) + Chr(13)+"                    Rio de Janeiro , " +  DtoC( Date() ) 
   
  EndIF     
    If nOpc == 2                            
    
       cAssunto  += " - Reenvio por alteração " 
    
    Else  //If nOpc == 3                            
    
       cAssunto  += " " //- Reenvio por deleção "    
    
    EndIf   
    
   
     
EndIf 
 
 return(_cMensagem)

 
 
/*--------------------------------------------------*/ 
/*
*--------------------------------------*
 user Function EnvMmens( _cMensagem , cDest  , cAssunto )
*--------------------------------------*                                           

return()


// redesenho da tela inicial 
/*
oGrp4      := TGroup():New( 000,148,028,300,"Prazos",oDlg1,CLR_BLACK,CLR_WHITE,.T.,.F. )
oSay5      := TSay():New( 004,180,{||"Início"},oGrp4,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,016,008)
oSay34     := TSay():New( 007,156,{||"Data"},oGrp4,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,016,008)
oSay35     := TSay():New( 024,422,{||"Hora"},oGrp4,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,018,008)
oSay7      := TSay():New( 007,200,{||"Hora"},oGrp4,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,020,008)
oSay9      := TSay():New( 004,256,{||"Fim "},oGrp4,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,020,008)
oSay14     := TSay():New( 007,277,{||"Hora"},oGrp4,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,020,008)
oSay15     := TSay():New( 007,237,{||"Data"},oGrp4,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,016,008)
oDtDist    := TGet():New( 014,156,{|u| If(PCount()>0,dDtInc:=u,dDtInc)},oGrp4,032,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","dDtInc",,)
oGet17     := TGet():New( 014,200,{|u| If(PCount()>0,cHoraInc:=u,cHoraInc)},oGrp4,024,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cHoraInc",,)
oGet18     := TGet():New( 014,273,{|u| If(PCount()>0,cHoraFim:=u,cHoraFim)},oGrp4,024,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cHoraFim",,)
oGet19     := TGet():New( 014,233,{|u| If(PCount()>0,dDtFim:=u,dDtFim)},oGrp4,032,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","dDtFim",,)
oGrp5      := TGroup():New( 000,004,028,144,"Identificação ",oDlg1,CLR_BLACK,CLR_WHITE,.T.,.F. )
oSay1      := TSay():New( 004,080,{||"Tipo "},oGrp5,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oGet20     := TGet():New( 012,008,{|u| If(PCount()>0,cIdPrazo:=u,cIdPrazo)},oGrp5,060,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cIdPrazo",,)
oCBox1     := TComboBox():New( 012,080,,{"&Audiencia","&Prazo","&Acompanhamento"},060,010,oGrp5,,,,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,, )
oGrp6      := TGroup():New( 000,304,028,416,"Controles",oDlg1,CLR_BLACK,CLR_WHITE,.T.,.F. )
oBtn3      := TButton():New( 010,308,"Grava",oGrp6,{||fgrava()},032,012,,,,.T.,,"",,,,.F. )
oBtn5      := TButton():New( 010,344,"Deleta",oGrp6,{||fDeleta()},032,012,,,,.T.,,"",,,,.F. )
oBtn6      := TButton():New( 010,380,"Sair",oGrp6,{||oDlg2:End()},032,012,,,,.T.,,"",,,,.F. )
           
*/

