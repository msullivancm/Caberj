#INCLUDE "PROTHEUS.ch"
#INCLUDE "TOPCONN.ch"
#INCLUDE "PLSMGER.CH"
#Include "Ap5Mail.Ch"
#Include 'Tbiconn.ch'   
#Include "PRTOPDEF.CH"
#Include "rwmake.ch"   
#Include "RPTDEF.CH"     
#include "PLSA090.ch"
#include "PROTHEUS.CH"
#include "PLSMGER2.CH"
#INCLUDE "TOTVS.CH"
#INCLUDE "UTILIDADES.CH"

#Define CRLF Chr(13)+Chr(10)
/*--------------------------------------------------------------------------
| Programa  | CABA131  | Autor | Altamiro	Affonso    | Data | 24/10/2017  |
|---------------------------------------------------------------------------|
| Descricao | analise da carteira em relação a posição do sib               |
|           |                                                               |
|---------------------------------------------------------------------------|
| Uso       | Ajustes / visualização das varias do  sib - browser de seleção|
--------------------------------------------------------------------------*/

User Function CABA142

local cRda        := ' '
local cNivel      := ' '
local nI := 0
                        
private aDadDet   := {}
private aBrwPEG   := {}
Private aCabPEG	  := { " ","Desc" , "AtuSib" , "InfSib", "InfAns","Cod Cco ?", "Anterior Atv", "Anterior Bloq", "Anterior Tot", "Atual Atv", "Atual Bloq","Atual Tot","Posterior Atv", "Posterior Bloq","Posterior Tot" ,"Bloq. Mesmo Mes" ,"Tot Geral" ,"Status Ans" }
Private aTamPEG	  := { 10 , 60    , 20       , 20      , 20      , 20        , 40            ,  40            , 40            ,  40        , 40           , 40        , 40           ,   40            , 40             ,   40                 ,  40        ,    40       }
//                        1   2        3          4         5         6         7           8          9          0          1        2        3           4         5          6         17      
Private oOk       := LoadBitMap(GetResources(),"LBOK")
Private oNo       := LoadBitMap(GetResources(),"LBNO")

Private aObjects  := {}

Private aSizeAut  := MsAdvSize()

Private cPerg	  := "CABA142"

//private cAliasBA1  := GetNextAlias()
private cAliasPEG := GetNextAlias()
private cAliasCT  := GetNextAlias()
private cAliasEX  := GetNextAlias()

private cDtEntr   := ' '
Private cdata     := ' '
private cdtant    := ' '  
private cdtatu    := ' '
private cdtfut    := ' '  
Private nEmpresa  := ' '   
private lConfirmou:= .T.
private aRetPEG   := {}
private lFztot    := Iif (SubStr(cUSUARIO,7,8)=='Altamiro',.T.,.F.)    

private aDadCco   := {}     
private lSai      := .T.

AjustaSX1(cPerg)
                                   
Pergunte(cPerg,.T.)        

   cDtEntr   := dtos(mv_par01)
   cdata     := substr(cDtEntr,7,2)+'/'+substr(cDtEntr,5,2)+'/'+substr(cDtEntr,1,4)
   cdtant := iif(substr(cDtEntr,5,2)=='01', strzero((val(substr(cDtEntr,1,4))-1),4),substr(cDtEntr,1,4))+ ;
             iif(substr(cDtEntr,5,2)=='01','12',strzero((val(substr(cDtEntr,5,2))-1),2))+ ;
                 substr(cDtEntr,7,2)      
   cdtatu := cDtEntr 
   cdtfut := iif(substr(cDtEntr,5,2)=='12'     , strzero((val(substr(cDtEntr,1,4))+1),4),substr(cDtEntr,1,4))+ ;
             iif(substr(cDtEntr,5,2)=='12','01', strzero((val(substr(cDtEntr,5,2))+1),2))+'01'
                                                                                       


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
//aAdd( aObjects, { 130,  250, lAjustHor, lAjustVert } )
//aAdd( aObjects, { 130,  250, lAjustHor, lAjustVert } )

nSepHoriz   := 5
nSepVert    := 5
nSepBorHor 	:= 5
nSepBorVert	:= 5

aInfo  		:= { aSizeAut[ 1 ], aSizeAut[ 2 ], aSizeAut[ 3 ], aSizeAut[ 4 ], nSepHoriz, nSepVert, nSepBorHor, nSepBorVert }
aPosObj 	:= MsObjSize( aInfo, aObjects, .T. )

oDlg  		:= MsDialog():New( aSizeAut[7],00,aSizeAut[3]-100,aSizeAut[5]-10,"Analise da carteira em relação a posição do sib  ",,,.F.,,,,,,.T.,,,.T. )

oSayPEG    	:= TSay():New( aPosObj[1][1],aPosObj[1][2],{||'analise da carteira em relação a posição do sib    '},oDlg,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,236,016)

bDbClickPEG	:= {|| aBrwPEG[oBrwPEG:nAt,1] := !aBrwPEG[oBrwPEG:nAt,1] , VerifMarc( )  ,oBrwPEG:Refresh()}

//bChangePEG	:= {||AtuBrwGuia(aBrwPEG[oBrwPEG:nAt,2],aBrwPEG[oBrwPEG:nAt,3])}

//oBrwPEG 	:= TcBrowse():New(aPosObj[1][1]+10,aPosObj[1][2],aPosObj[1][4],aPosObj[1][3],,aCabPEG,aTamPEG,oDlg,,,,bChangePEG,bDbClickPEG,,,,,,,.F.,,.T.,,.F.,,, )

oBrwPEG 	:= TcBrowse():New(aPosObj[1][1]+10,aPosObj[1][2],aPosObj[1][4],aPosObj[1][3],,aCabPEG,aTamPEG,oDlg,,,,,bDbClickPEG,,,,,,,.F.,,.T.,,.F.,,, )

oBrwPEG:SetArray(aBrwPEG)

oBrwPEG:bLine := {||{If( aBrwPEG[oBrwPEG:nAt,1],oOk,oNo)      ,;
                         aBrwPEG[oBrwPEG:nAt,2]		          ,;
                         aBrwPEG[oBrwPEG:nAt,3]               ,;
                         aBrwPEG[oBrwPEG:nAt,4]               ,; 
                         aBrwPEG[oBrwPEG:nAt,5]		          ,;
                         aBrwPEG[oBrwPEG:nAt,6]               ,;
               Transform(aBrwPEG[oBrwPEG:nAt,7] ,'@E 999,999'),; 
               Transform(aBrwPEG[oBrwPEG:nAt,8] ,'@E 999,999'),;               
               Transform(aBrwPEG[oBrwPEG:nAt,9] ,'@E 999,999'),;               
               Transform(aBrwPEG[oBrwPEG:nAt,10],'@E 999,999'),;               
               Transform(aBrwPEG[oBrwPEG:nAt,11],'@E 999,999'),; 
               Transform(aBrwPEG[oBrwPEG:nAt,12],'@E 999,999'),;               
               Transform(aBrwPEG[oBrwPEG:nAt,13],'@E 999,999'),;               
               Transform(aBrwPEG[oBrwPEG:nAt,14],'@E 999,999'),;               
               Transform(aBrwPEG[oBrwPEG:nAt,15],'@E 999,999'),;  
               Transform(aBrwPEG[oBrwPEG:nAt,16],'@E 999,999'),; 
               Transform(aBrwPEG[oBrwPEG:nAt,17],'@E 999,999'),;               
                         aBrwPEG[oBrwPEG:nAt,18] }}


oBrwPEG:nScrollType  := 1 // Scroll VCR

lConfirmou 	:= .T.

aBut    :={{"PENDENTE", {||marca(1)      ,oBrwPEG:Refresh()             }	, "Marcar Todos "       , "Marcar Todos"     } }
aAdd(aBut, {"PENDENTE", {||u_desmarca1(1),oBrwPEG:Refresh()             }	, "DesMarcar Todos "	, "DesMarcar Todos"	 } )
aAdd(aBut, {"PENDENTE", {||geraExcel(1)  ,desmarca1(),oBrwPEG:Refresh() }	, "Demostrativo "   	, "Demostrativo"     } )
aAdd(aBut, {"PENDENTE", {||lsai:= .T.    , oDlg:End()                   }	, "Sair "   	        , "Sair"             } )
//aAdd(aBut, {"PENDENTE", {||fConfexc(1),oBrwPEG:Refresh(),oDlg:End()}	, "Excluir Selecção"   	, "Excluir Selecção" } )
//aAdd(aBut, {"PENDENTE", {||fConfexc(2),oBrwPEG:Refresh(),oDlg:End()}	, "Excl.Tit/Selecao"   	, "Excl.Tit/Selecao" } )

//If lsai

//  exit

//endIf

lConfirmou := .F.

bOk 	:= {||fazTriag() , desmarca1() , oBrwPEG:Refresh()  }

bCancel := {||lConfirmou := .F., oDlg:End()}

  
oDlg:Activate(,,,.T.,,,EnchoiceBar(oDlg,bOk,bCancel,,aBut))


//	MsgInfo("Processo finalizado")

//	MsgAlert(Left(cBuffer,len(cBuffer)-1))


Return

//EndDo


************************************************************************************


Static Function aDadosPEG
Local cquery	:= ""
//Local cAliasPEG	:= GetNextAlias()
local i

ProcRegua(0)

nCont := 0

for i:=1 to 5
	IncProc('Buscando Dados no Servidor ...')
next
cquery := "SELECT decode(BA1_LOCSIB,'0','0-NÃO ENVIADO', " + CRLF
cquery += "                   '1','1-ATIVO', " + CRLF
cquery += "                   '2','2-EXCLUÍDO'," + CRLF
cquery += "                   '3','3-ENVIADO INCLUSÃO ',   " + CRLF
cquery += "                   '4','4-ENVIADO ALTERAÇÃO',  " + CRLF
cquery += "                   '5','5-ENVIADO EXCLUSÃO ',   " + CRLF
cquery += "                   '6','6-CRIT INC (F/INC) ', " + CRLF
cquery += "                   '7','7-CRIT ALT (F/ALT) ',  " + CRLF
cquery += "                   '8','8-CRIT EXC (F/EXC) ',  " + CRLF
cquery += "                   '9','9-ENV MUD CONTRATUAL', " + CRLF
cquery += "                   'A','A-ENVIADO REATIVAÇÃO', " + CRLF
cquery += "                   'B','B-CRIT MUD CONTRATUAL'," + CRLF
cquery += "                   'C','C-CRIT REATIVAÇÃO',    " + CRLF
cquery += "                   'Outros - Não Previsto') DESC_LOCSIB, " + CRLF
cquery += " decode(BA1_ATUSIB,'0','Nao','Sim') AtuSib ,  " + CRLF
cquery += " decode(BA1_INFSIB,'0','Nao','Sim') InfSib ,  " + CRLF
cquery += " decode(BA1_INFANS,'0','Nao','Sim') InfAns ,   " + CRLF
cquery += " DECODE(TRIM(BA1_CODCCO),'', 'Sem CCo','Com CCo') Codcco, " + CRLF  

cquery += "        SUM (CASE WHEN ((TRIM( BA1_DATBLO) is Null OR BA1_DATBLO > '"+cdtant+"') AND (BA1_DATINC <= '"+cdtant+"'))  THEN 1 ELSE 0 END ) AN_A , " + CRLF 
cquery += "        SUM (CASE WHEN ((BA1_DATBLO <='"+cdtant+"') AND TRIM( BA1_DATBLO) is NOT  Null) THEN 1 ELSE 0 END )AN_B , " + CRLF
cquery += "        SUM (CASE WHEN   BA1_DATINC <='"+cdtant+"'  THEN 1 ELSE 0 END )  AN_T , " + CRLF

cquery += "        SUM (CASE WHEN trim(BA1_DATBLO) is  null   AND BA1_DATINC > '"+cdtant+"'  AND BA1_DATINC <= '"+cdtatu+"'   THEN 1 ELSE 0 END ) AT_A , " + CRLF
cquery += "        SUM (CASE WHEN    BA1_DATBLO > '"+cdtant+"' AND BA1_DATBLO <= '"+cdtatu+"' THEN 1 ELSE 0 END )  AT_B , " + CRLF
cquery += "        SUM (CASE WHEN (( BA1_DATINC >'"+cdtant+"' AND BA1_DATINC <='"+cdtatu+"') or (BA1_DATBLO >'"+cdtant+"' AND BA1_DATBLO <= '"+cdtatu+"' )) THEN 1 ELSE 0 END )   AT_T ," + CRLF

cquery += "        SUM (CASE WHEN  trim(BA1_DATBLO) is  null    AND BA1_DATINC >= '"+cdtatu+"' THEN 1 ELSE 0 END )  AP_A , " + CRLF
cquery += "        SUM (CASE WHEN  BA1_DATBLO >'"+cdtatu+"'  THEN 1 ELSE 0 END )  AP_B  ,  " + CRLF
cquery += "        SUM (CASE WHEN ( BA1_DATINC >'"+cdtatu+"'   or BA1_DATBLO >'"+cdtatu+"') THEN 1 ELSE 0 END )   AP_T , " + CRLF
                                                                               
cquery += "        SUM (CASE WHEN (BA1_DATINC > '"+cdtant+"' AND  substr(BA1_DATINC,1,6) = substr(BA1_DATBLO,1,6)) THEN 1 ELSE 0 END )  tot_blq_mes , " + CRLF

cquery += "        COUNT(*) TOTAL_GERAL , " + CRLF
cquery += "        decode(nvl(sib_situac,' '),'1', 'Ativo' , '3','Bloqueado', 'Sem ANS') status_ans " + CRLF 

If cempant == '01'                                                                                        
   cquery += "  FROM BA1010 BA1 , Confsib_Cab " + CRLF                                                        
Else 
   cquery += "  FROM BA1020 BA1 , Confsib_Int " + CRLF                                                        
EndIf 

cquery += " WHERE BA1_FILIAL = ' ' AND D_e_l_e_t_ = ' ' " + CRLF
If cempant == '01'                                                                                        
   cquery += "   AND BA1_CODEMP NOT IN ('0004','0009') " + CRLF
EndIf    

cquery += "   AND BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG||BA1_DIGITO = SIB_MATRIC(+) " + CRLF  
If dtos(mv_par02) != '20010101'
   cquery += "   AND (BA1_DATINC BETWEEN '"+dtos(mv_par02)+"'  AND '"+dtos(mv_par03)+"') " + CRLF
//cquery += "   AND BA1_DATINC > '19010101'   " + CRLF
EndIf
/*
If !lFztot 
   cquery += "  and  Ba1_locsib = '2'
   cquery += "  and decode(BA1_ATUSIB,'0','Não','Sim') = 'Não' " + CRLF
   cquery += "  and decode(BA1_INFSIB,'0','Não','Sim') = 'Não' " + CRLF
   cquery += "  and decode(BA1_INFANS,'0','Não','Sim') = 'Não' " + CRLF
   cquery += "  and DECODE(TRIM(BA1_CODCCO),'', 'Sem CCo','Com CCo') = 'Sem CCo' " + CRLF
EndIf     
*/
cquery += " GROUP BY " + CRLF
cquery += " decode(BA1_LOCSIB,'0','0-NÃO ENVIADO', " + CRLF   
cquery += "                   '1','1-ATIVO', " + CRLF
cquery += "                   '2','2-EXCLUÍDO'," + CRLF
cquery += "                   '3','3-ENVIADO INCLUSÃO ',   " + CRLF
cquery += "                   '4','4-ENVIADO ALTERAÇÃO',  " + CRLF
cquery += "                   '5','5-ENVIADO EXCLUSÃO ',   " + CRLF
cquery += "                   '6','6-CRIT INC (F/INC) ', " + CRLF
cquery += "                   '7','7-CRIT ALT (F/ALT) ',  " + CRLF
cquery += "                   '8','8-CRIT EXC (F/EXC) ',  " + CRLF
cquery += "                   '9','9-ENV MUD CONTRATUAL', " + CRLF
cquery += "                   'A','A-ENVIADO REATIVAÇÃO', " + CRLF
cquery += "                   'B','B-CRIT MUD CONTRATUAL'," + CRLF
cquery += "                   'C','C-CRIT REATIVAÇÃO',    " + CRLF
cquery += "                   'Outros - Não Previsto') ,  " + CRLF
cquery += " decode(BA1_ATUSIB,'0','Nao','Sim') ,  " + CRLF
cquery += " decode(BA1_INFSIB,'0','Nao','Sim') ,  " + CRLF
cquery += " decode(BA1_INFANS,'0','Nao','Sim') ,  " + CRLF
cquery += " decode(TRIM(BA1_CODCCO),'', 'Sem CCo','Com CCo') , " + CRLF 
cquery += " decode(nvl(sib_situac,' '),'1', 'Ativo' , '3','Bloqueado', 'Sem ANS') " + CRLF
cquery += " ORDER By 1 " + CRLF


TcQuery cQuery New Alias (cAliasPEG)

(cAliasPEG)->(dbGoTop())

While !(cAliasPEG)->(EOF())                            	
      aAdd(aRetPEG,{.F. ,;
                    trim((cAliasPEG)->DESC_LOCSIB) ,;
					trim((cAliasPEG)->AtuSib)      ,;
					trim((cAliasPEG)->InfSib)      ,;
					trim((cAliasPEG)->InfAns)      ,;
					trim((cAliasPEG)->Codcco)      ,;
					(cAliasPEG)->AN_A        ,;
					(cAliasPEG)->AN_B        ,;
					(cAliasPEG)->AN_T        ,;
					(cAliasPEG)->AT_A        ,;
					(cAliasPEG)->AT_B        ,;
					(cAliasPEG)->AT_T        ,;
					(cAliasPEG)->AP_A        ,;
					(cAliasPEG)->AP_B        ,;
					(cAliasPEG)->AP_T        ,; 
					(cAliasPEG)->tot_blq_mes ,;
					(cAliasPEG)->TOTAL_GERAL ,;
					(cAliasPEG)->status_ans  })

	(cAliasPEG)->(DbSkip())
	
EndDo

(cAliasPEG)->(DbCloseArea())

If empty(aRetPEG)
	aAdd(aRetPEG,{.T.,'','','','','','','','','','','','','','','',''})
EndIf

Return aRetPEG

/********************************************/
/********************************************/


/********************************************/

**********************************************************************************
Static Function marca() // cRef == 1 peg , 2 , proc

local nI

For nI := 1 to len(aBrwPEG)
	
	
	aBrwPEG[nI,1]:= .T.
	

Next

RETURN()


static Function desmarca1()

local nI


For nI := 1 to len(aBrwPEG)
	
	aBrwPEG[nI,1]:= .F.
	
Next


RETURN()


***************************************************************************************/
Static Function VerifMarc( )

local nI


For nI := 1 to len(aBrwPEG)

//	If  (Trim(aBrwPEG[nI,4])!= 'AJUSTAR BASE' .AND. Trim(aBrwPEG[nI,4])!= 'ENVIAR BLOQUEIO') .or. aBrwPEG[nI,5] == 0 

/*	If  (substr(aBrwPEG[nI,3],1,5) $ '0.1 -|0.2 -|1.1 -|2.1 -|2.2 -') .and. aBrwPEG[nI,5] > 0 
	
        A:= 'B'
    Else    		
		aBrwPEG[nI,1]:= .F.
		
	EndIf
*/	
Next



Return()
*********************************************************************************

Static Function AjustaSX1(cPerg)

Local aHelpPor := {}
                     
aHelp := {}
aAdd(aHelp, "Informe a Data da Ultima Entrege do SIB mensal "+ CRLF)
PutSX1(cPerg,"01" , "Data de Entrega Sib"                         ,"","","mv_ch1","D",08,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

//PutSx1(cPerg,"01",OemToAnsi("Data de Entrega Sib ") 		      ,"","","mv_ch1","D",08,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","","",{},{})
aHelp := {}
aAdd(aHelp, "Informe a Data de inclusao inicial  "+ CRLF)
aAdd(aHelp, "Para considerar TODAS as matriculas "+ CRLF)
aAdd(aHelp, " Informe 01/01/01                   ") 
PutSX1(cPerg,"02" , "Data inclusão Inical "      ,"","","mv_ch2","D",08,0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

//PutSx1(cPerg,"02",OemToAnsi("Data    Incial      ") 		      ,"","","mv_ch2","D",08,0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","","",{},{})
aHelp := {}
aAdd(aHelp, "Informe a Data de inclusão final "+ CRLF) 
PutSX1(cPerg,"03" , "Data inclusão Final"      ,"","","mv_ch3","D",08,0,0,"G","","","","","mv_par03","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)
//PutSx1(cPerg,"03",OemToAnsi("Data    Final       ") 		      ,"","","mv_ch3","D",08,0,0,"G","","","","","mv_par03","","","","","","","","","","","","","","","","","",{},{})

Pergunte(cPerg,.F.)

Return

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

_cMensagem +=  Chr(13) + Chr(10) + Chr(13) + Chr(10) + " Assunto : "+cAssunto 
_cMensagem +=  Chr(13) + Chr(10) + Chr(13) + Chr(10) + "Prezados,"

_cMensagem +=  Chr(13) + Chr(10) + Chr(13) + Chr(10) + "Foi executado os acertos na base do SIB da Empresa "+cEmpresa
_cMensagem +=  Chr(13) + Chr(10) + Chr(13) + Chr(10) + "Arquivo planilha como as matricula que sofream a ação em anexo "

	//destinatario cristina
	cDest+= "altamiro@caberj.com.br ;"  

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
Local _cAssunto    := " Sib Global "
Local _cError      := ""
Local _lOk         := .T.
Local _lSendOk     := .F.
local cto_         := ' '

//_cTo+= cDest

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
return()

static function fazTriag()  

Local cAliasBA1	:= GetNextAlias()
Local cquery1 := ""
local nI

For nI := 1 to len(aBrwPEG)
	
	If  aBrwPEG[nI,1] == .T.     

		cquery1 := "SELECT ba1_codint ||'.'|| ba1_codemp ||'.'|| ba1_matric ||'.'|| ba1_tipreg ||'-'|| ba1_digito  matricula , " + CRLF
		cquery1 += " nvl(trim(ba1_nomusr),' ') nomusr , " + CRLF
		cquery1 += " nvl(TRIM(BA1_CODCCO),' ') Codcco , " + CRLF  
		cquery1 += " nvl(trim(BA1_DATINC),' ') DATINC , " + CRLF
		cquery1 += " nvl(trim(BA1_DATBLO),' ') DATBLO   " + CRLF

		If cempant == '01'                                                                                        
           cquery1 += "  FROM BA1010 BA1 , Confsib_Cab " + CRLF                                                        
		Else 
           cquery1 += "  FROM BA1020 BA1 , Confsib_Int " + CRLF                                                        
		EndIf 

		cquery1 += " WHERE BA1_FILIAL = ' ' AND D_e_l_e_t_ = ' ' " + CRLF
		
		If cempant == '01'                                                                                        
   		   cquery1 += "   AND BA1_CODEMP NOT IN ('0004','0009') " + CRLF
		EndIf    

		cquery1 += "   AND BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG||BA1_DIGITO = SIB_MATRIC(+) " + CRLF  
		
		If dtos(mv_par02) != '20010101' 
           cquery1 += "   AND (BA1_DATINC BETWEEN '"+dtos(mv_par02)+"'  AND '"+dtos(mv_par03)+"') " + CRLF
        EndIf      
                                                            
		cquery1 += "  and  Ba1_locsib = '"+substr(aBrwPEG[nI,2],1,1) +"' " + CRLF
		cquery1 += "  and decode(BA1_ATUSIB,'0','Nao','Sim') = '"+trim(aBrwPEG[nI,3]) +"' " + CRLF
		cquery1 += "  and decode(BA1_INFSIB,'0','Nao','Sim') = '"+trim(aBrwPEG[nI,4]) +"' " + CRLF	
		cquery1 += "  and decode(BA1_INFANS,'0','Nao','Sim') = '"+trim(aBrwPEG[nI,5]) +"' " + CRLF
		cquery1 += "  and DECODE(TRIM(BA1_CODCCO),'', 'Sem CCo','Com CCo') = '"+trim(aBrwPEG[nI,6]) +"' " + CRLF                                                                                          

		cquery1 += "  and decode(nvl(sib_situac,' '),'1', 'Ativo' , '3','Bloqueado', 'Sem ANS')  = '"+trim(aBrwPEG[nI,18]) +"' " + CRLF   
                                                                                     
  /*	   
     	If !lFztot 
   			cquery1 += "  and  Ba1_locsib = '2'
   			cquery1 += "  and decode(BA1_ATUSIB,'0','Não','Sim') = 'Não' " + CRLF
   			cquery1 += "  and decode(BA1_INFSIB,'0','Não','Sim') = 'Não' " + CRLF
   			cquery1 += "  and decode(BA1_INFANS,'0','Não','Sim') = 'Não' " + CRLF
   			cquery1 += "  and DECODE(TRIM(BA1_CODCCO),'', 'Sem CCo','Com CCo') = 'Sem CCo' " + CRLF
		EndIf     
  */
		cquery1 += " GROUP BY " + CRLF
		cquery1 += " ba1_codint ||'.'|| ba1_codemp ||'.'|| ba1_matric ||'.'|| ba1_tipreg ||'-'|| ba1_digito ," + CRLF
		cquery1 += " ba1_nomusr  , " + CRLF
		cquery1 += " TRIM(BA1_CODCCO)  , " + CRLF  
		cquery1 += " BA1_DATINC ," + CRLF
		cquery1 += " BA1_DATBLO " + CRLF
        cquery1 += " ORDER By 1 " + CRLF

 
        TcQuery cQuery1 New Alias (cAliasBA1)

       (cAliasBA1)->(dbGoTop())
	
While !(cAliasBA1)->(EOF())                            	
      aAdd(aDadDet,{(cAliasBA1)->matricula ,;  
					(cAliasBA1)->nomusr      ,;
					(cAliasBA1)->Codcco      ,;
					(cAliasBA1)->DATINC      ,;
					(cAliasBA1)->DATBLO })
	(cAliasBA1)->(DbSkip())
	
EndDo
   
//   If Len(aDadDet) > 0
      geraExcel(2,nI)
//   EndIF  

    (cAliasBA1)->(DbCloseArea()) 
   	 cAliasBA1 := GetNextAlias()       
   	 aDadDet   := {}
                                                                                                                          
EndIf
	
Next  
                           
 //	(cAliasBA1)->(DbCloseArea()) 

Return()

/////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////
/*
static Function faz01cab()

Local cquery	:= ""
Local cAliasBA1	:= GetNextAlias()
local i

ProcRegua(0)

nCont := 0

for i:=1 to 5
	IncProc('Buscando Dados no Servidor ...')
next

cquery := " SELECT 'CABERJ' EMPRESA, '0.1 - MATRÍCULA VINCULADA A CCO DIFERENTE DA BASE' TIPO, 'AJUSTAR BASE' AJUSTE ,  " + CRLF
cquery += "        sib_codcco sibcco , BA1_CODCCO BA1CCO , ba1_datblo ba1datblo , ba1010.r_E_C_N_O_ recba1  , ba1_motblo ba1motblo , " + CRLF
cquery += "        BA1_CODINT || BA1_CODEMP || BA1_MATRIC || BA1_TIPREG || BA1_DIGITO mat_caberj , SIB_MATRIC mat_sib , " + CRLF
cquery += "        ba1_nomusr ba1nomusr , sib_nomusr sibnomusr , ba1_cpfusr ba1cpfusr , sib_cpfusr sibcpfusr , ba1_datinc ba1datinc , " + CRLF 

cquery += "        BA1_INFANS INFANS, BA1_INFSIB INFSIB , BA1_ATUSIB ATUSIB ," + CRLF  
cquery += "        decode(BA1_LOCSIB,'1','1-ATIVO'," + CRLF 
cquery += "                          '2','2-EXCLUÍDO'," + CRLF
cquery += "          				 '3','3-ENVIADO INCLUSÃO'," + CRLF
cquery += "                          '4','4-ENVIADO ALTERAÇÃO'," + CRLF
cquery += "                          '5','5-ENVIADO EXCLUSÃO'," + CRLF
cquery += "                          '6','6-CRITICADO INCLUSÃO (FORÇAR INCLUSÃO)'," + CRLF
cquery += "                          '7','7-CRITICADO ALTERAÇÃO (FORÇAR ALTERAÇÃO)'," + CRLF
cquery += "                          '8','8-CRITICADO EXCLUSÃO (FORÇAR EXCLUSÃO)'," + CRLF
cquery += "                          '9','9-ENVIADO MUDANÇA CONTRATUAL'," + CRLF
cquery += "                          'A','A-ENVIADO REATIVAÇÃO'," + CRLF
cquery += "                          'B','B-CRITICADO MUDANÇA CONTRATUAL'," + CRLF
cquery += "                          'C','C-CRITICADO REATIVAÇÃO'," + CRLF
cquery += "        	   			     'Outros - Não Previsto') LOCSIB " + CRLF      

cquery += "   FROM CONFSIB_CAB " + CRLF
cquery += "  INNER JOIN BA1010 ON BA1_FILIAL = ' ' " + CRLF
cquery += "    AND BA1_CODINT || BA1_CODEMP || BA1_MATRIC || BA1_TIPREG || BA1_DIGITO = SIB_MATRIC " + CRLF
cquery += "    AND BA1_CODCCO <> SIB_CODCCO " + CRLF
cquery += "    AND SIB_CODCCO <> ' ' " + CRLF
cquery += "    AND D_E_L_E_T_ = ' ' " + CRLF

cquery += "    ORDER BY 1,2 " + CRLF

TcQuery cQuery New Alias (cAliasBA1)

(cAliasBA1)->(dbGoTop())

DbSelectArea("BA1")


While !(cAliasBA1)->(EOF())
	
	If (cAliasBA1)->recba1 > 0 


		If  mv_par02 == 1

    		BA1->(dbGoTo((cAliasBA1)->recba1))
            BA1->(RecLock("BA1",.F.))
    	    BA1->BA1_CODCCO	:=	(cAliasBA1)->sibcco
    		BA1->(MsUnlock())                                           

		EndIf
		aAdd(aDados,{  (cAliasBA1)->TIPO      ,; 
					   (cAliasBA1)->AJUSTE    ,; 
 	                   (cAliasBA1)->sibcco    ,; 
					   (cAliasBA1)->BA1CCO    ,; 
 					   (cAliasBA1)->mat_caberj,; 
					   (cAliasBA1)->mat_sib   ,;
 					   (cAliasBA1)->ba1nomusr ,; 
 					   (cAliasBA1)->sibnomusr ,; 
					   (cAliasBA1)->ba1cpfusr ,; 
					   (cAliasBA1)->sibcpfusr ,; 
					   (cAliasBA1)->ba1datinc ,;  
	    		       (cAliasBA1)->ba1datblo ,; 					   
					   (cAliasBA1)->ba1motblo ,;
					   (cAliasBA1)->INFANS    ,;
					   (cAliasBA1)->INFSIB    ,; 
					   (cAliasBA1)->ATUSIB    ,;  
					   (cAliasBA1)->LOCSIB    ,;
 	                   (cAliasBA1)->recba1    ,;
 	                   ' '  })    
		
	EndIf
	(cAliasBA1)->(DbSkip())
	
EndDo

(cAliasBA1)->(DbCloseArea())

Return() */
////////////////////////////////////////                           
/*static function faz11cab()
Local cquery	:= ""
Local cAliasBA1	:= GetNextAlias()
local i

ProcRegua(0)

nCont := 0

for i:=1 to 5
	IncProc('Buscando Dados no Servidor ...')
next

cquery += " SELECT 'CABERJ' EMPRESA, '1.1 - ATIVOS ANS E BLOQUEADOS ATÉ "+cdata+" '  TIPO , 'ENVIAR BLOQUEIO' AJUSTE, " + CRLF
cquery += "        sib_codcco sibcco , BA1_CODCCO BA1CCO , ba1_datblo ba1datblo , BA1.r_E_C_N_O_ recba1  , ba1_motblo ba1motblo , " + CRLF
cquery += "        BA1_CODINT || BA1_CODEMP || BA1_MATRIC || BA1_TIPREG || BA1_DIGITO mat_caberj , SIB_MATRIC mat_sib , " + CRLF
cquery += "        ba1_nomusr ba1nomusr , sib_nomusr sibnomusr , ba1_cpfusr ba1cpfusr , sib_cpfusr sibcpfusr , ba1_datinc ba1datinc ," + CRLF     
cquery += "        BA1_INFANS INFANS, BA1_INFSIB INFSIB , BA1_ATUSIB ATUSIB ," + CRLF  
cquery += "        decode(BA1_LOCSIB,'1','1-ATIVO'," + CRLF 
cquery += "                          '2','2-EXCLUÍDO'," + CRLF
cquery += "          				 '3','3-ENVIADO INCLUSÃO'," + CRLF
cquery += "                          '4','4-ENVIADO ALTERAÇÃO'," + CRLF
cquery += "                          '5','5-ENVIADO EXCLUSÃO'," + CRLF
cquery += "                          '6','6-CRITICADO INCLUSÃO (FORÇAR INCLUSÃO)'," + CRLF
cquery += "                          '7','7-CRITICADO ALTERAÇÃO (FORÇAR ALTERAÇÃO)'," + CRLF
cquery += "                          '8','8-CRITICADO EXCLUSÃO (FORÇAR EXCLUSÃO)'," + CRLF
cquery += "                          '9','9-ENVIADO MUDANÇA CONTRATUAL'," + CRLF
cquery += "                          'A','A-ENVIADO REATIVAÇÃO'," + CRLF
cquery += "                          'B','B-CRITICADO MUDANÇA CONTRATUAL'," + CRLF
cquery += "                          'C','C-CRITICADO REATIVAÇÃO'," + CRLF
cquery += "        	   			     'Outros - Não Previsto') LOCSIB , " + CRLF      

cquery += "'UPDATE BA1010 SET BA1_LOCSIB = ''' || BA1_LOCSIB || ''', BA1_INFANS = ''' || BA1_INFANS || ''',BA1_INFSIB = ''' || BA1_INFSIB || ''' , BA1_ATUSIB = ''' || BA1_ATUSIB || '''WHERE R_E_C_N_O_ = ' || BA1.R_E_C_N_O_ || ';' DESFAZ    " + CRLF 

cquery += "   FROM CONFSIB_CAB " + CRLF
cquery += "  INNER JOIN BA1010 ba1 ON BA1_FILIAL = ' ' " + CRLF
cquery += "    AND BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG||BA1_DIGITO = SIB_MATRIC " + CRLF
cquery += "    AND BA1_DATBLO <> ' ' " + CRLF
cquery += "    AND BA1_DATBLO <= '"+cDtEntr+"' " + CRLF
cquery += "    AND BA1_DATINC <= '"+cDtEntr+"' " + CRLF
cquery += "    AND D_E_L_E_T_ = ' ' " + CRLF 
cquery += "    AND BA1_CODEMP NOT IN ('0004','0009') " + CRLF                      
cquery += "    AND BA1_MOTBLO not in( '485','509','067') " + CRLF 
cquery += "    AND SIGA.BLOQUEIO_ANS_SIB( 'CABERJ', SIB_MATRIC, '"+cDtEntr+"' ) = 'S' " + CRLF
cquery += "  WHERE SIB_SITUAC = '1' " + CRLF

cquery += "    ORDER BY 1,2 " + CRLF

TcQuery cQuery New Alias (cAliasBA1)

(cAliasBA1)->(dbGoTop())

DbSelectArea("BA1")


While !(cAliasBA1)->(EOF())
	
	If (cAliasBA1)->recba1 > 0 
		                 
	   If  mv_par02 == 1
	       
	       BA1->(dbGoTo((cAliasBA1)->recba1))
           BA1->(RecLock("BA1",.F.))
   	       BA1->BA1_LOCSIB	:= '8'      
           BA1->BA1_ATUSIB := '1'  
     //      BA1->BA1_INFANS := '1'
           BA1->BA1_INFSIB := '1'  
	       BA1->(MsUnlock())                                           

       EndIf 	
		aAdd(aDados,{  (cAliasBA1)->TIPO      ,; 
					   (cAliasBA1)->AJUSTE    ,; 
 	                   (cAliasBA1)->sibcco    ,; 
					   (cAliasBA1)->BA1CCO    ,; 
 					   (cAliasBA1)->mat_caberj,; 
					   (cAliasBA1)->mat_sib   ,;
 					   (cAliasBA1)->ba1nomusr ,; 
 					   (cAliasBA1)->sibnomusr ,; 
					   (cAliasBA1)->ba1cpfusr ,; 
					   (cAliasBA1)->sibcpfusr ,; 
					   (cAliasBA1)->ba1datinc ,;  
	    		       (cAliasBA1)->ba1datblo ,; 					   
					   (cAliasBA1)->ba1motblo ,;    
					   (cAliasBA1)->INFANS    ,;
					   (cAliasBA1)->INFSIB    ,; 
					   (cAliasBA1)->ATUSIB    ,;  
					   (cAliasBA1)->LOCSIB    ,;
 	                   (cAliasBA1)->recba1    ,;
 	                   (cAliasBA1)->DESFAZ })    
		
	EndIf
	(cAliasBA1)->(DbSkip())
	
EndDo

(cAliasBA1)->(DbCloseArea())

Return()        


static function faz21CAB()
Local cquery	:= ""
Local cAliasBA1	:= GetNextAlias()
local i

ProcRegua(0)

nCont := 0

for i:=1 to 5
	IncProc('Buscando Dados no Servidor ...')
next

cquery += " SELECT 'CABERJ' EMPRESA, '2.1 - ATIVOS OU BLOQUEADOS APÓS "+cdata+" NÃO EXISTEM ANS' TIPO, 'SE NÃO ESTIVEREM COMO ENVIADO INCLUSÃO, ENVIAR A INCLUSÃO' AJUSTE , " + CRLF
cquery += "        'nao se aplica' sibcco , BA1_CODCCO BA1CCO , ba1_datblo ba1datblo , ba1.r_E_C_N_O_ recba1  , ba1_motblo ba1motblo , " + CRLF
cquery += "        BA1_CODINT || BA1_CODEMP || BA1_MATRIC || BA1_TIPREG || BA1_DIGITO mat_caberj , 'nao se aplica' mat_sib , " + CRLF
cquery += "        ba1_nomusr ba1nomusr , 'nao se aplica' sibnomusr , ba1_cpfusr ba1cpfusr , 'nao se aplica' sibcpfusr , ba1_datinc ba1datinc ," + CRLF     
cquery += "        BA1_INFANS INFANS, BA1_INFSIB INFSIB , BA1_ATUSIB ATUSIB ," + CRLF  
cquery += "        decode(BA1_LOCSIB,'1','1-ATIVO'," + CRLF 
cquery += "                          '2','2-EXCLUÍDO'," + CRLF
cquery += "          				 '3','3-ENVIADO INCLUSÃO'," + CRLF
cquery += "                          '4','4-ENVIADO ALTERAÇÃO'," + CRLF
cquery += "                          '5','5-ENVIADO EXCLUSÃO'," + CRLF
cquery += "                          '6','6-CRITICADO INCLUSÃO (FORÇAR INCLUSÃO)'," + CRLF
cquery += "                          '7','7-CRITICADO ALTERAÇÃO (FORÇAR ALTERAÇÃO)'," + CRLF
cquery += "                          '8','8-CRITICADO EXCLUSÃO (FORÇAR EXCLUSÃO)'," + CRLF
cquery += "                          '9','9-ENVIADO MUDANÇA CONTRATUAL'," + CRLF
cquery += "                          'A','A-ENVIADO REATIVAÇÃO'," + CRLF
cquery += "                          'B','B-CRITICADO MUDANÇA CONTRATUAL'," + CRLF
cquery += "                          'C','C-CRITICADO REATIVAÇÃO'," + CRLF
cquery += "        	   			     'Outros - Não Previsto') LOCSIB , " + CRLF 

cquery += "'UPDATE BA1010 SET BA1_LOCSIB = ''' || BA1_LOCSIB || ''', BA1_INFANS = ''' || BA1_INFANS || ''',BA1_INFSIB = ''' || BA1_INFSIB || ''' , BA1_ATUSIB = ''' || BA1_ATUSIB || '''WHERE R_E_C_N_O_ = ' || BA1.R_E_C_N_O_ || ';' DESFAZ    " + CRLF 

cquery += "   FROM BA1010 ba1 " + CRLF
cquery += "  WHERE BA1_FILIAL = ' ' " + CRLF
cquery += "    AND ( BA1_DATBLO = ' ' OR BA1_DATBLO > '"+cDtEntr+"' ) " + CRLF
cquery += "    AND BA1_DATINC <= '"+cDtEntr+"' " + CRLF
cquery += "    AND D_E_L_E_T_ = ' '  " + CRLF   
cquery += "    AND BA1_CODEMP NOT IN ('0004','0009') " + CRLF
cquery += "    AND NOT EXISTS " + CRLF
cquery += "      ( " + CRLF
cquery += " SELECT 1 " + CRLF
cquery += "   FROM CONFSIB_CAB " + CRLF
cquery += "  WHERE SIB_MATRIC = BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG||BA1_DIGITO " + CRLF
cquery += "      ) " + CRLF


TcQuery cQuery New Alias (cAliasBA1)

(cAliasBA1)->(dbGoTop())

DbSelectArea("BA1")


While !(cAliasBA1)->(EOF())
	
	If (cAliasBA1)->recba1 > 0 
		

	   If  mv_par02 == 1

//		forçar (6 - forçar inclusão, 7 - forçar alteração; 8 - forçar exclusão) 
           
           BA1->(dbGoTo((cAliasBA1)->recba1))    
           BA1->(RecLock("BA1",.F.))
           BA1->BA1_LOCSIB	:= '6'      
           BA1->BA1_ATUSIB   := '1'  
         //  BA1->BA1_INFANS   := '1'
           BA1->BA1_INFSIB   := '1'   
	       BA1->(MsUnlock())                                           
       EndIf
         		
		aAdd(aDados,{  (cAliasBA1)->TIPO      ,; 
					   (cAliasBA1)->AJUSTE    ,; 
 	                   (cAliasBA1)->sibcco    ,; 
					   (cAliasBA1)->BA1CCO    ,; 
 					   (cAliasBA1)->mat_caberj,; 
					   (cAliasBA1)->mat_sib   ,;
 					   (cAliasBA1)->ba1nomusr ,; 
 					   (cAliasBA1)->sibnomusr ,; 
					   (cAliasBA1)->ba1cpfusr ,; 
					   (cAliasBA1)->sibcpfusr ,; 
					   (cAliasBA1)->ba1datinc ,;  
	    		       (cAliasBA1)->ba1datblo ,; 					   
					   (cAliasBA1)->ba1motblo ,;    
					   (cAliasBA1)->INFANS    ,;
					   (cAliasBA1)->INFSIB    ,; 
					   (cAliasBA1)->ATUSIB    ,;  
					   (cAliasBA1)->LOCSIB    ,;
 	                   (cAliasBA1)->recba1    ,;
 	                   (cAliasBA1)->DESFAZ    })    
		
	EndIf
	(cAliasBA1)->(DbSkip())
	
EndDo

(cAliasBA1)->(DbCloseArea())

Return()


/////////
static  function faz22CAB()
Local cquery	:= ""
Local cAliasBA1	:= GetNextAlias()
local i

ProcRegua(0)

nCont := 0

for i:=1 to 5
	IncProc('Buscando Dados no Servidor ...')
next

cquery += " SELECT 'CABERJ' EMPRESA, '2.2 - ATIVOS QUE EXISTEM COMO INATIVOS NA ANS' TIPO, 'ENVIAR REATIVAÇÃO' AJUSTE, " + CRLF
cquery += "        sib_codcco sibcco , BA1_CODCCO BA1CCO , ba1_datblo ba1datblo , ba1.r_E_C_N_O_ recba1  , ba1_motblo ba1motblo , " + CRLF
cquery += "        BA1_CODINT || BA1_CODEMP || BA1_MATRIC || BA1_TIPREG || BA1_DIGITO mat_caberj , SIB_MATRIC mat_sib , " + CRLF
cquery += "        ba1_nomusr ba1nomusr , sib_nomusr sibnomusr , ba1_cpfusr ba1cpfusr , sib_cpfusr sibcpfusr , ba1_datinc ba1datinc ," + CRLF     
cquery += "        BA1_INFANS INFANS, BA1_INFSIB INFSIB , BA1_ATUSIB ATUSIB ," + CRLF  
cquery += "        decode(BA1_LOCSIB,'1','1-ATIVO'," + CRLF 
cquery += "                          '2','2-EXCLUÍDO'," + CRLF
cquery += "          				 '3','3-ENVIADO INCLUSÃO'," + CRLF
cquery += "                          '4','4-ENVIADO ALTERAÇÃO'," + CRLF
cquery += "                          '5','5-ENVIADO EXCLUSÃO'," + CRLF
cquery += "                          '6','6-CRITICADO INCLUSÃO (FORÇAR INCLUSÃO)'," + CRLF
cquery += "                          '7','7-CRITICADO ALTERAÇÃO (FORÇAR ALTERAÇÃO)'," + CRLF
cquery += "                          '8','8-CRITICADO EXCLUSÃO (FORÇAR EXCLUSÃO)'," + CRLF
cquery += "                          '9','9-ENVIADO MUDANÇA CONTRATUAL'," + CRLF
cquery += "                          'A','A-ENVIADO REATIVAÇÃO'," + CRLF
cquery += "                          'B','B-CRITICADO MUDANÇA CONTRATUAL'," + CRLF
cquery += "                          'C','C-CRITICADO REATIVAÇÃO'," + CRLF
cquery += "        	   			     'Outros - Não Previsto') LOCSIB , " + CRLF 

cquery += "'UPDATE BA1010 SET BA1_LOCSIB = ''' || BA1_LOCSIB || ''', BA1_INFANS = ''' || BA1_INFANS || ''',BA1_INFSIB = ''' || BA1_INFSIB || ''' , BA1_ATUSIB = ''' || BA1_ATUSIB || '''WHERE R_E_C_N_O_ = ' || BA1.R_E_C_N_O_ || ';' DESFAZ    " + CRLF 

cquery += "   FROM BA1010 ba1 " + CRLF
cquery += "  INNER JOIN CONFSIB_CAB ON SIB_MATRIC = BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG||BA1_DIGITO " + CRLF
cquery += "    AND SIB_SITUAC <> '1' " + CRLF
cquery += "  WHERE BA1_FILIAL = ' ' " + CRLF
cquery += "    AND BA1_DATBLO = ' ' " + CRLF
cquery += "    AND D_E_L_E_T_ = ' ' " + CRLF 
cquery += "    AND BA1_CODEMP NOT IN ('0004','0009') " + CRLF

TcQuery cQuery New Alias (cAliasBA1)

(cAliasBA1)->(dbGoTop())

DbSelectArea("BA1")


While !(cAliasBA1)->(EOF())
	
	If (cAliasBA1)->recba1 > 0 

       If  mv_par02 == 1

//		forçar (6 - forçar inclusão, 7 - forçar alteração; 8 - forçar exclusão) 		

           BA1->(dbGoTo((cAliasBA1)->recba1))    		
           BA1->(RecLock("BA1",.F.))
           BA1->BA1_LOCSIB   := 'A'      
           BA1->BA1_ATUSIB   := '1'  
           BA1->BA1_INFANS   := '1'
           BA1->BA1_INFSIB   := '1'   
	       BA1->(MsUnlock())                                           
 		   
       EndIf 
       
		aAdd(aDados,{  (cAliasBA1)->TIPO      ,; 
					   (cAliasBA1)->AJUSTE    ,; 
 	                   (cAliasBA1)->sibcco    ,; 
					   (cAliasBA1)->BA1CCO    ,; 
 					   (cAliasBA1)->mat_caberj,; 
					   (cAliasBA1)->mat_sib   ,;
 					   (cAliasBA1)->ba1nomusr ,; 
 					   (cAliasBA1)->sibnomusr ,; 
					   (cAliasBA1)->ba1cpfusr ,; 
					   (cAliasBA1)->sibcpfusr ,; 
					   (cAliasBA1)->ba1datinc ,;  
	    		       (cAliasBA1)->ba1datblo ,; 					   
					   (cAliasBA1)->ba1motblo ,;    
					   (cAliasBA1)->INFANS    ,;
					   (cAliasBA1)->INFSIB    ,; 
					   (cAliasBA1)->ATUSIB    ,;  
					   (cAliasBA1)->LOCSIB    ,;
 	                   (cAliasBA1)->recba1    ,;
 	                   (cAliasBA1)->DESFAZ    })    
		
	EndIf
	(cAliasBA1)->(DbSkip())
	
EndDo

(cAliasBA1)->(DbCloseArea())

Return()


/////////////////////////////////////////////////////////////////
static Function faz01int()


Local cquery	:= ""
Local cAliasBA1	:= GetNextAlias()
local i

ProcRegua(0)

nCont := 0

for i:=1 to 5
	IncProc('Buscando Dados no Servidor ...')
next

cquery := " SELECT 'INTEGRAL' EMPRESA, '0.1 - MATRÍCULA VINCULADA A CCO DIFERENTE DA BASE' TIPO, 'AJUSTAR BASE' AJUSTE ,  " + CRLF
cquery += "        sib_codcco sibcco , BA1_CODCCO BA1CCO , ba1_datblo ba1datblo , ba1.r_E_C_N_O_ recba1  , ba1_motblo ba1motblo , " + CRLF
cquery += "        BA1_CODINT || BA1_CODEMP || BA1_MATRIC || BA1_TIPREG || BA1_DIGITO mat_caberj , SIB_MATRIC mat_sib , " + CRLF
cquery += "        ba1_nomusr ba1nomusr , sib_nomusr sibnomusr , ba1_cpfusr ba1cpfusr , sib_cpfusr sibcpfusr , ba1_datinc ba1datinc , " + CRLF

cquery += "        BA1_INFANS INFANS, BA1_INFSIB INFSIB , BA1_ATUSIB ATUSIB ," + CRLF  
cquery += "        decode(BA1_LOCSIB,'1','1-ATIVO'," + CRLF 
cquery += "                          '2','2-EXCLUÍDO'," + CRLF
cquery += "          				 '3','3-ENVIADO INCLUSÃO'," + CRLF
cquery += "                          '4','4-ENVIADO ALTERAÇÃO'," + CRLF
cquery += "                          '5','5-ENVIADO EXCLUSÃO'," + CRLF
cquery += "                          '6','6-CRITICADO INCLUSÃO (FORÇAR INCLUSÃO)'," + CRLF
cquery += "                          '7','7-CRITICADO ALTERAÇÃO (FORÇAR ALTERAÇÃO)'," + CRLF
cquery += "                          '8','8-CRITICADO EXCLUSÃO (FORÇAR EXCLUSÃO)'," + CRLF
cquery += "                          '9','9-ENVIADO MUDANÇA CONTRATUAL'," + CRLF
cquery += "                          'A','A-ENVIADO REATIVAÇÃO'," + CRLF
cquery += "                          'B','B-CRITICADO MUDANÇA CONTRATUAL'," + CRLF
cquery += "                          'C','C-CRITICADO REATIVAÇÃO'," + CRLF
cquery += "        	   			     'Outros - Não Previsto') LOCSIB " + CRLF      

cquery += "   FROM CONFSIB_INT " + CRLF
cquery += "  INNER JOIN BA1020 BA1 ON BA1_FILIAL = ' ' " + CRLF
cquery += "    AND BA1_CODINT || BA1_CODEMP || BA1_MATRIC || BA1_TIPREG || BA1_DIGITO = SIB_MATRIC " + CRLF
cquery += "    AND BA1_CODCCO <> SIB_CODCCO " + CRLF
cquery += "    AND SIB_CODCCO <> ' ' " + CRLF
cquery += "    AND D_E_L_E_T_ = ' ' " + CRLF

//cquery += "    and BA1_CODINT || BA1_CODEMP || BA1_MATRIC || BA1_TIPREG || BA1_DIGITO in ('00010222000788013','00010260000118010','00010258000061017','00010258000061025','00010010001574002')"

cquery += "    ORDER BY 1,2 " + CRLF

TcQuery cQuery New Alias (cAliasBA1)

(cAliasBA1)->(dbGoTop())
  

DbSelectArea("BA1")
 
While !(cAliasBA1)->(EOF())
	
	If (cAliasBA1)->recba1 > 0
		
       If  mv_par02 == 1

   		   BA1->(dbGoTo((cAliasBA1)->recba1))
  	       BA1->(RecLock("BA1",.F.))
  	       BA1->BA1_CODCCO	:=	(cAliasBA1)->sibcco
  	       BA1->(MsUnlock())                 
  	       
       EndIf 

		aAdd(aDados,{ (cAliasBA1)->TIPO       ,; 
					   (cAliasBA1)->AJUSTE    ,; 
 	                   (cAliasBA1)->sibcco    ,; 
					   (cAliasBA1)->BA1CCO    ,; 
 					   (cAliasBA1)->mat_caberj,; 
					   (cAliasBA1)->mat_sib   ,;
 					   (cAliasBA1)->ba1nomusr ,; 
 					   (cAliasBA1)->sibnomusr ,; 
					   (cAliasBA1)->ba1cpfusr ,; 
					   (cAliasBA1)->sibcpfusr ,; 
					   (cAliasBA1)->ba1datinc ,;  
	    		       (cAliasBA1)->ba1datblo ,; 					   
					   (cAliasBA1)->ba1motblo ,;
					   (cAliasBA1)->INFANS    ,;
					   (cAliasBA1)->INFSIB    ,; 
					   (cAliasBA1)->ATUSIB    ,;  
					   (cAliasBA1)->LOCSIB    ,;
 	                   (cAliasBA1)->recba1    ,;
 	                   ' ' })    
				
	EndIf
	
	(cAliasBA1)->(DbSkip())
	
EndDo

(cAliasBA1)->(DbCloseArea())

Return()
//////////////////////////////////////////////////////
static  function faz11int()
Local cquery	:= ""
Local cAliasBA1	:= GetNextAlias()
local i

ProcRegua(0)

nCont := 0

for i:=1 to 5
	IncProc('Buscando Dados no Servidor ...')
next

cquery += " SELECT 'INTEGRAL' EMPRESA, '1.1 - ATIVOS ANS E BLOQUEADOS ATÉ "+cdata+" '  TIPO , 'ENVIAR BLOQUEIO' AJUSTE, " + CRLF
cquery += "        sib_codcco sibcco , BA1_CODCCO BA1CCO , ba1_datblo ba1datblo , ba1.r_E_C_N_O_ recba1  , ba1_motblo ba1motblo , " + CRLF
cquery += "        BA1_CODINT || BA1_CODEMP || BA1_MATRIC || BA1_TIPREG || BA1_DIGITO mat_caberj , SIB_MATRIC mat_sib , " + CRLF
cquery += "        ba1_nomusr ba1nomusr , sib_nomusr sibnomusr , ba1_cpfusr ba1cpfusr , sib_cpfusr sibcpfusr , ba1_datinc ba1datinc ," + CRLF     
cquery += "        BA1_INFANS INFANS, BA1_INFSIB INFSIB , BA1_ATUSIB ATUSIB ," + CRLF  
cquery += "        decode(BA1_LOCSIB,'1','1-ATIVO'," + CRLF 
cquery += "                          '2','2-EXCLUÍDO'," + CRLF
cquery += "          				 '3','3-ENVIADO INCLUSÃO'," + CRLF
cquery += "                          '4','4-ENVIADO ALTERAÇÃO'," + CRLF
cquery += "                          '5','5-ENVIADO EXCLUSÃO'," + CRLF
cquery += "                          '6','6-CRITICADO INCLUSÃO (FORÇAR INCLUSÃO)'," + CRLF
cquery += "                          '7','7-CRITICADO ALTERAÇÃO (FORÇAR ALTERAÇÃO)'," + CRLF
cquery += "                          '8','8-CRITICADO EXCLUSÃO (FORÇAR EXCLUSÃO)'," + CRLF
cquery += "                          '9','9-ENVIADO MUDANÇA CONTRATUAL'," + CRLF
cquery += "                          'A','A-ENVIADO REATIVAÇÃO'," + CRLF
cquery += "                          'B','B-CRITICADO MUDANÇA CONTRATUAL'," + CRLF
cquery += "                          'C','C-CRITICADO REATIVAÇÃO'," + CRLF
cquery += "        	   			     'Outros - Não Previsto') LOCSIB , " + CRLF 

cquery += "'UPDATE BA1020 SET BA1_LOCSIB = ''' || BA1_LOCSIB || ''', BA1_INFANS = ''' || BA1_INFANS || ''',BA1_INFSIB = ''' || BA1_INFSIB || ''' , BA1_ATUSIB = ''' || BA1_ATUSIB || '''WHERE R_E_C_N_O_ = ' || BA1.R_E_C_N_O_ || ';' DESFAZ    " + CRLF 

cquery += "   FROM CONFSIB_INT " + CRLF
cquery += "  INNER JOIN BA1020 BA1 ON BA1_FILIAL = ' ' " + CRLF
cquery += "    AND BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG||BA1_DIGITO = SIB_MATRIC " + CRLF
cquery += "    AND BA1_DATBLO <> ' ' " + CRLF
cquery += "    AND BA1_DATBLO <= '"+cDtEntr+"' " + CRLF
cquery += "    AND BA1_DATINC <= '"+cDtEntr+"' " + CRLF     
cquery += "    AND BA1_MOTBLO <> '765' " + CRLF 
cquery += "    AND D_E_L_E_T_ = ' ' " + CRLF
cquery += "    AND SIGA.BLOQUEIO_ANS_SIB( 'INTEGRAL', SIB_MATRIC, '"+cDtEntr+"' ) = 'S' " + CRLF
cquery += "  WHERE SIB_SITUAC = '1' " + CRLF

cquery += "    ORDER BY 1,2 " + CRLF

TcQuery cQuery New Alias (cAliasBA1)

(cAliasBA1)->(dbGoTop())

DbSelectArea("BA1")


While !(cAliasBA1)->(EOF())
	
	If (cAliasBA1)->recba1 > 0 
		
       If  mv_par02 == 1

//		forçar (6 - forçar inclusão, 7 - forçar alteração; 8 - forçar exclusão) 
       
           BA1->(dbGoTo((cAliasBA1)->recba1))    
           BA1->(RecLock("BA1",.F.))
           BA1->BA1_LOCSIB	:= '8'      
           
	       BA1->(MsUnlock())                                           
       
       EndIf 		
       
		aAdd(aDados,{  (cAliasBA1)->TIPO      ,; 
					   (cAliasBA1)->AJUSTE    ,; 
 	                   (cAliasBA1)->sibcco    ,; 
					   (cAliasBA1)->BA1CCO    ,; 
 					   (cAliasBA1)->mat_caberj,; 
					   (cAliasBA1)->mat_sib   ,;
 					   (cAliasBA1)->ba1nomusr ,; 
 					   (cAliasBA1)->sibnomusr ,; 
					   (cAliasBA1)->ba1cpfusr ,; 
					   (cAliasBA1)->sibcpfusr ,; 
					   (cAliasBA1)->ba1datinc ,;  
	    		       (cAliasBA1)->ba1datblo ,; 					   
					   (cAliasBA1)->ba1motblo ,;    
					   (cAliasBA1)->INFANS    ,;
					   (cAliasBA1)->INFSIB    ,; 
					   (cAliasBA1)->ATUSIB    ,;  
					   (cAliasBA1)->LOCSIB    ,;
 	                   (cAliasBA1)->recba1    ,;
 	                   (cAliasBA1)->DESFAZ    })    
		
	EndIf
	(cAliasBA1)->(DbSkip())
	
EndDo

(cAliasBA1)->(DbCloseArea())

Return()

static  function faz21int()
Local cquery	:= ""
Local cAliasBA1	:= GetNextAlias()
local i

ProcRegua(0)

nCont := 0

for i:=1 to 5
	IncProc('Buscando Dados no Servidor ...')
next

cquery := " SELECT 'INTEGRAL' EMPRESA, '2.1 - ATIVOS OU BLOQUEADOS APÓS "+cdata+" NÃO EXISTEM ANS' TIPO, 'SE NÃO ESTIVEREM COMO ENVIADO INCLUSÃO, ENVIAR A INCLUSÃO' AJUSTE , " + CRLF
cquery += "        'nao se aplica' sibcco , BA1_CODCCO BA1CCO , ba1_datblo ba1datblo , ba1.r_E_C_N_O_ recba1  , ba1_motblo ba1motblo , " + CRLF
cquery += "        BA1_CODINT || BA1_CODEMP || BA1_MATRIC || BA1_TIPREG || BA1_DIGITO mat_caberj , 'nao se aplica' mat_sib , " + CRLF
cquery += "        ba1_nomusr ba1nomusr , 'nao se aplica' sibnomusr , ba1_cpfusr ba1cpfusr , 'nao se aplica' sibcpfusr , ba1_datinc ba1datinc ," + CRLF     
cquery += "        BA1_INFANS INFANS, BA1_INFSIB INFSIB , BA1_ATUSIB ATUSIB ," + CRLF  
cquery += "        decode(BA1_LOCSIB,'1','1-ATIVO'," + CRLF 
cquery += "                          '2','2-EXCLUÍDO'," + CRLF
cquery += "          				 '3','3-ENVIADO INCLUSÃO'," + CRLF
cquery += "                          '4','4-ENVIADO ALTERAÇÃO'," + CRLF
cquery += "                          '5','5-ENVIADO EXCLUSÃO'," + CRLF
cquery += "                          '6','6-CRITICADO INCLUSÃO (FORÇAR INCLUSÃO)'," + CRLF
cquery += "                          '7','7-CRITICADO ALTERAÇÃO (FORÇAR ALTERAÇÃO)'," + CRLF
cquery += "                          '8','8-CRITICADO EXCLUSÃO (FORÇAR EXCLUSÃO)'," + CRLF
cquery += "                          '9','9-ENVIADO MUDANÇA CONTRATUAL'," + CRLF
cquery += "                          'A','A-ENVIADO REATIVAÇÃO'," + CRLF
cquery += "                          'B','B-CRITICADO MUDANÇA CONTRATUAL'," + CRLF
cquery += "                          'C','C-CRITICADO REATIVAÇÃO'," + CRLF
cquery += "        	   			     'Outros - Não Previsto') LOCSIB , " + CRLF 

cquery += "'UPDATE BA1020 SET BA1_LOCSIB = ''' || BA1_LOCSIB || ''', BA1_INFANS = ''' || BA1_INFANS || ''',BA1_INFSIB = ''' || BA1_INFSIB || ''' , BA1_ATUSIB = ''' || BA1_ATUSIB || '''WHERE R_E_C_N_O_ = ' || BA1.R_E_C_N_O_ || ';' DESFAZ    " + CRLF 

cquery += "   FROM BA1020 BA1 " + CRLF
cquery += "  WHERE BA1_FILIAL = ' ' " + CRLF
cquery += "    AND ( BA1_DATBLO = ' ' OR BA1_DATBLO > '"+cDtEntr+"' ) " + CRLF
cquery += "    AND BA1_DATINC <= '"+cDtEntr+"' " + CRLF
cquery += "    AND D_E_L_E_T_ = ' ' " + CRLF
cquery += "    AND NOT EXISTS " + CRLF
cquery += "      ( " + CRLF
cquery += " SELECT 1 " + CRLF
cquery += "   FROM CONFSIB_INT " + CRLF
cquery += "  WHERE SIB_MATRIC = BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG||BA1_DIGITO " + CRLF
cquery += "      ) " + CRLF


TcQuery cQuery New Alias (cAliasBA1)

(cAliasBA1)->(dbGoTop())

DbSelectArea("BA1")


While !(cAliasBA1)->(EOF())
	
	If (cAliasBA1)->recba1 > 0 
		
		If  mv_par02 == 1

//		forçar (6 - forçar inclusão, 7 - forçar alteração; 8 - forçar exclusão) 
            BA1->(dbGoTo((cAliasBA1)->recba1))    
            BA1->(RecLock("BA1",.F.))
            BA1->BA1_LOCSIB	:= '6'      
            BA1->BA1_ATUSIB   := '1'  
       //     BA1->BA1_INFANS   := '1'
            BA1->BA1_INFSIB   := '1'   
	        BA1->(MsUnlock())                                           

 		EndIf 
 		
		aAdd(aDados,{  (cAliasBA1)->TIPO      ,; 
					   (cAliasBA1)->AJUSTE    ,; 
 	                   (cAliasBA1)->sibcco    ,; 
					   (cAliasBA1)->BA1CCO    ,; 
 					   (cAliasBA1)->mat_caberj,; 
					   (cAliasBA1)->mat_sib   ,;
 					   (cAliasBA1)->ba1nomusr ,; 
 					   (cAliasBA1)->sibnomusr ,; 
					   (cAliasBA1)->ba1cpfusr ,; 
					   (cAliasBA1)->sibcpfusr ,; 
					   (cAliasBA1)->ba1datinc ,;  
	    		       (cAliasBA1)->ba1datblo ,; 					   
					   (cAliasBA1)->ba1motblo ,;    
					   (cAliasBA1)->INFANS    ,;
					   (cAliasBA1)->INFSIB    ,; 
					   (cAliasBA1)->ATUSIB    ,;  
					   (cAliasBA1)->LOCSIB    ,;
 	                   (cAliasBA1)->recba1    ,;
 	                   (cAliasBA1)->DESFAZ    })    
		
	EndIf
	(cAliasBA1)->(DbSkip())
	
EndDo

(cAliasBA1)->(DbCloseArea())

Return()


/////////
static function faz22int()
Local cquery	:= ""
Local cAliasBA1	:= GetNextAlias()
local i

ProcRegua(0)

nCont := 0

for i:=1 to 5
	IncProc('Buscando Dados no Servidor ...')
next

cquery += " SELECT 'INTEGRAL' EMPRESA, '2.2 - ATIVOS QUE EXISTEM COMO INATIVOS NA ANS' TIPO, 'ENVIAR REATIVAÇÃO' AJUSTE, " + CRLF
cquery += "        sib_codcco sibcco , BA1_CODCCO BA1CCO , ba1_datblo ba1datblo , ba1.r_E_C_N_O_ recba1  , ba1_motblo ba1motblo , " + CRLF
cquery += "        BA1_CODINT || BA1_CODEMP || BA1_MATRIC || BA1_TIPREG || BA1_DIGITO mat_caberj , SIB_MATRIC mat_sib , " + CRLF
cquery += "        ba1_nomusr ba1nomusr , sib_nomusr sibnomusr , ba1_cpfusr ba1cpfusr , sib_cpfusr sibcpfusr , ba1_datinc ba1datinc ," + CRLF     
cquery += "        BA1_INFANS INFANS, BA1_INFSIB INFSIB , BA1_ATUSIB ATUSIB ," + CRLF  
cquery += "        decode(BA1_LOCSIB,'1','1-ATIVO'," + CRLF 
cquery += "                          '2','2-EXCLUÍDO'," + CRLF
cquery += "          				 '3','3-ENVIADO INCLUSÃO'," + CRLF
cquery += "                          '4','4-ENVIADO ALTERAÇÃO'," + CRLF
cquery += "                          '5','5-ENVIADO EXCLUSÃO'," + CRLF
cquery += "                          '6','6-CRITICADO INCLUSÃO (FORÇAR INCLUSÃO)'," + CRLF
cquery += "                          '7','7-CRITICADO ALTERAÇÃO (FORÇAR ALTERAÇÃO)'," + CRLF
cquery += "                          '8','8-CRITICADO EXCLUSÃO (FORÇAR EXCLUSÃO)'," + CRLF
cquery += "                          '9','9-ENVIADO MUDANÇA CONTRATUAL'," + CRLF
cquery += "                          'A','A-ENVIADO REATIVAÇÃO'," + CRLF
cquery += "                          'B','B-CRITICADO MUDANÇA CONTRATUAL'," + CRLF
cquery += "                          'C','C-CRITICADO REATIVAÇÃO'," + CRLF
cquery += "        	   			     'Outros - Não Previsto') LOCSIB , " + CRLF 

cquery += "'UPDATE BA1020 SET BA1_LOCSIB = ''' || BA1_LOCSIB || ''', BA1_INFANS = ''' || BA1_INFANS || ''',BA1_INFSIB = ''' || BA1_INFSIB || ''' , BA1_ATUSIB = ''' || BA1_ATUSIB || '''WHERE R_E_C_N_O_ = ' || BA1.R_E_C_N_O_ || ';' DESFAZ    " + CRLF 

cquery += "   FROM BA1020 ba1 " + CRLF
cquery += "  INNER JOIN CONFSIB_INT ON SIB_MATRIC = BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG||BA1_DIGITO " + CRLF
cquery += "    AND SIB_SITUAC <> '1' " + CRLF
cquery += "  WHERE BA1_FILIAL = ' ' " + CRLF
cquery += "    AND BA1_DATBLO = ' ' " + CRLF
cquery += "    AND D_E_L_E_T_ = ' ' " + CRLF

TcQuery cQuery New Alias (cAliasBA1)

(cAliasBA1)->(dbGoTop())

DbSelectArea("BA1")


While !(cAliasBA1)->(EOF())
	
	If (cAliasBA1)->recba1 > 0 
		
	   If  mv_par02 == 1

//		forçar (6 - forçar inclusão, 7 - forçar alteração; 8 - forçar exclusão)  	
           BA1->(dbGoTo((cAliasBA1)->recba1))    
           BA1->(RecLock("BA1",.F.))
           BA1->BA1_LOCSIB	:= 'A'      
           BA1->BA1_ATUSIB   := '1'  
       //    BA1->BA1_INFANS   := '1'
           BA1->BA1_INFSIB   := '1'   
	       BA1->(MsUnlock())                                           

 	   EndIf 
 	    	
		aAdd(aDados,{  (cAliasBA1)->TIPO      ,; 
					   (cAliasBA1)->AJUSTE    ,; 
 	                   (cAliasBA1)->sibcco    ,; 
					   (cAliasBA1)->BA1CCO    ,; 
 					   (cAliasBA1)->mat_caberj,; 
					   (cAliasBA1)->mat_sib   ,;
 					   (cAliasBA1)->ba1nomusr ,; 
 					   (cAliasBA1)->sibnomusr ,; 
					   (cAliasBA1)->ba1cpfusr ,; 
					   (cAliasBA1)->sibcpfusr ,; 
					   (cAliasBA1)->ba1datinc ,;  
	    		       (cAliasBA1)->ba1datblo ,; 					   
					   (cAliasBA1)->ba1motblo ,;    
					   (cAliasBA1)->INFANS    ,;
					   (cAliasBA1)->INFSIB    ,; 
					   (cAliasBA1)->ATUSIB    ,;  
					   (cAliasBA1)->LOCSIB    ,;
 	                   (cAliasBA1)->recba1    ,;
 	                   (cAliasBA1)->DESFAZ    })    
		
	EndIf
	(cAliasBA1)->(DbSkip())
	
EndDo

(cAliasBA1)->(DbCloseArea())

Return()



/////////////////////////////////////////////////////////////////   

Static Function FGrvPlan(ind,cEmpresa)           

   cNomDadCab:=  aDados[1,1]
   cAcao     :=  aDados[1,2]
                
 
       //	cNomeArq := "C:\TEMP\"+cEmpresa+'_'+trim(substr(aDados[1,1],1,1))+trim(substr(aDados[1,1],3,1))+"_"+SubStr(DtoS(date()),7,2)+"_"+SubStr(DtoS(date()),5,2)+"_"+SubStr(DtoS(date()),1,4)+"_"+STRTRAN(TIME(),":","_")+".csv" 
        cNomeArq := "\LOG_SIB\"+substr(cEmpresa,1,3)+'_'+trim(substr(aDados[1,1],1,1))+trim(substr(aDados[1,1],3,1))+DtoS(date())+"_"+STRTRAN(TIME(),":","")+".csv"
		nHandle := FCREATE(cNomeArq)
        
        cMontaTxt := 'Empresa  : '+ cEmpresa  
        cMontaTxt += CRLF
        FWrite(nHandle,cMontaTxt)		
        
        cMontaTxt := cNomDadCab
        cMontaTxt += CRLF
        FWrite(nHandle,cMontaTxt)        		 
        
        cMontaTxt := 'Ação  : '+cAcao
        cMontaTxt += CRLF
        FWrite(nHandle,cMontaTxt)		  
        
        cMontaTxt := 'Usuario : '+SubStr(cUSUARIO,7,15)
        cMontaTxt += CRLF
        FWrite(nHandle,cMontaTxt) 
	         

        cMontaTxt := "Cco Ans  ;"  
		cMontaTxt += "Cco Emp  ;"   
		cMontaTxt += "Matricula Emp ;"       
		cMontaTxt += "Matricula Ans ;"     
		cMontaTxt += "Nome Usuar Emp;"     
		cMontaTxt += "Nome Usuar Ans;"  
		cMontaTxt += "Cpf Emp       ;"  
		cMontaTxt += "Cpf Ans       ;"    
		cMontaTxt += "Dt Incl Emp   ;"     
		cMontaTxt += "Dt Bloq Emp   ;"     
		cMontaTxt += "Mot Bloq Emp  ;" 
		cMontaTxt += "INFANS        ;"
        cMontaTxt += "INFSIB        ;" 
		cMontaTxt += "ATUSIB        ;"  
		cMontaTxt += "LOCSIB        ;"
		cMontaTxt += "Recno Emp     ;"      
		cMontaTxt += "DESFAZ        ;"     
		
		cMontaTxt += CRLF // Salto de linha para .csv (excel)
             
		FWrite(nHandle,cMontaTxt)
		
      For nCount:=1 to len(aDados)
		
   		  cMontaTxt := trim(aDados[nCount][03]) + ";"  
   		  cMontaTxt += trim(aDados[nCount][04]) + ";"   
   		  cMontaTxt += trim(aDados[nCount][05]) + ";"   
   		  cMontaTxt += trim(aDados[nCount][06]) + ";"   
   		  cMontaTxt += trim(aDados[nCount][07]) + ";"     		     		   
   		  cMontaTxt += trim(aDados[nCount][08]) + ";"   
   		  cMontaTxt += trim(aDados[nCount][09]) + ";"   
   		  cMontaTxt += trim(aDados[nCount][10]) + ";"   
   		  cMontaTxt += trim(aDados[nCount][11]) + ";"     		     		  
   		  cMontaTxt += trim(aDados[nCount][12]) + ";"   
   		  cMontaTxt += trim(aDados[nCount][13]) + ";" 
   		  cMontaTxt += trim(aDados[nCount][14]) + ";"
   		  cMontaTxt += trim(aDados[nCount][15]) + ";"
   		  cMontaTxt += trim(aDados[nCount][16]) + ";"
   		  cMontaTxt += trim(aDados[nCount][17]) + ";"
   		  cMontaTxt += str(aDados[nCount][18])  + ";"    
   		  cMontaTxt +=     aDados[nCount][19]  + ";" 
    	  cMontaTxt += CRLF // Salto de linha para .csv (excel)      
		      
		  FWrite(nHandle,cMontaTxt)
	
      Next 

	If nHandle > 0
		
		// encerra gravação no arquivo
		FClose(nHandle)
	//	cNomeArq1+= cNomeArq + CRLF
		MsgAlert("Relatorio salvo em: "+cNomeArq)      
	

		fEnvEmail(cNomeArq , cEmpresa , trim(aDados[1,1]) )
	EndIf       
    aDados:={}
Return()	
/////////////////////////////////////////////////////////////////   

*/
static Function geraExcel(orig , ind1 )
	
	If orig == 1 	
		Processa( {|| geraExcel1()  }, "Aguarde...", "Gerando Excel.......",.F.)
	ElseIf 	orig == 2                                                           
	    Processa( {|| geraExcel2(ind1)  }, "Aguarde...", "Gerando Excel.......",.F.)
    EndIf 		
	
Return

Static Function geraExcel1()
	
	Local aArea        	:= GetArea()
	Local cQuery       	:= ""
	Local oFWMsExcel
	Local oExcel
  //	Local cAliasLog	  	:= GetNextAlias()
//	Local cArquivo    	:= GetTempPath()+cvaltochar(randomize(1,100000))+'_sinteticosib.xml'
	Local cArquivo    	:= 'C:\TEMP\sinteticsib'+SubStr(DtoS(date()),7,2)+SubStr(DtoS(date()),5,2)+SubStr(DtoS(date()),1,4)+STRTRAN(TIME(),":","_")+'.xml'  
	
	Local cEmpresa    	:= iIf( cEmpAnt=='01', 'C', 'I')
  //	Local c_Data 	  	:= dtos(mv_par01)
//	Local c_Competencia := mv_par01+mv_par02
	Local nRegs			:= len(aRetPEG)  
	
	If nRegs == 0
	
		Aviso("Não há dados!!!","Não há Log a ser impresso com os parâmetros informados!",{"OK"})
	
	Else 
	
		oFWMsExcel := FWMSExcel():New()
		
		//Aba 01 - Log_Boletos
		oFWMsExcel:AddworkSheet("SIB")
		//Criando a Tabela
		oFWMsExcel:AddTable("SIB","Sib")
		oFWMsExcel:AddColumn("SIB","Sib","Descrição",1)
		oFWMsExcel:AddColumn("SIB","Sib","AtuSib",1)
		oFWMsExcel:AddColumn("SIB","Sib","InfSib",1)
		oFWMsExcel:AddColumn("SIB","Sib","InfAns",1)
		oFWMsExcel:AddColumn("SIB","Sib","Com Cco?",1)
		
		oFWMsExcel:AddColumn("SIB","Sib","Anterior Atv",3)
		oFWMsExcel:AddColumn("SIB","Sib","Anterior Bloq",3)
		oFWMsExcel:AddColumn("SIB","Sib","Anterior Tot",3)     
		
		oFWMsExcel:AddColumn("SIB","Sib","Atual Atv",3)
		oFWMsExcel:AddColumn("SIB","Sib","Atual Bloq",3)
		oFWMsExcel:AddColumn("SIB","Sib","Atual Tot",3)     
		
		oFWMsExcel:AddColumn("SIB","Sib","Posterior Atv",3)
		oFWMsExcel:AddColumn("SIB","Sib","Posterior Bloq",3)
		oFWMsExcel:AddColumn("SIB","Sib","Posterior Tot",3)    

		oFWMsExcel:AddColumn("SIB","Sib","Bloq. Mesmo Mes Tot",3)
		oFWMsExcel:AddColumn("SIB","Sib","Tot Geral",3)
		oFWMsExcel:AddColumn("SIB","Sib","Status Ans",1)
		
		ProcRegua(nRegs) // Atribui quantidade de registros que serão impressos
		
		//Criando as Linhas... Enquanto não for fim da query

        for I = 1 to len(aRetPEG)

			IncProc()                                          
					
			oFWMsExcel:AddRow("SIB","Sib",{;
				  aRetPEG[I,2] ,;
 				  aRetPEG[I,3] ,;
 				  aRetPEG[I,4] ,;
				  aRetPEG[I,5] ,;
 				  aRetPEG[I,6] ,;
				  aRetPEG[I,7] ,;
				  aRetPEG[I,8] ,;
 				  aRetPEG[I,9] ,;
 				  aRetPEG[I,10] ,;
				  aRetPEG[I,11] ,;
 				  aRetPEG[I,12] ,;
				  aRetPEG[I,13] ,;
				  aRetPEG[I,14] ,;
 				  aRetPEG[I,15] ,;  
 				  aRetPEG[I,16] ,; 
 				  aRetPEG[I,17] ,;
 				  aRetPEG[I,18] })
						
		Next 
		
		//Ativando o arquivo e gerando o xml                    
		oFWMsExcel:Activate()
		oFWMsExcel:GetXMLFile(cArquivo)
		
		//Abrindo o excel e abrindo o arquivo xml
		oExcel := MsExcel():New()           //Abre uma nova conexão com Excel
		oExcel:WorkBooks:Open(cArquivo)     //Abre uma planilha
		oExcel:SetVisible(.T.)              //Visualiza a planilha
		oExcel:Destroy()                    //Encerra o processo do gerenciador de tarefas
		
    EndIf 	
    	
	RestArea(aArea)
	
Return

///////////////////////////////////////////

Static Function geraExcel2(ind)
	
	Local aArea        	:= GetArea()
	Local cQuery       	:= ""
	Local oFWMsExcel
	Local oExcel
//	Local cAliasLog	  	:= GetNextAlias()
//	Local cArquivo    	:= GetTempPath()+cvaltochar(randomize(1,100000))+'_analiticosib.xml'   
	Local cArquivo    	:= 'C:\TEMP\analitsib'+SubStr(DtoS(date()),7,2)+SubStr(DtoS(date()),5,2)+SubStr(DtoS(date()),1,4)+STRTRAN(TIME(),":","_")+'.xml'  
	Local cEmpresa    	:= iIf( cEmpAnt=='01', 'C', 'I')
	Local nRegs			:= len(aDadDet)  
	
	If nRegs == 0
	
		Aviso("Não há dados!!!","Não há Log a ser impresso com os parâmetros informados!",{"OK"})
	
	Else 
	
		oFWMsExcel := FWMSExcel():New()
		
		//Aba 01 - Log_Boletos
		oFWMsExcel:AddworkSheet("SIB")
		//Criando a Tabela
		oFWMsExcel:AddTable("SIB","Sib")
		oFWMsExcel:AddColumn("SIB","Sib","Descrição",1)
		oFWMsExcel:AddColumn("SIB","Sib","AtuSib",1)
		oFWMsExcel:AddColumn("SIB","Sib","InfSib",1)
		oFWMsExcel:AddColumn("SIB","Sib","InfAns",1)
		oFWMsExcel:AddColumn("SIB","Sib","Com Cco?",1)
		oFWMsExcel:AddColumn("SIB","Sib","Status Ans",1)
		
		oFWMsExcel:AddColumn("SIB","Sib","Matricula",1)
		oFWMsExcel:AddColumn("SIB","Sib","Usuario",1) 
        oFWMsExcel:AddColumn("SIB","Sib","Codigo do Cco",1) 		
		oFWMsExcel:AddColumn("SIB","Sib","Data Inclusão",1) 
		oFWMsExcel:AddColumn("SIB","Sib","Data Exclusão",1)

		ProcRegua(nRegs) // Atribui quantidade de registros que serão impressos
		
		//Criando as Linhas... Enquanto não for fim da query

        for I = 1 to len(aDadDet)

			IncProc()                                          
					
			oFWMsExcel:AddRow("SIB","Sib",{;
				  aRetPEG[ind,2]  ,;
 				  aRetPEG[ind,3]  ,;
 				  aRetPEG[ind,4]  ,;
				  aRetPEG[ind,5]  ,;
 				  aRetPEG[ind,6]  ,;
				  aRetPEG[ind,18] ,;
				  aDadDet[I,1] ,;
 				  aDadDet[I,2] ,;
				  aDadDet[I,3] ,; 
    		     (aDadDet[I,4]),;				  
				 (aDadDet[I,5]) })
						
		Next 
		
		//Ativando o arquivo e gerando o xml
		oFWMsExcel:Activate()
		oFWMsExcel:GetXMLFile(cArquivo)
		
		//Abrindo o excel e abrindo o arquivo xml
		oExcel := MsExcel():New()           //Abre uma nova conexão com Excel
		oExcel:WorkBooks:Open(cArquivo)     //Abre uma planilha
		oExcel:SetVisible(.T.)              //Visualiza a planilha
 	 //	oExcel:Destroy()                    //Encerra o processo do gerenciador de tarefas
		
    EndIf 	
    	
	RestArea(aArea)
	
Return


// Função que criação as perguntas que estão feitas ao usuário         


