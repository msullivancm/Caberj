#Define CRLF Chr(13)+Chr(10)
#include "PROTHEUS.CH"                                                                                                                                
#INCLUDE "TOPCONN.ch"
#INCLUDE "PLSMGER.CH"                                                                                   
#Include "Ap5Mail.Ch"      
#Include 'Tbiconn.ch'           
#INCLUDE 'RWMAKE.CH'
#INCLUDE 'FONT.CH'
#INCLUDE 'COLORS.CH'

/*--------------------------------------------------------------------------
| Programa  | CABA188  | Autor | Altamiro	Affonso    | Data | 19/06/2020  |
|---------------------------------------------------------------------------|              
| Descricao | Alcadas de liberação de folha de pagamento e beneficios       |
|           |                                                               |                                                       
|---------------------------------------------------------------------------|
| Uso       | Alcadas de liberação de folha de pagamento                    |                                   
 --------------------------------------------------------------------------*/

User Function CABA188()
                                                 
Private  nI := 0          

Private _cUsuario:= SubStr(cUSUARIO,7,15)
Private _cIdUsuar:= RetCodUsr()
private _UserLog := _cIdUsuar

//Private _cIdUsuar := '000081'
//private ctitulos11  := ctitulos1

private cDthr       := (dtos(DATE()) + "-" + Time())       
 
private aTitRecPag	:= {}
private adadosTit   := {}   
private aDadSE1     := {}

Private cAliastmp    := GetNextAlias()
Private cAliastmp1 	 := GetNextAlias()
Private cAliastmp2 	 := GetNextAlias()      
Private cAliastmp3 	 := GetNextAlias()
Private cAliastmp4 	 := GetNextAlias()    
Private cAliastmp5 	 := GetNextAlias()    
Private cAliastmp6 	 := GetNextAlias() 
Private cAliastmp7 	 := GetNextAlias() 
Private cAliastmp8 	 := GetNextAlias() 
Private cAliastmp9 	 := GetNextAlias() 

Private cQuery        := " "   
Private cQuery1       := " "  
Private cQuery2       := " "  
Private cQuery3       := " "  
Private cQuery4       := " "   
Private cQuery5       := " "   
Private cQuery6       := " "  
Private cQuery7       := " "
Private cQuery8       := " "
Private cQuery9       := " "

private cEmp          := ' ' 
private cMes          := ' '
private cAno          := ' '
private cPrefT        := ' ' 
private cNumtT        := ' '
private cTipoT        := ' '
private cVend         := ' '
private lflagMM       :=.F.
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

Private cPerg	    := "CABA188"     
 
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

PRIVATE cAno        := ' ' 
private cMes        := ' ' 
private cMostLib    := 1 
private cAnoMais    := ' ' 
private cMesMais    := ' '

private cAnoMenos   := ' '
private cMesMenos   := ' '

private cAnoMenos1  := ' '
private cMesMenos1  := ' '

private cAnoMenos2  := ' '
private cMesMenos2  := ' '

private cAnoMenos3  := ' '
private cMesMenos3  := ' '

private cAnoMenos7  := ' '
private cMesMenos7  := ' '

private cAnoMen13  := ' '
private cMesMen13  := ' '

Private cttitpgto   :=' '   

Private oOk      	:= LoadBitMap(GetResources(),"LBOK")
Private oNo      	:= LoadBitMap(GetResources(),"LBNO")

Private oVerde   	:= LoadBitMap(GetResources(),"ENABLE")
Private oAzul   	:= LoadBitMap(GetResources(),"BR_AZUL")    
Private oAmarelo	:= LoadBitMap(GetResources(),"BR_AMARELO")
Private oVermelho	:= LoadBitMap(GetResources(),"BR_VERMELHO")

PRIVATE cCadastro	:= "Aprovação de Folha e Beneficios  "

PRIVATE aCdCores	:= { 	{ 'BR_VERDE'    ,'Aprovado     ' },; 
							{ 'BR_AZUl'     ,'Pago         ' },;							
							{ 'BR_AMARELO'  ,'Não Aprovado ' },;
							{ 'BR_VERMELHO' ,'Visialização ' }}

PRIVATE aRotina	:=	{	{ "Legenda"		, 'U_LEG188'	    , 0, K_Incluir		} }	

Private cComptMais  := ' ' 
Private cComptMenos := ' '
Private cTipo       := ' ' 
Private cTipo1       := ' ' 

/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±± Declaração de cVariable dos componentes                                 ±±
Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/
Private cMensSist 
Private oSay_131   := Space(1)
Private oSay_132   := Space(1)
Private oSay_133   := Space(1)
Private cSayFer1   := Space(1)
Private oSayFer2   := Space(1)
Private oSayFer3   := Space(1)
Private oSayFgts1  := Space(1)
Private oSayFgts2  := Space(1)
Private oSayFgts3  := Space(1)
Private cSayFol1   := Space(1)
Private oSayFol2   := Space(1)
Private oSayFol3   := Space(1)
Private oSayInss1  := Space(1)
Private oSayInss2  := Space(1)
Private oSayInss3  := Space(1)
Private oSayIr1    := Space(1)
Private oSayIr2    := Space(1)
Private oSayIr3    := Space(1)
Private oSayPen1   := Space(1)
Private oSayPen2   := Space(1)
Private oSayPen3   := Space(1)
Private oSayPis1   := Space(1)
Private oSayPis2   := Space(1)
Private oSayPis3   := Space(1)
Private oSayRes1   := Space(1)
Private oSayRes2   := Space(1)
Private oSayRes3   := Space(1)
Private oSaySod1   := Space(1)
Private oSaySod2   := Space(1)
Private oSaySod3   := Space(1)
Private oSayVTan1  := Space(1)
Private oSayVTan2  := Space(1)
Private oSayVTan3  := Space(1)
Private cTipoAtu   := Space(1)
Private dDataAtu   := CtoD(" ")

Private nVlr130    := 0
Private nVlr131    := 0
Private nVlr132    := 0
Private nVlr133    := 0

Private nVlrAtu    := 0
Private nVSaldAtu  := 0

Private nVlrFer0   := 0
Private nVlrFer1   := 0
Private nVlrFer2   := 0
Private nVlrFer3   := 0

Private nVlrFgts0  := 0
Private nVlrFgts1  := 0
Private nVlrFgts2  := 0
Private nVlrFgts3  := 0

Private nVlrFol0   := 0
Private nVlrFol1   := 0
Private nVlrFol2   := 0
Private nVlrFol3   := 0

Private nVlrInss0  := 0
Private nVlrInss1  := 0
Private nVlrInss2  := 0
Private nVlrInss3  := 0

Private nVlrIr0    := 0
Private nVlrIr1    := 0
Private nVlrIr2    := 0
Private nVlrIr3    := 0

Private nVlrPen0   := 0
Private nVlrPen1   := 0
Private nVlrPen2   := 0
Private nVlrPen3   := 0

Private nVlrPis0   := 0
Private nVlrPis1   := 0
Private nVlrPis2   := 0
Private nVlrPis3   := 0

Private nVlrResc0  := 0
Private nVlrResc1  := 0
Private nVlrResc2  := 0
Private nVlrResc3  := 0

Private nVlrSodx0  := 0
Private nVlrSodx1  := 0
Private nVlrSodx2  := 0
Private nVlrSodx3  := 0

Private nVlrVTra0  := 0
Private nVlrVTra1  := 0
Private nVlrVTra2  := 0
Private nVlrVTra3  := 0

/////////////////////////////
Private cCompt0    := ' ' 
Private cCompt1    := ' ' 
Private cCompt2    := ' '
Private cCompt3    := ' '
Private cMensSist 
Private cTipoAtu   := ' '
Private dDataAtu   := CtoD(" ")

Private nVlrAtu    := 0
Private nVlrTot    := 0

private dDtvenc    :=' ' 
private cOrgem     :=' ' 
private cTip       := ' ' 

private lCertif    :=.T.
private lfim       := .F.

/////////////////////////////////////

Private nM1312M    := 0
Private nM136M     := 0
Private nMFer12M   := 0
Private nMFer6M    := 0
Private nMFgts12M  := 0
Private nMFgts6M   := 0
Private nMFol12M   := 0
Private nMFol6M    := 0
Private nMInss12M  := 0
Private nMInss6M   := 0
Private nMIr12M    := 0
Private nMIr6M     := 0
Private nMPen12M   := 0
Private nMPen6M    := 0
Private nMPis12M   := 0
Private nMPis6M    := 0
Private nMRes12M   := 0
Private nMRes6M    := 0
Private nMSod12M   := 0
Private nMSod6M    := 0
Private nMVTra12M  := 0
Private nMVTra6M   := 0

/////////////////////////////////////////////fim variaves da tela
/////// Variavel global da aprovação 

PRIVATE cRegSCR    := ' '//SE2->E2_PREFIXO + SE2->E2_NUM + SE2->E2_PARCELA + SE2->E2_TIPO + SE2->E2_FORNECE + SE2->E2_LOJA

Private cGrpApr	:= "909099"		// Grupo novo para ferias do Paulo Vasques "909128"

////////////////////////
Perg188(cPerg)

If Pergunte(cPerg,.T.) == .F.
	Return
Endif 

cAno         := Mv_par01 
cMes         := Mv_par02
cMostLib     := Mv_Par03

If !empty(trim(Mv_Par04))
   _cIdUsuar:=Mv_Par04 
EndIf 

fcompte(cAno , cMes)

fEstatis()

cComptMais  := cAnoMais  +'/'+cMesMais
cComptMenos := cAnoMenos +'/'+cMesMenos

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
                     iif(cMostLib == 1, oVermelho , (IIf(aBrwPEG[oBrwPEG:nAt,8]== 0,oAzul,(IIf(alltrim(aBrwPEG[oBrwPEG:nAt, 15]) != '0',oVerde,oAmarelo)))))  ,;
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

oBrwPEG:nScrollType  := 1 // Scroll VCR+.

lConfirmou 	:= .T.

aBut    :={{"PENDENTE", {||marca(1)                 }	, "Marcar Todos "         , "Marcar Todos"      }}
aAdd(aBut, {"PENDENTE", {||desmarca(1)              }	, "Desmarcar Todos "	  , "Desmarcar Todos"	})   
aAdd(aBut, {"PENDENTE", {||fMostTela()              }   , "Tela de Liberações "   , "Tela de Liberações"})  
aAdd(aBut, {"PENDENTE", {||U_LEG188()               }   , "Legenda "              , "Legenda "          })
aAdd(aBut, {"PENDENTE", {||resumo7()                }	, "Detalhes Folha Empresa", "Detalhes Folha Empresa"})  
aAdd(aBut, {"PENDENTE", {||resumo4()                }	, "Detalhes Folha Diretoria", "Detalhes Folha Diretoria"})  
aAdd(aBut, {"PENDENTE", {||resumo5()                }	, "Detalhes Folha Departamento", "Detalhes Folha Departamento"})
aAdd(aBut, {"PENDENTE", {||resumo6()                }	, "Detalhes Folha Colaborador" , "Detalhes Folha Colaborador"})
aAdd(aBut, {"PENDENTE", {||resumo8()                }	, "Detalhes da Rescisão - por colaborador " , "Detalhes da Rescisão - por colaborador"})
aAdd(aBut, {"PENDENTE", {||resumo9()                }	, "Detalhes da Admissão - por colaborador " , "Detalhes da Admissão - por colaborador"})
aAdd(aBut, {"PENDENTE", {||oDlg:End()               }   , "Sair "                 , "Sair "             })  

lConfirmou := .F.

//bOk 	:= {||fSequen() , oBrwPEG:Refresh() , oBrwPEG:Refresh() ,oDlg:End()   }    
 
bOk 	:= {|| fMostTela() , oDlg:End()  }    
 
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
             
/// consulta principal 

cQryPEG :="        select DECODE(SUBSTR(E2_ORIGEM,1,4) ,'GPEM' , 'FOLHA','COMPAS') ORIGEM , " 
cQryPEG += CRLF + "       DECODE(E2_TIPO,'FGT' , 'FUNDO DE GARANTIA' , " 
cQryPEG += CRLF + "       'FOL' , 'FOLHA DE PAGAMENTO' , "
cQryPEG += CRLF + "       'PEN' , 'PENSÃO ALIMENTICIA' , " 
cQryPEG += CRLF + "       'RES' , 'RESCISÃO', "
cQryPEG += CRLF + "       'IRF' , 'IMPOSTO DE RENDA' ,  " 
cQryPEG += CRLF + "       'FER' , 'FERIAS' , "
cQryPEG += CRLF + "       'TX ' , 'PIS' , "
cQryPEG += CRLF + "       'INS' , 'INSS', "
cQryPEG += CRLF + "       'NF ' , TRIM(E2_NOMFOR) , 'NAO IDENTIFICADO') TIPO , "
cQryPEG += CRLF + "       trim( Substr(E2_VENCREA,7,2)||'/'||Substr(E2_VENCREA,5,2)||'/'||Substr(E2_VENCREA,1,4)) VencRea , "
cQryPEG += CRLF + "       trim(Substr(E2_EMISSAO,7,2)||'/'||Substr(E2_EMISSAO,5,2)||'/'||Substr(E2_EMISSAO,1,4)) Emissao , "                            
//cQryPEG += CRLF + "       trim(Substr(E2_EMISSAO,7,2)||'/'||Substr(E2_VENCREA,5,2)||'/'||Substr(E2_VENCREA,1,4)) Emissao , " 
cQryPEG += CRLF + "       trim(Substr(E2_BAIXA  ,7,2)||'/'||Substr(E2_BAIXA  ,5,2)||'/'||Substr(E2_BAIXA  ,1,4)) Baixa   , "                            
cQryPEG += CRLF + "       Alc.AK_USER Usuar, Alc.AK_NOME NomUsr, Alc.AL_COD CodAlc , Alc.AL_DESC DescAlc , decode(Alc.AL_LIBAPR, 'V', 'Vista', 'Aprova') Lib , Alc.AL_USERSUP AprSup , "
cQryPEG += CRLF + "       Alc.AK_LIMMIN LIMMIN, Alc.AK_LIMMAX LIMMAX ,"
cQryPEG += CRLF + "       sum(se2.E2_VALOR) valor , sum(se2.e2_saldo) saldo , decode( nvl(pdt.pdt_num, '0'),'0','0','1') TEMPDT , "
cQryPEG += CRLF + "       E2_TIPO E2TIPO "

cQryPEG += CRLF + "  from se2010 SE2 , pdt010 pdt , "
cQryPEG += CRLF + "       (SELECT AK_USER , AK_NOME, AL_COD , AL_DESC , AL_LIBAPR , AL_USERSUP , AK_LIMMIN ,AK_LIMMAX , AL_NIVEL"  
cQryPEG += CRLF + "         FROM "+RetSQLName("SAL")+" SAL , "
cQryPEG += CRLF + "              "+RetSQLName("SAK")+" SAK   "
cQryPEG += CRLF + "        WHERE AL_FILIAL  = '" + xFilial('SAL') + "'  AND SAL.D_E_L_E_T_ = ' ' " 
cQryPEG += CRLF + "          AND AK_FILIAL  = '" + xFilial('SAK') + "'  AND SAK.D_E_L_E_T_ = ' ' "
cQryPEG += CRLF + "          AND AL_COD = '" + cGrpApr + "' "
cQryPEG += CRLF + "          AND AK_COD = AL_APROV "
cQryPEG += CRLF + "          AND AL_USER = '"+_cIdUsuar+"' ) Alc "

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

if  cMostLib == 2 // controla se vamos ver todos os titulos(1) ou so os que seram liberados (2) 

//    cQryPEG += CRLF + "   and e2_baixa = ' ' "
        
    cQryPEG += CRLF + "   and ((SELECT  COUNT(*) FROM PDT010 PDT1 "  
    cQryPEG += CRLF + "          WHERE PDT1.pdt_filial ='01' and PDT1.d_E_L_E_T_ = ' ' "     
    cQryPEG += CRLF + "            AND pdt1.PDT_PREFIX = se2.e2_prefixo "  
    cQryPEG += CRLF + "            AND pdt1.PDT_NUM    = se2.e2_num     "
    cQryPEG += CRLF + "            AND PDT1.PDT_PARCEL = se2.e2_parcela "  
    cQryPEG += CRLF + "            AND PDT1.PDT_TIPO   = se2.e2_tipo    "
    cQryPEG += CRLF + "            AND PDT1.PDT_FORNEC = se2.e2_fornece "  
	cQryPEG += CRLF + "            and pdt1.pdt_tpapro = 'V' "
    cQryPEG += CRLF + "            and (PDT1.pdt_aprov IN  (SELECT NVL(AK_USER,' ') "
    cQryPEG += CRLF + "                                     FROM SAL010 SAL , SAK010 SAK "    
    cQryPEG += CRLF + "                                    WHERE AL_FILIAL  = '01'  AND SAL.D_E_L_E_T_ = ' ' "   
    cQryPEG += CRLF + "                                      AND AK_FILIAL  = '01'  AND SAK.D_E_L_E_T_ = ' ' "  
    cQryPEG += CRLF + "                                      AND AL_COD = '" + cGrpApr + "'  AND AK_COD = AL_APROV    " 
    cQryPEG += CRLF + "                                      AND AL_USERSUP = '"+_cIdUsuar+"') "
    cQryPEG += CRLF + "            AND PDT1.PDT_modulo = 'FOL') ) > 0 " 
    cQryPEG += CRLF + "    Or alc.al_nivel = '01') "
      
    cQryPEG += CRLF + "   AND (SELECT COUNT(*) FROM PDT010 PDT1   
    cQryPEG += CRLF + "         WHERE PDT1.pdt_filial ='01' and PDT1.d_E_L_E_T_ = ' ' "     
    cQryPEG += CRLF + "           AND pdt1.PDT_PREFIX = se2.e2_prefixo "  
    cQryPEG += CRLF + "           AND pdt1.PDT_NUM    = se2.e2_num     "
    cQryPEG += CRLF + "           AND PDT1.PDT_PARCEL = se2.e2_parcela " 
    cQryPEG += CRLF + "           AND PDT1.PDT_TIPO   = se2.e2_tipo    "
    cQryPEG += CRLF + "           AND PDT1.PDT_FORNEC = se2.e2_fornece "   
    cQryPEG += CRLF + "           and PDT1.pdt_aprov  = '"+_cIdUsuar+"'"     
    cQryPEG += CRLF + "           AND PDT1.PDT_modulo = 'FOL' ) =  0 "

EndIf
 
cQryPEG += CRLF + "   AND ((E2_NOMFOR LIKE '%RIO CARD%' OR E2_NOMFOR LIKE '%SODEX%')OR e2_origem like 'GPE%') "
cQryPEG += CRLF + "   AND (E2_ORIGEM LIKE 'MA%' OR e2_origem like 'GPE%') "

cQryPEG += CRLF + " Group by DECODE(SUBSTR(E2_ORIGEM,1,4) ,'GPEM' , 'FOLHA','COMPAS') , " 
cQryPEG += CRLF + "       DECODE(E2_TIPO,'FGT' , 'FUNDO DE GARANTIA' , " 
cQryPEG += CRLF + "       'FOL' , 'FOLHA DE PAGAMENTO' , "
cQryPEG += CRLF + "       'PEN' , 'PENSÃO ALIMENTICIA' , " 
cQryPEG += CRLF + "       'RES' , 'RESCISÃO' , "
cQryPEG += CRLF + "       'IRF' , 'IMPOSTO DE RENDA' ,  " 
cQryPEG += CRLF + "       'FER' , 'FERIAS' , "
cQryPEG += CRLF + "       'TX ' , 'PIS' , "
cQryPEG += CRLF + "       'INS' , 'INSS', "
cQryPEG += CRLF + "       'NF ' , TRIM(E2_NOMFOR) , 'NAO IDENTIFICADO') , "
cQryPEG += CRLF + "       Substr(E2_VENCREA,7,2)||'/'||Substr(E2_VENCREA,5,2)||'/'||Substr(E2_VENCREA,1,4) , "
cQryPEG += CRLF + "       trim(Substr(E2_EMISSAO,7,2)||'/'||Substr(E2_EMISSAO,5,2)||'/'||Substr(E2_EMISSAO,1,4)) , "                            
cQryPEG += CRLF + "       Substr(E2_BAIXA  ,7,2)||'/'||Substr(E2_BAIXA  ,5,2)||'/'||Substr(E2_BAIXA  ,1,4) , "                            
cQryPEG += CRLF + "       Alc.AK_USER , Alc.AK_NOME , Alc.AL_COD , Alc.AL_DESC , decode(Alc.AL_LIBAPR, 'V', 'Vista', 'Aprova') , Alc.AL_USERSUP , decode( nvl(pdt.pdt_num, '0'),'0','0','1')  , e2_tipo , "
cQryPEG += CRLF + "       Alc.AK_LIMMIN , Alc.AK_LIMMAX "

cQryPEG += CRLF + " Order by 2,4"

If Select((cAliasPEG)) <> 0 
   (cAliasPEG)->(DbCloseArea())  
Endif      

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

 //aAdd(aRetPEG,{iif((cAliasPEG)->Saldo == 0, .F. ,(Iif(trim((cAliasPEG)->TEMPDT) == '0',.T.,.F.) ))        ,;    //1
 aAdd(aRetPEG,{iif(cMostLib == 1 ,.F., (iif((cAliasPEG)->Saldo == 0, .F. ,(Iif(trim((cAliasPEG)->TEMPDT) == '0',.T.,.F.) ))))        ,;    //1
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

local cObs    := 'Liberado pela Rotina Caba188'


If  _UserLog != _cIdUsuar

    MsgAlert("               ATENÇÃO!!!"+ CRLF + CRLF + ;
	         "   Usuario logado("+_UserLog+") Diferente do Usuario cadastrado("+_cIdUsuar+") !!!"+ CRLF + CRLF +;
		     "                  Operação Não sera Realizada !!!")

    Return()
EndIf 


nPagto := 0
      
cQuery :="        select DECODE(SUBSTR(E2_ORIGEM,1,4) ,'GÀPEM' , 'FOLHA','COMPAS') ORIGEM , " 
cQuery += CRLF + "       DECODE(E2_TIPO,'FGT' , 'FUNDO DE GARANTIA' , " 
cQuery += CRLF + "       'FOL' , 'FOLHA DE PAGAMENTO' , "
cQuery += CRLF + "       'PEN' , 'PENSÃO ALIMENTICIA' , " 
cQuery += CRLF + "       'RES' , 'RESCISÃO' , "
cQuery += CRLF + "       'IRF' , 'IMPOSTO DE RENDA' ,  " 
cQuery += CRLF + "       'FER' , 'FERIAS' , "
cQuery += CRLF + "       'TX '  , 'PIS' , "
cQuery += CRLF + "       'INS' , 'INSS', "
cQuery += CRLF + "       'NF '  , TRIM(E2_NOMFOR) , 'NAO IDENTIFICADO') TIPO , "
cQuery += CRLF + "       trim( Substr(E2_VENCREA,7,2)||'/'||Substr(E2_VENCREA,5,2)||'/'||Substr(E2_VENCREA,1,4)) VencRea , "
cQuery += CRLF + "       trim(Substr(E2_EMISSAO,7,2)||'/'||Substr(E2_EMISSAO,5,2)||'/'||Substr(E2_EMISSAO,1,4)) Emissao , "                            
cQuery += CRLF + "       trim(Substr(E2_BAIXA  ,7,2)||'/'||Substr(E2_BAIXA  ,5,2)||'/'||Substr(E2_BAIXA  ,1,4)) Baixa   , "                            
cQuery += CRLF + "       Alc.AK_USER Usuar, Alc.AK_NOME NomUsr, Alc.AL_COD CodAlc , Alc.AL_DESC DescAlc , decode(Alc.AL_LIBAPR, 'V', 'Vista', 'Aprova') Lib , Alc.AL_USERSUP AprSup ,  AL_LIBAPR LIBAPR ,"
cQuery += CRLF + "       Alc.AK_LIMMIN LIMMIN, Alc.AK_LIMMAX LIMMAX , ALC.AL_APROV APROV ,"
cQuery += CRLF + "       (se2.E2_VALOR) valor , (se2.e2_saldo) saldo , decode( nvl(pdt.pdt_num, '0'),'0','0','1') TEMPDT ,  "
 
cQuery += CRLF + "       se2.e2_prefixo prefixo , se2.e2_num num , se2.e2_parcela parcela , se2.e2_tipo e2tipo , se2.e2_fornece fornece , se2.e2_loja loja , se2.e2_nomfor nomfor , se2.R_E_C_N_O_ controle " 

cQuery += CRLF + "  from se2010 SE2 , pdt010 pdt , "
cQuery += CRLF + "       (SELECT AK_USER , AK_NOME, AL_COD , AL_DESC , AL_LIBAPR , AL_USERSUP , AK_LIMMIN ,AK_LIMMAX , AL_NIVEL , AL_APROV "  
cQuery += CRLF + "         FROM "+RetSQLName("SAL")+" SAL , "
cQuery += CRLF + "              "+RetSQLName("SAK")+" SAK   "
cQuery += CRLF + "        WHERE AL_FILIAL  = '" + xFilial('SAL') + "'  AND SAL.D_E_L_E_T_ = ' ' " 
cQuery += CRLF + "          AND AK_FILIAL  = '" + xFilial('SAK') + "'  AND SAK.D_E_L_E_T_ = ' ' "
cQuery += CRLF + "          AND AL_COD = '" + cGrpApr + "' "
cQuery += CRLF + "          AND AK_COD = AL_APROV "
cQuery += CRLF + "          AND AL_USER = '"+_cIdUsuar+"' ) Alc "

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

if  cMostLib == 2 // controla se vamos ver todos os titulos(1) ou so os que seram liberados (2) 

//    cQuery += CRLF + "   and e2_baixa = ' ' "
        
    cQuery += CRLF + "   and ((SELECT  COUNT(*) FROM PDT010 PDT1 "  
    cQuery += CRLF + "          WHERE PDT1.pdt_filial ='01' and PDT1.d_E_L_E_T_ = ' ' "     
    cQuery += CRLF + "            AND pdt1.PDT_PREFIX = se2.e2_prefixo "  
    cQuery += CRLF + "            AND pdt1.PDT_NUM    = se2.e2_num     "
    cQuery += CRLF + "            AND PDT1.PDT_PARCEL = se2.e2_parcela "  
    cQuery += CRLF + "            AND PDT1.PDT_TIPO   = se2.e2_tipo    "
    cQuery += CRLF + "            AND PDT1.PDT_FORNEC = se2.e2_fornece "  
	cQuery += CRLF + "            and pdt1.pdt_tpapro = 'V' "
    cQuery += CRLF + "            and (PDT1.pdt_aprov IN  (SELECT NVL(AK_USER,' ') "
    cQuery += CRLF + "                                     FROM SAL010 SAL , SAK010 SAK "    
    cQuery += CRLF + "                                    WHERE AL_FILIAL  = '01'  AND SAL.D_E_L_E_T_ = ' ' "   
    cQuery += CRLF + "                                      AND AK_FILIAL  = '01'  AND SAK.D_E_L_E_T_ = ' ' "  
    cQuery += CRLF + "                                      AND AL_COD = '" + cGrpApr + "'  AND AK_COD = AL_APROV    " 
    cQuery += CRLF + "                                      AND AL_USERSUP = '"+_cIdUsuar+"') "
    cQuery += CRLF + "            AND PDT1.PDT_modulo = 'FOL') ) > 0 " 
    cQuery += CRLF + "    Or alc.al_nivel = '01') "

    cQuery += CRLF + "   AND (SELECT COUNT(*) FROM PDT010 PDT1   
    cQuery += CRLF + "         WHERE PDT1.pdt_filial ='01' and PDT1.d_E_L_E_T_ = ' ' "     
    cQuery += CRLF + "           AND pdt1.PDT_PREFIX = se2.e2_prefixo "  
    cQuery += CRLF + "           AND pdt1.PDT_NUM    = se2.e2_num     "
    cQuery += CRLF + "           AND PDT1.PDT_PARCEL = se2.e2_parcela " 
    cQuery += CRLF + "           AND PDT1.PDT_TIPO   = se2.e2_tipo    "
    cQuery += CRLF + "           AND PDT1.PDT_FORNEC = se2.e2_fornece "   
    cQuery += CRLF + "           and PDT1.pdt_aprov  = '"+_cIdUsuar+"'"     
    cQuery += CRLF + "           AND PDT1.PDT_modulo = 'FOL' ) =  0 "

EndIf
 
cQuery += CRLF + "   AND ((E2_NOMFOR LIKE '%RIO CARD%' OR E2_NOMFOR LIKE '%SODEX%')OR e2_origem like 'GPE%') "
cQuery += CRLF + "   AND (E2_ORIGEM LIKE 'MA%' OR e2_origem like 'GPE%') "

cQuery += CRLF + "   AND DECODE(SUBSTR(E2_ORIGEM,1,4) ,'GPEM' , 'FOLHA','COMPAS') = '"+TRIM(aBrwPEG[I,3])+"'"
cQuery += CRLF + "   and DECODE(E2_TIPO,'FGT' , 'FUNDO DE GARANTIA' , " 
cQuery += CRLF + "       'FOL' , 'FOLHA DE PAGAMENTO' , "
cQuery += CRLF + "       'PEN' , 'PENSÃO ALIMENTICIA' , " 
cQuery += CRLF + "       'RES' , 'RESCISÃO'           , "
cQuery += CRLF + "       'IRF' , 'IMPOSTO DE RENDA'   , " 
cQuery += CRLF + "       'FER' , 'FERIAS' , "
cQuery += CRLF + "       'TX ' , 'PIS'    , "
cQuery += CRLF + "       'INS' , 'INSS'   , "
cQuery += CRLF + "       'NF ' ,  TRIM(E2_NOMFOR) , 'NAO IDENTIFICADO') = '"+TRIM(aBrwPEG[I,18])+"'"
cQuery += CRLF + "   AND E2_VENCREA            = '"+dDtvenc+"'"
//cQuery += CRLF + "   AND E2_SALDO              > 0 "

cQuery += CRLF + "   AND E2_emissao            = '"+substr(aBrwPEG[I,05],7,4)+substr(aBrwPEG[I,05],4,2)+substr(aBrwPEG[I,05],1,2)+"'"
//cQuery += CRLF + "   AND E2_emissao            = '"+dtos(stod(TRIM(aBrwPEG[I,05])))+"'"

//cQuery += CRLF + "   AND E2_emissao            = '"+cDataEmis+"'"

cQuery += CRLF + "   AND E2_TIPO               = '"+TRIM(aBrwPEG[I,17])+"'"

cQuery += CRLF + " Order by 2,4"

/*
cQuery += CRLF + "  from se2010 SE2 , pdt010 pdt , "
cQuery += CRLF + "       (SELECT AK_USER , AK_NOME, AL_COD , AL_DESC , AL_LIBAPR , AL_USERSUP , AK_LIMMIN ,AK_LIMMAX , AL_APROV "  
cQuery += CRLF + "         FROM "+RetSQLName("SAL")+" SAL , "
cQuery += CRLF + "              "+RetSQLName("SAK")+" SAK   "
cQuery += CRLF + "        WHERE AL_FILIAL  = '" + xFilial('SAL') + "'  AND SAL.D_E_L_E_T_ = ' ' " 
cQuery += CRLF + "          AND AK_FILIAL  = '" + xFilial('SAK') + "'  AND SAK.D_E_L_E_T_ = ' ' "
cQuery += CRLF + "          AND AL_COD = '" + cGrpApr + "' "
cQuery += CRLF + "          AND AK_COD = AL_APROV "
cQuery += CRLF + "          AND AL_USER = '"+_cIdUsuar+"' ) Alc   "

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


cQuery += CRLF + "   AND ((E2_NOMFOR LIKE '%RIO CARD%' OR E2_NOMFOR LIKE '%SODEX%')OR e2_origem like 'GPE%') "
cQuery += CRLF + "   AND (E2_ORIGEM LIKE 'MA%' OR e2_origem like 'GPE%') "

cQuery += CRLF + "   AND DECODE(SUBSTR(E2_ORIGEM,1,4) ,'GPEM' , 'FOLHA','COMPAS') = '"+TRIM(aBrwPEG[I,3])+"'"
cQuery += CRLF + "   and DECODE(E2_TIPO,'FGT' , 'FUNDO DE GARANTIA' , " 
cQuery += CRLF + "       'FOL' , 'FOLHA DE PAGAMENTO' , "
cQuery += CRLF + "       'PEN' , 'PENSÃO ALIMENTICIA' , " 
cQuery += CRLF + "       'RES' , 'RESCISÃO'           , "
cQuery += CRLF + "       'IRF' , 'IMPOSTO DE RENDA'   ,  " 
cQuery += CRLF + "       'FER' , 'FERIAS' , "
cQuery += CRLF + "       'TX ' , 'PIS'    , "
cQuery += CRLF + "       'INS' , 'INSS'   , "
cQuery += CRLF + "       'NF ' ,  TRIM(E2_NOMFOR) , 'NAO IDENTIFICADO') = '"+TRIM(aBrwPEG[I,18])+"'"
cQuery += CRLF + "   AND E2_VENCREA            = '"+dDtvenc+"'"
cQuery += CRLF + "   AND E2_SALDO              > 0 "
cQuery += CRLF + "   AND E2_TIPO               = '"+TRIM(aBrwPEG[I,17])+"'"
*/
                              
If Select((cAliastmp)) <> 0 
   (cAliastmp)->(DbCloseArea())  
Endif      

TcQuery cQuery New Alias (cAliastmp)  

(cAliastmp)->(dbGoTop())    

DBSELECTAREA("PDT")   
PDT->(dbSetOrder(1))

While !(cAliastmp)->(EOF())
	 
    //If  (cAliastmp)->LIMMIN >= (cAliastmp)->SALDO .AND. (cAliastmp)->LIMMAX <= (cAliastmp)->SALDO
    If  (cAliastmp)->LIMMIN <= (cAliastmp)->valor .AND. (cAliastmp)->LIMMAX >= (cAliastmp)->valor

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

             //Funcao que cria(monta) os registros do SCR

        cRegSCR := (cAliastmp)->prefixo + (cAliastmp)->num + (cAliastmp)->parcela + (cAliastmp)->e2tipo + (cAliastmp)->fornece + (cAliastmp)->loja  

		cObs:= 'Liberado pela Rotina Caba188'

	    If  cAcao   == 'A'		 
		    
			cObs:= 'Liberado pela Rotina Caba188'

        EndIf 

        U_fscr(cRegSCR , (cAliastmp)->APROV , cAcao , 'FL', cObs )

//		If cResp = 'S'	
//			lLiberou := MaAlcDoc({SCR->CR_NUM,SCR->CR_TIPO,nTotal,cCodApr,,cGrupo,,,,,cObs},dDataBase,If(cResp=='S',4,6))
//			CONOUT("LIBEROU")
/*
		    cObs:= 'Liberado pela Rotina Caba188'

	    If  cAcao   == 'A'		 
		    
			cObs:= 'Liberado pela Rotina Caba188'

	    	StMaAlcDoc:= MaAlcDoc({cRegSCR, "FL", (cAliastmp)->VALOR,(cAliastmp)->APROV,, (cAliastmp)->CodAlc ,,,,dDataBase, cObs}, dDataBase, If(cAcao== 'A',4,1) )   
           
                MsgAlert("             A T E N Ç Ã O  !!!"+ CRLF + CRLF + ;
	                  "  Titulo "+ cRegSCR +" Foi Aprovação !!!") 

			Else 
			    MsgAlert("             A T E N Ç Ã O  !!!"+ CRLF + CRLF + ;
	                     "  Titulo "+ cRegSCR +" Não Foi Aprovação !!!" + ;
					     "    Verifique a aprovação do Titulos !!!")		  
            EndIf 
			

		Else 

            cObs:= 'Vistado pela Rotina Caba188'

		    StMaAlcDoc:= MaAlcDoc({cRegSCR, "FL", (cAliastmp)->VALOR,(cAliastmp)->APROV,, (cAliastmp)->CodAlc ,,,,dDataBase, cObs}, dDataBase, If(cAcao== 'A',4,1) )   
		    
			    MsgAlert("             A T E N Ç Ã O  !!!"+ CRLF + CRLF + ;
	                     "  Titulo "+ cRegSCR +" Foi Vistado !!!")

			Else 
			    MsgAlert("             A T E N Ç Ã O  !!!"+ CRLF + CRLF + ;
	                     "  Titulo "+ cRegSCR +" Não Foi Vistado !!!" + ;
					     "    Verifique o Visto do Titulos !!!")		  
            EndIf
        

		EndIf	
*/

    If  cAcao   == 'A'  // 'A' - ALTERAR QUANDO FOR PARA PRODUÇÃO OU TESTE PILOTO
    
	    aaDD(aDadostit ,{(cAliastmp)->Prefixo    ,;
		                 (cAliastmp)->Num        ,;                                                          
		                 (cAliastmp)->parcela    ,;                                                                                 
		                 (cAliastmp)->e2tipo       ,; 
						 Transform((cAliastmp)->Saldo,'@E  99,999,999.99'),;                                                                           
		                 (cAliastmp)->FORNECE    ,;
		                 (cAliastmp)->Usuar      ,;
						 (cAliastmp)->NomUsr     ,;
		                 cAcao ,;
						 cTipoAtu })     

    Else

        If (nAscan:=Ascan(adadosTit , {|e| e[1]+e[2]+e[3]+e[4] == cTipoAtu + (cAno+cmes) + dDataAtu + (Transform(nVlrTot,'@E  99,999,999.99'))})) == 0    

			aaDD(aDadostit,{cTipoAtu    ,;
							cAno+cmes   ,;
							dDataAtu    ,;
							Transform(nVlrTot,'@E  99,999,999.99'),;                                                                           
							Transform(nVlrAtu,'@E  99,999,999.99'),;
							(cAliastmp)->Usuar      ,;
							(cAliastmp)->NomUsr     ,;
							cAcao  })

        EndIf 

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
_cMensagem +=  Chr(13) + Chr(10) + Chr(13) + Chr(10) + "Foi Aprovado(s) ou Vistado(s) os Pagamento(s) abaixo identifiado(s) : "
//_cMensagem +=  Chr(13) + Chr(10) + Chr(13) + Chr(10) + "Foi Aprovado(s) ou Vistados os Pagamento(s) do(s) Titulo(s) abaixo identifiado(s) : "
_cMensagem +=  Chr(13) + Chr(10)

for i:=1 to  len(adadosTit) 

    if adadosTit [I,8]  = 'V'

		_cMensagem +=  Chr(13) + Chr(10) + " Tipo          : "+ adadosTit [I,1] + " "  + adadosTit [I,2] +" " + adadosTit [I,3] + " " + adadosTit [I,4]  
		_cMensagem +=  Chr(13) + Chr(10) + " Competencia   : "+ adadosTit [I,2] 
		_cMensagem +=  Chr(13) + Chr(10) + " Vencimento    : "+ adadosTit [I,3] 
		_cMensagem +=  Chr(13) + Chr(10) + " Vlr Base      : "+ adadosTit [I,4]  
		_cMensagem +=  Chr(13) + Chr(10) + " Saldo         : "+ adadosTit [I,5] 
		_cMensagem +=  Chr(13) + Chr(10) + " Vistador      : "+ adadosTit [I,7]+ " - " + adadosTit [I,7] 
		_cMensagem +=  Chr(13) + Chr(10) + " Ação          : "+ Iif(adadosTit [I,8]=='A', 'Aprovação','Visto') 
		_cMensagem +=  Chr(13) + Chr(10) +  "________________________________________________________________________________"   

    Else 
        _cMensagem +=  Chr(13) + Chr(10) + " Tipo          : "+ adadosTit [I,10]
		_cMensagem +=  Chr(13) + Chr(10) + " Ident. Titulo : "+ adadosTit [I,1] + " "  + adadosTit [I,2] +" " + adadosTit [I,3] + " " + adadosTit [I,4]  
		_cMensagem +=  Chr(13) + Chr(10) + " Saldo         : "+ adadosTit [I,5] 
		_cMensagem +=  Chr(13) + Chr(10) + " Fornecedor    : "+ adadosTit [I,6] + " - " + POSICIONE("SA2",1,xFilial("SA2") + adadosTit [I,6],"A2_NOME")
		_cMensagem +=  Chr(13) + Chr(10) + " Aprovador     : "+ adadosTit [I,7] + " - " + adadosTit [I,8] 
		_cMensagem +=  Chr(13) + Chr(10) + " Ação          : "+ Iif(adadosTit [I,9]=='A', 'Aprovação','Visto') 
		_cMensagem +=  Chr(13) + Chr(10) +  "________________________________________________________________________________"   

    EndIf 
Next 

_cMensagem +=  Chr(13) + Chr(10)
_cMensagem +=  Chr(13) + Chr(10)

_cMensagem +=  Chr(13) + Chr(10) + "Para sua Ciencia."
if _cIdUsuar == '000521'
//   cDest+= "wesley.santos@caberj.com.br;"
//elseIf  _cIdUsuar == '001616'
//   cDest+= "paulovasques@caberj.com.br"
EndIf    

cDest+= "altamiro@caberj.com.br  "
//cDest+= "altamiro@caberj.com.br  ; piumbim@caberj.com.br"
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
  
	cAnoMenos    := Iif (cMes == '01',strZero(val(cAno)-1,4),cAno)
	cMesMenos    := Iif (cMes == '01','12' ,strZero(val(cMes)-1,2))
	cAnoMais     := Iif (cMes == '12',strZero(val(cAno)+1,4),cAno) 
	cMesMais     := Iif (cMes == '12','01' ,strZero(val(cMes)+1,2)) 

	cAnoMenos1   := Iif (cMes == '01',strZero(val(cAno)-1,4),cAno)
	cMesMenos1   := Iif (cMes == '01','12' ,strZero(val(cMes)-1,2))

	cAnoMenos2   := Iif (cMes $  '01|02',strZero(val(cAno)-1,4),cAno)
	cMesMenos2   := Iif (cMes == '02','12' ,(Iif(cMes == '01','11' ,strZero(val(cMes)-2,2))))

	cAnoMenos3   := Iif (cMes $  '01|02|03',strZero(val(cAno)-1,4),cAno)
	cMesMenos3   := Iif (cMes == '03','12' ,Iif (cMes == '02','11' ,(Iif(cMes == '01','10' ,strZero(val(cMes)-3,2)))))

    cAnoMen13  := Iif (cMes ==  '01',strZero(val(cAno)-2,4),strZero(val(cAno)-1,4))
	cMesMen13  := Iif (cMes == '01','12' ,strZero(val(cMes),2))

	cAnoMenos7   := Iif (cMes $  '01|02|03|04|05|06|',strZero(val(cAno)-1,4),strZero(val(cAno),4))
	if  val(cMes) >= 7
    	cMesMenos7   := strZero(val(cMes)-6,2)
	ElseIf val(cMes) == 6
    	cMesMenos7   := '12'
	ElseIf val(cMes) == 5
    	cMesMenos7   := '11'
	ElseIf val(cMes) == 4
    	cMesMenos7   := '10'
	ElseIf val(cMes) == 3
    	cMesMenos7   := '09'
	ElseIf val(cMes) == 2
    	cMesMenos7   := '08'
	ElseIf val(cMes) == 1
    	cMesMenos7   := '07'
	EndIf	 		 	
Return()

User Function LEG188()

Local aLegenda

	aLegenda 	:= { 	{ aCdCores[1,1],aCdCores[1,2] },;
						{ aCdCores[2,1],aCdCores[2,2] },;
	              		{ aCdCores[3,1],aCdCores[3,2] },;
						{ aCdCores[4,1],aCdCores[4,2] } }

	                     	
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

cMensSist :=" As comparações das 3 ultimas competencias fechadas são calculadas sempre sobre a competencia Anteror, como base" + CRLF 
cMensSist +=" As proporções das medias de 6 meses e 12 meses obedecem as faixas : entre 90% a 110% Verde , abaixo de 90% Azul , acima de 110% vermelho" + CRLF 
cMensSist +="    em Referencia a primeira competencia fechada" + CRLF + CRLF 
For I := 1 to len(aBrwPEG)

lCertif    :=.T.
			
	If  aBrwPEG[I,1] == .T.    

        cTipoAtu := trim(aBrwPEG[I,3]) + ' - ' + trim(aBrwPEG[I,4])
        dDataAtu := aBrwPEG[I,6]
        nVlrAtu  := aBrwPEG[I,7]
		nVlrTot  := aBrwPEG[I,7]
        nVSaldAtu:= aBrwPEG[I,8]
        dDtvenc  :=substr(dDataAtu,7,4)+substr(dDataAtu,4,2)+substr(dDataAtu,1,2)
        cOrgem   :=aBrwPEG[I,3]
        cTip     := aBrwPEG[I,13]
		
		cDataEmis:= substr(aBrwPEG[I,05],7,4)+substr(aBrwPEG[I,05],4,2)+substr(aBrwPEG[I,05],1,2)

        cCompt3  :=cAnoMenos3+'/'+cMesMenos3
        cCompt2  :=cAnoMenos2+'/'+cMesMenos2
        cCompt1  :=cAnoMenos1+'/'+cMesMenos1
        cCompt0  :=cAno+'/'+cMes

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

			If  fCertif(trim(aBrwPEG[I,17]) ,dDtvenc , nVlrTot )
				If aBrwPEG[I,7] == nVlrTot 
			       cMensSist +="Liberação Foi   C E R T I F I C A D A   , Valor do Titulo a Pagar é Igual aos registrados no sistema de Folha de Pagamento " + CRLF + CRLF
				   lCertif    :=.T.
				Else 
				   cMensSist +="Liberação NÂO Foi   C E R T I F I C A D A   , Valor do Titulo a Pagar no Financeiro é" + Transform(aBrwPEG[I,7],'@E 9.999,999.99') +" e o Valor no sistema de Folha de Pagamento é "+ Transform(nVlrTot,'@E 9.999,999.99') + CRLF + CRLF
			  	   lCertif    :=.F.
				EndIf
			Else 
				cMensSist +="Liberação NÂO Foi   C E R T I F I C A D A   , Titulos Não registrados no sistema de Folha de Pagamento " + CRLF + CRLF
				lCertif    :=.F.
			EndIf
		EndIf 

		If aBrwPEG[I,8] <= 0 .and. trim(aBrwPEG[I,15]) == '0'
		   cMensSist +="Titulo foi Baixado , Não pode ser Liberdo" +CRLF
		   lCertif   :=.F.
        EndIf

		If trim(aBrwPEG[I,15]) <> '0'
		   cMensSist +=" Titulo Liberado por você  , Não pode ser liberdo Novamente " +CRLF
		   lCertif   :=.F.
		EndIf

		If aBrwPEG[I,7] <> aBrwPEG[I,8] .and. aBrwPEG[I,8] > 0 .and. trim(aBrwPEG[I,15]) = '0' 
		   cMensSist +="                         A T E N Ç Ã O  " +CRLF+" Titulo Com Baixa Parcial ,valor de Origem Diferente do Saldo " +CRLF
		   lCertif   :=.T.
		EndIf

	fMostTela1(aBrwPEG[I,8],trim(aBrwPEG[I,15]),i)
	
	EndIf

Next 

	If  Len(adadosTit) > 0
	   
	    fEnvEmail()
	   
    EndIf

    MsgAlert("             A T E N Ç Ã O  !!!"+ CRLF + CRLF + ;
	         "   Fim do Processo desta Aprovação !!!"+ CRLF + CRLF +;
		     "  Se desejar Inicie nova Aprovalçao !!!")
oDlg:End()

Return


//////////////////////CERTIFICAÇÃO ///////////////////////
Static Function  fCertif(cTipoCer ,dDataAtu, nValor  )

local lRet:= .T.

for x :=1 to 5
    IncProc('Certificando titulos a serem Liberados ....')
next             
      
cQuery1 := " Select rc1_venrea ,rc1_tipo  , sum(rc1_valor) " 
cQuery1 += CRLF + "  from RC1010 RC1  "
cQuery1 += CRLF + " where rc1_filial = ' ' "
cQuery1 += CRLF + "   and d_E_L_E_T_ = ' ' "

cQuery1 += CRLF + "   AND RC1_TIPO   = '"+cTipoCer+"'" 
cQuery1 += CRLF + "   and rc1_venrea = '"+dDataAtu+"'"

cQuery1 += CRLF + "   having sum(rc1_valor) =  "+ trim(str(nValor))
cQuery1 += CRLF + " group by rc1_venrea ,rc1_tipo "
cQuery1 += CRLF + " order by rc1_venrea ,rc1_tipo "

If Select((cAliastmp1)) <> 0 
   (cAliastmp1)->(DbCloseArea())  
Endif      

TcQuery cQuery1 New Alias (cAliasTMP1)  

(cAliasTMP1)->(dbGoTop())    

If (cAliasTMP1)->(EOF())
   (cAliastmp1)->(DbCloseArea())
	
	cQuery3 := " Select rc1_venrea ,rc1_tipo  , rc1_valor " 
	cQuery3 += CRLF + "  from RC1010 RC1  "
	cQuery3 += CRLF + " where rc1_filial = ' ' "
	cQuery3 += CRLF + "   and d_E_L_E_T_ = ' ' "

	cQuery3 += CRLF + "   AND RC1_TIPO   = '"+cTipoCer+"'" 
	cQuery3 += CRLF + "   and rc1_venrea = '"+dDataAtu+"'"

	cQuery3 += CRLF + "   and rc1_valor =  "+ trim(str(nValor)) "
	
		If Select((cAliastmp3)) <> 0 
		(cAliastmp3)->(DbCloseArea())  
		Endif      

		TcQuery cQuery3 New Alias (cAliasTMP3)  

		(cAliasTMP3)->(dbGoTop())    

		If (cAliasTMP3)->(EOF())
           lRet:=.F.
		EndIf 
		(cAliastmp3)->(DbCloseArea())
EndIf		   

return (lRet)

///////////////////////////// ESTATISTICA ///////
Static Function  fEstatis()

Local nVlrEdt := 0.00

 cCompt0 := cAno+'/'+cMes   
 cCompt1 := cAnoMenos1+'/'+cMesMenos1     
 cCompt2 := cAnoMenos2+'/'+cMesMenos2    
 cCompt3 := cAnoMenos3+'/'+cMesMenos3   

for i:=1 to 55
    IncProc('Certificando titulos a serem Liberados ....')
next             

cQuery2 :=        "  Select 0 clas, decode(TRIM(rc1_tipo),'TX','PIS','131','13','132','13',rc1_tipo)  tipo , substr(rc1_venrea,1,6) compte   , sum(rc1_valor) valor " 
cQuery2 += CRLF + "    from RC1010 RC1 , SE2010 SE2 "
cQuery2 += CRLF + "   where rc1_filial = ' '  and RC1.d_E_L_E_T_ = ' ' "

cQuery2 += CRLF + "     AND E2_filial  = '01' and SE2.d_E_L_E_T_ = ' ' "
cQuery2 += CRLF + "     AND E2_PREFIXO = RC1_PREFIX"
cQuery2 += CRLF + "     AND E2_NUM     = RC1_NUMTIT"
cQuery2 += CRLF + "     AND E2_TIPO    = RC1_TIPO" 

cQuery2 += CRLF + "     and rc1_venrea like '"+cAno+cMes+"%' "
cQuery2 += CRLF + "   group by decode(TRIM(rc1_tipo),'TX','PIS','131','13','132','13',rc1_tipo) , substr(rc1_venrea,1,6) " 

cQuery2 += CRLF + " union " 

cQuery2 += CRLF + "  Select 1 clas ,decode(TRIM(rc1_tipo),'TX','PIS','131','13','132','13',rc1_tipo)  titpo  , substr(rc1_venrea,1,6) compte   , sum(rc1_valor) valor  " 
cQuery2 += CRLF + "    from RC1010 RC1  , SE2010 SE2 "
cQuery2 += CRLF + "   where rc1_filial = ' ' and RC1.d_E_L_E_T_ = ' ' "

cQuery2 += CRLF + "     AND E2_filial  = '01' and SE2.d_E_L_E_T_ = ' ' "
cQuery2 += CRLF + "     AND E2_PREFIXO = RC1_PREFIX"
cQuery2 += CRLF + "     AND E2_NUM     = RC1_NUMTIT"
cQuery2 += CRLF + "     AND E2_TIPO    = RC1_TIPO" 


cQuery2 += CRLF + "     and rc1_venrea like '"+cAnoMenos1+cMesMenos1+"%' " 
cQuery2 += CRLF + "   group by decode(TRIM(rc1_tipo),'TX','PIS','131','13','132','13',rc1_tipo) , substr(rc1_venrea,1,6) "  

cQuery2 += CRLF + " union "

cQuery2 += CRLF + " Select 2 clas ,decode(TRIM(rc1_tipo),'TX','PIS','131','13','132','13',rc1_tipo) tipo , substr(rc1_venrea,1,6) compte   , sum(rc1_valor) valor  "
cQuery2 += CRLF + "   from RC1010 RC1 , SE2010 SE2"
cQuery2 += CRLF + "  where rc1_filial = ' '  and RC1.d_E_L_E_T_ = ' ' "

cQuery2 += CRLF + "     AND E2_filial  = '01' and SE2.d_E_L_E_T_ = ' ' "
cQuery2 += CRLF + "     AND E2_PREFIXO = RC1_PREFIX"
cQuery2 += CRLF + "     AND E2_NUM     = RC1_NUMTIT"
cQuery2 += CRLF + "     AND E2_TIPO    = RC1_TIPO" 

cQuery2 += CRLF + "     and rc1_venrea like '"+cAnoMenos2+cMesMenos2+"%' " 
cQuery2 += CRLF + "   group by decode(TRIM(rc1_tipo),'TX','PIS','131','13','132','13',rc1_tipo), substr(rc1_venrea,1,6) "  

cQuery2 += CRLF + " union "

cQuery2 += CRLF + "  Select 3 clas ,decode(TRIM(rc1_tipo),'TX','PIS','131','13','132','13',rc1_tipo) tipo , substr(rc1_venrea,1,6) compte  , sum(rc1_valor) valor "
cQuery2 += CRLF + "      from RC1010 RC1 , SE2010 SE2 "  
cQuery2 += CRLF + "      where rc1_filial = ' '  and RC1.d_E_L_E_T_ = ' ' "

cQuery2 += CRLF + "     AND E2_filial  = '01' and SE2.d_E_L_E_T_ = ' ' "
cQuery2 += CRLF + "     AND E2_PREFIXO = RC1_PREFIX"
cQuery2 += CRLF + "     AND E2_NUM     = RC1_NUMTIT"
cQuery2 += CRLF + "     AND E2_TIPO    = RC1_TIPO" 

cQuery2 += CRLF + "     and rc1_venrea like '"+cAnoMenos3+cMesMenos3+"%' " 
cQuery2 += CRLF + "   group by decode(TRIM(rc1_tipo),'TX','PIS','131','13','132','13',rc1_tipo), substr(rc1_venrea,1,6) "

cQuery2 += CRLF + " union "

cQuery2 += CRLF + "  Select 6 clas ,decode(TRIM(rc1_tipo),'TX','PIS','131','13','132','13',rc1_tipo) tipo , '"+cAnoMenos7+cMesMenos7+"' compte  , sum(rc1_valor) valor "
cQuery2 += CRLF + "      from RC1010 RC1 , SE2010  SE2 "  
cQuery2 += CRLF + "      where rc1_filial = ' '  and RC1.d_E_L_E_T_ = ' ' "

cQuery2 += CRLF + "     AND E2_filial  = '01' and SE2.d_E_L_E_T_ = ' ' "
cQuery2 += CRLF + "     AND E2_PREFIXO = RC1_PREFIX"
cQuery2 += CRLF + "     AND E2_NUM     = RC1_NUMTIT"
cQuery2 += CRLF + "     AND E2_TIPO    = RC1_TIPO" 

cQuery2 += CRLF + "     and rc1_venrea >= '"+cAnoMenos7+cMesMenos7+"%' and rc1_venrea <= '"+cAnoMenos1+cMesMenos1+"%' " 
cQuery2 += CRLF + "   group by decode(TRIM(rc1_tipo),'TX','PIS','131','13','132','13',rc1_tipo) "

cQuery2 += CRLF + " union "

cQuery2 += CRLF + "  Select 12 clas ,decode(TRIM(rc1_tipo),'TX','PIS','131','13','132','13',rc1_tipo) tipo , '"+cAnoMen13+cMesMen13+"' compte  , sum(rc1_valor) valor "
cQuery2 += CRLF + "      from RC1010 RC1 , SE2010 SE2 "  
cQuery2 += CRLF + "      where rc1_filial = ' '  and RC1.d_E_L_E_T_ = ' ' "

cQuery2 += CRLF + "     AND E2_filial  = '01' and SE2.d_E_L_E_T_ = ' ' "
cQuery2 += CRLF + "     AND E2_PREFIXO = RC1_PREFIX"
cQuery2 += CRLF + "     AND E2_NUM     = RC1_NUMTIT"
cQuery2 += CRLF + "     AND E2_TIPO    = RC1_TIPO" 

cQuery2 += CRLF + "     and rc1_venrea >= '"+cAnoMen13+cMesMen13+"%' and rc1_venrea <= '"+cAnoMenos1+cMesMenos1+"%' " 
cQuery2 += CRLF + "   group by decode(TRIM(rc1_tipo),'TX','PIS','131','13','132','13',rc1_tipo)"

cQuery2 += CRLF + " union "

cQuery2 += CRLF + "   select 0 clas , " 
cQuery2 += CRLF + "          DECODE(E2_TIPO,'NF ' , decode(TRIM(E2_NOMFOR),'RIO CARD', 'RCR', 'SODEXHO' , 'SDX' , 'NAO IDENTIFICADO')) TIPO , "
cQuery2 += CRLF + "          substr(E2_vencrea,1,6) compte , "
cQuery2 += CRLF + "          sum(se2.E2_VALOR) valor " 
cQuery2 += CRLF + "     from se2010 SE2 " 
cQuery2 += CRLF + "    where e2_filial ='01' and se2.d_E_L_E_T_ = ' '  "
cQuery2 += CRLF + "      AND E2_VENCREA  like '"+cAno+cMes+"%' " 
cQuery2 += CRLF + "      AND (E2_NOMFOR LIKE '%RIO CARD%' OR E2_NOMFOR LIKE '%SODEX%') " 
cQuery2 += CRLF + "      AND (E2_ORIGEM LIKE 'MA%' ) "
cQuery2 += CRLF + "    Group by DECODE(E2_TIPO,'NF ' , decode(TRIM(E2_NOMFOR),'RIO CARD', 'RCR', 'SODEXHO' , 'SDX' , 'NAO IDENTIFICADO')), substr(E2_vencrea,1,6) "

cQuery2 += CRLF + " union " 

cQuery2 += CRLF + "   select 1 clas , "
cQuery2 += CRLF + "          DECODE(E2_TIPO,'NF ' , decode(TRIM(E2_NOMFOR),'RIO CARD', 'RCR', 'SODEXHO' , 'SDX' , 'NAO IDENTIFICADO')) TIPO , "
cQuery2 += CRLF + "          substr(E2_vencrea,1,6) compte ," 
cQuery2 += CRLF + "          sum(se2.E2_VALOR) valor "
cQuery2 += CRLF + "     from se2010 SE2 "
cQuery2 += CRLF + "    where e2_filial ='01' and se2.d_E_L_E_T_ = ' ' " 
cQuery2 += CRLF + "      AND E2_VENCREA  like '"+cAnoMenos1+cMesMenos1+"%' "
cQuery2 += CRLF + "      AND (E2_NOMFOR LIKE '%RIO CARD%' OR E2_NOMFOR LIKE '%SODEX%') "
cQuery2 += CRLF + "      AND (E2_ORIGEM LIKE 'MA%' ) "
cQuery2 += CRLF + "    Group by DECODE(E2_TIPO,'NF ' , decode(TRIM(E2_NOMFOR),'RIO CARD', 'RCR', 'SODEXHO' , 'SDX' , 'NAO IDENTIFICADO')), substr(E2_vencrea,1,6) "

cQuery2 += CRLF + " union "

cQuery2 += CRLF + "   select 2 clas, "
cQuery2 += CRLF + "          DECODE(E2_TIPO,'NF ' , decode(TRIM(E2_NOMFOR),'RIO CARD', 'RCR', 'SODEXHO' , 'SDX' , 'NAO IDENTIFICADO')) TIPO , "
cQuery2 += CRLF + "          substr(E2_vencrea,1,6) compte , "
cQuery2 += CRLF + "          sum(se2.E2_VALOR) valor "
cQuery2 += CRLF + "     from se2010 SE2 "
cQuery2 += CRLF + "    where e2_filial ='01' and se2.d_E_L_E_T_ = ' ' "  
cQuery2 += CRLF + "      AND E2_VENCREA  like '"+cAnoMenos2+cMesMenos2+"%'" 
cQuery2 += CRLF + "      AND (E2_NOMFOR LIKE '%RIO CARD%' OR E2_NOMFOR LIKE '%SODEX%') " 
cQuery2 += CRLF + "      AND (E2_ORIGEM LIKE 'MA%' ) "
cQuery2 += CRLF + "    Group by DECODE(E2_TIPO,'NF ' , decode(TRIM(E2_NOMFOR),'RIO CARD', 'RCR', 'SODEXHO' , 'SDX' , 'NAO IDENTIFICADO')), substr(E2_vencrea,1,6) "

cQuery2 += CRLF + " union"

cQuery2 += CRLF + "   select 3 clas , " 
cQuery2 += CRLF + "          DECODE(E2_TIPO,'NF ' , decode(TRIM(E2_NOMFOR),'RIO CARD', 'RCR', 'SODEXHO' , 'SDX' , 'NAO IDENTIFICADO')) TIPO , "
cQuery2 += CRLF + "          substr(E2_vencrea,1,6) compte , "
cQuery2 += CRLF + "          sum(se2.E2_VALOR) valor "
cQuery2 += CRLF + "     from se2010 SE2 "
cQuery2 += CRLF + "    where e2_filial ='01' and se2.d_E_L_E_T_ = ' ' "  
cQuery2 += CRLF + "      AND E2_VENCREA  like '"+cAnoMenos3+cMesMenos3+"%' " 
cQuery2 += CRLF + "      AND (E2_NOMFOR LIKE '%RIO CARD%' OR E2_NOMFOR LIKE '%SODEX%') " 
cQuery2 += CRLF + "      AND (E2_ORIGEM LIKE 'MA%' ) "
cQuery2 += CRLF + "    Group by DECODE(E2_TIPO,'NF ' , decode(TRIM(E2_NOMFOR),'RIO CARD', 'RCR', 'SODEXHO' , 'SDX' , 'NAO IDENTIFICADO')), substr(E2_vencrea,1,6) "

cQuery2 += CRLF + " union"

cQuery2 += CRLF + "   select 6 clas , " 
cQuery2 += CRLF + "          DECODE(E2_TIPO,'NF ' , decode(TRIM(E2_NOMFOR),'RIO CARD', 'RCR', 'SODEXHO' , 'SDX' , 'NAO IDENTIFICADO')) TIPO , "
cQuery2 += CRLF + "          '"+cAnoMenos7+cMesMenos7+"' compte , "
cQuery2 += CRLF + "          sum(se2.E2_VALOR) valor "
cQuery2 += CRLF + "     from se2010 SE2 "
cQuery2 += CRLF + "    where e2_filial ='01' and se2.d_E_L_E_T_ = ' ' "  
cQuery2 += CRLF + "      AND E2_VENCREA >= '"+cAnoMenos7+cMesMenos7+"%' AND E2_VENCREA <= '"+cAnoMenos1+cMesMenos1+"%' " 
cQuery2 += CRLF + "      AND (E2_NOMFOR LIKE '%RIO CARD%' OR E2_NOMFOR LIKE '%SODEX%') " 
cQuery2 += CRLF + "      AND (E2_ORIGEM LIKE 'MA%' ) "
cQuery2 += CRLF + "    Group by DECODE(E2_TIPO,'NF ' , decode(TRIM(E2_NOMFOR),'RIO CARD', 'RCR', 'SODEXHO' , 'SDX' , 'NAO IDENTIFICADO')) "

cQuery2 += CRLF + " union"

cQuery2 += CRLF + "   select 12 clas , " 
cQuery2 += CRLF + "          DECODE(E2_TIPO,'NF ' , decode(TRIM(E2_NOMFOR),'RIO CARD', 'RCR', 'SODEXHO' , 'SDX' , 'NAO IDENTIFICADO')) TIPO , "
cQuery2 += CRLF + "          '"+cAnoMen13+cMesMen13+"' compte , "
cQuery2 += CRLF + "          sum(se2.E2_VALOR) valor "
cQuery2 += CRLF + "     from se2010 SE2 "
cQuery2 += CRLF + "    where e2_filial ='01' and se2.d_E_L_E_T_ = ' ' "  
cQuery2 += CRLF + "      AND E2_VENCREA >= '"+cAnoMen13+cMesMen13+"%' AND E2_VENCREA <= '"+cAnoMenos1+cMesMenos1+"%' " 
cQuery2 += CRLF + "      AND (E2_NOMFOR LIKE '%RIO CARD%' OR E2_NOMFOR LIKE '%SODEX%') " 
cQuery2 += CRLF + "      AND (E2_ORIGEM LIKE 'MA%' ) "
cQuery2 += CRLF + "    Group by DECODE(E2_TIPO,'NF ' , decode(TRIM(E2_NOMFOR),'RIO CARD', 'RCR', 'SODEXHO' , 'SDX' , 'NAO IDENTIFICADO')) "

cQuery2 += CRLF + "   order by  2,1,3 "

If Select((cAliastmp2)) <> 0 
   (cAliasTMP2)->(DbCloseArea())  
Endif      

TcQuery cQuery2 New Alias (cAliastmp2)  


(cAliasTMP2)->(dbGoTop())    

While !(cAliastmp2)->(EOF())

	nVlrEdt := Transform((cAliasTMP2)->valor ,'@E  99,999,999.99')

	if trim((cAliasTMP2)->tipo) == '13'
	
		If (cAliasTMP2)->clas == 0 
			nVlr130    := (cAliasTMP2)->valor 
		ElseIf (cAliasTMP2)->clas == 1 
		    nVlr131    := (cAliasTMP2)->valor
		ElseIf (cAliasTMP2)->clas == 2  
	    	nVlr132    := (cAliasTMP2)->valor   
		ElseIf (cAliasTMP2)->clas == 3 
		    nVlr133    := (cAliasTMP2)->valor
		ElseIf (cAliasTMP2)->clas == 6
		    nM136M	    := ((cAliasTMP2)->valor / 6)
		ElseIf (cAliasTMP2)->clas == 12
		    nM1312M    := ((cAliasTMP2)->valor / 12)	 	   	   		
		EndIf

	ElseIf TRIM((cAliasTMP2)->tipo) == 'FER'
		
		If (cAliasTMP2)->clas == 0 
			nVlrFer0    := (cAliasTMP2)->valor 
		ElseIf (cAliasTMP2)->clas == 1 
			nVlrFer1    := (cAliasTMP2)->valor
		ElseIf (cAliasTMP2)->clas == 2 
			nVlrFer2    := (cAliasTMP2)->valor   
		ElseIf (cAliasTMP2)->clas == 3 
    		nVlrFer3    := (cAliasTMP2)->valor 	   
		ElseIf (cAliasTMP2)->clas == 6
		    nMFer6M	    := ((cAliasTMP2)->valor / 6)
		ElseIf (cAliasTMP2)->clas == 12
		    nMFer12M    := ((cAliasTMP2)->valor / 12)
		EndIf

	ElseIf TRIM((cAliasTMP2)->tipo) == 'FGT'
		
		If (cAliasTMP2)->clas == 0 
			nVlrFgts0    := (cAliasTMP2)->valor 
		ElseIf (cAliasTMP2)->clas == 1 
			nVlrFgts1    := (cAliasTMP2)->valor
		ElseIf (cAliasTMP2)->clas == 2 
			nVlrFgts2    := (cAliasTMP2)->valor   
		ElseIf (cAliasTMP2)->clas == 3 
			nVlrFgts3    := (cAliasTMP2)->valor 	   	   
		ElseIf (cAliasTMP2)->clas == 6
		    nMFgts6M	    := ((cAliasTMP2)->valor / 6)
		ElseIf (cAliasTMP2)->clas == 12
		    nMFgts12M    := ((cAliasTMP2)->valor / 12)
		EndIf

	ElseIf TRIM((cAliasTMP2)->tipo) == 'FOL'
		
		If (cAliasTMP2)->clas == 0 
			nVlrFol0    := (cAliasTMP2)->valor 
		ElseIf (cAliasTMP2)->clas == 1 
			nVlrFol1    := (cAliasTMP2)->valor
		ElseIf (cAliasTMP2)->clas == 2 
			nVlrFol2    := (cAliasTMP2)->valor   
		ElseIf (cAliasTMP2)->clas == 3 
			nVlrFol3    := (cAliasTMP2)->valor
        ElseIf (cAliasTMP2)->clas == 6
		    nMFol6M	    := ((cAliasTMP2)->valor / 6)
		ElseIf (cAliasTMP2)->clas == 12
		    nMFol12M    := ((cAliasTMP2)->valor / 12)	 	   	   
		EndIf

	ElseIf TRIM((cAliasTMP2)->tipo) == 'INS'
		
		If (cAliasTMP2)->clas == 0 
			nVlrInss0    := (cAliasTMP2)->valor 
		ElseIf (cAliasTMP2)->clas == 1 
			nVlrInss1    := (cAliasTMP2)->valor
		ElseIf (cAliasTMP2)->clas == 2 
			nVlrInss2    := (cAliasTMP2)->valor   
		ElseIf (cAliasTMP2)->clas == 3 
			nVlrInss3    := (cAliasTMP2)->valor 	   	   
		ElseIf (cAliasTMP2)->clas == 6
		    nMInss6M	    := ((cAliasTMP2)->valor / 6)
		ElseIf (cAliasTMP2)->clas == 12
		    nMInss12M    := ((cAliasTMP2)->valor / 12)	 	   	   
		EndIf

	ElseIf TRIM((cAliasTMP2)->tipo) == 'IRF'
		
		If (cAliasTMP2)->clas == 0 
			nVlrIr0    := (cAliasTMP2)->valor 
		ElseIf (cAliasTMP2)->clas == 1 
			nVlrIr1    := (cAliasTMP2)->valor
		ElseIf (cAliasTMP2)->clas == 2 
			nVlrIr2    := (cAliasTMP2)->valor   
		ElseIf (cAliasTMP2)->clas == 3 
			nVlrIr3    := (cAliasTMP2)->valor 	   	   
		ElseIf (cAliasTMP2)->clas == 6
		    nMIr6M	    := ((cAliasTMP2)->valor / 6)
		ElseIf (cAliasTMP2)->clas == 12
		    nMIr12M    := ((cAliasTMP2)->valor / 12)	 	   	   
		EndIf


	ElseIf TRIM((cAliasTMP2)->tipo) == 'PEN'
		
		If (cAliasTMP2)->clas == 0 
			nVlrPen0    := (cAliasTMP2)->valor 
		ElseIf (cAliasTMP2)->clas == 1 
			nVlrPen1    := (cAliasTMP2)->valor
		ElseIf (cAliasTMP2)->clas == 2 
			nVlrPen2    := (cAliasTMP2)->valor   
		ElseIf (cAliasTMP2)->clas == 3 
			nVlrPen3    := (cAliasTMP2)->valor 	   	   
		ElseIf (cAliasTMP2)->clas == 6
		    nMPen6M	    := ((cAliasTMP2)->valor / 6)
		ElseIf (cAliasTMP2)->clas == 12
		    nMPen12M    := ((cAliasTMP2)->valor / 12)	 	   	   
		EndIf

	ElseIf TRIM((cAliasTMP2)->tipo) == 'PIS'
		
		If (cAliasTMP2)->clas == 0 
			nVlrPis0    := (cAliasTMP2)->valor 
		ElseIf (cAliasTMP2)->clas == 1 
			nVlrPis1    := (cAliasTMP2)->valor
		ElseIf (cAliasTMP2)->clas == 2 
			nVlrPis2    := (cAliasTMP2)->valor   
		ElseIf (cAliasTMP2)->clas == 3 
			nVlrPis3    := (cAliasTMP2)->valor 	   	   
		ElseIf (cAliasTMP2)->clas == 6
		    nMPis6M	    := ((cAliasTMP2)->valor / 6)
		ElseIf (cAliasTMP2)->clas == 12
		    nMPis12M    := ((cAliasTMP2)->valor / 12)	 	   	   
		EndIf

	ElseIf TRIM((cAliasTMP2)->tipo) == 'RES'
		
		If (cAliasTMP2)->clas == 0 
			nVlrResc0    := (cAliasTMP2)->valor 
		ElseIf (cAliasTMP2)->clas == 1 
			nVlrResc1    := (cAliasTMP2)->valor
		ElseIf (cAliasTMP2)->clas == 2 
			nVlrResc2    := (cAliasTMP2)->valor   
		ElseIf (cAliasTMP2)->clas == 3 
			nVlrResc3    := (cAliasTMP2)->valor 	   	   
		ElseIf (cAliasTMP2)->clas == 6
		    nMRes6M	     := ((cAliasTMP2)->valor / 6)
		ElseIf (cAliasTMP2)->clas == 12
		    nMRes12M     := ((cAliasTMP2)->valor / 12)	 	   	   
		EndIf


	ElseIf TRIM((cAliasTMP2)->tipo) == 'SDX'
		
		If (cAliasTMP2)->clas == 0 
			nVlrSodx0    := (cAliasTMP2)->valor 
		ElseIf (cAliasTMP2)->clas == 1 
			nVlrSodx1    := (cAliasTMP2)->valor
		ElseIf (cAliasTMP2)->clas == 2 
			nVlrSodx2    := (cAliasTMP2)->valor   
		ElseIf (cAliasTMP2)->clas == 3 
			nVlrSodx3    := (cAliasTMP2)->valor 	   	   
        ElseIf (cAliasTMP2)->clas == 6
		    nMSod6M      := ((cAliasTMP2)->valor / 6)
		ElseIf (cAliasTMP2)->clas == 12
		   nMSod12M      := ((cAliasTMP2)->valor / 12)	 	   	   
		EndIf

	ElseIf TRIM((cAliasTMP2)->tipo) == 'RCR'
		
		If (cAliasTMP2)->clas == 0 
			nVlrVTra0    := (cAliasTMP2)->valor 
		ElseIf (cAliasTMP2)->clas == 1 
			nVlrVTra1    := (cAliasTMP2)->valor
		ElseIf (cAliasTMP2)->clas == 2 
			nVlrVTra2    := (cAliasTMP2)->valor   
		ElseIf (cAliasTMP2)->clas == 3 
			nVlrVTra3    := (cAliasTMP2)->valor 	   	   
		ElseIf (cAliasTMP2)->clas == 6
		    nMVTra6M      := ((cAliasTMP2)->valor / 6)
		ElseIf (cAliasTMP2)->clas == 12
		   nMVTra12M      := ((cAliasTMP2)->valor / 12)	 	   	   
		EndIf

	EndIf 

    (cAliasTMP2)->(DbSkip())

EndDo

return ()
 

Static Function fCalcEst()

// 13 salario 

If  nVlr131   != 0
    oSay_131:SetText("  100 %")
	oSay_132:SetText("  100 %")  
Else 	
    oSay_131:SetText("      0 %")
	oSay_132:SetText("      0 %")
EndIF
If nVlr132   == 0
  	oSay_132:SetText("      0 %")
ElseIf  nVlr131   != 0    
        oSay_132:SetText(Transform(((nVlr132/nVlr131*100)),'@E  999,999%'))
    If     (nVlr132/nVlr131*100)/100 > 100 
            oSay_132:SetColor(CLR_RED)
	ElseIf (nVlr132/nVlr131*100)/100 < 100  	 
            oSay_132:SetColor(CLR_BLUE)
    EndIf
Else
    oSay_132:SetText("   100 %")
EndIf
If nVlr133   == 0
	oSay_133:SetText("      0 %")
ElseIf  nVlr132   != 0     	    
		 oSay_133:SetText(Transform(((nVlr133/nVlr132*100)),'@E  999,999%'))
    If      (nVlr133/nVlr132*100)/100 > 100 
             oSay_133:SetColor(CLR_RED)
	ElseIf  (nVlr133/nVlr132*100)/100 < 100  	 
             oSay_133:SetColor(CLR_BLUE)
    EndIf 
Else
    oSay_133:SetText("   100 %")
EndIF

// fgts  

If  nVlrFgts1   != 0
    oSayFgts1:SetText("  100 %")
	oSayFgts2:SetText("  100 %")  
Else 	
    oSayFgts1:SetText("      0 %")
	oSayFgts2:SetText("      0 %")
EndIF
If  nVlrFgts2   == 0
  	oSayFgts2:SetText("      0 %")
ElseIf  nVlrFgts1   != 0    
        oSayFgts2:SetText(Transform((nVlrFgts2/nVlrFgts1*100),'@E  999,999 %'))
    If      (nVlrFgts2/nVlrFgts1*100)> 100 
             oSayFgts2:SetColor(CLR_RED)
	ElseIf  (nVlrFgts2/nVlrFgts1*100) < 100  	 
             oSayFgts2:SetColor(CLR_BLUE)
    EndIf 
Else
    oSayFgts2:SetText("   100 %")
EndIf
If nVlrFgts3 == 0
	oSayFgts3:SetText("      0 %")
ElseIf  nVlrFgts2   != 0    
 	    oSayFgts3:SetText(Transform((nVlrFgts3/nVlrFgts2*100),'@E  999,999 %'))
        If      (nVlrFgts3/nVlrFgts2*100) > 100 
                 oSayFgts3:SetColor(CLR_RED)
	    ElseIf  (nVlrFgts3/nVlrFgts2*100) < 100  	 
                 oSayFgts3:SetColor(CLR_BLUE)
        EndIf 
Else
        oSayFgts3:SetText("   100 %")
EndIF

// ferias  

If  nVlrFer1   != 0
    oSayFer1:SetText("  100 %")
	oSayFer2:SetText("  100 %")  
Else 	
    oSayFer1:SetText("      0 %")
	oSayFer2:SetText("      0 %")
EndIF

If  nVlrFer2   == 0
  	oSayFer2:SetText("      0 %")
ElseIf  nVlrFer1 != 0    
        oSayFer2:SetText(Transform((nVlrFer2/nVlrFer1*100),'@E  999,999 %'))
    If      (nVlrFer2/nVlrFer1*100)> 100 
             oSayFer2:SetColor(CLR_RED)
	ElseIf  (nVlrFer2/nVlrFer1*100) < 100  	 
             oSayFer2:SetColor(CLR_BLUE)
    EndIf 
Else
    	oSayFer2:SetText("   100 %")
EndIf
If  nVlrFer3 == 0
	oSayFer3:SetText("      0 %")
ElseIf  nVlrFer2   != 0    
 	    oSayFer3:SetText(Transform((nVlrFer3/nVlrFer2*100),'@E  999,999 %'))
    If      (nVlrFer3/nVlrFer2*100) > 100 
             oSayFer3:SetColor(CLR_RED)
	ElseIf  (nVlrFer3/nVlrFer2*100) < 100  	 
             oSayFer3:SetColor(CLR_BLUE)
    EndIf 
Else
        oSayFer3:SetText("   100 %")
EndIF

// folha   

If  nVlrFol1   != 0
    oSayFol1:SetText("  100 %")
	oSayFol2:SetText("  100 %")  
Else 	
    oSayFol1:SetText("      0 %")
	oSayFol2:SetText("      0 %")
EndIF

If      nVlrFol2   == 0
     	oSayFol2:SetText("      0 %")
ElseIf  nVlrFol1 != 0    
        oSayFol2:SetText(Transform((nVlrFol2/nVlrFol1*100),'@E  999,999 %'))
    If      (nVlrFol2/nVlrFol1*100)> 100 
             oSayFol2:SetColor(CLR_RED)
	ElseIf  (nVlrFol2/nVlrFol1*100) < 100  	 
             oSayFol2:SetColor(CLR_BLUE)
    EndIf 
Else
    oSayFol2:SetText("   100 %")
EndIf
If      nVlrFol3 == 0
	    oSayFol3:SetText("      0 %")
ElseIf  nVlrFol2   != 0    

 	    oSayFol3:SetText(Transform((nVlrFol3/nVlrFol2*100),'@E  999,999 %'))

    If      (nVlrFol3/nVlrFol2*100) > 100 
             oSayFol3:SetColor(CLR_RED)
	ElseIf  (nVlrFol3/nVlrFol2*100) < 100  	 
             oSayFol3:SetColor(CLR_BLUE)
    EndIf 

Else
        oSayFol3:SetText("   100 %")
EndIF

// INSS   

If  nVlrInss1   != 0
 
    oSayInss1:SetText("  100 %")
	oSayInss2:SetText("  100 %")  

Else 	

    oSayInss1:SetText("      0 %")
	oSayInss2:SetText("      0 %")

EndIF

If  nVlrInss2   == 0
	
  	oSayInss2:SetText("      0 %")

ElseIf  nVlrInss1 != 0    
 
        oSayInss2:SetText(Transform((nVlrInss2/nVlrInss1*100),'@E  999,999 %'))

    If      (nVlrInss2/nVlrInss1*100)> 100 
             oSayInss2:SetColor(CLR_RED)
	ElseIf  (nVlrInss2/nVlrInss1*100) < 100  	 
             oSayInss2:SetColor(CLR_BLUE)
    EndIf 

Else

    	oSayInss2:SetText("   100 %")

EndIf

If nVlrInss3 == 0

	    oSayInss3:SetText("      0 %")

ElseIf  nVlrInss2   != 0    

 	    oSayInss3:SetText(Transform((nVlrInss3/nVlrInss2*100),'@E  999,999 %'))

    If      (nVlrInss3/nVlrInss2*100) > 100 
             oSayInss3:SetColor(CLR_RED)
	ElseIf  (nVlrInss3/nVlrInss2*100) < 100  	 
             oSayInss3:SetColor(CLR_BLUE)
    EndIf 

Else
        oSayInss3:SetText("   100 %")
EndIF


// IRRF 

If  nVlrIr1  != 0
 
    oSayIr1:SetText("  100 %")
	oSayIr2:SetText("  100 %")  

Else 	

    oSayIr1:SetText("      0 %")
	oSayIr2:SetText("      0 %")

EndIF

If  nVlrIr2   == 0
	
  	oSayIr2:SetText("      0 %")

ElseIf  nVlrIr1 != 0    
 
        oSayIr2:SetText(Transform((nVlrIr2/nVlrIr1*100),'@E  999,999 %'))

    If      (nVlrIr2/nVlrIr1*100)> 100 
             oSayIr2:SetColor(CLR_RED)
	ElseIf  (nVlrIr2/nVlrIr1*100) < 100  	 
             oSayIr2:SetColor(CLR_BLUE)
    EndIf 

Else

    	oSayIr2:SetText("   100 %")

EndIf

If nVlrIr3 == 0

	    oSayIr3:SetText("      0 %")

ElseIf  nVlrIr2   != 0    

 	    oSayIr3:SetText(Transform((nVlrIr3/nVlrIr2*100),'@E  999,999 %'))

    If      (nVlrIr3/nVlrIr2*100) > 100 
             oSayIr3:SetColor(CLR_RED)
	ElseIf  (nVlrIr3/nVlrIr2*100) < 100  	 
             oSayIr3:SetColor(CLR_BLUE)
    EndIf 

Else
        oSayIr3:SetText("   100 %")
EndIF


// PENSAO 

If  nVlrPen1  != 0
 
    oSayPen1:SetText("  100 %")
	oSayPen2:SetText("  100 %")  

Else 	

    oSayPen1:SetText("      0 %")
	oSayPen2:SetText("      0 %")

EndIF

If  nVlrPen2   == 0
	
  	oSayPen2:SetText("      0 %")

ElseIf  nVlrPen1 != 0    
 
        oSayPen2:SetText(Transform((nVlrPen2/nVlrPen1*100),'@E  999,999 %'))

    If      (nVlrPen2/nVlrPen1*100)> 100 
             oSayPen2:SetColor(CLR_RED)
	ElseIf  (nVlrPen2/nVlrPen1*100) < 100  	 
             oSayPen2:SetColor(CLR_BLUE)
    EndIf 

Else

    	oSayPen2:SetText("   100 %")

EndIf

If nVlrPen3 == 0

	    oSayPen3:SetText("      0 %")

ElseIf  nVlrPen2   != 0    

 	    oSayPen3:SetText(Transform((nVlrPen3/nVlrPen2*100),'@E  999,999 %'))

    If      (nVlrPen3/nVlrPen2*100) > 100 
             oSayPen3:SetColor(CLR_RED)
	ElseIf  (nVlrPen3/nVlrPen2*100) < 100  	 
             oSayPen3:SetColor(CLR_BLUE)
    EndIf 

Else
        oSayPen3:SetText("   100 %")
EndIF

// Pis 

If  nVlrPis1  != 0
 
    oSayPis1:SetText("  100 %")
	oSayPis2:SetText("  100 %")  

Else 	

    oSayPis1:SetText("      0 %")
	oSayPis2:SetText("      0 %")

EndIF

If  nVlrPis2   == 0
	
  	oSayPis2:SetText("      0 %")

ElseIf  nVlrPis1 != 0    
 
        oSayPis2:SetText(Transform((nVlrPis2/nVlrPis1*100),'@E  999,999 %'))

    If      (nVlrPis2/nVlrPis1*100)> 100 
             oSayPis2:SetColor(CLR_RED)
	ElseIf  (nVlrPis2/nVlrPis1*100) < 100  	 
             oSayPis2:SetColor(CLR_BLUE)
    EndIf 

Else

    	oSayPis2:SetText("   100 %")

EndIf

If nVlrPis3 == 0

	    oSayPis3:SetText("      0 %")

ElseIf  nVlrPis2   != 0    

 	    oSayPis3:SetText(Transform((nVlrPis3/nVlrPis2*100),'@E  999,999 %'))

    If      (nVlrPis3/nVlrPis2*100) > 100 
             oSayPis3:SetColor(CLR_RED)
	ElseIf  (nVlrPis3/nVlrPis2*100) < 100  	 
             oSayPis3:SetColor(CLR_BLUE)
    EndIf 

Else
        oSayPis3:SetText("   100 %")
EndIF


// RESIÇÃO  

If  nVlrResc1  != 0
 
    oSayRes1:SetText("  100 %")
	oSayRes2:SetText("  100 %")  

Else 	

    oSayRes1:SetText("      0 %")
	oSayRes2:SetText("      0 %")

EndIF

If  nVlrResc2   == 0
	
  	oSayRes2:SetText("      0 %")

ElseIf  nVlrResc1 != 0    
 
        oSayRes2:SetText(Transform((nVlrResc2/nVlrResc1*100),'@E  999,999 %'))

    If      (nVlrResc2/nVlrResc1*100)> 100 
             oSayRes2:SetColor(CLR_RED)
	ElseIf  (nVlrResc2/nVlrResc1*100) < 100  	 
             oSayRes2:SetColor(CLR_BLUE)
    EndIf 

Else

    	oSayRes2:SetText("   100 %")

EndIf

If nVlrResc3 == 0

	    oSayRes3:SetText("      0 %")

ElseIf  nVlrResc2   != 0    

 	    oSayRes3:SetText(Transform((nVlrResc3/nVlrResc2*100),'@E  999,999 %'))

    If      (nVlrResc3/nVlrResc2*100) > 100 
             oSayRes3:SetColor(CLR_RED)
	ElseIf  (nVlrResc3/nVlrResc2*100) < 100  	 
             oSayRes3:SetColor(CLR_BLUE)
    EndIf 

Else
        oSayRes3:SetText("   100 %")
EndIF


// RIO CARD  


If  nVlrVTra1  != 0
 
    oSayVTan1:SetText("  100 %")
	oSayVTan2:SetText("  100 %")  

Else 	

    oSayVTan1:SetText("      0 %")
	oSayVTan2:SetText("      0 %")

EndIF

If  nVlrVTra2   == 0
	
  	oSayVTan2:SetText("      0 %")

ElseIf  nVlrVTra1 != 0    
 
        oSayVTan2:SetText(Transform((nVlrVTra2/nVlrVTra1*100),'@E  999,999 %'))

    If      (nVlrVTra2/nVlrVTra1*100)> 100 
             oSayVTan2:SetColor(CLR_RED)
	ElseIf  (nVlrVTra2/nVlrVTra1*100) < 100  	 
             oSayVTan2:SetColor(CLR_BLUE)
    EndIf 

Else

    	oSayVTan2:SetText("   100 %")

EndIf

If nVlrVTra3 == 0

	    oSayVTan3:SetText("      0 %")

ElseIf  nVlrVTra2   != 0    

 	    oSayVTan3:SetText(Transform((nVlrVTra3/nVlrVTra2*100),'@E  999,999 %'))

    If      (nVlrVTra3/nVlrVTra2*100) > 100 
             oSayVTan3:SetColor(CLR_RED)
	ElseIf  (nVlrVTra3/nVlrVTra2*100) < 100  	 
             oSayVTan3:SetColor(CLR_BLUE)
    EndIf 

Else
        oSayVTan3:SetText("   100 %")
EndIF

// SODEXO  


If  nVlrSodx1 != 0
 
    oSaySod1:SetText("  100 %")
	oSaySod2:SetText("  100 %")  

Else 	

    oSaySod1:SetText("      0 %")
	oSaySod2:SetText("      0 %")

EndIF

If  nVlrSodx2   == 0
	
  	oSaySod2:SetText("      0 %")

ElseIf  nVlrSodx1 != 0    
 
        oSaySod2:SetText(Transform((nVlrSodx2/nVlrSodx1*100),'@E  999,999 %'))

    If      (nVlrSodx2/nVlrSodx1*100)> 100 
             oSaySod2:SetColor(CLR_RED)
	ElseIf  (nVlrSodx2/nVlrSodx1*100) < 100  	 
             oSaySod2:SetColor(CLR_BLUE)
    EndIf 

Else

    	oSaySod2:SetText("   100 %")

EndIf

If nVlrSodx3 == 0

	    oSaySod3:SetText("      0 %")

ElseIf  nVlrSodx2   != 0    

 	    oSaySod3:SetText(Transform((nVlrSodx3/nVlrSodx2*100),'@E  999,999 %'))

    If      (nVlrSodx3/nVlrSodx2*100) > 100 
             oSaySod3:SetColor(CLR_RED)
	ElseIf  (nVlrSodx3/nVlrSodx2*100) < 100  	 
             oSaySod3:SetColor(CLR_BLUE)
    EndIf 

Else
        oSaySod3:SetText("   100 %")
EndIf
 
/////////// 13°  

If nM1312M > 0  
   If      (nVlr131 >= (nM1312M/100)*90)   .and.  ( nVlr131 <= (nM1312M/100)*110) 
               oGet222:SetColor(CLR_GREEN)
    Elseif (nVlr131 < (nM1312M/100)*90)
	           oSay13:SetColor(CLR_BLUE)
	Else 
	           oSay13:SetColor(CLR_RED)	
	EndIf 
Else 			      
	oSay13:SetColor(CLR_BLACK,CLR_WHITE)
EndIF 	
  oSay13:refresh() 

If nM136M > 0   
   If      (nVlr131 >= (nM136M/100)*90)   .and.  ( nVlr131 <= (nM136M/100)*110) 
               oSay19:SetColor(CLR_GREEN)
    Elseif (nVlr131 < (nM136M/100)*90)
	           oSay19:SetColor(CLR_BLUE)
	Else 
	           oSay19:SetColor(CLR_RED)	
	EndIf 
Else 			      
    oSay19:SetColor(CLR_BLACK)
EndIF 	

  oSay19:refresh()  

/////////// FERIAS   

If nMFer12M > 0 
   If      (nVlrFer1 >= (nMFer12M/100)*90)   .and.  ( nVlrFer1 <= (nMFer12M/100)*110) 
               oSay3:SetColor(CLR_GREEN)
    Elseif (nVlrFer1 < (nMFer12M/100)*90)
	           oSay3:SetColor(CLR_BLUE)
	Else 
	           oSay3:SetColor(CLR_RED)	
	EndIf 
Else 			      
    oSay3:SetColor(CLR_BLACK)
EndIF 	

    oSay3:refresh()  

If nMFer6M > 0  
    If      (nVlrFer1 >= (nMFer6M/100)*90)   .and.  ( nVlrFer1 <= (nMFer6M/100)*110) 
               oSay16:SetColor(CLR_GREEN)
    Elseif (nVlr131 < (nMFer6M/100)*90)
	           oSay16:SetColor(CLR_BLUE)
	Else 
	           oSay16:SetColor(CLR_RED)	
	EndIf 
Else 			      
    oSay16:SetColor(CLR_BLACK)
EndIF 	
    oSay1:refresh()  

/////////// FOLHA   
If nMFol12M > 0 
   If      (nVlrFol1 >= (nMFol12M/100)*90)   .and.  ( nVlrFol1 <= (nMFol12M/100)*110) 
               oSay2:SetColor(CLR_GREEN)
    Elseif (nVlrFol1 < (nMFol12M/100)*90)
	           oSay2:SetColor(CLR_BLUE)
	Else 
	           oSay2:SetColor(CLR_RED)	
	EndIf 
Else 			      
    oSay2:SetColor(CLR_BLACK)
EndIF 	
    oSay2:refresh()  

If nMFol6M > 0  
    If      (nVlrFol1 >= (nMFol6M/100)*90)   .and.  (nVlrFol1 <= (nMFol6M/100)*110) 
               oSay17:SetColor(CLR_GREEN)
    Elseif (nVlrFol1 < (nMFol6M/100)*90)
	           oSay17:SetColor(CLR_BLUE)
	Else 
	           oSay17:SetColor(CLR_RED)	
	EndIf 
Else 			      
    oSay17:SetColor(CLR_BLACK)
EndIF 	
    oSay17:refresh()   

/////////// FGTS

If nMFgts12M > 0 
   If      (nVlrFgts1 >= (nMFgts12M/100)*90)   .and.  (nVlrFgts1 <= (nMFgts12M/100)*110) 
               oSay10:SetColor(CLR_GREEN)
    Elseif (nVlrFgts1 < (nMFgts12M/100)*90)
	           oSay10:SetColor(CLR_BLUE)
	Else  
	           oSay10:SetColor(CLR_RED)	
	EndIf 
Else 			      
    oSay10:SetColor(CLR_BLACK)
EndIF 	
    oSay10:refresh()  

If nMFgts6M > 0  
    If      (nVlrFgts1 >= (nMFgts6M/100)*90)   .and.  (nVlrFgts1 <= (nMFgts6M/100)*110) 
               oSay22:SetColor(CLR_GREEN)
    Elseif (nVlrFgts1 < (nMFgts6M/100)*90)
	           oSay22:SetColor(CLR_BLUE)
	Else 
	           oSay22:SetColor(CLR_RED)	
	EndIf 
Else 			      
    oSay22:SetColor(CLR_BLACK)
EndIF 	
    oSay22:refresh()   	

/////////// INSS

If nMInss12M > 0 
   If      (nVlrInss1 >= (nMInss12M/100)*90)   .and.  (nVlrInss1 <= (nMInss12M/100)*110) 
               oSay5:SetColor(CLR_GREEN)
    Elseif (nVlrInss1 < (nMInss12M/100)*90)
	           oSay5:SetColor(CLR_BLUE)
	Else 
	           oSay5:SetColor(CLR_RED)	
	EndIf 
Else 			      
    oSay5:SetColor(CLR_BLACK)
EndIF 	
    oSay5:refresh()  

If nMInss6M > 0  
    If      (nVlrInss1 >= (nMInss6M/100)*90)   .and.  (nVlrInss1 <= (nMInss6M/100)*110) 
               oSay20:SetColor(CLR_GREEN)
    Elseif (nVlrInss1 < (nMInss6M/100)*90)
	           oSay20:SetColor(CLR_BLUE)
	Else 
	           oSay20:SetColor(CLR_RED)	
	EndIf 
Else 			      
    oSay20:SetColor(CLR_BLACK)
EndIF 	
    oSay20:refresh()   	

/////////// IR

If nMIr12M > 0 
   If      (nVlrIr1 >= (nMIr12M/100)*90) .and. (nVlrIr1 <= (nMIr12M/100)*110) 
            oSay6:SetColor(CLR_GREEN)
    Elseif (nVlrIr1 < (nMIr12M/100)*90)
	        oSay6:SetColor(CLR_BLUE)
	Else 
	        oSay6:SetColor(CLR_RED)	
	EndIf 
Else 			      
    oSay6:SetColor(CLR_BLACK)
EndIF 	
    oSay6:refresh()  

If nMIr6M > 0  
    If      (nVlrIr1 >= (nMIr6M/100)*90)   .and.  (nVlrIr1 <= (nMIr6M/100)*110) 
               oSay8:SetColor(CLR_GREEN)
    Elseif (nVlrIr1 < (nMIr6M/100)*90)
	           oSay8:SetColor(CLR_BLUE)
	Else 
	           oSay8:SetColor(CLR_RED)	
	EndIf 
Else 			      
    oSay8:SetColor(CLR_BLACK)
EndIF 	
    oSay8:refresh()   	

/////////// pensao
 
 If nMPen12M > 0 
   If      (nVlrPen1 >= (nMPen12M/100)*90)   .and.  (nVlrPen1 <= (nMPen12M/100)*110) 
               oSay7:SetColor(CLR_GREEN)
    Elseif (nVlrPen1 < (nMPen12M/100)*90)
	           oSay7:SetColor(CLR_BLUE)
	Else 
	           oSay7:SetColor(CLR_RED)	
	EndIf 
Else 			      
    oSay7:SetColor(CLR_BLACK)
EndIF 	
    oSay7:refresh()  

If nMPen6M > 0  
    If      (nVlrPen1 >= (nMPen6M/100)*90)   .and.  (nVlrPen1 <= (nMPen6M/100)*110) 
               oSay14:SetColor(CLR_GREEN)
    Elseif (nVlrPen1 < (nMPen6M/100)*90)
	           oSay14:SetColor(CLR_BLUE)
	Else 
	           oSay14:SetColor(CLR_RED)	
	EndIf 
Else 			      
    oSay14:SetColor(CLR_BLACK)
EndIF 	
    oSay14:refresh()   	

/////////// PIS
 
 If nMPis12M > 0 
   If      (nVlrPis1 >= (nMPis12M/100)*90)   .and.  (nVlrPis1 <= (nMPis12M/100)*110) 
               oSay9:SetColor(CLR_GREEN)
    Elseif (nVlrPis1 < (nMPis12M/100)*90)
	           oSay9:SetColor(CLR_BLUE)
	Else 
	           oSay9:SetColor(CLR_RED)	
	EndIf 
Else 			      
    oSay9:SetColor(CLR_BLACK)
EndIF 	
    oSay9:refresh()  

If nMPis6M > 0  
    If      (nVlrPis1 >= (nMPis6M/100)*90)   .and.  (nVlrPis1 <= (nMPis6M/100)*110) 
               oSay18:SetColor(CLR_GREEN)
    Elseif (nVlrPis1 < (nMPis6M/100)*90)
	           oSay18:SetColor(CLR_BLUE)
	Else 
	           oSay18:SetColor(CLR_RED)	
	EndIf 
Else 			      
    oSay18:SetColor(CLR_BLACK)
EndIF 	
    oSay18:refresh()   	

/////////// Rescição
 
 If nMRes12M > 0 
   If      (nVlrResc1 >= (nMRes12M/100)*90)   .and.  (nVlrResc1 <= (nMRes12M/100)*110) 
               oSay4:SetColor(CLR_GREEN)
    Elseif (nVlrResc1 < (nMRes12M/100)*90)
	           oSay4:SetColor(CLR_BLUE)
	Else 
	           oSay4:SetColor(CLR_RED)	
	EndIf 
Else 			      
    oSay4:SetColor(CLR_BLACK)
EndIF 	
    oSay4:refresh()  

If nMRes6M > 0  
    If      (nVlrResc1 >= (nMRes6M/100)*90)   .and.  (nVlrResc1 <= (nMRes6M/100)*110) 
               oSay15:SetColor(CLR_GREEN)
    Elseif (nVlrResc1 < (nMRes6M/100)*90)
	           oSay15:SetColor(CLR_BLUE)
	Else 
	           oSay15:SetColor(CLR_RED)	
	EndIf 
Else 			      
    oSay15:SetColor(CLR_BLACK)
EndIF 	
    oSay15:refresh()   	


/////////// Sodexo

 If nMSod12M > 0 
   If      (nVlrSodx1 >= (nMSod12M/100)*90)   .and.  (nVlrSodx1 <= (nMSod12M/100)*110) 
               oSay12:SetColor(CLR_GREEN)
    Elseif (nVlrSodx1 < (nMSod12M/100)*90)
	           oSay12:SetColor(CLR_BLUE)
	Else 
	           oSay12:SetColor(CLR_RED)	
	EndIf 
Else 			      
    oSay12:SetColor(CLR_BLACK)
EndIF 	
    oSay12:refresh()  

If nMRes6M > 0  
    If      (nVlrSodx1 >= (nMSod6M/100)*90)   .and.  (nVlrSodx1 <= (nMSod6M/100)*110) 
               oSay21:SetColor(CLR_GREEN)
    Elseif (nVlrSodx1 < (nMSod6M/100)*90)
	           oSay21:SetColor(CLR_BLUE)
	Else 
	           oSay21:SetColor(CLR_RED)	
	EndIf 
Else 			      
    oSay21:SetColor(CLR_BLACK)
EndIF 	
    oSay21:refresh()   	

/////////// Vale Transporte 

 If nMVTra12M > 0 
   If      (nVlrVTra1 >= (nMVTra12M/100)*90)   .and.  (nVlrVTra1 <= (nMVTra12M/100)*110) 
               oSay11:SetColor(CLR_GREEN)
    Elseif (nVlrVTra1 < (nMVTra12M/100)*90)
	           oSay11:SetColor(CLR_BLUE)
	Else 
	           oSay11:SetColor(CLR_RED)	
	EndIf 
Else 			      
    oSay11:SetColor(CLR_BLACK)
EndIF 	
    oSay11:refresh()  

If nMVTra6M > 0  
    If      (nVlrVTra1 >= (nMVTra6M/100)*90)   .and.  (nVlrVTra1 <= (nMVTra6M/100)*110) 
               oSay23:SetColor(CLR_GREEN)
    Elseif (nVlrVTra1 < (nMVTra6M/100)*90)
	           oSay23:SetColor(CLR_BLUE)
	Else 
	           oSay23:SetColor(CLR_RED)	
	EndIf 
Else 			      
    oSay23:SetColor(CLR_BLACK)
EndIF 	
    oSay23:refresh()   	

Return ()


////////////////////
/*
#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'RWMAKE.CH'
#INCLUDE 'FONT.CH'
#INCLUDE 'COLORS.CH'

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

static Function fMostTela1(nSaldo,cVisto, i )

/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±± Declaração de cVariable dos componentes                                 ±±
Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/

/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±± Declaração de Variaveis Private dos Objetos                             ±±
Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/
SetPrvt("oDlg1881","oGrp1","oSay2","oSay6","oSay28","oSay251","oSay267","oGet2","oGet6","oBtn1","oBtn2")
SetPrvt("oBtn3","oGet251","oGet216","oGrp3","oGrp4","oSay3","oSay4","oSay5","oSay11","oSay12","oSay13")
SetPrvt("oSay31","oSay250","oSay252","oSay253","oSayFol1","oSayFer1","oSayRes1","oSayPen1","oSayIr1")
SetPrvt("oSayFgts1","oSayPis1","oSay_131","oSaySod1","oSay179","oSayVTan1","oSay181","oGet3","oGet4")
SetPrvt("oGet11","oGet12","oGet13","oGet31","oGrp5","oSay14","oSay17","oSay18","oSay19","oSay20","oSay21")
SetPrvt("oSay23","oGet14","oGet17","oGet18","oGet19","oGet20","oGet21","oGet22","oGet23","oGrp6","oSay24")
SetPrvt("oSay26","oSay27","oSay29","oSay30","oSay32","oSay33","oGet24","oGet25","oGet26","oGet27","oGet29")
SetPrvt("oGet32","oGet33","oGrp8","oSay34","oSay35","oSay36","oSay37","oSay38","oSay39","oSay40","oSay41")
SetPrvt("oGet35","oGet36","oGet37","oGet38","oGet39","oGet40","oGet41","oGrp9","oSay42","oSay43","oSay44")
SetPrvt("oSay46","oSay47","oSay48","oSay49","oGet42","oGet43","oGet44","oGet45","oGet46","oGet47","oGet48")
SetPrvt("oGrp10","oSay50","oSay51","oSay52","oSay53","oSay54","oSay55","oSay56","oSay57","oGet50","oGet51")
SetPrvt("oGet53","oGet54","oGet55","oGet56","oGet57","oGet250","oGet252","oGet253","oGet158","oGet159")
SetPrvt("oMGet1","oGrp11","oSay58","oSay59","oSay60","oSay61","oSay62","oSay63","oSay64","oSay65","oSay66")
SetPrvt("oSay68","oSayFol3","oSayFol2","oSayFer2","oSayRes2","oSayPen2","oSayIr2","oSayInss1","oSayInss2","oSayFgts2","oSayPis2")
SetPrvt("oSaySod2","oSay79","oSayVTan2","oSay81","oGet58","oGet59","oGet60","oGet61","oGet62","oGet63")
SetPrvt("oGrp12","oSay82","oSay83","oSay84","oSay85","oSay86","oSay87","oSay88","oSay89","oGet65","oGet66")
SetPrvt("oGet68","oGet69","oGet70","oGet71","oGet72","oGrp13","oSay90","oSay91","oSay92","oSay93","oSay94")
SetPrvt("oSay96","oSay97","oGet73","oGet74","oGet75","oGet76","oGet77","oGet78","oGet79","oGet80","oGrp14")
SetPrvt("oSay99","oSay100","oSay101","oSay102","oSay103","oSay104","oSay105","oGet81","oGet82","oGet83")
SetPrvt("oGet85","oGet86","oGet87","oGet88","oGrp15","oSay106","oSay107","oSay108","oSay109","oSay110")
SetPrvt("oSay112","oSay113","oGet89","oGet90","oGet91","oGet92","oGet93","oGet94","oGet95","oGet96","oGrp16")
SetPrvt("oSay115","oSay116","oSay117","oSay118","oSay119","oSay120","oSay121","oGet97","oGet98","oGet99")
SetPrvt("oGet101","oGet102","oGet103","oGet104","oGet105","oGet106","oGet107","oGet108","oGet109","oGrp17")
SetPrvt("oSay123","oSay124","oSay125","oSay126","oSay127","oSay128","oSay129","oSay130","oSay131","oSay132")
SetPrvt("oSayFer3","oSayRes3","oSayPen3","oSayIr3","oSayInss3","oSayFgts3","oSayPis3","oSay_132","oSay_133","oSaySod3")
SetPrvt("oSayVTan3","oSay145","oGet110","oGet111","oGet112","oGet113","oGet114","oGet115","oGet116","oGrp18")
SetPrvt("oSay147","oSay148","oSay149","oSay150","oSay151","oSay152","oSay153","oGet117","oGet118","oGet119")
SetPrvt("oGet121","oGet122","oGet123","oGet124","oGrp19","oSay154","oSay155","oSay156","oSay157","oSay158")
SetPrvt("oSay160","oSay161","oGet125","oGet126","oGet127","oGet128","oGet129","oGet130","oGet131","oGet132")
SetPrvt("oSay162","oSay163","oSay164","oSay165","oSay166","oSay167","oSay168","oSay169","oGet133","oGet134")
SetPrvt("oGet136","oGet137","oGet138","oGet139","oGet140","oGrp21","oSay170","oSay171","oSay172","oSay173")
SetPrvt("oSay175","oSay176","oSay177","oGet141","oGet142","oGet143","oGet144","oGet145","oGet146","oGet147")
SetPrvt("oGrp22","oSay178","oSay180","oSay182","oSay183","oSay184","oSay185","oSay186","oSay187","oGet149")
SetPrvt("oGet151","oGet152","oGet153","oGet154","oGet155","oGet156","oGet157","oGet160","oGet161","oGet162")
SetPrvt("oGrp2","oSay7","oSay8","oSay9","oSay10","oSay15","oSay16","oSay70","oSay71","oSay72","oSay73")
SetPrvt("oSay139","oGet7","oGet8","oGet9","oGet10","oGet15","oGet16","oGet164","oGrp23","oSay140","oSay141")
SetPrvt("oSay144","oSay188","oSay189","oSay190","oSay191","oGet165","oGet166","oGet167","oGet168","oGet169")
SetPrvt("oGet171","oGet172","oGrp24","oSay192","oSay193","oSay194","oSay195","oSay196","oSay197","oSay198")
SetPrvt("oGet173","oGet174","oGet175","oGet176","oGet177","oGet178","oGet179","oGet180","oGrp25","oSay200")
SetPrvt("oSay202","oSay203","oSay204","oSay205","oSay206","oSay207","oGet181","oGet182","oGet183","oGet184")
SetPrvt("oGet186","oGet187","oGet188","oGrp26","oSay208","oSay209","oSay210","oSay211","oSay212","oSay213")
SetPrvt("oSay215","oGet189","oGet190","oGet191","oGet192","oGet193","oGet194","oGet195","oGet196","oGrp27")
SetPrvt("oSay217","oSay218","oSay219","oSay220","oSay221","oSay222","oSay223","oGet197","oGet198","oGet199")
SetPrvt("oGet201","oGet202","oGet203","oGet204","oGet205","oGet206","oGet207","oGet208","oGet209")

SetPrvt("oDlg1881","oGrp28","oSay69","oSay74","oSay75","oSay76","oSay77","oSay78","oSay80","oSay133")
SetPrvt("oSay135","oSay136","oGet210","oGet211","oGet213","oGet214","oGet215","oGet218","oGet219","oGet220")
SetPrvt("oGet222","oGet223","oGrp30","oSay245","oSay246","oSay247","oSay248","oSay249","oSay254","oSay255")
SetPrvt("oSay257","oSay258","oSay259","oGet233","oGet234","oGet235","oGet236","oGet237","oGet238","oGet239")
SetPrvt("oGet241","oGet242","oGet243")

/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±± Definicao do Dialog e todos os seus componentes.                        ±±
Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/

oDlg1881   := MSDialog():New( 089,087,699,1254,"AUTORIZAÇÃO DE PAGAMENTOS DA FOLHA E BENEFICIOS",,,.F.,,,,,,.T.,,,.T. )
//oSay2      := TSay():New( 0120,005,{||"Teste de impresao - - -ipo de Pagamento "},oDlg1881,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,1200,1200)
//oDlg1881   := MSDialog():New( 099,260,709,1229,"AUTORIZAÇÃO DE PAGAMENTOS DE FOLHA E BENEFICIOS",,,.F.,,,,,,.T.,,,.T. )
oGrp1      := TGroup():New( 000,000,052,472,"Dados da Liberação ",oDlg1881,CLR_BLUE,CLR_WHITE,.T.,.F. )
oSay2      := TSay():New( 012,005,{||"Tipo de Pagamento "},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,059,008)
oSay6      := TSay():New( 012,421,{||"ValorTotal Liberado "},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLUE,CLR_WHITE,047,008)
oSay28     := TSay():New( 012,282,{||"Data de Pagamento"},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLUE,CLR_WHITE,047,008)
oSay251    := TSay():New( 012,232,{||"Competência"},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay267    := TSay():New( 012,354,{||"Valor Total"},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLUE,CLR_WHITE,047,008)
oGet2      := TGet():New( 020,004,{|u| If(PCount()>0,cTipoAtu:=u,cTipoAtu)},oGrp1,216,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cTipoAtu",,)

oGet6      := TGet():New( 020,415,{|u| If(PCount()>0,nVSaldAtu:=u,nVSaldAtu)},oGrp1,052,008,'@E 9,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVSaldAtu",,)

oBtn1      := TButton():New( 036,008,"Autoriza",oGrp1,{||fFazlib(i),oDlg1881:End()},060,012,,,,.T.,,"",,,,.F. )
oBtn2      := TButton():New( 037,408,"Sair ",oGrp1,{||oDlg1881:End()},060,012,,,,.T.,,"",,,,.F. )
oGet28     := TGet():New( 020,281,{|u| If(PCount()>0,dDataAtu:=u,dDataAtu)},oGrp1,049,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.T.,,.T.,.F.,"","dDataAtu",,)
//oBtn3      := TButton():New( 037,234,"Demonstrar ",oGrp1,, dDtvenc , TRIM(aBrwPEG[I,17]) )},060,012,,,,.T.,,"",,,,.F. )
oBtn3      := TButton():New( 037,234,"Demonstrar ",oGrp1,{||u_CABA188a( cAno+cMes , TRIM(aBrwPEG[I,3]), TRIM(aBrwPEG[I,18]), dDtvenc , TRIM(aBrwPEG[I,17]), _cIdUsuar )},060,012,,,,.T.,,"",,,,.F. )

oGet251    := TGet():New( 020,232,{|u| If(PCount()>0,cCompt0:=u,cCompt0)},oGrp1,032,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.T.,,.T.,.F.,"","cCompt0",,)

oGet216    := TGet():New( 020,346,{|u| If(PCount()>0,nVlrAtu:=u,nVlrAtu)},oGrp1,052,008,'@E 9,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrAtu",,)

oGrp3      := TGroup():New( 056,104,064,472,"Evolução das Ultimas  3 Comptetências",oDlg1881,CLR_BLUE,CLR_WHITE,.T.,.F. )

oGrp4      := TGroup():New( 066,102,244,224,"Detalhes da Evolução 1° Mes",oDlg1881,CLR_BLACK,CLR_WHITE,.T.,.F. )
oSay3      := TSay():New( 090,106,{||"Folha "},oGrp4,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,033,008)
oSay4      := TSay():New( 104,106,{||"Férias"},oGrp4,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,041,008)
oSay5      := TSay():New( 118,106,{||"Rescisão"},oGrp4,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,033,008)
oSay11     := TSay():New( 146,106,{||"I R"},oGrp4,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,033,008)
oSay12     := TSay():New( 160,106,{||"INSS"},oGrp4,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,033,009)
oSay13     := TSay():New( 132,106,{||"Pensão  "},oGrp4,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,036,009)
oSay1      := TSay():New( 076,178,{||"             Evolução "},oGrp4,,,.F.,.F.,.F.,.T.,CLR_RED,CLR_WHITE,044,008)
oSay31     := TSay():New( 076,106,{||"Competência "},oGrp4,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,036,008)
oSay250    := TSay():New( 174,106,{||"FGTS"},oGrp4,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,033,009)
oSay252    := TSay():New( 188,106,{||"PIS"},oGrp4,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,033,009)
oSay253    := TSay():New( 202,106,{||"13° "},oGrp4,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,033,009)
oSay179    := TSay():New( 216,106,{||"Sodexo"},oGrp4,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,033,009)
oSay181    := TSay():New( 230,106,{||"Vale Transporte"},oGrp4,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,039,009)

oSayFol1   := TSay():New( 090,198,{||"     100 %"},oGrp4,,,.F.,.F.,.F.,.T.,CLR_GREEN,CLR_WHITE,024,008)
oSayFer1   := TSay():New( 104,199,{||"     100 %"},oGrp4,,,.F.,.F.,.F.,.T.,CLR_GREEN,CLR_WHITE,024,008)
oSayRes1   := TSay():New( 118,199,{||"     100 %"},oGrp4,,,.F.,.F.,.F.,.T.,CLR_GREEN,CLR_WHITE,024,008)
oSayPen1   := TSay():New( 132,199,{||"     100 %"},oGrp4,,,.F.,.F.,.F.,.T.,CLR_GREEN,CLR_WHITE,024,008)
oSayIr1    := TSay():New( 146,199,{||"     100 %"},oGrp4,,,.F.,.F.,.F.,.T.,CLR_GREEN,CLR_WHITE,024,008)
oSayInss1  := TSay():New( 160,199,{||"     100 %"},oGrp4,,,.F.,.F.,.F.,.T.,CLR_GREEN,CLR_WHITE,024,008)
oSayFgts1  := TSay():New( 174,199,{||"     100 %"},oGrp4,,,.F.,.F.,.F.,.T.,CLR_GREEN,CLR_WHITE,024,008)
oSayPis1   := TSay():New( 188,199,{||"     100 %"},oGrp4,,,.F.,.F.,.F.,.T.,CLR_GREEN,CLR_WHITE,024,008)
oSay_131   := TSay():New( 202,199,{||"     100 %"},oGrp4,,,.F.,.F.,.F.,.T.,CLR_GREEN,CLR_WHITE,024,008)
oSaySod1   := TSay():New( 216,199,{||"     100 %"},oGrp4,,,.F.,.F.,.F.,.T.,CLR_GREEN,CLR_WHITE,024,008)
oSayVTan1  := TSay():New( 230,199,{||"     100 %"},oGrp4,,,.F.,.F.,.F.,.T.,CLR_GREEN,CLR_WHITE,024,008)

oGet3      := TGet():New( 088,146,{|u| If(PCount()>0,nVlrFol1:=u,nVlrFol1)},oGrp4,048,008,'@E 9,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrFol1",,)
oGet4      := TGet():New( 102,146,{|u| If(PCount()>0,nVlrFer1:=u,nVlrFer1)},oGrp4,048,008,'@E 9,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrFer1",,)
oGet5      := TGet():New( 116,146,{|u| If(PCount()>0,nVlrResc1:=u,nVlrResc1)},oGrp4,049,008,'@E 9,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrResc1",,)
oGet11     := TGet():New( 144,146,{|u| If(PCount()>0,nVlrIr1:=u,nVlrIr1)},oGrp4,048,008,'@E 9,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrIr1",,)
oGet12     := TGet():New( 158,146,{|u| If(PCount()>0,nVlrInss1:=u,nVlrInss1)},oGrp4,048,008,'@E 9,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrInss1",,)
oGet13     := TGet():New( 130,146,{|u| If(PCount()>0,nVlrPen1:=u,nVlrPen1)},oGrp4,048,008,' @E 9,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrPen1",,)
oGet31     := TGet():New( 074,146,{|u| If(PCount()>0,cCompt1:=u,cCompt1)},oGrp4,032,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cCompt1",,)
oGet250    := TGet():New( 172,146,{|u| If(PCount()>0,nVlrFgts1:=u,nVlrFgts1)},oGrp4,048,008,'@E 9,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrFgts1",,)
oGet252    := TGet():New( 186,146,{|u| If(PCount()>0,nVlrPis1:=u,nVlrPis1)},oGrp4,048,008,'@E 9,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrPis1",,)
oGet253    := TGet():New( 200,146,{|u| If(PCount()>0,nVlr131:=u,nVlr131)},oGrp4,048,008,'@E 9,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlr131",,)
oGet158    := TGet():New( 214,146,{|u| If(PCount()>0,nVlrSodx1:=u,nVlrSodx1)},oGrp4,048,008,'@E 9,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrSodx1",,)
oGet159    := TGet():New( 228,146,{|u| If(PCount()>0,nVlrVTra1:=u,nVlrVTra1)},oGrp4,048,008,'@E 9,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrVTra1",,)

oGrp7      := TGroup():New( 248,004,296,472,"Mensagem do Sistema",oDlg1881,CLR_RED,CLR_WHITE,.T.,.F. )
oMGet1     := TMultiGet():New( 256,004,{|u| If(PCount()>0,cMensSist:=u,cMensSist)},oGrp7,464,036,,,CLR_BLACK,CLR_WHITE,,.T.,"",,,.F.,.F.,.T.,,,.F.,,  )

oGrp11     := TGroup():New( 067,227,245,349,"Detalhes da Evolução 2° Mes",oDlg1881,CLR_BLACK,CLR_WHITE,.T.,.F. )
oSay58     := TSay():New( 091,231,{||"Folha "},oGrp11,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,033,008)
oSay59     := TSay():New( 105,231,{||"Férias"},oGrp11,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,041,008)
oSay60     := TSay():New( 119,231,{||"Rescisão"},oGrp11,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,033,008)
oSay61     := TSay():New( 147,231,{||"I R"},oGrp11,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,033,008)
oSay62     := TSay():New( 161,231,{||"INSS"},oGrp11,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,033,009)
oSay63     := TSay():New( 133,231,{||"Pensão  "},oGrp11,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,036,009)
oSay64     := TSay():New( 077,303,{||"             Evolução "},oGrp11,,,.F.,.F.,.F.,.T.,CLR_RED,CLR_WHITE,044,008)
oSay65     := TSay():New( 077,231,{||"Competência "},oGrp11,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,036,008)
oSay66     := TSay():New( 175,231,{||"FGTS"},oGrp11,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,033,009)
oSay67     := TSay():New( 189,231,{||"PIS"},oGrp11,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,033,009)
oSay68     := TSay():New( 203,231,{||"13° "},oGrp11,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,033,009)
oSay79     := TSay():New( 217,231,{||"Sodexo"},oGrp11,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,033,009)
oSay81     := TSay():New( 231,231,{||"Vale Transporte"},oGrp11,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,039,009)

oSayFol2   := TSay():New( 091,323,{||"     100 %"},oGrp11,,,.F.,.F.,.F.,.T.,CLR_GREEN,CLR_WHITE,024,008)
oSayFer2   := TSay():New( 105,324,{||"     100 %"},oGrp11,,,.F.,.F.,.F.,.T.,CLR_GREEN,CLR_WHITE,024,008)
oSayRes2   := TSay():New( 119,324,{||"     100 %"},oGrp11,,,.F.,.F.,.F.,.T.,CLR_GREEN,CLR_WHITE,024,008)
oSayPen2   := TSay():New( 133,324,{||"     100 %"},oGrp11,,,.F.,.F.,.F.,.T.,CLR_GREEN,CLR_WHITE,024,008)
oSayIr2    := TSay():New( 147,324,{||"     100 %"},oGrp11,,,.F.,.F.,.F.,.T.,CLR_GREEN,CLR_WHITE,024,008)
oSayInss2  := TSay():New( 161,324,{||"     100 %"},oGrp11,,,.F.,.F.,.F.,.T.,CLR_GREEN,CLR_WHITE,024,008)
oSayFgts2  := TSay():New( 175,324,{||"     100 %"},oGrp11,,,.F.,.F.,.F.,.T.,CLR_GREEN,CLR_WHITE,024,008)
oSayPis2   := TSay():New( 189,324,{||"     100 %"},oGrp11,,,.F.,.F.,.F.,.T.,CLR_GREEN,CLR_WHITE,024,008)
oSay_132   := TSay():New( 203,324,{||"     100 %"},oGrp11,,,.F.,.F.,.F.,.T.,CLR_GREEN,CLR_WHITE,024,008)
oSaySod2   := TSay():New( 217,324,{||"     100 %"},oGrp11,,,.F.,.F.,.F.,.T.,CLR_GREEN,CLR_WHITE,024,008)
oSayVTan2  := TSay():New( 231,324,{||"     100 %"},oGrp11,,,.F.,.F.,.F.,.T.,CLR_GREEN,CLR_WHITE,024,008)

oGet58     := TGet():New( 089,271,{|u| If(PCount()>0,nVlrFol2:=u,nVlrFol2)},oGrp11,048,008,'@E 9,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrFol2",,)
oGet59     := TGet():New( 103,271,{|u| If(PCount()>0,nVlrFer2:=u,nVlrFer2)},oGrp11,048,008,'@E 9,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrFer2",,)
oGet60     := TGet():New( 117,271,{|u| If(PCount()>0,nVlrResc2:=u,nVlrResc2)},oGrp11,049,008,'@E 9,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrResc2",,)
oGet61     := TGet():New( 145,271,{|u| If(PCount()>0,nVlrIr2:=u,nVlrIr2)},oGrp11,048,008,'@E 9,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrIr2",,)
oGet62     := TGet():New( 159,271,{|u| If(PCount()>0,nVlrInss2:=u,nVlrInss2)},oGrp11,048,008,'@E 9,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrInss2",,)
oGet63     := TGet():New( 131,271,{|u| If(PCount()>0,nVlrPen2:=u,nVlrPen2)},oGrp11,048,008,' @E 9,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrPen2",,)
oGet64     := TGet():New( 075,271,{|u| If(PCount()>0,cCompt2:=u,cCompt2)},oGrp11,032,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cCompt2",,)
oGet105    := TGet():New( 173,271,{|u| If(PCount()>0,nVlrFgts2:=u,nVlrFgts2)},oGrp11,048,008,'@E 9,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrFgts2",,)
oGet106    := TGet():New( 187,271,{|u| If(PCount()>0,nVlrPis2:=u,nVlrPis2)},oGrp11,048,008,'@E 9,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrPis2",,)
oGet107    := TGet():New( 201,271,{|u| If(PCount()>0,nVlr132:=u,nVlr132)},oGrp11,048,008,'@E 9,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlr132",,)
oGet108    := TGet():New( 215,271,{|u| If(PCount()>0,nVlrSodx2:=u,nVlrSodx2)},oGrp11,048,008,'@E 9,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrSodx2",,)
oGet109    := TGet():New( 229,271,{|u| If(PCount()>0,nVlrVTra2:=u,nVlrVTra2)},oGrp11,048,008,'@E 9,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrVTra2",,)

oGrp17     := TGroup():New( 067,351,245,473,"Detalhes da Evolução 3° Mes",oDlg1881,CLR_BLACK,CLR_WHITE,.T.,.F. )
oSay122    := TSay():New( 091,355,{||"Folha "},oGrp17,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,033,008)
oSay123    := TSay():New( 105,355,{||"Férias"},oGrp17,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,041,008)
oSay124    := TSay():New( 119,355,{||"Rescisão"},oGrp17,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,033,008)
oSay125    := TSay():New( 147,355,{||"I R"},oGrp17,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,033,008)
oSay126    := TSay():New( 161,355,{||"INSS"},oGrp17,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,033,009)
oSay127    := TSay():New( 133,355,{||"Pensão  "},oGrp17,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,036,009)
oSay128    := TSay():New( 077,427,{||"             Evolução "},oGrp17,,,.F.,.F.,.F.,.T.,CLR_RED,CLR_WHITE,044,008)
oSay129    := TSay():New( 077,355,{||"Competência "},oGrp17,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,036,008)
oSay130    := TSay():New( 175,355,{||"FGTS"},oGrp17,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,033,009)
oSay131    := TSay():New( 189,355,{||"PIS"},oGrp17,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,033,009)
oSay132    := TSay():New( 203,355,{||"13° "},oGrp17,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,033,009)
oSay143    := TSay():New( 217,355,{||"Sodexo"},oGrp17,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,033,009)
oSay145    := TSay():New( 231,355,{||"Vale Transporte"},oGrp17,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,039,009)

oSayFol3   := TSay():New( 091,447,{||"     100 %"},oGrp17,,,.F.,.F.,.F.,.T.,CLR_GREEN,CLR_WHITE,024,008)
oSayFer3   := TSay():New( 105,448,{||"     100 %"},oGrp17,,,.F.,.F.,.F.,.T.,CLR_GREEN,CLR_WHITE,024,008)
oSayRes3   := TSay():New( 119,448,{||"     100 %"},oGrp17,,,.F.,.F.,.F.,.T.,CLR_GREEN,CLR_WHITE,024,008)
oSayPen3   := TSay():New( 133,448,{||"     100 %"},oGrp17,,,.F.,.F.,.F.,.T.,CLR_GREEN,CLR_WHITE,024,008)
oSayIr3    := TSay():New( 147,448,{||"     100 %"},oGrp17,,,.F.,.F.,.F.,.T.,CLR_GREEN,CLR_WHITE,024,008)
oSayInss3  := TSay():New( 161,448,{||"     100 %"},oGrp17,,,.F.,.F.,.F.,.T.,CLR_GREEN,CLR_WHITE,024,008)
oSayFgts3  := TSay():New( 175,448,{||"     100 %"},oGrp17,,,.F.,.F.,.F.,.T.,CLR_GREEN,CLR_WHITE,024,008)
oSayPis3   := TSay():New( 189,448,{||"     100 %"},oGrp17,,,.F.,.F.,.F.,.T.,CLR_GREEN,CLR_WHITE,024,008)
oSay_133   := TSay():New( 203,448,{||"     100 %"},oGrp17,,,.F.,.F.,.F.,.T.,CLR_GREEN,CLR_WHITE,024,008)
oSaySod3   := TSay():New( 217,448,{||"     100 %"},oGrp17,,,.F.,.F.,.F.,.T.,CLR_GREEN,CLR_WHITE,024,008)
oSayVTan3  := TSay():New( 231,448,{||"     100 %"},oGrp17,,,.F.,.F.,.F.,.T.,CLR_GREEN,CLR_WHITE,024,008)

oGet110    := TGet():New( 089,395,{|u| If(PCount()>0,nVlrFol3:=u,nVlrFol3)},oGrp17,048,008,'@E 9,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrFol3",,)
oGet111    := TGet():New( 103,395,{|u| If(PCount()>0,nVlrFer3:=u,nVlrFer3)},oGrp17,048,008,'@E 9,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrFer3",,)
oGet112    := TGet():New( 117,395,{|u| If(PCount()>0,nVlrResc3:=u,nVlrResc3)},oGrp17,049,008,'@E 9,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrResc3",,)
oGet113    := TGet():New( 145,395,{|u| If(PCount()>0,nVlrIr3:=u,nVlrIr3)},oGrp17,048,008,'@E 9,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrIr3",,)
oGet114    := TGet():New( 159,395,{|u| If(PCount()>0,nVlrInss3:=u,nVlrInss3)},oGrp17,048,008,'@E 9,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrInss3",,)
oGet115    := TGet():New( 131,395,{|u| If(PCount()>0,nVlrPen3:=u,nVlrPen3)},oGrp17,048,008,' @E 9,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrPen3",,)
oGet116    := TGet():New( 075,395,{|u| If(PCount()>0,cCompt1:=u,cCompt3)},oGrp17,032,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cCompt1",,)
oGet157    := TGet():New( 173,395,{|u| If(PCount()>0,nVlrFgts3:=u,nVlrFgts3)},oGrp17,048,008,'@E 9,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrFgts3",,)
oGet160    := TGet():New( 187,395,{|u| If(PCount()>0,nVlrPis3:=u,nVlrPis3)},oGrp17,048,008,'@E 9,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrPis3",,)
oGet161    := TGet():New( 201,395,{|u| If(PCount()>0,nVlr133:=u,nVlr133)},oGrp17,048,008,'@E 9,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlr133",,)
oGet162    := TGet():New( 215,395,{|u| If(PCount()>0,nVlrSodx3:=u,nVlrSodx3)},oGrp17,048,008,'@E 9,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrSodx3",,)
oGet163    := TGet():New( 229,395,{|u| If(PCount()>0,nVlrVTra3:=u,nVlrVTra3)},oGrp17,048,008,'@E 9,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrVTra3",,)

oGrp2      := TGroup():New( 055,003,244,100,"Detalhes Competencia  Atual",oDlg1881,CLR_BLACK,CLR_WHITE,.T.,.F. )
oSay7      := TSay():New( 080,007,{||"Folha "},oGrp2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,033,008)
oSay8      := TSay():New( 095,007,{||"Férias"},oGrp2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,041,008)
oSay9      := TSay():New( 110,007,{||"Rescisão"},oGrp2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,033,008)
oSay10     := TSay():New( 140,007,{||"I R"},oGrp2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,033,008)
oSay15     := TSay():New( 155,007,{||"INSS"},oGrp2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,033,009)
oSay16     := TSay():New( 125,007,{||"Pensão  "},oGrp2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,036,009)
oSay70     := TSay():New( 065,007,{||"Competência "},oGrp2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,036,008)
oSay71     := TSay():New( 170,007,{||"FGTS"},oGrp2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,033,009)
oSay72     := TSay():New( 184,007,{||"PIS"},oGrp2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,033,009)
oSay73     := TSay():New( 200,007,{||"13° "},oGrp2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,033,009)
oSay137    := TSay():New( 214,007,{||"Sodexo"},oGrp2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,033,009)
oSay139    := TSay():New( 229,007,{||"Vale Transporte"},oGrp2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,039,009)
oGet7      := TGet():New( 078,047,{|u| If(PCount()>0,nVlrFol0:=u,nVlrFol0)},oGrp2,048,008,'@E 9,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrFol0",,)
oGet8      := TGet():New( 093,047,{|u| If(PCount()>0,nVlrFer0:=u,nVlrFer0)},oGrp2,048,008,'@E 9,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrFer0",,)
oGet9      := TGet():New( 108,047,{|u| If(PCount()>0,nVlrResc0:=u,nVlrResc0)},oGrp2,049,008,'@E 9,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrResc0",,)
oGet10     := TGet():New( 138,047,{|u| If(PCount()>0,nVlrIr0:=u,nVlrIr0)},oGrp2,048,008,'@E 9,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrIr0",,)
oGet15     := TGet():New( 153,047,{|u| If(PCount()>0,nVlrInss0:=u,nVlrInss0)},oGrp2,048,008,'@E 9,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrInss0",,)
oGet16     := TGet():New( 123,047,{|u| If(PCount()>0,nVlrPen0:=u,nVlrPen0)},oGrp2,048,008,' @E 9,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrPen0",,)
oGet164    := TGet():New( 063,047,{|u| If(PCount()>0,cCompt0:=u,cCompt0)},oGrp2,032,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cCompt0",,)
oGet205    := TGet():New( 168,047,{|u| If(PCount()>0,nVlrFgts0:=u,nVlrFgts0)},oGrp2,048,008,'@E 9,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrFgts0",,)
oGet206    := TGet():New( 183,047,{|u| If(PCount()>0,nVlrPis0:=u,nVlrPis0)},oGrp2,048,008,'@E 9,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrPis0",,)
oGet207    := TGet():New( 198,047,{|u| If(PCount()>0,nVlr130:=u,nVlr130)},oGrp2,048,008,'@E 9,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlr130",,)
oGet208    := TGet():New( 213,047,{|u| If(PCount()>0,nVlrSodx0:=u,nVlrSodx0)},oGrp2,048,008,'@E 9,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrSodx0",,)
oGet209    := TGet():New( 228,047,{|u| If(PCount()>0,nVlrVTra0:=u,nVlrVTra0)},oGrp2,048,008,'@E 9,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrVTra0",,)

oGrp28     := TGroup():New( 000,480,144,576,"Media 12 Meses ",oDlg1881,CLR_GREEN,CLR_WHITE,.T.,.F. )
oSay69     := TSay():New( 009,484,{||"Folha"},oGrp28,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay74     := TSay():New( 021,484,{||"Ferias "},oGrp28,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay75     := TSay():New( 033,484,{||"Rescisão "},oGrp28,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay76     := TSay():New( 045,484,{||"Pensão "},oGrp28,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay77     := TSay():New( 057,484,{||"IR"},oGrp28,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay78     := TSay():New( 069,484,{||"INSS"},oGrp28,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay80     := TSay():New( 081,484,{||"FGTS"},oGrp28,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay133    := TSay():New( 094,484,{||"PIS"},oGrp28,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay134    := TSay():New( 106,484,{||"13° "},oGrp28,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay135    := TSay():New( 118,484,{||"Sodexo "},oGrp28,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay136    := TSay():New( 130,484,{||"V.Transporte "},oGrp28,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,037,008)
oSay2      := TSay():New( 009,570,{||"$"},oGrp28,,,.F.,.F.,.F.,.T.,CLR_GREEN,CLR_WHITE,004,008)
oSay3      := TSay():New( 021,570,{||"$"},oGrp28,,,.F.,.F.,.F.,.T.,CLR_GREEN,CLR_WHITE,004,008)
oSay4      := TSay():New( 033,570,{||"$"},oGrp28,,,.F.,.F.,.F.,.T.,CLR_GREEN,CLR_WHITE,004,008)
oSay5      := TSay():New( 069,570,{||"$"},oGrp28,,,.F.,.F.,.F.,.T.,CLR_GREEN,CLR_WHITE,004,008)
oSay6      := TSay():New( 057,570,{||"$"},oGrp28,,,.F.,.F.,.F.,.T.,CLR_GREEN,CLR_WHITE,004,008)
oSay7      := TSay():New( 045,570,{||"$"},oGrp28,,,.F.,.F.,.F.,.T.,CLR_GREEN,CLR_WHITE,004,008)
oSay9      := TSay():New( 094,570,{||"$"},oGrp28,,,.F.,.F.,.F.,.T.,CLR_GREEN,CLR_WHITE,004,008)
oSay10     := TSay():New( 081,570,{||"$"},oGrp28,,,.F.,.F.,.F.,.T.,CLR_GREEN,CLR_WHITE,004,008)
oSay11     := TSay():New( 130,570,{||"$"},oGrp28,,,.F.,.F.,.F.,.T.,CLR_GREEN,CLR_WHITE,004,008)
oSay12     := TSay():New( 118,570,{||"$"},oGrp28,,,.F.,.F.,.F.,.T.,CLR_GREEN,CLR_WHITE,004,008)
oSay13     := TSay():New( 106,570,{||"$"},oGrp28,,,.F.,.F.,.F.,.T.,CLR_GREEN,CLR_WHITE,004,008)
oGet210    := TGet():New( 128,524,{|u| If(PCount()>0,nMVTra12M:=u,nMVTra12M)},oGrp28,044,008,'@E 99,999,999.99',,CLR_GREEN,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nMVTra12M",,)
oGet211    := TGet():New( 116,524,{|u| If(PCount()>0,nMSod12M:=u,nMSod12M)},oGrp28,044,008,'@E 99,999,999.99',,CLR_GREEN,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nMSod12M",,)
oGet213    := TGet():New( 092,524,{|u| If(PCount()>0,nMPis12M:=u,nMPis12M)},oGrp28,044,008,'@E 99,999,999.99',,CLR_GREEN,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nMPis12M",,)
oGet214    := TGet():New( 080,524,{|u| If(PCount()>0,nMFgts12M:=u,nMFgts12M)},oGrp28,044,008,'@E 99,999,999.99',,CLR_GREEN,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nMFgts12M",,)
oGet215    := TGet():New( 068,524,{|u| If(PCount()>0,nMInss12M:=u,nMInss12M)},oGrp28,044,008,'@E 99,999,999.99',,CLR_GREEN,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nMInss12M",,)
oGet218    := TGet():New( 044,524,{|u| If(PCount()>0,nMPen12M:=u,nMPen12M)},oGrp28,044,008,'@E 99,999,999.99',,CLR_GREEN,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nMPen12M",,)
oGet219    := TGet():New( 032,524,{|u| If(PCount()>0,nMRes12M:=u,nMRes12M)},oGrp28,044,008,'@E 99,999,999.99',,CLR_GREEN,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nMRes12M",,)
oGet220    := TGet():New( 020,524,{|u| If(PCount()>0,nMFer12M:=u,nMFer12M)},oGrp28,044,008,'@E 99,999,999.99',,CLR_GREEN,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nMFer12M",,)
oGet221    := TGet():New( 008,524,{|u| If(PCount()>0,nMFol12M:=u,nMFol12M)},oGrp28,044,008,'@E 99,999,999.99',,CLR_GREEN,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nMFol12M",,)
oGet222    := TGet():New( 104,524,{|u| If(PCount()>0,nM1312M:=u,nM1312M)},oGrp28,044,008,'@E 99,999,999.99',,CLR_GREEN,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nM1312M",,)
oGet223    := TGet():New( 056,524,{|u| If(PCount()>0,nMIr12M:=u,nMIr12M)},oGrp28,044,008,'@E 99,999,999.99',,CLR_GREEN,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nMIr12M",,)
oGrp30     := TGroup():New( 148,480,292,576,"Media 6 Meses",oDlg1881,CLR_BLUE,CLR_WHITE,.T.,.F. )
oSay245    := TSay():New( 157,484,{||"Folha"},oGrp30,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay246    := TSay():New( 169,484,{||"Ferias "},oGrp30,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay247    := TSay():New( 181,484,{||"Rescisão "},oGrp30,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay248    := TSay():New( 193,484,{||"Pensão "},oGrp30,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay249    := TSay():New( 204,484,{||"IR"},oGrp30,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay254    := TSay():New( 217,484,{||"INSS"},oGrp30,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay255    := TSay():New( 229,484,{||"FGTS"},oGrp30,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay256    := TSay():New( 242,484,{||"PIS"},oGrp30,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay257    := TSay():New( 254,484,{||"13° "},oGrp30,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay258    := TSay():New( 266,484,{||"Sodexo "},oGrp30,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay259    := TSay():New( 278,484,{||"V.Transporte "},oGrp30,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,037,008)
oSay8      := TSay():New( 204,570,{||"$"},oGrp30,,,.F.,.F.,.F.,.T.,CLR_GREEN,CLR_WHITE,004,008)
oSay14     := TSay():New( 193,570,{||"$"},oGrp30,,,.F.,.F.,.F.,.T.,CLR_GREEN,CLR_WHITE,004,008)
oSay15     := TSay():New( 181,570,{||"$"},oGrp30,,,.F.,.F.,.F.,.T.,CLR_GREEN,CLR_WHITE,004,008)
oSay16     := TSay():New( 169,570,{||"$"},oGrp30,,,.F.,.F.,.F.,.T.,CLR_GREEN,CLR_WHITE,004,008)
oSay17     := TSay():New( 157,570,{||"$"},oGrp30,,,.F.,.F.,.F.,.T.,CLR_GREEN,CLR_WHITE,004,008)
oSay18     := TSay():New( 242,570,{||"$"},oGrp30,,,.F.,.F.,.F.,.T.,CLR_GREEN,CLR_WHITE,004,008)
oSay19     := TSay():New( 254,570,{||"$"},oGrp30,,,.F.,.F.,.F.,.T.,CLR_GREEN,CLR_WHITE,004,008)
oSay20     := TSay():New( 217,570,{||"$"},oGrp30,,,.F.,.F.,.F.,.T.,CLR_GREEN,CLR_WHITE,004,008)
oSay21     := TSay():New( 266,570,{||"$"},oGrp30,,,.F.,.F.,.F.,.T.,CLR_GREEN,CLR_WHITE,004,008)
oSay22     := TSay():New( 229,570,{||"$"},oGrp30,,,.F.,.F.,.F.,.T.,CLR_GREEN,CLR_WHITE,004,008)
oSay23     := TSay():New( 278,570,{||"$"},oGrp30,,,.F.,.F.,.F.,.T.,CLR_GREEN,CLR_WHITE,004,008)
oGet233    := TGet():New( 156,524,{|u| If(PCount()>0,nMFol6M:=u,nMFol6M)},oGrp30,044,008,'@E 99,999,999.99',,CLR_GREEN,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nMFol6M",,)
oGet234    := TGet():New( 168,524,{|u| If(PCount()>0,nMFer6M:=u,nMFer6M)},oGrp30,044,008,'@E 99,999,999.99',,CLR_GREEN,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nMFer6M",,)
oGet235    := TGet():New( 180,524,{|u| If(PCount()>0,nMRes6M:=u,nMRes6M)},oGrp30,044,008,'@E 99,999,999.99',,CLR_GREEN,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nMRes6M",,)
oGet236    := TGet():New( 192,524,{|u| If(PCount()>0,nMPen6M:=u,nMPen6M)},oGrp30,044,008,'@E 99,999,999.99',,CLR_GREEN,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nMPen6M",,)
oGet237    := TGet():New( 204,524,{|u| If(PCount()>0,nMIr6M:=u,nMIr6M)},oGrp30,044,008,'@E 99,999,999.99',,CLR_GREEN,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nMIr6M",,)
oGet238    := TGet():New( 216,524,{|u| If(PCount()>0,nMInss6M:=u,nMInss6M)},oGrp30,044,008,'@E 99,999,999.99',,CLR_GREEN,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nMInss6M",,)
oGet239    := TGet():New( 228,524,{|u| If(PCount()>0,nMFgts6M:=u,nMFgts6M)},oGrp30,044,008,'@E 99,999,999.99',,CLR_GREEN,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nMFgts6M",,)
oGet240    := TGet():New( 240,524,{|u| If(PCount()>0,nMPis6M:=u,nMPis6M)},oGrp30,044,008,'@E 99,999,999.99',,CLR_GREEN,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nMPis6M",,)
oGet241    := TGet():New( 252,524,{|u| If(PCount()>0,nM136M:=u,nM136M)},oGrp30,044,008,'@E 99,999,999.99',,CLR_GREEN,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nM136M",,)
oGet242    := TGet():New( 264,524,{|u| If(PCount()>0,nMSod6M:=u,nMSod6M)},oGrp30,044,008,'@E 99,999,999.99',,CLR_GREEN,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nMSod6M",,)
oGet243    := TGet():New( 276,524,{|u| If(PCount()>0,nMVTra6M:=u,nMVTra6M)},oGrp30,044,008,'@E 99,999,999.99',,CLR_GREEN,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nMVTra6M",,)

	If nSaldo <= 0  .Or. trim(cVisto) <> '0' .Or. !lCertif  .or. cMostLib == 1  .Or.  _UserLog != _cIdUsuar 
		oBtn1:DISABLE() 
		a:='b' 
	EndIf

  fCalcEst()
  
oDlg1881:Activate(,,,.T.)
oMGet1:SetFocus
   
Return(.T.)


Static Function Perg188(cPerg)
    u_CABASX1(cPerg,"01",OemToAnsi("Ano Base")			     ,"","","mv_ch1","C",04,0,0,"G","","","","","mv_par01",   "","","","",   "","","","","","","","","","","","",{},{},{})
    u_CABASX1(cPerg,"02",OemToAnsi("Mes Base")			     ,"","","mv_ch2","C",02,0,0,"G","","","","","mv_par02",   "","","","",   "","","","","","","","","","","","",{},{},{})
    u_CABASX1(cPerg,"03",OemToAnsi("Exib. Aprov/Liquidados?"),"","","mv_ch3","N",01,0,0,"C","","","","","mv_par03","Sim","","","","Não","","","","","","","","","","","",{},{},{}) 
	u_CABASX1(cPerg,"04",OemToAnsi("Id Usuario ")			 ,"","","mv_ch4","C",06,0,0,"G","","","","","mv_par04",   "","","","",   "","","","","","","","","","","","",{},{},{})

Return

User function fscr( chavescr , aprovador, tpaprova, aliasapr , cObs)

local lret       := .F.
local spcScr     := Space(50-len(chavescr))

	DbSelectArea("SCR")
	SCR->(DbSetOrder(2))	// CR_FILIAL+CR_TIPO+CR_NUM+CR_USER
	if SCR->(DbSeek(xFilial("SCR") + aliasapr +chavescr+spcScr+_cIdUsuar))

		/*
		If DbSeek(xFilial("SCR") + aliasapr +chavescr+_cIdUsuar)
			Reclock("SCR",.F.)		
		
			If  SCR->CR_STATUS == "01"
				If tpaprova == 'A'
				SCR->CR_STATUS := "03"
				SCR->CR_obs := 'Liberado pela Rotina Caba188' 
				Else 
				SCR->CR_STATUS := "02"
				SCR->CR_obs := 'Vistado pela Rotina Caba188'
				Endif

			Else 

				A:= 'b'

			EndIf 
			
			MsUnlock()
		
		Else 

		StMaAlcDoc:= MaAlcDoc({cRegSCR, "FL", (cAliastmp)->VALOR,(cAliastmp)->APROV,, (cAliastmp)->CodAlc ,,,,dDataBase, cObs}, dDataBase, If(tpaprova== 'A',4,1) )   

		EndIf
		*/

		StMaAlcDoc:= MaAlcDoc({cRegSCR, "FL", (cAliastmp)->VALOR,(cAliastmp)->APROV,, (cAliastmp)->CodAlc ,,,,dDataBase, cObs}, dDataBase, If(tpaprova== 'A',4,1) ) 
	
	endif

Return()
///////////////////////////////////////
static function resumo7()

local aLogFol7   := {}
local nTotSalT   := 0.00
local nTotSal    := 0.00	
local nTotQtda   := 0.00
local nTotQtdaT  := 0.00

local nTotQtdap  := 0.00
local nTotSalP   := 0.00

cQuery7 :=        "  select '00 - Caberj ' empresa, 
cQuery7 += CRLF + "         case when (ra_demissa = ' ' and  ra_admissa < '"+cAno+cmes+"01') then '1 - Folha'  
cQuery7 += CRLF + "              when ra_demissa >= '"+cAno+cmes+"01' and ra_demissa <= '"+cAno+cmes+"31' then '3 - Demitidos no Mes'  
cQuery7 += CRLF + "              when (ra_demissa = ' ' and ra_admissa >= '"+cAno+cmes+"01' and ra_admissa <= '"+cAno+cmes+"31') then '2 - Admitidos no Mes' 
cQuery7 += CRLF + "          End demadm1,  
cQuery7 += CRLF + "         sum( case when (ra_demissa = ' ' and  ra_admissa < '"+cAno+cmes+"01') then ra_salario   
cQuery7 += CRLF + "                   when ra_demissa >= '"+cAno+cmes+"01' and ra_demissa <= '"+cAno+cmes+"31' then (ra_salario*-1)   
cQuery7 += CRLF + "                   when (ra_demissa = ' ' and ra_admissa >= '"+cAno+cmes+"01' and ra_admissa <= '"+cAno+cmes+"31') then ra_salario  
cQuery7 += CRLF + "               End )demadm, 
cQuery7 += CRLF + "         sum( case when (ra_demissa = ' ' and  ra_admissa < '"+cAno+cmes+"01') then 1   
cQuery7 += CRLF + "                   when ra_demissa >= '"+cAno+cmes+"01' and ra_demissa <= '"+cAno+cmes+"31' then -1   
cQuery7 += CRLF + "                   when (ra_demissa = ' ' and ra_admissa >= '"+cAno+cmes+"01' and ra_admissa <= '"+cAno+cmes+"31') then 1  
cQuery7 += CRLF + "               End )demadmq  
cQuery7 += CRLF + "    from sra010 sra 
cQuery7 += CRLF + "   where ra_FILIAL = '01' AND sra.D_e_l_e_t_ = ' ' 
cQuery7 += CRLF + "     and (RA_DEMISSA = ' ' OR (RA_DEMISSA >= '"+cAno+cmes+"01' AND RA_DEMISSA <= '"+cAno+cmes+"31')) 
cQuery7 += CRLF + "     and ra_admissa <= '"+cAno+cmes+"31' 
cQuery7 += CRLF + "     and RA_SALARIO > 0 
cQuery7 += CRLF + "   group by case when (ra_demissa = ' ' and  ra_admissa < '"+cAno+cmes+"01') then '1 - Folha'  
cQuery7 += CRLF + "                 when ra_demissa >= '"+cAno+cmes+"01' and ra_demissa <= '"+cAno+cmes+"31' then '3 - Demitidos no Mes'  
cQuery7 += CRLF + "                 when (ra_demissa = ' ' and ra_admissa >= '"+cAno+cmes+"01' and ra_admissa <= '"+cAno+cmes+"31') then '2 - Admitidos no Mes' End 
cQuery7 += CRLF + "   Order by 1,2

	If  Select((cAliastmp7)) <> 0 
			(cAliastmp7)->(DbCloseArea())  
	Endif      

	TcQuery cQuery7 New Alias (cAliasTMP7)  

	(cAliasTMP7)->(dbGoTop())    

    While !(cAliastmp7)->(EOF())

	    nTotSalT := (cAliastmp7)->demadm + nTotSalT
        nTotQtdaT := (cAliastmp7)->demadmq + nTotQtdaT

		(cAliastmp7)->(DbSkip())

	endDo

	(cAliasTMP7)->(dbGoTop())    

    While !(cAliastmp7)->(EOF())

          nTotQtdaP  := ((cAliastmp7)->demadmq / nTotQtdaT)*100 
          nTotSalP   := ((cAliastmp7)->demadm  / nTotSalT)*100 
            
		aAdd(aLogFol7,{ TRIM((cAliastmp7)->Empresa ),;  
                        TRIM((cAliastmp7)->demadm1) ,;  
				   transform(((cAliastmp7)->demadm),"@E 999,999,999.99"),;
				   transform(((cAliastmp7)->demadmq),"@E 99,999") ,;
				   transform(nTotSalP,"@E 999.999%") ,;
				   transform(nTotQtdap,"@E 999.999%") })     //3 
		
		    nTotSal := ((cAliastmp7)->demadm + nTotSal)
			nTotQtda :=((cAliastmp7)->demadmq + nTotQtda) 
			
			(cAliastmp7)->(DbSkip())
    EndDo

            aAdd(aLogfol7,{ ' '   ,; 
				    		' '   ,;
					    	' '   ,;
							' '   ,;
					    	' '   ,;    
		           			' '   })     //3 

            aAdd(aLogfol7,{ ' '    ,; 
				    		'Totais ------>'         ,;    
		           			transform((nTotSal),"@E 999,999,999.99"),;
							transform((nTotQtda),"@E 99,999"),;
							'100.00%' ,;
							'100.00%'})     //3 

            PLSCRIGEN(aLogfol7,{{'Empresa ',"@!",50}      ,;
							    {'Tp Movimento' ,"@!",70} ,;
							    {'Salario ' ,"@!",40}     ,;
								{'Qtda    ' ,"@!",40}     ,;
								{'Prop. Salario ' ,"@!",40}     ,;
								{'Prop. Qtda    ' ,"@!",40} }   ,;
								'Detalhes da Folha da Competencia '+cano+'/'+cMes+' - Por Empresa',nil,nil)

return( )

///////////////////////////////////////
static function resumo4()
local aLogFol4   := {}
local nTotSal    := 0.00	
local nTotQtda   := 0.00
local nSal       := 0.00	
local nQtda      := 0.00
local cCustoN1   :=' ' 

local nTotSalT   := 0.00
local nTotQtdaT  := 0.00

local nTotQtdap  := 0.00
local nTotSalP   := 0.00


cQuery4 :=        "select ctt2.ctt_custo custo1 , TRIM(ctt2.ctt_desc01) desc1 , 
cQuery4 += CRLF + "       case when (ra_demissa = ' ' and ra_admissa < '"+cAno+cmes+"01') then '1 - Folha' "  
cQuery4 += CRLF + "            when ra_demissa >= '"+cAno+cmes+"01' and ra_demissa <= '"+cAno+cmes+"31' then '3 - Demitidos no Mes' "  
cQuery4 += CRLF + "            when (ra_demissa = ' ' and ra_admissa >= '"+cAno+cmes+"01' and ra_admissa <= '"+cAno+cmes+"31') then '2 - Admitidos no Mes' " 
cQuery4 += CRLF + "        End demadm1 , "  
cQuery4 += CRLF + "        sum( case when (ra_demissa = ' ' and ra_admissa < '"+cAno+cmes+"01') then ra_salario "   
cQuery4 += CRLF + "                  when ra_demissa >= '"+cAno+cmes+"01' and ra_demissa <= '"+cAno+cmes+"31' then (ra_salario*-1) "   
cQuery4 += CRLF + "                  when (ra_demissa = ' ' and ra_admissa >= '"+cAno+cmes+"01' and ra_admissa <= '"+cAno+cmes+"31') then ra_salario " 
cQuery4 += CRLF + "             End )demadm , " 
cQuery4 += CRLF + "        sum(case when (ra_demissa = ' ' and ra_admissa < '"+cAno+cmes+"01') then 1 "
cQuery4 += CRLF + "                 when ra_demissa >= '"+cAno+cmes+"01' and ra_demissa <= '"+cAno+cmes+"31' then -1 "   
cQuery4 += CRLF + "                 when (ra_demissa = ' ' and ra_admissa >= '"+cAno+cmes+"01' and ra_admissa <= '"+cAno+cmes+"31') then 1 "  
cQuery4 += CRLF + "             End )demadmq " 
cQuery4 += CRLF + "  from sra010 sra , ctt010 ctt1 , ctt010 ctt2 "
cQuery4 += CRLF + " where ra_FILIAL = '01' AND sra.D_e_l_e_t_ = ' ' " 

cQuery4 += CRLF + "   and ctt1.ctt_filial ='01' and ctt1.d_E_L_E_T_ =' ' " 
cQuery4 += CRLF + "   and ctt2.ctt_filial ='01' and ctt2.d_E_L_E_T_ =' ' "
cQuery4 += CRLF + "   and (ctt1.ctt_dtexsf = ' ' or ctt1.ctt_dtexsf <= '"+cAno+cmes+"01') "  
cQuery4 += CRLF + "   AND (RA_DEMISSA = ' ' OR (RA_DEMISSA >= '"+cAno+cmes+"01' AND RA_DEMISSA <= '"+cAno+cmes+"31')) " 
cQuery4 += CRLF + "   and ra_admissa <= '"+cAno+cmes+"31' "
cQuery4 += CRLF + "   AND RA_SALARIO > 0 "
cQuery4 += CRLF + "   and ra_cc = ctt1.ctt_custo "
cQuery4 += CRLF + "   and substr(ctt1.ctt_custo,1,2) = trim(ctt2.ctt_custo) " 
cQuery4 += CRLF + " group by ctt2.ctt_custo , ctt2.ctt_desc01 ," 
cQuery4 += CRLF + "          case when (ra_demissa = ' ' and  ra_admissa < '"+cAno+cmes+"01') then '1 - Folha' " 
cQuery4 += CRLF + "               when ra_demissa >= '"+cAno+cmes+"01' and ra_demissa <= '"+cAno+cmes+"31' then '3 - Demitidos no Mes' "  
cQuery4 += CRLF + "               when (ra_demissa = ' ' and ra_admissa >= '"+cAno+cmes+"01' and ra_admissa <= '"+cAno+cmes+"31') then '2 - Admitidos no Mes' End " 
cQuery4 += CRLF + " Order by 1,3 "

	If  Select((cAliastmp4)) <> 0 
			(cAliastmp4)->(DbCloseArea())  
	Endif      

	TcQuery cQuery4 New Alias (cAliasTMP4)  

		(cAliasTMP4)->(dbGoTop())    

    While !(cAliastmp4)->(EOF())

	    nTotSalT  :=  (cAliastmp4)->demadm + nTotSalT
        nTotQtdaT := (cAliastmp4)->demadmq + nTotQtdaT

		(cAliastmp4)->(DbSkip())

	endDo


	(cAliasTMP4)->(dbGoTop())    

    While !(cAliastmp4)->(EOF())

            If cCustoN1   ==' '
            
			   cCustoN1   :=TRIM((cAliastmp4)->custo1)
            
			elseIf cCustoN1 !=TRIM((cAliastmp4)->custo1)  

				
				aAdd(aLogfol4,{ ' '    ,; 
								'Sub Totais --->'   ,;    
								transform((nSal),"@E 999,999,999.99"),;
								transform((nQtda),"@E 99,999")       ,;
								transform(((nSal/nTotSalT)*100),"@E 999.999%") ,;
								transform(((nQtda/nTotQtdaT)*100),"@E 999.999%") })     
								//3 
                
				aAdd(aLogfol4,{ ' '   ,; 
								' '   ,;
								' '   ,;   
								' '   ,;  
								' '   ,;
								' '   })     //3 

				nSal       := 0.00	
				nQtda      := 0.00
			    cCustoN1   :=TRIM((cAliastmp4)->custo1)

            EndIf 
			aAdd(aLogFol4,{ TRIM((cAliastmp4)->custo1)+' - '+TRIM((cAliastmp4)->desc1) ,;  
                            TRIM((cAliastmp4)->demadm1) ,;  
					   transform(((cAliastmp4)->demadm),"@E 999,999,999.99"),;
					   transform(((cAliastmp4)->demadmq),"@E 99,999")       ,;
					   transform((((cAliastmp4)->demadm/nTotSalT)*100),"@E 999.999%"),;
					   transform((((cAliastmp4)->demadmq/nTotQtdaT)*100),"@E 999.999%")})     //3 
		
		    nTotQtda := (cAliastmp4)->demadmq + nTotQtda
			nQtda    := (cAliastmp4)->demadmq + nQtda
		                      
			nTotSal  := (cAliastmp4)->demadm + nTotSal 
			nSal     := (cAliastmp4)->demadm + nSal 			

			(cAliastmp4)->(DbSkip())
    EndDo

            aAdd(aLogfol4,{ ' '    ,; 
								'Sub Totais --->'   ,;    
								transform((nSal),"@E 999,999,999.99"),;
								transform((nQtda),"@E 99,999") ,;
								transform(((nSal/nTotSalT)*100),"@E 999.999%") ,;
								transform(((nQtda/nTotQtdaT)*100),"@E 999.999%") })     //3 
            aAdd(aLogfol4,{ ' '   ,; 
				    		' '   ,;
					    	' '   ,;
							' '   ,;
					    	' '   ,;    
		           			' '   })     //3 

            aAdd(aLogfol4,{ ' '    ,; 
				    		'Totais ------>'         ,;    
		           			transform((nTotSal),"@E 999,999,999.99"),;
							transform((nTotQtda),"@E 99,999") ,;
							'100.00%' ,;
							'100.00%' })     //3 
 			

            PLSCRIGEN(aLogfol4,{{'Diretoria ',"@!",50}    ,;
							    {'Tp Movimento' ,"@!",70} ,;
							    {'Salario ' ,"@!",40}     ,;
								{'Qtda    ' ,"@!",40}     ,;
                                {'Prop. Salario ' ,"@!",40}     ,;
								{'Prop. Qtda    ' ,"@!",40} }     ,;
								'Detalhes da Folha da Competencia '+cano+'/'+cMes+' - Por Diretoria',nil,nil)
return( )
//////////////////////////////////
static function resumo5()
local aLogFol5   := {}
local nTotSal    := 0.00	
local nTotQtda   := 0.00

local nSal       := 0.00	
local nQtda      := 0.00

local nTotSalT   := 0.00
local nTotQtdaT  := 0.00

local nTotQtdap  := 0.00
local nTotSalP   := 0.00

local cCustoN1N2 :=' ' 

cQuery5 :=        "select ctt2.ctt_custo custo1 , TRIM(ctt2.ctt_desc01) desc1 , RA_CC custo2 ,  TRIM(ctt1.ctt_desc01) desc2 , " 
cQuery5 += CRLF + "       case when (ra_demissa = ' ' and ra_admissa < '"+cAno+cmes+"01') then '1 - Folha' "  
cQuery5 += CRLF + "            when ra_demissa >= '"+cAno+cmes+"01' and ra_demissa <= '"+cAno+cmes+"31' then '3 - Demitidos no Mes' "  
cQuery5 += CRLF + "            when (ra_demissa = ' ' and ra_admissa >= '"+cAno+cmes+"01' and ra_admissa <= '"+cAno+cmes+"31') then '2 - Admitidos no Mes' " 
cQuery5 += CRLF + "        End demadm1 , "  
cQuery5 += CRLF + "        sum( case when (ra_demissa = ' ' and ra_admissa < '"+cAno+cmes+"01') then ra_salario "   
cQuery5 += CRLF + "                  when ra_demissa >= '"+cAno+cmes+"01' and ra_demissa <= '"+cAno+cmes+"31' then (ra_salario*-1) "   
cQuery5 += CRLF + "                  when (ra_demissa = ' ' and ra_admissa >= '"+cAno+cmes+"01' and ra_admissa <= '"+cAno+cmes+"31') then ra_salario " 
cQuery5 += CRLF + "             End )demadm , " 
cQuery5 += CRLF + "        sum(case when (ra_demissa = ' ' and ra_admissa < '"+cAno+cmes+"01') then 1 "
cQuery5 += CRLF + "                 when ra_demissa >= '"+cAno+cmes+"01' and ra_demissa <= '"+cAno+cmes+"31' then -1 "   
cQuery5 += CRLF + "                 when (ra_demissa = ' ' and ra_admissa >= '"+cAno+cmes+"01' and ra_admissa <= '"+cAno+cmes+"31') then 1 "  
cQuery5 += CRLF + "             End )demadmq " 
cQuery5 += CRLF + "  from sra010 sra , ctt010 ctt1 , ctt010 ctt2 " 
cQuery5 += CRLF + " where ra_FILIAL = '01' AND sra.D_e_l_e_t_ = ' ' " 
cQuery5 += CRLF + "   and ctt1.ctt_filial ='01' and ctt1.d_E_L_E_T_ =' ' " 
cQuery5 += CRLF + "   and ctt2.ctt_filial ='01' and ctt2.d_E_L_E_T_ =' ' "
cQuery5 += CRLF + "   and (ctt1.ctt_dtexsf = ' ' or ctt1.ctt_dtexsf <= '"+cAno+cmes+"01') "  
cQuery5 += CRLF + "   AND (RA_DEMISSA = ' ' OR (RA_DEMISSA >= '"+cAno+cmes+"01' AND RA_DEMISSA <= '"+cAno+cmes+"31')) " 
cQuery5 += CRLF + "   and ra_admissa <= '"+cAno+cmes+"31' "
cQuery5 += CRLF + "   AND RA_SALARIO > 0 "
cQuery5 += CRLF + "   and ra_cc = ctt1.ctt_custo "
cQuery5 += CRLF + "   and substr(ctt1.ctt_custo,1,2) = trim(ctt2.ctt_custo) " 
cQuery5 += CRLF + " group by ctt2.ctt_custo , ctt2.ctt_desc01 ,RA_CC, ctt1.ctt_desc01 , " 
cQuery5 += CRLF + "          case when (ra_demissa = ' ' and  ra_admissa < '"+cAno+cmes+"01') then '1 - Folha' " 
cQuery5 += CRLF + "               when ra_demissa >= '"+cAno+cmes+"01' and ra_demissa <= '"+cAno+cmes+"31' then '3 - Demitidos no Mes' "  
cQuery5 += CRLF + "               when (ra_demissa = ' ' and ra_admissa >= '"+cAno+cmes+"01' and ra_admissa <= '"+cAno+cmes+"31') then '2 - Admitidos no Mes' End " 
cQuery5 += CRLF + " Order by 1,3,5 "

	If  Select((cAliastmp5)) <> 0 
			(cAliastmp5)->(DbCloseArea())  
	Endif      

	TcQuery cQuery5 New Alias (cAliasTMP5)  

		(cAliasTMP5)->(dbGoTop())    

    While !(cAliastmp5)->(EOF())

	    nTotSalT  :=  (cAliastmp5)->demadm + nTotSalT
        nTotQtdaT := (cAliastmp5)->demadmq + nTotQtdaT

		(cAliastmp5)->(DbSkip())

	EndDo 

	(cAliasTMP5)->(dbGoTop())    

    While !(cAliastmp5)->(EOF())

            If cCustoN1N2 == ' '
            
			   cCustoN1N2 :=TRIM((cAliastmp5)->custo1)+TRIM((cAliastmp5)->custo2)
            
			elseIf cCustoN1N2 !=TRIM((cAliastmp5)->custo1)+TRIM((cAliastmp5)->custo2) 

            aAdd(aLogfol5,{ ' '    ,; 
				    		'Sub Totais --->'  ,;
					    	' '   ,;     
		           			transform((nSal),"@E 999,999,999.99"),;
							transform((nQtda),"@E 99,999")       ,;
							transform(((nSal/nTotSalT)*100),"@E 999.999%"),;
					        transform(((nQtda/nTotQtdaT)*100),"@E 999.999%")})     //3

            aAdd(aLogfol5,{ ' '   ,; 
				    		' '   ,;
					    	' '   ,;   
							' '   ,;  
							' '   ,;   
							' '   ,; 
		           			' '   })     //3 

				nSal       := 0.00	
				nQtda      := 0.00
                cCustoN1N2 :=TRIM((cAliastmp5)->custo1)+TRIM((cAliastmp5)->custo2)
            
			EndIf 

			aAdd(aLogFol5,{ TRIM((cAliastmp5)->custo1)+' - '+TRIM((cAliastmp5)->desc1) ,; 
							TRIM((cAliastmp5)->custo2)+' - '+TRIM((cAliastmp5)->desc2) ,; 
                            TRIM((cAliastmp5)->demadm1) ,;  
					   transform(((cAliastmp5)->demadm),"@E 999,999,999.99") ,;
					   transform(((cAliastmp5)->demadmq),"@E 99,999") ,;
					   transform((((cAliastmp5)->demadm/nTotSalT)*100),"@E 999.999%"),;
					   transform((((cAliastmp5)->demadmq/nTotQtdaT)*100),"@E 999.999%")})     //3 
		
		    nTotQtda := (cAliastmp5)->demadmq + nTotQtda
			nQtda    := (cAliastmp5)->demadmq + nQtda
		                      
			nTotSal  := (cAliastmp5)->demadm + nTotSal 
			nSal     := (cAliastmp5)->demadm + nSal 	

			(cAliastmp5)->(DbSkip())

    EndDo

            aAdd(aLogfol5,{ ' '    ,; 
				    		'Sub Totais --->'  ,;
					    	' '   ,;     
		           			transform((nSal),"@E 999,999,999.99"),;
							transform((nQtda),"@E 99,999") ,;
                            transform(((nSal/nTotSalT)*100),"@E 999.999%"),;
					        transform(((nQtda/nTotQtdaT)*100),"@E 999.999%")})     //3

            aAdd(aLogfol5,{ ' '   ,; 
				    		' '   ,;
					    	' '   ,;   
							' '   ,;
							' '   ,;   
							' '   ,;  
		           			' '   })     //3 

            aAdd(aLogfol5,{ ' '    ,; 
				    		'Totais ------>'         ,;
					    	' '   ,;     
		           			transform((nTotSal),"@E 999,999,999.99"),;
							transform((nTotQtda),"@E 99,999"),;
							'100.00%' ,;
							'100.00%'})     //3 
 			
            PLSCRIGEN(aLogfol5,{{'Diretoria ',"@!",50}    ,;
							    {'Departamento ',"@!",70} ,;
							    {'Tp Movimento' ,"@!",70} ,;
							    {'Salario ' ,"@!",40}     ,;
								{'Qtda    ' ,"@!",40}     ,;
								{'Prop. Salario ' ,"@!",40}    ,;
								{'Prop. Qtda    ' ,"@!",40}}   ,;
								'Detalhes da Folha da Competencia '+cano+'/'+cMes+' - Por Departamento',nil,nil)
return( )
//////////////////////////////////
static function resumo6()
local aLogFol6:= {}
local nTotSal    := 0.00	
local nTotQtda   := 0.00
local nSal       := 0.00	
local nQtda      := 0.00

local nTotSalT   := 0.00
local nTotQtdaT  := 0.00

local nTotQtdap  := 0.00
local nTotSalP   := 0.00

local cCustoN1N2 :=' ' 

cQuery6 :=        "select ctt2.ctt_custo custo1 , TRIM(ctt2.ctt_desc01) desc1 , RA_CC custo2 ,  TRIM(ctt1.ctt_desc01) desc2 , " 
cQuery6 += CRLF + "       ra_mat matric, ra_nome nome  ,  SRJ.RJ_DESC RJdESC , "
cQuery6 += CRLF + "       case when (ra_demissa = ' ' and ra_admissa < '"+cAno+cmes+"01') then '1 - Folha' "  
cQuery6 += CRLF + "            when ra_demissa >= '"+cAno+cmes+"01' and ra_demissa <= '"+cAno+cmes+"31' then '3 - Demitidos no Mes' "  
cQuery6 += CRLF + "            when (ra_demissa = ' ' and ra_admissa >= '"+cAno+cmes+"01' and ra_admissa <= '"+cAno+cmes+"31') then '2 - Admitidos no Mes' " 
cQuery6 += CRLF + "        End demadm1 , "  
cQuery6 += CRLF + "        sum( case when (ra_demissa = ' ' and ra_admissa < '"+cAno+cmes+"01') then ra_salario "   
cQuery6 += CRLF + "                  when ra_demissa >= '"+cAno+cmes+"01' and ra_demissa <= '"+cAno+cmes+"31' then (ra_salario*-1) "   
cQuery6 += CRLF + "                  when (ra_demissa = ' ' and ra_admissa >= '"+cAno+cmes+"01' and ra_admissa <= '"+cAno+cmes+"31') then ra_salario " 
cQuery6 += CRLF + "             End )demadm , " 
cQuery6 += CRLF + "        sum(case when (ra_demissa = ' ' and ra_admissa < '"+cAno+cmes+"01') then 1 "
cQuery6 += CRLF + "                 when ra_demissa >= '"+cAno+cmes+"01' and ra_demissa <= '"+cAno+cmes+"31' then -1 "   
cQuery6 += CRLF + "                 when (ra_demissa = ' ' and ra_admissa >= '"+cAno+cmes+"01' and ra_admissa <= '"+cAno+cmes+"31') then 1 "  
cQuery6 += CRLF + "             End )demadmq " 
cQuery6 += CRLF + "  from sra010 sra , ctt010 ctt1 , ctt010 ctt2 , SRJ010 SRJ " //, SR3010 SR3
cQuery6 += CRLF + " where ra_FILIAL = '01' AND sra.D_e_l_e_t_ = ' ' " 
cQuery6 += CRLF + "   AND RJ_FILIAL = '  ' AND SRJ.D_e_l_e_t_ = ' ' "
cQuery6 += CRLF + "   and ctt1.ctt_filial ='01' and ctt1.d_E_L_E_T_ =' ' " 
cQuery6 += CRLF + "   and ctt2.ctt_filial ='01' and ctt2.d_E_L_E_T_ =' ' "
cQuery6 += CRLF + "   and (ctt1.ctt_dtexsf = ' ' or ctt1.ctt_dtexsf <= '"+cAno+cmes+"01') "  
cQuery6 += CRLF + "   AND (RA_DEMISSA = ' ' OR (RA_DEMISSA >= '"+cAno+cmes+"01' AND RA_DEMISSA <= '"+cAno+cmes+"31')) " 
cQuery6 += CRLF + "   and ra_admissa <= '"+cAno+cmes+"31' "
cQuery6 += CRLF + "   AND RA_SALARIO > 0 "
cQuery6 += CRLF + "   AND sra.RA_CODFUNC = SRJ.RJ_FUNCAO "
cQuery6 += CRLF + "   and ra_cc = ctt1.ctt_custo "
cQuery6 += CRLF + "   and substr(ctt1.ctt_custo,1,2) = trim(ctt2.ctt_custo) " 
cQuery6 += CRLF + " group by ctt2.ctt_custo , ctt2.ctt_desc01 ,RA_CC, ctt1.ctt_desc01, ra_nome,SRJ.RJ_DESC , ra_mat ," 
cQuery6 += CRLF + "          case when (ra_demissa = ' ' and  ra_admissa < '"+cAno+cmes+"01') then '1 - Folha' " 
cQuery6 += CRLF + "               when ra_demissa >= '"+cAno+cmes+"01' and ra_demissa <= '"+cAno+cmes+"31' then '3 - Demitidos no Mes' "  
cQuery6 += CRLF + "               when (ra_demissa = ' ' and ra_admissa >= '"+cAno+cmes+"01' and ra_admissa <= '"+cAno+cmes+"31') then '2 - Admitidos no Mes' End " 
cQuery6 += CRLF + " Order by 1,3,5"

	If  Select((cAliastmp6)) <> 0 
			(cAliastmp6)->(DbCloseArea())  
	Endif      

	TcQuery cQuery6 New Alias (cAliasTMP6)  
	
    While !(cAliastmp6)->(EOF())

	    nTotSalT  :=  (cAliastmp6)->demadm + nTotSalT
        nTotQtdaT := (cAliastmp6)->demadmq + nTotQtdaT

		(cAliastmp6)->(DbSkip())

	EndDo 

	(cAliasTMP6)->(dbGoTop())    

    While !(cAliastmp6)->(EOF())

            If cCustoN1N2 == ' '
            
			   cCustoN1N2 :=TRIM((cAliastmp6)->custo1)+TRIM((cAliastmp6)->custo2)
            
			elseIf cCustoN1N2 !=TRIM((cAliastmp6)->custo1)+TRIM((cAliastmp6)->custo2) 

            aAdd(aLogfol6,{ ' '    ,; 
				    		'Sub Totais --->'  ,;
					    	' '   ,;   
							' '   ,;
							' '   ,;  
		           			transform((nSal),"@E 999,999,999.99") ,;
							transform((nQtda),"@E 99,999") ,;
							transform(((nSal/nTotSalT)*100),"@E 999.999%"),;
					        transform(((nQtda/nTotQtdaT)*100),"@E 999.999%")})     //3 

            aAdd(aLogfol6,{ ' '   ,; 
				    		' '   ,;
					    	' '   ,;   
							' '   ,;
							' '   ,;
							' '   ,;
							' '   ,;
							' '   ,;  
		           			' '   })     //3 

				nSal       := 0.00	
				nQtda      := 0.00
                cCustoN1N2 :=TRIM((cAliastmp6)->custo1)+TRIM((cAliastmp6)->custo2)
            
			EndIf 

			aAdd(aLogFol6,{ TRIM((cAliastmp6)->custo1)+' - '+TRIM((cAliastmp6)->desc1) ,; 
							TRIM((cAliastmp6)->custo2)+' - '+TRIM((cAliastmp6)->desc2) ,; 
							TRIM((cAliastmp6)->matric)+' - '+TRIM((cAliastmp6)->nome)  ,;
							TRIM((cAliastmp6)->RJdESC) ,;
							TRIM((cAliastmp6)->demadm1) ,;  
					   transform(((cAliastmp6)->demadm),"@E 999,999,999.99"),;
					   transform(((cAliastmp6)->demadmq),"@E 99,999") ,;
					   transform((((cAliastmp6)->demadm/nTotSalT)*100),"@E 999.999%"),;
					   transform((((cAliastmp6)->demadmq/nTotQtdaT)*100),"@E 999.999%")})     //3 
		
		    nTotQtda := (cAliastmp6)->demadmq + nTotQtda
			nQtda    := (cAliastmp6)->demadmq + nQtda
		                      
			nTotSal  := (cAliastmp6)->demadm + nTotSal 
			nSal     := (cAliastmp6)->demadm + nSal 	

			(cAliastmp6)->(DbSkip())

    EndDo

            aAdd(aLogfol6,{ ' '    ,; 
				    		'Sub Totais --->'  ,;
					    	' '   ,;   
							' '   ,;
							' '   ,;  
		           			transform((nSal),"@E 999,999,999.99") ,;
							transform((nQtda),"@E 99,999") ,;
							transform(((nSal/nTotSalT)*100),"@E 999.999%"),;
					        transform(((nQtda/nTotQtdaT)*100),"@E 999.999%")})     //3 

            aAdd(aLogfol6,{ ' '   ,; 
				    		' '   ,;
					    	' '   ,;   
							' '   ,;
							' '   ,;
							' '   ,;
							' '   ,;
							' '   ,;  
		           			' '   })     //3 

            aAdd(aLogfol6,{ ' '    ,; 
				    		'Totais ------>' ,;
					    	' '   ,;   
							' '   ,;
							' '   ,;  
		           			transform((nTotSal),"@E 999,999,999.99") ,;
							transform((nTotQtda),"@E 99,999") ,;
							'100.00%' ,;
							'100.00%'})     //3  			

            PLSCRIGEN(aLogfol6,{{'Diretoria ',"@!",50}     ,;
								  {'Departamento ',"@!",70} ,;
								  {'Nome Colaborador ',"@!",100} ,;
							   	  {'Cargo' ,"@!",70} ,;
                                  {'Tp Movimento' ,"@!",70} ,;
								  {'Salario ' ,"@!",70}        ,;
								  {'Quantidade  ' ,"@!",50}    ,;
								  {'Prop. Salario ' ,"@!",40}  ,;
								  {'Prop. Qtda    ' ,"@!",40}} ,;
								   'Detalhes da Folha da Competencia '+cano+'/'+cMes+' - Por Colaborado',nil,nil)
return( )

static function resumo8()
local aLogFol8:= {}
local nTotSal    := 0.00	
local nTotQtda   := 0.00
local nSal       := 0.00	
local nQtda      := 0.00

local nTotSalT   := 0.00
local nTotQtdaT  := 0.00

local nTotQtdap  := 0.00
local nTotSalP   := 0.00

local cCustoN1N2 :=' ' 

cQuery8 :=        "select ctt2.ctt_custo custo1 , TRIM(ctt2.ctt_desc01) desc1 , RA_CC custo2 ,  TRIM(ctt1.ctt_desc01) desc2 , " 
cQuery8 += CRLF + "       ra_mat matric, ra_nome nome  ,  SRJ.RJ_DESC RJdESC , "
cQuery8 += CRLF + "       case when (ra_demissa = ' ' and ra_admissa < '"+cAno+cmes+"01') then '1 - Folha' "  
cQuery8 += CRLF + "            when ra_demissa >= '"+cAno+cmes+"01' and ra_demissa <= '"+cAno+cmes+"31' then '3 - Demitidos no Mes' "  
cQuery8 += CRLF + "            when (ra_demissa = ' ' and ra_admissa >= '"+cAno+cmes+"01' and ra_admissa <= '"+cAno+cmes+"31') then '2 - Admitidos no Mes' " 
cQuery8 += CRLF + "        End demadm1 , "  
cQuery8 += CRLF + "        sum( case when (ra_demissa = ' ' and ra_admissa < '"+cAno+cmes+"01') then rc1_valor "   
cQuery8 += CRLF + "                  when ra_demissa >= '"+cAno+cmes+"01' and ra_demissa <= '"+cAno+cmes+"31' then (rc1_valor*-1) "   
cQuery8 += CRLF + "                  when (ra_demissa = ' ' and ra_admissa >= '"+cAno+cmes+"01' and ra_admissa <= '"+cAno+cmes+"31') then ra_salario " 
cQuery8 += CRLF + "             End )demadm , " 
cQuery8 += CRLF + "        sum(case when (ra_demissa = ' ' and ra_admissa < '"+cAno+cmes+"01') then 1 "
cQuery8 += CRLF + "                 when ra_demissa >= '"+cAno+cmes+"01' and ra_demissa <= '"+cAno+cmes+"31' then -1 "   
cQuery8 += CRLF + "                 when (ra_demissa = ' ' and ra_admissa >= '"+cAno+cmes+"01' and ra_admissa <= '"+cAno+cmes+"31') then 1 "  
cQuery8 += CRLF + "             End )demadmq " 
cQuery8 += CRLF + "  from sra010 sra , ctt010 ctt1 , ctt010 ctt2 , SRJ010 SRJ , Rc1010 RC1 " //, SR3010 SR3
cQuery8 += CRLF + " where ra_FILIAL = '01' AND sra.D_e_l_e_t_ = ' ' " 
cQuery8 += CRLF + "   AND RJ_FILIAL = '  ' AND SRJ.D_e_l_e_t_ = ' ' "
cQuery8 += CRLF + "   and ctt1.ctt_filial ='01' and ctt1.d_E_L_E_T_ =' ' " 
cQuery8 += CRLF + "   and ctt2.ctt_filial ='01' and ctt2.d_E_L_E_T_ =' ' "
cQuery8 += CRLF + "   and (ctt1.ctt_dtexsf = ' ' or ctt1.ctt_dtexsf <= '"+cAno+cmes+"01') "  
cQuery8 += CRLF + "   AND (RA_DEMISSA = ' ' OR (RA_DEMISSA >= '"+cAno+cmes+"01' AND RA_DEMISSA <= '"+cAno+cmes+"31')) " 
cQuery8 += CRLF + "   and ra_admissa <= '"+cAno+cmes+"31' "

cQuery8 += CRLF + "      AND rc1_filial = ' ' and rc1.d_E_L_E_T_ = ' ' " 
cQuery8 += CRLF + "      and rc1_venrea like '"+cAno+cmes+"%'" 
cQuery8 += CRLF + "      AND RC1_TIPO = 'RES' "
cQuery8 += CRLF + "      AND RA_MAT   =  RC1_MAT "

cQuery8 += CRLF + "   AND RA_SALARIO > 0 "
cQuery8 += CRLF + "   AND sra.RA_CODFUNC = SRJ.RJ_FUNCAO "
cQuery8 += CRLF + "   and ra_cc = ctt1.ctt_custo "
cQuery8 += CRLF + "   and substr(ctt1.ctt_custo,1,2) = trim(ctt2.ctt_custo) " 
cQuery8 += CRLF + " group by ctt2.ctt_custo , ctt2.ctt_desc01 ,RA_CC, ctt1.ctt_desc01, ra_nome,SRJ.RJ_DESC , ra_mat ," 
cQuery8 += CRLF + "          case when (ra_demissa = ' ' and  ra_admissa < '"+cAno+cmes+"01') then '1 - Folha' " 
cQuery8 += CRLF + "               when ra_demissa >= '"+cAno+cmes+"01' and ra_demissa <= '"+cAno+cmes+"31' then '3 - Demitidos no Mes' "  
cQuery8 += CRLF + "               when (ra_demissa = ' ' and ra_admissa >= '"+cAno+cmes+"01' and ra_admissa <= '"+cAno+cmes+"31') then '2 - Admitidos no Mes' End " 
cQuery8 += CRLF + " Order by 1,3,5"



	If  Select((cAliastmp8)) <> 0 
			(cAliastmp8)->(DbCloseArea())  
	Endif      

	TcQuery cQuery8 New Alias (cAliasTMP8)  
	
    While !(cAliastmp8)->(EOF())

	    nTotSalT  := (cAliastmp8)->demadm + nTotSalT
        nTotQtdaT := (cAliastmp8)->demadmq + nTotQtdaT

		(cAliastmp8)->(DbSkip())

	EndDo 

	(cAliasTMP8)->(dbGoTop())    

    While !(cAliastmp8)->(EOF())

            If cCustoN1N2 == ' '
            
			   cCustoN1N2 :=TRIM((cAliastmp8)->custo1)+TRIM((cAliastmp8)->custo2)
            
			elseIf cCustoN1N2 !=TRIM((cAliastmp8)->custo1)+TRIM((cAliastmp8)->custo2) 

            aAdd(aLogfol8,{ ' '    ,; 
				    		'Sub Totais --->'  ,;
					    	' '   ,;   
							' '   ,;
							' '   ,;  
		           			transform((nSal),"@E 999,999,999.99") ,;
							transform((nQtda),"@E 99,999") ,;
							transform(((nSal/nTotSalT)*100),"@E 999.999%"),;
					        transform(((nQtda/nTotQtdaT)*100),"@E 999.999%")})     //3 

            aAdd(aLogfol8,{ ' '   ,; 
				    		' '   ,;
					    	' '   ,;   
							' '   ,;
							' '   ,;
							' '   ,;
							' '   ,;
							' '   ,;  
		           			' '   })     //3 

				nSal       := 0.00	
				nQtda      := 0.00
                cCustoN1N2 :=TRIM((cAliastmp8)->custo1)+TRIM((cAliastmp8)->custo2)
            
			EndIf 
		
			aAdd(aLogFol8,{ TRIM((cAliastmp8)->custo1)+' - '+TRIM((cAliastmp8)->desc1) ,; 
							TRIM((cAliastmp8)->custo2)+' - '+TRIM((cAliastmp8)->desc2) ,; 
							TRIM((cAliastmp8)->matric)+' - '+TRIM((cAliastmp8)->nome)  ,;
							TRIM((cAliastmp8)->RJdESC) ,;
							TRIM((cAliastmp8)->demadm1) ,;  
					   transform(((cAliastmp8)->demadm),"@E 999,999,999.99"),;
					   transform(((cAliastmp8)->demadmq),"@E 99,999") ,;
					   transform((((cAliastmp8)->demadm/nTotSalT)*100),"@E 999.999%"),;
					   transform((((cAliastmp8)->demadmq/nTotQtdaT)*100),"@E 999.999%")}) 

		    nTotQtda := (cAliastmp8)->demadmq + nTotQtda
			nQtda    := (cAliastmp8)->demadmq + nQtda
		                      
			nTotSal  := (cAliastmp8)->demadm + nTotSal 
			nSal     := (cAliastmp8)->demadm + nSal 	

			(cAliastmp8)->(DbSkip())

    EndDo

            aAdd(aLogfol8,{ ' '    ,; 
				    		'Sub Totais --->'  ,;
					    	' '   ,;   
							' '   ,;
							' '   ,;  
		           			transform((nSal),"@E 999,999,999.99") ,;
							transform((nQtda),"@E 99,999") ,;
							transform(((nSal/nTotSalT)*100),"@E 999.999%"),;
					        transform(((nQtda/nTotQtdaT)*100),"@E 999.999%")})     //3 

            aAdd(aLogfol8,{ ' '   ,; 
				    		' '   ,;
					    	' '   ,;   
							' '   ,;
							' '   ,;
							' '   ,;
							' '   ,;
							' '   ,;  
		           			' '   })     //3 

            aAdd(aLogfol8,{ ' '    ,; 
				    		'Totais ------>' ,;
					    	' '   ,;   
							' '   ,;
							' '   ,;  
		           			transform((nTotSal),"@E 999,999,999.99") ,;
							transform((nTotQtda),"@E 99,999") ,;
							'100.00%' ,;
							'100.00%'})     //3  			

            PLSCRIGEN(aLogfol8,{{'Diretoria ',"@!",50}     ,;
								  {'Departamento ',"@!",70} ,;
								  {'Nome Colaborador ',"@!",100} ,;
							   	  {'Cargo' ,"@!",70} ,;
                                  {'Tp Movimento' ,"@!",70} ,;
								  {'Rescisão  ' ,"@!",70}        ,;
								  {'Quantidade  ' ,"@!",50}    ,;
								  {'Prop. Rescisão  ' ,"@!",40}  ,;
								  {'Prop. Qtda    ' ,"@!",40}} ,;
								   'Detalhes da Rescisão   '+cano+'/'+cMes+' - Por Colaborado',nil,nil)
return( )

static function resumo9()

local aLogFol9:= {}
local nTotSal    := 0.00	
local nTotQtda   := 0.00
local nSal       := 0.00	
local nQtda      := 0.00

local nTotSalT   := 0.00
local nTotQtdaT  := 0.00

local nTotQtdap  := 0.00
local nTotSalP   := 0.00

local cCustoN1N2 :=' ' 

cQuery9 :=        "select ctt2.ctt_custo custo1 , TRIM(ctt2.ctt_desc01) desc1 , RA_CC custo2 ,  TRIM(ctt1.ctt_desc01) desc2 , " 
cQuery9 += CRLF + "       ra_mat matric, ra_nome nome  ,  SRJ.RJ_DESC RJdESC , "
cQuery9 += CRLF + "       case when (ra_demissa = ' ' and ra_admissa < '"+cAno+cmes+"01') then '1 - Folha' "  
cQuery9 += CRLF + "            when ra_demissa >= '"+cAno+cmes+"01' and ra_demissa <= '"+cAno+cmes+"31' then '3 - Demitidos no Mes' "  
cQuery9 += CRLF + "            when (ra_demissa = ' ' and ra_admissa >= '"+cAno+cmes+"01' and ra_admissa <= '"+cAno+cmes+"31') then '2 - Admitidos no Mes' " 
cQuery9 += CRLF + "        End demadm1 , "  
cQuery9 += CRLF + "        sum( case when (ra_demissa = ' ' and ra_admissa < '"+cAno+cmes+"01') then ra_salario "   
cQuery9 += CRLF + "                  when ra_demissa >= '"+cAno+cmes+"01' and ra_demissa <= '"+cAno+cmes+"31' then (ra_salario*-1) "   
cQuery9 += CRLF + "                  when (ra_demissa = ' ' and ra_admissa >= '"+cAno+cmes+"01' and ra_admissa <= '"+cAno+cmes+"31') then ra_salario " 
cQuery9 += CRLF + "             End )demadm , " 
cQuery9 += CRLF + "        sum(case when (ra_demissa = ' ' and ra_admissa < '"+cAno+cmes+"01') then 1 "
cQuery9 += CRLF + "                 when ra_demissa >= '"+cAno+cmes+"01' and ra_demissa <= '"+cAno+cmes+"31' then -1 "   
cQuery9 += CRLF + "                 when (ra_demissa = ' ' and ra_admissa >= '"+cAno+cmes+"01' and ra_admissa <= '"+cAno+cmes+"31') then 1 "  
cQuery9 += CRLF + "             End )demadmq " 
cQuery9 += CRLF + "  from sra010 sra , ctt010 ctt1 , ctt010 ctt2 , SRJ010 SRJ " //, SR3010 SR3
cQuery9 += CRLF + " where ra_FILIAL = '01' AND sra.D_e_l_e_t_ = ' ' " 
cQuery9 += CRLF + "   AND RJ_FILIAL = '  ' AND SRJ.D_e_l_e_t_ = ' ' "
cQuery9 += CRLF + "   and ctt1.ctt_filial ='01' and ctt1.d_E_L_E_T_ =' ' " 
cQuery9 += CRLF + "   and ctt2.ctt_filial ='01' and ctt2.d_E_L_E_T_ =' ' "
cQuery9 += CRLF + "   and (ctt1.ctt_dtexsf = ' ' or ctt1.ctt_dtexsf <= '"+cAno+cmes+"01') "  
cQuery9 += CRLF + "   AND (RA_DEMISSA = ' ' OR (RA_DEMISSA >= '"+cAno+cmes+"01' AND RA_DEMISSA <= '"+cAno+cmes+"31')) " 
cQuery9 += CRLF + "   and ra_admissa <= '"+cAno+cmes+"31' "
cQuery9 += CRLF + "   AND RA_SALARIO > 0 "
cQuery9 += CRLF + "   AND sra.RA_CODFUNC = SRJ.RJ_FUNCAO "

cQuery9 += CRLF + "   and ra_cc = ctt1.ctt_custo "
cQuery9 += CRLF + "   and substr(ctt1.ctt_custo,1,2) = trim(ctt2.ctt_custo) " 

cQuery9 += CRLF + "   having  (case when (ra_demissa = ' ' and ra_admissa < '20220701') then '1 - Folha' "
cQuery9 += CRLF + "   when ra_demissa >= '20220701' and ra_demissa <= '20220731' then '3 - Demitidos no Mes' "
cQuery9 += CRLF + "   when (ra_demissa = ' ' and ra_admissa >= '20220701' and ra_admissa <= '20220731') then '2 - Admitidos no Mes' " 
cQuery9 += CRLF + "   End) =  '2 - Admitidos no Mes' "

cQuery9 += CRLF + " group by ctt2.ctt_custo , ctt2.ctt_desc01 ,RA_CC, ctt1.ctt_desc01, ra_nome,SRJ.RJ_DESC , ra_mat ," 
cQuery9 += CRLF + "          case when (ra_demissa = ' ' and  ra_admissa < '"+cAno+cmes+"01') then '1 - Folha' " 
cQuery9+= CRLF + "               when ra_demissa >= '"+cAno+cmes+"01' and ra_demissa <= '"+cAno+cmes+"31' then '3 - Demitidos no Mes' "  
cQuery9 += CRLF + "               when (ra_demissa = ' ' and ra_admissa >= '"+cAno+cmes+"01' and ra_admissa <= '"+cAno+cmes+"31') then '2 - Admitidos no Mes' End " 
cQuery9 += CRLF + " Order by 1,3,5"


// eecview(cquery9)

	If  Select((cAliastmp9)) <> 0 
			(cAliastmp9)->(DbCloseArea())  
	Endif      

	TcQuery cQuery9 New Alias (cAliasTMP9)  
	
    While !(cAliastmp9)->(EOF())

	    nTotSalT  :=  (cAliastmp9)->demadm + nTotSalT
        nTotQtdaT := (cAliastmp9)->demadmq + nTotQtdaT

		(cAliastmp9)->(DbSkip())

	EndDo 

	(cAliasTMP9)->(dbGoTop())    

    While !(cAliastmp9)->(EOF())

            If cCustoN1N2 == ' '
            
			   cCustoN1N2 :=TRIM((cAliastmp9)->custo1)+TRIM((cAliastmp9)->custo2)
            
			elseIf cCustoN1N2 !=TRIM((cAliastmp9)->custo1)+TRIM((cAliastmp9)->custo2) 

            aAdd(aLogfol9,{ ' '    ,; 
				    		'Sub Totais --->'  ,;
					    	' '   ,;   
							' '   ,;
							' '   ,;  
		           			transform((nSal),"@E 999,999,999.99") ,;
							transform((nQtda),"@E 99,999") ,;
							transform(((nSal/nTotSalT)*100),"@E 999.999%"),;
					        transform(((nQtda/nTotQtdaT)*100),"@E 999.999%")})     //3 

            aAdd(aLogfol9,{ ' '   ,; 
				    		' '   ,;
					    	' '   ,;   
							' '   ,;
							' '   ,;
							' '   ,;
							' '   ,;
							' '   ,;  
		           			' '   })     //3 

				nSal       := 0.00	
				nQtda      := 0.00
                cCustoN1N2 :=TRIM((cAliastmp9)->custo1)+TRIM((cAliastmp9)->custo2)
            
			EndIf 

			aAdd(aLogFol9,{ TRIM((cAliastmp9)->custo1)+' - '+TRIM((cAliastmp9)->desc1) ,; 
							TRIM((cAliastmp9)->custo2)+' - '+TRIM((cAliastmp9)->desc2) ,; 
							TRIM((cAliastmp9)->matric)+' - '+TRIM((cAliastmp9)->nome)  ,;
							TRIM((cAliastmp9)->RJdESC) ,;
							TRIM((cAliastmp9)->demadm1) ,;  
					   transform(((cAliastmp9)->demadm),"@E 999,999,999.99"),;
					   transform(((cAliastmp9)->demadmq),"@E 99,999") ,;
					   transform((((cAliastmp9)->demadm/nTotSalT)*100),"@E 999.999%"),;
					   transform((((cAliastmp9)->demadmq/nTotQtdaT)*100),"@E 999.999%")})     //3 
		
		    nTotQtda := (cAliastmp9)->demadmq + nTotQtda
			nQtda    := (cAliastmp9)->demadmq + nQtda
		                      
			nTotSal  := (cAliastmp9)->demadm + nTotSal 
			nSal     := (cAliastmp9)->demadm + nSal 	

			(cAliastmp9)->(DbSkip())

    EndDo

            aAdd(aLogfol9,{ ' '    ,; 
				    		'Sub Totais --->'  ,;
					    	' '   ,;   
							' '   ,;
							' '   ,;  
		           			transform((nSal),"@E 999,999,999.99") ,;
							transform((nQtda),"@E 99,999") ,;
							transform(((nSal/nTotSalT)*100),"@E 999.999%"),;
					        transform(((nQtda/nTotQtdaT)*100),"@E 999.999%")})     //3 

            aAdd(aLogfol9,{ ' '   ,; 
				    		' '   ,;
					    	' '   ,;   
							' '   ,;
							' '   ,;
							' '   ,;
							' '   ,;
							' '   ,;  
		           			' '   })     //3 

            aAdd(aLogfol9,{ ' '    ,; 
				    		'Totais ------>' ,;
					    	' '   ,;   
							' '   ,;
							' '   ,;  
		           			transform((nTotSal),"@E 999,999,999.99") ,;
							transform((nTotQtda),"@E 99,999") ,;
							'100.00%' ,;
							'100.00%'})     //3  			

            PLSCRIGEN(aLogfol9,{{'Diretoria ',"@!",50}     ,;
								  {'Departamento ',"@!",70} ,;
								  {'Nome Colaborador ',"@!",100} ,;
							   	  {'Cargo' ,"@!",70} ,;
                                  {'Tp Movimento' ,"@!",70} ,;
								  {'Salario ' ,"@!",70}        ,;
								  {'Quantidade  ' ,"@!",50}    ,;
								  {'Prop. Salario ' ,"@!",40}  ,;
								  {'Prop. Qtda    ' ,"@!",40}} ,;
								  'Detalhes da Admissão'+cano+'/'+cMes+' - Por Colaborado',nil,nil)
return( )
