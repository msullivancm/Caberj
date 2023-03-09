#Define CRLF Chr(13)+Chr(10)
#INCLUDE "PROTHEUS.ch"                                                                                                                                  
#INCLUDE "TOPCONN.ch"
#INCLUDE "PLSMGER.CH"                                                                                   
#Include "Ap5Mail.Ch"       
#Include 'Tbiconn.ch'
/*                                                                                                        
+--------------------------------------------------------------------------+
| Programa  | CABA129  | Autor | Altamiro	Affonso    | Data | 21/06/2013    |
|---------------------------------------------------------------------------|              
| Descricao | Calculo da atualização automatica das multas ANS              |
|           |                                                               |                                                       
|---------------------------------------------------------------------------|
| Uso       | Faturamento de convenios antecipado   - browser de seleção    |                                   
+---------------------------------------------------------------------------+
*/
User Function CABA197
                                                 

Private _cUsuario := SubStr(cUSUARIO,7,15)        
private cDthr     := (dtos(DATE()) + "-" + Time())     
Private _cIdUsuar := RetCodUsr()

PRIVATE nVlrAtual := 0.00
PRIVATE nVlracert := 0.00

Private aBrwPEG 
             //   1      2    			      	3				         	4					      5					            6			     		7					     8			                 	9	      					     10				         11	                         12                  13                   14                      15                   16                 
Private aCabPEG	:= { " ","Demanda" , "Prefixo" , "Numero" , "Prc","Tipo" , "Cod Forn" ,"Nome Fornecedor" , "Valor ","Acrescimo","Decrescimo","Saldo","Venc. Real","Emissao","Vlr Tit Ajustar","Dt Ajustar","Contr SE2","Contr PEB","Contr PBY", "Ult Parc"  }
Private aTamPEG	:= { 05 , 25       ,20         ,30        , 15   ,20     ,25          , 70               ,35       ,35         ,35          ,35     ,30          ,20       ,  25             , 30         , 15        ,15         ,15         ,   15 }

//private aBrwPEG
//Private aCabPEG		:= {" ", "Compt. Entrada","Operadora de  Origem  ","Vlr Fase 3","Vlr Fase 31/2","Vlr Fase 4","Vlr Inss","Vlr Tx Adm", "Total Guias","Faturado","Qtda Guias"}
//Private aTamPEG		:= {10,30,120,45,45,45,45,45,45,45,25}  

Private oOk      	:= LoadBitMap(GetResources(),"LBOK")
Private oNo      	:= LoadBitMap(GetResources(),"LBNO")

Private oVerde   	:= LoadBitMap(GetResources(),"ENABLE")
Private oVermelho	:= LoadBitMap(GetResources(),"DISABLE")  

Private aObjects 	:= {}

Private aSizeAut 	:= MsAdvSize() 

Private cPerg	   := "CABA129"     

private cCompInc  := ' '                    
private cCompFim  := ' '

private cmv_par09 := ' '   

private aSelic    := {}
private aCompt    := {}
Private aParcela  :={'1','2','3','4','5','6','7','8','9','A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z','a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z'}
//                    1   2   3   4   5   6   7   8   9   10  11  12  13  14  15  16  17  18  19  20  21  22  23  24  25  26  27  28  29  30  31  32  33  34  35  36  37  38  39  40  41  42  43  44  45  46  47  48  49  50  51  52  53  54  55  56  57  58  59  60  61 
private nPos      :=	0 

private cAliasCf  := GetNextAlias()    
private cAliasDem := GetNextAlias()   
private cAliasVA  := GetNextAlias()   // atualiza valor presente     
private cAliasEX  := GetNextAlias()
private cAliastmp := GetNextAlias()    

private cObsOnus := ' ' 
fCargaVet()

AjustaSX1()

Pergunte(cPerg,.T.)        

cCompInc := Mv_par01                     
cCompFim := Mv_par02  
cmv_par09:= Mv_par01

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

aAdd( aObjects, { 120,  200, lAjustHor, lAjustVert } )
//aAdd( aObjects, { 130,  250, lAjustHor, lAjustVert } )
//aAdd( aObjects, { 130,  250, lAjustHor, lAjustVert } )

nSepHoriz   := 5   
nSepVert    := 5
nSepBorHor 	:= 5
nSepBorVert	:= 5

aInfo  		:= { aSizeAut[ 1 ], aSizeAut[ 2 ], aSizeAut[ 3 ], aSizeAut[ 4 ], nSepHoriz, nSepVert, nSepBorHor, nSepBorVert }
aPosObj 	:= MsObjSize( aInfo, aObjects, .T. )

oDlg  		:= MsDialog():New( aSizeAut[7],00,aSizeAut[3]-100,aSizeAut[5]-10,"Atualização Automatica das Multas AN",,,.F.,,,,,,.T.,,,.T. ) 

oSayPEG    	:= TSay():New( aPosObj[1][1],aPosObj[1][2],{||'Atualização Automatica das Multas ANS '},oDlg,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,236,016)

bDbClickPEG	:= {|| aBrwPEG[oBrwPEG:nAt,1] := !aBrwPEG[oBrwPEG:nAt,1], oBrwPEG:Refresh()}   

//bChangePEG	:= {||AtuBrwGuia(aBrwPEG[oBrwPEG:nAt,2],aBrwPEG[oBrwPEG:nAt,3])}

//oBrwPEG 	:= TcBrowse():New(aPosObj[1][1]+10,aPosObj[1][2],aPosObj[1][4],aPosObj[1][3],,aCabPEG,aTamPEG,oDlg,,,,bChangePEG,bDbClickPEG,,,,,,,.F.,,.T.,,.F.,,, )

oBrwPEG 	:= TcBrowse():New(aPosObj[1][1]+10,aPosObj[1][2],aPosObj[1][4],aPosObj[1][3],,aCabPEG,aTamPEG,oDlg,,,,,bDbClickPEG,,,,,,,.F.,,.T.,,.F.,,, )

oBrwPEG:SetArray(aBrwPEG) 

oBrwPEG:bLine := {||{If( aBrwPEG[oBrwPEG:nAt,  1],oOk,oNo) ,;
                         aBrwPEG[oBrwPEG:nAt,  2] ,;
                         aBrwPEG[oBrwPEG:nAt,  3] ,;                       
 	  	    	             aBrwPEG[oBrwPEG:nAt,  4] ,;
		 	                aBrwPEG[oBrwPEG:nAt,  5] ,;
		 	                aBrwPEG[oBrwPEG:nAt,  6] ,; 
   		 	             aBrwPEG[oBrwPEG:nAt,  7] ,;
                         aBrwPEG[oBrwPEG:nAt,  8] ,;  
               Transform(aBrwPEG[oBrwPEG:nAt,  9],'@E  9999,999.99'),;                       
               Transform(aBrwPEG[oBrwPEG:nAt, 10],'@E  9999,999.99'),;                       
               Transform(aBrwPEG[oBrwPEG:nAt, 11],'@E  9999,999.99'),;                       
               Transform(aBrwPEG[oBrwPEG:nAt, 12],'@E  9999,999.99'),;                         
                    trim(aBrwPEG[oBrwPEG:nAt, 13]) ,;
                    trim(aBrwPEG[oBrwPEG:nAt, 14]) ,;
               Transform(aBrwPEG[oBrwPEG:nAt, 17],'@E  9999,999.99'),;                         
                    trim(aBrwPEG[oBrwPEG:nAt, 18]) ,;
                    trim(aBrwPEG[oBrwPEG:nAt, 15]) ,;
   	 	           trim(aBrwPEG[oBrwPEG:nAt, 16]) ,;
                    trim(aBrwPEG[oBrwPEG:nAt, 19]) ,;
                         aBrwPEG[oBrwPEG:nAt, 20]      }}                                       	 	                 

oBrwPEG:nScrollType  := 1 // Scroll VCR

lConfirmou 	:= .T.

aBut    :={{"PENDENTE", {||marca(1)   ,oBrwPEG:Refresh()           }	, "Marcar Todos "    , "Marcar Todos"     }}
aAdd(aBut, {"PENDENTE", {||desmarca(1),oBrwPEG:Refresh()           }	, "DesMarcar Todos "	, "DesMarcar Todos"	})  

aAdd(aBut, {"PENDENTE", {||fFazAtual(),oBrwPEG:Refresh(),oDlg:End()} , "Faz Atualização"  , "Faz Atualização"  })  

lConfirmou := .F.

//bOk 	:= {||fSequen() , oBrwPEG:Refresh() , oBrwPEG:Refresh() ,oDlg:End()   }    
 
bOk 	:= {|| MsgAlert("Favor Escolher uma opção em 'Ações Relacionadas'")  ,oBrwPEG:Refresh() }    
 
bCancel := {||lConfirmou := .F.,oDlg:End()}
	
oDlg:Activate(,,,.T.,,,EnchoiceBar(oDlg,bOk,bCancel,,aBut))

Return    

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

cQryPEG :="select peb.PEB_DEMAND Demanda , " + CRLF
cQryPEG +="       se2.e2_prefixo Prefixo , " + CRLF
cQryPEG +="       se2.e2_num     Num     , " + CRLF
cQryPEG +="       se2.E2_PARCELA Parcela , " + CRLF
cQryPEG +="       se2.e2_tipo    Tipo    , " + CRLF
cQryPEG +="       TRIM(se2.E2_FORNECE) fornece , " + CRLF
cQryPEG +="       TRIM(se2.e2_nomfor)  nomfor  , " + CRLF
cQryPEG +="       se2.E2_VALOR   Valor   , " + CRLF
cQryPEG +="       se2.E2_SDACRES Acresc  , " + CRLF
cQryPEG +="       se2.E2_SDDECRE Decresc , " + CRLF
cQryPEG +="       decode(se2.e2_saldo,0,0.00,(e2_saldo + se2.E2_SDACRES - se2.E2_SDDECRE ))SALDO , " + CRLF 
cQryPEG +="       TRIM(substr(se2.E2_VENCREA,7,2)||'/'||substr(se2.E2_VENCREA,5,2)||'/'||substr(se2.E2_VENCREA,1,4)) VencRea , " + CRLF 
cQryPEG +="       TRIM(substr(se2.E2_emissao,7,2)||'/'||substr(se2.E2_emissao,5,2)||'/'||substr(se2.E2_emissao,1,4)) Emissao , " + CRLF         
cQryPEG +="       PEB.PEB_VLRTIT VLTPEB , " + CRLF
cQryPEG +="       PEB.PEB_DATAAJ DATPEB , " + CRLF
cQryPEG +="       TRIM( se2.r_e_c_n_o_) SE2REC , TRIM(peb.r_e_c_n_o_) PEBREC , TRIM(pby.r_e_c_n_o_) PBYREC ," + CRLF

cQryPEG +="       Pby.Pby_Qtdpar qdpartPby, Peb.Peb_Partot qdpartPeb " + CRLF

cQryPEG +="  FROM "+RetSqlName('PEB')+ " PEB ,"+RetSqlName('SE2')+ " SE2 , "+RetSqlName('PBY')+ " PBY " + CRLF
cQryPEG +=" WHERE  E2_FILIAL = '" + xFilial('SE2') + "' AND SE2.D_E_L_E_T_ = ' ' " + CRLF
cQryPEG +="   AND PEB_FILIAL = '" + xFilial('PEB') + "' AND PEB.D_E_L_E_T_ = ' ' " + CRLF
cQryPEG +="   AND PBY_FILIAL = '" + xFilial('PBY') + "' AND PBY.D_E_L_E_T_ = ' ' " + CRLF

cQryPEG +="   and  se2.E2_PREFIXO = peb.PEB_PREFIX " + CRLF
cQryPEG +="   and  se2.E2_NUM     = peb.PEB_NUM    " + CRLF
cQryPEG +="   and  se2.E2_PARCELA = peb.PEB_PARCEL " + CRLF
cQryPEG +="   and  se2.e2_tipo    = peb.PEB_TIPO   " + CRLF
cQryPEG +="   and  se2.E2_FORNECE = peb.peb_fornec " + CRLF
cQryPEG +="   and  se2.E2_VENCREA like '"+cCompInc+"%'"+ CRLF
        
cQryPEG +="   and  se2.E2_PREFIXO = pbY.PBY_PREFPG "+ CRLF
cQryPEG +="   and  se2.E2_NUM     = pbY.PBY_TITPGT "+ CRLF   
cQryPEG +="   and  se2.E2_PARCELA = pbY.PBY_PARCPG "+ CRLF
cQryPEG +="   and  se2.e2_tipo    = pbY.PBY_TIPOPG "+ CRLF

cQryPEG +="   and  (Se2.E2_Acresc = 0 and Se2.E2_Decresc = 0 and se2.e2_saldo = se2.e2_valor) "+ CRLF 
cQryPEG +="   and  se2.e2_SALDO  <> 0 AND SE2.E2_SALDO <> PEB.PEB_VLRTIT " + CRLF
cQryPEG +="   and  (PEB.PEB_VLRTIT > 0  or PEB.PEB_DATAAJ <> ' ' )" + CRLF

cQryPEG +="  ORDER BY 1" + CRLF
                                      
TcQuery cQryPEG New Alias (cAliasPEG)

While !(cAliasPEG)->(EOF())

                                    
	aAdd(aRetPEG,{.F. , (cAliasPEG)->DEMANDA , ((cAliasPEG))->Prefixo , (cAliasPEG)->NUM  , (cAliasPEG)->PARCELA , (cAliasPEG)->TIPO, (cAliasPEG)->FORNECE,trim((cAliasPEG)->NOMFOR) , (cAliasPEG)->VALOR , (cAliasPEG)->Acresc , (cAliasPEG)->Decresc , (cAliasPEG)->SALDO , (cAliasPEG)->VencRea , (cAliasPEG)->EMISSAO , (cAliasPEG)->SE2REC , (cAliasPEG)->PEBREC , (cAliasPEG)->VLTPEB , (cAliasPEG)->DATPEB , (cAliasPEG)->PBYREC , (cAliasPEG)->qdpartPeb})
             //   1      2    			      	3				         	4					      5					            6			     		7					     8			                 	9	      					     10				         11	                         12                  13                   14                      15                   16                 17               18               19                     20    
	
		(cAliasPEG)->(DbSkip())

EndDo
  
(cAliasPEG)->(DbCloseArea())

If empty(aRetPEG)
	aAdd(aRetPEG,{.F.,;
                  '',;
                  '',; 
                  '',; 
                  '',;
                  '',;
                  '',;
                  '',;
                0.00,; 
                0.00,;
                0.00,; 
                0.00,;
            ' /  / ',;
            ' /  / ',;
                   0,;
                   0,;
                   0,;
            ' /  / ',;
                   0,;
                   ' '}) 
EndIf

Return aRetPEG

/********************************************/
/********************************************/                                    

/***********************************************************************************/
Static Function marca(cRef) // cRef == 1 peg , 2 , proc
	
       local nI            
       
	
		For nI := 1 to len(aBrwPEG)\
	
		    aBrwPEG[nI,1]:= .T.
			

		Next      
		
		
RETURN()	
	
Static Function desmarca(cRef) // cRef == 1 peg , 2 , proc
	
       local nI

			
	      For nI := 1 to len(aBrwPEG)
	
			   aBrwPEG[nI,1]:= .F.
			   
	      Next
	      
	
RETURN() 


/***************************************************************************************/
Static Function AjustaSX1()

Local aHelp 	:= {}   


aAdd(aHelp, "Compt Entrada  , ano mes da co mptencia de entrada  ")
PutSX1(cPerg,"01", "Compt Entrada  ?","","","mv_ch1","C",6,0,0,"G","","","","","mv_par01"," ","","",""," ","",""," ","","","","","","","","",aHelp,aHelp,aHelp)  


Return() 

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
     cDest+= "altamiro@caberj.com.br ; douglas.futuro@caberj.com.br"
ElseIf cNivel == '02'
      //destinatario Giordano  
     cDest+= "altamiro@caberj.com.br ; carlabiagioni@caberj.com.br"
ElseIf cNivel == '03'
      //destinatario jose paulo   
     cDest+= "altamiro@caberj.com.br ; macedo@caberj.com.br"
EndIf              

EnvEmail1( _cMensagem , cDest) 

RestArea(aArea)             

Return (.T.)                                                          
/*--------------------------------------*/
Static Function EnvEmail1( _cMensagem , cDest )
/*--------------------------------------*/                                          

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

 static function fCargaVet()
   
   local ret1       := 0
   local cAliasPea  := GetNextAlias()
   local cQuery     := " "

         cQuery :=  "select * From PEA010 PEA where PEA_FILIAL = '"+  xFilial("PEA") +"'   AND PEA.D_E_L_E_T_ = ' '  order by PEA.PEA_COMPTE "

         If Select((cAliasPea)) <> 0
            (cAliasPea)->(DbCloseArea())
         Endif

         TCQuery cQuery New Alias (cAliasPea)

         (cAliasPea)->( DbGoTop() )
         
         While !(cAliasPea)->(EOF())
                  
               Aadd(aCompt,{ trim((cAliasPea)->PEA_COMPTE) })
               Aadd(aSelic,{ (cAliasPea)->PEA_VALOR })

              (cAliasPea)->(dbSkip())  
            
               ret1++

         EndDo

         (cAliasPea)->(DbCloseArea())

Return( ret1 )

static function fFazAtual()

local nI:= 0
      
      For nI := 1 to len(aBrwPEG)
	
			   If aBrwPEG[nI,1]== .T.

               If aBrwPEG[nI,17] != 0 .or. aBrwPEG[nI,18] != ' ' 
        
                  If aBrwPEG[nI,10] != 0 .or. aBrwPEG[nI,11] != 0 

                      MsgAlert("Titulo No "+ aBrwPEG[nI,3] + "-" +aBrwPEG[nI,4] +" "+ aBrwPEG[nI,5] +" "+ aBrwPEG[nI,6] +", Já esta Ajustado !!! ","Atencao!")   
                      aBrwPEG[nI,1]== .F.

                  Else 

                      fAtMonet(aBrwPEG[nI,15] , aBrwPEG[nI,16] , aBrwPEG[nI,19], aBrwPEG[nI,20])
                      
                  EndIf

               Else 

                  MsgAlert("Titulo No "+ aBrwPEG[nI,3] +"-"+aBrwPEG[nI,4] +" "+aBrwPEG[nI,5] +" "+aBrwPEG[nI,6] +", Falta Valor de ajuste ou data de ajuste !!! ","Atencao!")
                  aBrwPEG[nI,1]== .F.

               EndIf 

            EndIf

	      Next
 a:='b'
Return()
/*-------------------------------------------------------------------------*/
   
static function fAtMonet(recse2 , recpeb , recpby ,cParctot)

private cvlratu := 0.00
        cObsOnus:=  " "
        dbselectArea("SE2")
        dbSetOrder(1)

	        SE2->(DbGoto(val(recse2)))
            
        dbselectArea("PEB")
        dbSetOrder(1)

            PEB->(DbGoto(val(recpeb)))

        dbselectArea("PBY")
        dbSetOrder(1)

           PBY->(DbGoto(val(recpby)))
  
    If  PEB->PEB_MODCAL == '1' 
        fCalAtuANS(substr(dtos(se2->E2_VENCREA),1,6),se2->E2_PARCELA)
    Else
        fCalAtuAGU(substr(dtos(se2->E2_VENCREA),1,6),se2->E2_PARCELA)
    EndIf
         /// atualização da multa
a:='b'

// desfazer para gravar 
      
         RecLock("SE2",.F.)

            If nVlracert <> 0 .or. nVlrAtual <> 0
               se2->E2_SDACRES  += nVlrAtual
               se2->E2_ACRESC   += nVlrAtual

               If nVlracert > 0
                  se2->E2_SDACRES  += nVlracert
                  se2->E2_ACRESC   += nVlracert
               Else
                  se2->E2_SDDECRE  += (nVlracert*-1)
                  se2->E2_DECRESC  += (nVlracert*-1)
               EndIf

            EndIf

            if !empty(peb->PEB_DATAAJ)  
               SE2->E2_VENCREA  :=  peb->PEB_DATAAJ
            EndIf
    
         Msunlock("SE2")
      
         RecLock("PEB",.F.)

            If nVlracert <> 0
               PEB->PEB_VLRAJA   := nVlrAtual   
            EndIf  
            If nVlracert <> 0
              PEB->PEB_VLRAJD   := nVlracert
            EndIF   
            PEB->PEB_USARAR   := _cIdUsuar +' - '+_cUsuario + ' - ' + cDthr  

         Msunlock("PEB")

         RecLock("PBY",.F.)

            If nVlracert <> 0
               PBY->PBY_VLACAT   += (nVlrAtual+nVlracert)   
               PBY->PBY_VLONUS   += nVlrAtual+nVlracert
               PBY->PBY_VLACPG   += nVlrAtual+nVlracert
            EndIf   
            
            If !empty(PBY->PBY_OBSONS) 
               PBY->PBY_OBSONS   += cObsOnus
            Else 
               PBY->PBY_OBSONS   := cObsOnus   
            EndIf   
           
         Msunlock("PBY")

      If (nVlrAtual+nVlracert)  <> 0   
         u_CTB197( SE2->E2_VENCREA ,(nVlrAtual-nVlracert) , peb->peb_demand , se2->e2_parcela, cParctot)
      EndIf

  //  versao de teste
 //         u_CTB197( SE2->E2_VENCREA ,(se2->E2_SDACRES-se2->E2_SDDECRE) , peb->peb_demand , se2->e2_parcela, cParctot)
   
//         fEnmail("AJT", "PGT", PBY->PBY_PREFPG, PBY->PBY_TITPGT , PBY->PBY_PARCPG , PBY->PBY_TIPOPG , PBY->PBY_CODFOR ,  SE2->E2_LOJA , SA2->A2_NOME , PBY->PBY_DTVPAG , PBY->PBY_VLONUS)

////////
    

   return()

   static function fCalAtuANS(cCompt1 , cParcela1)

      local nInd1     := 0
      local nInd2     := 0

      local cJuros    := 1
      local cConta    := 0

      local cPercMes := 0.00
      local cPercTot := 0.00
      local nVlrMAnt := 0.00
      local nVlrAtul := 0.00
      local nVlrCor  := 0.00
      local nVlrTcor := 0.00

      local cVlrAtuAns := 0.00

      LOCAL IND  := 0

      nInd1 := Ascan(aCompt,{ |x| x[1] = cCompt1 })

      If nInd1 > 0

      // orientado pelo Sr Alan que se utiliza a selic do mes anterior 
      // ja que a do mes de calculo nao existe (nao publicada)
      // ação documentada por email em 09/08/2021

         nInd1--

         nInd2 := nInd1 - ((aScan(aParcela, cParcela1 )) - 1)

         If nInd2 > 0

            cObsOnus +=  CRLF + "--> Modelo ANS - Atualizado Pelo Sistema -  Usuario " + _cIdUsuar+ " - "+_cUsuario+" Em "  + cDthr + CRLF + CRLF

            For IND  := nInd2 to nInd1

               cConta++

               If cConta <= 3

                  cPercMes := 0.00
                  cPercTot += cPercMes

                  cComptAtl:= aCompt[IND][1] 

                  nVlrMAnt := Se2->e2_valor
                  nVlrAtul := nVlrMAnt+((nVlrMAnt*cPercMes)/100)
                  nVlrCor  := (nVlrMAnt*cPercMes ) /100

                  nVlrTcor := nVlrAtul - Se2->e2_valor

                  cObsOnus +=  " Parc "+ Transform(cConta,"@e 999") +;
                     " Vlr Orginal R$ " + Transform(Se2->e2_valor,"@e 9,999,999.99") +;
                     " Vlr Mes Anterior R$ " + Transform(nVlrMAnt,"@e 9,999,999.99") +;
                     " Vlr Atual. "+ Transform((nVlrAtul),"@e 9,999,999.99") +;
                     " % Atul. Mesal :"+ Transform(cPercMes,"@e 999.99")+"% -"+;
                     " % Atul. Total :"+ Transform(cPercTot,"@e 999.99")+"% -"+;
                     " Vlr da Correção "+ Transform(nVlrCor ,"@e 999,999.99") + ;
                     " Compt Atual.  "+ cComptAtl + CRLF

               ElseIf cConta == 4

                  cPercMes := cJuros
                  cPercTot += cPercMes

                  cComptAtl:= aCompt[IND][1] 

                  nVlrMAnt :=  nVlrAtul
                  nVlrAtul :=  nVlrMAnt+((nVlrMAnt*cPercMes)/100)
                  nVlrCor  :=  (nVlrMAnt*cPercMes) /100

                  nVlrTcor := nVlrAtul - Se2->e2_valor

                  cObsOnus +=  " Parc "+ Transform(cConta,"@e 999") +;
                     " Vlr Orginal R$ " + Transform(Se2->e2_valor,"@e 9,999,999.99") +;
                     " Vlr Mes Anterior R$ " + Transform(nVlrMAnt,"@e 9,999,999.99") +;
                     " Vlr Atual. "+ Transform((nVlrAtul),"@e 9,999,999.99") +;
                     " % Atul. Mesal :"+ Transform(cPercMes,"@e 999.99")+"% -"+;
                     " % Atul. Total :"+ Transform(cPercTot,"@e 999.99")+"% -"+;
                     " Vlr da Correção "+ Transform(nVlrCor ,"@e 999,999.99")      +;
                     " Compt Atual.  "+ cComptAtl + CRLF
               Else

                  cPercMes := Iif (len(aSelic) > IND ,  aSelic[IND][1]  , 0.00)
                  cPercTot += cPercMes

                  cComptAtl:= aCompt[IND][1] 

                  nVlrMAnt := nVlrAtul
                  nVlrAtul := nVlrMAnt+((nVlrMAnt*cPercMes)/100)
                  nVlrCor  := (nVlrMAnt*cPercMes ) /100
                  nVlrTcor := nVlrAtul - Se2->e2_valor

                  cObsOnus +=  " Parc "+ Transform(cConta,"@e 999") +;
                     " Vlr Orginal R$ " + Transform(Se2->e2_valor,"@e 9,999,999.99") +;
                     " Vlr Mes Anterior R$ " + Transform(nVlrMAnt,"@e 9,999,999.99") +;
                     " Vlr Atual. "+ Transform((nVlrAtul),"@e 9,999,999.99") +;
                     " % Atul. Mesal :"+ Transform(cPercMes,"@e 999.99")+"% -"+;
                     " % Atul. Total :"+ Transform(cPercTot,"@e 999.99")+"% -"+;
                     " Vlr da Correção "+ Transform(nVlrCor ,"@e 999,999.99") +;
                     " Compt Atual.  "+ cComptAtl + CRLF
               EndIf

            Next IND

         Else

            MsgAlert("SELIC não cadastrada, SELIC Não localizado !!! ","Atencao!")

         EndIf

      Else

         MsgAlert("COMPETENCIA não cadastrada, COMPETENCIA Não localizado !!! ","Atencao!")

      EndIf

      nVlrAtual:= nVlrTcor
      nVlracert:= PEB->PEB_VLRTIT  - (nVlrTcor+Se2->e2_valor) 
            
      cObsOnus +=  CRLF + CRLF + "--> Valor Atualizado Automaticamete R$ " + Transform((nVlrTcor+Se2->e2_valor),"@e 999,999.99") + ", Valor da Atualização R$ "+Transform(nVlrTcor,"@e 9,999.99") +" -  Em "  + cDthr + CRLF 
//      MsgAlert(cObsOnus,"Atencao!")

   
   RETURN()

static function fCalAtuAGU(cCompt1 , cParcela1)

   local nInd1     := 0
   local nInd2     := 0

   local cJuros    := 1
   local cConta    := 0

   local cPercMes := 0.00
   local cPercTot := 0.00
   local nVlrMAnt := 0.00
   local nVlrAtul := 0.00
   local nVlrCor  := 0.00
   local nVlrTcor := 0.00
   

   LOCAL IND := 0

   nInd1 := Ascan(aCompt,{ |x| x[1] = cCompt1 })

      If nInd1 > 0

      // orientado pelo Sr Alan que se utiliza a selic do mes anterior 
      // ja que a do mes de calculo nao existe (nao publicada)
      // ação documentada por email em 09/08/2021

         nInd1--
    
         nInd2 := nInd1 - ((aScan(aParcela, cParcela1 )) - 1)

         If nInd2 > 0

            cObsOnus +=  CRLF + "--> Modelo AGU - Atualizado Pelo Sistema -  Usuario " + _cIdUsuar+ " - "+_cUsuario+" Em "  + cDthr + CRLF 
            cObsOnus +=  CRLF + "--> A Selic utilizada e sempre a do mês anterior a da competência "+ CRLF + CRLF

            For IND := nInd2 to nInd1

               cConta++
 
               If cConta == 1 
                  cPercMes := 0.00
                  cPercTot += cPercMes

                  cComptAtl:= aCompt[IND][1] 

                  nVlrMAnt := Se2->e2_valor
                  nVlrAtul := nVlrMAnt+((nVlrMAnt*cPercMes)/100)
                  nVlrCor  := (nVlrMAnt*cPercMes ) /100

                  nVlrTcor := nVlrAtul - Se2->e2_valor

                  cObsOnus +=  " Parc "+ Transform(cConta,"@e 999") +;
                     " Vlr Orginal R$ " + Transform(Se2->e2_valor,"@e 9,999,999.99") +;
                     " Vlr Mes Anterior R$ " + Transform(nVlrMAnt,"@e 9,999,999.99") +;
                     " Vlr Atual. "+ Transform((nVlrAtul),"@e 9,999,999.99") +;
                     " % Atul. Mesal :"+ Transform(cPercMes,"@e 999.99")+"% -"+;
                     " % Atul. Total :"+ Transform(cPercTot,"@e 999.99")+"% -"+;
                     " Vlr da Correção "+ Transform(nVlrCor ,"@e 999,999.99")+      ;
                     " Compt Atual.  "+ cComptAtl + CRLF

               ElseIf cConta == 2

                  cPercMes := cJuros
                  cPercTot += cPercMes

                  cComptAtl:= aCompt[IND][1] 

                  nVlrMAnt :=  nVlrAtul
                  nVlrAtul :=  nVlrMAnt+((nVlrMAnt*cPercMes)/100)
                  nVlrCor  :=  (nVlrMAnt*cPercMes) /100
                  nVlrTcor := nVlrAtul - Se2->e2_valor

                  cObsOnus +=  " Parc "+ Transform(cConta,"@e 999") +;
                     " Vlr Orginal R$ " + Transform(Se2->e2_valor,"@e 9,999,999.99") +;
                     " Vlr Mes Anterior R$ " + Transform(nVlrMAnt,"@e 9,999,999.99") +;
                     " Vlr Atual. "+ Transform((nVlrAtul),"@e 9,999,999.99") +;
                     " % Atul. Mesal :"+ Transform(cPercMes,"@e 999.99")+"% -"+;
                     " % Atul. Total :"+ Transform(cPercTot,"@e 999.99")+"% -"+;
                     " Vlr da Correção "+ Transform(nVlrCor ,"@e 999,999.99")+      ;
                     " Compt Atual.  "+ cComptAtl + CRLF
               Else

                  cPercMes := Iif (len(aSelic) > IND ,   aSelic[IND][1]  , 0.00)
                  cPercTot += cPercMes

                  cComptAtl:= aCompt[IND][1] 

                  nVlrMAnt := nVlrAtul
                  nVlrAtul := nVlrMAnt+((nVlrMAnt*cPercMes)/100)
                  nVlrCor  := (nVlrMAnt*cPercMes ) /100
                  nVlrTcor := nVlrAtul - Se2->e2_valor

                  cObsOnus +=  " Parc "+ Transform(cConta,"@e 999") +;
                     " Vlr Orginal R$ " + Transform(Se2->e2_valor,"@e 9,999,999.99") +;
                     " Vlr Mes Anterior R$ " + Transform(nVlrMAnt,"@e 9,999,999.99") +;
                     " Vlr Atual. "+ Transform((nVlrAtul),"@e 9,999,999.99") +;
                     " % Atul. Mesal :"+ Transform(cPercMes,"@e 999.99")+"% -"+;
                     " % Atul. Total :"+ Transform(cPercTot,"@e 999.99")+"% -"+;
                     " Vlr da Correção "+ Transform(nVlrCor ,"@e 999,999.99")+      ;
                     " Compt Atual.  "+ cComptAtl + CRLF
               EndIf

            Next IND

         Else

            MsgAlert("SELIC não cadastrada, SELIC Não localizado !!! ","Atencao!")

         EndIf

      Else

         MsgAlert("COMPETENCIA não cadastrada, COMPETENCIA Não localizado !!! ","Atencao!")

      EndIf
      
      cObsOnus +=  CRLF + CRLF + "--> Valor Atualizado Automaticamete R$ " + Transform((nVlrTcor+Se2->e2_valor),"@e 999,999.99") + ", Valor Da Atualização R$ "+Transform(nVlrTcor,"@e 9,999.99") +" -  Em "  + cDthr + CRLF 

  //    MsgAlert(cObsOnus,"Atencao!")

      nVlrAtual:= nVlrTcor
      nVlracert:= PEB->PEB_VLRTIT  - (nVlrTcor+Se2->e2_valor) 

      cObsOnus +=  CRLF + CRLF + "--> Valor Atualizado Automaticamete , Valor Da Correção da Atualização automatica R$ "+Transform(nVlracert,"@e 9,999.99") +" -  Em "  + cDthr + CRLF 
   
   RETURN()


//////////////////////////////////////////
/* faz a provicionamento da atualização do mes projetado para as parcela futuras */
///////////////////////////////////////////

User Function CTB197( dtvenc , valor , cidmulta, cNparcAt, cParctot)
//CTB197( SE2->E2_VENCREA ,(se2->E2_SDACRES-se2->E2_SDDECRE) , peb->peb_demand , se2->e2_parcela)
            
Local 	cQueryVW
Local 	cArqTMP	  := GetNextAlias()
Local 	cQueryEv
Local 	cArqEve	  := GetNextAlias()  
Local 	nProc	     := 0

local    nFecham    := 0.00

PRIVATE nMesbs      := val(substr(DTOS(dtvenc),5,2))  // VENCIMENTOS DO TITULOS QUE ESTA SENDO ATUALIZADO

PRIVATE nAnobs      := val(substr(DTOS(dtvenc),1,4))  // VENCIMENTOS DO TITULOS QUE ESTA SENDO ATUALIZADO

private  cLgnCrt    := 'C1'
PRIVATE  nQtdParc   := cParctot

PUBLIC  _197VLCRT   := 0.00

PUBLIC  _197VLLNG   := 0.00
PUBLIC  _197VLTOT   := 0.00

PUBLIC  _197HIST    := ' ' // HISTORICO DO LANÇAMENTOS 



npos := Ascan( aParcela,cNparcAt )
QdPrcRest := (nQtdParc - npos)
nVlrAtuBs := fCalVlrAtu(aParcela[npos],aParcela[npos-1] )
// conforme orientado pelo Guilherme da contabilidade e confirmado por email 
// o provisionamento do curto prazo sera :
// quando for o primerio ano , o provisionamento e do meses restante do ano mais o ano seguinte (12 meses) 
// quando for segundo ano em diante o provisionamento sera dos meses restante do ano 

If npos <= nMesbs  
   nMesCont := 24
Else 
   nMesCont := 12
EndIf 

If (QdPrcRest + nMesbs) <=   nMesCont
    
    _197VLCRT := (nVlrAtuBs * (QdPrcRest - (nMesbs))) + nVlrAtuBs  

else 

    _197VLCRT := (nVlrAtuBs * (nMesCont - (nMesbs))) + nVlrAtuBs    

    _197VLLNG := nVlrAtuBs * (QdPrcRest - (nMesCont - (nMesbs)))

   nFecham :=  (_197VLCRT + _197VLLNG) 

EndIf     

 _197VLTOT  := _197VLCRT + _197VLLNG 

 _197VLCRT +=  ((_197VLCRT + _197VLLNG) - _197VLTOT)

 _197HIST   := 'Id Multa  ' + trim(cidmulta) +' Parc atual ' + cNparcAt +' '+strzero(npos,2) +' De ' + strzero(nQtdParc,2) + ' Parc Rest '+ strzero(QdPrcRest,2) + ' Parc. CP ' +  strzero((nMesCont - (nMesbs)) ,2) + ' Parc. LP ' +  strzero(QdPrcRest - (nMesCont - (nMesbs)),2)

 cPadrao     := "871"

 lPadrao     := VerPadrao(cPadrao)
//dDatabase	:=	lastday(stod(mv_par04+"01"))
dDatabase	:=	dtvenc
cLote       := "008871"
//
//MOSTRA LANÇAMENTO
l_Mostra    := .T.
lAglutina   := .T.     
//
cArquivo    := ""
nHdlPrv     := HeadProva(cLote,"MLT",Substr(cUsuario,7,6),@cArquivo)
_aArea	    :=	GetArea()
//
nTotReg	    := 0                                                                              
nValLan	    := 0
nSeq	       := 0

nTotReg	++
//  
IncProc(" Processando ..." + cIdMulta )
//
_nVALOR		:= 0
_nTotal     := 0  
//
_nTotal     += DetProva(nHdlPrv,cPadrao,"MLT",cLote)  
nSeq ++
//
RodaProva(nHdlPrv,_nTotal)
cA100Incl(cArquivo,nHdlPrv,3,cLote,l_Mostra,lAglutina)
nSeq := 0

return() 

static Function fAtuPe6(cidmulta, dtvenc , cNparcAt , nQtdParc)

Local 	cQueryVW  := ' '
Local 	cQuerySE2 := ' '

cQuerySE2 := "     select max(e2_vencrea) "
cQuerySE2 += CRLF+ " from  " + RetSqlName("SE2") +" SE2 "
cQuerySE2 += CRLF+ "where E2_filial = '"+xFilial('SE2')+ "' and SE2.d_E_L_E_T_ = ' ' "
cQuerySE2 += CRLF+ "  and e2_prefixo = 'RPD' 
cQuerySE2 += CRLF+ "   and E2_NUM  ='"+SE2->E2_NUM +"'"        
    
cQueryVW := "     select NVL(PE6_QTDTPR , 0) QTDTPR   , nvl(R_E_C_N_O_ , 0) Rec"
cQueryVW += CRLF+ " from  " + RetSqlName("PE6") +" PE6 "
cQueryVW += CRLF+ " where PE6_filial = '"+xFilial('PE6')+ "' and PE6.d_E_L_E_T_ = ' ' " 
cQueryVW += CRLF+ " and PE6_PROCES ='"+cidmulta+"'"        
 
If Select((cAliastmp)) <> 0 
   (cAliastmp)->(DbCloseArea())  
Endif                          

TCQuery cQueryVW New Alias (cAliastmp)   

(cAliastmp)->( DbGoTop() )  
     
   If (cAliastmp)->Rec > 0
      dbselectArea("PE6")

      PE6->(DbGoto((cAliastmp)->Rec))

         RecLock("PE6",.F.)

            PE6->pe6_dtpatu := dtvenc
            PE6->pe6_paratu := strzero(cNparcAt,2)
            PE6->pe6_vlpatu := nVlrAtual+nVlracert
            PE6->pe6_dtultp := StoD('  /  /  ')
            PE6->pe6_parult :=aParcela[nQtdParc]

         Msunlock("SE2")
   EndIf 

(cAliastmp)->(DbCloseArea())

return()   

static Function fCalVlrAtu(ParcAtu , ParcAnt)

Local 	cQueryVAB  := ' '
local    nRet       := 0

QueryVAB  := "     select nvl((atu.vlrtit - ant.vlrtit), 0) VlrPrs "
QueryVAB  += CRLF+ " from "
QueryVAB  += CRLF+ "       (select peb_vlrtit vlrtit "
QueryVAB  += CRLF+ "          from  " + RetSqlName("PEB") +" PEB "
QueryVAB  += CRLF+ "         where PEB_filial = '"+xFilial('PEB')+ "' and PEB.d_E_L_E_T_ = ' ' "
QueryVAB  += CRLF+ "         and peb_prefix  = 'RPD' "
QueryVAB  += CRLF+ "         AND PEB_TIPO     = 'FT' "
QueryVAB  += CRLF+ "         AND PEB_NUM      = '"+PEB->peb_num +"'" 
QueryVAB  += CRLF+ "         AND PEB_PARCEL   = '"+ParcAtu+"')atu , "
QueryVAB  += CRLF+ "       (select peb_vlrtit  vlrtit "
QueryVAB  += CRLF+ "          from  " + RetSqlName("PEB") +" PEB "
QueryVAB  += CRLF+ "         where PEB_filial = '"+xFilial('PEB')+ "' and PEB.d_E_L_E_T_ = ' ' "
QueryVAB  += CRLF+ "         and peb_prefix  = 'RPD' "
QueryVAB  += CRLF+ "         AND PEB_TIPO     = 'FT' "
QueryVAB  += CRLF+ "         AND PEB_NUM      = '"+PEB->peb_num +"'" 
QueryVAB  += CRLF+ "         AND PEB_PARCEL   = '"+ParcAnt+"') ant "

If Select((cAliasVA)) <> 0 
   (cAliasVA)->(DbCloseArea())  
Endif                          

TCQuery QueryVAB New Alias (cAliasVA)   

(cAliasVA)->( DbGoTop() )  
     
  nRet := (cAliasVA)->VlrPrs

(cAliasVA)->(DbCloseArea())

return(nRet)   