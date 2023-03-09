#INCLUDE "PROTHEUS.CH"
#Include "TOPCONN.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABR152   º Autor ³Altamiro              º Data ³ 26/09/14  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Rotina para Listar Parcelamentos em aberto                 º±±
±±º          ³ Parcelas pagas e nao pagas                                 º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/


User Function CABR152
	
	Local cMsg			:= ""
	Private lAbortPrint :=.F.
	Private cPerg       := "CABR152"
	Private cTitulo     := "Listagem de Parcelamentos em aberto , Parcelas pagas (identificando o titulos) e nao pagas (identificando os debitos)"
	
	Private cAliastmp 	:= GetNextAlias()
	
	//SetPrvt("oDlg1","oGrp1","oSay1","oSBtn1","oSBtn2","oSBtn3")
	
	cMsg += " Este programa lista Parcelamentos em aberto , Parcelas pagas (identificando o titulos) e nao pagas (identificando os debitos)  "
	
	***************************************************************************
	
	Private  aDados1     := {}
	Private  acabec1     :={"COD.CLIENTE" ,"IDENT. CLIENTE" ,"NOME CLIENTE","CODIGO PARCEL " , "MES BASE", "ANO BASE", "VLR PARCEL" , "VLR TIT PARCEL", "SALDO TIT PARCEL" ,;
		"PREF TIT PARCEL" , "NUM TIT PARCEL"  , "PARCELA TIT PARCEL" ,"TIPO TIT PARCEL", "EMISSAO TIT PARCEL","BAIXA TIT PARCEL" ,"VLR TIT FIN" ,;
		"SALDO TIT FIN" ,"PREF TIT FIN" , "NUM2 TIT FIN" , "PARCELA TIT FIN" ,"TIPO TIT FIN" ,"EMISSAO TIT FIN" ,"BAIXA TIT FIN", "FORMA DE COBRANÇA",  ;
		"GRUPOPLANO","IDADE","PROJETOS","INTERNADO","SINISTR_12","SINISTR_24","Mot Bloq"}
	
	private Descric := ' '
	
	
	AjustaSX1(cPerg)
	
	Pergunte(cPerg,.T.)
	
	cClientDe    := mv_par01
	cClientAte   := mv_par02
	cEmprDe      := mv_par03
	cEmprAte     := mv_par04
	cMatricDe    := mv_par05
	cMatricAte   := mv_par06
	nGeraEx	     := mv_par07
	nOrder       := mv_par08
	nListar      := mv_par09
	
	
	Processa({||Processa1()}, cTitulo, "", .T.)
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Libera impressao                                                         ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	// faz ecxel
	if nGeraEx == 1
		DlgToExcel({{"ARRAY","Listagem de Parcelamentos em aberto  , Parcelas pagas (identificando o titulos) e nao pagas (identificando os debitos)  " ,aCabec1,aDados1}})
	EndIf
	
	fGeraRel()
	
	
	MsgInfo("Processo finalizado")
	
Return

**************************************************************************

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFun‡„o    ³ PROCESSA1º Autor ³ Jean Schulz        º Data ³  11/11/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescri‡„o ³ Funcao auxiliar chamada pela PROCESSA.  A funcao PROCESSA  º±±
±±º          ³ monta a janela com a regua de processamento.               º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Programa principal                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function Processa1()
	
	ProcRegua(FT_FLASTREC())
	
	nCont := 0
	IncProc('Processando...')
	//////////////////////
	
	cquery := CRLF+               "  SELECT  DISTINCT RETORNA_GRUPO_PLANO_MS('C',BA3_CODINT,BA3_CODEMP,BA3_MATRIC,'00') GRUPOPLANO,   "
	cquery += CRLF+               "  (SELECT BA1_motblo FROM BA1010 WHERE BA1_FILIAL = ' ' AND BA1_CODEMP = BA3_CODEMP AND BA1_MATRIC = BA3_MATRIC AND BA1_TIPUSU = 'T' AND D_E_L_E_T_ = ' ') motblo ,  "
	cquery += CRLF+               "  IDADE_S((SELECT BA1_DATNAS FROM BA1010 WHERE BA1_FILIAL = ' ' AND BA1_CODEMP = BA3_CODEMP AND BA1_MATRIC = BA3_MATRIC AND BA1_TIPUSU = 'T' AND D_E_L_E_T_ = ' ')) IDADE,  "
	cquery += CRLF+               "  NVL(PLS_LISTA_PROJ_ATIVO(BA3_FILIAL,BA3_CODINT,BA3_CODEMP,BA3_MATRIC,'00','0',TRUNC(sysdate)),' ' ) PROJETOS,  "
	cquery += CRLF+               "  DECODE(VERIFICA_ASSOC_INTERNADO(BA3_CODINT,BA3_CODEMP,BA3_MATRIC,'00',TO_CHAR(SYSDATE,'YYYYMM')),0,'NAO','SIM') INTERNADO,   "
	cquery += CRLF+               "  SIGA.RETORNA_SINISTRAL_FAM_MS_CAB('C','S',BA3_CODINT,BA3_CODEMP,BA3_MATRIC,TRUNC(ADD_MONTHS(SYSDATE,-13),'MM'),TRUNC(ADD_MONTHS(sysdate,-1),'MM')) SINISTR_12, "
	cquery += CRLF+               "  SIGA.RETORNA_SINISTRAL_FAM_MS_CAB('C','S',BA3_CODINT,BA3_CODEMP,BA3_MATRIC,TRUNC(ADD_MONTHS(sysdate,-25),'MM'),TRUNC(ADD_MONTHS(sysdate,-1),'MM')) SINISTR_24, "
	
	cquery += CRLF+               "  ZG_CLIENTE , ZG_CODINT || ZG_CODEMP || ZG_MATRIC IDMAT , ZG_NOME NOME ,  "
	
	cquery += CRLF+               "  ZH_CODIGO , ZH_MESBASE, ZH_ANOBASE, ZH_VALOR , "
	
	cquery += CRLF+               "  NVL(SE1.E1_VALOR, 0) E1_VALOR1 , "
	cquery += CRLF+               "  NVL(SE1.E1_SALDO, 0) E1_SALDO1 , "
	cquery += CRLF+               "  NVL(SE1.E1_PREFIXO,' ' )E1_PREFIX1 , "
	cquery += CRLF+               "  NVL(SE1.E1_NUM, '0') E1_NUM1 , "
	cquery += CRLF+               "  NVL(SE1.E1_PARCELA, ' ' ) E1_PARCELA1 , "
	cquery += CRLF+               "  NVL(SE1.E1_TIPO, ' ') E1_TIPO1 , "
	cquery += CRLF+               "  NVL(SE1.E1_EMISSAO , ' ') E1_EMISSAO1 , "
	cquery += CRLF+               "  NVL(SE1.E1_BAIXA  , ' ')  E1_BAIXA1 , "
	
	cquery += CRLF+               "  NVL(SE11.E1_VALOR, 0) E1_VALOR2 , "
	cquery += CRLF+               "  NVL(SE11.E1_SALDO, 0) E1_SALDO2 , "
	cquery += CRLF+               "  NVL(SE11.E1_PREFIXO,' ' )E1_PREFIX2 , "
	cquery += CRLF+               "  NVL(SE11.E1_NUM, '0') E1_NUM2 , "
	cquery += CRLF+               "  NVL(SE11.E1_PARCELA, ' ' ) E1_PARCELA2 , "
	cquery += CRLF+               "  NVL(SE11.E1_TIPO, ' ') E1_TIPO2 , "
	cquery += CRLF+               "  NVL(SE11.E1_EMISSAO , ' ') E1_EMISSAO2 , "
	cquery += CRLF+               "  NVL(SE11.E1_BAIXA  , ' ')  E1_BAIXA2 ,   "
	
	cquery += CRLF+ " CASE nvl(ba3_tippag ,'00') WHEN '01' THEN '01 - Mater Aposentado' "
	cquery += CRLF+ " WHEN '08' THEN '08 - Mater Aposentado Vinc' WHEN '02' THEN '02 - Banco Liq ' "
	cquery += CRLF+ " WHEN '03' THEN '03 - Mater Empresa '  WHEN '04' THEN '04 - Boleto 112'"
	cquery += CRLF+ " WHEN '05' THEN '05 - Boleto 175 ' WHEN '06' THEN '06 - SisDeb '	 WHEN '07' THEN '07 - Emp. Itau '"
	cquery += CRLF+ " WHEN '00' THEN '00 - Não Cobrando ' ELSE ba3_tippag ||' - Não especf' END tpcobcad  "
	
	cquery += CRLF+  " FROM  "+ RetSqlName("SZH") +" SZH "
	
	cquery += CRLF+  " LEFT JOIN "+ RetSqlName("BSQ") +" BSQ ON BSQ.BSQ_FILIAL = '"+xFilial("BSQ")+ "' "
	cquery += CRLF+  "  AND BSQ.D_E_L_E_T_ = ' '    AND BSQ.BSQ_PREORI = ZH_PREFIXO "
	cquery += CRLF+  "  AND BSQ.BSQ_NUMORI = ZH_NUM AND BSQ.BSQ_PARORI = ZH_PARCELA AND BSQ.BSQ_TIPORI = ZH_TIPO "
	
	cquery += CRLF+  " LEFT JOIN "+ RetSqlName("SE1") +" SE1 ON SE1.E1_FILIAL = '"+xFilial("SE1")+ "' "
	cquery += CRLF+  "  AND SE1.D_E_L_E_T_ = ' '        AND BSQ.BSQ_PREORI = SE1.E1_PREFIXO "
	cquery += CRLF+  "  AND BSQ.BSQ_NUMORI = se1.E1_NUM AND BSQ.BSQ_PARORI = SE1.E1_PARCELA AND BSQ.BSQ_TIPORI = se1.E1_TIPO "
	
	cquery += CRLF+  " LEFT JOIN "+ RetSqlName("SZG") +" SZG ON SZG.ZG_FILIAL = '"+xFilial("SZG")+ "' "
	cquery += CRLF+  "  AND ZG_STATUS = 'C'   AND zg_codigo = zh_codigo  AND SZG.D_E_L_E_T_ = ' '  "
	
	cquery += CRLF+  " LEFT JOIN "+ RetSqlName("BA3") +" BA3 ON BA3.BA3_FILIAL = '"+xFilial("BA3")+ "' "
	cquery += CRLF+  "  AND BA3_CODINT = ZG_CODINT AND BA3_CODEMP = ZG_CODEMP AND BA3_MATRIC = ZG_MATRIC AND BA3.D_E_L_E_T_ = ' '"
	
	cquery += CRLF+  " LEFT JOIN "+ RetSqlName("BSQ") +" BSQ1 ON BSQ1.BSQ_FILIAL = '"+xFilial("BSQ")+ "' "
	cquery += CRLF+  "  AND BSQ1.D_E_L_E_T_ = ' ' AND BSQ1.BSQ_CODINT = ZG_CODINT  AND BSQ1.BSQ_CODEMP = ZG_CODEMP "
	cquery += CRLF+  "  AND BSQ1.BSQ_MATRIC = ZG_MATRIC  AND BSQ1.BSQ_ANO = ZH_ANOBASE AND BSQ1.BSQ_MES = ZH_MESBASE AND BSQ1.BSQ_CODLAN = '991' "
	
	cquery += CRLF+  " LEFT JOIN "+ RetSqlName("SE1") +" SE11 ON SE11.E1_FILIAL = '"+xFilial("SE1")+ "' "
	
	//-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	// Angelo Henrique - Data: 01/10/2019
	//-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	cquery += CRLF+  "  AND SE11.D_E_L_E_T_ = ' ' AND SE11.E1_CODINT = BSQ1.BSQ_CODINT "
	//cquery += CRLF+  "  AND SE11.D_E_L_E_T_ = ' ' AND SE11.E1_PLNUCOB = BSQ1.BSQ_NUMCOB AND SE11.E1_CODINT = BSQ1.BSQ_CODINT "
	//-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	cquery += CRLF+  "  AND SE11.E1_CODEMP = BSQ1.BSQ_CODEMP  AND SE11.E1_MATRIC = BSQ1.BSQ_MATRIC "
	
	cquery += CRLF+  "  AND SE11.E1_PREFIXO = BSQ1.BSQ_PREFIX  AND SE11.E1_NUM = BSQ1.BSQ_NUMTIT   "
	cquery += CRLF+  "  AND SE11.E1_PARCELA = BSQ1.BSQ_PARCEL  AND SE11.E1_TIPO = BSQ1.BSQ_TIPTIT  "
	
	cquery += CRLF+  "WHERE SZH.ZH_FILIAL = '"+xFilial("SZH")+ "' AND SZH.D_E_L_E_T_ = ' ' AND SZH.ZH_NEGTIPO = 'S' "
	cquery += CRLF+  "  AND ZH_CODIGO IN ( SELECT ZG_CODIGO FROM "+ RetSqlName("SZG")  + " SZG , " + RetSqlName("BA3")+ " BA3"
	cquery += CRLF+                       " WHERE SZG.D_E_L_E_T_ = ' ' AND BA3.D_E_L_E_T_ = ' '  "
	
	If !empty(cClientAte)
		cquery += CRLF+                       "  AND ZG_CLIENTE >= '"+cClientDe+"'  AND ZG_CLIENTE <= '"+cClientAte+"' "
	EndIf
	If !empty(cEmprAte)
		cquery += CRLF+                       "  AND ZG_CODEMP  >= '"+cEmprDe+"'    AND ZG_CODEMP  <= '"+cEmprAte+"'"
	EndIf
	If !empty(cMatricAte)
		cquery += CRLF+                       "  AND ZG_MATRIC  >= '"+cMatricDe+"'  AND ZG_MATRIC  <= '"+cMatricAte +"' "
	EndIf
	cquery += CRLF+                       "  AND BA3_CODINT = ZG_CODINT AND BA3_CODEMP = ZG_CODEMP AND BA3_MATRIC = ZG_MATRIC "
	if nListar != 3
		cquery += CRLF+                       "  AND BA3_MOTBLO "
		if nListar = 1
			cquery += CRLF+                 "   NOT "
		EndIf
		cquery += CRLF+                    " IN (SELECT BG1_CODBLO FROM  BG1010 BG1 WHERE  BG1_FILIAL = ' ' AND BG1.D_E_L_E_T_ = ' ' AND BG1_BLOFAT = '1') "
	EndIf
	cquery += CRLF+                       "  AND  ZG_CODIGO IN  ( SELECT  SZH.ZH_CODIGO "
	cquery += CRLF+                                              "  FROM  "+ RetSqlName("SZH") +" SZH "
	cquery += CRLF+                                              "  LEFT JOIN  "+ RetSqlName("BSQ") +" BSQ ON BSQ.BSQ_FILIAL = '"+xFilial("BSQ")+ "' "
	cquery += CRLF+                                              "   AND BSQ.D_E_L_E_T_ = ' ' AND BSQ.BSQ_PREORI = ZH_PREFIXO AND BSQ.BSQ_NUMORI = ZH_NUM "
	cquery += CRLF+                                              "   AND BSQ.BSQ_PARORI = ZH_PARCELA AND BSQ.BSQ_TIPORI = ZH_TIPO "
	
	cquery += CRLF+                                              "  LEFT JOIN "+ RetSqlName("SE1") +" SE1 ON SE1.E1_FILIAL = '"+xFilial("SE1")+ "' "
	cquery += CRLF+                                              "   AND SE1.D_E_L_E_T_ = ' '  AND BSQ.BSQ_PREORI = SE1.E1_PREFIXO AND BSQ.BSQ_NUMORI = se1.E1_NUM "
	cquery += CRLF+                                              "   AND BSQ.BSQ_PARORI = SE1.E1_PARCELA AND BSQ.BSQ_TIPORI = SE1.E1_TIPO "
	
	cquery += CRLF+                                              "  LEFT JOIN "+ RetSqlName("SZG") +" SZG ON SZG.ZG_FILIAL = '"+xFilial("SZG")+ "' "
	cquery += CRLF+                                              "  AND ZG_CODIGO = ZH_CODIGO  AND ZG_STATUS = 'C' AND SZG.D_E_L_E_T_ = ' ' "
	
	cquery += CRLF+                                              "  LEFT JOIN "+ RetSqlName("BA3") +" BA3 ON BA3.BA3_FILIAL = '"+xFilial("BA3")+ "' "
	cquery += CRLF+                                              "   AND BA3.BA3_CODINT = ZG_CODINT AND BA3.BA3_CODEMP = ZG_CODEMP "
	cquery += CRLF+                                              "   AND BA3.BA3_MATRIC = ZG_MATRIC AND BA3.D_E_L_E_T_ = ' ' "
	
	cquery += CRLF+                                              "  LEFT JOIN  "+ RetSqlName("BSQ") +" BSQ1 ON BSQ1.BSQ_FILIAL = '"+xFilial("BSQ")+ "' "
	cquery += CRLF+                                              "   AND BSQ1.D_E_L_E_T_ = ' ' AND BSQ1.BSQ_CODINT = ZG_CODINT "
	cquery += CRLF+                                              "   AND BSQ1.BSQ_CODEMP = ZG_CODEMP AND BSQ1.BSQ_MATRIC = ZG_MATRIC "
	cquery += CRLF+                                              "   AND ZH_PREFIXO = BSQ1.BSQ_PREORI AND ZH_NUM  = BSQ1.BSQ_NUMORI "
	cquery += CRLF+                                              "   AND ZH_PARCELA = BSQ1.BSQ_PARORI AND ZH_TIPO = BSQ1.BSQ_TIPORI AND BSQ1.BSQ_CODLAN = '991' "
	/*cquery += CRLF+                                              "   AND ZH_PREFIXO = BSQ1.BSQ_PREFIX AND ZH_NUM  = BSQ1.BSQ_NUMTIT "
	cquery += CRLF+                                              "   AND ZH_PARCELA = BSQ1.BSQ_PARCEL AND ZH_TIPO = BSQ1.BSQ_TIPTIT AND BSQ1.BSQ_CODLAN = '991' "
	*/
	cquery += CRLF+                                              "  LEFT JOIN "+ RetSqlName("SE1") +" SE11 ON SE11.E1_FILIAL = '"+xFilial("SE1")+ "' "
	
	//-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	// Angelo Henrique - Data: 01/10/2019
	//-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	cquery += CRLF+                                              "   AND SE11.D_E_L_E_T_ = ' ' AND SE11.E1_CODINT = BSQ1.BSQ_CODINT "	
	//cquery += CRLF+                                              "   AND SE11.D_E_L_E_T_ = ' ' AND SE11.E1_PLNUCOB = BSQ1.BSQ_NUMCOB AND SE11.E1_CODINT = BSQ1.BSQ_CODINT "
	//-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	
	cquery += CRLF+                                              "   AND SE11.E1_CODEMP = BSQ1.BSQ_CODEMP AND SE11.E1_MATRIC = BSQ1.BSQ_MATRIC AND SE11.E1_PREFIXO = BSQ1.BSQ_PREFIX "
	cquery += CRLF+                                              "   AND SE11.E1_NUM = BSQ1.BSQ_NUMTIT AND SE11.E1_PARCELA = BSQ1.BSQ_PARCEL AND SE11.E1_TIPO = BSQ1.BSQ_TIPTIT "
	
	cquery += CRLF+                                              " WHERE ZH_FILIAL  = '"+xFilial("SZH")+"' AND SZH.D_E_L_E_T_ = ' ' AND ZH_NEGTIPO = 'S'  "
	cquery += CRLF+                                              "   AND (NVL(SE1.E1_SALDO, 0) > 0 OR   NVL(SE11.E1_SALDO, 0) > 0 ) "
	cquery += CRLF+                                              " GROUP BY ZH_CODIGO "
	cquery += CRLF+                                           " ) "
	cquery += CRLF+                  "  ) "
	if nOrder == 1
		cquery += CRLF+ "  ORDER BY ZH_CODIGO ,E1_PREFIX1 , E1_NUM1 ,E1_PARCELA1 ,E1_TIPO1,E1_PREFIX2 , E1_NUM2 ,E1_PARCELA2 ,E1_TIPO2 "
	Else
		cquery += CRLF+ "  ORDER BY ZH_CODIGO ,E1_PREFIX2 , E1_NUM2 ,E1_PARCELA2 ,E1_TIPO2,E1_PREFIX1 , E1_NUM1 ,E1_PARCELA1 ,E1_TIPO1 "
	EndIf
	
	/////////////////////////////////////////*
	
	If Select((cAliastmp)) <> 0
		(cAliastmp)->(DbCloseArea())
	Endif
	
	TCQuery cQuery New Alias (cAliastmp)
	
	dbSelectArea(cAliastmp)
	
	(cAliastmp)->(dbGoTop())
	
	While (cAliastmp)->(!Eof())
		
		aaDD(aDados1,{(cAliastmp)->ZG_CLIENTE ,;
			(cAliastmp)->IDMAT     ,;
			(cAliastmp)->NOME      ,;
			(cAliastmp)->ZH_CODIGO ,;
			(cAliastmp)->ZH_MESBASE,;
			(cAliastmp)->ZH_ANOBASE,;
			(cAliastmp)->ZH_VALOR  ,;
			(cAliastmp)->E1_VALOR1 ,;
			(cAliastmp)->E1_SALDO1 ,;
			(cAliastmp)->E1_PREFIX1,;
			(cAliastmp)->E1_NUM1   ,;
			(cAliastmp)->E1_PARCELA1 ,;
			(cAliastmp)->E1_TIPO1  ,;
			stod((cAliastmp)->E1_EMISSAO1) ,;
			stod((cAliastmp)->E1_BAIXA1)   ,;
			(cAliastmp)->E1_VALOR2  ,;
			(cAliastmp)->E1_SALDO2  ,;
			(cAliastmp)->E1_PREFIX2 ,;
			(cAliastmp)->E1_NUM2    ,;
			(cAliastmp)->E1_PARCELA2,;
			(cAliastmp)->E1_TIPO2   ,;
			stod((cAliastmp)->E1_EMISSAO2),;
			stod((cAliastmp)->E1_BAIXA2)  ,;
			(cAliastmp)->tpcobcad     ,;
			(cAliastmp)->GRUPOPLANO,;
			(cAliastmp)->IDADE,;
			(cAliastmp)->PROJETOS,;
			(cAliastmp)->INTERNADO,;
			(cAliastmp)->SINISTR_12, ;
			(cAliastmp)->SINISTR_24 ,;
			(cAliastmp)->MOTBLO })
		(cAliastmp)->(dbSkip())
	EndDo
Return

*************************************************************************************************************
Static Function fGeraRel
	
	Local oReport
	Private cPerg		:= "CABR152"
	Private aOrdem 		:= {}//{'RDA','Ano/Mes'}
	
	
	
	oReport:= ReportDef()
	oReport:PrintDialog()
	
Return

*************************************************************************************************************

********************************************************************************************************************************

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³ Leonardo Portella                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpO1: Objeto do relatorio                                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function ReportDef()
	
	Local oReport
	Local oDPJ
	oReport	:= TReport():New("CABR152","Listagem de Parcelamentos em aberto , Parcelas pagas (identificando o titulos) e nao pagas (identificando os debitos) ",, {|oReport| ReportPrt(oReport)},"Listagem de Parcelamentos em aberto , Parcelas pagas (identificando o titulos) e nao pagas (identificando os debitos)")
	oReport:SetTotalInLine(.F.)//Imprime na linha: .F. - Imprime abaixo da linha com o titulo de cada coluna: .T.
	//oReport:SetTotalText('Total Geral')
	
	*'-----------------------------------------------------------------------------------'*
	*'Solucao para impressao em que as colunas se truncam: "SetColSpace" e "SetLandScape"'*
	*'-----------------------------------------------------------------------------------'*
	
	oReport:SetColSpace(1) //Espacamento entre colunas.
	oReport:SetLandscape() //Impressao em paisagem.
	//oReport:SetPortrait() //Impressao em retrato.
	
	oDPJ := TRSection():New(oReport,"Listagem de Parcelamentos em aberto , Parcelas pagas (identificando o titulos) e nao pagas (identificando os debitos)",,aOrdem)
	
	TRCell():New(oDPJ ,'CCLIENTE'       		,/*TABELA*/	,'Cod. Cliente'    ,/*Picture*/   		,06				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
	TRCell():New(oDPJ ,'ICLIENTE'       		,/*TABELA*/	,'Ident. Cliente'  ,/*Picture*/ 	    ,50				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
	TRCell():New(oDPJ ,'CPARCEL'	     		,/*TABELA*/	,'Cod.Parcel'      ,/*Picture*/ 	    ,10				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
	TRCell():New(oDPJ ,'MOTBLO'	     		,/*TABELA*/	,'Mot.Bloq'      ,/*Picture*/ 	        ,03				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
	
	TRCell():New(oDPJ ,'MESANOP'	     	    ,/*TABELA*/	,'M/A Parcel'      ,/*Picture*/ 	    ,07				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
	TRCell():New(oDPJ ,'VPARCEL'				,/*TABELA*/	,'Valor Parcel. '  ,"@E 9,999,999.99"  	,13			 	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"		)
	
	TRCell():New(oDPJ ,'TITPROV'	     		,/*TABELA*/	,'Tit. Provis'	   ,/*Picture*/ 	    ,16				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
	TRCell():New(oDPJ ,'EMISPROV'	     	,/*TABELA*/	,'Dt.Emis.Prov.'   ,/*"@E 99:99"	*/  ,10				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
	TRCell():New(oDPJ ,'VSPROV'				,/*TABELA*/	,'Vl Tit. Prov.'   ,"@E 9,999,999.99"  	,13			 	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"		)
	TRCell():New(oDPJ ,'BXPROV'	     		,/*TABELA*/	,'Dt. Bx. Prov.'   ,/*Picture*/ 	    ,10				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
	TRCell():New(oDPJ ,'VBPROV'				,/*TABELA*/	,'Saldo Tit.Prov.' ,"@E 9,999,999.99" 	,13			 	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"		)
	
	TRCell():New(oDPJ ,'TITFIN'	     		,/*TABELA*/	,'Tit. Financ '	   ,/*Picture*/ 	    ,16				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
	TRCell():New(oDPJ ,'EMISFIN'	        	,/*TABELA*/	,'Dt.Emis.Fin.'    ,/*"@E 99:99"	*/  ,10				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
	TRCell():New(oDPJ ,'VSFIN'				,/*TABELA*/	,'Vl Tit. Fin.'    ,"@E 9,999,999.99"  	,13			 	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"		)
	TRCell():New(oDPJ ,'BXFIN'	     		,/*TABELA*/	,'Dt. Bx. Fin.'    ,/*Picture*/ 	    ,10				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
	TRCell():New(oDPJ ,'VBFIN'				,/*TABELA*/	,'Saldo Tit.Fin.'  ,"@E 9,999,999.99"  	,13			 	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"		)
	
	
	oBreak01 		:= TRBreak():New(oDPJ,oDPJ:Cell("CPARCEL"),"Total Parcelamento"	,.F.)
	
	lTotSecBrk01	:= .T.//Indica se totalizador sera impresso na quebra de secao
	lTotFimBrk01	:= .T.//Indica se totalizador sera impresso no final do relatorio - Como o total eh o mesmo, basta que apenas um esteja ativado
	
	
	TRFunction():New(oDPJ:Cell("VSPROV")    	,NIL,"SUM"	    	,oBreak01,,"@E 999,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01)
	TRFunction():New(oDPJ:Cell("VBPROV")    	,NIL,"SUM"	    	,oBreak01,,"@E 999,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01)
	TRFunction():New(oDPJ:Cell("VSFIN")  		,NIL,"SUM"			,oBreak01,,"@E 999,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01)
	TRFunction():New(oDPJ:Cell("VBFIN")  		,NIL,"SUM"			,oBreak01,,"@E 999,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01)
	
Return(oReport)

********************************************************************************************************************************

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrint³ Autor ³ Leonardo Portella                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function ReportPrt(oReport)
	
	Local   cImp    :='Não'
	
	Local i := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
	
	Private oDPJ 	:= oReport:Section(1)
	
	Private nCont	:= 0
	
	nCont := Len(aDados1)
	
	//Se nao tiver esta linha, nao imprime os dados
	oDPJ:init()
	
	oReport:SetMeter(nCont)
	
	cTot	:= AllTrim(Transform(nCont,'@E 999,999,999,999'))
	nCont 	:= 0
	
	For i := 1 To Len(aDados1)
		
		oReport:SetMsgPrint("Imprimindo linha " + AllTrim(Transform(++nCont,'@E 999,999,999,999')) + ' de ' + cTot)
		
		oReport:IncMeter()
		
		If oReport:Cancel()
			
			oReport:FatLine()
			oReport:PrintText('Cancelado pelo operador!!!',,,CLR_RED,,,.T.)
			
			exit
			
		EndIf
		
		oDPJ:Cell('CCLIENTE'):SetValue((aDados1[i][1]))
		oDPJ:Cell('ICLIENTE'):SetValue((aDados1[i][2])+'-'+(aDados1[i][3]))
		oDPJ:Cell('CPARCEL' ):SetValue((aDados1[i][4]))
		oDPJ:Cell('MESANOP' ):SetValue((aDados1[i][5])+"/"+(aDados1[i][6]))
		oDPJ:Cell('VPARCEL' ):SetValue((aDados1[i][7]))
		
		oDPJ:Cell('TITPROV' ):SetValue((aDados1[i][10])+" "+(aDados1[i][11])+" "+(aDados1[i][12])+" "+(aDados1[i][13]))
		oDPJ:Cell('EMISPROV'):SetValue((aDados1[i][14]))
		oDPJ:Cell('VSPROV'  ):SetValue((aDados1[i][8]))
		oDPJ:Cell('BXPROV'  ):SetValue((aDados1[i][15]))
		oDPJ:Cell('VBPROV'  ):SetValue((aDados1[i][9]))
		
		oDPJ:Cell('TITFIN' ):SetValue((aDados1[i][18])+" "+(aDados1[i][19])+" "+(aDados1[i][20])+" "+(aDados1[i][21]))
		oDPJ:Cell('EMISFIN'):SetValue((aDados1[i][22]))
		oDPJ:Cell('VSFIN'  ):SetValue((aDados1[i][16]))
		oDPJ:Cell('BXFIN'  ):SetValue((aDados1[i][23]))
		oDPJ:Cell('VBFIN'  ):SetValue((aDados1[i][17]))
		
		oDPJ:Cell('MOTBLO'  ):SetValue((aDados1[i][31]))
		
		oDPJ:PrintLine()
		
	Next i
	
	oDPJ:Finish()
	
Return

******************************************************************************************

Static Function AjustaSX1(cPerg)
	
	Local aHelpPor := {}
	
	PutSx1(cPerg,"01",OemToAnsi("Cod. Cliente De ") 		,"","","mv_ch1","C",06,0,0,"G","","","","","mv_par01","   ","","","","   ","","","","","","","","","","","",{},{},{})
	PutSx1(cPerg,"02",OemToAnsi("Cod. Cliente Ate") 		,"","","mv_ch2","C",06,0,0,"G","","","","","mv_par02","   ","","","","   ","","","","","","","","","","","",{},{},{})
	PutSx1(cPerg,"03",OemToAnsi("Cod. Empresa De ") 	    ,"","","mv_ch3","C",04,0,0,"G","","","","","mv_par03","   ","","","","   ","","","","","","","","","","","",{},{},{})
	PutSx1(cPerg,"04",OemToAnsi("Cod. Empresa Ate") 		,"","","mv_ch4","C",04,0,0,"G","","","","","mv_par04","   ","","","","   ","","","","","","","","","","","",{},{},{})
	PutSx1(cPerg,"05",OemToAnsi("Cod. Matric. De ") 		,"","","mv_ch5","C",06,0,0,"G","","","","","mv_par05","   ","","","","   ","","","","","","","","","","","",{},{},{})
	PutSx1(cPerg,"06",OemToAnsi("Cod. Matric. Ate")        ,"","","mv_ch6","C",06,0,0,"G","","","","","mv_par06","   ","","","","   ","","","","","","","","","","","",{},{},{})
	
	PutSx1(cPerg,"07",OemToAnsi("Gerar Excel ") 	        ,"","","mv_ch7","N",01,0,0,"C","","","","","mv_par07","Sim","","","","Não","","","","","","","","","","","",{},{},{})
	
	PutSx1(cPerg,"08",OemToAnsi("Ordernar Por ") 	        ,"","","mv_ch08","N",01,0,0,"C","","","","","mv_par08","Tit. Provisorio","","","","Tit. Pls","","","","","","","","","","","",{},{},{})
	
	PutSx1(cPerg,"09",OemToAnsi("Listar ") 	                ,"","","mv_ch09","N",01,0,0,"C","","","","","mv_par09","Ativos" ,"","","","Bloqueados","","","Ambos","","","","","","","","",{},{},{})
	Pergunte(cPerg,.F.)
	
Return
