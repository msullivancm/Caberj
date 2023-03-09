#INCLUDE "PROTHEUS.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PLSICAB1  º Autor ³ Mateus Medeiros    º Data ³  18/09/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Ponto de entrada utilizado para acrescentar nova opção Menuº±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function PLSICAB1()
	
	Local aAreaPto := GetArea()
	Local cTipGui := paramixb[1]
	Local cCodOpe := paramixb[2]
	Local cCodLdp := paramixb[3]
	Local cCodPeg := paramixb[4]
	Local cFase   := paramixb[5]
	Local cSituac := paramixb[6]
	Local dDatPro := paramixb[7]
	Local cHora   := paramixb[8]
	Local cMes    := paramixb[9]
	Local cAno    := paramixb[10]
	Local cNumImp := paramixb[11]
	Local cCid    := paramixb[12]
	Local nQtNasV := paramixb[13]
	Local nQtNasM := paramixb[14]
	Local nQtNasP := paramixb[15]
	Local nQtObtP := paramixb[16]
	Local nQtObAR := paramixb[17]
	Local cTipFat := paramixb[18]
	Local cCidObt := paramixb[19]
	Local cNrdCob := paramixb[20]
	Local cObtMul := paramixb[21]
	Local cTipAlt := paramixb[22]
	Local cNrdCnv := paramixb[23]
	Local aDadRDA := paramixb[24]
	Local aCriticas := paramixb[25]
	Local cLotGui := paramixb[26]
	Local cNumLib := paramixb[27]
	Local lHonor  := paramixb[28]
	Local cNumSol := paramixb[29]
	Local cPadCon := paramixb[30]
	Local dDtAlta := paramixb[31]
	Local cHrAlta := paramixb[32]
	Local cEmgest := paramixb[33]
	Local cAborto := paramixb[34]
	Local cTraGra := paramixb[35]
	Local cComurp := paramixb[36]
	Local cAtespa := paramixb[37]
	Local cComnal := paramixb[38]
	Local cBaipes := paramixb[39]
	Local cPaareo := paramixb[40]
	Local cPatnor := paramixb[41]
	Local cArqImp := paramixb[42]
	Local aAreaBD5 := BD5->(GetArea())
	Local aAreaBE4 := BE4->(GetArea())
	
	//PVLRTAGXML(ADADOSUNIC, IIF(CTIPO=='1', '\PROFISSIONALEXECUTANTE\CBOS', IIF(CTIPO='2', '\PROCEDIMENTOSEXECUTADOS\PROCEDIMENTOEXECUTADO\EQUIPESADT', IIF(CTIPO=='3', '\IDENTEQUIPE\IDENTIFICACAOEQUIPE\CBOS', ''))))
	//If cTipGui == "01" .And. dDatPro <> dDataBase // Consulta
	
	/*	dbSelectArea("BD5")
	BD5->(RecLock("BD5",.F.))
	BD5->BD5_DATPRO := dDataBase
	BD5->(msUnlock())*/
	// Mateus Medeiros - 05/12/18
	if !(cTipGui $ "05|06|") 
		// TODAS GUIAS EXCETO INTERNAÇÃO E HONORÁRIOS
		
		/////dbselectarea("BD5")
		BD5->(RecLock("BD5",.F.))
		
		// verifica se a variavel private declarada na BVP existe
		if (TYPE("ADADOS")=="A")
			if aDados[len(adados)][1] # '_ANSTISS_MENSAGEMTISS'
				if cTipGui == "01" // Só verificará se a tag do CBOS executante existe se for GUIA de SADT
					
					nPos	:= ascan(adados,{|x| x[3] == "\MENSAGEMTISS\PRESTADORPARAOPERADORA\LOTEGUIAS\GUIASTISS\GUIACONSULTA\PROFISSIONALEXECUTANTE\" .and. "CBOS" $ x[1]   })
					BD5->BD5_CBOS := IF(TYPE("CCBOS")=="C",CCBOS,'')
					BD5->BD5_XCBOS:= IF(TYPE("CCBOS")=="C",CCBOS,'')
					if nPos > 0
						BD5->BD5_XCBOE:= aDados[nPos][2]
					endif
				elseif cTipGui == "02" // Só verificará se a tag do CBOS executante existe se for GUIA de SADT
					nPosSol	:= ascan(adados,{|x| x[3] == "\MENSAGEMTISS\PRESTADORPARAOPERADORA\LOTEGUIAS\GUIASTISS\GUIASP_SADT\DADOSSOLICITANTE\PROFISSIONALSOLICITANTE\" .and. "CBOS" $ x[1]   })
					nPos	:= ascan(adados,{|x| x[3] == "\MENSAGEMTISS\PRESTADORPARAOPERADORA\LOTEGUIAS\GUIASTISS\GUIASP_SADT\PROCEDIMENTOSEXECUTADOS\PROCEDIMENTOEXECUTADO\EQUIPESADT\" .and. "CBOS" $ x[1]   })
					
					if nPosSol > 0
						BD5->BD5_CBOS := aDados[nPosSol][2]
						BD5->BD5_XCBOS:= aDados[nPosSol][2]
					endif
					
					if nPos > 0
						BD5->BD5_XCBOE:= aDados[nPos][2]
					endif
					
				endif
			endif
		endif
		
		BD5->(msUnlock())
		
	elseif cTipGui == "05" // internação
		
		////dbselectarea("BE4")
		BE4->(RecLock("BE4",.F.))
		BE4->BE4_TIPADM := "0"
		BE4->BE4_YDTSOL := BE4->BE4_DTDIGI
		if (TYPE("ADADOS")=="A")
			if aDados[len(adados)][1] # '_ANSTISS_MENSAGEMTISS'
				//DATA INICIO FATURAMENTO
				nPos	:= ascan(adados,{|x|  "\GUIARESUMOINTERNACAO\DADOSINTERNACAO\" $ x[3]   .and.  "DATAINICIOFATURAMENTO" $ x[1]   })
				if nPos > 0
					BE4->BE4_DTINIF := stod(strtran(aDados[nPos][2],'-',''))
				endif
				
				//HORA INICIO FATURAMENTO
				nPos	:= ascan(adados,{|x|  "\GUIARESUMOINTERNACAO\DADOSINTERNACAO\" $ x[3]   .and.  "HORAINICIOFATURAMENTO" $ x[1]   })
				if nPos > 0
					BE4->BE4_HRINIF := strtran(aDados[nPos][2],':','')
				endif
				
				//DATA FINAL FATURAMENTO
				nPos	:= ascan(adados,{|x|  "\GUIARESUMOINTERNACAO\DADOSINTERNACAO\" $ x[3] .and.  "DATAFINALFATURAMENTO" $ x[1]   })
				if nPos > 0
					BE4->BE4_DTFIMF := stod(strtran(aDados[nPos][2],'-',''))
				endif
				
				//HORA FINAL FATURAMENTO
				nPos	:= ascan(adados,{|x|  "\GUIARESUMOINTERNACAO\DADOSINTERNACAO\" $ x[3] .and.  "HORAFINALFATURAMENTO" $ x[1]   })
				if nPos > 0
					BE4->BE4_HRFIMF := strtran(aDados[nPos][2],':','')
				endif
			endif
		endif
		BE4->(msUnlock())
		
	EndIf
	
	RestArea(aAreaPto)
	RestArea(aAreaBE4)
	RestArea(aAreaBD5)
Return
