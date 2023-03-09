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



User Function CABA188a( cCmptcia, cOrigem1, cTpDesc1 , dDtvenc1 , cTpSe21 , c_user)

                                                 
Private  nI := 0     
private cCmptc := cCmptcia  

private cOrigem := cOrigem1 
private cTpDesc := cTpDesc1 
private dDtvenc := dDtvenc1 
private cTpSe2  := cTpSe21 

Private _cUsuario := SubStr(cUSUARIO,7,15)
Private _cIdUsuar := RetCodUsr()

Private _cIdUsuar := c_user


private cDthr       := (dtos(DATE()) + "-" + Time())       

Private cQryPEG       := ""

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
			    "Competencia" ,;
			         "Origem" ,;
					   "Tipo" ,;
					 "Titulo" ,;
				 "Fornecedor" ,;
				    "Emissao" ,;
		         "Vencimento" ,;
				      "Baixa" ,;
				     "Valor " ,;
					  "Saldo" ,;
	   "Aprocador / Vistador" ,;
					   "Acao" ,;
			 "Codição Titulo" ,;
			 "Cont" }




// Private aCabPEG	:= {" ",Compte" , "Origem", "Tipo", "Titulo", "Fornecedor","Emissao","Vencimento","Baixa", "Valor " , "Saldo" ,Usuario","Acao", "Tipo","Cont"}
Private aTamPEG	    := {5  ,  20     , 15      , 50    ,  55    ,  50         ,      25 , 25         ,25     , 35       , 35      , 80  , 30      ,   30  , 05 }       



Private aObjects 	:= {}

Private aSizeAut 	:= MsAdvSize() 

//Private cPerg	    := "CABA183A"     
 
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


Private cDscori   := ' ' 

Private cMesBase     := ' '  
Private cAnoBase     := ' ' 
Private cNumTitI     := ' '  
Private cNumTitF     := ' '     
Private cOpeInc      := ' ' 
Private cOpeFim      := ' '     
   
Private aTit         := {}                     

private cAliasPEG	:= GetNextAlias()


Private oVerde   	:= LoadBitMap(GetResources(),"ENABLE")
Private oAzul   	:= LoadBitMap(GetResources(),"BR_AZUL")    
Private oAmarelo	:= LoadBitMap(GetResources(),"BR_AMARELO")


PRIVATE cCadastro	:= "Aprovação de Folha e Beneficios - Demonstrativo  "


PRIVATE aCdCores	:= { 	{ 'BR_VERDE'    ,'Aprovado     ' },; 
							{ 'BR_AZUl'     ,'Pago         ' },;							
							{ 'BR_AMARELO'  ,'Não Aprovado ' }}

PRIVATE aRotina	:=	{	{ "Legenda"		, 'U_LEG188A'	    , 0, K_Incluir		} }	


/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±± Declaração de cVariable dos componentes                                 ±±
Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/
/////////////////////////////////////////////fim variaves da tela

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

//odlg188a  		:= MsDialog():New( aSizeAut[7],00,aSizeAut[3]-100,aSizeAut[5]-10,"Repase Comissao Vendedor Interno Integral -> Caberj ",,,.F.,,,,,,.T.,,,.T. ) 

odlg188a  		:= MsDialog():New( aSizeAut[7],00,aSizeAut[3] ,aSizeAut[5]-10,"Demostrativo de titulos Liberados da Folha e/ou  Beneficios",,,.F.,,,,,,.T.,,,.T. ) 
oSayPEG    	:= TSay():New( aPosObj[1][1],aPosObj[1][2],{||'"Demostrativo de titulos Liberados da Folha e/ou  Beneficios "'},odlg188a,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,236,016)


bDbClickPEG	:= {|| aBrwPEG[oBrwPEG:nAt,1] := !aBrwPEG[oBrwPEG:nAt,1], oBrwPEG:Refresh()}   

//bDbClickPEG	:= {|| aBrwPEG[oBrwPEG:nAt,1] := iif ((aBrwPEG[oBrwPEG:nAt,17] == ' ' .or. mv_par01 == '1') , aBrwPEG[oBrwPEG:nAt,1] ,!aBrwPEG[oBrwPEG:nAt,1]), oBrwPEG:Refresh()}   

//bChangePEG	:= {||AtuBrwGuia(aBrwPEG[oBrwPEG:nAt,2],aBrwPEG[oBrwPEG:nAt,3])}

oBrwPEG 	:= TcBrowse():New(aPosObj[1][1],aPosObj[1][2],aPosObj[1][4],aPosObj[1][3]+40,,aCabPEG,aTamPEG,odlg188a,,,,,bDbClickPEG,,,,,,,.F.,,.T.,,.F.,,, )

//oBrwPEG 	:= TcBrowse():New(aPosObj[1][1]+10,aPosObj[1][2],aPosObj[1][4],aPosObj[1][3]+190,,aCabPEG,aTamPEG,odlg188a,,,,,bDbClickPEG,,,,,,,.F.,,.T.,,.F.,,, )

oBrwPEG:SetArray(aBrwPEG)

//IIf(alltrim(aBrwPEG[oBrwPEG:nAt, 15]) != '0',oVerde,(IIf(aBrwPEG[oBrwPEG:nAt,8]== 0,oVermelho,oAmarelo) ))  ,;
	                 
oBrwPEG:bLine := {||{IIf(aBrwPEG[oBrwPEG:nAt,8]== 0,oAzul,(IIf(alltrim(aBrwPEG[oBrwPEG:nAt, 19]) != '0',oVerde,oAmarelo)))  ,;
                         aBrwPEG[oBrwPEG:nAt,  1] ,;
						 aBrwPEG[oBrwPEG:nAt,  2] ,;
                         aBrwPEG[oBrwPEG:nAt,  3] ,;
						 aBrwPEG[oBrwPEG:nAt, 12] +aBrwPEG[oBrwPEG:nAt, 13] + aBrwPEG[oBrwPEG:nAt, 14] + aBrwPEG[oBrwPEG:nAt, 15] ,;
						 aBrwPEG[oBrwPEG:nAt, 16] ,;
						 aBrwPEG[oBrwPEG:nAt,  4] ,;
                         aBrwPEG[oBrwPEG:nAt,  5] ,;
                         aBrwPEG[oBrwPEG:nAt,  6] ,;
	  	       Transform(aBrwPEG[oBrwPEG:nAt,  7] ,'@E  99,999,999.99'),;
			   Transform(aBrwPEG[oBrwPEG:nAt,  8] ,'@E  99,999,999.99'),;	 
		 	     alltrim(aBrwPEG[oBrwPEG:nAt,  9]) + ' - ' +alltrim(aBrwPEG[oBrwPEG:nAt,  10]),; 
				         aBrwPEG[oBrwPEG:nAt, 17] ,;
						 aBrwPEG[oBrwPEG:nAt, 18] ,;
						 aBrwPEG[oBrwPEG:nAt, 19]}}          

oBrwPEG:nScrollType  := 1 // Scroll VCR

lConfirmou 	:= .T.

aBut    :={{"PENDENTE", {||odlg188a:End()    }  , "Sair "                 , "Sair "              }}  
/*aBut    :={{"PENDENTE", {||marca(1)          }	, "Marcar Todos "         , "Marcar Todos"       }}
aAdd(aBut, {"PENDENTE", {||desmarca(1)       }	, "Desmarcar Todos "	  , "Desmarcar Todos"	 })   
aAdd(aBut, {"PENDENTE", {||fMostTela()       }  , "Tela de Liberações "   , "Tela de Liberações "})  
aAdd(aBut, {"PENDENTE", {||U_LEG188A()       }  , "Legenda "              , "Legenda "           })  
aAdd(aBut, {"PENDENTE", {||odlg188a:End()    }  , "Sair "                 , "Sair "              })  
*/
lConfirmou := .F.

//bOk 	:= {||fSequen() , oBrwPEG:Refresh() , oBrwPEG:Refresh() ,odlg188a:End()   }    
 
bOk 	:= {||lConfirmou := .F.,odlg188a:End()}
 
bCancel := {||lConfirmou := .F.,odlg188a:End()}

odlg188a:Activate(,,,.T.,,,EnchoiceBar(odlg188a,bOk,bCancel,,aBut))

a:='v'

Return(nPagto)    

************************************************************************************

Static Function aDadosPEG

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
cQryPEG += CRLF + "       'RES' , 'RESCISÃO' , "
cQryPEG += CRLF + "       'IRF' , 'IMPOSTO DE RENDA' , " 
cQryPEG += CRLF + "       'FER' , 'FERIAS' , "
cQryPEG += CRLF + "       'TX '  , 'PIS' , "
cQryPEG += CRLF + "       'INS' , 'INSS', "
cQryPEG += CRLF + "       'NF '  , TRIM(E2_NOMFOR) , 'NAO IDENTIFICADO') TIPO , "
cQryPEG += CRLF + "       trim(Substr(E2_VENCREA,7,2)||'/'||Substr(E2_VENCREA,5,2)||'/'||Substr(E2_VENCREA,1,4)) VencRea , " 
cQryPEG += CRLF + "       trim(Substr(E2_EMISSAO,7,2)||'/'||Substr(E2_VENCREA,5,2)||'/'||Substr(E2_VENCREA,1,4)) Emissao , "
cQryPEG += CRLF + "       trim(Substr(E2_BAIXA  ,7,2)||'/'||Substr(E2_BAIXA  ,5,2)||'/'||Substr(E2_BAIXA  ,1,4)) Baixa   , "
cQryPEG += CRLF + "       Alc.AK_USER Usuar, Alc.AK_NOME NomUsr, Alc.AL_COD CodAlc , Alc.AL_DESC DescAlc , "
cQryPEG += CRLF + "       decode(Alc.AL_LIBAPR, 'V', 'Vista', 'Aprova') Lib , Alc.AL_USERSUP AprSup , AL_LIBAPR LIBAPR , "
cQryPEG += CRLF + "       Alc.AK_LIMMIN LIMMIN, Alc.AK_LIMMAX LIMMAX , "
cQryPEG += CRLF + "       (se2.E2_VALOR) valor , (se2.e2_saldo) saldo , nvl(pdt.pdt_num,'0') TEMPDT , " 
cQryPEG += CRLF + "       DECODE(nvl(pdt.pdt_num, '0'),'0','Não Aprovado ou Não Vistado', DECODE(pdt.pdt_TpApro, 'V','Vistado','Aprovado')) Aprov , " 
cQryPEG += CRLF + "       decode(se2.e2_saldo, 0 , 'Baixado', decode(se2.e2_saldo,se2.E2_valor, 'Não Baixado','Baixa Parcial')) Tpsaldo , "
cQryPEG += CRLF + "       se2.e2_prefixo prefixo , se2.e2_num num , se2.e2_parcela parcela , se2.e2_tipo e2tipo , se2.e2_fornece fornece , se2.e2_nomfor nomfor ,"

cQryPEG += CRLF + "       decode(nvl(PDT.pdt_aprov,'0'),Alc.AK_USER,'1','0')TEMPDT1, " 
cQryPEG += CRLF + "       decode(nvl(pdt.pdt_num, '0'),'0','0','1') TEMPDT2 " 

cQryPEG += CRLF + "  from se2010 SE2 , pdt010 pdt , "
cQryPEG += CRLF + "       (SELECT AK_USER , AK_NOME, AL_COD , AL_DESC , AL_LIBAPR , AL_USERSUP , AK_LIMMIN ,AK_LIMMAX "
cQryPEG += CRLF + "         FROM SAL010 SAL , "
cQryPEG += CRLF + "              SAK010 SAK   "
cQryPEG += CRLF + "        WHERE AL_FILIAL  = '01'  AND SAL.D_E_L_E_T_ = ' ' "
cQryPEG += CRLF + "          AND AK_FILIAL  = '01'  AND SAK.D_E_L_E_T_ = ' ' "
cQryPEG += CRLF + "          AND AL_COD = '909099' "
cQryPEG += CRLF + "          AND AK_COD = AL_APROV "

cQryPEG += CRLF + "          AND AK_USER = '"+_cIdUsuar+"'"

cQryPEG += CRLF + "          ) Alc  "
cQryPEG += CRLF + " where e2_filial ='01' and se2.d_E_L_E_T_ = ' ' "
cQryPEG += CRLF + "   and pdt_filial(+) ='01' and pdt.d_E_L_E_T_(+) = ' ' " 
cQryPEG += CRLF + "   AND E2_VENCREA  like '"+cCmptc+"%' " 
cQryPEG += CRLF + "   AND PDT_PREFIX(+) = se2.e2_prefixo "
cQryPEG += CRLF + "   AND PDT_NUM(+)    = se2.e2_num     "
cQryPEG += CRLF + "   AND PDT_PARCEL(+) = se2.e2_parcela "
cQryPEG += CRLF + "   AND PDT_TIPO(+)   = se2.e2_tipo    "
cQryPEG += CRLF + "   AND PDT_FORNEC(+) = se2.e2_fornece "
cQryPEG += CRLF + "   AND PDT_modulo(+) = 'FOL' "
cQryPEG += CRLF + " "
/*
cQryPEG += CRLF + "   and ((Alc.AL_USERSUP <> ' ' " 
cQryPEG += CRLF + "   AND (SELECT NVL(COUNT(*), 0 ) FROM PDT010 PDT1 "
cQryPEG += CRLF + "         WHERE PDT1.pdt_filial ='01' and pdt1.d_E_L_E_T_ = ' ' "
cQryPEG += CRLF + "           AND pdt1.PDT_PREFIX = se2.e2_prefixo "
cQryPEG += CRLF + "           AND pdt1.PDT_NUM    = se2.e2_num "
cQryPEG += CRLF + "           AND PDT1.PDT_PARCEL = se2.e2_parcela "
cQryPEG += CRLF + "           AND PDT1.PDT_TIPO   = se2.e2_tipo  "
cQryPEG += CRLF + "           AND PDT1.PDT_FORNEC = se2.e2_fornece " 
cQryPEG += CRLF + "           and PDT1.pdt_aprov  = Alc.AL_USERSUP "
cQryPEG += CRLF + "           AND PDT1.PDT_modulo = 'FOL' ) > 0) "
cQryPEG += CRLF + "    OR ALC.AL_USERSUP = ' ') "
*/
cQryPEG += CRLF + " "
cQryPEG += CRLF + "   AND ((E2_NOMFOR LIKE '%RIO CARD%' OR E2_NOMFOR LIKE '%SODEX%')OR e2_origem like 'GPE%') "
cQryPEG += CRLF + "   AND (E2_ORIGEM LIKE 'MA%' OR e2_origem like 'GPE%') "


cQryPEG += CRLF + "   AND DECODE(SUBSTR(E2_ORIGEM,1,4) ,'GPEM' , 'FOLHA','COMPAS') = '"+cOrigem+"'"
cQryPEG += CRLF + "   and DECODE(E2_TIPO,'FGT' , 'FUNDO DE GARANTIA' , " 
cQryPEG += CRLF + "       'FOL' , 'FOLHA DE PAGAMENTO' , "
cQryPEG += CRLF + "       'PEN' , 'PENSÃO ALIMENTICIA' , " 
cQryPEG += CRLF + "       'RES' , 'RESCISÃO' , "
cQryPEG += CRLF + "       'IRF' , 'IMPOSTO DE RENDA' ,  " 
cQryPEG += CRLF + "       'FER' , 'FERIAS' , "
cQryPEG += CRLF + "       'TX '  , 'PIS' , "
cQryPEG += CRLF + "       'INS' , 'INSS', "
cQryPEG += CRLF + "       'NF '  , TRIM(E2_NOMFOR) , 'NAO IDENTIFICADO') = '"+cTpDesc+"'"
cQryPEG += CRLF + "   AND E2_VENCREA            = '"+dDtvenc+"'"
//cQryPEG += CRLF + "   AND E2_SALDO              > 0 "
cQryPEG += CRLF + "   AND E2_TIPO               = '"+cTpSe2+"'"

cQryPEG += CRLF + "  ORDER by se2.e2_prefixo , se2.e2_num , se2.e2_parcela , se2.e2_tipo , se2.e2_fornece , se2.e2_nomfor , Alc.AK_USER "

If Select((cAliasPEG)) <> 0 
   (cAliasPEG)->(DbCloseArea())  
Endif      

TcQuery cQryPEG New Alias (cAliasPEG)  

(cAliasPEG)->(dbGoTop())    

While !(cAliasPEG)->(EOF())


//aAdd(aRetPEG,{iif(iif(trim((cAliasPEG)->TEMPDT) == '0',.T.,.F.) 

 aAdd(aRetPEG,{	substr(cCmptc,5,2)+'/'+substr(cCmptc,1,4),; //1
				(cAliasPEG)->Origem                      ,; //2 
				trim((cAliasPEG)->Tipo)       			 ,; //3
				alltrim((cAliasPEG)->emissao) 			 ,; //4
				alltrim((cAliasPEG)->VencRea) 			 ,; //4
				alltrim((cAliasPEG)->BAIXA)   			 ,; //6
				(cAliasPEG)->Valor            			 ,; //7
				(cAliasPEG)->Saldo            		 	 ,; //8
				(cAliasPEG)->Usuar            			 ,; //9
				(cAliasPEG)->NomUsr           			 ,; //10
    			(cAliasPEG)->TEMPDT           			 ,; //11
				(cAliasPEG)->PREFIXO          			 ,; //12
				(cAliasPEG)->NUM              			 ,; //13
				(cAliasPEG)->parcela          			 ,; //14
				(cAliasPEG)->E2TIPO           			 ,; //15
				(cAliasPEG)->NOMFOR           			 ,; //16
				(cAliasPEG)->APROV            			 ,; //17
				(cAliasPEG)->Tpsaldo            		 ,; //18
				(cAliasPEG)->TEMPDT1		  			 }) //19

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
				 '0',;   //11
				   '',;  //12
				   '',;  //13
				   '',;  //14
				   '',;  //15
				   '',;  //16
				   '',;  //17
				   '',;  //18
				   ''})  //19
				    
EndIf

Return aRetPEG

/********************************************/
/********************************************/                                    

    
User Function LEG188A()

Local aLegenda

	aLegenda 	:= { 	{ aCdCores[1,1],aCdCores[1,2] },;
						{ aCdCores[2,1],aCdCores[2,2] },;
	              		{ aCdCores[3,1],aCdCores[3,2] } }

	                     	
BrwLegenda(cCadastro,"Status" ,aLegenda)

Return


