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
±±ºPrograma  ³CABA181   ºAutor  ³ Altamiro	         º Data ³  14/010/2020º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Tela de browser do sistema de liberação de titulos comissaoº±±
±±º          ³ 															  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function caba181()                 

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta matriz com as opcoes do browse...                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE aRotina	:=	{	{ "&Visualizar"	, "U_Caba181A"		, 0 , 1	 },; 
      				     	{ "&Alteracao"	, "U_Caba181A"		, 0 , 2  },;
                        { "&Incluir"	, "U_Caba181A"		, 0 , 3	 },;
                        { "Legenda"		, "U_LPROS181"	    , 0 , 3	 }}  
						
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Titulo e variavies para indicar o status do arquivo                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE cCadastro	:= "Browser do Sistema bloqueio / desbloqueio comissoes "

PRIVATE aCdCores	:= { 	{ 'BR_VERDE'    ,'Titulo Liberado   '         },;
			   				{ 'BR_VERMELHO' ,'Titulo Bloqueado  '         }}

PRIVATE aCores	:= { {'e2_yltitc=="2"', aCdCores[2,1]},;
                    {'e2_yltitc==" "', aCdCores[1,1]},;
                    {'e2_yltitc=="1"', aCdCores[1,1]} }

//PRIVATE cPath  := ""                        
PRIVATE cAlias := "SE2" 

PRIVATE cPerg	:= "CABA409"

PRIVATE cNomeProg   := "CABA181"
PRIVATE nQtdLin     := 68
PRIVATE nLimite     := 132
PRIVATE cControle   := 15
PRIVATE cTamanho    := "G"
PRIVATE cTitulo     := "Controle de Liberação Titulos de Comissão"
PRIVATE cDesc1      := ""
PRIVATE cDesc2      := ""
PRIVATE cDesc3      := ""
PRIVATE nRel        := "CABA181"
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
PRIVATE cCabec1     := "Controle de Liberação de Titulos Comercial"
PRIVATE cCabec2     := ""
PRIVATE nColuna     := 00 
Private cFiltro     := ' '
private cDthr       := (dtos(DATE()) + "-" + Time()) 
private _cUsuario   := subStr(cUSUARIO,7,15)  
Private cAliastmp   := GetNextAlias()
Private cAliastmp2  := GetNextAlias()  
private cQuery2     := " " 
private cTitulos    := " "
private cTitulos1   := " "


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Starta mBrowse...                                                   ³         
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ   

fFiltro() 
 
dbselectarea("SE2")
SE2->(DBSetOrder(1))



Set Filter to (SE2->E2_PREFIXO = 'COM' .AND. SE2->E2_SALDO > 0 .AND. SE2->E2_tipo = 'DP' .and. E2_NUM $ cTitulos1 )
 //    Set Filter to (SE2->E2_PREFIXO = 'COM' .AND. SE2->E2_SALDO > 0 .AND. SE2->E2_tipo = 'DP' .and. $ fFiltro() )
// Set Filter to (SE2->E2_PREFIXO == 'COM' .AND. SE2->E2_SALDO > 0 .AND. SE2->E2_tipo == 'DP' )


//PBW->(mBrowse(006,001,022,075,"PBW" , , , , , Nil    , aCores, , , ,nil, .T.))  
SE2->(mBrowse(006,001,022,075,"SE2" , , , , , 2    , aCores, , , ,nil, .F.)) 
//mBrowse(6, 1, 22, 75, "PBW",,,,,,aCores)
SE2->(DbClearFilter())
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
USER Function LPROS181()
Local aLegenda

	aLegenda 	:= { 	{ aCdCores[1,1],aCdCores[1,2] },;
						   { aCdCores[2,1],aCdCores[2,2] } }

	                     	
BrwLegenda(cCadastro,"Status" ,aLegenda)

Return

User Function Caba181A(cAlias,nReg,nOpc) 

Private cCompte    := Space(1)
Private cEmpres    := Space(1)
Private cFornece   := Space(1)
Private cNum       := Space(1)
Private cPref      := Space(1)
Private cStatus    := Space(1)
Private cTipo      := Space(1)
Private cVenc      := Space(1)
Private cMot       := ' ' 
Private nSaldo     := '0'
Private nValor     := '0


/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±± Declaração de Variaveis Private dos Objetos                             ±±
Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/
SetPrvt("oDlg1","oPanel1","oGrp1","oSay11","oBtn1","oBtn2","oBtn3","oGet10","oGrp2","oSay1","oSay2","oSay3")
SetPrvt("oSay5","oSay6","oSay7","oSay8","oSay9","oSay10","oGet1","oGet2","oGet3","oGet4","oGet5","oGet6")
SetPrvt("oGet8","oGet9","oCBox1")

//If nopc == 3 
//   cNumCab:=fProxNum() 
//else       
   	dbselectarea("SE2")
      DbGoto(nReg)
      fMovArqVar()
//EndIf


/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±± Definicao do Dialog e todos os seus componentes.                        ±±
Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/
oDlg1      := MSDialog():New( 169,268,496,963,"Liberação / Boqueio de pagamentos de Comissão ",,,.F.,,,,,,.T.,,,.T. )
oPanel1    := TPanel():New( 0-4,-12,"oPanel1",oDlg1,,.F.,.F.,,,352,156,.T.,.F. )
oGrp1      := TGroup():New( 004,016,032,348,"Ação",oPanel1,CLR_BLACK,CLR_WHITE,.T.,.F. )
oSay11     := TSay():New( 020,224,{||"Status "},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,024,008)
oBtn1      := TButton():New( 016,024,"Libera"   ,oGrp1,{||fAtualiza('L')},037,012,,,,.T.,,"",,,,.F. )
oBtn2      := TButton():New( 016,076,"Bloqueia ",oGrp1,{||fAtualiza('B')},037,012,,,,.T.,,"",,,,.F. )

oBtn3      := TButton():New( 016,128,"Sair",oGrp1,{||oDlg1:End()},037,012,,,,.T.,,"",,,,.F. )

oGet10     := TGet():New( 016,252,{|u| If(PCount()>0,cStatus:=u,cStatus)},oGrp1,060,010,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cStatus",,)
oGrp2      := TGroup():New( 040,016,152,348,"Identificação do Titulos ",oPanel1,CLR_BLACK,CLR_WHITE,.T.,.F. )
oSay1      := TSay():New( 048,020,{||"Prefixo "},oGrp2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,024,008)
oSay2      := TSay():New( 048,048,{||"Numero "},oGrp2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,028,008)
oSay3      := TSay():New( 048,092,{||"Tipo"},oGrp2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,020,008)
oSay4      := TSay():New( 076,020,{||"Fornecedor "},oGrp2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,040,008)
oSay5      := TSay():New( 048,264,{||"Valor"},oGrp2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,020,008)
oSay6      := TSay():New( 048,320,{||"Saldo"},oGrp2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,020,008)
oSay7      := TSay():New( 101,021,{||"Empresa"},oGrp2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,040,008)
oSay8      := TSay():New( 048,120,{||"Competencia "},oGrp2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,044,008)
oSay9      := TSay():New( 048,184,{||"Vencimento "},oGrp2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,036,008)
oSay10     := TSay():New( 124,020,{||"Motivo bloq/desbloq"},oGrp2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,068,008)
oGet1      := TGet():New( 084,020,{|u| If(PCount()>0,cFornece:=u,cFornece)},oGrp2,324,010,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cFornece",,)
oGet2      := TGet():New( 056,236,{|u| If(PCount()>0,nValor:=u,nValor)},oGrp2,048,010,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nValor",,)
oGet3      := TGet():New( 056,292,{|u| If(PCount()>0,nSaldo:=u,nSaldo)},oGrp2,048,010,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nSaldo",,)
oGet4      := TGet():New( 056,020,{|u| If(PCount()>0,cPref:=u,cPref)},oGrp2,020,010,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cPref",,)
oGet5      := TGet():New( 056,048,{|u| If(PCount()>0,cNum :=u,cNum )},oGrp2,036,010,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cNem ",,)
oGet6      := TGet():New( 056,092,{|u| If(PCount()>0,cTipo:=u,cTipo)},oGrp2,016,010,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cTipo",,)
oGet7      := TGet():New( 109,021,{|u| If(PCount()>0,cEmpres:=u,cEmpres)},oGrp2,323,010,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cEmpres",,)
oGet8      := TGet():New( 056,116,{|u| If(PCount()>0,cCompte:=u,cCompte)},oGrp2,044,010,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cCompte",,)
oGet9      := TGet():New( 056,177,{|u| If(PCount()>0,cVenc:=u,cVenc)},oGrp2,044,010,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cVenc",,)
oCBox1     := TComboBox():New( 132,020,{|u| If(PCount()>0,cMot:=u,cMot)},{"Renegociacao de contrato","Pendencias financeiras","Pendencias administrativas"," "},324,012,oGrp2,,,,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,,cMot )

if se2->e2_yltitc == '2'
    oBtn2:Disable()
 else   
    oBtn1:Disable()
 EndIf	

oDlg1:Activate(,,,.T.)

Return

static Function fMovArqVar()
 /*
 if e2_yltitc == '2'
    oBtn2:disable 
 else   
    oBtn1:disable
 EndIf	
*/


 cCompte    := flebxq(1)
 cEmpres    := flebxq(2)
 cFornece   := se2->e2_fornece +' - '+ se2->e2_nomfor
 cNum       := se2->e2_num
 cPref      := se2->e2_prefixo 
 cStatus    := iif(se2->e2_yltitc=='2','BLOQUEADO','LIBERADO')  
 cTipo      := se2->E2_tipo
 cVenc      := se2->e2_vencrea
 cMot       := se2->e2_mtblcm
 nSaldo     := alltrim(transform(se2->e2_saldo,"@E 99999,999.99"))  
 nValor     := alltrim(transform(se2->e2_valor,"@E 99999,999.99"))  
//e2_yltitc , e2_mtblcm , e2_lgblcm
Return()

static function fAtualiza(acao)


if acao == 'B' .and. Empty(cMot)  
   
   alert("Motivo do Bloquei NÃO selecionado !!!")
   
elseif acao == 'L'
	RECLOCK("SE2", .F. )
       e2_yltitc := '1'
       e2_mtblcm := ' ' 
       e2_lgblcm :=  "Usur:" +_cUsuario + " Lib:" +cDthr      
	(MSUNLOCK())
   oDlg1:End()
elseif acao == 'B'
	RECLOCK("SE2", .F. )
       e2_yltitc := '2'
       e2_mtblcm := cMot
	    e2_lgblcm :=  "Usur:" +_cUsuario + " Bloq:" +cDthr
	(MSUNLOCK())
   oDlg1:End()				
EndIf 
 Return()

static function flebxq(acao)

local ret := ' ' 
local cQuery := ' '

cQuery := CRLF + "SELECT DISTINCT BXQ_ANO ano , BXQ_MES mes  , BXQ_CODVEN codvend, BXQ_CODEMP cCodemp   , BG9_DESCRI cDescEmp "

cQuery += CRLF + "  FROM  "+ RetSqlName("BXQ") +" BXQ , "+ RetSqlName("BG9") +" BG9 "
cQuery += CRLF + " where bxq_filial = '" + xFilial("BXQ") + "' and BXQ.d_E_L_E_T_ = ' ' "
cQuery += CRLF + "   AND BG9_filial = '" + xFilial("BG9") + "' and BG9.d_E_L_E_T_ = ' ' "  
cQuery += CRLF + "   and bxq_E2PREF = '"+SE2->E2_PREFIXO+"'  "
cQuery += CRLF + "   AND BXQ_E2NUM  = '"+SE2->E2_NUM+"'  "
cQuery += CRLF + "   AND BXQ_E2TIPO = '"+SE2->E2_TIPO+"'  " 
cQuery += CRLF + "   AND BXQ_E2FORN = '"+SE2->E2_FORNECE+"'  "
cQuery += CRLF + "   AND BXQ_REFERE = BXQ_PAGCOM "  
cQuery += CRLF + "   AND BG9_CODINT ='0001' AND BG9_CODIGO = BXQ_CODEMP " 

   
If Select((cAliastmp)) <> 0 
   (cAliastmp)->(DbCloseArea())  
Endif 
        
TCQuery cQuery  New Alias (cAliastmp)   

(cAliastmp)->(dbGoTop()) 
    
If (cAliastmp)->(!EOF())    
   
   If acao == 1
      ret:= (cAliastmp)->ano +'/'+ (cAliastmp)->mes
   Else 
      ret:= cCodemp+' - '+ cDescEmp    
   EndIf
else 
      ret:= 'Nao Encontrado'   
EndIf 

Return (ret)



static function fFiltro() 

cQuery2 :=  " SELECT distinct bxq1.BXQ_E2FORN , "
cQuery2 += CRLF+ "                   bxq1.BXQ_E2PREF , "
cQuery2 += CRLF+ "                   bxq1.BXQ_E2NUM  , " 
cQuery2 += CRLF+ "                   bxq1.BXQ_E2PARC , "
cQuery2 += CRLF+ "                   bxq1.BXQ_E2TIPO , "
cQuery2 += CRLF+ "                   bxq1.BXQ_E2LOJA   "

cQuery2 += CRLF+ "  from  " + RetSqlName("SE2") +" SE2 ,"

cQuery2 += CRLF+ "  (SELECT distinct BXQ_E2FORN , "
cQuery2 += CRLF+ "                   BXQ_E2PREF , "
cQuery2 += CRLF+ "                   BXQ_E2NUM  , " 
cQuery2 += CRLF+ "                   BXQ_E2PARC , "
cQuery2 += CRLF+ "                   BXQ_E2TIPO , "
cQuery2 += CRLF+ "                   BXQ_E2LOJA   "

cQuery2 += CRLF+ "  from " + RetSqlName("BXQ") + " BXQ "
cQuery2 += CRLF+ "   WHERE  BXQ_FILIAL     = '"+xFilial('BXQ')+ "'  and BXQ.D_E_L_E_T_ = ' ' " 

//cQuery2 += CRLF+ "   and BXQ_ANO    >= '2020' "
// cQuery2 += CRLF+ "   AND BXQ_MES    = '"+cMes+"'" 
cQuery2 += CRLF+ "   and bxq_e2num <>  ' ' "
cQuery2 += CRLF+ "   AND BXQ_CODVEN NOT in ('000174','000172','000171','000191','000177','000215' )) bxq1 "
  
cQuery2 += CRLF+ " WHERE SE2.d_e_l_e_t_ = ' ' AND E2_FILIAL = '"+xFilial('SE2')+ "' " 
  
cQuery2 += CRLF+ "   and E2_FORNECE = bxq1.BXQ_E2FORN "
cQuery2 += CRLF+ "   and E2_PREFIXO = bxq1.BXQ_E2PREF "
//cQuery2 += CRLF+ "   and E2_YLTITC <> '2' "
   
cQuery2 += CRLF+ "   and E2_NUM     = bxq1.BXQ_E2NUM  "
cQuery2 += CRLF+ "   and E2_PARCELA = bxq1.BXQ_E2PARC "
cQuery2 += CRLF+ "   and E2_TIPO    = bxq1.BXQ_E2TIPO "
cQuery2 += CRLF+ "   and E2_LOJA    = bxq1.BXQ_E2LOJA "
cQuery2 += CRLF+ "   and e2_baixa   = ' ' "  

cQuery2 += CRLF + "    AND nvl(( SELECT COUNT(*) QTDA "
cQuery2 += CRLF + "                FROM siga."+RetSQLName("PDT")+" PDT  "
cQuery2 += CRLF + "               WHERE PDT_FILIAL = '" + xFilial('PDT') + "' 
cQuery2 += CRLF + "                 AND D_e_l_e_t_ = ' ' "
cQuery2 += CRLF + "                 AND PDT_PREFIX = se2.e2_prefixo "
cQuery2 += CRLF + "                 AND PDT_NUM    = se2.e2_num "
cQuery2 += CRLF + "                 AND PDT_PARCEL = se2.e2_parcela "
cQuery2 += CRLF + "                 AND PDT_TIPO   = se2.e2_tipo  "
cQuery2 += CRLF + "                 AND PDT_FORNEC = se2.e2_fornece "
cQuery2 += CRLF + "                 and pdt_aprov  = '000047'),0) = 0 "

cQuery2 += CRLF + "    AND nvl(( SELECT COUNT(*) QTDA "
cQuery2 += CRLF + "                FROM siga."+RetSQLName("PDT")+" PDT  "
cQuery2 += CRLF + "               WHERE PDT_FILIAL = '" + xFilial('PDT') + "' 
cQuery2 += CRLF + "                 AND D_e_l_e_t_ = ' ' "
cQuery2 += CRLF + "                 AND PDT_PREFIX = se2.e2_prefixo "
cQuery2 += CRLF + "                 AND PDT_NUM    = se2.e2_num "
cQuery2 += CRLF + "                 AND PDT_PARCEL = se2.e2_parcela "
cQuery2 += CRLF + "                 AND PDT_TIPO   = se2.e2_tipo  "
cQuery2 += CRLF + "                 AND PDT_FORNEC = se2.e2_fornece "
cQuery2 += CRLF + "                 and pdt_aprov  = '001495'),0) > 0 "



If Select((cAliastmp2)) <> 0 
   (cAliastmp2)->(DbCloseArea())  
Endif                          

TCQuery cQuery2 New Alias (cAliastmp2)   

    (cAliastmp2)->( DbGoTop() )  

    While !(cAliastmp2)->(Eof())


        cTitulos  += (cAliastmp2)->BXQ_E2NUM +"|"
					
       (cAliastmp2)->(DbSkip())
	
	Enddo		

	cTitulos1 := FormatIn(cTitulos ,"|")
  
Return (cTitulos1)


