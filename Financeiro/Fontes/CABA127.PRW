#Define CRLF Chr(13)+Chr(10)
#INCLUDE "PROTHEUS.ch"                                                                                                                                  
#INCLUDE "TOPCONN.ch"
#INCLUDE "PLSMGER.CH"
#Include "Ap5Mail.Ch"      
#Include 'Tbiconn.ch'    
#include "rwmake.ch"
/*--------------------------------------------------------------------------
| Programa  | CABA127  | Autor | Altamiro	Affonso    | Data | 21/06/2013  |
|---------------------------------------------------------------------------|              
| Descricao | Fatura apagar para mais de 1 titulos                          |
|           |                                                               |                                                       
|---------------------------------------------------------------------------|
| Uso       | Fatura apagar - exec auto - browser                           | 
 --------------------------------------------------------------------------*/

User Function CABA127

local cRda      := ' ' 
local cNivel     := ' '
local nI := 0  


Private aBrwDem 
Private aCabDem		:= { "Prefixo" , "Numero" , "Parcela" ,  "Tipo" , "Fornecedor","Nome Fornecedor", "Valor" , "Saldo","Venc Real", "Emissao" }
Private aTamDem		:= {25,40,20,25,30,100,40,40,40,40}

private aBrwPEG
Private aCabPEG		:= {" ", " ","Cod Fornec.","Nome Fornecedor ","Venc. Real","Valor Total ","Saldo total ","Qtda ", "Origem"}
Private aTamPEG		:= {10,10,30,120,45,45,45,25,30}  



Private oOk      	:= LoadBitMap(GetResources(),"LBOK")
Private oNo      	:= LoadBitMap(GetResources(),"LBNO")

Private oVerde   	:= LoadBitMap(GetResources(),"ENABLE")
Private oVermelho	:= LoadBitMap(GetResources(),"DISABLE")    
Private oAmarelo	:= LoadBitMap(GetResources(),"BR_AMARELO")

Private aObjects 	:= {}

Private aSizeAut 	:= MsAdvSize() 

private cQryAMP     := ' '     

Private cPerg	    := "CABA127"       

Private dVencInc                      
Private dVencFim                     
Private cTipotit                     
Private cTipbaixa                    
private nVlrtotTit:= 0

PRIVATE cAliasMTit:= GetNextAlias()

AjustaSX1()

Pergunte(cPerg,.T.)        

dVencInc := dtos(Mv_par01)                     
dVencFim := dtos(Mv_par02)                    
cTipotit := Mv_par03                    
cTipbaixa:= Mv_par04     
cAglutina:= mv_par05               
 
Processa({||aBrwPEG := aDadosPEG()},'Processando...','Processando...',.T.)
 

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

oDlg  		:= MsDialog():New( aSizeAut[7],00,aSizeAut[3]-100,aSizeAut[5]-10,"Mais de um Titulo Para o a mesmo vencimento",,,.F.,,,,,,.T.,,,.T. ) 

oSayPEG    	:= TSay():New( aPosObj[1][1],aPosObj[1][2],{||'Titulos Reembolso '},oDlg,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,236,016)

bDbClickPEG	:= {||aBrwPEG[oBrwPEG:nAt,1] := !aBrwPEG[oBrwPEG:nAt,1], oBrwPEG:Refresh()}   

//bChangePEG	:= {||AtuBrwGuia(aBrwPEG[oBrwPEG:nAt,2],aBrwPEG[oBrwPEG:nAt,3])}

//oBrwPEG 	:= TcBrowse():New(aPosObj[1][1]+10,aPosObj[1][2],aPosObj[1][4],aPosObj[1][3],,aCabPEG,aTamPEG,oDlg,,,,bChangePEG,bDbClickPEG,,,,,,,.F.,,.T.,,.F.,,, )

oBrwPEG 	:= TcBrowse():New(aPosObj[1][1]+10,aPosObj[1][2],aPosObj[1][4],aPosObj[1][3],,aCabPEG,aTamPEG,oDlg,,,,,bDbClickPEG,,,,,,,.F.,,.T.,,.F.,,, )

oBrwPEG:SetArray(aBrwPEG) 

// Transform(aBrwPEG[oBrwPEG:nAt,8],'@E  999,999,999.99'),; 
oBrwPEG:bLine := {||{If( aBrwPEG[oBrwPEG:nAt,1],oOk,oNo)               ,;
	                     oVerde 									   ,;
                         aBrwPEG[oBrwPEG:nAt, 2]					   ,;
                         aBrwPEG[oBrwPEG:nAt, 3]      				   ,; 
                         aBrwPEG[oBrwPEG:nAt, 4] 				       ,;                         
               Transform(aBrwPEG[oBrwPEG:nAt, 5],'@E  999,999,999.99') ,;
		 	   Transform(aBrwPEG[oBrwPEG:nAt, 6],'@E  999,999,999.99') ,;
		 	   Transform(aBrwPEG[oBrwPEG:nAt, 7],'@E  9,999')          ,;
		 	             aBrwPEG[oBrwPEG:nAt, 8]                       }}


oBrwPEG:nScrollType  := 1 // Scroll VCR

lConfirmou 	:= .T.
 
aBut    :={{"PENDENTE", {||marca(),oBrwPEG:Refresh()    }	, "Marcar Todos "    , "Marcar Todos"     } }
aAdd(aBut, {"PENDENTE", {||desmarca(),oBrwPEG:Refresh() }	, "DesMarcar Todos "	, "DesMarcar Todos"	} )
If cAglutina == 1
   aAdd(aBut, {"PENDENTE", {||demost( aBrwPEG[oBrwPEG:nAt,2] + Substr(aBrwPEG[oBrwPEG:nAt,4],7,4)+ Substr(aBrwPEG[oBrwPEG:nAt,4],4,2)+Substr(aBrwPEG[oBrwPEG:nAt,4],1,2)),oBrwPEG:Refresh()  }	, "Demostrativo "   	,"Demostrativo"      } )
Else 
   aAdd(aBut, {"PENDENTE", {||demost( aBrwPEG[oBrwPEG:nAt,8] ), oBrwPEG:Refresh()  }	, "Demostrativo " ,"Demostrativo" } )
EndIf 

lConfirmou := .F.
If cAglutina == 1
   bOk 	:= {||SelecFat( ) ,oBrwPEG:Refresh()   }    
else 
   bOk 	:= {||demost( aBrwPEG[oBrwPEG:nAt,8]),oBrwPEG:Refresh()  }
EndIf   

bCancel := {||lConfirmou := .F.,oDlg:End()}

	
oDlg:Activate(,,,.T.,,,EnchoiceBar(oDlg,bOk,bCancel,,aBut))


//	MsgInfo("Processo finalizado")

//	MsgAlert(Left(cBuffer,len(cBuffer)-1))
	

Return    




************************************************************************************


Static Function aDadosPEG

Local aRetPEG	:= {}
Local cQryPEG	:= ""
Local cAliasPEG	:= GetNextAlias()
local i

ProcRegua(0) 

nCont := 0

for i:=1 to 5
    IncProc('Buscando Dados no Servidor ...')
next             
                  
cQryPEG :="  SELECT E2_FORNECE  CODFOR , " + CRLF 
cQryPEG +="         E2_NOMFOR   NOMFOR , " + CRLF 
cQryPEG +="         SUBSTR(E2_VENCREA,7,2)||'/' || SUBSTR(E2_VENCREA,5,2)||'/' || SUBSTR(E2_VENCREA,1,4) VENCREA , " + CRLF  
cQryPEG +="         trim(E2_TITPAI) TITPAI , " + CRLF 
cQryPEG +="         SUM(E2_VALOR) VLR, " + CRLF                                                                              
cQryPEG +="         SUM(E2_SALDO) SALDO  ,  " + CRLF 
cQryPEG +="         COUNT(*) QTDA " + CRLF 


cQryPEG +="    FROM "+RetSqlName('SE2')+ " SE2  " + CRLF
cQryPEG +="   WHERE E2_FILIAL = '" + xFilial('SE2') + "'and  se2.d_E_L_E_T_ = ' ' " + CRLF    

cQryPEG +="     AND E2_VENCREA >= '"+dVencInc+"' " + CRLF     
cQryPEG +="     AND E2_VENCREA <= '"+dVencFim+"' " + CRLF    

If cAglutina == 1
   cQryPEG +="    and e2_prefixo = 'RLE' AND E2_TIPO = 'REM' " + CRLF    
ElseIf cAglutina == 2
   cQryPEG +="     AND e2_prefixo  = 'RFN' AND E2_TIPO = 'FT '" + CRLF        
EndIf    
   cQryPEG +="     AND E2_SALDO > 0 " + CRLF
    
If cAglutina == 1 
   cQryPEG +="  HAVING count(E2_VENCREA) > 1 " + CRLF
EndIf 
cQryPEG +="   GROUP BY  E2_FORNECE , " + CRLF
cQryPEG +="             E2_NOMFOR  , E2_TITPAI , " + CRLF
cQryPEG +="             SUBSTR(E2_VENCREA,7,2)||'/' || SUBSTR(E2_VENCREA,5,2)||'/' || SUBSTR(E2_VENCREA,1,4)   " + CRLF
cQryPEG +="   ORDER BY  3,1 " + CRLF   
                        
TcQuery cQryPEG New Alias cAliasPEG

While !cAliasPEG->(EOF())

	aAdd(aRetPEG,{.F. , cAliasPEG->CODFOR , cAliasPEG->NOMFOR , cAliasPEG->VENCREA , cAliasPEG->VLR , cAliasPEG->SALDO , cAliasPEG->QTDA , cAliasPEG->TITPAI })
	                                    
	cAliasPEG->(DbSkip())

EndDo
  
cAliasPEG->(DbCloseArea())

If empty(aRetPEG)
	aAdd(aRetPEG,{.f.,'','','','','','',''})
EndIf

Return aRetPEG

/********************************************/
/********************************************/
Static Function demost( cRef )
 
 local nI
 
         Processa({||aBrwDem := aDadosDem( cRef )},'Processando Demonstrativo ...','buscando dados no servido ...',.T.)
      
         oDlg1  		:= MsDialog():New( aSizeAut[7]-30,00,aSizeAut[3]-250,aSizeAut[5]-70,"Composição do Pagamento ",,,.F.,,,,,,.T.,,,.T. ) 

         oSayDem    	:= TSay():New( aPosObj[1][1],aPosObj[1][2],{||'Composição do pagto  '},oDlg1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,236,016)
         
         bDbClickDem	:= {||aBrwDem[oBrwDem:nAt,1] := !aBrwDem[oBrwDem:nAt,1], oBrwDem:Refresh()}   

         //oBrwDem 	    := TcBrowse():New(aPosObj[1][1]+10,aPosObj[1][2],aPosObj[1][4],aPosObj[1][3]-50,,aCabdem,aTamdem,oDlg1,,,,,,,,,,,,.F.,,.T.,,.F.,,, )
         oBrwDem 	    := TcBrowse():New(5,5,610,190,,aCabdem,aTamdem,oDlg1,,,,,bDbClickDem,,,,,,,.F.,,.T.,,.F.,,, )
        //oBrwDem 	    := TcBrowse():New(aPosObj[1][1]+10,aPosObj[1][2],aPosObj[1][4],aPosObj[1][3],,aCabdem,aTamdem,oDlg,,,,,bDbClickPEG,,,,,,,.F.,,.T.,,.F.,,, )

         oBrwDem:SetArray(aBrwDem) 
         
         oBrwDem:bLine  := {||{  	AllTrim(aBrwDem[oBrwDem:nAt,1])	    	  ,;									
									AllTrim(aBrwDem[oBrwDem:nAt,2])	   		  ,;
   								    AllTrim(aBrwDem[oBrwDem:nAt,3])	    	  ,;
								    Alltrim(aBrwDem[oBrwDem:nAt,4])		      ,;
                                    Alltrim(aBrwDem[oBrwDem:nAt,5])	    	  ,;
                                    Alltrim(aBrwDem[oBrwDem:nAt,6])			  ,;
						          Transform(aBrwDem[oBrwDem:nAt,7],'@E  999,999,999.99'),;   
						          Transform(aBrwDem[oBrwDem:nAt,8],'@E  999,999,999.99'),;
                                    Alltrim(aBrwDem[oBrwDem:nAt,9]) 	  ,;
                                    Alltrim(aBrwDem[oBrwDem:nAt,10])     }}
						
			  oBrwDem:nScrollType  := 1 // Scroll VCR
			  
 /*		     aBut1    :={{"PENDENTE", {||marcalin(),oBrwDem:Refresh()             }	, "Marcar Todos "    , "Marcar Todos"     } }
			 aAdd(aBut1, {"PENDENTE", {||desmarcalin(),oBrwDem:Refresh()          }	, "DesMarcar Todos " , "DesMarcar Todos"  } )
			 aAdd(aBut1, {"PENDENTE", {||demlin(),desmarcalin(),oBrwDem:Refresh() }	, "Demost. Linha "   , "Demost. Linha "   } )
*/
  	      bOk 	  := {|| oDlg1:End()}
          bCancel := {|| oDlg1:End()}

//        oDlg1:Activate(,,,.T.,,,EnchoiceBar(oDlg1,bOk,bCancel,,aBut1)) 
          oDlg1:Activate(,,,.T.,,,EnchoiceBar(oDlg1,bOk,bCancel,,))
		
RETURN()	


/********************************************/
Static Function aDadosDem(cRef)

Local aRetDem	  := {}
Local cQryDem	  := " "

Local cAliasDem := GetNextAlias()
local i

ProcRegua(0) 

nCont := 0

for i:=1 to 5
    IncProc('Buscando Dados no Servidor ...')
next     

		cQryDem :=" SELECT  e2_prefixo prefixo ,  e2_num     num  , " + CRLF
		cQryDem +="         e2_parcela parcela ,  e2_tipo    tipo , " + CRLF
		cQryDem +="         e2_fornece fornece ,  e2_loja    loja , " + CRLF 
		cQryDem +="         e2_nomfor  nomfor  ,                    " + CRLF		
		cQryDem +="         e2_Valor   Valor   ,  e2_saldo   saldo, " + CRLF 
		
		cQryDem +="         substr(e2_vencrea,7,2)||'/'||substr(e2_vencrea,5,2)||'/'||substr(e2_vencrea,1,4) vencrea , " + CRLF
        cQryDem +="         substr(e2_emissao,7,2)||'/'||substr(e2_emissao,5,2)||'/'||substr(e2_emissao,1,4)   emissao" + CRLF

		cQryDem +="    FROM "+RetSqlName('SE2')+ " SE2  WHERE  e2_filial =  '" + xFilial('SE2') + "'  AND SE2.D_E_L_E_T_ = ' ' " + CRLF 
		cQryDem +="     AND E2_FORNECE || E2_VENCREA IN('"+ cRef +"')" + CRLF 
		If cAglutina == 2
           cQryDem +="     AND TRIM(E2_TITPAI) = 'RFN' " + CRLF   
          // cQryDem +="     AND E2_HIST LIKE ('%caba127%') " + CRLF              		
		EndIf
        cQryDem +="   ORDER BY E2_FORNECE " + CRLF
		
		TcQuery cQryDem New Alias cAliasDem  
		       
		
		While !cAliasDem->(EOF())
			
	 		aAdd(aRetDem,{ cAliasDem->prefixo , cAliasDem->num , cAliasDem->parcela , cAliasDem->tipo , cAliasDem->Fornece , cAliasDem->nomfor , cAliasDem->valor , cAliasDem->saldo , cAliasDem->vencrea , cAliasDem->emissao })
				
			cAliasDem->(DbSkip())
			
		EndDo

  	   cAliasDem->(DbCloseArea())

       If empty(aRetDem)

		   aAdd(aRetDem,{'','','','','','',' ',' ',' ',' ' ,' '})
       EndIf
   
//Next
Return aRetDem             
                
	***********************************************************************************
Static Function marca
	
       local nI
		
		For nI := 1 to len(aBrwPEG)
	
		   aBrwPEG[nI,1]:= .T.
			
		Next
		
RETURN()	
	
Static Function desmarca
	
       local nI
		
		For nI := 1 to len(aBrwPEG)
	
			   aBrwPEG[nI,1]:= .F.
	
		Next

RETURN()	

***********************************************************************************

Static Function SelecFat()  

local nI  
Local aArray   :={}
Local aTit     :={}           
Local cQryTit  := ""
Local cAliasTit:= GetNextAlias()
local i
local cRefTit  := ' '      
local lPvez    := .T.

local DtDeFat  
local DtAteFat  

LOCAL cFornec1 := ' '  
LOCAL cLoja1   := ' '
LOCAL cNaturez1:= ' ' 
LOCAL cEmissao1:= ' '  
LOCAL cVencto1 := ' ' 
LOCAL cVencrea1:= ' '  
LOCAL nValor1  := 0.00
LOCAL nVlrCruz1:= 0.00
LOCAL cCCD1    := ' ' 

Private lMsErroAuto := .F.
		
For nI := 1 to len(aBrwPEG)
	
 If  aBrwPEG[nI,1]== .T.   
 
     cRefTit :=aBrwPEG[oBrwPEG:nAt,2] + Substr(aBrwPEG[oBrwPEG:nAt,4],7,4)+ Substr(aBrwPEG[oBrwPEG:nAt,4],4,2)+Substr(aBrwPEG[oBrwPEG:nAt,4],1,2)
			  
     cQryTit :=" SELECT e2_prefixo prefixo ,  e2_num     num  , " + CRLF
	 cQryTit +="        e2_parcela parcela ,  e2_tipo    tipo , " + CRLF
	 cQryTit +="        e2_fornece fornece ,  e2_loja    loja , " + CRLF 
	 cQryTit +="        e2_nomfor  nomfor  ,                    " + CRLF		
	 cQryTit +="        e2_Valor   Valor   ,  e2_saldo   saldo, " + CRLF 
		
	 cQryTit +="        e2_vencrea vencrea , " + CRLF
	 cQryTit +="        e2_emissao emissao , " + CRLF     
	 
	 cQryTit +="        e2_vencto vencto , e2_ccd  ccd  , e2_naturez naturez " + CRLF 

     cQryTit +=" FROM "+RetSqlName('SE2')+ " SE2  WHERE  e2_filial =  '" + xFilial('SE2') + "'  AND SE2.D_E_L_E_T_ = ' ' " + CRLF 
  	 cQryTit +="  AND E2_FORNECE || E2_VENCREA IN('"+ cRefTit +"') " + CRLF
     cQryTit +="ORDER BY E2_FORNECE " + CRLF    
     
     TcQuery cQryTit New Alias (cAliasTit)
     
     lPvez := .T.		

	 nVlrtotTit := 0   
	  

     While !(cAliasTit)->(EOF())   
		    
		   		 
			u_fBaixaPag(xFilial('SE2'), (cAliasTit)->prefixo , (cAliasTit)->num , (cAliasTit)->parcela , (cAliasTit)->tipo , (cAliasTit)->Fornece , (cAliasTit)->loja  ,(cAliasTit)->saldo)	
              
              cNumtit  := (cAliasTit)->num        
              cFornec1 := (cAliasTit)->Fornece  
              cLoja1   := (cAliasTit)->loja
              cNaturez1:= (cAliasTit)->naturez 
              cEmissao1:= (cAliasTit)->emissao  
              cVencto1 := (cAliasTit)->vencto 
              cVencrea1:= (cAliasTit)->vencrea  
              cCCD1    := (cAliasTit)->ccd                   
              cRefTit1 := cRefTit

			(cAliasTit)->(DbSkip())
			
	 EndDo
	
	    
 	    u_FIN050INC(cFornec1, cNumtit,  cLoja1  ,cNaturez1, cEmissao1,cVencto1 ,cVencrea1,nVlrtotTit ,nVlrtotTit,cCCD1, cRefTit1  )
  	    
  	    (cAliasTit)->(DbCloseArea())
		 
   EndIf    
 		  	  
Next


//MsExecAuto( { |x,y| FINA290(x,y)},3,aArray,)
   
oDlg:End()

Return()


/***************************************************************************************/
Static Function AjustaSX1()

Local aHelp 	:= {}   


aAdd(aHelp, "Data Vencimento Real Inicial , Limite Superior da Data do Vencimento Real ")
PutSX1(cPerg,"01", "Dt Vencimento De ?","","","mv_ch1","D",8,0,0,"G","","","","","mv_par01"," ","","",""," ","",""," ","","","","","","","","",aHelp,aHelp,aHelp) 

aAdd(aHelp, "Data Vencimento Real Final , Limite Inferior da Data do Vencimento Real ")
PutSX1(cPerg,"02", "Dt Vencimento Ate ?","","","mv_ch2","D",8,0,0,"G","","","","","mv_par02"," ","","",""," ","",""," ","","","","","","","","",aHelp,aHelp,aHelp)

aAdd(aHelp, "O que Listar ")
PutSX1(cPerg,"03", "Listar , Por Tipo  ","","","mv_ch3","N",1,0,1,"C","","","","","mv_par03","Reembolso ","","","","Financeiro ","","","Faturas","","","Todos","","","","","",aHelp,aHelp,aHelp)

aAdd(aHelp, "Listar baixados , nao baixados ou todos  ")
PutSX1(cPerg,"04", "Listar , Por Baixa ","","","mv_ch4","N",1,0,1,"C","","","","","mv_par04","Não Baixado "	,"","","","Baixado ","","","Todos ","","","","","","","","",aHelp,aHelp,aHelp)

aAdd(aHelp, "Listar Titulos de reembolso , Aglutinados   ou à Aglutinar  ")
PutSX1(cPerg,"05", "Listar ,titulos ","","","mv_ch5","N",1,0,1,"C","","","","","mv_par05"," à Aglutinar "	,"","","","Aglutinados ","","", " ","","","","","","","","",aHelp,aHelp,aHelp)

Return

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Formata textos das caixas multiget                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Static Function fEnvEmail(cNivel , cRda )

Local lEmail     := .F.
Local c_CampAlt  := '  ' 
Local lExecuta   := .T.   
local cDest      := " "                           
Local aArea      := GetArea() //Armazena a Area atual        
Local _cMensagem := " " 

_cMensagem := "Em " + DtoC( Date() ) +  Chr(10) + Chr(13) + Chr(10) + Chr(13) 

_cMensagem +=  Chr(13) + Chr(10) + Chr(13) + Chr(10) + " Assunto : Pagamento de Rda's a Libera : " 
_cMensagem +=  Chr(13) + Chr(10) + Chr(13) + Chr(10) + "Prezados,"       

_cMensagem +=  Chr(13) + Chr(10) + Chr(13) + Chr(10) + "Existe(m) Pagamento(s) de Rda('s) aguardando Liberação(oes) por Alçada "
_cMensagem +=  Chr(13) + Chr(10) + Chr(13) + Chr(10) + cRda    
 
if cNivel == '01'
      //destinatario cristina 
     cDest+= "altamiro@caberj.com.br ; douglas.futuro@caberj.com.br"
ElseIf cNivel == '02'
      //destinatario Giordano  
     cDest+= "altamiro@caberj.com.br ; carlabiagioni@caberj.com.br"
ElseIf cNivel == '03'
      //destinatario jose paulo   
     cDest+= "altamiro@caberj.com.br ; macedo@caberj.com.br"
EndIf              

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
Local _cMailConta  := GetMv( "MV_EMCONTA" )
Local _cMailSenha  := GetMv( "MV_EMSENHA" ) 

//Local _cTo  	 := "altamiro@caberj.com.br, paulovasques@caberj.com.br, piumbim@caberj.com.br"
Local _cTo  	     := cDest //"altamiro@caberj.com.br "
Local _cCC         := " "  //GetMv( "MV_WFFINA" )
Local _cAssunto    := " Liberação de Pagamento Por Alçada "
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


User Function fBaixaPag(Filial,          Prefixo ,              Num ,              Parcela ,              Tipo ,              Fornece ,               Loja  ,                      Saldo)	


Private lMsErroAuto := .F.  

dbSelectArea("SE2")
SE2->(dbSetOrder(1))
SE2->(dbGoTop())  

Begin Transaction     

//If SE2->(dbSeek(xFilial("SE2") + "RLE" + "011946814" + ""+ "REM" + "135223" + "01"))       
If SE2->(dbSeek(xFilial("SE2")+ Prefixo + Num + Parcela + Tipo + Fornece + Loja ))  

   If SE2->E2_SALDO > 0
      cHistBaixa := "BX. por Aglut. caba127"
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
//³Monta array com os dados da baixa a pagar do título³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ 
      aBaixa := {}                                                

      AADD(aBaixa, {"E2_FILIAL"   , FILIAL , Nil})
 	  AADD(aBaixa, {"E2_PREFIXO"  , Prefixo  , Nil})
	  AADD(aBaixa, {"E2_NUM"      , NUM , Nil})
	  AADD(aBaixa, {"E2_PARCELA"  , PARCELA, Nil})
	  AADD(aBaixa, {"E2_TIPO"     , TIPO , Nil})
	  AADD(aBaixa, {"E2_FORNECE"  , FORNECE  , Nil})
	  AADD(aBaixa, {"E2_LOJA"     , LOJA  , Nil}) 
	  AADD(aBaixa, {"AUTMOTBX"    , 'BNF'  , Nil})
	  AADD(aBaixa, {"AUTBANCO"    , ' ' , Nil})
	  AADD(aBaixa, {"AUTAGENCIA"  , '' , Nil})
	  AADD(aBaixa, {"AUTCONTA"    , '' , Nil})
      AADD(aBaixa, {"AUTDTBAIXA"  , dDatabase , Nil}) 
	  AADD(aBaixa, {"AUTDTCREDITO", DDATABASE  , Nil})
	  AADD(aBaixa, {"AUTHIST"     , cHistBaixa , Nil})
  	  AADD(aBaixa, {"AUTVLRPG"    , SALDO , Nil}) 

  	                                             
  	  
  	    
  	  nVlrtotTit += SE2->E2_SALDO
	  
	  ACESSAPERG("FIN080", .F.)
	  MSEXECAUTO({|x,y| FINA080(x,y)}, aBaixa, 3)
	  If lMsErroAuto
	     MOSTRAERRO() 
	     DisarmTransaction()
	     Return .F.
	  Else   
	     Alert("Baixa realizada, verifique a SE5")    
	     
	     RecLock("SE2",.F.)
         //  E2_HIST   :=  cHistBaixa   
           E2_TITPAI := 'RFN'   
         MsUnlock("SE2")  
	     
	  EndIf 
	
   Else
      Alert("O título não possui saldo a pagar em aberto")
   EndIf 
Else
  Alert("O título a pagar não foi localizado")
EndIf  
	End Transaction  

Return

USER FUNCTION FIN050INC(cFornec1, cNumTit1 ,  cLoja1  ,cNaturez1, cEmissao1,cVencto1 ,cVencrea1,nValor1  ,nVlrCruz1,cCCD1  )
   //u_FIN050INC(cFornec1, cLoja1  ,cNaturez1, cEmissao1,cVencto1 ,cVencrea1,nVlrtotTit ,nVlrtotTit,cCCD1  )
LOCAL aArray := {}    

local a_DadosSE2:= {}                                          

LOCAL cPrefixo:= 'RFN'    
LOCAL cNumTit := cNumTit1
LOCAL cParcela:= ' '                 
LOCAL CTipo   := 'FT '
LOCAL cFornece:= cFornec1  
LOCAL cLoja   := cLoja1
LOCAL cNaturez:= cNaturez1 
LOCAL cEmissao:= dDataBase  
LOCAL cVencto := dDataBase 
LOCAL cVencrea:= dDataBase   
Local cHistor := 'Reemb Aglutinado '
LOCAL nValor  := nValor1
LOCAL nVlrCruz:= nValor1
LOCAL cCCD    := cCCD1                                                                                                            
local cRefTit2:= trim(cRefTit1)    

If dtos(cEmissao) >=  cVencto1   
   cVencto  := dDataBase 
   cVencrea := dDataBase   
else                       
   cVencto  := stod ( cVencto1 )  
   cVencrea := stod ( cVencrea1 )    
EndIf    

PRIVATE lMsErroAuto := .F.   
////////                                   
                                                                   
 aadd(a_DadosSE2, {'E2_PREFIXO'      , cPrefixo          , NIL})
 aadd(a_DadosSE2, {'E2_NUM'          , cNumTit           , NIL})
 aadd(a_DadosSE2, {'E2_PARCELA'      , cParcela          , NIL})
 aadd(a_DadosSE2, {'E2_TIPO'         , CTipo             , NIL})
 aadd(a_DadosSE2, {'E2_FORNECE'      , cFornece          , NIL})
 aadd(a_DadosSE2, {'E2_LOJA'         , cLoja             , NIL})
 aadd(a_DadosSE2, {'E2_NATUREZ'      , cNaturez          , NIL})
 aadd(a_DadosSE2, {'E2_EMISSAO'      , cEmissao          , NIL})
 aadd(a_DadosSE2, {'E2_VENCTO'       , cVencto           , NIL})
 aadd(a_DadosSE2, {'E2_VENCREA'      , cVencrea          , NIL})
 aadd(a_DadosSE2, {'E2_HIST'         , cHistor           , NIL})
 aadd(a_DadosSE2, {'E2_VALOR'        , nValor            , NIL})
 aadd(a_DadosSE2, {'E2_VLCRUZ'       , nVlrCruz          , NIL})
 aadd(a_DadosSE2, {'E2_CCD'          , cCCD              , NIL}) 
 aadd(a_DadosSE2, {'E2_titpai'       , trim(cRefTit2)    , NIL})


 BEGIN Transaction
    //QOut(iIf(PA0->PA0_TPTITU=="6","ADIANTAMENTO A CONVENIADO","ADIANTAMENTO A CREDENCIADO"))
 _lRet  := .T.
 
 lMsErroAuto := .F.
 
 MSExecAuto({|x,y,z| Fina050(x,y,z)},a_DadosSE2,,3)
 
 If lMsErroAuto
 
    QOut( "E R R O    N O    E X E C A U T O" )

    lMsHelpAuto := .T.

    DisarmTransaction()
                               
    MostraErro()
    
    _cErro := MostraErro(NIL, "C:\erro_exec.GER") // Para gravar o erro

    memowrite("C:\erro_exec.GER", _cErro)

    QOut( _cErro )

    _lRet := .F.
     
 Else
 
    Alert("Título incluído com sucesso!")

 Endif
 
 END Transaction



///////
/* 
aArray := { { "E2_PREFIXO"  , "PAG"             , NIL },;
            { "E2_NUM"      , "0001"            , NIL },;
            { "E2_TIPO"     , "NF"              , NIL },;
            { "E2_NATUREZ"  , "001"             , NIL },;
            { "E2_FORNECE"  , fornece           , NIL },;
            { "E2_EMISSAO"  , CtoD("17/02/2018"), NIL },;
            { "E2_VENCTO"   , CtoD("17/02/2018"), NIL },;
            { "E2_VENCREA"  , CtoD("17/02/2018"), NIL },;
            { "E2_VALOR"    , valor             , NIL } }
 
MsExecAuto( { |x,y,z| FINA050(x,y,z)}, aArray,, 3)  // 3 - Inclusao, 4 - Alteração, 5 - Exclusão
 
 
If lMsErroAuto
    MostraErro()
Else
    Alert("Título incluído com sucesso!")
Endif
*/
Return

static Function PegNum()

cQryMTit := " ( SELECT NVL(MAX(E2_NUM),'000000000') NUM   " + CRLF 
cQryMTit += "     FROM "+RetSqlName('SE1')+ " SE2 " + CRLF  
cQryMTit += "    WHERE E1_FILIAL ='"+ xFilial('SE2')+"' AND E2_PREFIXO = 'RFN') NUME1 " + CRLF         

If Select(cAliasMTit) > 0
	dbSelectArea(cAliasMTit)
	dbCloseArea()
EndIf

TcQuery cQryMTit New Alias (cAliasMTit)

Return((cAliasMTit)->NUM )
// cosulta por linhas  **********/
 
