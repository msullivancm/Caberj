#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"
#INCLUDE "topconn.Ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABA021   ºAutor  ³ Frederico O. C. Jr º Data ³  27/01/2022 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³  Importação do Cadastro de Profissionais de Saúde 		  º±±
±±º          ³ disponibilizados no site do CFM (Conselho Federal de       º±±
±±º          ³ Medicina).											      º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ MP8                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function CABA021

Local oDlg
Local oArquiv
Local cDiret	:= space(100)
Local nOpcao	:= 0
Local oProcess
Local lAux		:= .T.

DEFINE MSDIALOG oDlg TITLE OemToAnsi("Importação de Profissionais de Saúde - CFM") FROM 000,000 TO 230,410	PIXEL

	@006,008 SAY "Rotina para importação/atualização dos profissionais de saúde"						PIXEL OF oDlg
	
	@018,018 SAY "* 1- Tratamento exclusivo para o Conselho Federal do Mediciana (CFM);"				PIXEL OF oDlg
	@030,018 SAY "* 2- Rotina irá importar novos profissionais, bem como atualizar os"					PIXEL OF oDlg
	@038,018 SAY "        já existentes no cadastro."													PIXEL OF oDlg
	
	@061,008 SAY "Arquivo:"																 				PIXEL OF oDlg
	@060,035 MsGet oArquiv		VAR cDiret		SIZE 140,008		When .F.							PIXEL OF oDlg
	@060,178 BUTTON "..." SIZE 015,010 PIXEL ACTION (cDiret := cGetFile("","Selecione o diretório:",,"",.F.,GETF_LOCALHARD+GETF_RETDIRECTORY ) )
															 //cGetFile("Arquivo Texto (*.txt) | *.txt", OemToAnsi("Selecione Arquivo"),,"",.F.,GETF_LOCALHARD+GETF_NETWORKDRIVE,.F.)
	
	@085,045 BUTTON "CONFIRMAR"	SIZE 050,010 PIXEL ACTION (nOpcao := 1, Close(oDlg))
	@085,107 BUTTON "CANCELAR"	SIZE 050,010 PIXEL ACTION Close(oDlg)

ACTIVATE DIALOG oDlg CENTERED

if nOpcao == 1

	if !empty(cDiret)

		if MsgYesNo("Deseja carregar os dados atualizados para a base do CFM no sistema?")

			oProcess := MsNewProcess():New({|| CABA021B(oProcess, cDiret)}, "Atualizando base do CFM...", "Aguarde...", .T.)
			oProcess:Activate()
		
		endif

		// Verificar profissionais da PA7 que ainda não existem na BB0 (e migrá-los)
		Processa({|| CABA021C(cDiret)}, "Incluindo profissionais de saúde...")
		
		// Verificar profissionais com dados divergentes entre a PA7 e a BB0 (e atualizá-los)
		Processa({|| CABA021D(cDiret)}, "Atualizando profissionais de saúde...")

		// Verificar se tem algum status novo (não tratado) nos arquivos do CFM para parametrizar
		Processa({|| lAux := CABA021E(cDiret)}, "Checando novos status não parametrizados...")

		if lAux

			// Verificar profissionais que devam ser bloqueados/desbloqueados com base no status enviado pelo CFM
			Processa({|| CABA021F(cDiret)}, "Bloqueando/desbloqueando profissionais de saúde...")

			MsgInfo("Importação finalizada com sucesso!")
		
		else

			MsgInfo("Importação não atualizou o bloqueio/desbloqueio devido a não ter todos os status da CFM parametrizado!")
		
		endif
	
	else
		MsgInfo("Não foi selecionado nenhum diretório para o processamento!")
	endif

endif

return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ CABA021A ºAutor  ³ Frederico O. C. Jr º Data ³  25/02/22   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³   Cadastro de status do prof. de saude			          º±±
±±º          ³                                                            º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function CABA021A()

Local cVldAlt	:= ".T."
Local cVldExc	:= ".T."
Local cMsg		:= "Cadastro de Status - Prof. Saude"
Private cTabela	:= "ZS1"

DbSelectArea(cTabela)
DbSetOrder(1)

AxCadastro(cTabela, cMsg, cVldExc, cVldAlt)

return


//----------------------------------------------------------------------------------------------//
//	Função para processar a importação dos proficionais de saúde								//
//----------------------------------------------------------------------------------------------//
Static Function CABA021B(oProcess, cDiret)

Local aArquivs		:= Directory(cDiret + "*.txt")
Local i				:= 0
Local cEstado		:= ""
Local nHdl			:= 0
Local nHdl2			:= 0
Local nTotSeq		:= 0
Local nContSq		:= 0
Local nTotPrf		:= 0
Local cBuffer		:= ""
Local aAux			:= {}
Local cExtracao		:= ""
Local cNumCR		:= ""
Local cAux			:= ""
Local x				:= 0
Local cNome			:= ""
Local cStatus		:= ""
Local cEspec		:= ""

if len(aArquivs) > 0

	nHdl2	:= FCREATE( cDiret + "1_Log_Atualizacao_CFM_" + DtoS(date()) + "-" + StrTran(time(), ":", "") + ".csv")

	if nHdl2 <> -1

		cExtracao := "UF;Linha;Numero CR;Log" + CHR(13)+CHR(10)
		FWRITE ( nHdl2 , cExtracao )

		oProcess:SetRegua1( len(aArquivs) )

		for i := 1 to len(aArquivs)

			cEstado	:= SubStr(aArquivs[i][1],1,2)
			nContSq	:= 0

			oProcess:IncRegua1( AllTrim(str(i)) + "/" + AllTrim(str(len(aArquivs))) + " - Importando profissionais: " + cEstado)

			nHdl	:= FT_FUse( cDiret + aArquivs[i][1] )

			if nHdl <> -1

				nTotSeq	:= FT_FLastRec()	// Retorna o número de linhas do arquivo

				oProcess:SetRegua2(nTotSeq)

				FT_FGoTop()
				while !FT_FEOF()
				
					nTotPrf++
					oProcess:IncRegua2("Profissional: " + AllTrim(Str(nContSq)) + " / " + AllTrim(Str(nTotSeq)))

					cBuffer	:= FT_FReadLn() // Retorna a linha corrente
					aAux	:= StrTokArr2 (cBuffer, '!', .T.)
					
					if len(aAux) == 6

						nContSq++

						//01 - Numero CR
						//02 - UF
						//03 - Nome
						//04 - Principal ou Secundária
						//05 - Status
						//06 - Especialidade

						if !empty(aAux[1]) .and. len( AllTrim(aAux[2]) ) == 2 .and. !empty(aAux[3]) .and. !empty(aAux[5])

							cNumCR	:= AllTrim(aAux[1])
							cAux	:= ""

							// Tratamento para retirar todos os caracteres não numericos enviados
							for x := 1 to len( cNumCR )
								if IsDigit( SubStr(cNumCR, x, 1) )
									cAux += SubStr(cNumCR, x, 1)
								endif
							next
							cNumCR	:= PadR( cAux, TamSX3('PA7_CRM')[1])

							PA7->(DbSetOrder(1))	// PA7_FILIAL+PA7_CRM+PA7_EST
							if !PA7->(DbSeek( xFilial("PA7") + cNumCR + aAux[2]  ))

								PA7->( RecLock("PA7",.T.) )
									PA7->PA7_FILIAL	:= xFilial("PA7")
									PA7->PA7_CRM	:= cNumCR
									PA7->PA7_EST    := aAux[2]
									PA7->PA7_NOME   := NoAcento(DecodeUTF8(AllTrim(aAux[3]), "cp1252"))
									PA7->PA7_STATUS	:= NoAcento(DecodeUTF8(AllTrim(aAux[5]), "cp1252"))
									PA7->PA7_ESPECI	:= NoAcento(DecodeUTF8(AllTrim(aAux[6]), "cp1252"))
								PA7->( MsUnlock() )

								cExtracao := AllTrim(aAux[2]) + ";" + AllTrim(str(nContSq)) + ";" + AllTrim(aAux[1]) + ";Importacao realizada"
							
							else

								cNome		:= AllTrim(NoAcento(DecodeUTF8(aAux[3], "cp1252")))
								cStatus		:= AllTrim(NoAcento(DecodeUTF8(aAux[5], "cp1252")))
								cEspec		:= AllTrim(NoAcento(DecodeUTF8(aAux[6], "cp1252")))

								if !(cNome == AllTrim(PA7->PA7_NOME)) .or. !(cStatus == AllTrim(PA7->PA7_STATUS)) .or. !(cEspec == AllTrim(PA7->PA7_ESPECI))

									PA7->( RecLock("PA7",.F.) )
										PA7->PA7_NOME   := cNome
										PA7->PA7_STATUS	:= cStatus
										PA7->PA7_ESPECI	:= cEspec
									PA7->( MsUnlock() )

									cExtracao := AllTrim(aAux[2]) + ";" + AllTrim(str(nContSq)) + ";" + AllTrim(aAux[1]) + ";Profissional atualizado"
								
								else

									cExtracao := AllTrim(aAux[2]) + ";" + AllTrim(str(nContSq)) + ";" + AllTrim(aAux[1]) + ";Ja importado"
								
								endif
							
							endif

							cExtracao	+= CHR(13)+CHR(10)
							FWRITE ( nHdl2 , cExtracao )
						
						else
							cExtracao := AllTrim(aAux[2]) + ";" + AllTrim(str(nContSq)) + ";" + AllTrim(aAux[1]) + ";UF/Numero/Nome/Status nao informado(s)" + CHR(13)+CHR(10)
							FWRITE ( nHdl2 , cExtracao )
						endif
						
					else
						cExtracao := cEstado + ";" + AllTrim(str(nContSq)) + ";" + ";Quantidade incorreto de colunas" + CHR(13)+CHR(10)
						FWRITE ( nHdl2 , cExtracao )
					endif

					FT_FSkip()	// Pula para próxima linha
				end
				
				FT_FUse()
				FCLOSE ( nHdl  )
			
			else
				alert("Erro na abertura do arquivo: [" + aArquivs[i][1] + "]. Entre em contato com o administrador do sistema.")
			endif
		
		next

		MsgInfo( AllTrim(str(nTotPrf)) + " profissionais de saúde do CFM importados!")

	else
		alert("Erro na criação do arquivo de log. Entre em contato com o administrador do sistema.")
	endif

	FCLOSE ( nHdl2 )

else
	MsgInfo("Não existe nenhum arquivo '.TXT' no diretório informado!")
endif

return



//----------------------------------------------------------------------------------//
// Levar profissionais novos para a tabela de profissional de saúde					//
//----------------------------------------------------------------------------------//
Static Function CABA021C(cDiret)

Local cQuery		:= ""
Local cAliasQry		:= GetNextAlias()
Local nTotSeq		:= 0
Local nContSq		:= 0
Local nHdl2			:= 0

cQuery := " select count(*) CONTAGEM"
cQuery += " from " + RetSqlName("PA7") + " PA7"
cQuery += " where PA7.D_E_L_E_T_ =  ' '"
cQuery +=	" and PA7_FILIAL = '" + xFilial("PA7") + "'"
cQuery +=	" and not exists (select BB0_NUMCR"
cQuery +=					" from " + RetSqlName("BB0") + " BB0"
cQuery +=					" where BB0.D_E_L_E_T_ = ' '"
cQuery +=					  " and BB0_FILIAL = '" + xFilial("BB0") + "'"
cQuery +=					  " and BB0_ESTADO = PA7_EST"
cQuery +=					  " and BB0_NUMCR  = PA7_CRM"
cQuery +=					  " and BB0_CODSIG = 'CRM'"
cQuery +=					  " and BB0_CODOPE = '0001')"
cQuery += " order by PA7_EST, PA7_CRM"

TcQuery cQuery New Alias (cAliasQry)

nTotSeq	:= (cAliasQry)->CONTAGEM
ProcRegua( nTotSeq )

(cAliasQry)->(DbCloseArea())

cQuery := " select PA7_CRM, PA7_EST, PA7_NOME, PA7_STATUS, PA7_ESPECI"
cQuery += " from " + RetSqlName("PA7") + " PA7"
cQuery += " where PA7.D_E_L_E_T_ =  ' '"
cQuery +=	" and PA7_FILIAL = '" + xFilial("PA7") + "'"
cQuery +=	" and not exists (select BB0_NUMCR"
cQuery +=					" from " + RetSqlName("BB0") + " BB0"
cQuery +=					" where BB0.D_E_L_E_T_ = ' '"
cQuery +=					  " and BB0_FILIAL = '" + xFilial("BB0") + "'"
cQuery +=					  " and BB0_ESTADO = PA7_EST"
cQuery +=					  " and BB0_NUMCR  = PA7_CRM"
cQuery +=					  " and BB0_CODSIG = 'CRM'"
cQuery +=					  " and BB0_CODOPE = '0001')"
cQuery += " order by PA7_EST, PA7_CRM"

TcQuery cQuery New Alias (cAliasQry)

//nTotSeq	:= (cAliasQry)->(RecCount())

(cAliasQry)->(DbGoTop())

if (cAliasQry)->(!EOF())

	nHdl2	:= FCREATE( cDiret + "2_Log_Adicao_Prof_Saude_" + DtoS(date()) + "-" + StrTran(time(), ":", "") + ".csv")

	if nHdl2 <> -1

		cExtracao := "UF;Numero CR;Log" + CHR(13)+CHR(10)
		FWRITE ( nHdl2 , cExtracao )

		while (cAliasQry)->(!EOF())

			nContSq++
			IncProc("Profissional: " + AllTrim(Str(nContSq)) + " / " + AllTrim(Str(nTotSeq)) )

			U_GravaBB0((cAliasQry)->PA7_EST, (cAliasQry)->PA7_CRM, "CRM", (cAliasQry)->PA7_NOME, "2", (cAliasQry)->PA7_STATUS, (cAliasQry)->PA7_ESPECI )

			cExtracao := AllTrim((cAliasQry)->PA7_EST) + ";" + AllTrim((cAliasQry)->PA7_CRM) + ";Profissional integrado" + CHR(13)+CHR(10)
			FWRITE ( nHdl2 , cExtracao )

			(cAliasQry)->(DbSkip())
		end
	
	else
		alert("Erro na criação do arquivo de log. Entre em contato com o administrador do sistema.")
	endif

	FCLOSE ( nHdl2 )

endif
(cAliasQry)->(DbCloseArea())

return


//------------------------------------------------------------------------------------------------------------------//
// Levar dados desatualizados de nome, status e especialidade para a tabela de profissional de saúde				//
//------------------------------------------------------------------------------------------------------------------//
Static Function CABA021D(cDiret)

Local cQuery		:= ""
Local cAliasQry		:= GetNextAlias()
Local nTotSeq		:= 0
Local nContSq		:= 0
Local nHdl2			:= 0

cQuery := " select count(*) CONTAGEM"
cQuery += " from " + RetSqlName("BB0") + " BB0"
cQuery +=	" inner join " + RetSqlName("PA7") + " PA7"
cQuery +=	  " on (    PA7_FILIAL = BB0_FILIAL"
cQuery +=		  " and PA7_CRM    = BB0_NUMCR"
cQuery +=		  " and PA7_EST    = BB0_ESTADO)"
cQuery += " where BB0.D_E_L_E_T_ =  ' ' and PA7.D_E_L_E_T_ =  ' '"
cQuery +=	" and BB0_FIlIAL = '" + xFilial("BB0") + "'"
cQuery +=	" and BB0_CODSIG = 'CRM'"
cQuery +=	" and BB0_CODOPE = '0001'"
cQuery +=	" and (   BB0_NOME   <> SubStr(PA7_NOME,1,40)"
cQuery +=		 " or BB0_XSTATU <> PA7_STATUS"
cQuery +=		 " or BB0_XESPEC <> PA7_ESPECI)"
cQuery += " order by PA7_EST, PA7_CRM"

TcQuery cQuery New Alias (cAliasQry)

nTotSeq	:= (cAliasQry)->CONTAGEM
ProcRegua( nTotSeq )

(cAliasQry)->(DbCloseArea())

cQuery := " select BB0.R_E_C_N_O_ as BB0REC, PA7.R_E_C_N_O_ as PA7REC"
cQuery += " from " + RetSqlName("BB0") + " BB0"
cQuery +=	" inner join " + RetSqlName("PA7") + " PA7"
cQuery +=	  " on (    PA7_FILIAL = BB0_FILIAL"
cQuery +=		  " and PA7_CRM    = BB0_NUMCR"
cQuery +=		  " and PA7_EST    = BB0_ESTADO)"
cQuery += " where BB0.D_E_L_E_T_ =  ' ' and PA7.D_E_L_E_T_ =  ' '"
cQuery +=	" and BB0_FIlIAL = '" + xFilial("BB0") + "'"
cQuery +=	" and BB0_CODSIG = 'CRM'"
cQuery +=	" and BB0_CODOPE = '0001'"
cQuery +=	" and (   BB0_NOME   <> SubStr(PA7_NOME,1,40)"
cQuery +=		 " or BB0_XSTATU <> PA7_STATUS"
cQuery +=		 " or BB0_XESPEC <> PA7_ESPECI)"
cQuery += " order by PA7_EST, PA7_CRM"

TcQuery cQuery New Alias (cAliasQry)

//nTotSeq	:= (cAliasQry)->(RecCount())

(cAliasQry)->(DbGoTop())

if (cAliasQry)->(!EOF())

	nHdl2	:= FCREATE( cDiret + "3_Log_Atualiza_Prof_Saude_" + DtoS(date()) + "-" + StrTran(time(), ":", "") + ".csv")

	if nHdl2 <> -1

		cExtracao := "UF;Numero;Nome Anterior;Nome Novo;Status Anterior;Status Novo;Especialidade Anterior;Especialidade Nova" + CHR(13)+CHR(10)
		FWRITE ( nHdl2 , cExtracao )

		while (cAliasQry)->(!EOF())

			nContSq++
			IncProc("Profissional: " + AllTrim(Str(nContSq)) + " / " + AllTrim(Str(nTotSeq)) )

			BB0->(DbGoTo( (cAliasQry)->BB0REC ))
			PA7->(DbGoTo( (cAliasQry)->PA7REC ))

			cExtracao := AllTrim(PA7->PA7_EST) + ";" + AllTrim(PA7->PA7_CRM) + ";"
			cExtracao += iif(BB0->BB0_NOME   <> SubStr(PA7->PA7_NOME,1,40),	BB0->BB0_NOME   + ";" + SubStr(PA7->PA7_NOME,1,40), "-;-") + ";"
			cExtracao += iif(BB0->BB0_XSTATU <> PA7->PA7_STATUS,			BB0->BB0_XSTATU + ";" + PA7->PA7_STATUS			  , "-;-") + ";"
			cExtracao += iif(BB0->BB0_XESPEC <> PA7->PA7_ESPECI,			BB0->BB0_XESPEC + ";" + PA7->PA7_ESPECI			  , "-;-") + CHR(13)+CHR(10)
			FWRITE ( nHdl2 , cExtracao )

			BB0->( RecLock("BB0",.F.) )
				BB0->BB0_NOME   := PA7->PA7_NOME
				BB0->BB0_XSTATU	:= PA7->PA7_STATUS
				BB0->BB0_XESPEC	:= PA7->PA7_ESPECI
			BB0->( MsUnlock() )

			(cAliasQry)->(DbSkip())
		end

	endif

	FCLOSE ( nHdl2 )

endif
(cAliasQry)->(DbCloseArea())

return


//----------------------------------------------------------------------//
// Ientificar se existe status novo na carga do CFM						//
//----------------------------------------------------------------------//
Static Function CABA021E(cDiret)

Local lRet			:= .T.
Local cQuery		:= ""
Local cAliasQry		:= GetNextAlias()
Local nHdl2			:= 0
Local cStatNC		:= ""

cQuery := " select unique BB0_XSTATU"
cQuery += " from " + RetSqlName("BB0") + " BB0"
cQuery += " where BB0.D_E_L_E_T_ = ' '"
cQuery +=	" and BB0_FIlIAL = '" + xFilial("BB0") + "'"
cQuery +=	" and not exists (select ZS1_STATUS"
cQuery +=					" from " + RetSqlName("ZS1") + " ZS1"
cQuery +=					" where ZS1.D_E_L_E_T_ = ' '"
cQuery +=					  " and ZS1_FILIAL = '" + xFilial("ZS1") + "'"
cQuery +=					  " and ZS1_STATUS = BB0_XSTATU)"
cQuery += " order by BB0_XSTATU"

TcQuery cQuery New Alias (cAliasQry)

(cAliasQry)->(DbGoTop())
while (cAliasQry)->(!EOF())

	if !empty((cAliasQry)->BB0_XSTATU)
		cStatNC	+= AllTrim((cAliasQry)->BB0_XSTATU) + CHR(13)+CHR(10)
	endif

	(cAliasQry)->(DbSkip())
end
(cAliasQry)->(DbCloseArea())

if !empty(cStatNC)

	lRet	:= .F.

	nHdl2	:= FCREATE( cDiret + "4_Log_Status_Nao_Parametrizado_" + DtoS(date()) + "-" + StrTran(time(), ":", "") + ".csv")

	if nHdl2 <> -1

		cExtracao := "Status Sem Parametrizacao" + CHR(13)+CHR(10)
		FWRITE ( nHdl2 , cExtracao )

		FWRITE ( nHdl2 , cStatNC )
	
	endif

	FCLOSE ( nHdl2 )

	Alert("Existem novos status enviados no arquivo do CFM não parametrizados no sistema, são eles:" + CHR(13)+CHR(10) + CHR(13)+CHR(10) + cStatNC +;
			CHR(13)+CHR(10) + CHR(13)+CHR(10) + "É necessário efetuar este cadastro antes de seguir com a importação!" )
	
endif

return lRet


//------------------------------------------------------------------------------//
// Bloquear/Desbloquear profissionais com base no status do CFM					//
//------------------------------------------------------------------------------//
Static Function CABA021F(cDiret)

Local cQuery		:= ""
Local cAliasQry		:= GetNextAlias()
Local nTotSeq		:= 0
Local nContSq		:= 0
Local nHdl2			:= 0

cQuery := " select count(*) CONTAGEM"
cQuery += " from " + RetSqlName("BB0") + " BB0"
cQuery +=	" inner join " + RetSqlName("ZS1") + " ZS1"
cQuery +=	  " on (    ZS1_FILIAL = '" + xFilial("ZS1") + "'"
cQuery +=		  " and ZS1_STATUS = BB0_XSTATU)"
cQuery += " where BB0.D_E_L_E_T_ = ' ' and ZS1.D_E_L_E_T_ = ' '"
cQuery +=	" and BB0_FIlIAL = '" + xFilial("BB0") + "'"
cQuery +=	" and BB0_CODSIG = 'CRM'"
cQuery +=	" and BB0_CODOPE = '0001'"
cQuery +=	" and (   (ZS1_ACAO = '1' and BB0_CODBLO <> ' ')"	// deveria estar ativo - mas esta bloqueado
cQuery +=		 " or (ZS1_ACAO = '0' and BB0_CODBLO =  ' '))"	// deveria estar bloqueado - mas esta ativo
cQuery += " order by BB0_ESTADO, BB0_NUMCR"

TcQuery cQuery New Alias (cAliasQry)

nTotSeq	:= (cAliasQry)->CONTAGEM
ProcRegua( nTotSeq )

(cAliasQry)->(DbCloseArea())

cQuery := " select BB0.R_E_C_N_O_ as BB0REC, ZS1_ACAO, ZS1_MOTIVO"
cQuery += " from " + RetSqlName("BB0") + " BB0"
cQuery +=	" inner join " + RetSqlName("ZS1") + " ZS1"
cQuery +=	  " on (    ZS1_FILIAL = '" + xFilial("ZS1") + "'"
cQuery +=		  " and ZS1_STATUS = BB0_XSTATU)"
cQuery += " where BB0.D_E_L_E_T_ = ' ' and ZS1.D_E_L_E_T_ = ' '"
cQuery +=	" and BB0_FIlIAL = '" + xFilial("BB0") + "'"
cQuery +=	" and BB0_CODSIG = 'CRM'"
cQuery +=	" and BB0_CODOPE = '0001'"
cQuery +=	" and (   (ZS1_ACAO = '1' and BB0_CODBLO <> ' ')"	// deveria estar ativo - mas esta bloqueado
cQuery +=		 " or (ZS1_ACAO = '0' and BB0_CODBLO =  ' '))"	// deveria estar bloqueado - mas esta ativo
cQuery += " order by BB0_ESTADO, BB0_NUMCR"

TcQuery cQuery New Alias (cAliasQry)

//nTotSeq	:= (cAliasQry)->(RecCount())

(cAliasQry)->(DbGoTop())

if (cAliasQry)->(!EOF())

	nHdl2	:= FCREATE( cDiret + "5_Log_Bloqueio_Desbloqueio_" + DtoS(date()) + "-" + StrTran(time(), ":", "") + ".csv")

	if nHdl2 <> -1

		cExtracao := "UF;Numero;Status CFM;Acao;Cod. Bloq.;Cod. Desbloq.;Descrição / Log;Data;Bloq. Retirado" + CHR(13)+CHR(10)
		FWRITE ( nHdl2 , cExtracao )

		while (cAliasQry)->(!EOF())

			nContSq++
			IncProc("Profissional: " + AllTrim(Str(nContSq)) + " / " + AllTrim(Str(nTotSeq)) )

			BB0->(DbGoTo( (cAliasQry)->BB0REC ))

			cExtracao := AllTrim(BB0->BB0_ESTADO) + ";" + AllTrim(BB0->BB0_NUMCR) + ";" + AllTrim(BB0->BB0_XSTATU) + ";"

			BAP->(DbSetOrder(1))	// BAP_FILIAL+BAP_CODBLO
			if BAP->(DbSeek(xFilial("BAP") + (cAliasQry)->ZS1_MOTIVO ))

				if (cAliasQry)->ZS1_ACAO == "0"		// bloquear

					cExtracao += "Bloquear" + ";" + (cAliasQry)->ZS1_MOTIVO + ";;" + AllTrim(BAP->BAP_DESCRI) + ";" + DtoC(date()) + ";" + CHR(13)+CHR(10)
					FWRITE ( nHdl2 , cExtracao )

					Begin Transaction
					
						BB0->( RecLock("BB0",.F.) )
							BB0->BB0_CODBLO		:= (cAliasQry)->ZS1_MOTIVO
							BB0->BB0_DATBLO		:= date()
						BB0->( MsUnlock() )

						B17->( RecLock("B17",.T.) )
							B17->B17_FILIAL		:= xFilial("B17")
							B17->B17_CODPFS		:= BB0->BB0_CODIGO
							B17->B17_DATA		:= date()
							B17->B17_HORA		:= StrTran(time(),":","")
							B17->B17_MOTBLO		:= (cAliasQry)->ZS1_MOTIVO
							B17->B17_OBS		:= "Atualização com base no status do CFM"
							B17->B17_TIPO		:= "0"
							B17->B17_USUOPE		:= cUserName
						B17->( MsUnlock() )
					
					End Transaction

				else

					cExtracao += "Desbloquear" + ";;" + (cAliasQry)->ZS1_MOTIVO + ";" + AllTrim(BAP->BAP_DESCRI) + ";" + DtoC(date()) + ";"
					cExtracao += BB0->BB0_CODBLO + CHR(13)+CHR(10)
					FWRITE ( nHdl2 , cExtracao )

					Begin Transaction
					
						BB0->( RecLock("BB0",.F.) )
							BB0->BB0_CODBLO		:= " "
							BB0->BB0_DATBLO		:= StoD(" ")
						BB0->( MsUnlock() )

						B17->( RecLock("B17",.T.) )
							B17->B17_FILIAL		:= xFilial("B17")
							B17->B17_CODPFS		:= BB0->BB0_CODIGO
							B17->B17_DATA		:= date()
							B17->B17_HORA		:= StrTran(time(),":","")
							B17->B17_MOTBLO		:= (cAliasQry)->ZS1_MOTIVO
							B17->B17_OBS		:= "Atualização com base no status do CFM"
							B17->B17_TIPO		:= "1"
							B17->B17_USUOPE		:= cUserName
						B17->( MsUnlock() )
					
					End Transaction

				endif

			else

				cExtracao += "Inconsistencia" + ";"
				cExtracao += iif((cAliasQry)->ZS1_ACAO == "2", (cAliasQry)->ZS1_MOTIVO + ";", ";" + (cAliasQry)->ZS1_MOTIVO ) + ";"
				cExtracao += "Motivo não cadastrado" + ";;" + CHR(13)+CHR(10)
				FWRITE ( nHdl2 , cExtracao )
			
			endif

			(cAliasQry)->(DbSkip())
		end

	endif

	FCLOSE ( nHdl2 )

endif
(cAliasQry)->(DbCloseArea())

return


//----------------------------------------------------------------------------------------------//
//	Função generica para gravação do profissional de saúde										//
//----------------------------------------------------------------------------------------------//
User Function GravaBB0(cEst, cNum, cSigla, cNome, cOrigem, cStatPrf, cEspec)

Default cStatPrf	:= ""
Default cEspec		:= ""

cEst	:= PadR( AllTrim(cEst),   TamSX3('BB0_ESTADO')[1])
cNum	:= PadR( AllTrim(cNum),   TamSX3('BB0_NUMCR' )[1])
cSigla	:= PadR( AllTrim(cSigla), TamSX3('BB0_CODSIG')[1])

BB0->(DbSetOrder(1))	// BB0_FILIAL+BB0_ESTADO+BB0_NUMCR+BB0_CODSIG+BB0_CODOPE
if !BB0->(DbSeek( xFilial("BB0") + cEst + cNum + cSigla + PlsIntPad() ))

	BB0->( RecLock("BB0",.T.) )
		BB0->BB0_FILIAL	:= xFilial("BB0")
		BB0->BB0_VINC	:= "2"					// 1=Faz parte da rede de atendimento;2=Nao faz parte da rede de atendimento
		BB0->BB0_CODIGO	:= U_RetProxCod()		// GETSX8NUM("BB0","BB0_CODIGO")
		BB0->BB0_NOME	:= cNome
		BB0->BB0_CODSIG	:= cSigla
		BB0->BB0_NUMCR	:= cNum
		BB0->BB0_ESTADO	:= cEst
		BB0->BB0_UF		:= cEst
		BB0->BB0_CODOPE	:= PlsIntPad()
		BB0->BB0_XFLAGI	:= "S"					// Identifica que o registro veio a partir da importação
		BB0->BB0_XDATA	:= date()
		BB0->BB0_XORIGE	:= cOrigem				// 1=Manual;2=Importacao XML;3=Importacao;4=Reembolso
		BB0->BB0_XSTATU	:= cStatPrf
		BB0->BB0_XESPEC	:= cEspec
	BB0->( MsUnlock() )

endif

return


//----------------------------------------------------------------------------------------------//
//	Retorna o próximo codigo para ser utilizado na inclusão	na tabela BB0						//
//----------------------------------------------------------------------------------------------//
User Function RetProxCod()

Local cRet			:= ""
Local cQuery		:= ""
Local cAliasSeq		:= GetNextAlias()

cQuery := " select MAX(BB0_CODIGO) as PROXCOD"
cQuery += " from " + RetSqlName("BB0") + " BB0"
cQuery += " where BB0.D_E_L_E_T_ = ' '"
cQuery +=	" and BB0_FILIAL = '" + xFilial('BB0') + "'"

TcQuery cQuery New Alias (cAliasSeq)

cRet	:= soma1( (cAliasSeq)->PROXCOD )

(cAliasSeq)->(DbCloseArea())

return cRet







//----------------------------------------------------------------------------------------------//
//								ACERTO DE BASE - PROFISSIONAL DE SAÚDE							//
//----------------------------------------------------------------------------------------------//
User Function AcrPrfSd

if msgyesno("Executar bloqueio de profissionais com conselhos inválidos?")
	Processa({|| BlqPrfCI()}, "Processando...")
endif

if msgyesno("Executar saneamento de profissionais da CFM?")
	Processa({|| AcertPrf()}, "Processando...")
endif

return


Static Function BlqPrfCI()

Local aCRegBlq	:= {{""			, "919"},;
					{"CBORT"	, "917"},;
					{"CCM"		, "917"},;
					{"CMC"		, "917"},;
					{"COMBRAC"	, "917"},;
					{"CRAS"		, "917"},;
					{"CRB"		, "917"},;
					{"CRBM"		, "917"},;
					{"CREF"		, "917"},;
					{"CRF"		, "917"},;
					{"CRFA"		, "917"},;
					{"CRFa"		, "917"},;
					{"CRQ"		, "917"},;
					{"DETRAN"	, "919"},;
					{"DIC"		, "919"},;
					{"IFP"		, "919"},;
					{"ISS"		, "919"},;
					{"MB"		, "919"},;
					{"MG"		, "919"},;
					{"MM"		, "919"},;
					{"OUT"		, "919"},;
					{"OUTROS"	, "919"},;
					{"PF-INSM"	, "919"},;
					{"PJ - IM"	, "917"},;
					{"PJ-INSE"	, "917"},;
					{"PJ-INSM"	, "917"},;
					{"PJINSM"	, "917"},;
					{"RG"		, "917"},;
					{"0000002"	, "919"},;
					{"0000003"	, "919"},;
					{"0000004"	, "919"},;
					{"0000005"	, "919"},;
					{"0000006"	, "919"},;
					{"0000007"	, "919"},;
					{"0000009"	, "919"},;
					{"0000010"	, "919"},;
					{"1"		, "919"},;
					{"10"		, "919"},;
					{"9110"		, "919"}}
Local dDatBlq	:= StoD("20221231")
Local nPosBlq	:= 0
Local nHdl		:= FCREATE( "C:\Fred_Temp\Bloq_Conselhos_" + DtoS(date()) + "-" + StrTran(time(), ":", "") + ".csv")
Local cExtracao	:= ""
Local lVinc		:= .F.
Local lCopart	:= .F.
Local lCorpoCl	:= .F.

if nHdl <> -1

	cExtracao := "Cod. Prof.;Conselho;Estado;Registro;Nome;Log;RDA;Copart.;Corpo Clinico" + CHR(13)+CHR(10)
	FWRITE ( nHdl , cExtracao )

	BB0->(DbSetOrder(1))
	BB0->(DbGoTop())
	while BB0->(!EOF())

		if empty(BB0->BB0_CODSIG)
			nPosBlq	:= 1
		else
			nPosBlq	:= aScan(aCRegBlq,{|x| x[1] == AllTrim(BB0->BB0_CODSIG)})
		endif

		if nPosBlq <> 0

			lVinc	:= (BB0->BB0_VINC == "1")		// Faz parte da Rede de Atendimento

			if !lVinc

				BAU->(DbSetOrder(5))	// BAU_FILIAL+BAU_CODBB0
				if BAU->(DbSeek( xFilial("BAU") + BB0->BB0_CODIGO ) )
					lVinc	:= .T.
				endif

			endif

			ZZF->(DbSetOrder(1))	// ZZF_FILIAL+ZZF_CODIGO+DTOS(ZZF_DATA)+ZZF_TIPO
			if ZZF->(DbSeek( xFilial("ZZF") + BB0->BB0_CODIGO ) )
				lCopart		:= .T.					// Tem regra de isenção de copart.
			else
				lCopart		:= .F.
			endif

			BC1->(DbSetOrder(4))	// BC1_FILIAL+BC1_CODPRF
			if BC1->(DbSeek( xFilial("BC1") + BB0->BB0_CODIGO ) )
				lCorpoCl	:= .T.					// Tem vinculo em corpo clínico
			else
				lCorpoCl	:= .F.
			endif

			if !lVinc .and. !lCopart .and. !lCorpoCl

				Begin Transaction
					
					BB0->( RecLock("BB0",.F.) )
						BB0->BB0_CODBLO		:= aCRegBlq[nPosBlq][2]
						BB0->BB0_DATBLO		:= dDatBlq
					BB0->( MsUnlock() )

					B17->( RecLock("B17",.T.) )
						B17->B17_FILIAL		:= xFilial("B17")
						B17->B17_CODPFS		:= BB0->BB0_CODIGO
						B17->B17_DATA		:= dDatBlq
						B17->B17_HORA		:= "23:59"
						B17->B17_MOTBLO		:= aCRegBlq[nPosBlq][2]
						B17->B17_OBS		:= "Bloqueio automatico de conselhos invalidos"
						B17->B17_TIPO		:= "0"
						B17->B17_USUOPE		:= cUserName
					B17->( MsUnlock() )
				
				End Transaction

				cExtracao := BB0->BB0_CODIGO + ";" + AllTrim(BB0->BB0_CODSIG) + ";" + BB0->BB0_ESTADO + ";" + AllTrim(BB0->BB0_NUMCR) + ";" + AllTrim(BB0->BB0_NOME) +;
								";Bloqueado;;;" + CHR(13)+CHR(10)
				FWRITE ( nHdl , cExtracao )

			else

				cExtracao := BB0->BB0_CODIGO + ";" + AllTrim(BB0->BB0_CODSIG) + ";" + BB0->BB0_ESTADO + ";" + AllTrim(BB0->BB0_NUMCR) + ";" + AllTrim(BB0->BB0_NOME) +;
								";Nao Bloqueado;" + iif(lVinc,"Sim","Nao") + ";" + iif(lCopart,"Sim","Nao") + ";" + iif(lCorpoCl,"Sim","Nao") + CHR(13)+CHR(10)
				FWRITE ( nHdl , cExtracao )
			
			endif

		endif

		BB0->(DbSkip())
	end

endif

return











Static Function AcertPrf()

Local cCodOpe		:= PlsIntPad()
Local cEstCRM		:= ""
Local cCodCRM		:= PadR( "CRM", TamSX3('BB0_CODSIG')[1])
Local cNumCRM		:= ""

Local nHdl			:= FCreate("C:\Fred_Temp\Log_Ajuste_Prof_CRM_" + DtoS(date()) + "-" + StrTran(time(), ":", "") + ".csv")
Local cQuery		:= ""
Local cAliasQry		:= GetNextAlias()
Local nCont			:= 0
Local nTotal		:= 0
Local cExtracao 	:= ""


Local cNomPrf		:= ""
Local cCodBB0		:= ""
Local nRecBB0		:= 0
Local nRecNew		:= 0
Local cCodBlo		:= "919"	// OUTROS
Local lVinc			:= .F.
Local lCopart		:= .F.
Local lCorpoCl		:= .F.
Local i				:= 0
Local cAux			:= ""
Local nRecAux		:= 0
Local aAuxBB0		:= {}
Local aAux			:= {}

Local cAuxLog		:= ""
Local cNumOri		:= ""


if nHdl <> -1

	cQuery := " select count(BB0_CODIGO) as QTDE"
	cQuery += " from " + RetSqlName("BB0") + " BB0"
	cQuery += " where BB0.D_E_L_E_T_ = ' '"
	cQuery +=	" and BB0_FILIAL = '" + xFilial('BB0') + "'"
	
	TcQuery cQuery New Alias (cAliasQry)

	nTotal	:= (cAliasQry)->QTDE

	(cAliasQry)->(DbCloseArea())

	ProcRegua(nTotal)

	cExtracao := "Codigo;Identificacao;Log;Analisar;Nome (sistema);Nome (CFM);RDA;Copart.;Corpo Clinico;Especialidade" + CHR(13)+CHR(10)
	FWRITE ( nHdl , cExtracao )

	BB0->(DbSetOrder(1))
	BB0->(DBGoTop())

	while BB0->(!EOF())

		nCont++
		IncProc("Profissional: " + AllTrim(Str(nCont)) + " / " + AllTrim(Str(nTotal)) )

		// Cenário para teste do fonte
		//BB0->(DbSeek(xFilial("BB0") + "002810" ))

		if (empty(BB0->BB0_XDATA) .or. empty(BB0->BB0_XORIGE))	// ainda não processado

			if !empty(BB0->BB0_CODBLO)		// se profissional já bloqueado - só marcar data e origem

				BB0->( RecLock("BB0",.F.) )
					BB0->BB0_XDATA	:= date()
					BB0->BB0_XORIGE	:= "1"				// Manual
				BB0->( MsUnlock() )
			
			else

				cExtracao	:= ""
				cAuxLog		:= ""

				if AllTrim(BB0->BB0_CODSIG) == "CRM"

					nRecBB0	:= BB0->(RECNO())
					cCodBB0	:= BB0->BB0_CODIGO
					cEstCRM	:= BB0->BB0_ESTADO
					cNumCRM	:= PadR( AllTrim(BB0->BB0_NUMCR) , TamSX3('PA7_CRM')[1])
					cNumOri	:= AllTrim(BB0->BB0_NUMCR)
					cNomPrf	:= AllTrim(BB0->BB0_NOME)
					nRecNew	:= 0
					
					// Verificar se existe na PA7
					PA7->(DbSetOrder(1))	// PA7_FILIAL+PA7_CRM+PA7_EST
					if PA7->(DbSeek( xFilial("PA7") + cNumCRM + cEstCRM ))

						BB0->( RecLock("BB0",.F.) )
							BB0->BB0_XDATA	:= date()
							BB0->BB0_XORIGE	:= "3"				// Importação
						BB0->( MsUnlock() )

						cExtracao := cCodBB0 + ";" + cEstCRM + "-" + cNumOri + ";Profissional já na padronização;Nao;-;-;Nao;Nao;Nao;Nao" + CHR(13)+CHR(10)
						FWRITE ( nHdl , cExtracao )

					else

						//--------------------------------------------------------------------------//
						//							Verificar vinculos								//
						//--------------------------------------------------------------------------//
						lVinc	:= (BB0->BB0_VINC == "1")		// Faz parte da Rede de Atendimento

						ZZF->(DbSetOrder(1))	// ZZF_FILIAL+ZZF_CODIGO+DTOS(ZZF_DATA)+ZZF_TIPO
						if ZZF->(DbSeek( xFilial("ZZF") + BB0->BB0_CODIGO ) )
							lCopart		:= .T.					// Tem regra de isenção de copart.
						else
							lCopart		:= .F.
						endif

						BC1->(DbSetOrder(4))	// BC1_FILIAL+BC1_CODPRF
						if BC1->(DbSeek( xFilial("BC1") + BB0->BB0_CODIGO ) )
							lCorpoCl	:= .T.					// Tem vinculo em corpo clínico
						else
							lCorpoCl	:= .F.
						endif

						// Tratamento para retirar todos os caracteres não numericos enviados
						cAux	:= ""
						for i := 1 to len(cNumCRM)
							if IsDigit( SubStr(cNumCRM, i, 1) )
								cAux += SubStr(cNumCRM, i, 1)
							endif
						next
						cNumCRM	:= AllTrim(str(val(cAux)))

						if val(cNumCRM) > 0

							cNumCRM	:= PadR( cNumCRM, TamSX3('PA7_CRM')[1])

							PA7->(DbSetOrder(1))	// PA7_FILIAL+PA7_CRM+PA7_EST
							if PA7->(DbSeek( xFilial("PA7") + cNumCRM + cEstCRM ))

								cNumCRM	:= PadR( AllTrim(cNumCRM), TamSX3('BB0_NUMCR')[1])

								BB0->(DbSetOrder(4))	// BB0_FILIAL+BB0_ESTADO+BB0_NUMCR+BB0_CODSIG+BB0_CODOPE
								if BB0->(DbSeek( xFilial("BB0") + cEstCRM + cNumCRM + cCodCRM + cCodOpe ))

									nRecNew	:= BB0->(RECNO())
								
								endif
							
							endif

							if nRecNew == 0

								cNumCRM := AllTrim(cNumCRM)
								if SubStr(cNumCRM,1,2) == '52'

									cNumCRM	:= SubStr(cNumCRM, 3, len(cNumCRM)-2 )
									cNumCRM	:= AllTrim(str(val(cNumCRM)))

									if val(cNumCRM) > 0

										cNumCRM	:= PadR( cNumCRM, TamSX3('PA7_CRM')[1])

										PA7->(DbSetOrder(1))	// PA7_FILIAL+PA7_CRM+PA7_EST
										if PA7->(DbSeek( xFilial("PA7") + cNumCRM + cEstCRM ))

											if AllTrim(PA7->PA7_NOME) == cNomPrf

												cNumCRM	:= PadR( AllTrim(cNumCRM), TamSX3('BB0_NUMCR')[1])

												BB0->(DbSetOrder(4))	// BB0_FILIAL+BB0_ESTADO+BB0_NUMCR+BB0_CODSIG+BB0_CODOPE
												if BB0->(DbSeek( xFilial("BB0") + cEstCRM + cNumCRM + cCodCRM + cCodOpe ))

													nRecNew	:= BB0->(RECNO())
												
												endif
											
											else
											
												cAuxLog	:= ";" + cNomPrf + ";" + AllTrim(PA7->PA7_NOME)
											
											endif
										
										endif

									endif
								
								endif

							endif

							BB0->(DbSetOrder(1))
							BB0->(DBGoTo(nRecBB0))	// Retornar ao profissional em anállise

							if nRecNew > 0

								cExtracao := cCodBB0 + ";" + cEstCRM + "-" + cNumOri + ";Profissional fora da padronizacao atualizado;Nao;-;-;"

								aAuxBB0	:= {BB0->BB0_CGC			,;
											BB0->BB0_TIPLOG			,;
											BB0->BB0_ENDERE			,;
											BB0->BB0_BAIRRO			,;
											BB0->BB0_CIDADE			,;
											BB0->BB0_UF				,;
											BB0->BB0_CEP			,;
											BB0->BB0_CODMUN			,;
											BB0->BB0_COMPLE			,;
											BB0->BB0_NUMERO			,;
											BB0->BB0_YCDRDA			,;
											BB0->BB0_DATNAS			,;
											BB0->BB0_SEXO			,;
											BB0->BB0_ESTCIV			,;
											BB0->BB0_MATVID			,;
											BB0->BB0_YTIPPE			,;
											BB0->BB0_DATVIN			,;
											BB0->BB0_EMAIL			,;
											BB0->BB0_NRCRNA			,;
											BB0->BB0_TEL			}

								Begin Transaction

									// Bloquear registro com código incorreto
									BB0->( RecLock("BB0",.F.) )
										BB0->BB0_VINC		:= "2"			// 2=Nao faz parte da Rede de Atendimento (vínculo irá pro novo prof.)
										BB0->BB0_XDATA		:= date()
										BB0->BB0_XORIGE		:= "3"			// Importação
										BB0->BB0_CODBLO		:= cCodBlo
										BB0->BB0_DATBLO		:= date()
									BB0->( MsUnlock() )

									B17->( RecLock("B17",.T.) )
										B17->B17_FILIAL	:= xFilial("B17")
										B17->B17_CODPFS	:= BB0->BB0_CODIGO
										B17->B17_DATA	:= date()
										B17->B17_HORA	:= StrTran(time(),":","")
										B17->B17_MOTBLO	:= cCodBlo
										B17->B17_OBS	:= "NUMERO DUPLICADO"
										B17->B17_TIPO	:= "0"
										B17->B17_USUOPE	:= cUserName
									B17->( MsUnlock() )

									BB0->(DBGoTo(nRecNew))	// Posicionar no profissional correto

									BB0->( RecLock("BB0",.F.) )
										BB0->BB0_VINC	:= iif(lVinc,					"1",			 BB0->BB0_VINC	)
										BB0->BB0_CGC	:= iif(!empty(BB0->BB0_CGC), 	BB0->BB0_CGC,	 aAuxBB0[01]	)
										BB0->BB0_TIPLOG	:= iif(!empty(BB0->BB0_TIPLOG), BB0->BB0_TIPLOG, aAuxBB0[02]	)
										BB0->BB0_ENDERE	:= iif(!empty(BB0->BB0_ENDERE), BB0->BB0_ENDERE, aAuxBB0[03]	)
										BB0->BB0_BAIRRO	:= iif(!empty(BB0->BB0_BAIRRO), BB0->BB0_BAIRRO, aAuxBB0[04]	)
										BB0->BB0_CIDADE	:= iif(!empty(BB0->BB0_CIDADE), BB0->BB0_CIDADE, aAuxBB0[05]	)
										BB0->BB0_UF		:= iif(!empty(BB0->BB0_UF),		BB0->BB0_UF,	 aAuxBB0[06]	)
										BB0->BB0_CEP	:= iif(!empty(BB0->BB0_CEP),	BB0->BB0_CEP,	 aAuxBB0[07]	)
										BB0->BB0_CODMUN	:= iif(!empty(BB0->BB0_CODMUN), BB0->BB0_CODMUN, aAuxBB0[08]	)
										BB0->BB0_COMPLE	:= iif(!empty(BB0->BB0_COMPLE), BB0->BB0_COMPLE, aAuxBB0[09]	)
										BB0->BB0_NUMERO	:= iif(!empty(BB0->BB0_NUMERO), BB0->BB0_NUMERO, aAuxBB0[10]	)
										BB0->BB0_YCDRDA	:= iif(!empty(BB0->BB0_YCDRDA), BB0->BB0_YCDRDA, aAuxBB0[11]	)
										BB0->BB0_DATNAS	:= iif(!empty(BB0->BB0_DATNAS), BB0->BB0_DATNAS, aAuxBB0[12]	)
										BB0->BB0_SEXO	:= iif(!empty(BB0->BB0_SEXO),	BB0->BB0_SEXO,	 aAuxBB0[13]	)
										BB0->BB0_ESTCIV	:= iif(!empty(BB0->BB0_ESTCIV), BB0->BB0_ESTCIV, aAuxBB0[14]	)
										BB0->BB0_MATVID	:= iif(!empty(BB0->BB0_MATVID), BB0->BB0_MATVID, aAuxBB0[15]	)
										BB0->BB0_YTIPPE	:= iif(!empty(BB0->BB0_YTIPPE), BB0->BB0_YTIPPE, aAuxBB0[16]	)
										BB0->BB0_DATVIN	:= iif(!empty(BB0->BB0_DATVIN), BB0->BB0_DATVIN, aAuxBB0[17]	)
										BB0->BB0_EMAIL	:= iif(!empty(BB0->BB0_EMAIL),	BB0->BB0_EMAIL,	 aAuxBB0[18]	)
										BB0->BB0_NRCRNA	:= iif(!empty(BB0->BB0_NRCRNA), BB0->BB0_NRCRNA, aAuxBB0[19]	)
										BB0->BB0_TEL	:= iif(!empty(BB0->BB0_TEL),	BB0->BB0_TEL,	 aAuxBB0[20]	)
									BB0->( MsUnlock() )

									if lVinc

										cExtracao += "Sim;"

										BAU->(DbSetOrder(5))	// BAU_FILIAL+BAU_CODBB0
										if BAU->(DbSeek( xFilial("BAU") + cCodBB0 ) )

											BAU->( RecLock("BAU",.F.) )
												BAU->BAU_CODBB0	:= BB0->BB0_CODIGO
												BAU->BAU_SIGLCR	:= BB0->BB0_CODSIG
												BAU->BAU_ESTCR	:= BB0->BB0_ESTADO
												BAU->BAU_CONREG	:= AllTrim(BB0->BB0_NUMCR)
											BAU->( MsUnlock() )
											
										endif

									else
										cExtracao += "Nao;"
									endif

									if lCopart

										cExtracao += "Sim;"

										ZZF->(DbSetOrder(1))	// ZZF_FILIAL+ZZF_CODIGO+DTOS(ZZF_DATA)+ZZF_TIPO
										if ZZF->(DbSeek( xFilial("ZZF") + cCodBB0 ) )

											while ZZF->(!EOF()) .and. ZZF->ZZF_CODIGO == cCodBB0

												nRecAux	:= ZZF->(RECNO())

												aAux	:= {ZZF->ZZF_DATA	,;
															ZZF->ZZF_TIPO	,;
															ZZF->ZZF_RDARES	,;
															ZZF->ZZF_TPPROF	,;
															ZZF->ZZF_DATBLO	,;
															ZZF->ZZF_NUPRE	}

												ZZF->( RecLock("ZZF",.T.) )
													ZZF->ZZF_FILIAL		:= xFilial("ZZF")
													ZZF->ZZF_CODIGO		:= BB0->BB0_CODIGO
													ZZF->ZZF_DATA		:= aAux[1]
													ZZF->ZZF_TIPO		:= aAux[2]
													ZZF->ZZF_RDARES		:= aAux[3]
													ZZF->ZZF_TPPROF		:= aAux[4]
													ZZF->ZZF_DATBLO		:= aAux[5]
													ZZF->ZZF_NUPRE		:= aAux[6]
												ZZF->( MsUnlock() )

												ZZF->(DBGoTo(nRecAux))

												ZZF->(DbSkip())
											end
											
										endif
										
									else
										cExtracao += "Nao;"
									endif

									if lCorpoCl

										cExtracao += "Sim;"

										aAux	:= {}

										BC1->(DbSetOrder(4))	// BC1_FILIAL+BC1_CODPRF
										if BC1->(DbSeek( xFilial("BC1") + cCodBB0 ) )

											while BC1->(!EOF()) .and. BC1->BC1_CODPRF == cCodBB0

												aAdd(aAux, BC1->(RECNO()))
											
												BC1->(DbSkip())
											end

											for i := 1 to len(aAux)

												BC1->(DBGoTo(aAux[i]))

												BC1->( RecLock("BC1",.F.) )
													BC1->BC1_CODPRF		:= BB0->BB0_CODIGO
													BC1->BC1_SIGLCR		:= BB0->BB0_CODSIG
													BC1->BC1_NUMCR		:= BB0->BB0_NUMCR
													BC1->BC1_ESTCR		:= BB0->BB0_ESTADO
													BC1->BC1_OBSERV		:= "Profissional alterado - Anterior: " + cCodBB0
												BC1->( MsUnlock() )

											next

										endif
										
									else
										cExtracao += "Nao;"
									endif

									BQ1->(DbSetOrder(1))	// BQ1_FILIAL+BQ1_CODIGO+BQ1_CODESP
									if BQ1->(DbSeek( xFilial("BQ1") + cCodBB0 ) )

										cExtracao += "Sim"

										while BQ1->(!EOF()) .and. BQ1->BQ1_CODIGO == cCodBB0

											nRecAux	:= BQ1->(RECNO())

											aAux	:= {BQ1->BQ1_TIPDOC		,;
														BQ1->BQ1_CONTRA		,;
														BQ1->BQ1_DTEMSS		,;
														BQ1->BQ1_CODESP		,;
														BQ1->BQ1_BENPRC		,;
														BQ1->BQ1_DESCRI		,;
														BQ1->BQ1_DEPEND		,;
														BQ1->BQ1_CPFCNP		,;
														BQ1->BQ1_NATURE		,;
														BQ1->BQ1_INICIO		,;
														BQ1->BQ1_TERMCT		,;
														BQ1->BQ1_CANCEL		,;
														BQ1->BQ1_VENCTO		,;
														BQ1->BQ1_QTDPAR		,;
														BQ1->BQ1_VLRPAR		,;
														BQ1->BQ1_JUROS		,;
														BQ1->BQ1_CUSTO		,;
														BQ1->BQ1_TOTPAR		,;
														BQ1->BQ1_VLROUT		,;
														BQ1->BQ1_TOTFAT		}
											
											BQ1->(DbSetOrder(1))	// BQ1_FILIAL+BQ1_CODIGO+BQ1_CODESP
											if !BQ1->(DbSeek( xFilial("BQ1") + BB0->BB0_CODIGO + aAux[04] ) )	// Se não existe

												BQ1->( RecLock("BQ1",.T.) )
													BQ1->BQ1_FILIAL		:= xFilial("BQ1")
													BQ1->BQ1_CODINT		:= BB0->BB0_CODOPE
													BQ1->BQ1_CODIGO		:= BB0->BB0_CODIGO
													BQ1->BQ1_TIPDOC		:= aAux[01]
													BQ1->BQ1_CONTRA		:= aAux[02]
													BQ1->BQ1_DTEMSS		:= aAux[03]
													BQ1->BQ1_CODESP		:= aAux[04]
													BQ1->BQ1_BENPRC		:= aAux[05]
													BQ1->BQ1_DESCRI		:= aAux[06]
													BQ1->BQ1_DEPEND		:= aAux[07]
													BQ1->BQ1_CPFCNP		:= aAux[08]
													BQ1->BQ1_NATURE		:= aAux[09]
													BQ1->BQ1_INICIO		:= aAux[10]
													BQ1->BQ1_TERMCT		:= aAux[11]
													BQ1->BQ1_CANCEL		:= aAux[12]
													BQ1->BQ1_VENCTO		:= aAux[13]
													BQ1->BQ1_QTDPAR		:= aAux[14]
													BQ1->BQ1_VLRPAR		:= aAux[15]
													BQ1->BQ1_JUROS		:= aAux[16]
													BQ1->BQ1_CUSTO		:= aAux[17]
													BQ1->BQ1_TOTPAR		:= aAux[18]
													BQ1->BQ1_VLROUT		:= aAux[19]
													BQ1->BQ1_TOTFAT		:= aAux[20]
												BQ1->( MsUnlock() )
											
											endif

											BQ1->(DBGoTo(nRecAux))
										
											BQ1->(DbSkip())
										end

									else
										cExtracao += "Nao"
									endif

								End Transaction

								cExtracao += CHR(13)+CHR(10)
								FWRITE ( nHdl , cExtracao )

								BB0->(DbSetOrder(1))
								BB0->(DBGoTo(nRecBB0))	// Retornar ao profissional em anállise
							
							else

								cExtracao := cCodBB0 + ";" + cEstCRM + "-" + cNumOri + ";Codigo nao localizado no CFM - "

								if !lVinc .and. !lCopart .and. !lCorpoCl

									cExtracao += "sem vinculos (bloqueado);Nao"

									Begin Transaction

										BB0->( RecLock("BB0",.F.) )
											BB0->BB0_XDATA		:= date()
											BB0->BB0_XORIGE		:= "3"			// Importação
											BB0->BB0_CODBLO		:= cCodBlo
											BB0->BB0_DATBLO		:= date()
										BB0->( MsUnlock() )

										B17->( RecLock("B17",.T.) )
											B17->B17_FILIAL	:= xFilial("B17")
											B17->B17_CODPFS	:= BB0->BB0_CODIGO
											B17->B17_DATA	:= date()
											B17->B17_HORA	:= StrTran(time(),":","")
											B17->B17_MOTBLO	:= cCodBlo
											B17->B17_OBS	:= "NUMERO INVALIDO"
											B17->B17_TIPO	:= "0"
											B17->B17_USUOPE	:= cUserName
										B17->( MsUnlock() )
									
									End Transaction

								else 
								
									cExtracao += "com vinculos (analisar);Sim"
								
								endif

								cExtracao += iif(!empty(cAuxLog), cAuxLog, ";-;-")  + ";Nao;Nao;Nao;Nao" + CHR(13)+CHR(10)
								FWRITE ( nHdl , cExtracao )

							endif

						else

							cExtracao := cCodBB0 + ";" + cEstCRM + "-" + cNumOri + ";Numero invalido - "
							
							if !lVinc .and. !lCopart .and. !lCorpoCl

								cExtracao += "sem vinculos (bloqueado);Nao;-;-;Nao;Nao;Nao;Nao" + CHR(13)+CHR(10)

								Begin Transaction

									BB0->( RecLock("BB0",.F.) )
										BB0->BB0_XDATA		:= date()
										BB0->BB0_XORIGE		:= "3"			// Importação
										BB0->BB0_CODBLO		:= cCodBlo
										BB0->BB0_DATBLO		:= date()
									BB0->( MsUnlock() )

									B17->( RecLock("B17",.T.) )
										B17->B17_FILIAL	:= xFilial("B17")
										B17->B17_CODPFS	:= BB0->BB0_CODIGO
										B17->B17_DATA	:= date()
										B17->B17_HORA	:= StrTran(time(),":","")
										B17->B17_MOTBLO	:= cCodBlo
										B17->B17_OBS	:= "NUMERO INVALIDO"
										B17->B17_TIPO	:= "0"
										B17->B17_USUOPE	:= cUserName
									B17->( MsUnlock() )
								
								End Transaction

							else

								cExtracao += "com vinculos (analisar);Sim;-;-;Nao;Nao;Nao;Nao" + CHR(13)+CHR(10)
							
							endif

							FWRITE ( nHdl , cExtracao )

						endif
					
					endif

				else		// se não for CRM (com tabela de apoio para conferência)

					// avaliar tratamento para profissionais fora da CFM
				
				endif

			endif

		endif

		// Cenário de teste (não ficar no loop)
		//exit

		BB0->(DBSkip())
	end

	// Tratar códigos duplicados (acerto manual da área - não será feito rotina sistemica)
	// query de apoio salva abaixo para formalizar
	/*
		select BB0_CODSIG, BB0_NUMCR, BB0_ESTADO, count(*)
		from BB0010 BB0
		where BB0.D_E_L_E_T_ =  ' '
			and BB0_FIlIAL = '  '
			and BB0_CODSIG = 'CRM'
			and BB0_CODOPE = '0001'
			and BB0_CODBLO = ' '
		group by BB0_CODSIG, BB0_NUMCR, BB0_ESTADO
		having (count(*) > 1);
	*/

else
	alert("Erro na criação do log. Entre em contato com o administrador do sistema.")
endif
FCLOSE ( nHdl  )

return 







