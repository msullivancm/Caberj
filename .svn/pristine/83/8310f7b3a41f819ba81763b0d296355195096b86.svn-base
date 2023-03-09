#Include "PROTHEUS.CH"
#INCLUDE "rwmake.ch"
#INCLUDE "topconn.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ CABI025  บ Autor ณ Frederico O. C. Jr บ Data ณ  24/10/21   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ   Atualiza็ใo das carencias							      บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function CABI025()

if MsgYesNo("Confirma a execu็ใo do ajuste das car๊ncias?")
	Processa({|| CABI25A() }, "Aguarde...")
endif

return


Static Function CABI25A()

Local cQuery		:= ""
Local cAliasQry		:= GetNextAlias()
Local nCont			:= 0
Local nTotReg		:= 0
Local nProcess		:= 0
Local nHdl			:= 0
Local nHdl2			:= 0
Local cBuffer		:= ""
Local aAux			:= {}
Local cExtracao		:= ""
Local cArquivo		:= ""
Local cAux			:= ""
Local nCtBG8		:= 0
Local nCtBR8		:= 0
Local aDePara		:= {}
Local aClaQtd		:= {}
Local aDePar2		:= {}
Local nAux			:= 0
Local nAux2			:= 0
Local i				:= 0

// Cria็ใo das novas classes de car๊ncia (as mesmas abaixo):
/*		041 - Atendimentos de urg๊ncia e emerg๊ncia						 24	HORAS
		042 - Consultas M้dicas											 30	DIAS
		043 - Interna็๕es eletivas										180	DIAS
		044 - Procedimentos cir๚rgicos de porte anest้sico 0 (zero)		180	DIAS
		045 - Terapias – Tratamento Cr๔nico								180	DIAS
		046 - Exames Complementares										180	DIAS
		047 - Exames Complementares PAC E DUT							180	DIAS
		048 - Terapias - Tratamento Convencional						180	DIAS
		049 - Parto a Termo												300	DIAS
*/

if MsgYesNo("Atualizar os procedimentos para as novas classes?")

	cArquivo	:= "C:\Users\frederico.junior\Desktop\Trat. Carencia\proced_x_classe.txt"
	nHdl		:= FT_FUse( cArquivo )
	nHdl2		:= 0
	nCont		:= 1

	while at("\", cArquivo, nCont) <> 0
		nCont := at("\", cArquivo, nCont) + 1
	end

	nHdl2	:= FCREATE( SubStr(cArquivo, 1, nCont-1) + "log_proced_x_classe_" + DtoS(date()) + "-" + StrTran(time(), ":", "") + ".csv")

	if nHdl <> -1

		if nHdl2 <> -1
		
			cExtracao := "Linha;Chave;Log Generico;Log BG8;Log BR8" + CHR(13)+CHR(10)
			FWRITE ( nHdl2 , cExtracao )
			
			nTotReg	:= FT_FLastRec()	// Retorna o n๚mero de linhas do arquivo
			
			ProcRegua(nTotReg)

			nCont		:= 0
			nProcess	:= 0
			
			FT_FGoTop()
			while !FT_FEOF()
			
				nCont++
				IncProc("Processando..." + CHR(13)+CHR(10) + "Registro: " + AllTrim(Str(nCont)) + " / " + AllTrim(Str(nTotReg)) )
				
				cBuffer	:= FT_FReadLn() // Retorna a linha corrente
				aAux	:= StrTokArr2 (cBuffer, ';', .T.)
				
				if len(aAux) == 3
				
					/*
					01 - Classe
					02 - Cod. Pad
					03 - Cod. Proced.
					*/

					if len( AllTrim(aAux[1]) ) == 3 .and. len( AllTrim(aAux[2]) ) == 2 .and. len( AllTrim(aAux[3]) ) == 8

						cAux		:= AllTrim(aAux[1]) + "-" + AllTrim(aAux[2]) + "-" + AllTrim(aAux[3])
						cExtracao	:= AllTrim(str(nCont)) + ";" + cAux + ";"
						nCtBG8		:= 0
						nCtBR8		:= 0

						BDL->(DbSetOrder(1))	// BDL_FILIAL+BDL_CODINT+BDL_CODIGO
						if BDL->(DbSeek( xFilial("BDL") + PlsIntPad() + AllTrim(aAux[1]) ))

							cExtracao += ";"

							BG8->(DbSetOrder(7))	// BG8_FILIAL+BG8_CODPSA+BG8_CODGRU+BG8_CODINT
							if BG8->(DbSeek( xFilial("BG8") + AllTrim(aAux[3]) ))

								while BG8->(!EOF()) .and. AllTrim(BG8->BG8_CODPSA) == AllTrim(aAux[3])

									if BG8->BG8_CODPAD == AllTrim(aAux[2])

										nCtBG8++

										BG8->( RecLock("BG8",.F.) )
											BG8->BG8_CLACAR	:=  AllTrim(aAux[1])
										BG8->( MsUnlock() )

									endif

									BG8->(DbSkip())
								end

							endif

							if nCtBG8 > 0
								cExtracao += "Atualizou " + AllTrim(str(nCtBG8)) + " registro(s);"
							else
								cExtracao += "Procedimento nao localizado;"
							endif
							
							BR8->(DbSetOrder(1))	// BR8_FILIAL+BR8_CODPAD+BR8_CODPSA+BR8_ANASIN
							if BR8->(DbSeek( xFilial("BR8") + AllTrim(aAux[2]) + AllTrim(aAux[3]) ))

								nCtBR8++

								BR8->( RecLock("BR8",.F.) )
									BR8->BR8_CLACAR	:=  AllTrim(aAux[1])
								BR8->( MsUnlock() )

								cExtracao += "Atualizou registro" + CHR(13)+CHR(10)

							else
								cExtracao += "Procedimento nao localizado" + CHR(13)+CHR(10)
							endif

							FWRITE ( nHdl2 , cExtracao )

							if nCtBR8 > 0 .or. nCtBG8 > 0
								nProcess++
							endif

						else
							cExtracao	+= "Classe de carencia invalida" + CHR(13)+CHR(10)
							FWRITE ( nHdl2 , cExtracao )
						endif

					else
						cExtracao := AllTrim(str(nCont)) + ";" + cAux + ";Mascara da classe e/ou proced. incorreta" + CHR(13)+CHR(10)
						FWRITE ( nHdl2 , cExtracao )
					endif
					
				else
					cExtracao := AllTrim(str(nCont)) + ";" + ";Quantidade incorreto de colunas" + CHR(13)+CHR(10)
					FWRITE ( nHdl2 , cExtracao )
				endif
				
				FT_FSkip()	// Pula para pr๓xima linha
			end
			FT_FUse()

			MsgInfo("AMARRAวรO DOS PROCEDIMENTOS ภ NOVA CLASSE"				+ CHR(13)+CHR(10) + CHR(13)+CHR(10) +;
					"Total Registros Arquivo: "		+ AllTrim(str(nTotReg)) + CHR(13)+CHR(10) +;
					"Total Registros Executados: "	+ AllTrim(str(nCont)) 	+ CHR(13)+CHR(10) +;
					"Total Registros Atualizados: "	+ AllTrim(str(nProcess)) )
		
		else
			alert("Erro na cria็ใo do log. Entre em contato com o administrador do sistema.")
		endif

	else
		alert("Erro na abertura do arquivo. Entre em contato com o administrador do sistema.")
	endif

	FCLOSE ( nHdl  )
	FCLOSE ( nHdl2 )

endif


// Classas Antigas e seu de-para nas Classes Novas
aDePara		:= {{"001", {"041"}},;
				{"002", {"042"}},;
				{"003", {"043","044","045","048"}},;
				{"004", {"043","044","048"}},;
				{"005", {"047"}},;
				{"007", {"042","044","047"}},;
				{"008", {"047"}},;
				{"012", {"044","046"}},;
				{"013", {"046"}},;
				{"014", {"046"}},;
				{"015", {"048"}},;
				{"016", {"041","042","043","044","045","046","047","048","049"}},;
				{"017", {"041","047","048"}},;
				{"019", {"041","048","049"}},;
				{"023", {"042"}},;
				{"024", {"041","042","043","044","045","046","047","048"}},;
				{"025", {"048"}},;
				{"026", {"043","044"}},;
				{"037", {"043","044","048"}},;
				{"038", {"043","044","046","048"}}}

aClaQtd		:= {{"041", {"1", 24, "1", 24, "1", 24}},;
				{"042", {"2", 30, "1", 24, "1", 24}},;
				{"043", {"2", 90, "2", 30, "2", 30}},;
				{"044", {"2",180, "2",120, "2", 30}},;
				{"045", {"2",180, "2",180, "2", 30}},;
				{"046", {"2",180, "2",180, "2",180}},;
				{"047", {"2",180, "2",180, "2", 90}},;
				{"048", {"2",180, "2",180, "2", 90}},;
				{"049", {"2",300, "2",300, "2",300}}}


if MsgYesNo("Atualizar classes de car๊ncia no produto?")

	cQuery := " select BAN_CODIGO, BAN_VERSAO, BAN_CLACAR"
	cQuery += " from " + RetSqlName("BAN") + " BAN"
	cQuery +=	" inner join " + RetSqlName("BDL") + " BDL"
	cQuery +=	  " on (    BDL_FILIAL = BAN_FILIAL"
	cQuery +=		  " and BDL_CODINT = substr(BAN_CODIGO,1,4)"
	cQuery +=		  " and BDL_CODIGO = BAN_CLACAR)"
	cQuery += " where BAN.D_E_L_E_T_ = ' ' and BDL.D_E_L_E_T_ = ' '"
	cQuery +=	" and BDL_CODEDI <> 'N'"

	// CENARIO DE TESTE
	//cQuery +=	" and BAN_CODIGO = '00010001'"

	cQuery += " order by BAN.BAN_CODIGO, BAN.BAN_CLACAR"

	TcQuery cQuery New Alias (cAliasQry)

	nTotReg		:= 0
	nCont		:= 0
	nProcess	:= 0

	dbeval({||nTotReg++ },,{||(cAliasQry)->(!EOF())})

	ProcRegua(nTotReg)

	// Todos os beneficiแrios com classes de car๊ncia em curso (desde que houve altera็ใo de prazos dentro dela) - e os proced. vinculados a ela
	(cAliasQry)->(DbGoTop())
	while (cAliasQry)->(!EOF())

		nCont++
		IncProc("Processando..." + CHR(13)+CHR(10) + "Registro: " + AllTrim(Str(nCont)) + " / " + AllTrim(Str(nTotReg)))

		nAux	:= aScan(aDePara, {|x| AllTrim(x[1]) == AllTrim((cAliasQry)->BAN_CLACAR ) })

		if nAux > 0

			for i := 1 to len( aDePara[nAux][2] )

				BAN->(DbSetOrder(1))	// BAN_FILIAL+BAN_CODIGO+BAN_VERSAO+BAN_CLACAR
				if !BAN->(DbSeek( xFilial("BAN") + (cAliasQry)->(BAN_CODIGO+BAN_VERSAO) + aDePara[nAux][2][i] ))

					BDL->(DbSetOrder(1))	// BDL_FILIAL+BDL_CODINT+BDL_CODIGO
					if BDL->(DbSeek( xFilial("BDL") + PlsIntPad() + aDePara[nAux][2][i] ))

						nProcess++

						BAN->( RecLock("BAN",.T.) )
							BAN->BAN_FILIAL	:= xFilial("BAN")
							BAN->BAN_CODIGO	:= (cAliasQry)->BAN_CODIGO
							BAN->BAN_VERSAO	:= (cAliasQry)->BAN_VERSAO
							BAN->BAN_CLACAR	:= aDePara[nAux][2][i]
							BAN->BAN_QTDCAR	:= BDL->BDL_CARENC
							BAN->BAN_UNCAR	:= BDL->BDL_UNCAR
						BAN->( MsUnlock() )

					endif

				endif

			next

		endif

		(cAliasQry)->(DbSkip())
	end
	(cAliasQry)->(DbCloseArea())

	MsgInfo("AJUSTE CLASSE DE CARสNCIA X PRODUTO"					+ CHR(13)+CHR(10) + CHR(13)+CHR(10) +;
			"Total Registros Query: "		+ AllTrim(str(nTotReg)) + CHR(13)+CHR(10) +;
			"Total Registros Executados: "	+ AllTrim(str(nCont)) 	+ CHR(13)+CHR(10) +;
			"Total Registros Criados: "		+ AllTrim(str(nProcess)) )

endif


if MsgYesNo("Atualizar classe de car๊ncia no subcontrato")

	cQuery := " select BA6_CODINT, BA6_CODIGO, BA6_NUMCON, BA6_VERCON, BA6_SUBCON, BA6_VERSUB, BA6_CODPRO, BA6_VERPRO, BA6_CLACAR"
	cQuery += " from " + RetSqlName("BA6") + " BA6"
	cQuery +=	" inner join " + RetSqlName("BDL") + " BDL"
	cQuery +=	  " on (    BDL_FILIAL = BA6_FILIAL"
	cQuery +=		  " and BDL_CODINT = BA6_CODINT"
	cQuery +=		  " and BDL_CODIGO = BA6_CLACAR)"
	cQuery += " where BA6.D_E_L_E_T_ = ' ' and BDL.D_E_L_E_T_ = ' '"
	cQuery +=	" and BDL_CODEDI <> 'N'"

	// CENARIO DE TESTE
	//cQuery +=	" and BA6_CODINT = '0001'"
	//cQuery +=	" and BA6_CODIGO = '0001'"
	//cQuery +=	" and BA6_NUMCON = '000000000001'"
	//cQuery +=	" and BA6_SUBCON = '000000001'"
	//cQuery +=	" and BA6_CODPRO = '0001'"

	cQuery += " order by BA6_CODINT, BA6_CODIGO, BA6_NUMCON, BA6_VERCON, BA6_SUBCON, BA6_VERSUB, BA6_CODPRO, BA6_VERPRO, BA6_CLACAR"

	TcQuery cQuery New Alias (cAliasQry)

	nTotReg		:= 0
	nCont		:= 0
	nProcess	:= 0

	dbeval({||nTotReg++ },,{||(cAliasQry)->(!EOF())})

	ProcRegua(nTotReg)

	// Todos os beneficiแrios com classes de car๊ncia em curso (desde que houve altera็ใo de prazos dentro dela) - e os proced. vinculados a ela
	(cAliasQry)->(DbGoTop())
	while (cAliasQry)->(!EOF())

		nCont++
		IncProc("Processando..." + CHR(13)+CHR(10) + "Registro: " + AllTrim(Str(nCont)) + " / " + AllTrim(Str(nTotReg)))

		nAux	:= aScan(aDePara, {|x| AllTrim(x[1]) == AllTrim((cAliasQry)->BA6_CLACAR ) })

		if nAux > 0

			for i := 1 to len( aDePara[nAux][2] )

				BA6->(DbSetOrder(1))	// BA6_FILIAL+BA6_CODINT+BA6_CODIGO+BA6_NUMCON+BA6_VERCON+BA6_SUBCON+BA6_VERSUB+BA6_CODPRO+BA6_VERPRO+BA6_CLACAR
				if !BA6->(DbSeek( xFilial("BA6") + (cAliasQry)->(BA6_CODINT+BA6_CODIGO+BA6_NUMCON+BA6_VERCON+BA6_SUBCON+BA6_VERSUB+BA6_CODPRO+BA6_VERPRO) + aDePara[nAux][2][i] ))

					BDL->(DbSetOrder(1))	// BDL_FILIAL+BDL_CODINT+BDL_CODIGO
					if BDL->(DbSeek( xFilial("BDL") + PlsIntPad() + aDePara[nAux][2][i] ))

						nAux2 := aScan(aClaQtd, {|x| AllTrim(x[1]) == aDePara[nAux][2][i] })

						if nAux2 > 0

							nProcess++

							BA6->( RecLock("BA6",.T.) )
								BA6->BA6_FILIAL	:= xFilial("BA6")
								BA6->BA6_CODINT	:= (cAliasQry)->BA6_CODINT
								BA6->BA6_CODIGO	:= (cAliasQry)->BA6_CODIGO
								BA6->BA6_NUMCON	:= (cAliasQry)->BA6_NUMCON
								BA6->BA6_VERCON	:= (cAliasQry)->BA6_VERCON
								BA6->BA6_SUBCON	:= (cAliasQry)->BA6_SUBCON
								BA6->BA6_VERSUB	:= (cAliasQry)->BA6_VERSUB
								BA6->BA6_CODPRO	:= (cAliasQry)->BA6_CODPRO
								BA6->BA6_VERPRO	:= (cAliasQry)->BA6_VERPRO
								BA6->BA6_CLACAR	:= aDePara[nAux][2][i]
								BA6->BA6_CARENC	:= BDL->BDL_CARENC
								BA6->BA6_UNICAR	:= BDL->BDL_UNCAR
								BA6->BA6_XCANBE	:= aClaQtd[nAux2][2][4]
								BA6->BA6_XUNNBE	:= aClaQtd[nAux2][2][3]
								BA6->BA6_XCABEC	:= aClaQtd[nAux2][2][6]
								BA6->BA6_XUNBEC	:= aClaQtd[nAux2][2][5]
							BA6->( MsUnlock() )
						
						endif

					endif

				endif

			next

		endif

		(cAliasQry)->(DbSkip())
	end
	(cAliasQry)->(DbCloseArea())

	MsgInfo("AJUSTE CLASSE DE CARสNCIA X SUBCONTRATO"				+ CHR(13)+CHR(10) + CHR(13)+CHR(10) +;
			"Total Registros Query: "		+ AllTrim(str(nTotReg)) + CHR(13)+CHR(10) +;
			"Total Registros Executados: "	+ AllTrim(str(nCont)) 	+ CHR(13)+CHR(10) +;
			"Total Registros Criados: "		+ AllTrim(str(nProcess)) )

endif


if MsgYesNo("Atualizar classe de car๊ncia na famํlia?")

	cQuery := " select BFJ_CODINT, BFJ_CODEMP, BFJ_MATRIC, BFJ_CLACAR, BFJ_CARENC, BFJ_UNICAR"
	cQuery += " from " + RetSqlName("BFJ") + " BFJ"
	cQuery +=	" inner join " + RetSqlName("BDL") + " BDL"
	cQuery +=	  " on (    BDL_FILIAL = BFJ_FILIAL"
	cQuery +=		  " and BDL_CODINT = BFJ_CODINT"
	cQuery +=		  " and BDL_CODIGO = BFJ_CLACAR)"
	cQuery += " where BFJ.D_E_L_E_T_ = ' ' and BDL.D_E_L_E_T_ = ' '"
	cQuery +=	" and BDL_CODEDI <> 'N'"

	// CENARIO DE TESTE
	//cQuery +=	" and BFJ_CODINT = '0001'"
	//cQuery +=	" and BFJ_CODEMP = '0001'"
	//cQuery +=	" and BFJ_MATRIC = '039041'"

	cQuery += " order by BFJ_CODINT, BFJ_CODEMP, BFJ_MATRIC, BFJ_CLACAR"

	TcQuery cQuery New Alias (cAliasQry)

	nTotReg		:= 0
	nCont		:= 0
	nProcess	:= 0

	dbeval({||nTotReg++ },,{||(cAliasQry)->(!EOF())})

	ProcRegua(nTotReg)

	// Todos os beneficiแrios com classes de car๊ncia em curso (desde que houve altera็ใo de prazos dentro dela) - e os proced. vinculados a ela
	(cAliasQry)->(DbGoTop())
	while (cAliasQry)->(!EOF())

		nCont++
		IncProc("Processando..." + CHR(13)+CHR(10) + "Registro: " + AllTrim(Str(nCont)) + " / " + AllTrim(Str(nTotReg)))

		nAux	:= aScan(aDePara, {|x| AllTrim(x[1]) == AllTrim((cAliasQry)->BFJ_CLACAR ) })

		if nAux > 0

			for i := 1 to len( aDePara[nAux][2] )

				BFJ->(DbSetOrder(1))	// BFJ_FILIAL+BFJ_CODINT+BFJ_CODEMP+BFJ_MATRIC+BFJ_CLACAR
				if !BFJ->(DbSeek( xFilial("BFJ") + (cAliasQry)->(BFJ_CODINT+BFJ_CODEMP+BFJ_MATRIC) + aDePara[nAux][2][i] ))

					BDL->(DbSetOrder(1))	// BDL_FILIAL+BDL_CODINT+BDL_CODIGO
					if BDL->(DbSeek( xFilial("BDL") + PlsIntPad() + aDePara[nAux][2][i] ))

						nProcess++

						BFJ->( RecLock("BFJ",.T.) )
							BFJ->BFJ_FILIAL	:= xFilial("BFJ")
							BFJ->BFJ_CODINT	:= (cAliasQry)->BFJ_CODINT
							BFJ->BFJ_CODEMP	:= (cAliasQry)->BFJ_CODEMP
							BFJ->BFJ_MATRIC	:= (cAliasQry)->BFJ_MATRIC
							BFJ->BFJ_CLACAR	:= aDePara[nAux][2][i]
							BFJ->BFJ_CARENC	:= (cAliasQry)->BFJ_CARENC
							BFJ->BFJ_UNICAR	:= (cAliasQry)->BFJ_UNICAR
						BFJ->( MsUnlock() )

					endif

				elseif BFJ->BFJ_CARENC > (cAliasQry)->BFJ_CARENC

					BFJ->( RecLock("BFJ",.F.) )
						BFJ->BFJ_CARENC	:= (cAliasQry)->BFJ_CARENC
						BFJ->BFJ_UNICAR	:= (cAliasQry)->BFJ_UNICAR
					BFJ->( MsUnlock() )

				endif

			next

		endif

		(cAliasQry)->(DbSkip())
	end
	(cAliasQry)->(DbCloseArea())

	MsgInfo("AJUSTE CLASSE DE CARสNCIA X FAMอLIA"					+ CHR(13)+CHR(10) + CHR(13)+CHR(10) +;
			"Total Registros Query: "		+ AllTrim(str(nTotReg)) + CHR(13)+CHR(10) +;
			"Total Registros Executados: "	+ AllTrim(str(nCont)) 	+ CHR(13)+CHR(10) +;
			"Total Registros Criados: "		+ AllTrim(str(nProcess)) )

endif


if MsgYesNo("Atualizar classes de car๊ncia no usuแrio?")

	cQuery := " select BFO_CODINT, BFO_CODEMP, BFO_MATRIC, BFO_TIPREG, BFO_CLACAR, BFO_DATCAR, BFO_CARENC, BFO_UNICAR"
	cQuery += " from " + RetSqlName("BFO") + " BFO"
	cQuery +=	" inner join " + RetSqlName("BDL") + " BDL"
	cQuery +=	  " on (    BDL_FILIAL = BFO_FILIAL"
	cQuery +=		  " and BDL_CODINT = BFO_CODINT"
	cQuery +=		  " and BDL_CODIGO = BFO_CLACAR)"
	cQuery += " where BFO.D_E_L_E_T_ = ' ' and BDL.D_E_L_E_T_ = ' '"
	cQuery +=	" and BDL_CODEDI <> 'N'"

	// CENARIO DE TESTE
	//cQuery +=	" and BFO_CODINT = '0001'"
	//cQuery +=	" and BFO_CODEMP = '0001'"
	//cQuery +=	" and BFO_MATRIC = '000016'"
	//cQuery +=	" and BFO_TIPREG = '01'"

	cQuery += " order by BFO_CODINT, BFO_CODEMP, BFO_MATRIC, BFO_TIPREG, BFO_CLACAR"

	TcQuery cQuery New Alias (cAliasQry)

	nTotReg		:= 0
	nCont		:= 0
	nProcess	:= 0

	dbeval({||nTotReg++ },,{||(cAliasQry)->(!EOF())})

	ProcRegua(nTotReg)

	// Todos os beneficiแrios com classes de car๊ncia em curso (desde que houve altera็ใo de prazos dentro dela) - e os proced. vinculados a ela
	(cAliasQry)->(DbGoTop())
	while (cAliasQry)->(!EOF())

		nCont++
		IncProc("Processando..." + CHR(13)+CHR(10) + "Registro: " + AllTrim(Str(nCont)) + " / " + AllTrim(Str(nTotReg)))

		nAux	:= aScan(aDePara, {|x| AllTrim(x[1]) == AllTrim((cAliasQry)->BFO_CLACAR ) })

		if nAux > 0

			for i := 1 to len( aDePara[nAux][2] )

				BFO->(DbSetOrder(1))	// BFO_FILIAL+BFO_CODINT+BFO_CODEMP+BFO_MATRIC+BFO_TIPREG+BFO_CLACAR
				if !BFO->(DbSeek( xFilial("BFO") + (cAliasQry)->(BFO_CODINT+BFO_CODEMP+BFO_MATRIC+BFO_TIPREG) + aDePara[nAux][2][i] ))

					BDL->(DbSetOrder(1))	// BDL_FILIAL+BDL_CODINT+BDL_CODIGO
					if BDL->(DbSeek( xFilial("BDL") + PlsIntPad() + aDePara[nAux][2][i] ))

						nProcess++

						BFO->( RecLock("BFO",.T.) )
							BFO->BFO_FILIAL	:= xFilial("BFO")
							BFO->BFO_CODINT	:= (cAliasQry)->BFO_CODINT
							BFO->BFO_CODEMP	:= (cAliasQry)->BFO_CODEMP
							BFO->BFO_MATRIC	:= (cAliasQry)->BFO_MATRIC
							BFO->BFO_TIPREG	:= (cAliasQry)->BFO_TIPREG
							BFO->BFO_DATCAR	:= StoD( (cAliasQry)->BFO_DATCAR )
							BFO->BFO_CLACAR	:= aDePara[nAux][2][i]
							BFO->BFO_CARENC	:= (cAliasQry)->BFO_CARENC
							BFO->BFO_UNICAR	:= (cAliasQry)->BFO_UNICAR
							BFO->BFO_YRGIMP	:= "1"						// SIM
						BFO->( MsUnlock() )

					endif

				elseif BFO->BFO_CARENC > (cAliasQry)->BFO_CARENC

					BFO->( RecLock("BFO",.F.) )
						BFO->BFO_CARENC	:= (cAliasQry)->BFO_CARENC
						BFO->BFO_UNICAR	:= (cAliasQry)->BFO_UNICAR
					BFO->( MsUnlock() )
				
				endif

			next

		endif

		(cAliasQry)->(DbSkip())
	end
	(cAliasQry)->(DbCloseArea())

	MsgInfo("AJUSTE CLASSE DE CARสNCIA X USUมRIO"					+ CHR(13)+CHR(10) + CHR(13)+CHR(10) +;
			"Total Registros Query: "		+ AllTrim(str(nTotReg)) + CHR(13)+CHR(10) +;
			"Total Registros Executados: "	+ AllTrim(str(nCont)) 	+ CHR(13)+CHR(10) +;
			"Total Registros Criados: "		+ AllTrim(str(nProcess)) )

endif


if MsgYesNo("Atualizar grupos de car๊ncia no produto?")

	// de-para de classe de carencia x grupo de carencia
	aDePar2	:= {{"041","022"},;
				{"042","023"},;
				{"043","024"},;
				{"044","025"},;
				{"045","026"},;
				{"046","027"},;
				{"047","028"},;
				{"048","029"},;
				{"049","030"}}
	
	cQuery := " select BAY_CODIGO, BAY_VERSAO, BAY_CODGRU, BAE_CLACAR, BAE_CARENC, BAE_UNCAR"
	cQuery += " from " + RetSqlName("BAY") + " BAY"
	cQuery +=	" inner join " + RetSqlName("BI3") + " BI3"
	cQuery +=	  " on (    BI3_FILIAL = BAY_FILIAL"
	cQuery +=		  " and BI3_CODINT = substr(BAY_CODIGO,1,4)"
	cQuery +=		  " and BI3_CODIGO = substr(BAY_CODIGO,5,4)"
	cQuery +=		  " and BI3_VERSAO = BAY_VERSAO)"
	cQuery +=	" inner join " + RetSqlName("BAE") + " BAE"
	cQuery +=	  " on (    BAE_FILIAL = BAY_FILIAL"
	cQuery +=		  " and BAE_CODIGO = BAY_CODIGO"
	cQuery +=		  " and BAE_VERSAO = BAY_VERSAO"
	cQuery +=		  " and BAE_CODGRU = BAY_CODGRU)"
	cQuery +=	" inner join " + RetSqlName("BDL") + " BDL"
	cQuery +=	  " on (    BDL_FILIAL = BAE_FILIAL"
	cQuery +=		  " and BDL_CODINT = substr(BAE_CODIGO,1,4)"
	cQuery +=		  " and BDL_CODIGO = BAE_CLACAR)"
	cQuery += " where BAY.D_E_L_E_T_ = ' ' and BI3.D_E_L_E_T_ = ' ' and BAE.D_E_L_E_T_ = ' ' and BDL.D_E_L_E_T_ = ' '"
	cQuery +=	" and BDL_CODEDI <> 'N'"

	// CENARIO DE TESTE
	
	cQuery += " order by BAY_CODIGO, BAY_VERSAO, BAY_CODGRU, BAE_CLACAR"

	TcQuery cQuery New Alias (cAliasQry)

	nTotReg		:= 0
	nCont		:= 0
	nProcess	:= 0

	dbeval({||nTotReg++ },,{||(cAliasQry)->(!EOF())})

	ProcRegua(nTotReg)

	// Todos os beneficiแrios com classes de car๊ncia em curso (desde que houve altera็ใo de prazos dentro dela) - e os proced. vinculados a ela
	(cAliasQry)->(DbGoTop())
	while (cAliasQry)->(!EOF())

		nCont++
		IncProc("Processando..." + CHR(13)+CHR(10) + "Registro: " + AllTrim(Str(nCont)) + " / " + AllTrim(Str(nTotReg)))

		nAux	:= aScan(aDePara, {|x| AllTrim(x[1]) == AllTrim((cAliasQry)->BAE_CLACAR ) })

		if nAux > 0

			for i := 1 to len( aDePara[nAux][2] )

				nAux2 := aScan(aDePar2, {|x| AllTrim(x[1]) == AllTrim( aDePara[nAux][2][i] ) })

				if nAux2 > 0

					BAY->(DbSetOrder(1))	// BAY_FILIAL+BAY_CODIGO+BAY_VERSAO+BAY_CODGRU
					if !BAY->(DbSeek( xFilial("BAY") + (cAliasQry)->(BAY_CODIGO+BAY_VERSAO) + aDePar2[nAux2][2] ))

						nProcess++

						BAY->( RecLock("BAY",.T.) )
							BAY->BAY_FILIAL	:= xFilial("BAY")
							BAY->BAY_CODIGO	:= (cAliasQry)->BAY_CODIGO
							BAY->BAY_VERSAO	:= (cAliasQry)->BAY_VERSAO
							BAY->BAY_CODGRU	:= aDePar2[nAux2][2]
						BAY->( MsUnlock() )

					endif

					BAE->(DbSetOrder(1))	// BAE_FILIAL+BAE_CODIGO+BAE_VERSAO+BAE_CODGRU+BAE_CLACAR
					if !BAE->(DbSeek( xFilial("BAE") + (cAliasQry)->(BAY_CODIGO+BAY_VERSAO) + aDePar2[nAux2][2] + aDePara[nAux][2][i] ))

						BDL->(DbSetOrder(1))	// BDL_FILIAL+BDL_CODINT+BDL_CODIGO
						if BDL->(DbSeek( xFilial("BDL") + PlsIntPad() + aDePara[nAux][2][i] ))

							nProcess++

							BAE->( RecLock("BAE",.T.) )
								BAE->BAE_FILIAL	:= xFilial("BAE")
								BAE->BAE_CODIGO	:= (cAliasQry)->BAY_CODIGO
								BAE->BAE_VERSAO	:= (cAliasQry)->BAY_VERSAO
								BAE->BAE_CODGRU	:= aDePar2[nAux2][2]
								BAE->BAE_CLACAR	:= aDePara[nAux][2][i]
								BAE->BAE_CARENC	:= (cAliasQry)->BAE_CARENC
								BAE->BAE_UNCAR	:= (cAliasQry)->BAE_UNCAR
							BAE->( MsUnlock() )

						endif

					elseif BAE->BAE_CARENC >(cAliasQry)->BAE_CARENC

						BAE->( RecLock("BAE",.F.) )
							BAE->BAE_CARENC	:= (cAliasQry)->BAE_CARENC
							BAE->BAE_UNCAR	:= (cAliasQry)->BAE_UNCAR
						BAE->( MsUnlock() )
					
					endif

				endif
			
			next

		endif

		(cAliasQry)->(DbSkip())
	end
	(cAliasQry)->(DbCloseArea())

	MsgInfo("AJUSTE GRUPO X CLASSE DE CARสNCIA"						+ CHR(13)+CHR(10) + CHR(13)+CHR(10) +;
			"Total Registros Query: "		+ AllTrim(str(nTotReg)) + CHR(13)+CHR(10) +;
			"Total Registros Executados: "	+ AllTrim(str(nCont)) 	+ CHR(13)+CHR(10) +;
			"Total Registros Criados: "		+ AllTrim(str(nProcess)) )

endif

MsgInfo("ATUALIZAวรO FINALIZADA!")

return
