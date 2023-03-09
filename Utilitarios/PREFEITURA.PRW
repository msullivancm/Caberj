#INCLUDE 'TOTVS.CH'
#INCLUDE 'TOPCONN.CH'

//Carrega o arquivo da prefeitura na tabela Oracle PREFEITURA_CARGA

User Function CargaPref()

Local nOpca 	:= GETF_LOCALHARD + GETF_NETWORKDRIVE
Local cArq 		:= cGetFile('Arquivo TXT | *.TXT','Arquivo TXT', 1,'\',.T.,nOpca)   

If !empty(cArq)
	Processa({||PCargaPrefeitura(cArq)},'Carga Prefeitura','Processando...',.F.)
Else
	MsgStop('Informe um arquivo!',AllTrim(SM0->M0_NOMECOM))
EndIf

Return

******************************************************************************************************************

Static Function PCargaPrefeitura(cArqPref)

Local cLine		:= ''
Local aLine		:= {}
Local nQtd 		:= 0
Local nI		:= 0
Local nHandle 	:= FT_FUse(cArqPref)
Local aCabec	:= {}
Local cFimIns	:= ''
Local cErro		:= ''
Local cIniIns	:= ''
Local aUpd		:= {}
Local cMsg		:= ''

cMsg := 'Esta rotina irá realizar a carga da Prefeitura na tabela PREFEITURA_CARGA.' 								+ CRLF
cMsg += '- A tabela PREFEITURA_CARGA terá todos os seus registros deletados e depois incluídos conforme a carga!' 	+ CRLF
cMsg += '---> Confirma a execução da carga?' 

If MsgYesNo(cMsg,AllTrim(SM0->M0_NOMECOM))
	
	FT_FGoTop()
	
	nQtd := FT_FLastRec()
	cTot := AllTrim(Transform(nQtd, "@E 999,999,999"))
	
	ProcRegua(nQtd)
	
	nQtd := 0
	FT_FGoTop()
	
	If TcSqlExec('DELETE FROM PREFEITURA_CARGA') <> 0
		
		cErro := "- Erro na execução do delete" + CRLF + 'TcSqlError [ ' + TcSqlError() + ' ]'
		MsgStop(cErro,AllTrim(SM0->M0_NOMECOM))
		
	Else
	
		While !FT_FEOF()
		
			IncProc('Linha: ' + AllTrim(Transform(++nQtd, "@E 999,999,999")) + ' de ' + cTot)
			
		  	cLine := FT_FReadLn() // Retorna a linha corrente
		  	
		  	If nQtd == 1 //Cabecalho
		  	
		  		aCabec := Separa(cLine,';',.T.)
		  		
		  		cIniIns := "INSERT INTO PREFEITURA_CARGA ("
		  		For nI := 1 to len(aCabec)
		  			cIniIns += aCabec[nI] + ','
		  		Next
		  		
		  		cIniIns += 'ID'
		  		cIniIns += ") VALUES (" 
		  		
		  	Else
		  	
		  		aLine := Separa(cLine,';',.T.)
		  		
		  		If len(aLine) > 0
		  		
		  			cFimIns := ''
		  			
			  		For nI := 1 to len(aLine)
			  			cFimIns += "'" + aLine[nI] + "',"
			  		Next
			  		
			  		cFimIns += cValToChar(nQtd - 1)
			  		cFimIns += ')'
			  		
			  		If TcSqlExec(cIniIns + cFimIns) <> 0
			
						cErro := "- Erro na execução da instrução:" + CRLF + Space(3) + cIniIns + cFimIns + CRLF + Space(3) + 'TcSqlError [ ' + TcSqlError() + ' ]'
						MsgStop(cErro,AllTrim(SM0->M0_NOMECOM))
						Exit
			  		EndIf
			  		
			  	EndIf
		
		  	EndIf
		  	
			FT_FSKIP()
		  	
		EndDo 
		
		aAdd(aUpd,"UPDATE PREFEITURA_CARGA SET CPF_ORI=CPF,CPF_SEGURADO_ORI=CPF_SEGURADO,DTNASC_ORI=DTNASC,TIPOLOGENDER_ORI=TIPOLOGENDER,NOMELOGENDER_ORI=NOMELOGENDER,COMPLENDER_ORI=COMPLENDER")
		aAdd(aUpd,"UPDATE PREFEITURA_CARGA SET CPF = LPAD(TRIM(CPF),11,'0'),CPF_SEGURADO = LPAD(TRIM(CPF_SEGURADO),11,'0')")
		aAdd(aUpd,"UPDATE PREFEITURA_CARGA SET NOME = UPPER(NOME),TIPOLOGENDER = UPPER(TIPOLOGENDER),NOMELOGENDER = UPPER(NOMELOGENDER),COMPLENDER = UPPER(COMPLENDER),DTNASC=REPLACE(DTNASC,'-','')")
		aAdd(aUpd,"UPDATE PREFEITURA_CARGA SET NOME = ALFA_NUM_EXCECAO_PARAMETRO(NOME,' ')")
		aAdd(aUpd,"UPDATE PREFEITURA_CARGA SET NOMELOGENDER = REPLACE(NOMELOGENDER,TIPOLOGENDER,'')")
		aAdd(aUpd,"UPDATE PREFEITURA_CARGA SET COMPLENDER = REPLACE(COMPLENDER,TIPOLOGENDER,'')")
		aAdd(aUpd,"UPDATE PREFEITURA_CARGA SET COMPLENDER = REPLACE(COMPLENDER,NOMELOGENDER,'')")
		aAdd(aUpd,"UPDATE PREFEITURA_CARGA SET TIPOLOGENDER = ABREV_ENDERECO_PREFEITURA(TIPOLOGENDER),NOMELOGENDER = ABREV_ENDERECO_PREFEITURA(NOMELOGENDER),COMPLENDER = ABREV_ENDERECO_PREFEITURA(COMPLENDER)")
		
		ProcRegua(len(aUpd))
		
		For nI := 1 to len(aUpd)
		
			IncProc('Realizando ajustes... [ ' + cValToChar(nI) + ' de ' + cValToChar(len(aUpd)) + ' ]')
		
			If TcSqlExec(aUpd[nI]) <> 0
				
				cErro := "- Erro na execução da instrução:" + CRLF + Space(3) + aUpd[nI] + CRLF + Space(3) + 'TcSqlError [ ' + TcSqlError() + ' ]'
				MsgStop(cErro,AllTrim(SM0->M0_NOMECOM))
				Exit
				
			EndIf
			
		Next
		
	EndIf
	
	// Fecha o Arquivo
	FCLOSE(nHandle)
	FT_FUSE() 
	
	MsgAlert('Carga finalizada!',AllTrim(SM0->M0_NOMECOM))
	
Else
	MsgAlert('Operação cancelada',AllTrim(SM0->M0_NOMECOM))
EndIf

Return

******************************************************************************************************************

//Remove do arquivo de carteirinha a linha correspondente a uma matricula na BA1.

User Function RemBA1Cart

Local nOpca 	:= 0//Somente servidor
Local cArq 		:= ''
Local cPath		:= ''
Local aArqs		:= ''
Local nTipoAj	:= Aviso('Atenção','Deseja processar 1 arquivo ou todos os arquivos do diretório?',{'1 arquivo','Diretório','Cancelar'})   
Local nI		:= 0

Private aFiles 		
Private aSizes 		

If nTipoAj == 1

	cArq := cGetFile('Arquivo TXT | *.TXT','Arquivo TXT', 1,'\',.T.,nOpca)

	If !empty(cArq)
		Processa({||PRemBA1Cart(cArq)},'Ajuste Carteirinha Prefeitura','Processando...',.F.)
	Else
		MsgStop('Informe um arquivo!',AllTrim(SM0->M0_NOMECOM))
	EndIf

ElseIf nTipoAj == 2
	
	cPath 	:= cGetFile('*.*','Arquivo TXT', 1,'\',.F.,128,.T.,.T.)
	
	nCount 	:= aDir(AllTrim(cPath) + "*.txt", aFiles, aSizes)
	
	For nI := 1 to nCount
		cArq := cPath + aFiles[nI]
		Processa({||PRemBA1Cart(cArq,.T.)},'Ajuste Carteirinha Prefeitura','Processando...',.F.)
	Next
	
Else
	MsgStop('Operação cancelada',AllTrim(SM0->M0_NOMECOM))
EndIf

Return

******************************************************************************************************************

Static Function PRemBA1Cart(cArqPref,lDiretorio)

Local cLine		:= ''
Local aLine		:= {}
Local nQtd 		:= 0
Local nI		:= 0
Local nPosDiv	:= RAt('\',cArqPref)
Local cNomArq 	:= Substr(cArqPref,nPosDiv+1,Len(cArqPref)-nPosDiv)
Local cNovoNome	:= Stuff(cNomArq,At('.',cNomArq),0,"_PREF")
Local cPathArq 	:= Left(cArqPref,nPosDiv)
Local nHandle 	:= FT_FUse(cArqPref)
Local nHdl		:= 0
Local aCabec	:= {}
Local cMsg		:= ''
Local aNewArq	:= {}
Local cNomeBen	:= ''
Local cMatBen	:= ''
Local cPlanoBen	:= ''
Local cBuffer	:= ''
Local nLinOri	:= 0
Local cCodEmp	:= ''

Default lDiretorio := .F.

cMsg := 'Esta rotina irá realizar a exclusão de matrículas no arquivo de carteirinhas da PREFEITURA.'	+ CRLF
cMsg += '- O novo arquivo será gerado na mesma pasta onde estiver o arquivo original ' 					+ CRLF
cMsg += '  com o nome do original acrescido de _PREF antes da extensão do arquivo.' 					+ CRLF
cMsg += '---> Confirma a execução da carga?' 

If lDiretorio .or. MsgYesNo(cMsg,AllTrim(SM0->M0_NOMECOM))
	
	FT_FGoTop()
	
	nLinOri := FT_FLastRec()
	cTot 	:= AllTrim(Transform(nLinOri, "@E 999,999,999"))
	
	ProcRegua(nLinOri)
	
	nQtd := 0
	
	FT_FGoTop()

	While !FT_FEOF()
	
		IncProc('Linha: ' + AllTrim(Transform(++nQtd, "@E 999,999,999")) + ' de ' + cTot)
		
	  	cLine := FT_FReadLn() // Retorna a linha corrente
	  	
  		aLine := Separa(cLine,';',.T.)
  		
  		If len(aLine) > 0
  		
  			cCodEmp		:= AllTrim(aLine[2])
	  		cNomeBen	:= aLine[5]
			cMatBen		:= aLine[7]
			cPlanoBen	:= aLine[8]
			
			If ( len(aLine) >= 24 )
			
				cDescrRede	:= aLine[24]
				aLine[24]	:= ''//Leonardo Portella - 01/06/15 - Solicitacao Dr Jose Paulo - nao exibir a Rede
				
			EndIf 
			
			cMatBen		:= Replace(cMatBen,'.','')
			cMatBen		:= Replace(cMatBen,'-','')
			
			aDadMatPref := aDadMatrCart(cMatBen, cCodEmp)
			
			BA1->(DbGoTo(aDadMatPref[7]))
			cChvBA1 := BA1->( BA1_FILIAL + BA1_CODINT + BA1_CODEMP + BA1_MATRIC )
			
			aLine[15]	:= DtoC(BA1->BA1_DATNAS)
			aLine[16]	:= StrZero(Day(BA1->BA1_DATNAS),2) + '/' + StrZero(Month(BA1->BA1_DATNAS),2) +  '/' + StrZero(Year(BA1->BA1_DATNAS),4)
			aLine[6]	:= AllTrim(Upper(BA1->BA1_NOMUSR))
			
			BA1->(DbSetOrder(2))
			BA1->(DbSeek(cChvBA1 + '00'))
			
			aLine[5]	:= AllTrim(Upper(BA1->BA1_NOMUSR))//Titular
			
			If aLine[8] $ '0096|0097'
				aLine[25] := 'Urgência/Emergência: 0300-1172-888'
			EndIf
			
			While len(aLine) < 27//Somente se nao foram incluidos os dados abaixo. Se foram incluidos, nao altero. 
				aAdd(aLine,'')
			EndDo
			
			aLine[26] := AllTrim(Upper(aDadMatPref[2])) //Leonardo Portella - 01/06/15 - Inclusao do Nome Social
			aLine[27] := AllTrim(Upper(aDadMatPref[3])) //Leonardo Portella - 01/06/15 - Inclusao do Plano Odonto
			
			//Leonardo Portella - 05/06/15 - Inicio - Correcoes no plano. 
			//Pegar o plano e acomodacao conforme estiver na BA1 e BI3
			
			aLine[8]  := aDadMatPref[4]
			aLine[9]  := aDadMatPref[5]
			aLine[10] := aDadMatPref[6]
			
			//Leonardo Portella - 05/06/15 - Fim
			
			aLine[10] := Upper(aLine[10])
			aLine[10] := Replace(aLine[10],'Ç','C') 
			aLine[10] := Replace(aLine[10],'Ã','A') 
			aLine[10] := Replace(aLine[10],'ACOMODACAO','') 
			aLine[10] := AllTrim((aLine[10]))
			
			If !aDadMatPref[1] //So adiciono no novo vetor se nao for para excluir
				cLine := ''
				
				For nI := 1 to len(aLine)
					cLine += aLine[nI] + ';'
				Next
				
				aAdd(aNewArq,cLine)
				/*
				If cCodEmp == '0024'
				
					cIns := "UPDATE CARTEIRA_PREFEITURA SET GERADO_CART = 'SIM' WHERE RECBA1 = " + cValToChar(aDadMatPref[7])
				
					If ( TcSqlExec(cIns) < 0 )
						MsgStop("Erro no update de dados na tabela 'CARTEIRA_PREFEITURA'" + CRLF + CRLF + TcSqlError(),AllTrim(SM0->M0_NOMECOM))
						Return 
					EndIf
				
				EndIf
				*/
			EndIf
			
	  		
	  	EndIf
	  	
		FT_FSKIP()
	  	
	EndDo 
	
	// Fecha o Arquivo
	FCLOSE(nHandle)
	FT_FUSE() 
	
	If File(cPathArq + cNovoNome) 
		If ( FErase(cPathArq + cNovoNome) <> 0 )
			MsgStop('Erro ao deletar o arquivo [ ' + cPathArq + cNovoNome + ' ].' + CRLF + 'Operação cancelada...',AllTrim(SM0->M0_NOMECOM))
			Return 
		EndIf
	EndIf
	
	nHdl := FCreate(cPathArq + cNovoNome)  
	
	nQtd := len(aNewArq)
	cTot := AllTrim(Transform(nQtd, "@E 999,999,999"))
	
	ProcRegua(nQtd) 
	
	For nI := 1 to len(aNewArq)               
	
		IncProc('Gerando arquivo. Linha: ' + AllTrim(Transform(nI, "@E 999,999,999")) + ' de ' + cTot)
		
	  	cBuffer	:= aNewArq[nI] + CRLF
	
		FWrite(nHdl,cBuffer,len(cBuffer)) 
		
	Next 
	
	FClose(nHdl)
	
	If lDiretorio .or. File(cPathArq + cNovoNome)
		cMsg := 'Ajuste de carteirinhas Prefeitura finalizado!' 					+ CRLF
		cMsg += '- Arquivo [ ' + cPathArq + cNovoNome + ' ] gerado.' 				+ CRLF
		cMsg += '- Arquivo original [ ' + cValToChar(nLinOri) + ' linhas ]' 		+ CRLF
		cMsg += '- Arquivo gerado [ ' + cValToChar(len(aNewArq)) + ' linhas ]' 		+ CRLF
		cMsg += '- Diferença [ ' + cValToChar(nLinOri- len(aNewArq)) + ' linhas ]' 	+ CRLF
		
		MsgAlert(cMsg,AllTrim(SM0->M0_NOMECOM))
	Else
		MsgStop('Ocorreu algum erro na criação do arquivo [ ' + cPathArq + cNovoNome + ' ]. Verifique...',AllTrim(SM0->M0_NOMECOM))
	EndIf
	
Else
	MsgAlert('Operação cancelada',AllTrim(SM0->M0_NOMECOM))
EndIf

Return

******************************************************************************************************************

Static Function aDadMatrCart(cMatric, cCodEmp)

Local lExcluiCart 	:= .F.
Local aArea			:= GetArea()
Local aAreaBA1		:= BA1->(GetArea())
Local aAreaBI3		:= BI3->(GetArea())
Local cCodPla		:= ''
Local cDesPla		:= ''
Local cAcomoda		:= ''
Local cNomSocial	:= ''
Local cPlanoOdo		:= ''
Local cMatOdo		:= ''
Local nRecBA1		:= 0
Local dNasc		
Local aExcl2528		:= {}	 

BA1->(DbSetOrder(2))
BA1->(DbGoTop())

If BA1->(DbSeek(xFilial('BA1') + cMatric))

	nRecBA1		:= BA1->(Recno())
	/*
	If cCodEmp == '0024'
	
		lExcluiCart := lRecInLista(nRecBA1)
		
	ElseIf cCodEmp $ '0025|0028'
	
		//Exclusoes solicitadas pela Lucia Bandeira
		
		aAdd(aExcl2528,'00010025000070009')
		aAdd(aExcl2528,'00010025000070017')
		aAdd(aExcl2528,'00010025000070025')
		aAdd(aExcl2528,'00010025000164003')
		aAdd(aExcl2528,'00010025000174009')
		aAdd(aExcl2528,'00010025000174017')
		aAdd(aExcl2528,'00010025000174025')
		aAdd(aExcl2528,'00010025000171000')
		aAdd(aExcl2528,'00010025000171018')
		aAdd(aExcl2528,'00010025000171026')
		aAdd(aExcl2528,'00010025000171034')
		aAdd(aExcl2528,'00010025000265004')
		aAdd(aExcl2528,'00010025000112003')
		aAdd(aExcl2528,'00010025000112011')
		aAdd(aExcl2528,'00010025000112020')
		aAdd(aExcl2528,'00010025000112038')
		aAdd(aExcl2528,'00010025000145009')
		aAdd(aExcl2528,'00010025000145017')
		aAdd(aExcl2528,'00010025000145033')
		aAdd(aExcl2528,'00010025000271004')
		aAdd(aExcl2528,'00010028000003004')
		aAdd(aExcl2528,'00010028000022009')
		aAdd(aExcl2528,'00010025000184004')
		aAdd(aExcl2528,'00010025000184012')
		aAdd(aExcl2528,'00010025000184020')
		aAdd(aExcl2528,'00010025000261009')
		aAdd(aExcl2528,'00010025000261017')
		aAdd(aExcl2528,'00010025000261025')
		aAdd(aExcl2528,'00010025000298000')
		aAdd(aExcl2528,'00010028000012003')
		aAdd(aExcl2528,'00010028000012011')
		aAdd(aExcl2528,'00010028000012020')
		aAdd(aExcl2528,'00010028000012038')
		aAdd(aExcl2528,'00010025000707007')
		aAdd(aExcl2528,'00010025000707015')
		aAdd(aExcl2528,'00010025000050008')
		aAdd(aExcl2528,'00010025000050016')
		aAdd(aExcl2528,'00010025000050024')
		aAdd(aExcl2528,'00010025000050032')
		aAdd(aExcl2528,'00010025000050040')
		aAdd(aExcl2528,'00010025000050059')
		aAdd(aExcl2528,'00010025000050075')
		aAdd(aExcl2528,'00010025000050075')
		aAdd(aExcl2528,'00010025000142000')
		aAdd(aExcl2528,'00010025000142018')
		aAdd(aExcl2528,'00010025000142026')
		aAdd(aExcl2528,'00010025000142034')
		aAdd(aExcl2528,'00010025000262005')
		aAdd(aExcl2528,'00010025000262013')
		aAdd(aExcl2528,'00010025000262021')
		
		lExcluiCart := ( aScan(aExcl2528,cMatric) > 0 )
	
	EndIf
	*/	
	cNomSocial	:= BA1->BA1_YNMSOC
	cMatOdo		:= BA1->BA1_YMTODO
	
	cCodPla		:= BA1->BA1_CODPLA
 	
	BI3->(DbSetOrder(1))
	BI3->(DbSeek(xFilial('BI3') + BA1->BA1_CODINT + cCodPla))
	
	cDesPla		:= AllTrim(Upper(BI3->BI3_DESCAR))
	cAcomoda	:= If(AllTrim(BI3->BI3_CODACO) == '1','INDIVIDUAL','COLETIVA')
	
	BA1->(DbGoTop())
	
	If BA1->(DbSeek(xFilial('BA1') + cMatOdo))
		cPlanoOdo	:= BA1->BA1_YDPLAP //Descricao Plano Dental Prefeitura
	EndIf
	 
Else
	lExcluiCart := .T.
EndIf

//Leonardo Portella - 05/06/15 - Solicitacao da Marcia - nao enviar se tiver nome social
If !empty(cNomSocial)
	lExcluiCart := .T.	
EndIf 


BA1->(RestArea(aAreaBA1))
BI3->(RestArea(aAreaBI3))
RestArea(aArea)

Return {lExcluiCart,cNomSocial,cPlanoOdo,cCodPla,cDesPla,cAcomoda,nRecBA1}

******************************************************************************************************************

Static Function lRecInLista(nRecBA1)

Local lLocalizado 	:= .F.
Local aArea			:= GetArea()
Local aAreaBA1		:= BA1->(GetArea())
Local cChvFam		:= ''
Local cRecIn 		:= cValToChar(nRecBA1) + ','
Local cQry			:= ''
Local cAlQry		:= GetNextAlias()		

BA1->(DbGoTo(nRecBA1))

cChvFam := BA1->(BA1_FILIAL + BA1_CODINT + BA1_CODEMP + BA1_MATRIC) 

BA1->(DbSetOrder(2))

BA1->(DbSeek(cChvFam)) 

While !BA1->(EOF()) .and. ( cChvFam == BA1->(BA1_FILIAL + BA1_CODINT + BA1_CODEMP + BA1_MATRIC) ) 
	
	If empty(BA1->BA1_DATBLO) //Bloqueado nao precisa considerar na regra de nao mandar toda a familia 
		cRecIn += cValToChar(BA1->(Recno())) + ','
	EndIf
	
	BA1->(DbSkip())

EndDo

cRecIn 	:= Left(cRecIn,Len(cRecIn) - 1)

cQry 	:= "SELECT *" 								+ CRLF
cQry 	+= "FROM CARTEIRA_PREFEITURA" 				+ CRLF 
cQry 	+= "WHERE RECBA1 = " + cValToChar(nRecBA1) 	+ CRLF

//Primeiro envio apos a carga inicial
cQry 	+= "  AND GERA_CARTEIRA = 'S3'" 			+ CRLF 
cQry 	+= "  AND GERADO_CART IS NULL" 				+ CRLF

TcQuery cQry New Alias cAlQry

If cAlQry->(EOF())
	lLocalizado := .T.//Nao envia se nao localizar na CARTEIRA_PREFEITURA 
Else
	cAlQry->(DbCloseArea())
	cAlQry	:= GetNextAlias()
	
	cQry 	:= "SELECT *" 								+ CRLF
	cQry 	+= "FROM CARTEIRA_PREFEITURA" 				+ CRLF 
	cQry 	+= "WHERE RECBA1 IN (" + cRecIn + ")" 		+ CRLF 
	cQry 	+= "  AND GERA_CARTEIRA = 'NAO'" 			+ CRLF
	cQry 	+= "  AND OBS_CARTEIRA <> 'MATRIC. ODONTO'" + CRLF

	TcQuery cQry New Alias cAlQry
	
	lLocalizado := !cAlQry->(EOF())//Nao envia se alguem da familia estiver como NAO na CARTEIRA_PREFEITURA 
EndIf

cAlQry->(DbCloseArea())

BA1->(RestArea(aAreaBA1))
RestArea(aArea)

Return lLocalizado

******************************************************************************************************************

//Inclusao de beneficiarios conforme dados do cadastro

User Function IncBenCad()

Local nOpca 	:= GETF_LOCALHARD + GETF_NETWORKDRIVE
Local cArq 		:= cGetFile('Arquivo TXT | *.TXT','Arquivo TXT', 1,'\',.T.,nOpca)   

If !empty(cArq)
	Processa({||PIncBenCad(cArq)},'Processando','Processando...',.F.)
Else
	MsgStop('Informe um arquivo!',AllTrim(SM0->M0_NOMECOM))
EndIf

Return

******************************************************************************************************************

Static Function PIncBenCad(cArqPref)

Local cLine		:= ''
Local aLine		:= {}
Local nQtd 		:= 0
Local nI		:= 0
Local nHandle 	:= FT_FUse(cArqPref)
Local aCabec	:= {}
Local cFimIns	:= ''
Local cErro		:= ''
Local cIniIns	:= ''
Local aUpd		:= {}
Local cMsg		:= ''
Local aNewFile	:= {}
Local aUsrCad	:= {}
Local nI		:= 0

cMsg := 'Esta rotina irá gerar um arquivo com base no arquvo espelho total da Prefeitura.' 	+ CRLF
cMsg += '- Somente usuários informados na rotina aUsrIncCad!' 								+ CRLF
cMsg += '---> Confirma?' 

If MsgYesNo(cMsg,AllTrim(SM0->M0_NOMECOM))

	aUsrCad := aUsrIncCad()
	
	FT_FGoTop()
	
	nQtd := FT_FLastRec()
	cTot := AllTrim(Transform(nQtd, "@E 999,999,999"))
	
	ProcRegua(nQtd)
	
	nQtd := 0
	FT_FGoTop()
	
	While !FT_FEOF()
	
		IncProc('Linha: ' + AllTrim(Transform(++nQtd, "@E 999,999,999")) + ' de ' + cTot)
		
	  	cLine := FT_FReadLn() // Retorna a linha corrente
	  	
	  	//Se a linha tiver a pessoa eu incluo, sem me preocupar com duplicidade pois o CABA336 
	  	//esta criticando isso
	  	
	  	If nQtd == 1 //Cabecalho
	  		aAdd(aNewFile,cLine)
	  	Else	  	
	  		For nI := 1 to len(aUsrCad)
				If At(aUsrCad[nI],cLine) > 0
					aAdd(aNewFile,cLine)
					Exit
				EndIf
	  		Next	
	  	EndIf
	  		
		FT_FSKIP()
	  	
	EndDo
	
	// Fecha o Arquivo
	FCLOSE(nHandle)
	FT_FUSE() 
	
	cArqPref := Replace(Upper(cArqPref),'.TXT','_INCLUSOES.TXT')
	
	nHdl := FCreate(cArqPref)  
	
	nQtd := len(aNewFile)
	cTot := AllTrim(Transform(nQtd, "@E 999,999,999"))
	
	ProcRegua(nQtd) 
	
	For nI := 1 to len(aNewFile)               
	
		IncProc('Gerando arquivo. Linha: ' + AllTrim(Transform(nI, "@E 999,999,999")) + ' de ' + cTot)
		
	  	cBuffer	:= aNewFile[nI] + CRLF
	
		FWrite(nHdl,cBuffer,len(cBuffer)) 
		
	Next 
	
	FClose(nHdl)
	
	MsgAlert('Processo finalizado!',AllTrim(SM0->M0_NOMECOM))
	
Else
	MsgAlert('Operação cancelada',AllTrim(SM0->M0_NOMECOM))
EndIf

Return

******************************************************************************************************************

//Retorna vetor com os dados informados pelo cadastro

Static Function aUsrIncCad

Local aUsr := {}

aAdd(aUsr,'ISABEL DO CARMO ROCHA')
aAdd(aUsr,'HELOISA ROMANO TOMBASCO DOS SANTOS')
aAdd(aUsr,'MARIA HELENA DA CRUZ')
aAdd(aUsr,'EDNA DE SOUZA FERREIRA')
aAdd(aUsr,'SANDRA REGINA FERREIRA DE MESQUITA')
aAdd(aUsr,'MARIA IGNEZ IGAYARA BERKER')
aAdd(aUsr,'MARIA DE LOURDES SOARES DE ANDRADE')
aAdd(aUsr,'KATIA HALAC')
aAdd(aUsr,'ELISABETH DOS ANJOS COVAS')
aAdd(aUsr,'MARIA DAS GRAÇAS REZENDE SILVA')
aAdd(aUsr,'PATRICIA MARCELINO DA SILVA CARRIJO')
aAdd(aUsr,'NILZA MARCAL MARQUES RAMOS')
aAdd(aUsr,'MARIA JOSE GOMES FAGUNDES DE CARVALHO')
aAdd(aUsr,'KARLA DE DEUS MACHADO')
aAdd(aUsr,'STANISLAW PEREZYNSKI')
aAdd(aUsr,'RITA DE CASSIA RODRIGUES DO NASCIMENTO')
aAdd(aUsr,'GILCEMARA LOURENÇO FERREIRA')
aAdd(aUsr,'MARILENE MIRANDA SAMPAIO')
aAdd(aUsr,'LAERCIO ARRAIS')
aAdd(aUsr,'ANNA PAULA MEIRELLES DE AZEVEDO')
aAdd(aUsr,'GRAZIELA RODRIGUES DA SILVA')
aAdd(aUsr,'ADRIANE BARBOSA SILVA DE OLIVEIRA')
aAdd(aUsr,'ROSANGELA PAES PEREIRA ABECASSIS')
aAdd(aUsr,'RAQUEL DE ALMEIDA SILVA')
aAdd(aUsr,'PRISCILA NEVES DA SILVA')
aAdd(aUsr,'GABRIELA DUARTE CUNHA MACHADO')
aAdd(aUsr,'AMAURY GOMES DE ALMEIDA')
aAdd(aUsr,'DANIELE HENRIQUES')
aAdd(aUsr,'TUANY ALVES SANTOS DE MELLO')
aAdd(aUsr,'JOELMA SANTOS F. VARELA RAIMUNDO')
aAdd(aUsr,'ERICA PIPAS MORGADO')
aAdd(aUsr,'HELENA STUTZ')
aAdd(aUsr,'JUCY DA SILVA GUERRA')
aAdd(aUsr,'HILMA FERNANDES RIBEIRO PEIXOTO')
aAdd(aUsr,'EDIL ARENA')
aAdd(aUsr,'MARIA THEREZA DA SILVA COSTA')
aAdd(aUsr,'ELIANE LOPES MARQUES')
aAdd(aUsr,'MARIA CRISTINA CAMPOS')
aAdd(aUsr,'LUCI QUINTILIANO EMYGDIO')
aAdd(aUsr,'ELIZABETH PARANHOS DARDEAU VIEIRA')
aAdd(aUsr,'ELIANE PEREIRA LEITE')
aAdd(aUsr,'JOAO CARLOS PINTO LOJA')
aAdd(aUsr,'JOAQUIM DO ESPIRITO SANTO TEIXEIRA')
aAdd(aUsr,'VALCI DE SOUZA')
aAdd(aUsr,'JOEL BASILIO MAGNO')
aAdd(aUsr,'MARIA DULCE VIEIRA GUIMARAES')
aAdd(aUsr,'OSWALDO GOMES DE SOUZA')
aAdd(aUsr,'RAIMUNDA CARDOSO DE SOUSA')
aAdd(aUsr,'MARIA DE LOURDES FERREIRA PAILHOUS')
aAdd(aUsr,'EDI DE OLIVEIRA BRAILE')
aAdd(aUsr,'SUELI DE OLIVEIRA GOUVEA')
aAdd(aUsr,'VERA LUCIA MILEZI LOBO')
aAdd(aUsr,'PERCILIA DE LIMA MAGALHAES')
aAdd(aUsr,'AGLAIR PAIVA DIAS NOGUEIRA')
aAdd(aUsr,'LUCIA HELENA DE CASTRO LACERDA')
aAdd(aUsr,'SILVIA CRUZ ARAUJO SANTOS')
aAdd(aUsr,'ANGELA MARIA MACEDO GUIMARAES')
aAdd(aUsr,'LIGIA MARIA BRUGGER PEREZ')
aAdd(aUsr,'VALERIA BUENO DE MORAES')
aAdd(aUsr,'AMELIA MARIA BLOOMFIELD GAMA')
aAdd(aUsr,'MARIA EMILIA LOPES DE OLIVEIRA')
aAdd(aUsr,'ANGELA LEAL LARANJEIRA DE SOUSA')
aAdd(aUsr,'MARIA DA CONCEICAO RODRIGUES FILHO')
aAdd(aUsr,'MARIA LUCIA FERREIRA TERZI')
aAdd(aUsr,'MARILDA ROCIO DE SA REGO')
aAdd(aUsr,'DAISY PAULA ALVES')
aAdd(aUsr,'GLORIA MARIA PEDREIRA GONZAGA MATTOS')
aAdd(aUsr,'MARIA BERNADETE IGNACIO ANNES')
aAdd(aUsr,'DENIZE JOSE MARTINS ALVARES')
aAdd(aUsr,'ELIZABETH BOM SENHOR')
aAdd(aUsr,'VIRGINIA SANTOS BORDALO')
aAdd(aUsr,'AIRA SUZANA RIBEIRO MARTINS')
aAdd(aUsr,'VERA LUCIA DA PONTE')
aAdd(aUsr,'CRISTINA LEONEL DIAS RAMOS')
aAdd(aUsr,'CELIA REGINA MORAES WISNESKY SALES')
aAdd(aUsr,'JOSALIA DE OLIVEIRA RIJO')
aAdd(aUsr,'CARMEN LUCIA ASSUNCAO FELISBERTO DE CARVALHO')
aAdd(aUsr,'VERA MARTINS DO SANTOS')
aAdd(aUsr,'VERA LUCIA DE LIMA FIGUEIREDO')
aAdd(aUsr,'REGINA CELIA DE OLIVEIRA E SILVA CURY')
aAdd(aUsr,'MARIA DO CARMO CASTANHEIRO BRITO')
aAdd(aUsr,'MIRIAM EMILE PACHECO DE AZEVEDO')
aAdd(aUsr,'WILMA MUCHALUAT')
aAdd(aUsr,'MARIA ESTELA GOMES BESERRA')
aAdd(aUsr,'HELIO NELSON DI IULIO')
aAdd(aUsr,'ROSA UMBELINA ARAUJO DA COSTA')
aAdd(aUsr,'MOACIR DA ROCHA FREIRE')
aAdd(aUsr,'ANTONIO PEREIRA SOBRINHO')
aAdd(aUsr,'LUCIENE FIGUEIRA DE MORAES')
aAdd(aUsr,'MARIA ELIAS DE SOUZA')
aAdd(aUsr,'ALAIR AUGUSTO MARTINS')
aAdd(aUsr,'SEBASTIAO DA COSTA FEIJO')
aAdd(aUsr,'APARECIDA CAVALCANTI LIMA RIEGER')
aAdd(aUsr,'ALBERTO FONSECA RODRIGUES')
aAdd(aUsr,'MARIA ANGELICA DE SOUZA')
aAdd(aUsr,'LUCIA HELENA CORDEIRO DE SOUZA AGRA')
aAdd(aUsr,'RUTH FONSECA DO NASCIMENTO')
aAdd(aUsr,'FREDERICO REBELO DE MELO')
aAdd(aUsr,'JANETE GOMES MOREIRA')
aAdd(aUsr,'CIRLEI SANTANA DE ARAÚJO')
aAdd(aUsr,'LUCIA DE FATIMA SOARES VIEIRA TENORIO')
aAdd(aUsr,'NEUZA GUAPE FERREIRA')
aAdd(aUsr,'RICARDO VIEIRA SILVA')
aAdd(aUsr,'ENEDINA RANGEL GOMES')
aAdd(aUsr,'MARIA LUCIA RIBEIRO CAVALCANTE')
aAdd(aUsr,'MARCIA DA SILVA TANNUS')
aAdd(aUsr,'AMAURI DOS SANTOS')
aAdd(aUsr,'CLAUDIA LUCIA MOTA ESTEVES')
aAdd(aUsr,'ELIZABETH CAVALCANTI SERRA DE LUCAS')
aAdd(aUsr,'HELOISA ALVES DA FONSECA')
aAdd(aUsr,'MIRIAM TRINDADE CARNEIRO')
aAdd(aUsr,'MARLENE FERREIRA HEMERLY')
aAdd(aUsr,'NAIR SEVERINA DA CONCEICAO')
aAdd(aUsr,'MARIA DE LOURDES SILVA GOMES')
aAdd(aUsr,'VALTER DE SOUSA MARGATO')
aAdd(aUsr,'MARIA FRANCISCA MENDES')
aAdd(aUsr,'MARIA DE FATIMA ESTEVES DE OLIVEIRA')
aAdd(aUsr,'MIRIAM BEATRIZ SOUZA RODRIGUES')
aAdd(aUsr,'LIGIA DA SILVA COSTA')
aAdd(aUsr,'HELENA PINTO THOMÉ FILHA')
aAdd(aUsr,'CARMEN MARIA DA CUNHA FERNANDES')
aAdd(aUsr,'SILERI CAVALIERI DOS SANTOS')
aAdd(aUsr,'VANIA MARCULINO DE ALBUQUERQUE')
aAdd(aUsr,'CLAUDIA CARVALHO PINTO DE MENDONCA')
aAdd(aUsr,'VANIA LUCIA FERNANDES BARBOSA')
aAdd(aUsr,'EDGAR ALBERTO DE OLIVEIRA')
aAdd(aUsr,'HELENICE RIBEIRO DA SILVA')
aAdd(aUsr,'LEILA DA SILVEIRA BEZERRA')
aAdd(aUsr,'LUIZ CLAUDIO ALVES SOUZA')
aAdd(aUsr,'MAGALI DE MOURA LEITE')
aAdd(aUsr,'ELIANI SILVA SICILIANO')
aAdd(aUsr,'LUIZ HENRIQUE DA SILVA FERREIRA')
aAdd(aUsr,'ELISABETH MATHIAS DE SOUZA PIRES')
aAdd(aUsr,'SOLANGE DOS SANTOS PACHECO')
aAdd(aUsr,'MARIA LUCIA BELATO')
aAdd(aUsr,'EDSON DA SILVA')
aAdd(aUsr,'LUCIA HELENA BACAL DE VASCONCELOS')
aAdd(aUsr,'JANETE FERNANDES ROCHA')
aAdd(aUsr,'ROSE MARY DOS SANTOS DE MACEDO')
aAdd(aUsr,'CLAUDIA BERCACOLA BARBOSA')
aAdd(aUsr,'THYLDE MYRIAM SOUSA ANDRADE')
aAdd(aUsr,'JOSE HENRIQUE DE MAFRA ALVES')
aAdd(aUsr,'SUZANA TEIXEIRA DE CARVALHO')
aAdd(aUsr,'ANTÔNIA BARBOSA LISBOA')
aAdd(aUsr,'MARIA MERCIA LIMA DE QUEIROZ')
aAdd(aUsr,'TANIA MARIA GARCIA AUGUSTO DE OLIVEIRA')
aAdd(aUsr,'MARLENE LUIZA PEREIRA')
aAdd(aUsr,'ANTONIO CARLOS DUARTE MACHADO')
aAdd(aUsr,'SERGIO AREIAS MARINS')
aAdd(aUsr,'LUIZ CEZAR DE SOUZA')
aAdd(aUsr,'AMELIA ROMUALDO CORTEZ')
aAdd(aUsr,'GILCINARA OLIVEIRA DA CRUZ')
aAdd(aUsr,'DAGMAR DA HORA OLIVEIRA')
aAdd(aUsr,'ELIANA LIMA SOUZA')
aAdd(aUsr,'MARIZE FERREIRA DA SILVA')
aAdd(aUsr,'VANIA RIBEIRO FRAGA')
aAdd(aUsr,'MARCIA SOUZA DE CARVALHO')
aAdd(aUsr,'MARIA REGINA GONCALVES MORAIS')
aAdd(aUsr,'SONIA REGINA DA SILVA RODRIGUES')
aAdd(aUsr,'NANCY DE LIMA SOARES')
aAdd(aUsr,'NAJLA ELIAS FARAGE')
aAdd(aUsr,'SIDNEIA FRANCISCA MANHAES DE SOUZA XAVIER')
aAdd(aUsr,'MARIA LUIZA DANTAS SILVA')
aAdd(aUsr,'JOSE CARLOS GOMES FAGUNDES')
aAdd(aUsr,'MIRIAN SILVA DE SOUZA')
aAdd(aUsr,'SEBASTIANA MARIANA DE OLIVEIRA')
aAdd(aUsr,'MARCIO SOARES DE MENEZES')
aAdd(aUsr,'ANDREA LONTRA MOREIRA')
aAdd(aUsr,'LARISSA ACOSTA DE JESUS')
aAdd(aUsr,'LUCIANE DA COSTA')
aAdd(aUsr,'DENISE RIBEIRO CABRAL')
aAdd(aUsr,'MARIA MATILDE MONTEIRO DE BARROS MATHEUS')
aAdd(aUsr,'ANA MARIA CARVALHO')
aAdd(aUsr,'EMÍLIA SALETE DA SILVEIRA TORNELLI')
aAdd(aUsr,'SANTANA MARIA PAIVA CARVALHO')
aAdd(aUsr,'VANIA LUCIA BASTOS')
aAdd(aUsr,'ANTONIO GUINEBRETIERE DE CARVALHO')
aAdd(aUsr,'AMARA LUCIA PEREIRA LEANDRO')
aAdd(aUsr,'MARIA AMELIA DE MEDEIROS')
aAdd(aUsr,'CIRA UMBELINDA FONSECA')
aAdd(aUsr,'CATARINA ALAIDE DE CASTRO GOMES')
aAdd(aUsr,'DENISE MARIA CARVALHO BARBOZA')
aAdd(aUsr,'JOSELI APARECIDA SILVA')
aAdd(aUsr,'LEILA MARGALHAES FREITAS SILVA')
aAdd(aUsr,'LAINA BARBOZA DE AZEVEDO')
aAdd(aUsr,'DENISE VIEIRA GOMES DE ARAUJO')
aAdd(aUsr,'LAUDELINA SOUZA DANTAS')
aAdd(aUsr,'MARCIA DE JESUS SOARES')
aAdd(aUsr,'LUCIENE GALVAO SANTOS')
aAdd(aUsr,'SONIA REGINA PELLUSO SILVA DE OLIVEIRA')
aAdd(aUsr,'LILIAN MARLI AUSQUIA LEAO')
aAdd(aUsr,'CYNTIA VEIGA RODRIGUES')
aAdd(aUsr,'IGNEZ MENEZES DOS SANTOS')
aAdd(aUsr,'SANDRA SOARES SANTOS')
aAdd(aUsr,'ALBERTO DE SOUZA LIMA')
aAdd(aUsr,'RAIMUNDA SARAIVA RODRIGUES')
aAdd(aUsr,'ALDA DE ALBUQUERQUE BRITTO FONSECA')
aAdd(aUsr,'GRACIADEI FELIPE DE SOUZA')
aAdd(aUsr,'JOSE ROMUALDO DE OLIVEIRA')
aAdd(aUsr,'VALERIA MAURICIO')
aAdd(aUsr,'ANTONIO CARLITO MATOLA')
aAdd(aUsr,'SANDRA LUCIA CAETANO DA FONSECA SILVA')
aAdd(aUsr,'JUSSARA DE OLIVEIRA DE SOUZA')
aAdd(aUsr,'DANIEL FELIPE DE MORAES MARINO')
aAdd(aUsr,'IVANIA VARGAS DE OLIVEIRA')
aAdd(aUsr,'GILSON GONCALVES BRAVO')
aAdd(aUsr,'RENATA DE PAIVA SANTOS')
aAdd(aUsr,'CLAUDIO DOS SANTOS')
aAdd(aUsr,'FRANCISCA MARIA DE CARVALHO GONZAGA E SILVA')
aAdd(aUsr,'DILMA PEREIRA SILVA')
aAdd(aUsr,'SANDRA MARISE TEIXEIRA DA SILVA')
aAdd(aUsr,'PAMMELA LOBO SORIANO LOPES DE OLIVEIRA')
aAdd(aUsr,'CELIA PEREIRA MARTINS LOPES')
aAdd(aUsr,'SANDRA NOGUEIRA PIRES RIBEIRO')
aAdd(aUsr,'JOSE ANTONIO ALVES DA PENHA')
aAdd(aUsr,'MICHELI PAULINO DOS SANTOS')
aAdd(aUsr,'JUCILENE VASCONCELOS GOMES VIEIRA')
aAdd(aUsr,'JOSIANE MALAFAIA DA SILVA')
aAdd(aUsr,'ANA MARCIA MESQUITA CAMPELLO')
aAdd(aUsr,'ZULEIDE HELENA DA SILVA')
aAdd(aUsr,'PATRICIA DAS NEVES LOPES')
aAdd(aUsr,'ANA PAULA ANDRADE SILVA')
aAdd(aUsr,'JOSE AUGUSTO PECANHA DA COSTA')
aAdd(aUsr,'ANA MARIA SOUZA SILVA')
aAdd(aUsr,'ANTONIO CARLOS SIQUEIRA COBUCCI')
aAdd(aUsr,'ANA PAULA SIMOES')
aAdd(aUsr,'BIANCA GERALDINE DUARTE GONCALVES')
aAdd(aUsr,'DAMIAO BEZERRA DE LIMA')
aAdd(aUsr,'MARCELO DA SILVA SANA')
aAdd(aUsr,'ROSANA MENDONCA FERREIRA MUNIZ')
aAdd(aUsr,'STELLA BARRETO SILVA ESTABANEZ')
aAdd(aUsr,'BETHANIA MOTA DA SILVA')
aAdd(aUsr,'LUCIO MAURO DE SOUZA FRANCISCO')
aAdd(aUsr,'ROSILENE DO VALLE BERNARDINO')
aAdd(aUsr,'ANA PAULA VIEIRA XAVIER')
aAdd(aUsr,'BRUNA MARIA CARNEIRO')
aAdd(aUsr,'MONICA GIESBRE4CHT FORMIGA NOGUEIRA CARDOSO')
aAdd(aUsr,'ROSANGELA DA SILVA FERRAZ')
aAdd(aUsr,'JOCINETE NERI DE LIMA')
aAdd(aUsr,'GILDETE DOS SANTOS DE FARIA')
aAdd(aUsr,'GILSON DA SILVA FONSECA')
aAdd(aUsr,'TANIA RIBEIRO DE OLIVEIRA')
aAdd(aUsr,'FLÁVIA REIS DA FONSECA')
aAdd(aUsr,'IVONE MAGNA HENRIQUE TEIXEIRA')
aAdd(aUsr,'NEUSA DULCE FERNANDES ALVES')
aAdd(aUsr,'JAQUELINE MOREIRA DA SILVA')
aAdd(aUsr,'ANA LUCIA MARTINS DA CONCEICAO DE OLIVEIRA')
aAdd(aUsr,'WILSON AGOSTINHO FREITAS')
aAdd(aUsr,'NADJANE PEREIRA DA SILVA')
aAdd(aUsr,'WLAMIR OFREDI MARTINS')
aAdd(aUsr,'HERMINIO DOMINGUES SOBRAL')
aAdd(aUsr,'ELAINE BRITTO RODRIGUES DA SILVA')
aAdd(aUsr,'ERISVALDO PEREIRA DA SILVA')
aAdd(aUsr,'MARIA ELIZABETH FRANCISCONI DOS SANTOS')
aAdd(aUsr,'MONICA DINIZ AMORIM')
aAdd(aUsr,'JADER DA FONSECA SALGADO')
aAdd(aUsr,'PAULA HELEN DE ANDRADE PEREIRA')
aAdd(aUsr,'MONICA CAVALLERO MARQUES DA SILVA')
aAdd(aUsr,'ROSECLER DA SILVA PEREIRA')
aAdd(aUsr,'KARLA CARDOSO DO NASCIMENTO')
aAdd(aUsr,'EDUARDO FALCAO PEQUENO')
aAdd(aUsr,'FRANCISCO CARLOS DIAMANTINO COUTINHO')
aAdd(aUsr,'CARLOS ALBERTO BARROS TAVARES')
aAdd(aUsr,'CLAUDIA MARIA DOS SANTOS FREITAS')
aAdd(aUsr,'TANIA SOUZA KOHLHASE LARANJA')
aAdd(aUsr,'MELISSA LOUREIRO XAVIER SOARES')
aAdd(aUsr,'MIRIAN ALVES PASSOS')
aAdd(aUsr,'JUPIRA ROQUE DA SILVA')
aAdd(aUsr,'ELOISA DA COSTA SILVA')
aAdd(aUsr,'MARIA HELENA BARROS DE SOUZA')
aAdd(aUsr,'REGINA RODRIGUES DOS SANTOS')
aAdd(aUsr,'ELIANA DA SILVA ATHAYDE')
aAdd(aUsr,'DILMA MARTINS DA SILVA')
aAdd(aUsr,'SAMMEA HERICA FERREIRA LEMOS')
aAdd(aUsr,'NEUSA MARIA TEIXEIRA RAMOS')
aAdd(aUsr,'TARCISIO ESTEVES')
aAdd(aUsr,'MARCIA CRISTINA DA SILVA')
aAdd(aUsr,'CATIA CUNHA DO NASCIMENTO DOS SANTOS')
aAdd(aUsr,'ADRIANA ANCELES DE OLIVEIRA BAPTISTA')
aAdd(aUsr,'LILIAN TEIXEIRA RIBEIRO')
aAdd(aUsr,'LUCIA REGINA DE QUEIROGA')
aAdd(aUsr,'ANA LUCIA BATISTA DOS SANTOS')
aAdd(aUsr,'SILVANA FERNANDES DE CARVALHO')
aAdd(aUsr,'JANDYRA DE MIRANDA')
aAdd(aUsr,'MARIA DA PENHA LEITE')
aAdd(aUsr,'DANIELE BARRETO RANGEL')
aAdd(aUsr,'GLORIA VIRGINIA DE MELO BRITES')
aAdd(aUsr,'ELISANGELA DA SILVA CUNHA')
aAdd(aUsr,'CLAUDIA FERNANDES DOS SANTOS')
aAdd(aUsr,'MAILDA RODRIGUES DE AGUIAR')
aAdd(aUsr,'RENATA RUBACK DOS SANTOS')
aAdd(aUsr,'CRISTIANE MONIQUE DE ANDRADE PEREIRA PAIXAO')
aAdd(aUsr,'VAGNER LEANDRO DOS SANTOS')
aAdd(aUsr,'LUIZ CLAUDIO ESPIRITO SANTO DE OLIVEIRA')
aAdd(aUsr,'ALIE LAVALLE DE MENDONCA SILVA')
aAdd(aUsr,'DANIEL LUIS DA SILVA')
aAdd(aUsr,'ANGELA MARIA MENDONCA')
aAdd(aUsr,'LIVIA FERNANDES FONSECA')
aAdd(aUsr,'ANA FLAVIA SOARES SALES DA SILVA')
aAdd(aUsr,'ELEIZO CARDIM DOS SANTOS')
aAdd(aUsr,'THEREZINHA PEREIRA DA SILVA')
aAdd(aUsr,'CARLOS JONEY SOUSA DA SILVA')
aAdd(aUsr,'ELIZABETH GOMES GONCALVES')
aAdd(aUsr,'MOEMA REGINA RAMOS INHAPIM')
aAdd(aUsr,'LAUDICERIA REIS DA SILVA OLIVEIRA')
aAdd(aUsr,'SANDRA LESSA MACHADO')
aAdd(aUsr,'ELISABETE CARDOZO DO NASCIMENTO')
aAdd(aUsr,'ADRIANA DA SILVA JARDIM')
aAdd(aUsr,'ALESSANDRA DO NASCIMENTO')
aAdd(aUsr,'GLAUCO OLIVEIRA DE LIMA')
aAdd(aUsr,'MALENA FARIAS SANT ANNA')
aAdd(aUsr,'ADRIANA DA COSTA DA CRUZ')
aAdd(aUsr,'LEANDRO MENDONCA DO NASCIMENTO')
aAdd(aUsr,'MARCELA ALVES SCHNEIDER')
aAdd(aUsr,'LUCIANA LAURINDO DE SA')
aAdd(aUsr,'EVELYN LUCY ALVES DA LUZ')
aAdd(aUsr,'KARLA MARTINS COSTA')
aAdd(aUsr,'ROSANGELA BEZERRA DOS SANTOS')
aAdd(aUsr,'FERNANDA DOS SANTOS GOMES CARNEIRO')
aAdd(aUsr,'PAULINO JOSE DOS SANTOS JUNIOR')
aAdd(aUsr,'MARCIA VALERIA ALVES DO NASCIMENTO')
aAdd(aUsr,'TERESA CRISTINA BATISTA DA COSTA')
aAdd(aUsr,'CATIA CARDOSO DO NASCIMENTO')
aAdd(aUsr,'LIDIA DE LIMA LACERDA')
aAdd(aUsr,'ANA ROSA MEDINA LOPES')
aAdd(aUsr,'SUELEN DE SOUZA PESSANHA')
aAdd(aUsr,'RICARDO SANTOS DE AZEVEDO')
aAdd(aUsr,'JOAO CARLOS BARREIROS PEREIRA')
aAdd(aUsr,'SILVIO DE CARVALHO BARRETO')
aAdd(aUsr,'THAYS PASSOS DA SILVA')
aAdd(aUsr,'ANA CLAUDIA MEDEIROS FERREIRA CYTRANGULO')
aAdd(aUsr,'ANDRE LUIZ VIANNA BELLO TAVARES DOS REIS')
aAdd(aUsr,'CLAUDIO VILLAS BOAS BRITO')
aAdd(aUsr,'NOEMI TEIXEIRA DA SILVA')
aAdd(aUsr,'MARIA RITA DE CASSIA DE ASSIS MATARAZZO')
aAdd(aUsr,'MARIANA DE SOUZA MARTINS')
aAdd(aUsr,'ALINE PAIXAO MIRANDA')
aAdd(aUsr,'EDUARDO SERRA MONTEIRO DE SOUZA')
aAdd(aUsr,'DIANE MOTA LIMA')
aAdd(aUsr,'VANESSA BEZERRA DE SÁ')
aAdd(aUsr,'RENATA GONZALES TEMER SILVA')
aAdd(aUsr,'RAFAEL DOS ANJOS SILVA')
aAdd(aUsr,'VITOR DE CASTRO DOS SANTOS')
aAdd(aUsr,'ALESSANDRO NOGUEIRA SILVA')
aAdd(aUsr,'SILVANA DA SILVA SALLES')
aAdd(aUsr,'HAMILTON VERISSIMO DA SILVEIRA')
aAdd(aUsr,'MARISA PAIVA DOS SANTOS')
aAdd(aUsr,'VALDECIR RODRIGUES SOBRINHO')
aAdd(aUsr,'WANDERSON DUARTE DO NASCIMENTO')
aAdd(aUsr,'MEYRE SENDRA MARTINS')
aAdd(aUsr,'GISELE DA ROCHA SARDINHA MADEIRA')
aAdd(aUsr,'NEWTON CARLOS DA SILVA SIMOES')
aAdd(aUsr,'LENITA LYRA DOS SANTOS MOTA')
aAdd(aUsr,'WALLACE RODRIGUES CHAMARELLI DE SOUZA')
aAdd(aUsr,'MARCIO ALESSANDRO CICCHELLI DE SOUZA')
aAdd(aUsr,'NATALIA MARQUES DOS SANTOS')
aAdd(aUsr,'DANIEL DA SILVA RODRIGUES DE SOUZA')
aAdd(aUsr,'PRISCILLA BARROS LESSA')
aAdd(aUsr,'RILCILENE VALERIA VITAL RAMOS')
aAdd(aUsr,'RICARDO CARVALHO BARBOSA')
aAdd(aUsr,'ANA CLAUDIA DE LEMOS DOS REIS')
aAdd(aUsr,'WANDERSON DA SILVA LIMA')
aAdd(aUsr,'SONIA CRISTINA SANTORO FABER')
aAdd(aUsr,'DANIELA DA SILVA RODRIGUES')
aAdd(aUsr,'MARENILZA MAIA PINHEIRO')
aAdd(aUsr,'NEIVA CARRARO PONTES')
aAdd(aUsr,'ALESSANDRA PEREIRA DE LIMA')
aAdd(aUsr,'DAIANE PIRES DE ARAÚJO')
aAdd(aUsr,'THYAGO SILVA DE MORAES')
aAdd(aUsr,'ALLAN DOS SANTOS VIEIRA')
aAdd(aUsr,'CARLOS EDUARDO DE ALMEIDA COSTA')
aAdd(aUsr,'ALTAMIRO PACHECO FILHO')
aAdd(aUsr,'MELISSA DOS SANTOS FAGUNDES SOARES')
aAdd(aUsr,'FERNANDA BRAGA ARNAUD')
aAdd(aUsr,'ANNELISE SILVA SANTOS')
aAdd(aUsr,'JORGE JOSE DOS SANTOS')
aAdd(aUsr,'LAURA CORREA DE OLIVEIRA')
aAdd(aUsr,'RODRIGO MARTINS GOMES')
aAdd(aUsr,'GISELLE SOUZA DA SILVA')
aAdd(aUsr,'JULIANA CORREA DA SILVA')
aAdd(aUsr,'CATIA REGINA CAMILO FURTADO SILVEIRA')
aAdd(aUsr,'SILVANA GONCALVES VIANA DE MATOS FLORES')
aAdd(aUsr,'FABRICIO XAVIER DO CARMO')
aAdd(aUsr,'FABIANA LOZANO GAMA')
aAdd(aUsr,'FLAVIA DA SILVA LOURDES')
aAdd(aUsr,'LUCIANE DE MOURA ELIAS VALDUGA')
aAdd(aUsr,'LIVIA GUIMARAES DO NASCIMENTO')
aAdd(aUsr,'CELIA MARIA DOS SANTOS PINHEIRO')
aAdd(aUsr,'FABIO BARBOZA DA SILVA')
aAdd(aUsr,'ADRIANE MAIA DE LIMA')
aAdd(aUsr,'DULCINEIA SANTOS MEDEIROS')
aAdd(aUsr,'SUZANA GOMES MOREIRA DOS SANTOS')
aAdd(aUsr,'GILBERTO COSTA CAMARINHA')
aAdd(aUsr,'JULIO PEREIRA GUIMARAES JUNIOR')
aAdd(aUsr,'EMILIA MARIA DE SOUZA')
aAdd(aUsr,'PAULO DACIO BROCANELLI')
aAdd(aUsr,'ROSANGELA MASCARENHAS DA COSTA MARQUES')
aAdd(aUsr,'LEONARDO MOURA FERNANDES')
aAdd(aUsr,'BARBARA AMADO ANDRE')
aAdd(aUsr,'MAURO MATURANA CARDOSO')
aAdd(aUsr,'MICHELLE MARTINS GALVAO')
aAdd(aUsr,'BRUNA SEGUI DA SILVA')
aAdd(aUsr,'ELAINE CRISTINA DA SILVA GARCIA')
aAdd(aUsr,'CLEBER SOARES DE SOUZA')
aAdd(aUsr,'ANTONIA ALICE DE SOUSA FARIAS')
aAdd(aUsr,'PATRICIA PIZA SANTANA RODRIGUES')
aAdd(aUsr,'VANESSA FRANCA ANTUNES BANDEIRA')
aAdd(aUsr,'ALINE PINHEIRO DOS SANTOS')
aAdd(aUsr,'LUCIANA ROSA CAMPOS')
aAdd(aUsr,'MARCIA OGGIONI TOLEDO')
aAdd(aUsr,'ELLEN DOS SANTOS ABOUD DO NASCIMENTO MATTOS')
aAdd(aUsr,'DEBORAH DA COSTA BARROS')
aAdd(aUsr,'MARIA CRISTINA RIBEIRO BARRETO')
aAdd(aUsr,'ANNE KELLY DA SILVA E SOUZA ROCHA')
aAdd(aUsr,'CARMEN LUCIA SILVA DE CASTRO')
aAdd(aUsr,'ROSIMERE XAVIER MOTTA')
aAdd(aUsr,'TATIANA DA COSTA SILVA')
aAdd(aUsr,'PAULO CESAR DE SOUZA COSTA JUNIOR')
aAdd(aUsr,'DEBORA CRESPO PEREIRA')
aAdd(aUsr,'MARIANGELA HONORATO DE MENDONCA')
aAdd(aUsr,'ELEN SALES MARINELLI FIGUEIRA')
aAdd(aUsr,'RENATA DE MELO CARDOSO PALMARES')
aAdd(aUsr,'HUMBERTO BATISTA DE MACEDO JUNIOR')
aAdd(aUsr,'MICHELLE CRISTIBNA MORAES BARCELLOS COIMBRA')
aAdd(aUsr,'ROBERTO ALFREDO NASCIMENTO')
aAdd(aUsr,'REGILENE GUIMARAES PASCHOAL')
aAdd(aUsr,'GISELE PORTO LAGE')
aAdd(aUsr,'RENATO ALVES DE CARVALHO JUNIOR')
aAdd(aUsr,'LUCIANA DE CARVALHO POLLA')
aAdd(aUsr,'ROSA CLAUDIA DA SILVA MATOS')
aAdd(aUsr,'ALINE PAULA RAMOS PESSANHA')
aAdd(aUsr,'ANDRE LUIS DE OLIVEIRA SANTOS')
aAdd(aUsr,'HERCULES ALVES COUTO')
aAdd(aUsr,'GISELE DOS SANTOS MALTOS')
aAdd(aUsr,'THIAGO JORGE CARDOSO BRAZ')
aAdd(aUsr,'FERNANDO CESARIO FIGUEIREDO DE ARAUJO')
aAdd(aUsr,'ROSA NOGUEIRA')
aAdd(aUsr,'SANDRA REGINA SANTOS DE ALMEIDA')
aAdd(aUsr,'FLAVIA PEREIRA DE BARROS RODRIGUES')
aAdd(aUsr,'MONICA CRISTINA PINTO')
aAdd(aUsr,'ANDREIA GOMES DA SILVA')
aAdd(aUsr,'FABIO HASTENREITER BARCELLOS')
aAdd(aUsr,'SILVANA BAUNER RODRIGUES')
aAdd(aUsr,'RAQUEL DIAS DOS SANTOS DANTAS')
aAdd(aUsr,'TATIANE COSTA DE BARCELOS')
aAdd(aUsr,'ELIZABETH SILVA LEITE')
aAdd(aUsr,'MARIA ELANE DA CONCEICAO')
aAdd(aUsr,'ROBERTA RIBEIRO DE CICCO')
aAdd(aUsr,'ANA CAROLINA ACHINELLES DE OLIVEIRA')
aAdd(aUsr,'BRUNO NUNES FALCAO')
aAdd(aUsr,'FRANCINE AMARAL NOGUEIRA')
aAdd(aUsr,'JESSICA BRUNA DE FREITAS DANTAS DOS SANTOS')
aAdd(aUsr,'KATIA CRISTINA SOUZA DA SILVA')
aAdd(aUsr,'ALESSANDRO DE OLIVEIRA BARBOZA')
aAdd(aUsr,'ERIVALDO MOREIRA DOS SANTOS JUNIOR')
aAdd(aUsr,'JAQUELINE LUZIA DA COSTA DE SOUZA')
aAdd(aUsr,'LILIAN BACELAR FREMEAUX')
aAdd(aUsr,'MARCIA ANDREA SILVA MARTINS')
aAdd(aUsr,'NEIVALDO JOSE DE ANDRADE')
aAdd(aUsr,'PAULO CESAR DE BRITO')
aAdd(aUsr,'ZORAIA TATIM SAUER')
aAdd(aUsr,'DANIEL GONCALVES DOS SANTOS')
aAdd(aUsr,'ROGERIO ANDRE DA SILVA LEITE')
aAdd(aUsr,'VALERIA CARVALHO DE ARAUJO MARTINS')
aAdd(aUsr,'CARLOS AUGUSTO GUIMARAES COUTINHO')
aAdd(aUsr,'JORGE LUIZ DA SILVA')
aAdd(aUsr,'PEDRO LUIZ DA COSTA OLIVEIRA')
aAdd(aUsr,'LUIS CARLOS SERRA DA SILVA')
aAdd(aUsr,'JORGE LUIZ DA COSTA CARVALHO')
aAdd(aUsr,'ELEZIR LISBOA')
aAdd(aUsr,'ROBERTO XAVIER NUNES')
aAdd(aUsr,'DENILSON DOS SANTOS SILVA')
aAdd(aUsr,'ANTONIO LIMA PEREIRA FILHO')
aAdd(aUsr,'NELSON JOSE DE CASTRO')
aAdd(aUsr,'ADELSON GOMES')
aAdd(aUsr,'REYNALDO NILO GOMES')
aAdd(aUsr,'PAULO ROBERTO SOUZA DE OLIVEIRA')
aAdd(aUsr,'CLEVERSON SANTANNA DA COSTA')
aAdd(aUsr,'RICARDO LUIZ DE SOUZA LADEIRA')
aAdd(aUsr,'RONALDO DE FREITAS  GOULART')
aAdd(aUsr,'SEBASTIAO EDUARDO ALVES')
aAdd(aUsr,'LINDOMAR DOS SANTOS DE OLIVEIRA')
aAdd(aUsr,'JOSÉ RICARDO DO NASCIMENTO MOREIRA')
aAdd(aUsr,'MARCELO DE SOUSA')
aAdd(aUsr,'JOSE MARCOS SILVA FEITOSA')
aAdd(aUsr,'REINALDO AUGUSTO DE BARROS')
aAdd(aUsr,'ANDRE LIBERTINO GONCALVES')
aAdd(aUsr,'ALBERTO JOSE DA CUNHA FILHO')
aAdd(aUsr,'ARTUR LUIZ JATAHY DA CRUZ')
aAdd(aUsr,'JOSE LUCIO BARRETO FILHO')
aAdd(aUsr,'ALOYSIO DE JESUS PEIGAS')
aAdd(aUsr,'FRANCISCO JOSE CONTARATO LEANDRO')
aAdd(aUsr,'JOBSON VIANA ALVES')
aAdd(aUsr,'GLAUCIO DA SILVA PEREIRA')
aAdd(aUsr,'GILSON PESSANHA DA SILVA')
aAdd(aUsr,'REINALDO MELLO NUNES')
aAdd(aUsr,'AMÍLTON ELIAS DA SILVA')
aAdd(aUsr,'FRANCISCO CARLOS ALVES DE MORAES')
aAdd(aUsr,'ALEXANDRE DEODATO DE SOUZA MATTOS')
aAdd(aUsr,'PAULO ROBERTO DE JESUS SILVA')
aAdd(aUsr,'JAQUELINE BATISTA MACEDO')
aAdd(aUsr,'CAMILA DE OLIVEIRA TEIXEIRA')
aAdd(aUsr,'ROSIANE GONCALVES MARTINS')
aAdd(aUsr,'JANAINA IGNEZ DE SOUZA ALELUIA')
aAdd(aUsr,'ANDERSOM DE OLIVEIRA CONCEICAO')
aAdd(aUsr,'EDUARDO SOARES DA SILVA')
aAdd(aUsr,'LEANDRO BRANCO DE OLIVEIRA')
aAdd(aUsr,'EDSON SILVA DE SOUZA')
aAdd(aUsr,'JEAN SANTOS MACHADO')
aAdd(aUsr,'MARCO ANTONIO DE ANDRADE SANTIAGO')
aAdd(aUsr,'PAULO ROBERTO BARBOSA')
aAdd(aUsr,'PEDRO HENRIQUE TAVARES DA GAMA')
aAdd(aUsr,'SIDNEI DA SILVA CONCEICAO')
aAdd(aUsr,'ANDRÉA LUÍZA FERREIRA')
aAdd(aUsr,'FABIANO BARROSO ACACIO SILVEIRA')
aAdd(aUsr,'FLAVIO NORBERTO DO CARMO SILVA')
aAdd(aUsr,'DAYANA APARECIDA RODRIGUES LOUZADA')
aAdd(aUsr,'BRUNO DA CONCEICAO')
aAdd(aUsr,'EDLAINE VERCILLO VIANNA')
aAdd(aUsr,'ISAIAS COSTA SIMOES')
aAdd(aUsr,'VANDERSON PEREIRA DOS SANTOS')
aAdd(aUsr,'DOUGLAS DE SA MATOS')
aAdd(aUsr,'ILSON MONTEIRO PORTO')
aAdd(aUsr,'JANAINA ROSALI GANDARA DE MATOS')
aAdd(aUsr,'LARISSA ERNANDEZ JOAQUIM DA SILVA')
aAdd(aUsr,'ALESSANDRO OLIVEIRA ARAUJO')
aAdd(aUsr,'RAFAEL BRUNO DE ALMEIDA')
aAdd(aUsr,'ADALBERTO SILVA DE SOUZA')
aAdd(aUsr,'RODRIGO DA SILVA PACHU')
aAdd(aUsr,'WELLINGTON DA COSTA DE SOUZA')
aAdd(aUsr,'ANTONIO AILTON MARTINS BEZERRA')
aAdd(aUsr,'CARLOS EDUARDO FRANCISCO DA SILVA')
aAdd(aUsr,'LENILSON DA SILVA CARNEIRO')
aAdd(aUsr,'MARCUS VINICIUS DE BELÇO SILVA')
aAdd(aUsr,'ROMILDO VALERIO DA SILVA JUNIOR')
aAdd(aUsr,'WILLIAM OLIVEIRA NICOLAU')
aAdd(aUsr,'DANIEL DA SILVA CORREA')
aAdd(aUsr,'EDIVALDO ALCÂNTARA BARBOSA')
aAdd(aUsr,'FELIPE DA SILVA DOS SANTOS')
aAdd(aUsr,'FRANCISCO WESLEY SOUSA OLIVEIRA')
aAdd(aUsr,'TEREZA CRISTINA VIEIRA LEITE GOMES')
aAdd(aUsr,'NEUZA DA COSTA MARTINS')
aAdd(aUsr,'ZELI DAIM DOS SANTOS')
aAdd(aUsr,'MARIA DE LOURDES BRAZ')
aAdd(aUsr,'EUGENIO FERREIRA DA SILVA')
aAdd(aUsr,'ARLETTE DE BARROS')
aAdd(aUsr,'IZABEL ALVES CRISOSTOMO LEITE DA SILVA')
aAdd(aUsr,'ELISABETE CUNHA SIMOES')
aAdd(aUsr,'CATIA DE SANTANA AMARAL')

Return aUsr