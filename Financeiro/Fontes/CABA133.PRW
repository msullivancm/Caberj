#Define CRLF Chr(13)+Chr(10)
#INCLUDE "PROTHEUS.ch"
#INCLUDE "TOPCONN.ch"
#INCLUDE "PLSMGER.CH"                                           
#Include 'Tbiconn.ch' 
#INCLUDE "PLSR591.ch"  
#Include "rwmake.ch"   
#Include "RPTDEF.CH"
/*--------------------------------------------------------------------------\
| Programa  | CABA133  | Autor | Altamiro	Affonso    | Data | 01/12/2017  |
|---------------------------------------------------------------------------|
| Descricao | Browser de seleção de guias para fechamento do convenio       |
|           |                                                               |
|---------------------------------------------------------------------------|
| Uso       | Browser de seleção de guias para fechamento do convenio       |
\--------------------------------------------------------------------------*/

User Function CABA133( ANOMES , OPEORI , cFFec )

local cRda        := ' '
local cNivel      := ' '
local nI := 0                  

////
PRIVATE nQtdLin     := 60
PRIVATE nLimite     := 220
PRIVATE cTamanho    := "G"
PRIVATE cTitulo     := "Relatório de Despesas de Convênios Reciprocidade"
PRIVATE cDesc1      := STR0002 //"Este Relatorio tem como objetivo emitir resumo demonstrando a composicao de"
PRIVATE cDesc2      := STR0003  //"um lote de cobranca."
PRIVATE cDesc3      := ""
PRIVATE cAlias      := "BDC"
PRIVATE cPerg       := "PLR591"
PRIVATE cPerg1      := "CABA133"
PRIVATE cRel        := "CABA133"
PRIVATE nli         := 80
PRIVATE m_pag       := 1
PRIVATE lCompres    := .F.
PRIVATE lDicion     := .F.
PRIVATE lFiltro     := .F.
PRIVATE lCrystal    := .F.
PRIVATE aOrderns    := {}
PRIVATE aReturn     := { "", 1,"", 1, 1, 1, "",1 }
PRIVATE lAbortPrint := .F.     
PRIVATE cMontaTxt1  := ' '                          

PRIVATE cPosic1     := ' '
PRIVATE cPosic2     := ' '
PRIVATE cPosic3     := ' '
PRIVATE cPosic4		:= ' '
PRIVATE cPosic5 	:= ' '
PRIVATE cPosic6 	:= ' '
PRIVATE cPosic7 	:= ' '
PRIVATE cPosic8 	:= ' '
PRIVATE cPosic9 	:= ' ' 
PRIVATE cPosic10	:= ' '

PRIVATE cCabec1     := "Associado                                               Mat. Convenio      Data Proc.   Prestador                    Nr.Impresso           Procedimento                              Valor     Taxa Conv.         INSS   "

//PRIVATE cCabec1     := "Lote      Geraçào  Referência                                         Total de servicos                        Taxas           Total"
//PRIVATE cCabec2   := STR0008  //"OPERADORA ORIGEM                          PRFX TITULO  PARC. TIPO QTD EVE. "
PRIVATE cCabec2		:= ""

private _VLRTAD     := 0.00
private _VLRBPF     := 0.00
private _VLRINS     := 0.00

private _VLRTADT    := 0.00
private _VLRBPFT    := 0.00
private _VLRINST    := 0.00

private _VLRTADTOT  := 0.00
private _VLRBPFTOT  := 0.00
private _VLRINSTOT  := 0.00

////

Private cOpeOri     := OPEORI     
Private cAnoMes     := AnoMes                   
private cFazFec     := cFFec
PRIVATE aDados      := {}
PRIVATE arettitcov  := {}   
PRIVATE arettit     := {}  

private aDados2     := {}    

PRIVATE lImprimiu   := .F.


private aBrwPEG     := {}
Private aCabPEG		:= {" ","Status ","Usuario ","Dt Proc ","Rdaf","Procedimento ","Bas Cust","Tax Cust", "Tot Cust" , "Bas Adian","Tax Adian", "Tot Adian" ,"Dif Bas","Dif Tx","Dif Total"}
Private aTamPEG		:= {10 ,45       ,80       ,30         ,80    ,80             ,35        ,35          ,35        ,35          ,35         ,35           ,35       ,35      ,35         }  


Private oOk      	:= LoadBitMap(GetResources(),"LBOK")
Private oNo      	:= LoadBitMap(GetResources(),"LBNO")

private lsai      := .F.

Private aObjects  := {}
Private aSizeAut  := MsAdvSize()
Private cPerg	  := "CABA133"
Private adados    := {}

private cAliasPEG := GetNextAlias()     
private cAliasCf  := GetNextAlias()   
private cAliasDem := GetNextAlias()   
private cAliasCT  := GetNextAlias()    
private cAliasEX  := GetNextAlias()   

private cDtEntr   := ' '
Private cdata     := ' '
Private nEmpresa  := ' '
private cLibBlq   := 'S'

AjustaSX1(cPerg)

Pergunte(cPerg,.T.)

Processa({||aDados:= aDadosPEG()},'Processando...','Processando...',.T.)

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

oDlg1  		:= MsDialog():New( aSizeAut[7],00,aSizeAut[3]-100,aSizeAut[5]-10,"Liberação de Titulos Para Filial de Produção",,,.F.,,,,,,.T.,,,.T. )

oSayPEG    	:= TSay():New( aPosObj[1][1],aPosObj[1][2],{||'Liberação de Titulos Para Filial de Produção'},oDlg1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,236,016)

bDbClickPEG	:= {|| adados[oBrwPEG1:nAt,1] := !adados[oBrwPEG1:nAt,1] , oBrwPEG1:Refresh()}  

oBrwPEG1 	:= TcBrowse():New(aPosObj[1][1]+10,aPosObj[1][2],(aPosObj[1][4]-10),(aPosObj[1][3]-45),,aCabPEG,aTamPEG,oDlg1,,,,,bDbClickPEG,,,,,,,.F.,,.T.,,.F.,,, )
                       
oBrwPEG1:SetArray(aDados)                  
                  
oBrwPEG1:bLine := {||{If( adados[oBrwPEG1:nAt,01],oOk,oNo) ,;
                          adados[oBrwPEG1:nAt,30]		   ,;
                   substr(adados[oBrwPEG1:nAt,08],1,20)    ,;
				   substr(adados[oBrwPEG1:nAt,07],7,02)+'/'+substr(adados[oBrwPEG1:nAt,7],5,2)+'/'+substr(adados[oBrwPEG1:nAt,7],1,4) ,;
                   substr(adados[oBrwPEG1:nAt,10],1,20) ,;
				   substr(adados[oBrwPEG1:nAt,11],1,20) ,;
                Transform(adados[oBrwPEG1:nAt,13],"@E 9,999,999.99") ,;
                Transform(adados[oBrwPEG1:nAt,14],"@E 9,999,999.99") ,;
                Transform(adados[oBrwPEG1:nAt,12],"@E 9,999,999.99") ,; 
                Transform(adados[oBrwPEG1:nAt,28],"@E 9,999,999.99") ,;
                Transform(adados[oBrwPEG1:nAt,29],"@E 9,999,999.99") ,;
                Transform(adados[oBrwPEG1:nAt,27],"@E 9,999,999.99") ,;
                Transform(adados[oBrwPEG1:nAt,31],"@E 9,999,999.99") ,;
                Transform(adados[oBrwPEG1:nAt,32],"@E 9,999,999.99") ,;
                Transform(adados[oBrwPEG1:nAt,33],"@E 9,999,999.99")  }}
							            
oBrwPEG1:nScrollType  := 1 // Scroll VCR

lConfirmou 	:= .T.

aBut    :={{"PENDENTE", {||marca(),oBrwPEG1:Refresh()            }	, "Marcar Todos "       , "Marcar Todos"     } }
aAdd(aBut, {"PENDENTE", {||desmarca() ,oBrwPEG1:Refresh()        }	, "DesMarcar Todos "	, "DesMarcar Todos"	 } )
aAdd(aBut, {"PENDENTE", {||lsai:= .T. , oDlg1:End()              }	, "Sair "   	        , "Sair"             } )

If lsai

   oDlg1:End()

endIf

lConfirmou := .F.

bOk 	:= {||fFazRel() , oBrwPEG1:Refresh()  ,oDlg1:End()   }

bCancel := {||lConfirmou := .F.,oDlg1:End()}

  
oDlg1:Activate(,,,.T.,,,EnchoiceBar(oDlg1,bOk,bCancel,,aBut))

//	MsgInfo("Processo finalizado")

Return(arettit)

/************************************************************************************/

Static Function aDadosPEG

Local aDados1	:= {}
Local cquery	:= ""
local i

ProcRegua(0)

nCont := 0

for i:=1 to 5
	IncProc('Buscando Dados no Servidor ...')
next 


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta query...                                                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cSQL := "SELECT * FROM  "+RetSqlName('BTF')+ " BTF ," +RetSqlName('BTO')+ " BTO " 
cSQL += " WHERE BTF_FILIAL = '"+xFilial("BTF")+"' AND "
cSQL += "       BTF_CODOPE = '0001' AND "
cSQL += "BTF_NUMERO = '"+mv_par01+"' AND "
cSQL += "BTO_OPEORI = '"+cOpeOri+"' AND "
cSQL += "BTF.D_E_L_E_T_ = ' ' AND "
cSQL += "BTO.D_E_L_E_T_ = ' ' AND "
cSql += "BTF_CODOPE = BTO_CODOPE   AND "
cSql += "BTF_NUMERO = BTO_NUMERO "
     
If Select(("TRB1")) <> 0
					
   ("TRB1")->(DbCloseArea())
					
Endif

TcQuery cSQL New Alias ("TRB1")            


/*
PLSQuery(cSQL,"TRB1")

If TRB1->(Eof())
   TRB1->(DbCloseArea())
   Help("",1,"RECNO")
   Return
Endif           
*/

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta query do titulo ...                                                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cSQL := " SELECT PCS_OPEORI ,PCS_ANOPAG||PCS_MESPAG ,PCS_PREFIX prefixo , PCS_NUMTIT num , PCS_TIPO tipo ,  " + CRLF
cSQL += "        COUNT(*) QTDA ,  SUM( PCS_VLRBPF) VLRBPF , SUM( PCS_VLRTAD ) VLRTAD , SUM( PCS_VLRINS ) VLRINS " + CRLF
cSQL += "   FROM "+RetSqlName('PCS')+ " PCS " + CRLF
cSQL += "  WHERE PCS_FILIAL ='"+xFilial("PCS")+"' " + CRLF
cSQL += "    AND D_E_L_E_T_ = ' '  " + CRLF
cSQL += "    AND PCS_OPEORI = '"+cOpeOri+"'  " + CRLF
cSQL += "    AND PCS_ANOPAG||PCS_MESPAG = '"+cAnoMes+"'  " + CRLF
cSQL += "    GROUP BY PCS_OPEORI ,PCS_ANOPAG||PCS_MESPAG ,PCS_PREFIX , PCS_NUMTIT , PCS_TIPO  " + CRLF
cSQL += "    ORDER BY 1,2,4
			
If Select((cAliasCT)) <> 0
				
   (cAliasCT)->(DbCloseArea())
				
Endif
			
TcQuery cSQL New Alias (cAliasCT)            
                                            

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Busca a movimentacao da operadora por usuarios... somente analitico³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
          
cSql := " "

If ( mv_par02 != 3)					

cSql += " SELECT BD6_CODOPE, BD6_CODEMP, BD6_MATRIC, BD6_TIPREG, BD6_DIGITO, BD6_DATPRO, " + CRLF
cSql += " BD6_NOMUSR, BD6_CODRDA, BD6_NOMRDA, BD6_DESPRO, BD6_VLRTPF , BD6_VLRBPF , BD6_VLRTAD, BD6_NUMIMP,  "+ CRLF
cSql += " BD6_CODOPE, BD6_CODLDP, BD6_CODPEG, BD6_NUMERO, BD6_ORIMOV, BD6_SEQUEN, BD6_CODPRO,  "+ CRLF
cSql += " BA1_YMTREP, "+ CRLF
cSql += " BAU_CODIGO, BAU_TIPPE, BAU_NOME , "+ CRLF		
cSql += "  0.00 VLRTPFPCS , 0.00 VLRBPFPCS ,  0.00  VLRTADPCS , " + CRLF
cSql += " decode(trim(BD6_FASE),'4','4-Fat','1','1-Dig','2','2-Conf','3','3-Prt',  'N-Prt') fase ,"+ CRLF
cSql += " CASE WHEN trim(bd6.D_e_l_e_t_)      = '*'                  THEN 'Delet. PLS '"+ CRLF
cSql += "      WHEN nvl(bd6_CODPEG,' ')       = ' '                  THEN 'Não Exist PLS ' "+ CRLF
cSql += "      WHEN trim(BD6_FASE) <> '4'                            THEN 'G. Não Paga  ' "+ CRLF
cSql += "      WHEN NVL(BD6_NUMFAT,'            ') = '            '  THEN 'G. Não Cobrd' "+ CRLF
cSql += "      Else 'Ok' END  statuspeg  , "+ CRLF				
cSql += "      0.00 DifB , 0.00 DifT , 0.00 DifTOT , "+ CRLF
cSql += "      0 PCSRECNO  , BD6.R_e_c_n_o_ BD6RECNO , "+ CRLF            

cSql += "      DECODE(NVL(trim(XML.IDLOTE),' ' ),' ',' ' , XML.IDLOTE) IDLOT " + CRLF

cSql += " FROM "+RetSqlName('BDH')+" BDH,"+RetSqlName('BD6')+" BD6, "+RetSqlName('BA1')+" BA1, "+RetSqlName('BAU')+" BAU , "+ CRLF

cSql += "      (select DISTINCT trim(RCP.RECBD6) RECBD6 , trim(RCP.IDLOTE) IDLOTE " + CRLF
cSql += "         from siga.RECIPR_PROCEDIMENTO RCP , siga.RECIPR_LOTE RCG , siga.RECIPR_LOTE RCL " + CRLF
cSql += "        where RCP.IDLOTE = RCG.IDLOTE " + CRLF 
cSql += "          AND RCP.IDLOTE = RCL.IDLOTE " + CRLF
cSql += "          AND RCL.XML_GERADO ='S' " + CRLF
cSql += "          AND TRIM(RCP.EMPRESA) ='CABERJ'" + CRLF
cSql += "          AND LTRIM(RCP.OPERADORA) = 'CABESP') XML  " + CRLF

cSql += " WHERE BDH_OPEFAT = '"+cOpeOri+"' "+ CRLF
cSql += " AND BDH_NUMFAT = '0001"+mv_par01+"' "+ CRLF
cSql += " AND BDH_OPEORI = '"+cOpeOri+"' "+ CRLF
cSql += " AND BDH_CODINT = '0001' "+ CRLF
cSql += " AND BA1_FILIAL = '"+xFilial("BA1")+"' "+ CRLF
cSql += " AND BA1_CODINT = BDH_CODINT " + CRLF
cSql += " AND BA1_CODEMP = BDH_CODEMP "+ CRLF
cSql += " AND BA1_MATRIC = BDH_MATRIC "+ CRLF
cSql += " AND BA1_TIPREG = BDH_TIPREG "+ CRLF
cSql += " AND BD6_FILIAL = '"+xFilial("BD6")+"' "+ CRLF
cSql += " AND BD6_OPEUSR = BDH_CODINT "+ CRLF
cSql += " AND BD6_CODEMP = BDH_CODEMP "+ CRLF
cSql += " AND BD6_MATRIC = BDH_MATRIC "+ CRLF
cSql += " AND BD6_TIPREG = BDH_TIPREG "+ CRLF
cSql += " AND BD6_ANOPAG = BDH_ANOFT  "+ CRLF
cSql += " AND BD6_MESPAG = BDH_MESFT  "+ CRLF
cSql += " AND BD6_SEQPF  = BDH_SEQPF  "+ CRLF
cSql += " AND BD6_NUMSE1 = BDH_NUMSE1 "+ CRLF
					
cSql += " AND NOT EXISTS ( SELECT * FROM "+RetSqlName('PCS')+" PCS WHERE PCS_FILIAL = '"+xFilial("PCS")+"'  AND PCS.D_e_l_e_t_ = ' ' AND PCS_RECBD6 = BD6.r_e_c_n_o_ AND PCS_LCFEC = 11 ) " + CRLF					
                                                                     
cSql += " AND BD6.R_e_c_n_o_ = XML.RECBD6(+)  " + CRLF  

cSql += " AND BAU_FILIAL = '"+xFilial("BAU")+"' "+ CRLF
cSql += " AND BAU_CODIGO = BD6_CODRDA "+ CRLF
cSql += " AND BA1.D_E_L_E_T_ = ' ' "+ CRLF
cSql += " AND BDH.D_E_L_E_T_ = ' ' "+ CRLF
cSql += " AND BD6.D_E_L_E_T_ = ' ' "+ CRLF
cSql += " AND BAU.D_E_L_E_T_ = ' ' AND bau.R_E_C_D_E_L_ = 0"+ CRLF
					
///tratamento para guias reapresentadas
if  Mv_par12 == 2
    cSql += " AND NOT EXISTS" + CRLF
	cSql += " ( select  NULL" + CRLF
	cSql += "    from "+RetSqlName('PCS')+" PCS ,"+RetSqlName('BD6')+" BD61 " + CRLF
	cSql += "   where pcs_filial   ='"+xFilial("PCS")+"' and pcs.D_e_l_E_T_ = ' ' " + CRLF
	cSql += "     and bd61.bd6_filial ='"+xFilial("BD6")+"' " + CRLF
	cSql += "     and bd61.R_E_C_N_O_ = pcs_recbd6 " + CRLF
	cSql += "     and trim(bd61.BD6_CODOPE) = trim(BD6.BD6_CODOPE) " + CRLF
	cSql += "     and trim(bd61.BD6_CODEMP) = trim(BD6.BD6_CODEMP) " + CRLF
	cSql += "     and trim(bd61.BD6_MATRIC) = trim(BD6.BD6_MATRIC) " + CRLF
	cSql += "     and trim(bd61.BD6_TIPREG) = trim(BD6.BD6_TIPREG) " + CRLF
	cSql += "     and trim(bd61.BD6_DATPRO) = trim(BD6.BD6_DATPRO) " + CRLF
	cSql += "     and trim(bd61.BD6_CODPRO) = trim(BD6.BD6_CODPRO) " + CRLF
	cSql += "     and trim(BD61.bd6_CODRDA) = trim(BD6.bd6_CODRDA) " + CRLF
	cSql += "     and trim(bd61.BD6_NUMIMP) = trim(BD6.BD6_NUMIMP) " + CRLF
	cSql += "     and bd61.r_e_c_n_o_ <> bd6.r_e_c_n_o_  " + CRLF						
	cSql += "     and ( bd61.D_e_l_e_t_ = '*' ) " + CRLF
	if  Mv_par13 == 2
	    cSql += "    AND PCS_MESPAG = BD61.BD6_MESPAG " + CRLF
	    cSql += "    AND PCS_ANOPAG = BD61.BD6_ANOPAG " + CRLF
	EndIf
	cSql += "   AND PCS_VLRBPF      >= BD6.BD6_VLRBPF " + CRLF
	cSql += "   AND PCS_VLRTAD      >= BD6.BD6_VLRTAD " + CRLF
	cSql += "   AND PCS_VLRTPF      >= BD6.BD6_VLRTPF " + CRLF
	cSql += " )  " + CRLF
EndIf                                                       

EndIf 
/////
If ( mv_par02 == 1	.or.  mv_par02 == 3)					

   If mv_par02 == 1

      cSql += "union"+ CRLF              
     
   Else 

      cSql := " "     

   EndIf    
						
   cSql += " SELECT BD6_CODOPE, BD6_CODEMP, BD6_MATRIC, BD6_TIPREG, BD6_DIGITO, BD6_DATPRO," + CRLF
   cSql += " BD6_NOMUSR, BD6_CODRDA, BD6_NOMRDA, BD6_DESPRO,"+ CRLF
   cSql += " BD6_VLRTPF, BD6_VLRBPF, BD6_VLRTAD,"+ CRLF
   cSql += " BD6_NUMIMP, BD6_CODOPE, BD6_CODLDP, BD6_CODPEG, BD6_NUMERO, BD6_ORIMOV," + CRLF
   cSql += " BD6_SEQUEN, BD6_CODPRO,   BA1_YMTREP,  BAU_CODIGO, BAU_TIPPE, BAU_NOME ," + CRLF
   cSql += "  PCS_VLRTPF VLRTPFPCS , PCS_VLRBPF VLRBPFPCS ,  PCS_VLRTAD VLRTADPCS ,  " + CRLF						
   cSql += " decode(trim(BD6_FASE),'4','4-Fat','1','1-Dig','2','2-Conf','3','3-Prt', 'N-Prt') fase ,"+ CRLF						
   cSql += "  CASE WHEN trim(nvl(bd6.D_e_l_e_t_,'*')) = '*'             THEN 'Delet. PLS'      " + CRLF
   cSql += "       WHEN nvl(bd6_CODPEG,' ')      = ' '             THEN 'Não Exist PLS'   " + CRLF
   cSql += "       WHEN trim(nvl(BD6_BLOCPA,'1'))= '1'             THEN 'G. Bloq Cob'     " + CRLF
   cSql += "       WHEN trim(nvl(BD6_SITUAC,'0'))<> '1'            THEN 'G. Não Ativa'    " + CRLF
   cSql += "       WHEN SUBSTR(trim(nvl(BD6_fase,'1')),1,1) < '3'  THEN 'G. Fase 1 ou 2'  " + CRLF
   cSql += "       WHEN trim(nvl(BD6_fase,'1'))  <> '4'            THEN 'G. Não Paga'     " + CRLF
   cSql += "       WHEN NVL(BD6_NUMFAT,'            ') = '            ' THEN 'G. Não Cobrd'    " + CRLF
   cSql += "       WHEN PCS_VLRTPF     <>  nvl(BD6_VLRTPF,0.00)     THEN 'Div Vlr Cobrd'   " + CRLF
   cSql += "       WHEN PCS_VLRBPF     <>  nvl(BD6_VLRBPF,0.00)     THEN 'Div Vlr Pagto'   " + CRLF
   cSql += "       WHEN PCS_VLRTAD     <>  nvl(BD6_VLRTAD,0.00)     THEN 'Div Vlr Taxa'    " + CRLF
   cSql += "       Else 'Ok' END  statuspeg  , " + CRLF						
   cSql += "      (nvl(BD6_VLRBPF,0.00) - PCS_VLRBPF) DifB , "+ CRLF
   cSql += "      (nvl(BD6_VLRTAD,0.00) - PCS_VLRTAD) DifT , "+ CRLF
   cSql += "      (nvl(BD6_VLRTPF,0.00) - PCS_VLRTPF) DifTOT ,  "+ CRLF					
   cSql += "       PCS.r_e_c_n_o_ PCSRECNO  , BD6.r_e_c_n_o_ BD6RECNO , "+ CRLF           
   
   cSql += "        ' '  IDLOT " + CRLF
						
   cSql += " FROM  "+RetSqlName('BD6')+" BD6 , "+RetSqlName('BA1')+" BA1 , "+RetSqlName('BAU')+" BAU , siga."+RetSqlName('PCS')+" PCS " + CRLF
   cSql += " WHERE BA1_FILIAL = '"+xFilial("BA1")+"' "+ CRLF
   cSql += " AND BA1_CODINT = BD6_OPEUSR " + CRLF
   cSql += " AND BA1_CODEMP = BD6_CODEMP " + CRLF
   cSql += " AND BA1_MATRIC = BD6_MATRIC " + CRLF
   cSql += " AND BA1_TIPREG = BD6_TIPREG " + CRLF
   cSql += " AND BD6_FILIAL = '"+xFilial("BD6")+"' " + CRLF
						
   cSql += " AND pcs_filial = '"+xFilial("PCS")+"' " + CRLF
   cSql += " AND PCS_RECBD6 = BD6.r_e_c_n_o_ " + CRLF
						
   cSQL += " AND PCS_OPEORI = '"+cOpeOri+"'  " + CRLF
   cSQL += " AND PCS_ANOPAG||PCS_MESPAG = '"+cAnoMes+"'  " + CRLF
						
   cSql += " AND BAU_FILIAL = '"+xFilial("BAU")+"' " + CRLF
   cSql += " AND BAU_CODIGO = BD6_CODRDA "+ CRLF
   cSql += " AND BA1.D_E_L_E_T_ = ' ' " + CRLF
						
   cSql += " AND BAU.D_E_L_E_T_ = ' ' AND bau.R_E_C_D_E_L_ = 0 " + CRLF
   cSql += " and PCS.D_E_L_E_T_ = ' ' " + CRLF
						
///tratamento para guias reapresentadas
   if  Mv_par12 == 2
       cSql += " AND NOT EXISTS" + CRLF
       cSql += " ( select  NULL" + CRLF
       cSql += "     from siga."+RetSqlName('PCS')+" PCS  ,siga."+RetSqlName('BD6')+" BD61 " + CRLF
       cSql += "   where pcs_filial      ='"+xFilial("PCS")+"' and pcs.D_e_l_E_T_ = ' ' " + CRLF
       cSql += "     and bd61.bd6_filial ='"+xFilial("BD6")+"' and bd61.D_e_l_E_T_ = ' ' " + CRLF
     //cSql += "     and bd61.R_E_C_N_O_ = pcs_recbd6 " + CRLF
       cSql += "     and trim(bd61.BD6_CODOPE) = trim(BD6.BD6_CODOPE) " + CRLF
       cSql += "     and trim(bd61.BD6_CODEMP) = trim(BD6.BD6_CODEMP) " + CRLF
       cSql += "     and trim(bd61.BD6_MATRIC) = trim(BD6.BD6_MATRIC) " + CRLF
       cSql += "     and trim(bd61.BD6_TIPREG) = trim(BD6.BD6_TIPREG) " + CRLF
       cSql += "     and trim(bd61.BD6_DATPRO) = trim(BD6.BD6_DATPRO) " + CRLF
       cSql += "     and trim(bd61.BD6_CODPRO) = trim(BD6.BD6_CODPRO) " + CRLF
       cSql += "     and trim(BD61.bd6_CODRDA) = trim(BD6.bd6_CODRDA) " + CRLF
       cSql += "     and trim(bd61.BD6_NUMIMP) = trim(BD6.BD6_NUMIMP) " + CRLF
     //cSql += "     and trim(bd61.bd6_HORPRO) = trim(BD6.bd6_HORPRO) " + CRLF
       cSql += "     and bd61.r_e_c_n_o_ <> bd6.r_e_c_n_o_  " + CRLF						
       cSql += "     and ( bd6.D_e_l_e_t_ = '*' )" + CRLF
     //cSql += "        or bd6.BD6_SITUAC     <> '1' ) " + CRLF
       if Mv_par13 == 2
          cSql += "    AND PCS_MESPAG = BD61.BD6_MESPAG " + CRLF
          cSql += "    AND PCS_ANOPAG = BD61.BD6_ANOPAG " + CRLF
       EndIf
       cSql += "     AND PCS_VLRBPF  = BD61.BD6_VLRBPF " + CRLF
       cSql += "     AND PCS_VLRTAD  = BD61.BD6_VLRTAD " + CRLF
       cSql += "     AND PCS_VLRTPF  = BD61.BD6_VLRTPF " + CRLF
       cSql += " ) " + CRLF
   EndIf
///
   cSql += "  and ( trim(nvl(bd6.D_e_l_e_t_,'*'))  = '*'    " + CRLF
   cSql += "        or nvl(bd6_CODPEG,' ')         = ' '    " + CRLF
   cSql += "        or trim(nvl(BD6_SITUAC,'0'))  <> '1'    " + CRLF
//CRITICA DE COPARTICIPAÇÃO BLOQUEADA 						
   If mv_par09 == 1
      cSql += "        or trim(nvl(BD6_BLOCPA,'1'))   = '1'    " + CRLF
   EndIf
//CRITICA DE FASE MENOR QUE 3 , IGUAL A 1 OU 2 												
   If mv_par07 == 1
      cSql += "        or trim(nvl(BD6_fase,'1'))     < '3'    " + CRLF
   EndIf
//CRITICA DE FASE MENOR QUE 4 , IGUAL A 1 , 2 OU 3 																		
   If mv_par06 == 1
      cSql += "        or trim(nvl(BD6_fase,'1'))    <> '4'    " + CRLF
   EndIf
//CRITICA DE NAO FATURADA 																								
   If mv_par08 == 1
      cSql += "        or NVL(BD6_NUMFAT,'            ') = '            ' " + CRLF
   EndIf
//CRITICA DE VALOR TOTAL , MAIOR , MENOR OU DIFERENTE    																														
   If mv_par03 == 1
      cSql += "        or PCS_VLRTPF >  nvl(BD6_VLRTPF,0.00)   " + CRLF
   ElseIf mv_par03 == 2
      cSql += "        or PCS_VLRTPF <  nvl(BD6_VLRTPF,0.00)   " + CRLF
   ElseIf mv_par03 == 4
      cSql += "        or PCS_VLRTPF <> nvl(BD6_VLRTPF,0.00)   " + CRLF
   EndIf
//CRITICA DE VALOR BASE , MAIOR , MENOR OU DIFERENTE    																																				
   If mv_par04 == 1
      cSql += "        or PCS_VLRBPF >  nvl(BD6_VLRBPF,0.00)   " + CRLF
   ElseIf mv_par04 == 2
      cSql += "        or PCS_VLRBPF <  nvl(BD6_VLRBPF,0.00)   " + CRLF 
   ElseIf mv_par04 == 4
      cSql += "        or PCS_VLRBPF <> nvl(BD6_VLRBPF,0.00)   " + CRLF
   EndIf
//CRITICA DE VALOR TAXA , MAIOR , MENOR OU DIFERENTE    																																										
   If mv_par05 == 1
      cSql += "        or PCS_VLRTAD >  nvl(BD6_VLRTAD,0.00)   " + CRLF
   ElseIf mv_par05 == 2
      cSql += "        or PCS_VLRTAD <  nvl(BD6_VLRTAD,0.00)   " + CRLF
   ElseIf mv_par05 == 4
      cSql += "        or PCS_VLRTAD <> nvl(BD6_VLRTAD,0.00)   " + CRLF
   EndIf
						
   cSql += " ) " + CRLF
						
EndIf
					
cSql += " ORDER BY 1,2,3,4,5,6 "+ CRLF
					

If Select(("TRB2")) <> 0
					
   ("TRB2")->(DbCloseArea())
					
Endif
					                                                                                           
TcQuery cSql New Alias ("TRB2")
		
////

While !("TRB2")->(EOF())   
	
	aAdd(aDados1,{ .T. ,;
	TRB2->BD6_CODOPE , ;
	TRB2->BD6_CODEMP , ;
	TRB2->BD6_MATRIC , ;
	TRB2->BD6_TIPREG , ;
	TRB2->BD6_DIGITO , ;
	TRB2->BD6_DATPRO , ;
	TRB2->BD6_NOMUSR , ;
	TRB2->BD6_CODRDA , ;
	TRB2->BD6_NOMRDA , ;
	TRB2->BD6_DESPRO , ;
	TRB2->BD6_VLRTPF , ;
	TRB2->BD6_VLRBPF , ;
	TRB2->BD6_VLRTAD , ;
	TRB2->BD6_NUMIMP , ;
	TRB2->BD6_CODOPE , ;
	TRB2->BD6_CODLDP , ;
	TRB2->BD6_CODPEG , ;
	TRB2->BD6_NUMERO , ;
	TRB2->BD6_ORIMOV , ;
	TRB2->BD6_SEQUEN , ;
	TRB2->BD6_CODPRO , ;
	TRB2->BA1_YMTREP , ;
	TRB2->BAU_CODIGO , ;
	TRB2->BAU_TIPPE  , ;
	TRB2->BAU_NOME   , ;
	TRB2->VLRTPFPCS , ;
	TRB2->VLRBPFPCS , ;
	TRB2->VLRTADPCS , ;
	TRB2->statuspeg  , ;
	TRB2->DifB  , ;
	TRB2->DifT , ;
	TRB2->DifTOT,;
	TRB2->PCSRECNO ,;
	TRB2->BD6RECNO ,;
	TRB2->IDLOT })

	("TRB2")->(DbSkip())
	
EndDo

("TRB2")->(DbCloseArea())

If empty(aDados1)   
  aAdd(aDados1,{ .T. , ;
 				' ' , ;
				' ' , ;
				' ' , ;
				' ' , ;
				' ' , ;
				'        ' , ;
				' ' , ;
				' ' , ;
				' ' , ;
				' ' , ;
				0.00 , ;
				0.00 , ;
				0.00 , ;
				' ' , ;
				' ' , ;
				' ' , ;
				' ' , ;
				' ' , ;
				' ' , ;
				' ' , ;
				' ' , ;
				' ' , ;
				' ' , ;
				' ' , ;
				' ' , ;
				0.00 , ;
				0.00 , ;
				0.00 , ;
				' '  , ;
				0.00 , ;
				0.00 , ;
				0.00 , ;
				0    , ;
				0    , ;
				' '  })
				
EndIf

Return (aDados1)

/**********************************************************************************/

Static Function marca() 

Local nI

For nI := 1 to len(aDados)
	
	aDados[nI,1]:= .T.
	
Next

RETURN()


Static Function desmarca() 

Local nI

For nI := 1 to len(aDados)
	
	aDados[nI,1]:= .F.
	
Next


RETURN()


/***************************************************************************************/
/**********************************************************************************/

Static Function AjustaSX1(cPerg)

Local aHelpPor := {}     

PutSx1(cPerg,"01",OemToAnsi("Lote Int Eventual "      )  ,"","","mv_ch01","C",08,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "", "" )
PutSx1(cPerg,"02",OemToAnsi("Faz Criticas ?"          )  ,"","","mv_ch02","N",01,0,0,"C","","","","","mv_par02","Sim"     ,"","","","Não"    ,"","","Só Critica","","","","","","","","","","","","","","","","","" , "" , "" , "", "", "" )
PutSx1(cPerg,"03",OemToAnsi("Critíca Vlr Tot  Part"   )  ,"","","mv_ch03","N",01,0,0,"C","","","","","mv_par03","À Maior ","","","","À Menor","","","Não Critica","","","Critica Tot","","","","","",{},{},{})
PutSx1(cPerg,"04",OemToAnsi("Critíca Vlr Base Part"   )  ,"","","mv_ch04","N",01,0,0,"C","","","","","mv_par04","À Maior ","","","","À Menor","","","Não Critica","","","Critica Tot","","","","","",{},{},{})
PutSx1(cPerg,"05",OemToAnsi("Critíca Vlr Taxa Part"   )  ,"","","mv_ch05","N",01,0,0,"C","","","","","mv_par05","À Maior ","","","","À Menor","","","Não Critica","","","Critica Tot","","","","","",{},{},{})
PutSx1(cPerg,"06",OemToAnsi("Critíca Fase 3       "   )  ,"","","mv_ch06","N",01,0,0,"C","","","","","mv_par06","Sim ","","","","Não ","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"07",OemToAnsi("Critíca Fase Ant 3   "   )  ,"","","mv_ch07","N",01,0,0,"C","","","","","mv_par07","Sim ","","","","Não ","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"08",OemToAnsi("Critíca Faturad      "   )  ,"","","mv_ch08","N",01,0,0,"C","","","","","mv_par08","Sim ","","","","Não ","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"09",OemToAnsi("Critíca Bloq Faturad "   )  ,"","","mv_ch09","N",01,0,0,"C","","","","","mv_par09","Sim ","","","","Não ","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"10",OemToAnsi("Faz Conciliação      "   )  ,"","","mv_ch10","N",01,0,0,"C","","","","","mv_par10","Sim ","","","","Não ","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"11",OemToAnsi("Mostrar Titulo COV   "   )  ,"","","mv_ch11","N",01,0,0,"C","","","","","mv_par11","Sim ","","","","Não ","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"12",OemToAnsi("Mostrar Lanc. Duplic "   )  ,"","","mv_ch12","N",01,0,0,"C","","","","","mv_par12","Sim ","","","","Não ","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"13",OemToAnsi("Consid Duplic F/ Compet" )  ,"","","mv_ch13","N",01,0,0,"C","","","","","mv_par13","Sim ","","","","Não ","","","","","","","","","","","",{},{},{})

Pergunte(cPerg,.F.)

Return

Static function fFazRel()   

//³ Chama SetPrint (padrao)                                                  
cRel := SetPrint(cAlias,cRel,cPerg1,@cTitulo,cDesc1,cDesc2,cDesc3,lDicion,aOrderns,lCompres,cTamanho,{},lFiltro,lCrystal)

//³ Verifica se foi cancelada a operacao (padrao)                            
If nLastKey  == 27
	Return
Endif

//³ Configura impressora (padrao)                                            
SetDefault(aReturn,cAlias)

//³ Emite relat¢rio                                                          
MsAguarde({|| Imprel() }, cTitulo, "", .T.)
                                                                              
//³ Libera threads                                                           

Roda(0,space(10),cTamanho)

If  aReturn[5] == 1
	Set Printer To
	Ourspool(cRel)
Endif

DbSelectArea("BDC")  

Ms_Flush()      

Return(  )


//³ Fim da rotina                                                             

//Return (arettit)
////////
static function Imprel() 

MsProcTxt(PLSTR0001)   

nLi := 80
VldPag()
              
///////
cOPEORI  := Left(Posicione("BA0",1,xFilial("BA0")+TRB1->BTO_OPEORI,"BA0_NOMINT"),18)         

If mv_par11 == 1
   @ nLi, 000 PSAY STR0008 						
     nLi++   
   @ nLi, 000 PSAY Replicate('-',215)
     nLi++   
EndIf      
@ nLi, 000 PSAY TRB1->BTO_OPEORI+"-"
@ nLi, 007 PSAY Left(Posicione("BA0",1,xFilial("BA0")+TRB1->BTO_OPEORI,"BA0_NOMINT"),18)
			
If mv_par11 == 1
				
   @ nLi, 034 PSAY TRB1->BTO_PREFIX
   @ nLi, 039 PSAY TRB1->BTO_NUMTIT
   @ nLi, 046 PSAY TRB1->BTO_PARCEL
   @ nLi, 050 PSAY TRB1->BTO_TIPTIT
   @ nLi, 053 PSAY StrZero(TRB1->BTO_QTDEVE, 5)
				
   @ nLi, 074 PSAY Transform(TRB1->(BTO_VLRCOP+BTO_VLRCP2+BTO_VLRCP3),"@E 99,999,999.99")
   @ nLi, 103 PSAY Transform(TRB1->BTO_VLRTAX,"@E 99,999,999.99")
   @ nLi, 118 PSAY Transform(TRB1->BTO_CUSTOT,"@E 99,999,999.99")
				
EndIf

nLi++
_nTotValor	:= 0
_nTotTaxa	:= 0
_nTotINSS	:= 0
			
cTitSe1 := TRB1->BTO_PREFIX + TRB1->BTO_NUMTIT + TRB1->BTO_PARCEL + TRB1->BTO_TIPTIT  

/****************************************************************/

If mv_par11 == 1
	
// 	@ nLi, 000 PSAY TRB1->BTO_OPEORI+"-"
//	@ nLi, 007 PSAY Left(Posicione("BA0",1,xFilial("BA0")+TRB1->BTO_OPEORI,"BA0_NOMINT"),18)
	@ nLi, 034 PSAY (cAliasCT)->PREFIXO
	@ nLi, 039 PSAY (cAliasCT)->NUM
	@ nLi, 046 PSAY ' '
	@ nLi, 050 PSAY (cAliasCT)->TIPO
	@ nLi, 053 PSAY StrZero((cAliasCT)->QTDA, 5)
				
	@ nLi, 074 PSAY Transform(((cAliasCT)->VLRBPF)*-1,"99,999,999.99")
	@ nLi, 103 PSAY Transform(((cAliasCT)->VLRTAD*-1),"@E 99,999,999.99")
	@ nLi, 118 PSAY Transform(((cAliasCT)->VLRBPF*-1)+((cAliasCT)->VLRTAD*-1),"99,999,999.99")
	@ nLi, 133 PSAY Transform(((cAliasCT)->VLRINS*-1),"@E 99,999,999.99")
	nLi++
EndIf
				 					
  aadd(arettitcov,{(cAliasCT)->PREFIXO , (cAliasCT)->NUM , (cAliasCT)->TIPO , mv_par01 , mv_par02, mv_par03 , mv_par04, mv_par05 , mv_par06, mv_par07 , mv_par08, mv_par09 , mv_par10})
			
  _VLRTAD :=_vlrtad + (cAliasCT)->VLRTAD
  _VLRBPF :=_VLRBPF + (cAliasCT)->VLRBPF
  _VLRINS :=_VLRINS + (cAliasCT)->VLRINS
							
/****************************************************************/ 
			
    fGrvPlan(cOPEORI ,mv_par01 , cFazFec )
				
	@ nLi, 000 PSAY Replicate('-',215)
	nLi++
					
	cMatImpAnt := ""



For x:= 1 to len(aDados)       
/*
 cPosic1    := ' '
 cPosic2    := ' '
 cPosic3    := ' '
 cPosic4	:= ' '
 cPosic5 	:= ' '
 cPosic6 	:= ' '
 cPosic7 	:= ' '
 cPosic8 	:= ' '
 cPosic9 	:= ' ' 
 cPosic10 	:= ' '
 */ 
If 	aDados[x,1] == .T. .and. !Empty(aDados[x,02])
    cDatPro := StoD("")
    cNumImp := ""
    If Empty(aDados[x,07])         //TRB2->(BD6_DATPRO)					
   	   If  aDados[x,20]== "1"      //TRB2->BD6_ORIMOV
          If BD5->(MsSeek(xFilial("BD5")+aDados[x,02],aDados[x,17],aDados[x,28] , aDados[x,19])) //TRB2->(BD6_CODOPE, BD6_CODLDP, BD6_CODPEG, BD6_NUMERO)
             cDatPro := BD5->BD5_DATPRO
             cNumImp := BD5->BD5_NUMIMP
          EndIf
       Else
          If BE4->(MsSeek(xFilial("BE4")+aDados[x,02],aDados[x,17],aDados[x,28] , aDados[x,19]))    //TRB2->(BD6_CODOPE, BD6_CODLDP, BD6_CODPEG, BD6_NUMERO)
             cDatPro := BE4->BE4_DATPRO
             cNumImp := BE4->BE4_NUMIMP
          EndIf
       EndIf
    Else
//       cDatPro := DtoC(aDados[x,07]) //TRB2->BD6_DATPRO     
       cDatPro := aDados[x,07] //TRB2->BD6_DATPRO       
       cNumImp := aDados[x,15]       //TRB2->BD6_NUMIMP
    Endif
						
/*
            10        20        30        40        50        60        70        80        90        100       110       120       130       140       150       160       170       180       190       200       210
  012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
  Associado                                               Mat. Convenio      Data Proc.   Prestador                    Nr.Impresso           Procedimento                        Valor     Taxa Conv.         INSS   "
  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx-9.999.9999.999999.99-9  xxxxxxxxxxxxxxxxx   99/99/99    999999-xxxxxxxxxxxxxxxxxxxx  99999999999999999999  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx 999,999.99     999,999.99   999,999.99   "
*/
						
    _nMultINSS := Iif(aDados[x,25]=="F",0.2,0)  //TRB2->BAU_TIPPE
						
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ 12/2/08: Conforme regra solicitada, nao imprimir o ³
//³ quando for o mesmo beneficiario nome e matricula...³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
    If  (aDados[x,02] + aDados[x,03] + aDados[x,04] + aDados[x,05] + aDados[x,06]) <> cMatImpAnt       //TRB2->(BD6_CODOPE+BD6_CODEMP+BD6_MATRIC+BD6_TIPREG+BD6_DIGITO)
          						
        If !Empty(cMatImpAnt)
           //Imprime totalizador somatorio / batimento de valores...
           @ nLi, 076 PSAY Replicate('-',139)
             nLi++
           @ nLi, 176 PSAY Transform(_nTotUsrValor,"@E 999,999.99")
           @ nLi, 191 PSAY Transform(_nTotUsrTaxa,"@E 999,999.99")
           @ nLi, 204 PSAY Transform(_nTotUsrINSS,"@E 999,999.99")
             nLi+=2	
        EndIf
        _nTotUsrValor	:= 0
	    _nTotUsrTaxa	:= 0
	    _nTotUsrINSS	:= 0
								
	    @ nLi, 000 PSAY Left(aDados[x,08],31)+'-'+Transform((aDados[x,02]+aDados[x,03]+aDados[x,04]+aDados[x,05]+aDados[x,06]),"@R !!!!.!!!!.!!!!!!-!!-!")    //__cPictUsr //TRB2->(BD6_CODOPE+BD6_CODEMP+BD6_MATRIC+BD6_TIPREG+BD6_DIGITO // Left(TRB2->BD6_NOMUSR,31)
	      cPosic1 := Left(aDados[x,08],31)+'-'+Transform((aDados[x,02]+aDados[x,03]+aDados[x,04]+aDados[x,05]+aDados[x,06]),"@R !!!!.!!!!.!!!!!!-!!-!") 
    	@ nLi, 056 PSAY Alltrim(aDados[x,23])+Space(17-Len(Alltrim(aDados[x,23])))  //Alltrim(TRB2->BA1_YMTREP)+Space(17-Len(Alltrim(TRB2->BA1_YMTREP)))        
    	  cPosic2 := Alltrim(aDados[x,23])+Space(17-Len(Alltrim(aDados[x,23]))) 
    	  nLi+=1     	  
    Endif 
    
    If aDados[x,36] != ' ' 	  
       @ nLi, 005 PSAY 'Lote XML--> '+aDados[x,36]
       cPosic10 := aDados[x,36]
    Else                       
       cPosic10 := ' '    
	EndIf   
    
    @ nLi, 076 PSAY substr(cDatPro,7,2)+'/'+substr(cDatPro,5,2)+'/'+substr(cDatPro,1,4) 
      cPosic3 := substr(cDatPro,7,2)+'/'+substr(cDatPro,5,2)+'/'+substr(cDatPro,1,4) 
    @ nLi, 088 PSAY aDados[x,09] +'-'+Substr(aDados[x,26],1,20)  //TRB2->BD6_CODRDA+'-'+Substr(TRB2->BAU_NOME,1,20)
      cPosic4 := aDados[x,09] +'-'+Substr(aDados[x,26],1,20)     
    @ nLi, 117 PSAY cNumImp                                     
      cPosic5 := cNumImp          
    @ nLi, 139 PSAY aDados[x,22]+Substr(aDados[x,11],1,11) //TRB2->BD6_CODPRO+Substr(TRB2->BD6_DESPRO,1,20)
      cPosic6 := aDados[x,22]+Substr(aDados[x,11],1,11)          
						
    if   (trim(aDados[x,30]) == 'Delet. PLS' ) .or.  (trim(aDados[x,30]) == 'Não Exist PLS' ) ; // TRB2->statuspeg
    .or. (trim(aDados[x,30]) == 'G. Não Paga') .or.  (trim(aDados[x,30]) == 'G. Não Cobrd'  ) ;
    .or. (trim(aDados[x,30]) == 'G. Bloq Cob') .or.  (trim(aDados[x,30]) == 'G. Não Ativa'  ) ;
    .or. (trim(aDados[x,30]) == 'G. Fase 1 ou 2')
							
         @ nLi, 010 PSAY aDados[x,30] + ' - ' + Transform((aDados[x,28]*-1),"@E 999,999.99") + ' - ' + Transform((aDados[x,29]*-1),"@E 999,999.99")// TRB2->statuspeg //TRB2->(VLRBPFPCS) //TRB2->(VLRTADPCS)
       //    cPosic1 := aDados[x,30] + ' - ' + Transform((aDados[x,28]*-1),"@E 999,999.99") + ' - ' + Transform((aDados[x,29]*-1),"@E 999,999.99")         
         @ nLi, 176 PSAY Transform((aDados[x,28]*-1),"@E 999,999.99") //TRB2->(VLRBPFPCS)
           cPosic7 := Transform((aDados[x,28]*-1),"@E 999,999.99")          
         @ nLi, 191 PSAY Transform((aDados[x,29]*-1),"@E 999,999.99") //TRB2->(VLRTADPCS)
           cPosic8 := Transform((aDados[x,29]*-1),"@E 999,999.99")         
         @ nLi, 204 PSAY Transform(((aDados[x,28]*_nMultINSS)*-1),"@E 999,999.99") //INSS (cfme regra Caberj - Marcela - somente cobra de PF.)//TRB2->(VLRBPFPCS)
           cPosic9 := Transform(((aDados[x,28]*_nMultINSS)*-1),"@E 999,999.99")            

         _VLRTADT       :=  aDados[x,29] *-1  //TRB2->(VLRTADPCS)
         _VLRBPFT       :=  aDados[x,28] *-1  //TRB2->(VLRBPFPCS)
         _VLRINST       := (aDados[x,28] *_nMultINSS)*-1 //TRB2->(VLRBPFPCS)
							
         _nTotUsrValor	+=  aDados[x,28]  *-1                 //TRB2->VLRBPFPCS
         _nTotUsrTaxa	+=  aDados[x,29]  *-1                 //TRB2->VLRTADPCS
         _nTotUsrINSS	+= (aDados[x,28]  *_nMultINSS)*-1      //TRB2->VLRBPFPCS
							
         _nTotValor     +=  aDados[x,28] *-1                     //TRB2->VLRBPFPCS
         _nTotTaxa      +=  aDados[x,29] *-1                     //TRB2->VLRTADPCS
         _nTotINSS      += (aDados[x,28] *_nMultINSS)*-1       //TRB2->VLRBPFPCS
							
    ElseIf (aDados[x,31] <> 0 .OR. aDados[x,32] <> 0 .OR. aDados[x,33] <> 0)  //(TRB2->DifB <> 0 .OR. TRB2->DifT <> 0 .OR. TRB2->DifTOT <> 0)
							
         @ nLi, 010 PSAY trim(aDados[x,30]) + ' - ' +  Transform((aDados[x,31]),"@E 999,999.99") + ' - ' +  Transform((aDados[x,32]),"@E 999,999.99")
        //   cPosic1 := trim(aDados[x,30]) + ' - ' +  Transform((aDados[x,31]),"@E 999,999.99") + ' - ' +  Transform((aDados[x,32]),"@E 999,999.99")       
         @ nLi, 176 PSAY Transform((aDados[x,31] ),"@E 999,999.99")
           cPosic7 := Transform((aDados[x,31] ),"@E 999,999.99")
         @ nLi, 191 PSAY Transform((aDados[x,32] ),"@E 999,999.99")
           cPosic8 := Transform((aDados[x,32] ),"@E 999,999.99")
         @ nLi, 204 PSAY Transform(((aDados[x,31])*_nMultINSS),"@E 999,999.99")  //INSS (cfme regra Caberj - Marcela - somente cobra de PF.)
           cPosic9 := Transform(((aDados[x,31])*_nMultINSS),"@E 999,999.99")
           						
         _VLRTADT:=  aDados[x,32]
         _VLRbPFT:=  aDados[x,31]
         _VLRINST:=  (aDados[x,12]-aDados[x,14]) + (aDados[x,31]-aDados[x,32])*_nMultINSS - (adados[x,12]-adados[x,14])*_nMultINSS
//                  TRB2->((BD6_VLRTPF-BD6_VLRTAD)+(TRB2->DifB+TRB2->DifT))*_nMultINSS - TRB2->(BD6_VLRTPF-BD6_VLRTAD)*_nMultINSS
							
         _nTotUsrValor	+= aDados[x,31] //TRB2->DifB
         _nTotUsrTaxa	+= aDados[x,32] //TRB2->DifT
         _nTotUsrINSS	+= ((aDados[x,12]-aDados[x,14]) + (aDados[x,31]-aDados[x,32]))*_nMultINSS - ((adados[x,12]-adados[x,14]))*_nMultINSS
                         //TRB2->((BD6_VLRTPF-BD6_VLRTAD)+(TRB2->DifB+TRB2->DifT))*_nMultINSS - TRB2->(BD6_VLRTPF-BD6_VLRTAD)*_nMultINSS
							
         _nTotValor += aDados[x,31] //TRB2->DifB
         _nTotTaxa  += aDados[x,32] //TRB2->DifT
         _nTotINSS  += ((aDados[x,12]-aDados[x,14]) + (aDados[x,31]-aDados[x,32]))*_nMultINSS - ((adados[x,12]-adados[x,14]))*_nMultINSS 
                    //TRB2->((BD6_VLRTPF-BD6_VLRTAD)+(TRB2->DifB+TRB2->DifT))*_nMultINSS - TRB2->(BD6_VLRTPF-BD6_VLRTAD)*_nMultINSS
							
    Else
         @ nLi, 176 PSAY Transform(aDados[x,12]-aDados[x,14],"@E 999,999.99") //TRB2->(BD6_VLRTPF-BD6_VLRTAD)
           cPosic7 := Transform(aDados[x,12]-aDados[x,14],"@E 999,999.99")	
         @ nLi, 191 PSAY Transform(aDados[x,14],"@E 999,999.99")        // TRB2->(BD6_VLRTAD)
           cPosic8 := Transform(aDados[x,14],"@E 999,999.99") 
         @ nLi, 204 PSAY Transform(((aDados[x,12]-aDados[x,14])*_nMultINSS),"@E 999,999.99") //INSS (cfme regra Caberj - Marcela - somente cobra de PF.)//TRB2->(BD6_VLRTPF-BD6_VLRTAD)
           cPosic9 :=  Transform(((aDados[x,12]-aDados[x,14])*_nMultINSS),"@E 999,999.99")
 							
         _VLRTADT:=  0.00
         _VLRBPFT:=  0.00
         _VLRINST:=  0.00
							
         _nTotUsrValor +=  aDados[x,12]-aDados[x,14] + _VLRBPFT  //TRB2->(BD6_VLRTPF-BD6_VLRTAD) + _VLRBPFT
         _nTotUsrTaxa  +=  aDados[x,14] + _VLRTADT                //TRB2->(BD6_VLRTAD) + _VLRTADT
         _nTotUsrINSS  += ((aDados[x,12]-aDados[x,14])*_nMultINSS) + _VLRINST //  (TRB2->(BD6_VLRTPF-BD6_VLRTAD)*_nMultINSS) + _VLRINST
							
         _nTotValor    +=  aDados[x,12]-aDados[x,14] + _VLRBPFT             //TRB2->(BD6_VLRTPF-BD6_VLRTAD) + _VLRBPFT
         _nTotTaxa     +=  aDados[x,14] + _VLRTADT                          // TRB2->(BD6_VLRTAD) + _VLRTADT
         _nTotINSS     += ((aDados[x,12]-aDados[x,14])*_nMultINSS) + _VLRINST //(TRB2->(BD6_VLRTPF-BD6_VLRTAD)*_nMultINSS) + _VLRINST
							
    EndIf
    //@ nLi, 198 PSAY Transform(TRB2->(BD6_VLRTPF-BD6_VLRTAD)*0.2,"@E 999,999.99") //INSS (cfme regra Caberj - Marcela - somente cobra de PF.)
    cMatImpAnt := aDados[x,02]+aDados[x,03]+aDados[x,04]+aDados[x,05]+aDados[x,06] //TRB2->(BD6_CODOPE+BD6_CODEMP+BD6_MATRIC+BD6_TIPREG+BD6_DIGITO)
						
    If cFazFec == 1 .and.(trim(aDados[x,30])) != 'Ok'  .AND. aDados[x,34] != 0   //(trim(TRB2->statuspeg)) != 'Ok'  .AND. TRB2->PCSRECNO != 0
							
       FGrvContr( aDados[x,34] , (trim(aDados[x,30]))  )
							
    EndIf
						
//			fMarcPcs((trim(TRB2->statuspeg)) futura implemnetação
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ 12/2/08: Conforme solicitado pelo finenceiro, somar³
//³ o valor por usuario para totalizacao individual... ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						
   _VLRTADTOT+= _VLRTADT
   _VLRBPFTOT+= _VLRBPFT
   _VLRINSTOT+= _VLRINST
						
   _VLRTADT:=  0.00
   _VLRBPFT:=  0.00
   _VLRINST:=  0.00
						
   nLi ++
// TRB2->( dbSkip() )
   lImprimiu := .T.
						
   VldPag() 
EndIf  

fGrvDad2()

Next  
 
    fGrvPlan1(cOPEORI ,mv_par01 , cFazFec  )

//³ 12/2/08: Imprime o ultimo totalizador por usuario. ³
If !Empty(cMatImpAnt)
   //Imprime totalizador somatorio / batimento de valores...
   @ nLi, 076 PSAY Replicate('-',139)
     nLi+=2
   @ nLi, 176 PSAY Transform(_nTotUsrValor,"@E 999,999.99")
   @ nLi, 191 PSAY Transform(_nTotUsrTaxa,"@E 999,999.99")
   @ nLi, 204 PSAY Transform(_nTotUsrINSS,"@E 999,999.99")
     nLi++
Endif
										
//Imprime totalizador somatorio / batimento de valores...
@ nLi, 000 PSAY Replicate('-',215)
  nLi++
@ nLi, 176 PSAY Transform(_nTotValor,"@E 999,999.99")
@ nLi, 191 PSAY Transform(_nTotTaxa,"@E 999,999.99")
@ nLi, 204 PSAY Transform(_nTotINSS,"@E 999,999.99")
  nLi ++
					
If lImprimiu
   nLi++
EndIf

@ nLi, 082 PSAY "Valor "                      
@ nLi, 111 PSAY "Taxa "
		
@ nLi, 126 PSAY "Inss "
		
@ nLi, 150 PSAY "Total "
  nLi++
@ nLi, 067 PSAY Replicate('-', 88); nLi++
@ nLi, 037 PSAY "TOTAIS ---> "
@ nLi, 074 PSAY Transform((_nTotValor),"@E 99,999,999.99")
@ nLi, 103 PSAY Transform((_nTotTaxa),"@E 99,999,999.99")
@ nLi, 118 PSAY Transform(( _nTotINSS ),"@E 99,999,999.99")
		
@ nLi, 142 PSAY Transform((_nTotValor+_nTotTaxa+_nTotINSS),"@E 99,999,999.99")
		
arettit:= {cOPEORI ,cTitse1,_nTotValor,_nTotTaxa,_nTotINSS, mv_par01 , mv_par02, mv_par03 , mv_par04, mv_par05 , mv_par06, mv_par07 , mv_par08, mv_par09 , mv_par10}
		
  nLi 	+= 2

		_VLRTADTOT:= 0
		_VLRBPFTOT:= 0
		_VLRINSTOT:= 0

	@ nLi, 000 PSAY Replicate('-',155)

Return()             

Static Function fGrvDad2()               

	aAdd(aDados2 ,{;
	     cPosic1 , ;
		 cPosic2 , ;
		 cPosic3 , ;
	     cPosic4 , ;
	     cPosic5 , ;
	     cPosic6 , ;
	     cPosic7 , ;
	     cPosic8 , ;
	     cPosic9 , ;
	     cPosic10} )

Return()


///////////////////////////////////////////////////////////////// 

//////////
Static Function VldPag()

If nLi > nQtdLin
	R590Cabec()
Endif

Return

///////       

Static Function R590Cabec()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime cabecalho...                                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nLi := Cabec(cTitulo,cCabec1,cCabec2,cRel,cTamanho,IIF(aReturn[4]==1,GetMv("MV_COMP"),GetMv("MV_NORM")))
nLi ++

Return
/////////////////////////

Static Function FGrvContr( nReg , sts  )

	DbSelectArea("PCS")
	dbgoto(nReg)
	
	PCS->(RecLock("PCS",.F.))
	
If   ((trim(sts) == 'Delet. PLS' ) .or. (trim(sts) == 'Não Exist PLS' ) ;
 .or. (trim(sts) == 'G. Bloq Cob') .or. (trim(sts) == 'G. Não Ativa'  ))
	

	  PCS->PCS_LCFEC := 22

Else 	                

	  PCS->PCS_LCFEC := 12
	
EndIf
    
    PCS->(MsUnlock())
Return()
///////////////////////////////////////////////////////////////// 

Static Function FGrvPlan(cOperadora,cComp , cFec )

local ix := 0  

cNomeArq := "C:\TEMP\"+trim(cOperadora)+'_'+cComp+DtoS(date())+"_"+STRTRAN(TIME(),":","")+".csv"
nHandle := FCREATE(cNomeArq)

cMontaTxt := 'Empresa  : '+ trim(cOperadora)
cMontaTxt += CRLF
FWrite(nHandle,cMontaTxt)

cMontaTxt := 'Ação  : Log de Cobrança Final'
cMontaTxt += CRLF
FWrite(nHandle,cMontaTxt)

cMontaTxt := 'Usuario : '+SubStr(cUSUARIO,7,15)
cMontaTxt += CRLF
FWrite(nHandle,cMontaTxt)  
cMontaTxt := "STATUS ;"
cMontaTxt += "BD6_CODOPE  ;"
cMontaTxt += "BD6_CODEMP  ;"
cMontaTxt += "BD6_MATRIC ;"
cMontaTxt += "BD6_TIPREG ;"
cMontaTxt += "BD6_DIGITO ;"
cMontaTxt += "BD6_DATPRO ;"
cMontaTxt += "BD6_NOMUSR ;"
cMontaTxt += "BD6_CODRDA ;"
cMontaTxt += "BD6_NOMRDA ;"
cMontaTxt += "BD6_DESPRO ;"
cMontaTxt += "BD6_VLRTPF ;"
cMontaTxt += "BD6_VLRBPF ;"
cMontaTxt += "BD6_VLRTAD ;"
cMontaTxt += "BD6_NUMIMP ;"
cMontaTxt += "BD6_CODOPE ;"
cMontaTxt += "BD6_CODLDP ;"
cMontaTxt += "BD6_CODPEG ;"
cMontaTxt += "BD6_NUMERO ;"
cMontaTxt += "BD6_ORIMOV ;"
cMontaTxt += "BD6_SEQUEN ;"
cMontaTxt += "BD6_CODPRO ;"
cMontaTxt += "BA1_YMTREP ;"
cMontaTxt += "BAU_CODIGO ;"
cMontaTxt += "BAU_TIPPE  ;"
cMontaTxt += "BAU_NOME   ;"
cMontaTxt += "VLRTPFPCS  ;"
cMontaTxt += "VLRBPFPCS  ;"
cMontaTxt += "VLRTADPCS  ;"
cMontaTxt += "statuspeg  ;"
cMontaTxt += "DifB       ;"
cMontaTxt += "DifT       ;"
cMontaTxt += "DifTOT     ;"     
cMontaTxt += "RecnoPcs   ;" 
cMontaTxt += "RecnoBd6   ;"     
cMontaTxt += "Lote XML   ;"
cMontaTxt += CRLF // Salto de linha para .csv (excel)

FWrite(nHandle,cMontaTxt)



For ix := 1 To Len(aDados)
    cMontaTxt := Iif(aDados[ix,01]==.T., 'Ativo','Inativo') + ";"
	cMontaTxt += aDados[ix,02] + ";"
	cMontaTxt += aDados[ix,03] + ";"
	cMontaTxt += aDados[ix,04] + ";"
	cMontaTxt += aDados[ix,05] + ";"
	cMontaTxt += aDados[ix,06] + ";"
	cMontaTxt += aDados[ix,07] + ";"
	cMontaTxt += aDados[ix,08] + ";"
	cMontaTxt += aDados[ix,09] + ";"
	cMontaTxt += aDados[ix,10] + ";"
	cMontaTxt += aDados[ix,11] + ";" 
	cMontaTxt += Transform((aDados[ix,12]),"@E 99,999,999.99") + ";" 
	cMontaTxt += Transform((aDados[ix,13]),"@E 99,999,999.99") + ";"
	cMontaTxt += Transform((aDados[ix,14]),"@E 99,999,999.99") + ";"
	cMontaTxt += aDados[ix,15] + ";"
	cMontaTxt += aDados[ix,16] + ";"
	cMontaTxt += aDados[ix,17] + ";"
	cMontaTxt += aDados[ix,18] + ";"
	cMontaTxt += aDados[ix,19] + ";"
	cMontaTxt += aDados[ix,20] + ";"
	cMontaTxt += aDados[ix,21] + ";"
	cMontaTxt += aDados[ix,22] + ";"
	cMontaTxt += aDados[ix,23] + ";"
	cMontaTxt += aDados[ix,24] + ";"
	cMontaTxt += aDados[ix,25] + ";"
	cMontaTxt += aDados[ix,26] + ";"
	cMontaTxt += Transform((aDados[ix,27]),"@E 99,999,999.99") + ";" 
	cMontaTxt += Transform((aDados[ix,28]),"@E 99,999,999.99") + ";"
	cMontaTxt += Transform((aDados[ix,29]),"@E 99,999,999.99") + ";"
	cMontaTxt += aDados[ix,30] + ";"
	cMontaTxt += Transform((aDados[ix,31]),"@E 99,999,999.99") + ";"
	cMontaTxt += Transform((aDados[ix,32]),"@E 99,999,999.99") + ";"
	cMontaTxt += Transform((aDados[ix,33]),"@E 99,999,999.99") + ";"
	cMontaTxt += str(aDados[ix,34]) + ";" 
	cMontaTxt += str(aDados[ix,35]) + ";"	    
	cMontaTxt += aDados[ix,36] + ";"

	cMontaTxt += CRLF // Salto de linha para .csv (excel)
	
	FWrite(nHandle,cMontaTxt)
	
next
//		  TRB2->( dbSkip() )


//      EndDo

If nHandle > 0
	
	// encerra gravação no arquivo
	FClose(nHandle)
	//	cNomeArq1+= cNomeArq + CRLF
	MsgAlert("Relatorio salvo em: "+cNomeArq)
	
	//	fEnvEmail(cNomeArq , cEmpresa , trim(aDados[1,1]) )
EndIf
     
If cFec == 1 
	ix := 0  

	cNomeArq := "\fec_conv\"+trim(cOperadora)+'_'+cComp+DtoS(date())+"_"+STRTRAN(TIME(),":","")+".csv"
	nHandle := FCREATE(cNomeArq)
	
	cMontaTxt := 'Empresa  : '+ trim(cOperadora)
	cMontaTxt += CRLF
	FWrite(nHandle,cMontaTxt)
	
	cMontaTxt := 'Ação  : Log de Cobrança Final'
	cMontaTxt += CRLF
	FWrite(nHandle,cMontaTxt)
	
	cMontaTxt := 'Usuario : '+SubStr(cUSUARIO,7,15)
	cMontaTxt += CRLF
	FWrite(nHandle,cMontaTxt)  
	cMontaTxt := "STATUS ;"
	cMontaTxt += "BD6_CODOPE  ;"
	cMontaTxt += "BD6_CODEMP  ;"
	cMontaTxt += "BD6_MATRIC ;"
	cMontaTxt += "BD6_TIPREG ;"
	cMontaTxt += "BD6_DIGITO ;"
	cMontaTxt += "BD6_DATPRO ;"
	cMontaTxt += "BD6_NOMUSR ;"
	cMontaTxt += "BD6_CODRDA ;"
	cMontaTxt += "BD6_NOMRDA ;"
	cMontaTxt += "BD6_DESPRO ;"
	cMontaTxt += "BD6_VLRTPF ;"
	cMontaTxt += "BD6_VLRBPF ;"
	cMontaTxt += "BD6_VLRTAD ;"
	cMontaTxt += "BD6_NUMIMP ;"
	cMontaTxt += "BD6_CODOPE ;"
	cMontaTxt += "BD6_CODLDP ;"
	cMontaTxt += "BD6_CODPEG ;"
	cMontaTxt += "BD6_NUMERO ;"
	cMontaTxt += "BD6_ORIMOV ;"
	cMontaTxt += "BD6_SEQUEN ;"
	cMontaTxt += "BD6_CODPRO ;"
	cMontaTxt += "BA1_YMTREP ;"
	cMontaTxt += "BAU_CODIGO ;"
	cMontaTxt += "BAU_TIPPE  ;"
	cMontaTxt += "BAU_NOME   ;"
	cMontaTxt += "VLRTPFPCS  ;"
	cMontaTxt += "VLRBPFPCS  ;"
	cMontaTxt += "VLRTADPCS  ;"
	cMontaTxt += "statuspeg  ;"
	cMontaTxt += "DifB       ;"
	cMontaTxt += "DifT       ;"
	cMontaTxt += "DifTOT     ;"     
	cMontaTxt += "RecnoPcs   ;" 
	cMontaTxt += "RecnoBd6   ;" 
	cMontaTxt += "Lote Xml   ;"	
	cMontaTxt += CRLF // Salto de linha para .csv (excel)
	
	FWrite(nHandle,cMontaTxt)

	For ix := 1 To Len(aDados)
	    cMontaTxt := Iif(aDados[ix,01]==.T., 'Ativo','Inativo') + ";"
		cMontaTxt += aDados[ix,02] + ";"
		cMontaTxt += aDados[ix,03] + ";"
		cMontaTxt += aDados[ix,04] + ";"
		cMontaTxt += aDados[ix,05] + ";"
		cMontaTxt += aDados[ix,06] + ";"
		cMontaTxt += aDados[ix,07] + ";"
		cMontaTxt += aDados[ix,08] + ";"
		cMontaTxt += aDados[ix,09] + ";"
		cMontaTxt += aDados[ix,10] + ";"
		cMontaTxt += aDados[ix,11] + ";" 
		cMontaTxt += Transform((aDados[ix,12]),"@E 99,999,999.99") + ";" 
		cMontaTxt += Transform((aDados[ix,13]),"@E 99,999,999.99") + ";"
		cMontaTxt += Transform((aDados[ix,14]),"@E 99,999,999.99") + ";"
		cMontaTxt += aDados[ix,15] + ";"
		cMontaTxt += aDados[ix,16] + ";"
		cMontaTxt += aDados[ix,17] + ";"
		cMontaTxt += aDados[ix,18] + ";"
		cMontaTxt += aDados[ix,19] + ";"
		cMontaTxt += aDados[ix,20] + ";"
		cMontaTxt += aDados[ix,21] + ";"
		cMontaTxt += aDados[ix,22] + ";"
		cMontaTxt += aDados[ix,23] + ";"
		cMontaTxt += aDados[ix,24] + ";"
		cMontaTxt += aDados[ix,25] + ";"
		cMontaTxt += aDados[ix,26] + ";"
		cMontaTxt += Transform((aDados[ix,27]),"@E 99,999,999.99") + ";" 
		cMontaTxt += Transform((aDados[ix,28]),"@E 99,999,999.99") + ";"
		cMontaTxt += Transform((aDados[ix,29]),"@E 99,999,999.99") + ";"
		cMontaTxt += aDados[ix,30] + ";"
		cMontaTxt += Transform((aDados[ix,31]),"@E 99,999,999.99") + ";"
		cMontaTxt += Transform((aDados[ix,32]),"@E 99,999,999.99") + ";"
		cMontaTxt += Transform((aDados[ix,33]),"@E 99,999,999.99") + ";"
		cMontaTxt += str(aDados[ix,34]) + ";" 
		cMontaTxt += str(aDados[ix,35]) + ";"	 
		cMontaTxt += aDados[ix,36] + ";"	
	
		cMontaTxt += CRLF // Salto de linha para .csv (excel)
		
		FWrite(nHandle,cMontaTxt)
		
	next
	
	If nHandle > 0
		
		FClose(nHandle)
	
	EndIf
EndIf 

Return() 

///////////////////////////////////////////////////////////////// 

Static Function FGrvPlan1(cOperadora,cComp  , cFec )

local ix := 0  

cNomeArq := "C:\TEMP\Fech"+trim(cOperadora)+'_'+cComp+DtoS(date())+"_"+STRTRAN(TIME(),":","")+'1'+".csv"
nHandle := FCREATE(cNomeArq)

cMontaTxt := 'Empresa  : '+ trim(cOperadora)
cMontaTxt += CRLF
FWrite(nHandle,cMontaTxt)

cMontaTxt := 'Ação  : Planilha de Cobrança Final'
cMontaTxt += CRLF
FWrite(nHandle,cMontaTxt)

cMontaTxt := 'Usuario : '+SubStr(cUSUARIO,7,15)
cMontaTxt += CRLF
FWrite(nHandle,cMontaTxt)  

cMontaTxt1 := "Associado     ;"                                               
cMontaTxt1 += "Mat. Convenio ;"      
cMontaTxt1 += "Data Proc.    ;"
cMontaTxt1 += "Prestador     ;"                
cMontaTxt1 += "Nr.Impresso   ;"        
cMontaTxt1 += "Procedimento  ;"                             
cMontaTxt1 += "Valor         ;"
cMontaTxt1 += "Taxa Conv.    ;"        
cMontaTxt1 += "INSS          ;"
cMontaTxt1 += CRLF // Salto de linha para .csv (excel)

FWrite(nHandle,cMontaTxt1)

For ix := 1 To Len(aDados2)
    cMontaTxt := aDados2[ix,01] + ";"
	cMontaTxt += aDados2[ix,02] + ";"
	cMontaTxt += aDados2[ix,03] + ";"
	cMontaTxt += aDados2[ix,04] + ";"
	cMontaTxt += aDados2[ix,05] + ";"
	cMontaTxt += aDados2[ix,06] + ";"
	cMontaTxt += aDados2[ix,07] + ";"
	cMontaTxt += aDados2[ix,08] + ";"
	cMontaTxt += aDados2[ix,09] + ";" 
	cMontaTxt += aDados2[ix,10] + ";"	
	cMontaTxt += CRLF // Salto de linha para .csv (excel)
	
	FWrite(nHandle,cMontaTxt)
	
next

If nHandle > 0
	
	// encerra gravação no arquivo
	FClose(nHandle)
	//	cNomeArq1+= cNomeArq + CRLF
	MsgAlert("Relatorio salvo em: "+cNomeArq)
	
	//	fEnvEmail(cNomeArq , cEmpresa , trim(aDados[1,1]) )
EndIf

If cfec == 1 

   ix := 0  
	
	cNomeArq := "\fec_conv\Fech"+trim(cOperadora)+'_'+cComp+DtoS(date())+"_"+STRTRAN(TIME(),":","")+".csv"
	nHandle := FCREATE(cNomeArq)
	
	cMontaTxt := 'Empresa  : '+ trim(cOperadora)
	cMontaTxt += CRLF
	FWrite(nHandle,cMontaTxt)
	
	cMontaTxt := 'Ação  : Planilha de Cobrança Final'
	cMontaTxt += CRLF
	FWrite(nHandle,cMontaTxt)
	
	cMontaTxt := 'Usuario : '+SubStr(cUSUARIO,7,15)
	cMontaTxt += CRLF
	FWrite(nHandle,cMontaTxt)  
	
	cMontaTxt1 := "Associado     ;"                                               
	cMontaTxt1 += "Mat. Convenio ;"      
	cMontaTxt1 += "Data Proc.    ;"
	cMontaTxt1 += "Prestador     ;"                
	cMontaTxt1 += "Nr.Impresso   ;"        
	cMontaTxt1 += "Procedimento  ;"                             
	cMontaTxt1 += "Valor         ;"
	cMontaTxt1 += "Taxa Conv.    ;"        
	cMontaTxt1 += "INSS          ;" 
	cMontaTxt1 += "Lote XML      ;"
	cMontaTxt1 += CRLF // Salto de linha para .csv (excel)
	
	FWrite(nHandle,cMontaTxt1)
	
	For ix := 1 To Len(aDados2)
	    cMontaTxt := aDados2[ix,01] + ";"
		cMontaTxt += aDados2[ix,02] + ";"
		cMontaTxt += aDados2[ix,03] + ";"
		cMontaTxt += aDados2[ix,04] + ";"
		cMontaTxt += aDados2[ix,05] + ";"
		cMontaTxt += aDados2[ix,06] + ";"
		cMontaTxt += aDados2[ix,07] + ";"
		cMontaTxt += aDados2[ix,08] + ";"
		cMontaTxt += aDados2[ix,09] + ";" 
		cMontaTxt += aDados2[ix,10] + ";"		
		cMontaTxt += CRLF // Salto de linha para .csv (excel)
		
		FWrite(nHandle,cMontaTxt)
		
	next
	
	If nHandle > 0
		
		// encerra gravação no arquivo
		FClose(nHandle)

	EndIf  
EndIf 
Return()  

/////////////////
/*

  aAdd(aDados1,{ .T. , ;    01
	TRB2->BD6_CODOPE , ;    02
	TRB2->BD6_CODEMP , ;    03
	TRB2->BD6_MATRIC , ;    04
	TRB2->BD6_TIPREG , ;    05
	TRB2->BD6_DIGITO , ;    06
	TRB2->BD6_DATPRO , ;    07
	TRB2->BD6_NOMUSR , ;    08
	TRB2->BD6_CODRDA , ;    09
	TRB2->BD6_NOMRDA , ;    10
	TRB2->BD6_DESPRO , ;    11
	TRB2->BD6_VLRTPF , ;    12
	TRB2->BD6_VLRBPF , ;    13
	TRB2->BD6_VLRTAD , ;    14
	TRB2->BD6_NUMIMP , ;    15
	TRB2->BD6_CODOPE , ;    16
	TRB2->BD6_CODLDP , ;    17
	TRB2->BD6_CODPEG , ;    18
	TRB2->BD6_NUMERO , ;    19
	TRB2->BD6_ORIMOV , ;    20
	TRB2->BD6_SEQUEN , ;    21
	TRB2->BD6_CODPRO , ;    22
	TRB2->BA1_YMTREP , ;    23
	TRB2->BAU_CODIGO , ;    24
	TRB2->BAU_TIPPE  , ;    25
	TRB2->BAU_NOME   , ;    26
	TRB2->VLRTPFPCS  , ;    27
	TRB2->VLRBPFPCS  , ;    28
	TRB2->VLRTADPCS  , ;    29
	TRB2->statuspeg  , ;    30
	TRB2->DifB       , ;    31
	TRB2->DifT       , ;    32
	TRB2->DifTOT     , ;    33
	TRB2->PCSRECNO	        34  
	TRB2->BD6RECNO	        35 	 
	TRB2->IDLOT  	        36 	
*/ 

       