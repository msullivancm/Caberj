#include "rwmake.ch"
#include "TOPCONN.CH" 
#INCLUDE "protheus.ch"
#include "TBICONN.CH"

#DEFINE c_ent CHR(13) + CHR(10)
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABR026    ºAutor  ³Renato Peixoto    º Data  ³  22/06/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Relatório de quantidade de usuários por NUPRE.              º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Plano de Saúde - PLS                                       º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function CABR026(dDataI,dDataF,cLocDe,cLocAte,cComp,dDtEv,nTpRel,cProj,cOpIni,cOpFin,cCodRdaI,cCodRdaF,nOpcR)


/*BEGINDOC
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Testar alteração feita em 17/12/2010 por mim para atender³
//³solicitação do dr. sandro que deseja visualizar os totais³
//³por produto também.                                      ³
//³Essa totalização sera feita a partir da variável private ³
//³criada de nome nTotProd.                                 ³
//³                                                         ³
//³Documentation by                                         ³
//³Renato Peixoto                                           ³
//³Date: 17/12/2010                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
ENDDOC*/                   

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//Local wnrel
Private cDesc1 	:= "Quantidade de Usuários por NUPRE"
Private cDesc2 	:= ""
Private cDesc3 	:= ""
Private cString 	:= "BF4"
Private nQtdLin     := 72
Private cAlias      := "BF4"
Private cRel        := "CABR026"
Private nLi         := nQtdLin+1
Private m_pag       := 1
Private lCompres    := .F.
Private lDicion     := .F.
Private lFiltro     := .F. //.T.
Private lCrystal    := .F.
Private aOrdem      := {"Empresa","Produto"}
Private lAbortPrint := .F.
PRIVATE nColuna     := 1 
Private nLimite     := 132
Private tamanho 	:= "M"
Private cTitulo	:= "QUANTIDADE DE USUÁRIOS POR NUPRE." //ver como fazer para colocar no titulo tambem o projeto
Private aReturn := { "Zebrado", 1,"Administracao", 1, 1, 1, "",1 }
Private cPerg   := "CABR26    "
Private nomeprog:= "CABR026"
Private nLastKey:=0
Private cabec1  := "Usuário                 Nome                                          Data Inclusão   Data Bloqueio      Valor          Vigência"
Private cabec2  := ""

//Variáveis a serem utilizadas na lógica de impressão
Private dDataIni    //:= Mv_Par01
Private dDataFim    //:= Mv_Par02   
Private cLocalDe    := "" //MV_PAR03
Private cLocalAte   := "" //MV_PAR04
Private cCompet     := ""//Mv_Par05
Private dDataEvento //:= Mv_Par06
Private nTipoRel    //:=Mv_Par07  
Private nTipo       := 0
Private cProjeto    := ""//MV_PAR08
Private cOperIni    := ""//MV_PAR09
Private cOperFin    := ""//MV_PAR10
Private cCodRdaIni  := ""//Mv_Par11
Private cCodRdaFim  := ""//Mv_Par12 
Private cCodAAG     := GetMV("MV_XCODAAG")
Private nCont       := 0
Private nTotNupre   := 0
Private nTotEmp     := 0
Private nTotGer     := 0
Private nQtdNUPRE   := 0
Private nQtdGeral   := 0
Private nTotProd    := 0 //nTotProd acrescentado por Renato Peixoto em 17/12/2010 para atender solicitação do Dr. Sandro.
Private nQtdProd    := 0 //nQtdProd acrescentado por Renato Peixoto em 17/12/2010 para atender solicitação do Dr. Sandro.
Private aDados		:= {}
Private nValor      := 0 
Private nOpcRel     := 0 //Identifica se o relatorio sera com a posição do dia ou baseado no que foi gravado no contas medicas quando a rotina de rateio foi processada
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Atualiza SX1                                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
CriaSX1(cPerg)
/*
IF !Pergunte(cPerg,.T.)
	Return
EndIF
*/
If AllTrim(FunName()) = "CABR026"

	Pergunte(cPerg,.T.)
	//Ordem dos parâmetros a partir do MV_PAR08 alterada em 27/10/10 pq foi retirado o parâmetro para gerar ctas médicas a partir do relatório. Foi subtraído 1. Renato Peixoto.
	If MV_PAR07 = 2
		cabec1  := "Empresa/Produto                                       Quantidade         Valor Per Capita                Valor Total          "
	EndIf
	
	dDataIni    := Mv_Par01
	dDataFim    := Mv_Par02
	cLocalDe    := MV_PAR03
	cLocalAte   := MV_PAR04
	cCompet     := Mv_Par05
	dDataEvento := Mv_Par06
	nTipoRel    := Mv_Par07 //Ordem dos parâmetros a partir do MV_PAR08 alterada em 27/10/10 pq foi retirado o parâmetro para gerar ctas médicas a partir do relatório. Foi subtraído 1. Renato Peixoto. 
	cProjeto    := MV_PAR08 //Ordem dos parâmetros a partir do MV_PAR08 alterada em 27/10/10 pq foi retirado o parâmetro para gerar ctas médicas a partir do relatório. Foi subtraído 1. Renato Peixoto.
    cOperIni    := MV_PAR09 //Ordem dos parâmetros a partir do MV_PAR08 alterada em 27/10/10 pq foi retirado o parâmetro para gerar ctas médicas a partir do relatório. Foi subtraído 1. Renato Peixoto.
    cOperFin    := MV_PAR10 //Ordem dos parâmetros a partir do MV_PAR08 alterada em 27/10/10 pq foi retirado o parâmetro para gerar ctas médicas a partir do relatório. Foi subtraído 1. Renato Peixoto.
    cCodRdaIni  := Mv_Par11 //Ordem dos parâmetros a partir do MV_PAR08 alterada em 27/10/10 pq foi retirado o parâmetro para gerar ctas médicas a partir do relatório. Foi subtraído 1. Renato Peixoto.
	cCodRdaFim  := Mv_Par12 //Ordem dos parâmetros a partir do MV_PAR08 alterada em 27/10/10 pq foi retirado o parâmetro para gerar ctas médicas a partir do relatório. Foi subtraído 1. Renato Peixoto.
	nOpcRel     := Mv_Par13
 Else 
	If AllTrim(FunName()) = "CABA022"
    	
    	Pergunte(cPerg,.F.)
    	
    	dDataIni   := dDataI
		dDataFim   := dDataF
		cLocalDe   := cLocDe
		cLocalAte  := cLocAte
		cCompet    := cComp
		dDataEvento:= dDtEv
		nTipoRel   := nTpRel //(dDataI,dDataF,cLocDe,cLocAte,cComp,dDtEv,cGeraCt,cTpRel,cProj,cOpIni,cOpFin,cCodRdaI,cCodRdaF)
    	cProjeto   := cProj
    	cOperIni   := cOpIni
    	cOperFin   := cOpFin
    	cCodRdaIni := cCodRdaI
		cCodRdaFim := cCodRdaF
    	nOpcRel    := nOpcR
    	
    	If nTipoRel = 2
			cabec1  := "Empresa/Produto                                       Quantidade         Valor Per Capita                Valor Total          "
		EndIf
	 
	EndIf
	
EndIf

//monta título do relatório referencia
cTitulo += "(Ref. Pgto.:" + Substr(DTOC(dDataIni),4,7) + ")"


cRel := SetPrint(cString,cRel,cPerg,@cTitulo,cDesc1,cDesc2,cDesc3,.F.,aOrdem,,tamanho,,.F.)

If nLastKey == 27
	Return
End

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Configura impressora (padrao)                                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
SetDefault(aReturn,cString)

If nLastKey == 27
	Return ( NIL )
End

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Emite relat¢rio                                                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
RptStatus({|lEnd| CABR026Imp(@lEnd,cRel,cString)},cTitulo)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fim da rotina                                                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Fun‡…o    ³CABR026Imp³ Autor ³ Renato Peixoto  ³ Data ³ 22/06/10       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Descri‡…o ³Impressao 											       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Sintaxe   ³CABR026Imp(lEnd,wnRel,cString)                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso       ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function CABR026Imp(lEnd,cRel,cString)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define variaveis...                                                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
LOCAL nOrdSel       := aReturn[8]  // será numérico (1 ou 2)
Local cbcont,cbtxt
Local cQuery2       := ""
Local cArqQry2      := GetNextAlias()
Local cNUPRE        := ""
Local cProd         := ""   
Local cEmpresa      := ""
Local nLoop         := 0  
Local lTrocouEmp    := .F.
Local lTrocouPro    := .F.
Local lTrocouNup    := .F.
Local lDesblOK      := .T.
Local aBloq         := {}
Local aRelExcel     := {}
Local nRedutor      := 0 //irá conter o número de usuários bloqueados no AAG no período especificado no relatório. Esse número será reduzido do totalizador
Local cRDA          := ""
Private cQuery      := ""
Private cArqQry     := GetNextAlias()

aAdd ( aRelExcel,{"NUPRE","CÓDIGO RDA","NOME DO NUPRE","MATRÍCULA","NOME DO USUÁRIO","VALOR INDIVIDUAL"})//aADD ( aRelExcel, { (cArqQry)->NUPRE, (cArqQry)->PA6_CODRDA, (cArqQry)->PA6_NOMNUP, AllTrim((cArqQry)->BA1_CODINT)+AllTrim((cArqQry)->BA1_CODEMP)+AllTrim((cArqQry)->BA1_MATRIC), (cArqQry)->BA1_NOMUSR, (cArqQry)->PA6_VALIND } )
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para Impressao do Cabecalho e Rodape    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cbtxt    := SPACE(10)
cbcont   := 0
li       := 80
m_pag    := 1

nTipo     := 15//GetMv("MV_COMP")
nTotNupre := 0
nQtdNUPRE := 0


dbSelectArea("BF4")

If nTipoRel = 1 //Relatório Analítico
    
	cQuery := "SELECT PA6.PA6_CODNUP nupre, bf4_codpro, bf4_datbas, bf4_datblo, bf4_motblo, ba1_matvid, "+c_ent //27-06-2011
	cQuery += "ba1_codint,ba1_codemp,ba1_matric,ba1_tipreg,ba1_digito,ba1_nomusr, ba1_datblo, BA3_CODPLA, BI3_DESCRI, "+c_ent
	cQuery += "PA6_CODINT, PA6_CODNUP, PA6_NOMNUP, PA6_CODRDA, PA6_DESRDA, PA6_VALIND, PA6_DTINI "+c_ent
	cQuery += "FROM   "+RetSqlName("BF4")+" BF4, "+RetSqlName("BA1")+" BA1, "+RetSqlName("BA3")+" BA3, "+RetSqlName("BI3")+" BI3, "+RetSqlName("PA6")+" PA6 "+c_ent
	cQuery += "WHERE  bf4.bf4_filial = '  ' AND ba1.ba1_filial = '  ' AND BA3.BA3_FILIAL = '  '    AND BI3.BI3_FILIAL = '  '    AND PA6.PA6_FILIAL = '  ' "+c_ent
	cQuery += "	   AND    bf4.bf4_codpro = '"+cProjeto+"' "+c_ent
	cQuery += "    AND BA1.BA1_CODINT BETWEEN '"+cOperIni+"' AND '"+cOperFin+"' "+c_ent
	cQuery += "    AND PA6.PA6_CODINT BETWEEN '"+cOperIni+"' AND '"+cOperFin+"' "+c_ent
	cQuery += "    AND PA6.PA6_CODLOC BETWEEN '"+cLocalDe+"' AND '"+cLocalAte+"' "+c_ent
	If cCodRDAIni < cCodRDAFim 
		cQuery += "    AND PA6.PA6_CODRDA BETWEEN '"+cCodRdaIni+"' AND '"+cCodRDAFim+"' "+c_ent
	Else
		cQuery += "    AND PA6.PA6_CODRDA BETWEEN '"+cCodRDAFim+"' AND '"+cCodRDAIni+"' "+c_ent
	EndIf    
	
	cQuery += "    AND    ba1.ba1_filial = bf4.bf4_filial "+c_ent
	cQuery += "    AND    ba1.ba1_codint = bf4.bf4_codint "+c_ent
	cQuery += "    AND    ba1.ba1_codemp = bf4.bf4_codemp "+c_ent
	cQuery += "	   AND    ba1.ba1_matric = bf4.bf4_matric "+c_ent
	cQuery += "    AND    ba1.ba1_tipreg = bf4.bf4_tipreg "+c_ent
	cQuery += "    AND BF4.BF4_CODINT = BA3.BA3_CODINT "+c_ent
	cQuery += "    AND BF4.BF4_CODEMP = BA3.BA3_CODEMP "+c_ent
	cQuery += "    AND BF4.BF4_MATRIC = BA3.BA3_MATRIC "+c_ent
	cQuery += "    AND BA3.BA3_CODPLA = BI3.BI3_CODIGO "+c_ent   
	
	//MOTTA --BIANCHINI - ACERTO DE QTD EM FEV/2013
	cQuery += "    AND RETORNA_NUCLEO_MS(BA1_CODINT,BA1_CODEMP,BA1_MATRIC,BA1_TIPREG,'"+DTOS(dDataIni)+"') = PA6.PA6_CODNUP "+c_ent //27-06-2011
	//M cQuery += "    AND RETORNA_NUCLEO_MS(BA1_CODINT,BA1_CODEMP,BA1_MATRIC,BA1_TIPREG,'"+DTOS(dDataFim)+"') = PA6.PA6_CODNUP "+c_ent //27-06-2011    	
	cQuery += "    AND PA6.PA6_DTBLOQ = ' ' "+c_ent
	
    //01/05/11  base congelada
	If nOpcRel = 1
		cQuery += "	   AND    ('"+DTOS(dDataIni)+"' BETWEEN bf4.bf4_datbas AND Nvl(Trim(bf4_datblo),'"+DTOS(dDataFim)+"') OR ( (SELECT bg3_tipblo FROM "+RetSqlName("BG3")+" BG3 WHERE bg3_filial = ' ' AND bg3_codblo = bf4_motblo AND D_E_L_E_T_ = ' ' )='1')) "+c_ent
		cQuery += "    AND    '"+DTOS(dDataIni)+"' BETWEEN ba1.ba1_datinc AND Nvl(Trim(ba1_datblo),'"+DTOS(dDataFim)+"') "+c_ent
	Else
	  cQuery += "    AND    BA1_MATRIC IN (SELECT PAE_MATRIC " +c_ent 
      cQuery += " 							FROM "+RetSqlName("PAE")+" PAE "+c_ent
      cQuery += "							WHERE PAE.PAE_FILIAL = '  ' AND PAE.PAE_COMPET = '"+cCompet+"' AND PAE.PAE_CODNUP = PA6.PA6_CODRDA "+c_ent
      cQuery += "							AND PAE.PAE_CODEMP = BA1.BA1_CODEMP AND PAE.PAE_MATRIC = BA1.BA1_MATRIC AND PAE.PAE_TIPREG = BA1.BA1_TIPREG "+c_ent
      cQuery += "							AND PAE.PAE_DIGITO = BA1.BA1_DIGITO AND PAE.D_E_L_E_T_ = ' ') "+c_ent
    Endif    
	
    cQuery += "    AND    bf4.d_e_l_e_t_ = ' ' "+c_ent
	cQuery += "    AND    ba1.d_e_l_e_t_ = ' ' "+c_ent
	cQuery += "    AND    BA3.D_E_L_E_T_ = ' ' "+c_ent
	cQuery += "    AND    BI3.D_E_L_E_T_ = ' ' "+c_ent
	cQuery += "    AND    PA6.D_E_L_E_T_ = ' ' "+c_ent    
	
	If nOrdSel = 1
		cQuery += "    ORDER  BY PA6.PA6_CODNUP, BF4_CODEMP, BA3_CODPLA " //27-06-2011
	Else
		cQuery += "    ORDER  BY PA6.PA6_CODNUP, BA3_CODPLA, BF4_CODEMP " //27-06-2011
	EndIf
	


Else //Relatório Sintético
    
    cQuery := "SELECT PA6.PA6_CODNUP nupre, ba1_codint, ba1_codemp, BA3_CODPLA, BI3_DESCRI,  PA6_CODNUP, PA6_NOMNUP, PA6_CODRDA, PA6_DESRDA, PA6_CODINT, PA6_VALIND, Sum(PA6_VALIND) VALTOTAL, PA6_DTINI, COUNT(PA6_CODINT) QUANT "+c_ent  //27-06-2011
	cQuery += "FROM   "+RetSqlName("BF4")+" BF4, "+RetSqlName("BA1")+" BA1, "+RetSqlName("BA3")+" BA3, "+RetSqlName("BI3")+" BI3, "+RetSqlName("PA6")+" PA6 "+c_ent
	cQuery += "	   WHERE  bf4.bf4_filial = '  ' AND ba1.ba1_filial = '  ' AND BA3.BA3_FILIAL = '  '    AND BI3.BI3_FILIAL = '  '    AND PA6.PA6_FILIAL = '  ' "+c_ent

	cQuery += "	   AND    bf4.bf4_codpro = '"+cProjeto+"' "+c_ent
	cQuery += "    AND BA1.BA1_CODINT BETWEEN '"+cOperIni+"' AND '"+cOperFin+"' "+c_ent
	cQuery += "    AND PA6.PA6_CODINT BETWEEN '"+cOperIni+"' AND '"+cOperFin+"' "+c_ent
	cQuery += "    AND PA6.PA6_CODLOC BETWEEN '"+cLocalDe+"' AND '"+cLocalAte+"' "+c_ent
	If cCodRDAIni < cCodRDAFim
		cQuery += "    AND PA6.PA6_CODRDA BETWEEN '"+cCodRdaIni+"' AND '"+cCodRDAFim+"' "+c_ent
	Else
		cQuery += "    AND PA6.PA6_CODRDA BETWEEN '"+cCodRDAFim+"' AND '"+cCodRDAIni+"' "+c_ent
	EndIf     
	
	cQuery += "    AND    ba1.ba1_filial = bf4.bf4_filial "+c_ent
	cQuery += "    AND    ba1.ba1_codint = bf4.bf4_codint "+c_ent
	cQuery += "    AND    ba1.ba1_codemp = bf4.bf4_codemp "+c_ent
	cQuery += "	   AND    ba1.ba1_matric = bf4.bf4_matric "+c_ent
	cQuery += "    AND    ba1.ba1_tipreg = bf4.bf4_tipreg "+c_ent
	cQuery += "    AND BF4.BF4_CODINT = BA3.BA3_CODINT "+c_ent
	cQuery += "    AND BF4.BF4_CODEMP = BA3.BA3_CODEMP "+c_ent
	cQuery += "    AND BF4.BF4_MATRIC = BA3.BA3_MATRIC "+c_ent
	cQuery += "    AND BA3.BA3_CODPLA = BI3.BI3_CODIGO "+c_ent 
	  
	//MOTTA BIANCHINI - ACERTO DE QTD EM FEV/2013
	cQuery += "    AND RETORNA_NUCLEO_MS(BA1_CODINT,BA1_CODEMP,BA1_MATRIC,BA1_TIPREG,'"+DTOS(dDataIni)+"') = PA6.PA6_CODNUP "+c_ent //27-06-2011
	//M cQuery += "    AND RETORNA_NUCLEO_MS(BA1_CODINT,BA1_CODEMP,BA1_MATRIC,BA1_TIPREG,'"+DTOS(dDataFim)+"') = PA6.PA6_CODNUP "+c_ent 
    
	cQuery += "    AND PA6.PA6_DTBLOQ = ' ' "+c_ent
	
	//01/05/11  base congelada
	If nOpcRel = 1
		cQuery += "	   AND    ('"+DTOS(dDataIni)+"' BETWEEN bf4.bf4_datbas AND Nvl(Trim(bf4_datblo),'"+DTOS(dDataFim)+"') OR ( (SELECT bg3_tipblo FROM "+RetSqlName("BG3")+" BG3 WHERE bg3_filial = ' ' AND bg3_codblo = bf4_motblo AND D_E_L_E_T_ = ' ' )='1')) "+c_ent
		cQuery += "    AND    '"+DTOS(dDataIni)+"' BETWEEN ba1.ba1_datinc AND Nvl(Trim(ba1_datblo),'"+DTOS(dDataFim)+"') "+c_ent
	Else
	  cQuery += "    AND    BA1_MATRIC IN (SELECT PAE_MATRIC " +c_ent 
      cQuery += " 							FROM "+RetSqlName("PAE")+" PAE "+c_ent
      cQuery += "								WHERE PAE.PAE_FILIAL = '  ' AND PAE.PAE_COMPET = '"+cCompet+"' AND PAE.PAE_CODNUP = PA6.PA6_CODRDA "+c_ent
      cQuery += "								AND PAE.PAE_CODEMP = BA1.BA1_CODEMP AND PAE.PAE_MATRIC = BA1.BA1_MATRIC AND PAE.PAE_TIPREG = BA1.BA1_TIPREG "+c_ent
      cQuery += "								AND PAE.PAE_DIGITO = BA1.BA1_DIGITO AND PAE.D_E_L_E_T_ = ' ') "+c_ent
    Endif      
	
	cQuery += "    AND    bf4.d_e_l_e_t_ = ' ' "+c_ent
	cQuery += "    AND    ba1.d_e_l_e_t_ = ' ' "+c_ent
	cQuery += "    AND    BA3.D_E_L_E_T_ = ' ' "+c_ent
	cQuery += "    AND    BI3.D_E_L_E_T_ = ' ' "+c_ent
	cQuery += "    AND    PA6.D_E_L_E_T_ = ' ' "+c_ent   
	
	//Motta 30/05/2011
	cQuery += "    AND    RETORNA_NUCLEO_MS(BA1_CODINT,BA1_CODEMP,BA1_MATRIC,BA1_TIPREG,'"+DTOS(dDataIni)+"') <> ' ' "
	//MOTA - BIANCHINI - ACERTO DE QTD EM FEV/2013
	// M cQuery += "    AND    RETORNA_NUCLEO_MS(BA1_CODINT,BA1_CODEMP,BA1_MATRIC,BA1_TIPREG,'"+DTOS(dDataFim)+"') <> ' ' "

	  
	cQuery += "	   GROUP BY PA6.PA6_CODNUP,  ba1_codint, ba1_codemp,  BA3_CODPLA, BI3_DESCRI, PA6_CODNUP, PA6_NOMNUP, PA6_CODRDA, PA6_DESRDA, PA6_VALIND, PA6_CODINT,  PA6_DTINI "+c_ent
	If nOrdSel = 1
		cQuery += "    ORDER  BY PA6.PA6_CODNUP, BA1_CODEMP, BA3_CODPLA " //27-06-2011
	Else
		cQuery += "    ORDER  BY PA6.PA6_CODNUP, BA3_CODPLA, BA1_CODEMP " //27-06-2011
	EndIf

EndIf
	    
//memowrit("C:\TEMP\CABR026.SQL",cQuery)

If Select(cArqQry) > 0
	(cArqQry)->(DbCloseArea())
EndIf

*--------------------------------------------*
*** Cria o alias executando a query
*--------------------------------------------*
DbUseArea(.T.,"TopConn",TcGenQry(,,cQuery),cArqQry,.F.,.T.)

DbSelectArea(cArqQry)
COUNT to nCont // Conta o total de registro na tabela
DbGotop()
//PLSQuery(cSQL,"cArqQry")
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Trata se nao existir registros...                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea(cArqQry)
(cArqQry)->(DbGoTop())

SetRegua(nCont)

nTotRDA := 0
nTotEmp := 0
nTotGer := 0
cRDA := (cArqQry)->PA6_CODRDA
While !((cArqQry)->(Eof()))//começar aqui tratamento de impressao do relatorio, quebrando por nupre, empresa e produto
    nRedutor   := 0
	lTrocouPro := .F. //Renato Peixoto em 22/12/2010
	lTrocouNup := .F. //Renato Peixoto em 22/12/2010
	nLoop++
	
	//teste motta If nTipoRel = 1  //O relatório analítico verifica o histórico de bloqueios e desbloqueios dos opcionais. O sintético ainda não faz isso.
	//Motta 07/07/11 	lDesblOK := .T.
	//Motta 07/07/11 	//01/05/11  na base congelada nao verifica o historico
	//Motta 07/07/11 	If nOpcRel = 1
	//Motta 07/07/11 		//Trata quando o usuário já foi bloqueado no AAG em alguma data. Se o desbloqueio ocorreu após a data até do parâmetro, o registro não é para ser considerado.
    //Motta 07/07/11 		//Renato Peixoto em 29/09/10
    //Motta 07/07/11 		// Motta 30/05/2011 If !Empty((cArqQry)->BF4_MOTBLO )
    //Motta 07/07/11 			cQuery2 := "SELECT BGU_MATRIC, BGU_TIPO, BGU_DATA, BGU_MOTBLO, BGU_CODPRO "+c_ent
    //Motta 07/07/11 			cQuery2 += "FROM "+RetSqlName("BGU")+" BGU "+c_ent	
    //Motta 07/07/11 			cQuery2 += "WHERE BGU_FILIAL = '"+XFILIAL("BGU")+"' "+c_ent
	//teste motta			cQuery2 += "AND BGU_MATRIC = '"+(cArqQry)->BA1_CODINT+(cArqQry)->BA1_CODEMP+(cArqQry)->BA1_MATRIC+"' "+c_ent
	//teste motta			cQuery2 += "AND BGU_CODPRO = '"+(cArqQry)->BF4_CODPRO+"' "+c_ent
    //teste motta			cQuery2 += "AND BGU_TIPREG = '"+(cArqQry)->BA1_TIPREG+"' "+c_ent
	//teste motta			cQuery2 += "AND BGU.D_E_L_E_T_ = ' ' "+c_ent
	//teste motta			cQuery2 += "ORDER BY BGU_DATA, BGU_TIPO "  //BGU_TIPO acrescentado por Renato Peixoto em 29/03/2011, pois pode ocorrer um bloqueio e desbloqueio no mesmo dia
    //teste motta
    //teste motta			If Select(cArqQry2) > 0
	//teste motta				(cArqQry2)->(DbCloseArea())
	//teste motta			EndIf
    //teste motta
	//teste motta			*--------------------------------------------*
    //teste motta			*** Cria o alias executando a query
	//teste motta			*--------------------------------------------*
	//teste motta			DbUseArea(.T.,"TopConn",TcGenQry(,,cQuery2),cArqQry2,.F.,.T.)
	//teste motta	
    //teste motta			While !((cArqQry2)->(Eof())) .AND. AllTrim((cArqQry2)->BGU_MATRIC) == AllTrim((cArqQry)->BA1_CODINT)+AllTrim((cArqQry)->BA1_CODEMP)+AllTrim((cArqQry)->BA1_MATRIC)	
    //teste motta				If (cArqQry2)->BGU_TIPO = "0" 
    //teste motta					If STOD((cArqQry2)->BGU_DATA) < dDataIni 
    //teste motta						lDesblOK := .F.
    //teste motta						(cArqQry2)->(DbSkip())
    //teste motta						Loop
    //teste motta					Else
    //teste motta						If STOD((cArqQry2)->BGU_DATA) < dDataFim
    //teste motta							lDesblOK := .T.
    //teste motta							Exit
    //teste motta						Else
    //teste motta							lDesblOK := .T.
    //teste motta						EndIf
    //teste motta					EndIf  
    //teste motta				Else
    //teste motta					If STOD((cArqQry2)->BGU_DATA) > dDataFim
    //teste motta						lDesblOK := .F.
    //teste motta					Else
    //teste motta						If STOD((cArqQry2)->BGU_DATA) >= dDataIni .AND. STOD((cArqQry2)->BGU_DATA) <= dDataFim
    //teste motta							lDesblOK := .T.
    //teste motta							Exit
    //teste motta						Else
    //teste motta							lDesblOk := .T.
    //teste motta						EndIf
    //teste motta					EndIf
    //teste motta				EndIf
    //teste motta				(cArqQry2)->(DbSkip())
    //teste motta			EndDo
    //teste motta			(cArqQry2)->(DbCloseArea())
    //teste motta		// Motta 30/05/2011 EndIf
    //Motta 07/07/11 
    //Motta 07/07/11 		If !lDesblOK 
    //Motta 07/07/11 			aAdd ( aBloq, { (cArqQry)->NUPRE, (cArqQry)->PA6_CODRDA,AllTrim((cArqQry)->BA1_CODINT)+AllTrim((cArqQry)->BA1_CODEMP)+AllTrim((cArqQry)->BA1_MATRIC), (cArqQry)->BA1_NOMUSR } )
    //Motta 07/07/11 			(cArqQry)->(DbSkip())
    //Motta 07/07/11 			Loop
    //Motta 07/07/11 		EndIf            
    //Motta 07/07/11 	Endif    	
	//Motta 07/07/11 EndIf
	
	If nOrdSel = 1
		lTrocouEmp := .F.
	Else
		lTrocouPro := .F.
	EndIf
	
	If li > nQtdLin
		li := cabec(cTitulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
		li++
	EndIf
	
	If (cArqQry)->PA6_CODNUP <> cNUPRE .AND. nLoop <> 1
		lTrocouNup := .T. //Renato Peixoto em 22/12/2010
		If nTipoRel = 2
			
			//nRedutor := U_BSCBLOQ(cRDA)
			cRDA := (cArqQry)->PA6_CODRDA
			//li++
			@ li, 000 PSAY Replicate("-",132)
			li++
			//nQtdNupre -= nRedutor
			@ li, 000 PSay "Quantidade NUPRE -->"
			@ li, 020 PSay Transform(nQtdNupre ,"@E 999,999,999")
			
			//nTotNupre -= nValor * nRedutor
			@ li, 065 PSay "Total NUPRE -->"
			@ li, 085 PSay Transform(nTotNupre ,"@E 999,999,999.99")
			nTotGer   += nTotNupre
			nQtdGeral += nQtdNUPRE
			
			cNUPRE := (cArqQry)->PA6_CODNUP
			nValor := (cArqQry)->PA6_VALIND
			nTotNupre := 0
			nQtdNUPRE := 0
			li := cabec(cTitulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
			li++
			@ li, 001 PSay "NUPRE: " + (cArqQry)->PA6_CODNUP + " - " + (cArqQry)->PA6_NOMNUP
			li++
			@ li, 001 PSay "RDA Responsável pelo NUPRE: " + (cArqQry)->PA6_CODRDA + " - " + (cArqQry)->PA6_DESRDA
			@ li, 082 PSay "Projeto: " + cProjeto + " - " + POSICIONE("BI3",1,XFILIAL("BI3")+(cArqQry)->PA6_CODINT+cProjeto,"BI3_DESCRI")
			li++
		Else
			li++
			@ li, 001 PSay "TOTAL PRODUTO " + cProd + " - " + AllTrim(POSICIONE("BI3",1,XFILIAL("BI3")+(cArqQry)->BA1_CODINT+cProd,"BI3_DESCRI")) + " : R$" + AllTrim(Transform(nTotProd,"@E 999,999,999.99")) + " pagos para um total de " + AllTrim(Transform(nQtdProd,"@E 999,999,999")) + " usuários."//AllTrim(STR(nTotProd)) //Acrescentado por Renato Peixoto em 17/12/10 para totalizar também por produto a pedido do Dr. Sandro
			li++//Renato Peixoto em 17/12/2010
			@ li, 000 PSay Replicate("-",132) //Renato Peixoto em 17/12/2010
			li+=2//Renato Peixoto em 17/12/2010
			nTotProd := 0 //Renato Peixoto em 17/12/2010
			nQtdProd := 0 //Renato Peixoto em 22/12/2010
			
			
			cNUPRE := (cArqQry)->PA6_CODNUP
			nValor := (cArqQry)->PA6_VALIND
			//li++
			@ li, 000 PSAY Replicate("-",132)
			li++
			@ li, 000 PSay "Quantidade NUPRE -->"
			@ li, 020 PSay Transform(nQtdNupre ,"@E 999,999,999")
			@ li, 065 PSay "Total NUPRE -->"
			@ li, 085 PSay Transform(nTotNupre ,"@E 999,999,999.99")
			nTotGer   += nTotNupre
			nQtdGeral += nQtdNUPRE
			nTotNupre := 0
			nQtdNUPRE := 0
			li := cabec(cTitulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
			li++
			@ li, 001 PSay "NUPRE: " + (cArqQry)->PA6_CODNUP + " - " + (cArqQry)->PA6_NOMNUP
			li++
			@ li, 001 PSay "RDA Responsável pelo NUPRE: " + (cArqQry)->PA6_CODRDA + " - " + (cArqQry)->PA6_DESRDA
			@ li, 082 PSay "Projeto: " + cProjeto + " - " + POSICIONE("BI3",1,XFILIAL("BI3")+(cArqQry)->PA6_CODINT+cProjeto,"BI3_DESCRI")
			li++
	    EndIf
	EndIf
	
	If nLoop = 1
		cNUPRE := (cArqQry)->PA6_CODNUP
		nValor := (cArqQry)->PA6_VALIND
	
		@ li, 001 PSay "NUPRE: " + (cArqQry)->PA6_CODNUP + " - " + (cArqQry)->PA6_NOMNUP
		li++
		@ li, 001 PSay "RDA Responsável pelo NUPRE: " + (cArqQry)->PA6_CODRDA + " - " + (cArqQry)->PA6_DESRDA
		@ li, 082 PSay "Projeto: " + cProjeto + " - " + POSICIONE("BI3",1,XFILIAL("BI3")+(cArqQry)->PA6_CODINT+cProjeto,"BI3_DESCRI")
		li++
	EndIf
	
	
	If nOrdSel = 1
	    
		If (cArqQry)->BA3_CODPLA <> cProd   
			lTrocouPro := .T.
			If nTipoRel = 1
				@ li += 2
			EndIf
			
			If li > nQtdLin
				li := cabec(cTitulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
				li++
			EndIf
		
			If nLoop > 1 .AND. !lTrocouNup//Renato Peixoto em 17/12/2010
				If nTipoRel = 1 //Acrescentado por Renato Peixoto em 19/01/11 para imprimir esse detalhe somente quando o relatório for analítico
					@ li, 001 PSay "TOTAL PRODUTO " + cProd + " - " + AllTrim(POSICIONE("BI3",1,XFILIAL("BI3")+(cArqQry)->BA1_CODINT+cProd,"BI3_DESCRI")) + " : R$" + AllTrim(Transform(nTotProd,"@E 999,999,999.99")) + " pagos para um total de " + AllTrim(Transform(nQtdProd,"@E 999,999,999")) + " usuários."//Alltrim(STR(nTotProd)) //Acrescentado por Renato Peixoto em 17/12/10 para totalizar também por produto a pedido do Dr. Sandro
					li++//Renato Peixoto em 17/12/2010
					@ li, 000 PSay Replicate("-",132) //Renato Peixoto em 17/12/2010
					li+=2//Renato Peixoto em 17/12/2010
					nTotProd := 0 //Renato Peixoto em 17/12/2010
					nQtdProd := 0 //Renato Peixoto em 22/12/2010
				EndIf //Acrescentado por renato Peixoto em 19/01/11 para imprimir esse detalhe somente quando for relatório analítico
			EndIf//Renato Peixoto em 17/12/2010
		EndIf
		
		If (cArqQry)->BA1_CODEMP <> cEmpresa 
			lTrocouEmp := .T.  
			cEmpresa := (cArqQry)->BA1_CODEMP
			@ li += 2
			@ li, 001 PSay "EMPRESA: " + cEmpresa + " - " + POSICIONE("BG9",1,XFILIAL("BG9")+(cArqQry)->BA1_CODINT+(cArqQry)->BA1_CODEMP,"BG9_DESCRI")
			li++ 
			@ li, 000 PSAY Replicate("-",132)
			li++
		EndIf
	
		If lTrocouEmp .AND. (cArqQry)->BA3_CODPLA = cProd
			If nTipoRel = 1
				li ++
			EndIf
			
			If li > nQtdLin
				li := cabec(cTitulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
				li++
			EndIf
			
			@ li, 001 PSay "PRODUTO: " + cProd + " - " + AllTrim((cArqQry)->BI3_DESCRI)
			li ++
		EndIf
	
		If lTrocouPro//(cArqQry)->BA3_CODPLA <> cProd   
			cProd := (cArqQry)->BA3_CODPLA
			If nTipoRel = 1
				@ li += 2
			EndIf
			
			If li > nQtdLin
				li := cabec(cTitulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
				li++
			EndIf
			
			@ li, 001 PSay "PRODUTO: " + cProd + " - " + AllTrim((cArqQry)->BI3_DESCRI)
			li++ 
			li++
			lTrocouPro := .F.
		EndIf
		cProd    := (cArqQry)->BA3_CODPLA 
		cEmpresa := (cArqQry)->BA1_CODEMP  
	
	Else
	
		If (cArqQry)->BA3_CODPLA <> cProd  //trocar para produto BA3_CODPLA e cProd
			lTrocouPro := .T.  
			@ li += 2
			
			If li > nQtdLin
				li := cabec(cTitulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
				li++
			EndIf
			
			If nLoop > 1 .AND. !lTrocouNup//Renato Peixoto em 17/12/2010
				If nTipoRel = 1//Acrescentado por renato Peixoto em 19/01/11 para imprimir esse detalhe somente quando for relatório analítico
					li++
					@ li, 001 PSay "TOTAL PRODUTO " + cProd + " - " + AllTrim(POSICIONE("BI3",1,XFILIAL("BI3")+(cArqQry)->BA1_CODINT+cProd,"BI3_DESCRI")) + " : R$" + AllTrim(Transform(nTotProd,"@E 999,999,999.99")) + " pagos para um total de " + AllTrim(Transform(nQtdProd,"@E 999,999,999")) + " usuários."//AllTrim(STR(nTotProd)) //Acrescentado por Renato Peixoto em 17/12/10 para totalizar também por produto a pedido do Dr. Sandro
					li++//Renato Peixoto em 17/12/2010
					@ li, 000 PSay Replicate("-",132) //Renato Peixoto em 17/12/2010
					li+=2//Renato Peixoto em 17/12/2010
					nTotProd := 0 //Renato Peixoto em 17/12/2010
					nQtdProd := 0 //Renato Peixoto em 22/12/2010
				EndIf //Acrescentado por renato Peixoto em 19/01/11 para imprimir esse detalhe somente quando for relatório analítico
			EndIf//Renato Peixoto em 17/12/2010
			cProd := (cArqQry)->BA3_CODPLA//Renato Peixoto em 23/12/10
			@ li, 001 PSay "PRODUTO: " + cProd + " - " + (cArqQry)->BI3_DESCRI
			li++ 
			@ li, 000 PSAY Replicate("-",132)
		   	li++
		EndIf
	
		If lTrocouPro .AND. (cArqQry)->BA1_CODEMP = cEmpresa  //trocar para empresa  BA1_CODEMP e cEmpresa
			li ++
			If li > nQtdLin
				li := cabec(cTitulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
				li++
			EndIf
			@ li, 001 PSay "EMPRESA: " + cEmpresa + " - " + POSICIONE("BG9",1,XFILIAL("BG9")+(cArqQry)->BA1_CODINT+(cArqQry)->BA1_CODEMP,"BG9_DESCRI")
			li ++
		EndIf
	
		If (cArqQry)->BA1_CODEMP <> cEmpresa //trocar para empresa   BA1_CODEMP e cEmpresa
			cEmpresa := (cArqQry)->BA1_CODEMP
			@ li += 2
			If li > nQtdLin
				li := cabec(cTitulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
				li++
			EndIf
			@ li, 001 PSay "EMPRESA: " + cEmpresa + " - " + POSICIONE("BG9",1,XFILIAL("BG9")+(cArqQry)->BA1_CODINT+(cArqQry)->BA1_CODEMP,"BG9_DESCRI")
			li++ 
		EndIf
		cProd    := (cArqQry)->BA3_CODPLA 
		cEmpresa := (cArqQry)->BA1_CODEMP
	
	EndIf		
	
	If nTipoRel = 1		//analítico	
		@ li, 001 PSay (cArqQry)->BA1_CODINT+(cArqQry)->BA1_CODEMP+(cArqQry)->BA1_MATRIC+(cArqQry)->BA1_TIPREG+(cArqQry)->BA1_DIGITO
		@ li, 030 PSay SubStr((cArqQry)->BA1_NOMUSR,1,40)//025
		@ li, 072 PSay STOD((cArqQry)->BF4_DATBAS) //072
		@ li, 085 PSay STOD((cArqQry)->BF4_DATBLO)
		@ li, 100 PSay Transform(nValor,"@E 999,999,999.99")
		@ li, 122 PSay STOD((cArqQry)->PA6_DTINI)
		
		nTotProd += nValor
		nQtdProd++
		li++
		//adiciona o usuário impresso no vetor que irá gerar o relatório em excel 
		aADD ( aRelExcel, { (cArqQry)->NUPRE, (cArqQry)->PA6_CODRDA, (cArqQry)->PA6_NOMNUP, AllTrim((cArqQry)->BA1_CODINT)+AllTrim((cArqQry)->BA1_CODEMP)+AllTrim((cArqQry)->BA1_MATRIC), (cArqQry)->BA1_NOMUSR, (cArqQry)->PA6_VALIND } )
		
		nTotNupre := nTotNupre + nValor
		nQtdNUPRE++  
	
	Else	//sintético
	    li -= 2
	    //nRedutor := U_BSCBLOQ((cArqQry)->PA6_CODRDA,cProd,cEmpresa)//busca a quantidade de usuários bloqueados no AAG no período especificado por parâmetro em cada empresa e plano
		@ li, 060 PSay (cArqQry)->QUANT-nRedutor
		@ li, 080 PSay (cArqQry)->PA6_VALIND
		@ li, 096 PSay Transform((cArqQry)->VALTOTAL-((cArqQry)->PA6_VALIND*nRedutor) ,"@E 999,999,999.99")
		li += 2
	    nTotNupre += (cArqQry)->VALTOTAL-((cArqQry)->PA6_VALIND*nRedutor)
		nQtdNUPRE += (cArqQry)->QUANT-nRedutor   
		
	EndIf
 	
   	   	
	(cArqQry)->(DbSkip())
	   		
Enddo

If Len(aBloq) > 0
	DlgToExcel({{"ARRAY","Problemas com bloqueio","",aBloq}}) 
EndIf

If nLoop = 1

	nTotGer   := nTotNupre
	nQtdGeral := nQtdNUPRE
	li++
	@ li, 000 PSAY Replicate("-",132)
	li++
	@ li, 000 PSay "Quantidade Total -->"
	@ li, 020 PSay Transform(nQtdGeral ,"@E 999,999,999")
	@ li, 065 PSay "Total Geral -->"
	@ li, 085 PSay Transform(nTotGer ,"@E 999,999,999.99")//Valor Total

EndIf

If nTipoRel = 1 //Acrescentado por renato Peixoto em 19/01/11 para imprimir esse detalhe somente quando for relatório analítico
	//Imprime o total do último produto
	li++
	@ li, 001 PSay "TOTAL PRODUTO " + cProd + " - " + AllTrim(POSICIONE("BI3",1,XFILIAL("BI3")+(cArqQry)->BA1_CODINT+cProd,"BI3_DESCRI")) + " : R$" + AllTrim(Transform(nTotProd,"@E 999,999,999.99")) + " pagos para um total de " + AllTrim(Transform(nQtdProd,"@E 999,999,999")) + " usuários."//AllTrim(STR(nTotProd)) //Acrescentado por Renato Peixoto em 17/12/10 para totalizar também por produto a pedido do Dr. Sandro
	li++//Renato Peixoto em 17/12/2010
	@ li, 000 PSay Replicate("-",132) //Renato Peixoto em 17/12/2010
	li+=2//Renato Peixoto em 17/12/2010
	nTotProd := 0 //Renato Peixoto em 17/12/2010
	nQtdProd := 0 //Renato Peixoto em 22/12/2010
EndIf //Acrescentado por renato Peixoto em 19/01/11 para imprimir esse detalhe somente quando for relatório analítico


//Imprime os totais do último NUPRE impresso no relatório
li++
@ li, 000 PSAY Replicate("-",132)
li++
@ li, 000 PSay "Quantidade NUPRE -->"
@ li, 020 PSay Transform(nQtdNupre ,"@E 999,999,999")
@ li, 065 PSay "Total NUPRE -->"
@ li, 085 PSay Transform(nTotNupre ,"@E 999,999,999.99")
nTotGer   += nTotNupre
nQtdGeral += nQtdNUPRE


li++
@ li, 000 PSAY Replicate("-",132)
li++
@ li, 000 PSay "Quantidade Total -->"
@ li, 020 PSay Transform(nQtdGeral ,"@E 999,999,999")
@ li, 065 PSay "Total Geral -->"
@ li, 085 PSay Transform(nTotGer ,"@E 999,999,999.99")//Valor Total
/*If li != 80
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Imprime rodape do relatorio...                                     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	roda(cbcont,cbtxt,tamanho)
End  */
dbSelectArea(cArqQry)
(cArqQry)->(dbCloseArea())

//Gera o relatório em excel a pedido do Dr. Sandro quando o relatório for analítico....
If nTipoRel = 1
	DlgToExcel({{"ARRAY","Relatório AAG em Excel","",aRelExcel}}) 
EndIf

//dbSelectArea("BD6")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Libera impressao                                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Set Device To Screen

If aReturn[5] = 1
	Set Printer To
	dbCommitAll()
	OurSpool(cRel)
Endif

MS_FLUSH()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fim do Relat¢rio                                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ CriaSX1  ³ Autor ³ Renato Peixoto        ³ Data ³ 22/06/10 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Atualiza perguntas                                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ CriaSX1()                                                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function CriaSX1()

PutSx1(cPerg,"01",OemToAnsi("Dt. Analise de:")		 ,"","","mv_ch1","D",08,0,0,"G","","   ","","","mv_par01",""   ,"","","",""   ,"","","","","","","","","","","",{"Determina a partir de qual data será feito o filtro"},{""},{""})
PutSx1(cPerg,"02",OemToAnsi("Dt. Analise ate:")		 ,"","","mv_ch2","D",08,0,0,"G","","   ","","","mv_par02",""   ,"","","",""   ,"","","","","","","","","","","",{"Determina ate qual data será feito o filtro"},{""},{""})
PutSx1(cPerg,"03",OemToAnsi("Local atendimento de:") ,"","","mv_ch3","C",06,0,0,"G","","PA6LOC","","","mv_par03",""   ,"","","",""   ,"","","","","","","","","","","",{"Determina a partir de qual local de atendimento será feito o filtro"},{""},{""})
PutSx1(cPerg,"04",OemToAnsi("Local atendimento ate:"),"","","mv_ch4","C",06,0,0,"G","","PA6LOC","","","mv_par04",""   ,"","","",""   ,"","","","","","","","","","","",{"Determina ate qual local de atendimento será feito o filtro"},{""},{""})
PutSx1(cPerg,"05",OemToAnsi("Competencia Pgto:")     ,"","","mv_ch5","C",06,0,0,"G","","   ","","","mv_par05",""   ,"","","",""   ,"","","","","","","","","","","",{"Defina qual será a competencia de Pgto no formato mmaaaa"},{""},{""})
PutSx1(cPerg,"06",OemToAnsi("Data do Evento:")       ,"","","mv_ch6","D",08,0,0,"G","","   ","","","mv_par06",""   ,"","","",""   ,"","","","","","","","","","","",{"Defina qual será a data do evento"},{""},{""})
//PutSx1(cPerg,"07",OemToAnsi("Gera Contas Médicas?")  ,"","","mv_ch7","C",01,0,0,"C","","   ","","","mv_par07","Sim"      ,"","","","Nao"      ,"","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"07",OemToAnsi("Tipo de Relatório:")    ,"","","mv_ch7","C",01,0,0,"C","","   "   ,"","","mv_par07","Analitico","","","","Sintetico","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"08",OemToAnsi("Qual Projeto?")         ,"","","mv_ch8","C",04,0,0,"G","","BI3COD","","","mv_par08",""   ,"","","",""   ,"","","","","","","","","","","",{"Defina qual será o Projeto"},{""},{""})
PutSx1(cPerg,"09",OemToAnsi("Código Operadora de:")  ,"","","mv_ch9","C",04,0,0,"G","","B89PLS","","","mv_par09",""   ,"","","",""   ,"","","","","","","","","","","",{"A partir de qual operadora?"},{""},{""})
PutSx1(cPerg,"10",OemToAnsi("Código Operadora Ate:") ,"","","mv_ch10","C",04,0,0,"G","","B89PLS","","","mv_par10",""   ,"","","",""   ,"","","","","","","","","","","",{"Ate qual operadora?"},{""},{""})
PutSx1(cPerg,"11",OemToAnsi("RDA De:")               ,"","","mv_ch11","C",06,0,0,"G","","PA6RDA","","","mv_par11",""   ,"","","",""   ,"","","","","","","","","","","",{"A partir de qual RDA?"},{""},{""})
PutSx1(cPerg,"12",OemToAnsi("RDA Ate:")              ,"","","mv_ch12","C",06,0,0,"G","","PA6RDA","","","mv_par12",""   ,"","","",""   ,"","","","","","","","","","","",{"Ate qual RDA?"},{""},{""})
PutSx1(cPerg,"13",OemToAnsi("Opcão do Relatório:")    ,"","","mv_ch13","C",01,0,0,"C","","   "   ,"","","mv_par13","Posição Atual","","","","Posição Gravada","","","","","","","","","","","",{"Posição Atual da Base, ou Base Gravada no faturamento (se já ocorreu)."},{},{})


//PlsVldPerg( aRegs )
Return                     

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ BSCBLOQ  ³ Autor ³ Renato Peixoto        ³ Data ³ 05/10/10 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Trata quando o usuário já foi bloqueado no AAG em alguma   ³±±
±±³          ³ data. Se o desbloqueio ocorreu após a data até do          ³±±
±±³          ³ parâmetro, o registro não é para ser considerado.          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ CriaSX1()                                                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function BSCBLOQ(cRDA,cProduto,cEmpresa)

Local cQuery3  := ""
Local cArqQry3 := GetNextAlias()
Local cQuery4  := ""
Local cArqQry4 := GetNextAlias()
Local nQtdBlo  := 0  
Local lDesblOK := .T.


			
cQuery3 := "SELECT bf4_ynupre nupre, bf4_codpro, bf4_datbas, bf4_datblo, bf4_motblo, ba1_matvid, "+c_ent
cQuery3 += "ba1_codint,ba1_codemp,ba1_matric,ba1_tipreg,ba1_digito,ba1_nomusr, ba1_datblo, BA3_CODPLA, BI3_DESCRI, "+c_ent
cQuery3 += "PA6_CODINT, PA6_CODNUP, PA6_NOMNUP, PA6_CODRDA, PA6_DESRDA, PA6_VALIND, PA6_DTINI "+c_ent
cQuery3 += "FROM   "+RetSqlName("BF4")+" BF4, "+RetSqlName("BA1")+" BA1, "+RetSqlName("BA3")+" BA3, "+RetSqlName("BI3")+" BI3, "+RetSqlName("PA6")+" PA6 "+c_ent
cQuery3 += "WHERE  bf4.bf4_filial = '  ' AND ba1.ba1_filial = '  ' AND BA3.BA3_FILIAL = '  '    AND BI3.BI3_FILIAL = '  '    AND PA6.PA6_FILIAL = '  ' "+c_ent
cQuery3 += "	   AND    bf4.bf4_codpro = '"+cProjeto+"' "+c_ent
cQuery3 += "    AND BA1.BA1_CODINT BETWEEN '"+cOperIni+"' AND '"+cOperFin+"' "+c_ent
cQuery3 += "    AND PA6.PA6_CODINT BETWEEN '"+cOperIni+"' AND '"+cOperFin+"' "+c_ent
cQuery3 += "    AND PA6.PA6_CODLOC BETWEEN '"+cLocalDe+"' AND '"+cLocalAte+"' "+c_ent

cQuery3 += "	AND PA6.PA6_CODRDA = '"+cRDA+"' "+c_ent
cQuery3 += "	AND BA1.BA1_CODEMP = '"+cEmpresa+"' AND BA3.BA3_CODPLA = '"+cProduto+"' "+c_ent
/*If cCodRDAIni < cCodRDAFim
	cQuery3 += "    AND PA6.PA6_CODRDA BETWEEN '"+cCodRdaIni+"' AND '"+cCodRDAFim+"' "+c_ent
Else
	cQuery3 += "    AND PA6.PA6_CODRDA BETWEEN '"+cCodRDAFim+"' AND '"+cCodRDAIni+"' "+c_ent
EndIf*/
//cQuery3 += "	AND    BF4.BF4_MOTBLO <> ' ' --(Trim(BF4.BF4_MOTBLO) IS NULL)
//--AND    BA1.BA1_DATBLO = ' '

cQuery3 += "    AND    ba1.ba1_filial = bf4.bf4_filial "+c_ent
cQuery3 += "    AND    ba1.ba1_codint = bf4.bf4_codint "+c_ent
cQuery3 += "    AND    ba1.ba1_codemp = bf4.bf4_codemp "+c_ent
cQuery3 += "	   AND    ba1.ba1_matric = bf4.bf4_matric "+c_ent
cQuery3 += "    AND    ba1.ba1_tipreg = bf4.bf4_tipreg "+c_ent
cQuery3 += "    AND BF4.BF4_CODINT = BA3.BA3_CODINT "+c_ent
cQuery3 += "    AND BF4.BF4_CODEMP = BA3.BA3_CODEMP "+c_ent
cQuery3 += "    AND BF4.BF4_MATRIC = BA3.BA3_MATRIC "+c_ent
cQuery3 += "    AND BA3.BA3_CODPLA = BI3.BI3_CODIGO "+c_ent
cQuery3 += "    AND BF4.BF4_YNUPRE = PA6.PA6_CODNUP "+c_ent
cQuery3 += "    AND PA6.PA6_DTBLOQ = ' ' "+c_ent
cQuery3 += "    AND    '"+DTOS(dDataFim)+"' BETWEEN bf4.bf4_datbas AND Nvl(Trim(bf4_datblo),'"+DTOS(dDataFim)+"') "+c_ent
cQuery3 += "    AND    '"+DTOS(dDataFim)+"' BETWEEN ba1.ba1_datinc AND Nvl(Trim(ba1_datblo),'"+DTOS(dDataFim)+"') "+c_ent
//cQuery += "    AND    To_Char(SYSDATE,'yyyymmdd') BETWEEN bf4.bf4_datbas AND Nvl(Trim(bf4_datblo),To_Char(SYSDATE,'yyyymmdd')) "+c_ent
//cQuery += "    AND    To_Char(SYSDATE,'yyyymmdd') BETWEEN ba1.ba1_datinc AND Nvl(Trim(ba1_datblo),To_Char(SYSDATE,'yyyymmdd')) "+c_ent 
//cQuery += "	   AND (bf4.bf4_datbas < '"+DTOS(dDataFim)+"' AND ((Trim(bf4.bf4_datblo) IS NULL) OR bf4.bf4_datblo > '"+DTOS(dDataFim)+"') )  "+c_ent 
//cQuery += "    AND (ba1.ba1_datinc < '"+DTOS(dDataFim)+"' AND ((Trim(ba1.ba1_datblo) IS NULL) OR ba1.ba1_datblo > '"+DTOS(dDataFim)+"') )  "+c_ent
cQuery3 += "    AND    bf4.d_e_l_e_t_ = ' ' "+c_ent
cQuery3 += "    AND    ba1.d_e_l_e_t_ = ' ' "+c_ent
cQuery3 += "    AND    BA3.D_E_L_E_T_ = ' ' "+c_ent
cQuery3 += "    AND    BI3.D_E_L_E_T_ = ' ' "+c_ent
cQuery3 += "    AND    PA6.D_E_L_E_T_ = ' ' "+c_ent

//If nOrdSel = 1
cQuery3 += "    ORDER  BY BF4.BF4_YNUPRE, BF4_CODEMP, BA3_CODPLA "
//Else
//	cQuery += "    ORDER  BY BF4.BF4_YNUPRE, BA3_CODPLA, BF4_CODEMP "
//EndIf	
	
If Select(cArqQry3)>0
	(cArqQry3)->(DbCloseArea())
EndIf

*--------------------------------------------*
*** Cria o alias executando a query
*--------------------------------------------*
DbUseArea(.T.,"TopConn",TcGenQry(,,cQuery3),cArqQry3,.F.,.T.)	
	

//Trata quando o usuário já foi bloqueado no AAG em alguma data. Se o desbloqueio ocorreu após a data até do parâmetro, o registro não é para ser considerado.
//Renato Peixoto em 29/09/10
(cArqQry3)->(DbGoTop())

While !((cArqQry3)->(Eof()))
	lDesblOK := .T.
	If !Empty((cArqQry3)->BF4_MOTBLO )

		cQuery4 := "SELECT BGU_MATRIC, BGU_TIPO, BGU_DATA, BGU_MOTBLO, BGU_CODPRO "+c_ent
    	cQuery4 += "FROM "+RetSqlName("BGU")+" BGU "+c_ent	
		cQuery4 += "WHERE BGU_FILIAL = '"+XFILIAL("BGU")+"' "+c_ent
		cQuery4 += "AND BGU_MATRIC = '"+(cArqQry3)->BA1_CODINT+(cArqQry3)->BA1_CODEMP+(cArqQry3)->BA1_MATRIC+"' "+c_ent
		cQuery4 += "AND BGU_CODPRO = '"+(cArqQry3)->BF4_CODPRO+"' "+c_ent
		cQuery4 += "AND BGU_TIPREG = '"+(cArqQry3)->BA1_TIPREG+"' "+c_ent
		cQuery4 += "AND BGU.D_E_L_E_T_ = ' ' "+c_ent
		cQuery4 += "ORDER BY BGU_DATA, BGU_TIPO " //BGU_TIPO acrescentado por Renato Peixoto em 30/03/11, pois certas vezes ocorre bloqueio e desbloqueio no mesmo dia.

    	If Select(cArqQry4) > 0
			(cArqQry4)->(DbCloseArea())
		EndIf
		*--------------------------------------------*
		*** Cria o alias executando a query
		*--------------------------------------------*
		DbUseArea(.T.,"TopConn",TcGenQry(,,cQuery4),cArqQry4,.F.,.T.)
		
    		//DbSelectArea("BGU")
    		//DbSetOrder(1)
    		//If DbSeek(XFILIAL("BGU")+(cArqQry)->BA1_CODINT+(cArqQry)->BA1_CODEMP+(cArqQry)->BA1_MATRIC+(cArqQry)->BF4_CODPRO)
    			//While !(BGU->(Eof())) .AND. AllTrim(BGU->BGU_MATRIC) == AllTrim((cArqQry)->BA1_CODINT)+AllTrim((cArqQry)->BA1_CODEMP)+AllTrim((cArqQry)->BA1_MATRIC)
    	While !((cArqQry4)->(Eof())) .AND. AllTrim((cArqQry4)->BGU_MATRIC) == AllTrim((cArqQry3)->BA1_CODINT)+AllTrim((cArqQry3)->BA1_CODEMP)+AllTrim((cArqQry3)->BA1_MATRIC)	
    		If (cArqQry4)->BGU_TIPO = "0" 
    			If STOD((cArqQry4)->BGU_DATA) < dDataIni 
    				lDesblOK := .F.
    				(cArqQry4)->(DbSkip())
    				Loop
    			Else
    				If STOD((cArqQry4)->BGU_DATA) < dDataFim
    					lDesblOK := .T.
    					Exit
    				Else
    					lDesblOK := .T.
    				EndIf
    			EndIf  
    		Else
    			If STOD((cArqQry4)->BGU_DATA) > dDataFim
    				lDesblOK := .F.
    			Else
    				If STOD((cArqQry4)->BGU_DATA) >= dDataIni .AND. STOD((cArqQry4)->BGU_DATA) <= dDataFim
    					lDesblOK := .T.
    					Exit
    				Else
    					lDesblOk := .T.
    				EndIf
    			EndIf
    		EndIf
    		(cArqQry4)->(DbSkip())
    	EndDo
    	(cArqQry4)->(DbCloseArea())
    EndIf
    
    If !lDesblOK 
    	//aAdd ( aBloq, { (cArqQry)->NUPRE, (cArqQry)->PA6_CODRDA,AllTrim((cArqQry)->BA1_CODINT)+AllTrim((cArqQry)->BA1_CODEMP)+AllTrim((cArqQry)->BA1_MATRIC), (cArqQry)->BA1_NOMUSR } )
    	nQtdBlo++
    	(cArqQry3)->(DbSkip())
    	Loop
    EndIf
	(cArqQry3)->(DbSkip())
EndDo
(cArqQry3)->(DbCloseArea())

Return(nQtdBlo)