#INCLUDE "PROTHEUS.ch"
#INCLUDE "TOPCONN.ch"
#INCLUDE "PLSMGER.CH"
#Include "Ap5Mail.Ch"
#Include 'Tbiconn.ch'

/*--------------------------------------------------------------------------
| Programa  | CABA129  | Autor | Altamiro	Affonso    | Data | 21/06/2013  |
|---------------------------------------------------------------------------|              
| Descricao | Faturamento de convenios antecipado - controle de Titulos     |
|           |                                                               |                                                       
|---------------------------------------------------------------------------|
| Uso       | Faturamento de convenios antecipado   - browser de seleção    |                                   
 --------------------------------------------------------------------------*/
//---------------------------------------------------------------------------
//Angelo Henrique - Data: 01/02/2023
//---------------------------------------------------------------------------
//Ajustes no fonte:
//---------------------------------------------------------------------------
// - Declaração de variáveis 
// - Remoção de variáveis não utilizadas na rotina
// - Remoção de comentários desnecessários e comandos em duplicidade
//---------------------------------------------------------------------------
//Para ver o histórico e versões anteriores olhar o SVN
//---------------------------------------------------------------------------

User Function CABA129
                                                 
Local _oPos09     := Nil //Angelo Henrique - Data: 01/02/2023
Local _oPos10     := Nil //Angelo Henrique - Data: 01/02/2023
Local _oPos11     := Nil //Angelo Henrique - Data: 01/02/2023
Local _oPos12     := Nil //Angelo Henrique - Data: 01/02/2023
Local _oPos13     := Nil //Angelo Henrique - Data: 01/02/2023
Local _oPos14     := Nil //Angelo Henrique - Data: 01/02/2023
Local _oPos15     := Nil //Angelo Henrique - Data: 01/02/2023

Private _cUsuario := SubStr(cUSUARIO,7,15)        
Private aBrwPEG   := {}
Private aCabPEG	:= { " ","Cmp Ent" , "Opr Origem" , "Pref" ,"Numero" , "Prc","Tipo" , "Valor " ,"" , "Relatorio","","Conferencia","","Carta","","Email","","Divergencia","","Fechamento","","Conciliação"  }
Private aTamPEG	:= { 10 , 25       ,20            ,30      ,35       , 15   ,20     ,45        , 05,30           ,05 ,35         ,05  ,30   ,05  ,30   ,05,35           ,05, 35 ,  05  ,35 }
Private oOk      	:= LoadBitMap(GetResources(),"LBOK")
Private oNo      	:= LoadBitMap(GetResources(),"LBNO")
Private oVerde   	:= LoadBitMap(GetResources(),"ENABLE")
Private oVermelho	:= LoadBitMap(GetResources(),"DISABLE")  
Private aObjects 	:= {}
Private aSizeAut 	:= MsAdvSize() 
Private cPerg	   := "CABA129"     
Private cFecConv  := 1       
Private cFezConc  := 2
Private cLOTCOB   := ' '   
Private cFZCRIT   := ' '   
Private cCVLTOT   := ' '   
Private cCVLBAS   := ' '   
Private cCVLTAD   := ' '   
Private cCVLFS3   := ' '   
Private cCVLAN3   := ' '   
Private cCVLFAT   := ' ' 
Private cCVLBLF   := ' ' 
Private cFAZCON   := ' ' 
Private dVencInc  := CTOD(' / / ')
Private dVencFim  := CTOD(' / / ')
Private cTipotit  := ""   
Private cTipbaixa := ""       
Private cCompInc  := ' '                     
Private cCompFim  := ' '
Private cmv_par09 := ' '   
Private nfase3    := 0                   
Private nfase312  := 0                  
Private nfase4    := 0   
Private Idx       := 0        
Private cClsRd    := ' ' 
Private dDtvenc   := ' '  
Private cDscori   := ' ' 
Private cMesBase  := ' '  
Private cAnoBase  := ' ' 
Private cNumTitI  := ' '  
Private cNumTitF  := ' '     
Private cOpeInc   := ' ' 
Private cOpeFim   := ' '     
Private aTit      := {}                     
Private cAliasCf  := GetNextAlias()   
Private cAliasDem := GetNextAlias()   
Private cAliasCT  := GetNextAlias()    
Private cAliasEX  := GetNextAlias()   
Private aBut      := {}

AjustaSX1()

Pergunte(cPerg,.T.)        

cCompInc := Mv_par01                     
cCompFim := Mv_par02  
cmv_par09:= Mv_par01

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

aAdd( aObjects, { 120,  200, lAjustHor, lAjustVert } )

nSepHoriz   := 5   
nSepVert    := 5
nSepBorHor 	:= 5
nSepBorVert	:= 5

aInfo  		:= { aSizeAut[ 1 ], aSizeAut[ 2 ], aSizeAut[ 3 ], aSizeAut[ 4 ], nSepHoriz, nSepVert, nSepBorHor, nSepBorVert }
aPosObj 	   := MsObjSize( aInfo, aObjects, .T. )

oDlg  		:= MsDialog():New( aSizeAut[7],00,aSizeAut[3]-100,aSizeAut[5]-10,"Controle de Cobrança Antecipada de Convenio de Reciprocidade ",,,.F.,,,,,,.T.,,,.T. ) 

oSayPEG    	:= TSay():New( aPosObj[1][1],aPosObj[1][2],{||'Controle de Cobrança de Convenio de Reciprocidade'},oDlg,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,236,016)

bDbClickPEG	:= {|| aBrwPEG[oBrwPEG:nAt,1] := !aBrwPEG[oBrwPEG:nAt,1], oBrwPEG:Refresh()}   

oBrwPEG 	   := TcBrowse():New(aPosObj[1][1]+10,aPosObj[1][2],aPosObj[1][4],aPosObj[1][3],,aCabPEG,aTamPEG,oDlg,,,,,bDbClickPEG,,,,,,,.F.,,.T.,,.F.,,, )

oBrwPEG:SetArray(aBrwPEG) 

//-----------------------------------------------------------------------------------
//Angelo Henrique - Data: 01/02/2023
//-----------------------------------------------------------------------------------
//Para correção da identação do fonte e correta apresentação da leitura do código 
//as validações (IF's) foram colocadas foras do vetor
//-----------------------------------------------------------------------------------
IF trim(aBrwPEG[oBrwPEG:nAt, 9])  == 'FEITO'
   _oPos09 := oVerde 
Else
   _oPos09 := oVermelho
EndIf

IF trim(aBrwPEG[oBrwPEG:nAt, 10]) == 'FEITO'
   _oPos10 := oVerde
Else
   _oPos10 := oVermelho
EndIf 

IF trim(aBrwPEG[oBrwPEG:nAt, 11]) == 'FEITO'
   _oPos11 := oVerde 
Else
   _oPos11 := oVermelho
EndIf

IF trim(aBrwPEG[oBrwPEG:nAt, 12]) == 'FEITO'
   _oPos12 := oVerde 
Else
   _oPos12 := oVermelho
EndIf

IF trim(aBrwPEG[oBrwPEG:nAt, 13]) == 'FEITO'
   _oPos13 := oVerde
Else
   _oPos13 := oVermelho
EndIf

IF trim(aBrwPEG[oBrwPEG:nAt, 14]) == 'FEITO'
_oPos14 := oVerde 
Else
_oPos14 := oVermelho  
EndIf

IF trim(aBrwPEG[oBrwPEG:nAt, 15]) == 'FEITO'
_oPos15 := oVerde 
Else
_oPos15 := oVermelho  
EndIf
//-----------------------------------------------------------------------------------

oBrwPEG:bLine := {||{IIF( aBrwPEG[oBrwPEG:nAt, 1],oOk,oNo) ,;
	aBrwPEG[oBrwPEG:nAt, 2] ,;
	aBrwPEG[oBrwPEG:nAt, 3] ,;
	aBrwPEG[oBrwPEG:nAt, 4] ,;
	aBrwPEG[oBrwPEG:nAt, 5] ,;
	aBrwPEG[oBrwPEG:nAt, 6] ,;
	aBrwPEG[oBrwPEG:nAt, 7] ,;
	Transform(aBrwPEG[oBrwPEG:nAt, 8],'@E  9999,999.99'),;
	_oPos09 ,;                 // 09
	aBrwPEG[oBrwPEG:nAt, 9] ,; // 10
	_oPos10,;                  // 11
	aBrwPEG[oBrwPEG:nAt, 10],; // 12
	_oPos11,;                  // 13
	aBrwPEG[oBrwPEG:nAt, 11],; // 14
	_oPos12,;                  // 15
	aBrwPEG[oBrwPEG:nAt, 12],; // 16
	_oPos13,;                  // 17
	aBrwPEG[oBrwPEG:nAt, 13],; // 18
	_oPos14,;                  // 19
	aBrwPEG[oBrwPEG:nAt, 14],; // 20
	_oPos15,;                  // 21
	aBrwPEG[oBrwPEG:nAt, 15] }}// 22

oBrwPEG:nScrollType  := 1 // Scroll VCR

lConfirmou 	:= .T.

aAdd(aBut, {"PENDENTE", {||marca(1)    ,oBrwPEG:Refresh()            }	, "Marcar Todos "    , "Marcar Todos"     })
aAdd(aBut, {"PENDENTE", {||desmarca(1) ,oBrwPEG:Refresh()            }	, "DesMarcar Todos "	, "DesMarcar Todos"	})
aAdd(aBut, {"PENDENTE", {||fExclui()   ,oBrwPEG:Refresh(),oDlg:End() }  , "Excluir Tit"   	, "Excluir Tit"      })
aAdd(aBut, {"PENDENTE", {||fPgOpeRel(1),oBrwPEG:Refresh()            }  , "Relatorio "   	   , "Relatorio "       })
aAdd(aBut, {"PENDENTE", {||fConfe(1)   ,oBrwPEG:Refresh()            }	, "Conferencia"   	, "Conferencia"      })
aAdd(aBut, {"PENDENTE", {||fCarta(1)   ,oBrwPEG:Refresh()            }	, "Carta "           , "Carta"            })
aAdd(aBut, {"PENDENTE", {||fEmail(1)   ,oBrwPEG:Refresh()            }	, "Email "       	   , "Email"            })
aAdd(aBut, {"PENDENTE", {||fDiver(1)   ,oBrwPEG:Refresh()            }	, "Divergencias"     , "Divergencia"      })
aAdd(aBut, {"PENDENTE", {||fFecha(1)   ,oBrwPEG:Refresh()            }  , "Fechamento"       , "Fechamento"       })

lConfirmou := .F.

bOk 	:= {|| MsgAlert("Favor Escolher uma opção em 'Ações Relacionadas'.","Atenção") , oBrwPEG:Refresh() }

bCancel := {||lConfirmou := .F.,oDlg:End()}

oDlg:Activate(,,,.T.,,,EnchoiceBar(oDlg,bOk,bCancel,,aBut))

Return

Static Function aDadosPEG

	Local aRetPEG	   := {}
	Local cQryPEG	   := ""
	Local cAliasPEG   := GetNextAlias()
	Local i           := 0
	Local _lDbseek		:= .F.

	ProcRegua(0)

	nCont := 0

	for i:=1 to 5
		IncProc('Buscando Dados no Servidor ...')
	next

	cQryPEG :=" SELECT PCU_OPEORI||'-'||OPE.NOMOPE  OPEORI , " + CRLF
	cQryPEG +="        PCU_COMPT   COMPT  , " + CRLF
	cQryPEG +="        PCU_PREFIX  PREFIX , " + CRLF
	cQryPEG +="        PCU_NUM     NUM    , " + CRLF
	cQryPEG +="        PCU_PARCEL  PARCEL , " + CRLF
	cQryPEG +="        PCU_TIPO    TIPO   , " + CRLF
	cQryPEG +="        PCU_VLR     VLR    , " + CRLF

	cQryPEG +="        DECODE(PCU_RELAT ,'F', 'A Fazer' , 'FEITO')   RELAT  , " + CRLF
	cQryPEG +="        DECODE(PCU_CONF  ,'F', 'A Fazer' , 'FEITO')   CONF   , " + CRLF
	cQryPEG +="        DECODE(PCU_CARTA ,'F', 'A Fazer' , 'FEITO')   CARTA  , " + CRLF
	cQryPEG +="        DECODE(PCU_EMAIL ,'F', 'A Fazer' , 'FEITO')   EMAIL  , " + CRLF
	cQryPEG +="        DECODE(PCU_DIVERG,'F', 'A Fazer' , 'FEITO')   DIVERG , " + CRLF
	cQryPEG +="        DECODE(PCU_FECHAM,'F', 'A Fazer' , 'FEITO')   FECHAM , " + CRLF
	cQryPEG +="        DECODE(PCU_CONCIL,'F', 'A Fazer' , 'FEITO')   CONCIL   " + CRLF


	cQryPEG +="   FROM ( " + CRLF
	cQryPEG +="         SELECT '10'||BGH_GRUOPE OPEORI , BA2_DESCRI NOMOPE ,  BGH_VLRTRC VLRCOB " + CRLF
	cQryPEG +="           FROM "+RetSqlName('BGH')+ " BGH  ,"+RetSqlName('BA2')+ " BA2" + CRLF
	cQryPEG +="          WHERE BA2_FILIAL = '" + xFilial('BA2') + "' AND BA2.D_E_L_E_T_ = ' ' " + CRLF
	cQryPEG +="            AND BGH_FILIAL = '" + xFilial('BGH') + "' AND BGH.D_E_L_E_T_ = ' ' " + CRLF
	cQryPEG +="            AND BGH_DATFIN = ' ' AND BA2_GRUOPE = BGH_GRUOPE ) OPE  , " + CRLF


	cQryPEG +="       "+RetSqlName('PCU')+ " PCU " + CRLF

	cQryPEG +="  WHERE PCU_FILIAL = '" + xFilial('PCU') + "' " + CRLF

	cQryPEG +="    AND PCU_COMPT  = '"+cCompInc+"' " + CRLF
	cQryPEG +="    AND PCU.D_E_L_E_T_ = ' ' " + CRLF

	cQryPEG +="    AND PCU_OPEORI = OPE.OPEORI(+) " + CRLF

	cQryPEG +="  ORDER BY 2,1" + CRLF


	TcQuery cQryPEG New Alias (cAliasPEG)

	While !(cAliasPEG)->(EOF())

		aAdd(aRetPEG,{.F. , (cAliasPEG)->COMPT , ((cAliasPEG))->OPEORI , (cAliasPEG)->PREFIX , (cAliasPEG)-> NUM , (cAliasPEG)->PARCEL , (cAliasPEG)->TIPO, (cAliasPEG)->VLR ,trim((cAliasPEG)->RELAT) , trim((cAliasPEG)->CONF) , trim((cAliasPEG)->CARTA) , trim((cAliasPEG)->EMAIL) , trim((cAliasPEG)->DIVERG) , trim((cAliasPEG)->FECHAM), trim((cAliasPEG)->CONCIL)})
		//   1      2    				3				      	4					5					6			     		7					8				9						     10				         11	                        12                          13                          14

		(cAliasPEG)->(DbSkip())

	EndDo

	(cAliasPEG)->(DbCloseArea())

   //-----------------------------------------------------------------------------------
   //Angelo Henrique - Data: 01/02/2023
   //-----------------------------------------------------------------------------------
   //Alimentando o vetor com as informações dos convênios que não tiveram adiantamento
   //-----------------------------------------------------------------------------------
   cQryPEG := " SELECT															" + CRLF
   cQryPEG += "     DISTINCT           										    " + CRLF
   cQryPEG += "     BD6.BD6_OPEORI ,         									" + CRLF
   cQryPEG += "     BD6.BD6_OPEORI||'-'||TRIM(BA2.BA2_DESCRI) OPEORI,         	" + CRLF
   cQryPEG += "     BT5.BT5_CODCLI     										    " + CRLF
   cQryPEG += " FROM                   										    " + CRLF
   cQryPEG += " 	" + RetSqlName("BD6") + " BD6     							" + CRLF
   cQryPEG += "                        										    " + CRLF
   cQryPEG += " 	 INNER JOIN                                                 " + CRLF
   cQryPEG += " 	     " + RetSqlName("BA2") + " BA2                          " + CRLF
   cQryPEG += " 	 ON                                                         " + CRLF
   cQryPEG += " 	     BA2.BA2_FILIAL      = ' '                              " + CRLF
   cQryPEG += " 	     AND BA2.BA2_GRUOPE  = SUBSTR(BD6.BD6_OPEORI,3,2)       " + CRLF
   cQryPEG += " 	     AND BA2.D_E_L_E_T_  = ' '                              " + CRLF
   cQryPEG += " 																" + CRLF
   cQryPEG += "     INNER JOIN        											" + CRLF
   cQryPEG += "         " + RetSqlName("BT5") + " BT5     						" + CRLF
   cQryPEG += "     ON                 										    " + CRLF
   cQryPEG += "         BT5.BT5_FILIAL      = BD6.BD6_FILIAL					" + CRLF
   cQryPEG += "         AND BT5.BT5_CODINT  = BD6.BD6_CODOPE   				   	" + CRLF
   cQryPEG += "         AND BT5.BT5_CODIGO  = BD6.BD6_CODEMP   				   	" + CRLF
   cQryPEG += "         AND BT5.BT5_NUMCON  = BD6.BD6_CONEMP   				   	" + CRLF
   cQryPEG += "         AND BT5.BT5_VERSAO  = BD6.BD6_VERCON   				   	" + CRLF
   cQryPEG += "         AND BT5.BT5_INTERC  = '1'              				   	" + CRLF
   cQryPEG += "         AND BT5.D_E_L_E_T_  = BD6.D_E_L_E_T_   				   	" + CRLF
   cQryPEG += "         AND BT5.BT5_CODCLI NOT IN (            				   	" + CRLF
   cQryPEG += "             SELECT                             				   	" + CRLF
   cQryPEG += "                 SE1.E1_CLIENTE                 				   	" + CRLF
   cQryPEG += "             FROM                               				   	" + CRLF
   cQryPEG += "                 " + RetSqlName("SE1") + " SE1                 	" + CRLF
   cQryPEG += "             WHERE                              				   	" + CRLF
   cQryPEG += "                 SE1.E1_FILIAL       = '" + xFilial("SE1") + "'	" + CRLF   
   cQryPEG += "                 AND SE1.E1_CODEMP   = BD6.BD6_CODEMP			" + CRLF	
   cQryPEG += "                 AND SE1.E1_PREFIXO  = 'COV'            		   	" + CRLF
   cQryPEG += "                 AND SE1.E1_ANOBASE  = BD6.BD6_ANOPAG   		   	" + CRLF
   cQryPEG += "                 AND SE1.E1_MESBASE  = BD6.BD6_MESPAG   		   	" + CRLF
   cQryPEG += "                 AND SE1.E1_CLIENTE  = BT5.BT5_CODCLI   		   	" + CRLF
   cQryPEG += "                 AND SE1.D_E_L_E_T_  = ' '              		   	" + CRLF
   cQryPEG += "         )                                              		   	" + CRLF
   cQryPEG += "                                                        		   	" + CRLF
   cQryPEG += " WHERE                                                  		   	" + CRLF
   cQryPEG += "     BD6.BD6_FILIAL      = '" + xFilial("BD6") + "'     		   	" + CRLF
   cQryPEG += "     AND BD6.BD6_CODOPE  = '0001'                       		   	" + CRLF
   cQryPEG += "     AND BD6.BD6_CODEMP  = '0004'                       		   	" + CRLF
   cQryPEG += "     AND BD6.BD6_FASE    = '4'                          		   	" + CRLF
   cQryPEG += "     AND BD6.BD6_BLOPAG  = '0'                          		   	" + CRLF
   cQryPEG += "     AND BD6.BD6_NUMLOT  <> ' '                         		   	" + CRLF
   cQryPEG += "     AND BD6.BD6_ANOPAG  = '" + SUBSTR(cCompInc,1,4) + "'   		" + CRLF
   cQryPEG += "     AND BD6.BD6_MESPAG  = '" + SUBSTR(cCompInc,5,2) + "'   		" + CRLF
   cQryPEG += "     AND BD6.BD6_BLOCPA  = '0'                          		   	" + CRLF
   cQryPEG += "     AND BD6.D_E_L_E_T_  = ' '                          		   	" + CRLF
   cQryPEG += "     AND BD6.BD6_OPEORI NOT IN (									" + CRLF	
   cQryPEG += "          SELECT													" + CRLF
   cQryPEG += "              PCU.PCU_OPEORI										" + CRLF
   cQryPEG += "          FROM													" + CRLF
   cQryPEG += "               " + RetSqlName("PCU") + " PCU						" + CRLF
   cQryPEG += "          WHERE													" + CRLF
   cQryPEG += "              PCU.PCU_FILIAL = BD6.BD6_FILIAL					" + CRLF
   cQryPEG += "              AND PCU.PCU_OPEORI = BD6.BD6_OPEORI				" + CRLF
   cQryPEG += "              AND PCU.PCU_COMPT = BD6.BD6_ANOPAG||BD6.BD6_MESPAG	" + CRLF
   cQryPEG += "              AND PCU.D_E_L_E_T_  = ' '  						" + CRLF
   cQryPEG += "       )															" + CRLF

   TcQuery cQryPEG New Alias (cAliasPEG)

	While !(cAliasPEG)->(EOF())

		aAdd(aRetPEG,{.F. , cCompInc , ((cAliasPEG))->OPEORI , 'COV' , substr(cCompInc,2) + ((cAliasPEG))->BD6_OPEORI , ' ' , 'DP', 0 ,"AUTO" , "AUTO" , "AUTO" , "AUTO" , "AUTO" , "AUTO", "AUTO" })
		//   1      2    				3				      	4					5					6			     		7					8				9						     10				         11	                        12                          13                          14

		DBSELECTAREA( "PCU" )
		DbSetOrder(2)//PCU_FILIAL, PCU_OPEORI, PCU_PREFIX, PCU_NUM, PCU_PARCEL, PCU_TIPO, R_E_C_N_O_, D_E_L_E_T_
		_lDbseek := DbSeek(xFilial("PCU") + ((cAliasPEG))->BD6_OPEORI   + "COV" + substr(cCompInc,2) + ((cAliasPEG))->BD6_OPEORI + ' ' + "DP")
		
		RecLock("PCU", !_lDbseek)
		   
		PCU->PCU_FILIAL := xFilial('PCU') 
		PCU->PCU_OPEORI := ((cAliasPEG))->BD6_OPEORI  
		PCU->PCU_COMPT  := cCompInc
		PCU->PCU_PREFIX := "COV"   
		PCU->PCU_NUM    := substr(cCompInc,2) + ((cAliasPEG))->BD6_OPEORI
		PCU->PCU_PARCEL := ' '
		PCU->PCU_TIPO   := "DP"
		PCU->PCU_VLR    := 0  
		PCU->PCU_RELAT  := .F.  
		PCU->PCU_CONF   := .F.  
		PCU->PCU_EMAIL  := .F.  
		PCU->PCU_CARTA  := .F.  
		PCU->PCU_DIVERG := .F.     
		PCU->PCU_FECHAM := .F.
		PCU->PCU_USRSEL := _cUsuario
		PCU->PCU_HRSEL  := dtos(DATE()) + " - " + Time()     

		PCU->(MsUnlock())


		(cAliasPEG)->(DbSkip())

	EndDo
   //-----------------------------------------------------------------------------------

	If empty(aRetPEG)
		aAdd(aRetPEG,{.F.,'','','','','','','','','','','','','',''})
	EndIf

Return aRetPEG


static function  fSequen()

	fDiver(2)

	fEmail(2)

	fCarta(2)

	fConfe(2)

	fPgOpeRel(2)

Return


Static Function marca(cRef) // cRef == 1 peg , 2 , proc

	Local nI := 0

	For nI := 1 to len(aBrwPEG)

		aBrwPEG[nI,1]:= .T.

	Next

Return

Static Function desmarca(cRef) // cRef == 1 peg , 2 , proc

	Local nI

	For nI := 1 to len(aBrwPEG)

		aBrwPEG[nI,1]:= .F.

	Next

Return

Static Function fExclui()

	Local I           := 0

	Private cPrefixo  := ' '
	Private cNumero   := ' '
	Private cParcela  := ' '
	Private cTipo     := ' '
	Private cCompet   := ' '
	Private nSaldo    := 0.00
	Private nValor    := 0.00
	Private cBord     := ' '

	For I := 1 to len(aBrwPEG)

		If aBrwPEG[I,1] == .T.

			If aBrwPEG[I,12] == 'FEITO'

				MsgAlert("Convenio: "+ substr(aBrwPEG[I,3],1,4)   + CRLF + CRLF + CRLF +;
					" Titulo : "+ aBrwPEG[I,4] + aBrwPEG[I,5] + aBrwPEG[I,6] + aBrwPEG[I,7] + CRLF + CRLF+;
					" Com Email Emitido , NÃO pode ser EXCLUIDO ", " Exclução de Titulo ")
			Else

				u_fPgTit(aBrwPEG[I,4] , aBrwPEG[I,5] , aBrwPEG[I,6] , aBrwPEG[I,7] )

				U_fExcTit( SUBSTR(aBrwPEG[I,3],1,4),cPrefixo, cNumero,cParcela,cTipo,aBrwPEG[I,2] , nSaldo , nValor , cBord )

			EndIF

		EndIf

	Next

Return

Static Function fPgOpeRel(orig)

Local I  := 0

	For I:= 1 to Len(aBrwPEG)
		If orig == 2
			If aBrwPEG[I,1]== .T.
				If  aBrwPEG[I,10]== 'A Fazer'


					MsgAlert("Convenio: "+ substr(aBrwPEG[I,3],1,4)   + CRLF + CRLF + CRLF +;
						" Titulo : "+ aBrwPEG[I,4] + aBrwPEG[I,5] + aBrwPEG[I,6] + aBrwPEG[I,7] + CRLF + CRLF+;
						" Relatorio Sera  Emitido ", " Relatorio Sera Emitido  ")

					cMesBase     := substr(aBrwPEG[I,2],5,2)
					cAnoBase     := substr(aBrwPEG[I,2],1,4)
					cNumTitI     := aBrwPEG[I,5]
					cNumTitF     := aBrwPEG[I,5]
					cOpeFim      := substr(aBrwPEG[I,3],1,4)
					cOpeInc := substr(aBrwPEG[I,3],1,4)

					u_cabr240(cMesBase,cAnoBase,cNumTitI,cNumTitF,cOpeInc,cOpeFim)

					DbSelectArea("PCU")
					DbSetOrder(2)

					If PCU->(MsSeek(xFilial("PCU") + cOpeInc + aBrwPEG[I,4] + aBrwPEG[I,5] + aBrwPEG[I,6] + aBrwPEG[I,7] ))

						PCU->(RecLock("PCU",.F.))
						PCU->PCU_RELAT:= .T.
						PCU->(MsUnlock())

						Idx := I

						aBrwPEG[Idx ,09]:="FEITO"
						aBrwPEG[Idx ,01]:=.F.

					EndIf
				EndIf
			EndIf
		Else
			If aBrwPEG[I,1]== .T.

				MsgAlert("Convenio: "+ substr(aBrwPEG[I,3],1,4)   + CRLF + CRLF + CRLF +;
					" Titulo : "+ aBrwPEG[I,4] + aBrwPEG[I,5] + aBrwPEG[I,6] + aBrwPEG[I,7] + CRLF + CRLF+;
					" Relatorio Sera  Emitido ", " Relatorio Sera Emitido  ")


				cMesBase     := substr(aBrwPEG[I,2],5,2)
				cAnoBase     := substr(aBrwPEG[I,2],1,4)
				cNumTitI     := aBrwPEG[I,5]
				cNumTitF     := aBrwPEG[I,5]
				cOpeFim      := substr(aBrwPEG[I,3],1,4)
				cOpeInc := substr(aBrwPEG[I,3],1,4)

				u_cabr240(cMesBase,cAnoBase,cNumTitI,cNumTitF,cOpeInc,cOpeFim)

				DbSelectArea("PCU")
				DbSetOrder(2)

				If PCU->(MsSeek(xFilial("PCU") + cOpeInc + aBrwPEG[I,4] + aBrwPEG[I,5] + aBrwPEG[I,6] + aBrwPEG[I,7] ))

					PCU->(RecLock("PCU",.F.))
					PCU->PCU_RELAT:= .T.
					PCU->(MsUnlock())

				EndIf

			EndIf
		EndIf

	Next

Return


Static Function fConfe(orig)

Local I  := 0

	If Orig == 1
		If !MsgYesNo("Confirma Execução Da Conferencia de Convenio ?")
			Return
		EndIf
	EndIf

	For I:= 1 to Len(aBrwPEG)

		If aBrwPEG[I,1]== .T.


			DbSelectArea("PCU")
			DbSetOrder(2)

			If PCU->(MsSeek(xFilial("PCU") + SUBSTR(aBrwPEG[I,3],1,4) + aBrwPEG[I,4] + aBrwPEG[I,5] + aBrwPEG[I,6] + aBrwPEG[I,7] ))

				If PCU->PCU_RELAT == .T.

					MsgAlert("Convenio: "+ substr(aBrwPEG[I,3],1,4)   + CRLF + CRLF + CRLF +;
						" Titulo : "+ aBrwPEG[I,4] + aBrwPEG[I,5] + aBrwPEG[I,6] + aBrwPEG[I,7] + CRLF + CRLF+;
						" Conferencia sera realizada  ", " Conferencia de Convenio ")


					cMesBase     := substr(aBrwPEG[I,2],5,2)
					cAnoBase     := substr(aBrwPEG[I,2],1,4)
					cNumTitI     := aBrwPEG[I,5]
					cNumTitF     := aBrwPEG[I,5]
					cOpeFim      := substr(aBrwPEG[I,3],1,4)
					cOpeInc      := substr(aBrwPEG[I,3],1,4)

					u_CABR241( cMesBase , cAnoBase , cNumTitI , cOpeInc , 1 )

					PCU->(RecLock("PCU",.F.))
					PCU->PCU_CONF := .T.
					//salta estas funções ate acerto da carta  altamiro - 18/10/2018
					PCU->PCU_CARTA := .T.
					PCU->PCU_EMAIL  := .T.
					//////

					PCU->PCU_USRCOF  := _cUsuario
					PCU->PCU_HRCOF   := dtos(DATE()) + " - " + Time()

					PCU->(MsUnlock())

					Idx := I

					aBrwPEG[Idx ,10]:="FEITO"
					aBrwPEG[Idx ,01]:=.F.

				Else
					If Orig == 1

						MsgAlert("Convenio: "+ substr(aBrwPEG[I,3],1,4)   + CRLF + CRLF + CRLF +;
							" Titulo : "+ aBrwPEG[I,4] + aBrwPEG[I,5] + aBrwPEG[I,6] + aBrwPEG[I,7] + CRLF + CRLF+;
							" Relatorio NÃO emitido , NÃO pode ser considerado Conferido", " Conferencia de Convenio ")
					EndIf

				EndIf

			EndIf

		EndIf

	NEXT

Return
	

Static Function fCarta(orig)

Local I  := 0

	If Orig == 1
		If !MsgYesNo("Confirma Execução Da Emissao da Carta de Cobrança de Convenio ?")
			Return
		EndIf
	EndIf

	For I:= 1 to Len(aBrwPEG)

		If aBrwPEG[I,1]== .T.

			DbSelectArea("PCU")
			DbSetOrder(2)

			If PCU->(MsSeek(xFilial("PCU") + SUBSTR(aBrwPEG[I,3],1,4) + aBrwPEG[I,4] + aBrwPEG[I,5] + aBrwPEG[I,6] + aBrwPEG[I,7] ))

				If PCU->PCU_CONF  == .T.

					MsgAlert("Convenio: "+ substr(aBrwPEG[I,3],1,4)   + CRLF + CRLF + CRLF +;
						" Titulo : "+ aBrwPEG[I,4] + aBrwPEG[I,5] + aBrwPEG[I,6] + aBrwPEG[I,7] + CRLF + CRLF+;
						" Carta Será  Emitido ", " Carta Será Emitido  ")

					cMesBase     := substr(aBrwPEG[I,2],5,2)
					cAnoBase     := substr(aBrwPEG[I,2],1,4)
					cNumTitI     := aBrwPEG[I,5]
					cNumTitF     := aBrwPEG[I,5]
					cOpeFim      := substr(aBrwPEG[I,3],1,4)
					cOpeInc := substr(aBrwPEG[I,3],1,4)

					u_cabr243(cMesBase,cAnoBase,cNumTitI,cNumTitF,cOpeInc,cOpeFim,1)


					PCU->(RecLock("PCU",.F.))
					PCU->PCU_CARTA := .T.

					PCU->PCU_USRCAR  := _cUsuario
					PCU->PCU_HRCAR   := dtos(DATE()) + " - " + Time()

					PCU->(MsUnlock())

					Idx := I

					aBrwPEG[Idx ,11]:="FEITO"
					aBrwPEG[Idx ,01]:=.F.

					fEmail(2)

					a:= 'B'
				Else
					If Orig == 1

						MsgAlert("Convenio: "+ substr(aBrwPEG[I,3],1,4)   + CRLF + CRLF + CRLF +;
							" Titulo : "+ aBrwPEG[I,4] + aBrwPEG[I,5] + aBrwPEG[I,6] + aBrwPEG[I,7] + CRLF + CRLF+;
							" Conferencia NÃO Realizada , NÃO pode ser Emitido a Carta", " Carta de Convenio ")

					EndIf

				EndIf

			EndIf

		EndIf

	NEXT

Return
	
Static Function fEmail(orig)

Local I  := 0

	If Orig == 1
		If !MsgYesNo("Confirma Execução Da Emissao do Email de Cobrança de Convenio ?")
			Return
		EndIf
	EndIf


	For I:= 1 to Len(aBrwPEG)

		If aBrwPEG[I,1]== .T.


			DbSelectArea("PCU")
			DbSetOrder(2)

			If PCU->(MsSeek(xFilial("PCU") + SUBSTR(aBrwPEG[I,3],1,4) + aBrwPEG[I,4] + aBrwPEG[I,5] + aBrwPEG[I,6] + aBrwPEG[I,7] ))

				If PCU->PCU_CARTA  == .T.
					If Orig == 1

						MsgAlert("Convenio: "+ substr(aBrwPEG[I,3],1,4)   + CRLF + CRLF + CRLF +;
							" Titulo : "+ aBrwPEG[I,4] + aBrwPEG[I,5] + aBrwPEG[I,6] + aBrwPEG[I,7] + CRLF + CRLF+;
							" Email Será  Emitido ", " Email Será Emitido  ")

					EndIf
					PCU->(RecLock("PCU",.F.))
					PCU->PCU_EMAIL  := .T.

					PCU->PCU_USREML  := _cUsuario
					PCU->PCU_HREML   := dtos(DATE()) + " - " + Time()

					PCU->(MsUnlock())

					Idx := I

					aBrwPEG[Idx ,12]:="FEITO"
					aBrwPEG[Idx ,01]:=.F.

				Else
					If Orig == 1

						MsgAlert("Convenio: "+ substr(aBrwPEG[I,3],1,4)   + CRLF + CRLF + CRLF +;
							" Titulo : "+ aBrwPEG[I,4] + aBrwPEG[I,5] + aBrwPEG[I,6] + aBrwPEG[I,7] + CRLF + CRLF+;
							" Carta NÃO Emitida , NÃO pode ser Emitido a Email", " Email de Convenio ")
					EndIf

				EndIf

			EndIf

		EndIf

	NEXT

Return

Static Function fDiver(orig)

Local I  := 0

	If Orig == 1
		If !MsgYesNo("Confirma Execução Da Conferencia de Divergencia da Cobrança de Convenio ?")
			Return
		EndIf
	EndIf

	For I:= 1 to Len(aBrwPEG)

		If aBrwPEG[I,1]== .T.

			DbSelectArea("PCU")
			DbSetOrder(2)

			If PCU->(MsSeek(xFilial("PCU") + SUBSTR(aBrwPEG[I,3],1,4) + aBrwPEG[I,4] + aBrwPEG[I,5] + aBrwPEG[I,6] + aBrwPEG[I,7] ))

				If PCU->PCU_EMAIL  == .T.

					MsgAlert("Convenio: "+ substr(aBrwPEG[I,3],1,4)   + CRLF + CRLF + CRLF +;
						" Titulo : "+ aBrwPEG[I,4] + aBrwPEG[I,5] + aBrwPEG[I,6] + aBrwPEG[I,7] + CRLF + CRLF+;
						" Conferencia de Divergencia sera Realizada  ", " Conferencia de Divergencia  ")

					PCU->(RecLock("PCU",.F.))
					PCU->PCU_DIVERG  := .T.

					cMesBase     := substr(aBrwPEG[I,2],5,2)
					cAnoBase     := substr(aBrwPEG[I,2],1,4)
					cNumTitI     := aBrwPEG[I,5]
					cNumTitF     := aBrwPEG[I,5]
					cOpeFim      := substr(aBrwPEG[I,3],1,4)
					cOpeInc      := substr(aBrwPEG[I,3],1,4)

					u_CABR241( cMesBase , cAnoBase , cNumTitI , cOpeInc , 2 , PCU->PCU_FECHAM)

					PCU->PCU_USRDIV  := _cUsuario
					PCU->PCU_HRDIV   := dtos(DATE()) + " - " + Time()

					PCU->(MsUnlock())

					Idx := I

					aBrwPEG[Idx ,13]:="FEITO"
					aBrwPEG[Idx ,01]:=.F.

				Else
					If Orig == 1

						MsgAlert("Convenio: "+ substr(aBrwPEG[I,3],1,4)   + CRLF + CRLF + CRLF +;
							" Titulo : "+ aBrwPEG[I,4] + aBrwPEG[I,5] + aBrwPEG[I,6] + aBrwPEG[I,7] + CRLF + CRLF+;
							" Email NÃO Enviado  , NÃO pode ser Analizado Divergencias", " Analise de Divergencia de Convenio ")
					EndIf

				EndIf

			EndIf

		EndIf

	NEXT

Return


Static Function fVFOpe(opeori)

	Local lRet:= .T.
	Local I:= 0

	DbSelectArea("PCU")
	DbSetOrder(2)

	For I:= 1 to Len(aBrwPEG)

		If substr(aBrwPEG[I,3],1,4) == opeori

			If PCU->(MsSeek(xFilial("PCU") + SUBSTR(aBrwPEG[I,3],1,4) + aBrwPEG[I,4] + aBrwPEG[I,5] + aBrwPEG[I,6] + aBrwPEG[I,7] ))

				If PCU->PCU_DIVERG  == .T. //.Or. PCU->PCU_FECHAM   == .T.

					If  PCU->PCU_FECHAM   == .T.

						lRet    := .T.
						cFecConv:=  2

					Else

						If MsgYesNo("Efetiva Fechamento da Cobrança de Convenio ?")

							cFecConv:=1

						Else

							cFecConv:=2

						EndIf

					EndIf

				Else

					lRet:= .F.

				EndIf

			Else

				lRet:= .F.


			EndIf

		EndIf
	Next

Return lRet

Static Function fGrvPcu(opeori)

Local I  := 0

	If cFecConv == 1 .and. cFazCon == 1

		For I:= 1 to Len(aBrwPEG)

			If substr(aBrwPEG[I,3],1,4) == opeori

				If PCU->(MsSeek(xFilial("PCU") + SUBSTR(aBrwPEG[I,3],1,4) + aBrwPEG[I,4] + aBrwPEG[I,5] + aBrwPEG[I,6] + aBrwPEG[I,7] ))

					If PCU->PCU_DIVERG  == .T. .and. PCU->PCU_FECHAM   == .F.

						PCU->(RecLock("PCU",.F.))

						PCU->PCU_FECHAM  := .T.
						PCU->PCU_USRFEC  := _cUsuario
						PCU->PCU_HRFECH  := dtos(DATE()) + " - " + Time()

						PCU->PCU_CONCIL  := .T.
						PCU->PCU_USRCON  := _cUsuario
						PCU->PCU_HRCONC  := dtos(DATE()) + " - " + Time()

						PCU->PCU_LOTCOB  := cLOTCOB
						PCU->PCU_FZCRIT  := ltrim(str(cFZCRIT))
						PCU->PCU_CVLTOT  := ltrim(str(cCVLTOT))
						PCU->PCU_CVLBAS  := ltrim(str(cCVLBAS))
						PCU->PCU_CVLTAD  := ltrim(str(cCVLTAD))
						PCU->PCU_CVLFS3  := ltrim(str(cCVLFS3))
						PCU->PCU_CVLAN3  := ltrim(str(cCVLAN3))
						PCU->PCU_CVLFAT  := ltrim(str(cCVLFAT))
						PCU->PCU_CVLBLF  := ltrim(str(cCVLBLF))
						PCU->PCU_FAZCON  := ltrim(str(cFAZCON))

						PCU->(MsUnlock())

					EndIf

				EndIf

			EndIf

		Next

	EndIF

Return

static Function fFecha(orig)

Local I  := 0

	If MsgYesNo("Confirma Execução Do Fechamento da Cobrança de Convenio ?")

		For I:= 1 to Len(aBrwPEG)

			If aBrwPEG[I,1]== .T. .and. orig == 1

				If fVFOpe(substr(aBrwPEG[I,3],1,4)) == .T.

					If cFecConv == 1
						MsgAlert("Convenio: "+ aBrwPEG[I,3] +"  Competecia : " + aBrwPEG[I,2]+ CRLF + CRLF + CRLF +;
							" Todos os Títulos desta Operadora e desta Competência  Sofrerão  fechamento "+ CRLF +;
							" Fechamento da Cobrança será Realizada  ", " Fechamento da Cobrança ")
					Else
						MsgAlert("Convenio: "+ aBrwPEG[I,3] +"  Competecia : " + aBrwPEG[I,2]+ CRLF + CRLF + CRLF +;
							" Todos os Títulos desta Operadora e desta Competência  Serão Considerados , mas NÂO Sofrerão  fechamento "+ CRLF +;
							" Fechamento da Cobrança NÃO será Realizada  ", " Fechamento da Cobrança ")
					EndIf

					aTit := u_Caba133( aBrwPEG[I,2]   , substr(aBrwPEG[I,3],1,4), cFecConv  )

					cMesBase     := substr(aBrwPEG[I,2],5,2)
					cAnoBase     := substr(aBrwPEG[I,2],1,4)
					cNumTitI     := aBrwPEG[I,5]
					cNumTitF     := aBrwPEG[I,5]
					cOpeFim      := substr(aBrwPEG[I,3],1,4)
					cOpeInc      := substr(aBrwPEG[I,3],1,4)

					if cFecConv == 1 .and. aTit[15] == 1

						cLOTCOB     := aTit[06]
						cFZCRIT     := aTit[07]
						cCVLTOT     := aTit[08]
						cCVLBAS     := aTit[09]
						cCVLTAD     := aTit[10]
						cCVLFS3     := aTit[11]
						cCVLAN3     := aTit[12]
						cCVLFAT     := aTit[13]
						cCVLBLF     := aTit[14]
						cFAZCON     := aTit[15]

						Idx := I

						fGrvPcu(substr(aBrwPEG[I,3],1,4))

						aBrwPEG[Idx ,14]:="FEITO"
						aBrwPEG[Idx ,15]:="FEITO"
						aBrwPEG[Idx ,01]:=.F.

						U_CABA130( substr(aTit[2],1,3) , substr(aTit[2],4,9) , substr(aTit[2],13,1) , substr(aTit[2],14,3) ,  'COV' , cNumTitI , ' ' , 'DP ' , aTit[3] , aTit[4] , aTit[5], cOpeInc)

						u_cabr243(cMesBase,cAnoBase,cNumTitI,aTit,cOpeInc,cOpeFim,2)

					EndIf

				Else

					If Orig == 1

						MsgAlert("Convenio: "+ aBrwPEG[I,3] + CRLF + CRLF + CRLF +;
							" À Títulos desta Operadora , desta Competência Faltando Cumprir Etapas Anteriores ou  "+ CRLF +;
							" Fechamento da Cobrança , NÃO será Realizada  ", " Fechamento da Cobrança ")
					EndIf

				EndIf

			EndIf

		NEXT

	EndIf

Return


Static Function AjustaSX1()

	Local aHelp 	:= {}

	aAdd(aHelp, "Compt Entrada  , ano mes da co mptencia de entrada  ")
	PutSX1(cPerg,"01", "Compt Entrada  ?","","","mv_ch1","C",6,0,0,"G","","","","","mv_par01"," ","","",""," ","",""," ","","","","","","","","",aHelp,aHelp,aHelp)

Return

Static Function ValPergFc()

	cPerg := PADR(cPerg,7)

	PutSx1(cPerg,"01","Mes Compencia     "  ,"","","mv_ch01","C",02,0,0,"G","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "99", "" )
	PutSx1(cPerg,"02","Ano Compencia     "  ,"","","mv_ch02","C",04,0,0,"G","","mv_par02","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "99", "" )
	PutSx1(cPerg,"03","Num Titulo Inc    "  ,"","","mv_ch03","C",09,0,0,"G","","mv_par03","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "99/99/9999", "" )
	PutSx1(cPerg,"04","Num Titulo Fim    "  ,"","","mv_ch04","C",09,0,0,"G","","mv_par04","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "99/99/9999", "" )
	PutSx1(cPerg,"05","Ope Origem Inc    "  ,"","","mv_ch05","C",04,0,0,"G","","mv_par05","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "99/99/9999", "" )
	PutSx1(cPerg,"06","Ope Origem Final  "  ,"","","mv_ch06","C",04,0,0,"G","","mv_par06","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "99", "" )

Return .T.

user Function fPgTit(cPref , cNum , cParc , cTip )

		   cQrySeq := " SELECT  DISTINCT E1_PREFIXO PREFIXO , E1_NUM NUM , E1_PARCELA PARCELA ,E1_TIPO TIPO,  E1_CLIENTE CLIENTE , E1_LOJA LOJA , E1_SALDO SALDO , E1_VALOR VALOR , E1_BAIXA BAIXA, E1_NUMBOR NUMBOR  "+ CRLF
		   cQrySeq += "   FROM  " +RetSqlName('SE1')+ " SE1  " + CRLF
		   cQrySeq += "  WHERE  E1_FILIAL ='"+ xFilial('SE1') +"' AND SE1.D_E_L_E_T_ = ' ' " + CRLF 

     	   cQrySeq += " AND E1_PREFIXO = '"+ cPref  +"'"+ CRLF  
		   cQrySeq += " AND E1_NUM     = '"+ cNum   +"'"+  CRLF
		   cQrySeq += " AND E1_PARCELA = '"+ cParc  +"'"+ CRLF
		   cQrySeq += " AND E1_TIPO    = '"+ cTip   +"'"+ CRLF
		   
		    
		   If Select((cAliasCT)) <> 0 
		
		     (cAliasCT)->(DbCloseArea()) 
		
		   Endif 
  
           TcQuery cQrySeq New Alias (cAliasCT)                                                                                                                                                                                   
           
           If !(cAliasCT)->(EOF())  
               cPrefixo := (cAliasCT)->PREFIXO 
               cNumero  := (cAliasCT)->NUM 
               cParcela := (cAliasCT)->PARCELA  
               cTipo    := (cAliasCT)->TIPO
               nSaldo   := (cAliasCT)->SALDO 
               nValor   := (cAliasCT)->VALOR  
               cBord    := (cAliasCT)->NUMBOR
           EndIf

Return
