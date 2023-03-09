
#INCLUDE "PROTHEUS.CH"  
#INCLUDE "TOPCONN.CH"  
#INCLUDE "UTILIDADES.CH" 
#INCLUDE 'PARMTYPE.CH'
#INCLUDE 'TBICONN.CH'
#INCLUDE 'RWMAKE.CH'
#INCLUDE 'FONT.CH'
#INCLUDE 'COLORS.CH' 

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ CABA619  ºAutor  ³Fabio Bianchini     º Data ³  28/12/2019 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina criada para Gerar Relatório Excel que fará conferen- º±±
±±º          ³cia dos saldos remanescentes e coparts apuradas da CMB      º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³CABERJ                                                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function CABA619()

	Local _aArea 		:= GetArea()
	Private _cPerg		:= "CABA619"  ////montar pergunte que atenda aos arquivos e relatorio
	Private cCodemp	:= ""
	Private cNumFat	:= ""
	Private cMes	:= ""
	Private cAno	:= ""
	Private nConfere:= 0
	Private cPath	:= "\\srvdbp\backup\utl\" //Onde a Procedure le o arquivo de carga
	Private	cDataFatTMP := " "
	Private	cMesFt		:= " "
	Private	cAnoFt		:= " "
	
	If cEmpAnt == '02'
	
		Aviso("Atenção","Função Exclusiva para CMB (0325 - INTEGRAL).",{"OK"})
	
		CABA619A(_cPerg)
	
		If Pergunte(_cPerg,.T.)
	
			//If !(Empty(AllTrim(MV_PAR01))) .and. !(Empty(AllTrim(MV_PAR02))) .and. !(Empty(AllTrim(MV_PAR03))) .and. !(Empty(AllTrim(MV_PAR04)))

				cNumFat  := MV_PAR01
				cMes	 := MV_PAR02
				cAno	 := MV_PAR03
				nConfere := MV_PAR04
	
	
				cDataFatTMP := DTOS(MonthSub(STOD(cAno + cMes + '01'),1))
				cMesFt		:= SUBS(cDataFatTMP,5,2)
				cAnoFt		:= SUBS(cDataFatTMP,1,4)
		
				If MsgYesNo("Confirma a Geração da Planilha de Conferencia?")
					
					Processa({||ExcelCMB()},'Processando Planilha...')
				
				Endif
				
				If nConfere == 1  //Somente Subcontratos de folha
				
					If MsgYesNo("Confirma a Geração dos Arquivos para Envio À CMB?")
				
						Processa({||GeraArqCMB()},'Processando...')
				
					Endif
				
				Else
					
					Aviso("Atenção","Somente é possível Gerar arquivos CMB para Conferência do Tipo FOLHA.",{"OK"})
				
				Endif
		
			//Else
	
			//	Aviso("Atenção","Favor preencher todos os parâmetros.",{"OK"})
	
			//EndIf
	
		EndIf
	
	Else
	
		Aviso("Atenção","Função Disponível SOMENTE na Operador INTEGRAL SAÚDE.",{"OK"})
	
	Endif

	RestArea(_aArea)

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABA619A  ºAutor  ³Fabio Bianchini     º Data ³  28/12/2019 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina responsavel pela geração das perguntas no relatório  º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function CABA619A(cPerg)

	Local aHelpPor := {} //help da pergunta

	aHelpPor := {}
	AADD(aHelpPor,"Geração de Relatório Excel e	")
	AADD(aHelpPor,"arquivos para desconto em folha CMB ")	

	PutSx1(cPerg,"01",OemToAnsi("Lote Cobr.: ")		,"","","mv_ch0","C",012,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","",aHelpPor,{},{})
	PutSx1(cPerg,"02",OemToAnsi("Mes: ")			,"","","mv_ch1","C",002,0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","",aHelpPor,{},{})
	PutSx1(cPerg,"03",OemToAnsi("Ano: ")			,"","","mv_ch2","C",004,0,0,"G","","","","","mv_par03","","","","","","","","","","","","","","","","",aHelpPor,{},{})
	PutSx1(cPerg,"04",OemToAnsi("Conferir: ")		,"","","mv_ch3","C",001,0,0,"C","","","","","mv_par04","1-Lista Folha","","","","2-Lista Art.30","","","3-Ambos","","","","","","","","",aHelpPor,{},{})
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ExcelCMB  ºAutor  ³Microsiga           º Data ³  19/12/19   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina para gerar extrato de conferência em Excel           º±±
±±º          ³															  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function ExcelCMB()

	Private cMsg		:= ""
	Private lAbortPrint := .F.
	Private cTitulo     := "Relatório de Conferencia de Coparticipação CMB "        
	Private aCabec1		:= {"MATRICULA ","ORIGEM ","NOME_BENEFICIARIO ","DATA ","TIPO ","TIPO_EVENTO ","PRESTADOR ","PROCEDIMENTO ","VALOR_PARTICIPACAO ","REFERENCIA_COB " }
	Private aDados1     := {} 
	
	cMsg += " Este programa tem por finalidade possibilitar a conferência de coparts da CMB - Integral (Grupo Empresa 0325) " + CRLF
	cMsg += "  " + CRLF

	lexcel	   := .T.    

	Processa({||Processa1()}, cTitulo, "", .T.)

	if lexcel      

		DlgToExcel({{"ARRAY","EXTRATO DE CONFERÊNCIA - CMB " ,aCabec1,aDados1}})   

	EndIF

	MsgInfo("Processo finalizado")

Return                 

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³Processa1 ºAutor  ³Microsiga           º Data ³  19/12/19   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina para executar a query						          º±±
±±º          ³															  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function Processa1()

	Local i := 0

	Local dDatIni     := CtoD("  /  /    ")
	Local dDtInicial  := CtoD("  /  /    ")
	Local aCriticas   := {}
	Local cSQL		  := ""
	Local cAliastmp   := GetNextAlias() 
	Local cTmpData	  := ""
	Local cTmpValor	  := ""
	Private nContador := 0

	//MsgRun("Selecionando Registros...",,{|| BuscaRegs(),CLR_HBLUE})
	MsgRun("Selecionando Registros...",,{|| ,CLR_HBLUE})

	cSQL := " SELECT 													" + CRLF
	//cSQL += "        SUBSTR(TRIM(U.BA1_MATEMP),-8,11) MATRICULA,		" + CRLF
	cSQL += "        CASE												" + CRLF
    cSQL += "            WHEN SUBSTR(TRIM(U.BA1_MATEMP),-8,11) IS NULL	" + CRLF
    cSQL += "            THEN TRIM(U.BA1_MATEMP)						" + CRLF
    cSQL += "            ELSE SUBSTR(TRIM(U.BA1_MATEMP),-8,11)			" + CRLF
    cSQL += "        END MATRICULA,										" + CRLF
	cSQL += "        decode(U.BA1_TIPUSU,'T','1','D',2,'A',3) ORIGEM,	" + CRLF           
	cSQL += "        TRIM(U.BA1_NOMUSR) NOME_BENEFICIARIO ,				" + CRLF
	cSQL += "        TO_DATE(BD6_DATPRO,'YYYYMMDD') DATA,				" + CRLF
	cSQL += "        'ATENDIMENTOS' TIPO,								" + CRLF
	cSQL += "        RETORNA_EVENTO_ANSRES389(BD6_YNEVEN) TIPO_EVENTO,	" + CRLF
	cSQL += "        NVL( TRIM(BAU_NFANTA),TRIM(BAU_NOME))  PRESTADOR,	" + CRLF
	cSQL += "        TRIM(UPPER(BD6_DESPRO)) PROCEDIMENTO,				" + CRLF
	cSQL += "        BD6_VLRTPF VALOR_PARTICIPACAO,						" + CRLF
	cSQL += "        SE1020T.E1_ANOBASE||SE1020T.E1_MESBASE REFERENCIA_COB,	" + CRLF
	cSQL += "        TRIM(U.BA1_CPFUSR) CPF_BENEFICIARIO 				" + CRLF
	cSQL += "   FROM "+RetSqlName("BD6")+" BD6 "  						+ CRLF
	cSQL += "      , "+RetSqlName("BA1")+" U "  						+ CRLF    
	cSQL += "      , "+RetSqlName("SE1")+" SE1020T "  					+ CRLF
	cSQL += "      , "+RetSqlName("BAU")+" BAU "  						+ CRLF  
	cSQL += "  WHERE U.BA1_FILIAL  		= '"+xFilial("BA1")+"'		  " + CRLF
	cSQL += "    AND BD6_FILIAL    		= '"+xFilial("BD6")+"'		  " + CRLF
	cSQL += "    AND BAU_FILIAL    		= '"+xFilial("BAU")+"'		  " + CRLF
	cSQL += "    AND SE1020T.E1_FILIAL 	= '"+xFilial("SE1")+"'		  " + CRLF
	cSQL += "    AND E1_PREFIXO   = BD6_PREFIX  					  "	+ CRLF
	cSQL += "    AND E1_NUM       = BD6_NUMTIT  					  "	+ CRLF
	cSQL += "    AND E1_PARCELA   = BD6_PARCEL  					  "	+ CRLF
	cSQL += "    AND E1_TIPO      = BD6_TIPTIT  					  "	+ CRLF
	cSQL += "    AND U.BA1_CODINT = '"+PLSINTPAD()+"'  				  "	+ CRLF
	cSQL += "    AND U.BA1_CODEMP = '0325'  					  	  "	+ CRLF
	If !Empty(cAno+cMes)
		cSQL += "    AND SE1020T.E1_ANOBASE||SE1020T.E1_MESBASE = '"+cAno+cMes+"'"	+ CRLF
	Endif
	If !Empty(cNumFat)
		cSQL += "    AND BD6_NUMFAT   = '"+cNumFat+"'				  	  "	+ CRLF
	Endif
	cSQL += "    AND U.BA1_CODINT  = BD6_OPEUSR						  "	+ CRLF
	cSQL += "    AND U.BA1_CODEMP  = BD6_CODEMP						  "	+ CRLF
	cSQL += "    AND U.BA1_MATRIC  = BD6_MATRIC						  "	+ CRLF
	cSQL += "    and U.BA1_TIPREG  = BD6_TIPREG						  "	+ CRLF
	cSQL += "    AND BA1_CONEMP    = '000000000001'					  "	+ CRLF
	If nConfere == 1  //Somente Subcontratos de folha
		cSQL += "    AND U.BA1_SUBCON IN ('000000001','000000002','000000006','000000009','000000010')	" + CRLF
	Elseif nConfere == 2  //Somente Subcontratos de Art.30/31
		cSQL += "    AND U.BA1_SUBCON IN ('000000003','000000004','000000005')	" + CRLF
	Else
		cSQL += "    AND U.BA1_SUBCON IN ('000000001','000000002','000000006','000000009','000000010','000000003','000000004','000000005')	" + CRLF
	Endif
	cSQL += "    AND BD6_CODRDA = BAU_CODIGO						  " + CRLF
	cSQL += "    AND BD6_VLRBPF > 0									  " + CRLF
	cSQL += "    AND BD6_VLRTPF > 0									  " + CRLF
	cSQL += "    AND BD6.D_E_L_E_T_ <> '*'							  " + CRLF
	cSQL += "    AND U.D_E_L_E_T_   <> '*'							  " + CRLF
	cSQL += "    AND SE1020T.D_E_L_E_T_ <> '*'						  " + CRLF
	cSQL += "    AND BAU.D_E_L_E_T_  <> '*'							  " + CRLF

	cSQL += "UNION ALL												  " + CRLF

	cSQL += "SELECT 													" + CRLF
	//cSQL += "SUBSTR(TRIM(U.BA1_MATEMP),-8,11) MATRICULA,		  " + CRLF
	cSQL += "        CASE												" + CRLF
    cSQL += "            WHEN SUBSTR(TRIM(U.BA1_MATEMP),-8,11) IS NULL	" + CRLF
    cSQL += "            THEN TRIM(U.BA1_MATEMP)						" + CRLF
    cSQL += "            ELSE SUBSTR(TRIM(U.BA1_MATEMP),-8,11)			" + CRLF
    cSQL += "        END MATRICULA,										" + CRLF
	cSQL += "      decode(U.BA1_TIPUSU,'T','1','D',2,'A',3) ORIGEM,	  " + CRLF          
	cSQL += "      TRIM(U.BA1_NOMUSR) NOME_BENEFICIARIO ,			  " + CRLF
	cSQL += "      TO_DATE(('01'||LPAD(BM1_MES,2,'0')||BM1_ANO),'DDMMYYYY') data,	" + CRLF          
	cSQL += "      'ACERTO LIMITE COPART' TIPO,						  " + CRLF
	cSQL += "      'Acerto limite'  TIPO_EVENTO,					  " + CRLF
	cSQL += "      ' - ' PRESTADOR,									  " + CRLF
	If cEmpAnt == '01'
		cSQL += "      TRIM(RET_DESC_BSQ('C', BM1_CODTIP, BM1_DESTIP, BM1_ORIGEM)),		" + CRLF
	Else
		cSQL += "      TRIM(RET_DESC_BSQ('I', BM1_CODTIP, BM1_DESTIP, BM1_ORIGEM)),		" + CRLF
	Endif
	cSQL += "      Decode(bm1_tipo,2,-1,1)*TO_NUMBER(BM1_VALMES),	  " + CRLF
	cSQL += "      E1_ANOBASE||E1_MESBASE REFERENCIA_COB,			  " + CRLF
	cSQL += "      TRIM(U.BA1_CPFUSR) CPF_BENEFICIARIO 				  " + CRLF
	cSQL += "FROM "+RetSqlName("BM1")+" BM1 						  " + CRLF
	cSQL += "   , "+RetSqlName("BA1")+" U   						  " + CRLF
	cSQL += "   , "+RetSqlName("BA1")+" BA1020T 					  " + CRLF
	cSQL += "   , "+RetSqlName("SE1")+" E1 							  " + CRLF
	cSQL += "WHERE BM1_CODTIP  IN ('921', '922','923')				  " + CRLF
	cSQL += " AND U.BA1_FILIAL = '"+xFilial("BA1")+"'		  		  " + CRLF
	cSQL += " AND BA1020T.BA1_FILIAL = '"+xFilial("BA1")+"'		  	  " + CRLF
	cSQL += " AND BM1_FILIAL   = '"+xFilial("BM1")+"'				  " + CRLF
	cSQL += " AND E1.E1_FILIAL = '"+xFilial("SE1")+"'		  		  " + CRLF
	cSQL += " AND U.BA1_CODINT  = BM1_CODINT						  " + CRLF
	cSQL += " AND U.BA1_CODEMP  = BM1_CODEMP						  " + CRLF
	cSQL += " AND U.BA1_MATRIC  = BM1_MATRIC						  " + CRLF
	cSQL += " AND U.BA1_TIPREG  = BM1_TIPREG						  " + CRLF
	cSQL += " AND U.BA1_DIGITO  = BM1_DIGITO						  " + CRLF
	cSQL += " AND U.BA1_CONEMP='000000000001'						  " + CRLF
	If nConfere == 1  //Somente Subcontratos de folha
		cSQL += "    AND U.BA1_SUBCON IN ('000000001','000000002','000000006','000000009','000000010')	" + CRLF
	Elseif nConfere == 2  //Somente Subcontratos de Art.30/31
		cSQL += "    AND U.BA1_SUBCON IN ('000000003','000000004','000000005')	" + CRLF
	Else
		cSQL += "    AND U.BA1_SUBCON IN ('000000001','000000002','000000006','000000009','000000010','000000003','000000004','000000005')	" + CRLF
	Endif
	cSQL += " AND E1.E1_PREFIXO = BM1_PREFIX						  " + CRLF
	cSQL += " AND E1.E1_NUM = BM1_NUMTIT							  " + CRLF
	cSQL += " AND E1.E1_PARCELA = BM1_PARCEL						  " + CRLF
	cSQL += " AND E1.E1_TIPO = BM1_TIPTIT    						  " + CRLF 
	cSQL += " AND BA1020T.BA1_CODINT = '"+PLSINTPAD()+"' 			  " + CRLF
	cSQL += " AND BA1020T.BA1_CODEMP = '0325' 						  " + CRLF
	If !Empty(cAno+cMes)
		cSQL += " AND BM1_ANO||BM1_MES = '"+cAno+cMes+"'				  " + CRLF	
	Endif
	If !Empty(cNumFat)
		cSQL += " AND BM1_PLNUCO  = '"+cNumFat+"'					  	  "	+ CRLF
	Endif
	cSQL += " AND BA1020T.BA1_FILIAL  = U.BA1_FILIAL				  " + CRLF
	cSQL += " AND BA1020T.BA1_CODINT  = U.BA1_CODINT				  " + CRLF
	cSQL += " AND BA1020T.BA1_CODEMP  = U.BA1_CODEMP				  " + CRLF
	cSQL += " AND BA1020T.BA1_MATRIC  = U.BA1_MATRIC				  " + CRLF
	cSQL += " AND BA1020T.BA1_TIPREG  = '00'						  " + CRLF
	cSQL += " AND BM1.D_E_L_E_T_ <> '*'								  " + CRLF
	cSQL += " AND E1.D_E_L_E_T_ <> '*'								  " + CRLF
	cSQL += " AND U.D_E_L_E_T_ <> '*'								  " + CRLF
	cSQL += " AND BA1020T.D_E_L_E_T_ <> '*'							  " + CRLF

	cSQL += "UNION ALL												  " + CRLF

	cSQL += "SELECT 													" + CRLF
	//SUBSTR(TRIM(U.BA1_MATEMP),-8,11) MATRICULA,		  " + CRLF
	cSQL += "        CASE												" + CRLF
    cSQL += "            WHEN SUBSTR(TRIM(U.BA1_MATEMP),-8,11) IS NULL	" + CRLF
    cSQL += "            THEN TRIM(U.BA1_MATEMP)						" + CRLF
    cSQL += "            ELSE SUBSTR(TRIM(U.BA1_MATEMP),-8,11)			" + CRLF
    cSQL += "        END MATRICULA,										" + CRLF
	cSQL += "       decode(U.BA1_TIPUSU,'T','1','D',2,'A',3) ORIGEM,  " + CRLF          
	cSQL += "       TRIM(U.BA1_NOMUSR) NOME_BENEFICIARIO ,	 		  " + CRLF
	cSQL += "       TO_DATE((PDN_COMPET||'01'),'YYYYMMDD') data, 	  " + CRLF          
	cSQL += "       'SALDO COPART ANT.' TIPO,	  					  " + CRLF
	cSQL += "       'SALDO COPART ANT.' TIPO_EVENTO,	  			  " + CRLF
	cSQL += "       ' - ' PRESTADOR,	  							  " + CRLF
	cSQL += "       ' - ' PROCEDIMENTO,							 	  " + CRLF
	cSQL += "       PDN_SALDO VALOR_PARTICIPACAO,				 	  " + CRLF
	cSQL += "       PDN_COMPET REFERENCIA_COB, 						  " + CRLF
	cSQL += "       TRIM(U.BA1_CPFUSR) CPF_BENEFICIARIO        	      " + CRLF
	cSQL += "  FROM "+RetSqlName("BA1")+" U							  " + CRLF
	cSQL += "  	  , "+RetSqlName("PDN")+" V							  " + CRLF
	cSQL += " WHERE U.BA1_FILIAL = '"+xFilial("BA1")+"'		  	  	  " + CRLF
	cSQL += "   AND V.PDN_FILIAL = '"+xFilial("PDN")+"'		  	  	  " + CRLF
	cSQL += "   AND U.BA1_CODINT = '"+PLSINTPAD()+"' 				  " + CRLF
	cSQL += "   AND U.BA1_CODEMP = '0325' 							  " + CRLF
	cSQL += "   AND U.BA1_CONEMP = '000000000001'	  				  " + CRLF
	If nConfere == 1  //Somente Subcontratos de folha
		cSQL += "    AND U.BA1_SUBCON IN ('000000001','000000002','000000006','000000009','000000010')	" + CRLF
	Elseif nConfere == 2  //Somente Subcontratos de Art.30/31
		cSQL += "    AND U.BA1_SUBCON IN ('000000003','000000004','000000005')	" + CRLF
	Else
		cSQL += "    AND U.BA1_SUBCON IN ('000000001','000000002','000000006','000000009','000000010','000000003','000000004','000000005')	" + CRLF
	Endif
	cSQL += "   AND V.PDN_MATRIC = U.BA1_CODINT||U.BA1_CODEMP||U.BA1_MATRIC||U.BA1_TIPREG " + CRLF
	cSQL += "   AND V.PDN_SEQUEN IN (SELECT MAX(PDN_SEQUEN)-1 		  " + CRLF
	cSQL += "                          FROM "+RetSqlName("PDN")+" PDN2 " + CRLF
	cSQL += "                         WHERE PDN2.PDN_FILIAL = '"+xFilial("PDN")+"' " + CRLF
	cSQL += "                           AND PDN2.PDN_MATRIC = V.PDN_MATRIC    " + CRLF
	cSQL += "                           AND PDN2.PDN_COMPET = '"+cAno+cMes+"' " + CRLF	
	cSQL += "                           AND D_E_L_E_T_ = ' ' )   	  " + CRLF
	cSQL += "   AND U.D_E_L_E_T_ <> '*'	  				 			  " + CRLF
	cSQL += "   AND V.D_E_L_E_T_ <> '*'	  				 			  " + CRLF

	cSQL += "   UNION ALL	  				 						  " + CRLF

	cSQL += "SELECT 													" + CRLF
	//SUBSTR(TRIM(U.BA1_MATEMP),-8,11) MATRICULA,		  " + CRLF
	cSQL += "        CASE												" + CRLF
    cSQL += "            WHEN SUBSTR(TRIM(U.BA1_MATEMP),-8,11) IS NULL	" + CRLF
    cSQL += "            THEN TRIM(U.BA1_MATEMP)						" + CRLF
    cSQL += "            ELSE SUBSTR(TRIM(U.BA1_MATEMP),-8,11)			" + CRLF
    cSQL += "        END MATRICULA,										" + CRLF
	cSQL += "       decode(U.BA1_TIPUSU,'T','1','D',2,'A',3) ORIGEM,  " + CRLF          
	cSQL += "       TRIM(U.BA1_NOMUSR) NOME_BENEFICIARIO ,			  " + CRLF
	cSQL += "       TO_DATE((PDN_COMPET||'01'),'YYYYMMDD') data,	  " + CRLF          
	cSQL += "       'SALDO COPART PROX.MES' TIPO,					  " + CRLF
	cSQL += "       'SALDO COPART PROX.MES' TIPO_EVENTO,			  " + CRLF
	cSQL += "       ' - ' PRESTADOR,								  " + CRLF
	cSQL += "       ' - ' PROCEDIMENTO, 							  " + CRLF
	cSQL += "       PDN_SALDO VALOR_PARTICIPACAO,					  " + CRLF 
	cSQL += "       PDN_COMPET REFERENCIA_COB, 						  " + CRLF
    cSQL += "       TRIM(U.BA1_CPFUSR) CPF_BENEFICIARIO  			  " + CRLF	
	cSQL += "  FROM "+RetSqlName("BA1")+" U							  " + CRLF
	cSQL += "  	  , "+RetSqlName("PDN")+" V							  " + CRLF
	cSQL += " WHERE U.BA1_FILIAL = '"+xFilial("BA1")+"'		  	  	  " + CRLF
	cSQL += "   AND V.PDN_FILIAL = '"+xFilial("PDN")+"'		  	  	  " + CRLF
	cSQL += "   AND U.BA1_CODINT = '"+PLSINTPAD()+"' 				  " + CRLF
	cSQL += "   AND U.BA1_CODEMP = '0325' 							  " + CRLF
	cSQL += "   AND U.BA1_CONEMP = '000000000001'					  " + CRLF
	If nConfere == 1  //Somente Subcontratos de folha
		cSQL += "    AND U.BA1_SUBCON IN ('000000001','000000002','000000006','000000009','000000010')	" + CRLF
	Elseif nConfere == 2  //Somente Subcontratos de Art.30/31
		cSQL += "    AND U.BA1_SUBCON IN ('000000003','000000004','000000005')	" + CRLF
	Else
		cSQL += "    AND U.BA1_SUBCON IN ('000000001','000000002','000000006','000000009','000000010','000000003','000000004','000000005')	" + CRLF
	Endif
	cSQL += "   AND V.PDN_MATRIC = U.BA1_CODINT||U.BA1_CODEMP||U.BA1_MATRIC||U.BA1_TIPREG  			  " + CRLF
	cSQL += "   AND V.PDN_SEQUEN IN (SELECT MAX(PDN_SEQUEN)			  " + CRLF 
	cSQL += "                          FROM "+RetSqlName("PDN")+" PDN2 " + CRLF
	cSQL += "                         WHERE PDN2.PDN_FILIAL = '"+xFilial("PDN")+"' " + CRLF
	cSQL += "                           AND PDN2.PDN_MATRIC = V.PDN_MATRIC    " + CRLF
	cSQL += "                           AND PDN2.PDN_COMPET = '"+cAnoFt+cMesFt+"' " + CRLF	
	cSQL += "                           AND D_E_L_E_T_ = ' ' )		  " + CRLF
	cSQL += "   AND U.D_E_L_E_T_ <> '*'			  					  " + CRLF
	cSQL += "   AND V.D_E_L_E_T_ <> '*'			  					  " + CRLF

	cSQL += "ORDER BY 1,2,5 DESC,4,6							 	  " + CRLF

	memowrit("C:\TEMP\CABA619.SQL",cSQL)

	PLSQuery(cSQL,cAliastmp)

	While !(cAliastmp)->(Eof())

		//MsProcTxt("Processando Usuario..."+ (cAliastmp)->(NOME_BENEFICIARIO))
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica o cancelamento pelo usuario...                             ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If lAbortPrint
			Exit
		Endif

		cTmpData := SUBS(DTOS((cAliastmp)->DATA),7,2) + '/' + SUBS(DTOS((cAliastmp)->DATA),5,2) + '/' + SUBS(DTOS((cAliastmp)->DATA),1,4) 
		cTmpValor:= StrTran(cValToChar((cAliastmp)->VALOR_PARTICIPACAO),'.',',') 

		Aadd(aDados1,{  AllTrim((cAliastmp)->MATRICULA),;
						AllTrim((cAliastmp)->ORIGEM),;
						AllTrim((cAliastmp)->NOME_BENEFICIARIO),;
						cTmpData,;
						AllTrim((cAliastmp)->TIPO),;
						AllTrim((cAliastmp)->TIPO_EVENTO),;                                     
						AllTrim((cAliastmp)->PRESTADOR),;
						AllTrim((cAliastmp)->PROCEDIMENTO),;
						cTmpValor,;
						AllTrim((cAliastmp)->REFERENCIA_COB),;
					  })
		(cAliastmp)->(DbSkip())

	Enddo

	(cAliastmp)->(DbCloseArea())

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³GeraArqCMB ºAutor  ³Microsiga         º Data ³  18/12/19    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina para gerar e copiar os arquivos para CMB para des-   º±±
±±º          ³conto em folha e envio à CMB								  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/                        
Static Function GeraArqCMB()

	Local cErro 	:= ''
	Local lOk		:= .T.
	Local cQuery 	:= ''  
	Local cDataArq	 := SUBS(DTOS(Date()),7,2) + SUBS(DTOS(Date()),5,2) + SUBS(DTOS(Date()),1,4)  
    /*
    BQC_SUBCON
    '000000001' ==> 'ATIVOS'
    '000000002' ==> 'APOSENT_INVAL'
    '000000006' ==> 'INATIVOS_PDV2017'
    '000000009' ==> 'JUDICIAL'
    '000000010' ==> 'INATIVOS_PDV2019'
    */
	Local cArqOri1  := "CMB_COP_ATIVOS_"		    +cAno+cMes+"_"+cDataArq+".TXT"
	Local cArqOri2  := "CMB_COP_APOSENT_INVAL_"	    +cAno+cMes+"_"+cDataArq+".TXT"
	Local cArqOri3  := "CMB_COP_INATIVOS_PDV2017_"  +cAno+cMes+"_"+cDataArq+".TXT"
	Local cArqOri4  := "CMB_COP_JUDICIAL_"			+cAno+cMes+"_"+cDataArq+".TXT"
	Local cArqOri5  := "CMB_COP_INATIVOS_PDV2019_"	+cAno+cMes+"_"+cDataArq+".TXT"

	Local _cArqOri1  := ""
	Local _cArqOri2  := ""
	Local _cArqOri3  := ""
	Local _cArqOri4  := ""
	Local _cArqOri5  := ""

	Local _cArqDes1  := ""
	Local _cArqDes2  := ""
	Local _cArqDes3  := ""
	Local _cArqDes4  := ""
	Local _cArqDes5  := ""
	
	
	Static cPath	:= "\\srvdbp\backup\utl\"  

	_cArqOri1  := cPath+cArqOri1
	_cArqOri2  := cPath+cArqOri2 
	_cArqOri3  := cPath+cArqOri3
	_cArqOri4  := cPath+cArqOri4
	_cArqOri5  := cPath+cArqOri5

	_cArqDes1  := "C:\TEMP\"+cArqOri1
	_cArqDes2  := "C:\TEMP\"+cArqOri2
	_cArqDes3  := "C:\TEMP\"+cArqOri3
	_cArqDes4  := "C:\TEMP\"+cArqOri4
	_cArqDes5  := "C:\TEMP\"+cArqOri5

	//chamada da stored procedure	        

	cQuery := "BEGIN " + CRLF	
	cQuery += "SIGA.GERA_ARQUIVO_CMB(TO_DATE('"+cAno+cMes+'01'+"','YYYYMMDD'));" + CRLF	
	cQuery += "END;" + CRLF	

	If TcSqlExec(cQuery) <> 0	
		cErro := " - Erro na execucao da procedure " + CRLF + Space(3) + cQuery + CRLF + Space(3) + 'TcSqlError [ ' + TcSqlError() + ' ]'
		ConOut(cErro) 
		lOk := .F.      
	Else 
		//Arquivo 1
		If !MoveFile(_cArqOri1,_cArqDes1,.F.)
			Alert("Erro na copia do arquivo CMB !! ")   
		Else
			Alert("Arquivo Criado em " + _cArqDes1 + " ! ")
		EndIf	

		//Arquivo 2
		If !MoveFile(_cArqOri2,_cArqDes2,.F.)
			Alert("Erro na copia do arquivo CMB !! ")   
		Else
			Alert("Arquivo Criado em " + _cArqDes2 + " ! ")
		EndIf

		//Arquivo 3
		If !MoveFile(_cArqOri3,_cArqDes3,.F.)
			Alert("Erro na copia do arquivo CMB !! ")   
		Else
			Alert("Arquivo Criado em " + _cArqDes3 + " ! ")
		EndIf	

		//Arquivo 4
		If !MoveFile(_cArqOri4,_cArqDes4,.F.)
			Alert("Erro na copia do arquivo CMB !! ")   
		Else
			Alert("Arquivo Criado em " + _cArqDes4 + " ! ")
		EndIf	

		//Arquivo 5
		If !MoveFile(_cArqOri5,_cArqDes5,.F.)
			Alert("Erro na copia do arquivo CMB !! ")   
		Else
			Alert("Arquivo Criado em " + _cArqDes5 + " ! ")
		EndIf	

	EndIf
Return   
