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
| Programa  | CABA177  | Autor | Altamiro	Affonso    | Data | 19/06/2020  |
|---------------------------------------------------------------------------|              
| Descricao | Alcadas de liberação de folha de pagamento e beneficios       |
|           |                                                               |                                                       
|---------------------------------------------------------------------------|
| Uso       | Alcadas de liberação de comissoes                             |                                   
 --------------------------------------------------------------------------*/

User Function CABA188X( nOrigem , ctitulos , ctitulos1 )
                                                 
Private  nI := 0          

Private _cUsuario:= SubStr(cUSUARIO,7,15)
Private _cIdUsuar:= RetCodUsr()

Private _cIdUsuar := '000521'

private ctitulos11  := ctitulos1

private cDthr       := (dtos(DATE()) + "-" + Time())       
 
private aTitRecPag	:= {}
private adadosTit   := {}   
private aDadSE1     := {}

private nOrigem1    := iif (empty(nOrigem), 0 , nOrigem )

Private cAliastmp    := GetNextAlias()
Private cAliastmp1 	 := GetNextAlias()
Private cAliastmp2 	 := GetNextAlias()      
Private cAliastmp3 	 := GetNextAlias()
Private cAliastmp4 	 := GetNextAlias()    
Private cAliastmp6 	 := GetNextAlias() 
Private cAliastmp7 	 := GetNextAlias() 

Private cQuery        := " "   
Private cQuery1       := " "  
Private cQuery2       := " "  
Private cQuery3       := " "  
Private cQuery4       := " "   
Private cQuery6       := " "  
Private cQuery7       := " "

private cEmp          := ' ' 
private cMes          := ' '
private cAno          := ' '
private cPrefT        := ' ' 
private cNumtT        := ' '
private cTipoT        := ' '
private cVend         := ' '
private lflagMM      :=.F.
private cValor        := ' ' 

Private aBrwPEG 
private aRetPEG	:= {}    
 
Private aCabPEG	:= {      " " ,;
                          " " ,;
			    "Competencia" ,;
			         "Origem" ,;
					   "Tipo" ,;
				    "Emissao" ,;
		         "Vencimento" ,;
				     "Valor " ,;
					  "Saldo" ,;
					  "Baixa" ,;
				    "Usuario" ,;
					   "Acao" ,;
					   "Tipo" }

// Private aCabPEG	:= {" "," ","Compte" , "Origem", "Tipo", "Emissao", "Vencimento ", "Valor " , "Saldo" , "Baixa",Usuario","Acao", 'Tipo'}
Private aTamPEG	    := {5  , 5 ,  35     , 25      , 120    ,  25      ,  25          , 50       , 50        , 25   , 100    , 30  ,   30 }       

//private aBrwPEG
//Private aCabPEG		:= {" ", "Compt. Entrada","Operadora de  Origem  ","Vlr Fase 3","Vlr Fase 31/2","Vlr Fase 4","Vlr Inss","Vlr Tx Adm", "Total Guias","Faturado","Qtda Guias"}
//Private aTamPEG		:= {10,30,120,45,45,45,45,45,45,45,25}  

/*
Private oOk      	:= LoadBitMap(GetResources(),"LBOK")
Private oNo      	:= LoadBitMap(GetResources(),"LBNO")

Private oVerde   	:= LoadBitMap(GetResources(),"ENABLE")
Private oAzul   	:= LoadBitMap(GetResources(),"BR_AZUL") 
Private oAmarelo	:= LoadBitMap(GetResources(),"BR_AMARELO")
*/

Private aObjects 	:= {}

Private aSizeAut 	:= MsAdvSize() 

Private cPerg	    := "CABA183A"     
 
private cFecConv    := 1       
private cFezConc    := 2

private nPagto      := 0

private cLOTCOB     := ' '   
private cFZCRIT     := ' '   
private cCVLTOT     := ' '   
private cCVLBAS     := ' '   
private cCVLTAD     := ' '   
private cCVLFS3     := ' '   
private cCVLAN3     := ' '   
private cCVLFAT     := ' ' 
private cCVLBLF     := ' ' 
private cFAZCON     := ' ' 

Private dVencInc                      
Private dVencFim                     
Private cTipotit                     
Private cTipbaixa     

private cCompInc  := ' '                     
private cCompFim  := ' '

private cmv_par09 := ' '   

private nfase3    := 0                   
private nfase312  := 0                  
private nfase4    := 0   

private Idx       := 0        

private cClsRd    := ' ' 

private dDtvenc   := ' '  

Private cDscori   := ' ' 

Private cMesBase     := ' '  
Private cAnoBase     := ' ' 
Private cNumTitI     := ' '  
Private cNumTitF     := ' '     
Private cOpeInc      := ' ' 
Private cOpeFim      := ' '     
   
Private aTit         := {}                     

private cAliasCf  := GetNextAlias()   
private cAliasDem := GetNextAlias()   
private cAliasCT  := GetNextAlias()    
private cAliasEX  := GetNextAlias()   
Private cAliasEqp := GetNextAlias()

private cAliasPEG	:= GetNextAlias()
private cAliasCE	:= GetNextAlias()

PRIVATE cAno         := ' ' 
private cMes         := ' ' 

private cAnoMais  := ' ' 
private cMesMais  := ' '

private cAnoMenos := ' '
private cMesMenos := ' '

private cAnoMenos1 := ' '
private cMesMenos1 := ' '

private cAnoMenos2 := ' '
private cMesMenos2 := ' '

private cAnoMenos3 := ' '
private cMesMenos3 := ' '

Private cttitpgto:=' '   

Private oOk      	:= LoadBitMap(GetResources(),"LBOK")
Private oNo      	:= LoadBitMap(GetResources(),"LBNO")

Private oVerde   	:= LoadBitMap(GetResources(),"ENABLE")
Private oAzul   	:= LoadBitMap(GetResources(),"BR_AZUL")    
Private oAmarelo	:= LoadBitMap(GetResources(),"BR_AMARELO")


PRIVATE cCadastro	:= "Aprovação de Folha e Beneficios  "


PRIVATE aCdCores	:= { 	{ 'BR_VERDE'    ,'Aprovado     ' },; 
							{ 'BR_AZUl'     ,'Pago         ' },;							
							{ 'BR_AMARELO'  ,'Não Aprovado ' }}

PRIVATE aRotina	:=	{	{ "Legenda"		, 'U_LEGPR188'	    , 0, K_Incluir		} }	

Private cComptMais  := ' ' 
Private cComptMenos := ' '
Private cTipo       := ' ' 
Private cTipo1       := ' ' 

/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±± Declaração de cVariable dos componentes                                 ±±
Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/
Private cCompt1    := Space(1)
Private cCompt2    := Space(1)
Private cCompt3    := Space(1)
Private cMensSist 
Private cTipoAtu   := Space(1)
Private dDataAtu   := CtoD(" ")

//Private lConf      := .T.

Private nEvolu0    := 0
Private nEvolu1    := 0
Private nEvolu2    := 0
Private nEvolu3    := 0

Private nFundGrt0  := 0
Private nFundGrt1  := 0
Private nFundGrt2  := 0
Private nFundGrt3  := 0

Private nInssPat0  := 0
Private nInssPat1  := 0
Private nInssPat2  := 0
Private nInssPat3  := 0

Private nInssRet0  := 0
Private nInssRet1  := 0
Private nInssRet2  := 0
Private nInssRet3  := 0

Private nIrrfRet0  := 0
Private nIrrfRet1  := 0
Private nIrrfRet2  := 0
Private nIrrfRet3  := 0

Private nQtda0     := 0
Private nQtda1     := 0
Private nQtda2     := 0
Private nQtda3     := 0

Private nVlrAtu    := 0
Private nVlrTot    := 0

private dDtvenc    :=' ' 
private cOrgem     :=' ' 
private cTip       := ' ' 

Private nVlrLib0   := 0
Private nVlrLib1   := 0
Private nVlrLib2   := 0
Private nVlrLib3   := 0
private lCertif    :=.T.
private lfim       := .F.
/////////////////////////////////////////////fim variaves da tela




If Pergunte(cPerg,.T.) = .F.
	Return
Endif 

cAno         := Mv_par02 
cMes         := Mv_par01


fcompte(cAno , cMes)

cComptMais  := cAnoMais  +'/'+cMesMais
cComptMenos := cAnoMenos +'/'+cMesMenos

//AjustaSX1()

//Pergunte(cPerg,.T.)        

//cCompInc := Mv_par01                     
//cCompFim := Mv_par02  
//cmv_par09:= Mv_par01

//Processa({||aBrwPEG := aDadosPEG()},'Processando...','Processando...',.T.)
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
          
lAjustHor	:= .T.
//lAjustVert 	:= .T.
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

//oDlg  		:= MsDialog():New( aSizeAut[7],00,aSizeAut[3]-100,aSizeAut[5]-10,"Repase Comissao Vendedor Interno Integral -> Caberj ",,,.F.,,,,,,.T.,,,.T. ) 

oDlg  		:= MsDialog():New( aSizeAut[7],00,aSizeAut[3] ,aSizeAut[5]-10,"Liberações de Pagamentos da Folha e Beneficios ",,,.F.,,,,,,.T.,,,.T. ) 
oSayPEG    	:= TSay():New( aPosObj[1][1],aPosObj[1][2],{||'"Liberações de Pagamentos da Folha e Beneficios "'},oDlg,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,236,016)


bDbClickPEG	:= {|| aBrwPEG[oBrwPEG:nAt,1] := !aBrwPEG[oBrwPEG:nAt,1], oBrwPEG:Refresh()}   

//bDbClickPEG	:= {|| aBrwPEG[oBrwPEG:nAt,1] := iif ((aBrwPEG[oBrwPEG:nAt,17] == ' ' .or. mv_par01 == '1') , aBrwPEG[oBrwPEG:nAt,1] ,!aBrwPEG[oBrwPEG:nAt,1]), oBrwPEG:Refresh()}   

//bChangePEG	:= {||AtuBrwGuia(aBrwPEG[oBrwPEG:nAt,2],aBrwPEG[oBrwPEG:nAt,3])}

oBrwPEG 	:= TcBrowse():New(aPosObj[1][1],aPosObj[1][2],aPosObj[1][4],aPosObj[1][3]+40,,aCabPEG,aTamPEG,oDlg,,,,,bDbClickPEG,,,,,,,.F.,,.T.,,.F.,,, )

//oBrwPEG 	:= TcBrowse():New(aPosObj[1][1]+10,aPosObj[1][2],aPosObj[1][4],aPosObj[1][3]+190,,aCabPEG,aTamPEG,oDlg,,,,,bDbClickPEG,,,,,,,.F.,,.T.,,.F.,,, )

oBrwPEG:SetArray(aBrwPEG)

//IIf(alltrim(aBrwPEG[oBrwPEG:nAt, 15]) != '0',oVerde,(IIf(aBrwPEG[oBrwPEG:nAt,8]== 0,oVermelho,oAmarelo) ))  ,;
	                 
oBrwPEG:bLine := {||{ If(aBrwPEG[oBrwPEG:nAt,  1],oOk,oNo) ,;
                     IIf(aBrwPEG[oBrwPEG:nAt,8]== 0,oAzul,(IIf(alltrim(aBrwPEG[oBrwPEG:nAt, 15]) != '0',oVerde,oAmarelo)))  ,;
                         aBrwPEG[oBrwPEG:nAt,  2] ,;
                         aBrwPEG[oBrwPEG:nAt,  3] ,;
						 aBrwPEG[oBrwPEG:nAt,  4] ,;
                         aBrwPEG[oBrwPEG:nAt,  5] ,;
                         aBrwPEG[oBrwPEG:nAt,  6] ,;
	  	       Transform(aBrwPEG[oBrwPEG:nAt,  7] ,'@E  99,999,999.99'),;
			   Transform(aBrwPEG[oBrwPEG:nAt,  8] ,'@E  99,999,999.99'),;	 
		 	             aBrwPEG[oBrwPEG:nAt, 16] ,;
		 	     alltrim(aBrwPEG[oBrwPEG:nAt,  9]) + ' - ' +alltrim(aBrwPEG[oBrwPEG:nAt,  10]),; 
				         aBrwPEG[oBrwPEG:nAt, 13] ,;
						 aBrwPEG[oBrwPEG:nAt, 17] }}                         

oBrwPEG:nScrollType  := 1 // Scroll VCR

lConfirmou 	:= .T.

aBut    :={{"PENDENTE", {||marca(1)                 }	, "Marcar Todos "         , "Marcar Todos"      }}
aAdd(aBut, {"PENDENTE", {||desmarca(1)              }	, "Desmarcar Todos "	  , "Desmarcar Todos"	})   
aAdd(aBut, {"PENDENTE", {||fMostTela()              }   , "Tela de Liberações "    , "Tela de Liberações "})  
aAdd(aBut, {"PENDENTE", {||U_LEGPR188()             }   , "Legenda "              , "Legenda "          })  
aAdd(aBut, {"PENDENTE", {||oDlg:End()               }   , "Sair "                 , "Sair "             })  

lConfirmou := .F.

//bOk 	:= {||fSequen() , oBrwPEG:Refresh() , oBrwPEG:Refresh() ,oDlg:End()   }    
 
bOk 	:= {|| fMostTela()  }    
 
bCancel := {||lConfirmou := .F.,oDlg:End()}

oDlg:Activate(,,,.T.,,,EnchoiceBar(oDlg,bOk,bCancel,,aBut))

a:='v'

Return(nPagto)    

************************************************************************************

Static Function aDadosPEG

Local cQryPEG	:= ""
Local cQryCE	:= ""
local i 

ProcRegua(0) 

nCont := 0

for i:=1 to 5
    IncProc('Buscando Dados no Servidor ...')
next             
      
cQryPEG :="        select DECODE(SUBSTR(E2_ORIGEM,1,4) ,'GPEM' , 'FOLHA','COMPAS') ORIGEM , " 
cQryPEG += CRLF + "       DECODE(E2_TIPO,'FGT' , 'FUNDO DE GARANTIA' , " 
cQryPEG += CRLF + "       'FOL' , 'FOLHA DE PAGAMENTO' , "
cQryPEG += CRLF + "       'PEN' , 'PENSÃO ALIMENTICIA' , " 
cQryPEG += CRLF + "       'RES' , 'RESIÇÃO' , "
cQryPEG += CRLF + "       'IRF' , 'IMPOSTO DE RENDA' ,  " 
cQryPEG += CRLF + "       'FER' , 'FERIAS' , "
cQryPEG += CRLF + "       'TX ' , 'PIS' , "
cQryPEG += CRLF + "       'INS' , 'INSS', "
cQryPEG += CRLF + "       'NF ' , TRIM(E2_NOMFOR) , 'NAO IDENTIFICADO') TIPO , "
cQryPEG += CRLF + "       trim( Substr(E2_VENCREA,7,2)||'/'||Substr(E2_VENCREA,5,2)||'/'||Substr(E2_VENCREA,1,4)) VencRea , "
cQryPEG += CRLF + "       trim(Substr(E2_EMISSAO,7,2)||'/'||Substr(E2_VENCREA,5,2)||'/'||Substr(E2_VENCREA,1,4)) Emissao , "                            
cQryPEG += CRLF + "       trim(Substr(E2_BAIXA  ,7,2)||'/'||Substr(E2_BAIXA  ,5,2)||'/'||Substr(E2_BAIXA  ,1,4)) Baixa   , "                            
cQryPEG += CRLF + "       Alc.AK_USER Usuar, Alc.AK_NOME NomUsr, Alc.AL_COD CodAlc , Alc.AL_DESC DescAlc , decode(Alc.AL_LIBAPR, 'V', 'Vista', 'Aprova') Lib , Alc.AL_USERSUP AprSup , "
cQryPEG += CRLF + "       Alc.AK_LIMMIN LIMMIN, Alc.AK_LIMMAX LIMMAX ,"
cQryPEG += CRLF + "       sum(se2.E2_VALOR) valor , sum(se2.e2_saldo) saldo , nvl(pdt.pdt_num, '0') TEMPDT , "
cQryPEG += CRLF + "       E2_TIPO E2TIPO "
// se2.e2_prefixo prefixo , se2.e2_num num , se2.e2_parcela parcela , se2.e2_tipo e2tipo , se2.e2_fornece fornece , se2.e2_nomfor nomfor , se2.R_E_C_N_O_ controle ,

cQryPEG += CRLF + "  from se2010 SE2 , pdt010 pdt , "
cQryPEG += CRLF + "       (SELECT AK_USER , AK_NOME, AL_COD , AL_DESC , AL_LIBAPR , AL_USERSUP , AK_LIMMIN ,AK_LIMMAX"  
cQryPEG += CRLF + "         FROM "+RetSQLName("SAL")+" SAL , "
cQryPEG += CRLF + "              "+RetSQLName("SAK")+" SAK   "
cQryPEG += CRLF + "        WHERE AL_FILIAL  = '" + xFilial('SAL') + "'  AND SAL.D_E_L_E_T_ = ' ' " 
cQryPEG += CRLF + "          AND AK_FILIAL  = '" + xFilial('SAK') + "'  AND SAK.D_E_L_E_T_ = ' ' "
cQryPEG += CRLF + "          AND AL_COD = '909099' "
cQryPEG += CRLF + "          AND AK_COD = AL_APROV "
cQryPEG += CRLF + "          AND AL_USER = '"+_cIdUsuar+"' ) Alc  "

cQryPEG += CRLF + " where e2_filial ='01' and se2.d_E_L_E_T_ = ' ' "

cQryPEG += CRLF + "   and pdt_filial(+) ='01' and pdt.d_E_L_E_T_(+) = ' ' " 

cQryPEG += CRLF + "   AND E2_VENCREA  like '"+cAno+cmes+"%' "

cQryPEG += CRLF + "   AND PDT_PREFIX(+) = se2.e2_prefixo "
cQryPEG += CRLF + "   AND PDT_NUM(+)    = se2.e2_num "
cQryPEG += CRLF + "   AND PDT_PARCEL(+) = se2.e2_parcela "
cQryPEG += CRLF + "   AND PDT_TIPO(+)   = se2.e2_tipo  "
cQryPEG += CRLF + "   AND PDT_FORNEC(+) = se2.e2_fornece "
cQryPEG += CRLF + "   and pdt_aprov(+)  = '"+_cIdUsuar+"' "
cQryPEG += CRLF + "   AND PDT_modulo(+) = 'FOL' "

cQryPEG += CRLF + "   and ((Alc.AL_USERSUP <> ' ' "
cQryPEG += CRLF + "   AND (SELECT NVL(COUNT(*), 0 ) FROM PDT010 PDT1 "
cQryPEG += CRLF + "         WHERE PDT1.pdt_filial ='01' and pdt.d_E_L_E_T_ = ' ' "  
cQryPEG += CRLF + "           AND pdt1.PDT_PREFIX = se2.e2_prefixo "
cQryPEG += CRLF + "           AND pdt1.PDT_NUM    = se2.e2_num "
cQryPEG += CRLF + "           AND PDT1.PDT_PARCEL = se2.e2_parcela "
cQryPEG += CRLF + "           AND PDT1.PDT_TIPO   = se2.e2_tipo  "
cQryPEG += CRLF + "           AND PDT1.PDT_FORNEC = se2.e2_fornece "
cQryPEG += CRLF + "           and PDT1.pdt_aprov  = Alc.AL_USERSUP " 
cQuery += CRLF + "            AND PDT_TPAPRO = 'V' "
cQuery += CRLF + "            AND PDT_ACAO   = 'V' "
cQryPEG += CRLF + "           AND PDT1.PDT_modulo = 'FOL' ) > 0) "
cQryPEG += CRLF + "    OR ALC.AL_USERSUP = ' ')  "     

cQryPEG += CRLF + "   AND ((E2_NOMFOR LIKE '%RIO CARD%' OR E2_NOMFOR LIKE '%SODEX%')OR e2_origem like 'GPE%') "
cQryPEG += CRLF + "   AND (E2_ORIGEM LIKE 'MA%' OR e2_origem like 'GPE%') "

cQryPEG += CRLF + " Group by DECODE(SUBSTR(E2_ORIGEM,1,4) ,'GPEM' , 'FOLHA','COMPAS') , " 
cQryPEG += CRLF + "       DECODE(E2_TIPO,'FGT' , 'FUNDO DE GARANTIA' , " 
cQryPEG += CRLF + "       'FOL' , 'FOLHA DE PAGAMENTO' , "
cQryPEG += CRLF + "       'PEN' , 'PENSÃO ALIMENTICIA' , " 
cQryPEG += CRLF + "       'RES' , 'RESIÇÃO' , "
cQryPEG += CRLF + "       'IRF' , 'IMPOSTO DE RENDA' ,  " 
cQryPEG += CRLF + "       'FER' , 'FERIAS' , "
cQryPEG += CRLF + "       'TX ' , 'PIS' , "
cQryPEG += CRLF + "       'INS' , 'INSS', "
cQryPEG += CRLF + "       'NF ' , TRIM(E2_NOMFOR) , 'NAO IDENTIFICADO') , "
cQryPEG += CRLF + "       Substr(E2_VENCREA,7,2)||'/'||Substr(E2_VENCREA,5,2)||'/'||Substr(E2_VENCREA,1,4) , "
cQryPEG += CRLF + "       Substr(E2_EMISSAO,7,2)||'/'||Substr(E2_VENCREA,5,2)||'/'||Substr(E2_VENCREA,1,4) , "                            
cQryPEG += CRLF + "       Substr(E2_BAIXA  ,7,2)||'/'||Substr(E2_BAIXA  ,5,2)||'/'||Substr(E2_BAIXA  ,1,4) , "                            
cQryPEG += CRLF + "       Alc.AK_USER , Alc.AK_NOME , Alc.AL_COD , Alc.AL_DESC , decode(Alc.AL_LIBAPR, 'V', 'Vista', 'Aprova') , Alc.AL_USERSUP , nvl(pdt.pdt_num, '0') , e2_tipo , "
cQryPEG += CRLF + "       Alc.AK_LIMMIN , Alc.AK_LIMMAX "

cQryPEG += CRLF + " Order by 2,4"
TcQuery cQryPEG New Alias (cAliasPEG)  

(cAliasPEG)->(dbGoTop())    

While !(cAliasPEG)->(EOF())

cTipo1 :=   trim((cAliasPEG)->Tipo)

If substr((cAliasPEG)->Tipo,1,5) $ 'IMPOS|INSS |FUNDO'

   cTipo :=   trim((cAliasPEG)->Tipo) + ' - Competencia ' + cComptMenos

ElseIf substr((cAliasPEG)->Tipo,1,5) $ 'SODEX|RIO C|FERIA'

   cTipo :=   trim((cAliasPEG)->Tipo) + ' - Competencia ' + cComptMais

Else 

   cTipo :=   trim((cAliasPEG)->Tipo) + ' - Competencia ' + cAno+'/'+cMes

EndIF   

//aAdd(aRetPEG,{iif(iif(trim((cAliasPEG)->TEMPDT) == '0',.T.,.F.) 

 aAdd(aRetPEG,{iif((cAliasPEG)->Saldo == 0, .F. ,(Iif(trim((cAliasPEG)->TEMPDT) == '0',.T.,.F.) ))        ,;    //1
					cAno+cmes            ,;    //2
					(cAliasPEG)->Origem  ,;    //3 
					cTipo    ,;    //4
					alltrim((cAliasPEG)->emissao) ,;    //5
					alltrim((cAliasPEG)->VencRea) ,;    //6
					(cAliasPEG)->Valor   ,;    //7
					(cAliasPEG)->Saldo   ,;    //8
					(cAliasPEG)->Usuar   ,;    //9
					(cAliasPEG)->NomUsr  ,;    //10
					(cAliasPEG)->CodAlc  ,;    //11
					(cAliasPEG)->DescAlc ,;    //12
					(cAliasPEG)->Lib     ,;    //13
					(cAliasPEG)->AprSup  ,;    //14
					(cAliasPEG)->TEMPDT  ,;    //15
					alltrim((cAliasPEG)->BAIXA) ,;//16
					(cAliasPEG)->E2TIPO  ,;     //17
					cTIPO1})    //18

	(cAliasPEG)->(DbSkip())

EndDo
  
(cAliasPEG)->(DbCloseArea())

If empty(aRetPEG)
	aAdd(aRetPEG,{.F.,;  //1
           cAno+cmes ,;  //2  
				   '',;  //3
				   '',;  //4
				   '',;  //5
				   '',;  //6
				 0.00,;  //7
			     0.00,;  //8
				   '',;  //9
				   '',;  //10
				   '',;  //11
				   '',;  //12
				   '',;  //13
				   '',;  //14
				  '0',;  //15
				   '',;  //16
				   ''})  //17
				    
EndIf

Return aRetPEG

/********************************************/
/********************************************/                                    

    
/***********************************************************************************/
Static Function marca(cRef) // cRef == 1 peg , 2 , proc
	
       local nI            
       
//    If mv_par01 == 2

		For nI := 1 to len(aBrwPEG)
	
		    aBrwPEG[nI,1]:= .T.

		Next

//	EndIf 	
		
RETURN()	
	
Static Function desmarca(cRef) // cRef == 1 peg , 2 , proc
	
       local nI
			
	      For nI := 1 to len(aBrwPEG)
	
			   aBrwPEG[nI,1]:= .F.
			   
	      Next
	
RETURN() 

Static Function fFazlib(I)

local aUsu := PswRet()
LOCAL cTpApro := 'V'
LOCAL cAcao   := 'V' 
LOCAL cLib    := 'N'

nPagto := 0
      
cQuery :="        select DECODE(SUBSTR(E2_ORIGEM,1,4) ,'GPEM' , 'FOLHA','COMPAS') ORIGEM , " 
cQuery += CRLF + "       DECODE(E2_TIPO,'FGT' , 'FUNDO DE GARANTIA' , " 
cQuery += CRLF + "       'FOL' , 'FOLHA DE PAGAMENTO' , "
cQuery += CRLF + "       'PEN' , 'PENSÃO ALIMENTICIA' , " 
cQuery += CRLF + "       'RES' , 'RESCISÃO' , "
cQuery += CRLF + "       'IRF' , 'IMPOSTO DE RENDA' ,  " 
cQuery += CRLF + "       'FER' , 'FERIAS' , "
cQuery += CRLF + "       'TX '  , 'IMPOSTO DE RENDA' , "
cQuery += CRLF + "       'INS' , 'INSS', "
cQuery += CRLF + "       'NF '  , TRIM(E2_NOMFOR) , 'NAO IDENTIFICADO') TIPO , "
cQuery += CRLF + "       trim( Substr(E2_VENCREA,7,2)||'/'||Substr(E2_VENCREA,5,2)||'/'||Substr(E2_VENCREA,1,4)) VencRea , "
cQuery += CRLF + "       trim(Substr(E2_EMISSAO,7,2)||'/'||Substr(E2_VENCREA,5,2)||'/'||Substr(E2_VENCREA,1,4)) Emissao , "                            
cQuery += CRLF + "       trim(Substr(E2_BAIXA  ,7,2)||'/'||Substr(E2_BAIXA  ,5,2)||'/'||Substr(E2_BAIXA  ,1,4)) Baixa   , "                            
cQuery += CRLF + "       Alc.AK_USER Usuar, Alc.AK_NOME NomUsr, Alc.AL_COD CodAlc , Alc.AL_DESC DescAlc , decode(Alc.AL_LIBAPR, 'V', 'Vista', 'Aprova') Lib , Alc.AL_USERSUP AprSup ,  AL_LIBAPR LIBAPR ,"
cQuery += CRLF + "       Alc.AK_LIMMIN LIMMIN, Alc.AK_LIMMAX LIMMAX ,"
cQuery += CRLF + "       (se2.E2_VALOR) valor , (se2.e2_saldo) saldo , nvl(pdt.pdt_num, '0') TEMPDT ,  "
 
 cQuery += CRLF + "       se2.e2_prefixo prefixo , se2.e2_num num , se2.e2_parcela parcela , se2.e2_tipo e2tipo , se2.e2_fornece fornece , se2.e2_nomfor nomfor , se2.R_E_C_N_O_ controle " 

cQuery += CRLF + "  from se2010 SE2 , pdt010 pdt , "
cQuery += CRLF + "       (SELECT AK_USER , AK_NOME, AL_COD , AL_DESC , AL_LIBAPR , AL_USERSUP , AK_LIMMIN ,AK_LIMMAX "  

cQuery += CRLF + "         FROM "+RetSQLName("SAL")+" SAL , "
cQuery += CRLF + "              "+RetSQLName("SAK")+" SAK   "
cQuery += CRLF + "        WHERE AL_FILIAL  = '" + xFilial('SAL') + "'  AND SAL.D_E_L_E_T_ = ' ' " 
cQuery += CRLF + "          AND AK_FILIAL  = '" + xFilial('SAK') + "'  AND SAK.D_E_L_E_T_ = ' ' "
cQuery += CRLF + "          AND AL_COD = '909099' "
cQuery += CRLF + "          AND AK_COD = AL_APROV "
cQuery += CRLF + "          AND AL_USER = '"+_cIdUsuar+"' ) Alc  "

cQuery += CRLF + " where e2_filial ='01' and se2.d_E_L_E_T_ = ' ' "

cQuery += CRLF + "   and pdt_filial(+) ='01' and pdt.d_E_L_E_T_(+) = ' ' " 

cQuery += CRLF + "   AND E2_VENCREA  like '"+cAno+cmes+"%' "

cQuery += CRLF + "   AND PDT_PREFIX(+) = se2.e2_prefixo "
cQuery += CRLF + "   AND PDT_NUM(+)    = se2.e2_num "
cQuery += CRLF + "   AND PDT_PARCEL(+) = se2.e2_parcela "
cQuery += CRLF + "   AND PDT_TIPO(+)   = se2.e2_tipo  "
cQuery += CRLF + "   AND PDT_FORNEC(+) = se2.e2_fornece "
cQuery += CRLF + "   and pdt_aprov(+)  = '"+_cIdUsuar+"' "
cQuery += CRLF + "   AND PDT_modulo(+) = 'FOL' "

cQuery += CRLF + "   and ((Alc.AL_USERSUP <> ' ' "
cQuery += CRLF + "   AND (SELECT NVL(COUNT(*), 0 ) FROM PDT010 PDT1 "
cQuery += CRLF + "         WHERE PDT1.pdt_filial ='01' and pdt.d_E_L_E_T_ = ' ' "  
cQuery += CRLF + "           AND pdt1.PDT_PREFIX = se2.e2_prefixo "
cQuery += CRLF + "           AND pdt1.PDT_NUM    = se2.e2_num "
cQuery += CRLF + "           AND PDT1.PDT_PARCEL = se2.e2_parcela " 
cQuery += CRLF + "           AND PDT1.PDT_TIPO   = se2.e2_tipo  "
cQuery += CRLF + "           AND PDT1.PDT_FORNEC = se2.e2_fornece "
cQuery += CRLF + "           AND PDT_TPAPRO = 'V' "
cQuery += CRLF + "           AND PDT_ACAO   = 'V' "
cQuery += CRLF + "           and PDT1.pdt_aprov  = Alc.AL_USERSUP "
cQuery += CRLF + "           AND PDT1.PDT_modulo = 'FOL' ) > 0) "
cQuery += CRLF + "    OR ALC.AL_USERSUP = ' ')   "    

cQuery += CRLF + "   AND ((E2_NOMFOR LIKE '%RIO CARD%' OR E2_NOMFOR LIKE '%SODEX%')OR e2_origem like 'GPE%') "
cQuery += CRLF + "   AND (E2_ORIGEM LIKE 'MA%' OR e2_origem like 'GPE%') "

cQuery += CRLF + "   AND DECODE(SUBSTR(E2_ORIGEM,1,4) ,'GPEM' , 'FOLHA','COMPAS') = '"+TRIM(aBrwPEG[I,3])+"'"
cQuery += CRLF + "   and DECODE(E2_TIPO,'FGT' , 'FUNDO DE GARANTIA' , " 
cQuery += CRLF + "       'FOL' , 'FOLHA DE PAGAMENTO' , "
cQuery += CRLF + "       'PEN' , 'PENSÃO ALIMENTICIA' , " 
cQuery += CRLF + "       'RES' , 'RESIÇÃO' , "
cQuery += CRLF + "       'IRF' , 'IMPOSTO DE RENDA' ,  " 
cQuery += CRLF + "       'FER' , 'FERIAS' , "
cQuery += CRLF + "       'TX '  , 'IMPOSTO DE RENDA' , "
cQuery += CRLF + "       'INS' , 'INSS', "
cQuery += CRLF + "       'NF '  , TRIM(E2_NOMFOR) , 'NAO IDENTIFICADO') = '"+TRIM(aBrwPEG[I,18])+"'"
cQuery += CRLF + "   AND E2_VENCREA            = '"+dDtvenc+"'"
cQuery += CRLF + "   AND E2_SALDO              > 0 "
cQuery += CRLF + "   AND E2_TIPO               = '"+TRIM(aBrwPEG[I,17])+"'"


                                         
If Select((cAliastmp)) <> 0 
   (cAliastmp)->(DbCloseArea())  
Endif      

TcQuery cQuery New Alias (cAliastmp)  

(cAliastmp)->(dbGoTop())    

    nPagto := 0

	DBSELECTAREA("PDT")   
    PDT->(dbSetOrder(1))

	While !(cAliastmp)->(EOF())
	 
If  (cAliastmp)->LIMMIN > (cAliastmp)->SALDO .AND. (cAliastmp)->LIMMAX < (cAliastmp)->SALDO

     cTpApro := 'A'
     cAcao   := 'A' 
     cLib    := 'S'

Else    

     cTpApro := 'V'
     cAcao   := 'V' 
     cLib    := 'N'

EndIF
    
		PDT->(Reclock("PDT",.T.))
   
   			PDT_FILIAL   := xFilial('PDT')  
			PDT_PREFIX   := (cAliastmp)->prefixo 
			PDT_NUM      := (cAliastmp)->num  
			PDT_PARCEL   := (cAliastmp)->parcela  
			PDT_TIPO     := (cAliastmp)->e2tipo
			PDT_FORNEC   := (cAliastmp)->fornece 
			PDT_APROV    := (cAliastmp)->Usuar
			PDT_TPAPRO   := cTpApro //(cAliastmp)->LIBAPR 
			PDT_DTAPRO   := DATE()  
			PDT_LIBERA   := cLib //trim(Iif((cAliastmp)->lib=='Visto','N','S'))  
			PDT_MODULO   :='FOL'  
			PDT_GRPAPR   := (cAliastmp)->CodAlc
			PDT_NOMAPV   := (cAliastmp)->NomUsr
			PDT_LOG      := "Usuario : " +_cUsuario + " Data Hora Geração " +cDthr
			PDT_ACAO     := cAcao //(cAliastmp)->LIBAPR
         
		    nPagto++                

		PDT->(MsUnlock())

    If  cAcao   == 'A'  // 'A' - ALTERAR QUANDO FOR PARA PRODUÇÃO OU TESTE PILOTO
        aaDD(aDadostit ,{(cAliastmp)->Prefixo    ,;
		                 (cAliastmp)->Num        ,;                                                          
		                 (cAliastmp)->parcela    ,;                                                                                 
		                 (cAliastmp)->e2tipo       ,; 
						 Transform((cAliastmp)->Saldo,'@E  99,999,999.99'),;                                                                           
		                 (cAliastmp)->FORNECE    ,;
		                 (cAliastmp)->Usuar      ,;
						 (cAliastmp)->NomUsr     ,;
		                 cAcao  })     

    Else

        aaDD(aDadostit ,{cTipoAtu    ,;
		                 cAno+cmes   ,;
                         dDataAtu    ,;
						 Transform(nVlrTot,'@E  99,999,999.99'),;                                                                           
						 Transform(nVlrAtu,'@E  99,999,999.99'),;
						 (cAliastmp)->Usuar      ,;
						 (cAliastmp)->NomUsr     ,;
		                 cAcao  })           
    EndIf 

		(cAliasTmp)->(DbSkip())

	EndDo
    


Return(nPagto)
***************************************************************************************/
Static Function AjustaSX1()

Local aHelp 	:= {}   


u_CABASX1(cPerg,"01",OemToAnsi("Exib. Tit. Baixados")              ,"","","mv_ch1","N",01,0,0,"C","","","","","mv_par01","Sim","","","","Não","","","","","","","","","","","",{},{},{}) 



Return 
           

Static Function ValPergFc()

cPerg := PADR(cPerg,7)    

PutSx1(cPerg,"01","Mes Compencia     "  ,"","","mv_ch01","C",02,0,0,"G","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "99", "" )  
PutSx1(cPerg,"02","Ano Compencia     "  ,"","","mv_ch02","C",04,0,0,"G","","mv_par02","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "99", "" ) 
PutSx1(cPerg,"03","Num Titulo Inc    "  ,"","","mv_ch03","C",09,0,0,"G","","mv_par03","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "99/99/9999", "" ) 
PutSx1(cPerg,"04","Num Titulo Fim    "  ,"","","mv_ch04","C",09,0,0,"G","","mv_par04","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "99/99/9999", "" ) 
PutSx1(cPerg,"05","Ope Origem Inc    "  ,"","","mv_ch05","C",04,0,0,"G","","mv_par05","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "99/99/9999", "" )
PutSx1(cPerg,"06","Ope Origem Final  "  ,"","","mv_ch06","C",04,0,0,"G","","mv_par06","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "99", "" )


Return(.T.)

Static Function fEnvEmail()

Local lEmail     := .F.
Local c_CampAlt  := '  ' 
Local lExecuta   := .T.   
local cDest      := " "                           
Local aArea      := GetArea() //Armazena a Area atual        
Local _cMensagem := " " 

_cMensagem := "Em " + DtoC( Date() ) +  Chr(10) + Chr(13) + Chr(10) + Chr(13) 

_cMensagem +=  Chr(13) + Chr(10) + Chr(13) + Chr(10) + " Assunto : Aprovação  de Folha de Pagamento e/ou Beneficios  " 
_cMensagem +=  Chr(13) + Chr(10) + Chr(13) + Chr(10) + "Prezados,"       
_cMensagem +=  Chr(13) + Chr(10) + Chr(13) + Chr(10) + "Foi Aprovado(s) para Pagamento(s) o(s) Titulo(s) abaixo identifiado(s) : "
_cMensagem +=  Chr(13) + Chr(10)

for i:=1 to  len(adadosTit) 

    if adadosTit [I,1]  = 'A'

		_cMensagem +=  Chr(13) + Chr(10) + " Ident. Titulo : "+ adadosTit [I,1] + " "  + adadosTit [I,2] +" " + adadosTit [I,3] + " " + adadosTit [I,4]  
		_cMensagem +=  Chr(13) + Chr(10) + " Saldo         : "+ adadosTit [I,5] 
		_cMensagem +=  Chr(13) + Chr(10) + " Fornecedor    : "+ adadosTit [I,6] + " - " + POSICIONE("SA2",1,xFilial("SA2") + adadosTit [I,6],"A2_NOME")
		_cMensagem +=  Chr(13) + Chr(10) + " Aprovador     : "+ adadosTit [I,7] + " - " + adadosTit [I,8] 
		_cMensagem +=  Chr(13) + Chr(10) + " Ação          : Aprovação " 
		_cMensagem +=  Chr(13) + Chr(10) +  "________________________________________________________________________________"   

    Else 

		_cMensagem +=  Chr(13) + Chr(10) + " Tipo          : "+ adadosTit [I,1] + " "  + adadosTit [I,2] +" " + adadosTit [I,3] + " " + adadosTit [I,4]  
		_cMensagem +=  Chr(13) + Chr(10) + " Competencia   : "+ adadosTit [I,2] 
		_cMensagem +=  Chr(13) + Chr(10) + " Vencimento    : "+ adadosTit [I,3] 
		_cMensagem +=  Chr(13) + Chr(10) + " Vlr Base      : "+ adadosTit [I,4]  
		_cMensagem +=  Chr(13) + Chr(10) + " Saldo         : "+ adadosTit [I,5] 
		_cMensagem +=  Chr(13) + Chr(10) + " Vistador      : "+ adadosTit [I,7]+ " - " + adadosTit [I,7] 
		_cMensagem +=  Chr(13) + Chr(10) + " Ação          : Visto "
		_cMensagem +=  Chr(13) + Chr(10) +  "________________________________________________________________________________"   

    EndIf 

Next 

_cMensagem +=  Chr(13) + Chr(10)
_cMensagem +=  Chr(13) + Chr(10)

_cMensagem +=  Chr(13) + Chr(10) + "Para sua Ciencia."

cDest+= "altamiro@caberj.com.br " //; piumbim@caberj.com.br""

EnvEmail1( _cMensagem , cDest)   

RestArea(aArea)             

Return (.T.)                                                          
*--------------------------------------*
Static Function EnvEmail1( _cMensagem , cDest )
*--------------------------------------*                                           

/*Local _cMailServer := GetMv( "MV_WFSMTP" )
Local _cMailConta  := GetMv( "MV_WFAUTUS" )
Local _cMailSenha  := GetMv( "MV_WFAUTSE" )                        */
Local _cMailConta  := GetMv( "MV_EMCONTA" )
Local _cMailServer := GetMv( "MV_RELSERV" )
Local _cMailCo_Alnta  := GetMv( "MV_EMCONTA" )
Local _cMailSenha  := GetMv( "MV_EMSENHA" ) 

//Local _cTo  	 := "altamiro@caberj.com.br, paulovasques@caberj.com.br, piumbim@caberj.com.br"
Local _cTo  	     := cDest //"altamiro@caberj.com.br "
Local _cCC         := " "  //GetMv( "MV_WFFINA" )
Local _cAssunto    := " Autorização de pagamento de Folha de pagamento e Beneficios  "
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

static function fcompte(cAno , cMes)

  
  cAnoMenos  := Iif (cMes == '01',strZero(val(cAno)-1,4),cAno)
  cMesMenos  := Iif (cMes == '01','12' ,strZero(val(cMes)-1,2))
  cAnoMais   := Iif (cMes == '12',strZero(val(cAno)+1,4),cAno) 
  cMesMais   := Iif (cMes == '12','01' ,strZero(val(cMes)+1,2)) 

  cAnoMenos1  := Iif (cMes == '01',strZero(val(cAno)-1,4),cAno)
  cMesMenos1  := Iif (cMes == '01','12' ,strZero(val(cMes)-1,2))

  cAnoMenos2  := Iif (cMes $  '01|02',strZero(val(cAno)-1,4),cAno)
  cMesMenos2  := Iif (cMes == '02','12' ,(Iif(cMes == '01','11' ,strZero(val(cMes)-2,2))))

  cAnoMenos3  := Iif (cMes $  '01|02|03',strZero(val(cAno)-1,4),cAno)
  cMesMenos3  := Iif (cMes == '03','12' ,Iif (cMes == '02','11' ,(Iif(cMes == '01','10' ,strZero(val(cMes)-2,2)))))


Return()

User Function LEGPR188()

Local aLegenda

	aLegenda 	:= { 	{ aCdCores[1,1],aCdCores[1,2] },;
						{ aCdCores[2,1],aCdCores[2,2] },;
	              		{ aCdCores[3,1],aCdCores[3,2] } }

	                     	
BrwLegenda(cCadastro,"Status" ,aLegenda)

Return



/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³         ³ Autor ³                       ³ Data ³           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Locacao   ³                  ³Contato ³                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Aplicacao ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Analista Resp.³  Data  ³                                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³              ³  /  /  ³                                               ³±±
±±³              ³  /  /  ³                                               ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

static Function fMostTela()

For I := 1 to len(aBrwPEG)
			
	If  aBrwPEG[I,1] == .T.    

        cTipoAtu := trim(aBrwPEG[I,3]) + ' - ' + trim(aBrwPEG[I,4])
        dDataAtu := aBrwPEG[I,6]
        nVlrAtu  := aBrwPEG[I,8]
		nVlrTot  := aBrwPEG[I,7]

        dDtvenc  :=substr(dDataAtu,7,4)+substr(dDataAtu,4,2)+substr(dDataAtu,1,2)
        cOrgem   :=aBrwPEG[I,3]
        cTip     := aBrwPEG[I,13]

        cCompt3:=cAnoMenos3+'/'+cMesMenos3
        cCompt2:=cAnoMenos2+'/'+cMesMenos2
        cCompt1:=cAnoMenos1+'/'+cMesMenos1
        cCompt0:=cAno+'/'+cMes

//// percetual de evoluçaõ		
        nEvolu0:=100.00
        nEvolu1:=100.00
        nEvolu2:=100.00
        nEvolu3:=100.00

//// quantidade de pagto 
       nQtda0     := 99999
       nQtda1     := 99999
       nQtda2     := 99999 
       nQtda3     := 99999

    If TRIM(cOrgem) == 'FOLHA'

        If fCertif(trim(aBrwPEG[I,13]) ,dDtvenc , nVlrTot )
		   cMensSist :="Liberação Foi   C E R T I F I C A D A   , Valor do Titulo a Pagar é Igual aos registrados no sistema de Folha de Pagamento " + CRLF + CRLF
		Else 
		   cMensSist :="Liberação NÂO Foi   C E R T I F I C A D A   , Valor do Titulo a Pagar é Diferente dos registrados no sistema de Folha de Pagamento " + CRLF + CRLF
        EndIf
    
	EndIf 

        If aBrwPEG[I,8] <= 0
		   cMensSist +="Titulo foi Baixado , Não pode ser Liberdo" +CRLF
        EndIf

		If trim(aBrwPEG[I,15]) <> '0'
           cMensSist +=" Titulo Liberado por você  , Não pode ser liberdo Novamente " +CRLF
		EndIf

		If aBrwPEG[I,7] <> aBrwPEG[I,8] .and. aBrwPEG[I,8] >= 0 
           cMensSist +="                         A T E N Ç Ã O  " +CRLF+" Titulo Com Baixa Parcial ,valor de Origem Diferente do Saldo " +CRLF
		EndIf

/*	
		oGet2:refresh()
		oGet28:refresh()
		oGet6:refresh()

		oGet161:refresh()
		oGet65:refresh()
		oGet31:refresh()
		oget250:refresh()
*/
    
	fMostTela1(aBrwPEG[I,8],trim(aBrwPEG[I,15]),i)
	

	oDlg:End()     

	EndIf

Next 

	If  Len(adadosTit) > 0
	    fEnvEmail()
    EndIf

    MsgAlert("ATENÇÃO! PROCESSO DE APROVAÇÃO ENCERRADO ! OPERAÇÃO ENCERRADA !")

Return

static Function fMostTela1(nSaldo,cVisto, i )

/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±± Declaração de Variaveis Private dos Objetos                             ±±
Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/
SetPrvt("oDlg1881","oGrp1","oSay2","oSay6","oSay28","oGet2","oGet6","oBtn1","oBtn2","oGet28","oBtn3")
SetPrvt("oSay7","oSay8","oSay9","oSay10","oSay15","oSay16","oGet7","oGet8","oGet9","oGet10","oGet15")
SetPrvt("oCBox1","oGrp3","oGrp4","oSay3","oSay4","oSay5","oSay11","oSay12","oSay13","oSay1","oSay31")
SetPrvt("oGet4","oGet5","oGet11","oGet12","oGet13","oGet1","oGet31","oGrp5","oSay14","oSay17","oSay18")
SetPrvt("oSay20","oSay21","oSay22","oSay23","oGet14","oGet17","oGet18","oGet19","oGet20","oGet21","oGet22")
SetPrvt("oGrp6","oSay24","oSay25","oSay26","oSay27","oSay29","oSay30","oSay32","oSay33","oGet24","oGet25")
SetPrvt("oGet27","oGet29","oGet30","oGet32","oGet33","oGrp8","oSay34","oSay35","oSay36","oSay37","oSay38")
SetPrvt("oSay40","oSay41","oGet34","oGet35","oGet36","oGet37","oGet38","oGet39","oGet40","oGet41","oGrp9")
SetPrvt("oSay43","oSay44","oSay45","oSay46","oSay47","oSay48","oSay49","oGet42","oGet43","oGet44","oGet45")
SetPrvt("oGet47","oGet48","oGet49","oGrp10","oSay50","oSay51","oSay52","oSay53","oSay54","oSay55","oSay56")
SetPrvt("oGet50","oGet51","oGet52","oGet53","oGet54","oGet55","oGet56","oGet57","oGrp7","oMGet1","oGrp11")
SetPrvt("oSay59","oSay60","oSay61","oSay62","oSay63","oSay64","oSay65","oGet58","oGet59","oGet60","oGet61")
SetPrvt("oGet63","oGet64","oGet65","oGrp12","oSay66","oSay67","oSay68","oSay69","oSay70","oSay71","oSay72")
SetPrvt("oGet66","oGet67","oGet68","oGet69","oGet70","oGet71","oGet72","oGet73","oGrp13","oSay74","oSay75")
SetPrvt("oSay77","oSay78","oSay79","oSay80","oSay81","oGet74","oGet75","oGet76","oGet77","oGet78","oGet79")
SetPrvt("oGet81","oGrp14","oSay82","oSay83","oSay84","oSay85","oSay86","oSay87","oSay88","oSay89","oGet82")
SetPrvt("oGet84","oGet85","oGet86","oGet87","oGet88","oGet89","oGrp15","oSay90","oSay91","oSay92","oSay93")
SetPrvt("oSay95","oSay96","oSay97","oGet90","oGet91","oGet92","oGet93","oGet94","oGet95","oGet96","oGet97")
SetPrvt("oSay98","oSay99","oSay100","oSay101","oSay102","oSay103","oSay104","oSay105","oGet98","oGet99")
SetPrvt("oGet101","oGet102","oGet103","oGet104","oGet105","oGrp17","oSay106","oSay107","oSay108","oSay109")
SetPrvt("oSay111","oSay112","oSay113","oGet106","oGet107","oGet108","oGet109","oGet110","oGet111","oGet112")
SetPrvt("oGrp18","oSay114","oSay115","oSay116","oSay117","oSay118","oSay119","oSay120","oSay121","oGet114")
SetPrvt("oGet116","oGet117","oGet118","oGet119","oGet120","oGet121","oGrp19","oSay122","oSay123","oSay124")
SetPrvt("oSay126","oSay127","oSay128","oSay129","oGet122","oGet123","oGet124","oGet125","oGet126","oGet127")
SetPrvt("oGet129","oGrp20","oSay130","oSay131","oSay132","oSay133","oSay134","oSay135","oSay136","oSay137")
SetPrvt("oGet131","oGet132","oGet133","oGet134","oGet135","oGet136","oGet137","oGrp21","oSay138","oSay139")
SetPrvt("oSay141","oSay142","oSay143","oSay144","oSay145","oGet138","oGet139","oGet140","oGet141","oGet142")
SetPrvt("oGet144","oGet145","oGrp22","oSay146","oSay147","oSay148","oSay149","oSay150","oSay151","oSay152")
SetPrvt("oGet146","oGet147","oGet148","oGet149","oGet150","oGet151","oGet152","oGet153","oGrp23","oSay154")
SetPrvt("oSay156","oSay157","oSay158","oSay159","oSay160","oSay161","oGet154","oGet155","oGet156","oGet157")
SetPrvt("oGet159","oGet160","oGet161","oGrp24","oSay162","oSay163","oSay164","oSay165","oSay166","oSay167")
SetPrvt("oSay169","oGet162","oGet163","oGet164","oGet165","oGet166","oGet167","oGet168","oGet169","oGrp25")
SetPrvt("oSay171","oSay172","oSay173","oSay174","oSay175","oSay176","oSay177","oGet170","oGet171","oGet172")
SetPrvt("oGet174","oGet175","oGet176","oGet177","oGrp26","oSay178","oSay179","oSay180","oSay181","oSay182")
SetPrvt("oSay184","oSay185","oGet178","oGet179","oGet180","oGet181","oGet182","oGet183","oGet184","oGet185")
SetPrvt("oSay186","oSay187","oSay188","oSay189","oSay190","oSay191","oSay192","oSay193","oGet186","oGet187")
SetPrvt("oGet189","oGet190","oGet191","oGet192","oGet193","oGrp28","oSay194","oSay195","oSay196","oSay197")
SetPrvt("oSay199","oSay200","oSay201","oGet194","oGet195","oGet196","oGet197","oGet198","oGet199","oGet200")
SetPrvt("oGrp29","oSay202","oSay203","oSay204","oSay205","oSay206","oSay207","oSay208","oSay209","oGet202")
SetPrvt("oGet204","oGet205","oGet206","oGet207","oGet208","oGet209","oGrp30","oSay210","oSay211","oSay212")
SetPrvt("oSay214","oSay215","oSay216","oSay217","oGet210","oGet211","oGet212","oGet213","oGet214","oGet215")
SetPrvt("oGet217","oGrp31","oSay218","oSay219","oSay220","oSay221","oSay222","oSay223","oSay224","oSay225")
SetPrvt("oGet219","oGet220","oGet221","oGet222","oGet223","oGet224","oGet225","oGrp32","oSay226","oSay227")
SetPrvt("oSay229","oSay230","oSay231","oSay232","oSay233","oGet226","oGet227","oGet228","oGet229","oGet230")
SetPrvt("oGet232","oGet233","oGrp33","oSay234","oSay235","oSay236","oSay237","oSay238","oSay239","oSay240")
SetPrvt("oGet234","oGet235","oGet236","oGet237","oGet238","oGet239","oGet240","oGet241","oGrp34","oSay242")
SetPrvt("oSay244","oSay245","oSay246","oSay247","oSay248","oSay250","oSay251","oSay252","oGet242","oGet243","oGet244","oGet245")
SetPrvt("oGet247","oGet248","oGet250","oGet251","oGet252")

/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±± Definicao do Dialog e todos os seus componentes.                        ±±
Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/
oDlg1881   := MSDialog():New( 104,381,642,1197,"AUTORIZAÇÃO DE PAGAMENTOS DE FOLHA DE PAGAMENTOS E BENEFICIOS",,,.F.,,,,,,.T.,,,.T. )
/*
oGrp1      := TGroup():New( 000,000,052,400,"Dados da Liberação ",oDlg1881,CLR_BLUE,CLR_WHITE,.T.,.F. )
oSay2      := TSay():New( 012,005,{||"Tipo de Pagamento "},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,059,008)
oSay6      := TSay():New( 012,349,{||"Valor Total Liberado "},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLUE,CLR_WHITE,047,008)
oSay28     := TSay():New( 012,282,{||"Data de Pagamento"},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLUE,CLR_WHITE,047,008)
oSay251    := TSay():New( 012,232,{||"Competencia"},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)

oGet2      := TGet():New( 020,004,{|u| If(PCount()>0,cTipoAtu:=u,cTipoAtu)},oGrp1,216,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cTipoAtu",,)
oGet28     := TGet():New( 020,280,{|u| If(PCount()>0,dDataAtu:=u,dDataAtu)},oGrp1,049,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.T.,,.T.,.F.,"","dDataAtu",,)

oGet6      := TGet():New( 020,344,{|u| If(PCount()>0,nVlrAtu:=u,nVlrAtu)},oGrp1,052,008,'@E 9,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrAtu",,)
oGet251    := TGet():New( 020,232,{|u| If(PCount()>0,cCompt0:=u,cCompt0)},oGrp1,032,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.T.,,.T.,.F.,"","cCompt0",,)

oBtn1      := TButton():New( 036,008,"Autoriza",oGrp1,{||fFazlib(i),oDlg1881:End()},060,012,,,,.T.,,"",,,,.F. )
oBtn3      := TButton():New( 037,170,"Demonstrar ",oGrp1,,060,012,,,,.T.,,"",,,,.F. )
oBtn2      := TButton():New( 037,332,"Sair ",oGrp1,{||oDlg1881:End()},060,012,,,,.T.,,"",,,,.F. )
*/
oGrp1      := TGroup():New( 000,000,052,400,"Dados da Liberação ",oDlg1881,CLR_BLUE,CLR_WHITE,.T.,.F. )
oSay2      := TSay():New( 012,005,{||"Tipo de Pagamento "},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,059,008)
oSay6      := TSay():New( 012,349,{||"Valor Da Liberado "},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLUE,CLR_WHITE,047,008)
oSay28     := TSay():New( 012,234,{||"Data de Pagamento"},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLUE,CLR_WHITE,047,008)
oSay251    := TSay():New( 012,184,{||"Competencia"},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay252    := TSay():New( 012,306,{||"Valor Total  "},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLUE,CLR_WHITE,030,008)
oGet2      := TGet():New( 020,004,{|u| If(PCount()>0,cTipoAtu:=u,cTipoAtu)},oGrp1,172,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cTipoAtu",,)
oGet6      := TGet():New( 020,344,{|u| If(PCount()>0,nVlrAtu:=u,nVlrAtu)},oGrp1,052,008,'@E 9,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrAtu",,)
oBtn1      := TButton():New( 036,008,"Autoriza",oGrp1,{||fFazlib(i),oDlg1881:End()},060,012,,,,.T.,,"",,,,.F. )
oBtn2      := TButton():New( 037,332,"Sair ",oGrp1,{||oDlg1881:End()},060,012,,,,.T.,,"",,,,.F. )
oGet28     := TGet():New( 020,232,{|u| If(PCount()>0,dDataAtu:=u,dDataAtu)},oGrp1,049,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.T.,,.T.,.F.,"","dDataAtu",,)
oBtn3      := TButton():New( 037,170,"Demonstrar ",oGrp1,,060,012,,,,.T.,,"",,,,.F. )
oGet251    := TGet():New( 020,184,{|u| If(PCount()>0,cCompt0:=u,cCompt0)},oGrp1,032,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.T.,,.T.,.F.,"","cCompt0",,)
oGet252    := TGet():New( 020,285,{|u| If(PCount()>0,nVlrTot:=u,nVlrTot)},oGrp1,052,008,'@E 9,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrTot",,)
oGrp2      := TGroup():New( 056,005,208,105,"Detalhes da Liberação ",oDlg1881,CLR_BLACK,CLR_WHITE,.T.,.F. )

oGrp2      := TGroup():New( 056,005,208,105,"Detalhes da Liberação",oDlg1881,CLR_RED,CLR_WHITE,.T.,.F. )
oSay7      := TSay():New( 064,012,{||"Quantidade"},oGrp2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,072,008)
oSay8      := TSay():New( 085,012,{||"Valor Liberado"},oGrp2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,059,008)
oSay9      := TSay():New( 106,012,{||"Inss Patronal (se Hover)"},oGrp2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,059,008)
oSay10     := TSay():New( 147,012,{||"Irrf Retitido (se hover)"},oGrp2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,059,008)
oSay15     := TSay():New( 168,012,{||"Inss Retitido (se houver)"},oGrp2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,059,008)
oSay16     := TSay():New( 127,012,{||"Fundo de Garantia (se hover)"},oGrp2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,073,008)
oSay250    := TSay():New( 198,013,{||"Percentil Evolutivo"},oGrp2,,,.F.,.F.,.F.,.T.,CLR_RED,CLR_WHITE,044,008)

oGet7      := TGet():New( 072,012,{|u| If(PCount()>0,nQtda0:=u,nQtda0)},oGrp2,057,008,'@E 99,999',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nQtda0",,)
oGet8      := TGet():New( 093,012,{|u| If(PCount()>0,nVlrLib0:=u,nVlrLib0)},oGrp2,060,008,'@E 9,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrLib0",,)
oGet9      := TGet():New( 114,012,{|u| If(PCount()>0,nInssPat0:=u,nInssPat0)},oGrp2,060,008,'@E 9,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nInssPat0",,)
oGet10     := TGet():New( 155,012,{|u| If(PCount()>0,nIrrfRet0:=u,nIrrfRet0)},oGrp2,060,008,'@E 9,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nIrrfRet0",,)
oGet15     := TGet():New( 176,012,{|u| If(PCount()>0,nInssRet0:=u,nInssRet0)},oGrp2,060,008,'@E 9,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nInssRet0",,)
oGet16     := TGet():New( 135,012,{|u| If(PCount()>0,nFundGrt0:=u,nFundGrt0)},oGrp2,060,008,' @E 9,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nFundGrt0",,)
//oCBox1     := TCheckBox():New( 192,017,"CONFERENCIA",{|u| If(PCount()>0,lConf:=u,lConf)},oGrp2,048,008,,,,,CLR_GREEN,CLR_WHITE,,.T.,"",, )

//oGet250    := TGet():New( 196,061,{|u| If(PCount()>0,nEvolu0:=u,nEvolu0)},oGrp2,024,008,'@E 999.99%',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nEvolu0",,)

oGrp3      := TGroup():New( 056,108,064,400,"Evolução das Ultimas  3 Comptetencias",oDlg1881,CLR_BLUE,CLR_WHITE,.T.,.F. )

oGrp4      := TGroup():New( 066,114,209,201,"Detalhes da Liberação",oDlg1881,CLR_BLACK,CLR_WHITE,.T.,.F. )
oSay3      := TSay():New( 089,121,{||"Quantidade"},oGrp4,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,072,008)
oSay4      := TSay():New( 107,121,{||"Valor Liberado"},oGrp4,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,059,008)
oSay5      := TSay():New( 124,121,{||"Inss Patronal (se Hover)"},oGrp4,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,059,008)
oSay11     := TSay():New( 161,121,{||"Irrf Retitido (se hover)"},oGrp4,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,059,008)
oSay12     := TSay():New( 179,121,{||"Inss Retitido (se houver)"},oGrp4,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,059,009)
oSay13     := TSay():New( 142,121,{||"Fundo de Garantia (se hover)"},oGrp4,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,075,009)
oSay1      := TSay():New( 200,122,{||"Percentil Evolutivo"},oGrp4,,,.F.,.F.,.F.,.T.,CLR_RED,CLR_WHITE,044,008)
oSay31     := TSay():New( 072,121,{||"Competencia "},oGrp4,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,036,008)
oGet3      := TGet():New( 097,121,{|u| If(PCount()>0,nQtda1:=u,nQtda1)},oGrp4,057,008,'@E 99,999',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nQtda1",,)
oGet4      := TGet():New( 114,121,{|u| If(PCount()>0,nVlrLib1:=u,nVlrLib1)},oGrp4,060,008,'@E 9,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrLib1",,)
oGet5      := TGet():New( 132,121,{|u| If(PCount()>0,nInssPat1:=u,nInssPat1)},oGrp4,060,008,'@E 9,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nInssPat1",,)
oGet11     := TGet():New( 169,121,{|u| If(PCount()>0,nIrrfRet1:=u,nIrrfRet1)},oGrp4,060,008,'@E 9,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nIrrfRet1",,)
oGet12     := TGet():New( 187,121,{|u| If(PCount()>0,nInssRet1:=u,nInssRet1)},oGrp4,060,008,'@E 9,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nInssRet1",,)
oGet13     := TGet():New( 150,121,{|u| If(PCount()>0,nFundGrt1:=u,nFundGrt1)},oGrp4,060,008,' @E 9,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nFundGrt1",,)
oGet1      := TGet():New( 198,170,{|u| If(PCount()>0,nEvolu1:=u,nEvolu1)},oGrp4,024,008,'@E 999.99%',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nEvolu1",,)
oGet31     := TGet():New( 079,121,{|u| If(PCount()>0,cCompt1:=u,cCompt1)},oGrp4,032,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cCompt1",,)


oGrp7      := TGroup():New( 212,000,260,400,"Mensagem do Sistema",oDlg1881,CLR_RED,CLR_WHITE,.T.,.F. )
oMGet1     := TMultiGet():New( 220,004,{|u| If(PCount()>0,cMensSist:=u,cMensSist)},oGrp7,392,036,,,CLR_BLACK,CLR_WHITE,,.T.,"",,,.F.,.F.,.T.,,,.F.,,  )
oGrp11     := TGroup():New( 066,211,209,298,"Detalhes da Liberação",oDlg1881,CLR_BLACK,CLR_WHITE,.T.,.F. )
oSay58     := TSay():New( 089,218,{||"Quantidade"},oGrp11,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,072,008)
oSay59     := TSay():New( 107,218,{||"Valor Liberado"},oGrp11,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,059,008)
oSay60     := TSay():New( 124,218,{||"Inss Patronal (se Hover)"},oGrp11,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,059,008)
oSay61     := TSay():New( 161,218,{||"Irrf Retitido (se hover)"},oGrp11,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,059,008)
oSay62     := TSay():New( 179,218,{||"Inss Retitido (se houver)"},oGrp11,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,059,009)
oSay63     := TSay():New( 142,218,{||"Fundo de Garantia (se hover)"},oGrp11,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,075,009)
oSay64     := TSay():New( 200,219,{||"Percentil Evolutivo"},oGrp11,,,.F.,.F.,.F.,.T.,CLR_RED,CLR_WHITE,044,008)
oSay65     := TSay():New( 072,218,{||"Competencia "},oGrp11,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,036,008)
oGet58     := TGet():New( 097,218,{|u| If(PCount()>0,nQtda2:=u,nQtda2)},oGrp11,057,008,'@E 99,999',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nQtda2",,)
oGet59     := TGet():New( 114,218,{|u| If(PCount()>0,nVlrLib2:=u,nVlrLib2)},oGrp11,060,008,'@E 9,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrLib2",,)
oGet60     := TGet():New( 132,218,{|u| If(PCount()>0,nInssPat2:=u,nInssPat2)},oGrp11,060,008,'@E 9,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nInssPat2",,)
oGet61     := TGet():New( 169,218,{|u| If(PCount()>0,nIrrfRet2:=u,nIrrfRet2)},oGrp11,060,008,'@E 9,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nIrrfRet2",,)
oGet62     := TGet():New( 187,218,{|u| If(PCount()>0,nInssRet2:=u,nInssRet2)},oGrp11,060,008,'@E 9,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nInssRet2",,)
oGet63     := TGet():New( 150,218,{|u| If(PCount()>0,nFundGrt2:=u,nFundGrt2)},oGrp11,060,008,' @E 9,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nFundGrt2",,)
oGet64     := TGet():New( 198,267,{|u| If(PCount()>0,nEvolu2:=u,nEvolu2)},oGrp11,024,008,'@E 999.99%',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nEvolu2",,)
oGet65     := TGet():New( 079,218,{|u| If(PCount()>0,cCompt2:=u,cCompt2)},oGrp11,032,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cCompt2",,)

oGrp23     := TGroup():New( 067,307,210,394,"Detalhes da Liberação",oDlg1881,CLR_BLACK,CLR_WHITE,.T.,.F. )
oSay154    := TSay():New( 090,314,{||"Quantidade"},oGrp23,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,072,008)
oSay155    := TSay():New( 108,314,{||"Valor Liberado"},oGrp23,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,059,008)
oSay156    := TSay():New( 125,314,{||"Inss Patronal (se Hover)"},oGrp23,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,059,008)
oSay157    := TSay():New( 162,314,{||"Irrf Retitido (se hover)"},oGrp23,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,059,008)
oSay158    := TSay():New( 180,314,{||"Inss Retitido (se houver)"},oGrp23,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,059,009)
oSay159    := TSay():New( 143,314,{||"Fundo de Garantia (se hover)"},oGrp23,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,075,009)
oSay160    := TSay():New( 201,315,{||"Percentil Evolutivo"},oGrp23,,,.F.,.F.,.F.,.T.,CLR_RED,CLR_WHITE,044,008)
oSay161    := TSay():New( 073,314,{||"Competencia "},oGrp23,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,036,008)
oGet154    := TGet():New( 098,314,{|u| If(PCount()>0,nQtda3:=u,nQtda3)},oGrp23,057,008,'@E 99,999',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nQtda3",,)
oGet155    := TGet():New( 115,314,{|u| If(PCount()>0,nVlrLib3:=u,nVlrLib3)},oGrp23,060,008,'@E 9,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrLib3",,)
oGet156    := TGet():New( 133,314,{|u| If(PCount()>0,nInssPat3:=u,nInssPat3)},oGrp23,060,008,'@E 9,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nInssPat3",,)
oGet157    := TGet():New( 170,314,{|u| If(PCount()>0,nIrrfRet3:=u,nIrrfRet3)},oGrp23,060,008,'@E 9,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nIrrfRet3",,)
oGet158    := TGet():New( 188,314,{|u| If(PCount()>0,nInssRet3:=u,nInssRet3)},oGrp23,060,008,'@E 9,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nInssRet3",,)
oGet159    := TGet():New( 151,314,{|u| If(PCount()>0,nFundGrt3:=u,nFundGrt3)},oGrp23,060,008,' @E 9,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nFundGrt3",,)
oGet160    := TGet():New( 198,363,{|u| If(PCount()>0,nEvolu3:=u,nEvolu3)},oGrp23,024,008,'@E 999.99%',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nEvolu3",,)
oGet161    := TGet():New( 080,314,{|u| If(PCount()>0,cCompt3:=u,cCompt3)},oGrp23,032,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cCompt3",,)

	If nSaldo <= 0  .OR. trim(cVisto) <> '0' .OR. !lCertif  
		oBtn1:DISABLE()  
	EndIf

oDlg1881:Activate(,,,.T.)
oMGet1:SetFocus
   
Return(.T.)

Static Function  fCertif(cTip ,dDataAtu, nValor  )

for i:=1 to 5
    IncProc('Certificando titulos a serem Liberados ....')
next             
      
cQuery1 := " Select rc1_venrea ,rc1_tipo  , sum(rc1_valor) " 
cQuery1 += CRLF + "  from RC1010 RC1  "
cQuery1 += CRLF + " where rc1_filial = ' ' "
cQuery1 += CRLF + "   and d_E_L_E_T_ = ' ' "

cQuery1 += CRLF + "   AND RC1_TIPO   = '"+cTip+"'" 
cQuery1 += CRLF + "   and rc1_venrea = '"+dDataAtu+"'"

//cQuery1 += CRLF + "   and rc1_venrea like '"+cAno+cmes+"%' "
cQuery1 += CRLF + "   having sum(rc1_valor) =  "+ trim(str(nValor))
cQuery1 += CRLF + " group by rc1_venrea ,rc1_tipo "
cQuery1 += CRLF + " order by rc1_venrea ,rc1_tipo "


TcQuery cQuery1 New Alias (cAliasTMP1)  

(cAliasTMP1)->(dbGoTop())    

return !(cAliasTMP1)->(EOF())


/*
Select decode(TRIM(rc1_tipo),'TX','PIS',rc1_tipo)  , sum(rc1_valor)  
  from RC1010 RC1  
 where rc1_filial = ' ' 
   and d_E_L_E_T_ = ' ' 
   and rc1_venrea like '202102%' 
 group by Decode(TRIM(rc1_tipo),'TX','PIS',rc1_tipo) 
*/