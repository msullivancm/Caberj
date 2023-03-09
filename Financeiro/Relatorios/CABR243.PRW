#Define CRLF Chr(13)+Chr(10)
#Include "Protheus.ch"
#Include "Rwmake.ch"
#Include "Topconn.ch"        
#include "Msole.CH"      
#Include "Ap5Mail.Ch"
#Include 'Tbiconn.ch'   
#Include "RPTDEF.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±                             
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABR243     º Autor ³ Altamiro         ³ Data ³ 27/09/2017  ³±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Geração de documento Word "carta", para Cobrança de Convenoº±±
±±º          ³ Reciprocidade                                              º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABR243                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

************************************************************ 
//User Function CABR243  
User Function CABR243(  cMesBase1     , cAnoBase1     ,cNumTitI1    ,aNumTitF1     ,cOpeInc1      ,cOpeFim1 , cOrigem)
************************************************************        
private cArquivo := "L:\Protheus_Data\IntegracaoProtheusOffice\CartaConv5.dot" 
//private cArquivo := "M:\Protheus_Data\IntegracaoProtheusOffice\CartaConv5.dot" 
private cCodEmp  := ' '
private cMatric  := ' '
private ctipreg  := ' '
private nConta   := 0                            
private cValTot  := 0.00
private cValParc := 0.00 
private ccpf     := ' '                                                         
private cdtnasc  := ' ' 
private cOrig    := cOrigem 
private cNumTitF1 := ' '
PRIVATE cTitrec   := ' '
private cVLRDMED  := 0.00 
private cVLRADM   := 0.00 
private cVLRINSS  := 0.00    

private cAliasCT    := GetNextAlias()  

private cNomeArq := ' '         
private CEmpresa := ' ' 
private cAssunto := ' '

If cOrig == 2   
   cNumTitF1 := substr(aNumTitF1[2],4,9)   
   cTitrec   := aNumTitF1[2] 
   cVLRDMED  := aNumTitF1[3] 
   cVLRADM   := aNumTitF1[4]
   cVLRINSS  := aNumTitF1[5]   
else                             
   cNumTitF1:= aNumTitF1   
endIf 


Processa({|| WORDIMP()})  // Chamada do Processamento// Substituido pelo assistente de conversao do AP5 IDE em 14/02/00 ==> 	Processa({|| Execute(WORDIMP)})  // Chamada do Processamento	

Return

**********************************************************************
Static FUNCTION WORDIMP()
**********************************************************************
//Local cGrava     := 'M:\Protheus_Data\spool\altamiro\cartas\'
//Local cGrava     := 'L:\Protheus_Data\cart_conv\'  
Local cGrava     := 'M:\Protheus_Data\cart_conv\'    
//Local cGrava     := 'C:\temp\carta_conv\'

Local cItens   := ""
Local cItens2  := ""
Local cNomCli  := " " 
Local cCNPJ  
Local cQuery   := ' '         

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


	cQuery := "SELECT PCS.PCS_OPEORI OPEORI , " + CRLF
	cQuery += "       OPE.NOMOPE NOMOPE ,     " + CRLF
	cQuery += "       SUM(PCS_VLRBPF) VLRBPF , " + CRLF
	cQuery += "       SUM(PCS_VLRTAD) VLRTAD , " + CRLF
	cQuery += "       SUM(PCS_VLRINS) VLRINS , " + CRLF 
	cQuery += "       PCS_MESPAG MESPAG , " + CRLF 
	cQuery += "       PCS_ANOPAG ANOPAG , " + CRLF
	cQuery += "       E1_PREFIXO E1PREF , E1_NUM E1NUM , E1_PARCELA E1PARC ,
	cQuery += "       E1_TIPO E1TIPO , E1_VALOR E1VALOR , E1_EMIS1 EMIS1 , E1_VENCREA VENCREA " + CRLF       
	cQuery += "  FROM "+RetSqlName('PCS')+ " PCS , "+RetSqlName('SE1')+ " SE1 ,"  + CRLF
	cQuery += "       (SELECT '10'||BGH_GRUOPE OPEORI , BA2_DESCRI NOMOPE ,  BGH_VLRTRC VLRCOB " + CRLF                                         
	
	cQuery += "          FROM "+RetSqlName('BGH')+ " BGH,"+RetSqlName('BA2')+ " BA2 " + CRLF
	cQuery += "         WHERE BA2_FILIAL = '"+xFilial("BA2")+"'  AND BA2.D_E_L_E_T_ = ' ' " + CRLF
	cQuery += "           AND BGH_FILIAL = '"+xFilial("BGH")+"'  AND BGH.D_E_L_E_T_ = ' ' " + CRLF
	cQuery += "           AND BGH_DATFIN = ' ' AND BA2_GRUOPE = BGH_GRUOPE ) OPE " + CRLF  
	cQuery += " WHERE PCS_FILIAL = '"+xFilial("PCS")+"' AND PCS.D_E_L_E_T_  = ' ' " + CRLF
	cQuery += "   AND E1_FILIAL = '"+xFilial("SE1")+"' AND SE1.D_E_L_E_T_  = ' ' " + CRLF  
	cQuery += "   AND PCS_PREFIX = E1_PREFIXO  " + CRLF
	cQuery += "   AND PCS_NUMTIT = E1_NUM " + CRLF
	cQuery += "   AND PCS_OPEORI = OPE.OPEORI " + CRLF
	  
	cQuery += "   AND trim(PCS_ANOPAG) = '"+cAnoBase+"'" + CRLF
	cQuery += "   AND trim(PCS_MESPAG) = '"+cMesBase+"'" + CRLF
	  
	cQuery += "   AND PCS_PREFIX = 'COV' " + CRLF
	cQuery += "   AND trim(PCS_NUMTIT) >= '"+cNumTitI+"'" + CRLF 
	cQuery += "   AND trim(PCS_NUMTIT) <= '"+cNumTitI+"'" + CRLF
	  
	cQuery += "   AND trim(PCS_OPEORI) >= '"+cOpeInc+"' AND  trim(PCS_OPEORI) <= '"+cOpeFim+"'  " + CRLF
	
	cQuery += " GROUP BY PCS.PCS_OPEORI , OPE.NOMOPE , PCS_MESPAG , PCS_ANOPAG , E1_VENCREA , "
	cQuery += "          E1_PREFIXO , E1_NUM , E1_PARCELA , E1_TIPO , E1_VALOR , E1_EMIS1 "
	cQuery += "   ORDER BY 1,4 " + CRLF   
	
if cOrig == 2 

	cQuery1 := "SELECT E1_PREFIXO E1PREF , E1_NUM E1NUM , E1_PARCELA E1PARC , " + CRLF
	cQuery1 += "       E1_TIPO E1TIPO , E1_VALOR E1VALOR , E1_EMIS1 EMIS1 , E1_VENCREA VENCREA " + CRLF       
	cQuery1 += "  FROM  "+RetSqlName('SE1')+ " SE1 ,"  + CRLF
	cQuery1 += " WHERE PCS_FILIAL = '"+xFilial("PCS")+"' AND PCS.D_E_L_E_T_  = ' ' " + CRLF
	cQuery1 += "   AND E1_FILIAL = '"+xFilial("SE1")+"' AND SE1.D_E_L_E_T_  = ' ' " + CRLF  

	cQuery1 += "   AND PCS_PREFIX = E1_PREFIXO  " + CRLF
	cQuery1 += "   AND PCS_NUMTIT = E1_NUM " + CRLF
	cQuery1 += "   AND PCS_OPEORI = OPE.OPEORI " + CRLF
	  	  
	cQuery1 += "   AND E1_PREFIXO = 'PLS' AND E1_TIPO = 'DP' " + CRLF
	cQuery1 += "   AND E1_NUM     = '"+cNumTitF1+"'" + CRLF 
	  
	cQuery1 += "   AND trim(PCS_OPEORI) >= '"+cOpeInc+"' AND  trim(PCS_OPEORI) <= '"+cOpeFim+"'  " + CRLF
	
	cQuery1 += " GROUP BY PCS.PCS_OPEORI , OPE.NOMOPE , PCS_MESPAG , PCS_ANOPAG , E1_VENCREA , "
	cQuery1 += "          E1_PREFIXO , E1_NUM , E1_PARCELA , E1_TIPO , E1_VALOR , E1_EMIS1 "
	cQuery1 += "   ORDER BY 1,4 " + CRLF   

EndIf 	     
            		                              
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime a movimentacao...                                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ			        	            		
//Modificada logica para Caberj.

if cOrig == 2 

    If Select("TMP1") > 0
	   dbSelectArea("TMP1")
	   dbclosearea()
    Endif

    TCQuery cQuery Alias "TMP1" New
    dbSelectArea("TMP1")
    tmp1->(dbGoTop())                                                                                                                         
    
EndIf

If Select("TMP") > 0
	dbSelectArea("TMP")
	dbclosearea()
Endif

TCQuery cQuery Alias "TMP" New                                                    
dbSelectArea("TMP")
tmp->(dbGoTop())                                                                                                                         
//cMatric := substr (tmp->Matricula1,1,14)
//cNomCli := substr (tmp->ba1_nomusr,1,30)
While tmp->(!EOF())     
  
      OLE_SetDocumentVar(oWord,"DT_CAB"   , SubStr(DtoS(dDataBase),7,2) + ' De ' + u_MesExt(SubStr(DtoS(dDataBase),5,2))+" de  " + SubStr(DtoS(dDataBase),1,4))  
      OLE_SetDocumentVar(oWord,"OPE"      , tmp->NOMOPE)

   If cOrig == 2                                                                            
      OLE_SetDocumentVar(oWord,"VLRTOT"   , Transform((cVLRDMED+cVLRADM+cVLRINSS), "@E 999,999,999.99") ) 
      OLE_SetDocumentVar(oWord,"REF_CONS" , trim(u_MesExt(substr(tmp1->EMIS1,5,2)))+' De '+substr(tmp1->EMIS1,1,4)  )
      OLE_SetDocumentVar(oWord,"VLRDMED"  , Transform(cVLRDMED, "@E 999,999,999.99") ) 
      OLE_SetDocumentVar(oWord,"VLRADM"   , Transform(cVLRADM , "@E 999,999,999.99") ) 
      OLE_SetDocumentVar(oWord,"VLRINSS"  , Transform(cVLRINSS, "@E 999,999,999.99") )          
      
      OLE_SetDocumentVar(oWord,"DT_ROD"   , STOD(TMP1->VENCREA))
   Else                                                                                                                                           
    //  OLE_SetDocumentVar(oWord,"VLRTOT"   , Transform(TMP->E1VALOR, "@E 999,999,999.99") )  
      OLE_SetDocumentVar(oWord,"VLRTOT"   , Transform((TMP->VLRBPF+TMP->VLRTAD+TMP->VLRINS), "@E 999,999,999.99") ) 
      OLE_SetDocumentVar(oWord,"REF_CONS" , trim(u_MesExt(substr(tmp->EMIS1,5,2)))+' De '+substr(tmp->EMIS1,1,4))  
      OLE_SetDocumentVar(oWord,"VLRDMED"  , Transform(TMP->VLRBPF, "@E 999,999,999.99") ) 
      OLE_SetDocumentVar(oWord,"VLRADM"   , Transform(TMP->VLRTAD, "@E 999,999,999.99") ) 
      OLE_SetDocumentVar(oWord,"VLRINSS"  , Transform(TMP->VLRINS, "@E 999,999,999.99") )   
      OLE_SetDocumentVar(oWord,"DT_ROD"   , STOD(TMP->VENCREA))
   EndIf    
      OLE_SetDocumentVar(oWord,"VLRMAT"   ,"0,00")
      OLE_SetDocumentVar(oWord,"VLRADMMAT","0,00") 
      OLE_SetDocumentVar(oWord,"VLRCAR"   ,"0,00")
      OLE_SetDocumentVar(oWord,"VLRJUR"   ,"0,00")     
      OLE_SetDocumentVar(oWord,"VLRREG"   ,"0,00")
      OLE_SetDocumentVar(oWord,"VLRCRED"  ,"0,00")
      

      OLE_SetDocumentVar(oWord,"COMPT"    ,Iif(cOrig==1," "," (FATURA COMPLEMENTAR)"))
      nConta:=1
  
//   If cMatric != substr (tmp->Matricula1,1,14)                            
                                                                                                                   
      OLE_UpDateFields(oWord)
      Ole_PrintFile(oWord,"ALL",,,1)  //ativa quando for pra valer
                         
      WaitPrt(10)
 //-- Imprime as variaveis		
   if cOrig == 1 
   
      OLE_SaveAsFile( oWord, cGrava  + tmp->OPEORI + tmp->E1PREF + tmp->E1NUM +".doc" )	

      cNomeArq :=	Trim(("\cart_conv\"   + tmp->OPEORI + tmp->E1PREF + tmp->E1NUM +".doc"))

   Else                                                                       
                 
      OLE_SaveAsFile( oWord, cGrava  + tmp->OPEORI + cTitrec+".doc" )		
   
      cNomeArq :=	trim(("\cart_conv\"  + tmp->OPEORI + cTitrec+".doc"))
         
   EndIf       
  // Fecha o Documento
  ///// email 

	 fEnvEmail(cNomeArq , trim(tmp->NOMOPE) +' - '+tmp->OPEORI   , (trim(tmp->NOMOPE) +' - '+ Iif(cOrig==1," Fatura de Adiantamento  "," Fatura Complementar " )  )  )

    
  tmp->(dbSkip()) 
EndDo                     
  OLE_CloseFile( oWord )
  OLE_CloseLink( oWord )
Return      

//Waint para carragar Spool do Word
Static Function WaitPRT(nTime)
Local oDlgPrt,oTimer
	DEFINE MSDIALOG oDlgPrt FROM 0,0 TO 50,500 TITLE "Imprimindo!" PIXEL
		oTimer := TTimer():New( nTime * 50, {|| oDlgPrt:END() }, oDlgPrt )
		@1,1  SAY "Aguarde..."+ tmp->OPEORI + tmp->E1PREF + tmp->E1NUM + ".doc"
		oTimer:lActive   := .T.
	ACTIVATE MSDIALOG oDlgPrt CENTERED      

Return                                                                       
                 

user Function MesExt(cMes)
Local cString := Space(11)

Do case
	Case cMes == "01"
		cString := "Janeiro    "
	Case cMes == "02"
		cString := "Fevereiro  "
	Case cMes == "03"
		cString := "Marco      "
	Case cMes == "04"
		cString := "Abril      "
	Case cMes == "05"
		cString := "Maio       "
	Case cMes == "06"
		cString := "Junho      "
	Case cMes == "07"
		cString := "Julho      "
	Case cMes == "08"
		cString := "Agosto     "
	Case cMes == "09"
		cString := "Setembro   "
	Case cMes == "10"
		cString := "Outubro    "
	Case cMes == "11"
		cString := "Novembro   "
	Case cMes == "12"
		cString := "Dezembro   "																		
EndCase

Return cString   

/////////////
********************************************************************************* 

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Formata textos das caixas multiget                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Static Function fEnvEmail(cNomeArq , cEmpresa , cAssunto  )                  

Local lEmail     := .F.
Local c_CampAlt  := '  '
Local lExecuta   := .T.
local cDest      := " "
Local aArea      := GetArea() //Armazena a Area atual
Local _cMensagem := " "

_cMensagem := "Em " + DtoC( Date() ) +  Chr(10) + Chr(13) + Chr(10) + Chr(13)

_cMensagem +=  Chr(13) + Chr(10) + Chr(13) + Chr(10) + " Assunto : Carta de Cobrança do Convenio "+cAssunto 
_cMensagem +=  Chr(13) + Chr(10) + Chr(13) + Chr(10) + "Prezados,"

_cMensagem +=  Chr(13) + Chr(10) + Chr(13) + Chr(10) + "Foi Gerado a carta de cobrança para o convenio  "+cEmpresa
_cMensagem +=  Chr(13) + Chr(10) + Chr(13) + Chr(10) + "e esta em  anexo "

	//destinatario cristina
	cDest+= "altamiro@caberj.com.br ;"
	//destinatario Giordano
	//cDest+= "alan.jefferson@caberj.com.br ;"        
	//cDest+= "esther.melo@caberj.com.br "
	//cDest+= "monique.goncalves@caberj.com.br"

// envio desativado por orientação da esther por email em 17/12/20
//EnvEmail1( _cMensagem , cDest , cNomeArq , cAssunto)

RestArea(aArea)

Return (.T.)
*--------------------------------------*
Static Function EnvEmail1( _cMensagem , cDest , cNomeArq , cAssunto )
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
Local _cAssunto    := cAssunto
Local _cError      := ""
Local _lOk         := .T.
Local _lSendOk     := .F.
local cto_         := ' '
//local cNomeArq     := '\CART_CONV\1002COV000000017.DOC' 

//_cTo+= cDest

If !Empty( _cMailServer ) .And.    !Empty( _cMailConta  )
	// Conecta uma vez com o servidor de e-mails
	CONNECT SMTP SERVER _cMailServer ACCOUNT _cMailConta PASSWORD _cMailSenha RESULT _lOk            
		
	If _lOk
	 	SEND MAIL From _cMailConta To _cTo /*BCC _cCC  */ Subject _cAssunto Body _cMensagem  Result _lSendOk ATTACHMENT trim(cNomeArq)      
	  //	SEND MAIL From _cMailConta To _cTo /*BCC _cCC  */ Subject _cAssunto Body _cMensagem  Result _lSendOk
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

