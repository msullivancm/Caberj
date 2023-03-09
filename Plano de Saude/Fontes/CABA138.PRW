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
±±ºPrograma  ³CABA138   ºAutor  ³ Altamiro	         º Data ³  19/06/2015 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Tela de browser do controle do custo operacional           º±±
±±º          ³ 															  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function caba138(cOrigem)
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Monta matriz com as opcoes do browse...                             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	PRIVATE aRotina	:=	{	{ "&Visualizar"	, "U_Caba138V()"		, 0 , 1	 },;
		{ "&Alteracao"	, "U_Caba138V()"	, 0 , 2  },;
		{ "&Incluir"	, "U_Caba138I"		, 0 , 3	 },;
		{ "A&tualizacao", "U_fAtuCust"		, 0 , 3	 },;
		{ "Legenda"		, "U_LPRO138A"	    , 0 , 3	 }}
		
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Titulo e variavies para indicar o status do arquivo                 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	PRIVATE cCadastro	:= "Browser de Controle de Custo Operacional "
	
	PRIVATE aCdCores	:= { 	{ 'BR_AMARELO'  ,'Custo Op. Incluido'  },;
	                        	{ 'BR_VERMELHO' ,'Custo Op. Com Guias' },;
								{ 'BR_AZUL'     ,'Custo Op. Pago'      },;
								{ 'BR_VERDE'    ,'Custo Op. Concluido' }}
	
	PRIVATE aCores	:= {{'!empty(PD2_TITCOB)', aCdCores[4,1]},;
	                    {'!empty(PD2_LOTFAT)', aCdCores[4,1]},;
		                {'!empty(PD2_LOTPAG)', aCdCores[3,1]},;
		                {'!empty(PD2_CODPEG)', aCdCores[2,1]},;
		                {'!empty(PD2_SENHA)' , aCdCores[1,1]} }
	//PRIVATE cPath  := ""
	PRIVATE cAlias := "PD2"
	
	private adadosbd6    := {}
	
	private  lfaz     := .F.
	private  adadobd6 :={}
	private  cCompt1  := ' '
	private  cUsuario := ' '
	private  nOorigem := cOrigem
	
	PRIVATE cPerg	:= "CABA138"
	
	PRIVATE cNomeProg   := "CABA138"
	PRIVATE nQtdLin     := 68
	PRIVATE nLimite     := 132
	PRIVATE cControle   := 15
	PRIVATE cTamanho    := "G"
	PRIVATE cTitulo     := "Controle de Guias do Custo Gerenciado "
	PRIVATE cDesc1      := ""
	PRIVATE cDesc2      := ""
	PRIVATE cDesc3      := ""
	PRIVATE nRel        := "caba138"
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
	PRIVATE cCabec1     := "Controle de Guias do Custo Gerenciado "
	PRIVATE cCabec2     := ""
	PRIVATE nColuna     := 00
	
	PRIVATE cAliastmp   := GetNextAlias()    
	PRIVATE cAliasSe1   := GetNextAlias()  
	PRIVATE cAliasBd7   := GetNextAlias()
	PRIVATE cAlstmpsz9  := GetNextAlias()

	private recod2      := 0
	/////////////////////
	private cTpSenha2 := ' '   //PD2_TPSENH   NOT NULL CHAR(10)
	private cSenha1   := ' '   //PD2_SENHA    NOT NULL CHAR(15)
	private cSenha2   := ' '   //PD2_SENHA    NOT NULL CHAR(15)
	private cCOMPT    := ' '   //PD2_COMPT    NOT NULL CHAR(6)
	private cCODEMP   := ' '   //PD2_CODEMP   NOT NULL CHAR(4)
	private cMATRIC   := ' '   //PD2_MATRIC   NOT NULL CHAR(6)
	private cTPREG    := ' '   //PD2_TPREG    NOT NULL CHAR(2)
	private cDIGITO   := ' '   //PD2_DIGITO   NOT NULL CHAR(1)
	private cNOMUSR   := ' '   //PD2_NOMUSR   NOT NULL CHAR(30)
	private cCODOPE   := ' '   //PD2_CODOPE   NOT NULL CHAR(4)
	private cCODLDP   := ' '   //PD2_CODLDP   NOT NULL CHAR(4)
	private cCODPEG   := ' '   //PD2_CODPEG   NOT NULL CHAR(8)
	private cNUMERO   := ' '   //PD2_NUMERO   NOT NULL CHAR(8)
	private cORIMOV   := ' '   //PD2_ORIMOV   NOT NULL CHAR(1)
	private cSEQUEN   := ' '   //PD2_SEQUEN   NOT NULL CHAR(3)
	private cCODPAD   := ' '   //PD2_CODPAD   NOT NULL CHAR(2)
	private cCODPRO   := ' '   //PD2_CODPRO   NOT NULL CHAR(16)
	private cDESPRO   := ' '   //PD2_DESPRO   NOT NULL CHAR(50)
	private nVALOR    := 0.00  //PD2_VALOR    NOT NULL NUMBER
	private cCODRDA   := ' '   //PD2_CODRDA   NOT NULL CHAR(6)
	private cNOMRDA   := ' '   //PD2_NOMRDA   NOT NULL CHAR(30)
	private cLOTPAG   := ' '   //PD2_LOTPAG   NOT NULL CHAR(10)
	private cLOTFAT   := ' '   //PD2_LOTFAT   NOT NULL CHAR(12)
	/////////////////////
	
	Private cGetEmpres := Space(40)
	Private cGetProced := Space(30)
	Private cGetRDA    := Space(40)
	Private cGetSenha  := Space(TAMSX3("PD2_SENHA")[1]) //Angelo Henrique - Data: 12/06/19
	Private cGetUsuari := Space(50)
	Private lCBoxInt   := .T.
	Private lCBoxLib   := .F.
	private dDatlib    := ' '
	PRIVATE nSenhaAux1 := ' '
	private cProcedm   := Space(30)
	 
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Starta mBrowse...                                                   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
	±± Declaração de Variaveis Private dos Objetos                             ±±
	Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/
	SetPrvt("oDlg1","oPanel1","oSay1","oRMenu1","oCBoxInt","oCBoxLib","oGetSenha","oGrp1","oSay2","oSay3")
	SetPrvt("oSay5","oGetEmpresa","oGetUsuario","oGetRDA","oGetProcedim","oGrp2","oBtn1","oBtn2","oBtn3")
	
	If cOrigem == 1
	
  	   U_FCrgPd2() 

	//  Processa({U_FCrgPd2()},'Processando...','Buscando Dados No Servidor ...',.T.)

	Else     
  //	U_FCrgPd2(cAlias,nReg,nOpc)
       dbselectarea("PD2")
 	   PD2->(DBSetOrder(1))

	   Set Filter to TRIM(PD2->PD2_COMPTE) <> '201912'

	//PBW->(mBrowse(006,001,022,075,"PBW" , , , , , Nil    , aCores, , , ,nil, .T.))
	   PD2->(mBrowse(006,001,022,075,"PD2" , , , , , 2    , aCores, , , ,nil, .F.))
	//mBrowse(6, 1, 22, 75, "PBW",,,,,,aCores)
	   PD2->(DbClearFilter())
	   DbCloseArea()
	EndIf
 
    
Return()
user Function fAtuCust()

    U_FCrgPd2()

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
USER Function LPRO138A()
	Local aLegenda
	
	aLegenda 	:= { 	{ aCdCores[1,1],aCdCores[1,2] },;
		{ aCdCores[2,1],aCdCores[2,2] },;
		{ aCdCores[3,1],aCdCores[3,2] },;
		{ aCdCores[4,1],aCdCores[4,2] }}
	
	
	BrwLegenda(cCadastro,"Status" ,aLegenda)
	
Return

AxCadastro(cString,"Cadastro de senhas do custo administrado ",cVldExc,cVldAlt)

Return

//user Function Caba138I()
User Function Caba138I(cAlias,nReg,nOpc)
	/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
	±± Declaração de cVariable dos componentes                                 ±±
	Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/
	if nOpc == 3
		cGetEmpres := Space(40)
		cGetProced := Space(30)
		cGetRDA    := Space(40)
		cGetSenha  := Space(TAMSX3("PD2_SENHA")[1]) //Angelo Henrique - Data: 12/06/19
		cGetUsuari := Space(50)
		lCBoxInt   := .T.
		lCBoxLib   := .F.
	EndIf
	
	/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
	±± Definicao do Dialog e todos os seus componentes.                        ±±
	Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/
	oDlg1      := MSDialog():New( 225,456,512,1012,"Controle do Custo Operacional",,,.F.,,,,,,.T.,,,.T. )
	oPanel1    := TPanel():New( 000,000," ",oDlg1,,.F.,.F.,,,272,136,.T.,.F. )
	oSay1      := TSay():New( 028,004,{||"Senha "},oPanel1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
	GoRMenu1   := TGroup():New( 000,000,024,176,"Internação / Libera (S.A.D.T.)",oPanel1,CLR_BLACK,CLR_WHITE,.T.,.F. )
	oRMenu1    := TRadMenu():New( 004,006,,,oPanel1,,,CLR_BLACK,CLR_WHITE,"",,,156,24,,.F.,.F.,.T. )
	
	oCBoxInt   := TCheckBox():New( 012,008,"Senha de Internação ",{|u| If(PCount()>0,(u_zeravar() ,lCBoxInt:=u,fconsbx(lCBoxInt,'3'),oCBoxInt:refresh(),oCBoxLib:refresh()),lCBoxInt)},oPanel1,064,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
    oCBoxLib   := TCheckBox():New( 012,092,"Senha do LIbera (S.A.D.T.)",{|u| If(PCount()>0,(u_zeravar(),lCBoxLib:=u,fconsbx(lCBoxLib,'2'),oCBoxInt:refresh(),oCBoxLib:refresh()),lCBoxLib)},oPanel1,080,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
                          
    	   
    If lCBoxInt 
	   
	   oGetSenha  := TGet():New( 036,004,{|u| If(PCount()>0,cGetSenha:=u,cGetSenha)},oPanel1,092,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"BE4SEN","cGetSenha",,)		
         
    Else 
    
       oGetSenha  := TGet():New( 036,004,{|u| If(PCount()>0,cGetSenha:=u,cGetSenha)},oPanel1,092,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"BEASEN","cGetSenha",,)

    Endif    

  	   oGetSenha:Refresh()
    
//	oGetSenha  := TGet():New( 036,004,{|u| If(PCount()>0,cGetSenha:=u,cGetSenha)},oPanel1,092,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"BEASEN","cGetSenha",,)
//	oGetSenha  := TGet():New( 036,004,{|u| If(PCount()>0,cGetSenha:=u,cGetSenha)},oPanel1,092,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"BE4SEN","cGetSenha",,)
	
	oGetSenha:bLostFocus:={||fValSen(cGetSenha)}
	
	oGrp1      := TGroup():New( 052,000,136,272,"Identificação ",oPanel1,CLR_BLACK,CLR_WHITE,.T.,.F. )
	oSay2      := TSay():New( 060,004,{||"Empresa "},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
	oSay3      := TSay():New( 080,004,{||"Usuario "},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,020,008)
	oSay4      := TSay():New( 100,004,{||"RDA"},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,028,008)
	oSay5      := TSay():New( 120,004,{||"Procedimento "},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
	oGetEmpres := TGet():New( 060,037,{|u| If(PCount()>0,cGetEmpresa:=u,cGetEmpresa)},oGrp1,232,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cGetEmpresa",,)
	oGetUsuari := TGet():New( 079,037,{|u| If(PCount()>0,cGetUsuario:=u,cGetUsuario)},oGrp1,231,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cGetUsuario",,)
	oGetRDA    := TGet():New( 098,037,{|u| If(PCount()>0,cGetRDA:=u,cGetRDA)},oGrp1,231,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cGetRDA",,)
	oGetProced := TGet():New( 119,037,{|u| If(PCount()>0,cGetProcedim:=u,cGetProcedim)},oGrp1,231,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cGetProcedim",,)
	oGrp2      := TGroup():New( 000,180,052,272,"Ações",oPanel1,CLR_BLACK,CLR_WHITE,.T.,.F. )
	
	oBtn1      := TButton():New( 008,184,"&Grava",oGrp2,{||fgravaReg()},084,012,,,,.T.,,"",,,,.F. )
	oBtn2      := TButton():New( 023,184,"&Excluir",oGrp2,{||fdeletaReg()},084,012,,,,.T.,,"",,,,.F. )
	If nOpc == 3
		oBtn2:Disable()
	Else
		oBtn2:enable()
	EndIf
	oBtn3      := TButton():New( 037,184,"&Sair",oGrp2,{||oDlg1:End()},084,012,,,,.T.,,"",,,,.F. )
	
	oDlg1:Activate(,,,.T.)
	
Return

static function  fconsbx(lcheck , origem)
	
	If origem == '3'
	
//		oGetSenha  := TGet():New( 036,004,{|u| If(PCount()>0,cGetSenha:=u,cGetSenha)},oPanel1,092,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"BE4SEN","cGetSenha",,)
//		oGetSenha:Refresh()
		
	 	 If lCBoxInt //.AND. TRIM(PD2->PD2_TPSENH) == 'Internação'
			lCBoxLib:= .F.
			lCBoxInt:= .T.
		 Else
			lCBoxLib:= .T.
			lCBoxInt:= .F.
		 EndIf
			
	Else
//		oGetSenha  := TGet():New( 036,004,{|u| If(PCount()>0,cGetSenha:=u,cGetSenha)},oPanel1,092,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"BEASEN","cGetSenha",,)
//		oGetSenha:Refresh()
		
		If lCBoxLib .or. TRIM(PD2->PD2_TPSENH) == 'S.A.D.T'
			lCBoxLib:= .T.
			lCBoxInt:= .F.
	    Else
			lCBoxLib:= .F.
			lCBoxInt:= .T.
	    EndIf
			 
	EndIf
	
Return()

static function fgravaReg()
	
	If !empty(cGetSenha)
		
		dbselectarea("PD2")
		PD2->(DbSetOrder(1))
		If !(dbSeek(xFilial("PD2")+cGetSenha))
			
			PD2->(RecLock("PD2",.T.))
			PD2->PD2_FILIAL   :=	xFilial("PD2")
			PD2->PD2_TPSENH   := Iif(lCBoxLib== .T., 'S.A.D.T','Internação')
			PD2->PD2_SENHA    := (cAliastmp)->SENHA
			PD2->PD2_COMPT    := (cAliastmp)->ANOPAG+(cAliastmp)->MESPAG //cCOMPT
			PD2->PD2_CODEMP   := (cAliastmp)->CODEMP                         //cCODEMP
			PD2->PD2_MATRIC   := (cAliastmp)->MATRIC                         //cMATRIC
			PD2->PD2_TPREG    := (cAliastmp)->TIPREG                         //cTPREG
			PD2->PD2_NOMUSR   := (cAliastmp)->NOMUSR
			PD2->PD2_NOMRDA   := (cAliastmp)->NOMRDA
			PD2->PD2_CODLDP   := cCODLDP
			PD2->PD2_CODPEG   := cCODPEG
			PD2->PD2_NUMERO   := cNUMERO
			PD2->PD2_VALOR    := nVALOR
			PD2->PD2_LOTPAG   := cLOTPAG
			PD2->PD2_LOTFAT   := cLOTFAT
			PD2->PD2_CODRDA   := (cAliastmp)->CODRDA                          //cCODRDA
		    PD2->PD2_COMPTE   := (cAliastmp)->ANOPAG+(cAliastmp)->MESPAG //cCOMPT
			PD2->(MsUnlock())
			
			u_fValGuia(trim(cGetSenha),0)
			
			oDlg1:End()
			
		Else
			
			msgBox("REgistro Ja existe na base" ,"Verifique o Numero da Senha !!!!!","INFO")
			oDlg1:End()
			
		endIf
		
	EndIf
	
Return()

user  function Caba138V()

fValSen(pd2->pd2_senha)

U_CABA138I()

Return()

static function fdeletaReg()
	Local aArea   := {}
	local cSenhaux:= ' '
	If ApMsgYesNo("Deseja excluir o Registro. Deseja excluir","SIMNAO")
		cSenhaux:= trim(PD2->PD2_SENHA)
		u_FGrvBd6cop( pd2->pd2_senha , 2 )
		
		While trim(PD2->PD2_SENHA) == trim(cSenhaux)
			PD2->(RecLock("PD2",.F.))
			PD2->(DbDelete())
			PD2->(MsUnlock())
			PD2->(DbSkip())
		EndDo
	EndIf
	
	cGetEmpres := Space(40)
	cGetProced := Space(30)
	cGetRDA    := Space(40)
	cGetSenha  := Space(20)
	cGetUsuari := Space(50)
	lCBoxInt   := .T.
	CBoxLib   := .F.
	
	oDlg1:End()
	
Return()

static function fValSen(cSenha1)
	
	local ret:=.T.
	//local cAliastmp      := GetNextAlias()
	Private cQuery       := ""
	Default cSenha1      := ''
	
	IF 'CABA138V' $ PROCNAME(1) // ALTERAÇÃO 
		
		IF ALLTRIM(PD2->PD2_TPSENH) == "S.A.D.T"
			lCBoxLib := .T.
			lCBoxInt := .F. 
		ELSE
			lCBoxLib := .F.
			lCBoxInt := .T.  
		ENDIF 
		
	ENDIF  
	
	if !empty(csenha1)
		
		cGetSenha := csenha1
		
	endIf
	
	If !empty(cGetSenha)
		if lCBoxLib // valida quando a opção selecionada é liberação SADT
			
			cQuery := "       Select bea_senha SENHA ,"
			cQuery += CRLF+ " bea_codrda CODRDA, bea_nomrda NOMRDA, "
			cQuery += CRLF+ " bea_codemp CODEMP, bea_matric MATRIC, bea_tipreg TIPREG, bea_nomusr NOMUSR, "
			cQuery += CRLF+ " bg9_descri DESCEMP, "
			cQuery += CRLF+ " bea_mespag MESPAG, bea_anopag ANOPAG, "
			cQuery += CRLF+ " bea_descid DESCID , "
			cQuery += CRLF+ " bea_tipo  TIPO ,  "
			cQuery += CRLF+ " BEA_XDTLIB XDTLIB"
			cQuery += CRLF+ "  from  " + RetSqlName("BEA") +" BEA ,  "+ RetSqlName("BG9") +" BG9 "
			cQuery += CRLF+ " where BEA_filial = '"+xFilial('BEA')+ "' and BEA.d_E_L_E_T_ = ' ' "
			cQuery += CRLF+ "   AND BG9_filial = '"+xFilial('BG9')+ "' and BG9.d_E_L_E_T_ = ' ' "
			cQuery += CRLF+ "   and bg9_codigo = bea_codemp  "
			cQuery += CRLF+ "   and bea_senha = '"+cGetSenha+"' "
	 	else
			cQuery := "            Select BE4_senha SENHA,
			cQuery += CRLF+ "BE4_codrda CODRDA, BE4_nomrda NOMRDA ,
			cQuery += CRLF+ "BE4_codemp CODEMP, BE4_matric MATRIC, BE4_tipreg TIPREG, BE4_nomusr NOMUSR,
			cQuery += CRLF+ "bg9_descri DESCEMP,
			cQuery += CRLF+ "BE4_mespag MESPAG, BE4_anopag ANOPAG,
			cQuery += CRLF+ "BE4_descid DESCID, "// --,
			//	cQuery += CRLF+ "--BE4_tipo   ,
			cQuery += CRLF+ "BE4_XDTLIB  XDTLIB
			cQuery += CRLF+ "  from  " + RetSqlName("BE4") +" BE4 ,  "+ RetSqlName("BG9") +" BG9 "
			cQuery += CRLF+ "where BE4_filial = '  ' and BE4.d_E_L_E_T_ = ' '
			cQuery += CRLF+ "AND BG9_filial = '  ' and BG9.d_E_L_E_T_ = ' '
			cQuery += CRLF+ "and bg9_codigo = BE4_codemp
			cQuery += CRLF+ " and BE4_senha = '"+cGetSenha+"' "
		endif
		
		If Select((cAliastmp)) <> 0
			(cAliastmp)->(DbCloseArea())
		Endif
		
		TCQuery cQuery New Alias (cAliastmp)
		
		If (cAliastmp)->(Eof())//Select((cAliastmp)) == 0
			msgBox("Senha inexistente na base" ,"Verifique o Número da Senha !!!!!","INFO")
			oGetSenha:SetFocus()
		Else
			cGetEmpresa := (cAliastmp)->DESCEMP
			cGetUsuario := (cAliastmp)->NOMUSR
			cGetRDA     := (cAliastmp)->NOMRDA
			cGetProcedim:= (cAliastmp)->DESCID
			
			dDatlib    := (cAliastmp)->XDTLIB
			cProcedm   := (cAliastmp)->DESCID
			
			If empty(csenha1)
				fconsbx(.T. , IIF(lCBoxLib,'2','3') /*(cAliastmp)->bea_tipo */ )
				oGetEmpres :refresh()
				oGetUsuari :refresh()
				oGetRDA    :refresh()
				oGetProced :refresh()
				
			EndIf
		EndIf
	EndIf
	
Return()


user function fValGuia(cSenha1, nCont)
	
	//local  cSenha1 := cSenha
	local  cQuery       := " "
	local  cAlstmpbd6   := GetNextAlias()
	local  lPvez        := '.T.' 
	local  cskippd2     := ''
	local  adadosbd6    := {}

////////////////////////////
	
	dbselectarea("PD2")
	PD2->(DbSetOrder(1))
	
	If (dbSeek(xFilial("PD2")+cSenha1))
		
		cTpSenha:= PD2_TPSENH
		cSenha1 := PD2_SENHA
		cComp   := PD2_COMPT
		cCodEmp := PD2_CODEMP
		cMatric := PD2_MATRIC
		cTpReg  := PD2_TPREG
		cNomUsr := PD2_NOMUSR
		cCodRda := PD2_CODRDA
		cNomRda := PD2_NOMRDA

	EndIf
	
////////////////////////////////
cQuery :=        "select distinct "
cQuery += CRLF + "        BD6.BD6_CODPRO , "
cQuery += CRLF + "        BD6.BD6_DESPRO , "
cQuery += CRLF + "        BD6.bd6_qtdpro , "
cQuery += CRLF + "        BD6.Bd6_CODOPE , "
cQuery += CRLF + "        BD6.Bd6_CODLDP , "
cQuery += CRLF + "        BD6.Bd6_CODPEG , "
cQuery += CRLF + "        BD6.Bd6_NUMERO , "
cQuery += CRLF + "        BD6.Bd6_ORIMOV , "
cQuery += CRLF + "        BD6.Bd6_SEQUEN , "
cQuery += CRLF + "        BD6.Bd6_CODPAD , "
cQuery += CRLF + "        BD6.Bd6_Numlot , "
cQuery += CRLF + "        BD6.Bd6_Numfat , "
cQuery += CRLF + "        DECODE(BD6.BD6_CODLDP,'0013',BD6.BD6_VLRPAG, "
cQuery += CRLF + "        (SELECT Sum(BD7.BD7_VLRPAG) AS VLRPAG "

cQuery += CRLF + "          FROM " + RetSqlName("BD7") +" BD7  " 
cQuery += CRLF + "         WHERE BD7.BD7_FILIAL='"+xFilial('BD7')+ "' " 

cQuery += CRLF + "           and bd7.d_E_L_E_T_ = ' ' "
cQuery += CRLF + "           AND BD7.BD7_CODOPE = '0001' "
cQuery += CRLF + "           and bd7.bd7_opelot='0001' "
cQuery += CRLF + "           AND BD7.BD7_SITUAC = '1'" 
cQuery += CRLF + "           AND BD7.BD7_FASE = '4' "
cQuery += CRLF + "           AND BD7.BD7_BLOPAG <> '1'   "
cQuery += CRLF + "           AND BD7.BD7_CODLDP = BD6.BD6_CODLDP "
cQuery += CRLF + "           AND BD7.BD7_CODPEG = BD6.BD6_CODPEG "
cQuery += CRLF + "           AND BD7.BD7_NUMERO = BD6.BD6_NUMERO "
cQuery += CRLF + "           AND BD7.BD7_ORIMOV = BD6.BD6_ORIMOV "
cQuery += CRLF + "           and BD7.BD7_SEQUEN = BD6.BD6_SEQUEN ))VAL_PROC "

cQuery += CRLF + "          from " + RetSqlName("BD6")+" BD6, " + RetSqlName("BR8")+" BR8   " 
/*
cQuery += CRLF + "          (select bd6_numlot , bd6_vlrpag,bd6_vlrglo , "
cQuery += CRLF + "                  BD6_OPEUSR , "
cQuery += CRLF + "                  BD6_CODLDP , "
cQuery += CRLF + "                  BD6_CODPEG , "
cQuery += CRLF + "                  BD6_NUMERO "
cQuery += CRLF + "           from " + RetSqlName("BD6")+" BD6 "
cQuery += CRLF + "          where bd6_filial = '"+xFilial('BD6')+ "'  and d_E_L_E_T_ = ' ' "
cQuery += CRLF + "            and bd6_codemp = '"+cCodEmp+"'" 
cQuery += CRLF + "            and bd6_matric = '"+cMatric+"'" 
cQuery += CRLF + "            and bd6_tipreg = '"+cTpReg+"'"   
cQuery += CRLF + "            and bd6_numlot <> ' ' " 
if cempant == '01'
   cQuery += CRLF + "            and oBTEM_SENHA_INTER('C',BD6.BD6_CODOPE,BD6.BD6_CODLDP,BD6.BD6_CODPEG,BD6.BD6_NUMERO) = '"+cSenha1+"' )bd61 "
Else 
   cQuery += CRLF + "            and oBTEM_SENHA_INTER('I',BD6.BD6_CODOPE,BD6.BD6_CODLDP,BD6.BD6_CODPEG,BD6.BD6_NUMERO) = '"+cSenha1+"' )bd61 "
EndIf
*/    
cQuery += CRLF + "             where BD6.BD6_FILIAL='"+xFilial('BD6')+ "' "
cQuery += CRLF + "               AND BR8_FILIAL='"+xFilial('BR8')+ "' " 
cQuery += CRLF + "               AND BD6.BD6_CODPAD=br8.br8_codpad "  
cQuery += CRLF + "               AND BD6.BD6_CODPRO=BR8_CODPSA " 


cQuery += CRLF + "            and bd6_codemp = '"+cCodEmp+"'" 
cQuery += CRLF + "            and bd6_matric = '"+cMatric+"'" 
cQuery += CRLF + "            and bd6_tipreg = '"+cTpReg+"'"   
cQuery += CRLF + "            and bd6_numlot <> ' ' " 
if cempant == '01'
   cQuery += CRLF + "            and oBTEM_SENHA_INTER('C',BD6.BD6_CODOPE,BD6.BD6_CODLDP,BD6.BD6_CODPEG,BD6.BD6_NUMERO) = '"+cSenha1+"' "
Else 
   cQuery += CRLF + "            and oBTEM_SENHA_INTER('I',BD6.BD6_CODOPE,BD6.BD6_CODLDP,BD6.BD6_CODPEG,BD6.BD6_NUMERO) = '"+cSenha1+"'  "
EndIf

cQuery += CRLF + "               AND BD6.BD6_OPEUSR='0001' "
//cQuery += CRLF + "               AND BD6.BD6_OPEUSR=bd61.BD6_OPEUSR "
//cQuery += CRLF + "               AND BD6.BD6_CODLDP=bd61.BD6_CODLDP "
//cQuery += CRLF + "               AND BD6.BD6_CODPEG=bd61.BD6_CODPEG "
//cQuery += CRLF + "               AND BD6.BD6_NUMERO=bd61.BD6_NUMERO "
cQuery += CRLF + "               and not(BD6.bd6_vlrpag=0 and BD6.BD6_VLRGLO=BD6.bd6_VLRMAN) " 
cQuery += CRLF + "               AND ((BD6.BD6_CODLDP<>'0017') or (BD6.BD6_CODLDP='0017' " 
cQuery += CRLF + "               and BD6.bd6_codpro IN ('10102019','80010342'))) "
cQuery += CRLF + "               AND BD6.D_E_L_E_T_=' ' "
cQuery += CRLF + "               AND BR8.D_E_L_E_T_=' ' "



////////////////////////////////////
/*	
cQuery :=        " select V.*, "
cQuery += CRLF + "        BD6_CODPRO , "
cQuery += CRLF + "        BD6_DESPRO , "
cQuery += CRLF + "        bd6_qtdpro , "
cQuery += CRLF + "        Bd6_CODOPE , "
cQuery += CRLF + "        Bd6_CODLDP , "
cQuery += CRLF + "        Bd6_CODPEG , "
cQuery += CRLF + "        Bd6_NUMERO , "
cQuery += CRLF + "        Bd6_ORIMOV , "
cQuery += CRLF + "        Bd6_SEQUEN , "
cQuery += CRLF + "        Bd6_CODPAD , "
cQuery += CRLF + "        Bd6_Numlot , "
cQuery += CRLF + "        Bd6_Numfat , " 
                         
cQuery += CRLF + "        DECODE(BD6_CODLDP,'0013',BD6_VLRPAG, "                         
cQuery += CRLF + "       (SELECT Sum(BD7.BD7_VLRPAG) AS VLRPAG "
cQuery += CRLF + "          FROM " + RetSqlName("BD7") +" BD7  " 
cQuery += CRLF + "         WHERE BD7.BD7_FILIAL='"+xFilial('BD7')+ "' " 
cQuery += CRLF + "           AND BD7.BD7_CODOPE = '0001' "
cQuery += CRLF + "           and bd7_opelot='0001' "
cQuery += CRLF + "           AND BD7.BD7_SITUAC = '1' "
cQuery += CRLF + "           AND BD7.BD7_FASE = '4' " //TODAS AS GUIAS PAGAS
cQuery += CRLF + "           AND BD7.BD7_BLOPAG <> '1'   "
cQuery += CRLF + "           AND BD7.D_E_L_E_T_ = ' '    "
cQuery += CRLF + "           AND BD7_CODLDP = BD6_CODLDP "
cQuery += CRLF + "           AND BD7_CODPEG = BD6_CODPEG "
cQuery += CRLF + "           AND BD7_NUMERO = BD6_NUMERO "
cQuery += CRLF + "           AND BD7_ORIMOV = BD6_ORIMOV "
cQuery += CRLF + "           and BD7_SEQUEN = BD6_SEQUEN ))VAL_PROC "
cQuery += CRLF + "          from V_CUSTO_INTERN_CONSOL V, " + RetSqlName("BD6")+" BD6, " + RetSqlName("BR8")+" BR8 " 

cQuery += CRLF + "         where senha= '"+cSenha1+"'

cQuery += CRLF + "           AND BD6_FILIAL='"+xFilial('BD6')+ "' " 
cQuery += CRLF + "           AND BR8_FILIAL='"+xFilial('BR8')+ "' " 
cQuery += CRLF + "           AND BD6_CODPAD=br8.br8_codpad "
cQuery += CRLF + "           AND BD6_CODPRO=BR8_CODPSA "
cQuery += CRLF + "           AND BD6_OPEUSR='0001' "
IF cEmpant == "02"
   cQuery += CRLF + "           AND EMPRESA_GRUPO='INTEGRAL' "
Else    
   cQuery += CRLF + "           AND EMPRESA_GRUPO='CABERJ' "
EndIf    

cQuery += CRLF + "           AND BD6_OPEUSR=SUBSTR(GUIA, 1,4) "  
cQuery += CRLF + "           AND BD6_CODLDP=SUBSTR(GUIA, 5,4) "
cQuery += CRLF + "           AND BD6_CODPEG=SUBSTR(GUIA, 9,8) " 
cQuery += CRLF + "           AND BD6_NUMERO=SUBSTR(GUIA,17,8) "     
cQuery += CRLF + "           and not(bd6_vlrpag=0 and BD6_VLRGLO=bd6_VLRMAN) "
cQuery += CRLF + "           AND BD6_YNEVEN=v.cod_evento "
//cQuery += CRLF + "         AND BR8_YCAPIT <> '1'--CAPTATION 
cQuery += CRLF + "           AND ((BD6_CODLDP<>'0017') or (BD6_CODLDP='0017' "
cQuery += CRLF + "           and bd6_codpro IN ('10102019','80010342'))) "

//cQuery += CRLF + "           and bd6_codpro = ('40403173') "

cQuery += CRLF + "           AND FASE='FATURADA' " 

cQuery += CRLF + "           AND DECODE(BR8_TPPROC,'0','PROCEDIMENTO','1','MATERIAL','2','MEDICAMENTO','3','TAXAS', "
cQuery += CRLF + "               '4',DECODE(INSTR(BR8_DESCRI,'ACOMPANHANTE'),0,'DIARIAS','DIARIA ACOMP'),'5','OPME','6','PACOTES','7','GASES MEDICINAIS','8','ALUGUEIS','PROCEDIMENTO')= TIPPROC "
cQuery += CRLF + "          AND DECODE(BR8_YTPITM,'D','DIARIAS/TAXAS','E','EXAMES','G','GASES','H','HM','M','MATERIAIS','R','MEDICAMENTOS','HM')=TIPITEM "
//cQuery += CRLF + "          and DECODE(OBTER_CUSTO_GR_INT(OBTER_SENHA_INT(BD6_CODOPE,BD6_CODLDP,BD6_CODPEG,BD6_NUMERO),BD6_DATPRO,BD6_DESPRO),0,'UTI',1,'APARTAMENTO',2,'ENFERMARIA',3,'DAY','APARTAMENTO') =ACOMOD "
cQuery += CRLF + "          and DECODE(OBTER_CUSTO_GR_INT(OBTEM_SENHA_INTER("+Iif(cEmpAnt == "01","'C'","'I'")+",BD6_CODOPE,BD6_CODLDP,BD6_CODPEG,BD6_NUMERO),BD6_DATPRO,BD6_DESPRO),0,'UTI',1,'APARTAMENTO',2,'ENFERMARIA',3,'DAY','APARTAMENTO') =ACOMOD "
cQuery += CRLF + "          AND BD6.D_E_L_E_T_=' ' "
cQuery += CRLF + "          AND BR8.D_E_L_E_T_=' ' "
	
*////////////////////

	
	If Select((cAlstmpbd6)) <> 0
		(cAlstmpbd6)->(DbCloseArea())
	Endif
	
	TCQuery cQuery New Alias (cAlstmpbd6)
	
	(cAlstmpbd6)->(dbGoTop())
/*	
	dbselectarea("PD2")
	PD2->(DbSetOrder(1))
	
	If (dbSeek(xFilial("PD2")+cSenha1))
		
		cTpSenha:= PD2_TPSENH
		cSenha1 := PD2_SENHA
		cComp   := PD2_COMPT
		cCodEmp := PD2_CODEMP
		cMatric := PD2_MATRIC
		cTpReg  := PD2_TPREG
		cNomUsr := PD2_NOMUSR
		cCodRda := PD2_CODRDA
		cNomRda := PD2_NOMRDA

	EndIf
*/	
	while !(cAlstmpbd6)->(Eof())
		/*
		
		cCODOPE :=(cAlstmpbd6)->Bd6_CODOPE
		cCODLDP :=(cAlstmpbd6)->Bd6_CODLDP
		cCODPEG :=(cAlstmpbd6)->Bd6_CODPEG
		cNUMERO :=(cAlstmpbd6)->Bd6_NUMERO
		cORIMOV :=(cAlstmpbd6)->Bd6_ORIMOV
		cSEQUEN :=(cAlstmpbd6)->Bd6_SEQUEN
		cCODPAD :=(cAlstmpbd6)->Bd6_CODPAD
		cCODPRO :=(cAlstmpbd6)->Bd6_CODPRO
		cLOTPAG :=(cAlstmpbd6)->Bd6_Numlot
		cLOTFAT :=(cAlstmpbd6)->Bd6_Numfat
		nVALOR  :=(cAlstmpbd6)->VAL_PROC
		*/

     If (cAlstmpbd6)->Bd6_CODLDP <> '0000'		    

// altamiro 040819
		
	dbselectarea("PD2")
	PD2->(DbSetOrder(2))
          If dbSeek(xFilial("PD2")+;
                   (cAlstmpbd6)->Bd6_CODOPE+;
                   (cAlstmpbd6)->Bd6_CODLDP+;
                   (cAlstmpbd6)->Bd6_CODPEG+;
                   (cAlstmpbd6)->Bd6_NUMERO+;
                   (cAlstmpbd6)->Bd6_ORIMOV+;
                   (cAlstmpbd6)->Bd6_SEQUEN+;
                   (cAlstmpbd6)->Bd6_CODPAD+;
                   (cAlstmpbd6)->Bd6_CODPRO)		  			
///
        
/*           If (PD2->PD2_CODOPE  == (cAlstmpbd6)->Bd6_CODOPE .AND. ;
		       PD2->PD2_CODLDP  == (cAlstmpbd6)->Bd6_CODLDP .AND. ;
			   PD2->PD2_CODPEG  == (cAlstmpbd6)->Bd6_CODPEG .AND. ;
			   PD2->PD2_NUMERO  == (cAlstmpbd6)->Bd6_NUMERO .AND. ;
			   PD2->PD2_ORIMOV  == (cAlstmpbd6)->Bd6_ORIMOV .AND. ;
			   PD2->PD2_SEQUEN  == (cAlstmpbd6)->Bd6_SEQUEN .AND. ;
			   PD2->PD2_CODPAD  == (cAlstmpbd6)->Bd6_CODPAD .AND. ;
			   PD2->PD2_CODPRO  == (cAlstmpbd6)->Bd6_CODPRO )*/ 

	       //If  (dbSeek(xFilial("PD2")+(cAlstmpbd6)->Bd6_CODOPE+(cAlstmpbd6)->Bd6_CODLDP+(cAlstmpbd6)->Bd6_CODPEG+(cAlstmpbd6)->Bd6_NUMERO+(cAlstmpbd6)->Bd6_ORIMOV+(cAlstmpbd6)->Bd6_SEQUEN+(cAlstmpbd6)->Bd6_CODPAD+(cAlstmpbd6)->Bd6_CODPRO))		  			
   		   
   			   If !empty((cAlstmpbd6)->Bd6_Numlot)  .and.  empty((cAlstmpbd6)->Bd6_Numfat)
				
			      adadosbd6 := U_FGrvBd6cop( (xFilial("BD6")+(cAlstmpbd6)->Bd6_CODOPE+(cAlstmpbd6)->Bd6_CODLDP+(cAlstmpbd6)->Bd6_CODPEG+(cAlstmpbd6)->Bd6_NUMERO+(cAlstmpbd6)->Bd6_ORIMOV+(cAlstmpbd6)->Bd6_SEQUEN+(cAlstmpbd6)->Bd6_CODPAD+(cAlstmpbd6)->Bd6_CODPRO), 1, (cAlstmpbd6)->Bd6_Numlot )
				
		       EndIf
			
			    PD2->(RecLock("PD2",.F.))
			
			    PD2->PD2_LOTPAG :=(cAlstmpbd6)->Bd6_Numlot
			    PD2->PD2_LOTFAT :=(cAlstmpbd6)->Bd6_Numfat
			    PD2->PD2_VALOR  :=(cAlstmpbd6)->VAL_PROC
			
			    PD2->(MsUnlock())
			  
  		        PD2->(DbSkip()) 
   	 //	        (cAlstmpbd6)->(DbSkip())
   		        
		   ElseIf trim(PD2->PD2_CODPEG) == ''                        
		       If  !empty( PD2->PD2_TPSENH)
                    PD2->(RecLock("PD2",.F.))		        
                    cskippd2:='S'
               Else 
                    PD2->(RecLock("PD2",.T.))
                    cskippd2:='N'
                    PD2->PD2_TPSENH  := cTpSenha
		            PD2->PD2_SENHA   := cSenha1 
		            PD2->PD2_COMPT   := cComp  
   		            PD2->PD2_CODEMP  := cCodEmp
		            PD2->PD2_MATRIC  := cMatric 
		            PD2->PD2_TPREG   := cTpReg
		            PD2->PD2_NOMUSR  := cNomUsr
		            PD2->PD2_CODRDA  := cCodRda
		            PD2->PD2_NOMRDA  := cNomRda
		       EndIF 		

		       PD2->PD2_CODOPE  := (cAlstmpbd6)->Bd6_CODOPE
		       PD2->PD2_CODLDP  := (cAlstmpbd6)->Bd6_CODLDP
		       PD2->PD2_CODPEG  := (cAlstmpbd6)->Bd6_CODPEG
		       PD2->PD2_NUMERO  := (cAlstmpbd6)->Bd6_NUMERO
		       PD2->PD2_ORIMOV  := (cAlstmpbd6)->Bd6_ORIMOV
		       PD2->PD2_SEQUEN  := (cAlstmpbd6)->Bd6_SEQUEN
		       PD2->PD2_CODPAD  := (cAlstmpbd6)->Bd6_CODPAD
		       PD2->PD2_CODPRO  := (cAlstmpbd6)->Bd6_CODPRO
		       PD2->PD2_DESPRO  := (cAlstmpbd6)->Bd6_DESPRO 
				 
   		       PD2->PD2_LOTPAG  :=(cAlstmpbd6)->Bd6_Numlot
		       PD2->PD2_LOTFAT  :=(cAlstmpbd6)->Bd6_Numfat
              
		    If !empty(PD2->PD2_LOTPAG )  .and.  empty(PD2->PD2_LOTFAT)
					
			   adadosbd6 := U_FGrvBd6cop( (xFilial("BD6")+(cAlstmpbd6)->Bd6_CODOPE+(cAlstmpbd6)->Bd6_CODLDP+(cAlstmpbd6)->Bd6_CODPEG+(cAlstmpbd6)->Bd6_NUMERO+(cAlstmpbd6)->Bd6_ORIMOV+(cAlstmpbd6)->Bd6_SEQUEN+(cAlstmpbd6)->Bd6_CODPAD+(cAlstmpbd6)->Bd6_CODPRO) , 1, (cAlstmpbd6)->Bd6_Numlot)
					
		    EndIf
				
			   PD2->PD2_LOTPAG :=(cAlstmpbd6)->Bd6_Numlot
			   PD2->PD2_LOTFAT :=(cAlstmpbd6)->Bd6_Numfat
			   PD2->PD2_VALOR  :=(cAlstmpbd6)->VAL_PROC
				
			   PD2->(MsUnlock())

			   If cskippd2 =='S'	
                  PD2->(DbSkip()) 
               EndIf    	 
   	   Else 	   
   	       If !empty(PD2->PD2_LOTPAG )  .and.  empty(PD2->PD2_LOTFAT)
					
//			   U_FGrvBd6cop( (xFilial("BD6")+(cAlstmpbd6)->Bd6_CODOPE+(cAlstmpbd6)->Bd6_CODLDP+(cAlstmpbd6)->Bd6_CODPEG+(cAlstmpbd6)->Bd6_NUMERO+(cAlstmpbd6)->Bd6_ORIMOV+(cAlstmpbd6)->Bd6_SEQUEN+(cAlstmpbd6)->Bd6_CODPAD+(cAlstmpbd6)->Bd6_CODPRO) , 1)
  			  adadosbd6:= U_FGrvBd6cop( (xFilial("BD6")+PD2->PD2_CODOPE+PD2->PD2_CODLDP+PD2->PD2_CODPEG+PD2->PD2_NUMERO+PD2->PD2_ORIMOV+PD2->PD2_SEQUEN+PD2->PD2_CODPAD+PD2->PD2_CODPRO), 1) 
       //aadd(adadobd6,{BD6->BD6_VLRACB , BD6->BD6_VLRPAG ,BD6->BD6_VLRBPF , BD6->BD6_VLRTPF , BD6->BD6_VLRPF,BD6->BD6_NUMLOT,BD6->BD6_NUMFAT})  
		    EndIf
		    
		       PD2->(RecLock("PD2",.F.))		        
				
			   PD2->PD2_LOTPAG :=(cAlstmpbd6)->Bd6_Numlot
			   PD2->PD2_LOTFAT :=(cAlstmpbd6)->Bd6_Numfat
			   PD2->PD2_VALOR  :=(cAlstmpbd6)->VAL_PROC
				
			   PD2->(MsUnlock())

               PD2->(DbSkip()) 		   
               
	     EndIf	
	EndIf     
		           	
	(cAlstmpbd6)->(DbSkip())
		
	EndDo
	cSenhaux:= nSenhaAux1
   If lfaz //.and. PD2->PD2_LOTFAT = ' ' 
//	  fMonEmail(cUsuario , nValor , cSenhaux , cProcd , cCompt1)
      fMonEmail(cUsuario , nValor , pd2->PD2_Senha , cProcd , cCompt1)
   EndIf     
   
   lfaz     := .F.
   adadobd6 :={}
	
   cCODPEG     :=' '
   cNUMERO     :=' '
   cCODLDP     :=' '
   nVALOR      := 0.00
   cLOTPAG  :=' '
   cLOTFAT  :=' '
  
  (cAlstmpbd6)->(DbCloseArea())
	
Return()

user Function FGrvBd6cop(cChvbd6 , opc, numlot)
	
//	local lfaz     := .F.
//	local cUsuario := ' '
	local nValor   := 0.00
	local cProcd   := ' '
	
//	local adadobd6 :={}
	
	DbSelectArea("BD6")
	DbSetOrder(1)
	If DbSeek(cChvbd6)
//		While (cChvbd6)  
		While (xFilial("BD6")+BD6->Bd6_CODOPE+BD6->Bd6_CODLDP+BD6->Bd6_CODPEG+BD6->Bd6_NUMERO+BD6->Bd6_ORIMOV+BD6->Bd6_SEQUEN+BD6->Bd6_CODPAD+BD6->Bd6_CODPRO);
           == (XFILIAL("PD2")+PD2->PD2_CODOPE+PD2->PD2_CODLDP+PD2->PD2_CODPEG+PD2->PD2_NUMERO+PD2->PD2_ORIMOV+PD2->PD2_SEQUEN+PD2->PD2_CODPAD+PD2->PD2_CODPRO)
			If  (((BD6->BD6_VLRTPF != BD6->BD6_VLRPAG .and. trim(bd6->bd6_numfat) == '') ;
			 .or. (fValSe1(trim(bd6->bd6_numfat)) .and. opc != 1)) ;
			 .and. (fValFec(bd6->bd6_numlot)))   
			
				RecLock("BD6",.F.)
				If opc == 1
			   	   BD6->BD6_VLRACB := BD6->BD6_VLRPAG
				   BD6->BD6_VLRBPF := BD6->BD6_VLRPAG
				   BD6->BD6_VLRTPF := BD6->BD6_VLRPAG
				   BD6->BD6_VLRPF  := BD6->BD6_VLRPAG 
				   if lfaz     == .F.
                      lfaz     := .T.
                   EndIf    
				   BD6->BD6_DESBPG := 'Cobr.c/oper.da senha '+pd2->PD2_Senha+' , p/ empr'
			    Else
			       BD6->BD6_VLRACB := 0
				   BD6->BD6_VLRBPF := 0
				   BD6->BD6_VLRTPF := 0
				   BD6->BD6_VLRPF  := 0
				   if lfaz     == .F.
                      lfaz     := .T.
                   EndIf    	   
				   BD6->BD6_DESBPG := " "
			    EndIf 
			    cUsuario := BD6->bd6_opeusr +'.'+BD6->bd6_codemp+'.'+BD6->bd6_matric +'-'+BD6->bd6_tipreg+'-'+BD6->bd6_digito+' - '+ trim(bd6_nomusr)
		     	nValor   += BD6->BD6_VLRTPF
		    	cProcd   += BD6->BD6_despro+ CRLF
	    		cCompt1  := substr(BD6->BD6_numlot,1,4)+'/'+substr(BD6->BD6_numlot,5,2)
		    	BD6->(MsUnlock())
			
		   EndIf
		aadd(adadobd6,{BD6->BD6_VLRACB ,;
		               BD6->BD6_VLRPAG ,;
		               BD6->BD6_VLRBPF ,;
		               BD6->BD6_VLRTPF ,;
		               BD6->BD6_VLRPF  ,;
		               BD6->BD6_NUMLOT ,;
		               BD6->BD6_NUMFAT ,;
		               trim(BD6->bd6_codpro) +'-'+ trim(BD6->bd6_despro)          ,; 
		               nValor}) 
		bd6->(DbSkip())
	    EndDo
	
    EndIf

If lfaz
//    MonEmail(cUsuario , nValor , cSenhaux , cProcd , cCompt1)
	fMonEmail(cUsuario , nValor , pd2->PD2_Senha , cProcd , cCompt1)
EndIf     
//lfaz     := .T.
return(adadobd6)

user Function FCrgPd2()
	
	local  cQuery       := " "
	local  cAlstmppd2   := GetNextAlias()
	
	cQuery := "       Select DISTINCT PD2_SENHA  "
	cQuery += CRLF + "  From " + RetSqlName("PD2") +" PD2   "
	cQuery += CRLF + " Where pd2_Filial = '"+xFilial('PD2')+ "'  And  pd2.D_E_L_E_T_ = ' ' "

  //  cQuery += CRLF + " AND PD2_SENHA = '74354798645599943599'  "  // teste de uma senha especifica 

	//cQuery += CRLF + " and (pd2_codpeg = ' ' or pd2_lotpag = ' ' or pd2_lotfat = ' ' ) "
	
	If Select((cAlstmppd2)) <> 0
		(cAlstmppd2)->(DbCloseArea())
	Endif
	
	TCQuery cQuery New Alias (cAlstmppd2)
	
	(cAlstmppd2)->(dbGoTop())
	
	 While !(cAlstmppd2)->(Eof())  
		/*
		cTpSenha2:= PD2_TPSENH
		cSenha2  := PD2_SENHA
		cComp2   := PD2_COMPT
		cCodEmp2 := PD2_CODEMP
		cMatric2 := PD2_MATRIC
		cTpReg2  := PD2_TPREG
		cNomUsr2 := PD2_NOMUSR
		cCodRda2 := PD2_CODRDA
		cNomRda2 := PD2_NOMRDA
		*/
		nSenhaAux1 :=trim((cAlstmppd2)->PD2_Senha)
		u_fValGuia(trim((cAlstmppd2)->PD2_Senha), 1)  
		
	//	u_fValGuia(trim('053052911'), 1)
		   
		
	   (cAlstmppd2)->(DbSkip()) 
		
	EndDo 
	
return()   

static function fValSe1(numfat)

local lRet   := .F.
local cQuery := ' ' 

	cQuery := CRLF + "select e1_baixa "
	cQuery += CRLF + "  From " + RetSqlName("BD6") +" BD6 , " + RetSqlName("SE1") +" SE1 "
    cQuery += CRLF + " Where Bd6_Filial = '"+xFilial('BD6')+"' And  BD6.D_E_L_E_T_ = ' ' " 
  	cQuery += CRLF + "   and  E1_Filial = '"+xFilial('SE1')+"' And  SE1.D_E_L_E_T_ = ' ' "
  	cQuery += CRLF + "   and bd6_prefix = e1_prefixo "
  	cQuery += CRLF + "   and bd6_numtit = e1_num     "
  	cQuery += CRLF + "   and bd6_parcel = e1_parcela "
  	cQuery += CRLF + "   and bd6_tiptit = e1_tipo    "
  	cQuery += CRLF + "   and bd6_numfat = '"+numfat+"'"       
  	  	
	If Select((cAliasSe1)) <> 0
	   (cAliasSe1)->(DbCloseArea())
	Endif
		
		TCQuery cQuery New Alias (cAliasSe1)
		
		lRet:= IIf (trim((cAliasSe1)->e1_baixa)=='',.T.,.F.)
  	
Return(lret)  	

//////////////////////////
static function fVlrBd7(cCODOPE,cCODLDP,cCODPEG,cNUMERO,cORIMOV,cSEQUEN,cCODPRO)

local lRet   := .F.
local cQuery := ' ' 

 	cQuery := CRLF + "Select nvl(sum(bd7_vlrpag),0) vlrpgBd7"
    cQuery += CRLF + "  From " + RetSqlName("BD7") +" BD7  "	 
    cQuery := CRLF + " Where BD7_FILIAL = '"+xFilial('BD6')+"' And D_E_L_E_T_ = ' ' "            
    cQuery += CRLF + "   And  BD7_CODOPE = cCODOPE "          
    cQuery += CRLF + "   And  BD7_CODLDP = cCODLDP "         
    cQuery += CRLF + "   And  BD7_CODPEG = cCODPEG "          
    cQuery += CRLF + "   And  BD7_NUMERO = cNUMERO "          
    cQuery += CRLF + "   And  BD7_ORIMOV = cORIMOV "          
    cQuery += CRLF + "   And  BD7_SEQUEN = cSEQUEN "          
    cQuery += CRLF + "   And  BD7_CODPRO = cCODPRO "

	If Select((cAliasbd7)) <> 0
	   (cAliasbd7)->(DbCloseArea())
	Endif
		
		TCQuery cQuery New Alias (cAliasBd7)
  	
Return((cAliasbd7)->vlrpgBd7)  	

//////////////////////////



////////////////////////////////
static function fMonEmail(cUsuario , nValor , cSenhaux, cProcd , cCompt1  )
	
	local cDest := ' '
	Local _cMensagem := ""
	local ccCC := ''
	local aDados:={}
	
	PRIVATE cAssunto  := "Solicitação de consolidação da cobrança "
	cAssunto  += " - Cobrança do Custo Operacional "
	
	
	aAdd(aDados,{"altamiro@caberj.com.br"})
	//  aAdd(aDados,{"piumbim@caberj.com.br"})
	//   aAdd(aDados,{"elina.cabral@caberj.com.br"})
	//   aAdd(aDados,{"alan.jefferson@caberj.com.br"})
	//  aAdd(aDados,{"esther.melo@caberj.com.br"})
	//  aAdd(aDados,{"carlos.santos@caberj.com.br"})
	
	for I:=1 to len(aDados)
		
		EnvEm138(fBcoEmail(aDados ,cUsuario , nValor, cSenhaux , 1 , cProcd , cCompt1  ) , adados[I,1] , cAssunto)

	Next
	
	cAssunto  := "Comunicado de cobrança "
	cAssunto  += " - Cobrança do Custo Operacional "
	adados    := {}
	
	aAdd(aDados,{"altamiro@caberj.com.br"})
	//  aAdd(aDados,{"alan.jefferson@caberj.com.br"})
	
	//  aAdd(aDados,{"piumbim@caberj.com.br"})
	//  aAdd(aDados,{"carlacravo@a4administradora.rio.br"})
	//  aAdd(aDados,{"armandogentil@caberj.com.br"})
	//  aAdd(aDados,{"eduardo.pierro@caberj.com.br"})
	
	for I:=1 to len(aDados)
		
		EnvEm138(fBcoEmail(aDados ,cUsuario , nValor, cSenhaux , 2 , cProcd , cCompt1) , adados[I,1] , cAssunto)
	   	  
	Next
	
Return()

STATIC FUNCTION fBcoEmail(aDados ,cUsuario , nValor , cSenha1, nOpcao , cProcd , cCompt1 )
	
	local cEmCopia   := ' '
	local cMatcab    := ' '
	local cMatemp    := ' '

	local   _cMensagem := ""
	local   _cMensag1  := ""
	local   _cMensag2  := ""
	local   _cMensag3  := ""
	local   _cMensag4  := ""
	local   cCompt12   := substr(BD6->BD6_numlot,1,4)+'/'+substr(BD6->BD6_numlot,5,2)
	
	fValSen(cSenha1)
	
	for Ind := 1 to len(adados)
		cEmCopia+= adados[Ind,1] +' , '
	next
	nValor:= 0
	for I:=1 to len(adadobd6)
		
	nValor+=adadobd6[I,4]
	
	Next 
	
	cMatcab:= SUBSTR(cUsuario,1,4)+SUBSTR(cUsuario,6,4)+SUBSTR(cUsuario,11,6)+SUBSTR(cUsuario,18,2)+SUBSTR(cUsuario,21,1)
	cMatEMP:= POSICIONE("BA1",2,XFILIAL("BA1")+cMatcab,"BA1_MATEMP")
	
	_cMensag1:=  Chr(13) + Chr(10) +  Chr(13) + Chr(10)+ "Prezados ,  "
	_cMensag2:=  Chr(13) + Chr(10) +  "Solicitamos a consolidação da cobrança para a empresa  "
	_cMensag3:=  Chr(13) + Chr(10) +  "Informamos a Cobrança da(s) despesas para a empresa  "
	_cMensag4:=  Chr(13) + Chr(10) +  (cAliastmp)->DESCEMP //substr(cUsuario,6,4) +' - ' +GetAdvFVal("BG9","BG9_DESCRI",xFilial("BG9")+'0001'+(substr(cUsuario,6,4)),1)
	_cMensag4+=  Chr(13) + Chr(10) +  " no valor de R$"+  Transform(nValor, "@E 999,999,999.99")
	_cMensag4+=  Chr(13) + Chr(10) +  " do usuario  "+(cAliastmp)->nomusr  + " - Matricula na Empresa "+ (cAliastmp)->matric+'-'+(cAliastmp)->TIPREG
/*	_cMensag4+=  Chr(13) + Chr(10) +  " Procedimento(s) : "
	
	_cMensag4+=  Chr(13) + Chr(10)
	
	for I:=1 to len(adadobd6)
		
	   _cMensag4+=  Chr(13) + Chr(10) + adadobd6[I,8]
    
	Next */
	// _cMensagem4+=  Chr(13) + Chr(10) +  " Procedimento  "+ GetAdvFVal("BEA","BEA_DESCID",xFilial("BEA")+cSenha,14)
	// _cMensagem4+=  Chr(13) + Chr(10) +  " Senha   "+cSenha  +"  , data da Liberação "+StoD(GetAdvFVal("BEA","BEA_XDTLIB",xFilial("BEA")+cSenha,14))
	_cMensag4+=  Chr(13) + Chr(10) +  " Senha   "+cSenha1  +"  , data da Liberação "+substr(dDatlib,7,2)+'/'+substr(dDatlib,5,2)+'/'+substr(dDatlib,1,4)
	_cMensag4+=  Chr(13) + Chr(10) +  " Competencia "+cCompt12
	_cMensag4+=  Chr(13) + Chr(10) + Chr(13) + Chr(10)+ 'Ps.: Em Copia :' + cEmCopia
	_cMensag4+=  Chr(10) + Chr(13) + Chr(10) + Chr(13)+ Chr(10) + Chr(13) + Chr(10) + Chr(13)+"                    Rio de Janeiro , " +  DtoC( Date() )
	
	If nOpcao == 1
		_cMensagem:= _cMensag1+_cMensag2+_cMensag4
	EndIf
	If nOpcao == 2
		_cMensagem:= _cMensag1+_cMensag3+_cMensag4
	EndIf
	
return(_cMensagem)

user function zeravar() 
	
	cGetEmpres := Space(40)
	cGetProced := Space(30)
	cGetRDA    := Space(40)
	cGetSenha  := Space(20)
	cGetUsuari := Space(50)

	oGetSenha:Refresh()
	oGetEmpres:Refresh() 
	oGetUsuari:Refresh() 
	oGetRDA:Refresh()   
	oGetProced:Refresh()

Return()
          
static Function EnvEm138(_cMensagem , cDest , cAssunto )
                                          
/*Local _cMailServer := GetMv( "MV_WFSMTP" )
Local _cMailConta  := GetMv( "MV_WFAUTUS" )
Local _cMailSenha  := GetMv( "MV_WFAUTSE" )                        */
Local _cMailServer := GetMv( "MV_RELSERV" )
Local _cMailConta  := GetMv( "MV_EMCONTA" )
Local _cMailSenha  := GetMv( "MV_EMSENHA" ) 

//Local _cTo  	 := "altamiro@caberj.com.br, paulovasques@caberj.com.br, piumbim@caberj.com.br"
Local _cTo  	     := cDest //"altamiro@caberj.com.br "
Local _cCC         := " "  //GetMv( "MV_WFFINA" )
//Local _cAssunto   := " Liberação de Pagamento Por Alçada "
Local _cAssunto    := cAssunto
Local _cError      := ""
Local _lOk         := .T.
Local _lSendOk     := .F.
local cto_         := ' '

//_cTo+= cDest

If !Empty( _cMailServer ) .And. !Empty( _cMailConta  ) 
	// Conecta uma vez com o servidor de e-mails
	CONNECT SMTP SERVER _cMailServer ACCOUNT _cMailConta PASSWORD _cMailSenha RESULT _lOk

	If _lOk
		SEND MAIL From _cMailConta To _cTo /*BCC _cCC  */ Subject _cAssunto Body _cMensagem  Result _lSendOk
	Else
		//Erro na conexao com o SMTP Server
		GET MAIL ERROR _cError
     	Aviso( "Erro no envio do E-Mail", _cError, { "Fechar" }, 2 )   
	EndIf

    If _lOk       
    	//Desconecta do Servidor
      	DISCONNECT SMTP SERVER  
    EndIf
EndIf
return()  
 
/////////////////////////////////

STATIC Function fValFec(numlot) 

    local  AnoLot       := substr(numlot,1,4)
	local  MesLot       := substr(numlot,5,2)
    local  cQuery       := " "
	
	cQuery := "       Select *  "
	cQuery += CRLF + "  From " + RetSqlName("SZ9") +" SZ9 "
	cQuery += CRLF + " Where Z9_Filial = '"+xFilial('SZ9')+ "'  And  SZ9.D_E_L_E_T_ = ' ' "

	cQuery += CRLF + " AND Z9_ANOCTB = '"+AnoLot+"'  "  // Ano teste  
    cQuery += CRLF + " AND Z9_MESCTB = '"+MesLot+"'  "  // Mes teste  
	
	If Select((cAlstmpSZ9)) <> 0
		(cAlstmpSZ9)->(DbCloseArea())
	Endif
	
	TCQuery cQuery New Alias (cAlstmpSZ9)
	
	(cAlstmpSZ9)->(dbGoTop())

	//If trim((cAlstmpSZ9)->Z9_FECHOU) == 'N'
	 
	Return(trim((cAlstmpSZ9)->Z9_FECHOU) == 'N')


/////////////////////////////////
