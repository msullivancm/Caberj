#include "PROTHEUS.CH"
#include "PLSMGER.CH"
#include "COLORS.CH"
#include "RWMAKE.CH"
#Include "topconn.ch"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณRELSINIS  บ Autor ณ Rafael             บ Data ณ  17/03/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Relat๓rio de despesa x reajuste                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/                                                               

User Function RELSINIS
********************

Local cDesc1        := "Este programa tem como objetivo imprimir relatorio "
Local cDesc2        := "de acordo com os parametros informados pelo usuario."
Local cDesc3        := ""
Local cPict         := ""
Local titulo        := "Resumo de Sinistralidade"
Local nLin          := 80
Local Cabec1        := ""
Local Cabec2        := ""
Local imprime       := .T.
Local aOrd          := {}
Private lEnd        := .F.
Private lAbortPrint := .F.
Private CbTxt       := ""
Private limite      := 220
Private tamanho     := "G"
Private nomeprog    := "RELSINIS"
Private nTipo       := 18
Private aReturn     := {"Zebrado", 1, "Administracao", 2, 2, 1, "", 1}
Private nLastKey    := 0
Private cbtxt       := Space(10)
Private cbcont      := 00
Private CONTFL      := 01
Private m_pag       := 01
Private wnrel       := "RELSINIS"
Private cString     := "SE1"
Private cPerg       := "RELSIN"


fSetSX1()
If Pergunte(cPerg,.T.)
	
	wnrel := SetPrint(cString,NomeProg,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.T.,aOrd,.T.,Tamanho,,.T.)
	
	If nLastKey == 27
		Return
	End
	
	SetDefault(aReturn,cString)
	
	If nLastKey == 27
		Return
	End
	
	nTipo := If(aReturn[4] == 1,15,18)

	Processa({|| fProcImp(Cabec1,Cabec2,Titulo,nLin)},"Receitas x Despesas")
	
End

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณfProcImp  บ Autor ณ Rafael             บ Data ณ  17/03/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Processamento do relat๓rio.                                บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function fProcImp(Cabec1,Cabec2,Titulo,nLin)
***************************************************

Local cChave
Local nPercRec
Local nTotPRec
Local nPercLiq
Local nTotPLiq
Local nTotalRec
Local nTotalLiq
Local nVlrResul  
Local nSubRec     := 0
Local nSubAdi     := 0
Local nSubTRec    := 0
Local nSubDes     := 0
Local nSubLiq     := 0
Local nTotRec     := 0
Local nTotAdi     := 0
Local nTotTRec    := 0
Local nTotDes     := 0
Local nTotLiq     := 0
Local nSubRes     := 0  
Local nTotRes     := 0  
Local cNmEmp      := ""
Local cQuery
Local cQrySel
Local cQryFrm
Local cQryWhe
Local cQryGrp
Local nPosVet   := 0
Local nPosUsr   := 0
Local nTotReg   := 0
Local dDatNas 	:= ""
Local cProduto  := ""
Local cTpEven   := ""
Local cVarQry   := ""
Local cOpePad   := PlsIntPad()
Local nVlrMen 	:= 0
Local nVlrAdi 	:= 0
Local aReceita  := {}
Local aDespesa  := {}
Local aUsuario  := {}
Local aCntUsuario:= {}
Local aEmpres   := {}
Local aSubCon   := {}
Local nqtdusr 	:= 0
Local nVlrDes   := 0
Local nTmp      := 0
Local cAliasRec := "QryReceitas"
Local cAliasDes := "QryDespesas"
Local cModPag   := "0"
Local cTexto    := ""
Local cImpLog   := GetNewPar("MV_PLSY054","2") 
Local cCodEmp   := ""
Local cSubCon   := ""
Local cAnoMes   := ""
Local nTotUsr   := 0
Local nNroMes   := 0

//Grava cabecalho do log
If cImpLog == "1"
	cTexto := "Empresa;Contrato;Sub-Contrato;Usuแrios;Mensalidade;Adicional;Receita Total;Pago;Resultado;Sinistralidade;"
	GravaLog(cTexto)
Endif

//Monta o cabe็alho conforme tipo de relat๓rio (Analitico ou Sintetico)
If mv_par17 == 1
	Cabec1 := " Matrํcula - Nome do usuแrio                        Mensalidade         Adicional          Total          Evento           Resultado    %Sinistralidade  Prod/Versao-Mod.Pagto  Data Nasc."
ElseIf mv_par17 == 2
	Cabec1 := "                              +---------------- RECEITAS ---------------------+ +-------- EVENTOS -------+ +---------- LอQUIDO ---------+"
	Cabec2 := " Ano   M๊s  Usuแrios          | Mensal         Adicional         Total        | |        Pago            | | Resultado    Sinistralidade|"
End

//Monta a query das receitas
cQuery  := ""
cQrySel := ""
cQryFrm := ""
cQryWhe := ""
cQryGrp := ""
cQryOrd := ""

cVarQry := IIF(Empty(mv_par26),"", "'" + StrTran( mv_par26, ",", "','" ) + "'")

If mv_par27 == 1 //Pessoa Fisica

	cQrySel += " SELECT BM1_PREFIX,BM1_NUMTIT,BM1_PARCEL,BM1_TIPTIT,BM1_CODINT,BM1_CODEMP,BM1_MATRIC,BM1_TIPREG,BM1_DIGITO,BM1_CODTIP,BM1_VALOR,BM1_CONEMP,BM1_VERCON,BM1_SUBCON,BM1_VERSUB,BM1_ANO,BM1_MES,BM1_NOMUSR "
	cQryFrm += " FROM "  + RetSqlName("BM1") + ", " + RetSqlName("BA3")
	cQryWhe += " WHERE BM1_FILIAL = '" + xFilial("BM1") + "' "
	cQryWhe += "   AND BM1_CODINT BETWEEN '" + mv_par01 + "' AND '" + mv_par02 + "' "
	cQryWhe += "   AND BM1_CODEMP BETWEEN '" + mv_par03 + "' AND '" + mv_par04 + "' "
	cQryWhe += "   AND BM1_CONEMP BETWEEN '" + mv_par05 + "' AND '" + mv_par06 + "' "
	cQryWhe += "   AND BM1_VERCON BETWEEN '" + mv_par07 + "' AND '" + mv_par08 + "' "
	cQryWhe += "   AND BM1_SUBCON BETWEEN '" + mv_par09 + "' AND '" + mv_par10 + "' "
	cQryWhe += "   AND BM1_VERSUB BETWEEN '" + mv_par11 + "' AND '" + mv_par12 + "' "
	cQryWhe += "   AND BM1_MATRIC BETWEEN '" + mv_par20 + "' AND '" + mv_par21 + "' "
	cQryWhe += "   AND BM1_TIPREG BETWEEN '" + mv_par22 + "' AND '" + mv_par23 + "' "
	cQryWhe += "   AND BM1_ANO+BM1_MES BETWEEN '" + mv_par15+mv_par13 + "' AND '" +  mv_par16+mv_par14 + "' "
	cQryWhe += "   AND BM1_CODEVE <> '0086' " //Sem Usimed
	cQryWhe += "   AND BA3_TIPOUS = '1' " //Pessoa Fisica
	If ! Empty(cVarQry)
		cQryWhe += "   AND BA3_GRPCOB IN (" + cVarQry + ")"
	Endif
	cQryWhe += "   AND BA3_FILIAL=BM1_FILIAL "
	cQryWhe += "   AND BA3_CODINT=BM1_CODINT "
	cQryWhe += "   AND BA3_CODEMP=BM1_CODEMP "
	cQryWhe += "   AND BA3_MATRIC=BM1_MATRIC "
	cQryWhe += "   AND " + RetSqlName("BM1") + ".D_E_L_E_T_ <> '*' "
	cQryWhe += "   AND " + RetSqlName("BA3") + ".D_E_L_E_T_ <> '*' "
	cQryGrp := " ORDER BY BM1_CODEMP, BM1_CONEMP, BM1_VERCON, BM1_SUBCON, BM1_VERSUB, BM1_ANO, BM1_MES "

Else

	cQrySel += " SELECT BM1_PREFIX,BM1_NUMTIT,BM1_PARCEL,BM1_TIPTIT,BM1_CODINT,BM1_CODEMP,BM1_MATRIC,BM1_TIPREG,BM1_DIGITO,BQC_CODBLO,BM1_CODTIP,BM1_VALOR,BM1_CONEMP,BM1_VERCON,BM1_SUBCON,BM1_VERSUB,BM1_ANO,BM1_MES,BM1_NOMUSR "
	cQryFrm += " FROM "  + RetSqlName("BM1") + ", " + RetSqlName("BQC")
	cQryWhe += " WHERE BM1_FILIAL = '" + xFilial("BM1") + "' "
	cQryWhe += "   AND BM1_CODINT BETWEEN '" + mv_par01 + "' AND '" + mv_par02 + "' "
	cQryWhe += "   AND BM1_CODEMP BETWEEN '" + mv_par03 + "' AND '" + mv_par04 + "' "
	cQryWhe += "   AND BM1_CONEMP BETWEEN '" + mv_par05 + "' AND '" + mv_par06 + "' "
	cQryWhe += "   AND BM1_VERCON BETWEEN '" + mv_par07 + "' AND '" + mv_par08 + "' "
	cQryWhe += "   AND BM1_SUBCON BETWEEN '" + mv_par09 + "' AND '" + mv_par10 + "' "
	cQryWhe += "   AND BM1_VERSUB BETWEEN '" + mv_par11 + "' AND '" + mv_par12 + "' "
	cQryWhe += "   AND BM1_MATRIC BETWEEN '" + mv_par20 + "' AND '" + mv_par21 + "' "
	cQryWhe += "   AND BM1_TIPREG BETWEEN '" + mv_par22 + "' AND '" + mv_par23 + "' "
	cQryWhe += "   AND BM1_ANO+BM1_MES BETWEEN '" + mv_par15+mv_par13 + "' AND '" +  mv_par16+mv_par14 + "' "
	cQryWhe += "   AND BM1_CODEVE <> '0086' " //Sem Usimed

	If ! Empty(cVarQry)
		cQryWhe += "   AND BQC_GRPCOB IN (" + cVarQry + ")"
	Endif

	If mv_par24 = 1 //Somente Bloqueados
		cQryWhe += "   AND BQC_CODBLO <> '' "
	ElseIf mv_par24 = 2 //Somente Desbloqueados
		cQryWhe += "   AND BQC_CODBLO = '' "
	Endif

	cQryWhe += "   AND BQC_FILIAL=BM1_FILIAL "
	cQryWhe += "   AND BQC_CODIGO=BM1_CODINT+BM1_CODEMP "
	cQryWhe += "   AND BQC_NUMCON=BM1_CONEMP "
	cQryWhe += "   AND BQC_VERCON=BM1_VERCON "
	cQryWhe += "   AND BQC_SUBCON=BM1_SUBCON "
	cQryWhe += "   AND BQC_VERSUB=BM1_VERSUB "
	cQryWhe += "   AND " + RetSqlName("BM1") + ".D_E_L_E_T_ <> '*' "
	cQryWhe += "   AND " + RetSqlName("BQC") + ".D_E_L_E_T_ <> '*' "
	cQryGrp := " ORDER BY BM1_CODEMP, BM1_CONEMP, BM1_VERCON, BM1_SUBCON, BM1_VERSUB, BM1_ANO, BM1_MES "
		
Endif

If Select(cAliasRec) != 0
	(cAliasRec)->(dbCloseArea())
EndIf

cQuery := (cQrySel+cQryFrm+cQryWhe+cQryGrp)
PlsQuery(cQuery,cAliasRec)

(cAliasRec)->(dbGoTop())

While (cAliasRec)->(!Eof())
	nTotReg++
	(cAliasRec)->(dbSkip())
EndDo

ProcRegua(nTotReg)

(cAliasRec)->(dbGoTop())
While (cAliasRec)->(!Eof())

	cCodEmp := (cAliasRec)->(BM1_CODEMP)
	aAdd(aEmpres,cCodEmp)
	
	While (cAliasRec)->(BM1_CODEMP)==cCodEmp .and. (cAliasRec)->(!Eof())

		cSubCon := (cAliasRec)->(BM1_CONEMP+BM1_VERCON+BM1_SUBCON+BM1_VERSUB)
		Aadd(aSubCon,{(cAliasRec)->BM1_CODEMP,(cAliasRec)->BM1_CONEMP,(cAliasRec)->BM1_VERCON,(cAliasRec)->BM1_SUBCON,(cAliasRec)->BM1_VERSUB})
	
		While (cAliasRec)->(BM1_CODEMP)==cCodEmp .and. (cAliasRec)->(BM1_CONEMP+BM1_VERCON+BM1_SUBCON+BM1_VERSUB)==cSubCon .and. (cAliasRec)->(!Eof())

			//Alimenta variaveis
			aUsuario := {}            
			cAnoMes  := (cAliasRec)->(BM1_ANO+BM1_MES)

			//verifica nome da empresa
			BG9->(DbSetOrder(1))
			BG9->(MsSeek(xFilial("BG9")+(cAliasRec)->(BM1_CODINT+BM1_CODEMP)))
			
			cNmEmp := BG9->BG9_DESCRI
	
			//verifica situacao do Sub-contrato e a modalidade do produto
			cCodblo := "Desbloq"
	
			If mv_par27 == 1 //Pessoa Fisica
				cCodblo := "PF"
			Else
				If Alltrim((cAliasRec)->(BQC_CODBLO)) <> ""
					cCodblo := "Bloq"
				Endif
			Endif
	
			If mv_par17 <> 1  //sintetico

				Aadd(aReceita,{(cAliasRec)->BM1_ANO,(cAliasRec)->BM1_MES,(cAliasRec)->BM1_CODINT,(cAliasRec)->BM1_CODEMP,(cAliasRec)->BM1_CONEMP,(cAliasRec)->BM1_VERCON,(cAliasRec)->BM1_SUBCON,(cAliasRec)->BM1_VERSUB,0,0,cNmEmp,cCodBlo})
				Aadd(aCntUsuario,{(cAliasRec)->BM1_ANO+(cAliasRec)->BM1_MES+(cAliasRec)->BM1_CODEMP+(cAliasRec)->BM1_CONEMP+(cAliasRec)->BM1_VERCON+(cAliasRec)->BM1_SUBCON+(cAliasRec)->BM1_VERSUB,0})

				nPosVet := Len(aReceita)
				nPosUsr := Len(aCntUsuario)

	        Endif

			While (cAliasRec)->(BM1_CODEMP)==cCodEmp .and. (cAliasRec)->(BM1_CONEMP+BM1_VERCON+BM1_SUBCON+BM1_VERSUB)==cSubCon .and. (cAliasRec)->(BM1_ANO+BM1_MES)==cAnoMes .and. (cAliasRec)->(!Eof())
			
				IncProc("Receitas: "+cCodEmp+"."+(cAliasRec)->(BM1_CONEMP)+"."+(cAliasRec)->(BM1_SUBCON)+" "+(cAliasRec)->(BM1_MES)+"/"+(cAliasRec)->(BM1_ANO) )
				
				//verificar titulos baixados
				If mv_par25 == 1
					If ! VldTit((cAliasRec)->(BM1_PREFIX),(cAliasRec)->(BM1_NUMTIT),(cAliasRec)->(BM1_PARCEL),(cAliasRec)->(BM1_TIPTIT))
						(cAliasRec)->(DbSkip())
						Loop
					Endif
			    Endif
			    
				//busca data de nascimento do usuario
				BA1->(DbSetOrder(2))
				BA1->(MsSeek(xFilial("BA1")+(cAliasRec)->(BM1_CODINT+BM1_CODEMP+BM1_MATRIC+BM1_TIPREG+BM1_DIGITO)))
				
				dDatNas:= BA1->BA1_DATNAS
			
				If Alltrim(BA1->BA1_CODPLA) <> ''
					cProduto := BA1->BA1_CODPLA + '/'+ BA1->BA1_VERSAO
				Else
					BA3->(DbSetOrder(01))
					BA3->(MsSeek(xFilial("BA3")+BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC)))
					cProduto := BA3->BA3_CODPLA+ '/'+ BA3->BA3_VERSAO
				Endif
				
				//verificar tipo de faturamento cfme evento e separa os valores
				nVlrMen := 0
				nVlrAdi := 0
			
				BFQ->(DbSetOrder(1))
				BFQ->(MsSeek(xFilial("BFQ")+((cAliasRec)->BM1_CODINT+(cAliasRec)->BM1_CODTIP)))
			
				IF BFQ->BFQ_TIPFAT = "2"
					nVlrMen := (cAliasRec)->BM1_VALOR
				Else
					nVlrAdi := (cAliasRec)->BM1_VALOR
				Endif
			
				//monta array
				If mv_par17 == 1  //analitico
					nqtdusr := Len(aReceita)
					nPosVet := aScan(aReceita,{|x| x[7]+x[8]+x[2]+x[9]+x[10] == (cAliasRec)->(BM1_ANO+BM1_MES+BM1_CODEMP+BM1_MATRIC+BM1_TIPREG)})
					If nPosVet == 0
						Aadd(aReceita,{	(cAliasRec)->BM1_CODINT,(cAliasRec)->BM1_CODEMP,(cAliasRec)->BM1_CONEMP,(cAliasRec)->BM1_VERCON,(cAliasRec)->BM1_SUBCON,(cAliasRec)->BM1_VERSUB,(cAliasRec)->BM1_ANO,(cAliasRec)->BM1_MES,(cAliasRec)->BM1_MATRIC,(cAliasRec)->BM1_TIPREG,(cAliasRec)->BM1_NOMUSR,nVlrMen,nVlrAdi,dDatNas,cProduto,cNmEmp,cCodblo})
					Else
						aReceita[nPosVet][12]+= nVlrMen
						aReceita[nPosVet][13]+= nVlrAdi
					Endif
				Else
					
					//Grava Valores por Competencia + Sub-Contrato
					aReceita[nPosVet][9]  += nVlrMen
					aReceita[nPosVet][10] += nVlrAdi
					
					//Grava Usuario + Sub-Contrato por Competencia
					If aScan(aUsuario,{|x| x[1]+x[2]+x[3] == (cAliasRec)->(BM1_CODEMP+BM1_MATRIC+BM1_TIPREG)}) == 0
						Aadd(aUsuario,{	(cAliasRec)->BM1_CODEMP,(cAliasRec)->BM1_MATRIC,(cAliasRec)->BM1_TIPREG})
					Endif
				Endif
				
				(cAliasRec)->(dbSkip())
			EndDo
			
			//Grava Total de Usuarios por Competencia + Sub-Contrato
			If mv_par17 <> 1  //sintetico
				aCntUsuario[nPosUsr][2] := Len(aUsuario)
			Endif
		EndDo
	EndDo
EndDo

//Monta a query das despesas
cQuery  := ""
cQrySel := ""
cQryFrm := ""
cQryWhe := ""
cQryGrp := ""

ProcRegua(Len(aSubCon))

For nTmp := 1 to Len(aSubCon)

	IncProc("Processando Custos...")

	cQrySel := " SELECT SUBSTRING(BD7_NUMLOT,1,4) AS BD7_ANOPAG, SUBSTRING(BD7_NUMLOT,5,2) AS BD7_MESPAG, " + If(mv_par17 == 1,"BD7_MATRIC, BD7_TIPREG, ","")+ " SUM(BD7_VLRPAG) " + If(mv_par19 == 2," - SUM(BD7_VLRTAD) ","") + " AS BD7_VLRPAG "
	cQryFrm := "  FROM " + RetSqlName("BD6") + ", " + RetSqlName("BD7") 
	cQryWhe := "  	WHERE BD6_FILIAL = '" + xFilial("BD6") + "' "
	cQryWhe += "      AND BD6_CODOPE = '" + PlsIntPad() + "' "
	cQryWhe += "      AND BD6_CODEMP = '" + aSubCon[nTmp][1] + "' "
	cQryWhe += "      AND BD6_CONEMP = '" + aSubCon[nTmp][2] + "' "
	cQryWhe += "      AND BD6_VERCON = '" + aSubCon[nTmp][3] + "' "
	cQryWhe += "      AND BD6_SUBCON = '" + aSubCon[nTmp][4] + "' "
	cQryWhe += "      AND BD6_VERSUB = '" + aSubCon[nTmp][5] + "' "
	cQryWhe += "      AND BD6_MATRIC BETWEEN '" + mv_par20 + "' AND '" + mv_par21 + "' "
	cQryWhe += "      AND BD6_TIPREG BETWEEN '" + mv_par22 + "' AND '" + mv_par23 + "' "
	cQryWhe += "	  AND SUBSTRING(BD7_NUMLOT,1,6) BETWEEN '" + mv_par15+mv_par13 + "' AND '" +  mv_par16+mv_par14 + "' "
	cQryWhe += "      AND BD7_FASE   = '4' "
	cQryWhe += "      AND BD7_SITUAC = '1' "
	cQryWhe += "      AND BD7_BLOPAG <> '1' "
	cQryWhe += "      AND BD7_FILIAL = BD6_FILIAL "
	cQryWhe += "      AND BD7_CODOPE = BD6_CODOPE "
	cQryWhe += "      AND BD7_CODLDP = BD6_CODLDP "
	cQryWhe += "      AND BD7_CODPEG = BD6_CODPEG "
	cQryWhe += "      AND BD7_NUMERO = BD6_NUMERO "
	cQryWhe += "      AND BD7_ORIMOV = BD6_ORIMOV "
	cQryWhe += "      AND BD7_SEQUEN = BD6_SEQUEN "
	cQryWhe += "      AND " + RetSqlName("BD6") + ".D_E_L_E_T_ = ' ' "
	cQryWhe += "      AND " + RetSqlName("BD7") + ".D_E_L_E_T_ = ' ' "
	cQryGrp := " GROUP BY SUBSTRING(BD7_NUMLOT,1,4), SUBSTRING(BD7_NUMLOT,5,2)" + If(mv_par17 == 1,", BD7_MATRIC,BD7_TIPREG","")

	If Select(cAliasDes) != 0
		(cAliasDes)->(dbCloseArea())
	EndIf
	
	cQuery := (cQrySel+cQryFrm+cQryWhe+cQryGrp)
	PlsQuery(cQuery,cAliasDes)
	
	While (cAliasDes)->(!Eof())
	
		If mv_par17 == 1 //analitico
			nPosVet := aScan(aDespesa,{|x| x[1]+x[2]+x[3]+x[4]+x[5]+x[6]+x[7]+x[8]+x[9]+x[10] == (cAliasDes)->(BD7_ANOPAG+BD7_MESPAG)+cOpePad+aSubCon[nTmp][1]+aSubCon[nTmp][2]+aSubCon[nTmp][3]+aSubCon[nTmp][4]+aSubCon[nTmp][5]+BD7_MATRIC+BD7_TIPREG })
			If nPosVet == 0
				aAdd(aDespesa,{(cAliasDes)->BD7_ANOPAG, (cAliasDes)->BD7_MESPAG, cOpePad, aSubCon[nTmp][1], aSubCon[nTmp][2], aSubCon[nTmp][3], aSubCon[nTmp][4], aSubCon[nTmp][5], (cAliasDes)->BD7_MATRIC, (cAliasDes)->BD7_TIPREG, (cAliasDes)->BD7_VLRPAG })
			Else
				aDespesa[nPosVet][11]+= (cAliasDes)->BD7_VLRPAG
			Endif
		Else
			nPosVet := aScan(aDespesa,{|x| x[1]+x[2]+x[3]+x[4]+x[5]+x[6]+x[7] == (cAliasDes)->(BD7_ANOPAG+BD7_MESPAG)+aSubCon[nTmp][1]+aSubCon[nTmp][2]+aSubCon[nTmp][3]+aSubCon[nTmp][4]+aSubCon[nTmp][5] })
			If nPosVet == 0
				aAdd(aDespesa,{(cAliasDes)->BD7_ANOPAG,(cAliasDes)->BD7_MESPAG,aSubCon[nTmp][1], aSubCon[nTmp][2], aSubCon[nTmp][3], aSubCon[nTmp][4],aSubCon[nTmp][5],(cAliasDes)->BD7_VLRPAG})
			Else
				aDespesa[nPosVet][9] += (cAliasDes)->BD7_VLRPAG
			Endif
		Endif
		
		(cAliasDes)->(dbSkip())
	EndDo
		
Next 

//ordena array
If mv_par17 == 1
	aSort(aReceita,,,{|x,y| x[1]+x[2]+x[3]+x[4]+x[5]+x[6]+x[7]+x[8]+x[9]+x[10] < y[1]+y[2]+y[3]+y[4]+y[5]+y[6]+y[7]+y[8]+y[9]+y[10]})
	aSort(aDespesa,,,{|x,y| x[2]+x[1]+x[3]+x[9]+x[10] < y[2]+y[1]+y[3]+y[9]+y[10]})
	ProcRegua(Len(aReceita))
elseif mv_par17 == 2
	aSort(aReceita,,,{|x,y| x[3]+x[4]+x[5]+x[6]+x[7]+x[1]+x[2] < y[3]+y[4]+y[5]+y[6]+y[7]+y[1]+y[2]})
	aSort(aDespesa,,,{|x,y| x[3]+x[4]+x[5]+x[6]+x[7]+x[1]+x[2] < y[3]+y[4]+y[5]+y[6]+y[7]+y[1]+y[2]})
	ProcRegua(Len(aReceita))
endif  

nPos:= 1

ProcRegua(len(aReceita))

While npos <= len(aReceita)

	If lAbortPrint
		@nLin,00 PSay "*** CANCELADO PELO OPERADOR ***"
		Exit
	End
	
	If mv_par17 == 1
		//Se quebra pแgina por contrato
		If mv_par18 == 1
			Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
			nLin := 8
		End
		
		If nLin > 60
			Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
			nLin := 8
		End
		
		cOper		:= aReceita[npos,1]
		cEmp		:= aReceita[npos,2]
		cCont		:= aReceita[npos,3]
		cVercon		:= aReceita[npos,4]
		cSub		:= aReceita[npos,5]
		cVerSub		:= aReceita[npos,6]
		cNmEmpA		:= aReceita[npos,16]
		nqtdusrA 	:= len(aReceita)
		cCodbloA	:= aReceita[npos,17]
		
		//solicitado em 26.01.07
		cNmSub := Posicione("BQC",1,xFilial("BQC")+ (cOper+cEmp+cCont+cVercon+cSub+cVerSub),"BQC_DESCRI")
		
		@nLin, 001 PSay If(mv_par19 == 1,"[C/ TX ADM]","[S/ TX ADM]") + Space(2) + "Operadora: " + cOper + ;
		Space(3) + "Empresa: " +cEmp + "-" + substr(cNmEmpA,1,15)+ ;
		Space(3) + "Contrato: " + cCont + "/" + cVercon + ;
		Space(3) + "Sub-Contrato: " + cSub + "/" +cVerSub+ "-" + substr(cNmSub,1,20) +"-"+ cCodbloA
		nLin ++
		
		If nLin > 60
			Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
			nLin := 8
		End
		
		While nPos <= len(aReceita) .and. cEmp+cCont+cVercon+cSub+cVersub == aReceita[npos,2]+ aReceita[npos,3]+ aReceita[npos,4]+ aReceita[npos,5]+ aReceita[npos,6]
			cAno		:= aReceita[npos,7]
			cMes		:= aReceita[npos,8]
			
			nLin ++
			@nLin, 001 PSay "Ano Base: " + cAno + Space(2) + "M๊s Base: " + cMes
			nLin ++
			nLin ++
			
			If nLin > 60
				Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
				nLin := 8
			End
			
			nqtd:= 0
			While nPos <= len(aReceita) .and. cEmp+cCont+cVercon+cSub+cVersub+cAno+cMes == aReceita[npos,2]+ aReceita[npos,3]+ aReceita[npos,4]+ aReceita[npos,5]+ aReceita[npos,6]+aReceita[npos,7]+aReceita[npos,8]
	
				IncProc("Imprimindo Relat๓rio...")
	
				cMatric		:= aReceita[npos,9]
				cTipReg		:= aReceita[npos,10]
				cNumUsrA 	:= aReceita[npos,11]
				nVlrMenA 	:= aReceita[npos,12]
				nVlrAdiA	:= aReceita[npos,13]
				dDatNasA	:= aReceita[npos,14]
				cProdutoA	:= aReceita[npos,15]
				
				nVlrDes:= 0
				nPosVet := aScan(aDespesa,{|x| x[1]+x[2]+x[4]+x[9]+x[10] == cAno+cMes+cEmp+cMatric+cTipReg})
				
				If nPosVet <> 0
					nVlrDes := aDespesa[nPosVet,11]
				Endif
				
				nTotalRec := nVlrMenA + nVlrAdiA
				nVlrResul := nTotalRec-nVlrDes 
				
				If nLin > 60
					Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
					nLin := 8
				End
				
				@nLin, 001 PSay cMatric+"."+cTipReg + " - " + AllTrim(cNumUsrA)
				@nLin, 042 PSay Transform(nVlrMenA,"@E 999,999,999,999.99")
				@nLin, 059 PSay Transform(nVlrAdiA,"@E 999,999,999,999.99")
				@nLin, 076 PSay Transform(nTotalRec,"@E 999,999,999,999.99")
				@nLin, 093 PSay Transform(nVlrDes,"@E 999,999,999,999.99")
				@nLin, 110 PSay Transform(nVlrResul,"@E 999,999,999,999.99")
				
				BI3->(DbSetOrder(1))
				BI3->(MsSeek(xFilial("BI3")+(cOper+substr(cProdutoA,1,4)+substr(cProdutoA,6,3))))
				cModPag:= BI3->BI3_MODPAG
				
				If Alltrim(cModPag) == "1" //pre-pagto
					nPercLiq:= ((nVlrDes - nVlrAdiA) / nVlrMenA ) * 100
				Else
					nPercLiq:= (nVlrDes / nTotalRec) * 100
				Endif
				
				@nLin, 135 PSay Transform(nPercLiq,"@E 9999.99%")
				@nLin, 152 PSay cProdutoA + "-" + if(Alltrim(cModPag) == "1", "PP","CO")
				@nLin, 172 PSay Transform(dDatNasA,"@D") 
				
				If nLin > 60
					Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
					nLin := 8
				End
				nSubRec  += nVlrMenA
				nSubAdi  += nVlrAdiA
				nSubTRec += nTotalRec
				nSubDes  += nVlrDes
				nSubRes  += nVlrResul 
				nTotRec  += nVlrMenA
				nTotAdi  += nVlrAdiA
				nTotTRec += nTotalRec
				nTotDes  +=  nVlrDes
				
				If cModPag == "1"        //pre-pagto
					nTotPLiq := ((nSubDes - nSubAdi) /nSubRec)*100
				Else
					nTotPLiq  := (nSubDes /nSubTRec)*100
				Endif
				
				nqtd ++
				
				nTotRes  += nVlrResul 
				
				nLin ++
				nPos ++
			Enddo
			
			@nLin, 001  PSay __PrtThinLine()
			nLin ++
			
			@nLin, 001 PSay "TOTAL SUB-CONTRATO Qtd Usuarios: " + AllTrim(Transform(nQtd,"@E 9999"))
			@nLin, 042 PSay Transform(nSubRec,"@E 999,999,999,999.99")
			@nLin, 059 PSay Transform(nSubAdi,"@E 999,999,999,999.99")
			@nLin, 076 PSay Transform(nSubTRec,"@E 999,999,999,999.99")
			@nLin, 093 PSay Transform(nSubDes,"@E 999,999,999,999.99")
			@nLin, 110 PSay Transform(nSubRes,"@E 999,999,999,999.99")
			@nLin, 135 PSay Transform(nTotPLiq,"@E 9999.99%")
			
			nSubRec  := 0
			nSubAdi  := 0
			nSubTRec := 0
			nSubDes  := 0
			nSubRes  := 0
			
			nLin ++
			@nLin, 001  PSay __PrtFatLine()
			nLin ++
		Enddo
	Elseif mv_par17 == 2                                    //sintetico
		
		If mv_par18 == 1
			Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
			nLin := 8
		End
		
		If nLin > 60
			Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
			nLin := 8
		End
		
		cOper		:= aReceita[npos,3]
		cEmp		:= aReceita[npos,4]
		cCont		:= aReceita[npos,5]
		cVercon		:= aReceita[npos,6]
		cSub		:= aReceita[npos,7]
		cVerSub		:= aReceita[npos,8]
		cNmEmpA		:= aReceita[npos,11]
		cCodbloA	:= aReceita[npos,12]
		
		
		//verifica modalidade de pagamento
		BT6->(DbSetOrder(01))
		If BT6->(MsSeek(xFilial("BT6")+cOper+cEmp+cCont+cVercon+cSub+cVersub))//PJ
			cModPag:= alltrim(BT6->BT6_MODPAG)
		Else   															//PF
			cModPag:= '1'
		Endif
		
		cNmSub := Posicione("BQC",1,xFilial("BQC")+ (cOper+cEmp+cCont+cVercon+cSub+cVerSub),"BQC_DESCRI")
		
		nLin ++
		@nLin, 001 PSay If(mv_par19 == 1,"[C/ TX ADM]","[S/ TX ADM]") + Space(2) + "Operadora: " + cOper + ;
		Space(3) + "Empresa: " +cEmp + "-" + substr(cNmEmpA,1,15)+ ;
		Space(3) + "Contrato: " + cCont + "/" + cVercon + ;
		Space(3) + "Sub-Contrato: " + cSub + "/" +cVerSub+"-"+ substr(cNmSub,1,20) + "-" + cCodbloA+;
		Space(3) + "Mod. Pagto: " + if(cModPag == "1", "PP","CO")
		nLin ++
		
		cTexto := cEmp+" - "+Alltrim(cNmEmpA)+";"+cCont+"/"+cVercon+";"+cSub+"/"+cVerSub+"-"+Alltrim(cNmSub)+";"

		If nLin > 60
			Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
			nLin := 8
		End
		
		nLin += 2

		nTotUsr := 0
		nNroMes := 0

		While nPos <= len(aReceita) .and. cEmp+cCont+cVercon+cSub+cVersub== aReceita[npos,4]+ aReceita[npos,5]+ aReceita[npos,6]+ aReceita[npos,7]+ aReceita[npos,8]

			IncProc("Imprimindo Relat๓rio...")

			cAno     := aReceita[npos,1]
			cMes	 := aReceita[npos,2]
			nVlrMenA := aReceita[npos,9]
			nVlrAdiA := aReceita[npos,10]
			nVlrDes  := 0
			nPosVet  := aScan(aDespesa,{|x| x[1]+x[2]+x[3]+x[4]+x[5]+x[6]+x[7] == cAno+cMes+cEmp+cCont+cVercon+cSub+cVerSub})
			
			If nPosVet <> 0
				nVlrDes := aDespesa[nPosVet,8]
			Endif
			
			nQtdUsr:= 0
			nPosVet := aScan(aCntUsuario,{|x| x[1] == cAno+cMes+cEmp+cCont+cVercon+cSub+cVerSub})
			
			If nPosVet <> 0
				nQtdUsr:= aCntUsuario[nPosVet,2]
			Endif
			
			If nLin > 60
				Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
				nLin := 9
			End
			
			nTotalRec := nVlrMenA + nVlrAdiA
			nTotalLiq := nTotalRec - nVlrDes
			
			If cModPag == "1"        //pre-pagto
				nPercLiq := ((nVlrDes - nVlrAdiA) /nVlrMenA)*100
			Else
				nPercLiq := (nVlrDes /nTotalRec)*100
			Endif
			
			@nLin, 001 PSay cAno
			@nLin, 007 PSay cMes
			@nLin, 014 PSay Transform(nQtdUsr,"@E 999999")
			@nLin, 020 PSay Transform(nVlrMenA,"@E 999,999,999,999.99")
			@nLin, 037 PSay Transform(nVlrAdiA,"@E 999,999,999,999.99")
			@nLin, 054 PSay Transform(nTotalRec,"@E 999,999,999,999.99")
			@nLin, 077 PSay Transform(nVlrDes,"@E 999,999,999,999.99")
			
			@nLin, 099 PSay Transform(nTotalLiq,"@E 999,999,999,999.99")
			@nLin, 125 PSay Transform(nPercLiq,"@E 9999.99%")
			
			nSubRec  += nVlrMenA
			nSubAdi  += nVlrAdiA
			nSubTRec += nTotalRec
			nSubDes  += nVlrDes
			nSubLiq  += nTotalLiq
			
			nTotRec  += nVlrMenA
			nTotAdi  += nVlrAdiA
			nTotTRec += nTotalRec
			nTotDes  += nVlrDes
			nTotLiq  += nTotalLiq
			
			//Grava o ultimo registro impresso
			nTotUsr += nQtdUsr
			nNroMes++
			
			nLin ++
			nPos++
		Enddo
		@nLin, 001  PSay __PrtThinLine()
		nLin ++
		
		If cModPag == "1"        //pre-pagto
			nTotPLiq := ((nSubDes - nSubAdi) /nSubRec)*100
		Else
			nTotPLiq  := (nSubDes /nSubTRec)*100
		Endif
		
		@nLin, 001 PSay "TOTAL SUB-CONTRATO"
		@nLin, 020 PSay Transform(nSubRec,"@E 999,999,999,999.99")
		@nLin, 037 PSay Transform(nSubAdi,"@E 999,999,999,999.99")
		@nLin, 054 PSay Transform(nSubTRec,"@E 999,999,999,999.99")
		@nLin, 077 PSay Transform(nSubDes,"@E 999,999,999,999.99")
		@nLin, 099 PSay Transform(nSubLiq,"@E 999,999,999,999.99")
		@nLin, 125 PSay Transform(nTotPLiq,"@E 9999.99%")

		cTexto += Transform((nTotUsr/nNroMes),"@E 999999")+";"+Transform(nSubRec,"@E 999,999,999,999.99")+";"+Transform(nSubAdi,"@E 999,999,999,999.99")+";"+Transform(nSubTRec,"@E 999,999,999,999.99")+";"+Transform(nSubDes,"@E 999,999,999,999.99")+";"+Transform(nSubLiq,"@E 999,999,999,999.99")+";"+Transform(nTotPLiq,"@E 9999.99%")+";"

		If cImpLog == "1"
			GravaLog(cTexto)
		Endif
		
		nSubRec  := 0
		nSubAdi  := 0
		nSubTRec := 0
		nSubDes  := 0
		nSubLiq  := 0
		nSubRes  := 0
		
		nLin ++
		@nLin, 001  PSay __PrtFatLine()
		nLin ++
	End
Enddo

//Se quebra pแgina por contrato
If mv_par18 == 1
	Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
	nLin := 9
End

@nLin, 001  PSay __PrtThinLine()
nLin ++
@nLin, 001  PSay "TOTAL"
If mv_par17 == 1
	If cModPag == "1"        //pre-pagto
		nTotPLiq := ((nTotDes - nTotAdi) /nTotRec)*100
	Else
		nTotPLiq  := (nTotDes /nTotTRec)*100
	Endif
	@nLin, 042 PSay Transform(nTotRec,"@E 999,999,999,999.99")
	@nLin, 059 PSay Transform(nTotAdi,"@E 999,999,999,999.99")
	@nLin, 076 PSay Transform(nTotTRec,"@E 999,999,999,999.99")
	@nLin, 093 PSay Transform(nTotDes,"@E 999,999,999,999.99")
	@nLin, 110 PSay Transform(nTotRes,"@E 999,999,999,999.99")
	@nLin, 135 PSay Transform(nTotPLiq,"@E 9999.99%")
	
	
ElseIf mv_par17 == 2
	If cModPag == "1"        //pre-pagto
		nTotPLiq := ((nTotDes - nTotAdi) /nTotRec)*100
	Else
		nTotPLiq  := (nTotDes /nTotTRec)*100
	Endif
	@nLin, 020 PSay Transform(nTotRec,"@E 999,999,999,999.99")
	@nLin, 037 PSay Transform(nTotAdi,"@E 999,999,999,999.99")
	@nLin, 054 PSay Transform(nTotTRec,"@E 999,999,999,999.99")
	@nLin, 077 PSay Transform(nTotDes,"@E 999,999,999,999.99")
	@nLin, 099 PSay Transform(nTotLiq,"@E 999,999,999,999.99")
	@nLin, 125 PSay Transform(nTotPLiq,"@E 9999.99%")
End
nLin ++
@nLin, 001  PSay __PrtFatLine()

Set Device To Screen

If aReturn[5] == 1
	dbCommitAll()
	Set Printer To
	OurSpool(wnrel)
End

MS_FLUSH()

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ VldTit   บ Autor ณ Raquel             บ Data ณ  17/01/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Valida Grupo Cobranca cfme parametro                       บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function VldTit(cPrefix,cNum,cParc,cTip)
**********************

Local lVldTit := .T.

SE1->(DbSetOrder(01))
SE1->(MsSeek(xFilial("SE1")+(cPrefix+cNum+cParc+cTip)))

If SE1->E1_SALDO <> 0 // ainda deve
	lVldTit := .F.
Else
	If SE1->E1_FATPREF <> ''
		SE1->(DbSetOrder(01))
		SE1->(MsSeek(xFilial("SE1")+(SE1->E1_FATPREF+SE1->E1_FATURA)))
		cChave := xFilial("SE1")+(SE1->E1_FATPREF+SE1->E1_FATURA)
		While ! SE1->(Eof()) .and. cChave == SE1->(E1_FILIAL+E1_FATPREF+E1_FATURA)
			If Empty(SE1->E1_BAIXA)
				lVldTit := .F.
				exit
			Endif
			SE1->(Dbskip())
		Enddo
	Endif
Endif

return lVldTit

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณfSetSX1   บ Autor ณ Rafael             บ Data ณ  17/03/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Grava as perguntas referente ao relat๓rio.                 บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function fSetSX1
***********************

Local aTam
Local aHelpPor

aTam := TamSX3("E1_CODINT")
aHelpPor := {}
PutSx1(cPerg,"01","Operadora De ?","","","mv_ch1",aTam[3],aTam[1],aTam[2],0,"G","","B89","","","mv_par01","","","","","","","","","","","","","","","","",aHelpPor,{},{})

aTam := TamSX3("E1_CODINT")
aHelpPor := {}
PutSx1(cPerg,"02","Operadora At้ ?","","","mv_ch2",aTam[3],aTam[1],aTam[2],0,"G","","B89","","","mv_par02","","","","","","","","","","","","","","","","",aHelpPor,{},{})

aTam := TamSX3("E1_CODEMP")
aHelpPor := {}
PutSx1(cPerg,"03","Empresa De ?","","","mv_ch3",aTam[3],aTam[1],aTam[2],0,"G","","BYI","","","mv_par03","","","","","","","","","","","","","","","","",aHelpPor,{},{})

aTam := TamSX3("E1_CODEMP")
aHelpPor := {}
PutSx1(cPerg,"04","Empresa At้ ?","","","mv_ch4",aTam[3],aTam[1],aTam[2],0,"G","","BYI","","","mv_par04","","","","","","","","","","","","","","","","",aHelpPor,{},{})

aTam := TamSX3("E1_CONEMP")
aHelpPor := {}
PutSx1(cPerg,"05","Contrato De ?","","","mv_ch5",aTam[3],aTam[1],aTam[2],0,"G","","B7B","","","mv_par05","","","","","","","","","","","","","","","","",aHelpPor,{},{})

aTam := TamSX3("E1_CONEMP")
aHelpPor := {}
PutSx1(cPerg,"06","Contrato At้ ?","","","mv_ch6",aTam[3],aTam[1],aTam[2],0,"G","","B7B","","","mv_par06","","","","","","","","","","","","","","","","",aHelpPor,{},{})

aTam := TamSX3("E1_VERCON")
aHelpPor := {}
PutSx1(cPerg,"07","Versใo Contrato De ?","","","mv_ch7",aTam[3],aTam[1],aTam[2],0,"G","","","","","mv_par07","","","","","","","","","","","","","","","","",aHelpPor,{},{})

aTam := TamSX3("E1_VERCON")
aHelpPor := {}
PutSx1(cPerg,"08","Versใo Contrato At้ ?","","","mv_ch8",aTam[3],aTam[1],aTam[2],0,"G","","","","","mv_par08","","","","","","","","","","","","","","","","",aHelpPor,{},{})

aTam := TamSX3("E1_SUBCON")
aHelpPor := {}
PutSx1(cPerg,"09","Sub-Contrato De ?","","","mv_ch9",aTam[3],aTam[1],aTam[2],0,"G","","B7C","","","mv_par09","","","","","","","","","","","","","","","","",aHelpPor,{},{})

aTam := TamSX3("E1_SUBCON")
aHelpPor := {}
PutSx1(cPerg,"10","Sub-Contrato At้ ?","","","mv_cha",aTam[3],aTam[1],aTam[2],0,"G","","B7C","","","mv_par10","","","","","","","","","","","","","","","","",aHelpPor,{},{})

aTam := TamSX3("E1_VERSUB")
aHelpPor := {}
PutSx1(cPerg,"11","Versใo Sub-Contrato De ?","","","mv_chb",aTam[3],aTam[1],aTam[2],0,"G","","","","","mv_par11","","","","","","","","","","","","","","","","",aHelpPor,{},{})

aTam := TamSX3("E1_VERSUB")
aHelpPor := {}
PutSx1(cPerg,"12","Versใo Sub-Contrato At้ ?","","","mv_chc",aTam[3],aTam[1],aTam[2],0,"G","","","","","mv_par12","","","","","","","","","","","","","","","","",aHelpPor,{},{})

aTam := TamSX3("E1_MESBASE")
aHelpPor := {}
PutSx1(cPerg,"13","M๊s Base De ?","","","mv_chd",aTam[3],aTam[1],aTam[2],0,"G","","","","","mv_par13","","","","","","","","","","","","","","","","",aHelpPor,{},{})

aTam := TamSX3("E1_MESBASE")
aHelpPor := {}
PutSx1(cPerg,"14","M๊s Base At้ ?","","","mv_che",aTam[3],aTam[1],aTam[2],0,"G","","","","","mv_par14","","","","","","","","","","","","","","","","",aHelpPor,{},{})

aTam := TamSX3("E1_ANOBASE")
aHelpPor := {}
PutSx1(cPerg,"15","Ano Base De ?","","","mv_chf",aTam[3],aTam[1],aTam[2],0,"G","","","","","mv_par15","","","","","","","","","","","","","","","","",aHelpPor,{},{})

aTam := TamSX3("E1_ANOBASE")
aHelpPor := {}
PutSx1(cPerg,"16","Ano Base At้ ?","","","mv_chg",aTam[3],aTam[1],aTam[2],0,"G","","","","","mv_par16","","","","","","","","","","","","","","","","",aHelpPor,{},{})

aTam := {1, 0, "N"}
aHelpPor := {}
PutSx1(cPerg,"17","Tipo Relat๓rio ?","","","mv_chh",aTam[3],aTam[1],aTam[2],0,"C","","","","","mv_par17","Analitico","","","","Sintetico","","","","","","","","","","","",aHelpPor,{},{})

aTam := {1, 0, "N"}
aHelpPor := {}
PutSx1(cPerg,"18","Quebra pแgina por contrato ?","","","mv_chi",aTam[3],aTam[1],aTam[2],0,"C","","","","","mv_par18","Sim","","","","Nใo","","","","","","","","","","","",aHelpPor,{},{})

aTam := {1, 0, "N"}
aHelpPor := {}
PutSx1(cPerg,"19","Inclui taxa administrativa ?","","","mv_chj",aTam[3],aTam[1],aTam[2],0,"C","","","","","mv_par19","Sim","","","","Nใo","","","","","","","","","","","",aHelpPor,{},{})

aTam := TamSX3("BA3_MATRIC")
aHelpPor := {}
PutSx1(cPerg,"20","Matrํcula De ?","","","mv_chl",aTam[3],aTam[1],aTam[2],0,"G","","BAG","","","mv_par20","","","","","","","","","","","","","","","","",aHelpPor,{},{})

aTam := TamSX3("BA3_MATRIC")
aHelpPor := {}
PutSx1(cPerg,"21","Matrํcula At้ ?","","","mv_chm",aTam[3],aTam[1],aTam[2],0,"G","","BAG","","","mv_par21","","","","","","","","","","","","","","","","",aHelpPor,{},{})

aTam := TamSX3("BA1_TIPREG")
aHelpPor := {}
PutSx1(cPerg,"22","Tipo Registro De ?","","","mv_chn",aTam[3],aTam[1],aTam[2],0,"G","","","","","mv_par22","","","","","","","","","","","","","","","","",aHelpPor,{},{})

aTam := TamSX3("BA1_TIPREG")
aHelpPor := {}
PutSx1(cPerg,"23","Tipo Registro Ate ?","","","mv_cho",aTam[3],aTam[1],aTam[2],0,"G","","","","","mv_par23","","","","","","","","","","","","","","","","",aHelpPor,{},{})

aTam := {1, 0, "N"}
aHelpPor := {}
PutSx1(cPerg,"24","Situacao Sub-Contr.?","","","mv_chp",aTam[3],aTam[1],aTam[2],0,"C","","","","","mv_par24","Bloqueado","","","","Desbloqueado","","","Bloq/Desbloq","","","","","","","","",aHelpPor,{},{})

aTam := {1, 0, "N"}
aHelpPor := {}
PutSx1(cPerg,"25","Situacao Titulo","","","mv_chq",aTam[3],aTam[1],aTam[2],0,"C","","","","","mv_par25","Baixado","","","","Todos","","","","","","","","","","","",aHelpPor,{},{})

aTam := {80, 0, "C"}
aHelpPor := {}
PutSx1(cPerg,"26","Grupo de Cobranca","","","mv_chr",aTam[3],aTam[1],aTam[2],0,"G","","YZ7","","","mv_par26","","","","","","","","","","","","","","","","",aHelpPor,{},{})

aTam := {1, 0, "N"}
aHelpPor := {}
PutSx1(cPerg,"27","Tipo de Contrato","","","mv_chs",aTam[3],aTam[1],aTam[2],0,"C","","","","","mv_par27","Pessoa Fisica","","","","Pessoa Juridica","","","","","","","","","","","",aHelpPor,{},{})

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัอออออออออออออออออออออออหออออออัออออออออออปฑฑ
ฑฑบPrograma  ณ GravaLog บ Autor ณ Thiago Machado Correa บ Data ณ 15/02/08 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯอออออออออออออออออออออออสออออออฯออออออออออนฑฑ
ฑฑบDescricao ณ Grava log do resumo.						                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function GravaLog(cTexto)

Local nHandle := -1
Local cNomArq := "LogRelSin.txt"

If !File( cNomArq )
	nHandle := FCreate( cNomArq )
	FClose( nHandle )
Endif

If File( cNomArq )
	nHandle := FOpen( cNomArq, 2 )
	FSeek( nHandle, 0, 2 )
	FWrite( nHandle, cTexto + CRLF, Len(cTexto)+2 )
	FClose( nHandle) 
Endif

Return