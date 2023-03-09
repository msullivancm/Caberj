#INCLUDE 'PROTHEUS.CH'

#DEFINE c_ent CHR(13) + CHR(10)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³RENVCART  ºAutor  ³Angelo Henrique     º Data ³  17/11/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina utilizada para preparar as etiquetas para a gráfica, º±±
±±º          ³gerando assim um arquivo .CSV conforme solicitado.          º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³CABERJ                                                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function RENVCART()
	
	Local cArq 		:= ''
	Local cPath		:= ''
	Local nTipoAj		:= Aviso('Atenção','Deseja processar 1 arquivo ou todos os arquivos do diretório?',{'1 arquivo','Diretório','Cancelar'})
	Local nI			:= 0
	Local nCount		:= 0
	
	Private aFiles	:= {}
	Private aSizes	:= {}
	
	If nTipoAj == 1
		
		cArq :=  cGetFile( '*.txt' , 'Textos (TXT)', 1, 'C:\', .T., GETF_LOCALHARD)
		
		If !empty(cArq)
			Processa({||RenvCart1(cArq)},'Ajuste Renovação Carteirinha ','Processando...',.F.)
		Else
			MsgStop('Informe um arquivo!',AllTrim(SM0->M0_NOMECOM))
		EndIf
		
	ElseIf nTipoAj == 2
		
		cPath :=  cGetFile( '*.txt' , 'Textos (TXT)', 1, 'C:\', .F., nOR( GETF_LOCALHARD, GETF_LOCALFLOPPY, GETF_RETDIRECTORY ),.T.,.T.)
		
		nCount 	:= aDir(AllTrim(cPath) + "*.txt", aFiles, aSizes)
		
		For nI := 1 to nCount
			cArq := cPath + aFiles[nI]
			Processa({||RenvCart1(cArq,.T.)},'Ajuste Renovação Carteirinha','Processando...',.F.)
		Next
		
	Else
		MsgStop('Operação cancelada',AllTrim(SM0->M0_NOMECOM))
	EndIf
	
Return

******************************************************************************************************************

Static Function RenvCart1(cArqPref,lDiretorio)
	
	Local cLine		:= ''
	Local aLine		:= {}
	Local nQtd 		:= 0
	Local nI			:= 0
	Local nPosDiv		:= RAt('\',cArqPref)
	Local cNomArq 	:= Substr(cArqPref,nPosDiv+1,Len(cArqPref)-nPosDiv)
	Local cNovoNome	:= Stuff(cNomArq,At('.',cNomArq),At('.',cNomArq),".csv")
	Local cPathArq 	:= Left(cArqPref,nPosDiv)
	Local nHandle 	:= FT_FUse(cArqPref)
	Local nHdl			:= 0
	Local aCabec		:= {}
	Local cMsg			:= ''
	Local aNewArq		:= {}
	Local cBuffer		:= ''
	Local nLinOri		:= 0
	Local cNewLine	:= ""
	Local _cMatLt		:= ""
	Local _nb			:= 0
	Local cTot			:= ""
	Local _cAliasQry	:= GetNextAlias()
	Local _cQuery		:= ""
	Local _cNome 		:= ""
	Local _cEnde 		:= ""
	Local _cNrEd		:= ""
	Local _cComd		:= ""
	Local _cBair		:= ""
	Local _cMunc		:= ""
	Local _cEsta		:= ""
	Local _cCep		:= ""
	
	Default lDiretorio := .F.
	
	cMsg := 'Esta rotina irá gerar o arquivo de carteiras em Excel para serem enviados a grafica.'			+ CRLF
	cMsg += '- O novo arquivo será gerado na mesma pasta onde estiver o arquivo original ' 					+ CRLF
	cMsg += '  com o nome do original porém com a extensão mudada para .csv           ' 					+ CRLF
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
			
			For _nb := 1 to Len(aLine)
				
				_cMatLt := Replace(Replace(aLine[_nb],".",""),"-","")
				
				If Len(_cMatLt) >= 14
					
					If !Empty(AllTrim(_cMatLt))
						
						DbSelectArea("BA1")
						DbSetOrder(2)
						If DbSeek(xFilial("BA1") + _cMatLt)
							
							cLine := _cMatLt
							
							Exit
							
						EndIf
						
					EndIf
					
				EndIf
				
			Next _nb
			
			If !Empty(AllTrim(cLine))
				
				//------------------------------------------------------
				//Conforme solicitado, só poderá imprimir as etiquetas
				//dos títulares, pois as carteiras dos dependentes
				//seguiram para o mesmo endereço
				//------------------------------------------------------
				DbSelectArea("BA1")
				DbSetOrder(2)
				If DbSeek(xFilial("BA1") + cLine)										
					
					If AllTrim(UPPER(BA1->BA1_TIPUSU)) = "T" //Títular
						
						_cNome := BA1->BA1_NOMUSR
						_cEnde := BA1->BA1_ENDERE
						_cNrEd	:= BA1->BA1_NR_END
						_cComd	:= BA1->BA1_COMEND
						_cBair	:= BA1->BA1_BAIRRO
						_cMunc	:= BA1->BA1_MUNICI
						_cEsta	:= BA1->BA1_ESTADO
						_cCep	:= BA1->BA1_CEPUSR
						
						cNewLine := "Matricula: " + AllTrim(cLine) + ";"
						cNewLine += AllTrim(_cNome) + ";"
						cNewLine += AllTrim(_cEnde) + " " + AllTrim(_cNrEd) + " " + AllTrim(_cComd) + ";"
						cNewLine += AllTrim(_cBair) + ";"
						cNewLine += AllTrim(_cMunc) + "-" + AllTrim(_cEsta) + ";"
						cNewLine += "CEP:" + AllTrim(_cCep) + ";"
						
						cNewLine := '"' + cNewLine + '"'
						
						aAdd(aNewArq,cNewLine)
						
					/*Else
						
						//-------------------------------------------------------------------------------------
						//Caso seja dependente com plano diferente de títular, deve imprimir a etiqueta
						//pois o títular saiu em outro lote, gerando assim a etiqueta separado
						//-------------------------------------------------------------------------------------
						
						_cQuery := "SELECT BA1_CODPLA, BA1_ENDERE, BA1_NR_END, "			+ c_ent
						_cQuery += "BA1_COMEND, BA1_BAIRRO, BA1_MUNICI, "					+ c_ent
						_cQuery += "BA1_ESTADO, BA1_CEPUSR, BA1_NOMUSR "						+ c_ent
						_cQuery += "FROM " + RetSqlName('BA1') + " BA1 " 					+ c_ent
						_cQuery += "WHERE D_E_L_E_T_ = ' '" 									+ c_ent
						_cQuery += "		AND BA1_FILIAL = '" + xFilial('BA1')  + "'"		+ c_ent
						_cQuery += "		AND BA1_CODINT = '" + BA1->BA1_CODINT + "'"  		+ c_ent
						_cQuery += "		AND BA1_CODEMP = '" + BA1->BA1_CODEMP	+ "'" 		+ c_ent
						_cQuery += "		AND BA1_MATRIC = '" + BA1->BA1_MATRIC	+ "'" 		+ c_ent
						_cQuery += "		AND BA1_TIPUSU = 'T'" 								+ c_ent
						
						If Select(_cAliasQry) > 0
							dbSelectArea(_cAliasQry)
							dbCloseArea()
						EndIf
						
						dbUseArea(.T.,"TOPCONN",TcGenQry(,,_cQuery),_cAliasQry,.T.,.T.)
						
						//----------------------------------------------------
						//Caso não ache este opcional no nivel do usuário
						//será zerada a linha, assim não gerando incorreto.
						//----------------------------------------------------
						If !(_cAliasQry)->(Eof())
							
							//If (_cAliasQry)->BA1_CODPLA != BA1->BA1_CODPLA
							
							If (_cAliasQry)->BA1_NOMUSR != _cNome
								
								_cEnde := (_cAliasQry)->BA1_ENDERE
								_cNrEd	:= (_cAliasQry)->BA1_NR_END
								_cComd	:= (_cAliasQry)->BA1_COMEND
								_cBair	:= (_cAliasQry)->BA1_BAIRRO
								_cMunc	:= (_cAliasQry)->BA1_MUNICI
								_cEsta	:= (_cAliasQry)->BA1_ESTADO
								_cCep	:= (_cAliasQry)->BA1_CEPUSR
								_cNome := (_cAliasQry)->BA1_NOMUSR
								
								cNewLine := "Matricula: " + AllTrim(cLine) 	+ ";"
								cNewLine += AllTrim(_cNome) + ";"
								cNewLine += AllTrim(_cEnde) + " " + AllTrim(_cNrEd) + " " + AllTrim(_cComd) + ";"
								cNewLine += AllTrim(_cBair) + ";"
								cNewLine += AllTrim(_cMunc) + "-" + AllTrim(_cEsta) + ";"
								cNewLine += "CEP:" + AllTrim(_cCep) + ";"
								
								cNewLine := '"' + cNewLine + '"'
								
								aAdd(aNewArq,cNewLine)
								
							EndIf
							
						EndIf
						
						If Select(_cAliasQry) > 0
							dbSelectArea(_cAliasQry)
							dbCloseArea()
						EndIf
						*/
					EndIf
					
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
			cMsg := 'Ajuste de carteirinhas para grafica finalizado!' 					+ CRLF
			cMsg += '- Arquivo [ ' + cPathArq + cNovoNome + ' ] gerado.' 				+ CRLF
			
			MsgAlert(cMsg,AllTrim(SM0->M0_NOMECOM))
		Else
			MsgStop('Ocorreu algum erro na criação do arquivo [ ' + cPathArq + cNovoNome + ' ]. Verifique...',AllTrim(SM0->M0_NOMECOM))
		EndIf
		
	Else
		MsgAlert('Operação cancelada',AllTrim(SM0->M0_NOMECOM))
	EndIf
	
Return
