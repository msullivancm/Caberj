#Define CRLF Chr(13)+Chr(10)
#INCLUDE "PROTHEUS.ch"                                                                                                                                  
#INCLUDE "TOPCONN.ch"
#INCLUDE "PLSMGER.CH"
#Include "Ap5Mail.Ch"    
/*--------------------------------------------------------------------------
| Programa  | CABA145 | Autor | Altamiro	Affonso    | Data | 14/12/2018  |
|---------------------------------------------------------------------------|              
| Descricao | Controle de vidas ao ser enviadas a ans e                     |
|           | controle de processamento                                     |                                                       
|---------------------------------------------------------------------------|
| Uso       | gestao do SIB - cadastro                                      | 
 --------------------------------------------------------------------------*/

//User Function CABA145                                                                                    

User Function CABA145(mvpar01 , mvpar02 , mvpar03 , mvpar04 , mvpar05 , mvpar06 , mvpar07 , mvpar08 , mvpar09, origem)

local cRda      := ' ' 
local cNivel    := ' '
local nI        := 0        
private lsai    := .F. 

private pvez    := .T.     
private cOrigem := origem                                             

private aRetTit	:= {}
private aBrwTit      
//Private aCabTit	:= {" ", " ","Tp Acao " , "Cod CCo ", "Mat Caberj ", "Usuario ","Dt Criação" , "Enviado" ,"Criticado ","Tipo Sib" , "Seq","Compet" ,"Dt Envio ","Dt Retorno" ,"Envia sib","C. ANS" ,"C. Cab" , "Cont.","LocSib","Usuar. Envio","Arq. Envio","Usuar. Retorno","Arq. Retorno", "Descrição Critaca Caberj","Descrição Critaca ANS"}   
  Private aCabTit	:= {" ", " ","Tp Acao " , "Cod CCo ", "Mat Caberj ", "Usuario ","Dt Criação" , "Enviado" ,"Em Analise","Tipo Sib" , "Seq","Compet" ,"Dt Envio ","Dt Retorno" ,"Envia sib","C. ANS" ,"C. Cab" , "Cont.","LocSib","Usuar. Envio","Arq. Envio","Usuar. Retorno","Arq. Retorno", "Descrição Critaca Caberj","Descrição Critaca ANS"}  
Private aTamTit	:= {15 ,15  ,25         ,40         ,50            ,100        ,30           ,25         ,25          ,30         , 15   ,25       ,30         ,30           ,25         ,20       , 20      ,15      ,15      ,30            ,30          ,30              ,30            ,300                        ,300}                         

Private oOk     := LoadBitMap(GetResources(),"LBOK")
Private oNo     := LoadBitMap(GetResources(),"LBNO")

Private oVerde   	:= LoadBitMap(GetResources(),"BR_VERDE")
Private oVermelho	:= LoadBitMap(GetResources(),"BR_VERMELHO")    
Private oAmarelo	:= LoadBitMap(GetResources(),"BR_AMARELO") 
Private oAzul    	:= LoadBitMap(GetResources(),"BR_AZUL")

Private aObjects 	:= {}

Private aSizeAut 	:= MsAdvSize() 

private cQryAMP     := ' '     

Private cPerg	    := "CABA145"     

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

PRIVATE cCadastro	:= "Status do Sib / Gestao de envio"  

PRIVATE aCdCores	:= { 	{ 'BR_VERDE'    ,'Enviado Sem Critica '  },;
							{ 'BR_AZUL'     ,'Enviado Com Critica'   },; 
							{ 'BR_VERMELHO' ,'Nao Envia Com Critica' },;							
							{ 'BR_AMARELO'  ,'Nao Envia Sem Critica' }}							
 
If Origem == 'CABA145A'

	mv_par01:= mvpar01  
	mv_par02:= mvpar02  
	mv_par03:= mvpar03 
	mv_par04:= mvpar04 
	mv_par05:= mvpar05 
	mv_par06:= mvpar06 
	mv_par07:= mvpar07 
	mv_par08:= mvpar08 
	mv_par09:= mvpar09 
	
ElseIf Origem == 'CABA144'

	mv_par01:= mvpar01 
	If trim(mvpar02)=='1-Sib Mensal'  
	   mv_par02:= 1 
	Else           
	   mv_par02:= 2
	EndIf         
	 If mvpar03 == 'INCL'
	    mv_par03 := 1      
	 elseIf mvpar03 == 'CANC'
	    mv_par03 := 2
	 elseIf mvpar03 == 'RETI'
	    mv_par03 := 3         
     elseIf mvpar03 == 'REAT'
	    mv_par03 := 4
	 EndIf    	    	
	mv_par04:= mvpar04
	
	If mvpar05 ==  'Sim'
       mv_par05 := 1
    Else 
       mv_par05 := 2 
    EndIf          
	
	If mvpar06 ==  'Sim'
       mv_par06 := 1
    Else 
       mv_par06 := 2 
    EndIf          
	mv_par07:= ''
	mv_par08:= '' 
	mv_par09:= ''
                                          
Else 	
 
    AjustaSX1()

    Pergunte(cPerg,.T.)    
    
EndIf 
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

aInfo  		:= { aSizeAut[ 1 ], aSizeAut[ 2 ], aSizeAut[ 3 ], aSizeAut[ 4 ], nSepHoriz, nSepVert, nSepBorHor, nSepBorVert }
aPosObj 	:= MsObjSize( aInfo, aObjects, .T. )

//oDlg  		:= MsDialog():New( aSizeAut[7],00,aSizeAut[3]-100,aSizeAut[5]-10,"Status do Sib / Gestao de envio   ",,,.F.,,,,,,.T.,,,.T. )  
oDlg  		:= MsDialog():New( aSizeAut[7],00,aSizeAut[3]-100,aSizeAut[5]-10,"Status do Sib / Gestao de envio   ",,,.F.,,,,,,.T.,,,.T. ) 

oSayTit    	:= TSay():New( aPosObj[1][1],aPosObj[1][2],{||'Status do Sib / Gestao de envio'},oDlg,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,236,016)

bDbClickTit	:= {|| aBrwTit[oBrwTit:nAt,1] := !aBrwTit[oBrwTit:nAt,1], oBrwTit:Refresh()  }   

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
                 	 Iif(aBrwTit[oBrwTit:nAt, 7]=='T',(Iif(trim(aBrwTit[oBrwTit:nAt, 6])=='T',oAzul, oVermelho)),(Iif(trim(aBrwTit[oBrwTit:nAt, 6])=='T',oVerde, oAmarelo))),;                                                           
		                 aBrwTit[oBrwTit:nAt, 2]		         ,;
				         aBrwTit[oBrwTit:nAt, 3]                 ,; 
		                 aBrwTit[oBrwTit:nAt, 4] 		         ,; 
		                 aBrwTit[oBrwTit:nAt, 16]                ,; 
				         aBrwTit[oBrwTit:nAt, 5]                ,;                
                     Iif(aBrwTit[oBrwTit:nAt, 6]=='T','Sim','Não'),;
                     Iif(aBrwTit[oBrwTit:nAt, 7]=='T','Sim','Não'),;
		                 aBrwTit[oBrwTit:nAt, 8]                 ,;
				         aBrwTit[oBrwTit:nAt, 9]                 ,;	 	  	    	 
		 	             aBrwTit[oBrwTit:nAt,10]                 ,;
		 	             aBrwTit[oBrwTit:nAt,11]                ,;    
		 	             aBrwTit[oBrwTit:nAt,12]                ,;
		 	         Iif(aBrwTit[oBrwTit:nAt,13]=='T','Sim','Não'),;
		 	             aBrwTit[oBrwTit:nAt,14],; 
		 	             aBrwTit[oBrwTit:nAt,17],;
		 	             aBrwTit[oBrwTit:nAt,15],; 
		 	             aBrwTit[oBrwTit:nAt,20],;		 	              
		 	             aBrwTit[oBrwTit:nAt,21],;		 	              
  		 	             aBrwTit[oBrwTit:nAt,22],;		 	             		 	             		 	             
  		 	             aBrwTit[oBrwTit:nAt,23],;		 	             
                         aBrwTit[oBrwTit:nAt,24],;		 	            
                         aBrwTit[oBrwTit:nAt,18],;
                         aBrwTit[oBrwTit:nAt,19]}}
		 	        
oBrwTit:nScrollType  := 1 // Scroll VCR


lConfirmou 	:= .F. 

 
aBut    :={{"PENDENTE", {||u_LEG145(),oBrwTit:Refresh()    }	, "Legendas"    , "Legendas"    } }
aAdd(aBut, {"PENDENTE", {||fFazExcel()}	, "Excel" , "Excel" } )
//aAdd(aBut, {"PENDENTE", {||U_fCaba148((aBrwTit[oBrwTit:nAt, 4]),(aBrwTit[oBrwTit:nAt, 3])),oBrwTit:Refresh()  }	, "Demostrativo "    , "Demostrativo"    } )
aAdd(aBut, {"PENDENTE", {||U_fCaba148((aBrwTit[oBrwTit:nAt, 4]),(aBrwTit[oBrwTit:nAt, 3])),oDlg:End()  }	, "Demostra"    , "Demostra"    } )

 bOk 	:= {|| lConfirmou := .T. , fMarcEnv(),oDlg:End()  }    
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
	       
   dBSelectArea("PD5")   
   
   If trim(mv_par01) !='' .and. mv_par02 != 3 .and. !fValEnv(mv_par04)   
	
      For nI := 1 to len(aBrwTit)
       
          PD5->(DbGoto(aBrwTit[nI,15]))
	   
	      If aBrwTit[nI,1] == .F. .and.PD5->PD5_ENVIA == .T. 
	   	   
	         RecLock( "PD5" , .F. )   
	  
             PD5->PD5_ENVIA := .F.  
    	          
	         PD5->(MSUNLOCK())              
	                                                                                                                                          
          ElseIf aBrwTit[nI,1] == .T. .and.PD5->PD5_ENVIA == .F. 
	   	   
	         RecLock( "PD5" , .F. )   
	       
             PD5->PD5_ENVIA := .T.  
    	          
	         PD5->(MSUNLOCK())   
	                  
          EndIf 
         
	  Next
	   
   Else                     
	 
	    MsgAlert("Não e possivel Marcar ou DesMarcar Itens Para Envio , Com : Comp. Em branco ou Tipo de Sib não especificado ou de sib ja enviado ou sem informar a sequencia","Atencao!") 
	
   EndIf 
    	
RETURN()	

/***********************************************************************************/	

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

////////////////////////////////
cQryTit :=" SELECT PD5.*, NVL(PD4_CRITIC, ' ' ) PD4CRICAB , NVL(PD4_CRIANS,' ') PD4CRIANS ,"+ CRLF  

cQryTit += CRLF+ " DECODE(PD5_LOCSIB,'0','0-A ENVIAR' ," 
cQryTit += CRLF+ "                   '1','1-ATIVO' , "
cQryTit += CRLF+ "                   '2','2-EXCLUÍDO' , "
cQryTit += CRLF+ "                   '3','3-ENVIADO INCLUSÃO' ," 
cQryTit += CRLF+ "                   '4','4-ENVIADO ALTERAÇÃO' ," 
cQryTit += CRLF+ "                   '5','5-ENVIADO EXCLUSÃO' ," 
cQryTit += CRLF+ "                   '6','6-FORÇAR  INCLUSÃO' ," 
cQryTit += CRLF+ "                   '7','7-FORÇAR ALTERAÇÃO' ," 
cQryTit += CRLF+ "                   '8','8-FORÇAR EXCLUSÃO' ," 
cQryTit += CRLF+ "                   '9','9-MUDANÇA CONTRATUAL' ," 
cQryTit += CRLF+ "                   'A','A-ENVIADO REATIVAÇÃO' ," 
cQryTit += CRLF+ "                   'B','B-FORÇAR MUD.CONTRATUAL' ," 
cQryTit += CRLF+ "                   'C','C-FORÇAR REATIVAÇÃO' ," 
cQryTit += CRLF+ "                   'Outros - Não Previsto') STSANS " + CRLF  

cQryTit +="   FROM " +RetSqlName('PD5')+ " PD5 , " +RetSqlName('PD4')+ " PD4 "+ CRLF 
cQryTit +="  WHERE PD5_filial = '" + xFilial('PD5')    + "'"+ CRLF 
cQryTit +="    AND PD4_filial(+) = '" + xFilial('PD5')    + "'"+ CRLF
cQryTit +="    AND PD5.d_E_L_E_T_ = ' ' "+ CRLF 
cQryTit +="    AND PD4.d_E_L_E_T_(+) = ' ' "+ CRLF
If !empty(mv_par01)
   cQryTit +="    AND PD5_COMPTE = '"+ mv_par01 +"' "+ CRLF                                          
EndIf 
If mv_par02 == 1
   cQryTit +="    AND PD5_TPENVI = 'Sib Mensal' "+ CRLF
ElseIf mv_par02 == 2
   cQryTit +="    AND PD5_TPENVI = 'Sib Global' "+ CRLF     
EndIf    
                
If mv_par03 == 1
   cQryTit +="    AND PD5_TPACAO = 'INCL' "+ CRLF
ElseIf mv_par03 == 2
   cQryTit +="    AND PD5_TPACAO = 'CANC' "+ CRLF 
ElseIf mv_par03 == 3
   cQryTit +="    AND PD5_TPACAO = 'RETI' "+ CRLF
ElseIf mv_par03 == 4
   cQryTit +="    AND PD5_TPACAO = 'REAT' "+ CRLF      
EndIf     

If !empty(mv_par04)
    cQryTit +="    AND PD5_SEQUEN = '"+ mv_par04 +"'"+ CRLF
EndIf 
If mv_par05 == 1
   cQryTit +="    AND PD5_CRITIC = 'T' "+ CRLF 
ElseIf mv_par05 == 2
   cQryTit +="    AND PD5_CRITIC = 'F' "+ CRLF     
EndIf    

If mv_par06 == 1
   cQryTit +="    AND PD5_ENVIAD = 'T' "+ CRLF
ElseIf mv_par06 == 2                          
   cQryTit +="    AND PD5_ENVIAD = 'F' "+ CRLF
EndIf            

If !empty(mv_par07)                           
   cQryTit +="    AND PD5_CODCCO LIKE  '%"+trim(mv_par07)+"%'"+ CRLF
ElseIf !empty(mv_par08)                           
   cQryTit +="    AND PD5_matric LIKE  '%"+trim(mv_par08)+"%'"+ CRLF
EndIf           
If !empty(mv_par09)                          
   cQryTit +="    AND PD5_NOMUSR LIKE  '%"+TRIM(mv_par09)+"%'"+ CRLF
EndIf                              

cQryTit +=" AND PD4_COMPTE(+) = PD5_COMPTE"+ CRLF  
cQryTit +=" AND PD4_SEQUEN(+) = PD5_SEQUEN "+ CRLF 
cQryTit +=" AND PD4_MATRIC(+) = PD5_MATRIC 
cQryTit +=" AND PD4_CODCCO(+) = PD5_CODCCO 

cQryTit +=" AND PD4_ACAO(+) = PD5_TPACAO "+ CRLF

cQryTit +=" AND PD4_TIPENV(+) = PD5_TPENVI "+ CRLF    
If cOrigem <> 'CABA145A'
   cQryTit +=" AND PD5_CRICAB <> 'XXX1' AND PD5_CRICAB <> 'XXX2' "+ CRLF
EndIf      

cQryTit +=" ORDER BY PD5_TPACAO , PD5_CODCCO , PD5_MATRIC  " + CRLF   
//////////////////////////////
 //////////////////////////////         
If Select((cAliasTit)) <> 0 
      
  (cAliasTit)->(DbCloseArea()) 
 
Endif 
                            
TcQuery cQryTit New Alias (cAliasTit)  

While !(cAliasTit)->(EOF())     
                                     
 //StoD((cAliasTit)->PD5_DTCRIA),; 
 //StoD((cAliasTit)->PD5_DTENV) ,;
 //StoD((cAliasTit)->PD5_DATRET),;
   cDTCRIA:= substr((cAliasTit)->PD5_DTCRIA,7,2)+'/'+substr((cAliasTit)->PD5_DTCRIA,5,2)+'/'+substr((cAliasTit)->PD5_DTCRIA,1,4)     
   cDTENV := substr((cAliasTit)->PD5_DTENV,7,2)+'/'+substr((cAliasTit)->PD5_DTENV,5,2)+'/'+substr((cAliasTit)->PD5_DTENV,1,4) 
   cDATRET:= substr((cAliasTit)->PD5_DATRET,7,2)+'/'+substr((cAliasTit)->PD5_DATRET,5,2)+'/'+substr((cAliasTit)->PD5_DATRET,1,4)
        
      aAdd(aRetTit,{Iif((cAliasTit)->PD5_ENVIA=='T',.T. ,.F. ),;  
                        (cAliasTit)->PD5_TPACAO ,; 
                        (cAliasTit)->PD5_CODCCO ,;
                        (cAliasTit)->PD5_MATRIC ,;
                         cDTCRIA ,;
                        (cAliasTit)->PD5_ENVIAD ,; 
                        (cAliasTit)->PD5_CRITIC ,;
                        (cAliasTit)->PD5_TPENVI ,; 
                        (cAliasTit)->PD5_SEQUEN ,;
                        (cAliasTit)->PD5_COMPTE ,; 
                         cDTENV,;
                         cDATRET,; 
                        (cAliasTit)->PD5_ENVIA  ,; 
                        (cAliasTit)->PD5_CRIANS ,; 
                        (cAliasTit)->R_E_C_N_O_ ,;
                        (cAliasTit)->PD5_NOMUSR ,; 
                        (cAliasTit)->PD5_CRICAB ,;
                        (cAliasTit)->PD4CRICAB  ,;
                        (cAliasTit)->PD4CRIANS  ,;
                        (cAliasTit)->STSANS     ,; 
                        (cAliasTit)->PD5_USRENV ,;
                        (cAliasTit)->PD5_ARQENV ,;
                        (cAliasTit)->PD5_USRRET ,;
                        (cAliasTit)->PD5_ARQRET }) 
      
       (cAliasTit)->(DbSkip())
	
EndDo

(cAliasTit)->(DbCloseArea())

If empty(aRetTit)  

    MsgAlert("Nao Dados para esta consulta "  + CRLF + " Revise seus parametros !!! ","Atencao!")
    lsai := .T.
	aAdd(aRetTit,{.F. , '' , '' , '' , '' , '' , '', '' , ''  ,''  ,'', '', '','',0,' ','',' ','',' ' ,'',' ','',' '})        
EndIf

Return aRetTit                              

User Function fCaba148(cMat145, cCco145)

local cquery :='  '

If trim(cMat145) == '' 	

cquery := CRLF+" SELECT BA1_CODINT|| BA1_CODEMP|| BA1_MATRIC|| BA1_TIPREG|| BA1_DIGITO matric "
cquery += CRLF+"   FROM "+ RetSqlName("BA1") + " BA1  "
cquery += CRLF+"  WHERE BA1_FILIAL = '" + xFilial("BA1") + "' AND BA1.D_E_L_E_T_ = ' '"

cquery += CRLF+"    AND BA1_CODCCO =  '"+ cCco145 +"' "
       
//////
If Select(cAliastmp) <> 0 
  (cAliastmp)->(DbCloseArea()) 
Endif
  
 TCQuery cQuery New Alias (cAliastmp)  
    
 dbSelectArea(cAliastmp)
   
 (cAliastmp)->(dbGoTop())           
 
 cMat148:= (cAliastmp)->matric
 
 (cAliastmp)->(DbCloseArea())          

Else         
 
   cMat148:=cMat145 
 
EndIf    

  u_caba148(cMat148, 1)       
  
Return()  
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

Static Function fValEnv(cseq)

local lRet    := .F.   
local lQryEnv := ' '

 
lQryEnv :=" SELECT count(*) QTDA "+ CRLF 
lQryEnv +="   FROM " +RetSqlName('PD5')+ " PD5 "+ CRLF 
lQryEnv +="  WHERE PD5_filial = '" + xFilial('PD5')    + "'"+ CRLF
lQryEnv +="    AND d_E_L_E_T_ = ' ' "+ CRLF
lQryEnv +="    AND PD5_COMPTE = '"+ mv_par01 +"' "+ CRLF                                          

If mv_par02 == 1
   lQryEnv +="    AND PD5_TPENVI = 'Sib Mensal' "+ CRLF
ElseIf mv_par02 == 2
lQryEnv +="    AND PD5_TPENVI = 'Sib Global' "+ CRLF     
EndIf    
lQryEnv +="    AND PD5_sequen = '"+cSeq+"' "+ CRLF                
lQryEnv +="    AND PD5_ENVIAD = 'T' "+ CRLF
///////////////////////////////         

If Select(cAliasEnv) <> 0 
      
  (cAliasEnv)->(DbCloseArea()) 
 
Endif 
                            
TcQuery lQryEnv New Alias (cAliasEnv)          

If (cAliasEnv)->QTDA > 0
    lRet:= .T.
End    

                         
Return (lRet)

Static Function AjustaSX1()

Local aHelp 	:= {}

aHelp := {}
aAdd(aHelp, "Informe a Competencia do Sib")
PutSX1(cPerg , "01" , "Compet do sib (AAAAMM)" ,"","","mv_ch1","C",6,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aAdd(aHelp, "Tipo de Envio Sib")
PutSX1(cPerg,"02", "Tipo de Envio Sib"         ,"","","mv_ch2","N",1,0,1,"C","","","","","mv_par02","Sib Mensal"	,"","","","Sib Global","","","Todos","","","","","","","","",aHelp,aHelp,aHelp)

aAdd(aHelp, "Tipo de Acao do Sib ")
PutSX1(cPerg,"03", "Tipo de Acao do Sib"        ,"","","mv_ch3","N",1,0,1,"C","","","","","mv_par03","Inclusoes"	,"","","","Exclusões","","","Retificações","","","Reativação","","","Todos","","",aHelp,aHelp,aHelp)

aAdd(aHelp, "Sequencia do Sib ")
PutSX1(cPerg , "04" , "Sequencia"           ,"","","mv_ch4","C",2,0,0,"G","","","","","mv_par04"," ","","",""," ","",""," ","","","","","","","","",aHelp,aHelp,aHelp)
 
aAdd(aHelp, "Criticas ")
PutSX1(cPerg,"05", "Criticas ","","","mv_ch5","N",1,0,1,"C","","","","","mv_par05","Com Criticas "	,"","","","Sem Criticas ","","","Todos","","","","","","","","",aHelp,aHelp,aHelp) 

aAdd(aHelp, "Enviados ")
PutSX1(cPerg,"06", "Enviados","","","mv_ch6","N",1,0,1,"C","","","","","mv_par06","Enviados "	,"","","","Não Enviados","","","Todos","","","","","","","","",aHelp,aHelp,aHelp)

aAdd(aHelp, "Cod CCo ")
PutSX1(cPerg,"07", "Cod CCo ?","","","mv_ch7","C",12,0,0,"G","","","","","mv_par07"," ","","",""," ","",""," ","","","","","","","","",aHelp,aHelp,aHelp) 

aAdd(aHelp, "Matricula ")
PutSX1(cPerg,"08", "Matricula  ?","","","mv_ch8","C",17,0,0,"G","","","","","mv_par08"," ","","",""," ","",""," ","","","","","","","","",aHelp,aHelp,aHelp) 

aAdd(aHelp, "Nome Usuario  ")
PutSX1(cPerg,"09", "Nome Usuario  ?","","","mv_ch9","C",40,0,0,"G","","","","","mv_par09"," ","","",""," ","",""," ","","","","","","","","",aHelp,aHelp,aHelp)

/*
aAdd(aHelp, "Cod Fornecedor Final  ")
PutSX1(cPerg,"09", "Cod Fornecedor  Ate ?","","","mv_ch9","C",6,0,0,"G","","","","","mv_par09"," ","","",""," ","",""," ","","","","","","","","",aHelp,aHelp,aHelp)
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
   
User Function LEG145()
Local aLegenda

	aLegenda 	:= { 	{ aCdCores[1,1],aCdCores[1,2] },;
						{ aCdCores[2,1],aCdCores[2,2] },;
						{ aCdCores[3,1],aCdCores[3,2] },;
	              		{ aCdCores[4,1],aCdCores[4,2] } }

	                     	
BrwLegenda(cCadastro,"Status" ,aLegenda)         
Return

//////////////////////////////////////////////////////////////////    
STATIC FUNCTION fFazExcel()
                  
	Local aArea        	:= GetArea()
	Local cEmpresa    	:= iIf( cEmpAnt=='01', 'C', 'I')
	Local oFWMsExcel
	Local oExcel
	Local cArquivoA    	:= 'C:\TEMP\'+cEmpresa+'SIB'+SubStr(DtoS(date()),7,2)+SubStr(DtoS(date()),5,2)+SubStr(DtoS(date()),1,4)+STRTRAN(TIME(),":","_")+'.xml'   
	
	Local nRegsA		:= len(	aRetTit )   

	If nRegsA == 0
		Aviso("Não há dados!!!","Dmed - Ir  !",{"OK"})              
	Else 
		oFWMsExcel := FWMSExcel():New()		
		oFWMsExcel:AddworkSheet("SIB")
		oFWMsExcel:AddTable("SIB","Sib")
		oFWMsExcel:AddColumn("SIB","Sib","Tp Acao ",1) 
		oFWMsExcel:AddColumn("SIB","Sib","Cod Cco ",1) 
		oFWMsExcel:AddColumn("SIB","Sib","Matric Operadora",1) 
		oFWMsExcel:AddColumn("SIB","Sib","Nome Usuario ",1) 
		oFWMsExcel:AddColumn("SIB","Sib","Dt Criação",1) 
		oFWMsExcel:AddColumn("SIB","Sib","Enviado?",1) 
   		oFWMsExcel:AddColumn("SIB","Sib","Criticado?",1) 
        oFWMsExcel:AddColumn("SIB","Sib","tipo Sib",1)		
   		oFWMsExcel:AddColumn("SIB","Sib","Sequen.",1) 
   		oFWMsExcel:AddColumn("SIB","Sib","Competencia",1) 
			oFWMsExcel:AddColumn("SIB","Sib","Envia Sib?",1) 
			oFWMsExcel:AddColumn("SIB","Sib","Crit. ANS",1) 
			oFWMsExcel:AddColumn("SIB","Sib","Crit. Operadora",1) 
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
					
			oFWMsExcel:AddRow("SIB","Sib",{;
 				  	aRetTit[I,02] ,;
 				  	aRetTit[I,03] ,;
				  	aRetTit[I,04] ,;
 				  	aRetTit[I,16] ,;
 				  	aRetTit[I,05] ,;
 				  	aRetTit[I,06] ,;
 				    aRetTit[I,07] ,; 
 				    aRetTit[I,08] ,;
 				    aRetTit[I,09] ,;
 				    aRetTit[I,10] ,;                    			  	
				  	aRetTit[I,13] ,;
					aRetTit[I,14] ,;  
				 	aRetTit[I,17] })  /*,;
				  		aRetTit[I,20] ,; 
				  		aRetTit[I,18] ,;
				  		aRetTit[I,19] ,;
				    	aRetTit[I,21] ,;
				  		aRetTit[I,22] ,; 
				  		aRetTit[I,23] ,;
				  		aRetTit[I,24] })*/  	  	
					  	
					  	
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


/*
STATIC FUNCTION fFazExcel()

//	    MsgAlert("Funcionalidade ainda NÃO disponivel !!!!!!.","Atencao!")
                  
	Local aArea        	:= GetArea()
	Local cEmpresa    	:= iIf( cEmpAnt=='01', 'C', 'I')
	Local oFWMsExcel
	Local oExcel
	Local cArquivoA    	:= 'C:\TEMP\'+cEmpresa+'Sib'+SubStr(DtoS(date()),7,2)+SubStr(DtoS(date()),5,2)+SubStr(DtoS(date()),1,4)+STRTRAN(TIME(),":","_")+'.xml'   
	
	Local nRegsA		:= len(	aRetTit )   

	If nRegsA == 0
		Aviso("Não há dados!!!","Dmed - Ir  !",{"OK"})              
	Else 
		oFWMsExcel := FWMSExcel():New()		
		oFWMsExcel:AddworkSheet("SIB")
		oFWMsExcel:AddTable("SIB","Sib")
		oFWMsExcel:AddColumn("SIB","Sib","Tp Acao ",1) 
		oFWMsExcel:AddColumn("SIB","Sib","Cod Cco ",1) 
		oFWMsExcel:AddColumn("SIB","Sib","Matric Operadora",1) 
		oFWMsExcel:AddColumn("SIB","Sib","Nome Usuario ",1)
		oFWMsExcel:AddColumn("SIB","Sib","Dt Criação",1) 
		oFWMsExcel:AddColumn("SIB","Sib","Enviado?",1) 
		oFWMsExcel:AddColumn("SIB","Sib","Criticado?",1) 
		oFWMsExcel:AddColumn("SIB","Sib","tipo Sib",1)		
		oFWMsExcel:AddColumn("SIB","Sib","Sequen.",1) 
		oFWMsExcel:AddColumn("SIB","Sib","Competencia",1) 
		oFWMsExcel:AddColumn("SIB","Sib","Dt Envio",1) 
		oFWMsExcel:AddColumn("SIB","Sib","Dt Retorno",1)
		oFWMsExcel:AddColumn("SIB","Sib","Envia Sib?",1) 
		oFWMsExcel:AddColumn("SIB","Sib","Crit. ANS",1) 
		oFWMsExcel:AddColumn("SIB","Sib","Crit. Operadora",1) 
		oFWMsExcel:AddColumn("SIB","Sib","Controle Arq",1)				               
		oFWMsExcel:AddColumn("SIB","Sib","St. Cont. Envio",1)
		oFWMsExcel:AddColumn("SIB","Sib","Desc Critica Operadora",1) 
		oFWMsExcel:AddColumn("SIB","Sib","Desc Critica ANS",1)  
		oFWMsExcel:AddColumn("SIB","Sib","Usuario Envio",1)				               
		oFWMsExcel:AddColumn("SIB","Sib","Arq. Envio ",1)
		oFWMsExcel:AddColumn("SIB","Sib","Usuario Retorno",1) 
		oFWMsExcel:AddColumn("SIB","Sib","Arq. Retorno ",1) 
		
		ProcRegua(nRegsA) // Atribui quantidade de registros que serão impressos
		
		//Criando as Linhas... Enquanto não for fim da query

        for I = 1 to len(aRetTit)

			IncProc()                                          
					
			oFWMsExcel:AddRow("SIB","Sib",{;
 				  	aRetTit[I,02] ,;
 				  	aRetTit[I,03] ,;
				  	aRetTit[I,04] ,;
 				  	aRetTit[I,16] ,;
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
				  	aRetTit[I,17] ,; 
                    aRetTit[I,15] ,;
				  	aRetTit[I,20] ,; 
				  	aRetTit[I,18] ,;
				  	aRetTit[I,19] ,;
				    aRetTit[I,21] ,;
				  	aRetTit[I,22] ,; 
				  	aRetTit[I,23] ,;
				  	aRetTit[I,24] })      
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
*/