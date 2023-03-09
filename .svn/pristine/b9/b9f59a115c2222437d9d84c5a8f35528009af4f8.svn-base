#Include 'RWMAKE.CH'
#Include 'PLSMGER.CH'
#Include 'COLORS.CH'
#Include 'TOPCONN.CH'


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณARQFTIT   บMotta  ณCaberj              บ Data ณ  08/20/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ  Gerar arquivo de exporta็ใo da fatura Itau                บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/


User Function ARQFTIT()

Local cNomeArq	:= " "
Local cArq      := " "
Local cFilIt    := " "
Local cMais     := "+"
Local cMenos    := "-"
Local cPath := GetNewPar("MV_YEXFIT","M:\Protheus_Data_TST\interface\exporta\itaufatura")
Local cCpo		:= ""
Local cLin := Space(1)+CHR(13)+CHR(10)
Local nReg  := 0
Local nVlFat := 0
Local lGrav := .F.
PRIVATE cPerg := "ARQFIT"
PRIVATE nHdl

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Chama Pergunte Invariavelmente                                           ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
CriaSX1(cPerg)

If !Pergunte(cPerg,.T.)
	Return
End

Pergunte(cPerg,.F.)

cArq     := "FAT_ITAU_"+mv_par02+"_"+mv_par03+mv_par04+".TXT"
cNomeArq := cPath+"\"+cArq

If mv_par02 == "01115"
	cFilIt := "04697"
else
	If mv_par02 == "01123"
		cFilIt := "04705"
	else
		If mv_par02 == "01628"
			cFilIt := "05397"
		else
			If mv_par02 == "01834"
				cFilIt := "05645"
			else
				cFilIt := "05454"
			Endif
		Endif
	Endif
Endif


cSql := "SELECT  DECODE(BM1_CODTIP,'101','61',DECODE(BM1_TIPO,'2','62',DECODE(BM1_CODEVE,'036       ','64','63'))) OPER, "
cSql += "(CASE WHEN BM1_ALIAS = 'BSQ' OR TRIM(BM1_ORIGEM) = 'BSQ' THEN "
cSql += "        (SELECT MAX(BSQ_ANO||BSQ_MES) FROM " + RetSqlName("BSQ") + " WHERE BSQ_FILIAL = '  ' AND BSQ_CODSEQ = BM1_CODSEQ AND D_E_L_E_T_ = ' ') "
cSql += "      WHEN BM1_CODTIP = '118' THEN "
cSql += "        TO_CHAR(ADD_MONTHS(TO_DATE(BM1_ANO||BM1_MES||'01','YYYYMMDD'),-1),'YYYYMM') "
cSql += "      ELSE BM1_ANO||BM1_MES END) REF, "
cSql += "SUBSTR(REPLACE(BA1_MATEMP,'_',NULL),1,9) FUNCIO, "
cSql += "SUBSTR(REPLACE(BA1_MATEMP,'_',NULL),10,2) DEP, "
cSql += "RPAD(BA1_NOMUSR,80,' ') NOME, "
cSql += "SUBSTR(BA1_DATNAS,7,2) || '.' || SUBSTR(BA1_DATNAS,5,2) ||  '.' || SUBSTR(BA1_DATNAS,1,4) NASC, "
cSql += "SUBSTR(BA1_DATINC,7,2) || '.' || SUBSTR(BA1_DATINC,5,2) ||  '.' || SUBSTR(BA1_DATINC,1,4) DTINC, "
cSql += "DECODE(BA1_DATBLO,' ',SUBSTR(BA1_DATBLO,7,2) || '.' || SUBSTR(BA1_DATBLO,5,2) ||  '.' || SUBSTR(BA1_DATBLO,1,4),'          ') DTEXC, " //
cSql += "Decode(BT5_NUMCON,'000000000001',Decode(instr(BQC_DESCRI,'AGREGADOS'),0,'A','G') "
cSql += "                 ,'000000000002',Decode(instr(BQC_DESCRI,'AGREGADOS'),0,'I','G')) CATEG, "
cSql += "Decode(BA1_CODPLA,'0010','0406','0014','0406','0011','0307','0015','0307', "
cSql += "                  '0012','0208','0016','0208','0013','0109','0017','0109', "
cSql += "                  '0055','0109','0056','0218','0057','0317','0058','0327', "
cSql += "                  '0059','0406','    ') PADRAO, "
cSql += "LPAD(BM1_IDAFIN,3,'0')  FETARIA,"
cSql += "LPAD(TO_CHAR(BM1_VALOR * 100),13,'0') VALOR, "
cSql += "DECODE(BM1_TIPO,'2','N','P') SINAL "
cSql += "FROM " + RetSqlName("BM1") + " D, " + RetSqlName("BQC") + " B, " + RetSqlName("BA1") + " U, " + RetSqlName("BT5") + " C "
cSql += "WHERE D.D_E_L_E_T_<>'*' "
cSql += "AND B.D_E_L_E_T_<>'*' "
cSql += "AND U.D_E_L_E_T_<>'*' "
cSql += "AND C.D_E_L_E_T_<>'*' "
cSql += "AND BM1_FILIAL=BA1_FILIAL "
cSql += "AND BM1_CODINT=BA1_CODINT "
cSql += "AND BM1_CODEMP=BA1_CODEMP "
cSql += "AND BM1_MATRIC=BA1_MATRIC "
cSql += "AND BM1_TIPREG=BA1_TIPREG "
cSql += "AND BM1_DIGITO=BA1_DIGITO "
cSql += "AND BA1_FILIAL=BQC_FILIAL "
cSql += "AND BA1_CODINT=BQC_CODINT "
cSql += "AND BA1_SUBCON=BQC_SUBCON "
cSql += "AND BA1_CONEMP=BQC_NUMCON "
cSql += "AND BA1_CODEMP=BQC_CODEMP "
cSql += "AND BA1_FILIAL=BT5_FILIAL "
cSql += "AND BA1_CODINT=BT5_CODINT "
cSql += "AND BA1_CODEMP=BT5_CODIGO "
cSql += "AND BA1_CONEMP=BT5_NUMCON "
cSql += "AND BM1_PREFIX = 'PLS' "
cSql += "AND BA1_CODEMP='" + mv_par01 +"' "
cSql += "AND BA1_NUMCON <> '000000000003' " //ART 30
cSql += "AND BM1_MES = '" + mv_par04 + "' "
cSql += "AND BM1_ANO = '" + mv_par03 + "' "

if mv_par01 = "0006" // Contrato Antigo
	cSql += "AND BT5_NUMCON = DECODE('" + mv_par02 + "','01115','000000000001','000000000002') "
else
	if mv_par01 = "0010" .AND. mv_par02 = "01628"
		cSql += "AND BT5_NUMCON = '000000000001' "
	else
		if mv_par01 = "0010" .AND. mv_par02 = "01644"
			cSql += "AND BT5_NUMCON = '000000000004' "
		else
			cSql += "AND BT5_NUMCON = '000000000005' "
		Endif
	Endif
Endif


cSql += "ORDER BY 3,4,1,2 "

//MemoWrite("C:\FITAU.SQL", cSql)

PLsQuery(cSql,"TMPARQI")
If !TMPARQI->(EOF())
	If U_Cria_TXT(cNomeArq)
		// header
		cCpo := "02"
		cCpo += mv_par02
		cCpo += cFilIt
		cCpo += Substr(DtoS(dDataBase),1,6)
		cCpo += "CAIXA DE ASSISTสNCIA ภ SAฺDE-CABERJ               " // nome empresa 50 posicoes
		cCpo += "42182170000184" // cnpj
		cCpo += mv_par05 // nบ remessa 6 posicoes
		cCpo += "001" //versao
		cCpo += Substr(DtoS(dDataBase),7,2)+"."+Substr(DtoS(dDataBase),5,2)+"."+Substr(DtoS(dDataBase),1,4)
		cCpo += StrTran(Time(),":","")
		cCpo += cArq + Space(50 - Len(cArq))
		cCpo += Space(143)
		
		If !(U_GrLinha_TXT(cCpo,cLin))
			MsgAlert("ATENวรO! NรO FOI POSSอVEL GRAVAR CORRETAMENTE A LINHA ATUAL! OPERAวรO ABORTADA!")
			Return
		Endif
		// detalhe
		While !TMPARQI->(EOF())
			cCpo := "12"
			cCpo += mv_par02
			cCpo += cFilIt
			cCpo += Substr(DtoS(dDataBase),1,6)
			cCpo += TMPARQI->OPER
			cCpo += TMPARQI->REF
			cCpo += TMPARQI->FUNCIO
			cCpo += TMPARQI->DEP
			cCpo += TMPARQI->NOME
			cCpo += TMPARQI->NASC
			cCpo += TMPARQI->DTINC
			cCpo += TMPARQI->DTEXC
			cCpo += TMPARQI->CATEG
			cCpo += TMPARQI->PADRAO
			cCpo += TMPARQI->FETARIA
			cCpo += TMPARQI->VALOR
			If TMPARQI->SINAL == "P" // nao pode ser query poi o advpl nao trata corretamente usando o sinal +
				cCpo += cMais
			Else
				cCpo += cMenos
			Endif
			cCpo += Space(131)
			nReg += 1
			// acumula o valor tratando pelo sinal
			If TMPARQI->SINAL == "P"
				nVlFat := nVlFat + Val(TMPARQI->VALOR)
			Else
				nVlFat := nVlFat - Val(TMPARQI->VALOR)
			Endif
			If !(U_GrLinha_TXT(cCpo,cLin))
				MsgAlert("ATENวรO! NรO FOI POSSอVEL GRAVAR CORRETAMENTE A LINHA ATUAL! OPERAวรO ABORTADA!")
				Return
			Endif
			TMPARQI->(DbSkip())
		Enddo
		// trailler
		cCpo := "98"
		cCpo += mv_par02
		cCpo += cFilIt
		cCpo += Substr(DtoS(dDataBase),1,6)
		cCpo += StrZero(nReg,9)
		cCpo += StrZero(nVlFat,13)
		cCpo += Space(260)
		
		If !(U_GrLinha_TXT(cCpo,cLin))
			MsgAlert("ATENวรO! NรO FOI POSSอVEL GRAVAR CORRETAMENTE A LINHA ATUAL! OPERAวรO ABORTADA!")
			Return
		Endif
		U_Fecha_TXT()
		lGrav := .T.
	Endif
Endif
TMPARQI->(DbCloseArea())
If lGrav == .T.
	MsgAlert("Arquivo "+cNomeArq+" gravado com sucesso!")
Endif

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Fim da Rotina...                                                    ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCriaSX1   บAutor  ณ Motta              บ Data ณ  10/10/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณCria / atualiza parametros                                  บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Caberj.                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function CriaSX1(cPerg)

PutSx1(cPerg,"01",OemToAnsi("Empresa")		      	,"","","mv_ch1","C",04,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"02",OemToAnsi("Contrato")				,"","","mv_ch2","C",05,0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"03",OemToAnsi("Ano Ref")		      	,"","","mv_ch3","C",04,0,0,"G","","","","","mv_par03","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"04",OemToAnsi("Mes Ref")				,"","","mv_ch4","C",02,0,0,"G","","","","","mv_par04","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"05",OemToAnsi("Sequencia")     		,"","","mv_ch5","C",06,0,0,"G","","","","","mv_par05","","","","","","","","","","","","","","","","",{},{},{})

Return

