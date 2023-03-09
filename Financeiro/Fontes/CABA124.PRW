#Define CRLF Chr(13)+Chr(10)
#INCLUDE "PROTHEUS.ch"                                                                                                                                  
#INCLUDE "TOPCONN.ch"
#INCLUDE "PLSMGER.CH"
#Include "Ap5Mail.Ch"    
/*--------------------------------------------------------------------------
| Programa  | CABA124 | Autor | Altamiro	Affonso    | Data | 07/11/2016  |
|---------------------------------------------------------------------------|              
| Descricao | Controle de pagamento , liberação gerenciada                  |
|           |                                                               |                                                       
|---------------------------------------------------------------------------|
| Uso       | gestora do  financeiro                                        | 
 --------------------------------------------------------------------------*/

User Function CABA124 ( nRecno )                                                                                   

local cRda      := ' ' 
local cNivel    := ' '
local nI        := 0        
private lsai    := .F. 

private pvez    := .T.

private aRetTit	:= {}
private aBrwTit                  
Private aCabTit		:= {" ", " ","nome Rda" , "Num Bord", "Prefixo" , "Num Tit" , "Parcela" ,"Tipo" , "Emissao" ,"Venc. Real", "Saldo" ,"Vlr Tot","Vlr Pgto" , "Competencia", "Controle","At/Anter"}  
Private aTamTit		:= {15,15,120,40,30,40,10,15,45,45,45,40,40,40,30,30} 

Private oOk      	:= LoadBitMap(GetResources(),"LBOK")
Private oNo      	:= LoadBitMap(GetResources(),"LBNO")

Private oVerde   	:= LoadBitMap(GetResources(),"Atual")
Private oVermelho	:= LoadBitMap(GetResources(),"Anterior")    
//Private oAmarelo	:= LoadBitMap(GetResources(),"BR_AMARELO")

Private aObjects 	:= {}

Private aSizeAut 	:= MsAdvSize() 

private cQryAMP     := ' '     

Private cPerg	    := "CABA124"     

private datatu      := dtos(dDataBase)      

private nliberado := 0        
private nSlRecTot := 0
private nAliberar := 0           
private nSlTotLib := 0

private cAnocomp0 := 0 
private cMescomp0 := 0 
private nsldcomp0 := 0 


private cAnocomp1 := 0 
private cMescomp1 := 0 
private nsldcomp1 := 0
                      
private cAnocomp2 := 0 
private cMescomp2 := 0 
private nsldcomp2 := 0 

private cAnocomp3 := 0 
private cMescomp3 := 0 
private nsldcomp3 := 0      

private nsaldocred:= 0
private nPreccred := 0 

/*private cCompeten   := cCompet
private cGrupoPgto  := cGrppag  
private nNumopcao   := nOpcao  
*/
private datatu      := dtos(dDataBase-10)      
private cAliasSe2   := GetNextAlias()       
private cAliasTit	:= GetNextAlias()
/*
AjustaSX1()

Pergunte(cPerg,.T.)    
                     
dDtPror := IIf (!empty(trim(dtos(mv_par04))) , dtos(mv_par04) , ' ')                      
  */
Processa({||aBrwTit:= aDadosTit()},'Processando...','Processando...',.T.)
 
 if lsai 
 
    lsai := .F.    
    
    Return()
    
 Endif    

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

oDlg  		:= MsDialog():New( aSizeAut[7],00,aSizeAut[3]-100,aSizeAut[5]-10,"Gestao de Liberação Pagamento  ",,,.F.,,,,,,.T.,,,.T. ) 

oSayTit    	:= TSay():New( aPosObj[1][1],aPosObj[1][2],{||'Gestao de Liberação Pagamento  '},oDlg,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,236,016)

bDbClickTit	:= {||fClik(!aBrwTit[oBrwTit:nAt,1], aBrwTit[oBrwTit:nAt,13] , oBrwTit:nAt ) , aBrwTit[oBrwTit:nAt,1] := !aBrwTit[oBrwTit:nAt,1], oBrwTit:Refresh(), fhistLib(2)  }   

//bChangeTit	:= {||AtuBrwGuia(aBrwTit[oBrwTit:nAt,2],aBrwTit[oBrwTit:nAt,3])}

//oBrwTit 	:= TcBrowse():New(aPosObj[1][1]+10,aPosObj[1][2],aPosObj[1][4],aPosObj[1][3],,aCabTit,aTamTit,oDlg,,,,bChangeTit,bDbClickTit,,,,,,,.F.,,.T.,,.F.,,, )

oBrwTit 	:= TcBrowse():New(aPosObj[1][1]+10,aPosObj[1][2],aPosObj[1][4],aPosObj[1][3],,aCabTit,aTamTit,oDlg,,,,,bDbClickTit,,,,,,,.F.,,.T.,,.F.,,, )

oBrwTit:SetArray(aBrwTit) 

// Transform(aBrwTit[oBrwTit:nAt,8],'@E  999,999,999.99'),; 
oBrwTit:bLine := {||{If( aBrwTit[oBrwTit:nAt,1],oOk,oNo) ,;
	 If( aBrwTit[oBrwTit:nAt,15] == "Anterior" ,oVermelho, oVerde) ,;                                                           
		                   aBrwTit[oBrwTit:nAt, 2]		                	 ,;
				           aBrwTit[oBrwTit:nAt, 3]                           ,; 
		                   aBrwTit[oBrwTit:nAt, 4]		                	 ,;
				           aBrwTit[oBrwTit:nAt, 5]                           ,;
		                   aBrwTit[oBrwTit:nAt, 6]		                	 ,;
				           aBrwTit[oBrwTit:nAt, 7]                           ,;
		                   StoD(aBrwTit[oBrwTit:nAt, 8])                 	 ,;
				           StoD(aBrwTit[oBrwTit:nAt, 9])                     ,;
	  	    	      Transform(aBrwTit[oBrwTit:nAt,10],'@E  999,999,999.99')  ,; 
	  	    	      Transform(aBrwTit[oBrwTit:nAt,11],'@E  999,999,999.99')  ,;
	  	    	      Transform(aBrwTit[oBrwTit:nAt,12],'@E  999,999,999.99')  ,;	  	    	 	  	    	 
		 	               aBrwTit[oBrwTit:nAt,13] ,;
		 	               aBrwTit[oBrwTit:nAt,14] ,;
		 	               aBrwTit[oBrwTit:nAt,15] }}         
		 	                                                                                          

oBrwTit:nScrollType  := 1 // Scroll VCR


lConfirmou 	:= .F. 

 
aBut    :={{"PENDENTE", {||marca(),oBrwTit:Refresh()    }	, "Marcar Todos "    , "Marcar Todos"     } }
aAdd(aBut, {"PENDENTE", {||desmarca(),oBrwTit:Refresh() }	, "DesMarcar Todos "	, "DesMarcar Todos"	} )
aAdd(aBut, {"PENDENTE", {||demost(),oBrwTit:Refresh()  }	, "Demostrativo "   	,"Demostrativo"      } )

 bOk 	:= {|| lConfirmou := .T. , TrocVenc(),oDlg:End()  }    
//  bOk 	:= {||lConfirmou := .T., atrbalcada(),oDlg:End()}   
bCancel := {||lConfirmou := .F.,oDlg:End()}

	
oDlg:Activate(,,,.T.,,,EnchoiceBar(oDlg,bOk,bCancel,,aBut))

If lConfirmou  
	/*
    For nI := 1 to len(aBrwTit)

	   If aBrwTit[nI,1] == .T.
             cRda+= 'Rda         : ' +  aBrwTit[nI,2] + CRLF   	         
             cRda+= 'Titulo      : ' +  aBrwTit[nI,4] +aBrwTit[nI,5] +aBrwTit[nI,6] +aBrwTit[nI,7] + CRLF    			 
             cRda+= 'Saldo       : R$' +  Transform(aBrwTit[oBrwTit:nAt,10],'@E  999,999,999.99')   + CRLF   
             cRda+= 'Venc.       : ' + aBrwTit[nI,9] + CRLF  
             cRda+= 'LiberVenc. Prorogado: ' + dDtPror + CRLF 
             cRda+= '________________________________________________________________' + CRLF  
	        EndIf
	        
	Next
	If !empty(trim(cRda))
       fEnvEmail( cRda ) 	
    EndIf      
    */
	MsgInfo("Processo finalizado")

//	MsgAlert(Left(cBuffer,len(cBuffer)-1))
	
EndIf

Return    

Static Function TrocVenc()

Local nI  := 0        

nsldcomp0 := 0 
nsldcomp1 := 0 
nsldcomp2 := 0 
nsldcomp3 := 0      
	       
   dBSelectArea("SE2")
	
	For nI := 1 to len(aBrwTit)

	   If aBrwTit[nI,1] == .T.
	   
   	   	  se2->(DbGoto(aBrwTit[nI,14]))
	   
	      RecLock( "SE2" , .F. )   
	  
      //    SE2->E2_DATALIB := datatu  
    	        
	      se2->e2_ctrpgt   :=  PCI->PCI_CPTPGT + substr(PCI->PCI_DESCPG,1,4) + trim(PCI->PCI_CLSRED) + strzero(PCI->PCI_SEQ,2)      
          
	      SE2->(MSUNLOCK())              
	                          
	       
	//APROPRIA VALOR LIB POR COMPETENCIA       
          If trim(substr(se2->e2_pllote,1,6)) == trim(cCPTPGT)           
        
              nsldcomp0:= nsldcomp0 + SE2->E2_SALDO 
            
          ElseIf trim(substr(se2->e2_pllote,1,6)) == ltrim(str(cAnocomp1) + strzero((cmescomp1),2))    
       
              nsldcomp1:= nsldcomp1 + SE2->E2_SALDO
       
          ElseIf trim(substr(se2->e2_pllote,1,6)) == ltrim(str(cAnocomp2) + strzero((cMescomp2),2))    
       
              nsldcomp2:= nsldcomp2 + SE2->E2_SALDO
             
          ElseIf trim(substr(se2->e2_pllote,1,6)) == ltrim(str(cAnocomp3) + strzero((cMescomp3),2))    
    
              nsldcomp3:= nsldcomp3 + SE2->E2_SALDO
          
          EndIf         
  	      
	      gravalog(nI)     
       EndIf   
                                                                                                                
       lConfirmou 	:= .T. 

	Next                     
	                          
	      RecLock( "PCI" , .F. )   
	  
          PCI->PCI_STATUS:= 'Concluido'      
          
          PCI->PCI_VLREA0 := nsldcomp0 
          PCI->PCI_VLREA1 := nsldcomp1
          PCI->PCI_VLREA2 := nsldcomp2
          PCI->PCI_VLREA3 := nsldcomp3      
          
          PCI->PCI_SLDREC := ( PCI->PCI_VLTREC - ( PCI->PCI_VLREA0 + PCI->PCI_VLREA1 + PCI->PCI_VLREA2 + PCI->PCI_VLREA3 ) )      
          PCI->PCI_PRECAl := ( PCI->PCI_VLTREC / ( ( PCI->PCI_VLREA0 + PCI->PCI_VLREA1 + PCI->PCI_VLREA2 + PCI->PCI_VLREA3 ) * 100 ))     
          PCI->PCI_PRECSD := 100 - PCI->PCI_PRECAl 
          
          PCI->PCI_PRREA0 := IIF(nsldcomp0== 0 , 0.00, ((nsldcomp0 * 100) / PCI->PCI_VLEST0))
          PCI->PCI_PRREA1 := IIF(nsldcomp1== 0 , 0.00, ((nsldcomp1 * 100) / PCI->PCI_VLEST1))
          PCI->PCI_PRREA2 := IIF(nsldcomp2== 0 , 0.00, ((nsldcomp2 * 100) / PCI->PCI_VLEST2))
          PCI->PCI_PRREA3 := IIF(nsldcomp3== 0 , 0.00, ((nsldcomp3 * 100) / PCI->PCI_VLEST3))
	        
	      PCI->(MSUNLOCK())   
	
       lConfirmou 	:= .F.
   
    u_fFazexcel(cCPTPGT)	
	
RETURN()	

Static Function gravalog(nAt)
                        
    dBSelectArea("PCP")
	   
	RecLock( "PCP" , .T. )   
	
       PCP->PCP_PREFIX   := aBrwTit[oBrwTit:nAt, 4]
       PCP->PCP_NUM      := aBrwTit[oBrwTit:nAt, 5]
       PCP->PCP_PARC     := aBrwTit[oBrwTit:nAt, 6]
       PCP->PCP_TIPO     := aBrwTit[oBrwTit:nAt, 7]
       PCP->PCP_NUMBOR   := aBrwTit[oBrwTit:nAt, 3]
       PCP->PCP_CODRDA   := aBrwTit[oBrwTit:nAt, 2]
       PCP->PCP_DTORIG   := stod(aBrwTit[oBrwTit:nAt, 9])
       PCP->PCP_DTDEST   := stod(datatu)
       PCP->PCP_USUARI   := SubStr(cUSUARIO,7,15)
       PCP->PCP_DTHR     := dtos(dDataBase)      
       
       

	PCP->(MSUNLOCK())           
    
RETURN()
/***********************************************************************************/	
Static Function fClik(lok , cNumlot , nI )
	
	  If lok == .F.
	    
	     fCalcSld('1', cNumlot, 1 , nI )  
	        
	  Else                 
	        
         fCalcSld('2', cNumlot, 1 , nI)  
	          
      EndIf 
		
RETURN()	
/***********************************************************************************/
Static Function marca   

local cprivez := .T.
	
local nI
		
		For nI := 1 to len(aBrwTit) 
		
		    If aBrwTit[nI,1] == .F.
	    
	           If fCalcSld('1', aBrwTit[nI,15],1, nI)
		
		          aBrwTit[nI,1]:= .T.
		
		       ElseIf ApMsgYesNo(        "          Titulo : "+aBrwTit[nI,04]+aBrwTit[nI,05]+aBrwTit[nI,06]+aBrwTit[nI,07] + CRLF +; 
		                                 " do Fornecedor a : "+aBrwTit[nI,02] + CRLF +; 
		                                 " no Valor de     : "+Transform( aBrwTit[nI,10] , "@R  999,999,999.99")     + CRLF +;
		                         " Ultrapassou do saldo Disponivel , Deseja Marcar os Titulos para liberação   ?? ","SIMNAO")
                    		    
		          aBrwTit[nI,1]:= .T. 

		          fCalcSld('1', aBrwTit[nI,15],1, nI)
		
		      EndIf        
		      
            EndIf
		   
		Next 
		
  fhistLib(2)
       
RETURN()	
/***********************************************************************************/	
Static Function desmarca
	
local nI    
    	
		For nI := 1 to len(aBrwTit)  
		
		    If aBrwTit[nI,1] == .T.
           
               fCalcSld('2', aBrwTit[nI,15], 1 , nI ) 
        
			   aBrwTit[nI,1]:= .F.
			
			EndIf    
	
		Next  
 
       fhistLib(2) 

RETURN()	
/***********************************************************************************/
Static Function aDadosTit

LOCAL nConSald:= ' '

Local cQryTit	:= ""

local i                          
local cCPTPGT   := PCI->PCI_CPTPGT    
local cCLSRED   := PCI->PCI_CLSRED
LOCAL cGRPPAG   := SUBSTR (PCI->PCI_DESCPG,1,4)
LOCAL cSTATUS   := PCI->PCI_STATUS            
LOCAL CORDENA   := PCI->PCI_ORDENA 
                                     

                                        
If ApMsgYesNo("Considera Saldo da receita para Listagem  ?? ","SIMNAO")
   nConSald:= 1
else 
   nConSald:= 2
EndIf 

ProcRegua(0) 

nCont := 0  



for i:=1 to 5
    IncProc('Buscando Dados no Servidor ...')
next 

////////////////////////////////
         
cQryTit :=" SELECT nvl(trim(bau_nfanta),bau_nome) nomerda, " + CRLF 
cQryTit +="        E2_numbor numbor, nvl(substr(e2_pllote,1,6), ' ') numlot , " + CRLF 
cQryTit +="        e2_prefixo pref, e2_num num , e2_parcela parc, e2_tipo tipo , e2_emis1 emissao , e2_vencrea vencrea, " + CRLF 
cQryTit +="        e2_saldo  saldo ,  " + CRLF 
cQryTit +="       (e2_valor + e2_irrf +  e2_inss + e2_iss + e2_Vretpis +e2_vretcof+ e2_vretcsl) vlrtot  ,  " + CRLF 
cQryTit +="       (e2_valor-e2_saldo ) vlr_pgto  , se2.R_E_C_N_O_ recse2 , decode(substr(E2_PLLOTE,1,6) , '"+cCPTPGT+"', 'Atual','Anterior') AT_ANT , " + CRLF 
cQryTit +="       sum(pci_slest0) sldcmp0 , " + CRLF
cQryTit +="       sum(pci_slest1) sldcmp1 , " + CRLF
cQryTit +="       sum(pci_slest2) sldcmp2 , " + CRLF
cQryTit +="       sum(pci_slest3) sldcmp3 ,  " + CRLF

cQryTit +="       (pci_slest0+pci_slest1+pci_slest2+pci_slest3) sldtotlib ,  " + CRLF 
cQryTit +="       pci_sldRec  sldtotrec   " + CRLF

cQryTit +="   FROM " +RetSqlName('SE2')+ " SE2 , " +RetSqlName('BAU')+ " BAU , " +RetSqlName('PCI')+ " PCI  " + CRLF
cQryTit +="  WHERE E2_FILIAL      = '" + xFilial('SE2')    + "' AND SE2.D_E_L_E_T_    = ' ' " + CRLF  
cQryTit +="    AND BAU.BAU_FILIAL = '" + xFilial('BAU')    + "' AND BAU.D_E_L_E_T_    = ' '  AND BAU.R_E_C_D_E_L_ = 0 " + CRLF        
//cQryTit +="    AND PCI.R_e_c_n_o_ = "+nRecno + " " + CRLF
cQryTit +="    AND PCI_FILIAL  = '" + xFilial('PCI')    + "' AND PCI.D_E_L_E_T_ = ' ' " + CRLF  

cQryTit +="    AND E2_SALDO > 0 AND TRIM(E2_TIPO) = 'FT'  "+ CRLF   
If nConSald == 1
   cQryTit +="    AND ((PCI_ATV0 = 'Sim'  and PCI_SLEST0 > 0" + CRLF
   cQryTit +="    AND (E2_PLLOTE like '"+cCPTPGT+"%' AND TO_CHAR(ADD_MONTHS(TO_DATE('"+cCPTPGT+"' ,'YYYYMM'),-0 ),'YYYYMM') = SUBSTR(E2_PLLOTE,1,6))) " + CRLF
   cQryTit +="     or (PCI_ATV01 = 'Sim'  and PCI_SLEST1 > 0 " + CRLF
   cQryTit +="    AND (E2_PLLOTE < '"+cCPTPGT+"0001' AND TO_CHAR(ADD_MONTHS(TO_DATE('"+cCPTPGT+"' ,'YYYYMM'),-1 ),'YYYYMM') = SUBSTR(E2_PLLOTE,1,6))) " + CRLF
   cQryTit +="     or (PCI_ATV02 = 'Sim'  and PCI_SLEST2 > 0 " + CRLF
   cQryTit +="    AND (E2_PLLOTE < '"+cCPTPGT+"0001' AND TO_CHAR(ADD_MONTHS(TO_DATE('"+cCPTPGT+"' ,'YYYYMM'),-2 ),'YYYYMM') = SUBSTR(E2_PLLOTE,1,6))) " + CRLF    
   cQryTit +="     or (PCI_ATV03 = 'Sim'  and PCI_SLEST3 > 0 " + CRLF
   cQryTit +="    AND (E2_PLLOTE < '"+cCPTPGT+"0001' AND TO_CHAR(ADD_MONTHS(TO_DATE('"+cCPTPGT+"' ,'YYYYMM'),-3 ),'YYYYMM') = SUBSTR(E2_PLLOTE,1,6))))" + CRLF   
Else 
   cQryTit +="    AND ((PCI_ATV0 = 'Sim'  " + CRLF
   cQryTit +="    AND (E2_PLLOTE like '"+cCPTPGT+"%' AND TO_CHAR(ADD_MONTHS(TO_DATE('"+cCPTPGT+"' ,'YYYYMM'),-0 ),'YYYYMM') = SUBSTR(E2_PLLOTE,1,6))) " + CRLF
   cQryTit +="     or (PCI_ATV01 = 'Sim'  " + CRLF
   cQryTit +="    AND (E2_PLLOTE < '"+cCPTPGT+"0001' AND TO_CHAR(ADD_MONTHS(TO_DATE('"+cCPTPGT+"' ,'YYYYMM'),-1 ),'YYYYMM') = SUBSTR(E2_PLLOTE,1,6))) " + CRLF
   cQryTit +="     or (PCI_ATV02 = 'Sim'  " + CRLF
   cQryTit +="    AND (E2_PLLOTE < '"+cCPTPGT+"0001' AND TO_CHAR(ADD_MONTHS(TO_DATE('"+cCPTPGT+"' ,'YYYYMM'),-2 ),'YYYYMM') = SUBSTR(E2_PLLOTE,1,6))) " + CRLF    
   cQryTit +="     or (PCI_ATV03 = 'Sim'  " + CRLF
   cQryTit +="    AND (E2_PLLOTE < '"+cCPTPGT+"0001' AND TO_CHAR(ADD_MONTHS(TO_DATE('"+cCPTPGT+"' ,'YYYYMM'),-3 ),'YYYYMM') = SUBSTR(E2_PLLOTE,1,6))))" + CRLF   
EndIf 
cQryTit +="    AND TRIM(PCI_STATUS) = 'Ativo'" + CRLF 
if !empty(cCLSRED)
   cQryTit +="    AND E2_PREFIXO     = '"+cCLSRED +"'  " + CRLF           
   cQryTit +="    AND PCI_CLSRED     = '"+cCLSRED +"'  " + CRLF          
EndIf                                      

cQryTit +="    AND BAU_GRPPAG = '"+cGRPPAG +"'  " + CRLF 
cQryTit +="    AND substr(PCI.PCI_DESCPG,1,4) = '"+cGRPPAG +"'  " + CRLF            
cQryTit +="    AND PCI_CPTPGT = '"+cCPTPGT+"'  " + CRLF 

cQryTit +="    AND E2_NUMBOR   = ' '  " + CRLF
cQryTit +="    AND (E2_DATALIB = ' ' OR E2_DATALIB < '"+ datatu +"') " + CRLF 

cQryTit +="    AND E2_CTRPGT  = ' ' " 

cQryTit +="    AND E2_YLIBPLS IN ('L','S') " + CRLF
cQryTit +="    AND E2_CODRDA = BAU.BAU_CODIGO " + CRLF       

cQryTit +="  group by " + CRLF       
cQryTit +="             nvl(trim(bau_nfanta),bau_nome) , " + CRLF
cQryTit +="             E2_numbor ," + CRLF
cQryTit +="             nvl(substr(e2_pllote,1,6), ' ') ," + CRLF 
cQryTit +="             e2_prefixo , " + CRLF
cQryTit +="             e2_num     , " + CRLF
cQryTit +="             e2_parcela , " + CRLF
cQryTit +="             e2_tipo    , " + CRLF
cQryTit +="             e2_emis1   , " + CRLF
cQryTit +="             e2_vencrea , " + CRLF
cQryTit +="             e2_saldo   , " + CRLF
cQryTit +="             (e2_valor + e2_irrf +  e2_inss + e2_iss + e2_Vretpis +e2_vretcof+ e2_vretcsl) , " + CRLF 
cQryTit +="             (e2_valor-e2_saldo ) , " + CRLF
cQryTit +="             se2.R_E_C_N_O_ , " + CRLF
cQryTit +="             decode(substr(E2_PLLOTE,1,6) , '"+cCPTPGT+"', 'Atual','Anterior') , " + CRLF
cQryTit +="             (pci_slest0+pci_slest1+pci_slest2+pci_slest3) , " + CRLF 
cQryTit +="             pci_sldRec " + CRLF   

//IF TRIM(ORDENA) == "Vlr Maior -> Menor"                                            
   cQryTit +="  ORDER BY  3 , 10  , 2 , 1 " + CRLF  
//   cQryTit +="  ORDER BY  3 desc , 10 DESC , 2 , 1 " + CRLF    
//ELSEIF TRIM(ORDENA) ==  

 If Select((cAliasTit)) <> 0 
      
    (cAliasTit)->(DbCloseArea()) 
 
 Endif 
                            
TcQuery cQryTit New Alias (cAliasTit)  

fCCcomp()            

If ApMsgYesNo("Listar todos os Titulos selecionados ?? ","SIMNAO")
   cLisTod  := 'SIM'
Else                
   cLisTod  := 'NAO'
EndIf  
   
If ApMsgYesNo("Deseja Marcar os Titulos listados , que estao dentro do limite de liberação  ?? ","SIMNAO")
   cMarcTod := 'SIM'
Else                
   cMarcTod := 'NAO'
EndIf 

nSlRecTot := (cAliasTit)->sldtotrec    

nSlTotlib := (cAliasTit)->sldtotlib

While !(cAliasTit)->(EOF())
        
                
    If cLisTod == 'NAO'                            
    
       If cMarcTod == 'SIM'  
          lfaz := fCalcSld('1', (cAliasTit)->numlot, 2 , 0 )    
          if lfaz == .T.  
             aAdd(aRetTit,{lfaz , (cAliasTit)->nomerda , (cAliasTit)->numbor, (cAliasTit)->pref, (cAliasTit)->num  , (cAliasTit)->parc , (cAliasTit)->tipo , (cAliasTit)->emissao , (cAliasTit)->vencrea , (cAliasTit)->saldo , (cAliasTit)->vlrtot , (cAliasTit)->vlr_pgto ,(cAliasTit)->numlot , (cAliasTit)->recse2 ,(cAliasTit)->AT_ANT })
          EndIf    
       Else                                                                                                                                                                                                                                                                                                   
          lfaz := fCalcSld('1', (cAliasTit)->numlot, 2 , 0 )
          if lfaz == .T.         
             aAdd(aRetTit,{.F. , (cAliasTit)->nomerda , (cAliasTit)->numbor, (cAliasTit)->pref, (cAliasTit)->num  , (cAliasTit)->parc , (cAliasTit)->tipo , (cAliasTit)->emissao , (cAliasTit)->vencrea , (cAliasTit)->saldo , (cAliasTit)->vlrtot , (cAliasTit)->vlr_pgto ,(cAliasTit)->numlot , (cAliasTit)->recse2 ,(cAliasTit)->AT_ANT })
          EndIf 
       EndIf
       
    Else    
       
       If cMarcTod== 'SIM'
          
          lfaz := fCalcSld('1',(cAliasTit)->numlot , 2 , 0)

          aAdd(aRetTit,{lfaz , (cAliasTit)->nomerda , (cAliasTit)->numbor, (cAliasTit)->pref, (cAliasTit)->num  , (cAliasTit)->parc , (cAliasTit)->tipo , (cAliasTit)->emissao , (cAliasTit)->vencrea , (cAliasTit)->saldo , (cAliasTit)->vlrtot , (cAliasTit)->vlr_pgto ,(cAliasTit)->numlot , (cAliasTit)->recse2 ,(cAliasTit)->AT_ANT }) 

       Else 
       
          aAdd(aRetTit,{.F. , (cAliasTit)->nomerda , (cAliasTit)->numbor, (cAliasTit)->pref, (cAliasTit)->num  , (cAliasTit)->parc , (cAliasTit)->tipo , (cAliasTit)->emissao , (cAliasTit)->vencrea , (cAliasTit)->saldo , (cAliasTit)->vlrtot , (cAliasTit)->vlr_pgto ,(cAliasTit)->numlot , (cAliasTit)->recse2 ,(cAliasTit)->AT_ANT })   
	   
	   EndIF                 
   
    EndIF                	
	                     
	(cAliasTit)->(DbSkip())

EndDo

(cAliasTit)->(DbCloseArea())

If empty(aRetTit)  

    MsgAlert("Nao Dados para esta consulta "  + CRLF + " Revise seus parametros !!! ","Atencao!")
    lsai := .T.
	aAdd(aRetTit,{.F. , '' , '','', '' , '' , '', '' , '' , 0.00 , 0.00 , 0.00 ,'' , 0 ,'' })        
else            


    fhistLib(1) 
    
EndIf

Return aRetTit
        

static FUNCTION fCalcSld(cSinal , cNumlot , nOrigem , nAt)

local lfaz:= .F.

If nOrigem == 2 
  If csinal == '1'
   
     If trim(cNumlot) == trim(cCPTPGT)    

       if (nsldcomp0 - (cAliasTit)->saldo) >= 0 
           lfaz:= .T.
           nsldcomp0:= nsldcomp0 - (cAliasTit)->saldo
       Else                     
           lfaz:= .F.
       EndIf 
 
    ElseIf trim(cNumlot) == ltrim(str(cAnocomp1) + strzero((cmescomp1),2))    
       
       if (nsldcomp1 - (cAliasTit)->saldo) >= 0 
           lfaz:= .T.                              
           nsldcomp1:= nsldcomp1 - (cAliasTit)->saldo
       Else           
           lfaz:= .F.
       EndIf                    
       
    ElseIf trim(cNumlot) == ltrim(str(cAnocomp2) + strzero((cmescomp2),2))    
       
       if (nsldcomp2 - (cAliasTit)->saldo) >= 0 
           lfaz:= .T.                  
           nsldcomp2:= nsldcomp2 - (cAliasTit)->saldo
       Else           
           lfaz:= .F.
       EndIf           
             
    ElseIf trim(cNumlot) == ltrim(str(cAnocomp3) + strzero((cmescomp3),2))    
    
       if (nsldcomp3 - (cAliasTit)->saldo) >= 0 
           lfaz:= .T.                  
           nsldcomp3:= nsldcomp3 - (cAliasTit)->saldo
       Else           
           lfaz:= .F.
       EndIf         
    
    EndIf   
 
 Else 

     If trim(cNumlot) == trim(cCPTPGT)    
        
        nsldcomp0:= nsldcomp0 + (cAliasTit)->saldo      
     
     ElseIf trim(cNumlot) == ltrim(str(cAnocomp1) + strzero((cmescomp1),2))    
       
        nsldcomp1:= nsldcomp1 + (cAliasTit)->saldo
       
     ElseIf trim(cNumlot) == ltrim(str(cAnocomp2) + strzero((cMescomp2),2))    
       
        nsldcomp2:= nsldcomp2 + (cAliasTit)->saldo
             
     ElseIf trim(cNumlot) == ltrim(str(cAnocomp3) + strzero((cMescomp3),2))    
    
        nsldcomp3:= nsldcomp3 + (cAliasTit)->saldo
          
     EndIf         
    
     lfaz:= .T.
  EndIf
///////

Else 
  If csinal == '1'
   
     If trim(cNumlot) == trim(cCPTPGT)    

       if (nsldcomp0 - aBrwTit[oBrwTit:nAt,10]) >= 0 
           lfaz:= .T.
           nsldcomp0:= nsldcomp0 - aBrwTit[oBrwTit:nAt,10]       
  
       Else                                                                     
           lfaz:= .F.
       EndIf 
 
    ElseIf trim(cNumlot) == ltrim(str(cAnocomp1) + strzero((cmescomp1),2))    
       
       if (nsldcomp1 - aBrwTit[oBrwTit:nAt,10]) >= 0 
           lfaz:= .T.                              
           nsldcomp1:= nsldcomp1 - aBrwTit[oBrwTit:nAt,10] 
            
       Else           
           lfaz:= .F.
           nsldcomp1:= nsldcomp1 + aBrwTit[oBrwTit:nAt,10] 
           
       EndIf                    
       
    ElseIf trim(cNumlot) == ltrim(str(cAnocomp2) + strzero((cmescomp2),2))    
       
       if (nsldcomp2 - aBrwTit[oBrwTit:nAt,10]) >= 0 
           lfaz:= .T.                  
           nsldcomp2:= nsldcomp2 - aBrwTit[oBrwTit:nAt,10]
           
       Else           
           lfaz:= .F.                                      
           nsldcomp1:= nsldcomp1 + aBrwTit[oBrwTit:nAt,10] 
           
       EndIf           
             
    ElseIf trim(cNumlot) == ltrim(str(cAnocomp3) + strzero((cmescomp3),2))    
    
       if (nsldcomp3 - aBrwTit[oBrwTit:nAt,10]) >= 0 
           lfaz:= .T.                  
           nsldcomp3:= nsldcomp3 - aBrwTit[oBrwTit:nAt,10]
            
       Else           
           lfaz:= .F.
           nsldcomp1:= nsldcomp1 + aBrwTit[oBrwTit:nAt,10] 
         
       EndIf         
    
    EndIf                                      
    
  //    fhistLib(2) 
 Else 

     If trim(cNumlot) == trim(cCPTPGT)                                                               
        
        nsldcomp0:= nsldcomp0 + aBrwTit[oBrwTit:nAt,10]      
          
     
     ElseIf trim(cNumlot) == ltrim(str(cAnocomp1) + strzero((cmescomp1),2))    
       
        nsldcomp1:= nsldcomp1 + aBrwTit[oBrwTit:nAt,10] 
        
       
     ElseIf trim(cNumlot) == ltrim(str(cAnocomp2) + strzero((cMescomp2),2))    
       
        nsldcomp2:= nsldcomp2 + aBrwTit[oBrwTit:nAt,10] 
             
     ElseIf trim(cNumlot) == ltrim(str(cAnocomp3) + strzero((cMescomp3),2))    
    
        nsldcomp3:= nsldcomp3 + aBrwTit[oBrwTit:nAt,10] 
                
     EndIf         
  
        lfaz:= .T.
//        fhistLib(2) 
     
 EndIf
   
EndIf   

RETURN(lfaz)


/***************************************************************************************/    
Static Function fCCcomp()

 cAnocomp0 := val(substr(cCPTPGT,1,4)) 
 cMescomp0 := val(substr(cCPTPGT,5,2)) 
 nsldcomp0 := (cAliasTit)->sldcmp0

 cAnocomp1 := val(substr(cCPTPGT,1,4)) 
 cMescomp1 := val(substr(cCPTPGT,5,2)) 
 nsldcomp1 := (cAliasTit)->sldcmp1

 cAnocomp2 := val(substr(cCPTPGT,1,4)) 
 cMescomp2 := val(substr(cCPTPGT,5,2)) 
 nsldcomp2 := (cAliasTit)->sldcmp2

 cAnocomp3 := val(substr(cCPTPGT,1,4)) 
 cMescomp3 := val(substr(cCPTPGT,5,2)) 
 nsldcomp3 := (cAliasTit)->sldcmp3

If cMescomp0 - 1 == 0
   cMescomp1 := 12
   cAnocomp1 := cAnocomp0 -1
else 
   cMescomp1 := cMescomp0 - 1
   cAnocomp1 := cAnocomp0 
EndIf   

If cMescomp1 - 1 == 0
   cMescomp2 := 12
   cAnocomp2 := cAnocomp1 -1
else 
   cMescomp2 := cMescomp1 - 1
   cAnocomp2 := cAnocomp1 
EndIf   

If cMescomp2 - 1 == 0
   cMescomp3 := 12
   cAnocomp3 := cAnocomp2 -1
else 
   cMescomp3 := cMescomp2 - 1
   cAnocomp3 := cAnocomp2 
EndIf  
 

Return ()
                         
Static Function fhistLib(ntpAray)                           
local nI      
                                           
nliberado := 0
nAliberar := 0
   	
  if ntpAray == 2  	
		For nI := 1 to len(aBrwTit)  
		
		    If aBrwTit[nI,1] == .T.
               nliberado := nliberado + aBrwTit[nI,10] 
			EndIf    
	
		Next      
  Else 		      
  		For nI := 1 to len(aRetTit)  
		
		    If aRetTit[nI,1] == .T.
               nliberado := nliberado +  aRetTit[nI,10] 
			EndIf    
	
		Next      
  EndIf 		
  
   	    nAliberar := nSlRecTot - nliberado

nSlRecTot1 := Transform( nSlRecTot , "@R  999,999,999.99")                             

nliberado1 := Transform( nliberado , "@R  999,999,999.99")
nAliberar1 := Transform( nAliberar , "@R  999,999,999.99")
nSlTotlib1 := Transform( nSlTotLib , "@R  999,999,999.99")      

    MsgAlert(" Saldo Total da Receita       :"+  nSlRecTot1  + CRLF +;  
             " Valor Liberado               :"+  nliberado1  + CRLF +; 
             " Saldo a Librarar             :"+  nAliberar1  + CRLF +;
             " Vlr Tot Possivel de Liberação:"+  nliberado1  + CRLF + "  " , " Resumo da Liberação") 
             
Return ()

Static Function AjustaSX1()

Local aHelp 	:= {}

aHelp := {}
aAdd(aHelp, "Informe o numero do Bordero  ")
PutSX1(cPerg , "01" , "Num Bordero " 	,"","","mv_ch1","C",6,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aAdd(aHelp, "Informe o Codigo do RDA ")
PutSX1(cPerg , "02" , "Codigo do Rda " 	,"","","mv_ch2","C",6,0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aAdd(aHelp, "Data do Bordero  , Data da Criação do Bordero ")
PutSX1(cPerg , "03" , "Dt Bordero "     ,"","","mv_ch3","D",8,0,0,"G","","","","","mv_par03"," ","","",""," ","",""," ","","","","","","","","",aHelp,aHelp,aHelp)
 
aAdd(aHelp, "Nova Data de Vencimento , Data para prorogação do vencimento do titulo selecionado  ")
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

Return  
        
user function fFazexcel(CPTPGT)
   local cNomDadCab:=  'Relação de Titulos Liberados para Pagamento '
   local cComp     :=  CPTPGT
   local cNomPla   := 'Liberação De Pagamentos '                   
   local cvlrtot   := Transform(0.00 ,'@E  999,999,999.99')    
   
   
cQrySe2 := " SELECT e2_prefixo || e2_num || e2_Parcela||e2_tipo  titulo ,"  + CRLF   
cQrySe2 += "        e2_fornece ||' - '|| e2_nomfor fornece ,"  + CRLF 
cQrySe2 += "        substr(e2_emissao,7,2)||'/'|| substr(e2_emissao,5,2)||'/'||substr(e2_emissao,1,4) EMISSAO , "    
cQrySe2 += "        substr(e2_vencrea,7,2)||'/'|| substr(e2_vencrea,5,2)||'/'||substr(e2_vencrea,1,4) VENCREA , "    
cQrySe2 += "        substr(e2_datalib,7,2)||'/'|| substr(e2_datalib,5,2)||'/'||substr(e2_datalib,1,4) DATALIB ,"     
cQrySe2 += "        e2_saldo SALDO ,  E2_PLLOTE PLLOTE , " 
cQrySe2 += "       (e2_saldo + e2_irrf + e2_inss + e2_iss + e2_vretpis + e2_vretcof + e2_vretcsl) VLRTOT "   

cQrySe2 += "   FROM " +RetSqlName('SE2')+ " SE2 " + CRLF 
cQrySe2 += "  WHERE E2_FILIAL  ='"+ xFilial('SE2') +"' AND SE2.D_E_L_E_T_ = ' ' " + CRLF 
cQrySe2 += "    AND e2_ctrpgt =  '"+PCI->PCI_CPTPGT + substr(PCI->PCI_DESCPG,1,4) + trim(PCI->PCI_CLSRED) + strzero(PCI->PCI_SEQ,2) +"'"  + CRLF    
   
If Select((cAliasSe2)) <> 0 

   (cAliasSe2)->(DbCloseArea()) 

Endif           
                        
TcQuery cQrySe2 New Alias (cAliasSe2)
   
     	cNomeArq := "C:\TEMP\"+PCI->PCI_CPTPGT +" - "+SubStr(DtoS(date()),1,4)+"_"+STRTRAN(TIME(),":","_")+".csv"
		nHandle := FCREATE(cNomeArq)
        cMontaTxt := cNomDadCab
        cMontaTxt += CRLF
        FWrite(nHandle,cMontaTxt)        		 
        cMontaTxt := 'Referencia : '+cComp
        cMontaTxt += CRLF
        FWrite(nHandle,cMontaTxt)		 
        cMontaTxt := 'Planilha : '+cNomPla  
        cMontaTxt += CRLF
        FWrite(nHandle,cMontaTxt)		

        cMontaTxt := "Titulo   ;"
		cMontaTxt += "Fornecedor  ;"            
		cMontaTxt += "Dt. Emissao  ;" 		
		cMontaTxt += "Dt. Vencimento ;" 
		cMontaTxt += "Dt. Liberação  ;" 		
		cMontaTxt += "Valor Liquido  ;" 
		cMontaTxt += "Valor Bruto    ;"   
		
		cMontaTxt += CRLF // Salto de linha para .csv (excel)
             
		FWrite(nHandle,cMontaTxt)
		pvez := .F.            
		
		
 
  Do  While !((cAliasSe2)->(Eof())) 
          cvlrtot:= Transform(((cAliasSe2)->VLRTOT ),'@E  999,999,999.99')	
          cSaldo := Transform(((cAliasSe2)->SALDO  ),'@E  999,999,999.99')
   		  cMontaTxt := (cAliasSe2)->Titulo  + ";"  
   		  cMontaTxt += (cAliasSe2)->fornece + ";"  
   		  cMontaTxt += (cAliasSe2)->emissao + ";"   
   		  cMontaTxt += (cAliasSe2)->vencrea + ";"   
   		  cMontaTxt += (cAliasSe2)->datalib + ";"  
          cMontaTxt += cSaldo + ";" 
          cMontaTxt += cvlrtot
          
    	  cMontaTxt += CRLF // Salto de linha para .csv (excel)      
		    
		  FWrite(nHandle,cMontaTxt)  
		  
	  	(cAliasSe2)->(DbSkip())
	
    EndDo                                                                    
    	If nHandle > 0	
   		   FClose(nHandle)
        EndIf   
        	
    MsgAlert("Planilha Eletronica Disponivel e, : "+cNomeArq +" ","Atencao!")
   
Return()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ tranmiste email                                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Static Function fEnvEmail( cRda )

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
Local _cTo  	     := cDest //"altamiro@caberj.com.br "
Local _cCC         := " "  //GetMv( "MV_WFFINA" )
Local _cAssunto    := " Alteração de Vencimento  "
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
   