#include "PROTHEUS.CH"

User Function PL130VLR

Local cOper		:= paramixb[1]
Local cEmpIni	:= paramixb[2]
Local cEmpFim	:= paramixb[3]
Local cMatIni	:= paramixb[4]
Local cMatFim	:= paramixb[5]
Local dDatIni	:= paramixb[6]
Local dDatFim	:= paramixb[7]
Local cTipPla	:= paramixb[8]
Local dTipPla   := paramixb[9]
Local cGruBen   := paramixb[10]
Local dGruBen   := paramixb[11]
Local cEmpIntS  := paramixb[12]
Local nIndiceE  := paramixb[13]
Local aSipExp   := {}
Local cSql		:= ""
Local cAIni  	:= cAnoIni
Local cMIni  	:= cMesIni
Local cAFim  	:= cAnoFim
Local cMFim  	:= cMesFim
Local cTipUsu	:= ""
Local nPos,nPosaSip:= 0
Local nLBr8		:= 1
Local sClaSip	:= ''
Local sCodEsp	:= ''
Local nPosaCri,nI  := 0
Local aProcSip	 := {}
Local aRecA3	 := {}
Local nPosA3	 := 0
Local aRecInt	 := {}
Local nPosInt	 := 0
LOcal cEmpAtu 	 := SM0->M0_CODIGO
Local lBE4		 := .F.
Local lA3		 := .T.
Private aI130vlr := {}

If cGruBen = "1"
	cTipUsu:= '0'
ElseIf cGruBen = "2"
	cTipUsu:= '2'
ElseIf cGruBen = "3"
	cTipUsu:= '1'
EndIf

//Item Consultas
aadd(aSipExp,{"1.1",0,0,0,1})
//Exames Complementares
aadd(aSipExp,{"1.2",0,0,0,0})  
//Angiografia
aadd(aSipExp,{"1.2.1.1",0,0,0,0})
//Hemodinamica
aadd(aSipExp,{"1.2.1.2",0,0,0,0})
//Ressonancia nuclear
aadd(aSipExp,{"1.2.1.3",0,0,0,0})
//Tomografia computadorizada
aadd(aSipExp,{"1.2.1.4",0,0,0,0})
//Demais exames             
aadd(aSipExp,{"1.2.2",0,0,0,31})
//Terapias
aadd(aSipExp,{"1.3",0,0,0,0})
//Hemoterapia
aadd(aSipExp,{"1.3.1.1",0,0,0,0})
//Litotripsia
aadd(aSipExp,{"1.3.1.2",0,0,0,0})
//Quimioterapia
aadd(aSipExp,{"1.3.1.3",0,0,0,0})
//Radiologia
aadd(aSipExp,{"1.3.1.4",0,0,0,0})
//Radioterapia
aadd(aSipExp,{"1.3.1.5",0,0,0,0})
//Terapia renal
aadd(aSipExp,{"1.3.1.6",0,0,0,0})
//Demais terapias
aadd(aSipExp,{"1.3.2",0,0,0,33})
//Internacoes
aadd(aSipExp,{"1.4",0,0,0,0})  
//Internacoes com menos de 24 hs
aadd(aSipExp,{"1.4.1",0,0,0,0})  
//Internacoes com 24 hs ou mais
aadd(aSipExp,{"1.4.2",0,0,0,0})  
//Outros Atend Ambulat
aadd(aSipExp,{"1.5",0,0,0,6})      
//Demais despesas assistenciais
aadd(aSipExp,{"1.6",0,0,0,7}) 

BD6->(DbSetOrder(1))    

If cEmpAtu = '01'
	//QUERY PROCEDURE SIGA.CR_PLS_CUSTO_POR_EVENTO_NOVO relativo aos atendimentos Protheus
	cSql := "SELECT BD7F.BD7_CODOPE CODOPE, BD7F.BD7_CODLDP CODLDP, BD7F.BD7_CODPEG CODPEG, BD7F.BD7_NUMERO NUMERO,BD7F.BD7_SEQUEN SEQUEN,BD7F.BD7_CODPAD CODPAD,BD7F.BD7_CODPRO CODPRO,"+CRLF 
	cSql += "RETORNA_EVENTO_BD5(BD6_OPEUSR,BD6_CODLDP, BD6_CODPEG,BD6_NUMERO,BD6_ORIMOV,BD6_CODPAD,BD6_CODPRO,BD6_MATVID,'"+IIf(cEmpAtu = "01","C","I")+"' ) CODEVENTO,"+CRLF 
	cSql += "SUM(BD7F.BD6_QTDPRO) QTDE,"+CRLF 
	cSql += "SUM(BD7F.VLRPAG)  VLRPAG,"+CRLF 
	cSql += "SUM(DECODE(BD6F.BD6_BLOCPA,'1',0,DECODE(SIGN(BD6F.BD6_VLRTPF),-1,0,DECODE(BD6F.BD6_CODEMP,'0004',0,BD6F.BD6_VLRTPF)))) VLRPF "+CRLF 
	cSql += "FROM    ("+CRLF 
	cSql += "SELECT  BD7.BD7_FILIAL,BD7_CODPLA,SIGA_TIPO_EXPOSICAO_ANS(BD7_CODEMP,BD7_MATRIC,BD7_TIPREG,sysdate) EXPOS,"+CRLF 
	cSql += "BD7.BD7_OPELOT,BD7.BD7_NUMLOT,"+CRLF 
	cSql += "BD7.BD7_CODRDA, BD7.BD7_CODOPE, BD7.BD7_CODLDP, BD7.BD7_CODPEG, BD7.BD7_NUMERO, BD7.BD7_ORIMOV, BD7_CODPAD,BD7_CODPRO,"+CRLF 
	cSql += "BD7.BD7_SEQUEN, BD6.BD6_QTDPRO, Sum(BD7.BD7_VLRPAG) AS VLRPAG,"+CRLF 
	cSql += "COUNT(DISTINCT BD7_CODEMP||BD7_MATRIC||BD7_TIPREG) QTDE "+CRLF 
	cSql += "FROM    "+RetSqlName("BD7")+" BD7, "+RetSqlName("BAU")+" BAU, "+RetSqlName("BD6")+" BD6 "+CRLF 
	If  alltrim(cTipPla) <> "1"  // Tipo Plano = Coletivo
		cSql += ", "+RetSqlName("BQC")+" BQC "+CRLF 
	Endif
	cSql += "WHERE BD7.BD7_FILIAL='"+xFilial("BD7")+"' "+CRLF 
	cSql += "AND BD7.BD7_CODOPE = '"+cOper+"' "+CRLF 
	cSql += "AND BD7.BD7_SITUAC = '1' "+CRLF 
	cSql += "AND BD7.BD7_FASE = '4' "+CRLF 
	cSql += "AND BD7.BD7_BLOPAG <> '1' "+CRLF 
	cSql += "AND SIGA_TIPO_EXPOSICAO_ANS(BD7_CODEMP,BD7_MATRIC,BD7_TIPREG,sysdate) = "+cTipUsu+" "+CRLF 
	cSql += "AND BD7.D_E_L_E_T_ = ' ' "+CRLF 
	cSql += "AND BAU_FILIAL = '"+xFilial("BAU")+"' "+CRLF 
	cSql += "AND BAU.BAU_CODIGO = BD7.BD7_CODRDA "+CRLF 
	cSql += "AND BAU.D_E_L_E_T_ = ' ' "+CRLF 
	cSql += "AND BD6.BD6_FILIAL = '  ' "+CRLF 
	cSql += "AND BD6.BD6_CODOPE = BD7.BD7_CODOPE "+CRLF 
	cSql += "AND BD6.BD6_CODLDP = BD7.BD7_CODLDP "+CRLF 
	cSql += "AND BD6.BD6_CODPEG = BD7.BD7_CODPEG "+CRLF 
	cSql += "AND BD6.BD6_NUMERO = BD7.BD7_NUMERO "+CRLF 
	cSql += "AND BD6.BD6_ORIMOV = BD7.BD7_ORIMOV "+CRLF 
	cSql += "AND BD6.BD6_SEQUEN = BD7.BD7_SEQUEN "+CRLF 
	cSql += "AND BD6.BD6_CODPRO = BD7.BD7_CODPRO "+CRLF 
	cSql += "AND BD6.BD6_CODPAD<>'06' AND "+CRLF 
	If cEmpIni <> '    ' .and. Upper(cEmpFim) <> 'ZZZZ'  
		cSql += " BD6.BD6_OPEUSR =  '" + cOper   + "'  AND "+CRLF 
		cSql += "BD6.BD6_CODEMP >= '" + cEmpIni   + "' AND "+CRLF 
		cSql += "BD6.BD6_MATRIC >= '" + cMatIni   + "' AND "+CRLF 
		cSql += "BD6.BD6_CODEMP <= '" + cEmpFim   + "' AND "+CRLF 
		cSql += "BD6.BD6_MATRIC <= '" + cMatFim   + "' AND "+CRLF 
	Endif
	If !empty(cEmpIntS)
		cSql += " BD6.BD6_CODEMP NOT IN ("+cEmpIntS+") AND"+CRLF 
	Endif
	cSql += " BD6.D_E_L_E_T_ = ' ' "+CRLF 
	If  alltrim(cTipPla) <> "1" // Tipo Plano = Coletivo
		cSql += " AND BQC.BQC_FILIAL = '"+xFilial("BQC")+"' AND "+CRLF 	
		cSql += " BQC.BQC_CODIGO = BD6.BD6_OPEUSR||BD6.BD6_CODEMP AND "+CRLF 
		cSql += " BQC.BQC_NUMCON = BD6.BD6_CONEMP AND "+CRLF 
		cSql += " BQC.BQC_VERCON = BD6.BD6_VERCON AND "+CRLF  
		cSql += " BQC.BQC_SUBCON = BD6.BD6_SUBCON AND "+CRLF 
		cSql += " BQC.BQC_VERSUB = BD6.BD6_VERSUB AND "+CRLF 
		If  alltrim(cTipPla) == "2" // Tipo Plano = Coletivo sem patrocinador
			cSql += " BQC.BQC_PATROC <> '1' AND "+CRLF  // sem patrocinador
		Else
			cSql += " BQC.BQC_PATROC = '1' AND "+CRLF // com patrocinador
		Endif
		cSql += " BQC.D_E_L_E_T_ = ' ' "+CRLF 
	Else
		cSql += " AND BD6.BD6_CONEMP = ' ' AND"+CRLF  
		cSql += " BD6.BD6_VERCON = ' ' AND"+CRLF  
		cSql += " BD6.BD6_SUBCON = ' 'AND"+CRLF 
		cSql += " BD6.BD6_VERSUB = ' '"+CRLF 
	Endif
	cSql += "GROUP BY BD7.BD7_FILIAL,BD7_CODPLA,SIGA_TIPO_EXPOSICAO_ANS(BD7_CODEMP,BD7_MATRIC,BD7_TIPREG,sysdate),"+CRLF 
	cSql += "BD7.BD7_OPELOT,BD7.BD7_NUMLOT,"+CRLF 
	cSql += "BD7.BD7_CODRDA, BD7.BD7_CODOPE, BD7.BD7_CODLDP, BD7.BD7_CODPEG, BD7.BD7_NUMERO, BD7.BD7_ORIMOV, BD7_CODPAD,BD7_CODPRO,"+CRLF 
	cSql += "BD7.BD7_SEQUEN, BD6.BD6_QTDPRO "+CRLF 
	cSql += ") BD7F, "+RetSqlName("BD6")+" BD6F,"+RetSqlName("BR8")+" BR8, "+RetSqlName("BI3")+" BI3, "+RetSqlName("ZZT")+" ZZT "+CRLF 
	cSql += "WHERE   ZZT_FILIAL='"+xFilial("ZZT")+"' "+CRLF 
	cSql += "AND ZZT.D_E_L_E_T_ = ' ' "+CRLF 
	cSql += "AND BR8.BR8_FILIAL='"+xFilial("BR8")+"' "+CRLF 
	cSql += "AND BR8.BR8_FILIAL=BD6_FILIAL "+CRLF 
	cSql += "AND BR8.BR8_CODPAD=BD6_CODPAD "+CRLF 
	cSql += "AND BR8.BR8_CODPSA=BD6_CODPRO "+CRLF 
	cSql += "AND BR8.D_E_L_E_T_ = ' ' "+CRLF 
	cSql += "AND BI3.BI3_FILIAL='"+xFilial("BR8")+"' "+CRLF 
	cSql += "AND BI3_FILIAL =BD7_FILIAL "+CRLF 
	cSql += "AND BI3_CODINT=BD7_CODOPE "+CRLF 
	cSql += "AND BI3_CODIGO=BD7_CODPLA "+CRLF 
	cSql += "AND BI3.D_E_L_E_T_ = ' ' "+CRLF 
	cSql += "AND BD6F.BD6_FILIAL='"+xFilial("BD6")+"' "+CRLF 
	cSql += "AND RETORNA_EVENTO_BD5 (BD6_OPEUSR,BD6_CODLDP, BD6_CODPEG,BD6_NUMERO,BD6_ORIMOV,BD6_CODPAD,BD6_CODPRO,BD6_MATVID,'"+IIf(cEmpAtu = "01","C","I")+"' )=ZZT_CODEV "+CRLF 
	cSql += "AND BD6F.D_E_L_E_T_ = ' ' "+CRLF 
	cSql += "AND BD7F.BD7_NUMLOT LIKE '"+cAIni+cMIni+"%' "+CRLF 
	cSql += "AND BD6F.BD6_NUMLOT LIKE '"+cAIni+cMIni+"%' "+CRLF 
	cSql += "AND BD7F.BD7_FILIAL = BD6F.BD6_FILIAL "+CRLF 
	cSql += "AND BD7F.BD7_CODOPE = BD6F.BD6_CODOPE "+CRLF 
	cSql += "AND BD7F.BD7_CODLDP = BD6F.BD6_CODLDP "+CRLF 
	cSql += "AND BD7F.BD7_CODPEG = BD6F.BD6_CODPEG "+CRLF 
	cSql += "AND BD7F.BD7_NUMERO = BD6F.BD6_NUMERO "+CRLF 
	cSql += "AND BD7F.BD7_ORIMOV = BD6F.BD6_ORIMOV "+CRLF 
	cSql += "AND BD7F.BD7_SEQUEN = BD6F.BD6_SEQUEN "+CRLF 
	cSql += "AND BD7F.BD7_CODPRO = BD6F.BD6_CODPRO "+CRLF 
	cSql += "GROUP BY    BD7F.BD7_CODOPE, BD7F.BD7_CODLDP, BD7F.BD7_CODPEG, BD7F.BD7_NUMERO,BD7F.BD7_SEQUEN,BD7F.BD7_CODPAD,BD7F.BD7_CODPRO, "+CRLF 
	cSql += "RETORNA_EVENTO_BD5(BD6_OPEUSR,BD6_CODLDP, BD6_CODPEG,BD6_NUMERO,BD6_ORIMOV,BD6_CODPAD,BD6_CODPRO,BD6_MATVID,'"+IIf(cEmpAtu = "01","C","I")+"' ) "+CRLF 
	
	If nLogDad = 2
		PlsLogFil("QUERY PROCEDURE SIGA.CR_PLS_CUSTO_POR_EVENTO_NOVO relativo aos atendimentos Protheus","QUERY_PL130VLR.SIP")
		PlsLogFil(cEmpAtu+"/"+cTipPla+"/"+cGruBen,"QUERY_PL130VLR.SIP")
		PlsLogFil(cSql,"QUERY_PL130VLR.SIP")						
		PlsLogFil("","QUERY_PL130VLR.SIP")
	EndIf
	                                        
	PLSQuery(cSql,"PEQRY")
	
	BarGauge2Set(PEQRY->(RecCount()))
	
	BE4->(DbSetOrder(1))
	
	While !PEQRY->(EoF())
		If nLogDad = 2
			cLogDad := PEQRY->CODOPE+";"
			cLogDad += PEQRY->CODLDP+";"
			cLogDad += PEQRY->CODPEG+";"
			cLogDad += PEQRY->NUMERO+";"
			cLogDad += StrZero(PEQRY->QTDE,3)+";"
			cLogDad += Str(PEQRY->VLRPAG,17,2)+";"			
			cLogDad += Str(PEQRY->VLRPF,17,2)+";"			
			cLogDad += Str(PEQRY->CODEVENTO,3)+";"
		    cLogDad += IIf(cTipPla = "1","IND",IIF(cTipPla = "2","CSP",IIF(cTipPla = "3","CCP","   ")))+";"				   
			cLogDad += IIf(cGruBen = "1","EXP",IIF(cGruBen = "2","ENB",IIF(cGruBen = "3","BNE","   ")))+";"			
			PlsLogFil(cLogDad,"AII_PL130VLR_QRY_CUSTO.SIP")					
		EndIf
		IncProcG2("PL130VLR-Acumulando valores para o procedimento: " + PEQRY->CODPRO)
		nPos := Ascan(aSipExp,{|x| x[5] = PEQRY->CODEVENTO })
		
		If nPos > 0
			aSipExp[nPos,2] += PEQRY->QTDE
			aSipExp[nPos,3] += PEQRY->VLRPAG
			aSipExp[nPos,4] += PEQRY->VLRPF
		Else
			nPosaSip := aScan(aSip,{|x| AllTrim(x[iCodPsa]) == AllTrim(PEQRY->CODPRO) })
			If nPosaSip > 0
				cCdSIP	 := AllTrim(aSip[nPosaSip,iCodigo])
			Else
				cCdSIP	 := ""
			EndIf
	 
			Do Case
				Case nPosaSip > 0 .and. !Empty(cCdSIP) .and. PEQRY->CODEVENTO == 1  .and. cCdSIP = '1.1'
					nPos := aScan(aSipExp,{|x| AllTrim(x[1]) == cCdSIP }) 
				Case nPosaSip > 0 .and. !Empty(cCdSIP) .and. PEQRY->CODEVENTO == 6  .and. cCdSIP = '1.5'
					nPos := aScan(aSipExp,{|x| AllTrim(x[1]) == cCdSIP }) 
				Case nPosaSip > 0 .and. !Empty(cCdSIP) .and. PEQRY->CODEVENTO == 7  .and. cCdSIP = '1.6'
					nPos := aScan(aSipExp,{|x| AllTrim(x[1]) == cCdSIP }) 
				Case nPosaSip > 0 .and. !Empty(cCdSIP) .and. PEQRY->CODEVENTO == 30 .and. SubStr(cCdSIP,1,5) = '1.2.1' 
					nPos := aScan(aSipExp,{|x| AllTrim(x[1]) == cCdSIP }) 
				Case nPosaSip > 0 .and. !Empty(cCdSIP) .and. PEQRY->CODEVENTO == 31 .and. SubStr(cCdSIP,1,5) = '1.2.2' 
					nPos := aScan(aSipExp,{|x| AllTrim(x[1]) == cCdSIP }) 
				Case nPosaSip > 0 .and. !Empty(cCdSIP) .and. PEQRY->CODEVENTO == 32 .and. SubStr(cCdSIP,1,5) = '1.3.1'
					nPos := aScan(aSipExp,{|x| AllTrim(x[1]) == cCdSIP }) 		
				Case nPosaSip > 0 .and. !Empty(cCdSIP) .and. PEQRY->CODEVENTO == 33 .and. SubStr(cCdSIP,1,5) = '1.3.2'
					nPos := aScan(aSipExp,{|x| AllTrim(x[1]) == cCdSIP }) 
				Case PEQRY->CODEVENTO >= 34
					If BE4->(msSeek(xFilial("BE4")+PEQRY->(CODOPE+CODLDP+CODPEG+NUMERO)))
						If 	!Empty(BE4->BE4_DTALTA) .AND.;
							(BE4->BE4_DTALTA = BE4->BE4_DATPRO  .OR.;
				   			(BE4->BE4_DTALTA = (BE4->BE4_DATPRO+1) .AND. BE4->BE4_HRALTA < BE4->BE4_HORPRO))
						
							cCdSIP := "1.4.1"
						Else
							cCdSIP := "1.4.2"
						EndIf 
						lBE4 := .T.
					Else
						cCdSIP := "1.4.2"
						lBE4 := .F.
					EndIf
					nPos := aScan(aSipExp,{|x| AllTrim(x[1]) == cCdSIP })
				OtherWise
					nPos := aScan(aSipExp,{|x| AllTrim(x[1]) == "1.5" })
			Endcase
			If PEQRY->CODEVENTO >= 34 .AND. SubStr(cCdSIP,1,3) = "1.4" .and. lBE4
				nPosInt := Ascan(aRecInt,{|x| x[1] = PEQRY->(CODOPE+CODLDP+CODPEG+NUMERO) })
				If nPosInt = 0 
					aadd(aRecInt,{PEQRY->(CODOPE+CODLDP+CODPEG+NUMERO) })
					aSipExp[nPos,2] ++
				EndIf
			Else
				If PEQRY->CODPAD <> '05' .and. SubStr(cCdSIP,1,3) <> "1.4"
					aSipExp[nPos,2] += PEQRY->QTDE					
				Endif
			EndIf
			aSipExp[nPos,3] += PEQRY->VLRPAG
			aSipExp[nPos,4] += PEQRY->VLRPF								
		EndIf		
		if nLogDad = 2		
			cLogDad := PEQRY->CODOPE+";"
			cLogDad += PEQRY->CODLDP+";"
			cLogDad += PEQRY->CODPEG+";"
			cLogDad += PEQRY->NUMERO+";"
			cLogDad += IIF(nPosInt = 0,IIF(PEQRY->CODPAD <> '05' .and. SubStr(aSipExp[nPos,1],1,3) <> "1.4",StrZero(PEQRY->QTDE,3),"000"),"001")+";"
			cLogDad += Str(PEQRY->VLRPAG,17,2)+";"			
			cLogDad += Str(PEQRY->VLRPF,17,2)+";"			
			cLogDad += aSipExp[nPos,1]+";"		    	    			    
			cLogDad += Str(PEQRY->CODEVENTO,3)+";"
			cLogDad += PEQRY->CODPRO+";"
		    cLogDad += IIf(cTipPla = "1","IND",IIF(cTipPla = "2","CSP",IIF(cTipPla = "3","CCP","   ")))+";"				   
			cLogDad += IIf(cGruBen = "1","EXP",IIF(cGruBen = "2","ENB",IIF(cGruBen = "3","BNE","   ")))+";"			
			PlsLogFil(cLogDad,"AII_PL130VLR_ENQ_SIP.SIP")					
		EndIf
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Acumula valores para o Anexo 3, somente qdo Grupo de Beneficiarios for  ³
		//³	1-Beneficiarios expostos                  								³
		//³	2-Expostos nao beneficiarios                  							³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		nPosA3 := Ascan(aRecA3,{|x| x[1] = PEQRY->(CODOPE+CODLDP+CODPEG+NUMERO+SEQUEN) })
		If nPosA3 = 0
			aadd(aRecA3,{PEQRY->(CODOPE+CODLDP+CODPEG+NUMERO+SEQUEN) })
			lA3 := .T.
		Else
			lA3 := .F.
		EndIf
		
		If (cGruBen == "1"  .or. cGruBen == "2") .and. lA3 .and. PEQRY->CODEVENTO < 34
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Posiciona o BR8 de acordo com o Procedimento			   ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If  aProcBR8[nLBr8,2] <> AllTrim(PEQRY->CODPRO)           
				nLBr8 := aScan(aProcBR8,{ |x| AllTrim(x[2]) == AllTrim(PEQRY->CODPRO) })
				If  nLBr8 <> 0
					cClaSip := aProcBR8[nLBr8,4]
				Else
					cClaSip := ""
					nLBr8	:= 1
		   		Endif
			Else
				If  nLBr8 <> 0
					cClaSip := aProcBR8[nLBr8,4]
				Else
					cClaSip := ""
					nLBr8	:= 1       
		        Endif
			Endif
			If  ALLTRIM(cClaSip) == "1"
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Verifica se ja carregou a guia uma vez e busca o resultado para melhorar desempenho   ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			    nPos := Ascan(aProcSip,{ |x| x[1] == PEQRY->(CODOPE+CODLDP+CODPEG+NUMERO)})
			    If nPos == 0
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Verifica se Tipo da Guia e diferente de 3 e busca a especialide no BD5   ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					If BD5->(msSeek(xFilial("BD5")+PEQRY->(CODOPE+CODLDP+CODPEG+NUMERO)))					
						sCodEsp := BD5->BD5_CODESP
			   		ElseIf BE4->(msSeek(xFilial("BE4")+PEQRY->(CODOPE+CODLDP+CODPEG+NUMERO))) 
			         	sCodEsp := BE4->BE4_CODESP
			      	Endif   
			        
			      If BD6->(FieldPos("BD6_ESPEDI")) > 0 .AND. BAQ->(FieldPos("BAQ_INTERC")) > 0 .and. !Empty(BD6->BD6_ESPEDI)
			      	sCodEsp := Posicione("BAQ",5,xFilial("BAQ")+AllTrim(BD6->BD6_ESPEDI),"BAQ_CODESP") 
			      EndIf
		     	    //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				    //³ Busca no BAQ de acordo com a especialidade da Guia a Classif SIP para o anexo 3   ³
				    //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					BAQ->(DbSetOrder(1))
					BAQ->(msSeek(xFilial("BAQ")+PEQRY->CODOPE+sCodEsp))
					sClaSip := BAQ->BAQ_ESPSP2                             
		     	    //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				    //³ Caso nao ache a especialidade ou nao tenha a classif sip ele pega do BR8 ³
				    //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
					If empty(sClaSip) .or. sClaSip == nil
						sClaSip := cClaSip 
					EndIf			
	 			    aadd(aProcSip,{PEQRY->(CODOPE+CODLDP+CODPEG+NUMERO),sCodEsp,sClaSip})
		       Else 
					sClaSip := aProcSip[nPos,3]
		       Endif				
			Else
				sClaSip := cClaSip   
			EndIf		 
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Posiciona o arrey anexo3 de acordo com a Classe SIP        ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			nPos := aScan(aAnexo3,{|x| AllTrim(x[1]) == AllTrim(sClaSip)})
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Acumula valores arrey Anexo 3			                   ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If  nPos == 0
				 nPosaCri := aScan(aCriticas,{|u| u[1] == cCodPsa})    
			Else
			    aAnexo3[nPos,2] += PEQRY->QTDE	
			Endif
			
			if nLogDad = 2		
				cLogDad := PEQRY->CODOPE+";"
				cLogDad += PEQRY->CODLDP+";"
				cLogDad += PEQRY->CODPEG+";"
				cLogDad += PEQRY->NUMERO+";"
				cLogDad += StrZero(PEQRY->QTDE,3)+";"
				cLogDad += Str(PEQRY->VLRPAG,17,2)+";"			
				cLogDad += Str(PEQRY->VLRPF,17,2)+";"			
			    cLogDad += IIf(cTipPla = "1","IND",IIF(cTipPla = "2","CSP",IIF(cTipPla = "3","CCP","   ")))+";"				   
				cLogDad += IIf(cGruBen = "1","EXP",IIF(cGruBen = "2","ENB",IIF(cGruBen = "3","BNE","   ")))+";"
			    cLogDad += AllTrim(sClaSip)+";"		    	    			    
				PlsLogFil(cLogDad,"AIII_PL130VLR_ENQ_SIP.SIP")					
			EndIf
	
		Endif
	
		PEQRY->(DbSkip())
	EndDo
	
	PEQRY->(DbCloseArea())
	
	If cGruBen = "1" .AND. alltrim(cTipPla) == "2"
		//QUERY PROCEDURE SIGA.CR_PLS_CUSTO_POR_EVENTO_NOVO relativo aos Débitos/Créditos Protheus
		cSql := "SELECT  BBB_YNEVEN CODEVENTO,"+CRLF
		cSql += "COUNT(DISTINCT BGQ_CODSEQ) QTDE,"+CRLF
		cSql += "SUM(Decode(BBB_TIPSER,1,-1*BGQ_VALOR,BGQ_VALOR)) VLRPAG "+CRLF
		cSql += "FROM "+RetSqlName("BGQ")+" BGQ,"+RetSqlName("BBB")+" BBB,"+RetSqlName("SE2")+" SE2,"+RetSqlName("BI3")+" BI3,"+RetSqlName("ZZT")+" ZZT "+CRLF
		cSql += "WHERE BGQ_FILIAL = '"+xFilial("BGQ")+"' "+CRLF
		cSql += "AND BGQ_CODLAN <> '050' "+CRLF
		cSql += "AND BBB_FILIAL = '"+xFilial("BBB")+"' "+CRLF
		cSql += "AND BBB_CODSER = BGQ_CODLAN "+CRLF
		cSql += "AND E2_FILIAL = '"+xFilial("SE2")+"' "+CRLF
		cSql += "AND BGQ_NUMLOT = E2_PLLOTE "+CRLF
		cSql += "AND ZZT_FILIAL = '"+xFilial("ZZT")+"' "+CRLF
		cSql += "AND BBB_YNEVEN=ZZT_CODEV "+CRLF
		cSql += "AND BI3_FILIAL = '"+xFilial("BI3")+"' "+CRLF
		cSql += "AND BI3_CODIGO=BBB_YCODPL "+CRLF
		cSql += "AND BGQ_CODIGO = E2_CODRDA "+CRLF
		cSql += "AND E2_TIPO = 'FT ' "+CRLF
		cSql += "AND E2_ANOBASE||E2_MESBASE = '"+cAIni+cMIni+"' "+CRLF
		cSql += "AND BI3.D_E_L_E_T_ = ' ' "+CRLF
		cSql += "AND ZZT.D_E_L_E_T_ = ' ' "+CRLF
		cSql += "AND BGQ.D_E_L_E_T_ = ' ' "+CRLF
		cSql += "AND BBB.D_E_L_E_T_ = ' ' "+CRLF
		cSql += "AND SE2.D_E_L_E_T_ = ' ' "+CRLF
		cSql += "GROUP BY BBB_YNEVEN"+CRLF
		
		If nLogDad = 2
			PlsLogFil("QUERY PROCEDURE SIGA.CR_PLS_CUSTO_POR_EVENTO_NOVO relativo aos Débitos/Créditos Protheus","QUERY_PL130VLR.SIP")
			PlsLogFil(cEmpAtu+"/"+cTipPla+"/"+cGruBen,"QUERY_PL130VLR.SIP")
			PlsLogFil(cSql,"QUERY_PL130VLR.SIP")						
			PlsLogFil("","QUERY_PL130VLR.SIP")
		EndIf
				
		PLSQuery(cSql,"PEQRY")
		
		BarGauge2Set(PEQRY->(RecCount()))
		
		While !PEQRY->(EoF())
			if nLogDad = 2		
				cLogDad := StrZero(PEQRY->QTDE,3)+";"
				cLogDad += Str(PEQRY->VLRPAG,17,2)+";"			
			    cLogDad += IIf(cTipPla = "1","IND",IIF(cTipPla = "2","CSP",IIF(cTipPla = "3","CCP","   ")))+";"				   
				cLogDad += IIf(cGruBen = "1","EXP",IIF(cGruBen = "2","ENB",IIF(cGruBen = "3","BNE","   ")))+";"
			    cLogDad += Str(PEQRY->CODEVENTO,3)+";"		    	    			    
				PlsLogFil(cLogDad,"AII_PL130VLR_QRY_DEB_CRED.SIP")					
			EndIf
			
			IncProcG2("PL130VLR-Acumulando valores para Débito/Crédito: ")
			nPos := Ascan(aSipExp,{|x| x[5] = PEQRY->CODEVENTO })
			If PEQRY->CODEVENTO >= 34
				nPos := aScan(aSipExp,{|x| AllTrim(x[1]) == "1.4.1" })			
			ElseIf nPos <= 0
				nPos := aScan(aSipExp,{|x| AllTrim(x[1]) == "1.5" })	
			EndIf
			aSipExp[nPos,2] += PEQRY->QTDE
			aSipExp[nPos,3] += PEQRY->VLRPAG
			
			if nLogDad = 2		
				cLogDad := StrZero(PEQRY->QTDE,3)+";"
				cLogDad += Str(PEQRY->VLRPAG,17,2)+";"			
			    cLogDad += IIf(cTipPla = "1","IND",IIF(cTipPla = "2","CSP",IIF(cTipPla = "3","CCP","   ")))+";"				   
				cLogDad += IIf(cGruBen = "1","EXP",IIF(cGruBen = "2","ENB",IIF(cGruBen = "3","BNE","   ")))+";"
			    cLogDad += aSipExp[nPos,1]+";"		    	    			    
				PlsLogFil(cLogDad,"AII_PL130VLR_ENQ_DEB_CRED.SIP")					
			EndIf
			
			PEQRY->(DbSkip())
		EndDo           
		
		PEQRY->(DbCloseArea())
	EndIf
	
	If alltrim(cTipPla) == "2" 
		//QUERY PROCEDURE SIGA.CR_PLS_CUSTO_POR_EVENTO_NOVO relativo aos Mat/Med e Reembolso sistema Legado
		cSql :=  "SELECT  Decode(Nvl(COD_TIPO_REEMBOLSO,0), 3,7, 4,7, 5,7, 6,7, 7,34, 8,1, 9,31, 10,34, 11,39, 12,7, 13,37, 14,37, 7)  CODEVENTO, "+CRLF
		cSql +=  "COUNT(DISTINCT A.NUM_ASSOCIADO ) QTDE, "+CRLF
		cSql +=  "SUM(NVL(VAL_CALCULADO_REEMB,0)) VLRPAG, "+CRLF
		cSql +=  "0 VLRPF "+CRLF
		cSql +=  "FROM  SAUDE.PEDIDO_REEMBOLSO@PROD A,SAUDE.ASSOCIADO@PROD E, SAUDE.PLANO_MEDICO@PROD PM ,"+RetSqlName("ZZT")+" ZZT,SAUDE.RECIBO_PEDIDO@PROD RE "+CRLF
		cSql +=  "WHERE  ZZT_FILIAL='"+xFilial("ZZT")+"' AND "+CRLF
		cSql +=  "A.DAT_PAGAMENTO between TO_DATE('01-"+cMIni+"-"+IIf(Len(AllTrim(cAIni)) = 4,cAIni,"20"+cAIni )+"','dd/mm/yyyy') and LAST_DAY(TO_DATE('01-"+cMIni+"-"+IIf(Len(AllTrim(cAIni)) = 4,cAIni,"20"+cAIni )+"','dd/mm/yyyy')) AND "+CRLF
		cSql +=  "A.IND_SITUACAO_PEDIDO IN (4,8) AND "+CRLF
		cSql +=  "A.NUM_ASSOCIADO = E.NUM_ASSOCIADO AND "+CRLF
		cSql +=  "RE.IND_DEVOLUCAO = 0   AND "+CRLF
		cSql +=  "A.NUM_REEMBOLSO = RE.NUM_REEMBOLSO(+) AND "+CRLF
		cSql +=  "E.COD_PLANO=PM.COD_PLANO(+)  AND "+CRLF
		cSql +=  "Decode(Nvl(COD_TIPO_REEMBOLSO,0),3,7,4,7,5,7,6,7,7,34,8,1,9,31,10,34,11,39,12,7,13,37,14,37,7)=ZZT_CODEV     AND "+CRLF
		cSql +=  "SAUDE.TIPO_EXPOSICAO_ANS@PROD (E.NUM_ASSOCIADO,A.DAT_PAGAMENTO) = "+cTipUsu+" AND "+CRLF
		cSql +=  "ZZT.D_E_L_E_T_=' ' "+CRLF
		cSql +=  "GROUP BY  Decode(Nvl(COD_TIPO_REEMBOLSO,0), 3,7, 4,7, 5,7, 6,7, 7,34, 8,1, 9,31, 10,34, 11,39, 12,7, 13,37, 14,37, 7) "+CRLF
		cSql +=  "UNION "+CRLF
		cSql +=  "SELECT 37 CODEVENTO, "+CRLF
		cSql +=  "COUNT(DISTINCT ASS.NUM_ASSOCIADO) QTDE, "+CRLF
		cSql +=  "SUM(DESPESA) VLRPAG, "+CRLF
		cSql +=  "SUM(PART) VLRPF "+CRLF
		cSql +=  "FROM  ( SELECT NUM_PEDIDO, SAUDE.ASS_GET_DATA_EMISSAO_NF@PROD(FM.NUM_PEDIDO) DATA, SUM(NVL(VAL_PARCELA,0)) DESPESA, 0 PART, 0 BRUTO "+CRLF
		cSql +=  "        FROM SAUDE.FATURAMENTO_MATERIAL@PROD FM "+CRLF
		cSql +=  "			WHERE FM.COD_SITUACAO IN (3,4) AND "+CRLF
	    cSql +=  "     	FM.DATA_EMISSAO_NF BETWEEN TO_DATE('01-"+cMIni+"-"+IIf(Len(AllTrim(cAIni)) = 4,cAIni,"20"+cAIni )+"','dd/mm/yyyy') AND LAST_DAY(TO_DATE('01-"+cMIni+"-"+IIf(Len(AllTrim(cAIni)) = 4,cAIni,"20"+cAIni )+"','dd/mm/yyyy')) "+CRLF
		cSql +=  "        GROUP BY FM.NUM_PEDIDO, SAUDE.ASS_GET_DATA_EMISSAO_NF@PROD(FM.NUM_PEDIDO) "+CRLF
	    cSql +=  "        UNION  ALL "+CRLF
	    cSql +=  "        SELECT NUM_PEDIDO, SAUDE.ASS_GET_DATA_EMISSAO_NF@PROD(IP.NUM_PEDIDO) DATA, 0 DESPESA , SUM(NVL(VAL_PARTICIPACAO,0)) PART, SUM(NVL(VAL_TOTAL_BRUTO,0)) BRUTO "+CRLF
	    cSql +=  "        FROM SAUDE.ITENS_PEDIDO_MATERIAL@PROD IP "+CRLF
	    cSql +=  "        WHERE IP.NUM_PEDIDO IN (SELECT FM.NUM_PEDIDO "+CRLF
	    cSql +=  "        								FROM SAUDE.FATURAMENTO_MATERIAL@PROD FM "+CRLF
	    cSql +=  "        								WHERE COD_SITUACAO IN (3,4) "+CRLF
		cSql +=  "											AND   DATA_EMISSAO_NF BETWEEN TO_DATE('01-"+cMIni+"-"+IIf(Len(AllTrim(cAIni)) = 4,cAIni,"20"+cAIni )+"','dd/mm/yyyy') AND LAST_DAY(TO_DATE('01-"+cMIni+"-"+IIf(Len(AllTrim(cAIni)) = 4,cAIni,"20"+cAIni )+"','dd/mm/yyyy')))"+CRLF
		cSql +=  "			GROUP BY IP.NUM_PEDIDO, SAUDE.ASS_GET_DATA_EMISSAO_NF@PROD(IP.NUM_PEDIDO)  ) V, "+CRLF
		cSql +=  "SAUDE.PEDIDO_MATERIAL@PROD PM, SAUDE.ASSOCIADO@PROD ASS,SAUDE.PLANO_MEDICO@PROD PL ,"+RetSqlName("ZZT")+" ZZT "+CRLF
		cSql +=  "WHERE  ZZT_FILIAL='"+xFilial("ZZT")+"' AND "+CRLF
		cSql +=  "V.NUM_PEDIDO = PM.NUM_PEDIDO AND "+CRLF
		cSql +=  "PM.COD_SITUACAO <> 9 AND "+CRLF
		cSql +=  "PM.IND_ESTOQUE = 'N'  AND "+CRLF
		cSql +=  "PM.NUM_ASSOCIADO = ASS.NUM_ASSOCIADO AND "+CRLF
		cSql +=  "ASS.COD_PLANO NOT IN ('ESSENCIAL','MAIS','MULTI','TOTAL') AND "+CRLF
		cSql +=  "SAUDE.TIPO_EXPOSICAO_ANS@PROD(ASS.NUM_ASSOCIADO,FIRST_DAY(DATA)) = "+cTipUsu+" AND "+CRLF
		cSql +=  "ASS.COD_PLANO=PL.COD_PLANO(+) AND "+CRLF
		cSql +=  "ZZT_CODEV=37     AND "+CRLF
		cSql +=  "ZZT.D_E_L_E_T_=' ' "+CRLF
		
		If nLogDad = 2
			PlsLogFil("QUERY PROCEDURE SIGA.CR_PLS_CUSTO_POR_EVENTO_NOVO relativo aos Mat/Med e Reembolso sistema Legado","QUERY_PL130VLR.SIP")
			PlsLogFil(cEmpAtu+"/"+cTipPla+"/"+cGruBen,"QUERY_PL130VLR.SIP")
			PlsLogFil(cSql,"QUERY_PL130VLR.SIP")						
			PlsLogFil("","QUERY_PL130VLR.SIP")
		EndIf

		
		PLSQuery(cSql,"PEQRY")
		
		BarGauge2Set(PEQRY->(RecCount()))
		
		While !PEQRY->(EoF())
			IncProcG2("PL130VLR-Acumulando valores de Mat/Med Legado: ")
			if nLogDad = 2		
				cLogDad := StrZero(PEQRY->QTDE,3)+";"
				cLogDad += Str(PEQRY->VLRPAG,17,2)+";"			
			    cLogDad += IIf(cTipPla = "1","IND",IIF(cTipPla = "2","CSP",IIF(cTipPla = "3","CCP","   ")))+";"				   
				cLogDad += IIf(cGruBen = "1","EXP",IIF(cGruBen = "2","ENB",IIF(cGruBen = "3","BNE","   ")))+";"
			    cLogDad += Str(PEQRY->CODEVENTO,3)+";"		    	    			    
				PlsLogFil(cLogDad,"AII_PL130VLR_QRY_REEMB.SIP")					
			EndIf			
			nPos := Ascan(aSipExp,{|x| x[5] = PEQRY->CODEVENTO })
			If nPos > 0
				aSipExp[nPos,2] += PEQRY->QTDE
				aSipExp[nPos,3] += PEQRY->VLRPAG
				aSipExp[nPos,4] += PEQRY->VLRPF
			Else
				Do Case
					Case PEQRY->CODEVENTO >= 34
						cCdSIP := "1.4.2"
						nPos := aScan(aSipExp,{|x| AllTrim(x[1]) == cCdSIP })
					OtherWise
						nPos := aScan(aSipExp,{|x| AllTrim(x[1]) == "1.5" })
				Endcase
				aSipExp[nPos,2] += iif(PEQRY->CODEVENTO >= 34,0,PEQRY->QTDE)
				aSipExp[nPos,3] += PEQRY->VLRPAG
				aSipExp[nPos,4] += PEQRY->VLRPF		
			EndIf
			if nLogDad = 2		
				cLogDad := StrZero(PEQRY->QTDE,3)+";"
				cLogDad += Str(PEQRY->VLRPAG,17,2)+";"			
			    cLogDad += IIf(cTipPla = "1","IND",IIF(cTipPla = "2","CSP",IIF(cTipPla = "3","CCP","   ")))+";"				   
				cLogDad += IIf(cGruBen = "1","EXP",IIF(cGruBen = "2","ENB",IIF(cGruBen = "3","BNE","   ")))+";"
			    cLogDad += aSipExp[nPos,1]+";"		    	    			    
				PlsLogFil(cLogDad,"AII_PL130VLR_ENQ_REEMB.SIP")					
			EndIf			

			PEQRY->(DbSkip())
		EndDo
		
		PEQRY->(DbCloseArea())
	
	EndIf
Else
	//QUERY PROCEDURE SIGA.CR_PLS_CUSTO_POR_EVENTO_NOVO relativo aos atendimentos Protheus
	cSql := "SELECT BD7F.BD7_CODOPE CODOPE, BD7F.BD7_CODLDP CODLDP, BD7F.BD7_CODPEG CODPEG, BD7F.BD7_NUMERO NUMERO,BD7F.BD7_SEQUEN SEQUEN,BD7F.BD7_CODPAD CODPAD,BD7F.BD7_CODPRO CODPRO,"
	cSql += "RETORNA_EVENTO_BD5(BD6_OPEUSR,BD6_CODLDP, BD6_CODPEG,BD6_NUMERO,BD6_ORIMOV,BD6_CODPAD,BD6_CODPRO,BD6_MATVID,'"+IIf(cEmpAtu = "01","C","I")+"' ) CODEVENTO,"
	cSql += "SUM(BD7F.BD6_QTDPRO) QTDE,"
	cSql += "SUM(BD7F.VLRPAG)  VLRPAG,"
	cSql += "SUM(DECODE(BD6F.BD6_BLOCPA,'1',0,DECODE(SIGN(BD6F.BD6_VLRTPF),-1,0,DECODE(BD6F.BD6_CODEMP,'0004',0,BD6F.BD6_VLRTPF)))) VLRPF "
	cSql += "FROM    ("
	cSql += "SELECT  BD7.BD7_FILIAL,BD7_CODPLA,SIGA_TIPO_EXPOSICAO_ANS_INT(BD7_CODEMP,BD7_MATRIC,BD7_TIPREG,sysdate) EXPOS,"
	cSql += "BD7.BD7_OPELOT,BD7.BD7_NUMLOT,"
	cSql += "BD7.BD7_CODRDA, BD7.BD7_CODOPE, BD7.BD7_CODLDP, BD7.BD7_CODPEG, BD7.BD7_NUMERO, BD7.BD7_ORIMOV, BD7_CODPAD,BD7_CODPRO,"
	cSql += "BD7.BD7_SEQUEN, BD6.BD6_QTDPRO, Sum(BD7.BD7_VLRPAG) AS VLRPAG,"
	cSql += "COUNT(DISTINCT BD7_CODEMP||BD7_MATRIC||BD7_TIPREG) QTDE "
	cSql += "FROM    "+RetSqlName("BD7")+" BD7, "+RetSqlName("BAU")+" BAU, "+RetSqlName("BD6")+" BD6 "
	If  alltrim(cTipPla) <> "1" // Tipo Plano = Coletivo
		cSql += ", "+RetSqlName("BQC")+" BQC "
	Endif
	cSql += "WHERE BD7.BD7_FILIAL='"+xFilial("BD7")+"' "
	cSql += "AND BD7.BD7_CODOPE = '"+cOper+"' "
	cSql += "AND BD7.BD7_SITUAC = '1' "
	cSql += "AND BD7.BD7_FASE = '4' "
	cSql += "AND BD7.BD7_BLOPAG <> '1' "
	cSql += "AND SIGA_TIPO_EXPOSICAO_ANS_INT(BD7_CODEMP,BD7_MATRIC,BD7_TIPREG,sysdate) = "+cTipUsu+" " 
	cSql += "AND BD7.D_E_L_E_T_ = ' ' "
	cSql += "AND BAU_FILIAL = '"+xFilial("BAU")+"' "
	cSql += "AND BAU.BAU_CODIGO = BD7.BD7_CODRDA "
	cSql += "AND BAU.D_E_L_E_T_ = ' ' "
	cSql += "AND BD6.BD6_FILIAL = '  ' "       
	cSql += "AND BD6.BD6_CODOPE = BD7.BD7_CODOPE "
	cSql += "AND BD6.BD6_CODLDP = BD7.BD7_CODLDP "
	cSql += "AND BD6.BD6_CODPEG = BD7.BD7_CODPEG "
	cSql += "AND BD6.BD6_NUMERO = BD7.BD7_NUMERO "
	cSql += "AND BD6.BD6_ORIMOV = BD7.BD7_ORIMOV "
	cSql += "AND BD6.BD6_SEQUEN = BD7.BD7_SEQUEN "
	cSql += "AND BD6.BD6_CODPRO = BD7.BD7_CODPRO AND "
	If cEmpIni <> '    ' .and. Upper(cEmpFim) <> 'ZZZZ'  
		cSql += " BD6.BD6_OPEUSR =  '" + cOper   + "'  AND "
		cSql += "BD6.BD6_CODEMP >= '" + cEmpIni   + "' AND "
		cSql += "BD6.BD6_MATRIC >= '" + cMatIni   + "' AND "
		cSql += "BD6.BD6_CODEMP <= '" + cEmpFim   + "' AND "
		cSql += "BD6.BD6_MATRIC <= '" + cMatFim   + "' AND "
	Endif
	If !empty(cEmpIntS)
		cSql += " BD6.BD6_CODEMP NOT IN ("+cEmpIntS+") AND"	
	Endif
	cSql += " BD6.D_E_L_E_T_ = ' ' "
	If  alltrim(cTipPla) <> "1" // Tipo Plano = Coletivo
		cSql += " AND BQC.BQC_FILIAL = '"+xFilial("BQC")+"' AND "	
		cSql += " BQC.BQC_CODIGO = BD6.BD6_OPEUSR||BD6.BD6_CODEMP AND "
		cSql += " BQC.BQC_NUMCON = BD6.BD6_CONEMP AND " 
		cSql += " BQC.BQC_VERCON = BD6.BD6_VERCON AND " 
		cSql += " BQC.BQC_SUBCON = BD6.BD6_SUBCON AND "
		cSql += " BQC.BQC_VERSUB = BD6.BD6_VERSUB AND "
		If  alltrim(cTipPla) == "2" // Tipo Plano = Coletivo sem patrocinador
			cSql += " BQC.BQC_PATROC <> '1' AND " // sem patrocinador
		Else
			cSql += " BQC.BQC_PATROC = '1' AND "// com patrocinador
		Endif
		cSql += " BQC.D_E_L_E_T_ = ' ' "
	Else
		cSql += " AND BD6.BD6_CONEMP = ' ' AND 
		cSql += " BD6.BD6_VERCON = ' ' AND 
		cSql += " BD6.BD6_SUBCON = ' 'AND
		cSql += " BD6.BD6_VERSUB = ' '
	Endif
	cSql += "GROUP BY BD7.BD7_FILIAL,BD7_CODPLA,SIGA_TIPO_EXPOSICAO_ANS_INT(BD7_CODEMP,BD7_MATRIC,BD7_TIPREG,sysdate),"
	cSql += "BD7.BD7_OPELOT,BD7.BD7_NUMLOT,"
	cSql += "BD7.BD7_CODRDA, BD7.BD7_CODOPE, BD7.BD7_CODLDP, BD7.BD7_CODPEG, BD7.BD7_NUMERO, BD7.BD7_ORIMOV, BD7_CODPAD,BD7_CODPRO,"
	cSql += "BD7.BD7_SEQUEN, BD6.BD6_QTDPRO "
	cSql += ") BD7F, "+RetSqlName("BD6")+" BD6F,"+RetSqlName("BR8")+" BR8, "+RetSqlName("BI3")+" BI3, "+RetSqlName("ZZT")+" ZZT, "
	cSql += RetSqlName("SE2")+" SE2 ,"+RetSqlName("BG9")+" BG9 "
	cSql += "WHERE E2_FILIAL = '01'
	cSql += "AND ZZT_FILIAL='"+xFilial("ZZT")+"' "
	cSql += "AND ZZT.D_E_L_E_T_ = ' ' "
	cSql += "AND BR8.BR8_FILIAL='"+xFilial("BR8")+"' "
	cSql += "AND BR8.BR8_FILIAL=BD6_FILIAL "
	cSql += "AND BR8.BR8_CODPAD=BD6_CODPAD "
	cSql += "AND BR8.BR8_CODPSA=BD6_CODPRO "
	cSql += "AND BR8.D_E_L_E_T_ = ' ' "
	cSql += "AND BI3.BI3_FILIAL='"+xFilial("BR8")+"' "
	cSql += "AND BI3_FILIAL =BD7_FILIAL "
	cSql += "AND BI3_CODINT=BD7_CODOPE "
	cSql += "AND BI3_CODIGO=BD7_CODPLA "
	cSql += "AND BI3.D_E_L_E_T_ = ' ' "
	cSql += "AND BD6F.BD6_FILIAL='"+xFilial("BD6")+"' "
	cSql += "AND BD6_OPEUSR=BG9_CODINT "
    cSql += "AND BD6_CODEMP=BG9_CODIGO "    	
    cSql += "AND BG9.D_E_L_E_T_ = ' ' "	
	cSql += "AND RETORNA_EVENTO_BD5 (BD6_OPEUSR,BD6_CODLDP, BD6_CODPEG,BD6_NUMERO,BD6_ORIMOV,BD6_CODPAD,BD6_CODPRO,BD6_MATVID,'"+IIf(cEmpAtu = "01","C","I")+"' )=ZZT_CODEV "
	cSql += "AND BD6F.D_E_L_E_T_ = ' ' "
	cSql += "AND BG9_FILIAL=' ' "
    cSql += "AND E2_ANOBASE='"+cAIni+"' "
    cSql += "AND E2_MESBASE='"+cMIni+"' " 
    cSql += "AND E2_ORIGEM='PLSMPAG' "
    cSql += "AND E2_TIPO='FT' "
    cSql += "AND E2_PLOPELT = BD7F.BD7_OPELOT "
    cSql += "AND E2_PLLOTE =  BD7F.BD7_NUMLOT "
    cSql += "AND E2_CODRDA= BD7F.BD7_CODRDA "
    cSql += "AND SE2.D_E_L_E_T_ = ' ' "
	cSql += "AND BD7F.BD7_FILIAL = BD6F.BD6_FILIAL "
	cSql += "AND BD7F.BD7_CODOPE = BD6F.BD6_CODOPE "
	cSql += "AND BD7F.BD7_CODLDP = BD6F.BD6_CODLDP "
	cSql += "AND BD7F.BD7_CODPEG = BD6F.BD6_CODPEG "
	cSql += "AND BD7F.BD7_NUMERO = BD6F.BD6_NUMERO "
	cSql += "AND BD7F.BD7_ORIMOV = BD6F.BD6_ORIMOV "
	cSql += "AND BD7F.BD7_SEQUEN = BD6F.BD6_SEQUEN "
	cSql += "AND BD7F.BD7_CODPRO = BD6F.BD6_CODPRO "
	cSql += "GROUP BY    BD7F.BD7_CODOPE, BD7F.BD7_CODLDP, BD7F.BD7_CODPEG, BD7F.BD7_NUMERO,BD7F.BD7_SEQUEN,BD7F.BD7_CODPAD,BD7F.BD7_CODPRO, "
	cSql += "RETORNA_EVENTO_BD5(BD6_OPEUSR,BD6_CODLDP, BD6_CODPEG,BD6_NUMERO,BD6_ORIMOV,BD6_CODPAD,BD6_CODPRO,BD6_MATVID,'"+IIf(cEmpAtu = "01","C","I")+"' ) "
	
	                                        
	PLSQuery(cSql,"PEQRY")
	
	BarGauge2Set(PEQRY->(RecCount()))
	
	BE4->(DbSetOrder(1))
	
	While !PEQRY->(EoF())
		IncProcG2("PL130VLR-Acumulando valores para o procedimento: " + PEQRY->CODPRO)
		nPos := Ascan(aSipExp,{|x| x[5] = PEQRY->CODEVENTO })
		If nPos > 0
			aSipExp[nPos,2] += PEQRY->QTDE
			aSipExp[nPos,3] += PEQRY->VLRPAG
			aSipExp[nPos,4] += PEQRY->VLRPF
		Else
			nPosaSip := aScan(aSip,{|x| AllTrim(x[iCodPsa]) == AllTrim(PEQRY->CODPRO) })
			If nPosaSip > 0
				cCdSIP	 := AllTrim(aSip[nPosaSip,iCodigo])
			Else
				cCdSIP	 := ""
			EndIf
	 
			Do Case
				Case nPosaSip > 0 .and. !Empty(cCdSIP) .and. PEQRY->CODEVENTO == 1  .and. cCdSIP = '1.1'
					nPos := aScan(aSipExp,{|x| AllTrim(x[1]) == cCdSIP }) 
				Case nPosaSip > 0 .and. !Empty(cCdSIP) .and. PEQRY->CODEVENTO == 6  .and. cCdSIP = '1.5'
					nPos := aScan(aSipExp,{|x| AllTrim(x[1]) == cCdSIP }) 
				Case nPosaSip > 0 .and. !Empty(cCdSIP) .and. PEQRY->CODEVENTO == 7  .and. cCdSIP = '1.6'
					nPos := aScan(aSipExp,{|x| AllTrim(x[1]) == cCdSIP }) 
				Case nPosaSip > 0 .and. !Empty(cCdSIP) .and. PEQRY->CODEVENTO == 30 .and. SubStr(cCdSIP,1,5) = '1.2.1' 
					nPos := aScan(aSipExp,{|x| AllTrim(x[1]) == cCdSIP }) 
				Case nPosaSip > 0 .and. !Empty(cCdSIP) .and. PEQRY->CODEVENTO == 31 .and. SubStr(cCdSIP,1,5) = '1.2.2' 
					nPos := aScan(aSipExp,{|x| AllTrim(x[1]) == cCdSIP }) 
				Case nPosaSip > 0 .and. !Empty(cCdSIP) .and. PEQRY->CODEVENTO == 32 .and. SubStr(cCdSIP,1,5) = '1.3.1'
					nPos := aScan(aSipExp,{|x| AllTrim(x[1]) == cCdSIP }) 		
				Case nPosaSip > 0 .and. !Empty(cCdSIP) .and. PEQRY->CODEVENTO == 33 .and. SubStr(cCdSIP,1,5) = '1.3.2'
					nPos := aScan(aSipExp,{|x| AllTrim(x[1]) == cCdSIP }) 
				Case PEQRY->CODEVENTO >= 34
					If BE4->(msSeek(xFilial("BE4")+PEQRY->(CODOPE+CODLDP+CODPEG+NUMERO)))
						If 	!Empty(BE4->BE4_DTALTA) .AND.;
							(BE4->BE4_DTALTA = BE4->BE4_DATPRO  .OR.;
				   			(BE4->BE4_DTALTA = (BE4->BE4_DATPRO+1) .AND. BE4->BE4_HRALTA < BE4->BE4_HORPRO))
						
							cCdSIP := "1.4.1"							
						Else
							cCdSIP := "1.4.2"
						EndIf
						lBE4 := .T. 
					Else
						cCdSIP := "1.4.2"
						lBE4 := .F.
					EndIf
					nPos := aScan(aSipExp,{|x| AllTrim(x[1]) == cCdSIP })
				OtherWise
					nPos := aScan(aSipExp,{|x| AllTrim(x[1]) == "1.5" })
			Endcase
			If PEQRY->CODEVENTO >= 34 .AND. SubStr(cCdSIP,1,3) = "1.4" .and. lBE4
				nPosInt := Ascan(aRecInt,{|x| x[1] = PEQRY->(CODOPE+CODLDP+CODPEG+NUMERO) })
				If nPosInt = 0
					aadd(aRecInt,{PEQRY->(CODOPE+CODLDP+CODPEG+NUMERO) })
					aSipExp[nPos,2] ++
				EndIf
			Else
				If PEQRY->CODPAD <> '05' .and. SubStr(cCdSIP,1,3) <> "1.4" 
					aSipExp[nPos,2] += PEQRY->QTDE
				Endif
			EndIf
			aSipExp[nPos,3] += PEQRY->VLRPAG
			aSipExp[nPos,4] += PEQRY->VLRPF		
		EndIf	
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Acumula valores para o Anexo 3, somente qdo Grupo de Beneficiarios for  ³
		//³	1-Beneficiarios expostos                  								³
		//³	2-Expostos nao beneficiarios                  							³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		nPosA3 := Ascan(aRecA3,{|x| x[1] = PEQRY->(CODOPE+CODLDP+CODPEG+NUMERO+SEQUEN) })
		If nPosA3 = 0
			aadd(aRecA3,{PEQRY->(CODOPE+CODLDP+CODPEG+NUMERO+SEQUEN) })
			lA3 := .T.
		Else
			lA3 := .F.
		EndIf
		
		If (cGruBen == "1"  .or. cGruBen == "2") .and. lA3 .and. PEQRY->CODEVENTO < 34
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Posiciona o BR8 de acordo com o Procedimento			   ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If  aProcBR8[nLBr8,2] <> AllTrim(PEQRY->CODPRO)           
				nLBr8 := aScan(aProcBR8,{ |x| AllTrim(x[2]) == AllTrim(PEQRY->CODPRO) })
				If  nLBr8 <> 0
					cClaSip := aProcBR8[nLBr8,4]
				Else
					cClaSip := ""
					nLBr8	:= 1
		   		Endif
			Else
				If  nLBr8 <> 0
					cClaSip := aProcBR8[nLBr8,4]
				Else
					cClaSip := ""
					nLBr8	:= 1       
		        Endif
			Endif
			If  ALLTRIM(cClaSip) == "1"
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Verifica se ja carregou a guia uma vez e busca o resultado para melhorar desempenho   ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			    nPos := Ascan(aProcSip,{ |x| x[1] == PEQRY->(CODOPE+CODLDP+CODPEG+NUMERO)})
			    If nPos == 0
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Verifica se Tipo da Guia e diferente de 3 e busca a especialide no BD5   ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					If BD5->(msSeek(xFilial("BD5")+PEQRY->(CODOPE+CODLDP+CODPEG+NUMERO)))					
						sCodEsp := BD5->BD5_CODESP
			   		ElseIf BE4->(msSeek(xFilial("BE4")+PEQRY->(CODOPE+CODLDP+CODPEG+NUMERO))) 
			         	sCodEsp := BE4->BE4_CODESP
			      	Endif   
			        
			      If BD6->(FieldPos("BD6_ESPEDI")) > 0 .AND. BAQ->(FieldPos("BAQ_INTERC")) > 0 .and. !Empty(BD6->BD6_ESPEDI)
			      	sCodEsp := Posicione("BAQ",5,xFilial("BAQ")+AllTrim(BD6->BD6_ESPEDI),"BAQ_CODESP") 
			      EndIf
		     	    //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				    //³ Busca no BAQ de acordo com a especialidade da Guia a Classif SIP para o anexo 3   ³
				    //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					BAQ->(DbSetOrder(1))
					BAQ->(msSeek(xFilial("BAQ")+PEQRY->CODOPE+sCodEsp))
					sClaSip := BAQ->BAQ_ESPSP2                             
		     	    //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				    //³ Caso nao ache a especialidade ou nao tenha a classif sip ele pega do BR8 ³
				    //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
					If empty(sClaSip) .or. sClaSip == nil
						sClaSip := cClaSip 
					EndIf			
	 			    aadd(aProcSip,{PEQRY->(CODOPE+CODLDP+CODPEG+NUMERO),sCodEsp,sClaSip})
		       Else 
					sClaSip := aProcSip[nPos,3]
		       Endif				
			Else
				sClaSip := cClaSip   
			EndIf		 
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Posiciona o arrey anexo3 de acordo com a Classe SIP        ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			nPos := aScan(aAnexo3,{|x| AllTrim(x[1]) == AllTrim(sClaSip)})
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Acumula valores arrey Anexo 3			                   ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If  nPos == 0
				 nPosaCri := aScan(aCriticas,{|u| u[1] == cCodPsa})    
			Else
			    aAnexo3[nPos,2] += PEQRY->QTDE	
			Endif
	
		Endif
	
		PEQRY->(DbSkip())
	EndDo
	
	PEQRY->(DbCloseArea())
	
	If cGruBen = "1" .AND. alltrim(cTipPla) == "2"
		//QUERY PROCEDURE SIGA.CR_PLS_CUSTO_POR_EVENTO_NOVO relativo aos Débitos/Créditos Protheus
		cSql := "SELECT  BBB_YNEVEN CODEVENTO,"
		cSql += "COUNT(DISTINCT BGQ_CODSEQ) QTDE,"
		cSql += "SUM(Decode(BBB_TIPSER,1,-1*BGQ_VALOR,BGQ_VALOR)) VLRPAG "
		cSql += "FROM "+RetSqlName("BGQ")+" BGQ,"+RetSqlName("BBB")+" BBB,"+RetSqlName("SE2")+" SE2,"+RetSqlName("BI3")+" BI3,"+RetSqlName("ZZT")+" ZZT,"+RetSqlName("BG9")+" BG9 "
		cSql += "WHERE BGQ_FILIAL = '"+xFilial("BGQ")+"' "
		cSql += "AND BGQ_CODLAN <> '050' "
		cSql += " AND BG9_FILIAL=' ' "
		cSql += "AND BBB_FILIAL = '"+xFilial("BBB")+"' "
		cSql += "AND BBB_CODSER = BGQ_CODLAN "
		cSql += "AND E2_FILIAL = '"+xFilial("SE2")+"' "
		cSql += "AND BGQ_NUMLOT = E2_PLLOTE "
		cSql += "AND ZZT_FILIAL = '"+xFilial("ZZT")+"' "
		cSql += "AND BBB_YNEVEN=ZZT_CODEV "
		cSql += "AND BI3_FILIAL = '"+xFilial("BI3")+"' "
		cSql += "AND BI3_CODIGO=BBB_YCODPL "
		cSql += "AND BGQ_CODIGO = E2_CODRDA "
		cSql += "AND E2_TIPO = 'FT ' "
		cSql += "AND E2_ANOBASE||E2_MESBASE = '"+cAIni+cMIni+"' "
		cSql += "AND Decode(BBB_TIPSER,1,-1*BGQ_VALOR,BGQ_VALOR)>0 "
        cSql += "AND BG9_CODINT='0001' "
        cSql += "AND RETORNA_GRUPO_EMP(BI3_CODIGO)=BG9_CODIGO "
		cSql += "AND BI3.D_E_L_E_T_ = ' ' "
		cSql += "AND ZZT.D_E_L_E_T_ = ' ' "
		cSql += "AND BGQ.D_E_L_E_T_ = ' ' "
		cSql += "AND BBB.D_E_L_E_T_ = ' ' "
		cSql += "AND SE2.D_E_L_E_T_ = ' ' "
		cSql += "GROUP BY BBB_YNEVEN"
		
		PLSQuery(cSql,"PEQRY")
		
		BarGauge2Set(PEQRY->(RecCount()))
		
		While !PEQRY->(EoF())
			IncProcG2("PL130VLR-Acumulando valores para Débito/Crédito: ")
			nPos := Ascan(aSipExp,{|x| x[5] = PEQRY->CODEVENTO })
			If nPos <= 0
				nPos := aScan(aSipExp,{|x| AllTrim(x[1]) == "1.5" })	
			EndIf
			aSipExp[nPos,2] += PEQRY->QTDE
			aSipExp[nPos,3] += PEQRY->VLRPAG
			PEQRY->(DbSkip())
		EndDo           
		
		PEQRY->(DbCloseArea())
	EndIf
	
	If alltrim(cTipPla) == "2" 
		//QUERY PROCEDURE SIGA.CR_PLS_CUSTO_POR_EVENTO_NOVO relativo aos Mat/Med e Reembolso sistema Legado
		cSql :=  "SELECT Decode(Nvl(BKD_ZZZCOD,0), '02',7, '03',7, '04',7, '05',7, '01',34, '06',1, '07',31, '08',34, '09',39, '10',7, '11',37, '12',37, 7) CODEVENTO, "
		cSql +=  "COUNT(DISTINCT BKD_CODINT||BKD_CODEMP||BKD_MATRIC||BKD_TIPREG) QTDE, "
		cSql +=  "Sum(Decode(Sign(BKE_VLRRBS-BKE_VLRPAG),-1,BKE_VLRRBS,BKE_VLRPAG)) VLRPAG, "
		cSql +=  "0 VLRPF "
		cSql +=  "FROM BKD020 C,BKE020 D ,SE1020 T ,BA1020 U,BA3020 F ,BI3020 BI3 ,BG9020 BG9 , ZZT010 ZZT,SE2020 SE2 "
		cSql +=  "WHERE BKD_FILIAL=' ' "
        cSql +=  "AND BKE_FILIAL=' ' "
        cSql +=  "AND BI3_FILIAL=' ' "
        cSql +=  "AND BA3_FILIAL=' ' "
        cSql +=  "AND BA1_FILIAL=' ' "
        cSql +=  "AND BG9_FILIAL=' ' "
        cSql +=  "AND ZZT_FILIAL=' ' "
        cSql +=  "AND E1_FILIAL='01' "
        cSql +=  "AND E1_PREFIXO='RLE' "
        cSql +=  "AND BKD_CODRBS=BKE_CODRBS "
        cSql +=  "AND BKD_CODRBS=E1_NUM "
        cSql +=  "AND BA1_CODINT=BA3_CODINT "
        cSql +=  "AND BA1_CODEMP=BA3_CODEMP "
        cSql +=  "AND BA1_MATRIC=BA3_MATRIC "
        cSql +=  "AND BA1_CODINT=BKD_CODINT "
        cSql +=  "AND BA1_CODEMP=BKD_CODEMP "
        cSql +=  "AND BA1_MATRIC=BKD_MATRIC "
        cSql +=  "AND BA1_TIPREG=BKD_TIPREG "
        cSql +=  "AND BI3_CODINT=BA1_CODINT "
        cSql +=  "AND BKD_CODINT=BG9_CODINT "
        cSql +=  "AND BKD_CODEMP=BG9_CODIGO "
        cSql +=  "AND BI3_CODIGO=Nvl(Trim(BA1_CODPLA),BA3_CODPLA) "
        cSql +=  "AND DECODE(E2_VENCREA,NULL,SubStr(E1_VENCREA,1,6),SubStr(E2_VENCREA,1,6))='"+cAIni+cMIni+"' "
        cSql +=  "AND E1_PREFIXO||E1_NUM||E1_PARCELA||E1_TIPO=E2_TITORIG(+) "
        cSql +=  "AND Decode(Nvl(BKD_ZZZCOD,0),'02',7,'03',7,'04',7,'05',7,'01',34,'06',1,'07',31,'08',34,'09',39,'10',7,'11',37,'12',37,7) =ZZT_CODEV "
        cSql +=  "AND SIGA_TIPO_EXPOSICAO_ANS_INT(BKD_CODEMP,BKD_MATRIC,BKD_TIPREG,sysdate) = "+cTipUsu+" "
        cSql +=  "AND C.D_E_L_E_T_=' ' "
        cSql +=  "AND D.D_E_L_E_T_=' ' "
        cSql +=  "AND T.D_E_L_E_T_=' ' "
        cSql +=  "AND U.D_E_L_E_T_=' ' "
        cSql +=  "AND F.D_E_L_E_T_=' ' "
        cSql +=  "AND BI3.D_E_L_E_T_ = ' ' "
        cSql +=  "AND BG9.D_E_L_E_T_=' ' "
        cSql +=  "AND ZZT.D_E_L_E_T_=' ' "
		cSql +=  "GROUP BY  Decode(Nvl(BKD_ZZZCOD,0), '02',7, '03',7, '04',7, '05',7, '01',34, '06',1, '07',31, '08',34, '09',39, '10',7, '11',37, '12',37, 7) "		
		cSql +=  "UNION "
		
		cSql +=  "SELECT 37 CODEVENTO, "
		cSql +=  "COUNT(DISTINCT ASS.NUM_ASSOCIADO) QTDE, "
		cSql +=  "SUM(DESPESA) VLRPAG, "
		cSql +=  "SUM(PART) VLRPF "
		cSql +=  "FROM  ( SELECT NUM_PEDIDO, SAUDE.ASS_GET_DATA_EMISSAO_NF@PROD(FM.NUM_PEDIDO) DATA, SUM(NVL(VAL_PARCELA,0)) DESPESA, 0 PART, 0 BRUTO "
		cSql +=  "        FROM SAUDE.FATURAMENTO_MATERIAL@PROD FM "
		cSql +=  "			WHERE FM.COD_SITUACAO IN (3,4) AND "
	    cSql +=  "     	FM.DATA_EMISSAO_NF BETWEEN TO_DATE('01-"+cMIni+"-"+IIf(Len(AllTrim(cAIni)) = 4,cAIni,"20"+cAIni )+"','dd/mm/yyyy') AND LAST_DAY(TO_DATE('01-"+cMIni+"-"+IIf(Len(AllTrim(cAIni)) = 4,cAIni,"20"+cAIni )+"','dd/mm/yyyy')) "
		cSql +=  "        GROUP BY FM.NUM_PEDIDO, SAUDE.ASS_GET_DATA_EMISSAO_NF@PROD(FM.NUM_PEDIDO) "
	    cSql +=  "        UNION  ALL "
	    cSql +=  "        SELECT NUM_PEDIDO, SAUDE.ASS_GET_DATA_EMISSAO_NF@PROD(IP.NUM_PEDIDO) DATA, 0 DESPESA , SUM(NVL(VAL_PARTICIPACAO,0)) PART, SUM(NVL(VAL_TOTAL_BRUTO,0)) BRUTO "
	    cSql +=  "        FROM SAUDE.ITENS_PEDIDO_MATERIAL@PROD IP "
	    cSql +=  "        WHERE IP.NUM_PEDIDO IN (SELECT FM.NUM_PEDIDO "
	    cSql +=  "        								FROM SAUDE.FATURAMENTO_MATERIAL@PROD FM "
	    cSql +=  "        								WHERE COD_SITUACAO IN (3,4) "
		cSql +=  "											AND   DATA_EMISSAO_NF BETWEEN TO_DATE('01-"+cMIni+"-"+IIf(Len(AllTrim(cAIni)) = 4,cAIni,"20"+cAIni )+"','dd/mm/yyyy') AND LAST_DAY(TO_DATE('01-"+cMIni+"-"+IIf(Len(AllTrim(cAIni)) = 4,cAIni,"20"+cAIni )+"','dd/mm/yyyy')))"
		cSql +=  "			GROUP BY IP.NUM_PEDIDO, SAUDE.ASS_GET_DATA_EMISSAO_NF@PROD(IP.NUM_PEDIDO)  ) V, "
		cSql +=  "SAUDE.PEDIDO_MATERIAL@PROD PM, SAUDE.ASSOCIADO@PROD ASS,SAUDE.PLANO_MEDICO@PROD PL ,"+RetSqlName("ZZT")+" ZZT,"+RetSqlName("BG9")+" BG9 "
		cSql +=  "WHERE  ZZT_FILIAL='"+xFilial("ZZT")+"' AND "
		cSql +=  "BG9_FILIAL=' ' AND "
		cSql +=  "V.NUM_PEDIDO = PM.NUM_PEDIDO AND "
		cSql +=  "PM.COD_SITUACAO <> 9 AND "
		cSql +=  "PM.IND_ESTOQUE = 'N'  AND "
		cSql +=  "PM.NUM_ASSOCIADO = ASS.NUM_ASSOCIADO AND "
		cSql +=  "ASS.COD_PLANO IN ('ESSENCIAL','MAIS','MULTI','TOTAL') AND "
		cSql +=  "SAUDE.TIPO_EXPOSICAO_ANS@PROD(ASS.NUM_ASSOCIADO,FIRST_DAY(DATA)) = "+cTipUsu+" AND "
		cSql +=  "ASS.COD_PLANO=PL.COD_PLANO(+) AND "
		cSql +=  "ZZT_CODEV=37     AND "
		cSql +=  "ZZT.D_E_L_E_T_=' ' AND "
        cSql +=  "BG9_CODINT='0001' AND "
        cSql +=  "RETORNA_GRUPO_EMP_MS(ASS.NUM_ASSOCIADO,'I')=BG9_CODIGO AND "
        cSql +=  "BG9.D_E_L_E_T_=' ' "	
		
		PLSQuery(cSql,"PEQRY")
		
		BarGauge2Set(PEQRY->(RecCount()))
		
		While !PEQRY->(EoF())
			IncProcG2("PL130VLR-Acumulando valores de Mat/Med Legado: ")
			nPos := Ascan(aSipExp,{|x| x[5] = PEQRY->CODEVENTO })
			If nPos > 0
				aSipExp[nPos,2] += PEQRY->QTDE
				aSipExp[nPos,3] += PEQRY->VLRPAG
				aSipExp[nPos,4] += PEQRY->VLRPF
			Else
				Do Case
					Case PEQRY->CODEVENTO >= 34
						cCdSIP := "1.4.2"
						nPos := aScan(aSipExp,{|x| AllTrim(x[1]) == cCdSIP })
					OtherWise
						nPos := aScan(aSipExp,{|x| AllTrim(x[1]) == "1.5" })
				Endcase
				aSipExp[nPos,2] += IIF(PEQRY->CODEVENTO >= 34,0,PEQRY->QTDE)
				aSipExp[nPos,3] += PEQRY->VLRPAG
				aSipExp[nPos,4] += PEQRY->VLRPF		
			EndIf
			PEQRY->(DbSkip())
		EndDo
		
		PEQRY->(DbCloseArea())
	
	EndIf

EndIf

if nLogDad = 2
	For nI:=1 to Len(aSipExp)
		cLogDad := IIf(cGruBen = "1","EXP",IIF(cGruBen = "2","ENB",IIF(cGruBen = "3","BNE","   ")))+";"
		cLogDad += IIf(cTipPla = "1","IND",IIF(cTipPla = "2","CSP",IIF(cTipPla = "3","CCP","   ")))+";"				   
		cLogDad += aSipExp[nI,1]+";"		    	    			    
		cLogDad += StrZero(aSipExp[nI,2],3)+";"
		cLogDad += Str(aSipExp[nI,3],17,2)+";"			
		cLogDad += Str(aSipExp[nI,4],17,2)+";"				
		PlsLogFil(cLogDad,"PL130VLR_RES_SIP.SIP")
	Next	
EndIf

Return(aSipExp)
