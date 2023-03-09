#Define CRLF Chr(13)+Chr(10)
#INCLUDE "PROTHEUS.ch"
#INCLUDE "TOPCONN.ch"
#INCLUDE "PLSMGER.CH"
#Include "Ap5Mail.Ch"
#Include 'Tbiconn.ch'   
#Include "rwmake.ch"   
#Include "RPTDEF.CH"
/*--------------------------------------------------------------------------\
| Programa  | CABA132  | Autor | Altamiro	Affonso    | Data | 01/12/2017  |
|---------------------------------------------------------------------------|
| Descricao | Browser de trans. Filial XX -> '01' - Produção                |
|           |                                                               |
|---------------------------------------------------------------------------|
| Uso       | trans. Filial XX -> '01' - Produção - browser de seleção      |
\--------------------------------------------------------------------------*/

User Function cabr260()

local cRda        := ' '
local cNivel      := ' '
local nI := 0

private lsai      := .F.
private aBrwPEG   := {}
Private aCabPEG	  := { " ","CODCCO ","SITUAC ","DT_ATU ","NOMUSR ","CPFUSR ","PISPAS ","SEXO   ","DATNAS ","MAE    ","ENDERE ","NR_END ","BAIRRO ","CODMUN ","CEPUSR ","RESEXT ","MATRIC ","GRAUPA ","DATCON ","NUMPLA ","COBPAR ","ITEXCO ","CGCEMP ","CNS","DATCAN ","PISPASEP ","CCOTIT ","CNPJ_CONT "}//,"REFER " } 
//Private aCabPEG	  := { "CODCCO ","SITUAC ","DT_ATU ","NOMUSR ","CPFUSR ","PISPAS ","SEXO   ","DATNAS ","MAE    ","ENDERE ","NR_END ","BAIRRO ","CODMUN ","CEPUSR ","RESEXT ","MATRIC ","GRAUPA ","DATCON ","NUMPLA ","COBPAR ","ITEXCO ","CGCEMP ","CNS","DATCAN ","PISPASEP ","CCOTIT ","CNPJ_CONT "}//,"REFER " }

Private aTamPEG	  := { 10 , 15      , 10      ,40       ,15       ,30       , 10      , 10       , 15      , 40      , 40      , 5       ,10       , 15      , 10     ,40       ,30       ,10      , 10      , 10       , 15      , 40      , 40      , 15  , 10      , 15        , 10      ,40          } 
//Private aTamPEG	  := {  15      , 10      ,40       ,15       ,30       , 10      , 10       , 15      , 40      , 40      , 5       ,10       , 15      , 10     ,40       ,30       ,10      , 10      , 10       , 15      , 40      , 40      , 15  , 10      , 15        , 10      ,40          }


Private oOk       := LoadBitMap(GetResources(),"LBOK")
Private oNo       := LoadBitMap(GetResources(),"LBNO")

Private aObjects  := {}
Private aSizeAut  := MsAdvSize()
Private cPerg	  := "cabr260"
Private adados    := {}

//private cAliasCf  := GetNextAlias()
private cAliasPEG := GetNextAlias()
//private cAliasCT  := GetNextAlias()
//private cAliasEX  := GetNextAlias()


private cDtEntr   := ' '
Private cdata     := ' '
Private nEmpresa  := ' '
private cLibBlq   := 'S'

AjustaSX1(cPerg)

Pergunte(cPerg,.T.)

Processa({||aBrwPEG := aDadosPEG()},'Buscando dados no servidor . . . . .','Processando...',.T.)

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

nSepHoriz   := 5
nSepVert    := 5
nSepBorHor 	:= 5
nSepBorVert	:= 5

aInfo  		:= { aSizeAut[ 1 ], aSizeAut[ 2 ], aSizeAut[ 3 ], aSizeAut[ 4 ], nSepHoriz, nSepVert, nSepBorHor, nSepBorVert }
aPosObj 	:= MsObjSize( aInfo, aObjects, .T. )

oDlg  		:= MsDialog():New( aSizeAut[7],00,aSizeAut[3]-100,aSizeAut[5]-10,"Liberação de Titulos Para Filial de Produção",,,.F.,,,,,,.T.,,,.T. )

oSayPEG    	:= TSay():New( aPosObj[1][1],aPosObj[1][2],{||'Liberação de Titulos Para Filial de Produção'},oDlg,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,236,016)

bDbClickPEG	:= {||U_fCaba148(aBrwPEG[oBrwPEG:nAt,17], aBrwPEG[oBrwPEG:nAt,2]) ,oBrwPEG:Refresh()}  

oBrwPEG 	:= TcBrowse():New(aPosObj[1][1]+10,aPosObj[1][2],aPosObj[1][4],aPosObj[1][3],,aCabPEG,aTamPEG,oDlg,,,,,bDbClickPEG,,,,,,,.F.,,.T.,,.F.,,, )

oBrwPEG:SetArray(aBrwPEG) 

oBrwPEG:bLine := {||{If( aBrwPEG[oBrwPEG:nAt,1],oOk,oNo) ,;   
aBrwPEG[oBrwPEG:nAt,2]       ,;
aBrwPEG[oBrwPEG:nAt,3]       ,;
aBrwPEG[oBrwPEG:nAt,4]       ,;
aBrwPEG[oBrwPEG:nAt,5]       ,;
aBrwPEG[oBrwPEG:nAt,6]       ,;
aBrwPEG[oBrwPEG:nAt,7]       ,; 
aBrwPEG[oBrwPEG:nAt,8]	     ,;
aBrwPEG[oBrwPEG:nAt,9]       ,;
aBrwPEG[oBrwPEG:nAt,10]      ,;
aBrwPEG[oBrwPEG:nAt,11]      ,;
aBrwPEG[oBrwPEG:nAt,12]      ,;
aBrwPEG[oBrwPEG:nAt,13]      ,; 
aBrwPEG[oBrwPEG:nAt,14]	     ,;
aBrwPEG[oBrwPEG:nAt,15]      ,;
aBrwPEG[oBrwPEG:nAt,16]      ,;
aBrwPEG[oBrwPEG:nAt,17]      ,;
aBrwPEG[oBrwPEG:nAt,18]      ,;
aBrwPEG[oBrwPEG:nAt,19]      ,; 
aBrwPEG[oBrwPEG:nAt,20]      ,;
aBrwPEG[oBrwPEG:nAt,21]      ,;
aBrwPEG[oBrwPEG:nAt,22]      ,;
aBrwPEG[oBrwPEG:nAt,23]      ,;
aBrwPEG[oBrwPEG:nAt,24]      ,;
aBrwPEG[oBrwPEG:nAt,25]      ,; 
aBrwPEG[oBrwPEG:nAt,26]      ,;
aBrwPEG[oBrwPEG:nAt,27]      ,;
aBrwPEG[oBrwPEG:nAt,28]      }}
//aBrwPEG[oBrwPEG:nAt,29]      }}


oBrwPEG:nScrollType  := 1 // Scroll VCR

lConfirmou 	:= .T.

aBut    :={{"PENDENTE", {||marca(),oBrwPEG:Refresh()           }	, "Marcar Todos "       , "Marcar Todos"     } }
aAdd(aBut, {"PENDENTE", {||desmarca() ,oBrwPEG:Refresh()        }	, "DesMarcar Todos "	, "DesMarcar Todos"	 } )
aAdd(aBut, {"PENDENTE", {||lsai:= .T. , oDlg:End()              }	, "Sair "   	        , "Sair"             } )

If lsai

   oDlg:End()

endIf

lConfirmou := .F.

bOk 	:= {||fazTriag() , oBrwPEG:Refresh()  ,oDlg:End()   }

bCancel := {||lConfirmou := .F.,oDlg:End()}

  
oDlg:Activate(,,,.T.,,,EnchoiceBar(oDlg,bOk,bCancel,,aBut))

	MsgInfo("Processo finalizado")

Return

/************************************************************************************/

Static Function aDadosPEG

Local aRetPEG	:= {}
Local cquery	:= ""
local i

ProcRegua(0)

nCont := 0

for i:=1 to 5
	IncProc('Buscando Dados no Servidor ...')
next

cquery := CRLF+" select SIB_CODCCO CODCCO , " 
cquery += CRLF+"        decode(SIB_SITUAC ,'1','Ativo','Bloqueado')SITUAC , " 
cquery += CRLF+"        SIB_DT_ATU DT_ATU , " 
cquery += CRLF+"        SIB_NOMUSR NOMUSR , " 
cquery += CRLF+"        SIB_CPFUSR CPFUSR , " 
cquery += CRLF+"        SIB_PISPAS PISPAS , " 
cquery += CRLF+"        SIB_SEXO   SEXO   , " 
cquery += CRLF+"        SIB_DATNAS DATNAS , " 
cquery += CRLF+"        SIB_MAE    MAE    , " 
cquery += CRLF+"        SIB_ENDERE ENDERE , " 
cquery += CRLF+"        SIB_NR_END NR_END , " 
cquery += CRLF+"        SIB_BAIRRO BAIRRO , " 
cquery += CRLF+"        SIB_CODMUN CODMUN , " 
cquery += CRLF+"        SIB_CEPUSR CEPUSR , " 
cquery += CRLF+"        SIB_RESEXT RESEXT , " 
cquery += CRLF+"        SIB_MATRIC MATRIC , " 
cquery += CRLF+"        SIB_GRAUPA GRAUPA , " 
cquery += CRLF+"        SIB_DATCON DATCON , " 
cquery += CRLF+"        SIB_NUMPLA NUMPLA , " 
cquery += CRLF+"        SIB_COBPAR COBPAR , " 
cquery += CRLF+"        SIB_ITEXCO ITEXCO , " 
cquery += CRLF+"        SIB_CGCEMP CGCEMP , " 
cquery += CRLF+"        SIB_CNS    CNS    , " 
cquery += CRLF+"        SIB_DATCAN DATCAN , " 
cquery += CRLF+"        SIB_PISPASEP PISPASEP , " 
cquery += CRLF+"        SIB_CCO_TITULAR CCOTIT, " 
cquery += CRLF+"        SIB_CNPJ_CONTRATANTE CNPJ_CONT  " 
//cquery += CRLF+"        SIB_REFER  REFER "          
If cempant == '01'
   cquery += CRLF+"   FROM CONFSIB_CAB ,
Else                                        
   cquery += CRLF+"   FROM CONFSIB_INT , " 	 
EndIf   
cquery += CRLF+" " + RetSqlName("BA1")  + " BA1 "             
cquery += CRLF+" WHERE  BA1_FILIAL = '" + xFilial('BA1') + "'" 	     
cquery += CRLF+"   and  ba1_codint || ba1_codemp || ba1_matric || ba1_tipreg || ba1_digito = sib_matric "                                 

If empty(mv_par01) .AND. empty(mv_par02) .AND. empty(mv_par03)                                                                                                                   
   cquery += CRLF+"  AND BA1_INFANS <> '0' AND BA1_ATUSIB <> '0' AND BA1_INFSIB <> '0' "                                 
EndIf                
  
If !empty(mv_par01)
   cquery += CRLF+"        and   SIB_CODCCO like '%"+TRIM(mv_par01)+"%' "  
ElseIf !empty(mv_par02)
   cquery += CRLF+"        and   SIB_MATRIC like '%"+TRIM(mv_par02)+"%' "  
ElseIf !empty(mv_par03)
   cquery += CRLF+"        and   SIB_NOMUSR like '%"+TRIM(mv_par03)+"%' "  
EndIf         


////////////////////////////////////////
If Select(cAliasPEG) > 0
	dbSelectArea(cAliasPEG)
	dbclosearea()
Endif

TcQuery cQuery New Alias (cAliasPEG)

(cAliasPEG)->(dbGoTop())

While !(cAliasPEG)->(EOF())   

//	aAdd(aRetPEG,{.F. , (cAliasPEG)->CODCCO , (cAliasPEG)->SITUAC , (cAliasPEG)->DT_ATU , (cAliasPEG)->NOMUSR , (cAliasPEG)->CPFUSR , (cAliasPEG)->PISPAS , (cAliasPEG)->SEXO   , (cAliasPEG)->DATNAS , (cAliasPEG)->MAE    , (cAliasPEG)->ENDERE , (cAliasPEG)->NR_END , (cAliasPEG)->BAIRRO , (cAliasPEG)->CODMUN , (cAliasPEG)->CEPUSR , (cAliasPEG)->RESEXT , (cAliasPEG)->MATRIC , (cAliasPEG)->GRAUPA , (cAliasPEG)->DATCON , (cAliasPEG)->NUMPLA , (cAliasPEG)->COBPAR , (cAliasPEG)->ITEXCO , (cAliasPEG)->CGCEMP , (cAliasPEG)->CNS    , (cAliasPEG)->DATCAN , (cAliasPEG)->PISPASEP , (cAliasPEG)->CCOTIT , (cAliasPEG)->CNPJ_CONT , (cAliasPEG)->REFER })        
	aAdd(aRetPEG,{.F. , (cAliasPEG)->CODCCO , (cAliasPEG)->SITUAC ,  StoD((cAliasPEG)->DT_ATU) , (cAliasPEG)->NOMUSR , (cAliasPEG)->CPFUSR , (cAliasPEG)->PISPAS , (cAliasPEG)->SEXO   ,  StoD((cAliasPEG)->DATNAS) , (cAliasPEG)->MAE    , (cAliasPEG)->ENDERE , (cAliasPEG)->NR_END , (cAliasPEG)->BAIRRO , (cAliasPEG)->CODMUN , (cAliasPEG)->CEPUSR , (cAliasPEG)->RESEXT , (cAliasPEG)->MATRIC , (cAliasPEG)->GRAUPA ,  StoD((cAliasPEG)->DATCON) , (cAliasPEG)->NUMPLA , (cAliasPEG)->COBPAR , (cAliasPEG)->ITEXCO , (cAliasPEG)->CGCEMP , (cAliasPEG)->CNS    ,  StoD((cAliasPEG)->DATCAN) , (cAliasPEG)->PISPASEP , (cAliasPEG)->CCOTIT , (cAliasPEG)->CNPJ_CONT })	
              //   1      2    		    		3	    				4					5                    6                       7                       8                         9             10                    11                     12                    13                   14                    15                    16                     17                   18                    19                     20                   21                     22                    23                    24                    25                   26                       27                   28                       29
	(cAliasPEG)->(DbSkip())
	
EndDo

(cAliasPEG)->(DbCloseArea())

If empty(aRetPEG)
//	aAdd(aRetPEG,{.T.,'','','','','','','','','','','','','','','','','','','','','','','','','','','','',''}) 
	aAdd(aRetPEG,{.T.,'','','','','','','','','','','','','','','','','','','','','','','','','','','','',''})
EndIf

Return aRetPEG

/**********************************************************************************/

Static Function marca() 

Local nI

For nI := 1 to len(aBrwPEG)
	
	aBrwPEG[nI,1]:= .T.
	
Next

RETURN()


Static Function desmarca() 

Local nI

For nI := 1 to len(aBrwPEG)
	
	aBrwPEG[nI,1]:= .F.
	
Next


RETURN()


/***************************************************************************************/
Static Function VerifMarc( ind  , ccodrda )

local nI 
local I

For nI := 1 to ind //len(aBrwPEG)  

	If  aBrwPEG[nI,1] == .T. 

   	   If  trim(aBrwPEG[nI,5]) == ' ---> Total RDA <---'
	
           For I := 1 to nI 
           
              If aBrwPEG[nI,4] == aBrwPEG[I,4] .and. aBrwPEG[I,4] == ccodrda
              
                 aBrwPEG[I,1]:= .T.
                 
              EndIf
                  
           Next
        
       EndIf    		
		
	EndIf
	
Next


Return()     
Static Function VerifdMarc( ind , ccodrda )

local nI 
local I0

For nI := 1 to len(aBrwPEG)  

	If  aBrwPEG[nI,1] == .F. .and. nI <= ind 

   	   If  trim(aBrwPEG[nI,5]) == ' ---> Total RDA <---'
	
           For I := 1 to nI 
           
              If aBrwPEG[nI,4] == aBrwPEG[I,4] .and. aBrwPEG[I,4] == ccodrda
              
                 aBrwPEG[I,1]:= .F.    
                 
              EndIf
                  
           Next
        
       EndIf    		
		
	EndIf
	
Next


Return()

/**********************************************************************************/

Static Function AjustaSX1(cPerg)

Local aHelpPor := {}

PutSx1(cPerg,"01",OemToAnsi("Cod CCo") 		          ,"","","mv_ch1","C",12,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","","",{},{})
PutSx1(cPerg,"02",OemToAnsi("Matric Compl")           ,"","","mv_ch2","C",17,0,0,"C","","","","","mv_par02","","","","","","","","","","","","","","","","",{},{},{}) 
PutSx1(cPerg,"03",OemToAnsi("Nome  ")                 ,"","","mv_ch3","C",40,0,0,"C","","","","","mv_par03","","","","","","","","","","","","","","","","",{},{},{}) 

Pergunte(cPerg,.F.)

Return

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Formata textos das caixas multiget                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Static Function fEnvEmail(cNomeArq , cEmpresa   )  

Local lEmail     := .F.
Local c_CampAlt  := '  '
Local lExecuta   := .T.
local cDest      := " "
Local aArea      := GetArea() //Armazena a Area atual
Local _cMensagem := " "

_cMensagem := "Em " + DtoC( Date() ) +  Chr(10) + Chr(13) + Chr(10) + Chr(13)

_cMensagem +=  Chr(13) + Chr(10) + Chr(13) + Chr(10) + " Assunto : Liberação de Titulos Para Filial de Produção " 
_cMensagem +=  Chr(13) + Chr(10) + Chr(13) + Chr(10) + "Prezados,"

_cMensagem +=  Chr(13) + Chr(10) + Chr(13) + Chr(10) + "Foi executado o Processo de Liberação  para  os titulos em anexo " 
_cMensagem +=  Chr(13) + Chr(10) + "Para mais Infornações verifique arquivo em anexo "

	//destinatario cristina
	cDest+= "altamiro@caberj.com.br ;"
	//destinatario Giordano
	cDest+= "piumbim@caberj.com.br "

EnvEmail1( _cMensagem , cDest , cNomeArq )

RestArea(aArea)

Return (.T.)
*--------------------------------------*
Static Function EnvEmail1( _cMensagem , cDest , cNomeArq )
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
Local _cAssunto    := " Liberação de Titulos para Filial de Produção "
Local _cError      := ""
Local _lOk         := .T.
Local _lSendOk     := .F.
local cto_         := ' '

If !Empty( _cMailServer ) .And.    !Empty( _cMailConta  )
	// Conecta uma vez com o servidor de e-mails
	CONNECT SMTP SERVER _cMailServer ACCOUNT _cMailConta PASSWORD _cMailSenha RESULT _lOk            
		
	If _lOk
	 	SEND MAIL From _cMailConta To _cTo /*BCC _cCC  */ Subject _cAssunto Body _cMensagem  Result _lSendOk ATTACHMENT cNomeArq      
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

Return()


