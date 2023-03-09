#Define CRLF Chr(13)+Chr(10)
#INCLUDE "PROTHEUS.ch"                                                                                                                                  
#INCLUDE "TOPCONN.ch"
#INCLUDE "PLSMGER.CH"                                                                                               
#Include "Ap5Mail.Ch"    
/*--------------------------------------------------------------------------
| Programa  | CABA118  | Autor | Altamiro	Affonso    | Data | 07/11/2016  |
|---------------------------------------------------------------------------|              
| Descricao | Controle de exposição no site                                 |
|           |                                                               |                                                       
|---------------------------------------------------------------------------|
| Uso       | operacional do contas medicas ou financeiro                   | 
 --------------------------------------------------------------------------*/

User Function CABA118

local cRda      := ' ' 
local cNivel    := ' '
local nI        := 0        
private lsai    := .F.        
Private cCadastro := OemToAnsi("Liberação paro Exibição No Site") 
/*
Private aBrwLin 
Private aCabLin		:= {"Evento", "Loc Dig","Cod Tit","Num.Guia","Origem", "Linha" , "Cod Unm" , "Tbl", "Matricula ","Dt Proc","Proced." , "vlrpag", "Vlr Apres", "Vlr Glo" , "Vlr Unit","Qtd proc"}
Private aTamLin		:= {70,20,20,20,20,20,20,15,20,20,80,40,40,40,40,10}      
//Private aTamLin		:= {80,15,20,20,15,15,15,10,15,15,90,40,40,40}

Private aBrwDem 
Private aCabDem		:= {" " , "Rda","Evento", "Lote Custo" ,  "Comp ent" , "Empresa","Tipo Custo", "Valor" , "Aprovador","Status", "Projeto" }
Private aTamDem		:= {15,120,120,40,30,30,30,40,20,30,25}

private aBrwTit
Private aCabTit		:= {" ", " ","Rda","Grp Pag","Vlr Fat.Amb","Vlr Fat.Hosp","Vlr 31/2 Amb","Vlr 31/2 Hosp", "Vlr Não liberado" , "Vlr Total" , "Vlr Previa", "Lib/Pend" , "Nvl"}
Private aTamTit		:= {15,15,100,120,45,45,45,45,45,45,45,40,10}            
*/
private aBrwTit                  
Private aCabTit		:= {" ", " ","Cod Rda","nome Rda" , "Num Lote ", "Ano Comp" , "Mes Comp" , "Emit NF" ,"Grupo Pagto" , "Vlr Tit" ,"Saldo Tit", "Vlr Total" ,"Liberador","Data Digit", "Tip Pessoa" ,"Controle"}  
Private aTamTit		:= {15,15,25,80,20,20,20,20,100,35,35,35,50,40,45 ,10} 

Private oOk      	:= LoadBitMap(GetResources(),"LBOK")
Private oNo      	:= LoadBitMap(GetResources(),"LBNO")

Private oVerde   	:= LoadBitMap(GetResources(),"ENABLE")
Private oVermelho	:= LoadBitMap(GetResources(),"DISABLE")    
Private oAmarelo	:= LoadBitMap(GetResources(),"BR_AMARELO")

Private aObjects 	:= {}

Private aSizeAut 	:= MsAdvSize() 

private cQryAMP     := ' '     

Private cPerg	    := "CABA118"     

private cIdusr      := SubStr(cUSUARIO,1,06)              

AjustaSX1()

Pergunte(cPerg,.T.)    
                     
 
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

oDlg  		:= MsDialog():New( aSizeAut[7],00,aSizeAut[3]-100,aSizeAut[5]-10,"Liberação de Consulta no Site ",,,.F.,,,,,,.T.,,,.T. ) 

oSayTit    	:= TSay():New( aPosObj[1][1],aPosObj[1][2],{||'Libera Consulta no Site '},oDlg,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,236,016)

bDbClickTit	:= {||aBrwTit[oBrwTit:nAt,1] := !aBrwTit[oBrwTit:nAt,1], oBrwTit:Refresh()}   

//bChangeTit	:= {||AtuBrwGuia(aBrwTit[oBrwTit:nAt,2],aBrwTit[oBrwTit:nAt,3])}

//oBrwTit 	:= TcBrowse():New(aPosObj[1][1]+10,aPosObj[1][2],aPosObj[1][4],aPosObj[1][3],,aCabTit,aTamTit,oDlg,,,,bChangeTit,bDbClickTit,,,,,,,.F.,,.T.,,.F.,,, )

oBrwTit 	:= TcBrowse():New(aPosObj[1][1]+10,aPosObj[1][2],aPosObj[1][4],aPosObj[1][3],,aCabTit,aTamTit,oDlg,,,,,bDbClickTit,,,,,,,.F.,,.T.,,.F.,,, )

dDatDig := stod(aBrwTit[oBrwTit:nAt,14])  

oBrwTit:SetArray(aBrwTit) 
oBrwTit:bLine := {||{If(aBrwTit[oBrwTit:nAt,1],oOk,oNo) ,;
                     If(aBrwTit[oBrwTit:nAt,13] == 0, oVerde  ,If((aBrwTit[oBrwTit:nAt,10] == 0 .or. (trim(aBrwTit[oBrwTit:nAt,8]) == 'Sim' .and. aBrwTit[oBrwTit:nAt,15]== 'J')), oVermelho, oAmarelo )),;                                                           
   		                   aBrwTit[oBrwTit:nAt, 2]		                	 ,;
				           aBrwTit[oBrwTit:nAt, 3]                           ,; 
		                   aBrwTit[oBrwTit:nAt, 5]		                	 ,;
				           aBrwTit[oBrwTit:nAt, 6]                           ,;
		                   aBrwTit[oBrwTit:nAt, 7]		                	 ,;
			          trim(aBrwTit[oBrwTit:nAt, 8])                          ,;                                            
		              trim(aBrwTit[oBrwTit:nAt, 4])                	         ,;
                 Transform(aBrwTit[oBrwTit:nAt, 9],'@E  999,999,999.99')     ,; 
	  	    	 Transform(aBrwTit[oBrwTit:nAt,10],'@E  999,999,999.99')     ,;
	  	    	 Transform(aBrwTit[oBrwTit:nAt,11],'@E  999,999,999.99')     ,;	  	    	 	  	    	 
		 	          trim(aBrwTit[oBrwTit:nAt,12])                          ,;         
	 	                   dDatDig                                           ,;
		 	           iif(aBrwTit[oBrwTit:nAt,15]== 'F','Fisica','Juridica'),; 
		 	               aBrwTit[oBrwTit:nAt,13]                           }}         
		 	     

oBrwTit:nScrollType  := 1 // Scroll VCR


lConfirmou 	:= .F. 

 
aBut    :={{"PENDENTE", {||marca(),oBrwTit:Refresh()       }	, "Marcar Todos "       , "Marcar Todos"        } }
aAdd(aBut, {"PENDENTE", {||desmarca(),oBrwTit:Refresh()    }	, "DesMarcar Todos "	, "DesMarcar Todos" 	} )
aAdd(aBut, {"PENDENTE", {||fDeleta(),oBrwTit:Refresh()     }	, "Cancelar Exibição "  , "Cancelar Exibição"   } )     
aAdd(aBut, {"PENDENTE", {||Caba118Leg(),oBrwTit:Refresh()  }	, "Exibir Legenda "     , "Exibir Legenda "     } ) 


 bOk 	:= {|| lConfirmou := .T. , fGravaPBE(), desmarca() , oBrwTit:Refresh()   }    
//  bOk 	:= {||lConfirmou := .T., atrbalcada(),oDlg:End()}   
bCancel := {||lConfirmou := .F.,oDlg:End()}

	
oDlg:Activate(,,,.T.,,,EnchoiceBar(oDlg,bOk,bCancel,,aBut))

If lConfirmou  
	
    For nI := 1 to len(aBrwTit)

	   If aBrwTit[nI,1] == .T.
             cRda+= 'Rda         : ' +  aBrwTit[nI,2] + CRLF   	         
             cRda+= 'Titulo      : ' +  aBrwTit[nI,4] +aBrwTit[nI,5] +aBrwTit[nI,6] +aBrwTit[nI,7] + CRLF    			 
             cRda+= 'Saldo       : R$' +  Transform(aBrwTit[oBrwTit:nAt,10],'@E  999,999,999.99')   + CRLF   
             cRda+= 'Venc. Original : ' + aBrwTit[nI,9] + CRLF  
             cRda+= 'Venc. Prorogado: ' + dDtPror + CRLF 
             cRda+= '________________________________________________________________' + CRLF  
	        EndIf
	        
	Next
	If !empty(trim(cRda))
       fEnvEmail( cRda ) 	
    EndIf     
	MsgInfo("Processo finalizado")

	
EndIf

Return    

Static Function fGravaPBE()

Local nI := 0
	       
 	
   dBSelectArea("PBE")
	
	For nI := 1 to len(aBrwTit)  

	   If aBrwTit[nI,1] == .T. 
	      
	      if aBrwTit[nI,13] != 0 
	   
             MsgAlert("Registro Já Existe  "  + CRLF + " Já liberado no Site !!! "  + CRLF +"cod Rda : " + aBrwTit[nI,2] + CRLF +"Num lote : " + aBrwTit[nI,5],"Atencao!")
             
          else
  
        	   a:='b'
   	  
//    Private aCabTit		:= {" ", "Cod Rda","nome Rda" , "Num Lote ", "Ano Comp" , "Mes Comp" , "Emit NF" ,"Grupo Pagto" , "Vlr Tit" ,"Saldo Tit", "Vlr Total" ,"Liberador", "Controle"}  
//	aAdd(aRetTit,{.F. , cAliasTit->codrda , cAliasTit->nomerda , cAliasTit->grppag , cAliasTit->nlot , cAliasTit->anolot , cAliasTit->meslot , cAliasTit->EmNf , cAliasTit->vlr_liq , cAliasTit->Saldo , cAliasTit->vlr_bruto , cAliasTit->IdLib , cAliasTit->pbe_rec })
	   
       RecLock( "PBE" , .T. )
	  
       PBE->PBE_GRPPAG   := SUBSTR(aBrwTit[oBrwTit:nAt, 4],1,4)         
       PBE->PBE_ANO      := aBrwTit[oBrwTit:nAt, 6]
       PBE->PBE_MES      := aBrwTit[oBrwTit:nAt, 7]
       PBE->PBE_DATA     := Iif(trim(dtos(mv_par08))== '' , dDataBase , mv_par08)
       PBE->PBE_USUARI   := SubStr(cUSUARIO,7,15)
       PBE->PBE_DATDIG   := dDataBase       
       PBE->PBE_CODRDA   := aBrwTit[oBrwTit:nAt, 2]
       PBE->PBE_NUMLOT   := aBrwTit[oBrwTit:nAt, 5]

       Msunlock("PBE")	        
	      
     
	      EndIf   

       EndIf   
       
       lConfirmou 	:= .T. 

	Next 

   lConfirmou 	:= .F.
 
	
RETURN()	

Static Function fDeleta  
//If  cIdusr $ cautdel

    dbselectarea("PBE")                  
 
 	For nI := 1 to len(aBrwTit)  

   If aBrwTit[nI,1] == .T.   // .and. cIdusr $ cautdel
      If (aBrwTit[nI,13] != 0  .AND. aBrwTit[nI,10] != 0 .AND. trim(aBrwTit[nI,8]) == 'Não')
          


         DbGoto(aBrwTit[nI,13])         
       
         RecLock("PBE",.F.)
           dbdelete()
         Msunlock("PBE")
            
        
      Else    
         MsgAlert("Registro nao pode ser excluido   "  + CRLF + " Revise seus parametros !!! ","Atencao!")	
      Endif  
   EndIf
 next
//Else 
//   MsgAlert("Usuario sem Premissão de Cancelar Expossição no site   "  ,"Atencao!")	    
//EndIf 
RETURN()	
	
***********************************************************************************
Static Function marca
	
local nI
		
		For nI := 1 to len(aBrwTit) 
    		
    		If(aBrwTit[nI,10] != 0 .and. (trim(aBrwTit[nI,8]) == 'Não' .or. aBrwTit[nI,15]== 'F'))
	
		        aBrwTit[nI,1]:= .T.              
		     
		    EndIf     
			
		Next
		
	RETURN()	
	
Static Function desmarca
	
local nI
		
		For nI := 1 to len(aBrwTit)
	
			   aBrwTit[nI,1]:= .F.
	
		Next

RETURN()	
/***************************************************************************/

Static Function aDadosTit

Local aRetTit	:= {}
Local cQryTit	:= ""
Local cAliasTit	:= GetNextAlias()
local i

ProcRegua(0) 

nCont := 0

for i:=1 to 5
    IncProc('Buscando Dados no Servidor ...')
next             

cQryTit :=" SELECT bau_codigo codrda , " + CRLF
cQryTit +="        nvl(trim(bau_nfanta),bau_nome) nomerda  , " + CRLF
cQryTit +="        e2_pllote nlot , " + CRLF  
cQryTit +="        substr(e2_pllote,1,4) anolot , substr(e2_pllote,5,2) meslot ," + CRLF   
cQryTit +="        decode(e2_ylibpls, 'N','Não','Sim') EmNf , " + CRLF 
cQryTit +="        substr(BAU_GRPPAG||' - ' || B16_DESCRI,1,30) grppag , " + CRLF
cQryTit +="        e2_valor vlr_liq , " + CRLF 
cQryTit +="        e2_saldo saldo ," + CRLF            

cQryTit +="       (e2_valor + e2_inss + e2_irrf + e2_vretpis + e2_vretcof + e2_vretcsl) vlr_bruto , " + CRLF
cQryTit +="        nvl(substr(pbe_usuari,1,20), ' ' ) IdLib , " + CRLF
cQryTit +="        nvl(pbe.R_e_c_n_o_ , 0 ) pbe_rec ," + CRLF      
cQryTit +="        nvl(pbe_datdig , ' '  ) pbe_datdig ,  " + CRLF
cQryTit +="        bau_tippe tppesoa " + CRLF            

cQryTit +="   FROM "+RetSqlName('PBE')+ " PBE  , " +RetSqlName('SE2')+ " SE2 , " +RetSqlName('BAU')+ " BAU , " +RetSqlName('B16')+ " B16 " + CRLF
cQryTit +="  WHERE PBE_FILIAL(+)  = '" + xFilial('PBE') + "'  AND PBE.D_E_L_E_T_(+) = ' ' " + CRLF 
cQryTit +="    AND E2_FILIAL      = '" + xFilial('SE2') + "'  AND SE2.D_E_L_E_T_ = ' ' " + CRLF 
cQryTit +="    AND BAU_FILIAL     = '" + xFilial('BAU') + "'  AND BAU.D_E_L_E_T_ = ' ' " + CRLF  
cQryTit +="    AND B16_FILIAL     = '" + xFilial('B16') + "'  AND B16.D_E_L_E_T_ = ' ' " + CRLF  

cQryTit +="    AND E2_PLLOTE LIKE '"+mv_par01+'%'+ "' " + CRLF

If !empty(trim(mv_par02))
     cQryTit += " AND BAU_GRPPAG  =  '" + MV_PAR02 + "' " + CRLF    
EndIf 

cQryTit +="    AND BAU_GRPPAG = B16_CODIGO " + CRLF             
If mv_par09 == 2
   cQryTit +="    AND (BAU_TIPPE  = 'J' or BAU_TIPPE  = 'j') " + CRLF
ElseIf mv_par09 == 1
   cQryTit +="    AND (BAU_TIPPE  = 'F' or BAU_TIPPE  = 'f') " + CRLF
EndIf                                                     

If mv_par10 == 1
   cQryTit +="    AND (e2_ylibpls  <> 'N' or BAU_TIPPE  <> 'n') " + CRLF
ElseIf mv_par10 == 2
   cQryTit +="    AND (e2_ylibpls  = 'N' or BAU_TIPPE  = 'n') " + CRLF
EndIf                                                     

cQryTit +="    AND e2_codrda = bau_codigo  " + CRLF 
cQryTit +="    AND E2_TIPO   = 'FT'   " + CRLF 
cQryTit +="    AND PBE_DATDIG(+)<=TO_CHAR(SYSDATE,'YYYYMMDD') " + CRLF          
cQryTit +="    AND PBE_NUMLOT(+) = E2_pllote   " + CRLF             
cQryTit +="    AND PBE_CODRDA(+)= E2_codrda    " + CRLF
cQryTit +="    AND PBE_ANO(+) = '"+substr(mv_par01,1,4)+"' " + CRLF
cQryTit +="    AND PBE_MES(+) = '"+substr(mv_par01,5,2)+"' " + CRLF 
                                                                          
If !empty(trim(mv_par03))
     cQryTit +=" AND BAU_CODIGO >= '"+mv_par03+"' AND BAU_CODIGO <= '"+mv_par04+"' " + CRLF      
EndIf                                        
                                             
If !empty(trim(mv_par05))
     cQryTit +=" AND E2_PLLOTE = '"+mv_par05+"' " + CRLF      
EndIf                                        

If !empty(trim(DtoS(mv_par06)))
     cQryTit +=" AND E2_EMISSAO >= '"+DtoS(mv_par06)+"' AND E2_EMISSAO <= '"+DtoS(mv_par07)+"' " + CRLF      
EndIf                                        

cQryTit +="    ORDER BY 2 , 1 " + CRLF                         
                              
                        
TcQuery cQryTit New Alias cAliasTit

While !cAliasTit->(EOF())

	aAdd(aRetTit,{.F.                  ,;
	              cAliasTit->codrda    ,;
	              cAliasTit->nomerda   ,;
	              cAliasTit->grppag    ,;
	              cAliasTit->nlot      ,;
	              cAliasTit->anolot    ,;
	              cAliasTit->meslot    ,;
	              cAliasTit->EmNf      ,;
	              cAliasTit->vlr_liq   ,;
	              cAliasTit->Saldo     ,;
	              cAliasTit->vlr_bruto ,; 
	              cAliasTit->IdLib     ,; 
	              cAliasTit->pbe_rec   ,;
	              cAliasTit->pbe_datdig,;
	              cAliasTit->tppesoa })
	                                    
	cAliasTit->(DbSkip())

EndDo
  
cAliasTit->(DbCloseArea())

If empty(aRetTit)  

    MsgAlert("Nao Dados para esta consulta "  + CRLF + " Revise seus parametros !!! ","Atencao!")
    lsai := .T.
        
	RETURN() 

//	aAdd(aRetTit,{.F.,'','','','','','','','','0.00','0.00','0.00','',''})
EndIf

Return aRetTit


/***************************************************************************************/
Static Function AjustaSX1()

Local aHelp 	:= {}

aHelp := {}

aAdd(aHelp, "Informe a competencia do Custo(AAAAMM) ")
PutSX1(cPerg , "01" , "Compet. do Custo (AAAAMM) " 	,"","","mv_ch1","C",6,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe o numero do Grupo de pagamento  ")                                                
PutSX1(cPerg , "02" , "Grupo de pagamento " 	,"","","mv_ch2","C",4,0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)
           
aHelp := {}
aAdd(aHelp, "Informe o Codigo do RDA de ")
PutSX1(cPerg , "03" , "Codigo do Rda de " 	,"","","mv_ch3","C",6,0,0,"G","","","","","mv_par03","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp) 
aHelp := {}
aAdd(aHelp, "Informe o Codigo do RDA ate ")
PutSX1(cPerg , "04" , "Codigo do Rda ate " 	,"","","mv_ch4","C",6,0,0,"G","","","","","mv_par04","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)
 
aHelp := {}
aAdd(aHelp, "Informe o Numero do lote  de pagamentno  ")
PutSX1(cPerg , "05" , "Num. Lote pagamento  " 	,"","","mv_ch5","C",10,0,0,"G","","","","","mv_par05","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Data do faturamento de , Data da Criação do lote de pagamento ")
PutSX1(cPerg , "06" , "Dt do Lote de Pagamento de "     ,"","","mv_ch6","D",8,0,0,"G","","","","","mv_par06"," ","","",""," ","",""," ","","","","","","","","",aHelp,aHelp,aHelp) 
aHelp := {}
aAdd(aHelp, "Data do faturamento ate , Data da Criação do lote de pagamento ")
PutSX1(cPerg , "07" , "Dt do Lote de Pagamento ate "     ,"","","mv_ch7","D",8,0,0,"G","","","","","mv_par07"," ","","",""," ","",""," ","","","","","","","","",aHelp,aHelp,aHelp)

aHelp := {} 
aAdd(aHelp, "Data apattir , que sera possovel a visualização no site  , Data , apartir dela ,que sera possivel a visualização no site")
PutSX1(cPerg , "08" , "Data para visualização no site ","","","mv_ch8","D",8,0,0,"G","","","","","mv_par08"," ","","",""," ","",""," ","","","","","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Listar Pessoas fisicas , juridicas ou Todas   ")
PutSX1(cPerg,"09", "Tipo da Pessoa ","","","mv_ch9","N",1,0,1,"C","","","","","mv_par09","Fisica "	,"","","","Juridica ","","","Todos","","","","","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Listar Com NF Emitida , Não Emitida ou Todas  ")
PutSX1(cPerg,"10", "Nf Emitida  ","","","mv_ch10","N",1,0,1,"C","","","","","mv_par10","Emitidas "	,"","","","Não Emitidas","","","Todos","","","","","","","","",aHelp,aHelp,aHelp)

/*
aAdd(aHelp, "Nova Data de Vencimento , Data para prorogação do vencimento do titulo selecionado  ")
PutSX1(cPerg , "04" , "Nova Dt de Venc ","","","mv_ch4","D",8,0,0,"G","","","","","mv_par04"," ","","",""," ","",""," ","","","","","","","","",aHelp,aHelp,aHelp)


aAdd(aHelp, "Origem dos Titulos, Contas Medicas ou OPME ")
PutSX1(cPerg,"05", "Origem  ","","","mv_ch5","N",1,0,1,"C","","","","","mv_par05","Contas Medica"	,"","","","OPME ","","","Todos","","","","","","","","",aHelp,aHelp,aHelp)

aAdd(aHelp, "Opcao Procedimento")
PutSX1(cPerg,"04", "Valor Maximo ","","","mv_ch4","N",13,2,1,"G","","","","","mv_par04",""	,"","","","","","",""	,"","","","","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Operado , 001250 - Milena ")
aAdd(aHelp, "          001240 - Dr. Douglas")
aAdd(aHelp, "          000271 - Dra. Carla")
aAdd(aHelp, "          000029 - Dr. J.Macedo")
PutSX1(cPerg , "05" , "Operado " 	,"","","mv_ch5","C",6,0,0,"G",""	,"","","","mv_par05","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aAdd(aHelp, "Ordernar Por Rda , Grupo de Pagto ")
PutSX1(cPerg,"06", "Listar  ","","","mv_ch6","N",1,0,1,"C","","","","","mv_par06","Pagto <= Previa ","","","","Pagto > Previa ","","","+ 1 Competencia","","","Todos","","","Maiores Ofensores","","",aHelp,aHelp,aHelp)

aAdd(aHelp, "Considere so a Competencia De Entrada  para liberar ")
PutSX1(cPerg,"07", "Cons. só Competencia de Entrada","","","mv_ch7","N",1,0,1,"C","","","","","mv_par07","Sim "	,"","","","Não ","",""," ","","","","","","","","",aHelp,aHelp,aHelp)

aAdd(aHelp, "Data de Procedimento Inicial , limite inferior da Data de procedimento ")
PutSX1(cPerg,"08", "Dt procedimento De ?","","","mv_ch8","D",8,0,0,"G","","","","","mv_par08"," ","","",""," ","",""," ","","","","","","","","",aHelp,aHelp,aHelp)

aAdd(aHelp, "Data de Procedimento Final , limite sUPERIOR da Data de procedimento ")
PutSX1(cPerg,"09", "Dt procedimento Ate ?","","","mv_ch9","D",8,0,0,"G","","","","","mv_par09"," ","","",""," ","",""," ","","","","","","","","",aHelp,aHelp,aHelp)

aAdd(aHelp, "Listar sem recuso de glosa , só recurso de glosa ou não considera ")
PutSx1(cPerg,"10",OemToAnsi("Com Recurso de Glosa ")         ,"","","mv_ch10","N",01,0,0,"C","","","","","mv_par10","Sem Rec.de glosa","","","","Só Rec. de glosa","","","Todas","","","","","","","","",{},{},{})  

aAdd(aHelp, "Liberar Pagto quando sim mostrar so que tem valor a liberar , quando não lista todos dos itens do custo  ")
PutSx1(cPerg,"11",OemToAnsi("Ação  ")         ,"","","mv_ch11","N",01,0,0,"C","","","","","mv_par11","Lib. Pgto ","","","","Auditoria","","","","","","","","","","","",{},{},{})  

aAdd(aHelp, "Listar So Projeto , Sem Projeto , Não Considera  ")
PutSx1(cPerg,"12",OemToAnsi("Listar Projeto ? ")         ,"","","mv_ch12","N",01,0,0,"C","","","","","mv_par12","Só Projeto ","","","","Sem Projeto ","","","Todas","","","","","","","","",{},{},{})  

aAdd(aHelp, "Informe Grupo de Pagamento , Em branco lista todos ")
PutSX1(cPerg,"13", "Grupo de Pagamento , P/Todos Não Informar ","","","mv_ch13","C",4,0,1,"G","","","","","mv_par13"," ","","",""," ","",""," ","","","","","","","","",aHelp,aHelp,aHelp)
*/
Return

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Formata textos das caixas multiget                                  ³
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

//************************
static Function Caba118Leg()
//************************
	BrwLegenda(cCadastro, "Legenda", {	{"BR_VERDE"		, "Apto a Incluir "	     			  },;
										{"BR_AMARELO"	, "Incluido e pode ser Excluido."	  },;
										{"BR_VERMELHO"	, "Incluido e NÃO pode ser Excluido." }})

Return Nil
   