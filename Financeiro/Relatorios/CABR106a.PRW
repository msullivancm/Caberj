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
User Function cartajanela(ccab1,ccab2,ccab3,ccab4,ccab5,cdet1,ctit1,ctit2,ctit3)
************************************************************        
private cArquivo := "M:\Protheus_Data\IntegracaoProtheusOffice\cartajanela4.dot" //Motta 09/01/2012

 //	Processa({|| IMPRIME()})  // Chamada do Processamento// Substituido pelo assistente de conversao do AP5 IDE em 14/02/00 ==> 	Processa({|| Execute(WORDIMP)})  // Chamada do Processamento	

 	Processa({|| WORDIMP()})  // Chamada do Processamento// Substituido pelo assistente de conversao do AP5 IDE em 14/02/00 ==> 	Processa({|| Execute(WORDIMP)})  // Chamada do Processamento	
Return

**********************************************************************                                          

Static FUNCTION WORDIMP()
**********************************************************************
Local cGrava   := 'M:\Protheus_Data\spool\motta\cartas\' //Motta 09/01/2012
Local cQuery := ' '

//cArquivo := 'M:\RDMakes\configurador\Modelo Chamado.dot' 


// Inicia o Word 

// Inicializa o Ole com o MS-Word 97 ( 8.0 )	
oWord := OLE_CreateLink('TMsOleWord97')		

OLE_NewFile(oWord,cArquivo)
OLE_SetProperty( oWord, oleWdVisible,   .F. )
OLE_SetProperty( oWord, oleWdPrintBack, .T. )      

  //     cdet1 := Transform(cdet1  ,"@R 9,999.99") 
       OLE_SetDocumentVar(oWord,"cab1"  ,ccab1)                                           
       OLE_SetDocumentVar(oWord,"cab2"  ,ccab2)                                          
       OLE_SetDocumentVar(oWord,"cab3"  ,ccab3)                                          
       OLE_SetDocumentVar(oWord,"cab4"  ,ccab4)                                          
       OLE_SetDocumentVar(oWord,"cab5"  ,ccab5)                                          
       OLE_SetDocumentVar(oWord,"det1"  ,cdet1)                                          
       OLE_SetDocumentVar(oWord,"tit1"  ,ctit1) 
                                                 
       OLE_SetDocumentVar(oWord,"tit2"  ,iif (!empty (ctit2), ctit2, " "))   
       OLE_SetDocumentVar(oWord,"tit3"  ,iif (!empty (ctit3), ctit3, " "))                                          

       OLE_UpDateFields(oWord)
//  Ole_PrintFile(oWord,"ALL",,,1)  //ativa quando for pra valer
                         
//WaitPrt(10)
//-- Imprime as variaveis		
      OLE_SaveAsFile( oWord, cGrava+ccab1+ ".doc" )		
      OLE_CloseFile( oWord )
      OLE_CloseLink( oWord ) 			// Fecha o Documento
               

Return (.T.)
//Waint para carragar Spool do Word
Static Function WaitPRT(nTime)
Local oDlgPrt,oTimer
	DEFINE MSDIALOG oDlgPrt FROM 0,0 TO 50,100 TITLE "Imprimindo!" PIXEL
		oTimer := TTimer():New( nTime * 1000, {|| oDlgPrt:END() }, oDlgPrt )
		@1,1  SAY "Aguarde..."
		oTimer:lActive   := .T.
	ACTIVATE MSDIALOG oDlgPrt CENTERED
Return                             
