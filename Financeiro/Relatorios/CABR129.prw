#INCLUDE "PLSR591.ch"
#include "PROTHEUS.CH"
#include "PLSMGER.CH"
/*/
������������������������������������������������������������������������������
������������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ���
���Funcao    � RIN591  � Autor �Geraldo Felix Junior    � Data � 28.04.04 ����
�������������������������������������������������������������������������Ĵ���
���Descricao � Emissao do resumo de cobranca (Intercambio Eventual)       ����
�������������������������������������������������������������������������Ĵ���
���Sintaxe   � RIN591                                                     ����
�������������������������������������������������������������������������Ĵ���
��� Uso      � Advanced Protheus                                          ����
�������������������������������������������������������������������������Ĵ���
��� Alteracoes desde sua construcao inicial                               ����                            
�������������������������������������������������������������������������Ĵ���
��� Data     � BOPS � Programador � Breve Descricao                       ����
�������������������������������������������������������������������������Ĵ���
��������������������������������������������������������������������������ٱ��
������������������������������������������������������������������������������
������������������������������������������������������������������������������
/*/
//��������������������������������������������������������������������������Ŀ
//� Define nome da funcao                                                    �
//����������������������������������������������������������������������������
USER Function CABR129(cmv_par01, cmv_par02, cmv_par03, cmv_par04, cmv_par05, cmv_par06, cmv_par07, cmv_par08)
//��������������������������������������������������������������������������Ŀ
//� Define variaveis padroes para todos os relatorios...                     �
//����������������������������������������������������������������������������
PRIVATE nQtdLin     := 60
PRIVATE nLimite     := 220
PRIVATE cTamanho    := "G"
PRIVATE cTitulo     := "Relat�rio de Despesas de Conv�nios Reciprocidade"
PRIVATE cDesc1      := STR0002 //"Este Relatorio tem como objetivo emitir resumo demonstrando a composicao de"
PRIVATE cDesc2      := STR0003  //"um lote de cobranca."
PRIVATE cDesc3      := ""
PRIVATE cAlias      := "BDC"
PRIVATE cPerg       := "PLR129"

//Leonardo Portella - Alterado o nome do relatorio pois existe outro PLSR591NOVO e de qualquer maneira deve corresponder
//ao nome do PRW
PRIVATE cRel        := 'CABR129'//"PLSR591NOVO" 

PRIVATE nli         := 80
PRIVATE m_pag       := 1
PRIVATE lCompres    := .F.
PRIVATE lDicion     := .F.
PRIVATE lFiltro     := .F.
PRIVATE lCrystal    := .F.
PRIVATE aOrderns    := {}
PRIVATE aReturn     := { "", 1,"", 1, 1, 1, "",1 }
PRIVATE lAbortPrint := .F.
PRIVATE cCabec1     := "Lote      Gera��o  Refer�ncia                                         Total de servicos                        Taxas           Total       "
//PRIVATE cCabec2     := STR0008  //"OPERADORA ORIGEM                          PRFX TITULO  PARC. TIPO QTD EVE. "
PRIVATE cCabec2		:= ""
PRIVATE aGerINSS		:= {}
PRIVATE nTitInss		:= 0
PRIVATE cAnoTit 		:= ""
PRIVATE cMesTit		:= ""

//��������������������������������������������������������������������������Ŀ
//� Testa ambiente do relatorio somente top...                               �
//����������������������������������������������������������������������������
If ! PLSRelTop()
	Return
EndIf

BE4->(DbSetOrder(1))
BD5->(DbSetOrder(1))
SZ8->(DbSetOrder(1)	)

//�����������������������������������������������������������������������������Ŀ
//� Variaveis utilizadas para parametros                         				�
//� mv_par01 // Operadora Inicial                          						�
//� mv_par02 // Operado Final                                    				�
//� mv_par03 // Numero Cobranca incial                    						�
//� mv_par04 // Numero Cobranca Final                            				�
//� mv_par05 // Operadora inicial                                				�
//� mv_par06 // Operadora final                                  				�
//� mv_par07 // Tipo de relatorio  ? analitico/resumido/sintetico				�
//� mv_par08 // Demonstra criticas ?                             				�
//�������������������������������������������������������������������������������

Pergunte(cPerg,.T.)

If cMv_par01 # Nil
	mv_par01 := cMv_par01
	mv_par02 := cMv_par02
	mv_par03 := cMv_par03
	mv_par04 := cMv_par04
	mv_par05 := cMv_par05
	mv_par06 := cMv_par06
	mv_par07 := cMv_par07
	mv_par08 := cMv_par08
EndIf

If mv_par07 == 1
	cCabec2 := "Tipo      Associado                                               Mat. Convenio      Data Proc.   Prestador                    Nr.Impresso           Procedimento                              Valor     Taxa Conv.            "
EndIf

//��������������������������������������������������������������������������Ŀ
//� Chama SetPrint (padrao)                                                  �
//����������������������������������������������������������������������������
cRel := SetPrint(cAlias,cRel,cPerg,@cTitulo,cDesc1,cDesc2,cDesc3,lDicion,aOrderns,lCompres,cTamanho,{},lFiltro,lCrystal)
//��������������������������������������������������������������������������Ŀ
//� Verifica se foi cancelada a operacao (padrao)                            �
//����������������������������������������������������������������������������
If nLastKey  == 27
	Return
EndIf

//��������������������������������������������������������������������������Ŀ
//� Configura impressora (padrao)                                            �
//����������������������������������������������������������������������������
SetDefault(aReturn,cAlias)

//��������������������������������������������������������������������������Ŀ
//� Emite relat�rio                                                          �
//����������������������������������������������������������������������������
MsAguarde({|| r591Imp() }, cTitulo, "", .T.)

//��������������������������������������������������������������������������Ŀ
//� Libera threads                                                           �
//����������������������������������������������������������������������������
Ms_Flush()

//��������������������������������������������������������������������������Ŀ
//� Fim da rotina                                                            �
//����������������������������������������������������������������������������
Return
/*/
������������������������������������������������������������������������������
������������������������������������������������������������������������������
��������������������������������������������������������������������������Ŀ��
���Programa   � r591Imp  � Autor �Geraldo Felix Junior...� Data � 28.04.04 ���
��������������������������������������������������������������������������Ĵ��
���Descricao  � Imprime detalhe do relatorio...                            ���
���������������������������������������������������������������������������ٱ�
������������������������������������������������������������������������������
/*/
Static Function r591Imp()
//��������������������������������������������������������������������������Ŀ
//� Define variaveis...                                                      �
//����������������������������������������������������������������������������
LOCAL cSQL
LOCAL cBTFName 	:= BTF->(RetSQLName("BTF"))
LOCAL cBTOName 	:= BTO->(RetSQLName("BTO"))
LOCAL cBDHName 	:= BDH->(RetSQLName("BDH"))
LOCAL cBA1Name 	:= BA1->(RetSQLName("BA1"))
LOCAL cBD6Name 	:= BD6->(RetSQLName("BD6"))
LOCAL cBAUName 	:= BAU->(RetSQLName("BAU"))
LOCAL cStatus	:= ''
LOCAL cLote		:= ''
LOCAL cNumCob 	:= ''
LOCAL cSequen 	:= ''
LOCAL lFat		:= .F.
LOCAL lCri		:= .F.
LOCAL lNosel	:= .F.
LOCAL lImprimiu := .F.
LOCAL nVLRCOP	:= 0
LOCAL nVLRCP2	:= 0
LOCAL nVLRCP3	:= 0
LOCAL nVLRTAX	:= 0
LOCAL nCUSTOT	:= 0
LOCAL nCUSINSS	:= 0
LOCAL nQTDEVE	:= 0
LOCAL cTipInt   := GetNewPar("MV_PLSCDIE","1")
LOCAL cMatImpAnt:= ""
LOCAL _nTotUsrValor	:= 0
LOCAL _nTotUsrTaxa	:= 0
LOCAL _nTotUsrINSS	:= 0
LOCAL cOpeBTO		:= "" 
Local n_Inc			:= 10//Leonardo Portella - 06/08/14

Private _cChave := ""

_nTotValor	:= 0
_nTotTaxa	:= 0
_nTotINSS	:= 0

//��������������������������������������������������������������������Ŀ
//� Busca a movimentacao da operadora por usuarios... somente analitico�
//���������������������������������������������������������������������� 

//Leonardo Portella - 30/03/15 - Diferenciacao de SADT para SADT Internado
//Leonardo Portella - 13/06/14 - Incluido o JOIN com a BCI para ver o TIPGUI, pois em alguns casos BD5_TIPGUI estava diferente de BD6_TIPGUI

cSql := "SELECT Q.* FROM ("	 																														+ CRLF
cSql += " SELECT"																																	+ CRLF 
cSql += "     CASE WHEN BCI_TIPGUI = '02'"																											+ CRLF
cSql += "       THEN"																																+ CRLF 
cSql += "         CASE WHEN"																														+ CRLF 
cSql += "           ( SELECT BD5_REGATE"																											+ CRLF 
cSql += "             FROM " + RetSqlName('BD5') + " BD5"																							+ CRLF
cSql += "             WHERE BD5_FILIAL = '" + xFilial('BD5') + "'"																					+ CRLF  
cSql += "               AND BD5_CODOPE = BD6_CODOPE"																								+ CRLF
cSql += "               AND BD5_CODLDP = BD6_CODLDP"																								+ CRLF
cSql += "               AND BD5_CODPEG = BD6_CODPEG"																								+ CRLF
cSql += "               AND BD5_NUMERO = BD6_NUMERO"																								+ CRLF
cSql += "               AND BD5.D_E_L_E_T_ = ' '"																									+ CRLF
cSql += "           ) = '1' THEN 'SADT INT.' ELSE 'SADT' END"																						+ CRLF
cSql += "       ELSE"																																+ CRLF
cSql += "         DECODE(BCI_TIPGUI,'01','CONSULTA','03', 'INTER.','04','REEMBOL.','05','INTER.','06','HON. IND.','-')"								+ CRLF  
cSql += "     END TIPO_GUIA,"																														+ CRLF
cSql += " BD6_CODEMP, BD6_MATRIC, BD6_TIPREG, BD6_DIGITO, BD6_DATPRO, " 																			+ CRLF
cSql += " BD6_NOMUSR, BD6_CODRDA, BD6_NOMRDA, BD6_DESPRO, BD6_VLRTPF, BD6_VLRTAD, BD6_NUMIMP,  " 													+ CRLF
cSql += " BD6_CODOPE, BD6_CODLDP, BD6_CODPEG, BD6_NUMERO, BD6_ORIMOV, BD6_SEQUEN, BD6_CODPRO,  "   													+ CRLF
cSql += " BA1_YMTREP, " 																		   													+ CRLF
cSql += " BAU_CODIGO, BAU_TIPPE, BAU_NOME " 													  													+ CRLF
cSql += " FROM "+cBDHName+" BDH,"+cBD6Name+" BD6, "+cBA1Name+" BA1, "+cBAUName+" BAU," + RetSqlName('BCI') + " BCI  " 								+ CRLF
cSql += " WHERE BDH_OPEFAT = '0001' " 															  													+ CRLF
cSql += " AND BDH_NUMFAT >= '0001"+MV_PAR03+"' " 												 													+ CRLF
cSql += " AND BDH_NUMFAT <= '0001"+MV_PAR04+"' " 												 													+ CRLF
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

//Leonardo Portella - 10/06/14 - Ordenar pelo tipo de guia
cSql += ") Q ORDER BY TIPO_GUIA,BD6_NOMUSR " 														 													+ CRLF
//cSql += " ORDER BY BD6_NOMUSR "    

PlsQuery(cSql, "TRB2")

n_VlrTipo 	:= 0 
n_TaxTipo	:= 0
c_TipoGuia	:= ''
					
//��������������������������������������������������������������������Ŀ
//� Imprime a movimentacao...                                          �
//����������������������������������������������������������������������
//Modificada logica para Caberj. 

While !TRB2->( Eof() )

	//��������������������������������������������������������������������������Ŀ
	//� Tratar campos vazios...                                                  �
	//����������������������������������������������������������������������������
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
						
	/*
	10        20        30        40        50        60        70        80        90        100       110       120       130       140       150       160       170       180       190       200       210
	012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
	Associado                                               Mat. Convenio      Data Proc.   Prestador                    Nr.Impresso           Procedimento                        Valor     Taxa Conv.         INSS   "
	xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx-9.999.9999.999999.99-9  xxxxxxxxxxxxxxxxx   99/99/99    999999-xxxxxxxxxxxxxxxxxxxx  99999999999999999999  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx 999,999.99     999,999.99   999,999.99   "
	*/
						
	_nMultINSS := Iif(TRB2->BAU_TIPPE == "F",0.2,0)
	
	n_Inc := 10//Leonardo Portella - 10/06/14 - Inclusao do tipo de guia. Variavel para alinhamento do relatorio.
	
	//����������������������������������������������������Ŀ
	//� 12/2/08: Conforme regra solicitada, nao imprimir o �
	//� quando for o mesmo beneficiario nome e matricula...�
	//������������������������������������������������������
 
	If TRB2->(BD6_CODOPE+BD6_CODEMP+BD6_MATRIC+BD6_TIPREG+BD6_DIGITO) <> cMatImpAnt
	
		If !Empty(cMatImpAnt)
			//Imprime totalizador somatorio / batimento de valores...
			If mv_par07 == 1
				@ nLi, 076 + n_Inc PSAY Replicate('-',139 - n_Inc)
				nLi++
				@ nLi, 176 + n_Inc PSAY Transform(_nTotUsrValor,"@E 999,999.99")
				@ nLi, 191 + n_Inc PSAY Transform(_nTotUsrTaxa,"@E 999,999.99")
//				@ nLi, 204 PSAY Transform(_nTotUsrINSS,"@E 999,999.99")
				nLi+=2
				
				n_VlrTipo += _nTotUsrValor //Leonardo Portella - 13/06/14
				n_TaxTipo += _nTotUsrTaxa  //Leonardo Portella - 13/06/14
			EndIf

		EndIf
			
        _nTotUsrValor	:= 0
		_nTotUsrTaxa	:= 0
//		_nTotUsrINSS	:= 0

		//Leonardo Portella - 13/06/14 - Inicio - Total por tipo de guia
		
		If TRB2->(TIPO_GUIA) <> c_TipoGuia 
			
			If !empty(c_TipoGuia) .and. ( mv_par07 == 1 )
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
	    
	    //Leonardo Portella - 13/06/14 - Fim

		If mv_par07 == 1
			@ nLi, 000 			PSAY PadR(TRB2->TIPO_GUIA,9)//Leonardo Portella - 10/06/14
			@ nLi, 000 + n_Inc 	PSAY Left(TRB2->BD6_NOMUSR,31)+'-'+Transform(TRB2->(BD6_CODOPE+BD6_CODEMP+BD6_MATRIC+BD6_TIPREG+BD6_DIGITO), "@R !.!!!.!!!!.!!!!!!-!!-!")   //"@R !!!.!!!!.!!!!!!-!!-!"
			@ nLi, 056 + n_Inc 	PSAY Alltrim(TRB2->BA1_YMTREP)+Space(17-Len(Alltrim(TRB2->BA1_YMTREP)))
		EndIf

	EndIf
						
	If mv_par07 == 1

		@ nLi, 076 + n_Inc  PSAY cDatPro
		@ nLi, 088 + n_Inc  PSAY TRB2->BD6_CODRDA+'-'+Substr(TRB2->BAU_NOME,1,20)
		@ nLi, 117 + n_Inc  PSAY cNumImp
		@ nLi, 139 + n_Inc  PSAY TRB2->BD6_CODPRO+Substr(TRB2->BD6_DESPRO,1,20)
		@ nLi, 176 + n_Inc  PSAY Transform(TRB2->(BD6_VLRTPF-BD6_VLRTAD),"@E 999,999.99")
		@ nLi, 191 + n_Inc  PSAY Transform(TRB2->(BD6_VLRTAD),"@E 999,999.99")
//		@ nLi, 204 PSAY Transform(TRB2->(BD6_VLRTPF-BD6_VLRTAD)*_nMultINSS,"@E 999,999.99") //INSS (cfme regra Caberj - Marcela - somente cobra de PF.)
		//@ nLi, 198 PSAY Transform(TRB2->(BD6_VLRTPF-BD6_VLRTAD)*0.2,"@E 999,999.99") //INSS (cfme regra Caberj - Marcela - somente cobra de PF.)
		nLi ++
		lImprimiu := .T.
		
	EndIf
						
	cMatImpAnt := TRB2->(BD6_CODOPE+BD6_CODEMP+BD6_MATRIC+BD6_TIPREG+BD6_DIGITO)
						
	//����������������������������������������������������Ŀ
	//� 12/2/08: Conforme solicitado pelo finenceiro, somar�
	//� o valor por usuario para totalizacao individual... �
	//������������������������������������������������������

	_nTotUsrValor += TRB2->(BD6_VLRTPF-BD6_VLRTAD)
	_nTotUsrTaxa += TRB2->(BD6_VLRTAD)
//	_nTotUsrINSS += TRB2->(BD6_VLRTPF-BD6_VLRTAD)*_nMultINSS
	
	_nTotValor += TRB2->(BD6_VLRTPF-BD6_VLRTAD)
	_nTotTaxa += TRB2->(BD6_VLRTAD)
//	_nTotINSS += TRB2->(BD6_VLRTPF-BD6_VLRTAD)*_nMultINSS
    
	TRB2->( dbSkip() )

	VldPag()
						
EndDo			
					
//����������������������������������������������������Ŀ
//� 12/2/08: Imprime o ultimo totalizador por usuario. �
//������������������������������������������������������
If !Empty(cMatImpAnt)
	If mv_par07 == 1
		//Imprime totalizador somatorio / batimento de valores...
		@ nLi, 076 + n_Inc  PSAY Replicate('-',139 - n_Inc)
		nLi+=2
		@ nLi, 176 + n_Inc  PSAY Transform(_nTotUsrValor,"@E 999,999.99")
		@ nLi, 191 + n_Inc  PSAY Transform(_nTotUsrTaxa,"@E 999,999.99")
//		@ nLi, 204 PSAY Transform(_nTotUsrINSS,"@E 999,999.99")
		nLi++
			
		n_VlrTipo += _nTotUsrValor //Leonardo Portella - 13/06/14
		n_TaxTipo += _nTotUsrTaxa  //Leonardo Portella - 13/06/14
	EndIf
EndIf

//Leonardo Portella - 13/06/14 - Inicio - Ultimo total por tipo de guia
		
If TRB2->(TIPO_GUIA) <> c_TipoGuia 
	
	If !empty(c_TipoGuia) .and. ( mv_par07 == 1 )
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
    
//Leonardo Portella - 13/06/14 - Fim

//Imprime totalizador somatorio / batimento de valores...
If mv_par07 == 1
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
		
//��������������������������������������������������������������������Ŀ
//� Imprime rodape do relatorio...                                     �
//����������������������������������������������������������������������
Roda(0,space(10),cTamanho)
//��������������������������������������������������������������������Ŀ
//� Fecha arquivo...                                                   �
//����������������������������������������������������������������������

//��������������������������������������������������������������������������Ŀ
//� Libera impressao                                                         �
//����������������������������������������������������������������������������
If  aReturn[5] == 1
	Set Printer To
	Ourspool(cRel)
EndIf

//��������������������������������������������������������������������������Ŀ
//� Fim do Relat�rio                                                         �
//����������������������������������������������������������������������������
DbSelectArea("BDC")

Return

/*/
������������������������������������������������������������������������������
������������������������������������������������������������������������������
��������������������������������������������������������������������������Ŀ��
���Programa   � R590Cabec � Autor �Geraldo Felix Junior. � Data � 28.04.04 ���
��������������������������������������������������������������������������Ĵ��
���Descricao  � Imprime Cabecalho                                          ���
���������������������������������������������������������������������������ٱ�
������������������������������������������������������������������������������
/*/
Static Function R590Cabec()
//��������������������������������������������������������������������������Ŀ
//� Imprime cabecalho...                                                     �
//����������������������������������������������������������������������������
nLi := Cabec(cTitulo,cCabec1,cCabec2,cRel,cTamanho,IIF(aReturn[4]==1,GetMv("MV_COMP"),GetMv("MV_NORM")))
nLi ++

Return
/*/
������������������������������������������������������������������������������
������������������������������������������������������������������������������
��������������������������������������������������������������������������Ŀ��
���Programa   � VLDPAG    � Autor �Geraldo Felix Junior. � Data � 28.04.04 ���
��������������������������������������������������������������������������Ĵ��
���Descricao  � Valida a proxima pagina...                                 ���
���������������������������������������������������������������������������ٱ�
������������������������������������������������������������������������������
/*/
Static Function VldPag()

If nLi > nQtdLin
	R590Cabec()
EndIf


Return


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �AjustaSX1 �Autor  �Microsiga           � Data �  15/08/08   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �PLSR591NOVO�Autor  �Microsiga           � Data �  08/15/08   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function IncTitINSS(aGerINSS)
Local nCont := 0

Begin Transaction

For nCont := 1 to Len(aGerINSS)

	lMsErroAuto := .F.
	MsExecAuto({|x,y| Fina040(x,y)},aGerINSS[nCont],3)
	If lMsErroAuto
		DisarmTransaction()
		MostraErro()
	EndIf   
		
	SZ8->(RecLock("SZ8",.T.))
	SZ8->Z8_FILIAL := xFilial("SZ8")
	SZ8->Z8_PREORI := "PLS"
	SZ8->Z8_NUMORI := aGerINSS[nCont,2,2] 
	SZ8->Z8_PARORI := aGerINSS[nCont,3,2]
	SZ8->Z8_TIPORI := aGerINSS[nCont,4,2]
	SZ8->Z8_PREFIX := aGerINSS[nCont,1,2] 
	SZ8->Z8_NUMTIT := aGerINSS[nCont,2,2] 
	SZ8->Z8_PARCEL := aGerINSS[nCont,3,2] 
	SZ8->Z8_TIPTIT := aGerINSS[nCont,4,2] 		
	SZ8->(MsUnlock())

Next
			
End Transaction 

Return Nil




/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �DesfazTit �Autor  �Microsiga           � Data �  15/08/08   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function DesfazTit(cPrefixo, cNumero, cParcela, cTipo)
Local lRet := .F.
Local aAreaSE1 := SE1->(GetArea())

If SE1->(MsSeek(xFilial("SE1")+cPrefixo+cNumero+cParcela+cTipo))
           
	Begin Transaction 
	
	aGerINSS := {{"E1_PREFIXO" ,cPrefixo,Nil},;
					{"E1_NUM"     ,cNumero,Nil},;
					{"E1_PARCELA" ,cParcela,Nil},;
					{"E1_TIPO"    ,cTipo,Nil}}/*,;
					{"E1_VALOR"   ,_nTotInss ,Nil},;
					{"E1_NATUREZ" ,GetNewPar("MV_YNTINS",SE1->E1_NATUREZ),Nil},;
					{"E1_CLIENTE" ,SE1->E1_CLIENTE,Nil},;
					{"E1_LOJA"    ,SE1->E1_LOJA ,Nil},;
					{"E1_EMISSAO" ,dDataBase,Nil},;
					{"E1_EMIS1"   ,dDataBase,Nil},;
					{"E1_HIST"    ,"TIT.INSS GERADO PELO PLSR591",Nil},;
					{"E1_VENCTO"  ,Iif(SE1->E1_VENCTO < dDataBase,dDataBase,SE1->E1_VENCTO),Nil},; 
					{"E1_VENCREA" ,DataValida(Iif(SE1->E1_VENCTO < dDataBase,dDataBase,SE1->E1_VENCTO)),Nil},;	                    	
					{"E1_MESBASE" ,SE1->E1_MESBASE,Nil},;
					{"E1_ANOBASE" ,SE1->E1_ANOBASE,Nil},;	                    	
					{"E1_PORCJUR" ,SE1->E1_PORCJUR,Nil} }*/
	
	lMsErroAuto := .F.
	MsExecAuto({|x,y| Fina040(x,y)},aGerINSS,5) //Exclusao de titulos
	If lMsErroAuto
		DisarmTransaction()
		MostraErro()	
	Else
	                       
	   If SZ8->(Found())
			SZ8->(RecLock("SZ8",.F.))
			SZ8->(DbDelete())
			SZ8->(MsUnlock())
		EndIf
		
	EndIf
	
	
	End Transaction

EndIf

RestArea(aAreaSE1)

Return lRet