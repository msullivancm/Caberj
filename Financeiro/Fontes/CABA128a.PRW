#Define CRLF Chr(13)+Chr(10)
#INCLUDE "PROTHEUS.ch"                                                                                                                                  
#INCLUDE "TOPCONN.ch"
#INCLUDE "PLSMGER.CH"                                                                                                             
#Include "Ap5Mail.Ch"      
#Include 'Tbiconn.ch'                                                                         
/*--------------------------------------------------------------------------
| Programa  | CABA127  | Autor | Altamiro	Affonso    | Data | 21/06/2013  |
|---------------------------------------------------------------------------|                  
| Descricao | Faturamento de convenios antecipado                           |
|           |                                                               |                                                       
|---------------------------------------------------------------------------|
| Uso       | Faturamento de convenios antecipado   - browser de seleção    |                                   
 --------------------------------------------------------------------------*/

User Function CABA128a
                                                 
local cRda      := ' ' 
local cNivel    := ' '
local nI := 0  

private aBrwPEG
Private aCabPEG		:= {" ", "Compt. Entrada","Operadora de  Origem  ","Vlr Fase 3","Vlr Fase 31/2","Vlr Fase 4","Vlr Inss","Vlr Tx Adm", "Vlr Guias" , "Total Guias","Faturado","Qtda Guias"}
Private aTamPEG		:= {10,30,120,45,45,45,45,45,45,45,25}  


Private oOk      	:= LoadBitMap(GetResources(),"LBOK")
Private oNo      	:= LoadBitMap(GetResources(),"LBNO")


Private aObjects 	:= {}

Private aSizeAut 	:= MsAdvSize() 

Private cPerga	    := "CABA128a"   

Private dVencInc                      
Private dVencFim                     
Private cTipotit                     
Private cTipbaixa    

Private cUsuario:= SubStr(cUSUARIO,7,15)        
//private cDthr   := STR(dtos(DATE()) + "-" + Time())   

private cCompInc := ' '                     
private cCompFim := ' '  

private nfase3    := 0                   
private nfase312  := 0                  
private nfase4    := 0        
private nGerpes   := 3

private cClsRd   := ' ' 

private dDtvenc  := ' '  

Private cDscori  := ' '      

private lsai := .F.    

private cAliasCf  := GetNextAlias()   
private cAliasDem := GetNextAlias()   
private cAliasCT  := GetNextAlias()    
private cAliasEX  := GetNextAlias()   
AjustaSX1()

Pergunte(cPerg,.T.)        

cCompInc := Mv_par01                     
cCompFim := Mv_par02  
                         
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

oDlg  		:= MsDialog():New( aSizeAut[7],00,aSizeAut[3]-100,aSizeAut[5]-10,"Mais de um Titulo Para o a mesmo vencimento",,,.F.,,,,,,.T.,,,.T. ) 

oSayPEG    	:= TSay():New( aPosObj[1][1],aPosObj[1][2],{||'Titulos Reembolso '},oDlg,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,236,016)

bDbClickPEG	:= {|| aBrwPEG[oBrwPEG:nAt,1] := !aBrwPEG[oBrwPEG:nAt,1] , VerifMarc(aBrwPEG[oBrwPEG:nAt,3]) ,oBrwPEG:Refresh()}   

//bChangePEG	:= {||AtuBrwGuia(aBrwPEG[oBrwPEG:nAt,2],aBrwPEG[oBrwPEG:nAt,3])}

//oBrwPEG 	:= TcBrowse():New(aPosObj[1][1]+10,aPosObj[1][2],aPosObj[1][4],aPosObj[1][3],,aCabPEG,aTamPEG,oDlg,,,,bChangePEG,bDbClickPEG,,,,,,,.F.,,.T.,,.F.,,, )

oBrwPEG 	:= TcBrowse():New(aPosObj[1][1]+10,aPosObj[1][2],aPosObj[1][4],aPosObj[1][3],,aCabPEG,aTamPEG,oDlg,,,,,bDbClickPEG,,,,,,,.F.,,.T.,,.F.,,, )

oBrwPEG:SetArray(aBrwPEG) 

oBrwPEG:bLine := {||{If( aBrwPEG[oBrwPEG:nAt,1],oOk,oNo) ,;
                         aBrwPEG[oBrwPEG:nAt,2]		 ,;
                         aBrwPEG[oBrwPEG:nAt,3]      ,;                       
	  	    	 Transform(aBrwPEG[oBrwPEG:nAt, 4],'@E  999,999,999.99')  ,;
		 	     Transform(aBrwPEG[oBrwPEG:nAt, 5],'@E  999,999,999.99')  ,;
		 	     Transform(aBrwPEG[oBrwPEG:nAt, 6],'@E  999,999,999.99')  ,; 
   		 	     Transform(aBrwPEG[oBrwPEG:nAt, 7],'@E  999,999,999.99')  ,; 
   		 	     Transform(aBrwPEG[oBrwPEG:nAt, 8],'@E  999,999,999.99')  ,;    
                 Transform(aBrwPEG[oBrwPEG:nAt, 12],'@E  999,999,999.99')  ,;       		 	     
   		 	     Transform(aBrwPEG[oBrwPEG:nAt, 10],'@E  999,999,999.99')  ,; 
   		 	     Transform(aBrwPEG[oBrwPEG:nAt, 09],'@E  999,999,999.99')  ,;
  	 	         Transform(aBrwPEG[oBrwPEG:nAt, 11],'@E  999,999'       )  }}


oBrwPEG:nScrollType  := 1 // Scroll VCR

lConfirmou 	:= .T.

aBut    :={{"PENDENTE", {||marca(1),oBrwPEG:Refresh()           }	, "Marcar Todos "       , "Marcar Todos"     } }
aAdd(aBut, {"PENDENTE", {||desmarca(1),oBrwPEG:Refresh()        }	, "DesMarcar Todos "	, "DesMarcar Todos"	 } )
aAdd(aBut, {"PENDENTE", {||demost(1),oBrwPEG:Refresh()          }	, "Demostrativo "   	, "Demostrativo"     } )   
aAdd(aBut, {"PENDENTE", {||lsai:= .T. , oDlg:End()              }	, "Sair "   	        , "Sair"             } )  
//aAdd(aBut, {"PENDENTE", {||fConfexc(1),oBrwPEG:Refresh(),oDlg:End()}	, "Excluir Selecção"   	, "Excluir Selecção" } )    
//aAdd(aBut, {"PENDENTE", {||fConfexc(2),oBrwPEG:Refresh(),oDlg:End()}	, "Excl.Tit/Selecao"   	, "Excl.Tit/Selecao" } )

//If lsai 
   
 //  exit
   
//endIf                                                                                                                        

lConfirmou := .F.

bOk 	:= {||demost(2) , oBrwPEG:Refresh()  ,oDlg:End()   }    
 
bCancel := {||lConfirmou := .F.,oDlg:End()}

	
oDlg:Activate(,,,.T.,,,EnchoiceBar(oDlg,bOk,bCancel,,aBut))


//	MsgInfo("Processo finalizado")

//	MsgAlert(Left(cBuffer,len(cBuffer)-1))
	

Return    

//EndDo


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
                  
cQryPEG :=" SELECT /*+FIRST_ROWS INDEX_ASC(BD7 BD70105)*/ " + CRLF
cQryPEG +="         trim(BD6F.BD6_ANOPAG) ||'/'||  trim(BD6F.BD6_MESPAG) COMPENT  ," + CRLF
cQryPEG +="         nvl(OPE.OPEORI,'0000')||' - '|| nvl(OPE.NOMOPE, '') OPEORI ," + CRLF          

cQryPEG +="         sum(decode(nvl(pcs_recbd6,0),0,(decode(trim(BD6F.BD6_FASE),'3',(decode(trim(BD7F.BD7_YFAS35),'F', Bd6_vlrbpf , 0.00)),0.00)),0.00)) FASE3 , " + CRLF
cQryPEG +="         sum(decode(nvl(pcs_recbd6,0),0,(decode(trim(BD6F.BD6_FASE),'3',(decode(trim(BD7F.BD7_YFAS35),'T', Bd6_vlrbpf , 0.00)),0.00)),0.00)) FASE3_1_2 , " + CRLF

cQryPEG +="         sum(decode(nvl(pcs_recbd6,0),0,(decode(trim(BD6F.BD6_NUMFAT),''  ,(decode(trim(BD6F.BD6_FASE),'4', Bd6_vlrbpf , 0.00)),0.00)),0.00)) FASE4 , " + CRLF

cQryPEG +="          nvl(pcs1.inss,0) Inss , " + CRLF 
cQryPEG +="          nvl(pcs1.TxAdm,0) TxAdm , " + CRLF   
cQryPEG +="          nvl(pcs1.FATTIT,0) FATTIT , " + CRLF    
cQryPEG +="          nvl(pcs1.VlrBpf,0) VlrBpf , " + CRLF  

cQryPEG +="         sum(Bd6_vlrbpf) TOT , " + CRLF                                               
cQryPEG +="         COUNT(*) QTDA " + CRLF
 
cQryPEG +="   FROM ( " + CRLF
cQryPEG +="         SELECT '10'||BGH_GRUOPE OPEORI , BA2_DESCRI NOMOPE ,  BGH_VLRTRC VLRCOB " + CRLF 
cQryPEG +="           FROM "+RetSqlName('BGH')+ " BGH  ,"+RetSqlName('BA2')+ " BA2" + CRLF
cQryPEG +="          WHERE BA2_FILIAL = '" + xFilial('BA2') + "' AND BA2.D_E_L_E_T_ = ' ' " + CRLF
cQryPEG +="            AND BGH_FILIAL = '" + xFilial('BGH') + "' AND BGH.D_E_L_E_T_ = ' ' " + CRLF
cQryPEG +="            AND BGH_DATFIN = ' ' AND BA2_GRUOPE = BGH_GRUOPE ) OPE  , ( "  + CRLF
cQryPEG +="    SELECT pcs_opeori      OPEORI, "  + CRLF
cQryPEG +="           sum(pcs_vlrins) Inss , "  + CRLF
cQryPEG +="           sum(pcs_vlrtad) TxAdm , "  + CRLF
cQryPEG +="           sum(pcs_vlrbpf) VlrBpf , "  + CRLF
cQryPEG +="          (sum(pcs_vlrbpf) +  sum(pcs_vlrtad) + sum(pcs_vlrins))FATTIT , "  + CRLF
cQryPEG +="           sum(pcs_vlrbpf + pcs_vlrtad + pcs_vlrins )FATTIT1 "  + CRLF
cQryPEG +="      from "+RetSqlName('PCS')+ " PCS "  + CRLF
cQryPEG +="     where PCS_FILIAL = '" + xFilial('PCS') + "' "  + CRLF
cQryPEG +="       and  d_E_L_E_T_ = ' ' "  + CRLF
cQryPEG +="       and pcs_anopag||pcs_mespag = '"+cCompInc+"' " + CRLF 
cQryPEG +="     group by pcs_opeori ) pcs1 , (" + CRLF
cQryPEG +="         SELECT BD7.BD7_FILIAL,BD7_CODPLA,SIGA_TIPO_EXPOSICAO_ANS(BD7_CODEMP,BD7_MATRIC,BD7_TIPREG,TO_DATE(TRIM(BD7_DATPRO),'YYYYMMDD')) EXPOS, " + CRLF
cQryPEG +="                BD7.BD7_OPELOT, BD7.BD7_YFAS35 , BD7.BD7_FASE , BD7.BD7_NUMLOT ,  BD7.BD7_DATPRO , " + CRLF
cQryPEG +="                BD7.BD7_CODOPE, BD7.BD7_CODLDP, BD7.BD7_CODPEG, BD7.BD7_NUMERO, BD7.BD7_ORIMOV, BD7_CODPRO , " + CRLF
cQryPEG +="                BD7.BD7_SEQUEN,  SUM(BD7.BD7_VLRPAG) AS VLRPAG , BD7.BD7_BLOPAG , BD7.BD7_CODRDA  , bd7.bd7_nomrda , " + CRLF
cQryPEG +="                COUNT(DISTINCT BD7_CODEMP||BD7_MATRIC||BD7_TIPREG) QTDE " + CRLF
cQryPEG +="           FROM "+RetSqlName('BD7')+ " BD7 " + CRLF
cQryPEG +="          WHERE BD7.BD7_FILIAL= '" + xFilial('BD7') + "' " + CRLF
cQryPEG +="                AND BD7.BD7_CODOPE = '0001' " + CRLF
cQryPEG +="                AND BD7.BD7_SITUAC = '1' " + CRLF
cQryPEG +="                AND BD7.BD7_blopag  <> '1' " + CRLF 
cQryPEG +="                AND (BD7.BD7_FASE = '3' or BD7.BD7_FASE  = '4') " + CRLF

cQryPEG +="                AND BD7.BD7_ANOPAG || bd7.bd7_mespag  = '"+cCompInc+"' " + CRLF 
cQryPEG +="                and (bd7.bd7_numlot = ' ' or bd7.bd7_numlot like  '"+cCompInc+"%') " + CRLF

cQryPEG +="                AND BD7.D_E_L_E_T_ = ' ' " + CRLF
cQryPEG +="                AND bd7.bd7_codemp = '0004' " + CRLF

cQryPEG +="                AND bd7.bd7_vlrpag > 0 " + CRLF 
cQryPEG +="              GROUP BY BD7_FILIAL, BD7_CODPLA, BD7.BD7_OPELOT,BD7_CODPRO , bd7.BD7_DATPRO , " + CRLF
cQryPEG +="                    SIGA_TIPO_EXPOSICAO_ANS(BD7_CODEMP,BD7_MATRIC,BD7_TIPREG,TO_DATE(TRIM(BD7_DATPRO),'YYYYMMDD')) ,BD7.BD7_NUMLOT , BD7.BD7_CODRDA , bd7.bd7_nomrda , " + CRLF
cQryPEG +="                    BD7_FILIAL, BD7_CODOPE, BD7_CODLDP, BD7_CODPEG, BD7_NUMERO, BD7_ORIMOV, BD7_SEQUEN, BD7.BD7_YFAS35 , BD7.BD7_FASE ,BD7.BD7_BLOPAG  " + CRLF
cQryPEG +="                    ) BD7F, "+RetSqlName('BD6')+ " BD6F ,"+RetSqlName('BI3')+ " BI3 , "+RetSqlName('ZZT')+ " ZZT , "+RetSqlName('BR8')+ " BR8  , "+RetSqlName('BA1')+ " BA1 ,"+RetSqlName('PCS')+ " PCS" + CRLF
cQryPEG +="  WHERE ZZT_FILIAL='" + xFilial('ZZT') + "' " + CRLF 
cQryPEG +="    AND BI3_FILIAL='" + xFilial('BI3') + "' " + CRLF 
cQryPEG +="    AND BR8_FILIAL='" + xFilial('BR8') + "' " + CRLF     
cQryPEG +="    AND PCS_FILIAL(+)='" + xFilial('PCS') + "' " + CRLF
cQryPEG +="    AND BD6F.BD6_CODPAD=BR8_CODPAD " + CRLF
cQryPEG +="    AND BD6F.BD6_CODPRO=BR8_CODPSA " + CRLF 

cQryPEG +="    AND BD6F.BD6_CODLDP <> '0000' " + CRLF

cQryPEG +="    AND BR8.D_E_L_E_T_=' ' " + CRLF 
cQryPEG +="    AND PCS.D_E_L_E_T_(+)=' ' " + CRLF
cQryPEG +="    AND BD6F.BD6_FILIAL='" + xFilial('BD6') + "' " + CRLF
cQryPEG +="    AND BD7F.BD7_FILIAL = BD6F.BD6_FILIAL " + CRLF
cQryPEG +="    AND BD7F.BD7_CODOPE = BD6F.BD6_CODOPE " + CRLF
cQryPEG +="    AND BD7F.BD7_CODLDP = BD6F.BD6_CODLDP " + CRLF
cQryPEG +="    AND BD7F.BD7_CODPEG = BD6F.BD6_CODPEG " + CRLF
cQryPEG +="    AND BD7F.BD7_NUMERO = BD6F.BD6_NUMERO " + CRLF
cQryPEG +="    AND BD7F.BD7_ORIMOV = BD6F.BD6_ORIMOV " + CRLF
cQryPEG +="    AND BD7F.BD7_SEQUEN = BD6F.BD6_SEQUEN " + CRLF
cQryPEG +="    AND BD6F.BD6_CODPRO = BD7F.BD7_CODPRO " + CRLF        

cQryPEG +="    AND BI3_FILIAL = BD7_FILIAL " + CRLF
cQryPEG +="    AND BI3_CODINT = BD7_CODOPE " + CRLF
cQryPEG +="    AND BI3_CODIGO = BD7_CODPLA " + CRLF               

cQryPEG +="    AND PCS_RECBD6(+) = BD6F.r_e_c_n_o_ " + CRLF
 
cQryPEG +="    AND bd6_vlrpag = bd6_vlrbpf " + CRLF           

cQryPEG +="    AND siga.RETORNA_EVENTO_BD5(BD6_OPEUSR,BD6_CODLDP, BD6_CODPEG,BD6_NUMERO,BD6_ORIMOV,BD6_CODPAD,BD6_CODPRO,'C' ) = ZZT_CODEV " + CRLF
cQryPEG +="    AND BD6F.BD6_OPEORI = OPE.OPEORI(+) " + CRLF  

cQryPEG +="    AND BD6F.BD6_OPEORI = PCS1.OPEORI(+) " + CRLF

//cQryPEG +="    AND BD6F.D_E_L_E_T_ = ' ' and bd6f.bd6_seqpf = ' '  and bd6f.bd6_blocpa <> '1' " + CRLF   -=- verificar a condição de consolidação 
cQryPEG +="    AND BD6F.D_E_L_E_T_ = ' '   and bd6f.bd6_blocpa <> '1' " + CRLF
cQryPEG +="    AND BI3.D_E_L_E_T_ = ' ' " + CRLF
cQryPEG +="    AND ZZT.D_E_L_E_T_ = ' ' " + CRLF
cQryPEG +="    AND BA1.BA1_FILIAL = '" + xFilial('BA1') + "' " + CRLF
cQryPEG +="    AND BA1.D_e_l_e_t_ = ' ' " + CRLF
cQryPEG +="    AND BA1.BA1_CODEMP = BD6F.BD6_CODEMP " + CRLF
cQryPEG +="    AND BA1.BA1_MATRIC = BD6F.BD6_MATRIC " + CRLF
cQryPEG +="    AND BA1.BA1_TIPREG = BD6F.BD6_TIPREG " + CRLF    
 
cQryPEG +="  GROUP BY trim(BD6F.BD6_ANOPAG)  , trim(BD6F.BD6_MESPAG) , " + CRLF
cQryPEG +="        nvl(OPE.OPEORI,'0000') ,  nvl(OPE.NOMOPE, '') ,  " + CRLF 
cQryPEG +="        nvl(pcs1.inss,0)  , " + CRLF 
cQryPEG +="        nvl(pcs1.TxAdm,0) , " + CRLF   
cQryPEG +="        nvl(pcs1.FATTIT,0), " + CRLF    
cQryPEG +="        nvl(pcs1.VlrBpf,0)  " + CRLF  

//cQryPEG +="  ORDER BY 2,1" + CRLF                 
cQryPEG +="union all " + CRLF                
                 

cQryPEG +=" SELECT /*+FIRST_ROWS INDEX_ASC(BD7 BD70105)*/ " + CRLF
cQryPEG +="         trim(BD6F.BD6_ANOPAG) ||'/'||  trim(BD6F.BD6_MESPAG) COMPENT  ," + CRLF
cQryPEG +="         '9999'||' - '|| '    ----> T O T A I S <---- ' OPEORI ," + CRLF          

cQryPEG +="         sum(decode(nvl(pcs_recbd6,0),0,(decode(trim(BD6F.BD6_FASE),'3',(decode(trim(BD7F.BD7_YFAS35),'F', Bd6_vlrbpf , 0.00)),0.00)),0.00)) FASE3 , " + CRLF
cQryPEG +="         sum(decode(nvl(pcs_recbd6,0),0,(decode(trim(BD6F.BD6_FASE),'3',(decode(trim(BD7F.BD7_YFAS35),'T', Bd6_vlrbpf , 0.00)),0.00)),0.00)) FASE3_1_2 , " + CRLF

//cQryPEG +="       sum(decode(nvl(pcs_recbd6,0),0,(decode(trim(BD6F.BD6_FASE),'4', Bd6_vlrbpf , 0.00)),0.00)) FASE4 , " + CRLF         

cQryPEG +="         sum(decode(nvl(pcs_recbd6,0),0,(decode(trim(BD6F.BD6_NUMFAT),''  ,(decode(trim(BD6F.BD6_FASE),'4', Bd6_vlrbpf , 0.00)),0.00)),0.00)) FASE4 , " + CRLF

cQryPEG +="         nvl(pcs1.inss,0)   Inss , " + CRLF 
cQryPEG +="         nvl(pcs1.TxAdm,0)  TxAdm , " + CRLF   
cQryPEG +="         nvl(pcs1.FATTIT,0) FATTIT , " + CRLF    
cQryPEG +="         nvl(pcs1.VlrBpf,0) VlrBpf , " + CRLF  

cQryPEG +="         sum(Bd6_vlrbpf) TOT, " + CRLF                                               
cQryPEG +="         COUNT(*) QTDA " + CRLF  


 
cQryPEG +="   FROM ( " + CRLF       

cQryPEG +="    SELECT "  + CRLF
cQryPEG +="           sum(pcs_vlrins) Inss , "  + CRLF
cQryPEG +="           sum(pcs_vlrtad) TxAdm , "  + CRLF
cQryPEG +="           sum(pcs_vlrbpf) VlrBpf , "  + CRLF
cQryPEG +="          (sum(pcs_vlrbpf) +  sum(pcs_vlrtad) + sum(pcs_vlrins))FATTIT , "  + CRLF
cQryPEG +="           sum(pcs_vlrbpf + pcs_vlrtad + pcs_vlrins )FATTIT1 "  + CRLF
cQryPEG +="      from "+RetSqlName('PCS')+ " PCS "  + CRLF
cQryPEG +="     where PCS_FILIAL = '" + xFilial('PCS') + "' "  + CRLF
cQryPEG +="       and  d_E_L_E_T_ = ' ' "  + CRLF
cQryPEG +="       and pcs_anopag||pcs_mespag = '"+cCompInc+"' " + CRLF 
cQryPEG +="     ) pcs1 , (" + CRLF



cQryPEG +="         SELECT BD7.BD7_FILIAL,BD7_CODPLA,SIGA_TIPO_EXPOSICAO_ANS(BD7_CODEMP,BD7_MATRIC,BD7_TIPREG,TO_DATE(TRIM(BD7_DATPRO),'YYYYMMDD')) EXPOS, " + CRLF
cQryPEG +="                BD7.BD7_OPELOT, BD7.BD7_YFAS35 , BD7.BD7_FASE , BD7.BD7_NUMLOT ,  BD7.BD7_DATPRO , " + CRLF
cQryPEG +="                BD7.BD7_CODOPE, BD7.BD7_CODLDP, BD7.BD7_CODPEG, BD7.BD7_NUMERO, BD7.BD7_ORIMOV, BD7_CODPRO , " + CRLF
cQryPEG +="                BD7.BD7_SEQUEN,  SUM(BD7.BD7_VLRPAG) AS VLRPAG , BD7.BD7_BLOPAG , BD7.BD7_CODRDA  , bd7.bd7_nomrda , " + CRLF
cQryPEG +="                COUNT(DISTINCT BD7_CODEMP||BD7_MATRIC||BD7_TIPREG) QTDE " + CRLF
cQryPEG +="           FROM "+RetSqlName('BD7')+ " BD7 " + CRLF
cQryPEG +="          WHERE BD7.BD7_FILIAL= '" + xFilial('BD7') + "' " + CRLF
cQryPEG +="                AND BD7.BD7_CODOPE = '0001' " + CRLF
cQryPEG +="                AND BD7.BD7_SITUAC = '1' " + CRLF
cQryPEG +="                AND BD7.BD7_blopag  <> '1' " + CRLF 
cQryPEG +="                AND (BD7.BD7_FASE = '3' or BD7.BD7_FASE  = '4') " + CRLF

cQryPEG +="                AND BD7.BD7_ANOPAG || bd7.bd7_mespag  = '"+cCompInc+"' " + CRLF 
//cQryPEG +="                AND BD7.BD7_ANOPAG || bd7.bd7_mespag  <= '"+cCompFim+"' " + CRLF
cQryPEG +="                and (bd7.bd7_numlot = ' ' or bd7.bd7_numlot like  '"+cCompInc+"%') " + CRLF

cQryPEG +="                AND BD7.D_E_L_E_T_ = ' ' " + CRLF
cQryPEG +="                AND bd7.bd7_codemp = '0004' " + CRLF

cQryPEG +="                AND bd7.bd7_vlrpag > 0 " + CRLF 
cQryPEG +="              GROUP BY BD7_FILIAL, BD7_CODPLA, BD7.BD7_OPELOT,BD7_CODPRO , bd7.BD7_DATPRO , " + CRLF
cQryPEG +="                    SIGA_TIPO_EXPOSICAO_ANS(BD7_CODEMP,BD7_MATRIC,BD7_TIPREG,TO_DATE(TRIM(BD7_DATPRO),'YYYYMMDD')) ,BD7.BD7_NUMLOT , BD7.BD7_CODRDA , bd7.bd7_nomrda , " + CRLF
cQryPEG +="                    BD7_FILIAL, BD7_CODOPE, BD7_CODLDP, BD7_CODPEG, BD7_NUMERO, BD7_ORIMOV, BD7_SEQUEN, BD7.BD7_YFAS35 , BD7.BD7_FASE ,BD7.BD7_BLOPAG  " + CRLF
cQryPEG +="                    ) BD7F, "+RetSqlName('BD6')+ " BD6F ,"+RetSqlName('BI3')+ " BI3 , "+RetSqlName('ZZT')+ " ZZT , "+RetSqlName('BR8')+ " BR8  , "+RetSqlName('BA1')+ " BA1 ,"+RetSqlName('PCS')+ " PCS" + CRLF
cQryPEG +="  WHERE ZZT_FILIAL='" + xFilial('ZZT') + "' " + CRLF 
cQryPEG +="    AND BI3_FILIAL='" + xFilial('BI3') + "' " + CRLF 
cQryPEG +="    AND BR8_FILIAL='" + xFilial('BR8') + "' " + CRLF     
cQryPEG +="    AND PCS_FILIAL(+)='" + xFilial('PCS') + "' " + CRLF
cQryPEG +="    AND BD6F.BD6_CODPAD=BR8_CODPAD " + CRLF
cQryPEG +="    AND BD6F.BD6_CODPRO=BR8_CODPSA " + CRLF 

cQryPEG +="    AND BD6F.BD6_CODLDP <> '0000' " + CRLF

cQryPEG +="    AND BR8.D_E_L_E_T_=' ' " + CRLF 
cQryPEG +="    AND PCS.D_E_L_E_T_(+)=' ' " + CRLF
cQryPEG +="    AND BD6F.BD6_FILIAL='" + xFilial('BD6') + "' " + CRLF
cQryPEG +="    AND BD7F.BD7_FILIAL = BD6F.BD6_FILIAL " + CRLF
cQryPEG +="    AND BD7F.BD7_CODOPE = BD6F.BD6_CODOPE " + CRLF
cQryPEG +="    AND BD7F.BD7_CODLDP = BD6F.BD6_CODLDP " + CRLF
cQryPEG +="    AND BD7F.BD7_CODPEG = BD6F.BD6_CODPEG " + CRLF
cQryPEG +="    AND BD7F.BD7_NUMERO = BD6F.BD6_NUMERO " + CRLF
cQryPEG +="    AND BD7F.BD7_ORIMOV = BD6F.BD6_ORIMOV " + CRLF
cQryPEG +="    AND BD7F.BD7_SEQUEN = BD6F.BD6_SEQUEN " + CRLF
cQryPEG +="    AND BD6F.BD6_CODPRO = BD7F.BD7_CODPRO " + CRLF        

cQryPEG +="    AND BI3_FILIAL = BD7_FILIAL " + CRLF
cQryPEG +="    AND BI3_CODINT = BD7_CODOPE " + CRLF
cQryPEG +="    AND BI3_CODIGO = BD7_CODPLA " + CRLF               

cQryPEG +="    AND PCS_RECBD6(+) = BD6F.r_e_c_n_o_ " + CRLF
 
cQryPEG +="    AND bd6_vlrpag = bd6_vlrbpf " + CRLF           

cQryPEG +="    AND siga.RETORNA_EVENTO_BD5(BD6_OPEUSR,BD6_CODLDP, BD6_CODPEG,BD6_NUMERO,BD6_ORIMOV,BD6_CODPAD,BD6_CODPRO,'C' ) = ZZT_CODEV " + CRLF
//cQryPEG +="    AND BD6F.D_E_L_E_T_ = ' ' and bd6f.bd6_seqpf = ' '  and bd6f.bd6_blocpa <> '1' " + CRLF   -=- verificar a condição de consolidação 
cQryPEG +="    AND BD6F.D_E_L_E_T_ = ' '   and bd6f.bd6_blocpa <> '1' " + CRLF
cQryPEG +="    AND BI3.D_E_L_E_T_ = ' ' " + CRLF
cQryPEG +="    AND ZZT.D_E_L_E_T_ = ' ' " + CRLF
cQryPEG +="    AND BA1.BA1_FILIAL = '" + xFilial('BA1') + "' " + CRLF
cQryPEG +="    AND BA1.D_e_l_e_t_ = ' ' " + CRLF
cQryPEG +="    AND BA1.BA1_CODEMP = BD6F.BD6_CODEMP " + CRLF
cQryPEG +="    AND BA1.BA1_MATRIC = BD6F.BD6_MATRIC " + CRLF
cQryPEG +="    AND BA1.BA1_TIPREG = BD6F.BD6_TIPREG " + CRLF    
 
cQryPEG +="  GROUP BY trim(BD6F.BD6_ANOPAG)  , trim(BD6F.BD6_MESPAG) , " + CRLF

cQryPEG +="         nvl(pcs1.inss,0)    , " + CRLF 
cQryPEG +="         nvl(pcs1.TxAdm,0)   , " + CRLF   
cQryPEG +="         nvl(pcs1.FATTIT,0)  , " + CRLF    
cQryPEG +="         nvl(pcs1.VlrBpf,0)    " + CRLF  
cQryPEG +="  ORDER BY 2,1" + CRLF   

                                      
                        
TcQuery cQryPEG New Alias cAliasPEG       
 

While !cAliasPEG->(EOF())
                                    
	aAdd(aRetPEG,{.F. , cAliasPEG->COMPENT , cAliasPEG->OPEORI , cAliasPEG->FASE3 , cAliasPEG->FASE3_1_2 , cAliasPEG->FASE4 , cAliasPEG->Inss, cAliasPEG->TxAdm ,cAliasPEG->FATTIT , cAliasPEG->TOT , cAliasPEG->QTDA , cAliasPEG->VlrBpf})
                //   1      2    				3					4					5					6					7					8				9						10				11	                  12                  
	cAliasPEG->(DbSkip())

EndDo
  
cAliasPEG->(DbCloseArea())

If empty(aRetPEG)
	aAdd(aRetPEG,{.T.,'','','','','','','','','','',''})
EndIf

Return aRetPEG

/********************************************/
/********************************************/
Static Function demost( cRefExe1 )
 
 local nI    
 local I :=0   
 local cRef := ' ' 
 private  cRefExe := cRefExe1
 
     If cRefExe==2                     
         AjustaSX1a()

         Pergunte(cPerga,.T.)          

          nfase3   := Mv_par01                     
          nfase312 := Mv_par02                    
          nfase4   := Mv_par03                   
          cClsRd   := Mv_par04
     
          dDtvenc  := Mv_par05          
          nGerTx   := Mv_par06
          nGerInss := Mv_par07    
          nGerPes  := Mv_par08
     
        MsgAlert("DESMARQUE os procedimentos que NÃO deseja Cobrar ","Atencao!")
        
     EndIf 
     For I:= 1 to Len(aBrwPEG)        
     
	
		   If aBrwPEG[I,1]== .T.  .and.(aBrwPEG[I,4] > 0 .or. aBrwPEG[I,5] > 0 .or. aBrwPEG[I,6] > 0)
	   		
	   		  cRef:=Substr(aBrwPEG[I,3],1,4)
    
              Processa({||aBrwDem := aDadosDem( cRef )},'Processando Demonstrativo ...','buscando dados no servido ...',.T.)
      
              oDlg1  		:= MsDialog():New( aSizeAut[7]-30,00,aSizeAut[3]-250,aSizeAut[5]-70,"Composição do Pagamento ",,,.F.,,,,,,.T.,,,.T. ) 

              oSayDem    	:= TSay():New( aPosObj[1][1],aPosObj[1][2],{||'Composição do pagto  '},oDlg1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,236,016)
         
              bDbClickDem	:= {|| aBrwDem[oBrwDem:nAt,1] := !aBrwDem[oBrwDem:nAt,1], oBrwDem:Refresh()}   

         //oBrwDem 	    := TcBrowse():New(aPosObj[1][1]+10,aPosObj[1][2],aPosObj[1][4],aPosObj[1][3]-50,,aCabdem,aTamdem,oDlg1,,,,,,,,,,,,.F.,,.T.,,.F.,,, )
              oBrwDem 	    := TcBrowse():New(5,5,610,190,,aCabdem,aTamdem,oDlg1,,,,,bDbClickDem,,,,,,,.F.,,.T.,,.F.,,, )
        //oBrwDem 	    := TcBrowse():New(aPosObj[1][1]+10,aPosObj[1][2],aPosObj[1][4],aPosObj[1][3],,aCabdem,aTamdem,oDlg,,,,,bDbClickPEG,,,,,,,.F.,,.T.,,.F.,,, )

              oBrwDem:SetArray(aBrwDem)             
              
         
              oBrwDem:bLine  := {||{If(aBrwDem[oBrwDem:nAt,1],oOk,oNo)        ,;
                                    AllTrim(aBrwDem[oBrwDem:nAt,2])	    	  ,;									
									AllTrim(aBrwDem[oBrwDem:nAt,3])	   		  ,;
   								    AllTrim(aBrwDem[oBrwDem:nAt,4])	    	  ,;
								    Alltrim(aBrwDem[oBrwDem:nAt,5])		      ,;
                                    Alltrim(aBrwDem[oBrwDem:nAt,6])	    	  ,;
                                    Alltrim(aBrwDem[oBrwDem:nAt,7])			  ,;
                                    Alltrim(aBrwDem[oBrwDem:nAt,8]) 	      ,;
                                    Alltrim(aBrwDem[oBrwDem:nAt,9])           ,;
                                    Alltrim(aBrwDem[oBrwDem:nAt,10]) 	      ,;
                                    Alltrim(aBrwDem[oBrwDem:nAt,11])          ,;
                                    Transform(aBrwDem[oBrwDem:nAt,12],'@E  999,999.99'),;   
                                    Transform(aBrwDem[oBrwDem:nAt,13],'@E  999')+'%',;      
 									Transform(aBrwDem[oBrwDem:nAt,14],'@E  999,999.99'),;                                    
						            Transform(aBrwDem[oBrwDem:nAt,15],'@E  999,999.99') ,;
						            aBrwDem[oBrwDem:nAt,16] ,; 
						            stod(aBrwDem[oBrwDem:nAt,17]) ,;
						            stod(aBrwDem[oBrwDem:nAt,18]) ,;
						            stod(aBrwDem[oBrwDem:nAt,19]) ,;
						            aBrwDem[oBrwDem:nAt,20]       ,;
									aBrwDem[oBrwDem:nAt,21] ,;
						            aBrwDem[oBrwDem:nAt,22] }}
						
			  oBrwDem:nScrollType  := 1 // Scroll VCR
			  
 		     aBut1    :={{"PENDENTE", {||marca(2),oBrwDem:Refresh()             }	, "Marcar Todos "    , "Marcar Todos"     } }
			 aAdd(aBut1, {"PENDENTE", {||desmarca(2),oBrwDem:Refresh()          }	, "DesMarcar Todos " , "DesMarcar Todos"  } )
//			 aAdd(aBut1, {"PENDENTE", {||demlin(),desmarcalin(),oBrwDem:Refresh() }	, "Demost. Linha "   , "Demost. Linha "   } )

//  	      bOk 	  := {||iif(cRefExe==2, fGeratit(), lsai := .F. )}
              bOk 	  := {||iif(cRefExe==2,(fGeratit(), oDlg1:End()), oDlg1:End()) }
          bCancel := {|| oDlg1:End()}                          
     //     if Lsai 
     //        exit
     //     EndIf   

       oDlg1:Activate(,,,.T.,,,EnchoiceBar(oDlg1,bOk,bCancel,,aBut1)) 
//          oDlg1:Activate(,,,.T.,,,EnchoiceBar(oDlg1,bOk,bCancel,,))
        EndIf 
   Next
  If empty(cRef) 
  	 
  	 MsgAlert("Não a dados para esta consulta","Atencao!")	    

   //  aAdd(aBrwDem,{'','','','','','','',' ',' ',' ',' ',0.00 ,0 ,0.00 , 0.00 , 0,'' ,'' , '', '', '', ' '  })  
  	       
  EndIf 		
RETURN()	


/********************************************/
Static Function aDadosDem(cRef)

Local aRetDem	  := {}
Local cQryDem	  := " "


local i

ProcRegua(0) 

nCont := 0

for i:=1 to 5
    IncProc('Buscando Dados no Servidor ...')       
next                                                
		cQryDem :=" SELECT /*+FIRST_ROWS INDEX_ASC(BD7 BD70105)*/ " + CRLF 
		cQryDem +=" distinct trim(BD6F.BD6_ANOPAG)||'/'|| trim(BD6F.BD6_MESPAG) AnoMes , " + CRLF 
 		cQryDem +="        nvl(OPE.OPEORI,'0000') ||' - '|| nvl(OPE.NOMOPE, '')  OPEORI , " + CRLF     
 		cQryDem +="        decode(trim(BD7F.BD7_FASE),'4','4-Fat','1','1-Dig','2','2-Conf','3',(decode(trim(BD7F.BD7_YFAS35),'T','31/2','3-Prt')),  'NAO PRONTA') fase ," + CRLF  
  		cQryDem +="        trim(BD6F.BD6_CODEMP) codemp , " + CRLF 
  
  		cQryDem +="        trim(BD6F.BD6_CODLDP) codldp , " + CRLF 
  		cQryDem +="        trim(BD6F.BD6_CODPEG) codpeg , " + CRLF 
  		cQryDem +="        trim(BD6F.BD6_NUMERO) numero , " + CRLF 
  		cQryDem +="        trim(BD6F.BD6_ORIMOV) orimov , " + CRLF 
  		cQryDem +="        trim(BD6F.BD6_SEQUEN) sequen , " + CRLF 
  		cQryDem +="        trim(DECODE(BD6_CODLDP,'0010','RECUP GLOSA','0017','RATEIO','CONTA')) tipo , " + CRLF 
  		cQryDem +="        BD7F.VLRPAG  VlrAprov , " + CRLF 
        cQryDem +="        BD6F.BD6_PERTAD PRECTX , " + CRLF   		
  		cQryDem +="        BD6F.BD6_VLRTAD VlrTx  , " + CRLF        
  		cQryDem +="        BD6F.BD6_VLRTPF VlrTpf , " + CRLF       
  		cQryDem +="        BD6F.r_e_c_n_o_ REC , " + CRLF           
  		cQryDem +="        BD6F.BD6_DATPRO DatPro , " + CRLF         
  		cQryDem +="        BA1.BA1_DATBLO  DatBlo , " + CRLF        
  		cQryDem +="        BA1.BA1_DATINC  DatInc , " + CRLF       
  		
  		cQryDem +="        BAU.BAU_TIPPRE  ClsRd  , " + CRLF  
  		cQryDem +="        BAU.BAU_codigo  CODRda , " + CRLF   	  
  		cQryDem +="        BAU.BAU_tippe   Tippe   " + CRLF     			  		

  		cQryDem +="   FROM ( " + CRLF
  		cQryDem +="        SELECT '10'||BGH_GRUOPE OPEORI , BA2_DESCRI NOMOPE ,  BGH_VLRTRC VLRCOB " + CRLF 
  		cQryDem +="          FROM "+RetSqlName('BGH')+ " BGH  ,"+RetSqlName('BA2')+ " BA2" + CRLF
  		cQryDem +="         WHERE BA2_FILIAL = '" + xFilial('BA2') + "' AND BA2.D_E_L_E_T_ = ' ' " + CRLF
  		cQryDem +="           AND BGH_FILIAL = '" + xFilial('BGH') + "' AND BGH.D_E_L_E_T_ = ' ' " + CRLF
  		cQryDem +="           AND BGH_DATFIN = ' ' AND BA2_GRUOPE = BGH_GRUOPE ) OPE  , (" + CRLF
  		cQryDem +="        SELECT BD7.BD7_FILIAL,BD7_CODPLA,SIGA_TIPO_EXPOSICAO_ANS(BD7_CODEMP,BD7_MATRIC,BD7_TIPREG,TO_DATE(TRIM(BD7_DATPRO),'YYYYMMDD')) EXPOS, " + CRLF
  		cQryDem +="               BD7.BD7_OPELOT, BD7.BD7_YFAS35 , BD7.BD7_FASE , BD7.BD7_NUMLOT ,  BD7.BD7_DATPRO , " + CRLF
  		cQryDem +="               BD7.BD7_CODOPE, BD7.BD7_CODLDP, BD7.BD7_CODPEG, BD7.BD7_NUMERO, BD7.BD7_ORIMOV, BD7_CODPRO , " + CRLF
  		cQryDem +="               BD7.BD7_SEQUEN,  SUM(BD7.BD7_VLRPAG) AS VLRPAG , BD7.BD7_BLOPAG , BD7.BD7_CODRDA  , bd7.bd7_nomrda , " + CRLF
  		cQryDem +="               COUNT(DISTINCT BD7_CODEMP||BD7_MATRIC||BD7_TIPREG) QTDE " + CRLF
  		cQryDem +="          FROM "+RetSqlName('BD7')+ " BD7 " + CRLF
  		cQryDem +="         WHERE BD7.BD7_FILIAL= '" + xFilial('BD7') + "' " + CRLF
  		cQryDem +="           AND BD7.BD7_CODOPE = '0001' " + CRLF
  		cQryDem +="           AND BD7.BD7_SITUAC = '1' " + CRLF
  		cQryDem +="           AND BD7.BD7_blopag  <> '1' " + CRLF 

        cQryDem +="           AND BD7.BD7_FASE >= '3' " + CRLF
             	       
           If nfase3 == 1 
       	      cQryDem +="           AND ((BD7.BD7_FASE = '3' and bd7_YFAS35 = 'F')  " + CRLF            
  		   EndIf   
  		                                                                                                 
  		   If nfase312 == 1 .and. nfase3 == 1
  		      cQryDem +="           or (BD7.BD7_FASE = '3' and bd7_YFAS35 = 'T' ) " + CRLF            
  		   ElseIf nfase312 == 1 .and. nfase3 != 1
  		      cQryDem +="           And ((BD7.BD7_FASE = '3' and bd7_YFAS35 = 'T' ) " + CRLF            
  		   EndIf  
  		
  		   If nfase4 == 1 .and. ( nfase312 == 1 .or. nfase3 == 1) 
  		      cQryDem +="           or ( BD7.BD7_FASE = '4') " + CRLF            
  		   ElseIf nfase4 == 1 .and. ( nfase312 != 1 .or. nfase3 != 1)              
  		      cQryDem +="           and  (( BD7.BD7_FASE = '4') " + CRLF           
  		   EndIf  
  		   
  		  If (nfase4 == 1 .or. nfase312 == 1 .or. nfase3 == 1) 
   
  		   cQryDem +="  ) " + CRLF
  		   
        EndIf            

  		cQryDem +="           AND BD7.BD7_ANOPAG || bd7.bd7_mespag = '"+cCompInc+"' " + CRLF 
  		cQryDem +="           AND (bd7.bd7_numlot = ' ' or bd7.bd7_numlot like  '"+cCompInc+"%') " + CRLF

  		cQryDem +="           AND BD7.D_E_L_E_T_ = ' ' " + CRLF
  		cQryDem +="           AND bd7.bd7_codemp = '0004' " + CRLF

  		cQryDem +="           AND bd7.bd7_vlrpag > 0 " + CRLF 
  		cQryDem +="         GROUP BY BD7_FILIAL, BD7_CODPLA, BD7.BD7_OPELOT,BD7_CODPRO , bd7.BD7_DATPRO , " + CRLF
  		cQryDem +="               SIGA_TIPO_EXPOSICAO_ANS(BD7_CODEMP,BD7_MATRIC,BD7_TIPREG,TO_DATE(TRIM(BD7_DATPRO),'YYYYMMDD')) ,BD7.BD7_NUMLOT , BD7.BD7_CODRDA , bd7.bd7_nomrda , " + CRLF
  		cQryDem +="               BD7_FILIAL, BD7_CODOPE, BD7_CODLDP, BD7_CODPEG, BD7_NUMERO, BD7_ORIMOV, BD7_SEQUEN, BD7.BD7_YFAS35 , BD7.BD7_FASE ,BD7.BD7_BLOPAG  " + CRLF
  		cQryDem +="             ) BD7F, "+RetSqlName('BD6')+ " BD6F ,"+RetSqlName('BI3')+ " BI3 , "+RetSqlName('ZZT')+ " ZZT , "+RetSqlName('BR8')+ " BR8  , "+RetSqlName('BA1')+ " BA1 , " + CRLF 
  		
  		cQryDem +="               "+RetSqlName('BAU')+ " BAU " + CRLF 
  		
  		cQryDem +="  WHERE ZZT_FILIAL='" + xFilial('ZZT') + "' " + CRLF 
  		cQryDem +="    AND BI3_FILIAL='" + xFilial('BI3') + "' " + CRLF 
  		cQryDem +="    AND BR8_FILIAL='" + xFilial('BR8') + "' " + CRLF 
  		
  		cQryDem +="    AND BAU_FILIAL='" + xFilial('BAU') + "' " + CRLF
  		
  		cQryDem +="    AND BD6F.BD6_CODPAD=BR8_CODPAD " + CRLF
  		cQryDem +="    AND BD6F.BD6_CODPRO=BR8_CODPSA " + CRLF
  		                                               
  		cQryDem +="    AND BAU.D_E_L_E_T_=' '  AND BAU.R_E_C_D_E_L_ = 0 " + CRLF
        
        cQryDem +="    and bau.bau_codigo = bd6f.bd6_codrda " + CRLF
        
  		cQryDem +="    AND BR8.D_E_L_E_T_=' ' " + CRLF 
  		cQryDem +="    AND BD6F.BD6_FILIAL='" + xFilial('BD6') + "' " + CRLF    
  		
  		If nGerPes == 1 
           cQryDem +="           AND BAU.BAU_tippe = 'F'   " + CRLF 
        ElseIf nGerPes == 2 
           cQryDem +="           AND BAU.BAU_tippe = 'J'   " + CRLF   	    
        EndIf 
  		
   		cQryDem +="    AND NOT EXISTS ( SELECT * FROM siga.PCS010 PCS WHERE PCS_FILIAL = ' ' AND PCS.D_e_l_e_t_ = ' ' AND PCS_RECBD6 = BD6F.r_e_c_n_o_ ) " + CRLF
  		cQryDem +="    AND BD6F.bd6_vlrpag = BD6F.bd6_vlrbpf "  		
  		cQryDem +="    AND BD7F.BD7_FILIAL = BD6F.BD6_FILIAL " + CRLF
  		cQryDem +="    AND BD7F.BD7_CODOPE = BD6F.BD6_CODOPE " + CRLF
  		cQryDem +="    AND BD7F.BD7_CODLDP = BD6F.BD6_CODLDP " + CRLF
  		cQryDem +="    AND BD7F.BD7_CODPEG = BD6F.BD6_CODPEG " + CRLF
  		cQryDem +="    AND BD7F.BD7_NUMERO = BD6F.BD6_NUMERO " + CRLF
  		cQryDem +="    AND BD7F.BD7_ORIMOV = BD6F.BD6_ORIMOV " + CRLF
  		cQryDem +="    AND BD7F.BD7_SEQUEN = BD6F.BD6_SEQUEN " + CRLF
  		cQryDem +="    AND BD6F.BD6_CODPRO = BD7F.BD7_CODPRO " + CRLF
  		cQryDem +="    AND BI3_FILIAL = BD7_FILIAL " + CRLF
  		cQryDem +="    AND BI3_CODINT = BD7_CODOPE " + CRLF
  		cQryDem +="    AND BI3_CODIGO = BD7_CODPLA " + CRLF
  		cQryDem +="    AND siga.RETORNA_EVENTO_BD5(BD6_OPEUSR,BD6_CODLDP, BD6_CODPEG,BD6_NUMERO,BD6_ORIMOV,BD6_CODPAD,BD6_CODPRO,'C' ) = ZZT_CODEV " + CRLF
  		cQryDem +="    AND BD6F.BD6_OPEORI = OPE.OPEORI(+) " + CRLF  
  		cQryDem +="    AND BD6F.bd6_numfat = '            '   " + CRLF           
//  		cQryDem +="    AND BD6F.D_E_L_E_T_ = ' ' and bd6f.bd6_seqpf = ' '  and bd6f.bd6_blocpa <> '1' " + CRLF -- verificar seqpf
  		cQryDem +="    AND BD6F.D_E_L_E_T_ = ' '  and bd6f.bd6_blocpa <> '1' " + CRLF  		
  		cQryDem +="    AND BI3.D_E_L_E_T_ = ' ' " + CRLF
  		cQryDem +="    AND ZZT.D_E_L_E_T_ = ' ' " + CRLF
  		cQryDem +="    AND BA1.BA1_FILIAL = '" + xFilial('BA1') + "' " + CRLF
  		cQryDem +="    AND BA1.D_e_l_e_t_ = ' ' " + CRLF
  		cQryDem +="    AND BA1.BA1_CODEMP = BD6F.BD6_CODEMP " + CRLF
  		cQryDem +="    AND BA1.BA1_MATRIC = BD6F.BD6_MATRIC " + CRLF
  		cQryDem +="    AND BA1.BA1_TIPREG = BD6F.BD6_TIPREG " + CRLF      

  		cQryDem +="    AND BD6F.BD6_CODLDP <> '0000' " + CRLF
  		
  	   If !Empty(cClsRd)
  	   
  		  cQryDem += " and bau_tippre in "+FormatIn(cClsRd, ",")
  	   
  	   EndIf 	                                
	
	    cQryDem +="    AND BD6F.BD6_OPEORI = '"+cRef+"'"  		
   
  		cQryDem +="    ORDER BY 2,1" + CRLF
		
		TcQuery cQryDem New Alias cAliasDem
		
		While !cAliasDem->(EOF())
			                                                                                			
	 		aAdd(aRetDem,{ .T. , cAliasDem->AnoMes , cAliasDem->OPEORI, cAliasDem->fase , cAliasDem->codemp , cAliasDem->codldp , cAliasDem->codpeg , cAliasDem->numero , cAliasDem->orimov , cAliasDem->sequen , cAliasDem->tipo , cAliasDem->VlrAprov ,  cAliasDem->PRECTX ,  cAliasDem->VlrTx  , cAliasDem->VlrTpf  , cAliasDem->rec ,  cAliasDem->DatPro , cAliasDem->DatBlo , cAliasDem->DatInc , cAliasDem->ClsRd, cAliasDem->CodRda, cAliasDem->Tippe})  
				
			cAliasDem->(DbSkip())
			
		EndDo

  	   cAliasDem->(DbCloseArea())

       If empty(aRetDem)    
       
         	 MsgAlert("Não a dados para esta consulta","Atencao!")

		   aAdd(aRetDem,{'','','','','','','',' ',' ',' ',' ',0.00 ,0 ,0.00 , 0.00 , 0,'' ,'' , '', '', '', ' '  })  
		                
       EndIf
   
//Next
Return aRetDem             
                
	***********************************************************************************
Static Function marca(cRef) // cRef == 1 peg , 2 , proc
	
 local nI            
       
	If cRef	== 1

		For nI := 1 to len(aBrwPEG)     
		 
		    If  SUBSTR(aBrwPEG[nI,3],1,4)!='0000' .and. SUBSTR(aBrwPEG[nI,3],1,4)!='9999' 
	
		       aBrwPEG[nI,1]:= .T.
      
            EndIf	
            		
		Next     

	Else 	     
	    
	    For nI := 1 to len(aBrwDem)
	                                   
	        aBrwDem[nI,1]:= .T.
		        			
		Next     
	
	EndIf 
		
		
RETURN()

Static Function VerifMarc()	

local nI                            

For nI := 1 to len(aBrwPEG)     
		 
		    If  SUBSTR(aBrwPEG[nI,3],1,4)=='0000' .or. SUBSTR(aBrwPEG[nI,3],1,4)=='9999' 
	
		       aBrwPEG[nI,1]:= .F.
      
            EndIf	
            		
		Next     
		
Return()	

Static Function desmarca(cRef) // cRef == 1 peg , 2 , proc
	
       local nI

	   If cRef	== 1
			
	      For nI := 1 to len(aBrwPEG)
	
			   aBrwPEG[nI,1]:= .F.
			   
	      Next
	      
	   Else   
	   
	      For nI := 1 to len(aBrwDem)
	
			   aBrwDem[nI,1]:= .F.
			   
	      Next
	   
	   EndIf 

RETURN()	                                   

Static Function fGeratit()


local nI:= 0         
local vlrbse := 0 
local vlrtaxa:= 0  
local vlrinss:= 0
local vlrTot := 0      
local cOpeOri:= ' ' 

           
local cCont  := 0    

Begin Transaction
	 
For nI := 1 to len(aBrwDem)
	
    If (aBrwDem[nI,1] == .T. .AND. fConflanc(aBrwDem[nI,16]) .AND. ; // u_fVrecBd6(aBrwDem[nI,16]) .AND.;
       (aBrwDem[nI,17]>= aBrwDem[nI,19]) .AND. (empty(aBrwDem[nI,18]) .OR. (aBrwDem[nI,17]<= aBrwDem[nI,18])))         
      
       DbSelectArea("BD6")	
      
       DbGoto(aBrwDem[nI,16])

/***********************************************************************************/
       RecLock("PCS",.T.)

        PCS_FILIAL   := BD6->BD6_FILIAL 
		PCS_OPEUSR   := BD6->BD6_OPEUSR 
		PCS_CODEMP   := BD6->BD6_CODEMP  
		PCS_MATRIC   := BD6->BD6_MATRIC 
		PCS_TIPREG   := BD6->BD6_TIPREG  
		PCS_CODOPE   := BD6->BD6_CODOPE  
		PCS_CODLDP   := BD6->BD6_CODLDP  
		PCS_CODPEG   := BD6->BD6_CODPEG  
		PCS_NUMERO   := BD6->BD6_NUMERO 
		PCS_SEQUEN   := BD6->BD6_SEQUEN  
		PCS_CODPAD   := BD6->BD6_CODPAD  
		PCS_CODPRO   := BD6->BD6_CODPRO 
		PCS_QTDPRO   := BD6->BD6_QTDPRO  
		PCS_VLRAPR   := BD6->BD6_VLRAPR   
		PCS_VLRMAN   := BD6->BD6_VLRMAN   
		PCS_VLRGLO   := BD6->BD6_VLRGLO   
		PCS_VLRPAG   := BD6->BD6_VLRPAG   
		PCS_VLRBPF   := BD6->BD6_VLRBPF   
		PCS_VLRPF    := BD6->BD6_VLRPF  
		PCS_VLRTPF   := BD6->BD6_VLRTPF   
		PCS_BLOCPA   := BD6->BD6_BLOCPA
		PCS_DESBPF   := BD6->BD6_DESBPF     
		if nGerTx == 1
  		   PCS_VLRTAD   := BD6->BD6_VLRTAD  
  		Else                                
  		   PCS_VLRTAD   := 0.00
  		EndIF        
          		
  		if nGerInss == 1
  		   If aBrwDem[nI,22] == 'F'
  		      PCS_VLRINS   := (BD6->BD6_VLRBPF *0.2)  
  		   Else 
              PCS_VLRINS   := 0.00
  		   EndIF         		      
  		Else                                
  		   PCS_VLRINS   := 0.00
  		EndIF       
  		
  		PCS_TIPPE    := aBrwDem[nI,22]
		PCS_SEQPF    := BD6->BD6_SEQPF
		PCS_FASE     := BD6->BD6_FASE 
		PCS_SITUAC   := BD6->BD6_SITUAC 
		PCS_MESPAG   := BD6->BD6_MESPAG 
		PCS_ANOPAG   := BD6->BD6_ANOPAG
		
		PCS_PREFIX   := ' '  
		PCS_NUMTIT   := ' '  
		PCS_PARCEL   := ' ' 
		PCS_TIPO     := ' '  
		PCS_CLIENT   := ' ' 
		
		PCS_RECBD6   := aBrwDem[nI,16]  
		PCS_OPEORI   := BD6->BD6_OPEORI   
		
	    PCS_LCFEC    := 11
	    
		cCont++             
		
        MsUnlock("PCS")  
                
         If copeori == ' '  
            copeori  := BD6->BD6_OPEORI         
            cDscori  := aBrwDem[nI,03]
         EndIf    
         If copeori == BD6->BD6_OPEORI
            vlrbse += BD6->BD6_VLRBPF 
            vlrtaxa+= PCS_VLRTAD
            vlrinss+= PCS_VLRINS
            vlrTot += BD6->BD6_VLRBPF + PCS_VLRTAD 
         Else                        
           
           
           vlrbse1  := Transform( vlrbse  , "@R  999,999,999.99")                             
           vlrtaxa1 := Transform( vlrtaxa , "@R  999,999,999.99")
           vlrTot1  := Transform( vlrTot  , "@R  999,999,999.99")

           MsgAlert("Convenio : "+ cDscori + CRLF + CRLF + CRLF +;
              	    " Valor Base      : "  +  vlrbse1   + CRLF +;  
                    " Valor taxa      : "  +  vlrtaxa1  + CRLF +;  
                    " Valor Inss      : "  + Transform( vlrinss  , "@R  999,999,999.99") + ('Tit a Parte') + CRLF +; 
                    " Valor Total     : "  +  vlrTot1   + CRLF + "  " , " Resumo da Cobrança")     
                                                
         
            u_FCriaTitRc(cOpeori , cCompInc )
         
         
           copeori := BD6->BD6_OPEORI         
           cDscori := aBrwDem[nI,03]
           
           vlrbse  := 0.00 
           vlrtaxa := 0.00
           vlrTot  := 0.00            
           vlrinss := 0.00
         
         EndIf 	

   EndIf
     	 
Next 

vlrbse1  := Transform( vlrbse  , "@R  999,999,999.99")                             
vlrtaxa1 := Transform( vlrtaxa , "@R  999,999,999.99")
vlrTot1  := Transform( vlrTot  , "@R  999,999,999.99")

    MsgAlert("Convenio : "+ cDscori + CRLF + CRLF + CRLF +;
             " Valor Base      : "  +  vlrbse1   + CRLF +;  
             " Valor taxa      : "  +  vlrtaxa1  + CRLF +; 
             " Valor Inss      : "  + Transform( vlrinss  , "@R  999,999,999.99") + ('Tit A parte') + CRLF +; 
             " Valor Total     : "  +  vlrTot1   + CRLF + "  " , " Resumo da Cobrança")        
          
         u_FCriaTitRc(cOpeori , cCompInc )
      
End Transaction             

Return()

***************************************************************************************/
Static Function AjustaSX1()

Local aHelp 	:= {}   


aAdd(aHelp, "Compt Entrada  , ano mes da co mptencia de entrada  ")
PutSX1(cPerg,"01", "Compt Entrada  ?","","","mv_ch1","C",6,0,0,"G","","","","","mv_par01"," ","","",""," ","",""," ","","","","","","","","",aHelp,aHelp,aHelp)  

aAdd(aHelp, "Cobrar   fase 3   , Cobrar  fase 3 ")                                                                                                                                    
PutSX1(cPerga,"01", "Cobrar na  fase 3??  ","","","mv_ch1","N",1,0,1,"C","","","","","mv_par01","Sim","","","","Não","","","","","","","","","","","",aHelp,aHelp,aHelp) 

aHelp := {}
aAdd(aHelp, "Cobrar  fase 31/2   , Cobrar na fase 31/2 ")                                                                                                                                    
PutSX1(cPerga,"02", "Cobrar fase 31/2 ??  ","","","mv_ch2","N",1,0,1,"C","","","","","mv_par02","Sim","","","","Não","","","","","","","","","","","",aHelp,aHelp,aHelp) 

aHelp := {}
aAdd(aHelp, "Cobrar  fase 4   , Cobrar na fase 4 ")                                                                                                                                    
PutSX1(cPerga,"03", "Cobrar fase 4 ??  ","","","mv_ch3","N",1,0,1,"C","","","","","mv_par03","Sim","","","","Não","","","","","","","","","","","",aHelp,aHelp,aHelp)

aHelp := {}                                                    
aAdd(aHelp, "Informe Classe de Redes a Cobrar , separado por virgula , Cobrar as Classe listadas   , em branco lista Todos ") 
PutSx1(cPerga,"04","Classe de Rede "  ,"","","mv_ch04","C",99,0,0,"G","","mv_par04","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , aHelp, aHelp, aHelp )  

aHelp := {}                                                    
aAdd(aHelp, "Informe Data de vencimento do Titulo ") 
PutSx1(cPerga,"05","Dta Venc Do Titulo "  ,"","","mv_ch05","D",8,0,0,"G","","mv_par05","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "", "" )  

aHelp := {}
aAdd(aHelp, "Gerar Taxa de Adm, Sim ou Não ")                                                                                                                                    
PutSX1(cPerga,"06", "Gerar Taxa de Adm ?       " ,"","","mv_ch6","N",1,0,1,"C","","","","","mv_par06","Sim","","",""        ,"Não"       ,"","","","","","","","","","","",aHelp,aHelp,aHelp)  

aHelp := {}
aAdd(aHelp, "Gerar Inss, Sim ou Não ")                                                                                                                                    
PutSX1(cPerga,"07", "Gerar Inss ?       " ,"","","mv_ch7","N",1,0,1,"C","","","","","mv_par07","Sim","","",""        ,"Não"       ,"","","","","","","","","","","",aHelp,aHelp,aHelp) 

aHelp := {}
aAdd(aHelp, "1 - Gerar Pessoa Fisica , 2 - Gerar Pessoa Jurica  , 3 - Gera Todos  ")                                                                                                                                    
PutSX1(cPerga,"08", "Gerar por Tipo de Pessao ?" ,"","","mv_ch8","N",1,0,1,"C","","","","","mv_par08","Pessoa Fisica","","",""        ,"Pessoa Jurica"       ,"","","Todos","","","","","","","","",aHelp,aHelp,aHelp) 

/*
PutSx1(cPerg,"01",OemToAnsi("Lote Int Eventual "      )  ,"","","mv_ch01","C",08,0,0,"G","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "", "" )
PutSx1(cPerg,"02",OemToAnsi("Faz Criticas ?"          )  ,"","","mv_ch08","N",01,0,0,"C","","","","","mv_par08","Sim","","","","Não","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "", "" )
PutSx1(cPerg,"03",OemToAnsi("Critíca Vlr Tot  Part"   )  ,"","","mv_ch09","N",01,0,0,"C","","","","","mv_par09","À Maior ","","","","À Menor","","","Não Critica","","","Critica Tot","","","","","",{},{},{})
PutSx1(cPerg,"04",OemToAnsi("Critíca Vlr Base Part"   )  ,"","","mv_ch10","N",01,0,0,"C","","","","","mv_par10","À Maior ","","","","À Menor","","","Não Critica","","","Critica Tot","","","","","",{},{},{})
PutSx1(cPerg,"05",OemToAnsi("Critíca Vlr Taxa Part"   )  ,"","","mv_ch11","N",01,0,0,"C","","","","","mv_par11","À Maior ","","","","À Menor","","","Não Critica","","","Critica Tot","","","","","",{},{},{})
PutSx1(cPerg,"06",OemToAnsi("Critíca Fase 3       "   )  ,"","","mv_ch12","N",01,0,0,"C","","","","","mv_par12","Sim ","","","","Não ","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"07",OemToAnsi("Critíca Fase Ant 3   "   )  ,"","","mv_ch13","N",01,0,0,"C","","","","","mv_par13","Sim ","","","","Não ","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"08",OemToAnsi("Critíca Faturad      "   )  ,"","","mv_ch14","N",01,0,0,"C","","","","","mv_par14","Sim ","","","","Não ","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"09",OemToAnsi("Critíca Bloq Faturad "   )  ,"","","mv_ch15","N",01,0,0,"C","","","","","mv_par15","Sim ","","","","Não ","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"10",OemToAnsi("Faz Conciliação      "   )  ,"","","mv_ch16","N",01,0,0,"C","","","","","mv_par16","Sim ","","","","Não ","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"11",OemToAnsi("Mostrar Titulo COV   "   )  ,"","","mv_ch17","N",01,0,0,"C","","","","","mv_par17","Sim ","","","","Não ","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"12",OemToAnsi("Mostrar Lanc. Duplic "   )  ,"","","mv_ch18","N",01,0,0,"C","","","","","mv_par18","Sim ","","","","Não ","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"13",OemToAnsi("Consid Duplic F/ Compet" )  ,"","","mv_ch19","N",01,0,0,"C","","","","","mv_par19","Sim ","","","","Não ","","","","","","","","","","","",{},{},{})

  
*/
Return

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Formata textos das caixas multiget                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
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
*--------------------------------------*
Static Function EnvEmail1( _cMensagem , cDest )
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
          /*       
 User Function FCriaTitRc(cOpeori , cComp )       
 
Local  cNum     := ' '
Local  cPrefix  := 'COV'
Local  cParcela :=  ' ' 
Local  cTipo    :=  "DP"	  
Local  cNat	    := '30'
Local  cCliente := ' ' 
Local  cLojaCli := ' '
Local  dDataBas := dDatabase 
Local  dVencto  := dDatabase
Local  nValor   := 0.00
Local  cHistor  := 'Cobrança Antec de Conven' 
Local  cCodEmp  := '0004'
Local  cAnoBase := '2017'
Local  cMesBase := '01'
local  cQryRec  := " "   

Local  nSucesso        

Private  lMsErroAuto	:= .F.
Private lMsHelpAuto	:= .T.  
Private lAutoErrNoFile := .T.

Private adadosTit:= {}
                   
   cQryRec := " SELECT BT5_CODCLI CLIENT , BT5_LOJA LOJA , '30'  NAT , NUME1.NUM NUM , SUM(PCS_VLRBPF) VLRBPF , SUM(PCS_VLRTAD) VLRTAD , SUM(PCS_VLRINS) VLRINS " + CRLF
   cQryRec += "   FROM "+RetSqlName('PCS')+ " PCS , "+RetSqlName('BT5')+ " BT5 , " + CRLF
   cQryRec += " ( SELECT NVL(MAX(E1_NUM),'000000000') NUM   " + CRLF 
   cQryRec += "     FROM "+RetSqlName('SE1')+ " SE1 " + CRLF  
   cQryRec += "    WHERE E1_FILIAL ='"+ xFilial('SE1')+"' AND E1_PREFIXO = 'COV') NUME1 " + CRLF 
   cQryRec += "  WHERE PCS_FILIAL ='"+ xFilial('PCS') +"' AND PCS.D_E_L_E_T_ = ' ' " + CRLF  
   cQryRec += "    AND BT5_FILIAL ='"+ xFilial('BT5') +"' AND BT5.D_E_L_E_T_ = ' ' " + CRLF 
     
   cQryRec += "    AND PCS_OPEORI = '"+cOpeori+ "'" + CRLF
   cQryRec += "    AND PCS_ANOPAG || PCS_MESPAG = '"+cComp+ "' " + CRLF
   
   cQryRec += "    AND PCS_NUMTIT = '         ' " + CRLF  
   cQryRec += "    AND PCS_OPEORI = BT5_OPEINT" + CRLF 
   cQryRec += " GROUP BY  BT5_CODCLI , BT5_LOJA  ,  NUME1.NUM " + CRLF  
   
   If Select((cAliasCT)) <> 0 

      (cAliasCT)->(DbCloseArea()) 

   Endif           
                        
   TcQuery cQryRec New Alias (cAliasCT)

   If !(cAliasCT)->(EOF())

		 cNum     := STRZERO((VAL((cAliasCT)->NUM)+ 1),9)
		 cPrefix  := 'COV'
		 cParcela :=  ' ' 
		 cTipo    :=  'DP'	  
		 cNat	  := '30'
		 cCliente := (cAliasCT)->CLIENT 
		 cLojaCli := (cAliasCT)->LOJA 
		 dDataBas := dDatabase 
		 dVencto  := dDtvenc
		 nValor   := (cAliasCT)->VLRBPF + (cAliasCT)->VLRTAD   
		 cvlrins  := (cAliasCT)->VLRINS
		 cHistor  := 'Cobrança Antec de Conven' 
		 cCodEmp  := '0004'
		 cAnoBase := SUBSTR(cComp,1,4)
		 cMesBase := SUBSTR(cComp,5,2)
	
 	   
 	   ////
 	   	SA1->(DbSetOrder(1))
    	SA1->(MsSeek(xFilial("SA1")+cCliente+cLojaCli))
 	   
 	    // Criação de títulos provisórios.
  
       DBSELECTAREA('SE1')
  
	  //	aDadosTit := {}  
//		aAdd(aDadosTit, {"E1_FILIAL "	, XFILIAL('SE1'), .F.})
//		aAdd(aDadosTit, {"E1_PREFIXO"	, cPrefix	, .F.})
//		aAdd(aDadosTit, {"E1_NUM"		, cNum   	, .F.})
//		aAdd(aDadosTit, {"E1_PARCELA"	, cParcela	, .F.})
//		aAdd(aDadosTit, {"E1_TIPO"		, cTipo	  	, .F.})
//		aAdd(aDadosTit, {"E1_NATUREZ"	, cNat	  	, .F.})
//		aAdd(aDadosTit, {"E1_CLIENTE"	, cCliente	, .F.})
//		aAdd(aDadosTit, {"E1_LOJA"		, cLojaCli	, .F.})
//		aAdd(aDadosTit, {"E1_EMISSAO"	, dDataBase	, .F.})
//		aAdd(aDadosTit, {"E1_VENCTO"	, dVencto  	, .F.})    
//		aAdd(aDadosTit, {"E1_VENCREA"	, DataValida(dVencto)  	, .F.})
//		aAdd(aDadosTit, {"E1_VALOR"		, nValor  	, .F.})
//		aAdd(aDadosTit, {"E1_HIST"		, cHistor	, .F.}) 
//		aAdd(aDadosTit, {"E1_CODEMP"	, cCodEmp	, .F.})
//		aAdd(aDadosTit, {"E1_ANOBASE"	, cAnoBase	, .F.})
//		aAdd(aDadosTit, {"E1_MESBASE"	, cMesBase	, .F.}) 
//		                                                         
        u_FCTitRc(cPrefix	 , cNum , cParcela , cTipo , cNat , cCliente , cLojaCli	, dDataBase, dVencto  ,nValor  , cHistor	, cCodEmp	, cAnoBase  ,cMesBase)	


        u_fGrInss1(cNum , cparcela , ctipo , cvlrins ,cmesbase , canobase , cOpeori  , cCliente , clojaCli , dVencto , 0)
       
		cQuery := " UPDATE "+RetSqlName("PCS") +" "+ CRLF
		cQuery += " SET "+ CRLF
		cQuery += " PCS_PREFIX   = '"+cPrefix  +"', "+ CRLF  
		cQuery += " PCS_NUMTIT   = '"+cNum     +"', "+ CRLF
		cQuery += " PCS_PARCEL   = '"+cParcela +"', "+ CRLF
		cQuery += " PCS_TIPO     = '"+cTipo    +"', "+ CRLF
		cQuery += " PCS_CLIENT   = '"+cCliente +"'  "+ CRLF
		cQuery += " WHERE PCS_FILIAL = '"+ xFilial('PCS') +"' and d_E_L_E_T_ = ' ' " + CRLF 
		cQuery += "   AND PCS_OPEORI = '"+cOpeori+ "'" + CRLF
        cQuery += "   AND PCS_ANOPAG || PCS_MESPAG = '"+cComp+ "' " + CRLF 
        cQuery += "   AND PCS_NUMTIT =  '         ' " + CRLF  
        
        
		nSucesso := TcSqlExec(cQuery)
		
	//	If PCU->(MsSeek(xFilial("PCU")+cOpeori+cPrefix+cNum+cparcela+ctipo))			         
	  
		    PCU->(RecLock("PCU",.T.))
		   
		    PCU->PCU_FILIAL := xFilial('PCU') 
		 	PCU->PCU_OPEORI := cOpeori  
			PCU->PCU_COMPT  := cComp  
			PCU->PCU_PREFIX := cPrefix   
			PCU->PCU_NUM    := cNum   
			PCU->PCU_PARCEL := cParcela  
			PCU->PCU_TIPO   := CTipo  
			PCU->PCU_VLR    := nValor  
			PCU->PCU_RELAT  := .F.  
			PCU->PCU_CONF   := .F.  
			PCU->PCU_EMAIL  := .F.  
			PCU->PCU_CARTA  := .F.  
			PCU->PCU_DIVERG := .F.     
			PCU->PCU_FECHAM := .F.
			PCU->PCU_USRSEL := cUsuario
			PCU->PCU_HRSEL  := dtos(DATE()) + " - " + Time()     
						
		   PCU->(MsUnlock())    			         
      
                     
           MsgAlert("Convenio: "+ cDscori + CRLF + CRLF + CRLF +;
              	    " Titulo : "+ cPrefix + cNum + cParcela    + cTipo + CRLF + CRLF+;  
               " Valor Total : "+  Transform( nValor  , "@R  999,999,999.99") + CRLF + "  " , " Titulo Gerado ")  
  EndIf 
Return()
*/

//////////////////// 
static Function fConflanc ( nRef )   

Local lret	    := .F.     
local lSegue    := .F.   
Local cQrySeq	:= ""                                       

cQrySeq := " SELECT COUNT(*) qtda               "  + CRLF
cQrySeq += "   FROM " +RetSqlName('PCS')+ " PCS  " + CRLF
cQrySeq += "  WHERE PCS_FILIAL ='"+ xFilial('PCS') +"' AND PCS.D_E_L_E_T_ = ' ' " + CRLF 
cQrySeq += "    AND PCS_RECBD6 = "+ ltrim(str(nRef)) +" "    + CRLF                              
   
If Select((cAliasCf)) <> 0 

   (cAliasCf)->(DbCloseArea()) 

Endif           
                        
TcQuery cQrySeq New Alias (cAliasCf)

If (cAliasCf)->qtda == 0 

   lSegue:= .T.      
   
EndIf 

return( lSegue )

////////////////////            


static Function fConfexc ( nRef )   

Local lret	    := .F.     
local lSegue    := .F.   
Local cQrySeq	:= ' '   
Local cComp     := ' '
Local Cconv     := ' '                                    
Local I         := 0    
local cTitulo   := ' '
local lfaz      := .F.
                               
 For I:= 1 to Len(aBrwPEG)        
   
    lfaz := .F. 
   
     If aBrwPEG[I,1] == .T.   

      
		   cQrySeq := " SELECT  DISTINCT E1_PREFIXO PREFIXO , E1_NUM NUM , E1_PARCELA PARCELA ,E1_TIPO TIPO,  E1_CLIENTE CLIENTE , E1_LOJA LOJA , E1_SALDO SALDO , E1_VALOR VALOR , E1_BAIXA BAIXA, E1_NUMBOR NUMBOR  "+ CRLF
		   cQrySeq += "   FROM " +RetSqlName('PCS')+ " PCS  , " +RetSqlName('SE1')+ " SE1  " + CRLF
		   cQrySeq += "  WHERE PCS_FILIAL ='"+ xFilial('PCS') +"' AND PCS.D_E_L_E_T_ = ' ' " + CRLF  
           cQrySeq += "    AND  E1_FILIAL ='"+ xFilial('SE1') +"' AND SE1.D_E_L_E_T_ = ' ' " + CRLF 
		   cQrySeq += "    AND PCS_OPEORI ='"+ SUBSTR(aBrwPEG[I,3],1,4) +"' "                + CRLF                              
     	   
     	   cQrySeq += " AND PCS_PREFIX   = E1_PREFIXO "+ CRLF  
		   cQrySeq += " AND PCS_NUMTIT   = E1_NUM    "+ CRLF
		   cQrySeq += " AND PCS_PARCEL   = E1_PARCELA     "+ CRLF
		   cQrySeq += " AND PCS_TIPO     = E1_TIPO        "+ CRLF
		   cQrySeq += " AND PCS_CLIENT   = E1_CLIENTE     "+ CRLF 
		            
		   cQrySeq += " AND E1_VALOR = E1_SALDO AND E1_NUMBOR = ' '           "+ CRLF 
                 
		   //cQrySeq += " AND PCS_ANOPAG || PCS_MESPAG  = '"+(substr(aBrwPEG[I,2],1,4)+substr(aBrwPEG[I,2],6,2))+"' " + CRLF                             
		   cQrySeq += " AND PCS_ANOPAG || PCS_MESPAG  = '"+aBrwPEG[I,2] +"' " + CRLF                             
		   
		    
		   If Select((cAliasEX)) <> 0 
		
		     (cAliasEX)->(DbCloseArea()) 
		
		   Endif 
  
           TcQuery cQrySeq New Alias (cAliasEX)

          While !(cAliasEX)->(EOF()) 
          
               lfaz := .T.
        
               U_fExcTit( SUBSTR(aBrwPEG[I,3],1,4),(cAliasEX)->PREFIXO,(cAliasEX)->NUM ,(cAliasEX)->PARCELA,(cAliasEX)->TIPO, aBrwPEG[I,2] , (cAliasEX)->SALDO , (cAliasEX)->VALOR , (cAliasEX)->NUMBOR )
                                                     
               (cAliasEX)->(DbSkip())    
        	
           EndDo

           If lfaz == .F.
               
               MsgAlert( "        A Seleção     " + CRLF              +;
                         " Convenio     : " + aBrwPEG[I,3] + CRLF     +;
                         " Competencia  : " + aBrwPEG[I,2] + CRLF     +; 
                         " Não Há Titulo(s) para esta Consulta - Favor Verificar  " , " Atencao!")     
           EndIF
              
       EndIf 

Next       
return(  )      
             
/*
user Function fExcTit( cOpeori , cPref , cNum , cParc , cTipo , cComp , saldo , valor , bord )
                                                                        
local cOpeori1 := cOpeori
local cPref1   := cPref
local cNum1    := cNum
local cParc1   := cParc
local cTipo1   := cTipo
local cComp1   := cComp     
local nSaldo1  := nSaldo
local nValor1  := nValor
local cBord1   := cBord            
                                 
            If nValor1 == nSaldo1 .AND. empty(cBord1) 
           
                  cQuery := "Delete  "+RetSqlName("PCS") + CRLF                
                  cQuery += " WHERE PCS_FILIAL ='"+ xFilial('PCS') +"' AND D_E_L_E_T_ = ' ' " + CRLF 
		          cQuery += "   AND PCS_OPEORI = '"+ cOpeori1 +"' "    + CRLF                              
//        	      cQuery += "   AND PCS_PREFIX = '"+ cPref1 +"'  "+ CRLF   
        	      cQuery += "   AND PCS_PREFIX IN ('COV','INS' )   "+ CRLF  
     		      cQuery += "   AND PCS_NUMTIT = '"+ cNum1    +"'  "+ CRLF
	    	      cQuery += "   AND PCS_PARCEL = '"+ cParc1 +"'  "+ CRLF
		          cQuery += "   AND PCS_TIPO   = '"+ cTipo1   +"'  "+ CRLF		       
                  cQuery +="    AND PCS_ANOPAG || PCS_MESPAG  = '"+cComp1+"' "   + CRLF                             

                  TCSqlExec(cQuery)          
                 
                  DbSelectArea("SE1")                        
                  DbSetOrder(1)

    	      	  If SE1->(MsSeek(xFilial("SE1")+cPref1+cNum1+cParc1+cTipo1))
		       
		             SE1->(RecLock("SE1",.F.))
			         SE1->(DbDelete())
			         SE1->(MsUnlock())   
			         
			         DbSelectArea("PCU")                        
                     DbSetOrder(2) 

                     If PCU->(MsSeek(xFilial("PCU")+cOpeori1+cPref1+cNum1+cParc1+cTipo))			         
		                PCU->(RecLock("PCU",.F.))
			            PCU->(DbDelete())
			            PCU->(MsUnlock())    			         
                     EndIf    
                  
                  Else 

                    MsgAlert("        A Seleção     " + CRLF + CRLF +    ;
                             " Titulos  : " + cPref1+cNum1+cParc1+cTipo + CRLF+ CRLF +;
                             " Titulos Não Encontrado  - Favor Verificar  ","Atencao!")     
   
                  EndIf 
                
            ElseIf (cAliasEX)->VALOR != (cAliasEX)->SALDO                            
               
                    MsgAlert("        A Seleção     " + CRLF + CRLF      +;
                             " Titulo  : " + cPref1+cNum1+cParc1+cTipo + CRLF+ CRLF +;
                             " Titulo Sofreu Baixa, Favor Verificar  ","Atencao!")     
                    
            ElseIf !empty((cAliasEX)->Numbor)                             
               
                    MsgAlert("        A Seleção     " + CRLF + CRLF +;
                             " Titulo  : " + cPref1+cNum1+cParc1+cTipo + CRLF+ CRLF +;
                             " Titulo Esta em bordero   ","Atencao!")    
               
            EndIf                
                                            
Return()                            
*/

/// valida recno bd6, exclusivo 
/*User Function fVrecBd6(recbd6)   
  
local ret:= .T.
  
  dbSelectArea("PCS")
  dbSetOrder(4)

  If dbSeek(xFilial("PCS")+(recbd6))    
     ret:= .F.
  EndIf 
         
Return(ret)
*/       
//User Function FCTitRc(aDadosTit)       
/*User Function FCTitRc(cPrefix	 , cNum , cParcela , cTipo , cNat , cCliente , cLojaCli	, dDataBase, dVencto , nValor  , cHistor	, cCodEmp	, cAnoBase  ,cMesBase)	
                                           
	// Grava o titulo a receber...	
	SE1->(RecLock("SE1",.T.))

	SE1->E1_FILIAL   := xFilial("SE1")
	SE1->E1_TIPO     := cTipo
	SE1->E1_CLIENTE  := cCliente
	SE1->E1_LOJA     := cLojaCli          
	SE1->E1_NATUREZ  := cNat
	SE1->E1_EMISSAO  := dDataBase
	SE1->E1_EMIS1    := dDataBase
	SE1->E1_SITUACA  := "0"
	SE1->E1_MOEDA    := 1
	SE1->E1_OCORREN  := "01"
	SE1->E1_FLUXO    := "S"
	SE1->E1_STATUS   := "A"
	SE1->E1_PROJPMS  := " "
	SE1->E1_VENCORI  := dVencto
	SE1->E1_VENCTO   := dVencto
	SE1->E1_PREFIXO  := cPrefix
	SE1->E1_NUM      := cNum
	SE1->E1_PARCELA  := cParcela
	SE1->E1_VENCREA  := DataValida(dVencto)
	SE1->E1_VLCRUZ   := nValor
	SE1->E1_IRRF	 := 0
	SE1->E1_VALOR    := nValor
	SE1->E1_NOMCLI   := SA1->A1_NOME
	SE1->E1_SALDO    := nValor                     
	SE1->E1_HIST     := cHistor  
	SE1->E1_DECRESC  := 0
	SE1->E1_SDDECRE  := 0
	SE1->E1_ACRESC   := 0
	SE1->E1_SDACRES  := 0
	SE1->E1_VALLIQ   := 0
	 
	SE1->E1_BCOCLI   := " "
	SE1->E1_AGECLI   := " "
	SE1->E1_CTACLI   := " "
	
	SE1->E1_NUMBCO   := " "
	SE1->E1_PLNUCOB  := " "
	SE1->E1_VALJUR   := 0
	SE1->E1_PORCJUR  := 0
	SE1->E1_CODINT   := " "
	SE1->E1_CODEMP   := cCodEmp	
	SE1->E1_MATRIC 	 := " "
	SE1->E1_CONEMP   := " "
	SE1->E1_VERCON   := " "
	SE1->E1_SUBCON   := " "
	SE1->E1_VERSUB   := " "
	SE1->E1_MESBASE  := cMesBase
	SE1->E1_ANOBASE  := cAnoBase
	SE1->E1_MULTNAT  := "2"
	SE1->E1_NUMCON   := " "
	SE1->E1_TIPREG   := " "
	SE1->E1_ORIGEM   := 'CABA128'
	
	SE1->(MsUnLock())

Return()   
*/