#INCLUDE "PROTHEUS.ch"
#INCLUDE "TOPCONN.ch"
#INCLUDE "PLSMGER.CH"
#Include "Ap5Mail.Ch"
#Include 'Tbiconn.ch'   
#Include "PRTOPDEF.CH"

#Include "rwmake.ch"   
#Include "RPTDEF.CH" 
#Define CRLF Chr(13)+Chr(10)
/*--------------------------------------------------------------------------
| Programa  | CABA131  | Autor | Altamiro	Affonso    | Data | 24/10/2017  |
|---------------------------------------------------------------------------|
| Descricao | Controle de Execusaõ de ajustes do sib global                 |
|           |                                                               |
|---------------------------------------------------------------------------|
| Uso       | Ajustes do sib global- browser de seleção                     |
--------------------------------------------------------------------------*/

User Function CABA131 



local cRda        := ' '
local cNivel      := ' '
local nI := 0


private aBrwPEG   :={}
Private aCabPEG	  := { " ","Empresa" , "Tipo  " , "Ajuste Necessario " ,"Qtda" }
Private aTamPEG	  := { 10 , 35       , 220      ,220                   ,20     }


Private oOk       := LoadBitMap(GetResources(),"LBOK")
Private oNo       := LoadBitMap(GetResources(),"LBNO")


Private aObjects  := {}

Private aSizeAut  := MsAdvSize()

Private cPerg	  := "CABA131"

Private adados    := {}

private cAliasCf  := GetNextAlias()
private cAliasPEG := GetNextAlias()
private cAliasCT  := GetNextAlias()
private cAliasEX  := GetNextAlias()


private cDtEntr   := ' '
Private cdata     := ' '
Private nEmpresa  := ' '   
private lConfirmou:= .T.


AjustaSX1(cPerg)

Pergunte(cPerg,.T.)

cDtEntr    := dtos(mv_par01)
cdata      := substr(cDtEntr,7,2)+'/'+substr(cDtEntr,5,2)+'/'+substr(cDtEntr,1,4)
nEmpresa   := mv_par02



//while !lSai
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

oDlg  		:= MsDialog():New( aSizeAut[7],00,aSizeAut[3]-100,aSizeAut[5]-10,"Ajustes do sib global- browser de seleção ",,,.F.,,,,,,.T.,,,.T. )

oSayPEG    	:= TSay():New( aPosObj[1][1],aPosObj[1][2],{||'Ajustes do sib global- browser de seleção  '},oDlg,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,236,016)

bDbClickPEG	:= {|| aBrwPEG[oBrwPEG:nAt,1] := !aBrwPEG[oBrwPEG:nAt,1] , VerifMarc( )  ,oBrwPEG:Refresh()}

//bChangePEG	:= {||AtuBrwGuia(aBrwPEG[oBrwPEG:nAt,2],aBrwPEG[oBrwPEG:nAt,3])}

//oBrwPEG 	:= TcBrowse():New(aPosObj[1][1]+10,aPosObj[1][2],aPosObj[1][4],aPosObj[1][3],,aCabPEG,aTamPEG,oDlg,,,,bChangePEG,bDbClickPEG,,,,,,,.F.,,.T.,,.F.,,, )

oBrwPEG 	:= TcBrowse():New(aPosObj[1][1]+10,aPosObj[1][2],aPosObj[1][4],aPosObj[1][3],,aCabPEG,aTamPEG,oDlg,,,,,bDbClickPEG,,,,,,,.F.,,.T.,,.F.,,, )

oBrwPEG:SetArray(aBrwPEG)

oBrwPEG:bLine := {||{If( aBrwPEG[oBrwPEG:nAt,1],oOk,oNo) ,;
aBrwPEG[oBrwPEG:nAt,2]		 ,;
aBrwPEG[oBrwPEG:nAt,3]      ,;
aBrwPEG[oBrwPEG:nAt,4]      ,;
Transform(aBrwPEG[oBrwPEG:nAt,5],'@E  999,999') }}


oBrwPEG:nScrollType  := 1 // Scroll VCR

lConfirmou 	:= .T.

aBut    :={{"PENDENTE", {||marca(1),oBrwPEG:Refresh()           }	, "Marcar Todos "       , "Marcar Todos"     } }
aAdd(aBut, {"PENDENTE", {||desmarca(1),oBrwPEG:Refresh()        }	, "DesMarcar Todos "	, "DesMarcar Todos"	 } )
aAdd(aBut, {"PENDENTE", {||u_CABR245(aBrwPEG , cdata ) ,oBrwPEG:Refresh()          }	, "Demostrativo "   	, "Demostrativo"     } )
aAdd(aBut, {"PENDENTE", {||lsai:= .T. , oDlg:End()              }	, "Sair "   	        , "Sair"             } )
//aAdd(aBut, {"PENDENTE", {||fConfexc(1),oBrwPEG:Refresh(),oDlg:End()}	, "Excluir Selecção"   	, "Excluir Selecção" } )
//aAdd(aBut, {"PENDENTE", {||fConfexc(2),oBrwPEG:Refresh(),oDlg:End()}	, "Excl.Tit/Selecao"   	, "Excl.Tit/Selecao" } )

//If lsai

//  exit

//endIf

lConfirmou := .F.

bOk 	:= {||u_fazTriag() , oBrwPEG:Refresh()  ,oDlg:End()   }

bCancel := {||lConfirmou := .F.,oDlg:End()}

  
oDlg:Activate(,,,.T.,,,EnchoiceBar(oDlg,bOk,bCancel,,aBut))


//	MsgInfo("Processo finalizado")

//	MsgAlert(Left(cBuffer,len(cBuffer)-1))


Return

//EndDo


************************************************************************************


Static Function aDadosPEG

Local aRetPEG	:= {}
Local cquery	:= ""
//Local cAliasPEG	:= GetNextAlias()
local i

ProcRegua(0)

nCont := 0

for i:=1 to 5
	IncProc('Buscando Dados no Servidor ...')
next
If cempant == '01'                   

cquery := " SELECT 'CABERJ' EMPRESA, '0.1 - MATRÍCULA VINCULADA A CCO DIFERENTE DA BASE' TIPO, 'AJUSTAR BASE' AJUSTE, COUNT(*) QTD " + CRLF
cquery += "   FROM CONFSIB_CAB " + CRLF
cquery += "  INNER JOIN BA1010 ON BA1_FILIAL = ' ' " + CRLF
cquery += "    AND BA1_CODINT || BA1_CODEMP || BA1_MATRIC || BA1_TIPREG || BA1_DIGITO = SIB_MATRIC " + CRLF
cquery += "    AND ba1_cpfusr = sib_cpfusr " + CRLF
cquery += "    AND BA1_CODCCO <> SIB_CODCCO " + CRLF
cquery += "    AND ba1_CODCCO <> ' ' " + CRLF 

cquery += "    AND BA1_INFANS <> '0' " + CRLF

cquery += "    AND D_E_L_E_T_ = ' ' " + CRLF

cquery += "  UNION " + CRLF

cquery += " SELECT 'CABERJ' EMPRESA, '0.2 - CCO VINCULADA A MATRÍCULA DIFERENTE DA BASE' TIPO, 'AJUSTAR BASE' AJUSTE, COUNT(*) QTD " + CRLF
cquery += "   FROM CONFSIB_CAB " + CRLF
cquery += "  INNER JOIN BA1010 ON BA1_FILIAL = ' ' " + CRLF
cquery += "    AND BA1_CODINT || BA1_CODEMP || BA1_MATRIC || BA1_TIPREG || BA1_DIGITO <> SIB_MATRIC " + CRLF
cquery += "    AND BA1_CODCCO = SIB_CODCCO " + CRLF

cquery += "    AND BA1_INFANS <> '0' " + CRLF

cquery += "    AND ba1_DATBLO <> ' ' " + CRLF   
cquery += "    AND D_E_L_E_T_ = ' ' " + CRLF

cquery += "  UNION " + CRLF

cquery += " SELECT 'CABERJ' EMPRESA, '1 - ATIVOS ANS' TIPO, '-' AJUSTE, COUNT(*) QTD " + CRLF
cquery += "   FROM CONFSIB_CAB " + CRLF
cquery += "  WHERE SIB_SITUAC = '1' " + CRLF
cquery += "  UNION " + CRLF

cquery += " SELECT 'CABERJ' EMPRESA, '1.1 - ATIVOS ANS E BLOQUEADOS ATÉ "+cdata+" '  TIPO , 'ENVIAR BLOQUEIO' AJUSTE, COUNT(*) QTD " + CRLF
cquery += "   FROM CONFSIB_CAB " + CRLF
cquery += "  INNER JOIN BA1010 BA1 ON BA1_FILIAL = ' ' " + CRLF
cquery += "    AND BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG||BA1_DIGITO = SIB_MATRIC " + CRLF
cquery += "    AND BA1_DATBLO <> ' ' " + CRLF
cquery += "    AND BA1_DATBLO <= '"+cDtEntr+"' " + CRLF
cquery += "    AND BA1_DATINC <= '"+cDtEntr+"' " + CRLF
cquery += "    AND D_E_L_E_T_ = ' ' " + CRLF        
cquery += "    AND BA1_CODEMP NOT IN ('0004','0009') " + CRLF 
cquery += "    AND BA1_INFANS <> '0' " + CRLF 
cquery += "    AND BA1_CODCCO <> ' ' " + CRLF 
cquery += "    AND SIGA.BLOQUEIO_ANS_SIB( 'CABERJ', SIB_MATRIC, '"+cDtEntr+"' ) = 'S' " + CRLF
cquery += "  WHERE SIB_SITUAC = '1' " + CRLF      
                                                          
If mv_par03 == 1
	cquery += "  AND (SELECT  COUNT(*) FROM SIGA.PD5010 PD5 "
	cquery += "        WHERE  PD5_FILIAL = ' ' AND PD5.D_e_l_e_t_ = ' ' "
	cquery += "          AND PD5_TPACAO = 'CANC' AND PD5_DATRET > '"+cDtEntr+"'" 
	cquery += "          AND PD5_ENVIAD = 'T'  "
	cquery += "          AND PD5_CRIANS =  ' ' "
	cquery += "          AND BA1_CODCCO = PD5_CODCCO )= 0 "
EndIf 

cquery += "  UNION " + CRLF

cquery += " SELECT 'CABERJ' EMPRESA, '1.1.1 - ATIVOS ANS E BLOQUEADOS ATÉ "+cdata+" SEM TABELA BTS' TIPO, 'AJUSTAR BASE' AJUSTE, COUNT(*) QTD " + CRLF
cquery += "   FROM CONFSIB_CAB " + CRLF
cquery += "  INNER JOIN BA1010 BA1 ON BA1_FILIAL = ' ' " + CRLF
cquery += "    AND BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG||BA1_DIGITO = SIB_MATRIC " + CRLF
cquery += "    AND BA1_DATBLO <> ' ' " + CRLF
cquery += "    AND BA1_DATBLO <= '"+cDtEntr+"' " + CRLF
cquery += "    AND BA1_DATINC <= '"+cDtEntr+"' " + CRLF
cquery += "    AND BA1_INFANS <> '0' " + CRLF
cquery += "    AND D_E_L_E_T_ = ' ' " + CRLF
cquery += "    AND SIGA.BLOQUEIO_ANS_SIB( 'CABERJ', SIB_MATRIC, '"+cDtEntr+"' ) = 'S' " + CRLF
cquery += "    AND NOT EXISTS " + CRLF
cquery += "      ( " + CRLF
cquery += " SELECT 1 " + CRLF
cquery += "   FROM BTS010 BTS " + CRLF
cquery += "  WHERE BTS_FILIAL = ' ' " + CRLF
cquery += "    AND BTS_MATVID = BA1_MATVID" + CRLF
cquery += "    AND BTS.D_E_L_E_T_ = ' ' " + CRLF
cquery += "      ) " + CRLF
cquery += "  WHERE SIB_SITUAC = '1' " + CRLF

cquery += "  UNION " + CRLF

cquery += " SELECT 'CABERJ' EMPRESA, '1.2 - ATIVOS ANS E ATIVOS NA BASE OU BLOQUEADOS APÓS "+cdata+"'  TIPO, '-' AJUSTE, COUNT(*) QTD " + CRLF
cquery += "   FROM CONFSIB_CAB " + CRLF
cquery += "  INNER JOIN BA1010 BA1 ON BA1_FILIAL = ' ' " + CRLF
cquery += "    AND BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG||BA1_DIGITO = SIB_MATRIC " + CRLF
cquery += "    AND ( BA1_DATBLO = ' ' OR BA1_DATBLO > '"+cDtEntr+"' ) " + CRLF
cquery += "    AND BA1_DATINC <= '"+cDtEntr+"' " + CRLF
cquery += "    AND D_E_L_E_T_ = ' ' " + CRLF 
cquery += "    AND BA1_INFANS <> '0' " + CRLF
cquery += "  WHERE SIB_SITUAC = '1' " + CRLF
cquery += "  UNION " + CRLF

cquery += " SELECT 'CABERJ' EMPRESA, '1.3 - ATIVOS NA ANS QUE NÃO EXISTEM NA BASE' TIPO, 'FABRICAR  BLOQUEIO' AJUSTE, COUNT(*) QTD " + CRLF
cquery += "   FROM CONFSIB_CAB " + CRLF
cquery += "  WHERE SIB_SITUAC = '1' " + CRLF
cquery += "    AND NOT EXISTS " + CRLF
cquery += "      ( " + CRLF
cquery += " SELECT 1 " + CRLF
cquery += "   FROM BA1010 BA1 " + CRLF
cquery += "  WHERE BA1_FILIAL = ' ' " + CRLF
cquery += "    AND BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG||BA1_DIGITO = SIB_MATRIC " + CRLF
cquery += "    AND D_E_L_E_T_ = ' ' " + CRLF 
//cquery += "    AND BA1_INFANS <> '0' " + CRLF
cquery += "      ) " + CRLF

cquery += "  UNION " + CRLF

cquery += " SELECT 'CABERJ' EMPRESA, '2 - ATIVOS NA BASE OU BLOQUEADOS APÓS "+cdata+" ' TIPO, '-' AJUSTE, COUNT(*) QTD " + CRLF
cquery += "   FROM BA1010 " + CRLF
cquery += "  WHERE BA1_FILIAL = ' ' " + CRLF
cquery += "    AND ( BA1_DATBLO = ' ' OR BA1_DATBLO > '"+cDtEntr+"' ) " + CRLF
cquery += "    AND BA1_DATINC <= '"+cDtEntr+"' " + CRLF
cquery += "    AND BA1_CODEMP NOT IN ('0004','0009') " + CRLF
cquery += "    AND BA1_INFANS <> '0' " + CRLF
cquery += "    AND D_E_L_E_T_ = ' '  " + CRLF

cquery += "  UNION " + CRLF

cquery += " SELECT 'CABERJ' EMPRESA, '2.1 - ATIVOS OU BLOQUEADOS APÓS "+cdata+" NÃO EXISTEM ANS' TIPO, 'SE NÃO ESTIVEREM COMO ENVIADO INCLUSÃO, ENVIAR A INCLUSÃO' AJUSTE, COUNT(*) QTD " + CRLF
cquery += "   FROM BA1010 " + CRLF
cquery += "  WHERE BA1_FILIAL = ' ' " + CRLF
cquery += "    AND ( BA1_DATBLO = ' ' OR BA1_DATBLO > '"+cDtEntr+"' ) " + CRLF
cquery += "    AND BA1_DATINC <= '"+cDtEntr+"' " + CRLF
cquery += "    AND BA1_INFANS <> '0' " + CRLF
cquery += "    AND BA1_CODEMP NOT IN ('0004','0009') " + CRLF
cquery += "    AND D_E_L_E_T_ = ' ' " + CRLF  
cquery += "    AND BA1_CODCCO = ' ' " + CRLF
cquery += "    AND NOT EXISTS " + CRLF
cquery += "      ( " + CRLF
cquery += " SELECT 1 " + CRLF
cquery += "   FROM CONFSIB_CAB " + CRLF
cquery += "  WHERE SIB_MATRIC = BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG||BA1_DIGITO " + CRLF
cquery += "      ) " + CRLF  
If mv_par03 == 1
	cquery += "  AND (SELECT  COUNT(*) FROM SIGA.PD5010 PD5 "
	cquery += "        WHERE  PD5_FILIAL = ' ' AND PD5.D_e_l_e_t_ = ' ' "
	cquery += "          AND PD5_TPACAO = 'INCL' AND PD5_DATRET > '"+cDtEntr+"'" 
	cquery += "          AND PD5_ENVIAD = 'T'  "
	cquery += "          AND PD5_CRIANS =  ' ' "
	cquery += "          AND BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG||BA1_DIGITO = PD5_MATRIC )= 0 "
EndIf 
cquery += "  UNION " + CRLF

cquery += " SELECT 'CABERJ' EMPRESA, '2.2 - ATIVOS QUE EXISTEM COMO INATIVOS NA ANS' TIPO, 'ENVIAR REATIVAÇÃO' AJUSTE, COUNT(*) QTD " + CRLF
cquery += "   FROM BA1010 " + CRLF
cquery += "  INNER JOIN CONFSIB_CAB ON SIB_MATRIC = BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG||BA1_DIGITO " + CRLF
cquery += "    AND SIB_SITUAC <> '1' " + CRLF
cquery += "  WHERE BA1_FILIAL = ' '  " + CRLF
cquery += "    AND BA1_DATBLO = ' '  " + CRLF
cquery += "    AND BA1_CODEMP NOT IN ('0004','0009') " + CRLF
cquery += "    AND BA1_INFANS <> '0' " + CRLF
cquery += "    AND D_E_L_E_T_ = ' ' " + CRLF                                                           
If mv_par03 == 1
	cquery += "    AND (SELECT  COUNT(*) "
	cquery += "           FROM SIGA.PD5010 PD5 "
	cquery += "          WHERE  PD5_FILIAL = ' ' AND PD5.D_e_l_e_t_ = ' ' "
	cquery += "            AND PD5_TPACAO = 'REAT' AND PD5_DATRET > '"+cDtEntr+"'" 
	cquery += "            AND PD5_ENVIAD = 'T' "
	cquery += "            AND PD5_CRIANS =  ' ' "
	cquery += "            AND BA1_CODCCO = PD5_CODCCO )= 0  "
EndIf 
cquery += "  UNION " + CRLF

cquery += " SELECT 'CABERJ' EMPRESA, '3.1 - ATIVOS OU BLOQUEADOS APÓS "+cdata+" SEM FAMÍLIA QUE EXISTEM ANS' TIPO, '-' AJUSTE, COUNT(*) QTD " + CRLF
cquery += "   FROM BA1010 " + CRLF
cquery += "  INNER JOIN CONFSIB_CAB ON SIB_MATRIC = BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG||BA1_DIGITO " + CRLF
cquery += "  WHERE BA1_FILIAL = ' '  " + CRLF
cquery += "    AND ( BA1_DATBLO = ' ' OR BA1_DATBLO > '"+cDtEntr+"' ) " + CRLF
cquery += "    AND BA1_DATINC <= '"+cDtEntr+"' " + CRLF
cquery += "    AND D_E_L_E_T_ = ' ' " + CRLF 
cquery += "    AND BA1_INFANS <> '0' " + CRLF
cquery += "    AND NOT EXISTS " + CRLF
cquery += "      ( " + CRLF
cquery += " SELECT 1 " + CRLF
cquery += "   FROM BA3010 BA3 " + CRLF
cquery += "  WHERE BA3_FILIAL = ' '" + CRLF
cquery += "    AND BA3_CODINT = BA1_CODINT " + CRLF
cquery += "    AND BA3_CODEMP = BA1_CODEMP " + CRLF
cquery += "    AND BA3_MATRIC = BA1_MATRIC " + CRLF
cquery += "    AND BA3.D_E_L_E_T_ = ' '    " + CRLF
cquery += "      ) " + CRLF


EndIf

If cempant == '02' 

cquery := " SELECT 'INTEGRAL' EMPRESA, '0.1 - MATRÍCULA VINCULADA A CCO DIFERENTE DA BASE' TIPO, 'AJUSTAR BASE' AJUSTE, COUNT(*) QTD " + CRLF
cquery += "   FROM CONFSIB_INT " + CRLF
cquery += "  INNER JOIN BA1020 ON BA1_FILIAL = ' ' " + CRLF
cquery += "    AND BA1_CODINT || BA1_CODEMP || BA1_MATRIC || BA1_TIPREG || BA1_DIGITO = SIB_MATRIC " + CRLF
cquery += "    AND ba1_cpfusr = sib_cpfusr " + CRLF
cquery += "    AND BA1_CODCCO <> SIB_CODCCO " + CRLF
cquery += "    AND BA1_CODCCO <> ' ' " + CRLF
cquery += "    AND BA1_INFANS <> '0' " + CRLF
cquery += "    AND D_E_L_E_T_ = ' ' " + CRLF

cquery += "  UNION " + CRLF

cquery += " SELECT 'INTEGRAL' EMPRESA, '0.2 - CCO VINCULADA A MATRÍCULA DIFERENTE DA BASE' TIPO, 'AJUSTAR BASE' AJUSTE, COUNT(*) QTD " + CRLF
cquery += "   FROM CONFSIB_CAB " + CRLF
cquery += "  INNER JOIN BA1020 ON BA1_FILIAL = ' ' " + CRLF
cquery += "    AND BA1_CODINT || BA1_CODEMP || BA1_MATRIC || BA1_TIPREG || BA1_DIGITO <> SIB_MATRIC " + CRLF
cquery += "    AND BA1_CODCCO = SIB_CODCCO " + CRLF
cquery += "    AND SIB_CODCCO <> ' ' " + CRLF   
cquery += "    AND ba1_DATBLO <> ' ' " + CRLF   
cquery += "    AND D_E_L_E_T_ = ' '  " + CRLF
cquery += "    AND BA1_INFANS <> '0' " + CRLF

cquery += "  UNION " + CRLF

cquery += " SELECT 'INTEGRAL' EMPRESA, '1 - ATIVOS ANS' TIPO, '-' AJUSTE, COUNT(*) QTD " + CRLF
cquery += "   FROM CONFSIB_INT " + CRLF
cquery += "  WHERE SIB_SITUAC = '1' " + CRLF

cquery += "  UNION " + CRLF

cquery += " SELECT 'INTEGRAL' EMPRESA, '1.1 - ATIVOS ANS E BLOQUEADOS ATÉ "+cdata+" ' TIPO, 'ENVIAR BLOQUEIO' AJUSTE, COUNT(*) QTD " + CRLF
cquery += "   FROM CONFSIB_INT " + CRLF
cquery += "  INNER JOIN BA1020 BA1 ON BA1_FILIAL = ' ' " + CRLF
cquery += "    AND BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG||BA1_DIGITO = SIB_MATRIC " + CRLF
cquery += "    AND BA1_DATBLO <> ' '  " + CRLF
cquery += "    AND BA1_DATBLO <= '"+cDtEntr+"' " + CRLF
cquery += "    AND BA1_DATINC <= '"+cDtEntr+"' " + CRLF 
cquery += "    AND BA1_INFANS <> '0' " + CRLF             
cquery += "    AND BA1_CODCCO <> ' ' " + CRLF 
cquery += "    AND D_E_L_E_T_ = ' ' " + CRLF
cquery += "    AND SIGA.BLOQUEIO_ANS_SIB( 'INTEGRAL', SIB_MATRIC, '"+cDtEntr+"' ) = 'S' " + CRLF
cquery += "  WHERE SIB_SITUAC = '1' " + CRLF                                       
If mv_par03 == 1
	cquery += "  AND (SELECT COUNT(*) FROM SIGA.PD5020 PD5 "
	cquery += "        WHERE PD5_FILIAL = ' ' AND PD5.D_e_l_e_t_ = ' ' "
	cquery += "          AND PD5_TPACAO = 'CANC' AND PD5_DATRET > '"+cDtEntr+"'" 
	cquery += "          AND PD5_ENVIAD = 'T'  "
	cquery += "          AND PD5_CRIANS =  ' ' "
	cquery += "          AND BA1_CODCCO = PD5_CODCCO )= 0 "
EndIf 

cquery += "  AND (SELECT  COUNT(*) FROM SIGA.PD5020 PD5 "
cquery += "        WHERE  PD5_FILIAL = ' ' AND PD5.D_e_l_e_t_ = ' ' "
cquery += "          AND PD5_TPACAO = 'CANC' AND PD5_DATRET > '"+cDtEntr+"'" 
cquery += "          AND PD5_ENVIAD = 'T'  "
cquery += "          AND PD5_CRIANS =  ' ' "
cquery += "          AND BA1_CODCCO = PD5_CODCCO )= 0 "

cquery += "  UNION " + CRLF

cquery += " SELECT 'INTEGRAL' EMPRESA, '1.1.1 - ATIVOS ANS E BLOQUEADOS ATÉ "+cdata+" SEM TABELA BTS' TIPO, 'AJUSTAR BASE' AJUSTE, COUNT(*) QTD " + CRLF
cquery += "   FROM CONFSIB_CAB " + CRLF
cquery += "  INNER JOIN BA1020 BA1 ON BA1_FILIAL = ' ' " + CRLF
cquery += "    AND BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG||BA1_DIGITO = SIB_MATRIC " + CRLF
cquery += "    AND BA1_DATBLO <> ' ' " + CRLF
cquery += "    AND BA1_DATBLO <= '"+cDtEntr+"' " + CRLF
cquery += "    AND BA1_DATINC <= '"+cDtEntr+"' " + CRLF
cquery += "    AND D_E_L_E_T_ = ' ' " + CRLF  
cquery += "    AND BA1_INFANS <> '0' " + CRLF
cquery += "    AND SIGA.BLOQUEIO_ANS_SIB( 'INTEGRAL', SIB_MATRIC, '"+cDtEntr+"' ) = 'S' " + CRLF
cquery += "    AND NOT EXISTS " + CRLF
cquery += "      ( " + CRLF
cquery += " SELECT 1 " + CRLF
cquery += "   FROM BTS020 BTS " + CRLF
cquery += "  WHERE BTS_FILIAL = ' '  " + CRLF
cquery += "    AND BTS_MATVID = BA1_MATVID " + CRLF
cquery += "    AND BTS.D_E_L_E_T_ = ' ' " + CRLF
cquery += "    AND BA1_INFANS <> '0' " + CRLF
cquery += "      ) " + CRLF
cquery += "  WHERE SIB_SITUAC = '1' " + CRLF

cquery += "  UNION " + CRLF

cquery += " SELECT 'INTEGRAL' EMPRESA, '1.2 - ATIVOS ANS E ATIVOS NA BASE OU BLOQUEADOS APÓS "+cdata+" ' TIPO, '-' AJUSTE, COUNT(*) QTD " + CRLF
cquery += "   FROM CONFSIB_INT " + CRLF
cquery += "  INNER JOIN BA1020 BA1 ON BA1_FILIAL = ' ' " + CRLF
cquery += "    AND BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG||BA1_DIGITO = SIB_MATRIC " + CRLF
cquery += "    AND ( BA1_DATBLO = ' ' OR BA1_DATBLO > '"+cDtEntr+"' ) " + CRLF
cquery += "    AND BA1_DATINC <= '"+cDtEntr+"' " + CRLF
cquery += "    AND D_E_L_E_T_ = ' ' " + CRLF 
cquery += "    AND BA1_INFANS <> '0' " + CRLF
cquery += "  WHERE SIB_SITUAC = '1' " + CRLF

cquery += "  UNION " + CRLF

cquery += " SELECT 'INTEGRAL' EMPRESA, '1.3 - ATIVOS NA ANS QUE NÃO EXISTEM NA BASE' TIPO, 'FABRICAR BLOQUEIO' AJUSTE, COUNT(*) QTD " + CRLF
cquery += "   FROM CONFSIB_INT " + CRLF
cquery += "  WHERE SIB_SITUAC = '1' " + CRLF
cquery += "    AND NOT EXISTS " + CRLF
cquery += "      ( " + CRLF
cquery += " SELECT 1 " + CRLF
cquery += "   FROM BA1020 BA1 " + CRLF
cquery += "  WHERE BA1_FILIAL = ' ' " + CRLF
cquery += "    AND BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG||BA1_DIGITO = SIB_MATRIC " + CRLF
cquery += "    AND D_E_L_E_T_ = ' ' " + CRLF 
//cquery += "    AND BA1_INFANS <> '0' " + CRLF
cquery += "      ) " + CRLF


cquery += "  UNION " + CRLF

cquery += " SELECT 'INTEGRAL' EMPRESA, '2 - ATIVOS NA BASE OU BLOQUEADOS APÓS "+cdata+" ' TIPO, '-' AJUSTE, COUNT(*) QTD " + CRLF
cquery += "   FROM BA1020 " + CRLF
cquery += "  WHERE BA1_FILIAL = ' ' " + CRLF
cquery += "    AND ( BA1_DATBLO = ' ' OR BA1_DATBLO > '"+cDtEntr+"' ) " + CRLF
cquery += "    AND BA1_DATINC <= '"+cDtEntr+"' " + CRLF
cquery += "    AND D_E_L_E_T_ = ' ' " + CRLF 
cquery += "    AND BA1_INFANS <> '0' " + CRLF

cquery += "  UNION " + CRLF

cquery += " SELECT 'INTEGRAL' EMPRESA, '2.1 - ATIVOS OU BLOQUEADOS APÓS "+cdata+" NÃO EXISTEM ANS' TIPO, 'SE NÃO ESTIVEREM COMO ENVIADO INCLUSÃO, ENVIAR A INCLUSÃO' AJUSTE, COUNT(*) QTD " + CRLF
cquery += "   FROM BA1020" + CRLF
cquery += "  WHERE BA1_FILIAL = ' ' " + CRLF
cquery += "    AND ( BA1_DATBLO = ' ' OR BA1_DATBLO > '"+cDtEntr+"' ) " + CRLF
cquery += "    AND BA1_DATINC <= '"+cDtEntr+"' " + CRLF
cquery += "    AND D_E_L_E_T_ = ' ' " + CRLF
cquery += "    AND BA1_INFANS <> '0' " + CRLF
cquery += "    AND BA1_CODCCO = ' ' " + CRLF
cquery += "    AND NOT EXISTS " + CRLF
cquery += "      ( " + CRLF
cquery += " SELECT 1 " + CRLF
cquery += "   FROM CONFSIB_INT " + CRLF
cquery += "  WHERE SIB_MATRIC = BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG||BA1_DIGITO " + CRLF
cquery += "      ) " + CRLF                            
If mv_par03 == 1
	cquery += "  AND (SELECT  COUNT(*) FROM SIGA.PD5020 PD5 "
	cquery += "        WHERE  PD5_FILIAL = ' ' AND PD5.D_e_l_e_t_ = ' ' "
	cquery += "          AND PD5_TPACAO = 'INCL' AND PD5_DATRET > '"+cDtEntr+"'" 
	cquery += "          AND PD5_ENVIAD = 'T'  "
	cquery += "          AND PD5_CRIANS =  ' ' "
	cquery += "          AND BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG||BA1_DIGITO = PD5_MATRIC )= 0 "
EndIf 
cquery += "  UNION " + CRLF

cquery += " SELECT 'INTEGRAL' EMPRESA, '2.2 - ATIVOS QUE EXISTEM COMO INATIVOS NA ANS' TIPO, 'ENVIAR REATIVAÇÃO' AJUSTE, COUNT(*) QTD " + CRLF
cquery += "   FROM BA1020 " + CRLF
cquery += "  INNER JOIN CONFSIB_INT ON SIB_MATRIC = BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG||BA1_DIGITO " + CRLF
cquery += "    AND SIB_SITUAC <> '1' " + CRLF
cquery += "  WHERE BA1_FILIAL = ' ' " + CRLF
cquery += "    AND BA1_DATBLO = ' ' " + CRLF 
cquery += "    AND BA1_INFANS <> '0' " + CRLF
cquery += "    AND D_E_L_E_T_ = ' ' " + CRLF 
If mv_par03 == 1
	cquery += "  AND (SELECT  COUNT(*) FROM SIGA.PD5020 PD5 "
	cquery += "        WHERE  PD5_FILIAL = ' ' AND PD5.D_e_l_e_t_ = ' ' "
	cquery += "          AND PD5_TPACAO = 'REAT' AND PD5_DATRET > '"+cDtEntr+"'" 
	cquery += "          AND PD5_ENVIAD = 'T'  "
	cquery += "          AND PD5_CRIANS =  ' ' "
	cquery += "          AND BA1_CODCCO = PD5_CODCCO )= 0 "
EndIf 
cquery += "  UNION " + CRLF

cquery += " SELECT 'INTEGRAL' EMPRESA, '3.1 - ATIVOS OU BLOQUEADOS APÓS "+cdata+" SEM FAMÍLIA QUE EXISTEM ANS' TIPO, '-' AJUSTE, COUNT(*) QTD " + CRLF
cquery += "   FROM BA1020 " + CRLF
cquery += "  INNER JOIN CONFSIB_INT ON SIB_MATRIC = BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG||BA1_DIGITO " + CRLF
cquery += "  WHERE BA1_FILIAL = ' '  " + CRLF
cquery += "    AND ( BA1_DATBLO = ' ' OR BA1_DATBLO > '"+cDtEntr+"' ) " + CRLF
cquery += "    AND BA1_DATINC <= '"+cDtEntr+"' " + CRLF
cquery += "    AND BA1_INFANS <> '0' " + CRLF
cquery += "    AND D_E_L_E_T_ = ' ' " + CRLF
cquery += "    AND NOT EXISTS " + CRLF
cquery += "      ( " + CRLF
cquery += " SELECT 1 " + CRLF
cquery += "   FROM BA3020 BA3 " + CRLF
cquery += "  WHERE BA3_FILIAL = ' ' " + CRLF
cquery += "    AND BA3_CODINT = BA1_CODINT " + CRLF
cquery += "    AND BA3_CODEMP = BA1_CODEMP " + CRLF
cquery += "    AND BA3_MATRIC = BA1_MATRIC " + CRLF
cquery += "    AND BA3.D_E_L_E_T_ = ' '    " + CRLF
cquery += "      ) " + CRLF

endIf

cquery += "    ORDER BY 1,2 " + CRLF

//////////////////////////////////////// 

/*
cquery1 := "  SELECT  decode(BA1_LOCSIB,'0','0-NÃO ENVIADO', " + CRLF
cquery1 += "                            '1','1-ATIVO', " + CRLF
cquery1 += "                            '2','2-EXCLUÍDO', " + CRLF
cquery1 += "                            '3','3-ENVIADO INCLUSÃO', " + CRLF
cquery1 += "                            '4','4-ENVIADO ALTERAÇÃO', " + CRLF
cquery1 += "                            '5','5-ENVIADO EXCLUSÃO', " + CRLF
cquery1 += "                            '6','6-CRITICADO INCLUSÃO (FORÇAR INCLUSÃO)', " + CRLF
cquery1 += "                            '7','7-CRITICADO ALTERAÇÃO (FORÇAR ALTERAÇÃO)'," + CRLF
cquery1 += "                            '8','8-CRITICADO EXCLUSÃO (FORÇAR EXCLUSÃO)', " + CRLF
cquery1 += "                            '9','9-ENVIADO MUDANÇA CONTRATUAL', " + CRLF
cquery1 += "                            'A','A-ENVIADO REATIVAÇÃO', " + CRLF
cquery1 += "                            'B','B-CRITICADO MUDANÇA CONTRATUAL', " + CRLF
cquery1 += "                            'C','C-CRITICADO REATIVAÇÃO', " + CRLF
cquery1 += "                            'Outros - Não Previsto') DESC_LOCSIB , " + CRLF   
cquery1 += "          SUM (CASE WHEN  BA1_DATINC < '20180801'  THEN 1 ELSE 0 END )  TOT_ATE_31_07_2018 , " + CRLF 
cquery1 += "          SUM (CASE WHEN ( BA1_DATBLO = ' ' OR BA1_DATBLO >= '20180801' ) AND BA1_DATINC < '20180801'  THEN 1 ELSE 0 END ) ATIVOS_31_07_2018, " + CRLF  
cquery1 += "          SUM (CASE WHEN ( BA1_DATBLO < '20180801' AND  TRIM(BA1_DATBLO) <> ' ' ) AND BA1_DATINC < '20180801'  THEN 1 ELSE 0 END ) BLOQ_ATE_31_07_2018, " + CRLF  
cquery1 += "          SUM (CASE WHEN  BA1_DATINC >= '20180801'  THEN 1 ELSE 0 END )  TOTAL_APOS_31_07_2018 , " + CRLF
cquery1 += "          SUM (CASE WHEN  BA1_DATBLO = ' ' AND BA1_DATINC >= '20180801'  THEN 1 ELSE 0 END ) ATIVOS_31_07_2018 , " + CRLF 
cquery1 += "          SUM (CASE WHEN  BA1_DATBLO >= '20180801'  AND BA1_DATINC >= '20180801'  THEN 1 ELSE 0 END ) BLOQ_APOS_31_07_2018 , " + CRLF
cquery1 += "          decode(nvl(sib_situac,' '),'1', 'Ativo' , '3','Bloqueado', 'Sem ANS') status_ans " + CRLF
cquery1 += "  FROM BA1010 BA1 , confsib_cab " + CRLF
cquery1 += "  WHERE BA1_FILIAL = ' ' AND D_e_l_e_t_ = ' ' " + CRLF
cquery1 += "  AND BA1_CODEMP NOT IN ('0004','0009') " + CRLF
cquery1 += "  AND BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG||BA1_DIGITO = SIB_MATRIC(+)  " + CRLF
cquery1 += " GROUP BY decode(BA1_LOCSIB,'0','0-NÃO ENVIADO', " + CRLF
cquery1 += "                            '1','1-ATIVO', " + CRLF
cquery1 += "                            '2','2-EXCLUÍDO', " + CRLF
cquery1 += "                            '3','3-ENVIADO INCLUSÃO'  , " + CRLF
cquery1 += "                            '4','4-ENVIADO ALTERAÇÃO' , " + CRLF
cquery1 += "                            '5','5-ENVIADO EXCLUSÃO'  , " + CRLF
cquery1 += "                            '6','6-CRITICADO INCLUSÃO (FORÇAR INCLUSÃO)'  ," + CRLF 
cquery1 += "                            '7','7-CRITICADO ALTERAÇÃO (FORÇAR ALTERAÇÃO)'," + CRLF
cquery1 += "                            '8','8-CRITICADO EXCLUSÃO (FORÇAR EXCLUSÃO)'," + CRLF
cquery1 += "                            '9','9-ENVIADO MUDANÇA CONTRATUAL'," + CRLF
cquery1 += "                            'A','A-ENVIADO REATIVAÇÃO'," + CRLF
cquery1 += "                            'B','B-CRITICADO MUDANÇA CONTRATUAL', " + CRLF
cquery1 += "                            'C','C-CRITICADO REATIVAÇÃO'," + CRLF
cquery1 += "                            'Outros - Não Previsto') ," + CRLF
cquery1 += "          decode(nvl(sib_situac,' '),'1', 'Ativo' , '3','Bloqueado', 'Sem ANS') " + CRLF
cquery1 += "  ORDER BY 9,1 " + CRLF
*/
TcQuery cQuery New Alias (cAliasPEG)

(cAliasPEG)->(dbGoTop())

While !(cAliasPEG)->(EOF())
	
	aAdd(aRetPEG,{.F. , (cAliasPEG)->empresa , (cAliasPEG)->tipo  , (cAliasPEG)->ajuste , (cAliasPEG)->qtd})
            	//   1      2    				3					4					5
	(cAliasPEG)->(DbSkip())
	
EndDo

(cAliasPEG)->(DbCloseArea())

If empty(aRetPEG)
	aAdd(aRetPEG,{.T.,'','','',''})
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
	
	If  (substr(aBrwPEG[nI,3],1,5) $ '0.1 -|0.2 -|1.1 -|2.1 -|2.2 -') .and. aBrwPEG[nI,5] > 0 
	
        A:= 'B'
    Else    		
		aBrwPEG[nI,1]:= .F.
		
	EndIf	
Next

RETURN()


Static Function desmarca(cRef) // cRef == 1 peg , 2 , proc

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

	If  (substr(aBrwPEG[nI,3],1,5) $ '0.1 -|0.2 -|1.1 -|2.1 -|2.2 -') .and. aBrwPEG[nI,5] > 0 
	
        A:= 'B'
    Else    		
		aBrwPEG[nI,1]:= .F.
		
	EndIf
	
Next



Return()
*********************************************************************************

Static Function AjustaSX1(cPerg)

Local aHelpPor := {}

PutSx1(cPerg,"01",OemToAnsi("Data de Entrega ") 		      ,"","","mv_ch1","D",08,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","","",{},{})
PutSx1(cPerg,"02",OemToAnsi("Ajustar a Base ? ")              ,"","","mv_ch2","N",01,0,0,"C","","","","","mv_par02","Sim","","","","Não","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"03",OemToAnsi("Consultar Envio ? ")             ,"","","mv_ch3","N",01,0,0,"C","","","","","mv_par03","Sim","","","","Não","","","","","","","","","","","",{},{},{})

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
	cDest+= "esther.melo@caberj.com.br ;"   
	cDest+= "cristiana.silva@caberj.com.br ;"  
 //	cDest+= "marcia.victer@caberj.com.br ;" 
	//destinatario Giordano
	//cDest+= "lucia.souza@caberj.com.br "

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

user function fazTriag()

local nI

For nI := 1 to len(aBrwPEG)
	
	If  aBrwPEG[nI,1] == .T.
		
		If (substr(aBrwPEG[nI,3],1,3)== '0.1'        .and. Trim(aBrwPEG[nI,2])== 'CABERJ'  )
			u_faz01cab()              
			FGrvPlan('0.1','CABERJ')                 
		ElseIf (substr(aBrwPEG[nI,3],1,3)== '0.2'    .and. Trim(aBrwPEG[nI,2])== 'CABERJ' )
		  //	u_faz02cab()            
		  //	FGrvPlan('0.2','CABERJ')
		ElseIf (substr(aBrwPEG[nI,3],1,3)== '1.1'  .and. Trim(aBrwPEG[nI,2])== 'CABERJ')
			u_faz11cab()           
			FGrvPlan('1.1','CABERJ') 
		ElseIf (substr(aBrwPEG[nI,3],1,3)== '2.1'  .and. Trim(aBrwPEG[nI,2])== 'CABERJ')
			u_faz21cab()           
			FGrvPlan('2.1','CABERJ')
		ElseIf (substr(aBrwPEG[nI,3],1,3)== '2.2'  .and. Trim(aBrwPEG[nI,2])== 'CABERJ')
			u_faz22cab()           
			FGrvPlan('2.2','CABERJ')					
		ElseIf (substr(aBrwPEG[nI,3],1,3)== '0.1'    .and. Trim(aBrwPEG[nI,2])== 'INTEGRAL')
			u_faz01int()            
			FGrvPlan('0.1','INTEGRAL')
		ElseIf (substr(aBrwPEG[nI,3],1,3)== '0.2'    .and. Trim(aBrwPEG[nI,2])== 'INTEGRAL')
		  //	u_faz02int()              
		  //	FGrvPlan('0.2','INTEGRAL')			
		ElseIf (substr(aBrwPEG[nI,3],1,3)== '1.1'  .and. Trim(aBrwPEG[nI,2])== 'INTEGRAL')
			u_faz11int()
			FGrvPlan('1.1','INTEGRAL')			 
		ElseIf (substr(aBrwPEG[nI,3],1,3)== '2.1'  .and. Trim(aBrwPEG[nI,2])== 'INTEGRAL')
			u_faz21int()
			FGrvPlan('2.1','INTEGRAL')			
		ElseIf (substr(aBrwPEG[nI,3],1,3)== '2.2'  .and. Trim(aBrwPEG[nI,2])== 'INTEGRAL')
			u_faz22int()
			FGrvPlan('2.2','INTEGRAL')									
		EndIf
		
	EndIf
	
Next



Return()

/////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
user  Function faz01cab()

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
cquery += "    AND ba1_cpfusr = sib_cpfusr " + CRLF
cquery += "    AND BA1_CODCCO <> SIB_CODCCO " + CRLF                       

cquery += "    AND BA1_CODCCO <> ' ' " + CRLF
cquery += "    AND D_E_L_E_T_ = ' ' " + CRLF
cquery += "    AND BA1_INFANS <> '0' " + CRLF

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

Return()
////////////////////////////////////////                           
user function faz11cab()
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
cquery += "    AND BA1_INFANS <> '0' " + CRLF
cquery += "    AND BA1_CODCCO <> ' ' " + CRLF 
cquery += "    AND SIGA.BLOQUEIO_ANS_SIB( 'CABERJ', SIB_MATRIC, '"+cDtEntr+"' ) = 'S' " + CRLF
cquery += "  WHERE SIB_SITUAC = '1' " + CRLF
If mv_par03 == 1
	cquery += "  AND (SELECT  COUNT(*) FROM SIGA.PD5010 PD5 "
	cquery += "        WHERE  PD5_FILIAL = ' ' AND PD5.D_e_l_e_t_ = ' ' "
	cquery += "          AND PD5_TPACAO = 'CANC' AND PD5_DATRET > '"+cDtEntr+"'" 
	cquery += "          AND PD5_ENVIAD = 'T'  "
	cquery += "          AND PD5_CRIANS =  ' ' "
	cquery += "          AND BA1_CODCCO = PD5_CODCCO )= 0 "
EndIf 
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
       //    BA1->BA1_INFANS := '1'
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


user function faz21CAB()
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
cquery += "    AND BA1_INFANS <> '0' " + CRLF  
cquery += "    AND BA1_CODCCO =  ' ' " + CRLF 
cquery += "    AND NOT EXISTS " + CRLF
cquery += "      ( " + CRLF
cquery += " SELECT 1 " + CRLF
cquery += "   FROM CONFSIB_CAB " + CRLF
cquery += "  WHERE SIB_MATRIC = BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG||BA1_DIGITO " + CRLF
cquery += "      ) " + CRLF
If mv_par03 == 1
	cquery += "  AND (SELECT  COUNT(*) FROM SIGA.PD5010 PD5 "
	cquery += "        WHERE  PD5_FILIAL = ' ' AND PD5.D_e_l_e_t_ = ' ' "
	cquery += "          AND PD5_TPACAO = 'INCL' AND PD5_DATRET > '"+cDtEntr+"'" 
	cquery += "          AND PD5_ENVIAD = 'T'  "
	cquery += "          AND PD5_CRIANS =  ' ' "
	cquery += "          AND BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG||BA1_DIGITO = PD5_MATRIC )= 0 "
EndIf 

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
           //BA1->BA1_INFANS   := '1'
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
user function faz22CAB()
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
cquery += "    AND BA1_INFANS <> '0' " + CRLF
cquery += "    AND D_E_L_E_T_ = ' ' " + CRLF 
cquery += "    AND BA1_CODEMP NOT IN ('0004','0009') " + CRLF 
If mv_par03 == 1
	cquery += "    AND (SELECT  COUNT(*) "
	cquery += "           FROM SIGA.PD5010 PD5 "
	cquery += "          WHERE  PD5_FILIAL = ' ' AND PD5.D_e_l_e_t_ = ' ' "
	cquery += "            AND PD5_TPACAO = 'REAT' AND PD5_DATRET > '"+cDtEntr+"'" 
	cquery += "            AND PD5_ENVIAD = 'T' "
	cquery += "            AND PD5_CRIANS =  ' ' "
	cquery += "            AND BA1_CODCCO = PD5_CODCCO )= 0  "
EndIf 

TcQuery cQuery New Alias (cAliasBA1)

(cAliasBA1)->(dbGoTop())

DbSelectArea("BA1")


While !(cAliasBA1)->(EOF())
	
	If (cAliasBA1)->recba1 > 0 

       If  mv_par02 == 1

//		forçar (6 - forçar inclusão, 7 - forçar alteração; 8 - forçar exclusão) 		

           BA1->(dbGoTo((cAliasBA1)->recba1))    		
           BA1->(RecLock("BA1",.F.))
           BA1->BA1_LOCSIB   := 'C'      
           BA1->BA1_ATUSIB   := '1'  
//           BA1->BA1_INFANS   := '1'
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
user  Function faz01int()


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
cquery += "    AND BA1_CODCCO <> ' ' " + CRLF
cquery += "    AND BA1_INFANS <> '0' " + CRLF
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
user function faz11int()
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
cquery += "    AND BA1_INFANS <> '0' " + CRLF 
cquery += "    AND D_E_L_E_T_ = ' ' " + CRLF
cquery += "    AND SIGA.BLOQUEIO_ANS_SIB( 'INTEGRAL', SIB_MATRIC, '"+cDtEntr+"' ) = 'S' " + CRLF
cquery += "  WHERE SIB_SITUAC = '1' " + CRLF 
If mv_par03 == 1
	cquery += "  AND (SELECT  COUNT(*) FROM SIGA.PD5020 PD5 "
	cquery += "        WHERE  PD5_FILIAL = ' ' AND PD5.D_e_l_e_t_ = ' ' "
	cquery += "          AND PD5_TPACAO = 'CANC' AND PD5_DATRET > '"+cDtEntr+"'" 
	cquery += "          AND PD5_ENVIAD = 'T'  "
	cquery += "          AND PD5_CRIANS =  ' ' "
	cquery += "          AND BA1_CODCCO = PD5_CODCCO )= 0 "
EndIf 

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

user function faz21int()
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
cquery += "    AND BA1_INFANS <> '0' " + CRLF     
cquery += "    AND BA1_CODCCO = ' ' " + CRLF
cquery += "    AND NOT EXISTS " + CRLF
cquery += "      ( " + CRLF
cquery += " SELECT 1 " + CRLF
cquery += "   FROM CONFSIB_INT " + CRLF
cquery += "  WHERE SIB_MATRIC = BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG||BA1_DIGITO " + CRLF
cquery += "      ) " + CRLF
If mv_par03 == 1
	cquery += "  AND (SELECT  COUNT(*) FROM SIGA.PD5020 PD5 "
	cquery += "        WHERE  PD5_FILIAL = ' ' AND PD5.D_e_l_e_t_ = ' ' "
	cquery += "          AND PD5_TPACAO = 'INCL' AND PD5_DATRET > '"+cDtEntr+"'" 
	cquery += "          AND PD5_ENVIAD = 'T'  "
	cquery += "          AND PD5_CRIANS =  ' ' "
	cquery += "          AND BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG||BA1_DIGITO = PD5_MATRIC )= 0 "
EndIf 

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
//            BA1->BA1_INFANS   := '1'
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
user function faz22int()
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
cquery += "    AND BA1_INFANS <> '0' " + CRLF
cquery += "    AND D_E_L_E_T_ = ' ' " + CRLF

If mv_par03 == 1
	cquery += "    AND (SELECT  COUNT(*) "
	cquery += "           FROM SIGA.PD5020 PD5 "
	cquery += "          WHERE  PD5_FILIAL = ' ' AND PD5.D_e_l_e_t_ = ' ' "
	cquery += "            AND PD5_TPACAO = 'REAT' AND PD5_DATRET > '"+cDtEntr+"'" 
	cquery += "            AND PD5_ENVIAD = 'T' "
	cquery += "            AND PD5_CRIANS =  ' ' "
	cquery += "            AND BA1_CODCCO = PD5_CODCCO )= 0  "
EndIf 

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
 //          BA1->BA1_INFANS   := '1'
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

       