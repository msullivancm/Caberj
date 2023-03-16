#Define CRLF Chr(13)+Chr(10)
#INCLUDE "PROTHEUS.ch"                                                                                                                                  
#INCLUDE "TOPCONN.ch"
#INCLUDE "PLSMGER.CH"                                                                                   
#Include "Ap5Mail.Ch"      
#Include 'Tbiconn.ch'                                                                                                        
/*--------------------------------------------------------------------------
| Programa  | CABA177  | Autor | Altamiro	Affonso    | Data | 19/06/2020  |
|---------------------------------------------------------------------------|              
| Descricao | Lançamento na Folha de Pagamento da comissao equipe interna   |
|           |                                                               |                                                       
|---------------------------------------------------------------------------|
| Uso       | Lançamento na Folha de Pagamento da comissao equipe interna   |                                   
 --------------------------------------------------------------------------*/

User Function CABA177()
                                                 
local cRda      := ' ' 
local cNivel    := ' '
local nI := 0          

Private _cUsuario:= SubStr(cUSUARIO,7,15)        
private cDthr   := (dtos(DATE()) + "-" + Time())       
 
private aTitRecPag	:= {}
private adadosTit   := {}   
private aDadSE1     := {}


Private aBrwPEG 
private aRetPEG	:= {}    

Private aCabPEG	:= { " ","Cod Emp" , "Prefixo" , "Numero   " , "Tipo" , "Cod Fornec",'Nome Forncedor', "Emissão" , "Vencimento" , "Baixa " , "Valor Pgto" , "Saldo Pgto"  , "Cod Vend " , "Compte " , "Vlr Base " , "Vlr Comis." , "Cod Equipe" , "Qtd Fat.", "1 Fat", "Ult Fat" , '%', 'Nome Emp', 'NumFat', 'NumPar'}
Private aTamPEG	:= { 10 , 30       , 30        ,30           , 20     , 30          , 100            , 25        , 35           , 35       , 30           ,30             , 20          ,  25       , 30          ,  30          , 20           ,  10        , 25    , 25        , 10 , 100       ,  10     ,    10   }

//private aBrwPEG
//Private aCabPEG		:= {" ", "Compt. Entrada","Operadora de  Origem  ","Vlr Fase 3","Vlr Fase 31/2","Vlr Fase 4","Vlr Inss","Vlr Tx Adm", "Total Guias","Faturado","Qtda Guias"}
//Private aTamPEG		:= {10,30,120,45,45,45,45,45,45,45,25}  


Private oOk      	:= LoadBitMap(GetResources(),"LBOK")
Private oNo      	:= LoadBitMap(GetResources(),"LBNO")

Private oVerde   	:= LoadBitMap(GetResources(),"ENABLE")
Private oVermelho	:= LoadBitMap(GetResources(),"DISABLE")  

Private aObjects 	:= {}

Private aSizeAut 	:= MsAdvSize() 

Private cPerg	    := "CABA180"     
 
private cFecConv    := 1       
private cFezConc    := 2


private cLOTCOB     := ' '   
private cFZCRIT     := ' '   
private cCVLTOT     := ' '   
private cCVLBAS     := ' '   
private cCVLTAD     := ' '   
private cCVLFS3     := ' '   
private cCVLAN3     := ' '   
private cCVLFAT     := ' ' 
private cCVLBLF     := ' ' 
private cFAZCON     := ' ' 

Private dVencInc                      
Private dVencFim                     
Private cTipotit                     
Private cTipbaixa     

private cCompInc := ' '                     
private cCompFim := ' '

private cmv_par09:= ' '   

private nfase3    := 0                   
private nfase312  := 0                  
private nfase4    := 0   

private Idx       := 0        

private cClsRd   := ' ' 

private dDtvenc  := ' '  

Private cDscori  := ' ' 

Private cMesBase     := ' '  
Private cAnoBase     := ' ' 
Private cNumTitI     := ' '  
Private cNumTitF     := ' '     
Private cOpeInc      := ' ' 
Private cOpeFim      := ' '        
Private aTit         := {}                     

private cAliasCf  := GetNextAlias()   
private cAliasDem := GetNextAlias()   
private cAliasCT  := GetNextAlias()    
private cAliasEX  := GetNextAlias()   
Private cAliasEqp   := GetNextAlias()
//AjustaSX1()

//Pergunte(cPerg,.T.)        

//cCompInc := Mv_par01                     
//cCompFim := Mv_par02  
//cmv_par09:= Mv_par01

//Processa({||aBrwPEG := aDadosPEG()},'Processando...','Processando...',.T.)
 Processa({||aBrwPEG := aDadosPEG()},'Processando...','Buscando Dados No Servidor ...',.T.)

  
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³MsAdvSize()                          ³
//³-------------------------------------³
//³1 -> Linha inicial area trabalho.    ³
//³2 -> Coluna inicial area trabalho.   ³
//³3 -> Linha final area trabalho.      ³
//³4 -> Coluna final area trabalho.     ³
//³5 -> Coluna final dialog (janela).   ³
//³6 -> Linha final dialog (janela).    ³
//³7 -> Linha inicial dialog (janela).  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
          
lAjustHor	:= .T.
//lAjustVert 	:= .T.
lAjustVert 	:= .F.


aAdd( aObjects, { 120,  200, lAjustHor, lAjustVert } )
//aAdd( aObjects, { 130,  250, lAjustHor, lAjustVert } )
//aAdd( aObjects, { 130,  250, lAjustHor, lAjustVert } )

nSepHoriz   := 5     
nSepVert    := 5
nSepBorHor 	:= 5
nSepBorVert	:= 5

aInfo  		:= { aSizeAut[ 1 ], aSizeAut[ 2 ], aSizeAut[ 3 ], aSizeAut[ 4 ], nSepHoriz, nSepVert, nSepBorHor, nSepBorVert }
aPosObj 	:= MsObjSize( aInfo, aObjects, .T. )

//oDlg  		:= MsDialog():New( aSizeAut[7],00,aSizeAut[3]-100,aSizeAut[5]-10,"Repase Comissao Vendedor Interno Integral -> Caberj ",,,.F.,,,,,,.T.,,,.T. ) 
oDlg  		:= MsDialog():New( aSizeAut[7],00,aSizeAut[3] ,aSizeAut[5]-10,"Repase Comissao Vendedor Interno Integral -> Caberj ",,,.F.,,,,,,.T.,,,.T. ) 
oSayPEG    	:= TSay():New( aPosObj[1][1],aPosObj[1][2],{||'Repase Comissao Vendedor Interno Integral -> Caberj'},oDlg,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,236,016)

//bDbClickPEG	:= {|| aBrwPEG[oBrwPEG:nAt,1] := !aBrwPEG[oBrwPEG:nAt,1], oBrwPEG:Refresh()}   

bDbClickPEG	:= {|| aBrwPEG[oBrwPEG:nAt,1] := iif ((aBrwPEG[oBrwPEG:nAt,17] == ' ' .or. mv_par01 == '1') , aBrwPEG[oBrwPEG:nAt,1] ,!aBrwPEG[oBrwPEG:nAt,1]), oBrwPEG:Refresh()}   

//bChangePEG	:= {||AtuBrwGuia(aBrwPEG[oBrwPEG:nAt,2],aBrwPEG[oBrwPEG:nAt,3])}

//oBrwPEG 	:= TcBrowse():New(aPosObj[1][1]+10,aPosObj[1][2],aPosObj[1][4],aPosObj[1][3],,aCabPEG,aTamPEG,oDlg,,,,bChangePEG,bDbClickPEG,,,,,,,.F.,,.T.,,.F.,,, )

oBrwPEG 	:= TcBrowse():New(aPosObj[1][1]+10,aPosObj[1][2],aPosObj[1][4],aPosObj[1][3]+190,,aCabPEG,aTamPEG,oDlg,,,,,bDbClickPEG,,,,,,,.F.,,.T.,,.F.,,, )

oBrwPEG:SetArray(aBrwPEG) 

oBrwPEG:bLine := {||{If( aBrwPEG[oBrwPEG:nAt,  1],oOk,oNo) ,;
                         aBrwPEG[oBrwPEG:nAt,  2] ,;
                         aBrwPEG[oBrwPEG:nAt,  3] ,;                       
	  	    	         aBrwPEG[oBrwPEG:nAt,  4] ,;
		 	             aBrwPEG[oBrwPEG:nAt,  5] ,;
		 	             aBrwPEG[oBrwPEG:nAt,  6] ,; 
   		 	             aBrwPEG[oBrwPEG:nAt,  7] ,; 
                 alltrim(aBrwPEG[oBrwPEG:nAt,  8]),;
                 alltrim(aBrwPEG[oBrwPEG:nAt,  9]),;   
   		 	     alltrim(aBrwPEG[oBrwPEG:nAt, 10]),; 
			   Transform(aBrwPEG[oBrwPEG:nAt, 11] ,'@E  9999,999.99'),;
			   Transform(aBrwPEG[oBrwPEG:nAt, 12] ,'@E  9999,999.99'),;
		 	             aBrwPEG[oBrwPEG:nAt, 13] ,;
		 	             aBrwPEG[oBrwPEG:nAt, 14] ,; 
               Transform(aBrwPEG[oBrwPEG:nAt, 15] ,'@E  9999,999.99'),;
			   Transform(aBrwPEG[oBrwPEG:nAt, 16] ,'@E  9999,999.99'),;
			             aBrwPEG[oBrwPEG:nAt, 17] ,; 
   		 	             aBrwPEG[oBrwPEG:nAt, 18] ,;
			   	  	     aBrwPEG[oBrwPEG:nAt, 19] ,; 
   		 	             aBrwPEG[oBrwPEG:nAt, 20] ,;
				 		 aBrwPEG[oBrwPEG:nAt, 21] ,;
						 aBrwPEG[oBrwPEG:nAt, 22] ,;
						 aBrwPEG[oBrwPEG:nAt, 23] ,;
						 aBrwPEG[oBrwPEG:nAt, 24]}}             
						             

oBrwPEG:nScrollType  := 1 // Scroll VCR

lConfirmou 	:= .T.

aBut    :={{"PENDENTE", {||marca(1),oBrwPEG:Refresh()             }	, "Marcar Todos "       , "Marcar Todos"      }}
aAdd(aBut, {"PENDENTE", {||desmarca(1),oBrwPEG:Refresh()          }	, "DesMarcar Todos "	, "DesMarcar Todos"	  })  
aAdd(aBut, {"PENDENTE", {||fFazpgto(),oBrwPEG:Refresh(),oDlg:End()}  , "Demonst. Calculos " , "Demonst. Calculos" })  
aAdd(aBut, {"PENDENTE", {||fFazpgto(),oBrwPEG:Refresh(),oDlg:End()}  , "Gera Pgto Folha "   , "Gera Pgto Folha"   })  

lConfirmou := .F.

//bOk 	:= {||fSequen() , oBrwPEG:Refresh() , oBrwPEG:Refresh() ,oDlg:End()   }    
 
bOk 	:= {|| MsgAlert("Favor Escolher uma opção em 'Ações Relacionadas'")  ,oBrwPEG:Refresh() }    
 
bCancel := {||lConfirmou := .F.,oDlg:End()}

	
oDlg:Activate(,,,.T.,,,EnchoiceBar(oDlg,bOk,bCancel,,aBut))


Return    

************************************************************************************

Static Function aDadosPEG

Local cQryPEG	:= ""
Local cQryCE	:= ""
Local cAliasPEG	:= GetNextAlias()
Local cAliasCE	:= GetNextAlias()
local i


cQryCE :=  CRLF+ " SELECT PDY_CODEMP ,COUNT (*) FROM PDY010 WHERE PDY_FILIAL = ' ' AND D_e_l_e_t_ = ' ' HAVING COUNT (*) > 1 GROUP BY PDY_CODEMP "

TcQuery cQryCE New Alias (cAliasCE)

(cAliasCE)->(dbGoTop())

    iF  !(cAliasCE)->(EOF())

        MsgALERT("A T E N Ç Ã O "+CRLF+CRLF+CRLF+"Existe Empresa(s) vinculadas a Mais de Uma Equipe de Venda Interna,"+CRLF+" Uma Empresa só Pode esta Vinculada a Uma Equipe de Venda Interna !!!"+CRLF+ "Faça o Correção para Continuar.")
	    
		aAdd(aRetPEG,{.F.,'','','','','','','','','',0 , 0 ,'','', 0 , 0 , ' ' , ' ',' ',' ',' ' , ' ', ' ' })
		Return
   
    EndIf 

ProcRegua(0) 

nCont := 0

for i:=1 to 5
    IncProc('Buscando Dados no Servidor ...')
next             

//////////////////////////////////altamiro 20/06/2021 - nova versao do sql
cQryPEG :="            Select distinct Prefse2 , NumSe2 , TipoSe2 , ForneceSe2 , NomForSe2 , EmissaoSe2 , VencSe2 , BaixaSe2 , ValorSe2 , SaldoSe2 , "
cQryPEG += CRLF + "           CodEmpBxq  , E2PrefBxq , E2NumBXq , E2TipoBxq  , E2FornBxq , CodVenBxq  , CompteBxq , " 
cQryPEG += CRLF + "           BaseComBxq , VlrComBxq , "
cQryPEG += CRLF + "           NomEmpBxq  , NumParBxq , "
cQryPEG += CRLF + "           nvl(CODEQPPDY,'Sem Equipe') CODEQPPDY , CODEMPPDY  CODEMPPDY , Nvl(comptepdy, ' ') comptepdy , "
cQryPEG += CRLF + "          ((trunc(months_between(TO_DATE(TRIM(dtmax),'YYYYMMDD') , TO_DATE(TRIM(dtmin),'YYYYMMDD')))+1) - "
cQryPEG += CRLF + "           (trunc(months_between(TO_DATE(TRIM(dtmax),'YYYYMMDD') , TO_DATE(TRIM(CompteBxq||'01'),'YYYYMMDD')))+1)+1) NumFat , "
cQryPEG += CRLF + "           (trunc(months_between(TO_DATE(TRIM(dtmax),'YYYYMMDD') , TO_DATE(TRIM(dtmin),'YYYYMMDD')))+1) QtdaFat , " 
cQryPEG += CRLF + "           trim(substr(dtmin,1,6)) CptPFat , trim(substr(dtmax,1,6)) CptUFat ,  Percom Percom "
cQryPEG += CRLF + "      From (Select E2_Prefixo Prefse2 , E2_Num NumSe2 , E2_Tipo TipoSe2 , E2_Fornece ForneceSe2 ,E2_NomFor NomForSe2 , "
cQryPEG += CRLF + "                   (substr(E2_Emissao,7,2)||'/'||substr(E2_Emissao,5,2)||'/'||substr(E2_Emissao,1,4)) EmissaoSe2 , "
cQryPEG += CRLF + "                   (substr(E2_Vencrea,7,2)||'/'||substr(E2_Vencrea,5,2)||'/'||substr(E2_Vencrea,1,4)) VencSe2  , "
cQryPEG += CRLF + "                   (substr(E2_Baixa  ,7,2)||'/'||substr(E2_Baixa  ,5,2)||'/'||substr(E2_Baixa  ,1,4)) BaixaSe2 , "
cQryPEG += CRLF + "                   E2_Valor ValorSe2, E2_Saldo SaldoSe2 "
cQryPEG += CRLF + "              From SE2020 SE2 "
cQryPEG += CRLF + "             Where E2_Filial = '01'  And SE2.D_E_L_E_T_ = ' ' "
//cQryPEG += CRLF + "               And E2_Fornece in ('INPSEF','INPSEG','INPTXN','INPSFU','194347','125276' ,'INPTWE')
cQryPEG += CRLF + "               And E2_Fornece        = '125276' "
cQryPEG += CRLF + "               And E2_Prefixo        = 'COM' "
cQryPEG += CRLF + "               AND E2_EMISSAO       >= '20200101' " 
cQryPEG += CRLF + "               And E2_Valor          = E2_Saldo " 
cQryPEG += CRLF + "               And E2_Baixa          = ' ' "
cQryPEG += CRLF + "               And E2_Origem         In ('PLSMPAG','PLSM152') " 
cQryPEG += CRLF + "               And E2_Tipo            = 'DP' ) TIT , " 
cQryPEG += CRLF + "           (Select Bxq_Codemp CodEmpBxq , "
cQryPEG += CRLF + "                   trim(BG9_DESCRI) NomEmpBxq , "
cQryPEG += CRLF + "                   Bxq_E2pref E2PrefBxq , "
cQryPEG += CRLF + "                   Bxq_E2num  E2NumBXq  , "
cQryPEG += CRLF + "                   Bxq_E2tipo E2TipoBxq , "
cQryPEG += CRLF + "                   Bxq_E2forn E2FornBxq , "
cQryPEG += CRLF + "                   Bxq_Codven CodVenBxq , "
cQryPEG += CRLF + "                   trim(Bxq_Ano || Bxq_Mes) CompteBxq , bxq_numpar NumParBxq ,  "
cQryPEG += CRLF + "                   Sum(Bxq_Bascom) BaseComBxq , "
cQryPEG += CRLF + "                   Sum(Bxq_Vlrcom) VlrComBxq  , "   
cQryPEG += CRLF + "                   CASE  WHEN bxq_percom < 0  THEN bxq_percom * -1 "
cQryPEG += CRLF + "                         WHEN bxq_percom > 0  THEN bxq_percom  END Percom "
cQryPEG += CRLF + "              From BXQ020 BXQ  ,SE2020 SE2 , BG9020 BG9 , se1020 se1 " 
cQryPEG += CRLF + "             Where Bxq_Filial = '  '  And Bxq.D_E_L_E_T_ = ' ' "
cQryPEG += CRLF + "               And E2_Filial  = '01'  And SE2.D_E_L_E_T_ = ' ' "
cQryPEG += CRLF + "               And E1_Filial  = '01'  And SE1.D_E_L_E_T_ = ' ' "
cQryPEG += CRLF + "               And BG9_Filial = '  '  And BG9.D_E_L_E_T_ = ' ' "
cQryPEG += CRLF + "               AND BXQ_CODVEN = '000215' "
cQryPEG += CRLF + "               And E2_Fornece = '125276' "
cQryPEG += CRLF + "               And Bxq_Refere = Bxq_Pagcom "
cQryPEG += CRLF + "               And Bxq_E2pref = E2_Prefixo "
cQryPEG += CRLF + "               And Bxq_E2num  = E2_Num "
cQryPEG += CRLF + "               And Bxq_E2tipo = E2_Tipo "
cQryPEG += CRLF + "               And E2_Fornece = Bxq_E2forn "
cQryPEG += CRLF + "               And Bxq_Ano||Bxq_Mes >= '202001' " 
cQryPEG += CRLF + "               And E2_Baixa   = ' '      "
cQryPEG += CRLF + "               And E2_Valor   = E2_Saldo "
cQryPEG += CRLF + "               and bg9_codint = '0001' AND trim(bxq_CODEMP) = trim(BG9_CODIGO) " 
cQryPEG += CRLF + "               and e1_prefixo = bxq_prefix   "
cQryPEG += CRLF + "               and e1_num     = BXQ.BXQ_NUM  "
cQryPEG += CRLF + "               and e1_parcela = BXQ.BXQ_PARC "
cQryPEG += CRLF + "               and e1_tipo    = BXQ.BXQ_TIPO " 
cQryPEG += CRLF + "               and e2_valor   > 0  "
cQryPEG += CRLF + "               and e1_saldo   = 0  "            
cQryPEG += CRLF + "             Group By Bxq_Codemp , "
cQryPEG += CRLF + "                      trim(BG9_DESCRI) , " 
cQryPEG += CRLF + "                      Bxq_E2pref , "
cQryPEG += CRLF + "                      Bxq_E2num  , "
cQryPEG += CRLF + "                      Bxq_E2tipo , "
cQryPEG += CRLF + "                      Bxq_E2forn , "
cQryPEG += CRLF + "                      Bxq_Codven , Bxq_numpar  , "
cQryPEG += CRLF + "                      trim(Bxq_Ano || Bxq_Mes) , "
cQryPEG += CRLF + "                      CASE  WHEN bxq_percom < 0  THEN bxq_percom * -1 "
cQryPEG += CRLF + "                            WHEN bxq_percom > 0  THEN bxq_percom  END  ) COM , "
cQryPEG += CRLF + "           (Select nvl(Pdy_Codeqp,'Sem/Eqp') Codeqppdy, nvl(Pdy_Codemp ,' ') Codemppdy , nvl(pdy_compte,' ') comptepdy From Pdy010 Pdy Where Pdy_Filial = ' ' And D_E_L_E_T_ = ' ' ) PDY , "
cQryPEG += CRLF + "           (select bxq_codemp codemp , min(bxq_ano||bxq_mes||'01') dtmin from bxq020 where bxq_filial = ' ' and d_E_L_E_T_ =' ' And Bxq_Refere = Bxq_Pagcom  And Bxq_Ano||Bxq_Mes >= '202001' and bxq_codemp >'0001'  group by bxq_codemp order by 1)dtmin , "
cQryPEG += CRLF + "           (select bxq_codemp codemp , max(bxq_ano||bxq_mes||'28') dtmax from bxq020 where bxq_filial = ' ' and d_E_L_E_T_ =' ' And Bxq_Refere = Bxq_Pagcom  And Bxq_Ano||Bxq_Mes >= '202001' and bxq_codemp >'0001' group by bxq_codemp order by 1)dtmax "
cQryPEG += CRLF + "     Where Com.E2prefBxq = Tit.PrefSe2 "
cQryPEG += CRLF + "       And Com.E2numBxq  = Tit.NumSe2  "
cQryPEG += CRLF + "       And Com.E2tipoBxq = Tit.TiposE2 "
cQryPEG += CRLF + "       And Com.E2fornBxq = Tit.ForneceSe2 "
cQryPEG += CRLF + "       And trim(PDY.CODEMPPDY(+)) = trim(COM.CodEmpBxq) " 
cQryPEG += CRLF + "       and Dtmin.Codemp  = COM.CodEmpBxq " 
cQryPEG += CRLF + "       and dtmax.Codemp  = COM.CodEmpBxq "
cQryPEG += CRLF + "       and PDY.comptepdy < COM.CompteBxq "
cQryPEG += CRLF + "       ORDER BY CodEmpBxq , CompteBxq " 

/*
cQryPEG :="          Select distinct Prefse2   , NumSe2    , TipoSe2  , ForneceSe2 , NomForSe2 , EmissaoSe2 , VencSe2   , BaixaSe2  , ValorSe2   , SaldoSe2  , " 
cQryPEG += CRLF + "         CodEmpBxq , E2PrefBxq , E2NumBXq , E2TipoBxq  , E2FornBxq , CodVenBxq  , CompteBxq , BaseComBxq , VlrComBxq ,NomEmpBxq ,  "

cQryPEG += CRLF + "         nvl(CODEQPPDY,'Sem Equipe') CODEQPPDY , CODEMPPDY  CODEMPPDY , Nvl(comptepdy, ' ') comptepdy , "   

//cQryPEG += CRLF + "        (trunc(months_between(TO_DATE(TRIM(dtmax),'YYYYMMDD') , TO_DATE(TRIM(CompteBxq||'01'),'YYYYMMDD')))+1) NumFat , "
 cQryPEG += CRLF + "        ((trunc(months_between(TO_DATE(TRIM(dtmax),'YYYYMMDD') , TO_DATE(TRIM(dtmin),'YYYYMMDD')))+1) - "
 cQryPEG += CRLF + "         (trunc(months_between(TO_DATE(TRIM(dtmax),'YYYYMMDD') , TO_DATE(TRIM(CompteBxq||'01'),'YYYYMMDD')))+1)+1) NumFat ,"

cQryPEG += CRLF + "        (trunc(months_between(TO_DATE(TRIM(dtmax),'YYYYMMDD') , TO_DATE(TRIM(dtmin),'YYYYMMDD')))+1) QtdaFat , "
cQryPEG += CRLF + "         trim(substr(dtmin,1,6)) CptPFat , trim(substr(dtmax,1,6)) CptUFat ,  Percom Percom  "

cQryPEG += CRLF + "    From (Select E2_Prefixo Prefse2 , E2_Num NumSe2 , E2_Tipo TipoSe2 , E2_Fornece ForneceSe2 ,E2_NomFor NomForSe2 ,"

cQryPEG += CRLF + "          (substr(E2_Emissao,7,2)||'/'||substr(E2_Emissao,5,2)||'/'||substr(E2_Emissao,1,4)) EmissaoSe2, "
cQryPEG += CRLF + "          (substr(E2_Vencrea,7,2)||'/'||substr(E2_Vencrea,5,2)||'/'||substr(E2_Vencrea,1,4)) VencSe2   , "
cQryPEG += CRLF + "          (substr(E2_Baixa  ,7,2)||'/'||substr(E2_Baixa  ,5,2)||'/'||substr(E2_Baixa  ,1,4)) BaixaSe2  , "
cQryPEG += CRLF + "           E2_Valor ValorSe2, E2_Saldo SaldoSe2 "

cQryPEG += CRLF + "            From SE2020 SE2"    

cQryPEG += CRLF + "           Where E2_Filial = '" + xFilial('SE2') + "'  And SE2.D_E_L_E_T_ = ' ' " 

//cQryPEG += CRLF + "And E2_Fornece in ('INPSEF','INPSEG','INPTXN','INPSFU','194347','125276' ,'INPTWE','INPUCP')"
cQryPEG += CRLF + "And E2_Fornece in ('INPSEF','INPSEG','INPTXN','INPSFU','194347','125276' ,'INPTWE')"

cQryPEG += CRLF + "             And E2_Prefixo        = 'COM' " 
 CRLF + "             And E2_Fornece        in('125276','194347') " 
cQryPEG += CRLF + "             AND E2_EMISSAO       >= '20200101' "
cQryPEG += CRLF + "             And E2_Valor          = E2_Saldo "
cQryPEG += CRLF + "             And E2_Baixa          = ' ' "

cQryPEG += CRLF + "             And E2_Origem         In ('PLSMPAG','PLSM152') " 

cQryPEG += CRLF + "             And E2_Tipo            = 'DP' ) TIT , "  
cQryPEG += CRLF + "        ( Select Bxq_Codemp CodEmpBxq, trim(BG9_DESCRI) NomEmpBxq , Bxq_E2pref E2PrefBxq, Bxq_E2num E2NumBXq, Bxq_E2tipo E2TipoBxq, Bxq_E2forn E2FornBxq   , "
cQryPEG += CRLF + "                 Bxq_Codven CodVenBxq, trim(Bxq_Ano || Bxq_Mes) CompteBxq   ,Sum(Bxq_Bascom) BaseComBxq , Sum(Bxq_Vlrcom) VlrComBxq , bxq_percom Percom "
cQryPEG += CRLF + "            From BXQ020 BXQ  ,SE2020 SE2 , BG9020 BG9 , se1020 se1 " 
cQryPEG += CRLF + "           Where Bxq_Filial = '" + xFilial('BXQ') + "'  And Bxq.D_E_L_E_T_ = ' ' " 
cQryPEG += CRLF + "             And E2_Filial  = '" + xFilial('SE2') + "'  And SE2.D_E_L_E_T_ = ' ' " 
cQryPEG += CRLF + "             And E1_Filial  = '" + xFilial('SE2') + "'  And SE1.D_E_L_E_T_ = ' ' "
cQryPEG += CRLF + "             And BG9_Filial = '" + xFilial('BG9') + "'  And BG9.D_E_L_E_T_ = ' ' " 

// DESFAZER AKI -- ALTAMIRO 27/08/20	
cQryPEG += CRLF + " AND BXQ_CODVEN in ('000174','000172','000171','000185','000191','000177','000215','000189')" 
cQryPEG += CRLF + " And E2_Fornece in ('INPSEF','INPSEG','INPTXN', 'INPSFU','125276','INPTWE')"
//cQryPEG += CRLF + " And E2_Fornece in ('INPSEF','INPSEG','INPTXN', 'INPSFU','194347','125276','INPTWE')" ALTAMIRO	 18/06/21
//cQryPEG += CRLF + " AND BXQ_CODVEN in ('000174','000172','000171','000185','000191','000177','000215','000189','000210' )" 
//cQryPEG += CRLF + " And E2_Fornece in ('INPSEF','INPSEG','INPTXN', 'INPSFU','194347','125276','INPTWE', 'INPUCP')"

//cQryPEG += CRLF + " AND BXQ_CODVEN in ('000189') And E2_Fornece in ('INPTWE')"

cQryPEG += CRLF + "             And Bxq_Refere = Bxq_Pagcom "
cQryPEG += CRLF + "             And Bxq_E2pref = E2_Prefixo "
cQryPEG += CRLF + "             And Bxq_E2num  = E2_Num "
cQryPEG += CRLF + "             And Bxq_E2tipo = E2_Tipo "
cQryPEG += CRLF + "             And E2_Fornece = Bxq_E2forn "
cQryPEG += CRLF + "             And Bxq_Ano||Bxq_Mes >= '202001' "
cQryPEG += CRLF + "            AND BXQ_CODVEN        In ('000215') "    

cQryPEG += CRLF + "             And E2_Baixa   = ' ' "
cQryPEG += CRLF + "             And E2_Valor   = E2_Saldo"
cQryPEG += CRLF + "             and bg9_codint = '0001' AND trim(bxq_CODEMP) = trim(BG9_CODIGO) "

cQryPEG += CRLF + "             and e1_prefixo = bxq_prefix   " 
cQryPEG += CRLF + "             and e1_num     = BXQ.BXQ_NUM  "
cQryPEG += CRLF + "             and e1_parcela = BXQ.BXQ_PARC "
cQryPEG += CRLF + "             and e1_tipo    = BXQ.BXQ_TIPO "
cQryPEG += CRLF + "             and e1_saldo   = 0            "

cQryPEG += CRLF + "           Group By Bxq_Codemp , BG9_DESCRI , Bxq_E2pref , Bxq_E2num , Bxq_E2tipo , Bxq_E2forn , Bxq_Codven , Bxq_Ano || Bxq_Mes, bxq_percom ) COM , "

cQryPEG += CRLF + "         (Select nvl(Pdy_Codeqp,'Sem/Eqp') Codeqppdy, nvl(Pdy_Codemp ,' ') Codemppdy , nvl(pdy_compte,' ') comptepdy From Pdy010 Pdy Where Pdy_Filial = ' ' And D_E_L_E_T_ = ' ' ) PDY , 

cQryPEG += CRLF + "         ( select bxq_codemp codemp , min(bxq_ano||bxq_mes||'01') dtmin from bxq020 where bxq_filial = ' ' and d_E_L_E_T_ =' ' And Bxq_Refere = Bxq_Pagcom  And Bxq_Ano||Bxq_Mes >= '202001' and bxq_codemp >'0001'  group by bxq_codemp order by 1)dtmin,
cQryPEG += CRLF + "         ( select bxq_codemp codemp , max(bxq_ano||bxq_mes||'28') dtmax from bxq020 where bxq_filial = ' ' and d_E_L_E_T_ =' ' And Bxq_Refere = Bxq_Pagcom  And Bxq_Ano||Bxq_Mes >= '202001' and bxq_codemp >'0001' group by bxq_codemp order by 1)dtmax

cQryPEG += CRLF + "   Where Com.E2prefBxq = Tit.PrefSe2 "
cQryPEG += CRLF + "     And Com.E2numBxq  = Tit.NumSe2 "  
cQryPEG += CRLF + "     And Com.E2tipoBxq = Tit.TiposE2 "  
cQryPEG += CRLF + "     And Com.E2fornBxq = Tit.ForneceSe2 " 

cQryPEG += CRLF + "     And trim(PDY.CODEMPPDY(+)) = trim(COM.CodEmpBxq) "

cQryPEG += CRLF + "     and Dtmin.Codemp  = COM.CodEmpBxq  and dtmax.Codemp  = COM.CodEmpBxq"

cQryPEG += CRLF + "     and PDY.comptepdy < COM.CompteBxq "

cQryPEG +=  CRLF+ "  ORDER BY CodEmpBxq , CompteBxq "

*/


TcQuery cQryPEG New Alias (cAliasPEG)  

While !(cAliasPEG)->(EOF())
                                    
    aAdd(aRetPEG,{.F. , (cAliasPEG)->CodEmpBxq , (cAliasPEG)->Prefse2 , (cAliasPEG)->NumSe2 , (cAliasPEG)->TipoSe2 , (cAliasPEG)->ForneceSe2,  (cAliasPEG)->NomForSe2 , (cAliasPEG)->EmissaoSe2 , (cAliasPEG)->VencSe2 , (cAliasPEG)->BaixaSe2 , (cAliasPEG)->ValorSe2 , (cAliasPEG)->SaldoSe2 , (cAliasPEG)->CodVenBxq , (cAliasPEG)->CompteBxq , (cAliasPEG)->BaseComBxq , (cAliasPEG)->VlrComBxq , (cAliasPEG)->CODEQPPDY , (cAliasPEG)->QtdaFat,(cAliasPEG)->CptPFat,(cAliasPEG)->CptUFat, (cAliasPEG)->percom , (cAliasPEG)->NomEmpBxq , (cAliasPEG)->NumFat , (cAliasPEG)->NumparBxq})
    	      //   1     2        				  3				      	 4					   5					  6			     	 	    7					      8				         9						 10				         11	                     12                       13                      14                       15                       16                       17                       18                        19                   20                21                     22                       23                     24

	(cAliasPEG)->(DbSkip())

EndDo
  
(cAliasPEG)->(DbCloseArea())

If empty(aRetPEG) 
	aAdd(aRetPEG,{.F.,' ',' ' ,' ',' ',' ',' ',' ',' ',' ',0 , 0 ,' ',' ', 0 , 0 , ' ' , 0 ,' ',' ', 0  , ' ', 0 , ' ' })
EndIf

Return aRetPEG

/********************************************/
/********************************************/                                    

static function  fSequen()           

local I 
                        
//	For I := 1 to len(aBrwPEG)
	
//		If aBrwPEG[I,1] == .T.    
                        
//			If aBrwPEG[I,13] == 'FEITO'   

//			    MsgAlert("Para fechamanto use o Menu de Ações Relacionadas ")  

//   	    fFecha(2,I)  //avaliar se e viavel 
            
//            ElseIf aBrwPEG[I,12] == 'FEITO'   
			
			    fDiver(2,I)
			
//			ElseIf aBrwPEG[I,11] == 'FEITO'   
			    
			    fEmail(2,I)
 
//          ElseIf aBrwPEG[I,10] == 'FEITO'  
			
			    fCarta(2,I)
			
// 			ElseIf aBrwPEG[I,9] == 'FEITO'    

			    fConfe(2,I)
        
//          ElseIf aBrwPEG[I,9] == 'A Fazer'

     		    fPgOpeRel(2,I) 
						
			
//			EndIf
			        
//      EndIf 
        
//  Next

Return ()       
/***********************************************************************************/
Static Function marca(cRef) // cRef == 1 peg , 2 , proc
	
       local nI            
       
//    If mv_par01 == 2

		For nI := 1 to len(aBrwPEG)
	
		    aBrwPEG[nI,1]:= .T.

		Next

//	EndIf 	
		
RETURN()	
	
Static Function desmarca(cRef) // cRef == 1 peg , 2 , proc
	
       local nI
			
	      For nI := 1 to len(aBrwPEG)
	
			   aBrwPEG[nI,1]:= .F.
			   
	      Next
	
RETURN() 

Static Function fFazpgto()

Local cQryEqp	:= ""

local I 

	For I := 1 to len(aBrwPEG)
			
		If  aBrwPEG[I,1] == .T.    

			cQryEqp :=  CRLF+ " select * "
			cQryEqp +=  CRLF+ "   from SIGA.pdy010 pdy ,pdx010 pdx " 
			cQryEqp +=  CRLF+ "  where pdy_filial = ' ' and pdy.D_E_L_E_T_ = ' ' " 
			cQryEqp +=  CRLF+ "    and pdx_filial = ' ' and pdx.D_E_L_E_T_ = ' ' "
			cQryEqp +=  CRLF+ "    and pdx_codigo = pdy_codeqp "
			cQryEqp +=  CRLF+ "    and pdY_codemp = '"+ aBrwPEG[I,2]+"' "
			cQryEqp +=  CRLF+ "    and pdy_codeqp = '"+ trim(aBrwPEG[I,17])+"' "
			cQryEqp +=  CRLF+ "    and ( PDY_COMPTE = ' ' or  PDY_COMPTE <= '"+ trim(aBrwPEG[I,14])+"') " 

            cQryEqp +=  CRLF+ "    and ( (PDX_PARFIM  <> ' ' 
            cQryEqp +=  CRLF+ "        AND PDX_PARINI <= '"+ trim(aBrwPEG[I,24])+"'  
			cQryEqp +=  CRLF+ "        AND PDX_PARFIM >= '"+ trim(aBrwPEG[I,24])+"')
			cQryEqp +=  CRLF+ "     OR PDX_PARFIM      = ' ')

            cQryEqp +=  CRLF+ "    AND ( (PDX_DATFIM <> ' '
			cQryEqp +=  CRLF+ "        AND SUBSTR(pdx_DATINI,1,6)  <='"+trim(aBrwPEG[I,14])+"'
            cQryEqp +=  CRLF+ "        AND SUBSTR(pdx_DATFIM,1,6)  >='"+trim(aBrwPEG[I,14])+"') 
            cQryEqp +=  CRLF+ "     OR (PDX_DATFIM = ' '"
			cQryEqp +=  CRLF+ "        AND SUBSTR(pdx_DATINI,1,6)  <='"+trim(aBrwPEG[I,14])+"'))" 
            cQryEqp +=  CRLF+ "    and pdx_codigo = pdy.PDY_CODEQP    "
			 
           If Select((cAliasEqp)) <> 0 
              (cAliasEqp)->(DbCloseArea())    
           Endif

			TcQuery cQryEqp New Alias (cAliasEqp)        
			(cAliasEqp)->(dbGoTop())
		
		    DBSELECTAREA("PDU")   
            PDU->(dbSetOrder(1))
  
    		While (cAliasEqp)->(!Eof())  
                      
			    PDU->(Reclock("PDU",.T.))

    			PDU->PDU_FILIAL  := xFilial('PDU')   
				PDU->PDU_CODEQP  := aBrwPEG[I,17]                // NOT NULL CHAR(6)  
				PDU->PDU_CODEMP  := aBrwPEG[I,2]                 // NOT NULL CHAR(6)  
				PDU->PDU_NOME    := (cAliasEqp)->PDX_NOME        // NOT NULL CHAR(30) 
				PDU->PDU_USUAR   := _cUsuario                    // NOT NULL CHAR(20) 
				PDU->PDU_DATFOL  := dDataBase                    // NOT NULL CHAR(8)  
				PDU->PDU_DATINC  := dDataBase                    // NOT NULL CHAR(8)  
				PDU->PDU_MATFUC  :=(cAliasEqp)->PDX_MATFUC       // NOT NULL CHAR(6)  
				PDU->PDU_COMPTE  := aBrwPEG[I,14]                //NOT NULL CHAR(6)   
				PDU->PDU_VERBA   := (cAliasEqp)->PDX_VERBA       // NOT NULL CHAR(3)  
				PDU->PDU_TITREC  := ' '                          // NOT NULL CHAR(17) 
				PDU->PDU_TITPGT  := aBrwPEG[I,3]+aBrwPEG[I,4]+aBrwPEG[I,5]   // NOT NULL CHAR(17) 
				PDU->PDU_VLRPGT  := (aBrwPEG[I,16] * (cAliasEqp)->PDX_PERCEN)/100 
				PDU->PDU_VLRBAS  := aBrwPEG[I,16]    
				PDU->PDU_PERCEN  := (cAliasEqp)->PDX_PERCEN //NOT NULL NUMBER   
                PDU->PDU_OBS     := "Usuario : " +_cUsuario + " Data Hora Geração " +cDthr
			    PDU->PDU_CCUSTO  := (cAliasEqp)->PDX_CCUSTO
				PDU->PDU_VBASIN  := aBrwPEG[I,15]  //NOT NULL NUMBER   
                PDU->PDU_PERINT  := aBrwPEG[I,21]   // NOT NULL NUMBER PDU_
                PDU->PDU_PGTO    := 'N'
                PDU->PDU_NUMPAR  :=  aBrwPEG[I,24] // VALIDAR 
				PDU->(MsUnlock())

				If  PDY->(dbSeek(xFilial('PDY')+TRIM(aBrwPEG[I,17])+TRIM(aBrwPEG[I,2]) )) 

				    If PDY->PDY_COMPTE < aBrwPEG[I,14]

    	               PDY->(Reclock("PDY",.F.))

                	       PDY->PDY_COMPTE := aBrwPEG[I,14] 
				
					    PDY->(MsUnlock()) 
				
				    EndIf

	            EndIf		

    aAdd(aTitRecPag,{aBrwPEG[I, 2] ,;
	                 aBrwPEG[I, 3] ,;
					 aBrwPEG[I, 4] ,;
					 aBrwPEG[I, 5] ,;
					 aBrwPEG[I, 6] ,;
					 aBrwPEG[I, 7] ,;  
					 aBrwPEG[I, 8] ,; 
	                 aBrwPEG[I, 9] ,;
					 aBrwPEG[I,10] ,;
					 aBrwPEG[I,11] ,;
					 aBrwPEG[I,12] ,;
					 aBrwPEG[I,13] ,;
					 aBrwPEG[I,14] ,;
					 aBrwPEG[I,15] ,;
                     aBrwPEG[I,16] ,;
					 aBrwPEG[I,17] ,;
					 aBrwPEG[I,18] ,;
					 aBrwPEG[I,19] ,;
					 aBrwPEG[I,20] ,;  
					 aBrwPEG[I,21] ,;
					 aBrwPEG[I,22] })
					 
				(cAliasEqp)->(DbSkip())
			
            EndDo
              
        EndIf

	Next
Return()
***************************************************************************************/
Static Function AjustaSX1()

Local aHelp 	:= {}   


     u_CABASX1(cPerg,"01",OemToAnsi("Exib. Tit. Baixados")              ,"","","mv_ch1","N",01,0,0,"C","","","","","mv_par01","Sim","","","","Não","","","","","","","","","","","",{},{},{}) 



Return 
           

Static Function ValPergFc()

cPerg := PADR(cPerg,7)    

PutSx1(cPerg,"01","Mes Compencia     "  ,"","","mv_ch01","C",02,0,0,"G","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "99", "" )  
PutSx1(cPerg,"02","Ano Compencia     "  ,"","","mv_ch02","C",04,0,0,"G","","mv_par02","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "99", "" ) 
PutSx1(cPerg,"03","Num Titulo Inc    "  ,"","","mv_ch03","C",09,0,0,"G","","mv_par03","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "99/99/9999", "" ) 
PutSx1(cPerg,"04","Num Titulo Fim    "  ,"","","mv_ch04","C",09,0,0,"G","","mv_par04","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "99/99/9999", "" ) 
PutSx1(cPerg,"05","Ope Origem Inc    "  ,"","","mv_ch05","C",04,0,0,"G","","mv_par05","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "99/99/9999", "" )
PutSx1(cPerg,"06","Ope Origem Final  "  ,"","","mv_ch06","C",04,0,0,"G","","mv_par06","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "99", "" )


Return(.T.)

Static Function fEnvEmail(cNivel , cRda )

Local lEmail     := .F.
Local c_CampAlt  := '  ' 
Local lExecuta   := .T.   
local cDest      := " "                           
Local aArea      := GetArea() //Armazena a Area atual        
Local _cMensagem := " " 

_cMensagem := "Em " + DtoC( Date() ) +  Chr(10) + Chr(13) + Chr(10) + Chr(13) 

_cMensagem +=  Chr(13) + Chr(10) + Chr(13) + Chr(10) + " Assunto : Movimentação de Comissao , equipe Interna  " 
_cMensagem +=  Chr(13) + Chr(10) + Chr(13) + Chr(10) + "Prezados,"       

_cMensagem +=  Chr(13) + Chr(10) + Chr(13) + Chr(10) + "Foi feito movimentos de baixa(s) de Titulos de Comissao na Intergral Saude , "
_cMensagem +=  Chr(13) + Chr(10) + "Criação de titulos a receber na Caberj e "
_cMensagem +=  Chr(13) + Chr(10) + "Lançamento de verbas da folha de pagamento , Conforme descrito abaixo : "
_cMensagem +=  Chr(13) + Chr(10) 
_cMensagem +=  Chr(13) + Chr(10) + "Titulos a Pagar Baixados : "

_cMensagem +=  Chr(13) + Chr(10) + "Titulos a Receber Criado e  Baixados : "

_cMensagem +=  Chr(13) + Chr(10) + "Verbas da Folha (SRK) lançadas : "
 
_cMensagem +=  Chr(13) + Chr(10) + "Para sua Ciencia."

cDest+= "altamiro@caberj.com.br ; macedo@caberj.com.br"

EnvEmail1( _cMensagem , cDest) 

RestArea(aArea)             

Return (.T.)                                                          
*--------------------------------------*
Static Function EnvEmail1( _cMensagem , cDest )
*--------------------------------------*                                           

/*Local _cMailServer := GetMv( "MV_WFSMTP" )
Local _cMailConta  := GetMv( "MV_WFAUTUS" )
Local _cMailSenha  := GetMv( "MV_WFAUTSE" )                        */
Local _cMailServer := GetMv( "MV_RELSERV" )
Local _cMailCo_Alnta  := GetMv( "MV_EMCONTA" )
Local _cMailSenha  := GetMv( "MV_EMSENHA" ) 

//Local _cTo  	 := "altamiro@caberj.com.br, paulovasques@caberj.com.br, piumbim@caberj.com.br"
Local _cTo  	     := cDest //"altamiro@caberj.com.br "
Local _cCC         := " "  //GetMv( "MV_WFFINA" )
Local _cAssunto    := " Movimentação de Comissao , equipe Interna  "
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

  /*
    Begin Transaction

		SE1->(DbSeek(cFilSe1+(cAliasTmp)->E1_PREFIXO+(cAliasTmp)->E1_NUM+(cAliasTmp)->E1_PARCELA+(cAliasTmp)->E1_TIPO))
		 aDadSe1 :={{"E1_PREFIXO"  ,(cAliasTmp)->E1_PREFIXO , Nil }, {"E1_NUM"      ,(cAliasTmp)->E1_NUM     , Nil },;
		 		    {"E1_PARCELA"  ,(cAliasTmp)->E1_PARCELA , Nil }, {"E1_TIPO"     ,(cAliasTmp)->E1_TIPO    , Nil },;
				    {"E1_CLIENTE"  ,(cAliasTmp)->E1_CLIENTE , Nil }, {"E1_LOJA"     ,(cAliasTmp)->E1_LOJA    , Nil },;
				    {"AUTMOTBX"    ,'REE'                   , Nil }, {"AUTBANCO"    ,cBanco                  , Nil },;
					{"AUTAGENCIA"  ,cAgencia                , Nil }, {"AUTCONTA"    ,cConta                  , Nil },;
					{"AUTDTBAIXA"  ,dDataBase               , Nil }, {"AUTDTCREDITO",dDataBase               , Nil },;
					{"AUTHIST"     ,cHistor                 , Nil }, {"AUTVALREC"   ,(cAliasTmp)->E1_SALDO   , Nil }}
					lMsErroAuto := .F.
					MsExecAuto({ |x,y| Fina070(x,y)},aDadSe1,if(!lExcBord,3,5))
					If lMsErroAuto
						DisarmTransaction()
						MostraErro()
					Endif
    End Transaction
*/
    // Criação de títulos provisórios.

Static Function fSe1(cPrefix , cFatura , cParcela , cTipo , cNat ,  cCliente ,  cLojaCli , dVencto , nValor , cHistor, cCodInt , cCodemp , cAnobase , CMesBase )
  
//for i = 1 to len(aBrwPEG)

		aDadosTit := {}
		aAdd(aDadosTit, {"E1_PREFIXO"	, aBrwPEG[I,3]	, Nil})
		aAdd(aDadosTit, {"E1_NUM"		, aBrwPEG[I,4]  , Nil})
		aAdd(aDadosTit, {"E1_PARCELA"	, ' '        	, Nil})
		aAdd(aDadosTit, {"E1_TIPO"		, aBrwPEG[I,5] 	, Nil})
		aAdd(aDadosTit, {"E1_NATUREZ"	, '999' 	  	, Nil})
		aAdd(aDadosTit, {"E1_CLIENTE"	, '032541'   	, Nil})
		aAdd(aDadosTit, {"E1_LOJA"		, '01'      	, Nil}) 
		aAdd(aDadosTit, {"E1_EMISSAO"	, dDataBase	    , Nil})
		aAdd(aDadosTit, {"E1_VENCTO"	, dDataBase	    , Nil})
		aAdd(aDadosTit, {"E1_VALOR"		, aBrwPEG[I,11] , Nil})
		aAdd(aDadosTit, {"E1_HIST"		, "Pagto Comissao da INTERGRAL a CABERJ"	, Nil}) 
		aAdd(aDadosTit, {"E1_CODINT"	, '0001'	, Nil})
		aAdd(aDadosTit, {"E1_CODEMP"	, '0009'	, Nil})
		aAdd(aDadosTit, {"E1_ANOBASE"	, substr(cAnoBase,1,4)	, Nil})
		aAdd(aDadosTit, {"E1_MESBASE"	, substr(cMesBase,5,2)	, Nil})

		MsExecAuto({|x,y| Fina040(x,y)},aDadosTit,3)

		If lMsErroAuto
			DisarmTransaction()
			MostraErro()
			Return .F.
		endIf 	
Return()		

	// Baixar Fatura
	        cHist     := "Pgto Comissao da INTERGRAL a CABERJ " 
			cHistoric := "Pgto Comissao da INTERGRAL a CABERJ"
	aDadSE1 := {}
	aAdd(aDadSE1, {"E1_PREFIXO"		, aBrwPEG[I,3]	, Nil })
	aAdd(aDadSE1, {"E1_NUM"			, aBrwPEG[I,4]	, Nil })
	aAdd(aDadSE1, {"E1_PARCELA"		, " "		 	, Nil })
	aAdd(aDadSE1, {"E1_TIPO"		, aBrwPEG[I,5]	, Nil })
	aAdd(aDadSE1, {"E1_CLIENTE"		, '032541'		, Nil })
	aAdd(aDadSE1, {"E1_LOJA"		, '01' 			, Nil })
	aAdd(aDadSE1, {"AUTMOTBX"		, 'BX'				, Nil }) // Mudar para NEG
	aAdd(aDadSE1, {"AUTBANCO"		, CriaVar("A6_COD")		, Nil })
	aAdd(aDadSE1, {"AUTAGENCIA"		, CriaVar("A6_AGENCIA")	, Nil })
	aAdd(aDadSE1, {"AUTCONTA"		, CriaVar("A6_NUMCON")	, Nil })
	aAdd(aDadSE1, {"AUTDTBAIXA"		, dDataBase				, Nil })
	aAdd(aDadSE1, {"AUTDTCREDITO"	, dDataBase				, Nil })
	aAdd(aDadSE1, {"AUTHIST"		, cHistoric				, Nil })
	aAdd(aDadSE1, {"E1_HIST"		, cHist					, Nil })
	aAdd(aDadSE1, {"AUTVALREC"		, aBrwPEG[I,11]				, Nil })
			
	lMsErroAuto := .F.
	MsExecAuto({|x,y| Fina070(x,y)}, aDadSe1, 3)
	If lMsErroAuto
		DisarmTransaction()
		MostraErro()
		Return .F.
	Endif

Return()

static Function fSe2()

//troca dimaniucade empresa
//Solução
//Não existe uma função específica que permita consultas ou manipulação em uma empresa 'B' enquanto estiver conectado em ambiente da empresa 'A'.
//Para que uma ação desse tipo seja possível é necessário que outra Thread seja iniciada para uma execução independente, e nela preparado um ambiente para tal.
//O recurso para essa necessidade seria a função StartJob.
//A seguir um exemplo de rotina automática, para a inclusão de um produto, em duas empresas diferentes simultaneamente;

Local aBaixa := {}

PRIVATE lMsErroAuto := .F.
Private INCLUI := .T.
private cHistBaixa := 'Baixa da Comissao Pgto a Caberj'

	AADD(aBaixa, {"E2_FILIAL" , xFilial("SE2") , Nil})
    AADD(aBaixa, {"E2_PREFIXO" , cPref , Nil})
    AADD(aBaixa, {"E2_NUM" , cNUM , Nil})
	AADD(aBaixa, {"E2_PARCELA" , cParc , Nil})
	AADD(aBaixa, {"E2_TIPO" , cTIPO , Nil})
    AADD(aBaixa, {"E2_FORNECE" , cFornec , Nil})
	AADD(aBaixa, {"E2_LOJA" , cLoja , Nil}) 
    AADD(aBaixa, {"AUTMOTBX" , "COMP. CR " , Nil})
    AADD(aBaixa, {"AUTBANCO" , "001" , Nil})
    AADD(aBaixa, {"AUTAGENCIA" , "00001" , Nil})
	AADD(aBaixa, {"AUTCONTA" , "000001 " , Nil})
	AADD(aBaixa, {"AUTDTBAIXA" , dDataBase , Nil}) 
	AADD(aBaixa, {"AUTDTCREDITO", dDataBase , Nil})
    AADD(aBaixa, {"AUTHIST" , cHistBaixa , Nil})
    AADD(aBaixa, {"AUTVLRPG" , vlrbxa , Nil})
  
    ACESSAPERG("FIN080", .F.)
 


//baixa o titulos na Integral a empresa '02'
STARTJOB("U_T020Auto",getenvserver(),.t.,aBaixa)
 
Return

User Function T020Auto(aVetor)
PRIVATE lMsErroAuto := .F.
Private INCLUI := .T.

PREPARE ENVIRONMENT EMPRESA "02" FILIAL '0201'

	lMsErroAuto := .F.
	MsExecAuto({|x,y| Fina070(x,y)}, aDadSe1, 3)
	If lMsErroAuto
		DisarmTransaction()
		MostraErro()
		Return .F.
	Endif

 
If !lMsErroAuto 
 QOut("Tit. Baixado na integral , Com susseso 02 !!!! ") 
Else 
 QOut("A T E N Ç Ã O , Erro na Baixa!!!! , Avise a TI ") 
 MostraErro()
EndIf

RESET ENVIRONMENT

Return()
/*
static Function fSRK()
Local x := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

         // Se encontrar no SRK, ATUALIZA, senao, INCLUI ...
         lForma := SRK->( dbSeek('01'+cMatric+cVerba, nValor  , dDtpgto, dDtMov , cDoc) ) 
	
         RecLock( "SRC" , !lForma )
         If !lForma
            SRK->RK_FILIAL := '01'
            SRK->RK_MAT    := AllTrim(cMatric)
            SRK->RK_PD     := cVerba 

			SRK->RK_VALORTO   := nValor  
			SRK->RK_PARCELA   := 1   
			SRK->RK_JUROANO   := 0   
            SRK->RK_JUROMES   := 0   
            SRK->RK_VALORPA   := nValor  
			SRK->RK_PARCPAG   := 1    
			SRK->RK_VLRPAGO   := 0  
			SRK->RK_VALORAR   := 0   
			SRK->RK_DTVENC    := dDtPgto   
			SRK->RK_DTMOVI    := dDtMov   
			SRK->RK_DOCUMEN   := cDoc  
			SRK->RK_CC        := '99999'  
RK_QUITARC   NOT NULL CHAR(1)  
RK_PERINI    NOT NULL CHAR(6)  
RK_NUMPAGO   NOT NULL CHAR(2)  
RK_STATUS    NOT NULL CHAR(1)  
RK_VLSALDO   NOT NULL NUMBER   
RK_NUMID     NOT NULL CHAR(26) 
RK_QUITAR    NOT NULL CHAR(1)  
RK_PROCES    NOT NULL CHAR(5)  
RK_POSTO     NOT NULL CHAR(8)  
RK_REGRADS   NOT NULL CHAR(1)  
RK_ITEM      NOT NULL CHAR(9)  
RK_CLVL      NOT NULL CHAR(9)  
RK_VALPARE   NOT NULL NUMBER   
RK_EMPCONS   NOT NULL CHAR(1)  
RK_MESDISS   NOT NULL CHAR(6)  
RK_IDCMPL    NOT NULL CHAR(6)  
RK_PDJUROS   NOT NULL CHAR(3)  
RK_VLJUROS   NOT NULL NUMBER   
RK_PCJUROS   NOT NULL NUMBER   
RK_PGJUROS   NOT NULL NUMBER   
RK_TIPO      NOT NULL CHAR(1)  
RK_HORAS     NOT NULL NUMBER   
RK_DTREF     NOT NULL CHAR(8)  
RK_NRCONTR   NOT NULL CHAR(15) 
RK_CONSFGT   NOT NULL CHAR(1)  
RK_BCOCONS   NOT NULL CHAR(5)  

            SRK->RK_TIPO1  := TRB2->TIPO1

            SRC->RC_VALOR  := TRB2->VALOR
            SRC->RC_TIPO2  := TRB2->TIPO2
            SRC->RC_DATA   := CTOD( Substr(TRB2->DTPGTO,7,2)+"/"+Substr(TRB2->DTPGTO,5,2)+"/"+Substr(TRB2->DTPGTO,1,4) )
            SRC->RC_CC     := TRB2->CCUSTO
            SRC->RC_SEQ    := '1'
         Else
            SRC->RC_DATA   := CTOD( Substr(TRB2->DTPGTO,7,2)+"/"+Substr(TRB2->DTPGTO,5,2)+"/"+Substr(TRB2->DTPGTO,1,4) )
            SRC->RC_VALOR  += TRB2->VALOR
         Endif
         SRC->( MsUnLock() )
      Next	
   ENDIF
   TRB2->( dbSkip() )
Enddo                                    
Return()




/* 
 
    Private lMsErroAuto := .F.   
    private adados := {}     
    private vlrbxa := 0.00


    dbSelectArea("SE2")
    SE2->(dbSetOrder(1))
    SE2->(dbGoTop())      
    //U_CABADPJ(TMP->(E2_PREFIXO+E2_NUM+E2_PARCELA+E2_TIPO+E2_FORNECE+E2_LOJA))  
    If SE2->(dbSeek(xFilial("SE2") + cPref + cNum + cParc + cTipo + cFornec + cLoja)) 
       if SE2->E2_SALDO > 0

          fConsDpj(cFornec)    
    
          For i:= 1 to i >  len(adados) .and. SE2->E2_SALDO > 0
 
             vlrbxa:= (SE2->E2_SALDO * (adados[i,3])/100)                                                        

             If adados[i,4] < ( adados[i,5]+ cVlrbxa )
                vlrbxa:= adados[i,4] -  adados[i,5]
             endIf   
             
             cHistBaixa := str(adados[i,1],6,0) + "Bx. Automat. DPJ"
    //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
    //³Monta array com os dados da baixa a pagar do título³
    //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ 
             aBaixa := {}
             AADD(aBaixa, {"E2_FILIAL" , xFilial("SE2") , Nil})
             AADD(aBaixa, {"E2_PREFIXO" , cPref , Nil})
             AADD(aBaixa, {"E2_NUM" , cNUM , Nil})
             AADD(aBaixa, {"E2_PARCELA" , cParc , Nil})
             AADD(aBaixa, {"E2_TIPO" , cTIPO , Nil})
             AADD(aBaixa, {"E2_FORNECE" , cFornec , Nil})
             AADD(aBaixa, {"E2_LOJA" , cLoja , Nil}) 
             AADD(aBaixa, {"AUTMOTBX" , "COMP. CR " , Nil})
             AADD(aBaixa, {"AUTBANCO" , "001" , Nil})
             AADD(aBaixa, {"AUTAGENCIA" , "00001" , Nil})
             AADD(aBaixa, {"AUTCONTA" , "000001 " , Nil})
             AADD(aBaixa, {"AUTDTBAIXA" , dDataBase , Nil}) 
             AADD(aBaixa, {"AUTDTCREDITO", dDataBase , Nil})
             AADD(aBaixa, {"AUTHIST" , cHistBaixa , Nil})
             AADD(aBaixa, {"AUTVLRPG" , vlrbxa , Nil})
             ACESSAPERG("FIN080", .F.)
             
             MSEXECAUTO({|x,y| FINA080(x,y)}, aBaixa, 3)

             If lMsErroAuto
                MOSTRAERRO() 
                Return .F.
             Else
                fgravadpj(str(adados(i,1),6,0),vlrbxa,(xFilial("SE2") + cPref + cNum + cParc + cTipo + cFornec + cLoja))
     			Alert("Baixa realizada, verifique a SE5")
    		    SE2->(dbSeek(xFilial("SE2") + cPref + cNum + cParc + cTipo + cFornec + cLoja)) 
			 EndIf
			  
	      Next
	      	 
       Else
           Alert("O título não possui saldo a pagar em aberto")
       EndIf 
    Else
        Alert("O título a pagar não foi localizado")
    EndIf
Return()

*/
return
/*
			nRegs := 0
			(cAliasTmp)->(dbGoTop())
			(cAliasTmp)->(dbEval({||nRegs++}))
			(cAliasTmp)->(dbGoTop())
			ProcRegua(nRegs)
			
			// Verifica utilização do número do bordero.
			cNumOld := cNumero
			While !MayIUseCode("E2_NUMBOR" + xFilial("SE2") + cNumero)
				cNumero := Soma1(cNumero)
			EndDo
			
			While (cAliasTmp)->(!Eof())
				
				IncProc()
				
				nRecno := (cAliasTmp)->(Recno())
				SA1->(DbSeek(cFilSa1+(cAliasTmp)->E1_CLIENTE+(cAliasTmp)->E1_LOJA))
				If !Empty((cAliasTmp)->&(cCampoOk))
					SA2->(DbSetOrder(3))
					If !SA2->(DbSeek(cFilSa2+SA1->A1_CGC)) .And. !lExcBord
						cCodFor := GetSX8Num("SA2","A2_COD")
						//  Trocado o campo sa1->a1_tipo por a1_pessoa
						//			{"A2_TIPO"    ,SA1->A1_TIPO    ,Nil}, {"A2_DIRF"    ,cDirf           ,Nil},;
							//  Alterado municipio de SA1->A1_MUN  para 'rio de janeiro'
						
						
						aDadSa2 := {{"A2_COD"     ,cCodFor         			,Nil},;
							{"A2_LOJA"    ,cLojFor         			,Nil},;
							{"A2_NOME"    ,SA1->A1_NOME    			,Nil},;
							{"A2_NREDUZ"  ,SA1->A1_NREDUZ  			,Nil},;
							{"A2_CGC"     ,SA1->A1_CGC     			,Nil},;
							{"A2_END"     ,SA1->A1_END     			,Nil},;
							{"A2_EST"     ,'RJ'            			,Nil},;
							{"A2_COD_MUN" ,'04557'         			,Nil},;
							{"A2_MUN"     ,'RIO DE JANEIRO'			,Nil},;
							{"A2_CEP"     ,SA1->A1_CEP     			,Nil},;
							{"A2_CONTATO" ,SA1->A1_CONTATO 			,Nil},;
							{"A2_TEL"     ,SA1->A1_TEL     			,Nil},;
							{"A2_DDD"     ,SA1->A1_DDD     			,Nil},;
							{"A2_FAX"     ,SA1->A1_FAX     			,Nil},;
							{"A2_CONTA"   ,cContab         			,Nil},;
							{"A2_TIPO"    ,SA1->A1_TIPO  			,Nil},;
							{"A2_DIRF"    ,cDirf           			,Nil},;
							{"A2_YTPTITU" ,'4'             			,Nil}}
						
						MSExecAuto({|x,y| MATA020(x,y)},aDadSa2,3)
						
						If lMsErroAuto
							RollBackSX8()
							DisarmTransaction()
							MostraErro()
							Exit
						Else
							
							ConfirmSX8()
							
							//------------------------------------------------------------------
							//Angelo Henrique - Data: 07/05/2019
							//------------------------------------------------------------------
							//Após a migração o ExecAuto estava apresentando erro
							//para as informações que funcionavam na P11
							//------------------------------------------------------------------
							DbSelectArea("SA2")
							DbSetOrder(1)
							If DbSeek(xFilial("SA2") + cCodFor + cLojFor)
								
								RecLock("SA2", .F.)
								
								SA2->A2_BAIRRO	:= SA1->A1_BAIRRO
								SA2->A2_EMAIL	:= AllTrim(SA1->A1_EMAIL)
								SA2->A2_BANCO	:= SA1->A1_XBANCO
								SA2->A2_AGENCIA	:= SA1->A1_XAGENC
								SA2->A2_NUMCON	:= SA1->A1_XCONTA
								SA2->A2_YDAC   	:= SA1->A1_XDGCON
								
								SA2->(MsUnLock())
								
							Endif
							
						Endif
						
					Else
						
						SA2->(Reclock("SA2",.F.))
						SA2->A2_END		:= SA1->A1_END
						SA2->A2_BAIRRO	:= SA1->A1_BAIRRO
						SA2->A2_MUN		:= SA1->A1_MUN
						SA2->A2_EST		:= SA1->A1_EST
						SA2->A2_CEP		:= SA1->A1_CEP
						SA2->A2_CONTATO	:= SA1->A1_CONTATO
						SA2->A2_TEL		:= SA1->A1_TEL
						SA2->A2_DDD		:= SA1->A1_DDD
						SA2->A2_FAX		:= SA1->A1_FAX
						SA2->A2_EMAIL	:= SA1->A1_EMAIL
						SA2->A2_CONTA	:= cContab
						SA2->A2_TIPO	:= SA1->A1_PESSOA
						//SA2->A2_TIPO	:= SA1->A1_TIPO
						//SA2->A2_DIRF	:= cDirf
						/*SA2->A2_BANCO	:= SA1->A1_XBANCO
						SA2->A2_AGENCIA	:= SA1->A1_XAGENC
						SA2->A2_NUMCON	:= SA1->A1_XCONTA
						SA2->A2_YDAC	:= SA1->A1_XDGCON/
						SA2->(MsUnlock())
						
						cCodFor := SA2->A2_COD
					EndIf
					
					SE1->(DbSeek(cFilSe1+(cAliasTmp)->E1_PREFIXO+(cAliasTmp)->E1_NUM+(cAliasTmp)->E1_PARCELA+(cAliasTmp)->E1_TIPO))
					aDadSe1 :={{"E1_PREFIXO"  ,(cAliasTmp)->E1_PREFIXO , Nil }, {"E1_NUM"      ,(cAliasTmp)->E1_NUM     , Nil },;
						{"E1_PARCELA"  ,(cAliasTmp)->E1_PARCELA , Nil }, {"E1_TIPO"     ,(cAliasTmp)->E1_TIPO    , Nil },;
						{"E1_CLIENTE"  ,(cAliasTmp)->E1_CLIENTE , Nil }, {"E1_LOJA"     ,(cAliasTmp)->E1_LOJA    , Nil },;
						{"AUTMOTBX"    ,'REE'                   , Nil }, {"AUTBANCO"    ,cBanco                  , Nil },;
						{"AUTAGENCIA"  ,cAgencia                , Nil }, {"AUTCONTA"    ,cConta                  , Nil },;
						{"AUTDTBAIXA"  ,dDataBase               , Nil }, {"AUTDTCREDITO",dDataBase               , Nil },;
						{"AUTHIST"     ,cHistor                 , Nil }, {"AUTVALREC"   ,(cAliasTmp)->E1_SALDO   , Nil }}
					lMsErroAuto := .F.
					MsExecAuto({ |x,y| Fina070(x,y)},aDadSe1,if(!lExcBord,3,5))
					If lMsErroAuto
						DisarmTransaction()
						MostraErro()
						Exit
					Endif
					
					If cPgrec = "Sim"
						SE1->(Reclock("SE1",.F.))
						SE1->E1_VENCTO  :=  dDttroca
						SE1->E1_VENCREA :=  dDttroca
						SE1->E1_FLUXO := "N"
						SE1->(MsUnlock())
					EndIf
					
					cTitOrig:= (cAliasTmp)->E1_PREFIXO+(cAliasTmp)->E1_NUM+(cAliasTmp)->E1_PARCELA+(cAliasTmp)->E1_TIPO
					If lBordero
						aDadSEA := {}
						aAdd(aDadSEA, {"EA_FILIAL"	, cFilSea					})
						aAdd(aDadSEA, {"EA_PORTADO"	, cBanco					})
						aAdd(aDadSEA, {"EA_AGEDEP"	, cAgencia					})
						aAdd(aDadSEA, {"EA_NUMCON"	, cConta					})
						aAdd(aDadSEA, {"EA_NUMBOR"	, cNumero					})
						aAdd(aDadSEA, {"EA_DATABOR"	, dDataBase					})
						aAdd(aDadSEA, {"EA_PREFIXO"	, (cAliasTmp)->E1_PREFIXO	})
						aAdd(aDadSEA, {"EA_NUM"		, (cAliasTmp)->E1_NUM		})
						aAdd(aDadSEA, {"EA_PARCELA"	, (cAliasTmp)->E1_PARCELA	})
						aAdd(aDadSEA, {"EA_TIPO"	, "REM"						})
						aAdd(aDadSEA, {"EA_FORNECE"	, cCodFor					})
						aAdd(aDadSEA, {"EA_LOJA"	, cLojFor					})
						aAdd(aDadSEA, {"EA_CART"	, "P"						})
						aAdd(aDadSEA, {"EA_MODELO"	, cModPgto					})
						aAdd(aDadSEA, {"EA_TIPOPAG"	, cTipoPag					})
						aAdd(aDadSEA, {"EA_FILORIG"	, cFilAnt					})
						
						fGeraSEA(aDadSEA, lExcBord)
					Endif
					
					// Tratamento de centro de custo e natureza por empresa e plano
					cNatPln := (cAliasTmp)->E1_NATUREZ
					If (SubStr(cNumEmp,1,2) == "01")
						cCusto := "998"
						If (cAliasTmp)->E1_PREFIXO <> 'AXF'
							cNatPln = '40001'
						EndIf
					Else
						If (substr(cNumEmp,1,2) == "02")
							cCusto := "99999"
							cNatPln = '40001'
						EndIf
					EndIf
					// --
					
					B44->(DbSeek(xFilial("B44")+(cAliasTmp)->(E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO)))
					//			{"E2_NATUREZ"  ,(cAliasTmp)->E1_NATUREZ ,Nil}, {"E2_FORNECE"  ,cCodFor                 ,Nil},;
						//		aDadSe2 :={{"E2_PREFIXO"  ,TRIM((cAliasTmp)->E1_PREFIXO) ,Nil}, {"E2_NUM"      ,(cAliasTmp)->E1_NUM     ,Nil},;
						aDadSe2 :={{"E2_PREFIXO"  ,TRIM((cAliasTmp)->E1_PREFIXO) ,Nil} , {"E2_NUM"      ,(cAliasTmp)->E1_NUM     ,Nil},;
						{"E2_PARCELA"  ,(cAliasTmp)->E1_PARCELA ,Nil}, {"E2_TIPO"     ,'REM'                   ,Nil},;
						{"E2_NATUREZ"  ,cNatPln                 ,Nil}, {"E2_FORNECE"  ,cCodFor                 ,Nil},;
						{"E2_LOJA"     ,cLojFor                 ,Nil}, {"E2_EMISSAO"  ,(cAliasTmp)->E1_EMISSAO ,NIL},;
						{"E2_VENCTO"   ,(cAliasTmp)->E1_VENCTO  ,NIL}, {"E2_VENCREA"  ,(cAliasTmp)->E1_VENCREA ,NIL},;
						{"E2_HIST"     ,'ASSOC ' + B44->B44_NOMUSR   ,Nil}, {"E2_CCD"      ,cCusto             ,Nil},;
						{"E2_VALOR"    ,(cAliasTmp)->E1_SALDO   ,Nil}, {"E2_NUMB0R"   ,If(!lExcBord,cNumero,""),Nil},;
						{"E2_PORTADO"  ,If(!lExcBord,cBanco,"") ,Nil}, {"E2_TITORIG"  ,cTitOrig                ,Nil} }
					
					lMsErroAuto := .F.
					If lExcBord .And. SE2->(DbSeek(cFilSe2+aDadSe2[aScan(aDadSe2, {|X| X[1] == "E2_PREFIXO"}),2]+;
							aDadSe2[aScan(aDadSe2, {|X| X[1] == "E2_NUM"    }),2]+;
							aDadSe2[aScan(aDadSe2, {|X| X[1] == "E2_PARCELA"}),2]+;
							aDadSe2[aScan(aDadSe2, {|X| X[1] == "E2_TIPO"   }),2]+;
							aDadSe2[aScan(aDadSe2, {|X| X[1] == "E2_FORNECE"}),2]+;
							aDadSe2[aScan(aDadse2, {|X| X[1] == "E2_LOJA"   }),2]))
						SE2->(RecLock("SE2",.F.)) ; SE2->E2_NUMBOR  := "" ; SE2->E2_PORTADO := "" ; SE2->(MsUnLock())
						RegToMemory("SE2",.F.,.F.)
						Fa050Delet("SE2",SE2->(Recno()),5)
					Else
						MsExecAuto({ |x,y| Fina050(x,y)},aDadSe2,3)
						If lMsErroAuto
							DisarmTransaction()
							MostraErro()
							Exit
						ElseIf !lMsErroAuto .And. !lExcBord
							SE2->(Reclock("SE2",.F.))
							If SE2->E2_PREFIXO <> 'AXF'
							   SE2->E2_ORIGEM := 'CAB007'
							EndIf
							
							If lBordero
								//		SE2->(RecLock("SE2",.F.))
								SE2->E2_NUMBOR  := cNumero
								SE2->E2_PORTADO := cBanco
								//		SE2->(MsUnLock())
							Endif
							if cPgrec = "Sim"
								//      SE2->(Reclock("SE2",.F.))
								SE2->E2_YDTVANT :=  SE2->E2_VENCREA
								//      SE2->E2_VENCTO  :=  dDttroca
								SE2->E2_VENCREA :=  dDttroca
								//      SE2->(MsUnlock())
							EndIf
							SE2->(MsUnlock())
						Endif
					Endif
				Endif
				(cAliasTmp)->(DbGoTo(nRecno))
				(cAliasTmp)->(DbSkip())
			EndDo
		End Transaction


/*
////////////////////////////////////////////////////////
		titulo a receber , criar

			IncProc("Criando Parcelas ...")
	cParcela := "0"
	cHistor := "PARCELAMENTO EM " + Dtoc(dDtNeg)
	For x := 1 To Len(aParcelas)

		If cParcela == "Z"
			cParcela := "1"
			cFatura := Soma1(cFatura, 6)
		Else
			cParcela := Soma1(cParcela, 1)
		EndIf
//		cParcela	:= Soma1(cParcela, 1)

		dVencto		:= aParcelas[x][1]
		nValor		:= nVlParc //aParcelas[x][2]
		cAnoBase	:= SubStr(Dtos(dVencto), 1, 4)
		cMesBase	:= SubStr(Dtos(dVencto), 5, 2)
		nPorcJur	:= If(SZG->ZG_JUROS == "S", nTxJur, 0)
		nCalcJur	:= nValor * nPorcJur / 100

	    // Criação de títulos provisórios.
		aDadosTit := {}
		aAdd(aDadosTit, {"E1_PREFIXO"	, cPrefix	, Nil})
		aAdd(aDadosTit, {"E1_NUM"		, cFatura	, Nil})
		aAdd(aDadosTit, {"E1_PARCELA"	, cParcela	, Nil})
		aAdd(aDadosTit, {"E1_TIPO"		, "PR"	  	, Nil})
		aAdd(aDadosTit, {"E1_NATUREZ"	, cNat	  	, Nil})
		aAdd(aDadosTit, {"E1_CLIENTE"	, cCliente	, Nil})
		aAdd(aDadosTit, {"E1_LOJA"		, cLojaCli	, Nil})
		aAdd(aDadosTit, {"E1_EMISSAO"	, dDataBase	, Nil})
		aAdd(aDadosTit, {"E1_VENCTO"	, dVencto  	, Nil})
		aAdd(aDadosTit, {"E1_VALOR"		, nValor  	, Nil})
		aAdd(aDadosTit, {"E1_PORCJUR"	, nPorcJur 	, Nil})
		aAdd(aDadosTit, {"E1_JUROS"		, nCalcJur 	, Nil})
		aAdd(aDadosTit, {"E1_HIST"		, cHistor	, Nil}) 
		aAdd(aDadosTit, {"E1_CODINT"	, cCodInt	, Nil})
		aAdd(aDadosTit, {"E1_CODEMP"	, cCodEmp	, Nil})
		aAdd(aDadosTit, {"E1_MATRIC"	, cMatric	, Nil})
		aAdd(aDadosTit, {"E1_CONEMP"	, cConEmp	, Nil})
		aAdd(aDadosTit, {"E1_VERCON"	, cVerCon	, Nil})
		aAdd(aDadosTit, {"E1_SUBCON"	, cSubCon	, Nil})
		aAdd(aDadosTit, {"E1_VERSUB"	, cVerSub	, Nil})
		aAdd(aDadosTit, {"E1_XNUMNEG"	, cNeg	  	, Nil})
		aAdd(aDadosTit, {"E1_ANOBASE"	, cAnoBase	, Nil})
		aAdd(aDadosTit, {"E1_MESBASE"	, cMesBase	, Nil})

		MsExecAuto({|x,y| Fina040(x,y)},aDadosTit,3)

		If lMsErroAuto
			DisarmTransaction()
			MostraErro()
			Return .F.
		EndIf
/////////////////////////////////////////////////////////////
baixa titulo do contas a receber


	// Preenche demais dados da fatura.
	If SE1->(dbSeek(cFilSE1+cPrefix+cFatura+" "+cTipo))
		SE1->(Reclock("SE1",.F.))
		SE1->E1_HIST	:= cHistoric
		SE1->E1_XNUMNEG	:= cNeg
		SE1->E1_CODINT	:= cCodInt
		SE1->E1_CODEMP	:= cCodEmp
		SE1->E1_MATRIC	:= cMatric
		SE1->E1_CONEMP	:= cConEmp
		SE1->E1_VERCON	:= cVerCon
		SE1->E1_SUBCON	:= cSubCon
		SE1->E1_VERSUB	:= cVerSub
		SE1->(MsUnlock())
	EndIf
	// Baixar Fatura
	cHist := "NEGOCIACAO EM: " + Dtoc(dDtNeg)
	aDadSE1 := {}
	aAdd(aDadSE1, {"E1_PREFIXO"		, cPrefix				, Nil })
	aAdd(aDadSE1, {"E1_NUM"			, cFatura				, Nil })
	aAdd(aDadSE1, {"E1_PARCELA"		, " "		 			, Nil })
	aAdd(aDadSE1, {"E1_TIPO"		, cTipo		 			, Nil })
	aAdd(aDadSE1, {"E1_CLIENTE"		, cCliente	  			, Nil })
	aAdd(aDadSE1, {"E1_LOJA"		, cLojaCli	   			, Nil })
	aAdd(aDadSE1, {"AUTMOTBX"		, cTpBaixa				, Nil }) // Mudar para NEG
	aAdd(aDadSE1, {"AUTBANCO"		, CriaVar("A6_COD")		, Nil })
	aAdd(aDadSE1, {"AUTAGENCIA"		, CriaVar("A6_AGENCIA")	, Nil })
	aAdd(aDadSE1, {"AUTCONTA"		, CriaVar("A6_NUMCON")	, Nil })
	aAdd(aDadSE1, {"AUTDTBAIXA"		, dDataBase				, Nil })
	aAdd(aDadSE1, {"AUTDTCREDITO"	, dDataBase				, Nil })
	aAdd(aDadSE1, {"AUTHIST"		, cHistoric				, Nil })
	aAdd(aDadSE1, {"E1_HIST"		, cHist					, Nil })
	aAdd(aDadSE1, {"AUTVALREC"		, nVlNeg				, Nil })
			
	lMsErroAuto := .F.
	MsExecAuto({|x,y| Fina070(x,y)}, aDadSe1, 3)
	If lMsErroAuto
		DisarmTransaction()
		MostraErro()
		Return .F.
	Endif

	///////
	baixa a pagar 

	User Function CABADPJ(cPref ,cNum,cParc,cTipo,cFornec,cLoja)

    Private lMsErroAuto := .F.   
    private adados := {}     
    private vlrbxa := 0.00


    dbSelectArea("SE2")
    SE2->(dbSetOrder(1))
    SE2->(dbGoTop())      
    //U_CABADPJ(TMP->(E2_PREFIXO+E2_NUM+E2_PARCELA+E2_TIPO+E2_FORNECE+E2_LOJA))  
    If SE2->(dbSeek(xFilial("SE2") + cPref + cNum + cParc + cTipo + cFornec + cLoja)) 
       if SE2->E2_SALDO > 0

          fConsDpj(cFornec)    
    
          For i:= 1 to i >  len(adados) .and. SE2->E2_SALDO > 0
 
             vlrbxa:= (SE2->E2_SALDO * (adados[i,3])/100)                                                        

             If adados[i,4] < ( adados[i,5]+ cVlrbxa )
                vlrbxa:= adados[i,4] -  adados[i,5]
             endIf   
             
             cHistBaixa := str(adados[i,1],6,0) + "Bx. Automat. DPJ"
    //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
    //³Monta array com os dados da baixa a pagar do título³
    //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ 
             aBaixa := {}
             AADD(aBaixa, {"E2_FILIAL" , xFilial("SE2") , Nil})
             AADD(aBaixa, {"E2_PREFIXO" , cPref , Nil})
             AADD(aBaixa, {"E2_NUM" , cNUM , Nil})
             AADD(aBaixa, {"E2_PARCELA" , cParc , Nil})
             AADD(aBaixa, {"E2_TIPO" , cTIPO , Nil})
             AADD(aBaixa, {"E2_FORNECE" , cFornec , Nil})
             AADD(aBaixa, {"E2_LOJA" , cLoja , Nil}) 
             AADD(aBaixa, {"AUTMOTBX" , "COMP. CR " , Nil})
             AADD(aBaixa, {"AUTBANCO" , "001" , Nil})
             AADD(aBaixa, {"AUTAGENCIA" , "00001" , Nil})
             AADD(aBaixa, {"AUTCONTA" , "000001 " , Nil})
             AADD(aBaixa, {"AUTDTBAIXA" , dDataBase , Nil}) 
             AADD(aBaixa, {"AUTDTCREDITO", dDataBase , Nil})
             AADD(aBaixa, {"AUTHIST" , cHistBaixa , Nil})
             AADD(aBaixa, {"AUTVLRPG" , vlrbxa , Nil})
             ACESSAPERG("FIN080", .F.)
             
             MSEXECAUTO({|x,y| FINA080(x,y)}, aBaixa, 3)

             If lMsErroAuto
                MOSTRAERRO() 
                Return .F.
             Else
                fgravadpj(str(adados(i,1),6,0),vlrbxa,(xFilial("SE2") + cPref + cNum + cParc + cTipo + cFornec + cLoja))
     			Alert("Baixa realizada, verifique a SE5")
    		    SE2->(dbSeek(xFilial("SE2") + cPref + cNum + cParc + cTipo + cFornec + cLoja)) 
			 EndIf
			  
	      Next
	      	 
       Else
           Alert("O título não possui saldo a pagar em aberto")
       EndIf 
    Else
        Alert("O título a pagar não foi localizado")
    EndIf
Return()



//////
troca dimaniucade empresa
Solução
Não existe uma função específica que permita consultas ou manipulação em uma empresa 'B' enquanto estiver conectado em ambiente da empresa 'A'. Para que uma ação desse tipo seja possível é necessário que outra Thread seja iniciada para uma execução independente, e nela preparado um ambiente para tal. O recurso para essa necessidade seria a função StartJob.
A seguir um exemplo de rotina automática, para a inclusão de um produto, em duas empresas diferentes simultaneamente;

#Include 'Protheus.ch'
#Include 'TBICONN.ch'

User Function tStJb010()
Local aVetor := {}

PRIVATE lMsErroAuto := .F.
Private INCLUI := .T.

aVetor:= {{"B1_COD" ,'PA01           ' ,NIL},; 
 {"B1_DESC" ,"TESTE EXECAUT " ,NIL},; 
 {"B1_TIPO" ,"PA" ,Nil},; 
 {"B1_UM" ,"UN" ,Nil},; 
 {"B1_PESO" ,10 ,Nil},; 
 {"B1_LOCPAD" ,"01" ,Nil},;
 {"B1_RASTRO" ,"N" ,Nil},;
 {"B1_LOCALIZ" ,"N" ,Nil}}
 
//Inclui o produto na empresa corrente ('99') 
MSExecAuto({|x,y| Mata010(x,y)},aVetor,3)

If !lMsErroAuto 
 QOut("Produto incluído na empresa 99") 
Else 
 QOut("Erro na inclusao!") 
 MostraErro()
EndIf

//Inclui o mesmo produto na empresa '02'
STARTJOB("U_T010Auto",getenvserver(),.t.,aVetor)
 
Return

User Function T010Auto(aVetor)
PRIVATE lMsErroAuto := .F.
Private INCLUI := .T.

PREPARE ENVIRONMENT EMPRESA "02" FILIAL '0201'

MSExecAuto({|x,y| Mata010(x,y)},aVetor,3)

If !lMsErroAuto 
 QOut("Produto incluído na empresa 02 ") 
Else 
 QOut("Erro na inclusao!") 
 MostraErro()
EndIf

RESET ENVIRONMENT

Return



Static Function FGrvSRK(cMatric, cVerba)

Local x := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

         // Se encontrar no SRK, ATUALIZA, senao, INCLUI ...
         lForma := SRK->( dbSeek('01'+cMatric+cVerba, nValor  , dDtpgto, dDtMov , cDoc) ) 
	
         RecLock( "SRC" , !lForma )
         If !lForma
            SRK->RK_FILIAL := '01'
            SRK->RK_MAT    := AllTrim(cMatric)
            SRK->RK_PD     := cVerba 

			SRK->RK_VALORTO   := nValor  
			SRK->RK_PARCELA   := 1   
			SRK->RK_JUROANO   := 0   
            SRK->RK_JUROMES   := 0   
            SRK->RK_VALORPA   := nValor  
			SRK->RK_PARCPAG   := 1    
			SRK->RK_VLRPAGO   := 0  
			SRK->RK_VALORAR   := 0   
			SRK->RK_DTVENC    := dDtPgto   
			SRK->RK_DTMOVI    := dDtMov   
			SRK->RK_DOCUMEN   := cDoc  
			SRK->RK_CC        := '99999'  
RK_QUITARC   NOT NULL CHAR(1)  
RK_PERINI    NOT NULL CHAR(6)  
RK_NUMPAGO   NOT NULL CHAR(2)  
RK_STATUS    NOT NULL CHAR(1)  
RK_VLSALDO   NOT NULL NUMBER   
RK_NUMID     NOT NULL CHAR(26) 
RK_QUITAR    NOT NULL CHAR(1)  
RK_PROCES    NOT NULL CHAR(5)  
RK_POSTO     NOT NULL CHAR(8)  
RK_REGRADS   NOT NULL CHAR(1)  
RK_ITEM      NOT NULL CHAR(9)  
RK_CLVL      NOT NULL CHAR(9)  
RK_VALPARE   NOT NULL NUMBER   
RK_EMPCONS   NOT NULL CHAR(1)  
RK_MESDISS   NOT NULL CHAR(6)  
RK_IDCMPL    NOT NULL CHAR(6)  
RK_PDJUROS   NOT NULL CHAR(3)  
RK_VLJUROS   NOT NULL NUMBER   
RK_PCJUROS   NOT NULL NUMBER   
RK_PGJUROS   NOT NULL NUMBER   
RK_TIPO      NOT NULL CHAR(1)  
RK_HORAS     NOT NULL NUMBER   
RK_DTREF     NOT NULL CHAR(8)  
RK_NRCONTR   NOT NULL CHAR(15) 
RK_CONSFGT   NOT NULL CHAR(1)  
RK_BCOCONS   NOT NULL CHAR(5)  







            SRK->RK_TIPO1  := TRB2->TIPO1

            SRC->RC_VALOR  := TRB2->VALOR
            SRC->RC_TIPO2  := TRB2->TIPO2
            SRC->RC_DATA   := CTOD( Substr(TRB2->DTPGTO,7,2)+"/"+Substr(TRB2->DTPGTO,5,2)+"/"+Substr(TRB2->DTPGTO,1,4) )
            SRC->RC_CC     := TRB2->CCUSTO
            SRC->RC_SEQ    := '1'
         Else
            SRC->RC_DATA   := CTOD( Substr(TRB2->DTPGTO,7,2)+"/"+Substr(TRB2->DTPGTO,5,2)+"/"+Substr(TRB2->DTPGTO,1,4) )
            SRC->RC_VALOR  += TRB2->VALOR
         Endif
         SRC->( MsUnLock() )
      Next	
   ENDIF
   TRB2->( dbSkip() )
Enddo                                    

//+---------------------------------------------------------------------+
//| Fecha Arquivo Temporario...                                         |
//+---------------------------------------------------------------------+
If Select("TRB2") > 0 ; dbSelectArea("TRB2") ; TRB2->( dbCloseArea() ) ; Endif
Return 
