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
User Function CABR224a( cAno , cMes , aDadosCMF  ,aDaECMF ,cCritNsai,LFazpag , f_ok , lBgq1 , lFat , aDadosECCB , cRdaEmp)   

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
Private nomeprog     := "CABR224A"                                             
Private nTipo        := 15
Private aReturn      := { "Zebrado", 1, "Administracao", 1, 2, 1, "", 1}
Private nLastKey     := 0
Private cbtxt        := Space(10)
Private cbcont       := 00
Private CONTFL       := 01
Private m_pag        := 01
Private wnrel        := "CABR224"
Private cString      := "BM1"
Private cPerg        := "CABR224a  "
Private valor_tot    := 0.00  
Private valor_col    := 0.00                                                                      
Private cquebra      := " "        
Private cttitpgto    :=' '   
private cqtdavend    := 0 
private ctraco80     := replicate("_",080)  
Private lflagtot     :=.F.  
PRIVATE cEmpresa     :=  Iif(cempant == '01','Caberj','Integral') 

Private cQuery       := " "   

private lbgq         := lBgq1

private cRdaEmp      := cRdaEmp

PRIVATE cNomEmp      := iif(cRdaEmp=='145246', 'Met Life', 'Prima Vida')
//Private aVlmetlif    :=ametlife    

Private nTotVlEMet   :=  0    
Private nTotQtdEMet  :=  0     

private lFat1:= lFat


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
titulo         := "        Repasse - " + cNomEmp 
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

local nTotVCabc := 0  
local nTotQtdac := 0

local nTotVlMet  :=  0    
local nTotQtdMet :=  0



dbSelectArea(cString)
dbSetOrder(1)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ SETREGUA -> Indica quantos registros serao processados para a regua ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

SetRegua(RecCount())                    

    
  If nLin > 60 // Salto de Pแgina. Neste caso o formulario tem 55 linhas...
       nLin :=	Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
       nLin ++            		
    EndIf         		
  
    
    @ nLin,001 PSAY "               H I S T ำ R I C O    D E    P A G A M E N T O  "            
      nlin++   
    @ nLin,001 PSAY ctraco80
      nlin++  
    @ nLin,001 PSAY " Confer๊ncia do pagamento  a "+cNomEmp +" da compet๊ncia : " +  cMesAno1                
	  nlin++            
    @ nLin,001 PSAY ctraco80    
   		
      nlin++    
    @ nLin,001 PSAY "                    Base da Empresa : "+ cEmpresa  
      nlin++  
    @ nLin,001 PSAY ctraco80   
      nlin++                                                                               
    @ nLin,000 PSAY "Empresa              Plano              Status            Vlr Total    Valor Qtda"    
   //                01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
    //                         1         2         3         4         5         6         7         8         9
    @ nLin,001 PSAY ctraco80                                                                                        
    

      nlin++
   
    For I:= 1 to len(aDadosECCB)       


           cEmpresas := aDadosECCB[I,1]+' - '+substr(Posicione("BG9",1,xFilial("BG9")+'0001'+aDadosECCB[I,1],"BG9_DESCRI"),1,13)
           cPlano    := aDadosECCB[I,3]+' - '+substr(aDadosECCB[I,4],1,11)              
           cCritica  := substr(aDadosECCB[I,6],1,17)           
           nValorT   := Transform(aDadosECCB[I,5],"@E  99,999.99")             
           nValoru   := Transform(aDadosECCB[I,7],"@E     999.99")            
           nqtda     := Transform(aDadosECCB[I,8],"@R       9999") 
           
    @ nLin,000 PSAY cEmpresas    
    @ nLin,021 PSAY cplano 
    @ nLin,040 PSAY cCritica 
    @ nLin,058 PSAY nValort  
    @ nLin,070 PSAY nValoru 
    @ nLin,077 PSAY nQTDA 
    
      nTotVCabc += aDadosECCB[I,5]  
      nTotQtdac += aDadosECCB[I,8]  
           
  	  nlin++    
        
       If nLin > 55 // Salto de Pแgina. Neste caso o formulario tem 55 linhas...  

          @ nLin,001 PSAY ctraco80  
           nlin++                                                                                      
          @ nLin,021 PSAY 'Continua . . . '     
        
          nLin :=	Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
          nLin ++            		
       EndIf         		  
    
    Next      

          
    @ nLin,001 PSAY ctraco80              
      nlin++   
    @ nLin,030 PSAY 'Total  -->'
    @ nLin,045 PSAY Transform(nTotVCabc,"@E  9999,999.99")  
    @ nLin,075 PSAY Transform(nTotQtdac,"@E         9999")     


      nlin++            
    @ nLin,001 PSAY ctraco80             
      nlin++    
    @ nLin,001 PSAY "            Considerados para Pagamento e Conferido da "+ cEmpresa              
      nlin++                                                                                               
    @ nLin,001 PSAY ctraco80   
      nlin++                                                                               
    @ nLin,000 PSAY "Empresa              Plano              Status               Tit/Dep   Valor Qtda"            
          
    //               01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
    //                         1         2         3         4         5         6         7         8         9
      nlin++                                                                                   
    @ nLin,001 PSAY ctraco80                                                                                        
      nlin++
   
    For I:= 1 to len(aDadosCMF)       

        If !(aDadosCMF[I,3] $ cCritNsai)

           cEmpresas := aDadosCMF[I,1]+' - '+substr(Posicione("BG9",1,xFilial("BG9")+'0001'+aDadosCMF[I,1],"BG9_DESCRI"),1,13)
           cPlano    := aDadosCMF[I,2]+' - '+substr(aDadosCMF[I,9],1,11)              
           cCritica  := substr(aDadosCMF[I,4],1,20)           
           cTitDep   := Substr(aDadosCMF[I,5],1,3)
           nValor    := Transform(aDadosCMF[I,7],"@E  99,999.99")            
           nqtda     := Transform(aDadosCMF[I,8],"@R        9999") 
           
 
    @ nLin,000 PSAY cEmpresas     
    @ nLin,021 PSAY cplano  
    @ nLin,040 PSAY cCritica 
    @ nLin,063 PSAY cTitDep    
    @ nLin,067 PSAY nValor  
    @ nLin,077 PSAY nQTDA  
    
      nTotVCob += aDadosCMF[I,7]  
      nTotQtda += aDadosCMF[I,8]  
           
  	  nlin++

        EndIf     
        
       If nLin > 55 // Salto de Pแgina. Neste caso o formulario tem 55 linhas...
          
          @ nLin,001 PSAY ctraco80  
           nlin++                                                                                      
          @ nLin,021 PSAY 'Continua . . . '     

          nLin :=	Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
          nLin ++                                                                         
                    		
       EndIf         		  
    
    Next      

          
    @ nLin,001 PSAY ctraco80              
      nlin++   
    @ nLin,030 PSAY 'Total do Pagamento -->' 
    @ nLin,060 PSAY Transform(nTotVCob,"@E  9999,999.99")  
    @ nLin,075 PSAY Transform(nTotQtda,"@E         9999")     
    
      nlin++            
    @ nLin,001 PSAY ctraco80             
      nlin++   
    @ nLin,001 PSAY "                              Resumo da Confer๊ncia  "   
      nlin++            
    @ nLin,001 PSAY ctraco80             
    @ nLin,000 PSAY "Plano                 Crํtica                                          Valor Qtda"                 
    //               01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
    //                         1         2         3         4         5         6         7         8         9
    @ nLin,001 PSAY ctraco80                                                                                        
       
    For x:= 1 to len(aDaECMF)     

  	  nlin++     
    
     @ nLin,000 PSAY aDaECMF[x,1] +' - '+ substr(aDaECMF[x,6],1,11)  
     @ nLin,021 PSAY aDaECMF[x,2] +' - '+ aDaECMF[x,3]                                  
     @ nLin,067 PSAY Transform(aDaECMF[x,4],"@E 999,999.99") 
     @ nLin,076 PSAY Transform(aDaECMF[x,5],"@R 9,999")          
  	  
  	  nTotVlMet  +=  aDaECMF[x,4]    
      nTotQtdMet +=  aDaECMF[x,5]  
      
      If nLin > 55 // Salto de Pแgina. Neste caso o formulario tem 55 linhas...       
          @ nLin,001 PSAY ctraco80  
           nlin++                                                                                      
          @ nLin,021 PSAY 'Continua . . . '     

          nLin :=	Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
          nLin ++            		
       EndIf         		  

      
    Next                                                                                                                                                                                                  

  	  nlin++

    @ nLin,001 PSAY ctraco80              
      nlin++   
    @ nLin,030 PSAY 'Totais -->'
    @ nLin,042 PSAY Transform(nTotVlMet ,"@E  9,999,999.99") 
    @ nLin,076 PSAY Transform(nTotQtdMet,"@R 9,999")          
      nlin++            
    @ nLin,001 PSAY ctraco80 
    
    
    If nLin > 45 // Salto de Pแgina. Neste caso o formulario tem 55 linhas...  

       @ nLin,001 PSAY ctraco80  
         nlin++                                                                                      
       @ nLin,021 PSAY 'Continua . . . '     
        
       nLin :=	Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
       nLin ++            		
    EndIf                
    
       
    If f_ok   .and. LFazpag   
                
      nlin++  
      nlin++  
      nlin++        
    @ nLin,028 PSAY " A U T O R I Z A ว ี E S "  
	  nlin++                    
      nlin++  	  
    @ nLin,002 PSAY "             Autorizo o pagamento a "+cNomEmp+" do valor de R$" + Transform(nTotVCob ,"@E  9,999,999.99")   
      nlin++            
      nlin++ 
    @ nLin,015 PSAY "ODONTOLOGIA " 
    @ nLin,034 PSAY "D I C O M "           
    @ nLin,055 PSAY "D I M E D "  
	  nlin++          
      nlin++            
      nlin++            
    @ nLin,013 PSAY "_____________"      
    @ nLin,032 PSAY "_____________"
    @ nLin,053 PSAY "_____________"  
      nlin++                           
      
      If nLin > 45 // Salto de Pแgina. Neste caso o formulario tem 55 linhas...  
    
         @ nLin,001 PSAY ctraco80  
           nlin++                                                                                      
         @ nLin,021 PSAY 'Continua . . . '     
        
           nLin :=	Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
          nLin ++            		
      EndIf     
                     
      If nTotVCob  <> nTotVCabc    
    
         @ nLin,001 PSAY ctraco80        
           nlin++  
         @ nLin,002 PSAY " * Diferen็a apurado entre o Valor "+cNomEmp+" " + Transform((nTotVCob) ,"@E  9,999,999.99")
           nlin++  
         @ nLin,002 PSAY "                             Valor "+cEmpresa+" " + Transform((nTotVCabc) ,"@E  9,999,999.99")        
           nlin++                                                                                                                                                                              
         @ nLin,001 PSAY ctraco80       
      
      EndIf                       
      
       nlin++  
     @ nLin,002 PSAY " ** Informa็๕es para gerar o lote , Valor do Pagto"+ Transform((nTotVCob) ,"@E  9,999,999.99")
       nlin++  
     @ nLin,002 PSAY "    , Rda  "+cRdaEmp+" , Competencia "+cAnoMes                 

   If lFat1                   
      nlin++  
    @ nLin,002 PSAY " * Pagamento Jแ realizado , Nใo ้ vแlido para Pagamemento"        
      nlin++                        
    @ nLin,001 PSAY ctraco80 
   elseIf lbgq
         nlin++  
       @ nLin,002 PSAY " * Op็ใo de Fechamento Jแ Realizada anteriormente  , Nใo ้ vแlido para Pagamemento"        
         nlin++                        
       @ nLin,001 PSAY ctraco80 
    EndIf 
 Else   
      nlin++  
    @ nLin,002 PSAY " * Op็ใo de Fechamento NรO foi selecionada , Nใo ้ vแlido para Pagamemento"        
      nlin++                        
    @ nLin,001 PSAY ctraco80        

 EndIf

/*
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
     @ nLin,037 PSAY aDadosECMF[x,3]                                  
     @ nLin,060 PSAY Transform(aDadosECMF[x,4],"@E 9,999,999.99") 
     @ nLin,075 PSAY Transform(aDadosECMF[x,5],"@R 9,999")          
       nlin++     
   	  
  	   nTotVlEMet  +=  aDadosECMF[x,4]    
       nTotQtdEMet +=  aDadosECMF[x,5]
    Next                                                                                                                                                                                                    
 
    @ nLin,001 PSAY ctraco80              
      nlin++   
    @ nLin,030 PSAY 'Totais -->'                                  
    @ nLin,060 PSAY Transform(nTotVlEMet,"@E 9,999,999.99") 
    @ nLin,075 PSAY Transform(nTotQtdEMet,"@R 9,999")          
      nlin++            
    @ nLin,001 PSAY ctraco80              
  
 */
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

aAdd(aRegs,{cPerg,"01","Mes/Ano Respase?","","","mv_ch1","C",07,0,0,"G","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "99/9999", "" })
aAdd(aRegs,{cPerg,"02","Arquivo Met Life","","","mv_ch2","C",060,0,0,"G","U_fGetFile('csv     (*.csv)            | *.csv | ')","","","","mv_par02","","","","","","","","","","","","","","","","",aHelpPor,{},{}})
aadd(aRegs,{cPerg,"03","Listar Met Life Analitico?","","","mv_ch3","N", 1,0,0,"C","","mv_par03","Sim","","","","","Nao","","","","","","","","","","","","","","","","","","","",""})
/*aAdd(aRegs,{cPerg,"02","Cod Empresa De ?","","","mv_ch2","C",04,0,0,"G","","mv_par02","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "", "" }) 
/*  aAdd(aRegs,{cPerg,"03","Cod Empresa Ate?","","","mv_ch3","C",04,0,0,"G","","mv_par03","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "", "" })
  aAdd(aRegs,{cPerg,"04","Vendedor De    ?","","","mv_ch4","C",06,0,0,"G","","mv_par04","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "", "" }) 
  aAdd(aRegs,{cPerg,"05","Vendedor Ate   ?","","","mv_ch5","C",06,0,0,"G","","mv_par05","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "", "" })
//aadd(aRegs,{cPerg,"11","Bloqueados ?     ","","","mv_cha","N", 1,0,0,"C","","mv_par11","Sim","","","","","Nao","","","","","Ambos","","","","","","","","","","","","","",""      ,""})
*/
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
