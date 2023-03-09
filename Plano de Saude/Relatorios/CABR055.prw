#include "PROTHEUS.CH"
#include "TOPCONN.CH"
#include "UTILIDADES.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³CABR055  ³ Autor ³Leonardo Portella     ³ Data ³ 14/09/11   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Relatorio de pessoas com carteira no periodo sem segunda   ³±±
±±³          ³ via no periodo, sem renovacao e que nao foi feita          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Advanced Protheus                                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function CABR055

Private cPerg	:= 'CABR055'

AjustaSX1()

If Pergunte(cPerg,.T.)
	Processa({|lEnd|PCABR055(@lEnd)},,,.F.)
EndIf

Return                  

*************************************************************************************************

Static Function PCABR055(lEnd)

Local i := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

LOCAL cPosTit   := alltrim(GetNewPar("MV_PLPOSTI","1")) // 1-titulos em aberto  2-titulos em aberto/baixados
LOCAL cTipAtr   := alltrim(GetNewPar("MV_PLTIPAT","2")) // 1-dias corridos  2-dias acumulados
Local cCodInt   := ""
Local cCodEmp   := ""
Local cConEmp   := ""
Local cSubCon   := ""
Local cMatrUs   := ""

Local cAlias 	:= GetNextAlias()
Local cQuery 	:= ""      

Private cSep 	:= If(mv_par03 == 1,';',',')

ProcRegua(0)

For i := 1 to 5
	IncProc('Processando...')
Next

cQuery += "SELECT BA1_DTVLCR VALID_USR,BA3_VALID VALID_FAM,BA1_DATNAS," 									  			   						+ CRLF
cQuery += "  CASE WHEN BA1_DTVLCR <= '" + DtoS(mv_par02) + "' THEN 'VALIDADE USUARIO' ELSE CASE WHEN BA3_VALID <= '" + DtoS(mv_par02) + "' THEN 'VALIDADE FAMILIA' ELSE 'AMBOS' END END CRITICA, " + CRLF
cQuery += "  BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG||BA1_DIGITO MATRIC,BA1_NOMUSR,BA1_CDIDEN ULTIMO_LOTE,BA1_CODPLA," 					+ CRLF
cQuery += "  BA1_CODINT,BA1_CODEMP,BA1_MATRIC,BA1_TIPREG,BA1_DIGITO" 																			+ CRLF
cQuery += "FROM " + RetSqlName('BA1') + " BA1"			 																						+ CRLF
cQuery += "INNER JOIN " + RetSqlName('BA3') + " BA3 ON BA3.D_E_L_E_T_ = ' '"			 														+ CRLF
cQuery += "  AND BA3_FILIAL = '" + xFilial('BA3') + "'" 																						+ CRLF
cQuery += "  AND BA3_CODINT = BA1_CODINT" 																										+ CRLF
cQuery += "  AND BA3_CODEMP = BA1_CODEMP" 																										+ CRLF
cQuery += "  AND BA3_MATRIC = BA1_MATRIC" 																										+ CRLF
cQuery += "WHERE BA1.D_E_L_E_T_ = ' '"																											+ CRLF
cQuery += "  AND BA1_FILIAL = '" + xFilial('BA1') + "'" 																						+ CRLF
cQuery += "  AND BA1_IMAGE = 'ENABLE'" 																											+ CRLF
cQuery += "  AND BA1_MOTBLO = ' '" 																												+ CRLF
cQuery += "  AND (BA1_DATBLO = ' ' OR BA1_DATBLO > '" + DtoS(mv_par02) + "' )" 																	+ CRLF
cQuery += "  AND BA1_CODEMP IN ('0001','0002','0005','0006','0010')" 																			+ CRLF
cQuery += "  AND ( BA1_DTVLCR <= '" + DtoS(mv_par02) + "' OR BA3_VALID <= '" + DtoS(mv_par02) + "')" 											+ CRLF
cQuery += "  AND BA1_CDIDEN <> 'AVULSA'" 																										+ CRLF
cQuery += "  AND (BA1_YDTLIM = ' ' OR BA1_YDTLIM > '" + DtoS(mv_par02) + "')" 																	+ CRLF
cQuery += "  AND NOT EXISTS" 																													+ CRLF
cQuery += "  (" 																																+ CRLF
cQuery += "  SELECT BED_CDIDEN" 																												+ CRLF
cQuery += "  FROM " + RetSqlName('BED')																											+ CRLF
cQuery += "  WHERE D_E_L_E_T_ = ' ' " 																											+ CRLF
cQuery += "    AND BED_FILIAL = '" + xFilial('BED') + "' "			 																			+ CRLF
cQuery += "    AND ( ( BED_DTSOLI BETWEEN '" + DtoS(mv_par01) + "' AND '" + DtoS(mv_par02) + "' ) OR "											+ CRLF
cQuery += "          ( BED_ANMSFT BETWEEN '" + Left(DtoS(mv_par01),6) + "' AND '" + Left(DtoS(mv_par02),6) + "') )" 							+ CRLF
cQuery += "    AND BED_CODINT||BED_CODEMP||BED_MATRIC||BED_TIPREG||BED_DIGITO = BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG||BA1_DIGITO" 	+ CRLF
cQuery += "    AND BED_CDIDEN <> 'AVULSA'" 																										+ CRLF
cQuery += "  )" 																																+ CRLF
cQuery += "ORDER BY BA1_CODEMP,MATRIC,BA1_NOMUSR" 																								+ CRLF

TcQuery cQuery New Alias cAlias

nQtd := 0 

COUNT TO nQtd

cTot := allTrim(Transform(nQtd,'@E 999,999,999'))

ProcRegua(nQtd)

nQtd := 0

cAlias->(DbGoTop())

cArq	:= GetTempPath() + "CABR055_" + DtoS(dDatabase) + "_" + StrTran(Time(),":","")+".CSV"
nHdl 	:= FCreate(cArq) 

cBuffer := "Valid. Usr." + cSep + "Valid. Fam." + cSep + "Data Nasc." + cSep + "Critica" + cSep + "Matr." + cSep + "Nome. Usr." + cSep + "Ultimo lote" + cSep + "Código Plano" + CRLF

FWRITE(nHdl,cBuffer,len(cBuffer))

While !cAlias->(EOF())
    
    IncProc('Processando: ' + allTrim(Transform(++nQtd,'@E 999,999,999')) + " de " + cTot)
    
    If @lEnd
		Exit    
    EndIf
                        
	nTits	:= 0
	aDadUsr := PLSDADUSR(cAlias->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO),"1",.F.,dDataBase,nil,nil,nil)

	If !aDadUsr[1]
	   cAlias->(DbSkip())
	   loop
	EndIf

	If !(cPosTit $ "1,2") // 1-titulos em aberto  2-titulos em aberto/baixados
	   cPosTit := "1"    // default = 1 porque os primeiros clientes tratavam assim
	Endif

	If !(cTipAtr $ "1,2")   // 1-Dias Corridos  2-Dias Acumulados
	   cTipAtr := "2"      // default = 2 porque os primeiros clientes tratavam assim
	Endif

	cCodCli := aDadUsr[58]
	cLoja   := aDadUsr[59]
	cNivCob	:= aDadUsr[61]

	If cPosTit == "1" // considerar apenas titulos em aberto
	    SE1->(DbSetOrder(8))
	    If SE1->(DbSeek(xFilial("SE1")+cCodCli+cLoja+"A"))
	       While ! SE1->(Eof()) .And. SE1->(E1_FILIAL+E1_CLIENTE+E1_LOJA+E1_STATUS) == xFilial("SE1")+cCodCli+cLoja+"A"
	          If dtos(dDataBase) > dtos(SE1->E1_VENCREA)
	             If ( cNivCob >= "4" .And. SE1->(E1_CODINT+E1_CODEMP+E1_MATRIC) == cCodInt+cCodEmp+cMatrUs ) .Or. ;
	                ( cNivCob <  "4" .And. SE1->(E1_CODINT+E1_CODEMP+E1_CONEMP+E1_SUBCON) == cCodInt+cCodEmp+cConEmp+cSubCon )

					If SE1->E1_PREFIXO == 'PLS'
						nTits     += 1
					EndIf

	             Endif
	          Endif
	          SE1->(DbSkip())
	       Enddo
	    Endif
	Else  // considerar titulos em aberto/baixados
	    dDatIni := dDataBase - 365 // verifica ate 1 anos atras
	    SE1->(DbSetOrder(8))
	    If SE1->(DbSeek(xFilial("SE1")+cCodCli+cLoja))
	       While ! SE1->(Eof()) .And. SE1->(E1_FILIAL+E1_CLIENTE+E1_LOJA) == xFilial("SE1")+cCodCli+cLoja
	          If dtos(dDataBase)   >  dtos(SE1->E1_VENCREA) .and. ;
	             dtos(dDatIni) <= dtos(SE1->E1_EMISSAO)
	             If ( BA3->BA3_TIPOUS == "1" .And. SE1->(E1_CODINT+E1_CODEMP+E1_MATRIC) == cCodInt+cCodEmp+cMatrUs ) .Or. ;
	                ( BA3->BA3_TIPOUS == "2" .And. SE1->(E1_CODINT+E1_CODEMP) == cCodInt+cCodEmp )

	                If  SE1->E1_SALDO > 0 .AND. SE1->E1_PREFIXO == 'PLS'
	                    nTits     += 1
	                Endif

	             Endif
	          Endif
	          SE1->(DbSkip())
	       Enddo
	    Endif
	Endif

	//Nao imprime se tiver 2 ou mais titulos em aberto
	If nTits < 2  
		cBuffer := DtoC_4DigAno(StoD(cAlias->(VALID_USR))) + cSep + DtoC_4DigAno(StoD(cAlias->(VALID_FAM))) + cSep + DtoC_4DigAno(StoD(cAlias->(BA1_DATNAS))) + cSep
		cBuffer += cAlias->(CRITICA + cSep + MATRIC + cSep + BA1_NOMUSR + cSep + ULTIMO_LOTE + cSep + BA1_CODPLA) 
		cBuffer += CRLF

		FWRITE(nHdl,cBuffer,len(cBuffer))
	EndIf

	cAlias->(DbSkip())

EndDo

cAlias->(DbCloseArea())

FCLOSE(nHdl)
FT_FUSE()

ExecExcel(cArq,,'GRUPO CABERJ')

Return

**************************************************************************************************

User Function AtuUsr

Processa({||ProcAtu()})

Return

**************************************************************************************************

Static Function ProcAtu

Local i := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

Local cAlias := GetNextAlias() 

ProcRegua(0)

For i := 1 to 5
	IncProc()
Next

DbUseArea(.T.,,"ba10101140920111.dtc",cAlias,.T.,.F.)

COUNT TO nLast
nCont := 0

ProcRegua(nLast)

(cAlias)->(DbGoTop())

While !(cAlias)->(EOF()) 

  IncProc("Processando: " + allTrim(Transform(++nCont,'@E 999,999,999,999')) + ' de ' + allTrim(Transform(nLast,'@E 999,999,999,999')))

  DbSelectArea('BA1')
  BA1->(DbSetOrder(2))//BA1_FILIAL + BA1_CODINT + BA1_CODEMP + BA1_MATRIC + BA1_TIPREG + BA1_DIGITO                                                                                                                                                    
  BA1->(DbGoTop())

  cChave := (cAlias)->(BA1_CODINT + BA1_CODEMP + BA1_MATRIC + BA1_TIPREG + BA1_DIGITO)

  If BA1->(MsSeek(xFilial('BA1') + cChave ))

  	If BA1->BA1_ORIEND != (cAlias)->(BA1_ORIEND)

	  	BA1->(Reclock('BA1',.F.))

	  	BA1->BA1_ORIEND := (cAlias)->(BA1_ORIEND)

	  	BA1->(Msunlock())

    EndIf

  EndIf

  // Pula para próxima linha
  (cAlias)->(DbSkip())

End

// Fecha o Arquivo
FT_FUSE()

Return

*********************************************************************************************

Static Function AjustaSX1

Local aHelp := {}

aAdd(aHelp, "Informe a data inicial"	)
PutSX1(cPerg,"01","Data de"		,"","","mv_ch01","D",8					,0,1,"G","",""			,"","","mv_par01",""	,"","","",""  		,"","","" 			,"","",""				,"","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe a data final"	)
PutSX1(cPerg,"02","Data ate"	,"","","mv_ch02","D",8					,0,1,"G","",""			,"","","mv_par02",""	,"","","",""  		,"","","" 			,"","",""				,"","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe o separador do Excel"	)
PutSX1(cPerg,"03","Separador Excel"		,"","","mv_ch03","N",01					,0,1,"C","",""			,"","","mv_par03",";"	,"","","",","  		,"","","" 			,"","",""				,"","","","","",aHelp,aHelp,aHelp)

Return