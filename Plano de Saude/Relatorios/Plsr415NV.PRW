#INCLUDE "Plsr415.ch"
#include "PROTHEUS.CH"
#include "PLSMGER.CH"
#include "topconn.CH"  

/*/
ээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠зддддддддддбдддддддддбдддддддбддддддддддддддддддддддддбддддддбдддддддддд©╠╠╠
╠╠ЁFuncao    Ё PLSR415 Ё Autor Ё Angelo Sperandio       Ё Data Ё 30/01/04 Ё╠╠╠
╠╠цддддддддддедддддддддадддддддаддддддддддддддддддддддддаддддддадддддддддд╢╠╠╠
╠╠ЁDescricao Ё Emite relatorio para calculo da taxa de saude              Ё╠╠╠
╠╠цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢╠╠╠
╠╠ЁSintaxe   Ё PLSR415()                                                  Ё╠╠╠
╠╠цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢╠╠╠
╠╠Ё Uso      Ё Advanced Protheus                                          Ё╠╠╠
╠╠цддддддддддадддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢╠╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъ
/*/

user Function PLSR415NV()

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Define variaveis padroes para todos os relatorios...                     Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
Private cNomeProg   := "PLSR415"
Private nCaracter   := 15
Private cTamanho    := "G"
Private cTitulo     := STR0001 //"Resumo para Taxa de Saude"
Private cDesc1      := STR0002 //"Emite resumo para calculo da taxa de saude."
Private cDesc2      := ""
Private cDesc3      := ""
Private cCabec1     := ""
Private cCabec2     := ""
Private cAlias      := "BA1"
Private cPerg       := "PLR415"
Private wnRel       := "PLSR415"
Private Li         	:= 99
Private nLi         := 01
Private m_pag       := 1
Private aReturn     := {STR0003, 1,STR0004, 1, 1, 1, "",1 } //"Zebrado"###"Administracao"
Private lAbortPrint := .F.                                                                       
Private aOrdens     := ""
Private lDicion     := .F.
Private lCompres    := .F.
Private lCrystal    := .F.
Private lFiltro     := .T.
Private nTax60      := 0

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Cria novo SX1...						                                 Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
///////Lvr1SX1()  //P12 - deletando Pergunte

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Chama SetPrint                                                           Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
wnRel := SetPrint(cAlias,wnRel,cPerg,@cTitulo,cDesc1,cDesc2,cDesc3,lDicion,aOrdens,lCompres,cTamanho,{},lFiltro,lCrystal)

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Verifica se foi cancelada a operacao                                     Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
If  nLastKey  == 27
    Return
Endif

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Seleciona indices                                                        Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
BA1->(DbSetOrder(2))
BA3->(DbSetOrder(1))
BI3->(DbSetOrder(1))

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Acessa parametros do relatorio...                                        Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
Pergunte(cPerg,.F.)
dDatRef  := mv_par01
cOper    := mv_par02
cEmpIni  := mv_par03
cEmpFim  := mv_par04
cAbrIni  := mv_par05
cAbrFim  := mv_par06
cSegIni  := mv_par07
cSegFim  := mv_par08
nEmpresa := mv_par09
nTaxa    := mv_par10
nImpUsu  := mv_par11

If  nEmpresa == 1
    lEmpresa := .T.
Else
    lEmpresa := .F.
Endif        

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Monta cabecalho                                                          Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
If  lEmpresa
    cCabec1 := STR0005+"                       "+STR0006+"                                                      "+STR0007+"                                               "+STR0008+"        "+"Qtd"+"   "+STR0009+"        "+STR0010+"   "+STR0011+"        "+STR0012 //"Abrangencia"###"Segmentacao"###"Empresa"###"Faixa Etaria"###"Taxa"###"Valor"###"Desconto"###"Total"
Else
    cCabec1 := STR0005+"                       "+STR0006+"                                                          "+STR0008+"        "+STR0013+"          "+STR0009+"        "+STR0010+"   "+STR0011+"        "+STR0012 //"Abrangencia"###"Segmentacao"###"Faixa Etaria"###"Qtd"###"Taxa"###"Valor"###"Desconto"###"Total"
Endif

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Configura impressora                                                     Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
SetDefault(aReturn,cAlias)

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Emite relat╒rio                                                          Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
MsAguarde( {|| IMPR415() }, cTitulo ,"", .T.)

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Fim do programa                                                          Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
Return

/*/
ээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠здддддддддддбддддддддддбдддддддбдддддддддддддддддддддддбддддддбдддддддддд©╠╠
╠╠ЁPrograma   Ё IMPR415  Ё Autor Ё Angelo Sperandio      Ё Data Ё 30/01/04 Ё╠╠
╠╠цдддддддддддеддддддддддадддддддадддддддддддддддддддддддаддддддадддддддддд╢╠╠
╠╠ЁDescricao  Ё Imprime detalhe do relatorio...                            Ё╠╠
╠╠юдддддддддддадддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
/*/

Static Function IMPR415()

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Define variaveis...                                                      Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
Local nQtdLin  := 58
Local nColuna  := 00
Local nLimite  := 220
Local cSQL
Local nOrdSel  := aReturn[8] 
Local cCabAnt
Local cNameBA1 := RetSQLName("BA1")
Local nValor   := 0
Local nIdade   := 0
Local i,nJ

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Exibe mensagem...                                                        Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
msProcTxt(STR0014) //"Selecionando registros ..."

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Monta query...                                                           Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
cFiltro := " SELECT BA1_NOMUSR, BA1_CODINT, BA1_CODEMP, BA1_MATRIC, BA1_TIPREG "
cFiltro += " FROM " + cNameBA1 
cFiltro += " WHERE BA1_FILIAL =  '" + xFilial("BA1") + "' AND "
cFiltro +=       " BA1_OPEORI =  '" + cOper           + "' AND "
cFiltro +=       " BA1_CODINT =  '" + cOper           + "' AND "
cFiltro +=       " BA1_CODEMP >= '" + cEmpIni         + "' AND "
cFiltro +=       " BA1_CODEMP <= '" + cEmpFim         + "' AND "
cFiltro +=       " BA1_DATINC <= '" + dtos(dDatRef)   + "' AND "
cFiltro +=       " BA1_INFANS <> '0' AND "
cFiltro +=       " BA1_LOCSIB <> '0' AND "
cFiltro +=       " BA1_LOCSIB <> '6' AND "
cFiltro +=         cNameBA1 + ".D_E_L_E_T_ <> '*'"
cFiltro += " ORDER BY BA1_NOMUSR, BA1_CODINT, BA1_CODEMP, BA1_MATRIC, BA1_TIPREG "

PLSQuery(cFiltro,"BA1QRY")

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Inicializa variaveis                                                     Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
aTaxa1 := {} //Ate 59 anos
aTaxa2 := {} //60 anos ou mais
aUsuUti:= {} //usuarios que compoem o relatorio
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Processa BA1 - Usuarios                                                  Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
While ! BA1QRY->(eof())

   //зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
   //Ё Verifica se foi abortada a impressao...                               Ё
   //юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
   If  Interrupcao(lAbortPrint)
       Exit
   Endif

   //зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
   //Ё Exibe mensagem...                                                     Ё
   //юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
   msProcTxt(STR0015+": " + BA1QRY->BA1_CODINT + "." + BA1QRY->BA1_CODEMP + "." + BA1QRY->BA1_MATRIC +  "." + BA1QRY->BA1_TIPREG) //"Processando matricula"

   //зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
   //Ё Posiciona Usuario...                                                  Ё
   //юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
   If ! BA1->(DbSeek(xFilial("BA1")+BA1QRY->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG)))
   	   BA1QRY->(DbSkip())
   	   Loop
   Endif   

   //зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
   //Ё Posiciona Familia...                                                  Ё
   //юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
   If ! BA3->(DbSeek(xFilial("BA3")+BA1QRY->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC)))
   	   BA1QRY->(DbSkip())
   	   Loop
   Endif   

   //зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
   //Ё Posiciona Produto...                                                  Ё
   //юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
   If ! BI3->(DbSeek(xFilial("BI3")+BA1->(BA1_CODINT+BA1_CODPLA+BA1_VERSAO)))
	   If ! BI3->(DbSeek(xFilial("BI3")+BA3->(BA3_CODINT+BA3_CODPLA+BA3_VERSAO)))
	   	   BA1QRY->(DbSkip())
   		   Loop
   	   Endif	   
   Endif   
   
   //зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
   //Ё Verifica abrangencia...                                               Ё
   //юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
   If BI3->BI3_ABRANG < cAbrIni .or. BI3->BI3_ABRANG > cAbrFim
   	   BA1QRY->(DbSkip())
	   Loop
   Endif	   

   //зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
   //Ё Verifica segmentacao...                                               Ё
   //юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
   If BI3->BI3_CODSEG < cSegIni .or. BI3->BI3_CODSEG > cSegFim
   	   BA1QRY->(DbSkip())
	   Loop
   Endif	   

   //зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
   //Ё Verifica se usuario estava bloqueado na data de referencia            Ё
   //юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
   If  VerifAns(dDatRef)
       BA1QRY->(dbSkip())
       Loop
   Endif
          
   //зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
   //Ё Verifica se deve considerar empresa                                   Ё
   //юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
   If  lEmpresa
       cCodEmp := BA1->BA1_CODEMP
   Else
       cCodEmp := space(4)
   Endif   
   
   //зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
   //Ё Acumula qtd de usuarios                                                Ё
   //юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
   cCodAbr := BI3->BI3_ABRANG
   cCodSeg := BI3->BI3_CODSEG
   nIdade  := Calc_Idade(dDatRef,BA1->BA1_DATNAS)
   
   nPos := aScan(aTaxa1,{|x| x[1] == cCodAbr .and. x[2] == cCodSeg .and. x[3] == cCodEmp})

   If  nPos == 0
       If nIdade < 60
	       aadd(aTaxa1,{cCodAbr,cCodSeg,cCodEmp,1,{{BA1->BA1_NOMUSR,BA1->BA1_CODINT,BA1->BA1_CODEMP,BA1->BA1_MATRIC,BA1->BA1_TIPREG,BA1->BA1_DIGITO,BA1->BA1_CONEMP,BA1->BA1_SUBCON,BA1->BA1_CODEMP,BA1->BA1_CODPLA}}})
    	   aadd(aTaxa2,{cCodAbr,cCodSeg,cCodEmp,0})
       Else
	       aadd(aTaxa1,{cCodAbr,cCodSeg,cCodEmp,0,{{BA1->BA1_NOMUSR,BA1->BA1_CODINT,BA1->BA1_CODEMP,BA1->BA1_MATRIC,BA1->BA1_TIPREG,BA1->BA1_DIGITO,BA1->BA1_CONEMP,BA1->BA1_SUBCON,BA1->BA1_CODEMP,BA1->BA1_CODPLA}}})
    	   aadd(aTaxa2,{cCodAbr,cCodSeg,cCodEmp,1})
       Endif   
   Else
       If nIdade < 60
	       aTaxa1[nPos,4] += 1
	   Else
	       aTaxa2[nPos,4] += 1
	   Endif
	   aadd(aTaxa1[nPos,5],{BA1->BA1_NOMUSR,BA1->BA1_CODINT,BA1->BA1_CODEMP,BA1->BA1_MATRIC,BA1->BA1_TIPREG,BA1->BA1_DIGITO,BA1->BA1_CONEMP,BA1->BA1_SUBCON,BA1->BA1_CODEMP,BA1->BA1_CODPLA})
   Endif
   aadd(aUsuUti,{BA1->BA1_NOMUSR,BA1->BA1_CODINT,BA1->BA1_CODEMP,BA1->BA1_MATRIC,BA1->BA1_TIPREG,BA1->BA1_DIGITO,BA1->BA1_CONEMP,BA1->BA1_SUBCON,BA1->BA1_CODEMP,BA1->BA1_CODPLA})
   //зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
   //Ё Acessa proximo registro                                               Ё
   //юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
   BA1QRY->(dbSkip())
EndDo   

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Fecha arquivo de trabalho                                                Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
BA1QRY->(DbCloseArea()) 

If  len(aTaxa1) == 0
    msgalert(STR0016) //"Nenhum usuario encontrado"
    Return
Endif

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Mensagem de processamento                                                Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
msProcTxt(STR0017+" ...") //"Organizando informacoes"

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Adiciona uma ocorrencia para tratar o total geral                        Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
aadd(aTaxa1,{"ZZ","ZZZ"," ",0})
aadd(aTaxa2,{"ZZ","ZZZ"," ",0})

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Classica vetor                                                           Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
aSort(aTaxa1,,, { |x,y| x[1]+x[2]+x[3] < y[1]+y[2]+y[3] })
aSort(aTaxa2,,, { |x,y| x[1]+x[2]+x[3] < y[1]+y[2]+y[3] })

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Inicializa variaveis                                                     Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
nTotQtd    := 0
nTotQtdAbr := 0
nTotQtdSeg := 0
nTotVlr    := 0
nTotVlrAbr := 0
nTotVlrSeg := 0
nTotDes    := 0
nTotDesAbr := 0
nTotDesSeg := 0

nTtlQtd    := 0
nTtlQtdAbr := 0
nTtlQtdSeg := 0
nTtlVlr    := 0
nTtlVlrAbr := 0
nTtlVlrSeg := 0
nTtlDes    := 0
nTtlDesAbr := 0
nTtlDesSeg := 0

If  lEmpresa
    nLen := 93
Else
    nLen := 43
Endif        

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Imprime relatorio                                                        Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
i := 1

While .T.

   //зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
   //Ё Acessa BF7-Abrangencia                                                Ё
   //юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
   cCodAbr := aTaxa1[i,1]        
   BF7->(dbSeek(xFilial("BF7")+cCodAbr))
   nPerAbr := BF7->BF7_PERDES
   cDesAbr := BF7->BF7_DESORI
   cLinAbr := cCodAbr + Space(01) + cDesAbr + Space(01)

   While aTaxa1[i,1] == cCodAbr 
   
      //здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
      //Ё Acessa BI6-Segmentacao                                             Ё
      //юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
      cCodSeg := aTaxa1[i,2]
      BI6->(dbSeek(xFilial("BI6")+cCodSeg))
      nPerSeg := BI6->BI6_PERDES
      cDesSeg := BI6->BI6_DESCRI
      cLinSeg := cCodSeg + Space(01) + cDesSeg + Space(01) 
      
      While aTaxa1[i,1] == cCodAbr .and. aTaxa1[i,2] == cCodSeg
      
         //зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
         //Ё Mensagem de processamento                                       Ё
         //юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
         msProcTXT(STR0018+" " + alltrim(str(i)) + " ...")  //"Imprimindo"
         
         //зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
         //Ё Calcula valores - Ate 59 anos                                   Ё
         //юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
         nQtd1   := aTaxa1[i,4]
         nValor1 := nQtd1 * nTaxa
         nDesc1  := noround((nValor1 * (nPerAbr / 100)) + (nValor1 * (nPerSeg / 100)),2) 
         nTotal1 := nValor1 - nDesc1
		 nTotal1 := IIF(nTotal1<0,0,nTotal1)

         //зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
         //Ё Calcula valores - Mais de 59 anos                               Ё
         //юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
         nQtd2   := aTaxa2[i,4]
         nValor2 := nQtd2 * nTax60
         nDesc2  := noround((nValor2 * (nPerAbr / 100)) + (nValor2 * (nPerSeg / 100)),2) 
         nTotal2 := nValor2 - nDesc2
		 nTotal2 := IIF(nTotal2<0,0,nTotal2)         

         //зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
         //Ё Verifica se deve lista empresa                                  Ё
         //юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
         If  lEmpresa 
         
             //зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
             //Ё Acessa BG9 - Grupo/Empresa                                  Ё
             //юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
             cCodEmp := aTaxa1[i,3]
             BG9->(dbSeek(xFilial("BG9")+cOper+cCodEmp))
             cDesEmp := BG9->BG9_DESCRI    
             
             //зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
             //Ё Imprime cabecalho                                           Ё
             //юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
             If  Li+3 > nQtdLin
                  Cabec(cTitulo,cCabec1,cCabec2,wnRel,cTamanho,IIF(aReturn[4]==1,GetMv("MV_COMP"),GetMv("MV_NORM")))
             Endif     
             
             //зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
             //Ё Imprime linha de detalhe - Ate 59 anos                      Ё
             //юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
             cLinha := cLinAbr + cLinSeg
             cLinha += cCodEmp + Space(01) + substr(cDesEmp,1,44) + Space(01) 
		     cLinha += Space(4) + STR0019 + Space(5) //"Ate 59 anos"
             cLinha += Transform(nQtd1  ,"@E 999,999") + Space(01) 
             cLinha += Transform(nTaxa  ,"@E 999.99")   + Space(01) 
             cLinha += Transform(nValor1,"@E 9,999,999.99") + Space(01)
             cLinha += Transform(nDesc1 ,"@E   999,999.99") + Space(01)
             cLinha += Transform(nTotal1,"@E 9,999,999.99")
             @ Li,nColuna pSay cLinha
             Li ++ 

             //зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
             //Ё Imprime linha de detalhe - Mais de 59 anos                  Ё
             //юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
             cLinha := space(34) + space(65)
             cLinha += Space(04) + Space(01) + Space(44) + Space(05) 
		     cLinha += STR0020 + Space(1) //"Mais de 59 anos"
             cLinha += Transform(nQtd2  ,"@E 999,999") + Space(01) 
             cLinha += Transform(nTax60 ,"@E 999.99")   + Space(01) 
             cLinha += Transform(nValor2,"@E 9,999,999.99") + Space(01)
             cLinha += Transform(nDesc2 ,"@E   999,999.99") + Space(01)
             cLinha += Transform(nTotal2,"@E 9,999,999.99")
             @ Li,nColuna pSay cLinha
             Li ++ 
             
             //зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
             //Ё Imprime linha de detalhe - Totalizador		                 Ё
             //юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
             cLinha := space(34) + space(50)
             cLinha += Space(04) + Space(01) + Space(64) 
		     cLinha += STR0012 + Space(11) //"Total"
             cLinha += Transform((nQtd1+nQtd2),"@E 999,999") 
             cLinha += Space(08) 
             cLinha += Transform((nValor1+nValor2),"@E 9,999,999.99") + Space(01)
             cLinha += Transform((nDesc1+nDesc2),"@E   999,999.99") + Space(01)
             cLinha += Transform((nTotal1+nTotal2),"@E 9,999,999.99")
             @ Li,nColuna pSay cLinha
             Li ++ 

             @ Li,nColuna pSay ""
             Li ++ 
             
             cLinAbr := space(34)
             cLinSeg := space(65)
         Endif  
         
         //зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
         //Ё Acumula valores - Ate 59 anos                                   Ё
         //юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
         nTotQtd    += nQtd1
         nTotQtdAbr += nQtd1
         nTotQtdSeg += nQtd1
         nTotVlr    += nValor1
         nTotVlrAbr += nValor1
         nTotVlrSeg += nValor1
         nTotDes    += nDesc1 
         nTotDesAbr += nDesc1 
         nTotDesSeg += nDesc1
         //зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
         //Ё Acumula valores - Mais de 59 anos                               Ё
         //юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
         nTtlQtd    += nQtd2
         nTtlQtdAbr += nQtd2
         nTtlQtdSeg += nQtd2
         nTtlVlr    += nValor2
         nTtlVlrAbr += nValor2
         nTtlVlrSeg += nValor2
         nTtlDes    += nDesc2 
         nTtlDesAbr += nDesc2 
         nTtlDesSeg += nDesc2

         If nImpUsu == 1
            cCabAnt := cCabec1
            cCabec1 := STR0021+"  "+STR0022+"             "+STR0023+"               "+STR0024+"                                               "+STR0025 //"Gr.Empresa"###"Contrato"###"SubContrato Matricula"###"Nome"###"Plano"
//                      9999        XXXXXXXXXXXXXXXXXXXX XXXXXXXXX   9999.9999.999999.99-9   XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX 9999
            @ Li,nColuna pSay cCabec1
            Li ++ 
            @ Li,00 PSAY __PrtThinLine()
            Li++
            aUsuUti := aClone(aTaxa1[i,5])
			For nJ := 1 to len(aUsuUti)
			    cLinha  := aUsuUti[nJ,3]+"        "+ PadR(aUsuUti[nJ,7],20)+" "+ aUsuUti[nJ,8] +"   "+ aUsuUti[nJ,2] + "." + aUsuUti[nJ,3] + "." + aUsuUti[nJ,4] + "-" + aUsuUti[nJ,5] + " " + aUsuUti[nJ,6] + " - " + aUsuUti[nJ,1]+" "+aUsuUti[nJ,10]
  		        @ Li,nColuna pSay cLinha
			    Li ++ 
				If  Li+3 > nQtdLin
				    Cabec(cTitulo,cCabec1,cCabec2,wnRel,cTamanho,IIF(aReturn[4]==1,GetMv("MV_COMP"),GetMv("MV_NORM")))
				Endif     
			Next
            cCabec1 := cCabAnt
			Li++
            @ Li,nColuna pSay cCabec1
            Li ++ 
            @ Li,00 PSAY __PrtThinLine()
            Li++
         EndIf    
         i++
      EndDo  
      
      If  lEmpresa
          cLinha := space(34)  + STR0026+" " + cCodSeg + space(1) + replicate(".",nLen) //"Total Segmentacao"
      Else
          If  Li > nQtdLin
              Cabec(cTitulo,cCabec1,cCabec2,wnRel,cTamanho,IIF(aReturn[4]==1,GetMv("MV_COMP"),GetMv("MV_NORM")))
          Endif
          cLinha := cLinAbr + cLinSeg
      Endif
      
      //зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
      //Ё Imprime cabecalho                                           Ё
      //юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
      If  Li+3 > nQtdLin
          Cabec(cTitulo,cCabec1,cCabec2,wnRel,cTamanho,IIF(aReturn[4]==1,GetMv("MV_COMP"),GetMv("MV_NORM")))
      Endif     
      
      //здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
      //Ё Imprime total da segmentacao - Ate 59 anos                         Ё
      //юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
      cLinha += Space(4) + STR0019 + Space(5) //"Ate 59 anos"
      cLinha += Transform(nTotQtdSeg,"@E 999,999") + Space(1)
      If ! lEmpresa
          cLinha += Space(7)
      Endif 
      cLinha += Transform(nTaxa  ,"@E 999.99")   + Space(01) 
      cLinha += Transform(nTotVlrSeg,"@E 9,999,999.99") + Space(1)
      cLinha += Transform(nTotDesSeg,"@E   999,999.99") + Space(1)
      cLinha += Transform((nTotVlrSeg-nTotDesSeg),"@E 9,999,999.99")
      @ Li,nColuna pSay cLinha
      Li ++    

      //здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
      //Ё Imprime total da segmentacao - Mais de 59 anos                     Ё
      //юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
      cLinha := Space(103)
      If lEmpresa
          cLinha += Space(50)
      Endif
      cLinha += STR0020 + Space(1) //"Mais de 59 anos"
      cLinha += Transform(nTtlQtdSeg,"@E 999,999") + Space(1) 
      If ! lEmpresa
          cLinha += Space(7)
      Endif 
      cLinha += Transform(nTax60,"@E 999.99")   + Space(01) 
      cLinha += Transform(nTtlVlrSeg,"@E 9,999,999.99") + Space(1)
      cLinha += Transform(nTtlDesSeg,"@E   999,999.99") + Space(1)
      cLinha += Transform((nTtlVlrSeg-nTtlDesSeg),"@E 9,999,999.99")
      @ Li,nColuna pSay cLinha
      Li ++    

      //здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
      //Ё Imprime totalizador da segmentacao				                 Ё
      //юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
      cLinha := Space(103)
      If lEmpresa
          cLinha += Space(50)
      Endif
      cLinha += STR0012 + Space(11) //"Total"
      cLinha += Transform((nTotQtdSeg+nTtlQtdSeg),"@E 999,999") + Space(1) 
      If ! lEmpresa
          cLinha += Space(7)
      Endif 
      cLinha += Space(07)
      cLinha += Transform((nTotVlrSeg+nTtlVlrSeg),"@E 9,999,999.99") + Space(1)
      cLinha += Transform((nTotDesSeg+nTtlDesSeg),"@E   999,999.99") + Space(1)
      cLinha += Transform(((nTotVlrSeg-nTotDesSeg)+(nTtlVlrSeg-nTtlDesSeg)),"@E 9,999,999.99")
      @ Li,nColuna pSay cLinha
      Li ++    

      @ Li,nColuna pSay ""
      Li ++    
      
      nTotQtdSeg := 0
      nTotVlrSeg := 0
      nTotDesSeg := 0
      nTtlQtdSeg := 0
      nTtlVlrSeg := 0
      nTtlDesSeg := 0
      cLinAbr    := space(34)
   EndDo 
   
   //зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
   //Ё Imprime cabecalho                                           Ё
   //юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
   If  Li+3 > nQtdLin
       Cabec(cTitulo,cCabec1,cCabec2,wnRel,cTamanho,IIF(aReturn[4]==1,GetMv("MV_COMP"),GetMv("MV_NORM")))
   Endif     

   //зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
   //Ё Imprime total da abrangencia - Ate 59 anos                            Ё
   //юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
   cLinha := space(34) + STR0027+" " + cCodAbr + space(2) + replicate(".",nLen) //"Total Abrangencia"
   cLinha += Space(4) + STR0019 + Space(5) //"Ate 59 anos"
   cLinha += Transform(nTotQtdAbr,"@E 999,999")
   If lEmpresa
       cLinha += Space(8) 
   Else
   	   cLinha += Space(15) 
   Endif	   
   cLinha += Transform(nTotVlrAbr,"@E 9,999,999.99") + Space(1) 
   cLinha += Transform(nTotDesAbr,"@E   999,999.99") + Space(1) 
   cLinha += Transform((nTotVlrAbr-nTotDesAbr),"@E 9,999,999.99")
   @ Li,nColuna pSay cLinha
   Li ++ 
   
   //зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
   //Ё Imprime total da abrangencia - Mais de 59 anos                        Ё
   //юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
   cLinha := space(34) + space(22) + replicate(" ",nLen)
   cLinha += Space(4) + STR0020 + Space(1) //"Mais de 59 anos"
   cLinha += Transform(nTtlQtdAbr,"@E 999,999")
   If lEmpresa
       cLinha += Space(8) 
   Else
   	   cLinha += Space(15) 
   Endif	   
   cLinha += Transform(nTtlVlrAbr,"@E 9,999,999.99") + Space(1) 
   cLinha += Transform(nTtlDesAbr,"@E   999,999.99") + Space(1) 
   cLinha += Transform((nTtlVlrAbr-nTtlDesAbr),"@E 9,999,999.99")
   @ Li,nColuna pSay cLinha
   Li ++ 
      
   //зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
   //Ё Imprime totalizador da abrangencia				                     Ё
   //юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
   cLinha := space(34) + space(22) + replicate(" ",nLen)
   cLinha += Space(4) + STR0012 + Space(11) //"Total"
   cLinha += Transform((nTotQtdAbr+nTtlQtdAbr),"@E 999,999")
   If lEmpresa
       cLinha += Space(8) 
   Else
   	   cLinha += Space(15) 
   Endif	   
   cLinha += Transform((nTotVlrAbr+nTtlVlrAbr),"@E 9,999,999.99") + Space(1) 
   cLinha += Transform((nTotDesAbr+nTtlDesAbr),"@E   999,999.99") + Space(1) 
   cLinha += Transform(((nTotVlrAbr+nTtlVlrAbr)-(nTotDesAbr+nTtlDesAbr)),"@E 9,999,999.99")
   @ Li,nColuna pSay cLinha
   Li ++ 

   @ Li,nColuna pSay ""
   Li ++ 
   
   nTotQtdAbr := 0
   nTotVlrAbr := 0
   nTotDesAbr := 0
   nTtlQtdAbr := 0
   nTtlVlrAbr := 0
   nTtlDesAbr := 0
   //зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
   //Ё Verifica se chegou ao fim do vetor                                    Ё
   //юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
   If  aTaxa1[i,1] == "ZZ"
       Exit
   Endif
EndDo

//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Imprime cabecalho                                           Ё
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
If  Li+3 > nQtdLin
    Cabec(cTitulo,cCabec1,cCabec2,wnRel,cTamanho,IIF(aReturn[4]==1,GetMv("MV_COMP"),GetMv("MV_NORM")))
Endif     

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Imprime total geral - Ate 59 Anos                                        Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
cLinha := space(34) + STR0028+"       " +  space(4) + replicate(".",nLen) //"Total Geral"
cLinha += Space(4) + STR0019 + Space(5) //"Ate 59 anos"
cLinha += Transform(nTotQtd,"@E 999,999")
If lEmpresa
    cLinha += Space(8) 
Else
    cLinha += Space(15) 
Endif
cLinha += Transform(nTotVlr,"@E 9,999,999.99") + Space(1) 
cLinha += Transform(nTotDes,"@E   999,999.99") + Space(1) 
cLinha += Transform((nTotVlr-nTotDes),"@E 9,999,999.99")
@ Li,nColuna pSay cLinha   
Li ++

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Imprime total geral - Mais de 59 anos                                    Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
cLinha := space(34) + space(22) + replicate(" ",nLen)
cLinha += Space(4) + STR0020 + Space(1) //"Mais de 59 anos"
cLinha += Transform(nTtlQtd,"@E 999,999")
If lEmpresa
    cLinha += Space(8) 
Else
    cLinha += Space(15) 
Endif
cLinha += Transform(nTtlVlr,"@E 9,999,999.99") + Space(1) 
cLinha += Transform(nTtlDes,"@E   999,999.99") + Space(1) 
cLinha += Transform((nTtlVlr-nTtlDes),"@E 9,999,999.99")
@ Li,nColuna pSay cLinha  
Li ++

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Imprime totalizador geral                                                Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
cLinha := space(34) + space(22) + replicate(" ",nLen)
cLinha += Space(4) + STR0012 + Space(11) //"Total"
cLinha += Transform((nTotQtd+nTtlQtd),"@E 999,999")
If lEmpresa
    cLinha += Space(8) 
Else
    cLinha += Space(15) 
Endif
cLinha += Transform((nTotVlr+nTtlVlr),"@E 9,999,999.99") + Space(1) 
cLinha += Transform((nTotDes+nTtlDes),"@E   999,999.99") + Space(1) 
cLinha += Transform(((nTotVlr+nTtlVlr)-(nTotDes+nTtlDes)),"@E 9,999,999.99")
@ Li,nColuna pSay cLinha  
Li ++

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Imprime rodape do relatorio...                                           Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
Roda(0,space(10),cTamanho)

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Libera impressao                                                         Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
If  aReturn[5] == 1 
    Set Printer To
    Ourspool(wnRel)
Endif

Return 

/*/
ээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠зддддддддддбдддддддддбдддддддбддддддддддддддддддддддддбддддддбдддддддддд©╠╠╠
╠╠ЁFuncao    ЁVerifAns Ё Autor Ё Angelo                 Ё Data Ё 28.06.05 Ё╠╠╠
╠╠цддддддддддедддддддддадддддддаддддддддддддддддддддддддаддддддадддддддддд╢╠╠╠
╠╠ЁDescricao Ё Verifica se o usuario esta ativo para a ANS                Ё╠╠╠
╠╠юддддддддддадддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды╠╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъ
/*/

Static Function VerifAns(dDatRef)

Local lBloq := .F.

//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Verifica se no fim do periodo o beneficiario estava bloqueado         Ё
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
cQryBlq  := " SELECT BCA_TIPO, BCA_DATA, BCA_MOTBLO, BCA_NIVBLQ FROM " + RetSQLName("BCA")
cQryBlq  += " WHERE BCA_FILIAL = '" + xFilial("BCA") + "' AND "
cQryBlq  +=	" BCA_MATRIC = '" + BA1->BA1_CODINT + BA1->BA1_CODEMP + BA1->BA1_MATRIC + "' AND"
cQryBlq  += " BCA_TIPREG = '" + BA1->BA1_TIPREG + "' AND"
//cQryBlq  += " BCA_DATA <= '" + dtos(dDatRef) + "' AND " == Chamado para corrigir este problema SCLMRN	  
cQryBlq  += " BCA_DATA < '" + dtos(dDatRef) + "' AND "	  
cQryBlq  += RetSQLName("BCA") + ".D_E_L_E_T_ <> '*' "
cQryBlq  += " ORDER BY BCA_MATRIC, R_E_C_N_O_ DESC"

PLSQuery(cQryBlq,"BCAQRY")

DbSelectArea("BQU")
BQU->(DbSetOrder(1))
DbSelectArea("BG1")
BG1->(DbSetOrder(1))
DbSelectArea("BG3")
BG3->(DbSetOrder(1))
//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Se nao existe historico de bloqueio do Usuario e                      Ё
//Ё    a data de bloqueio do usuario eh anterior ao periodo do SIB        Ё
//Ё    -> despreza o usuario                                              Ё
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
While ! BCAQRY->(Eof())

	If  BCAQRY->BCA_TIPO == '0'
		
		Do Case 
			Case BCAQRY->BCA_NIVBLQ == 'U' // Nivel de Usuario
				If  BG3->(MsSeek(xFilial("BG3")+BCAQRY->BCA_MOTBLO))
			    	If  ! empty(BG3->BG3_BLQANS)
						lBloq := .T.
					Endif	
			  	Endif
			Case BCAQRY->BCA_NIVBLQ == 'F' // Nivel de Familia
			    If  BG1->(MsSeek(xFilial("BG1")+BCAQRY->BCA_MOTBLO))
			    	If  ! empty(BG1->BG1_BLQANS)
						lBloq := .T.
					Endif	
			  	Endif
			Case BCAQRY->BCA_NIVBLQ == 'S' // Nivel de Sub-Contrato
			    If  BQU->(MsSeek(xFilial("BQU")+BCAQRY->BCA_MOTBLO))
			    	If  ! empty(BQU->BQU_BLQANS)
						lBloq := .T.
					Endif	
				Endif
		EndCase
	   
   	Else
       lBloq := .F.
   	EndIf
   	
   	Exit

EndDo                                 
BCAQRY->(DbCloseArea())

Return(lBloq)

/*
ээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠иммммммммммяммммммммммкмммммммямммммммммммммммммммммкммммммяммммммммммммм╩╠╠
╠╠╨Programa  ЁLvr1SX1   ╨Autor  ЁMicrosiga PLS        ╨ Data Ё  29/07/04   ╨╠╠
╠╠лммммммммммьммммммммммймммммммомммммммммммммммммммммйммммммоммммммммммммм╧╠╠
╠╠╨Desc.     ЁCria o pergunte padrao                                       ╨╠╠
╠╠╨          Ё                                                             ╨╠╠
╠╠лммммммммммьммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммм╧╠╠
╠╠╨Uso       Ё AP                                                          ╨╠╠
╠╠хммммммммммоммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммм╪╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъ
*/
Static Function Lvr1SX1()
Local aRegs	:=	{}

//Verifica versao e corrige o pergunte
If PlsGetVersao() >= 8
	If  SX1->(msSeek(cPerg+"02"))
		If Alltrim(SX1->X1_F3) == "B89" 
			   If SX1->(msSeek(cPerg+"11"))	
		           SX1->(RecLock("SX1",.F.))
	    	       SX1->(dbDelete())
	        	   SX1->(msUnLock())
	           Endif
	    Endif
	Endif
Endif
//VEFIRICA ALTERACAO DO SX1 E DELETA A ULTIMA PERGUNTA PARA QUE SEJA CRIADO NOVAMENTE
If  SX1->(msSeek(cPerg+"10"))
	If SX1->X1_DECIMAL = 0 
		   If SX1->(msSeek(cPerg+"11"))	
	           SX1->(RecLock("SX1",.F.))
    	       SX1->(dbDelete())
        	   SX1->(msUnLock())
           Endif
    Endif
Endif

If  ! SX1->(msSeek(cPerg+"11"))
    While .T.
       If  SX1->(msSeek(cPerg))
           SX1->(RecLock("SX1",.F.))
           SX1->(dbDelete())
           SX1->(msUnLock())
       Else
           Exit
       Endif
    Enddo
Endif

aadd(aRegs,{cPerg,"01","Data de Referencia ?","","","mv_ch1","D", 8,0,0,"G","","mv_par01",""        ,"","","","",""          ,"","","","",""          ,"","","","","","","","","","","","","",""   ,""})
aadd(aRegs,{cPerg,"02","Operadora          ?","","","mv_ch2","C", 4,0,0,"G","","mv_par02",""        ,"","","","",""          ,"","","","",""          ,"","","","","","","","","","","","","",IIf(PlsGetVersao() >= 8,"B89PLS","B89"),""})
aadd(aRegs,{cPerg,"03","Grupo Empr. De     ?","","","mv_ch3","C", 4,0,0,"G","","mv_par03",""        ,"","","","",""          ,"","","","",""          ,"","","","","","","","","","","","","",IIf(PlsGetVersao() >= 8,"B7APLS","B7A"),""})
aadd(aRegs,{cPerg,"04","Grupo Empr. Ate    ?","","","mv_ch4","C", 4,0,0,"G","","mv_par04",""        ,"","","","",""          ,"","","","",""          ,"","","","","","","","","","","","","",IIf(PlsGetVersao() >= 8,"B7APLS","B7A"),""})
aadd(aRegs,{cPerg,"05","Abrangencia De     ?","","","mv_ch5","C", 2,0,0,"G","","mv_par05",""        ,"","","","",""          ,"","","","",""          ,"","","","","","","","","","","","","",IIf(PlsGetVersao() >= 8,"BD9PLS","BD9"),""})
aadd(aRegs,{cPerg,"06","Abrangencia Ate    ?","","","mv_ch6","C", 2,0,0,"G","","mv_par06",""        ,"","","","",""          ,"","","","",""          ,"","","","","","","","","","","","","",IIf(PlsGetVersao() >= 8,"BD9PLS","BD9"),""})
aadd(aRegs,{cPerg,"07","Segmentacao De     ?","","","mv_ch7","C", 3,0,0,"G","","mv_par07",""        ,"","","","",""          ,"","","","",""          ,"","","","","","","","","","","","","",IIf(PlsGetVersao() >= 8,"B52PLS","B52"),""})
aadd(aRegs,{cPerg,"08","Segmentacao Ate    ?","","","mv_ch8","C", 3,0,3,"G","","mv_par08","" 		  ,"","","","",""		    ,"","","","",""	  		 ,"","","","","","","","","","","","","",IIf(PlsGetVersao() >= 8,"B52PLS","B52"),""})
aadd(aRegs,{cPerg,"09","Imprime Grupo Empr.?","","","mv_ch9","N", 1,0,0,"C","","mv_par09","Sim"     ,"","","","","Nao"        ,"","","","",""         ,"","","","","","","","","","","","","",""   ,""})
aadd(aRegs,{cPerg,"10","Taxa               ?","","","mv_cha","N",10,2,0,"G","","mv_par10",""        ,"","","","",""           ,"","","","",""         ,"","","","","","","","","","","","","",""   ,""})
aadd(aRegs,{cPerg,"11","Imprime Usuarios   ?","","","mv_chb","N", 1,0,0,"C","","mv_par11","Sim"     ,"","","","","Nao"        ,"","","","",""         ,"","","","","","","","","","","","","",""   ,""})        

PlsVldPerg( aRegs )

Return()
