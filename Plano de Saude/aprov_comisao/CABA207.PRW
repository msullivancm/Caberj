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
| Programa  | CABA177  | Autor | Altamiro	Affonso    | Data | 18/01/2022  |
|---------------------------------------------------------------------------|              
| Descricao | Alcadas de liberação de comissoes                             |
|           |                                                               |                                                       
|---------------------------------------------------------------------------|
| Uso       | Alcadas de liberação de comissoes                             |                                   
 --------------------------------------------------------------------------*/

User Function CABA207( nOrigem , ctitulos , ctitulos1 ,cano183 , cmes183, nMstLib, nGrpEmp , nPerPes)
                                                 
local nI := 0          

PRIVATE cPerg        := "CABA207"
PRIVATE cAno         := ' ' 
private cMes         := ' ' 
Private _cUsuario    := SubStr(cUSUARIO,7,15)
private _UserLog     := RetCodUsr()


Private _cUsuario:= SubStr(cUSUARIO,7,15)
Private _cIdUsuar:= RetCodUsr()

private ctitulos11  := ctitulos1

private nMstLib1 := nMstLib 
private nGrpEmp1 := nGrpEmp

private nPerPes1 := nPerPes

private cTitPesq := Iif (nGrpEmp1 == 1 ,'Administradora', (Iif (nGrpEmp1 == 2 ,'Empresas',(Iif (nGrpEmp1 == 3 ,'Uma Empresa' , 'Todas as Empresas')))))

private cCompteAtu   := substr(dtos(DATE()) ,1,6)       
 
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

Private cAliasMost 	 := GetNextAlias()

Private cAliasMSV 	 := GetNextAlias()

Private cAliasRkC1 	 := GetNextAlias()
Private cAliasRkC2 	 := GetNextAlias()
Private cAliasRkC3 	 := GetNextAlias()
Private cAliasRkC4 	 := GetNextAlias()
Private cAliasRkC5 	 := GetNextAlias()

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
private lflagMM       :=.F.
private cValor        := ' ' 

Private aBrwPEG 
private aRetPEG	:= {}    
 
Private aCabPEG	:= {"Empresa ",;
        "Grupo Sinistralidade",;
                     "Receita",;
              "Custo Variavel",;
			   "Margem Contr.",;
                           "%",;
                   "Comissões",;
                   "Resultado",;
                  "Tx Retorno",;
				    "% C.Fixo",;
				  "Custo Fixo",;
			    "Result Final",;
			   "Retorno Final",;
              "Sinistralidade",;
               "Idade (Meses)",;
                   "Vidas Atv",;
                   "Vidas Blq",;
                   "%Vidas Atv",;
                 "Total Vidas"}
        
//Private aCabPEG	:= {"Empresa "," Grupo Sinistralidade","Receita","Custo","Margem Contr.","%" ,"Comissões","Resultado","Tx Retorno","% C f","Vlr C F", "Result Final" , "Ret. Final","Sinist.","Idade","Vidas Atv","Vidas Blq","Proporção","Total Vidas"}
Private aTamPEG	    := { 100      ,  60                  , 40      , 50    , 50            , 20 ,40          , 40         , 20        ,20     , 40      ,  40            , 20          , 20      ,30     ,    20     ,  20       ,20         , 20            }       
//Private aTamPEG	:= {5  , 25     ,20     , 25   , 20   ,20    ,    80     , 30    ,30        ,30     ,    20    ,  25    ,  100    ,100       , 25       , 25        }       

//private aBrwPEG
//Private aCabPEG		:= {" ", "Compt. Entrada","Operadora de  Origem  ","Vlr Fase 3","Vlr Fase 31/2","Vlr Fase 4","Vlr Inss","Vlr Tx Adm", "Total Guias","Faturado","Qtda Guias"}
//Private aTamPEG		:= {10,30,120,45,45,45,45,45,45,45,25}  

Private aObjects 	:= {}

Private aSizeAut 	:= MsAdvSize()    
 
private cFecConv    := 1       
private cFezConc    := 2

private nPagto      := 0

Private dVencInc                      
Private dVencFim                     
Private cTipotit                     
Private cTipbaixa     

private cCompInc := ' '                     
private cCompFim := ' '

private cmv_par09:= ' '   

private nfase3    := 0                   
private nfase312  := 0                  
private nfase4    := 0   

private Idx       := 0        

private cClsRd   := ' ' 

private dDtvenc  := ' '  

Private cDscori  := ' ' 

Private cMesBase     := ' '  
Private cAnoBase     := ' ' 
Private cNumTitI     := ' '  
Private cNumTitF     := ' '     
Private cOpeInc      := ' ' 
Private cOpeFim      := ' '     
   
Private aTit         := {}                     

private cQueryDem := ' ' 
private cQueryDemT:= ' ' 
private cAliasPEG	:= GetNextAlias()
private cAliasPEGT	:= GetNextAlias()
private cAliasDem	:= GetNextAlias()
private cAliasDemT	:= GetNextAlias()
PRIVATE cAliasCFX   := GetNextAlias()
Private nMaId    := 0
Private nQtdaAtv := 0
Private nQtdaBlq := 0
Private nQtdatot := 0
PRIVATE nCargcom := 0 
private nTodResul:= 0 
PRIVATE cAno         := ' ' 
private cMes         := ' ' 

Private cttitpgto:=' '   

private nbascomT := 0.00
private nVlrcomT := 0.00
private nQtdat   := 0
Private nPercomT := 0.0000
/*private aMenuAdm:={{{||fRkAdm1() }   , "Analise Corretora Visão 1" , "Analise Corretora Visão 1"  },;
                   {{||fRkAdm2() }   , "Analise Corretora Visão 2" , "Analise Corretora Visão 2"  },; 
                   {{||fRkAdm3() }   , "Analise Corretora Visão 3" , "Analise Corretora Visão 3"  },; 
                   {{||fRkAdm4() }   , "Analise Corretora Visão 4" , "Analise Corretora Visão 4"  },; 				   				   
                   {{||fRkAdm5() }   , "Analise Corretora Visão 5" , "Analise Corretora Visão 5"  }} */
private cEmpCI   := Iif (cempant == '01','C','I')
private nPerioro := 0
private nOpcPes  := 0

private  MensalTot := 0
private  CustoTot  := 0
private  CargcomTot:= 0
private  ResulTot  := 0
private  QtdaAtvTot:= 0 
private  QtdaBlqTot:= 0 
private  QtdaVdTot := 0

private nPercCfx   := 0.00
PRIVATE nPercCfxM  := 0
PRIVATE nContCfx   := 0
private nVlrCfxT   := 0

   If Pergunte(cPerg,.T.) = .F.
	  Return
   Endif 

   cAno         := Mv_par02 
   cMes         := Mv_par01
   cOpcPes      := Mv_par03
   nPerioro     := Mv_par04
   nGrpEmp1     := cOpcPes 
   
cTitPesq := Iif (cOpcPes == 1 ,'Administradora', (Iif (cOpcPes == 2 ,'Empresas',(Iif (cOpcPes == 3 ,'Uma Empresa' , 'Todas as Empresas')))))

cAnoANT :=  strzero((val(cAno)-1),4)
cMesAnt := cMes

    If  cMes == '01'
        cMesAtu := '12'
        cAnoATU := strzero((val(cAno)-1),4)
    ElseIf cMes >= '02' 
        cMesAtu :=strzero((val(cMes)-1),2)
        cAnoATU :=cAno
    EndIF

cAnoANT := substr(cAnoANT,3,2)
cAnoATU := substr(cAnoATU,3,2)


If nPerioro == 1 

   cTitPesq:= cTitPesq + " - 12 Meses"

ElseIf nPerioro == 2 

   cTitPesq:= cTitPesq + " - Ano Civil "
   
   cAnoANT := cAnoATU
   cMesAnt := '01'

ElseIf nPerioro == 3 

   cTitPesq:= cTitPesq + " - Um Mes "
   
   cAnoANT := cAnoATU
   cMesAnt := cMesAtu

EndIf   

cTitPesq:= cTitPesq + ' -  Compte Inicial  20'+cAnoANT+'/'+cMesAnt +' - Compte Final  20'+cAnoATU+'/'+cMesAtu


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

oDlg  		:= MsDialog():New( aSizeAut[7],00,aSizeAut[3] ,aSizeAut[5]-10,"Demonstrativo de "+cTitPesq ,,,.F.,,,,,,.T.,,,.T. ) 
oSayPEG    	:= TSay():New( aPosObj[1][1],aPosObj[1][2],{||"Demonstrativo de "+cTitPesq },oDlg,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,236,016)


//bDbClickPEG	:= {|| aBrwPEG[oBrwPEG:nAt,1] := !aBrwPEG[oBrwPEG:nAt,1], oBrwPEG:Refresh()}   

bDbClickPEG	:= {|| MsgAlert("Favor Escolher uma opção em 'Ações Relacionadas") , oBrwPEG:Refresh()}   
//bDbClickPEG	:= {|| aBrwPEG[oBrwPEG:nAt,1] := iif ((aBrwPEG[oBrwPEG:nAt,17] == ' ' .or. mv_par01 == '1') , aBrwPEG[oBrwPEG:nAt,1] ,!aBrwPEG[oBrwPEG:nAt,1]) , oBrwPEG:Refresh()}   

//bChangePEG	:= {||AtuBrwGuia(aBrwPEG[oBrwPEG:nAt,2],aBrwPEG[oBrwPEG:nAt,3])}

oBrwPEG 	:= TcBrowse():New(aPosObj[1][1],aPosObj[1][2],aPosObj[1][4],aPosObj[1][3]+40,,aCabPEG,aTamPEG,oDlg,,,,,bDbClickPEG,,,,,,,.F.,,.T.,,.F.,,, )

//oBrwPEG 	:= TcBrowse():New(aPosObj[1][1]+10,aPosObj[1][2],aPosObj[1][4],aPosObj[1][3]+190,,aCabPEG,aTamPEG,oDlg,,,,,bDbClickPEG,,,,,,,.F.,,.T.,,.F.,,, )

oBrwPEG:SetArray(aBrwPEG) 


oBrwPEG:bLine := {||{   aBrwPEG[oBrwPEG:nAt,  1] ,;
                        aBrwPEG[oBrwPEG:nAt,  2] ,;
                        Transform(aBrwPEG[oBrwPEG:nAt, 3]  ,'@E  999,999,999.99'),;
                        Transform(aBrwPEG[oBrwPEG:nAt, 4]  ,'@E  999,999,999.99'),;
                        Transform(aBrwPEG[oBrwPEG:nAt,14]  ,'@E  999,999,999.99'),;
                        Transform(aBrwPEG[oBrwPEG:nAt,15]  ,'@E  99,999.99')+'%',;
                        Transform(aBrwPEG[oBrwPEG:nAt,13]  ,'@E  999,999,999.99'),;
                        Transform(aBrwPEG[oBrwPEG:nAt, 5]  ,'@E  999,999,999.99'),;
                        Transform(aBrwPEG[oBrwPEG:nAt, 6]  ,'@E  999,999,999.99')+'%',;
                        Transform(nPercCfxM                ,'@E  999.99')+'%',;
						Transform(aBrwPEG[oBrwPEG:nAt,16]  ,'@E  999,999,999.99'),;
                        Transform(aBrwPEG[oBrwPEG:nAt,18]  ,'@E  999,999,999.99'),;
						Transform(aBrwPEG[oBrwPEG:nAt,17]  ,'@E  99,999.99')+'%',;
			            Transform(aBrwPEG[oBrwPEG:nAt, 7]  ,'@E  99,999.99')+'%',;
                        Transform(aBrwPEG[oBrwPEG:nAt, 8]  ,'@E  999,999') ,;
                        Transform(aBrwPEG[oBrwPEG:nAt, 9]  ,'@E  999,999'),;
                        Transform(aBrwPEG[oBrwPEG:nAt,10]  ,'@E  999,999'),;
                        Transform(aBrwPEG[oBrwPEG:nAt,11]  ,'@E  99,999.99')+'%',;
                        Transform(aBrwPEG[oBrwPEG:nAt,12]  ,'@E  999,999')}}                   

oBrwPEG:nScrollType  := 1 // Scroll VCR

lConfirmou 	:= .T.

	aBut    :={{"PENDENTE", {||fRkAdm1()    ,oBrwPEG:Refresh()          }   , "Classif. Sinistralidade"  , "Classif. Sinistralidade"   }} 
    aAdd(aBut, {"PENDENTE", {||fRkAdm2()    ,oBrwPEG:Refresh()          }   , "Sinist. Faturamento X Custo"  , "Sinist. Faturamento X Custo"   }) 
	aAdd(aBut, {"PENDENTE", {||fRkAdm3()    ,oBrwPEG:Refresh()          }   , "Result.Financeiro Empresa", "Result.Financeiro Empresa" }) 
    aAdd(aBut, {"PENDENTE", {||fRkAdm4()    ,oBrwPEG:Refresh()          }   , "Result.Financeiro Grp.Empresa"  , "Result.Financeiro Grp.Empresa"  }) 
	aAdd(aBut, {"PENDENTE", {||fRkAdm5()    ,oBrwPEG:Refresh()          }   , "Result.Financ.Grp.Empresa c/ Comis"  , "Result.Financ.Grp.Empresa c/ Comis"  }) 
	aAdd(aBut, {"PENDENTE", {||oDlg:End()                               }   , "Sair "               , "Sair "             })  

lConfirmou := .F.

//bOk 	:= {||fSequen() , oBrwPEG:Refresh() , oBrwPEG:Refresh() ,oDlg:End()   }    
 
bOk 	:= {|| MsgAlert("Favor Escolher uma opção em 'Ações Relacionadas'")  ,oBrwPEG:Refresh() }    
 
bCancel := {||lConfirmou := .F.,oDlg:End()}

oDlg:Activate(,,,.T.,,,EnchoiceBar(oDlg,bOk,bCancel,,aBut))

a:='v'

Return(nPagto)    

************************************************************************************

Static Function aDadosPEG

Local cQryPEG	:= ""
local i

MensalTot := 0
CustoTot  := 0
CargcomTot:= 0
ResulTot  := 0
QtdaAtvTot:= 0 
QtdaBlqTot:= 0 
QtdaVdTot := 0
nVlrCfxT  := 0
ProcRegua(0) 

fcargCFx()

nCont := 0

for i:=1 to 5
    IncProc('Buscando Dados no Servidor ...')
next             
      
	cQryPEG  :=        " SELECT (CASE WHEN Codemp in ('0010','0404')  THEN  01    " 
    cQryPEG  +=CRLF+"                 WHEN Codemp in ('0149','0182','0282','0296') then 02 "
    cQryPEG  +=CRLF+"                 WHEN Codemp in ('0373','0394') then 03 "
    cQryPEG  +=CRLF+"                 WHEN Codemp in ('0220','0260','0274','0352','0375','0387') then 04 "
    cQryPEG  +=CRLF+"                 ELSE 99 END) ClasEmp  , "
     
    cQryPEG  +=CRLF+"            codemp CodEmp , trim(Bg9.Bg9_Descri) Emp_1 , "
	
    cQryPEG  +=CRLF+"           (CASE WHEN Decode(Sum(MENSA),0,0,round((Sum(APROVADO-PART))/Sum(MENSA),6))*100 = 0 THEN            '0- Ideterminada' "
    cQryPEG  +=CRLF+"              WHEN Decode(Sum(MENSA),0,0,round((Sum(APROVADO-PART))/Sum(MENSA),6))*100 BETWEEN 1 AND 65 THEN  '1-Até 65%'       "
	cQryPEG  +=CRLF+"              WHEN Decode(Sum(MENSA),0,0,round((Sum(APROVADO-PART))/Sum(MENSA),6))*100 BETWEEN 66 AND 70 THEN '2-de 66 a 70%'   "
	cQryPEG  +=CRLF+"              WHEN Decode(Sum(MENSA),0,0,round((Sum(APROVADO-PART))/Sum(MENSA),6))*100 BETWEEN 71 AND 80 THEN '3-de 71 a 80%'   "
	cQryPEG  +=CRLF+"              ELSE                                    '4-acima de 80%' END) GRPSINIS  ,"
	cQryPEG  +=CRLF+"              Sum(MENSA) mensal ,"
    cQryPEG  +=CRLF+"              Sum(APROVADO-PART) Custo,"
    cQryPEG  +=CRLF+"              Sum(MENSA) - Sum(APROVADO-PART) Resulta,"
    cQryPEG  +=CRLF+"              Decode(Sum(MENSA),0,0,  (trunc((Sum(MENSA) - Sum(APROVADO-PART)) / Sum(MENSA),2) * 100)) perc ,"
    cQryPEG  +=CRLF+"              Decode(Sum(MENSA),0,0,round((Sum(APROVADO-PART))/Sum(MENSA),4))*100 sinist , "

//	cQryPEG  +=CRLF+"              Decode(Sum(MENSA),0,0,  trunc((Sum(MENSA) * "+Transform(nPercCfxM,'@E  99,99')+" ) / 100,2)) VlrCfx " 
	cQryPEG  +=CRLF+"              Decode(Sum(MENSA),0,0,  trunc((Sum(MENSA) * "+str(nPercCfxM)+" ) / 100,2)) VlrCfx " 
     
    If  cEmpCI=='I'
		cQryPEG  +=CRLF+" FROM COB_SINISTRALIDADE_MS_INT , bg9020 bg9  "
	Else
		cQryPEG  +=CRLF+" FROM COB_SINISTRALIDADE_MS_CAB , bg9010 bg9 "
	EndIf	             
		
	cQryPEG  +=CRLF+"  where MES_ANO_REF between TO_DATE('"+DtOS(stod('20'+cAnoAnt+cMesAnt+'01'))+"','YYYYMMDD') and TO_DATE('"+DtOS(stod('20'+cAnoAtu+cMesAtu+'01'))+"','YYYYMMDD')"	   
	cQryPEG  +=CRLF+"    and   bg9_filial = ' ' and d_E_L_E_T_ =' ' " 
	cQryPEG  +=CRLF+"    and bg9_codint ='0001' and bg9_codigo = codemp " 

    If  cOpcPes == 1 
	    cQryPEG  +=CRLF+"    and bg9_ytpemp = '2'  "
	ElseIf  cOpcPes == 2 
	    cQryPEG  +=CRLF+"    and bg9_ytpemp <> '2' "
    EndIf

	cQryPEG  +=CRLF+"  having (Sum(MENSA) > 0 or (Sum(APROVADO-PART)) > 0) "
	cQryPEG  +=CRLF+"  group by  codemp , Bg9.Bg9_Descri " 
	cQryPEG  +=CRLF+"  order by  ClasEmp , codemp "

TcQuery cQryPEG New Alias (cAliasPEG)  

(cAliasPEG)->(dbGoTop())    

While !(cAliasPEG)->(EOF())

        fconsId(1 , (cAliasPEG)->CodEmp)

        fcargComer(1 ,(cAliasPEG)->CodEmp) 

///// simistralidade por vendedor -- altamiro 29/09/2021

	/////////////
    aAdd(aRetPEG,{(cAliasPEG)->CodEmp +' - ' +(cAliasPEG)->Emp_1  ,;    //1
	              (cAliasPEG)->GRPSINIS                           ,;    //2
	              (cAliasPEG)->Mensal                             ,;    //3
                  (cAliasPEG)->Custo                              ,;    //4
                  ((cAliasPEG)->Resulta - nCargcom)                ,;    //5
                  ((((cAliasPEG)->Resulta - nCargcom) *100) /(cAliasPEG)->Mensal) ,;    //6
                  (cAliasPEG)->sinist                             ,;    //7
                   nMaId                                          ,;    //8
	               nQtdaAtv                                       ,;    //9
	               nQtdaBlq                                       ,;    //10
                   ((nQtdaAtv*100)/(nQtdaBlq+nQtdaAtv))           ,;    //11
	               nQtdatot                                       ,;    //12
                   nCargcom                                       ,;    //13
				   (cAliasPEG)->Resulta                           ,;    //14
				   ((cAliasPEG)->Resulta  * 100)  / (cAliasPEG)->Mensal ,; //15
				   (cAliasPEG)->VlrCfx                            ,;    //16
				   ((((cAliasPEG)->Resulta - nCargcom - (cAliasPEG)->VlrCfx ) *100) /(cAliasPEG)->Mensal),; //17
				   ((cAliasPEG)->Resulta - nCargcom - (cAliasPEG)->VlrCfx ) })    //18   

         CargcomTot:= CargcomTot + nCargcom
         QtdaAtvTot:= QtdaAtvtot + nQtdaAtv 
         QtdaBlqTot:= QtdaBlqTot + nQtdablq 
         QtdaVdTot := QtdaVdTot  + nQtdatot
         nTodResul := nTodResul  + (cAliasPEG)->Resulta
         nVlrCfxT  := nVlrCfxT   + (cAliasPEG)->VlrCfx

	(cAliasPEG)->(DbSkip())

EndDo
  
(cAliasPEG)->(DbCloseArea())

 fcargTot()
 
    aAdd(aRetPEG,{'T O T A I S    - - - >'                         ,;    //1
	              ' '                                              ,;    //2
	              (cAliasPEGT)->Mensal                             ,;    //3
                  (cAliasPEGT)->Custo                              ,;    //4
                  ((cAliasPEGT)->Resulta - CargcomTot)             ,;    //5
                  ((((cAliasPEGT)->Resulta - CargcomTot) *100) /(cAliasPEGT)->Mensal) ,; //6
                  (cAliasPEGT)->sinist                             ,;    //7
                   ''                                              ,;    //8
	               QtdaAtvTot                                      ,;    //9
	               QtdaBlqTot                                      ,;    //10
                   ((QtdaAtvTot*100)/(QtdaBlqTot + QtdaAtvTot))    ,;    //11
	               QtdaVdTot                                       ,;    //12
                   CargcomTot                                      ,;    //13
				   (cAliasPEGT)->Resulta                           ,;    //14
				   ((cAliasPEGT)->Resulta  * 100 ) / (cAliasPEGT)->Mensal ,;//15
				   nVlrCfxT                                        ,;    //16
				   ((((cAliasPEGT)->Resulta - CargcomTot - nVlrCfxT ) *100) /(cAliasPEGT)->Mensal) ,; //17
				   ((cAliasPEGT)->Resulta - CargcomTot - nVlrCfxT )})    //18   

If empty(aRetPEG)
	aAdd(aRetPEG,{'',;  //1
	              '',;  //2
				  0 ,;  //3
				  0 ,;  //4
				  0 ,;  //5
				  0 ,;  //6
				  0 ,;  //7
				  0 ,;  //8
				  0 ,;  //9
				  0 ,;  //10
				  0 ,;  //11
                  0 ,;  //12
				  0 ,;  //13
				  0 ,;  //14
				  0 ,;  //15
				  0 ,;  //16
				  0 ,;  //17
				  0 })  //18
EndIf

Return aRetPEG

/********************************************/
/********************************************/                                    
/***********************************************************************************/

static Function fRkAdm1()

local aLogLtaRk1:= {}
local cqueryRkS1:= ' '     

	cQueryRkS1  :=        " SELECT (CASE WHEN Codemp in ('0010','0404')  THEN  01  "   
    cQueryRkS1  +=CRLF+"                 WHEN Codemp in ('0149','0182','0282','0296') then 02 "
    cQueryRkS1  +=CRLF+"                 WHEN Codemp in ('0373','0394') then 03  "
    cQueryRkS1  +=CRLF+"                 WHEN Codemp in ('0220','0260','0274','0352','0375','0387') then 04 "
    cQueryRkS1  +=CRLF+"                 ELSE 99 END) ClasEmp  ,"
     
    cQueryRkS1  +=CRLF+"            codemp CodEmp , trim(Bg9.Bg9_Descri) Emp_1 , "
	
    cQueryRkS1  +=CRLF+"           (CASE WHEN Decode(Sum(MENSA),0,0,round((Sum(APROVADO-PART))/Sum(MENSA),6))*100 = 0 THEN            '0- Ideterminada' "
    cQueryRkS1  +=CRLF+"                 WHEN Decode(Sum(MENSA),0,0,round((Sum(APROVADO-PART))/Sum(MENSA),6))*100 BETWEEN 1 AND 65 THEN  '1-Até 65%'       "
	cQueryRkS1  +=CRLF+"                 WHEN Decode(Sum(MENSA),0,0,round((Sum(APROVADO-PART))/Sum(MENSA),6))*100 BETWEEN 66 AND 70 THEN '2-de 66 a 70%'   "
	cQueryRkS1  +=CRLF+"                 WHEN Decode(Sum(MENSA),0,0,round((Sum(APROVADO-PART))/Sum(MENSA),6))*100 BETWEEN 71 AND 80 THEN '3-de 71 a 80%'   "
	cQueryRkS1  +=CRLF+"                 ELSE                                    '4-acima de 80%' END) GRPSINIS  "

	If  cEmpCI=='I'
		cQueryRkS1 +=CRLF+" FROM COB_SINISTRALIDADE_MS_INT , bg9020 bg9  "
	Else
		cQueryRkS1 +=CRLF+" FROM COB_SINISTRALIDADE_MS_CAB , bg9010 bg9 "
	EndIf	             
		
	cQueryRkS1 +=CRLF+"  where MES_ANO_REF between TO_DATE('"+DtOS(stod('20'+cAnoAnt+cMesAnt+'01'))+"','YYYYMMDD') and TO_DATE('"+DtOS(stod('20'+cAnoAtu+cMesAtu+'01'))+"','YYYYMMDD')"	   
	cQueryRkS1 +=CRLF+"    and   bg9_filial = ' ' and d_E_L_E_T_ =' ' " 
	cQueryRkS1 +=CRLF+"    and bg9_codint ='0001' and bg9_codigo = codemp " 
     
    If  nGrpEmp1 == 1 
	    cQueryRkS1 +=CRLF+"    and bg9_ytpemp = '2'  "
	ElseIf  nGrpEmp1 == 2 
	    cQueryRkS1 +=CRLF+"    and bg9_ytpemp <> '2' "
    ElseIf  nGrpEmp1 == 3 
	    cQueryRkS1 +=CRLF+"    and bg9_codigo = '"+substr(aBrwPEG[oBrwPEG:nAt,1],1,4)+"' "
    EndIf

	cQueryRkS1 +=CRLF+"  having (Sum(MENSA) > 0 or (Sum(APROVADO-PART)) > 0) "
	cQueryRkS1 +=CRLF+"  group by  codemp , Bg9.Bg9_Descri " 
	cQueryRkS1 +=CRLF+"  order by ClasEmp , CodEmp "

		If Select((cAliasRkC1)) <> 0 
				(cAliasRkC1)->(DbCloseArea())  
		Endif                          

		TCQuery cQueryRkS1 New Alias (cAliasRkC1)   

		(cAliasRkC1)->( DbGoTop() )  

		While !(cAliasRkC1)->(EOF())

            fconsId(1 ,(cAliasRkC1)->codEmp ) 

			aAdd(aLogLtaRk1,{ (cAliasRkC1)->codEmp        ,; 
							trim((cAliasRkC1)->Emp_1)   ,;    //1
							(cAliasRkC1)->GRPSINIS      ,;
                             nMaId                      ,;
                             nQtdaAtv                   ,;
                             nQtdaBlq })     //3 
		
			(cAliasRkC1)->(DbSkip())

		EndDo

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Detalhe dp titulo de comisso                                             ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If  len(aLogLtaRk1) > 0

			PLSCRIGEN(aLogLtaRk1,{{'Cod Emp.',"@!",20}     ,;
								{'Administradora/Empresa',"@!",130}   ,;
								{'Classificações' ,"@!",50}    ,;
                                {'Idade (Meses)' ,"@!",30}    ,;
                                {'Vidas Ativas' ,"@!",30}     ,;
                                {'Vidas Bloqueadas' ,"@!",30}},;
								'Pesquisa por '+cTitPesq+' - Classificação por Sinistralidade',nil,nil) 
		Endif

Return()

static Function fRkAdm2()

local aLogLtaRk2:= {}
local cqueryRkS2:= ' '     
local nQtdVid   := 0  
local nSintot   := 0
local nCustTot  := 0
local nMensTot  := 0
local txretor   := 0
local nSinEmp   := 0
local nCustEmp  := 0
local nMensEmp  := 0

local cCodempad2:= ' '

	
    cQueryRkS2  :=        " SELECT (CASE WHEN Codemp in ('0010','0404')  THEN  01 "     
    cQueryRkS2  +=CRLF+"                 WHEN Codemp in ('0149','0182','0282','0296') then 02 "
    cQueryRkS2  +=CRLF+"                 WHEN Codemp in ('0373','0394') then 03 "
    cQueryRkS2  +=CRLF+"                 WHEN Codemp in ('0220','0260','0274','0352','0375','0387') then 04 "
    cQueryRkS2  +=CRLF+"                 ELSE 99 END) ClasEmp  , "
   
    cqueryRkS2 +=CRLF+"                  codemp CodEmp , Bg9.Bg9_Descri Emp , "
	cQueryRkS2 +=CRLF+"        '20'||substr(TO_char(MES_ANO_REF),7,2)||'/'||substr(TO_char(MES_ANO_REF),4,2) referencia ,"
	cQueryRkS2 +=CRLF+"        Sum(MENSA) mensal , MES_ANO_REF MES_ANO_REF , "
	cQueryRkS2 +=CRLF+"        Sum(APROVADO - PART) custo , "
	cQueryRkS2 +=CRLF+"        Decode(Sum(MENSA),0,0,round((Sum(APROVADO-PART))/Sum(MENSA),6))*100 sinist , "
	cQueryRkS2 +=CRLF+"        SUM(case when ( matric <> ' ' and MENSA > 0) THEN 1 ELSE 0 END) QTDAVID  , "

    cQueryRkS2  +=CRLF+"           (CASE WHEN Decode(Sum(MENSA),0,0,round((Sum(APROVADO-PART))/Sum(MENSA),6))*100 = 0 THEN            '0- Ideterminada' "
    cQueryRkS2  +=CRLF+"                 WHEN Decode(Sum(MENSA),0,0,round((Sum(APROVADO-PART))/Sum(MENSA),6))*100 BETWEEN 1 AND 65 THEN  '1-Até 65%'       "
	cQueryRkS2  +=CRLF+"                 WHEN Decode(Sum(MENSA),0,0,round((Sum(APROVADO-PART))/Sum(MENSA),6))*100 BETWEEN 66 AND 70 THEN '2-de 66 a 70%'   "
	cQueryRkS2  +=CRLF+"                 WHEN Decode(Sum(MENSA),0,0,round((Sum(APROVADO-PART))/Sum(MENSA),6))*100 BETWEEN 71 AND 80 THEN '3-de 71 a 80%'   "
	cQueryRkS2  +=CRLF+"                 ELSE                                    '4-acima de 80%' END) GRPSINIS  "

	If  cEmpCI=='I'
		cQueryRkS2+=CRLF+" FROM COB_SINISTRALIDADE_MS_INT , bg9020 bg9  "
	Else
		cQueryRkS2 +=CRLF+" FROM COB_SINISTRALIDADE_MS_CAB , bg9010 bg9 "
	EndIf	             
		
	cQueryRkS2 +=CRLF+"  where MES_ANO_REF between TO_DATE('"+DtOS(stod('20'+cAnoAnt+cMesAnt+'01'))+"','YYYYMMDD') and TO_DATE('"+DtOS(stod('20'+cAnoAtu+cMesAtu+'01'))+"','YYYYMMDD')"	   
	
	cQueryRkS2 +=CRLF+"    and bg9_filial = ' ' and d_E_L_E_T_ =' ' " 
	cQueryRkS2 +=CRLF+"    and bg9_codint ='0001' and bg9_codigo = codemp " 
	
	If  nGrpEmp1 == 1 
	    cQueryRkS2 +=CRLF+"    and bg9_ytpemp = '2'  "
	ElseIf  nGrpEmp1 == 2 
	    cQueryRkS2 +=CRLF+"    and bg9_ytpemp <> '2' "
    ElseIf  nGrpEmp1 == 3 
	    cQueryRkS2 +=CRLF+"    and bg9_codigo = '"+substr(aBrwPEG[oBrwPEG:nAt,1],1,4)+"' "
    EndIf
    
	cQueryRkS2 +=CRLF+"  having (Sum(MENSA) > 0 or (Sum(APROVADO-PART)) > 0) "
	
	//cQueryRkS2 +=CRLF+"    and bg9_ytpemp = '2' "
	//cQueryRkS2 +=CRLF+"  having Decode(Sum(MENSA),0,0,round((Sum(APROVADO-PART))/Sum(MENSA),6))*100 > 0 "
	cQueryRkS2 +=CRLF+"  group by  codemp , Bg9.Bg9_Descri , MES_ANO_REF" 
	cQueryRkS2 +=CRLF+"  order by 1,2,5 "


		If Select((cAliasRkC2)) <> 0 
				(cAliasRkC2)->(DbCloseArea())  
		Endif                          

		TCQuery cQueryRkS2 New Alias (cAliasRkC2)   

		(cAliasRkC2)->( DbGoTop() )  

		While !(cAliasRkC2)->(EOF())
		
            if cCodempad2 == ' '   
	        
			   cCodempad2 := TRIM((cAliasRkC2)->codEmp)
            
			ElseIf cCodempad2 != TRIM((cAliasRkC2)->codEmp)

		  	    cCodempad2 := TRIM((cAliasRkC2)->codEmp)
                nSinEmp    :=  (nCustEmp / nMensEmp )*100
                txretorEmp := ((nMensEmp - nCustEmp) / nMensEmp * 100)

                aAdd(aLogLtaRk2,{ ' '    ,; 
				    			  'Totais Empresa  --->'         ,;
					    		  ' '   ,;   
						          ' '   ,;
		           				  transform((nMensEmp),"@E 999,999,999.99") ,;
        						  transform((nCustEmp),"@E 999,999,999.99") ,;
                                  transform((txretorEmp),"@E 99,999.99")+'%' ,;
        						  transform((nSinEmp),"@E 99,999.99")+'%' ,;
	   					  	      ' ' })     //3 
 			nCustEmp  := 0.00 
			nMensEmp  := 0.00
            nSinEmp   := 0			

            EndIf 
              
              txretor:= (((cAliasRkC2)->mensal - (cAliasRkC2)->custo) / (cAliasRkC2)->mensal* 100)

			aAdd(aLogLtaRk2,{ TRIM((cAliasRkC2)->codEmp)    ,; 
							  trim((cAliasRkC2)->Emp)   ,;
							  trim(substr(dtos((cAliasRkC2)->MES_ANO_REF),1,4)+'/'+substr(dtos((cAliasRkC2)->MES_ANO_REF),5,2))   ,;   
						 transform(((cAliasRkC2)->QTDAVID),"@E 999,999") ,;
						 transform(((cAliasRkC2)->mensal),"@E 999,999,999.99") ,;
						 transform(((cAliasRkC2)->custo),"@E 999,999,999.99") ,;
                         transform(txretor,"@E 99,999.99")+'%' ,;
						 transform(((cAliasRkC2)->sinist),"@E 99,999.99")+'%' ,;
	   					  	      (cAliasRkC2)->GRPSINIS })     //3 
		
			nQtdVid   := nQtdVid  + (cAliasRkC2)->QTDAVID 
            nCustTot  := nCustTot + (cAliasRkC2)->custo 
			nMensTot  := nMensTot + (cAliasRkC2)->mensal

            nCustEmp  := nCustEmp + (cAliasRkC2)->custo 
			nMensEmp  := nMensEmp + (cAliasRkC2)->mensal

			(cAliasRkC2)->(DbSkip())

		EndDo

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Detalhe dp titulo de comisso                                             ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If  len(aLogLtaRk2) > 0

            nSintot    :=  (nCustTot / nMensTot )*100
            txretorTot := ((nMensTot - nCustTot) / nMensTot * 100)
            txretorEmp := ((nMensEmp - nCustEmp) / nMensEmp * 100)
            aAdd(aLogLtaRk2,{ ' '    ,; 
				    		  'Totais Empresa  --->' ,;
					    	  ' '   ,;   
						      ' '   ,;
		           			  transform((nMensEmp),"@E 999,999,999.99") ,;
        					  transform((nCustEmp),"@E 999,999,999.99") ,;
                              transform((txretorEmp),"@E 99,999.99")+'%' ,;
        					  transform((nSinEmp),"@E 99,999.99")+'%' ,;
	   					  	  ' ' })     //3 

			aAdd(aLogLtaRk2,{ ' '    ,; 
							  ' '    ,;
							  ' '    ,;   
   						      ' '    ,;
 						      ' '    ,;
						      ' '    ,;
                              ' '    ,;
						      ' '    ,;
	   					  	  ' '    })     //3

			aAdd(aLogLtaRk2,{ ' '   ,; 
							  'Totais   --->' ,;
							  ' '   ,;   
						      ' '   ,;
						 transform((nMensTot),"@E 999,999,999.99") ,;
						 transform((nCustTot),"@E 999,999,999.99") ,;
                         transform((txretorTot),"@E 99,999.99")+'%' ,;
						 transform((nSintot),"@E 99,999.99")+'%' ,;
	   					  	  ' ' })     //3 

			PLSCRIGEN(aLogLtaRk2,{{'Cod Emp.',"@!",20}     ,;
								  {'Administradora/Empresa',"@!",120} ,;
								  {'Referencia' ,"@!",30} ,;
								  {'Qtda Lanç.' ,"@!",30} ,;
							   	  {'Receita' ,"@!",30} ,;
                                  {'Custo' ,"@!",30} ,;
								  {'Tx Retorno' ,"@!",30} ,;
                                  {'Sinistralidade' ,"@!",50} ,;
								  {'Classificações' ,"@!",50} },;
  								   'Pesquisa por '+cTitPesq+' - Sinistralidade Faturamento X Custo',nil,nil) 
		Endif
		
Return()

static Function fRkAdm3()

local aLogLtaRk3:= {}
local cqueryRkS3:= ' '     

local nCustTot  := 0
local nMensTot  := 0
local nResulTot := 0



    cQueryRkS3  :=        " SELECT (CASE WHEN Codemp in ('0010','0404')  THEN  01 "     
    cQueryRkS3  +=CRLF+"                 WHEN Codemp in ('0149','0182','0282','0296') then 02 "
    cQueryRkS3  +=CRLF+"                 WHEN Codemp in ('0373','0394') then 03 "
    cQueryRkS3  +=CRLF+"                 WHEN Codemp in ('0220','0260','0274','0352','0375','0387') then 04 "
    cQueryRkS3  +=CRLF+"                 ELSE 99 END) ClasEmp  , "

	cQueryRkS3 += CRLF+"       codemp CodEmp , Bg9.Bg9_Descri Emp , 
	cQueryRkS3 += CRLF+"       Sum(MENSA) mensal ,
	cQueryRkS3 +=CRLF+"        Sum(APROVADO - PART) custo, 
	cQueryRkS3 +=CRLF+"        Sum(MENSA) - Sum(APROVADO-PART) result "
     
    If  cEmpCI=='I'
		cQueryRkS3 +=CRLF +" FROM COB_SINISTRALIDADE_MS_INT , bg9020 bg9  "
	Else
		cQueryRkS3 +=CRLF +" FROM COB_SINISTRALIDADE_MS_CAB , bg9010 bg9 "
	EndIf	             
		
	cQueryRkS3 +=CRLF+"  where MES_ANO_REF between TO_DATE('"+DtOS(stod('20'+cAnoAnt+cMesAnt+'01'))+"','YYYYMMDD') and TO_DATE('"+DtOS(stod('20'+cAnoAtu+cMesAtu+'01'))+"','YYYYMMDD')"	   
	
	cQueryRkS3 +=CRLF+"    and bg9_filial = ' ' and d_E_L_E_T_ =' ' " 
	cQueryRkS3 +=CRLF+"    and bg9_codint ='0001' and bg9_codigo = codemp " 
	
	If  nGrpEmp1 == 1 
	    cQueryRkS3 +=CRLF+"    and bg9_ytpemp = '2'  "
	ElseIf  nGrpEmp1 == 2 
	    cQueryRkS3 +=CRLF+"    and bg9_ytpemp <> '2' "
    ElseIf  nGrpEmp1 == 3 
        cQueryRkS3 +=CRLF+"    and bg9_codigo = '"+substr(aBrwPEG[oBrwPEG:nAt,1],1,4)+"' "
    EndIf
	cQueryRkS3 +=CRLF+"  having (Sum(MENSA) > 0 or (Sum(APROVADO-PART)) > 0) "
	//cQueryRkS3 +=CRLF+"    and bg9_ytpemp = '2' "
    //cQueryRkS3 +=CRLF+"  having Decode(Sum(MENSA),0,0,round((Sum(APROVADO-PART))/Sum(MENSA),6))*100 > 0 "
    cQueryRkS3 +=CRLF+"  group by  codemp , Bg9.Bg9_Descri " 
	cQueryRkS3 +=CRLF+"  order by 1,2 ,3 "

	If Select((cAliasRkC3)) <> 0 
				(cAliasRkC3)->(DbCloseArea())  
	Endif                          

	TCQuery cQueryRkS3 New Alias (cAliasRkC3)   

	(cAliasRkC3)->( DbGoTop() )  

	While !(cAliasRkC3)->(EOF())

        txretor:= (((cAliasRkC3)->mensal - (cAliasRkC3)->custo) / (cAliasRkC3)->mensal* 100)

			aAdd(aLogLtaRk3,{ TRIM((cAliasRkC3)->codEmp)    ,; 
							  trim((cAliasRkC3)->Emp)   ,;   
						 transform(((cAliasRkC3)->mensal),"@E 999,999,999.99") ,;
						 transform(((cAliasRkC3)->custo),"@E 999,999,999.99") ,;
						 transform(((cAliasRkC3)->Result),"@E 999,999,999.99"),;
                         transform((txretor),"@E 99,999.99")+'%' })     //3 

 			nCustTot  := nCustTot + (cAliasRkC3)->custo
 			nMensTot  := nMensTot + (cAliasRkC3)->mensal 
            nResulTot := nResulTot + (cAliasRkC3)->Result

			(cAliasRkC3)->(DbSkip())

		EndDo

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Detalhe dp titulo de comisso                                             ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If  len(aLogLtaRk3) > 0

        txretorTot:= ((nMensTot - nCustTot) / nMensTot* 100)
		aAdd(aLogLtaRk3,{ ' ' ,; 
						  'Totais    ---> '	     ,;   
						 transform(nMensTot,"@E 999,999,999.99") ,;
						 transform(nCustTot,"@E 999,999,999.99") ,;
						 transform(nResulTot,"@E 999,999,999.99"),;
                         transform((txretorTot),"@E 99,999.99")+'%' })     //3

			PLSCRIGEN(aLogLtaRk3,{{'Cod Emp.',"@!",20}     ,;
								  {'Administradora/Empresa',"@!",120} ,;
							   	  {'Receita' ,"@!",30}    ,;
                                  {'Custo' ,"@!",30}          ,;
								  {'Resultado' ,"@!",50}      ,;
                                  {'Tx Retorno' ,"@!",50}}    ,;
								   'Pesquisa por '+cTitPesq+' - Resultado Financeiro Empresa',nil,nil) 
		Endif

Return()

static Function fRkAdm4()

local aLogLtaRk4:= {}
local cqueryRkS4:= ' '     
local nCustEmp  := 0.00 
local nMensEmp  := 0.00
local nResult   := 0.00		
local nCustEmpT  := 0.00 
local nMensEmpT  := 0.00
local nResultT   := 0.00	

local cCodempad4:= ' ' 

    cQueryRkS4  :=        " SELECT (CASE WHEN Codemp in ('0010','0404')  THEN  01 "     
    cQueryRkS4  +=CRLF+"                 WHEN Codemp in ('0149','0182','0282','0296') then 02 "
    cQueryRkS4  +=CRLF+"                 WHEN Codemp in ('0373','0394') then 03 "
    cQueryRkS4  +=CRLF+"                 WHEN Codemp in ('0220','0260','0274','0352','0375','0387') then 04 "
    cQueryRkS4  +=CRLF+"                 ELSE 99 END) ClasEmp  , "
	
    cQueryRkS4 += CRLF+"       codemp CodEmp , Bg9.Bg9_Descri Emp , nvl(BQC_DESCRI,'Lançamento a Nivel da Empresa') GRPEMP , "
    cQueryRkS4 += CRLF+"       Sum(MENSA) mensal , "
	cQueryRkS4 += CRLF+"       Sum(APROVADO - PART) custo, "
	cQueryRkS4 += CRLF+"       Sum(MENSA) - Sum(APROVADO-PART) result "
     
    If  cEmpCI=='I'
		cQueryRkS4 +=CRLF +" FROM COB_SINISTRALIDADE_MS_INT , bg9020 bg9 , bqc020 bqc   "
	Else
		cQueryRkS4 +=CRLF +" FROM COB_SINISTRALIDADE_MS_CAB , bg9010 bg9 , bqc010 bqc "
	EndIf	             
		
	cQueryRkS4 +=CRLF+"  where MES_ANO_REF between TO_DATE('"+DtOS(stod('20'+cAnoAnt+cMesAnt+'01'))+"','YYYYMMDD') and TO_DATE('"+DtOS(stod('20'+cAnoAtu+cMesAtu+'01'))+"','YYYYMMDD')"	   
	
	cQueryRkS4 +=CRLF+"    and bg9_filial    = ' ' and bg9.d_E_L_E_T_ =' ' "
    cQueryRkS4 +=CRLF+"    and bqc_filial(+) = ' ' and bqc.d_E_L_E_T_(+) = ' ' " 
	cQueryRkS4 +=CRLF+"    and bg9_codint ='0001' and bg9_codigo = codemp " 
	
	If  nGrpEmp1 == 1 
	    cQueryRkS4 +=CRLF+"    and bg9_ytpemp = '2'  "
	ElseIf  nGrpEmp1 == 2 
	    cQueryRkS4 +=CRLF+"    and bg9_ytpemp <> '2' "
    ElseIf  nGrpEmp1 == 3 
	    cQueryRkS4 +=CRLF+"    and bg9_codigo = '"+substr(aBrwPEG[oBrwPEG:nAt,1],1,4)+"' "
    EndIf
		//cQueryRkS4 +=CRLF+"    and bg9_ytpemp = '2' "

    cQueryRkS4 += CRLF+"   and bqc_codigo(+) = '0001'||codemp
    cQueryRkS4 += CRLF+"   AND BQC_NUMCON(+) = CONTRATO 
    cQueryRkS4 += CRLF+"   AND BQC_SUBCON(+) = SUBCONTRATO
//    cQueryRkS4 += CRLF+"having Decode(Sum(MENSA),0,0,round((Sum(APROVADO-PART))/Sum(MENSA),6))*100 > 0

    cQueryRkS4 +=CRLF+"  having (Sum(MENSA) > 0 or (Sum(APROVADO-PART)) > 0) "

	cQueryRkS4 +=CRLF+"  group by  codemp , Bg9.Bg9_Descri , BQC_DESCRI  " 
	cQueryRkS4 +=CRLF+"  order by 1,2,3 "

	If Select((cAliasRkC4)) <> 0 
				(cAliasRkC4)->(DbCloseArea())  
	Endif                          

	TCQuery cQueryRkS4 New Alias (cAliasRkC4)   

	(cAliasRkC4)->( DbGoTop() )  

	While !(cAliasRkC4)->(EOF())

        if cCodempad4 == ' '   
	        
     	   cCodempad4 := TRIM((cAliasRkC4)->codEmp)
            
		ElseIf cCodempad4 != TRIM((cAliasRkC4)->codEmp)

			cCodempad4 := TRIM((cAliasRkC4)->codEmp)
            nSinEmp   :=  (nCustEmp / nMensEmp )*100
            txretorEmp:= ((nMensEmp - nCustEmp ) / nMensEmp* 100)

            aAdd(aLogLtaRk4,{ ' '    ,; 
				    		  'Totais Empresa  --->'         ,;
					    	  ' '   ,;   
		           			  transform((nMensEmp),"@E 999,999,999.99") ,;
        					  transform((nCustEmp),"@E 999,999,999.99") ,;
        					  transform((nResult ),"@E 999,999,999.99") ,;
                              transform((txretorEmp),"@E 99,999.99")+'%' })     //3 
 			nCustEmp  := 0.00 
			nMensEmp  := 0.00
            nResult   := 0.00			

        EndIf 
            txretor:= (((cAliasRkC4)->mensal - (cAliasRkC4)->custo) / (cAliasRkC4)->mensal* 100)
			aAdd(aLogLtaRk4,{ TRIM((cAliasRkC4)->codEmp)    ,; 
							  trim((cAliasRkC4)->Emp)       ,; 
							  trim((cAliasRkC4)->GRPEMP)    ,;  
						 transform(((cAliasRkC4)->mensal),"@E 999,999,999.99") ,;
						 transform(((cAliasRkC4)->custo ),"@E 999,999,999.99") ,;
						 transform(((cAliasRkC4)->Result),"@E 999,999,999.99") ,;
                         transform((txretor),"@E 99,999.99")+'%'  })     //3 
		
			nCustEmp  := nCustEmp + (cAliasRkC4)->custo
			nMensEmp  := nMensEmp + (cAliasRkC4)->mensal
            nResult   := nResult  + (cAliasRkC4)->Result			
            
			nCustEmpT  := nCustEmpT + (cAliasRkC4)->custo
			nMensEmpT  := nMensEmpT + (cAliasRkC4)->mensal
            nResultT   := nResultT  + (cAliasRkC4)->Result				
			
			(cAliasRkC4)->(DbSkip())

		EndDo

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Detalhe dp titulo de comisso                                             ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If  len(aLogLtaRk4) > 0
            txretorEmp:= ((nMensEmp - nCustEmp ) / nMensEmp* 100)
		    aAdd(aLogLtaRk4,{ ' '    ,; 
				    		  'Totais Empresa  --->' ,;
					    	  ' '   ,;   
		           			  transform((nMensEmp),"@E 999,999,999.99") ,;
        					  transform((nCustEmp),"@E 999,999,999.99") ,;
        					  transform((nResult ),"@E 999,999,999.99") ,;
                              transform((txretorEmp),"@E 99,999.99")+'%'})     //3

            aAdd(aLogLtaRk4,{ ' '    ,; 
				    		  '----' ,;
					    	  ' '   ,;   
		           			  ' ' ,;
        					  ' ' ,;
        					  ' ' ,;
                              ' ' })     //3
            txretorTot:= ((nMensEmpt - nCustEmpt ) / nMensEmpt* 100)
		    aAdd(aLogLtaRk4,{ ' '    ,; 
				    		  'Totais   --->' ,;
					    	  ' '   ,;   
		           			  transform((nMensEmpT),"@E 999,999,999.99") ,;
        					  transform((nCustEmpT),"@E 999,999,999.99") ,;
        					  transform((nResultT ),"@E 999,999,999.99") ,;
                              transform((txretorTot),"@E 99,999.99")+'%'})     //3

			PLSCRIGEN(aLogLtaRk4,{{'Cod Emp.',"@!",20}     ,;
								  {'Administradora/Empresa',"@!",120} ,;
								  {'Grupo de Empresa',"@!",120} ,;
							   	  {'Receita' ,"@!",30} ,;
                                  {'Custo' ,"@!",30} ,;
								  {'Resultado' ,"@!",50},;
                                  {'Tx Retorno',"@!",30}},;
								   'Pesquisa por '+cTitPesq+' - Resultado Financeiro Grp.Empresa',nil,nil) 
		Endif

Return()

static Function fRkAdm5()

local aLogLtaRk5:= {}
local cqueryRkS5:= ' '     
local nCustEmp   := 0.00 
local nMensEmp   := 0.00
local nResult    := 0.00
local nComis     := 0.00		
local nCustEmpT  := 0.00 
local nMensEmpT  := 0.00
local nResultT   := 0.00
local nResultE   := 0.00
local nComisT    := 0.00	
local nReultaL   := 0.00


local cCodempad5 := ' ' 

    cQueryRkS5  :=        " SELECT (CASE WHEN Codemp in ('0010','0404')  THEN  01 "     
    cQueryRkS5  +=CRLF+"                 WHEN Codemp in ('0149','0182','0282','0296') then 02 "
    cQueryRkS5  +=CRLF+"                 WHEN Codemp in ('0373','0394') then 03 "
    cQueryRkS5  +=CRLF+"                 WHEN Codemp in ('0220','0260','0274','0352','0375','0387') then 04 "
    cQueryRkS5  +=CRLF+"                 ELSE 99 END) ClasEmp  , "

    cQueryRkS5 += CRLF+"       codemp CodEmp , "
    cQueryRkS5 += CRLF+"       emp.Emp Emp ,  "
	cQueryRkS5 += CRLF+"       nvl(emp.GRPEMP,'Lançamento a Nivel da Empresa') GRPEMP , "
    cQueryRkS5 += CRLF+"       emp.mensal mensal , "
    cQueryRkS5 += CRLF+"       emp.custo , "
    cQueryRkS5 += CRLF+"       nvl(bxq1.totcom,0)  totcom1 , "
    cQueryRkS5 += CRLF+"       emp.resulta - nvl(bxq1.totcom,0) resulta "
    cQueryRkS5 += CRLF+"  FROM (SELECT codemp CodEmp ," 
    cQueryRkS5 += CRLF+"               Bg9.Bg9_Descri Emp ,"  
    cQueryRkS5 += CRLF+"               BQC_DESCRI GRPEMP , "
    cQueryRkS5 += CRLF+"               BQC_NUMCON NUMCON , "
    cQueryRkS5 += CRLF+"               BQC_SUBCON SUBCON , "
    cQueryRkS5 += CRLF+"               Sum(MENSA) mensal , " 
    cQueryRkS5 += CRLF+"               Sum(APROVADO - PART) custo ,"
    cQueryRkS5 += CRLF+"                Sum(MENSA) - Sum(APROVADO-PART) resulta "
    cQueryRkS5 += CRLF+"          FROM COB_SINISTRALIDADE_MS_INT , bg9020 bg9 , bqc020 bqc "
    cQueryRkS5 += CRLF+"         where MES_ANO_REF between TO_DATE('"+DtOS(stod('20'+cAnoAnt+cMesAnt+'01'))+"','YYYYMMDD') and TO_DATE('"+DtOS(stod('20'+cAnoAtu+cMesAtu+'01'))+"','YYYYMMDD')"	   
    cQueryRkS5 += CRLF+"           and bg9_filial = ' ' and bg9.d_E_L_E_T_ = ' ' "
    cQueryRkS5 += CRLF+"           and bqc_filial(+) = ' ' and bqc.d_E_L_E_T_(+) = ' ' "
    cQueryRkS5 += CRLF+"           and bg9_codint = '0001' " 
	cQueryRkS5 += CRLF+"           and bg9_codigo = codemp "

	If  nGrpEmp1 == 1 
	    cQueryRkS5 +=CRLF+"    and bg9_ytpemp = '2'  "
	ElseIf  nGrpEmp1 == 2 
	    cQueryRkS5 +=CRLF+"    and bg9_ytpemp <> '2' "
    ElseIf  nGrpEmp1 == 3 
	    cQueryRkS5 +=CRLF+"    and bg9_codigo = '"+substr(aBrwPEG[oBrwPEG:nAt,1],1,4)+"' "
    EndIf
	
    cQueryRkS5 += CRLF+"           and bqc_codigo(+) = '0001'||codemp " 
    cQueryRkS5 += CRLF+"           AND BQC_NUMCON(+) = CONTRATO "
    cQueryRkS5 += CRLF+"           AND BQC_SUBCON(+) = SUBCONTRATO "
    //cQueryRkS5 += CRLF+"        having Decode(Sum(MENSA),0,0,round((Sum(APROVADO-PART))/Sum(MENSA),6))*100 > 0 " 
    cQueryRkS5 +=CRLF+"  having (Sum(MENSA) > 0 or (Sum(APROVADO-PART)) > 0) "
	cQueryRkS5 += CRLF+"      group by codemp , Bg9.Bg9_Descri , BQC_DESCRI , BQC_NUMCON , BQC_SUBCON )emp , " 
    cQueryRkS5 += CRLF+"       (select bxq_codemp codbxq ," 
    cQueryRkS5 += CRLF+"               bxq_numcon conbxq ," 
    cQueryRkS5 += CRLF+"               bxq_subcon subbxq ," 
    cQueryRkS5 += CRLF+"               Bg9.Bg9_Descri Emp ,"  
    cQueryRkS5 += CRLF+"               SUM(BXQ_VLRCOM) totcom "
    cQueryRkS5 += CRLF+"          from BXQ020 BXQ , bg9020 bg9 "
    cQueryRkS5 += CRLF+"         WHERE BXQ_FILIAL = ' ' AND bxq.D_e_l_e_t_ = ' ' "
    cQueryRkS5 += CRLF+"           and bg9_filial = ' ' and bg9.d_E_L_E_T_ = ' ' "
    cQueryRkS5 += CRLF+"           and bg9_codint = '0001' "
    cQueryRkS5 += CRLF+"           and bg9_codigo = bxq_codemp "
	
	If  nGrpEmp1 == 1 
	    cQueryRkS5 +=CRLF+"    and bg9_ytpemp = '2'  "
	ElseIf  nGrpEmp1 == 2 
	    cQueryRkS5 +=CRLF+"    and bg9_ytpemp <> '2' "
    ElseIf  nGrpEmp1 == 3 
	    cQueryRkS5 +=CRLF+"    and bg9_codigo = '"+substr(aBrwPEG[oBrwPEG:nAt,1],1,4)+"' "
    EndIf
	
    cQueryRkS5 += CRLF+"           and (bxq_numcon <> ' ' or bxq_subcon <> ' ') "
    cQueryRkS5 += CRLF+"           AND BXQ_REFERE = BXQ_PAGCOM "
    cQueryRkS5 += CRLF+"           and bxq_ano||bxq_mes >= '20"+cAnoAnt+cMesAnt+"'"   
    cQueryRkS5 += CRLF+"           and bxq_ano||bxq_mes <= '20"+cAnoAtu+cMesAtu+"'" 
	cQueryRkS5 += CRLF+"      GROUP BY bxq_codemp ,  bxq_numcon , bxq_subcon , Bg9.Bg9_Descri) bxq1 " 
    cQueryRkS5 += CRLF+"         where emp.NUMCON = bxq1.conbxq(+) "
    cQueryRkS5 += CRLF+"           and emp.subCON = bxq1.subbxq(+) "
    cQueryRkS5 += CRLF+"           and emp.CodEmp = bxq1.codbxq(+) "
    
    cQueryRkS5 += CRLF+"        and (emp.mensal > 0 Or emp.custo > 0) "
	
    cQueryRkS5 += CRLF+"      union all "
    
    cQueryRkS5  +=CRLF+" SELECT (CASE WHEN bxq_codemp in ('0010','0404')  THEN  01 "     
    cQueryRkS5  +=CRLF+"                 WHEN bxq_codemp in ('0149','0182','0282','0296') then 02 "
    cQueryRkS5  +=CRLF+"                 WHEN bxq_codemp in ('0373','0394') then 03 "
    cQueryRkS5  +=CRLF+"                 WHEN bxq_codemp in ('0220','0260','0274','0352','0375','0387') then 04 "
    cQueryRkS5  +=CRLF+"                 ELSE 99 END) ClasEmp  , "
	cQueryRkS5 += CRLF+"                bxq_codemp CodEmp  , "
    cQueryRkS5 += CRLF+"               Bg9.Bg9_Descri Emp , "
    cQueryRkS5 += CRLF+"               'Lanc. Comissão Deb/Cred' GRPEMP ," 
    cQueryRkS5 += CRLF+"               0.00 mensal,"
    cQueryRkS5 += CRLF+"               0.00 custo ,"
    cQueryRkS5 += CRLF+"               SUM(BXQ_VLRCOM) totcom1 , "
    cQueryRkS5 += CRLF+"               SUM(BXQ_VLRCOM ) "
    cQueryRkS5 += CRLF+"          from BXQ020 BXQ , bg9020 bg9 "
    cQueryRkS5 += CRLF+"         WHERE BXQ_FILIAL = ' ' AND bxq.D_e_l_e_t_ = ' '  "
    cQueryRkS5 += CRLF+"           and bg9_filial = ' ' and bg9.d_E_L_E_T_ = ' '  "
    cQueryRkS5 += CRLF+"           and bg9_codint = '0001' " 
    cQueryRkS5 += CRLF+"           and bg9_codigo = bxq_codemp "
	
	If  nGrpEmp1 == 1 
	    cQueryRkS5 +=CRLF+"    and bg9_ytpemp = '2'  "
	ElseIf  nGrpEmp1 == 2 
	    cQueryRkS5 +=CRLF+"    and bg9_ytpemp <> '2' "
    ElseIf  nGrpEmp1 == 3 
	    cQueryRkS5 +=CRLF+"    and bg9_codigo = '"+substr(aBrwPEG[oBrwPEG:nAt,1],1,4)+"' "
    EndIf
	
    cQueryRkS5 += CRLF+"           and (bxq_numcon = ' ' or bxq_subcon = ' ') "
    cQueryRkS5 += CRLF+"           AND BXQ_REFERE = BXQ_PAGCOM "
    cQueryRkS5 += CRLF+"           and bxq_ano||bxq_mes >= '20"+cAnoAnt+cMesAnt+"'" 
    cQueryRkS5 += CRLF+"           and bxq_ano||bxq_mes <= '20"+cAnoAtu+cMesAtu+"'" 
    cQueryRkS5 += CRLF+"      GROUP BY bxq_codemp ,  bxq_numcon , bxq_subcon , Bg9.Bg9_Descri "

cQueryRkS5 += CRLF+"      union all "

    cQueryRkS5 +=CRLF+"SELECT (CASE WHEN bg9_codigo in ('0010','0404')  THEN  01 "
    cQueryRkS5 +=CRLF+"             WHEN bg9_codigo   in ('0149','0182','0282','0296') then 02 "
    cQueryRkS5 +=CRLF+"             WHEN bg9_codigo   in ('0373','0394') then 03 "
    cQueryRkS5 +=CRLF+"             WHEN bg9_codigo   in ('0220','0260','0274','0352','0375','0387') then 04 "
    cQueryRkS5 +=CRLF+"             ELSE 99 END) ClasEmp , " 
    cQueryRkS5 +=CRLF+"       pdu_codemp CodEmp  , "
    cQueryRkS5 +=CRLF+"       Bg9.Bg9_Descri Emp , "
    cQueryRkS5 +=CRLF+"      'Comissão Colaborador ' GRPEMP , "
    cQueryRkS5 +=CRLF+"       0.00 mensal, "
    cQueryRkS5 +=CRLF+"       0.00 custo , "
    cQueryRkS5 +=CRLF+"       SUM(pdu_vlrpgt) totcom1 , "
    cQueryRkS5 +=CRLF+"       SUM(pdu_vlrpgt) "
    cQueryRkS5 +=CRLF+"  from pdu010 pdu , bg9020 bg9 "
    cQueryRkS5 +=CRLF+" WHERE PDU_FILIAL = ' ' AND PDU.D_e_l_e_t_ = ' ' "
    cQueryRkS5 +=CRLF+"   and bg9_filial = ' ' and bg9.d_E_L_E_T_ = ' ' "  
    cQueryRkS5 +=CRLF+"   and bg9_codint = '0001' "
    cQueryRkS5 +=CRLF+"   and bg9_codigo = pdu_codemp " 
	
	If  nGrpEmp1 == 1 
	    cQueryRkS5 +=CRLF+"    and bg9_ytpemp = '2'  "
	ElseIf  nGrpEmp1 == 2 
	    cQueryRkS5 +=CRLF+"    and bg9_ytpemp <> '2' "
    ElseIf  nGrpEmp1 == 3 
	    cQueryRkS5 +=CRLF+"    and bg9_codigo = '"+substr(aBrwPEG[oBrwPEG:nAt,1],1,4)+"' "
    EndIf

    cQueryRkS5 +=CRLF+"        AND pdu_pgto = 'S' "
    cQueryRkS5 +=CRLF+"        and PDU_COMPTE  >= '20"+cAnoAnt+cMesAnt+"'"
    cQueryRkS5 +=CRLF+"        and PDU_COMPTE  <= '20"+cAnoAtu+cMesAtu+"'"
    cQueryRkS5 +=CRLF+"   GROUP BY bg9_codigo ,  pdu_codemp , Bg9.Bg9_Descri "  

    cQueryRkS5 += CRLF+"      order by 1,2,3 "

	////////////////////////////////

	If Select((cAliasRkC5)) <> 0 
			 (cAliasRkC5)->(DbCloseArea())  
	Endif                          

	TCQuery cQueryRkS5 New Alias (cAliasRkC5)   

	(cAliasRkC5)->( DbGoTop() )  

	While !(cAliasRkC5)->(EOF())

        if cCodempad5 == ' '   
	        
     	   cCodempad5 := TRIM((cAliasRkC5)->codEmp)
            
		ElseIf cCodempad5 != TRIM((cAliasRkC5)->codEmp)

			cCodempad5 := TRIM((cAliasRkC5)->codEmp)
            
			nSinEmp   :=  (nCustEmp / nMensEmp )*100

            txretorEmp:= ((nMensEmp - (nCustEmp+nComis )) / nMensEmp * 100)
            
            aAdd(aLogLtaRk5,{ ' '    ,; 
				    		  'Totais Empresa  --->'         ,;
					    	  ' '   ,;   
		           			  transform((nMensEmp),"@E 999,999,999.99") ,;
        					  transform((nCustEmp),"@E 999,999,999.99") ,;
							  transform((nComis)  ,"@E 999,999,999.99") ,;
        					  transform((nResulte ),"@E 999,999,999.99"),;
                              transform((txretorEmp),"@E 99,999.99")+'%' })     //3 
 			
			nCustEmp  := 0.00 
			nMensEmp  := 0.00
            nResultE  := 0.00
			nResult   := 0.00			
            nComis    := 0.00

        EndIf 
            txretor:= (((cAliasRkC5)->mensal - ((cAliasRkC5)->custo +(cAliasRkC5)->totcom1 )) / (cAliasRkC5)->mensal * 100)
			nReultaL:= ((cAliasRkC5)->mensal - ((cAliasRkC5)->custo +(cAliasRkC5)->totcom1 )) 
			aAdd(aLogLtaRk5,{ TRIM((cAliasRkC5)->codEmp)    ,; 
							  trim((cAliasRkC5)->Emp)      ,; 
							  trim((cAliasRkC5)->GRPEMP)      ,;  
						 transform(((cAliasRkC5)->mensal),"@E 999,999,999.99") ,;
						 transform(((cAliasRkC5)->custo),"@E 999,999,999.99") ,;
						 transform(((cAliasRkC5)->totcom1),"@E 999,999,999.99") ,;
						 transform(nReultaL,"@E 999,999,999.99") ,;
                         transform((txretor),"@E 99,999.99")+'%' })     //3 
		
				nCustEmp   := nCustEmp  + (cAliasRkC5)->custo
				nMensEmp   := nMensEmp  + (cAliasRkC5)->mensal
				nResult    := nResult   + (cAliasRkC5)->Resulta
				nComis     := nComis	+ (cAliasRkC5)->totcom1

				nCustEmpT  := nCustEmpT + (cAliasRkC5)->custo 
				nMensEmpT  := nMensEmpT + (cAliasRkC5)->mensal
				nResultE   := nResulte  + nReultaL
				nResultTt  := nResultT  + (cAliasRkC5)->Resulta
				nComisT    := nComisT	+ (cAliasRkC5)->totcom1

			(cAliasRkC5)->(DbSkip())

    EndDo

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Detalhe dp titulo de comisso                                             ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If  len(aLogLtaRk5) > 0
            txretorEmp:= ((nMensEmp - (nCustEmp+nComis )) / nMensEmp * 100)
            aAdd(aLogLtaRk5,{ ' '    ,; 
				    		  'Totais Empresa  --->'         ,;
					    	  ' '   ,;   
		           			  transform((nMensEmp),"@E 999,999,999.99") ,;
        					  transform((nCustEmp),"@E 999,999,999.99") ,;
							  transform((nComis)  ,"@E 999,999,999.99") ,;
        					  transform((nResultE ),"@E 999,999,999.99") ,;
                              transform((txretorEmp),"@E 99,999.99")+'%'})     //3 
 			
            aAdd(aLogLtaRk5,{ ' ' ,; 
				    		  '---'  ,;
					    	  ' ' ,;   
		           			  ' ' ,;
        					  ' ' ,;
							  ' ' ,;
        					  ' ' ,;
                              ' ' })     //3 
 			txretorTOT:= ((nMensEmpt - (nCustEmpT+nComisT )) / nMensEmpT * 100)
            aAdd(aLogLtaRk5,{ ' '    ,; 
				    		  'Totais   --->'         ,;
					    	  ' '   ,;   
		           			  transform((nMensEmpT),"@E 999,999,999.99") ,;
        					  transform((nCustEmpT),"@E 999,999,999.99") ,;
							  transform((nComisT)  ,"@E 999,999,999.99") ,;
        					  transform(((nMensEmpT-nCustEmpT-nComisT)) ,"@E 999,999,999.99"),;
                              transform((txretorTot),"@E 99,999.99")+'%' })     //3
							  //transform((nResulTT) ,"@E 999,999,999.99") })     //3

			PLSCRIGEN(aLogLtaRk5,{{'Cod Emp.',"@!",20}     ,;
								  {'Administradora/Empresa',"@!",120} ,;
								  {'Grupo de Empresa',"@!",120} ,;
							   	  {'Receita' ,"@!",30} ,;
                                  {'Custo' ,"@!",30} ,;
								  {'Comissão' ,"@!",30} ,;
                                  {'Resultado' ,"@!",50},;
								  {'Tx Retorno' ,"@!",50}},;
								   'Pesquisa por '+cTitPesq+' - Resultado Financeiro Grp Empresa com Comissão',nil,nil) 
		Endif
		

Return()

static function fconsId(nProc, cCodEmp)

nMaId    := 0
nQtdaAtv := 0
nQtdaBlq := 0
nQtdatot := 0
//TO_DATE('"+DtOS(stod('20'+cAnoAtu+cMesAtu+'01'))+"','YYYYMMDD')

//cQueryDem:=        " select nvl(trunc(mod(months_between(trunc(DECODE(TO_DATE(TRIM(BQC_DATBLO),'YYYYMMDD'), NULL, TRUNC(SYSDATE) ,TO_DATE(TRIM(BQC_DATBLO),'YYYYMMDD'))),trunc(TO_DATE(TRIM(BQC_DATCON),'YYYYMMDD'))), 999),0),0)+1 MESES ,"
cQueryDem:=        " select nvl(trunc(mod(months_between(trunc(DECODE(TO_DATE(TRIM(BQC_DATBLO),'YYYYMMDD'), NULL, TRUNC(TO_DATE('"+DtOS(stod('20'+cAnoAtu+cMesAtu+'01'))+"','YYYYMMDD')) ,TO_DATE(TRIM(BQC_DATBLO),'YYYYMMDD'))),trunc(TO_DATE(TRIM(BQC_DATCON),'YYYYMMDD'))), 999),0),0)+1 MESES ,"
cQueryDem+= CRLF + "        bqc_codemp , BQC_NUMCON , bqc_subcon , BQC_DATCON , BQC_DATBLO  , "
cQueryDem+= CRLF + "        Sum (case when (ba1.ba1_Datblo = ' ' or ba1.ba1_Datblo >='20"+cAnoAtu+cMesAtu+"01') then  1  Else 0 end) QtdAtv , "
cQueryDem+= CRLF + "        Sum (case when (ba1.ba1_Datblo <'20"+cAnoAtu+cMesAtu+"01' and ba1.ba1_Datblo <> ' ') then  1  Else 0 end) QtdBlq   "
cQueryDem+= CRLF + "   from Bqc020 bqc , ba1020 ba1 "
cQueryDem+= CRLF + "  where bqc_filial = ' ' and bqc.d_E_L_E_T_ = ' ' "
cQueryDem+= CRLF + "    and bqc_filial = ' ' and ba1.d_E_L_E_T_ = ' ' "
cQueryDem+= CRLF + "    and bqc_codemp = '"+cCodEmp+"'" 
cQueryDem+= CRLF + "    and ba1_codemp = bqc_codemp "
cQueryDem+= CRLF + "    and ba1_conemp = bqc_numcon "
cQueryDem+= CRLF + "    and BA1_SUBCON = bqc_subcon "
cQueryDem+= CRLF + "  group by bqc_codemp , BQC_NUMCON , bqc_subcon , BQC_DATCON , BQC_DATBLO " 
cQueryDem+= CRLF + "  order by bqc_codemp , BQC_NUMCON , bqc_subcon "


	If Select((cAliasDem)) <> 0 
	          (cAliasDem)->(DbCloseArea())  
	Endif                

	TcQuery cQueryDem New Alias (cAliasDem)  

    (cAliasDem)->(dbGoTop())

    While !(cAliasDem)->(EOF())

        If  nProc == 1 // retorna totais da Empresa
          
            If (cAliasDem)->MESES > nMaId
                nMaId    := (cAliasDem)->MESES
            EndIf     

            nQtdaAtv := nQtdaAtv + (cAliasDem)->QtdAtv
            nQtdaBlq := nQtdaBlq + (cAliasDem)->QtdBlq
            nQtdatot := nQtdaAtv + nQtdaBlq 

        EndIf 

            (cAliasDem)->(DbSkip())

    EndDo
     
    (cAliasDem)->(DbCloseArea())

Return()

////////////////////////CARREGAMENTO COMERCIAL 

static function fcargComer(nProc , cCodEmp)

nCargcom := 0

cQueryDemT:=        " select codemp , sum(vlrcom) VLRCOM from " 
cQueryDemT+= CRLF + "        (select PDU_CODEMP codemp , SUM(pdu_vlrpgt)vlrcom " 
cQueryDemT+= CRLF + "           from PDU010 "
cQueryDemT+= CRLF + "          WHERE PDU_FILIAL =' ' AND D_e_l_e_t_ = ' ' "

cQueryDemT+= CRLF + "   AND PDU_COMPTE >= '20"+cAnoAnt+cMesAnt+"' AND PDU_COMPTE <= '20"+cAnoAtu+cMesAtu+"' "

cQueryDemT+= CRLF + "   AND PDU_codemp = '"+cCodEmp+"'"

cQueryDemT+= CRLF + "   AND PDU_PGTO = 'S'"
cQueryDemT+= CRLF + " group by PDU_CODEMP "

cQueryDemT+= CRLF + " union all "

cQueryDemT+= CRLF + " select bxq_codemp codemp  , sum(bxq_vlrcom) vlrcom "  
cQueryDemT+= CRLF + "   from bxq020 "
cQueryDemT+= CRLF + "  where bxq_filial = ' ' and d_E_L_E_T_ =' ' " 
cQueryDemT+= CRLF + "    AND BXQ_REFERE = BXQ_PAGCOM "
cQueryDemT+= CRLF + "    and bxq_ano||bxq_mes >= '20"+cAnoAnt+cMesAnt+"' and bxq_ano||bxq_mes <= '20"+cAnoAtu+cMesAtu+"' "

cQueryDemT+= CRLF + "    and bxq_codemp = '"+cCodEmp+"'"

cQueryDemT+= CRLF + "    and bxq_e2num<> ' ' "
cQueryDemT+= CRLF + "  GROUP BY bxq_codemp) "
cQueryDemT+= CRLF + "  group by codemp "
cQueryDemT+= CRLF + "  order by 1 "

	If Select((cAliasDemT)) <> 0 
	          (cAliasDemT)->(DbCloseArea())  
	Endif                

	TcQuery cQueryDemT New Alias (cAliasDemT)  

    (cAliasDemT)->(dbGoTop())

    While !(cAliasDemT)->(EOF())

        If  nProc == 1 // retorna totais da Empresa
          
          nCargcom := (cAliasDemT)->VLRCOM
                
        EndIf 

            (cAliasDemT)->(DbSkip())

    EndDo
     
    (cAliasDemT)->(DbCloseArea())

Return()

static function fcargTot()

Local cQryPEGT	:= " "

    cQryPEGT  :=        " SELECT "
	cQryPEGT  +=CRLF+"              Sum(MENSA) mensal ,"
    cQryPEGT  +=CRLF+"              Sum(APROVADO-PART) Custo,"
    cQryPEGT  +=CRLF+"              Sum(MENSA) - Sum(APROVADO-PART) Resulta,"
    cQryPEGT  +=CRLF+"              Decode(Sum(MENSA),0,0,  (trunc((Sum(MENSA) - Sum(APROVADO-PART)) / Sum(MENSA),2) * 100)) perc ,"
    cQryPEGT  +=CRLF+"              Decode(Sum(MENSA),0,0,round((Sum(APROVADO-PART))/Sum(MENSA),4))*100 sinist "
    
    If  cEmpCI=='I'
		cQryPEGT  +=CRLF+" FROM COB_SINISTRALIDADE_MS_INT , bg9020 bg9  "
	Else
		cQryPEGT  +=CRLF+" FROM COB_SINISTRALIDADE_MS_CAB , bg9010 bg9 "
	EndIf	             
		
	cQryPEGT  +=CRLF+"  where MES_ANO_REF between TO_DATE('"+DtOS(stod('20'+cAnoAnt+cMesAnt+'01'))+"','YYYYMMDD') and TO_DATE('"+DtOS(stod('20'+cAnoAtu+cMesAtu+'01'))+"','YYYYMMDD')"	   
	cQryPEGT  +=CRLF+"    and   bg9_filial = ' ' and d_E_L_E_T_ =' ' " 
	cQryPEGT  +=CRLF+"    and bg9_codint ='0001' and bg9_codigo = codemp " 

    If  cOpcPes == 1 
	    cQryPEGT  +=CRLF+"    and bg9_ytpemp = '2'  "
	ElseIf  cOpcPes == 2 
	    cQryPEGT  +=CRLF+"    and bg9_ytpemp <> '2' "
    EndIf

    cQryPEGT  +=CRLF+"   and (MENSA > 0 or (APROVADO-PART)> 0)  "

TcQuery cQryPEGT New Alias (cAliasPEGT)  

(cAliasPEGT)->(dbGoTop())    
/*
While !(cAliasPEGT)->(EOF())

(cAliasDemT)->(DbSkip())

EndDo        
*/
Return()



static function fcargCFx()

Local cQryCFX	:= " "

nPercCfx   := 0.00
nPercCfxM  := 0.00
nContCfx   := 0
                                                    
cQryCFX   :=        " 	SELECT ped_compte COMPTE , ROUND(SUM(PED_PERCEN), 2) pCUSTfX "
cQryCFX   +=CRLF+   "     FROM ped020 ped "
cQryCFX   +=CRLF+   "    where PED_filial = ' ' and ped.d_E_L_E_T_ =' ' "
cQryCFX   +=CRLF+   "      and ped_compte >= '20"+cAnoAnt+cMesAnt+"' and ped_compte <= '20"+cAnoAtu+cMesAtu+"' "
cQryCFX   +=CRLF+   "      and ped_CCONTA = ' ' "
cQryCFX   +=CRLF+   "    group by ped_compte "

TcQuery cQryCFX New Alias (cAliasCFX)  

(cAliasCFX)->(dbGoTop())    

While !(cAliasCFX)->(EOF())

nContCfx++
nPercCfx:= nPercCfx + (cAliasCFX)->pCUSTfX

(cAliasCFX)->(DbSkip())

EndDo        

nPercCfxM  := (nPercCfx/nContCfx)

Return()