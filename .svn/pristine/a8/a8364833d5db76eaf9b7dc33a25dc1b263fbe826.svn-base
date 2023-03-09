#Define CRLF Chr(13)+Chr(10)
#Include "Ap5Mail.Ch"    

#include "PLSA090.ch" 
#include "PROTHEUS.CH"
#Include 'PLSMGER.CH'                                                        
#include "PLSMGER2.CH"
#include "PLSMCCR.CH"                                               
#include "topconn.ch"
#INCLUDE "TOTVS.CH"
                             
#INCLUDE "RWMAKE.CH"
#include "fileio.ch"
/*
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±…ÕÕÕÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕª±±
±±∫Programa  ≥CABA125  ∫Autor  ≥ Altamiro	         ∫ Data ≥  01/02/2017 ∫±±
±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕπ±±
±±∫Desc.     ≥ Tela de browser Para carga e manutenÁ„oi de regras para    ∫±±
±±∫          ≥ pagto        											  ∫±±
±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕπ±±
±±∫Uso       ≥ AP                                                         ∫±±
±±»ÕÕÕÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕº±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
*/

User Function CABA125()             

//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
//≥ Monta matriz com as opcoes do browse...                              ≥
//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
PRIVATE aRotina	:=	{	{ "&Visualizar"	, 'U_caba126'		, 0, K_Visualizar	},;
						{ "&Incluir"	, 'U_Carga125'		, 0, K_Incluir		},;
						{ "Legenda"		, 'U_LEPRO1'        , 0, K_Incluir		} }

//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
//≥ Titulo e variavies para indicar o status do arquivo                 ≥
//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
PRIVATE cCadastro	:= "Browser De ManutenÁ„o dos Paramentros para pagamento gerenciado "

PRIVATE aCdCores	:= { 	{ 'BR_VERDE'    ,'Ativo    '  },;
							{ 'BR_AZUL'     ,'Concluido'  },; 
							{ 'BR_VERMELHO' ,'Cancelado'  },;							
							{ 'BR_AMARELO'  ,'Suspenso '  }}


PRIVATE aCores	:= {{'trim(PCQ_STATU) == "Ativo"'    , aCdCores[1,1]},;
					{'trim(PCQ_STATU) == "Concluido"', aCdCores[2,1]},;
					{'trim(PCQ_STATU) == "Cancelado"', aCdCores[3,1]},;
					{'trim(PCQ_STATU) == "Suspenso"' , aCdCores[4,1]}}   


PRIVATE cPath  := ""                        
PRIVATE cAlias := "PCQ" 

PRIVATE cPerg	:= "CABA125"

PRIVATE cNomeProg   := "CABA125"
PRIVATE nQtdLin     := 68
PRIVATE nLimite     := 132
PRIVATE cControle   := 15
PRIVATE cTamanho    := "G"
PRIVATE cTitulo     := "Parametros de Pagamento "
PRIVATE cDesc1      := ""
PRIVATE cDesc2      := ""
PRIVATE cDesc3      := ""
PRIVATE nRel        := "caba125"
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
PRIVATE cCabec1     := "Carga  dos Parametros de pagamento "
PRIVATE cCabec2     := ""
PRIVATE nColuna     := 00    
PRIVATE cPLLOTE     := " "       
Private dDtatu      := dtos(dDataBase - 10)

private cAliasSeq1 := GetNextAlias()        
private cAliasSeq2 := GetNextAlias()       
private cAliasSeq3 := GetNextAlias()        
private cAliasSeq4 := GetNextAlias()     

private cAliasSeq5 := GetNextAlias()  

private cAliasSeq6 := GetNextAlias()   

private datatu     := dtos(dDataBase)


Private cCAnPrio   := 'Sim'
Private cCAPrior   := 'Sim'
Private cCompEmi   := Space(6)
Private cDescItPg  := Space(30)
Private cHoraLog   := Space(5)
Private cSeq       := Space(2)
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

//* Dados do banco, agencia e conta 
// p/ realizar a movimentaÁ„o banc·ria.


//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
//≥ Starta mBrowse...                                                   ≥
//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
dbselectarea("PCQ")
PCQ->(DBSetOrder(1))
PCQ->(mBrowse(006,001,022,075,"PCQ" , , , , , Nil    , aCores, , , ,nil, .T.))
PCQ->(DbClearFilter())

Return

/*/
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±⁄ƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒø±±±
±±≥Funcao    ≥ CBIMPLEG   ≥ Autor ≥ Jean Schulz         ≥ Data ≥ 06.09.06 ≥±±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒ¥±±±
±±≥Descricao ≥ Exibe a legenda...                                         ≥±±±
±±¿ƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ±±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
/*/
user Function LEPRO1()
Local aLegenda

	aLegenda 	:= { 	{ aCdCores[1,1],aCdCores[1,2] },;
						{ aCdCores[2,1],aCdCores[2,2] },;
						{ aCdCores[3,1],aCdCores[3,2] },;
	              		{ aCdCores[4,1],aCdCores[4,2] } }
	                     	
BrwLegenda(cCadastro,"Status" ,aLegenda)

Return                 

User Function CARGA125()

Local lRetTit	:= .F. 
Local lsegue	:= .F.
Local cQryTit	:= ""         
Local cQryTit1	:= ""        
local cComPgta  := ' ' 
local nSeq      := 0
local i 

local cComptO   := mv_par01    // competencia de origem para copia 
local cSeq      := mv_par02    // sequencia de origem para copia
local cComptD   := mv_par03    // competencia de destino  
local cVlrRec   := mv_par04    // Valor da receita para distribuiÁ„o 
local nNovCam   := mv_par05    // Carrega Nova Competencia
local nCarVlr   := mv_par06    // copia percentuais 
local cClsGrp   := mv_par07    // se 1 gera por classe se 2 gera por grupo 

AjustaSX1()

Pergunte(cPerg,.T.)       

 cComptO   := mv_par01
 cSeq      := mv_par02  
 cComptD   := mv_par03 
 cVlrRec   := mv_par04
 nNovCam   := mv_par05 
 nCarVlr   := mv_par06
 nClsGrp   := mv_par07    
 
ProcRegua(0) 

nCont := 0

for i:=1 to 5    

    IncProc('Buscando Dados no Servidor ...') 
    
next           

    cQryCCmp := CRLF +"  SELECT NVL(PCQ_CPTPGT, '"+cComptD+"') CPTPGT , "
    cQryCCmp += CRLF +"         NVL(PCQ_GRPPAG , BAU1.GRPPAG ) GRPPAG , "
    If  nClsGrp == 1
        cQryCCmp += CRLF +"         NVL(PCQ_CLSRED , BAU1.CLSREDAU ) CLSREDAU , " 
        cQryCCmp += CRLF +"         NVL(BAU1.CLSREDE2, ' ' ) CLSREDE2 , "
    Else
        cQryCCmp += CRLF +"         ' '  CLSREDAU  , "    
        cQryCCmp += CRLF +"         ' '  CLSREDE2  , "    
    EndIf     
    cQryCCmp += CRLF +"         NVL(PCQ_SEQ, 1 ) SEQ , "
    cQryCCmp += CRLF +"         NVL(PCQ_DESCP,  BAU1.GRPPAG||' - '|| BAU1.DESCRI ) DESCRI , "

    If  nClsGrp == 1    
        cQryCCmp += CRLF +"         NVL(((( PCQ_VLRLI * 100)/PCQ_VLREC ) * "+str(cVlrRec)+"/100), 0.00 )  NVlLi , "
        cQryCCmp += CRLF +"         NVL(PCQ_VLRLI  , 0.00 ) VLRLI , "
        cQryCCmp += CRLF +"         NVL(PCQ_PERCU  , 0.00 ) PERCU , "
    Else                                                            
        cQryCCmp += CRLF +"         SUM(NVL(((( PCQ_VLRLI * 100)/PCQ_VLREC ) * "+str(cVlrRec)+"/100), 0.00 ))  NVlLi , "
        cQryCCmp += CRLF +"         SUM(NVL(PCQ_VLRLI  , 0.00 )) VLRLI , "
        cQryCCmp += CRLF +"         SUM(NVL(PCQ_PERCU  , 0.00 )) PERCU , "    
    EndIF                                                                
    
    cQryCCmp += CRLF +"         NVL(PCQ_STATU  , 'Suspenso') STATU , "
    cQryCCmp += CRLF +"         NVL(PCQ_VLREC  , 0.00 ) VLREC , "
    cQryCCmp += CRLF +"         NVL(PCQ_DIALIB , 01 ) DIALIB  "
    If  nClsGrp == 1 
        cQryCCmp += CRLF +"    ,    NVL(PCQ_DTCALE , ' '  ) DTCALE , "
        cQryCCmp += CRLF +"         NVL(PCQ_DTPGTO , ' '  ) DTPGTO   "
    EndIf                                        
    cQryCCmp += CRLF +"    FROM " +RetSqlName('PCQ')+ " PCQ , "
    cQryCCmp += CRLF +"         ( SELECT DISTINCT BAU_GRPPAG GRPPAG , B16_DESCRI DESCRI "
    
    If  nClsGrp == 1 
        cQryCCmp += CRLF +"        , nvl(E2_PREFIXO, ' ' ) CLSREDE2 , BAU_TIPPRE CLSREDAU " 
    EndIf
        
    cQryCCmp += CRLF +"            FROM " +RetSqlName('BAU')+ " BAU , " +RetSqlName('B16')+ "  B16 , " +RetSqlName('SE2')+ "  SE2"
    cQryCCmp += CRLF +"           WHERE BAU_FILIAL = '"+ xFilial('BAU') +"' AND BAU.D_E_L_E_T_ = ' ' "
    cQryCCmp += CRLF +"             AND B16_FILIAL = '"+ xFilial('B16') +"' AND B16.D_E_L_E_T_ = ' ' "
    
    cQryCCmp += CRLF +" AND e2_FILIAL(+) = '"+ xFilial('SE2') +"' AND se2.D_E_L_E_T_(+) = ' ' "
    cQryCCmp += CRLF +" AND bau_codigo = e2_codrda(+) "
    cQryCCmp += CRLF +" AND substr(e2_pllote(+),1,6)<= '201706' AND substr(e2_pllote(+),1,6) >= TO_CHAR(ADD_MONTHS(TO_DATE('201706' ,'YYYYMM'),-3 ),'YYYYMM') 
    cQryCCmp += CRLF +" AND e2_saldo(+) > 0  "
    cQryCCmp += CRLF +" AND e2_numbor(+) = ' '" 
    cQryCCmp += CRLF +" AND e2_tipo(+)= 'FT' "   
    cQryCCmp += CRLF +" AND (E2_DATALIB(+) = ' ' OR E2_DATALIB(+) < '"+dDtatu+"') " 
    cQryCCmp += CRLF +" AND E2_CTRPGT(+)   = ' '  AND E2_YLIBPLS(+) IN ('L','S') "
    
    
    cQryCCmp += CRLF +"             AND B16_CODIGO = BAU_GRPPAG "
    cQryCCmp += CRLF +"             AND B16_DESCRI NOT LIKE '%SEM PAGAM%' )BAU1 , "
    cQryCCmp += CRLF +"         ( SELECT NVL(MAX(PCQ_SEQ),0) NSEQ "
    cQryCCmp += CRLF +" 	        FROM " +RetSqlName('PCQ')+ " PCQ1 " 
    cQryCCmp += CRLF +"            WHERE PCQ_FILIAL = '  ' AND PCQ1.D_E_L_E_T_ = ' ' "
    cQryCCmp += CRLF +"              AND PCQ_CPTPGT = '"+cComptO+"' ) RSEQ "              
    
    cQryCCmp += CRLF +"   WHERE PCQ_FILIAL(+) = '  ' AND PCQ.D_E_L_E_T_(+) = ' ' "
    cQryCCmp += CRLF +"     AND PCQ_CPTPGT(+) = '"+cComptO+"' " 
    cQryCCmp += CRLF +"     AND PCQ_GRPPAG(+) = BAU1.GRPPAG   "   
If  nClsGrp == 1      
    cQryCCmp += CRLF +"     AND PCQ_CLSRED(+) = BAU1.CLSREDE2 "      
    cQryCCmp += CRLF +"     AND PCQ_CLSRED(+) = BAU1.CLSREDAU "     
EndIf     
    If Empty(cSeq) .and. nCarVlr == 1
       cQryCCmp += CRLF +"     AND PCQ_SEQ = RSEQ.NSEQ     "                          
    ElseIf nCarVlr == 1
           cQryCCmp += CRLF +"     AND PCQ_SEQ = '"+cSeq+"' "                         
    EndIf        
  If  nClsGrp == 2    
      cQryCCmp += CRLF +"   GROUP BY NVL(PCQ_CPTPGT , '"+cComptD+"'), " 
      cQryCCmp += CRLF +"            NVL(PCQ_GRPPAG , BAU1.GRPPAG ), "    
       
      cQryCCmp += CRLF +"            ' '  , "    
       
      cQryCCmp += CRLF +"   		 NVL(PCQ_SEQ, 1 ) , "
      cQryCCmp += CRLF +"   		 NVL(PCQ_DESCP  , BAU1.GRPPAG||' - '|| BAU1.DESCRI ) , " 
      cQryCCmp += CRLF +"   		 NVL(PCQ_STATU  , 'Suspenso') , "
      cQryCCmp += CRLF +"   		 NVL(PCQ_VLREC  , 0.00 ) , "
      cQryCCmp += CRLF +"   		 NVL(PCQ_DIALIB , 01 ) "
  EndIf
    cQryCCmp += CRLF +" ORDER BY  NVL(PCQ_CPTPGT, '"+cComptD+"' ) , NVL(PCQ_GRPPAG , BAU1.GRPPAG )

    If Select((cAliasSeq1)) <> 0 
      
       (cAliasSeq1)->(DbCloseArea()) 
 
    Endif           
              
    TcQuery cQryCCmp New Alias (cAliasSeq1)  
         
// EndIf   // aki hoje 1/06/2017

If nNovCam == 1 .and. !empty(trim(cComptD))

   nseqc := fpegseq(cComptD)       

Else  
                            
   nseqc := fpegseq(cComptO)       

EndIf                     

If nNovCam == 1 .and. !empty(trim(cComptD))  

   cPLLOTE :=cComptD

   lsegue  := fConflanc(cComptD)
  
Else
                          
   cPLLOTE :=cComptO               

   lsegue:= fConflanc(cComptO)

EndIF
 
  dBSelectArea("PCQ")  
 
If !(lsegue)
   
    If ApMsgYesNo("Existe lancamento Ativo ou Suspenso para a Competencia : "+ cPLLOTE +" !!!"+CRLF +"Deseja Altera o(s) Status  para Cancelado ?") 
     
       fConcanc(cComptD)
       
       lsegue:= .T.    
       
    EndIf
   
    lRetTit:=.T.
    
EndIf       

If lsegue 
   If  !empty(trim(cComptD))  
     For x:= 1 to 2      
         
         dbgotop(cAliasSeq1)                                         
         While !(cAliasSeq1)->(EOF()) //.OR. !cAliasSeq2->(EOF())
          if 	lRetTit == .F.
             	lRetTit:=.T.                 
             	
	      EndIf    

	      lsegAue2  := .T.  

	      If  nClsGrp == 1   
   	          If x == 1  
   	             lsegAue2:= ((fCnflncPC( cComptD , (cAliasSeq1)->grppag ,  (cAliasSeq1)->clsredAu  )) .AND. (TRIM((cAliasSeq1)->clsredAU) != ' ' ) )
   	          Else                                                                                                     
    	         lsegAue2:= ((fCnflncPC( cComptD , (cAliasSeq1)->grppag ,  (cAliasSeq1)->clsredE2  )) .AND. (TRIM((cAliasSeq1)->clsredE2) != ' ' ) )
   	          EndIf
   	      Else         
   	       If x == 2        
   	          lsegAue2  := .F.
   	          x == 3  
   	       EndIf    
   	      EndIf    
          If lsegAue2      	       
                RecLock( "PCQ" , .T. )         
      	 
	            PCQ->PCQ_CPTPGT := cComptD 
                PCQ->PCQ_GRPPAG := (cAliasSeq1)->grppag                   
                If  nClsGrp == 1   
                    if x == 1
     	               PCQ->PCQ_CLSRED := (cAliasSeq1)->clsredau      
     	            else 
     	               PCQ->PCQ_CLSRED := (cAliasSeq1)->clsrede2
     	            EndIf           
                Else 	                                          
                    PCQ->PCQ_CLSRED := ' '     
                EndIf                     
      
  	            PCQ->PCQ_SEQ    := nseqc   
     	        PCQ->PCQ_DESCP  := (cAliasSeq1)->descri  
  	           If nCarVlr == 1
                  PCQ->PCQ_VLRLI  := (cAliasSeq1)->NVlLi     
                  PCQ->PCQ_PERCU  := (cAliasSeq1)->PERCU 
               Else 
                  PCQ->PCQ_VLRLI  := 0.00     
                  PCQ->PCQ_PERCU  := 0.00          
               EndIf    
               PCQ->PCQ_STATU  := 'Suspenso'  
               PCQ->PCQ_VLREC  := cVlrRec   
               PCQ->PCQ_DIALIB := 01   
               PCQ->PCQ_DTCALE := stod('  /  /  ') 
               PCQ->PCQ_DTPGTO := stod('  /  /  ')      
      	                                   
         	  PCQ->(MSUNLOCK())      
 
         EndIf               
     	(cAliasSeq1)->(DbSkip())
                                                                                       
     EndDo 
       
     Next 
   EndIf 
Else 

      Alert("A Competencia Destino deve ser Preenchida para a Competencia : "+ cPLLOTE +" !!!" )          
        
EndIf   
            

(cAliasSeq1)->(DbCloseArea())

   
If !(lRetTit) 

    MsgAlert("Nao ‡ Dados para esta consulta "  + CRLF + " Revise seus parametros !!! ","Atencao!")
    lsai := .T.    
    
EndIf        

RETURN() 

//////////////////// 
static Function fConflanc ( PLLOTE )   

Local lret	    := .F.     
local lSegue    := .F.
Local cQrySeq	:= ""

cQrySeq := " SELECT COUNT(*) qtda               "  + CRLF
cQrySeq += "   FROM " +RetSqlName('PCQ')+ " PCQ "  + CRLF
cQrySeq += "  WHERE PCQ_FILIAL ='"+ xFilial('PCQ') +"' AND D_E_L_E_T_ = ' ' " + CRLF
cQrySeq += "    AND PCQ_CPTPGT  = '"+PLLOTE+"'"     + CRLF    
cQrySeq += "    AND PCQ.PCQ_STATU IN('Suspenso','Ativo')"  + CRLF  
   
If Select((cAliasSeq3)) <> 0 

   (cAliasSeq3)->(DbCloseArea()) 

Endif           
                        
TcQuery cQrySeq New Alias (cAliasSeq3)

If (cAliasSeq3)->qtda == 0 

   lSegue:= .T.  
   
Else 
  lSegue:= .F. 
endIF  

return( lSegue )
/////////////////////////////////////////////////////////
static Function   fCnflncPC ( PLLOTE , Cgrppag , cClsRed) 

Local lret	    := .F.     
local lSegue    := .F.
Local cQrySeq	:= ""

cQrySeq := " SELECT COUNT(*) qtda               "  + CRLF
cQrySeq += "   FROM " +RetSqlName('PCQ')+ " PCQ "  + CRLF
cQrySeq += "  WHERE PCQ_FILIAL ='"+ xFilial('PCQ') +"' AND D_E_L_E_T_ = ' ' " + CRLF
cQrySeq += "    AND PCQ_CPTPGT  = '"+PLLOTE+"'"     + CRLF     

cQrySeq += "    AND PCQ_GRPPAG = '"+Cgrppag+"'"     + CRLF  

cQrySeq += "    AND PCQ_CLSRED = '"+cClsRed+"'"     + CRLF 

cQrySeq += "    AND PCQ.PCQ_STATU IN('Suspenso','Ativo')"  + CRLF  
   
If Select((cAliasSeq6)) <> 0 

   (cAliasSeq6)->(DbCloseArea()) 

Endif           
                        
TcQuery cQrySeq New Alias (cAliasSeq6)

If (cAliasSeq6)->qtda == 0 

   lSegue:= .T.  
   
Else
 
   lSegue:= .F. 

endIF  

return( lSegue )



////////////////////////////////////////////////////////

static Function fpegseq( PLLOTE )   

Local nSeq	    := 0
Local cQrySeq	:= ""                          
                                       

cQrySeq := " SELECT NVL(MAX(PCQ_SEQ), 0) SEQ "     + CRLF
cQrySeq += "   FROM " +RetSqlName('PCQ')+ " PCQ "  + CRLF
cQrySeq += "  WHERE PCQ_FILIAL ='"+ xFilial('PCQ') +"' AND D_E_L_E_T_ = ' ' " + CRLF
cQrySeq += "    AND PCQ_CPTPGT = '"+PLLOTE+"'"     + CRLF
//cQrySeq += "    AND PCQ_TIPO   = '"+TIPO+"'"       + CRLF       

                        
If Select((cAliasSeq4)) <> 0 

   (cAliasSeq4)->(DbCloseArea()) 

Endif           

TcQuery cQrySeq New Alias (cAliasSeq4)

If Select((cAliasSeq4)) <> 0       
   nSeq	    := ((cAliasSeq4)->seq + 1)
else 
   nSeq	    :=  1
EndIf    

return(nseq)

//////////////////// 
//converte de ativo / suspenso para cancelado / concliudo
static Function fConcanc( PLLOTE )   

Local lret	    := .F.     
local lSegue    := .F.
Local cQrySeq	:= ""

cQrySeq := " SELECT PCQ_CPTPGT CPTPGT, PCQ_CLSRED CLSRED , PCQ_GRPPAG GRPPAG ,PCQ_SEQ SEQ , R_E_C_N_O_ recpcq "  + CRLF
cQrySeq += "   FROM " +RetSqlName('PCQ')+ " PCQ "  + CRLF
cQrySeq += "  WHERE PCQ_FILIAL ='"+ xFilial('PCQ') +"' AND D_E_L_E_T_ = ' ' " + CRLF
cQrySeq += "    AND PCQ_CPTPGT  = '"+PLLOTE+"'"    + CRLF    
cQrySeq += "    AND PCQ.PCQ_STATU IN('Suspenso','Ativo')"  + CRLF  
   
If Select((cAliasSeq3)) <> 0 

   (cAliasSeq3)->(DbCloseArea()) 

Endif           
                         
TcQuery cQrySeq New Alias (cAliasSeq3)
      
 While !(cAliasSeq3)->(EOF())         
 
        cQuery := " UPDATE " +RetSqlName('PCQ') + " "
		cQuery += " SET PCQ_STATU  = 'Cancelado' "
        cQuery += " WHERE R_E_C_N_O_ = "+str((cAliasSeq3)->recpcq)
		
		nSucesso := TcSqlExec(cQuery)
 
     	(cAliasSeq3)->(DbSkip())
      
EndDo   
            
cQrypci := " SELECT R_E_C_N_O_ recpci "  + CRLF
cQrypci += "   FROM " +RetSqlName('PCI')+ " PCI "  + CRLF
cQrypci += "  WHERE PCI_FILIAL ='"+ xFilial('PCI') +"' AND D_E_L_E_T_ = ' ' " + CRLF
cQrypci += "    AND PCI_CPTPGT  = '"+PLLOTE+"'"    + CRLF    
cQrypci += "    AND PCI.PCI_STATUS IN('Suspenso','Ativo')"  + CRLF  
   
If Select((cAliasSeq5)) <> 0 

   (cAliasSeq5)->(DbCloseArea()) 

Endif           
                         
TcQuery cQrypci New Alias (cAliasSeq5)
 
If !(cAliasSeq5)->(EOF()) 
   If ApMsgYesNo("Existe ProgramaÁıes  Ativas ou Suspensas para a Competencia : "+ cPLLOTE +" !!!"+CRLF +"Deseja Altera o(s) Status  para Cancelado ?") 
   
      (cAliasSeq5)->(dbgotop())

      While !(cAliasSeq5)->(EOF())         
 
        cQuery := " UPDATE " +RetSqlName('PCI') + " "
		cQuery += " SET PCI_STATUS  = 'Cancelado' "
        cQuery += " WHERE R_E_C_N_O_ = "+str((cAliasSeq5)->recpci)
		
		nSucesso := TcSqlExec(cQuery)
 
     	(cAliasSeq5)->(DbSkip())
      
      EndDo               
		
   EndIf	               

EndIf

return(  )
                    
 

 /////////////////////                 

Static Function AjustaSX1()

Local aHelp 	:= {}
                                       
	If Select((cAliasSeq1)) <> 0 
       (cAliasSeq1)->(DbCloseArea())         
    EndIf 
                                 
	If Select((cAliasSeq2)) <> 0 
       (cAliasSeq2)->(DbCloseArea())         
    EndIf         
                                 
	If Select((cAliasSeq3)) <> 0 
       (cAliasSeq3)->(DbCloseArea())         
    EndIf         
                                 
	If Select((cAliasSeq4)) <> 0 
       (cAliasSeq4)->(DbCloseArea())         
    EndIf         
                                 
	If Select((cAliasSeq5)) <> 0 
       (cAliasSeq5)->(DbCloseArea())         
    EndIf 

/*aHelp := {}
aAdd(aHelp, "Informe Competecia base / Anomes emissao titulos   ")
PutSX1(cPerg , "01" , "Competencia pagamento " 	,"","","mv_ch1","C",6,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)
*/

aHelp := {}  
aAdd(aHelp, "Informe Competecia custo Origem / Anomes emissao titulos   ")
PutSX1(cPerg , "01" , "Compet. Origem " 	,"","","mv_ch1","C",6,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aAdd(aHelp, "Seguencia gerada quando mais de uma paramentrizaÁ„o por custo ")
PutSX1(cPerg , "02" , "Sequencia Origem " ,"","","mv_ch2","C",2,0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)       

aAdd(aHelp, "Informe Competecia custo destino  / Anomes emissao titulos   ")
PutSX1(cPerg , "03" , "Compet. Destino " 	,"","","mv_ch3","C",6,0,0,"G","","","","","mv_par03","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aAdd(aHelp, "Informe o Valor Da Receita ")
PutSX1(cPerg , "04" , "Valor Da Receita " 	,"","","mv_ch4","N",14,0,0,"G","","","","","mv_par04","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aAdd(aHelp, "Carrega Nova Competencia - SIM ou  N√O  ")
PutSX1(cPerg , "05", "Nova Competencia   ","","","mv_ch5","N",1,0,1,"C","","","","","mv_par05","Sim "	,"","","","N„o ","",""," ","","","","","","","","",aHelp,aHelp,aHelp) 

aAdd(aHelp, "Copia Valores - SIM - N√O  ")
PutSX1(cPerg , "06", "Copia Valores   ","","","mv_ch6","N",1,0,1,"C","","","","","mv_par06","Sim "	,"","","","N„o ","",""," ","","","","","","","","",aHelp,aHelp,aHelp)

aAdd(aHelp, "Trata ao nivel de Classe de Rede - SIM Inclui classe de rede se N√O inclui Grupo de pagamento e classe de rede igual a GRP com os valores totais das redes no grupo  ")
PutSX1(cPerg , "07", "Incluir Classe Rede ","","","mv_ch7","N",1,0,1,"C","","","","","mv_par07","Sim "	,"","","","N„o ","",""," ","","","","","","","","",aHelp,aHelp,aHelp) 

/*
aAdd(aHelp, "Informe Competecia origem  / Anomes emissao titulos   ")
PutSX1(cPerg , "05" , "Competencia Origem " ,"","","mv_ch5","C",6,0,0,"G","","","","","mv_par05","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)       

aAdd(aHelp, "Trata ao nivel de Classe  - SIM Inclui classe de rede se N√O inclui classe de rede GRP para todas as redes ")
PutSX1(cPerg , "06", "Incluir Classe Rede ","","","mv_ch6","N",1,0,1,"C","","","","","mv_par06","Sim "	,"","","","N„o ","",""," ","","","","","","","","",aHelp,aHelp,aHelp) 

aAdd(aHelp, "Data do Bordero  , Data da CriaÁ„o do Bordero ")
PutSX1(cPerg , "03" , "Dt Bordero "     ,"","","mv_ch3","D",8,0,0,"G","","","","","mv_par03"," ","","",""," ","",""," ","","","","","","","","",aHelp,aHelp,aHelp)
 
aAdd(aHelp, "Nova Data de Vencimento , Data para prorogaÁ„o do vencimento do titulo selecionado  ")
PutSX1(cPerg , "04" , "Nova Dt de Venc ","","","mv_ch4","D",8,0,0,"G","","","","","mv_par04"," ","","",""," ","",""," ","","","","","","","","",aHelp,aHelp,aHelp)


aAdd(aHelp, "Origem dos Titulos, Contas Medicas ou OPME ")
PutSX1(cPerg,"05", "Origem  ","","","mv_ch5","N",1,0,1,"C","","","","","mv_par05","Contas Medica"	,"","","","OPME ","","","Todos","","","","","","","","",aHelp,aHelp,aHelp)


aAdd(aHelp, "Data de Vencimento  inicial ")
PutSX1(cPerg,"06", "Dt Vencimento  De ?","","","mv_ch6","D",8,0,0,"G","","","","","mv_par06"," ","","",""," ","",""," ","","","","","","","","",aHelp,aHelp,aHelp)

aAdd(aHelp, "Data de Vencimento Final  ")
PutSX1(cPerg,"07", "Dt vencimento  Ate ?","","","mv_ch7","D",8,0,0,"G","","","","","mv_par07"," ","","",""," ","",""," ","","","","","","","","",aHelp,aHelp,aHelp)

aAdd(aHelp, "Cod Fornecedor  inicial ")
PutSX1(cPerg,"08", "Cod Fornecedor  De ?","","","mv_ch8","C",6,0,0,"G","","","","","mv_par08"," ","","",""," ","",""," ","","","","","","","","",aHelp,aHelp,aHelp)

aAdd(aHelp, "Cod Fornecedor Final  ")
PutSX1(cPerg,"09", "Cod Fornecedor  Ate ?","","","mv_ch9","C",6,0,0,"G","","","","","mv_par09"," ","","",""," ","",""," ","","","","","","","","",aHelp,aHelp,aHelp)
 */
 /*

aAdd(aHelp, "Opcao Procedimento")
PutSX1(cPerg,"04", "Valor Maximo ","","","mv_ch4","N",13,2,1,"G","","","","","mv_par04",""	,"","","","","","",""	,"","","","","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Operado , 001250 - Milena ")
aAdd(aHelp, "          001240 - Dr. Douglas")
aAdd(aHelp, "          000271 - Dra. Carla")
aAdd(aHelp, "          000029 - Dr. J.Macedo")
PutSX1(cPerg , "05" , "Operado " 	,"","","mv_ch5","C",6,0,0,"G",""	,"","","","mv_par05","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aAdd(aHelp, "Ordernar Por Rda , Grupo de Pagto ")
PutSX1(cPerg,"06", "Listar  ","","","mv_ch6","N",1,0,1,"C","","","","","mv_par06","Pagto <= Previa ","","","","Pagto > Previa ","","","+ 1 Competencia","","","Todos","","","Maiores Ofensores","","",aHelp,aHelp,aHelp)

aAdd(aHelp, "Considere so a Competencia De Entrada  para liberar ")
PutSX1(cPerg,"07", "Cons. sÛ Competencia de Entrada","","","mv_ch7","N",1,0,1,"C","","","","","mv_par07","Sim "	,"","","","N„o ","",""," ","","","","","","","","",aHelp,aHelp,aHelp)

aAdd(aHelp, "Data de Procedimento Inicial , limite inferior da Data de procedimento ")
PutSX1(cPerg,"08", "Dt procedimento De ?","","","mv_ch8","D",8,0,0,"G","","","","","mv_par08"," ","","",""," ","",""," ","","","","","","","","",aHelp,aHelp,aHelp)

aAdd(aHelp, "Data de Procedimento Final , limite sUPERIOR da Data de procedimento ")
PutSX1(cPerg,"09", "Dt procedimento Ate ?","","","mv_ch9","D",8,0,0,"G","","","","","mv_par09"," ","","",""," ","",""," ","","","","","","","","",aHelp,aHelp,aHelp)

aAdd(aHelp, "Listar sem recuso de glosa , sÛ recurso de glosa ou n„o considera ")
PutSx1(cPerg,"10",OemToAnsi("Com Recurso de Glosa ")         ,"","","mv_ch10","N",01,0,0,"C","","","","","mv_par10","Sem Rec.de glosa","","","","SÛ Rec. de glosa","","","Todas","","","","","","","","",{},{},{})  

aAdd(aHelp, "Liberar Pagto quando sim mostrar so que tem valor a liberar , quando n„o lista todos dos itens do custo  ")
PutSx1(cPerg,"11",OemToAnsi("AÁ„o  ")         ,"","","mv_ch11","N",01,0,0,"C","","","","","mv_par11","Lib. Pgto ","","","","Auditoria","","","","","","","","","","","",{},{},{})  

aAdd(aHelp, "Listar So Projeto , Sem Projeto , N„o Considera  ")
PutSx1(cPerg,"12",OemToAnsi("Listar Projeto ? ")         ,"","","mv_ch12","N",01,0,0,"C","","","","","mv_par12","SÛ Projeto ","","","","Sem Projeto ","","","Todas","","","","","","","","",{},{},{})  

aAdd(aHelp, "Informe Grupo de Pagamento , Em branco lista todos ")
PutSX1(cPerg,"13", "Grupo de Pagamento , P/Todos N„o Informar ","","","mv_ch13","C",4,0,1,"G","","","","","mv_par13"," ","","",""," ","",""," ","","","","","","","","",aHelp,aHelp,aHelp)
*/
Return

//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
//≥ tranmiste email                                                     ≥
//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
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

_cMensagem +=  Chr(13) + Chr(10) + Chr(13) + Chr(10) + "Existe(m) Pagamento(s) de Rda('s) aguardando LiberaÁ„o(oes) por AlÁada "
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
Local _cAssunto    := " AlteraÁ„o de Vencimento  "
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
