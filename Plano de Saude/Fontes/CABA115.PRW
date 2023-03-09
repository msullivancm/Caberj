#Define CRLF Chr(13)+Chr(10)
#INCLUDE "PROTHEUS.ch"                                                                                                                                  
#INCLUDE "TOPCONN.ch"
#INCLUDE "PLSMGER.CH"
#Include "Ap5Mail.Ch"    
/*--------------------------------------------------------------------------
| Programa  | CABA111  | Autor | Altamiro	Affonso    | Data | 07/11/2016  |
|---------------------------------------------------------------------------|              
| Descricao | troca Data de vencimento real de titulos do contas medica     |
|           | com gravação de log - data anterior , data nova e quem trocou |                                                       
|---------------------------------------------------------------------------|
| Uso       | gestora do contas medicas ou financeiro                       | 
 --------------------------------------------------------------------------*/

User Function CABA115

local cRda      := ' ' 
local cNivel    := ' '
local nI        := 0        
private lsai    := .F.
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
Private aCabTit		:= {" ", " ","nome Rda" , "Num Bord", "Prefixo" , "Num Tit" , "Parcela" ,"Tipo" , "Emissao" ,"Venc. Real", "Saldo" ,"Vlr Tot","Vlr Pgto" , "Competencia", "Controle"}  
Private aTamTit		:= {15,15,120,45,30,60,20,30,45,45,45,40,40,40,30} 

Private oOk      	:= LoadBitMap(GetResources(),"LBOK")
Private oNo      	:= LoadBitMap(GetResources(),"LBNO")

Private oVerde   	:= LoadBitMap(GetResources(),"ENABLE")
Private oVermelho	:= LoadBitMap(GetResources(),"DISABLE")    
Private oAmarelo	:= LoadBitMap(GetResources(),"BR_AMARELO")

Private aObjects 	:= {}

Private aSizeAut 	:= MsAdvSize() 

private cQryAMP     := ' '     

Private cPerg	    := "CABA115"     

private datatu      := dtos(dDataBase)

AjustaSX1()

Pergunte(cPerg,.T.)    
                     
dDtPror := IIf (!empty(trim(dtos(mv_par04))) , dtos(mv_par04) , ' ')                      
 
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

oDlg  		:= MsDialog():New( aSizeAut[7],00,aSizeAut[3]-100,aSizeAut[5]-10,"Prorrogação de Vencimento ",,,.F.,,,,,,.T.,,,.T. ) 

oSayTit    	:= TSay():New( aPosObj[1][1],aPosObj[1][2],{||'Prorroga Vencimento '},oDlg,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,236,016)

bDbClickTit	:= {||aBrwTit[oBrwTit:nAt,1] := !aBrwTit[oBrwTit:nAt,1], oBrwTit:Refresh()}   

//bChangeTit	:= {||AtuBrwGuia(aBrwTit[oBrwTit:nAt,2],aBrwTit[oBrwTit:nAt,3])}

//oBrwTit 	:= TcBrowse():New(aPosObj[1][1]+10,aPosObj[1][2],aPosObj[1][4],aPosObj[1][3],,aCabTit,aTamTit,oDlg,,,,bChangeTit,bDbClickTit,,,,,,,.F.,,.T.,,.F.,,, )

oBrwTit 	:= TcBrowse():New(aPosObj[1][1]+10,aPosObj[1][2],aPosObj[1][4],aPosObj[1][3],,aCabTit,aTamTit,oDlg,,,,,bDbClickTit,,,,,,,.F.,,.T.,,.F.,,, )

oBrwTit:SetArray(aBrwTit) 

// Transform(aBrwTit[oBrwTit:nAt,8],'@E  999,999,999.99'),; 
oBrwTit:bLine := {||{If( aBrwTit[oBrwTit:nAt,1],oOk,oNo) ,;
	 If( aBrwTit[oBrwTit:nAt,12] > 0 ,oVermelho, oVerde) ,;                                                           
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
		 	               aBrwTit[oBrwTit:nAt,14]  }}         
		 	     
		 	     
		 	     
/*aAdd(aRetTit,{.F. , 
              cAliasTit->nomerda , 
              cAliasTit->numbor, 
              cAliasTit->pref, 
              cAliasTit->num  , 
              cAliasTit->parc , 
              cAliasTit->tipo , 
              cAliasTit->emissao , 
              cAliasTit->vencrea , 
              cAliasTit->saldo , 
              cAliasTit->vlr_pgto })
    	 	     
*/                                                                                       

oBrwTit:nScrollType  := 1 // Scroll VCR


lConfirmou 	:= .F. 

 
aBut    :={{"PENDENTE", {||marca(),oBrwTit:Refresh()    }	, "Marcar Todos "    , "Marcar Todos"     } }
aAdd(aBut, {"PENDENTE", {||desmarca(),oBrwTit:Refresh() }	, "DesMarcar Todos "	, "DesMarcar Todos"	} )
aAdd(aBut, {"PENDENTE", {||demost(),oBrwTit:Refresh()  }	, "Demostrativo "   	,"Demostrativo"      } )

 bOk 	:= {|| lConfirmou := .T. , TrocVenc(), desmarca() , oBrwTit:Refresh()   }    
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

//	MsgAlert(Left(cBuffer,len(cBuffer)-1))
	
EndIf

Return    

Static Function TrocVenc()

Local nI := 0
	       
If (!empty(dDtPror)  .and. substr(dDtPror,1,4) >= '2016' .and. (substr(dDtPror,5,2) >= '01' .and. substr(dDtPror,5,2) <= '12')  ; 
                    .and. (substr(dDtPror,7,2) <> ' '   .and.  substr(dDtPror,7,2) >= '01' .and. substr(dDtPror,7,2) <= '31') .AND. dDtPror >= datatu ) ;
                    
 	
   dBSelectArea("SE2")
	
	For nI := 1 to len(aBrwTit)

	   If aBrwTit[nI,1] == .T.
	   
   	   	  DbGoto(aBrwTit[nI,14])
	   
	      RecLock( "SE2" , .F. )
	  
          SE2->E2_VENCREA := (mv_par04) 
	        
	      SE2->(MSUNLOCK())   
  	      
	      gravalog(nI)     
   
	   EndIf   
                                                                                                                
    //   lConfirmou 	:= .T. 

	Next 
    lConfirmou 	:= .F.
Else 

   MsgAlert("Data Invalida para Novo Vencimento  "  + CRLF + " Revise seus parametros !!! ","Atencao!")	
   
   lConfirmou 	:= .F.
 
EndIf 
	
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
       PCP->PCP_DTDEST   := stod(dDtPror)
       PCP->PCP_USUARI   := SubStr(cUSUARIO,7,15)
       PCP->PCP_DTHR     := dtos(dDataBase)

	PCP->(MSUNLOCK())      
    
RETURN()	
	
***********************************************************************************
Static Function marca
	
local nI
		
		For nI := 1 to len(aBrwTit)
	
		   aBrwTit[nI,1]:= .T.
			
		Next
		
	RETURN()	
	
Static Function desmarca
	
local nI
		
		For nI := 1 to len(aBrwTit)
	
			   aBrwTit[nI,1]:= .F.
	
		Next

RETURN()	

/***********************************************************************************
Static Function marcaLin

local nI
	
	For nI := 1 to len(aBrwTit)

	   aBrwTit[nI,1]:= .T.
		
	Next
	
RETURN()	

Static Function desmarcalin

local nI
	
	For nI := 1 to len(aBrwTit)

		   aBrwTit[nI,1]:= .F.

	Next

RETURN()	
************************************************************************************/


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
 
cQryTit :=" SELECT nvl(trim(bau_nfanta),bau_nome) nomerda, " + CRLF 
cQryTit +="        nvl(ea_numbor,0) numbor, nvl(substr(e2_pllote,1,6), ' ') numlot , " + CRLF 
cQryTit +="        e2_prefixo pref, e2_num num , e2_parcela parc, e2_tipo tipo ,   e2_emis1 emissao , e2_vencrea vencrea, " + CRLF 
cQryTit +="        e2_saldo  saldo ,  " + CRLF 
cQryTit +="       (e2_valor + e2_irrf +  e2_inss + e2_iss + e2_Vretpis +e2_vretcof+ e2_vretcsl) vlrtot  ,  " + CRLF 
cQryTit +="       (e2_saldo - e2_valor) vlr_pgto  , se2.R_E_C_N_O_ recse2" + CRLF 
cQryTit +="    FROM "+RetSqlName('SEA')+ " SEA  , " +RetSqlName('SE2')+ " SE2 , " +RetSqlName('BAU')+ " BAU " + CRLF
cQryTit +="   WHERE EA_FILIAL(+)  = '" + xFilial('SEA') + "' AND SEA.D_E_L_E_T_(+) = ' ' " + CRLF 
cQryTit +="     AND E2_FILIAL  = '" + xFilial('SE2')    + "' AND SE2.D_E_L_E_T_ = ' ' " + CRLF 
cQryTit +="     AND BAU_FILIAL = '" + xFilial('BAU')    + "' AND BAU.D_E_L_E_T_ = ' ' " + CRLF  

cQryTit +="     and  ea_prefixo(+) = e2_prefixo " + CRLF   
cQryTit +="     and  ea_num(+)     = e2_num     " + CRLF   
cQryTit +="     and  ea_parcela(+) = e2_parcela " + CRLF      
cQryTit +="     and  ea_tipo(+)    = e2_tipo    " + CRLF   
cQryTit +="     and  ea_fornece(+) = e2_fornece " + CRLF   
cQryTit +="     and  e2_origem     = 'PLSMPAG'  " + CRLF    
cQryTit +="     and  e2_saldo      > 0          " + CRLF   
cQryTit +="     and bau_codsa2     = E2_FORNECE " + CRLF    

 
If !empty(trim(mv_par01))
     cQryTit +="     AND EA_NUMBOR  = '" + mv_par01 +"' " + CRLF      
EndIf                                        

If !empty(trim(dtos(mv_par03)))
     cQryTit += " and  ea_databor >= '" + DtoS(mv_par03) + "' " + CRLF                
EndIf                                                                

If !empty(trim(mv_par02))
     cQryTit += " AND e2_codrda  =  '" + MV_PAR02 + "' " + CRLF    
EndIf 
                             
if mv_par05 == 1
     cQryTit += " AND e2_NATUREZ <> 'OPME' " + CRLF  
     cQryTit +="  and  e2_tipo    = 'FT'   " + CRLF   
Elseif mv_par05 == 2
     cQryTit += " AND e2_NATUREZ  =  'OPME' " + CRLF          
     cQryTit +="  and  e2_tipo    =  'NF'   " + CRLF  
     cQryTit +="  and  e2_PREFIXO =  'UNI'   " + CRLF     
EndIf      

If !empty(mv_par06)
     cQryTit += " and  e2_vencrea  >= '" + DtoS(mv_par06) + "' " + CRLF                 
     cQryTit += " and  e2_vencrea  <= '" + DtoS(mv_par07) + "' " + CRLF                     
EndIf                  

If !empty(mv_par08)
     cQryTit += " and  e2_fornece   >= '" + mv_par08 + "' " + CRLF                 
     cQryTit += " and  e2_fornece   <= '" + mv_par09 + "' " + CRLF                     
EndIf                 



cQryTit +="    ORDER BY 2 , 1 " + CRLF 

                        
TcQuery cQryTit New Alias cAliasTit

While !cAliasTit->(EOF())

	aAdd(aRetTit,{.F. , cAliasTit->nomerda , cAliasTit->numbor, cAliasTit->pref, cAliasTit->num  , cAliasTit->parc , cAliasTit->tipo , cAliasTit->emissao , cAliasTit->vencrea , cAliasTit->saldo , cAliasTit->vlrtot , cAliasTit->vlr_pgto ,cAliasTit->numlot , cAliasTit->recse2})
	                                    
	cAliasTit->(DbSkip())

EndDo
  
cAliasTit->(DbCloseArea())

If empty(aRetTit)  

    MsgAlert("Nao Dados para esta consulta "  + CRLF + " Revise seus parametros !!! ","Atencao!")
    lsai := .T.
        
	RETURN() 

//	aAdd(aRetTit,{.F.,'','','','','','','','','0.00','0.00','0.00',''})
EndIf

Return aRetTit


/***************************************************************************************/
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

 /*

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
   