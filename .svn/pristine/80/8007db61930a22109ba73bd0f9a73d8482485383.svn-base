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

User Function CABA132

local cRda        := ' '
local cNivel      := ' '
local nI := 0


private lsai      := .F.
private aBrwPEG   := {}
Private aCabPEG	  := { " ","Filial" , "Cod Fornec." , "Cod RDA" ,"Nome / Razao Social" ,"Titulo" , "Saldo do Tit" ,"Tot Impostos","Total Desenbolso" , "Dta Emissão","Dta Venciemto", "Controle"}

Private aTamPEG	  := { 10 , 30      , 40            ,40         ,15                    ,30       , 40             , 50          , 50                , 40           , 40            , 30}


Private oOk       := LoadBitMap(GetResources(),"LBOK")
Private oNo       := LoadBitMap(GetResources(),"LBNO")

Private aObjects  := {}
Private aSizeAut  := MsAdvSize()
Private cPerg	  := "CABA132"
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

nSepHoriz   := 5
nSepVert    := 5
nSepBorHor 	:= 5
nSepBorVert	:= 5

aInfo  		:= { aSizeAut[ 1 ], aSizeAut[ 2 ], aSizeAut[ 3 ], aSizeAut[ 4 ], nSepHoriz, nSepVert, nSepBorHor, nSepBorVert }
aPosObj 	:= MsObjSize( aInfo, aObjects, .T. )

oDlg  		:= MsDialog():New( aSizeAut[7],00,aSizeAut[3]-100,aSizeAut[5]-10,"Liberação de Titulos Para Filial de Produção",,,.F.,,,,,,.T.,,,.T. )

oSayPEG    	:= TSay():New( aPosObj[1][1],aPosObj[1][2],{||'Liberação de Titulos Para Filial de Produção'},oDlg,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,236,016)

bDbClickPEG	:= {|| aBrwPEG[oBrwPEG:nAt,1] := !aBrwPEG[oBrwPEG:nAt,1] , VerifMarc( oBrwPEG:nAt , aBrwPEG[oBrwPEG:nAt,4] ) ,  VerifdMarc( oBrwPEG:nAt , aBrwPEG[oBrwPEG:nAt,4] ) ,oBrwPEG:Refresh()}  

oBrwPEG 	:= TcBrowse():New(aPosObj[1][1]+10,aPosObj[1][2],aPosObj[1][4],aPosObj[1][3],,aCabPEG,aTamPEG,oDlg,,,,,bDbClickPEG,,,,,,,.F.,,.T.,,.F.,,, )

oBrwPEG:SetArray(aBrwPEG)

oBrwPEG:bLine := {||{If( aBrwPEG[oBrwPEG:nAt,1],oOk,oNo) ,;
aBrwPEG[oBrwPEG:nAt,2]		 ,;
aBrwPEG[oBrwPEG:nAt,3]      ,;
aBrwPEG[oBrwPEG:nAt,4]      ,;
aBrwPEG[oBrwPEG:nAt,5]      ,;
aBrwPEG[oBrwPEG:nAt,11] +" "+aBrwPEG[oBrwPEG:nAt,12]  ,;
Transform(aBrwPEG[oBrwPEG:nAt,6],"@E 999,999,999.99") ,;
Transform(aBrwPEG[oBrwPEG:nAt,7],"@E 999,999,999.99") ,;
Transform(aBrwPEG[oBrwPEG:nAt,8],"@E 999,999,999.99") ,;
aBrwPEG[oBrwPEG:nAt,9]      ,;
aBrwPEG[oBrwPEG:nAt,10]      ,;
aBrwPEG[oBrwPEG:nAt,15]      }}


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

cquery := " SELECT '1',E2_FILIAL FILIAL  , E2_FORNECE CODFOR , E2_CODRDA CODRDA , A2_NOME NOME , " + CRLF 
cquery += "        e2_prefixo pref , e2_num num , e2_parcela parc, e2_tipo  tipo , " + CRLF
cquery += "        E2_SALDO SALDO , (E2_VRETPIS + E2_VRETCOF + E2_VRETCSL + E2_IRRF + E2_INSS + E2_ISS) IMPOSTOS ,  " + CRLF
cquery += "       (E2_SALDO + E2_VRETPIS + E2_VRETCOF + E2_VRETCSL + E2_IRRF + E2_INSS + E2_ISS) Tot_desem ,  " + CRLF
cquery += "        substr(E2_emissao,7,2)||'/'||substr(E2_emissao,5,2)||'/'||substr(E2_emissao,1,4) Dt_emissao ,  " + CRLF
cquery += "        substr(E2_VENCREA,7,2)||'/'||substr(E2_VENCREA,5,2)||'/'||substr(E2_VENCREA,1,4) Dt_vencrea  , Se2.R_E_C_N_O_ recse2" + CRLF
cquery += "   FROM "+RetSqlName('SE2')+ " SE2 ,"+RetSqlName('SA2')+ " SA2 " + CRLF       
cquery += "  WHERE e2_filial <> '"+xFilial("SE2")+"' and e2_saldo > 0 and e2_tipo = 'FT'  " + CRLF     
cquery += "    AND se2.d_E_L_E_T_ = ' '   " + CRLF
cquery += "    AND a2_filial = '"+xFilial("SA2")+"' and sa2.d_E_L_E_T_ = ' '   " + CRLF
cquery += "    AND e2_fornece = a2_cod  " + CRLF    
                   
cquery += "    AND E2_CODRDA >= '"+ MV_PAR01 +"' AND E2_CODRDA <= '"+ MV_PAR02 +"'" + CRLF

cquery += "  union all  " + CRLF
cquery += " SELECT '2',' 'filial   , E2_FORNECE CODFOR , E2_CODRDA CODRDA , ' ---> Total RDA <--- ' NOME ,   " + CRLF
cquery += "        ' ' pref , ' ' num , ' ' parc, ' '  tipo , " + CRLF
cquery += "        sum(E2_SALDO) SALDO ,sum((E2_VRETPIS + E2_VRETCOF + E2_VRETCSL + E2_IRRF + E2_INSS + E2_ISS)) IMPOSTOS ,   " + CRLF
cquery += "        sum((E2_SALDO + E2_VRETPIS + E2_VRETCOF + E2_VRETCSL + E2_IRRF + E2_INSS + E2_ISS)) Tot_desem , ' ' , ' ' , 0 " + CRLF 
cquery += "   FROM "+RetSqlName('SE2')+ " SE2 " + CRLF     
cquery += "  WHERE e2_filial <> '"+xFilial("SE2")+"' and e2_saldo > 0 and e2_tipo = 'FT'  and se2.d_E_L_E_T_ = ' '  " + CRLF     
cquery += "    AND E2_CODRDA >= '"+ MV_PAR01 +"' AND E2_CODRDA <= '"+ MV_PAR02 +"'" + CRLF
cquery += "  GROUP BY  E2_FORNECE , E2_CODRDA , ' ---> Total RDA <--- '  " + CRLF
cquery += "  ORDER BY 4, 1 , 14  " + CRLF

////////////////////////////////////////
If Select(cAliasPEG) > 0
	dbSelectArea(cAliasPEG)
	dbclosearea()
Endif

TcQuery cQuery New Alias (cAliasPEG)

(cAliasPEG)->(dbGoTop())

While !(cAliasPEG)->(EOF())   

	aAdd(aRetPEG,{.F. , (cAliasPEG)->FILIAL , (cAliasPEG)->CODFOR  , (cAliasPEG)->CODRDA , (cAliasPEG)->NOME , (cAliasPEG)->SALDO  , (cAliasPEG)->IMPOSTOS , (cAliasPEG)->Tot_desem , (cAliasPEG)->Dt_emissao , (cAliasPEG)->Dt_vencrea  , (cAliasPEG)->pref, (cAliasPEG)->num, (cAliasPEG)->parc, (cAliasPEG)->tipo , (cAliasPEG)->recse2 })
              //   1      2    		    		3	    				4					5                    6                       7                       8                         9                           10                            11           12              13                   14                          15   
	(cAliasPEG)->(DbSkip())
	
EndDo

(cAliasPEG)->(DbCloseArea())

If empty(aRetPEG)
	aAdd(aRetPEG,{.T.,'','','','','','','','','','','','',0})
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

PutSx1(cPerg,"01",OemToAnsi("Rda Inicial") 		      ,"","","mv_ch1","C",06,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","","",{},{})
PutSx1(cPerg,"02",OemToAnsi("Rda Final  ")            ,"","","mv_ch2","C",06,0,0,"C","","","","","mv_par02","","","","","","","","","","","","","","","","",{},{},{})

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


Static function fazTriag()

local nI                                                                      
private cfilant := '01' 
private Indi    := 0

For nI := 1 to len(aBrwPEG)

	If  aBrwPEG[nI,1] == .T. .and. aBrwPEG[nI,15] <> 0 //.and. (cfornedor == ' ' .or. cfornedor == aBrwPEG[nI,03] )
        DbSelectArea("SE2")                        
        DbGoto(aBrwPEG[nI,15])  
        
        aAdd(aDados,{trim(aBrwPEG[nI][02]),trim(aBrwPEG[nI][03]),trim(aBrwPEG[nI][04]),trim(aBrwPEG[nI][05]),Transform(aBrwPEG[nI][06] , "@E 999,999,999.99"),Transform(aBrwPEG[nI][07] , "@E 999,999,999.99"),Transform(aBrwPEG[nI][08] , "@E 999,999,999.99"),aBrwPEG[nI][09],aBrwPEG[nI][10],aBrwPEG[nI][11] +' '+ aBrwPEG[nI][12]+SE2->E2_tipo  })

        VerImpostos(cLibBlq , aBrwPEG[nI,11] , aBrwPEG[nI,12] , aBrwPEG[nI,02])                               
        
        RecLock("SE2",.F.)
		 
   	     SE2->E2_FILIAL := '04'
		
        Msunlock("SE2") 
              
 //       MsgAlert("trocando a filial : "+OLDSE2->E2_FILIAL +" para :"+SE2->E2_FILIAL +" - titulos "+SE2->E2_prefixo+se2->e2_num+SE2->E2_tipo )

    EndIf 

Next
     
     FGrvPlan( cfilant )      
     
Return()

/////////////////////////////////////////////////////////////////   

Static Function FGrvPlan( cfilant )           

   cEmpresa:=  Iif(cempant == '01','Caberj','Integral')
   cAcao   :=  'Liberação de Titulos para filial de produção '
                 
        cNomeArq := "\LOG_TrFil\"+substr(cEmpresa,1,3)+'_'+adados[1,3]+'_' +DtoS(date())+"_"+STRTRAN(TIME(),":","_")+".csv"
		nHandle := FCREATE(cNomeArq)
        
        cMontaTxt := 'Empresa  : '+ Iif (cEmpant == '01', 'Caberj' , 'Integral')  
        cMontaTxt += CRLF
        FWrite(nHandle,cMontaTxt)		
                
        cMontaTxt := 'Ação  : Da Filial  '+ cfilant +' Para Produção ' 
        cMontaTxt += CRLF
        FWrite(nHandle,cMontaTxt)		  
        
        cHora:= StrTran(Time(),':','')   
        
        cHora := substr(cHora,1,2)+':'+substr(cHora,3,2)+':'+substr(cHora,5,2)
        
        cMontaTxt := 'Usuario : '+SubStr(cUSUARIO,7,15)+  '   Data : '+substr(dtos(date()),7,2)+'/'+substr(dtos(date()),5,2)+'/'+substr(dtos(date()),1,4)+ ' Hora : '+cHora	
        cMontaTxt += CRLF
        FWrite(nHandle,cMontaTxt) 
	   	         
        cMontaTxt := "Filial Origem ;"  
		cMontaTxt += "Cod Fornecdor ;"   
		cMontaTxt += "Cod Rda       ;"       
		cMontaTxt += "Nome          ;" 
		cMontaTxt += "Titulos       ;"     
		cMontaTxt += "Saldo         ;"     
		cMontaTxt += "Impostos      ;"  
		cMontaTxt += "Tot Desembolso;"  
		cMontaTxt += "Dt Emissao    ;"    
		cMontaTxt += "Dt Vencimento ;"     
		cMontaTxt += "Filial Destino;"     
		cMontaTxt += CRLF // Salto de linha para .csv (excel)
             
		FWrite(nHandle,cMontaTxt)
		
      For I := 1 to len(aDados)
		
   		  cMontaTxt := aDados[I][01] + ";"  
   		  cMontaTxt += aDados[I][02] + ";"   
   		  cMontaTxt += aDados[I][03] + ";"   
   		  cMontaTxt += aDados[I][04] + ";"  
   	 	  cMontaTxt += aDados[I][10] + ";" 
   	 	  cMontaTxt += aDados[I][05] + ";"     
   		  cMontaTxt += aDados[I][06] + ";"    
   		  cMontaTxt += aDados[I][07] + ";"   
          cMontaTxt += aDados[I][08] + ";"     		     		    
          cMontaTxt += aDados[I][09] + ";"     		     		   
   		  cMontaTxt += '01'          + ";"   
     	  cMontaTxt += CRLF // Salto de linha para .csv (excel)      
		      
		  FWrite(nHandle,cMontaTxt)
	
     Next 

	If nHandle > 0
		
		// encerra gravação no arquivo
		FClose(nHandle)

//		MsgAlert("Relatorio salvo em: "+cNomeArq)

		fEnvEmail(cNomeArq , cEmpresa  )
	EndIf       
    indi:= 0 
    indf:= 0
Return()	 

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³VerImpostos ³ Autor ³ Jose Carlos Noronha ³ Data ³ 02/08/07 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Verificar se Tem Titulos de Impostos do PLS                ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ VerImpostos(cLibBlq)                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Caberj                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static FuncTion VerImpostos(cLibBlq , _cPref  , _cTitulo , _cFilial)

LOCAL   cPrefixo := _cPref
LOCAL   cNum	 := _cTitulo
LOCAL   cParcPai

DbSelectArea("SE2")
nReg := RECNO()
If SE2->E2_ISS > 0
	nValorPai := SE2->E2_ISS
	cParcPai  := SE2->E2_PARCISS
	cTipoPai  := MVISS
	AchaImpostos(nValorPai,cParcPai,cTipoPai,_cFilial,cPrefixo,cNum,cLibBlq)
Endif
dbgoto(nReg)
If SE2->E2_INSS > 0
	nValorPai := SE2->E2_INSS
	cParcPai  := SE2->E2_PARCINS
	cTipoPai  := MVINSS
	AchaImpostos(nValorPai,cParcPai,cTipoPai,_cFilial,cPrefixo,cNum,cLibBlq)
Endif
dbgoto(nReg)
If SE2->E2_SEST > 0
	nValorPai := SE2->E2_SEST
	cParcPai  := SE2->E2_PARCSES
	cTipoPai  := "SES"
	AchaImpostos(nValorPai,cParcPai,cTipoPai,xxx,_cFilial,cPrefixo,cNum,cLibBlq)
Endif
dbgoto(nReg)
If SE2->E2_VRETPIS > 0       
//	nValorPai := SE2->E2_PIS
	nValorPai := SE2->E2_VRETPIS
	cParcPai  := SE2->E2_PARCPIS
	cTipoPai  := MVTAXA
	AchaImpostos(nValorPai,cParcPai,cTipoPai,_cFilial,cPrefixo,cNum,cLibBlq)
Endif
dbgoto(nReg)
If SE2->E2_VRETCOF > 0          
//	nValorPai := SE2->E2_COFINS
	nValorPai := SE2->E2_VRETCOF
	cParcPai  := SE2->E2_PARCCOF
	cTipoPai  := MVTAXA
	AchaImpostos(nValorPai,cParcPai,cTipoPai,_cFilial,cPrefixo,cNum,cLibBlq)
Endif
dbgoto(nReg)
If SE2->E2_VRETCSL > 0          
//	nValorPai := SE2->E2_CSLL
	nValorPai := SE2->E2_VRETCSL
	cParcPai  := SE2->E2_PARCSLL
	cTipoPai  := MVTAXA
	AchaImpostos(nValorPai,cParcPai,cTipoPai,_cFilial,cPrefixo,cNum,cLibBlq)
Endif
dbgoto(nReg)
If SE2->E2_IRRF > 0
	nValorPai := SE2->E2_IRRF
	cParcPai  := SE2->E2_PARCIR
	cTipoPai  := MVTAXA
	AchaImpostos(nValorPai,cParcPai,cTipoPai,_cFilial,cPrefixo,cNum,cLibBlq)
Endif
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³AchaImpostos³ Autor ³ Jose Carlos Noronha ³ Data ³ 02/08/07 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Achar Titulos de Impostos do PLS                           ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Caberj                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function AchaImpostos(nValorPai,cParcPai,cTipoPai , _xcFil,xPrefixo,cNum,cLibBlq)
dbSelectArea("SE2")
If dbSeek(_xcFil+xPrefixo+cNum)
	While !Eof() .and. SE2->(E2_FILIAL+E2_PREFIXO+E2_NUM) == _xcFil+xPrefixo+cNum
		If cParcPai == SE2->E2_PARCELA .and. cTipoPai = SE2->E2_TIPO
			If nValorPai != 0
           
                aAdd(aDados,{trim(SE2->E2_FILIAL) ,;
			                 trim(SE2->E2_fornece),;
			                 trim(SE2->E2_codrda), ;
			                 trim(SE2->E2_nomfor), ;
			                 Transform(SE2->E2_saldo , "@E 999,999,999.99"), ;
			                 Transform(SE2->E2_sest  , "@E 999,999,999.99"), ; 
			                 Transform(SE2->E2_saldo , "@E 999,999,999.99"), ;
			                 substr(dtos(SE2->E2_emissao),7,2)+'/'+substr(dtos(SE2->E2_emissao),5,2)+'/'+substr(dtos(SE2->E2_emissao),1,4),;  
                             substr(dtos(SE2->E2_vencrea),7,2)+'/'+substr(dtos(SE2->E2_vencrea),5,2)+'/'+substr(dtos(SE2->E2_vencrea),1,4),; 
			                 SE2->E2_prefixo+' '+se2->e2_num + se2->e2_tipo })

			 	RecLock("SE2",.F.)
	          
	               SE2->E2_FILIAL  := '04'
			 	
			 	MSunlock()

//       MsgAlert("trocando a filial : "+OLDSE2->E2_FILIAL +" para :"+SE2->E2_FILIAL +" - titulos "+SE2->E2_prefixo+se2->e2_num+SE2->E2_tipo )
			  
				Exit
			EndIf
		EndIf
		DbSkip()
	Enddo
EndIf
dbSelectArea("SE2")
dbgoto(nReg)
Return

       