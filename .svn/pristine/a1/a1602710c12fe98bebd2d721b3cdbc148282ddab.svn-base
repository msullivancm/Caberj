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
±±ºPrograma  ³acertapcc ºAutor  ³ Altamiro	         º Data ³  19/06/2015 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Tela de browser do de acerto do PCC                       º±±
±±º          ³ 															  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function acertapcc()                 

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta matriz com as opcoes do browse...                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE aRotina	:=	{	{ "&Visualizar"	, "u_acpcc1"    , 0 , 1	 },;       
					      	{ "&Alteracao"	, "u_acpcc1"	, 0 , 2  },;
                        { "&Incluir"	, "u_acpcc1"  	, 0 , 3	 },;
                        { "Legenda"		, "U_LEGPROSPCC", 0 , 3	 }}  
						
						

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Titulo e variavies para indicar o status do arquivo                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE cCadastro	:= "Browser do Sistema juridico "
/*
'BR_PRETO'    
'BR_AMARELO'            
'BR_VERDE'    
'BR_AZUL'                 
'BR_CINZA'    
'BR_PINK'            
'BR_LARANJA'  
'BR_MARRON'    
'BR_VERMELHO' 

*/

PRIVATE aCdCores	:= { 	{ 'BR_VERDE'    ,'PREFIXO  CLI' },;
							{ 'BR_AZUL'     ,'PREFIXO  HOS' },; 
							{ 'BR_VERMELHO' ,'PREFIXO  ODN' },;							
							{ 'BR_AMARELO'  ,'PREFIXO  CON' },;
							{ 'BR_PRETO'    ,'PREFIXO  SVD' },;
							{ 'BR_LARANJA'  ,'PREFIXO  OPE' },;
							{ 'BR_PINK'     ,'PREFIXO  REC' }}   
							
							

PRIVATE aCores	:= {{'e2_prefixo=="CLI"', aCdCores[1,1]},;
						{'e2_prefixo=="HOS"', aCdCores[2,1]},;
						{'e2_prefixo=="ODN"', aCdCores[3,1]},;
						{'e2_prefixo=="CON"', aCdCores[4,1]},;
						{'e2_prefixo=="SVD"', aCdCores[5,1]},;
						{'e2_prefixo=="OPE"', aCdCores[6,1]},;
						{'e2_prefixo=="REC"', aCdCores[7,1]	}}
//PRIVATE cPath  := ""                        
PRIVATE cAlias := "SE2" 

PRIVATE cPerg	:= " "

PRIVATE cNomeProg   := "ACERTAPCC"
PRIVATE nQtdLin     := 68
PRIVATE nLimite     := 132
PRIVATE cControle   := 15
PRIVATE cTamanho    := "G"
PRIVATE cTitulo     := "Acerto Pcc "
PRIVATE cDesc1      := ""
PRIVATE cDesc2      := ""
PRIVATE cDesc3      := ""
PRIVATE nRel        := "ACERTOPCC"
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
PRIVATE cCabec1     := "Acerto Pcc"
PRIVATE cCabec2     := ""
PRIVATE nColuna     := 00  
private lFaz        := .F.  
private cCodusu     := SubStr(cUSUARIO,7,5)
private dDtVcRea    := "  " 
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Starta mBrowse...                                                   ³         
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ     
dbselectarea("SE2")
SE2->(DBSetOrder(1))     
//SET FILTER TO ((e2_valor+e2_irrf+e2_iss)> 215.17 .AND. e2_saldo == e2_valor .and. e2_codret == '1708' .AND. ALLTRIM(e2_tipo) = 'FT' .and. e2_vretpis==0 .and. e2_vretcof==0 .and. e2_vretcsl==0 )
SET FILTER TO ( e2_saldo == e2_valor .and. e2_codret == '1708' .AND. ALLTRIM(e2_tipo) $ 'FT|DP' )

//SET FILTER TO ((e2_valor+e2_irrf+e2_iss)> 215.17 .AND. e2_saldo > 0 .AND. trim(e2_naturez) == '40002002' .and. (e2_vretpis==0 .and. e2_vretcof==0 .and. e2_vretcsl==0 ).and. e2_vencrea <= '20150731') 
//PBW->(mBrowse(006,001,022,075,"PBW" , , , , , Nil    , aCores, , , ,nil, .T.))  
SE2->(mBrowse(006,001,022,075,"SE2" , , , , , 2    , aCores, , , ,nil, .F.)) 
//mBrowse(6, 1, 22, 75, "PBW",,,,,,aCores)
SE2->(DbClearFilter())
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
USER Function LEGPROSPCC()
Local aLegenda

	aLegenda 	:= { 	{ aCdCores[1,1],aCdCores[1,2] },;
						{ aCdCores[2,1],aCdCores[2,2] },;
						{ aCdCores[3,1],aCdCores[3,2] },;
	              	{ aCdCores[4,1],aCdCores[4,2] },;
	              	{ aCdCores[5,1],aCdCores[5,2] } }

	                     	
BrwLegenda(cCadastro,"Status" ,aLegenda)

Return

user Function acpcc1(OPC1, OPC2, OPC3)

/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±± Declaração de cVariable dos componentes                                 ±±
Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/          

DbGoto(OPC2)   
private cRecnoSe2  := OPC2
Private cFornce    := se2->e2_nomfor
Private cNaturez   := se2->e2_naturez 
Private cNum       := se2->e2_num 
Private cObs       := ' '
Private cParcel    := se2->e2_parcela
Private cPrefix    := se2->e2_prefixo 
Private cRetCofis  := Space(1)
Private cRetCsl    := Space(1)
Private cRetIrrf   := Space(1)
Private cRetPis    := Space(1)
Private cTipo      := se2->e2_tipo
Private dDtEmis    := se2->e2_emissao
Private dDtVenc    := se2->e2_vencrea
Private nVlCofs    := se2->e2_vretcof  //Transform(se2->e2_vretcof  ,"@R 999,999,999.99")  //picture "@E 9,999,999.99") 
Private nVlCofsN   := 0
Private nVlCsll    := se2->e2_vretcsl //Transform(se2->e2_vretcsl ,"@R 999,999,999.99")  //picture "@E 9,999,999.99") 
Private nVlCsllN   := 0
Private nVlIrrf    := se2->e2_irrf //Transform(se2->e2_irrf ,"@R 999,999,999.99")  //picture "@E 9,999,999.99") 
Private nVlIss     := se2->e2_iss  //Transform(se2->e2_iss  ,"@R 999,999,999.99")   //picture "@E 9,999,999.99") 
Private nVlIssN    := 0
Private nVlPis     := se2->e2_vretpis //Transform(se2->e2_vretpis ,"@R 999,999,999.99")  //picture "@E 9,999,999.99") 
Private nVlPisN    := 0
Private nVlSdTit   := se2->e2_SALDO
Private nVlSdTitN  := 0
Private nVlIrrfN   := 0
Private nVlTTit    := (se2->e2_valor + se2->e2_iss + se2->e2_irrf + se2->e2_vretpis + se2->e2_vretcof + se2->e2_vretcsl )
Private nVlTTitN   := 0    
Private lAtVenRea  :=.F.
PRIVATE cNatSa2    := ' ' 
private dDtVcRea   := se2->e2_vencrea	 

SA2->(dbsetorder(1))
IF SA2->(dbseek(xFilial("SA2")+trim(se2->e2_FORNECE)))  

   If sa2->a2_reccofi== '1'
      cRetCofis  := 'Sim'
   Else                 
      cRetCofis  :='Não'
   EndIf         
                           
   If sa2->a2_reccsll == '1'
      cRetCsl  :='Sim'
   Else                 
      cRetCsl  :='Não'
   EndIf   

   If sa2->a2_recpis == '1'
      cRetPis  :='Sim'
   Else                 
      cRetPis  :='Não'
   EndIf         

   If sa2->a2_calcirf == '1' .or. sa2->a2_calcirf ==  '2' 
      cRetIrrf  :='Sim'
   Else                 
      cRetIrrf  :='Não'
   EndIf
   
   if !empty(sa2->a2_naturez) 
      cNatSa2    := sa2->a2_naturez
   Else                              
      cNatSa2    := se2->e2_naturez
   EndIf   
   
EndIf  
/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±± Declaração de Variaveis Private dos Objetos                             ±±
Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/
SetPrvt("oDlg1","oSay26","oGrp1","oSay1","oSay2","oSay3","oSay4","oSay5","oSay6","oSay7","oSay9","oSay8")
SetPrvt("oSay11","oSay27","oGet1","oGet2","oGet3","oGet4","oGet5","oGet6","oGet7","oGet8","oGet9","oGet10")
SetPrvt("oBtn1","oBtn2","oGet27","oGet28","oCBox1","oGrp2","oSay12","oSay13","oSay14","oSay15","oSay16","oSay17","oBtn3" )
SetPrvt("oGet12","oGet13","oGet14","oGet15","oGet16","oGet17","oGet18","oGrp3","oSay19","oSay20","oSay21")
SetPrvt("oSay23","oSay24","oSay25","oGet19","oGet20","oGet21","oGet22","oGet23","oGet24","oGet25","oGet26")

/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±± Definicao do Dialog e todos os seus componentes.                        ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±*/
oDlg1      := MSDialog():New( 162,490,597,966,"                           **** Acerto Titulos  Com Iimpostos - PCC ********",,,.F.,,,,,,.T.,,,.T. )
oSay26     := TSay():New( 204,000,{||"Obs: "},oDlg1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oGrp1      := TGroup():New( 000,000,092,236,"Identificação do Titulo ",oDlg1,CLR_GREEN,CLR_WHITE,.T.,.F. )
oSay1      := TSay():New( 012,004,{||"Prefixo "},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,020,008)
oSay2      := TSay():New( 012,024,{||"Numero "},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,020,008)
oSay3      := TSay():New( 012,056,{||"Parcela "},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,020,008)
oSay4      := TSay():New( 012,080,{||"Tipo "},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay5      := TSay():New( 032,004,{||"Fornecedor "},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,036,008)
oSay6      := TSay():New( 012,100,{||"Emissao "},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay7      := TSay():New( 012,149,{||"Vencimento "},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay9      := TSay():New( 056,008,{||"Ret PIS"},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,020,008)
oSay8      := TSay():New( 057,041,{||"Ret COFINS"},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,031,008)
oSay10     := TSay():New( 057,077,{||"Ret CSLL"},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,027,008)
oSay11     := TSay():New( 057,118,{||"Ret IRRF"},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,027,008)
oSay27     := TSay():New( 057,154,{||"Nat. Cadast"},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)

oSay28     := TSay():New( 080,078,{||"Venc.Real"},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)

oGet1      := TGet():New( 020,004,{|u| If(PCount()>0,cPrefix:=u,cPrefix)},oGrp1,016,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cPrefix",,)
oGet2      := TGet():New( 020,024,{|u| If(PCount()>0,cNum:=u,cNum)},oGrp1,028,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cNum",,)
oGet3      := TGet():New( 020,060,{|u| If(PCount()>0,cParcel:=u,cParcel)},oGrp1,008,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cParcel",,)
oGet4      := TGet():New( 020,080,{|u| If(PCount()>0,cTipo:=u,cTipo)},oGrp1,016,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cTipo",,)
oGet5      := TGet():New( 040,004,{|u| If(PCount()>0,cFornce:=u,cFornce)},oGrp1,180,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cFornce",,)
oGet6      := TGet():New( 020,100,{|u| If(PCount()>0,dDtEmis:=u,dDtEmis)},oGrp1,036,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","dDtEmis",,)
oGet7      := TGet():New( 020,149,{|u| If(PCount()>0,dDtVenc:=u,dDtVenc)},oGrp1,036,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","dDtVenc",,)
oGet8      := TGet():New( 065,079,{|u| If(PCount()>0,cRetCsl:=u,cRetCsl)},oGrp1,028,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cRetCsl",,)
oGet9      := TGet():New( 065,005,{|u| If(PCount()>0,cRetPis:=u,cRetPis)},oGrp1,027,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cRetPis",,)
oGet10     := TGet():New( 065,042,{|u| If(PCount()>0,cRetCofis:=u,cRetCofis)},oGrp1,027,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cRetCofis",,)
oGet11     := TGet():New( 065,116,{|u| If(PCount()>0,cRetIrrf:=u,cRetIrrf)},oGrp1,028,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cRetIrrf",,)

oBtn1      := TButton():New( 024,196,"&Gravar ",oGrp1,{||fgrava()},032,012,,,,.T.,,"",,,,.F. )
oBtn2      := TButton():New( 040,196,"&Descartar ",oGrp1,{||fdescarta()},032,012,,,,.T.,,"",,,,.F. )
oBtn3      := TButton():New( 009,197,"&Calcular ",oGrp1,{||ACERTPCC1(cRecnoSe2) },032,012,,,,.T.,,"",,,,.F. )

oGet27     := TGet():New( 065,152,{|u| If(PCount()>0,cNatSa2 :=u,cNatSa2 )},oGrp1,060,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cNatSa2",,)

oGet28     := TGet():New( 080,110,{|u| If(PCount()>0,dDtVcRea:=u,dDtVcRea)},oGrp1,042,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","dDtVcRea",,)

oCBox1     := TCheckBox():New( 080,004,"Atual. Venc Real",{|u| If(PCount()>0,lAtVenRea:=u,lAtVenRea)},oGrp1,064,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
oGrp2      := TGroup():New( 096,000,148,236,"Valores Atuais ",oDlg1,CLR_BLACK,CLR_WHITE,.T.,.F. )
oSay12     := TSay():New( 104,004,{||"Vlr Total Tit."},oGrp2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,028,008)
oSay13     := TSay():New( 105,069,{||"Vlr Total Saldo "},oGrp2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,039,008)
oSay14     := TSay():New( 105,125,{||"Vlr Total Irrf"},oGrp2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,028,008)
oSay15     := TSay():New( 126,174,{||"Vlr Total CSLL"},oGrp2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,046,008)
oSay16     := TSay():New( 126,090,{||"Vlr Total COFINS."},oGrp2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,046,008)
oSay17     := TSay():New( 125,005,{||"Vlr Total PIS"},oGrp2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,043,008)
oSay18     := TSay():New( 106,178,{||"Vlr Total Iss"},oGrp2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,034,008)
oGet12     := TGet():New( 112,004,{|u| If(PCount()>0,nVlTotTit:=u,nVlTTit)},oGrp2,056,008,'@E 9,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nVlTTit",,)
oGet13     := TGet():New( 112,069,{|u| If(PCount()>0,nVlSaldTit:=u,nVlSdTit)},oGrp2,047,008,'@E 9,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nVlSdTit",,)
oGet14     := TGet():New( 112,125,{|u| If(PCount()>0,nVlIrrf:=u,nVlIrrf)},oGrp2,043,008,'@E 9,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nVlIrrf",,)
oGet15     := TGet():New( 134,174,{|u| If(PCount()>0,nVlCsll:=u,nVlCsll)},oGrp2,060,008,'@E 9,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nVlCsll",,)
oGet16     := TGet():New( 134,090,{|u| If(PCount()>0,nVlCofs:=u,nVlCofs)},oGrp2,060,008,'@E 9,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nVlCofs",,)
oGet17     := TGet():New( 133,005,{|u| If(PCount()>0,nVlPis:=u,nVlPis)},oGrp2,060,008,'@E 9,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nVlPis",,)
oGet18     := TGet():New( 112,178,{|u| If(PCount()>0,nVlIss:=u,nVlIss)},oGrp2,050,008,'@E 9,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nVlIss",,)
oGrp3      := TGroup():New( 149,000,201,236,"Valores Atualizados ",oDlg1,CLR_BLACK,CLR_WHITE,.T.,.F. )
oSay19     := TSay():New( 157,178,{||"Vlr Total Iss"},oGrp3,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,034,008)
oSay20     := TSay():New( 157,125,{||"Vlr Total Irrf"},oGrp3,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,028,008)
oSay21     := TSay():New( 157,069,{||"Vlr Total Saldo "},oGrp3,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,039,008)
oSay22     := TSay():New( 157,004,{||"Vlr Total Tit."},oGrp3,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,028,008)
oSay23     := TSay():New( 177,174,{||"Vlr Total CSLL"},oGrp3,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,046,008)
oSay24     := TSay():New( 177,090,{||"Vlr Total COFINS."},oGrp3,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,046,008)
oSay25     := TSay():New( 177,005,{||"Vlr Total PIS"},oGrp3,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,043,008)
oGet19     := TGet():New( 165,178,{|u| If(PCount()>0,nVlIssN:=u  ,nVlIssN)},oGrp3,050,008,'@E 9,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nVlIssN",,)
oGet20     := TGet():New( 165,125,{|u| If(PCount()>0,nVlIrrfN:=u ,nVlIrrfN)},oGrp3,043,008,'@E 9,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nVlIrrfN",,)
oGet21     := TGet():New( 165,069,{|u| If(PCount()>0,nVlSdTitN:=u,nVlSdTitN)},oGrp3,047,008,'@E 9,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nVlSdTitN",,)
oGet22     := TGet():New( 165,004,{|u| If(PCount()>0,nVlTTitN:=u ,nVlTTitN)},oGrp3,056,008,'@E 9,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nVlTTitN",,)
oGet23     := TGet():New( 185,174,{|u| If(PCount()>0,nVlCsllN:=u ,nVlCsllN)},oGrp3,060,008,'@E 9,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nVlCsllN",,)
oGet24     := TGet():New( 185,090,{|u| If(PCount()>0,nVlCofsN:=u ,nVlCofsN)},oGrp3,060,008,'@E 9,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nVlCofsN",,)
oGet25     := TGet():New( 185,005,{|u| If(PCount()>0,nVlPisN:=u  ,nVlPisN)},oGrp3,060,008,'@E 9,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nVlPisN",,)
oGet26     := TGet():New( 204,012,{|u| If(PCount()>0,cObs:=u,cObs)},oDlg1,220,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cObs",,)

      oGet19:ctrlrefresh()
      oGet20:ctrlrefresh()
      oGet21:ctrlrefresh()
      oGet22:ctrlrefresh()
      oGet23:ctrlrefresh()
      oGet24:ctrlrefresh()
      oGet25:ctrlrefresh()
      oGet26:ctrlrefresh()   
      
 if nVlTTitN == 0 
     oBtn1:Disable()
  Else 
     oBtn1:enable()  
  EndIf     
  
      
oDlg1:Activate(,,,.T.)         


Return


static Function ACERTPCC1(cRecnoSe2)
    //private cRecnoSe2  := OPC2
    Local cFilSe2	:= xFilial("SE2")
	Private lMsHelpAuto	:= .T.
	Private lMsErroAuto	:= .F.
	//Private aRotina		:= {{"","",0,1},{"","",0,2},{"","",0,3},{"","",0,4},{"","Fa050Delet",0,5}}
	Private cCadastro	:= ""
	Private lAltera		:= .F.
	Private lF050Auto	:= .T.
	Private nRecno		:= 0    
	private vlrtot      := se2->e2_valor + se2->e2_iss + se2->e2_irrf + se2->e2_vretpis + se2->e2_vretcof + se2->e2_vretcsl 
	private vlrtot50    := (se2->e2_valor + se2->e2_iss + se2->e2_irrf + se2->e2_vretpis + se2->e2_vretcof + se2->e2_vretcsl)+50.00  
    nVlTTit:=vlrtot
    oget12:ctrlrefresh()
                                  
    oBtn3:Disable()
    
   
    
        SE2->(DBSEEK(se2->e2_filial+se2->e2_prefixo+se2->e2_num+se2->e2_parcela+se2->e2_tipo+se2->E2_FORNECE+se2->e2_loja))      
     	
/*     	dbSelectArea("SA2")
        dbSetOrder(1)
        
       	SA2->(DBSEEK(SA2->A2_FILIAL+se2->E2_FORNECE+se2->e2_loja))    */
        //vlrtot:= (TMP->vlrtot+50.00)

         vlrtot      := se2->e2_valor + se2->e2_iss + se2->e2_irrf + se2->e2_vretpis + se2->e2_vretcof + se2->e2_vretcsl 
         vlrtot50    := (se2->e2_valor + se2->e2_iss + se2->e2_irrf + se2->e2_vretpis + se2->e2_vretcof + se2->e2_vretcsl)+50.00  

        BEGIN Transaction
   
//			{"E2_NATUREZ"  ,(cAliasTmp)->E1_NATUREZ ,Nil}, {"E2_FORNECE"  ,cCodFor                 ,Nil},;      
		  	aDadSe2 :={{"E2_FILIAL"   ,se2->e2_filial       ,.F.},;
			           {"E2_PREFIXO"  ,se2->e2_prefixo      ,.F.},;  
   			           {"E2_NUM"      ,se2->e2_num          ,.F.},;
   			           {"E2_PARCELA"  ,se2->e2_parcela      ,.F.},; 
   			           {"E2_TIPO"     ,se2->e2_tipo         ,.F.},;
            		    {"E2_FORNECE"  ,se2->E2_FORNECE      ,.F.},;
			           {"E2_LOJA"     ,se2->e2_loja         ,.F.},;  
   			           {"E2_NATUREZ"  ,trim(cNatSa2)              ,.F.},; 
			           {"E2_VALOR"    ,vlrtot50             ,nil} }   
			           
 			lMsErroAuto := .F.
 			MsExecAuto({ |x,y,z| Fina050(x,y,z)},aDadSe2,,4)
			If lMsErroAuto
				MostraErro()  
  				DisarmTransaction()  
   		    Endif                                                                                               
  		         
////////// segunda passada   		                                                                               
            aDadSe2 :={{"E2_FILIAL"   ,se2->e2_filial       ,.F.},;
			           {"E2_PREFIXO"  ,se2->e2_prefixo      ,.F.},;  
   			           {"E2_NUM"      ,se2->e2_num          ,.F.},;
   			           {"E2_PARCELA"  ,se2->e2_parcela      ,.F.},; 
   			           {"E2_TIPO"     ,se2->e2_tipo         ,.F.},;
            		   {"E2_FORNECE"  ,se2->E2_FORNECE      ,.F.},;
			           {"E2_LOJA"     ,se2->e2_loja         ,.F.},; 
   			           {"E2_NATUREZ"  ,trim(cNatSa2)               ,.F.},; 
			           {"E2_VALOR"    ,vlrtot               ,nil} }   
			           
 			lMsErroAuto := .F.
 			MsExecAuto({ |x,y,z| Fina050(x,y,z)},aDadSe2,,4)

			If lMsErroAuto
				MostraErro()  
  		        DisarmTransaction()
   		    Endif   
   		    
             nVlCofsN   := se2->e2_vretcof
             nVlCsllN   := se2->e2_vretcsl
             nVlIssN    := se2->e2_iss
             nVlPisN    := se2->e2_vretpis
             nVlSdTitN  := (vlrtot -(se2->e2_iss+se2->e2_irrf+se2->e2_vretpis+se2->e2_vretcof+se2->e2_vretcsl)  )
             nVlIrrfN   := se2->e2_irrf
             nVlTTitN   := (vlrtot )//- (se2->e2_iss+se2->e2_irrf+se2->e2_vretpis+se2->e2_vretcof+se2->e2_vretcsl)  ) //vlrtot//(SE2->E2_valor-(se2->e2_iss+se2->e2_irrf+se2->e2_vretpis+se2->e2_vretcof+se2->e2_vretcsl) ) 
                                                                                           
             cObs       := cCodusu + " - " + se2->e2_hist 
             
   		    If !(lFaz)
                DisarmTransaction()    
                SE2->(DBSEEK(se2->e2_filial+se2->e2_prefixo+se2->e2_num+se2->e2_parcela+se2->e2_tipo+se2->E2_FORNECE+se2->e2_loja)) 
   		    endIf
 		
         End Transaction      
        
///      DBSEEK(TMP->e2_filial+TMP->e2_prefixo+TMP->e2_num+TMP->e2_parcela+TMP->e2_tipo+TMP->E2_FORNECE+TMP->e2_loja)    
   	 	If lFaz .and. !(lMsErroAuto)   
   	 	   BEGIN Transaction
   		    SE2->(Reclock("SE2",.F.))        
              	  valor:= (vlrtot -(se2->e2_iss+se2->e2_irrf+se2->e2_vretpis+se2->e2_vretcof+se2->e2_vretcsl)  ) //(SE2->E2_valor-((se2->e2_iss+se2->e2_irrf+se2->e2_vretpis+se2->e2_vretcof+se2->e2_vretcsl)+e2_csll+e2_pis+e2_cofins ))	           
			      SE2->E2_valor := valor
				  SE2->E2_saldo := valor     
				  se2->e2_vlcruz:= valor          
                  cObs          := cCodusu + " - " + se2->e2_hist 
                  se2->e2_hist  := cObs     
                  SE2->E2_CCD   := Iif(cEmpAnt == '01','998','99999') 
                  If lAtVenRea
                     se2->e2_vencrea:= dDataBase
                  EndIf   
                     
	        SE2->(MsUnLock())          
	       End Transaction
        EndIf  
/*            If !(lFaz)
                DisarmTransaction()
   		    endIf
*/ 
 //  	    End Transaction  
	
 
 if  nVlTTitN == 0 
     oBtn1:Disable()
 Else 
     oBtn1:enable()  
 EndIf    

 If  lFaz        
     oDlg1:End()
 EndIf
Return(.T.)    
    
static Function fgrava()
     lFaz:=.T.  
     ACERTPCC1(cRecnoSe2) 
     lFaz :=.F.
Return() 

static Function  fdescarta()
     lFaz:=.F.     
     oDlg1:End()
Return() 

