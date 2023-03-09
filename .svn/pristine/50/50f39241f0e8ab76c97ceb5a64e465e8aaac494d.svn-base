#Define CRLF Chr(13)+Chr(10)
#INCLUDE "PROTHEUS.ch"                                                                                                                                  
#INCLUDE "TOPCONN.ch"
#INCLUDE "PLSMGER.CH"                                                                                                             
#Include "Ap5Mail.Ch"      
#Include 'Tbiconn.ch'                                                                         
/*--------------------------------------------------------------------------
| Programa  | CABA242a  | Autor | Altamiro	Affonso    | Data | 21/06/2013  |
|---------------------------------------------------------------------------|                  
| Descricao | Faturamento de convenios antecipado                           |
|           |                                                               |                                                       
|---------------------------------------------------------------------------|
| Uso       | Faturamento de convenios antecipado   - browser de seleção    |                                   
 --------------------------------------------------------------------------*/

User Function CABA242a(adados1)
                                                 
local cRda      := ' ' 
local cNivel    := ' '
local nI := 0  
 
 
Private aBrwPEG1  :=  adados1  
//                        1     30      8               7         10     11                28          29          27         13           14         12          31     32       33
Private aCabPEG1		:= { " ","Critica","Usuario " ,"Dt Proced" ,"Rda ","Procedimento "  ,"Vl B Ant","Vl Tx Ant","Vl T Ant","Vl B Atu ","Vl Tx Atu","Vl T Atu ","DifB ","DifT  ","DifTOT"}
Private aTamPEG1		:= { 10, 25       ,40         ,15          ,40    ,40               ,35         , 35       ,35         ,35         ,35         ,35         ,35    ,35       ,35     }


/*
private aBrwPEG
Private aCabPEG		:= {" ", "Compt. Entrada","Operadora de  Origem  ","Vlr Fase 3","Vlr Fase 31/2","Vlr Fase 4","Vlr Inss","Vlr Tx Adm", "Vlr Guias" , "Total Guias","Faturado","Qtda Guias"}
Private aTamPEG		:= {10,30,120,45,45,45,45,45,45,45,25}  
*/

Private oOk      	:= LoadBitMap(GetResources(),"LBOK")
Private oNo      	:= LoadBitMap(GetResources(),"LBNO")


Private aObjects 	:= {}

Private aSizeAut 	:= MsAdvSize() 

Private cPerg	    := "CABA242A"     
Private cPerga	    := "CABA242A"   

Private dVencInc                      
Private dVencFim                     
Private cTipotit                     
Private cTipbaixa    

Private cUsuario:= SubStr(cUSUARIO,7,15)        
//private cDthr   := STR(dtos(DATE()) + "-" + Time())   

private cCompInc := ' '                     
private cCompFim := ' '  

private nfase3    := 0                   
private nfase312  := 0                  
private nfase4    := 0        
private nGerpes   := 3

private cClsRd   := ' ' 

private dDtvenc  := ' '  

Private cDscori  := ' '      

private lsair := .F.    

private cAliasCf  := GetNextAlias()   
private cAliasDem := GetNextAlias()   
private cAliasCT  := GetNextAlias()    
private cAliasEX  := GetNextAlias()   
//AjustaSX1()

//Pergunte(cPerg,.T.)        

//cCompInc := Mv_par01                     
//cCompFim := Mv_par02  
                         
//while !lSai 
//Processa({||aBrwPEG := aDadosPEG()},'Processando...','Processando...',.T.)
                                  
 
 

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
lAjustVert 	:= .F.

aAdd( aObjects, { 130,  260, lAjustHor, lAjustVert } )
//aAdd( aObjects, { 130,  250, lAjustHor, lAjustVert } )
//aAdd( aObjects, { 130,  250, lAjustHor, lAjustVert } )

nSepHoriz   := 5   
nSepVert    := 5
nSepBorHor 	:= 5
nSepBorVert	:= 5

aInfo  		:= { aSizeAut[ 1 ], aSizeAut[ 2 ], aSizeAut[ 3 ], aSizeAut[ 4 ], nSepHoriz, nSepVert, nSepBorHor, nSepBorVert }
aPosObj 	:= MsObjSize( aInfo, aObjects, .T. )

oDlg1  		:= MsDialog():New( aSizeAut[7],00,aSizeAut[3]-100,aSizeAut[5]-10,"Mais de um Titulo Para o a mesmo vencimento",,,.F.,,,,,,.T.,,,.T. ) 

oSayPEG    	:= TSay():New( aPosObj[1][1],aPosObj[1][2],{||'Titulos Reembolso '},oDlg1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,236,016)

bDbClickPEG	:= {|| aBrwPEG[oBrwPEG:nAt,1] := !aBrwPEG[oBrwPEG:nAt,1]  ,oBrwPEG:Refresh()}   

//bChangePEG	:= {||AtuBrwGuia(aBrwPEG[oBrwPEG:nAt,2],aBrwPEG[oBrwPEG:nAt,3])}

//oBrwPEG 	:= TcBrowse():New(aPosObj[1][1]+10,aPosObj[1][2],aPosObj[1][4],aPosObj[1][3],,aCabPEG,aTamPEG,oDlg,,,,bChangePEG,bDbClickPEG,,,,,,,.F.,,.T.,,.F.,,, )

oBrwPEG 	:= TcBrowse():New(aPosObj[1][1]+10,aPosObj[1][2],aPosObj[1][4],aPosObj[1][3],,aCabPEG,aTamPEG,oDlg1,,,,,bDbClickPEG,,,,,,,.F.,,.T.,,.F.,,, )

oBrwPEG:SetArray(aBrwPEG) 

oBrwPEG:bLine := {||{If( aBrwPEG[oBrwPEG:nAt,1],oOk,oNo) ,;
                         aBrwPEG[oBrwPEG:nAt,30]		 ,;
                         substr(aBrwPEG[oBrwPEG:nAt,8],1,30)          ,;                        
                         substr(aBrwPEG[oBrwPEG:nAt,7],7,2)+'/'+substr(aBrwPEG[oBrwPEG:nAt,7],5,2)+'/'+substr(aBrwPEG[oBrwPEG:nAt,7],1,4) ,;
                         substr(aBrwPEG[oBrwPEG:nAt,10],1,30)        ,;                       
                         substr(aBrwPEG[oBrwPEG:nAt,11],1,30)		 ,;  
	  	                 aBrwPEG[oBrwPEG:nAt,28]                     ,; 
	  	                 aBrwPEG[oBrwPEG:nAt,29] ,;
	  	                 aBrwPEG[oBrwPEG:nAt,27] ,; 
	  	                 aBrwPEG[oBrwPEG:nAt,13] ,; 
	  	                 aBrwPEG[oBrwPEG:nAt,14]          ,;
	  	                 aBrwPEG[oBrwPEG:nAt,12]          ,;
	  	                 aBrwPEG[oBrwPEG:nAt,31]          ,; 
	  	                 aBrwPEG[oBrwPEG:nAt,32]          ,;
	  	                 aBrwPEG[oBrwPEG:nAt,33]          }}


oBrwPEG:nScrollType  := 1 // Scroll VCR

lConf 	:= .T.

aBut    :={{"PENDENTE", {||marca(1),oBrwPEG:Refresh()           }	, "Marcar Todos "       , "Marcar Todos"     } }
aAdd(aBut, {"PENDENTE", {||desmarca(1),oBrwPEG:Refresh()        }	, "DesMarcar Todos "	, "DesMarcar Todos"	 } )
aAdd(aBut, {"PENDENTE", {||demost(1),oBrwPEG:Refresh()          }	, "Demostrativo "   	, "Demostrativo"     } )   
aAdd(aBut, {"PENDENTE", {||lsair:= .T. , oDlg1:End()            }	, "Sair "   	        , "Sair"             } )  
//aAdd(aBut, {"PENDENTE", {||fConfexc(1),oBrwPEG:Refresh(),oDlg:End()}	, "Excluir Selecção"   	, "Excluir Selecção" } )    
//aAdd(aBut, {"PENDENTE", {||fConfexc(2),oBrwPEG:Refresh(),oDlg:End()}	, "Excl.Tit/Selecao"   	, "Excl.Tit/Selecao" } )

//If lsai 
   
 //  exit
   
//endIf                                                                                                                        

lConf := .F.

bOk 	:= { oDlg1:End()   }    
 
bCancel := {||lConf := .F.,oDlg1:End()}

	
oDlg1:Activate(,,,.T.,,,EnchoiceBar(oDlg1,bOk,bCancel,,aBut))


//	MsgInfo("Processo finalizado")

//	MsgAlert(Left(cBuffer,len(cBuffer)-1))
	

Return( aBrwPEG )   

//EndDo


************************************************************************************

************************************************************************************
Static Function marca() // cRef == 1 peg , 2 , proc
	
 local nI            
       
	If cRef	== 1

		For nI := 1 to len(aBrwPEG)     
		 
		    If  SUBSTR(aBrwPEG[nI,3],1,4)!='0000' .and. SUBSTR(aBrwPEG[nI,3],1,4)!='9999' 
	
		       aBrwPEG[nI,1]:= .T.
      
            EndIf	
            		
		Next     

	Else 	     
	    
	    For nI := 1 to len(aBrwDem)
	                                   
	        aBrwDem[nI,1]:= .T.
		        			
		Next     
	
	EndIf 
		
		
RETURN()



Static Function desmarca(cRef) // cRef == 1 peg , 2 , proc
	
       local nI

	   If cRef	== 1
			
	      For nI := 1 to len(aBrwPEG)
	
			   aBrwPEG[nI,1]:= .F.
			   
	      Next
	      
	   Else   
	   
	      For nI := 1 to len(aBrwDem)
	
			   aBrwDem[nI,1]:= .F.
			   
	      Next
	   
	   EndIf 

RETURN()	                                   
