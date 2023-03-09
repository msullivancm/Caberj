#Define CRLF Chr(13)+Chr(10)
#Include "Ap5Mail.Ch"    

#include "PLSA090.ch" 
#include "PROTHEUS.CH"
#Include 'PLSMGER.CH'
#include "PLSMGER2.CH"
#include "PLSMCCR.CH"                                               
#include "topconn.ch"
#INCLUDE "TOTVS.CH"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABA121  ºAutor  ³ Altamiro	         º Data ³  01/02/2017 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Tela de browser Para carga e manutençãoi de regras para    º±±
±±º          ³ pagto        											  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ3ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CABA121()             

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta matriz com as opcoes do browse...                              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE aRotina	:=	{	{ "&Visualizar"	, 'U_caba122'		, 0, K_Visualizar	},;
						{ "&Incluir"	, 'U_Carga121'		, 0, K_Incluir		},;
						{ "Legenda"		, 'U_LEGPRO1'	    , 0, K_Incluir		} }

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Titulo e variavies para indicar o status do arquivo                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE cCadastro	:= "Browser De Manutenção dos Paramentros para pagamento gerenciado "

PRIVATE aCdCores	:= { 	{ 'BR_VERDE'    ,'Ativo'      },;
							{ 'BR_AZUL'     ,'Concluido'      },; 
							{ 'BR_VERMELHO' ,'Cancelado'         },;							
							{ 'BR_AMARELO'  ,'Suspenso' }}
 

PRIVATE aCores	:= {{'trim(PCI_STATUS) == "Ativo"' , aCdCores[1,1]},;
					{'trim(PCI_STATUS) == "Concluido"', aCdCores[2,1]},;
					{'trim(PCI_STATUS) == "Cancelado"', aCdCores[3,1]},;
					{'trim(PCI_STATUS) == "Suspenso"', aCdCores[4,1]} }   


PRIVATE cPath  := ""                        
PRIVATE cAlias := "PCI" 

PRIVATE cPerg	:= "CABA121"
                                                                          
PRIVATE cNomeProg   := "CABA121"
PRIVATE nQtdLin     := 68
PRIVATE nLimite     := 132
PRIVATE cControle   := 15
PRIVATE cTamanho    := "G"
PRIVATE cTitulo     := "Parametros de Pagamento "
PRIVATE cDesc1      := ""
PRIVATE cDesc2      := ""
PRIVATE cDesc3      := ""
PRIVATE nRel        := "caba121"
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
PRIVATE cCabec1     := "Controle de Parametros de pagamento "
PRIVATE cCabec2     := ""
PRIVATE nColuna     := 00      

private datatu      := dtos(dDataBase)     
private nVazClas    := 0      

Private cCAnPrio   := 'Sim'
Private cCAPrior   := 'Sim'
Private cCompEmi   := Space(6)
Private cDescItPg  := Space(30)
Private cHoraLog   := Space(5)
Private cSeq       := Space(2)       
Private nSeq       := 0
Private cTp        := Space(6)
Private dDtLog     := CtoD(" ")
Private nCAnPerc   := 0
Private nCAnSalPri := 0
Private nCAnVTPrio := 0
Private nCAPerc    := 0
Private nCASalPrio := 0
Private nCAVTPrior := 0
Private nOrdena   
Private nPercCus   := 0
Private nPrecIt    := 0
Private nPrecRecSD := 0
Private nStatus   
Private nVlImpAt   := 0
Private nVlRecTot  := 0
Private nVlTotPaga := 0                           
private nSldDist   := 0

private cAliasSeq2 := GetNextAlias()      
private cAliasSeq1 := GetNextAlias()     
private cAliasSeq  := GetNextAlias()   
private cAliasPCQ  := GetNextAlias()    
Private dDtatu     := dtos(dDataBase - 10)


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Starta mBrowse...                                                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbselectarea("PCI")
PCI->(DBSetOrder(1))
PCI->(mBrowse(006,001,022,075,"PCI" , , , , , Nil    , aCores, , , ,nil, .T.))
PCI->(DbClearFilter())

Return
              


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
User Function LEGPRO1()
Local aLegenda

	aLegenda 	:= { 	{ aCdCores[1,1],aCdCores[1,2] },;
						{ aCdCores[2,1],aCdCores[2,2] },;
						{ aCdCores[3,1],aCdCores[3,2] },;
	              		{ aCdCores[4,1],aCdCores[4,2] } }

	                     	
BrwLegenda(cCadastro,"Status" ,aLegenda)

Return                 

User Function CARGA121()

Local lRetTit	:= .F. 
Local lsegue	:= .F.
Local cQryTit	:= ""

local i


AjustaSX1()

Pergunte(cPerg,.T.)  

/////


ProcRegua(0) 

nCont := 0

for i:=1 to 5
    IncProc('Buscando Dados no Servidor ...') 
next   

nVazClas:=fPegpcq(MV_PAR01)

cQryTit :=       " SELECT DISTINCT 'CTMD' TIPO , "  
IF nVazClas ==1
  cQryTit += CRLF +"        ' '  CLSRED , " 
Else 
  cQryTit += CRLF +"        BAU1.CLSRED CLSRED, "
EndIf
cQryTit += CRLF +"        '"+MV_PAR01+"' PLLOTE ,  "
cQryTit += CRLF +"        BAU1.GRPPAG , "  
cQryTit += CRLF +"		  BAU1.GRPPAGDES , "  
cQryTit += CRLF +"		  PCQ.PCQ_VLRLI PCQ_VLRLI , 
cQryTit += CRLF +"		  PCQ.PCQ_VLREC PCQ_VLREC ,
cQryTit += CRLF +"		  PCQ.PCQ_STATU PCQ_STATU , 
cQryTit += CRLF +"		  PCQ.PCQ_SEQ PCQ_SEQ ,                       
cQryTit += CRLF +"	   	  NVL(SE21.LOTE0 , ' ' ) LOTE0  , "
cQryTit += CRLF +"	      NVL(SE23.LOTE1 , ' ' ) LOTE1  , "        
cQryTit += CRLF +"	   	  NVL(SE24.LOTE2 , ' ' ) LOTE2  , "  
cQryTit += CRLF +"	   	  NVL(SE25.LOTE3 , ' ' ) LOTE3  , "
/*
IF nVazClas == 1
   cQryTit += CRLF +"		  SUM(PCQ.PCQ_PERCU) PCQ_PERCU ,    
   cQryTit += CRLF +" 		  SUM(NVL(SE22.TOTAL,0)) TOTAL_REC, "  
   cQryTit += CRLF +"		  SUM(NVL(SE221.VALOR1,0)) SALDO_REC , "   
   cQryTit += CRLF +"		  ROUND(SUM(NVL(SE21.VALOR0,0)  * 100 /SE22.TOTAL)),2 PREC , " 
   cQryTit += CRLF +"		  SUM(NVL(SE21.IMPOSTOS,0)) IMPOSTOS , "   
   cQryTit += CRLF +"	   	  SUM(NVL(SE21.VALOR0,0)) VALOR0  ,   "
   cQryTit += CRLF +"		  SUM(NVL(SE23.VALOR1,0)) VALOR_ANT1 , " 
   cQryTit += CRLF +"		  SUM(NVL(SE24.VALOR2,0)) VALOR_ANT2 , " 
   cQryTit += CRLF +"		  SUM(NVL(SE25.VALOR3,0)) VALOR_ANT3  "      
Else */
   cQryTit += CRLF +"		  PCQ.PCQ_PERCU PCQ_PERCU ,    
   cQryTit += CRLF +" 		  NVL(SE22.TOTAL,0) TOTAL_REC, "  
   cQryTit += CRLF +"		  NVL(SE221.VALOR1,0) SALDO_REC , "
   cQryTit += CRLF +"		  ROUND(((NVL(SE21.VALOR0,0) ) * 100 /SE22.TOTAL),2) PREC , " 
   cQryTit += CRLF +"		  NVL(SE21.IMPOSTOS,0) IMPOSTOS , "   
   cQryTit += CRLF +"	   	  NVL(SE21.VALOR0,0) VALOR0  ,   "
   cQryTit += CRLF +"		  NVL(SE23.VALOR1,0) VALOR_ANT1 , "
   cQryTit += CRLF +"		  NVL(SE24.VALOR2,0) VALOR_ANT2 , " 
   cQryTit += CRLF +"		  NVL(SE25.VALOR3,0) VALOR_ANT3  "     
//EndIf    

cQryTit += CRLF +"	 FROM " +RetSqlName('PCQ')+ " PCQ , " 
//dados basicos da competencia atual
cQryTit += CRLF +"		  (SELECT SUBSTR(E2_PLLOTE,1,6) LOTE0 , "
cQryTit += CRLF +"		          BAU_GRPPAG GRPPAG0  , "    
IF nVazClas !=1
   cQryTit += CRLF +"		          BAU_TIPPRE TIPPRE0 ,  " 
EndIf     
cQryTit += CRLF +"		          SUM(E2_SALDO) VALOR0 , "
cQryTit += CRLF +"		          SUM(E2_SALDO) VALOR  , "      
cQryTit += CRLF +"		          SUM(SE2.E2_VRETPIS + SE2.E2_VRETCOF + SE2.E2_VRETCSL + SE2.E2_INSS + SE2.E2_ISS + SE2.E2_IRRF) IMPOSTOS , "
cQryTit += CRLF +"		          SUM(SE2.E2_VALOR+SE2.E2_VRETPIS + SE2.E2_VRETCOF + SE2.E2_VRETCSL + SE2.E2_INSS + SE2.E2_ISS + SE2.E2_IRRF) TOTAL0 "
cQryTit += CRLF +"		     FROM " +RetSqlName('BAU')+ " BAU1 , " +RetSqlName('SE2')+ " se2 "  
cQryTit += CRLF +"		    WHERE E2_FILIAL  = '" + xFilial('SE2') +"' AND SE2.D_E_L_E_T_  = ' ' "
cQryTit += CRLF +"		      AND BAU_FILIAL = '" + xFilial('BAU') +"' AND BAU1.D_E_L_E_T_ = ' '  AND BAU1.R_E_C_D_E_L_ = 0 "
cQryTit += CRLF +"		      AND E2_SALDO > 0 "
cQryTit += CRLF +"		      AND TRIM(E2_TIPO) = 'FT' "
cQryTit += CRLF +"		      AND '"+MV_PAR01+"' = SUBSTR(E2_PLLOTE,1,6) "
cQryTit += CRLF +"		      AND E2_PLLOTE LIKE '"+MV_PAR01+"%'" 
cQryTit += CRLF +"		      AND E2_NUMBOR = ' ' " 
cQryTit += CRLF +"            AND (E2_DATALIB = ' ' OR E2_DATALIB < '"+dDtatu+"') "                          
cQryTit += CRLF +"		      AND E2_YLIBPLS IN ('L','S') "
cQryTit += CRLF +"		      AND E2_CODRDA = BAU1.BAU_CODIGO "
cQryTit += CRLF +"		    GROUP BY SUBSTR(E2_PLLOTE,1,6), BAU_GRPPAG "
IF nVazClas !=1 
cQryTit += CRLF +"  , BAU_TIPPRE  "
endIF 
cQryTit += CRLF +") SE21 , "
//dados basicos do rda                                                                                        
cQryTit += CRLF +"		  (SELECT  "
IF nVazClas !=1 
   cQryTit += CRLF +" BAU.BAU_TIPPRE CLSRED , "
EndIf 
cQryTit += CRLF +" BAU.BAU_GRPPAG GRPPAG , NVL(B16.B16_CODIGO, '0') ||'-'|| NVL(B16.B16_DESCRI , 'S/GRPPAG') GRPPAGDES "
cQryTit += CRLF +"	         FROM " +RetSqlName('BAU')+ " BAU , " +RetSqlName('B16')+ " B16 " 
cQryTit += CRLF +"          WHERE BAU.BAU_FILIAL     = '  ' AND BAU.D_E_L_E_T_    = ' '  AND BAU.R_E_C_D_E_L_ = 0 "
cQryTit += CRLF +"            AND B16_FILIAL(+)      = '  ' AND B16.D_E_L_E_T_(+) = ' ' "
cQryTit += CRLF +"            AND BAU.BAU_GRPPAG = B16.B16_CODIGO(+) )BAU1 ,"  
// valor total do custo da competencia atual  
cQryTit += CRLF +"		  (SELECT SUM(SE21.E2_VALOR+SE21.E2_VRETPIS + SE21.E2_VRETCOF + SE21.E2_VRETCSL + SE21.E2_INSS + SE21.E2_ISS + SE21.E2_IRRF) TOTAL "
cQryTit += CRLF +"		     FROM "+RetSqlName('SE2')+"  SE21 "  
cQryTit += CRLF +"		    WHERE E2_FILIAL  = '" + xFilial('SE2')+"' AND  SE21.D_E_L_E_T_ = ' ' "  
cQryTit += CRLF +"		      AND TRIM(E2_TIPO) = 'FT' AND E2_PLLOTE LIKE '"+MV_PAR01+"%') SE22 , "     
//valor total liberado - controlado pelo custo atual deve mudar para o controle que sera gravado na se2 e na capa de cada lote 
cQryTit += CRLF +"		  (SELECT SUBSTR(E2_PLLOTE,1,6) LOTE1 , "
cQryTit += CRLF +"		          BAU_GRPPAG GRPPAG1 , "
IF nVazClas !=1 
   cQryTit += CRLF +"		          BAU_TIPPRE TIPPRE1 , "   
EndIf   
cQryTit += CRLF +"		          E2_CTRPGT  CTRPGT  , "
cQryTit += CRLF +"		          SUM(E2_VALOR) VALOR1 " 
cQryTit += CRLF +"		     FROM " +RetSqlName('BAU')+ " BAU1 , " +RetSqlName('SE2')+ " se2 "  
cQryTit += CRLF +"		    WHERE E2_FILIAL  = '" + xFilial('SE2')+"' AND SE2.D_E_L_E_T_    = ' ' " 
cQryTit += CRLF +"		      AND BAU_FILIAL = '" + xFilial('BAU')+"' AND BAU1.D_E_L_E_T_    = ' '  AND BAU1.R_E_C_D_E_L_ = 0  "
cQryTit += CRLF +"		      AND TRIM(E2_TIPO) = 'FT' "
cQryTit += CRLF +"            AND (E2_PLLOTE >= '"+MV_PAR01+"0001' AND TO_CHAR(ADD_MONTHS(TO_DATE('"+MV_PAR01+"' ,'YYYYMM'),-0 ),'YYYYMM') = SUBSTR(E2_PLLOTE,1,6) )"                    
cQryTit += CRLF +"            AND ( E2_DATALIB >= '"+dDtatu+"' OR E2_SALDO = 0   ) "      

IF nVazClas ==2
   cQryTit += CRLF +"            AND E2_ctrpgt = SUBSTR(E2_PLLOTE,1,6)||BAU_GRPPAG||BAU_TIPPRE||'"+strzero(nSeq,2)+"'"                                                                       
Else                                                                                                                                                                                      
   cQryTit += CRLF +"            AND E2_ctrpgt = SUBSTR(E2_PLLOTE,1,6)||BAU_GRPPAG||' '||'"+strzero(nSeq,2)+"'"                                                                       
EndIf                                                                                  

cQryTit += CRLF +"            AND E2_CODRDA = BAU1.BAU_CODIGO "
cQryTit += CRLF +"            GROUP BY SUBSTR(E2_PLLOTE,1,6), BAU_GRPPAG , 
IF nVazClas !=1 
   cQryTit += CRLF +"            BAU_TIPPRE , "
Endif 
cQryTit += CRLF +"            E2_CTRPGT ) SE221 , "     
//dados basico da comptencia atua - 1 mes
cQryTit += CRLF +"		  (SELECT SUBSTR(E2_PLLOTE,1,6) LOTE1 , "
cQryTit += CRLF +"		          BAU_GRPPAG GRPPAG1 , "
IF nVazClas !=1 
    cQryTit += CRLF +"		          BAU_TIPPRE TIPPRE1 , " 
Endif    
cQryTit += CRLF +"		          SUM(E2_SALDO) VALOR1 " 
cQryTit += CRLF +"		     FROM " +RetSqlName('BAU')+ " BAU1 , " +RetSqlName('SE2')+ " se2 "  
cQryTit += CRLF +"		    WHERE E2_FILIAL  = '" + xFilial('SE2')+"' AND SE2.D_E_L_E_T_    = ' ' " 
cQryTit += CRLF +"		      AND BAU_FILIAL = '" + xFilial('BAU')+"' AND BAU1.D_E_L_E_T_    = ' '  AND BAU1.R_E_C_D_E_L_ = 0  "
cQryTit += CRLF +"		      AND E2_SALDO > 0 "
cQryTit += CRLF +"		      AND TRIM(E2_TIPO) = 'FT' "
cQryTit += CRLF +"            AND (E2_PLLOTE < '"+MV_PAR01+"0001' AND TO_CHAR(ADD_MONTHS(TO_DATE('"+MV_PAR01+"' ,'YYYYMM'),-1 ),'YYYYMM') = SUBSTR(E2_PLLOTE,1,6) )"  
cQryTit += CRLF +"            AND E2_NUMBOR = ' ' " 
cQryTit += CRLF +"            AND (E2_DATALIB = ' ' OR E2_DATALIB < '"+dDtatu+"') "                          
cQryTit += CRLF +"            AND E2_YLIBPLS IN ('L','S') "            

cQryTit += CRLF +"            AND E2_CODRDA = BAU1.BAU_CODIGO "
cQryTit += CRLF +"            GROUP BY SUBSTR(E2_PLLOTE,1,6), BAU_GRPPAG "
IF nVazClas !=1 
   cQryTit += CRLF +"            , BAU_TIPPRE  "
EndIF 
cQryTit += CRLF +"            ) SE23 , "     
   
//dados basico da comptencia atua - 2 mes
cQryTit += CRLF +"		  (SELECT SUBSTR(E2_PLLOTE,1,6) LOTE2 , "   
cQryTit += CRLF +"		          BAU_GRPPAG GRPPAG2 ,  
IF nVazClas !=1 
   cQryTit += CRLF +"		          BAU_TIPPRE TIPPRE2 ,   
EndIf   
cQryTit += CRLF +"		          SUM(E2_SALDO) VALOR2 "   
cQryTit += CRLF +"		     FROM " +RetSqlName('BAU')+ " BAU1 , " +RetSqlName('SE2')+ " se2  "  
cQryTit += CRLF +"		    WHERE E2_FILIAL  = '" + xFilial('SE2')+"' AND SE2.D_E_L_E_T_  = ' ' "   
cQryTit += CRLF +"		      AND BAU_FILIAL = '" + xFilial('BAU')+"' AND BAU1.D_E_L_E_T_ = ' '  AND BAU1.R_E_C_D_E_L_ = 0 "  
cQryTit += CRLF +"		      AND E2_SALDO > 0 " 
cQryTit += CRLF +"		      AND TRIM(E2_TIPO) = 'FT' "  
cQryTit += CRLF +"            AND (E2_PLLOTE < '"+MV_PAR01+"0001' AND TO_CHAR(ADD_MONTHS(TO_DATE('"+MV_PAR01+"' ,'YYYYMM'),-2 ),'YYYYMM') = SUBSTR(E2_PLLOTE,1,6) )"   
cQryTit += CRLF +"            AND E2_NUMBOR = ' ' "          
cQryTit += CRLF +"            AND (E2_DATALIB = ' ' OR E2_DATALIB < '"+dDtatu+"') "                          
cQryTit += CRLF +"            AND E2_YLIBPLS IN ('L','S') "   
cQryTit += CRLF +"            AND E2_CODRDA = BAU1.BAU_CODIGO "   

cQryTit += CRLF +"            GROUP BY SUBSTR(E2_PLLOTE,1,6), BAU_GRPPAG , BAU_TIPPRE  ) SE24 , "      
//dados basico da comptencia atua - 3 mes
cQryTit += CRLF +"		  (SELECT SUBSTR(E2_PLLOTE,1,6) LOTE3 , "   
cQryTit += CRLF +"		          BAU_GRPPAG GRPPAG3 ,  
IF nVazClas !=1 
   cQryTit += CRLF +"		          BAU_TIPPRE TIPPRE3 ,   
EndIf
cQryTit += CRLF +"		          SUM(E2_SALDO) VALOR3 "   
cQryTit += CRLF +"		     FROM " +RetSqlName('BAU')+ " BAU1 , " +RetSqlName('SE2')+ " se2  "  
cQryTit += CRLF +"		    WHERE E2_FILIAL  = '" + xFilial('SE2')+"' AND SE2.D_E_L_E_T_    = ' ' "   
cQryTit += CRLF +"		      AND BAU_FILIAL = '" + xFilial('BAU')+"' AND BAU1.D_E_L_E_T_    = ' '  AND BAU1.R_E_C_D_E_L_ = 0 "  
cQryTit += CRLF +"		      AND E2_SALDO > 0 " 
cQryTit += CRLF +"		      AND TRIM(E2_TIPO) = 'FT' "  
cQryTit += CRLF +"            AND (E2_PLLOTE < '"+MV_PAR01+"0001' AND TO_CHAR(ADD_MONTHS(TO_DATE('"+MV_PAR01+"' ,'YYYYMM'),-3 ),'YYYYMM') = SUBSTR(E2_PLLOTE,1,6) )"   
cQryTit += CRLF +"            AND E2_NUMBOR = ' ' "                                                          
cQryTit += CRLF +"            AND (E2_DATALIB = ' ' OR E2_DATALIB < '"+dDtatu+"') "                          
cQryTit += CRLF +"            AND E2_YLIBPLS IN ('L','S') "   
cQryTit += CRLF +"            AND E2_CODRDA = BAU1.BAU_CODIGO "   

cQryTit += CRLF +"            GROUP BY SUBSTR(E2_PLLOTE,1,6), BAU_GRPPAG , BAU_TIPPRE  ) SE25  "      

cQryTit += CRLF +"  WHERE SE21.GRPPAG0(+)  = BAU1.GRPPAG " 

cQryTit += CRLF +"    AND SE221.GRPPAG1(+) = BAU1.GRPPAG "

cQryTit += CRLF +"    AND SE23.GRPPAG1(+)  = BAU1.GRPPAG "

cQryTit += CRLF +"    AND SE24.GRPPAG2(+)  = BAU1.GRPPAG " 

cQryTit += CRLF +"    AND SE25.GRPPAG3(+)  = BAU1.GRPPAG "      
cQryTit += CRLF +"    AND PCQ_FILIAL  = '" + xFilial('PCQ')+"' AND PCQ.D_e_l_e_t_ = ' ' "
cQryTit += CRLF +"    AND PCQ_CPTPGT  = '"+MV_PAR01+"' " 
cQryTit += CRLF +"    AND PCQ.PCQ_STATU IN('Ativo') "
cQryTit += CRLF +"    AND BAU1.GRPPAG = PCQ.PCQ_GRPPAG  
if nVazClas == 2 
   cQryTit += CRLF +"    AND BAU1.CLSRED  = PCQ.PCQ_CLSRED  " 
   
   cQryTit += CRLF +"    AND SE21.TIPPRE0(+)  = BAU1.CLSRED "  
   cQryTit += CRLF +"    AND SE221.TIPPRE1(+) = BAU1.CLSRED " 
   cQryTit += CRLF +"    AND SE23.TIPPRE1(+)  = BAU1.CLSRED " 
   cQryTit += CRLF +"    AND SE24.TIPPRE2(+)  = BAU1.CLSRED " 
   cQryTit += CRLF +"    AND SE24.TIPPRE2(+)  = BAU1.CLSRED " 
   cQryTit += CRLF +"    AND SE25.TIPPRE3(+)  = BAU1.CLSRED " 
EndIf  
//cQryTit += CRLF +"    AND ( SE21.VALOR0 > 0 OR SE23.VALOR1 > 0 OR  SE24.VALOR2 > 0 OR  SE25.VALOR3 > 0 OR SE221.VALOR1 > 0)"  
cQryTit += CRLF +"    AND ( SE21.VALOR0 > 0 OR SE23.VALOR1 > 0 OR  SE24.VALOR2 > 0 OR  SE25.VALOR3 > 0 )"
/*
if nVazClas == 1 
   cQryTit += CRLF +" GROUP BY '"+MV_PAR01+"'  ,  "
   cQryTit += CRLF +"       BAU1.GRPPAG , "  
   cQryTit += CRLF +"		BAU1.GRPPAGDES , "  
   cQryTit += CRLF +"		PCQ.PCQ_VLRLI , 
   cQryTit += CRLF +"		PCQ.PCQ_VLREC ,
   cQryTit += CRLF +"		PCQ.PCQ_STATU , 
   cQryTit += CRLF +"		PCQ.PCQ_SEQ ,
   cQryTit += CRLF +"	   	NVL(SE21.LOTE0 , ' ' ) , "
   cQryTit += CRLF +"	    NVL(SE23.LOTE1 , ' ' ) , "        
   cQryTit += CRLF +"	   	NVL(SE24.LOTE2 , ' ' ) , "  
   cQryTit += CRLF +"	   	NVL(SE25.LOTE3 , ' ' )  "
EndIf 
*/
cQryTit += CRLF +"  ORDER BY 4,2,1 "

 If Select((cAliasSeq)) <> 0 
      
    (cAliasSeq)->(DbCloseArea()) 
 
 Endif           
              
TcQuery cQryTit New Alias (cAliasSeq) 

If Select((cAliasSeq)) <= 0
 
   Return()

EndIf     

nseqc := fpegseq((cAliasSeq)->PLLOTE )       

lsegue:= fConflanc((cAliasSeq)->PLLOTE)

dDtatu1 := dtos(dDataBase)

If lsegue
   While !(cAliasSeq)->(EOF()) 
      if 	lRetTit == .F.
        	lRetTit:=.T.
	  EndIf                       
	  nSldDist := (cAliasSeq)->PCQ_VLRLI //- cAliasSeq->saldo_rec 
  
      dBSelectArea("PCI")    
	   
      RecLock( "PCI" , .T. )      
	                                    
		  PCI->PCI_CLSRED :=  (cAliasSeq)->CLSRED    
		  PCI->PCI_CPTAN1 :=  (cAliasSeq)->LOTE1    
		  PCI->PCI_CPTAN2 :=  (cAliasSeq)->LOTE2     
		  PCI->PCI_CPTAN3 :=  (cAliasSeq)->LOTE3
		  PCI->PCI_CPTAT0 :=  (cAliasSeq)->LOTE0     
		  PCI->PCI_CPTPGT :=  (cAliasSeq)->PLLOTE    
		  PCI->PCI_DESCPG :=  (cAliasSeq)->GRPPAGDES
		  PCI->PCI_SEQ    :=  (cAliasSeq)->PCQ_SEQ //nseqc       
		  PCI->PCI_SLDREC :=   iif(((cAliasSeq)->PCQ_VLRLI - (cAliasSeq)->saldo_rec) > 0.00 , ((cAliasSeq)->PCQ_VLRLI - (cAliasSeq)->saldo_rec) , 0.00) 
		  PCI->PCI_TIPO   :=  (cAliasSeq)->TIPO        
		  
       	  PCI->PCI_ATV03  :=  Iif (trim((cAliasSeq)->LOTE3)!= '' ,'Sim','Não')    
		  If (nSldDist ) < 1    
             PCI->PCI_ATV03 := 'Não'
          EndIf    		       
		
	      PCI->PCI_ATV02  :=  Iif (trim((cAliasSeq)->LOTE2)!= '' ,'Sim','Não')      
          If (nSldDist -= (cAliasSeq)->VALOR_ANT3) < 1    
             PCI->PCI_ATV02 := 'Não'
          EndIf    		       		  
		
		  PCI->PCI_ATV01  :=  Iif (trim((cAliasSeq)->LOTE1)!= '' ,'Sim','Não')    
		  If (nSldDist -= (cAliasSeq)->VALOR_ANT2 ) < 1    
             PCI->PCI_ATV01 := 'Não'
          EndIf    		       
          
		  PCI->PCI_ATV0   :=  Iif (trim((cAliasSeq)->LOTE0)!= '' ,'Sim','Não')      
		  If (nSldDist -= (cAliasSeq)->VALOR_ANT1 ) < 1 
             PCI->PCI_ATV0 := 'Não'
          EndIf    
		  
		  PCI->PCI_CPTREC :=  MV_PAR01    
		  PCI->PCI_ORDENA :=  'Vlr Maior -> Menor'      
		  PCI->PCI_PERCUS :=  (cAliasSeq)->PREC         
		  
		  nPrecent:= iif(((((cAliasSeq)->PCQ_VLRLI - (cAliasSeq)->saldo_rec) * 100) / (cAliasSeq)->PCQ_VLRLI ) < 0.00 , 0.00 , ;
		                  (((cAliasSeq)->PCQ_VLRLI - (cAliasSeq)->saldo_rec) * 100) / (cAliasSeq)->PCQ_VLRLI )  
		  If nPrecent >= 0.00 
		     PCI->PCI_PRECSD := nPrecent
		  Else 
		     PCI->PCI_PRECSD := 00.00
		  endIf      	

		  nPrecent:= 100.00 - nPrecent //(((cAliasSeq->PCQ_VLRLI - cAliasSeq->saldo_rec) * 100) / cAliasSeq->PCQ_VLRLI )  
          If nPrecent <=100.00
		     PCI->PCI_PRECAL := nPrecent
		  Else 
		     PCI->PCI_PRECAL := 99.99
		  endIf      	   
		  
		      
		  PCI->PCI_PRREA0 :=  0.00    
		  PCI->PCI_PRREA1 :=  0.00    
		  PCI->PCI_PRREA2 :=  0.00    
		  PCI->PCI_PRREA3 :=  0.00    
                                                   
          If (cAliasSeq)->PCQ_VLRLI >= (cAliasSeq)->VALOR_ANT3 
             nsaldorec := (cAliasSeq)->PCQ_VLRLI - (cAliasSeq)->VALOR_ANT3
             PCI->PCI_SLEST3 :=  (cAliasSeq)->VALOR_ANT3
          Else                           
   		     PCI->PCI_SLEST3 :=  (cAliasSeq)->PCQ_VLRLI              
   		     nsaldorec := 0
   		  EndIf     
   		  
   		  If nsaldorec >= (cAliasSeq)->VALOR_ANT2 .and. nsaldorec > 0
             nsaldorec := nsaldorec - (cAliasSeq)->VALOR_ANT2
             PCI->PCI_SLEST2 :=  (cAliasSeq)->VALOR_ANT2
          Else                           
   		     PCI->PCI_SLEST2 :=  nsaldorec              
   		     nsaldorec := 0
   		  EndIf     
   		  
   		  If nsaldorec >= (cAliasSeq)->VALOR_ANT1 .and. nsaldorec > 0
             nsaldorec := nsaldorec - (cAliasSeq)->VALOR_ANT1
             PCI->PCI_SLEST1 := (cAliasSeq)->VALOR_ANT1
          Else                           
   		     PCI->PCI_SLEST1 :=  nsaldorec              
   		     nsaldorec := 0
   		  EndIf     
   		           
   		  If nsaldorec >= (cAliasSeq)->VALOR0 .and. nsaldorec > 0
             nsaldorec := nsaldorec - (cAliasSeq)->VALOR0
             PCI->PCI_SLEST0 :=  (cAliasSeq)->VALOR0
          Else                           
   		     PCI->PCI_SLEST0 :=  nsaldorec              
   		     nsaldorec := 0
   		  EndIf  
   		  
   		  PCI->PCI_PREST0 := Iif (trim(PCI->PCI_ATV0) = 'Sim' , Iif(PCI->PCI_SLEST0 > 0,((PCI->PCI_SLEST0*100)/(cAliasSeq)->VALOR0)    ,0.00),0.00)     
		  PCI->PCI_PREST1 := Iif (trim(PCI->PCI_ATV01)= 'Sim' , Iif(PCI->PCI_SLEST1 > 0,((PCI->PCI_SLEST1*100)/(cAliasSeq)->VALOR_ANT1),0.00),0.00)     
		  PCI->PCI_PREST2 := Iif (trim(PCI->PCI_ATV02)= 'Sim' , Iif(PCI->PCI_SLEST2 > 0,((PCI->PCI_SLEST2*100)/(cAliasSeq)->VALOR_ANT2),0.00),0.00)    
		  PCI->PCI_PREST3 := Iif (trim(PCI->PCI_ATV03)= 'Sim' , Iif(PCI->PCI_SLEST3 > 0,((PCI->PCI_SLEST3*100)/(cAliasSeq)->VALOR_ANT3),0.00),0.00)    

		  PCI->PCI_STATUS :=  (cAliasSeq)->PCQ_STATU     
		  PCI->PCI_VLEST0 :=  (cAliasSeq)->VALOR0   
		  PCI->PCI_VLEST1 :=  (cAliasSeq)->VALOR_ANT1    
		  PCI->PCI_VLEST2 :=  (cAliasSeq)->VALOR_ANT2    
		  PCI->PCI_VLEST3 :=  (cAliasSeq)->VALOR_ANT3    
		  PCI->PCI_VLRTOT :=  ((cAliasSeq)->VALOR0 + (cAliasSeq)->VALOR_ANT1 + (cAliasSeq)->VALOR_ANT2 + (cAliasSeq)->VALOR_ANT3) 
		  PCI->PCI_VLTREC :=  (cAliasSeq)->PCQ_VLRLI   
		  PCI->PCI_VLREA0 :=  0.00     
		  PCI->PCI_VLREA1 :=  0.00     
		  PCI->PCI_VLREA2 :=  0.00     
		  PCI->PCI_VLREA3 :=  0.00     
		
		  PCI->PCI_LOGINC :=  SubStr(cUSUARIO,7,15)
		  PCI->PCI_LOGDT  :=  stod(dDtatu1)
		  cHora           :=  Time()           
		  PCI->PCI_HORALO :=  substr(cHora,1,5)    
		
          PCI->(MSUNLOCK())      
          
 
      (cAliasSeq)->(DbSkip())
    
   EndDo  


        cQuery := " UPDATE " +RetSqlName('PCQ')    + CRLF
		cQuery += "    SET PCQ_STATU  = 'Concluido' "  + CRLF
        cQuery += "  WHERE PCQ_CPTPGT = '"+MV_PAR01+"' AND PCQ_STATU  = 'Ativo'"  + CRLF
		
		nSucesso := TcSqlExec(cQuery) 
   
Else 

    MsgAlert("Existe lancamento Ativo ou Suspenso para a Competencia : "+ (cAliasSeq)->PLLOTE + CRLF + ;
             "Conclua ou Cancela , TODOS os lnacamento e refaça a operação  !!!","Atenção" )       

    lRetTit:=.T.

EndIf            

(cAliasSeq)->(DbCloseArea())

   
If !(lRetTit) 

    MsgAlert("Nao Dados para esta consulta "  + CRLF + " Revise seus parametros !!! ","Atencao!")
    lsai := .T.    
    
EndIf        

RETURN() 

//////////////////// 
static Function fConflanc ( PLLOTE )   

Local lret	    := .F.     
local lSegue    := .F.
Local cQrySeq	:= ""                                       

cQrySeq := " SELECT COUNT(*) qtda               "  + CRLF
cQrySeq += "   FROM " +RetSqlName('PCI')+ " PCI , " +RetSqlName('PCQ')+ " PCQ  " + CRLF
cQrySeq += "  WHERE PCI_FILIAL ='"+ xFilial('PCI') +"' AND PCI.D_E_L_E_T_ = ' ' " + CRLF 
cQrySeq += "    AND PCQ_FILIAL ='"+ xFilial('PCQ') +"' AND PCQ.D_E_L_E_T_ = ' ' " + CRLF
cQrySeq += "    AND PCI_CPTPGT  = '"+ltrim(PLLOTE)+"'"    + CRLF                             
cQrySeq += "    AND PCQ_SEQ =      PCI_SEQ " + CRLF 
cQrySeq += "    AND PCI_CPTPGT  =  PCQ_CPTPGT " + CRLF 
cQrySeq += "    AND trim(PCI_CLSRED)  =  Trim(PCQ_CLSRED) " + CRLF
cQrySeq += "    AND PCI.PCI_STATUS IN('Ativo') " + CRLF
cQrySeq += "    AND PCQ.PCQ_STATU  IN('Ativo') " + CRLF
 
   
If Select((cAliasSeq2)) <> 0 

   (cAliasSeq2)->(DbCloseArea()) 

Endif           
                        
TcQuery cQrySeq New Alias (cAliasSeq2)

If (cAliasSeq2)->qtda == 0 

   lSegue:= .T.
EndIf 

return( lSegue )


static Function fPegpcq(MV_PAR01)
            
local  ret:= 0 
 
cQryPCQ := " SELECT DISTINCT  DECODE(TRIM(PCQ_CLSRED), '', 'G','C') CLSRED   , pcq_seq seq "     + CRLF
cQryPCQ += "   FROM " +RetSqlName('PCQ')+ " PCQ "  + CRLF
cQryPCQ += "  WHERE PCQ_FILIAL ='"+ xFilial('PCQ') +"' AND D_E_L_E_T_ = ' ' " + CRLF
cQryPCQ += "    AND PCQ_CPTPGT = '"+MV_PAR01+"'"     + CRLF
cQryPCQ += "    AND PCQ_STATU  = 'Ativo'"            + CRLF       

                        
If Select(cAliasPCQ) <> 0 

   (cAliasPCQ)->(DbCloseArea()) 

Endif           

TcQuery cQryPCQ New Alias (cAliasPCQ)    

If trim((cAliasPCQ)->CLSRED) == 'G'
   ret:=1
Else       
   ret:=2
EndIf   
nSeq:= (cAliasPCQ)->seq 
               

Return( ret )

static Function fpegseq( PLLOTE )   

Local nSeq	    := .F.
Local cQrySeq	:= ""                          
                                       

cQrySeq := " SELECT NVL(MAX(PCI_SEQ), 0) SEQ "     + CRLF
cQrySeq += "   FROM " +RetSqlName('PCI')+ " PCI "  + CRLF
cQrySeq += "  WHERE PCI_FILIAL ='"+ xFilial('PCI') +"' AND D_E_L_E_T_ = ' ' " + CRLF
cQrySeq += "    AND PCI_CPTPGT = '"+PLLOTE+"'"     + CRLF
//cQrySeq += "    AND PCI_TIPO   = '"+TIPO+"'"       + CRLF       

                        
If Select((cAliasSeq1)) <> 0 

   (cAliasSeq1)->(DbCloseArea()) 

Endif           

TcQuery cQrySeq New Alias (cAliasSeq1)

return((cAliasSeq1)->seq + 1)
 
 /////////////////////                 

Static Function AjustaSX1()

Local aHelp 	:= {}

aHelp := {}  
aAdd(aHelp, "Informe Competecia custo  / Anomes emissao titulos   ")
PutSX1(cPerg , "01" , "Competencia  " 	,"","","mv_ch1","C",6,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)
                                                                                                                                    

Return

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ tranmiste email                                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Static Function fEnvEmail( cRda )

Local lEmail     := .F.
Local c_CampAlt  := '  ' 
Local lExecuta   := .T.   
local cDest      := " "                           
Local aArea      := GetArea() //Armazena a Area atual        
Local _cMensagem := " "      
local cDest      := "altamiro@caberj.com.br"

_cMensagem := "Em " + DtoC( Date() ) +  Chr(10) + Chr(13) + Chr(10) + Chr(13) 

_cMensagem +=  Chr(13) + Chr(10) + Chr(13) + Chr(10) + " Assunto : Pagamento de Rda's a Libera : " 
_cMensagem +=  Chr(13) + Chr(10) + Chr(13) + Chr(10) + "Prezados,"       

_cMensagem +=  Chr(13) + Chr(10) + Chr(13) + Chr(10) + "Existe(m) Pagamento(s) de Rda('s) aguardando Liberação(oes) por Alçada "
_cMensagem +=  Chr(13) + Chr(10) + Chr(13) + Chr(10) + cRda    
 

  cDest:= "altamiro@caberj.com.br ; piumbim@caberj.com.br"

EnvEmail1( _cMensagem , cDest) 

RestArea(aArea)             

Return (.T.)                                                          

*--------------------------------------*
Static Function EnvEmail1( _cMensagem , cDest )
*--------------------------------------*                                           

Local _cMailServer := GetMv( "MV_RELSERV" )
Local _cMailConta  := GetMv( "MV_EMCONTA" )
Local _cMailSenha  := GetMv( "MV_EMSENHA" ) 

//Local _cTo  	 := "altamiro@caberj.com.br, paulovasques@caberj.com.br, piumbim@caberj.com.br"
Local _cTo  	   := cDest //"altamiro@caberj.com.br "
Local _cCC         := " "  //GetMv( "MV_WFFINA" )
Local _cAssunto    := " Alteração de Vencimento  "
Local _cError      := ""
Local _lOk         := .T.
Local _lSendOk     := .F.
local cto_         := ' '

//_cTo+= cDest

If !Empty( _cMailServer ) .And.    !Empty( _cMailConta  ) 
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
