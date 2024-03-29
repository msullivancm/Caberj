#INCLUDE "PLSR591.ch"
#include "PROTHEUS.CH"
#include "PLSMGER.CH"
/*/
������������������������������������������������������������������������������
������������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ���
���Funcao    � PLSR591 � Autor �Geraldo Felix Junior    � Data � 28.04.04 ����
�������������������������������������������������������������������������Ĵ���
���Descricao � Emissao do resumo de cobranca (Intercambio Eventual)       ����
�������������������������������������������������������������������������Ĵ���
���Sintaxe   � PLSR591                                                    ����
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
USER Function PLSR591NOVO(cmv_par01, cmv_par02, cmv_par03, cmv_par04, cmv_par05, cmv_par06, cmv_par07, cmv_par08)
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
PRIVATE cPerg       := "PLR591"
PRIVATE cRel        := "PLSR591NOVO"
PRIVATE nli         := 80
PRIVATE m_pag       := 1    
PRIVATE lCompres    := .F. 
PRIVATE lDicion     := .F. 
PRIVATE lFiltro     := .F. 
PRIVATE lCrystal    := .F. 
PRIVATE aOrderns    := {}
PRIVATE aReturn     := { "", 1,"", 1, 1, 1, "",1 } 
PRIVATE lAbortPrint := .F.
PRIVATE cCabec1     := "Lote      Gera��o  Refer�ncia                                         Total de servicos                        Taxas           Total"
//PRIVATE cCabec2     := STR0008  //"OPERADORA ORIGEM                          PRFX TITULO  PARC. TIPO QTD EVE. "
PRIVATE cCabec2		:= ""
//��������������������������������������������������������������������������Ŀ
//� Testa ambiente do relatorio somente top...                               �
//����������������������������������������������������������������������������
If ! PLSRelTop()
   Return
Endif    

BE4->(DbSetOrder(1))
BD5->(DbSetOrder(1))

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
Pergunte(cPerg,.F.)
If cMv_par01 # Nil
	mv_par01 := cMv_par01
	mv_par02 := cMv_par02
	mv_par03 := cMv_par03
	mv_par04 := cMv_par04
	mv_par05 := cMv_par05
	mv_par06 := cMv_par06	
	mv_par07 := cMv_par07
	mv_par08 := cMv_par08
Endif

If mv_par07 == 1
	cCabec2 := "Associado                                               Mat. Convenio      Data Proc.   Prestador                    Nr.Impresso           Procedimento                              Valor     Taxa Conv.         INSS   "
Endif

//��������������������������������������������������������������������������Ŀ
//� Chama SetPrint (padrao)                                                  �
//����������������������������������������������������������������������������
cRel := SetPrint(cAlias,cRel,cPerg,@cTitulo,cDesc1,cDesc2,cDesc3,lDicion,aOrderns,lCompres,cTamanho,{},lFiltro,lCrystal)
//��������������������������������������������������������������������������Ŀ
//� Verifica se foi cancelada a operacao (padrao)                            �
//����������������������������������������������������������������������������
If nLastKey  == 27 
   Return
Endif

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
LOCAL nQTDEVE	:= 0
LOCAL cTipInt   := GetNewPar("MV_PLSCDIE","1")
LOCAL cMatImpAnt:= ""
LOCAL _nTotUsrValor	:= 0
LOCAL _nTotUsrTaxa	:= 0
LOCAL _nTotUsrINSS	:= 0

Private _cChave := ""

//��������������������������������������������������������������������������Ŀ
//� Monta query...                                                           �
//����������������������������������������������������������������������������
cSQL := "SELECT * FROM "+cBTFName+","+cBTOName+" WHERE "
cSQL += "BTF_FILIAL = '"+xFilial("BTF")+"' AND "
cSQL += "BTF_CODOPE >= '"+mv_par01+"' AND "
cSQL += "BTF_CODOPE <= '"+mv_par02+"' AND "
cSQL += "BTF_NUMERO >= '"+mv_par03+"' AND "
cSQL += "BTF_NUMERO <= '"+mv_par04+"' AND "

cSQL += "BTO_OPEORI >= '"+mv_par05+"' AND "
cSQL += "BTO_OPEORI <= '"+mv_par06+"' AND "

cSQL += cBTFName+".D_E_L_E_T_ = '' AND "
cSQL += cBTOName+".D_E_L_E_T_ = '' AND "
cSql += "BTF_CODOPE = BTO_CODOPE   AND "
cSql += "BTF_NUMERO = BTO_NUMERO "
cSQL += "ORDER BY " + BTF->(IndexKey()) +"+BTO_STATUS"

PLSQuery(cSQL,"TRB1")

If TRB1->(Eof())
   TRB1->(DbCloseArea())
   Help("",1,"RECNO")
   Return
Endif
//��������������������������������������������������������������������������Ŀ
//� Exibe mensagem...                                                        �
//����������������������������������������������������������������������������
MsProcTxt(PLSTR0001) 

//��������������������������������������������������������������������������Ŀ
//� Inicio da impressao dos detalhes...                                      �
//����������������������������������������������������������������������������
While ! TRB1->(Eof())
	nLi := 80
	VldPag()

	//��������������������������������������������������������������������������Ŀ
	//� Referentes ao cabecalho do lote...                                       �
	//����������������������������������������������������������������������������			                           
	If mv_par07 <> 1
		@ nLi, 000 PSAY TRB1->BTF_NUMERO
		@ nLi, 010 PSAY dToc(TRB1->BTF_DATGER)
		@ nLi, 020 PSAY TRB1->BTF_ANOINI+"/"+TRB1->BTF_MESINI
		If TRB1->BTF_OPEGER > 0
			@ nLi, 036 PSAY StrZero(TRB1->BTF_OPEGER,4)
		Endif
		If TRB1->BTF_OPECRI > 0
			@ nLi, 045 PSAY StrZero(TRB1->BTF_OPECRI,4)
		Endif
		If TRB1->BTF_NOSELE > 0 
			@ nLi, 053 PSAY StrZero(TRB1->BTF_NOSELE,4)
		Endif
		//@ nLi, 059 PSAY Transform(TRB1->BTF_VLRCOP,"@E 99,999,999.99")
		@ nLi, 074 PSAY Transform(TRB1->(BTF_VLRCOP+BTF_VLRCP2+BTF_VLRCP3),"@E 99,999,999.99")
		/*
		If BTF->( FieldPos("BTF_VLRCP3") ) > 0
			@ nLi, 090 PSAY Transform(TRB1->BTF_VLRCP3,"@E 99,999,999.99")	
		Endif
		*/
		@ nLi, 103 PSAY Transform(TRB1->BTF_VLRTAX,"@E 99,999,999.99")	
		@ nLi, 118 PSAY Transform(TRB1->BTF_CUSTOT,"@E 99,999,999.99")
	Endif
	nLi += 2
	
	cLote := TRB1->BTF_NUMERO
	While !TRB1->( Eof() ) .and. TRB1->BTO_NUMERO == cLote

		
		If TRB1->BTO_STATUS == '1'
			//@ nLi, 000 PSAY STR0009 ; nLi++   	// FATURADAS
			//@ nLi, 000 PSAY "----------"		
			lFat := .T.
		Elseif TRB1->BTO_STATUS == '2'			// CRITICADAS
			//@ nLi, 000 PSAY STR0010	; nLi++
			//@ nLi, 000 PSAY "------------"
			lCri := .T.
		Else
			//@ nLi, 000 PSAY STR0011 ; nLi++		// NAO SELECIONADAS
			//@ nLi, 000 PSAY "-----------------"		
			lNoSel := .T.
		Endif	
		
		nLi++
		cStatus := TRB1->BTO_STATUS                           
		
		While !TRB1->( Eof() ) .and. TRB1->BTO_NUMERO == cLote .and. TRB1->BTO_STATUS == cStatus
		
			@ nLi, 000 PSAY TRB1->BTO_OPEORI+"-"
			@ nLi, 007 PSAY Left(Posicione("BA0",1,xFilial("BA0")+TRB1->BTO_OPEORI,"BA0_NOMINT"),18)
			@ nLi, 034 PSAY TRB1->BTO_PREFIX
			@ nLi, 039 PSAY TRB1->BTO_NUMTIT
			@ nLi, 046 PSAY TRB1->BTO_PARCEL
			@ nLi, 050 PSAY TRB1->BTO_TIPTIT
			@ nLi, 053 PSAY StrZero(TRB1->BTO_QTDEVE, 5)
			
			//@ nLi, 059 PSAY Transform(TRB1->BTO_VLRCOP,"@E 99,999,999.99")
			@ nLi, 074 PSAY Transform(TRB1->(BTO_VLRCOP+BTO_VLRCP2+BTO_VLRCP3),"@E 99,999,999.99")
			/*
			If BTO->( FieldPos("BTO_VLRCP3") ) > 0
				@ nLi, 090 PSAY Transform(TRB1->BTO_VLRCP3,"@E 99,999,999.99")	
			Endif		 
			*/
			@ nLi, 103 PSAY Transform(TRB1->BTO_VLRTAX,"@E 99,999,999.99")	
			@ nLi, 118 PSAY Transform(TRB1->BTO_CUSTOT,"@E 99,999,999.99")
			nLi++           
			
			_nTotValor	:= 0
			_nTotTaxa	:= 0
			_nTotINSS	:= 0			
			        
            If mv_par07 == 1 // Analitico
            	If lfat
					//��������������������������������������������������������������������Ŀ
					//� Busca a movimentacao da operadora por usuarios... somente analitico�
					//����������������������������������������������������������������������			        	            	
             		cSql := " SELECT BD6_CODOPE, BD6_CODEMP, BD6_MATRIC, BD6_TIPREG, BD6_DIGITO, BD6_DATPRO, "
             		cSql += " BD6_NOMUSR, BD6_CODRDA, BD6_NOMRDA, BD6_DESPRO, BD6_VLRTPF, BD6_VLRTAD, BD6_NUMIMP,  "
             		cSql += " BD6_CODOPE, BD6_CODLDP, BD6_CODPEG, BD6_NUMERO, BD6_ORIMOV, BD6_SEQUEN, BD6_CODPRO,  "
             		cSql += " BA1_YMTREP, "
             		cSql += " BAU_CODIGO, BAU_TIPPE, BAU_NOME "
            		cSql += " FROM "+cBDHName+" BDH,"+cBD6Name+" BD6, "+cBA1Name+" BA1, "+cBAUName+" BAU "
            		cSql += " WHERE BDH_OPEFAT = '"+TRB1->BTO_OPEORI+"' "
            		cSql += " AND BDH_NUMFAT = '"+TRB1->BTO_CODOPE+TRB1->BTO_NUMERO+"' "
            		cSql += " AND BDH_OPEORI = '"+TRB1->BTO_OPEORI+"' "
            		cSql += " AND BDH_CODINT = '"+TRB1->BTO_CODOPE+"' "
					cSql += " AND BA1_FILIAL = '"+xFilial("BA1")+"' "
					cSql += " AND BA1_CODINT = BDH_CODINT "
					cSql += " AND BA1_CODEMP = BDH_CODEMP "
					cSql += " AND BA1_MATRIC = BDH_MATRIC "
					cSql += " AND BA1_TIPREG = BDH_TIPREG "
					cSql += " AND BD6_FILIAL = '"+xFilial("BD6")+"' "
					cSql += " AND BD6_OPEUSR = BDH_CODINT "
					cSql += " AND BD6_CODEMP = BDH_CODEMP "
					cSql += " AND BD6_MATRIC = BDH_MATRIC "
					cSql += " AND BD6_TIPREG = BDH_TIPREG "
					cSql += " AND BD6_ANOPAG = BDH_ANOFT "
					cSql += " AND BD6_MESPAG = BDH_MESFT "
					cSql += " AND BD6_SEQPF =  BDH_SEQPF "
					cSql += " AND BD6_NUMSE1 = BDH_NUMSE1 "
					cSql += " AND BAU_FILIAL = '"+xFilial("BAU")+"' "
					cSql += " AND BAU_CODIGO = BD6_CODRDA "
					cSql += " AND BA1.D_E_L_E_T_ = ' ' "
					cSql += " AND BDH.D_E_L_E_T_ = ' ' "
					cSql += " AND BD6.D_E_L_E_T_ = ' ' "
					cSql += " AND BAU.D_E_L_E_T_ = ' ' "
            		cSql += " ORDER BY BD6_NOMUSR "
            		PlsQuery(cSql, "TRB2")
            		                              
					//��������������������������������������������������������������������Ŀ
					//� Imprime a movimentacao...                                          �
					//����������������������������������������������������������������������			        	            		
					//Modificada logica para Caberj.
					
					
            		TRB2->( dbGotop() )
            		@ nLi, 000 PSAY Replicate('-',215)
            		nLi++
            		
            		cMatImpAnt := "" 
            		
            		While !TRB2->( Eof() )
            		
						//��������������������������������������������������������������������������Ŀ
						//� Tratar campos vazios...                                                  �
						//����������������������������������������������������������������������������
						
						cDatPro := StoD("")
						cNumImp := ""
            			If Empty(TRB2->(BD6_DATPRO))
            			
            				If TRB2->BD6_ORIMOV == "1"
								If BD5->(MsSeek(xFilial("BD5")+TRB2->(BD6_CODOPE, BD6_CODLDP, BD6_CODPEG, BD6_NUMERO)))
									cDatPro := BD5->BD5_DATPRO
									cNumImp := BD5->BD5_NUMIMP
								Endif
							Else
	            				If BE4->(MsSeek(xFilial("BE4")+TRB2->(BD6_CODOPE, BD6_CODLDP, BD6_CODPEG, BD6_NUMERO)))
		            				cDatPro := BE4->BE4_DATPRO
		            				cNumImp := BE4->BE4_NUMIMP
	            				Endif
	      					Endif
            			Else
            				cDatPro := DtoC(TRB2->BD6_DATPRO)
            				cNumImp := TRB2->BD6_NUMIMP
            			Endif

						/*
						          10        20        30        40        50        60        70        80        90        100       110       120       130       140       150       160       170       180       190       200       210
						012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
						Associado                                               Mat. Convenio      Data Proc.   Prestador                    Nr.Impresso           Procedimento                        Valor     Taxa Conv.         INSS   "
						xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx-9.999.9999.999999.99-9  xxxxxxxxxxxxxxxxx   99/99/99    999999-xxxxxxxxxxxxxxxxxxxx  99999999999999999999  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx 999,999.99     999,999.99   999,999.99   "
						*/		
						
            		    _nMultINSS := Iif(TRB2->BAU_TIPPE=="F",0.2,0)
            		    

						//����������������������������������������������������Ŀ
						//� 12/2/08: Conforme regra solicitada, nao imprimir o �
						//� quando for o mesmo beneficiario nome e matricula...�
						//������������������������������������������������������			        	            		
						If TRB2->(BD6_CODOPE+BD6_CODEMP+BD6_MATRIC+BD6_TIPREG+BD6_DIGITO) <> cMatImpAnt

							If !Empty(cMatImpAnt)
			      				//Imprime totalizador somatorio / batimento de valores...
			            		@ nLi, 076 PSAY Replicate('-',139)
			            		nLi++
								@ nLi, 176 PSAY Transform(_nTotUsrValor,"@E 999,999.99")
								@ nLi, 191 PSAY Transform(_nTotUsrTaxa,"@E 999,999.99")
								@ nLi, 204 PSAY Transform(_nTotUsr,"@E 999,999.99") 
								nLi+=2
							Endif
							
							_nTotUsrValor	:= 0
							_nTotUsrTaxa	:= 0
							_nTotUsrINSS	:= 0

	            			@ nLi, 000 PSAY Left(TRB2->BD6_NOMUSR,31)+'-'+Transform(TRB2->(BD6_CODOPE+BD6_CODEMP+BD6_MATRIC+BD6_TIPREG+BD6_DIGITO),"@R !.!!!.!!!!.!!!!!!-!!-!")    //__cPictUsr
	            			@ nLi, 056 PSAY Alltrim(TRB2->BA1_YMTREP)+Space(17-Len(Alltrim(TRB2->BA1_YMTREP)))
            			Endif
						@ nLi, 076 PSAY cDatPro
						@ nLi, 088 PSAY TRB2->BD6_CODRDA+'-'+Substr(TRB2->BAU_NOME,1,20)
						@ nLi, 117 PSAY cNumImp
						@ nLi, 139 PSAY TRB2->BD6_CODPRO+Substr(TRB2->BD6_DESPRO,1,20)
						@ nLi, 176 PSAY Transform(TRB2->(BD6_VLRTPF-BD6_VLRTAD),"@E 999,999.99")
						@ nLi, 191 PSAY Transform(TRB2->(BD6_VLRTAD),"@E 999,999.99")
						@ nLi, 204 PSAY Transform(TRB2->(BD6_VLRTPF-BD6_VLRTAD)*_nMultINSS,"@E 999,999.99") //INSS (cfme regra Caberj - Marcela - somente cobra de PF.)
						//@ nLi, 198 PSAY Transform(TRB2->(BD6_VLRTPF-BD6_VLRTAD)*0.2,"@E 999,999.99") //INSS (cfme regra Caberj - Marcela - somente cobra de PF.)
						cMatImpAnt := TRB2->(BD6_CODOPE+BD6_CODEMP+BD6_MATRIC+BD6_TIPREG+BD6_DIGITO)
						
						//����������������������������������������������������Ŀ
						//� 12/2/08: Conforme solicitado pelo finenceiro, somar�
						//� o valor por usuario para totalizacao individual... �
						//������������������������������������������������������			        	            							
						_nTotUsrValor += TRB2->(BD6_VLRTPF-BD6_VLRTAD)
						_nTotUsrTaxa += TRB2->(BD6_VLRTAD)
						_nTotUsrINSS += TRB2->(BD6_VLRTPF-BD6_VLRTAD)*_nMultINSS
												
						_nTotValor += TRB2->(BD6_VLRTPF-BD6_VLRTAD)
						_nTotTaxa += TRB2->(BD6_VLRTAD)
						_nTotINSS += TRB2->(BD6_VLRTPF-BD6_VLRTAD)*_nMultINSS
						
            			nLi ++
            			TRB2->( dbSkip() )
            			lImprimiu := .T.
            			
            			VldPag()
            			
      				Enddo


					//����������������������������������������������������Ŀ
					//� 12/2/08: Imprime o ultimo totalizador por usuario. �
					//������������������������������������������������������			        	            												
					If !Empty(cMatImpAnt)
	      				//Imprime totalizador somatorio / batimento de valores...
	            		@ nLi, 076 PSAY Replicate('-',139)
	            		nLi+=2
						@ nLi, 176 PSAY Transform(_nTotUsrValor,"@E 999,999.99")
						@ nLi, 191 PSAY Transform(_nTotUsrTaxa,"@E 999,999.99")
						@ nLi, 204 PSAY Transform(_nTotUsrINSS,"@E 999,999.99") 
						nLi++
					Endif
      				      				
      				//Imprime totalizador somatorio / batimento de valores...
            		@ nLi, 000 PSAY Replicate('-',215)
            		nLi++
					@ nLi, 176 PSAY Transform(_nTotValor,"@E 999,999.99")
					@ nLi, 191 PSAY Transform(_nTotTaxa,"@E 999,999.99")
					@ nLi, 204 PSAY Transform(_nTotINSS,"@E 999,999.99") 
      				nLi ++
					
					
					/*
            		TRB2->( dbGotop() )
            		@ nLi, 000 PSAY Replicate('-',80)+;
            		nLi++
            		While !TRB2->( Eof() )
            			@ nLi, 000 PSAY Left(TRB2->BD6_NOMUSR,31)+'-'+;
            			Transform(TRB2->(BD6_CODOPE+BD6_CODEMP+BD6_MATRIC+BD6_TIPREG+BD6_DIGITO), __cPictUsr)

						If TRB2->( FieldPos("BDH_QTDEVE") ) <> 0
							@ nLi, 053 PSAY StrZero(TRB2->BDH_QTDEVE, 5)
						Else
							@ nLi, 053 PSAY StrZero(0, 5)
						Endif
						
						@ nLi, 059 PSAY Transform(TRB2->BDH_VLRCOP,"@E 99,999,999.99")
						@ nLi, 074 PSAY Transform(TRB2->(BDH_VLRCP2),"@E 99,999,999.99")
						If BDH->( FieldPos("BDH_VLRCP3") ) > 0
							@ nLi, 090 PSAY Transform(TRB2->BDH_VLRCP3,"@E 99,999,999.99")	
						Endif		 						
						@ nLi, 103 PSAY Transform(TRB2->BDH_VLRTAX,"@E 99,999,999.99")	
						@ nLi, 118 PSAY Transform(TRB2->(BDH_VLRCOP+BDH_VLRCP2+BDH_VLRTAX),"@E 99,999,999.99")
            			nLi ++
            			TRB2->( dbSkip() )
            			lImprimiu := .T.
            			
            			VldPag()
            			
      				Enddo
      				*/
      				
      				If lImprimiu
      					nLi++
      				Endif
      				TRB2->( dbClosearea() )
      			Elseif lCri 
      				BTG->( dbSetorder(02) )
      				If BTG->( dbSeek(xFilial("BTG")+TRB1->(BTF_CODOPE+BTF_NUMERO+BTO_SEQUEN)) )
	      				cNumCob := TRB1->BTF_NUMERO
	      				cSequen := TRB1->BTO_SEQUEN
	      				
	      				While !BTG->( Eof() ) .and. BTG->BTG_NUMERO == cNumCob .and. BTG->BTG_SEQUEN == cSequen
	      					@ nLi, 007 PSAY BTG->BTG_CODCRI+" - "+Posicione("SX5",1,xFilial("SX5")+"BI"+BTG->BTG_CODCRI,"X5_DESCRI")

	      					BTG->( dbSkip() ) 
	      					lImprimiu := .T.
	      					nLi++	      					
	      				Enddo
	      				If lImprimiu
	      					nLi++
	      				Endif
					Endif
      			Endif
      		Endif
      		lImprimiu := .F.
      		
			//��������������������������������������������������������������������Ŀ
			//� Sumariza as variaveis totalizadoras...                             �
			//����������������������������������������������������������������������			        	
			nVLRCOP	+= TRB1->BTO_VLRCOP
			nVLRCP2	+= TRB1->BTO_VLRCP2
			If BTO->( FieldPos("BTO_VLRCP3") ) > 0
				nVLRCP3 += TRB1->BTO_VLRCP3
			Endif
			nVLRTAX	+= TRB1->BTO_VLRTAX
			nCUSTOT	+= TRB1->BTO_CUSTOT
			nQTDEVE += TRB1->BTO_QTDEVE
			
 			TRB1->(DbSkip())
	 	Enddo
	 	@ nLi, 082 PSAY "Valor "
	 	@ nLi, 111 PSAY "Taxa "
	 	@ nLi, 126 PSAY "Total "
	 	nLi++
		@ nLi, 067 PSAY Replicate('-', 65); nLi++
		@ nLi, 037 PSAY STR0012 // TOTAIS --->
		//@ nLi, 053 PSAY StrZero(nQTDEVE, 5)
		
		//@ nLi, 059 PSAY Transform(nVLRCOP,"@E 99,999,999.99")
		@ nLi, 074 PSAY Transform(nVLRCOP+nVLRCP2+nVLRCP3,"@E 99,999,999.99")
		/*
		If BTO->( FieldPos("BTO_VLRCP3") ) > 0
			@ nLi, 090 PSAY Transform(nVLRCP3,"@E 99,999,999.99")
		Endif
		*/
		@ nLi, 103 PSAY Transform(nVLRTAX,"@E 99,999,999.99")	
		@ nLi, 118 PSAY Transform(nCUSTOT,"@E 99,999,999.99")		
		nLi 	+= 2

		//��������������������������������������������������������������������Ŀ
		//� Reseta as variaveis...                                             �
		//����������������������������������������������������������������������		
		lFat 	:= .F.
		lCri 	:= .F.
		lNoSel  := .F.
		
		nQTDEVE	:= 0
		nVLRCOP := 0
		nVLRCP2 := 0
		nVLRTAX := 0
		nCUSTOT := 0
 	Enddo
 	@ nLi, 000 PSAY Replicate('-',132)
Enddo
//��������������������������������������������������������������������Ŀ
//� Imprime rodape do relatorio...                                     �
//����������������������������������������������������������������������
Roda(0,space(10),cTamanho)
//��������������������������������������������������������������������Ŀ
//� Fecha arquivo...                                                   �
//����������������������������������������������������������������������
TRB1->(DbCloseArea())
//��������������������������������������������������������������������������Ŀ
//� Libera impressao                                                         �
//����������������������������������������������������������������������������
If  aReturn[5] == 1 
    Set Printer To
    Ourspool(cRel)
Endif

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
Endif 


Return
