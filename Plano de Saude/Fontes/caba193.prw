#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'RWMAKE.CH'
#INCLUDE 'FONT.CH'
#INCLUDE 'COLORS.CH'
#Include 'PLSMGER.CH'
#include "PLSMGER2.CH"
#include "PLSMCCR.CH"                                               
#include "topconn.ch"  
#INCLUDE "TOTVS.CH"    
#INCLUDE 'UTILIDADES.CH'
/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³         ³ Autor ³                       ³ Data ³           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Locacao   ³                  ³Contato ³                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³  lançamento de credito em comissao                         ³±±
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
 
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABA409   ºAutor  ³ Altamiro	         º Data ³  19/06/2015 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Tela de browser de controlem de edição                     º±±
±±º          ³ 															  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function caba193()                 

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta matriz com as opcoes do browse...                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE aRotina	:=	{	{ "&Visualizar"	, "U_Caba193A"		, 0 , 1	 },; 
				     	{ "&Alteracao"	, "U_Caba193A"		, 0 , 2  },;
                        { "&Incluir"	, "U_Caba193A"		, 0 , 3	 },;
                        { "Legenda"		, "U_LEG193"	    , 0 , 3	 }}  
						
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Titulo e variavies para indicar o status do arquivo                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE cCadastro	:= "Browser de Lançamentos de Credito ou Debitos na Comissao "

PRIVATE aCdCores	:= { 	{ 'BR_VERDE'    ,'Aprovada'      },;
							{ 'BR_AZUL'     ,'Revisada'      },; 
							{ 'BR_VERMELHO' ,'Lançado'      },;							
							{ 'BR_AMARELO'  ,'Incluida'      },;
							{ 'BR_PRETO'    ,'Excluida'      }}

PRIVATE aCores	:= {{'trim(PE9_SITUAC)=="Aprovada"', aCdCores[1,1]},;
                    {'trim(PE9_SITUAC)=="Revisada"', aCdCores[2,1]},;
                    {'trim(PE9_SITUAC)=="Lançado"' , aCdCores[3,1]},;
					{'trim(PE9_SITUAC)=="Incluida"', aCdCores[2,1]},;
					{'trim(PE9_SITUAC)=="Excluida"', aCdCores[4,1]} }
//PRIVATE cPath  := ""                        
PRIVATE cAlias := "PE9" 

PRIVATE cPerg	:= "CABA193"

PRIVATE cNomeProg   := "CABA193"
PRIVATE nQtdLin     := 68
PRIVATE nLimite     := 132
PRIVATE cControle   := 15
PRIVATE cTamanho    := "G"
PRIVATE cTitulo     := "Lançamento de Creditos e Debitos na Comissao "
PRIVATE cDesc1      := ""
PRIVATE cDesc2      := ""
PRIVATE cDesc3      := ""
PRIVATE nRel        := "caba193"
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
PRIVATE cCabec1     := "Lançamento de Creditos e Debitos na Comissao "
PRIVATE cCabec2     := ""
PRIVATE nColuna     := 00
Private cFiltro     := ' '

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Starta mBrowse...                                                   ³         
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ     
dbselectarea("PE9")
PE9->(DBSetOrder(1))


//PE9->(mBrowse(006,001,022,075,"PE9" , , , , , Nil    , aCores, , , ,nil, .T.))  
PE9->(mBrowse(006,001,022,075,"PE9" , , , , , 2    , aCores, , , ,nil, .F.)) 
//mBrowse(6, 1, 22, 75, "PE9",,,,,,aCores)
PE9->(DbClearFilter())
DbCloseArea()
Return()
              
a:='b'

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
User Function LEG193()
Local aLegenda

	aLegenda 	:= { 	{ aCdCores[1,1],aCdCores[1,2] },;
						{ aCdCores[2,1],aCdCores[2,2] },;
						{ aCdCores[3,1],aCdCores[3,2] },;
	              		{ aCdCores[4,1],aCdCores[4,2] },;
	              		{ aCdCores[5,1],aCdCores[5,2] } }

	                     	
BrwLegenda(cCadastro,"Status" ,aLegenda)

Return


/////////
User Function caba193A(cAlias,nReg,nOpc)     

/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±± Declaração de cVariable dos componentes                                 ±±
Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/

Private cCodEmp    := Space(6)
Private cCompte    := Space(7)
Private cHist     
Private cJustif    := Space(200)
Private cNomEmp    := Space(40)
Private cNomVend   := Space(30)
Private cSituacao  := Space(10)
Private cUsuar     := Space(50)
Private cVendedor  := Space(6)
Private nPercCom   := 0
Private nTpLanc   
Private nVlrBase   := 0
Private nVlrCom    := 0

Private nOpc1      := nOpc
Private _cUsuar    := SubStr(cUSUARIO,7,15)
Private _cIdUsuar  := RetCodUsr()
private cDthr      := (dtos(DATE()) + "-" + Time())       
private cAlias1    := GetNextAlias()   

PRIVATE cQryExc    := ' '
private cAlias2    := GetNextAlias()   

private UsuarGrv   :=  alltrim(GetMv("MV_USRGRV"))
private UsuarLan   :=  alltrim(GetMv("MV_USRLAN"))
private UsuarRev   :=  alltrim(GetMv("MV_USRREV"))   
private UsuarApr   :=  alltrim(GetMv("MV_USRAPV"))   
/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±± Declaração de Variaveis Private dos Objetos                             ±±
Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/
SetPrvt("oDlg193","oSay21","oGrp2","oSay7","oSay2","oSay1","oSay16","oSay17","oSay18","oSay4","oSay5","oGet7")
SetPrvt("oGet2","oGet54","oGet55","oGet12","oGet4","oGet5","oGrp5","oSay23","oSay24","oBtn2","oBtn1")
SetPrvt("oBtn3","oBtn4","oBtn5","oBtn6","oGet67","oGrp1","oSay3","oMGet1","oGet3","oRMenu1")

If nopc != 3 
     dbselectarea("PE9")
     DbGoto(nReg)
     fMovArqVar()  
EndIf             


/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±± Definicao do Dialog e todos os seus componentes.                        ±±
Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/ 
/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±± Definicao do Dialog e todos os seus componentes.                        ±±
Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/
    oDlg193    := MSDialog():New( 156,322,640,1140,"Credito ou Debitos de Comissões ",,,.F.,,,,,,.T.,,,.T. )

    oGrp2      := TGroup():New( 047,000,140,304,"Identificação empresa / Vendedore(s)",oDlg193,CLR_BLACK,CLR_WHITE,.T.,.F. )
    oSay7      := TSay():New( 056,003,{||"Competência"},oGrp2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,033,006)
    oSay2      := TSay():New( 056,101,{||"Nome da Empresa "},oGrp2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,047,006)
    oSay1      := TSay():New( 056,048,{||"Cod. Empresa "},oGrp2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,037,006)
    oSay16     := TSay():New( 084,004,{||"Vendedor "},oGrp2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
    oSay17     := TSay():New( 084,049,{||"Nome Vendedor "},oGrp2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,107,008)
    oSay18     := TSay():New( 112,016,{||"Valor Base"},oGrp2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
    oSay4      := TSay():New( 112,125,{||"% Comissao"},oGrp2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
    oSay5      := TSay():New( 112,237,{||"Valor Comissao"},oGrp2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,039,008)
    oGet7      := TGet():New( 066,003,{|u| If(PCount()>0,cCompte:=u,cCompte)},oGrp2,031,008,'@E 9999/99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cCompte",,)
    oGet1      := TGet():New( 066,048,{|u| If(PCount()>0,cCodEmp:=u,cCodEmp)},oGrp2,034,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"BG9CON","cCodEmp",,)
    oGet1:bF3  := &('{|| IIf(ConPad1(,,,"BG9CON",,,.F.),Eval({|| cCodEmp:= BG9->BG9_CODIGO,cNomEmp:=BG9->BG9_DESCRI,oGet1:Refresh(),oGet2:Refresh()}),.T.)}')
    oGet2      := TGet():New( 066,100,{|u| If(PCount()>0,cNomEmp:=u,cNomEmp)},oGrp2,196,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cNomEmp",,)

    oGet54     := TGet():New( 094,049,{|u| If(PCount()>0,cNomVend:=u,cNomVend)},oGrp2,247,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cNomVend",,)
    oGet55     := TGet():New( 094,003,{|u| If(PCount()>0,cVendedor:=u,cVendedor)},oGrp2,033,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"SA3","cVendedor",,)
    oGet55:bF3 := &('{|| IIf(ConPad1(,,,"SA3",,,.F.),Eval({|| cVendedor:= SA3->A3_COD,cNomVend:=SA3->A3_NOME,oGet55:Refresh(),oGet54:Refresh()}),.T.)}')


    oGet12     := TGet():New( 122,016,{|u| If(PCount()>0,nVlrBase :=u,nVlrBase )},oGrp2,044,008,'@E 9999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nVlrBase ",,)
    oGet4      := TGet():New( 122,126,{|u| If(PCount()>0,nPercCom:=u,nPercCom)},oGrp2,044,008,'@E 999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nPercCom",,)

    oGet4:bLostFocus:={|| fCalCom() ,oGet4:Refresh(),oGet12:Refresh(),oGet5:Refresh()} 

    oGet5      := TGet():New( 122,237,{|u| If(PCount()>0,nVlrCom :=u,nVlrCom )},oGrp2,044,008,'@E 9999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nVlrCom ",,)
    oGrp5      := TGroup():New( 000,000,044,401,"Controle",oDlg193,CLR_BLACK,CLR_WHITE,.T.,.F. )
    oSay23     := TSay():New( 010,077,{||"Usuario da Ação "},oGrp5,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,043,006)
    oSay24     := TSay():New( 010,006,{||"Situação"},oGrp5,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,025,006)
    oBtn2      := TButton():New( 019,346,"Excluir",oGrp5,{||fExclui(),oDlg193:End()},050,009,,,,.T.,,"",,,,.F. )
    oBtn1      := TButton():New( 032,288,"Lança",oGrp5,{||fLanca(),oDlg193:End()},050,009,,,,.T.,,"",,,,.F. )
    oGet61     := TGet():New( 020,004,{|u| If(PCount()>0,cSituacao:=u,cSituacao)},oGrp5,060,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cSituacao",,)
    oGet61:Disable()
    oBtn3      := TButton():New( 020,288,"Aprovar",oGrp5,{||fAprova(),oDlg193:End()},050,009,,,,.T.,,"",,,,.F. )
    oBtn4      := TButton():New( 008,346,"Revisada",oGrp5,{||fRevisa(),oDlg193:End()},050,009,,,,.T.,,"",,,,.F. )
    oBtn5      := TButton():New( 031,346,"&Sair",oGrp5,{||oDlg193:End()},050,010,,,,.T.,,"",,,,.F. )
    oBtn6      := TButton():New( 008,288,"Gravar",oGrp5,{||fGrava(),oDlg193:End()},050,009,,,,.T.,,"",,,,.F. )
    oGet67     := TGet():New( 020,076,{|u| If(PCount()>0,cUsuar :=u,cUsuar )},oGrp5,200,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cUsuar",,)
    oGet67:Disable()
    oGrp1      := TGroup():New( 144,000,232,400,"Historico das ações ",oDlg193,CLR_BLACK,CLR_WHITE,.T.,.F. )
    oSay3      := TSay():New( 156,004,{||"Justificativa"},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
    oMGet1     := TMultiGet():New( 188,004,{|u| If(PCount()>0,cHist:=u,cHist)},oGrp1,396,040,,,CLR_BLACK,CLR_WHITE,,.T.,"",,,.F.,.F.,.F.,,,.F.,,  )
    oMGet1:Disable()
    oGet3      := TGet():New( 168,004,{|u| If(PCount()>0,cJustif:=u,cJustif)},oGrp1,392,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cJustif",,)
    GoRMenu1   := TGroup():New( 048,308,140,400,"Debito / Credito",oDlg193,CLR_BLACK,CLR_WHITE,.T.,.F. )
    oRMenu1    := TRadMenu():New( 052,314,{"Credito","Debito"},{|u| If(PCount()>0,nTpLanc:=u,nTpLanc)},oDlg193,,{|| fCalCom() ,oGet4:Refresh(),oGet12:Refresh(),oGet5:Refresh()},CLR_BLACK,CLR_WHITE,"",,,072,46,,.F.,.F.,.T. )

    fVerBoton()

    oDlg193:Activate(,,,.T.)

Return

static function fCalCom()

    If nvlrbase < 0
       nVlrBase:= nVlrBase * -1
       nPercCom:= nPercCom * -1
    EndIf

    nVlrCom := (nVlrBase*nPercCom)/100

    If nTpLanc == 2 .and. nVlrCom > 0

       nVlrCom := nVlrCom  * -1
       nVlrBase:= nVlrBase * -1
       nPercCom:= nPercCom * -1
    
    ElseIf nTpLanc == 1 .and. nVlrCom < 0  
    
       nVlrCom := nVlrCom  * -1
       nVlrBase:= nVlrBase * -1
       nPercCom:= nPercCom * -1 

    Endif 

Return()


static function fExclui()

    cDthr      := (dtos(DATE()) + "-" + Time())   

    cSituacao:= 'Excluida'
    
    cUsuar := "Usuario : "+_cIdUsuar+' - ' +_cUsuar + " Data Hora Ação " +cDthr
    
    fGvObs(1)

    fVerBoton()
    
    fGrvPE9('EXC')

    If trim(cSituacao) =='Aprovada'  

        fExcCom()

    EndIf     

Return()

static Function fLanca()

If fcritica() 

    cDthr      := (dtos(DATE()) + "-" + Time())   

    cSituacao:= 'Lançado'
    cUsuar := "Usuario : "+_cIdUsuar+' - ' +_cUsuar + " Data Hora Ação " +cDthr

    fGvObs(1)

    fVerBoton()

    fGrvPE9('LNC')

    fGrvBxq()

EndIF
Return()

static function fAprova()

If fcritica() 

    cDthr      := (dtos(DATE()) + "-" + Time())   

    cSituacao:= 'Aprovada'
    cUsuar := "Usuario : "+_cIdUsuar+' - ' +_cUsuar + " Data Hora Ação " +cDthr

    fGvObs(1)

    fVerBoton()

    fGrvPE9('REGRV')

EndIf 

Return 

Static Function fRevisa()

If fcritica() 

    cDthr      := (dtos(DATE()) + "-" + Time())   

    cSituacao:= 'Revisada'
    cUsuar := "Usuario : "+_cIdUsuar+' - ' +_cUsuar + " Data Hora Ação " +cDthr

    fGvObs(1)

    fVerBoton()

    fGrvPE9('REGRV')

EndIf

Return 


Static Function fGrava()

    If fcritica() 

        cDthr      := (dtos(DATE()) + "-" + Time())   

        cSituacao:= 'Incluida'
        cUsuar := "Usuario : "+_cIdUsuar+' - ' +_cUsuar + ' Data Hora Ação ' +cDthr

        fGvObs(1)

        fVerBoton()

        fGrvPE9('GRV')
    
    Else 

        Alert("Lançamentos NÃO foi EFETIVADO , hà criticas .... - VERIFIQUE ")

    EndIf

Return 

static Function fGvObs(Idetobs)

    If Idetobs == 1 
       
       cHist+= CRLF + '--> Ação ' + cSituacao  
       cHist+= CRLF + '-->' + cUsuar

    EndIf 

Return

Static Function fVerBoton()
 
    If  empty(cSituacao)

        If   _cIdUsuar $ UsuarGrv .OR. _cIdUsuar == '000310'
    
            oBtn2:Disable()
            oBtn1:Disable()
            oBtn3:Disable()
            oBtn4:Disable()
            oBtn6:Enable()
            oBtn5:Enable()

        Else 

            oBtn2:Disable()
            oBtn1:Disable()
            oBtn3:Disable()
            oBtn4:Disable()
            oBtn6:Disable()
            oBtn5:Enable()

        EndIf     

    ElseIf trim(cSituacao) =='Excluida'

        oBtn2:Disable()
        oBtn1:Disable()
        oBtn3:Disable()
        oBtn4:Disable()
        oBtn6:Disable()
        oBtn5:Enable()
        fbloqexec()

    ElseIf trim(cSituacao) =='Incluida'

        If  _cIdUsuar $ UsuarRev .OR. _cIdUsuar == '000310'    
        
            oBtn2:Enable()
            oBtn1:Disable()
            oBtn3:Disable()
            oBtn4:Enable()
            oBtn6:Disable()
            oBtn5:Enable()
        
        Else 

            oBtn2:Disable()
            oBtn1:Disable()
            oBtn3:Disable()
            oBtn4:Disable()
            oBtn6:Disable()
            oBtn5:Enable()

        EndIf 

    ElseIf trim(cSituacao) =='Revisada'

        If  _cIdUsuar $ UsuarApr .OR. _cIdUsuar == '000310'    
    
            oBtn2:Enable()
            oBtn1:Disable()
            oBtn3:Enable()
            oBtn4:Disable()
            oBtn6:Disable()
            oBtn5:Enable()
            fbloqexec()

        Else 

            oBtn2:Disable()
            oBtn1:Disable()
            oBtn3:Disable()
            oBtn4:Disable()
            oBtn6:Disable()
            oBtn5:Enable()

        EndIf     

    ElseIf trim(cSituacao) =='Aprovada'
    
        If _cIdUsuar == '000310' .or. _cIdUsuar == '001495' 
            oBtn2:Enable()
        Else 
            oBtn2:Disable()
        EndIf  

        If  _cIdUsuar $ UsuarLan   
            oBtn1:Enable()
            oBtn3:Disable()
            oBtn4:Disable()
            oBtn6:Disable()
            oBtn5:Enable()
            fbloqexec()
        
        Else 

            oBtn2:Disable()
            oBtn1:Disable()
            oBtn3:Disable()
            oBtn4:Disable()
            oBtn6:Disable()
            oBtn5:Enable()

        EndIf     

    ElseIf trim(cSituacao) == 'Lançado'
    
            oBtn2:Disable()
            oBtn1:Disable()
            oBtn3:Disable()
            oBtn4:Disable()
            oBtn6:Disable()
            oBtn5:Enable()
            fbloqexec()

    EndIf                         

Return()

static Function fGrvPE9(AcPe9)
  
    If  AcPe9 == 'GRV' 
       
        Reclock("PE9",.T.) 

    Else 

        Reclock("PE9",.F.)

    EndIf

    PE9_FILIAL :=  xFilial('PE9')      
    PE9_SITUAC :=  cSituacao // NOT NULL CHAR(10)  
    PE9_USUARI :=  cUsuar    // NOT NULL CHAR(50)  
    PE9_COMPTE :=  cCompte   // NOT NULL CHAR(7)   
    PE9_CODEMP :=  cCodEmp   // NOT NULL CHAR(6)   
    PE9_NOMEMP :=  cNomEmp   // NOT NULL CHAR(40)  
    PE9_CODVEN :=  cVendedor // NOT NULL CHAR(6)   
    PE9_NOMVEN :=  cNomVend  // NOT NULL CHAR(40)  
    PE9_VLRBAS :=  nVlrBase  // NOT NULL NUMBER    
    PE9_PERCOM :=  nPercCom  // NOT NULL NUMBER    
    PE9_VLRCOM :=  nVlrCom   // NOT NULL NUMBER    
    PE9_JUSTIF :=  cJustif   // NOT NULL CHAR(200) 
    PE9_TPLANC :=  nTpLanc   // NOT NULL CHAR(7)   
    PE9_HISTOR :=  cHist     // BLOB

If AcPe9 == 'EXC'  
    
    If  _cIdUsuar == '000310'
        If  MsgYesNo("Confirma a EXCLUSÃO definitiva dos dados ?", 'Lanc. Deb/Cre')
  	        PE9->(DbDelete())  
        EndIf 
    EndIf

EndIf 

    PE9->(MsUnlock())		

Return()


static Function fGrvBxq()

LOCAL  cseq :=nextcodtab('BXQ', 'BXQ_SEQ',.T.)


    reclock("BXQ",.T.)         
        
            BXQ->BXQ_FILIAL := xFilial('BXQ')      
            
            BXQ->BXQ_ANO    := substr(cCompte,1,4)  
            BXQ->BXQ_MES    := substr(cCompte,6,2)
            BXQ->BXQ_CODVEN := cVendedor 
            BXQ->BXQ_CODEQU := ' '
            BXQ->BXQ_PREFIX := ' '    
            BXQ->BXQ_NUM    := ' '        
            BXQ->BXQ_PARC   := ' '        
            BXQ->BXQ_TIPO   := ' '       
            BXQ->BXQ_CODINT := '0001' 
            BXQ->BXQ_CODEMP := cCodEmp 
            BXQ->BXQ_MATRIC := ' '  
            BXQ->BXQ_TIPREG := ' ' 
            BXQ->BXQ_DIGITO := ' ' 
            BXQ->BXQ_NUMCON := ' '
            BXQ->BXQ_VERCON := ' ' 
            BXQ->BXQ_SUBCON := ' ' 
            BXQ->BXQ_VERSUB := ' ' 
            BXQ->BXQ_DATA   := dDataBase   
            BXQ->BXQ_SEQBXO := ' '  
            BXQ->BXQ_SEQ    := cseq   
            BXQ->BXQ_NUMPAR := "777" //TMP->BXQ_NUMPAR 
            BXQ->BXQ_BASCOM := nVlrBase
            BXQ->BXQ_PERCOM := nPercCom  
            BXQ->BXQ_VLRCOM := nVlrCom
            BXQ->BXQ_REFERE := '1' 
            BXQ->BXQ_PAGCOM := '1' 
            BXQ->BXQ_PAGPER := 100

            BXQ->(MsUnlock())	

Return


Static Function fCritica()

Local lRet := .T.

If  Substr(cCompte,1,4)<='2021' .and. Substr(cCompte,1,4)>='2022' 

    Alert("Ano da Competencia Invalida - VERIFIQUE ")
    lret := .F.

ElseIf  Substr(cCompte,6,2) < '01' .and. Substr(cCompte,6,2) > '12' 

    Alert("Mes da Competencia Invalida - VERIFIQUE ")
    lret := .F.

ElseIf Empty(cCodemp)     
       
       Alert("Codigo da Empresa em branco - VERIFIQUE ")
       lret := .F.

ElseIf Empty(cVendedor)     
       
       Alert("Codigo da Vendeddor em branco - VERIFIQUE ")
       lret := .F.

ElseIf nPercCom < -100.00 .or. nPercCom >  100.00

       Alert("Percentual de comissão invalido - VERIFIQUE ")
       lret := .F.

ElseIf nVlrBase == 0

       Alert("Valor base da comissão invalido - VERIFIQUE ")
       lret := .F.
/*
ElseIf (nVlrCom >= 0 .and. nTpLanc == 2) .or. (nVlrCom <= 0 .and. nTpLanc == 1)  

       Alert("Valor da comissão invalido - VERIFIQUE ")
       lret := .F.
*/
elseIf !fValbxq()

       lret := .F.

EndIf 

Return(lRet)


Static Function fbloqexec()

oGet7:Disable()
oGet1:Disable()
oGet2:Disable()
oGet55:Disable()
oGet54:Disable()
oGet12:Disable()
oGet4:Disable()
oGet5:Disable()
oGet3:Disable()
oRMenu1:Disable()

Return()

STATIC FUNCTION fMovArqVar()

    cSituacao := PE9_SITUAC      // NOT NULL CHAR(10)  
    cUsuar    := PE9_USUARI      // NOT NULL CHAR(50)  
    cCompte   := PE9_COMPTE      // NOT NULL CHAR(7)   
    cCodEmp   := PE9_CODEMP      // NOT NULL CHAR(6)   
    cNomEmp   := PE9_NOMEMP      // NOT NULL CHAR(40)  
    cVendedor := PE9_CODVEN      // NOT NULL CHAR(6)   
    cNomVend  := PE9_NOMVEN      // NOT NULL CHAR(40)  
    nVlrBase  := PE9_VLRBAS      // NOT NULL NUMBER    
    nPercCom  := PE9_PERCOM      // NOT NULL NUMBER    
    nVlrCom   := PE9_VLRCOM      // NOT NULL NUMBER    
    cJustif   := PE9_JUSTIF      // NOT NULL CHAR(200) 
    nTpLanc   := PE9_TPLANC      // NOT NULL CHAR(7)   
    cHist     := PE9_HISTOR      // BLOB

Return()

static function fValbxq()

local cQrySeq :=' '
local lRet    := .T.

    cQrySeq += CRLF+ " select distinct bxq_codemp , bxq_e2num , nvl(e2_Num,' ') e2Num, nvl(e2_baixa,' ') E2baixa "
    cQrySeq += CRLF+ "   from " +RetSqlName('BXQ')+ " BXQ  ," +RetSqlName('SE2')+ " SE2  "  
    cQrySeq += CRLF+ "  where bxq_filial    = '"+ xFilial('BXQ') +"'    and bxq.d_E_L_E_T_    = ' ' "
    cQrySeq += CRLF+ "    and e2_filial(+)  = '"+ xFilial('SE2') +"'    and se2.d_E_L_E_T_(+) = ' ' "
    cQrySeq += CRLF+ "    and bxq_ano    = '"+substr(cCompte,1,4)+ "'"
    cQrySeq += CRLF+ "    and bxq_mes    = '"+substr(cCompte,6,2)+ "'"
    cQrySeq += CRLF+ "    and bxq_codemp = '"+cCodemp+"'"
    cQrySeq += CRLF+ "    and bxq_codven = '"+cVendedor+"' " 
    cQrySeq += CRLF+ "    and bxq_e2pref = e2_prefixo(+)"
    cQrySeq += CRLF+ "    and bxq_e2num  = e2_num(+)"
    cQrySeq += CRLF+ "    and bxq_e2tipo = e2_tipo(+)"
    cQrySeq += CRLF+ "    and bxq_e2forn = e2_fornece(+)"		   
		    
	If Select((cAlias1)) <> 0 
		
	    (cAlias1)->(DbCloseArea()) 
		
	Endif 
  
    TcQuery cQrySeq New Alias (cAlias1)

    If (cAlias1)->(EOF())
       Alert("Calculo da Comissao NÃO realizado ou empresa / vendedor infornado errado , Deb/Ced sere Lançado - VERIFIQUE ")
       lRet:=.F. 
    ElseIf !empty((cAlias1)->e2num) 
       Alert("Titulo de pagamento Comissao ja Gerado "+ (cAlias1)->e2num +" , Deb/Ced sera Lançado - VERIFIQUE ")
       //lRet:=.F.
    ElseIf !empty((cAlias1)->e2num) .and. !empty((cAlias1)->E2baixa)
       Alert("Titulo de pagamento Comissao ja Gerado e baixado"+ (cAlias1)->e2num +" , Deb/Ced Não Pode ser Lançado - VERIFIQUE ")
       lRet:=.F.
    EndIf 

Return(lRet)

STATIC FUNCTION fExcCom()

If MsgYesNo("CONFIRMA EXCLUSÃO DA COMISSAO?")

    cQryExc := CRLF+ " SELECT BXQ.R_E_C_N_O_ BXQ_REC "

    cQryExc += CRLF+ "   from " +RetSqlName('BXQ')+ " BXQ "  
    cQryExc += CRLF+ "  where bxq_filial    = '"+ xFilial('BXQ') +"'    and bxq.d_E_L_E_T_    = ' ' "
    
    cQryExc += CRLF+ "    AND BXQ_ANO = "+SUBSTR(cCOMPTE,1,4) +'"'
    cQryExc += CRLF+ "    AND BXQ_MES = "+SUBSTR(cCOMPTE,6,2)+'"'
    cQryExc += CRLF+ "    AND BXQ_CODEMP = "+cCODEMP +'"'
    cQryExc += CRLF+ "    AND BXQ_CODVEN = "+cVendedor+'"'
    cQryExc += CRLF+ "    AND BXQ_NUMPAR = '777'"

    If Select((cAlias2)) <> 0 
		
	    (cAlias2)->(DbCloseArea()) 
		
	Endif 
  
    TcQuery cQryExc New Alias (cAlias2)

    If !(cAlias2)->(EOF())

           BXQ->(DbGoTo((cAlias2)->BXQ_REC))
           RecLock("BXQ", .F.)
               BXQ->(DbDelete())
           BXQ->(MsUnlock())
    
    EndIf  

EndIf 

Return()
// oGet1       := TGet():New( 137,308,{|u| If(PCount()>0,(cFornec:=u,fConsSa(cFornec,'PGTO')),cFornec)},oGrp11,024,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"SA2JU1","cFornec",,)

// REVISAR - ALTAMIRO     
//oGet1:bF3 := &('{|| IIf(ConPad1(,,,"SA2JUR",,,.F.),Eval({|| cFornec:= SA2->A2_COD,cNomFornec:=SA2->A2_NOME ,cLjCliFor:= SA2->A2_LOJA ,oGet1:Refresh(),oGet11:Refresh()}),.T.)}')