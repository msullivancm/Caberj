#Include "RwMake.ch"
#Include "Protheus.ch"
#Include "TopConn.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ CABR015  ºAutor  ³ Frederico O. C. Jr º Data ³  01/11/21   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³   Relatório / Extrator de importador de copart.		      º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±º          ³                                                            º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function CABR015()

Local cCadastro		:= "Extração de Coparticipações - Integ. Gestão de Pessoal"
Local aSays			:= {}
Local aButtons		:= {}

Private cPerg       := "CABR015"

ValidPerg()

Pergunte(cPerg,.F.)

aAdd(aSays,"Rotina para a geração de arquivo de conferência das parametrizações,")
aAdd(aSays,"bem como dos valores de coparticipação a serem integrados à Folha de Pagamento.")
aAdd(aButtons,{5,.T.,{|o| Pergunte(cPerg,.T.)}})
aAdd(aButtons,{1,.T.,{|o| Processa( {|| ExecGer(), FechaBatch()}, "Aguarde...") }})
aAdd(aButtons,{2,.T.,{|o| FechaBatch()}})

FormBatch(cCadastro,aSays,aButtons)

return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ ExecGer  ºAutor  ³ Frederico O. C Jr  º Data ³  01/11/21   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³   Execução da extração                                     º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ExecGer()

Local cQuery		:= ""
Local cAliasQry		:= GetNextAlias()
Local nTotSeq		:= 0
Local nContSq		:= 0
Local nCtExp		:= 0
Local aHeader		:= {}

Local aAux			:= {}
Local nHdl			:= 0
Local cArq			:= ""
Local cCmpDe		:= SubStr(DtoS(StoD(mv_par02 + "15") + 30), 1, 6)
Local cCmpAte		:= SubStr(DtoS(StoD(mv_par03 + "15") + 30), 1, 6)

if Select(cAliasQry) > 0
	DbSelectArea(cAliasQry)
	(cAliasQry)->(dbCloseArea())
endif

IncProc("Buscando dados para a geração das coparticipações!")

cQuery := " SELECT MATRICULA, CAD_TIT_PLANO, SEQUENCIA, CAD_DEP_PLANO, TIPO_USUARIO, ORIGEM, VERBA,"											+;
				 " COMPETENCIA, CPF_USUARIO, DATA_NASC_USUARIO, NOME_USUARIO, SUM(VALOR) AS VALOR"
cQuery += " FROM (SELECT BA3.BA3_AGMTFU AS MATRICULA,"																							+;
					   " CASE WHEN RHK.RHK_MAT <> ' ' THEN 'Sim' ELSE 'Nao' END AS CAD_TIT_PLANO,"												+;
					   " CASE WHEN BA1.BA1_TIPUSU = 'T' THEN '  ' ELSE"																			+;
						 " CASE WHEN SRB.RB_COD <> ' ' THEN SRB.RB_COD ELSE '??' END END AS SEQUENCIA,"											+;
					   " CASE WHEN RHL.RHL_CODIGO <> ' ' OR BA1.BA1_TIPUSU = 'T' THEN 'Sim' ELSE 'Nao' END AS CAD_DEP_PLANO,"					+;
					   " CASE WHEN BA1.BA1_TIPUSU = 'T' THEN 'Titular' ELSE"																	+;
						 " CASE WHEN BA1.BA1_TIPUSU = 'D' THEN 'Dependente' ELSE 'Outro' END END AS TIPO_USUARIO,"								+;
					   " CASE WHEN BA1.BA1_TIPUSU = 'T' THEN '1' ELSE '2' END AS ORIGEM,"														+;
					   " CASE WHEN BA1.BA1_TIPUSU = 'T' THEN '503' ELSE '504' END AS VERBA,"													+;
					   " BM1.BM1_ANO||BM1.BM1_MES COMPETENCIA,"																					+;
					   " BM1.BM1_VALOR * DECODE(BM1.BM1_TIPO, '1', 1, -1) VALOR,"																+;
					   " BA1.BA1_CPFUSR CPF_USUARIO,"																							+;
					   " BA1.BA1_DATNAS DATA_NASC_USUARIO,"																						+;
					   " BA1.BA1_NOMUSR NOME_USUARIO"
cQuery +=		" FROM " + RetSqlName("BM1") + " BM1"
cQuery +=		  " INNER JOIN " + RetSqlName("BA1") + " BA1"
cQuery +=			" ON (    BA1.BA1_FILIAL = BM1.BM1_FILIAL"																					+;
						" AND BA1.BA1_CODINT = BM1.BM1_CODINT"																					+;
						" AND BA1.BA1_CODEMP = BM1.BM1_CODEMP"																					+;
						" AND BA1.BA1_MATRIC = BM1.BM1_MATRIC"																					+;
						" AND BA1.BA1_TIPREG = BM1.BM1_TIPREG)"
cQuery +=		  " INNER JOIN " + RetSqlName("BA3") + " BA3"
cQuery +=			" ON (    BA3.BA3_FILIAL = BA1.BA1_FILIAL"																					+;
						" AND BA3.BA3_CODINT = BA1.BA1_CODINT"																					+;
						" AND BA3.BA3_CODEMP = BA1.BA1_CODEMP"																					+;
						" AND BA3.BA3_MATRIC = BA1.BA1_MATRIC)"
cQuery +=		  " INNER JOIN " + RetSqlName("BFQ") + " BFQ"
cQuery +=			" ON (    BFQ.BFQ_FILIAL = BM1.BM1_FILIAL"																					+;
						" AND BFQ.BFQ_CODINT = BM1.BM1_CODINT"																					+;
						" AND BFQ.BFQ_PROPRI = SUBSTR(BM1_CODTIP,1,1)"																			+;
						" AND BFQ.BFQ_CODLAN = SUBSTR(BM1_CODTIP,2,2))"
cQuery +=		  " LEFT JOIN " + RetSqlName("SRA") + " SRA"
cQuery +=			" ON (    SRA.D_E_L_E_T_ = ' '"																								+;
						" AND SRA.RA_FILIAL  = '" + xFilial("SRA") + "'"																		+;
						" AND SRA.RA_MAT     = BA3.BA3_AGMTFU)"
cQuery +=		  " LEFT JOIN " + RetSqlName("RHK") + " RHK"
cQuery +=			" ON (    RHK.D_E_L_E_T_ = ' '"																								+;
						" AND RHK.RHK_FILIAL = SRA.RA_FILIAL"																					+;
						" AND RHK.RHK_MAT    = SRA.RA_MAT"																						+;
						" AND BM1.BM1_ANO||BM1.BM1_MES >= SUBSTR(RHK.RHK_PERINI,3,4)||SUBSTR(RHK.RHK_PERINI,1,2)"								+;
						" AND (BM1.BM1_ANO||BM1.BM1_MES <= SUBSTR(RHK.RHK_PERFIM,3,4)||SUBSTR(RHK.RHK_PERFIM,1,2) OR RHK.RHK_PERFIM = ' ')"		+;
						" AND RHK_TPFORN = '1')"						// ASSISTENCIAL (NÃO TEM COPART ODONTOLOGICA)
cQuery +=		  " LEFT JOIN " + RetSqlName("SRB") + " SRB"
cQuery +=			" ON (    SRB.D_E_L_E_T_ = ' '"																								+;
						" AND SRB.RB_FILIAL  = SRA.RA_FILIAL"																					+;
						" AND SRB.RB_MAT     = SRA.RA_MAT"																						+;
						" AND SRB.RB_CIC     = BA1.BA1_CPFUSR)"
cQuery +=		  " LEFT JOIN " + RetSqlName("RHL") + " RHL"
cQuery +=			" ON (    RHL.D_E_L_E_T_ = ' '"																								+;
						" AND RHL.RHL_FILIAL = SRB.RB_FILIAL"																					+;
						" AND RHL.RHL_MAT    = SRB.RB_MAT"																						+;
						" AND RHL.RHL_CODIGO = SRB.RB_COD"																						+;
						" AND BM1.BM1_ANO||BM1.BM1_MES >= SUBSTR(RHL.RHL_PERINI,3,4)||SUBSTR(RHL.RHL_PERINI,1,2)	"							+;
						" AND (BM1.BM1_ANO||BM1.BM1_MES <= SUBSTR(RHL.RHL_PERFIM,3,4)||SUBSTR(RHL.RHL_PERFIM,1,2) OR RHL.RHL_PERFIM = ' ')"		+;
						" AND RHL.RHL_TPFORN = '1')"					// ASSISTENCIAL (NÃO TEM COPART ODONTOLOGICA)
cQuery +=		" WHERE BM1.D_E_L_E_T_ = ' ' AND BA1.D_E_L_E_T_ = ' ' AND BA3.D_E_L_E_T_ = ' ' AND BFQ.D_E_L_E_T_ = ' '"
cQuery +=		  " AND BM1.BM1_FILIAL = '" + xFilial("BM1") + "'"
cQuery +=		  " AND BM1.BM1_CODINT = '0001'"
cQuery +=		  " AND BM1.BM1_CODEMP = '0003'"
cQuery +=		  " AND BA3.BA3_AGMTFU <> ' '"
cQuery +=		  " AND (   (BA1.BA1_CONEMP = '000000000001' AND BA1.BA1_SUBCON IN ('000000002','000000003','000000004'))"
cQuery +=			   " OR (BA1.BA1_CONEMP = '000000000002' AND BA1.BA1_SUBCON = '000000001'))"
cQuery +=		  " AND BFQ.BFQ_YTPANL = 'C'"
cQuery +=		  " AND BFQ.BFQ_ATIVO  = '1'"

// filtro por competencia
cQuery +=		  " AND BM1_ANO||BM1_MES BETWEEN '" + cCmpDe + "' and '" + cCmpAte + "'"

cQuery +=		" )"
cQuery += " GROUP BY  MATRICULA, CAD_TIT_PLANO, SEQUENCIA, CAD_DEP_PLANO, TIPO_USUARIO, ORIGEM, VERBA, COMPETENCIA, CPF_USUARIO, DATA_NASC_USUARIO, NOME_USUARIO"
cQuery += " ORDER BY MATRICULA, SEQUENCIA"

TcQuery cQuery New Alias (cAliasQry)

dbeval({||nTotSeq++ },,{||(cAliasQry)->(!EOF())})

ProcRegua(nTotSeq)

if mv_par01 == 1		// Conferência

	if !ApOleClient("MsExcel")
		Alert("Você precisa ter o Microsoft Excel instalado no seu computador.")
		return
	endif

	aAux	:= U_ImpCabXML(cPerg)
	nHdl	:= aAux[1]
	cArq	:= aAux[2]

	if nHdl <> -1 .and. !empty(cArq)

		aAdd(aHeader,	'MATRIC. FUNCIONAL'				)
		aAdd(aHeader,	'HAB. PLANO MED. - TITULAR'		)
		aAdd(aHeader,	'SEQUENCIA DEPEND.'				)
		aAdd(aHeader,	'HAB. PLANO MED. - DEPEND.'		)
		aAdd(aHeader,	'TIPO USUARIO'					)
		aAdd(aHeader,	'COD. VERBA'					)
		aAdd(aHeader,	'COMPETENCIA'					)
		aAdd(aHeader,	'CPF USUARIO'					)
		aAdd(aHeader,	'DATA NASC. USUARIO'			)
		aAdd(aHeader,	'NOME USUARIO'					)

		U_ImpPriXML(nHdl, aHeader)

		(cAliasQry)->(DbGoTop())
		while (cAliasQry)->(!EOF())

			nContSq++
			IncProc("Processando..." + CHR(13)+CHR(10) + "Registro: " + AllTrim(Str(nContSq)) + " / " + AllTrim(Str(nTotSeq)) )

			// Inicio da Impressão da linha
			cLinha := "<Row>" + CHR(13)+CHR(10)
			cLinha += U_ImpLinXML( (cAliasQry)->MATRICULA												, 1)
			cLinha += U_ImpLinXML( (cAliasQry)->CAD_TIT_PLANO											, 1)
			cLinha += U_ImpLinXML( (cAliasQry)->SEQUENCIA												, 1)
			cLinha += U_ImpLinXML( (cAliasQry)->CAD_DEP_PLANO											, 1)
			cLinha += U_ImpLinXML( (cAliasQry)->TIPO_USUARIO					     					, 1)
			cLinha += U_ImpLinXML( (cAliasQry)->VERBA							     					, 1)
			cLinha += U_ImpLinXML( SubStr(DtoS(StoD((cAliasQry)->COMPETENCIA + "15") - 30), 1, 6)		, 1)
			cLinha += U_ImpLinXML( (cAliasQry)->CPF_USUARIO						     					, 1)
			cLinha += U_ImpLinXML( StoD((cAliasQry)->DATA_NASC_USUARIO)									, 3)
			cLinha += U_ImpLinXML( (cAliasQry)->NOME_USUARIO					     					, 1)
			cLinha += '</Row>' + CHR(13)+CHR(10)

			FWRITE ( nHdl , cLinha )

			(cAliasQry)->(DbSkip())
		end
		(cAliasQry)->(DbCloseArea())

		cArq := U_ImpRodXML(nHdl, cArq)

		if ApOleClient("MsExcel")

			IncProc("Aguarde... Abrindo Excel")

			oExcelApp := MsExcel():New()
			oExcelApp:WorkBooks:Open(cArq)
			oExcelApp:SetVisible(.T.)
			oExcelApp:Destroy()

		else
			MsgStop("Microsoft Excel não instalado." + CHR(13)+CHR(10) + "Arquivo: " + cArq )
		endif
	
	else
		MsgStop("O arquivo não pode ser criado! Entre em contato com o administrador do sistema.")
		return
	endif

else		// Geração de arquivo de integração GPE

	cArq	:= "C:\integração\"
	MontaDir(cArq)

	cArq	+= "integracao_copart_" + DtoS(DATE()) + "_" + StrTran( time(), ":", "") + ".txt"

	nHdl	:= FCreate(cArq)

	if nHdl <> -1

		(cAliasQry)->(DbGoTop())
		while (cAliasQry)->(!EOF())

			nContSq++
			IncProc("Processando..." + CHR(13)+CHR(10) + "Registro: " + AllTrim(Str(nContSq)) + " / " + AllTrim(Str(nTotSeq)) )

			if AllTrim((cAliasQry)->CAD_TIT_PLANO) == "Sim" .and. AllTrim((cAliasQry)->CAD_DEP_PLANO) == "Sim"

				nCtExp++

				// Inicio da Impressão da linha
				cLinha := (cAliasQry)->MATRICULA
				cLinha += (cAliasQry)->SEQUENCIA
				cLinha += (cAliasQry)->ORIGEM
				cLinha += (cAliasQry)->VERBA
				cLinha += SubStr(DtoS(StoD((cAliasQry)->COMPETENCIA + "15") - 30), 1, 6)
				cLinha += StrZero(int((cAliasQry)->VALOR),5) + "." + StrZero(((cAliasQry)->VALOR - int((cAliasQry)->VALOR)) * 100, 2)
				cLinha += " "
				cLinha += (cAliasQry)->CPF_USUARIO
				cLinha += CHR(13)+CHR(10)

				FWRITE ( nHdl , cLinha )

			endif

			(cAliasQry)->(DbSkip())
		end
		(cAliasQry)->(DbCloseArea())

		FCLOSE ( nHdl  )

		if nContSq == nCtExp

			MsgInfo("Geração do arquivo efetuada com sucesso!" 								+ CHR(13)+CHR(10) +;
					"O mesmo se encontra no diretório: [ C:\integração\ ] ")
		
		else

			MsgInfo( AllTrim(str(nContSq - nCtExp)) + " registros não puderam ser gerados." + CHR(13)+CHR(10) +;
			 		"Analise os mesmos na geração no modo de 'conferencia'."				+ CHR(13)+CHR(10) +;
					"O arquivo gerado se encontra no diretório: [ C:\integração\ ] ")
			
		endif

	else

		MsgStop("O arquivo não pode ser criado! Entre em contato com o administrador do sistema.")
		return
		
	endif

endif

return


*********************************************************************************************************************
Static Function ValidPerg()
*********************************************************************************************************************

Local aRegs		:= {}

aAdd(aRegs,{cPerg,"01","Tipo Execução?"			,"","","mv_ch1","N", 1,0,0,"C","","mv_par01","Conferencia","","","","","Extracao","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"02","Comp. Inic. (AAAAMM)?"	,"","","mv_ch2","C", 6,0,0,"G","","mv_par02",""			  ,"","","","",""		 ,"","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"03","Comp. Fim (AAAAMM)?"	,"","","mv_ch3","C", 6,0,0,"G","","mv_par03",""			  ,"","","","",""		 ,"","","","","","","","","","","","","","","","","","","",""})

PlsVldPerg( aRegs )

return
