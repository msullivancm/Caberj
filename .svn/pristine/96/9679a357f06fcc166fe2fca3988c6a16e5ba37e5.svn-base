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

User Function CABA182( nOrigem , ctitulos , ctitulos1 ,cano183 , cmes183, nMstLib, nGrpEmp , nPerPes)
                                                 
local nI := 0          

Private _cUsuario:= SubStr(cUSUARIO,7,15)
Private _cIdUsuar:= RetCodUsr()

private ctitulos11  := ctitulos1

private nMstLib1 := nMstLib 
private nGrpEmp1 := nGrpEmp

private nPerPes1 := nPerPes

private cTitPesq := Iif (nGrpEmp1 == 1 ,'Administradora', (Iif (nGrpEmp1 == 2 ,'Empresas',(Iif (nGrpEmp1 == 3 ,'Uma Empresa' , 'Todas as Empresas')))))

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
 
Private aCabPEG	:= {" ",;
               "Compte",;
			    "Pref.",;
				 "Num.",;
				 "Parc",;
				 "Tipo",;
		   "Fornecedor",;
           "Vencimento",;
		        "Saldo",;
			 'Tributos',;
			   'Total' ,;
		 'Sinist. Emp.',;
		 'Sinist.Corretor',;
		      "Empresa",;
			 "Corretor",;
			 "Superior",;
			 "Controle"}
/*
Private aCabPEG	:= {" ",;
               "Compte",;
			    "Pref.",;
				 "Num.",;
				 "Parc",;
				 "Tipo",;
		   "Fornecedor",;
		        "Saldo",;
			 'Tributos',;
			   'Total' ,;
			   'Sinist',;
		   "Vencimento",;
		      "Empresa",;
			 "Vendedor",;
			 "Superior",;
			 "Controle"}
*/

//Private aCabPEG	:= {" ","Compte","Pref.","Num.","Parc","Tipo","Fornecedor","Saldo","Tributos","Total","Sinst.Emp.","Sinst.Emp.","Vencimento","Empresa","Vendedor","Superior","Controle"}
Private aTamPEG	    := {5  , 25     ,20     , 25   , 20   ,20    ,    80     , 30    ,30        ,30     ,    20       ,  20        ,25    ,  100    ,100       , 25       , 25        }       
//Private aTamPEG	:= {5  , 25     ,20     , 25   , 20   ,20    ,    80     , 30    ,30        ,30     ,    20    ,  25    ,  100    ,100       , 25       , 25        }       

//private aBrwPEG
//Private aCabPEG		:= {" ", "Compt. Entrada","Operadora de  Origem  ","Vlr Fase 3","Vlr Fase 31/2","Vlr Fase 4","Vlr Inss","Vlr Tx Adm", "Total Guias","Faturado","Qtda Guias"}
//Private aTamPEG		:= {10,30,120,45,45,45,45,45,45,45,25}  


Private oOk      	:= LoadBitMap(GetResources(),"LBOK")
Private oNo      	:= LoadBitMap(GetResources(),"LBNO")

Private oVerde   	:= LoadBitMap(GetResources(),"ENABLE")
Private oVermelho	:= LoadBitMap(GetResources(),"DISABLE")  

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

private cAliasCf  := GetNextAlias()   
//private cAliasDem := GetNextAlias()   
private cAliasCT  := GetNextAlias()    
private cAliasEX  := GetNextAlias()   
Private cAliasEqp := GetNextAlias()

private cQueryDem := ' ' 
private cQueryDemT:= ' ' 

PRIVATE cAno         := ' ' 
private cMes         := ' ' 

Private cttitpgto:=' '   

private nbascomT:= 0.00
private nVlrcomT:= 0.00
private nQtdat  := 0
Private nPercomT:= 0.0000
/*private aMenuAdm:={{{||fRkAdm1() }   , "Analise Corretora Visão 1" , "Analise Corretora Visão 1"  },;
                   {{||fRkAdm2() }   , "Analise Corretora Visão 2" , "Analise Corretora Visão 2"  },; 
                   {{||fRkAdm3() }   , "Analise Corretora Visão 3" , "Analise Corretora Visão 3"  },; 
                   {{||fRkAdm4() }   , "Analise Corretora Visão 4" , "Analise Corretora Visão 4"  },; 				   				   
                   {{||fRkAdm5() }   , "Analise Corretora Visão 5" , "Analise Corretora Visão 5"  }} */
private cEmpCI := Iif (cempant == '01','C','I')

if nOrigem1 == 1
   _cIdUsuar:='000047'
Else
   _cIdUsuar:='001495'
EndIf

if nOrigem1 != 1
   If Pergunte(cPerg,.T.) = .F.
	  Return
   Endif 

   cAno         := Mv_par02 
   cMes         := Mv_par01

Else 

   cAno         := cano183 
   cmes         := cmes183

EndIf 

cAnoANT :=  strzero((val(cAno)-1),4)
cMesAnt := cMes

If cMes == '01'
   cMesAtu := '12'
   cAnoATU := strzero((val(cAno)-1),4)
ElseIf cMes >= '02' 
   cMesAtu :=strzero((val(cMes)-1),2)
   cAnoATU :=cAno
EndIF

cAnoANT := substr(cAnoANT,3,2)
cAnoATU := substr(cAnoATU,3,2)


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

oDlg  		:= MsDialog():New( aSizeAut[7],00,aSizeAut[3] ,aSizeAut[5]-10,"Liberações de comissoes ",,,.F.,,,,,,.T.,,,.T. ) 
oSayPEG    	:= TSay():New( aPosObj[1][1],aPosObj[1][2],{||'"Liberações de comissoes "'},oDlg,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,236,016)


//bDbClickPEG	:= {|| aBrwPEG[oBrwPEG:nAt,1] := !aBrwPEG[oBrwPEG:nAt,1], oBrwPEG:Refresh()}   

bDbClickPEG	:= {|| aBrwPEG[oBrwPEG:nAt,1] := iif ((aBrwPEG[oBrwPEG:nAt,17] == ' ' .or. mv_par01 == '1') , aBrwPEG[oBrwPEG:nAt,1] ,!aBrwPEG[oBrwPEG:nAt,1]) , fMostInf() , oBrwPEG:Refresh()}   
//bDbClickPEG	:= {|| aBrwPEG[oBrwPEG:nAt,1] := iif ((aBrwPEG[oBrwPEG:nAt,17] == ' ' .or. mv_par01 == '1') , aBrwPEG[oBrwPEG:nAt,1] ,!aBrwPEG[oBrwPEG:nAt,1]) , oBrwPEG:Refresh()}   

//bChangePEG	:= {||AtuBrwGuia(aBrwPEG[oBrwPEG:nAt,2],aBrwPEG[oBrwPEG:nAt,3])}

oBrwPEG 	:= TcBrowse():New(aPosObj[1][1],aPosObj[1][2],aPosObj[1][4],aPosObj[1][3]+40,,aCabPEG,aTamPEG,oDlg,,,,,bDbClickPEG,,,,,,,.F.,,.T.,,.F.,,, )

//oBrwPEG 	:= TcBrowse():New(aPosObj[1][1]+10,aPosObj[1][2],aPosObj[1][4],aPosObj[1][3]+190,,aCabPEG,aTamPEG,oDlg,,,,,bDbClickPEG,,,,,,,.F.,,.T.,,.F.,,, )

oBrwPEG:SetArray(aBrwPEG) 

oBrwPEG:bLine := {||{If( aBrwPEG[oBrwPEG:nAt,  1],oOk,oNo) ,;
                         aBrwPEG[oBrwPEG:nAt,  2] ,;
                         aBrwPEG[oBrwPEG:nAt,  3] ,;
						 aBrwPEG[oBrwPEG:nAt,  4] ,;
                         aBrwPEG[oBrwPEG:nAt,  5] ,;
                         aBrwPEG[oBrwPEG:nAt,  6] ,;
					trim(aBrwPEG[oBrwPEG:nAt,  8]) ,;                       
                         aBrwPEG[oBrwPEG:nAt,  10] ,;
	  	       Transform(aBrwPEG[oBrwPEG:nAt,  9]  ,'@E  9999,999.99'),;
			   Transform(aBrwPEG[oBrwPEG:nAt,  20] ,'@E  9999,999.99'),;
			   Transform(aBrwPEG[oBrwPEG:nAt,  21] ,'@E  9999,999.99'),;
			   Transform(aBrwPEG[oBrwPEG:nAt,  22] ,'@E  999.99')+'%',;
			   Transform(aBrwPEG[oBrwPEG:nAt,  23] ,'@E  999.99')+'%',;
		 	     alltrim(aBrwPEG[oBrwPEG:nAt,  11]),; 
				 alltrim(aBrwPEG[oBrwPEG:nAt,  12]),; 
				         aBrwPEG[oBrwPEG:nAt,  18] ,;
						 aBrwPEG[oBrwPEG:nAt,  19] }}                   



oBrwPEG:nScrollType  := 1 // Scroll VCR

lConfirmou 	:= .T.

if  nOrigem1 != 1
	aBut    :={{"PENDENTE", {||marca(1)   ,oBrwPEG:Refresh()            }	, "Marcar Todos "       , "Marcar Todos"      }}
	aAdd(aBut, {"PENDENTE", {||desmarca(1),oBrwPEG:Refresh()            }	, "Desmarcar Todos "	, "Desmarcar Todos"	  })  
	aAdd(aBut, {"PENDENTE", {||fMSinsEmp()  ,oBrwPEG:Refresh()          }   , "Sinist. Empresa "    , "Sinist. Empresa"   })  
	If  mv_par03 == 1
	    aAdd(aBut, {"PENDENTE", {||fFazlib()  ,oBrwPEG:Refresh(),oDlg:End() }   , "Faz Liberaçõa "      , "Faz Liberaçõa"     })  
	EndIf 	
	aAdd(aBut, {"PENDENTE", {||fMSinsVend()  ,oBrwPEG:Refresh()         }   , "Sinist. Corretora/Administradora" , "Sinist. Corretora/Administradora"  })  
	aAdd(aBut, {"PENDENTE", {||fMostInfE()  ,oBrwPEG:Refresh()          }   , "Custo Total De Comercialização"   , "Custo Total De Comercialização"  })   
	aAdd(aBut, {"PENDENTE", {||fRkAdm1()    ,oBrwPEG:Refresh()          }   , "Classif. Sinistralidade"  , "Classif. Sinistralidade"   }) 
    aAdd(aBut, {"PENDENTE", {||fRkAdm2()    ,oBrwPEG:Refresh()          }   , "Sinist. Faturamento X Custo"  , "Sinist. Faturamento X Custo"   }) 
	aAdd(aBut, {"PENDENTE", {||fRkAdm3()    ,oBrwPEG:Refresh()          }   , "Result.Financeiro Empresa", "Result.Financeiro Empresa" }) 
    aAdd(aBut, {"PENDENTE", {||fRkAdm4()    ,oBrwPEG:Refresh()          }   , "Result.Financeiro Grp.Empresa"  , "Result.Financeiro Grp.Empresa"  }) 
	aAdd(aBut, {"PENDENTE", {||fRkAdm5()    ,oBrwPEG:Refresh()          }   , "Result.Financ.Grp.Empresa c/ Comis"  , "Result.Financ.Grp.Empresa c/ Comis"  }) 
	aAdd(aBut, {"PENDENTE", {||oDlg:End()                               }   , "Sair "               , "Sair "             })  
Else 
//	aBut    :={{"PENDENTE", {||marca(1)     ,oBrwPEG:Refresh()          }	, "Marcar Todos "       , "Marcar Todos"      }}
//	aAdd(aBut, {"PENDENTE", {||desmarca(1)  ,oBrwPEG:Refresh()          }	, "Desmarcar Todos "	, "Desmarcar Todos"	  })  
	
	aBut    :={{"PENDENTE", {||fMSinsEmp()  ,oBrwPEG:Refresh()          }   , "Sinist. Empresa "    , "Sinist. Empresa"   }} 
	aAdd(aBut, {"PENDENTE", {||fMSinsVend() ,oBrwPEG:Refresh()          }   , "Sinist. Corretora/Administradora" , "Sinist. Corretora/Administradora"  })  
	aAdd(aBut, {"PENDENTE", {||fMostInfE()  ,oBrwPEG:Refresh()          }   , "Custo De Comercialização" , "Custo De Comercialização"  })  
	aAdd(aBut, {"PENDENTE", {||fRkAdm1()    ,oBrwPEG:Refresh()          }   , "Classif. Sinistralidade"  , "Classif. Sinistralidade"   }) 
    aAdd(aBut, {"PENDENTE", {||fRkAdm2()    ,oBrwPEG:Refresh()          }   , "Sinist. Faturamento X Custo"  , "Sinist. Faturamento X Custo"   }) 
	aAdd(aBut, {"PENDENTE", {||fRkAdm3()    ,oBrwPEG:Refresh()          }   , "Result.Financeiro Empresa", "Result.Financeiro Empresa" }) 
    aAdd(aBut, {"PENDENTE", {||fRkAdm4()    ,oBrwPEG:Refresh()          }   , "Result.Financeiro Grp.Empresa"  , "Result.Financeiro Grp.Empresa"  }) 
	aAdd(aBut, {"PENDENTE", {||fRkAdm5()    ,oBrwPEG:Refresh()          }   , "Result.Financ.Grp.Empresa c/ Comis"  , "Result.Financ.Grp.Empresa c/ Comis"  }) 
	aAdd(aBut, {"PENDENTE", {||oDlg:End()                               }   , "Sair "               , "Sair "             })  
Endif

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
Local cQryCE	:= ""
Local cAliasPEG	:= GetNextAlias()
Local cAliasDem	:= GetNextAlias()
Local cAliasDemT:= GetNextAlias()
local i

ProcRegua(0) 

nCont := 0

for i:=1 to 5
    IncProc('Buscando Dados no Servidor ...')
next             
      
cQryPEG :="        select distinct bxq_ano||bxq_mes compte , "
cQryPEG += CRLF + "       e2_prefixo pref ,"
cQryPEG += CRLF + "       e2_num num , "
cQryPEG += CRLF + "       E2_PARCELA parcel , "
cQryPEG += CRLF + "       e2_tipo tipo , "
cQryPEG += CRLF + "       E2_FORNECE fornece,
cQryPEG += CRLF + "       E2_NOMFOR  nomfor,
cQryPEG += CRLF + "       e2_saldo Saldo , "
cQryPEG += CRLF + "       (e2_irrf+e2_inss+e2_iss+e2_vretpis+e2_vretcof+e2_vretcsl) tributo , "
cQryPEG += CRLF + "       (e2_irrf+e2_inss+e2_iss+e2_vretpis+e2_vretcof+e2_vretcsl+e2_valor) Total , "
cQryPEG += CRLF + "       Trim(substr(e2_vencrea,7,2)||'/'||substr(e2_vencrea,5,2)||'/'||substr(e2_vencrea,1,4)) Vencto , "
cQryPEG += CRLF + "       bxq_codemp ||' - '|| trim(bg9_descri) Emp , "
cQryPEG += CRLF + "       bxq_codven ||' - '|| trim(a3_Nome) Vend , "
cQryPEG += CRLF + "       Alc.AK_USER Usuar, Alc.AK_NOME NomUsr, Alc.AL_COD CodAlc , Alc.AL_DESC DescAlc , Alc.AL_LIBAPR Lib , Alc.AL_USERSUP AprSup ,"

cQryPEG += CRLF + "       se2.R_E_C_N_O_ contro"
          
cQryPEG += CRLF + "  from "+RetSQLName("BXQ")+" BXQ , " 
cQryPEG += CRLF + "       "+RetSQLName("SE2")+" SE2 , "
cQryPEG += CRLF + "       "+RetSQLName("SA3")+" SA3 , "
cQryPEG += CRLF + "       "+RetSQLName("BG9")+" BG9 , "
/* TRATAMENTO PARA nf DIGITADA ATIVA QUANDO FOR OBRIGATORIO 
cQryPEG += CRLF + "       "+RetSQLName("SA2")+" SA2 , "
*/
cQryPEG += CRLF + "      (SELECT AK_USER , AK_NOME, AL_COD , AL_DESC , AL_LIBAPR , AL_USERSUP "  
cQryPEG += CRLF + "         FROM "+RetSQLName("SAL")+" SAL , "
cQryPEG += CRLF + "              "+RetSQLName("SAK")+" SAK   "
cQryPEG += CRLF + "        WHERE AL_FILIAL  = '" + xFilial('SAL') + "'  AND SAL.D_E_L_E_T_ = ' ' " 
cQryPEG += CRLF + "          AND AK_FILIAL  = '" + xFilial('SAK') + "'  AND SAK.D_E_L_E_T_ = ' ' "
cQryPEG += CRLF + "          AND AL_COD = '909098' "
cQryPEG += CRLF + "          AND AK_COD = AL_APROV "
cQryPEG += CRLF + "          AND AL_USER = '"+_cIdUsuar+"' ) Alc "
cQryPEG += CRLF + "  Where e2_filial  = '" + xFilial('SE2') + "' and bxq.d_E_l_E_T_ = ' ' "
cQryPEG += CRLF + "    and bxq_filial = '" + xFilial('BXQ') + "' and se2.d_E_L_E_T_ = ' ' "
cQryPEG += CRLF + "    and a3_filial  = '" + xFilial('SA3') + "' and sa3.d_E_L_E_T_ = ' ' "
cQryPEG += CRLF + "    and bg9_filial = '" + xFilial('BG9') + "' and bg9.d_E_L_E_T_ = ' ' "

/* TRATAMENTO PARA nf DIGITADA ATIVA QUANDO FOR OBRIGATORIO 
cQryPEG += CRLF + "    and a2_filial  = '" + xFilial('SA2') + "' and sa2.d_E_L_E_T_ = ' ' "
*/

cQryPEG += CRLF + "    and a3_cod     = bxq_codven "
cQryPEG += CRLF + "    and bg9_codigo = bxq_codemp "

cQryPEG += CRLF + "    and bxq_e2pref = e2_prefixo " 
cQryPEG += CRLF + "    and bxq_e2num  = e2_num "
cQryPEG += CRLF + "    and bxq_e2parc = e2_parcela "
cQryPEG += CRLF + "    and bxq_e2tipo = e2_tipo "
cQryPEG += CRLF + "    and bxq_e2forn = e2_fornece "  
cQryPEG += CRLF + "    and bxq_e2loja = e2_loja "

cQryPEG += CRLF + "    and e2_prefixo = 'COM' "

cQryPEG += CRLF + "    and e2_ylibpls in ('S','M') "

cQryPEG += CRLF + "    AND BXQ_CODVEN NOT in ('000174','000172','000171','000191','000177','000215' ) "

/* TRATAMENTO PARA nf DIGITADA ATIVA QUANDO FOR OBRIGATORIO 

cQryPEG += CRLF + "    AND A2_COD     = E2_FORNECE "

cQryPEG += CRLF + "    AND ((A2TIPPE    = 'J' AND SA2.A2_YBLQPLS = 'S' AND E2_YLIBPLS = 'S') OR A2TIPPE    = 'F')  "
*/

if nOrigem1 == 1

   cQryPEG += CRLF + "    and E2_NUM IN" + TRIM(cTITULOS11) 

Else

// cQryPEG += CRLF + "  and e2_emissao like '"+cano+cmes+"%'"   

cQryPEG += CRLF + "  and bxq_ano =  '"+cano+"'"   
cQryPEG += CRLF + "  and bxq_mes =  '"+cmes+"'"   

EndIf 

/*
if Mv_par03 == 1

   cQryPEG += CRLF + "    and e2_baixa = ' '  "
   cQryPEG += CRLF + "    and e2_saldo > 0 "
 
EndIf 
*/

if   (nMstLib1 == 1  .or.  Mv_par03 == 1 )

    cQryPEG += CRLF + "    and e2_baixa = ' '  " 
    cQryPEG += CRLF + "    and e2_saldo > 0 "

	cQryPEG += CRLF + "    AND nvl(( SELECT COUNT(*) QTDA "
	cQryPEG += CRLF + "                FROM siga."+RetSQLName("PDT")+" PDT  "
	cQryPEG += CRLF + "               WHERE PDT_FILIAL = '" + xFilial('PDT') + "'" 
	cQryPEG += CRLF + "                 AND D_e_l_e_t_ = ' ' "
	cQryPEG += CRLF + "                 AND PDT_PREFIX = se2.e2_prefixo "
	cQryPEG += CRLF + "                 AND PDT_NUM    = se2.e2_num "
	cQryPEG += CRLF + "                 AND PDT_PARCEL = se2.e2_parcela "
	cQryPEG += CRLF + "                 AND PDT_TIPO   = se2.e2_tipo  "
	cQryPEG += CRLF + "                 AND PDT_FORNEC = se2.e2_fornece "
	cQryPEG += CRLF + "                 and pdt_aprov  = '"+_cIdUsuar+"'),0) = 0 "
EndIf

if  nOrigem1 == 1

//cQryPEG += CRLF + "                 order by  bxq_codemp ||' - '|| trim(bg9_descri)  "    
cQryPEG += CRLF + "     order by  bxq_codven ||' - '|| trim(a3_Nome) , "
cQryPEG += CRLF + "               bxq_codemp ||' - '|| trim(bg9_descri) "
Else
    cQryPEG += CRLF + "                 order by  e2_prefixo ,e2_num  "    
EndIf 

TcQuery cQryPEG New Alias (cAliasPEG)  

(cAliasPEG)->(dbGoTop())    

While !(cAliasPEG)->(EOF())

cQueryDem:= " SELECT Decode(Sum(MENSA),0,0,round((Sum(APROVADO-PART))/Sum(MENSA),6))*100 sinist "
If  cEmpCI=='I'
    cQueryDem+= CRLF + "FROM COB_SINISTRALIDADE_MS_INT "
Else
    cQueryDem+= CRLF + "FROM COB_SINISTRALIDADE_MS_CAB "
EndIf	
cQueryDem+= CRLF + " where MES_ANO_REF between TO_DATE('"+DtOS(stod('20'+cAnoAnt+cMesAnt+'01'))+"','YYYYMMDD') and TO_DATE('"+DtOS(stod('20'+cAnoAtu+cMesAtu+'01'))+"','YYYYMMDD')"
cQueryDem+= CRLF + "   AND CODEMP = '"+substr((cAliasPEG)->Emp,1,4)+"'"

	If Select((cAliasDem)) <> 0 
	          (cAliasDem)->(DbCloseArea())  
	Endif                

	TcQuery cQueryDem New Alias (cAliasDem)  

    (cAliasDem)->(dbGoTop())

///// simistralidade por vendedor -- altamiro 29/09/2021

cQueryDemT:= " SELECT Decode(Sum(MENSA),0,0,round((Sum(APROVADO-PART))/Sum(MENSA),6))*100 sinist "
If  cEmpCI=='I'
    cQueryDemT += CRLF + "FROM COB_SINISTRALIDADE_MS_INT "
Else
    cQueryDemT += CRLF + "FROM COB_SINISTRALIDADE_MS_CAB "
EndIf	
cQueryDemT+= CRLF + " where MES_ANO_REF between TO_DATE('"+DtOS(stod('20'+cAnoAnt+cMesAnt+'01'))+"','YYYYMMDD') and TO_DATE('"+DtOS(stod('20'+cAnoAtu+cMesAtu+'01'))+"','YYYYMMDD')"
cQueryDemT+= CRLF + "  AND CODEMP in  "
cQueryDemT+= CRLF + "(select distinct bxq_codemp FROM siga."+RetSQLName("BXQ")+" BXQ "
cQueryDemT+= CRLF + "  WHERE BXQ_FILIAL = '" + xFilial('BXQ') + "' AND D_e_l_e_t_ = ' ' "
cQueryDemT+= CRLF + "    and bxq_codven = '"+substr((cAliasPEG)->Vend,1,6) +"' "
cQueryDemT+= CRLF + "    and bxq_ano = '"+'20'+cAnoAtu+"' and bxq_mes = '"+cMesAtu+"')"

	If Select((cAliasDemT)) <> 0 
	          (cAliasDemT)->(DbCloseArea())  
	Endif                

	TcQuery cQueryDemT New Alias (cAliasDemT)  

    (cAliasDemT)->(dbGoTop())

	/////////////

    aAdd(aRetPEG,{.F.    ,;    //1
	(cAliasPEG)->compte  ,;    //2
	(cAliasPEG)->pref    ,;    //3
    (cAliasPEG)->num     ,;    //4
    (cAliasPEG)->parcel  ,;    //5
    (cAliasPEG)->tipo    ,;    //6
    (cAliasPEG)->fornece ,;    //7
    (cAliasPEG)->nomfor  ,;    //8
	(cAliasPEG)->Saldo   ,;    //9
	trim((cAliasPEG)->Vencto) ,;    //10
	(cAliasPEG)->Emp     ,;    //11
	(cAliasPEG)->Vend    ,;    //12
	(cAliasPEG)->Usuar   ,;    //13
	(cAliasPEG)->NomUsr  ,;    //14
	(cAliasPEG)->CodAlc  ,;    //15
	(cAliasPEG)->DescAlc ,;    //16
	(cAliasPEG)->Lib     ,;    //17
	(cAliasPEG)->AprSup  ,;    //18
	(cAliasPEG)->contro  ,;    //19
	(cAliasPEG)->Tributo ,;    //20
	(cAliasPEG)->total   ,;    //21
    (cAliasDem)->sinist  ,;    //22
	(cAliasDemT)->sinist })    //23   

	(cAliasPEG)->(DbSkip())

EndDo
  
(cAliasPEG)->(DbCloseArea())

If empty(aRetPEG)
	aAdd(aRetPEG,{.F.,;  //1
	               '',;  //2
				   '',;  //3
				   '',;  //4
				   '',;  //5
				   '',;  //6
				   '',;  //7
				   '',;  //8
				   0 ,;  //9
				   '',;  //10
				   '',;  //11
				   '',;  //12
				   '',;  //13
				   '',;  //14
				   '',;  //15
				   '',;  //16
				   '',;  //17
				   '',;  //18
				    0,;  //19
				  ' ',;  //20
					0,;  //21
					0,;  //22
					0})  //23
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

Static Function fFazlib()

//Local cQryEqp	:= ""

local I 

nPagto := 0



	For I := 1 to len(aBrwPEG)
			
		If  aBrwPEG[I,1] == .T.  
			
			DBSELECTAREA("PDT")   
            PDT->(dbSetOrder(1))  
	 
            cPrefT        := aBrwPEG[I,03] 
            cNumtT        := aBrwPEG[I,04]
            cTipoT        := aBrwPEG[I,06]
            cMes          := substr(aBrwPEG[I,02],5,2)
            cAno          := substr(aBrwPEG[I,02],1,4)
            cEmp          := substr(aBrwPEG[I,11],1,4) 
            cVend         := substr(aBrwPEG[I,12],1,6) 
///			
			PDT->(Reclock("PDT",.T.))

				PDT_FILIAL   := xFilial('PDT')  
				PDT_PREFIX   := aBrwPEG[I,03] 
				PDT_NUM      := aBrwPEG[I,04]  
				PDT_PARCEL   := aBrwPEG[I,05]  
				PDT_TIPO     := aBrwPEG[I,06]  
				PDT_FORNEC   := aBrwPEG[I,07]  
				PDT_APROV    := aBrwPEG[I,13]  
				PDT_TPAPRO   := aBrwPEG[I,17]  
				PDT_DTAPRO   := DATE()  
				PDT_LIBERA   := trim(Iif( aBrwPEG[I,17]='V','N','S'))  
				PDT_MODULO   :='COM'  
				PDT_GRPAPR   := aBrwPEG[I,15]  
				PDT_NOMAPV   := aBrwPEG[I,14] 
				PDT_LOG      := "Usuario : " +_cUsuario + " Data Hora Geração " +cDthr
				PDT_ACAO     := trim(aBrwPEG[I,17])
         
		        nPagto++                

			PDT->(MsUnlock())
	          
	        DBSELECTAREA("SE2")   
            SE2->(DbSetOrder(1))		  
	
	        If SE2->(MsSeek(xFilial("SE2") + aBrwPEG[I,03]+aBrwPEG[I,04]+aBrwPEG[I,05]+aBrwPEG[I,06]))
								
	   //MARCA COMO CONTABILIZADO, PARA EVITAR A DELEÇÃO APOS A AUTORIZAÇÃO - PARA LIBERAR A EXCLUÇÃO LIBERAR A CONTABILIZAÇÃO
	     	   SE2->(RecLock("SE2",.F.))
						
	           SE2->E2_LA := "S"
					
	           SE2->(MsUnLock())

	        EndIf
    
	    EndIf
	
	Next

Return(nPagto)
***************************************************************************************/
        



static Function fMostInf()

local aLogLista := {}
local cquery    := ' '     

local cAnoM    := substr(aBrwPEG[oBrwPEG:nAt,2],1,4)
local cMesM    := substr(aBrwPEG[oBrwPEG:nAt,2],5,2)
local cCodempM := substr(aBrwPEG[oBrwPEG:nAt,11],1,4)
local cCodVenM := substr(aBrwPEG[oBrwPEG:nAt,12],1,6)

if nOrigem1 == 1

	cQuery :="  select bxqa.vendedor vendedor       , "
    cQuery +=CRLF+"         sum(bxqa.bacom) bacom   , "
	cQuery +=CRLF+"         trim(bxqa.percom) percom  , "
	cQuery +=CRLF+"         sum(bxqa.vlcom) vlcom   , "
	cQuery +=CRLF+"         sum(bxqa.qtda) qtda     , "
	cQuery +=CRLF+"         bxqa.obs     obs        , "
	cQuery +=CRLF+"         bxqa.idadLim idadLim    , "
	cQuery +=CRLF+"         bxqa.agenc   agenc       , "
	
    cQuery +=CRLF+"         decode(bxqa.agenc ,'Agenciamento',bxqa.numpar , 'X') parcela "  

	cQuery +=CRLF+"    from ("

	cQuery +=CRLF+"  select bxq.codven ||'-'|| bxq.nomvend vendedor, " 
	cQuery +=CRLF+"    sum(bxq.bascom) bacom    , "
	cQuery +=CRLF+"    bxq.percom||'%' percom  , "
	cQuery +=CRLF+"    sum(bxq.vlrcom) vlcom    , " 
	cQuery +=CRLF+"    sum(bxq.qtda) qtda       , "

    cQuery +=CRLF+"    bxop.obs     obs         , "
    cQuery +=CRLF+"    bxop.idadLim idadLim     , "
    cQuery +=CRLF+"    bxop.agenc   agenc       , "

	cQuery +=CRLF+"    bxq.numpar   numpar        "

	cQuery +=CRLF+"    from( select bxq_codven codven      , "
	cQuery +=CRLF+"                 a3_nome nomvend        , "
	cQuery +=CRLF+"                 bxq_numpar numpar      , "
	cQuery +=CRLF+"                 count(*) qtda          , "
	cQuery +=CRLF+"                 Bxq_Percom      percom , "
	cQuery +=CRLF+"                 sum(bxq_vlrcom) vlrcom , "
	cQuery +=CRLF+"                 sum(bxq_bascom) bascom , "
	cQuery +=CRLF+"                 bxq_codemp codemp      , "
	cQuery +=CRLF+"                 bxq_matric matric      , "
	cQuery +=CRLF+"                 bxq_tipreg tipreg      , "
	cQuery +=CRLF+"                 a3_nome Vend           , "
	cQuery +=CRLF+"                 ba1_conemp conemp      , "
	cQuery +=CRLF+"                 ba1_subcon subcon      , "
	cQuery +=CRLF+"                 ba1_Tipinc  tipInc       "
	cQuery +=CRLF+"            From " + RetSqlName("BXQ") +" BXQ , " + RetSqlName("SA3") +" SA3 ," + RetSqlName("BA1") +" BA1 " 

	cQuery +=CRLF+"           where bxQ_filial  ='"+xFilial('BXQ')+ "' and bxQ.d_E_L_E_T_ = ' ' "
	cQuery +=CRLF+"             and   A3_filial ='"+xFilial('SA3')+ "'  and SA3.d_E_L_E_T_ = ' ' "
	cQuery +=CRLF+"             and  BA1_filial ='"+xFilial('BA1')+ "'  and BA1.d_E_L_E_T_ = ' ' " 
	cQuery +=CRLF+"             and bxq_codint = ba1_codint "
	cQuery +=CRLF+"             and bxq_codemp = ba1_codemp "
	cQuery +=CRLF+"             and bxq_matric = ba1_matric "
	cQuery +=CRLF+"             and bxq_tipreg = ba1_tipreg "
	cQuery +=CRLF+"             and bxq_codven = a3_cod "    
	cQuery +=CRLF+"             and bxq_vlrcom > 0  "        

	cQuery +=CRLF+"             and bxq_codemp = '"+cCodempM+"'  " 
	cQuery +=CRLF+"             and bxq_codven = '"+cCodVenM+"'  "
	cQuery +=CRLF+"             and bxq_ano    = '"+cAnoM+"'  "
	cQuery +=CRLF+"             and bxq_mes    = '"+cMesM+"'  "

	cQuery +=CRLF+"             and bxq_pagcom = bxq_refere "
	cQuery +=CRLF+"        group by bxq_codven , bxq_numpar , bxq_codemp , bxq_matric , "
	cQuery +=CRLF+"                 bxq_tipreg, Bxq.Bxq_Percom ,a3_nome , ba1_conemp  , ba1_subcon ,ba1_tipinc  )bxq , "
	
cQuery +=CRLF+"  (select bxo_codven codven , 
cQuery +=CRLF+"          bxo_codemp codemp , 
cQuery +=CRLF+"          bxo_matric matric , 
cQuery +=CRLF+"          bxo_tipreg tipreg , 
cQuery +=CRLF+"          NVL(BXJK.bxk_qtdde,'001') qtdde   , 
cQuery +=CRLF+"          NVL(BXJK.bxk_qtdate,'999') qtdate , 
cQuery +=CRLF+"          NVL(BXJK.bxk_obs,' ') Obs         ,
cQuery +=CRLF+"          nvl(BXJK.bxj_Yidisn,' ')  idadLim ,

if  cempant == '01'
    cQuery +=CRLF+"                decode(NVL(bxjk.BXK_AGENCI,' ') ,'1', 'Agenciamento', 'Vitalicio') agenc 
Else 
    cQuery +=CRLF+"                decode(NVL(bxjk.BXK_AGENC,' ') ,'1', 'Agenciamento', 'Vitalicio') agenc 
EndIf

cQuery +=CRLF+"       From " + RetSqlName("BXO") +" BXO , "  
cQuery +=CRLF+"            (select * from  "+ RetSqlName("BXJ") +" BXJ , "+ RetSqlName("BXK") +" BXK " 
cQuery +=CRLF+"              where BXJ_filial = '"+xFilial('BXJ')+ "'  and bxj.d_E_L_E_T_ = ' ' "
cQuery +=CRLF+"                and BXK_filial = '"+xFilial('BXK')+ "'  and bxk.d_E_L_E_T_ = ' ' "
cQuery +=CRLF+"                AND BXK_SEQBXJ = BXJ_SEQ
cQuery +=CRLF+"                AND BXJ_CODEMP = '0010') BXJK 
cQuery +=CRLF+"              where BXO_filial = '  '  and bxo.d_E_L_E_T_ = ' '
cQuery +=CRLF+"                and bxo_codemp = '"+cCodEmpM+"' "
cQuery +=CRLF+"                and bxo_codven = '"+cCodVenM+"' "
cQuery +=CRLF+"                and BXJK.bxj_seq(+)    = bxo_seqbxj 	) bxop " 
	
	cQuery +=CRLF+"           where bxq.codven = bxop.codven   "
	cQuery +=CRLF+"             and bxq.numpar >= bxop.qtdde   "
	cQuery +=CRLF+"             and bxq.numpar <= bxop.qtdate  "
	cQuery +=CRLF+"             and bxq.codemp = bxop.codemp   "
	cQuery +=CRLF+"             and bxq.matric = bxop.matric   "
	cQuery +=CRLF+"             and bxq.tipreg = bxop.tipreg   "
	cQuery +=CRLF+"        group by bxq.codven , bxq.nomvend , "
	cQuery +=CRLF+"                 bxop.qtdde||' a '||bxop.qtdate , bxq.percom||'%' , "
    cQuery +=CRLF+"                 bxop.obs , bxop.idadLim , bxop.agenc , bxq.numpar  "

	cQuery +=CRLF+" union all "  
    
	cQuery +=CRLF+"    select bxq.codven ||'-'|| bxq.nomvend vendedor , "
	cQuery +=CRLF+"           sum(bxq.bascom) bacom    , "
	cQuery +=CRLF+"           bxq.percom||'%' percom   , "
	cQuery +=CRLF+"           sum(bxq.vlrcom) vlcom    , "
	cQuery +=CRLF+"           sum(bxq.qtda) qtda       , "

    cQuery +=CRLF+"           bxop.obs     obs         , "
    cQuery +=CRLF+"		      bxop.idadLim idadLim     , "
    cQuery +=CRLF+"    		  bxop.agenc   agenc       , "

	cQuery +=CRLF+"           bxq.numpar   numpar        "

	cQuery +=CRLF+"      from( select bxq_codven codven      , " 
	cQuery +=CRLF+"                   a3_nome nomvend        , " 
	cQuery +=CRLF+"                   bxq_numpar numpar      , " 
	cQuery +=CRLF+"                   count(*) qtda          , " 
	cQuery +=CRLF+"                   Bxq_Percom  Percom     , " 
	cQuery +=CRLF+"                   sum(bxq_vlrcom) vlrcom , "
	cQuery +=CRLF+"                   sum(bxq_bascom) bascom , "
	cQuery +=CRLF+"                   bxq_codemp codemp      , "
	cQuery +=CRLF+"                   bxq_matric matric      , "
	cQuery +=CRLF+"                   bxq_tipreg tipreg      , "
	cQuery +=CRLF+"                   a3_nome Vend           , "
	cQuery +=CRLF+"                   ba1_conemp conemp      , "
	cQuery +=CRLF+"                   ba1_subcon subcon      , "
	cQuery +=CRLF+"                   ba1_Tipinc  tipInc       "
	cQuery +=CRLF+"              From " + RetSqlName("BXQ") +" BXQ , " + RetSqlName("SA3") +" SA3 ," + RetSqlName("BA1") +" BA1 " 
	cQuery +=CRLF+"             where bxQ_filial = '"+xFilial('BXQ')+ "'  and bxQ.d_E_L_E_T_ = ' ' "
	cQuery +=CRLF+"               and A3_filial  = '"+xFilial('SA3')+ "'  and SA3.d_E_L_E_T_ = ' ' "
	cQuery +=CRLF+"               and BA1_filial = '"+xFilial('BA1')+ "'  and BA1.d_E_L_E_T_ = ' ' "
	cQuery +=CRLF+"               and bxq_codint = ba1_codint "
	cQuery +=CRLF+"               and bxq_codemp = ba1_codemp "
	cQuery +=CRLF+"               and bxq_matric = ba1_matric "
	cQuery +=CRLF+"               and bxq_tipreg = ba1_tipreg "
	cQuery +=CRLF+"               and bxq_codven = a3_cod     "
	cQuery +=CRLF+"               and bxq_vlrcom < 0          "

	cQuery +=CRLF+"               and bxq_codemp = '"+cCodEmpM+"' "     
	cQuery +=CRLF+"               and bxq_codven = '"+cCodVenM+"' "
	cQuery +=CRLF+"               and bxq_ano    = '"+cAnoM+"' "     
	cQuery +=CRLF+"               and bxq_mes    = '"+cMesM+"' "       

	cQuery +=CRLF+"               and bxq_pagcom = bxq_refere "
	cQuery +=CRLF+"          group by bxq_codven , bxq_numpar , bxq_codemp , bxq_matric , "
	cQuery +=CRLF+"                   bxq_tipreg, Bxq_Percom ,a3_nome , ba1_conemp  , ba1_subcon ,ba1_tipinc  )bxq , " 

cQuery +=CRLF+"  (select bxo_codven codven , 
cQuery +=CRLF+"          bxo_codemp codemp , 
cQuery +=CRLF+"          bxo_matric matric , 
cQuery +=CRLF+"          bxo_tipreg tipreg , 
cQuery +=CRLF+"          NVL(BXJK.bxk_qtdde,'001') qtdde   , 
cQuery +=CRLF+"          NVL(BXJK.bxk_qtdate,'999') qtdate , 
cQuery +=CRLF+"          NVL(BXJK.bxk_obs,' ') Obs         ,
cQuery +=CRLF+"          nvl(BXJK.bxj_Yidisn,' ')  idadLim ,

if  cempant == '01'
    cQuery +=CRLF+"                decode(NVL(bxjk.BXK_AGENCI,' ') ,'1', 'Agenciamento', 'Vitalicio') agenc 
Else 
    cQuery +=CRLF+"                decode(NVL(bxjk.BXK_AGENC,' ') ,'1', 'Agenciamento', 'Vitalicio') agenc 
EndIf

cQuery +=CRLF+"       From " + RetSqlName("BXO") +" BXO , "  
cQuery +=CRLF+"            (select * from "+ RetSqlName("BXJ") +" BXJ , "+ RetSqlName("BXK") +" BXK " 
cQuery +=CRLF+"              where BXJ_filial = '"+xFilial('BXJ')+ "'  and bxj.d_E_L_E_T_ = ' ' "
cQuery +=CRLF+"                and BXK_filial = '"+xFilial('BXK')+ "'  and bxk.d_E_L_E_T_ = ' ' "
cQuery +=CRLF+"                AND BXK_SEQBXJ = BXJ_SEQ
cQuery +=CRLF+"                AND BXJ_CODEMP = '0010') BXJK 
cQuery +=CRLF+"              where BXO_filial = '  '  and bxo.d_E_L_E_T_ = ' '
cQuery +=CRLF+"                and bxo_codemp = '"+cCodEmpM+"' "
cQuery +=CRLF+"                and bxo_codven = '"+cCodVenM+"' "
cQuery +=CRLF+"                and BXJK.bxj_seq(+)    = bxo_seqbxj ) bxop "


	cQuery +=CRLF+"   where bxq.codven  = bxop.codven  "
	cQuery +=CRLF+"     and bxq.numpar >= bxop.qtdde   "
	cQuery +=CRLF+"     and bxq.numpar <= bxop.qtdate  "
	cQuery +=CRLF+"     and bxq.codemp  = bxop.codemp  "
	cQuery +=CRLF+"     and bxq.matric  = bxop.matric  "
	cQuery +=CRLF+"     and bxq.tipreg  = bxop.tipreg  "
	cQuery +=CRLF+"   group by bxq.codven   , bxq.nomvend , "
	cQuery +=CRLF+"         bxq.percom||'%' , bxop.obs    , "
    cQuery +=CRLF+"         bxop.idadLim    , bxop.agenc  , bxq.numpar ) bxqa "

    cQuery +=CRLF+"   group by bxqa.vendedor    , "
    cQuery +=CRLF+"            bxqa.percom      , "
    cQuery +=CRLF+"            bxqa.obs         , "
    cQuery +=CRLF+"            bxqa.idadLim     , "
    cQuery +=CRLF+"            bxqa.agenc       , "

	cQuery +=CRLF+"            decode(bxqa.agenc ,'Agenciamento',bxqa.numpar , 'X')" 

	cQuery +=CRLF+" union all "  
    
	cQuery +=CRLF+" select bxq_codven ||'-'|| a3_nome  vendedor , " 
    cQuery +=CRLF+"        sum(bxq_bascom) bacom    , "
	cQuery +=CRLF+"        bxq_percom||'%' percom   , "
	cQuery +=CRLF+"        sum(bxq_vlrcom) vlcom    , "
	cQuery +=CRLF+"        count(*)        qtda     , "
    cQuery +=CRLF+"        PE9_JUSTIF      obs      , "
	cQuery +=CRLF+"        ' '             idadLim  , "
	cQuery +=CRLF+"        'NAO'           agenc    , "
	cQuery +=CRLF+"        bxq_numpar      numpar     "

	cQuery +=CRLF+"   FROM  " + RetSqlName("BXQ") +" BXQ , " + RetSqlName("PE9") +" PE9 , "+ RetSqlName("SA3") +" SA3 " 
    
	cQuery +=CRLF+"  where BXQ_filial = '"+xFilial('BXO')+ "'  and BXQ.d_E_L_E_T_ = ' ' "
    cQuery +=CRLF+"    and PE9_filial = '"+xFilial('PE9')+ "'  and PE9.d_E_L_E_T_ = ' ' "
    cQuery +=CRLF+"    and  A3_filial = '"+xFilial('SA3')+ "'  and SA3.d_E_L_E_T_ = ' ' "

	cQuery +=CRLF+"    and bxq_codemp = '"+cCodEmpM+"' "     
	cQuery +=CRLF+"    and bxq_codven = '"+cCodVenM+"' "
	cQuery +=CRLF+"    and bxq_ano    = '"+cAnoM+"' "     
	cQuery +=CRLF+"    and bxq_mes    = '"+cMesM+"' "       
	
	cQuery +=CRLF+"    AND PE9_COMPTE = '"+cAnoM+"/"+cMesM+"' " 
    cQuery +=CRLF+"    AND PE9_CODEMP = '"+cCodEmpM+"' "
    cQuery +=CRLF+"    AND PE9_CODVEN = '"+cCodVenM+"' "

	cQuery +=CRLF+"    and bxq_pagcom = bxq_refere "
    cQuery +=CRLF+"    and bxq_codven = a3_cod     "
    cQuery +=CRLF+"    and bxq_numpar = '777'      "
    cQuery +=CRLF+"  GROUP BY bxq_codven ||'-'|| a3_nome , " 
	cQuery +=CRLF+"       bxq_percom , "
    cQuery +=CRLF+"       bxq_numpar , "
    cQuery +=CRLF+"       PE9_JUSTIF   "

	If Select((cAliasMost)) <> 0 
	          (cAliasMost)->(DbCloseArea())  
	Endif                          

	TCQuery cQuery New Alias (cAliasMost)   

    (cAliasMost)->( DbGoTop() )  

	While !(cAliasMost)->(EOF())

		aAdd(aLogLista,{ trim((cAliasMost)->vendedor)                               ,;    //1
						transform((cAliasMost)->bacom,"@E 999,999,999.99") ,;    //2
                        transform(( ( (cAliasMost)->vlcom / (cAliasMost)->bacom) *100),"@E 999.9999") ,;//3	
						transform((cAliasMost)->vlcom,"@E 999,999,999.99") ,;    //4
						transform(iif((cAliasMost)->vlcom < 0, ((cAliasMost)->qtda*-1), (cAliasMost)->qtda) ,"@E 999,999") ,;    //5
						trim((cAliasMost)->percom) ,;  //6
						iif(trim((cAliasMost)->parcela)=='777', 'X',trim((cAliasMost)->parcela))  ,; //7
						iif((cAliasMost)->parcela=='777', 'Cobr/Dev', (iif((cAliasMost)->vlcom<0, 'Recuperação', (cAliasMost)->agenc))) ,;//8
						iif(TRIM((cAliasMost)->idadLim)=='', 'Não', 'Sim') ,;    //9
						(cAliasMost)->Obs })     //10 

	    	nbascomT+=(cAliasMost)->bacom
	    	nVlrcomT+=(cAliasMost)->vlcom
	    	nQtdat  += iif((cAliasMost)->vlcom<0, ((cAliasMost)->qtda*-1), (cAliasMost)->qtda)
	
		(cAliasMost)->(DbSkip())

	EndDo

                  aAdd(aLogLista,{'Totais --->'                               ,;    //1
						transform(nbascomT,"@E 999,999,999.99")   ,;    //2
                        transform(((nVlrcomT/nbascomT) *100),"@E 999.9999") ,;	//3	
						transform(nVlrcomT,"@E 999,999,999.99")   ,;    //4
						transform(nQtdat  ,"@E 999,999")          ,;    //5
						' '                                       ,; //6
						' '                                       ,; //7
						(cAliasMost)->Agenc                                  ,;    //8
						(cAliasMost)->idadLim                                ,;    //9
						(cAliasMost)->Obs                                   })     //10 

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Detalhe dp titulo de comisso                                             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If  len(aLogLista) > 0
		PLSCRIGEN(aLogLista,{{'Vendedor ',"@!",60}    ,;
		                     {'Faturamento',"@!",30}  ,;
							 {'% Calculado',"@!",15}  ,;
							 {'Comissão',"@!",25}     ,;
							 {'Vidas',"@!",15}        ,;
							 {'Regra ',"@!",15}       ,;
							 {'Parcela ',"@!",10}     ,;
							 {'Tipo  ',"@!",25}       ,;
							 {'Idade Limite',"@!",12} ,;
							 {'Observações',"@!",100}},;
							 'Detalhes da Comissão',nil,nil) 
	Endif
    desmarca()
EndIF
nbascomT:= 0.00
nVlrcomT:= 0.00
nQtdat  := 0

Return()
////////////////////////////////////////////////
static Function fMSinsEmp()

local aLogLtaSv := {}
local cquerySv  := ' '     
local nSinsTot  := 0.0000
local cEmptot   := ' '
local ncontSv   := 0  
local cCodempM  := substr(aBrwPEG[oBrwPEG:nAt,11],1,4)
local nSintot   := aBrwPEG[oBrwPEG:nAt,23]
local nCustTot  := 0
local nMensTot  := 0
local nSinst    := 0.0000

if nOrigem1 == 1

	cQuerySv :=     "  SELECT codemp CodEmp , Bg9.Bg9_Descri Emp , mes_ano_ref Compte ,"
    cQuerySv +=CRLF+"          Decode(Sum(MENSA),0,0,round((Sum(APROVADO-PART))/Sum(MENSA),6))*100 sinist ,"
	cQuerySv +=CRLF+"          Decode(Sum(MENSA),0,0,round((Sum(APROVADO-PART)))) custo, Sum(MENSA) mensal ," 

	cQuerySv +=CRLF+"          SUM(case when ( matric <> ' ' and MENSA > 0) THEN 1 ELSE 0 END) QTDAVID " 

If  cEmpCI=='I'
    cQuerySv +=CRLF+"   FROM COB_SINISTRALIDADE_MS_INT , bg9020 bg9  "
Else
    cQuerySv +=CRLF+"   FROM COB_SINISTRALIDADE_MS_CAB , bg9010 bg9 "
EndIf	
    cQuerySv +=CRLF+"  where MES_ANO_REF between TO_DATE('"+DtOS(stod('20'+cAnoAnt+cMesAnt+'01'))+"','YYYYMMDD') and TO_DATE('"+DtOS(stod('20'+cAnoAtu+cMesAtu+'01'))+"','YYYYMMDD')"

    cQuerySv +=CRLF+"    and bg9_filial = ' ' and d_E_L_E_T_ =' ' "
    cQuerySv +=CRLF+"    and bg9_codint ='0001' and bg9_codigo = codemp "

    cQuerySv +=CRLF+"   AND CODEMP = '"+cCodempM +"'"
    
	//cQuery += CRLF + "    group by  codemp, Bg9.Bg9_Descri , trim(substr(mes_ano_ref,4,2)||'/'||'20'||substr(mes_ano_ref,7,2)) "
	cQuerySv += CRLF + "    group by  codemp , Bg9.Bg9_Descri , mes_ano_ref " 
	cQuerySv += CRLF + "    order by 1,2 "

	If Select((cAliasMSV)) <> 0 
	          (cAliasMSV)->(DbCloseArea())  
	Endif                          

	TCQuery cQuerySv New Alias (cAliasMSV)   

    (cAliasMSV)->( DbGoTop() )  

	While !(cAliasMSV)->(EOF())
        
		If  cEmptot   == ' '
		    cEmptot   := (cAliasMSV)->codEmp
	    EndIf  		
		
		If cEmptot == (cAliasMSV)->codEmp
			
		    ncontSv += 1
            nSinsTot+= (cAliasMSV)->sinist
            
			nCustTot  += (cAliasMSV)->custo
            nMensTot  += (cAliasMSV)->mensal
             
        Else 
		
		    nSinst    := (nMensTot/nCustTot) * 100
			 
		    aAdd(aLogLtaSv,{' ',; 
		    'Total Empresa'   ,;    
		    ' ' ,;    //2
            transform((((nCustTot /nMensTot)*100)) ,"@E 9999.99")+'%' ,;
			' '  })    
          
		    //transform(((nSinsTot/ncontSv)) ,"@E 9999.9999") })     //3
		    cEmptot   := (cAliasMSV)->codEmp
            
			ncontSv := 1
            nSinsTot:= (cAliasMSV)->sinist
            
			nCustTot  := (cAliasMSV)->custo
            nMensTot  := (cAliasMSV)->mensal
		EndIf 

		aAdd(aLogLtaSv,{ (cAliasMSV)->codEmp   ,; 
			             trim((cAliasMSV)->Emp)   ,;    //1
						 substr(dtos((cAliasMSV)->Compte ),5,2)+'/'+substr(dtos((cAliasMSV)->Compte ),1,4),;    //2
                         transform((cAliasMSV)->sinist ,"@E 9999.99")+'%'  ,;
						 transform((cAliasMSV)->QTDAVID  ,"@E 99,999")})     //3 
	
		(cAliasMSV)->(DbSkip())

	EndDo

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Detalhe dp titulo de comisso                                             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If  len(aLogLtaSv) > 0

		    aAdd(aLogLtaSv,{' ',;
		    'Total Sinistralidade da Empresa' ,;    //1
		    ' ' ,;    //2
            transform((((nCustTot /nMensTot)*100)) ,"@E 9999.99")+'%' ,;
			' '  })     //3
/*
		    aAdd(aLogLtaSv,{'----- ',;
		                    ' ' ,;    //1
		                    ' ' ,;    //2
                            ' ' ,;
			                ' '  })     //3
*/
		PLSCRIGEN(aLogLtaSv,{{'Cod Empresa',"@!",30}    ,;
		                     {'Empresa Contratante',"@!",120}    ,;
		                     {'Competencia',"@!",30}  ,;
							 {'% Sinistralidade',"@!",35},;
							 {'Vidas Ativas',"@!",25}},;
   							  'Sinistralidade Empresa ',nil,nil) 
	Endif
    desmarca()
EndIF
nbascomT:= 0.00
nVlrcomT:= 0.00
nQtdat  := 0

Return()

/////////////////////////////////////////////////
static Function fMSinsVend()

local aLogLtaSv := {}
local cquerySv  := ' '     
local nSinsTot  := 0.0000
local cEmptot   := ' '
local ncontSv   := 0  
local cCodVenM  := substr(aBrwPEG[oBrwPEG:nAt,12],1,6)
local nSintot   := aBrwPEG[oBrwPEG:nAt,23]
local nCustTot  := 0
local nMensTot  := 0
local nSinst    := 0.0000

if nOrigem1 == 1

	cQuerySv :=     "  SELECT codemp CodEmp , Bg9.Bg9_Descri Emp , mes_ano_ref Compte ,"
    cQuerySv +=CRLF+"          Decode(Sum(MENSA),0,0,round((Sum(APROVADO-PART))/Sum(MENSA),6))*100 sinist ,"
	cQuerySv +=CRLF+"          Decode(Sum(MENSA),0,0,round((Sum(APROVADO-PART)))) custo, Sum(MENSA) mensal ," 

	cQuerySv +=CRLF+"          SUM(case when ( matric <> ' ' and MENSA > 0) THEN 1 ELSE 0 END) QTDAVID " 

If  cEmpCI=='I'
    cQuerySv +=CRLF+"   FROM COB_SINISTRALIDADE_MS_INT , bg9020 bg9  "
Else
    cQuerySv +=CRLF+"   FROM COB_SINISTRALIDADE_MS_CAB , bg9010 bg9 "
EndIf	
    cQuerySv +=CRLF+"  where MES_ANO_REF between TO_DATE('"+DtOS(stod('20'+cAnoAnt+cMesAnt+'01'))+"','YYYYMMDD') and TO_DATE('"+DtOS(stod('20'+cAnoAtu+cMesAtu+'01'))+"','YYYYMMDD')"

    cQuerySv +=CRLF+"    and bg9_filial = ' ' and d_E_L_E_T_ =' ' "
    cQuerySv +=CRLF+"    and bg9_codint ='0001' and bg9_codigo = codemp "

    cQuerySv +=CRLF+"   AND CODEMP in  "
    cQuerySv +=CRLF+" (select distinct bxq_codemp FROM siga."+RetSQLName("BXQ")+" BXQ "
    cQuerySv += CRLF + "  WHERE BXQ_FILIAL = '" + xFilial('BXQ') + "' AND D_e_l_e_t_ = ' ' "
    cQuerySv += CRLF + "    and bxq_codven = '"+cCodVenM+"' "
    cQuerySv += CRLF + "    and bxq_ano = '"+'20'+cAnoAtu+"' and bxq_mes = '"+cMesAtu+"')"
    
	//cQuery += CRLF + "    group by  codemp, Bg9.Bg9_Descri , trim(substr(mes_ano_ref,4,2)||'/'||'20'||substr(mes_ano_ref,7,2)) "
	cQuerySv += CRLF + "    group by  codemp , Bg9.Bg9_Descri , mes_ano_ref " 
	cQuerySv += CRLF + "    order by 1,2 "

	If Select((cAliasMSV)) <> 0 
	          (cAliasMSV)->(DbCloseArea())  
	Endif                          

	TCQuery cQuerySv New Alias (cAliasMSV)   

    (cAliasMSV)->( DbGoTop() )  

	While !(cAliasMSV)->(EOF())
        
		If  cEmptot   == ' '
		    cEmptot   := (cAliasMSV)->codEmp
	    EndIf  		
		
		If cEmptot == (cAliasMSV)->codEmp
			
		    ncontSv += 1
            nSinsTot+= (cAliasMSV)->sinist
            
			nCustTot  += (cAliasMSV)->custo
            nMensTot  += (cAliasMSV)->mensal
             
        Else 
		
		    nSinst    := (nMensTot/nCustTot) * 100
			 
		    aAdd(aLogLtaSv,{' ',; 
		    'Total Empresa'   ,;    
		    ' ' ,;    //2
            transform((((nCustTot /nMensTot)*100)) ,"@E 9999.99")+'%' ,;
			' '  })    
          
		    //transform(((nSinsTot/ncontSv)) ,"@E 9999.9999") })     //3
		    cEmptot   := (cAliasMSV)->codEmp
            
			ncontSv := 1
            nSinsTot:= (cAliasMSV)->sinist
            
			nCustTot  := (cAliasMSV)->custo
            nMensTot  := (cAliasMSV)->mensal
		EndIf 

		aAdd(aLogLtaSv,{ (cAliasMSV)->codEmp   ,; 
			             trim((cAliasMSV)->Emp)   ,;    //1
						 substr(dtos((cAliasMSV)->Compte ),5,2)+'/'+substr(dtos((cAliasMSV)->Compte ),1,4),;    //2
                         transform((cAliasMSV)->sinist ,"@E 9999.99")+'%'  ,;
						 transform((cAliasMSV)->QTDAVID  ,"@E 99,999")})     //3 
	
		(cAliasMSV)->(DbSkip())

	EndDo

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Detalhe dp titulo de comisso                                             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If  len(aLogLtaSv) > 0

		    aAdd(aLogLtaSv,{' ',;
		    'Total da Empresa' ,;    //1
		    ' ' ,;    //2
            transform((((nCustTot /nMensTot)*100)) ,"@E 9999.99")+'%' ,;
			' '  })     //3

		    aAdd(aLogLtaSv,{'----- ',;
		                    ' ' ,;    //1
		                    ' ' ,;    //2
                            ' ' ,;
			                ' '  })     //3

            aAdd(aLogLtaSv,{' ',;
		                    'Sinistralidade Media do Corretor' ,;    //1
		    ' ' ,;    //2
            transform((nSintot) ,"@E 9999.99")+'%' ,;
			' '  })     //3

		PLSCRIGEN(aLogLtaSv,{{'Cod Empresa',"@!",30}    ,;
		                     {'Empresa Contratante',"@!",120}    ,;
		                     {'Competencia',"@!",30}  ,;
							 {'% Sinistralidade',"@!",35},;
							 {'Vidas Ativas',"@!",25}},;
   							  'Sinistralidade Corretor',nil,nil) 
	Endif
    desmarca()
EndIF
nbascomT:= 0.00
nVlrcomT:= 0.00
nQtdat  := 0

Return()


/////////
static Function fMostInfE()

local aLogLista := {}
local cquery    := ' '     
local cVendedor := ' ' 
local cAnoM    := substr(aBrwPEG[oBrwPEG:nAt,2],1,4)
local cMesM    := substr(aBrwPEG[oBrwPEG:nAt,2],5,2)
local cCodempM := substr(aBrwPEG[oBrwPEG:nAt,11],1,4)
local cCodVenM := substr(aBrwPEG[oBrwPEG:nAt,12],1,6)
Local nVlCT     := 0
if nOrigem1 == 1

	cQuery :="  select bxqa.vendedor vendedor       , "
    cQuery +=CRLF+"         sum(bxqa.bacom) bacom   , "
	cQuery +=CRLF+"         trim(bxqa.percom) percom  , "
	cQuery +=CRLF+"         sum(bxqa.vlcom) vlcom   , "
	cQuery +=CRLF+"         sum(bxqa.qtda) qtda     , "
	cQuery +=CRLF+"         bxqa.obs     obs        , "
	cQuery +=CRLF+"         bxqa.idadLim idadLim    , "
	cQuery +=CRLF+"         bxqa.agenc   agenc       , "
	
    cQuery +=CRLF+"         decode(bxqa.agenc ,'Agenciamento',bxqa.numpar , 'X') parcela "  

	cQuery +=CRLF+"    from ("

	cQuery +=CRLF+"  select bxq.codven ||'-'|| bxq.nomvend vendedor, " 
	cQuery +=CRLF+"    sum(bxq.bascom) bacom    , "
	cQuery +=CRLF+"    bxq.percom||'%' percom  , "
	cQuery +=CRLF+"    sum(bxq.vlrcom) vlcom    , " 
	cQuery +=CRLF+"    sum(bxq.qtda) qtda       , "

    cQuery +=CRLF+"    bxop.obs     obs         , "
    cQuery +=CRLF+"    bxop.idadLim idadLim     , "
    cQuery +=CRLF+"    bxop.agenc   agenc       , "

	cQuery +=CRLF+"    bxq.numpar   numpar        "

	cQuery +=CRLF+"    from( select bxq_codven codven      , "
	cQuery +=CRLF+"                 a3_nome nomvend        , "
	cQuery +=CRLF+"                 bxq_numpar numpar      , "
	cQuery +=CRLF+"                 count(*) qtda          , "
	cQuery +=CRLF+"                 Bxq_Percom      percom , "
	cQuery +=CRLF+"                 sum(bxq_vlrcom) vlrcom , "
	cQuery +=CRLF+"                 sum(bxq_bascom) bascom , "
	cQuery +=CRLF+"                 bxq_codemp codemp      , "
	cQuery +=CRLF+"                 bxq_matric matric      , "
	cQuery +=CRLF+"                 bxq_tipreg tipreg      , "
	cQuery +=CRLF+"                 a3_nome Vend           , "
	cQuery +=CRLF+"                 ba1_conemp conemp      , "
	cQuery +=CRLF+"                 ba1_subcon subcon      , "
	cQuery +=CRLF+"                 ba1_Tipinc  tipInc       "
	cQuery +=CRLF+"            From " + RetSqlName("BXQ") +" BXQ , " + RetSqlName("SA3") +" SA3 ," + RetSqlName("BA1") +" BA1 " 

	cQuery +=CRLF+"           where bxQ_filial  ='"+xFilial('BXQ')+ "' and bxQ.d_E_L_E_T_ = ' ' "
	cQuery +=CRLF+"             and   A3_filial ='"+xFilial('SA3')+ "'  and SA3.d_E_L_E_T_ = ' ' "
	cQuery +=CRLF+"             and  BA1_filial ='"+xFilial('BA1')+ "'  and BA1.d_E_L_E_T_ = ' ' " 
	cQuery +=CRLF+"             and bxq_codint = ba1_codint "
	cQuery +=CRLF+"             and bxq_codemp = ba1_codemp "
	cQuery +=CRLF+"             and bxq_matric = ba1_matric "
	cQuery +=CRLF+"             and bxq_tipreg = ba1_tipreg "
	cQuery +=CRLF+"             and bxq_codven = a3_cod "    
	cQuery +=CRLF+"             and bxq_vlrcom > 0  "        

	cQuery +=CRLF+"             and bxq_codemp = '"+cCodempM+"'  " 
//	cQuery +=CRLF+"             and bxq_codven = '"+cCodVenM+"'  "
	cQuery +=CRLF+"             and bxq_ano    = '"+cAnoM+"'  "
	cQuery +=CRLF+"             and bxq_mes    = '"+cMesM+"'  "

	cQuery +=CRLF+"             and bxq_pagcom = bxq_refere "
	cQuery +=CRLF+"        group by bxq_codven , bxq_numpar , bxq_codemp , bxq_matric , "
	cQuery +=CRLF+"                 bxq_tipreg, Bxq.Bxq_Percom ,a3_nome , ba1_conemp  , ba1_subcon ,ba1_tipinc  )bxq , "
	
cQuery +=CRLF+"  (select bxo_codven codven , 
cQuery +=CRLF+"          bxo_codemp codemp , 
cQuery +=CRLF+"          bxo_matric matric , 
cQuery +=CRLF+"          bxo_tipreg tipreg , 
cQuery +=CRLF+"          NVL(BXJK.bxk_qtdde,'001') qtdde   , 
cQuery +=CRLF+"          NVL(BXJK.bxk_qtdate,'999') qtdate , 
cQuery +=CRLF+"          NVL(BXJK.bxk_obs,' ') Obs         ,
cQuery +=CRLF+"          nvl(BXJK.bxj_Yidisn,' ')  idadLim ,

if  cempant == '01'
    cQuery +=CRLF+"                decode(NVL(bxjk.BXK_AGENCI,' ') ,'1', 'Agenciamento', 'Vitalicio') agenc 
Else 
    cQuery +=CRLF+"                decode(NVL(bxjk.BXK_AGENC,' ') ,'1', 'Agenciamento', 'Vitalicio') agenc 
EndIf

cQuery +=CRLF+"       From " + RetSqlName("BXO") +" BXO , "  
cQuery +=CRLF+"            (select * from  "+ RetSqlName("BXJ") +" BXJ , "+ RetSqlName("BXK") +" BXK " 
cQuery +=CRLF+"              where BXJ_filial = '"+xFilial('BXJ')+ "'  and bxj.d_E_L_E_T_ = ' ' "
cQuery +=CRLF+"                and BXK_filial = '"+xFilial('BXK')+ "'  and bxk.d_E_L_E_T_ = ' ' "
cQuery +=CRLF+"                AND BXK_SEQBXJ = BXJ_SEQ
cQuery +=CRLF+"                AND BXJ_CODEMP = '0010') BXJK 
cQuery +=CRLF+"              where BXO_filial = '  '  and bxo.d_E_L_E_T_ = ' '
cQuery +=CRLF+"                and bxo_codemp = '"+cCodEmpM+"' "
//cQuery +=CRLF+"                and bxo_codven = '"+cCodVenM+"' "
cQuery +=CRLF+"                and BXJK.bxj_seq(+)    = bxo_seqbxj 	) bxop " 
	
	cQuery +=CRLF+"           where bxq.codven = bxop.codven   "
	cQuery +=CRLF+"             and bxq.numpar >= bxop.qtdde   "
	cQuery +=CRLF+"             and bxq.numpar <= bxop.qtdate  "
	cQuery +=CRLF+"             and bxq.codemp = bxop.codemp   "
	cQuery +=CRLF+"             and bxq.matric = bxop.matric   "
	cQuery +=CRLF+"             and bxq.tipreg = bxop.tipreg   "
	cQuery +=CRLF+"        group by bxq.codven , bxq.nomvend , "
	cQuery +=CRLF+"                 bxop.qtdde||' a '||bxop.qtdate , bxq.percom||'%' , "
    cQuery +=CRLF+"                 bxop.obs , bxop.idadLim , bxop.agenc , bxq.numpar  "

	cQuery +=CRLF+" union all "  
    
	cQuery +=CRLF+"    select bxq.codven ||'-'|| bxq.nomvend vendedor , "
	cQuery +=CRLF+"           sum(bxq.bascom) bacom    , "
	cQuery +=CRLF+"           bxq.percom||'%' percom   , "
	cQuery +=CRLF+"           sum(bxq.vlrcom) vlcom    , "
	cQuery +=CRLF+"           sum(bxq.qtda) qtda       , "

    cQuery +=CRLF+"           bxop.obs     obs         , "
    cQuery +=CRLF+"		      bxop.idadLim idadLim     , "
    cQuery +=CRLF+"    		  bxop.agenc   agenc       , "

	cQuery +=CRLF+"           bxq.numpar   numpar        "

	cQuery +=CRLF+"      from( select bxq_codven codven      , " 
	cQuery +=CRLF+"                   a3_nome nomvend        , " 
	cQuery +=CRLF+"                   bxq_numpar numpar      , " 
	cQuery +=CRLF+"                   count(*) qtda          , " 
	cQuery +=CRLF+"                   Bxq_Percom  Percom     , " 
	cQuery +=CRLF+"                   sum(bxq_vlrcom) vlrcom , "
	cQuery +=CRLF+"                   sum(bxq_bascom) bascom , "
	cQuery +=CRLF+"                   bxq_codemp codemp      , "
	cQuery +=CRLF+"                   bxq_matric matric      , "
	cQuery +=CRLF+"                   bxq_tipreg tipreg      , "
	cQuery +=CRLF+"                   a3_nome Vend           , "
	cQuery +=CRLF+"                   ba1_conemp conemp      , "
	cQuery +=CRLF+"                   ba1_subcon subcon      , "
	cQuery +=CRLF+"                   ba1_Tipinc  tipInc       "
	cQuery +=CRLF+"              From " + RetSqlName("BXQ") +" BXQ , " + RetSqlName("SA3") +" SA3 ," + RetSqlName("BA1") +" BA1 " 
	cQuery +=CRLF+"             where bxQ_filial = '"+xFilial('BXQ')+ "'  and bxQ.d_E_L_E_T_ = ' ' "
	cQuery +=CRLF+"               and A3_filial  = '"+xFilial('SA3')+ "'  and SA3.d_E_L_E_T_ = ' ' "
	cQuery +=CRLF+"               and BA1_filial = '"+xFilial('BA1')+ "'  and BA1.d_E_L_E_T_ = ' ' "
	cQuery +=CRLF+"               and bxq_codint = ba1_codint "
	cQuery +=CRLF+"               and bxq_codemp = ba1_codemp "
	cQuery +=CRLF+"               and bxq_matric = ba1_matric "
	cQuery +=CRLF+"               and bxq_tipreg = ba1_tipreg "
	cQuery +=CRLF+"               and bxq_codven = a3_cod     "
	cQuery +=CRLF+"               and bxq_vlrcom < 0          "

	cQuery +=CRLF+"               and bxq_codemp = '"+cCodEmpM+"' "     
//	cQuery +=CRLF+"               and bxq_codven = '"+cCodVenM+"' "
	cQuery +=CRLF+"               and bxq_ano    = '"+cAnoM+"' "     
	cQuery +=CRLF+"               and bxq_mes    = '"+cMesM+"' "       

	cQuery +=CRLF+"               and bxq_pagcom = bxq_refere "
	cQuery +=CRLF+"          group by bxq_codven , bxq_numpar , bxq_codemp , bxq_matric , "
	cQuery +=CRLF+"                   bxq_tipreg, Bxq_Percom ,a3_nome , ba1_conemp  , ba1_subcon ,ba1_tipinc  )bxq , " 

cQuery +=CRLF+"  (select bxo_codven codven , 
cQuery +=CRLF+"          bxo_codemp codemp , 
cQuery +=CRLF+"          bxo_matric matric , 
cQuery +=CRLF+"          bxo_tipreg tipreg , 
cQuery +=CRLF+"          NVL(BXJK.bxk_qtdde,'001') qtdde   , 
cQuery +=CRLF+"          NVL(BXJK.bxk_qtdate,'999') qtdate , 
cQuery +=CRLF+"          NVL(BXJK.bxk_obs,' ') Obs         ,
cQuery +=CRLF+"          nvl(BXJK.bxj_Yidisn,' ')  idadLim ,

if  cempant == '01'
    cQuery +=CRLF+"                decode(NVL(bxjk.BXK_AGENCI,' ') ,'1', 'Agenciamento', 'Vitalicio') agenc 
Else 
    cQuery +=CRLF+"                decode(NVL(bxjk.BXK_AGENC,' ') ,'1', 'Agenciamento', 'Vitalicio') agenc 
EndIf

cQuery +=CRLF+"       From " + RetSqlName("BXO") +" BXO , "  
cQuery +=CRLF+"            (select * from "+ RetSqlName("BXJ") +" BXJ , "+ RetSqlName("BXK") +" BXK " 
cQuery +=CRLF+"              where BXJ_filial = '"+xFilial('BXJ')+ "'  and bxj.d_E_L_E_T_ = ' ' "
cQuery +=CRLF+"                and BXK_filial = '"+xFilial('BXK')+ "'  and bxk.d_E_L_E_T_ = ' ' "
cQuery +=CRLF+"                AND BXK_SEQBXJ = BXJ_SEQ
cQuery +=CRLF+"                AND BXJ_CODEMP = '0010') BXJK 
cQuery +=CRLF+"              where BXO_filial = '  '  and bxo.d_E_L_E_T_ = ' '
cQuery +=CRLF+"                and bxo_codemp = '"+cCodEmpM+"' "
//cQuery +=CRLF+"                and bxo_codven = '"+cCodVenM+"' "
cQuery +=CRLF+"                and BXJK.bxj_seq(+)    = bxo_seqbxj ) bxop "


	cQuery +=CRLF+"   where bxq.codven  = bxop.codven  "
	cQuery +=CRLF+"     and bxq.numpar >= bxop.qtdde   "
	cQuery +=CRLF+"     and bxq.numpar <= bxop.qtdate  "
	cQuery +=CRLF+"     and bxq.codemp  = bxop.codemp  "
	cQuery +=CRLF+"     and bxq.matric  = bxop.matric  "
	cQuery +=CRLF+"     and bxq.tipreg  = bxop.tipreg  "
	cQuery +=CRLF+"   group by bxq.codven   , bxq.nomvend , "
	cQuery +=CRLF+"         bxq.percom||'%' , bxop.obs    , "
    cQuery +=CRLF+"         bxop.idadLim    , bxop.agenc  , bxq.numpar ) bxqa "

    cQuery +=CRLF+"   group by bxqa.vendedor    , "
    cQuery +=CRLF+"            bxqa.percom      , "
    cQuery +=CRLF+"            bxqa.obs         , "
    cQuery +=CRLF+"            bxqa.idadLim     , "
    cQuery +=CRLF+"            bxqa.agenc       , "

	cQuery +=CRLF+"            decode(bxqa.agenc ,'Agenciamento',bxqa.numpar , 'X')" 

	cQuery +=CRLF+" union all "  
    
	cQuery +=CRLF+" select bxq_codven ||'-'|| a3_nome  vendedor , " 
    cQuery +=CRLF+"        sum(bxq_bascom) bacom    , "
	cQuery +=CRLF+"        bxq_percom||'%' percom   , "
	cQuery +=CRLF+"        sum(bxq_vlrcom) vlcom    , "
	cQuery +=CRLF+"        count(*)        qtda     , "
    cQuery +=CRLF+"        PE9_JUSTIF      obs      , "
	cQuery +=CRLF+"        ' '             idadLim  , "
	cQuery +=CRLF+"        'NAO'           agenc    , "
	cQuery +=CRLF+"        bxq_numpar      numpar     "

	cQuery +=CRLF+"   FROM  " + RetSqlName("BXQ") +" BXQ , " + RetSqlName("PE9") +" PE9 , "+ RetSqlName("SA3") +" SA3 " 
    
	cQuery +=CRLF+"  where BXQ_filial = '"+xFilial('BXO')+ "'  and BXQ.d_E_L_E_T_ = ' ' "
    cQuery +=CRLF+"    and PE9_filial = '"+xFilial('PE9')+ "'  and PE9.d_E_L_E_T_ = ' ' "
    cQuery +=CRLF+"    and  A3_filial = '"+xFilial('SA3')+ "'  and SA3.d_E_L_E_T_ = ' ' "

	cQuery +=CRLF+"    and bxq_codemp = '"+cCodEmpM+"' "     
	//cQuery +=CRLF+"    and bxq_codven = '"+cCodVenM+"' "
	cQuery +=CRLF+"    and bxq_ano    = '"+cAnoM+"' "     
	cQuery +=CRLF+"    and bxq_mes    = '"+cMesM+"' "       
	
	cQuery +=CRLF+"    AND PE9_COMPTE = '"+cAnoM+"/"+cMesM+"' " 
    cQuery +=CRLF+"    AND PE9_CODEMP = '"+cCodEmpM+"' "
   
   // cQuery +=CRLF+"    AND PE9_CODVEN = '"+cCodVenM+"' "

	cQuery +=CRLF+"    and bxq_pagcom = bxq_refere "
    cQuery +=CRLF+"    and bxq_codven = a3_cod     "
    cQuery +=CRLF+"    and bxq_numpar = '777'      "
    cQuery +=CRLF+"  GROUP BY bxq_codven ||'-'|| a3_nome , " 
	cQuery +=CRLF+"       bxq_percom , "
    cQuery +=CRLF+"       bxq_numpar , "
    cQuery +=CRLF+"       PE9_JUSTIF   "

	cQuery +=CRLF+"       order by 1 "

	If Select((cAliasMost)) <> 0 
	          (cAliasMost)->(DbCloseArea())  
	Endif                          

	TCQuery cQuery New Alias (cAliasMost)   

    (cAliasMost)->( DbGoTop() )  

	While !(cAliasMost)->(EOF())

        If cVendedor == ' ' 
	       cVendedor := (cAliasMost)->vendedor
		EndIf 

		If cVendedor != (cAliasMost)->vendedor  	
          aAdd(aLogLista,{'Totais do Vendedor --->'               ,;    //1
						transform(nbascomT,"@E 999,999,999.99")   ,;    //2
                         transform(((nVlrcomT/nbascomT) *100),"@E 999.9999") ,;	//3	
						transform(nVlrcomT,"@E 999,999,999.99")   ,;    //4
						transform(nQtdat  ,"@E 999,999")          ,;    //5
						' '                                       ,;    //6
						' '                                       ,;    //7
						' '                                       ,;    //8
						' '                                       ,;    //9
						' '                                       })    //10
		nbascomT:= 0.00
        nVlrcomT:= 0.00
        nQtdat  := 0 
		cVendedor := (cAliasMost)->vendedor

        EndIF

		aAdd(aLogLista,{ trim((cAliasMost)->vendedor)                               ,;    //1
						transform((cAliasMost)->bacom,"@E 999,999,999.99") ,;    //2
                        transform(( ( (cAliasMost)->vlcom / (cAliasMost)->bacom) *100),"@E 999.9999") ,;//3	
						transform((cAliasMost)->vlcom,"@E 999,999,999.99") ,;    //4
						transform(iif((cAliasMost)->vlcom < 0, ((cAliasMost)->qtda*-1), (cAliasMost)->qtda) ,"@E 999,999") ,;    //5
						trim((cAliasMost)->percom) ,;  //6
						iif(trim((cAliasMost)->parcela)=='777', 'X',trim((cAliasMost)->parcela))  ,; //7
						iif((cAliasMost)->parcela=='777', 'Cobr/Dev', (iif((cAliasMost)->vlcom<0, 'Recuperação', (cAliasMost)->agenc))) ,;//8
						iif(TRIM((cAliasMost)->idadLim)=='', 'Não', 'Sim') ,;    //9
						(cAliasMost)->Obs })     //10 

	    	nbascomT+=(cAliasMost)->bacom
	    	nVlrcomT+=(cAliasMost)->vlcom
	    	nQtdat  += iif((cAliasMost)->vlcom<0, ((cAliasMost)->qtda*-1), (cAliasMost)->qtda)
	
	        nVlCT   += (cAliasMost)->vlcom 
		(cAliasMost)->(DbSkip())

	EndDo

                  aAdd(aLogLista,{'Totais do Corretor --->'       ,;    //1
						transform(nbascomT,"@E 999,999,999.99")   ,;    //2
                        transform(((nVlrcomT/nbascomT) *100),"@E 999.9999") ,;	//3	
						transform(nVlrcomT,"@E 999,999,999.99")   ,;    //4
						transform(nQtdat  ,"@E 999,999")          ,;    //5
						' '                                       ,;    //6
						' '                                       ,;    //7
						' '                                       ,;    //8
						' '                                       ,;    //9
						' '                                       })    //10 

        aAdd(aLogLista,{' '       ,;    //1
						' '   ,;    //2
                        ' ' ,;	//3	
						' '   ,;    //4
						' '         ,;    //5
						' '                                       ,;    //6
						' '                                       ,;    //7
						' '                                       ,;    //8
						' '                                       ,;    //9
						' '                                       })    //10 

                  aAdd(aLogLista,{'Totais de Comercialização  --->'       ,;    //1
						' '   ,;    //2
                        ' ' ,;	//3	
						transform(nVlCT,"@E 999,999,999.99")   ,;    //4
						' '         ,;    //5
						' '                                       ,;    //6
						' '                                       ,;    //7
						' '                                       ,;    //8
						' '                                       ,;    //9
						' '                                       })    //10 

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Detalhe dp titulo de comisso                                             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If  len(aLogLista) > 0
		PLSCRIGEN(aLogLista,{{'Vendedor ',"@!",60}    ,;
		                     {'Faturamento',"@!",30}  ,;
							 {'% Calculado',"@!",15}  ,;
							 {'Comissão',"@!",25}     ,;
							 {'Vidas',"@!",15}        ,;
							 {'Regra ',"@!",15}       ,;
							 {'Parcela ',"@!",10}     ,;
							 {'Tipo  ',"@!",25}       ,;
							 {'Idade Limite',"@!",12} ,;
							 {'Observações',"@!",100}},;
							 'Detalhes da Comissão Por Empresa',nil,nil) 
	Endif
    desmarca()
EndIF
nbascomT:= 0.00
nVlrcomT:= 0.00
nQtdat  := 0

Return()


static Function fRkAdm1()

local aLogLtaRk1:= {}
local cqueryRkS1:= ' '     
local nSinsTot  := 0.0000
local cEmptot   := ' '
local ncontSv   := 0  
local cCodVenM  := substr(aBrwPEG[oBrwPEG:nAt,12],1,6)
local nSintot   := aBrwPEG[oBrwPEG:nAt,23]
local nCustTot  := 0
local nMensTot  := 0
local nSinst    := 0.0000

if nOrigem1 == 1

	cqueryRkS1 :=     " SELECT codemp CodEmp , Bg9.Bg9_Descri Emp_1 , "
	cQueryRkS1 +=CRLF+"        (CASE WHEN Decode(Sum(MENSA),0,0,round((Sum(APROVADO-PART))/Sum(MENSA),6))*100 < 66 THEN              '1-Até 65%'     "
	cQueryRkS1 +=CRLF+"              WHEN Decode(Sum(MENSA),0,0,round((Sum(APROVADO-PART))/Sum(MENSA),6))*100 BETWEEN 66 AND 70 THEN '2-de 66 a 70%' "
	cQueryRkS1 +=CRLF+"              WHEN Decode(Sum(MENSA),0,0,round((Sum(APROVADO-PART))/Sum(MENSA),6))*100 BETWEEN 71 AND 80 THEN '3-de 71 a 80%' "
	cQueryRkS1 +=CRLF+"              ELSE                                    '4-acima de 80%' END) GRPSINIS  "
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
	    cQueryRkS1 +=CRLF+"    and bg9_codigo = '"+substr(aBrwPEG[oBrwPEG:nAt,11],1,4)+"' "
    EndIf

	cQueryRkS1 +=CRLF+"  having Decode(Sum(MENSA),0,0,round((Sum(APROVADO-PART))/Sum(MENSA),6))*100 > 0 "
	cQueryRkS1 +=CRLF+"  group by  codemp , Bg9.Bg9_Descri " 
	cQueryRkS1 +=CRLF+"  order by 3 "


		If Select((cAliasRkC1)) <> 0 
				(cAliasRkC1)->(DbCloseArea())  
		Endif                          

		TCQuery cQueryRkS1 New Alias (cAliasRkC1)   

		(cAliasRkC1)->( DbGoTop() )  

		While !(cAliasRkC1)->(EOF())

			aAdd(aLogLtaRk1,{ (cAliasRkC1)->codEmp        ,; 
							trim((cAliasRkC1)->Emp_1)   ,;    //1
							(cAliasRkC1)->GRPSINIS })     //3 
		
			(cAliasRkC1)->(DbSkip())

		EndDo

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Detalhe dp titulo de comisso                                             ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If  len(aLogLtaRk1) > 0

			PLSCRIGEN(aLogLtaRk1,{{'Cod Empresa',"@!",20}     ,;
								{'Administradora',"@!",120} ,;
								{'Classificaçõa' ,"@!",50} },;
								'Pesquisa por '+cTitPesq+' - Classificação por Sinistralidade',nil,nil) 
		Endif
		
EndIF

Return()

static Function fRkAdm2()

local aLogLtaRk2:= {}
local cqueryRkS2:= ' '     
local nQtdVid   := 0  
local nSintot   := aBrwPEG[oBrwPEG:nAt,23]
local nCustTot  := 0
local nMensTot  := 0
local nSinEmp   := aBrwPEG[oBrwPEG:nAt,23]
local nCustEmp  := 0
local nMensEmp  := 0
local cCodempad2:= ' '

if nOrigem1 == 1

	cqueryRkS2 :=     " SELECT codemp CodEmp , Bg9.Bg9_Descri Emp , "
	cQueryRkS2 +=CRLF+"        '20'||substr(TO_char(MES_ANO_REF),7,2)||'/'||substr(TO_char(MES_ANO_REF),4,2) referencia ,"
	cQueryRkS2 +=CRLF+"        Sum(MENSA) mensal , MES_ANO_REF MES_ANO_REF , "
	cQueryRkS2 +=CRLF+"        Sum(APROVADO - PART) custo , "
	cQueryRkS2 +=CRLF+"        Decode(Sum(MENSA),0,0,round((Sum(APROVADO-PART))/Sum(MENSA),6))*100 sinist , "
	cQueryRkS2 +=CRLF+"        SUM(case when ( matric <> ' ' and MENSA > 0) THEN 1 ELSE 0 END) QTDAVID  , "
	cQueryRkS2 +=CRLF+"        (CASE WHEN Decode(Sum(MENSA),0,0,round((Sum(APROVADO-PART))/Sum(MENSA),6))*100 < 66 THEN              '1-Até 65%'     "
	cQueryRkS2 +=CRLF+"              WHEN Decode(Sum(MENSA),0,0,round((Sum(APROVADO-PART))/Sum(MENSA),6))*100 BETWEEN 66 AND 70 THEN '2-de 66 a 70%' "
	cQueryRkS2 +=CRLF+"              WHEN Decode(Sum(MENSA),0,0,round((Sum(APROVADO-PART))/Sum(MENSA),6))*100 BETWEEN 71 AND 80 THEN '3-de 71 a 80%' "
	cQueryRkS2 +=CRLF+"         ELSE                                    '4-acima de 80%' END) GRPSINIS "  

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
	    cQueryRkS2 +=CRLF+"    and bg9_codigo = '"+substr(aBrwPEG[oBrwPEG:nAt,11],1,4)+"' "
    EndIf

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
                nSinEmp   :=  (nCustEmp / nMensEmp )*100

                aAdd(aLogLtaRk2,{ ' '    ,; 
				    			  'Totais Empresa  --->'         ,;
					    		  ' '   ,;   
						          ' '   ,;
		           				  transform((nMensEmp),"@E 999,999,999.99") ,;
        						  transform((nCustEmp),"@E 999,999,999.99") ,;
        						  transform((nSinEmp),"@E 99,999.99")+'%' ,;
	   					  	      ' ' })     //3 
 			nCustEmp  := 0.00 
			nMensEmp  := 0.00
            nSinEmp   := 0			

            EndIf 
             
			aAdd(aLogLtaRk2,{ TRIM((cAliasRkC2)->codEmp)    ,; 
							  trim((cAliasRkC2)->Emp)   ,;
							  trim(substr(dtos((cAliasRkC2)->MES_ANO_REF),1,4)+'/'+substr(dtos((cAliasRkC2)->MES_ANO_REF),5,2))   ,;   
						 transform(((cAliasRkC2)->QTDAVID),"@E 999,999") ,;
						 transform(((cAliasRkC2)->mensal),"@E 999,999,999.99") ,;
						 transform(((cAliasRkC2)->custo),"@E 999,999,999.99") ,;
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

            nSintot   :=  (nCustTot / nMensTot )*100

            aAdd(aLogLtaRk2,{ ' '    ,; 
				    		  'Totais Empresa  --->' ,;
					    	  ' '   ,;   
						      ' '   ,;
		           			  transform((nMensEmp),"@E 999,999,999.99") ,;
        					  transform((nCustEmp),"@E 999,999,999.99") ,;
        					  transform((nSinEmp),"@E 99,999.99")+'%' ,;
	   					  	  ' ' })     //3 

			aAdd(aLogLtaRk2,{ ' '    ,; 
							  ' '    ,;
							  ' '    ,;   
   						      ' '    ,;
 						      ' '    ,;
						      ' '    ,;
						      ' '    ,;
	   					  	  ' ' })     //3

			aAdd(aLogLtaRk2,{ ' '   ,; 
							  'Totais   --->' ,;
							  ' '   ,;   
						      ' '   ,;
						 transform((nMensTot),"@E 999,999,999.99") ,;
						 transform((nCustTot),"@E 999,999,999.99") ,;
						 transform((nSintot),"@E 99,999.99")+'%' ,;
	   					  	  ' ' })     //3 

			PLSCRIGEN(aLogLtaRk2,{{'Cod Empresa',"@!",20}     ,;
								  {'Administradora',"@!",120} ,;
								  {'Referencia' ,"@!",30} ,;
								  {'Vidas Ativas' ,"@!",30} ,;
							   	  {'Mensalidade' ,"@!",30} ,;
                                  {'Custo' ,"@!",30} ,;
								  {'Sinistralidade' ,"@!",50} ,;
								  {'Classificaçõa' ,"@!",50} },;
  								   'Pesquisa por '+cTitPesq+' - Sinistralidade Faturamento X Custo',nil,nil) 
		Endif
		
EndIF

Return()

static Function fRkAdm3()

local aLogLtaRk3:= {}
local cqueryRkS3:= ' '     
local nSinsTot  := 0.0000
local cEmptot   := ' '
local ncontSv   := 0  
local cCodVenM  := substr(aBrwPEG[oBrwPEG:nAt,12],1,6)
local nSintot   := aBrwPEG[oBrwPEG:nAt,23]
local nCustTot  := 0
local nMensTot  := 0
local nResulTot := 0
local nSinst    := 0.0000

if nOrigem1 == 1

	cqueryRkS3 :=     " SELECT codemp CodEmp , Bg9.Bg9_Descri Emp , 
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
        cQueryRkS3 +=CRLF+"    and bg9_codigo = '"+substr(aBrwPEG[oBrwPEG:nAt,11],1,4)+"' "
    EndIf
	
	//cQueryRkS3 +=CRLF+"    and bg9_ytpemp = '2' "
    cQueryRkS3 +=CRLF+"  having Decode(Sum(MENSA),0,0,round((Sum(APROVADO-PART))/Sum(MENSA),6))*100 > 0 "
    cQueryRkS3 +=CRLF+"  group by  codemp , Bg9.Bg9_Descri " 
	cQueryRkS3 +=CRLF+"  order by 1,3 "

	If Select((cAliasRkC3)) <> 0 
				(cAliasRkC3)->(DbCloseArea())  
	Endif                          

	TCQuery cQueryRkS3 New Alias (cAliasRkC3)   

	(cAliasRkC3)->( DbGoTop() )  

	While !(cAliasRkC3)->(EOF())

			aAdd(aLogLtaRk3,{ TRIM((cAliasRkC3)->codEmp)    ,; 
							  trim((cAliasRkC3)->Emp)   ,;   
						 transform(((cAliasRkC3)->mensal),"@E 999,999,999.99") ,;
						 transform(((cAliasRkC3)->custo),"@E 999,999,999.99") ,;
						 transform(((cAliasRkC3)->Result),"@E 999,999,999.99") })     //3 

 			nCustTot  := nCustTot + (cAliasRkC3)->custo
 			nMensTot  := nMensTot + (cAliasRkC3)->mensal 
            nResulTot := nResulTot + (cAliasRkC3)->Result

			(cAliasRkC3)->(DbSkip())

		EndDo

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Detalhe dp titulo de comisso                                             ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If  len(aLogLtaRk3) > 0

		aAdd(aLogLtaRk3,{ ' ' ,; 
						  'Totais    ---> '	     ,;   
						 transform(nMensTot,"@E 999,999,999.99") ,;
						 transform(nCustTot,"@E 999,999,999.99") ,;
						 transform(nResulTot,"@E 999,999,999.99") })     //3


			PLSCRIGEN(aLogLtaRk3,{{'Cod Empresa',"@!",20}     ,;
								  {'Administradora',"@!",120} ,;
							   	  {'Mensalidade' ,"@!",30} ,;
                                  {'Custo' ,"@!",30} ,;
								  {'Resultado' ,"@!",50}},;
								   'Pesquisa por '+cTitPesq+' - Resultado Financeiro Empresa',nil,nil) 
		Endif
		
EndIF

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

if nOrigem1 == 1

	cqueryRkS4 :=     " SELECT codemp CodEmp , Bg9.Bg9_Descri Emp , nvl(BQC_DESCRI,'Lançamento a Nivel da Empresa') GRPEMP , "
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
	    cQueryRkS4 +=CRLF+"    and bg9_codigo = '"+substr(aBrwPEG[oBrwPEG:nAt,11],1,4)+"' "
    EndIf
	
	//cQueryRkS4 +=CRLF+"    and bg9_ytpemp = '2' "

    cQueryRkS4 += CRLF+"   and bqc_codigo(+) = '0001'||codemp
    cQueryRkS4 += CRLF+"   AND BQC_NUMCON(+) = CONTRATO 
    cQueryRkS4 += CRLF+"   AND BQC_SUBCON(+) = SUBCONTRATO
//    cQueryRkS4 += CRLF+"having Decode(Sum(MENSA),0,0,round((Sum(APROVADO-PART))/Sum(MENSA),6))*100 > 0
    cQueryRkS4 +=CRLF+"  group by  codemp , Bg9.Bg9_Descri , BQC_DESCRI  " 
	cQueryRkS4 +=CRLF+"  order by 1,3 "

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

            aAdd(aLogLtaRk4,{ ' '    ,; 
				    		  'Totais Empresa  --->'         ,;
					    	  ' '   ,;   
		           			  transform((nMensEmp),"@E 999,999,999.99") ,;
        					  transform((nCustEmp),"@E 999,999,999.99") ,;
        					  transform((nResult ),"@E 999,999,999.99") })     //3 
 			nCustEmp  := 0.00 
			nMensEmp  := 0.00
            nResult   := 0.00			

        EndIf 

			aAdd(aLogLtaRk4,{ TRIM((cAliasRkC4)->codEmp)    ,; 
							  trim((cAliasRkC4)->Emp)       ,; 
							  trim((cAliasRkC4)->GRPEMP)    ,;  
						 transform(((cAliasRkC4)->mensal),"@E 999,999,999.99") ,;
						 transform(((cAliasRkC4)->custo ),"@E 999,999,999.99") ,;
						 transform(((cAliasRkC4)->Result),"@E 999,999,999.99") })     //3 
		
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

		    aAdd(aLogLtaRk4,{ ' '    ,; 
				    		  'Totais Empresa  --->' ,;
					    	  ' '   ,;   
		           			  transform((nMensEmp),"@E 999,999,999.99") ,;
        					  transform((nCustEmp),"@E 999,999,999.99") ,;
        					  transform((nResult ),"@E 999,999,999.99") })     //3

            aAdd(aLogLtaRk4,{ ' '    ,; 
				    		  '----' ,;
					    	  ' '   ,;   
		           			  ' ' ,;
        					  ' ' ,;
        					  ' '})     //3

		    aAdd(aLogLtaRk4,{ ' '    ,; 
				    		  'Totais   --->' ,;
					    	  ' '   ,;   
		           			  transform((nMensEmpT),"@E 999,999,999.99") ,;
        					  transform((nCustEmpT),"@E 999,999,999.99") ,;
        					  transform((nResultT ),"@E 999,999,999.99") })     //3

			PLSCRIGEN(aLogLtaRk4,{{'Cod Empresa',"@!",20}     ,;
								  {'Administradora',"@!",120} ,;
								  {'Grupo de Empresa',"@!",120} ,;
							   	  {'Mensalidade' ,"@!",30} ,;
                                  {'Custo' ,"@!",30} ,;
								  {'Resultado' ,"@!",50}},;
								   'Pesquisa por '+cTitPesq+' - Resultado Financeiro Grp.Empresa',nil,nil) 
		Endif
		
EndIF

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

local cCodempad5 := ' ' 

if nOrigem1 == 1

 cqueryRkS5 :=      "SELECT codemp CodEmp , "
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
	    cQueryRkS5 +=CRLF+"    and bg9_codigo = '"+substr(aBrwPEG[oBrwPEG:nAt,11],1,4)+"' "
    EndIf
	
    cQueryRkS5 += CRLF+"           and bqc_codigo(+) = '0001'||codemp " 
    cQueryRkS5 += CRLF+"           AND BQC_NUMCON(+) = CONTRATO "
    cQueryRkS5 += CRLF+"           AND BQC_SUBCON(+) = SUBCONTRATO "
    //cQueryRkS5 += CRLF+"        having Decode(Sum(MENSA),0,0,round((Sum(APROVADO-PART))/Sum(MENSA),6))*100 > 0 " 
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
	    cQueryRkS5 +=CRLF+"    and bg9_codigo = '"+substr(aBrwPEG[oBrwPEG:nAt,11],1,4)+"' "
    EndIf
	
    cQueryRkS5 += CRLF+"           and (bxq_numcon <> ' ' or bxq_subcon <> ' ') "
    cQueryRkS5 += CRLF+"           AND BXQ_REFERE = BXQ_PAGCOM "
    cQueryRkS5 += CRLF+"           and bxq_ano||bxq_mes >= '20"+cAnoAnt+cMesAnt+"'"   
    cQueryRkS5 += CRLF+"           and bxq_ano||bxq_mes <= '20"+cAnoAtu+cMesAtu+"'" 
	cQueryRkS5 += CRLF+"      GROUP BY bxq_codemp ,  bxq_numcon , bxq_subcon , Bg9.Bg9_Descri) bxq1 " 
    cQueryRkS5 += CRLF+"         where emp.NUMCON = bxq1.conbxq(+) "
    cQueryRkS5 += CRLF+"           and emp.subCON = bxq1.subbxq(+) "
    cQueryRkS5 += CRLF+"           and emp.CodEmp = bxq1.codbxq(+) "
    
	cQueryRkS5 += CRLF+"      union all "
    
	cQueryRkS5 += CRLF+"        select bxq_codemp CodEmp  , "
    cQueryRkS5 += CRLF+"               Bg9.Bg9_Descri Emp , "
    cQueryRkS5 += CRLF+"               'Ajuste Comissão Deb / Cred' GRPEMP ," 
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
	    cQueryRkS5 +=CRLF+"    and bg9_codigo = '"+substr(aBrwPEG[oBrwPEG:nAt,11],1,4)+"' "
    EndIf
	
    cQueryRkS5 += CRLF+"           and (bxq_numcon = ' ' or bxq_subcon = ' ') "
    cQueryRkS5 += CRLF+"           AND BXQ_REFERE = BXQ_PAGCOM "
    cQueryRkS5 += CRLF+"           and bxq_ano||bxq_mes >= '20"+cAnoAnt+cMesAnt+"'" 
    cQueryRkS5 += CRLF+"           and bxq_ano||bxq_mes <= '20"+cAnoAtu+cMesAtu+"'" 
    cQueryRkS5 += CRLF+"      GROUP BY bxq_codemp ,  bxq_numcon , bxq_subcon , Bg9.Bg9_Descri "
    cQueryRkS5 += CRLF+"      order by 1,3 "

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

            aAdd(aLogLtaRk5,{ ' '    ,; 
				    		  'Totais Empresa  --->'         ,;
					    	  ' '   ,;   
		           			  transform((nMensEmp),"@E 999,999,999.99") ,;
        					  transform((nCustEmp),"@E 999,999,999.99") ,;
							  transform((nComis)  ,"@E 999,999,999.99") ,;
        					  transform((nResulte ),"@E 999,999,999.99") })     //3 
 			
			nCustEmp  := 0.00 
			nMensEmp  := 0.00
            nResultE  := 0.00
			nResult   := 0.00			
            nComis    := 0.00

        EndIf 

			aAdd(aLogLtaRk5,{ TRIM((cAliasRkC5)->codEmp)    ,; 
							  trim((cAliasRkC5)->Emp)      ,; 
							  trim((cAliasRkC5)->GRPEMP)      ,;  
						 transform(((cAliasRkC5)->mensal),"@E 999,999,999.99") ,;
						 transform(((cAliasRkC5)->custo),"@E 999,999,999.99") ,;
						 transform(((cAliasRkC5)->totcom1),"@E 999,999,999.99") ,;
						 transform(((cAliasRkC5)->Resulta),"@E 999,999,999.99") })     //3 
		
				nCustEmp   := nCustEmp  + (cAliasRkC5)->custo
				nMensEmp   := nMensEmp  + (cAliasRkC5)->mensal
				nResult    := nResult   + (cAliasRkC5)->Resulta
				nComis     := nComis	+ (cAliasRkC5)->totcom1

				nCustEmpT  := nCustEmpT + (cAliasRkC5)->custo 
				nMensEmpT  := nMensEmpT + (cAliasRkC5)->mensal
				nResultE   := nResulte  + (cAliasRkC5)->Resulta
				nResultTt  := nResultT  + (cAliasRkC5)->Resulta
				nComisT    := nComisT	+ (cAliasRkC5)->totcom1

			(cAliasRkC5)->(DbSkip())

    EndDo

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Detalhe dp titulo de comisso                                             ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If  len(aLogLtaRk5) > 0

            aAdd(aLogLtaRk5,{ ' '    ,; 
				    		  'Totais Empresa  --->'         ,;
					    	  ' '   ,;   
		           			  transform((nMensEmp),"@E 999,999,999.99") ,;
        					  transform((nCustEmp),"@E 999,999,999.99") ,;
							  transform((nComis)  ,"@E 999,999,999.99") ,;
        					  transform((nResultE ),"@E 999,999,999.99") })     //3 
 			
            aAdd(aLogLtaRk5,{ ' ' ,; 
				    		  '---'  ,;
					    	  ' ' ,;   
		           			  ' ' ,;
        					  ' ' ,;
							  ' ' ,;
        					  ' ' })     //3 
 			
            aAdd(aLogLtaRk5,{ ' '    ,; 
				    		  'Totais   --->'         ,;
					    	  ' '   ,;   
		           			  transform((nMensEmpT),"@E 999,999,999.99") ,;
        					  transform((nCustEmpT),"@E 999,999,999.99") ,;
							  transform((nComisT)  ,"@E 999,999,999.99") ,;
        					  transform(((nMensEmpT-nCustEmpT-nComisT)) ,"@E 999,999,999.99") })     //3
							  //transform((nResulTT) ,"@E 999,999,999.99") })     //3

			PLSCRIGEN(aLogLtaRk5,{{'Cod Empresa',"@!",20}     ,;
								  {'Administradora',"@!",120} ,;
								  {'Grupo de Empresa',"@!",120} ,;
							   	  {'Mensalidade' ,"@!",30} ,;
                                  {'Custo' ,"@!",30} ,;
								  {'Comissão' ,"@!",30} ,;
								  {'Resultado' ,"@!",50}},;
								   'Pesquisa por '+cTitPesq+' - Resultado Financeiro Grp Empresa com Comissão',nil,nil) 
		Endif
		
EndIF

Return()
