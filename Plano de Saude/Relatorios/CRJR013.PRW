#include "PLSMGER.CH"
#Define cCodigosPF "104,116,117,123,124,125,127,134,137,138,139,140,141,142,143,144,145,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,177"

Static cCodDB     := PLSRETLADC()        
/*/
������������������������������������������������������������������������������
������������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ���
���Funcao    � CRJR013 � Autor � Jean Schulz            � Data � 24.11.00 ����
�������������������������������������������������������������������������Ĵ���
���Descricao � Relatorio de opcionais e debitos / creditos		          ����
�������������������������������������������������������������������������Ĵ���
���Sintaxe   � CRJR013                                                    ����
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
User Function CRJR013()

LOCAL aCampos	:= {	{"TR1_CODIGO"    	, "C", TamSX3("BI3_CODIGO")[1]	, 0 },;
						{"TR1_ANO" 			, "C", TamSX3("BM1_ANO")[1]		, 0 },;
						{"TR1_MES"			, "C", TamSX3("BM1_MES")[1]		, 0 },;
						{"TR1_TIPEVE"		, "C", 1						, 0 },;
						{"TR1_CODTIP"		, "C", TamSX3("BM1_CODTIP")[1]	, 0 },;
						{"TR1_CODEVE"		, "C", TamSX3("BM1_CODEVE")[1]	, 0 },;
						{"TR1_DESEVE"		, "C", TamSX3("BM1_DESEVE")[1]	, 0 },;
						{"TR1_TIPCOB"		, "C", TamSX3("E1_FORMREC")[1]	, 0 },;
						{"TR1_BAIXA"		, "D", 8						, 0 },;						
						{"TR1_VENCTO"		, "D", 8						, 0 },;
						{"TR1_VALOR"		, "N", TamSX3("BM1_VALOR")[1]	, 2 }}


//��������������������������������������������������������������������������Ŀ
//� Define variavaoeis...                                                      �
//����������������������������������������������������������������������������
PRIVATE nQtdLin 	:= 58
PRIVATE cNomeProg   := "CRJR013"
PRIVATE nCaracter   := 15
PRIVATE nLimite     := 220
PRIVATE cTamanho    := "G"
PRIVATE cTitulo     := "Relatorio de opcionais e debitos / creditos"
PRIVATE cDesc1      := ""
PRIVATE cDesc2      := ""                         
PRIVATE cDesc3      := ""
PRIVATE cCabec1     := "                                                                                                      "
PRIVATE cCabec2     := ""
PRIVATE cAlias      := "BA3"
PRIVATE cPerg       := "CRJ013"
PRIVATE cRel        := "CRJR013"
PRIVATE nLi         := 01
PRIVATE m_pag       := 1
PRIVATE aReturn     := { "Zebrado", 1,"Administracao", 1, 1, 1, "",1 } 
PRIVATE lAbortPrint := .F.                                                                       
PRIVATE aOrdens     := { "Codigo do plano" } 
PRIVATE lDicion     := .F.
PRIVATE lCompres    := .F.
PRIVATE lCrystal    := .F.
PRIVATE lFiltro     := .T.

//��������������������������������������������������������������������������Ŀ
//� Monta Expressao de filtro...                                             �
//����������������������������������������������������������������������������
cCodDB := StrTRan(cCodDB, ' ', '')

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

cOpe     	:= mv_par01
_cMes    	:= mv_par02
_cAno    	:= mv_par03
               
cTexto := "- Folha de pagamento"

cTitulo := AllTrim(cTitulo) + " - " + PLRETMES(Val(_cMes)) + "/" + _cAno + ' ' + cTexto

//��������������������������������������������������������������������������Ŀ
//� Configura Impressora                                                     �
//����������������������������������������������������������������������������
SetDefault(aReturn,cAlias)
                                                                              
//��������������������������������������������������������������������������Ŀ
//� Cria o Arquivo de Trabalho que tera todos os pagamentos medicos...       �
//����������������������������������������������������������������������������
cArqTRB := CriaTrab(aCampos, .T.)
		
dbUseArea(.T.,,cArqTRB,"TRB1",.F.)

//��������������������������������������������������������������������������Ŀ
//� Cria Indice 1 do Arquivo de Trabalho...                                  �
//����������������������������������������������������������������������������
cInd1TRB := CriaTrab(Nil, .F.)

IndRegua("TRB1",cInd1TRB,"TR1_CODIGO + TR1_ANO + TR1_MES + TR1_TIPEVE + TR1_CODTIP + TR1_CODEVE",,,"Indexando Arquivo de Trabalho")
cCabec1 := "Plano - Descricao                       Referencia     Tipo       Lancamento        Evento Descricao evento                         Valor"	

TRB1->( dbClearIndex() )	

TRB1->(dbSetIndex(cInd1TRB + OrdBagExt()))

TRB1->( dbSetorder(01) )

Proc2BarGauge({|| aCriticas := RJ009aImp() }  , "Imprimindo provisionamento...") 
//��������������������������������������������������������������������������Ŀ
//� Fim da Rotina Principal...                                               �
//����������������������������������������������������������������������������
Return


/*/
������������������������������������������������������������������������������
������������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ���
���Funcao    � RJ009aImp� Autor � Geraldo Felix Junior   � Data � 04.11.07 ����
�������������������������������������������������������������������������Ĵ���
���Descricao � Relatorio opcionais / debitos e credito - provisionamento  ����
��������������������������������������������������������������������������ٱ��
������������������������������������������������������������������������������
������������������������������������������������������������������������������
/*/
Static Function RJ009aImp()

//��������������������������������������������������������������������������Ŀ
//� Variaveis do IndRegua...                                                 �
//����������������������������������������������������������������������������
LOCAL i
LOCAL n
LOCAL pMoeda1	:= "@E 999,999.99"
LOCAL pMoeda2	:= "@E 999,999,999.99"
LOCAL nPosTit	:= 0
LOCAL aPlanos 	:= {}
LOCAL aPlaUsr	:= {}
LOCAL _cCodPla	:= ''
LOCAL _cVerPla 	:= ''
LOCAL nTotal	:= 0
LOCAL nTotDeb	:= 0
LOCAL nTotCre	:= 0
LOCAL nTotOpc	:= 0

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

cSql :=	"SELECT BM1_CODINT, BM1_CODEMP, BM1_MATRIC, BM1_TIPREG, BA1_NOMUSR, BM1_CODTIP, BM1_DESTIP, BM1_CODEVE,  "
cSql +=	"BM1_DESEVE, BM1_VALOR, BM1_PREFIX, BM1_NUMTIT, BM1_PARCEL, BM1_TIPTIT, BA1_CODPLA, BM1_CODPLA, BM1_DESPLA,  "
cSql +=	"BM1_VERPLA, BM1_ANO, BM1_MES, BA1_VERSAO  "
cSql += "FROM "+RetSqlName("BA1")+" BA1, "+RetSqlName("BM1")+" BM1, "+RetSqlName("B1T")+" B1T "
cSql +=	"WHERE BA1_FILIAL = '"+xFilial("BA1")+"'  "
cSql +=	"AND BM1_FILIAL = '"+xFilial("BM1")+"'  "
cSql += "AND BM1.BM1_CODINT = '"+cOpe+"' "
cSql += "AND BM1.BM1_ANO = '"+ _cAno +"' "
cSql += "AND BM1.BM1_MES = '"+ _cMes +"' "
cSql += "AND BM1.BM1_CODTIP IN "+FormatIn("101,102,"+cCodDB,",") // o 101 entra na query apenas para poder obter o produto original..
cSql +=	"AND B1T_FILIAL = '"+xFilial("B1T")+"'  "
cSql +=	"AND B1T_CODINT = '"+PLSINTPAD()+"'  "
cSql +=	"AND BM1_AGMTFU = B1T_AGMTFU  "
cSql +=	"AND BM1_ANO = B1T_ANO  "
cSql +=	"AND BM1_MES = B1T_MES  "
cSql +=	"AND BM1_VERSIG = B1T_VERSIG  "
cSql +=	"AND BA1_CODINT = BM1.BM1_CODINT  "
cSql +=	"AND BA1_CODEMP = BM1.BM1_CODEMP  "
cSql +=	"AND BA1_MATRIC = BM1.BM1_MATRIC  "
cSql +=	"AND BA1_TIPREG = BM1.BM1_TIPREG "
cSql +=	"AND BA1_DIGITO = BM1.BM1_DIGITO  "
cSql +=	"AND BM1.D_E_L_E_T_ = ' '  "
cSql +=	"AND BA1.D_E_L_E_T_ = ' '  "
cSql +=	"AND B1T.D_E_L_E_T_ = ' '  "
cSql +=	"ORDER BY BM1_CODINT, BM1_CODEMP, BM1_MATRIC, BM1_TIPREG, BM1_CODTIP, BM1_CODEVE "
                                                    
                                                    
/*                                                    
cSql := "SELECT BM1_CODINT, BM1_CODEMP, BM1_MATRIC, BM1_TIPREG, BA1_NOMUSR, BM1_CODTIP, BM1_DESTIP, "
cSql +=	"BM1_CODEVE, BM1_DESEVE, BM1_VALOR, BM1_PREFIX, BM1_NUMTIT, BM1_PARCEL, BM1_TIPTIT, BA1_CODPLA, "
cSql += "BM1_CODPLA, BM1_DESPLA, BM1_VERPLA, BM1_ANO, BM1_MES, BA1_VERSAO "
cSql += "FROM "+RetSqlName("BA1")+" BA1, "+RetSqlName("BM1")+" BM1 "
cSql += "WHERE BA1_FILIAL = '"+xFilial("BA1")+"' "
cSql += "AND BM1_FILIAL = '"+xFilial("BM1")+"' "
cSql += "AND BM1.BM1_CODINT = '"+cOpe+"' "
cSql += "AND BM1.BM1_ANO = '"+ _cAno +"' "
cSql += "AND BM1.BM1_MES = '"+ _cMes +"' "
cSql += "AND BM1.BM1_CODTIP IN "+FormatIn("101,102,"+cCodDB,",") // o 101 entra na query apenas para poder obter o produto original..
cSql += " AND BM1.D_E_L_E_T_ = ' ' "
cSql += "AND BA1.D_E_L_E_T_ = ' ' "
cSql += "AND BA1_CODINT = BM1.BM1_CODINT "
cSql += "AND BA1_CODEMP = BM1.BM1_CODEMP "
cSql += "AND BA1_MATRIC = BM1.BM1_MATRIC "
cSql += "AND BA1_TIPREG = BM1.BM1_TIPREG	 "
cSql += "AND BA1_DIGITO = BM1.BM1_DIGITO "
cSql += "ORDER BY BM1_CODINT, BM1_CODEMP, BM1_MATRIC, BM1_TIPREG, BM1_CODTIP, BM1_CODEVE "
*/

PlsQuery(cSql, "TRB")

nQtd:=1
TRB->(DBEval( { | | nQtd ++ }))
BarGauge1Set(nQtd)               

TRB->(DbGoTop())

BQC->(DbSetOrder(1))
BFQ->(DbSetOrder(1))
BI3->(dbSetorder(1))
SE1->(dbSetorder(1))

//��������������������������������������������������������������������������Ŀ
//� Define matriz de planos...                                               �
//����������������������������������������������������������������������������
aPlanos := {}

While ! TRB->(Eof())

	// Juros e farmacia serao desconsiderado porqie contabilizado no outro relatorio...
	If Alltrim(TRB->BM1_CODEVE) $ GetNewPar("MV_YCDLJ3","993") .or. Alltrim(TRB->BM1_CODEVE) $ GetNewPar("MV_YLANFAR","998")		// Juros...
		TRB->( dbSkip() )
		Loop
	Endif
	
	cFam := TRB->( BM1_CODINT + BM1_CODEMP + BM1_MATRIC )
	aPlaUsr := {}
		
	While !TRB->( Eof() ) .and. TRB->( BM1_CODINT + BM1_CODEMP + BM1_MATRIC ) == cFam
		//��������������������������������������������������������������������������Ŀ
		//� Apresenta mensagem em tela...                                            �
		//����������������������������������������������������������������������������
		IncProcG1("Familia ["+TRB->BM1_CODINT+"."+TRB->BM1_CODEMP+"."+TRB->BM1_MATRIC+"]")
		ProcessMessage()
		                                                                             
		// Juros e farmacia serao desconsiderado porqie contabilizado no outro relatorio...
		If Alltrim(TRB->BM1_CODEVE) $ GetNewPar("MV_YCDLJ3","993") .or. Alltrim(TRB->BM1_CODEVE) $ GetNewPar("MV_YLANFAR","998")		// Juros...
			TRB->( dbSkip() )
			Loop
		Endif
			
		//��������������������������������������������������������������������������Ŀ
		//� Posiciona a familia do usuario                                           �
		//����������������������������������������������������������������������������
		If TRB->(BM1_CODINT+BM1_CODEMP+BM1_MATRIC) <> BA3->(BA3_CODINT+BA3_CODEMP+BA3_MATRIC)
			BA3->( MsSeek(xFilial("BA3")+TRB->(BM1_CODINT+BM1_CODEMP+BM1_MATRIC)) )
		Endif	
	
		//��������������������������������������������������������������������Ŀ
		//� Defini qual o plano do usuario...                                  �
		//����������������������������������������������������������������������
		_cCodPla := ''
		_cVerPla := ''
		
		// Regra numero um: Utiliza o plano do BM1.
		If !Empty(BM1->BM1_CODPLA) .and. !Empty(BM1->BM1_VERPLA)
			_cCodPla := TRB->BM1_CODPLA
			_cVerPla := TRB->BM1_VERPLA
			
		Else
			// Regra numero dois: Utiliza o plano informado na mensalidade para os demais eventos.
			If TRB->BM1_CODTIP $ '101'		// Mensalidade
				_cCodPla := Alltrim(TRB->BM1_CODEVE)
				_cVerPla := '001'
				
				// Guarda o plano do usuario
				Aadd(aPlaUsr, {TRB->(BM1_CODINT+BM1_CODEMP+BM1_MATRIC+BM1_TIPREG), '101', Alltrim(TRB->BM1_CODEVE)})
		        
			Else
				// Considera o plano informado no BM1_CODEVE da mensalidade 101...
				If (nPosPla := Ascan(aPlaUsr, {|x| x[1] == TRB->(BM1_CODINT+BM1_CODEMP+BM1_MATRIC+BM1_TIPREG) .and.;
					x[2] == '101'})) > 0
					_cCodPla := aPlaUsr[nPosPla][3]
					_cVerPla := '001'
				Endif
			Endif
		Endif

		// O lancamento 101 sera utilizado apenas para obter o codigo do produto original 
		// e nao sera considerado no realtorio
		If TRB->BM1_CODTIP $ '101'		
			TRB->( dbSkip() )
			Loop
		Endif
						
		// Regra numero tres: Utiliza o plano do usuario ou da familia.
		If Empty(_cCodPla)
			If !Empty(TRB->BA1_CODPLA)
				_cCodPla := TRB->BA1_CODPLA
				_cVerPla := TRB->BA1_VERSAO
			Else
				_cCodPla := BA3->BA3_CODPLA
				_cVerPla := BA3->BA3_VERSAO
			Endif
		Endif
		
		//��������������������������������������������������������������������Ŀ
		//� Verifica se foi abortada a impressao...                            �
		//����������������������������������������������������������������������
		If  Interrupcao(lAbortPrint)
			Exit
		Endif

		//��������������������������������������������������������������������Ŀ
		//� Classifica o lancamento impresso em opcional, debito ou credito... �
		//����������������������������������������������������������������������  
		cTipo := ''
		If TRB->BM1_CODTIP $ '102'
			cTipo := '1'  // Classifica como opcional...
			
		Elseif TRB->BM1_CODTIP $ cCodDB
			If BFQ->( MsSeek(xFilial("BFQ")+TRB->BM1_CODINT + TRB->BM1_CODTIP) )
				If BFQ->BFQ_DEBCRE == '2' 	
					cTipo := '3'	// Classifica como credito...

				Elseif BFQ->BFQ_DEBCRE == '1' 
					cTipo := '2'	// Classifica como debito...

				Endif
			Endif
		Else
			cTipo := '4' // Nao classificado..
		Endif
	                           
		//��������������������������������������������������������������������Ŀ
		//� Grava arquivo temporario...                                        �
		//����������������������������������������������������������������������  						
		lFound := TRB1->( MsSeek(_cCodPla + TRB->BM1_ANO + TRB->BM1_MES + cTipo + TRB->BM1_CODTIP + Alltrim(TRB->BM1_CODEVE) ) )
		
		TRB1->( RecLock("TRB1", !lFound) )
		// Grava campos que compoem a chave de pesquisa.
		If !lFound
			TRB1->TR1_CODIGO	:= _cCodPla
			TRB1->TR1_ANO		:= TRB->BM1_ANO
			TRB1->TR1_MES		:= TRB->BM1_MES
			TRB1->TR1_TIPEVE	:= cTipo
			TRB1->TR1_CODTIP	:= TRB->BM1_CODTIP
			TRB1->TR1_CODEVE	:= TRB->BM1_CODEVE
			TRB1->TR1_DESEVE	:= TRB->BM1_DESEVE
			TRB1->TR1_VALOR		:= TRB->BM1_VALOR
		Else
			TRB1->TR1_VALOR		+= TRB->BM1_VALOR
		Endif
		
		TRB1->( MsUnlock() )
				
		TRB->(DbSkip())
	Enddo
	
	//��������������������������������������������������������������������Ŀ
	//� Fim do laco...                                                     �
	//����������������������������������������������������������������������
Enddo

TRB1->( dbGotop() )
nLi := 1000

BI3->( dbSetorder(01) )
while !TRB1->( Eof() )

	// Controle de saldo de pagina...
	If  nli > nQtdLin
    	nli := Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nCaracter)                                  
	    nli++               	
	Endif                            
	
	// Posinciona o produto...
    BI3->( MsSeek(xFilial("BI3")+PlsIntPad()+TRB1->TR1_CODIGO) )
                              
    // imprime quebra...
	@ nLi, 000 Psay TRB1->TR1_CODIGO+ ' - ' + Substr(BI3->BI3_DESCRI, 1, 30)
	nLi ++
	cQbMaster := TRB1->TR1_CODIGO		
	
	@ nLi, 042 Psay TRB1->TR1_ANO + '/' + TRB1->TR1_MES
	
	While !TRB1->( Eof() ) .and. TRB1->TR1_CODIGO == cQbMaster	
                                   
		// Quebra secundaria, por tipo de evento...
		cQuebra := TRB1->TR1_CODIGO + TRB1->TR1_ANO+TRB1->TR1_MES+TRB1->TR1_TIPEVE
		
		While !TRB1->( Eof() ) .and. TRB1->TR1_CODIGO + TRB1->TR1_ANO + TRB1->TR1_MES + TRB1->TR1_TIPEVE == cQuebra
			// Controle de saldo de pagina...
			If  nli > nQtdLin
    			nli := Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nCaracter)                                  
	    		nli++

			    // imprime quebra...
				@ nLi, 000 Psay TRB1->TR1_CODIGO+ ' - ' + Substr(BI3->BI3_DESCRI, 1, 30)
				nLi ++

				@ nLi, 042 Psay TRB1->TR1_ANO + '/' + TRB1->TR1_MES	    		
			Endif                            
			           
			If TRB1->TR1_TIPEVE == '1'
				cTexto := "Opcional"
				nTotOpc += TRB1->TR1_VALOR
				
			Elseif TRB1->TR1_TIPEVE == '2'
				cTexto := "Debito"
				nTotDeb += TRB1->TR1_VALOR
				
			Elseif TRB1->TR1_TIPEVE == '3'
				cTexto := "Credito"
				nTotCre += TRB1->TR1_VALOR			
				
			Else
				cTexto := "N�o classif."
			     
			Endif
			
			// Imprime a linha de detalhes...
			@ nLi, 055 Psay cTexto
	    	@ nLi, 069 Psay TRB1->TR1_CODTIP
	    	@ nLi, 085 Psay TRB1->TR1_CODEVE
		    @ nLi, 091 Psay Substr(TRB1->TR1_DESEVE,1,30)
    		@ nLi, 123 Psay Transform(TRB1->TR1_VALOR, pMoeda2)
			nLi++
			
			nTotal += TRB1->TR1_VALOR
			        	
			TRB1->( dbSkip() ) 
		Enddo
		
		// Imprime total da quebra por tipo de evento..
		nLi ++ 
		@ nLi, 055 Psay "Total"
		@ nLi, 123 Psay Transform(nTotal, pMoeda2)
		
		nLi++
		@ nLi, 055 Psay Replicate('-', (nLimite-55))
		
		nLi += 2
		nTotal := 0
	Enddo
	@ nLi, 000 Psay Replicate('-', nLimite)
		
	nLi ++
Enddo  		

@ nLi, 000 Psay "Total de opcionais: " + Transform(nTotOpc, pMoeda2)
nLi++

@ nLi, 000 Psay "Total de Debitos  : " + Transform(nTotDeb, pMoeda2)
nLi++

@ nLi, 000 Psay "Total de Creditos : " + Transform(nTotCre, pMoeda2)

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
//� Finaliza e elimina o arquivo fisico do temporario...                     �
//����������������������������������������������������������������������������
TRB1->( dbCloseArea() )
FErase(cArqTRB  + ".DBF")
FErase(cInd1TRB + OrdBagExt())

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

aadd(aRegs,{cPerg,"01","Operadora ?                   ","","","mv_ch1","C", 4,0,0,"G",""           ,"mv_par01",""            	,"","","","",""               	,"","","","",""              ,"","","","",""       ,"","","","","","","","",IIf(PlsGetVersao() >= 8,"B89PLS","B89"),""})
aadd(aRegs,{cPerg,"02","Mes ?                         ","","","mv_ch2","C", 2,0,0,"G","PlsVldMes()","mv_par02",""            	,"","","","",""               	,"","","","",""              ,"","","","",""       ,"","","","","","","","",""   ,""})
aadd(aRegs,{cPerg,"03","Ano ?                         ","","","mv_ch3","C", 4,0,0,"G",""           ,"mv_par03",""            	,"","","","",""               	,"","","","",""              ,"","","","",""       ,"","","","","","","","",""   ,""})
PlsVldPerg( aRegs )
    
Return
