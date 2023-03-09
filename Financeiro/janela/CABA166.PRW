#Define CRLF Chr(13)+Chr(10)
#INCLUDE "PROTHEUS.ch"                                                                                                                                  
#INCLUDE "TOPCONN.ch"
#INCLUDE "PLSMGER.CH"
#Include "Ap5Mail.Ch"    
/*--------------------------------------------------------------------------
| Programa  | CABA166 | Autor | Altamiro	Affonso    | Data | 08/12/2019  |
|---------------------------------------------------------------------------|              
| Descricao | browser de Controle de cobrança da janela                     |
|           |                                                               |                                                       
|---------------------------------------------------------------------------|
| Uso       | GESTAO DE JANELA DE COBRANÇA                                  | 
 --------------------------------------------------------------------------*/                                                                                  

User Function CABA166()

local cRda      := ' ' 
local cNivel    := ' '
local nI        := 0     

private lsai    := .F. 

private pvez    := .T.                                               

Private _cIdUsu166 := RetCodUsr()

private aRetTit	:= {}
private aRetTBsq:= {}
private aBrwTit      
Private aCabTit	:= {" ", " ","Compte " , "Cod Int", "Empr","Matricula", "Tip Reg","Nome Usuario" , "Dt Incl." ,"Dt Bloq Usr","Dt Bloq Fml" , "Vlr Cobrado","Deb/Cred" ,"Lote Fat ","Dt Deb/Cred" ,"Plano ","Nivel Cob" ,"Dt Process.","Controle" , "Contrato", "V.Contrato.","Sub Contrat." , "V.Scont.","Bloq","Crit", "Obs.","Num. Titulo"}  
Private aTamTit	:= {15 ,15  ,20        ,20        ,20     ,25         ,15        ,40             ,20           ,20          , 20           ,20           ,20         ,30         ,20            ,20      , 20          , 20        , 15          , 25        ,15             ,25            ,15         ,15    ,15    ,60     , 50          }                         

Private oOk     := LoadBitMap(GetResources(),"LBOK")
Private oNo     := LoadBitMap(GetResources(),"LBNO")

Private oVerde   	:= LoadBitMap(GetResources(),"BR_VERDE")
Private oVermelho	:= LoadBitMap(GetResources(),"BR_VERMELHO")    
Private oAzul    	:= LoadBitMap(GetResources(),"BR_AZUL")

Private aObjects 	:= {}

Private aSizeAut 	:= MsAdvSize() 

private cQryAMP     := ' '     

Private cPerg	    := "CABA166"     

Private cPerg	    := "CABA166EX"   

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

private datatu      := dtos(dDataBase-10)      
private cAliasSe2   := GetNextAlias()       
private cAliasTit	:= GetNextAlias() 
private cAliasEnv 	:= GetNextAlias() 
private cAliastmp 	:= GetNextAlias()
private cDTCRIA     := ' ' 
private cDTENV      := ' '
private cDATRET     := ' '

private cCodBsq     := ' '
private cTit        := ' '

Private cComptatu   := dtos(DATE()) 
private cAnoAtu     := substr(cComptatu,1,4) 
private cMesAtu     := substr(cComptatu,5,2)

PRIVATE cCadastro	:= "Status/Controle da Janela de Cobrança"  

PRIVATE aCdCores	:= { 	{ 'BR_VERDE'    ,'Faturado'  },;
							{ 'BR_AZUL'     ,'Lanc. Debito, Sem Faturamento'   },; 
							{ 'BR_VERMELHO' ,'Sem Debito , Sem Faturamento' }}							
 
    AjustaSX1()

    Pergunte(cPerg,.T.)    
    

Processa({||aBrwTit:= aDadosTit()},'Processando...','Processando...',.T.)


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

aInfo  		:= { aSizeAut[ 1 ], aSizeAut[ 2 ], aSizeAut[ 3 ], aSizeAut[ 4 ]-100, nSepHoriz, nSepVert, nSepBorHor, nSepBorVert }
aPosObj 	:= MsObjSize( aInfo, aObjects, .T. )

//oDlg  		:= MsDialog():New( aSizeAut[7],00,aSizeAut[3]-100,aSizeAut[5]-10,"Status do Sib / Gestao de envio   ",,,.F.,,,,,,.T.,,,.T. )  
oDlg  		:= MsDialog():New( aSizeAut[7],00,aSizeAut[3]-100,aSizeAut[5]-30,"Controle  Janela de Cobrança",,,.F.,,,,,,.T.,,,.T. ) 

oSayTit    	:= TSay():New( aPosObj[1][1],aPosObj[1][2],{||'Controle Janela de Cobrança'},oDlg,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,236,016)

//bDbClickTit	:= {|| aBrwTit[oBrwTit:nAt,1] := !aBrwTit[oBrwTit:nAt,1] , fMarcEnv() ,oBrwTit:Refresh()  }   
bDbClickTit	:= {|| aBrwTit[oBrwTit:nAt,1] := !aBrwTit[oBrwTit:nAt,1] , fMarcEnv1(oBrwTit:nAt) ,oBrwTit:Refresh()  }   
//bChangeTit	:= {||AtuBrwGuia(aBrwTit[oBrwTit:nAt,2],aBrwTit[oBrwTit:nAt,3])}

//oBrwTit 	:= TcBrowse():New(aPosObj[1][1]+10,aPosObj[1][2],aPosObj[1][4],aPosObj[1][3],,aCabTit,aTamTit,oDlg,,,,bChangeTit,bDbClickTit,,,,,,,.F.,,.T.,,.F.,,, )

oBrwTit 	:= TcBrowse():New(aPosObj[1][1]+10,aPosObj[1][2],aPosObj[1][4],aPosObj[1][3],,aCabTit,aTamTit,oDlg,,,,,bDbClickTit,,,,,,,.F.,,.T.,,.F.,,, )

oBrwTit:SetArray(aBrwTit) 

// Transform(aBrwTit[oBrwTit:nAt,8],'@E  999,999,999.99'),; 


//Iif(aBrwTit[oBrwTit:nAt, 1]=='T',oOk,oNo)   ,;              

//	 Iif(aBrwTit[oBrwTit:nAt, 6]=='T',oVerde, (Iif(aBrwTit[oBrwTit:nAt, 6]=='T',oVerde,oVermelho),;                                                           
//	 Iif(aBrwTit[oBrwTit:nAt, 6]=='T',oVerde,(Iif(trim(aBrwTit[oBrwTit:nAt, 14])=='',oAzul, oVermelho))),; 
//oBrwTit:bLine := {||{Iif(aBrwTit[oBrwTit:nAt,6]=='T', aBrwTit[oBrwTit:nAt, 1],If(aBrwTit[oBrwTit:nAt, 1],oOk,oNo)),;                                                                                                                        
//oBrwTit:bLine := {||{If( aBrwTit[oBrwTit:nAt,1],oOk,oNo) ,;                                                                                                                                                                                  

 oBrwTit:bLine := {||{If( aBrwTit[oBrwTit:nAt,1],oOk,oNo) ,;                                                                                                                      
                 	 Iif(trim(aBrwTit[oBrwTit:nAt, 12])!='',(Iif(trim(aBrwTit[oBrwTit:nAt, 13])!='',oVerde, oAzul)),oVermelho),;                                                           
		                 aBrwTit[oBrwTit:nAt, 2],;
				         aBrwTit[oBrwTit:nAt, 3],; 
		                 aBrwTit[oBrwTit:nAt, 4],; 
		                 aBrwTit[oBrwTit:nAt, 5],; 
				         aBrwTit[oBrwTit:nAt, 6],;                
		                 aBrwTit[oBrwTit:nAt, 7],;
				         aBrwTit[oBrwTit:nAt, 8],;	 	  	    	 
				         aBrwTit[oBrwTit:nAt, 9],;	 	  	    	 				         
		 	             aBrwTit[oBrwTit:nAt,10],;
		 	             aBrwTit[oBrwTit:nAt,11],;    
		 	             aBrwTit[oBrwTit:nAt,12],;
		 	             aBrwTit[oBrwTit:nAt,13],;
		 	             aBrwTit[oBrwTit:nAt,14],; 
		 	             aBrwTit[oBrwTit:nAt,15],; 
		 	             aBrwTit[oBrwTit:nAt,16],;		 	              
		 	             aBrwTit[oBrwTit:nAt,17],;
		 	             aBrwTit[oBrwTit:nAt,18],;
		 	             aBrwTit[oBrwTit:nAt,19],; 
		 	             aBrwTit[oBrwTit:nAt,20],;		 	              
		 	             aBrwTit[oBrwTit:nAt,21],;
		 	             aBrwTit[oBrwTit:nAt,22],;
		 	             aBrwTit[oBrwTit:nAt,23],;
		 	             aBrwTit[oBrwTit:nAt,24],;
		 	             aBrwTit[oBrwTit:nAt,25],;
		 	             aBrwTit[oBrwTit:nAt,26]}}
		 	        
oBrwTit:nScrollType  := 1 // Scroll VCR


lConfirmou 	:= .F. 

 
aBut    :={{"PENDENTE", {||u_LEG166(),oBrwTit:Refresh()    }	, "Legendas"    , "Legendas"    } }
aAdd(aBut, {"PENDENTE", {||fFazExcel()}	, "Excel" , "Excel" } )
//aAdd(aBut, {"PENDENTE", {||fMarcEnv()}	, "Marca/Desmarca" , "Marca/Desmarca" } )
aAdd(aBut, {"PENDENTE", {||fExcPdl() , oDlg:End() }	, "Exclui Janela "    , "Exclui Janela "    } )
aAdd(aBut, {"PENDENTE", {||fGrvBSQ() }	, "Lança Deb/Cred"    , "Lança Deb/Cred"    } )

// bOk 	:= {|| lConfirmou := .T. , fMarcEnv(),oDlg:End()  }    
 bOk 	:= {|| lConfirmou := .T.  }    
// bOk 	+= {|| lConfirmou := .T. , fCaba148()}   
bCancel := {||lConfirmou := .F.,oDlg:End()}

	
oDlg:Activate(,,,.T.,,,EnchoiceBar(oDlg,bOk,bCancel,,aBut)) 
//oDlg:Activate(,,,.T.,,,EnchoiceBar(oDlg,bOk,bCancel,,))

//If lConfirmou  

  //	MsgInfo("Processo finalizado")

//	MsgAlert(Left(cBuffer,len(cBuffer)-1))
	
//EndIf

Return (lConfirmou)   


Static Function fMarcEnv()

Local nI  := 0        
	       
   dBSelectArea("PDL")   
   
	
      For nI := 1 to len(aBrwTit)
       
          PDL->(DbGoto(aBrwTit[nI,18]))
	   
	   
	      If aBrwTit[nI,1] == .F. .and.PDL->PDL_MARCA == 'T' 
	   	   
	         RecLock( "PDL" , .F. )   
	  
             PDL->PDL_MARCA := 'F'  
    	          
	         PDL->(MSUNLOCK())              
	      
	      ElseIf aBrwTit[nI,1] == .T. .and.PDL->PDL_MARCA =='F' 
	   	   
	         RecLock( "PDL" , .F. )   
	       
             PDL->PDL_MARCA := 'T'  
    	          
	         PDL->(MSUNLOCK())   
	                  
          EndIf 
         
	  Next
	   
RETURN()	

Static Function fMarcEnv1(nx)

      
local nI:= nx	      

   dBSelectArea("PDL")   
       
   PDL->(DbGoto(aBrwTit[nI,18]))
	
	      
	          If !EMPTY(TRIM(PDL->PDL_LOTCOB)) 

   	             aBrwTit[oBrwTit:nAt,1] := !aBrwTit[oBrwTit:nAt,1]
   	             
                 MsgAlert("Janela Ja Cobranda No Lote Nº "+PDL->PDL_LOTCOB + CRLF + "  Ação Não Permitida !!! ","Atencao!")
 
                 Return() 
 
              ElseIf !EMPTY(TRIM(PDL->PDL_DEBCRE)) 
              
                 aBrwTit[oBrwTit:nAt,1] := !aBrwTit[oBrwTit:nAt,1]

	             MsgAlert("Janela Com Lançamento de Debito Realizado Nº "+PDL->PDL_DEBCRED + CRLF + "  Ação Não Permitida !!! ","Atencao!")
              
                 Return()
             
              EndIf 
            
	      If aBrwTit[nI,1] == .F. .and.PDL->PDL_MARCA == 'T' 
	   	   
	         RecLock( "PDL" , .F. )   
	  
             PDL->PDL_MARCA := 'F'  
    	          
	         PDL->(MSUNLOCK())              
	      
	      ElseIf aBrwTit[nI,1] == .T. .and.PDL->PDL_MARCA =='F' 
	   	   
	         RecLock( "PDL" , .F. )   
	       
             PDL->PDL_MARCA := 'T'  
    	          
	         PDL->(MSUNLOCK())   
	                  
          EndIf 
            
RETURN()	

/***********************************************************************************/	
User Function LEG166()
Local aLegenda

	aLegenda 	:= { 	{ aCdCores[1,1],aCdCores[1,2] },;
						{ aCdCores[2,1],aCdCores[2,2] },;
						{ aCdCores[3,1],aCdCores[3,2] } }

	                     	
BrwLegenda(cCadastro,"Status" ,aLegenda)         
Return

/***********************************************************************************/
/***********************************************************************************/	
/***********************************************************************************/
Static Function aDadosTit

LOCAL nConSald:= ' '

Local cQryTit	:= ""

local i                          

ProcRegua(0) 

nCont := 0  

for i:=1 to 5
    IncProc('Buscando Dados no Servidor ...')
next 

fTitLPag()

////////////////////////////////

cQryTit :=      " SELECT PDL_COMPTE COMPTE , "
cQryTit += CRLF+ "       PDL_CODINT CODINT , "
cQryTit += CRLF+ "       PDL_CODEMP CODEMP , "
cQryTit += CRLF+ "       PDL_MATRIC MATRIC , "
cQryTit += CRLF+ "       PDL_TIPREG TIPREG , "
cQryTit += CRLF+ "       PDL_NOMUSR NOMUSR , "
cQryTit += CRLF+ "       trim(substr(PDL_DTAINC,7,2)||'/'||substr(PDL_DTAINC,5,2)||'/'||substr(PDL_DTAINC,1,4)) DTAINC , "
cQryTit += CRLF+ "       trim(substr(PDL_DTBLO1,7,2)||'/'||substr(PDL_DTBLO1,5,2)||'/'||substr(PDL_DTBLO1,1,4)) DTBLO1 , "
cQryTit += CRLF+ "       trim(substr(PDL_DTBLO3,7,2)||'/'||substr(PDL_DTBLO3,5,2)||'/'||substr(PDL_DTBLO3,1,4)) DTBLO3 , " 
cQryTit += CRLF+ "       PDL_VALOR    VALOR  , "  
cQryTit += CRLF+ "       PDL_DEBCRE   DEBCRE , "
cQryTit += CRLF+ "       PDL_LOTCOB   LOTCOB , "
cQryTit += CRLF+ "       trim(substr(PDL_DTLANC,7,2)||'/'||substr(PDL_DTLANC,5,2)||'/'||substr(PDL_DTLANC,1,4)) DTLANC , "
cQryTit += CRLF+ "       PDL_MARCA    MARCA  , "
cQryTit += CRLF+ "       PDL_PLANO    PLANO  , "
cQryTit += CRLF+ "       PDL_COBNIV   COBNIV , "
cQryTit += CRLF+ "       Trim(substr(PDL_DTPROC,7,2)||'/'||substr(PDL_DTPROC,5,2)||'/'||substr(PDL_DTPROC,1,4)) DTPROC ,"

cQryTit += CRLF+ "       PDL.R_e_c_n_o_   Recnopdl ,"

cQryTit += CRLF+ "       BA1.BA1_CONEMP CONEMP , "
cQryTit += CRLF+ "       BA1.BA1_VERCON VERCON , "
cQryTit += CRLF+ "       BA1.BA1_SUBCON SUBCON , "
cQryTit += CRLF+ "       BA1.BA1_VERSUB VERSUB , "
 
cQryTit += CRLF+ "       PDL_MOTBLO MOTBLO , "
cQryTit += CRLF+ "       DECODE(PDL_CRITIC, '1' , 'Sim', 'Não') CRITICA , "
cQryTit += CRLF+ "       PDL_OBS OBS , PDL_NUMTIT NUMTIT "

cQryTit += CRLF+ "  FROM " +RetSqlName('PDL')+ " PDL  , " +RetSqlName('BA1')+ " BA1 "  
cQryTit += CRLF+ " WHERE PDL_FILIAL = '" + xFilial('PDL') + "'"
cQryTit += CRLF+ "   AND PDL.D_E_L_E_T_ = ' ' "
  
cQryTit += CRLF+ "   AND BA1_FILIAL = '" + xFilial('BA1') + "'"
cQryTit += CRLF+ "   AND BA1.D_E_L_E_T_ = ' ' "  
cQryTit += CRLF+ "   AND BA1_CODINT=PDL_CODINT "
cQryTit += CRLF+ "   AND BA1_CODEMP=PDL_CODEMP "
cQryTit += CRLF+ "   AND BA1_MATRIC=PDL_MATRIC "
cQryTit += CRLF+ "   AND BA1_TIPREG=PDL_TIPREG " 

If mv_par05 = 1

   cQryTit += CRLF+ "   AND PDL_MARCA = 'T' "

ElseIf mv_par05 = 2   

   cQryTit += CRLF+ "   AND PDL_MARCA = 'F' "
   
EndIf 
 
cQryTit += CRLF+ "   AND PDL_COMPTE >= '"+mv_par01+"' AND PDL_COMPTE <= '"+mv_par02+"' "
  
cQryTit += CRLF+ "   AND PDL_CODEMP >= '"+mv_par03+"'   AND PDL_CODEMP <= '"+mv_par04+"' "

If mv_par06 = 1

   cQryTit += CRLF+ "   AND PDL.PDL_DEBCRE <> ' ' "

ElseIf mv_par06 = 2   

   cQryTit += CRLF+ "   AND PDL.PDL_DEBCRE =  ' ' "
   
EndIf 
 
If mv_par07 = 1

   cQryTit += CRLF+ "   AND PDL.PDL_LOTCOB <> ' ' "

ElseIf mv_par07 = 2   

   cQryTit += CRLF+ "   AND PDL.PDL_LOTCOB = ' ' "
   
EndIf  
  
cQryTit += CRLF+ "   AND PDL.PDL_LOTCOB >=  '"+mv_par08+"'  AND PDL.PDL_LOTCOB <=  '"+mv_par09+"' "
  
cQryTit += CRLF+ "   AND PDL.PDL_DTPROC >= '"+Dtos(mv_par10)+"' AND PDL.PDL_DTPROC <= '"+Dtos(mv_par11)+"' "

cQryTit += CRLF+ "   AND PDL.PDL_CODINT||PDL.PDL_CODEMP||PDL.PDL_MATRIC||PDL.PDL_TIPREG  >= '"+mv_par12+"' "
cQryTit += CRLF+ "   AND PDL.PDL_CODINT||PDL.PDL_CODEMP||PDL.PDL_MATRIC||PDL.PDL_TIPREG  <= '"+mv_par13+"' "

cQryTit += CRLF+ " ORDER BY PDL_COMPTE , PDL_CODEMP "
 //////////////////////////////         
If Select((cAliasTit)) <> 0 
      
  (cAliasTit)->(DbCloseArea()) 
 
Endif 
                            
TcQuery cQryTit New Alias (cAliasTit)  

While !(cAliasTit)->(EOF())

//        If !empty((cAliasTit)->DEBCRE) .and. empty((cAliasTit)->LOTCOB) .and. (cAliasTit)->LOTCOB <> '999999999999'
/*        If !empty((cAliasTit)->DEBCRE)  .and. (cAliasTit)->LOTCOB <> '999999999999'
          
            fAcaoBSQ((cAliasTit)->DEBCRE, 2)
            
            cLotCob     := aRetTBsq[1,1]
            cTit        := aRetTBsq[1,2]

        Else  

             cLotCob     := (cAliasTit)->LOTCOB
             cTit        := (cAliasTit)->NUMTIT
                    
        EndIf      
*/
//(cAliasTit)->LOTCOB
//(cAliasTit)->NUMTIT
// ver aki altamiroq
      aAdd(aRetTit,{Iif((cAliasTit)->MARCA =='T',.T. ,.F. ),;  
                        (cAliasTit)->COMPTE  ,; 
                        (cAliasTit)->CODINT  ,;                        
                        (cAliasTit)->CODEMP  ,;
                        (cAliasTit)->MATRIC  ,;
                        (cAliasTit)->TIPREG  ,; 
                        (cAliasTit)->NOMUSR  ,;
                   TRIM((cAliasTit)->DTAINC) ,; 
                   TRIM((cAliasTit)->DTBLO1) ,;
                   TRIM((cAliasTit)->DTBLO3) ,; 
              transform((cAliasTit)->VALOR,"@E 99,999.99"),; 
                        (cAliasTit)->DEBCRE  ,; 
                        (cAliasTit)->LOTCOB  ,;                   
                   TRIM((cAliasTit)->DTLANC) ,; 
                        (cAliasTit)->PLANO   ,;
                        (cAliasTit)->COBNIV  ,;
                   TRIM((cAliasTit)->DTPROC) ,;
                        (cAliasTit)->Recnopdl,;
                        (cAliasTit)->CONEMP  ,; 
                        (cAliasTit)->VERCON  ,;                   
                        (cAliasTit)->SUBCON  ,; 
                        (cAliasTit)->VERSUB  ,;
                   TRIM((cAliasTit)->MOTBLO) ,;                   
                   TRIM((cAliasTit)->CRITICA),; 
                   TRIM((cAliasTit)->OBS)    ,;
                   TRIM((cAliasTit)->NUMTIT) })  
      
       (cAliasTit)->(DbSkip())
	
EndDo

(cAliasTit)->(DbCloseArea())

If empty(aRetTit)  

    MsgAlert("Nao Dados para esta consulta "  + CRLF + " Revise seus parametros !!! ","Atencao!")
    lsai := .T.
	aAdd(aRetTit,{.F. , '' , '' , '' , '' , '' , '', '' , ''  ,''  ,0,'', '', '','',' ','',' ','',' ' ,'',' ',' ' ,'',' ',' '})        
EndIf

Return aRetTit                              
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
 
DELETE
Return ()

Static Function fExcPdl()

///////////////////////////////////////

If ApMsgYesNo("Deseja Exluir TODOS as Janela do browser ? ","SIMNAO")

      For nI := 1 to len(aBrwTit)
       
          PDL->(DbGoto(aBrwTit[nI,18]))
	   
	      If EMPTY(TRIM(PDL->PDL_LOTCOB))
	      
//	         If  !EMPTY(TRIM(PDL->PDL_DEBCRE)) .and.  _cIdUsu166 ==  "001091"
	         If   _cIdUsu166 $("001091|000310")
		
 		         PDL->(Reclock("PDL",.F.))
		
		           PDL->(DbDelete()) 
		
	  	         PDL->(MSUNLOCK())              

                 If !EMPTY(TRIM(PDL->PDL_DEBCRE))
                    
                    fAcaoBSQ(TRIM(PDL->PDL_DEBCRE) , 1)
                 
                 EndIf    
	         
	         EndIf 
	      Else
 		  
              MsgAlert("Debito/credito "+PDL->PDL_DEBCRE+"Já Faturado, Não sera possivel excluir  ","Atencao!")                         
                                                                                                                                    
        EndIf 
         
    Next
    
EndIf    

 MsgAlert("Dados Apagados Com Sucesso ","Atencao!")              
                         
Return ()


Static Function fAcaoBSQ(cBSQSeq,cAcao)

aRetTBsq := {}

		dbSelectArea("BSQ")
		dbSetOrder(1)
		If dbSeek( xFilial("BSQ") + cBSQSeq )
	
	        If cAcao == 1 
	        
       			BSQ->(RecLock("BSQ",.F.))
	    		      BSQ->(DbDelete())
	    		BSQ->(MsUnlock())
	        
	        Else 
	        
	        PDL->(DbGoto((cAliasTit)->Recnopdl))
	        
   	            PDL->(Reclock("PDL",.F.))
		
		              PDL->PDL_LOTCOB := BSQ->BSQ_NUMCOB
		              PDL->PDL_NUMTIT := BSQ->BSQ_PREFIX+BSQ->BSQ_NUMTIT+BSQ->BSQ_PARCEL+BSQ->BSQ_TIPTIT
		              
	  	        PDL->(MSUNLOCK())          

	            aAdd(aRetTBsq ,{BSQ->BSQ_NUMCOB ,; 
                                BSQ->BSQ_PREFIX+BSQ->BSQ_NUMTIT+BSQ->BSQ_PARCEL+BSQ->BSQ_TIPTIT})     
	  
	  	    EndIf    
	        
	            
	    EndIf 	
Return ()

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

aAdd(aHelp, "Marcados para ação ")
U_CABASX1(cPerg,"05", "Marcados "        ,"","","mv_ch5","N",1,0,1,"C","","","","","mv_par05","Marcados","","","","Não Marcados","","","Todos","","","","","","","","",aHelp,aHelp,aHelp)

aAdd(aHelp, "Com Lançamento de Deb/Cred")
U_CABASX1(cPerg,"06", "Lançamento de Deb/Cred"   ,"","","mv_ch6","N",1,0,1,"C","","","","","mv_par06","Com Lanc. D/C","","","","Sem Lanc. D/C","","","Todos","","","","","","","","",aHelp,aHelp,aHelp)

aAdd(aHelp, "Com Lote de de Faturamento ")
U_CABASX1(cPerg,"07","Lote Faturamento "   ,"","","mv_ch7","N",1,0,1,"C","","","","","mv_par07","Com Lote Fat","","","","Sem Lote Fat","","","Todos","","","","","","","","",aHelp,aHelp,aHelp)

aAdd(aHelp, "Lançamento de Faturamento Inicial ")
U_CABASX1(cPerg , "08" , "Lot Fatur. inicial " ,"","","mv_ch8","C",12,0,0,"G","","","","","mv_par08","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aAdd(aHelp, "Lançamento de Faturamento Final ")
U_CABASX1(cPerg , "09" , "Lot Fatur. Final" ,"","","mv_ch9","C",12,0,0,"G","","","","","mv_par09","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aAdd(aHelp, "Data de processamento , seleção da janela")
U_CABASX1(cPerg , "10" , "Dt do Processamento De " ,"","","mv_ch10","D",08,0,0,"G","","","","","mv_par10","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aAdd(aHelp, "Data de processamento , seleção da janela")
U_CABASX1(cPerg , "11" , "Dt do Processamento Ate" ,"","","mv_ch11","D",08,0,0,"G","","","","","mv_par11","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aAdd(aHelp, "Matricula completa 16 caracteres , sem o digito , Inicial ")
U_CABASX1(cPerg , "12" , "Matricula Inicial (S/digito)" ,"","","mv_ch12","C",16,0,0,"G","","","","","mv_par12","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aAdd(aHelp, "Matricula completa 16 caracteres , sem o digito , Final ")
U_CABASX1(cPerg , "13" , "Matricula Final (S/digito) " ,"","","mv_ch13","C",16,0,0,"G","","","","","mv_par13","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)


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
   

//////////////////////////////////////////////////////////////////    
STATIC FUNCTION fFazExcel()
                  
	Local aArea        	:= GetArea()
	Local cEmpresa    	:= iIf( cEmpAnt=='01', 'C', 'I')
	Local oFWMsExcel
	Local oExcel
	Local cArquivoA    	:= 'C:\TEMP\'+cEmpresa+'JANELA'+SubStr(DtoS(date()),7,2)+SubStr(DtoS(date()),5,2)+SubStr(DtoS(date()),1,4)+STRTRAN(TIME(),":","_")+'.xml'   
	
	Local nRegsA		:= len(	aRetTit )   

	If nRegsA == 0
		Aviso("Não há dados!!!","Cobranca Janela  !",{"OK"})              
	Else 
		oFWMsExcel := FWMSExcel():New()		
		oFWMsExcel:AddworkSheet("JANELA")
		oFWMsExcel:AddTable("JANELA","Janela")
		oFWMsExcel:AddColumn("JANELA","Janela","Compte ",1) 
		oFWMsExcel:AddColumn("JANELA","Janela","Cod Int ",1)
		oFWMsExcel:AddColumn("JANELA","Janela","Cod Empresa",1)  
		oFWMsExcel:AddColumn("JANELA","Janela","Matricula ",1) 
		oFWMsExcel:AddColumn("JANELA","Janela","Tip Reg ",1) 
		oFWMsExcel:AddColumn("JANELA","Janela","Nome Usuario ",1) 
		oFWMsExcel:AddColumn("JANELA","Janela","Dt Inicio",1) 
		oFWMsExcel:AddColumn("JANELA","Janela","Dt Bloq. Usr",1) 
		oFWMsExcel:AddColumn("JANELA","Janela","Dt Bloq. Fml",1) 
		oFWMsExcel:AddColumn("JANELA","Janela","Valor à Cobrar",3) 
   		oFWMsExcel:AddColumn("JANELA","Janela","Deb/Cred",1) 
        oFWMsExcel:AddColumn("JANELA","Janela","Lote Cobranca",1)		
   		oFWMsExcel:AddColumn("JANELA","Janela","Dt Lanc. Deb.",1) 
   		oFWMsExcel:AddColumn("JANELA","Janela","Cod Plano ",1) 
		oFWMsExcel:AddColumn("JANELA","Janela","Nivel Cobrança",1) 
		oFWMsExcel:AddColumn("JANELA","Janela","Dt Process.",1) 
		oFWMsExcel:AddColumn("JANELA","Janela","Controle",1) 
		
		oFWMsExcel:AddColumn("JANELA","Janela","Contrato",1) 
		oFWMsExcel:AddColumn("JANELA","Janela","V. Contr.",1)
		oFWMsExcel:AddColumn("JANELA","Janela","Sub Contrato",1) 
		oFWMsExcel:AddColumn("JANELA","Janela","V.Sub Contr.",1) 				 
		
	    oFWMsExcel:AddColumn("JANELA","Janela","Cod Bloq.",1) 				 
		oFWMsExcel:AddColumn("JANELA","Janela","Criticado",1) 				 
		oFWMsExcel:AddColumn("JANELA","Janela","Obs",1) 				 
		oFWMsExcel:AddColumn("JANELA","Janela","Num Titulo",1) 				 
				
	/*		
		oFWMsExcel:AddColumn("SIB","Sib","St. Cont. Envio",1)
		oFWMsExcel:AddColumn("SIB","Sib","Desc Critica Operadora",1) 
		oFWMsExcel:AddColumn("SIB","Sib","Desc Critica ANS",1)  
		oFWMsExcel:AddColumn("SIB","Sib","Usuario Envio",1)				               
		oFWMsExcel:AddColumn("SIB","Sib","Arq. Envio ",1)
		oFWMsExcel:AddColumn("SIB","Sib","Usuario Retorno",1) 
		oFWMsExcel:AddColumn("SIB","Sib","Arq. Retorno ",1) 
	
		*/
		ProcRegua(nRegsA) // Atribui quantidade de registros que serão impressos
		
		//Criando as Linhas... Enquanto não for fim da query

        for I = 1 to len(aRetTit)

        IncProc()
	    IncProc("Aguarde.. Gerando Excel Da Grade ....")
	
					
			oFWMsExcel:AddRow("JANELA","Janela",{;
 				  	aRetTit[I,02] ,;
 				  	aRetTit[I,03] ,;
				  	aRetTit[I,04] ,;
 				  	aRetTit[I,05] ,;
 				  	aRetTit[I,06] ,;
 				  	aRetTit[I,07] ,;
 				    aRetTit[I,08] ,;
 				    aRetTit[I,09] ,;
 				    aRetTit[I,10] ,;                    			  	
				    aRetTit[I,11] ,;                    			  	
				    aRetTit[I,12] ,;                    			  	 				    
				  	aRetTit[I,13] ,;
					aRetTit[I,14] ,;  
					aRetTit[I,15] ,;  
					aRetTit[I,16] ,;  
				 	aRetTit[I,17] ,;
				 	aRetTit[I,18] ,;
				 	aRetTit[I,19] ,;
				 	aRetTit[I,20] ,;
				 	aRetTit[I,21] ,;
				 	aRetTit[I,22] ,;
				 	aRetTit[I,23] ,;
				 	aRetTit[I,24] ,; 
				 	aRetTit[I,25] ,;
				 	aRetTit[I,26] })
				 	  
		Next 
		
		//Ativando o arquivo e gerando o xml                    
		oFWMsExcel:Activate()
		oFWMsExcel:GetXMLFile(cArquivoA)
		
		//Abrindo o excel e abrindo o arquivo xml
		oExcel := MsExcel():New()           //Abre uma nova conexão com Excel
		oExcel:WorkBooks:Open(cArquivoA)     //Abre uma planilha
		oExcel:SetVisible(.T.)              //Visualiza a planilha
		oExcel:Destroy()                    //Encerra o processo do gerenciador de tarefas
		
    EndIf 			

RETURN()


static Functio fGrvBSQ()
    
      For nI := 1 to len(aBrwTit)
       
          PDL->(DbGoto(aBrwTit[nI,18]))
	   
	      If aBrwTit[nI,1] == .T. .and.PDL->PDL_MARCA == 'T' .and. EMPTY(TRIM(PDL->PDL_DEBCRE))
	
			   BSQ->(Reclock("BSQ",.T.))
	
				BSQ->BSQ_FILIAL	:= xFilial("BSQ")
				BSQ->BSQ_CODSEQ	:= PLSA625Cd("BSQ_CODSEQ","BSQ",1,"D_E_L_E_T_"," ")
				BSQ->BSQ_CODINT := PDL->PDL_CODINT
				BSQ->BSQ_CODEMP	:= PDL->PDL_CODEMP
				BSQ->BSQ_MATRIC	:= PDL->PDL_MATRIC
				BSQ->BSQ_CONEMP	:= aBrwTit[nI,19]
				BSQ->BSQ_VERCON	:= aBrwTit[nI,20]
			    BSQ->BSQ_SUBCON	:= aBrwTit[nI,21]
				BSQ->BSQ_VERSUB	:= aBrwTit[nI,22]
				BSQ->BSQ_COBNIV := PDL->PDL_COBNIV
				BSQ->BSQ_ANO	:= cAnoAtu //substr(PDL->PDL_compte,1,4)
				BSQ->BSQ_MES	:= cMesAtu //substr(PDL->PDL_compte,5,2)
	
				BSQ->BSQ_CODLAN	:= '898' // parPDL->PDL_comptea teste 
	
				BSQ->BSQ_VALOR	:= PDL->PDL_VALOR
				BSQ->BSQ_NPARCE	:= "1"
						
				BSQ->BSQ_OBS	:= "Cobrança De Janela - Comptencia - "+ PDL->PDL_compte	
				
				BSQ->BSQ_AUTOMA	:= "1"
				BSQ->BSQ_TIPO	:= "1"
				BSQ->BSQ_TIPEMP	:= "2"
				BSQ->BSQ_ATOCOO	:= "1"
				
			    BSQ->BSQ_ITECTA := PDL->PDL_PLANO
			    BSQ->BSQ_CLVL   := PDL->PDL_CODEMP 
			
			   cCodBD := BSQ->BSQ_CODSEQ
			
		   BSQ->(MsUnlock())
		   
//////////////////////////////
		//////Registra lançamento de credito na caberj
		
		     PDL->(Reclock("PDL",.F.))
		
		       PDL->PDL_DEBCRE := cCodBD 
		
             // PDL->PDL_MARCA  := 'F'  
               
               PDL->PDL_DTLANC := DATE()
    	          
	         PDL->(MSUNLOCK())              
	                                                                                                                                          
        EndIf 
         
    Next
   
   Return()


Static Function fTitLPag()

    Local cqry       := ' ' 
    Local cAliasTmp1	:= GetNextAlias()

	cQry +=       " SELECT PDL.R_e_c_n_o_   Recnopdl , "
	cQry += CRLF+ "        PDL.PDL_LOTCOB   LotCob   , "
	cQry += CRLF+ "        BSQ.BSQ_NUMCOB   NumCob   , "
	cQry += CRLF+ "        PDL.PDL_NUMTIT   TitPDL   , "
	cQry += CRLF+ "        BSQ.BSQ_PREFIX || BSQ.BSQ_NUMTIT || BSQ.BSQ_PARCEL || BSQ.BSQ_TIPTIT TitBSQ "

	cQry += CRLF+ "  FROM " +RetSqlName('PDL')+ " PDL , " +RetSqlName('BSQ')+ " BSQ "  
	cQry += CRLF+ " WHERE PDL_FILIAL = '" + xFilial('PDL') + "'"
	cQry += CRLF+ "   AND PDL.D_E_L_E_T_ = ' ' "
	
	cQry += CRLF+ "   AND BSQ_FILIAL = '" + xFilial('BSQ') + "'"
	cQry += CRLF+ "   AND BSQ.D_E_L_E_T_ = ' ' "      

    cQry += CRLF+ "    AND PDL.PDL_MARCA = 'T' " 
	cQry += CRLF+ "    AND PDL.PDL_DEBCRE = bsq_CodSeq "
	cQry += CRLF+ "    AND PDL_LOTCOB <> '999999999999' "
	cQry += CRLF+ "    AND (PDL.PDL_LOTCOB <> BSQ_NUMCOB "
	cQry += CRLF+ "     OR SUBSTR(PDL.PDL_NUMTIT,4,9) <> BSQ.BSQ_NUMTIT) "
 
 //////////////////////////////         

If Select(cAliasTmp1) <> 0 
      
  (cAliasTmp1)->(DbCloseArea()) 
 
Endif 
                            
TcQuery cQry New Alias (cAliasTmp1)  

While !(cAliasTmp1)->(EOF())

    PDL->(DbGoto((cAliasTmp1)->Recnopdl))
	   
	PDL->(Reclock("PDL",.F.))
		
		PDL->PDL_LOTCOB := (cAliasTmp1)->NumCob
		       
        PDL->PDL_NUMTIT := (cAliasTmp1)->TitBSQ
    	          
	PDL->(MSUNLOCK())              
	                                                                                                                                          
         
    (cAliasTmp1)->(DbSkip())
	
EndDo

Return()