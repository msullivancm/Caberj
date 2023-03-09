#include "PROTHEUS.CH"
#Include "PLSMGER.CH"
#include "PLSMGER2.CH"
#include "PLSMCCR.CH"                                               
#include "topconn.ch"
#INCLUDE "TOTVS.CH"
#INCLUDE 'RWMAKE.CH'                                                 
#INCLUDE 'FONT.CH'
#INCLUDE 'COLORS.CH' 
#Include "Ap5Mail.Ch"                                                                                                       

User Function caba203()                 

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta matriz com as opcoes do browse...                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE aRotina	:=	{	{ "&Visualizar"	, "U_Caba203a"		, 0 , 1	 },; 
					  	{ "&Alteracao"	, "U_Caba203a"		, 0 , 2  },;
                        { "&Incluir"	, "U_Caba203a"		, 0 , 3	 },;
                        { "Legenda"		, "U_LEGPR203"	    , 0 , 3	 }}
                        
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Titulo e variavies para indicar o status do arquivo                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE cCadastro	:= "Browser de Pagamento de Comisões Executivos de Conta"

PRIVATE aCdCores	:= { 	{ 'BR_VERDE'    ,'Liberação p/ Pagameto'},;
							{ 'BR_AZUL'     ,'Comissão Devidas'     },; 
							{ 'BR_VERMELHO' ,'Comissão Não devidas' },;
                            { 'BR_LARANJA'  ,'Comissão Em Processo' },;
                            { 'BR_AMARELO'  ,'Comissão Calculada'   },;
                            { 'BR_PRETO'    ,'Empresa Bloqueada'    }}
 
//		{ 'BR_AMARELO'  ,'Processo Audiencia Marcada' },;

PRIVATE aCores	:= {{"(PEC_STATUS =='Incluido  ')"  , aCdCores[4,1]},;
                    {"(PEC_STATUS =='Devido    ')"  , aCdCores[2,1]},;
                    {"(PEC_STATUS =='Indevido  ')"  , aCdCores[3,1]},;
                    {"(PEC_STATUS =='Emp. Bloq ')"  , aCdCores[6,1]},;
					{"(PEC_STATUS =='Calculado ')"  , aCdCores[5,1]},;
                    {"(PEC_STATUS =='Pago      ')"  , aCdCores[1,1]}}

					
//PRIVATE cPath  := ""                        
PRIVATE cAlias := "PEC" 

PRIVATE cPerg	:= "CABA203"

PRIVATE cNomeProg   := "CABA203"
PRIVATE nQtdLin     := 68
PRIVATE nLimite     := 132
PRIVATE cControle   := 15
PRIVATE cTamanho    := "G"
PRIVATE cTitulo     := "Controle de Pagamento de Comissao de Executivo de Conta"
PRIVATE cDesc1      := ""
PRIVATE cDesc2      := ""
PRIVATE cDesc3      := ""
PRIVATE nRel        := "caba203"
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
PRIVATE cCabec1     := "Controle de Pagamento de Comissao de Executivo de Conta"
PRIVATE cCabec2     := ""
PRIVATE nColuna     := 00   
private tpcons      := ' ' 
Private cAliasMSV 	:= GetNextAlias()
Private cAliasVc  	:= GetNextAlias()
Private cAliasCr  	:= GetNextAlias()
Private cAliasCc  	:= GetNextAlias()

Private cAliasPR  	:= GetNextAlias()

Private cAliasCE  	:= GetNextAlias()
Private cAliasVRJ  	:= GetNextAlias()
Private cAliasCr2  	:= GetNextAlias()

private cEmpCI := Iif (cempant == '01','C','I')

private cano := 0
private cmes := 0

private canoReaj := ' ' 
private cmesReaj := ' '
private canoInc  := ' '
private cmesInc  := ' '
private canoFim  := ' '
private cmesFim  := ' '
private lEmpBloq := .F.
private nPrcExe  := SuperGetMv('MV_PRCEXE')
private nSinPme  := SuperGetMv('MV_SINPME')
private nSinEmp  := SuperGetMv('MV_SINEMP')
private cEmpNPart:= SuperGetMv('MV_EMPNCL')
private cAprov   := SuperGetMv('MV_AUTCMS')   

Private _cIdUsuar    := RetCodUsr()

private cNunFat  := 0

//private cSinEmp  := SuperGetMv('MV_AUTCMS') // 

private cStsFil  := ' ' 

Private nQtdReajT  := 0.00
Private nQtdTotT   := 0.00
Private nVlrReajT  := 0.00
private nPercReaj  := 0.00

private cCmpReaM   := ' '
private cCmpPgtM   := ' '
private nSequenM   := 0
private cStatusM   := 0

private nSinistCal := 0.00

private     nMensa     := 0.00 
Private     nDesp      := 0.00

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Starta mBrowse...                                                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ     
If Pergunte('CABA203  ',.T.) = .F.
	Return
Endif

/*********** */
dbselectarea("PEC")
PEC->(DBSetOrder(1))  
/*
Pago      
Calculado 
Emp. Bloq 
Devido    
Incluido  
Indevido  
*/
If mv_par04 == 1
   cStsFil  := "Todos"
ElseIf mv_par04 == 2
   cStsFil  := "DEVIDO"
ElseIf mv_par04 == 3
   cStsFil  := "INDEVIDO"
ElseIf mv_par04 == 4
   cStsFil  := "CALCULADO"
ElseIf mv_par04 == 5
   cStsFil  := "PAGO"
EndIF

    dbselectarea("PEC")
    dbSetOrder(1)

If mv_par01 == 1 .AND. mv_par04 == 1
   SET FILTER TO (PEC_CMPREA >= MV_PAR02 .AND. PEC_CMPREA <= MV_PAR03) 
EndIf 

If mv_par01 == 1 .AND. mv_par04 != 1
   SET FILTER TO ( Alltrim(UPPER(PEC_STATUS)) $ (alltrim(cStsFil)) .AND. PEC_CMPREA >= MV_PAR02 .AND. PEC_CMPREA <= MV_PAR03)
EndIf 

//PBW->(mBrowse(006,001,022,075,"PBW" , , , , , Nil    , aCores, , , ,nil, .T.))  
PEC->(mBrowse(006,001,022,075,"PEC" , , , , , 2  , aCores, , , ,nil, .F.)) 
//mBrowse(6, 1, 22, 75, "PBW",,,,,,aCores)
PEC->(DbClearFilter())
DbCloseArea()
Return()
              
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

User Function LEGPR203()
Local aLegenda

	aLegenda 	:= { 	{ aCdCores[1,1],aCdCores[1,2] },;
						{ aCdCores[2,1],aCdCores[2,2] },;
						{ aCdCores[3,1],aCdCores[3,2] },;
	              		{ aCdCores[4,1],aCdCores[4,2] },;
	              		{ aCdCores[5,1],aCdCores[5,2] },;
                        { aCdCores[6,1],aCdCores[6,2] } }

	                     	
BrwLegenda(cCadastro,"Status" ,aLegenda)

Return

User Function CABA203a(cAlias,nReg,nOpc)                         


/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±± Declaração de cVariable dos componentes                                 ±±
Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/
Private cCodEmp    := Space(4)  // PEC_CODEMP 
Private cComptFim  := Space(7)  // PEC_CMPFIM
Private cComptInic := Space(7)  // PEC_CMPINI
Private cComptPagt := Space(7)  // PEC_CMPPGT
Private cComptReaj := Space(7)  // PEC_CMPREA
Private cEquipe    := Space(6)  // PEC_EQUIPE
Private cNomEmp    := Space(40) // PEC_NOMEMP
Private cStatus    := Space(10) // PEC_STATUS
Private dDtPgtoCom := CtoD(" ") // PEC_DTPGTO
Private nQtdaVidas := 0         // PEC_QTDVID
Private nSequen    := 0         // PEC_SEQUEN
Private nSinistMed := 0.0000        // PEC_SNTMED
Private nVlrBase   := 0         // PEC_VLRBAS
Private nVlrCom    := 0         // PEC_VLRCOM
Private cObs                    // PEC_OBS

Private _cUsuario:= SubStr(cUSUARIO,7,15)
Private _cIdUsuar:= RetCodUsr()
private cDthr    := (dtos(DATE()) + "-" + Time()) 
Private _nAno   := Year(date())+1

//private cAprov  := SuperGetMv('MV_AUTCMS')    

private lSair    := .F.
/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±± Declaração de Variaveis Private dos Objetos                             ±±
Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/

oDlg203    := MSDialog():New( 200,259,498,1260,"Comissão Executivos de Conta ",,,.F.,,,,,,.T.,,,.T. )

SetPrvt("oDlg203","oGrp1","oSay1","oSay7","oSay23","oSay26","oSay10","oGet1","oGet7","oGet23","oGet26")
SetPrvt("oGrp2","oBtn1","oBtn2","oBtn3","oBtn7","oBtn11","oBtn12","oGrp5","oSay11","oSay6","oSay4","oSay3")
SetPrvt("oSay8","oSay9","oSay2","oSay12","oGet11","oGet3","oGet5","oGet4","oGet6","oGet8","oGet9","oGet2")
SetPrvt("oGrp3","oMGet1")
/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±± Definicao do Dialog e todos os seus componentes.                        ±±
Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/
    Private nopc203 := nopc
    private nOpcU   := nopc
    private lcrit   :=.F.
	
    Private cAnoAReaj := ' ' 
    Private cMesAReaj := ' ' 

    	dbselectarea("PEC")
        dbSetOrder(1)
   
    If nopc203 == 3
       
       cEquipe     := 'X00001'
       nSequen     := 1
       cStatus    := 'Incluido'
       cObs :=  CRLF + "--> Incluido Pelo Usuario " + _cIdUsuar+ " - "+_cUsuario+" Em "  + cDthr + CRLF
    Else

       fMArqVar()  

    EndIf 

oDlg203    := MSDialog():New( 200,259,498,1260,"Comissão Executivos de Conta ",,,.F.,,,,,,.T.,,,.T. )
oGrp1      := TGroup():New( 000,000,044,356,"Identificação Empresa ",oDlg203,CLR_BLACK,CLR_WHITE,.T.,.F. )
//oGrp1      := TGroup():New( 000,000,088,356,"Identificação Empresa ",oDlg203,CLR_BLACK,CLR_WHITE,.T.,.F. )
oSay1      := TSay():New( 012,032,{||"Empresa"},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,028,008)
oSay7      := TSay():New( 012,304,{||"Compte Pagto"},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,040,008)
oSay23     := TSay():New( 012,069,{||"Nome Empresa"},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,051,008)
oSay26     := TSay():New( 012,004,{||"Sequen"},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,020,008)
oSay10     := TSay():New( 013,249,{||"Compte Reajuste"},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,043,008)

oGrp2      := TGroup():New( 000,360,044,492,"Controles",oDlg203,CLR_BLACK,CLR_WHITE,.T.,.F. )
oBtn1      := TButton():New( 010,364,"&Grava",oGrp2,{||fGrava()},037,012,,,,.T.,,"",,,,.F. )
oBtn2      := TButton():New( 010,408,"&Deleta",oGrp2,{||fDeleta(),oDlg203:End()},037,012,,,,.T.,,"",,,,.F. )
oBtn3      := TButton():New( 010,450,"&Calc. Comissao",oGrp2,{||fMSins(1)},037,012,,,,.T.,,"",,,,.F. )
oBtn7      := TButton():New( 027,452,"&Gera Comis.",oGrp2,{||fPaga(),oDlg203:End()},036,012,,,,.T.,,"",,,,.F. )
oBtn11     := TButton():New( 027,366,"&Livre",oGrp2,{||fVerifReaj(cComptReaj, cComptPagt, cCodemp) },036,012,,,,.T.,,"",,,,.F. )
//oBtn12     := TButton():New( 028,408,"&Sair",oGrp2,{||lSair:=.T.,oDlg203:End()},036,012,,,,.T.,,"",,,,.F. )
oBtn12     := TButton():New( 028,408,"&Sair",oGrp2,{ || lSair:=.T. , oDlg203:End()},036,012,,,,.T.,,"",,,,.F. )

//oBtn12     := TButton():New( 028,408,"&Sair",oGrp2,{||fSair()},036,012,,,,.T.,,"",,,,.F. )
oGet26     := TGet():New( 025,004,{|u| If(PCount()>0,nSequen:=u,nSequen)},oGrp1,020,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nSequen",,)
oGet1      := TGet():New( 025,032,{|u| If(PCount()>0,cCodEmp:=u,cCodEmp)},oGrp1,024,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cCodEmp",,)
 
   oGet1:bLostFocus:={||fNomEmp()}

oGet10     := TGet():New( 025,249,{|u| If(PCount()>0,cComptReaj:=u,cComptReaj)},oGrp1,043,008,'@E 9999/99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cComptReaj",,)

   oGet10:bLostFocus:={||fFaComp(1)}

oGet7      := TGet():New( 025,304,{|u| If(PCount()>0,cComptPagt:=u,cComptPagt)},oGrp1,040,008,'@E 9999/99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cComptPagt",,)

   oGet7:bLostFocus:={||fValPagto(), fFaComp(2) }
   
oGrp5      := TGroup():New( 044,000,080,492,"Dados da Comissão",oDlg203,CLR_BLACK,CLR_WHITE,.T.,.F. )
oSay3      := TSay():New( 052,072,{||"Compte Inicial"},oGrp5,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,040,008)
oSay4      := TSay():New( 052,121,{||"Compte Final"},oGrp5,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)   
oSay5      := TSay():New( 052,168,{||"Sinistralidade Media"},oGrp5,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,052,008)
oSay8      := TSay():New( 052,265,{||"Base de Calculo "},oGrp5,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,047,008)
oSay9      := TSay():New( 052,318,{||"Vlr Bruto Comissaolo "},oGrp5,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,050,008)
oSay2      := TSay():New( 052,445,{||"Cod Equipe"},oGrp5,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,040,008)
//oSay12     := TSay():New( 053,381,{||"Dt Geração Comissao"},oGrp5,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,051,008)
oSay12     := TSay():New( 053,381,{||"Dt Geração Comis."},oGrp5,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,047,008)

oSay11     := TSay():New( 052,224,{||"Qtda Vidas "},oGrp5,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay6      := TSay():New( 052,004,{||"Status Comissao"},oGrp5,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,044,008)

oGet9      := TGet():New( 064,005,{|u| If(PCount()>0,cStatus:=u,cStatus)},oGrp5,060,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cStatus",,)
oGet3      := TGet():New( 064,072,{|u| If(PCount()>0,cComptInic:=u,cComptInic)},oGrp5,036,008,'@E 9999/99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cComptInic",,)
oGet5      := TGet():New( 064,119,{|u| If(PCount()>0,cComptFim:=u,cComptFim)},oGrp5,036,008,'@E 9999/99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cComptFim",,)
oGet4      := TGet():New( 064,170,{|u| If(PCount()>0,nSinistMed:=u,nSinistMed)},oGrp5,046,008,'@E 9999.99%',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nSinistMed",,)
oGet11     := TGet():New( 064,225,{|u| If(PCount()>0,nQtdaVidas:=u,nQtdaVidas)},oGrp5,032,008,'@E 99,999',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nQtdaVidas",,)

oGet6      := TGet():New( 064,264,{|u| If(PCount()>0,nVlrBase:=u,nVlrBase)},oGrp5,046,008,'@E 9,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrBase",,)
oGet8      := TGet():New( 064,319,{|u| If(PCount()>0,nVlrCom:=u,nVlrCom)},oGrp5,046,008,'@E 9,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrCom",,)
oGet12     := TGet():New( 064,382,{|u| If(PCount()>0,dDtPgtoCom:=u,dDtPgtoCom)},oGrp5,045,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","dDtPgtoCom",,)
oGet2      := TGet():New( 064,445,{|u| If(PCount()>0,cEquipe:=u,cEquipe)},oGrp5,040,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cEquipe",,)
oGet23     := TGet():New( 025,068,{|u| If(PCount()>0,cNomEmp:=u,cNomEmp)},oGrp1,168,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cNomEmp",,)


oGrp3      := TGroup():New( 080,000,140,492,"Observações",oDlg203,CLR_BLACK,CLR_WHITE,.T.,.F. )
oMGet1     := TMultiGet():New( 088,004,{|u| If(PCount()>0,cObs:=u,cObs)},oGrp3,484,044,,,CLR_BLACK,CLR_WHITE,,.T.,"",,,.F.,.F.,.F.,,,.F.,,  )

If  nopc203 != 3

    oGet1:Disable()
 
    oGet10:Disable()    
 
    if  nVlrBase > 0 .or. cStatus == 'Indevido'
 
        oGet7:Disable()
 
    EndIf 

Else 

    oGet1:setfocus()

EndIf

    oGet23:Disable()
    oGet26:Disable()
    oGet11:Disable()
    oGet12:Disable()
    oGet3:Disable()
    oGet5:Disable()
    oGet4:Disable()
    oGet6:Disable()
    oGet8:Disable()
    oGet9:Disable()
    oGet2:Disable()
    oMGet1:Disable()

If  trim(cStatus) == " "

    oBtn2:Disable() // deleta
    oBtn3:Disable() // Calc. Comissao
    oBtn7:Disable() // Gera Comis
    
ElseIf  trim(cStatus) == "Devido"

   // oBtn7:Disable()

ElseIf  trim(cStatus) == "Incluido"

    oBtn7:Disable()    

ElseIf  trim(cStatus) $ "Indevido|Emp. Bloq"

    oBtn1:Disable()
    oBtn3:Disable()
    oBtn7:Disable()

ElseIf  trim(cStatus) =="Calculado"

    oBtn1:Disable()
    //oBtn2:Disable()
    oBtn3:Disable()

ElseIf  trim(cStatus) =="Pago"   

    oBtn1:Disable()
    oBtn2:Disable()
    oBtn3:Disable()
    oBtn7:Disable()
EndIf 

If  !_cIdUsuar $ cAprov

    oBtn3:Disable() // Calc. Comissao
    oBtn7:Disable() // Gera Comis

EndIf 

If  !_cIdUsuar $ '001672|000310'

    oBtn12:Disable() // demonstração de reajuste - liberado apenas para juliana e altamiro 

EndIf     

oDlg203:Activate(,,,.T.)

Return

Static Function fGrava()

//		dbselectarea("PEC")
//		PEC->(DbSetOrder(1))   

        If  nopc203 == 2
             
            RecLock("PEC",.F.)     
	        fMVarArq()
	        Msunlock("PEC")    
            oDlg203:End()
        
        Else  	   
           
	        RecLock("PEC",.T.)     
            fMVarArq()
	   	    Msunlock("PEC")
            oDlg203:End()  
  	   
        EndIf 	       
            
return() 

static function fMVarArq()

PEC_FILIAL   := xFilial("PEC")
PEC_CODEMP   := cCodEmp     
PEC_CMPFIM   := substr(cComptFim  ,1,4)+substr(cComptFim  ,6,2)   
PEC_CMPINI   := substr(cComptInic ,1,4)+substr(cComptInic ,6,2) 
PEC_CMPPGT   := substr(cComptPagt ,1,4)+substr(cComptPagt ,6,2)
PEC_CMPREA   := substr(cComptReaj ,1,4)+substr(cComptReaj ,6,2) 
PEC_EQUIPE   := cEquipe  
PEC_NOMEMP   := cNomEmp    
PEC_STATUS   := cStatus    
PEC_DTPGTO   := dDtPgtoCom 
PEC_QTDVID   := nQtdaVidas 
PEC_SEQUEN   := nSequen    
PEC_SNTMED   := nSinistMed 
PEC_VLRBAS   := nVlrBase   
PEC_VLRCOM   := nVlrCom    
PEC_OBS      := cObs
PEC_PERCBS   := nPrcExe

Return()

static function fMArqVar()

cComptFim  := substr(PEC_CMPFIM ,1,4)+'0'+substr(PEC_CMPFIM ,5,2)   
cComptInic := substr(PEC_CMPINI ,1,4)+'0'+substr(PEC_CMPINI ,5,2) 
cComptPagt := substr(PEC_CMPPGT ,1,4)+'0'+substr(PEC_CMPPGT ,5,2)
cComptReaj := substr(PEC_CMPREA ,1,4)+'0'+substr(PEC_CMPREA ,5,2) 
cCodEmp    := PEC_CODEMP     
cEquipe    := PEC_EQUIPE    
cNomEmp    := PEC_NOMEMP    
cStatus    := PEC_STATUS    
dDtPgtoCom := PEC_DTPGTO    
nQtdaVidas := PEC_QTDVID    
nSequen    := PEC_SEQUEN    
nSinistMed := PEC_SNTMED    
nVlrBase   := PEC_VLRBAS    
nVlrCom    := PEC_VLRCOM      
cObs       := PEC_OBS    

Return()

static Function fNomEmp()

local cqueryCE := ' '

lEmpBloq    := .F.
lcrit       := .F.
cNomEmp     := ' '
cComptReaj  := Substr(dtos(dDataBase),1,4)+'0'+Substr(dtos(dDataBase),5,2)  

If  cCodEmp $ cEmpNPart
 
    MsgAlert("Esta Empresa Não participa do calculo da comisão!!! ","Atencao!")
    cCodEmp:= Space(4)
    oGet1:setfocus()
    lcrit:=.T.
    oDlg203:End()

ElseIf !empty(cCodEmp)
   
    cqueryCE :=        " select bg9_codigo , trim(NVL(bg9_descri,' ')) DescEmp , "
    cqueryCE +=  CRLF+ "        Sum(Decode(trim(ba1_datblo),'',1,0)) qtda, max(ba1_datblo) datblo " 
    cqueryCE +=  CRLF+ "   from bg9020 bg9 , ba1020 ba1 "
    cqueryCE +=  CRLF+ "  where bg9_filial = ' ' "
    cqueryCE +=  CRLF+ "    and bg9.d_E_L_E_T_ = ' ' "
    cqueryCE +=  CRLF+ "    and ba1_filial = ' ' "
    cqueryCE +=  CRLF+ "    and ba1.d_E_L_E_T_ = ' ' "

    cqueryCE +=  CRLF+ "    and bg9_codint = '0001' "
    cqueryCE +=  CRLF+ "    and bg9_codigo = '"+cCodEmp+"'"

    cqueryCE +=  CRLF+ "    and ba1_codemp = bg9_codigo " 
    cqueryCE +=  CRLF+ "  group by bg9_codigo , trim(NVL(bg9_descri,' ')) "
   
    If Select((cAliasCE)) <> 0 
        (cAliasCE)->(DbCloseArea())    
    Endif

	TcQuery cqueryCE New Alias (cAliasCE)        
	(cAliasCE)->(dbGoTop())

    If (cAliasCE)->qtda == 0
        lEmpBloq := .T. 
        If !MsgYesNo("Todas as Vidas desta empresa estao bloqueadas , Deseja continuar ?")
           cCodEmp:= Space(4)
           oGet1:setfocus()
           lcrit:=.T.
           oDlg203:End()
        Else
           cNomEmp:=(cAliasCE)->DescEmp
           oGet23:ctrlrefresh()   
           cObs :=  CRLF + "--> Incluido Pelo Usuario " + _cIdUsuar+ " - "+_cUsuario+" Em "  + cDthr + CRLF 
           cObs +=  "Nao à Vidas ativa -- Data Ultimo Bloqueio -- " + Substr((cAliasCE)->datblo,7,2)+'/'+Substr((cAliasCE)->datblo,5,2)+'/'+Substr((cAliasCE)->datblo,1,4) + CRLF
           cStatus  := 'Emp. Bloq' 
        EndIf 

    ElseIf !empty((cAliasCE)->DescEmp) 
           cNomEmp:=(cAliasCE)->DescEmp
           oGet23:ctrlrefresh()     
    Else 
        MsgAlert("Empresa Invalida , Verifique !!! ","Atencao!")       
    
        cCodEmp:= Space(4)
        oGet1:ctrlrefresh()     
        oGet1:setfocus()
        lcrit:=.T.
        oDlg203:End()
    EndIf 
Else
    MsgAlert("Codigo da Empresa esta em branco !!! ","Atencao!")       
    cCodEmp:= Space(4)
    oGet1:setfocus()
    lcrit:=.T.
    oDlg203:End()
EndIf 

Return()

Static Function fValPagto()

lcrit := .F.

If  Substr(cComptPagt,1,4) < '2021' .or. (Substr(cComptPagt,6,2) < '01' .or. Substr(cComptPagt,6,2) > '12') .or. empty(cComptPagt) 
    MsgAlert("Competencia de Pagamentos Invalida !!! ","Atencao!")     
    lcrit:=.T.
    oGet7:setfocus()
    oDlg203:End()

/*ElseIf  Substr(cComptReaj,1,4) == Substr(cComptPagt,1,4)  
    
    If  Substr(cComptReaj,6,2) > Substr(cComptPagt,6,2)
        MsgAlert("Competencia de Reajuste Maior que a competencia de Pagamentos !!! ","Atencao!")       
        lcrit:=.T.
        oGet7:setfocus()
    
    EndIF */

ElseIf  Substr(cComptReaj,1,4) > Substr(cComptPagt,1,4)  
    MsgAlert("Competencia de Reajuste Maior que a competencia de Pagamentos !!! ","Atencao!")       
        lcrit:=.T.
        oGet7:setfocus()
        oDlg203:End()
ElseIf  val(Substr(cComptPagt,1,4)) > _nAno 
    MsgAlert("O Ano da Competencia de Pagamento Maior que a Permitida "+strzero(_nAno,4) +" !!! ","Atencao!")       
        lcrit:=.T.
        oGet7:setfocus()
        oDlg203:End()
EndIF
    
Return()


Static Function fFaComp(contro)

If lcrit ==.T. 

   lcrit:=.F.
    
   Return()

Endif   

If  empty(cComptReaj)

    MsgAlert("Competencia de Reajuste em branco !!! ","Atencao!")       
    oGet1:setfocus()
    lcrit:=.T.
    oDlg203:End()
    Return()

EndIF 

If val(Substr(cComptReaj,1,4)) > _nAno

    MsgAlert("Ano da Competencia de Reajuste Maior que a Permitida "+strzero(_nAno,4) +" !!! ","Atencao!")       
    oGet10:setfocus()
    lcrit:=.T.
    oDlg203:End()
    Return() 
EndIf 

If Substr(cComptReaj,1,4) < '2021'

    MsgAlert("Ano da Competencia de Reajuste Invalido !!! ","Atencao!")       
    oGet10:setfocus()
    lcrit:=.T.
    oDlg203:End()
    Return() 
EndIf 

If Substr(cComptReaj,6,2) < '01' .and. Substr(cComptReaj,6,2) > '12'
     
    MsgAlert("Mes da Competencia de Reajuste Invalido !!! ","Atencao!")       
    oGet10:setfocus()
    lcrit:=.T.
    oDlg203:End()
    Return()
EndIf 

if contro == 2

    If  fCritComp() 
        // MsgAlert("Para esta Empresa , O ano da competencia Informado ja Foi avaliado "+CRLF +", Não é Possivel Nova Avaliação para a competencia Informada !!! ","Atencao!")       
        If !MsgYesNo("Para esta Empresa , O ano da competencia Informado ja Foi avaliado " +CRLF +", Deseja continuar ?")
        
            If  nopc203 != 2
        
                cNomEmp:=' '
                cCodEmp:=' '    
                cComptReaj :=  ' '
            
            EndIf

            oGet1:setfocus()
            lcrit:=.T.
            oDlg203:End()

            Return()
        
        else 

            If  (Substr(cComptReaj,1,4)+Substr(cComptReaj,6,2) < cCmpReaM .or. (Substr(cComptReaj,1,4)+Substr(cComptReaj,6,2) == cCmpReaM .and. nopc203 != 2 ))
                
                MsgAlert("Competencia de Reajuste "+cCmpReaM +" é Menor ou igual da já avaliada "+Substr(cComptReaj,1,4)+"/"+Substr(cComptReaj,6,2) +" !!! ","Atencao!")       
                lcrit:=.T.
                oGet10:setfocus()
                oDlg203:End()
                Return()

            elseif Substr(cComptPagt,1,4)+Substr(cComptPagt,6,2) <= cCmpPgtM    
                
                MsgAlert("Competencia de Pagamento"+cCmpPgtM +" é  Menor ou igual da ja havalida "+Substr(cComptPagt,1,4)+"/"+Substr(cComptPagt,6,2) +" !!! ","Atencao!")       
                lcrit:=.T.
                oGet7:setfocus()
                oDlg203:End()
                Return()
            
            elseif trim(cStatusM) $ 'Devido|Incluido|Calculado' .and. nopc203 != 2

                MsgAlert("Existe processo de comissão não concluido na competencia "+cCmpReaM  +" !!! ","Atencao!")       
                lcrit:=.T.
                oGet7:setfocus()
                oDlg203:End()
                Return()

            EndIF 

            If  nopc203 != 2    
                
                nSequen++
                oGet26:ctrlrefresh()
                cObs +=  "--> Atualizado Pelo Usuario " + _cIdUsuar+ " - "+_cUsuario+" Em "  + cDthr + CRLF
                cObs +=  "Incluida a sequencia -->  " + strzero(nSequen,3) +" Em "  + cDthr + CRLF

            EndIF 
        EndIf
    EndIf
EndIf 

    cano := val(substr(cComptReaj,1,4))
    cmes := val(substr(cComptReaj,6,2))

    canoReaj := val(substr(cComptReaj,1,4))
    cmesReaj := val(substr(cComptReaj,6,2))

//  Orientado que a data de aplicação do reajuste e igual a data do proprio reajuste - orientação equipe de exec de contas 
/*
If  nopc203 != 2 // REVERTER ORIENTAÇÃO PARA AUTOMAÇÃO 

    If cmes == 12 
       cComptPagt :=  strzero(cano+1,4)+'/'+strzero( 1 ,2)
    Else
       cComptPagt :=  strzero(cano,4)+'/'+strzero(cMes+1,2)
    EndIf

       cComptPagt := cComptReaj

EndIf    
*/
/////////////     

    If cmes == 1 
       cano--
       cmes := 10 
       
    ElseIf cmes == 2

       cano--
       cmes:= 11

    ElseIf cmes == 3

       cano--
       cmes:= 12       
      
    Else 
        
        cmes:= cmes - 3     
    
    EndIf  
     
    cComptFim := strzero(cano,4)+'/'+strzero(cmes,2)
    
    cmes++

    If (cmes) > 12
 
       cano++
       cmes:= 1

    EndIf 

    cComptInic := strzero((cano-1),4)+'/'+strzero(cmes,2)

/*

    If  lcrit == .F.
        
        If  ApMsgYesNo("Deseja Fazer os Calculos da Sinistralidade Agora ","SIMNAO")    
        
            fMSins(0) 

        EndIf 

    EndIf

*/
        lcrit:=.F.      

Return()

Static Function fDeleta()
 
    If  cStatus == 'Calculado'
        MsgAlert("Calculo ja foi realizado ,Não Pode ser Excluido !!! - Favor Verificar  ","Atencao!")
        Return()
    EndIf

    If  ApMsgYesNo("Deseja excluir o Registro. Deseja excluir","SIMNAO")

             
        RecLock("PEC",.F.)     
	    PEC_OBS +=  CRLF + "--> Excluido Pelo Usuario " + _cIdUsuar+ " - "+_cUsuario+" Em "  + cDthr + CRLF
	    Msunlock("PEC")    

        PEC->(RecLock("PEC",.F.))
        PEC->(DbDelete())
        PEC->(MsUnlock())

    EndIf
 
Return()

static Function fMSins(nOrigem)

local cquerySv  := ' ' 

    If  lEmpBloq == .T.
        MsgAlert("Empresa Bloqueada  , Não Paga  comissao !!! - Favor Verificar  ","Atencao!")
        cStatus  := 'Emp. Bloq'

        Return()
    ElseIf  cStatus == 'Pago'
        MsgAlert("Comissao Ja Paga , Não Pode Refazer os Calculos da comissao !!! - Favor Verificar  ","Atencao!")
        Return()
    EndIf

    If  cStatus == 'Calculado'
        If  ApMsgYesNo("Calculo ja foi realizado ,Deseja Refazer os Calculos da comissao ","SIMNAO")
            a:='b'
        Else     
            Return()
        EndIf
    EndIf

    canoReaj := substr(cComptReaj,1,4)
    cmesReaj := substr(cComptReaj,6,2)
    canoInc  := substr(cComptInic,1,4)
    cmesInc  := substr(cComptInic,6,2)
    canoFim  := substr(cComptFim,1,4)
    cmesFim  := substr(cComptFim,6,2)

	cQuerySv :=     "  SELECT codemp CodEmp , Decode(Sum(MENSA),0,0,round((Sum(APROVADO-PART)))) desp, Sum(MENSA) mensa , "
    cQuerySv +=CRLF+"          Decode(Sum(MENSA),0,0,round((Sum(APROVADO-PART))/Sum(MENSA),6))*100 sinist "

    // If  cEmpCI=='I'
        cQuerySv +=CRLF+"   FROM COB_SINISTRALIDADE_MS_INT  "
    // Else
    //    cQuerySv +=CRLF+"   FROM COB_SINISTRALIDADE_MS_CAB  "
    // EndIf	

    cQuerySv +=CRLF+"  where MES_ANO_REF between TO_DATE('"+DtOS(stod(canoInc+cmesInc+'01'))+"','YYYYMMDD') and TO_DATE('"+DtOS(stod(canoFim+cmesFim+'01'))+"','YYYYMMDD')"
    cQuerySv +=CRLF+"   AND CODEMP = '"+cCodEmp+"' "
    
	cQuerySv += CRLF + "    group by  codemp " 
	
	If  Select((cAliasMSV)) <> 0 
	    (cAliasMSV)->(DbCloseArea())  
	Endif                          

	TCQuery cQuerySv New Alias (cAliasMSV)   

    (cAliasMSV)->( DbGoTop() )  

	nSinistMed := (cAliasMSV)->sinist
    nMensa     := (cAliasMSV)->mensa
    nDesp      := (cAliasMSV)->desp


cQuerySv :=     "  select ba1_codemp Codemp , count(*) qtdavid "
cQuerySv +=CRLF+"    from ba1020 ba1
cQuerySv +=CRLF+"   where ba1_filial= ' ' and d_E_L_E_T_ = ' ' "
cQuerySv +=CRLF+"     and (ba1_datblo = ' ' or ba1_datblo >'"+ canoReaj+cmesReaj+'01'+"')"
cQuerySv +=CRLF+"     and ba1_codemp = '"+cCodEmp+"' "
cQuerySv +=CRLF+"   group by ba1_codemp "
 
	If  Select((cAliasMSV)) <> 0 
	    (cAliasMSV)->(DbCloseArea())  
	Endif                          

	TCQuery cQuerySv New Alias (cAliasMSV)   

    (cAliasMSV)->( DbGoTop() )  

	nQtdaVidas := (cAliasMSV)->QTDAVID

    oGet11:ctrlrefresh()
	
    oGet4:ctrlrefresh()    

    If  nQtdaVidas > 0
        
        If  nQtdaVidas <= 29
            If  nSinistMed <= nSinPme
                cStatus  := 'Devido'
                cObs +=  "--> Sinistralidade " +transform((nSinistMed),"@E 999,999,999.99")   +"% , Qtda Vidas " + transform((nQtdaVidas),"@E 99,999") + CRLF
                cObs +=  "--> Atualizado Pelo Usuario " + _cIdUsuar+ " - "+_cUsuario+" Em "  + cDthr + CRLF
                cObs +=  "--> Status - " + cStatus +" Em "  + cDthr + CRLF
            Else 
                cStatus  := 'Indevido' 
                cObs +=  "--> Sinistralidade " +transform((nSinistMed),"@E 999,999,999.99")   +"% , Qtda Vidas " + transform((nQtdaVidas),"@E 99,999") + CRLF
                cObs +=  "--> Atualizado Pelo Usuario " + _cIdUsuar+ " - "+_cUsuario+" Em "  + cDthr + CRLF
                cObs +=  "--> Status - " + cStatus +" Em "  + cDthr + CRLF
            EndIf
        Else
            If  nSinistMed <= nSinEmp
                cStatus  := 'Devido'
                cObs +=  "--> Sinistralidade " +transform((nSinistMed),"@E 999,999,999.99")   +"% , Qtda Vidas " + transform((nQtdaVidas),"@E 99,999") + CRLF
                cObs +=  "--> Atualizado Pelo Usuario " + _cIdUsuar+ " - "+_cUsuario+" Em "  + cDthr + CRLF
                cObs +=  "--> Status - " + cStatus +" Em "  + cDthr + CRLF
            Else 
                cStatus  := 'Indevido'
                cObs +=  "--> Sinistralidade " +transform((nSinistMed),"@E 999,999,999.99")   +"% , Qtda Vidas " + transform((nQtdaVidas),"@E 99,999") + CRLF
                cObs +=  "--> Atualizado Pelo Usuario " + _cIdUsuar+ " - "+_cUsuario+" Em "  + cDthr + CRLF
                cObs +=  "--> Status - " + cStatus +" Em "  + cDthr + CRLF
            EndIf
        EndIf 

        fPerReaj() 

        nSinistCal := nDesp / ((nMensa * nPercReaj) + nMensa ) * 100 
        nSinistMed := nSinistCal

      If  nQtdaVidas <= 29
            If  nSinistCal <= nSinPme
                cStatus  := 'Devido'
                cObs +=  "--> Pecentil Reajuste "+transform((( nPercReaj * 100 )),"@E 9,999.99") +"%  Sinistralidade Atualizada " + transform((nSinistCal),"@E 999,999,999.99") + "%  , Qtda Vidas " + transform((nQtdaVidas),"@E 99,999") + CRLF 
                cObs +=  "--> Atualizado Pelo Usuario " + _cIdUsuar+ " - "+_cUsuario+" Em "  + cDthr + CRLF
                cObs +=  "--> Status - " + cStatus +" Em "  + cDthr + CRLF
            Else 
                cStatus  := 'Indevido'
                cObs +=  "--> Percentil Reajuste "+transform((( nPercReaj * 100 )),"@E 9,999.99") +"%  Sinistralidade Atualizada " + transform((nSinistCal),"@E 999,999,999.99") + "%  , Qtda Vidas " + transform((nQtdaVidas),"@E 99,999") + CRLF
                cObs +=  "--> Atualizado Pelo Usuario " + _cIdUsuar+ " - "+_cUsuario+" Em "  + cDthr + CRLF
                cObs +=  "--> Status - " + cStatus +" Em "  + cDthr + CRLF
            EndIf
        Else
            If  nSinistCal <= nSinEmp
                cStatus  := 'Devido'
                cObs +=  "--> Percentil Reajuste "+transform((( nPercReaj * 100 )),"@E 9,999.99") +"%  Sinistralidade Atualizada " + transform((nSinistCal),"@E 999,999,999.99") + "%  , Qtda Vidas " + transform((nQtdaVidas),"@E 99,999") + CRLF
                cObs +=  "--> Atualizado Pelo Usuario " + _cIdUsuar+ " - "+_cUsuario+" Em "  + cDthr + CRLF
                cObs +=  "--> Status - " + cStatus +" Em "  + cDthr + CRLF
            Else 
                cStatus  := 'Indevido'
                cObs +=  "--> Percentil Reajuste "+transform((( nPercReaj * 100 )),"@E 9,999.99") +"%  Sinistralidade Atualizada " + transform((nSinistCal),"@E 999,999,999.99") + "%  , Qtda Vidas " + transform((nQtdaVidas),"@E 99,999") + CRLF
                cObs +=  "--> Atualizado Pelo Usuario " + _cIdUsuar+ " - "+_cUsuario+" Em "  + cDthr + CRLF
                cObs +=  "--> Status - " + cStatus +" Em "  + cDthr + CRLF
            EndIf
        EndIf 

       
        If  nOrigem == 1 .and. cStatus == 'Devido'
    
         
            fCalcBas(nOrigem)      
    
        EndIf 
    Else

      MsgAlert("Empresa  "+cCodEmp+" , Na competencia "+substr(cComptReaj ,1,4)+substr(cComptReaj ,6,2) +" , Sinistralidade ainda Não carregados, não e possivel calculo da comissão !!! - Favor Verificar  ","Atencao!")           
      
    EndIf 

Return()

static Function fCalcBas(nOrigem)

    local cqueryVd  := ' '  
    local nVlrdif   := 0
    local cVidCom   := 0  
    local cVidSem   := 0
/*
    If  nOrigem   == 1
        cStatus  := 'Calculado'
        cObs +=  "--> Atualizado Pelo Usuario " + _cIdUsuar+ " - "+_cUsuario+" Em "  + cDthr + CRLF
        cObs +=   "--> Status - " + cStatus +" Em "  + cDthr + CRLF
    EndIf
*/
        canoInc  := substr(cComptPagt,1,4)
        cmesInc  := substr(cComptPagt,6,2)
        canoFim  := substr(cComptFim,1,4)
        cmesFim  := substr(cComptFim,6,2)

        cAnoAReaj := val(substr(cComptReaj,1,4))
        cmesAReaj := val(substr(cComptReaj,6,2))
        If cmesAReaj == 1 
           cmesAReaj := 12
           cAnoAReaj--
        Else 
           cmesAReaj --
        EndIf    

    cQueryVd :=     "select bm11.bm1_ano , bm11.bm1_mes , bm11.bm1_codemp , bm11.bm1_matric , bm11.bm1_tipreg , bm11.bm1_nomusr , bm11.bm1_codpla , bm11.bm1_despla , bm11.bm1_valor , "
    
    cQueryVd +=CRLF+"       bm11.conemp conemp  , bm11.subcon subcon ,"
    
    cQueryVd +=CRLF+"       bm12.bm1_ano , bm12.bm1_mes , bm12.bm1_codemp , bm12.bm1_matric , bm12.bm1_tipreg , bm12.bm1_nomusr , bm12.bm1_codpla , bm12.bm1_despla , bm12.bm1_valor , "
    cQueryVd +=CRLF+"       (bm11.bm1_valor - bm12.bm1_valor) dif "
    cQueryVd +=CRLF+"       from "
    cQueryVd +=CRLF+"            (select bm1_ano , bm1_mes , bm1_codemp , bm1_matric , bm1_tipreg , bm1_nomusr, bm1_codpla , bm1_despla , bm1_valor , " 
     cQueryVd +=CRLF+"                   bm1_conemp conemp , bm1_subcon subcon "
    cQueryVd +=CRLF+"               from BM1020 BM1 " 
    cQueryVd +=CRLF+"              where bm1_filial =  '" + xFilial('BM1') + "'  and d_E_L_E_T_ = ' ' "
    cQueryVd +=CRLF+"                and bm1_codtip = '101' "
    cQueryVd +=CRLF+"                and bm1_codemp = '"+cCodEmp+"'"
    cQueryVd +=CRLF+"                and bm1_ano    = '"+canoInc+"'"
    cQueryVd +=CRLF+"                and bm1_mes    = '"+cmesInc+"') bm11 , "
    cQueryVd +=CRLF+"            (select bm1_ano , bm1_mes , bm1_codemp , bm1_matric , bm1_tipreg , bm1_nomusr ,bm1_codpla , bm1_despla , bm1_valor " 
    // cQueryVd +=CRLF+"               from "+RetSqlName('BM1') + " BM1 "
    cQueryVd +=CRLF+"               from BM1020 BM1 " 
    cQueryVd +=CRLF+"              where bm1_filial =  '" + xFilial('BM1') + "'  and d_E_L_E_T_ = ' ' "
    cQueryVd +=CRLF+"                and bm1_codtip = '101' "
    cQueryVd +=CRLF+"                and bm1_codemp  = '"+cCodEmp+"'"
        
    cQueryVd +=CRLF+"                and bm1_ano    = '"+strzero(cAnoAReaj,4)+"'"
    cQueryVd +=CRLF+"                and bm1_mes    = '"+strzero(cMesAReaj,2)+"') bm12 , bqc020 bqc "

//    cQueryVd +=CRLF+"                and bm1_ano    = '"+canoFim+"'"
//    cQueryVd +=CRLF+"                and bm1_mes    = '"+cmesFim+"') bm12 "
    
    cQueryVd +=CRLF+" Where bm12.bm1_codemp = bm11.bm1_codemp "
    cQueryVd +=CRLF+"   and bm12.bm1_matric = bm11.bm1_matric "
    cQueryVd +=CRLF+"   and bm12.bm1_tipreg = bm11.bm1_tipreg "  

    cQueryVd +=CRLF+"   and bqc_filial = ' ' and bqc.d_E_L_E_T_ = ' ' "
    cQueryVd +=CRLF+"   and bqc_codemp = bm11.bm1_codemp"
    cQueryVd +=CRLF+"   and bqc_numcon = bm11.conemp "
    cQueryVd +=CRLF+"   and bqc_subcon = bm11.subcon "
    cQueryVd +=CRLF+"   and (bqc_ystsco = '  ' or bqc_ystsco = '05') "
            
    If Select((cAliasVc)) <> 0 
        
    (cAliasVc)->(DbCloseArea()) 
    
    Endif 
                                
    TcQuery cQueryVd New Alias (cAliasVc)  

    cNunFat := 0

    While !(cAliasVc)->(EOF())     

        nVlrdif:= nVlrdif + (cAliasVc)->dif

        If (cAliasVc)->dif>0
 
           cVidCom++
 
        else 
        
           cVidSem++

        EndIf    

        cNunFat++

        (cAliasVc)->(DbSkip())

    EndDo
       
        If !MsgYesNo("Vidas Atualizadas "+transform(cVidCom,"@E 99,999")+", Vidas Não Atualizadas "+transform(cVidSem,"@E 99,999")+" , Total de vidas da Empresa "+transform(cVidCom+cVidsem,"@E 99,999")+" , Deseja continuar ?")
         
           lSair:=.T.
           oDlg203:End()
        
           Return() 

        EndiF
     
    If  nOrigem   == 1 .and. nVlrdif  >  0
    // If  nOrigem   == 1 .and. cNunFat > 0 

        cStatus  := 'Calculado'
        cObs     += "--> Atualizado Pelo Usuario " + _cIdUsuar+ " - "+_cUsuario+" Em "  + cDthr + CRLF
        cObs     += "--> Vidas Atualizadas "+transform(cVidCom,"@E 99,999")+", Vidas Não Atualizadas "+transform(cVidSem,"@E 99,999")+" , Total de vidas da Empresa "+transform(cVidCom+cVidsem,"@E 99,999") + CRLF
        cObs     += "--> Vidas comissionadas "+transform(cVidCom,"@E 99,999")+" , Status - " + cStatus +" Em "  + cDthr + CRLF
    
        nVlrBase:= nVlrdif

        nVlrCom := (nVlrBase/100) * nPrcExe

        oGet6:ctrlrefresh() 
        oGet8:ctrlrefresh() 
        oGet4:ctrlrefresh() 
        oGet9:ctrlrefresh() 

    Else 

        nSinistMed := 0
        cObs +=  "--> Atualizado Pelo Usuario " + _cIdUsuar+ " - "+_cUsuario+" Em "  + cDthr + CRLF
        cObs +=  "--> Reajuste Não Faturado , aguarde faturamento , Status - " + cStatus +" Em "  + cDthr + CRLF
        cObs +=  "--> Status - " + cStatus +" Em "  + cDthr + CRLF
        
        oGet4:ctrlrefresh() 
        
        MsgAlert("Empresa  "+cCodEmp+" , Na competencia "+canoInc+"/"+cmesInc+" , Não foi Observado Reajuste , !!! - Favor Verificar Competencia de aplicação ","Atencao!")       
   
    EndIF

Return()


static function fCritComp()

Local lRet      := .F.
Local cqueryCr  := ' '  

    cqueryCr  :=     " select max(pec_cmprea) cmprea , max(pec_cmppgt) cmppgt, max(pec_sequen) sequen , count(*) Qtda " 
//    cqueryCr  +=CRLF+"   from "+RetSqlName('PEC') + " PEC "
    cqueryCr  +=CRLF+"   from PEC010 PEC " 
    cqueryCr  +=CRLF+"  where PEC_filial =  '" + xFilial('PEC') + "' and d_E_L_E_T_ = ' ' "
          
    cqueryCr  +=CRLF+"    and pec_Codemp = '"+cCodEmp+"'"
    cqueryCr  +=CRLF+"    and substr(pec_cmprea,1,4) = '"+substr(cComptReaj,1,4) +"'"

    If Select((cAliasCr)) <> 0 
        
        (cAliasCr)->(DbCloseArea()) 
    
    Endif 
                                
    TcQuery cqueryCr  New Alias (cAliasCr)  

    (cAliasCr)->(DbGoTop())

    If (cAliasCr)->qtda > 0
        cCmpReaM   := (cAliasCr)->cmprea
        cCmpPgtM   := (cAliasCr)->cmppgt
        nSequenM   := (cAliasCr)->sequen
        lRet      := .T.

        cqueryCr2  :=     " select pec_status status  " 
        cqueryCr2  +=CRLF+"   from PEC010 PEC " 
        cqueryCr2  +=CRLF+"  where PEC_filial =  '" + xFilial('PEC') + "' and d_E_L_E_T_ = ' ' "
        cqueryCr2  +=CRLF+"    and pec_Codemp = '"+cCodEmp+"'"
        cqueryCr2  +=CRLF+"    and pec_cmprea = '"+cCmpReaM+"' and pec_sequen = "+ str(nSequenM)

        If Select((cAliasCr2)) <> 0 
            
            (cAliasCr2)->(DbCloseArea()) 
        
        Endif 
                                    
        TcQuery cqueryCr2  New Alias (cAliasCr2)  

        (cAliasCr2)->(DbGoTop())

        cStatusM   := (cAliasCr2)->Status 
    
    else 
     
        cCmpReaM   := ' '
        cCmpPgtM   := ' '
        nSequenM   := 0
        cStatusM   := ' ' 
        lRet       := .F.
    EndIf

Return(lRet)        

static function fPaga()

    local lfazgrv  := .F.
    Local cqueryCC := ' '
   // Local _recPec  := 0

    cqueryCC :=        " select pdx_codigo equipe , pdx_nome Nome  , PDX_MATFUC Matric , PDX_VERBA Verba , PDX_PERCEN Perct, PDX_CCUSTO Ccusto , " 
    cqueryCC +=  CRLF+ "        pec_codemp  CodEmp , pec_cmprea ComptReaj, pec_cmppgt ComptPgto , pec_cmpini ComptIni, PEC.PEC_CMPFIM CompteFim, " 
    cqueryCC +=  CRLF+ "        PEC.PEC_VLRBAS VlrBase , PEC.PEC_VLRCOM VlrBCom  , ((pec_vlrcom/100)*PDX_PERCEN) VlrCom , PEC_PERCBS PERCBS , pec.R_E_C_N_O_ Pecrec"
    cqueryCC +=  CRLF+ "   from pdX010 PDX , PEC010 PEC "
    cqueryCC +=  CRLF+ "  WHERE PDX_FILial = ' '"
    cqueryCC +=  CRLF+ "    and PDX.d_E_L_E_T_ = ' '"
    cqueryCC +=  CRLF+ "    AND PEC_FILial = '01'"
    cqueryCC +=  CRLF+ "    and PEC.d_E_L_E_T_ = ' '"
    cqueryCC +=  CRLF+ "    and pdx_codigo = PEC_EQUIPE"
    cqueryCC +=  CRLF+ "    AND PEC_STATUS = 'Calculado'"
    cqueryCC +=  CRLF+ "    AND PEC_CODEMP = '"+cCodEmp+"'"

    cqueryCC +=  CRLF+ "    AND SUBSTR(PDX_DATINI,1,6) <= '"+substr(cComptReaj ,1,4)+substr(cComptReaj ,6,2) +"'"
    cqueryCC +=  CRLF+ "    AND ( PDX_DATFIM = ' ' OR SUBSTR(PDX_DATFIM,1,6) > '"+substr(cComptReaj ,1,4)+substr(cComptReaj ,6,2) +"')"
			 
    If Select((cAliasCc)) <> 0 
        (cAliasCc)->(DbCloseArea())    
    Endif

	TcQuery cqueryCC New Alias (cAliasCc)        
	(cAliasCc)->(dbGoTop())
		
	DBSELECTAREA("PDU")   
    PDU->(dbSetOrder(1))


    cStatus := 'Pago'
    cObs +=  "--> Atualizado Pelo Usuario " + _cIdUsuar+ " - "+_cUsuario+" Em "  + cDthr + CRLF 
    dDtPgtoCom :=Date()

    While (cAliasCc)->(!Eof())  

    If (cAliasCc)->VlrCom > 0
                      
        PDU->(Reclock("PDU",.T.))

            PDU->PDU_FILIAL  := xFilial('PDU')   
			PDU->PDU_CODEQP  := (cAliasCc)->equipe        // NOT NULL CHAR(6)  
			PDU->PDU_CODEMP  := (cAliasCc)->CodEmp        // NOT NULL CHAR(6)  
			PDU->PDU_NOME    := (cAliasCc)->NOME          // NOT NULL CHAR(30) 
			PDU->PDU_USUAR   := _cUsuario                 // NOT NULL CHAR(20) 
			PDU->PDU_DATFOL  := dDataBase                 // NOT NULL CHAR(8)  
			PDU->PDU_DATINC  := dDataBase                 // NOT NULL CHAR(8)  
			PDU->PDU_MATFUC  := (cAliasCc)->Matric        // NOT NULL CHAR(6)  
			PDU->PDU_COMPTE  := (cAliasCc)->ComptReaj     // NOT NULL CHAR(6)   
			PDU->PDU_VERBA   := (cAliasCc)->VERBA         // NOT NULL CHAR(3)  
			PDU->PDU_TITREC  := ' '                       // NOT NULL CHAR(17) 
			PDU->PDU_TITPGT  := ' '                       // NOT NULL CHAR(17) 
			PDU->PDU_VLRPGT  := (cAliasCc)->VlrCom   
			PDU->PDU_VLRBAS  := (cAliasCc)->VlrBCom 
			PDU->PDU_PERCEN  := (cAliasCc)->Perct         //NOT NULL NUMBER   
            PDU->PDU_OBS     := "Usuario : " +_cUsuario + " Data Hora Geração " +cDthr
		    PDU->PDU_CCUSTO  := (cAliasCc)->CCUSTO
			PDU->PDU_VBASIN  := (cAliasCc)->VlrBase       //NOT NULL NUMBER   
            PDU->PDU_PERINT  := (cAliasCc)->PERCBS        // NOT NULL NUMBER PDU_
            PDU->PDU_PGTO    := 'N'
        //    PDU->PDU_APROV   := ' '      

		PDU->(MsUnlock())

            DbGoto((cAliasCc)->PecRec)
                 
            cObs +=  "--> Pago Ao Colaboador  "+(cAliasCc)->NOME+" Valor Comissão R$ "+transform((cAliasCc)->VlrCom ,"@E 99,999.99")+" - Em "  + cDthr + CRLF	            
            
            lfazgrv  := .T.
    EndIf                    
            
        (cAliasCc)->(DbSkip())    
    
    EndDo
 

    If  lfazgrv == .T.
    
        fGrava()
    
    Else 

        MsgAlert("Empresa  "+cCodEmp+" , Na competencia "+substr(cComptReaj ,1,4)+substr(cComptReaj ,6,2) +" , ainda Não foi faturado !!! - Favor Verificar  ","Atencao!")
    
    EndIf 
Return()    


static function fVerifReaj(cCompteInc, cCompteFim, cCodemp )

    local cAnoInc  := val(substr(cCompteInc,1,4))
    local cMesInc  := val(substr(cCompteInc,6,2))
    local cAnoFim  := substr(cCompteFim,1,4)
    local cMesFim  := substr(cCompteFim,6,2)

    Local cqueryVRj := ' '
    local aLogLtaVRJ:= {}

    If cMesInc == 01
    
       cAnoInc--
       cMesInc  := 12
    
    Else 
    
        cMesInc-- 
    
    EndIf   

cqueryVRj :=        " select bm11.bm1_codemp codemp , bm11.bm1_conemp conemp , bm11.bm1_subcon subcon , substr(BQC.BQC_DESCRI,1,30) descri , "
cqueryVRj +=  CRLF+ "        case when(bm12.bm1_valor - bm11.bm1_valor) > 0 " 
cqueryVRj +=  CRLF+ "             then  'Sim' "
cqueryVRj +=  CRLF+ "             Else  'Não' end  Reaj , "
cqueryVRj +=  CRLF+ "        Sum (case when(bm12.bm1_valor - bm11.bm1_valor) > 0 " 
cqueryVRj +=  CRLF+ "              then  1 "
cqueryVRj +=  CRLF+ "              Else 0 end) QtdReaj , "
cqueryVRj +=  CRLF+ "        count(*) QtdTot , "
cqueryVRj +=  CRLF+ "        Sum(bm12.bm1_valor - bm11.bm1_valor) vlrReaj "
cqueryVRj +=  CRLF+ "   from BQC020 BQC , "
cqueryVRj +=  CRLF+ "        (select bm1_ano , bm1_mes , bm1_codemp , bm1_matric , bm1_tipreg , bm1_nomusr, bm1_codpla , bm1_despla , bm1_valor ,bm1_conemp , bm1_subcon "
cqueryVRj +=  CRLF+ "           from BM1020 BM1 "
cqueryVRj +=  CRLF+ "          where bm1_filial =  '  '  and d_E_L_E_T_ = ' ' " 
cqueryVRj +=  CRLF+ "            and bm1_codtip = '101' "
cqueryVRj +=  CRLF+ "            and bm1_codemp = '"+ cCodEmp +"'"
cqueryVRj +=  CRLF+ "            and bm1_ano    = '"+ strzero(cAnoInc,4) +"'"
cqueryVRj +=  CRLF+ "            and bm1_mes    = '"+ strzero(cMesInc,2) +"') bm11 , "
cqueryVRj +=  CRLF+ "        (select bm1_ano , bm1_mes , bm1_codemp , bm1_matric , bm1_tipreg , bm1_nomusr ,bm1_codpla , bm1_despla , bm1_valor ,bm1_conemp , bm1_subcon "
cqueryVRj +=  CRLF+ "           from BM1020 BM1 "
cqueryVRj +=  CRLF+ "          where bm1_filial =  '  '  and d_E_L_E_T_ = ' ' " 
cqueryVRj +=  CRLF+ "        and bm1_codtip = '101' "
cqueryVRj +=  CRLF+ "        and bm1_codemp = '"+ cCodEmp +"'"
cqueryVRj +=  CRLF+ "        and bm1_ano    = '"+ cAnoFim +"'"
cqueryVRj +=  CRLF+ "        and bm1_mes    = '"+ cMesFim +"') bm12 "
cqueryVRj +=  CRLF+ "  Where bm12.bm1_codemp = bm11.bm1_codemp "
cqueryVRj +=  CRLF+ "    and bm12.bm1_matric = bm11.bm1_matric "
cqueryVRj +=  CRLF+ "    and bm12.bm1_tipreg = bm11.bm1_tipreg "
cqueryVRj +=  CRLF+ "    and bm12.bm1_conemp = bm11.bm1_conemp "
cqueryVRj +=  CRLF+ "    and bm12.bm1_subcon = bm11.bm1_subcon "
cqueryVRj +=  CRLF+ "    and BQC.BQC_CODIGO  = '0001'||BM11.BM1_CODEMP "
cqueryVRj +=  CRLF+ "    and BQC.BQC_NUMCON  = BM11.BM1_conemp "
cqueryVRj +=  CRLF+ "    and BQC.BQC_SUBCON  = BM11.BM1_SUBCON "
cqueryVRj +=  CRLF+ "  group by bm11.bm1_codemp , bm11.bm1_conemp , BM11.BM1_SUBCON , BQC.BQC_DESCRI ,"
cqueryVRj +=  CRLF+ "        case when(bm12.bm1_valor - bm11.bm1_valor) > 0 " 
cqueryVRj +=  CRLF+ "             then 'Sim' "
cqueryVRj +=  CRLF+ "             Else 'Não' end "  

cqueryVRj +=  CRLF+ "  Order by bm11.bm1_codemp , bm11.bm1_conemp , BM11.BM1_SUBCON "


/////////////////////////

	If Select((cAliasVRJ)) <> 0 
			 (cAliasVRJ)->(DbCloseArea())  
	Endif                          

    TCQuery cQueryVRJ New Alias (cAliasVRJ)   

	(cAliasVRJ)->( DbGoTop() )

    If !(cAliasVRJ)->(EOF())
    
    	While !(cAliasVRJ)->(EOF())

	    	aAdd(aLogLtaVRJ,{ TRIM((cAliasVRJ)->codEmp)      ,; 
		       			      trim((cAliasVRJ)->conEmp)      ,; 
			    			  trim((cAliasVRJ)->subcon)      ,; 
                              trim((cAliasVRJ)->descri)      ,; 
                              trim((cAliasVRJ)->Reaj)        ,;  
						      transform(((cAliasVRJ)->QtdReaj),"@E 999,999") ,;
    						  transform(((cAliasVRJ)->QtdTot) ,"@E 999,999") ,;
	    					  transform(((cAliasVRJ)->VlrReaj),"@E 999,999.99") })     //3 
    
	    			nQtdReajT  := nQtdReajT  + (cAliasVRJ)->QtdReaj
		    		nQtdTotT   := nQtdTotT   + (cAliasVRJ)->QtdTot
			    	nVlrReajT  := nVlrReajT  + (cAliasVRJ)->VlrReaj

	    		(cAliasVRJ)->(DbSkip())

        EndDo

        aAdd(aLogLtaVRJ,{ ' '    ,; 
   	    		          'Totais   --->' ,;
					      ' '   ,;
                          ' '   ,;
                          ' '   ,;   
		           		  transform((nQtdReajT) ,"@E 999,999") ,;
        				  transform((nQtdTotT)  ,"@E 999,999") ,;
						  transform((nVlrReajT) ,"@E 999,999.99")})

			PLSCRIGEN(aLogLtaVRJ,{{'Cod Empresa',"@!",20}     ,;
								  {'Contrato',"@!",20} ,;
								  {'Sub Contrato',"@!",20} ,;
							   	  {'Descrição' ,"@!",120} ,;
                                  {'Reajustado' ,"@!",20} ,;
								  {'Qtda Reajst' ,"@!",20} ,;
								  {'Qtad Total ' ,"@!",20},;
                                  {'Vlr Reajuste' ,"@!",30}},;
								   'Resultado Reajuste entre as Competencia Inicial '+strzero(cAnoInc,4)+"/"+strzero(cMesInc,2) +' e Final '+ cAnoFim +"/"+cMesFim ,nil,nil) 
   
    Else 

        MsgAlert("Para as Competencia Inicial "+strzero(cAnoInc,4)+"/"+strzero(cMesInc,2) +"e Final "+ cAnoFim +"/"+cMesFim + CRLF ;
        + "NÃO foram encontrados lançamentos de faturamento !!! ","Atencao!")

    EndIf     
   
    nQtdReajT  := 0.00
    nQtdTotT   := 0.00
    nVlrReajT  := 0.00

Return()
////////////////////////////////

static function fPerReaj()

    Local cqueryPR := ' '

    local cAnoInc  := val(substr(cComptReaj,1,4))
    local cMesInc  := val(substr(cComptReaj,6,2))
    local cAnoFim  := substr(cComptPagt,1,4)
    local cMesFim  := substr(cComptPagt,6,2)

    If cMesInc == 01
       cMesInc := 12
       cAnoInc := cAnoInc -1 
    Else  
     cMesInc:= cMesInc - 1  
    EndIf 

  cqueryPR :=        "select Sum(bm12.bm1_valor) vlrapos , "
  cqueryPR +=  CRLF+ "       sum(bm11.bm1_valor) vlrant , "
  cqueryPR +=  CRLF+ "       TRUNC((((Sum(bm12.bm1_valor))/(sum(bm11.bm1_valor)))-1),4) "
  cqueryPR +=  CRLF+ "  from BQC020 BQC , "
  cqueryPR +=  CRLF+ "       (select bm1_ano , bm1_mes , bm1_codemp , bm1_matric , bm1_tipreg , bm1_nomusr, bm1_codpla , bm1_despla , bm1_valor ,bm1_conemp , bm1_subcon "
  cqueryPR +=  CRLF+ "       from BM1020 BM1 "
  cqueryPR +=  CRLF+ "      where bm1_filial =  '  '  and d_E_L_E_T_ = ' ' " 
  cqueryPR +=  CRLF+ "        and bm1_codtip = '101' "
  cqueryPR +=  CRLF+ "        and bm1_codemp = '"+ cCodEmp +"'"
  cqueryPR +=  CRLF+ "        and bm1_ano    = '"+ strzero(cAnoInc,4) +"'"
  cqueryPR +=  CRLF+ "        and bm1_mes    = '"+ strzero(cMesInc,2) +"') bm11 , " 
  cqueryPR +=  CRLF+ "       (select bm1_ano , bm1_mes , bm1_codemp , bm1_matric , bm1_tipreg , bm1_nomusr ,bm1_codpla , bm1_despla , bm1_valor ,bm1_conemp , bm1_subcon "
  cqueryPR +=  CRLF+ "          from BM1020 BM1 "
  cqueryPR +=  CRLF+ "         where bm1_filial =  '  '  and d_E_L_E_T_ = ' ' "
  cqueryPR +=  CRLF+ "           and bm1_codtip = '101' "
  cqueryPR +=  CRLF+ "           and bm1_codemp = '"+ cCodEmp +"'"
  cqueryPR +=  CRLF+ "           and bm1_ano    = '"+ cAnoFim +"'"
  cqueryPR +=  CRLF+ "           and bm1_mes    = '"+ cMesFim +"' ) bm12 "
  cqueryPR +=  CRLF+ " Where bm12.bm1_codemp = bm11.bm1_codemp "
  cqueryPR +=  CRLF+ "   and bm12.bm1_matric = bm11.bm1_matric "
  cqueryPR +=  CRLF+ "   and bm12.bm1_tipreg = bm11.bm1_tipreg "
  cqueryPR +=  CRLF+ "   and bm12.bm1_conemp = bm11.bm1_conemp "
  cqueryPR +=  CRLF+ "   and bm12.bm1_subcon = bm11.bm1_subcon "
  cqueryPR +=  CRLF+ "   and BQC.BQC_CODIGO  = '0001'||BM11.BM1_CODEMP "
  cqueryPR +=  CRLF+ "   and BQC.BQC_NUMCON  = BM11.BM1_conemp "
  cqueryPR +=  CRLF+ "   and BQC.BQC_SUBCON  = BM11.BM1_SUBCON "
  cqueryPR +=  CRLF+ "   and (BQC.BQC_YSTSCO = '  ' or BQC.BQC_YSTSCO = '05') "

			 
    If Select((cAliasPR)) <> 0 
        (cAliasPR)->(DbCloseArea())    
    Endif

	TcQuery cqueryPr New Alias (cAliasPR)        
	(cAliasPr)->(dbGoTop())

    nPercReaj := ((cAliasPr)->vlrapos / (cAliasPr)->vlrant ) - 1 
		
Return()
