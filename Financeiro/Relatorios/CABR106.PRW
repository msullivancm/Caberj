#Include "Protheus.ch"
#Include "Rwmake.ch"
#Include "Topconn.ch"        
#include "Msole.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CHAMVALID     º Autor ³ Christian Moura        ³ Data ³     ³±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Geração de documento Word para Impressão de Chamados do    º±±
±±º          ³ FILDSERVICE                                                º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CHAMVALID                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

************************************************************
User Function cartaprev
************************************************************        
private cArquivo := "M:\Protheus_Data\IntegracaoProtheusOffice\cartaprev.dot" 
private cCodEmp  :=' '
private cMatric  := ' '
private ctipreg  := ' '
private nConta   := 0                            
private cValTot  := 0.00
private cValParc := 0.00

	Processa({|| WORDIMP()})  // Chamada do Processamento// Substituido pelo assistente de conversao do AP5 IDE em 14/02/00 ==> 	Processa({|| Execute(WORDIMP)})  // Chamada do Processamento	

Return

**********************************************************************
Static FUNCTION WORDIMP()
**********************************************************************
Local cGrava   := 'M:\Protheus_Data\spool\altamiro\cartas\'
Local cItens   := ""
Local cItens2   := ""
Local cNomCli 
Local cCNPJ  
Local cQuery := ' '

//cArquivo := 'M:\RDMakes\configurador\Modelo Chamado.dot' 


// Inicia o Word 
nVez := 1

// Inicializa o Ole com o MS-Word 97 ( 8.0 )	
oWord := OLE_CreateLink('TMsOleWord97')		

OLE_NewFile(oWord,cArquivo)
OLE_SetProperty( oWord, oleWdVisible,   .F. )
OLE_SetProperty( oWord, oleWdPrintBack, .T. ) 


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ SETREGUA -> Indica quantos registros serao processados para a regua ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
    
cQuery :=" SELECT BD6_CODEMP , BD6_MATRIC , BD6_TIPREG ,BA1_NOMUSR nomdep,A1_NOME NOME, A1_END ENDER, A1_EST EST, "
cQuery +=" A1_MUN MUN, A1_BAIRRO BAIRRO, A1_ESTADO ESTADO , A1_CEP CEP , sum(BD6_COPCOB) vlcob "
cQuery +="   FROM SIGA.bd6_erro2  BD6, SA1010 SA1 , BA3010  BA3 , BA1010  BA1 "
cQuery +="  WHERE A1_FILIAL = ' ' AND SA1.D_e_l_e_t_ = ' ' AND BA3_FILIAL = ' ' AND BA3.d_e_l_e_t_ = ' ' "   
cQuery +="    AND BA1_FILIAL = ' ' AND BA1.d_e_l_e_t_ = ' '  AND ba1_codemp = BD6_CODEMP AND BA1_MATRIC = BD6_MATRIC AND BA1_TIPREG = Bd6_TIPREG "
cQuery +="    aND ba3_codemp = BD6_CODEMP AND BA3_MATRIC = BD6_MATRIC AND BA3_CODCLI = a1_cod  "
cQuery +="    AND BD6_CODOPE IN ('PRE2','PREV' ) " 
//cQuery +="    AND BD6_CODEMP = '0001' AND  BD6_MATRIC in ( '034028' ) "
cQuery +="  GROUP BY BD6_CODEMP , BD6_MATRIC , BD6_TIPREG , BA1_NOMUSR, A1_NOME , A1_END , A1_EST , A1_MUN , A1_BAIRRO , A1_ESTADO , A1_CEP "
cQuery +="  ORDER BY  BD6_CODEMP , BD6_MATRIC ,   BD6_TIPREG "

If Select("TMP") > 0
	dbSelectArea("TMP")
	dbclosearea()
Endif

TCQuery cQuery Alias "TMP" New
dbSelectArea("TMP")
tmp->(dbGoTop())
cCodEmp := tmp->BD6_CODEMP 
cMatric := tmp->BD6_MATRIC 
ctipreg := tmp->BD6_TIPREG  
cNomet :=tmp->NOME 
cVlrtot:= 0.00 
nConta  :=0                            

While tmp->(!EOF())
   If  cCodEmp != tmp->BD6_CODEMP .or. cMatric != tmp->BD6_MATRIC
       cValParc  := Transform(cVlrtot  ,"@R 9,999.99") 
       If nConta  = 1                                                          
          OLE_SetDocumentVar(oWord,"w_valor_2"  ,+" Total R$ " + cValParc)                                            
       ElseIf nConta = 2 
          OLE_SetDocumentVar(oWord,"w_valor_3"  ,+" Total R$ " + cValParc)                                            
       ElseIf nConta = 3 
          OLE_SetDocumentVar(oWord,"w_total"  ,+" Total R$ " + cValParc)                                            
       EndIf        
          OLE_UpDateFields(oWord)                                                        
          OLE_SaveAsFile( oWord, cGrava+cNomet + cMatric+".doc" ) 
 //         Ole_PrintFile(oWord,"ALL",,,1) //ativar quando fro pra valer 
       //-- Imprime as variaveis		
       cNomet :=tmp->NOME 		
       cCodEmp := tmp->BD6_CODEMP 
       cMatric := tmp->BD6_MATRIC 
       ctipreg := tmp->BD6_TIPREG 
       nConta  := 0    
       cVlrtot := 0.00  
       cValParc := 0.00                             
   EndIf          
   If cCodEmp == tmp->BD6_CODEMP .and. cMatric == tmp->BD6_MATRIC 
	     cVlrtot += (tmp->vlcob)  
	     cnome := tmp->nomdep 
	     cValParc  := Transform(tmp->vlcob  ,"@R 9,999.99")
	     If nConta = 0  
  	        OLE_SetDocumentVar(oWord,"w_nome_assis"   ,cNomet)       
	        OLE_SetDocumentVar(oWord,"w_end_assis"    ,tmp->ENDER)
	        OLE_SetDocumentVar(oWord,"w_bairro_assis" ,trim (tmp->BAIRRO) +"-"+trim (TMP->MUN)+"-"+trim(TMP->ESTADO))
	        OLE_SetDocumentVar(oWord,"w_cep_assis"    ,tmp->CEP)  
            OLE_SetDocumentVar(oWord,"w_matr_assis1"  ,"0001."+ cCodEmp +"."+cMatric+"-"+tmp->BD6_TIPREG+"-"+substr(cnome,1,30))
            OLE_SetDocumentVar(oWord,"w_valor_1"  ,+"R$ " + cValParc) 
            
            OLE_SetDocumentVar(oWord,"w_matr_assis2"  ," ")
            OLE_SetDocumentVar(oWord,"w_valor_2"  , "  " )                                                                   
            OLE_SetDocumentVar(oWord,"w_matr_assis3"  ," ")
            OLE_SetDocumentVar(oWord,"w_valor_3"  , "  " )       
            OLE_SetDocumentVar(oWord,"w_total"    , "  " )      
                                                                        
         ElseIf nConta = 1              
                OLE_SetDocumentVar(oWord,"w_matr_assis2"  ,"0001."+ cCodEmp +"."+cMatric+"-"+tmp->BD6_TIPREG+"-"+substr(cnome,1,40))
                OLE_SetDocumentVar(oWord,"w_valor_2"  ,+"R$ " + cValParc)    
	     ElseIf nConta = 2 
                OLE_SetDocumentVar(oWord,"w_matr_assis3"  ,"0001."+ cCodEmp +"."+cMatric+"-"+tmp->BD6_TIPREG+"-"+substr(cnome,1,30))
                OLE_SetDocumentVar(oWord," w_valor_3" ,+"R$ " + cValParc)                                             
         EndIf                                                                
      
         nConta += 1
       tmp->(dbSkip())
       EndIf
EndDo     
    cValParc  := Transform(cVlrtot  ,"@R 9,999.99") 
       If nConta  = 1                                                          
          OLE_SetDocumentVar(oWord,"w_valor_2"  ,+" Total R$ " + cValParc)                                            
       ElseIf nConta = 2 
          OLE_SetDocumentVar(oWord,"w_valor_3"  ,+" Total R$ " + cValParc)                                            
       ElseIf nConta = 3 
          OLE_SetDocumentVar(oWord,"w_total"  ,+" Total R$ " + cValParc)                                            
       EndIf                                                                                                                
  OLE_UpDateFields(oWord)
//  Ole_PrintFile(oWord,"ALL",,,1)  //ativa quando for pra valer
                         
//WaitPrt(10)
//-- Imprime as variaveis		
 OLE_SaveAsFile( oWord, cGrava+cNomet+cMatric+ ".doc" )		
OLE_CloseFile( oWord )
OLE_CloseLink( oWord ) 			// Fecha o Documento
               

Return
//Waint para carragar Spool do Word
Static Function WaitPRT(nTime)
Local oDlgPrt,oTimer
	DEFINE MSDIALOG oDlgPrt FROM 0,0 TO 50,100 TITLE "Imprimindo!" PIXEL
		oTimer := TTimer():New( nTime * 1000, {|| oDlgPrt:END() }, oDlgPrt )
		@1,1  SAY "Aguarde..."
		oTimer:lActive   := .T.
	ACTIVATE MSDIALOG oDlgPrt CENTERED
Return                             
