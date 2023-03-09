#Include "PLSMGER.CH"
#Include "PROTHEUS.CH"
#Include "COLORS.CH"
#INCLUDE "rwmake.ch"
#INCLUDE "topconn.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ CABI024  บ Autor ณ Frederico O. C. Jr บ Data ณ  20/10/21   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ   Atualiza็ใo de Rol de Proced. X Tab. Padrใo X DUT        บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function CABI024()

Local oDlg
Local oArquiv
Local cArquiv	:= space(100)
Local nOpcao	:= 0

DEFINE MSDIALOG oDlg TITLE OemToAnsi("Atualiza็ใo: Rol de Proced. X Tab. Padrใo X DUT") FROM 000,000 TO 325,410 PIXEL

	@006,008 SAY "Rotina para atualiza็ใo do Rol Proced. X Tab. Padrใo X DUT!"							PIXEL
	
	@018,070 SAY "* Cria็ใo da tabela de Rol de procedimentos (substituindo atual)"						PIXEL
	@030,018 SAY "* Vํnculo na tabela do rol das DUT's."												PIXEL
	@038,018 SAY "* Refazer o vํnculo do Rol na Tabela Padrใo."											PIXEL
	
	@061,008 SAY "Arquivo:"															 			PIXEL
	@060,035 MsGet oArquiv		VAR cArquiv		SIZE 140,008		When .F.								PIXEL OF oDlg
	@060,178 BUTTON "..." SIZE 015,010 PIXEL ACTION (cArquiv := cGetFile("Arquivo Texto (*.txt) | *.txt", OemToAnsi("Selecione Arquivo"),,"",.F.,GETF_LOCALHARD+GETF_NETWORKDRIVE,.F.))
	
	@085,045 BUTTON "CONFIRMAR"	SIZE 050,010 PIXEL ACTION (nOpcao := 1, Close(oDlg))
	@085,107 BUTTON "CANCELAR"	SIZE 050,010 PIXEL ACTION Close(oDlg)

ACTIVATE DIALOG oDlg CENTERED

if nOpcao == 1

	Processa({|| CABI24A( cArquiv )}, "Aguarde...")

endif

return


Static Function CABI24A( cArquivo )

Local nHdl		:= FT_FUse( cArquivo )
Local nHdl2		:= 0
Local nTotSeq	:= 0
Local nContSq	:= 0
Local nContSc	:= 0
Local cBuffer	:= ""
Local aAux		:= {}
Local nCont		:= 1
Local cExtracao	:= ""
Local cSeqRol	:= ""

while at("\", cArquivo, nCont) <> 0
	nCont := at("\", cArquivo, nCont) + 1
end

nHdl2	:= FCREATE( SubStr(cArquivo, 1, nCont-1) + "log_rol_proced_" + DtoS(date()) + "-" + StrTran(time(), ":", "") + ".csv")

if nHdl <> -1

	if nHdl2 <> -1
	
		cExtracao := "Linha;Chave;Log" + CHR(13)+CHR(10)
		FWRITE ( nHdl2 , cExtracao )
		
		nTotSeq	:= FT_FLastRec()	// Retorna o n๚mero de linhas do arquivo
		
		ProcRegua(nTotSeq)
		
		FT_FGoTop()
		while !FT_FEOF()
		
			nContSq++
			IncProc("Processando..." + CHR(13)+CHR(10) + "Registro: " + AllTrim(Str(nContSq)) + " / " + AllTrim(Str(nTotSeq)) )
			
			cBuffer	:= FT_FReadLn() // Retorna a linha corrente
			aAux	:= StrTokArr2 (cBuffer, ';', .T.)
			
			if len(aAux) == 13
			
				/*
				01 - Cod. Pad	(16)
				02 - Cod. Proced.
				03 - Descri็ใo
				04 - SubGrupo
				05 - Grupo
				06 - Capitulo
				07 - Correla็ใo
				08 - Odontol๓gico
				09 - Ambulat๓rio
				10 - HCO
				11 - HSO
				12 - PAC
				13 - DUT
				*/

				if len( AllTrim(aAux[1]) ) == 2 .and. len( AllTrim(aAux[2]) ) == 8

					Begin Transaction

						cSeqRol	:= GetSxeNum("BRW","BRW_SEQROL")

						BRW->( RecLock("BRW",.T.) )

							BRW->BRW_FILIAL	:= xFilial("BRW")
							BRW->BRW_SEQROL	:= cSeqRol
							BRW->BRW_CODROL	:= AllTrim(aAux[2])
							BRW->BRW_DESROL	:= AllTrim(aAux[3])
							BRW->BRW_COMPLE	:= ""
							BRW->BRW_CODTTB	:= AllTrim(aAux[1])
							BRW->BRW_CODGRU	:= ""
							BRW->BRW_AMB	:= iif( AllTrim(aAux[ 9]) == "AMB", "1", "0")
							BRW->BRW_HCO	:= iif( AllTrim(aAux[10]) == "HCO", "1", "0")
							BRW->BRW_HSO	:= iif( AllTrim(aAux[11]) == "HSO", "1", "0")
							BRW->BRW_PAC	:= iif( AllTrim(aAux[12]) == "PAC", "1", "0")
							BRW->BRW_OD		:= iif( AllTrim(aAux[ 8]) == "OD" , "1", "0")
							BRW->BRW_SUBGRU	:= AllTrim(aAux[4])
							BRW->BRW_GRUPO	:= AllTrim(aAux[5])
							BRW->BRW_CAPITU	:= AllTrim(aAux[6])

							cExtracao := AllTrim(str(nContSq)) + ";" + AllTrim(aAux[2]) + ";Importacao realizada"

							BKK->(DbSetOrder(2))	// BKK_FILIAL+BKK_CODDUT+BKK_CODSUB+BKK_CODTAB
							if BKK->(DbSeek( xFilial("BKK") + StrZero( val(AllTrim(aAux[13])), 3 ) ))

								BRW->BRW_DUT	:= "1"
								BRW->BRW_TABDUT	:= BKK->BKK_CODTAB
								BRW->BRW_CODDUT	:= BKK->BKK_CODDUT
								//BRW->BRW_DUTSUB	:= ""

							else
								
								BRW->BRW_DUT	:= "0"
								if !empty(aAux[13])
									cExtracao	+= " - DUT nao localizada no sistema"
								endif

							endif
						
						BRW->( MsUnlock() )

						ConfirmSx8()

						if AllTrim(aAux[7]) == "SIM"

							BR8->(DbSetOrder(1))	// BR8_FILIAL+BR8_CODPAD+BR8_CODPSA+BR8_ANASIN
							if BR8->(DbSeek( xFilial("BR8") + BRW->(BRW_CODTTB+BRW_CODROL)))

								BR8->( RecLock("BR8",.F.) )
									BR8->BR8_CODROL	:= BRW->BRW_CODROL
									BR8->BR8_DESROL	:= BRW->BRW_DESROL
								BR8->( MsUnlock() )

								cExtracao	+= " - Vinculado na Tab. Padrao"
								
							else
								cExtracao	+= " - Proced. nao localizado na Tab. Padrao"
							endif

						endif

						cExtracao	+= CHR(13)+CHR(10)
						FWRITE ( nHdl2 , cExtracao )

					End Transaction

				else
					cExtracao := AllTrim(str(nContSq)) + ";" + AllTrim(aAux[2]) + ";Mascara do tipo de tabela e/ou procedimento incorretos" + CHR(13)+CHR(10)
					FWRITE ( nHdl2 , cExtracao )
				endif
				
			else
				cExtracao := AllTrim(str(nContSq)) + ";" + ";Quantidade incorreto de colunas" + CHR(13)+CHR(10)
				FWRITE ( nHdl2 , cExtracao )
			endif
			
			nContSc++
			
			FT_FSkip()	// Pula para pr๓xima linha
		end
		
		FT_FUse()
		
		MsgInfo("Procedimentos importados: " + AllTrim(str(nContSc)) + " / " + AllTrim(str(nContSq)) )
	
	else
		alert("Erro na cria็ใo do log. Entre em contato com o administrador do sistema.")
	endif

else
	alert("Erro na abertura do arquivo. Entre em contato com o administrador do sistema.")
endif

FCLOSE ( nHdl  )
FCLOSE ( nHdl2 )

return
