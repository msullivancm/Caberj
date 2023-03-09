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
±±ºDesc.     ³ Tela de browser do sistema juridico(DPJ)                   º±±
±±º          ³ 															  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/


User Function caba413()                 

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta matriz com as opcoes do browse...                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE aRotina	:=	{	{ "&Visualizar"	, "U_Caba413a"		, 0 , 1	 },; 
					  	{ "&Alteracao"	, "U_Caba413a"		, 0 , 2  },;
                        { "&Incluir"	, "U_Caba413a"		, 0 , 3	 },;
                        { "Legenda"		, "U_LEGPROS"	    , 0 , 3	 }}  
						
						

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Titulo e variavies para indicar o status do arquivo                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE cCadastro	:= "Browser do Sistema juridico - DPJ"

PRIVATE aCdCores	:= { 	{ 'BR_VERDE'    ,'Processo Ativo e Financeiro'     },;
							{ 'BR_AZUL'     ,'Processo Ativo e S/Financeiro'   },; 
							{ 'BR_VERMELHO' ,'Processo Desativado e Financeiro'},;												
							{ 'BR_PRETO'    ,'Processo Desativado e S/Financeiro'}}

//		{ 'BR_AMARELO'  ,'Processo Audiencia Marcada' },;

PRIVATE aCores	:= {{'((PC4_ATVDPJ==.T.).and.(PC4_FINDPJ==.T.))', aCdCores[1,1]},;
                    {'((PC4_ATVDPJ==.T.).and.(PC4_FINDPJ==.F.))', aCdCores[2,1]},;
					{'((PC4_ATVDPJ==.F.).and.(PC4_FINDPJ==.T.))', aCdCores[3,1]},;
					{'((PC4_ATVDPJ==.F.).and.(PC4_FINDPJ==.F.))', aCdCores[4,1]}}
					
					
//PRIVATE cPath  := ""                        
PRIVATE cAlias := "PC4" 

PRIVATE cPerg	:= "CABA413"

PRIVATE cNomeProg   := "CABA413"
PRIVATE nQtdLin     := 68
PRIVATE nLimite     := 132
PRIVATE cControle   := 15
PRIVATE cTamanho    := "G"
PRIVATE cTitulo     := "Controle de processos judiciais - Depositos Judiciais "
PRIVATE cDesc1      := ""
PRIVATE cDesc2      := ""
PRIVATE cDesc3      := ""
PRIVATE nRel        := "caba413"
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
PRIVATE cCabec1     := "Controle de Processo judiciais - Depositos Judiciais "
PRIVATE cCabec2     := ""
PRIVATE nColuna     := 00   
private tpcons      := ' ' 


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Starta mBrowse...                                                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ     
dbselectarea("PC4")
PC4->(DBSetOrder(1))  
//SET FILTER TO (PBX_NPRCAB == cNCab411 .AND. PBX_NUMPRO == cNproc411 .AND. PBX_NPRCOM == cNCompP411) 
//PBW->(mBrowse(006,001,022,075,"PBW" , , , , , Nil    , aCores, , , ,nil, .T.))  
PC4->(mBrowse(006,001,022,075,"PC4" , , , , , 2  , aCores, , , ,nil, .F.)) 
//mBrowse(6, 1, 22, 75, "PBW",,,,,,aCores)
PC4->(DbClearFilter())
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
User Function LEGPROS()
Local aLegenda

	aLegenda 	:= { 	{ aCdCores[1,1],aCdCores[1,2] },;
						{ aCdCores[2,1],aCdCores[2,2] },;
						{ aCdCores[3,1],aCdCores[3,2] },;
	              		{ aCdCores[4,1],aCdCores[4,2] },;
	              		{ aCdCores[5,1],aCdCores[5,2] } }

	                     	
BrwLegenda(cCadastro,"Status" ,aLegenda)

Return

User Function caba413a(cAlias,nReg,nOpc)                         

/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±± Declaração de cVariable dos componentes                                 ±±
Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/
Private cCnpjDpj   := Space(18)
Private cCodRdaDpj := Space(6)
Private cDescDpj   := Space(60)
Private dDtFim     :=  CtoD(" ")
Private cForneDpj  := Space(6)
Private cHistRet  
Private cNomDpj    := Space(40)
Private cObsDpj   
Private cRegDpj    := Space(150)
Private dDtinc     := CtoD(" ")
Private lAtivo     := .F.
Private lRotFin    := .F.
Private nIdDpj     := 0
Private nprec      := 0
Private nVlrLim    := 0
Private nVlrRet    := 0     

PRIVATE nopc413n   := nOpc

/*
±± ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±± Declaração de Variaveis Private dos Objetos                             ±±
Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/
SetPrvt("oDlg1","oGrp1","oSay1","oSay2","oSay3","oSay4","oSay5","oSay12","oGet1","oGet2","oGet3","oGet4")
SetPrvt("oGet12","oGrp13","oBtn1","oBtn2","oBtn4","oGrp2","oSay6","oSay7","oSay8","oSay9","oSay10","oSay11")
SetPrvt("oGet7","oGet8","oGet9","oGet10","oGet11","oCBox1","oCBox2","oGrp4","oMGet2","oGrp3","oMGet1")


dbselectarea("PC4")          

If nopc413n == 3 
   nIdDpj:=fPrNPc4()
else       
     DbGoto(nReg)
     fMArqVar()
EndIf                    

/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±± Definicao do Dialog e todos os seus componentes.                        ±±
Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/     


oDlg1      := MSDialog():New( 088,232,628,980,"oDlg1",,,.F.,,,,,,.T.,,,.T. )
oGrp1      := TGroup():New( 000,000,052,284,"Fornecedor ",oDlg1,CLR_BLACK,CLR_WHITE,.T.,.F. )
oSay1      := TSay():New( 028,004,{||"Cod Fornec."},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay2      := TSay():New( 028,088,{||"Nome "},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay3      := TSay():New( 029,053,{||"Cod RDA"},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,031,008)
oSay4      := TSay():New( 028,220,{||"Cnpj/Cpf"},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay5      := TSay():New( 008,004,{||"Controle Retenção"},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,048,008)
oSay12     := TSay():New( 008,052,{||"Identificação do Beneficiario"},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)    

oGet12     := TGet():New( 016,052,{|u| If(PCount()>0,cDescDpj:=u,cDescDpj)},oGrp1,220,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cDescDpj",,)


oGet1      := TGet():New( 036,004,{|u| If(PCount()>0,(cForneDpj:=u,fConsSa(cForneDpj,'PGTO')),cForneDpj)},oGrp1,032,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"SA2JU1","cForneDpj",,)

oGet1:bLostFocus:={|| fConsSa(cForneDpj,'PGTO') }  

oGet2      := TGet():New( 036,088,{|u| If(PCount()>0,cNomDpj:=u,cNomDpj)},oGrp1,128,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cNomDpj",,)
oGet3      := TGet():New( 036,053,{|u| If(PCount()>0,cCodRdaDpj:=u,cCodRdaDpj)},oGrp1,032,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cCodRdaDpj",,)
oGet4      := TGet():New( 036,220,{|u| If(PCount()>0,cCnpjDpj:=u,cCnpjDpj)},oGrp1,060,008,'@! !!!.!!!.!!!-!!!!.!!',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cCnpjDpj",,)
oGet5      := TGet():New( 016,004,{|u| If(PCount()>0,nIdDpj:=u,nIdDpj)},oGrp1,044,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nIdDpj",,)
oGrp13     := TGroup():New( 000,288,052,368,"Controles",oDlg1,CLR_BLACK,CLR_WHITE,.T.,.F. )
oBtn1      := TButton():New( 008,304,"Grava",oGrp13,{||fgrava()},048,012,,,,.T.,,"",,,,.F. )
oBtn2      := TButton():New( 022,304,"Deleta",oGrp13,{||fDeleta()},048,012,,,,.T.,,"",,,,.F. )
oBtn4      := TButton():New( 036,304,"Sair",oGrp13,{||oDlg1:End()},048,012,,,,.T.,,"",,,,.F. )  

oGrp2      := TGroup():New( 056,000,116,368,"Retenção",oDlg1,CLR_BLACK,CLR_WHITE,.T.,.F. )
oSay6      := TSay():New( 068,004,{||"Regra de Retenção "},oGrp2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,052,008)
oSay7      := TSay():New( 092,004,{||"% da Ret."},oGrp2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,028,008)
oSay8      := TSay():New( 092,040,{||"Valor Limite "},oGrp2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,036,008)
oSay9      := TSay():New( 092,088,{||"Valor Retido "},oGrp2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,036,008)
oSay10     := TSay():New( 092,140,{||"Data inicial "},oGrp2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay11     := TSay():New( 092,196,{||"Data Final "},oGrp2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oGet6      := TGet():New( 076,004,{|u| If(PCount()>0,cRegDpj:=u,cRegDpj)},oGrp2,360,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cRegDpj",,)
oGet7      := TGet():New( 100,004,{|u| If(PCount()>0,nprec:=u,nprec)},oGrp2,024,008,'@E 999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nprec",,)
oGet8      := TGet():New( 100,038,{|u| If(PCount()>0,nVlrLim:=u,nVlrLim)},oGrp2,040,008,'@E 9,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nVlrLim",,)
oGet9      := TGet():New( 100,084,{|u| If(PCount()>0,nVlrRet:=u,nVlrRet)},oGrp2,036,008,'@E 9,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrRet",,)
oGet10     := TGet():New( 100,138,{|u| If(PCount()>0,dDtinc:=u,dDtinc)},oGrp2,044,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","dDtinc",,)
oGet11     := TGet():New( 100,196,{|u| If(PCount()>0,dDtFim:=u,dDtFim)},oGrp2,044,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","dDtFim",,)
oCBox1     := TCheckBox():New( 100,254,"Ativo ?",{|u| If(PCount()>0,lAtivo:=u,lAtivo)},oGrp2,030,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
oCBox2     := TCheckBox():New( 100,288,"Rotina Financeira?",{|u| If(PCount()>0,lRotFin:=u,lRotFin)},oGrp2,064,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
oGrp4      := TGroup():New( 116,000,168,368,"Observações ",oDlg1,CLR_BLACK,CLR_WHITE,.T.,.F. )
oMGet2     := TMultiGet():New( 124,004,{|u| If(PCount()>0,cObsDpj:=u,cObsDpj)},oGrp4,360,040,,,CLR_BLACK,CLR_WHITE,,.T.,"",,,.F.,.F.,.F.,,,.F.,,  )
oGrp3      := TGroup():New( 168,000,268,372,"Histórico de Retenção",oDlg1,CLR_BLACK,CLR_WHITE,.T.,.F. )
oMGet1     := TMultiGet():New( 176,004,{|u| If(PCount()>0,cHistRet:=u,cHistRet)},oGrp3,364,084,,,CLR_BLACK,CLR_WHITE,,.T.,"",,,.F.,.F.,.T.,,,.F.,,  )

oDlg1:Activate(,,,.T.)

Return

/////////////////////////////////////////////

static function fMArqVar()

cDescDpj   := PC4_DSCDPJ 
dDtFim     := PC4_DTFIM  
cForneDpj  := PC4_CODFOR 
cNomDpj    := PC4_NOMFOR 
cObsDpj    := PC4_OBSDPJ 
cRegDpj    := PC4_REGDPJ 
dDtinc     := PC4_DTINC  
lAtivo     := PC4_ATVDPJ 
lRotFin    := PC4_FINDPJ 
nIdDpj     := PC4_IDDPJ  
nprec      := PC4_PRCDPJ 
nVlrLim    := PC4_VLRLIM 
nVlrRet    := PC4_VLRRET   
 
fConsSa(cForneDpj, 'CONS')  



Return()   

static function fMVarArq()

PC4_DSCDPJ :=  cDescDpj 
PC4_DTFIM  :=  dDtFim   
PC4_CODFOR :=  cForneDpj
PC4_NOMFOR :=  cNomDpj  
PC4_OBSDPJ :=  cObsDpj  
PC4_REGDPJ :=  cRegDpj  
PC4_DTINC  :=  dDtinc   
PC4_ATVDPJ :=  lAtivo   
PC4_FINDPJ :=  lRotFin  
PC4_IDDPJ  :=  nIdDpj   
PC4_PRCDPJ :=  nprec    
PC4_VLRLIM :=  nVlrLim  
PC4_VLRRET :=  nVlrRet  
  
Return()         
static function fLimpVar()

a:='b'

Return() 


Static Function fPrNPc4()
local ret        := 0
local cAliastmp  := GetNextAlias()  
Private cQuery   := " "   

cQuery := "select nvl(max(PC4_IDDPJ), 0 ) NUMMAX "
cQuery += CRLF+ " from  " + RetSqlName("PC4") +" PC4 "
cQuery += CRLF+ " where PC4_filial = '"+xFilial('PC4')+ "' and PC4.d_E_L_E_T_ = ' ' "  
                                                                                            
If Select((cAliastmp)) <> 0 
   (cAliastmp)->(DbCloseArea())  
Endif                          

TCQuery cQuery New Alias (cAliastmp)   

    (cAliastmp)->( DbGoTop() )  
     ret:= ((cAliastmp)->NUMMAX+1)
	(cAliastmp)->(DbCloseArea())
			
Return( ret )

Static Function fConsSa(IdTit, TpCons) 

local lRet := .T.              
local nome := ' '
local codigo := ' ' 
If !Empty(IdTit)  
   dbselectarea("SA2")
   dbsetorder(1)
   If dbseek(xFilial("SA2")+TRIM(IdTit))      
          
      cForneDpj := (SA2->A2_COD)                            
      cNomDpj   := (SA2->A2_NOME)
      cCnpjDpj  := (SA2->A2_CGC)
      cCodRdaDpj := fRdaforn(IdTit)
 
   Else 
 
      cForneDpj := 0         
      cNomDpj   := ' '
      cCnpjDpj  := ' ' 
       
   EndIf   
Else
    MsgAlert("Codigo do Fornecedor esta em branco !! ","Atencao!")       
    oGet1:setfocus()

EndIf
 cHistRet := fCarhist()    
 If TpCons!='CONS'
    oGet2:refresh()
    oGet3:refresh() 
    oGet4:refresh()   
    oMGet1:refresh()
 EndIf                                                                 
Return( ) 

Static Function fRdaForn(IdTit)        

local ret        := " " 
local cAliastmp  := GetNextAlias()  
Private cQuery   := " "   

cQuery := "select bau_codigo  "
cQuery += CRLF+ " from  " + RetSqlName("BAU") +" BAU "
cQuery += CRLF+ " where BAU_filial = '"+xFilial('BAU')+ "' and BAU.d_E_L_E_T_ = ' '  "  
cQuery += CRLF+ " AND BAU_CODSA2 = '"+IdTit + "'  "  
                                                                                            
If Select((cAliastmp)) <> 0 
   (cAliastmp)->(DbCloseArea())  
Endif                          

TCQuery cQuery New Alias (cAliastmp)   
If Select(cAliastmp) > 0
    (cAliastmp)->( DbGoTop() )  
     ret:= ((cAliastmp)->bau_codigo)
	(cAliastmp)->(DbCloseArea()) 
EndIf	
			
Return( ret )     

Static Function fGrava()
		dbselectarea("PC4")
		PC4->(DbSetOrder(1))   
	    dbSeek(xFilial("PC4")+str(nIdDpj,6,0))       
  
         If nopc413n == 2 
            RecLock("PC4",.F.)     
	        fMVarArq()
	        Msunlock("PC4")    
	        If ApMsgYesNo("Deseja enviar email para esta alteração??","SIMNAO")
               fEnmail("ALT")   
	        EndIf       
	        oDlg1:End() 
         else 	   
	        RecLock("PC4",.T.)     
            fMVarArq()
	   	    Msunlock("PC4")  
 	   	    fEnmail("INC")
	   	    oDlg1:End()                                       
  	     EndIf 	       
            
return() 
 
Static Function  fEnmail(cOrigem)    
 
 Local lEmail     := .F.
 Local c_CampAlt  := '  ' 
 Local lExecuta   := .T.   
                           
 Local aArea      := GetArea() //Armazena a Area atual        
 Local _cMensagem := ""     
 local cdest      := " " 

_cMensagem := DtoC( Date() ) +  Chr(10) + Chr(13) + Chr(10) + Chr(13)    
_cMensagem +=  Chr(13) + Chr(10) +Chr(13) + Chr(10) + "Prezados, CC "

If cOrigem=="INC"
   _cMensagem +=  Chr(13) + Chr(10) + " Assunto : Inclusao de DPJ de Numero : " +str(nIdDpj,6,0)  
ElseIf cOrigem=="ALT"
   _cMensagem +=  Chr(13) + Chr(10) + " Assunto : Alteração de DPJ de Numero : "+str(nIdDpj,6,0)
ElseIf cOrigem=="DEL"
   _cMensagem +=  Chr(13) + Chr(10) + " Assunto : Exclução de DPJ de Numero : "+str(nIdDpj,6,0)    
EndIf                                                                                              

_cMensagem +=  Chr(13) + Chr(10) + "Do cliente : " + cForneDpj + " - " + cNomDpj  

//_cMensagem +=  Chr(13) + Chr(10) +  " Prazo retorno no dia : "+ DtoC( dDtFim ) + " na Hora : " + substr(str(cHoraFim,2,0),1,2)+":"+substr(str(cHoraFim,2,0),3,2)
_cMensagem +=  Chr(13) + Chr(10) +  " Prezado Felipe, " 
_cMensagem +=  Chr(13) + Chr(10) +  " Para ciência e providências. "
_cMensagem +=  Chr(13) + Chr(10) +  " Prazo de retorno de escritório no dia __/__/__ "
_cMensagem +=  Chr(13) + Chr(10) +  " Atenciosamente, "
_cMensagem +=  Chr(13) + Chr(10) +  " Jurídico "
_cMensagem +=  Chr(13) + Chr(10) +  " R:6591 / R:9807 "
                  
u_EnvEmail1( _cMensagem , cDest) 

RestArea(aArea)             

Return (.T.)      
 
Static Function fDeleta()   
If PC4->PC4_VLRRET != 0                                                                                          
          MsgAlert("DPJ com retenções , NÃO pode ser  APAGADO  !!! -Favor verificar ","Atencao!")    
else           
       If ApMsgYesNo("Deseja excluir o Registro. Deseja excluir","SIMNAO")   
           
          MsgAlert("DPJ  APAGADO com Sucesso  !!! - Email Informando Exclução sera Emitido","Atencao!")    
     	   
          fEnmail("DEL")   
           
          PC4->(RecLock("PC4",.F.))
          PC4->(DbDelete())
          PC4->(MsUnlock())   
    	   
          oDlg1:End()                  
       EndIf 
EndIf       
 Return() 

  
Static Function  fCarhist()    
 local ret:=''
 local cAliastmp      := GetNextAlias()  

 Private cQuery       := " "   

cQuery := "select *  "
cQuery += CRLF+ " from  " + RetSqlName("SE2") +" SE2 "
cQuery += CRLF+ " where E2_filial = '"+xFilial('SE2')+ "' and SE2.d_E_L_E_T_ = ' ' "  
cQuery += CRLF+ " AND E2_PREFIXO  ='DPJ'"       
cQuery += CRLF+ " AND E2_FORNECE  ='"+ cForneDpj+"' "            
cQuery += CRLF+ " order by 1,2,3,4 "       

TCQuery cQuery New Alias (cAliastmp)   

(cAliastmp)->( DbGoTop() )          
    ret:= "Titulo Dpj           Emissao      Venc.         Baixa            Valor               saldo  " + CRLF      
    ret+= "--------------------------------------------------------------------------------------------" + CRLF  

  While !Eof()
  // Vlrsai:= (cAliastmp)->PBY_VLONUS  Picture "@E 999,999,999.99"    
  //    ret+= "--------------------------------------------------------" + CRLF 
      ret+= (cAliastmp)->(e2_prefixo+e2_num+e2_prefixo) + "   " ; 
         +  DtoC(STOD((cAliastmp)->E2_emis1))           + "   " ;
         +  DtoC(STOD((cAliastmp)->e2_vencrea))         + "   " ;
         +  DtoC(STOD((cAliastmp)->e2_baixa))           + "   " ;
         +  Transform((cAliastmp)->e2_valor,"@R  999,999,999.99") + "   " ;
         +  Transform((cAliastmp)->e2_saldo,"@R  999,999,999.99") + CRLF 
//      ret+= "--------------------------------------------------------" + CRLF  
     DbSkip()
  End                                   
  
Return(ret)    
 

/*

        cCnpjDpj   := Space(18)      cCnpjDpj   
        cCodRdaDpj := Space(6)       cCodRdaDpj 
		
        cDescDpj   := PC4_DSCDPJ :=  cDescDpj   
        cDtFim     := PC4_DTFIM  :=  cDtFim     
        cForneDpj  := PC4_CODFOR :=  cForneDpj  
        cHistRet   := PC4_HISRET :=  cHistRet  
		cNomDpj    := PC4_NOMFOR :=  cNomDpj    
        cObsDpj    := PC4_OBSDPJ :=  cObsDpj    
        cRegDpj    := PC4_REGDPJ :=  cRegDpj    
        dDtinc     := PC4_DTINC  :=  dDtinc     
        lAtivo     := PC4_ATVDPJ :=  lAtivo     
        lRotFin    := PC4_FINDPJ :=  lRotFin    
        nIdDpj     := PC4_IDDPJ  :=  nIdDpj     
        nprec      := PC4_PRCDPJ :=  nprec      
        nVlrLim    := PC4_VLRLIM :=  nVlrLim    
        nVlrRet    := PC4_VLRRET :=  nVlrRet       
        
        
        
***********************
User Function F300FIL()  
***********************

	Local lAchou		:= .T.
	Local cTrb			:= GetNextAlias()
	Local aAreaSEA		:= SEA->(GetArea())
	Private lMsErroAuto	:= .F. 
	Private aBaixa		:= {}

	Public  nRecTit     := SE2->(Recno())
	
	SE2->(DbSetOrder(11)) // Filial+IdCnab
 
	If !SE2->(DbSeek(xFilial("SE2")+SubStr(Paramixb[1],1,10)))

		//Se não achou utiliza chave antiga
		SE2->(DbSetOrder(1))

		If !SE2->(DbSeek(xFilial("SE2")+Pad(Paramixb[1],Paramixb[3])))

			lAchou := .F.
			Help("",1,"NOESPECIE",,Paramixb[1],5,1)

			//Localiza o primeiro titulo totalmente baixado para que o Fina300 pule a linha.
			cQry := "SELECT R_E_C_N_O_ REC FROM " + RetSqlName("SE2")
			cQry += " WHERE D_E_L_E_T_ = ' '"
			cQry += "   AND E2_FILIAL = '" + xFilial("SE2") + "'"
			cQry += "   AND E2_SALDO = 0"
			cQry += "   AND ROWNUM   = 1"

			If Select(cTrb) > 0; (cTrb)->(DbCloseArea()); EndIf
			dbUseArea(.T., 'TOPCONN', TCGenQry(,,cQry), cTrb, .F., .T.)

			(cTrb)->(dbGoTop())

			If (cTrb)->(!Eof())
				SE2->(DbGoTo((cTrb)->REC))
			EndIf

			(cTrb)->(dbCloseArea())
		EndIf
	EndIf
 
	If lAchou
		If AllTrim(cRetorno) == "DV" .And. !Empty(SE2->E2_BAIXA)
			nRecSE2		:= SE2->(Recno())
			cAutMotbx	:="NORMAL"
			cHistBx		:= "Cancelamento de Baixa"
			aBaixa		:={}

			dDataOld  := dDataBase
			dDataBase := SE2->E2_BAIXA

			aAdd(aBaixa, {"E2_PREFIXO"	, SE2->E2_PREFIXO			, Nil})
			aAdd(aBaixa, {"E2_NUM"		, SE2->E2_NUM				, Nil})
			aAdd(aBaixa, {"E2_PARCELA"	, SE2->E2_PARCELA			, Nil})
			aAdd(aBaixa, {"E2_TIPO"		, SE2->E2_TIPO				, Nil})
			aAdd(aBaixa, {"E2_FORNECE"	, SE2->E2_FORNECE			, Nil})
			aAdd(aBaixa, {"E2_LOJA"		, SE2->E2_LOJA				, Nil})
			aAdd(aBaixa, {"AUTHIST"		, cHistBx					, Nil})
			aAdd(aBaixa, {"AUTVLRPG"	, SE2->(E2_VALOR-E2_SALDO)	, Nil})

			Begin Transaction

			MsExecAuto({|x,y|FINA080(x,y)},aBaixa,5)

			Pergunte("AFI300", .F.)   

			If lMSErroAuto
				MostraErro()
				dDataBase := dDataOld
				Return .F.
			EndIf

			SEA->(DbSetOrder(1))
			If SEA->(DbSeek(xFilial("SEA")+SE2->(E2_NUMBOR+E2_PREFIXO+E2_NUM+E2_PARCELA+E2_TIPO+E2_FORNECE+E2_LOJA)))
				RecLock("SEA", .F.)
				SEA->(DbDelete())
				SEA->(MsUnlock())

				SE2->(dbGoTo(nRecSE2))
				RecLock("SE2", .F.)
				SE2->E2_NUMBOR  := Space(Len(SE2->E2_NUMBOR))
				SE2->E2_PORTADO := Space(Len(SE2->E2_PORTADO))
				SE2->(MsUnlock())
			EndIf

			dDataBase := dDataOld

			End Transaction
		EndIf
	EndIf

	RestArea(aAreaSEA)
Return
         


////////////////////////
    cFiltro: grava um filtro nos títulos da MBrowse.

    Exemplos
    #include "rwmake.ch"
    #include "protheus.ch"
    User Function EXEMPLO()

    Private lMsErroAuto := .F.

    dbSelectArea("SE2")
    SE2->(dbSetOrder(1))
    SE2->(dbGoTop())
    If SE2->(dbSeek(xFilial("SE2") + "TST" + "TESTESE51" + SPACE(TAMSX3("E2_PARCELA")[1]) + "BOL" + "001 " + "01"))
    If SE2->E2_SALDO > 0
    cHistBaixa := "Exemplo BX. Pagar"
    //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
    //³Monta array com os dados da baixa a pagar do título³
    //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ 
    aBaixa := {}
    AADD(aBaixa, {"E2_FILIAL" , SE2->E2_FILIAL , Nil})
    AADD(aBaixa, {"E2_PREFIXO" , SE2->E2_PREFIXO , Nil})
    AADD(aBaixa, {"E2_NUM" , SE2->E2_NUM , Nil})
    AADD(aBaixa, {"E2_PARCELA" , SE2->E2_PARCELA , Nil})
    AADD(aBaixa, {"E2_TIPO" , SE2->E2_TIPO , Nil})
    AADD(aBaixa, {"E2_FORNECE" , SE2->E2_FORNECE , Nil})
    AADD(aBaixa, {"E2_LOJA" , SE2->E2_LOJA , Nil}) 
    AADD(aBaixa, {"AUTMOTBX" , "COMP. CR " , Nil})
    AADD(aBaixa, {"AUTBANCO" , "001" , Nil})
    AADD(aBaixa, {"AUTAGENCIA" , "00001" , Nil})
    AADD(aBaixa, {"AUTCONTA" , "000001 " , Nil})
    AADD(aBaixa, {"AUTDTBAIXA" , dDataBase , Nil}) 
    AADD(aBaixa, {"AUTDTCREDITO", dDataBase , Nil})
    AADD(aBaixa, {"AUTHIST" , cHistBaixa , Nil})
    AADD(aBaixa, {"AUTVLRPG" , SE2->E2_SALDO , Nil})
    ACESSAPERG("FIN080", .F.)
    MSEXECAUTO({|x,y| FINA080(x,y)}, aBaixa, 3)

    If lMsErroAuto
    MOSTRAERRO() 
    Return .F.
    Else
    Alert("Baixa realizada, verifique a SE5")
    EndIf 
    Else
    Alert("O título não possui saldo a pagar em aberto")
    EndIf 
    Else
    Alert("O título a pagar não foi localizado")
    EndIf
    Return

Versões: Microsiga_Protheus10
Parâmetros: (aBaixa, nOpc , lNoMbrowse, nOpbaixa, cFiltro)
Programa Fonte: FINA080.PRX
/////////////////////////
