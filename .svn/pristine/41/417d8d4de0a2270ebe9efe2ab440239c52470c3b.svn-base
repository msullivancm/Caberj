#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'TOPCONN.CH'
#INCLUDE 'UTILIDADES.CH'

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABA046   ºAutor  ³Leonardo Portella   º Data ³  06/09/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Exportacao de arquivo TXT de reciprocidade para a CABESP.   º±±
±±º          ³Obs: Comentarios ao lado de cada linha retirados do layout. º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³CABERJ                                                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/   

User Function CABA046

Private cPath	 	:= "\Leonardo\RECIPROCIDADE_CABESP\"
Private cPerg		:= 'CABA046'
Private cAlias 		:= GetNextAlias()
Private oProcess    := Nil  
Private cHoraMin	:= Left(Time(),2) + Substr(Time(),4,2)
Private cHoraInicio	:= ""
Private aArqXTpReg	:= {}
Private cMsg		:= ""
Private cElapsed	:= ""
Private cHoraInicio	:= ""

AjustaSX1() 

Pergunte(cPerg,.F.)

nOpca := 0

aSays := {}
aAdd(aSays, 'Este programa ira gerar arquivos texto, agrupados por RDA, conforme'   )
aAdd(aSays, 'o layout definido pela CABESP.')

aButtons := {}
aAdd(aButtons, { 1,.T.,{|| nOpca:= 1, FechaBatch()}} )
aAdd(aButtons, { 2,.T.,{|| FechaBatch() }} )
aAdd(aButtons, { 5,.T.,{|| Pergunte(cPerg,.T.) }} )
 
FormBatch("Gera‡„o de Arquivo Texto",aSays,aButtons,,240,450)

If nOpca == 1
	cHoraInicio := Time() // Armazena hora de inicio do processamento

    If(MsgYesNo('Reinicia parametro MV_SEQREC para o valor 1?'),PutMv('MV_SEQREC',1),)

	ProcMult("ProcTxt()","Processando...")         

	LogErros(cMsg, 'Estatisticas...')

EndIf

Return

*********************************************************************************************************************************

Static Function ProcTxt

Local n_K := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

Local cQuery 		:= ""

Private nCont 		:= 0
Private nQtdArqs 	:= 0
Private cTot		:= ""

oSayT:SetText("Coletando informações...")
IniMProc('T')

oSay1:SetText('Registro tipo 01...')
oSay2:SetText('Registro tipo 02...')
oSay3:SetText('Registro tipo 03...')
oSay4:SetText('Registro tipo 04...')
oSay5:SetText('Registro tipo 05...')
oSay6:SetText('Registro tipo 06...')

IncMProc('T',0,"Processando...")  

oProcess:Refresh()

GetDRefresh()

//BTF - CABECALHO EVENTUAL
//BTO - ITENS INTERCAMBIO EVENTUAL
cQuery += "SELECT DISTINCT BTO_OPEORI,BTO_CODOPE,BTO_NUMERO"									+ CRLF
cQuery += "FROM " + RetSqlName('BTF') + " BTF" 						   							+ CRLF
cQuery += "INNER JOIN " + RetSqlName('BTO') + " BTO ON BTO.D_E_L_E_T_ = ' '" 					+ CRLF
cQuery += "  AND BTO_FILIAL = '" + xFilial('BTO') + "'" 										+ CRLF
cQuery += "  AND BTO_CODOPE = BTF_CODOPE" 	  													+ CRLF
cQuery += "  AND BTO_NUMERO = BTF_NUMERO" 														+ CRLF
cQuery += "  AND BTO_STATUS = '1'" 																+ CRLF
cQuery += "WHERE BTF_FILIAL = '" + xFilial('BTF') + "'"    										+ CRLF
cQuery += "  AND BTF.D_E_L_E_T_ = ' '" 									 						+ CRLF
cQuery += "  AND BTF_CODOPE BETWEEN '" + mv_par01 + "' AND '" + mv_par02 + "'"					+ CRLF
cQuery += "  AND BTF_NUMERO BETWEEN '" + mv_par03 + "' AND '" + mv_par04 + "'"					+ CRLF
cQuery += "  AND BTO_OPEORI = '1008'" /*CABESP*/							 					+ CRLF

TcQuery cQuery New Alias cAlias

COUNT TO nCont
            
cTot := allTrim(Transform(nCont,'@E 999,999,999'))
              
oMeterT:SetTotal(nCont)

nCont := 0

cAlias->(DbGoTop()) 

While !cAlias->(EOF())
      
    ++nCont
    
    oSayT:SetText('Processando... ' + allTrim(Transform(nCont,'@E 999,999,999')) + ' de ' + cTot + ' - Arquivos gerados: ' + allTrim(Transform(nQtdArqs,'@E 999,999,999'))) 
    
    aAreaOri := GetArea()
    
    //TIPO DE REGISTRO 01 - PEG
	TipoReg01(cAlias->(BTO_OPEORI),cAlias->(BTO_CODOPE) + cAlias->(BTO_NUMERO),cAlias->(BTO_CODOPE))
	
	RestArea(aAreaOri)
	
	IncMProc('T',nCont,'Processando... ' + allTrim(Transform(nCont,'@E 999,999,999')) + ' de ' + cTot)
	
	cAlias->(DbSkip())
	
EndDo

cAlias->(DbCloseArea()) 

cElapsed  	:= ElapTime(cHoraInicio,Time())  
	
cMsg := 'Geração de arquivos CABESP concluída!' + CRLF + CRLF + 'Arquivos gerados: ' + cValToChar(nQtdArqs) + CRLF + CRLF + 'Tempo decorrido: ' + cElapsed + CRLF + CRLF

For n_K := 1 to len(aArqXTpReg)

	 cMsg += ' - ' + aArqXTpReg[n_K][1] + CRLF
	 cMsg += '   ' + If(aArqXTpReg[n_K][2][2] > 0,'* ','- ')  + 'Registros tipo ' + aArqXTpReg[n_K][2][1]  + ' : ' + cValToChar(aArqXTpReg[n_K][2][2])  + CRLF//01
	 cMsg += '   ' + If(aArqXTpReg[n_K][2][4] > 0,'* ','- ')  + 'Registros tipo ' + aArqXTpReg[n_K][2][3]  + ' : ' + cValToChar(aArqXTpReg[n_K][2][4])  + CRLF//02
	 cMsg += '   ' + If(aArqXTpReg[n_K][2][6] > 0,'* ','- ')  + 'Registros tipo ' + aArqXTpReg[n_K][2][5]  + ' : ' + cValToChar(aArqXTpReg[n_K][2][6])  + CRLF//03
	 cMsg += '   ' + If(aArqXTpReg[n_K][2][8] > 0,'* ','- ')  + 'Registros tipo ' + aArqXTpReg[n_K][2][7]  + ' : ' + cValToChar(aArqXTpReg[n_K][2][8])  + CRLF//04
	 cMsg += '   ' + If(aArqXTpReg[n_K][2][10] > 0,'* ','- ') + 'Registros tipo ' + aArqXTpReg[n_K][2][9]  + ' : ' + cValToChar(aArqXTpReg[n_K][2][10]) + CRLF//05
	 cMsg += '   ' + If(aArqXTpReg[n_K][2][12] > 0,'* ','- ') + 'Registros tipo ' + aArqXTpReg[n_K][2][11] + ' : ' + cValToChar(aArqXTpReg[n_K][2][12]) + CRLF//06
	 cMsg += CRLF 

Next

oProcess:End() 
          
Return                

**************************************************************************************************************************

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³TIPO DE REGISTRO 01 - PEG³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Static Function TipoReg01(cOpeOri,cNumFat,cOperad)
                              
Local cQry 			:= "" 
Local nContLin		:= 0
Local cAliasTp01 	:= GetNextAlias()
Local nSeq			:= 0
Local cSequencial	:= ""

Private cNomeArq	:= ""

//BDH - Usuarios Participacao
cQry += "SELECT DISTINCT BD5_CODRDA, BD5_CODPEG, BD5_NUMIMP, BD5_NUMERO, BD5_CODEMP, BD5_MATRIC, BD5_TIPREG," 		+ CRLF
cQry += "  BD5_NOMRDA, BD5_VLRTPF, BD5_VLRTAD,  BD5_CODOPE, BD5_CODLDP, BD5_NOMUSR, BD5_DIGITO, BD5_DATPRO," 		+ CRLF
cQry += "  BD5_ORIMOV, COUNT(*) OVER(PARTITION BY BD5_CODPEG) QTD_GUIAS_PEG, "								 		+ CRLF
cQry += "  SUM(BD5_VLRPAG) OVER(PARTITION BY BD5_CODPEG) VLR_NA_PEG" 												+ CRLF
cQry += "FROM " + RetSqlName('BDH') + " BDH" 																		+ CRLF
cQry += "INNER JOIN " + RetSqlName('BD5') + " BD5 ON BD5.D_E_L_E_T_ = ' '" 											+ CRLF
cQry += "  AND BD5_FILIAL = '" + xFilial('BD5') + "'" 																+ CRLF
cQry += "  AND BD5_OPEUSR = BDH_CODINT" 																			+ CRLF
cQry += "  AND BD5_CODEMP = BDH_CODEMP" 																			+ CRLF
cQry += "  AND BD5_MATRIC = BDH_MATRIC" 																			+ CRLF
cQry += "  AND BD5_TIPREG = BDH_TIPREG" 																			+ CRLF
cQry += "  AND BD5_ANOPAG = BDH_ANOFT" 																				+ CRLF
cQry += "  AND BD5_MESPAG = BDH_MESFT" 																				+ CRLF
cQry += "  AND BD5_SEQPF =  BDH_SEQPF" 																				+ CRLF
cQry += "  AND BD5_NUMSE1 = BDH_NUMSE1" 																			+ CRLF
cQry += "INNER JOIN " + RetSqlName('BA1') + " BA1 ON BA1.D_E_L_E_T_ = ' '" 											+ CRLF
cQry += "  AND BA1_FILIAL = '" + xFilial('BA1') + "'" 																+ CRLF
cQry += "  AND BA1_CODINT = BDH_CODINT" 																			+ CRLF
cQry += "  AND BA1_CODEMP = BDH_CODEMP" 																			+ CRLF
cQry += "  AND BA1_MATRIC = BDH_MATRIC" 																			+ CRLF
cQry += "  AND BA1_TIPREG = BDH_TIPREG" 																			+ CRLF
cQry += "WHERE BDH.D_E_L_E_T_ = ' '" 																				+ CRLF
cQry += "  AND BDH_OPEFAT = '" + cOpeOri + "'" 	 																	+ CRLF
cQry += "  AND BDH_NUMFAT = '" + cNumFat + "'"				  														+ CRLF
cQry += "  AND BDH_OPEORI = '" + cOpeOri + "'" 					 													+ CRLF
cQry += "  AND BDH_CODINT = '" + cOperad + "'" 				   								  						+ CRLF
                                                     
//cQry += "  AND ROWNUM <= 20"	+ CRLF
 
cQry += "ORDER BY BD5_CODRDA, BD5_CODPEG, BD5_NUMIMP, BD5_NOMUSR"													+ CRLF

TcQuery cQry New Alias cAliasTp01

COUNT TO nContLin

cTot1 	:= allTrim(Transform(nContLin,'@E 999,999,999'))
           
IniMProc('1')
oMeter1:SetTotal(nContLin)

nContLin 	:= 0
	
cAliasTp01->(DbGoTop())

cRdaAnt 	:= ""         

While !cAliasTp01->(EOF())
    
    cRdaAnt 	:= cAliasTp01->(BD5_CODRDA)
    
    nSeq		:= GetMv('MV_SEQREC')
	cSequencial	:= StrZero(nSeq,20)

	PutMv('MV_SEQREC',(nSeq + 1) )

    cNomeArq 	:= cAliasTp01->(BD5_CODRDA) + '_' + DtoS(Date()) + '_' + cSequencial + ".txt"
    
    aAdd(aArqXTpReg,{cNomeArq,{'01',0,'02',0,'03',0,'04',0,'05',0,'06',0}})
	
    ++nQtdArqs
    
	oSayT:SetText('Processando... ' + allTrim(Transform(nCont,'@E 999,999,999')) + ' de ' + cTot + ' - Arquivos gerados: ' + allTrim(Transform(nQtdArqs,'@E 999,999,999'))) 
    
    //1 arquivo para cada prestador
	nHandle 	:= FCREATE(cPath + cNomeArq)
	
	cPEGAnt 	:= ""

	While !cAliasTp01->(EOF()) .and. cRdaAnt == cAliasTp01->(BD5_CODRDA)

        oSay1:SetText('Registro tipo 01: ' + allTrim(Transform(++nContLin,'@E 999,999,999')) + ' de ' + cTot1)
        
        If ( nPosArqArr := aScan(aArqXTpReg,{|x|x[1] == cNomeArq}) ) > 0
        	If ( nPosTip := aScan(aArqXTpReg[nPosArqArr][2],'01') ) > 0
				aArqXTpReg[nPosArqArr][2][nPosTip + 1]	 := aArqXTpReg[nPosArqArr][2][nPosTip + 1] + 1        	
        	EndIf
        EndIf

        If cPEGAnt != cAliasTp01->(BD5_CODPEG)

			cLine := '01' //Tipo do Registro

			cLine += PadL(If(cEmpAnt == '01','324361','415774'),14,'0')//Codigo do Recebedor

			cLine += Space(2)//Regime de Atendimento

			cLine += StrZero(cAliasTp01->(QTD_GUIAS_PEG),6)//Quantidade de Guias

			cLine += StrZero(cAliasTp01->(VLR_NA_PEG) * (10 ^ TamSX3('BD5_VLRPAG')[2]),12)//Valor Total do PEG

			cLine += StrZero(Val(cAliasTp01->(BD5_CODPEG)),9)//Numero do PEG

			cLine += StrZero(Day(dDataBase),2) + StrZero(Month(dDataBase),2) + cValToChar(Year(dDataBase))//Data de geracao do arquivo

			cLine += cHoraMin//Hora da geracao do arquivo

			cLine += StrZero(Val(cAliasTp01->(BD5_NUMIMP)),20)//Numero da Nota Fiscal 

			cPEGAnt := cAliasTp01->(BD5_CODPEG)

			FWRITE(nHandle,cLine + CRLF)

		EndIf

		aAreaTR1 := cAliasTp01->(GetArea())

		//TIPO DE REGISTRO 02 - GUIA
		TipoReg02(cAliasTp01->(BD5_CODOPE),cAliasTp01->(BD5_CODLDP),cAliasTp01->(BD5_CODPEG),cAliasTp01->(BD5_NUMERO))

		RestArea(aAreaTR1)

		cAliasTp01->(DbSkip())

		IncMProc('1',nContLin,'Registro tipo 01: ' + allTrim(Transform(nContLin,'@E 999,999,999')) + ' de ' + cTot1)		

	EndDo

	FCLOSE(nHandle)
	FT_FUSE() 

EndDo

cAliasTp01->(DbCloseArea())

Return

**************************************************************************************************************************
           
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³TIPO DE REGISTRO 02 - GUIA³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Static Function TipoReg02(cOper,cLocalDig,cPEG,cNumero)

Local cQryTmp02		:= "" 
Local nContLin2		:= 0
Local cAliasTp02 	:= GetNextAlias()

cQryTmp02 := "SELECT DECODE(BD5_TIPGUI,'01','10','02','20','03','30','04','40','  ') TIPGUIA,BD5_NUMERO,NVL(BE4_NUMERO,BD5_NUMIMP) GUIA_PRINC," 	+ CRLF
cQryTmp02 += "	BE4_SENHA,BD5_DATPRO,BD5_HORPRO,BD5_OPEUSR||BD5_CODEMP||BD5_MATRIC||BD5_TIPREG||BD5_DIGITO MATRIC,BE4_DATPRO,BE4_HORPRO,BE4_TIPALT,"+ CRLF
cQryTmp02 += "	BE4_HRALTA,BE4_DTALTA,BE4_GRPINT,BE4_TIPADM,BE4_REGINT,BE4_CID,BE4_NASVPR,BE4_CIDSEC,BE4_CID3,BE4_CID4,BE4_CID5,BE4_NRDCOB,"		+ CRLF
cQryTmp02 += "	BE4_TIPFAT,BD5_TIPATE,BD5_INDACI,BD5_TIPSAI,BD5_TIPDOE,BD5_TPODOE,BD5_UTPDOE,BD5_TIPCON,BD5_REGEXE,BD5_ESTEXE,BD5_SIGEXE,"			+ CRLF
cQryTmp02 += "	BD5_OPEEXE,BD5_CODRDA,BD5_CODESP,BD5_OPELOT,BD5_NUMLOT,BD5_SITUAC,BD5_OPEUSR,BD5_CODEMP,BD5_MATRIC,BD5_TIPREG,BD5_ESTSOL,"			+ CRLF
cQryTmp02 += "	BD5_REGSOL,BD5_SIGLA,BD5_OPESOL,BD5_INDCLI,BD5_CODEMP,BD5_NOMUSR,BD5_DIGITO,BD5_CODOPE,BD5_CODLDP,BD5_CODPEG,BD5_NUMIMP,BE4_PADINT,"+ CRLF
cQryTmp02 += "	BD5_VLRPAG,BA1_YMTREP"																												+ CRLF
cQryTmp02 += "FROM " + RetSqlName('BD5') + " BD5"																				  					+ CRLF
cQryTmp02 += "INNER JOIN " + RetSqlName('BA1') + " BA1 ON BA1.D_E_L_E_T_ = ' '" 														 			+ CRLF 
cQryTmp02 += "  AND BA1_FILIAL = '" + xFilial('BA1') + "'" 																							+ CRLF
cQryTmp02 += "  AND BA1_CODINT = BD5_OPEUSR" 																										+ CRLF
cQryTmp02 += "  AND BA1_CODEMP = BD5_CODEMP" 																										+ CRLF
cQryTmp02 += "  AND BA1_MATRIC = BD5_MATRIC" 																										+ CRLF
cQryTmp02 += "  AND BA1_TIPREG = BD5_TIPREG" 																										+ CRLF
cQryTmp02 += "  AND BA1_DIGITO = BD5_DIGITO" 																										+ CRLF
cQryTmp02 += "LEFT JOIN " + RetSqlName('BE4') + " BE4 ON BE4.D_E_L_E_T_ = ' '" 															 			+ CRLF 
cQryTmp02 += "  AND BE4_FILIAL = '" + xFilial('BE4') + "'" 																							+ CRLF
cQryTmp02 += "  AND BE4_CODOPE||BE4_CODLDP||BE4_CODPEG||BE4_NUMERO = BD5_GUIINT"																	+ CRLF
cQryTmp02 += "  AND BD5_TIPGUI <> '01'" 																											+ CRLF
cQryTmp02 += "WHERE BD5.D_E_L_E_T_ = ' '"								 																			+ CRLF
cQryTmp02 += "	AND BD5_FILIAL = '" + xFilial('BD5') + "'" 	 																						+ CRLF 
//cQryTmp02 += "  AND BD5_TIPGUI <> '01'" 																											+ CRLF
cQryTmp02 += "	AND BD5_CODOPE = '" + cOper + "'" 			   	 																					+ CRLF
cQryTmp02 += "	AND BD5_CODLDP = '" + cLocalDig + "'"  			 																					+ CRLF
cQryTmp02 += "	AND BD5_CODPEG = '" + cPEG + "'"   																									+ CRLF
cQryTmp02 += "	AND BD5_NUMERO = '" + cNumero + "'"  																								+ CRLF
                                                                                                	
//cQryTmp02 += "	AND ROWNUM <= 20"  							+ CRLF

cQryTmp02 += "ORDER BY BD5_NUMERO" 																						 							+ CRLF

TcQuery cQryTmp02 New Alias cAliasTp02
              
COUNT TO nContLin2

cTot2 		:= allTrim(Transform(nContLin2,'@E 999,999,999'))
        
IniMProc('2')
oMeter2:SetTotal(nContLin2)   

nContLin2 	:= 0

cAliasTp02->(DbGoTop())
                          
While !cAliasTp02->(EOF())
    
    oSay2:SetText('Registro tipo 02: ' + allTrim(Transform(++nContLin2,'@E 999,999,999')) + ' de ' + cTot2)
    
    If ( nPosArqArr := aScan(aArqXTpReg,{|x|x[1] == cNomeArq}) ) > 0
    	If ( nPosTip := aScan(aArqXTpReg[nPosArqArr][2],'02') ) > 0
			aArqXTpReg[nPosArqArr][2][nPosTip + 1]	 := aArqXTpReg[nPosArqArr][2][nPosTip + 1] + 1        	
       	EndIf
    EndIf
        
    cLine := '02'//Tipo do Registro
	
	cLine += cAliasTp02->(TIPGUIA)//Modelo de guia
	
	cLine += StrZero(Val(cAliasTp02->(BD5_NUMIMP)),20)//Numero da guia   
	
	cLine += StrZero(Val(cAliasTp02->(GUIA_PRINC)),20)//Numero da guia principal
	
	cLine += If(!empty(cAliasTp02->(BE4_SENHA)),StrZero(Val(cAliasTp02->(BE4_SENHA)),20),Space(20))//Autorizacao
	
	cLine += Right(cAliasTp02->(BD5_DATPRO),2) + Substr(cAliasTp02->(BD5_DATPRO),5,2) + Left(cAliasTp02->(BD5_DATPRO),4)//Data de emissao da guia
	
	cLine += Left(AllTrim(cAliasTp02->(BA1_YMTREP)),16)//Codigo do beneficiario - BA1_YMTREP : Matricula Repasse
	
	cLine += Right(cAliasTp02->(BD5_DATPRO),2) + Substr(cAliasTp02->(BD5_DATPRO),5,2) + Left(cAliasTp02->(BD5_DATPRO),4)//Data de atendimento
	
	cLine += cAliasTp02->(BD5_HORPRO)//Hora do atendimento	
    
    If !empty(cAliasTp02->(BE4_DATPRO))
    	cDtHrIniInt := Right(cAliasTp02->(BE4_DATPRO),2) + Substr(cAliasTp02->(BE4_DATPRO),5,2) + Left(cAliasTp02->(BE4_DATPRO),4) + cAliasTp02->(BE4_HORPRO)
    Else
    	cDtHrIniInt := Space(12)
    EndIf
    
    cLine += cDtHrIniInt//Data/Hora Inicial da Internacao            
	
	If !empty(cAliasTp02->(BE4_DTALTA))
    	cDtHrFimInt := Right(cAliasTp02->(BE4_DTALTA),2) + Substr(cAliasTp02->(BE4_DTALTA),5,2) + Left(cAliasTp02->(BE4_DTALTA),4) + cAliasTp02->(BE4_HRALTA)
    Else
    	cDtHrFimInt := Space(12)
    EndIf
    
    cLine += cDtHrFimInt//Data/Hora Alta da Internacao

	If cAliasTp02->(BE4_GRPINT) == '2'//1=Internacao Clinica;2=Internacao Cirurgica;3=Internacao Obstetrica;4=Internacao Pediatrica;5=Internacao Psiquiatrica           

		If !empty(cAliasTp02->(BE4_DATPRO))
	    	cDtHrIniInt := Right(cAliasTp02->(BE4_DATPRO),2) + Substr(cAliasTp02->(BE4_DATPRO),5,2) + Left(cAliasTp02->(BE4_DATPRO),4) + cAliasTp02->(BE4_HORPRO)
	    Else
	    	cDtHrIniInt := Space(12)
	    EndIf

	    cIntCir := cDtHrIniInt//Data/Hora Inicial da Internacao            

		If !empty(cAliasTp02->(BE4_DTALTA))
	    	cDtHrFimInt := Right(cAliasTp02->(BE4_DTALTA),2) + Substr(cAliasTp02->(BE4_DTALTA),5,2) + Left(cAliasTp02->(BE4_DTALTA),4) + cAliasTp02->(BE4_HRALTA)
	    Else
	    	cDtHrFimInt := Space(12)
	    EndIf

	    cIntCir += cDtHrFimInt

    Else
		cIntCir := Space(24)     
    EndIf

	cLine += cIntCir//Data/Hora - Inicio da Cirurgia *** Data/Hora - Final da Cirurgia 

	//BDR: 4 = EMERGENCIA - RISCO DE VIDA, 5 = URGENCIA - SEM RISCO DE VIDA - PASSIVEL DE REMOCAO, 6 = ELETIVA / PROGRAMADA / ROTINA                                         
	If cAliasTp02->(BE4_TIPADM) $ '4|5'
		cCarInt := 'U'
	ElseIf cAliasTp02->(BE4_TIPADM) == '6'
		cCarInt := 'E'
	Else
		cCarInt := Space(1)
	EndIf

	cLine += cCarInt//Carater da Internacao 
	
	//BI4: Tipos de acomodacao - 1 = APARTAMENTO, 2 = COLETIVO                     
	cLine += If(!empty(cAliasTp02->(BE4_PADINT)),StrZero(Val(cAliasTp02->(BE4_PADINT)),2),Space(2))//Tipo de acomodacao na Internacao - TISS Ok
                            
 	//1=Internacao Clinica;2=Internacao Cirurgica;3=Internacao Obstetrica;4=Internacao Pediatrica;5=Internacao Psiquiatrica   
	cLine += If(!empty(cAliasTp02->(BE4_GRPINT)),cAliasTp02->(BE4_GRPINT),Space(1))//Codigo do tipo da Internacao - TISS Ok

	//1=Hospitalar;2=Hospital-Dia;3=Domiciliar                                                                                      
	cLine += If(!empty(cAliasTp02->(BE4_REGINT)),cAliasTp02->(BE4_REGINT),Space(1))//Codigo do regime da Internacao - TISS Ok
	                  
	cLine += If(!empty(cAliasTp02->(BE4_NASVPR)),StrZero(Val(cAliasTp02->(BE4_NASVPR)),2),Replicate('0',2))//Quantidade de nascidos vivos prematuros
	
	cLine += PadR(allTrim(cAliasTp02->(BE4_CID)),5)//Codigo CID Principal
	
	cLine += PadR(allTrim(cAliasTp02->(BE4_CIDSEC)),5)//Codigo do CID 10 do segundo diagnostico

	cLine += PadR(allTrim(cAliasTp02->(BE4_CID3)),5)//Codigo do CID 10 do terceiro diagnostico
	
	cLine += PadR(allTrim(cAliasTp02->(BE4_CID4)),5)//Codigo do CID 10 do quarto diagnostico
     
	//BIY
	cLine += StrZero(Val(cAliasTp02->(BE4_TIPALT)),2)//Motivo da saida (Internacao) - TISS  
	
	//BIY: 44 = Obito de parturiente, com necropsia, com permanencia do recem nascido; 54 = Obito de parturiente, com necropsia, com permanencia do recem n       
    If cAliasTp02->(BE4_CID4) $ '44|54"

		Do Case
		
			Case !empty(cAliasTp02->(BE4_CID5))	
				cCidObito := PadR(allTrim(cAliasTp02->(BE4_CID5)),5)	
				
			Case !empty(cAliasTp02->(BE4_CID4))	
				cCidObito := PadR(allTrim(cAliasTp02->(BE4_CID4)),5)	

			Case !empty(cAliasTp02->(BE4_CID3))	
				cCidObito := PadR(allTrim(cAliasTp02->(BE4_CID3)),5)	

			Case !empty(cAliasTp02->(BE4_CIDSEC))	
				cCidObito := PadR(allTrim(cAliasTp02->(BE4_CIDSEC)),5)	
				
			Case !empty(cAliasTp02->(BE4_CID))	
				cCidObito := PadR(allTrim(cAliasTp02->(BE4_CID)),5)	
				
			Otherwise
				cCidObito := Space(5)
		
		EndCase    
        
		cNumObito := Left(cAliasTp02->(BE4_NRDCOB),5)
		
    Else
    	cCidObito := Space(5)
    	cNumObito := Space(5)
    EndIf
    
    cLine += cCidObito//Codigo internacional de Doenca responsavel pelo obito do paciente
             
    cLine += cNumObito//Numero da declaracao de obito do paciente Internacao
    
    //T=Total;P=Parcial                                                                                                               
    cLine += cAliasTp02->(BE4_TIPFAT)//Indica se o faturamento eh do tipo parcial ou total - TISS Ok
     
    //01=Remocao;02=Peq Cirurgia;03=Terapia;04=Consulta;05=Exame;06=Atend Domic;07=SADT Intern;08=Quimioterapia;09=Radioterapia;10=TRS
	cLine += StrZero(Val(cAliasTp02->(BD5_TIPATE)),2)//Codigo do tipo de atendimento - TISS Ok
	 
	//0=Relacionado ao Trabalho;1=Acidente de Transito;2=Outros Acidentes
	cLine += cAliasTp02->(BD5_INDACI)//Indica se houver acidente ou doenca relacionado a Trabalho, acidente de transito e outros acidentes - TISS Ok

	//1=Retorno;2=Retorno com SADT;3=Referencia;4=Internacao;5=Alta;6=Obito                                                                                                                      
	cLine += cAliasTp02->(BD5_TIPSAI)//Codigo do tipo de saida SP/SADT - TISS Ok

	//A=Aguda;C=Cronica                                                                                                               
	cLine += cAliasTp02->(BD5_TIPDOE)//Codigo do tipo de doenca - TISS
	                                                                  
	cLine += StrZero(cAliasTp02->(BD5_TPODOE),2)//Tempo de doenca referido pelo paciente
    
	//A=Anos;M=Meses;D=Dias                                                                                                           
	cLine += cAliasTp02->(BD5_UTPDOE)//Unidade do tempo de doenca referido pelo paciente 
    
	//1=Primeira;2=Seguimento;3=Pre-Natal                                                                                             
	cLine += cAliasTp02->(BD5_TIPCON)//Codigo do tipo de consulta - TISS 
	
	//1=Retorno;2=Retorno com SADT;3=Referencia;4=Internacao;5=Alta
	cLine += If(cAliasTp02->(BD5_TIPSAI) == '6',Space(1),cAliasTp02->(BD5_TIPSAI))//Codigo do tipo de saida consulta - TISS	
                                       
	cLine += StrZero(Val(Posicione("BB0",4,xFilial("BB0") + cAliasTp02->( BD5_ESTEXE + BD5_REGEXE + BD5_SIGEXE + BD5_OPEEXE),"BB0_CODIGO")),14)//Codigo na operadora CONTRATADO/EXECUTANTE (Codigo do prestador executor)    
           
	cLine += PadR(allTrim(Posicione("BB0",4,xFilial("BB0") + cAliasTp02->( BD5_ESTEXE + BD5_REGEXE + BD5_SIGEXE + BD5_OPEEXE),"BB0_NOME")),70)//Nome do profissional executante/complementar
     
    //SX5: X5_TABELA = 'B7'
    cLine += PadR(allTrim(cAliasTp02->(BD5_SIGEXE)),7)//Sigla do conselho profissional do executante - TISS
    
    cLine += StrZero(Val(cAliasTp02->(BD5_REGEXE)),15)//Numero de cadastro do profissional executante na entidade de conselho
    
	cLine += cAliasTp02->(BD5_ESTEXE)//Sigla da Unidade Federativa do Conselho Profissional do executante
	
	cLine += Posicione('BAQ',1,xFilial('BAQ') + cAliasTp02->(BD5_CODEMP + BD5_CODESP),'BAQ_CBOS')//Codigo da especialidade de atendimento do executor, conforme tabelas de dominio CBO-S - TISS
	         
	cTipoPart := Posicione('BD7',10,cAliasTp02->(BD5_OPELOT + BD5_NUMLOT + BD5_SITUAC + BD5_OPEUSR + BD5_CODEMP + BD5_MATRIC + BD5_TIPREG),'BD7_CODTPA')
	
	//BWT: Tipo de participacao
	cLine += Posicione('BWT',1,xFilial('BWT') + BD5_CODOPE + cTipoPart,'BWT_CODEDI')//Grau de Participacao - TISS
	
	cLine += StrZero(Val(Posicione("BB0",4,xFilial("BB0") + cAliasTp02->( BD5_ESTSOL + BD5_REGSOL + BD5_SIGLA + BD5_OPESOL ),"BB0_CODIGO")),14)//Codigo na operadora SOLICITANTE

	cLine += PadR(allTrim(Posicione("BB0",4,xFilial("BB0") + cAliasTp02->( BD5_ESTSOL + BD5_REGSOL + BD5_SIGLA + BD5_OPESOL ),"BB0_NOME")),70)//Nome do profissional solicitante

	//SX5: X5_TABELA = 'B7'
    cLine += PadR(allTrim(cAliasTp02->(BD5_SIGLA)),7)//Sigla do conselho profissional do solicitante - TISS
    
    cLine += StrZero(Val(cAliasTp02->(BD5_REGSOL)),15)//Numero de cadastro do profissional solicitante na entidade de conselho
    
    cLine += cAliasTp02->(BD5_ESTSOL)//Sigla da Unidade Federativa do Conselho Profissional do solicitante
    
    //Nao temos atualmente como informar o CBO-S do solicitante
    cLine += Space(5)//Codigo da especialidade de atendimento do solicitante - TISS
    
	cLine += Left(cAliasTp02->(BD5_INDCLI),70)//Indicacao clinica
    
	cLine += StrZero(cAliasTp02->(BD5_VLRPAG) * (10 ^ TamSx3('BD5_VLRPAG')[2]),12)//Valor total da guia  

	cQryTipo := "SELECT TIPO_PROC,SUM(BD6_VLRMAN) VLR_TOT_TIPO" 						+ CRLF
	cQryTipo += "FROM" 																	+ CRLF
	cQryTipo += "(" 																	+ CRLF
	cQryTipo += "  SELECT DECODE(BR8_TPPROC,'0','PROCEDIMENTOS','7','GASES','2','MEDICAMENTO','1','MATERIAIS','6','MATERIAIS','3','TAXAS-ALUGUEIS','8','TAXAS-ALUGUEIS','5','OPME','4','DIARIAS','-') TIPO_PROC,BD6_VLRMAN" + CRLF
	cQryTipo += "  FROM " + RetSqlName('BD6') + " BD6" 									+ CRLF
	cQryTipo += "  INNER JOIN " + RetSqlName('BR8') + " BR8 ON BR8.D_E_L_E_T_ = ' '" 	+ CRLF
	cQryTipo += "     AND BR8_FILIAL = '" + xFilial('BR8') + "'" 						+ CRLF
	cQryTipo += "     AND BR8_CODPAD = BD6_CODPAD" 										+ CRLF
	cQryTipo += "     AND BR8_CODPSA = BD6_CODPRO" 										+ CRLF
	cQryTipo += "  WHERE BD6.D_E_L_E_T_ = ' '" 											+ CRLF
	cQryTipo += "     AND BD6_FILIAL = '" + xFilial('BD6') + "'" 						+ CRLF
	cQryTipo += "     AND BD6_CODOPE = '" + cOper + "'" 								+ CRLF
	cQryTipo += "     AND BD6_CODLDP = '" + cLocalDig + "'" 							+ CRLF
	cQryTipo += "     AND BD6_CODPEG = '" + cPEG + "'" 									+ CRLF
	cQryTipo += "     AND BD6_NUMERO = '" + cNumero + "'" 								+ CRLF
	cQryTipo += ") QRY" 																+ CRLF
	cQryTipo += "GROUP BY TIPO_PROC" 													+ CRLF
	                           
	aAliasTipo 	:= GetArea()
	cAliasTipo 	:= GetNextAlias()
	aTipo 		:= {}
	nPosTipo 	:= 0    
	
	TcQuery cQryTipo New Alias cAliasTipo

	While !cAliasTipo->(EOF())
	    
		aAdd(aTipo,{cAliasTipo->TIPO_PROC,cAliasTipo->VLR_TOT_TIPO})
	    
		cAliasTipo->(DbSkip())
		
	EndDo
	
	cAliasTipo->(DbCloseArea())
	
	RestArea(aAliasTipo)
	
	cLine += If((nPosTipo := aScan(aTipo,{|x|AllTrim(x[1]) == 'GASES'})) > 0	   		,StrZero(aTipo[nPosTipo][2],12),Replicate('0',12))//Valor total dos Gases medicinais
	
	cLine += If((nPosTipo := aScan(aTipo,{|x|AllTrim(x[1]) == 'MEDICAMENTO'})) > 0	,StrZero(aTipo[nPosTipo][2],12),Replicate('0',12))//Valor total dos medicamentos
	
	cLine += If((nPosTipo := aScan(aTipo,{|x|AllTrim(x[1]) == 'MATERIAIS'})) > 0		,StrZero(aTipo[nPosTipo][2],12),Replicate('0',12))//Valor total dos materiais
	
	cLine += If((nPosTipo := aScan(aTipo,{|x|AllTrim(x[1]) == 'TAXAS-ALUGUEIS'})) > 0	,StrZero(aTipo[nPosTipo][2],12),Replicate('0',12))//Valor total das taxas/alugueis
	
	cLine += If((nPosTipo := aScan(aTipo,{|x|AllTrim(x[1]) == 'DIARIAS'})) > 0		,StrZero(aTipo[nPosTipo][2],12),Replicate('0',12))//Valor total das diarias
	
	cLine += If((nPosTipo := aScan(aTipo,{|x|AllTrim(x[1]) == 'PROCEDIMENTOS'})) > 0	,StrZero(aTipo[nPosTipo][2],12),Replicate('0',12))//Valor total dos procedimentos
	
	cLine += If((nPosTipo := aScan(aTipo,{|x|AllTrim(x[1]) == 'OPME'})) > 0			,StrZero(aTipo[nPosTipo][2],12),Replicate('0',12))//Valor total de OPME
	
	cLine += Space(200)//Observacao
	
	cLine += Space(15)//Numero no CRO da Clinica/Responsavel
	
	cLine += Space(1)//Codigo do tipo de atendimento ODONTO - TISS
	
	cLine += PadR(cAliasTp02->(BD5_NOMUSR),70)//Nome do beneficiario 
	       
	cLine += PadR(allTrim(Posicione("BB0",4,xFilial("BB0") + cAliasTp02->( BD5_ESTSOL + BD5_REGSOL + BD5_SIGLA + BD5_OPESOL ),"BB0_NOME")),70)//Nome do solicitante contratado
	
	cLine += PadR(allTrim(Posicione("BB0",4,xFilial("BB0") + cAliasTp02->( BD5_ESTEXE + BD5_REGEXE + BD5_SIGEXE + BD5_OPEEXE),"BB0_NOME")),70)//Nome do executante contratado
	
	cCodPla := Posicione('BA1',1,xFilial('BA1') + cAliasTp02->(BD5_OPEUSR + BD5_CODEMP + BD5_MATRIC + BD5_TIPREG + BD5_DIGITO),'BA1_CODPLA')
	
    cLine += Posicione('BI3',1,xFilial('BI3') + cAliasTp02->(BD5_OPEUSR) + cCodPla,'BI3_DESCRI')//Nome do plano do beneficiario
    
    FWRITE(nHandle,cLine + CRLF)
    
    aAreaTR2 := cAliasTp02->(GetArea())
    
    //TIPO DE REGISTRO 03 - EVENTO
	TipoReg03(cOper,cLocalDig,cPEG,cNumero)
    
	RestArea(aAreaTR2)
    
    cAliasTp02->(DbSkip())
    
	IncMProc('2',nContLin2,'Registro tipo 02: ' + allTrim(Transform(nContLin2,'@E 999,999,999')) + ' de ' + cTot2)		
    
EndDo

cAliasTp02->(DbCloseArea())                       

Return

**************************************************************************************************************************
      
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³TIPO DE REGISTRO 03 - EVENTO³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
     
Static Function TipoReg03(cOper,cLocalDig,cPEG,cNumero)

Local cAliasTp03 	:= GetNextAlias()
Local cQryTmp03		:= ""  
Local nContLin3		:= 0
                              
cQryTmp03 := "SELECT BD6_SEQUEN,BD6_NUMIMP,BEA_SENHA,BD6_DATPRO,BD6_HORPRO,BD6_HORFIM,BD6_CODPAD,BD6_PERHES,BD6_CODPRO,BD6_VIA,"  		+ CRLF
cQryTmp03 += "BGR_VIATIS,BD6_TECUTI,ROUND(BD6_VLRMAN/BD6_QTDPRO,2) * 100 VLR_UNIT_SEM_VIRG,ROUND(BD6_VLRMAN,2) * 100 VLR_TOT_SEM_VIRG,"	+ CRLF
cQryTmp03 += "BD6_DESPRO,BD6_QTDPRO,BR8_TPPROC,BR8_DESCRI,BR8_CLASP2,BEA_OPEMOV || BEA_ANOAUT || BEA_MESAUT || BEA_NUMAUT CHAVE_BE4,"	+ CRLF
cQryTmp03 += "BD6.R_E_C_N_O_ RECBD6"																									+ CRLF
cQryTmp03 += "FROM " + RetSqlName('BD6') + " BD6"			 																			+ CRLF
cQryTmp03 += "LEFT JOIN " + RetSqlName('BEA') + " BEA ON BEA.D_E_L_E_T_ = ' '" 															+ CRLF 
cQryTmp03 += "  AND BEA_FILIAL = '" + xFilial('BEA') + "'"			 		  															+ CRLF 
cQryTmp03 += "  AND BEA_NUMIMP = BD6_NUMIMP"							 																+ CRLF
cQryTmp03 += "LEFT JOIN " + RetSqlName('BGR') + " BGR ON BGR.D_E_L_E_T_ = ' '"															+ CRLF 
cQryTmp03 += "  AND BGR_FILIAL = '" + xFilial('BGR') + "'"			 		 															+ CRLF 
cQryTmp03 += "  AND BGR_CODINT = '" + PLSINTPAD() + "'"																					+ CRLF
cQryTmp03 += "  AND BGR_CODVIA = BD6_VIA"						  																		+ CRLF
cQryTmp03 += "INNER JOIN " + RetSqlName('BR8') + " BR8 ON BR8.D_E_L_E_T_ = ' '"															+ CRLF
cQryTmp03 += "	AND BR8_FILIAL = '" + xFilial('BR8') + "'"																				+ CRLF
cQryTmp03 += "	AND BR8_CODPAD = BD6_CODPAD"																							+ CRLF
cQryTmp03 += "	AND BR8_CODPSA = BD6_CODPRO"																							+ CRLF
cQryTmp03 += "WHERE BD6.D_E_L_E_T_ = ' '"				   																				+ CRLF
cQryTmp03 += "   AND BD6_FILIAL = '" + xFilial('BD6') + "'"	  																			+ CRLF
cQryTmp03 += "   AND BD6_CODOPE = '" + cOper + "'"			  	   																		+ CRLF
cQryTmp03 += "   AND BD6_CODLDP = '" + cLocalDig + "'"		 																			+ CRLF
cQryTmp03 += "   AND BD6_CODPEG = '" + cPEG + "'"				   																		+ CRLF
cQryTmp03 += "   AND BD6_NUMERO = '" + cNumero + "'"	  		  																		+ CRLF

//cQryTmp03 += "   AND ROWNUM < 20"				+ CRLF
      
TcQuery cQryTmp03 New Alias cAliasTp03 

COUNT TO nContLin3 

cAliasTp03->(DbGoTop())

cTot3 		:= allTrim(Transform(nContLin3,'@E 999,999,999'))

IniMProc('3')
oMeter3:SetTotal(nContLin3)   

nContLin3 	:= 0

While !cAliasTp03->(EOF())

	oSay3:SetText('Registro tipo 03: ' + allTrim(Transform(++nContLin3,'@E 999,999,999')) + ' de ' + cTot3)
	
    If ( nPosArqArr := aScan(aArqXTpReg,{|x|x[1] == cNomeArq}) ) > 0
    	If ( nPosTip := aScan(aArqXTpReg[nPosArqArr][2],'03') ) > 0
			aArqXTpReg[nPosArqArr][2][nPosTip + 1]	 := aArqXTpReg[nPosArqArr][2][nPosTip + 1] + 1        	
       	EndIf
    EndIf

    cLine := '03'//Tipo do Registro
                                                                                                          
	cLine += PadL(AllTrim(cAliasTp03->(BEA_SENHA)),8)//Senha
	         
	cDtRealEv := Right(cAliasTp03->(BD6_DATPRO),2) + Substr(cAliasTp03->(BD6_DATPRO),5,2) + Left(cAliasTp03->(BD6_DATPRO),4)
	cLine += cDtRealEv//Data de Realizacao do Evento
	
	cLine += cAliasTp03->(BD6_HORPRO)//Hora inicial da Realizacao do Evento
	
	cLine += cAliasTp03->(BD6_HORFIM)//Hora final da Realizacao do Evento
	                      
    cLine += cAliasTp03->(BD6_CODPAD)//Cod. da tabela utilizada para descrever os procedimentos - TISS

	cLine += If(cAliasTp03->(BD6_PERHES) > 0,'S','N')//Horario Especial
	
	cLine += PadL(allTrim(cAliasTp03->(BD6_CODPRO)),12)//Codigo do Evento

	cLine += Space(2)//Filler
	
	cLine += StrZero(cAliasTp03->(BD6_QTDPRO) * ( 10 ^ TamSx3('BD6_QTDPRO')[2] ),6)//Quantidade Executada   
	
	//BGR: Vias de acesso
	//U=Unica;M=Mesma Via;D=Diferentes Vias                                                                                           
	cLine += cAliasTp03->(BGR_VIATIS)//Via de acesso 
	
	//C=Convencional;V=Videolaparoscopia                                                                                              
	cLine += cAliasTp03->(BD6_TECUTI)//Tecnica utilizada 
	
	cLine += StrZero(cAliasTp03->(VLR_UNIT_SEM_VIRG),12)//Valor do Unitario Informado do Procedimento
    
	cLine += StrZero(cAliasTp03->(VLR_TOT_SEM_VIRG),12)//Valor Total Informado do Procedimento 
	
	cLine += Space(14)//Filler
	
	cLine += Space(70)//Filler
	
	cLine += Space(7)//Filler
	
	cLine += Space(15)//Filler
	
	cLine += Space(2)//Filler

	cLine += cAliasTp03->(BD6_DESPRO)//descricao do procedimento
	
	cLine += cAliasTp03->(BD6_NUMIMP)//Numero da guia
	
	cLine += StrZero(Val(cAliasTp03->(BD6_SEQUEN)),5)//Numero sequencial do procedimento
	
	FWRITE(nHandle,cLine + CRLF)
    
    //0=Procedimento;1=Material;2=Medicamento;3=Taxas;4=Diarias;5=Ortese/Protese;6=Pacote;7=Gases Medicinais;8=Alugueis               
	If cValToChar(cAliasTp03->(BR8_TPPROC)) $ '1|2|5|7'

		aAreaTR3 := cAliasTp03->(GetArea())

	    //TIPO DE REGISTRO 04 - Materiais e Medicamentos
		TipoReg04(	cAliasTp03->BD6_CODPAD				,;
					cAliasTp03->BD6_CODPRO				,;
					cAliasTp03->BD6_QTDPRO				,;
					cAliasTp03->VLR_UNIT_SEM_VIRG		,;
					cAliasTp03->VLR_TOT_SEM_VIRG		,;
					Val(cAliasTp03->BR8_TPPROC)	  		,;
					cDtRealEv							,;
					cAliasTp03->BD6_HORPRO	   			,;
					cAliasTp03->BD6_HORFIM	  			,;
					cAliasTp03->BD6_NUMIMP	   			,;
					cAliasTp03->BR8_DESCRI	   			)

		RestArea(aAreaTR3)

	EndIf
	
	aAreaTR3 := cAliasTp03->(GetArea())
	
	//Dificil termos registro do tipo 05 pois eh dificil alguem fazer um parto na reciprocidade
    
    //BR8_CLASP2 = classificacao do SIP para internacao
    If Left(AllTrim(cAliasTp03->(BR8_CLASP2)),3) == 'E13'

	    //N = Normal; C = Cesaria; O = Outros
    	cTpParto := If(allTrim(cAliasTp03->BR8_CLASP2) == 'E131','N',If(allTrim(cAliasTp03->BR8_CLASP2) == 'E132','C','O'))
    	
    	TipoReg05(cAliasTp03->BD6_CODPAD,cAliasTp03->BD6_CODPRO,cTpParto,cAliasTp03->CHAVE_BE4,cAliasTp03->BD6_NUMIMP)

    EndIf
    
    RestArea(aAreaTR3)
      
    aAreaTR3 := cAliasTp03->(GetArea())
    
    TipoReg06(cAliasTp03->RECBD6)
    
    RestArea(aAreaTR3)
    
	cAliasTp03->(DbSkip())
    
	IncMProc('3',nContLin3,'Registro tipo 03: ' + allTrim(Transform(nContLin3,'@E 999,999,999')) + ' de ' + cTot3)
	
EndDo

cAliasTp03->(DbCloseArea())

Return 

**************************************************************************************************************************

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³TIPO DE REGISTRO 04 - Materiais e Medicamentos³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Static Function TipoReg04(cTabela,cCodProc,nQtd,nVlrUnitSVirg,nVlrTotSVirg,nTipoProc,cDtRealEv,cHrIni,cHrFim,cNumGuia,cDescri)

IniMProc('4')
oMeter4:SetTotal(100)   

IncMProc('4',100,'Registro tipo 04: 1 de 1')

If ( nPosArqArr := aScan(aArqXTpReg,{|x|x[1] == cNomeArq}) ) > 0
   	If ( nPosTip := aScan(aArqXTpReg[nPosArqArr][2],'04') ) > 0
		aArqXTpReg[nPosArqArr][2][nPosTip + 1]	 := aArqXTpReg[nPosArqArr][2][nPosTip + 1] + 1        	
   	EndIf
EndIf

cLine := '04'//Tipo do Registro 

cLine += Left(cDescri,50)//Descricao

cLine += StrZero(nQtd * (10 ^ TamSx3('BD6_QTDPRO')[2]),12)//Quantidade

cLine += StrZero(nVlrUnitSVirg,12)//Valor Unitário da Despesa Informado

cLine += StrZero(nVlrTotSVirg,12)//Valor Total da Despesa Informado

//0=Procedimento;1=Material;2=Medicamento;3=Taxas;4=Diarias;5=Ortese/Protese;6=Pacote;7=Gases Medicinais;8=Alugueis        
cLine += StrZero(nTipoProc,2)//Tipo de despesa

cLine += cDtRealEv//Data de Realizacao da despesa

cLine += cHrIni//Hora inicial da Realizacao da despesa

cLine += cHrFim//Hora final da Realizacao da despesa

cLine += cTabela//Cod. da tabela utilizada para descrever os procedimentos da despesa - TISS

cLine += StrZero(Val(cCodProc),10)//Codigo da despesa

cLine += cNumGuia//Numero da guia

FWRITE(nHandle,cLine + CRLF)

Return

**************************************************************************************************************************

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³TIPO DE REGISTRO 05 - SIP ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
     
Static Function TipoReg05(cCodTab,cCodProc,cTpParto,cChaveBE4,cNumImp)
        
IniMProc('5')
oMeter5:SetTotal(100)
                 
IncMProc('5',100,'Registro tipo 05: 1 de 1')  
             
//BE4_FILIAL + BE4_CODOPE + BE4_CODLDP + BE4_CODPEG + BE4_NUMERO + BE4_SITUAC + BE4_FASE                                                                          
BE4->(DbSetOrder(1)) 
BE4->(DbGoTop()) 

//DELETAR depois do teste... 
//cChaveBE4 := '000100000003013400000018'

If BE4->(MsSeek(xFilial('BE4') + cChaveBE4))
    
    If ( nPosArqArr := aScan(aArqXTpReg,{|x|x[1] == cNomeArq}) ) > 0
    	If ( nPosTip := aScan(aArqXTpReg[nPosArqArr][2],'05') ) > 0
			aArqXTpReg[nPosArqArr][2][nPosTip + 1]	 := aArqXTpReg[nPosArqArr][2][nPosTip + 1] + 1        	
       	EndIf
    EndIf

	cLine := '05'//Tipo do Registro 
	 
	//1 - Normal; 2 - Forceps; 3 - Cesario; 4 - Outros
	cLine += If(cTpParto == 'C','3',If(cTpParto == 'N','1','4'))//PARTO
	
	//Tabela concatenada com o procedimento de UTI Neonatal
	cUTINeo := '0114500000|0181020007|0181020015|0181020023|0181020031|0181020040|0180021565|0180021573|0180021581'
    
	//1 - Nao; 2 - Sim
	cLine += If(BE4->BE4_ATENRN == '1' .and. allTrim(cCodTab) + allTrim(cCodProc) $ cUTINeo,'2','1')//ATENDIMENTO AO RECEM NASCIDO EM SALA DE PARTO
      
    //BEW_FILIAL + BEW_CODOPE + BEW_CODNAS                                                                                                                            
	cSituNas := allTrim(Posicione('BEW',1,xFilial('BE4') + BE4->BE4_CODOPE + BE4->BE4_TIPNAS,'BEW_CODNAS'))  
	
	//BEW: 5 = NASCIDO MORTO; 4 = NASCIDO VIVO A TERMO; 3 = NASCIDO VIVO PREMATURO                                                
	//CABESP: 1 - vivo prematuro; 2 - vivo a termo; 3 - morto
	cLine += If(cSituNas $ '3|4|5',cValToChar(Val(cSituNas)-2),' ')//SITUACAO DO NASCIMENTO	
	
	//Tabela concatenada com o procedimento de Recem Nascido encaminhado a UTI ou CTI
	cEncRnUti := '0114500000|0181020007|0181020015|0181020023|0181020031|0181020040|0180021565|0180021573|0180021581'
	
	//1 - Nao; 2 - Sim
	cLine += If(BE4->BE4_ATENRN == '1' .and. ( allTrim(cCodTab) + allTrim(cCodProc) ) $ cEncRnUti,'2','1')//ENCAMINHAMENTO DO RN A UTI OU CTI  
	
	//1 - Nao; 2 - Sim
	cLine += If(cSituNas == '2','2','1')//GRAVIDEZ TERMINADA EM ABORTO
	
	//1 - Nao; 2 - Sim
	cLine += If(cSituNas == '6','2','1')//TRANSTORNOS MATERNOS DECORRENTES DA GRAVIDEZ
	
	//1 - Nao; 2 - Sim
	cLine += If(cSituNas == '7','2','1')//COMPLICACOES NO PUERPERIO 
	
	cLine += Space(1)//FILLER
	
	//Informar o Codigo do CID, alinhado a esquerda, completar com brancos a direita. OBS incluir os pontos
	If cSituNas == '2'//Aborto 
		cCID := allTrim(BE4->BE4_CID)
		
		If len(cCID) > 3
			cCID := Left(Left(cCID,3) + '.' + Right(cCID,len(cCID) - 3),5)
		Else
			cCID := PadR(cCID,5)			
		EndIf
	Else
		cCID := Space(5)
	EndIf	
	
	cLine += cCID//CID ABORTO (SAM_GUIAAUTORIZ_SIP. ABORTOCID) 
	
	//1 - Nao; 2 - Sim
	cLine += If(cSituNas == '9','2','1')//Complicacaes no periodo neo natal (SAM_GUIAAUTORIZ_SIP.NEONATAL) 
	
	//1 - Nao; 2 - Sim
	cLine += If(cSituNas == '10','2','1')//Baixo peso < 2,5kg (SAM_GUIAAUTORIZ_SIP.BAIXOPESO) 

	//1 = Gravida; 2 = ate 42 dias apos termino gestacao; 3 = de 43 dias a 12 meses apos gestacao                                     
	cLine += BE4->BE4_OBTMUL//Obito em mulher (SAM_GUIAAUTORIZ_SIP.OBITOMULHER)      

	cLine += StrZero(BE4->BE4_OBTPRE,1)//Qtd obito neonatal precoce (SAM_GUIAAUTORIZ_SIP.OBITONEONATALPRECOCE) 

	cLine += StrZero(BE4->BE4_OBTTAR,1)//Qtd obito neonatal tardio (SAM_GUIAAUTORIZ_SIP.OBITONEONATALTARDIO)
    
    cLine += StrZero(BE4->BE4_NASVPR,1)//Qtd vivos prematuros (SAM_GUIAAUTORIZ_SIP.QTDVIVOSPREMATUROS)

	cLine += If(!empty(BE4->BE4_NRDCNV),BE4->BE4_NRDCNV,Space(15))//Num. decl. nasc. vivos (SAM_GUIAAUTORIZ_SIP.DECLARACAONASCIDOSVIVOS)
	
	//Nascidos vivos a termo
	cLine += If(cSituNas == '4',StrZero(BE4->BE4_NASVIV,2),'00')//Qtde. de nasc. vivos a termo (SAM_GUIAAUTORIZ_SIP. QTDNASCIDOSVIVOSTERMO)
    
    //Nascidos mortos
	cLine += If(cSituNas == '5',StrZero(BE4->BE4_NASMOR,2),'00')//Qtde. de nasc. mortos (SAM_GUIAAUTORIZ_SIP. QTDNASCIDOSMORTOS)
	
	cLine += PadL(allTrim(cNumImp),20,'0')//Numero da guia
	
	FWRITE(nHandle,cLine + CRLF)

EndIf

Return

**************************************************************************************************************************

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³TIPO DE REGISTRO 06 - EQUIPE ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Static Function TipoReg06(nRecBD6)

Local cAliasTp06 	:= GetNextAlias()
Local cQryTmp06		:= ""  
Local nContLin6		:= 0

IniMProc('6')

cQryTmp06 := "SELECT BD6_SEQUEN,BD7_CODTPA,BD6_ESTEXE,BD6_REGEXE,BD6_SIGEXE,BD6_OPEEXE,BD7_NOMPRE,BD7_SIGLA,BD7_REGPRE,BD7_ESTPRE"	+ CRLF
cQryTmp06 += "FROM " + RetSqlName('BD6') + " BD6"  							   														+ CRLF
cQryTmp06 += "INNER JOIN " + RetSqlName('BD7') + " BD7 ON BD7.D_E_L_E_T_ = ' '"												  		+ CRLF
cQryTmp06 += "  AND BD7_FILIAL = '" + xFilial('BD7') + "'"  				 														+ CRLF
cQryTmp06 += "  AND BD7_CODOPE = BD6_CODOPE"  								 														+ CRLF
cQryTmp06 += "  AND BD7_CODLDP = BD6_CODLDP"  																						+ CRLF
cQryTmp06 += "  AND BD7_CODPEG = BD6_CODPEG"				   					   													+ CRLF
cQryTmp06 += "  AND BD7_NUMERO = BD6_NUMERO"  									  													+ CRLF
cQryTmp06 += "  AND BD7_ORIMOV = BD6_ORIMOV"				  					  													+ CRLF
cQryTmp06 += "  AND BD7_CODPAD = BD6_CODPAD"  										 												+ CRLF
cQryTmp06 += "  AND BD7_CODPRO = BD6_CODPRO"  										 												+ CRLF
cQryTmp06 += "WHERE BD6.D_E_L_E_T_ = ' '"	  	   								   													+ CRLF
cQryTmp06 += "  AND BD6_FILIAL = '" + xFilial('BD6') + "'" 						  													+ CRLF
cQryTmp06 += "  AND BD6.R_E_C_N_O_ = '" + cValToChar(nRecBD6) + "'"  				 												+ CRLF

TcQuery cQryTmp06 New Alias cAliasTp06

COUNT TO nContLin6

oMeter6:SetTotal(nContLin6)

cTot6 		:= allTrim(Transform(nContLin6,'@E 999,999,999'))

nContLin6 	:= 0

cAliasTp06->(DbGoTop())

While !cAliasTp06->(EOF())                                 

    If ( nPosArqArr := aScan(aArqXTpReg,{|x|x[1] == cNomeArq}) ) > 0
    	If ( nPosTip := aScan(aArqXTpReg[nPosArqArr][2],'06') ) > 0
			aArqXTpReg[nPosArqArr][2][nPosTip + 1]	 := aArqXTpReg[nPosArqArr][2][nPosTip + 1] + 1        	
       	EndIf
    EndIf

	IncMProc('6',++nContLin6,'Registro tipo 06: ' + allTrim(Transform(nContLin6,'@E 999,999,999')) + ' de ' + cTot6)

	cLine := '06'//Tipo do Registro 
	      
	cLine += StrZero(Val(cAliasTp06->BD6_SEQUEN),5)//Informar o numero sequencial do procedimento a que se refere a equipe executante
     
    //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³TISS 2.02.03                ³³BWT                                ³
	//³00 Cirurgiao                ³³C 	CIRURGIAO                     	³
	//³01 Primeiro Auxiliar        ³³1 	1o. AUXILIAR                  	³
	//³02 Segundo Auxiliar         ³³2 	2o. AUXILIAR                  	³
	//³03 Terceiro Auxiliar        ³³3 	3o. AUXILIAR                  	³
	//³04 Quarto Auxiliar          ³³4 	4o. AUXILIAR                 	³
	//³05 Instrumentador           ³³O 	INSTRUMENTADOR                	³
	//³06 Anestesista              ³³A 	ANESTESISTA                   	³
	//³07 Auxiliar de Anestesista  ³³5 	AUXILIAR DE ANESTESISTA       	³
	//³08 Consultor                ³³                                 	³
	//³09 Perfusionista            ³³F 	PERFUSIONISTA                  	³
	//³10 Pediatra na sala de parto³³P 	PEDIATRA                       	³
	//³11 Auxiliar SADT            ³³H 	HOSPITAL/LABORATORIOS/CLINICAS	³
	//³12 Clinico                  ³³L 	CLINICO                        	³
	//³13 Intensivista             ³³                                  	³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

	cGrauPA := allTrim(cAliasTp06->BD7_CODTPA)

	Do Case

		Case cGrauPA == 'C'
			cGrauPA := '00'//Cirurgiao

		Case cGrauPA == '1'
			cGrauPA := '01'//Primeiro Auxiliar

		Case cGrauPA == '2'
			cGrauPA := '02'//Segundo Auxiliar

		Case cGrauPA == '3'
			cGrauPA := '03'//Terceiro Auxiliar

		Case cGrauPA == '4'
			cGrauPA := '04'//Quarto Auxiliar

		Case cGrauPA == 'O'
			cGrauPA := '05'//Instrumentador

		Case cGrauPA == 'A'
			cGrauPA := '06'//Anestesista

		Case cGrauPA == '5'
			cGrauPA := '07'//Auxiliar de Anestesista

		Case cGrauPA == 'F'
			cGrauPA := '09'//Perfusionista

		Case cGrauPA == 'P'
			cGrauPA := '10'//Pediatra na sala de parto

		Case cGrauPA == 'H'
			cGrauPA := '11'//Auxiliar SADT

		Case cGrauPA == 'L'
			cGrauPA := '12'//Clinico

		Otherwise
			cGrauPA := Space(2)

	EndCase

	cLine += cGrauPA//Grau de Participacao - TISS

	cLine += StrZero(Val(Posicione("BB0",4,xFilial("BB0") + cAliasTp06->(BD6_ESTEXE + BD6_REGEXE + BD6_SIGEXE + BD6_OPEEXE),"BB0_CODIGO")),14)//Codigo na operadora IDENTIFICACAO DA EQUIPE (Codigo na operadora medico executor do procedimento)

	cLine += PadR(allTrim(cAliasTp06->BD7_NOMPRE),70)//Nome do profissional participante da equipe medica 

	cLine += cAliasTp06->BD7_SIGLA//Sigla do conselho profissional do medico participante - TISS   

	cLine += StrZero(Val(cAliasTp06->BD7_REGPRE),15)//Numero de cadastro do medico participante na entidade de conselho

	cLine += cAliasTp06->BD7_ESTPRE//Sigla da Unidade Federativa do Conselho Profissional do medico participante

	cLine += Posicione("BB0",4,xFilial("BB0") + cAliasTp06->(BD6_ESTEXE + BD6_REGEXE + BD6_SIGEXE + BD6_OPEEXE),"BB0_CGC")//CPF(Informar o numero do CPF do profissional participante da equipe medica)

	cAliasTp06->(DbSkip())    

	FWRITE(nHandle,cLine + CRLF)

EndDo

cAliasTp06->(DbCloseArea())

Return

**************************************************************************************************************************

Static Function ProcMult(cFuncao,cTit)

Private nMeterT,nMeter1, nMeter2, nMeter3, nMeter4, nMeter5, nMeter6
Private oSayT, oSay1, oSay2, oSay3, oSay4, oSay5, oSay6

DEFINE DIALOG oProcess TITLE cTit FROM 095,232 TO 500,750 PIXEL STYLE DS_MODALFRAME 
  
   	oProcess:lEscClose  := .F. //cancela o sair pela tecla 'ESC'
   
   	nMeterT := 0 
   	oSayT  	:= TSay():New(05,10,,oProcess,,,,,,.T.,CLR_BLACK,CLR_WHITE,400,900)
   	oMeterT := TMeter():New(15,10,,100,oProcess,237,10,,.T.,,,.T.)
         
	oGrp1 	:= TGroup():New( 030,010,190,247,"",oProcess,CLR_BLACK,CLR_WHITE,.T.,.F. )

	nMeter1 := 0 
   	oSay1  	:= TSay():New(035,020,,oProcess,,,,,,.T.,CLR_BLACK,CLR_WHITE,400,900)
   	oMeter1 := TMeter():New(045,20,,100,oProcess,217,10,,.T.,,,.T.)

	nMeter2 := 0 
   	oSay2  	:= TSay():New(060,020,,oProcess,,,,,,.T.,CLR_BLACK,CLR_WHITE,400,900)
   	oMeter2 := TMeter():New(070,20,,100,oProcess,217,10,,.T.,,,.T.)
   	
	nMeter3 := 0 
   	oSay3  	:= TSay():New(085,020,,oProcess,,,,,,.T.,CLR_BLACK,CLR_WHITE,400,900)
   	oMeter3 := TMeter():New(095,20,,100,oProcess,217,10,,.T.,,,.T.)

	nMeter4 := 0 
   	oSay4  	:= TSay():New(110,020,,oProcess,,,,,,.T.,CLR_BLACK,CLR_WHITE,400,900)
   	oMeter4 := TMeter():New(120,20,,100,oProcess,217,10,,.T.,,,.T.)

	nMeter5 := 0 
   	oSay5  	:= TSay():New(135,020,,oProcess,,,,,,.T.,CLR_BLACK,CLR_WHITE,400,900)
   	oMeter5 := TMeter():New(145,20,,100,oProcess,217,10,,.T.,,,.T.)
   	
   	nMeter6 := 0 
   	oSay6  	:= TSay():New(160,020,,oProcess,,,,,,.T.,CLR_BLACK,CLR_WHITE,400,900)
   	oMeter6 := TMeter():New(170,20,,100,oProcess,217,10,,.T.,,,.T.)
   		                   
ACTIVATE DIALOG oProcess CENTERED ON INIT &cFuncao

Return

**************************************************************************************************************************

Static Function IncMProc(cOpcao,nQtd,cText,lEndMProc)
             
Local i := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
                                           
Default lEndMProc := .F.

oProcess:cCaption := 'Processando... Tempo decorrido: ' + ElapTime(cHoraInicio,Time())

If nQtd > 0
	oMeter&cOpcao:Set(nQtd)
Else
	For i := 1 to 5
		oMeter&cOpcao:Set(nQtd)
	Next
EndIf 

oSay&cOpcao:SetText(cText)

If !lEndMProc .and. nQtd >= oMeter&cOpcao:nTotal
	EndMProc(cOpcao)
EndIf
        
oProcess:Refresh()
	
Return

**************************************************************************************************************************

Static Function IniMProc(cOpcao)

oMeter&cOpcao:SetTotal(100)
IncMProc(cOpcao,1,'Registro tipo 0' + cOpcao + '...')

Return

**************************************************************************************************************************

Static Function EndMProc(cOpcao)

oMeter&cOpcao:SetTotal(100)
IncMProc(cOpcao,100,'Registro tipo 0' + cOpcao + '...',.T.)

Return

**************************************************************************************************************************

Static Function AjustaSX1()

Local aHelp 	:= {}
Local aArea2	:= GetArea()

aHelp := {}
aAdd(aHelp, "Informe a Operadora Inicial")
PutSX1(cPerg , "01" , "Operadora de ?" 		,"","","mv_ch1","C",TamSx3("BA1_CODINT")[1],0,0,"G",""	,"B89PLS","","","mv_par01","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe a Operadora Final")
PutSX1(cPerg , "02" , "Operadora ate ?" 	,"","","mv_ch2","C",TamSx3("BA1_CODINT")[1],0,0,"G","","B89PLS","","","mv_par02","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe o Lote de Intercambio ")
aAdd(aHelp, "Eventual Inicial")
PutSX1(cPerg,"03","Lote Int. Event.De ?"	,"","","mv_ch03","C",TamSx3("BTF_NUMERO")[1],0,1,"G","","BJ8PLS","","","mv_par03","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe o Lote de Intercambio ")
aAdd(aHelp, "Eventual Final")
PutSX1(cPerg,"04","Lote Int. Event.Ate ?"	,"","","mv_ch04","C",TamSx3("BTF_NUMERO")[1],0,1,"G","","BJ8PLS","","","mv_par04","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

RestArea(aArea2)

Return


