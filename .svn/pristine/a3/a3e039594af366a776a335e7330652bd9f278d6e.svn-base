#Define CRLF Chr(13)+Chr(10)
#INCLUDE "PROTHEUS.ch"                                                                                                                                  
#INCLUDE "TOPCONN.ch"
#INCLUDE "PLSMGER.CH"
#Include "Ap5Mail.Ch"    
/*--------------------------------------------------------------------------
| Programa  | CABA111  | Autor | Altamiro	Affonso    | Data | 21/06/2013  |
|---------------------------------------------------------------------------|              
| Descricao | Aprovação de pagamento por Alçada                             |
|           |                                                               |                                                       
|---------------------------------------------------------------------------|
| Uso       | Pagamento por alçada                                          | 
 --------------------------------------------------------------------------*/

User Function CABA111()

local cRda      := ' ' 
local cNivel     := ' '
local nI := 0  

Private aBrwLin 
Private aCabLin		:= {"Evento", "Loc Dig","Cod Peg","Num.Guia","Origem", "Linha" , "Cod Unm" , "Tbl", "Matricula ","Dt Proc","Proced." , "vlrpag", "Vlr Apres", "Vlr Glo" , "Vlr Unit","Qtd proc"}
Private aTamLin		:= {70,20,20,20,20,20,20,15,20,20,80,40,40,40,40,10}      
//Private aTamLin		:= {80,15,20,20,15,15,15,10,15,15,90,40,40,40}

Private aBrwDem 
Private aCabDem		:= {" " , "Rda","Evento", "Lote Custo" ,  "Comp ent" , "Empresa","Tipo Custo", "Valor" , "Aprovador","Status", "Projeto" }
Private aTamDem		:= {15,120,120,40,30,30,30,40,20,30,25}

private aBrwPEG
// Private aCabPEG		:= {" ", " ","Rda","Grp Pag","Vlr Fat.Amb","Vlr Fat.Hosp","Vlr 31/2 Amb","Vlr 31/2 Hosp", "Vlr Não liberado" , "Vlr Total" , "Vlr Previa","Vlr Glosa","Vlr Aprovado","Vlr Apresentado", "Lib/Pend" , "Nvl","Qtd Cpt"}
Private aCabPEG		:= {" ", " ","Rda","Grp Pag","Vlr Fat.Amb","Vlr Fat.Hosp","Vlr 31/2 Amb","Vlr 31/2 Hosp", "Vlr Não liberado" , "Vlr Total" , "Vlr Previa","Vlr Apresentado","Vlr Glosa","Vlr Aprovado", "Lib/Pend" , "Nvl","Qtd Cpt"}
Private aTamPEG		:= {15 ,15  ,100  ,15       ,40           ,40            ,40            ,40             ,40                  ,40           ,40           , 40        , 40           , 40              ,35          ,08    , 15      }


Private oOk      	:= LoadBitMap(GetResources(),"LBOK")
Private oNo      	:= LoadBitMap(GetResources(),"LBNO")

Private oVerde   	:= LoadBitMap(GetResources(),"ENABLE")
Private oVermelho	:= LoadBitMap(GetResources(),"DISABLE")    
Private oAmarelo	:= LoadBitMap(GetResources(),"BR_AMARELO")

PRIVATE cCadastro	:= "Aprovação pagamento medico "

PRIVATE aCdCores	:= { 	{ 'BR_VERDE'    ,'Aprovado     ' },; 							
							{ 'BR_AMARELO'  ,'Não Aprovado ' },;
							{ 'BR_VERMELHO' ,'Visialização ' }}

PRIVATE aRotina	:=	{	{ "Legenda"		, 'U_LEG111'	    , 0, K_Incluir		} }	

Private aObjects 	:= {}

Private aSizeAut 	:= MsAdvSize() 

private cQryAMP     := ' '     

Private cPerg	    := "CABA111" 
Private cAliasDem   := GetNextAlias()

private nCont       := 0

AjustaSX1()

Pergunte(cPerg,.T.)    
                     
if mv_par11 == 2   

   cCodUsr   := Posicione("SAL", 2, xFilial("SAL")+"909090"+"01", "AL_USER")

else 

    PRIVATE cCodUsr1   := RetCodUsr()

    If !empty(Mv_par05) .or. Mv_par05 <> ' ' 

       cCodUsr   := Mv_par05  

    Else 

   	   cCodUsr   :=  cCodUsr1  	   
       
   EndIf
          
EndIf 

If Mv_par04 == 0
   Mv_par04 := 999999999.99
endIf
// cCodUsr   := '000833'
/*

cQryALL :="SELECT AK_USER " + CRLF 
cQryALL +="  FROM "+RetSqlName('SAL')+ "  SAL  , " +RetSqlName('SAK')+ "  SAK " + CRLF
cQryALL +=" WHERE AL_FILIAL  = '" + xFilial('SAL') + "'  AND SAL.D_E_L_E_T_ = ' ' " + CRLF 
cQryALL +="   AND AK_FILIAL  = '" + xFilial('SAK') + "'  AND SAK.D_E_L_E_T_ = ' ' " + CRLF
cQryALL +="   AND AL_COD = '909090' " + CRLF
cQryALL +="   AND AK_COD = AL_APROV " + CRLF
cQryALL +="   AND AL_USER = '"+cCodUsr +"' ) APR , " + CRLF     

 If Select(("TMP")) <> 0 
       ("TMP")->(DbCloseArea()) 
 Endif
    
    TCQuery cQryALL Alias "TMP" New 
                                                                                           
    dbSelectArea("TMP")
   
    tmp->(dbGoTop())          
*/

// ContComp( )
 
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
//aAdd( aObjects, { 130,  260, lAjustHor, lAjustVert } )
//aAdd( aObjects, { 130,  250, lAjustHor, lAjustVert } )

nSepHoriz   := 5   
nSepVert    := 5
nSepBorHor 	:= 5
nSepBorVert	:= 5

aInfo  		:= { aSizeAut[ 1 ], aSizeAut[ 2 ], aSizeAut[ 3 ], aSizeAut[ 4 ], nSepHoriz, nSepVert, nSepBorHor, nSepBorVert }
aPosObj 	:= MsObjSize( aInfo, aObjects, .T. )

//oDlg  	:= MsDialog():New( aSizeAut[7],00,aSizeAut[3]-100,aSizeAut[5]-10,"Alçada de Pagamento ",,,.F.,,,,,,.T.,,,.T. ) 
//oDlg  	:= MsDialog():New( aSizeAut[7],00,aSizeAut[3]-10 ,aSizeAut[5]-10,"Alçada de Pagamento ",,,.F.,,,,,,.T.,,,.T. ) 
oDlg  		:= MsDialog():New( aSizeAut[7],00,aSizeAut[3] ,aSizeAut[5]+30,"Alçada de Pagamento ",,,.F.,,,,,,.T.,,,.T. ) 


oSayPEG    	:= TSay():New( aPosObj[1][1],aPosObj[1][2],{||'Libera Pagto '},oDlg,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,236,016)

bDbClickPEG	:= {||aBrwPEG[oBrwPEG:nAt,1] := !aBrwPEG[oBrwPEG:nAt,1], oBrwPEG:Refresh()}   

//bChangePEG	:= {||AtuBrwGuia(aBrwPEG[oBrwPEG:nAt,2],aBrwPEG[oBrwPEG:nAt,3])}

//oBrwPEG 	:= TcBrowse():New(aPosObj[1][1]+10,aPosObj[1][2],aPosObj[1][4],aPosObj[1][3],,aCabPEG,aTamPEG,oDlg,,,,bChangePEG,bDbClickPEG,,,,,,,.F.,,.T.,,.F.,,, )

oBrwPEG 	:= TcBrowse():New(aPosObj[1][1]+10,aPosObj[1][2],aPosObj[1][4],aPosObj[1][3],,aCabPEG,aTamPEG,oDlg,,,,,bDbClickPEG,,,,,,,.F.,,.T.,,.F.,,, )

oBrwPEG:SetArray(aBrwPEG) 

// Transform(aBrwPEG[oBrwPEG:nAt,8],'@E  999,999,999.99'),; 
oBrwPEG:bLine := {||{If( aBrwPEG[oBrwPEG:nAt,1],oOk,oNo) ,;
	 If( aBrwPEG[oBrwPEG:nAt,9] > aBrwPEG[oBrwPEG:nAt,12],oVermelho,IF (aBrwPEG[oBrwPEG:nAt,14] > 1 , oAmarelo , oVerde)) ,;
		                   aBrwPEG[oBrwPEG:nAt, 2]		                	 ,;
				           aBrwPEG[oBrwPEG:nAt, 3]                            ,;
	  	    	 Transform(aBrwPEG[oBrwPEG:nAt, 4],'@E  999,999,999.99')      ,;
		 	     Transform(aBrwPEG[oBrwPEG:nAt, 5],'@E  999,999,999.99')      ,;
		 	     Transform(aBrwPEG[oBrwPEG:nAt, 6],'@E  999,999,999.99')      ,; 
			     Transform(aBrwPEG[oBrwPEG:nAt, 7],'@E  999,999,999.99')      ,;		
			     Transform(aBrwPEG[oBrwPEG:nAt, 8],'@E  999,999,999.99')      ,;
			     Transform(aBrwPEG[oBrwPEG:nAt, 9],'@E  999,999,999.99')      ,;
			     Transform(aBrwPEG[oBrwPEG:nAt,12],'@E  999,999,999.99')      ,;
				 Transform(aBrwPEG[oBrwPEG:nAt,17],'@E  999,999,999.99')      ,;
				 Transform(aBrwPEG[oBrwPEG:nAt,15],'@E  999,999,999.99')      ,;
				 Transform(aBrwPEG[oBrwPEG:nAt,16],'@E  999,999,999.99')      ,;
				           aBrwPEG[oBrwPEG:nAt,10]                            ,; 
				           aBrwPEG[oBrwPEG:nAt,11]	                          ,;
				           aBrwPEG[oBrwPEG:nAt,14]	                          }}


oBrwPEG:nScrollType  := 1 // Scroll VCR

lConfirmou 	:= .T.
 
aBut    :={{"PENDENTE", {||marca(),oBrwPEG:Refresh()    }	, "Marcar Todos "    , "Marcar Todos"     } }
aAdd(aBut, {"PENDENTE", {||desmarca(),oBrwPEG:Refresh() }	, "DesMarcar Todos "	, "DesMarcar Todos"	} )
aAdd(aBut, {"PENDENTE", {||demost(),desmarca(),oBrwPEG:Refresh()  }	, "Demostrativo "   	,"Demostrativo"      } )
//aAdd(aBut, {"PENDENTE", {||demlin(),desmarca(),oBrwPEG:Refresh()  }	, "Demostrativo "   	,"Demostrativo"      } )
aAdd(aBut, {"PENDENTE", {||U_LEG111()}	, "Legenda "   	,"Legenda"      } )

//demlin
If mv_par11 == 2    
   lConfirmou := .F.
EndIf 

If  cCodUsr1 == cCodUsr .or. cCodUsr1 == '000310'
    bOk 	:= {|| atrbalcada(), desmarca() ,oBrwPEG:Refresh() }
Else 
	MsgInfo("Usuario Logado "+cCodUsr+" é Diferente do usuario Aprovador "+cCodUsr)
    bOk 	:= {||desmarca() , oBrwPEG:Refresh() }	
EndIf 	    
 // bOk 	:= {||lConfirmou := .T., atrbalcada(),oDlg:End()}   
bCancel := {||lConfirmou := .F.,oDlg:End()}

	
oDlg:Activate(,,,.T.,,,EnchoiceBar(oDlg,bOk,bCancel,,aBut))

If lConfirmou  
	
    For nI := 1 to len(aBrwPEG)

	    If aBrwPEG[nI,1] == .T.

	        If aBrwPEG[nI,10]!='Liberado'

	           cNivel:= aBrwPEG[nI,11]
	         
	            if aBrwPEG[nI,11]  > '01' 
	      
				    cRda+= 'Rda         : ' +  aBrwPEG[nI,2] + CRLF    			 
				    cRda+= 'Grp Pag     : ' +  aBrwPEG[nI,3] + CRLF   
					cRda+= 'Valor Total : R$' + Transform(aBrwPEG[nI,9],'@E  999,999,999.99') + CRLF 
					cRda+= '________________________________________________________________' + CRLF  

	            EndIf

	     	EndIf

	  	EndIf         
	Next

	If !empty (cNivel)

       fEnvEmail(cNivel , cRda ) 	

    EndIf     
	MsgInfo("Processo finalizado")

//	MsgAlert(Left(cBuffer,len(cBuffer)-1))
	
EndIf

Return    

Static Function atrbalcada()

Local nI := 0
	
	For nI := 1 to len(aBrwPEG)

	   If aBrwPEG[nI,1] == .T.
	   
	   Processa({||fazalcada(substr(aBrwPEG[nI,2],1,6) , Iif(aBrwPEG[nI,10]=='Liberado',.T., .F.), aBrwPEG[nI,11], aBrwPEG[nI,9], aBrwPEG[nI,12],aBrwPEG[nI,14])},'Processando...','Processando...',.T.)
   
	   EndIf   

	Next
	
RETURN()	

Static Function fazalcada(cCodRda, lLib , cNvlAlc , cVlrPgto , cVlrPrev, nQtCmp)
Local cQrylin	:= ""
Local cAliasLin	:= GetNextAlias()
local arecnobd7	:= {}
Local i

ProcRegua(0) 
/*
If nCont := cVlrPgto > cVlrPrev  .and. cNvlAlc =='01' 

    MsgAlert("Valor da Previa , R$ "+Transform(cVlrPrev ,'@E 99,999,999.99')+ CRLF +" È Menor que o Total do pagamento , R$ "+Transform(cVlrPgto ,'@E 99,999,999.99') + CRLF +" na Competencia , Favor Verificar ,"+ CRLF + " Pagamento NÃO sera liberado !!! ","Atencao!")
//	RETURN()  alterado em 15/03/21

elseif nQtCmp > 1 .and. cNvlAlc =='01'

    MsgAlert("Pgto Com Mais de Uma Competencia  "  + CRLF + " Pagamento Será Liberado na Alçada Nivel 02 "+ CRLF + " Pagamento NÃO sera liberado !!! ","Atencao!")
//	RETURN() alterado em 15/03/21

endIf  
*/
//If nCont := cVlrPgto <= cVlrPrev  

    for i:=1 to 5
	
	    IncProc('Liberação Em Andamento ...')          
	   
	Next
		
	cQryLin :=" SELECT bd7.R_E_C_N_O_ bd7rec
	cQryLin +="   FROM "+RetSqlName('BD7')+ " BD7  "
	cQryLin +="  WHERE BD7_FILIAL = '" + xFilial('BD7') + "'  AND BD7.D_E_L_E_T_ = ' ' AND BD7_FASE = '3' AND BD7.BD7_SITUAC = '1' AND BD7.BD7_CODEMP <>'9999' " + CRLF
	
   If mv_par07 == 1 
 
      cQryLin +="            AND BD7.BD7_ANOPAG || BD7.BD7_MESPAG = '"+mv_par01+mv_par02+"' " + CRLF
 
   Else                                                                       
 
      cQryLin +="            AND  BD7.BD7_ANOPAG || BD7.BD7_MESPAG >= '201612' AND  BD7.BD7_ANOPAG || BD7.BD7_MESPAG <= '"+mv_par01+mv_par02+"' " + CRLF 
 
   EndIf           
   
   If mv_par10 == 1  
 
      cQryLin += CRLF+" AND BD7_CODLDP <> '0010' "    
 
   ElseIf mv_par10 == 2  
 
      cQryLin += CRLF+" AND BD7_CODLDP =  '0010' "                
 
   EndIf  
   
	cQryLin +="    AND BD7_DATPRO >= '"+dtos(mv_par08)+"'   AND BD7_DATPRO <= '"+dtos(mv_par09)+"' " + CRLF
	            
	cQryLin +="    and Bd7_codrda  = '"+cCodRda+"' " + CRLF 
	       
	If cNvlAlc == '01' 
 
		   cQryLin +="    and BD7_YLIBN1 = ' ' " + CRLF
	
	ElseIf cNvlAlc == '02'
	
	   cQryLin +="    and BD7_YLIBN2 = ' ' " + CRLF
	
	ElseIf cNvlAlc == '03'
	
	   cQryLin +="    and BD7_YLIBN3 = ' ' " + CRLF
	
	ElseIf cNvlAlc == '04'
	
	   cQryLin +="    and BD7_YLIBN4 = ' ' " + CRLF
	
	EndIf      
	          
	cQryLin +="    AND BD7_CONEMP  >= '            ' " + CRLF
	
	cQryLin +="    AND BD7_CONEMP  <= 'zzzzzzzzzzzz' " + CRLF
	
	cQryLin +="    AND ( BD7.BD7_CONPAG = '1' OR BD7.BD7_CONPAG = ' ') AND BD7.BD7_LOTBLO = ' ' AND BD7.BD7_BLOPAG <> '1' AND BD7_NUMLOT = ' ' " + CRLF
    
    cQrylin += "   and BD7_CODLDP <>' ' and BD7_CODPEG <>' ' and BD7_NUMERO <>' ' and BD7_ORIMOV <>' ' and BD7_SEQUEN <> ' '" + CRLF
	
	cQryLin +="    AND BD7_YFAS35 = 'T' " + CRLF 
	
	TcQuery cQryLin New Alias cAliasLin
	
	while !cAliasLin->(EOF())
	       
	      aAdd( arecnobd7,  cAliasLin->bd7rec  )
	      
	      cAliasLin->(DbSkip())
	
	enddo      
	
	cAliasLin->(DbCloseArea())
	
	dBSelectArea("BD7")
	
	For i=1 to len(arecnobd7)
	
	DbGoto(arecnobd7[i])
	
	   
	  RecLock( "BD7" , .F. )
	  
	    IF  CNVLALC == '01' 
	        BD7->BD7_YLIBN1 := CCODUSR                                    
	    ELSEIF CNVLALC == '02'
	        BD7->BD7_YLIBN2 := CCODUSR   
	    ELSEIF CNVLALC == '03'
	        BD7->BD7_YLIBN3 := CCODUSR   
	    ELSEIF CNVLALC == '04'
			BD7->BD7_YLIBN4 :=  CCODUSR   
	    ENDIF  
       
       BD7->BD7_YLIBFA := lLIB
	        
	   BD7->(MSUNLOCK())      
	  	
	Next

//EndIf	
	
	RETURN()	 
	
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
Static Function marcaLin

local nI
	
	For nI := 1 to len(aBrwPEG)

	   aBrwPEG[nI,1]:= .T.
		
	Next
	
RETURN()	

Static Function desmarcalin

local nI
	
	For nI := 1 to len(aBrwPEG)

		   aBrwPEG[nI,1]:= .F.

	Next

RETURN()	
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

cQryPEG :=" SELECT SUBSTR(TAB.NOME,1,35) RDA , SUBSTR(TAB.GRPPAG,1,25) GRPPAG , " + CRLF 
cQryPEG +="        COUNT(DISTINCT TAB.ANOMES) QTD_ANOMES," + CRLF 
cQryPEG +="        SUM (DECODE (TAB.SEQ, '1',(DECODE (TAB.TPCUSTO, 'A', TAB.VALOR_LOTE, 0.00)),0.00)) FATURADA_A , " + CRLF 
cQryPEG +="        SUM (DECODE (TAB.SEQ, '1',(DECODE (TAB.TPCUSTO, 'H', TAB.VALOR_LOTE, 0.00)),0.00)) FATURADA_H , " + CRLF 
cQryPEG +="        SUM (DECODE (TAB.SEQ, '2',(DECODE (TAB.TPCUSTO, 'A', TAB.VALOR_LOTE, 0.00)),0.00)) ATVPRT35_A , " + CRLF 
cQryPEG +="        SUM (DECODE (TAB.SEQ, '2',(DECODE (TAB.TPCUSTO, 'H', TAB.VALOR_LOTE, 0.00)),0.00)) ATVPRT35_H , " + CRLF 
cQryPEG +="        SUM (DECODE (TAB.SEQ, '3',TAB.VALOR_LOTE, 0.00)) ATVPRT35_NL , " + CRLF 
cQryPEG +="        (SUM (TAB.VALOR_LOTE))-(SUM (DECODE (TAB.SEQ, '3',TAB.VALOR_LOTE, 0.00))) VLR_TOTAL , " + CRLF 
cQryPEG +="        NVL(ZZP.VLRTOT, 0.00) VLRTOTP , " + CRLF 

cQryPEG +="        SUM (TAB.VLRGLOSA) VLRGLOSA , " + CRLF
cQryPEG +="        SUM (TAB.VLRAPROV) VLRAPROV , " + CRLF
cQryPEG +="        SUM (TAB.VLRAPERS) VLRAPERS , " + CRLF

// cQryPEG +="        CASE  WHEN (( SUM (TAB.VALOR_LOTE))-(SUM (DECODE (TAB.SEQ, '3' , TAB.VALOR_LOTE, 0.00))) > NVL(ZZP.VLRTOT, 0.00)) THEN 'Pendente' " + CRLF  
cQryPEG +="        CASE " // WHEN (( SUM (TAB.VALOR_LOTE))-(SUM (DECODE (TAB.SEQ, '3' , TAB.VALOR_LOTE, 0.00))) > NVL(ZZP.VLRTOT, 0.00)) THEN 'Pendente' " + CRLF  
cQryPEG +="              WHEN  ( SUM(TAB.VALOR_LOTE) <= APR.AK_LIMMAX and APR.AL_NIVEL = '01' and (COUNT(DISTINCT TAB.ANOMES) = 1))  THEN 'Liberado' " + CRLF 
cQryPEG +="              WHEN  ( SUM(TAB.VALOR_LOTE) <= APR.AK_LIMMAX and APR.AL_NIVEL > '01' AND (COUNT(DISTINCT TAB.ANOMES) >= 1)) THEN 'Liberado' " + CRLF 
cQryPEG +="        ELSE 'Pendente' END MARCA , " + CRLF 
cQryPEG +="        APR.AL_NIVEL NIVEL_APR " + CRLF 




cQryPEG +="   FROM (SELECT AK_USER , AK_NOME , SAK.AK_LIMMIN , SAK.AK_LIMMAX , SAL.AL_NIVEL " + CRLF 
cQryPEG +="           FROM "+RetSqlName('SAL')+ "  SAL  , " +RetSqlName('SAK')+ "  SAK " + CRLF
cQryPEG +="          WHERE AL_FILIAL  = '" + xFilial('SAL') + "'  AND SAL.D_E_L_E_T_ = ' ' " + CRLF 
cQryPEG +="            AND AK_FILIAL  = '" + xFilial('SAK') + "'  AND SAK.D_E_L_E_T_ = ' ' " + CRLF
cQryPEG +="            AND AL_COD = '909090' " + CRLF
cQryPEG +="            AND AK_COD = AL_APROV " + CRLF
cQryPEG +="            AND AL_USER = '"+cCodUsr +"' ) APR , " + CRLF 

cQryPEG +="        (SELECT '1' SEQ ,'faturada ' TIPO , BAU_GRPPAG||' - ' || B16_DESCRI GRPPAG ,bau_CODIGO ||' - ' || BAU_NOME  NOME , " + CRLF
//cQryPEG +="        (SELECT '1' SEQ ,'faturada ' TIPO , BAU_GRPPAG GRPPAG ,bau_CODIGO ||' - ' || BAU_NOME  NOME , " + CRLF
cQryPEG +="                DECODE(TRIM(BAU_CODRET),'1708','P_JURIDICA','0588','P_FISICA','Nao Especificado') Tpessoa , " + CRLF
cQryPEG +="                SUM (BD7_VLRPAG) VALOR_LOTE , " + CRLF

cQryPEG +="                SUM (BD7_VLRGLO) VLRGLOSA , " + CRLF
cQryPEG +="                SUM (BD7_VLRPAG) VLRAPROV , " + CRLF
cQryPEG +="                SUM (BD7_VALORI) VLRAPERS , " + CRLF


cQryPEG +="                BD7_YLIBN1 , BD7_YLIBN2 , BD7_YLIBN3 , BD7_YLIBFA , " + CRLF
cQryPEG +="                ZZT_TPCUST TPCUSTO , bau_CODIGO , " + CRLF
cQryPEG +="                BD7_ANOPAG||BD7_MESPAG ANOMES " + CRLF

cQryPEG +="           FROM "+RetSqlName('BD7')+ " BD7 , "+RetSqlName('BAU')+ " BAU , " + CRLF
cQryPEG +="                "+RetSqlName('B16')+ " B16 , "+RetSqlName('BD6')+ " BD6 , " + CRLF
cQryPEG +="                "+RetSqlName('ZZT')+ " ZZT " + CRLF                               

cQryPEG +="          WHERE BD7_FILIAL = '" + xFilial('BD7') + "'  AND BD7.D_E_L_E_T_ = ' ' 
cQryPEG +="            AND BD7_FASE = '4' " + CRLF
cQryPEG +="            AND BD7.BD7_SITUAC = '1' " + CRLF 
cQryPEG +="            AND BD6_FILIAL = '" + xFilial('BD6') + "'  AND BD6.D_E_L_E_T_ = ' ' " + CRLF
cQryPEG +="            AND B16_FILIAL = '" + xFilial('B16') + "'  AND B16.D_E_L_E_T_ = ' ' " + CRLF
cQryPEG +="            AND ZZT_FILIAL = '" + xFilial('ZZT') + "'  AND ZZT.D_E_L_E_T_ = ' ' " + CRLF
cQryPEG +="            AND BAU_FILIAL = '" + xFilial('BAU') + "'  AND BAU.D_E_L_E_T_ = ' ' AND BAU.R_E_C_D_E_L_ = 0" + CRLF
cQryPEG +="            AND ZZT_CODEV = BD6.BD6_YNEVEN " + CRLF
cQryPEG +="            AND BD7.BD7_CODOPE = '0001' " + CRLF
cQryPEG +="            AND BD7_OPELOT='0001' " + CRLF
cQryPEG +="            AND BD6_CONEMP  >= '            ' " + CRLF
cQryPEG +="            AND BD6_CONEMP  <= 'zzzzzzzzzzzz' " + CRLF   

cQryPEG +="            AND BD6.BD6_BLOPAG <> '1' " + CRLF
cQryPEG +="            AND BD6.BD6_CODOPE = BD7.BD7_CODOPE " + CRLF 
cQryPEG +="            AND BD6.BD6_CODLDP = BD7.BD7_CODLDP " + CRLF
cQryPEG +="            AND BD6.BD6_CODPEG = BD7.BD7_CODPEG " + CRLF
cQryPEG +="            AND BD6.BD6_NUMERO = BD7.BD7_NUMERO " + CRLF
cQryPEG +="            AND BD6.BD6_SEQUEN = BD7.BD7_SEQUEN " + CRLF      
/*
If mv_par10 == 1  
     cQryPEG += CRLF+" AND BD7_CODLDP <> '0010' " + CRLF    
ElseIf mv_par10 == 2  
     cQryPEG += CRLF+" AND BD7_CODLDP =  '0010' " + CRLF                
EndIf                                                                

If mv_par12 == 1  
     cQryPEG += CRLF+" AND bd6_yproj <> ' ' " + CRLF    
ElseIf mv_par12 == 2  
     cQryPEG += CRLF+" AND bd6_yproj =  ' ' " + CRLF                
EndIf      

If !empty(mv_par13)    
     cQryPEG += CRLF+" AND bau_grppag = '"+mv_par13+"' " + CRLF    
EndIf      

If !empty(mv_par14)    
     cQryPEG += CRLF+" AND bd6_codldp = '"+mv_par14+"' " + CRLF    
EndIf      
*/
cQryPEG +="            AND BD7_NUMLOT like '"+mv_par01+mv_par02+ "%' "+ CRLF
            
cQryPEG +="            AND BD7_CONEMP  >= '            ' " + CRLF
cQryPEG +="            AND BD7_CONEMP  <= 'zzzzzzzzzzzz' " + CRLF
cQryPEG +="            AND BD7.BD7_LOTBLO = ' ' " + CRLF 
cQryPEG +="            AND BD7.BD7_BLOPAG <> '1' " + CRLF
cQryPEG +="            AND BAU_GRPPAG = B16_CODIGO " + CRLF  
cQryPEG +="            AND BD7_CODRDA  = BAU_CODIGO " + CRLF
cQryPEG +="            AND BD7_VLRPAG > 0 " + CRLF
cQryPEG +="          GROUP BY BAU_GRPPAG , B16_DESCRI , BAU_CODIGO , BAU_NOME , BAU_CODRET , BD7_YLIBN1 , " + CRLF
cQryPEG +="                BD7_YLIBN2 , BD7_YLIBN3 , BD7_YLIBFA , ZZT_TPCUST , " + CRLF
cQryPEG +="                BD7_ANOPAG||BD7_MESPAG " + CRLF

cQryPEG +="          UNION ALL " + CRLF

//cQryPEG +="         SELECT '2' SEQ ,'Pronta_Conferida' TIPO , BAU_GRPPAG||' - ' || B16_DESCRI GRPPAG ,BAU_CODIGO ||' - '|| BAU_NOME NOME , " + CRLF 
cQryPEG +="         SELECT '2' SEQ ,'Pronta_Conferida' TIPO , BAU_GRPPAG GRPPAG ,BAU_CODIGO ||' - '|| BAU_NOME NOME , " + CRLF 
cQryPEG +="                DECODE(TRIM(BAU_CODRET),'1708','P_JURIDICA','0588','P_FISICA','Nao Especificado') TPESSOA ,SUM (BD7_VLRPAG) VALOR_LOTE , " + CRLF 

cQryPEG +="                0.00 VLRGLOSA , " + CRLF
cQryPEG +="                0.00 VLRAPROV , " + CRLF
cQryPEG +="                0.00 VLRAPERS , " + CRLF

cQryPEG +="                BD7_YLIBN1 , BD7_YLIBN2 , BD7_YLIBN3 , BD7_YLIBFA , ZZT_TPCUST TPCUSTO , bau_CODIGO , BD7_ANOPAG||BD7_MESPAG ANOMES " + CRLF 
 
cQryPEG +="           FROM "+RetSqlName('BD7')+ " BD7 , "+RetSqlName('BAU')+ " BAU , " + CRLF
cQryPEG +="                "+RetSqlName('B16')+ " B16 , "+RetSqlName('BD6')+ " BD6 , " + CRLF
cQryPEG +="                "+RetSqlName('ZZT')+ " ZZT " + CRLF                               

cQryPEG +="          WHERE BD7_FILIAL = '" + xFilial('BD7') + "'  AND BD7.D_E_L_E_T_ = ' ' " + CRLF 
cQryPEG +="            AND BD7_OPEUSR='0001'" + CRLF 
cQryPEG +="            AND BD7.BD7_CODOPE = '0001' " + CRLF 
cQryPEG +="            AND BD7_FASE = '3'   " + CRLF 
cQryPEG +="            AND BD7.BD7_SITUAC = '1' " + CRLF     

If mv_par07 == 1 
   cQryPEG +="            AND BD7.BD7_ANOPAG = '" +mv_par01+ "' " + CRLF     
   cQryPEG +="            AND BD7.BD7_ANOPAG || BD7.BD7_MESPAG >= '"+mv_par01+mv_par02+"' " + CRLF 
   cQryPEG +="            AND BD7.BD7_ANOPAG || BD7.BD7_MESPAG <= '"+mv_par01+mv_par02+"' " + CRLF
Else   
   cQryPEG +="            AND BD7.BD7_ANOPAG BETWEEN '2019' AND '" +mv_par01+ "' " + CRLF     
   cQryPEG +="            AND  BD7.BD7_ANOPAG || BD7.BD7_MESPAG >= '201901' " + CRLF
   cQryPEG +="            AND  BD7.BD7_ANOPAG || BD7.BD7_MESPAG <= '"+mv_par01+mv_par02+"' " + CRLF 
EndIf 
cQryPEG +="            AND BD6_FILIAL = '" + xFilial('BD6') + "'  AND BD6.D_E_L_E_T_ = ' ' " + CRLF
cQryPEG +="            AND B16_FILIAL = '" + xFilial('B16') + "'  AND B16.D_E_L_E_T_ = ' ' " + CRLF
cQryPEG +="            AND ZZT_FILIAL = '" + xFilial('ZZT') + "'  AND ZZT.D_E_L_E_T_ = ' ' " + CRLF
cQryPEG +="            AND BAU_FILIAL = '" + xFilial('BAU') + "'  AND BAU.D_E_L_E_T_ = ' ' AND BAU.R_E_C_D_E_L_ = 0 " + CRLF
cQryPEG +="            AND ZZT_CODEV = BD6.BD6_YNEVEN " + CRLF    
cQryPEG +="            AND BD6.BD6_BLOPAG <> '1' " + CRLF
cQryPEG +="            AND BD6.BD6_CODOPE = BD7.BD7_CODOPE " + CRLF
cQryPEG +="            AND BD6.BD6_CODLDP = BD7.BD7_CODLDP " + CRLF
cQryPEG +="            AND BD6.BD6_CODPEG = BD7.BD7_CODPEG " + CRLF
cQryPEG +="            AND BD6.BD6_NUMERO = BD7.BD7_NUMERO " + CRLF
cQryPEG +="            AND BD6.BD6_SEQUEN = BD7.BD7_SEQUEN " + CRLF 
cQryPEG +="            AND BD7_DATPRO >= '"+dtos(mv_par08)+"'   AND BD7_DATPRO <= '"+dtos(mv_par09)+"' " + CRLF           

If mv_par10 == 1  
    cQryPEG += CRLF+"      AND BD7_CODLDP <> '0010'  " + CRLF    
ElseIf mv_par10 == 2  
    cQryPEG += CRLF+"      AND BD7_CODLDP =  '0010'  " + CRLF                
EndIf  

If mv_par12 == 1  
     cQryPEG += CRLF+" AND bd6_yproj <> ' ' " + CRLF    
ElseIf mv_par12 == 2  
     cQryPEG += CRLF+" AND bd6_yproj =  ' ' " + CRLF                
EndIf      
   
If !empty(mv_par13)    
     cQryPEG += CRLF+" AND bau_grppag = '"+mv_par13+"' " + CRLF    
EndIf      

If !empty(mv_par14)    
     cQryPEG += CRLF+" AND bd6_codldp = '"+mv_par14+"' " + CRLF    
EndIf 

cQryPEG +="            AND BD7.BD7_CONPAG <> '0' " + CRLF
cQryPEG +="            AND BD7.BD7_LOTBLO = ' '  " + CRLF
cQryPEG +="            AND BD7.BD7_BLOPAG <> '1' " + CRLF
cQryPEG +="            AND BD7_YFAS35 = 'T'      " + CRLF
cQryPEG +="            AND BAU_GRPPAG = B16_CODIGO  " + CRLF  
cQryPEG +="            AND BD7_CODRDA = BAU_CODIGO " + CRLF 

//cQryPEG +="            AND BD7_YLIBFA  = 'T' " + CRLF

cQryPEG +="            AND BD7_VLRPAG > 0           " + CRLF

cQryPEG +="          GROUP BY  BAU_GRPPAG, B16_DESCRI , BAU_CODIGO ,  BAU_NOME, BAU_CODRET , " + CRLF  
cQryPEG +="                BD7_YLIBN1 , BD7_YLIBN2 , BD7_YLIBN3 , BD7_YLIBFA  ,ZZT_TPCUST, BD7_ANOPAG||BD7_MESPAG " + CRLF
      
cQryPEG +="          UNION ALL " + CRLF

//cQryPEG +="         SELECT '3' SEQ ,'Pronta_Conferida nao Liberada' TIPO , BAU_GRPPAG||' - ' || B16_DESCRI GRPPAG ,BAU_CODIGO ||' - '|| BAU_NOME NOME , " + CRLF  
cQryPEG +="         SELECT '3' SEQ ,'Pronta_Conferida nao Liberada' TIPO , BAU_GRPPAG GRPPAG ,BAU_CODIGO ||' - '|| BAU_NOME NOME , " + CRLF  
cQryPEG +="                DECODE(TRIM(BAU_CODRET),'1708','P_JURIDICA','0588','P_FISICA','Nao Especificado') TPESSOA ,SUM (BD7_VLRPAG) VALOR_LOTE , " + CRLF 

cQryPEG +="                SUM (BD7_VLRGLO) VLRGLOSA , " + CRLF
cQryPEG +="                SUM (BD7_VLRPAG) VLRAPROV , " + CRLF
cQryPEG +="                SUM (BD7_VALORI) VLRAPERS , " + CRLF


cQryPEG +="                BD7_YLIBN1 , BD7_YLIBN2 , BD7_YLIBN3 , BD7_YLIBFA , ZZT_TPCUST TPCUSTO , bau_CODIGO ," + CRLF 
cQryPEG +="                BD7_ANOPAG||BD7_MESPAG ANOMES " + CRLF     

cQryPEG +="           FROM "+RetSqlName('BD7')+ " BD7 , "+RetSqlName('BAU')+ " BAU , " + CRLF
cQryPEG +="                "+RetSqlName('B16')+ " B16 , "+RetSqlName('BD6')+ " BD6 , " + CRLF
cQryPEG +="                "+RetSqlName('ZZT')+ " ZZT , "+RetSqlName('SAL')+ " SAL , " +RetSqlName('SAK')+ " SAK " + CRLF

cQryPEG +="          WHERE BD7_FILIAL = '" + xFilial('BD7') + "'  AND BD7.D_E_L_E_T_ = ' '  " + CRLF 
cQryPEG +="            AND BD7_OPEUSR = '0001' " + CRLF 
cQryPEG +="            AND BD7.BD7_CODOPE = '0001' " + CRLF 
cQryPEG +="            AND BD7_FASE = '3' " + CRLF 
cQryPEG +="            AND BD7.BD7_SITUAC = '1' " + CRLF 
cQryPEG +="            AND ZZT_CODEV = BD6.BD6_YNEVEN " + CRLF

cQryPEG +="            AND BD6_FILIAL = '" + xFilial('BD6') + "'  AND BD6.D_E_L_E_T_ = ' ' " + CRLF
cQryPEG +="            AND B16_FILIAL = '" + xFilial('B16') + "'  AND B16.D_E_L_E_T_ = ' ' " + CRLF
cQryPEG +="            AND ZZT_FILIAL = '" + xFilial('ZZT') + "'  AND ZZT.D_E_L_E_T_ = ' ' " + CRLF
cQryPEG +="            AND BAU_FILIAL = '" + xFilial('BAU') + "'  AND BAU.D_E_L_E_T_ = ' ' " + CRLF
cQryPEG +="            AND AL_FILIAL  = '" + xFilial('SAL') + "'  AND SAL.D_E_L_E_T_ = ' ' " + CRLF 

cQryPEG +="            AND AK_FILIAL  = '" + xFilial('SAK') + "'  AND SAK.D_E_L_E_T_ = ' ' " + CRLF
cQryPEG +="            AND AL_COD = '909090' " + CRLF
cQryPEG +="            AND AK_COD = AL_APROV " + CRLF
cQryPEG +="            AND AL_USER = '"+cCodUsr +"' " + CRLF 
If mv_par11 == 1 
   cQryPEG +="            AND ((AL_NIVEL = '01' AND BD7_YLIBN1 = ' ' )  "+ CRLF     
   cQryPEG +="             OR  (AL_NIVEL = '02' AND BD7_YLIBN2 = ' ' )  "+ CRLF  
   cQryPEG +="             OR  (AL_NIVEL = '03' AND BD7_YLIBN3 = ' ' )  "+ CRLF  
   cQryPEG +="             OR  (AL_NIVEL = '04' AND BD7_YLIBN4 = ' ' )) "+ CRLF  
EndIf      
If mv_par07 == 1 
   cQryPEG +="            AND BD7.BD7_ANOPAG || BD7.BD7_MESPAG = '"+mv_par01+mv_par02+"' " + CRLF  
    cQryPEG +="           AND BD7.BD7_ANOPAG || BD7.BD7_MESPAG >= '"+mv_par01+mv_par02+"' " + CRLF
   cQryPEG +="            AND BD7.BD7_ANOPAG || BD7.BD7_MESPAG <= '"+mv_par01+mv_par02+"' " + CRLF 
Else 
   cQryPEG +="            AND BD7.BD7_ANOPAG BETWEEN '2019' AND '" +mv_par01+ "' " + CRLF  
   cQryPEG +="            AND BD7.BD7_ANOPAG || BD7.BD7_MESPAG >= '201901' " + CRLF
   cQryPEG +="            AND BD7.BD7_ANOPAG || BD7.BD7_MESPAG <= '"+mv_par01+mv_par02+"' " + CRLF 
EndIf      

If mv_par10 == 1  
    cQryPEG += CRLF+"      AND BD7_CODLDP <> '0010'  " + CRLF    
ElseIf mv_par10 == 2  
    cQryPEG += CRLF+"      AND BD7_CODLDP =  '0010'  " + CRLF                
EndIf  

If mv_par12 == 1  
     cQryPEG += CRLF+" AND bd6_yproj <> ' ' " + CRLF    
ElseIf mv_par12 == 2  
     cQryPEG += CRLF+" AND bd6_yproj =  ' ' " + CRLF                
EndIf      

If !empty(mv_par13)    
     cQryPEG += CRLF+" AND bau_grppag = '"+mv_par13+"' " + CRLF    
EndIf      

If !empty(mv_par14)    
     cQryPEG += CRLF+" AND bd6_codldp = '"+mv_par14+"' " + CRLF    
EndIf 
   
cQryPEG +="            AND BD6.BD6_BLOPAG <> '1' " + CRLF 
cQryPEG +="            AND BD6.BD6_CODOPE = BD7.BD7_CODOPE " + CRLF  
cQryPEG +="            AND BD6.BD6_CODLDP = BD7.BD7_CODLDP " + CRLF 
cQryPEG +="            AND BD6.BD6_CODPEG = BD7.BD7_CODPEG " + CRLF 
cQryPEG +="            AND BD6.BD6_NUMERO = BD7.BD7_NUMERO " + CRLF 
cQryPEG +="            AND BD6.BD6_SEQUEN = BD7.BD7_SEQUEN " + CRLF 
cQryPEG +="            AND BD7_DATPRO >= '"+dtos(mv_par08)+"'   AND BD7_DATPRO <= '"+dtos(mv_par09)+"' " + CRLF
cQryPEG +="            AND BD7.BD7_CONPAG <> '0' " + CRLF 
cQryPEG +="            AND BD7.BD7_LOTBLO = ' ' " + CRLF 
cQryPEG +="            AND BD7.BD7_BLOPAG <> '1' " + CRLF 
cQryPEG +="            AND BD7_YFAS35 = 'T' " + CRLF 
cQryPEG +="            AND BAU_GRPPAG = B16_CODIGO  " + CRLF 
cQryPEG +="            AND BD7_CODRDA  = BAU_CODIGO " + CRLF

cQryPEG +="            AND BD7_YLIBFA  <> 'T' " + CRLF

cQryPEG +="            AND BD7_VLRPAG > 0 " + CRLF 
cQryPEG +="          GROUP BY  BAU_GRPPAG, B16_DESCRI , BAU_CODIGO ,  BAU_NOME, BAU_CODRET ,   BD7_YLIBN1 , BD7_YLIBN2 , " + CRLF 
cQryPEG +="                BD7_YLIBN3 , BD7_YLIBFA  ,ZZT_TPCUST ,BD7_ANOPAG||BD7_MESPAG ) TAB , " + CRLF 

cQryPEG +="       ( SELECT ZZP_CODRDA CODRDA, ZZP_MESPAG MESPAG , ZZP_ANOPAG ANOPAG , " + CRLF 
cQryPEG +="                (SUM(ZZP_VLINHO)+SUM(ZZP_VLINAM)+SUM(ZZP_VLINOD)) VLRTOT   " + CRLF 
cQryPEG +="           FROM " + RetSqlName("ZZP") + " ZZP " + CRLF
cQryPEG +="          WHERE ZZP_FILIAL = '" + xFilial("ZZP") + "' AND  ZZP.D_e_l_e_t_ = ' ' " + CRLF
cQryPEG +="            AND ZZP_ANOPAG||ZZP_MESPAG = '" +mv_par01+mv_par02+ "' " + CRLF
cQryPEG +="            AND ZZP_STATUS NOT IN ('PCA','CCA') " + CRLF
cQryPEG +="          GROUP BY ZZP_CODRDA , ZZP_MESPAG , ZZP_ANOPAG  ) ZZP   " + CRLF
 
cQryPEG +="   where ZZP.CODRDA(+)= TAB.bau_CODIGO  " + CRLF    
/*
If mv_par06 == 3    
    cQryPEG += " and QTD_ANOMES > 1  " + CRLF
EndIf                            
*/
cQryPEG +="  GROUP BY substr(TAB.NOME,1,35) , substr(TAB.GRPPAG,1,25) , TAB.BD7_YLIBN1 , TAB.BD7_YLIBN2 , 
cQryPEG +="  TAB.BD7_YLIBN3 , TAB.BD7_YLIBFA , apr.ak_user , APR.ak_nome , APR.AK_LIMMIN , APR.AK_LIMMAX , APR.al_nivel ,  nvl(ZZP.VLRTOT, 0.00)   " + CRLF

If mv_par11 == 1 .or.  mv_par06 <= 3 
   cQryPEG +="  HAVING  "
   
   If mv_par11 == 1 
      cQryPEG +="  (SUM (DECODE (TAB.SEQ, '2',(DECODE (TAB.TPCUSTO, 'A' , TAB.VALOR_LOTE, 0.00)),0.00)) >= 0 " + CRLF
      cQryPEG +=" OR SUM (DECODE (TAB.SEQ, '2',(DECODE (TAB.TPCUSTO, 'H' , TAB.VALOR_LOTE, 0.00)),0.00)) >= 0 " + CRLF 
      cQryPEG +=" or SUM (DECODE (TAB.SEQ, '3',TAB.VALOR_LOTE, 0.00)) > 0 ) " + CRLF

      cQryPEG +="       AND (((SUM (TAB.VALOR_LOTE))-(SUM (DECODE (TAB.SEQ, '3',TAB.VALOR_LOTE, 0.00))) > APR.AK_LIMMIN ) " + CRLF
      cQryPEG +="        or (APR.AL_NIVEL = '02' AND COUNT(DISTINCT TAB.ANOMES) > 1)" + CRLF
      cQryPEG +="        or ( SUM(TAB.VALOR_LOTE) - SUM(DECODE (TAB.SEQ, '3',TAB.VALOR_LOTE, 0.00)) > sum(nvl(ZZP.VLRTOT, 0.00)) and APR.AL_NIVEL <= '02') )   " + CRLF 
      
      cQryPEG +="       AND  SUM (DECODE (TAB.SEQ, '3',TAB.VALOR_LOTE, 0.00)) > 0 AND SUM (DECODE (TAB.SEQ, '3',TAB.VALOR_LOTE, 0.00)) <= "+strtran(Transform(Mv_par04,'@E 9999999999.99'),',','.')+" " + CRLF 

      cQryPEG +="       AND ( APR.AL_NIVEL = '01' " + CRLF 
      cQryPEG +="        OR   APR.AL_NIVEL = '02' AND TAB.BD7_YLIBN1 <> ' ' " + CRLF 
      cQryPEG +="        OR   APR.AL_NIVEL = '03' AND TAB.BD7_YLIBN2 <> ' ' " + CRLF                      
      cQryPEG +="        OR   APR.AL_NIVEL = '04' AND TAB.BD7_YLIBN3 <> ' ' ) " + CRLF     
   EndIf                                                 
      
   If mv_par11 == 1   .and. mv_par06 <= 3 
      cQryPEG +=" AND " 
   endIf    
    
   If  mv_par06 == 1     
       cQryPEG +="  SUM(TAB.VALOR_LOTE) - SUM(DECODE (TAB.SEQ, '3',TAB.VALOR_LOTE, 0.00)) <=  sum(nvl(ZZP.VLRTOT, 0.00)) " + CRLF
   ElseIf mv_par06 == 2 
       cQryPEG +="  SUM(TAB.VALOR_LOTE) - SUM(DECODE (TAB.SEQ, '3',TAB.VALOR_LOTE, 0.00)) >   sum(nvl(ZZP.VLRTOT, 0.00)) " + CRLF  
   ElseIf mv_par06 == 3 

       cQryPEG += "COUNT(DISTINCT TAB.ANOMES) >= 1      
  //  cQryPEG += " QTD_ANOMES > 1  " + CRLF

   EndIf  
        
EndIf

If Mv_par03 == 1
   cQryPEG +="    ORDER BY 1 " + CRLF 
Else  
   cQryPEG +="    ORDER BY 2 , 1 " + CRLF 
EndIf                                                                    

                        
TcQuery cQryPEG New Alias cAliasPEG

While !cAliasPEG->(EOF())

	aAdd(aRetPEG,{.F.                  ,; //1
	            cAliasPEG->RDA         ,; //2
			    cAliasPEG->GRPPAG      ,; //3
				cAliasPEG->FATURADA_A  ,; //4
				cAliasPEG->FATURADA_H  ,; //5
			    cAliasPEG->ATVPRT35_A  ,; //6
				cAliasPEG->ATVPRT35_H  ,; //7
				cAliasPEG->ATVPRT35_NL ,; //8
				cAliasPEG->VLR_TOTAL   ,; //9
				cAliasPEG->MARCA       ,; //10
				cAliasPEG->NIVEL_APR   ,; //11
				cAliasPEG->VLRTOTP     ,; //12
			    .T.                    ,; //13
				cAliasPEG->QTD_ANOMES  ,; //14
				cAliasPEG->VLRGLOSA    ,; //15
				cAliasPEG->VLRAPROV    ,; //16
				cAliasPEG->VLRAPERS    }) //17

	cAliasPEG->(DbSkip())

EndDo
  
cAliasPEG->(DbCloseArea())

If empty(aRetPEG)
//	aAdd(aRetPEG,{.f.,'','',  '', '', '', '', '','','','','',.T.,'', ' '})
	aAdd(aRetPEG,{.f.,; //1
	               '',; //2
				   '',; //3
				   0 ,; //4
				   0 ,; //5
				   0 ,; //6
				   0 ,; //7
				   0 ,; //8
				   0 ,; //9
				   '',; //10
				   '',; //11
				   0 ,; //12
				  .T.,; //13
				   0 ,; //14
				   0 ,; //15
				   0 ,; //16
				   0})  //17
EndIf

Return aRetPEG

/********************************************/
/********************************************/
Static Function demost()
  local cCodRdaD := ' ' 
  local nI
  
  Private lfaz:= .F.
 
  
  For nI := 1 to len(aBrwPEG)
      If aBrwPEG[nI,1] == .T.
         cCodRdaD:= substr(aBrwPEG[nI,2],1,6)
    
         Processa({||aBrwDem := aDadosDem(cCodRdaD)},'Pro Demonstrativo ...','buscando dados no servido ...',.T.)
      
         oDlg1  		:= MsDialog():New( aSizeAut[7]-30,00,aSizeAut[3]-250,aSizeAut[5]-70,"Composição do Pagamento - Peg",,,.F.,,,,,,.T.,,,.T. ) 
        ///oDlg1  		:= MsDialog():New( aSizeAut[7],00,aSizeAut[3]-50,aSizeAut[5]-20,"Composição do Pagamento ",,,.F.,,,,,,.T.,,,.T. ) 

         oSayDem    	:= TSay():New( aPosObj[1][1],aPosObj[1][2],{||'Composição do pagto - Peg'},oDlg1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,236,016)
         
         bDbClickDem	:= {||aBrwDem[oBrwDem:nAt,1] := !aBrwDem[oBrwDem:nAt,1], oBrwDem:Refresh()}   

         oBrwDem 	    := TcBrowse():New(aPosObj[1][1]+10,aPosObj[1][2],aPosObj[1][4],aPosObj[1][3]-50,,aCabdem,aTamdem,oDlg1,,,,,bDbClickDem ,,,,,,,.F.,,.T.,,.F.,,, )
      //   oBrwDem 	    := TcBrowse():New(10,5,610,190,,aCabdem,aTamdem,                                                 oDlg1,,,,,bDbClickDem ,,,,,,,.F.,,.T.,,.F.,,, )
         //oBrwDem  	    := TcBrowse():New(5,5,610,10,,aCabdem,aTamdem,oDlg1,,,,,bDbClickDem,,,,,,,.F.,,.T.,,.F.,,, )

        //oBrwDem 	    := TcBrowse():New(aPosObj[1][1]+10,aPosObj[1][2],aPosObj[1][4],aPosObj[1][3],,aCabdem,aTamdem,oDlg,,,,,bDbClickPEG,,,,,,,.F.,,.T.,,.F.,,, )

         oBrwDem:SetArray(aBrwDem) 
         
    	  oBrwDem:bLine  := {||{If( aBrwDem[oBrwDem:nAt,1],oOk,oNo)           ,;
									AllTrim(aBrwDem[oBrwDem:nAt,2])	    	  ,;									
									AllTrim(aBrwDem[oBrwDem:nAt,3])	   		  ,;
   								    AllTrim(aBrwDem[oBrwDem:nAt,8])	    	  ,;
								    Alltrim(aBrwDem[oBrwDem:nAt,4])		      ,;
								            aBrwDem[oBrwDem:nAt,5]	    	  ,;
                                    Alltrim(aBrwDem[oBrwDem:nAt,6])			  ,;
						          Transform(aBrwDem[oBrwDem:nAt,7],'@E  999,999,999.99'),;
                                    Alltrim(aBrwDem[oBrwDem:nAt,9])			  ,;
                                    Alltrim(aBrwDem[oBrwDem:nAt,10])	      ,;
                                    Alltrim(aBrwDem[oBrwDem:nAt,11])	      }}
						
			  oBrwDem:nScrollType  := 1 // Scroll VCR
			  
		     aBut1    :={{"PENDENTE", {||marcalin(),oBrwDem:Refresh()             }	, "Marcar Todos "    , "Marcar Todos"     } }
			 aAdd(aBut1, {"PENDENTE", {||desmarcalin(),oBrwDem:Refresh()          }	, "DesMarcar Todos " , "DesMarcar Todos"  } )
			 aAdd(aBut1, {"PENDENTE", {||demlin(),desmarcalin(),oBrwDem:Refresh() }	, "Demost. Linha "   , "Demost. Linha "   } )

  	      bOk 	  := {|| lfaz:=.F.,oDlg1:End()}
          bCancel := {|| lfaz:=.F.,oDlg1:End()}

          oDlg1:Activate(,,,.T.,,,EnchoiceBar(oDlg1,bOk,bCancel,,aBut1))
		
      EndIf 
   Next

RETURN()	
/********************************************/
/********************************************/
Static Function aDadosDem(cCodRdaD)

Local aRetDem	  := {}
Local cQryDem	  := " "

//Local cAliasDem := GetNextAlias()
local cRdacodA  := ' ' 
local cRdacod   := cCodRdaD
local lFaz      := .T.
local i

ProcRegua(0) 

nCont := 0

for i:=1 to 5
    IncProc('Buscando Dados no Servidor ...')
next     
     
    If cRdaCodA != cRdaCod .and. lfaz == .T.
       lfaz := .T.
       cRdaCodA := cRdaCod	        	

		cQryDem :="         SELECT TRIM(bd7_codrda||' - '||bd7_nomrda) Rda, " + CRLF
		cQryDem +="                TRIM(zzt_codev ||' - '||zzt_evento)  evento , " + CRLF
		cQryDem +="                trim(bd7_anopag)||'/'||Trim(bd7_mespag) custo_ent , " + CRLF
		If cEmpAnt == '01'
		     cQryDem +="      CASE WHEN bd7_codemp = '0024' THEN 'Prefeitura' " + CRLF
			 cQryDem +="           WHEN bd7_codemp = '0025' THEN 'Prefeitura' " + CRLF
			 cQryDem +="           WHEN bd7_codemp = '0026' THEN 'Prefeitura' " + CRLF
			 cQryDem +="           WHEN bd7_codemp = '0027' THEN 'Prefeitura' " + CRLF
			 cQryDem +="           WHEN bd7_codemp = '0028' THEN 'Prefeitura' " + CRLF
			 cQryDem +="           Else 'Rede' END  EMP , " + CRLF
		Else 	 
			 cQryDem +="          'Empresarial '  EMP , " + CRLF
		EndIf 	 
		cQryDem +="                SUM(BD7_VLRPAG) VALOR_LOTE , " + CRLF
		cQryDem +="                decode(ZZT_TPCUST, 'A', 'Ambulatorial' , 'Hospitalar') TPCUSTO , bd6_yproj proj , bd7_numlot numlot ," + CRLF  
		cQryDem +="                nvl(substr(al_desc,1,15),'Não Avaliado')  Aprovador, decode(bd7_ylibfa,'T','Liberado','Pendente') Lib " + CRLF
		cQryDem +="           FROM "+RetSqlName('BD7')+ " BD7 , "+RetSqlName('BD6')+" BD6 , "+RetSqlName('ZZT')+ " ZZT  , " + CRLF
		cQryDem +="                "+RetSqlName('SAL')+ " SAL  " + CRLF
		cQryDem +="          WHERE BD7_FILIAL = '" + xFilial('BD7') + "'  AND BD7.D_E_L_E_T_ = ' ' AND BD7_FASE = '3' AND BD7.BD7_SITUAC = '1' AND BD7.BD7_CODEMP <>'9999' " + CRLF 
		cQryDem +="            AND BD6_FILIAL = '" + xFilial('BD6') + "'  AND BD6.D_E_L_E_T_ = ' ' " + CRLF
		cQryDem +="            AND ZZT_FILIAL = '" + xFilial('ZZT') + "'  AND ZZT.D_E_L_E_T_ = ' ' " + CRLF
		cQryDem +="            AND AL_FILIAL(+)  = '" + xFilial('SAL') + "'  AND SAL.D_E_L_E_T_(+) = ' ' " + CRLF 
		
		cQryDem +="            AND AL_COD(+) = '909090' " + CRLF
		cQryDem +="            AND AL_USER(+) = ( CASE WHEN BD7.BD7_YLIBN4 <> ' ' THEN BD7.BD7_YLIBN4 " + CRLF
		cQryDem +="                                 WHEN BD7.BD7_YLIBN3 <> ' ' THEN BD7.BD7_YLIBN3 " + CRLF  
		cQryDem +="                                 WHEN BD7.BD7_YLIBN2 <> ' ' THEN BD7.BD7_YLIBN2 " + CRLF 
  		cQryDem +="                                 WHEN BD7.BD7_YLIBN1 <> ' ' THEN BD7.BD7_YLIBN1 " + CRLF
		cQryDem +="                                 Else ' ' END)  " + CRLF 
		
		cQryDem +="             AND BD7.BD7_CODOPE = '0001' " + CRLF 

	    cQryDem +="     	   AND siga.RETORNA_EVENTO_BD5(BD6_OPEUSR,BD6_CODLDP, BD6_CODPEG,BD6_NUMERO,BD6_ORIMOV,BD6_CODPAD,BD6_CODPRO,'"+ iif(cEmpAnt=='01','C','I') + "' ) = ZZT_CODEV "+ CRLF
		cQryDem +="            AND BD6_CONEMP  >= '            ' " + CRLF
		cQryDem +="            AND BD6_CONEMP  <= 'zzzzzzzzzzzz' " + CRLF
		cQryDem +="            AND ( BD6.BD6_CONPAG = '1' OR BD6.BD6_CONPAG = ' ') " + CRLF 
		cQryDem +="            AND BD6.BD6_BLOPAG <> '1' " + CRLF
		cQryDem +="            AND BD6.BD6_CODOPE = BD7.BD7_CODOPE " + CRLF
		cQryDem +="            AND BD6.BD6_CODLDP = BD7.BD7_CODLDP " + CRLF
		cQryDem +="            AND BD6.BD6_CODPEG = BD7.BD7_CODPEG " + CRLF
		cQryDem +="            AND BD6.BD6_NUMERO = BD7.BD7_NUMERO " + CRLF
		cQryDem +="            AND BD6.BD6_SEQUEN = BD7.BD7_SEQUEN " + CRLF
		
	If mv_par07 == 1 
      cQryDem +="            AND BD7.BD7_ANOPAG || BD7.BD7_MESPAG = '"+mv_par01+mv_par02+"' " + CRLF
   Else 
    //cQryPEG +="            AND  BD7.BD7_ANOPAG || BD7.BD7_MESPAG <= '"+mv_par01+mv_par02+"' " + CRLF 
      cQryDem +="            AND  BD7.BD7_ANOPAG || BD7.BD7_MESPAG >= '201901' AND  BD7.BD7_ANOPAG || BD7.BD7_MESPAG <= '"+mv_par01+mv_par02+"' " + CRLF 
   EndIf  
   If mv_par10 == 1  
      cQryDem += CRLF+" AND BD7_CODLDP <> '0010' "    
   ElseIf mv_par10 == 2  
      cQryDem += CRLF+" AND BD7_CODLDP =  '0010' "                
   EndIf  
   
   If mv_par12 == 1  
     cQryDem += CRLF+" AND bd6_yproj <> ' ' " + CRLF    
   ElseIf mv_par12 == 2  
     cQryDem += CRLF+" AND bd6_yproj =  ' ' " + CRLF                
   EndIf      

		cQryDem +="            AND BD7_DATPRO >= '"+dtos(mv_par08)+"'   AND BD7_DATPRO <= '"+dtos(mv_par09)+"' " + CRLF
		cQryDem +="            AND BD7_CONEMP  >= '            ' " + CRLF
		cQryDem +="            AND BD7_CONEMP  <= 'zzzzzzzzzzzz' " + CRLF
		cQryDem +="            AND ( BD7.BD7_CONPAG = '1' OR BD7.BD7_CONPAG = ' ') AND BD7.BD7_LOTBLO = ' ' AND BD7.BD7_BLOPAG <> '1' " + CRLF 
//		cQryDem +="            AND BD7_NUMLOT = ' ' " + CRLF     
        cQryDem +="           and BD7_CODLDP <>' ' and BD7_CODPEG <>' ' and BD7_NUMERO <>' ' and BD7_ORIMOV <>' ' and BD7_SEQUEN <> ' '" + CRLF
		
		cQryDem +="            AND BD7_YFAS35 = 'T' " + CRLF
		cQryDem +="            AND BD7_VLRPAG > 0 " + CRLF	
		cQryDem +="            AND BD7_codrda =  '"+cRdaCodA+"'" + CRLF
   
		cQryDem +="       GROUP BY  TRIM(Bd7_codrda||' - '||bd7_nomrda),trim(zzt_codev ||' - '||zzt_evento) , " + CRLF
		cQryDem +="                trim(bd7_anopag)||'/'||trim(bd7_mespag) , " + CRLF
        cQryDem +="                 CASE WHEN bd7_codemp = '0024' THEN 'Prefeitura' " + CRLF
        cQryDem +="                      WHEN bd7_codemp = '0025' THEN 'Prefeitura' " + CRLF
        cQryDem +="                      WHEN bd7_codemp = '0026' THEN 'Prefeitura' " + CRLF
        cQryDem +="                      WHEN bd7_codemp = '0027' THEN 'Prefeitura' " + CRLF
        cQryDem +="                      WHEN bd7_codemp = '0028' THEN 'Prefeitura' " + CRLF
        cQryDem +="                 Else 'Rede' END , " + CRLF 
        cQryDem +="                 decode(ZZT_TPCUST, 'A', 'Ambulatorial' , 'Hospitalar') , bd7_numlot , bd6_yproj, " + CRLF       
        cQryDem +="                 nvl(substr(al_desc,1,15),'Não Avaliado')  , decode(bd7_ylibfa,'T','Liberado','Pendente')" + CRLF        

cQryDem +=" union all "  + CRLF
      
  		cQryDem +="         SELECT TRIM(bd7_codrda||' - '||bd7_nomrda) Rda, " + CRLF
		cQryDem +="                TRIM(zzt_codev ||' - '||zzt_evento)  evento , " + CRLF
		cQryDem +="                trim(bd7_anopag)||'/'||trim(bd7_mespag) custo_ent , " + CRLF
		If cEmpAnt == '01'
		     cQryDem +="      CASE WHEN bd7_codemp = '0024' THEN 'Prefeitura' " + CRLF
			 cQryDem +="           WHEN bd7_codemp = '0025' THEN 'Prefeitura' " + CRLF
			 cQryDem +="           WHEN bd7_codemp = '0026' THEN 'Prefeitura' " + CRLF
			 cQryDem +="           WHEN bd7_codemp = '0027' THEN 'Prefeitura' " + CRLF
			 cQryDem +="           WHEN bd7_codemp = '0028' THEN 'Prefeitura' " + CRLF
			 cQryDem +="           Else 'Rede' END  EMP , " + CRLF
		Else 	 
			 cQryDem +="          'Empresarial '  EMP , " + CRLF
		EndIf 	 
		cQryDem +="                SUM(BD7_VLRPAG) VALOR_LOTE , " + CRLF
		cQryDem +="                decode(ZZT_TPCUST, 'A', 'Ambulatorial' , 'Hospitalar') TPCUSTO ,bd6_yproj proj , bd7_numlot numlot , " + CRLF       
		cQryDem +="                nvl(substr(al_desc,1,15),'Não Avaliado') Aprovador, decode(bd7_ylibfa,'T','Liberado','Pendente') Lib " + CRLF
		
		cQryDem +="           FROM "+RetSqlName('BD7')+ " BD7   , "+RetSqlName('BD6')+ " BD6 , "+RetSqlName('ZZT')+ " ZZT  , " + CRLF
		cQryDem +="                "+RetSqlName('SAL')+ " SAL  " + CRLF
		cQryDem +="          WHERE BD7_FILIAL = '" + xFilial('BD7') + "'  AND BD7.D_E_L_E_T_ = ' ' AND BD7_FASE = '4' AND BD7.BD7_SITUAC = '1' AND BD7.BD7_CODEMP <>'9999' " + CRLF 
		cQryDem +="            AND BD6_FILIAL = '" + xFilial('BD6') + "'  AND BD6.D_E_L_E_T_ = ' ' " + CRLF
		cQryDem +="            AND ZZT_FILIAL = '" + xFilial('ZZT') + "'  AND ZZT.D_E_L_E_T_ = ' ' " + CRLF
		cQryDem +="            AND AL_FILIAL(+) = '" + xFilial('SAL') + "'  AND SAL.D_E_L_E_T_(+) = ' ' " + CRLF 
		
		cQryDem +="            AND AL_COD(+)  = '909090' " + CRLF
		cQryDem +="            AND AL_USER(+) = ( CASE WHEN BD7.BD7_YLIBN4 <> ' ' THEN BD7.BD7_YLIBN4 "  + CRLF
		cQryDem +="                                    WHEN BD7.BD7_YLIBN3 <> ' ' THEN BD7.BD7_YLIBN3 "  + CRLF
		cQryDem +="                                    WHEN BD7.BD7_YLIBN2 <> ' ' THEN BD7.BD7_YLIBN2 "  + CRLF
  		cQryDem +="                                    WHEN BD7.BD7_YLIBN1 <> ' ' THEN BD7.BD7_YLIBN1 " + CRLF
		cQryDem +="                               Else ' ' END)  " + CRLF 
 		
		cQryDem +="            AND BD7.BD7_CODOPE = '0001' " + CRLF 
	    cQryDem +="     	   AND siga.RETORNA_EVENTO_BD5(BD6_OPEUSR,BD6_CODLDP, BD6_CODPEG,BD6_NUMERO,BD6_ORIMOV,BD6_CODPAD,BD6_CODPRO,'"+ iif(cEmpAnt=='01','C','I') + "' ) = ZZT_CODEV "+ CRLF
		cQryDem +="            AND BD6_CONEMP  >= '            ' " + CRLF
		cQryDem +="            AND BD6_CONEMP  <= 'zzzzzzzzzzzz' " + CRLF
		cQryDem +="            AND ( BD6.BD6_CONPAG = '1' OR BD6.BD6_CONPAG = ' ') " + CRLF 
		cQryDem +="            AND BD6.BD6_BLOPAG <> '1' " + CRLF
		cQryDem +="            AND BD6.BD6_CODOPE = BD7.BD7_CODOPE " + CRLF
		cQryDem +="            AND BD6.BD6_CODLDP = BD7.BD7_CODLDP " + CRLF
		cQryDem +="            AND BD6.BD6_CODPEG = BD7.BD7_CODPEG " + CRLF
		cQryDem +="            AND BD6.BD6_NUMERO = BD7.BD7_NUMERO " + CRLF
		cQryDem +="            AND BD6.BD6_SEQUEN = BD7.BD7_SEQUEN " + CRLF
		
	If mv_par07 == 1 
      cQryDem +="              AND BD7.BD7_ANOPAG || BD7.BD7_MESPAG = '"+mv_par01+mv_par02+"' " + CRLF
   Else 
      //cQryDem +="            AND  BD7.BD7_ANOPAG || BD7.BD7_MESPAG <= '"+mv_par01+mv_par02+"' " + CRLF      
      cQryDem +="              AND  BD7.BD7_ANOPAG || BD7.BD7_MESPAG >= '201901' AND  BD7.BD7_ANOPAG || BD7.BD7_MESPAG <= '"+mv_par01+mv_par02+"' " + CRLF 
   EndIf  
   If mv_par10 == 1  
      cQryDem += CRLF+" AND BD7_CODLDP <> '0010' "    
   ElseIf mv_par10 == 2  
      cQryDem += CRLF+" AND BD7_CODLDP =  '0010' "                
   EndIf      
   
   If mv_par12 == 1  
     cQryDem += CRLF+" AND bd6_yproj <> ' ' " + CRLF    
   ElseIf mv_par12 == 2  
     cQryDem += CRLF+" AND bd6_yproj =  ' ' " + CRLF                
  EndIf      

		cQryDem +="            AND BD7_DATPRO >= '"+dtos(mv_par08)+"'   AND BD7_DATPRO <= '"+dtos(mv_par09)+"' " + CRLF
		cQryDem +="            AND BD7_CONEMP  >= '            ' " + CRLF
		cQryDem +="            AND BD7_CONEMP  <= 'zzzzzzzzzzzz' " + CRLF
		cQryDem +="            AND ( BD7.BD7_CONPAG = '1' OR BD7.BD7_CONPAG = ' ') AND BD7.BD7_LOTBLO = ' ' AND BD7.BD7_BLOPAG <> '1' " + CRLF 
		cQryDem +="            AND BD7_NUMLOT like  '"+mv_par01+mv_par02+"%'  " + CRLF 
        cQryDem += "           AND BD7_CODLDP <>' ' and BD7_CODPEG <>' ' and BD7_NUMERO <>' ' and BD7_ORIMOV <>' ' and BD7_SEQUEN <> ' '" + CRLF		
		
		cQryDem +="            AND BD7_YFAS35 = 'T' " + CRLF
		cQryDem +="            AND BD7_VLRPAG > 0 " + CRLF
		
		cQryDem +="            AND BD7_codrda =  '"+cRdaCodA+"'" + CRLF
 
		cQryDem +="       GROUP BY  TRIM(Bd7_codrda||' - '||bd7_nomrda),trim(zzt_codev ||' - '||zzt_evento) , " + CRLF
		cQryDem +="                 trim(bd7_anopag)||'/'||trim(bd7_mespag) , " + CRLF
        cQryDem +="                 CASE WHEN bd7_codemp = '0024' THEN 'Prefeitura' " + CRLF
        cQryDem +="                      WHEN bd7_codemp = '0025' THEN 'Prefeitura' " + CRLF
        cQryDem +="                      WHEN bd7_codemp = '0026' THEN 'Prefeitura' " + CRLF
        cQryDem +="                      WHEN bd7_codemp = '0027' THEN 'Prefeitura' " + CRLF
        cQryDem +="                      WHEN bd7_codemp = '0028' THEN 'Prefeitura' " + CRLF
        cQryDem +="                 Else 'Rede' END , " + CRLF 
        cQryDem +="                 decode(ZZT_TPCUST, 'A', 'Ambulatorial' , 'Hospitalar') , bd7_numlot , bd6_yproj , " + CRLF       
   		cQryDem +="                 nvl(substr(al_desc,1,15),'Não Avaliado') , decode(bd7_ylibfa,'T','Liberado','Pendente')  " + CRLF

        cQryDem +="       Order By 3,2 " + CRLF
	
		TcQuery cQryDem New Alias cAliasDem
		
		While !cAliasDem->(EOF())
			
	 		aAdd(aRetDem,{.F., cAliasDem->RDA , cAliasDem->evento  ,cAliasDem->custo_ent  ,cAliasDem->emp , trim(cAliasDem->TPCUSTO) , cAliasDem->VALOR_LOTE, cAliasDem->numlot, cAliasDem->Aprovador , cAliasDem->Lib , cAliasDem->proj })
				
			cAliasDem->(DbSkip())
			
		EndDo

  	   cAliasDem->(DbCloseArea())

       If empty(aRetDem)

		   aAdd(aRetDem,{'','','','','','',' ',' ',' ',' ' ,' '})
       EndIf
   EndIf     
//Next
Return aRetDem


/***************************************************************************************/
Static Function AjustaSX1()

Local aHelp 	:= {}

aHelp := {}
aAdd(aHelp, "Informe o Ano da Competencia ")
U_CABASX1(cPerg , "01" , "Ano Competencia " 	,"","","mv_ch1","C",4,0,0,"G",""	,"","","","mv_par01","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe o Mês da Competencia ")
U_CABASX1(cPerg , "02" , "Mes Competencia " 	,"","","mv_ch2","C",2,0,0,"G",""	,"","","","mv_par02","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aAdd(aHelp, "Ordernar Por Rda , Grupo de Pagto ")
U_CABASX1(cPerg,"03", "Ordernar Por ","","","mv_ch3","N",1,0,1,"C","","","","","mv_par03","RDA"	,"","","","Grupo de Pagto ","","","","","","","","","","","",aHelp,aHelp,aHelp)


aAdd(aHelp, "Opcao Procedimento")
U_CABASX1(cPerg,"04", "Valor Maximo ","","","mv_ch4","N",13,2,1,"G","","","","","mv_par04",""	,"","","","","","",""	,"","","","","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Operado , 000833 - Max        "+ CRLF)
aAdd(aHelp, "          001240 - Dr. Douglas"+ CRLF)
aAdd(aHelp, "          000241 - Dr. Sandro "+ CRLF)
//aAdd(aHelp, "          000029 - Dr. J.Macedo")
U_CABASX1(cPerg , "05" , "Operado " 	,"","","mv_ch5","C",6,0,0,"G",""	,"","","","mv_par05","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aAdd(aHelp, "Ordernar Por Rda , Grupo de Pagto "+ CRLF)
U_CABASX1(cPerg,"06", "Listar  ","","","mv_ch6","N",1,0,1,"C","","","","","mv_par06","Pagto <= Previa ","","","","Pagto > Previa ","","","+ 1 Competencia","","","Todos","","","Maiores Ofensores","","",aHelp,aHelp,aHelp)

aAdd(aHelp, "Considere so a Competencia De Entrada  para liberar "+ CRLF)
U_CABASX1(cPerg,"07", "Cons. só Competencia de Entrada","","","mv_ch7","N",1,0,1,"C","","","","","mv_par07","Sim "	,"","","","Não ","",""," ","","","","","","","","",aHelp,aHelp,aHelp)

aAdd(aHelp, "Data de Procedimento Inicial , limite inferior da Data de procedimento "+ CRLF)
U_CABASX1(cPerg,"08", "Dt procedimento De ?","","","mv_ch8","D",8,0,0,"G","","","","","mv_par08"," ","","",""," ","",""," ","","","","","","","","",aHelp,aHelp,aHelp)

aAdd(aHelp, "Data de Procedimento Final , limite sUPERIOR da Data de procedimento "+ CRLF)
U_CABASX1(cPerg,"09", "Dt procedimento Ate ?","","","mv_ch9","D",8,0,0,"G","","","","","mv_par09"," ","","",""," ","",""," ","","","","","","","","",aHelp,aHelp,aHelp)

aAdd(aHelp, "Listar sem recuso de glosa , só recurso de glosa ou não considera "+ CRLF)
U_CABASX1(cPerg,"10",OemToAnsi("Com Recurso de Glosa ")         ,"","","mv_ch10","N",01,0,0,"C","","","","","mv_par10","Sem Rec.de glosa","","","","Só Rec. de glosa","","","Todas","","","","","","","","",{},{},{})  

aAdd(aHelp, "Liberar Pagto quando sim mostrar so que tem valor a liberar , quando não lista todos dos itens do custo  "+ CRLF)
U_CABASX1(cPerg,"11",OemToAnsi("Ação  ")         ,"","","mv_ch11","N",01,0,0,"C","","","","","mv_par11","Lib. Pgto ","","","","Auditoria","","","","","","","","","","","",{},{},{})  

aAdd(aHelp, "Listar So Projeto , Sem Projeto , Não Considera  "+ CRLF)
U_CABASX1(cPerg,"12",OemToAnsi("Listar Projeto ? ")         ,"","","mv_ch12","N",01,0,0,"C","","","","","mv_par12","Só Projeto ","","","","Sem Projeto ","","","Todas","","","","","","","","",{},{},{})  

aAdd(aHelp, "Informe Grupo de Pagamento , Em branco lista todos "+ CRLF)
U_CABASX1(cPerg,"13", "Grupo de Pagamento , P/Todos Não Informar ","","","mv_ch13","C",4,0,1,"G","","","","","mv_par13"," ","","",""," ","",""," ","","","","","","","","",aHelp,aHelp,aHelp)

aAdd(aHelp, "Informe Local de Digitação , Em branco lista todos "+ CRLF)
U_CABASX1(cPerg,"14", "Local de Digitação, Branco P/Todos ","","","mv_ch14","C",4,0,1,"G","","","","","mv_par14"," ","","",""," ","",""," ","","","","","","","","",aHelp,aHelp,aHelp)
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
      //cDest+= "altamiro@caberj.com.br ; douglas.futuro@caberj.com.br"
	  cDest+= "altamiro@caberj.com.br ; piumbim@caberj.com.br"
ElseIf cNivel == '02'
      //destinatario Giordano  
      //cDest+= "altamiro@caberj.com.br ; carlabiagioni@caberj.com.br"
	  cDest+= "altamiro@caberj.com.br ; piumbim@caberj.com.br"
ElseIf cNivel == '03'
      //destinatario jose paulo   
      //cDest+= "altamiro@caberj.com.br ; macedo@caberj.com.br"
	  cDest+= "altamiro@caberj.com.br ; piumbim@caberj.com.br"
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



/* cosulta por linhas  **********/

/***********************************************************************************/

Static Function demLin()
 local cCodRdaD := ' ' 
 local cCodEven := ' ' 
 local cEmp 
 local nI
 Private lfaz:= .F.
 
  
  For nI := 1 to len(aBrwDem)
      If aBrwDem[nI,1] == .T.
         cCodRdaD := substr(aBrwdem[nI,2],1,6)
         cCodEven := substr(aBrwdem[nI,3],1,2)  
         cEmp     := aBrwdem[nI,5] 
         cNumlot  := aBrwdem[nI,8]      
         cCmpCust := substr(aBrwdem[nI,4],1,4)+substr(aBrwdem[nI,4],6,2)      
         cproj    := aBrwdem[nI,11]

//Private aBrwLin 
//Private aCabLin		:= {"Evento", "Loc Dig","Cod Peg","Num.Guia","Origem", "Linha" , "Cod Unm" , "Tbl", "Matricula ","Dt Proc","Proced." , "vlrpag", "Vlr Apres", "Vlr Glo" , "Vlr Unit","Qtd proc"}
//Private aTamLin		:= {70,20,20,20,20,20,20,15,20,20,80,40,40,40,40,10}      

		  
         
         Processa({||aBrwlin := aDadoslin(cCodRdaD , cCodeven, cEmp , cNumlot , cCmpCust , cproj )},'Processando Demonstrativo ...','buscando dados no servido ...',.T.)
      
         oDlg2  		:= MsDialog():New( aSizeAut[7]-30,00,aSizeAut[3]-320,aSizeAut[5]-70,"Composição do Pagamento - Linha",,,.F.,,,,,,.T.,,,.T. ) 

         oSayLin    	:= TSay():New( aPosObj[1][1],aPosObj[1][2],{||'Composição do pagto - Linha'},oDlg2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,236,016)

         oBrwlin 	    := TcBrowse():New(aPosObj[1][1]+10,aPosObj[1][2],aPosObj[1][4],aPosObj[1][3]+50,,aCablin,aTamlin,oDlg2,,,,,,,,,,,,.F.,,.T.,,.F.,,, )
 //        oBrwLin 	    := TcBrowse():New(5,5,610,160,,aCablin,aTamlin,oDlg2,,,,,,,,,,,,.F.,,.T.,,.F.,,, )
//oBrwDem 	    := TcBrowse():New(aPosObj[1][1]+10,aPosObj[1][2],aPosObj[1][4],aPosObj[1][3],,aCabdem,aTamdem,oDlg,,,,,bDbClickPEG,,,,,,,.F.,,.T.,,.F.,,, )
•
         oBrwLin:SetArray(aBrwLin) 
         
		 oBrwlin:bLine  := {||{AllTrim(aBrwLin[oBrwLin:nAt,2])	        	       ,;
			                   Alltrim(aBrwLin[oBrwLin:nAt,3])	   		           ,;
								       aBrwLin[oBrwLin:nAt,4]		     		   ,;
								       aBrwLin[oBrwLin:nAt,5]					   ,;
								       aBrwLin[oBrwLin:nAt,6]					   ,;
								       aBrwLin[oBrwLin:nAt,7]					   ,;
								       aBrwLin[oBrwLin:nAt,8]					   ,;
								       aBrwLin[oBrwLin:nAt,9]					   ,;
                               AllTrim(aBrwLin[oBrwLin:nAt,15])	         	       ,;
                               AllTrim(aBrwLin[oBrwLin:nAt,14])	        	       ,;								   
  							   AllTrim(aBrwLin[oBrwLin:nAt,10])      	           ,;
						     Transform(aBrwLin[oBrwLin:nAt,11],'@E  9,999,999.99') ,;
						     Transform(aBrwLin[oBrwLin:nAt,12],'@E  9,999,999.99') ,;
						     Transform(aBrwLin[oBrwLin:nAt,13],'@E  9,999,999.99') ,;     
                             Transform(aBrwLin[oBrwLin:nAt,17],'@E  9,999,999.99') ,;
                             Transform(aBrwLin[oBrwLin:nAt,16],'@R      9,999.00') }}

   	     oBrwLin:nScrollType  := 1 // Scroll VCR
  
         bOk 	   := {|| lfaz:=.F.,oDlg2:End()}

         bCancel := {|| lfaz:=.F.,oDlg2:End()}

         oDlg2:Activate(,,,.T.,,,EnchoiceBar(oDlg2,bOk,bCancel,,,))
		
      EndIf 
   Next

RETURN()	

Static Function aDadoslin(cCodRdaD , cCodevenD , cEmpD , cNumlot , cCmpCust  , cproj )

Local aRetLin  := {}
Local cQryLin	  := ""

Local cAliasLin:= GetNextAlias()
local cRdacodA  := ' ' 
local cRdacod   := cCodRdaD
local cCodevenA := cCodevenD                                       
local cNumlotA  := cNumlot                                         
local cCmpCustA := cCmpCust
local cprojA    := cproj
local cFase     := ' '  
local lFaz      := .T. 
local i

if trim(cNumlot) == '' 
   cFase = '3'
else           
   cFase = '4' 
EndIf    

ProcRegua(0) 

nCont := 0

for i:=1 to 5
    IncProc('Buscando Dados no Servidor ...')
next     
     
    If cRdaCodA != cRdaCod .and. lfaz == .T.
       lfaz := .T.
       cRdaCodA := cRdaCod	        	
       cCodevenA := cCodevenD


cQryLin :=" SELECT TRIM(bd7_codrda||' - '||bd7_nomrda) Rda, " + CRLF
cQryLin +="        TRIM(zzt_codev ||' - '||substr(zzt_evento,1,30))  evento , " + CRLF
cQryLin +="        bd7_codldp locDig , bd7_codpeg CodPeg , bd7_numero NumGuia , bd7_orimov origem , bd7_sequen Linha , BD7_CODUNM codunm , " + CRLF
cQryLin +="        BR8_CODPAD TABELA , substr(br8_codpsa,1,10) ||'-'|| substr(br8_descri,1,40)  proces , " + CRLF
cQryLin +="        BD7_VLRPAG VlrPgto , " + CRLF
cQryLin +="        BD7_VLRMAN VlrApres , " + CRLF
cQryLin +="        BD7_VLRGLO VlrGlo , " + CRLF
cQryLin +="        SUBSTR(bd7_datpro,7,2)||'/'||SUBSTR(bd7_datpro,5,2)||'/'||SUBSTR(bd7_datpro,1,4) DTPRO , " + CRLF
cQryLin +="        bd7_opeusr||bd7_codemp||bd7_matric||bd7_tipreg MATRIC ,  " + CRLF   
cQryLin +="        ROUND(BD6_QTDPRO,2) qtdpro , " + CRLF          
cQryLin +="        ROUND(( BD7_VLRPAG / ROUND(BD6_QTDPRO,2) ),2) vlrunit " + CRLF
cQryLin +="   FROM " + RetSqlName('BD7')+ " BD7 , " + RetSqlName('BD6')+ " BD6 , " + RetSqlName('ZZT')+ " ZZT , " + CRLF
cQryLin +="        " + RetSqlName('SAL')+ " SAL , " + RetSqlName('SAK')+ " SAK , " + RetSqlName('BR8')+ " BR8   " + CRLF
cQryLin +="  WHERE BD7_FILIAL = '  '  AND BD7.D_E_L_E_T_ = ' ' AND BD7_FASE = '"+cFase+"' AND BD7.BD7_SITUAC = '1' AND BD7.BD7_CODEMP <>'9999' " + CRLF
cQryLin +="    AND BD6_FILIAL = '  '  AND BD6.D_E_L_E_T_ = ' ' " + CRLF
cQryLin +="    AND BR8_FILIAL = '  '  AND BR8.D_E_L_E_T_ = ' ' " + CRLF        
cQryLin +="    AND AL_FILIAL  = '01'  AND SAL.D_E_L_E_T_ = ' ' " + CRLF
cQryLin +="    AND AK_FILIAL  = '01'  AND SAK.D_E_L_E_T_ = ' ' " + CRLF
cQryLin +="    AND AL_COD = '909090' " + CRLF
cQryLin +="    AND AK_COD = AL_APROV " + CRLF

cQryLin +="    AND AL_USER = '"+cCodUsr +"' " + CRLF

cQryLin +="    AND siga.RETORNA_EVENTO_BD5(BD6_OPEUSR,BD6_CODLDP, BD6_CODPEG,BD6_NUMERO,BD6_ORIMOV,BD6_CODPAD,BD6_CODPRO,'"+ iif(cEmpAnt=='01','C','I') + "' ) = ZZT_CODEV "+ CRLF
cQryLin +="    AND ZZT_CODEV = '" +cCodevenA+"' " + CRLF

cQryLin +="    AND BD6_CONEMP  >= '            ' " + CRLF
cQryLin +="    AND BD6_CONEMP  <= 'zzzzzzzzzzzz' " + CRLF
cQryLin +="    AND ( BD6.BD6_CONPAG = '1' OR BD6.BD6_CONPAG = ' ') " + CRLF
cQryLin +="    AND BD6.BD6_BLOPAG <> '1' " + CRLF
cQryLin +="    AND BD6.BD6_CODOPE = BD7.BD7_CODOPE " + CRLF
cQryLin +="    AND BD6.BD6_CODLDP = BD7.BD7_CODLDP " + CRLF
cQryLin +="            AND BD6.BD6_CODPEG = BD7.BD7_CODPEG " + CRLF
cQryLin +="            AND BD6.BD6_NUMERO = BD7.BD7_NUMERO " + CRLF
cQryLin +="            AND BD6.BD6_SEQUEN = BD7.BD7_SEQUEN " + CRLF
If  cEmpD = 'Prefeitura'
    cQryLin +="            and bd7_codemp in('0024','0025','0026','0027','0028') " + CRLF
Else     
    cQryLin +="            and bd7_codemp not in('0024','0025','0026','0027','0028') " + CRLF
EndIf 
                           
cQryLin +="                AND BD7.BD7_ANOPAG || BD7.BD7_MESPAG = '"+cCmpCustA+"' " + CRLF

If mv_par10 == 1  
   cQryLin += CRLF+" AND BD7_CODLDP <> '0010' "  + CRLF   
ElseIf mv_par10 == 2  
   cQryLin += CRLF+" AND BD7_CODLDP =  '0010' "  + CRLF              
EndIf   

cQryLin += CRLF+" AND bd6_yproj =  '"+cprojA +"' " + CRLF                

//cQryLin +="            AND BD7_DATPRO >= '20010101' AND BD7_DATPRO <= '"+mv_par01+mv_par02+"31' "+ CRLF    
cQryLin +="              AND BD7_DATPRO >= '"+dtos(mv_par08)+"'   AND BD7_DATPRO <= '"+dtos(mv_par09)+"' " + CRLF

cQryLin +="            AND BD7_CONEMP  >= '            ' " + CRLF
cQryLin +="            AND BD7_CONEMP  <= 'zzzzzzzzzzzz' " + CRLF
cQryLin +="            AND ( BD7.BD7_CONPAG = '1' OR BD7.BD7_CONPAG = ' ') AND BD7.BD7_LOTBLO = ' ' AND BD7.BD7_BLOPAG <> '1' " + CRLF                
cQryLin +="            AND BD7_NUMLOT = '"+cNumlotA+"' " + CRLF 
cQrylin +="            and BD7_CODLDP <>' ' and BD7_CODPEG <>' ' and BD7_NUMERO <>' ' and BD7_ORIMOV <>' ' and BD7_SEQUEN <> ' '" + CRLF

cQryLin +="            AND BD7_YFAS35 = 'T' " + CRLF
cQryLin +="            AND BD7_VLRPAG > 0   " + CRLF

cQryLin +="            AND BD7_codrda = '"+cRdaCodA+"'" + CRLF
If Mv_par11 == 1		
   cQryLin +="            AND ((AL_NIVEL = '01' AND BD7_YLIBN1 = ' ' ) " + CRLF
   cQryLin +="             OR  (AL_NIVEL = '02' AND BD7_YLIBN2 = ' ' ) " + CRLF
   cQryLin +="             OR  (AL_NIVEL = '03' AND BD7_YLIBN3 = ' ' ) " + CRLF
   cQryLin +="             OR  (AL_NIVEL = '04' AND BD7_YLIBN4 = ' ')) " + CRLF
EndIf	  
cQryLin +="            AND BD7_CODPAD = BR8_CODPAD AND Bd7_CODPRO = BR8_CODPSA " + CRLF 

cQryLin +="            ORDER BY 14,15,2,3,4,5,6 " + CRLF
       
       
TcQuery cQryLin New Alias cAliasLin
		
		While !cAliasLin->(EOF())
			
	 		aAdd(aRetLin,{ cAliasLin->RDA     ,; // 1
			               cAliasLin->evento  ,; // 2
						   cAliasLin->locDig  ,; // 3
						   cAliasLin->CodPeg  ,; // 4
						   cAliasLin->NumGuia ,; // 5
						   cAliasLin->origem  ,; // 6
    	 			       cAliasLin->Linha   ,; // 7
						   cAliasLin->codunm  ,; // 8
						   cAliasLin->TABELA  ,; // 9
						   cAliasLin->proces  ,; // 10
						   cAliasLin->VlrPgto ,; // 11
						   cAliasLin->VlrApres,; // 12
    	 			       cAliasLin->VlrGlo  ,; // 13
						   cAliasLin->DTPRO   ,; // 14
						   cAliasLin->MATRIC  ,; // 15
						   cAliasLin->qtdpro  ,; // 16
						   cAliasLin->vlrunit }) // 17
				
			cAliasLin->(DbSkip())
			
		EndDo

  	   cAliasLin->(DbCloseArea())

       If empty(aRetLin)

		   aAdd(aRetLin,{'','','','','','','','','','','','','','','','',''})
		   
       EndIf
   EndIf     
//Next
Return aRetLin      

Static Function ContComp( )
    
cQryAMP :=" select tab1.rda rdaqcmp , count(*) qtdaqcmp" + CRLF
cQryAMP +="  from (select  distinct tab.CODRDA  rda , tab.anomes " + CRLF
cQryAMP +="  FROM ( SELECT BAU_CODIGO CODRDA, bd7_anopag||bd7_mespag anomes " + CRLF
cQryAMP +="           FROM "+RetSqlName('BD7')+ " BD7 , "+RetSqlName('BAU')+ " BAU , "+RetSqlName('B16')+ " B16 , "+RetSqlName('BD6')+ " BD6 , "+RetSqlName('ZZT')+ " ZZT " + CRLF
cQryAMP +="          WHERE BD7_FILIAL = '" + xFilial('BD7') + "'  AND BD7.D_E_L_E_T_ = ' ' AND BD7_FASE = '4' AND BD7.BD7_SITUAC = '1' AND BD7.BD7_CODEMP <>'9999' " + CRLF 
cQryAMP +="            AND BD6_FILIAL = '" + xFilial('BD6') + "'  AND BD6.D_E_L_E_T_ = ' ' " + CRLF
cQryAMP +="            AND B16_FILIAL = '" + xFilial('B16') + "'  AND B16.D_E_L_E_T_ = ' ' " + CRLF
cQryAMP +="            AND ZZT_FILIAL = '" + xFilial('ZZT') + "'  AND ZZT.D_E_L_E_T_ = ' ' " + CRLF
cQryAMP +="            AND BAU_FILIAL = '" + xFilial('BAU') + "'  AND BAU.D_E_L_E_T_ = ' ' " + CRLF
cQryAMP +="            AND ZZT_CODEV = BD6.BD6_YNEVEN " + CRLF
cQryAMP +="            AND BD7.BD7_CODOPE = '0001' " + CRLF 

cQryAMP +="            AND BD6_CONEMP  >= '            ' " + CRLF
cQryAMP +="            AND BD6_CONEMP  <= 'zzzzzzzzzzzz' " + CRLF
cQryAMP +="            AND ( BD6.BD6_CONPAG = '1' OR BD6.BD6_CONPAG = ' ') " + CRLF
cQryAMP +="            AND BD6.BD6_BLOPAG <> '1' " + CRLF
cQryAMP +="            AND BD6.BD6_CODOPE = BD7.BD7_CODOPE " + CRLF
cQryAMP +="            AND BD6.BD6_CODLDP = BD7.BD7_CODLDP " + CRLF
cQryAMP +="            AND BD6.BD6_CODPEG = BD7.BD7_CODPEG " + CRLF
cQryAMP +="            AND BD6.BD6_NUMERO = BD7.BD7_NUMERO " + CRLF
cQryAMP +="            AND BD6.BD6_SEQUEN = BD7.BD7_SEQUEN " + CRLF 

If mv_par07 == 1 
   cQryAMP +="            AND BD7.BD7_ANOPAG || BD7.BD7_MESPAG = '"+mv_par01+mv_par02+"' " + CRLF
Else 
   cQryAMP +="            AND  BD7.BD7_ANOPAG || BD7.BD7_MESPAG <= '"+mv_par01+mv_par02+"' " + CRLF 
EndIf   

If mv_par10 == 1  
      cQryAMP += " AND BD7_CODLDP <> '0010' " + CRLF   
ElseIf mv_par10 == 2  
      cQryAMP += " AND BD7_CODLDP =  '0010' " + CRLF                
Else 
      cQryAMP += CRLF+" AND BD7_CODLDP >=  '    ' " 
EndIf  

cQryAMP +="            AND BD7_NUMLOT like '"+mv_par01+mv_par02+ "%'"+ CRLF
cQryAMP +="            AND BD7_DATPRO >= '"+dtos(mv_par08)+"'   AND BD7_DATPRO <= '"+dtos(mv_par09)+"' " + CRLF
cQryAMP +="            AND BD7_CONEMP  >= '            ' " + CRLF
cQryAMP +="            AND BD7_CONEMP  <= 'zzzzzzzzzzzz' " + CRLF
cQryAMP +="            AND ( BD7.BD7_CONPAG = '1' OR BD7.BD7_CONPAG = ' ') AND BD7.BD7_LOTBLO = ' ' AND BD7.BD7_BLOPAG <> '1' " + CRLF
cQryAMP +="            AND BD7_YFAS35 = 'T' " + CRLF
cQryAMP +="            AND BAU_GRPPAG = B16_CODIGO  AND BD7_CODRDA  = BAU_CODIGO AND BD7_VLRPAG > 0 " + CRLF
  
cQryAMP +="         UNION ALL " + CRLF
 
cQryAMP +="         SELECT BAU_CODIGO CODRDA, bd7_anopag||bd7_mespag anomes " + CRLF
cQryAMP +="           FROM "+RetSqlName('BD7')+ " BD7 , "+RetSqlName('BAU')+ " BAU , "+RetSqlName('B16')+ " B16 , "+RetSqlName('BD6')+ " BD6 , "+RetSqlName('ZZT')+ " ZZT " + CRLF
cQryAMP +="          WHERE BD7_FILIAL = '" + xFilial('BD7') + "'  AND BD7.D_E_L_E_T_ = ' ' AND BD7_FASE = '3' AND BD7.BD7_SITUAC = '1' AND BD7.BD7_CODEMP <>'9999' " + CRLF 
cQryAMP +="            AND BD6_FILIAL = '" + xFilial('BD6') + "'  AND BD6.D_E_L_E_T_ = ' ' " + CRLF
cQryAMP +="            AND B16_FILIAL = '" + xFilial('B16') + "'  AND B16.D_E_L_E_T_ = ' ' " + CRLF
cQryAMP +="            AND ZZT_FILIAL = '" + xFilial('ZZT') + "'  AND ZZT.D_E_L_E_T_ = ' ' " + CRLF
cQryAMP +="            AND BAU_FILIAL = '" + xFilial('BAU') + "'  AND BAU.D_E_L_E_T_ = ' ' " + CRLF
cQryAMP +="            AND ZZT_CODEV = BD6.BD6_YNEVEN " + CRLF 

cQryAMP +="            AND BD7.BD7_CODOPE = '0001' " + CRLF 

cQryAMP +="            AND BD6_CONEMP  >= '            ' " + CRLF
cQryAMP +="            AND BD6_CONEMP  <= 'zzzzzzzzzzzz' " + CRLF
cQryAMP +="            AND ( BD6.BD6_CONPAG = '1' OR BD6.BD6_CONPAG = ' ') " + CRLF 
cQryAMP +="            AND BD6.BD6_BLOPAG <> '1' " + CRLF
cQryAMP +="            AND BD6.BD6_CODOPE = BD7.BD7_CODOPE " + CRLF
cQryAMP +="            AND BD6.BD6_CODLDP = BD7.BD7_CODLDP " + CRLF
cQryAMP +="            AND BD6.BD6_CODPEG = BD7.BD7_CODPEG " + CRLF
cQryAMP +="            AND BD6.BD6_NUMERO = BD7.BD7_NUMERO " + CRLF
cQryAMP +="            AND BD6.BD6_SEQUEN = BD7.BD7_SEQUEN " + CRLF

If mv_par07 == 1 
   cQryAMP +="            AND BD7.BD7_ANOPAG || BD7.BD7_MESPAG = '"+mv_par01+mv_par02+"' " + CRLF
Else 
   cQryAMP +="            AND  BD7.BD7_ANOPAG || BD7.BD7_MESPAG <= '"+mv_par01+mv_par02+"' " + CRLF 
EndIf 

If mv_par10 == 1  
      cQryAMP += " AND BD7_CODLDP <> '0010' " + CRLF    
ElseIf mv_par10 == 2  
      cQryAMP += " AND BD7_CODLDP =  '0010' " + CRLF                
Else 
      cQryAMP += CRLF+" AND BD7_CODLDP >=  '    ' " 
EndIf    

cQryAMP +="            AND BD7_DATPRO >= '"+dtos(mv_par08)+"'   AND BD7_DATPRO <= '"+dtos(mv_par09)+"' " + CRLF
cQryAMP +="            AND BD7_CONEMP  >= '            ' " + CRLF
cQryAMP +="            AND BD7_CONEMP  <= 'zzzzzzzzzzzz' " + CRLF
cQryAMP +="            AND ( BD7.BD7_CONPAG = '1' OR BD7.BD7_CONPAG = ' ') AND BD7.BD7_LOTBLO = ' ' AND BD7.BD7_BLOPAG <> '1' AND BD7_NUMLOT = ' ' " + CRLF
cQryAMP +="            AND BD7_YFAS35 = 'T' " + CRLF
cQryAMP +="            AND BAU_GRPPAG = B16_CODIGO  AND BD7_CODRDA  = BAU_CODIGO AND BD7_VLRPAG > 0 " + CRLF

cQryAMP +="         UNION ALL " + CRLF
 
cQryAMP +="         SELECT BAU_CODIGO CODRDA, bd7_anopag||bd7_mespag anomes " + CRLF
cQryAMP +="           FROM "+RetSqlName('BD7')+ " BD7 , "+RetSqlName('BAU')+ " BAU , "+RetSqlName('B16')+ " B16 , "+RetSqlName('BD6')+ " BD6 , "+RetSqlName('ZZT')+ " ZZT , " + CRLF
cQryAMP +="                "+RetSqlName('SAL')+ "  SAL  , " +RetSqlName('SAK')+ "  SAK " + CRLF
cQryAMP +="          WHERE BD7_FILIAL = '" + xFilial('BD7') + "'  AND BD7.D_E_L_E_T_ = ' ' AND BD7_FASE = '3' AND BD7.BD7_SITUAC = '1' AND BD7.BD7_CODEMP <>'9999' " + CRLF 
cQryAMP +="            AND BD6_FILIAL = '" + xFilial('BD6') + "'  AND BD6.D_E_L_E_T_ = ' ' " + CRLF
cQryAMP +="            AND B16_FILIAL = '" + xFilial('B16') + "'  AND B16.D_E_L_E_T_ = ' ' " + CRLF
cQryAMP +="            AND ZZT_FILIAL = '" + xFilial('ZZT') + "'  AND ZZT.D_E_L_E_T_ = ' ' " + CRLF
cQryAMP +="            AND BAU_FILIAL = '" + xFilial('BAU') + "'  AND BAU.D_E_L_E_T_ = ' ' " + CRLF
cQryAMP +="            AND AL_FILIAL  = '" + xFilial('SAL') + "'  AND SAL.D_E_L_E_T_ = ' ' " + CRLF 
cQryAMP +="            AND AK_FILIAL  = '" + xFilial('SAK') + "'  AND SAK.D_E_L_E_T_ = ' ' " + CRLF

cQryAMP +="            AND AL_COD = '909090' " + CRLF
cQryAMP +="            AND AK_COD = AL_APROV " + CRLF
cQryAMP +="            AND AL_USER = '"+cCodUsr +"' " + CRLF 

cQryAMP +="            AND ZZT_CODEV = BD6.BD6_YNEVEN " + CRLF
cQryAMP +="            AND BD7.BD7_CODOPE = '0001' " + CRLF 
cQryAMP +="            AND BD6_CONEMP  >= '            ' " + CRLF
cQryAMP +="            AND BD6_CONEMP  <= 'zzzzzzzzzzzz' " + CRLF
cQryAMP +="            AND ( BD6.BD6_CONPAG = '1' OR BD6.BD6_CONPAG = ' ') " + CRLF 
cQryAMP +="            AND BD6.BD6_BLOPAG <> '1' " + CRLF
cQryAMP +="            AND BD6.BD6_CODOPE = BD7.BD7_CODOPE " + CRLF
cQryAMP +="            AND BD6.BD6_CODLDP = BD7.BD7_CODLDP " + CRLF
cQryAMP +="            AND BD6.BD6_CODPEG = BD7.BD7_CODPEG " + CRLF
cQryAMP +="            AND BD6.BD6_NUMERO = BD7.BD7_NUMERO " + CRLF
cQryAMP +="            AND BD6.BD6_SEQUEN = BD7.BD7_SEQUEN " + CRLF

If mv_par07 == 1 
   cQryAMP +="            AND BD7.BD7_ANOPAG || BD7.BD7_MESPAG = '"+mv_par01+mv_par02+"' " + CRLF
Else 
   cQryAMP +="            AND  BD7.BD7_ANOPAG || BD7.BD7_MESPAG <= '"+mv_par01+mv_par02+"' " + CRLF 
EndIf               

If mv_par10 == 1  
      cQryAMP += " AND BD7_CODLDP <> '0010' " + CRLF   
ElseIf mv_par10 == 2  
      cQryAMP += " AND BD7_CODLDP =  '0010' " + CRLF               
Else 
      cQryAMP += CRLF+" AND BD7_CODLDP >=  '    ' " 
EndIf 
cQryAMP +="            AND BD7_DATPRO >= '"+dtos(mv_par08)+"'   AND BD7_DATPRO <= '"+dtos(mv_par09)+"' " + CRLF
cQryAMP +="            AND BD7_CONEMP  >= '            ' " + CRLF
cQryAMP +="            AND BD7_CONEMP  <= 'zzzzzzzzzzzz' " + CRLF
cQryAMP +="            AND ( BD7.BD7_CONPAG = '1' OR BD7.BD7_CONPAG = ' ') AND BD7.BD7_LOTBLO = ' ' AND BD7.BD7_BLOPAG <> '1' AND BD7_NUMLOT = ' ' " + CRLF
cQryAMP +="            AND BD7_YFAS35 = 'T' " + CRLF
cQryAMP +="            AND BAU_GRPPAG = B16_CODIGO  AND BD7_CODRDA  = BAU_CODIGO AND BD7_VLRPAG > 0 " + CRLF   

If mv_par11 == 1 
   cQryAMP +="            AND ((AL_NIVEL = '01' AND BD7_YLIBN1 = ' ' )  "+ CRLF     
   cQryAMP +="             OR  (AL_NIVEL = '02' AND BD7_YLIBN2 = ' ' )  "+ CRLF  
   cQryAMP +="             OR  (AL_NIVEL = '03' AND BD7_YLIBN3 = ' ' )  "+ CRLF  
   cQryAMP +="             OR  (AL_NIVEL = '04' AND BD7_YLIBN4 = ' ' )) "+ CRLF  
EndIf      

cQryAMP +="  ) tab " + CRLF      

cQryAMP +=" ) tab1 " + CRLF     
cQryAMP +=" group by tab1.rda order by 1 "

Return ()  

User Function LEG111()

Local aLegenda

	aLegenda 	:= { 	{ aCdCores[1,1],aCdCores[1,2] },;
						{ aCdCores[2,1],aCdCores[2,2] },;
	              		{ aCdCores[3,1],aCdCores[3,2] } }

	                     	
BrwLegenda(cCadastro,"Status" ,aLegenda)

Return
