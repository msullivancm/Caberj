#include "PROTHEUS.CH"
#Include 'PLSMGER.CH'
#include "PLSMGER2.CH"
#include "PLSMCCR.CH"                                               
#include "topconn.ch"
#INCLUDE "TOTVS.CH"
#INCLUDE "rwmake.ch"                                                           
#include "SIGAWIN.CH"
                                                                                                                           
/*/                                                                                      
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออออหออออออัอออออออออออปฑฑ
ฑฑบPrograma  ณCABR189   บ Autor ณAltamiro              บ Data ณ 18/05/2018บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออออสออออออฯอออออออออออนฑฑ
ฑฑบDescricao ณ Rotina para Pagamento a METLIFE                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/                  

User Function CABR189c

Local cMsg			:= ""      
Local nCont			:= 0
Private cDpj        := 'Nใo'   
private cImp        := 'Nใo'
Private oLeTxt
Private lAbortPrint :=.F.
Private cPerg       := "CABR189c"
Private cTitulo     := "Pagamento a "
Private lpvez       :=.T.   
Private cTpCrit     :=" "  
Private lImporta    := .F.  
Private f_ok        := .T.
private lDesfaz     := .F.
Private nLocaliz    := 0 // 1 - zzq -- 2 se2  -- 0 nao localizado         
PRIVATE cEmpresa    :=  Iif(cempant == '01','Caberj','Integral')  
private cpgto       := ' '       

private lFaturado   := .F.

private ind         := 1   

private cTitCSald   := ' '   
PRIVATE nVlrTitPri  := 0.00
PRIVATE nVlrTitcmp  := 0.00   
private cNomeArq1   := ' '   

Private  aDadosOk    := {}
Private  aDadosSCabj := {}
Private  aDadosSlife := {}          

Private  aDadoslife := {}     
Private  aDadosCabj := {}        
                              
Private  aDadosCMF  := {}      
Private  aDadosECMF := {}    
Private  aDaECMF    := {}   
Private  aDadosECCB := {}     

PRIVATE I := 1
PRIVATE X := 1
                                                                          
Private  cNomeArq	:= ""
Private  cMesAdi	:= ""
Private  cAnoAdi	:= "" 
Private  cCritica   := " " 
Private  cCritImp   := " "  

private nPos        := 0    
private lfaz        :=.F.

private dDtInic     := ' '      
private dDtBloq     := ' ' 

Private  cUsua      := SubStr(cUSUARIO,7,15)     
private cRdaEmp     := 1
private cNomEmp     := ' '

 AjustaSX1(cPerg)

cCompMes    := SUBSTR(mv_par01,1,2) 
cCompAno    := SUBSTR(mv_par01,4,4)    

dDtInic     := cCompAno+cCompMes+'01'      
dDtBloq     := cCompAno+cCompMes+'01' 
                                                                         
ldesfaz     := .F.
LFazpag     := iif(mv_par02 == 2, .T. , .F.)

cRdaEmp     := iif(mv_par14 == 1 ,'145246','143260')
cNomEmp     := iif(mv_par14 == 1 ,'Met Life','Prima Vida')

cTitulo     := "Pagamento a " + cNomEmp 
   cCritNsai   :="'CC|CR|CF"                     
   
   cCritNsai   += Iif (mv_par03== 1 , "|CP",'')  
   cCritNsai   += Iif (mv_par04== 1 , "|CB",'')  
   cCritNsai   += Iif (mv_par05== 1 , "|CM",'') 
   cCritNsai   += Iif (mv_par06== 1 , "|CD",'')     
   cCritNsai   += Iif (mv_par07== 1 , "|V+",'')  
   cCritNsai   += Iif (mv_par08== 1 , "|V-",'') 
   cCritNsai   += Iif (mv_par09== 1 , "|CI",'') 
   cCritNsai   += Iif (mv_par13== 2 , "|C ",'')             
   cCritNsai   +=	"'"
    
If  cCompMes  < '01' .OR. cCompMes > '12'    

     MsgAlert("Mes da competencia Invalido  , Mes Invalido . . . . " , "Atencao!!!")   
     return()
     
ElseIf cCompAno < '2018' .or.  cCompAno > '2030'    

     MsgAlert("Ano da competencia Invalido  , Ano Invalido . . . . " , "Atencao!!!")   
     return()

EndIf   

Processa({||Processa1()}, cTitulo, "", .T.)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Libera impressao                                                         ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

MsgInfo("Processo finalizado")

Return                 

**************************************************************************

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuno    ณ PROCESSA1บ Autor ณ Jean Schulz        บ Data ณ  11/11/06   บฑฑ
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
 

 
   cQuery := "      SELECT count(*) qtd "
   cQuery += CRLF +"  FROM " + RetSqlName("PD1") + " PD1" 
   cQuery += CRLF +" WHERE PD1_FILIAL = '" + xFilial("PD1") +"' AND PD1.D_E_L_E_T_ = ' '  "
   cQuery += CRLF +"   AND PD1_COMPTE = '"+cCompAno+cCompMes+"' " 
   cQuery += CRLF +"   AND PD1_CODRDA = '"+cRdaEmp+"' "   
   cQuery += CRLF +"   AND PD1_STATUS = 'Pre' "         
   
  If Select(("TMP1")) <> 0 
       ("TMP1")->(DbCloseArea()) 
  Endif
    
    TCQuery cQuery Alias "TMP1" New 
                                                                                           
    dbSelectArea("TMP1")

    tmp1->(dbGoTop())  
   
   If fVerfBgq() .and. lFaturado                                                                                                              

      msgBox("Pagamento Jแ realizado " ,"Relatorio sera emitido mas Nใo seram  refeito o Pagamento  !!!!","INFO")        
      
      f_ok := .F.

   ElseIf mv_par02 == 1  .and. tmp1->qtd !=  0                                                                          
   
      msgBox("Nใo Foi solicitado o Pagamento " ,"Relatorio sera emitido mas Nใo sera feito o fechamento !!!!","INFO")    

   ElseIf tmp1->qtd ==  0     
   
    	msgBox("Competencia de Faturamento Nใo Conferida " ,"Verifique  !!!!!","INFO")    
         
        Return()
        
   EndIf          
                                                        
	cQuery := CRLF +" select PD1.* 
	cQuery += CRLF +"   from siga." + RetSqlName("PD1") +  " PD1 " 
	cQuery += CRLF +"  where PD1_filial = ' ' and PD1.d_E_L_E_T_ = ' ' " 
	cQuery += CRLF +"    AND PD1_COMPTE = '"+cCompAno+cCompMes+"' AND PD1_STATUS = 'Fat' "      
   // cQuery += CRLF +"    AND PD1_CONF <> 'CB' "	
   // cQuery += CRLF +"   AND trim(PD1_matodo) in ('204086700','204086701','204086800','204086801')  "
    cQuery += CRLF +"   AND PD1_CODRDA = '"+cRdaEmp+"' "   
	cQuery += CRLF +"  order by PD1_codemp , pd1_conf , pd1_codpla "

If Select(("TMP")) <> 0 

   ("TMP")->(DbCloseArea()) 

Endif
    
    TCQuery cQuery Alias "TMP" New 
                                                                                           
    dbSelectArea("TMP")
   
    tmp->(dbGoTop())                                                      
    
    While !(TMP->(Eof()))                                                                                                                                                                                                   

        aAdd(aDadosCabj, {TMP->PD1_COMPTE ,; 
                          TMP->PD1_MATODO ,;
                          TMP->PD1_CODEMP ,;
                          Posicione("BG9",1,xFilial("BG9")+'0001'+TMP->PD1_CODEMP,"BG9_DESCRI"),;
                          TMP->PD1_NOMUSR ,; 
                          TMP->PD1_TPUSUA ,; 
                          TMP->PD1_CODPLA ,;
                          TMP->PD1_DESCPL ,; 
                          TMP->PD1_VALOR  ,; 
                          TMP->PD1_PARCEL ,; 
                          TMP->PD1_MATCAB ,; 
                          TMP->PD1_VLCAB  ,; 
                          TMP->PD1_CONF   ,; 
                          TMP->PD1_STATUS ,; 
                          TMP->PD1_QTDA   ,; 
                          TMP->PD1_CRITIC ,; 
                          TMP->PD1_LANCDC ,;
                          TMP->PD1_DESCRI })  
                                                                                                 
                                              
  //       If TMP->PD1_CONF == 'CC'
  //          a:= 'B' 
  //       EndIf                                                
         If (nAscan:=Ascan(aDadosCMF , {|e| e[1]+e[2]+e[3]+e[4]+e[5]+e[6] == TMP->PD1_CODEMP + ;
                                                                             TMP->PD1_CODPLA + ;
                                                                             TMP->PD1_CONF   + ;
                                                                             TMP->PD1_CRITIC + ;
                                                                        Iif (TMP->PD1_TPUSUA== 'D','Dependent','Titular')+;
                                                                             TMP->PD1_LANCDC })) == 0     
                                                                                    
   
   			Aadd(aDadosCMF , { TMP->PD1_CODEMP ,;
   			                   TMP->PD1_CODPLA ,;
   			                   TMP->PD1_CONF,;
                               TMP->PD1_CRITIC,; 
                               Iif (TMP->PD1_TPUSUA== 'D','Dependent','Titular') ,;
                               TMP->PD1_LANCDC ,;			                     
   		                       TMP->PD1_VALOR  ,;			                       
			                   1 ,;
			                   TMP->PD1_DESCPL})
	 	Else 

	 	    aDadosCMF[nAscan,7]+= TMP->PD1_VALOR
	 	    aDadosCMF[nAscan,8]+= 1	 	    

	 	EndIf     
	 	        
	 	
                                                
        If (nAscan:=Ascan(aDadosECMF , {|e| e[1]+e[2]+e[3]+e[4] == trim(TMP->PD1_CODPLA) +;
                                                                    TMP->PD1_CONF   + ;
                                                                    TMP->PD1_CRITIC + ;
                                                               Iif (TMP->PD1_TPUSUA== 'D','Dependent','Titular')})) == 0     
                                                                                    
   
   			Aadd(aDadosECMF , { trim(TMP->PD1_CODPLA) ,;
   			                    TMP->PD1_CONF,;
                                TMP->PD1_CRITIC,; 
                                Iif (TMP->PD1_TPUSUA== 'D','Dependent','Titular') ,;	                     
   		                        TMP->PD1_VALOR  ,;			                       
			                    1 ,;
			                    TMP->PD1_DESCPL})
	 	Else 

	 	    aDadosECMF[nAscan,5]+= TMP->PD1_VALOR
	 	    aDadosECMF[nAscan,6]+= 1	 	    

	 	EndIf   	 	
	 	
	 	
////////////////
If (nAscan:=Ascan(aDaECMF , {|e| e[1]+e[2]+e[3] == trim(TMP->PD1_CODPLA) +;
                                                        TMP->PD1_CONF   + ;
                                                        TMP->PD1_CRITIC })) == 0     
                                                                                    
   
   			Aadd(aDaECMF , { trim(TMP->PD1_CODPLA) ,;
   			                    TMP->PD1_CONF,;
                                TMP->PD1_CRITIC,; 
   		                        TMP->PD1_VALOR  ,;			                       
			                    1 ,;
			                    TMP->PD1_DESCPL})
	 	Else 

	 	    aDaECMF[nAscan,4]+= TMP->PD1_VALOR
	 	    aDaECMF[nAscan,5]+= 1	 	    

	 	EndIf   	 	
/////////////////
	 	
        tmp->(DbSkip())
		 	                  
    EndDo      
    
                      
If  f_ok .and.  !fVerfBgq()  .AND. LFazpag 
    
    For I:= 1 to len(aDadosCMF)       

        If !(aDadosCMF[I,3] $ cCritNsai)

           FGrvBGQ( aDadosCMF[I,1],;
                    aDadosCMF[I,2],;            
                    aDadosCMF[I,3],;
                    aDadosCMF[I,4],;           
                    aDadosCMF[I,5],;
                    aDadosCMF[I,6],;           
                    aDadosCMF[I,7],;
                    cCompAno , cCompMes, cRdaEmp )    
 
        EndIf
    
    Next      

EndIf 
   fGBCaberj()    
   
   FGrvPlan() 
                    
   u_cabr224a( cCompAno , cCompMes , aDadosCMF  ,aDaECMF ,cCritNsai ,LFazpag ,  f_ok ,   !fVerfBgq() ,  lFaturado , aDadosECCB , cRdaEmp) 
   
/* If mv_par02 == 1 .and. fVerfBgq()  .and. !lFaturado  
 
   fLimpBgq()
    
 EndIf  
*/     
Return()   

Static Function fGBCaberj()

cQuery := " SELECT  BA1_CODEMP CODEMP,"
cQuery +=         " BG9_DESCRI DESCEMP,"
cQuery +=         " BA1_CODPLA CODPLA,"
cQuery +=         " PAU_DESCML DESCPL,"
cQuery +=         " SUM(PAU_VLRML) VLRMLTOT,"
cQuery +=         " DECODE(TRIM(BA1_YMTODO), NULL, 'SEM MATRIC ODONT','COM MATRIC ODONT') MTODO,"
cQuery +=         " PAU_VLRML VLRML,"
cQuery +=         " COUNT(*) QTDA"
cQuery += " FROM " + RetSqlName("BA1") + " BA1"
cQuery +=   " INNER JOIN " + RetSqlName("BG9") + " BG9"
cQuery +=     " ON (    BG9_FILIAL = BA1_FILIAL"
cQuery +=         " AND BG9_CODINT = BA1_CODINT"
cQuery +=         " AND BG9_CODIGO = BA1_CODEMP)"
cQuery +=   " INNER JOIN " + RetSqlName("PAU") + " PAU"
cQuery +=     " ON (    PAU_FILIAL = BA1_FILIAL"
cQuery +=         " AND PAU_CONTRA = BA1_CONEMP"
cQuery +=         " AND PAU_SUBCON = BA1_SUBCON"
cQuery +=         " AND PAU_CODEMP = BA1_CODEMP"
cQuery +=         " AND PAU_CODPLA = BA1_CODPLA)"
cQuery += " WHERE BA1.D_E_L_E_T_ = ' ' AND BG9.D_E_L_E_T_ = ' ' AND PAU.D_E_L_E_T_ = ' '"
cQuery +=   " AND BA1_FILIAL = '" + xFilial("BA1") + "'"
cQuery +=   " AND BA1_YMTODO <> ' '"
cQuery +=   " AND BA1_DATINC <= '"  + dDtInic + "'"
cQuery +=   " AND (BA1_DATBLO >= '" + dDtBloq + "' OR BA1_DATBLO = ' ')"
cQuery +=   " AND (PAU_FIMVIG >= '" + dDtInic + "' OR PAU_FIMVIG = ' ')"
cQuery +=   " AND PAU_CODRDA = '" + cRdaEmp + "'"
cQuery +=   " AND EXISTS (SELECT PD1_FILIAL"
cQuery +=               " FROM " + RetSqlName("PD1") + " PD1"
cQuery +=               " WHERE PD1.D_E_L_E_T_ = ' '"
cQuery +=                 " AND PD1_FILIAL = BA1_FILIAL"
cQuery +=                 " AND PD1_COMPTE = '" + SubStr(dDtInic,1,6) + "'"
cQuery +=                 " AND PD1_CODRDA = PAU_CODRDA"
cQuery +=                 " AND PD1_MATCAB = BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG||BA1_DIGITO)"
cQuery += " GROUP BY BA1_CODEMP, BG9_DESCRI, BA1_CODPLA, PAU_DESCML, PAU_VLRML, DECODE(TRIM(BA1_YMTODO), NULL, 'SEM MATRIC ODONT', 'COM MATRIC ODONT')"

If Select(("TMP")) <> 0 

   ("TMP")->(DbCloseArea()) 

Endif
    
    TCQuery cQuery Alias "TMP" New 
                                                                                           
    dbSelectArea("TMP")
   
    tmp->(dbGoTop())                                                      

    
    While !(TMP->(Eof()))                                                                                                                                                                                                   

        aAdd(aDadosECCB, {TMP->Codemp   ,; 
                          TMP->descEmp  ,;
                          TMP->Codpla   ,; 
                          TMP->Descpl   ,; 
                          TMP->Vlrmltot ,;
                          TMP->Mtodo    ,;
                          TMP->Vlrml    ,;
                          TMP->qtda     })    
                          
                          
         tmp->(DbSkip())                    
    EndDo                       
    
   
Return() 

Static Function AjustaSX1(cPerg)

   Local aHelpPor := {}
   
   PutSx1(cPerg,"01",OemToAnsi("Mes/Ano Competencia?"                         ),"","","mv_ch01" ,"C",07,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","99/9999",aHelpPor,{},{})
   PutSx1(cPerg,"02",OemToAnsi("Faz Pagamento MetLife?"                       ),"","","mv_ch02" ,"N",01,0,0,"C","","","","","mv_par02","Nao","","","","Sim","","","","","","","","","","","",{},{},{})     
   PutSx1(cPerg,"03",OemToAnsi("Paga CP - Plano Diferente?"                   ),"","","mv_ch03" ,"N", 1,0,0,"C","","","","","mv_par03","Nao","","","","Sim","","","","","","","","","","","","","","","","","","","","")
   PutSx1(cPerg,"04",OemToAnsi("Paga CB - Usuario bloqueado?"                 ),"","","mv_ch04" ,"N", 1,0,0,"C","","","","","mv_par04","Nao","","","","Sim","","","","","","","","","","","","","","","","","","","","")
   PutSx1(cPerg,"05",OemToAnsi("Paga CM - Matr Caberj Em branco?"             ),"","","mv_ch05" ,"N", 1,0,0,"C","","","","","mv_par05","Nao","","","","Sim","","","","","","","","","","","","","","","","","","","","")
   PutSx1(cPerg,"06",OemToAnsi("Paga CD - Matr Caberj Dif MetLife?"           ),"","","mv_ch06" ,"N", 1,0,0,"C","","","","","mv_par06","Nao","","","","Sim","","","","","","","","","","","","","","","","","","","","")
   PutSx1(cPerg,"07",OemToAnsi("Paga V+ - MetLife MAIOR que Contratdo?"       ),"","","mv_ch07" ,"N", 1,0,0,"C","","","","","mv_par07","Nao","","","","Sim","","","","","","","","","","","","","","","","","","","","") 
   PutSx1(cPerg,"08",OemToAnsi("Paga V- - MetLife MENOR que Contratdo?"       ),"","","mv_ch08" ,"N", 1,0,0,"C","","","","","mv_par08","Nao","","","","Sim","","","","","","","","","","","","","","","","","","","","")
   PutSx1(cPerg,"09",OemToAnsi("Paga CI - Inclusao  posterior?"               ),"","","mv_ch09" ,"N", 1,0,0,"C","","","","","mv_par09","Nao","","","","Sim","","","","","","","","","","","","","","","","","","","","")
   PutSx1(cPerg,"10",OemToAnsi("Paga CF - Falta Param. Plano?"                ),"","","mv_ch10" ,"N", 1,0,0,"C","","","","","mv_par10","Nao","","","","Nใo","","","","","","","","","","","","","","","","","","","","")
   PutSx1(cPerg,"11",OemToAnsi("Paga CC - Sem registro Caberj?"               ),"","","mv_ch11" ,"N", 1,0,0,"C","","","","","mv_par11","Nao","","","","Nใo","","","","","","","","","","","","","","","","","","","","")
   PutSx1(cPerg,"12",OemToAnsi("Paga CR - Sem registro MetLife?"              ),"","","mv_ch12" ,"N", 1,0,0,"C","","","","","mv_par12","Nao","","","","Nใo","","","","","","","","","","","","","","","","","","","","")
   PutSx1(cPerg,"13",OemToAnsi("Paga C  - Importa็ใo Sem Critica?"            ),"","","mv_ch13" ,"N", 1,0,0,"C","","","","","mv_par13","Sim","","","","Nใo","","","","","","","","","","","","","","","","","","","","")
     

   Pergunte(cPerg,.T.)

Return() 


Static Function FGrvPlan()     

   cNomDadCab:=  '1 - Dados Analisados  ' + cNomEmp
   cComp     :=  cCompMes+'/'+cCompAno
   cNomPla   := 'Base Analisada '                 
 
     	cNomeArq := "C:\TEMP\"+cCompAno+cCompMes+" - "+cEmpresa+" - "+cNomDadCab+"_"+SubStr(DtoS(date()),7,2)+"_"+SubStr(DtoS(date()),5,2)+"_"+SubStr(DtoS(date()),1,4)+"_"+STRTRAN(TIME(),":","_")+".csv"
		nHandle := FCREATE(cNomeArq)
        cMontaTxt := cNomDadCab
        cMontaTxt += CRLF
        FWrite(nHandle,cMontaTxt)        		 
        cMontaTxt := 'Competencia : '+cComp
        cMontaTxt += CRLF
        FWrite(nHandle,cMontaTxt)		 
        cMontaTxt := 'Planilha : '+cNomPla  
        cMontaTxt += CRLF
        FWrite(nHandle,cMontaTxt)		      

        cMontaTxt := "Compte       ;" 
        cMontaTxt += "Matric.Odonto;" 
        cMontaTxt += "Matric.Compl ;" 
		cMontaTxt += "Nome         ;"      
		cMontaTxt += "Tp Usuario   ;"     
		cMontaTxt += "Plano        ;"  
		cMontaTxt += "Vlr Caberj   ;"   
		cMontaTxt += "Vlr Met Life ;" 
	    cMontaTxt += "Resultado    ;"      	       
		cMontaTxt += "Critica      ;"  
		cMontaTxt += "Desc. Critica ;"      
		
		cMontaTxt += CRLF // Salto de linha para .csv (excel)
             
		FWrite(nHandle,cMontaTxt)
		
      For nCount:=1 to len(aDadosCabj)
          cMontaTxt := trim(aDadosCabj[nCount][1]) + ";"		 
          cMontaTxt += trim(aDadosCabj[nCount][2]) + ";"		
          cMontaTxt += trim(aDadosCabj[nCount][11])+ ";"		 
          cMontaTxt += trim(aDadosCabj[nCount][5]) + ";"
          cMontaTxt += trim(aDadosCabj[nCount][6]) + ";"		          		          
          cMontaTxt += trim(aDadosCabj[nCount][7]) + ' - ' + trim(aDadosCabj[nCount][8]) + ";"  
   		  cMontaTxt += Transform(aDadosCabj[nCount][12],'@E  999,999,999.99')+ ";" 
          cMontaTxt += Transform(aDadosCabj[nCount][9],'@E  999,999,999.99')+ ";"     
   		  cMontaTxt += trim(aDadosCabj[nCount][13]) + ";"    
   		  cMontaTxt += trim(aDadosCabj[nCount][16]) + ";"     
   		  cMontaTxt += trim(aDadosCabj[nCount][17]) + ";"       		  
    
    	  cMontaTxt += CRLF // Salto de linha para .csv (excel)      
		      
		  FWrite(nHandle,cMontaTxt)
	
      Next 

	If nHandle > 0
		
		// encerra grava็ใo no arquivo
		FClose(nHandle)
		cNomeArq1+= cNomeArq + CRLF
	  //	MsgAlert("Relatorio salvo em: "+cNomeArq)
		
   
	    MsgAlert("Relatorio(s) salvo(s) em: "+ CRLF +cNomeArq1)

	EndIf                                 
	
	
   cNomDadCab:= ' 2 - Resumo da Conferencia ' + cNomEmp
   cComp     :=  cCompMes+'/'+cCompAno
   cNomPla   := ' BASE ANALISADA '                   
 
     	cNomeArq := "C:\TEMP\"+cCompAno+cCompMes+" - "+cEmpresa+" - "+cNomDadCab+"_"+SubStr(DtoS(date()),7,2)+"_"+SubStr(DtoS(date()),5,2)+"_"+SubStr(DtoS(date()),1,4)+"_"+STRTRAN(TIME(),":","_")+".csv"

		nHandle := FCREATE(cNomeArq)
        cMontaTxt := cNomDadCab
        cMontaTxt += CRLF
        FWrite(nHandle,cMontaTxt)       		 
        cMontaTxt := 'Competencia : '+cComp
        cMontaTxt += CRLF
        FWrite(nHandle,cMontaTxt)		 
        cMontaTxt := 'Planilha : '+cNomPla  
        cMontaTxt += CRLF
        FWrite(nHandle,cMontaTxt)	 

        cMontaTxt := "Cod. Empresa ;"
        cMontaTxt += "Cod Plano    ;"    
        cMontaTxt += "Status       ;"   
        cMontaTxt += "Critica      ;"  
		cMontaTxt += "Tp usuario   ;"   
		cMontaTxt += "Lanc D/C     ;"   
		cMontaTxt += "Valor        ;"
		cMontaTxt += "Qtda         ;"  		  		
                                                  
		
		cMontaTxt += CRLF // Salto de linha para .csv (excel)
             
		FWrite(nHandle,cMontaTxt)
		
      For nCount:=1 to len(aDadosCMF)
		                                    
   		  cMontaTxt := aDadosCMF[nCount][1] + ";"  
          cMontaTxt += aDadosCMF[nCount][2] + ";"   		   
          cMontaTxt += aDadosCMF[nCount][3] + ";"   		             
          cMontaTxt += aDadosCMF[nCount][4] + ";"   		                      
		  cMontaTxt += aDadosCMF[nCount][5] + ";"
		  cMontaTxt += aDadosCMF[nCount][6] + ";" 
		  cMontaTxt += Transform(aDadosCMF[nCount][7],'@E  999,999,999.99')+ ";"    
		  cMontaTxt += Transform(aDadosCMF[nCount][8],'@E  99,999')+ ";"   
		
		  cMontaTxt += CRLF // Salto de linha para .csv (excel)      
		      
		  FWrite(nHandle,cMontaTxt)
	
      Next 

	If nHandle > 0
		
		// encerra grava็ใo no arquivo
		FClose(nHandle)
		cNomeArq1+= cNomeArq + CRLF
		MsgAlert("Relatorio salvo em: "+cNomeArq)
		
	EndIf           
	    
   cNomDadCab:=  ' 3 - Resumo do Pagamento ' + cNomEmp
   cComp     :=  cCompMes+'/'+cCompAno
   cNomPla   := 'BASE ANALISADA '                   
 
     	cNomeArq := "C:\TEMP\"+cCompAno+cCompMes+" - "+cEmpresa+" - "+cNomDadCab+"_"+SubStr(DtoS(date()),7,2)+"_"+SubStr(DtoS(date()),5,2)+"_"+SubStr(DtoS(date()),1,4)+"_"+STRTRAN(TIME(),":","_")+".csv"

		nHandle := FCREATE(cNomeArq)
        cMontaTxt := cNomDadCab
        cMontaTxt += CRLF
        FWrite(nHandle,cMontaTxt)       		 
        cMontaTxt := 'Competencia : '+cComp
        cMontaTxt += CRLF
        FWrite(nHandle,cMontaTxt)		 
        cMontaTxt := 'Planilha : '+cNomPla  
        cMontaTxt += CRLF
        FWrite(nHandle,cMontaTxt)		
        
        cMontaTxt := "Cod. Empresa ;"
        cMontaTxt += "Cod Plano    ;"    
        cMontaTxt += "Status       ;"   
        cMontaTxt += "Critica      ;"  
		cMontaTxt += "Tp usuario   ;"   
		cMontaTxt += "Lanc D/C     ;"   
		cMontaTxt += "Valor        ;"
		cMontaTxt += "Qtda         ;"  		  		
                                                  
		
		cMontaTxt += CRLF // Salto de linha para .csv (excel)
             
		FWrite(nHandle,cMontaTxt)
		
      For nCount:=1 to len(aDadosCMF) 
      
       If !(aDadosCMF[nCount,3] $ cCritNsai)
		                                    
   		  cMontaTxt := aDadosCMF[nCount][1] + ";"  
          cMontaTxt += aDadosCMF[nCount][2] + ";"   		   
          cMontaTxt += aDadosCMF[nCount][3] + ";"   		             
          cMontaTxt += aDadosCMF[nCount][4] + ";"   		                      
		  cMontaTxt += aDadosCMF[nCount][5] + ";"
		  cMontaTxt += aDadosCMF[nCount][6] + ";" 
		  cMontaTxt += Transform(aDadosCMF[nCount][7],'@E  999,999,999.99')+ ";"    
		  cMontaTxt += Transform(aDadosCMF[nCount][8],'@E  99,999')+ ";"   
		
		  cMontaTxt += CRLF // Salto de linha para .csv (excel)      
		      
		  FWrite(nHandle,cMontaTxt)
		  
	   EndIf
	    
      Next 

	If nHandle > 0
		
		// encerra grava็ใo no arquivo
		FClose(nHandle)
		cNomeArq1+= cNomeArq + CRLF
		MsgAlert("Relatorio salvo em: "+cNomeArq)
		
	EndIf           

                    
   cNomDadCab:=  ' 4 - Resumo da  Base Caberj ' + cNomEmp 
   cComp     :=  cCompMes+'/'+cCompAno
   cNomPla   := 'BASE ANALISADA '                   
 
     	cNomeArq := "C:\TEMP\"+cCompAno+cCompMes+" - "+cEmpresa+" - "+cNomDadCab+"_"+SubStr(DtoS(date()),7,2)+"_"+SubStr(DtoS(date()),5,2)+"_"+SubStr(DtoS(date()),1,4)+"_"+STRTRAN(TIME(),":","_")+".csv"

		nHandle := FCREATE(cNomeArq)
        cMontaTxt := cNomDadCab
        cMontaTxt += CRLF
        FWrite(nHandle,cMontaTxt)       		 
        cMontaTxt := 'Competencia : '+cComp
        cMontaTxt += CRLF
        FWrite(nHandle,cMontaTxt)		 
        cMontaTxt := 'Planilha : '+cNomPla  
        cMontaTxt += CRLF
        FWrite(nHandle,cMontaTxt)		
        
        cMontaTxt := "Cod. Empresa ;" 
        cMontaTxt := "Nome da Empresa ;"
        cMontaTxt += "Cod  Plano    ;"     
        cMontaTxt += "Desc Plano    ;"            
        cMontaTxt += "Vlr Total     ;"   
        cMontaTxt += "C/S Mat Odonto;"  
		cMontaTxt += "Vlr Unit      ;"   
		cMontaTxt += "Qtda         ;"  		  		
                                                  
		
		cMontaTxt += CRLF // Salto de linha para .csv (excel)
             
		FWrite(nHandle,cMontaTxt)
		
      For nCount:=1 to len(aDadosECCB) 
                                       
   		  cMontaTxt := aDadosECCB[nCount][1] + ";"  
          cMontaTxt += aDadosECCB[nCount][2] + ";"   		   
          cMontaTxt += aDadosECCB[nCount][3] + ";"   		             
          cMontaTxt += aDadosECCB[nCount][4] + ";"   		                        
          cMontaTxt += Transform(aDadosECCB[nCount][5],'@E  9999,999.99')+ ";"    
		  cMontaTxt += aDadosECCB[nCount][6] + ";"  
		  cMontaTxt += Transform(aDadosECCB[nCount][7],'@E  999.99')+ ";"     
          cMontaTxt += Transform(aDadosECCB[nCount][8],'@E    9999')+ ";"    
		  cMontaTxt += CRLF // Salto de linha para .csv (excel)      
		      
		  FWrite(nHandle,cMontaTxt)
	    
      Next 

	If nHandle > 0
		
		// encerra grava็ใo no arquivo
		FClose(nHandle)
		cNomeArq1+= cNomeArq + CRLF
		MsgAlert("Relatorio salvo em: "+cNomeArq)
		
	EndIf           
             
Return ()    
///////

//////

Static Function FGrvBGQ(  cEmpresa , cPlano , cConf , cCritic , cTptip , cDebCred ,nValor, cAnoComp , cMesComp, cRDA  )     

LOCAL cRDAAud := cRDA 

		BBB->(MsSeek(xFilial("BBB")+ cDebCred ))

		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณ Necessario truncar casas decimais, lancando centavo no ultimo adic. ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู					
		BGQ->(Reclock("BGQ",.T.))	
		BGQ->BGQ_FILIAL	:= xFilial("BGQ") 
		BGQ->BGQ_CODSEQ	:= GETSX8NUM("BGQ","BGQ_CODSEQ")
		BGQ->BGQ_CODIGO	:= cRDAAud
		BGQ->BGQ_NOME	:= Posicione("BAU",1,xFilial("BAU")+cRDAAud,"BAU_NOME")
		BGQ->BGQ_ANO	:= cAnoComp
		BGQ->BGQ_MES	:= cMesComp
		BGQ->BGQ_CODLAN	:= cDebCred
		BGQ->BGQ_VALOR	:= nValor
		BGQ->BGQ_QTDCH	:= 0
		BGQ->BGQ_TIPO	:= "2" //Credito
		BGQ->BGQ_TIPOCT	:= "2" //PJ
		BGQ->BGQ_INCIR	:= BBB->BBB_INCIR
		BGQ->BGQ_INCINS	:= BBB->BBB_INCINS
		BGQ->BGQ_INCPIS	:= BBB->BBB_INCPIS
		BGQ->BGQ_INCCOF	:= BBB->BBB_INCCOF
		BGQ->BGQ_INCCSL	:= BBB->BBB_INCCSL
		BGQ->BGQ_VERBA	:= BBB->BBB_VERBA
		BGQ->BGQ_CODOPE	:= '0001'
		BGQ->BGQ_CONMFT	:= "0" //Nao
        if cRdaEmp == '145246'
		   BGQ->BGQ_OBS	:= "LANCTO PGTO ODONT Metlife - Ref: "+cAnoComp+cMesComp +" - " + cCritic
        Else 
           BGQ->BGQ_OBS	:= "LANCTO PGTO ODONT Prima Vida - Ref: "+cAnoComp+cMesComp +" - " + cCritic
        EndIf 
		BGQ->BGQ_USMES	:= 0
		BGQ->BGQ_LANAUT	:= "0" //Nao   
		
		BGQ->BGQ_ITECTA := cPlano   
        BGQ->BGQ_CLVL   := cEmpresa
        BGQ->BGQ_CODEMP := cEmpresa  

		BGQ->BGQ_YLTAUD	:=' '   		
		BGQ->(MsUnlock()) 
		ConfirmSx8()
				
return()                                        

Static Function fVerfBgq() 

   cQuery := "      Select BGQ_CODIGO , BGQ_ANO , BGQ_MES , BGQ_numlot FROM " + RetSqlName("BGQ") +  " BGQ" 
   cQuery += CRLF +" WHERE BGQ_FILIAL = '" + xFilial("BGQ") +"' AND D_E_L_E_T_ = ' '  "
  // cQuery += CRLF +"   AND BGQ_CODIGO = '145246' "
   cQuery += CRLF +"   AND BGQ_ANO	  = '"+cCompAno+"' "
   cQuery += CRLF +"   AND BGQ_MES	  = '"+cCompMes+"' "
   cQuery += CRLF +"   AND BGQ_CODIGO = '"+cRdaEmp+"' "
                   
If Select(("TMP")) <> 0 

   ("TMP")->(DbCloseArea()) 

Endif
    
    TCQuery cQuery Alias "TMP" New 
                                                                                           
If !EMPTY(tmp->BGQ_CODIGO) 
    lRet := .T.
    If  EMPTY(tmp->BGQ_numlot)
        lFaturado := .F.
    Else               
        lFaturado := .T.
    EndIf    
Else          
    lRet := .F.
EndIf      

return(lRet)                                        
/// 
Static Function fLimpbgq()                              

   cQuery :=       " DELETE " + RetSqlName("BGQ") +  " BGQ" 
   cQuery += CRLF +" WHERE BGQ_FILIAL = '" + xFilial("BGQ") +"' AND D_E_L_E_T_ = ' '  "
  // cQuery += CRLF +"   AND BGQ_CODIGO = '145246' "
   cQuery += CRLF +"   AND BGQ_ANO	  = '"+cCompAno+"' "
   cQuery += CRLF +"   AND BGQ_MES	  = '"+cCompMes+"' " 
   cQuery += CRLF +"   AND BGQ_CODIGO = '"+cRdaEmp+"' "
   cQuery += CRLF +"   AND Trim(BGQ_numlot) is null  "
   

    nSucesso += TcSqlExec(cQuery)	
    
return(lRet)                                        

