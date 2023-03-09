#INCLUDE "PROTHEUS.CH"
#Include "TOPCONN.CH"     
#Define cCodConv "104,116,117,123,124,125,127,134,137,138,139,140,141,142,143,144,145,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,177"
                                          
/*/                                 
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออออหออออออัอออออออออออปฑฑ
ฑฑบPrograma  ณcabr133   บ Autor ณAltamiro              บ Data ณ 01/10/12  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออออสออออออฯอออออออออออนฑฑ
ฑฑบDescricao ณ Relatorio de conferencia e contabiliza็ใo de baixa receber บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/                  

User Function CABR133

Local cMsg			:= ""
Private lAbortPrint :=.F.
Private cPerg       := "CABR133"
Private cTitulo     :=  "Mapa da Movimenta็ใo dos Titulos Receber & Contabiliza็ใo"         

Private cAliastmp 	:= GetNextAlias()         

Private cAliastmp1 	:= GetNextAlias()     

Private cAliassa52 	:= GetNextAlias()

Private cAliasszh 	:= GetNextAlias()       

Private cAliassa1  	:= GetNextAlias()

Private cAliassa6  	:= GetNextAlias()
                                                                         

cMsg += " Este programa  tem a finalidade de gerar listagem da movimenta็ใo dos titulos do contas a receber por diversos paramentros " + CRLF 
cMsg += " e fazer a sua contabiliza็ใo quando solicitado  " + CRLF

***************************************************************************    
 
Private  aDados      := {} 
Private  aDados1     := {}        
Private  aDados2     := {}    
Private  aDados3     := {}        
Private  aDados4     := {}       
Private  aDados5     := {}   
Private  aDados6     := {}  
    

Private  aRecnoBM1   := {}  
Private  aRecnoE5    := {}       
Private  aRecnoE1    := {} 

Private  lE5ok       := .T.  
Private  lBM1ok      := .T.  
Private  lE1ok       := .T. 
Private  lDefok      := .T. 

Private cPrefCmp      := ' ' 

Private lContMov      := .T. 
Private lContTit      := .T.
 
//private cContaD1      :- ' ' 

Private  nAscan      := 0
Private  acabec1     :={"Titulo ","Vlr Titulos", "Saldo Titulo " , "Vlor Bx Titulo ","Tp Doc","Motivo Bx.","Sequencia ","Tipo Lanc.","Plano ","Vlr Lanc" }
private  Descric     := ' '                                                                                                         
                        
private _nTotVlr	:= 0   
private cTpDif      := ' ' 

//
Private l_sai       := .T.
Private _ddatabase  := DDATABASE
Private _nTotal     := 0
Private _nTotal     :=0.00
Private _cNumLote   := ""
Private l_mostra    := .T.
Private lAglutina	:= .F.
Private _dDataAnt	:= dDataBase
Private _cFilOri	:= cFilAnt
Private _cQtdlin	:= 0
Private  nContx     := 0
Private	cLote    	:= " "
Private cPadrao  	:= " "    
Private lMARKBM1    := .T.  
private ccont       :=0    
private lCritica    := .F.  
private cVlAnt      :=0.00  
private cNumTit     := ' ' 
private cTpOpera    := 'N'

//
Public _nVLMOV1 
Public _cCTADEB
Public _cCTACRE 
Public _cITEMDEB  
Public _cITEMCRE   
Public _cCLVLDEB   
Public _cCLVLCRE   
Public _cDESCTIP

                	
  	  
AjustaSX1(cPerg)

Pergunte(cPerg,.T.) 

cTitulo += " De "+ DtoC(mv_par01)+ " Ate " + DtoC(mv_par02)    

cDtInicMvB     := dtos(mv_par01)
cDtFimMvB  	   := dtos(mv_par02)   
cImpRel        := mv_par03
cImpRes  	   := mv_par04
nMais1Mov      := mv_par05 
nDivVlr        := mv_par06
cPrefSair      := mv_par07            
cPNaoSair      := mv_par08           
cMotSair       := mv_par09            
cMNaoSair      := mv_par10
cGeraEx        := mv_par11   
cListConv      := mv_par12    
cListEst       := mv_par13 
cTitEsp        := mv_par14    
cdtBxMv        := mv_par15  
cMovBanc       := mv_par16  
cContab        := mv_par17
cfazCont       := mv_par18  

cMostLanc      := mv_par19 
cAgluLanc      := mv_par20

cConfCont      := mv_par21  

_cHistPad      := mv_par22   
_cItemCont     := mv_par23  
   
cfazContCC     := mv_par24 
cCodBSai       := mv_par25
lcontabiliza   := Iif(cContab == 1,'F','T')

cEmpresa    := Iif(cEmpAnt == '01','C','I')  

  
Processa({||Processa1()}, cTitulo, "", .T.)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Libera impressao                                                         ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
   
// faz ecxel

if cGeraEx == 1  
    DlgToExcel({{"ARRAY","Mapa da contabilizz็ใo da receita" ,aCabec1,aDados}})            
    DlgToExcel({{"ARRAY","Mapa da contabilizz็ใo da receita",aCabec1,aDados1}})   
    DlgToExcel({{"ARRAY","Mapa da contabilizz็ใo da receita",aCabec1,aDados2}})   
    DlgToExcel({{"ARRAY","Mapa da contabilizz็ใo da receita",aCabec1,aDados4}})  
    DlgToExcel({{"ARRAY","Mapa da contabilizz็ใo da receita",aCabec1,aDados5}})       
EndIf 
If cImpRel  == 1  .or. cImpRes == 1 
   fGeraRel2()                                   
EndIf   
// Contabilizacao movimenta็ใo da Receita 
If cfazCont    == 2 .and. cConfCont  == 2  .and. cdtBxMv == 1 .and. (cDtInicMvB == cDtFimMvB)  ;
.and. cContab == 1  .and. (!lCritica .or. cfazContCC == 2) .and. empty(cTitEsp) 
	alert("Contabilizacao Movimento Receita ")
	Processa ({||Contabiliza()})			  
ElseIf cfazCont    == 2 .and. cConfCont  == 2                                                                                    
    if cdtBxMv != 1                          
        alert("Nao Contabiliza - Cons. Dt Baixa Para Moviment - diferente de FIM ") 
    EndIf                                                                                    
    if cDtInicMvB != cDtFimMvB                                              
        alert("Nao Contabiliza - Diferen็a entre a Data inicial e final  ") 
    EndIf   
    if cContab != 1                                              
        alert("Nao Contabiliza - Selecใo  Diferente de Nao Contabilizado ") 
    EndIf        
    if lCritica                                              
        alert("Nao Contabiliza - Hแ Criticas de contas contabil          ") 
    EndIf  
   
EndIf  
      

lCritica:= .F.                                                                                                                         
             
MsgInfo("Processo finalizado")       

If Select((cAliastmp)) <> 0 
  (cAliastmp)->(DbCloseArea()) 
Endif
     
If Select((cAliastmp1)) <> 0 
  (cAliastmp1)->(DbCloseArea()) 
Endif  

If Select((cAliassa52)) <> 0 
  (cAliassa52)->(DbCloseArea()) 
Endif 

If Select((cAliasszh)) <> 0 
  (cAliasszh)->(DbCloseArea()) 
Endif
     
If Select((cAliassa1)) <> 0 
  (cAliassa1)->(DbCloseArea()) 
Endif
     
If Select((cAliassa6)) <> 0 
  (cAliassa6)->(DbCloseArea()) 
Endif

Return                 

**************************************************************************

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuno    ณ PROCESSA1บ Autor ณ altamiro	         บ Data ณ  11/11/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescrio ณ Funcao auxiliar chamada pela PROCESSA.  A funcao PROCESSA  บฑฑ
ฑฑบ          ณ monta a janela com a regua de processamento.               บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Programa principal                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static Function Processa1()        

ProcRegua(FT_FLASTREC()) 

nCont := 0
IncProc('Processando...')            
/////////////
cquery := "SELECT distinct TRIM (E1_PREFIXO || E1_NUM || E1_PARCELA || E1_TIPO||E1_CLIENTE||' - '||E1_NOMCLI)  E1IDENT_TIT , "    
cquery += CRLF+"        decode(SE52.E5_TIPODOC, 'BA',1,'VL',2,'RA',3,'ES',4,'CP',5,'JR',6,7) ORD ,"
cquery += CRLF+"        decode(SE52.E5_MOTBX, 'NOR',1,'FAT',2,'BNF',3,'CMP',4,'CEC',5, 6 ) ORD1 ,E1_ORIGEM  E1ORIGEM , E1_CLIENTE E1CLIENTE , "
cquery += CRLF+"        E1_VALOR E1VLR_TIT, E1_SALDO E1SLD_TIT, e1_labai E1LABX , DECODE( SE52.E5_TIPODOC , 'ES', SE52.E5_VLMOED2 * -1,'DC', SE52.E5_VLMOED2 * 1, SE52.E5_VLMOED2 )E5VLR_BX_TIT , "
cquery += CRLF+"        SE52.E5_MOTBX E5MOT_BX, SE52.E5_SEQ E5SEQ , SE52.E5_BANCO E5BANCO, SE52.E5_AGENCIA E5AGENCIA, SE52.E5_CONTA E5CONTA, SE52.E5_RECPAG E5RECPAG, "
cquery += CRLF+"        SE52.E5_TIPODOC E5TP_DOC , NVL(BM1_TIPO,' '  ) BM1DEBCED , NVL(BM1_CODTIP,' ' ) ||' - '|| NVL(BM1_DESTIP,' ' ) BM1TP_MOV , "
cquery += CRLF+"        NVL(BM1_CODEVE,' ' ) ||' - '|| NVL(BM1_DESEVE,' ' ) BM1EVENT_MOV, NVL(BM1_CODPLA,' ' ) ||' - '|| NVL(BM1_DESPLA,' ' ) BM1PLANO, "
cquery += CRLF+"        NVL(DECODE( BM1_TIPO, '1', BM1_VALOR , '2', BM1_VALOR *-1, BM1_VALOR ),0 ) BM1VLR_EVENTO , NVL(BM1.R_E_C_N_O_, 0) BM1_RECNO , "
cquery += CRLF+"        SE52.R_E_C_N_O_ SE5_RECNO , SE1.R_E_C_N_O_ SE1_RECNO ,DECODE(TRIM(SE52.E5_CONTA), '' , 'NAO','SIM') MOV_BANCO , "
cquery += CRLF+"        SE52.E5_DOCUMEN E5COMP, SE52.E5_DTDISPO E5DT , se52.e5_labai E5LABX ,se52.e5_SITUACA E52SITUACA , SE51.vlr SE51VLR , "
cquery += CRLF+"        SE51.vlr1 SE51VLR1, SE51.MVvlr SE51MVVLR, SE51.SMVvlr SE51SMVVLR , E1_CODEMP CODEMP "
cquery += CRLF+" FROM  " + RetSqlName("SE1") + " SE1  " 
cquery += CRLF+" INNER JOIN(SELECT E5_PREFIXO , E5_NUMERO , E5_PARCELA , E5_TIPO ,  COUNT(*) QTDA ,  SUM (DECODE( E5_TIPODOC, 'ES', E5_VALOR * 1 , 'DC', E5_VALOR * 1 , E5_VALOR )) VLR , "
/////* TRATA TOTAIS 
cquery += CRLF+"            SUM (CASE WHEN TRIM(E5_CONTA)  is null      THEN    (DECODE( E5_TIPODOC, 'ES', E5_VALOR * -1 ,'DC', E5_VALOR * 1 ,  E5_VALOR )) ELSE 0 end) SMVVLR , "
cquery += CRLF+"            SUM (CASE WHEN TRIM(E5_CONTA)  is not null  THEN    (DECODE( E5_TIPODOC, 'ES', E5_VALOR * -1 ,'DC', E5_VALOR * 1 ,  E5_VALOR )) ELSE 0 END) MVVLR ,"
cquery += CRLF+"            SUM ((DECODE( E5_TIPODOC, 'ES', E5_VALOR * -1 , 'DC', E5_VALOR * 1 , E5_VALOR )) ) vlr1        "
/////      
cquery += CRLF+"              FROM " + RetSqlName("SE5") + " SE5 WHERE SE5.E5_FILIAL = '" + xFilial('SE5') + "' AND SE5.D_E_L_E_T_ = ' ' "  
//ra cmp 
   cQuery += CRLF+"  AND ( SE5.E5_MOTBX NOT IN ('CMP') OR ( SE5.E5_MOTBX IN ('CMP') AND SE5.E5_PREFIXO  NOT IN  ('RAC','AXF','RLE') ) ) "    
///tarta contabiliza็ใo se5

////* TRATA EXCLUSOES 
If cListEst  == 2
   cQuery += CRLF+" AND NOT EXISTS (SELECT NULL FROM " + RetSqlName("SE5") + " SE53 WHERE SE53.E5_FILIAL = '" + xFilial('SE5') + "' AND SE53.E5_PREFIXO = SE5.E5_PREFIXO AND "
   cQuery += CRLF+"                 SE53.E5_NUMERO  = SE5.E5_NUMERO AND SE53.E5_PARCELA = SE5.E5_PARCELA AND "
   cQuery += CRLF+"                 SE53.E5_TIPO    = SE5.E5_TIPO   AND SE53.E5_CLIFOR  = SE5.E5_CLIFOR  AND "
   cQuery += CRLF+"                 SE53.E5_LOJA    = SE5.E5_LOJA   AND SE53.E5_SEQ     = SE5.E5_SEQ     AND "   
   cQuery += CRLF+"                 SE53.E5_DTDISPO = SE5.E5_DTDISPO AND "    
   
   cQuery += CRLF+"               ( TRIM(SE53.E5_TIPODOC) = 'ES'     AND  SE5.E5_TIPODOC IN ('VL' ,'BA' , 'CP') OR  "
   cQuery += CRLF+"                 TRIM(SE5.E5_TIPODOC)  = 'ES'     AND SE53.E5_TIPODOC IN ('VL', 'BA' , 'CP') OR  "   
   cQuery += CRLF+"                 TRIM(SE5.E5_SITUACA)  = 'C'      )    "  
   
//   IF !EMPTY (cDtInicMvB)  .and.  cdtBxMv == 1
//      cquery += CRLF+"          AND   SE53.E5_DTDISPO >='"+cDtInicMvB+"' AND SE53.E5_DTDISPO <='"+cDtFimMvB+"'         
//   EndIf  
   cQuery += CRLF+"               AND      SE53.D_E_L_E_T_ <> '*' ) "                           
EndIf    
////
   If !EMPTY (cTitEsp)                                                                                                                                               
      cQuery += CRLF+" AND trim(SE5.E5_PREFIXO || SE5.E5_NUMERO || SE5.E5_PARCELA || SE5.E5_TIPO)  = '"+trim(cTitEsp)+"'"   
   EndIf    
   IF !EMPTY (cDtInicMvB)                                                                 
         cquery += CRLF+"  AND E5_DTDISPO >='"+cDtInicMvB+"' AND E5_DTDISPO <='"+cDtFimMvB+"'  
   EndIf  
   IF !EMPTY (cPrefSair) 
      cQuery += CRLF+" AND E5_PREFIXO IN "+FormatIn(cPrefSair, ",") 
   EndIf   
   IF !EMPTY (cPNaoSair) 
      cQuery += CRLF+" AND E5_PREFIXO NOT IN "+FormatIn(cPNaoSair, ",") 
   EndIf   
   IF !EMPTY (cMotSair) 
      cQuery += CRLF+" AND E5_MOTBX IN "+FormatIn(cMotSair, ",") 
   EndIf   
   IF !EMPTY (cMNaoSair) 
      cQuery += CRLF+" AND E5_MOTBX NOT IN "+FormatIn(cMNaoSair, ",") 
   EndIf   
   IF !EMPTY (trim(cCodBSai)) 
      cQuery += CRLF+" AND E5_BANCO = '"+trim(cCodBSai)+"'" 
   EndIf   
cquery += CRLF+"             GROUP BY E5_PREFIXO , E5_NUMERO , E5_PARCELA , E5_TIPO  "
cquery += CRLF+"           ) SE51  ON SE51.E5_PREFIXO = SE1.E1_PREFIXO "
cquery += CRLF+"                  AND SE51.E5_NUMERO = SE1.E1_NUM AND  SE51.E5_PARCELA = SE1.E1_PARCELA  AND  SE51.E5_TIPO = SE1.E1_TIPO "       
if nMais1Mov == 2 
   cquery += CRLF+"                  AND SE51.QTDA = 1 "
elseif nMais1Mov == 1 
   cquery += CRLF+"                  AND SE51.QTDA > 1 " 
EndIf               
if nDivVlr == 1
   cquery += CRLF+"                  AND SE51.VLR = E1_VALOR  "
elseif nDivVlr == 2
   cquery += CRLF+"                  AND SE51.VLR > E1_VALOR  "
elseif nDivVlr == 3
   cquery += CRLF+"                  AND SE51.VLR < E1_VALOR  "
EndIF   
cquery += CRLF+" INNER JOIN " + RetSqlName("SE5") + " SE52 ON E1_NUM = SE52.E5_NUMERO AND SE52.E5_FILIAL  = '" + xFilial('SE5') + "' "
cquery += CRLF+"   AND SE52.D_E_L_E_T_ = ' '  AND E1_PREFIXO = SE52.E5_PREFIXO "                    
/// TRATAR POR PARAMENTRO   
   If cMovBanc == 1 
      cquery += CRLF+" AND E5_CONTA <> ' ' "  
   ElseIf cMovBanc == 2 
      cquery += CRLF+" AND E5_CONTA = ' ' "      
   EndIf   
   
   If !EMPTY (cDtInicMvB)  .and. cdtBxMv == 1 
      cquery += CRLF+"       AND SE52.E5_DTDISPO >='"+cDtInicMvB+"' AND SE52.E5_DTDISPO <='"+cDtFimMvB+"'  
    EndIf   
      
   If !EMPTY (cPrefSair) 
      cQuery += CRLF+" AND SE52.E5_PREFIXO IN "+FormatIn(cPrefSair, ",") 
   EndIf   
   IF !EMPTY (cPNaoSair) 
      cQuery += CRLF+" AND SE52.E5_PREFIXO NOT IN "+FormatIn(cPNaoSair, ",") 
   EndIf   
   IF !EMPTY (cMotSair) 
      cQuery += CRLF+" AND SE52.E5_MOTBX IN "+FormatIn(cMotSair, ",") 
   EndIf   
   IF !EMPTY (cMNaoSair) 
      cQuery += CRLF+" AND SE52.E5_MOTBX NOT IN "+FormatIn(cMNaoSair, ",") 
   EndIf                                                                                          
//* CMP 'RAC','AXF','RLE'    
   cQuery += CRLF+"  AND ( SE52.E5_MOTBX NOT IN ('CMP', 'CEC') OR ( SE52.E5_MOTBX IN ('CMP','CEC') AND SE52.E5_PREFIXO  NOT IN  ('RAC','AXF','RLE') ) ) "
///   
cquery += CRLF+"   AND E1_PARCELA = SE52.E5_PARCELA  AND E1_TIPO = SE52.E5_TIPO AND E1_CLIENTE = SE52.E5_CLIFOR "                                
cquery += CRLF+"  LEFT JOIN " + RetSqlName("BM1") + " BM1 ON BM1.BM1_FILIAL = '" + xFilial('BM1') + "'  AND SE1.E1_PREFIXO = BM1.BM1_PREFIX "
cquery += CRLF+"   AND SE1.E1_NUM = BM1.BM1_NUMTIT AND SE1.E1_TIPO    = BM1.BM1_TIPTIT "
//TRATA REEMBOLSO LIVRE ESCOLHA NAO TRAZ
cquery += CRLF+"   AND BM1.BM1_CODTIP <> '108' "
////
cquery += CRLF+"   AND SE1.E1_PARCELA = BM1.BM1_PARCEL  AND BM1.D_E_L_E_T_ = ' ' "
cquery += CRLF+"  WHERE SE1.E1_FILIAL = '" + xFilial('SE1') + "'  AND SE1.D_E_L_E_T_ = ' '  "
   If !EMPTY (cPrefSair) 
      cQuery += CRLF+" AND SE1.E1_PREFIXO IN "+FormatIn(cPrefSair, ",") 
   EndIf   
   If !EMPTY (cPNaoSair) 
      cQuery += CRLF+" AND SE1.E1_PREFIXO NOT IN "+FormatIn(cPNaoSair, ",") 
   EndIf  
////excluida da sele็ใo os convenios   -- incluido o cliente 046366 - que e da empresa -352 - chamado 67645 - verificar como fazer na integral
If cListConv      == 1 .AND. cEmpresa == 'C'                    
   cQuery += CRLF+" AND SE1.E1_CLIENTE NOT IN ('000003','000004','000005','039387','000007','000008','000010','000009','000011','000012', "
   cQuery += CRLF+"                            '000013','000014','000015','000016','000017','000018','000019','000020','000021','029189','030238')" 
ElseIf cListConv  == 2 .AND. cEmpresa == 'C'                    
   cQuery += CRLF+" AND SE1.E1_CLIENTE  IN ('000003','000004','000005','039387','000007','000008','000010','000009','000011','000012', "
   cQuery += CRLF+"                            '000013','000014','000015','000016','000017','000018','000019','000020','000021','029189','030238')" 
EndIf    
    
If cListEst  == 2
   cQuery += CRLF+" AND NOT EXISTS (SELECT NULL FROM " + RetSqlName("SE5") + " SE53 WHERE SE53.E5_FILIAL = '" + xFilial('SE5') + "' AND SE53.E5_PREFIXO = SE52.E5_PREFIXO AND "
   cQuery += CRLF+"                 SE53.E5_NUMERO  = SE52.E5_NUMERO AND SE53.E5_PARCELA = SE52.E5_PARCELA AND "
   cQuery += CRLF+"                 SE53.E5_TIPO    = SE52.E5_TIPO   AND SE53.E5_CLIFOR  = SE52.E5_CLIFOR  AND "
   cQuery += CRLF+"                 SE53.E5_LOJA    = SE52.E5_LOJA   AND SE53.E5_SEQ     = SE52.E5_SEQ     AND " 
   cQuery += CRLF+"                 SE53.E5_DTDISPO = SE52.E5_DTDISPO AND "   
     
   cQuery += CRLF+"                ( TRIM(SE53.E5_TIPODOC) = 'ES'     AND SE52.E5_TIPODOC IN ('VL' , 'BA' , 'CP') OR  "
   cQuery += CRLF+"                  TRIM(SE52.E5_TIPODOC) = 'ES'     AND SE53.E5_TIPODOC IN ('VL' , 'BA' , 'CP') OR  "   
   cQuery += CRLF+"                  TRIM(SE52.E5_SITUACA) = 'C'      )    "  
   
  IF !EMPTY (cDtInicMvB)  .and.  cdtBxMv = 1
     cquery += CRLF+"          AND   SE53.E5_DTDISPO >='"+cDtInicMvB+"' AND SE53.E5_DTDISPO <='"+cDtFimMvB+"'         
  EndIf  
   cQuery += CRLF+"              AND   SE53.D_E_L_E_T_ <> '*' )  "          
EndIf                                        
   cquery += CRLF+"  ORDER BY 1,3,2,23,24,15,18 " //1,27,2,3,23,24,15,18 -- 1,26,2,3,15,18  "  
                              
////////////
   	
    If Select((cAliastmp)) <> 0 
       (cAliastmp)->(DbCloseArea()) 
    Endif
  
    TCQuery cQuery New Alias (cAliastmp)  
    
    dbSelectArea(cAliastmp)
   
    (cAliastmp)->(dbGoTop())   
                                                                                                                 
    While (cAliastmp)->(!Eof())        
     cPrefCm       := ' '    
     cPrefCmp      := ' '        
     lContMov      := .T. 
     lContTit      := .F.
                                  
       
     If ( substr((cAliastmp)->E1IDENT_TIT,14,02) == 'PR' )
        cTipo := substr((cAliastmp)->E1IDENT_TIT,14,03) 
     Else    
        cTipo := ' ' 
     EndIf   
     If substr((cAliastmp)->E1IDENT_TIT,1,03) = 'PLS'
        cprefixo := 'PLS'      
     Else 
        cprefixo := substr((cAliastmp)->E1IDENT_TIT,1,03)                                                          
     EndIf    
     
     If (nAscan:=Ascan(aRecnoE1 , {|e| e[1] == (cAliastmp)->SE1_RECNO})) == 0 
         ccont:=0
     EndIf              

     If (nAscan:=Ascan(aRecnoE1 , {|e| e[1] == (cAliastmp)->SE1_RECNO})) == 0 .and. (cContab == 3 .OR. (cAliastmp)->E1labx == lcontabiliza )    	                
         aaDD(aRecnoE1,{(cAliastmp)->SE1_RECNO })             
       	 lE1ok := .T. 
       	 lMARKBM1 := .F.  
     Else              
       	 lE1ok  := .F.
     EndIf  
     if substr((cAliastmp)->E1IDENT_TIT,1,15) != cNumTit
        cVlAnt  := Val_salbaixa( substr((cAliastmp)->E1IDENT_TIT,1,15), (cAliastmp)->E5DT)         
        cNumTit := substr((cAliastmp)->E1IDENT_TIT,1,15) 
     EndIf    
     
     If ((nAscan:=Ascan(aRecnoBM1 , {|e| e[1] == (cAliastmp)->BM1_RECNO})) == 0 ) .and. ((cAliastmp)->BM1_RECNO != 0) .AND. lMARKBM1 = .F. .and. (cContab == 3 .OR. (cAliastmp)->E1labx == lcontabiliza )  .and. cVlAnt == 0.00   ;
    //      .and. (cAliastmp)->E5MOT_BX  $ ('NOR')   // 1 BAIXA POR COMPENSAO 2 BAIXA NORNAL - 19/08/14 - VALIDAR 
          aaDD(aRecnoBM1,{(cAliastmp)->BM1_RECNO })            
      	  lBM1ok   := .T.  
      	  lContTit := .T.
     Else              
          lBM1ok   := .F.            
          lContTit := .F.
     EndIf   
                 
     If ((nAscan:=Ascan(aRecnoE5 , {|e| e[1] == (cAliastmp)->SE5_RECNO})) == 0 ) .and. ((cAliastmp)->SE5_RECNO != 0) .and. (cContab == 3 .OR. (cAliastmp)->E5labx == lcontabiliza )          
          aaDD(aRecnoE5,{(cAliastmp)->SE5_RECNO })             
       	  lE5ok := .T. 
       	  if (!empty((cAliastmp)->E5CONTA)  .and. (cAliastmp)->E5MOT_BX  == 'NOR' .AND. (cAliastmp)->E5TP_DOC == 'BA')
       	     cCont++                                                                                                 
       	  EndIf   
     Else              
       	  lE5ok := .F.
     EndIf         
//(cAliastmp)->MOV_BANCO
     If ((lE5ok) .or. (lE1ok) .or. (lBM1ok)) .and. (cContab == 3 .OR. (cAliastmp)->E1labx == lcontabiliza .or. (cAliastmp)->E5labx == lcontabiliza)    	        
   	      cE1IDENT_TIT     := substr((cAliastmp)->E1IDENT_TIT,1,15)     	   
         If lE1ok      
	        cE1VLR_TIT     := (cAliastmp)->E1VLR_TIT          
	        cE1SLD_TIT	   := (cAliastmp)->E1VLR_TIT  - (cAliastmp)->SE51VLR - cVlAnt           
	        cE1ORIGEM	   := substr((cAliastmp)->E1ORIGEM,1,8)  
	        cE1LaBx        := Iif((cAliastmp)->E1LABX == 'T', 'SIM', 'NรO')             
	     Else                                                                 
   		    cE1VLR_TIT     := 0.00          
		    cE1SLD_TIT	   := 0.00
		    cE1ORIGEM	   := ' '     
		    cE1LaBx        := Iif((cAliastmp)->E1LABX == 'T', 'SIM', 'NรO')          
         EndIf  
//         if cE1SLD_TIT != 0   .and. ((cAliastmp)->SE51MVVLR > 0   .or. (cAliastmp)->E5MOT_BX == 'FAT')       
         if (cE1SLD_TIT ) != 0   .and. ((cAliastmp)->SE51MVVLR > 0  .or. cVlAnt == 0 .or. (cAliastmp)->E5MOT_BX $ 'FAT|CEC')   
            Geralncex(cE1SLD_TIT)              
  	        cE1VLR_TIT     := 0.00            		    
         EndIf            	
		 if lE5ok        
		    cAbate         := 0.00                                                 
		    cjuros         := 0.00      
  		    iF (cAliastmp)->E5MOT_BX $ "REE"                       
		        cjuros := (ValJuros('2',(cAliastmp)->E1IDENT_TIT))  
 		        If cjuros > 0
		           Geralncex(cjuros)       
		           cE1VLR_TIT     := 0.00                                         
		        EndIf   		        
		    ElseIf (cAliastmp)->E5MOT_BX $ "CMP|BNF|FAT|CEC"      
		        cPrefCmp := substr((cAliastmp)->E5COMP,1,03)      
//		         If ((cAliastmp)->E1VLR_TIT  - Val_salcmp( cE1IDENT_TIT , (cAliastmp)->E5DT ) == 0)  .AND. lMARKBM1 == .F. -- 19/08/14 
                  If (((cAliastmp)->E1VLR_TIT  - Val_salcmp( cE1IDENT_TIT , (cAliastmp)->E5DT ) == 0) .or. cVlAnt == 0) .AND. lMARKBM1 == .F.    
                    lBM1ok        := .T.       
                    lContTit      := .T.
                Else             
                    lBM1ok        := .F.    
                    lMARKBM1      := .T.     
                    lContTit      := .F.
                EndIf    
            EndIf                
           cE5VLR_BX_TIT  := ((cAliastmp)->E5VLR_BX_TIT - cjuros )
		    cE5TP_DOC	   := (cAliastmp)->E5TP_DOC             
		    cE5MOT_BX	   := (cAliastmp)->E5MOT_BX            
		    cE5SEQ	       := (cAliastmp)->E5SEQ               
		    cE5BANCO	   := (cAliastmp)->E5BANCO             
		    cE5AGENCIA     := (cAliastmp)->E5AGENCIA            
		    cE5CONTA       := (cAliastmp)->E5CONTA              
		    cE5RECPAG      := (cAliastmp)->E5RECPAG            
		    cMovBanco      := (cAliastmp)->MOV_BANCO           
		    cComp          := substr((cAliastmp)->E5COMP,1,16)
		    cE5Dt          := substr((cAliastmp)->E5DT,7,2)+'/'+substr((cAliastmp)->E5DT,5,2)
		    cE5LaBx        := Iif((cAliastmp)->E5LABX == 'T', 'SIM', 'NรO')                                        
		    cSituaca       := (cAliastmp)->E52SITUACA     
		 Else 
		    cE5VLR_BX_TIT  := 0.00 
   		    cE5TP_DOC	   := (cAliastmp)->E5TP_DOC             
		    cE5MOT_BX	   := (cAliastmp)->E5MOT_BX                 
//		    cE5TP_DOC	   := ' '
//		    cE5MOT_BX	   := ' '            
		    cE5SEQ	       := ' '               
		    cE5BANCO	   := ' '             
		    cE5AGENCIA     := ' '            
		    cE5CONTA       := ' '              
		    cE5RECPAG      := ' '
		    cMovBanco      := (cAliastmp)->MOV_BANCO           		    
//  		cMovBanco      := ' '   
  		    cComp          := ' ' 
  		    cE5Dt          := ' '    
  		    cE5LaBx        := Iif((cAliastmp)->E5LABX == 'T', 'SIM', 'NรO')       
   		    cSituaca       := ' '
         EndIf              
				
	     If lBM1ok   .and. (cAliastmp)->BM1VLR_EVENTO != 0 //.and.((cAliastmp)->E1VLR_TIT  - Val_salcmp( cE1IDENT_TIT , (cAliastmp)->E5DT ) = 0)
		    cBM1TP_MOV	   := substr((cAliastmp)->BM1TP_MOV,1,20)              
		    cBM1PLANO	   := substr((cAliastmp)->BM1PLANO,1,15)  
		    cBM1ITEMC      := substr((cAliastmp)->BM1PLANO,1,04)           
		    cBM1VLR_EVENTO := (cAliastmp)->BM1VLR_EVENTO    
   	        lContTit       := lBM1ok
		 Else           	 
		    cBM1TP_MOV	   := '    Mov. Sem Composi็ใo'              
		    cBM1PLANO	   := ' '
		    cBM1ITEMC      := ' '        
		    cBM1VLR_EVENTO := cE5VLR_BX_TIT     
            lContTit       := lBM1ok		                                          
         EndIf     
         if  cEmpresa == 'C' .AND. (cAliastmp)->E1CLIENTE  $ "000003|000004|000005|039387|000007|000008|000010|000009|000011|000012|000013|000014|000015|000016|000017|000018|000019|000020|000021|029189|030238" 
             cPlano := 'CONV' 
         ElseIf ( ( cEmpresa == 'C' .AND. !empty(cBM1PLANO) ) .and. (SUBSTR(cBM1PLANO,1,04) != '0098' .AND. SUBSTR(cBM1PLANO,1,04) != '0099' .AND. SUBSTR(cBM1PLANO,1,04) != '0136' .AND. SUBSTR(cBM1PLANO,1,04) != '0131' .AND. SUBSTR(cBM1PLANO,1,04) != '0133' .AND. SUBSTR(cBM1PLANO,1,04) != '0134' )   ) ;
          .or.  ( ( cEmpresa == 'I' .AND. !empty(cBM1PLANO) ) .and. (SUBSTR(cBM1PLANO,1,04) != '0088' .AND. SUBSTR(cBM1PLANO,1,04) != '0090' .AND. SUBSTR(cBM1PLANO,1,04) != '0091' .AND. SUBSTR(cBM1PLANO,1,04) != '0092' .AND. SUBSTR(cBM1PLANO,1,04) != '0156' .AND. SUBSTR(cBM1PLANO,1,04) != '0157' .AND. SUBSTR(cBM1PLANO,1,04) != '0170' ) )
            cPlano := '0001'
     //       cPlano := SUBSTR(cBM1PLANO,1,04) 
         Else 
             cPlano := SUBSTR(cBM1PLANO,1,04)    
         EndIf  

		 cBM1PLANO := substr((cAliastmp)->BM1PLANO,1,15)
		 If(cAliastmp)->E5TP_DOC =  'VL' .or. (cAliastmp)->E5TP_DOC = 'BA'
		    ctpdoce5 := 'BA'
 		 Else               
   		    ctpdoce5 := (cAliastmp)->E5TP_DOC
   		    IF (cAliastmp)->E5TP_DOC = 'CP'     
    		    cPrefCmp := substr((cAliastmp)->E5COMP,1,03)
            EndIf                         
		 EndIf   
		// orientado pelo srt. aline a lipar a lista de adminstradora s้ deixando as empresas 0296 e 0373
       // If cEmpAnt == '02' .and. (cAliastmp)->CODEMP $ '0296|0260|0270|0274|0010|0262|0182|0282|0352|0373' 
		  If cEmpAnt == '02' .and. (cAliastmp)->CODEMP $ '0296|0373|0402'
             cTpOpera := 'S' 
          Else                
             cTpOpera := 'N'
          EndIf                         
  	       
 	     cctaval := Val_conta( '2', (cAliastmp)->E5MOT_BX , ctpdoce5 , substr(cBM1TP_MOV,1,4), cPlano, cprefixo , cTipo  , cPrefCmp , cTpDif ,cTpOpera)  
      
            cContaC  := substr(cctaval, 1,30)
            cContaD  := substr(cctaval,31,60)  

         If cCont > 1 .or. (empty (cContaC) .and. empty (cContaD))  
            IF empty (cContaC) 
               cContaC:= 'Sem Conta '+(cAliastmp)->E5MOT_BX + ctpdoce5 + substr(cBM1TP_MOV,1,4) + cPlano + cprefixo + cTipo + cPrefCmp + cTpDif   
               lCritica    := .T.
            EndIf    
            IF empty (cContaD) 
               cContaD:= 'Sem Conta '+(cAliastmp)->E5MOT_BX + ctpdoce5 + substr(cBM1TP_MOV,1,4) + cPlano + cprefixo + cTipo + cPrefCmp + cTpDif   
               lCritica    := .T.
            EndIf   
//altamiro 05/04/14            cBM1VLR_EVENTO := 0.00
		 EndIf       
// altamiro 28/09/2015 - ajuste multiplas baixa na mesma data  cBM1TP_MOV	   := '    Mov. Sem Composi็ใo'
         IF cVlAnt == 0 .and. cBM1TP_MOV == '    Mov. Sem Composi็ใo' .and. !(substr(cE1IDENT_TIT,1,3) $ ('RAC|FAT|TNE|INS|OPM|TOP|ALG|COV'))
            a:='b'
         Else    
//////aki         
         aaDD(aDados,  { cE1IDENT_TIT         ,;
		                 cE1VLR_TIT           ,;
		                 cE1SLD_TIT           ,;  
		                 cE5VLR_BX_TIT        ,;
		                 cE5TP_DOC            ,; 
		                 cE5MOT_BX            ,;
		                 cE5SEQ               ,;
		                 cE5BANCO             ,;
		                 cE5AGENCIA           ,; 
		                 cE5CONTA             ,; 
		                 cE5RECPAG            ,;
		                 cBM1TP_MOV           ,;  
		    	           cBM1PLANO            ,;
			   	         Iif (cBM1VLR_EVENTO < 0 , (cBM1VLR_EVENTO * -1) , cBM1VLR_EVENTO ) ,;
			   	         cE1ORIGEM            ,;
 	            		 cMovBanco            ,;
 	            		 cComp                ,;
 	            		 cE5Dt                ,;
 	            		 cE5LaBx              ,;
 	            		 cSituaca             ,;
 	            		 cContaC              ,;     
                         cContaD    		  ,;
                         cE1LaBx              ,;
                         cBM1ITEMC            ,;
                      (cAliastmp)->SE1_RECNO ,; 
                      (cAliastmp)->SE5_RECNO ,; 
                      (cAliastmp)->BM1_RECNO ,;
                         lContMov            ,;
                         lContTit            ,;
                         (cAliastmp)->CODEMP})                
	
		      fResumo()     
  		   EndIf	 
	    EndIf	  	       
       (cAliastmp)->(dbSkip())  
          
     EndDo                                                          
     ASort(aDados1 , , , {|x,y|x[1]+x[3]+x[2]       < y[1]+y[3]+y[2]})    
     ASort(aDados2 , , , {|x,y|x[2]+x[1]            < y[2]+y[1]})    
     ASort(aDados3 , , , {|x,y|x[1]+x[2]+x[3]       < y[1]+y[2]+y[3]})  
     ASort(aDados4 , , , {|x,y|x[1]+x[2]+x[4]+x[3]  < y[1]+y[2]+y[4]+y[3]})               
     ASort(aDados5 , , , {|x,y|x[1]+x[2]+x[3]       < y[1]+y[2]+y[3]})     
     ASort(aDados6 , , , {|x,y|x[1]+x[2]+x[3]       < y[1]+y[2]+y[3]})    
Return   
*************************************************************************************************************  
Static Function fResumo                 

   If (nAscan:=Ascan(aDados1 , {|e| e[1]+e[2]+e[3]+e[4]+e[5] == substr(cE1IDENT_TIT,1,3)+cBM1TP_MOV + cBM1PLANO + cContaC + cContaD})) == 0           
                aaDD(aDados1,{substr(cE1IDENT_TIT,1,3),;
                                     cBM1TP_MOV        ,;  
	   	                             cBM1PLANO         ,;
	   	                             cContaC           ,;     
                                     cContaD           ,;  
                                     Iif (cBM1VLR_EVENTO < 0 , (cBM1VLR_EVENTO * -1) , cBM1VLR_EVENTO ) })                                         
   Else 
    	             aDados1[nAscan,6]+= Iif (cBM1VLR_EVENTO < 0 , (cBM1VLR_EVENTO * -1) , cBM1VLR_EVENTO ) 
   EndIf  
		                 
 //  if  lE5ok       
       If (nAscan:=Ascan(aDados2 , {|e| e[1]+e[2]+e[3]+e[4] == cE5TP_DOC + cE5MOT_BX +cContaC+cContaD })) == 0           
                     aaDD(aDados2,{cE5TP_DOC            ,; 
		                           cE5MOT_BX            ,;
		                           cContaC              ,;     
                                   cContaD              ,; 
                                   Iif (cBM1VLR_EVENTO < 0 , (cBM1VLR_EVENTO * -1) , cBM1VLR_EVENTO ) })                                                        
       Else 
	                      aDados2[nAscan,5]+= Iif (cBM1VLR_EVENTO < 0 , (cBM1VLR_EVENTO * -1) , cBM1VLR_EVENTO )                                           
       EndIf    

       If (nAscan:=Ascan(aDados3 , {|e| e[1]+e[2]+e[3] == cContaC + cBM1ITEMC+ "C" })) == 0                   
                    aaDD(aDados3,{cContaC              ,;     
	   	                          cBM1ITEMC            ,;
                                  "C"                  ,;
                                  Iif (cBM1VLR_EVENTO < 0 , (cBM1VLR_EVENTO * -1) , cBM1VLR_EVENTO ) })                                            
       Else 
        	             aDados3[nAscan,4]+= Iif (cBM1VLR_EVENTO < 0 , (cBM1VLR_EVENTO * -1) , cBM1VLR_EVENTO )                                           
       EndIf   
       If (nAscan:=Ascan(aDados3 , {|e| e[1]+e[2]+e[3] == cContaD + cBM1ITEMC+ "D" })) == 0                   
                    aaDD(aDados3,{cContaD              ,;     
	   	                          cBM1ITEMC            ,;
                                  "D"                  ,;
                                  Iif (cBM1VLR_EVENTO < 0 , (cBM1VLR_EVENTO * -1) , cBM1VLR_EVENTO ) })                                   
       Else 
        	             aDados3[nAscan,4]+= Iif (cBM1VLR_EVENTO < 0 , (cBM1VLR_EVENTO * -1) , cBM1VLR_EVENTO )    
       EndIf  
		       
       If (nAscan:=Ascan(aDados4 , {|e| e[1]+e[2]+e[3]+e[4]+e[5]+e[6]  == cE5RECPAG +substr(cE1IDENT_TIT,1,3) + cE5TP_DOC + cE5MOT_BX+cContaC+cContaD})) == 0           
                    aaDD(aDados4,{cE5RECPAG            ,;
                           substr(cE1IDENT_TIT,1,3)    ,;
                                  cE5TP_DOC            ,; 
    	                          cE5MOT_BX            ,;
	   	                          cContaC              ,;     
                                  cContaD              ,;
                                  Iif (cBM1VLR_EVENTO < 0 , (cBM1VLR_EVENTO * -1) , cBM1VLR_EVENTO ) })                                                         
       Else 
     	            aDados4[nAscan,7]+= Iif (cBM1VLR_EVENTO < 0 , (cBM1VLR_EVENTO * -1) , cBM1VLR_EVENTO )                                             
       EndIf        
		       
       If (nAscan:=Ascan(aDados5 , {|e| e[1]+e[2]+e[3]+e[4]+e[5] == cMovBanco + cE5TP_DOC + cE5MOT_BX+cContaC+cContaD})) == 0           
                    aaDD(aDados5,{cMovBanco            ,; 
                                  cE5TP_DOC            ,; 		                     
    	                          cE5MOT_BX            ,;
			   	                  cContaC              ,;     
                       			  cContaD              ,;
                       			  Iif (cBM1VLR_EVENTO < 0 , (cBM1VLR_EVENTO * -1) , cBM1VLR_EVENTO ) })                                                         
       Else 
	                aDados5[nAscan,6]+= Iif(cBM1VLR_EVENTO < 0 , (cBM1VLR_EVENTO * -1) , cBM1VLR_EVENTO )
       EndIf    
 //  EndIf	 
		   
       If (nAscan:=Ascan(aDados6 , {|e| e[1]+e[2]+e[3] == cContaC + cContaD + cBM1ITEMC })) == 0                   
                 aaDD(aDados6,{cContaC              ,; 
                               cContaD              ,;    
    	                       cBM1ITEMC            ,;
                               Iif(cBM1VLR_EVENTO < 0 , (cBM1VLR_EVENTO * -1) , cBM1VLR_EVENTO ) })                
       Else 
       	         aDados6[nAscan,4]+= Iif(cBM1VLR_EVENTO < 0 , (cBM1VLR_EVENTO * -1) , cBM1VLR_EVENTO )  
       EndIf          

Return   
*************************************************************************************************************  
Static Function fGeraRel2

Local oReport 
Private cPerg		:= "cabr133"  
Private aOrdem 		:= {}//{'RDA','Ano/Mes'}


oReport:= ReportDef2()
oReport:PrintDialog()

Return                          

////////////////////////////////////////////////////   
Static Function Geralncex(cvalor)  
       cBM1VLR_EVENTO := cvalor
       // orientado pelo srt. aline a lipar a lista de adminstradora s้ deixando as empresas 0296 e 0373
       // If cEmpAnt == '02' .and. (cAliastmp)->CODEMP $ '0296|0260|0270|0274|0010|0262|0182|0282|0352|0373' 
        If cEmpAnt == '02' .and. (cAliastmp)->CODEMP $ '0296|0373|0402'
          cTpOpera := 'S' 
       Else                
          cTpOpera := 'N'
       EndIf   
       
       if cE1SLD_TIT  != 0            
   		    cE5VLR_BX_TIT  := (cE1SLD_TIT   )      
		    cE5TP_DOC	   := 'DIF' 
		    cE5MOT_BX	   := (cAliastmp)->E5MOT_BX      
		    cTpDif   	   := Iif ((cE1SLD_TIT )  < 0 , 'MAIOR' , 'MENOR')  
	
            cE1SLD_TIT  := Iif ((cE1SLD_TIT ) < 0 , (cE1SLD_TIT  * -1) , cE1SLD_TIT  )
            cHistDesc   := '    Dif. Bxa a ' + cTpDif   		       
	        
	       If (cAliastmp)->E1CLIENTE  $ "000003|000004|000005|039387|000007|000008|000010|000009|000011|000012|000013|000014|000015|000016|000017|000018|000019|000020|000021|029189|030238" 
               cPlano := 'CONV' 
           Else          
               cPlano         := '    ' 
           EndIf   
       EndIf    
       if (cAliastmp)->E5MOT_BX   == 'CMP'               
   		  cPrefCmp := substr((cAliastmp)->E5COMP,1,03)     
       EndIf       
       if (cAliastmp)->E5MOT_BX   $ ("REE|NEG")               
   		   cE5VLR_BX_TIT  := cvalor      
		      cE5TP_DOC	   := 'JUR'
            cE5MOT_BX	   := (cAliastmp)->E5MOT_BX               
            cHistDesc      := '    Juros Ref. Parcelamento'    		       
	                                                                      
	       If (cAliastmp)->E1CLIENTE  $ "000003|000004|000005|039387|000007|000008|000010|000009|000011|000012|000013|000014|000015|000016|000017|000018|000019|000020|000021|029189|030238" 
               cPlano := 'CONV'
               // altamiro - 29/09/2021 ajuste solicitado pela aline contabilidade 
               If cE5TP_DOC  == 'JUR'
                  cE5TP_DOC  := 'DIF'
                  cHistDesc  := '    Diferen็a de baixa convenio '   
               EndIf   
           Else          
               cPlano         := '    ' 
           EndIf   
       EndIf    

            cctaval := Val_conta( '2', subst(cE5MOT_BX,1,3) , subst(cE5TP_DOC,1,3),' ' , cPlano ,cPrefixo , cTipo , cPrefCmp , cTpDif ,cTpOpera )    
              
                cContaC := substr(cctaval, 1,30)
                cContaD := substr(cctaval,31,60)
		    
		      cE5SEQ	     := '00'               
		      cE5BANCO	     := ' '             
		      cE5AGENCIA     := ' '            
		      cE5CONTA       := ' '              
		      cE5RECPAG      := ' '        
  	          cBM1TP_MOV     := cHistDesc 
		      cBM1PLANO      := ' ' 
		      If cCont > 1 .or. (empty (cContaC) .and. empty (cContaD))
                 cBM1VLR_EVENTO := 0.00
		      Else  
	             cBM1VLR_EVENTO := cE5VLR_BX_TIT    
	          EndIf    
			  cE1ORIGEM      := ' ' 
		      cMovBanco      := 'Nใo'          
		      cComp          := ' ' 
		      cE5Dt          := '00/00'
		      cE5LaBx        := 'NรO' 
   		   cE1LaBx        := 'NรO'
		      cSituaca       := ' '  
		      cBM1ITEMC      := ' ' 
		      cTpDif         := ' '    
		      aaDD(aDados,{ cE1IDENT_TIT         ,;      
		                    cE1VLR_TIT           ,;  
		                    cE1SLD_TIT           ,;  
		                    cE5VLR_BX_TIT        ,;
		                    cE5TP_DOC            ,;  
		                    cE5MOT_BX            ,;  
		                    cE5SEQ               ,;  
		                    cE5BANCO             ,;  
		                    cE5AGENCIA           ,;  
		                    cE5CONTA             ,;  
		                    cE5RECPAG            ,;  
 	                        cBM1TP_MOV           ,;
			   	            cBM1PLANO            ,;  
		   	            	Iif (cBM1VLR_EVENTO < 0 , (cBM1VLR_EVENTO * -1) , cBM1VLR_EVENTO ) ,;
			   	            cE1ORIGEM            ,;  
 	            		    cMovBanco            ,;  
 	            		    cComp                ,;
 	            		    cE5Dt                ,;
 	            		    cE5LaBx              ,;
 	            		    cSituaca             ,;
	            		    cContaC              ,;     
                            cContaD    		     ,;
                            cE1LaBx              ,;
                            cBM1ITEMC            ,;
                          (cAliastmp)->SE1_RECNO ,; 
                          (cAliastmp)->SE5_RECNO ,; 
                          (cAliastmp)->BM1_RECNO ,;
                            lContMov             ,;
                            lContTit             ,;
                            (cAliastmp)->CODEMP})
       fResumo()                          
 RETURN ()           	
///////////////////////////////////////////////////

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณvalcpf    บaltamiroณCaberj             บ Data ณ  21/12/11   บฑฑ                        
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Verifica se a duplicidade de CPF para matricula passada    บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/  
Static Function ValJuros(cOrigem , titulo )  
                   
local  cCconta := ' '           
local  cPrefzg := substr(titulo,1,3) 
local  cTitZg  := substr(titulo,4,9)
If  cOrigem = '2'      
    
    cQuery := CRLF+" SELECT DISTINCT ZG_VLTOTAL ZGVLTOT , ZG_VLPRESE ZGVLPRES , ZG_VALOR ZGVL ,ZG_VALOR-ZG_VLPRESE JUROS   "
    cQuery += CRLF+" FROM " + RetSqlName("SZH") + " SZH , " + RetSqlName("SZG") + " SZG "
    cQuery += CRLF+" WHERE ZH_FILIAL = '" + xFilial('SZH') + "' AND SZH.D_E_L_E_T_ = ' ' AND ZH_PREFIXO = '"+cPrefzg+"' AND ZH_NUM = '"+cTitZg+"' "
    cQuery += CRLF+" AND ZG_FILIAL = '" + xFilial('SZG') + "' AND SZG.D_e_l_e_t_ = ' ' AND ZG_CODIGO = ZH_CODIGO "
      	   
    If Select((cAliasszh)) <> 0 
       (cAliasszh)->(DbCloseArea()) 
    Endif
    TCQuery cQuery New Alias (cAliasszh)  
    dbSelectArea(cAliasszh)
    (cAliasszh)->(dbGoTop())  	   
    If (cAliasszh)->(!Eof()) 	                                                                                                              
       Ret := space(21 - len(str((cAliasszh)->ZGVLTOT))) + str((cAliasszh)->ZGVLTOT)   + ;  
           space(21 - len(str((cAliasszh)->ZGVLPRES))) + str((cAliasszh)->ZGVLPRES) + ; 
           space(21 - len(str((cAliasszh)->ZGVL))) + str((cAliasszh)->ZGVL)         + ;   
           space(21 - len(str((cAliasszh)->JUROS))) + str((cAliasszh)->JUROS) 
       Ret :=((cAliasszh)->JUROS)         
    else 
       Ret :=0.00   
    EndIf                                                                                                                                      
EndIf

Return ret         

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณvalcpf    บaltamiroณCaberj             บ Data ณ  21/12/11   บฑฑ                        
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Verifica se a duplicidade de CPF para matricula passada    บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/  
Static Function Val_conta( cOrigem, cMbx, cTpdc , cTplc, cPl, cPref, cTip, cPrefCm , cTpDf , cTpOpera)  
                   
local  cConta:= ' '    
   If  cOrigem = '2'                                           
       cQuery := CRLF+" SELECT ZUI_CTADEB CTADEB, ZUI_CTACRE CTACRE  FROM " + RetSqlName("ZUI") + " ZUI WHERE zui_FILIAL = '" + xFilial('ZUI') + "' "
	   cQuery += CRLF+" AND ZUI_CODTIP = '"+cTplc+"' AND ZUI_CODPLA = '"+cPl+"'"      
	                          
	   cQuery += CRLF+" AND ZUI_TPLANC = '"+cTpOpera+"'"  
	                          
	   cQuery += CRLF+" AND ZUI_MOTBX = '"+ cMbx +" ' AND ZUI_TPDOC = '"+cTpdc+"' AND D_e_l_e_t_ = ' ' "      
  	   if !empty(cPref)
    	   cQuery += CRLF+" AND ZUI_PREFIX = '"+cPref+"'
       EndIf  

       if !empty(cTip)
    	   cQuery += CRLF+" AND ZUI_TPTIT = '"+cTip+"'
       EndIf          
       
       if !empty(cPrefCm)
    	   cQuery += CRLF+" AND ZUI_prefcp = '"+cPrefCm+"'
       EndIf          
       
       if !empty(cTpDf)
    	   cQuery += CRLF+" AND ZUI_TPDIF = '"+cTpDf+"'
       EndIf          

        cQuery += CRLF+"  AND ZUI_CTBBX  <> 'N' "
       	   
       If Select((cAliastmp1)) <> 0 
         (cAliastmp1)->(DbCloseArea()) 
       Endif
       TCQuery cQuery New Alias (cAliastmp1)  
       dbSelectArea(cAliastmp1)
      (cAliastmp1)->(dbGoTop())  		                                                                                                              
       If (cAliastmp1)->(!Eof())  
           cContaC := (cAliastmp1)->CTACRE  + space(30 - len((cAliastmp1)->CTACRE ))
           cContaD := (cAliastmp1)->CTADEB  + space(30 - len((cAliastmp1)->CTADEB ))
//    	   cContaC := (cAliastmp1)->CTACRE 
//		   cContaD := (cAliastmp1)->CTADEB     
       Else
 	         cContaC := cTplc+"-" + cPl + "-"+ cMbx +"-"+cTpdc+"-"+cPref +"-" + cTip + cPrefCm + space(30 - len(cTplc+"-" + cPl + "-"+ cMbx +"-"+cTpdc+"-"+cPref +"-" + cTip + "-" + cprefcm) )
           cContaD := cTplc+"-" + cPl + "-"+ cMbx +"-"+cTpdc+"-"+cPref +"-" + cTip + cPrefCm + space(30 - len(cTplc+"-" + cPl + "-"+ cMbx +"-"+cTpdc+"-"+cPref +"-" + cTip + "-" + cprefcm) )
           lContMov:= .F.            
           lContTit:= .F.     
           lCritica:= .T.
       EndIf                            
	   If  trim(cContac) == 'BANCO' .or. trim(cContad) == 'BANCO'                    
	       cQuery := CRLF+" select a6_conta e6conta from " + RetSqlName("SA6") + " SA6 "
	       cQuery += CRLF+" where a6_filial = '" + xFilial('SA6') + "' and d_E_L_E_T_ = ' ' 
	       cQuery += CRLF+" and a6_cod = '"+ (cAliastmp)->E5BANCO +" ' "
           cQuery += CRLF+" and a6_agencia = '"+ (cAliastmp)->E5AGENCIA +" 'and a6_numcon = '"+ (cAliastmp)->E5CONTA +" ' "    
           If Select((cAliassa6)) <> 0 
             (cAliassa6)->(DbCloseArea()) 
           Endif
           TCQuery cQuery New Alias (cAliassa6)  
           dbSelectArea(cAliassa6)
          (cAliassa6)->(dbGoTop())  
          If (cAliassa6)->(!Eof())             
             if trim(cContaC) == 'BANCO' 
                cContaC := (cAliassa6)->e6conta  + space(30 - len((cAliassa6)->e6conta))   
             EndIf      
             if trim(cContaD) == 'BANCO' 
                cContaD := (cAliassa6)->e6conta  + space(30 - len((cAliassa6)->e6conta))   
             EndIf      
         EndIf   
       EndIf    
       If trim(cContaC) == 'CONV' .or. trim(cContaD) == 'CONV'    
	       cQuery := CRLF+" select a1_xctbcon a1conta from " + RetSqlName("SA1") + " SA1 "
	       cQuery += CRLF+" where a1_filial = ' ' and d_E_L_E_T_ = ' ' 
	       cQuery += CRLF+" and a1_cod = '"+ (cAliastmp)->E1CLIENTE +"'"    
           If Select((cAliassa1)) <> 0 
             (cAliassa1)->(DbCloseArea()) 
           Endif
           TCQuery cQuery New Alias (cAliassa1)  
           dbSelectArea(cAliassa1)
           (cAliassa1)->(dbGoTop())
           If (cAliassa1)->(!Eof())                
              if trim(cContaC) == 'CONV' 
                 cContaC := (cAliassa1)->a1conta + space(30 - len((cAliassa1)->a1conta))   
              EndIf
              if trim(cContaD) == 'CONV'                                                         
                 cContaD := (cAliassa1)->a1conta + space(30 - len((cAliassa1)->a1conta))
              Endif  			      
           EndIf   
	   EndIf   

       Ret := cContaC+cContaD
   Else                       
      Ret := space(60)
   EndIf              

Return Ret         
                   

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณvalscmp   บaltamiroณCaberj             บ Data ณ  21/12/11   บฑฑ                        
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Verifica saldo da compensa็ใo                              บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/ 
Static Function Val_salcmp( cTitulo , cDtDisp)              
	cquery := CRLF+" SELECT E5_PREFIXO , E5_NUMERO , E5_PARCELA , E5_TIPO , COUNT(*) QTDA , SUM (DECODE( E5_TIPODOC,'ES', E5_VALOR * -1 ,'DC', E5_VALOR * -1 , E5_VALOR )) VLR ,  "
	cquery += CRLF+"        SUM (CASE WHEN TRIM(E5_CONTA)  is null      THEN    (DECODE( E5_TIPODOC, 'ES', E5_VALOR * -1 ,'DC', E5_VALOR * -1 , E5_VALOR )) ELSE 0 end) MVVLR ,  "
	cquery += CRLF+"        SUM (CASE WHEN TRIM(E5_CONTA)  IS NOT NULL  THEN    (DECODE( E5_TIPODOC, 'ES', E5_VALOR * -1 ,'DC', E5_VALOR * -1 , E5_VALOR )) ELSE 0 END) SMVVLR , "
	cquery += CRLF+"        SUM ((DECODE( E5_TIPODOC, 'ES', E5_VALOR * -1 ,'DC', E5_VALOR * -1 , E5_VALOR )) ) vlr1            "
	cquery += CRLF+"   FROM " + RetSqlName("SE5") + " SE5 WHERE SE5.E5_FILIAL ='" + xFilial('SE5') + "' AND SE5.D_E_L_E_T_ = ' '                                      "
	cquery += CRLF+"        AND TRIM(SE5.E5_PREFIXO || SE5.E5_NUMERO || SE5.E5_PARCELA || SE5.E5_TIPO)  = trim('"+cTitulo+"')  "
	cquery += CRLF+"        AND SE5.E5_DTDISPO <='"+cDtDisp+"' AND TRIM(SE5.E5_MOTBX) <>  'NOR' "  
	cquery += CRLF+"        AND SE5.E5_PREFIXO NOT IN ('RLE','AXF', 'RAC') "
	cquery += CRLF+"      GROUP BY E5_PREFIXO , E5_NUMERO , E5_PARCELA , E5_TIPO "
	cquery += CRLF+"      ORDER BY E5_PREFIXO , E5_NUMERO , E5_PARCELA , E5_TIPO "    

	If Select((cAliassa52)) <> 0 
         (cAliassa52)->(DbCloseArea()) 
    Endif
    TCQuery cQuery New Alias (cAliassa52)  
    dbSelectArea(cAliassa52)
    (cAliassa52)->(dbGoTop())  		                                                                                                              
    If (cAliassa52)->(!Eof())  
        Ret:= (cAliassa52)->VLR   
    Else                        
        Ret:=0
    EndIf
             
return ret
/********************************************************************************************************************************/
Static Function Val_salbaixa( cTitulo , cDtDisp)              
	cquery := CRLF+" SELECT E5_PREFIXO , E5_NUMERO , E5_PARCELA , E5_TIPO , COUNT(*) QTDA , SUM (DECODE( E5_TIPODOC,'ES', E5_VALOR * -1 ,'DC', E5_VALOR * -1 , E5_VALOR )) VLR ,  "
	cquery += CRLF+"        SUM (CASE WHEN TRIM(E5_CONTA)  is null      THEN    (DECODE( E5_TIPODOC, 'ES', E5_VALOR * -1 ,'DC', E5_VALOR * -1 , E5_VALOR )) ELSE 0 end) MVVLR ,  "
	cquery += CRLF+"        SUM (CASE WHEN TRIM(E5_CONTA)  IS NOT NULL  THEN    (DECODE( E5_TIPODOC, 'ES', E5_VALOR * -1 ,'DC', E5_VALOR * -1 , E5_VALOR )) ELSE 0 END) SMVVLR , "
	cquery += CRLF+"        SUM ((DECODE( E5_TIPODOC, 'ES', E5_VALOR * -1 ,'DC', E5_VALOR * -1 , E5_VALOR )) ) vlr1            "
	cquery += CRLF+"   FROM " + RetSqlName("SE5") + " SE5 WHERE SE5.E5_FILIAL ='" + xFilial('SE5') + "' AND SE5.D_E_L_E_T_ = ' '                                      "
	cquery += CRLF+"        AND TRIM(SE5.E5_PREFIXO || SE5.E5_NUMERO || SE5.E5_PARCELA || SE5.E5_TIPO)  = trim('"+cTitulo+"')  "
	cquery += CRLF+"        AND SE5.E5_DTDISPO < '"+cDtDisp+"'"   
	cquery += CRLF+"        AND SE5.E5_PREFIXO NOT IN ('RLE','AXF', 'RAC') "  
	
    cquery += CRLF+" AND NOT EXISTS (SELECT NULL FROM SE5010 SE53 WHERE SE53.E5_FILIAL = '01' AND SE53.E5_PREFIXO = SE5.E5_PREFIXO "
    cquery += CRLF+"                    AND SE53.E5_NUMERO  = SE5.E5_NUMERO  AND SE53.E5_PARCELA = SE5.E5_PARCELA "
    cquery += CRLF+"                    AND SE53.E5_TIPO    = SE5.E5_TIPO    AND SE53.E5_CLIFOR  = SE5.E5_CLIFOR  "
    cquery += CRLF+"                    AND SE53.E5_LOJA    = SE5.E5_LOJA    AND SE53.E5_SEQ     = SE5.E5_SEQ     "
    cquery += CRLF+"                    AND SE53.E5_DTDISPO = SE5.E5_DTDISPO "
    cquery += CRLF+"                    AND (TRIM(SE53.E5_TIPODOC) = 'ES'    AND SE5.E5_TIPODOC IN ('VL' , 'BA' , 'CP') "
    cquery += CRLF+"                     OR  TRIM(SE5.E5_TIPODOC) = 'ES'     AND SE53.E5_TIPODOC IN ('VL' , 'BA' , 'CP') OR  TRIM(SE5.E5_SITUACA) = 'C' ) "    
    cquery += CRLF+"                    AND   SE53.E5_DTDISPO >='"+cDtDisp+"' AND SE53.E5_DTDISPO <='"+cDtDisp+"' AND   SE53.D_E_L_E_T_ <> '*' ) "  
	
	cquery += CRLF+"        GROUP BY E5_PREFIXO , E5_NUMERO , E5_PARCELA , E5_TIPO "
	cquery += CRLF+"        ORDER BY E5_PREFIXO , E5_NUMERO , E5_PARCELA , E5_TIPO "    

	If Select((cAliassa52)) <> 0 
         (cAliassa52)->(DbCloseArea()) 
    Endif
    TCQuery cQuery New Alias (cAliassa52)  
    dbSelectArea(cAliassa52)
    (cAliassa52)->(dbGoTop())  		                                                                                                              
    If (cAliassa52)->(!Eof())  
        Ret:= (cAliassa52)->VLR   
    Else                        
        Ret:=0.00
    EndIf
             
return ret
/********************************************************************************************************************************
/*                                                                                                                              

ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณPrograma  ณReportDef ณ Autor ณ Leonardo Portella                       ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescri…o ณA funcao estatica ReportDef devera ser criada para todos os ณฑฑ
ฑฑณ          ณrelatorios que poderao ser agendados pelo usuario.          ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณRetorno   ณExpO1: Objeto do relatorio                                  ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/                         

Static Function ReportDef2()

Local oReport 
Local oDPJ       
Local oDPJ1     
Local oDPJ2    
Local oDPJ3  
Local oDPJ4  
Local oDPJ5 
Local oDPJ6 
//oReport	:= TReport():New("cabr133","Movimenta็ใo Bancaria de Titulos a Receber - Contabiliza็ใo  ",, {|oReport| ReportPrt(oReport)},"Movimenta็ใo Bancaria de Titulos a Receber - Contabiliza็ใo  ") 
oReport	:= TReport():New("cabr133",cTitulo,, {|oReport| ReportPrt(oReport)},cTitulo)
oReport:SetTotalInLine(.F.)//Imprime na linha: .F. - Imprime abaixo da linha com o titulo de cada coluna: .T.
//oReport:SetTotalText('Total Geral') 

*'-----------------------------------------------------------------------------------'*
*'Solucao para impressao em que as colunas se truncam: "SetColSpace" e "SetLandScape"'* 
*'-----------------------------------------------------------------------------------'*

oReport:SetColSpace(1) //Espacamento entre colunas. 
oReport:SetLandscape() //Impressao em paisagem.  
//oReport:SetPortrait() //Impressao em retrato.  

oDPJ := TRSection():New(oReport,ctitulo,,aOrdem)                                                                                                                   
//oDPJ := TRSection():New(oReport,"Movimenta็ใo Bancaria de Titulos a Receber - Contabiliza็ใo  ",,aOrdem)                                                                                                                  

TRCell():New(oDPJ ,'TITULO'	    	, 	,'Titulo' 	       ,      			    ,16				,,,,,"LEFT"		)
TRCell():New(oDPJ ,'VLRTIT'	     	, 	,'Vlr Titulo'	   ,"@E 99,999,999.99" 	,14				,,,,,"RIGHT"	)
TRCell():New(oDPJ ,'VLRBAI'	   	, 	,'Vlr Baixa '      ,"@E 99,999,999.99" 	,14			  	,,,,,"RIGHT"	)  
TRCell():New(oDPJ ,'TPDOC'	      	, 	,'TDoc '           ,  	  				,02			  	,,,,,"LEFT"		)  
TRCell():New(oDPJ ,'MOTBX'		    	, 	,'MBx '            ,  	                ,03			  	,,,,,"LEFT"		)   
TRCell():New(oDPJ ,'SEQ'		    	, 	,'Seq '            ,  	    			,03			  	,,,,,"LEFT"		)   
TRCell():New(oDPJ ,'DATBXA'		   , 	,'Dt.Bxa'          ,  	    			,03			  	,,,,,"LEFT"		)    
TRCell():New(oDPJ ,'BANCO'		    	, 	,'Bco '            ,  	    			,03			  	,,,,,"LEFT"		)   
TRCell():New(oDPJ ,'AGENCIA'		   , 	,'Ag '             ,  	    			,04			  	,,,,,"LEFT"		)   
TRCell():New(oDPJ ,'CONTA'		    	, 	,'Conta'           ,  	    			,06			  	,,,,,"LEFT"		)    
TRCell():New(oDPJ ,'SITUA'		    	, 	,'Sit'             ,  	    			,03			  	,,,,,"LEFT"		)   
TRCell():New(oDPJ ,'CMPCOM'		   , 	,'Comp. Comp'      ,  	    			,16			  	,,,,,"LEFT"		)   
TRCell():New(oDPJ ,'TPLANC'		   , 	,'Tipo Lanc'       ,  	    			,20			  	,,,,,"LEFT"		)   
TRCell():New(oDPJ ,'PLANO'		    	, 	,'Plano '          ,  	    			,15			  	,,,,,"LEFT"		)
TRCell():New(oDPJ ,'VLRLNC'	     	, 	,'Vlr Lanc '	   ,"@E 99,999,999.99" 	,14				,,,,,"RIGHT"	)   
TRCell():New(oDPJ ,'CONTAB'     		, 	,'Mov?'	           ,  					,3				,,,,,"LEFT"	    )
TRCell():New(oDPJ ,'CONTABT'     	, 	,'Tit?'	           ,  					,3				,,,,,"LEFT"	    )
TRCell():New(oDPJ ,'CDEB'		    	, 	,'Conta Deb'       ,  	    			,20			  	,,,,,"LEFT"		)    
TRCell():New(oDPJ ,'CCRED'		    	, 	,'Conta Cred'      ,  	    			,20			  	,,,,,"LEFT"		) 
TRCell():New(oDPJ ,'IDEB'		    	, 	,'Item '           ,  	    			,04			  	,,,,,"LEFT"		)               
 
oBreak   		:= TRBreak():New(oDPJ,oDPJ:Cell("TITULO"),"Total por Titulos "	,.F.)  

lTotSecBrk	:= .T.//Indica se totalizador sera impresso na quebra de secao
lTotFimBrk	:= .F.//Indica se totalizador sera impresso no final do relatorio - Como o total eh o mesmo, basta que apenas um esteja ativado
                                                                   
TRFunction():New(oDPJ:Cell("VLRTIT")  		,NIL,"SUM"			,oBreak,,"@E 999,999,999.99"	, 	,lTotSecBrk,lTotFimBrk)  
TRFunction():New(oDPJ:Cell("VLRBAI")  		,NIL,"SUM"			,oBreak,,"@E 999,999,999.99"	, 	,lTotSecBrk,lTotFimBrk)  
TRFunction():New(oDPJ:Cell("VLRLNC")  		,NIL,"SUM"			,oBreak,,"@E 999,999,999.99"	, 	,lTotSecBrk,lTotFimBrk) 

*********************

oDPJ1 := TRSection():New(oReport,"Movimenta็ใo Bancaria de Titulos a Receber - Contabiliza็ใo - resumo por lancamento e plano  ",,aOrdem)                                                                                                                  
   
TRCell():New(oDPJ1 ,'PREFI'	    		, 	,'Prefixo Tit. '  	,            	    ,10				,,,,,"LEFT"		) 	
TRCell():New(oDPJ1 ,'TPMOV'	    		, 	,'Tipo Movimento '  ,    	            ,30				,,,,,"LEFT"		) 
TRCell():New(oDPJ1 ,'PLANO'	    		, 	,'Plano          '  ,   	            ,30				,,,,,"LEFT"		)
TRCell():New(oDPJ1 ,'VLRCOM'	     	, 	,'Vlr Total'	    ,"@E 99,999,999.99" ,13				,,,,,"RIGHT"   )
TRCell():New(oDPJ1 ,'CDEB'		    	, 	,'Conta Deb'       ,  	    			,25			  	,,,,,"LEFT"		)   
TRCell():New(oDPJ1 ,'CCRED'		    	, 	,'Conta Cred'      ,  	    			,25			  	,,,,,"LEFT"		)    

oBreak01		:= TRBreak():New(oDPJ1,oDPJ1:Cell("TPMOV"),"Total por Pref. Tit e Plano  "	,.F.)  

lTotSecBrk01	:= .F.//Indica se totalizador sera impresso na quebra de secao
lTotFimBrk01	:= .F.//Indica se totalizador sera impresso no final do relatorio - Como o total eh o mesmo, basta que apenas um esteja ativado
                                                                   
//TRFunction():New(oDPJ1:Cell("VLRCOM")  		,NIL,"SUM"			,oBreak01,,"@E 999,999,999.99"	, 	,lTotSecBrk01,lTotFimBrk01) 

**********************

oDPJ2 := TRSection():New(oReport,"Movimenta็ใo Bancaria de Titulos a Receber - Contabiliza็ใo - resumo por Mot. baixa   ",,aOrdem)                                                                                                                  
                                                                                                                                                                          
TRCell():New(oDPJ2 ,'TPDOC'	    		, 	,'Tipo Documento'  ,   	                ,15				,,,,,"LEFT"		) 
TRCell():New(oDPJ2 ,'MOTBX'	    		, 	,'Mot. Bx       '  ,            	    ,15				,,,,,"LEFT"		)
TRCell():New(oDPJ2 ,'VLRBX'	        	, 	,'Vlr Total'	   ,"@E 99,999,999.99" 	,13				,,,,,"RIGHT"	)
TRCell():New(oDPJ2 ,'CDEB'		    	, 	,'Conta Deb'       ,  	    			,25			  	,,,,,"LEFT"		)   
TRCell():New(oDPJ2 ,'CCRED'		    	, 	,'Conta Cred'      ,  	    			,25			  	,,,,,"LEFT"		)    
//TRCell():New(oDPJ2 ,'CTIT'		    	, 	,'Tit'             ,  	    			,3			  	,,,,,"LEFT"		)   
//TRCell():New(oDPJ2 ,'CMOV'		    	, 	,'Mov'              ,  	    			,3			  	,,,,,"LEFT"		)    

 
oBreak02 		:= TRBreak():New(oDPJ2,oDPJ2:Cell("TPDOC"),"Total por Doc. Baixa e Mot Baixa "	,.F.)  

lTotSecBrk02	:= .F.//Indica se totalizador sera impresso na quebra de secao
lTotFimBrk02	:= .F.//Indica se totalizador sera impresso no final do relatorio - Como o total eh o mesmo, basta que apenas um esteja ativado
                                                                   
//TRFunction():New(oDPJ2:Cell("VLRBX")  		,NIL,"SUM"			,oBreak02,,"@E 999,999,999.99"	, 	,lTotSecBrk02,lTotFimBrk02) 
  
**********************
                                                                                                                                                
oDPJ3 := TRSection():New(oReport,"Movimenta็ใo Bancaria de Titulos a Receber - Contabiliza็ใo - resumo por Mot. baixa   ",,aOrdem)                                                                                                                  

TRCell():New(oDPJ3 ,'CONTA'	    		, 	,'Conta'           ,   	                ,20				,,,,,"LEFT"		) 
TRCell():New(oDPJ3 ,'ITEM'	    	    , 	,'Item '           ,   	                ,04				,,,,,"LEFT"		) 
TRCell():New(oDPJ3 ,'CREDEB'	    	, 	,'D/C  '           ,            	    ,01				,,,,,"LEFT"		)
TRCell():New(oDPJ3 ,'VLR'	        	, 	,'Vlr  '	       ,"@E 99,999,999.99"  ,13				,,,,,"RIGHT"	)  

 
oBreak03 		:= TRBreak():New(oDPJ3,oDPJ3:Cell("CONTA"),"Total por Conta e Item  "	,.F.)  

lTotSecBrk03	:= .F.//Indica se totalizador sera impresso na quebra de secao
lTotFimBrk03	:= .F.//Indica se totalizador sera impresso no final do relatorio - Como o total eh o mesmo, basta que apenas um esteja ativado
                                                                   
//TRFunction():New(oDPJ3:Cell("VLRBX")  		,NIL,"SUM"			,oBreak03,,"@E 999,999,999.99"	, 	,lTotSecBrk03,lTotFimBrk03) 
  
********************************************************************************************************************************

oDPJ4 := TRSection():New(oReport,"Movimenta็ใo Bancaria de Titulos a Receber - Contabiliza็ใo - resumo por Mot. baixa   ",,aOrdem)                                                                                                                  

TRCell():New(oDPJ4 ,'PREFTIT'    		, 	,'Pref.Tit      '  ,   	                ,10				,,,,,"LEFT"		) 
TRCell():New(oDPJ4 ,'TPDOC'	    		, 	,'Tipo Documento'  ,   	                ,15				,,,,,"LEFT"		) 
TRCell():New(oDPJ4 ,'MOTBX'	    		, 	,'Mot. Bx       '  ,   	                ,15				,,,,,"LEFT"		) 
TRCell():New(oDPJ4 ,'CREDEB'	    	, 	,'Ent/Saida     '  ,   	                ,10				,,,,,"LEFT"		)
TRCell():New(oDPJ4 ,'VLRBX'	        	, 	,'Vlr Total'	   ,"@E 99,999,999.99" 	,13				,,,,,"RIGHT"	)
TRCell():New(oDPJ4 ,'CDEB'		    	, 	,'Conta Deb'       ,  	    			,25			  	,,,,,"LEFT"		)   
TRCell():New(oDPJ4 ,'CCRED'		    	, 	,'Conta Cred'      ,  	    			,25			  	,,,,,"LEFT"		)   

 
oBreak04 		:= TRBreak():New(oDPJ4,oDPJ4:Cell("PREFTIT"),"Total por Pref. Tits "	,.F.)  

lTotSecBrk04	:= .F.//Indica se totalizador sera impresso na quebra de secao
lTotFimBrk04	:= .F.//Indica se totalizador sera impresso no final do relatorio - Como o total eh o mesmo, basta que apenas um esteja ativado
                                                                   
//TRFunction():New(oDPJ4:Cell("VLRBX")  		,NIL,"SUM"			,oBreak04,,"@E 999,999,999.99"	, 	,lTotSecBrk04,lTotFimBrk04) 
                       
**********************
                                                                                                                                                
oDPJ5 := TRSection():New(oReport,"Movimenta็ใo Bancaria de Titulos a Receber - Contabiliza็ใo - resumo por Mot. baixa   ",,aOrdem)                                                                                                                  
                                                                                                                                                                          
TRCell():New(oDPJ5 ,'MVBCO'	    		, 	,'Mov. Banco'      ,   	    			,5				,,,,,"LEFT"		) 
TRCell():New(oDPJ5 ,'TPDOC'	    		, 	,'Tipo Documento'  ,   	    			,15				,,,,,"LEFT"		) 
TRCell():New(oDPJ5 ,'MOTBX'	    		, 	,'Mot. Bx       '  ,   	        		,15				,,,,,"LEFT"		)
TRCell():New(oDPJ5 ,'VLRBX'	        	, 	,'Vlr Total'	    ,"@E 99,999,999.99" ,13				,,,,,"RIGHT"	)
TRCell():New(oDPJ5 ,'CDEB'		    	, 	,'Conta Deb'       ,  	    			,25			  	,,,,,"LEFT"		)   
TRCell():New(oDPJ5 ,'CCRED'		    	, 	,'Conta Cred'      ,  	    			,25			  	,,,,,"LEFT"		)   
 
     
 
oBreak05 		:= TRBreak():New(oDPJ5,oDPJ5:Cell("MVBCO"),"Total por Mov. Bancaria  "	,.F.)  

lTotSecBrk05	:= .F.//Indica se totalizador sera impresso na quebra de secao
lTotFimBrk05	:= .F.//Indica se totalizador sera impresso no final do relatorio - Como o total eh o mesmo, basta que apenas um esteja ativado
                                                                   
//TRFunction():New(oDPJ5:Cell("VLRBX")  		,NIL,"SUM"			,oBreak05,,"@E 999,999,999.99"	, 	,lTotSecBrk05,lTotFimBrk05) 
  
**********************                                                                                                                       
                                                                                                                                                
oDPJ6 := TRSection():New(oReport,"Movimenta็ใo Bancaria de Titulos a Receber - Contabiliza็ใo - resumo por Contas ",,aOrdem)                                                                                                                  

TRCell():New(oDPJ6 ,'CONTAD'	    	, 	,'Conta Deb'       ,   	                ,22				,,,,,"LEFT"		)  
TRCell():New(oDPJ6 ,'CONTAC'	    	, 	,'Conta Cred'      ,   	                ,22				,,,,,"LEFT"		) 
TRCell():New(oDPJ6 ,'ITEM'	    	    , 	,'Item '           ,   	                ,04				,,,,,"LEFT"		) 
TRCell():New(oDPJ6 ,'VLR'	        	, 	,'Vlr  '	       ,"@E 99,999,999.99" 	,13				,,,,,"RIGHT"	)  

oBreak06 		:= TRBreak():New(oDPJ6,oDPJ6:Cell("CONTAD"),"Total por Conta e Item  "	,.F.)  

lTotSecBrk06	:= .F.//Indica se totalizador sera impresso na quebra de secao
lTotFimBrk06	:= .F.//Indica se totalizador sera impresso no final do relatorio - Como o total eh o mesmo, basta que apenas um esteja ativado
                                                                     
Return(oReport)

********************************************************************************************************************************

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณPrograma  ณReportPrintณ Autor ณ Leonardo Portella                      ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescri…o ณA funcao estatica ReportDef devera ser criada para todos os ณฑฑ
ฑฑณ          ณrelatorios que poderao ser agendados pelo usuario.          ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/

Static Function ReportPrt(oReport)

Local   cImp    :='Nใo'

Local i := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

Private oDPJ 	:= oReport:Section(1) 
Private oDPJ1 	:= oReport:Section(2)
Private oDPJ2 	:= oReport:Section(3) 
Private oDPJ3 	:= oReport:Section(4)  
Private oDPJ4 	:= oReport:Section(5) 
Private oDPJ5 	:= oReport:Section(6)    
Private oDPJ6 	:= oReport:Section(7)
private ctit    := ' ' 

Private nCont	:= 0   

nCont := Len(aDados) + Len(aDados1) + Len(aDados2)+ Len(aDados3)+ Len(aDados4)+ Len(aDados5)+ Len(aDados6)

//Se nao tiver esta linha, nao imprime os dados

if cImpRel  == 1 
   oDPJ:init()
EndIf                 

if cImpRes  == 1
   oDPJ1:init()
   oDPJ2:init() 
   oDPJ3:init() 
   oDPJ4:init() 
   oDPJ5:init()  
   oDPJ6:init() 
EndIf   

oReport:SetMeter(nCont) 

cTot	:= AllTrim(Transform(nCont,'@E 999,999,999,999'))
nCont 	:= 0       

For i := 1 To Len(aDados)

	oReport:SetMsgPrint("Imprimindo linha " + AllTrim(Transform(++nCont,'@E 999,999,999,999')) + ' de ' + cTot+ ' [ sec. 1] ')

	oReport:IncMeter()

	If oReport:Cancel()  
	    
	    oReport:FatLine()     
	    oReport:PrintText('Cancelado pelo operador!!!',,,CLR_RED,,,.T.)
		
	    exit
	    
	EndIf   	   
                                                                  
    if aDados[i][1] == ctit
       oDPJ:Cell('TITULO'	 		):hide()                         
       oDPJ:Cell('VLRTIT'	 		):hide()   

   else                    
       ctit:= aDados[i][1]                
       oDPJ:Cell('TITULO'	 		):show()        
       oDPJ:Cell('VLRTIT'	 		):show()   

   EndIf

    oDPJ:Cell('TITULO'	 		):SetValue((aDados[i][1]))     
	oDPJ:Cell('VLRTIT'	 		):SetValue((aDados[i][2]))    
    
    oDPJ:Cell('VLRBAI'   		):SetValue((aDados[i][4]))   
   	oDPJ:Cell('TPDOC'   	    ):SetValue((aDados[i][5]))
	oDPJ:Cell('MOTBX'	 		):SetValue((aDados[i][6]))     
    oDPJ:Cell('SEQ'  	 		):SetValue((aDados[i][7]))     	  
    oDPJ:Cell('DATBXA'  		):SetValue((aDados[i][18]))     	  

  	oDPJ:Cell('BANCO'	 		):SetValue((aDados[i][8]))           
  	oDPJ:Cell('AGENCIA'	 		):SetValue((aDados[i][9]))          
  	oDPJ:Cell('CONTA'	 		):SetValue((aDados[i][10]))          
    oDPJ:Cell('SITUA'	 		):SetValue((aDados[i][20]))               
    oDPJ:Cell('CMPCOM'	 		):SetValue((aDados[i][17]))              

  	oDPJ:Cell('TPLANC'	 		):SetValue((aDados[i][12]))          
	oDPJ:Cell('PLANO'	 		):SetValue((aDados[i][13]))           
	oDPJ:Cell('VLRLNC'	 		):SetValue((aDados[i][14]))           
	oDPJ:Cell('CONTAB'	 		):SetValue((aDados[i][19]))          
	oDPJ:Cell('CONTABT'	 		):SetValue((aDados[i][23]))          
	oDPJ:Cell('CCRED'	 		):SetValue((aDados[i][21]))          
	oDPJ:Cell('CDEB'	 		):SetValue((aDados[i][22]))  
	oDPJ:Cell('IDEB'	 		):SetValue((aDados[i][24])) 
	         

	oDPJ:PrintLine()
Next i

oDPJ:Finish()                  

*********************************************************************************
For i := 1 To Len(aDados1)

	oReport:SetMsgPrint("Imprimindo linha " + AllTrim(Transform(++nCont,'@E 999,999,999,999')) + ' de ' + cTot + ' [ sec. 2] ')

	oReport:IncMeter()

	If oReport:Cancel()  
	    
	    oReport:FatLine()     
	    oReport:PrintText('Cancelado pelo operador!!!',,,CLR_RED,,,.T.)
		
	    exit
	    
	EndIf   
	oDPJ1:Cell('PREFI'	 		):SetValue((aDados1[i][1]))
    oDPJ1:Cell('TPMOV'	 		):SetValue((aDados1[i][2]))     
	oDPJ1:Cell('PLANO'	 		):SetValue((aDados1[i][3]))     

  	oDPJ1:Cell('VLRCOM'	  		):SetValue((aDados1[i][6]))   
  	oDPJ1:Cell('CCRED'	 		):SetValue((aDados1[i][4]))          
	oDPJ1:Cell('CDEB'	 		):SetValue((aDados1[i][5]))  
                
	oDPJ1:PrintLine()
Next i

oDPJ1:Finish()    

********************************************************************************

For i := 1 To Len(aDados2)

	oReport:SetMsgPrint("Imprimindo linha " + AllTrim(Transform(++nCont,'@E 999,999,999,999')) + ' de ' + cTot+ ' [ sec. 3] ')

	oReport:IncMeter()

	If oReport:Cancel()  
	    
	    oReport:FatLine()     
	    oReport:PrintText('Cancelado pelo operador!!!',,,CLR_RED,,,.T.)
		
	    exit
	    
	EndIf   	    
    oDPJ2:Cell('TPDOC'	 		):SetValue((aDados2[i][1]))     
	oDPJ2:Cell('MOTBX'	 		):SetValue((aDados2[i][2]))    
  	oDPJ2:Cell('VLRBX'	  		):SetValue((aDados2[i][5]))      
  	oDPJ2:Cell('CCRED'	 		):SetValue((aDados2[i][3]))          
	oDPJ2:Cell('CDEB'	 		):SetValue((aDados2[i][4]))  
	oDPJ2:PrintLine()     
	
Next i

oDPJ2:Finish()  

********************************************************************************
For i := 1 To Len(aDados3)
	oReport:SetMsgPrint("Imprimindo linha " + AllTrim(Transform(++nCont,'@E 999,999,999,999')) + ' de ' + cTot+ ' [ sec. 4] ')
	oReport:IncMeter()
	If oReport:Cancel()  
	    oReport:FatLine()     
	    oReport:PrintText('Cancelado pelo operador!!!',,,CLR_RED,,,.T.)
	    exit
	EndIf  
    oDPJ3:Cell('CONTA'	 		):SetValue((aDados3[i][1]))     
	oDPJ3:Cell('ITEM'	 		):SetValue((aDados3[i][2]))     
	oDPJ3:Cell('CREDEB'	 		):SetValue((aDados3[i][3]))    
  	oDPJ3:Cell('VLR'	  		):SetValue((aDados3[i][4]))    
	oDPJ3:PrintLine()
Next i
oDPJ3:Finish()    
********************************************************************************
For i := 1 To Len(aDados6)

	oReport:SetMsgPrint("Imprimindo linha " + AllTrim(Transform(++nCont,'@E 999,999,999,999')) + ' de ' + cTot+ ' [ sec. 7] ')
	oReport:IncMeter()
	If oReport:Cancel()  
       oReport:FatLine()     
       oReport:PrintText('Cancelado pelo operador!!!',,,CLR_RED,,,.T.)
       exit
	EndIf  
    oDPJ6:Cell('CONTAD'	 		):SetValue((aDados6[i][2]))      
    oDPJ6:Cell('CONTAC'	 		):SetValue((aDados6[i][1]))     
	oDPJ6:Cell('ITEM'	 		):SetValue((aDados6[i][3]))     
  	oDPJ6:Cell('VLR'	  		):SetValue((aDados6[i][4]))    
	oDPJ6:PrintLine()
Next i
oDPJ6:Finish()    
********************************************************************************

For i := 1 To Len(aDados4)

	oReport:SetMsgPrint("Imprimindo linha " + AllTrim(Transform(++nCont,'@E 999,999,999,999')) + ' de ' + cTot+ ' [ sec. 5] ')

	oReport:IncMeter()

	If oReport:Cancel()  
	    
	    oReport:FatLine()     
	    oReport:PrintText('Cancelado pelo operador!!!',,,CLR_RED,,,.T.)
		
	    exit
	    
	EndIf   	   
                                                             
    oDPJ4:Cell('PREFTIT'	    ):SetValue((aDados4[i][2]))           
    oDPJ4:Cell('TPDOC'	 		):SetValue((aDados4[i][3]))     
	oDPJ4:Cell('MOTBX'	 		):SetValue((aDados4[i][4]))     
	oDPJ4:Cell('CREDEB'	 		):SetValue((aDados4[i][1]))    
  	oDPJ4:Cell('VLRBX'	  		):SetValue((aDados4[i][7]))      
  
  	oDPJ4:Cell('CCRED'	 		):SetValue((aDados4[i][5]))          
	oDPJ4:Cell('CDEB'	 		):SetValue((aDados4[i][6]))          
	oDPJ4:PrintLine()
Next i

oDPJ4:Finish()  

********************************************************************************

For i := 1 To Len(aDados5)

	oReport:SetMsgPrint("Imprimindo linha " + AllTrim(Transform(++nCont,'@E 999,999,999,999')) + ' de ' + cTot+ ' [ sec. 6] ')

	oReport:IncMeter()

	If oReport:Cancel()     
       oReport:FatLine()     
       oReport:PrintText('Cancelado pelo operador!!!',,,CLR_RED,,,.T.)	
       exit	    
	EndIf   	    
    oDPJ5:Cell('MVBCO'	 		):SetValue((aDados5[i][1]))    
    oDPJ5:Cell('TPDOC'	 		):SetValue((aDados5[i][2]))   
	oDPJ5:Cell('MOTBX'	 		):SetValue((aDados5[i][3]))    
  	oDPJ5:Cell('VLRBX'	  		):SetValue((aDados5[i][6]))      
  	oDPJ5:Cell('CCRED'	 		):SetValue((aDados5[i][4]))          
	oDPJ5:Cell('CDEB'	 		):SetValue((aDados5[i][5]))          
	oDPJ5:PrintLine()     
	
Next i

oDPJ5:Finish()  

********************************************************************************

Return       

******************************************************************************************

Static Function AjustaSX1(cPerg)

Local aHelpPor := {}            

PutSx1(cPerg,"01",OemToAnsi("Data Inicial Mov.  Bancaria   "),"","","mv_ch1","D",08,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","","",{},{}) 
PutSx1(cPerg,"02",OemToAnsi("Data Final   Mov.  Bancaria   "),"","","mv_ch2","D",08,0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","","",{},{}) 
PutSx1(cPerg,"03",OemToAnsi("Imprime Relatorio ?           "),"","","mv_ch03","N",01,0,0,"C","","","","","mv_par03","Sim"          ,"","","","Nใo","","","","","","","","","","","",{},{},{})  
PutSx1(cPerg,"04",OemToAnsi("Imprime Resumos   ?           "),"","","mv_ch04","N",01,0,0,"C","","","","","mv_par04","Sim"          ,"","","","Nใo","","","","","","","","","","","",{},{},{})  
PutSx1(cPerg,"05",OemToAnsi("Mais de Uma  Movimenta็ใo     "),"","","mv_ch5","N",01,0,0,"C","","","","","mv_par05","Sim"            ,"","","","Nใo"        ,"","","Nใo Considera","","","","","","",) 
PutSx1(cPerg,"06",OemToAnsi("Diverg๊ncia  de valores       "),"","","mv_ch6","N",01,0,0,"C","","","","","mv_par06","Sem Divergencia","","","","Mov. Maior que Titulo ","","","Mov. Menor que Titulo"   ,"","","Nใo Considera","","","","","","","","","","") 
PutSx1(cPerg,"07",OemToAnsi("Prefixo  hแ  Sair             "),"","","mv_ch07","C",60,0,0,"G","","","","","mv_par07",""              ,"","",""          ,""         ,"","","","","","","","","","","","","","","","","","","","") 
PutSx1(cPerg,"08",OemToAnsi("Prefixo  hแ Nใo Sair          "),"","","mv_ch08","C",60,0,0,"G","","","","","mv_par08",""              ,"","",""          ,""         ,"","","","","","","","","","","","","","","","","","","","")  

PutSx1(cPerg,"09",OemToAnsi("Motivo de baixa hแ  Sair      "),"","","mv_ch09","C",60,0,0,"G","","","","","mv_par09",""              ,"","","",""       ,"","","","","","","","","","","","","","","","","","","","") 
PutSx1(cPerg,"10",OemToAnsi("Motivo de baixa hแ Nใo Sair   "),"","","mv_ch10","C",60,0,0,"G","","","","","mv_par10",""              ,"","","",""       ,"","","","","","","","","","","","","","","","","","","","")  
PutSx1(cPerg,"11",OemToAnsi("Gerar Excel                   "),"","","mv_ch11","N",01,0,0,"C","","","","","mv_par11","Sim"           ,"","","","Nใo","","","","","","","","","","","",{},{},{})  
PutSx1(cPerg,"12",OemToAnsi("Lista Convenios               "),"","","mv_ch12","N",01,0,0,"C","","","","","mv_par12","Sem Convenios","","","","S๓ Convenio","","","Com Convenio"   ,"","","","","","","","","","","","","") 
PutSx1(cPerg,"13",OemToAnsi("Listar Estornos de Baixa      "),"","","mv_ch13","N",01,0,0,"C","","","","","mv_par13","Sim"           ,"","","","Nใo","","","","","","","","","","","",{},{},{})  
PutSx1(cPerg,"14",OemToAnsi("Ident. Titulo Especifico      "),"","","mv_ch14","C",60,0,0,"G","","","","","mv_par14",""              ,"","",""          ,""         ,"","","","","","","","","","","","","","","","","","","","")  
PutSx1(cPerg,"15",OemToAnsi("Cons. Dt Baixa Para Moviment  "),"","","mv_ch15","N",01,0,0,"C","","","","","mv_par15","Sim"           ,"","","","Nใo","","","","","","","","","","","",{},{},{})  
PutSx1(cPerg,"16",OemToAnsi("Lista S๓ Moviment. bancaria   "),"","","mv_ch16","N",01,0,0,"C","","","","","mv_par16","S๓ Mov.Banco" ,"","","","Sem Mov.Banco ","","","Nใo Considera"   ,"","","","","","","","","","","","","") 

PutSx1(cPerg,"17",OemToAnsi("Lista  Contabilizado          "),"","","mv_ch17","N",01,0,0,"C","","","","","mv_par17","Nใo Contabilizado" ,"","","","Contabilizado","","","Nใo Considera"   ,"","","","","","","","","","","","","") 

PutSx1(cPerg,"18",OemToAnsi("Fazer contabiliza็ใo          "),"","","mv_ch18","N",01,0,0,"C","","","","","mv_par18","Nใo"          ,"","","","Sim","","","","","","","","","","","",{},{},{})  
PutSx1(cPerg,"19",OemToAnsi("Mostra Lancamentos?           "),"","","mv_ch19","N",01,0,0,"C","","","","","mv_par19","Sim"          ,"Sim"         ,"Sim"         ,"","Nใo"        ,"Nใo"       ,"Nใo" )
PutSx1(cPerg,"20",OemToAnsi("Aglutina Lancto ?             "),"","","mv_ch20","N",01,0,0,"C","","","","","mv_par20","Sim"          ,"Sim"         ,"Sim"         ,"","Nao"        ,"Nao"       ,"Nao" )
PutSx1(cPerg,"21",OemToAnsi("Confima contabiliza็ใo?       "),"","","mv_ch21","N",01,0,0,"C","","","","","mv_par21","Nใo"          ,"","","","Sim","","","","","","","","","","","",{},{},{})  
PutSx1(cPerg,"22",OemToAnsi("Informe Historico             "),"","","mv_ch22","C",25,0,0,"G","","","","","mv_par22",""             ,"","",""          ,""         ,"","","","","","","","","","","","","","","","","","","","") 
PutSx1(cPerg,"23",OemToAnsi("Considera Item Conta  ?       "),"","","mv_ch23","N",01,0,0,"C","","","","","mv_par23","Sim"          ,"Sim"         ,"Sim"         ,"","Nao"        ,"Nao"       ,"Nao" )
PutSx1(cPerg,"24",OemToAnsi("Fazer contab. C/Critica       "),"","","mv_ch24","N",01,0,0,"C","","","","","mv_par24","Nใo"          ,"","","","Sim","","","","","","","","","","","",{},{},{})  
PutSx1(cPerg,"25",OemToAnsi("Cod banco a Contab            "),"","","mv_ch25","C",03,0,0,"G","","","","","mv_par25"," "             ,"","","","","","","","","","","","","","","",{},{},{})  

Pergunte(cPerg,.F.)

Return     

/*************************************************************************************************************/

Static Function Contabiliza()                                         

Local 	nProc		:= 0    

Local i := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
 
Private l_mostra    := .T. 
/*
01 - cE1IDENT_TIT         
02 - cE1VLR_TIT           
03 - cE1SLD_TIT            
04 - cE5VLR_BX_TIT        
05 - cE5TP_DOC             
06 - cE5MOT_BX            
07 - cE5SEQ               
08 - cE5BANCO             
09 - cE5AGENCIA            
10 - cE5CONTA              
11 - cE5RECPAG            
12 - cBM1TP_MOV             
13 - cBM1PLANO            
14 - cBM1VLR_EVENTO       
15 - cE1ORIGEM            
16 - cMovBanco            
17 - cComp                
18 - cE5Dt                
19 - cE5LaBx              
20 - cSituaca             
21 - cContaC                   
22 - cContaD    		  
23 - cE1LaBx              
24 - cBM1ITEMC            
25 - (cAliastmp)->SE1_RECNO  
26 - (cAliastmp)->SE5_RECNO  
27 - (cAliastmp)->BM1_RECNO 
28 - lContMov             
29 - lContTit            
	
    oDPJ:Cell('TITULO'	 		):SetValue((aDados[i][1]))     
	oDPJ:Cell('VLRTIT'	 		):SetValue((aDados[i][2]))    
    oDPJ:Cell('VLRBAI'   		):SetValue((aDados[i][4]))   
   	oDPJ:Cell('TPDOC'   	    ):SetValue((aDados[i][5]))
	oDPJ:Cell('MOTBX'	 		):SetValue((aDados[i][6]))     
    oDPJ:Cell('SEQ'  	 		):SetValue((aDados[i][7]))     	  
    oDPJ:Cell('DATBXA'  		):SetValue((aDados[i][18]))     	  
  	oDPJ:Cell('BANCO'	 		):SetValue((aDados[i][8]))           
  	oDPJ:Cell('AGENCIA'	 		):SetValue((aDados[i][9]))          
  	oDPJ:Cell('CONTA'	 		):SetValue((aDados[i][10]))          
    oDPJ:Cell('SITUA'	 		):SetValue((aDados[i][20]))               
    oDPJ:Cell('CMPCOM'	 		):SetValue((aDados[i][17]))              
  	oDPJ:Cell('TPLANC'	 		):SetValue((aDados[i][12]))          
	oDPJ:Cell('PLANO'	 		):SetValue((aDados[i][13]))           
	oDPJ:Cell('VLRLNC'	 		):SetValue((aDados[i][14]))           
	oDPJ:Cell('CONTAB'	 		):SetValue((aDados[i][19]))          
	oDPJ:Cell('CONTABT'	 		):SetValue((aDados[i][23]))          
	oDPJ:Cell('CCRED'	 		):SetValue((aDados[i][21]))          
	oDPJ:Cell('CDEB'	 		):SetValue((aDados[i][22]))  
	oDPJ:Cell('IDEB'	 		):SetValue((aDados[i][24])) 
	
*/
//
dDatabase	:= stod(cDtFimMvB)
cPadrao     := "988"
lPadrao     := VerPadrao(cPadrao)
cLote       := "009931"
cArquivo    := ""
nHdlPrv     := HeadProva(cLote,"PLS",Substr(cUsuario,7,6),@cArquivo)
_aArea      := GetArea()
//
nTotReg		:= 0
nCountnx	:= 0
nValLan		:= 0
nSeq		:= 0
_nTotVlr	:= 0
//
//MOSTRA LANวAMENTO
IIF(MV_PAR19 == 1  ,l_Mostra  := .T.,l_Mostra := .F.)
////AGLUTINA LANวAMENTO
IIF(MV_PAR20 == 1  ,lAglutina := .T.,lAglutina := .F.)
//             
For i := 1 To Len(aDados)    
    If  aDados[I,28] .and. (aDados[I,19]== 'NรO' .OR. aDados[I,23] == 'NรO')
	   	//
	 	DbSelectArea("SE5")    
	 	DbGoto(aDados[I,26])   
	 	If aDados[I,28] 
 	 	   If !SE5->E5_LABAI
       	      RecLock("SE5",.F.)
	 	      SE5->E5_LABAI := .T.
	 	      MsUnlock()
       	   EndIf 	
       	EndIf   
	 	
	 	DbSelectArea("SE1")    
	 	DbGoto(aDados[I,25])    
	 	If aDados[I,29] 
	 	   If !SE1->E1_LABAI 
              RecLock("SE1",.F.)
	 	      SE1->E1_LABAI := .T.
	 	      MsUnlock()
	 	   EndIf 
	 	EndIf     
	 	
	 	DbSelectArea("BM1")    
	 	DbGoto(aDados[I,27])
	 	//          
	 	If aDados[i][14] < 0
	       aDados[i][14]:= (aDados[i][14]*-1)                           
	    EndIf  
	       _cCTADEB    := aDados[i][22]
	       _cCTACRE    := aDados[i][21]  
 	    
   	    DbSelectArea("CT1")
 	    DbSetOrder(1)
 	    DbSeek(xFilial("CT1")+_cCTADEB)
 	   //                      
 	   // 	    If ct1_acclvl  == '2' 
       //            _cCLVLDEB   := ' ' 
       //         Else                 
       //            _cCLVLDEB   := ' '
       //         EndIf   
 	                                 
 	    If ct1_acitem = '2' .and. mv_par23 == 1 
 	       _cITEMDEB   := aDados[i][24]
 	    Else             
 	       _cITEMDEB   := '' 
 	    EndIf     
 	   // 
 	    DbSeek(xFilial("CT1")+_cCTACRE)
 	   //                   
       // 	    If ct1_acclvl  == '2' 
       //            _cCLVLCRE   := ' ' 
       //         Else                 
       //            _cCLVLCRE   := ' '
       //         EndIf   
     	                           
 	    If ct1_acitem == '2' .and. mv_par23 == 1 
 	       _cITEMCRE   := aDados[i][24]
 	    Else             
 	       _cITEMCRE   := '' 
 	    EndIf    
 	   //       
        If !empty (mv_par22)
           _cDESCTIP   := mv_par22
        Else          
           _cDESCTIP   :=  aDados[i][12]
        EndIf   
		_nVLMOV1	:=	aDados[i][14]
		_nTotVlr	+= 	aDados[i][14]
	
	 	nTotReg	++
		//	
  	 	_nTotal    += DetProva(nHdlPrv,cPadrao,"PLS",cLote)
		//
	EndIf	    
Next i
//
nSeq ++
//
RodaProva(nHdlPrv,_nTotal)
cA100Incl(cArquivo,nHdlPrv,3,cLote,l_Mostra,lAglutina)
nSeq := 0
                                                                                
Return          

/*************************************************************************************************************/
************************
Static Function gravavetor
************************
  //cArqEnviar - caminho do arq.
  //cFile      - nome do arq
 /*
	nHdl := FCreate(cArqEnviar + cFile)//Cria em pasta diferente com o mesmo nome
    
    If nHdl == -1
		aAdd(aCriticas,'Erro na criacao do arquivo [ ' + cArqEnviar + cFile + ' ]' + CRLF + 'Erro: [ ' + cDesFerror(FError()) + ' ] !')
		loop
    Endif 

    FT_FUse()
	FClose(nHdl)

    nHdl := FOpen(cArqEnviar + cFile,FO_WRITE)

	If nHdl == -1      
		aAdd(aCriticas,'Erro na abertura do arquivo [ ' + cArqEnviar + cFile + ' ]' + CRLF + 'Erro: [ ' + cDesFerror(FError()) + ' ] !')
		loop
    EndIf

	//Leonardo Portella - 21/12/12 - O cartao ja sai ordenado pelo PE PLS264OB visto que a carteirinha pode ser impressa direto na Caberj, sem preparacao do arquivo.
	//aSort(aOrdena,,,{|x,y| ( x[21] + x[7] ) < ( y[21] + y[7] )})

	For n_Cont := 1 to len(aOrdena)

		oProcess:IncRegua2("Ajustando registro " + StrZero(n_Cont,6) + " de " + StrZero(len(aOrdena),6))

		cString := StrZero(n_Cont,11) + ";"

		aAdd(aImp,{aOrdena[n_Cont][7],aOrdena[n_Cont][6],aOrdena[n_Cont][4],aOrdena[n_Cont][21],cNomeArq,cArqEnviar + cFile})

		For nCont2 := 2 to (Len(aOrdena[n_Cont])-1)
		    If !empty(aOrdena[n_Cont][nCont2])
		    	cString += aOrdena[n_Cont][nCont2]
		    EndIf
		    
		    cString += ";"
		Next   

		aAdd(aImpCart,cString)

	Next

	For nCont := 1 to len(aImpCart)

		cEscrever := aImpCart[nCont]
                                    
        If nCont < len(aImpCart)
        	cEscrever += CRLF
        EndIf
        
		FSeek(nHdl, 0, FS_END)//Posiciona no fim do arquivo
		
		FWrite(nHdl,@cEscrever)
	Next

	FT_FUse()
	FClose(nHdl)
 */
Return

