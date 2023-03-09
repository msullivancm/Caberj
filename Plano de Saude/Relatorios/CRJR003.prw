	#include "PLSMGER.CH"

/*/
������������������������������������������������������������������������������
������������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ���
���Funcao    � CRJR003 � Autor � Geraldo Felix Junior   � Data � 05.11.07 ����
�������������������������������������������������������������������������Ĵ���
���Descricao � Relatorio de creditos nao alocados...                      ����
�������������������������������������������������������������������������Ĵ���
���Sintaxe   � CRJR0003                                                   ����
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
//� Define nome da funcao...                                                 �
//����������������������������������������������������������������������������
User Function CRJR003()
//��������������������������������������������������������������������������Ŀ
//� Define variavaoeis...                                                      �
//����������������������������������������������������������������������������
PRIVATE nQtdLin 	:= 58
PRIVATE cNomeProg   := "CRJR003"
PRIVATE nCaracter   := 15
PRIVATE nLimite     := 220
PRIVATE cTamanho    := "G"
PRIVATE cTitulo     := "Relatorio de Creditos nao Alocados"
PRIVATE cDesc1      := ""
PRIVATE cDesc2      := ""                         
PRIVATE cDesc3      := ""
PRIVATE cCabec1     := "                                                                                                      "
PRIVATE cCabec2     := ""
PRIVATE cAlias      := "BA3"
PRIVATE cPerg       := "CRJ003"
PRIVATE cRel        := "CRJR003"
PRIVATE nLi         := 01
PRIVATE m_pag       := 1
PRIVATE aReturn     := { "Zebrado", 1,"Administracao", 1, 1, 1, "",1 } 
PRIVATE lAbortPrint := .F.                                                                       
PRIVATE aOrdens     := { "Prefixo + Titulo + Parcela + Tipo" } 
PRIVATE lDicion     := .F.
PRIVATE lCompres    := .F.
PRIVATE lCrystal    := .F.
PRIVATE lFiltro     := .T.

cCabec1 := "Titulo           N. num   Plano                         Vencto    Baixa       Vlr Original     - Abatim   - Impostos      Vlr Liquido         - Pagtos    - Decresc     + Acresc            Saldo                "

/*      
		 10        20        30        40        50        60        70        80        90       100       110       120       130       140       150       160       170       180       190       200       210       220
1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
Titulo           N. num   Plano                         Vencto    Emissao     Vlr Original     - Abatim   - Impostos      Vlr Liquido         - Pagtos    - Decresc     + Acresc            Saldo                Observacoes       
999.999999 99   9999999   9999-99999999999999999999   99/99/99   99/99/99   999,999,999.99   999,999.99   999,999.99   999,999,999.99   999,999,999.99   999,999.99   999,999.99   999,999,999.99   999999999999999999999999
*/
//��������������������������������������������������������������������������Ŀ
//� Chama SetPrint                                                           �
//����������������������������������������������������������������������������
CriaSX1() 
cRel := SetPrint(cAlias,cRel,cPerg,@cTitulo,cDesc1,cDesc2,cDesc3,lDicion,aOrdens,lCompres,cTamanho,{},lFiltro,lCrystal)
//��������������������������������������������������������������������������Ŀ
//� Verifica se foi cancelada a operacao                                     �
//����������������������������������������������������������������������������
If nLastKey  == 27
   Return
Endif
//��������������������������������������������������������������������������Ŀ
//� Recebe parametros                                                        �
//����������������������������������������������������������������������������
Pergunte(cPerg,.F.)            
cOpe	:= mv_par01
cCLiDe	:= mv_par02
cCliAte	:= mv_par03
cPreDe	:= mv_par04
cPreAte := mv_par05
dEmiDe	:= mv_par06
dEmiAte := mv_par07
dBaiDe 	:= mv_par08
dBaiAte := mv_par09
cTipo   := mv_par10

//��������������������������������������������������������������������������Ŀ
//� Configura Impressora                                                     �
//����������������������������������������������������������������������������
SetDefault(aReturn,cAlias)

//��������������������������������������������������������������������������Ŀ
//� Monta RptStatus...                                                       �
//����������������������������������������������������������������������������
Proc2BarGauge({|| aCriticas := RJ003Imp()() }  , "Imprimindo...") 
                                                                              
//��������������������������������������������������������������������������Ŀ
//� Fim da Rotina Principal...                                               �
//����������������������������������������������������������������������������
Return


/*/
������������������������������������������������������������������������������
������������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ���
���Funcao    � RJ001Imp� Autor � Geraldo Felix Junior   � Data � 04.11.07 ����
�������������������������������������������������������������������������Ĵ���
���Descricao � Relatorio de contratos.                                    ����
��������������������������������������������������������������������������ٱ��
������������������������������������������������������������������������������
������������������������������������������������������������������������������
/*/
//��������������������������������������������������������������������������Ŀ
//� Define nome da funcao                                                    �
//����������������������������������������������������������������������������
Static Function RJ003Imp()
//��������������������������������������������������������������������������Ŀ
//� Variaveis do IndRegua...                                                 �
//����������������������������������������������������������������������������
LOCAL i
LOCAL n
LOCAL nTotMen 	:= 0
LOCAL nTotOpc 	:= 0
LOCAL nTotAde 	:= 0
LOCAL nTotDeb 	:= 0
LOCAL nTotCre 	:= 0
LOCAL nTotPar 	:= 0
LOCAL nTotTar	:= 0
LOCAL nTotPla	:= 0
LOCAL nTotFar	:= 0
LOCAL nTotal	:= 0
LOCAL pMoeda1	:= "@E 999,999.99"
LOCAL pMoeda2	:= "@E 999,999,999.99"
LOCAL nPos		:= 0
LOCAL nPosTit	:= 0
LOCAL nValBx 	:= 0
LOCAL nTotAbImp := 0
LOCAL nTotAbat  := 0
LOCAL nTotAbLiq	:= 0
LOCAL nTotBru	:= 0
LOCAL nTotAb1	:= 0
LOCAL nTotAb2	:= 0
LOCAL nTotLiq 	:= 0
LOCAL nTotBx  	:= 0
LOCAL nTotDec 	:= 0
LOCAL nTotAcr 	:= 0
LOCAL nTotSal 	:= 0

//��������������������������������������������������������������������������Ŀ
//� Exibe mensagem informativa...                                            �
//����������������������������������������������������������������������������
IncProcG1("Aguarde. Buscando dados no servidor...")
ProcessMessage()
//��������������������������������������������������������������������������Ŀ
//� Totalizadores por Empresa...                                             �
//����������������������������������������������������������������������������
PRIVATE nTotCobEmp := 0
PRIVATE nTotRegEmp := 0
Private aQtdusrEmp := 0
//��������������������������������������������������������������������������Ŀ
//� Totalizadores por Contrato...                                            �                                                     
//����������������������������������������������������������������������������
PRIVATE nTotCobCon := 0
PRIVATE nTotRegCon := 0
Private aQtdusrCon := 0
//��������������������������������������������������������������������������Ŀ
//� Totalizadores por SubContrato...                                         �
//����������������������������������������������������������������������������
PRIVATE nTotCobSub := 0
PRIVATE nTotRegSub := 0
PRIVATE nVlrCob    := 0
Private aQtdusrSub := 0

If !Empty(cTipo) .And. ! ";" $ cTipo .And. Len(AllTrim(cTipo)) > 3
	ApMsgAlert("Separe os tipos a imprimir (pergunta 08) por um ; (ponto e virgula) a cada 3 caracteres")
	Return(Nil)
Endif	
                                        
// Monta variaveis com os prefixo utilizados pelo SIGAPLS para gerar titulos no contas a receber...
SX5->( dbSetorder(01) )
cPrefixos := ''
If SX5->( dbSeek(xFilial("SX5")+"BK") )
	While SX5->( !Eof() ) .and. Alltrim(SX5->X5_TABELA) == 'BK'
		cPrefixos += IIf(Empty(cPrefixos), "", ";")+ Alltrim(SX5->X5_CHAVE)
		
		SX5->( dbSkip() )
	Enddo
Endif
	
//��������������������������������������������������������������������������Ŀ
//� Monta Expressao de filtro...                                             �
//����������������������������������������������������������������������������
cQuery := "SELECT SE1.R_E_C_N_O_ SE1RECNO "
cQuery += "FROM " + RetSqlName("SE1")+" SE1 "
cQuery += "WHERE "
cQuery += "		E1_FILIAL = '" + xFilial("SE1") + "' AND "
cQuery += "		E1_EMISSAO between '" + DTOS(dEmiDe) 	+ "' AND '" + DTOS(dEmiAte)		+ "' AND "
cQuery += "		E1_BAIXA   between '" + DTOS(dBaiDe) 	+ "' AND '" + DTOS(dBaiAte)		+ "' AND "
cQuery += "		E1_CLIENTE between '" + cCliDe			+ "' AND '" + cCliAte     		+ "' AND "

// Expressao de filtro do prefixo... mesmo que seja informado de "    " a "ZZZZ", deve se considerar apenas os prefixos do PLS.
If Empty(cPreDe) .and. (Empty(cPreAte) .or. Alltrim(Upper(cPreAte)) == 'ZZZZ')
	cQuery += "      E1_PREFIXO IN "+FormatIn(cPrefixos,";")

Else
	cQuery += "      E1_PREFIXO between '" + cPreDe      	+ "' AND '" + cPreAte 	    	+ "' "
	
Endif
If !Empty(cTipo) // Deseja imprimir apenas os tipos do parametro 10
	cQuery += " AND E1_TIPO IN "+FormatIn(cTipo)
Endif

// Nao considera abatimentos
cQuery += " AND E1_TIPO NOT IN " + FormatIn(MVABATIM,"|")

// Apenas titulos com saldos, ou seja, nao foram totalmente baixados...
cQuery += " AND E1_SALDO <> 0 "	

cQuery += " AND D_E_L_E_T_ = ' '  "

// seta a ordem de acordo com a opcao do usuario
cQuery += " ORDER BY E1_NUMBCO "
PlsQuery(cQuery, "TRB")
		
nQtd:=1
TRB->(DBEval( { | | nQtd ++ }))
BarGauge1Set(nQtd)               

TRB->(DbGoTop())

//��������������������������������������������������������������������������Ŀ
//� Define matriz de planos...                                               �
//����������������������������������������������������������������������������
SE5->(dbSetorder(7))
BA3->(dbSetorder(1))
BI3->(dbSetorder(1))

aTitulos := {}
nLi := 1000
While ! TRB->(Eof())
                                  
	SE1->( dbGoto(TRB->SE1RECNO) )
	
	//��������������������������������������������������������������������������Ŀ
	//� Apresenta mensagem em tela...                                            �
	//����������������������������������������������������������������������������
	IncProcG1("Titulo - "+SE1->E1_PREFIXO+'.'+SE1->E1_NUM+'.'+SE1->E1_PARCELA+'.'+SE1->E1_TIPO)
	ProcessMessage()

	// Se o titulo sofreu baixa, acesso o SE5 para obter o valor baixado...
	nValBx := 0
	If SE1->E1_VALOR <> SE1->E1_SALDO
		If SE5->( MsSeek(xFilial("SE5")+SE1->E1_PREFIXO+SE1->E1_NUM+SE1->E1_PARCELA+SE1->E1_TIPO+SE1->E1_CLIENTE+SE1->E1_LOJA) )
			
			While !SE5->( Eof() ) .and. SE5->E5_PREFIXO+SE5->E5_NUMERO+SE5->E5_PARCELA+SE5->E5_TIPO+SE5->E5_CLIFOR+SE5->E5_LOJA ==;
			                             SE1->E1_PREFIXO+SE1->E1_NUM+SE1->E1_PARCELA+SE1->E1_TIPO+SE1->E1_CLIENTE+SE1->E1_LOJA
				                             
				If SE5->E5_RECPAG == 'R' .and.;
					 SE5->E5_MOTBX # GetNewPar("MV_PLMOTBC","CAN") .and.;
					 !(SE5->E5_TIPODOC $ "DC, D2, JR, J2, TL, MT, M2, CM, C2, TR, TE")
					                         
					// Processa os estornos das baixas... se houverem.
				  	cQuery := "SELECT Sum(E5_VALOR) ESTORNO FROM "+RetSqlName("SE5")+" WHERE "
			   	cQuery += "E5_FILIAL='"+xFilial("SE5")+"' AND "
			   	cQuery += "E5_PREFIXO='"+SE5->E5_PREFIXO+"' AND "
					cQuery += "E5_NUMERO='"+SE5->E5_NUMERO+"' AND "
					cQuery += "E5_PARCELA='"+SE5->E5_PARCELA+"' AND "
					cQuery += "E5_TIPO='"+SE5->E5_TIPO+"' AND "
					cQuery += "E5_CLIFOR='"+SE5->E5_CLIFOR+"' AND "
					cQuery += "E5_LOJA='"+SE5->E5_LOJA+"' AND "
					cQuery += "E5_SEQ='"+SE5->E5_SEQ+"' AND "
					cQuery += "E5_TIPODOC='ES' AND "
					cQuery += "D_E_L_E_T_<>'*'"
					PlsQuery(cQuery, "EST")
			
					nVlrEst := EST->ESTORNO 
					EST->( dbCloseArea() )
					
					nValBx += SE5->E5_VALOR
					nValBx -= nVlrEst
		
				Endif
				SE5->( dbSkip() ) 
			Enddo
		Endif
	Endif
	
	//��������������������������������������������������������������������Ŀ
	//� Verifica se foi abortada a impressao...                            �
	//����������������������������������������������������������������������
	If  Interrupcao(lAbortPrint)
		Exit
	Endif           
/*
		 10        20        30        40        50        60        70        80        90       100       110       120       130       140       150       160       170       180       190       200       210       220
1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
Titulo           N. num   Plano                         Vencto    Emissao     Vlr Original     - Abatim   - Impostos      Vlr Liquido         - Pagtos    - Decresc     + Acresc            Saldo                Observacoes
999.999999 99   9999999   9999-99999999999999999999   99/99/99   99/99/99   999,999,999.99   999,999.99   999,999.99   999,999,999.99   999,999,999.99   999,999.99   999,999.99   999,999,999.99   999999999999999999999999
*/
	// Controle de saldo de pagina...
	If  nli > nQtdLin
    	nli := Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nCaracter)                                  
	    nli++               	
	Endif

	nTotAbImp := 0
	dbSelectArea("SE1")
	nTotAbat  := SumAbatRec(SE1->E1_PREFIXO,SE1->E1_NUM,SE1->E1_PARCELA,SE1->E1_MOEDA,"S",SE1->E1_BAIXA,@nTotAbImp) 
	nTotAbLiq := nTotAbat - nTotAbImp
                                        
	// Valor liquido
	nValorLiq :=  (SE1->E1_VALOR - nTotAbLiq - nTotAbImp)
	cPlano := ''	                                  
	If !Empty(SE1->E1_MATRIC)
		If BA3->( MsSeek(xFilial("BA3")+SE1->(E1_CODINT+E1_CODEMP+E1_MATRIC)) )
			If BI3->( MsSeek(xFilial("BI3")+BA3->BA3_CODINT+BA3->BA3_CODPLA+BA3->BA3_VERSAO) )
				cPlano := BA3->BA3_CODPLA+"-"+Substr(BI3->BI3_DESCRI, 1, 20)
			Endif
		Endif
	Endif
		
	@ nLi, 000 Psay SE1->E1_PREFIXO + '.' + SE1->E1_NUM + SE1->E1_PARCELA + SE1->E1_TIPO
    @ nLi, 017 Psay SE1->E1_NUMBCO
    @ nLi, 027 Psay cPlano
    @ nLi, 055 Psay dToc(SE1->E1_VENCTO)
    @ nLi, 066 Psay dToc(SE1->E1_BAIXA)       
    // Valor bruto
    @ nLi, 077 Psay Transform(SE1->E1_VALOR, pMoeda2); nTotBru += SE1->E1_VALOR
    // - Abatimentos
    @ nLi, 094 Psay Transform(nTotAbLiq, pMoeda1); nTotAb1 += nTotAbLiq
    // - Impostos
    @ nLi, 107 Psay Transform(nTotAbImp, pMoeda1); nTotAb2 += nTotAbImp
    // = Liquido
	@ nLi, 120 Psay Transform(nValorLiq, pMoeda2); nTotLiq += nValorLiq
	// - baixas
	@ nLi, 137 Psay Transform(nValBx, pMoeda2); nTotBx += nValBx
	// - saldo Decrescimo                                           
	@ nLi, 154 Psay Transform(SE1->E1_SDDECRE, pMoeda1); nTotDec += SE1->E1_SDDECRE
	// + saldo acrescimos
	@ nLi, 167 Psay Transform(SE1->E1_SDACRES, pMoeda1); nTotAcr += SE1->E1_SDACRES
	// Saldo liquido real.
	@ nLi, 180 Psay Transform(SE1->E1_SALDO, pMoeda2); nTotSal += SE1->E1_SALDO
	
 	nLi ++
	//��������������������������������������������������������������������Ŀ
	//� Fim do laco...                                                     �
	//����������������������������������������������������������������������
	TRB->( dbSkip() )
Enddo

// Imprime os totais gerais
If  nli > nQtdLin
	nli := Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nCaracter)
	nli++
Endif

@ nLi, 000 Psay Replicate('-', nLimite)
nLi++

@ nLi, 000 Psay "Totais"
// Valor bruto
@ nLi, 077 Psay Transform(nTotBru, pMoeda2)
// - Abatimentos
@ nLi, 094 Psay Transform(nTotAb1, pMoeda1)
// - Impostos
@ nLi, 107 Psay Transform(nTotAb2, pMoeda1)
// = Liquido
@ nLi, 120 Psay Transform(nTotLiq, pMoeda2)
// - baixas
@ nLi, 137 Psay Transform(nTotBx, pMoeda2)
// - saldo Decrescimo
@ nLi, 154 Psay Transform(nTotDec, pMoeda1)
// + saldo acrescimos
@ nLi, 167 Psay Transform(nTotAcr, pMoeda1)
// Saldo liquido real.
@ nLi, 180 Psay Transform(nTotSal, pMoeda2)

//��������������������������������������������������������������������Ŀ
//� Imprime rodape...                                                  �
//����������������������������������������������������������������������
Roda(0,Space(10))
//��������������������������������������������������������������������Ŀ
//� Fecha area de trabalho...                                          �
//����������������������������������������������������������������������
BA3->(DbClearFilter())
BA3->(RetIndex("BA3"))

TRB->( dbClosearea() )
//��������������������������������������������������������������������������Ŀ
//� Libera impressao                                                         �
//����������������������������������������������������������������������������
If  aReturn[5] == 1
    Set Printer To
    Ourspool(crel)
Endif
//��������������������������������������������������������������������������Ŀ
//� Fim da impressao do relatorio...                                         �
//����������������������������������������������������������������������������
Return()


/*/
������������������������������������������������������������������������������
������������������������������������������������������������������������������
��������������������������������������������������������������������������Ŀ��
���Programa   � CriaSX1   � Autor � Angelo Sperandio     � Data � 03.02.05 ���
��������������������������������������������������������������������������Ĵ��
���Descricao  � Atualiza SX1                                               ���
���������������������������������������������������������������������������ٱ�
������������������������������������������������������������������������������
/*/

Static Function CriaSX1()

Local aRegs	:=	{}

aadd(aRegs,{cPerg,"01","Operadora ?                ","","","mv_ch1","C", 4,0,0,"G",""           ,"mv_par01",""            	,"","","","",""               	,"","","","",""              	,"","","","",""       ,"","","","","","","","",IIf(PlsGetVersao() >= 8,"B89PLS","B89"),""})
aadd(aRegs,{cPerg,"02","Cliente de  ?              ","","","mv_ch2","C", 6,0,0,"G",""			  ,"mv_par02",""            	,"","","","",""               	,"","","","",""              	,"","","","",""       ,"","","","","","","","","",""})
aadd(aRegs,{cPerg,"03","Cliente ate ?              ","","","mv_ch3","C", 6,0,0,"G",""           ,"mv_par03",""            	,"","","","",""               	,"","","","",""              	,"","","","",""       ,"","","","","","","","","",""})
aadd(aRegs,{cPerg,"04","Prefixo de ?               	","","","mv_ch4","C", 4,0,0,"G",""           ,"mv_par04","" 		     	,"","","","",""			       	,"","","","",""         	 	,"","","","",""       ,"","","","","","","","","",""})
aadd(aRegs,{cPerg,"05","Prefixo ate ?            	","","","mv_ch5","C", 4,0,0,"G",""           ,"mv_par05",""            	,"","","","",""               	,"","","","",""              	,"","","","",""       ,"","","","","","","","","",""})
aadd(aRegs,{cPerg,"06","Emissao de ?            	","","","mv_ch6","D", 8,0,0,"G",""           ,"mv_par06",""            	,"","","","",""               	,"","","","",""              	,"","","","",""       ,"","","","","","","","","",""})
aadd(aRegs,{cPerg,"07","Emissao ate ?           	","","","mv_ch7","D", 8,0,0,"G",""           ,"mv_par07",""            	,"","","","",""               	,"","","","",""              	,"","","","",""       ,"","","","","","","","","",""})
aadd(aRegs,{cPerg,"08","Baixa de ?          		","","","mv_ch8","D", 8,0,0,"G",""           ,"mv_par08",""            	,"","","","",""               	,"","","","",""              	,"","","","",""       ,"","","","","","","","","",""})
aadd(aRegs,{cPerg,"09","Baixa ate ?        			","","","mv_ch9","D", 8,0,0,"G",""           ,"mv_par09",""            	,"","","","",""               	,"","","","",""              	,"","","","",""       ,"","","","","","","","","",""})
aadd(aRegs,{cPerg,"10","Imprimir os tipo ?        	","","","mv_cha","C",20,0,0,"G",""           ,"mv_par10",""            	,"","","","",""               	,"","","","",""              	,"","","","",""       ,"","","","","","","","","",""})

PlsVldPerg( aRegs )
    
Return
