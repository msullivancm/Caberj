#include "PROTHEUS.CH"
#Include 'PLSMGER.CH'
#include "PLSMGER2.CH"
#include "PLSMCCR.CH"                                               
#include "topconn.ch"  
#INCLUDE "TOTVS.CH"  

#INCLUDE 'RWMAKE.CH'
#INCLUDE 'FONT.CH'
#INCLUDE 'COLORS.CH'


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCRIAFJW  บAutor  ณ Altamiro	           บ Data ณ   22/10/2020บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ INSERIR DADOS NAS TABELAS DE INSS RETENวรO OUTRAS FONTES   บฑฑ
ฑฑบ          ณ 															  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function ATUCT9()                 

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Monta matriz com as opcoes do browse...                             ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

//PRIVATE cPath  := ""                        

local cQuery := ' '

PRIVATE cAlias := "SE2" 

PRIVATE cPerg	:= "ATUCT9"

PRIVATE cNomeProg   := "CABA181"
PRIVATE nQtdLin     := 68
PRIVATE nLimite     := 132
PRIVATE cControle   := 15
PRIVATE cTamanho    := "G"
PRIVATE cTitulo     := "Controle de Libera็ใo Titulos de Comissใo"
PRIVATE cDesc1      := ""
PRIVATE cDesc2      := ""
PRIVATE cDesc3      := ""
PRIVATE nRel        := "CABA181"
PRIVATE nlin        := 100
PRIVATE nOrdSel     := 1
PRIVATE m_pag       := 1
PRIVATE lCompres    := .F.
PRIVATE lDicion     := .F.
PRIVATE lFiltro     := .T.
PRIVATE lCrystal    := .F.
PRIVATE aOrdens     := {} 
PRIVATE aReturn     := { "", 1,"", 1, 1, 1, "",1 }
PRIVATE lAbortPrint := .F.
PRIVATE cCabec1     := "Controle de Libera็ใo de Titulos Comercial"
PRIVATE cCabec2     := ""
PRIVATE nColuna     := 00
Private cFiltro     := ' '
private cDthr       := (dtos(DATE()) + "-" + Time()) 
private _cUsuario   := subStr(cUSUARIO,7,15)  
Private cAliastmp   := GetNextAlias()  

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ

cQuery := CRLF + " SELECT CTJ_FILIAL FILIAL, " 
cQuery += CRLF + "        CTJ_RATEIO RATEIO, " 
cQuery += CRLF + "        CTJ_SEQUEN SEQUEN, " 
cQuery += CRLF + "        CTJ_DESC   DESCR , " 
cQuery += CRLF + "        CTJ_MOEDLC MOEDLC, " 
cQuery += CRLF + "        CTJ_TPSALD TPSALD, " 
cQuery += CRLF + "        CTJ_DEBITO DEBITO, " 
cQuery += CRLF + "        CTJ_CREDIT CREDIT, " 
cQuery += CRLF + "        CTJ_QTDDIS QTDDIS, " 
cQuery += CRLF + "        CTJ_PERCEN PERCEN, " 
cQuery += CRLF + "        CTJ_VALOR  VALOR , " 
cQuery += CRLF + "        CTJ_HIST   HIST  , " 
cQuery += CRLF + "        CTJ_CCD    CCD   , " 
cQuery += CRLF + "        CTJ_CCC    CCC   , " 
cQuery += CRLF + "        CTJ_ITEMD  ITEMD , " 
cQuery += CRLF + "        CTJ_ITEMC  ITEMC , " 
cQuery += CRLF + "        CTJ_CLVLDB CLVLDB, " 
cQuery += CRLF + "        CTJ_CLVLCR CLVLCR, " 
cQuery += CRLF + "        CTJ_QTDTOT QTDTOT, " 
cQuery += CRLF + "        CTJ_EVENTO EVENTO  "
cQuery += CRLF + "   FROM CTJ010 CTJ         "
cQuery += CRLF + "  WHERE CTJ_FILIAL   = '01' "
cQuery += CRLF + "    AND D_E_L_E_T_   = ' ' " 
//cQuery += CRLF + "    AND CTJ_RATEIO   = '101' " 
     
If Select((cAliastmp)) <> 0 
   (cAliastmp)->(DbCloseArea())  
Endif 
        
TCQuery cQuery  New Alias (cAliastmp)   

(cAliastmp)->(dbGoTop()) 
    
If (cAliastmp)->(!EOF())    
   
    Do while !(cAliastmp)->(eof()) 
	//  
        RECLOCK("CT9", .T. )

            CT9_FILIAL   :=  xFilial('CT9')   

            CT9_RAT_ON  := (cAliastmp)->RATEIO  		
            CT9_SEQUEN  := (cAliastmp)->SEQUEN  		
            CT9_DESC    := (cAliastmp)->DESCR  		
            CT9_MOEDLC  := (cAliastmp)->MOEDLC  		
            CT9_TPSALD  := (cAliastmp)->TPSALD  		
            CT9_DEBITO  := (cAliastmp)->DEBITO  		
            CT9_CREDIT  := (cAliastmp)->CREDIT  		
                                                    //QTDE DISTR = PERCENTUAL PARA CADA C.C
            CT9_PERCEN  := (cAliastmp)->PERCEN  		
            CT9_VLR01   := (cAliastmp)->VALOR  		
            CT9_HIST    := (cAliastmp)->HIST  		
            CT9_CCD     := (cAliastmp)->CCD  		
            CT9_CCC     := (cAliastmp)->CCC  		
            CT9_ITEMD   := (cAliastmp)->ITEMD  		
            CT9_ITEMC   := (cAliastmp)->ITEMC  		
            CT9_CLVLDB  := (cAliastmp)->CLVLDB  		
            CT9_CLVLCR  := (cAliastmp)->CLVLCR  		
                                                    // QUANT. TOTAL = 100
            CT9_EVENTO  := (cAliastmp)->EVENTO 		  
            CT9_PERBAS  := 100                       //NOT NULL NUMBER   		PERCENTUAL BASE = 100%
            CT9_DC      := '1'//(cAliastmp)->             //           NOT NULL CHAR(1)  		TIPO DE LANวAMENTO = 1/2/3
            CT9_MOEDAS  := '11111'                   //   		LANCAMENTO MOEDA = 11111
            CT9_CRITER  := '    '                    //    		CRITERIO = "    "

        (MSUNLOCK())

        (cAliastmp)->(DbSkip())
 
	EndDo

EndIf

Return()  
