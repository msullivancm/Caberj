#Define CRLF Chr(13)+Chr(10)
#INCLUDE "PROTHEUS.ch"                                                                                                                                  
#INCLUDE "TOPCONN.ch"
#INCLUDE "PLSMGER.CH"
#Include "Ap5Mail.Ch" 
                                             
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABR245   º Autor ³Altamiro              º Data ³ 24/10/17  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Relatorio de Acompanhamento do Sib - extrato               º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/                                                                                                      

User Function CABA156( )

Local cMsg			:= " "

local  _cIdUsu156 := RetCodUsr()

Private lAbortPrint := .F.
Private cPerg       := "CABA156"
Private cTitulo     := "Carga janela de Cobrança "        
private aDados1     := {} 
private aDados2     := {}
Private cAliastmp 	:= GetNextAlias()             
Private cAliasTst 	:= GetNextAlias()   

Private cAliasBlc 	:= GetNextAlias()  
private lfaz        := .T.

private cCompte0    := ' ' 
private cCompte1    := ' ' 
private cCompte2    := ' ' 

private nImpCrit	:= GetNewPar('MV_JANSCRI',1) //considera janela com critica para importar 

***************************************************************************    
 
Private  acabec1:=  {"COMPTCIA"       ,;
					      "MATRICULA "     ,;
					      "USUARIO "       ,;
					      "DT INICIAL"     ,;
					      "DT BLOQ USUARIO",;
					      "DT BLOQ FAMILIA",;
					      "VALOR "         ,;
					      "LANC DEBCRE "   ,;
					      "LOTE COBRANÇA " ,;   
					      "DT LANC D/C "   ,;
					      "DT PROCES. "    ,;
					      "COD PLANO "     ,;
					      "NIV. COB "      ,;
					      "MARCA "         ,;
					      "COD BLOQ "      ,;
					      "LOCAL BLOQ "    ,;
					      "CRITICA "       ,;
					      "OBSERVAÇÃO "}

 

private  Descric := ' '

cMsg += " Este programa ira fazer a Carga da Janela de Cobrança para o arquivo PDL " + CRLF
cMsg += "  " + CRLF

/*

PARAMENTRO PARA TRATAMENTO MV_USUJAN 

If _cIdUsu156 != '001091' .and. _cIdUsu156 != '000310' .and. _cIdUsu156 != '000938'
   MsgAlert("                 ATENÇÃO!"+ CRLF + CRLF + " Usuario Não Autorizado a executar esta Rotina" + CRLF + "  Rotina não sera executada  !!")
EndIf 

*/                                                                                                       

  AjustaSX1()

  Pergunte(cPerg,.T.)  
   
cCompteI     := MV_PAR01 
cCompteF     := MV_PAR02
   
 //  cDtEntr    := dtos(mv_par01)     
 //  cdata      := substr(cDtEntr,7,2)+'/'+substr(cDtEntr,5,2)+'/'+substr(cDtEntr,1,4)
   cEmpresa   :=Iif(cEmpAnt == '01', 'C', 'I')                   
   
   If Mv_par06 == 2
      MsgAlert("                 ATENÇÃO!"+ CRLF + CRLF + " Dados Selecionados NÃO Serão Gravados no  Controle " + CRLF + "  Segundo Sua Opção !!")
   EndIf 
   
   
   Processa({||Processa1()}, cTitulo, "Processado Cobranca da Janela Da Competencia "+cCompteI+" a Competencia "+cCompteF  , .T.)
   


//lexcel	   := .T.    
  
//Processa({||Processa1()}, cTitulo, "", .T.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Libera impressao                                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
  
  
// faz ecxel

// if lexcel      
         
   DlgToExcel({{"ARRAY","Extrato Da Janela de Cobrança " ,aCabec1,aDados1}})   

// EndIF
fGeraRel2()    

MsgInfo("Processo finalizado")

Return                 

**************************************************************************

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFun‡„o    ³ PROCESSA1º Autor ³ Jean Schulz        º Data ³  11/11/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescri‡„o ³ Funcao auxiliar chamada pela PROCESSA.  A funcao PROCESSA  º±±
±±º          ³ monta a janela com a regua de processamento.               º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Programa principal                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±± 
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function Processa1() 

Local cquery := ''       

ProcRegua(FT_FLASTREC()) 

nCont := 0
IncProc('Processando...')      
///////////////////////////////////

while ( cCompteI <= cCompteF  ) 
      
cQuery := CRLF+ "SELECT 'PREVISTO NAO REALIZADO' TIPO, "
cQuery += CRLF+ "       '"+cCompteI +"'COMPTE , "
cQuery += CRLF+ "       TAB1.CODINT CODINT1 , "
cQuery += CRLF+ "       TAB1.CODEMP CODEMP1 , " 
cQuery += CRLF+ "       TAB1.MATRIC MATRIC1 , "
cQuery += CRLF+ "       TAB1.TIPREG TIPREG1 , "
cQuery += CRLF+ "       substr(TAB1.NOME,1,40) NOMUSR , "
//cQuery += CRLF+ "       (RETORNA_VALOR_FAIXA_PRXRE_ALTA('I',TAB1.CODINT,TAB1.CODEMP,TAB1.MATRIC,TAB1.TIPREG,'"+cCompteI+"01')) COTRPREST ,"
//cQuery += CRLF+ "       (RETORNA_VALOR_FAIXA_PRXRE('I',TAB1.CODINT,TAB1.CODEMP,TAB1.MATRIC,TAB1.TIPREG,'"+cCompteI+"01')) COTRPREST ,"

If cEmpresa == 'I' 
   //cQuery += CRLF+ "       (RETORNA_VALOR_FAIXA_I (TAB1.CODINT,TAB1.CODEMP,TAB1.MATRIC,TAB1.TIPREG,'"+cCompteI+"01')) COTRPREST ,"
   cQuery += CRLF+ "       (RETORNA_VALOR_FAIXA_PRXRE_ALTA('I',TAB1.CODINT,TAB1.CODEMP,TAB1.MATRIC,TAB1.TIPREG,'"+cCompteI+"01')) COTRPREST ,"
Else    
   cQuery += CRLF+ "       (RETORNA_VALOR_FAIXA (TAB1.CODINT,TAB1.CODEMP,TAB1.MATRIC,TAB1.TIPREG,'"+cCompteI+"01')) COTRPREST ,"
EndIf
 
cQuery += CRLF+ "       BA11.BA1_DATINC DATINC1, "
cQuery += CRLF+ "       BA11.BA1_DATBLO DATBLO1, "
cQuery += CRLF+ "       BA31.BA3_DATBLO DATBLO3, "      
cQuery += CRLF+ "       BA11.BA1_CODPLA CODPLA1, "
cQuery += CRLF+ "       case when BA11.BA1_COBNIV <> '1' AND BA31.BA3_COBNIV <> '1' AND BQC1.BQC_COBNIV <> '1' and  BT51.BT5_COBNIV <> '1' then '05' "   
cQuery += CRLF+ "            when BT51.BT5_COBNIV =  '1' and BA31.BA3_TIPOUS <> '1' then '4' "
cQuery += CRLF+ "            when BQC1.BQC_COBNIV =  '1' and BA31.BA3_TIPOUS <> '1' then '3' "
cQuery += CRLF+ "            when BA31.BA3_COBNIV =  '1' then '2' "
cQuery += CRLF+ "            when BA11.BA1_COBNIV =  '1' then '1' "
cQuery += CRLF+ "            else '0'  end CobNiv1 , "

cQuery += CRLF+ "       BA11.BA1_MOTBLO MOTBLO  , "
cQuery += CRLF+ "       BA11.BA1_CONSID LOCBLOQ , "
cQuery += CRLF+ "       TAB1.CONEMP CONEMP , TAB1.SUBCON SUBCON "

cQuery += CRLF+ "  from( "
cQuery += CRLF+ "        select BA1_CODINT CODINT , " 
cQuery += CRLF+ "               BA1_CODEMP CODEMP , "
cQuery += CRLF+ "               BA1_MATRIC MATRIC , "
cQuery += CRLF+ "               BA1_TIPREG TIPREG , "
cQuery += CRLF+ "               BA1_NOMUSR NOME   , "
cQuery += CRLF+ "               BA1_CONEMP CONEMP , "
cQuery += CRLF+ "               BA1_SUBCON SUBCON   "

If mv_par05 == 1       
/*     
       ,(RETORNA_VALOR_FAIXA_PRXRE('I',BA1_CODINT,BA1_CODEMP,BA1_MATRIC,BA1_TIPREG,TO_CHAR(FIRST_DAY(PMESANO),'YYYYMMDD')) +
         RETORNA_VALOR_DE_OPCIONAIS(BA1_CODINT,BA1_CODEMP,BA1_MATRIC,BA1_TIPREG,
                                                     TO_CHAR(FIRST_DAY(PMESANO),'YYYYMMDD'),'"+cEmpresa +"')) CONTRAPRESTACAO
 */
EndIf
    
cQuery += CRLF+ "          FROM "+ RetSqlName("BA1") +" BA1 ,"+ RetSqlName("BA3") +" BA3 "
cQuery += CRLF+ "         WHERE  BA1_FILIAL='"+xFilial('BA1')+ "'"
cQuery += CRLF+ "           AND  BA3_FILIAL='"+xFilial('BA3')+ "'"
cQuery += CRLF+ "           AND  BA1_CODINT=BA3_CODINT "
cQuery += CRLF+ "           AND  BA1_CODEMP=BA3_CODEMP "
cQuery += CRLF+ "           AND  BA1_MATRIC=BA3_MATRIC "

cQuery += CRLF+ "           AND  (BA3_DATBLO = '  ' OR BA3_DATBLO  >= '"+cCompteI+"01' )  
cQuery += CRLF+ "           AND  (BA1_DATBLO = '  ' OR BA1_DATBLO  >= '"+cCompteI+"01' )   
cQuery += CRLF+ "           AND  Substr(BA1_DATINC,1,6) <= '"+cCompteI+"' "

cQuery += CRLF+ "           AND  BA1_CONEMP<>' ' "
      
cQuery += CRLF+ "           AND  BA1_CODEMP >= '"+mv_par03+"'  AND  BA1_CODEMP <= '"+mv_par04+"' "

If cEmpresa == 'C' 
   cQuery += CRLF+ "           AND  BA1_CODEMP not in ('0004','0009')
EndIf
    
cQuery += CRLF+ "           AND  BA1.D_E_L_E_T_= ' ' "
cQuery += CRLF+ "           AND  BA3.D_E_L_E_T_= ' ' "

cQuery += CRLF+ "  MINUS  "

cQuery += CRLF+ "        SELECT  BA1_CODINT CODINT , "
cQuery += CRLF+ "                BA1_CODEMP CODEMP , "
cQuery += CRLF+ "                BA1_MATRIC MATRIC , "
cQuery += CRLF+ "                BA1_TIPREG TIPREG , "
cQuery += CRLF+ "                BA1_NOMUSR NOME   , "
cQuery += CRLF+ "                BA1_CONEMP CONEMP , "
cQuery += CRLF+ "                BA1_SUBCON SUBCON   "
If mv_par05 == 1       
//cQuery += CRLF+ "              ,SUM(DECODE(BFQ_DEBCRE,'1',1,'2',-1,0) * BM1_VALOR) CONTRAPRESTACAO
EndIf
cQuery += CRLF+ "           FROM "+ RetSqlName("BA1") +" BA1 ," 
cQuery += CRLF+ "                "+ RetSqlName("BM1") +" BM1 ," 
cQuery += CRLF+ "                "+ RetSqlName("BA3") +" BA3 ,"
cQuery += CRLF+ "                "+ RetSqlName("BFQ") +" BFQ ,"
cQuery += CRLF+ "                "+ RetSqlName("SE1") +" SE1   "
cQuery += CRLF+ "          WHERE BA1_FILIAL    = '"+xFilial('BA1')+ "'"
cQuery += CRLF+ "            AND BM1_FILIAL    = '"+xFilial('BM1')+ "'"
cQuery += CRLF+ "            AND BA3_FILIAL    = '"+xFilial('BA3')+ "'"
cQuery += CRLF+ "            AND BFQ_FILIAL    = '"+xFilial('BFQ')+ "'"
cQuery += CRLF+ "            AND E1_FILIAL     = '"+xFilial('SE1')+ "'"
cQuery += CRLF+ "            AND E1_PREFIXO    = BM1_PREFIX  "
cQuery += CRLF+ "            AND E1_NUM        = BM1_NUMTIT  "
cQuery += CRLF+ "            AND E1_PARCELA    = BM1_PARCEL  "
cQuery += CRLF+ "            AND E1_TIPO       = BM1_TIPTIT  "
cQuery += CRLF+ "            AND BM1.BM1_CODINT = '0001'     "
If mv_par05 != 1       
   cQuery += CRLF+ "            and bm1_codtip = '101'  "
EndIf         
cQuery += CRLF+ "            AND BM1.BM1_ANO||BM1.BM1_MES = '"+cCompteI+"'  "

cQuery += CRLF+ "            AND BFQ_YTPANL = 'M'  "
cQuery += CRLF+ "            AND BM1.D_E_L_E_T_ = ' '  "
cQuery += CRLF+ "            AND BA1.D_E_L_E_T_ = ' '  "
cQuery += CRLF+ "            AND SE1.D_E_L_E_T_ = ' '  "
cQuery += CRLF+ "            AND BA3.D_E_L_E_T_ = ' '  "
cQuery += CRLF+ "            AND BFQ.D_E_L_E_T_ = ' ' "

cQuery += CRLF+ "            and E1_CODINT      = BA1_CODINT "
cQuery += CRLF+ "            AND e1_CODEMP      = BA1_CODEMP "
cQuery += CRLF+ "            AND BA3_CODINT     = BA1_CODINT "
cQuery += CRLF+ "            AND BA3_CODEMP     = BA1_CODEMP "
cQuery += CRLF+ "            AND BA3_MATRIC     = BA1_MATRIC "                  
cQuery += CRLF+ "            and BM1_CODINT     = BA1_CODINT "
cQuery += CRLF+ "            and BM1_CODEMP     = BA1_CODEMP "
cQuery += CRLF+ "            and BM1_MATRIC     = BA1_MATRIC "  
cQuery += CRLF+ "            AND BM1_TIPREG     = BA1_TIPREG "  

//altamiro 20201230
//cQuery += CRLF+ "           AND  BA1_matric >= '000150'  AND  BA1_MATRIC <= '000150'  "        

cQuery += CRLF+ "            AND BFQ_CODINT     = '0001'  "
cQuery += CRLF+ "            AND BFQ_PROPRI     = SUBSTR(BM1_CODTIP,1,1) "
cQuery += CRLF+ "            AND BFQ_CODLAN     = SUBSTR(BM1_CODTIP,2,2) "
   
cQuery += CRLF+ "            AND  BA1_CODEMP >= '"+mv_par03+"'  AND  BA1_CODEMP <= '"+mv_par04+"' "
      
cQuery += CRLF+ "          GROUP BY BA1_CODINT,BA1_CODEMP,BA1_MATRIC,BA1_TIPREG,BA1_NOMUSR ,BA1_CONEMP ,BA1_SUBCON"
cQuery += CRLF+ "          )TAB1 , "
cQuery += CRLF+ "          "+ RetSqlName("BA1") +" BA11 ," 
cQuery += CRLF+ "          "+ RetSqlName("BA3") +" BA31 ,"

cQuery += CRLF+ "          "+ RetSqlName("BQC") +" BQC1 ,"
cQuery += CRLF+ "          "+ RetSqlName("BT5") +" BT51 "

cQuery += CRLF+ "          WHERE  BA11.BA1_FILIAL='"+xFilial('BA1')+ "'"
cQuery += CRLF+ "            AND  BA31.BA3_FILIAL='"+xFilial('BA3')+ "'"

cQuery += CRLF+ "            AND  BQC1.BQC_FILIAL='"+xFilial('BQC')+ "'"
cQuery += CRLF+ "            AND  BT51.BT5_FILIAL='"+xFilial('BT5')+ "'"
      
cQuery += CRLF+ "            AND  BA11.BA1_CODINT=BA31.BA3_CODINT "
cQuery += CRLF+ "            AND  BA11.BA1_CODEMP=BA31.BA3_CODEMP "
cQuery += CRLF+ "            AND  BA11.BA1_MATRIC=BA31.BA3_MATRIC "
 
cQuery += CRLF+ "            AND  BA11.BA1_CODINT=TAB1.CODINT "
cQuery += CRLF+ "            AND  BA11.BA1_CODEMP=TAB1.CODEMP "
cQuery += CRLF+ "            AND  BA11.BA1_MATRIC=TAB1.MATRIC "
cQuery += CRLF+ "            AND  BA11.BA1_TIPREG=TAB1.TIPREG "
 
cQuery += CRLF+ "            AND  (BA31.BA3_DATBLO = '  ' OR BA31.BA3_DATBLO  >= '"+cCompteI+"01') "
cQuery += CRLF+ "            AND  (BA11.BA1_DATBLO = '  ' OR BA11.BA1_DATBLO  >= '"+cCompteI+"01') "   
cQuery += CRLF+ "            AND  Substr(BA11.BA1_DATINC,1,6) <= '"+cCompteI+"' "
      
cQuery += CRLF+ "            AND  BA11.BA1_CONEMP<>' ' "
      
cQuery += CRLF+ "            AND  ba11.BA1_CODEMP >= '"+mv_par03+"'  AND  ba11.BA1_CODEMP <= '"+mv_par04+"' "

cQuery += CRLF+ "            AND  BA11.D_E_L_E_T_= ' ' "
cQuery += CRLF+ "            AND  BA31.D_E_L_E_T_= ' ' "

cQuery += CRLF+ "            AND  BQC1.D_E_L_E_T_= ' ' "
cQuery += CRLF+ "            AND  BT51.D_E_L_E_T_= ' ' "

cQuery += CRLF+ "            and bqc1.bqc_codigo =  '0001'||ba11.ba1_codemp "
cQuery += CRLF+ "            and bqc1.bqc_numcon = ba11.ba1_conemp "
cQuery += CRLF+ "            and bqc1.bqc_vercon = ba11.ba1_vercon "
cQuery += CRLF+ "            and bqc1.bqc_subcon = ba11.ba1_subcon "
cQuery += CRLF+ "            and bqc1.bqc_versub = ba11.ba1_versub "
// tratamento para NÃO  levar contratos que sejam gratuitos - chamado 82391 - carlos 
cQuery += CRLF+ "            and bqc1.bqc_gratui <>  '1' "
            
cQuery += CRLF+ "            and bt51.bt5_codint =  '0001' "
cQuery += CRLF+ "            and bt51.bt5_codigo = ba11.ba1_codemp "
cQuery += CRLF+ "            and bt51.bt5_numcon = ba11.ba1_conemp "
cQuery += CRLF+ "            and bt51.bt5_versao = ba11.ba1_vercon "
/*
cQuery += CRLF+ "            AND (SELECT count(*) from "+ RetSqlName("PDL") +" PDL " 
cQuery += CRLF+ "                  WHERE PDL_FILIAL = '"+xFilial('PDL')+ "'" 
cQuery += CRLF+ "                    AND PDL.D_e_l_e_t_ = ' ' 
cQuery += CRLF+ "                    AND PDL_COMPTE = '"+cCompteI+"' "
cQuery += CRLF+ "                    AND PDL_CODINT = TAB1.CODINT
cQuery += CRLF+ "                    AND PDL_CODEMP = TAB1.CODEMP
cQuery += CRLF+ "                    AND PDL_MATRIC = TAB1.MATRIC
cQuery += CRLF+ "                    AND PDL_TIPREG = TAB1.TIPREG)=0
*/
// orientado pelo carlos financeiro - chamado 78214
// tratamento para NÃO levar empresa 0402 - chamado 82391 - carlos
cQuery += CRLF+ "           and  TAB1.CODEMP not in ('0402','0392') "

cQuery += CRLF+ "            ORDER BY COMPTE , CODEMP1 "                                            

////////////////////////////////////////       
	   	
If Select((cAliastmp)) <> 0 
   (cAliastmp)->(DbCloseArea())  
Endif                          

//////////////////////////
    TCQuery cQuery New Alias (cAliastmp)
      
    dbSelectArea (cAliastmp)
   
    (cAliastmp)->(dbGoTop())   
     
    While (cAliastmp)->(!Eof())   
       
     //  fCritica() 
     // tratamento para NÃO levar contrato 1 e sub 7 e 8 da empresa 0325 - chamado 82391 - carlos 
       If (cAliastmp)->CODEMP1 = '0325' .AND. (cAliastmp)->CONEMP = '000000000001' .AND. (cAliastmp)->SUBCON $ ('000000007|000000008') 
          (cAliastmp)->(dbSkip()) 	 
          loop
       ElseIf (cAliastmp)->CODEMP1 = '0296'
           fCrit296()
      ElseIf (cAliastmp)->CODEMP1 $ ('0010|0352|0373|0391|0387')     
           fCrit010()  
      Else 
           fCritOut()     
      Endif

      If  fValPdl() .and. (cAliastmp)->COTRPREST > 0

        cMatCmp:= (cAliastmp)->CODINT1+'.'+(cAliastmp)->CODEMP1+'.'+(cAliastmp)->MATRIC1+'.'+(cAliastmp)->TIPREG1    
            aaDD(aDados1,{(cAliastmp)->COMPTE    ,;
                           cMatCmp               ,;
							     (cAliastmp)->NOMUSR    ,;                                                          
							     (cAliastmp)->DATINC1   ,;     
							     (cAliastmp)->DATBLO1   ,;                                                                            
							     (cAliastmp)->DATBLO3   ,;                                                                            
							     (cAliastmp)->COTRPREST ,;
							      ' '                   ,;                    
							      ' '                   ,;                    
							      '  /  /    '          ,;                    
							     DtoS(date())           ,;
	 					        (cAliastmp)->CODPLA1   ,;
							     (cAliastmp)->COBNIV1   ,;                    
							     ADADOS2[3][1]          ,;
							     (cAliastmp)->MOTBLO    ,;
							     (cAliastmp)->LOCBLOQ   ,;
  							     ADADOS2[1][1]          ,;
							     ADADOS2[2][1]          })                                 
   
      EndIf                    
   
     (cAliastmp)->(dbSkip()) 	   
    
   EndDo	                   
 
   cCompteI:= fCCcomp(cCompteI)
 
EndDo	                   
  
If mv_par06 == 1

   fGrvPdl()

EndIf  
 
Return    

*************************************************************************************************************  
Static Function fGeraRel2

Local oReport 
Private cPerg		:= "CABA56"                                                           

Private aOrdem 		:= {}//{'RDA','Ano/Mes'}            
Private lTPageBreak := .T.         


//aSort( aDados1,,,{|x,y| x[10] < y[10]} )

oReport:= ReportDef2()
oReport:PrintDialog()

Return

*************************************************************************************************************

********************************************************************************************************************************

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³ Leonardo Portella                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpO1: Objeto do relatorio                                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/                         

Static Function ReportDef2()

Local oReport 
Local oDPJ        
Local oDPJ1                
oReport	:= TReport():New("CABA156","Relatorio de Acompanhamento , Carga da janela de Cobrança  "  ,, {|oReport| ReportPrt(oReport)},"Relatorio de Acompanhamento , Carga da janela de Cobrança  "  )
oReport:SetTotalInLine(.F.)//Imprime na linha: .F. - Imprime abaixo da linha com o titulo de cada coluna: .T.
//oReport:SetTotalText('Total Geral') 

*'-----------------------------------------------------------------------------------'*
*'Solucao para impressao em que as colunas se truncam: "SetColSpace" e "SetLandScape"'* 
*'-----------------------------------------------------------------------------------'*

oReport:SetColSpace(3) //Espacamento entre colunas. 
oReport:SetLandscape() //Impressao em paisagem.  
//oReport:SetPortrait() //Impressao em retrato.  

oReport:SetTotalPageBreak(lTPageBreak)

oDPJ := TRSection():New(oReport,"Relatorio de Acompanhamento , Carga da janela de Cobrança  " ,,aOrdem)              


   TRCell():New(oDPJ ,'COMPTE'	        	,	,'Compte  '              ,          ,10	    	,,,,,"LEFT" )   
   TRCell():New(oDPJ ,'MATRIC'         		,	,'Matricula Completa '   ,          ,24     	,,,,,"LEFT"	)  
   TRCell():New(oDPJ ,'USUARI'         		,	,'Usuario            '   ,          ,40     	,,,,,"LEFT"	) 
   TRCell():New(oDPJ ,'DATINC'         		,	,'Dt Incl '       ,                 ,12     	,,,,,"LEFT"	)
   TRCell():New(oDPJ ,'LOCBLOQ'         		,	,'Nivel Bloq'     ,                 ,10     	,,,,,"LEFT"	)      
   TRCell():New(oDPJ ,'DTBLO1'         		,	,'Dt Bloq Usr'    ,                 ,12     	,,,,,"LEFT"	)   
   TRCell():New(oDPJ ,'DTBLO3'         		,	,'Dt Bloq Fam'    ,                 ,12     	,,,,,"LEFT"	)   
   TRCell():New(oDPJ ,'VLRCOB'         		,	,'Vlr a Cobrar'   ,"@E 99,999,999.99" ,15     	,,,,,"RIGHT")   
   TRCell():New(oDPJ ,'CREDEB'         		,	,'Lanc. D/C'      ,                 ,10     	,,,,,"LEFT"	)   
   TRCell():New(oDPJ ,'DTLDC'         		,	,'Data D/C'       ,                 ,12     	,,,,,"LEFT"	)   
   TRCell():New(oDPJ ,'LOTCOB'         		,	,'Lote Cobranca'  ,                 ,17     	,,,,,"LEFT"	) 
   TRCell():New(oDPJ ,'DTPROC'         		,	,'Dt Proces.'     ,                 ,12     	,,,,,"LEFT"	) 
   TRCell():New(oDPJ ,'CODPLA'         		,	,'Cod. Plano'     ,                 ,4         	,,,,,"LEFT"	)
   TRCell():New(oDPJ ,'COBNIV'         		,	,'Niv. Cobr.'     ,                 ,2       	,,,,,"LEFT"	)     
   TRCell():New(oDPJ ,'MARCA'         		,	,'Faz Lanc '      ,                 ,01     	,,,,,"RIGHT")    
  
   oBreak01 		:= TRBreak():New(oDPJ,oDPJ:Cell("COMPTE")," total da Compte .....   "	,.F.)  

   lTotSecBrk01	:= .T.//Indica se totalizador sera impresso na quebra de secao
   lTotFimBrk01	:= .T.//Indica se totalizador sera impresso no final do relatorio - Como o total eh o mesmo, basta que apenas um esteja ativado
                                                              
                                                              
   TRFunction():New(oDPJ:Cell("MATRIC")    	  ,NIL,"COUNT"	    	,oBreak01,,"@E 999,999"	        ,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01)  
   TRFunction():New(oDPJ:Cell("VLRCOB")    	  ,NIL,"SUM"	    	,oBreak01,,"@E 999,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01) 
   
**********************  
                                                                                                                 
Return(oReport)

********************************************************************************************************************************

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrint³ Autor ³ Leonardo Portella                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function ReportPrt(oReport)

Local i := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

Local   cImp    :='Não'
Private oDPJ 	:= oReport:Section(1)

Private nCont	:= 0   

nCont := Len(aDados1)

//Se nao tiver esta linha, nao imprime os dados     
  oDPJ:init()
  nCont := Len(aDados1)
  
  oReport:SetMeter(nCont) 

cTot	:= AllTrim(Transform(nCont,'@E 999,999,999,999'))
nCont 	:= 0       

   For i := 1 To Len(aDados1)

    oReport:SetMsgPrint("Imprimindo linha " + AllTrim(Transform(++nCont,'@E 999,999,999,999')) + ' de ' + cTot)

	oReport:IncMeter()

	If oReport:Cancel()  
	    
	    oReport:FatLine()     
	    oReport:PrintText('Cancelado pelo operador!!!',,,CLR_RED,,,.T.)
		
	    exit
	    
	EndIf          

 oDPJ:Cell('COMPTE'):SetValue((aDados1[i][ 1]))    
 oDPJ:Cell('MATRIC'):SetValue((aDados1[i][ 2]))     
 oDPJ:Cell('USUARI'):SetValue((aDados1[i][ 3]))   
 oDPJ:Cell('DATINC'):SetValue((aDados1[i][ 4]))   
 oDPJ:Cell('DTBLO1'):SetValue((aDados1[i][ 5]))      
 oDPJ:Cell('DTBLO3'):SetValue((aDados1[i][ 6]))      
 oDPJ:Cell('VLRCOB'):SetValue((aDados1[i][ 7]))  //(ltrim(Transform(aDados1[i][07],'@E 9,999,999.99')))      
 oDPJ:Cell('CREDEB'):SetValue((aDados1[i][ 8]))    
 oDPJ:Cell('DTLDC' ):SetValue((aDados1[i][10]))    
 oDPJ:Cell('LOTCOB'):SetValue((aDados1[i][ 9]))    
 oDPJ:Cell('DTPROC'):SetValue((aDados1[i][11]))    
 oDPJ:Cell('CODPLA'):SetValue((aDados1[i][12]))    
 oDPJ:Cell('COBNIV'):SetValue((aDados1[i][13]))    
 oDPJ:Cell('MARCA' ):SetValue((aDados1[i][14]))    
 oDPJ:Cell('LOCBLOQ' ):SetValue((aDados1[i][16]))    

       oDPJ:PrintLine()
   
   Next i

   oDPJ:Finish()      

*********************************************************************************
Return  
*********************************************************************************
*********************************************************************************
static function fGrvPdl()

   For i := 1 To Len(aDados1)

  	  reclock("PDL",.T.)                                                       
       
         PDL->PDL_FILIAL := xFilial('PDL')  
			PDL->PDL_COMPTE := aDados1[i][ 1]  
			PDL->PDL_CODINT := SUBSTR(aDados1[i][ 2],1,4)  
			PDL->PDL_CODEMP := SUBSTR(aDados1[i][ 2],6,4)  
			PDL->PDL_MATRIC := SUBSTR(aDados1[i][ 2],11,6)  
			PDL->PDL_TIPREG := SUBSTR(aDados1[i][ 2],18,2)  
			PDL->PDL_NOMUSR := aDados1[i][ 3] 
			PDL->PDL_DTAINC := stod(aDados1[i][ 4])  
			PDL->PDL_DTBLO1 := stod(aDados1[i][ 5])  
			PDL->PDL_DTBLO3 := stod(aDados1[i][ 6])    
			PDL->PDL_VALOR  := aDados1[i][ 7]   
			PDL->PDL_DEBCRE := ' '   
			PDL->PDL_LOTCOB := ' ' 
//			PDL->PDL_DTLANC := stod(aDados1[i][10])   
			PDL->PDL_MARCA  := aDados1[i][14]
			PDL->PDL_PLANO  := aDados1[i][12]  
			PDL->PDL_COBNIV := aDados1[i][13]
			PDL->PDL_DTPROC := DATE() 
			PDL->PDL_MOTBLO := aDados1[i][15]  
         PDL->PDL_CRITIC := aDados1[i][17] 
         PDL->PDL_OBS    := aDados1[i][18] 
         PDL->PDL_CONSID := aDados1[i][16] 
            
     PDL->(MsUnlock())		          
          
   Next i
          
Return  
*********************************************************************************

Static Function AjustaSX1()

Local aHelp 	:= {}

aHelp := {}
aAdd(aHelp, "Informe a Compte Inicial")
U_CABASX1(cPerg , "01" , "Compte Inicial(AAAAMM)" ,"","","mv_ch1","C",6,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aAdd(aHelp, "Informe a Compte Final")
U_CABASX1(cPerg , "02" , "Compte Final(AAAAMM)" ,"","","mv_ch2","C",6,0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aAdd(aHelp, "Informe Empresa Inicial")
U_CABASX1(cPerg , "03" , "Empresa Inicial" ,"","","mv_ch3","C",4,0,0,"G","","","","","mv_par03","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aAdd(aHelp, "Informe Empresa Final")
U_CABASX1(cPerg , "04" , "Empresa Final" ,"","","mv_ch4","C",4,0,0,"G","","","","","mv_par04","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aAdd(aHelp, "Quanto a Valor  ")
U_CABASX1(cPerg,"05", "Sobre o Valor " ,"","","mv_ch5","N",1,0,1,"C","","","","","mv_par05","Diferença ","","","","Falta Lanc","","","","","","","","","","","",aHelp,aHelp,aHelp)

aAdd(aHelp, "Grava Dados   ")
U_CABASX1(cPerg,"06", "Grava Dados ?" ,"","","mv_ch6","N",1,0,1,"C","","","","","mv_par06","Sim","","","","Não","","","","","","","","","","","",aHelp,aHelp,aHelp)

Return  

Static Function fCCcomp(cCompte)



 cAnoComp0 := val(substr(cCompte,1,4)) 
 cMesComp0 := val(substr(cCompte,5,2)) 

If cMesComp0 == 12
   cMesComp1 := 01
   cAnoComp1 := cAnocomp0 + 1
else 
   cMesComp1 := cMesComp0 + 1
   cAnoComp1 := cAnoComp0 
EndIf   
 

Return (alltrim(str(cAnoComp1))+alltrim(strzero(cMesComp1,2)) )


Static Function fCrit296()

/*
Código	Motivo	                        Ação
765+	    SUSPENSÃO TEMP ADMINISTRADORAS	NÃO FATURA MÊS DE SUSPENSÃO 
996-	    CANCELAMENTO PEDIDO RN412/16	FATURA MÊS DE BLOQUEIO      
995+	    DEFINITIVO INADIMPLÊNCIA ADM	NÃO FATURA MÊS DE BLOQUEIO E OS DOIS MESES ANTERIORES.
019-	    TROCA DE PLANO / MAT / SUB-CON	FATURA MÊS DE BLOQUEIO  
094-	    CANCELAMENTO A PEDIDO-RN412/16	FATURA MÊS DE BLOQUEIO 
007-	    SOLICITAÇÃO DA EMPRESA	        FATURA MÊS DE BLOQUEIO 
008+	    DUPLICIDADE DE MATRICULA	    NÃO FATURA MÊS DE BLOQUEIO 
011+	    INCLUSÃO INDEVIDA NO PLANO	    NÃO FATURA MÊS DE BLOQUEIO 
*/

  aDados2:= {}

if (cAliastmp)->MOTBLO $('765|008|011') .and.   substr((cAliastmp)->DATBLO1,1,6) == trim((cAliastmp)->COMPTE)

      aaDD(aDados2,{"1" })

      If (cAliastmp)->MOTBLO == '765'                                
          aaDD(aDados2,{"Bloq. Susp Temp. ADM" })                               
      ElseIf (cAliastmp)->MOTBLO == '008'                                
          aaDD(aDados2,{"Bloq. Dupl. Matricul" })                                     
      ElseIf (cAliastmp)->MOTBLO == '011'                                
          aaDD(aDados2,{"Bloq. Incl. Indevida" })                                 
      EndIf     

      If (cAliastmp)->MOTBLO =='765' 
          aaDD(aDados2,{"T" })
      Else     
          aaDD(aDados2,{"F" })
      EndIf     

//       aaDD(aDados2,{"Bloq. Def Comptencia" })                                      
ElseIf (cAliastmp)->MOTBLO == '995'
 
          fCCcomp3(trim((cAliastmp)->DATBLO1))

     If   trim((cAliastmp)->COMPTE) == cCompte0 ;
     .or. trim((cAliastmp)->COMPTE) == cCompte1 ;
     .or. trim((cAliastmp)->COMPTE) == cCompte2 
   
   /*  If   trim((cAliastmp)->COMPTE) == cCompte0 ;
     .or. trim((cAliastmp)->COMPTE) == cCompte1 
   */  
   
          aaDD(aDados2,{"1" })                                 
          aaDD(aDados2,{"Bloq. Def Temporario" })                                 
          aaDD(aDados2,{"F" })
     Else 
          aaDD(aDados2,{"0" })                                 
          aaDD(aDados2,{" " })                                 
          aaDD(aDados2,{"T" })       
     EndIf      
else 
      aaDD(aDados2,{"0" })                                 
      aaDD(aDados2,{" " })                                 
      aaDD(aDados2,{"T" })

 EndIF      
                                       
Return (adados2)

Static Function fCrit010()

/*
Código	Motivo	                        Ação
765+	    SUSPENSÃO TEMP ADMINISTRADORAS	NÃO FATURA MÊS DE SUSPENSÃO 
996-	    CANCELAMENTO PEDIDO RN412/16	FATURA MÊS DE BLOQUEIO      
995+	    DEFINITIVO INADIMPLÊNCIA ADM	NÃO FATURA MÊS DE BLOQUEIO E OS DOIS MESES ANTERIORES.
019-	    TROCA DE PLANO / MAT / SUB-CON	FATURA MÊS DE BLOQUEIO  
094-	    CANCELAMENTO A PEDIDO-RN412/16	FATURA MÊS DE BLOQUEIO 
007-	    SOLICITAÇÃO DA EMPRESA	        FATURA MÊS DE BLOQUEIO 
008+	    DUPLICIDADE DE MATRICULA	    NÃO FATURA MÊS DE BLOQUEIO 
011+	    INCLUSÃO INDEVIDA NO PLANO	    NÃO FATURA MÊS DE BLOQUEIO 
*/

  aDados2:= {}

 if (cAliastmp)->MOTBLO $('765|008|011') .and.   substr((cAliastmp)->DATBLO1,1,6) == trim((cAliastmp)->COMPTE)

      aaDD(aDados2,{"1" })

      If (cAliastmp)->MOTBLO == '765'                                
          aaDD(aDados2,{"Bloq. Susp Temp. ADM" })                               
      ElseIf (cAliastmp)->MOTBLO == '008'                                
          aaDD(aDados2,{"Bloq. Dupl. Matricul" })                                     
      ElseIf (cAliastmp)->MOTBLO == '011'                                
          aaDD(aDados2,{"Bloq. Incl. Indevida" })                                 
      EndIf     

          aaDD(aDados2,{"F" })
          

//       aaDD(aDados2,{"Bloq. Def Comptencia" })                                      
 ElseIf (cAliastmp)->MOTBLO == '995'
 
          fCCcomp3(trim((cAliastmp)->DATBLO1))

     If   trim((cAliastmp)->COMPTE) == cCompte0 ;
     .or. trim((cAliastmp)->COMPTE) == cCompte1 ;
     .or. trim((cAliastmp)->COMPTE) == cCompte2 
   
   /*  
      If   trim((cAliastmp)->COMPTE) == cCompte0 ;
     .or. trim((cAliastmp)->COMPTE) == cCompte1 
   */  
   
          aaDD(aDados2,{"1" })                                 
          aaDD(aDados2,{"Bloq. Def Temporario" })                                 
          aaDD(aDados2,{"F" })
     Else 
          aaDD(aDados2,{"0" })                                 
          aaDD(aDados2,{" " })                                 
          aaDD(aDados2,{"T" })       
     EndIf      
else 
      aaDD(aDados2,{"0" })                                 
      aaDD(aDados2,{" " })                                 
      aaDD(aDados2,{"T" })

 EndIF      
                                       
Return (adados2)

////// outras empresas

Static Function fCritOut()

Local cQuery2 :=  ' '

/*
Código	Motivo	                        Ação
765+	    SUSPENSÃO TEMP ADMINISTRADORAS	NÃO FATURA MÊS DE SUSPENSÃO 
996-	    CANCELAMENTO PEDIDO RN412/16	FATURA MÊS DE BLOQUEIO      
995+	    DEFINITIVO INADIMPLÊNCIA ADM	NÃO FATURA MÊS DE BLOQUEIO E OS DOIS MESES ANTERIORES.
019-	    TROCA DE PLANO / MAT / SUB-CON	FATURA MÊS DE BLOQUEIO  
094-	    CANCELAMENTO A PEDIDO-RN412/16	FATURA MÊS DE BLOQUEIO 
007-	    SOLICITAÇÃO DA EMPRESA	        FATURA MÊS DE BLOQUEIO 
008+	    DUPLICIDADE DE MATRICULA	    NÃO FATURA MÊS DE BLOQUEIO 
011+	    INCLUSÃO INDEVIDA NO PLANO	    NÃO FATURA MÊS DE BLOQUEIO 
*/

  aDados2:= {}
////////////////////////////////////////       
	   	
   If  Empty((cAliastmp)->MOTBLO)

       aaDD(aDados2,{"0" })                                 
       aaDD(aDados2,{"Sem bloqueio" })                                 
       aaDD(aDados2,{"T" })

   Else 
   
      cQuery2 := CRLF+ " select ba1_codemp , ba1_matric , ba1_tipreg , ba1_datblo , ba1_motblo , "
      cQuery2 += CRLF+ "        decode(trim(ba1_datblo),'' , 'sem bloqueio' ,   "
      cQuery2 += CRLF+ "        decode(trim(CASE WHEN BA1_consid = 'U' THEN NVL(BLQU.blqans, ' ' ) "   
      cQuery2 += CRLF+ "                         WHEN BA1_consid = 'F' THEN NVL(BLQF.blqans, ' ' ) " 
      cQuery2 += CRLF+ "                         WHEN BA1_consid = 'S' THEN NVL(BLQS.blqans, ' ' ) "
      cQuery2 += CRLF+ "                    Else 'S/Descriçao' END),null,'Bloq Temp','Bloq Def')) BLOANS1 ,"  
   
      cQuery2 += CRLF+ "                    CASE WHEN BA1_consid = 'U' THEN NVL(BLQU.DESCRI, ' ' )   
      cQuery2 += CRLF+ "                         WHEN BA1_consid = 'F' THEN NVL(BLQF.DESCRI, ' ' )   
      cQuery2 += CRLF+ "                         WHEN BA1_consid = 'S' THEN NVL(BLQS.DESCRI, ' ' )   
      cQuery2 += CRLF+ "                    Else 'S/Descriçao' END DESCBLO1 ,
                     
      cQuery2 += CRLF+ "                    CASE WHEN BA1_consid = 'U' THEN NVL(BLQU.ORIGEM, ' ' )   
      cQuery2 += CRLF+ "                         WHEN BA1_consid = 'F' THEN NVL(BLQF.ORIGEM, ' ' )   
      cQuery2 += CRLF+ "                         WHEN BA1_consid = 'S' THEN NVL(BLQS.ORIGEM, ' ' )   
      cQuery2 += CRLF+ "                    Else 'S/Descriçao' END ORIGEMBLO1 ,
                     
      cQuery2 += CRLF+ "                    CASE WHEN BA1_consid = 'U' THEN NVL(BLQU.blofat, ' ' )   
      cQuery2 += CRLF+ "                         WHEN BA1_consid = 'F' THEN NVL(BLQF.blofat, ' ' )    
      cQuery2 += CRLF+ "                         WHEN BA1_consid = 'S' THEN NVL(BLQS.bloFat, ' ' )   
      cQuery2 += CRLF+ "                    Else 'S/Descriçao' END BLOFAT1
      
      cQuery2 += CRLF+ "   from "+ RetSqlName("BA1") +" BA1 , "  
   
      cQuery2 += CRLF+ "   ( select 'usuario' origem  , bg3_codblo codblo , bg3_desblo descri , bg3_blqans blqans , bg3_blofat blofat from "+ RetSqlName("BG3") +" BG3 WHERE BG3_FILIAL= '"+xFilial('BG3')+ "'  AND BG3.d_e_l_e_t_ = ' ') blqu , "  
      cQuery2 += CRLF+ "   ( select 'familia' origem  , bg1_codblo codblo , bg1_desblo descri , bg1_blqans blqans , bg1_blofat blofat from "+ RetSqlName("BG1") +" BG1 WHERE BG1_FILIAL= '"+xFilial('BG1')+ "'  AND BG1.d_e_l_e_t_ = ' ') blqf , "  
      cQuery2 += CRLF+ "   ( select 'sub_cont' origem , bqu_codblo codblo , bqu_desblo descri , bqu_blqans blqans , bqu_blofat blofat from "+ RetSqlName("BQU") +" BQU WHERE BQU_FILIAL= '"+xFilial('BQU')+ "'  AND BQU.d_e_l_e_t_ = ' ') blqs   "
   
      cQuery2 += CRLF+ "   where ba1_filial = ' ' and d_E_L_E_T_ = ' '   "
   
      cQuery2 += CRLF+ "    AND BA1_CODINT = '"+(cAliastmp)->CODINT1+"'"
      cQuery2 += CRLF+ "    AND BA1_CODEMP = '"+(cAliastmp)->CODEMP1+"'"
      cQuery2 += CRLF+ "    AND BA1_MATRIC = '"+(cAliastmp)->MATRIC1+"'"
      cQuery2 += CRLF+ "    AND BA1_TIPREG = '"+(cAliastmp)->TIPREG1+"'"   
   
      cQuery2 += CRLF+ "    and ba1_motblo = BLQU.CODBLO(+) "  
      cQuery2 += CRLF+ "    and ba1_motblo = BLQF.CODBLO(+) "  
      cQuery2 += CRLF+ "    and ba1_motblo = BLQS.CODBLO(+) "
   
      If Select((cAliasBlc)) <> 0 
      (cAliasBlc)->(DbCloseArea())  
      Endif                          

      TCQuery cQuery2 New Alias (cAliasBlc)
         
      dbSelectArea (cAliasBlc)
   
      (cAliasBlc)->(dbGoTop())   

      If (cAliasBlc)->(!Eof())

         if trim((cAliasBlc)->BLOFAT1) == '1'  .and. substr((cAliastmp)->DATBLO1,1,6) == trim((cAliastmp)->COMPTE)

            aaDD(aDados2,{"1" })                        
            aaDD(aDados2,{(cAliasBlc)->DESCBLO1 })                               
            aaDD(aDados2,{"F" })

         Else 

            aaDD(aDados2,{"0" })                        
            aaDD(aDados2,{(cAliasBlc)->DESCBLO1 })                               
            aaDD(aDados2,{"T" })   

         Endif

      EndIf

   EndIf

    If  len(adados2)==0

        aaDD(aDados2,{"0" })                                 
        aaDD(aDados2,{"Sem bloqueio" })                                 
        aaDD(aDados2,{"T" })
      
    EndIf 

Return (adados2)
////////////////////////////////

Static Function fCCcomp3(cCompte)

 local Ret:= ' ' 
  
 local cAnoComp0 := val(substr(cCompte,1,4)) 
 local cMesComp0 := val(substr(cCompte,5,2)) 

 local cAnoComp1 := val(substr(cCompte,1,4)) 
 local cMesComp1 := val(substr(cCompte,5,2)) 

 local cAnoComp2 := val(substr(cCompte,1,4)) 
 local cMesComp2 := val(substr(cCompte,5,2)) 
  
 If cMesComp0 == 01 

   cMesComp1 := 12
   cAnoComp1 := cAnocomp0 - 1
   
   cMesComp2 := 11
   cAnoComp2 := cAnocomp0 - 1

elseIf cMesComp0 == 02  

   cMesComp1 := 01
   cAnoComp1 := cAnoComp0 
   
   cMesComp2 := 12
   cAnoComp2 := cAnocomp0 - 1

else    

   cMesComp1 := cMesComp0 - 1
   cAnoComp1 := cAnocomp0 
   
   cMesComp2 := cMesComp0 - 2
   cAnoComp2 := cAnocomp0 

EndIf 

cCompte0    := strzero(cAnocomp0,4)+strzero(cMesComp0,2) 
cCompte1    := strzero(cAnocomp1,4)+strzero(cMesComp1,2) 
cCompte2    := strzero(cAnocomp2,4)+strzero(cMesComp2,2)  
 
Return (Ret)

static function fValPdl()

Local cQuery1 :=  ' '
Local lRet    := .F.

If nImpCrit == 0 .and. !empty(ADADOS2[1][1])
   lRet:= .F.
Else  
   lRet:= .T.

   cQuery1 := CRLF+ " SELECT * from "+ RetSqlName("PDL") +" PDL " 
   cQuery1 += CRLF+ "  WHERE PDL_FILIAL = '"+xFilial('PDL')+ "'" 
   CQuery1 += CRLF+ "    AND PDL.D_e_l_e_t_ = ' ' 
   cQuery1 += CRLF+ "    AND PDL_COMPTE = '"+cCompteI+"' "
   cQuery1 += CRLF+ "    AND PDL_CODINT = '"+(cAliastmp)->CODINT1+"'"
   cQuery1 += CRLF+ "    AND PDL_CODEMP = '"+(cAliastmp)->CODEMP1+"'"
   cQuery1 += CRLF+ "    AND PDL_MATRIC = '"+(cAliastmp)->MATRIC1+"'"
   cQuery1 += CRLF+ "    AND PDL_TIPREG = '"+(cAliastmp)->TIPREG1+"'"   
   cQuery1 += CRLF+ "    AND PDL_CRITIC = '"+ADADOS2[1][1]+"'"
////////////////////////////////////////       
	   	
   If Select((cAliasTst)) <> 0 
     (cAliasTst)->(DbCloseArea())  
   Endif                          

//////////////////////////
    TCQuery cQuery1 New Alias (cAliasTst)
      
    dbSelectArea (cAliasTst)
  
    (cAliasTst)->(dbGoTop())   

     If (cAliasTst)->(!Eof())

         lRet:= .F.
         
     Else 
     
         lRet:= .T.
     
     EndIf    
   
EndIf     
REturn(lRet)
