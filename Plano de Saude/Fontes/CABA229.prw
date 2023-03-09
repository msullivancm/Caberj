#Define CRLF Chr(13)+Chr(10)
#INCLUDE "PROTHEUS.ch"                                                                                                                                  
#INCLUDE "TOPCONN.ch"
#INCLUDE "PLSMGER.CH"                                                                                   
#Include "Ap5Mail.Ch"      
#Include 'Tbiconn.ch'           
#INCLUDE 'RWMAKE.CH'
#INCLUDE 'FONT.CH'
#INCLUDE 'COLORS.CH'

/*--------------------------------------------------------------------------
| Programa  | CABA2029  | Autor | Altamiro	Affonso    | Data | 19/06/2020  |
|---------------------------------------------------------------------------|              
| Descricao | detalhe das equipe de venda                                   |
|           |                                                               |                                                       
|---------------------------------------------------------------------------|
| Uso       | liberação de comissao PARA EMISSAO nf WEB                     |                                   
 --------------------------------------------------------------------------*/

User Function CABA229()
                                                 
local nI := 0          

Private cAliastmp    := GetNextAlias()
Private cAliastmp1 	 := GetNextAlias()  
PRIVATE cAliasRkC1   := GetNextAlias()

Private cQuery        := " "   
Private cQryPEG       := " "  

private cEmp          := ' ' 
private cMes          := ' '
private cAno          := ' '
private cPrefT        := ' ' 
private cNumtT        := ' '
private cTipoT        := ' '
private cVend         := ' '
private lflagMM       :=.F.
private cValor        := ' ' 
private cCompte       := ' ' 

Private _cUsuario     := SubStr(cUSUARIO,7,10)
private cDthr         := (dtos(DATE()) + "-" + Time())    
Private _cIdUsuar     := RetCodUsr()

private _emailusr     := UsrRetMail(_cIdUsuar) 

Private aBrwPEG       := {}
private aRetPEG	      := {}    
private aDados        := {}

Private aCabPEG	:=   {" "                 ,;
                      " "                 ,;        
					  "Prefixo"           ,;
	      		      "Num titulo"        ,;
			          "Tipo"              ,;
                      "Valor Tit"         ,;
					  "Saldo Tit"         ,;
					  "Nf "               ,;
                      "Emissao"           ,;
					  "Vencimento"        ,;
			          "Cod Admin."        ,;
			          "Nome Administradora",;
		              "Cod. Fornec."      ,;
		              "Nome Fornecedor"   ,;
			          "Cod. Empresa"      ,;
			          "Nome Empresa"      ,;
					  "Compte"            ,;
					  "Tem Solicit."      ,;
					  "Email Corretor"    }

//Private aCabPEG	:= {" "," " ,"Prefixo","Num titulo","Tipo","Valor Tit","Saldo Tit", "Nf ","Emissao","Vencimento","Cod Admin.","Nome Admin.","Cod. Fornec.","Nome Fornecedor" , "Cod. Emp.","Nome Empresa","Compte","Email Corretora"      }
Private aTamPEG	    := {5  , 10 , 20      ,30          , 20   , 30        ,30         , 10   , 30      ,30          ,20          , 60          ,  20          ,  60              , 20         , 60           ,15 , 15 }       
//Private aTamPEG	:= {5  , 25     ,20     , 25   , 20   ,20    ,    80     , 30    ,30        ,30     ,    20    ,  25    ,  100    ,100       , 25       , 25        }       

//private aBrwPEG
//Private aCabPEG		:= {" ", "Compt. Entrada","Operadora de  Origem  ","Vlr Fase 3","Vlr Fase 31/2","Vlr Fase 4","Vlr Inss","Vlr Tx Adm", "Total Guias","Faturado","Qtda Guias"}
//Private aTamPEG		:= {10,30,120,45,45,45,45,45,45,45,25}  

Private _cUsuario    := SubStr(cUSUARIO,7,15)
private cDthr        := (dtos(DATE()) + "-" + Time())    

Private _cIdUsuar    := RetCodUsr()

//Private _cIdUsuar    :='000026'

Private _cIdUsuar1   := _cIdUsuar

private cAproN1      := " "
private cAproN2      := " "
private cAproN3      := " "
private cAproN4      := " "

Private oOk      	:= LoadBitMap(GetResources(),"LBOK")
Private oNo      	:= LoadBitMap(GetResources(),"LBNO")

Private oVerde   	:= LoadBitMap(GetResources(),"ENABLE")
Private oAmarelo	:= LoadBitMap(GetResources(),"BR_AMARELO")
Private oVermelho	:= LoadBitMap(GetResources(),"BR_VERMELHO")
Private oPreto   	:= LoadBitMap(GetResources(),"BR_PRETO")

PRIVATE cCadastro	:= "Solicitação de emissao de Nf "

PRIVATE aCdCores	:= { 	{ 'BR_VERDE'    ,'Entregue  Nf'           },; 
							{ 'BR_AMARELO'  ,'Pendente Aprovação'        },;
							{ 'BR_VERMELHO' ,'Titulo pago '           },;
							{ 'BR_PRETO'    ,'Aprovado para emissão Nf' }}

PRIVATE aRotina	:=	{	{ "Legenda"		, 'U_LEG229'	    , 0, K_Incluir		} }	

Private aObjects 	:= {}

Private aSizeAut 	:= MsAdvSize() 

Private cPerg	    := "CABA229"     

    If  Pergunte(cPerg,.T.) == .F.
	    Return
    Endif 

    cCompte  := Mv_par01 

    cAnoC    := substr(Mv_par01,1,4)
	cMesC    := substr(Mv_par01,5,2)
 Processa({||aBrwPEG := aDadosPEG()},'Processando...','Buscando Dados No Servidor ...',.T.)
  
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
          
lAjustHor	  := .T.
//lAjustVert  := .T.
lAjustVert 	  := .F.

aAdd( aObjects, { 120,  200, lAjustHor, lAjustVert } )
//aAdd( aObjects, { 130,  250, lAjustHor, lAjustVert } )
//aAdd( aObjects, { 130,  250, lAjustHor, lAjustVert } )

nSepHoriz   := 5     
nSepVert    := 5
nSepBorHor 	:= 5
nSepBorVert	:= 5

aInfo  		:= { aSizeAut[ 1 ], aSizeAut[ 2 ], aSizeAut[ 3 ], aSizeAut[ 4 ], nSepHoriz, nSepVert, nSepBorHor, nSepBorVert }
aPosObj 	:= MsObjSize( aInfo, aObjects, .T. )

//oDlg  		:= MsDialog():New( aSizeAut[7],00,aSizeAut[3]-100,aSizeAut[5]-10,"Repase Comissao Vendedor Interno Integral -> Caberj ",,,.F.,,,,,,.T.,,,.T. ) 

oDlg  		:= MsDialog():New( aSizeAut[7],00,aSizeAut[3] ,aSizeAut[5]-10,"Autorização de Importação de NF",,,.F.,,,,,,.T.,,,.T. ) 
oSayPEG    	:= TSay():New( aPosObj[1][1],aPosObj[1][2],{||'"Autorização de Importação de NF"'},oDlg,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,236,016)

//bDbClickPEG	:= {|| aBrwPEG[oBrwPEG:nAt,1] := !aBrwPEG[oBrwPEG:nAt,1], oBrwPEG:Refresh()}   

bDbClickPEG	:= {|| aBrwPEG[oBrwPEG:nAt,1] := iif ((aBrwPEG[oBrwPEG:nAt,  17] == 'SIM' .or. aBrwPEG[oBrwPEG:nAt,6] == 0 .or. aBrwPEG[oBrwPEG:nAt,7] == 'SIM') , aBrwPEG[oBrwPEG:nAt,1] ,!aBrwPEG[oBrwPEG:nAt,1]) , oBrwPEG:Refresh()}   
//bDbClickPEG	:= {|| aBrwPEG[oBrwPEG:nAt,1] := iif ((aBrwPEG[oBrwPEG:nAt,17] == ' ' .or. mv_par01 == '1') , aBrwPEG[oBrwPEG:nAt,1] ,!aBrwPEG[oBrwPEG:nAt,1]) , oBrwPEG:Refresh()}   

//bChangePEG	:= {||AtuBrwGuia(aBrwPEG[oBrwPEG:nAt,2],aBrwPEG[oBrwPEG:nAt,3])}

oBrwPEG 	:= TcBrowse():New(aPosObj[1][1],aPosObj[1][2],aPosObj[1][4],aPosObj[1][3]+40,,aCabPEG,aTamPEG,oDlg,,,,,bDbClickPEG,,,,,,,.F.,,.T.,,.F.,,, )

//oBrwPEG 	:= TcBrowse():New(aPosObj[1][1]+10,aPosObj[1][2],aPosObj[1][4],aPosObj[1][3]+190,,aCabPEG,aTamPEG,oDlg,,,,,bDbClickPEG,,,,,,,.F.,,.T.,,.F.,,, )

oBrwPEG:SetArray(aBrwPEG) 


oBrwPEG:bLine :=  {||{If(aBrwPEG[oBrwPEG:nAt,  1],oOk,oNo) ,;
                     iif(aBrwPEG[oBrwPEG:nAt,  17] == 'SIM',oPreto,;
					 (iif(aBrwPEG[oBrwPEG:nAt,  7] == 'NÃO',oAmarelo,;
					    (IIf(aBrwPEG[oBrwPEG:nAt, 6] > 0 ,oVerde,oVermelho)))))  ,;
                         aBrwPEG[oBrwPEG:nAt,  2] ,;
                         aBrwPEG[oBrwPEG:nAt,  3] ,;
						 aBrwPEG[oBrwPEG:nAt,  4] ,;                     
	  	       Transform(aBrwPEG[oBrwPEG:nAt,  5] ,'@E  9999,999.99'),;
			   Transform(aBrwPEG[oBrwPEG:nAt,  6] ,'@E  9999,999.99'),; 
						 aBrwPEG[oBrwPEG:nAt,  7] ,;
                         aBrwPEG[oBrwPEG:nAt,  8] ,;
                         aBrwPEG[oBrwPEG:nAt,  9] ,;
                         aBrwPEG[oBrwPEG:nAt,  10] ,;
                         aBrwPEG[oBrwPEG:nAt,  11] ,;
						 aBrwPEG[oBrwPEG:nAt,  12] ,;
						 aBrwPEG[oBrwPEG:nAt,  13] ,;
                         aBrwPEG[oBrwPEG:nAt,  14] ,;
                         aBrwPEG[oBrwPEG:nAt,  15] ,;
						 aBrwPEG[oBrwPEG:nAt,  16] ,;
						 aBrwPEG[oBrwPEG:nAt,  17] ,;
						 aBrwPEG[oBrwPEG:nAt,  18]}}                   
						 
oBrwPEG:nScrollType  := 1 // Scroll VCR

lConfirmou 	:= .T.

    aBut    :={{"PENDENTE", {||marca(1)   ,oBrwPEG:Refresh()            }	, "Marcar Todos "       , "Marcar Todos"      }}
	aAdd(aBut, {"PENDENTE", {||desmarca(1),oBrwPEG:Refresh()            }	, "Desmarcar Todos "	, "Desmarcar Todos"	  })  
	aAdd(aBut, {"PENDENTE", {||U_LEG229()                               }   , "Legenda "            , "Legenda "          })  
	aAdd(aBut, {"PENDENTE", {||fgrvpeq()  , oDlg:End()  }   , "Aprova Emissao NF "  , "Aprova emissao NF" })
	aAdd(aBut, {"PENDENTE", {||oDlg:End()                               }   , "Sair "               , "Sair "             })  

lConfirmou := .F.

//bOk 	:= {||fSequen() , oBrwPEG:Refresh() , oBrwPEG:Refresh() ,oDlg:End()   }    
//bOk 	:= {||fgrvpeq() ,oBrwPEG:Refresh() }    

bOk 	:= {||Processa({||aBrwPEG := fgrvpeq()},'Processando...','Fazendo liberação de importação de NF pela WEB...',.T.) , oDlg:End() }    
 
bCancel := {||lConfirmou := .F.,oDlg:End()}

oDlg:Activate(,,,.T.,,,EnchoiceBar(oDlg,bOk,bCancel,,aBut))

Return()    

************************************************************************************

Static Function aDadosPEG()

Local cQryPEG	:= ""
Local cAliasPEG	:= GetNextAlias()
local i:= 0

ProcRegua(0) 

for i := i+1 to 5

    IncProc('Buscando Dados no Servidor ...')

next    

 cQryPEG := CRLF+ "SELECT distinct E2_PREFIXO PREFIXO ,"  
 cQryPEG += CRLF+ "E2_NUM     NUM     , "
 cQryPEG += CRLF+ "E2_TIPO    TIPO    , "
 cQryPEG += CRLF+ "E2_VALOR   VALOR   , "
 cQryPEG += CRLF+ "E2_SALDO   SALDO   , "
 cQryPEG += CRLF+ "substr(DECODE(E2_YLIBPLS,'S','SIM','NÃO'),1,3) NFENT ,"
 cQryPEG += CRLF+ "Trim(substr(e2_emissao,7,2)||'/'||substr(e2_emissao,5,2)||'/'||substr(e2_emissao,1,4)) emissao , "
 cQryPEG += CRLF+ "Trim(substr(e2_vencrea,7,2)||'/'||substr(e2_vencrea,5,2)||'/'||substr(e2_vencrea,1,4)) vencrea , "
 cQryPEG += CRLF+ "BXQ_CODVEN CODVEN  , "
 cQryPEG += CRLF+ "A3_NOME    NOMVEND , "
 cQryPEG += CRLF+ "E2_FORNECE CODFOR  , "
 cQryPEG += CRLF+ "E2_NOMFOR  NOMFOR  , "
 cQryPEG += CRLF+ "BG9_CODIGO CODEMP  , "
 cQryPEG += CRLF+ "BG9_DESCRI NOMEMP  , "
 cQryPEG += CRLF+ "BXQ_ANO||BXQ_MES COMPTE ,"
 cQryPEG += CRLF+ "DECODE(NVL(PEQ_NUM,' '),' ', 'NAO','SIM') TPEQ ,"
 cQryPEG += CRLF+ "a3_email Emailc" 

	cQryPEG += CRLF+ "  from "+ RetSqlName("SE2") + " SE2 ,"+ RetSqlName("SA3") +" SA3 , "+ RetSqlName("BXQ") +" BXQ ,"  + RetSqlName("BG9") +" BG9 ,"  + RetSqlName("PEQ") +" PEQ "
	cQryPEG += CRLF+ " where  E2_filial = '"+xFilial('SE2')+ "'  and SE2.d_E_L_E_T_  = ' ' " 
	cQryPEG += CRLF+ "   and  A3_filial = '"+xFilial('SA3')+ "'  and SA3.d_E_L_E_T_  = ' ' "
	cQryPEG += CRLF+ "   and BXQ_filial = '"+xFilial('BXQ')+ "'  and BXQ.d_E_L_E_T_  = ' ' "
    cQryPEG += CRLF+ "   and bg9_filial = '"+xFilial('BG9')+ "'  and BG9.d_E_L_E_T_  = ' ' "
	cQryPEG += CRLF+ "   and PEQ_filial(+) = '"+xFilial('PEQ')+ "'  and PEQ.d_E_L_E_T_(+)  = ' ' "

 cQryPEG += CRLF+ "  AND E2_PREFIXO = BXQ_E2PREF "
 cQryPEG += CRLF+ "  AND E2_NUM     = BXQ_E2NUM  "
 cQryPEG += CRLF+ "  AND E2_TIPO    = BXQ_E2TIPO "

 cQryPEG += CRLF+ "  AND E2_PREFIXO = PEQ_PREFIX(+) "
 cQryPEG += CRLF+ "  AND E2_NUM     = PEQ_NUM(+)  "
 cQryPEG += CRLF+ "  AND E2_TIPO    = PEQ_TIPO(+) "


 //cQryPEG += CRLF+ "  AND E2_SALDO   = E2_VALOR "

 //cQryPEG += CRLF+ "  AND BXQ_ANO ||BXQ_MES = '"+cCompte+"'"

 cQryPEG += CRLF+ "  AND BXQ_ANO = '"+cAnoC+"'"
 cQryPEG += CRLF+ "  AND BXQ_MES = '"+cMesC+"'"
 
 cQryPEG += CRLF+ "  AND BXQ_codven <> '000215' "

 cQryPEG += CRLF+ "  AND A3_COD     = BXQ_CODVEN "
 cQryPEG += CRLF+ "  AND TRIM(BG9_CODINT) = '0001' "
 cQryPEG += CRLF+ "  AND TRIM(BG9_CODIGO) = BXQ_CODEMP " 
 cQryPEG += CRLF+ "  order by e2_num "
      
TcQuery cQryPEG New Alias (cAliasPEG)  

(cAliasPEG)->(dbGoTop())    

While !(cAliasPEG)->(EOF())


//fSinist((cAliasPEG)->CodEmp , substr((cAliasPEG)->Compte ,1,4), substr((cAliasPEG)->Compte ,5,2) )

    aAdd(aRetPEG,{.F.          ,;  //1
		(cAliasPEG)->PREFIXO   ,;  //2
		(cAliasPEG)->NUM       ,;  //3
		(cAliasPEG)->TIPO      ,;  //4
		(cAliasPEG)->VALOR     ,;  //5
		(cAliasPEG)->SALDO     ,;  //6
	trim((cAliasPEG)->NFENT)   ,;  //7
	trim((cAliasPEG)->emissao) ,;  //8
	trim((cAliasPEG)->vencrea) ,;  //9
		(cAliasPEG)->CODVEN    ,;  //10
		(cAliasPEG)->NOMVEND   ,;  //11
		(cAliasPEG)->CODFOR    ,;  //12
		(cAliasPEG)->NOMFOR    ,;  //13
		(cAliasPEG)->CODEMP    ,;  //14
		(cAliasPEG)->NOMEMP    ,;  //15
	trim((cAliasPEG)->COMPTE)  ,;  //16
	trim((cAliasPEG)->TPEQ)    ,;  //17
	trim((cAliasPEG)->emailc)  })  //18

		(cAliasPEG)->(DbSkip())
	  
EndDo
  
(cAliasPEG)->(DbCloseArea())

If empty(aRetPEG)
	aAdd(aRetPEG,{.F.,;  //1
	               '',;  //2
				   '',;  //3
				   '',;  //4
				   0 ,;  //5
				   0 ,;  //6
				   '',;  //7
				   '',;  //8
				   '',;  //9
				   '',;  //10
				   '',;  //11
				   '',;  //12
				   '',;  //13
				   '',;  //14
				   '',;  //15
                   '',;  //16 
				   '',;  //17
				   ''})  //18
EndIf

Return aRetPEG
                                  
/***********************************************************************************/
Static Function marca(cRef) // cRef == 1 peg , 2 , proc
	
local nI := 0            
       
	For nI := nI + 1 to len(aBrwPEG)
	
        if  (aBrwPEG[nI,17] == 'NAO' .AND. aBrwPEG[nI,6] > 0 .AND. aBrwPEG[nI,7] == 'NÃO')    

	         aBrwPEG[nI,1]:= .T.
    
        EndIF 

	Next

//	EndIf 	
		
RETURN()	
	
Static Function desmarca(cRef) // cRef == 1 peg , 2 , proc
	
    local nI := 0
			
	For nI :=  nI + 1 to len(aBrwPEG)
	    		
	        aBrwPEG[nI,1]:= .F.
	   
    Next
	
RETURN() 

User Function LEG229()

Local aLegenda

	aLegenda 	:= { 	{ aCdCores[1,1],aCdCores[1,2] },;
						{ aCdCores[2,1],aCdCores[2,2] },;
	              		{ aCdCores[3,1],aCdCores[3,2] },;
						{ aCdCores[4,1],aCdCores[4,2] }}
	                     	
BrwLegenda(cCadastro,"Status" ,aLegenda)

Return()

//Static Function fFazlib(nTpLib)

Static Function fEnvEmail( )

Local lEmail     := .F.
Local c_CampAlt  := '  ' 
Local lExecuta   := .T.   
local cDest      := " "                           
Local aArea      := GetArea() //Armazena a Area atual        
Local _cMensagem := " " 

_cMensagem := "Em " + DtoC( Date() ) +  Chr(10) + Chr(13) + Chr(10) + Chr(13) 


_cMensagem +=  Chr(13) + Chr(10) + Chr(13) + Chr(10) + " Assunto : Emissao de NF pelo Site  " 
_cMensagem +=  Chr(13) + Chr(10) + Chr(13) + Chr(10) + " Prezados,"       

_cMensagem +=  Chr(13) + Chr(10) + "Já esta disponivel para emissao a Nf da Comissão , competencia "+ aBrwPEG[I,16] 
 
_cMensagem +=  Chr(13) + Chr(10) + Chr(13) + Chr(10) + "Da empresa "+ aBrwPEG[I,14] +" - "+ aBrwPEG[I,15] 
_cMensagem +=  Chr(13) + Chr(10) + Chr(13) + Chr(10) + "Informação complementares disponivel na area do corretor."

_cMensagem +=  Chr(13) + Chr(10) 
/*_cMensagem :=  Chr(13) + Chr(10) + "Titulos a Pagar Baixados : "

_cMensagem :=  Chr(13) + Chr(10) + "Titulos a Receber Criado e  Baixados : "

_cMensagem :=  Chr(13) + Chr(10) + "Verbas da Folha (SRK) lançadas : "*/
 
_cMensagem +=  Chr(13) + Chr(10) + "Para sua Ciencia."

       aAdd(aDados,{"altamiro@caberj.com.br "}) 
       aAdd(aDados,{"casemiro@caberj.com.br"}) 
       aAdd(aDados,{"graciete.santos@caberj.com.br"})
	   If !empty(_emailusr )
          aAdd(aDados,{_emailusr })
	   EndIf  

       for I:=1 to len(aDados) 
                                       
            EnvEmail1( _cMensagem , aDados[I,1]) 
      
       Next

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
Local _cMailConta  := GetMv( "MV_EMCONTA" )

//Local _cTo  	 := "altamiro@caberj.com.br, paulovasques@caberj.com.br, piumbim@caberj.com.br"
Local _cTo  	     := cDest //"altamiro@caberj.com.br "
Local _cCC         := " "  //GetMv( "MV_WFFINA" )
Local _cAssunto    := " Aprovação de Comissao , Emissao de NF pela Web"
Local _cError      := ""
Local _lOk         := .T.
Local _lSendOk     := .F.
local cto_         := ' '

//_cTo:= cDest

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

static Function fgrvpeq()
a:='2'
 
	For I := 1 to len(aBrwPEG)
			
		If  aBrwPEG[I,1] == .T.  
			
			DBSELECTAREA("PEQ")   
            PEQ->(dbSetOrder(1))  
	
	        PEQ->(Reclock("PEQ",.T.))

				PEQ_FILIAL   := xFilial('PEQ')  
				PEQ_PREFIX   := aBrwPEG[I,02] 
				PEQ_NUM      := aBrwPEG[I,03]  
				PEQ_TIPO     := aBrwPEG[I,04]  
				PEQ_VLR      := aBrwPEG[I,05]  
				PEQ_EMISSA   := stod(aBrwPEG[I,08])  
				PEQ_CORRET   := aBrwPEG[I,10]
				PEQ_FORNEC   := aBrwPEG[I,12]  
				PEQ_EMPRES   := aBrwPEG[I,14]  				
				PEQ_USER     := _cUsuario + " Em :" +cDthr
				PEQ_COMPTE   := aBrwPEG[I,16]

			PEQ->(MsUnlock())	 

            fEnvEmail()
     
	    EndIf 

	Next

Return()