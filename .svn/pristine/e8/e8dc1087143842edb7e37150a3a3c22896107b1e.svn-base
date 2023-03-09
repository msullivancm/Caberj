#INCLUDE "PROTHEUS.CH"
#Include "TOPCONN.CH"
                             
/*/                                                                                      
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±…ÕÕÕÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕª±±
±±∫Programa  ≥CABR215   ∫ Autor ≥Altamiro              ∫ Data ≥ 01/10/12  ∫±±
±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕπ±±
±±∫Descricao ≥ Rotina para CONFERENCIA da PRIMAVIDA contra a CABERJ       ∫±±
±±∫          ≥                                                            ∫±±
±±»ÕÕÕÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕº±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
/*/                  

User Function CABR215()

Local   nCont		:= 0  
local   I           := 0    
Local   cMsg		:= ""
Private cDpj        := 'N„o'   
private cImp        := 'N„o'
Private oLeTxt
Private lAbortPrint :=.F.
Private cPerg       := "CABR215"
Private cTitulo     := "Conferencia Prima vida "
Private lpvez       :=.T.   
Private cTpCrit     :=" "  
Private lImporta    := .F.  
Private f_ok        := .F.
Private nLocaliz    := 0 // 1 - zzq -- 2 se2  -- 0 nao localizado        
private lOk         :=.F.
Private nSald_tit   := 0            
Private nVlr_Caberj := 0      
Private nVlr_Calc   := 0          
Private nVlr_ReCalc := 0
Private nsaldo_pgto := 0  

private adados1     := {}    

private adados2     := {}   

private nVLDEVPRIMA := 0		  
private nqtda       := 0 

private cpgto       := ' '    

private cTitCSald   := ' '   
PRIVATE nVlrTitPri  := 0.00
PRIVATE nVlrTitcmp  := 0.00   
private cNomeArq1   := ' '                
         
 
 AjustaSX1(cPerg)

cCompMes    := SUBSTR(mv_par01,1,2) 
cCompAno    := SUBSTR(mv_par01,4,4)    
cMatric     := mv_par04

//Leonardo Portella - 11/10/16 - InÌcio - Alterar o par‚metro fixo para 2 pois como 1 ele somente lista, 2 processa

//nListar     := Aviso('Selecione a opÁ„o','Selecione o modo de operaÁ„o:',{'Listar', 'Processar'})
//nListar   := 1 //mv_par02 

//Leonardo Portella - 11/10/16 - Fim 

nReproc     := mv_par03  
nReproc     := 2  // sem reprocessamento 
 
fVerifcal(cCompMes,cCompAno)                   

   cTitulo     := " Calculo repasse Prima vida  - "+ mv_par01 + " " 
   Processa({||Processa1()}, cTitulo, "", .T.) 

//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
//≥ Libera impressao                                                         ≥
//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ

//For I:= 1 to 3   

   u_cabr224(cCompAno,cCompMes) 
 
//Next                                         
 
MsgInfo("Processo finalizado")

Return                 

**************************************************************************

/*/
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±…ÕÕÕÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕª±±
±±∫FunáÑo    ≥ PROCESSA1∫ Autor ≥ Jean Schulz        ∫ Data ≥  11/11/06   ∫±±
±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕπ±±
±±∫DescriáÑo ≥ Funcao auxiliar chamada pela PROCESSA.  A funcao PROCESSA  ∫±±
±±∫          ≥ monta a janela com a regua de processamento.               ∫±±
±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕπ±±
±±∫Uso       ≥ Programa principal                                         ∫±±              
±±»ÕÕÕÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕº±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
/*/
Static Function Processa1()        

    If tmp1->QTDPROC > 0 // .and.  nListar == 1 
       FGrvPlan()
       fGeraRel() 
       fGeraRel1() 
       Return()
    ElseIf ( ( tmp1->QTDPROC >  0 .and.  nReproc != 1 );
         .or.( tmp1->QTDPROC == 0 .and.  nReproc == 1 ) )

       If tmp1->QTDPROC > 0 .and. nReproc != 1    
          MsgAlert("Arquivo Ja Processado, Grando Planilha e Relatorios ","Atencao!")      
          Return()
       Else 
          MsgAlert("Arquivo N√O processado,  ","Atencao!")    
          Return()  
       EndIf    
  
    EndIf        
      
    //////

   cQuery := " SELECT Bm1.bm1_codint ||'.'|| Bm1.bm1_codemp ||'.'|| Bm1.bm1_matric ||'-'|| Bm1.bm1_tipreg ||'.'|| Bm1.bm1_digito  matrbm1 , "
   cQuery += CRLF +" bm1.bm1_nomusr nome,   BM1_ANO , BM1_MES , BM1_NUMPAR , BM1_VALOR ,"
   cQuery += CRLF +"  E1_PREFIXO , E1_NUM , E1_TIPO , E1_VENCREA , E1_BAIXA , E1_VALOR , E1_SALDO  , bm1_deseve  ,  ba1.BA1_TIPUSU TIPUSU , BM1.R_e_c_n_o_ BM1REC , bm1_Yvlpri vlpri  , "
   cQuery += CRLF +"  BM1_YVLPRI VLRCALC , BM1_DTCPR DTCALC , BM1_YVLPR1 VLRRCALC , BM1_DTCPR1 DTRCALC  , BM1_CODPLA codpla , BM1_CODEVE codeve ,  "   
   
   cQuery += CRLF +"  nome_plano  , valor_parte_dental vl_odont "
            
   cQuery += CRLF +"  FROM " + RetSqlName("BM1") + " BM1 , " + RetSqlName("SE1") + " SE1  , " + RetSqlName("BA1") + " BA1 , SIGA.VALOR_PARTE_ODONTO_PREFEITURA " 
   cQuery += CRLF +"  WHERE BM1_FILIAL = '" + xFilial("BM1") +"' AND BM1.D_E_L_E_T_ = ' '  "
   cQuery += CRLF +"    AND E1_FILIAL  = '" + xFilial("SE1") +"' AND SE1.D_E_L_E_T_ = ' '  " 
   cQuery += CRLF +"    AND BA1.BA1_FILIAL = '" + xFilial("BA1") +"' AND BA1.D_E_L_E_T_ = ' '  " 
   cQuery += CRLF +"    AND BM1_MES    = '"+cCompMes +"' "
   cQuery += CRLF +"    AND BM1_ANO    = '"+cCompAno+"'"                    
   If !EMPTY(cMatric)
      cQuery += CRLF +"    AND BM1_CODINT || BM1_CODEMP||bm1_matric||BM1_TIPREG ||BM1_DIGITO  = '"+cMatric+"' "
   EndIf                                                        
   If nReproc == 1
      cQuery += CRLF +"    AND E1_SALDO    =  0  AND  BM1_YVLPR1 = 0  "
      cQuery += CRLF +"    AND ((BM1_valor =  9  AND  BM1_YVLPRI = 0) " 
      cQuery += CRLF +"     OR  (BM1_valor =  26.95  AND  BM1_YVLPRI = 8.5)  " 
      cQuery += CRLF +"     OR  (BM1_valor =  26.95  AND  BM1_YVLPRI = 0)) "
   EndIf     
   cQuery += CRLF +"    AND BM1_CODEMP in ( '0024' , '0025','0027','0028') " 
 
   If  cCompAno+cCompMes <='201607'
       cQuery += CRLF +"    AND BM1_CODTIP = '102' AND BM1_CODEVE  IN ('0103','0105')" 
   Else     
       cQuery += CRLF +"    AND BM1_CODTIP = '101' "
   EndIf 
       
   cQuery += CRLF +"    AND E1_PREFIXO =  BM1_PREFIX     "
   cQuery += CRLF +"    AND E1_NUM     =  BM1_NUMTIT     "
   cQuery += CRLF +"    AND E1_TIPO    =  BM1_TIPTIT     "                                      
   cQuery += CRLF +"    AND  BM1_CODINT = ba1.BA1_CODINT "
   cQuery += CRLF +"    AND  BM1_CODEMP = ba1.BA1_CODEMP "
   cQuery += CRLF +"    AND  BM1_MATRIC = ba1.BA1_MATRIC "
   cQuery += CRLF +"    AND  BM1_TIPREG = ba1.BA1_TIPREG "
   cQuery += CRLF +"    AND  BM1_DIGITO = ba1.BA1_DIGITO "       
   
   cQuery += CRLF +"    AND  BM1_codeve = cod_plano  "      
   
   

   cQuery += CRLF +"  ORDER BY BM1_CODINT , BM1_CODEMP , BM1_MATRIC , BM1_TIPREG , BM1_DIGITO "    
  
 If Select(("TMP")) <> 0 
       ("TMP")->(DbCloseArea()) 
 Endif
    
    TCQuery cQuery Alias "TMP" New 
                                                                                           
    dbSelectArea("TMP")
   
    tmp->(dbGoTop())                    
   
   DBSELECTAREA('BM1')  

   Fconfcob()     

   FGrvPlan()  
   
   FGeraRel() 
   
   FGeraRel1() 

Return()               

Static Function Fconfcob()   
                               
While !(TMP->(Eof()))             

 nValorcab   := TMP->bm1_valor                                                                                                                                                                                                    

//  If  TMP->CODEVE = '0103'
//If  TMP->CODPLA $('0112,0114,0117,0121,0126,0128')   // planos E

  If TMP->TIPUSU = 'T'  
     
     If TMP->E1_SALDO == 0              
             
        nVlrTitPri := (tmp->vl_odont * 0.75 )
        
     Else 
           
        nVlrTitPri :=  5.67       
              
     EndIf                        
          
     lOk:=.T.           
                
  Else                       

     If TMP->E1_SALDO == 0
                    
        nVlrTitPri :=  (tmp->vl_odont * 0.75 )   
                   
        lOk:=.T.
     
     Else                         
          
        nVlrTitPri :=  0.00   
             
        lOk:=.F.    
                       
     EndIf                  
           
  EndIf                   
  
 /*     
//  ElseIf  TMP->CODEVE = '0105'          
ElseIf  TMP->CODPLA $('0113,0115,0119,0123,0127,0129')  // planos M

      If  TMP->TIPUSU = 'T'  

          lOk:=.T.

          If TMP->E1_SALDO == 0
                    
             nVlrTitPri :=  20.12       
             
          Else                          
          
             nVlrTitPri :=  7.14       
                       
          EndIf                            
         
      Else                       
          If TMP->E1_SALDO == 0
                    
             nVlrTitPri :=  20.12       
             
             lOk:=.T.
          
          Else                          
          
             nVlrTitPri :=  0.00       
                  
             lOk:=.F.
                       
          EndIf                  
           
      EndIf                   
             
  EndIf 
               
*/ 

  If lOk==.T.         
                                       
   (dbGoTo( TMP->BM1REC ))  
                           
    RecLock("BM1",.F.)     
      
    If nReproc == 2  
       If BM1->BM1_YVLPRI == 0  
   
          BM1->BM1_YVLPRI:= nVlrTitPri 
          BM1->BM1_DTCPR := DATE()   
          
       EndIf
       
    ElseIf nReproc == 1                       

        If BM1->BM1_YVLPR1 == 0 .and. nVlrTitPri - BM1->BM1_YVLPRI > 0
         
           BM1->BM1_YVLPR1 :=  nVlrTitPri - BM1->BM1_YVLPRI 
       
           BM1->BM1_DTCPR1 := DATE()   
      
        EndIf
    
    EndIf     

    Msunlock("BM1")      

EndIf
    tmp->(DbSkip())

EndDo 
    
RETURN ()

Static Function AjustaSX1(cPerg)

Local aHelpPor := {}

PutSx1(cPerg,"01",OemToAnsi("Mes/Ano Repasse ?  ") 		,"","","mv_ch1","C",07,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","99/9999",aHelpPor,{},{})
//PutSx1(cPerg,"02",OemToAnsi("Somente Listar  ?  ")     	,"","","mv_ch2","N",01,0,0,"C","","","","","mv_par02","Sim ","","","","N„o ","",""," ","","","","","","","","",{},{},{})   
//PutSx1(cPerg,"03",OemToAnsi("Reprocessar     ?  ")     	,"","","mv_ch3","N",01,0,0,"C","","","","","mv_par03","Sim ","","","","N„o ","",""," ","","","","","","","","",{},{},{})   
//PutSx1(cPerg,"04",OemToAnsi("Matr. Completa     ") 		,"","","mv_ch4","C",17,0,0,"G","","","","","mv_par04","","","","","","","","","","","","","","","","",aHelpPor,{},{})

Pergunte(cPerg,.T.)

Return 

Static Function FGrvPlan()
// --resumo base             
If 	cCompAno+cCompMes <='201607'
	cQuery := "       SELECT BM1_CODEMP Emp   , "
	cQuery += CRLF +"       DECODE(trim(BM1_CODEVE) ,'0103' , ('DENTAL - E - ' || bm1_valor) "
	cQuery += CRLF +"                               ,'0105' , ('DENTAL - M - ' || bm1_valor) "
	cQuery += CRLF +"                               , ('DESCONHECIDO - '|| bm1_valor)) Plano_base , " 
	cQuery += CRLF +"       BM1_CODPLA||' - ' ||bm1_despla plano , "
	cQuery += CRLF +"       sum(BM1_VALOR)  Vlr_Caberj , "
	cQuery += CRLF +"       sum(BM1_YVLPRI) Vlr_Calc , "     
	cQuery += CRLF +"       sum(BM1_YVLPR1) Vlr_ReCalc , "
	cQuery += CRLF +"       SUM(DECODE(trim(BM1_CODEVE) ,'0103',7.14,'0105',20.12,0.00)) VLR_DEV_PRIMA , "
	cQuery += CRLF +"       count(*) qtda , "
	cQuery += CRLF +"       SUM(DECODE(trim(BM1_CODEVE) ,'0103',7.14,'0105',20.12,0.00) - ( bm1_yvlprI+bm1_yvlpr1)) saldo_pgto  , bm1_yvlprI Vlrpri " 
	cQuery += CRLF +"  FROM  " + RetSqlName("BM1") + " BM1 "
	cQuery += CRLF +" WHERE BM1_FILIAL = '" + xFilial("BM1") +"' AND BM1.D_E_L_E_T_ = ' '  "  
	cQuery += CRLF +"   AND BM1_MES    = '"+cCompMes+"' "
	cQuery += CRLF +"   AND BM1_ANO    = '"+cCompAno+"' "  
	cQuery += CRLF +"   AND BM1_CODEMP in ( '0024' , '0025','0027','0028') "
	cQuery += CRLF +"   AND BM1_CODTIP = '102' and BM1_CODEVE IN  ('0103','0105') "
	cQuery += CRLF +" group by   BM1_CODEMP  , BM1_CODPLA||' - ' ||bm1_despla ,  "
	cQuery += CRLF +"       DECODE(trim(BM1_CODEVE) ,'0103' , ('DENTAL - E - ' || bm1_valor) "
	cQuery += CRLF +"                         ,'0105' , ('DENTAL - M - ' || bm1_valor) "
	cQuery += CRLF +"                                 , ('DESCONHECIDO - '|| bm1_valor))  , bm1_yvlprI "
	cQuery += CRLF +" order by 1,2 "

Else  

	cQuery :=       " SELECT BM1_CODEMP EMP , "
	cQuery += CRLF +"        DECODE(TRIM(BM1_CODPLA ) ,'0112' , ('STANDARD - E - ' || VALOR_PARTE_DENTAL )      ,'0114' , ('STANDARD RIO - E - ' || VALOR_PARTE_DENTAL ) "
	cQuery += CRLF +"                                 ,'0117' , ('ESSENCIAL RIO - E - ' || VALOR_PARTE_DENTAL ) ,'0121' , ('MAIS RIO - E - ' || VALOR_PARTE_DENTAL ) "
	cQuery += CRLF +"                                 ,'0126' , ('MULTI RIO - E - ' || VALOR_PARTE_DENTAL )     ,'0128' , ('TOTAL RIO - E - ' || VALOR_PARTE_DENTAL ) "           
	cQuery += CRLF +"                                 ,'0113' , ('STANDARD - M - ' || VALOR_PARTE_DENTAL )      ,'0115' , ('STANDARD RIO - M - ' || VALOR_PARTE_DENTAL ) "                                    
	cQuery += CRLF +"                                 ,'0119' , ('ESSENCIAL RIO - M - ' || VALOR_PARTE_DENTAL ) ,'0123' , ('MAIS RIO - M - ' || VALOR_PARTE_DENTAL ) "
	cQuery += CRLF +"                                 ,'0127' , ('MULTI RIO - M - ' || VALOR_PARTE_DENTAL )     ,'0129' , ('TOTAL RIO - M - ' || VALOR_PARTE_DENTAL ) "                                    
	cQuery += CRLF +"              ) PLANO_BASE ,  "
	cQuery += CRLF +"        BM1_CODPLA||' - ' ||BM1_DESPLA PLANO  , "
	cQuery += CRLF +"        SUM( VALOR_PARTE_DENTAL )  VLR_CABERJ , "
	cQuery += CRLF +"        SUM( BM1_YVLPRI ) VLR_CALC   , "     
	cQuery += CRLF +"        SUM( BM1_YVLPR1 ) VLR_RECALC , "
	cQuery += CRLF +"        SUM( VALOR_PARTE_DENTAL * 0.75 ) VLR_DEV_PRIMA , "
	cQuery += CRLF +"        COUNT(*) QTDA , "
	cQuery += CRLF +"        SUM( VALOR_PARTE_DENTAL * 0.75 - ( BM1_YVLPRI+BM1_YVLPR1)) SALDO_PGTO  ,  "
	cQuery += CRLF +"        VALOR_PARTE_DENTAL Vlrpri "
    cQuery += CRLF +"  FROM  " + RetSqlName("BM1") + " BM1 , SIGA.VALOR_PARTE_ODONTO_PREFEITURA "
	cQuery += CRLF +" WHERE BM1_FILIAL = '" + xFilial("BM1") +"' AND BM1.D_E_L_E_T_ = ' '  "  
	
	cQuery += CRLF +"   AND BM1_MES    = '"+cCompMes+"' "
	cQuery += CRLF +"   AND BM1_ANO    = '"+cCompAno+"' "  
	
	cQuery += CRLF +"   AND  BM1_CODEMP IN ( '0024' , '0025','0027','0028')  "
	cQuery += CRLF +"   AND  BM1_CODTIP = '101' "                                  
	cQuery += CRLF +"   AND  BM1_CODPLA = COD_PLANO "
	cQuery += CRLF +" GROUP  BY BM1_CODEMP  ,  "       
	
    cQuery += CRLF +"        DECODE(TRIM(BM1_CODPLA ) ,'0112' , ('STANDARD - E - ' || VALOR_PARTE_DENTAL )      ,'0114' , ('STANDARD RIO - E - ' || VALOR_PARTE_DENTAL ) "
	cQuery += CRLF +"                                 ,'0117' , ('ESSENCIAL RIO - E - ' || VALOR_PARTE_DENTAL ) ,'0121' , ('MAIS RIO - E - ' || VALOR_PARTE_DENTAL ) "
	cQuery += CRLF +"                                 ,'0126' , ('MULTI RIO - E - ' || VALOR_PARTE_DENTAL )     ,'0128' , ('TOTAL RIO - E - ' || VALOR_PARTE_DENTAL ) "           
	cQuery += CRLF +"                                 ,'0113' , ('STANDARD - M - ' || VALOR_PARTE_DENTAL )      ,'0115' , ('STANDARD RIO - M - ' || VALOR_PARTE_DENTAL ) "                                    
	cQuery += CRLF +"                                 ,'0119' , ('ESSENCIAL RIO - M - ' || VALOR_PARTE_DENTAL ) ,'0123' , ('MAIS RIO - M - ' || VALOR_PARTE_DENTAL ) "
	cQuery += CRLF +"                                 ,'0127' , ('MULTI RIO - M - ' || VALOR_PARTE_DENTAL )     ,'0129' , ('TOTAL RIO - M - ' || VALOR_PARTE_DENTAL )), "                                    
	
    cQuery += CRLF +"        BM1_CODPLA||' - ' ||BM1_DESPLA  , "
    cQuery += CRLF +"        VALOR_PARTE_DENTAL "
	
//	 BM1_CODEMP , BM1_CODPLA , BM1_VALOR , BM1_YVLPRI , VALOR_PARTE_DENTAL , BM1_CODPLA||' - ' ||BM1_DESPLA "
	cQuery += CRLF +" ORDER  BY 1 , 3 "
 
EndIf 
If Select(("TMP")) <> 0 
          ("TMP")->(DbCloseArea()) 
Endif
    
TCQuery cQuery Alias "TMP" New 
                                                                                           
dbSelectArea("TMP")
              
// resumo base     
   If TMP1->QTDREPROC > 0
      cNomDadCab:=  '1 - Reprocessamento - Resumo Base CABERJ '
   Else 
      cNomDadCab:=  '1 - Processamento - Resumo Base CABERJ '
   EndIf 
         
   cComp     :=  cCompMes+'/'+cCompAno
   cNomPla   := cNomDadCab                 
 
     	cNomeArq := "C:\TEMP\"+cCompAno+cCompMes+" - "+cNomDadCab+"_"+SubStr(DtoS(date()),7,2)+"_"+SubStr(DtoS(date()),5,2)+"_"+SubStr(DtoS(date()),1,4)+"_"+STRTRAN(TIME(),":","_")+".csv"

		nHandle := FCREATE(cNomeArq)
        cMontaTxt := cNomDadCab
        cMontaTxt += CRLF
        FWrite(nHandle,cMontaTxt)       		 
        cMontaTxt := 'Competencia : ' + cComp
        cMontaTxt += CRLF
        FWrite(nHandle,cMontaTxt)		 
        cMontaTxt := 'Planilha : '+cNomPla  
        cMontaTxt += CRLF
        FWrite(nHandle,cMontaTxt)	 
        
        cMontaTxt := "Empresa ;"
		cMontaTxt += "Plano base   ;"   
		cMontaTxt += "Plano   ;" 		
        cMontaTxt += "Vlr Primavida ;"             
		cMontaTxt += "Vlr Cobrado ;"  
		cMontaTxt += "Vlr Odont. Calc. ;"   
		cMontaTxt += "Vlr Odont. ReCalc. ;"
		cMontaTxt += "Vlr Odont. Total ;" 
		cMontaTxt += "Qtda ;"
		cMontaTxt += "Saldo a Pgto ;"  		  		 		  		
		
		cMontaTxt += CRLF // Salto de linha para .csv (excel)
             
		FWrite(nHandle,cMontaTxt)
   
    tmp->(dbGoTop()) 
     
          nSald_tit   := 0            
		  nVlr_Caberj := 0      
		  nVlr_Calc   := 0          
		  nVlr_ReCalc := 0
		  nsaldo_pgto := 0 
		  nVLDEVPRIMA := 0		  
          nqtda       := 0                    
   
    While !(TMP->(Eof()))                                                                                                                                                                                                   

   		  cMontaTxt := tmp->Emp + ";"  
          cMontaTxt += tmp->Plano_base + ";"     
   		  cMontaTxt += tmp->Plano +";" 
          cMontaTxt += Transform(tmp->Vlrpri     ,'@E   999.99') + ";"                      
		  cMontaTxt += Transform(tmp->Vlr_Caberj    ,'@E  999,999,999.99') + ";"
		  cMontaTxt += Transform(tmp->Vlr_Calc      ,'@E  999,999,999.99') + ";"       
		  cMontaTxt += Transform(tmp->Vlr_ReCalc    ,'@E  999,999,999.99') + ";"
		  cMontaTxt += Transform(tmp->VLR_DEV_PRIMA ,'@E  999,999,999.99') + ";"       
		  cMontaTxt += Transform(tmp->qtda          ,'@E          99,999') + ";"       
		  cMontaTxt += Transform(tmp->saldo_pgto    ,'@E  999,999,999.99') + ";"
		  
		  cMontaTxt += CRLF // Salto de linha para .csv (excel)      
		      
		  FWrite(nHandle,cMontaTxt)             

		  nVlr_Caberj += tmp->Vlr_Caberj        
		  nVlr_Calc   += tmp->Vlr_Calc  
		  nVlr_ReCalc += tmp->Vlr_ReCalc         
		  nVLDEVPRIMA += tmp->VLR_DEV_PRIMA
		  nqtda       += tmp->qtda 
		  nsaldo_pgto += tmp->saldo_pgto
          
/////// Inicioa monta vetor 		  
   		  aaDD(aDados1,{tmp->Emp        ,;  
                        tmp->Plano_base ,;     
                        tmp->Plano      ,;                                    
                        tmp->Vlrpri     ,;             
		                tmp->Vlr_Caberj ,;
		                tmp->Vlr_Calc   ,;       
		                tmp->Vlr_ReCalc ,;
		                tmp->VLR_DEV_PRIMA ,;       
		                tmp->qtda          ,;       
		                tmp->saldo_pgto    })          
///////  Fim monta vetor 
         tmp->(DbSkip())

    EndDo       

   		  cMontaTxt := ' ' + ";"  
          cMontaTxt += ' ' + ";" 
          cMontaTxt += ' ' + ";"             
          cMontaTxt += ' ' + ";"                      
		  cMontaTxt += Transform(nVlr_Caberj    ,'@E  999,999,999.99') + ";"
		  cMontaTxt += Transform(nVlr_Calc      ,'@E  999,999,999.99') + ";"       
		  cMontaTxt += Transform(nVlr_ReCalc    ,'@E  999,999,999.99') + ";"
		  cMontaTxt += Transform(nVLDEVPRIMA    ,'@E  999,999,999.99') + ";"       
		  cMontaTxt += Transform(nqtda          ,'@E          99,999') + ";"       
		  cMontaTxt += Transform(nsaldo_pgto    ,'@E  999,999,999.99') + ";"
		  
		  cMontaTxt += CRLF // Salto de linha para .csv (excel)      
		      
		  FWrite(nHandle,cMontaTxt)             


	If nHandle > 0
		
		// encerra gravaÁ„o no arquivo
		FClose(nHandle)
		cNomeArq1+= cNomeArq + CRLF
     	//	MsgAlert("Relatorio salvo em: "+cNomeArq)
		
	EndIf           
	       

// --resumo Pgto          
If 	cCompAno+cCompMes <='201607'
    
    cQuery :=       " SELECT CASE WHEN ( trim(BM1_CODEVE) = '0103' AND  BM1_YVLPRI = 7.14  ) THEN ' Pagto Integ ' "
    cQuery += CRLF +"             WHEN ( trim(BM1_CODEVE) = '0105' AND  BM1_YVLPRI = 20.12 ) THEN ' Pagto Integ ' "
    cQuery += CRLF +"             WHEN ( trim(BM1_CODEVE) = '0105' AND  BM1_YVLPRI = 7.14  ) THEN ' Pagto Parc. ' "
    cQuery += CRLF +"             WHEN ( trim(BM1_CODEVE) = '0103' AND  BM1_YVLPRI = 0.00  ) THEN ' N„o Pagto ' "
	cQuery += CRLF +"             WHEN ( trim(BM1_CODEVE) = '0105' AND  BM1_YVLPRI = 0.00  ) THEN ' N„o Pagto ' "
	cQuery += CRLF +"        ELSE 'Nao Classificado ' END statu , "
	cQuery += CRLF +"        DECODE(ba1.BA1_TIPUSU,'T', 'Titular','Dependente') T_USUA , "
	cQuery += CRLF +"        DECODE(trim(BM1_CODEVE) , '0103' , 'DENTAL - E ' , '0105' , 'DENTAL - M ' , 'Nao Classificado ') plano_vlr , "
	cQuery += CRLF +"        BM1_CODPLA||' - ' ||bm1_despla plano , "
	cQuery += CRLF +"        COUNT(BM1_VALOR) Qtda ,SUM(BM1_VALOR) Vlr_base , "
	cQuery += CRLF +"        substr(BM1_DTCPR,7,2)||'/'||substr(BM1_DTCPR,5,2)||'/'|| substr(BM1_DTCPR,1,4) DT_CALC , SUM(BM1_YVLPRI) VLR_CALC , "      
	cQuery += CRLF +"        substr(BM1_DTCPR1,7,2)||'/'||substr(BM1_DTCPR1,5,2)||'/'|| substr(BM1_DTCPR1,1,4) DT_RECALC ,SUM(BM1_YVLPR1) VLR_RECALC , "
	cQuery += CRLF +"        SUM(DECODE(trim(BM1_CODEVE) ,'0103',7.14,'0105',20.12,0.00) - ( bm1_yvlprI+bm1_yvlpr1)) saldo_pgto , bm1_yvlprI Vlrpri "

	cQuery += CRLF +"   FROM  " + RetSqlName("BM1") + " BM1 ," + RetSqlName("SE1") + " SE1 ," + RetSqlName("BA1") + " BA1 "
	cQuery += CRLF +"  WHERE BM1_FILIAL = '" + xFilial("BM1") +"' AND BM1.D_E_L_E_T_ = ' '  "   
	cQuery += CRLF +"    AND  E1_FILIAL = '" + xFilial("SE1") +"' AND SE1.D_E_L_E_T_ = ' '  "  
	cQuery += CRLF +"    AND BA1_FILIAL = '" + xFilial("BA1") +"' AND BA1.D_E_L_E_T_ = ' '  "  

	cQuery += CRLF +"    AND BM1_MES  = '"+cCompMes +"' "
	cQuery += CRLF +"    AND BM1_ANO  = '"+cCompAno+"'"  

	cQuery += CRLF +"    AND BM1_CODEMP in ( '0024' , '0025','0027','0028')        "
	cQuery += CRLF +"    AND BM1_CODTIP = '102' and BM1_CODEVE IN  ('0103','0105') "
	
	cQuery += CRLF +"    AND E1_PREFIXO =  BM1_PREFIX    " 
	cQuery += CRLF +"    AND E1_NUM     =  BM1_NUMTIT    " 
	cQuery += CRLF +"    AND E1_TIPO    =  BM1_TIPTIT 	"    
	
	cQuery += CRLF +"    AND BM1_CODINT = ba1.BA1_CODINT "
	cQuery += CRLF +"    AND BM1_CODEMP = ba1.BA1_CODEMP "
	cQuery += CRLF +"    AND BM1_MATRIC = ba1.BA1_MATRIC "
	cQuery += CRLF +"    AND BM1_TIPREG = ba1.BA1_TIPREG "
	cQuery += CRLF +"    AND BM1_DIGITO = ba1.BA1_DIGITO "
	cQuery += CRLF +"  GROUP BY  "
	cQuery += CRLF +"        CASE WHEN ( trim(BM1_CODEVE) = '0103' AND  BM1_YVLPRI = 7.14  ) THEN ' Pagto Integ ' "
	cQuery += CRLF +"             WHEN ( trim(BM1_CODEVE) = '0105' AND  BM1_YVLPRI = 20.12 ) THEN ' Pagto Integ ' "
	cQuery += CRLF +"             WHEN ( trim(BM1_CODEVE) = '0105' AND  BM1_YVLPRI = 7.14  ) THEN ' Pagto Parc. ' "
	cQuery += CRLF +"             WHEN ( trim(BM1_CODEVE) = '0103' AND  BM1_YVLPRI = 0.00  ) THEN ' N„o Pagto ' "
	cQuery += CRLF +"             WHEN ( trim(BM1_CODEVE) = '0105' AND  BM1_YVLPRI = 0.00  ) THEN ' N„o Pagto ' "
	cQuery += CRLF +"             ELSE 'Nao Classificado ' END , " 
	cQuery += CRLF +"        DECODE(ba1.BA1_TIPUSU,'T', 'Titular','Dependente') ,BM1_CODPLA||' - ' ||bm1_despla ,  "
	cQuery += CRLF +"        DECODE(trim(BM1_CODEVE) , '0103' , 'DENTAL - E ' , '0105' , 'DENTAL - M ' , 'Nao Classificado ') , "
	cQuery += CRLF +"        substr(BM1_DTCPR,7,2)||'/'||substr(BM1_DTCPR,5,2)||'/' ||substr(BM1_DTCPR,1,4) ,  "
	cQuery += CRLF +"        substr(BM1_DTCPR1,7,2)||'/'||substr(BM1_DTCPR1,5,2)||'/'|| substr(BM1_DTCPR1,1,4) , bm1_yvlprI  "
	cQuery += CRLF +"        ORDER BY 1,3,2 "

Else 

    cQuery :=       " SELECT CASE WHEN ( BM1_YVLPRI =  ( VALOR_PARTE_DENTAL * 0.75 ) ) THEN ' Pagto Integ ' "
	cQuery += CRLF +"             WHEN ( BM1_YVLPRI <> ( VALOR_PARTE_DENTAL * 0.75 ) AND BM1_YVLPRI <> 0.00  ) THEN ' Pagto Parc. ' " 
	cQuery += CRLF +"             WHEN ( BM1_YVLPRI = 0.00  ) THEN ' N„o Pagto ' "
	cQuery += CRLF +"        ELSE 'Nao Classificado ' END statu ,  "
	cQuery += CRLF +"        DECODE(ba1.BA1_TIPUSU,'T', 'Titular','Dependente') T_USUA , "

    cQuery += CRLF +"        DECODE(TRIM(BM1_CODPLA ) ,'0112' , ('STANDARD - E' )      ,'0114' , ('STANDARD RIO - E' ) "
	cQuery += CRLF +"                                 ,'0117' , ('ESSENCIAL RIO - E' ) ,'0121' , ('MAIS RIO - E' ) "
	cQuery += CRLF +"                                 ,'0126' , ('MULTI RIO - E' )      ,'0128' , ('TOTAL RIO - E' ) "           
	cQuery += CRLF +"                                 ,'0113' , ('STANDARD - M' )      ,'0115' , ('STANDARD RIO - M' ) "                                    
	cQuery += CRLF +"                                 ,'0119' , ('ESSENCIAL RIO - M' )  ,'0123' , ('MAIS RIO - M' ) "
	cQuery += CRLF +"                                 ,'0127' , ('MULTI RIO - M' )      ,'0129' , ('TOTAL RIO - M' ) "    
    cQuery += CRLF +"                                 , 'Nao Classificado ' ) plano_vlr , "	                                

	cQuery += CRLF +"        BM1_CODPLA||' - ' ||bm1_despla plano , "
	
	cQuery += CRLF +"        COUNT(BM1_VALOR) Qtda ,SUM(BM1_VALOR) Vlr_base , "
	cQuery += CRLF +"        substr(BM1_DTCPR,7,2)||'/'||substr(BM1_DTCPR,5,2)||'/'|| substr(BM1_DTCPR,1,4) DT_CALC , SUM(BM1_YVLPRI) VLR_CALC , "
	cQuery += CRLF +"        substr(BM1_DTCPR1,7,2)||'/'||substr(BM1_DTCPR1,5,2)||'/'|| substr(BM1_DTCPR1,1,4) DT_RECALC ,SUM(BM1_YVLPR1) VLR_RECALC , "
	cQuery += CRLF +"        SUM( ( VALOR_PARTE_DENTAL * 0.75 ) - ( BM1_YVLPRI+BM1_YVLPR1)) SALDO_PGTO , " 
	cQuery += CRLF +"        VALOR_PARTE_DENTAL Vlrpri "

    cQuery += CRLF +"  FROM  " + RetSqlName("BM1") + " BM1 ," + RetSqlName("SE1") + " SE1 ," + RetSqlName("BA1") + " BA1 ,  SIGA.VALOR_PARTE_ODONTO_PREFEITURA "
	cQuery += CRLF +" WHERE BM1_FILIAL = '" + xFilial("BM1") +"' AND BM1.D_E_L_E_T_ = ' '  "   
	cQuery += CRLF +"   AND  E1_FILIAL = '" + xFilial("SE1") +"' AND SE1.D_E_L_E_T_ = ' '  "  
	cQuery += CRLF +"   AND BA1_FILIAL = '" + xFilial("BA1") +"' AND BA1.D_E_L_E_T_ = ' '  "  

	cQuery += CRLF +"   AND BM1_MES    = '"+cCompMes+"' "
	cQuery += CRLF +"   AND BM1_ANO    = '"+cCompAno+"' "  

	cQuery += CRLF +"   AND BM1_CODEMP in ( '0024' , '0025','0027','0028') "       
	cQuery += CRLF +"   AND BM1_CODTIP = '101' "

	cQuery += CRLF +"   AND E1_PREFIXO =  BM1_PREFIX "   
	cQuery += CRLF +"   AND E1_NUM     =  BM1_NUMTIT "   
	cQuery += CRLF +"   AND E1_TIPO    =  BM1_TIPTIT "	

	cQuery += CRLF +"   AND BM1_CODINT = ba1.BA1_CODINT "
	cQuery += CRLF +"   AND BM1_CODEMP = ba1.BA1_CODEMP "
	cQuery += CRLF +"   AND BM1_MATRIC = ba1.BA1_MATRIC "
	cQuery += CRLF +"   AND BM1_TIPREG = ba1.BA1_TIPREG "
	cQuery += CRLF +"   AND BM1_DIGITO = ba1.BA1_DIGITO "
   
	cQuery += CRLF +"   AND BM1_CODPLA = COD_PLANO "

	cQuery += CRLF +" GROUP BY CASE WHEN ( BM1_YVLPRI =  ( VALOR_PARTE_DENTAL * 0.75 ) ) THEN ' Pagto Integ ' "
	cQuery += CRLF +"               WHEN ( BM1_YVLPRI <> ( VALOR_PARTE_DENTAL * 0.75 ) AND BM1_YVLPRI <> 0.00  ) THEN ' Pagto Parc. ' " 
	cQuery += CRLF +"               WHEN ( BM1_YVLPRI = 0.00  ) THEN ' N„o Pagto ' "
	cQuery += CRLF +"          ELSE 'Nao Classificado ' END ,  "
	cQuery += CRLF +"       DECODE(ba1.BA1_TIPUSU,'T', 'Titular','Dependente') , "   
	cQuery += CRLF +"       DECODE(TRIM(BM1_CODPLA )  ,'0112' , ('STANDARD - E' )      ,'0114' , ('STANDARD RIO - E' ) "
	cQuery += CRLF +"                                 ,'0117' , ('ESSENCIAL RIO - E' ) ,'0121' , ('MAIS RIO - E' ) "
	cQuery += CRLF +"                                 ,'0126' , ('MULTI RIO - E' )      ,'0128' , ('TOTAL RIO - E' ) "           
	cQuery += CRLF +"                                 ,'0113' , ('STANDARD - M' )      ,'0115' , ('STANDARD RIO - M' ) "                                    
	cQuery += CRLF +"                                 ,'0119' , ('ESSENCIAL RIO - M' )  ,'0123' , ('MAIS RIO - M' ) "
	cQuery += CRLF +"                                 ,'0127' , ('MULTI RIO - M' )      ,'0129' , ('TOTAL RIO - M' ) "    
    cQuery += CRLF +"                                 , 'Nao Classificado ' ) , "
	cQuery += CRLF +"       BM1_CODPLA||' - ' ||bm1_despla , " 
	cQuery += CRLF +"       substr(BM1_DTCPR,7,2)||'/'||substr(BM1_DTCPR,5,2)||'/' ||substr(BM1_DTCPR,1,4) ,    "
	cQuery += CRLF +"       substr(BM1_DTCPR1,7,2)||'/'||substr(BM1_DTCPR1,5,2)||'/'|| substr(BM1_DTCPR1,1,4) , "
	cQuery += CRLF +"       VALOR_PARTE_DENTAL  "
	cQuery += CRLF +"       ORDER BY 1,3,2 "

EndIf
 

If Select(("TMP")) <> 0 
          ("TMP")->(DbCloseArea()) 
Endif
    
TCQuery cQuery Alias "TMP" New 
                                                                                           
dbSelectArea("TMP")
              
// resumo pgto      
   If TMP1->QTDREPROC > 0
      cNomDadCab:=  '2 - Reprocessamento - Resumo Pgto CABERJ '
   Else 
      cNomDadCab:=  '2 - Processamento - Resumo Pgto CABERJ '
   EndIf 
         
   cComp     :=  cCompMes+'/'+cCompAno
   cNomPla   := cNomDadCab                 
 
     	cNomeArq := "C:\TEMP\"+cCompAno+cCompMes+" - "+cNomDadCab+"_"+SubStr(DtoS(date()),7,2)+"_"+SubStr(DtoS(date()),5,2)+"_"+SubStr(DtoS(date()),1,4)+"_"+STRTRAN(TIME(),":","_")+".csv"

		nHandle := FCREATE(cNomeArq)
        cMontaTxt := cNomDadCab
        cMontaTxt += CRLF
        FWrite(nHandle,cMontaTxt)       		 
        cMontaTxt := 'Competencia : ' + cComp
        cMontaTxt += CRLF
        FWrite(nHandle,cMontaTxt)		 
        cMontaTxt := 'Planilha : '+cNomPla  
        cMontaTxt += CRLF
        FWrite(nHandle,cMontaTxt)	     
        
        cMontaTxt := "Status ;"
		cMontaTxt += "Tp Usuario   ;"   
		cMontaTxt += "Plano Base ;"   
		cMontaTxt += "Plano ;"  		
		cMontaTxt += "Qtda ;"   
		cMontaTxt += "Vlr Primavida ;"
		cMontaTxt += "Vlr Cobrado ;"
		cMontaTxt += "Dt. Calc  ;" 
		cMontaTxt += "Vlr Odont. Calc. ;"
		cMontaTxt += "Dt. ReCalc ;" 
		cMontaTxt += "Vlr Odont. ReCalc. ;"		
		cMontaTxt += "Saldo a Pgto ;"  		  		 		  		
		
		cMontaTxt += CRLF // Salto de linha para .csv (excel)
             
		FWrite(nHandle,cMontaTxt)

          nSald_tit   := 0            
		  nVlr_Caberj := 0      
		  nVlr_Calc   := 0          
		  nVlr_ReCalc := 0
		  nsaldo_pgto := 0 
		  nVLDEVPRIMA := 0		  
          nqtda       := 0                    

   
    tmp->(dbGoTop())                    
   
    While !(TMP->(Eof()))                                                                                                                                                                                                   

   		  cMontaTxt := tmp->statu     + ";"  
          cMontaTxt += tmp->T_USUA    + ";"   
          cMontaTxt += tmp->plano_vlr + ";"        
          cMontaTxt += tmp->plano     + ";"          
          cMontaTxt += Transform(tmp->qtda       ,'@E  999,999') + ";"           
          cMontaTxt += Transform(tmp->Vlrpri     ,'@E   999.99') + ";"             
		  cMontaTxt += Transform(tmp->Vlr_base   ,'@E  999,999,999.99') + ";" 
		  cMontaTxt += tmp->DT_CALC   + ";"
		  cMontaTxt += Transform(tmp->Vlr_Calc   ,'@E  999,999,999.99') + ";"    
		  cMontaTxt += tmp->DT_RECALC + ";"
		  cMontaTxt += Transform(tmp->Vlr_ReCalc ,'@E  999,999,999.99') + ";" 
		  cMontaTxt += Transform(tmp->SALDO_PGTO ,'@E  999,999,999.99') + ";"
		  
		  cMontaTxt += CRLF // Salto de linha para .csv (excel)      
		      
		  FWrite(nHandle,cMontaTxt)     

		  nqtda       += tmp->qtda 	  		  
  		  nVlr_Caberj += tmp->Vlr_base        
		  nVlr_Calc   += tmp->Vlr_Calc  
		  nVlr_ReCalc += tmp->Vlr_ReCalc         
		  nsaldo_pgto += tmp->saldo_pgto
		  
/////// Inicioa monta vetor 		                                          
      aaDD(aDados2,{tmp->statu     ,;  
          tmp->T_USUA    ,;   
          tmp->plano_vlr ,;        
          tmp->plano     ,;          
          tmp->qtda      ,;                              
          tmp->Vlrpri    ,;             
		  tmp->Vlr_base  ,; 
		  tmp->DT_CALC   ,;
		  tmp->Vlr_Calc  ,;    
		  tmp->SALDO_PGTO })

///////  Fim monta vetor 		  

         tmp->(DbSkip())

    EndDo       
                    
	      cMontaTxt := ' '  + ";"  
          cMontaTxt += ' '  + ";"   
          cMontaTxt += ' '  + ";"        
          cMontaTxt += ' '  + ";"                 
          cMontaTxt += Transform(nqtda        ,        '@E ,99,999') + ";"           
          cMontaTxt += ' '  + ";"                 
		  cMontaTxt += Transform(nVlr_Caberj  ,'@E  999,999,999.99') + ";" 
		  cMontaTxt += ' '  + ";"
		  cMontaTxt += Transform(nVlr_Calc   ,'@E  999,999,999.99') + ";"    
		  cMontaTxt += ' '  + ";"
		  cMontaTxt += Transform(nVlr_ReCalc ,'@E  999,999,999.99') + ";" 
		  cMontaTxt += Transform(nSALDO_PGTO ,'@E  999,999,999.99') + ";"
		  
		  cMontaTxt += CRLF // Salto de linha para .csv (excel)      
		      
		  FWrite(nHandle,cMontaTxt)    

	If nHandle > 0
		
		// encerra gravaÁ„o no arquivo
		FClose(nHandle)
		cNomeArq1+= cNomeArq + CRLF
     	//	MsgAlert("Relatorio salvo em: "+cNomeArq)
		
	EndIf           
	                      
// -- base     
If 	cCompAno+cCompMes <='201607'
    
    cQuery := " select bm1_codint || BM1_CODEMP ||bm1_matric || bm1_tipreg || bm1_digito ||' - '|| bm1_nomusr usuario , "
	cQuery += CRLF +"  nvl(e1_saldo,0) Sald_tit , "
	cQuery += CRLF +"  E1_PREFIXO || E1_NUM || E1_TIPO  TITULO , "
	cQuery += CRLF +"  SUBSTR(E1_BAIXA,7,2)||'/'||SUBSTR(E1_BAIXA,5,2)||'/'||SUBSTR(E1_BAIXA,1,4) BAIXA , "
	cQuery += CRLF +"  decode(ba1.BA1_TIPUSU,'T', 'Titular','Dependente') Tit_Dep , "



	cQuery += CRLF +"  DECODE(trim(BM1_CODEVE) , '0103' , 'DENTAL - E ' , '0105' , 'DENTAL - M ' , 'Nao Classificado ') Plano_base , " 
	cQuery += CRLF +"  BM1_CODPLA||' - ' ||bm1_despla plano , "
	cQuery += CRLF +"  BM1_VALOR  Vlr_Caberj , "
	cQuery += CRLF +"  substr(BM1_DTCPR,7,2)||'/'||substr(BM1_DTCPR,5,2)||'/'|| substr(BM1_DTCPR,1,4) DT_CALC , "
	cQuery += CRLF +"  BM1_YVLPRI Vlr_Calc, " 
	cQuery += CRLF +"  substr(BM1_DTCPR1,7,2)||'/'||substr(BM1_DTCPR1,5,2)||'/'|| substr(BM1_DTCPR1,1,4) DT_RECALC ,"
	cQuery += CRLF +"  BM1_YVLPR1 Vlr_ReCalc , "

	cQuery += CRLF +"  SUM(DECODE(trim(BM1_CODEVE) ,'0103',7.14,'0105',20.12,0.00) - ( bm1_yvlprI+bm1_yvlpr1)) saldo_pgto "
   
	cQuery += CRLF +"  FROM  " + RetSqlName("BM1") + " BM1 ," + RetSqlName("SE1") + " SE1 ," + RetSqlName("BA1") + " BA1 "
	cQuery += CRLF +" WHERE BM1_FILIAL = '" + xFilial("BM1") +"' AND BM1.D_E_L_E_T_ = ' '  "   
	cQuery += CRLF +"   AND  E1_FILIAL = '" + xFilial("SE1") +"' AND SE1.D_E_L_E_T_ = ' '  "  
	cQuery += CRLF +"   AND BA1_FILIAL = '" + xFilial("BA1") +"' AND BA1.D_E_L_E_T_ = ' '  "  

	cQuery += CRLF +"   AND BM1_MES    = '"+cCompMes +"' "
	cQuery += CRLF +"   AND BM1_ANO    = '"+cCompAno+"'"  
   		
	cQuery += CRLF +"  AND BM1_CODEMP in ( '0024' , '0025','0027','0028') "
	cQuery += CRLF +"  AND BM1_CODTIP = '102' and BM1_CODEVE IN  ('0103','0105') "
	cQuery += CRLF +"  AND BM1_CODINT = ba1.BA1_CODINT "
	cQuery += CRLF +"  AND BM1_CODEMP = ba1.BA1_CODEMP " 
	cQuery += CRLF +"  AND BM1_MATRIC = ba1.BA1_MATRIC "
	cQuery += CRLF +"  AND BM1_TIPREG = ba1.BA1_TIPREG "
	cQuery += CRLF +"  AND BM1_DIGITO = ba1.BA1_DIGITO "
	cQuery += CRLF +"  AND E1_PREFIXO =  BM1_PREFIX "    
	cQuery += CRLF +"  AND E1_NUM     =  BM1_NUMTIT "    
	cQuery += CRLF +"  AND E1_TIPO    =  BM1_TIPTIT "

	cQuery += CRLF +"group by bm1_codint || BM1_CODEMP ||bm1_matric || bm1_tipreg || bm1_digito ||' - '|| bm1_nomusr  , "
	cQuery += CRLF +"         nvl(e1_saldo,0) , "
	cQuery += CRLF +"         E1_PREFIXO || E1_NUM || E1_TIPO , " 
	cQuery += CRLF +"         SUBSTR(E1_BAIXA,7,2)||'/'||SUBSTR(E1_BAIXA,5,2)||'/'||SUBSTR(E1_BAIXA,1,4) , "
	cQuery += CRLF +"         decode(ba1.BA1_TIPUSU,'T', 'Titular','Dependente') , "
	cQuery += CRLF +"         DECODE(trim(BM1_CODEVE) , '0103' , 'DENTAL - E ' , '0105' , 'DENTAL - M ' , 'Nao Classificado ') , " 
	cQuery += CRLF +"         BM1_VALOR , BM1_CODPLA||' - ' ||bm1_despla , "
	cQuery += CRLF +"         substr(BM1_DTCPR,7,2)||'/'||substr(BM1_DTCPR,5,2)||'/'|| substr(BM1_DTCPR,1,4) , " 
	cQuery += CRLF +"         BM1_YVLPRI , " 
	cQuery += CRLF +"         substr(BM1_DTCPR1,7,2)||'/'||substr(BM1_DTCPR1,5,2)||'/'|| substr(BM1_DTCPR1,1,4) , "
	cQuery += CRLF +"         BM1_YVLPR1 " 
	cQuery += CRLF +"order by bm1_codint || BM1_CODEMP ||bm1_matric || bm1_tipreg || bm1_digito ||' - '|| bm1_nomusr  "
 
Else 
 
    cQuery :=" SELECT TRIM(BM1_CODINT || BM1_CODEMP ||BM1_MATRIC || BM1_TIPREG || BM1_DIGITO ||' - '|| BM1_NOMUSR) USUARIO , "
	cQuery += CRLF +" NVL(E1_SALDO,0) SALD_TIT , "
	cQuery += CRLF +" E1_PREFIXO || E1_NUM || E1_TIPO  TITULO , "
	cQuery += CRLF +" SUBSTR(E1_BAIXA,7,2)||'/'||SUBSTR(E1_BAIXA,5,2)||'/'||SUBSTR(E1_BAIXA,1,4) BAIXA , "
	cQuery += CRLF +" DECODE(BA1.BA1_TIPUSU,'T', 'Titular','Dependente') TIT_DEP , "                
	
    cQuery += CRLF +"       DECODE(TRIM(BM1_CODPLA )  ,'0112' , ('STANDARD - E' )      ,'0114' , ('STANDARD RIO - E' ) "
	cQuery += CRLF +"                                 ,'0117' , ('ESSENCIAL RIO - E' ) ,'0121' , ('MAIS RIO - E' ) "
	cQuery += CRLF +"                                 ,'0126' , ('MULTI RIO - E' )      ,'0128' , ('TOTAL RIO - E' ) "           
	cQuery += CRLF +"                                 ,'0113' , ('STANDARD - M' )      ,'0115' , ('STANDARD RIO - M' ) "                                    
	cQuery += CRLF +"                                 ,'0119' , ('ESSENCIAL RIO - M' )  ,'0123' , ('MAIS RIO - M' ) "
	cQuery += CRLF +"                                 ,'0127' , ('MULTI RIO - M' )      ,'0129' , ('TOTAL RIO - M' ) "    
    cQuery += CRLF +"                                 , 'Nao Classificado ' ) PLANO_BASE , "
	
	
	cQuery += CRLF +" TRIM(BM1_CODPLA||' - ' ||BM1_DESPLA) PLANO , "
	cQuery += CRLF +" VALOR_PARTE_DENTAL VLR_CABERJ , "
	cQuery += CRLF +" SUBSTR(BM1_DTCPR,7,2)||'/'||SUBSTR(BM1_DTCPR,5,2)||'/'|| SUBSTR(BM1_DTCPR,1,4) DT_CALC , "
	cQuery += CRLF +" BM1_YVLPRI VLR_CALC , "
	cQuery += CRLF +" SUBSTR(BM1_DTCPR1,7,2)||'/'||SUBSTR(BM1_DTCPR1,5,2)||'/'|| SUBSTR(BM1_DTCPR1,1,4) DT_RECALC , "
	cQuery += CRLF +" BM1_YVLPR1 VLR_RECALC , "    
	
	cQuery += CRLF +" SUM(( VALOR_PARTE_DENTAL * 0.75 ) - ( BM1_YVLPRI+BM1_YVLPR1)) SALDO_PGTO "
   
	cQuery += CRLF +"  FROM  " + RetSqlName("BM1") + " BM1 ," + RetSqlName("SE1") + " SE1 ," + RetSqlName("BA1") + " BA1 , SIGA.VALOR_PARTE_ODONTO_PREFEITURA"
	cQuery += CRLF +" WHERE BM1_FILIAL = '" + xFilial("BM1") +"' AND BM1.D_E_L_E_T_ = ' '  "   
	cQuery += CRLF +"   AND  E1_FILIAL = '" + xFilial("SE1") +"' AND SE1.D_E_L_E_T_ = ' '  "  
	cQuery += CRLF +"   AND BA1_FILIAL = '" + xFilial("BA1") +"' AND BA1.D_E_L_E_T_ = ' '  "  

	cQuery += CRLF +"   AND BM1_MES    = '"+cCompMes+"'"
	cQuery += CRLF +"   AND BM1_ANO    = '"+cCompAno+"'"  

	cQuery += CRLF +"   AND BM1_CODEMP IN ( '0024' , '0025','0027','0028') " 
	cQuery += CRLF +"   AND BM1_CODTIP = '101' " 
	
	cQuery += CRLF +"   AND BM1_CODINT = BA1.BA1_CODINT "
	cQuery += CRLF +"   AND BM1_CODEMP = BA1.BA1_CODEMP " 
	cQuery += CRLF +"   AND BM1_MATRIC = BA1.BA1_MATRIC "
	cQuery += CRLF +"   AND BM1_TIPREG = BA1.BA1_TIPREG "
	cQuery += CRLF +"   AND BM1_DIGITO = BA1.BA1_DIGITO " 

	cQuery += CRLF +"   AND E1_PREFIXO =  BM1_PREFIX "
	cQuery += CRLF +"   AND E1_NUM     =  BM1_NUMTIT "
	cQuery += CRLF +"   AND E1_TIPO    =  BM1_TIPTIT "
  
	cQuery += CRLF +"   AND BM1_CODPLA = COD_PLANO "
  
	cQuery += CRLF +" GROUP BY BM1_CODINT || BM1_CODEMP ||BM1_MATRIC || BM1_TIPREG || BM1_DIGITO ||' - '|| BM1_NOMUSR , "
	cQuery += CRLF +"          NVL(E1_SALDO,0) , "
	cQuery += CRLF +"          E1_PREFIXO || E1_NUM || E1_TIPO , "
	cQuery += CRLF +"          SUBSTR(E1_BAIXA,7,2)||'/'||SUBSTR(E1_BAIXA,5,2)||'/'||SUBSTR(E1_BAIXA,1,4) , "
	cQuery += CRLF +"          DECODE(BA1.BA1_TIPUSU,'T', 'Titular','Dependente') , "   
	
    cQuery += CRLF +"       DECODE(TRIM(BM1_CODPLA )  ,'0112' , ('STANDARD - E' )      ,'0114' , ('STANDARD RIO - E' ) "
	cQuery += CRLF +"                                 ,'0117' , ('ESSENCIAL RIO - E' ) ,'0121' , ('MAIS RIO - E' ) "
	cQuery += CRLF +"                                 ,'0126' , ('MULTI RIO - E' )      ,'0128' , ('TOTAL RIO - E' ) "           
	cQuery += CRLF +"                                 ,'0113' , ('STANDARD - M' )      ,'0115' , ('STANDARD RIO - M' ) "                                    
	cQuery += CRLF +"                                 ,'0119' , ('ESSENCIAL RIO - M' )  ,'0123' , ('MAIS RIO - M' ) "
	cQuery += CRLF +"                                 ,'0127' , ('MULTI RIO - M' )      ,'0129' , ('TOTAL RIO - M' ) "    
    cQuery += CRLF +"                                 , 'Nao Classificado ' )	,
    
	cQuery += CRLF +"          TRIM(BM1_CODPLA||' - ' ||BM1_DESPLA)  , "    
	
	cQuery += CRLF +"          VALOR_PARTE_DENTAL  , "
	cQuery += CRLF +"          BM1_CODPLA||' - ' ||BM1_DESPLA , "
	cQuery += CRLF +"          SUBSTR(BM1_DTCPR,7,2)||'/'||SUBSTR(BM1_DTCPR,5,2)||'/'|| SUBSTR(BM1_DTCPR,1,4) , " 
	cQuery += CRLF +"          BM1_YVLPRI , "
	cQuery += CRLF +"          SUBSTR(BM1_DTCPR1,7,2)||'/'||SUBSTR(BM1_DTCPR1,5,2)||'/'|| SUBSTR(BM1_DTCPR1,1,4) , "
	cQuery += CRLF +"          BM1_YVLPR1 "
  	cQuery += CRLF +" ORDER BY BM1_CODINT || BM1_CODEMP ||BM1_MATRIC || BM1_TIPREG || BM1_DIGITO ||' - '|| BM1_NOMUSR " 
  
EndIf  

If Select(("TMP")) <> 0 
       ("TMP")->(DbCloseArea()) 
Endif
    
TCQuery cQuery Alias "TMP" New 
                                                                                           
dbSelectArea("TMP")
              
//  base     
   If TMP1->QTDREPROC > 0
      cNomDadCab:=  '3 - Reprocessamento -  Base CABERJ '
   Else 
      cNomDadCab:=  '3 - Processamento -  Base CABERJ '
   EndIf 
         
   cComp     := cCompMes+'/'+cCompAno
   cNomPla   := cNomDadCab                 
 
   cNomeArq := "C:\TEMP\"+cCompAno+cCompMes+" - "+cNomDadCab+"_"+SubStr(DtoS(date()),7,2)+"_"+SubStr(DtoS(date()),5,2)+"_"+SubStr(DtoS(date()),1,4)+"_"+STRTRAN(TIME(),":","_")+".csv"

		nHandle := FCREATE(cNomeArq)
        cMontaTxt := cNomDadCab
        cMontaTxt += CRLF
        FWrite(nHandle,cMontaTxt)       		 
        cMontaTxt := 'Competencia : ' + cComp
        cMontaTxt += CRLF
        FWrite(nHandle,cMontaTxt)		 
        cMontaTxt := 'Planilha : '+cNomPla  
        cMontaTxt += CRLF
        FWrite(nHandle,cMontaTxt)	      
        
        cMontaTxt := "Usuario ;"
		cMontaTxt += "Saldo Tit  ;"   
		cMontaTxt += "Num Titulo a Receber ;"  
		cMontaTxt += "Dt Baixa ;"   
		cMontaTxt += "Tp usuario ;"
		cMontaTxt += "Plano base ;"  
		cMontaTxt += "Plano ;" 		
		cMontaTxt += "Vlr Cobrado  ;"
		cMontaTxt += "Data do Calc ;"
		cMontaTxt += "Vlr Odont. Calc. ;" 
		cMontaTxt += "Data do ReCalc ;"		
		cMontaTxt += "Vlr Odont. ReCalc. ;"  		  		 		  		
		cMontaTxt += "Saldo a Pgto  ;"
				
		cMontaTxt += CRLF // Salto de linha para .csv (excel)
             
		FWrite(nHandle,cMontaTxt)
   
    tmp->(dbGoTop())      
                  
          nSald_tit   := 0            
		  nVlr_Caberj := 0      
		  nVlr_Calc   := 0          
		  nVlr_ReCalc := 0
		  nsaldo_pgto := 0 
		  nVLDEVPRIMA := 0		  
          nqtda       := 0 
   
    While !(TMP->(Eof()))       


   		  cMontaTxt := tmp->usuario + ";"  
   		  cMontaTxt += Transform(tmp->Sald_tit    ,'@E  999,999,999.99') + ";"
          cMontaTxt += tmp->TITULO + ";"  
          cMontaTxt += tmp->BAIXA + ";" 
          cMontaTxt += tmp->Tit_Dep + ";"  
          cMontaTxt += tmp->Plano_base + ";"                                        
          cMontaTxt += tmp->Plano + ";"                                                 
          cMontaTxt += Transform(tmp->Vlr_Caberj  ,'@E  999,999,999.99') + ";"       
          cMontaTxt += tmp->DT_CALC + ";"          
		  cMontaTxt += Transform(tmp->Vlr_Calc    ,'@E  999,999,999.99') + ";"       
          cMontaTxt += tmp->DT_RECALC + ";"          
		  cMontaTxt += Transform(tmp->Vlr_ReCalc  ,'@E  999,999,999.99') + ";"
		  cMontaTxt += Transform(tmp->saldo_pgto  ,'@E  999,999,999.99') + ";"
		  
		  cMontaTxt += CRLF // Salto de linha para .csv (excel)      
		      
		  FWrite(nHandle,cMontaTxt)         
		  
		  nSald_tit   += tmp->Sald_tit            
		  nVlr_Caberj += tmp->Vlr_Caberj      
		  nVlr_Calc   += tmp->Vlr_Calc          
		  nVlr_ReCalc += tmp->Vlr_ReCalc
		  nsaldo_pgto += tmp->saldo_pgto

         tmp->(DbSkip())

    EndDo                                   
   
          cMontaTxt := ' '  + ";"  
   		  cMontaTxt += Transform(nSald_tit    ,'@E  999,999,999.99') + ";"
          cMontaTxt += ' ' + ";"  
          cMontaTxt += ' ' + ";" 
          cMontaTxt += ' ' + ";"   
          cMontaTxt += ' ' + ";"            
          cMontaTxt += ' ' + ";"                                       
          cMontaTxt += Transform(nVlr_Caberj  ,'@E  999,999,999.99') + ";"       
          cMontaTxt += ' ' + ";"          
		  cMontaTxt += Transform(nVlr_Calc    ,'@E  999,999,999.99') + ";"       
          cMontaTxt += ' ' + ";"          
		  cMontaTxt += Transform(nVlr_ReCalc  ,'@E  999,999,999.99') + ";"
		  cMontaTxt += Transform(nsaldo_pgto  ,'@E  999,999,999.99') + ";"
		  
		  cMontaTxt += CRLF // Salto de linha para .csv (excel)      
		      
		  FWrite(nHandle,cMontaTxt)         

	If nHandle > 0
		
		// encerra gravaÁ„o no arquivo
		FClose(nHandle)
		cNomeArq1+= cNomeArq + CRLF
     	//	MsgAlert("Relatorio salvo em: "+cNomeArq)
		
	EndIf     
	
// -- TIT COM SALDO   
If 	cCompAno+cCompMes <='201607'

	cQuery := " select bm1_codint || BM1_CODEMP ||bm1_matric || bm1_tipreg || bm1_digito ||' - '|| bm1_nomusr  usuario , "
	cQuery += CRLF +"  decode(ba1.BA1_TIPUSU,'T', 'Titular','Dependente') Tit_Dep , "                                      
	cQuery += CRLF +"  E1_PREFIXO || E1_NUM || E1_TIPO  TITULO , "
	cQuery += CRLF +"  nvl(e1_saldo,0) Sald_tit , "
	cQuery += CRLF +"  SUBSTR(E1_BAIXA,7,2)||'/'||SUBSTR(E1_BAIXA,5,2)||'/'||SUBSTR(E1_BAIXA,1,4) BAIXA ,"

	cQuery += CRLF +"        DECODE(trim(BM1_CODEVE) , '0103' , 'DENTAL - E ' "
	cQuery += CRLF +"                                , '0105' , 'DENTAL - M ' "
	cQuery += CRLF +"                                , 'Nao Classificado ') Plano_base , " 
	cQuery += CRLF +"       BM1_CODPLA||' - ' ||bm1_despla plano , "
	cQuery += CRLF +"       CASE    WHEN (   trim(BM1_CODEVE)  = '0103' AND  BM1_YVLPRI = 7.14  ) THEN ' Pagto Integ ' "
	cQuery += CRLF +"               WHEN (   trim(BM1_CODEVE)  = '0105' AND  BM1_YVLPRI = 20.12 ) THEN ' Pagto Integ ' "
	cQuery += CRLF +"               WHEN (   trim(BM1_CODEVE)  = '0105' AND  BM1_YVLPRI = 7.14  ) THEN ' Pagto Parc. ' "
	cQuery += CRLF +"               WHEN (   trim(BM1_CODEVE)  = '0103' AND  BM1_YVLPRI = 0.00  ) THEN ' N„o Pagto ' "
	cQuery += CRLF +"               WHEN (   trim(BM1_CODEVE)  = '0105' AND  BM1_YVLPRI = 0.00  ) THEN ' N„o Pagto ' "
	cQuery += CRLF +"               ELSE 'Nao Classificado ' END  statu ," 
     
	cQuery += CRLF +"       BM1_VALOR  Vlr_Caberj ," 
	cQuery += CRLF +"       substr(BM1_DTCPR,7,2)||'/'||substr(BM1_DTCPR,5,2)||'/' ||substr(BM1_DTCPR,1,4) Dat_calc ,"
	cQuery += CRLF +"       BM1_YVLPRI Vlr_Calc ,"      
	cQuery += CRLF +"       substr(BM1_DTCPR1,7,2)||'/'||substr(BM1_DTCPR1,5,2)||'/'|| substr(BM1_DTCPR1,1,4) Dat_recalc ," 
	cQuery += CRLF +"       BM1_YVLPR1 Vlr_ReCalc , "  
	
	cQuery += CRLF +"  SUM(DECODE(trim(BM1_CODEVE) ,'0103',7.14,'0105',20.12,0.00) - ( bm1_yvlprI+bm1_yvlpr1)) saldo_pgto " 

	cQuery += CRLF +"  FROM  " + RetSqlName("BM1") + " BM1 ," + RetSqlName("SE1") + " SE1 ," + RetSqlName("BA1") + " BA1 "
	cQuery += CRLF +" WHERE BM1_FILIAL = '" + xFilial("BM1") +"' AND BM1.D_E_L_E_T_ = ' '  "   
	cQuery += CRLF +"   AND  E1_FILIAL = '" + xFilial("SE1") +"' AND SE1.D_E_L_E_T_ = ' '  "  
	cQuery += CRLF +"   AND BA1_FILIAL = '" + xFilial("BA1") +"' AND BA1.D_E_L_E_T_ = ' '  "  

	cQuery += CRLF +"   AND BM1_MES    = '"+cCompMes +"' "
	cQuery += CRLF +"   AND BM1_ANO    = '"+cCompAno +"'"  

	cQuery += CRLF +"   AND BM1_CODEMP in ( '0024' , '0025' , '0027' , '0028') "
	cQuery += CRLF +"   AND BM1_CODTIP   = '102' and BM1_CODEVE IN  ('0103','0105') "
	cQuery += CRLF +"   AND E1_FILIAL(+) = '01' AND SE1.D_E_L_E_T_(+) = ' ' "     

	cQuery += CRLF +"   AND ((E1_SALDO  <> 0 ) "  
	cQuery += CRLF +"    OR  (trim(BM1_CODEVE) = '0103' AND BM1_YVLPRI <> 7.14 ) "
	cQuery += CRLF +"    OR  (trim(BM1_CODEVE) = '0105' AND BM1_YVLPRI <> 20.12 )) "

	cQuery += CRLF +"   AND E1_PREFIXO =  BM1_PREFIX     "
	cQuery += CRLF +"   AND E1_NUM     =  BM1_NUMTIT     "
	cQuery += CRLF +"   AND E1_TIPO    =  BM1_TIPTIT     "

	cQuery += CRLF +"   AND BM1_CODINT = ba1.BA1_CODINT  "
	cQuery += CRLF +"   AND BM1_CODEMP = ba1.BA1_CODEMP  "
	cQuery += CRLF +"   AND BM1_MATRIC = ba1.BA1_MATRIC  "
	cQuery += CRLF +"   AND BM1_TIPREG = ba1.BA1_TIPREG  "
	cQuery += CRLF +"   AND BM1_DIGITO = ba1.BA1_DIGITO  "          

	cQuery += CRLF +" GROUP BY bm1_codint || BM1_CODEMP ||bm1_matric || bm1_tipreg || bm1_digito ||' - '|| bm1_nomusr , " 
	cQuery += CRLF +"          decode(ba1.BA1_TIPUSU,'T', 'Titular','Dependente') , " 
	cQuery += CRLF +"          E1_PREFIXO || E1_NUM || E1_TIPO , "
	cQuery += CRLF +"          nvl(e1_saldo,0) , "
	cQuery += CRLF +"          SUBSTR(E1_BAIXA,7,2)||'/'||SUBSTR(E1_BAIXA,5,2)||'/'||SUBSTR(E1_BAIXA,1,4) , "
	cQuery += CRLF +"          DECODE(trim(BM1_CODEVE) , '0103' , 'DENTAL - E ' "
	cQuery += CRLF +"                                  , '0105' , 'DENTAL - M ' "
	cQuery += CRLF +"                                  , 'Nao Classificado ') , "
	cQuery += CRLF +"          CASE    WHEN (   trim(BM1_CODEVE)  = '0103' AND  BM1_YVLPRI = 7.14  ) THEN ' Pagto Integ ' "
	cQuery += CRLF +"                  WHEN (   trim(BM1_CODEVE)  = '0105' AND  BM1_YVLPRI = 20.12 ) THEN ' Pagto Integ ' "
	cQuery += CRLF +"                  WHEN (   trim(BM1_CODEVE)  = '0105' AND  BM1_YVLPRI = 7.14  ) THEN ' Pagto Parc. ' "
	cQuery += CRLF +"                  WHEN (   trim(BM1_CODEVE)  = '0103' AND  BM1_YVLPRI = 0.00  ) THEN ' N„o Pagto ' "
	cQuery += CRLF +"                  WHEN (   trim(BM1_CODEVE)  = '0105' AND  BM1_YVLPRI = 0.00  ) THEN ' N„o Pagto ' "
	cQuery += CRLF +"                  ELSE 'Nao Classificado ' END , "
	cQuery += CRLF +"          BM1_VALOR  ,BM1_CODPLA||' - ' ||bm1_despla ,  "
	cQuery += CRLF +"          substr(BM1_DTCPR,7,2)||'/'||substr(BM1_DTCPR,5,2)||'/' ||substr(BM1_DTCPR,1,4) , "
	cQuery += CRLF +"          BM1_YVLPRI , "
	cQuery += CRLF +"          substr(BM1_DTCPR1,7,2)||'/'||substr(BM1_DTCPR1,5,2)||'/'|| substr(BM1_DTCPR1,1,4) , "
	cQuery += CRLF +"          BM1_YVLPR1 "   
	cQuery += CRLF +"    ORDER BY  bm1_codint || BM1_CODEMP ||bm1_matric || bm1_tipreg || bm1_digito ||' - '|| bm1_nomusr "
 
Else 
 
    cQuery :=" SELECT TRIM(BM1_CODINT || BM1_CODEMP ||BM1_MATRIC || BM1_TIPREG || BM1_DIGITO ||' - '|| BM1_NOMUSR) USUARIO , "
	cQuery += CRLF +" NVL(E1_SALDO,0) SALD_TIT , "
	cQuery += CRLF +" E1_PREFIXO || E1_NUM || E1_TIPO  TITULO , "
	cQuery += CRLF +" SUBSTR(E1_BAIXA,7,2)||'/'||SUBSTR(E1_BAIXA,5,2)||'/'||SUBSTR(E1_BAIXA,1,4) BAIXA , "
	cQuery += CRLF +" DECODE(BA1.BA1_TIPUSU,'T', 'Titular','Dependente') TIT_DEP , "            
	
    cQuery += CRLF +" DECODE(TRIM(BM1_CODPLA )  ,'0112' , ('STANDARD - E' )      ,'0114' , ('STANDARD RIO - E' ) "
	cQuery += CRLF +"                           ,'0117' , ('ESSENCIAL RIO - E' ) ,'0121' , ('MAIS RIO - E' ) "
	cQuery += CRLF +"                           ,'0126' , ('MULTI RIO - E' )     ,'0128' , ('TOTAL RIO - E' ) "           
	cQuery += CRLF +"                           ,'0113' , ('STANDARD - M' )      ,'0115' , ('STANDARD RIO - M' ) "                                    
	cQuery += CRLF +"                           ,'0119' , ('ESSENCIAL RIO - M' ) ,'0123' , ('MAIS RIO - M' ) "
	cQuery += CRLF +"                           ,'0127' , ('MULTI RIO - M' )     ,'0129' , ('TOTAL RIO - M' ) "    
    cQuery += CRLF +"                           , 'Nao Classificado ' ) PLANO_BASE , "
	       
	
	cQuery += CRLF +"CASE WHEN ( BM1_YVLPRI =  ( VALOR_PARTE_DENTAL * 0.75 ) ) THEN ' Pagto Integ ' "
	cQuery += CRLF +"               WHEN ( BM1_YVLPRI <> ( VALOR_PARTE_DENTAL * 0.75 ) AND BM1_YVLPRI <> 0.00  ) THEN ' Pagto Parc. ' " 
	cQuery += CRLF +"               WHEN ( BM1_YVLPRI = 0.00  ) THEN ' N„o Pagto ' "
	cQuery += CRLF +"          ELSE 'Nao Classificado ' END statu ,  "

	
	cQuery += CRLF +" TRIM(BM1_CODPLA||' - ' ||BM1_DESPLA) PLANO , "
	cQuery += CRLF +" VALOR_PARTE_DENTAL VLR_CABERJ , "
	cQuery += CRLF +" SUBSTR(BM1_DTCPR,7,2)||'/'||SUBSTR(BM1_DTCPR,5,2)||'/'|| SUBSTR(BM1_DTCPR,1,4) DAT_CALC , "
	cQuery += CRLF +" BM1_YVLPRI VLR_CALC , "
	cQuery += CRLF +" SUBSTR(BM1_DTCPR1,7,2)||'/'||SUBSTR(BM1_DTCPR1,5,2)||'/'|| SUBSTR(BM1_DTCPR1,1,4) DAT_RECALC , "
	cQuery += CRLF +" BM1_YVLPR1 VLR_RECALC , "
	cQuery += CRLF +" SUM(( VALOR_PARTE_DENTAL * 0.75 ) - ( BM1_YVLPRI+BM1_YVLPR1)) SALDO_PGTO "
   
	cQuery += CRLF +"  FROM  " + RetSqlName("BM1") + " BM1 ," + RetSqlName("SE1") + " SE1 ," + RetSqlName("BA1") + " BA1 , SIGA.VALOR_PARTE_ODONTO_PREFEITURA"
	cQuery += CRLF +" WHERE BM1_FILIAL = '" + xFilial("BM1") +"' AND BM1.D_E_L_E_T_ = ' '  "   
	cQuery += CRLF +"   AND  E1_FILIAL = '" + xFilial("SE1") +"' AND SE1.D_E_L_E_T_ = ' '  "  
	cQuery += CRLF +"   AND BA1_FILIAL = '" + xFilial("BA1") +"' AND BA1.D_E_L_E_T_ = ' '  "  

	cQuery += CRLF +"   AND BM1_MES    = '"+cCompMes+"'"
	cQuery += CRLF +"   AND BM1_ANO    = '"+cCompAno+"'"  

	cQuery += CRLF +"   AND BM1_CODEMP IN ( '0024' , '0025','0027','0028') " 
	cQuery += CRLF +"   AND BM1_CODTIP = '101' " 
	
	cQuery += CRLF +"   AND BM1_CODINT = BA1.BA1_CODINT "
	cQuery += CRLF +"   AND BM1_CODEMP = BA1.BA1_CODEMP " 
	cQuery += CRLF +"   AND BM1_MATRIC = BA1.BA1_MATRIC "
	cQuery += CRLF +"   AND BM1_TIPREG = BA1.BA1_TIPREG "
	cQuery += CRLF +"   AND BM1_DIGITO = BA1.BA1_DIGITO " 

	cQuery += CRLF +"   AND E1_PREFIXO =  BM1_PREFIX "
	cQuery += CRLF +"   AND E1_NUM     =  BM1_NUMTIT "
	cQuery += CRLF +"   AND E1_TIPO    =  BM1_TIPTIT "    
	
    cQuery += CRLF +"   AND ((E1_SALDO  <> 0 ) "       
  	cQuery += CRLF +"    OR  (  BM1_YVLPRI <> ( VALOR_PARTE_DENTAL * 0.75 ) )"
	cQuery += CRLF +"    OR  (  BM1_YVLPRI <  ( VALOR_PARTE_DENTAL * 0.75 ) ) ) "
    
	cQuery += CRLF +"   AND BM1_CODPLA = COD_PLANO "
  
	cQuery += CRLF +" GROUP BY BM1_CODINT || BM1_CODEMP ||BM1_MATRIC || BM1_TIPREG || BM1_DIGITO ||' - '|| BM1_NOMUSR , "
	cQuery += CRLF +"          NVL(E1_SALDO,0) , "
	cQuery += CRLF +"          E1_PREFIXO || E1_NUM || E1_TIPO , "
	cQuery += CRLF +"          SUBSTR(E1_BAIXA,7,2)||'/'||SUBSTR(E1_BAIXA,5,2)||'/'||SUBSTR(E1_BAIXA,1,4) , "
	cQuery += CRLF +"          DECODE(BA1.BA1_TIPUSU,'T', 'Titular','Dependente') , "
	
    cQuery += CRLF +"          DECODE(TRIM(BM1_CODPLA )  ,'0112' , ('STANDARD - E' )       ,'0114' , ('STANDARD RIO - E' ) "
	cQuery += CRLF +"                                    ,'0117' , ('ESSENCIAL RIO - E' )  ,'0121' , ('MAIS RIO - E' ) "
	cQuery += CRLF +"                                    ,'0126' , ('MULTI RIO - E' )      ,'0128' , ('TOTAL RIO - E' ) "           
	cQuery += CRLF +"                                    ,'0113' , ('STANDARD - M' )       ,'0115' , ('STANDARD RIO - M' ) "                                    
	cQuery += CRLF +"                                    ,'0119' , ('ESSENCIAL RIO - M' )  ,'0123' , ('MAIS RIO - M' ) "
	cQuery += CRLF +"                                    ,'0127' , ('MULTI RIO - M' )      ,'0129' , ('TOTAL RIO - M' ) "    
    cQuery += CRLF +"                                    , 'Nao Classificado ' ) , "     
	
	cQuery += CRLF +"          CASE WHEN ( BM1_YVLPRI =  ( VALOR_PARTE_DENTAL * 0.75 ) ) THEN ' Pagto Integ ' "
	cQuery += CRLF +"               WHEN ( BM1_YVLPRI <> ( VALOR_PARTE_DENTAL * 0.75 ) AND BM1_YVLPRI <> 0.00  ) THEN ' Pagto Parc. ' " 
	cQuery += CRLF +"               WHEN ( BM1_YVLPRI = 0.00  ) THEN ' N„o Pagto ' "
	cQuery += CRLF +"          ELSE 'Nao Classificado ' END ,  "
	
	cQuery += CRLF +"          VALOR_PARTE_DENTAL  , "
	cQuery += CRLF +"          BM1_CODPLA||' - ' ||BM1_DESPLA , "
	cQuery += CRLF +"          SUBSTR(BM1_DTCPR,7,2)||'/'||SUBSTR(BM1_DTCPR,5,2)||'/'|| SUBSTR(BM1_DTCPR,1,4) , " 
	cQuery += CRLF +"          BM1_YVLPRI , "
	cQuery += CRLF +"          SUBSTR(BM1_DTCPR1,7,2)||'/'||SUBSTR(BM1_DTCPR1,5,2)||'/'|| SUBSTR(BM1_DTCPR1,1,4) , "
	cQuery += CRLF +"          BM1_YVLPR1 "
  	cQuery += CRLF +" ORDER BY BM1_CODINT || BM1_CODEMP ||BM1_MATRIC || BM1_TIPREG || BM1_DIGITO ||' - '|| BM1_NOMUSR " 
  
EndIf  


If Select(("TMP")) <> 0 
       ("TMP")->(DbCloseArea()) 
Endif
    
TCQuery cQuery Alias "TMP" New 
                                                                                           
dbSelectArea("TMP")
              
//  base     
   If TMP1->QTDREPROC > 0
      cNomDadCab:=  '4 - Reprocessamento -  Titulos com Saldo '
   Else 
      cNomDadCab:=  '4 - Processamento -  Titulos com Saldo  '
   EndIf 
         
   cComp     := cCompMes+'/'+cCompAno
   cNomPla   := cNomDadCab                 
 
   cNomeArq := "C:\TEMP\"+cCompAno+cCompMes+" - "+cNomDadCab+"_"+SubStr(DtoS(date()),7,2)+"_"+SubStr(DtoS(date()),5,2)+"_"+SubStr(DtoS(date()),1,4)+"_"+STRTRAN(TIME(),":","_")+".csv"

		nHandle := FCREATE(cNomeArq)
        cMontaTxt := cNomDadCab
        cMontaTxt += CRLF
        FWrite(nHandle,cMontaTxt)       		 
        cMontaTxt := 'Competencia : ' + cComp
        cMontaTxt += CRLF
        FWrite(nHandle,cMontaTxt)		 
        cMontaTxt := 'Planilha : '+cNomPla  
        cMontaTxt += CRLF
        FWrite(nHandle,cMontaTxt)	    
        
        cMontaTxt := "Usuario    ;"       
		cMontaTxt += "Tp usuario ;"    
		cMontaTxt += "Plano Base ;"         
		cMontaTxt += "Plano  ;"        		
		cMontaTxt += "Status ;"
		
		cMontaTxt += "Num Titulo a Receber ;"	  
		cMontaTxt += "Dt Baixa ;"    
		cMontaTxt += "Saldo Tit  ;"   
		

		cMontaTxt += "Vlr Cobrado  ;"
		cMontaTxt += "Data do Calc ;"
		cMontaTxt += "Vlr Odont. Calc. ;" 
		cMontaTxt += "Data do ReCalc ;"		
		cMontaTxt += "Vlr Odont. ReCalc. ;"  		  		 		  		
		cMontaTxt += "Saldo a Pgto  ;"
				
		cMontaTxt += CRLF // Salto de linha para .csv (excel)
             
		FWrite(nHandle,cMontaTxt)
   
    tmp->(dbGoTop())   
    
          nSald_tit   := 0            
		  nVlr_Caberj := 0      
		  nVlr_Calc   := 0          
		  nVlr_ReCalc := 0
		  nsaldo_pgto := 0 
		  nVLDEVPRIMA := 0		  
          nqtda       := 0                  
   
    While !(TMP->(Eof()))               
    
   		  cMontaTxt := tmp->usuario + ";"                                
   		  cMontaTxt += tmp->Tit_Dep + ";"  
   		  cMontaTxt += tmp->Plano_base + ";" 
   		  cMontaTxt += tmp->Plano +";'   		      
          cMontaTxt += tmp->statu + ";"            
                                
   		  cMontaTxt += tmp->TITULO + ";"  
          cMontaTxt += tmp->BAIXA + ";" 
   		  cMontaTxt += Transform(tmp->Sald_tit    ,'@E  999,999,999.99') + ";"
                                                
          cMontaTxt += Transform(tmp->Vlr_Caberj  ,'@E  999,999,999.99') + ";"       
          cMontaTxt += tmp->DAT_CALC + ";"          
		  cMontaTxt += Transform(tmp->Vlr_Calc    ,'@E  999,999,999.99') + ";"       
          cMontaTxt += tmp->DAT_RECALC + ";"          
		  cMontaTxt += Transform(tmp->Vlr_ReCalc  ,'@E  999,999,999.99') + ";"
		  cMontaTxt += Transform(tmp->saldo_pgto  ,'@E  999,999,999.99') + ";"
		  
		  cMontaTxt += CRLF // Salto de linha para .csv (excel)      
		      
		  FWrite(nHandle,cMontaTxt)     
		  
		  nSald_tit   += tmp->Sald_tit            
		  nVlr_Caberj += tmp->Vlr_Caberj      
		  nVlr_Calc   += tmp->Vlr_Calc          
		  nVlr_ReCalc += tmp->Vlr_ReCalc
		  nsaldo_pgto += tmp->saldo_pgto   
		  
         tmp->(DbSkip())

    EndDo       

          cMontaTxt := ' '  + ";"                                
   		  cMontaTxt += ' '  + ";"  
   		  cMontaTxt += ' '  + ";"     
          cMontaTxt += ' '  + ";"            
          cMontaTxt += ' '  + ";"                                            
   		  cMontaTxt += ' '  + ";"  
          cMontaTxt += ' '  + ";" 
   		  cMontaTxt += Transform(nSald_tit    ,'@E  999,999,999.99') + ";"
                                                
          cMontaTxt += Transform(nVlr_Caberj  ,'@E  999,999,999.99') + ";"       
          cMontaTxt += ' '  + ";"          
		  cMontaTxt += Transform(nVlr_Calc    ,'@E  999,999,999.99') + ";"       
          cMontaTxt += ' '  + ";"          
		  cMontaTxt += Transform(nVlr_ReCalc  ,'@E  999,999,999.99') + ";"
		  cMontaTxt += Transform(nsaldo_pgto  ,'@E  999,999,999.99') + ";"
		  
		  cMontaTxt += CRLF // Salto de linha para .csv (excel)      
		      
		  FWrite(nHandle,cMontaTxt)     



	If nHandle > 0
		
		// encerra gravaÁ„o no arquivo
		FClose(nHandle)
		cNomeArq1+= cNomeArq + CRLF
     	//	MsgAlert("Relatorio salvo em: "+cNomeArq)
		
	EndIf           

     	MsgAlert("Relatorio salvo em : "+ CRLF +cNomeArq1)

Return ()    


static function fVerifcal(cCompMes,cCompAno)
cQuery :=       " select qtdaproc.proc QTDPROC , qtdareproc.repoc QTDREPROC "
cQuery += CRLF + " FROM "     
cQuery += CRLF +"(SELECT count(*) proc"
cQuery += CRLF +"   FROM " + RetSqlName("BM1") + " BM1" 
cQuery += CRLF +"  WHERE BM1_FILIAL = '" + xFilial("BM1") +"' AND BM1.D_E_L_E_T_ = ' '  "
cQuery += CRLF +"    AND BM1_MES    = '"+cCompMes +"' "
cQuery += CRLF +"    AND BM1_ANO    = '"+cCompAno+"'"          
cQuery += CRLF +"    AND BM1_CODEMP in ( '0024' , '0025','0027','0028') "               
cQuery += CRLF +"    AND BM1_YVLPRI  > 0  )qtdaproc , " 
//cQuery += CRLF +"    AND BM1_CODTIP   = '102' and BM1_CODEVE IN  ('0103','0105') )qtdaproc , "

cQuery += CRLF +"(SELECT count(*) repoc "
cQuery += CRLF +"   FROM " + RetSqlName("BM1") + " BM1" 
cQuery += CRLF +"  WHERE BM1_FILIAL = '" + xFilial("BM1") +"' AND BM1.D_E_L_E_T_ = ' '  "
cQuery += CRLF +"    AND BM1_MES    = '"+cCompMes +"' "
cQuery += CRLF +"    AND BM1_ANO    = '"+cCompAno+"'"          
cQuery += CRLF +"    AND BM1_CODEMP in ( '0024' , '0025','0027','0028') "               
cQuery += CRLF +"    AND BM1_YVLPR1  > 0 )qtdareproc "   
//cQuery += CRLF +"    AND BM1_CODTIP   = '102' and BM1_CODEVE IN  ('0103','0105') )qtdareproc "
           
   
   If Select(("TMP1")) <> 0 
       ("TMP1")->(DbCloseArea()) 
    Endif
    
    TCQuery cQuery Alias "TMP1" New 

    dbSelectArea("TMP1")

    tmp1->(dbGoTop())                  

Return ()      

*************************************************************************************************************  
Static Function fGeraRel()

Local oReport 
Private cPerg		:= "CABR215"  
Private aOrdem 		:= {}//{'RDA','Ano/Mes'}              
 
 

oReport:= ReportDef()
oReport:PrintDialog()

Return

*************************************************************************************************************

********************************************************************************************************************************

/*/
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±⁄ƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒø±±
±±≥Programa  ≥ReportDef ≥ Autor ≥ Leonardo Portella                       ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥DescriáÖo ≥A funcao estatica ReportDef devera ser criada para todos os ≥±±
±±≥          ≥relatorios que poderao ser agendados pelo usuario.          ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥Retorno   ≥ExpO1: Objeto do relatorio                                  ≥±±
±±¿ƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
/*/                         

Static Function ReportDef()

Local oReport 
Local oDPJ     
oReport	:= TReport():New("CABR215","Listagem de Conferencia de Repasse Primavida - Base caberj  ",, {|oReport| ReportPrt(oReport)},"Listagem de Conferencia de Repasse Primavida  ")
oReport:SetTotalInLine(.F.)//Imprime na linha: .F. - Imprime abaixo da linha com o titulo de cada coluna: .T.
//oReport:SetTotalText('Total Geral') 

*'-----------------------------------------------------------------------------------'*
*'Solucao para impressao em que as colunas se truncam: "SetColSpace" e "SetLandScape"'* 
*'-----------------------------------------------------------------------------------'*

oReport:SetColSpace(1) //Espacamento entre colunas. 
oReport:SetLandscape() //Impressao em paisagem.  
//oReport:SetPortrait() //Impressao em retrato.  

oDPJ := TRSection():New(oReport,"Listagem de Conferencia de Repasse Primavida - Base Caber  )",,aOrdem)    

                
   TRCell():New(oDPJ ,'EMPRESA'       		,/*TABELA*/	,'Cod Emp '    ,/*Picture*/   		,06				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
   TRCell():New(oDPJ ,'PLANO  '       		,/*TABELA*/	,'Plano   '    ,/*Picture*/ 	    ,30				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		) 
   TRCell():New(oDPJ ,'TIPPLA '	     		,/*TABELA*/	,'Tipo Plano ' ,/*Picture*/ 	    ,30				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		) 
     
   TRCell():New(oDPJ ,'VLRPRI'				,/*TABELA*/	,'Vlr PrimaVida'    ,"@E        999.99"  ,10			 	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"		)  
   TRCell():New(oDPJ ,'VLRCAB'				,/*TABELA*/	,'Vlr caberj   '    ,"@E 99,999,999.99"  ,15			 	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"		) 
   
   TRCell():New(oDPJ ,'VLRCAL'				,/*TABELA*/	,'Vlr Calculado'    ,"@E 99,999,999.99"  ,15			 	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"		)       
   TRCell():New(oDPJ ,'VLRREC'				,/*TABELA*/	,'Vlr ReCalc   '    ,"@E 99,999,999.99"  ,15			 	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"		)  
   TRCell():New(oDPJ ,'VLRDPRI'				,/*TABELA*/	,'Vlr Dev Prima'    ,"@E 99,999,999.99"  ,15			 	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"		) 
   TRCell():New(oDPJ ,'QTDA  '				,/*TABELA*/	,'Qtda  '           ,"@E        99,999"  , 6			 	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"		)        
   
   TRCell():New(oDPJ ,'VLRSPG'	    		,/*TABELA*/	,'Saldo a pagar '   ,"@R 9,999,999.99"   ,15			 	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"		)       
                                                                          

 oBreak01 		:= TRBreak():New(oDPJ,oDPJ:Cell("EMPRESA"),"Total Competencia "	,.F.)  

lTotSecBrk01	:= .T.//Indica se totalizador sera impresso na quebra de secao
lTotFimBrk01	:= .T.//Indica se totalizador sera impresso no final do relatorio - Como o total eh o mesmo, basta que apenas um esteja ativado
                                                                     
// TRFunction():New(oDPJ:Cell("VLRPRI")    	,NIL,"SUM"	    	,oBreak01,,"@E 999,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01)  
 TRFunction():New(oDPJ:Cell("VLRCAB")    	,NIL,"SUM"	    	,oBreak01,,"@E 999,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01) 
 TRFunction():New(oDPJ:Cell("VLRCAL")  		,NIL,"SUM"			,oBreak01,,"@E 999,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01) 
 TRFunction():New(oDPJ:Cell("VLRREC")  		,NIL,"SUM"			,oBreak01,,"@E 999,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01)  

 TRFunction():New(oDPJ:Cell("VLRDPRI")  	,NIL,"SUM"			,oBreak01,,"@E 999,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01)  
 TRFunction():New(oDPJ:Cell("QTDA")  		,NIL,"SUM"			,oBreak01,,"@E        999,999"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01) 
 TRFunction():New(oDPJ:Cell("VLRSPG")  		,NIL,"SUM"			,oBreak01,,"@E 999,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01) 
  
Return(oReport)

********************************************************************************************************************************
/*/
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±⁄ƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒø±±
±±≥Programa  ≥ReportPrint≥ Autor ≥ Leonardo Portella                      ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒ¥±±
±±≥DescriáÖo ≥A funcao estatica ReportDef devera ser criada para todos os ≥±±
±±≥          ≥relatorios que poderao ser agendados pelo usuario.          ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
/*/

Static Function ReportPrt(oReport)

Local   cImp    :='N„o'

Local i := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

Private oDPJ 	:= oReport:Section(1)

Private nCont	:= 0   

nCont := Len(aDados1)

//Se nao tiver esta linha, nao imprime os dados
oDPJ:init()

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
 
   oDPJ:Cell('EMPRESA'):SetValue((aDados1[i][01]))     
   oDPJ:Cell('PLANO  '):SetValue((aDados1[i][02]))
   oDPJ:Cell('TIPPLA '):SetValue((aDados1[i][03]))       
   oDPJ:Cell('VLRPRI'):SetValue((aDados1[i][04]))    
   oDPJ:Cell('VLRCAB'):SetValue((aDados1[i][05]))               
                                            
   oDPJ:Cell('VLRCAL'):SetValue((aDados1[i][06]))      
   oDPJ:Cell('VLRREC'):SetValue((aDados1[i][07]))  
   oDPJ:Cell('VLRDPRI'):SetValue((aDados1[i][08]))
   oDPJ:Cell('QTDA  '):SetValue((aDados1[i][09]))                
   
   oDPJ:Cell('VLRSPG'):SetValue((aDados1[i][10]))                                                                                                                                                                      
      
   oDPJ:PrintLine()
                                       
Next i                                 

oDPJ:Finish()

Return   
******************************************************************************************      
Static Function ReportPrt1(oReport)

Local   cImp    :='N„o'

Local i := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

Private oDPJ1 	:= oReport:Section(1)

Private nCont	:= 0   

nCont := Len(aDados1)

//Se nao tiver esta linha, nao imprime os dados
oDPJ1:init()

oReport:SetMeter(nCont) 

cTot	:= AllTrim(Transform(nCont,'@E 999,999,999,999'))
nCont 	:= 0       

For i := 1 To Len(aDados2)

	oReport:SetMsgPrint("Imprimindo linha " + AllTrim(Transform(++nCont,'@E 999,999,999,999')) + ' de ' + cTot)

	oReport:IncMeter()

	If oReport:Cancel()  
	    
	    oReport:FatLine()     
	    oReport:PrintText('Cancelado pelo operador!!!',,,CLR_RED,,,.T.)
		
	    exit
	    
	EndIf       
 
   oDPJ:Cell('EMPRESA'):SetValue((aDados1[i][01]))     
   oDPJ:Cell('PLANO  '):SetValue((aDados1[i][02]))
   oDPJ:Cell('TIPPLA '):SetValue((aDados1[i][03]))       
   oDPJ:Cell('VLRPRI'):SetValue((aDados1[i][04]))    
   oDPJ:Cell('VLRCAB'):SetValue((aDados1[i][05]))               
                                            
   oDPJ:Cell('VLRCAL'):SetValue((aDados1[i][06]))      
   oDPJ:Cell('VLRREC'):SetValue((aDados1[i][07]))  
   oDPJ:Cell('VLRDPRI'):SetValue((aDados1[i][08]))
   oDPJ:Cell('QTDA  '):SetValue((aDados1[i][09]))                
   
   oDPJ:Cell('VLRSPG'):SetValue((aDados1[i][10]))                                                                               
                                                                                          
   oDPJ:PrintLine()
                                       
Next i                                 

oDPJ:Finish()

Return   

*************************************************************************************************************  
Static Function fGeraRel1()

Local oReport 
Private cPerg		:= "CABR215"  
Private aOrdem 		:= {}//{'RDA','Ano/Mes'}              
 
oReport:= ReportDef1()
oReport:PrintDialog()

Return

********************************************************************************************************************************

/*/
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±⁄ƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒø±±
±±≥Programa  ≥ReportDef ≥ Autor ≥ Leonardo Portella                       ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥DescriáÖo ≥A funcao estatica ReportDef devera ser criada para todos os ≥±±
±±≥          ≥relatorios que poderao ser agendados pelo usuario.          ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥Retorno   ≥ExpO1: Objeto do relatorio                                  ≥±±
±±¿ƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
/*/                         

Static Function ReportDef1()

Local oReport 
Local oDPJ1   
oReport	:= TReport():New("CABR215","Listagem de Conferencia de Repasse Primavida - Base Pagto   ",, {|oReport| ReportPr1(oReport)},"Listagem de Conferencia de Repasse Primavida  ")
oReport:SetTotalInLine(.F.)//Imprime na linha: .F. - Imprime abaixo da linha com o titulo de cada coluna: .T.
//oReport:SetTotalText('Total Geral') 

*'-----------------------------------------------------------------------------------'*
*'Solucao para impressao em que as colunas se truncam: "SetColSpace" e "SetLandScape"'* 
*'-----------------------------------------------------------------------------------'*

oReport:SetColSpace(1) //Espacamento entre colunas. 
oReport:SetLandscape() //Impressao em paisagem.  
//oReport:SetPortrait() //Impressao em retrato.  
               
  oDPJ1 := TRSection():New(oReport,"Listagem de Conferencia de Repasse Primavida - Base Pagto   )",,aOrdem)    
                                                                                                                            
   TRCell():New(oDPJ1 ,'STATUS'       		,/*TABELA*/	,'Status '     ,/*Picture*/   		,10				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		) 
   TRCell():New(oDPJ1 ,'TPUSUA'       		,/*TABELA*/	,'Tp Usuario ' ,/*Picture*/   		,20				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)   
   TRCell():New(oDPJ1 ,'PLANO '       		,/*TABELA*/	,'Plano   '    ,/*Picture*/ 	    ,30				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)  
   TRCell():New(oDPJ1 ,'TPLANO'       		,/*TABELA*/	,'Tp Plano'    ,/*Picture*/ 	    ,30				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)  
   TRCell():New(oDPJ1 ,'DTCALC'	        	,/*TABELA*/	,'Dt.Calculo '  ,/*"@E 99:99"	*/  ,10				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)   
   TRCell():New(oDPJ1 ,'QTDA  '				,/*TABELA*/	,'Qtda  '      ,"@E        99,999"  , 6			 	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"		)                            
   TRCell():New(oDPJ1 ,'VLRPRI'				,/*TABELA*/	,'Vlr PrimaVida'    ,"@E        999.99"  ,10			 	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"		)  
   TRCell():New(oDPJ1 ,'VLRCAB'				,/*TABELA*/	,'Vlr caberj   '    ,"@E 99,999,999.99"  ,15			 	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"		) 
   TRCell():New(oDPJ1 ,'VLRCAL'				,/*TABELA*/	,'Vlr Calculado'    ,"@E 99,999,999.99"  ,15			 	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"		)       
   TRCell():New(oDPJ1 ,'VLRSPG'	    		,/*TABELA*/	,'Saldo a pagar '   ,"@R 9,999,999.99"   ,15			 	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"		)       
                                                                          
   oBreak01 		:= TRBreak():New(oDPJ1,oDPJ1:Cell("STATUS"),"Total Competencia "	,.F.)  

lTotSecBrk01	:= .T.//Indica se totalizador sera impresso na quebra de secao
lTotFimBrk01	:= .T.//Indica se totalizador sera impresso no final do relatorio - Como o total eh o mesmo, basta que apenas um esteja ativado
                                                                     
// TRFunction():New(oDPJ1:Cell("VLRPRI")    	,NIL,"SUM"	    	,oBreak01,,"@E 999,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01)  
 TRFunction():New(oDPJ1:Cell("VLRCAB")    	,NIL,"SUM"	    	,oBreak01,,"@E 999,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01) 
 TRFunction():New(oDPJ1:Cell("VLRCAL") 		,NIL,"SUM"			,oBreak01,,"@E 999,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01) 
 TRFunction():New(oDPJ1:Cell("QTDA")  		,NIL,"SUM"			,oBreak01,,"@E        999,999"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01) 
 TRFunction():New(oDPJ1:Cell("VLRSPG") 		,NIL,"SUM"			,oBreak01,,"@E 999,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01)  
Return(oReport)

********************************************************************************************************************************

/*/
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±⁄ƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒø±±
±±≥Programa  ≥ReportPrint≥ Autor ≥ Leonardo Portella                      ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒ¥±±
±±≥DescriáÖo ≥A funcao estatica ReportDef devera ser criada para todos os ≥±±
±±≥          ≥relatorios que poderao ser agendados pelo usuario.          ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
/*/

Static Function ReportPr1(oReport)

Local   cImp    :='N„o'

Local i := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

Private oDPJ1 	:= oReport:Section(1)

Private nCont	:= 0   

nCont := Len(aDados2)

//Se nao tiver esta linha, nao imprime os dados
oDPJ1:init()

oReport:SetMeter(nCont) 

cTot	:= AllTrim(Transform(nCont,'@E 999,999,999,999'))
nCont 	:= 0       

For i := 1 To Len(aDados2)

	oReport:SetMsgPrint("Imprimindo linha " + AllTrim(Transform(++nCont,'@E 999,999,999,999')) + ' de ' + cTot)

	oReport:IncMeter()

	If oReport:Cancel()  
	    
	    oReport:FatLine()     
	    oReport:PrintText('Cancelado pelo operador!!!',,,CLR_RED,,,.T.)
		
	    exit
	    
	EndIf       

   oDPJ1:Cell('STATUS'):SetValue((aDados2[i][01]))      
   oDPJ1:Cell('TPUSUA'):SetValue((aDados2[i][02]))     
   oDPJ1:Cell('PLANO '):SetValue((aDados2[i][04]))
   oDPJ1:Cell('TPLANO'):SetValue((aDados2[i][03]))        
   oDPJ1:Cell('DTCALC'):SetValue((aDados2[i][08]))       
   oDPJ1:Cell('QTDA  '):SetValue((aDados2[i][05]))                
   oDPJ1:Cell('VLRPRI'):SetValue((aDados2[i][06]))    
   oDPJ1:Cell('VLRCAB'):SetValue((aDados2[i][07]))               
   oDPJ1:Cell('VLRCAL'):SetValue((aDados2[i][09]))      
   oDPJ1:Cell('VLRSPG'):SetValue((aDados2[i][10]))                                                                               
                                                         
   oDPJ1:PrintLine()
   
Next i

oDPJ1:Finish()

Return                   

User Function fRetVlrOdo( cTpUsu , cPlano ,nvlTit ,  nSaldoTit)    

local nRet := 0


   If nvlTit == nSaldoTit                       

      nRet := 0.00  
      
   Else                             
   
   If cPlano = '112' .and. cTpUsu == 'T'  
   
      nRet := 7.56                           
   
   ElseIf cPlano = '113' .and. cTpUsu == 'T' 
   
       If nSaldoTit == 0
          nRet := 30.36
       Else            
          nRet := 7.56
       EndIf                                  

   ElseIf cPlano $ ('114,117,121,126,128') 
 
      nRet := 11.43                          

      If nSaldoTit != 0 
         If cTpUsu == 'T'
            nRet := 7.56
         Else            
            nRet := 0
         EndIf 
      EndIf                                     
    
   ElseIf cPlano $ ('115,119,123,127,129') 
 
      nRet := 34.23                          

      If nSaldoTit != 0 
         If cTpUsu == 'T'
            nRet := 7.56
         Else            
            nRet := 0
         EndIf 

      EndIf                                     

   EndIF 

EndIF   

Return(nRet)        

/*
								
tipusr	    codeve	deseve	            codpla	despla 	               valor 	repase		
Titular	    112	    STANDARD E          112		STANDARD E              7,56	  7,14  *	112
Titular	    113		STANDARD M          113		STANDARD M             30,36	 20,12	*	113
Dependete	114		STANDARD RIO E      114		STANDARD RIO E         11,43	  7,14	*	114,117,121,126,128
Dependete	115		STANDARD RIO M      115		STANDARD RIO M         34,23	 20,12	*	115,119,123,127,129
Dependete	117		ESSENCIAL RIO E     117		ESSENCIAL RIO E        11,43	  7,14	*	
Titular	    117		ESSENCIAL RIO E     117		ESSENCIAL RIO E        11,4 3	  7,14	*	
Titular	    119		ESSENCIAL RIO M     119		ESSENCIAL RIO M        34,23	 20,12	*	
Dependete	119		ESSENCIAL RIO M     119		ESSENCIAL RIO M        34,23	 20,12	*	
Dependete	121		MAIS RIO E          121		MAIS RIO E             11,43	  7,14	*	
Titular	    121		MAIS RIO E          121		MAIS RIO E             11,43	  7,14	*	
Titular	    123		MAIS RIO M          123		MAIS RIO M             34,23	 20,12	*	
Dependete	123		MAIS RIO M          123		MAIS RIO M             34,23	 20,12	*	
Dependete	126		MULTI RIO E         126		MULTI RIO E            11,43	  7,14	*	
Titular	    126		MULTI RIO E         126		MULTI RIO E            11,43	  7,14	*	
Titular	    127		MULTI RIO M         127		MULTI RIO M            34,23	 20,12	*	
Dependete	127		MULTI RIO M         127		MULTI RIO M            34,23	 20,12	*	
Titular	    128		TOTAL RIO E         128		TOTAL RIO E            11,43	  7,14	*	
Dependete	128		TOTAL RIO E         128		TOTAL RIO E            11,43	  7,14	*	
Dependete	129		TOTAL RIO M         129		TOTAL RIO M            34,23	 20,12	*	
Titular	    129		TOTAL RIO M         129		TOTAL RIO M            34,23	 20,12	*	

