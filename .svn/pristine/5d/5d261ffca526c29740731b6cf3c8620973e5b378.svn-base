#Define CRLF Chr(13)+Chr(10)
#INCLUDE "rwmake.ch"
#include "PROTHEUS.CH"
#include "TOPCONN.CH"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ CABR224  บ Autor ณ Altamiro Affonso   บ Data ณ  10/06/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Relatorio de Aprova็ใo de pagamento Primavida              บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP6 IDE                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
User Function CABR224B( cano , cmes , ametlife  , aDadosECMF, nEfetConv , f_ok )  

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Declaracao de Variaveis                                             ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

Local cDesc1         := "Este programa tem como objetivo imprimir relatorio "
Local cDesc2         := "de Aprova็ใo de pagamento da METLIFE              "
Local cDesc3         := "                                                   "
Local cPict          := ""
Local titulo         := "        Repasse METLIFE      "

Local Cabec1         := "  " //Codigo     Descri็ใo                                            Saldo"
//                       12345678901234567890123456789012345678901234567890123456789001234567890
//                       0        1         2         3         4         5         6          7
//                          XXX       XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX   999.999.999,99 
//                      BK2_PROPRI||BK2_CODLAN,                                    Sum(BK2_SALDO) 
Local Cabec2         := " "
Local imprime        := .T.
Local aOrd           := {}
Private nLin         := 220  
Private lEnd         := .F.
Private lAbortPrint  := .F.
Private CbTxt        := ""
Private limite       := 100
Private tamanho      := "P"
Private nomeprog     := "CABR224b"                                             
Private nTipo        := 15
Private aReturn      := { "Zebrado", 1, "Administracao", 1, 2, 1, "", 1}
Private nLastKey     := 0
Private cbtxt        := Space(10)
Private cbcont       := 00
Private CONTFL       := 01
Private m_pag        := 01
Private wnrel        := "CABR224"
Private cString      := "BM1"
Private cPerg        := "CABR224b  "
Private valor_tot    := 0.00  
Private valor_col    := 0.00                                                                      
Private cquebra      := " "        
Private cttitpgto    :=' '   
private cqtdavend    := 0 
private ctraco80     := replicate("_",080)  
Private lflagtot     :=.F.

Private cQuery       := " "  

Private aVlmetlif    :=ametlife    

Private nTotVlEMet   :=  0    
Private nTotQtdEMet  :=  0

Private nEfetConv := 1 
       



/*

ValidPerg(cPerg)
If Pergunte(cPerg,.T.) = .F.
	Return
Endif                                     

*/




Private cAnoMes      := cano + cmes    //substr(mv_par01,4,4)+substr(mv_par01,1,2)      
Private cMesAno1     := cmes +'/'+cano //substr(mv_par01,1,2)+'/'+substr(mv_par01,4,4) 
Private cMes1        := cmes           //substr(mv_par01,1,2)+'/'+substr(mv_par01,4,4)
Private cAno1        := cano //substr(mv_par01,1,2)+'/'+substr(mv_par01,4,4)
/* 

Private cAnoMesa      := str(iif(cmes==01,cano-1, cano),4)+strzero(iif(cmes==01,12,(cmes-1)),2) */

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Monta a interface padrao com o usuario...                           ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

wnrel := SetPrint(cString,NomeProg,"",@titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,.F.,Tamanho,,.T.)

If nLastKey == 27
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
	Return
Endif

nTipo := If(aReturn[4]==1,15,18)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Processamento. RPTSTATUS monta janela com a regua de processamento. ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

RptStatus({|| RunReport(Cabec1,Cabec2,Titulo,nLin) },Titulo)
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuno    ณRUNREPORT บ Autor ณ AP6 IDE            บ Data ณ  31/08/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescrio ณ Funcao auxiliar chamada pela RPTSTATUS. A funcao RPTSTATUS บฑฑ
ฑฑบ          ณ monta a janela com a regua de processamento.               บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Programa principal                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/

Static Function RunReport(Cabec1,Cabec2,Titulo,nLin)

Local nOrdem
Local cQuery := ' '        

local nTotVCob := 0
local nTotVMet := 0
local nTotQtda := 0     

local nTotVlMet  :=  0    
local nTotQtdMet :=  0



dbSelectArea(cString)
dbSetOrder(1)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ SETREGUA -> Indica quantos registros serao processados para a regua ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

SetRegua(RecCount())                    

// --resumo Pgto    

cQuery :=       " SELECT BM1_ANO || BM1_MES COMPET,         "
cQuery += CRLF +"        BM1_CODEVE codpla ,  BM1_DESEVE plan ,	"
cQuery += CRLF +"        DECODE(trim(BM1_DTCPR),null ,'Nใo Conf', 'Conferido') ESTATUS ,"
                      
cQuery += CRLF +"        SUM(BM1_VALOR)  VALOR_COBRADO,  "
cQuery += CRLF +"        SUM(BM1_YVLPRI) VALOR_METLIFE, "
cQuery += CRLF +"        SUM(BM1_YVLPR1) RENTABILIDAE, "
cQuery += CRLF +"        COUNT(*) QTDA , "
cQuery += CRLF +"        SUM(BM1_YVLPRI) / COUNT(*)  vlor_metlife "
                      
cQuery += CRLF +"   FROM  " + RetSqlName("BM1") + " BM1  where  bm1_filial = ' ' and D_E_L_E_T_ = ' '  "

cQuery += CRLF +"    AND BM1_XISODO = '1'  and BM1_CODTIP = '101' "
/*   
If cEmpAnt == '01'
   cQuery += CRLF +"    and bm1_CODEVE IN ('0131' ,'0133','0134') " 
Else    
   cQuery += CRLF +"    and bm1_CODEVE IN ('0088' ,'0090','0091','0092') "
EndIf     
*/
cQuery += CRLF +"    AND BM1_MES    = '"+ cMes1 +"' "
cQuery += CRLF +"    AND BM1_ANO    = '"+ cAno1 +"'"     
cQuery += CRLF +"    GROUP BY BM1_ANO , BM1_MES , "
cQuery += CRLF +"    BM1_CODEVE , BM1_DESEVE , BM1_DTCPR "
cQuery += CRLF +"    order by 2,3  "
                      


If Select(("TMP")) <> 0 

          ("TMP")->(DbCloseArea()) 

Endif
    
TCQuery cQuery Alias "TMP" New 
                                                                                           
dbSelectArea("TMP")
   
    tmp->(dbGoTop())    
    
    If nLin > 60 // Salto de Pแgina. Neste caso o formulario tem 55 linhas...
       nLin :=	Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
       nLin ++            		
    EndIf         		
    
    
    @ nLin,001 PSAY "               H I S T O R I C O    D E    P A G A M E N T O  "            
      nlin++   
    @ nLin,001 PSAY ctraco80
      nlin++  
    @ nLin,001 PSAY " Conferencia do pagamento  a METLIFE da compet๊ncia : " +  cMesAno1                
	  nlin++            
    @ nLin,001 PSAY ctraco80   
     nlin++    
     @ nLin,001 PSAY "                              Base Caberj/Integral"   
      nlin++                                                                               
    @ nLin,001 PSAY " Plano                        Status       Vlr Faturado    Vlr Devido      Qtda"                 
    //               1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
    //                         1         2         3         4         5         6         7         8         9
    @ nLin,001 PSAY ctraco80                                                                                        
    

      nlin++
   
    While !(TMP->(Eof()))                                                                                                                                                                                                   

  
    @ nLin,001 PSAY TMP->plan 
  
    @ nLin,030 PSAY TMP->ESTATUS
    @ nLin,045 PSAY Transform(TMP->VALOR_COBRADO,"@E  9,999,999.99") 
    @ nLin,059 PSAY Transform(TMP->VALOR_METLIFE,"@E  9,999,999.99") 
    @ nLin,076 PSAY Transform(TMP->QTDA,"@R 9,999") 
    
      nTotVCob += TMP->VALOR_COBRADO
      nTotVMet += TMP->VALOR_METLIFE
      nTotQtda += TMP->QTDA
           
  	  nlin++             
  	  nlin++

         tmp->(DbSkip())
   EndDo

          
    @ nLin,001 PSAY ctraco80              
      nlin++   
    @ nLin,030 PSAY 'Totais -->'
    @ nLin,045 PSAY Transform(nTotVCob,"@E  9,999,999.99") 
    @ nLin,059 PSAY Transform(nTotVMet,"@E  9,999,999.99") 
    @ nLin,076 PSAY Transform(nTotQtda,"@R 9,999") 
      nlin++            
    @ nLin,001 PSAY ctraco80             
    
      nlin++ 
      nlin++
      nlin++   
     @ nLin,001 PSAY "                              Base METLIFE "   
      nlin++                                                                        
    @ nLin,001 PSAY " Plano                       Categoria          Valor                      Qtda"                 
    //               1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
    //                         1         2         3         4         5         6         7         8         9
    @ nLin,001 PSAY ctraco80                                                                                        
    
      nlin++
   
    For x:= 1 to len(aVlmetlif) 
    
     @ nLin,001 PSAY aVlmetlif[x,2] 
     @ nLin,030 PSAY aVlmetlif[x,1]                                  
     @ nLin,042 PSAY Transform(aVlmetlif[x,4],"@E 9,999,999.99") 
     @ nLin,074 PSAY Transform(aVlmetlif[x,5],"@R 9,999")          
  	  nlin++     
  	  
  	  nTotVlMet  +=  aVlmetlif[x,4]    
      nTotQtdMet +=  aVlmetlif[x,5]
    Next                                                                                                                                                                                                  

  	  nlin++

    @ nLin,001 PSAY ctraco80              
      nlin++   
    @ nLin,030 PSAY 'Totais -->'
    @ nLin,042 PSAY Transform(nTotVlMet ,"@E  9,999,999.99") 
    @ nLin,075 PSAY Transform(nTotQtdMet,"@R 9,999")          
      nlin++            
    @ nLin,001 PSAY ctraco80              
    
    
  If nEfetConv == 1 .or. !f_ok 
    // Autoriza็๕es        	
       
      nlin++  
      nlin++        
    @ nLin,028 PSAY " A U T O R I Z A ว ี E S "  
	  nlin++                    
      nlin++  
      nlin++  	  
    @ nLin,002 PSAY "             Autorizo o pagamento a METLIFE do valor de R$" + Transform(nTotVlMet ,"@E  9,999,999.99")   
      nlin++            
      nlin++            
     
    @ nLin,015 PSAY "ODONTOLOGIA "       
    @ nLin,055 PSAY "D A P R E V"  
	  nlin++          
      nlin++            
      nlin++            
    @ nLin,013 PSAY "_____________"  
    @ nLin,053 PSAY "_____________"  

	  nlin++          
      nlin++            
      nlin++            
   If nTotVlMet   <> nTotVMet     
   
    @ nLin,001 PSAY ctraco80        
      nlin++  
    @ nLin,002 PSAY " * Diferen็a a ser ajustado na pr๓xima Fatura -->"  + Transform((nTotVlMet - nTotVMet) ,"@E  9,999,999.99")        
      nlin++                        
    @ nLin,001 PSAY ctraco80        
      
   EndIf             
 Else                    
      nlin++  
    @ nLin,002 PSAY " * Opc็ao de Fechamento NรO foi selecionada , Nใo e valido para Pagamemento"        
      nlin++                        
    @ nLin,001 PSAY ctraco80        

 EndIf
                    
   nLin    :=	99 
   titulo  := "   Repasse METLIFE - Rela็ใo por Empresa Plano  - METLIFE       " 
   Cabec1  := " Cod Emp           Plano            Categoria                      Valor    Qtda"                 
    //         1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
    //                  1         2         3         4         5         6         7         8         9

    For x:= 1 to len(aDadosECMF)
    
      If nLin > 60 // Salto de Pแgina. Neste caso o formulario tem 55 linhas...
         nLin :=	Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
         nLin ++            		
      EndIf         		 
    
     @ nLin,001 PSAY aDadosECMF[x,1] 
     @ nLin,016 PSAY aDadosECMF[x,2]                                   
     @ nLin,037 PSAY aDadosECMF[x,4]                                  
     @ nLin,060 PSAY Transform(aDadosECMF[x,5],"@E 9,999,999.99") 
     @ nLin,075 PSAY Transform(aDadosECMF[x,6],"@R 9,999")          
       nlin++     
   	  
  	   nTotVlEMet  +=  aDadosECMF[x,5]    
       nTotQtdEMet +=  aDadosECMF[x,6]
    Next                                                                                                                                                                                                    
 
    @ nLin,001 PSAY ctraco80              
      nlin++   
    @ nLin,030 PSAY 'Totais -->'                                  
    @ nLin,060 PSAY Transform(nTotVlEMet,"@E 9,999,999.99") 
    @ nLin,075 PSAY Transform(nTotQtdEMet,"@R 9,999")          
      nlin++            
    @ nLin,001 PSAY ctraco80              
  

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Finaliza a execucao do relatorio...                                 ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู


SET DEVICE TO SCREEN

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Se impressao em disco, chama o gerenciador de impressao...          ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

If aReturn[5]==1
	dbCommitAll()
	SET PRINTER TO
	OurSpool(wnrel)
Endif

MS_FLUSH()

Return      

                                                                                                                                                                                                                                

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณValidPerg บ Autor ณ Jose Carlos Noronhaบ Data ณ 01/08/07    บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Parametros para selecao dos titulos do PLS                 บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ                                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static Function ValidPerg()

Local aAreaAtu := GetArea()
Local aRegs    := {}
Local i,j

DbSelectArea("SX1")
dbSetOrder(1)
cPerg := PADR(cPerg,10)

aAdd(aRegs,{cPerg,"01","Mes/Ano Competencia?","","","mv_ch1","C",07,0,0,"G","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "99/9999", "" })
			  
aadd(aRegs,{cPerg,"02","Paga CP - Plano Diferente?"                   ,"","","mv_ch2" ,"N", 1,0,0,"C","","mv_par03","Nao","","","","","Sim","","","","","","","","","","","","","","","","","","","",""})
aadd(aRegs,{cPerg,"03","Paga CB - Usuario bloqueado?"                 ,"","","mv_ch3" ,"N", 1,0,0,"C","","mv_par03","Nao","","","","","Sim","","","","","","","","","","","","","","","","","","","",""})
aadd(aRegs,{cPerg,"04","Paga CM - Matr Caberj na MetLife Em branco?"  ,"","","mv_ch4" ,"N", 1,0,0,"C","","mv_par03","Nao","","","","","Sim","","","","","","","","","","","","","","","","","","","",""})
aadd(aRegs,{cPerg,"05","Paga CD - Matr Caberj diferente da MetLife?"  ,"","","mv_ch5" ,"N", 1,0,0,"C","","mv_par03","Nao","","","","","Sim","","","","","","","","","","","","","","","","","","","",""})
aadd(aRegs,{cPerg,"06","Paga CV - Valor Caberj diferente da MetLife?" ,"","","mv_ch6" ,"N", 1,0,0,"C","","mv_par03","Nao","","","","","Sim","","","","","","","","","","","","","","","","","","","",""})
aadd(aRegs,{cPerg,"07","Paga CI - Inclui็ใo posteria a Paremetrizada?","","","mv_ch7" ,"N", 1,0,0,"C","","mv_par03","Nao","","","","","Sim","","","","","","","","","","","","","","","","","","","",""})
aadd(aRegs,{cPerg,"08","Paga CP - Falta Parametrizar de Plano?"       ,"","","mv_ch8" ,"N", 1,0,0,"C","","mv_par03","Nao","","","","","Sim","","","","","","","","","","","","","","","","","","","",""})
aadd(aRegs,{cPerg,"09","Paga CC - Sem registro Caberj?"               ,"","","mv_ch9" ,"N", 1,0,0,"C","","mv_par03","Nao","","","","","Sim","","","","","","","","","","","","","","","","","","","",""})
aadd(aRegs,{cPerg,"10","Paga CR - Sem registro MetLife?"              ,"","","mv_ch10","N", 1,0,0,"C","","mv_par03","Nao","","","","","Sim","","","","","","","","","","","","","","","","","","","",""})
aadd(aRegs,{cPerg,"11","Paga C  - Importa็ใo Sem Critica?"            ,"","","mv_ch11","N", 1,0,0,"C","","mv_par03","Nao","","","","","Sim","","","","","","","","","","","","","","","","","","","",""})

For i:=1 to Len(aRegs)
	If !dbSeek(cPerg+aRegs[i,2])
		RecLock("SX1",.T.)
		For j:=1 to FCount()
			If j <= Len(aRegs[i])
				FieldPut(j,aRegs[i,j])
			Endif
		Next
		MsUnlock()
	Endif
Next

RestArea( aAreaAtu )

Return(.T.)
