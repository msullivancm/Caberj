#INCLUDE "PLSR591.ch"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "PLSMGER.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABR144   ºAutor  ³Leonardo Portella   º Data ³  07/08/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Emissao do resumo de cobranca (Intercambio eventual da      º±±
±±º          ³CABESP. Baseado no relatorio CABR129.                       º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³CABERJ                                                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CABR144(cmv_par01, cmv_par02, cmv_par03)

Private nQtdLin     := 60
Private nLimite     := 220
Private cTamanho    := "G"
Private cTitulo     := "Relatório de Despesas de Convênios Reciprocidade - CABESP"
Private cDesc1      := STR0002//"Este Relatorio tem como objetivo emitir resumo demonstrando a composicao de"
Private cDesc2      := STR0003//"um lote de cobranca."
Private cDesc3      := ""
Private cAlias      := "BDC"
Private cPerg       := "CABR144"
Private cRel        := "CABR144"
Private nli         := 80
Private m_pag       := 1
Private lCompres    := .F.
Private lDicion     := .F.
Private lFiltro     := .F.
Private lCrystal    := .F.
Private aOrderns    := {}
Private aReturn     := { "", 1,"", 1, 1, 1, "",1 }
Private lAbortPrint := .F.
Private cCabec1     := "Lote      Geraçào  Referência                                         Total de servicos                        Taxas           Total       "
Private cCabec2		:= ""
Private aGerINSS	:= {}
Private nTitInss	:= 0
Private cAnoTit 	:= ""
Private cMesTit		:= ""

If ! PLSRelTop()
	Return
EndIf

BE4->(DbSetOrder(1))
BD5->(DbSetOrder(1))
SZ8->(DbSetOrder(1)	)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         				³
//³ mv_par01 // Operadora Inicial                          						³
//³ mv_par02 // Operado Final                                    				³
//³ mv_par03 // Numero Cobranca incial                    						³
//³ mv_par04 // Numero Cobranca Final                            				³
//³ mv_par05 // Operadora inicial                                				³
//³ mv_par06 // Operadora final                                  				³
//³ mv_par07 // Tipo de relatorio  ? analitico/resumido/sintetico				³
//³ mv_par08 // Demonstra criticas ?                             				³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

AjustaSX1()

Pergunte(cPerg,.F.)

If cMv_par01 # Nil
	mv_par01 := cMv_par01
	mv_par02 := cMv_par02
	mv_par03 := cMv_par03
EndIf

If mv_par03 == 1
	cCabec2 := "Tipo      Associado                                               Mat. Convenio      Data Proc.   Prestador                    Nr.Impresso           Procedimento                              Valor     Taxa Conv.            "
EndIf

cRel := SetPrint(cAlias,cRel,cPerg,@cTitulo,cDesc1,cDesc2,cDesc3,lDicion,aOrderns,lCompres,cTamanho,{},lFiltro,lCrystal)

If nLastKey  == 27
	Return
EndIf

SetDefault(aReturn,cAlias)

Processa({||r591Imp()},cTitulo,"",.T.)

Ms_Flush()

Return

*****************************************************************************************************************************************************

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa   ³ r591Imp  ³ Autor ³Geraldo Felix Junior...³ Data ³ 28.04.04 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao  ³ Imprime detalhe do relatorio...                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/

Static Function r591Imp()

Local cSQL
Local cBTFName 		:= BTF->(RetSQLName("BTF"))
Local cBTOName 		:= BTO->(RetSQLName("BTO"))
Local cBDHName 		:= BDH->(RetSQLName("BDH"))
Local cBA1Name 		:= BA1->(RetSQLName("BA1"))
Local cBD6Name 		:= BD6->(RetSQLName("BD6"))
Local cBAUName 		:= BAU->(RetSQLName("BAU"))
Local cStatus		:= ''
Local cLote			:= ''
Local cNumCob 		:= ''
Local cSequen 		:= ''
Local lFat			:= .F.
Local lCri			:= .F.
Local lNosel		:= .F.
Local lImprimiu 	:= .F.
Local nVLRCOP		:= 0
Local nVLRCP2		:= 0
Local nVLRCP3		:= 0
Local nVLRTAX		:= 0
Local nCUSTOT		:= 0
Local nCUSINSS		:= 0
Local nQTDEVE		:= 0
Local cTipInt   	:= GetNewPar("MV_PLSCDIE","1")
Local cMatImpAnt	:= ""
Local _nTotUsrValor	:= 0
Local _nTotUsrTaxa	:= 0
Local _nTotUsrINSS	:= 0
Local cOpeBTO		:= "" 
Local n_Inc			:= 10

Private _cChave 	:= ""

_nTotValor	:= 0
_nTotTaxa	:= 0
_nTotINSS	:= 0

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Busca a movimentacao da operadora por usuarios... somente analitico³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 

cSql := " SELECT DECODE(BCI_TIPGUI,'01','CONSULTA','02','SADT','03', 'INTER.','04','REEMBOL.','05','INTER.','06','HON. IND.','-') TIPO_GUIA,"		+ CRLF
cSql += " BD6_CODOPE, BD6_CODEMP, BD6_MATRIC, BD6_TIPREG, BD6_DIGITO, BD6_DATPRO, " 																+ CRLF
cSql += " BD6_NOMUSR, BD6_CODRDA, BD6_NOMRDA, BD6_DESPRO, BD6_VLRTPF, BD6_VLRTAD, BD6_NUMIMP,  " 													+ CRLF
cSql += " BD6_CODOPE, BD6_CODLDP, BD6_CODPEG, BD6_NUMERO, BD6_ORIMOV, BD6_SEQUEN, BD6_CODPRO,  "   													+ CRLF
cSql += " BA1_YMTREP, BAU_CODIGO, BAU_TIPPE, BAU_NOME " 										  													+ CRLF
cSql += " FROM "+cBDHName+" BDH,"+cBD6Name+" BD6, "+cBA1Name+" BA1, "+cBAUName+" BAU," + RetSqlName('BCI') + " BCI  " 								+ CRLF
cSql += " WHERE BDH_OPEFAT = '1008' " 															  													+ CRLF
cSql += " AND BDH_NUMFAT >= '0001"+MV_PAR01+"' " 												 													+ CRLF
cSql += " AND BDH_NUMFAT <= '0001"+MV_PAR02+"' " 												 													+ CRLF
cSql += " AND BDH_CODINT = '0001' " 															  													+ CRLF
cSql += " AND BA1_FILIAL = '"+xFilial("BA1")+"' " 												  													+ CRLF
cSql += " AND BA1_CODINT = BDH_CODINT " 														   													+ CRLF
cSql += " AND BA1_CODEMP = BDH_CODEMP " 														   													+ CRLF
cSql += " AND BA1_MATRIC = BDH_MATRIC " 														  													+ CRLF
cSql += " AND BA1_TIPREG = BDH_TIPREG " 														 													+ CRLF
cSql += " AND BD6_FILIAL = '"+xFilial("BD6")+"' " 												 													+ CRLF
cSql += " AND BD6_OPEUSR = BDH_CODINT " 														  													+ CRLF
cSql += " AND BD6_CODEMP = BDH_CODEMP " 														  													+ CRLF
cSql += " AND BD6_MATRIC = BDH_MATRIC " 														  													+ CRLF
cSql += " AND BD6_TIPREG = BDH_TIPREG " 														  													+ CRLF
cSql += " AND BD6_ANOPAG = BDH_ANOFT " 																												+ CRLF
cSql += " AND BD6_MESPAG = BDH_MESFT " 																												+ CRLF
cSql += " AND BD6_SEQPF  = BDH_SEQPF " 													   															+ CRLF
cSql += " AND BD6_PREFIX = BD6_PREFIX " 														   													+ CRLF
cSql += " AND BD6_NUMTIT = BD6_NUMTIT " 														   													+ CRLF
cSql += " AND BAU_FILIAL = '"+xFilial("BAU")+"' " 												  													+ CRLF
cSql += " AND BAU_CODIGO = BD6_CODRDA " 														  													+ CRLF
cSql += " AND BA1.D_E_L_E_T_ = ' ' " 															  													+ CRLF
cSql += " AND BDH.D_E_L_E_T_ = ' ' " 																												+ CRLF
cSql += " AND BD6.D_E_L_E_T_ = ' ' " 															   													+ CRLF
cSql += " AND BAU.D_E_L_E_T_ = ' ' " 																												+ CRLF
cSql += " AND BCI_FILIAL = ' '  " 																													+ CRLF
cSql += " AND BCI_CODOPE = BD6_CODOPE " 																											+ CRLF
cSql += " AND BCI_CODLDP = BD6_CODLDP " 																											+ CRLF
cSql += " AND BCI_CODPEG = BD6_CODPEG " 																											+ CRLF
cSql += " AND BCI.D_E_L_E_T_ = ' '  " 																												+ CRLF
cSql += " ORDER BY BCI_TIPGUI,BD6_NOMUSR " 														 													+ CRLF

PlsQuery(cSql, "TRB2") 

COUNT TO n_Cont 

ProcRegua(n_Cont)

c_Tot 	:= AllTrim(Transform(n_Cont,'@E 999,999,999'))
n_Cont 	:= 0

TRB2->(DbGoTop())

n_VlrTipo 	:= 0 
n_TaxTipo	:= 0
c_TipoGuia	:= ''
					
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime a movimentacao...                                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//Modificada logica para Caberj. 

While !TRB2->( Eof() )
	
	IncProc('Processando linha ' + AllTrim(Transform(++n_Cont,'@E 999,999,999')) + ' de ' + c_Tot)
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Tratar campos vazios...                                                  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	VldPag()						
	cDatPro := StoD("")
	cNumImp := ""
	
	If Empty(TRB2->(BD6_DATPRO))

		If TRB2->BD6_ORIMOV == "1"
		
			If BD5->(MsSeek(xFilial("BD5")+TRB2->(BD6_CODOPE, BD6_CODLDP, BD6_CODPEG, BD6_NUMERO)))
				cDatPro := BD5->BD5_DATPRO
				cNumImp := BD5->BD5_NUMIMP
			EndIf  
			
		Else
		
			If BE4->(MsSeek(xFilial("BE4")+TRB2->(BD6_CODOPE, BD6_CODLDP, BD6_CODPEG, BD6_NUMERO)))
				cDatPro := BE4->BE4_DATPRO
				cNumImp := BE4->BE4_NUMIMP
			EndIf  
			
		EndIf

	Else
		cDatPro := DtoC(TRB2->BD6_DATPRO)
		cNumImp := TRB2->BD6_NUMIMP
	EndIf
						
	_nMultINSS := Iif(TRB2->BAU_TIPPE == "F",0.2,0)
	
	n_Inc := 10
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Conforme regra solicitada, nao imprimir o          ³
	//³ quando for o mesmo beneficiario nome e matricula...³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
 
	If TRB2->(BD6_CODOPE+BD6_CODEMP+BD6_MATRIC+BD6_TIPREG+BD6_DIGITO) <> cMatImpAnt
	
		If !Empty(cMatImpAnt)
			//Imprime totalizador somatorio / batimento de valores...
			If mv_par03 == 1
				@ nLi, 076 + n_Inc PSAY Replicate('-',139 - n_Inc)
				nLi++
				@ nLi, 176 + n_Inc PSAY Transform(_nTotUsrValor,"@E 999,999.99")
				@ nLi, 191 + n_Inc PSAY Transform(_nTotUsrTaxa,"@E 999,999.99")
				nLi+=2
				
				n_VlrTipo += _nTotUsrValor
				n_TaxTipo += _nTotUsrTaxa
			EndIf

		EndIf
			
        _nTotUsrValor	:= 0
		_nTotUsrTaxa	:= 0
		
		If TRB2->(TIPO_GUIA) <> c_TipoGuia 
			
			If !empty(c_TipoGuia) .and. ( mv_par03 == 1 )
				@ nLi, 0 			PSAY Replicate('-',215)
				nLi++
				@ nLi, 0 			PSAY 'TOTAL TIPO [ ' + AllTrim(c_TipoGuia) + ' ]'
				@ nLi, 172 + n_Inc 	PSAY Transform(n_VlrTipo,"@E 999,999,999.99")
				@ nLi, 187 + n_Inc 	PSAY Transform(n_TaxTipo,"@E 999,999,999.99")
				nLi+=2
				
				n_VlrTipo 	:= 0 
				n_TaxTipo	:= 0
			EndIf
			
			c_TipoGuia 	:= TRB2->(TIPO_GUIA)
			
	    EndIf

		If mv_par03 == 1
			@ nLi, 000 			PSAY PadR(TRB2->TIPO_GUIA,9)
			@ nLi, 000 + n_Inc 	PSAY Left(TRB2->BD6_NOMUSR,31)+'-'+Transform(TRB2->(BD6_CODOPE+BD6_CODEMP+BD6_MATRIC+BD6_TIPREG+BD6_DIGITO), "@R !.!!!.!!!!.!!!!!!-!!-!")   //"@R !!!.!!!!.!!!!!!-!!-!"
			@ nLi, 056 + n_Inc 	PSAY Alltrim(TRB2->BA1_YMTREP)+Space(17-Len(Alltrim(TRB2->BA1_YMTREP)))
		EndIf

	EndIf
						
	If mv_par03 == 1

		@ nLi, 076 + n_Inc  PSAY cDatPro
		@ nLi, 088 + n_Inc  PSAY TRB2->BD6_CODRDA+'-'+Substr(TRB2->BAU_NOME,1,20)
		@ nLi, 117 + n_Inc  PSAY cNumImp
		@ nLi, 139 + n_Inc  PSAY TRB2->BD6_CODPRO+Substr(TRB2->BD6_DESPRO,1,20)
		@ nLi, 176 + n_Inc  PSAY Transform(TRB2->(BD6_VLRTPF-BD6_VLRTAD),"@E 999,999.99")
		@ nLi, 191 + n_Inc  PSAY Transform(TRB2->(BD6_VLRTAD),"@E 999,999.99")
		nLi ++
		lImprimiu := .T.
		
	EndIf
						
	cMatImpAnt := TRB2->(BD6_CODOPE+BD6_CODEMP+BD6_MATRIC+BD6_TIPREG+BD6_DIGITO)
						
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Conforme solicitado pelo financeiro, somar         ³
	//³ o valor por usuario para totalizacao individual... ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

	_nTotUsrValor 	+= TRB2->(BD6_VLRTPF-BD6_VLRTAD)
	_nTotUsrTaxa 	+= TRB2->(BD6_VLRTAD)
	
	_nTotValor 		+= TRB2->(BD6_VLRTPF-BD6_VLRTAD)
	_nTotTaxa 		+= TRB2->(BD6_VLRTAD)
    
	TRB2->( dbSkip() )

	VldPag()
						
EndDo			
					
If !Empty(cMatImpAnt)
	If mv_par03 == 1
		//Imprime totalizador somatorio / batimento de valores...
		@ nLi, 076 + n_Inc  PSAY Replicate('-',139 - n_Inc)
		nLi+=2
		@ nLi, 176 + n_Inc  PSAY Transform(_nTotUsrValor,"@E 999,999.99")
		@ nLi, 191 + n_Inc  PSAY Transform(_nTotUsrTaxa,"@E 999,999.99")
		nLi++
			
		n_VlrTipo += _nTotUsrValor
		n_TaxTipo += _nTotUsrTaxa
	EndIf
EndIf
		
If TRB2->(TIPO_GUIA) <> c_TipoGuia 
	
	If !empty(c_TipoGuia) .and. ( mv_par03 == 1 )
		@ nLi, 0 			PSAY Replicate('-',215)
		nLi++
		@ nLi, 0 			PSAY 'TOTAL TIPO [ ' + AllTrim(c_TipoGuia) + ' ]'
		@ nLi, 172 + n_Inc 	PSAY Transform(n_VlrTipo,"@E 999,999,999.99")
		@ nLi, 187 + n_Inc 	PSAY Transform(n_TaxTipo,"@E 999,999,999.99")
		nLi+=2     
		
		n_VlrTipo 	:= 0 
		n_TaxTipo	:= 0
	EndIf
	
	c_TipoGuia 	:= TRB2->(TIPO_GUIA)
	
EndIf

//Imprime totalizador somatorio / batimento de valores...
If mv_par03 == 1
	@ nLi, 000 + n_Inc  PSAY Replicate('-',215 - n_Inc)
	nLi++
	@ nLi, 173 + n_Inc  PSAY Transform(_nTotValor,"@E 99,999,999.99")
	@ nLi, 188 + n_Inc  PSAY Transform(_nTotTaxa,"@E 99,999,999.99")
	@ nLi, 201 + n_Inc  PSAY Transform(_nTotINSS,"@E 99,999,999.99")
	nLi ++
EndIf

If lImprimiu
	nLi++
EndIf

TRB2->(DbCloseArea())
		
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime rodape do relatorio...                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Roda(0,space(10),cTamanho)

If  aReturn[5] == 1
	Set Printer To
	Ourspool(cRel)
EndIf

DbSelectArea("BDC")

Return

*****************************************************************************************************************************************************

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa   ³ R590Cabec ³ Autor ³Geraldo Felix Junior. ³ Data ³ 28.04.04 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao  ³ Imprime Cabecalho                                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/

Static Function R590Cabec()

nLi := Cabec(cTitulo,cCabec1,cCabec2,cRel,cTamanho,IIF(aReturn[4]==1,GetMv("MV_COMP"),GetMv("MV_NORM")))
nLi ++

Return

*****************************************************************************************************************************************************

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa   ³ VLDPAG    ³ Autor ³Geraldo Felix Junior. ³ Data ³ 28.04.04 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao  ³ Valida a proxima pagina...                                 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/

Static Function VldPag()

If nLi > nQtdLin
	R590Cabec()
EndIf

Return
      
*****************************************************************************************************************************************************

Static Function AjustaSX1

PutSx1(cPerg,"01","Lote Int. Event.De ?          "  ,"","","mv_ch01","C",8,0,0,"G","","BJ8PLS"	,"","","mv_par01",""			,"","","",""				,"","",""				,"","","","","","","","",{},{},{})
PutSx1(cPerg,"02","Lote Int. Event.Ate ?         "  ,"","","mv_ch02","C",8,0,0,"G","","BJ8PLS"	,"","","mv_par02",""			,"","","",""				,"","",""				,"","","","","","","","",{},{},{})
PutSx1(cPerg,"03","Modelo ?                      "  ,"","","mv_ch03","N",1,0,0,"C","",""		,"","","mv_par03","Analitico"	,"","","","Sintetico"  		,"","","Resumido"		,"","","","","","","","",{},{},{})

Return