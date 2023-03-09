#INCLUDE "rwmake.ch"
#INCLUDE "topconn.ch"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ CABR116  º Autor ³ Altamiro Affonso   º Data ³  10/11/09   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Relatorio Controle de conta a receber de deligados         º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP6 IDE                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function CABR117
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Declaracao de Variaveis                                             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	Local cDesc1         := "Este programa tem como objetivo imprimir relatorio"
	Local cDesc2         := "de Usuario que não sofreram reajuste"
	Local cDesc3         := "na competencia especificada"
	Local titulo         := "Conferencia do Reajuste no Mês"
	Local nLin           := 80
	Local Cabec1         := " Identificação           Usuario                                              Forma Pagto           Dt Inclusao  Observações   "
	//                       1234567890123456789012345678901234567890123456789012345678900123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
	//                       0        1         2         3         4         5         6          7         8         9         1         2         3         4         5         6
	//                      BK2_PROPRI||BK2_CODLAN,                                    Sum(BK2_SALDO)
	Local Cabec2         := ""
	Local aOrd           := {}
	Private aUsunfat	 := {}
	Private pSitadv 	 := GetNewPar("MV_XSITADV","004,005,006")
	Private lEnd         := .F.
	Private lAbortPrint  := .F.
	Private CbTxt        := ""
	Private limite       := 220
	Private tamanho      := "G"
	Private nomeprog     := "CABR117"
	Private nTipo        := 15
	Private aReturn      := { "Zebrado", 1, "Administracao", 1, 2, 1, "", 1}
	Private nLastKey     := 0
	Private cbcont       := 00
	Private CONTFL       := 01
	Private m_pag        := 01
	Private wnrel        := "CABR117"
	Private cString      := "bm1"
	Private cPerg        := "CAB117"
	Private valor_tot    := 0.00
	Private valor_col    := 0.00
	Private cquebra      := " "
	Private lflagtot     :=.F.
	private cNovGrpPag   := " "
	private lLista   	 := .F.
	private cnum         := "  "
	private nTottit      := 0.00
	private nTotsal      := 0.00
	private lPVez        := .T.
	private aTitXls      := {"Matricula","Nome do Beneficiário","Forma de Pgto","Data de inclusão","Observações"}

	dbSelectArea("bm1")
	dbSetOrder(1)
	
	ValidPerg(cPerg)
	If Pergunte(cPerg,.T.) = .F.
		Return
	Endif
	Private dIncAt     := dtos(mv_par01)
	Private cCompDe    := mv_par02
	Private cCompAte   := mv_par03
	Private cEmp       := mv_par04
	Private nExcel     := mv_par06
	private cENãoSair  := mv_par07
	private cCNãoSair  := mv_par08
	private cSCNãoSair := mv_par09
	private cTpPag     := 0
	
	Do Case
	Case mv_par05 == 1 // 01 - Mater Aposentado e 08 - Mater Aposentado Vinc
		cTpPag      := "'01', '08'"
	Case mv_par05 == 2 // 02 - Banco Liq
		cTpPag      := "'02'"
	Case mv_par05 == 3 // 03 - Mater Empresa
		cTpPag      := "'03'"
	Case mv_par05 == 4 // 04 - Boleto 112 , 05 - Boleto 175 e SisDeb
		cTpPag      := "'04' , '05' , '06'"
	Case mv_par05 == 5 // 07 - Emp. Itau
		cTpPag      := "'07'"
	EndCase
	
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Monta a interface padrao com o usuario...                           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	wnrel := SetPrint(cString,NomeProg,"",@titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,.F.,Tamanho,,.T.)
	
	If nLastKey == 27
		Return
	Endif
	
	SetDefault(aReturn,cString)
	
	If nLastKey == 27
		Return
	Endif
	
	nTipo := If(aReturn[4]==1,15,18)
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Processamento. RPTSTATUS monta janela com a regua de processamento. ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	RptStatus({|| RunReport(Cabec1,Cabec2,Titulo,nLin) },Titulo)
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFun‡„o    ³RUNREPORT º Autor ³ AP6 IDE            º Data ³  31/08/07   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescri‡„o ³ Funcao auxiliar chamada pela RPTSTATUS. A funcao RPTSTATUS º±±
±±º          ³ monta a janela com a regua de processamento.               º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Programa principal                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function RunReport(Cabec1,Cabec2,Titulo,nLin)
	
	//Local nOrdem
	Local cQuery := ' '
	dbSelectArea(cString)
	dbSetOrder(1)
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ SETREGUA -> Indica quantos registros serao processados para a regua ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	SetRegua(RecCount())
	///
	cQuery := " SELECT FORMATA_MATRICULA_MS(ba1_codint||ba1_codemp||ba1_matric||ba1_tipreg||ba1_digito) matric, trim(ba1_nomusr) ident,"
	cQuery += "  BA1_DATINC , trim(bhh_obs1)||' '||trim(bhh_obs2)||' '||trim(bhh_obs3)||' '||trim(bhh_obs4) obs, "
	cQuery += "  DECODE(ba3_tippag,'01','Mater Aposentado ','02','Banco Liq','08','Mater Aposentado Vinc','03','Mater Empresa','04','Boleto 112','05','Boleto 175','06','SisDeb','07','Emp. Itau','Indefinido') tp_pagto   "
	cQuery += "  from " + RetSqlName('BA1') + "  ba1 ," + RetSqlName('BA3') + " ba3,  (select bhh_codint, bhh_codemp, bhh_matric, bhh_tipreg, bhh_obs1,  bhh_obs2,  bhh_obs3, bhh_obs4                   "
	cQuery += "  from " + RetSqlName('BHH') + " BHH  where bhh_filial = '" + xFilial("BHH") +"'  and bhh.D_E_L_E_T_ = ' 'and bhh_codsad in "+ formatin(pSitadv, "," ) +" ) bhh1 "
	cQuery += "  where ba1_filial = '" + xFilial("BA1") +"' and ba3_filial = '" + xFilial("BA3") +"' and ba1.d_E_L_E_T_ = ' ' and ba3.d_E_L_E_T_ = ' ' "

	If cEmpAnt == "01"
		If !empty(cTpPag) .and.  mv_par05 <> 2
			cQuery += " and ba3_tippag in ("+ cTpPag +") "
		EndIf
		If !empty(cEmp)
			cQuery += " AND ba1_codemp ='"+cEmp+"' "
		Else
			cQuery += " AND ba1_codemp IN ('0001','0002','0005') "
		EndIf
	Else 
		cQuery += " AND ba1_codemp ='"+cEmp+"' "
	EndIf
	
	/* prosegir a avaliação em outro monento  -- altamiro  21/10/2011
	If !empty (cENãoSair)
		cQuery +=" AND (ba1_codemp NOT IN "+FormatIn(cENãoSair, ",")
	EndIF
	If !empty (cCNãoSair)
		cQuery +=" AND BA1_CONEMP NOT IN "+FormatIn(cCNãoSair, ",")
	EndIF
	If !empty (cSCNãoSair)
		cQuery +=" AND BA1_SUBCON NOT IN "+FormatIn(cSCNãoSair, ",")+")"
	EndIF
	*/
	
	if cEmpAnt == "01"
		cQuery += "  AND ba1_codemp||BA1_CONEMP|| BA1_SUBCON NOT IN ('0001000000000001000000010') "
	EndIf
	
	cQuery += "  AND (( BA1_DATBLO = ' ' OR BA1_DATBLO >= '"+substr(dIncAt, 1,6 ) +"01')

	IF  cEmpAnt == '01'
		cQuery += "OR (BA1_MOTBLO   IN ('485') AND BA1_DATBLO        <> ' ') )
	else
		cQuery += "OR (BA1_MOTBLO   IN ('749','765') AND BA1_DATBLO        <> ' ') )
	endif

	cQuery += "AND BA1_DATINC < '"+dIncAt +"' and bhh1.BHH_CODINT (+) = BA1_CODINT AND bhh1.bhh_codemp(+) = ba1_codemp AND bhh1.bhh_matric(+) = ba1_MATRIC AND bhh1.bhh_tipreg (+) = ba1_tipreg           "
	cQuery += "  and ba3_codint = ba1_codint AND ba3_codemp = ba1_codemp AND ba3_matric = ba1_MATRIC and BA3_CONEMP = BA1_CONEMP and BA3_VERCON = BA1_VERCON and BA3_SUBCON = BA1_SUBCON and BA3_VERSUB = BA1_VERSUB  "
	cQuery += "  AND NOT EXISTS ( SELECT 1 FROM " + RetSqlName('BM1') +" WHERE BM1_FILIAL = '" + xFilial("BM1") +"'" "
	cQuery += "  AND D_e_L_e_t_ = ' ' "
	
	If !empty(cCompDe)
		cQuery += " AND bm1_mes between '"+ substr (cCompDe, 5,2) +"' and '"+ substr (cCompAte, 5,2) +"' "
		cQuery += " AND bm1_ano between '"+ Substr (cCompDe,1,4)  +"' and '"+ Substr (cCompAte,1,4)  +"' and bm1_prefix = 'PLS' and bm1_codtip = '101' "
	EndIF
	
	cQuery += " and BM1_CODINT = ba1.BA1_CODINT and ba1_codemp = bm1_codemp and ba1_matric = bm1_matric and ba1_tipreg = bm1_tipreg and BM1_DIGITO = ba1.BA1_DIGITO"  
	cQuery += " and BM1_CONEMP = ba1.BA1_CONEMP and BM1_VERCON = ba1.BA1_VERCON and BM1_SUBCON = ba1.BA1_SUBCON and BM1_VERSUB = ba1.BA1_VERSUB)    "
	cQuery += " ORDER BY FORMATA_MATRICULA_MS(ba1_codint||ba1_codemp||ba1_matric||ba1_tipreg||ba1_digito)"

	MemoWrite("C:\temp\CABR117.sql",cQuery)
	tmp := GetNextAlias()
	dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),tmp,.T.,.f.)
	
	titulo += "," + substr (dIncAt,7,2)+"/"+substr (dIncAt,5,2)+"/"+substr (dIncAt,1,4)
	If !empty(cCompDe) 
		if cCompDe = CcompAte
			titulo += ", para a competencia " + substr (cCompDe, 5,2)+"/"+ substr (cCompDe,1,4)
		else
			titulo += ", para a competencia de " + substr (cCompDe, 5,2)+"/"+ substr (cCompDe,1,4) + " ate " + substr (cCompAte, 5,2)+"/"+ substr (cCompAte,1,4)
		EndIf
	EndIf
	If !empty(cEmp)
		titulo += ", para a Empresa " + cEmp
		if cEmp = '0006'
			titulo += " - Itau "
		Elseif cEmp = '0006'
			titulo += " - Unibanco "
		EndIf
		
	Else
		titulo += ", Empresa 0001(Mater), 0002(Afinidade) e 0005(Afinidade S/Vinc)"
	EndIf

	NomeProg := "CABR117"
	
	nLin :=	Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
	nLin ++
	
	While (tmp)->(!EOF())
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Preenche Vetor para Excel...                             ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If nExcel = 1
        	aAdd(aUsunfat,{(tmp)->matric			,; // 01 Matricula
               	 			(tmp)->ident			,; // 02 Nome Beneficiario  
							(tmp)->tp_pagto			,; // 03 Forma de pagamento	
				 			stod((tmp)->ba1_datinc)	,; // 04 Data de inclusão  
				 			(tmp)->obs}) // 05 Observaçoes
				 			
      	EndIf     
		
		If nLin > 80 // Salto de Página. Neste caso o formulario tem 80 linhas...
			nLin :=	Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
			nLin ++
		EndIf
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica o cancelamento pelo usuario...                             ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If lAbortPrint
			@nLin,00 PSAY "*** CANCELADO PELO OPERADOR ***"
			Exit
		Endif
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Impressao do cabecalho do relatorio. . .                            ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		@ nLin,002 PSay  (tmp)->matric
		@ nLin,026 PSay  (tmp)->ident
		@ nLin,080 PSay  (tmp)->tp_pagto
		@ nLin,102 PSay  stod((tmp)->ba1_datinc)
		@ nLin,115 PSay  (tmp)->obs
		nLin ++     // Avanca a linha de impressao
		
		(tmp)->(dbSkip())   // Avanca o ponteiro do registro no arquivo
	EndDo
	
	If Select(tmp) > 0
		dbselectarea(tmp)
		(tmp)->(DbCloseArea())
	Endif

	if nExcel = 1 
      //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
      //³ Gera excel                                                         ³
      //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
      DlgToExcel({{"ARRAY","Conferência de Reajuste" , aTitXls  ,aUsunfat}})           
      //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ		        
   EndIf
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Finaliza a execucao do relatorio...                                 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	SET DEVICE TO SCREEN
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Se impressao em disco, chama o gerenciador de impressao...          ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	If aReturn[5]==1
		dbCommitAll()
		SET PRINTER TO
		OurSpool(wnrel)
	Endif
	
	MS_FLUSH()
	
Return


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ValidPerg º Autor ³ Jose Carlos Noronhaº Data ³ 01/08/07    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Parametros para selecao dos titulos do PLS                 º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³                                                            º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ValidPerg()
	
	cPerg := PADR(cPerg,6)
	PutSx1(cPerg,"01","Data Inclusao (Ate)     		","","","mv_ch01","D", 08,0,0,"G","","","","","mv_par01","             ","","","","         ","","","             ","","","                  ","","","         ","","","","","","","","","","","","","","","")
	PutSx1(cPerg,"02","Compet.Geracao (Ano/Mes) De	","","","mv_ch02","C", 06,0,0,"G","","","","","mv_par02","             ","","","","         ","","","             ","","","                  ","","","         ","","","","","","","","","","","","","","","")
	PutSx1(cPerg,"03","Compet.Geracao (Ano/Mes) Ate	","","","mv_ch03","C", 06,0,0,"G","","","","","mv_par03","             ","","","","         ","","","             ","","","                  ","","","         ","","","","","","","","","","","","","","","")
	PutSx1(cPerg,"04","Codigo Empresa          		","","","mv_ch04","C", 04,0,0,"G","","","","","mv_par04","             ","","","","         ","","","             ","","","                  ","","","         ","","","","","","","","","","","","","","","")
	PutSx1(cPerg,"05","Tipo de Cobranca        		","","","mv_ch05","N", 01,0,0,"C","","","","","mv_par05","Mater Aposent","","","","Todos as Cobrança","","","Mater Empresa","","","Bol 112,175,Sisdeb","","","Emp. Itau","","","","","","","","","","","","","","","")
	PutSx1(cPerg,"06","Gerar Excel             		","","","mv_ch06","N", 01,0,0,"C","","","","","mv_par06","Sim          ","","","","Nao      ","","","             ","","","                  ","","","         ","","","","","","","","","","","","","","","")
	PutSx1(cPerg,"07","Empresa a Nao Considerar		","","","mv_ch07","C", 20,0,0,"G","","","","","mv_par07","             ","","","","         ","","","             ","","","                  ","","","         ","","","","","","","","","","","","","","","")
	PutSx1(cPerg,"08","Cont. a Nao Considerar  		","","","mv_ch08","C", 20,0,0,"G","","","","","mv_par08","             ","","","","         ","","","             ","","","                  ","","","         ","","","","","","","","","","","","","","","")
	PutSx1(cPerg,"09","Sub_Cont. Nao Considerar		","","","mv_ch09","C", 20,0,0,"G","","","","","mv_par09","             ","","","","         ","","","             ","","","                  ","","","         ","","","","","","","","","","","","","","","")
	
	
Return(.T.)
