#include "PROTHEUS.CH" 
#Include 'PLSMGER.CH'
#include "PLSMGER2.CH"
#include "PLSMCCR.CH"  
#include "topconn.ch"
#INCLUDE "TOTVS.CH"
#INCLUDE "rwmake.ch"
#include "SIGAWIN.CH"
#Include "Ap5Mail.Ch"  
#INCLUDE 'FONT.CH'
#INCLUDE 'COLORS.CH'

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABA633   ºAutor  ³ Altamiro	         º Data ³  19/06/2015 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Tela de browser do cadastro de reserva                     º±±
±±º          ³ 															  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function caba633(cOrigem)
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Monta matriz com as opcoes do browse...                             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	PRIVATE aRotina	:=	{	{ "&Visualizar"	, "U_Caba633I"    , 0 , 1	 },;
		                    { "&Alteracao"	, "U_Caba633I"	, 0 , 2  },;
		                    { "&Incluir"	, "U_Caba633I"		, 0 , 3	 },;
		                    { "Legenda"		, "U_LPRO633A"	    , 0 , 3	 }}
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Titulo e variavies para indicar o status do arquivo                 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	PRIVATE cCadastro	:= "Browser de Controle do Cadastro de Reserva"
	
	PRIVATE aCdCores	:= { 	{ 'BR_VERDE'    ,'Reservado '        },;
	                            { 'BR_AMARELO'  ,'Prorrogado'        },;
		                        { 'BR_VERMELHO' ,'Declinado '        },;
	                            { 'BR_AZUL'     ,'Contratada'        },;
								{ 'BR_PRETO'    ,'Vencida'           }}
	
	PRIVATE aCores	:= {{'PEX_STATUS=="Reservado"' , aCdCores[1,1]},;
		                {'PEX_STATUS=="Prorrogado"', aCdCores[2,1]},;
	                    {'PEX_STATUS=="Declinado"' , aCdCores[3,1]},;
		                {'PEX_STATUS=="Contratada"', aCdCores[4,1]},;
						{'PEX_STATUS=="Vencida"'   , aCdCores[5,1]}}
	//PRIVATE cPath  := ""
	PRIVATE cAlias := "PEX"
	
	private adadostab := {}
	
	private  lfaz     := .F.
	private  aDados   := {}
	private  aDados1  := {}

	private  cCompt1  := ' '
	
	private  nOorigem := cOrigem

    PRIVATE cAliasPexT := GetNextAlias()
	
	PRIVATE cAliasCEmp := GetNextAlias()
    PRIVATE cAliasSEmp := GetNextAlias()
    PRIVATE cAliasSAno := GetNextAlias()
	PRIVATE cAliasSMes := GetNextAlias()

    PRIVATE cAliasBEmp := GetNextAlias()

	PRIVATE cAliasPEmp := GetNextAlias()
	
	PRIVATE cAliasTEmp := GetNextAlias()
	private USUAR633   := SubStr(cUSUARIO,7,15)
	private cUser      := RetCodUsr()


	PRIVATE cNomeProg   := "CABA633"
	PRIVATE nQtdLin     := 68
	PRIVATE nLimite     := 132
	PRIVATE cControle   := 15
	PRIVATE cTamanho    := "G"
	PRIVATE cTitulo     := "Cadastro de Reserva"
	PRIVATE cDesc1      := ""
	PRIVATE cDesc2      := ""
	PRIVATE cDesc3      := ""
	PRIVATE nRel        := "caba633"
	PRIVATE nlin        := 100
	PRIVATE nOrdSel     := 1
	PRIVATE m_pa        := 1
	PRIVATE lCompres    := .F.
	PRIVATE lDicion     := .F.
	PRIVATE lFiltro     := .T.
	PRIVATE lCrystal    := .F.
	PRIVATE aOrdens     := {}
	PRIVATE aReturn     := { "", 1,"", 1, 1, 1, "",1 }
	PRIVATE lAbortPrint := .F.
	PRIVATE cCabec1     := "Controle do Cadastro de Reserva"
	PRIVATE cCabec2     := ""
	PRIVATE nColuna     := 00
	
	PRIVATE cAliastmp   := GetNextAlias()    
	PRIVATE cAliasSe1   := GetNextAlias()  
	PRIVATE cAliasBd7   := GetNextAlias()
	PRIVATE cAlstmpsz9  := GetNextAlias()
	privatE lsair       := .F. 
	private lgrava      := .F.

	Private dDateHoje   := DATE()

	private lPriInc     := .F.

	private lexist      := .F.

	private recod2      := 0
	private nopc1       := 0

	private lProrroga   := .F.

	private  cUsuincl   := SuperGetMV("MV_CUSRIN") 
 
	/////////////////////
Private cCnpjCont  := Space(18)  // PEX_CNPJ  
Private cCodCor    := Space(6)   // PEX_CODCOR
Private cCodEmp    := Space(6)   // PEX_CODEMP
Private cCodGest   := Space(6)   // PEX_CODGES
Private cCodVend   := Space(6)   // PEX_CODVEN
Private cContAnter := '  '              
Private cMensObse  := ' '              // PEX_MENSOB
Private cNomCor    := Space(30)  // PEX_NOMCOR 
Private cNomGest   := Space(30)  // PEX_NOMGES
Private cNomVend   := Space(30)  // PEX_NOMVEN
Private cOprAtual  := Space(30)  // PEX_OPRATU 
Private cResAnter 
Private cRSocial   := Space(30)  // PEX_NOMEMP
Private cSeqAno    := Space(6)   // PEX_SEQANO
Private cSeqEmp    := Space(6)   // PEX_SEQEMP
Private cSeqMes    := Space(6)   // PEX_SEQMES
Private cStatus    := Space(20)   // PEX_STATUS
Private dDtFinal   := CtoD(" ")  // PEX_DTFIM 
Private dDtInic    := CtoD(" ")  // PEX_DTINC 
Private dDtProrrog := CtoD(" ")  // PEX_DTPROR 
Private nCarta                   // PEX_CARTA
Private nQtdaAft   := 0          // PEX_QTDAAF
Private nQtdaAtv   := 0          // PEX_QTDAAT

Private dDatUlInc := CtoD(" ")  // PEX_DTULTDAINC 
private cSequen   := Space(6)
                                 // PEX_SEQUEN -- SEQUENCIA PARA X2_UNICO

////

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Starta mBrowse...                                                   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
	±± Declaração de Variaveis Private dos Objetos                             ±±
	Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/
	SetPrvt("oDlg1","oGrp1","oSay1","oSay2","oSay3","oSay7","oSay9","oSay13","oGet1","oGet2","oGet3","oGet4")
	SetPrvt("oGet6","oGet10","oGet12","oGet13","oGet14","oRMenu1","oGrp3","oSay4","oSay5","oSay6","oGet7")
	SetPrvt("oGet9","oGrp4","oBtn1","oBtn2","oBtn3","oBtn8","oBtn20","oBtn4","oBtn17","oBtn30","oBtn31","oGrp6")
	SetPrvt("oSay10","oGet189","oGet24","oGrp2","oMGet2","oGrp5","oMGet3","oGrp7","oBtn7","oGet21","oGrp8")
	SetPrvt("oSay11","oGet26","oGet25","oGrp10","oMGet1","oGrp9","oBtn5","oGet11")
  
  //	U_FCrgPd2(cAlias,nReg,nOpc)
        //fCargtab()

       dbselectarea("PEX")
 	   PEX->(DBSetOrder(1))
        If  cUser $ cUsuincl
		    a:= 'b'
		Else 
            Set Filter to TRIM(PEX->PEX_filial ) == '99'
        EndIf 
	//PBW->(mBrowse(006,001,022,075,"PBW" , , , , , Nil    , aCores, , , ,nil, .T.))
	   
	   PEX->(mBrowse(006,001,022,075,"PEX" , , , , , 2    , aCores, , , ,nil, .F.))
	//mBrowse(6, 1, 22, 75, "PBW",,,,,,aCores)
	   PEX->(DbClearFilter())	
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
USER Function LPRO633A()
	Local aLegenda
	
	aLegenda 	:= { 	{ aCdCores[1,1],aCdCores[1,2] },;
						{ aCdCores[2,1],aCdCores[2,2] },;
						{ aCdCores[3,1],aCdCores[3,2] },;
						{ aCdCores[4,1],aCdCores[4,2] }}
	
	BrwLegenda(cCadastro,"Status" ,aLegenda)
	
Return()

//AxCadastro(cString,"Cadastro de senhas do custo administrado ",cVldExc,cVldAlt)

Return

//user Function Caba138I()
User Function Caba633I(cAlias,nReg,nOpc)
	/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
	±± Declaração de cVariable dos componentes                                 ±±
	Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/
    nopc1 := nOpc 

    If  nOpc == 3
        fLimpVar()
    Else
	    fMArqVar()
    EndIf 
	/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
	±± Definicao do Dialog e todos os seus componentes.                        ±±
	Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/

/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±± Definicao do Dialog e todos os seus componentes.                        ±±
Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/
oDlg1      := MSDialog():New( 104,271,750,1380,"Cadastro de Reserva",,,.F.,,,,,,.T.,,,.T. )
oGrp1      := TGroup():New( 000,004,132,272,"Identificação da Reserva",oDlg1,CLR_BLACK,CLR_WHITE,.T.,.F. )
oSay1      := TSay():New( 032,008,{||"Corretora"},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,028,008)
oSay2      := TSay():New( 072,008,{||"Gestor Int"},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,028,008)
oSay3      := TSay():New( 012,008,{||"Contratante "},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay7      := TSay():New( 112,008,{||"Status "},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,024,008)
oSay9      := TSay():New( 052,008,{||"Vendedor Int"},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay13     := TSay():New( 092,008,{||"Oper.atual"},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,031,008)
oGet5      := TGet():New( 012,048,{|u| If(PCount()>0,cCnpjCont:=u,cCnpjCont)},oGrp1,056,008,'@! !!.!!!.!!!/!!!!-!!',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cCnpjCont",,)
if nopc1 == 3
   oGet5:bLostFocus:={||fVdCnpj(cCnpjCont)} 
EndIf 
oGet6      := TGet():New( 012,108,{|u| If(PCount()>0,cRSocial:=u,cRSocial)},oGrp1,156,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cRSocial",,)

oGet1      := TGet():New( 032,048,{|u| If(PCount()>0,cCodCor:=u,cCodCor)},oGrp1,032,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cCodCor",,)
oGet1:bF3 := &('{|| IIf(ConPad1(,,,"SA31",,,.F.),Eval({||cCodCor:=SA3->A3_COD,cNomCor:=SA3->A3_NOME,oGet1:Refresh(),oGet2:Refresh()}),.T.)}')    
oGet2      := TGet():New( 032,084,{|u| If(PCount()>0,cNomCor:=u,cNomCor)},oGrp1,180,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cNomCor",,)

oGet13     := TGet():New( 053,048,{|u| If(PCount()>0,cCodVend:=u,cCodVend)},oGrp1,032,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cCodVend",,)
//oGet13:bF3 := &('{|| IIf(ConPad1(,,,"SRA",,,.F.),Eval({||cCodVend:=SRA->RA_MAT,cNomVend:=SRA->RA_NOME,oGet13:Refresh(),oGet12:Refresh()}),.T.)}')    
//oGet12     := TGet():New( 053,084,{|u| If(PCount()>0,cNomVend:=u,cNomVend)},oGrp1,180,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cNomVend",,)

oGet4      := TGet():New( 072,048,{|u| If(PCount()>0,cCodGest:=u,cCodGest)},oGrp1,032,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cCodGest",,)
//oGet4:bF3 := &('{|| IIf(ConPad1(,,,"SRA",,,.F.),Eval({||cCodGest:=SRA->RA_MAT,cNomGest:=SRA->RA_NOME,oGet4:Refresh(),oGet3:Refresh()}),.T.)}')    
//oGet3      := TGet():New( 072,084,{|u| If(PCount()>0,cNomGest:=u,cNomGest)},oGrp1,180,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cNomGest",,)	

oGet14     := TGet():New( 089,048,{|u| If(PCount()>0,cOprAtual:=u,cOprAtual)},oGrp1,216,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cOprAtual",,)
oGet10     := TGet():New( 112,048,{|u| If(PCount()>0,cStatus:=u,cStatus)},oGrp1,112,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cStatus",,)

oCBox1     := TComboBox():New( 052,084,{|u| If(PCount()>0,cNomvend:=u,cNomvend)},{" " ,"ALESSANDRA  SIMONE F. DE PAULA","ALINE HENRIQUE ALVES          ","ANDRESSA MAGALHAES DE OLIVEIRA","ANGELICA DANIELE BARROS ","IGOR RIBEIRO GONZALEZ         ","KARLA DANIELLE SILVA BRITO    ","NATHALIA PINNA RODRIGUES      "},180,010,oGrp1,,,,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,,cNomvend )
oCBox2     := TComboBox():New( 072,084,{|u| If(PCount()>0,cNomGest:=u,cNomGest)},{" " ,"EDUARDO HENRIQUE W PIERRO     ","KATIUSCIA JENNIFER DE FREITAS "},180,010,oGrp1,,,,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,,cNomGest )

oGrp3      := TGroup():New( 036,276,092,360,"Vigencia ",oDlg1,CLR_BLACK,CLR_WHITE,.T.,.F. )
oSay4      := TSay():New( 052,280,{||"Dta Inicial "},oGrp3,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,025,008)
oSay5      := TSay():New( 065,280,{||"Dta Final"},oGrp3,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,025,008)
oSay6      := TSay():New( 078,275,{||"Prorrogado "},oGrp3,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,025,008)
if  cUser == '000310'
	oGet7      := TGet():New( 049,304,{|u| If(PCount()>0,dDtInic:=u,dDtInic)},oGrp3,050,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","dDtInic",,)
	oGet8      := TGet():New( 062,304,{|u| If(PCount()>0,dDtFinal:=u,dDtFinal)},oGrp3,050,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","dDtFinal",,)
	oGet9      := TGet():New( 076,304,{|u| If(PCount()>0,dDtProrrog:=u,dDtProrrog)},oGrp3,050,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","dDtProrrog",,)
Else
	oGet7      := TGet():New( 049,304,{|u| If(PCount()>0,dDtInic:=u,dDtInic)},oGrp3,050,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","dDtInic",,)
	oGet8      := TGet():New( 062,304,{|u| If(PCount()>0,dDtFinal:=u,dDtFinal)},oGrp3,050,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","dDtFinal",,)
	oGet9      := TGet():New( 076,304,{|u| If(PCount()>0,dDtProrrog:=u,dDtProrrog)},oGrp3,050,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","dDtProrrog",,)
EndIF 
oGrp4      := TGroup():New( 000,432,092,544,"Controles",oDlg1,CLR_BLACK,CLR_WHITE,.T.,.F. )
oBtn1      := TButton():New( 008,437,"Grava",oGrp4,{||fGrava(), oDlg1:End() },050,012,,,,.T.,,"",,,,.F. )
oBtn2      := TButton():New( 024,490,"Exluir",oGrp4,{||fDelete()},050,012,,,,.T.,,"",,,,.F. )
oBtn3      := TButton():New( 008,490,"Prorroga ",oGrp4,{||fCalcDt(3)},050,012,,,,.T.,,"",,,,.F. )
oBtn8      := TButton():New( 024,437,"Bco Conhecimento",oGrp4,{||fBcoConhec()},050,012,,,,.T.,,"",,,,.F. )
oBtn20     := TButton():New( 076,437,"Sair ",oGrp4,{|| lsair:=.T. , oDlg1:End()},103,012,,,,.T.,,"",,,,.F. )
oBtn4      := TButton():New( 040,437,"Contratada",oGrp4,{||fGrava(4)},050,012,,,,.T.,,"",,,,.F. )
oBtn17     := TButton():New( 040,490,"Parametros",oGrp4,,050,012,,,,.T.,,"",,,,.F. )
oBtn30     := TButton():New( 056,491,"Declinado",oGrp4,{||fGrava(3)},050,012,,,,.T.,,"",,,,.F. )
oBtn31     := TButton():New( 056,438,"Validar ",oGrp4,,050,012,,,,.T.,,"",,,,.F. )
oGrp6      := TGroup():New( 000,276,032,352,"Sequencias - Empresa",oDlg1,CLR_BLACK,CLR_WHITE,.T.,.F. )
oSay8      := TSay():New( 008,280,{||"Cod Emp"},oGrp6,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay10     := TSay():New( 008,318,{||"Seq Emp"},oGrp6,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oGet189    := TGet():New( 017,280,{|u| If(PCount()>0,cCodEmp:=u,cCodEmp)},oGrp6,028,008,'@E 999999',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cCodEmp",,)
oGet24     := TGet():New( 017,318,{|u| If(PCount()>0,cSeqEmp:=u,cSeqEmp)},oGrp6,028,008,'@E 999999',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cSeqEmp",,)

oRMenu1    := TGroup():New( 036,364,092,428,"Carta",oDlg1,CLR_BLACK,CLR_WHITE,.T.,.F. )
oRMenu1    := TRadMenu():New( 040,370,{"Sem Carta","Nomeacao ","Exclusividade"},{|u| If(PCount()>0,nCarta :=u,nCarta )},oDlg1,,,CLR_BLACK,CLR_WHITE,"",,,044,18,,.F.,.F.,.T. )

oGrp2      := TGroup():New( 136,004,232,276,"Historico de Reservas (anteriores)",oDlg1,CLR_BLACK,CLR_WHITE,.T.,.F. )
oMGet2     := TMultiGet():New( 144,008,{|u| If(PCount()>0,cResAnter:=u,cResAnter)},oGrp2,264,084,,,CLR_BLACK,CLR_WHITE,,.T.,"",,,.F.,.F.,.T.,,,.F.,,  )
oGrp5      := TGroup():New( 136,277,232,545,"Historico de Contratações (anteriores)",oDlg1,CLR_BLACK,CLR_WHITE,.T.,.F. )
oMGet3     := TMultiGet():New( 144,281,{|u| If(PCount()>0,cContAnter:=u,cContAnter)},oGrp5,260,084,,,CLR_BLACK,CLR_WHITE,,.T.,"",,,.F.,.F.,.T.,,,.F.,,  )
oGrp7      := TGroup():New( 092,412,132,544,"Afastados",oDlg1,CLR_BLACK,CLR_WHITE,.T.,.F. )
oBtn7      := TButton():New( 100,452,"Qtda",oGrp7,,047,012,,,,.T.,,"",,,,.F. )
oGrp9      := TGroup():New( 093,276,133,408,"Ativos ",oDlg1,CLR_BLACK,CLR_WHITE,.T.,.F. )
oGet11     := TGet():New( 119,320,{|u| If(PCount()>0,nQtdaAtv:=u,nQtdaAtv)},oGrp9,045,008,'@E 99,999,999',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nQtdaAtv",,)
oGet21     := TGet():New( 118,452,{|u| If(PCount()>0,nQtdaAft:=u,nQtdaAft)},oGrp7,045,008,'@E 99,999,999',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nQtdaAft",,)
oGrp8      := TGroup():New( 000,356,032,428,"Sequencias - Periodos",oDlg1,CLR_BLACK,CLR_WHITE,.T.,.F. )
oSay12     := TSay():New( 008,400,{||"Seq Mes"},oGrp8,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,027,008)
oSay11     := TSay():New( 008,360,{||"Seq Ano"},oGrp8,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,027,008)
oGet26     := TGet():New( 017,360,{|u| If(PCount()>0,cSeqAno:=u,cSeqAno)},oGrp8,027,008,'@E 999999',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cSeqAno",,)
oGet25     := TGet():New( 017,396,{|u| If(PCount()>0,cSeqMes:=u,cSeqMes)},oGrp8,027,008,'@E 999999',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cSeqMes",,)
oGrp10     := TGroup():New( 236,004,312,544,"Mensagens / Observações ",oDlg1,CLR_BLACK,CLR_WHITE,.T.,.F. )
oMGet1     := TMultiGet():New( 244,008,{|u| If(PCount()>0,cMensObse:=u,cMensObse)},oGrp10,532,064,,,CLR_BLACK,CLR_WHITE,,.T.,"",,,.F.,.F.,.F.,,,.F.,,  )
oBtn5      := TButton():New( 101,320,"Qtda",oGrp9,,047,012,,,,.T.,,"",,,,.F. )

oDlg1:Activate(,,,.T.)

Return()

Static Function fMArqVar() 

 cCnpjCont  :=  PEX_CNPJ        
 cCodCor    :=  PEX_CODCOR    
 cCodEmp    :=  PEX_CODEMP    
 cCodGest   :=  PEX_CODGES   
 cCodVend   :=  PEX_CODVEN   
 cContAnter := (' ')                
 cMensObse  :=  PEX_MENSOB   
 cNomCor    :=  PEX_NOMCOR    
 cNomGest   :=  PEX_NOMGES    
 cNomVend   :=  PEX_NOMVEN    
 cOprAtual  :=  PEX_OPRATU    
 cResAnter  := (' ')
 cRSocial   :=  PEX_NOMEMP  
 cSeqAno    :=  PEX_SEQANO  
 cSeqEmp    :=  PEX_SEQEMP  
 cSeqMes    :=  PEX_SEQMES  
 cStatus    :=  PEX_STATUS  
 dDtFinal   :=  PEX_DTFIM   
 dDtInic    :=  PEX_DTINC    
 dDtProrrog :=  PEX_DTPROR   
 nCarta     :=  PEX_CARTA   
 nQtdaAft   :=  PEX_QTDAAF  
 nQtdaAtv   :=  PEX_QTDAAT   
 dDatUlInc  :=  PEX_ULTINC     
 cSequen    :=  PEX_SEQUEN          
Return()

Static Function fMVarArq() 

 PEX_CNPJ    := cCnpjCont   
 PEX_CODCOR  := cCodCor 
 PEX_CODEMP  := cCodEmp 
 PEX_CODGES  := cCodGest
 PEX_CODVEN  := cCodVend
             
 PEX_MENSOB  := cMensObse
 PEX_NOMCOR  := cNomCor 
 PEX_NOMGES  := cNomGest 
 PEX_NOMVEN  := cNomVend 
 PEX_OPRATU  := cOprAtual 
 
 PEX_NOMEMP  := cRSocial
 PEX_SEQANO  := cSeqAno
 PEX_SEQEMP  := cSeqEmp
 PEX_SEQMES  := cSeqMes
 PEX_STATUS  := cStatus
 PEX_DTFIM   := dDtFinal
 PEX_DTINC   := dDtInic 
 PEX_DTPROR  := dDtProrrog 
 PEX_CARTA   := nCarta
 PEX_QTDAAF  := nQtdaAft
 PEX_QTDAAT  := nQtdaAtv 
 PEX_ULTINC  := dDatUlInc  
 PEX_MENSOB  := cMensObse 
 PEX_SEQUEN  := cSequen
Return()

Static Function fLimpVar() 

a:= 'B'

 cCnpjCont  := Space(18)  // PEX_CNPJ  
 cCodCor    := Space(6)   // PEX_CODCOR
 cCodEmp    := Space(6)   // PEX_CODEMP
 cCodGest   := Space(6)   // PEX_CODGES
 cCodVend   := Space(6)   // PEX_CODVEN
 cContAnter := ' '              
 cMensObse                // PEX_MENSOB
 cNomCor    := Space(30)  // PEX_NOMCOR 
 cNomGest   := Space(30)  // PEX_NOMGES
 cNomVend   := Space(30)  // PEX_NOMVEN
 cOprAtual  := Space(30)  // PEX_OPRATU 
 cResAnter  := ' ' 
 cRSocial   := Space(30)  // PEX_NOMEMP
 cSeqAno    := Space(6)   // PEX_SEQANO
 cSeqEmp    := Space(6)   // PEX_SEQEMP
 cSeqMes    := Space(6)   // PEX_SEQMES
 cStatus    := Space(20)  // PEX_STATUS
 dDtFinal   := CtoD(" ")  // PEX_DTFIM 
 dDtInic    := CtoD(" ")  // PEX_DTINC 
 dDtProrrog := CtoD(" ")  // PEX_DTPROR 
 nCarta     := 1              // PEX_CARTA
 nQtdaAft   := 0          // PEX_QTDAAF
 nQtdaAtv   := 0          // PEX_QTDAAT
 dDatUlInc  := CtoD(" ")  // PEX_ULTINC
                          // PEX_SEQUEN -- SEQUENCIA PARA X2_UNICO

Return( )

Static Function   fVdCnpj(cCnpjCont)

	local lret:= 'T'
    Local DV11  := val(substr(cCnpjCont,1,1))*6
	Local DV12  := val(substr(cCnpjCont,2,1))*7
	Local DV13  := val(substr(cCnpjCont,4,1))*8
	Local DV14  := val(substr(cCnpjCont,5,1))*9
	Local DV15  := val(substr(cCnpjCont,6,1))*2
	Local DV16  := val(substr(cCnpjCont,8,1))*3
	Local DV17  := val(substr(cCnpjCont,9,1))*4
	Local DV18  := val(substr(cCnpjCont,10,1))*5
	Local DV19  := val(substr(cCnpjCont,12,1))*6
	Local DV110 := val(substr(cCnpjCont,13,1))*7
	Local DV111 := val(substr(cCnpjCont,14,1))*8
	Local DV112 := val(substr(cCnpjCont,15,1))*9

    local DVX   := 0

    Local DV21  := val(substr(cCnpjCont,1,1))*5
	Local DV22  := val(substr(cCnpjCont,2,1))*6
	Local DV23  := val(substr(cCnpjCont,4,1))*7
	Local DV24  := val(substr(cCnpjCont,5,1))*8
	Local DV25  := val(substr(cCnpjCont,6,1))*9
	Local DV26  := val(substr(cCnpjCont,8,1))*2
	Local DV27  := val(substr(cCnpjCont,9,1))*3
	Local DV28  := val(substr(cCnpjCont,10,1))*4
	Local DV29  := val(substr(cCnpjCont,12,1))*5
	Local DV210 := val(substr(cCnpjCont,13,1))*6
	Local DV211 := val(substr(cCnpjCont,14,1))*7
	Local DV212 := val(substr(cCnpjCont,15,1))*8
    local DV2X  := 0 

    local DVY   := 0 
/* calculo do digito verificador 

1  8  7  8  1  2  0  3  0  0  0  1 = 2               
x  x  x  x  x  x  x  x  x  x  x  x               
6  7  8  9  2  3  4  5  6  7  8  9            
----------------------------------                   
6+56+56+72+ 2+ 6+ 0+15+ 0+ 0+ 0+ 9 = 222÷11=20, com resto 2

1  8  7  8  1  2  0  3  0  0  0  1  2 = 8
x  x  x  x  x  x  x  x  x  x  x  x  x
5  6  7  8  9  2  3  4  5  6  7  8  9
-------------------------------------
5+48+49+64+ 9+ 4+ 0+12+ 0+ 0+ 0+ 8+18 = 217÷11=19, com resto 8

Portanto, CNPJ+DV = 18.781.203/0001-28

//////
3  3  7  7  5  1  6  4  0  0  0  1 =
x  x  x  x  x  x  x  x  x  x  x  x               
6  7  8  9  2  3  4  5  6  7  8  9           
----------------------------------
18+21+56+63+10+3+24+20+ 0+ 0+ 0+ 9 
*/


If  !Empty(cCnpjCont)

aDados1  := {}
fCargtab()
   
    DVX  := (DV11+DV12+DV13+DV14+DV15+DV16+DV17+DV18+DV19+DV110+DV111+DV112)-(int((DV11+DV12+DV13+DV14+DV15+DV16+DV17+DV18+DV19+DV110+DV111+DV112)/11)*11)  
    If len(alltrim(str(DVX))) = 1
       DV2X :=  DVX * 9
    Else 
       DV2X := val(substr(alltrim(str(DVX)),2,1)) * 9
	   DVX  := DV2X
    EndIf 
    DVY  := (DV21+DV22+DV23+DV24+DV25+DV26+DV27+DV28+DV29+DV210+DV211+DV212+DV2X)-(int((DV21+DV22+DV23+DV24+DV25+DV26+DV27+DV28+DV29+DV210+DV211+DV212+DV2X)/11)*11)
    DVY  := val(SUBSTR(ALLTRIM(STR(DVY)),(len(ALLTRIM(STR(DVY)))),1))

    If  ALLTRIM(str(DVX))+ALLTRIM(str(DVY))!= substr(cCnpjCont,17,2)
        
		ALERT("Cnpj Invalido , verifique ....  , ATENÇÃO  !!!!")   
        
		oget5:setfocus()
        
    Else
        
		fPesqCnpj(cCnpjCont)

        if !lgrava
	        FbuscDado(cCnpjCont)
		EndIf 	   
	EndIf   
EndIf   

Return(lret)

static function FbuscDado(cCnpjCont)

 local ret        := " "  
 local cQuery     := " "   
 local cQuery1    := " " 
 local cCnpjConts := substr(cCnpjCont,1,10)
 lPriInc          := .F.
 local cAlerta    := .F. 

If  cUser $ cUsuincl

	cQuery := "select * from pex020 where R_E_C_N_O_ = (select max(r_E_C_N_O_) from PEX020 PEX where pex_filial = ' '  and d_E_L_E_T_ = ' ' ) "

	If Select((cAliasPexT)) <> 0 
	(cAliasPexT)->(DbCloseArea())  
	Endif                          

	TCQuery cQuery New Alias (cAliasPexT)   

	//(cAliasPexT)->(DbGoTop() ) 

	if (cAliasPexT)->(Eof())

		If  fMostrRes(cCnpjCont, 1)
			MsgAlert('Existe Reserva ATIVA para esta Empresa, Registrada em Planilha ', 'ATENÇÃO')
			cCnpjCont:= ' ' 
			oGet5:SETFOCUS()
		Else 
			cSeqEmp    := StrZero(1,6)	 	
			cSeqAno    := StrZero(1,6)
			cSeqMes    := StrZero(1,6)
			cCodEmp    := StrZero(1,6)
			dDatUlInc  := dDateHoje 
			dDtInic    := fCalcDt(1)
			dDtFinal   := fCalcDt(2)
			dDtProrrog := CTOD(' ')
			lPriInc    := .T.
			cStatus    := 'Reservado'
			cCodEmp    := StrZero(1,6)
			cSequen    := StrZero(1,6)
		EndIf 		

		ElseIf nopc1 = 3  

	   If  fMostrRes(cCnpjCont, 1)
			MsgAlert('Existe Reserva ATIVA para esta Empresa, Registrada em Planilha ', 'ATENÇÃO')
			cCnpjCont:= " "
			oGet5:Refresh()
			oGet5:SETFOCUS()
        EndIf

		cQuery := "select * from PEX020 PEX where pex_filial = ' '  and d_E_L_E_T_ = ' ' and Pex_cnpj = '"+cCnpjCont+"'"
		cQuery += CRLF+ " order by PEX_CNPJ , PEX_SEQEMP DESC"

		If Select((cAliasCEmp)) <> 0 
		(cAliasCEmp)->(DbCloseArea())  
		EndIf                          

		TCQuery cQuery New Alias (cAliasCEmp)   

		if  (cAliasCEmp)->(Eof())
		
			fcodemp()
			dDatUlInc  := dDateHoje 
			dDtInic    := fCalcDt(1)
			dDtFinal   := fCalcDt(2)
			dDtProrrog := CTOD(' ')
		//   lPriInc    := .T.
			cStatus    := 'Reservado'

			If  substr(dtos(dDateHoje),1,4) == substr((cAliasPexT)->PEX_ULTINC,1,4)
				cSeqAno := StrZero((val((cAliasPexT)->PEX_SEQANO)+1),6)
				If  substr(dtos(dDateHoje),5,2) == substr((cAliasPexT)->PEX_ULTINC,5,2)	 
					cSeqMes :=StrZero((val((cAliasPexT)->PEX_SEQMES)+1),6)
				Else 
					cSeqMes  :=StrZero(1,6)
				EndIf 	
			Else 
					cSeqAno  :=StrZero(1,6)
					cSeqMes  :=StrZero(1,6)
			EndIf
	/// trata base ddo CNPJ

			cQuery1 := "select * from PEX020 PEX where pex_filial = ' '  and d_E_L_E_T_ = ' ' and substr(Pex_cnpj,1,10) = '"+cCnpjConts+"'"
			cQuery1 += CRLF+ " order by PEX_CNPJ , PEX_SEQEMP DESC"

			If Select((cAliasBEmp)) <> 0 
			(cAliasBEmp)->(DbCloseArea())  
			EndIf                          

			TCQuery cQuery1 New Alias (cAliasBEmp)   
	
			if !(cAliasBEmp)->(Eof())
				MsgAlert('Existe Reserva ATIVA para Empresa do Grupo deste CNPJ', 'ATENÇÃO')
				fMostrRes(cCnpjConts, 2)
			EndIf	

	/////////////////

		ElseIf  empty((cAliasCEmp)->PEX_DTPROR)

			If  !(cAliasCEmp)->(Eof()) .and. (cAliasCEmp)->PEX_DTFIM > dtos(dDateHoje)

					fMArqVar()

				MsgAlert('Existe Reserva ATIVA para este CNPJ', 'ATENÇÃO')
				fMostrRes(cCnpjCont, 1)
				
			Else 

				MsgAlert('Existe Reserva com data VENCIDA para este CNPJ, é possivel novo cadastro', 'ATENÇÃO')	
				fMostrRes(cCnpjCont, 1)
				fcodemp()
				If  substr(dtos(dDateHoje),1,4) == substr((cAliasPexT)->PEX_ULTINC,1,4)
					cSeqAno    := StrZero((val((cAliasPexT)->PEX_SEQANO)+1),6)
					If substr(dtos(dDateHoje),5,2) == substr((cAliasPexT)->PEX_ULTINC,5,2)	 
					cSeqMes  :=StrZero((val((cAliasPexT)->PEX_SEQMES)+1),6)
					Else 
					cSeqMes  :=StrZero(1,6)
					EndIf 	
				Else 
					cSeqAno  :=StrZero(1,6)
				EndIf 
			EndIf       

		Else
		
			If  (cAliasCEmp)->PEX_DTPROR > dtos(dDateHoje)
		
				MsgAlert('Existe Reserva ,PRORROGADA e ATIVA para este CNPJ', 'ATENÇÃO')
				fMostrRes(cCnpjCont, 1)

				oDlg1:End()

			Else 

				MsgAlert('Existe Reserva,  PRORROGADA  com data VENCIDA para este CNPJ, é possivel novo cadastro', 'ATENÇÃO')	
				fMostrRes(cCnpjCont, 1)
				
				If  substr(dtos(dDateHoje),1,4) == substr((cAliasPexT)->PEX_ULTINC,1,4)
					cSeqAno    := StrZero((val((cAliasPexT)->PEX_SEQANO)+1),6)
					If substr(dtos(dDateHoje),5,2) == substr((cAliasPexT)->PEX_ULTINC,5,2)	 
					cSeqMes  :=StrZero((val((cAliasPexT)->PEX_SEQMES)+1),6)
					Else 
					cSeqMes  :=StrZero(1,6)
					EndIf 	
				Else 
					cSeqAno  :=StrZero(1,6)
				EndIf 
			EndIf        
		EndIF 
	EndIf 

Else 
    cQuery := "select * from PEX020 PEX where pex_filial = ' '  and d_E_L_E_T_ = ' ' and Pex_cnpj = '"+cCnpjCont+"'"
	cQuery += CRLF+ " order by PEX_CNPJ , PEX_SEQEMP DESC"

	If Select((cAliasCEmp)) <> 0 
   	  (cAliasCEmp)->(DbCloseArea())  
	EndIf                          

		TCQuery cQuery New Alias (cAliasCEmp)   


    If  !(cAliasCEmp)->(Eof()) .and. (cAliasCEmp)->PEX_DTFIM > dtos(dDateHoje)

        MsgAlert('Existe Reserva ATIVA para este CNPJ , Gestor'+(cAliasCEmp)->PEX_NOMGES+' ' , 'ATENÇÃO')
		cAlerta:=.T.
				
    EndIf 
	If  (cAliasCEmp)->PEX_DTPROR > dtos(dDateHoje)
		
		MsgAlert('Existe Reserva ,PRORROGADA e ATIVA para este CNPJ, Gestor'+(cAliasCEmp)->PEX_NOMGES+' ', 'ATENÇÃO')
        cAlerta:=.T.
    EndIf 

    If  fMostrRes(cCnpjCont, 1)
		MsgAlert('Existe Reserva ATIVA para esta Empresa, Registrada em Planilha ', 'ATENÇÃO')
        cAlerta:=.T.
    EndIf  
   
    If  cAlerta==.F.
		MsgAlert('A Reserva desta Empresa pode ser feita ', 'ATENÇÃO')
    EndIf  

    oDlg1:End()

EndIf 
Return(ret)      

static Function fGrava(acao)

lgrava:=.T.

if EMPTY(cMensObse)
   cMensObse:= ' ' 
EndIf 

If  fCritica()
        lgrava:=.F.

    If  nopc1 = 3  
		cMensObse +=CRLF+  ' Reserva incluida com sucesso por - '+USUAR633+ ' em :' + substr(dtos(dDateHoje),7,2)+'/'+substr(dtos(dDateHoje),5,2)+'/'+substr(dtos(dDateHoje),1,4)

	    RecLock("PEX",.T.)
		if lPriInc 
		   cSequen := StrZero(1,6)
		Else    
           cSequen := StrZero((val((cAliasSEmp)->cSequen)+1),6)
		EndIf   
	Else 
        
		If  acao == 3 
			cMensObse +=CRLF+  ' Proposta DECLINADA  - '+USUAR633+ ' em :' + substr(dtos(dDateHoje),7,2)+'/'+substr(dtos(dDateHoje),5,2)+'/'+substr(dtos(dDateHoje),1,4)
            cStatus    := 'Declinado'
			oGet10:ctrlrefresh()   
	    ElseIf  acao == 4 
			cMensObse +=CRLF+  ' Empresa Contratada - '+USUAR633+ ' em :' + substr(dtos(dDateHoje),7,2)+'/'+substr(dtos(dDateHoje),5,2)+'/'+substr(dtos(dDateHoje),1,4)
            cStatus    := 'Contratada'
			oGet10:ctrlrefresh()   
	    EndIf 	
	EndIf 	
		
	EndIf 
	If  nCarta != PEX->PEX_CARTA
		    
		If  nCarta == 1
				
			if  PEX->PEX_CARTA == 2 
				cMensObse +=CRLF+  ' Havia carta de Nomeacao e foi retiradas (sem carta) - '+USUAR633+ ' em :' + substr(dtos(dDateHoje),7,2)+'/'+substr(dtos(dDateHoje),5,2)+'/'+substr(dtos(dDateHoje),1,4)
			Elseif  PEX->PEX_CARTA == 3 
				cMensObse +=CRLF+  ' Havia carta de Exclusividade e foi retiradas (sem carta) - '+USUAR633+ ' em :' + substr(dtos(dDateHoje),7,2)+'/'+substr(dtos(dDateHoje),5,2)+'/'+substr(dtos(dDateHoje),1,4) 	 
			EndIf 

		ElseIf nCarta == 2
					
			if  PEX->PEX_CARTA == 1 
				cMensObse +=CRLF+  'Anterior sem carta,  Foi concedida carta de Nomeacao - '+USUAR633+ ' em : ' + substr(dtos(dDateHoje),7,2)+'/'+substr(dtos(dDateHoje),5,2)+'/'+substr(dtos(dDateHoje),1,4)
			Elseif  PEX->PEX_CARTA == 3 
				cMensObse +=CRLF+  'Foi retirada carta de Exclusividade e concedida Carta de nomeacao - '+USUAR633+ ' em : '  + substr(dtos(dDateHoje),7,2)+'/'+substr(dtos(dDateHoje),5,2)+'/'+substr(dtos(dDateHoje),1,4)	 
			EndIf 

		ElseIf nCarta == 3    

			if  PEX->PEX_CARTA == 1 
				cMensObse +=CRLF+  'Anterior sem carta,  Foi Concedida carta de exclusividade  - '+USUAR633+ ' em : '  + substr(dtos(dDateHoje),7,2)+'/'+substr(dtos(dDateHoje),5,2)+'/'+substr(dtos(dDateHoje),1,4)
			Elseif  PEX->PEX_CARTA == 2 
				cMensObse +=CRLF+  'Foi retirada carta de Nomeação e concedida Carta de exclusividade  - '+USUAR633+ ' em : ' + substr(dtos(dDateHoje),7,2)+'/'+substr(dtos(dDateHoje),5,2)+'/'+substr(dtos(dDateHoje),1,4)
			EndIf  
		EndIf 
    EndIf 
	
	    RecLock("PEX",.F.)
	
			PEX_CNPJ    := cCnpjCont   
			PEX_CODCOR  := cCodCor 
			PEX_CODEMP  := cCodEmp 
			PEX_CODGES  := cCodGest
			PEX_CODVEN  := cCodGest

			PEX_MENSOB  := cMensObse
			PEX_NOMCOR  := cNomCor 
			PEX_NOMGES  := cNomGest 
			PEX_NOMVEN  := cNomVend 
			PEX_OPRATU  := cOprAtual 
			
			PEX_NOMEMP  := cRSocial
			PEX_SEQANO  := cSeqAno
			PEX_SEQEMP  := cSeqEmp
			PEX_SEQMES  := cSeqMes
			PEX_STATUS  := cStatus
			PEX_DTFIM   := dDtFinal
			PEX_DTINC   := dDtInic 
			PEX_DTPROR  := dDtProrrog 
			PEX_CARTA   := nCarta
			PEX_QTDAAF  := nQtdaAft
			PEX_QTDAAT  := nQtdaAtv 
			PEX_MENSOB  := cMensObse 
			PEX_ULTINC  := dDatUlInc  
			PEX_SEQUEN  := cSequen
				
	    Msunlock("PEX")		

Return()

static function fDelete()

   // If trim(pex_status) == 'Reservado'  - RETIRADO POR ORDEN DO Rodrigo 
       	If ApMsgYesNo("Deseja excluir o Registro. Deseja excluir","SIMNAO")
              PEX->(RecLock("PEX",.F.))
    	      PEX->(DbDelete())
    	      PEX->(MsUnlock())      
    	   MsgAlert("Reserva EXCLUIDO com Sucesso  !!! ","Atencao!")        
     	   oDlg1:End()               
     	EndIf   
//    Else 
//	    ALERT("Reserva Não pode ser excluida , status diferente de Reservado , verifique ....  , ATENÇÃO  !!!!")   
//    EndIf 

Return()

static Function fCalcDt(tp)

local cDia  :=  substr(dtos(dDateHoje),7,2)
local cMes  :=  substr(dtos(dDateHoje),5,2)
local cAno  :=  substr(dtos(dDateHoje),1,4)

lProrroga:= .F.

If  tp==1
    Ret:= dDateHoje
EndIf 

If  tp==2
 
	If  cMes >= '11' 
		If  cMes =='11'
			cAno:= alltrim(str(val(cAno)+1))
			cMes:= '01'
		else
			If  cMes =='12'
	    		cAno:= alltrim(str(val(cAno)+1))
			    cMes:= '02'
			EndIf 
		EndIf	
	Else     
		cMes:= alltrim(strzero((val(cMes)+2),2))
		If cMes=='02'
		   If cDia > '28'
		      cDia:='28'
		   EndIF 
		EndIF    	  
	EndIf

    Ret := stod(cAno+cMes+cDia)

EndIf 

If  tp==3
 
	If  cMes >= '11' 
		If  cMes =='11'
			cAno:= alltrim(str(val(cAno)+1))
			cMes:= '01'
		else
			If  cMes =='12'
	    		cAno:= alltrim(str(val(cAno)+1))
			    cMes:= '02'
			EndIf 
		EndIf	
	Else     
		cMes:= alltrim(strzero(val((cMes)+2),2))
		If cMes=='02'
		   If cDia > '28'
		      cDia:='28'
		   EndIF 
		EndIF    	  
	EndIf

    Ret := ' ' 
	dDtFinal   := dDateHoje
	dDtProrrog := stod(cAno+cMes+cDia)
	cStatus    := 'Prorrogado'
	cMensObse +=CRLF+  ' Proposta Prorrogada - '+USUAR633+ ' em :' + substr(dtos(dDateHoje),7,2)+'/'+substr(dtos(dDateHoje),5,2)+'/'+substr(dtos(dDateHoje),1,4)
	lProrroga  := .T.

EndIf 

Return(Ret)


static Function fCritica()

Local lRet:=.T.

    fVdCnpj(cCnpjCont)
		If  !empty(dDtProrrog) .and. (cStatus != 'Declinado' .and. cStatus != 'Contratada' .and. cStatus != 'Contratada')
		    If  dDtProrrog >= dDateHoje
		        cStatus:= 'Prorrogado'
			Else	
			    cStatus:= 'Vencida'
            EndIF 
		elseIf  empty(dDtProrrog) 
		    If  dDtFinal < dDateHoje
		        cStatus:= 'Vencida'
			EndIf 	
		EndIf 

return(lRet)
/////////////////

Static Function fcodemp()

local cQuerycd   := " " 

cQuerycd := "select max(PEX_CODEMP) codemp  , max(pex_seqano) SeqAno , max(pex_seqmes) SeqMes , max(PEX_ULTINC) ULTINC , MAX(PEX_SEQUEN) cSequen "
cQuerycd += CRLF+ " from PEX020 PEX where pex_filial = ' '  and d_E_L_E_T_ = ' ' "

If Select((cAliasSEmp)) <> 0 
   (cAliasSEmp)->(DbCloseArea())  
Endif                          

TCQuery cQuerycd  New Alias (cAliasSEmp)   

if !(cAliasSEmp)->(Eof())

	cCodEmp    := StrZero((val((cAliasSEmp)->CODEMP)+1),6)
    cSeqEmp    := StrZero(1,6)	
	
//	cSequen    := StrZero((val((cAliasSEmp)->cSequen)+1),6)

EndIf 
/*
    If substr(dtos(dDateHoje),1,4) > substr((cAliasSEmp)->ULTINC,1,4)
       cSeqAno    :=StrZero(1,6)
	   cSeqMes    :=StrZero(1,6)
	ElseIf substr(dtos(dDateHoje),1,4) == substr((cAliasSEmp)->ULTINC,1,4) .and. substr(dtos(dDateHoje),2,5) != substr((cAliasSEmp)->ULTINC,2,5)
           cSeqAno    :=StrZero((val((cAliassEmp)->SEQANO))+1,6)
		   cSeqMes    :=StrZero(1,6)
    ElseIf substr(dtos(dDateHoje),1,4) == substr((cAliasCEmp)->ULTINC,1,4) .and. substr(dtos(dDateHoje),2,5) == substr((cAliasCEmp)->ULTINC,2,5)
           cSeqAno    :=StrZero((val((cAliasCEmp)->SEQANO))+1,6)
	       cSeqMes    :=StrZero((val((cAliasCEmp)->SEQMES))+1,6)
    EndIf
endIf 	
*/
return()

static Function fMostrRes(cCnpjCont, ident)

local I := 1
local lRet:= .F.
local alogemp:= {}
local cQuery2 := ' '

		cQuery2 := "select " 
		cQuery2 += CRLF+ " PEX_CNPJ     cnpj , 
		cQuery2 += CRLF+ " pex_nomemp nomemp , 
		cQuery2 += CRLF+ " PEX_NOMCOR nomcor , 
		cQuery2 += CRLF+ " PEX_NOMVEN NOMVEN ,
		cQuery2 += CRLF+ " pex_nomges nomges , 
		cQuery2 += CRLF+ " pex_opratu opratu , 
		cQuery2 += CRLF+ " pex_status status ,
		cQuery2 += CRLF+ " substr(pex_dtinc,7,2)||'/'||substr(pex_dtinc,5,2)||'/'||substr(pex_dtinc,1,4) datinc , 
		cQuery2 += CRLF+ " substr(pex_dtfim,7,2)||'/'||substr(pex_dtfim,5,2)||'/'||substr(pex_dtfim,1,4) datfim , 
		cQuery2 += CRLF+ " substr(pex_Dtpror,7,2)||'/'||substr(pex_Dtpror,5,2)||'/'||substr(pex_Dtpror,1,4) Datpror, 
		cQuery2 += CRLF+ " case when pex_carta = 1  then 'Sem Carta'
		cQuery2 += CRLF+ "      when pex_carta = 2  then 'Nomeação'
		cQuery2 += CRLF+ "      when pex_carta = 3  then 'Exclusividade'       
		cQuery2 += CRLF+ "  End carta , 
		cQuery2 += CRLF+ "  PEX_QTDAAT QTDAAT , 
		cQuery2 += CRLF+ "  PEX_QTDAAF QTDAAF 

	if  ident == 1
		cQuery2 += CRLF+ " from PEX020 PEX where pex_filial = ' '  and d_E_L_E_T_ = ' ' and Pex_cnpj = '"+cCnpjCont+"'"
	Elseif  ident == 2
		cQuery2 += CRLF+ " from PEX020 PEX where pex_filial = ' '  and d_E_L_E_T_ = ' ' and substr(Pex_cnpj,1,10) = '"+cCnpjCont+"'"
	EndIf		
		cQuery2 += CRLF+ " order by PEX_SEQEMP DESC"

	//ENDIF

    If Select((cAliasPEmp)) <> 0 
	      (cAliasPEmp)->(DbCloseArea())  
    EndIf                          

    TCQuery cQuery2 New Alias (cAliasPEmp)   
 
    if !(cAliasPEmp)->(Eof())

    	While !(cAliasPEmp)->(EOF())

			aAdd(alogemp,{TRIM((cAliasPEmp)->cnpj )   ,; 
						 trim((cAliasPEmp)->nomemp)   ,; 
						 trim((cAliasPEmp)->nomcor)   ,;  
						 trim((cAliasPEmp)->nomven)   ,; 
						 trim((cAliasPEmp)->nomges)   ,; 
						 trim((cAliasPEmp)->opratu)   ,;  
						 trim((cAliasPEmp)->status)   ,; 
						 (cAliasPEmp)->Datinc         ,; 
						 (cAliasPEmp)->Datfim         ,;  
						 (cAliasPEmp)->Datpror        ,; 
						 (cAliasPEmp)->carta          ,; 
						 (cAliasPEmp)->qtdaat         ,;
						 (cAliasPEmp)->qtdaaf    })     
		
			
			(cAliasPEmp)->(DbSkip())

		EndDo
    EndIf 
	For I:=1 To Len(aDados1)
		if  ident == 1
		    If adados1[I,1]	== cCnpjCont
			   aAdd(alogemp,{adados1[I,1]   ,; 
	 					         adados1[I,6]   ,; 
								 adados1[I,8]   ,; 
								 adados1[I,9]   ,; 
								 ' '                  ,;
								 ' '                  ,;
								 'Planilha'           ,;
								 adados1[I,2]   ,; 
								 adados1[I,5]    ,; 
								 '  /  /  '           ,;
								 'Planilha'           ,;
                                 adados1[I,10]   ,; 
                                 adados1[I,11]   })
				    If 	(substr(adados1[I,5],7,4)+substr(adados1[I,5],4,2)+substr(adados1[I,5],1,2)) > dtos(dDateHoje)
					    lRet:=.T.
					EndIf 				 
			EndIf 
		Else
		    If substr(adados1[I,1],1,10) == cCnpjCont
				    aAdd(alogemp,{adados1[I,1]   ,; 
				   		          adados1[I,6]   ,; 
								  adados1[I,8]   ,; 
								  adados1[I,9]   ,; 
								  ' '                  ,;
								  ' '                  ,;
								  'Planilha'           ,;
								  adados1[I,2]   ,; 
								  adados1[I,5]    ,; 
								  '  /  /  '           ,;
								  'Planilha'           ,;
                                  adados1[I,10]   ,; 
                                  adados1[I,11]   })
		    EndIf
        EndIf 
	Next

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Detalhe dp titulo de comisso                                             ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If  len(alogemp) > 0  .and. cUser $ cUsuincl 			

		   	PLSCRIGEN(alogemp,{ {'CNPJ',"@!",20}     ,;
								{'Empresa ',"@!",30} ,;
								{'Corretor ',"@!",30} ,;
							   	{'Vendedor ' ,"@!",30} ,;
                                {'Gestor Venda' ,"@!",30} ,;
								{'Operadora Atual ' ,"@!",30},;
								{'Status ',"@!",30} ,;
							   	{'Data Inclusao ' ,"@!",30} ,;
                                {'Data Final ' ,"@!",30} ,;
								{'Data Prorrog. ' ,"@!",30},;
								{'Carta ' ,"@!",30} ,;
								{'Vidas Ativas ' ,"@!",30},;	
								{'Vidas Afastadas ' ,"@!",30}},;
								 'listagem de empresa ja reservadas - ',nil,nil) 
		Endif

Return(lRet)


Static Function fCargtab()
	
Local cNomeArq  := 'G:\DICOM\GEREM\NÚCLEO GERENCIAL 2\cotacao\cotacao2023.csv'
Local lprimeiro := .T.	
local nCont     := 0

	FT_FUSE(cNomeArq)
	FT_FGOTOP()
	
	ProcRegua(FT_FLASTREC())
	
	While !FT_FEOF()
		
		IncProc('Processando...')     
		
		cBuffer := FT_FREADLN()		//joga o conteudo da linha na variavel
		FT_FSKIP()
		aDados := separa(cBuffer,';',.T.)
		nCont++
        If  lprimeiro == .F.
            aAdd(aDados1,  {adados[01] ,;
			  			    adados[02] ,;
						    adados[03] ,;
							adados[04] ,;
							adados[05] ,;
							adados[06] ,;
							adados[07] ,;
							adados[08] ,;
							adados[09] ,;
							adados[10] ,;
							adados[11] ,;
							adados[12]})
			nCont++					
		Else 
		    If nCont >2
               lprimeiro := .F.
			EndIF    
        EndIf 
	EndDo 

	a:="b"	
Return()	

static function fBcoConhec()
		
	If nopc1 != 3 		

		dbgoto(PEX->(RECNO()))

		MsDocument("PEX", PEX->(RECNO()), 4 )
		
	EndIf 

return()

static function fPesqCnpj(cCnpjCont)

local lRet:= .F.
local alogempq:= {}
local cQuery3 := ' '
local cCnpj   :=substr(cCnpjCont,1,2) + substr(cCnpjCont,4,3) + substr(cCnpjCont,8,3) + substr(cCnpjCont,12,4)+ substr(cCnpjCont,17,2) 
local cContAberA :=""
local cContAberB :=""
local cContAberV :=""

cQuery3 :=       " SELECT BG9_CODIGO CODEMP , "
cQuery3 += CRLF+ " BG9_DESCRI NOME_EMP , "
cQuery3 += CRLF+ " BQC_CNPJ CNPJ_EMP , "
cQuery3 += CRLF+ " BQC_NUMCON NUM_CONTRA , "
cQuery3 += CRLF+ " BQC_SUBCON NUM_SUBCONT , "
cQuery3 += CRLF+ " BQC_DESCRI DESC_SUB_CON , "
cQuery3 += CRLF+ " BQC_DATBLO Dt_Bloc , "
cQuery3 += CRLF+ " substr(BQC_DATCON,7,2)||'/'||substr(BQC_DATCON,5,2)||'/'||substr(BQC_DATCON,1,4) Dt_Inc , "
cQuery3 += CRLF+ " substr(BQC_DATBLO,7,2)||'/'||substr(BQC_DATBLO,5,2)||'/'||substr(BQC_DATBLO,1,4) Dt_Bloq , "
cQuery3 += CRLF+ " COUNT(BA1_DATINC) TOTAL_Vidas , "
cQuery3 += CRLF+ " SUM(DECODE(TRIM(BA1_DATBLO),'',0,1)) Tot_BLOQ "
cQuery3 += CRLF+ " FROM BQC020 BQC , BG9020 BG9 ,BA1020 BA1 "
cQuery3 += CRLF+ " WHERE BQC_FILIAL = ' ' AND BQC.D_e_l_e_t_ = ' ' "
cQuery3 += CRLF+ " AND BG9_FILIAL = ' ' AND BG9.D_e_l_e_t_ = ' ' "
cQuery3 += CRLF+ " AND BA1_FILIAL = ' ' AND BA1.D_e_l_e_t_ = ' ' "
cQuery3 += CRLF+ " AND BG9_CODIGO = BQC_CODEMP "
cQuery3 += CRLF+ " AND BA1_CODEMP = BQC_CODEMP "
cQuery3 += CRLF+ " AND BA1_CONEMP = BQC_NUMCON "
cQuery3 += CRLF+ " AND BA1_SUBCON = BQC_SUBCON "

cQuery3 += CRLF+ " AND BQC_CNPJ = '"+cCnpj+"'"

cQuery3 += CRLF+ " GROUP BY BG9_CODIGO , BG9_DESCRI,  BQC_CNPJ , BQC_NUMCON , BQC_SUBCON, BQC_DESCRI , BQC_DATCON , BQC_DATBLO "
cQuery3 += CRLF+ " ORDER BY 1,4,5 "
  
    If Select((cAliasTEmp)) <> 0 
	      (cAliasTEmp)->(DbCloseArea())  
    EndIf                          

    TCQuery cQuery3 New Alias (cAliasTEmp)   
 
    if !(cAliasTEmp)->(Eof())

    	While !(cAliasTEmp)->(EOF())

			aAdd(alogempq,{(cAliasTEmp)->CODEMP     ,; 
						   trim((cAliasTEmp)->NOME_EMP)   ,; 
						   (cAliasTEmp)->CNPJ_EMP   ,;  
						   (cAliasTEmp)->NUM_CONTRA ,; 
						   (cAliasTEmp)->NUM_SUBCONT   ,; 
						   (cAliasTEmp)->Dt_Inc   ,;  
						   (cAliasTEmp)->Dt_Bloq  ,; 
						   strzero((cAliasTEmp)->TOTAL_Vidas,6)      ,; 
						   strzero((cAliasTEmp)->Tot_BLOQ,6) })     

		        If !empty((cAliasTEmp)->Dt_Bloc )
			        cContAberA := "Existe sub_Contrato Nao Bloqueado para este CNPJ" + CRLF
				Else 
					cContAberB := "Existe sub_Contrato Bloqueados para este CNPJ"+ CRLF
				EndIf 	
		
                If  (cAliasTEmp)->TOTAL_Vidas <> (cAliasTEmp)->Tot_BLOQ
				     cContAberV := "Existe sub_Contrato com vidas ativas  para este CNPJ"+ CRLF
		        EndIf
			
			(cAliasTEmp)->(DbSkip())
		
		EndDo
    
	EndIf 


		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Detalhe dp titulo de comisso                                             ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
 	
	If  len(alogempq) > 0  .and. cUser == cUsuincl 			

		If  (!empty(cContAberA)) .or. (!empty(cContAberB)) .or. (!empty(cContAberV)) 

            ALERT(cContAberA + cContAberB + cContAberV, "ATENÇÃO  !!!!")   
    
	    EndIf
	
	    If ApMsgYesNo("Deseja Exibir Detalhe dos Sub contratos !!","SIMNAO")
	
		   	PLSCRIGEN(alogempq,{ {'Cod Empr',"@!",20}     ,;
								{'Empresa ',"@!",40} ,;
								{'Cnpj ',"@!"   ,20} ,;
							   	{'Contrato ' ,"@!",30} ,;
                                {'Sub Contrato ' ,"@!",30} ,;
								{'Dat Inicio ' ,"@!",30},;
								{'Dat Bloqueio',"@!",30} ,;
							   	{'Qtda Total ' ,"@!",20} ,;
                                {'Qtda Bloq  ' ,"@!",20} },;
								 'Cnpj que ja Foram Cliente ',nil,nil) 
		EndIf
    EndIf 
Return()
