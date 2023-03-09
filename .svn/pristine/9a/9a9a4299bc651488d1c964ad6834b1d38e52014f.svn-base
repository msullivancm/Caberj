#Include "PROTHEUS.CH"
#Include "PLSA992.CH"
#Include "TOPCONN.CH"
                        
//Tipo de Processos    
#Define SADT_GIH   "BD7QRY"
#Define REEMBOLSO  "REE"
#Define ALTO_CUSTO "ALTCUS"

//Tipo Procedimento
#Define PROCEDIMENTO  	"0"
#Define MAT_MED 		"MATMED"
#Define PRO_SEM_CLA 	"Z999"
#Define COD_PRO_GIH 	"E,F,G"

//Tipos GUIAS
#Define GUIA_GIH  01
#Define GUIA_SADT 02

//Array aClaGIH-Dados da Internacao
#Define GIH_GRP_INT 01
#Define GIH_REG_INT 02
#Define GIH_DAT_INT 03
#Define GIH_HOR_INT 04
#Define GIH_HOR_ALT 05
#Define GIH_TIP_NAS 06
#Define GIH_NAS_VIV 07				
#Define GIH_RET_VIV 08				
#Define GIH_CID_INT 09				
#Define GIH_GUI_EST 10	
#Define GIH_DAT_ALT 11	
#Define GIH_CLA_SIP 12	
#Define GIH_VLR_INT 13
#Define GIH_GUI_PRI 14
#Define GIH_LNA_VIV 15
 
//Array aClaSADT-Composicao da SADT
#Define SAD_CLA_SIP 01
#Define SAD_VLR_SIP 02
#Define SAD_QTD_PRO 03
#Define SAD_ITE_PRO 04
#Define SAD_DAT_PRO 05
#Define SAD_COD_PRO 06
#Define SAD_DAT_OCO 07

//aProcSADT-Procedimentos da GUIA;
#Define PRO_CHECKED 01//Flag que indica a analise do procedimento da GUIA.
#Define PRO_CLA_SIP 02
#Define PRO_VLR_SIP 03
#Define PRO_QTD_PRO 04
#Define PRO_ITE_PRO 05
#Define PRO_DAT_PRO 06
#Define PRO_CODIGO  07
#Define PRO_TIPO    08
#Define PRO_DAT_REF 09

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณFun…o    ณ PLSA992  ณ Autor ณ PLS Team              ณ Data ณ 23/10/10 ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescri…o ณ Geracao do resumo S.I.P. para entrega  a ANS               ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณSintaxe   ณ PLSA992()                                                  ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณParametrosณ Nenhum                                                     ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
User Function PLSA992X()
	Local aSays          := {}
	Local aButtons       := {}
	Local nOpca          := 0
	Local lExecCalc      := .T.
	Local cDia           := ""
	//	
	Private cPerg        := "PLSA992"
	Private cRefIni      := ""
	Private cRefFim      := ""
	Private cRecon       := ""
	Private cCampo       := ""
	Private cMesIni      := ""	
	Private cMesFim      := ""	
	Private cOper        := PlsIntPad()	
	Private cFase        := GetNewPar("MV_PLFSSIP","4")
	Private cSituac      := GetNewPar("MV_PLSTSIP","1")
	Private cEmpInter    := GetNewPar("MV_PLSGEIN","9999")
	Private cGrpGer      := GetNewPar("MV_PLGRSIP","0001")
	//Logs	
	Private cIteLogVlr   := GetNewPar("MV_LSIPVLR","")//Grava os valores no momento da gravao do BZZ e BZW. Pode ser A1(Loga 1 unico procedimento) ,A1|A|B (Loga lista de procedimentos) ou ALL (Loga todos os procedimentos).
	Private cIteLogGuia  := GetNewPar("MV_LSIPGUI","")//Classificacoes que serao logadas no SIP. Pode ser A1(Loga 1 unico procedimento) ,A1|AB|B (Loga lista de procedimentos) ou ALL (Loga todos os procedimentos), Nao funciona para internacao
	Private cLogGIH      := GetNewPar("MV_LSIPGIH","")//Log a composicao das guias de GIH, para conferencia
	Private lLogProRep   := GetNewPar("MV_LSIPPRR",.F.)//Loga Procedimentos repetidos na guia.
	Private lIntGIHLog   := GetNewPar("MV_LSIPGIN",.F.)//Indica se verifica a integridade de gravacao entre o BZZ e BZW.
	Private cSipClaGen	 := Alltrim(GetNewPar("MV_SIPCGEN",""))//Indica uma classificacao generica para qdo a guia nใo tem procedimento, ou procedimento sem classificacao ou somente materiais e medicamentos.
	Private cTipDtOco  	 := GetNewPar("MV_PLSIPDT","1") //1=Dt Digitacao, 2= Dt Pagamento ou 3 Data do procedimento.No XML abrira um nova quadro de ocorrencia.
	Private lCheckDtAlt  := GetNewPar("MV_SIPDTIN",.T.) //Indica se a data de alta deve estar preenchida para envio da guia de internacao para o SIP.
	//Private lDoBzzNat  := ExistBlock("PL992CNAT")
	Private lPLS992Cpo   := .F.	
	Private dDataIni     := dDataBase
	Private dDataFim     := dDataBase
	Private aPeriodos    := {}
	Private aClasSup     := {}	
	Private aBufferInter := {}//Performance registra as guias de internacao, classificadas.
	Private nQtdReg      := 100
	Private nTamBZZ_ITEM := TamSx3("BZZ_ITEM")[1]
	Private nTBR8_CODPSA := TamSx3("BR8_CODPSA")[1]
	Private SipSadtLog   := "SipLogSADT"+cEmpAnt+".log"
	Private SipGIHLog    := "SipLogGIH"+cEmpAnt+".log"
	Private SipBZZLog    := "SipLogBZZ"+cEmpAnt+".csv"
	Private SipBZWLog    := "SipLogBZW"+cEmpAnt+".csv"
	
	If ExistBlock("PLS992CPO")
		cCampo 		:= ExecBlock("PLS992CPO",.F.,.F.)
		lPLS992Cpo 	:=.T.		
	EndIf
	
	If BR8->(Fieldpos("BR8_TPCONS")) == 0 .Or. BZZ->(Fieldpos("BZZ_FILIAL")) == 0
		Alert("Existem campos necessแrios que nใo foram criados. Favor rodar o compatibilizador UPDPLSSIP")
		Return .F.
	EndIf

	If ! Empty(cIteLogVlr)
		If MsgYesNo("O log de grava็ใo de valores BZZ e BZW esta atividado parametro (MV_LSIPVLR), isto pode reduzir a performance do programa. Continuar?")	
			PlsLogFil("Tipo,Guia,Clas.SIP,Valor,Quantidade", SipBZZLog)
			PlsLogFil("Guia,Clas.SIP,Valor,Quantidade" , SipBZWLog)
		Else
			Return .F.
		EndIf
	EndIf
	
	If ! Empty(cIteLogGuia) .And.;
		 !MsgYesNo("O log de grava็ใo de classifica็ใo da Guia atividado parametro (MV_LSIPGUI), isto pode reduzir a performance do programa. Continuar?")	
			Return .F.	
	EndIf	
	
	If lIntGIHLog .And.;
		 ! MsgYesNo("A verifica็ใo de integridade parametro(MV_LSIPGIN) esta atividado, a performance do programa serแ reduzida. Continuar?")
		 Return .F.
	EndIf

	/*ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	  ณ Ajusta perguntas                                      ณ
	  ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู*/
	P992CriaSXB()
	CriaSX1() 	
	
	/*ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	  ณ Monta texto para janela de processamento               ณ
	  ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู*/
	AADD(aSays,STR0002) //"Efetua a geracao do resumo mensal do S.I.P para entrega a ANS, baseado nas definicoes"
	AADD(aSays,STR0003) //"da tabela de Naturezas de Saude."	
	
	/*ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	  ณ Monta botoes para janela de processamento              ณ
	  ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู*/
	AADD(aButtons, { 5,.T.,{|| Pergunte(cPerg,.T. ) } } )
	AADD(aButtons, { 1,.T.,{|| nOpca:= 1, If( ConaOk(), FechaBatch(), nOpca:=0 ) }} )
	AADD(aButtons, { 2,.T.,{|| FechaBatch() }} )	

	/*ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	  ณ Exibe janela de processamento                            ณ
	  ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู*/
	FormBatch( STR0001, aSays, aButtons,, 160 )
		
	/*ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	  ณ Processa geracao do arquivo SIP                           ณ
	  ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู*/
	If  nOpca == 1
		/*ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		  ณ Parametros:					  				        ณ
		  ณ mv_par01 // Ano de referencia                       ณ
		  ณ mv_par02 // Periodo de referencia                   ณ
		  ณ mv_par03 // Evento/Despesa                          ณ
		  ณ mv_par04 // Agrupar por UF                          ณ
		  ณ mv_par05 // Gerar XML                               ณ
		  ณ mv_par06 // Diretorio para o XML                    ณ
		  ณ mv_par07 // Calcula Expostos                        ณ
		  ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู*/
		Pergunte(cPerg,.F.)
		
		aadd(aPeriodos,{"01","02","03"})
		aadd(aPeriodos,{"04","05","06"})
		aadd(aPeriodos,{"07","08","09"})
		aadd(aPeriodos,{"10","11","12"})
		//
		cMesIni 	:= aPeriodos[MV_PAR02,1]
		cMesFim 	:= aPeriodos[MV_PAR02,3]
		cRefIni		:= MV_PAR01 + cMesIni + "00"
		cRefFim		:= MV_PAR01 + cMesFim + "99"
		cRecon      := AllTrim(MV_PAR01)+PadL(Alltrim(Str(MV_PAR02)),2,"0")
		//	
		If MV_PAR03 == 1 .Or.  MV_PAR07 == 1
			lExecCalc := lExecutaCalc() 
		EndIf	
	
		cDia        := iiF(cMesFim $ "03/12","31","30")
		dDataIni 	:= cToD("01/"	 +cMesIni+"/"+MV_PAR01)
		dDataFim 	:= cToD(cDia+"/" +cMesFim+"/"+MV_PAR01)
		
		PlsLogFil("----------------------------------------------------------------------",SipSadtLog)	
		PlsLogFil("Inicio do Processamento:"+ dToC(dDataBase)+" As:"+Time(),SipSadtLog)	
		PlsLogFil("----------------------------------------------------------------------",SipSadtLog)	
		
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ	
		//ณ Inicializa o log de processamento.  Ver tabela CV8     ณ 
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		ProcLogIni( {},"PLSA992")
		ProcLogAtu("INICIO")
		ProcLogAtu("MENSAGEM","Iniciando Processamento SIP","Iniciando Processamento SIP")
		
		If (MV_PAR03 == 1 .Or. MV_PAR03 == 2) .And. lExecCalc
			
			If MV_PAR03 == 1
				ProcLogAtu("MENSAGEM","SIP","Excluindo calculos antigos, por favor, aguarde...")
				Proc2BarGauge({||PLS992Del()},"SIP-Novo calculo" ,"Excluindo calculos entre,"+cRefIni+" e "+cRefFim+",por favor, aguarde...","Consultando banco de dados. Aguarde...")
			EndIf
						
			ProcLogAtu("MENSAGEM","SIP-Procedimentos","Selecionando os procedimentos, por favor, aguarde...")
			Proc2BarGauge({||Pls992Processa(SADT_GIH)},"SIP-Procedimentos" ,"Selecionando os procedimentos, por favor, aguarde...","Consultando banco de dados. Aguarde...")
			
			ProcLogAtu("MENSAGEM","SIP-Reembolso","Processando Reembolso")
			Proc2BarGauge( {||Pls992Processa(REEMBOLSO)}	,"SIP-Reembolso" ,"Processando Reembolso","Consultando banco de dados. Aguarde...")

			ProcLogAtu("MENSAGEM","SIP-D้bitos e Cr้ditos","Processando debitos e creditos")
			Proc2BarGauge( {||PLS992Despesa()}	,"SIP-D้bitos e cr้ditos" ,"Processando d้bitos e cr้ditos","Consultando banco de dados. Aguarde...") 
			
			ProcLogAtu("MENSAGEM","SIP-Alto Custo","SIP-"+STR0007)
			Proc2BarGauge( {||Pls992Processa(ALTO_CUSTO)},"SIP-Alto custo" ,"Processando alto custo","Consultando banco de dados. Aguarde...")
			
		EndIf
		If MV_PAR07 == 1 .And. lExecCalc
			ProcLogAtu("MENSAGEM","Calculando Expostos","Calculando Expostos") 
			Proc2BarGauge( {||PLS992Expos()},STR0006 ,"Calculando Expostos" ,"Consultando banco de dados. Aguarde...")
		EndIf
		
		If MV_PAR05 == 1
			ProcLogAtu("MENSAGEM","Gerando XML","Gerando XML") 
			Proc2BarGauge( {||CreateXMLSIP()},STR0006,"Gerando XML" ,"Selecionando registros, por favor. Aguarde...")
		EndIf
	
		ProcLogAtu("MENSAGEM","Termino de Processamento SIP","Termino de Processamento SIP")
		
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณ Atualiza o log de processamento   ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		ProcLogAtu("FIM")

		PlsLogFil("----------------------------------------------------------------------",SipSadtLog)	
		PlsLogFil("Fim do Processamento:"+ dToC(dDataBase)+" As:"+Time(),SipSadtLog)	
		PlsLogFil("----------------------------------------------------------------------",SipSadtLog)	
	
		MsgAlert("Geracao do resumo do SIP concluido.","Fim do processamento")		
				
	EndIf

Return .T.

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณFun…o    ณPLS992Procณ Autor ณ Pls-Team              ณ Data:ณ 22.04.11 ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescri…o ณ Processa geracao do resumo SIP                             ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณParametrosณcExpC1 := Processo que sera executado.                      ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function PLS992Processa(cProcesso)
	Local cTempMsg := ""
    
	BarGauge1Set(2)	

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ	
	//ณSelecao dos registros que serao processados             ณ 
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	If cProcesso == SADT_GIH
		cTempMsg := "Selecionando SADTs. Por favor, aguarde..."
	ElseIf cProcesso == ALTO_CUSTO
		cTempMsg := "Selecionando Alto Custo. Por favor, aguarde..."
	ElseIf cProcesso == REEMBOLSO
		cTempMsg := "Selecionando Reembolso. Por favor, aguarde..."
	EndIf
	IncProcG1(cTempMsg)	
	ProcLogAtu("MENSAGEM","Inicio query:" + cProcesso, "Inicio query:" + cProcesso)
	ExecBD7SQL(cProcesso)
	ProcLogAtu("MENSAGEM","Fim query:" + cProcesso, "Fim query:" + cProcesso)
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ	
	//ณClassificacao dos registros selecionados anteriormente  ณ 
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	If cProcesso == SADT_GIH
		cTempMsg := "Classificando SADTs. Por favor, aguarde..."
	ElseIf cProcesso == ALTO_CUSTO
		cTempMsg := "Classificando Alto Custo. Por favor, aguarde..."
	ElseIf cProcesso == REEMBOLSO
		cTempMsg := "Classificando Reembolso. Por favor, aguarde..."
	EndIf
	IncProcG1(cTempMsg)		
	ProcLogAtu("MENSAGEM","Inicio classificacao:" + cProcesso, "Inicio classificacao:"+cProcesso)
	PL922ClasGui(cProcesso)                             
	ProcLogAtu("MENSAGEM","Fim classificacao:" + cProcesso, "Fim classificacao:"+cProcesso)
	
Return .T.

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณFun…o    ณPLS992Despณ Autor ณ Pls-Team              ณ Data:ณ 15.04.10 ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescri…o ณContabiliza as demais depesas medicos hospitalares          ณฑฑ
ฑฑณ          ณdebitos e creditos                                          ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณParametrosณNenhum                                                      ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function PLS992Despesa()
	Local cQuery	:= ""
	Local cDtOcorre	:= ""
	Local cIteSIP	:= ""
	Local cClaSip	:= ""
	Local cUF  		:= ""
	Local cTipPla	:= ""
	Local cCodSeg 	:= ""
	Local dDataPro	:= dDataBase
	Local nRefer	:= 0

	BarGauge1Set(2)	
	
	IncProcG1("Selecionando despesa. Por favor, aguarde...")	
	cQuery+= "Select BGQ_CODSEG     CODSEG,"
	cQuery+= "       BGQ_CODIGO     CODIGO,"
	cQuery+= "       BGQ_ANO        ANO,"
	cQuery+= "       BGQ_MES        MES,"   
	cQuery+= "       BGQ_CLASIP     CLASIP,"
	cQuery+= "       BGQ_NUMLOT     NUMLOT,"
	cQuery+= "       BGQ.R_E_C_N_O_ RECNODES,"
	cQuery+= "       BGQ_TIPPLA     TIPPLA,"
	cQuery+= "       BGQ_CODSEQ     SEQUENCIA,"
	cQuery+= "       ( Case BGQ_TIPO"
	cQuery+= "           When '1' Then 'DEB'"
	cQuery+= "           Else 'CRED'"
	cQuery+= "         End )        TIPO,"
	cQuery+= "       ( Case BGQ_TIPO"
	cQuery+= "           When '1' Then -BGQ_VALOR"
	cQuery+= "           Else BGQ_VALOR"
	cQuery+= "         End )        VALOR,"
	cQuery+= "       BAU_EST        EST"
	cQuery+= " From   "+RetSqlName("BGQ")+" BGQ"
	cQuery+= "       Inner Join "+RetSqlName("BAU")+" BAU"
	cQuery+= "         On BAU_FILIAL = '"+ xFilial("BAU")+ "'"
	cQuery+= "            And BAU_CODIGO = BGQ_CODIGO"
	cQuery+= "            And BAU.D_E_L_E_T_ = ' '"
	cQuery+= " Where  BGQ_FILIAL = '"+ xFilial("BGQ")+ "'"	
	cQuery+= "       And BGQ_CODSEG <> '   '"	
	cQuery+= "       And (BGQ_TIPO = '1' Or BGQ_TIPO = '2')"
	cQuery+= "       And BGQ_CLASIP <> '"+Space(TamSx3("BGQ_CLASIP")[1])+"'"
	cQuery+= "       And BGQ_NUMLOT >= '"+cRefIni+"'"
	cQuery+= "       And BGQ_NUMLOT <= '"+cRefFim+"' "
	cQuery+= "       And BGQ_TIPPLA <> '"+Space(TamSx3("BGQ_TIPPLA")[1])+"'"
	If MV_PAR03==2
		cQuery +=" And BGQ_RECSIP ='"+Space(TamSx3("BGQ_RECSIP")[1])+"' "
	EndIf
	cQuery+= "       And BGQ.D_E_L_E_T_ = '"+ xFilial("BGQ")+ "'"	
	//
	cQuery+= " Union "
	//
	cQuery+= "Select BCE_CODSEG     CODSEG,"
	cQuery+= "       BCE_CODIGO     CODIGO,"
	cQuery+= "       BCE_ANOPAG     ANO,"
	cQuery+= "       BCE_MESPAG     MES,"
	cQuery+= "       BCE_CLASIP     CLASIP,"
	cQuery+= "       BCE_NUMLOT     NUMLOT,"
	cQuery+= "       BCE.R_E_C_N_O_ RECNODES,"	
	cQuery+= "       BCE_TIPPLA     TIPPLA,"
	cQuery+= "       BCE_CODIGO     SEQUENCIA,"	
	cQuery+= "       'BCE'          TIPO,"		
	cQuery+= "       BCE_VLRAPT     VALOR,"	
	cQuery+= "       BAU_EST        EST"
	cQuery+= " From   "+RetSqlName("BCE")+" BCE"
	cQuery+= "       Inner Join "+RetSqlName("BAU")+" BAU"
	cQuery+= "         On BAU_FILIAL = '"+ xFilial("BAU")+ "'"
	cQuery+= "            And BAU_CODIGO = BCE_CODIGO"
	cQuery+= "            And BAU.D_E_L_E_T_ = ' '"
	cQuery+= " Where  BCE_FILIAL = '"+ xFilial("BCE")+ "'"
	cQuery+= "       And BCE_CODSEG <> '   ' "
	cQuery+= "       And BCE_CLASIP <> '"+Space(TamSx3("BCE_CLASIP")[1])+"'"
	cQuery+= "       And BCE_NUMLOT >= '"+cRefIni+"'"
	cQuery+= "       And BCE_NUMLOT <= '"+cRefFim+"' "
	cQuery+= "       And BCE_TIPPLA <> '"+Space(TamSx3("BCE_TIPPLA")[1])+"'"
	cQuery+= "       And BCE.D_E_L_E_T_ = ' '"	
	If MV_PAR03==2
		cQuery +=" And BCE_RECSIP ='"+Space(TamSx3("BCE_RECSIP")[1])+"' "
	EndIf
	
	cQuery := ChangeQuery(cQuery)
	
	dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"DESP",.F.,.T.)

	IncProcG1("Classificando d้bito e cr้dito. Por favor, aguarde...")		
	
	While DESP->(!Eof())
		
		GrowGauge2("Processando RDA: " + DESP->CODIGO)
		
		nRefer		:= Ascan( aPeriodos,{ |X| x[1] == Substr(DESP->NUMLOT,5,2) .or. x[2] == Substr(DESP->NUMLOT,5,2) .or. x[3] == Substr(DESP->NUMLOT,5,2)})
		cDtOcorre	:= Substr(DESP->NUMLOT,1,4)+PADL(Alltrim(STR(nRefer)),2,"0")
		cUF    		:= IIf(MV_PAR04 ==1,DESP->EST,Space(2))
		cClaSip		:= DESP->CLASIP
		cTipPla		:= DESP->TIPPLA
		cCodSeg 	:= DESP->CODSEG
		cIteSIP		:= PadR(Space(08)+PadR(DESP->TIPO,8," ")+DESP->SEQUENCIA,26 ," ")
		dDataPro	:= StoD(DESP->ANO+DESP->MES+"01")
		
		If RTrim(DESP->TIPO) =="BCE"
			BCE->(DbGoTo(DESP->RECNODES))
			BCE->(RecLock("BCE",.F.))
			BCE->BCE_RECSIP := cRecon
			BCE->(MsUnlock())
		Else
			BGQ->(DbGoTo(DESP->RECNODES))
			BGQ->(RecLock("BGQ",.F.))
			BGQ->BGQ_RECSIP := cRecon
			BGQ->(MsUnlock())
		EndIf

		//Nใo gravar a internacao nas notas de debito e credito.	
		If cClaSip $ COD_PRO_GIH
			PlsLogFil("Aten็ใo; A despesa codigo ;"+ DESP->(CODIGO)+"; esta classificada como interna็ใo porem nใo serแ enviada ao SIP.",SipSadtLog)
		Else
			cClaSip	:= SaveInBZZ(cClaSip,cDtOcorre,cUF,cTipPla,cCodSeg,0,DESP->VALOR,"DEB|CRE")
			SaveInBZW("","",cIteSIP,cTipPla,"",Space(19),dDataPro,cClaSip,0,DESP->VALOR,Space(19))		
		EndIf
		
		DESP->(DbSkip())
	Enddo
	DESP->(DbCloseArea())

Return .T.

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPL922ClasGบAutor  ณMicrosiga           บ Data ณ  22/03/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFaz a classificacao dos procedimentos das guias medicas     บฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณParametrosณcAlias := Alias da tabela temporaria que esta sendo proces- ณฑฑ
ฑฑบ          ณ          sada.                                             บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function PL922ClasGui(cAlias)
	Local cChave    	:= ""
	Local cClaSip 		:= ""
	Local cOpeOri  		:= ""
	Local cOpeDes  		:= ""
	Local cDtOcorre    	:= ""
	Local cDataInt		:= ""
	Local cSeekInt		:= ""
	Local cCodProc		:= ""
	Local cUF           := ""
	Local cTpPlan       := ""
	Local cSegMen       := ""
	Local cGrpInt 		:= ""
	Local cRegInt		:= ""
	Local cCID			:= ""
	Local nVlrProc    	:= 0
	Local nQtdProc		:= 0
	Local nTotInt       := 0
	Local nNasVivo      := 0
	Local nItens		:= 0
	Local nTpPlaSize	:= TamSx3("BII_TIPPLA")[1]
	Local dDatProc 		:= dDataBase
	Local dDatNas 		:= dDataBase
	Local dDataAlta		:= dDataBase
	Local lNasVivo 		:= .F.
	Local lFirst    	:= .T.	
	Local lRetVivo   	:= .F.	
	Local aClaGIH		:= {}
	Local aClaSADT		:= {}
	Local aLogDetGIH    := {}
		
	(cAlias)->(DbGoTop())
	While (cAlias)->(!Eof())
		cNumero     := (cAlias)->(BD7_CODOPE+BD7_CODLDP+BD7_CODPEG+BD7_NUMERO)
		cChave      := (cAlias)->(BD7_CODOPE+BD7_CODLDP+BD7_CODPEG+BD7_NUMERO+BD7_ORIMOV)
		cTipGui  	:= (cAlias)->(BD7_TIPGUI)
		cBenef   	:= (cAlias)->(BD6_OPEUSR+BD6_CODEMP+BD6_MATRIC+BD6_TIPREG+BD6_DIGITO)
		cUf         := Space(2)		
		cGuiInt 	:= ""
		cCodProc	:= ""
		nVlrMed     := 0	
		nRecBD5  	:= 0
		lNasVivo    := .F.
		lFirst      := .T.		
		aClaGIH		:= {}

		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณDados da Familia  Usuarios                 		ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		BA3->(dbSetOrder(1)	)           
		If ! BA3->(dbSeek(xFilial("BA3")+(cAlias)->(BD6_OPEUSR+BD6_CODEMP+BD6_MATRIC)))
			PlsLogFil("Aten็ใo; Familia usuแrio nใo localizado;"+(cAlias)->(BD6_OPEUSR+BD6_CODEMP+BD6_MATRIC),SipSadtLog)
			GoNextGuia(cAlias,cChave)
			Loop
		EndIf
		
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณDados dos Usuarios                        		ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		BA1->(dbSetOrder(2))
		If BA1->(dbSeek(xFilial("BA1")+(cAlias)->(BD6_CODOPE+BD6_CODEMP+BD6_MATRIC+BD6_TIPREG+BD6_DIGITO)))
			If Empty(BA1->BA1_CODPLA)
				cPlano	:= BA3->(BA3_CODPLA+BA3_VERSAO)
			Else
				cPlano	:= BA1->(BA1_CODPLA+BA1_VERSAO)
			EndIf
			cOpeOri  	:= BA1->BA1_OPEORI
			cOpeDes  	:= BA1->BA1_OPEDES
			dDatNas 	:= BA1->BA1_DATNAS
		Else
			PlsLogFil("Aten็ใo; Beneficiario nใo locaizado;"+(cAlias)->(BD6_CODOPE+BD6_CODEMP+BD6_MATRIC+BD6_TIPREG+BD6_DIGITO),SipSadtLog)
			GoNextGuia(cAlias,cChave)
			Loop
		EndIf		
		
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณLocalizar o seguimento do produto.        		ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		BI3->(DbSetOrder(1))
		If BI3->(DbSeek(xFilial("BI3")+cOper+cPlano))
			cSegmen := BI3->BI3_CODSEG
		Else
			PlsLogFil("Aten็ใo; Produto nใo locaizado;"+cOper+cPlano,SipSadtLog)
			GoNextGuia(cAlias,cChave)
			Loop		
		EndIf
		
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณTIPO DE PLANO / CONTRATO                                     ณ
		//ณAnalisa o tipo de plano / contrato do usuario. As opcoes sao:ณ
		//ณ1 - Individual / Familiar                                    ณ
		//ณ2 - Coletivo Empresarial                                     ณ
		//ณ3-  Coletivo por Adesใo                                      ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		BG9->(dbSetOrder(1))
		If BG9->( DbSeek( xFilial("BG9")+((cAlias)->(BD6_OPEUSR+BD6_CODEMP)) )) .And. BG9->BG9_TIPO == "1"
			cTpPlan	:= "1"
		Else
			BT5->(DbSetOrder(1))
			If BT5->(DbSeek(xFilial("BT5")+ (cAlias)->(BD6_CODOPE+BD6_CODEMP)+ BA3->(BA3_CONEMP+BA3_VERCON)))
				BII->(DbSetOrder(1))
				If BII->(DbSeek(xFilial("BII")+BT5->BT5_TIPCON))
					cTpPlan:= Alltrim(BII->BII_TIPPLA)
					If Empty(cTpPlan) .Or. Len(cTpPlan) > 1
						PlsLogFil("Aten็a๕; O tipo do plano esta vazio verifique o campo BII_TIPPLA.",SipSadtLog)
						cTpPlan := Space(nTpPlaSize)
					EndIf
				Else
					PlsLogFil("Aten็ใo; Tipo do Plano nใo localizado;"+ BT5->BT5_TIPCON,SipSadtLog)
					cTpPlan := Space(nTpPlaSize)
				EndIf
			Else
				PlsLogFil("Aten็ใo;Grupo de Empresa Contrato nใo localizado;"+(cAlias)->(BD6_CODOPE+BD6_CODEMP+BA3_CONEMP+BA3_VERCON),SipSadtLog)
				GoNextGuia(cAlias,cChave)
				Loop
			EndIf
		EndIf
		
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ		
		//ณLocalizando a Rede de Atendimento        		ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู		
		If MV_PAR04 ==1 .And. ! Empty((cAlias)->BD7_CODRDA)
			BAU->(dbSetOrder(1))
			If BAU->(DbSeek(xFilial("BAU")+(cAlias)->BD7_CODRDA))	.And. ! Empty(BAU->BAU_EST)
				cUF	:= BAU->BAU_EST
			Else
			PlsLogFil("Aten็ใo;Nใo foi possivel verificar o estado para a RDA c๓digo:"+(cAlias)->BD7_CODRDA+".",SipSadtLog)
			EndIf
		EndIf
	
		BD5->(dbSetOrder(1))
		If BD5->(DbSeek(xFilial("BD5")+cChave))
			cGuiInt 	:= BD5->BD5_GUIINT		
			nRecBD5  	:= BD5->(Recno())
			//Guias Estornada nao conta para o SIP.
			If ! Empty(BD5->BD5_GUESTO)
				GoNextGuia(cAlias,cChave)
				Loop
			EndIf
		EndIf				

		//Definicao do tipo da Guia.		
		If cTipGui == "03" .Or. ! Empty(cGuiInt) 
			GrowGauge2("A PEG n๚mero: " + cChave + " ้ uma GIH. Aguarde...")
			nGuiaType := GUIA_GIH 
			cGuiInt   := IIf(Empty(cGuiInt),cChave,cGuiInt)
		Else
			GrowGauge2("A PEG n๚mero: " + cChave + " ้ uma SADT. Aguarde...")
			nGuiaType := GUIA_SADT
		EndIf

		If nGuiaType == GUIA_GIH
		    If lClasGIH(cAlias,cGuiInt,aClaGIH,aLogDetGIH)
				cGrpInt 	:= aClaGIH[GIH_GRP_INT]
				cRegInt 	:= aClaGIH[GIH_REG_INT]
				dDataAlta 	:= aClaGIH[GIH_DAT_ALT]
				cDataInt	:= Left(DtoS(aClaGIH[GIH_DAT_ALT]),6)
				nNasVivo 	:= aClaGIH[GIH_NAS_VIV]
				lRetVivo  	:= aClaGIH[GIH_RET_VIV]
				lNasVivo    := aClaGIH[GIH_LNA_VIV]				
				cCID		:= aClaGIH[GIH_CID_INT]
				cClaSip		:= aClaGIH[GIH_CLA_SIP]
				nTotInt     := aClaGIH[GIH_VLR_INT]
				cSeekInt    := aClaGIH[GIH_GUI_PRI]
				
				//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
				//ณVerifica se a internacao ja foi gravada.			      ณ
				//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
				BZW->(dbSetOrder(1))
	            If BZW->(dbSeek(xFilial("BZW")+cSeekInt)) 
					GoNextGuia(cAlias,cChave)
					Loop
	            EndIf
				
				cDtOcorre  := Left(cDataInt,4)+cMesToTrim(Right(cDataInt,2))										

	            If lLogGIH(cSeekInt)
					LogGih("Informa็ใo; Detalhamento da composicao da GIH n๚mero " + cSeekInt + ";Valor;"+Alltrim(Str(nTotInt))+";SIP;" + cClaSip + ";cOrigem:"+cAlias ,.T.)
					DetLogProc(Nil,Nil,aLogDetGIH)
				EndIf

				Begin Transaction
					//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
					//ณE1-Grava a Interncao             									      ณ
					//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู  
					SaveInBZZ(cClaSip,cDtOcorre,cUF,cTpPlan,cSegmen,1,nTotInt,cSeekInt)
					SaveInBZW(cOpeOri,cOpeDes,cSeekInt,cTpPlan,cPlano,"",dDataAlta,cClaSip,1,nTotInt,cBenef)
					
					//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
					//ณE2-Grava o Regime de Internacao.     									  ณ
					//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู  
					cClaSip	:= "E2" + Iif(cGrpInt=="5".and.cRegInt=="2","21",cRegInt) 
					SaveInBZZ(cClaSip,cDtOcorre,cUF,cTpPlan,cSegmen,1,0,cSeekInt)
					SaveInBZW(cOpeOri,cOpeDes,cSeekInt,cTpPlan,cPlano,"",dDataAlta,cClaSip,1,0,cBenef)						
					
					//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
					//ณF-Grava causas Selecionadas da internacao								  ณ
					//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู  
					cClaSip := cClaSipF(cCid)
					If Left(cClaSip,1) == "F" .And. ! Alltrim(cClaSip) == "F"
						SaveInBZZ(cClaSip,cDtOcorre,cUF,cTpPlan,cSegmen,1,0,cSeekInt)
						SaveInBZW(cOpeOri,cOpeDes,cSeekInt,cTpPlan,cPlano,"",dDataAlta,cClaSip,1,0,cBenef)
					Else
						LogGih("Aten็ใo; A GIH n๚mero " + cSeekInt + ", nใo gravou a causa da interna็ใo." + "Causa:"+ Alltrim(cClaSip) ,.F.)
					EndIf

					//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
					//ณG-Grava Nascido vivo                                               ณ
					//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
					If nNasVivo > 0 .And. (lNasVivo .Or. lRetVivo)
						SaveInBZZ("G",cDtOcorre,cUF,cTpPlan,cSegMen,nNasVivo,0,cSeekInt)
						SaveInBZW(cOpeOri,cOpeDes,cSeekInt,cTpPlan,cPlano,"",dDataAlta,"G",nNasVivo,0,cBenef)
					EndIf					
				End Transaction
				
				//Verificacao de integridade na gravacao do item E							
				lChkIntGIH(cAlias+"/GIH",cSeekInt,nTotInt,cClaSip,aLogDetGIH)
			EndIf
			//
			GoNextGuia(cAlias,cChave)
			Loop
		ElseIf lClasSADT(cAlias,cChave,aClaSADT,dDatNas)
			For nItens := 1 to Len(aClaSADT) 
				cClaSip  := aClaSADT[nItens,SAD_CLA_SIP]
				nVlrProc := aClaSADT[nItens,SAD_VLR_SIP]
				nQtdProc := aClaSADT[nItens,SAD_QTD_PRO]
			    cIteProc := aClaSADT[nItens,SAD_ITE_PRO]
				dDatProc := aClaSADT[nItens,SAD_DAT_PRO]
				cCodProc := aClaSADT[nItens,SAD_COD_PRO]
				cDtOcorre:= aClaSADT[nItens,SAD_DAT_OCO]
				
				//Gravando Sintetico BZZ e Analitico BZW
				cClaSip := SaveInBZZ(cClaSip,cDtOcorre,cUF,cTpPlan,cSegmen,nQtdProc,nVlrProc,cChave)
				SaveInBZW(cOpeOri,cOpeDes,cIteProc,cTpPlan,cPlano,cCodProc,dDatProc,cClaSip,nQtdProc,nVlrProc,cBenef)
			Next nItens

			//Verificacao de integridade na gravacao do item E			
			lChkIntGIH(cAlias+"/SADT",cChave,nVlrProc,cClaSip,aClaSADT)
		EndIf			
	EndDo
	(cAlias)->(DbCloseArea())
	
Return .T.

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณPrograma   ณcClaSipE   ณ Autor ณ Pls-Team             ณ Data ณ 17.10.10 ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescricao  ณVerifica o tipo de internacao baseado no grupo de internaco-ณฑฑ
ฑฑณ           ณes.                                                         ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ*/
Static Function cClaSipE(cGrpInt,cClaSip,cCid,aClasInt,lNasVivo,aDadInt,dDatNas)
	Local cItemE		:= cClaSip	
	Local dAlta			:= aDadInt[GIH_DAT_ALT]
	Local dInter		:= aDadInt[GIH_DAT_INT]
	Local cIntHora		:= aDadInt[GIH_HOR_INT]
	Local cAltaHora		:= aDadInt[GIH_HOR_ALT]
	Local nIdade		:= Calc_Idade(aDadInt[GIH_DAT_INT],dDatNas)
	Local nParto		:= 0
	
	If cGrpInt =="1"//Clinica E11
		cItemE	:="E1"+cGrpInt
	ElseIf cGrpInt== "2" //Cirurgica
		//verifica se existe classifica็ใo no procecimento principal
		If !(Empty(cClaSip)) .And. (Alltrim(cClaSip) >= "E121" .And. cClaSip <= "E127")
			cItemE	:= cClaSip
			If cItemE == "E124" .And. nIdade < 60
				cItemE	:="E1"+cGrpInt
			EndIf
		Else
			cItemE:="E1"+cGrpInt
		EndIf
	ElseIf cGrpInt == "3"//Obstetrica
		If Len(aClasInt) > 0
			nParto	:=	Ascan(aClasInt,{ |x| x[1] >= "E131" .And. x[1] < "E133"})
			If nParto > 0
				cItemE := aClasInt[nParto,1]
				lNasVivo := .T.
			Else
				cItemE:="E1"+cGrpInt
			EndIf
		Else
			cItemE:="E1"+cGrpInt
		EndIf
	ElseIf cGrpInt == "4"//Pediatrica
		If (cCid $"J45/J46" .Or. (cCid >= "J00" .And. cCid <= "J22" )) .And. nIdade <= 5
			cItemE:= "E141"
		ElseIf cCid >="P00" .And. cCid <= "P96"
			If dAlta <= (dInter+2) .And. cAltaHora <= cIntHora //0 a 6 dias e 48 horas -E1421
				cItemE:="E1421"
			Else//0 a 28 dias - E142
				cItemE:="E142"					
			EndIf
		Else
			cItemE:= "E14"
		EndIf
	ElseIf cGrpInt == "5" // Psiquiatrica
		cItemE:= "E15"
	EndIf	
	
Return cItemE

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณPrograma   ณcClaSipF   ณ Autor ณ Pls-Team             ณ Data ณ 15.04.11 ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescricao  ณVerifica se a CID que esta sendo processada deve, ser grava-ณฑฑ
ฑฑณ           ณda no item F.                                               ณฑฑ
ฑฑณ           ณOs Itens F111,F121,F131 e F141, sao tratados pelo codigo do ณฑฑ
ฑฑณ           ณno BRO_CLASP2                                               ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ*/
Static Function cClaSipF(cCid)
	Local cClaSipF	:= cCid

	//Se ja estiver classificado como F, s๓ retorna.
	If Left(cCid,1) <> "F"
		If cCid >= "C00" .And. cCid <= "D48"//Item F1
			If Left(cCid,3) == "C50" .Or.  Left(cCid,3) == "D05" 
				cClaSipF	:= "F11"
			ElseIf Left(cCid,3) == "C53" .Or.  Left(cCid,3) == "D06"
				cClaSipF	:= "F12"			
			ElseIf (cCid >= "C18" .And. cCid <= "C20") .Or. (cCid >= "D010" .And. cCid <= "D012")
				cClaSipF	:= "F13"
			ElseIf Left(cCid,3) == "C61"
				cClaSipF	:= "F14"
			Else
				cClaSipF	:= "F1"
			EndIf
		ElseIf cCid >= "E10" .And. cCid <= "E14"//Item F2
			cClaSipF	:= "F2"
		ElseIf cCid >= "I00" .And. cCid <= "I99"//Item F3
			If Left(cCid,3) == "I21" .Or.  Left(cCid,3) == "I22"
				cClaSipF	:= "F31"
			ElseIf cCid >= "I10" .And. cCid <= "I15"
				cClaSipF	:= "F32"
			ElseIf cCid == "I500" 
				cClaSipF	:= "F33"
			ElseIf cCid >= "I60" .And. cCid <= "I69"				
				If Left(cCid,3) == "I64"
					cClaSipF	:= "F341"
				Else
					cClaSipF	:= "F34"
				EndIf
			Else
				cClaSipF	:= "F3"
			EndIf
		ElseIf cCid >= "J00" .And. cCid <= "J99"//Item F4
			If Left(cCid,3) == "J44"
				cClaSipF	:= "F41"
			Else
				cClaSipF	:= "F4"
			EndIf		
		ElseIf cCid >= "V01" .And. cCid <= "Y98"//Item F5
			cClaSipF	:= "F5"
		Else
			cClaSipF	:= cCid
		EndIf
	EndIf
	
Return cClaSipF

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณPrograma   ณcClaSipI   ณ Autor ณ Pls-Team             ณ Data ณ 17.09.10 ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescricao  ณDependendo do codigo do SIP, verifica a face do dente e     ณฑฑ
ฑฑณ           ณa idade do beneficiario para decidir o codigo do SIP, cor-  ณฑฑ
ฑฑณ           ณreto.                                                       ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ*/
Static Function cClaSipI(cSIP,cCID,dDatPro,dDatNas)
	Local cCodSip	:=	Alltrim(cSIP)
	Local nIdade	:=	0
	Local cDente	:=	""
	Local aAreaBD5 	:= {}

	//Procedimentos que dependem da face e ou idade do beneficiario.
	If ("|"+cCodSip) $ "|I33|I4|I5|I6|I7|I8|I9"
		nIdade := Calc_Idade(dDatPro,dDatNas)

		//Para este procedimento e necessario saber a face do dente		
		If ("|"+cCodSip) $ "|I5|I6|I7|I8|I9"
			aAreaBD5 	:= BD5->(getArea())
			BD5->(DbGoto(nRecBD5)) 
			BEA->(DbSetOrder(12))
			If BEA->(DbSeek(xFilial("BEA")+BD5->(BD5_CODOPE+BD5_CODLDP+BD5_CODPEG+BD5_NUMERO)))
				BE2->(DbSetOrder(1)) 
				If BE2->(DbSeek( xFilial("BE2")+BEA->(BEA_OPEMOV+BEA_ANOAUT+BEA_MESAUT+BEA_NUMAUT) ) )
					cDente	:=	Alltrim(BE2->BE2_DENREG)
				EndIf
				If Empty(cDente)
					PlsLogFil("Aten็ใo; Dente nใo localizado para o seguinte item no BEA;"+ BEA->(BEA_OPEMOV+BEA_ANOAUT+BEA_MESAUT+BEA_NUMAUT) ,SipSadtLog)
				EndIf
			EndIf 
			RestArea(aAreaBD5)
		EndIf
		
		//Tratamento das exececoes do SIP.
		If cCodSip == "I33" .And. nIdade >= 12
			cCodSip := "I"
		ElseIf cCodSip == "I4" .And. nIdade < 12
			cCodSip := "I"		
		ElseIf cCodSip == "I5" .Or. cCodSip == "I6"
			If nIdade < 12 .And. Left(cDente,1) > "4"
				cCodSip	:= "I5"
			ElseIf nIdade > 11 .And. Left(cDente,1) < "5"
				cCodSip	:= "I6"
			Else
				cCodSip	:= "I"
			EndIf
		ElseIf cCodSip == "I7" 
			//Doencas do Periodonto ou Carie.
			If ("|"+Alltrim(cCID)) $ "|K044|K045|K052|K053|K054|K02|K020|K021|K022|K023|K029" ;
				.And. Right(cDente,1) <> "8" .And. nIdade > 11
				cCodSip := "I7"
			Else
				cCodSip := "I"
			EndIf
		ElseIf cCodSip == "I8" .Or. cCodSip == "I9"
			If nIdade < 12 .And. Left(cDente,1) > "4"
				cCodSip	:= "I8"
			ElseIf nIdade > 11 .And. Left(cDente,1) < "5"
				cCodSip	:= "I9"
			Else
				cCodSip	:= "I"
			EndIf		
		EndIf
	EndIf

Return cCodSip

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณPrograma   ณcClaSipNat ณ Autor ณ Pls-Team             ณ Data ณ 13.09.10 ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescricao  ณRetorna a classificacao do SIP dependendo da natureza da    ณฑฑ
ฑฑณ           ณsaude                                                       ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ*/
Static Function cClaSipNat(cClaSip,cClaSip,dNasc,dAnalise)
	Local nIdade		:= 0
	
	BF0->(Dbsetorder(1))
	If BF0->(DbSeek(xFilial("BF0")+cGrpGer+cClaSip)) .And. BF0->BF0_NIVEL <> "1"
		If BF0->BF0_IDADE1 > 0
			nIdade := Calc_Idade(dAnalise,dNasc)
			If (nIdade < BF0->BF0_IDADE1 .or. nIdade > BF0->BF0_IDADE2)
				cClaSip := BF0->BF0_CODSUP
			EndIf
		ElseIf BF0->BF0_CLASSE =="1"
			BF0->(DbSetOrder(3))
			If BF0->(DbSeek(xFilial("BF0")+cGrpGer+BF0->BF0_CODIGO))
				nIdade := Calc_Idade(dAnalise,dNasc)
				If (nIdade >= BF0->BF0_IDADE1 .And. nIdade <= BF0->BF0_IDADE2)
					cClaSip := BF0->BF0_CODSUP
				EndIf
			EndIf
		EndIf
	EndIf

	cClaSip := Iif(Empty(cClaSip),PRO_SEM_CLA,cClaSip)

Return cClaSip

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuncao    ณSaveInBZZ บAutor  ณPLS-Team            บ Data ณ  06/25/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFaz a gravacao dos dados da tabela BZZ.                     บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function SaveInBZZ(cClaSip,cDtOcorre,cUF,cTpPlan,cSegmen,nQtdProc,nVlrProc,cGuiaNum)
	Local cSeekUF		:=	Iif(MV_PAR04 == 1,cUF,Space(2))
	Local lGravaAcum	:=	.T.
	Local nIteSup		:=	0	
	Local cChaveBZZ		:= cGrpGer+cRecon+cDtOcorre+cSeekUF+cTpPlan+cSegmen
	Local cClaSipNat	:= cClaSip//Usado para retornar a funcao chamadora para atualizar o BZW.
	
	/*ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
      |Nao alterar a classificacao da Internacao                                                    |
      |Nao sera mais permitido ao usuario mudar a classificacao da SADT, durante a gravacao.        |
      |Isto pode causar diferencas na quantidade de guias gravadas.                                 |
	  ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู    
	If ! Left(cClaSip,1) $ COD_PRO_GIH
		cClaSipNat 	:= ChangeBZZNature(cClaSip,cDtOcorre,cSeekUF,cTpPlan,cSegmen)
	EndIf		
	//Nao pode retornar classificao em branco nem classificacao de Interncao
	If ! Empty(cClaSipNat) .Or. Left(cClaSip,1) $ COD_PRO_GIH
		cClaSip	:= cClaSipNat
	EndIf
	*/
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณPega o codigo superior  ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	aClasSup := {}		
	PLS992Expl(cClaSip)

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณGrava o Item.           ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	BZZ->(DbSetOrder(1))
	If BZZ->(DbSeek(xFilial("BZZ")+cChaveBZZ+cClaSip))
		BZZ->(RecLock("BZZ",.F.))
	Else
		BZZ->(RecLock("BZZ",.T.))
		BZZ->BZZ_FILIAL := xFilial("BZZ")
		BZZ->BZZ_GRPGER := cGrpGer
		BZZ->BZZ_ITEM   := cClaSip
		BZZ->BZZ_PERIOD := cRecon
		BZZ->BZZ_REFERE := cDtOcorre
		BZZ->BZZ_UF     := cSeekUF
		BZZ->BZZ_TIPPLA := cTpPlan
		BZZ->BZZ_CODSEG := cSegmen
	EndIf
	//Para os procedimentos de internacao gravacao somente os valores do totalizador.
	If Left(cClaSip,1) != "E" .Or. Alltrim(cClaSip) == "E"
   		 BZZ->BZZ_TOTAL += nVlrProc
 	EndIf
 	BZZ->BZZ_EVENTO += nQtdProc
	BZZ->(MsUnlock())

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณLog Gravacao BZZ        ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	If lLogActive(cIteLogVlr,Alltrim(BZZ->BZZ_ITEM))
		PlsLogFil("I,"+cGuiaNum+","+Alltrim(Str(BZZ->BZZ_TOTAL))+","+Alltrim(BZZ->BZZ_ITEM)+","+Alltrim(Str(nQtdProc)) ,SipBZZLog)	
	EndIf
    
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณGrava o Acumulado       ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	For nIteSup:=1 To Len(aClasSup)
		//Gravando acumulado do regime de internacao.
		If Left(cClaSip,1) == "G"
			lGravaAcum	:= .F.
		ElseIf Alltrim(cClaSip) == "F"
			lGravaAcum	:= .F.
		ElseIf Left(cClaSip,2) == "E2" .And. Alltrim(aClasSup[nIteSup,1]) == "E"
			lGravaAcum	:= .F.
		EndIf

		//Completar o tamanho da classificacao para evitar erro na chave.		
		cClaSip := PadR(aClasSup[nIteSup,1],nTamBZZ_ITEM)
		
		If lGravaAcum 
			If BZZ->(DbSeek(xFilial("BZZ")+cChaveBZZ+cClaSip))
				BZZ->(RecLock("BZZ",.F.))
			Else
				BZZ->(RecLock("BZZ",.T.))
				BZZ->BZZ_FILIAL := xFilial("BZZ")
				BZZ->BZZ_GRPGER := cGrpGer
				BZZ->BZZ_ITEM   := cClaSip
				BZZ->BZZ_PERIOD := cRecon
				BZZ->BZZ_REFERE := cDtOcorre
				BZZ->BZZ_UF     := cSeekUF
				BZZ->BZZ_TIPPLA := cTpPlan
				BZZ->BZZ_CODSEG := cSegMen
			EndIf
			BZZ->BZZ_EVENTO += nQtdProc
			//Gravando Internacoes
			If Left(cClaSip,1) == "E"
				BZZ->BZZ_TOTAL += Iif(aClasSup[nIteSup,2]=="1" .And. aClasSup[nIteSup,3]== "1" , nVlrProc, 0)
			Else
				BZZ->BZZ_TOTAL += nVlrProc
			Endif
			BZZ->(MsUnlock())
			
			//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
			//ณLog Gravacao BZZ        ณ
			//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
			If  lLogActive(cIteLogVlr,Alltrim(BZZ->BZZ_ITEM))
				PlsLogFil("A,"+cGuiaNum+","+Alltrim(Str(BZZ->BZZ_TOTAL))+","+Alltrim(BZZ->BZZ_ITEM)+","+Alltrim(Str(nQtdProc)),SipBZZLog)
			EndIf
						
		EndIf
		lGravaAcum	:=	.T.
	Next nIteSup
	
Return cClaSipNat

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณPrograma   ณSaveInBZW  ณ Autor ณ Pls-Team             ณ Data ณ 15.10.11 ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescricao  ณFaz a gravacao da tabela Analiticas BZW.                    ณฑฑ
ฑฑณ           ณ                                                            ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ*/
Static Function SaveInBZW(cOpOri,cOpDes,cNumGuia,cTpPlano,cCodPlano,cCodProc,dDataPro,cClaSip,nQtdPro,nValorPro,cBenefic)
	Local cBenType	:= iIf(cOpOri == cOpDes .And. cOpDes== cOper,"1","2")//"1"=beneficiแrio exposto
	Local cBZWProd	:= "" 
	Local isDetInt	:= Left(cClaSip,2)=="E2" .Or. Left(cClaSip,1)== "G" .Or. Left(cClaSip,1)=="F" //Detalhes da internacao					

	If ! cClaSip $ COD_PRO_GIH
		cBZWProd :=	Substr(cCodProc,3,nTBR8_CODPSA)	
	EndIf	

	If isDetInt 
		BZW->(Reclock("BZW",.T.))						
	Else
		BZW->(DbSetorder(1))
		If BZW->(DbSeek(xFilial("BZW")+cNumGuia+cCodProc))
			BZW->(Reclock("BZW",.F.))
		Else
			BZW->(Reclock("BZW",.T.))
		EndIf		
	EndIf	
	BZW->BZW_FILIAL := xFilial("BZW")
	BZW->BZW_CODOPE := Substr(cNumGuia,01,04)
	BZW->BZW_CODLDP := Substr(cNumGuia,05,04)
	BZW->BZW_CODPEG := Substr(cNumGuia,09,08)
	BZW->BZW_NUMERO := Substr(cNumGuia,17,08)
	BZW->BZW_ORIMOV := Substr(cNumGuia,25,01)
	BZW->BZW_SEQUEN := Substr(cNumGuia,26,03)
	BZW->BZW_CODPAD := Left(cCodProc,2)
	BZW->BZW_CODPRO := cBZWProd
	BZW->BZW_VLRPAG := nValorPro
	BZW->BZW_CODPLA := cCodPlano
	BZW->BZW_DATPRO := dDataPro
	BZW->BZW_TIPPLA := cTpPlano
	BZW->BZW_CLASIP := cClaSip
	BZW->BZW_TPBENE := cBenType
	BZW->BZW_OPEUSR := Substr(cBenefic,01,04)
	BZW->BZW_CODEMP := Substr(cBenefic,05,04)
	BZW->BZW_MATRIC := Substr(cBenefic,09,06)
	BZW->BZW_TIPREG := Substr(cBenefic,15,02)
	BZW->BZW_DIGITO := Substr(cBenefic,17,02)
	BZW->BZW_PERIOD := cRecon
	BZW->BZW_QTDPRO += nQtdPro	
	BZW->(MsUnlock())
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณLog Gravacao BZW        ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	If lLogActive(cIteLogVlr,Alltrim(cClaSip))
		PlsLogFil(cNumGuia+","+Alltrim(cClaSip)+","+Alltrim(Str(nValorPro))+","+Alltrim(Str(nQtdPro)),SipBZWLog)
    EndIf
    
Return .T.

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPLSA992   บAutor  ณMicrosiga           บ Data ณ  03/24/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณLimpa o flag   de controle de processamento do SIP.         บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function PLS992Del()
	
	TcSQLExec("Delete From "+RetSQLName("BZZ")+" Where BZZ_PERIOD='"+cRecon+"' And BZZ_UF <> 'FC' ")
	TcSQLExec("Update "+RetSQLName("BD7")+" Set BD7_RECSIP='"+Space(4)+"' Where BD7_RECSIP='"+cRecon+"' ")
	TcSQLExec("Delete From "+RetSQLName("BZW")+" Where BZW_PERIOD='"+cRecon+"' ")
	TcSQLExec("Update "+RetSQLName("BE4")+" Set BE4_NASSIP='"+Space(4)+"' Where BE4_NASSIP='"+cRecon+"' ")

Return .T.

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPLS992ExplบAutor  ณMicrosiga           บ Data ณ  24/03/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Monta os codigos superiores da Natureza de Saude           บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function PLS992Expl(cCodigo)

	BF0->(DbSetOrder(1))
	If BF0->(DbSeek(xFilial("BF0")+cGrpGer+cCodigo)) .And. !Empty(BF0->BF0_CODSUP) .And. BF0->(DbSeek(xFilial("BF0")+cGrpGer+BF0->BF0_CODSUP))
		aadd(aClasSup,{BF0->BF0_CODIGO,BF0->BF0_CLASSE,BF0->BF0_NIVEL})
		PLS992Expl(BF0->BF0_CODIGO)
	EndIf
	
Return .T.

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณlPLS992RefบAutor  ณMicrosiga           บ Data ณ  04/08/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function lPLS992RefAnt(cGuiaIt)
	Local cCodOpe := Substr(cGuiaIt,01,04)
	Local cCodLdp := Substr(cGuiaIt,05,04)
	Local cCodPeg := Substr(cGuiaIt,09,08)
	Local cNumero := Substr(cGuiaIt,17,08)
	Local cOriMov := Substr(cGuiaIt,25,01)
	Local cSequen := Substr(cGuiaIt,26,03)
	Local lRet 	  := .F.
	Local cQuery  := ""
		
	cQuery += " Select BD7_RECSIP"
	cQuery += " From "+RetSqlName("BD7") +" "
	cQuery += " Where BD7_FILIAL='"+xFilial('BD7')+"'"
	cQuery += "       And BD7_CODOPE ='"+cCodOpe+"'" 
	cQuery += "       And BD7_CODLDP ='"+cCodLdp+"' "
	cQuery += "       And BD7_CODPEG ='"+cCodPeg+"'"
	cQuery += "       And BD7_NUMERO ='"+cNumero+"' "
	cQuery += "       And BD7_ORIMOV ='"+cOriMov+"'"
	cQuery += "       And BD7_SEQUEN ='"+cSequen+"' "
	cQuery += "       And BD7_VLRPAG > 0 "
	cQuery += "       And BD7_NUMLOT < '"+cRefIni+"'"
	cQuery += "       And BD7_RECSIP = '"+cRecon+"'"
	cQuery += "       And BD7_LIBERA <> '1'"
   	cQuery += "       And "+GetInStament(GetNewPar("MV_PLFSSIP","4"),"BD7_FASE")
 	cQuery += "       And "+GetInStament(GetNewPar("MV_PLSTSIP","1"),"BD7_SITUAC")
	cQuery += "       And BD7_BLOPAG <> '1' "
	cQuery += "       And D_E_L_E_T_ = ' ' "
	
	cQuery := ChangeQuery(cQuery)
	dbUseArea(.T.,"TOPCONN",TCGENQRY(,,cQuery),"TMPQRY",.F.,.T.)
	
	If TMPQRY->(!Eof())
		lRet:= .T.
	EndIf
	TMPQRY->(dbCloseArea())
	
Return lRet

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGetDoeByCiบAutor  ณPLS-Team            บ Data ณ 18/01/2011  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRetorna a doencao pelo CID;                                 บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       |PLSA992                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function GetDoeByCid(cCid)
	Local cCidReal := ""
	
	BA9->(dbSetOrder(1))
	If ! Empty(cCid) .And. BA9->(DbSeek(xFilial("BA9")+cCid))
		cCidReal  := BA9->BA9_CODDOE
	EndIf
	
Return cCidReal

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณExecBD7SqlบAutor  ณPLS-Team            บ Data ณ 04/03/2011  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณExecuta a selecao dos registros para processamento do SIP.  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       |PLSA992                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function ExecBD7Sql(cRsAlias)
	Local cStatement := "Select "
	Local aRetAux    :={}

	If "ORACLE" $ AllTrim(TCGetDB()) 
		cStatement := "Select /*+ INDEX_ASC(BD7 "+RetSQLName("BD7")+"2)*/ " 
	EndIf 
	cStatement += "BD7_NUMLOT,"
	cStatement += "BD7_CODOPE,"
	cStatement += "BD7_CODLDP,"
	cStatement += "BD7_CODPEG,"
	cStatement += "BD7_NUMERO,"
	cStatement += "BD7_ORIMOV,"
	cStatement += "BD7_VLRPAG,"
	cStatement += "BD7_CODRDA,"
	cStatement += "BD7_CODPAD,"
	cStatement += "BD7_CODPRO,"
	cStatement += "BD7_DATPRO,"
	cStatement += "BD7_SEQUEN,"
	cStatement += "BD7_BLOPAG,"
	cStatement += "BD7_TIPGUI,"	
	cStatement += "BD7_LIBERA,"	
	cStatement += "BD7_FASE,"	
	cStatement += "BD7_SITUAC,"	
	cStatement += "BD7_RECSIP,"	
	cStatement += "BD7.R_E_C_N_O_ RECNOBD7,"
	cStatement += "BD6_DTDIGI,"
	cStatement += "BD6_CID,"
	cStatement += "BD6_QTDPRO,"
	cStatement += "BD6_CODOPE,"
	cStatement += "BD6_PROREL,"
	cStatement += "BD6_CODEMP,"
	cStatement += "BD6_OPEUSR,"
	cStatement += "BD6_CODEMP,"
	cStatement += "BD6_MATRIC,"
	cStatement += "BD6_TIPREG,"
	cStatement += "BD6_DIGITO,"
	cStatement += "BD6_CODESP,"
	cStatement += "BR8_TPPROC,"
	cStatement += "BR8_CLASP2,"
	cStatement += "BR8_CLASIP,"
	cStatement += "BR8_TPPROC,"
	cStatement += "BR8_TPCONS "
	If lPLS992Cpo
		cStatement += cCampo + ", "
	EndIf	
	cStatement += " From "+RetSqlName("BD7")+" BD7 "
	cStatement += " Inner Join "+RetSqlName("BD6")+" BD6 "
	cStatement += "   On BD6_FILIAL = '"+xFilial("BD6")+"'"
	cStatement += "     And BD6_CODOPE = BD7_CODOPE"
	cStatement += "     And BD6_CODLDP = BD7_CODLDP"
	cStatement += "     And BD6_CODPEG = BD7_CODPEG"
	cStatement += "     And BD6_NUMERO = BD7_NUMERO"
	cStatement += "     And BD6_SEQUEN = BD7_SEQUEN"
	cStatement += "     And BD6.D_E_L_E_T_ = ' '"
	cStatement += " Inner Join "+RetSqlName("BR8")+" BR8 "
	cStatement += "   On BR8_FILIAL = '"+xFilial("BR8")+"'"
	cStatement += "     And BR8_CODPAD = BD7_CODPAD"
	cStatement += "     And BR8_CODPSA = BD7_CODPRO"
	cStatement += "     And BR8.D_E_L_E_T_ = ' '	"
	//Guias de Reembolso
	If cRsAlias == REEMBOLSO
		cStatement += " Inner Join "+RetSqlName("B44")+" B44 "
		cStatement += "   On B44_FILIAL = '"+xFilial("B44")+"' "
		cStatement += "     And B44_OPEUSR = BD6_CODOPE "
		cStatement += "     And B44_CODLDP = BD6_CODLDP "
		cStatement += "     And B44_CODPEG = BD6_CODPEG "
		cStatement += "     And B44_NUMGUI = BD6_NUMERO "
		cStatement += "     And B44.D_E_L_E_T_ = ' '"
		cStatement += " Inner Join "+RetSqlName("SE1")+" SE1 "
		cStatement += "   On E1_FILIAL = '"+xFilial("SE1")+"' "
		cStatement += "     And E1_PREFIXO = B44_PREFIX "
		cStatement += "     And E1_NUM = B44_NUM "
		cStatement += "     And SE1.D_E_L_E_T_ = ' ' "
	//Guias de Alto Custo
	ElseIf cRsAlias == ALTO_CUSTO
		cStatement += " Inner Join "+RetSqlName("B19")+" B19 "
		cStatement += "   On B19_FILIAL = BD7_FILIAL "
		cStatement += "     And BD7_CODOPE = Substring(B19_GUIA, 1, 4) "
		cStatement += "     And BD7_CODLDP = Substring(B19_GUIA, 5, 4) "
		cStatement += "     And BD7_CODPEG = Substring(B19_GUIA, 9, 8) "
		cStatement += "     And BD7_NUMERO = Substring(B19_GUIA, 17, 8) "
		cStatement += "     And BD7_ORIMOV = Substring(B19_GUIA, 25, 1) "
		cStatement += "     And BD7_SEQUEN = Substring(B19_GUIA, 26, 3) "
		cStatement += "     And B19.D_E_L_E_T_ = ' ' "
		cStatement += " Inner Join "+RetSqlName("SD1")+" SD1 "
		cStatement += "   On D1_FILIAL = '"+xFilial('SD1')+"' "
		cStatement += "     And D1_DOC = B19_DOC "
		cStatement += "     And D1_SERIE = B19_SERIE "
		cStatement += "     And D1_FORNECE = B19_FORNEC "
		cStatement += "     And D1_LOJA = B19_LOJA "
		cStatement += "     And D1_ITEM = B19_ITEM "
		cStatement += "     And D1_COD = B19_COD "
		cStatement += "     And SD1.D_E_L_E_T_ = ' ' "
		cStatement += " Inner Join "+RetSqlName("SF1")+" SF1 "
		cStatement += "   On F1_FILIAL = D1_FILIAL "
		cStatement += "     And D1_DOC = F1_DOC "
		cStatement += "     And D1_SERIE = F1_SERIE "
		cStatement += "     And D1_FORNECE = F1_FORNECE "
		cStatement += "     And F1_LOJA = D1_LOJA "
		cStatement += "     And SF1.D_E_L_E_T_ = ' ' "
	EndIf

	cStatement += "	Where  BD7_FILIAL = '"+xFilial("BD7") +"'"

	If cRsAlias != ALTO_CUSTO
		If cTipDtOco == "1"
			cStatement +=" And BD7_CODOPE ='"+cOper+"' "
			cStatement +=" And BD6_DTDIGI >='"+Dtos(dDataIni)+"' AND BD6_DTDIGI <='"+dtos(dDataFim)+"' "
		Else 
			cStatement +=" And BD7_OPELOT ='"+cOper+"' "
			cStatement +=" And BD7_NUMLOT >='"+cRefIni+"' AND BD7_NUMLOT <='"+cRefFim+"' "
		EndIf
	
		If cRsAlias == REEMBOLSO
			cStatement +=" And E1_EMIS1>='"+cRefini+"'" 
			cStatement +=" And E1_EMIS1<='"+cRefFim+"' "
		Else
		   	cStatement += " And BD7_CODEMP <>'"+cEmpInter +"' "
		    cStatement += " And BD7_LIBERA <>'1' "
		   	cStatement += " And "+ GetInStament(GetNewPar("MV_PLFSSIP","4"),"BD7_FASE")
		 	cStatement += " And "+ GetInStament(GetNewPar("MV_PLSTSIP","1"),"BD7_SITUAC")
		EndIf	 	
		
		//Desconsidera guias estornadas
		If ExistBlock("PLRECEST")
			aRetAux := Execblock("PLRECEST",.F.,.F.,{cAlias,lUsuario,lRDA,lMovto,lFatur,lIndRegua,lWhile,aRet})
			cStatement   += " And " + aRetAux[1]		
		Else
		  	cStatement   += " And BD6_CONMUS <> '0'"
		EndIf     
	
		If ! ExistBlock("PLS992FIL")
			cStatement +=" And BD7_VLRPAG > 0  "
		Else
			cStatement += ExecBlock("PLS992FIL",.F.,.F.)
		EndIf
	Else
		cStatement += " And BD7_CODEMP <> '"+cEmpInter +"' "
		cStatement += " And BD7_SITUAC = '1' "
		cStatement += " And D1_DTDIGIT >= '"+cRefIni+"' "
		cStatement += " And D1_DTDIGIT <= '"+cRefFim+"' "
	EndIf
	cStatement += " And  BD7.D_E_L_E_T_  = ' '  "
	If MV_PAR03==2
		cStatement +=" And BD7_RECSIP ='"+Space(TamSx3("BD7_RECSIP")[1])+"' "
	EndIf	
	//teste para verificar porque nao contou guia de exame encontrada pela Raquel. Renato 18/05/2011
   //	cStatement += " AND BD7_CODOPE = '0001' AND BD7_CODLDP = '0001' AND BD7_CODPEG = '00058553' AND BD7_NUMERO = '00000011' " //essa contou apos acertar parametrizacao
	//cStatement += " AND BD7_CODOPE = '0001' AND BD7_CODLDP = '0001' AND BD7_CODPEG = '00021271' AND BD7_NUMERO = '00000002' " //contou como interna็ใo, pois bd5_guiint estแ preenchido com a seguinte chave: 000100000000162600000003
	////cStatement += " AND BD7_CODOPE = '0001' AND BD7_CODLDP = '0000' AND BD7_CODPEG = '00022062' AND BD7_NUMERO = '00000002' " //--contou como interna็ใo, pois o bd5_guiint estแ preenchido com a chave da guia: 000100000000162600000003
	//fim teste renato
	cStatement +=	"Order by BD7_FILIAL,BD7_ORIMOV,BD7_CODOPE,BD7_CODLDP,BD7_CODPEG,BD7_NUMERO,BD7_SEQUEN " 

	cStatement := 	ChangeQuery(cStatement)
	dbUseArea(.T.,"TOPCONN",TcGenQry(,,cStatement),cRsAlias,.F.,.T.)

Return .T.

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณlClasGIH  บAutor  ณPLS Team            บ Data ณ  17/09/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณVerifica se a interncao deve ser contabilizada no SIP.      บฑฑ
ฑฑบ          ณVerifica se pelo menos um dos procedimentos da internacao   บฑฑ
ฑฑบ          ณfoi pago.                                                   บฑฑ
ฑฑบ          ณVerifica se a menor data de pagamento do procedimento da    บฑฑ
ฑฑบ          ณinternacao, e a mesma data de geracao do SIP.               บฑฑ
ฑฑบ          ณRetorna a classificacao principal do SIP, das guias de      บฑฑ
ฑฑบ          ณinternacao.                                                 บฑฑ
ฑฑบ          ณVerifica se a GIH, possui um procedimento OPME, amarrado a  บฑฑ
ฑฑบ          ณela.                                                        บฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณParametrosณExpC1: Alias da query esta sendo processada.                ณฑฑ
ฑฑณ          ณExpC2: Numero da guia de internacao.                        ณฑฑ
ฑฑณ          ณExpA1: Dados referentes a interncao.                        ณฑฑ
ฑฑณ          ณExpD1: Data de nascimento.                                  ณฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function lClasGIH(cAlias,cChave,aDadSIP,aLogDetGIH)
	Local lEnviaGIH		:= .T.
	Local lExiProPag	:= .F.//Controla se pelo menos um procedimento esta pago na GIH
	Local lLogSomInt	:= .F.//Usado no log para indicadr se o valor foi somado ao total da interna็ใo.
	Local lNasVivo		:= .F.
	Local lLogProc		:= lLogGIH(cChave)
	Local cStatement 	:= ""
	Local cTrimPag		:= ""
	Local cMenTrimPag	:= ""//Menor trimestre de pagamento
	Local cSIP			:= ""	
	Local cCIDIntProc	:= ""
	Local cSIPInt		:= ""
	Local cInterKey		:= Left(cChave,24)//BE4->(Len(BE4_CODOPE+BE4_CODPEG+BE4_CODLDP+BE4_NUMERO)))
	Local cBD7NumGuia   := ""
	Local cErrorMsg		:= ""
	Local nProcValor	:= 0 //Guarda o valor do maior procedimento
	Local nFoundGuia	:= 0 
	Local nTotInt		:= 0
	Local nItePro		:= 0
	Local aProcRecon	:= {} //Registra todos os procedimentos reconhecidos para grava็ใo no SIP.
	Local aClasInt 		:= {}

	Default aDadSIP		:= {}
	
	aLogDetGIH			:= {}

	/*aBufferInter[01,01] = cChave da Guia
	  aBufferInter[01,02] = Procedimento em Aberto
	  aBufferInter[01,03] = Dados da internacao*/
	If Len(aBufferInter) > 0
		nFoundGuia := Ascan(aBufferInter,{|aItem| Left(aItem[1],24) == Left(cChave,24)})
	EndIf
	
	If nFoundGuia > 0
		lEnviaSADT	:= aBufferInter[nFoundGuia,2]
        If ! lEnviaSADT
			aDadSIP	:= aBufferInter[nFoundGuia,3]
        EndIf
		//Controle do tamanho do buffer de guias
		If Len(aBufferInter) > 150
	        AEval(aBufferInter, {|cValue,nIndex| Iif(nIndex < 51 ,ADel(aBufferInter,nIndex),.T.)})
	        ASize(aBufferInter,75)
		EndIf
		//Conta a internacao somente uma vez.
		lEnviaGIH := .F.
	Else
		GrowGauge2("Consultando procedimentos da GIH: " + cInterKey)
		/*ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		  |Selecionando todos procedimentos executados na internacao, incluindo medicaments,materiais e compra de materais tabela B19.     |
		  ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู*/
		cStatement += " Select BD7_NUMLOT,BD7_SITUAC,BD7_FASE,BD7_BLOPAG,BD7_VLRPAG,"
		cStatement += "        BD7_CODOPE,BD7_CODPEG,BD7_FASE,BD7_NUMERO,BD7_RECSIP,"
		cStatement += "        BD7_CODEMP,BD7_LIBERA,BD7_CODLDP,BD7_SITUAC,BD7.R_E_C_N_O_ RECNOBD7,"
		cStatement += "        BR8_CLASP2,BR8_TPPROC,BR8_CODPAD,BR8_CODPSA"		
		cStatement += "   ,B19_GUIA"				
		cStatement += " From "  +RetSqlName("BD7")+" BD7 "    
		cStatement += "       Inner Join "+RetSqlName("BR8")+" BR8 "
		cStatement += "         On BR8_FILIAL = '"+xFilial('BR8')+"'
		cStatement += "            And BR8_CODPAD = BD7_CODPAD"
		cStatement += "            And BR8_CODPSA = BD7_CODPRO"
		cStatement += "            And BR8.D_E_L_E_T_  = ' '"
		cStatement += "        Left Join "+RetSqlName("B19")+" B19 "		
		cStatement += "         On B19_FILIAL = '"+xFilial("B19")+"'
		cStatement += "       	  And B19_GUIA = "  + ParseToDB("BD7_CODOPE+BD7_CODLDP+BD7_CODPEG+BD7_NUMERO+BD7_ORIMOV+BD7_SEQUEN")
		cStatement += "       	  And B19.D_E_L_E_T_ = ' '"
		cStatement += "        Left Join "+RetSqlName("BD5")+" BD5"
		cStatement += "         On BD5_FILIAL = '"+xFilial('BD5')+"'"
		cStatement += "            And BD5_CODOPE = BD7_CODOPE"
		cStatement += "            And BD5_CODLDP = BD7_CODLDP"
		cStatement += "            And BD5_CODPEG = BD7_CODPEG"
		cStatement += "            And BD5_NUMERO = BD7_NUMERO"
		cStatement += "            And BD5.D_E_L_E_T_ = ' '"
		cStatement += " Where "	
		cStatement += "		BD7_FILIAL ='"+xFilial("BD7")	+"' "
		cStatement += "		And BD5.BD5_GUIINT = '"+cInterKey+"'"
		cStatement += "     And BD7.D_E_L_E_T_ = ' '  "	
		cStatement += "  Union  "	
		/*ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		  |Selecionando os procedimentos pela guia principal BE4.   |
		  ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู*/	
		cStatement += " Select BD7_NUMLOT,BD7_SITUAC,BD7_FASE,BD7_BLOPAG,BD7_VLRPAG,"
		cStatement += "        BD7_CODOPE,BD7_CODPEG,BD7_FASE,BD7_NUMERO,BD7_RECSIP,"
		cStatement += "        BD7_CODEMP,BD7_LIBERA,BD7_CODLDP,BD7_SITUAC,BD7.R_E_C_N_O_ RECNOBD7,"
		cStatement += "        BR8_CLASP2,BR8_TPPROC,BR8_CODPAD,BR8_CODPSA
		cStatement += "    ,B19_GUIA"				
		cStatement += " From "  +RetSqlName("BD7")+" BD7 "    
		cStatement += "       Inner Join "+RetSqlName("BR8")+" BR8 "
		cStatement += "         On BR8_FILIAL = '"+xFilial('BR8')+"'
		cStatement += "            And BR8_CODPAD = BD7_CODPAD"
		cStatement += "            And BR8_CODPSA = BD7_CODPRO"
		cStatement += "            And BR8.D_E_L_E_T_ = ' '"
		cStatement += "        Left Join "+RetSqlName("B19")+" B19 "		
		cStatement += "         On B19_FILIAL = '"+xFilial('B19')+"'
		cStatement += "       	  And B19_GUIA = " + ParseToDB("BD7_CODOPE+BD7_CODLDP+BD7_CODPEG+BD7_NUMERO+BD7_ORIMOV+BD7_SEQUEN")
		cStatement += "       	  And B19.D_E_L_E_T_  = ' '"
		cStatement += " Where "	
		cStatement += "		BD7_FILIAL ='"+xFilial("BD7")	+"'"
		cStatement += "      And BD7_CODOPE = '" +Substring(cInterKey,01,04) + "'"
		cStatement += "      And BD7_CODLDP = '" +Substring(cInterKey,05,04) + "'"
		cStatement += "      And BD7_CODPEG = '" +Substring(cInterKey,09,08) + "'"
		cStatement += "      And BD7_NUMERO = '" +Substring(cInterKey,17,08) +"'"
		cStatement += "      And BD7.D_E_L_E_T_  = ' '  "	
		//
		cStatement := ChangeQuery(cStatement)
	
		dbUseArea(.T.,"TOPCONN",TCGENQRY(,,cStatement),"TBGUIRE",.F.,.T.)

		TBGUIRE->(dbGoTop())
		Do While ! TBGUIRE->(Eof())
			lLogSomInt := .F.			
			GrowGauge2("Analisando GIH:" + cInterKey)
			
			cBD7NumGuia := TBGUIRE->(BD7_CODOPE+BD7_CODLDP+BD7_CODPEG+BD7_NUMERO)
			//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
			//ณVerificacao do procedimento principal da internacao               ณ 
			//ณO Procedimento principal e o de menor nivel na hierarquia.        ณ
			//ณContabiliza tambem os procedimentos com classificacao com F.      ณ 
            //ณExemplo se na mesma guia tiver o procedimento E12 e E121 o sistemaณ
            //ณ considerara o E121 como procedimento principal.                  ณ
			//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู            
			If Len(Alltrim(TBGUIRE->BR8_CLASP2)) > Len(Alltrim(cSIP)) .And. TBGUIRE->BD7_VLRPAG > nProcValor .And. ;
				(Left(TBGUIRE->BR8_CLASP2,1) == "E" .Or. Left(TBGUIRE->BR8_CLASP2,1) == "F" ) 
				If Left(TBGUIRE->BR8_CLASP2,1) == "E"
					cSIP := TBGUIRE->BR8_CLASP2
				EndIf					
				nProcValor	:= TBGUIRE->BD7_VLRPAG
			EndIf
			//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
			//|Tratamento das causas da internacao especifica, Itens F111,F121,F131,F141  |
			//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู            
			If Left(TBGUIRE->BR8_CLASP2,1) == "F"
				cCIDIntProc := TBGUIRE->BR8_CLASP2
			EndIf
			//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ			
			//|Verifica se pelo menos 1 dos procedimentos da GIH esta pago.               |
			//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู            			
			If  cInterKey == TBGUIRE->(BD7_CODOPE+BD7_CODLDP+BD7_CODPEG+BD7_NUMERO) .And. ! Empty(TBGUIRE->(BD7_NUMLOT))
				//Pega o menor trimestre de pagamento
				cTrimPag := Left(TBGUIRE->(BD7_NUMLOT),4)+cMesToTrim(SubStr(TBGUIRE->(BD7_NUMLOT),5,2))
				If Empty(cMenTrimPag) .Or. cTrimPag < cMenTrimPag
					cIntKey		:= cInterKey
					cMenTrimPag := cTrimPag
					lExiProPag  := .T.
				EndIf
			EndIf
			//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
			//|Quando houver uma procedimento de alto custo amarrado a GIH, verifica se a data de alta e a mesma  |
			//|data de geracao do SIP,para contar a guia no SIP.                                                  |
			//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู            						
			If ! lExiProPag .And. ! Empty(TBGUIRE->B19_GUIA) 
				BE4->(dbSetOrder(1))
				If BE4->(dbSeek(xFilial("BE4")+Left(TBGUIRE->B19_GUIA,24))) 
					cMenTrimPag := Alltrim(Str(YEAR(BE4->BE4_DTALTA)))+cMesToTrim(StrZero(Month(BE4->BE4_DTALTA),2))
					cIntKey		:= Left(TBGUIRE->B19_GUIA,24)
					lExiProPag  := .T.
				EndIf                                    
			EndIf
			//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ			
			//|Acumulado o valor total da internacao.                                                                  |
			//|TBGUIRE->B19_GUIA, Indica que e um procedimento de alto custo e deve ser somado ao custo da internacao. |
			//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
			If 	(TBGUIRE->BD7_LIBERA <> "1" .And. TBGUIRE->BD7_FASE $ cFase .And. TBGUIRE->BD7_SITUAC $ cSituac .And. BD7_BLOPAG <>"1" ) .Or.;
				 ! Empty(TBGUIRE->B19_GUIA)
					//Somando o custo da interncao					
					If Empty(TBGUIRE->BD7_RECSIP)
						aadd(aProcRecon,TBGUIRE->RECNOBD7)
						nTotInt	+= TBGUIRE->BD7_VLRPAG
						lLogSomInt := .T.
					EndIf
			EndIf	 
			
			//Salvando o item para o log. 
			If lLogProc
				aadd(aLogDetGIH,{lLogSomInt,TBGUIRE->(BR8_CODPAD+BR8_CODPSA),TBGUIRE->BD7_VLRPAG,cBD7NumGuia})
			EndIf
					
			TBGUIRE->(dbSkip())
		EndDo
		TBGUIRE->(dbCloseArea())
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ					
		//|Verifica se o menor trimestre de pagamento e o mesmo de apuracao do SIP.        |
		//|Se nao existir pelo menos 1 procedimento pago a internacao nao foi reconhecida. |
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู		
		If lExiProPag .And. cMenTrimPag == cRecon
			aDadSIP := Array(15)
			//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
			//|Retornar os dados da internacao                              |
  		    //ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู					
			BE4->(dbSetOrder(1))
			If BE4->(dbSeek(xFilial("BE4")+cIntKey))
				//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
				//|Indica se devo verificar a data de alta antes de fazer a contabilizacao da internacao.		|
	  		    //ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู									
				If lCheckDtAlt .And. Empty(BE4->BE4_DTALTA) 
					cErrorMsg := "Aten็ใo; A GIH, "+cChave+", esta sem data de alta e nใo serแ enviada ao SIP.Origem:"+cAlias
					lEnviaGIH := .F.
				EndIf
				//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ				
				//|Guia Estornada nao conta para o SIP				  	        |
	  		    //ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู									
			  	If ! Empty(BE4->BE4_GUESTO)
					cErrorMsg := "Aten็ใo; A GIH,"+cGuiInt+", foi estornada e nใo serม enviada ao SIP."
					lEnviaGIH := .F.
				EndIf				

				If lEnviaGIH
					//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ				
					//|Definicao do codigo da CID usado para classificacao do item F. (Causas da Internacao)        |
		  		    //ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู													
					If Empty(cCIDIntProc) 
						cCIDIntProc := Iif(Empty(BE4->BE4_CIDREA),BE4->BE4_CID,GetDoeByCid(BE4->BE4_CIDREA))
						cCIDIntProc := Alltrim(cCIDIntProc)
					EndIf
					
					aDadSIP[GIH_GRP_INT] := BE4->BE4_GRPINT
					aDadSIP[GIH_REG_INT] := BE4->BE4_REGINT
					aDadSIP[GIH_DAT_INT] := BE4->BE4_DATPRO
					aDadSIP[GIH_HOR_INT] := BE4->BE4_HORPRO
					aDadSIP[GIH_HOR_ALT] := BE4->BE4_HRALTA
					aDadSIP[GIH_TIP_NAS] := BE4->BE4_TIPNAS
					aDadSIP[GIH_NAS_VIV] := BE4->(BE4_NASVIV+BE4_NASVPR)
					aDadSIP[GIH_RET_VIV] := Empty(BE4->BE4_NASSIP)
					aDadSIP[GIH_CID_INT] := cCIDIntProc
					aDadSIP[GIH_GUI_EST] := BE4->BE4_GUESTO
					aDadSIP[GIH_DAT_ALT] := BE4->BE4_DTALTA
					aDadSIP[GIH_VLR_INT] := nTotInt
					aDadSIP[GIH_GUI_PRI] := cIntKey
					//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
					//|Classificacao do Item E.                                     |
		  		    //ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
					If ! Empty(cSIP)
						cSIPInt	:= cSIP
					EndIf
					If Empty(cSIPInt)
						cSIPInt	:= (cAlias)->BR8_CLASP2
					EndIf					
					//
					aadd(aClasInt,{cSIPInt})

					//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
					//|Veririficacao do Item G,nascido vivo.                        |
		  		    //ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
					cSIPInt	  := cClaSipE(BE4->BE4_GRPINT,cSIPInt,cCIDIntProc,aClasInt,@lNasVivo,aDadSIP,BE4->BE4_DATNAS)
					aDadSIP[GIH_LNA_VIV] := lNasVivo
					
					//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
					//|Grava o BD7_RECSIP, para os procedimentos que foram reconhecidos para o SIP |
		  		    //ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
					If Left(cSIPInt,1) == "E"
						aDadSIP[GIH_CLA_SIP] := cSIPInt
						For nItePro := 1 to Len(aProcRecon)
							BD7->(dbGoTo(aProcRecon[nItePro]))
							BD7->(RecLock("BD7",.F.))
							BD7->BD7_RECSIP := cRecon
							BD7->(MsUnlock())
						Next nItePro
					Else
						cErrorMsg := "Aten็ใo; A GIH, " + cChave + ", nใo foi classificada como E."
						lEnviaGIH	:= .F.
					EndIf
				EndIf
			Else
				cErrorMsg := "Aten็ใo; Nใo foi possivel localizar a guia, " + cChave + ", no BE4.Origem:" + cAlias
				lEnviaGIH	:= .F.
			EndIf
		Else
			cErrorMsg := "Aten็ใo; A GIH, "+cChave+", estava fora do periodo de apura็ใo.Origem:"+cAlias
			lEnviaGIH	:= .F.
			cSIPInt		:= ""
		EndIf
		
		Aadd(aBufferInter,{cChave,lEnviaGIH,aDadSIP})
		
		If ! lEnviaGIH .And. ! Empty(cErrorMsg) 
			LogGih(cErrorMsg ,.F.)
		EndIf
	EndIf
	
Return lEnviaGIH

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณlClasSADT บAutor  ณPLS Team            บ Data ณ  17/09/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณAnalisa uma guia SADT e faz sua classificacao               บฑฑ
ฑฑบ          ณVerifica se a menor data de pagamento do procedimento da    บฑฑ
ฑฑบ          ณinternacao, e a mesma data de geracao do SIP.               บฑฑ
ฑฑบ          ณRetorna a classificacao principal do SIP, das guias de      บฑฑ
ฑฑบ          ณinternacao.                                                 บฑฑ
ฑฑบ          ณVerifica se a GIH, possui um procedimento OPME, amarrado a  บฑฑ
ฑฑบ          ณela.                                                        บฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณParametrosณExpC1: Alias da query esta sendo processada.                ณฑฑ
ฑฑณ          ณExpC2: Numero da guia de internacao.                        ณฑฑ
ฑฑณ          ณExpA1: Dados referentes a guia que esta sendo processada.   ณฑฑ
ฑฑณ          ณExpD1: Data de nascimento.                                  ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณRetorno   ณExpL1: Indica se a guia sera contabilizada no SIP.          ณฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function lClasSADT(cAlias,cChave,aClaSADT,dDatNas)
	Local cProRel 	:= ""
	Local cIteProc	:= ""
	Local cCodProc	:= ""
	Local cClaSip 	:= ""
	Local cTpCons 	:= "" 
	Local cTmpLogMsg:= ""
	Local cProType  := ""
	Local cCid		:= ""
	Local cCodEspMed:= ""
	Local cClaSipLog:= ""
	Local cErrorMsg	:= ""
	Local nQtdProc  := 0
	Local nVlrProc	:= 0	
	Local nVlMaiProc:= 0
	Local nProc		:= 0
	Local nSeek	    := 0
	Local lConsulta := .F.
	Local lEnviaSADT:= .T.
	Local lLogClaAC := .F.
	Local dDatProc 	:= dDataBase	
	Local aProcSADT := {}
	Local aProcRecon:= {} //Registra todos os procedimentos reconhecidos para grava็ใo no SIP.	
	Local aProcTmp	:= {}
	Local cDatProOco:= ""

	aClaSADT  := {}
	
	GrowGauge2("Analisando SADT:" + cChave + ". Aguarde...")
	/*ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	  ณLendo as PEGS...                   ณ
	  ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู*/
	While (cAlias)->(!Eof()) .And. cChave == (cAlias)->(BD7_CODOPE+BD7_CODLDP+BD7_CODPEG+BD7_NUMERO+BD7_ORIMOV)
		nQtdProc   	:= (cAlias)->(BD6_QTDPRO)
		cProRel 	:= (cAlias)->(BD6_PROREL)
		cCid 	 	:= (cAlias)->(BD6_CID)
		cCodEspMed	:= (cAlias)->(BD6_CODOPE+BD6_CODESP)
		cDatProOco  := cGetDTOcor(cAlias)		
		//
		cIteProc	:= (cAlias)->(BD7_CODOPE+BD7_CODLDP+BD7_CODPEG+BD7_NUMERO+BD7_ORIMOV+BD7_SEQUEN)
		cCodProc	:= (cAlias)->(BD7_CODPAD+BD7_CODPRO)
		dDatProc 	:= StoD((cAlias)->(BD7_DATPRO))
		//
		cClaSip 	:= (cAlias)->(BR8_CLASIP)
		cTpCons 	:= (cAlias)->(BR8_TPCONS)
		cProType 	:= (cAlias)->(BR8_TPPROC)
		nVlrProc	:= 0

		//Tratamento de procedimentos relacionados.
		If Empty(cProRel)
			lConsulta := PlsIsCon((cAlias)->BD7_CODPAD,(cAlias)->BD7_CODPRO)
			If cTipDtOco <> "1" .And. ! cAlias == REEMBOLSO
				nQtdProc := Iif(lPLS992RefAnt(cIteProc), 0 ,nQtdProc)
			EndIf			
		ElseIf (cAlias)->(BR8_TPPROC) == PROCEDIMENTO
			nQtdProc := 0
			BR8->(DbSetorder(3))
			If BR8->(DbSeek(xFilial("BR8")+cProRel)) .And. ! Empty(BR8->BR8_CLASIP)
				cClaSip := BR8->BR8_CLASIP
			Else
				PlsLogFil("Aten็ใo; Procedimento relacionado nใo localizado;"+cProRel,SipSadtLog)
			EndIf				
		EndIf

		//Verifica se o procedimento e uma consulta
		If Left(cClaSip,1) == "A" 
			lConsulta := .T.
		EndIf
				
		/*ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		  ณSomando o valor da composicao do procedimento  ณ
		  ณSoma os valores da composicao do procedimento  ณ
		  ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู*/
		While (cAlias)->(!Eof()) .And. cIteProc == (cAlias)->(BD7_CODOPE+BD7_CODLDP+BD7_CODPEG+BD7_NUMERO+BD7_ORIMOV+BD7_SEQUEN)
			
			If lPLS992Cpo
				nVlrProc += &(cAlias+"->"+cCampo)
			Else
				nVlrProc += (cAlias)->BD7_VLRPAG			
			EndIf
						
			aadd(aProcRecon,(cAlias)->RECNOBD7)	
			(cAlias)->(dbSkip())
		EndDo
		
		/*ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		  ณA.Consultas medicas.                				  			    	  ณ
		  ณB.Outros atendimentos ambulatoriais.									  ณ
		  ณC.Exames.                           									  ณ
		  ณD.Terapias.                         									  ณ
		  ณI.Procedimentos Odontologicos.      									  ณ
		  ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู*/
		If cProType == PROCEDIMENTO
			If lConsulta
				If cTpCons == "1"
					//Classificacao SIP da especialidade BAQ
					BAQ->(dbSetOrder(1))
					If BAQ->(DbSeek(xFilial("BAQ")+ cCodEspMed)) .And. ! Empty(BAQ->BAQ_ESPSP2)
						cClaSIP	:= BAQ->BAQ_ESPSP2
					EndIf
				EndIf
				
				If Empty(cClaSIP) 
					cClaSIP := PRO_SEM_CLA					
				EndIf
			ElseIf Left(cClaSIP,1) == "I"
				cClaSIP :=	cClaSipI(cClaSIP,cCid,dDatProc,dDatNas)
			Else
				cClaSIP :=	cClaSipNat(cClaSip,cClaSip,dDatNas,dDatProc)
			EndIf
	    ElseIf Empty(cClaSIP)
		    cClaSIP  := MAT_MED
		    nQtdProc := 0 
	    EndIf
		//Salva os procedimentos para analise da guia como um todo.
		aadd(aProcSADT,{.F.,cClaSIP,nVlrProc,nQtdProc,cIteProc,dDatProc,cCodProc,cProType,cDatProOco})
	EndDo
	GrowGauge2("Analisando a SADT:" + cChave + ". Aguarde...")
	
	/*ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	  ณTratamento das Consultas                       ณ
	  ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู*/
	lLogClaAC := lAnalProcAC(aProcSADT,aClaSADT,"A",cChave)

	/*ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	  ณTratamento dos Exames                          ณ
	  ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู*/
	lLogClaAC := lAnalProcAC(aProcSADT,aClaSADT,"C",cChave) .Or. lLogClaAC

	/*ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	  ณInsere os demais procedimentos da Guia.        ณ
	  ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู*/
	For nProc := 1 to Len(aProcSADT)
		If aProcSADT[nProc,PRO_CHECKED] == .F. .And. aProcSADT[nProc,PRO_TIPO] == PROCEDIMENTO .And.;
			 aProcSADT[nProc,PRO_CLA_SIP] != PRO_SEM_CLA
				AddProToSadt(aClaSADT,aProcSADT,nProc,Nil)
		EndIf
	Next nProc
	
	/*ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	  |Verifico se existe algum procedimento ou medicamento que nao foi somado na guia.     |
	  ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู*/   	
	nSeek := Ascan(aProcSADT, { |xProc| xProc[PRO_CHECKED] == .F. .And. Left(xProc[PRO_CLA_SIP],1)  != "A"})
	If nSeek > 0
		nSeekProc := 0
		nVlMaiProc:= 0
		//Localizo o procedimento ja classificado de maior valor para receber os valores nao classificados.
		For nProc := 1 to Len(aClaSADT)		
			If aClaSADT[nProc,SAD_CLA_SIP] != "A" .And.  aClaSADT[nProc,SAD_VLR_SIP] > nVlMaiProc
				nSeekProc	:= nProc
				nVlMaiProc	:= aClaSADT[nProc,SAD_VLR_SIP] 
			EndIf
		Next nProc
		
		If nSeekProc > 0
			For nProc := 1 to Len(aProcSADT)
				cProType := aProcSADT[nProc,PRO_CLA_SIP]
				If  aProcSADT[nProc,PRO_CHECKED] == .F. .And. (cProType == MAT_MED .Or. cProType == PRO_SEM_CLA)
					aClaSADT[nSeekProc,SAD_VLR_SIP] += aProcSADT[nProc,PRO_VLR_SIP]
					aProcSADT[nProc,PRO_CHECKED] := .T.
				EndIf
			Next		
		/*ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		  |Soma os itens que que nao sofreram classificacao de     |
		  |acordo com o paramentro (MV_SIPCGEN)                    |
		  ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู*/
		ElseIf ! Empty(cSipClaGen)
			For nProc := 1 to Len(aProcSADT)
				cProType := aProcSADT[nProc,PRO_CLA_SIP]
				If  aProcSADT[nProc,PRO_CHECKED] == .F. .And. (cProType == MAT_MED .Or. cProType == PRO_SEM_CLA)
					/*ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
					  |Como o item que esta sendo classificado nao e procedimento, a quantidade esta com zero.  |
					  |Por isto e necessario corrigir o item para contar como um procedimento.                  |
					  ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู*/					
					If aProcSADT[nProc,PRO_QTD_PRO] == 0
						aProcSADT[nProc,PRO_QTD_PRO] := 1
					EndIf
					AddProToSadt(aClaSADT,aProcSADT,nProc,cSipClaGen)
				EndIf
			Next nProc 
		EndIf
	EndIf
	
	/*ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	  ณVerificacao de erro guia com medicamentos sem procedimentos.         ณ
	  ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู*/   
	If Ascan(aProcSADT,{|xProc| xProc[PRO_CHECKED] == .F. }) > 0
		lEnviaSADT := .F.
		For nProc := 1 to Len(aProcSADT)
			cProType := aProcSADT[nProc,PRO_CLA_SIP]
			If aProcSADT[nProc,PRO_CHECKED] == .F.
				If (cProType == MAT_MED .Or. cProType == PRO_SEM_CLA)
					cErrorMsg := "Aten็ใo; A guia "+ cChave+ " contem um ou mais procedimento(s) invalido(s) para envio do SIP."
					Exit
				ElseIf Empty(cProType)
					cErrorMsg := "Aten็ใo; A guia "+ cChave+ " cont้m um ou mais procedimento em branco."
					Exit				
				Else
					cErrorMsg := "Aten็ใo; A guia "+ cChave+ " cont้m um procedimento que nใo foi classificado pelo SIP,a guia nใo serแ enviada."
					Exit				
				EndIf
			EndIf			
		Next nProc		
	EndIf	
		  
	If Len(aClaSADT) == 0 
		cErrorMsg := "Aten็ใo; A guia "+ cChave+ " nใo contem classifica็ใo valida para o SIP."
		lEnviaSADT := .F.
	EndIf

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณGrava a data de reconhecomento da SADT processada.                ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	If lEnviaSADT
		For nProc := 1 to Len(aProcRecon)
			BD7->(dbGoTo(aProcRecon[nProc]))
			BD7->(RecLock("BD7",.F.))
			BD7->BD7_RECSIP := cRecon
			BD7->(MsUnlock())
		Next nProc
	EndIf
	
	/*ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	  |Nao loga o erro se estiver filtrando a classificacao                 |
	  ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู*/   	
	If Empty(cIteLogGuia) .And. ! lEnviaSADT .And. ! Empty(cErrorMsg)
		PlsLogFil(cErrorMsg,SipSadtLog) 
		DetLogProc(aProcSADT,aClaSADT,Nil)
	ElseIf ! Empty(cIteLogGuia)
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณLog Gravacao das Guias        ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		For nProc := 1 to Len(aClaSADT)
			If lLogActive(cIteLogGuia,Alltrim(aClaSADT[nProc,SAD_CLA_SIP]))
				PlsLogFil("Informa็ใo; A classifica็ใo da Guia "+ cChave+ " foi gravada devido ao uso do parametro (MV_LSIPGUI) .",SipSadtLog)
				DetLogProc(aProcSADT,aClaSADT,Nil)
				Exit
		    EndIf
		Next	
	EndIf	

Return lEnviaSADT

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณlAnalProcAบAutor  ณPLS Team            บ Data ณ  30/12/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณAnalisa os procedimento de Consulta (cItemSip=A) e Exames   บฑฑ
ฑฑบ          ณ(cItemSip=C)                                                บฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณParametrosณExpA1: Contem os procedimentos que serao analisados.        ณฑฑ
ฑฑณ          ณExpA2: Retornara os dados da SADT, para gravacao no BZZ e   ณฑฑ
ฑฑณ          ณ       BZW.                                                 ณฑฑ
ฑฑณ          ณExpC1: Item que esta sendo analisado A=Consulta e C=Exames. ณฑฑ
ฑฑณ          ณExpC2: Numero da guia.                                      ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณRetorno   ณExpL1: Indica se deve ser logado a classificacao desta guia.ณฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function lAnalProcAC(aProcSADT,aClaSADT,cItemSip,cGuia)
	Local lExame   := Left(cItemSip,1) == "C"	
	Local lLogCla := .F.	
	Local nSeek    := 0 
	Local nProc    := 0
	Local nVlClaAtu:= 0
	Local nVlClaPro:= 0
	Local cProName := iif(lExame,"exame.","consulta.")
	Local cClaAtu  := ""
	Local cClaPro  := ""
	Local cProType := ""
	
	/*ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	  ณEncontra 1 procedimento com a classificacao solicitada.                               ณ
	  ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู*/
	nSeek := ascan( aProcSADT, { |xProc| Left(xProc[PRO_CLA_SIP],1) == cItemSip .And. xProc[PRO_CHECKED] == .F. })
	
	If nSeek > 0
		/*ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		  ณAdicionando procedimento a GUIA.               ณ
		  ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู*/
		AddProToSadt(aClaSADT,aProcSADT,nSeek)

		/*ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		  ณSoma os valores do medicamentos ao exame.      ณ
		  ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู*/
		If lExame
			//Verificar em qual item somar os custos de medicamentos e materias.
			nSeek := Ascan( aClaSADT, { |xPro| Left(xPro[SAD_CLA_SIP],1) == cItemSip})
			If nSeek > 0
				For nProc := 1 to Len(aProcSADT)
					cProType := aProcSADT[nProc,PRO_CLA_SIP]
					If  aProcSADT[nProc,PRO_CHECKED] == .F. .And. (cProType == MAT_MED .Or. cProType == PRO_SEM_CLA)
						aClaSADT[nSeek,SAD_VLR_SIP] += aProcSADT[nProc,PRO_VLR_SIP]
						aProcSADT[nProc,PRO_CHECKED] := .T.
					EndIf
				Next
			EndIf		
		Else
			/*ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
			  ณSe existir outro procedimento de consulta com classificacao repetida a guia pode estar fora do padrao.  ณ 
			  ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู*/
			nSeek := ascan( aProcSADT, { |xPro| Left(xPro[PRO_CLA_SIP],1) == cItemSip .And. Alltrim(xPro[PRO_CLA_SIP]) != PRO_SEM_CLA .And.;
												 xPro[PRO_CHECKED ] == .F. .And. xPro[PRO_TIPO] == PROCEDIMENTO })
			If nSeek > 0
			    nVlClaAtu := aTail(aClaSADT)[SAD_VLR_SIP]
				For nProc := 1 to Len(aProcSADT)
					cClaAtu  	:= Alltrim(aTail(aClaSADT)[SAD_CLA_SIP])
					cClaPro  	:= Alltrim(aProcSADT[nProc,PRO_CLA_SIP])
					nVlClaPro  	:= aProcSADT[nProc,PRO_VLR_SIP]

					If Left(cClaPro,1) == cItemSip .And. cClaAtu != PRO_SEM_CLA .And.;
						 aProcSADT[nProc,PRO_CHECKED] == .F. .And. aProcSADT[nProc,PRO_TIPO] == PROCEDIMENTO 
						/*ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
						  |Verifica qual e o procedimento que tem o maior valor para fazer a classificacao. |
						  ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู*/
						If nVlClaPro > nVlClaAtu
							aTail(aClaSADT)[SAD_CLA_SIP] := cClaPro
							nVlClaAtu  	:= nVlClaPro
						EndIf
						aTail(aClaSADT)[SAD_VLR_SIP] += nVlClaPro
						aProcSADT[nProc,PRO_CHECKED] := .T.
					EndIf
				Next  
				If lLogProRep
					PlsLogFil("Aten็ใo;A guia "+ cGuia+ " contem mais de um procedimento de " + cProName + "Seus valores foram somados e classificado como: "+ aTail(aClaSADT)[SAD_CLA_SIP],SipSadtLog)
					lLogCla := .T.
				EndIf
			EndIf			
		EndIf
	EndIf

Return lLogCla

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณAddProToSaบAutor  ณPLS-Team            บ Data ณ 18/01/2011  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณAdiciona um procedimento pre classficado ao array de retornoบฑฑ
ฑฑบ          ณde classificacao do SIP.                                    บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑณParametrosณExpA1: Contem os procedimentos classificados para o SIP.    ณฑฑ
ฑฑณ          ณExpA2: Contem os procedimentos que sera aficionados a matrizณฑฑ
ฑฑณ          ณ       aClaSADT.                                            ณฑฑ
ฑฑณ          ณExpN1: Item que sera adicionado.                            ณฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       |PLSA992                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function AddProToSadt(aClaSADT,aProcSADT,nItePro,cClaSip)
	Default cClasip := aProcSADT[nItePro,PRO_CLA_SIP]

	aadd(aClaSADT,{cClasip,;
					aProcSADT[nItePro,PRO_VLR_SIP],;
					aProcSADT[nItePro,PRO_QTD_PRO],;
					aProcSADT[nItePro,PRO_ITE_PRO],;
					aProcSADT[nItePro,PRO_DAT_PRO],;
					aProcSADT[nItePro,PRO_CODIGO],;  
					aProcSADT[nItePro,PRO_DAT_REF]})  

	//Marca o item como analisado					
	aProcSADT[nItePro,PRO_CHECKED] := .T.
	
Return .T.

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGrowGauge2บAutor  ณPLS-Team            บ Data ณ 18/01/2011  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRetorna a sintaxe In para montagem do comando SQL.          บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       |PLSA992                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function GrowGauge2(cMessage)

	If 	nQtdReg > 99
		BarGauge2Set(100)
		nQtdReg := 0
	Else
		IncProcG2(cMessage)	
		nQtdReg++
	EndIf	

Return .T.

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณlLogGIH   บAutor  ณPLS-Team            บ Data ณ 22/03/2011  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณDefine se uma guia esta sendo processada dever ser logada.  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       |PLSA992                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function lLogGIH(cGIHNum)
	Local lLog 	:= .F.
	Local cGIH	:= ""

	If ! Empty(cLogGIH)
		If "|" $ cLogGIH
			cGIH := Left(cGIHNum,24)+"|"
		Else
			If cLogGIH  != "ALL"
				cGIH := Left(cGIHNum,24)
			EndIf
		EndIf
	
		If cLogGIH  == "ALL" .Or. cGIH $ cLogGIH
			lLog := .T.
		EndIf
	EndIf
		
Return lLog	

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณlLogSaveVlบAutor  ณPLS-Team            บ Data ณ 22/03/2011  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณIndica se um item que esta sendo gravado no BZZ e BZW deve  บฑฑ
ฑฑบ          ณser gravado.                                                บฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณParametrosณExpC1: Parametro que sera verificado.                       ณฑฑ
ฑฑณ          ณExpC2: Classificacao que sera verificada.                   ณฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       |PLSA992                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function lLogActive(cParametro,cClaSip)
	Local lLogItem		:= .F.
	Local cClaSipLog 	:= ""

	If ! Empty(cParametro)	
		cClaSipLog := Alltrim(cClaSip)
		If "|" $ cParametro
			cClaSipLog := Alltrim(cClaSip)+"|"
		EndIf
	
		If cParametro  $ cClaSipLog .Or.cParametro == "ALL"
			lLogItem := .T.
		EndIf
	EndIf

Return lLogItem

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณDetLogProcบAutor  ณPLS-Team            บ Data ณ 18/01/2011  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณGrava o detalhamento do procedimento no arquivo de log.     บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       |PLSA992                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function DetLogProc(aProcSADT,aClaSADT,aDetInt)
	Local nProc 		:= 0
	Local cTmpLogMsg	:= ""

	Default aClaSADT	:= {} 
	Default aProcSADT	:= {}
	Default aDetInt		:= {}

	//Log da classificacao da guia
	If 	Len(aClaSADT) > 0
		PlsLogFil(Space(07)+"<1-Classifica็ใo SIP>",SipSadtLog) 	
	EndIf		
	For nProc := 1 to Len(aClaSADT)
		If nProc == 1
			cTmpLogMsg := Space(09) + "Proc.C๓d,;Proc.Clas.;Quantidade;Valor"
			PlsLogFil(cTmpLogMsg,SipSadtLog) 				
			cTmpLogMsg := Space(13)									
		Else
			cTmpLogMsg := Space(13)									
		EndIf
		cTmpLogMsg +=  Alltrim(aClaSADT[nProc,SAD_COD_PRO])
		cTmpLogMsg += ";" + Alltrim(aClaSADT[nProc,SAD_CLA_SIP])
		cTmpLogMsg += ";" + Alltrim(aClaSADT[nProc,SAD_QTD_PRO])
		cTmpLogMsg += ";" + Alltrim(Str(aClaSADT[nProc,SAD_VLR_SIP]))

		PlsLogFil(cTmpLogMsg,SipSadtLog) 
	Next nProc					
	//
	If 	Len(aProcSADT) > 0
		PlsLogFil(Space(07)+"<2-Composi็ใo da GUIA>",SipSadtLog)
	EndIf		
	For nProc := 1 to Len(aProcSADT)
		If nProc == 1
			cTmpLogMsg := Space(09) + "C๓digo;Tipo;Proc.Clas.;Valor;Quantidade"
			PlsLogFil(cTmpLogMsg,SipSadtLog) 				
			cTmpLogMsg := Space(13)												
		Else
			cTmpLogMsg := Space(13)		
		EndIf
		cTmpLogMsg += Alltrim(aProcSADT[nProc,PRO_CODIGO]	)
		cTmpLogMsg += ";" + Alltrim(aProcSADT[nProc,PRO_TIPO])
		cTmpLogMsg += ";" + Alltrim(aProcSADT[nProc,PRO_CLA_SIP])
		cTmpLogMsg += ";" + Alltrim(Str(aProcSADT[nProc,PRO_VLR_SIP]))
		cTmpLogMsg += ";" + Alltrim(Str(aProcSADT[nProc,PRO_QTD_PRO]))
		PlsLogFil(cTmpLogMsg,SipSadtLog) 
	Next nProc					
    //Log para a Internacao
	If 	Len(aDetInt) > 0
		PlsLogFil(Space(05)+"<1-Detalhe da interna็ใo>",SipGIHLog)
	EndIf
	For nProc := 1 to Len(aDetInt)
		If nProc == 1
			cTmpLogMsg := Space(08) + "Num.Guia;Somou;Cod.Proc.;Valor"
			PlsLogFil(cTmpLogMsg,SipGIHLog) 				
			cTmpLogMsg := Space(08)												
		Else
			cTmpLogMsg := Space(08)		
		EndIf
		cTmpLogMsg += Alltrim(aDetInt[nProc,04])
		cTmpLogMsg += ";" + iiF(aDetInt[nProc,01],"Sim","Nใo")
		cTmpLogMsg += ";" + Alltrim(aDetInt[nProc,02])
		cTmpLogMsg += ";" + Alltrim(Str(aDetInt[nProc,03]))
		PlsLogFil(cTmpLogMsg,SipGIHLog) 
	Next nProc
    
Return .T.

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGetInStameบAutor  ณPLS-Team            บ Data ณ 18/01/2011  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRetorna a sintaxe In para montagem do comando SQL.          บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       |PLSA992                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function GetInStament(cValue,cField)
	Local cStatement :=	"'"+StrTran(cValue, ";", "','")+"'"	

	If At(",",cStatement) > 0
		cStatement := cField+ " In (" + cStatement + ")"
	Else
		cStatement := cField+ " = " + cStatement  
	EndIf
	
Return cStatement

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณcGetDTOcorบAutor  ณPLS-Team            บ Data ณ 18/01/2011  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRetorna o trimestre de ocorrencia do procedimento.          บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       |PLSA992                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function cGetDTOcor(cAlias)
	Local cDtOcorre := cRecon
	Local cFldDtRef := cAlias+"->"
	Local cDatRef   := ""
	Local nRefer 	:= 0   	
	
	If cAlias == SADT_GIH
		If cTipDtOco == "1"
			cFldDtRef	+= "BD6_DTDIGI"	
		ElseIf cTipDtOco == "2"
			cFldDtRef	+= "BD7_NUMLOT"
		ElseIf cTipDtOco == "3"
			cFldDtRef	+= "BD7_DATPRO"
		EndIf		
		cDatRef		:= &cFldDtRef
		nRefer		:= Ascan( aPeriodos,{|xPer| xPer[1] == Substr(cDatRef,5,2) .Or. xPer[2] == Substr(cDatRef,5,2) .Or. xPer[3] == Substr(cDatRef,5,2)})
		cDtOcorre	:= Substr(cDatRef,1,4)+PadL(Alltrim(Str(nRefer)),2,"0")
	EndIf

Return cDtOcorre

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGoNextGuiaบAutor  ณPLS-Team            บ Data ณ 18/01/2011  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFaz um while na area atual ate chegar na proxima Guia.      บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       |PLSA992                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function GoNextGuia(cAlias,cChave)

	While (cAlias)->(!Eof()) .And. cChave == (cAlias)->(BD7_CODOPE+BD7_CODLDP+BD7_CODPEG+BD7_NUMERO+BD7_ORIMOV)
		(cAlias)->(dbSkip())
	End

Return (cAlias)->(!Eof())


/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณLogGih    บAutor  ณPLS-Team            บ Data ณ 18/01/2011  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRegistra um log referente ao processamento da internacao.   บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       |PLSA992                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function LogGih(cMsg,lForce)

	If Empty(cLogGIH) .Or. lForce
		PlsLogFil(cMsg ,SipGIHLog)
	EndIf
	
Return .T.

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณlChkIntGIHบAutor  ณPLS-Team            บ Data ณ 18/01/2011  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณVerifica se a gravacao do BZW e BZZ este de acordo.         บฑฑ
ฑฑบ          ณPara cada 1 BZZ deve ser gravado 2 BZW. Atencao somente     บฑฑ
ฑฑบ          ณpara interncao.                                             บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       |PLSA992                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function lChkIntGIH(cAlias,cSeekInt,nTotInt,cClaSip,aLogDetGIH)
	Local cStatement := ""
	Local aItemE	 := {}
	
	If lIntGIHLog
		cStatement += "Select 'BZW', SUM(BZW_QTDPRO) POR"
		cStatement += "				  from "+RetSqlName("BZW")
		cStatement += "				 WHERE BZW_FILIAL = '"+xFilial("BZW")+"'"
		cStatement += "			   AND BZW_CLASIP like 'E%'"
		cStatement += "			   AND BZW_PERIOD = '"+cRecon+"'"
		cStatement += "			   AND D_E_L_E_T_ = ' '   "
		cStatement += "			Union"
		cStatement += "			Select 'BZZ', SUM(BZZ_EVENTO) POR"
		cStatement += "			from "+RetSqlName("BZZ")
		cStatement += "			 WHERE BZZ_FILIAL = '"+xFilial("BZZ")+"'"
		cStatement += "			  AND BZZ_PERIOD = '"+cRecon+"'"
		cStatement += "			   AND (BZZ_ITEM = 'E')"
		cStatement += "			   AND D_E_L_E_T_ = ' '"
		cStatement := ChangeQuery(cStatement)
		dbUseArea(.T.,"TOPCONN",TCGENQRY(,,cStatement),"XTMP",.F.,.T.)

		XTMP->(dbgoTop())
		Do While ! XTMP->(Eof())
			aadd(aItemE,XTMP->POR)
			XTMP->(dbSkip())
		EndDo
		If Len(aItemE) > 0 .And. (aItemE[1]/2) <> aItemE[2]
			LogGih("Erro; Grava็ใo dos valores na BZZ e BZW esta comprometida :" + cSeekInt + ";Valor;"+Alltrim(Str(nTotInt))+";SIP;" + cClaSip ,.T.)
			DetLogProc(Nil,Nil,aLogDetGIH)					
			Alert("Integridade de valores entre o BZZ e BZW, esta comprometida.GIH :" + cSeekInt)
		EndIf
		XTMP->(DbCloseArea())
	EndIf
	
Return .T.
/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPLS992ExpoบAutor  ณMicrosiga           บ Data ณ  23/03/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function PLS992Expos()
	Local cSQL		:= ""
	Local nCont		:= 0
	Local nRegs		:= 0
	Local aTrimestre:= {}
	Local cAnoRef	:= ""
	Local dDataIni	:= StoD("")
	Local dDataFim	:= StoD("")
	Local dDataBlo	:= StoD("")
	Local nDiasPer	:= 0
	Local aBF0BKP	:= {}
	Local aCarBF0	:= {}
	Local aExposto	:= {}
	Local aExpTotal	:= {}
	Local aCritica	:= {}
	Local cTabBA1 := RetSQLName("BA1")
	Local cTabBA3 := RetSQLName("BA3")
	Local cTabBF0 := RetSQLName("BF0")
	Local cTabBCA := RetSQLName("BCA")
	Local cTabBR8 := RetSQLName("BR8")
	Local cTabBG8 := RetSQLName("BG8")
	Local cTabBFG := RetSQLName("BFG")
	Local cTabBFE := RetSQLName("BFE")
	Local cTabBFD := RetSQLName("BFD")
	Local cTabBFC := RetSQLName("BFC")
	Local cTabBT8 := RetSQLName("BT8")
	Local cTabBT7 := RetSQLName("BT7")
	Local cTabBB2 := RetSQLName("BB2")
	Local cTabBRV := RetSQLName("BRV")
	Local cTabBG9 := RetSQLName("BG9")
	Local cTabBT5 := RetSQLName("BT5")
	Local cFilBA1 := xFilial("BA1")
	Local cFilBA3 := xFilial("BA3")
	Local cFilBF0 := xFilial("BF0")
	Local cFilBCA := xFilial("BCA")
	Local cFilBR8 := xFilial("BR8")
	Local cFilBG8 := xFilial("BG8")
	Local cFilBFG := xFilial("BFG")
	Local cFilBFE := xFilial("BFE")
	Local cFilBFD := xFilial("BFD")
	Local cFilBFC := xFilial("BFC")
	Local cFilBT8 := xFilial("BT8")
	Local cFilBT7 := xFilial("BT7")
	Local cFilBB2 := xFilial("BB2")
	Local cFilBRV := xFilial("BRV")
	Local cFilBG3 := xFilial("BG3")
	Local cFilBG1 := xFilial("BG1")
	Local cFilBQU := xFilial("BQU")
	Local cFilBI3 := xFilial("BI3")
	Local cFilBAN := xFilial("BAN")
	Local cFilBDL := xFilial("BDL")
	Local cFilBT5 := xFilial("BT5")
	Local cFilBG9 := xFilial("BG9")
	Local cOpePad := PLSINTPAD()
	Local cCodSeg := ""
	Local cTpPlan := ""
	Local lPodeBR8:= .F.
	Local lGerarLog	:= GetNewPar("MV_PLLGEXP","0") == "1"
	Local cArqLog  	:= "pllgexp.log"
	Local nPos		:=	0
	
	Private cPerg	:= "SIPEXPOST"
	
	cAnoRef := mv_par01
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Carrega matriz de competencia, conforme ano referencia...			ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	aTrimestre :=	{ ;
						{StoD(cAnoRef+"0101"),StoD(cAnoRef+"0331"),cAnoRef+"01"},;
						{StoD(cAnoRef+"0401"),StoD(cAnoRef+"0630"),cAnoRef+"02"},;
						{StoD(cAnoRef+"0701"),StoD(cAnoRef+"0930"),cAnoRef+"03"},;
						{StoD(cAnoRef+"1001"),StoD(cAnoRef+"1231"),cAnoRef+"04"} ;
					}
	
	dDataIni := aTrimestre[mv_par02,1]
	dDataFim := aTrimestre[mv_par02,2]
	nDiasPer := dDataFim-dDataIni
	nTotFCar := 0
	nDiasFCar:= 0
	
	
	If lGerarLog
		MsgAlert("Atencao!!! Rotina esta logando os expostos em PLLGEXP.LOG")
	EndIf
	
	For nCont := 1 to 2
		
		If nCont == 1
			cSQL := " SELECT COUNT(BA1.R_E_C_N_O_) AS TOTREGS "
		Else
			cSQL := " SELECT BA1_CODINT, BA1_CODEMP, BA1_MATRIC, BA1_TIPREG, BA1_DATCAR, BA1_DATINC, BA1_DATNAS, BA1_DATBLO, BA1_SEXO, "
			cSQL += " BA3_CODPLA, BA3_VERSAO, BA1_CODPLA, BA1_VERSAO, BA1_CONEMP, BA1_VERCON, BA1_SUBCON, BA1_VERSUB, BA1_DIGITO, BG9_TIPO "
		EndIf
		
		cSQL += " FROM "+cTabBA1+" BA1, "+cTabBA3+" BA3, "+cTabBG9+" BG9 "
		cSQL += " WHERE BA1_FILIAL = '"+cFilBA1+"' "
		cSQL += "       AND BA1_OPEORI = '"+cOpePad+"' "
		
		cSQL += "       AND BA3_FILIAL = '"+cFilBA3+"' "
		cSQL += "       AND BA3_CODINT = BA1_CODINT "
		cSQL += "       AND BA3_CODEMP = BA1_CODEMP "
		cSQL += "       AND BA3_MATRIC = BA1_MATRIC "
		cSQL += "       AND BA1_INFANS = '1' "
		
		//cSQL += " AND BA3_CODEMP = '0003' "
	    cSQL += " AND BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG||BA1_DIGITO = '00010002040244009' "
		
		cSQL += "       AND BG9_FILIAL = '"+cFilBG9+"' "
		cSQL += "       AND BG9_CODINT = BA3_CODINT "
		cSQL += "       AND BG9_CODIGO = BA3_CODEMP "
		
		cSQL += "       AND BA1.D_E_L_E_T_ = ' ' "
		cSQL += "       AND BA3.D_E_L_E_T_ = ' ' "
		cSQL += "       AND BG9.D_E_L_E_T_ = ' ' "
		
		If nCont == 1
			TCQUERY cSQL NEW ALIAS "TRB"
			nRegs := TRB->TOTREGS
			TRB->(DbCloseArea())
		EndIf
		
	Next
	
	cSQL += " ORDER BY BA1_CODINT, BA1_CODEMP, BA1_MATRIC, BA1_TIPREG "
	
	TCQUERY cSQL NEW ALIAS "TRB"
	
	ProcRegua(nRegs)
	
	BDL->(DbSetOrder(1))
	BAN->(DbSetOrder(1))
	BI3->(DbSetOrder(1))
	
	nCont := 0
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Verifica se no fim do periodo o beneficiario estava bloqueado.        ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	cSQL := " SELECT BF0_CODSUP, BF0_CODIGO, BF0_NIVEL, BF0_IDADE1, BF0_IDADE2, BF0_SEXO "
	cSQL += " FROM "+cTabBF0+" BF0 "
	cSQL += " WHERE BF0_FILIAL = '"+cFilBF0+"' "
	cSQL += "       AND BF0_GRUGEN = '"+GetNewPar("MV_PLGRSIP","0001")+"' "
	cSQL += "       AND BF0_BENEF = '1' "
	cSQL += "       AND BF0.D_E_L_E_T_ = ' ' "
	cSQL += " ORDER BY BF0_CODIGO "
	
	TCQUERY cSQL NEW ALIAS "BF0QRY"
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Conforme os itens parametrizados no BF0, realizar checagem se os o 	  ณ
	//ณ campo de considera carencia (BR8_FCAREN) esta preenchido...        	  ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	While !BF0QRY->(Eof())
				
		//Por alguma razao desconhecida ocorreu um caso em que o trecho abaixo estava retornando .F. quando as strings eram diferentes  
		//Alltrim(BF0QRY->BF0_CODIGO) <> "A"
		
		//DEBUG do IDE no mesmo ponto e em sequencia: 
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณAlltrim(BF0QRY->BF0_CODIGO) <> "A"     ณ
		//ณ.F.                                    ณ
		//ณAlltrim(BF0QRY->BF0_CODIGO) != "A"     ณ
		//ณ.F.                                    ณ
		//ณAlltrim(BF0QRY->BF0_CODIGO) == "A"     ณ
		//ณ.F.                                    ณ
		//ณ!( Alltrim(BF0QRY->BF0_CODIGO) == "A" )ณ
		//ณ.T.                                    ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
				
		//If Alltrim(BF0QRY->BF0_CODIGO) <> "A" .And. BF0QRY->(BF0_IDADE1+BF0_IDADE2) == 0 .And. Empty(BF0QRY->BF0_SEXO)
		  
		If !(Alltrim(BF0QRY->BF0_CODIGO) == "A") .And. BF0QRY->(BF0_IDADE1+BF0_IDADE2) == 0 .And. Empty(BF0QRY->BF0_SEXO)
			cSQL := " SELECT COUNT(R_E_C_N_O_) AS QTDBR8 "
			cSQL += " FROM "+cTabBR8+" BR8 "
			cSQL += " WHERE BR8_FILIAL = '"+cFilBR8+"' "
			cSQL += "       AND BR8_FCAREN = '1' "
			cSQL += "       AND BR8_CLASIP = '"+Alltrim(BF0QRY->BF0_CODIGO)+"' OR BR8_CLASP2 = '"+Alltrim(BF0QRY->BF0_CODIGO)+"' "
			cSQL += "       AND D_E_L_E_T_ = ' ' "
			
			TCQUERY cSQL NEW ALIAS "TRBBR8"
			
			If TRBBR8->QTDBR8 == 0
				aadd(aCritica,{"Item do SIP sem nenhum c๓digo para benef. fora de car๊ncia! Item: "+Alltrim(BF0QRY->BF0_CODIGO),""})
			EndIf
			
			TRBBR8->(DbCloseArea())
		EndIf
		
		BF0QRY->(DbSkip())
	Enddo
	
	If Len(aCritica) > 0
		PLSCRIGEN(aCritica,{ {"Descri็ใo da crํtica","@C",300}},"Falhas na importacao impedem o calculo dos benef. fora de carencia!",.T.)
		If !MsgYesNo("Existem parametrizacoes nao realizadas para calculo dos benef. fora de carencia. Deseja continuar?")
			TRB->(DbCloseArea())
			BF0QRY->(DbCloseArea())
			Return
		EndIf
	EndIf
	
	BF0QRY->(DbGoTop())
	BF0->(DbSetOrder(3))
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Monta a matriz de BF0 conforme parametrizado na tabela de nat. saude  ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	While !BF0QRY->(Eof())
		
		//Caso seja um item sintetico, buscar todos as classificacoes possiveis...
		If BF0QRY->BF0_NIVEL < '3'
			BF0->(DbSeek(xFilial("BF0")+GetNewPar("MV_PLGRSIP","0001")+BF0QRY->BF0_CODIGO)) //BF0_FILIAL+BF0_GRUGEN+BF0_CODSUP+BF0_CODIGO
			While !BF0->(Eof()) .And. BF0->BF0_CODSUP == BF0QRY->BF0_CODIGO
				If aScan(aCarBF0,{|x| x[1] == BF0->BF0_CODIGO}) == 0
					aadd(aCarBF0,{BF0->BF0_CODIGO,0,CtoD(""),BF0->BF0_IDADE1, BF0->BF0_IDADE2,BF0->BF0_SEXO, BF0->BF0_NIVEL})
				EndIf
				BF0->(DbSkip())
			EndDo
		EndIf
		
		If aScan(aCarBF0,{|x| x[1] == BF0QRY->BF0_CODIGO}) == 0
			aadd(aCarBF0,{BF0QRY->BF0_CODIGO,0,CtoD(""),BF0QRY->BF0_IDADE1, BF0QRY->BF0_IDADE2, BF0QRY->BF0_SEXO, BF0QRY->BF0_NIVEL})
		EndIf
		BF0QRY->(DbSkip())
		
	Enddo
	
	aSort(aCarBF0,,,{|x,y| x[1] < y[1]})
	
	aBF0BKP := aClone(aCarBF0)
	//aExpTotal := aClone(aCarBF0)
	BF0QRY->(DbCloseArea())
	
	If lGerarLog
		PlsLogFil(Space(03)+"-> INICIO ROTINA: "+Time(),cArqLog)
	EndIf
	
	While !TRB->(Eof())
		
		nCont++
		dDataBlo := StoD(TRB->BA1_DATBLO)
		
		If lGerarLog
			PlsLogFil(Space(03)+"-> INICIO BENEFICIARIO "+Str(nCont)+"-"+TRB->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG)+" / "+AllTrim(Str(PlsHorIni(),10,3)),cArqLog)
			nHorIni := Seconds()
		EndIf
		
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณ Verifica se no fim do periodo o beneficiario estava bloqueado.        ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		cSQL := " SELECT BCA_TIPO, BCA_DATA, BCA_MOTBLO, BCA_NIVBLQ "
		cSQL += " FROM " + cTabBCA+" BCA "
		cSQL += " WHERE BCA_FILIAL = '"+cFilBCA+"' "
		cSQL += "       AND BCA_MATRIC = '"+TRB->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC)+"' "
		cSQL += "       AND BCA_TIPREG = '"+TRB->BA1_TIPREG+"' "
		cSQL += "       AND BCA_DATA >= '"+DtoS(aTrimestre[mv_par02,1])+"' "
		cSQL += "       AND BCA_DATA <= '"+DtoS(aTrimestre[mv_par02,2])+"' "
		cSQL += "       AND BCA_TIPO = '0' "
		cSQL += "       AND BCA.D_E_L_E_T_ = ' ' "
		cSQL += " ORDER BY BCA_DATA, R_E_C_N_O_"
		
		TCQUERY cSQL NEW ALIAS "BCAQRY"
		
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณ Processa historico de bloqueio                                        ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		While ! BCAQRY->(eof())
			lBlqAns := .F.
			Do Case
				Case BCAQRY->BCA_NIVBLQ == "U" // Nivel de Usuario
					If  BG3->(MsSeek(cFilBG3+BCAQRY->BCA_MOTBLO))
						If  ! empty(BG3->BG3_BLQANS)
							lBlqAns := .T.
						EndIf
					EndIf
				Case BCAQRY->BCA_NIVBLQ == "F" // Nivel de Familia
					If  BG1->(MsSeek(cFilBG1+BCAQRY->BCA_MOTBLO))
						If  ! empty(BG1->BG1_BLQANS)
							lBlqAns := .T.
						EndIf
					EndIf
				Case BCAQRY->BCA_NIVBLQ == "S" // Nivel de Sub-Contrato
					If  BQU->(MsSeek(cFilBQU+BCAQRY->BCA_MOTBLO))
						If  ! empty(BQU->BQU_BLQANS)
							lBlqAns := .T.
						EndIf
					EndIf
			EndCase
			If  lBlqAns
				dDataBlo := StoD(BCAQRY->BCA_DATA)
			Else
				dDataBlo := StoD("")
			EndIf
			BCAQRY->(dbSkip())
		EndDo
		BCAQRY->(DbCloseArea())
		
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณ Ignorar beneficiarios nao ativos no periodo...						  ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		If dDataBlo < dDataIni .And. !Empty(dDataBlo)
			TRB->(DbSkip())
			Loop
			
			If lGerarLog
				PlsLogFil(Space(03)+"-> BENEFICIARIO BLQ. FORA PERIODO - FIM / "+Str(nCont)+"-"+TRB->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG)+" / "+AllTrim(Str(PlsHorIni(),10,3)),cArqLog)
				nHorIni := Seconds()
			EndIf
			
		EndIf
		
		cOpeUsr := TRB->BA1_CODINT
		cCodEmp := TRB->BA1_CODEMP
		cNumCon := TRB->BA1_CONEMP
		cVerCon := TRB->BA1_VERCON
		cSubCon := TRB->BA1_SUBCON
		cVerSub := TRB->BA1_VERSUB
		cCodPro := Iif(Empty(TRB->BA1_CODPLA),TRB->BA3_CODPLA,TRB->BA1_CODPLA)
		cVerPro := Iif(Empty(TRB->BA1_VERSAO),TRB->BA3_VERSAO,TRB->BA1_VERSAO)
		cMatric := TRB->BA1_MATRIC
		cTipreg := TRB->BA1_TIPREG
		nIdade	:= Calc_Idade(dDataFim, StoD(TRB->BA1_DATNAS))
		cSexo	:= TRB->BA1_SEXO

		BI3->(DbSetOrder(1))		
		If BI3->(DbSeek(cFilBI3+cOpeUsr+cCodPro+cVerPro))
			lPodeBR8 := BI3->BI3_TODOS == "1"
			cCodSeg  := BI3->BI3_CODSEG
		EndIf
		
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณTIPO DE PLANO / CONTRATO                                     ณ
		//ณAnalisa o tipo de plano / contrato do usuario. As opcoes sao:ณ
		//ณ1 - Individual / Familiar                                    ณ
		//ณ2 - Coletivo Empresarial
		//ณ3-  Coletivo por Adesใo                                    ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		//cTpPlan := Iif(TRB->BG9_TIPO == "1","1",Alltrim(TRB->BT5_TIPCON))
		If TRB->BG9_TIPO == "1"
			cTpPlan := "1"
		Else
			//BT5_FILIAL + BT5_CODINT + BT5_CODIGO + BT5_NUMCON + BT5_VERSAO
			BT5->(DbSetOrder(1))		
			If BT5->(DbSeek(xFilial("BT5")+TRB->(BA1_CODINT+BA1_CODEMP+BA1_CONEMP+BA1_VERCON)))
				BII->(DbSetOrder(1))
				If BII->(DbSeek(xFilial("BII")+BT5->BT5_TIPCON))
					cTpPlan:= BII->BII_TIPPLA  
				EndIf
			EndIf
		EndIf 
		
		GrowGauge2("Aguarde... processando: "+cOpeUsr+"."+cCodEmp+"."+cMatric+"."+cTipReg)		
	
		//Consulta para obter os dados de cobertura/carencia, otimizado para o Exposto.
		cSQL := " SELECT BR8_CODPAD, BR8_CODPSA, BR8_CLASIP, BR8_CLASP2, BG8_CODGRU, BR8_REGATD, "
		cSQL += " BFG_CARENC, BFG_UNCAR,  BFG_CLACAR, BFG_DATCAR, BFG_BENUTL, "
		cSQL += " BFE_CODGRU, BFE_DATCAR, "
		cSQL += " BFD_CARENC, BFD_UNCAR, BFD_CLACAR, BFD_BENUTL, "
		cSQL += " BFC_CODGRU, "
		cSQL += " BT8_CARENC, BT8_UNCAR, BT8_CLACAR, BT8_BENUTL, "
		cSQL += " BT7_CARENC, BT7_UNCAR, "
		cSQL += " BB2_CARENC, BB2_UNCAR, BB2_CLACAR, BB2_BENUTL, "
		cSQL += " BRV_CODGRU,BG8_CARENC, BG8_UNCAR, BG8_CLACAR, BG8_BENUTL, "
		cSQL += " BR8_CARENC, BR8_UNCAR, BR8_CLACAR "
		
		cSQL += " FROM "+cTabBR8+" BR8 "
		//LIGAR DIRETAMENTE NO PROCEDIMENTO PARA OBTER OS GRUPOS DE COBERTURA DE CADA UM...
		cSQL += " LEFT OUTER JOIN "+cTabBG8+" BG8 "
		cSQL += " ON BG8_FILIAL = '"+cFilBG8+"' "
		cSQL += " AND BG8_CODPAD = BR8_CODPAD "
		cSQL += " AND BG8_CODPSA = BR8_CODPSA "
		cSQL += " AND BG8.D_E_L_E_T_ = ' ' "
		
		//COBERTURA NO USUARIO - PROCEDIMENTOS EXCLUSIVOS PARA O BENEFICIARIO
		cSQL += " LEFT OUTER JOIN "+cTabBFG+" BFG "
		cSQL += " ON BFG_FILIAL = '"+cFilBFG+"' "
		cSQL += " AND BFG_CODPAD = BR8_CODPAD "
		cSQL += " AND BFG_CODPSA = BR8_CODPSA "
		cSQL += " AND BFG_CODINT = '"+cOpeUsr+"' "
		cSQL += " AND BFG_CODEMP = '"+cCodEmp+"' "
		cSQL += " AND BFG_MATRIC = '"+cMatric+"' "
		cSQL += " AND BFG_TIPREG = '"+cTipReg+"' "
		cSQL += " AND BFG.D_E_L_E_T_ = ' ' "
		
		//GRUPO DE COBERTURA NO USUARIO
		cSQL += " LEFT OUTER JOIN "+cTabBFE+" BFE "
		cSQL += " ON BFE_FILIAL = '"+cFilBFE+"' "
		cSQL += " AND BFE_CODINT = '"+cOpeUsr+"' "
		cSQL += " AND BFE_CODEMP = '"+cCodEmp+"' "
		cSQL += " AND BFE_MATRIC = '"+cMatric+"' "
		cSQL += " AND BFE_TIPREG = '"+cTipReg+"' "
		cSQL += " AND BFE_CODGRU = BG8_CODGRU "
		cSQL += " AND BFE.D_E_L_E_T_ = ' ' "
		
		//COBERTURA FAMILIA - EXCLUSIVOS DE PROCEDIMENTOS NA FAMILIA...
		cSQL += " LEFT OUTER JOIN "+cTabBFD+" BFD "
		cSQL += " ON BFD_FILIAL = '"+cFilBFD+"' "
		cSQL += " AND BFD_CODINT = '"+cOpeUsr+"' "
		cSQL += " AND BFD_CODEMP = '"+cCodEmp+"' "
		cSQL += " AND BFD_MATRIC = '"+cMatric+"' "
		cSQL += " AND BFD_CODPAD = BR8_CODPAD "
		cSQL += " AND BFD_CODPSA = BR8_CODPSA "
		cSQL += " AND BFD.D_E_L_E_T_ = ' ' "
		
		//GRUPOS DE COBERTURA CONTIDOS NA FAMILIA...
		cSQL += " LEFT OUTER JOIN "+cTabBFC+" BFC "
		cSQL += " ON BFC_FILIAL = '"+cFilBFC+"' "
		cSQL += " AND BFC_CODINT = '"+cOpeUsr+"' "
		cSQL += " AND BFC_CODEMP = '"+cCodEmp+"' "
		cSQL += " AND BFC_MATRIC = '"+cMatric+"' "
		cSQL += " AND BFC_CODGRU = BG8_CODGRU "
		cSQL += " AND BFC.D_E_L_E_T_ = ' ' "
		
		//OBTEM PROCEDIMENTOS PARAMETRIZADOS EXCLUSIVOS NO CONTRATO/SUBCONTRATO
		cSQL += " LEFT OUTER JOIN "+cTabBT8+" BT8 "
		cSQL += " ON BT8_FILIAL = '"+cFilBT8+"' "
		cSQL += " AND BT8_CODINT = '"+cOpeUsr+"' "
		cSQL += " AND BT8_CODIGO = '"+cCodEmp+"' "
		cSQL += " AND BT8_NUMCON = '"+cNumCon+"' "
		cSQL += " AND BT8_VERCON = '"+cVerCon+"' "
		cSQL += " AND BT8_SUBCON = '"+cSubCon+"' "
		cSQL += " AND BT8_VERSUB = '"+cVerSub+"' "
		cSQL += " AND BT8_CODPRO = '"+cCodPro+"' "
		cSQL += " AND BT8_VERPRO = '"+cVerPro+"' "
		cSQL += " AND BT8_CODPAD = BR8_CODPAD "
		cSQL += " AND BT8_CODPSA = BR8_CODPSA "
		cSQL += " AND BT8.D_E_L_E_T_ = ' ' "
		
		//OBTEM GRUPOS DE COBERTURA EXCLUSIVOS DO CONTRATO/SUBCONTRATO
		cSQL += " LEFT OUTER JOIN "+cTabBT7+" BT7 "
		cSQL += " ON BT7_FILIAL = '"+cFilBT7+"' "
		cSQL += " AND BT7_CODINT = '"+cOpeUsr+"' "
		cSQL += " AND BT7_CODIGO = '"+cCodEmp+"' "
		cSQL += " AND BT7_NUMCON = '"+cNumCon+"' "
		cSQL += " AND BT7_VERCON = '"+cVerCon+"' "
		cSQL += " AND BT7_SUBCON = '"+cSubCon+"' "
		cSQL += " AND BT7_VERSUB = '"+cVerSub+"' "
		cSQL += " AND BT7_CODPRO = '"+cCodPro+"' "
		cSQL += " AND BT7_VERPRO = '"+cVerPro+"' "
		cSQL += " AND BT7_CODGRU = BG8_CODGRU "
		cSQL += " AND BT7.D_E_L_E_T_ = ' ' "
		
		//OBTEM CARENCIAS POR PROCEDIMENTO NO PRODUTO DO BENEFICIARIO
		cSQL += " LEFT OUTER JOIN "+cTabBB2+" BB2 "
		cSQL += " ON BB2_FILIAL = '"+cFilBB2+"' "
		cSQL += " AND BB2_CODIGO = '"+cOpePad+cCodPro+"' " //OPERADORA E PRODUTO
		cSQL += " AND BB2_VERSAO = '"+cVerPro+"' "
		cSQL += " AND BB2_CODPAD = BR8_CODPAD "
		cSQL += " AND BB2_CODPSA = BR8_CODPSA "
		cSQL += " AND BB2_BENUTL = '1' " //SOMENTE OS ATIVOS
		cSQL += " AND BB2.D_E_L_E_T_ = ' ' "
		
		//GRUPOS DE COBERTURA DO PRODUTO DO BENEFICIARIO...
		cSQL += " LEFT OUTER JOIN "+cTabBRV+" BRV "
		cSQL += " ON BRV_FILIAL = '"+cFilBRV+"' "
		cSQL += " AND BRV_CODPLA = '"+cOpePad+cCodPro+"' " //OPERADORA + PRODUTO
		cSQL += " AND BRV_VERSAO = '"+cVerPro+"' "
		cSQL += " AND BRV_CODGRU = BG8_CODGRU "
		cSQL += " AND BRV.D_E_L_E_T_ = ' ' "
		
		//LEMBRETE CASO O PRODUTO SEJA CONSIDERA PADRAO = SIM, DEVE-SE PEGAR TAMBEM COMO COBERTURA/CARENCIA OS DADOS DA BR8
		cSQL += " WHERE BR8_FILIAL = '"+cFilBR8+"' "
		cSQL += " AND (BR8_CLASIP <> ' ' OR BR8_CLASP2 <> ' ') "
		cSQL += " AND BR8_BENUTL = '1' "
		
		//CASO SEJA PARAMETRIZADO SOMENTE COM PROCEDIMENTOS, HABILITAR O PARAMETRO ABAIXO (MAIOR DESEMPENHO).
		If GetNewPar("MV_PLFCSOP","0") == "1"
			cSQL += " AND BR8_TPPROC = '0' "
		EndIf
		
		//CAMPO CRIADO PARA CONFIGURAR SE CONSIDERA OU NAO NO CALCULO DE BENEF FORA DE CARENCIA...
		cSQL += " AND BR8_FCAREN = '1' "
		//cSQL += " AND BR8_CODPSA IN ('81080042') "
		cSQL += " AND BR8.D_E_L_E_T_ = ' ' "
		
		TCQUERY cSQL NEW ALIAS "TRBCAR"
		
		nDiasCar	:= 0
		lTemCob		:= .F.
		dDatCar		:= StoD(TRB->BA1_DATCAR)
		nCarenc		:= 0
		cUnCar		:= ""
		cClaCar		:= ""
		
		While !TRBCAR->(Eof())
			
			cClaSip := Iif(TRBCAR->BR8_REGATD <> '2', TRBCAR->BR8_CLASIP, TRBCAR->BR8_CLASP2)
			nPos := aScan(aCarBF0,{|x| x[1] == cClaSip})
			
			//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
			//ณ Caso a classificacao seja grupo ou subgrupo, deve-se verificar se o   ณ
			//ณ item sera mais adequado por tratar-se de idade e sexo...              ณ
			//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
			If nPos > 0
				If aCarBF0[nPos,7] == '2'//Nivel
					
					cSQL := " SELECT BF0_CODIGO, BF0_IDADE1, BF0_IDADE2, BF0_SEXO "
					cSQL += " FROM "+cTabBF0+" BF0 "
					cSQL += " WHERE BF0_FILIAL = '"+cFilBF0+"' "
					cSQL += "       AND BF0_GRUGEN = '"+GetNewPar("MV_PLGRSIP","0001")+"' "
					cSQL += "       AND BF0_CODSUP = '"+cClaSip+"' "
					cSQL += "       AND BF0_NIVEL = '3' "
					cSQL += "       AND BF0_BENEF = '1' "
					cSQL += "       AND (BF0_IDADE1+BF0_IDADE2 > 0 OR BF0_SEXO <> ' ' ) "
					cSQL += "       AND BF0.D_E_L_E_T_ = ' ' "
					
					TCQUERY cSQL NEW ALIAS "TRBBF0"
					
					While !TRBBF0->(Eof())
						
						lIdade := ( TRBBF0->(BF0_IDADE1+BF0_IDADE2) == 0 ) .Or. ( nIdade > TRBBF0->BF0_IDADE1 .And. nIdade < TRBBF0->BF0_IDADE2 )
						lSexo := Empty(TRBBF0->BF0_SEXO) .Or. (cSexo == TRBBF0->BF0_SEXO)
						
						If lSexo .And. lIdade
							cClaSip := TRBBF0->BF0_CODIGO
							nPos := aScan(aCarBF0,{|x| x[1] == cClaSip})
							Exit
						EndIf
						
						TRBBF0->(DbSkip())
						
					EndDo
					TRBBF0->(DbCloseArea())
					
					//Caso seja um item, e nao tenha filtros, considero todos. Caso tenha algum filtro e
					//este filtro nao corresponder ao usuario, nao considerar o procedimento...
				Else
					
					lIdade := ( aCarBF0[nPos,4]+aCarBF0[nPos,5] == 0 ) .Or. ( nIdade > aCarBF0[nPos,4] .And. nIdade < aCarBF0[nPos,5] )
					lSexo := Empty(aCarBF0[nPos,6]) .Or. (cSexo == aCarBF0[nPos,6])
					
					If !lSexo .Or. !lIdade
						nPos := 0
					EndIf
				EndIf
			EndIf
			
			//So devera avaliar o proc. se estiver na arvore de subtotais...
			//Deve-se checar o nPos novamente devido a possibilidade de mudanca...
			If nPos > 0
				
				Do Case
					//Se encontrar parametrizacao para o procedimento, tem cobertura e ve a carencia...
					Case TRBCAR->BFG_BENUTL == "1"
						If !Empty(TRBCAR->BFG_UNCAR) .Or. !Empty(TRBCAR->BFG_DATCAR)
							nCarenc := TRBCAR->BFG_CARENC
							cUnCar  := TRBCAR->BFG_UNCAR
							cClaCar := TRBCAR->BFG_CLACAR
							dDatCar := StoD(TRBCAR->BFG_DATCAR)
						Else
							nCarenc := 0
							cUnCar  := "2"
							cClaCar := ""
						EndIf
						lTemCob	:= .T.
					//Se encontrar o grupo de cobertura no usuario, tem cobertura.
					Case !Empty(TRBCAR->BFE_CODGRU)
						dDatCar := StoD(TRBCAR->BFE_DATCAR)
						lTemCob := .T.
					//Se encontrar o grupo de cobertura na familia, tem cobertura.
					Case TRBCAR->BFD_BENUTL == "1"
						If !Empty(TRBCAR->BFD_UNCAR) .Or. !Empty(TRBCAR->BFD_CLACAR)
							nCarenc := TRBCAR->BFD_CARENC
							cUnCar  := TRBCAR->BFD_UNCAR
							cClaCar := TRBCAR->BFD_CLACAR
						Else
							nCarenc := 0
							cUnCar  := "2"
							cClaCar := ""
						EndIf
						lTemCob	:= .T.
					//Se encontrar o grupo de cobertura na familia, tem cobertura.
					Case !Empty(TRBCAR->BFC_CODGRU)
						lTemCob := .T.
					//Se encontrar o procedimentos no contrato/sub, tem cobertura...
					Case TRBCAR->BT8_BENUTL == "1"
						If !Empty(TRBCAR->BT8_UNCAR) .Or. !Empty(TRBCAR->BT8_CLACAR)
							nCarenc := TRBCAR->BT8_CARENC
							cUnCar  := TRBCAR->BT8_UNCAR
							cClaCar := TRBCAR->BT8_CLACAR
						Else
							nCarenc := 0
							cUnCar  := "2"
							cClaCar := ""
						EndIf
						lTemCob	:= .T.
					//Se encontrar o grupo de cobertura no contrato/sub, tem cobertura...
					Case !Empty(TRBCAR->BT7_UNCAR)
						nCarenc := TRBCAR->BT7_CARENC
						cUnCar  := TRBCAR->BT7_UNCAR
						lTemCob	:= .T.
					//Se encontrar parametrizacao diretamente no produto do usuario, tem cobertura e ve a carencia...
					Case TRBCAR->BB2_BENUTL == "1"
						
						If !Empty(TRBCAR->BB2_UNCAR) .Or. !Empty(TRBCAR->BB2_CLACAR)
							nCarenc := TRBCAR->BB2_CARENC
							cUnCar  := TRBCAR->BB2_UNCAR
							cClaCar := TRBCAR->BB2_CLACAR
						Else
							nCarenc := 0
							cUnCar  := "2"
							cClaCar := ""
						EndIf
						lTemCob	:= .T.
						
					//Se encontrar o grupo de cobertura no produto, tem cobertura.
					Case TRBCAR->BG8_BENUTL == "1"
						If !Empty(TRBCAR->BG8_UNCAR) .Or. !Empty(TRBCAR->BG8_CLACAR)
							nCarenc := TRBCAR->BG8_CARENC
							cUnCar  := TRBCAR->BG8_UNCAR
							cClaCar := TRBCAR->BG8_CLACAR
						Else
							nCarenc := 0
							cUnCar  := "2"
							cClaCar := ""
						EndIf
						lTemCob	:= .T.
						
					//Se encontrar o grupo de cobertura no produto, tem cobertura.
					Case (!Empty(TRBCAR->BR8_UNCAR) .Or. !Empty(TRBCAR->BR8_CLACAR)) .And. lPodeBR8
						nCarenc := TRBCAR->BR8_CARENC
						cUnCar  := TRBCAR->BR8_UNCAR
						cClaCar := TRBCAR->BR8_CLACAR
						lTemCob	:= .T.
						
				EndCase
				
				//Caso tenha cobertura, calcular os dias em carencia...
				If lTemCob
					
					If Empty(cUnCar) .Or. (! Empty(cClaCar) .And. lPodeBR8) 
						
						If BAN->(DbSeek(cFilBAN+cOpePad+cCodPro+cVerPro+cClaCar))
							nCarenc := BAN->BAN_QTDCAR
							cUnCar := BAN->BAN_UNCAR
						Else
							If BDL->(DbSeek(cFilBDL+cOpePad+cClaCar))
								nCarenc := BDL->BDL_CARENC
								cUnCar := BDL->BDL_UNCAR
							Else
								nCarenc := 0
								cUnCar := "2"
							EndIf
						EndIf
					EndIf
					
					If cUnCar $ "2,3,4" // Dias,Meses,Anos
						nDiasAux := PLSCarDias(nCarenc,cUnCar) // Calcula em dias
					Else
						nDiasAux := 1
					EndIf
					
					If Empty(aCarBF0[nPos,3])
						aCarBF0[nPos,2] := nDiasAux
						aCarBF0[nPos,3] := dDatCar
					Else
						If dDatCar+nDiasAux > aCarBF0[nPos,3]+aCarBF0[nPos,2]
							aCarBF0[nPos,2] := nDiasAux
							aCarBF0[nPos,3] := dDatCar
						EndIf
					EndIf
					
				EndIf
				
			EndIf
			
			TRBCAR->(DbSkip())
			lTemCob		:= .F.
			dDatCar		:= StoD(TRB->BA1_DATCAR)
			nCarenc		:= 0
			cUnCar		:= ""
			cClaCar		:= ""
			
		EndDo
		
		TRBCAR->(DbCloseArea())
		
		For nPos := 1 to Len(aCarBF0)
			
			//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
			//ณ Tratar a seguinte regra:															ณ
			//ณ 1-Caso a data de inicio do trimestre seja anterior a inclusao do beneficiario,		ณ
			//ณ   deve-se tratar a data de inclusao como data inicio do periodo.					ณ
			//ณ 2-Caso a data do bloqueio seja anterior a data final do trimestre, deve-se 			ณ
			//ณ  utilizar a data de bloqueio como data final do trimestre, para este beneficiario.	ณ
			//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
			dDataIni := IIf(aTrimestre[mv_par02,1] < StoD(TRB->BA1_DATINC),StoD(TRB->BA1_DATINC),aTrimestre[mv_par02,1])
			dDataFim := Iif(dDataBlo < aTrimestre[mv_par02,2],dDataBlo,aTrimestre[mv_par02,2])
			
			//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
			//ณAjustar datas se forem anteriores ou posteriores ao periodo de envio do SIP.ณ
			//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
			If dDataIni < aTrimestre[mv_par02,1]
				dDataIni := aTrimestre[mv_par02,1]
			EndIf
			If Empty(dDataFim) .Or. dDataFim > aTrimestre[mv_par02,2] .Or. dDataFim < dDataIni
				dDataFim := aTrimestre[mv_par02,2]
			EndIf
			
			nDiasCob := 0
			If !Empty(aCarBF0[nPos,3])
				nDiasCob := dDataFim-(aCarBF0[nPos,3]+aCarBF0[nPos,2])
				If nDiasCob > nDiasPer
					nDiasCob := dDataFim-dDataIni
				EndIf
				nDiasCob := Iif(nDiasCob > 0,nDiasCob, 0)
				
				SomaExpTot(@aExpTotal,aCarBF0[nPos,1],nDiasCob,cTpPlan,cCodSeg)
				
				//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
				//ณPreparar gravacao do beneficiario / class. sip e qtd de dias com cobertura. ณ
				//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
				If lGerarLog
					
					PlsLogFil(Space(03)+ " BENEF. - "+cOpeUsr+cCodEmp+cMatric+cTipReg+;
					" / CLASIP: "+aCarBF0[nPos,1]+;
					" Dt.Base:  "+DtoC(aCarBF0[nPos,3])+;
					" Dias Car: "+StrZero(aCarBF0[nPos,2],3)+;
					" Dias Cob: "+StrZero(nDiasCob,3)+" / "+;
					AllTrim(Str(PlsHorIni(),10,3)),cArqLog)
					nHorIni := Seconds()
				EndIf
				
				
				//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
				//ณCaso seja gravado o exposto para consultas, gravar tbm o item A cfme o para-ณ
				//ณmetro escolhido como item de despesa referencia para consultas.             ณ
				//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
				If Alltrim(aCarBF0[nPos,1]) == GetNewPar("MV_PLEXPCO","A2")
					
					SomaExpTot(@aExpTotal,"A"+Space(len(aCarBF0[nPos,1])-1),nDiasCob,cTpPlan,cCodSeg)
					
					If lGerarLog
						PlsLogFil(Space(03)+ " BENEF. - "+cOpeUsr+cCodEmp+cMatric+cTipReg+;
						" / CLASIP: "+"A"+;
						" Dt.Base:  "+DtoC(aCarBF0[nPos,3])+;
						" Dias Car: "+StrZero(aCarBF0[nPos,2],3)+;
						" Dias Cob: "+StrZero(nDiasCob,3)+" / "+;
						AllTrim(Str(PlsHorIni(),10,3)),cArqLog)
						nHorIni := Seconds()
					EndIf
					
				EndIf
			EndIf
			
		Next
		
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณColoco novamente o conteudo original de BF0 na matriz sem nova consulta...  ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		aCarBF0 := aClone(aBF0BKP)
		
		If lGerarLog
			PlsLogFil(Space(03)+"-> FINAL BENEFICIARIO "+Str(nCont)+"-"+cOpeUsr+cCodEmp+cMatric+cTipReg+" / "+AllTrim(Str(PlsHorIni(),10,3)),cArqLog)
			nHorIni := Seconds()
		EndIf
		
		TRB->(DbSkip())
		
	EndDo
	
	TRB->(DbCloseArea())
	
	cSQL := " DELETE FROM "+RetSQLName("BZZ")+" "
	cSQL += " WHERE BZZ_FILIAL = '"+xFilial("BZZ")+"' "
	cSQL += "       AND BZZ_GRPGER = '"+GetNewPar("MV_PLGRSIP","0001")+"' "
	cSQL += "       AND BZZ_PERIOD = '"+aTrimestre[mv_par02,3]+"' "
	cSQL += "       AND BZZ_REFERE = '"+aTrimestre[mv_par02,3]+"' "
	cSQL += "       AND BZZ_UF = 'FC' "
	cSQL += "       AND D_E_L_E_T_ = ' ' "
	
	TcSqlExec(cSQL)
	
	BF0->(DbSetOrder(1)) //BF0_FILIAL + BF0_GRUGEN + BF0_CODIGO
	For nPos := 1 to Len(aExpTotal)
		If BF0->(DbSeek(xFilial("BF0")+GetNewPar("MV_PLGRSIP","0001")+aExpTotal[nPos,1]))
			If BF0->BF0_BENEF == "1" //Verifica se o grupo totaliza beneficiarios...
				BZZ->(RecLock("BZZ",.T.))
				BZZ->BZZ_FILIAL	:= xFilial("BZZ")
				BZZ->BZZ_GRPGER	:= GetNewPar("MV_PLGRSIP","0001")
				BZZ->BZZ_PERIOD	:= aTrimestre[mv_par02,3]
				BZZ->BZZ_UF		:= "FC"
				BZZ->BZZ_ITEM	:= aExpTotal[nPos,1]
				BZZ->BZZ_BENEFI	:= Int(aExpTotal[nPos,2]/nDiasPer)
				BZZ->BZZ_REFERE	:= aTrimestre[mv_par02,3]
				BZZ->BZZ_TIPPLA := aExpTotal[nPos,3]
				BZZ->BZZ_CODSEG := aExpTotal[nPos,4]
				BZZ->(MsUnlock())
			EndIf
		EndIf
	Next
	
	If lGerarLog
		PlsLogFil(Space(03)+"-> FINAL ROTINA: "+Time(),cArqLog)
	EndIf

Return .T.

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณSomaExpTotบAutor  ณJean Schulz         บ Data ณ  31/05/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณSoma o total de dias ao que ja foi calculado anteriormente  บฑฑ
ฑฑบ          ณnos demais beneficiarios...                                 บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function SomaExpTot(aExpTot,cClaSip,nDiasCob,cTpPlan,cCodSeg)
	Local nPos := 0
	
	nPos := aScan(aExpTot,{|x| x[1]+x[3]+x[4] == cClaSip+cTpPlan+cCodSeg})
	
	If nPos > 0
		aExpTot[nPos,2] += nDiasCob
	Else
		AADD(aExpTot,{cClaSip,nDiasCob,cTpPlan,cCodSeg})
	EndIf
	
Return .T.

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณChangeBZZNบAutor  ณMicrosiga           บ Data ณ  07/03/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณPonto de entrada para tratar o codigo de classificacao SIP  บฑฑ
ฑฑบ          ณpara a tabela BZZ                                           บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
Static Function ChangeBZZNature(cNature,cDtOcorre,cUF,cTpPlan,cSegmen)
	Local cAlterNature:=	cNature

	If lDoBzzNat
		cAlterNature := ExecBlock("PL992CNAT",.F.,.F.,{cGrpGer,cNature,cRecon,cDtOcorre,cUF,cTpPlan,cSegmen})
		If Empty(cAlterNature)   
			cAlterNature:= cNature
		EndIf		
	EndIf

Return Alltrim(cAlterNature)
*/

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณlExecutaCaบAutor  ณPLS Team            บ Data ณ  26/08/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณVerifique se ja existe calculo para o periodo requisitado.  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function lExecutaCalc()
	Local lExiste		:=	.T.
	Local cStatement	:= ""	
	
	cStatement	+= 	"	Select Count(BZZ_PERIOD) BZZ_PERIOD "
	cStatement	+= 	"	From " + RetSqlName("BZZ")
	cStatement	+= 	"       	Where		BZZ_PERIOD = '"+cRecon+"'"
	cStatement	+=	"	 		And 	"+RetSqlName("BZZ")+".D_E_L_E_T_ = ' ' "

	cStatement 	:= ChangeQuery(cStatement)
	dbUseArea(.T.,"TOPCONN",TCGENQRY(,,cStatement),"TABSEG",.F.,.T.)
	
	If ! TABSEG->(Eof()) .And. TABSEG->BZZ_PERIOD > 0
		lExiste	:=	MsgYesNo("Aten็ใo! Existem valores para o perํodo selecionado."+Chr(13)+"Deseja gerar os valores novamente?")
	EndIf
                   
	TABSEG->(dbCloseArea())
	
Return lExiste

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณR992DIRECTบAutor  ณPLS Team            บ Data ณ  07/03/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao usada no pergunte.                                   บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function R992Direct(cCPO)
	Local cRET	:=	cGetFile(,"Selecione o diretorio",,"",.T.,GETF_LOCALFLOPPY+GETF_LOCALHARD+128)

	&(cCPO) 		:= cRET
	
	Iif( 1 < 0,R992Direct("XX"),"")//Retira o Warning de compilacao	

Return (!Empty(cRET))

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณcMesToTrimบAutor  ณPLS Team            บ Data ณ  30/12/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRetorna  o trimestre a apartir de um mes passado.           บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function cMesToTrim(cMes)
	Local cTrimestre 	:= "00"
	Local nMes			:=	1
	
	For nMes := 1 To 3
		cTrimestre := StrZero(aScan(aPeriodos, {|X| Alltrim(X[nMes]) == cMes }),2)
		If cTrimestre <> "00"
			Exit
		EndIf
	Next
			
Return cTrimestre

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณParseToDB บAutor  ณPLS-Team            บ Data ณ 18/01/2011  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณTrata a concatenacao de campo em banco diferente de MSSQL.  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       |PLSA992                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function ParseToDB(cStatement)
	Local cNewStat := cStatement

	If TCGetDB() != "MSSQL"
        cNewStat := StrTran(cStatement, "+", " || ")
	EndIf
	
Return cNewStat

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณPrograma   ณ CriaSX1   ณ Autor ณ Microsiga - PLS      ณ Data ณ 27.01.06 ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescricao  ณ Atualiza SX1                                               ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ*/
Static Function CriaSX1()
	Local aHelpPor := {}
	
	If SX1->(Dbseek(PADR('PLSA992',10)+'06')  .And. Empty(SX1->X1_F3) )
		SX1->(Reclock('SX1',.F.))
		SX1->(dbdelete())
		SX1->(MsUnlock())
	EndIf

	PutSx1( cPerg, "01", "Ano de Referencia ?","Ano de Referencia ?","Ano de Referencia ?","mv_ch1","C",4,0,2,"G","","","","","mv_par01","","","","","","","","","","","","","","","","",,,,".PLSA9921.")
	PutSx1( cPerg, "02", "Periodo de Referencia?","Periodo de Referencia?","Periodo de Referencia?","mv_ch2","N",1,0,2,"C","","","","","mv_par02","1บ Trimestre"," ","","","2บ Trimestre","","","3บ Trimestre","","","4บ Trimestre","","","","","",,,,".PLSA9922.")
	PutSx1( cPerg, "03", "Eventos/Despesa?","Eventos/Despesa?","Eventos/Despesa?","mv_ch3","N",1,0,2,"C","","","","","mv_par03","Gerar","Gerar","Gerar","","Atualizar","Atualizar","Atualizar","Nใo processar","Nใo processar","Nใo processar","","","","","","",,,,".PLSA9923.")
	PutSx1( cPerg, "04", "Agrupar por UF?","Agrupar por UF ?","Agrupar por UF ?","mv_ch4","N",1,0,2,"C","","","","","mv_par04","Sim","Si ","Yes","","Nao","No","No","","","","","","","","","",,,,".PLSA9924.")
	PutSx1( cPerg, "05", "Gerar XML ? ","Gerar XML ?","Gerar XML ?","mv_ch5","N",1,0,2,"C","","","","","mv_par05","Sim","Si ","Yes","","Nao","No","No","","","","","","","","","",,,,".PLSA9925.")
	PutSx1( cPerg, "06", "Diretorio para XML ","Diretorio para XML ","Diretorio para XML ","mv_ch6","C",25,0,2,"G","","R992DI","","","mv_par06",""," ","","","","","","","","","","","","","","",,,,".PLSA9926.")
	PutSx1( cPerg, "07", "Calcular Expostos ? ","Calcular Expostos ? ","Calcular Expostos ? ","mv_ch7","N",1,0,2,"C","","","","","mv_par07","Sim","Si ","Yes","","Nao","No","No","","","","","","","","","",,,,".PLSA9927.")
	
	aHelpPor := {"Ano de processamento."}
	PutSX1Help("P.PLSA9921.",aHelpPor,{},{})
	
	aHelpPor := {"Trimestre de processamento."}
	PutSX1Help("P.PLSA9922.",aHelpPor,{},{})
	
	aHelpPor := {"Tipo do calculo."}
	PutSX1Help("P.PLSA9923.",aHelpPor,{},{})
	
	aHelpPor := {"Indica se deve separar os resultados ","por Unidade Federativa."}
	PutSX1Help("P.PLSA9924.",aHelpPor,{},{})

	aHelpPor := {"Gerar o XML, para envio a ANS?"}
	PutSX1Help("P.PLSA9925.",aHelpPor,{},{})

	aHelpPor := {"Informe o diret๓rio para grava็ใo","do XML."}
	PutSX1Help("P.PLSA9926.",aHelpPor,{},{})

	aHelpPor := {"Calcular os expostos?"}
	PutSX1Help("P.PLSA9927.",aHelpPor,{},{})

	AjustaSX1()

Return .T.               

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัอออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณAjustaSX1 บAutor  ณThiago Machado Correaบ Data ณ  24/08/04   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯอออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณCria o pergunte padrao                                       บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                          บฑฑ
ฑฑศออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function AjustaSX1()
	Local cQuestion 	:=	 Padr(cPerg,10," ")
                           
	If SX1->(DbSeek(cQuestion+"03")) 
		SX1->(RecLock("SX1",.F.))
		SX1->X1_PERGUNT		:= "Evento/Despesa?"
		SX1->X1_DEF01		:= "Gerar"
		SX1->X1_DEF02		:= "Atualizar"
		SX1->X1_DEF03		:= "Nใo processar"
		SX1->(MsUnLock())
	EndIf

	If SX1->(DbSeek(cQuestion+"05")) .And. ! Empty(SX1->(X1_DEF03))
		SX1->(RecLock("SX1",.F.))
		SX1->X1_DEF03	:= ""		
		SX1->(MsUnLock())
	EndIf
	
	If SX1->(DbSeek(cQuestion+"07")) .And. ! Empty(SX1->(X1_DEF03))
		SX1->(RecLock("SX1",.F.))
		SX1->X1_DEF03	:= ""
		SX1->(MsUnLock())
	EndIf 
		
Return .T.

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณP992CriaSXบAutor  ณMicrosiga           บ Data ณ  07/03/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณCria o grupo de perguntas no SXB.                           บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function P992CriaSXB()
	Local aReg := {}
	Local i := 0
	Local j := 0
	Local cXB_ALIAS := "R992DI"
	
	aAdd(aReg,{cXB_ALIAS,"1","01","RE","DIRETORIO","DIRECTORIO","DIRECTORY","SX5"})
	aAdd(aReg,{cXB_ALIAS,"2","01","01","","","","R992DIRECT(READVAR())"})
	aAdd(aReg,{cXB_ALIAS,"5","01",""  ,"","","","M->&(READVAR())"})
	aAdd(aReg,{"XB_ALIAS","XB_TIPO","XB_SEQ","XB_COLUNA","XB_DESCRI","XB_DESCSPA","XB_DESCENG","XB_CONTEM"})
	
	dbSelectArea("SXB")
	dbSetOrder(1)
	
	For i:=1 to Len(aReg)-1
		If !dbSeek(aReg[i,1]+aReg[i,2]+aReg[i,3]+aReg[i,4])
			RecLock("SXB",.T.)
			For j:=1 to Len(aReg[i])
				FieldPut(FieldPos(aReg[Len(aReg)][j]),aReg[i,j])
			Next j
			MsUnlock()
		EndIf
	Next i

Return .T.