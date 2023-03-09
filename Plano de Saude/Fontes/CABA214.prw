#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'RWMAKE.CH'
#INCLUDE 'FONT.CH'
#INCLUDE 'COLORS.CH'

//-------------------------------------------------------------------
/*/{Protheus.doc} function CABA214
Rotina para facilitar o processo do repasse integral/caberj
@author  Angelo Henrique
@since   date 07/03/2022
@version 1.0
@type function
/*/
//-------------------------------------------------------------------
User Function CABA214

	SetPrvt("oDlg1","oGrp1","oBtn1","oBtn2","oBtn3","oBtn4","oBtn5")

	oDlg1      := MSDialog():New( 092,223,231,600,"Repasse Integral Caberj",,,.F.,,,,,,.T.,,,.T. )

	oGrp1      := TGroup():New( 000,004,060,180,"     Repasse     ",oDlg1,CLR_HBLUE,CLR_WHITE,.T.,.F. )

	oBtn1      := TButton():New( 016,008,"1 - Gerar Carga"              ,oGrp1,{||CABA214A()},076,012,,,,.T.,,"Gerar Carga"             ,,,,.F. )
	oBtn2      := TButton():New( 016,096,"2 - Confirma Carga / Valor"   ,oGrp1,{||CABA214B()},076,012,,,,.T.,,"Confirma Carga / Valor"  ,,,,.F. )
	oBtn3      := TButton():New( 040,008,"3 - Valida Internação"        ,oGrp1,{||CABA214C()},076,012,,,,.T.,,"Valida Internação"       ,,,,.F. )
	oBtn4      := TButton():New( 040,096,"4 - Geração XML"              ,oGrp1,{||CABA214D()},076,012,,,,.T.,,"Geração XML"             ,,,,.F. )
	oBtn5      := TButton():New( 040,128,"5 - Excluir"					,oGrp1,{||CABA214O()},044,012,,,,.T.,,"Exclusão de Carga "		,,,,.F. )

	oDlg1:Activate(,,,.T.)

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} function CABA214A
 Rotina para gerar carga
@author  Angelo Henrique
@since   date 07/03/2022
@version 1.0
@type function
/*/
//-------------------------------------------------------------------
Static Function CABA214A

	Local _cPerg := "CABA214E"

	CABA214E( _cPerg )

	If Pergunte( _cPerg )

		Processa({||CABA214F(MV_PAR01,MV_PAR02)},'Processando...')

	EndIf

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} function CABA214B
 Rotina para confirmar a carga por meio de relatório
            excel impresso e demonstrar o valor total em tela
@author  Angelo Henrique
@since   date 08/03/2022
@version 1.0
@type function
/*/
//-------------------------------------------------------------------
Static Function CABA214B

	Local oReport   := Nil
	Local aArea     := GetArea()
	Local cPerg     := "CABA214B"

	CABA214G(cPerg)

	IF Pergunte(cPerg, .T.)

		oReport:= CABA214H(cPerg)
		oReport:PrintDialog()

		//------------------------------------------------------------
		//Após impressão do relatório
		//gerar rotina para exibir em tela o total da carga
		//------------------------------------------------------------
		CABA214J()

	Endif

	RestArea(aArea)


Return

//-------------------------------------------------------------------
/*/{Protheus.doc} function CABA214C
 Rotina para validar a internação
@author  Angelo Henrique
@since   date 07/03/2022
@version 1.0
@type function
/*/
//-------------------------------------------------------------------
Static Function CABA214C

	Local oReport   := Nil
	Local aArea     := GetArea()
	Local cPerg     := "CABA214C"

	CABA214L(cPerg)

	IF Pergunte(cPerg, .T.)

		oReport:= CABA214M(cPerg)
		oReport:PrintDialog()

	Endif

	RestArea(aArea)

Return


//-------------------------------------------------------------------
/*/{Protheus.doc} function CABA214D
 Rotina para abrir o browse e permitir a geraração do XML
@author  Angelo Henrique
@since   date 07/03/2022
@version 1.0
@type function
/*/
//-------------------------------------------------------------------
Static Function CABA214D

	Local _cLink	:= GetNewPar("MV_XLKTISS",'https://www.caberj.com.br/reciprocidade/tiss/')

	ShellExecute("Open", _cLink, "", "", 1)

Return


//-------------------------------------------------------------------
/*/{Protheus.doc} function CABA214E
 Rotina que irá gerar as perguntas da carga da reciprocidade
@author  Angelo Henrique
@since   date 07/03/2022
@version 1.0
@type function
/*/
//----------------------------------------------------------s---------
Static Function CABA214E( _cPerg )

	u_CABASX1(_cPerg,"01",OemToAnsi("Lote de:")			,"","","mv_ch1","C",TAMSX3("BDH_NUMFAT")[1],0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","",{},{},{})
	u_CABASX1(_cPerg,"02",OemToAnsi("Lote Ate:")		,"","","mv_ch2","C",TAMSX3("BDH_NUMFAT")[1],0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","",{},{},{})

Return


//-------------------------------------------------------------------
/*/{Protheus.doc} function CABA214F
Rotina que irá gerar a carga da reciprocidade
@author  Angelo Henrique
@since   date 07/03/2022
@version 1.0
@type function
/*/
//-------------------------------------------------------------------
Static Function CABA214F( _cParam1,_cParam2 )

	Local cQuery    := ""
	Local _cLoteDe  := _cParam1
	Local _cLoteAte := _cParam2
	Local _cNvLote  := ""
	Local _cNvGuia  := ""
	Local _cNvProc  := ""
	Local _ni       := 0
	Local _cAlias1  := GetNextAlias() //Query principal
	Local _cAlias2  := GetNextAlias() //Query Procedimentos (SIGA.RECIPR_PROCEDIMENTO)
	Local _cAlias3  := GetNextAlias() //Sequence Novo Lote
	Local _cAlias4  := GetNextAlias() //Nova Guia
	Local _cAlias5  := GetNextAlias() //Informações da BAU
	Local _cAlias6  := GetNextAlias() //Informações da Novo Procedimento (NOVOPROC)
	Local _cAlias7  := GetNextAlias() //Informações do Profissional de saúde
	Local _cTipLog  := ""
	Local _cLogra   := ""
	Local _cNumRDA  := ""
	Local _cIBGE    := ""
	Local _cMunic   := ""
	Local _cCgUf    := ""
	Local _cCEP     := ""

	Local _nServExe := 0
	Local _nDiaria  := 0
	Local _nTaxas   := 0
	Local _nMater   := 0
	Local _nMedicam := 0
	Local _nGases   := 0

	Local _cNmExec  := ""
	Local _cCodSig  := ""
	Local _cNumCR   := ""
	Local _cEstEx   := ""
	Local _cCPFEx   := ""

	Local _lPrim    := .T.
	Local _nContGui := 0

	Local _cTipGui 	:= ""
	Local lGuiDif 	:= .T.

	ProcRegua(0)

	Incproc(DtoC(Date()) + ' ' + Time() + ' - Processando Geração...')

	If Len(AllTrim(_cLoteDe)) > (TamSX3("BDH_NUMFAT")[1] - 4)

		_cLoteDe := SUBSTR(AllTrim(_cLoteDe),5)

	EndIf

	If Len(AllTrim(_cLoteAte)) > (TamSX3("BDH_NUMFAT")[1] - 4)

		_cLoteAte := SUBSTR(AllTrim(_cLoteAte),5)

	EndIf

    /*
    cQuery := "BEGIN " + CRLF
    cQuery += " CARGA_TABS_RECIPROCIDADE('CABERJ','INTEGRAL','42182170000184','07844436000106','" + AllTrim(_cLoteDe) + "','" + AllTrim(_cLoteAte) + "');  " + CRLF
    cQuery += " COMMIT; " + CRLF
    cQuery += "END;     " + CRLF

    If TcSqlExec(cQuery) <> 0
        Aviso("Atenção","Erro na execuçao da carga de reciprocidade.",{"OK"})
    Else
        Aviso("Atenção","Execução finalizada da carga de reciprocidade.",{"OK"})
    EndIf
    */

	For _ni := 1 to 3

		cQuery := ""

		cQuery += CRLF +  " SELECT DISTINCT OPERADORA_ORIGEM,OPERADORA_DESTINO,ORIGEM,TIPOGUIA,FILIAL,OPE,LDP,PEG,"
		cQuery += CRLF +  "                   NUMGUIA,NUMLOTE,DATAEMISSAOGUIA,NUMEROGUIAPRESTADOR,NUMEROCARTEIRA, "
		cQuery += CRLF +  "                   NOMEBENEFICIARIO,NOMEPLANO,VALIDADECARTEIRA,NOMECONTRATADO,NUMEROCNES,"
		cQuery += CRLF +  "                   NOMEPROFISSIONAL,SIGLACONSELHO,NUMEROCONSELHO,UFCONSELHO,CBOS,INDICACAOCLINICA,"
		cQuery += CRLF +  "                   CARATERATENDIMENTO,DATAHORAATENDIMENTO,NOMETABELA,CODIGODIAGNOSTICO,TIPODOENCA,TIPOSAIDA,TIPOATENDIMENTO,"
		cQuery += CRLF +  "                   SERVICOSEXECUTADOS,DIARIAS,TAXAS,MATERIAIS,MEDICAMENTOS,GASES,TOTALGERAL,TIPO,NUMEROGUIAOPERADORA,"
		cQuery += CRLF +  "                   CODRDA,CARATERINTERNACAO,DATAHORAINTERNACAO,DATAHORASAIDAINTERNACAO,TIPOINTERNACAO,REGIMEINTERNACAO,MOTIVOSAIDAINTERNACAO,"
		cQuery += CRLF +  "                   DATAAUTORIZACAO,SENHAAUTORIZACAO,VALIDADESENHA,TIPOFATURAMENTO,TIPOCONSULTA,ACOMODACAO,REPASSE,"
		cQuery += CRLF +  "                   BDH_CODINT,BDH_CODEMP,BDH_MATRIC,BDH_TIPREG,BDH_ANOFT,BDH_MESFT,BDH_SEQPF,BD5_INDCLI,RECBD5,NUMFAT"
		cQuery += CRLF +  "           FROM"
		cQuery += CRLF +  "           ("
		cQuery += CRLF +  "             SELECT  'CABERJ' OPERADORA_ORIGEM,'INTEGRAL' OPERADORA_DESTINO,'BD5' ORIGEM,"
		cQuery += CRLF +  "                     CASE WHEN BD5_TIPGUI = '01' THEN 'CONSULTA' ELSE CASE WHEN BD5_REGATE <> '1' THEN 'SADT' ELSE 'SDTI' END END TIPOGUIA,"
		cQuery += CRLF +  "                     BD5_FILIAL FILIAL,BD5_CODOPE OPE,BD5_CODLDP LDP,BD5_CODPEG PEG,"
		cQuery += CRLF +  "                     BD5_NUMERO NUMGUIA,"
		cQuery += CRLF +  "                     'V_NOVOLOTE' NUMLOTE,"
		cQuery += CRLF +  "                     NVL(TRIM(BD5_DTDIGI),BCI_DTDIGI) DATAEMISSAOGUIA,BD5_NUMIMP NUMEROGUIAPRESTADOR,BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG||BA1_DIGITO NUMEROCARTEIRA,"
		cQuery += CRLF +  "                     BA1_NOMUSR NOMEBENEFICIARIO,NVL(TRIM(BI3_DESCRI),'-') NOMEPLANO,BA1_DTVLCR VALIDADECARTEIRA,BD5_CODRDA CODRDA,BD5_NOMRDA NOMECONTRATADO,' ' NUMEROCNES,"
		cQuery += CRLF +  "                     NVL(TRIM(BD5_NOMSOL),'CRM GENERICO') NOMEPROFISSIONAL,NVL(TRIM(BD5_SIGLA),'CRM') SIGLACONSELHO,NVL(TRIM(BD5_REGSOL),'0052000000') NUMEROCONSELHO,NVL(TRIM(BD5_ESTSOL),'RJ') UFCONSELHO,"
		cQuery += CRLF +  "                     BDH_CODINT,BDH_CODEMP,BDH_MATRIC,BDH_TIPREG,BDH_ANOFT,BDH_MESFT,BDH_SEQPF,BD5_INDCLI,BD5.R_E_C_N_O_ RECBD5,BDH_NUMFAT NUMFAT,"
		cQuery += CRLF +  "                     ( "
		cQuery += CRLF +  "                     SELECT REPLACE(BAQ_CBOS,'.','') "
		cQuery += CRLF +  "                     FROM BAQ010 BAQ "
		cQuery += CRLF +  "                     WHERE BAQ_FILIAL = ' ' "
		cQuery += CRLF +  "                       AND BAQ_CODINT = BD5_CODOPE"
		cQuery += CRLF +  "                       AND BAQ_CODESP = BD5_CODESP"
		cQuery += CRLF +  "                       AND ROWNUM = 1"
		cQuery += CRLF +  "                     ) CBOS,"
		cQuery += CRLF +  "                     SUBSTR(TRIM(BD5_INDCLI)||' '||TRIM(BD5_INDCL2),1,300) INDICACAOCLINICA,"
		cQuery += CRLF +  "                     BD5_TIPATO /*1=Tratamento Odontologico;2=Examen Radiologico;3=Ortodoncia;4=Urgencia/ Emergencia*/ CARATERATENDIMENTO,"
		cQuery += CRLF +  "                     RPAD(TRIM(BD5_DATPRO||BD5_HORPRO),14,'0') DATAHORAATENDIMENTO,'CID-10' NOMETABELA,BD5_CID CODIGODIAGNOSTICO,BD5_TIPDOE TIPODOENCA,BD5_TIPSAI TIPOSAIDA,"
		cQuery += CRLF +  "                     BD5_TIPATE /*01=Remocao;02=Peq Cirurgia;03=Terapia;04=Consulta;05=Exame;06=Atend Domic;07=SADT Intern;08=Quimioterapia;09=Radioterapia;10=TRS*/ TIPOATENDIMENTO,"
		cQuery += CRLF +  "                     0 SERVICOSEXECUTADOS,0 DIARIAS,0 TAXAS,0 MATERIAIS,0 MEDICAMENTOS,0 GASES,0 TOTALGERAL,'T' TIPO,BD5_NUMIMP NUMEROGUIAOPERADORA,"
		cQuery += CRLF +  "                     BD5_CODRDA, ' ' CARATERINTERNACAO,' ' DATAHORAINTERNACAO,' ' DATAHORASAIDAINTERNACAO,' ' TIPOINTERNACAO,' ' REGIMEINTERNACAO,' ' MOTIVOSAIDAINTERNACAO,"
		cQuery += CRLF +  "                     ' ' DATAAUTORIZACAO,' ' SENHAAUTORIZACAO,' ' VALIDADESENHA,' ' TIPOFATURAMENTO,BD5_TIPCON TIPOCONSULTA,' ' ACOMODACAO,"
		cQuery += CRLF +  "                     RETORNA_MATRICULA_INT_REP ( BA1_CODINT,BA1_CODEMP,BA1_MATRIC,BA1_TIPREG,BA1_DIGITO) REPASSE"
		cQuery += CRLF +  "             FROM BDH010 BDH"
		cQuery += CRLF +  "             INNER JOIN BD5010 BD5 ON BD5_FILIAL = ' '"
		cQuery += CRLF +  "               AND BD5_OPEUSR = BDH_CODINT"
		cQuery += CRLF +  "               AND BD5_CODEMP = BDH_CODEMP"
		cQuery += CRLF +  "               AND BD5_MATRIC = BDH_MATRIC"
		cQuery += CRLF +  "               AND BD5_TIPREG = BDH_TIPREG"
		cQuery += CRLF +  "               AND BD5_ANOPAG = BDH_ANOFT"
		cQuery += CRLF +  "               AND BD5_MESPAG = BDH_MESFT"
		cQuery += CRLF +  "               AND BD5_SEQPF =  BDH_SEQPF"
		cQuery += CRLF +  "               AND BD5_NUMFAT = BDH_NUMFAT"
		If _ni = 2 //SADT
			cQuery += CRLF +  "               AND BD5_REGATE <> '1' "
		ElseIf _ni = 3 //SDTI
			cQuery += CRLF +  "               AND BD5_REGATE = '1' "
		EndIf		
		cQuery += CRLF +  "               AND BD5.D_E_L_E_T_ = ' '"
		cQuery += CRLF +  "             INNER JOIN BCI010 BCI ON BCI_FILIAL = ' ' "
		cQuery += CRLF +  "               AND BCI_CODOPE = BD5_CODOPE"
		cQuery += CRLF +  "               AND BCI_CODLDP = BD5_CODLDP"
		cQuery += CRLF +  "               AND BCI_CODPEG = BD5_CODPEG"
		cQuery += CRLF +  "               AND ("
		If _ni = 1
			cQuery += CRLF +  "                     ( BCI_TIPGUI = '01' ) /* CONSULTA */  "
		Else
			cQuery += CRLF +  "                     ( BCI_TIPGUI IN ('02','06','10') ) /* SADT */                    "
		EndIf
		cQuery += CRLF +  "                   )             "
		cQuery += CRLF +  "               AND BCI.D_E_L_E_T_ = ' '  			             "
		cQuery += CRLF +  "             INNER JOIN BA1010 BA1 ON BA1_FILIAL = ' ' "
		cQuery += CRLF +  "               AND BA1_CODINT = BD5_CODOPE"
		cQuery += CRLF +  "               AND BA1_CODEMP = BD5_CODEMP"
		cQuery += CRLF +  "               AND BA1_MATRIC = BD5_MATRIC"
		cQuery += CRLF +  "               AND BA1_TIPREG = BD5_TIPREG"
		cQuery += CRLF +  "               AND BA1_DIGITO = BD5_DIGITO"
		cQuery += CRLF +  "               AND BA1.D_E_L_E_T_ = ' ' "
		cQuery += CRLF +  "             LEFT JOIN BI3010 BI3 ON BI3_FILIAL = ' ' "
		cQuery += CRLF +  "               AND BI3_CODINT = BA1_CODINT"
		cQuery += CRLF +  "               AND BI3_CODIGO = BA1_CODPLA"
		cQuery += CRLF +  "             WHERE BDH_FILIAL = ' '"
		cQuery += CRLF +  "               AND BDH.D_E_L_E_T_ = ' '								 						"
		cQuery += CRLF +  "               AND BDH_NUMFAT BETWEEN '0001" + AllTrim(_cLoteDe) + "' AND '0001" + AllTrim(_cLoteAte) + "'"
		cQuery += CRLF +  "           )"

		If Select(_cAlias1) > 0
			(_cAlias1)->(DbCloseArea())
		EndIf

		DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),_cAlias1,.T.,.T.)

		If !(_cAlias1)->(EOF())

			While !(_cAlias1)->(EOF())

				//Contador de Guias
				_nContGui ++				

				If _cTipGui <> TRIM((_cAlias1)->TIPOGUIA)

					_cTipGui := TRIM((_cAlias1)->TIPOGUIA)
					lGuiDif := .T.

				Else

					lGuiDif := .F.

				EndIf

				If _lPrim .Or. _nContGui > 99 .Or. lGuiDif

					_nContGui := 1

					_lPrim := .F.

					//-----------------------------
					//Pegando novo lote
					//-----------------------------
					BeginSql Alias _cAlias3
			
			            SELECT SIGA.ID_LOTE_CABERJ.NEXTVAL NovoLote FROM DUAL
			
					EndSql

					if (_cAlias3)->(!Eof())
						_cNvLote := cValToChar((_cAlias3)->NovoLote)
					endif

					if select(_cAlias3) > 0
						dbselectarea(_cAlias3)
						dbclosearea()
					endif

					//--------------------------------------------
					//INICIO - Inclusão do lote
					//--------------------------------------------
					cQuery := ""

					cQuery += CRLF +  " INSERT INTO "
					cQuery += CRLF +  "     SIGA.RECIPR_LOTE"
					cQuery += CRLF +  " ("
					cQuery += CRLF +  "     OPERADORA_ORIGEM,"
					cQuery += CRLF +  "     CNPJ_ORIGEM,"
					cQuery += CRLF +  "     IDLOTE,"
					cQuery += CRLF +  "     TIPOLOTE,"
					cQuery += CRLF +  "     XML_GERADO,"
					cQuery += CRLF +  "     OPERADORA_DESTINO,"
					cQuery += CRLF +  "     CNPJ_DESTINO,"
					cQuery += CRLF +  "     TIPOTRANSACAO,"
					cQuery += CRLF +  "     SEQUENCIALTRANSACAO,"
					cQuery += CRLF +  "     DATAREGISTROTRANSACAO,"
					cQuery += CRLF +  "     HORAREGISTROTRANSACAO,"
					cQuery += CRLF +  "     EMPRESA,"
					cQuery += CRLF +  "     NUMFAT"
					cQuery += CRLF +  " )"
					cQuery += CRLF +  " VALUES"
					cQuery += CRLF +  " ("
					cQuery += CRLF +  "     'CABERJ',"
					cQuery += CRLF +  "     '42182170000184' ,"
					cQuery += CRLF +  "     " + _cNvLote + ","

					If _ni = 1
						cQuery += CRLF +  "     'CONS' ,"
					ElseIf _ni = 2
						cQuery += CRLF +  "     'SADT' ,"
					ElseIf _ni = 3
						cQuery += CRLF +  "     'SDTI' ,"
					EndIf

					cQuery += CRLF +  "     'N' ,"
					cQuery += CRLF +  "     'INTEGRAL',"
					cQuery += CRLF +  "     '07844436000106',"
					cQuery += CRLF +  "     'ENVIO_LOTE_GUIAS' ,"
					cQuery += CRLF +  "     " + _cNvLote + ","
					cQuery += CRLF +  "     TO_CHAR(SYSDATE,'YYYYMMDD') ,"
					cQuery += CRLF +  "     TO_CHAR(SYSDATE,'HH:MI:SS') ,"
					cQuery += CRLF +  "     'CABERJ',"
					cQuery += CRLF +  "     '" + (_cAlias1)->NUMFAT  + "'"
					cQuery += CRLF +  " )

					If tcSqlExec(cQuery) < 0
						Alert("Erro na inclusao - SIGA.RECIPR_LOTE")
					EndIf
					//--------------------------------------------
					//FIM - Inclusão do lote
					//--------------------------------------------

				EndIf

				//-----------------------------------------------------
				// INICIO - Pegando numeração da guia
				//-----------------------------------------------------
				cQuery:= ""

				cQuery += CRLF +  " SELECT "
				cQuery += CRLF +  "     NVL(MAX(IDGUIA),0) + 1 NOVAGUIA"
				cQuery += CRLF +  " FROM "
				cQuery += CRLF +  "     SIGA.RECIPR_GUIA "
				cQuery += CRLF +  " WHERE "
				cQuery += CRLF +  "     EMPRESA = 'CABERJ' "
				cQuery += CRLF +  "     AND IDLOTE = '" + _cNvLote + "'"

				If Select(_cAlias4) > 0
					(_cAlias4)->(DbCloseArea())
				EndIf

				DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),_cAlias4,.T.,.T.)

				If !(_cAlias4)->(EOF())

					_cNvGuia := cValToChar((_cAlias4)->NOVAGUIA)

				Else

					Alert("Problema em calcular proximo numero da nova guia.")

				EndIf

				If Select(_cAlias4) > 0
					(_cAlias4)->(DbCloseArea())
				EndIf
				//-----------------------------------------------------
				// FIM - Pegando numeração da guia
				//-----------------------------------------------------

				//-----------------------------------------------------
				// INICIO - Pegando informações da BAU
				//-----------------------------------------------------
				cQuery := ""

				cQuery += CRLF +  " SELECT "
				cQuery += CRLF +  "     DISTINCT "
				cQuery += CRLF +  "     NVL(TRIM(BAU_TIPLOG),'-')  TPLOGRAD,"
				cQuery += CRLF +  "     UPPER(NVL(TRIM(B18_DESCRI),'-')) LOGRAD,"
				cQuery += CRLF +  "     BAU_NUMERO NUMERO,"
				cQuery += CRLF +  "     BAU_MUN CDIBGEMUN,"
				cQuery += CRLF +  "     NVL(UPPER(BID_DESCRI),'-') MUNICIPIO,"
				cQuery += CRLF +  "     BAU_EST CODIGOUF,"
				cQuery += CRLF +  "     BAU_CEP CEP"
				cQuery += CRLF +  " FROM "
				cQuery += CRLF +  "     BAU010 BAU"
				cQuery += CRLF +  "     "
				cQuery += CRLF +  "     LEFT JOIN "
				cQuery += CRLF +  "         B18010 B18 "
				cQuery += CRLF +  "     ON "
				cQuery += CRLF +  "         B18_FILIAL = ' '"
				cQuery += CRLF +  "         AND B18_CODIGO = BAU_TIPLOG"
				cQuery += CRLF +  "         AND B18.D_E_L_E_T_ = ' '"
				cQuery += CRLF +  "     "
				cQuery += CRLF +  "     LEFT JOIN "
				cQuery += CRLF +  "         BID010 BID "
				cQuery += CRLF +  "     ON "
				cQuery += CRLF +  "         BID_FILIAL = ' '"
				cQuery += CRLF +  "         AND BID_CODMUN = BAU_MUN"
				cQuery += CRLF +  "         AND BID.D_E_L_E_T_ = ' '"
				cQuery += CRLF +  "     "
				cQuery += CRLF +  " WHERE "
				cQuery += CRLF +  "     BAU_CODIGO = '" + (_cAlias1)->CODRDA + "'"
				cQuery += CRLF +  "     AND BAU.D_E_L_E_T_ = ' '"
				cQuery += CRLF +  "     AND ROWNUM = 1"

				If Select(_cAlias5) > 0
					(_cAlias5)->(DbCloseArea())
				EndIf

				DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),_cAlias5,.T.,.T.)

				If !(_cAlias5)->(EOF())

					_cTipLog    := REPLACE((_cAlias5)->TPLOGRAD ,"'"," ")
					_cLogra     := REPLACE((_cAlias5)->LOGRAD   ,"'"," ")
					_cNumRDA    := REPLACE((_cAlias5)->NUMERO   ,"'"," ")
					_cIBGE      := REPLACE((_cAlias5)->CDIBGEMUN,"'"," ")
					_cMunic     := REPLACE((_cAlias5)->MUNICIPIO,"'"," ")
					_cCgUf      := REPLACE((_cAlias5)->CODIGOUF ,"'"," ")
					_cCEP       := REPLACE((_cAlias5)->CEP      ,"'"," ")

				EndIf

				If Select(_cAlias5) > 0
					(_cAlias5)->(DbCloseArea())
				EndIf
				//-----------------------------------------------------
				// FIM - Pegando informações da BAU
				//-----------------------------------------------------

				cQuery := ""

				cQuery += CRLF +  " INSERT INTO SIGA.RECIPR_GUIA"
				cQuery += CRLF +  " ("
				cQuery += CRLF +  " 	EMPRESA,"
				cQuery += CRLF +  " 	IDLOTE,"
				cQuery += CRLF +  " 	IDGUIA,"
				cQuery += CRLF +  " 	OPERADORA,"
				cQuery += CRLF +  " 	ORIGEM,"
				cQuery += CRLF +  " 	TIPOGUIA,"
				cQuery += CRLF +  " 	FILIAL,"
				cQuery += CRLF +  " 	OPE,"
				cQuery += CRLF +  " 	LDP,"
				cQuery += CRLF +  " 	PEG,"
				cQuery += CRLF +  " 	NUMGUIA,"
				cQuery += CRLF +  " 	NUMLOTE,"
				cQuery += CRLF +  " 	DATAEMISSAOGUIA,"
				cQuery += CRLF +  " 	NUMEROGUIAPRESTADOR,"
				cQuery += CRLF +  " 	NUMEROCARTEIRA,"
				cQuery += CRLF +  " 	NOMEBENEFICIARIO,"
				cQuery += CRLF +  " 	NOMEPLANO,"
				cQuery += CRLF +  " 	VALIDADECARTEIRA,"
				cQuery += CRLF +  " 	NOMECONTRATADO,"
				cQuery += CRLF +  " 	NOMEPROFISSIONAL,"
				cQuery += CRLF +  " 	SIGLACONSELHO,"
				cQuery += CRLF +  " 	NUMEROCONSELHO,"
				cQuery += CRLF +  " 	UFCONSELHO,"
				cQuery += CRLF +  " 	CBOS,"
				cQuery += CRLF +  " 	INDICACAOCLINICA,"
				cQuery += CRLF +  " 	CARATERATENDIMENTO,
				cQuery += CRLF +  " 	DATAHORAATENDIMENTO,"
				cQuery += CRLF +  " 	NOMETABELA,"
				cQuery += CRLF +  " 	CODIGODIAGNOSTICO,"
				cQuery += CRLF +  " 	TIPODOENCA,"
				cQuery += CRLF +  " 	TIPOSAIDA,"
				cQuery += CRLF +  " 	TIPOATENDIMENTO,"
				cQuery += CRLF +  " 	SERVICOSEXECUTADOS,"
				cQuery += CRLF +  " 	DIARIAS,"
				cQuery += CRLF +  " 	TAXAS,"
				cQuery += CRLF +  " 	MATERIAIS,"
				cQuery += CRLF +  " 	MEDICAMENTOS,"
				cQuery += CRLF +  " 	GASES,
				cQuery += CRLF +  " 	TOTALGERAL,"
				cQuery += CRLF +  " 	TIPO,"
				cQuery += CRLF +  " 	NUMEROGUIAOPERADORA,"
				cQuery += CRLF +  " 	CARATERINTERNACAO,"
				cQuery += CRLF +  " 	DATAHORAINTERNACAO,"
				cQuery += CRLF +  " 	DATAHORASAIDAINTERNACAO,"
				cQuery += CRLF +  " 	TIPOINTERNACAO,"
				cQuery += CRLF +  " 	REGIMEINTERNACAO,"
				cQuery += CRLF +  " 	MOTIVOSAIDAINTERNACAO,"
				cQuery += CRLF +  " 	DATAAUTORIZACAO,"
				cQuery += CRLF +  " 	SENHAAUTORIZACAO,"
				cQuery += CRLF +  " 	VALIDADESENHA,"
				cQuery += CRLF +  " 	TIPOFATURAMENTO,"
				cQuery += CRLF +  " 	TIPOCONSULTA,"
				cQuery += CRLF +  " 	ACOMODACAO,"
				cQuery += CRLF +  " 	REPASSE,"
				cQuery += CRLF +  " 	DESCRICAODIAGNOSTICO,"
				cQuery += CRLF +  " 	CODIGOPRESTADORNAOPERADORA,"
				cQuery += CRLF +  "     TIPOLOGRADOURO,"
				cQuery += CRLF +  "     LOGRADOURO,"
				cQuery += CRLF +  "     NUMERO,"
				cQuery += CRLF +  "     CODIGOIBGEMUNICIPIO,"
				cQuery += CRLF +  "     MUNICIPIO,"
				cQuery += CRLF +  "     CODIGOUF,"
				cQuery += CRLF +  "     CEP,"
				cQuery += CRLF +  " 	RECBD5,"
				cQuery += CRLF +  " 	NUMFAT"
				cQuery += CRLF +  " )"
				cQuery += CRLF +  " VALUES"
				cQuery += CRLF +  " ("
				cQuery += CRLF +  " 	'CABERJ' ,"
				cQuery += CRLF +  " 	" + _cNvLote + ","
				cQuery += CRLF +  " 	" + _cNvGuia + ","
				cQuery += CRLF +  " 	'INTEGRAL' ,"
				cQuery += CRLF +  " 	'" + AllTrim((_cAlias1)->ORIGEM) + "',"
				cQuery += CRLF +  " 	'" + AllTrim((_cAlias1)->TIPOGUIA) + "',"
				cQuery += CRLF +  " 	'" + AllTrim((_cAlias1)->FILIAL) + "',"
				cQuery += CRLF +  " 	'" + AllTrim((_cAlias1)->OPE) + "',"
				cQuery += CRLF +  " 	'" + AllTrim((_cAlias1)->LDP) + "',"
				cQuery += CRLF +  " 	'" + AllTrim((_cAlias1)->PEG) + "',"
				cQuery += CRLF +  " 	'" + AllTrim((_cAlias1)->NUMGUIA) + "',"
				cQuery += CRLF +  " 	'" + _cNvLote + "',"
				cQuery += CRLF +  " 	'" + AllTrim((_cAlias1)->DATAEMISSAOGUIA) + "',"
				cQuery += CRLF +  " 	'" + AllTrim((_cAlias1)->NUMEROGUIAPRESTADOR) + "',"
				cQuery += CRLF +  " 	'" + AllTrim((_cAlias1)->NUMEROCARTEIRA) + "',"
				cQuery += CRLF +  " 	'" + AllTrim((_cAlias1)->NOMEBENEFICIARIO) + "',"
				cQuery += CRLF +  " 	'" + AllTrim((_cAlias1)->NOMEPLANO) + "',"
				cQuery += CRLF +  " 	'" + AllTrim((_cAlias1)->VALIDADECARTEIRA) + "',"
				cQuery += CRLF +  " 	'" + AllTrim((_cAlias1)->NOMECONTRATADO) + "',"
				cQuery += CRLF +  " 	'" + AllTrim((_cAlias1)->NOMEPROFISSIONAL) + "',"
				cQuery += CRLF +  " 	'" + AllTrim((_cAlias1)->SIGLACONSELHO) + "',"
				cQuery += CRLF +  " 	'" + AllTrim((_cAlias1)->NUMEROCONSELHO) + "',"
				cQuery += CRLF +  " 	'" + AllTrim((_cAlias1)->UFCONSELHO) + "',"
				cQuery += CRLF +  " 	'" + AllTrim((_cAlias1)->CBOS) + "',"
				cQuery += CRLF +  " 	'" + AllTrim((_cAlias1)->INDICACAOCLINICA) + "',"
				cQuery += CRLF +  " 	'" + AllTrim((_cAlias1)->CARATERATENDIMENTO) + "',"
				cQuery += CRLF +  " 	'" + AllTrim((_cAlias1)->DATAHORAATENDIMENTO) + "',"
				cQuery += CRLF +  " 	'" + AllTrim((_cAlias1)->NOMETABELA) + "',"
				cQuery += CRLF +  " 	'" + AllTrim((_cAlias1)->CODIGODIAGNOSTICO) + "',"
				cQuery += CRLF +  " 	'" + AllTrim((_cAlias1)->TIPODOENCA) + "',"
				cQuery += CRLF +  " 	'" + AllTrim((_cAlias1)->TIPOSAIDA) + "',"
				cQuery += CRLF +  " 	'" + AllTrim((_cAlias1)->TIPOATENDIMENTO) + "',"
				cQuery += CRLF +  " 	 " + cValToChar((_cAlias1)->SERVICOSEXECUTADOS) + ","
				cQuery += CRLF +  " 	 " + cValToChar((_cAlias1)->DIARIAS) + ","
				cQuery += CRLF +  " 	 " + cValToChar((_cAlias1)->TAXAS) + ","
				cQuery += CRLF +  " 	 " + cValToChar((_cAlias1)->MATERIAIS) + ","
				cQuery += CRLF +  " 	 " + cValToChar((_cAlias1)->MEDICAMENTOS) + ","
				cQuery += CRLF +  " 	 " + cValToChar((_cAlias1)->GASES) + ","
				cQuery += CRLF +  " 	 " + cValToChar((_cAlias1)->TOTALGERAL) + ","
				cQuery += CRLF +  " 	'" + AllTrim((_cAlias1)->TIPO) + "',"
				cQuery += CRLF +  " 	'" + AllTrim((_cAlias1)->NUMEROGUIAOPERADORA) + "',"
				cQuery += CRLF +  " 	'" + AllTrim((_cAlias1)->CARATERINTERNACAO) + "',"
				cQuery += CRLF +  " 	'" + AllTrim((_cAlias1)->DATAHORAINTERNACAO) + "',"
				cQuery += CRLF +  " 	'" + AllTrim((_cAlias1)->DATAHORASAIDAINTERNACAO) + "',"
				cQuery += CRLF +  " 	'" + AllTrim((_cAlias1)->TIPOINTERNACAO) + "',"
				cQuery += CRLF +  " 	'" + AllTrim((_cAlias1)->REGIMEINTERNACAO) + "',"
				cQuery += CRLF +  " 	'" + AllTrim((_cAlias1)->MOTIVOSAIDAINTERNACAO) + "',"
				cQuery += CRLF +  " 	'" + AllTrim((_cAlias1)->DATAAUTORIZACAO) + "',"
				cQuery += CRLF +  " 	'" + AllTrim((_cAlias1)->SENHAAUTORIZACAO) + "',"
				cQuery += CRLF +  " 	'" + AllTrim((_cAlias1)->VALIDADESENHA) + "',"
				cQuery += CRLF +  " 	'" + AllTrim((_cAlias1)->TIPOFATURAMENTO) + "',"
				cQuery += CRLF +  " 	'" + AllTrim((_cAlias1)->TIPOCONSULTA) + "',"
				cQuery += CRLF +  " 	'" + AllTrim((_cAlias1)->ACOMODACAO) + "',"
				cQuery += CRLF +  " 	'" + AllTrim((_cAlias1)->REPASSE) + "',"
				cQuery += CRLF +  " 	'" + AllTrim(SUBSTR((_cAlias1)->BD5_INDCLI,1,70)) + "',"
				cQuery += CRLF +  " 	'" + AllTrim((_cAlias1)->CODRDA) + "',"
				cQuery += CRLF +  " 	'" + AllTrim(_cTipLog) + "',"
				cQuery += CRLF +  " 	'" + AllTrim(_cLogra)  + "',"
				cQuery += CRLF +  " 	'" + AllTrim(_cNumRDA) + "',"
				cQuery += CRLF +  " 	'" + AllTrim(_cIBGE)   + "',"
				cQuery += CRLF +  " 	'" + AllTrim(_cMunic)  + "',"
				cQuery += CRLF +  " 	'" + AllTrim(_cCgUf)   + "',"
				cQuery += CRLF +  " 	'" + AllTrim(_cCEP)    + "',"
				cQuery += CRLF +  " 	 " + cValToChar((_cAlias1)->RECBD5) + ","
				cQuery += CRLF +  " 	'" + (_cAlias1)->NUMFAT + "'"
				cQuery += CRLF +  " )"

				If tcSqlExec(cQuery) < 0
					Alert("Erro na inclusao - SIGA.RECIPR_GUIA - PEG: " + AllTrim((_cAlias1)->PEG) + " - GUIA: " + AllTrim((_cAlias1)->NUMGUIA) )
				EndIf

				//---------------------------------------------------
				//INICIO - Validando numero da guia da operadora
				//---------------------------------------------------
				IF Empty(ALLTRIM((_cAlias1)->NUMEROGUIAOPERADORA))

					cQuery := ""

					cQuery += CRLF +  " UPDATE "
					cQuery += CRLF +  "     SIGA.RECIPR_GUIA "
					cQuery += CRLF +  " SET "
					cQuery += CRLF +  "     NUMEROGUIAOPERADORA = 'NULL'||LPAD(TRIM(TO_CHAR(SIGA.NUM_IMP_NULL.NEXTVAL)),9,'0'),"
					cQuery += CRLF +  "     NUMEROGUIAPRESTADOR = 'NULL'||LPAD(TRIM(TO_CHAR(SIGA.NUM_IMP_NULL.NEXTVAL)),9,'0')"
					cQuery += CRLF +  " WHERE "
					cQuery += CRLF +  "     EMPRESA = 'CABERJ'"
					cQuery += CRLF +  "     AND IDLOTE = '" + _cNvLote + "'"
					cQuery += CRLF +  "     AND IDGUIA = '" + _cNvGuia + "'"

					If tcSqlExec(cQuery) < 0
						Alert("Erro no update - SIGA.RECIPR_GUIA - para alimentar o numero da guia " )
					EndIf

				EndIf
				//---------------------------------------------------
				//FIM - Validando numero da guia da operadora
				//---------------------------------------------------

				cQuery := ""

				cQuery += CRLF +  " SELECT "
				cQuery += CRLF +  " 	BAU_CODIGO,"
				cQuery += CRLF +  " 	BR8_CODPAD,"
				cQuery += CRLF +  " 	BD6_DATPRO,"
				cQuery += CRLF +  " 	RPAD(NVL(TRIM(BD6.BD6_HORPRO),'0'),6,'0') HORPRO,"
				cQuery += CRLF +  " 	' ' HORAFIM,"
				cQuery += CRLF +  " 	BD6_QTDPRO,"
				cQuery += CRLF +  " 	BD6_SIGEXE,"
				cQuery += CRLF +  " 	BD6_ESTEXE,"
				cQuery += CRLF +  " 	BD6_REGEXE,"
				cQuery += CRLF +  " 	ROUND(BD6_VLRTPF/BD6_QTDPRO,2) VLRUNIT,"
				cQuery += CRLF +  " 	BD6_VLRTPF,"
				cQuery += CRLF +  " 	BR8_TPPROC,"
				cQuery += CRLF +  " 	TRIM(BR8_CODPSA) CODPSA,"
				cQuery += CRLF +  " 	BR8_DESCRI,"
				cQuery += CRLF +  " 	BD6.R_E_C_N_O_ RECBD6,"
				cQuery += CRLF +  "     ("
				cQuery += CRLF +  "         CASE  "
				cQuery += CRLF +  "             WHEN BR8_CODPAD NOT IN ('05','09') AND TRIM( BR8_TPPROC) = '7' "
				cQuery += CRLF +  "             THEN BD6_VLRTPF "
				cQuery += CRLF +  "             else 0"
				cQuery += CRLF +  "         End "
				cQuery += CRLF +  "     ) GASES,"
				cQuery += CRLF +  "     ("
				cQuery += CRLF +  "         case"
				cQuery += CRLF +  "              WHEN (BR8_CODPAD NOT IN ('05','09') AND TRIM( BR8_TPPROC) IN ('0','6')) OR BR8_TPPROC = ' ' "
				cQuery += CRLF +  "              THEN BD6_VLRTPF"
				cQuery += CRLF +  "              else 0"
				cQuery += CRLF +  "         end"
				cQuery += CRLF +  "     ) servicoexecutado,"
				cQuery += CRLF +  "     ("
				cQuery += CRLF +  "         case"
				cQuery += CRLF +  "              WHEN BR8_CODPAD NOT IN ('05','09') AND TRIM( BR8_TPPROC) = '4' "
				cQuery += CRLF +  "              THEN BD6_VLRTPF"
				cQuery += CRLF +  "              else 0"
				cQuery += CRLF +  "         end"
				cQuery += CRLF +  "     ) diarias,       "
				cQuery += CRLF +  "     ("
				cQuery += CRLF +  "         case"
				cQuery += CRLF +  "              WHEN BR8_CODPAD NOT IN ('05','09') AND TRIM( BR8_TPPROC) IN ('3','8') "
				cQuery += CRLF +  "              THEN BD6_VLRTPF"
				cQuery += CRLF +  "              else 0"
				cQuery += CRLF +  "         end"
				cQuery += CRLF +  "     ) taxas,"
				cQuery += CRLF +  "     ("
				cQuery += CRLF +  "         case"
				cQuery += CRLF +  "              WHEN TRIM( BR8_TPPROC) = '2' "
				cQuery += CRLF +  "              THEN BD6_VLRTPF"
				cQuery += CRLF +  "              WHEN BR8_CODPAD IN ('05','09') "
				cQuery += CRLF +  "              THEN BD6_VLRTPF"
				cQuery += CRLF +  "              else 0"
				cQuery += CRLF +  "         end"
				cQuery += CRLF +  "     ) medicamentos,        "
				cQuery += CRLF +  "     ("
				cQuery += CRLF +  "         case"
				cQuery += CRLF +  "              WHEN TRIM( BR8_TPPROC) IN ('1','5') "
				cQuery += CRLF +  "              THEN BD6_VLRTPF"
				cQuery += CRLF +  "              else 0"
				cQuery += CRLF +  "         end"
				cQuery += CRLF +  "     ) materias,"
				cQuery += CRLF +  " 	CASE "
				cQuery += CRLF +  " 		WHEN BD6_CODPAD = '02' THEN '16'"
				cQuery += CRLF +  " 		WHEN BD6_CODPAD = '15' THEN BD6_CODPAD "
				cQuery += CRLF +  " 		WHEN BD6_CODPAD IN ('06','07') /*OPME*/ THEN '00' "
				cQuery += CRLF +  " 		ELSE SUBSTR(TABS_MEDLINK(BD6_CODPAD,BD6_CODPRO,'CABERJ'),2,2) "
				cQuery += CRLF +  " 	END TAB_XML"
				cQuery += CRLF +  " FROM "
				cQuery += CRLF +  " 	BD6010 BD6"
				cQuery += CRLF +  " 	"
				cQuery += CRLF +  " 	INNER JOIN "
				cQuery += CRLF +  " 		BR8010 BR8 "
				cQuery += CRLF +  " 	ON "
				cQuery += CRLF +  " 		BR8.D_E_L_E_T_ = ' ' "
				cQuery += CRLF +  " 		AND BR8_FILIAL = ' ' "
				cQuery += CRLF +  " 		AND BR8_CODPAD = BD6_CODPAD"
				cQuery += CRLF +  " 		AND BR8_CODPSA = BD6_CODPRO"
				cQuery += CRLF +  " 	"
				cQuery += CRLF +  " 	INNER JOIN "
				cQuery += CRLF +  " 		BAU010 BAU "
				cQuery += CRLF +  " 	ON "
				cQuery += CRLF +  " 		BAU_FILIAL = ' ' "
				cQuery += CRLF +  " 		AND BAU_CODIGO = BD6_CODRDA "
				cQuery += CRLF +  " 		AND BAU.D_E_L_E_T_ = ' ' "
				cQuery += CRLF +  " WHERE "
				cQuery += CRLF +  " 	BD6.D_E_L_E_T_ = ' ' "
				cQuery += CRLF +  " 	AND BD6_FILIAL = ' ' "
				cQuery += CRLF +  " 	AND BD6_CODOPE = '" + (_cAlias1)->OPE 			+ "'"
				cQuery += CRLF +  " 	AND BD6_CODLDP = '" + (_cAlias1)->LDP 			+ "'"
				cQuery += CRLF +  " 	AND BD6_CODPEG = '" + (_cAlias1)->PEG 			+ "'"
				cQuery += CRLF +  " 	AND BD6_NUMERO = '" + (_cAlias1)->NUMGUIA 		+ "'"
				cQuery += CRLF +  " 	AND BD6_OPEUSR = '" + (_cAlias1)->BDH_CODINT 	+ "'"
				cQuery += CRLF +  " 	AND BD6_CODEMP = '" + (_cAlias1)->BDH_CODEMP 	+ "'"
				cQuery += CRLF +  " 	AND BD6_MATRIC = '" + (_cAlias1)->BDH_MATRIC 	+ "'"
				cQuery += CRLF +  " 	AND BD6_TIPREG = '" + (_cAlias1)->BDH_TIPREG 	+ "'"
				cQuery += CRLF +  " 	AND BD6_ANOPAG = '" + (_cAlias1)->BDH_ANOFT 	+ "'"
				cQuery += CRLF +  " 	AND BD6_MESPAG = '" + (_cAlias1)->BDH_MESFT 	+ "'"
				cQuery += CRLF +  " 	AND BD6_NUMFAT = '" + (_cAlias1)->NUMFAT 		+ "'"

				If Select(_cAlias2) > 0
					(_cAlias2)->(DbCloseArea())
				EndIf

				DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),_cAlias2,.T.,.T.)

				If !(_cAlias2)->(EOF())

					_nServExe   := 0
					_nDiaria    := 0
					_nTaxas     := 0
					_nMater     := 0
					_nMedicam   := 0
					_nGases     := 0

					While !(_cAlias2)->(EOF())

						_nServExe += (_cAlias2)->servicoexecutado
						_nDiaria  += (_cAlias2)->diarias
						_nTaxas   += (_cAlias2)->taxas
						_nMater   += (_cAlias2)->materias
						_nMedicam += (_cAlias2)->medicamentos
						_nGases   += (_cAlias2)->GASES

						//-----------------------------------------------------
						// INICIO - Pegando numeração do procedimento
						//-----------------------------------------------------
						cQuery := ""

						cQuery += CRLF +  " SELECT "
						cQuery += CRLF +  "     NVL(MAX(IDPROCEDIMENTO),0) + 1 NOVOPROC"
						cQuery += CRLF +  " FROM "
						cQuery += CRLF +  "     SIGA.RECIPR_PROCEDIMENTO "
						cQuery += CRLF +  " WHERE "
						cQuery += CRLF +  "     EMPRESA = 'CABERJ' "
						cQuery += CRLF +  "     AND IDLOTE = '" + _cNvLote + "'"
						cQuery += CRLF +  "     AND IDGUIA = '" + _cNvGuia + "'"

						If Select(_cAlias6) > 0
							(_cAlias6)->(DbCloseArea())
						EndIf

						DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),_cAlias6,.T.,.T.)

						If !(_cAlias6)->(EOF())

							_cNvProc := cValToChar((_cAlias6)->NOVOPROC)

						Else

							Alert("Problema em calcular proximo numero do novo procedimento.")

						EndIf

						If Select(_cAlias6) > 0
							(_cAlias6)->(DbCloseArea())
						EndIf
						//-----------------------------------------------------
						// FIM - Pegando numeração do procedimento
						//-----------------------------------------------------

						//-----------------------------------------------------
						// INICIO - Pegando informações profissional executante
						//-----------------------------------------------------
						cQuery:= ""

						cQuery += CRLF +  " SELECT "
						cQuery += CRLF +  " 	BB0_NOME,"
						cQuery += CRLF +  " 	BB0_CODSIG,"
						cQuery += CRLF +  " 	BB0_NUMCR,"
						cQuery += CRLF +  " 	BB0_ESTADO,"
						cQuery += CRLF +  " 	BB0_CGC"
						cQuery += CRLF +  " FROM "
						cQuery += CRLF +  " 	BB0010 BB0 "
						cQuery += CRLF +  " WHERE "
						cQuery += CRLF +  " 	BB0.R_E_C_N_O_ IN "
						cQuery += CRLF +  " 	( "
						cQuery += CRLF +  " 		SELECT "
						cQuery += CRLF +  " 			MAX(R_E_C_N_O_) "
						cQuery += CRLF +  " 		FROM "
						cQuery += CRLF +  " 			BB0010 DUPL_BB0 "
						cQuery += CRLF +  " 		WHERE "
						cQuery += CRLF +  " 			DUPL_BB0.BB0_FILIAL = ' ' "
						cQuery += CRLF +  " 			AND DUPL_BB0.BB0_CODSIG = '" + (_cAlias2)->BD6_SIGEXE + "'"
						cQuery += CRLF +  " 			AND DUPL_BB0.BB0_ESTADO = '" + (_cAlias2)->BD6_ESTEXE + "'"
						cQuery += CRLF +  " 			AND DUPL_BB0.BB0_NUMCR  = '" + (_cAlias2)->BD6_REGEXE + "'"
						cQuery += CRLF +  " 			AND DUPL_BB0.BB0_NUMCR <> ' '"
						cQuery += CRLF +  " 			AND DUPL_BB0.BB0_DATBLO = ' '"
						cQuery += CRLF +  " 			AND DUPL_BB0.D_E_L_E_T_ = ' '"
						cQuery += CRLF +  " 	)"

						If Select(_cAlias7) > 0
							(_cAlias7)->(DbCloseArea())
						EndIf

						DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),_cAlias7,.T.,.T.)

						If !(_cAlias7)->(EOF())

							_cNmExec = REPLACE(REPLACE(AllTrim((_cAlias7)->BB0_NOME) ,"'"," "),'"'," ")
							_cCodSig = (_cAlias7)->BB0_CODSIG
							_cNumCR  = (_cAlias7)->BB0_NUMCR
							_cEstEx  = (_cAlias7)->BB0_ESTADO
							_cCPFEx  = (_cAlias7)->BB0_CGC

						EndIf

						If Select(_cAlias7) > 0
							(_cAlias7)->(DbCloseArea())
						EndIf
						//-----------------------------------------------------
						// FIM - Pegando informações profissional executante
						//-----------------------------------------------------
						cQuery:= ""

						cQuery += CRLF +  " INSERT INTO SIGA.RECIPR_PROCEDIMENTO"
						cQuery += CRLF +  " ("
						cQuery += CRLF +  " 	EMPRESA,"
						cQuery += CRLF +  " 	IDLOTE,"
						cQuery += CRLF +  " 	IDGUIA,"
						cQuery += CRLF +  " 	IDPROCEDIMENTO,"
						cQuery += CRLF +  " 	OPERADORA,"
						cQuery += CRLF +  " 	CODIGOPRESTADORNAOPERADORA,"
						cQuery += CRLF +  " 	POSICAOPROFISSIONAL,"
						cQuery += CRLF +  " 	CODIGO,"
						cQuery += CRLF +  " 	TIPOTABELA,"
						cQuery += CRLF +  " 	DATAPRO,"
						cQuery += CRLF +  " 	HORAINICIO,"
						cQuery += CRLF +  " 	HORAFIM,"
						cQuery += CRLF +  " 	QUANTIDADEREALIZADA,"
						cQuery += CRLF +  " 	VALOR,"
						cQuery += CRLF +  " 	VALORTOTAL,"
						cQuery += CRLF +  " 	DESCRICAO,"
						cQuery += CRLF +  " 	CODIGOTABELA,"
						cQuery += CRLF +  " 	CODIGOPROCEDIMENTO,"
						cQuery += CRLF +  " 	CODIGOBARRA,"
						cQuery += CRLF +  " 	TIPODESPESA,"
						cQuery += CRLF +  " 	RECBD6,"
						cQuery += CRLF +  " 	TAB_XML,"
						cQuery += CRLF +  " 	NUMFAT,"
						cQuery += CRLF +  " 	NOMEEXECUTANTE,"
						cQuery += CRLF +  " 	SIGLACONSELHO,"
						cQuery += CRLF +  " 	NUMEROCONSELHO,"
						cQuery += CRLF +  " 	UFCONSELHO,"
						cQuery += CRLF +  " 	CPF"
						cQuery += CRLF +  " )"
						cQuery += CRLF +  " VALUES "
						cQuery += CRLF +  " ("
						cQuery += CRLF +  " 	'CABERJ',"
						cQuery += CRLF +  " 	" + _cNvLote + ","
						cQuery += CRLF +  " 	" + _cNvGuia + ","
						cQuery += CRLF +  " 	" + _cNvProc + ","
						cQuery += CRLF +  " 	'INTEGRAL',"
						cQuery += CRLF +  " 	'" + AllTrim((_cAlias2)->BAU_CODIGO) + "',"
						cQuery += CRLF +  " 	'POSPROF',"
						cQuery += CRLF +  " 	'" + AllTrim((_cAlias2)->CODPSA)     + "',"
						cQuery += CRLF +  " 	'" + AllTrim((_cAlias2)->BR8_CODPAD) + "',"
						cQuery += CRLF +  " 	'" + AllTrim((_cAlias2)->BD6_DATPRO) + "',"
						cQuery += CRLF +  " 	'" + AllTrim((_cAlias2)->HORPRO)     + "',"
						cQuery += CRLF +  " 	'" + AllTrim((_cAlias2)->HORAFIM)    + "',"
						cQuery += CRLF +  " 	 " + cValtoChar((_cAlias2)->BD6_QTDPRO) + ","
						cQuery += CRLF +  " 	'" + cValtoChar((_cAlias2)->VLRUNIT)    + "',"
						cQuery += CRLF +  " 	'" + cValtoChar((_cAlias2)->BD6_VLRTPF) + "',"
						cQuery += CRLF +  " 	'" + REPLACE(REPLACE(AllTrim((_cAlias2)->BR8_DESCRI) ,"'"," "),'"'," ") + "',"
						cQuery += CRLF +  " 	'" + AllTrim((_cAlias2)->BR8_CODPAD )+ "',"
						cQuery += CRLF +  " 	'" + AllTrim((_cAlias2)->CODPSA)     + "',"
						cQuery += CRLF +  " 	' ',"
						cQuery += CRLF +  " 	'" + AllTrim((_cAlias2)->BR8_TPPROC) + "',"
						cQuery += CRLF +  " 	 " + cValToChar((_cAlias2)->RECBD6) + " ,"
						cQuery += CRLF +  " 	'" + AllTrim((_cAlias2)->TAB_XML)    + "',"
						cQuery += CRLF +  " 	'" + AllTrim((_cAlias1)->NUMFAT)    + "',"
						cQuery += CRLF +  " 	'" + AllTrim(_cNmExec) + "',"
						cQuery += CRLF +  " 	'" + AllTrim(_cCodSig) + "',"
						cQuery += CRLF +  " 	'" + AllTrim(_cNumCR ) + "',"
						cQuery += CRLF +  " 	'" + AllTrim(_cEstEx ) + "',"
						cQuery += CRLF +  " 	'" + AllTrim(_cCPFEx ) + "' "
						cQuery += CRLF +  " )"

						If tcSqlExec(cQuery) < 0
							Alert("Erro na inclusão - SIGA.RECIPR_PROCEDIMENTO - Lote:  " + _cNvLote + " - Guia: " + _cNvGuia + "." )
						EndIf

						(_cAlias2)->(DBSKIP())

					EndDo

					cQuery:= ""

					cQuery += CRLF +  " UPDATE"
					cQuery += CRLF +  " 	SIGA.RECIPR_GUIA "
					cQuery += CRLF +  " SET "
					cQuery += CRLF +  " 	SERVICOSEXECUTADOS = " + cValToChar(_nServExe) + ","
					cQuery += CRLF +  " 	DIARIAS = " + cValToChar(_nDiaria) + ","
					cQuery += CRLF +  " 	TAXAS = " + cValToChar(_nTaxas) + ","
					cQuery += CRLF +  " 	MATERIAIS = " + cValToChar(_nMater) + ","
					cQuery += CRLF +  " 	MEDICAMENTOS = " + cValToChar(_nMedicam) + ","
					cQuery += CRLF +  " 	GASES = " + cValToChar(_nGases) + ","
					cQuery += CRLF +  " 	TOTALGERAL = (" + cValtoChar(_nServExe + _nDiaria +_nTaxas + _nMater + _nMedicam + _nGases) + ")"
					cQuery += CRLF +  " WHERE "
					cQuery += CRLF +  "     EMPRESA = 'CABERJ' "
					cQuery += CRLF +  "     AND IDLOTE = '" + _cNvLote + "'"
					cQuery += CRLF +  "     AND IDGUIA = '" + _cNvGuia + "'"

					If tcSqlExec(cQuery) < 0
						Alert("Erro na atualização de valores - Lote:  " + _cNvLote + " - Guia: " + _cNvGuia + "." )
					EndIf

				Else

					Aviso("Atenção","Não foi encontrado itens na BD6 para preencher a tabela de procedimentos (SIGA.RECIPR_PROCEDIMENTO) ",{"OK"})

				EndIf

				If Select(_cAlias2) > 0
					(_cAlias2)->(DbCloseArea())
				EndIf

				(_cAlias1)->(DBSKIP())

			EndDo

		Else
			If _ni = 1
			
				Aviso("Atenção","Não foram encontrado dados para os parametros informados",{"OK"})

			ElseIf _ni = 2

				Aviso("Atenção","Não foram encontrado dados de SADT para os parametros informados, porém foi gerado dados de consulta",{"OK"})

			Else

				Aviso("Atenção","Não foram encontrado dados de SADTI para os parametros informados, porém foi gerado dados de consulta e SADT",{"OK"})

			EndIf

		EndIf

	Next _ni

	If Select(_cAlias1) > 0
		(_cAlias1)->(DbCloseArea())
	EndIf

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} function CABA214G
 Perguntas para a impressão em excel da carga efetuada
@author  Angelo Henrique
@since   date 08/03/2022
@version 1.0
@type function
/*/
//-------------------------------------------------------------------
Static Function CABA214G(cPerg)

	u_CABASX1(cPerg,"01",OemToAnsi("Data de Geração da Carga:")			,"","","mv_ch1","D",10,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","",{},{},{})

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} function CABA214H
 Rotina para iniciar o processo de impressão em relatório
@author  Angelo Henrique
@since   date 08/03/2022
@version 1.0
@type function
/*/
//-------------------------------------------------------------------
Static Function CABA214H(cPerg)

	Local oSection2		:= Nil
	Local oReport		:= Nil
	Local aAreaSM0  	:= SM0->(GetArea())
	Local cTit 			:= "Relatório de Conferência de Carga Repasse"
	Private contador 	:= 1

	cDesCRel := cTit

	//??????????????????????????????????????
	//?Criacao do componente de impressao                                     ?
	//?oReport():New                                                          ?
	//?ExpC1 : Nome do relatorio                                              ?
	//?ExpC2 : Titulo                                                         ?
	//?ExpC3 : Pergunte                                                       ?
	//?ExpB4 : Bloco de codigo que sera executado na confirmacao da impressao ?
	//?ExpC5 : Descricao                                                      ?
	//??????????????????????????????????????
	cDesl:= "Este relatorio tem como objetivo imprimir a conferência da Carga efetuada no repasse ."
	oReport:= TReport():New(cPerg,cTit,cPerg, {|oReport| CABA214I(oReport)},cDescRel)
	oReport:SetLandScape()
	oReport:SetTotalInLine(.T.)

	Pergunte(oReport:uParam,.F.)

	oSection2 := TRSection():New(oReport,"Carga efetuada em: " + DTOC(MV_PAR01) + "." ,{}, , ,) //"Documento"

	// Colunas do relatório
	TRCell():New(oSection2,"EMPRESA"	,,"EMPRESA"		 	, ""	,20	,,{|| (cAliasTRB)->EMPRESA              } ,"LEFT"  , ,"LEFT"  )
	TRCell():New(oSection2,"IDLOTE"		,,"ID LOTE"		    , ""	,20	,,{|| cValToChar((cAliasTRB)->IDLOTE)   } ,"LEFT"  , ,"LEFT"  )
	TRCell():New(oSection2,"TIPOLOTE"	,,"TIPO DO LOTE"    , ""	,20	,,{|| (cAliasTRB)->TIPOLOTE             } ,"LEFT"  , ,"LEFT"  )
	TRCell():New(oSection2,"XML_GERADO" ,,"XML GERADO"		, ""	,20 ,,{|| (cAliasTRB)->XML_GERADO           } ,"LEFT"  , ,"LEFT"  )

	RestArea( aAreaSM0 )

Return(oReport)


//-------------------------------------------------------------------
/*/{Protheus.doc} function CABA214I
 Rotina que irá montar a query
@author  Angelo Henrique
@since   date 08/03/2022
@version 1.0
@type function
/*/
//-------------------------------------------------------------------
Static Function CABA214I(oReport)

	Local oSection2		:= Nil
	Local cQry 			:= " "

	Private cAliasTRB  	:= GetNextAlias()
	Private aArea1  	:= {}

	oSection2 := oReport:Section(1)

	cQry += " SELECT                                             " + CRLF
	cQry += "     EMPRESA,                                       " + CRLF
	cQry += "     IDLOTE,                                        " + CRLF
	cQry += "     TIPOLOTE,                                      " + CRLF
	cQry += "     XML_GERADO                                     " + CRLF
	cQry += " FROM                                               " + CRLF
	cQry += "     RECIPR_LOTE                                    " + CRLF
	cQry += " WHERE                                              " + CRLF
	cQry += "     DATAREGISTROTRANSACAO ='" + DTOS(MV_PAR01) + "'" + CRLF
	cQry += " ORDER BY IDLOTE                                    " + CRLF

	dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQry),cAliasTRB,.T.,.T.)

	dbSelectArea(cAliasTRB)
	(cAliasTRB)->(dbgotop())

	oReport:SetMeter((cAliasTRB)->(LastRec()))

	//Imprime os dados do relatorio
	If (cAliasTRB)->(Eof())
		Alert("Não foram encontrados dados de carga com a data informada!")
	Else

		oSection2:Init()

		While  !(cAliasTRB)->(Eof())

			oReport:IncMeter()
			oSection2:PrintLine()

			(cAliasTRB)->(DbSkip())
		Enddo

		oReport:FatLine()
		oReport:Section(1):Finish()

		(cAliasTRB)->(DbCloseArea())

	EndIf

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} function CABA214J
 Rotina para exibir em tela o total da carga
@author  Angelo Henrique
@since   date 08/03/2022
@version 1.0
@type function
/*/
//-------------------------------------------------------------------
Static Function CABA214J

	Local _cPerg    := "CABA214J"
	Local cQry 		:= " "
	Local cAliasTRB := GetNextAlias()

	Aviso("Atenção","Será calculado o Total da Carga Efetuado, favor preencher os parametros a seguir.",{"OK"})

	CABA214K(_cPerg)

	IF Pergunte(_cPerg, .T.)

		cQry += " SELECT                                                                          " + CRLF
		cQry += "     SUM(TOTALGERAL)  TOTAL                                                      " + CRLF
		cQry += " FROM                                                                            " + CRLF
		cQry += "     RECIPR_GUIA                                                                 " + CRLF
		cQry += " WHERE                                                                           " + CRLF
		cQry += "     IDLOTE BETWEEN '" + AllTrim(MV_PAR01) + "' AND '" + AllTrim(MV_PAR02) + "'  " + CRLF

		dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQry),cAliasTRB,.T.,.T.)

		dbSelectArea(cAliasTRB)
		(cAliasTRB)->(dbgotop())

		//Imprime os dados do relatorio
		If (cAliasTRB)->(Eof())
			Alert("Não foram encontrado os lotes informados!")
		Else

			Aviso("Atenção","Total de Carga: " + cValToChar((cAliasTRB)->TOTAL),{"OK"})

		EndIf

		(cAliasTRB)->(DbCloseArea())

	EndIf

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} function CABA214K
 Rotina para elaborar as perguntas do total da carga
@author  Angelo Henrique
@since   date 08/03/2022
@version 1.0
@type function
/*/
//-------------------------------------------------------------------
Static Function CABA214K(_cPerg)

	u_CABASX1(_cPerg,"01",OemToAnsi("Lote De:" )    ,"","","mv_ch1","C",06,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","",{},{},{})
	u_CABASX1(_cPerg,"02",OemToAnsi("Lote Ate:")	,"","","mv_ch2","C",06,0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","",{},{},{})

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} function CABA214L
 Rotina para elaborar as perguntas das Guias de Internação
@author  Angelo Henrique
@since   date 09/03/2022
@version 1.0
@type function
/*/
//-------------------------------------------------------------------
Static Function CABA214L(cPerg)

	u_CABASX1(cPerg,"01",OemToAnsi("Empresa:")	    ,"","","mv_ch1","C",TAMSX3("BA1_CODEMP")[1] ,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","",{},{},{})
	u_CABASX1(cPerg,"02",OemToAnsi("Faturamento:")	,"","","mv_ch2","C",TAMSX3("BD6_NUMFAT")[1] ,0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","",{},{},{})
	u_CABASX1(cPerg,"03",OemToAnsi("Lote De:" )     ,"","","mv_ch3","C",06                      ,0,0,"G","","","","","mv_par03","","","","","","","","","","","","","","","","",{},{},{})
	u_CABASX1(cPerg,"04",OemToAnsi("Lote Ate:")	    ,"","","mv_ch4","C",06                      ,0,0,"G","","","","","mv_par04","","","","","","","","","","","","","","","","",{},{},{})

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} function CABA214M
 Rotina para iniciar o processo de impressão em relatório
@author  Angelo Henrique
@since   date 09/03/2022
@version 1.0
@type function
/*/
//-------------------------------------------------------------------
Static Function CABA214M(cPerg)

	Local oSection2		:= Nil
	Local oReport		:= Nil
	Local aAreaSM0  	:= SM0->(GetArea())
	Local cTit 			:= "Relatório de Conferência de Carga Repasse"
	Private contador 	:= 1

	cDesCRel := cTit

	//??????????????????????????????????????
	//?Criacao do componente de impressao                                     ?
	//?oReport():New                                                          ?
	//?ExpC1 : Nome do relatorio                                              ?
	//?ExpC2 : Titulo                                                         ?
	//?ExpC3 : Pergunte                                                       ?
	//?ExpB4 : Bloco de codigo que sera executado na confirmacao da impressao ?
	//?ExpC5 : Descricao                                                      ?
	//??????????????????????????????????????
	cDesl:= "Esta rotina tem como objetivo imprimir a as guias de internação no processo de repasse ."
	oReport:= TReport():New(cPerg,cTit,cPerg, {|oReport| CABA214N(oReport)},cDescRel)
	oReport:SetLandScape()
	oReport:SetTotalInLine(.T.)

	Pergunte(oReport:uParam,.F.)

	oSection2 := TRSection():New(oReport,"Guias Internação " ,{}, , ,) //"Documento"

	// Colunas do relatório
	TRCell():New(oSection2,"DATA_PROCE"		,,"DATA_PROCE"		, ""	,20	,,{|| (cAliasTRB)->DATA_PROCE		} ,"LEFT"  , ,"LEFT"  )
	TRCell():New(oSection2,"COD_EMP"		,,"COD_EMP"		    , ""	,20	,,{|| (cAliasTRB)->COD_EMP		    } ,"LEFT"  , ,"LEFT"  )
	TRCell():New(oSection2,"MATRIC"			,,"MATRIC"			, ""	,20	,,{|| (cAliasTRB)->MATRIC			} ,"LEFT"  , ,"LEFT"  )
	TRCell():New(oSection2,"NOME_USUAR"		,,"NOME_USUAR"		, ""	,20	,,{|| (cAliasTRB)->NOME_USUAR       } ,"LEFT"  , ,"LEFT"  )
	TRCell():New(oSection2,"COD_RDA"		,,"COD_RDA"		    , ""	,20	,,{|| (cAliasTRB)->COD_RDA	        } ,"LEFT"  , ,"LEFT"  )
	TRCell():New(oSection2,"TAB"			,,"TAB"			    , ""	,20	,,{|| (cAliasTRB)->TAB              } ,"LEFT"  , ,"LEFT"  )
	TRCell():New(oSection2,"COD_PROCED"		,,"COD_PROCED"		, ""	,20	,,{|| (cAliasTRB)->COD_PROCED       } ,"LEFT"  , ,"LEFT"  )
	TRCell():New(oSection2,"DESC_PROCES"	,,"DESC_PROCES"	    , ""	,50	,,{|| (cAliasTRB)->DESC_PROCES      } ,"LEFT"  , ,"LEFT"  )
	TRCell():New(oSection2,"SIG_PROF_SOLIC"	,,"SIG_PROF_SOLIC"	, ""	,20	,,{|| (cAliasTRB)->SIG_PROF_SOLIC	} ,"LEFT"  , ,"LEFT"  )
	TRCell():New(oSection2,"EST_PROF_SOLIC"	,,"EST_PROF_SOLIC"	, ""	,20	,,{|| (cAliasTRB)->EST_PROF_SOLIC	} ,"LEFT"  , ,"LEFT"  )
	TRCell():New(oSection2,"NOME_PROF"		,,"NOME_PROF"		, ""	,20	,,{|| (cAliasTRB)->NOME_PROF        } ,"LEFT"  , ,"LEFT"  )
	TRCell():New(oSection2,"SOLIC_REG"		,,"SOLIC_REG"		, ""	,20	,,{|| (cAliasTRB)->SOLIC_REG        } ,"LEFT"  , ,"LEFT"  )
	TRCell():New(oSection2,"QTDA"			,,"QTDA"			, ""	,20	,,{|| (cAliasTRB)->QTDA             } ,"LEFT"  , ,"LEFT"  )
	TRCell():New(oSection2,"VALOR"			,,"VALOR"			, ""	,20	,,{|| (cAliasTRB)->VALOR            } ,"LEFT"  , ,"LEFT"  )
	TRCell():New(oSection2,"TPCUST"			,,"TPCUST"			, ""	,20	,,{|| (cAliasTRB)->TPCUST           } ,"LEFT"  , ,"LEFT"  )

	RestArea( aAreaSM0 )

Return(oReport)


//-------------------------------------------------------------------
/*/{Protheus.doc} function CABA214N
 Rotina que irá montar a query
@author  Angelo Henrique
@since   date 09/03/2022
@version 1.0
@type function
/*/
//-------------------------------------------------------------------
Static Function CABA214N(oReport)

	Local oSection2		:= Nil
	Local cQry 			:= " "

	Private cAliasTRB  	:= GetNextAlias()
	Private aArea1  	:= {}

	oSection2 := oReport:Section(1)

	//----------------------------------------------------------------
	//A query deve estar com as tabelas fixas, pois algumas tabelas
	//olha caberj e outras olha integral para esse processo de repasse
	//----------------------------------------------------------------
	cQry += " SELECT 																																			" + CRLF
	cQry += "     DATA_ATEND Data_Proce,                                                                                                                        " + CRLF
	cQry += "     CODEMP Cod_Emp ,                                                                                                                              " + CRLF
	cQry += "     MATRICULA_CAB Matric ,                                                                                                                        " + CRLF
	cQry += "     NOME Nome_Usuar , 	                                                                                                                        " + CRLF
	cQry += "     '999997' Cod_Rda ,                                                                                                                            " + CRLF
	cQry += "     TABELA TAB ,                                                                                                                                  " + CRLF
	cQry += "     PROCEDIMENTO Cod_Proced , 	                                                                                                                " + CRLF
	cQry += "     DESPRO Desc_Proces	,                                                                                                                       " + CRLF
	cQry += "     SIGLA  Sig_Prof_Solic,	                                                                                                                    " + CRLF
	cQry += "     ESTSOL Est_Prof_Solic,	                                                                                                                    " + CRLF
	cQry += "     NOMSOL Nome_Prof,                                                                                                                             " + CRLF
	cQry += "     REGSOL Solic_Reg,                                                                                                                             " + CRLF
	cQry += "     QTDPRO Qtda,                                                                                                                                  " + CRLF
	cQry += "     (VL_PART) Valor,                                                                                                                              " + CRLF
	cQry += "     tpcust                                                                                                                                        " + CRLF
	cQry += " FROM                                                                                                                                              " + CRLF
	cQry += "     (                                                                                                                                             " + CRLF
	cQry += "      SELECT                                                                                                                                       " + CRLF
	cQry += "         substr(BD7_NUMLOT,1,6) REF,                                                                                                               " + CRLF
	cQry += "         BA1_CODINT || BA1_CODEMP || BA1_MATRIC || BA1_TIPREG || BA1_DIGITO  MATRICULA_CAB,                                                        " + CRLF
	cQry += "         TRIM(BA1_NOMUSR) NOME,                                                                                                                    " + CRLF
	cQry += "         BD6_OPEUSR||BD6_CODEMP||BD6_MATRIC||BD6_TIPREG MATRICULA_INTEG,                                                                           " + CRLF
	cQry += "         BD6_CODPAD TABELA ,                                                                                                                       " + CRLF
	cQry += "         BD6_CODPRO PROCEDIMENTO,                                                                                                                  " + CRLF
	cQry += "         BD6_DESPRO DESPRO,                                                                                                                        " + CRLF
	cQry += "         BA1_CPFUSR,                                                                                                                               " + CRLF
	cQry += "         BA1_DATBLO,                                                                                                                               " + CRLF
	cQry += "         BD6_SIGLA SIGLA ,	                                                                                                                        " + CRLF
	cQry += "         BD6_ESTSOL ESTSOL,                                                                                                                        " + CRLF
	cQry += "         BD6_NOMSOL NOMSOL,                                                                                                                        " + CRLF
	cQry += "         BD6_REGSOL REGSOL,                                                                                                                        " + CRLF
	cQry += "         'Conta' Tipo,                                                                                                                             " + CRLF
	cQry += "         BD7F.VLRPAG Vl_Aprov ,                                                                                                                    " + CRLF
	cQry += "         BA1_CODEMP  CODEMP ,                                                                                                                      " + CRLF
	cQry += "         BD7F.QTDE QTDPRO ,                                                                                                                        " + CRLF
	cQry += "         TO_DATE(TRIM(bd6_datpro),'YYYYMMDD') DATA_ATEND,                                                                                          " + CRLF
	cQry += "         (Decode(BD6F.BD6_BLOCPA,'1',0,Decode(Sign(BD6F.BD6_VLRTPF),-1,0,BD6F.BD6_VLRTPF)))VL_PART,                                                " + CRLF
	cQry += "         zzt_tpcust tpcust                                                                                                                         " + CRLF
	cQry += "        FROM                                                                                                                                       " + CRLF
	cQry += "             (                                                                                                                                     " + CRLF
	cQry += "                 SELECT                                                                                                                            " + CRLF
	cQry += "                     BD7.BD7_FILIAL,                                                                                                               " + CRLF
	cQry += "                     BD7_CODPLA,                                                                                                                   " + CRLF
	cQry += "                     SIGA_TIPO_EXPOSICAO_ANS_INT(BD7_CODEMP,BD7_MATRIC,BD7_TIPREG,TO_DATE(TRIM(BD7_DATPRO),'YYYYMMDD')) EXPOS,                     " + CRLF
	cQry += "                     BD7.BD7_OPELOT,BD7.BD7_NUMLOT,                                                                                                " + CRLF
	cQry += "                     BD7.BD7_CODOPE, BD7.BD7_CODLDP, BD7.BD7_CODPEG, BD7.BD7_NUMERO, BD7.BD7_ORIMOV, BD7_CODPRO,                                   " + CRLF
	cQry += "                     BD7.BD7_SEQUEN,  SUM(BD7.BD7_VLRPAG) AS VLRPAG,                                                                               " + CRLF
	cQry += "                     COUNT(DISTINCT BD7_CODEMP||BD7_MATRIC||BD7_TIPREG) QTDE                                                                       " + CRLF
	cQry += "                 FROM                                                                                                                              " + CRLF
	cQry += "                     BD7010 BD7                                                                                                                    " + CRLF
	cQry += "                 WHERE                                                                                                                             " + CRLF
	cQry += "                     BD7.BD7_FILIAL=' '                                                                                                            " + CRLF
	cQry += "                     AND BD7.BD7_CODOPE = '0001'                                                                                                   " + CRLF
	cQry += "                     AND BD7.BD7_SITUAC = '1'                                                                                                      " + CRLF
	cQry += "                     AND BD7.BD7_FASE = '4'                                                                                                        " + CRLF
	cQry += "                     AND BD7.BD7_VLRPAG > 0                                                                                                        " + CRLF
	cQry += "                     AND BD7.BD7_BLOPAG <> '1'                                                                                                     " + CRLF
	cQry += "                     AND bd7_codemp = '" + MV_PAR01 + "'                                                                                           " + CRLF
	cQry += "                     AND BD7.D_E_L_E_T_ = ' '                                                                                                      " + CRLF
	cQry += "                 GROUP BY                                                                                                                          " + CRLF
	cQry += "                     BD7_FILIAL,                                                                                                                   " + CRLF
	cQry += "                     BD7_CODPLA,                                                                                                                   " + CRLF
	cQry += "                     BD7.BD7_OPELOT,                                                                                                               " + CRLF
	cQry += "                     BD7.BD7_NUMLOT,                                                                                                               " + CRLF
	cQry += "                     SIGA_TIPO_EXPOSICAO_ANS_INT(BD7_CODEMP,BD7_MATRIC,BD7_TIPREG,TO_DATE(TRIM(BD7_DATPRO),'YYYYMMDD')),                           " + CRLF
	cQry += "                     BD7_CODPRO,                                                                                                                   " + CRLF
	cQry += "                     BD7_FILIAL,                                                                                                                   " + CRLF
	cQry += "                     BD7_CODOPE,                                                                                                                   " + CRLF
	cQry += "                     BD7_CODLDP,                                                                                                                   " + CRLF
	cQry += "                     BD7_CODPEG,                                                                                                                   " + CRLF
	cQry += "                     BD7_NUMERO,                                                                                                                   " + CRLF
	cQry += "                     BD7_ORIMOV,                                                                                                                   " + CRLF
	cQry += "                     BD7_SEQUEN                                                                                                                    " + CRLF
	cQry += "             ) BD7F,                                                                                                                               " + CRLF
	cQry += "             BD6010 BD6F,                                                                                                                          " + CRLF
	cQry += "             BI3010 BI3 ,                                                                                                                          " + CRLF
	cQry += "             ZZT010 ZZT ,                                                                                                                          " + CRLF
	cQry += "             BG9010 BG9,                                                                                                                           " + CRLF
	cQry += "             ba1020 ba1                                                                                                                            " + CRLF
	cQry += "                                                                                                                                                   " + CRLF
	cQry += "     WHERE                                                                                                                                         " + CRLF
	cQry += "         ZZT_FILIAL=' '                                                                                                                            " + CRLF
	cQry += "         AND BI3_FILIAL=' '                                                                                                                        " + CRLF
	cQry += "         AND BD6F.BD6_FILIAL=' '                                                                                                                   " + CRLF
	cQry += "         AND BG9_FILIAL=' '                                                                                                                        " + CRLF
	cQry += "         AND BA1_FILIAL=' '                                                                                                                        " + CRLF
	cQry += "         AND BD7F.BD7_FILIAL = BD6F.BD6_FILIAL                                                                                                     " + CRLF
	cQry += "         AND BD7F.BD7_CODOPE = BD6F.BD6_CODOPE                                                                                                     " + CRLF
	cQry += "         AND BD7F.BD7_CODLDP = BD6F.BD6_CODLDP                                                                                                     " + CRLF
	cQry += "         AND BD7F.BD7_CODPEG = BD6F.BD6_CODPEG                                                                                                     " + CRLF
	cQry += "         AND BD7F.BD7_NUMERO = BD6F.BD6_NUMERO                                                                                                     " + CRLF
	cQry += "         AND BD7F.BD7_ORIMOV = BD6F.BD6_ORIMOV                                                                                                     " + CRLF
	cQry += "         AND BD7F.BD7_SEQUEN = BD6F.BD6_SEQUEN                                                                                                     " + CRLF
	cQry += "         AND BD6F.BD6_CODPRO = BD7F.BD7_CODPRO                                                                                                     " + CRLF
	cQry += "         AND BI3_FILIAL =BD7_FILIAL                                                                                                                " + CRLF
	cQry += "         AND BI3_CODINT=BD7_CODOPE                                                                                                                 " + CRLF
	cQry += "         AND BI3_CODIGO=BD7_CODPLA                                                                                                                 " + CRLF
	cQry += "         AND BD6_YNEVEN=ZZT_CODEV                                                                                                                  " + CRLF
	cQry += "         AND BD6_OPEUSR=BG9_CODINT                                                                                                                 " + CRLF
	cQry += "         AND BD6_CODEMP=BG9_CODIGO                                                                                                                 " + CRLF
	cQry += "         AND BD6_NUMFAT = '" + MV_PAR02 + "'                                                                                                       " + CRLF
	cQry += "         AND BA1_CODINT = BD6_CODOPE																												" + CRLF
	cQry += "         AND BA1_YMTREP LIKE  BD6_OPEUSR || BD6_CODEMP || BD6_MATRIC || BD6_TIPREG||'%'                                                            " + CRLF
	cQry += "         and ba1.r_e_c_n_o_ = (																													" + CRLF
    cQry += "                 select																															" + CRLF
    cQry += "                     MAX(ba1_c.r_e_c_n_o_)																											" + CRLF
    cQry += "                 from																																" + CRLF
    cQry += "                     ba1020 ba1_c																													" + CRLF
    cQry += "                 where																																" + CRLF
    cQry += "                     ba1.BA1_FILIAL      = ba1_c.BA1_FILIAL																						" + CRLF
    cQry += "                     AND ba1.BA1_CODINT  = ba1_c.BA1_CODINT																						" + CRLF
    cQry += "                     AND ba1.BA1_YMTREP  = ba1_c.BA1_YMTREP																						" + CRLF
    cQry += "                     AND BA1_c.D_E_L_E_T_ = ' '  																									" + CRLF
    cQry += "              )																																	" + CRLF
	cQry += "         AND BD6F.D_E_L_E_T_ = ' '                                                                                                                 " + CRLF
	cQry += "         AND BI3.D_E_L_E_T_ = ' '                                                                                                                  " + CRLF
	cQry += "         AND ZZT.D_E_L_E_T_ = ' '                                                                                                                  " + CRLF
	cQry += "         AND BG9.D_E_L_E_T_ = ' '                                                                                                                  " + CRLF
	cQry += "         AND BA1.D_E_L_E_T_ = ' '                                                                                                                  " + CRLF
	cQry += "         AND  BD6F.BD6_CODOPE || BD6F.BD6_CODLDP || BD6F.BD6_CODPEG || BD6F.BD6_NUMERO || BD6F.BD6_ORIMOV || BD6F.BD6_SEQUEN || BD6F.BD6_CODPRO IN " + CRLF
	cQry += "         (                                                                                                                                         " + CRLF
	cQry += "             SELECT                                                                                                                                " + CRLF
	cQry += "                 BD6_CODOPE || BD6_CODLDP || BD6_CODPEG || BD6_NUMERO || BD6_ORIMOV || BD6_SEQUEN || BD6_CODPRO                                    " + CRLF
	cQry += "             FROM                                                                                                                                  " + CRLF
	cQry += "                 BD6010                                                                                                                            " + CRLF
	cQry += "             WHERE                                                                                                                                 " + CRLF
	cQry += "                 BD6_FILIAL = ' '                                                                                                                  " + CRLF
	cQry += "                 AND D_e_l_e_t_ = ' '                                                                                                              " + CRLF
	cQry += "                 AND BD6_NUMFAT = '" + MV_PAR02 + "' 				                                                                                " + CRLF
	cQry += "                 AND NOT EXISTS (                                                                                                                  " + CRLF
	cQry += "                                 SELECT                                                                                                            " + CRLF
	cQry += "                                     *                                                                                                             " + CRLF
	cQry += "                                 FROM                                                                                                              " + CRLF
	cQry += "                                     RECIPR_GUIA REC                                                                                               " + CRLF
	cQry += "                                 WHERE                                                                                                             " + CRLF
	cQry += "                                     IDLOTE BETWEEN '" + MV_PAR03 + "' AND '" + MV_PAR04 + "'                                                      " + CRLF
	cQry += "                                     AND REC.OPE||REC.LDP||REC.PEG||REC.NUMGUIA = BD6_CODOPE ||BD6_CODLDP||BD6_CODPEG||BD6_NUMERO                  " + CRLF
	cQry += "                                 )                                                                                                                 " + CRLF
	cQry += "         )                                                                                                                                         " + CRLF
	cQry += "     )                                                                                                                                             " + CRLF

	dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQry),cAliasTRB,.T.,.T.)

	dbSelectArea(cAliasTRB)
	(cAliasTRB)->(dbgotop())

	oReport:SetMeter((cAliasTRB)->(LastRec()))

	//Imprime os dados do relatorio
	If (cAliasTRB)->(Eof())
		Alert("Não foram encontrados dados de carga com a data informada!")
	Else

		oSection2:Init()

		While  !(cAliasTRB)->(Eof())

			oReport:IncMeter()
			oSection2:PrintLine()

			(cAliasTRB)->(DbSkip())
		Enddo

		oReport:FatLine()
		oReport:Section(1):Finish()

		(cAliasTRB)->(DbCloseArea())

	EndIf

Return

/*/{Protheus.doc} CABA214O
Rotina para realizar a exclusão dos dados gerados nas tabelas 
@type function
@version  1.0
@author angelo.cassago
@since 20/10/2022
/*/
Static Function CABA214O()

	Local _cPerg    := "CABA214O"
	Local cQuery	:= ""

	Avsio("Atenção","Esse processo irá limpar todos os dados gerados na carga.",{"OK"})

	CABA214K(_cPerg)

	IF Pergunte(_cPerg, .T.)

		If !Empty(MV_PAR01) .AND. !Empty(MV_PAR02)

			cQuery := "delete 	" + CRLF
			cQuery += "from		" + CRLF
			cQuery += "	SIGA.RECIPR_PROCEDIMENTO " + CRLF 
			cQuery += "where	" + CRLF
			cQuery += "	idlote between '" + MV_PAR01 + "' and '" + MV_PAR02 + "' " + CRLF

			If TcSqlExec(cQuery) <> 0
				Aviso("Atenção","Erro na execuçao da exclusão da carga de reciprocidade, tabela: RECIPR_PROCEDIMENTO.",{"OK"})
				Aviso("Atenção","Favor entrar em contato com a TI.",{"OK"})
			Else

				cQuery := "delete	" + CRLF
				cQuery += "from		" + CRLF
				cQuery += "	SIGA.RECIPR_GUIA " + CRLF
				cQuery += "where	" + CRLF
				cQuery += "	idlote between '" + MV_PAR01 + "' and '" + MV_PAR02 + "' " + CRLF

				If TcSqlExec(cQuery) <> 0
					Aviso("Atenção","Erro na execuçao da exclusão da carga de reciprocidade, tabela: RECIPR_GUIA .",{"OK"})
					Aviso("Atenção","Favor entrar em contato com a TI.",{"OK"})
				Else

					cQuery := "delete	" + CRLF
					cQuery += "from		" + CRLF
					cQuery += "SIGA.RECIPR_LOTE	" + CRLF 
					cQuery += "where	" + CRLF
					cQuery += "idlote between '" + MV_PAR01 + "' and '" + MV_PAR02 + "' " + CRLF

					If TcSqlExec(cQuery) <> 0
						Aviso("Atenção","Erro na execuçao da exclusão da carga de reciprocidade, tabela: RECIPR_LOTE.",{"OK"})
						Aviso("Atenção","Favor entrar em contato com a TI.",{"OK"})
					Else
						Aviso("Atenção","Exclusão da carga de reciprocidade finalizada.",{"OK"})
					EndIf
					
				EndIf

			EndIf

		Else

			AVsio("Atenção","Nenhum parametro preenchido.",{"OK"})

		EndIf

	EndIf

Return
