#INCLUDE "rwmake.ch"
#INCLUDE "topconn.ch"

#Define CRLF Chr(13)+Chr(10)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ CABR104  º Autor ³ Altamiro Affonso   º Data ³  05/10/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Relatorio De Bordero de pagamento customizado              º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP6 IDE                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CABR104C()

   //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
   //³ Declaracao de Variaveis                                             ³
   //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

   Local cDesc1         := "Este programa tem como objetivo imprimir relatorio  "
   Local cDesc2         := "de bordero de pagamento ordenado e grupados pelo motivo"
   Local cDesc3         := " "
   Local titulo         := "Bordero de Pagamento por Tipo "
   Local nLin           := 132
   Local Cabec1         := "Tipo                                             Data                Valor"
   //                       1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
   //                       0        1         2         3         4         5         6         7         8         9         0         1         2         3         4         5         6         7         8         9         0         1         2
   Local Cabec2         := "   "
   Local aOrd           := {}
   Private lEnd         := .F.
   Private lAbortPrint  := .F.
   Private limite       :=  132 // 80 132 220
   Private tamanho      := "M" //  P   M   G
   Private nomeprog     := "CABR104C"
   Private nTipo        := 15
   Private aReturn      := { "Zebrado", 1, "Administracao", 2, 2, 1, "", 1}
   Private nLastKey     := 0
   Private cbtxt        := Space(10)
   Private cbcont       := 00
   Private CONTFL       := 01
   Private m_pag        := 01
   Private wnrel        := "CABR104"
   Private cString      := "SEA"
   Private cPerg        := "CAB104   "
   private cComp        := " "
   private cCompd       := 'Competencias--> '
   private aComPg       := {}
   private aSaidCom     := {}
   private aCabec1      := {'Prefixo' ,'Numero' , 'Tipo' , 'Saldo' , 'Impostos' , 'Descontos' , 'Cod.Rda' , 'Fornecedor' , 'Comp Pagto' , 'Mes/Ano Guias'  , 'Valor Guias'}
   private Cvlrtita     := 0.00
   private cImposto     := 0.00
   private VlData       := 0.00
   private VlDatat      := 0.00
   private dData        := " "
   private cCompAnt     := " "
   private Vltotger     :=0.00
   private lCritica     :=.F.
   private cNumbor      := ' '
   private nTotSal      := 0.00
   private nTotVlr      := 0.00
   private cQueryn      := ' '
   private atit3a		   := {}
   private  aTitXls     := {"Tp Movimento","Data","Valor"}
   private  aTitulo     := {}
   private Cabecal2     := ""

   dbSelectArea("SEA")
   dbSetOrder(1)

   //-----------------------------------------
   //Função para validação das perguntas
   //-----------------------------------------
   ValidPerg()

   If Pergunte(cPerg,.T.) = .F.
      Return
   Endif

   if mv_par23  = 2
      limite       :=  132 //80
      tamanho      := "M"
   else
      limite       :=  80
      tamanho      := "P"
   Endif

   dDtInc   := mv_par01
   dDtFim   := mv_par02
   nMosMov  := mv_par03
   cTNãoSair:= mv_par04
   cListBord:= mv_par05
   cSubTot  := mv_par06
   cListCheq:= mv_par07
   cBNãoSair:= mv_par08
   cBSair   := mv_par09
   cTSair   := mv_par10
   cProtador:= mv_par11
   nResGer  := Mv_Par12
   nDetMed  := Mv_Par13

   if mv_par23 = 2
      Cabecal2 := "Border Pref  Numero      TIPO                     Ultimos Pagamentos  Total(Periodo)                       Valor    Fornecedor"
   else
      Cabecal2 := "Border Pref  Numero      TIPO        Valor            Fornecedor"
   endif

   //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
   //³ Monta a interface padrao com o usuario...                           ³
   //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

   wnrel := SetPrint(cString,NomeProg,"",@titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,.F.,Tamanho,,.T.)

   If nLastKey == 27
      Return
   Endif

   SetDefault(aReturn,cString)

   If nLastKey == 27
      Return
   Endif

   nTipo := If(aReturn[4]==1,15,18)

   //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
   //³ Processamento. RPTSTATUS monta janela com a regua de processamento. ³
   //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

   RptStatus({|| RunReport(Cabec1,Cabec2,Titulo,nLin) },Titulo)
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFun‡„o    ³RUNREPORT º Autor ³ AP6 IDE            º Data ³  31/08/07   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescri‡„o ³ Funcao auxiliar chamada pela RPTSTATUS. A funcao RPTSTATUS º±±
±±º          ³ monta a janela com a regua de processamento.               º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Programa principal                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function RunReport(Cabec1,Cabec2,Titulo,nLin)

   Local cQuery   := ' '
   local cPrefixo := ' '
   local cNum     := ' '
   local cCodrda  := ' '
   local lVaz     := .T.
   local nVlrTit  := 0.00
   local i        := 1
   local nI       := 0
   local _nBkp15  := 0
   local nVezes   := 0
   local _nz      := 0

   dbSelectArea(cString)
   dbSetOrder(1)

   //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
   //³ SETREGUA -> Indica quantos registros serao processados para a regua ³
   //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

   SetRegua(RecCount())
   If cListBord = 1
      cQuery :=" SELECT case when sea.EA_MODELO = '01' then '01 - Credito C/C Itau' "
      cQuery +=" when sea.EA_MODELO = '02' then '02 - Cheque Pagamento Administrativo' "
      cQuery +=" when sea.EA_MODELO = '03' then '03 - DOC ' "
      cQuery +=" when sea.EA_MODELO = '04' then '04 - OP a Disposição Com Aviso Para o Favorecido' "
      cQuery +=" when sea.EA_MODELO = '05' then '05 - Credito em Conta Poupança' "
      cQuery +=" when sea.EA_MODELO = '10' then '10 - OP a Disposição Sem Aviso Para o Favorecido' "
      cQuery +=" when sea.EA_MODELO = '13' then '13 - Pagamento a Concessionarias' "
      cQuery +=" when sea.EA_MODELO = '16' then '16 - Pagamento de Tributos - DARF Normal' "
      cQuery +=" when sea.EA_MODELO = '17' then '17 - OPagamento de Tributos GPS' "
      cQuery +=" when sea.EA_MODELO = '18' then '18 - Pagamento de Tributos - DARF Simples' "
      cQuery +=" when sea.EA_MODELO = '21' then '21 - Pagamento de Tributos - DARF' "
      cQuery +=" when sea.EA_MODELO = '30' then '30 - Pagamento de Titulos Itau' " //Angelo Henrique - Data:14/0519
      cQuery +=" when sea.EA_MODELO = '31' then '31 - Pagamento de Titulos Em Outros Bancos' "
      cQuery +=" when sea.EA_MODELO = '41' then '41 - TED - Outro Titular' "
      cQuery +=" when sea.EA_MODELO = '43' then '43 - TED - Mesmo Titular' "
      cQuery +=" when sea.EA_MODELO = '45' then '45 - PIX - Transferencia' "
      cQuery +=" when sea.EA_MODELO = '46' then '46 - PIX - Outros Bancos' "  
      cQuery +=" when sea.EA_MODELO = '47' then '47 - PIX - QR CODE' "
      cQuery +=" when sea.EA_MODELO = '48' then '48 - PIX - QR CODE Outros Bancos' "
      cQuery +=" else 'Outros'  end descricao, "
      cQuery +=" sea.EA_DATABOR  , SUM (ROUND(E2_VALOR,2)) VALLIQ1,  trunc(Sum ((E2_SALDO-e2_SDDECRE) + E2_SDACRES),2) Saldo " //Angelo - Removido um dos Rounds e acrescentado Trunc
      cQuery +=" FROM "+RetSqlName("SE2")+" SE2  ,(select DISTINCT EA_NUMBOR,  EA_DATABOR ,EA_MODELO FROM "+RetSqlName("SEA")+" SEA "
      cQuery +=" WHERE EA_FILIAL = '"+xFilial("SEA")+"' AND sea.d_E_L_E_T_ = ' ' AND EA_DATABOR >= '" +dtos(dDtInc)+"' "
      cQuery +=" AND EA_DATABOR <= '"+dtos(dDtFim) +"' AND EA_CART = 'P' "
      If !empty (cProtador)
         cQuery +="and  EA_PORTADO = '"+cProtador+"'"
      EndIf
      If !empty (cTNãoSair)
         cQuery +=" AND EA_MODELO NOT IN "+FormatIn(cTNãoSair, ",")
      EndIF
      If !empty (cTSair)
         cQuery +=" AND EA_MODELO IN "+FormatIn(cTSair, ",")
      EndIF

      If !empty (cBNãoSair)
         cQuery +=" AND EA_NUMBOR NOT IN "+FormatIn(cBNãoSair, ",")
      EndIF
      If !empty (cBSair)
         cQuery +=" AND EA_NUMBOR IN "+FormatIn(cBSair, ",")
      EndIF
      cQuery +=" ) sea WHERE e2_filial =  '"+xFilial("SE2")+"' AND d_e_L_E_T_ = ' ' AND e2_numbor In ( sea.EA_NUMBOR ) "
      cQuery +=" group BY sea.EA_DATABOR , sea.EA_MODELO "
      cQuery +=" ORDER BY sea.EA_DATABOR , sea.EA_MODELO "

      If Select("TMP") > 0
         dbSelectArea("TMP")
         dbclosearea()
      Endif

      TCQuery cQuery Alias "TMP" New
      dbSelectArea("TMP")
      tmp->(dbGoTop())

      If  (nMosMov = 2 .OR. nMosMov = 4)
         cQuery :=" SELECT  sea.EA_MODELO ,  sea.EA_DATABOR , e2_numbor , e2_PREFIXO , e2_num  ,e2_Tipo ,(E2_VALOR) VALLIQ1,((E2_SALDO - e2_SDDECRE) + E2_SDACRES) saldo ,
         cQuery +=" e2_nomfor ,(e2_inss+e2_irrf+e2_iss+e2_vretpis+e2_vretcof+e2_vretcsl) imp , e2_origem , e2_pllote , e2_codrda "
         if mv_par15 = 2
            cQuery +=", bd7_mespag , bd7_anopag , e2_sddecre, e2_decresc , sum (bd7_vlrpag) vlrpag "
         EndIf
         cQuery +=" FROM "+RetSqlName("SE2")+" SE2, "
         if mv_par15 = 2
            cQuery += RETSQLNAME("BD7")+" BD7, "
         EndIf
         cQuery +="                       ( select DISTINCT EA_NUMBOR,  EA_DATABOR ,EA_MODELO "
         cQuery +="                           FROM "+RetSqlName("SEA")+" SEA  "
         cQuery +="                          WHERE EA_FILIAL = '"+xFilial("SEA")+"' AND sea.d_E_L_E_T_ = ' '
         cQuery +="                            AND EA_DATABOR >= '" +dtos(dDtInc)+"' "
         cQuery +="                            AND EA_DATABOR <= '"+dtos(dDtFim) +"' AND EA_CART = 'P'
         If !empty (cTNãoSair)
            cQuery +="                         AND EA_MODELO NOT IN "+FormatIn(cTNãoSair, ",")
         EndIF
         If !empty (cTSair)
            cQuery +="                         AND EA_MODELO IN "+FormatIn(cTSair, ",")
         EndIF
         If !empty (cBNãoSair)
            cQuery +="                         AND EA_numbor NOT IN "+FormatIn(cBNãoSair, ",")
         EndIF
         If !empty (cBSair)
            cQuery +="                         AND EA_numbor IN "+FormatIn(cBSair, ",")
         EndIF
         If !empty (cProtador)
            cQuery +="                         and  EA_PORTADO = '"+cProtador+"'"
         EndIf
         cQuery +="                       ) sea "
         cQuery +=" WHERE e2_filial =  '"+xFilial("SE2")+"' AND se2.d_e_L_E_T_ = ' '  AND e2_numbor In ( sea.EA_NUMBOR ) "
         if Mv_par15 = 2
            cQuery +=" and bd7_filial =  '"+xFilial("bd7")+"' AND bd7.d_e_L_E_T_ = ' ' "
            cQuery +=" and SUBSTR(bd7_numlot,1,6) >= SUBSTR(E2_pllOte,1,6) and SUBSTR(bd7_numlot,1,6) <= SUBSTR(E2_pllOte,1,6) "
            cQuery +=" and bd7_codrda = E2_codrda and bd7_codope = '0001' AND E2_ORIGEM = 'PLSMPAG' "
         //EndIf
            cQuery +=" group by  sea.EA_MODELO ,  sea.EA_DATABOR , e2_numbor , e2_PREFIXO , e2_num , e2_Tipo ,(E2_VALOR) , "
            cQuery +=" ((e2_saldo - e2_sddecre) + e2_acresc) , e2_nomfor ,(e2_inss+e2_irrf+e2_iss+e2_vretpis++e2_vretcof+e2_vretcsl) ,      "
            cQuery +=" e2_origem , e2_pllote , e2_codrda "
         //if mv_par15 = 2
            cQuery +=", bd7_mespag , bd7_anopag  , e2_sddecre, e2_decresc    "

            cQuery +=" union "

            cQuery +=" SELECT  sea.EA_MODELO ,  sea.EA_DATABOR , e2_numbor , e2_PREFIXO , e2_num  ,e2_Tipo ,(E2_VALOR) VALLIQ1,((E2_SALDO - e2_SDDECRE) + E2_SDACRES) saldo ,
            cQuery +=" e2_nomfor ,(e2_inss+e2_irrf+e2_iss+e2_vretpis+e2_vretcof+e2_vretcsl) imp , e2_origem , e2_pllote , e2_codrda , '00' , '0000' , e2_sddecre, e2_decresc , 0.00 "
            cQuery +=" FROM "+RetSqlName("SE2")+" SE2 , "
            cQuery +="                       ( select DISTINCT EA_NUMBOR,  EA_DATABOR ,EA_MODELO "
            cQuery +="                           FROM "+RetSqlName("SEA")+" SEA  "
            cQuery +="                          WHERE EA_FILIAL = '"+xFilial("SEA")+"' AND sea.d_E_L_E_T_ = ' '
            cQuery +="                            AND EA_DATABOR >= '" +dtos(dDtInc)+"' "
            cQuery +="                            AND EA_DATABOR <= '"+dtos(dDtFim) +"' AND EA_CART = 'P'
            If !empty (cTNãoSair)
               cQuery +="                         AND EA_MODELO NOT IN "+FormatIn(cTNãoSair, ",")
            EndIF
            If !empty (cTSair)
               cQuery +="                         AND EA_MODELO IN "+FormatIn(cTSair, ",")
            EndIF
            If !empty (cBNãoSair)
               cQuery +="                         AND EA_numbor NOT IN "+FormatIn(cBNãoSair, ",")
            EndIF
            If !empty (cBSair)
               cQuery +="                         AND EA_numbor IN "+FormatIn(cBSair, ",")
            EndIF
            If !empty (cProtador)
               cQuery +="                         and  EA_PORTADO = '"+cProtador+"'"
            EndIf
            cQuery +="                       ) sea "
            cQuery +=" WHERE e2_filial =  '"+xFilial("SE2")+"' AND se2.d_e_L_E_T_ = ' '  AND e2_numbor In ( sea.EA_NUMBOR ) "
            cQuery +="  AND E2_ORIGEM <> 'PLSMPAG' "
            cQuery +=" group by  sea.EA_MODELO ,  sea.EA_DATABOR , e2_numbor , e2_PREFIXO , e2_num , e2_Tipo ,(E2_VALOR) , "
            cQuery +=" ( ( e2_saldo - e2_sddecre ) + e2_acresc ) , e2_nomfor ,(e2_inss+e2_irrf+e2_iss+e2_vretpis++e2_vretcof+e2_vretcsl) ,      "
            cQuery +=" e2_origem , e2_pllote , e2_codrda  ,  e2_sddecre, e2_decresc    "
         EndIf
         cQuery +=" ORDER BY 2,1 , 4 , 5 "
         if mv_par15 = 2
            cQuery += ",13  "
         EndIf

         memowrit("c:\temp\cabr104C.sql",cQuery)

         If Select("TMP1") > 0
            dbSelectArea("TMP1")
            dbclosearea()
         Endif
         TCQuery cQuery Alias "TMP1" New
         dbSelectArea("TMP1")
         tmp1->(dbGoTop())
      EndIf
      If  (nMosMov = 3 .OR. nMosMov = 4)
         cQuery :=" SELECT  EA_NUMBOR, EA_DATABOR, EA_MODELO, SUM (ROUND(E2_VALOR , 2)) VALLIQ1 ,Sum((E2_SALDO - e2_SDDECRE) + E2_SDACRES) saldo ,"
         cQuery +="  case when sea.EA_MODELO = '01' then '01 - Credito C/C Itau' "
         cQuery +=" when sea.EA_MODELO = '02' then '02 - Cheque Pagamento Administrativo' "
         cQuery +=" when sea.EA_MODELO = '03' then '03 - DOC ' "
         cQuery +=" when sea.EA_MODELO = '04' then '04 - OP a Disposição Com Aviso Para o Favorecido' "
         cQuery +=" when sea.EA_MODELO = '05' then '05 - Credito em Conta Poupança' "
         cQuery +=" when sea.EA_MODELO = '10' then '10 - OP a Disposição Sem Aviso Para o Favorecido' "
         cQuery +=" when sea.EA_MODELO = '13' then '13 - Pagamento a Concessionarias' "
         cQuery +=" when sea.EA_MODELO = '16' then '16 - Pagamento de Tributos - DARF Normal' "
         cQuery +=" when sea.EA_MODELO = '17' then '17 - Pagamento de Tributos GPS' "
         cQuery +=" when sea.EA_MODELO = '18' then '18 - Pagamento de Tributos - DARF Simples' "
         cQuery +=" when sea.EA_MODELO = '21' then '21 - Pagamento de Tributos - DARF' "
         cQuery +=" when sea.EA_MODELO = '30' then '30 - Pagamento de Titulos Itau' " //Angelo Henrique - Data:14/0519
         cQuery +=" when sea.EA_MODELO = '31' then '31 - Pagamento de Titulos Em Outros Bancos' "
         cQuery +=" when sea.EA_MODELO = '41' then '41 - TED - Outro Titular' "
         cQuery +=" when sea.EA_MODELO = '43' then '43 - TED - Mesmo Titular' "
         cQuery +=" when sea.EA_MODELO = '45' then '45 - PIX - Transferencia' "
         cQuery +=" when sea.EA_MODELO = '46' then '46 - PIX - Outros Bancos' "
         cQuery +=" when sea.EA_MODELO = '47' then '47 - PIX - QR CODE' "
         cQuery +=" when sea.EA_MODELO = '48' then '48 - PIX - QR CODE Outros Bancos' "
         cQuery +=" else 'Outros'  end descricao "
         cQuery +=" FROM "+RetSqlName("SE2")+" SE2 ,(select DISTINCT EA_NUMBOR,  EA_DATABOR ,EA_MODELO FROM "+RetSqlName("SEA")+" SEA "
         cQuery +=" WHERE EA_FILIAL = '"+xFilial("SEA")+"' AND sea.d_E_L_E_T_ = ' ' AND EA_DATABOR >= '" +dtos(dDtInc)+"' "
         cQuery +=" AND EA_DATABOR <= '"+dtos(dDtFim) +"' AND EA_CART = 'P'
         If !empty (cTNãoSair)
            cQuery +=" AND EA_MODELO NOT IN "+FormatIn(cTSair, ",")
         EndIF
         If !empty (cTSair)
            cQuery +=" AND EA_MODELO IN "+FormatIn(cTSair, ",")
         EndIF
         If !empty (cBNãoSair)
            cQuery +=" AND EA_numbor NOT IN "+FormatIn(cBNãoSair, ",")
         EndIF
         If !empty (cBSair)
            cQuery +=" AND EA_numbor IN "+FormatIn(cBSair, ",")
         EndIF
         If !empty (cProtador)
            cQuery +="and  EA_PORTADO = '"+cProtador+"'"
         EndIf

         cQuery +=" ) sea WHERE e2_filial = '"+xFilial("SE2")+"' AND d_e_L_E_T_ = ' ' AND e2_numbor In ( sea.EA_NUMBOR ) "
         cQuery +=" group BY  EA_DATABOR , EA_MODELO , EA_NUMBOR "
         cQuery +=" ORDER BY sea.EA_DATABOR , sea.EA_MODELO  "

         If Select("TMP2") > 0
            dbSelectArea("TMP2")
            dbclosearea()
         Endif
         TCQuery cQuery Alias "TMP2" New
         dbSelectArea("TMP2")
         tmp2->(dbGoTop())
      EndIf

      While tmp->(!EOF())
         If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
            nLin  := Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
            dData := TMP->EA_DATABOR
         Endif

         //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
         //³ Verifica o cancelamento pelo usuario...                             ³
         //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
         If lAbortPrint
            @nLin,00 PSAY "*** CANCELADO PELO OPERADOR ***"
            Exit
         Endif

         //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
         //³ Impressao do cabecalho do relatorio. . .                            ³
         //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
         If nLin > 58 .and. cSubTot = 1
            @ nLin,000 PSay replicate("_",080)
            nLin := nLin + 1
            @ nLin,025 PSAY "Sub-Total Data "
            @ nlin,042 psay stod(dData)
            @ nlin,053 psay " ---> "
            @ nLin,062 PSAY VlData     Picture "@E 99,999,999.99"
            nLin := nLin + 1
            @ nLin,000 PSay replicate("_",080)
            dData:= TMP->EA_DATABOR
         endif

         if (cSubTot = 1 .and. TMP->EA_DATABOR  != dData )
            @ nLin,000 PSay replicate("_",080)
            nLin := nLin + 1
            @ nLin,030 PSAY "Total Data "
            @ nlin,042 psay stod(dData)
            @ nlin,053 psay " ---> "
            @ nLin,062 PSAY VlData     Picture "@E 99,999,999.99"
            nLin := nLin + 1
            @ nLin,000 PSay replicate("_",080)
            nLin := nLin + 1
            dData:= TMP->EA_DATABOR
            VlData := 0.00
         EndIf
         nLin++

         @ nLin,002 PSAY trim (TMP->descricao)
         @ nLin,046 PSAY stod(TMP->EA_DATABOR)
         if mv_par14 = 1
            @ nLin,062 PSAY TMP->Saldo   Picture "@E 999,999,999.99"
         else
            @ nLin,062 PSAY TMP->valliq1 Picture "@E 999,999,999.99"
         EndIf

         nLin++
         //nLin++

         If  (nMosMov = 3 .OR. nMosMov = 4)
            @ nLin,000 PSay replicate("_",080)
            nLin := nLin + 1
            While (tmp2->(!EOF()) .and. tmp2->EA_MODELO = substr (TMP->descricao,1,2) .and. tmp2->EA_DATABOR = tmp->EA_DATABOR .and. (nMosMov = 3 .OR. nMosMov = 4) )

               @ nLin,001 PSAY trim (TMP2->EA_NUMBOR)
               @ nLin,008 PSAY  stod(TMP2->EA_DATABOR)
               @ nLin,020 PSAY TMP2->descricao
               if mv_par14 = 1
                  @ nLin,062 PSAY TMP2->Saldo   Picture "@E 999,999,999.99"
               else
                  @ nLin,062 PSAY TMP2->valliq1 Picture "@E 999,999,999.99"
               EndIf
               nLin++
               If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
                  nLin  := Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
                  nLin++
               Endif

               tmp2->(dbSkip())   // Avanca o ponteiro do registro no arquivo
            EndDo
         EndIf
         If (nMosMov = 2 .OR. nMosMov = 3 .OR. nMosMov = 4)
            @ nLin,000 PSay replicate("_",080)
            nLin++
           
           // @ nLin,000 PSAY  Cabecal2
           // nLin++

            if mv_par23 = 2
               @ nLin,000 PSay replicate("_",140)
            else
               @ nLin,000 PSay replicate("_",080)
            endif

            nLin++

         EndIf
         If (nMosMov = 2 .OR. nMosMov = 4)
            While (tmp1->(!EOF()) .and. tmp1->EA_MODELO = substr (TMP->descricao,1,2) .and. tmp1->EA_DATABOR = tmp->EA_DATABOR .and.  (nMosMov = 2 .OR. nMosMov = 4))

               if mv_par23 = 2
                  cnumbor := TMP1->e2_numbor
                  cpref   := TMP1->e2_PREFIXO
                  cnum    := TMP1->e2_num

                  cSq2 := "  SELECT E2_FORNECE,E2_LOJA "
                  cSq2 += "  FROM "+RETSQLNAME("SE2")+" "
                  cSq2 += "  WHERE D_E_L_E_T_<> '*' "
                  cSq2 += "  AND E2_FILIAL  = '"+xFilial("SE2")+"' "
                  cSq2 += "  AND E2_NUMBOR  = '"+cnumbor+"' "
                  cSq2 += "  AND E2_PREFIXO = '"+cpref+"' "
                  cSq2 += "  AND E2_NUM     = '"+cnum+"' "

                  memowrit("c:\temp\fornec104.sql",cSq2)
                  If ( Select("QR2") > 0 )
                     QR2->( dbCloseArea() )
                  EndIf
                  TcQuery cSq2 Alias "QR2" New

                  cE2_FORNECE := QR2->E2_FORNECE
                  cE2_LOJA    := QR2->E2_LOJA
                  QR2->( dbCloseArea() )

                  cSq3 := " SELECT SUBSTR(E2_BAIXA,1,6) DTBAIXA ,SUM(E2_VALOR) VALOR "
                  cSq3 += "  FROM "+RETSQLNAME("SE2")+" "
                  cSq3 += "   WHERE D_E_L_E_T_<>'*' "
                  cSq3 += "   AND E2_FILIAL  = '"+xFilial("SE2")+"' "
                  cSq3 += "   AND E2_FORNECE = '"+cE2_FORNECE+"' "
                  cSq3 += "   AND E2_LOJA    = '"+cE2_LOJA   +"' "
                  cSq3 += "   AND E2_BAIXA <> ' ' "
                  cSq3 += "   GROUP BY SUBSTR(E2_BAIXA,1,6) "
                  cSq3 += "   ORDER BY SUBSTR(E2_BAIXA,1,6) DESC "

                  memowrit("c:\temp\titant.sql",cSq3)

                  If ( Select("QR3") > 0 )
                     QR3->( dbCloseArea() )
                  EndIf
                  TcQuery cSq3 Alias "QR3" New

                  if !eof()
                     cE2_VENCREA    := space(8)
                     cE2_BAIXA      := space(8)
                     nE2_VALOR      := 0.00
                     ctit           := " "
                     X              := 1

                     cE2_BAIXA1     := space(8)
                     nE2_VALOR1     := 0.00

                     cE2_BAIXA2     := space(8)
                     nE2_VALOR2     := 0.00

                     cE2_BAIXA3     := space(8)
                     nE2_VALOR3     := 0.00

                     Do While !eof() .and. x < 4

                        if x = 1
                           cE2_BAIXA1   := substr    (QR3->DTBAIXA,5,2)+"/"+ substr(QR3->DTBAIXA,1,4)
                           nE2_VALOR1   := Transform(QR3->VALOR,"@e 9,999,999.99")
                        Endif

                        if x = 2
                           cE2_BAIXA2   := substr    (QR3->DTBAIXA,5,2)+"/"+ substr(QR3->DTBAIXA,1,4)
                           nE2_VALOR2   := Transform(QR3->VALOR,"@e 9,999,999.99")
                        Endif

                        if x = 3
                           cE2_BAIXA3   := substr    (QR3->DTBAIXA,5,2)+"/"+ substr(QR3->DTBAIXA,1,4)
                           nE2_VALOR3   := Transform(QR3->VALOR,"@e 9,999,999.99")
                        Endif

                        DBSELECTAREA("QR3")
                        x := x + 1

                        DBSKIP()
                     Enddo

                     @  nLin,001 PSAY ctit
                     nLin++
                     QR3->( dbCloseArea() )
                  endif

                  DBSELECTAREA("TMP1")

                  @ nLin,001 PSAY TMP1->e2_numbor
                  @ nLin,008 PSAY TMP1->e2_PREFIXO
                  @ nLin,013 PSAY TMP1->e2_num
                  @ nLin,025 PSAY TMP1->e2_Tipo

                  @ nLin,030 PSAY nE2_VALOR3
                  @ nLin,042 PSAY "("+cE2_BAIXA3+")"

                  @ nLin,054 PSAY nE2_VALOR2
                  @ nLin,066 PSAY "("+cE2_BAIXA2+")"

                  @ nLin,078 PSAY nE2_VALOR1
                  @ nLin,090 PSAY "("+cE2_BAIXA1+")"

                  if mv_par14 = 1
                     @ nLin,101 PSAY TMP1->saldo    Picture "@E 999,999,999.99"
                  else
                     @ nLin,101 PSAY TMP1->valliq1   Picture "@E 999,999,999.99"
                  EndIf

                  @ nLin,116 PSAY substr (TMP1->e2_nomfor, 1,30)

                  If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
                     nLin  := Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
                     nLin++   // alterado pois estava dando sobreposto no texto do fonte 08/04/2020
                  Endif
               Else
                  @ nLin,001 PSAY TMP1->e2_numbor
                  @ nLin,008 PSAY TMP1->e2_PREFIXO
                  @ nLin,013 PSAY TMP1->e2_num
                  @ nLin,025 PSAY TMP1->e2_Tipo
                  if mv_par14 = 1
                     @ nLin,031 PSAY TMP1->saldo    Picture "@E 999,999,999.99"
                  else
                     @ nLin,031 PSAY TMP1->valliq1 Picture "@E 999,999,999.99"
                  EndIf
                  @ nLin,045 PSAY TMP1->E2_codrda + ' - ' + substr (TMP1->e2_nomfor, 1,30)
                  nLin++
                  If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
                     nLin  := Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
                     nLin++
                  Endif
               Endif

               if tmp1->(!EOF())
                  cPrefixo := tmp1->e2_prefixo
                  cNum     := tmp1->e2_num
                  cCodrda  := tmp1->E2_CODRDA
               EndIf

               lvaz    := .T.
               imposto := iif (mv_par17==1,.F.,.T.)

               While mv_par15 == 2 .and. tmp1->e2_prefixo == cPrefixo .and. tmp1->e2_num == cNum .and. tmp1->E2_CODRDA == cCodrda .and. trim(tmp1->e2_origem) == 'PLSMPAG' .and. tmp1->e2_prefixo != 'COM'
                  if mv_par16 = 2
                     if imposto
                        nLin++   // alterado pois estava dando sobreposto no texto do fonte 08/04/2020

                        @  nLin,008 PSAY "Impostos Retidos "
                        @  nLin,040 PSAY (tmp1->imp) Picture "@E 999,999,999.99"
                        nLin++
                        imposto := .F.
                        If tmp1->e2_decresc  > 0
                           nLin++   // alterado pois estava dando sobreposto no texto do fonte 08/04/2020
                           @  nLin,008 PSAY "Decrescimo  "
                           @  nLin,040 PSAY (tmp1->e2_decresc) Picture "@E 999,999,999.99"
                           nLin++
                        EndIf
                     EndIf

                     @  nLin,008 PSAY tmp1->bd7_mespag+'/'+tmp1->bd7_anopag
                     @  nLin,040 PSAY tmp1->vlrpag Picture "@E 999,999,999.99"
                     nLin++
                     nVlrTit += tmp1->vlrpag
                  else
                     cCompd+= tmp1->bd7_mespag+'/'+tmp1->bd7_anopag +' , '
                     nVlrTit +=  tmp1->vlrpag
                  EndIf

                  If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
                     nLin  := Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
                     nLin++
                  Endif
                  Aadd(aSaidCom,{tmp1->e2_prefixo, tmp1->e2_num, tmp1->e2_tipo , tmp1->saldo ,tmp1->imp ,tmp1->e2_decresc,   tmp1->e2_codrda , tmp1->e2_nomfor, substr(tmp1->e2_pllote,1,6) , tmp1->bd7_mespag+'/'+tmp1->bd7_anopag,tmp1->vlrpag })
                  If (nAscan:=Ascan(aComPg , {|e| e[2]+e[3] ==  tmp1->bd7_mespag + tmp1->bd7_anopag  })) == 0
                     Aadd(aComPg, { tmp1->bd7_anopag + tmp1->bd7_mespag ,;
                        tmp1->bd7_mespag     ,;
                        tmp1->bd7_anopag     ,;
                        tmp1->vlrpag})
                  Else
                     aComPg[nAscan,04]+= tmp1->vlrpag
                  EndIf
                  Cvlrtita := tmp1->saldo
                  cImposto := tmp1->imp
                  cpllote  := SUBSTR(TMP1->E2_pllOte,1,6)
                  tmp1->(dbSkip())
                  if tmp1->e2_prefixo != cPrefixo .or. tmp1->e2_num != cNum .or. tmp1->E2_CODRDA != cCodrda
                     if mv_par16 = 1
                        If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
                           nLin := Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
                           nLin ++
                        Endif
                        @ nLin,008 PSAY cCompd
                        cCompd := 'Competencias--> '
                        nLin++
                     EndIf
                     lvaz := .F.
                  EndIf
                  if mv_par18 = 2  .and. nVlrTit!=  (Cvlrtita + cImposto)
                     cQuery := "select bgq_ano , bgq_mes , bgq_numlot ,  SUM(DECODE(bgq_tipo,1,-1*BGQ_VALOR,BGQ_VALOR)) Vl_Informado "
                     cQuery += " from "+RETSQLNAME("BGQ")+" BGQ"
                     cQuery += " where bgq_filial = '  ' and bgq.d_E_L_E_T_ = ' ' and bgq_codlan <> '050' "
                     cQuery += " and  SUBSTR(bgq_numlot,1,6) >= '"+cpllote+"' and SUBSTR(bgq_numlot,1,6) <= '"+cpllote+"' and bgq_codigo  = '"+cCodrda +"' "
                     cQuery += " group by  bgq_ano, bgq_mes,bgq_numlot "

                     nVlrTit := 0.00
                     If Select("TMP6") > 0
                        dbSelectArea("TMP6")
                        dbclosearea()
                     Endif
                     TCQuery cQuery Alias "TMP6" New
                     dbSelectArea("TMP6")
                     tmp6->(dbGoTop())
                     While tmp6->(!EOF())
                        If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
                           nLin := Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
                           nLin ++
                        Endif
                        @  nLin,008 PSAY "Cred/Debito  "
                        @  nLin,030 PSAY tmp6->bgq_ano +'/'+ tmp6->bgq_mes +' - '+ tmp6->bgq_numlot
                        @  nLin,040 PSAY tmp6->Vl_Informado Picture "@E 999,999,999.99"
                     Enddo
                  EndIf

               EndDo

               If mv_par15 != 2  .or. lvaz == .T.
                  tmp1->(dbSkip())   // Avanca o ponteiro do registro no arquivo
               EndIf
            EndDo

         EndIf
         If  (nMosMov = 2 .OR. nMosMov = 4)
            if mv_par23 = 2
               @ nLin,000 PSay replicate("_",140)
               nLin := nLin + 1
            else
               @ nLin,000 PSay replicate("_",80)
               nLin := nLin + 1

            endif

         EndIf

         if mv_par14 = 1
            VlDatat +=TMP->saldo
            VlData  +=TMP->saldo
         else
            VlDatat +=TMP->valliq1
            VlData  +=TMP->valliq1
         EndIf

         tmp->(dbSkip())
      EndDo

      nLin := nLin + 1
      If cSubTot = 1

         if mv_par23 = 1
            @ nLin,030 PSAY "Total Data "
            @ nlin,042 psay stod(dData)
            @ nlin,053 psay " ---> "
            @ nLin,062 PSAY VlData     Picture "@E 99,999,999.99"
            nLin := nLin + 1
            @ nLin,000 PSay replicate("_",080)
            nLin := nLin + 1

         else
            @ nLin,066 PSAY "Total Data "
            @ nlin,078 psay stod(dData)
            @ nlin,091 psay " ---> "
            @ nLin,102 PSAY VlData     Picture "@E 99,999,999.99"
            nLin := nLin + 1
            @ nLin,000 PSay replicate("_",140)
            nLin := nLin + 1

         endif

      EndIf

      if mv_par23 = 1
         @ nLin,040 PSAY "Total   -----> "
         @ nLin,062 PSAY VlDatat     Picture "@E 99,999,999.99"
         nLin := nLin + 1
      else
         @ nLin,066 PSAY "Total   -----> "
         @ nLin,102 PSAY VlDatat     Picture "@E 99,999,999.99"
         nLin := nLin + 1
      Endif

      if mv_par23 = 1
         @ nLin,000 PSay replicate("_",080)
      else
         @ nLin,000 PSay replicate("_",140)
      endif
   EndIf
   If (nMosMov = 2 .OR. nMosMov = 4)
      aSort( aComPg,,,{|x,y| x[1] < y[1]} )
      @ nLin,000 PSay replicate("_",080)
      nliN++
      if mv_par23 = 1
         if len(aComPg) > 0          //len(len(aComPg)) > 0 // foi colocado na logica original depois 08/07/2020
            @ nLin,000 PSay replicate("_",080)
            nliN++
            @ nLiN, 015 Psay '    '
            @ nLiN, 038 Psay '  Valor  '
            nliN++
         endif

      else

         @ nLin,000 PSay replicate("_",140)
         nliN++
      Endif

      While  i <= len(aComPg)
         @ nLiN, 015 Psay aComPg[i][2]+'/'+aComPg[i][3]
         @ nLiN, 038 Psay aComPg[i][4] Picture "@E 999,999,999.99"
         nliN++
         i++
      Enddo
   EndIf
   If cListCheq == 1
      nLin := 80
      Cabec1:= "   Data    Bco  Ag   Conta    Num.Chq         Valor  Prf    Numero tipo Benefic"
      //         123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
      //                  1         2         3         4         5         6         7         8
      Cabec2:= ' '

      VlDatat :=0.00
      VlData  :=0.00
      cQuery :=" SELECT EF_DATA,EF_BANCO,EF_AGENCIA,EF_CONTA,EF_NUM,EF_VALOR,EF_PREFIXO,EF_TITULO,EF_TIPO,EF_BENEF,EF_HIST "
      cQuery +=" FROM "+RetSqlName("SEF")+" SEF  WHERE EF_FILIAL  = '"+xFilial("SEF")+"' AND d_E_L_E_T_ = ' ' "
      cQuery +=" AND EF_DATA >= '"+dtos(dDtInc) +"' AND  EF_DATA <= '"+dtos(dDtFim)+"' "
      If !empty (cProtador)
         cQuery +="and  EF_BANCO = '"+cProtador+"'"
      EndIf
      cQuery +="order by EF_DATA,EF_BANCO,EF_AGENCIA,EF_CONTA,EF_NUM,EF_VALOR,EF_PREFIXO,EF_TITULO,EF_TIPO"
      If Select("TMP3") > 0
         dbSelectArea("TMP3")
         dbclosearea()
      Endif
      TCQuery cQuery Alias "TMP3" New
      dbSelectArea("TMP3")
      tmp3->(dbGoTop())
      cnumChq:= " "
      While tmp3->(!EOF())
         If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
            nLin  := Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
            dData := TMP3->EF_DATA
            nLin ++
         Endif
         If nLin > 58 .and. cSubTot = 1
            @ nLin,000 PSay replicate("_",080)
            nLin := nLin + 1
            @ nLin,025 PSAY "Sub-Total Data "
            @ nlin,042 psay stod(dData)
            @ nlin,053 psay " ---> "
            @ nLin,062 PSAY VlData     Picture "@E 99,999,999.99"
            nLin := nLin + 1
            @ nLin,000 PSay replicate("_",080)
            dData:= TMP3->EF_DATA
         endif
         if (cSubTot = 1 .and.  TMP3->EF_DATA  != dData )
            @ nLin,000 PSay replicate("_",080)
            nLin := nLin + 1
            @ nLin,030 PSAY "Total Data "
            @ nlin,042 psay stod(dData)
            @ nlin,053 psay " ---> "
            @ nLin,062 PSAY VlData     Picture "@E 99,999,999.99"
            nLin := nLin + 1
            @ nLin,000 PSay replicate("_",080)
            nLin := nLin + 1
            dData:= TMP3->EF_DATA
            VlData := 0.00
         EndIf
         nLin++
         if cnumChq != substr (TMP3->EF_NUM,1,8)
            @ nLin,000 PSAY STOD(TMP3->EF_DATA)
            @ nLin,011 PSAY TMP3->EF_BANCO
            @ nLin,015 PSAY TMP3->EF_AGENCIA
            @ nLin,020 PSAY TMP3->EF_CONTA
            @ nLin,031 PSAY substr (TMP3->EF_NUM,1,8)
            @ nLin,040 PSAY TMP3->EF_VALOR   Picture "@E 999,999,999.99"
            @ nLin,053 PSAY substr (TMP3->EF_hist,1,20)
            VlDatat +=TMP3->EF_VALOR
            VlData  +=TMP3->EF_VALOR
         Else
            @ nLin,001 PSAY "*** Baixar o titulos --> "
            @ nLin,026 PSAY TMP3->EF_PREFIXO
            @ nLin,030 PSAY TMP3->EF_TITULO
            @ nLin,040 PSAY TMP3->EF_TIPO
            @ nLin,045 PSAY substr (TMP3->EF_BENEF,1,20)
         EndIf
         cnumChq := substr (TMP3->EF_NUM,1,8)
         tmp3->(dbSkip())
      EndDo
      @ nLin,000 PSay replicate("_",080)
      nLin := nLin + 1
      If cSubTot = 1
         @ nLin,030 PSAY "Total Data "
         @ nlin,042 psay stod(dData)
         @ nlin,053 psay " ---> "
         @ nLin,062 PSAY VlData     Picture "@E 99,999,999.99"
         nLin := nLin + 1
         @ nLin,000 PSay replicate("_",080)
         nLin := nLin + 1
      EndIf
      @ nLin,040 PSAY "Total   -----> "
      @ nLin,062 PSAY VlDatat     Picture "@E 99,999,999.99"
      nLin := nLin + 1
      @ nLin,000 PSay replicate("_",080)
   EndIf

   If nResGer  = 1
      Titulo := " Visão Gerencial"

      //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
      //³ Competencia  - sintetica        ......                             ³
      //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

      nLin := 80

      if mv_par23 = 1
         cabec1:= "Grupo de Pgto                                                      Valor "
      else
         cabec1:= "Grupo Pgto                                    Ultimos Pagamentos  Total(Periodo)                              Valor Tit      Saldo Tit"
      endif

      //              123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
      //                         1         2         3         4         5         6         7         8
      Cabec2:= ' '
      VlCompt :=0.00
      VlComp  :=0.00

      _nBkp15 := MV_PAR15

      If MV_PAR15 = 1
         nVezes := 1
      Else
         nVezes := 2
      EndIf

      For _nz := 1 to nVezes

         If nVezes = 2 .and. _nz = 1
            MV_PAR15 := 1
         elseIF nVezes = 2 .and. _nz = 2
            MV_PAR15 := 2
         EndIf

         cQueryn :="      SELECT  "

         If MV_PAR15 = 2
            cQueryn += CRLF+ " substr (e2_pllote, 1,6) Competencia,
         EndIf

         cQueryn += CRLF+ " NVL(ZUO_GRUPO, 'NÃO Certificado') Tit, SUM (ROUND(E2_VALOR , 2)) VALLIQ1, SUM ((E2_SALDO-e2_SDDECRE) + E2_SDACRES) Saldo  "
         cQueryn += CRLF+ " FROM "+RetSqlName("SE2")+" SE2,"+RetSqlName("ZUO")+" ZUO, "
         cQueryn += CRLF+ "(SELECT DISTINCT EA_NUMBOR,  EA_DATABOR ,EA_MODELO FROM "+RetSqlName("SEA")+" SEA "
         cQueryn += CRLF+ " WHERE EA_FILIAL = '"+xFilial("SEA")+"' AND sea.d_E_L_E_T_ = ' ' "
         cQueryn += CRLF+ "   AND EA_DATABOR >= '" +dtos(dDtInc)+"' "
         cQueryn += CRLF+ "   AND EA_DATABOR <= '"+dtos(dDtFim) +"' "
         cQueryn += CRLF+ "   AND EA_CART = 'P' "
         If !empty (cProtador)
            cQueryn +=CRLF+ "and  EA_PORTADO = '"+cProtador+"'"
         EndIf
         If !empty (cTNãoSair)
            cQueryn += CRLF+ " AND EA_MODELO NOT IN "+FormatIn(cTNãoSair, ",")
         EndIF
         If !empty (cTSair)
            cQueryn += CRLF+ " AND EA_MODELO IN "+FormatIn(cTSair, ",")
         EndIF
         If !empty (cBNãoSair)
            cQueryn += CRLF+ " AND EA_NUMBOR NOT IN "+FormatIn(cBNãoSair, ",")
         EndIF
         If !empty (cBSair)
            cQueryn += CRLF+ " AND EA_NUMBOR IN "+FormatIn(cBSair, ",")
         EndIF
         cQueryn += CRLF+ " ) sea WHERE e2_filial =  '"+xFilial("SE2")+"' AND SE2.d_e_L_E_T_ = ' '"
         cQueryn += CRLF+ " AND ZUO_FILIAL(+) = '"+xFilial("ZUO")+"' AND ZUO.d_E_L_E_T_(+) = ' ' "
         cQueryn += CRLF+ " AND e2_numbor In ( sea.EA_NUMBOR ) "
         cQueryn += CRLF+ " AND e2_origem = ZUO_ORIGEM(+) "
         cQueryn += CRLF+ " AND E2_PREFIXO = ZUO_PREF(+) "
         cQueryn += CRLF+ " AND E2_TIPO NOT IN ('TX' , 'INS','ISS', 'IRF', 'FGT') "

         If empty(Alltrim(mv_par24))
            cQueryn += CRLF+ " AND ZUO_GRUPO <> 'OPME' "
         Else
            cQueryn += CRLF+ " AND ZUO_GRUPO = '"+alltrim(MV_PAR24)+"'"
         EndIF

         //COMENTADO POR MARCOS PARA LISTAR O PGTO MEDICO E SEU TOTAL
         // If MV_PAR15 = 1
         //    cQueryn += CRLF+ " AND ZUO_GRUPO <> 'PGTO MEDICO' "
         // endif

         cQueryn += CRLF+ "GROUP BY "

         If MV_PAR15 = 2
            cQueryn += CRLF+ " substr(e2_pllote, 1,6), "
         EndIf

         cQueryn += CRLF+ " NVL(ZUO_GRUPO, 'NÃO Certificado') "
         
         If empty(Alltrim(mv_par24))
            cQueryn += CRLF+ " UNION ALL "
            
            //OPME
            cQueryn +="      SELECT  "

            If MV_PAR15 = 2
               cQueryn += CRLF+ " substr (F1_EMISSAO, 1,6) Competencia,
            EndIf

            cQueryn += CRLF+ " NVL(ZUO_GRUPO, 'NÃO Certificado') Tit, SUM (ROUND(E2_VALOR , 2)) VALLIQ1, SUM ((E2_SALDO-e2_SDDECRE) + E2_SDACRES) Saldo  "
            cQueryn += CRLF+ " FROM "+RetSqlName("SE2")+" SE2, "+RetSqlName("ZUO")+" ZUO, "+RetSqlName("SF1")+" SF1, "
            cQueryn += CRLF+ "(SELECT DISTINCT EA_NUMBOR,  EA_DATABOR ,EA_MODELO FROM "+RetSqlName("SEA")+" SEA "
            cQueryn += CRLF+ " WHERE EA_FILIAL = '"+xFilial("SEA")+"' AND sea.d_E_L_E_T_ = ' ' "
            cQueryn += CRLF+ "   AND EA_DATABOR >= '" +dtos(dDtInc)+"' "
            cQueryn += CRLF+ "   AND EA_DATABOR <= '"+dtos(dDtFim) +"' "
            cQueryn += CRLF+ "   AND EA_CART = 'P' "
            If !empty (cProtador)
               cQueryn +=CRLF+ "and  EA_PORTADO = '"+cProtador+"'"
            EndIf
            If !empty (cTNãoSair)
               cQueryn += CRLF+ " AND EA_MODELO NOT IN "+FormatIn(cTNãoSair, ",")
            EndIF
            If !empty (cTSair)
               cQueryn += CRLF+ " AND EA_MODELO IN "+FormatIn(cTSair, ",")
            EndIF
            If !empty (cBNãoSair)
               cQueryn += CRLF+ " AND EA_NUMBOR NOT IN "+FormatIn(cBNãoSair, ",")
            EndIF
            If !empty (cBSair)
               cQueryn += CRLF+ " AND EA_NUMBOR IN "+FormatIn(cBSair, ",")
            EndIF
            cQueryn += CRLF+ " ) sea WHERE e2_filial =  '"+xFilial("SE2")+"' AND SE2.d_e_L_E_T_ = ' '"
            cQueryn += CRLF+ " AND F1_FILIAL(+) =  '"+xFilial("SF1")+"' AND SF1.D_E_L_E_T_(+) = ' ' "
            cQueryn += CRLF+ " AND ZUO_FILIAL(+) = '"+xFilial("ZUO")+"' AND ZUO.d_E_L_E_T_(+) = ' ' "
            cQueryn += CRLF+ " AND e2_numbor In ( sea.EA_NUMBOR ) "
            cQueryn += CRLF+ " AND e2_origem = ZUO_ORIGEM(+) "
            cQueryn += CRLF+ " AND E2_PREFIXO = ZUO_PREF(+) "
            cQueryn += CRLF+ " AND E2_TIPO NOT IN ('TX' , 'INS','ISS', 'IRF', 'FGT') "
            cQueryn += CRLF+ " AND ZUO_GRUPO = 'OPME' "
            cQueryn += CRLF+ " AND F1_SERIE(+) = E2_PREFIXO "   
            cQueryn += CRLF+ " AND F1_DOC(+) = E2_NUM "        
            cQueryn += CRLF+ " AND F1_FORNECE(+) = E2_FORNECE " 
            cQueryn += CRLF+ " AND F1_LOJA(+) = E2_LOJA "
            cQueryn += CRLF+ "GROUP BY "

            If MV_PAR15 = 2
               cQueryn += CRLF+ " substr(F1_EMISSAO, 1,6), "
            EndIf

            cQueryn += CRLF+ " NVL(ZUO_GRUPO, 'NÃO Certificado') "
            //
         EndIF   
         
         If Alltrim(mv_par24) == "TRIBUTOS" .or. empty(Alltrim(mv_par24))
            cQueryn += CRLF+ " UNION ALL "
            cQueryn += CRLF+ "SELECT "

            If MV_PAR15 = 2
               cQueryn += CRLF+ " substr(e2_pllote, 1,6) Competencia, "
            EndIf

            cQueryn += CRLF+ " 'TRIBUTOS' TIT , SUM (ROUND(E2_VALOR , 2)) VALLIQ1, SUM ((E2_SALDO-E2_SDDECRE) + E2_SDACRES) SALDO
            cQueryn += CRLF+ "  FROM  " + RETSQLNAME("SE2") + " SE2, (SELECT DISTINCT EA_NUMBOR,  EA_DATABOR ,EA_MODELO
            cQueryn += CRLF+ "                     FROM " + RETSQLNAME("SEA") + " SEA
            cQueryn += CRLF+ "                    WHERE EA_FILIAL = '"+xFilial("SEA")+"' AND SEA.D_E_L_E_T_ = ' '
            cQueryn += CRLF+ "                      AND EA_DATABOR >= '" +dtos(dDtInc)+"' "
            cQueryn += CRLF+ "                      AND EA_DATABOR <= '" +dtos(dDtFim) +"' "
            cQueryn += CRLF+ "                      AND EA_CART = 'P' "
            If !empty (cProtador)
               cQueryn +=CRLF+ "and  EA_PORTADO = '"+cProtador+"'"
            EndIf
            If !empty (cTNãoSair)
               cQueryn += CRLF+ " AND EA_MODELO NOT IN "+FormatIn(cTNãoSair, ",")
            EndIF
            If !empty (cTSair)
               cQueryn += CRLF+ " AND EA_MODELO IN "+FormatIn(cTSair, ",")
            EndIF
            If !empty (cBNãoSair)
               cQueryn += CRLF+ " AND EA_NUMBOR NOT IN "+FormatIn(cBNãoSair, ",")
            EndIF
            If !empty (cBSair)
               cQueryn += CRLF+ " AND EA_NUMBOR IN "+FormatIn(cBSair, ",")
            EndIF
            cQueryn += CRLF+ "    AND EA_CART = 'P' ) SEA "
            cQueryn += CRLF+ " WHERE E2_FILIAL = '"+xFilial("SE2")+"' AND SE2.D_E_L_E_T_ = ' '
            cQueryn += CRLF+ "  AND E2_NUMBOR IN ( SEA.EA_NUMBOR )
            cQueryn += CRLF+ "  AND E2_TIPO IN ('TX' , 'INS','ISS', 'IRF', 'FGT')

            If MV_PAR15 = 2
               cQueryn += CRLF+ "  GROUP BY substr (e2_pllote, 1,6)
            EndIf
            
         EndIF
            
         cQueryn += CRLF+ " ORDER BY 2, 1, 3 "

         If Select("TMP4") > 0
            dbSelectArea("TMP4")
            dbclosearea()
         Endif

         memowrite("c:\temp\104B.sql",cQueryn)

         TCQuery cQueryn Alias "TMP4" New
         dbSelectArea("TMP4")
         tmp4->(dbGoTop())
         if tmp4->(!EOF())
            //-----------------------------------------------------------------------------------------
            //Validação para saber se foi ou não selecionado o parametro para mostrar lançamentos
            // 1 - Não  e 2 - Sim
            //-----------------------------------------------------------------------------------------
            IF MV_PAR15 = 1
               While tmp4->(!EOF())
                  If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
                     nLin  := Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
                  Endif
                  nLin++

                  if mv_par23 = 2

                     ntot3  := 0.00
                     ntot2  := 0.00
                     ntot1  := 0.00

                     ctit22 := alltrim(tmp4->Tit)

                     CCCBX3 := " "
                     CCCBX2 := " "
                     CCCBX1 := " "

                     for nI := 1 to len(atit3a)

                        if alltrim(atit3a[nI,i]) = ctit22

                           CCCBX3 := atit3a[nI,3] //cE2_BAIXA3
                           CCCBX2 := atit3a[nI,5] //cE2_BAIXA2
                           CCCBX1 := atit3a[nI,7] //cE2_BAIXA1

                           ntot3  := ntot3+atit3a[nI,2]
                           ntot2  := ntot2+atit3a[nI,4]
                           ntot1  := ntot1+atit3a[nI,6]

                        Endif

                     next

                     nLin++

                     if TMP4->Saldo > 0

                        @ nLin,000 PSAY tmp4->Tit
                        @ nLin,120 PSAY TMP4->Saldo   Picture "@E 999,999,999.99"

                     endif
                  Else

                     if TMP4->Saldo > 0

                        @ nLin,000 PSAY tmp4->Tit
                        @ nLin,060 PSAY TMP4->Saldo   Picture "@E 999,999,999.99"
                     
                     endif

                  endif
                  nTotSal  +=TMP4->Saldo
                  nTotVlr  +=TMP4->valliq1
                  Vlcomp   +=TMP4->Saldo

                  tmp4->(dbSkip())

               EndDo

               vltotger:=Vlcomp

            Else

               //-------------------------------------------------------------------
               //Processo de quebra por competência
               //Conforme solicitado pela Esther (Financeiro), nesse momento
               //é exibido tudo e depois detalhar por competência somente
               //o Pagamento Médico
               //-------------------------------------------------------------------

               
               //--------------------------------------------------------------------------
               //Mostrando o total antes de ir para a composição do pagamento médico e OPME
               //--------------------------------------------------------------------------
               nLin ++
               @ nLin,000 PSay replicate("_",080)
               nLin ++
               Vlcomp := 0.00
               /*
               ccomp := substr(cCompAnt,5,2)+'/'+substr(cCompAnt,1,4)
               @ nLin,025 PSAY "Total "
               @ nlin,059 psay " ---> "
               @ nLin,066 PSAY Vlcomp     Picture "@E 99,999,999.99"
               nLin++
               @ nLin,000 PSay replicate("_",080)
               Vlcomp := 0.00
               nLin ++
               nLin ++
               */

               dbSelectArea("TMP4")
               tmp4->(dbGoTop())
               _lPrima := .T.

               While tmp4->(!EOF())

                  If alltrim(tmp4->Tit) == "PGTO MEDICO"
                     If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
                        nLin  := Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
                     Endif
                     nLin++

                     If _lPrima .and. MV_PAR15 = 2
                        cCompAnt := (tmp4->Competencia)
                        _lPrima  := .F.

                     Endif

               IF MV_PAR15 = 2 .AND. (MV_PAR25 = 1 .OR. MV_PAR25 = 3) 
                     if mv_par23 = 2

                        ntot3  := 0.00
                        ntot2  := 0.00
                        ntot1  := 0.00

                        ctit22 := alltrim(tmp4->Tit)

                        CCCBX3 := " "
                        CCCBX2 := " "
                        CCCBX1 := " "

                        for nI := 1 to len(atit3a)

                           if alltrim(atit3a[nI,i]) = ctit22

                              CCCBX3 := atit3a[nI,3] //cE2_BAIXA3
                              CCCBX2 := atit3a[nI,5] //cE2_BAIXA2
                              CCCBX1 := atit3a[nI,7] //cE2_BAIXA1

                              ntot3  := ntot3+atit3a[nI,2]
                              ntot2  := ntot2+atit3a[nI,4]
                              ntot1  := ntot1+atit3a[nI,6]

                           Endif

                        next

                        nLin++

                        if TMP4->Saldo > 0

                           @ nLin,000 PSAY tmp4->Tit

                           //@ nLin,105 PSAY TMP4->valliq1 Picture "@E 999,999,999.99"
                           @ nLin,120 PSAY TMP4->Saldo   Picture "@E 999,999,999.99"

                        endif
                     Else

                        @ nLin,000 PSAY tmp4->Tit 

                        //@ nLin,040 PSAY TMP4->valliq1 Picture "@E 999,999,999.99"
                        @ nLin,060 PSAY TMP4->Saldo   Picture "@E 999,999,999.99"
                     endif

                     If cCompAnt != tmp4->Competencia
                        nLin ++
                        @ nLin,000 PSay replicate("_",080)
                        nLin ++
                        ccomp := substr((tmp4->Competencia),5,2)+'/'+substr((tmp4->Competencia),1,4)
                        @ nLin,025 PSAY "Total  Competencia"
                        @ nlin,052 psay ccomp
                        @ nlin,059 psay " ---> "
                        Vlcomp := (tmp4->Saldo)
                        @ nLin,066 PSAY Vlcomp     Picture "@E 99,999,999.99"
                        nLin++
                        @ nLin,000 PSay replicate("_",080)
                        nLin ++
                     Else
                        nLin ++
                        @ nLin,000 PSay replicate("_",080)
                        nLin ++
                        ccomp :=substr((tmp4->Competencia),5,2)+'/'+substr((tmp4->Competencia),1,4)
                        @ nLin,025 PSAY "Total  Competencia"
                        @ nlin,052 psay ccomp
                        @ nlin,059 psay " ---> "
                        Vlcomp := (tmp4->Saldo)
                        @ nLin,066 PSAY Vlcomp     Picture "@E 99,999,999.99"
                        nLin++
                        @ nLin,000 PSay replicate("_",080)
                        nLin ++
                     EndIf                    
                  ENDIF
                     //nTotSal  +=TMP4->Saldo  //Comentado Por Marcos para não somar os valores novamente
                     nTotVlr  +=TMP4->valliq1
                     //Vlcomp   +=TMP4->Saldo  //Comentado Por Marcos para não somar os valores novamente

                     tmp4->(dbSkip())

                  ElseIf alltrim(tmp4->Tit) == "OPME"
                     
                     If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
                        nLin  := Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
                     Endif
                     nLin++

                     If _lPrima .and. MV_PAR15 = 2
                        cCompAnt := (tmp4->Competencia)
                        _lPrima  := .F.

                     Endif

                  IF MV_PAR15 = 2 .AND. (MV_PAR25 = 1 .OR. MV_PAR25 = 2) 
                     if mv_par23 = 2

                        ntot3  := 0.00
                        ntot2  := 0.00
                        ntot1  := 0.00

                        ctit22 := alltrim(tmp4->Tit)

                        CCCBX3 := " "
                        CCCBX2 := " "
                        CCCBX1 := " "

                        for nI := 1 to len(atit3a)

                           if alltrim(atit3a[nI,i]) = ctit22

                              CCCBX3 := atit3a[nI,3] //cE2_BAIXA3
                              CCCBX2 := atit3a[nI,5] //cE2_BAIXA2
                              CCCBX1 := atit3a[nI,7] //cE2_BAIXA1

                              ntot3  := ntot3+atit3a[nI,2]
                              ntot2  := ntot2+atit3a[nI,4]
                              ntot1  := ntot1+atit3a[nI,6]

                           Endif

                        next

                        nLin++

                        if TMP4->Saldo > 0

                           @ nLin,000 PSAY tmp4->Tit            //Descomentado por Marcos para listar igual PGTO MEDICO quando o MV_PAR15 for igual a "SIM"

                           //@ nLin,105 PSAY TMP4->valliq1 Picture "@E 999,999,999.99"
                           @ nLin,120 PSAY TMP4->Saldo   Picture "@E 999,999,999.99" //Descomentado por Marcos para listar igual PGTO MEDICO quando o MV_PAR15 for igual a "SIM"

                        endif
                     Else

                       @ nLin,000 PSAY tmp4->Tit //Descomentado por Marcos para listar igual PGTO MEDICO quando o MV_PAR15 for igual a "SIM"

                        //@ nLin,040 PSAY TMP4->valliq1 Picture "@E 999,999,999.99"
                        @ nLin,060 PSAY TMP4->Saldo   Picture "@E 999,999,999.99"   //Descomentado por Marcos para listar igual PGTO MEDICO quando o MV_PAR15 for igual a "SIM"
                     endif
                     //descomentado por marcos para listar igual PGTO MEDICO quando o MV_PAR15 for igual a "SIM"
                     If cCompAnt != tmp4->Competencia
                        nLin ++
                        @ nLin,000 PSay replicate("_",080)
                        nLin ++
                        ccomp := substr((tmp4->Competencia),5,2)+'/'+substr((tmp4->Competencia),1,4)
                        @ nLin,025 PSAY "Total  Competencia"
                        @ nlin,052 psay ccomp
                        @ nlin,059 psay " ---> "
                        Vlcomp := (tmp4->Saldo)
                        @ nLin,066 PSAY Vlcomp     Picture "@E 99,999,999.99"
                        nLin++
                        @ nLin,000 PSay replicate("_",080)
                        nLin ++
                     Else
                        nLin ++
                        @ nLin,000 PSay replicate("_",080)
                        nLin ++
                        ccomp :=substr((tmp4->Competencia),5,2)+'/'+substr((tmp4->Competencia),1,4)
                        @ nLin,025 PSAY "Total  Competencia"
                        @ nlin,052 psay ccomp
                        @ nlin,059 psay " ---> "
                        Vlcomp := (tmp4->Saldo)
                        @ nLin,066 PSAY Vlcomp     Picture "@E 99,999,999.99"
                        nLin++
                        @ nLin,000 PSay replicate("_",080)
                        nLin ++
                     EndIf
                  ENDIF                    
                     //Descomentado por Marcos para listar igual PGTO MEDICO quando o MV_PAR15 for igual a "SIM"

                     //nTotSal  +=TMP4->Saldo
                     nTotVlr  +=TMP4->valliq1
                     //Vlcomp   +=TMP4->Saldo

                     tmp4->(dbSkip())
                  
                  Else

                     tmp4->(dbSkip())

                  EndIf

               EndDo

               vltotger:=Vlcomp

            EndIf

         EndIf

      next

      MV_PAR15 := _nBkp15

   EndIf

   if mv_par23 = 1
      nLin++
      @ nLin,000 PSay replicate("_",080)
      nLin++
      @ nLin,020 PSAY "Total Geral -----> "
     // @ nLin,040 PSAY nTotVlr   Picture "@E 999,999,999.99"
      @ nLin,060 PSAY ntotSal   Picture "@E 999,999,999.99"

      nLin++
      @ nLin,000 PSay replicate("_",080)

   else
      nLin++
      @ nLin,000 PSay replicate("_",140)
      nLin++
      @ nLin,078 PSAY "Total Geral -----> "
     // @ nLin,105 PSAY nTotVlr   Picture "@E 999,999,999.99"
      @ nLin,120 PSAY ntotSal   Picture "@E 999,999,999.99"

      nLin++
      @ nLin,000 PSay replicate("_",140)

   Endif

   vltotger:=0.00
   nLin++
   
   imposto := iif (mv_par17==1,.F.,.T.)
   
   //If imposto    //Comentado por Luiz Otavio 
      //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
      //³ Conferencia Pagamento Medico...                                     ³
      //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
      Titulo := " Visão Gerencial"
      //cabec1:= "Origem     Titulo           Fornecedor                                    Valor"
      cabec1:= "Origem   Pref  Titulo  Tipo Fornecedor                                    Valor"
      //           123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
      //                    1         2         3         4         5         6         7         8
      //           PLSMPAGMED.xxxxxxxxxxxxxxx.xxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx.999,999,999.99
      Cabec2:= ' '
      VlCompt :=0.00
      VlComp  :=0.00

      cQuery :="  select E2_ORIGEM , E2_PREFIXO ,e2_Num,  E2_TIPO , E2_EMISSAO , e2_fornece , e2_nomfor, SUM (ROUND(E2_VALOR , 2)) VALLIQ1, SUM (ROUND((E2_SALDO-e2_SDDECRE) + E2_SDACRES,2)) Saldo "
      cQuery +=" from "+RetSqlName("SE2")+" SE2,(select DISTINCT EA_NUMBOR,  EA_DATABOR ,EA_MODELO FROM "+RetSqlName("SEA")+" SEA "
      cQuery +=" WHERE EA_FILIAL = '"+xFilial("SEA")+"' AND sea.d_E_L_E_T_ = ' ' AND EA_DATABOR >= '" +dtos(dDtInc)+"' "
      cQuery +=" AND EA_DATABOR <= '"+dtos(dDtFim) +"' AND EA_CART = 'P' "
      If !empty (cProtador)
         cQuery +="and  EA_PORTADO = '"+cProtador+"'"
      EndIf
      If !empty (cTNãoSair)
         cQuery +=" AND EA_MODELO NOT IN "+FormatIn(cTNãoSair, ",")
      EndIF
      If !empty (cTSair)
         cQuery +=" AND EA_MODELO IN "+FormatIn(cTSair, ",")
      EndIF
      If !empty (cBNãoSair)
         cQuery +=" AND EA_NUMBOR NOT IN "+FormatIn(cBNãoSair, ",")
      EndIF
      If !empty (cBSair)
         cQuery +=" AND EA_NUMBOR IN "+FormatIn(cBSair, ",")
      EndIF
      cQuery +=" ) sea WHERE e2_filial =  '"+xFilial("SE2")+"' AND SE2.d_e_L_E_T_ = ' '  "
      
      If !imposto  //Inluido por Luiz Otavio em 08/11/2021
         cQuery +=" AND E2_TIPO NOT IN ('PIS', 'COF', 'CSL','ISS','TX', 'FGT','IRF','ISS','INS')"
      EndIf   

      cQuery +=" AND e2_numbor In ( sea.EA_NUMBOR ) "
      cQuery +=" AND NOT EXISTS ( SELECT ZUO_ORIGEM "
      cQuery +=" FROM  "+RetSqlName("ZUO")+" ZUO "
      cQuery +=" WHERE ZUO_FILIAL = '"+xFilial("ZUO")+"' AND ZUO.d_E_L_E_T_ = ' ' "
      cQuery +=" AND TRIM(E2_ORIGEM)  = TRIM(ZUO_ORIGEM)
      cQuery +=" AND TRIM(E2_PREFIXO) = TRIM(ZUO_PREF))
      cQuery +="  group by E2_ORIGEM , E2_PREFIXO ,e2_Num,  E2_TIPO , E2_EMISSAO , e2_fornece , e2_nomfor "

      lCritica := .F.
      //salta pagina forcado
      nLin  := Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)

      If Select("TMP4") > 0
         dbSelectArea("TMP4")
         dbclosearea()
      Endif
      TCQuery cQuery Alias "TMP4" New
      dbSelectArea("TMP4")
      tmp4->(dbGoTop())
      If tmp4->(!EOF())
         /*
         if nLin < 55
            nLin++
            @ nLin,000 PSAY cabec1
            nLin++
            @ nLin,000 PSay replicate("_",080)
         EndIf
         */
         
         lCritica := .T.
         While tmp4->(!EOF())
            If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
               nLin  := Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
            Endif

            If imposto

            Endif

            nLin++
            @ nLin,000 PSAY tmp4->E2_ORIGEM+" "+tmp4->E2_PREFIXO+" "+tmp4->e2_Num+" "+tmp4->E2_TIPO+" "+tmp4->e2_fornece+"-"+Substr(tmp4->e2_nomfor,1,30)
            if mv_par14 = 1
               @ nLin,065 PSAY TMP4->Saldo   Picture "@E 999,999,999.99"
            else
               @ nLin,065 PSAY TMP4->valliq1 Picture "@E 999,999,999.99"
            EndIf
            tmp4->(dbSkip())
         EndDo
      EndIF

      nLin++
      nLin++
      @ nLin,000 PSay replicate("_",080)
      nLin++
   
      If !lCritica
         @ nLin,000 PSAY "     ** Titulos Destes Bordero de Pagamento Foram Certificados ** "
      Else  
         @ nLin,000 PSAY "     ** Titulos Destes Bordero de Pagamento NÃO Certificados ** "
      EndIf
   
   //EndIf
   
   //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
   //³ Geração do demonstrativo gerencia......                             ³
   //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
   If nDetMed = 1
      //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
      //³ Competencia  - analitica         ......                             ³
      //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

      if mv_par23 = 1

         if mv_par21 =  1  // nao mostra origem
            cabec1:= "Grupo Pgto               Pref Natureza                  Valor Tit      Saldo Tit"
         else
            cabec1:= "Grupo Pgto       Origem  Pref Natureza                  Valor Tit      Saldo Tit"

         Endif

         if mv_par22 =  1  //nao mostra natureza
            cabec1:= "Grupo Pgto       Origem  Pref                           Valor Tit      Saldo Tit"
         else
            cabec1:= "Grupo Pgto       Origem  Pref Natureza                  Valor Tit      Saldo Tit"
         endif

         if mv_par21 =  1  .and. mv_par22 =  1  // nao mostra nada
            //cabec1:= "Grupo Pgto               Pref                           Valor Tit      Saldo Tit"
            cabec1:= "Grupo Pgto                                              Valor Tit      Saldo Tit"
         endif


         if mv_par21 =  2  .and. mv_par22 =  2   // Mostra tudo
            cabec1:= "Grupo Pgto       Origem  Pref Natureza                  Valor Tit      Saldo Tit"
         endif

      else
         cabec1:= "Grupo Pgto       Origem  Pref                      Ultimos Pagamentos  Total(Periodo)                       Valor Tit      Saldo Tit"

      Endif

      //           123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
      //                    1         2         3         4         5         6         7         8
      Cabec2:= ' '

      VlCompt :=0.00
      VlComp  :=0.00

      nTotSal      := 0.00
      nTotVlr      := 0.00

      cQuery := CRLF+ "SELECT NVL(ZUO_GRUPO, 'NÃO Certificado ') Tit ,"

      If mv_par21 = 2
         cQuery += CRLF+ "       e2_origem Origem ,"
      EndIf
      //cQuery += CRLF+ "       e2_prefixo pref , "

      If MV_PAR03 <> 1 .and. MV_PAR03 <> 3
         cQuery += CRLF+ "       trim(e2_naturez)||'-'||SUBSTR(ED_DESCRIC,1,13) Nat ,"
      EndIf

      cQuery += CRLF+ "       SUM (ROUND(E2_VALOR , 2)) VLR,"
      cQuery += CRLF+ "       SUM ((E2_SALDO-e2_SDDECRE) + E2_SDACRES) SALDO"
      cQuery += CRLF+ "  FROM "+RetSqlName("SE2")+" SE2 , "+RetSqlName("ZUO")+" ZUO, " +RetSqlName("SED")+" SED, "
      cQuery += CRLF+ "       (SELECT DISTINCT EA_NUMBOR,  EA_DATABOR ,EA_MODELO "
      cQuery += CRLF+ "          FROM "+RetSqlName("SEA")+" SEA "
      cQuery += CRLF+ "         WHERE EA_FILIAL = '"+xFilial("SEA")+"' AND sea.d_E_L_E_T_ = ' '
      cQuery += CRLF+ "           AND EA_DATABOR >= '" +dtos(dDtInc)+"' "
      cQuery += CRLF+ "           AND EA_DATABOR <= '"+dtos(dDtFim) +"' AND EA_CART = 'P' "
      If !empty (cProtador)
         cQuery +="and  EA_PORTADO = '"+cProtador+"'"
      EndIf
      If !empty (cTNãoSair)
         cQuery += CRLF+" AND EA_MODELO NOT IN "+FormatIn(trim(cTNãoSair), ",")
      EndIF
      If !empty (cTSair)
         cQuery += CRLF+" AND EA_MODELO IN "+FormatIn(trim(cTSair), ",")
      EndIF
      If !empty (cBNãoSair)
         cQuery += CRLF+" AND EA_NUMBOR NOT IN "+FormatIn(Trim(cBNãoSair), ",")
      EndIF
      If !empty (cBSair)
         cQuery += CRLF+" AND EA_NUMBOR IN "+FormatIn(cBSair, ",")
      EndIF
      cQuery += CRLF+ ") SEA "
      cQuery += CRLF+ "WHERE e2_filial = '"+xFilial("SE2")+"' AND se2.d_e_L_E_T_ = ' ' "
      cQuery += CRLF+ "  AND ED_filial = '"+xFilial("SED")+"' AND sed.d_e_L_E_T_ = ' ' "
      cQuery += CRLF+"   AND ZUO_FILIAL(+) = '"+xFilial("ZUO")+"' AND ZUO.d_E_L_E_T_(+) = ' ' "
      cQuery += CRLF+ "  AND e2_numbor In ( sea.EA_NUMBOR ) "
      cQuery += CRLF+ "  AND e2_origem = ZUO_ORIGEM(+) "
      cQuery += CRLF+ "  AND E2_PREFIXO = ZUO_PREF(+) "
      cQuery += CRLF+ "  AND E2_NATUREZ = ED_CODIGO "
      cQuery += CRLF+ "  AND E2_TIPO not IN ('TX' , 'INS','ISS', 'IRF', 'FGT') "

      If MV_PAR03 <> 1 .And. MV_PAR03 <> 3
         //cQuery += CRLF+ "GROUP BY NVL(ZUO_GRUPO, 'NÃO Certificado ') , e2_origem , e2_prefixo , trim(e2_naturez)||'-'||SUBSTR(ED_DESCRIC,1,13) "
         If mv_par21 = 2
            cQuery += CRLF+ "GROUP BY NVL(ZUO_GRUPO, 'NÃO Certificado ') , e2_origem , trim(e2_naturez)||'-'||SUBSTR(ED_DESCRIC,1,13) "
         Else
            cQuery += CRLF+ "GROUP BY NVL(ZUO_GRUPO, 'NÃO Certificado ') , trim(e2_naturez)||'-'||SUBSTR(ED_DESCRIC,1,13) "
         EndIf

      Else
         //cQuery += CRLF+ "GROUP BY NVL(ZUO_GRUPO, 'NÃO Certificado ') , e2_origem , e2_prefixo"

         If mv_par21 = 2
            cQuery += CRLF+ "GROUP BY NVL(ZUO_GRUPO, 'NÃO Certificado ') , e2_origem "
         Else
            cQuery += CRLF+ "GROUP BY NVL(ZUO_GRUPO, 'NÃO Certificado ') "
         EndIF
      EndIf

      cQuery += CRLF+ "  UNION ALL "

      cQuery += CRLF+ " SELECT 'TRIBUTOS' Tit ,"

      If mv_par21 = 2
         cQuery += CRLF+ "         e2_origem Origem ,"
      EndIf
      //cQuery += CRLF+ "         e2_prefixo pref , "

      If MV_PAR03 <> 1 .And. MV_PAR03 <> 3
         cQuery += CRLF+ "         trim(e2_naturez)||'-'||SUBSTR(ED_DESCRIC,1,13) Nat ,"
      EndIf

      cQuery += CRLF+ "         SUM (ROUND(E2_VALOR , 2)) VLR,"
      cQuery += CRLF+ "         SUM ((E2_SALDO-e2_SDDECRE)  + E2_SDACRES) SALDO"
      cQuery += CRLF+ "   FROM "+RetSqlName("SE2")+" SE2 ,"+RetSqlName("SED")+" SED ,"
      cQuery += CRLF+ "       (SELECT DISTINCT EA_NUMBOR,  EA_DATABOR ,EA_MODELO "
      cQuery += CRLF+ "          FROM "+RetSqlName("SEA")+" SEA  "
      cQuery += CRLF+ "         WHERE EA_FILIAL = '"+xFilial("SE2")+"' AND sea.d_E_L_E_T_ = ' ' "
      cQuery += CRLF+ "           AND EA_DATABOR >= '" +dtos(dDtInc)+"' "
      cQuery += CRLF+ "           AND EA_DATABOR <= '"+dtos(dDtFim) +"' AND EA_CART = 'P' "
      If !empty (cProtador)
         cQuery +="and  EA_PORTADO = '"+cProtador+"'"
      EndIf
      If !empty (cTNãoSair)
         cQuery += CRLF+" AND EA_MODELO NOT IN "+FormatIn(trim(cTNãoSair), ",")
      EndIF
      If !empty (cTSair)
         cQuery += CRLF+" AND EA_MODELO IN "+FormatIn(trim(cTSair), ",")
      EndIF
      If !empty (cBNãoSair)
         cQuery += CRLF+" AND EA_NUMBOR NOT IN "+FormatIn(Trim(cBNãoSair), ",")
      EndIF
      If !empty (cBSair)
         cQuery += CRLF+" AND EA_NUMBOR IN "+FormatIn(cBSair, ",")
      EndIF
      cQuery += CRLF+ ") SEA "
      cQuery += CRLF+ "WHERE e2_filial =  '"+xFilial("SE2")+"' AND se2.d_e_L_E_T_ = ' ' "
      cQuery += CRLF+ "  AND ED_filial =  '"+xFilial("SED")+"' AND sed.d_e_L_E_T_ = ' ' "
      cQuery += CRLF+ "  AND e2_numbor In ( sea.EA_NUMBOR ) "
      cQuery += CRLF+ "  AND e2_naturez = ed_codigo "
      cQuery += CRLF+ "  AND E2_TIPO IN ('TX' , 'INS','ISS', 'IRF', 'FGT') "

      If MV_PAR03 <> 1 .And. MV_PAR03 <> 3
         //cQuery += CRLF+ "  GROUP BY 'TRIBUTOS' , e2_origem , e2_prefixo  , trim(e2_naturez)||'-'||SUBSTR(ED_DESCRIC,1,13) "
         If mv_par21 = 2
            cQuery += CRLF+ "  GROUP BY 'TRIBUTOS' , e2_origem , trim(e2_naturez)||'-'||SUBSTR(ED_DESCRIC,1,13) "
         else
            cQuery += CRLF+ "  GROUP BY 'TRIBUTOS' , trim(e2_naturez)||'-'||SUBSTR(ED_DESCRIC,1,13) "
         endif
      Else
         //cQuery += CRLF+ "  GROUP BY 'TRIBUTOS' , e2_origem , e2_prefixo "
         If mv_par21 = 2
            cQuery += CRLF+ "  GROUP BY 'TRIBUTOS' , e2_origem "
         Else
            cQuery += CRLF+ "  GROUP BY 'TRIBUTOS' "
         endif
      EndIf

      If mv_par21 = 2
         cQuery += CRLF+ " order by 2,1,3,4 "
      Else
         cQuery += CRLF+ " order by 1 "
      EndIf

      If Select("TMP4") > 0
         dbSelectArea("TMP4")
         dbclosearea()
      Endif

      memowrit("c:\caberj\queryTMP4.sql",cQuery)

      TCQuery cQuery Alias "TMP4" New
      dbSelectArea("TMP4")
      tmp4->(dbGoTop())
      if tmp4->(!EOF())

         nLin  := Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)

         While tmp4->(!EOF())
            If nLin > 55  // Salto de Página. Neste caso o formulario tem 55 linhas...
               nLin  := Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
            Endif
            If nLin > 57
               nLin ++
               @ nLin,000 PSay replicate("_",080)
               nLin ++
               @ nLin,025 PSAY "Total Parcial "
               @ nlin,040 psay " ---> "
               @ nLin,052 PSAY nTotVlr  Picture "@E 999,999,999.99"
               @ nLin,067 PSAY nTotSal  Picture "@E 999,999,999.99"
               nLin ++
               @ nLin,000 PSay replicate("_",080)
            EndIf

            nLin++

            If mv_par21 = 2
               cE2ORIGEM  := TMP4->origem
            EndIF
            //cE2PREFIXO := TMP4->pref

            if mv_par23 = 1

               @ nLin,001 PSAY tmp4->Tit

               if mv_par21 = 2
                  @ nLin,017 PSAY TMP4->origem
               else
                  @ nLin,017 PSAY " "
               endif

               //@ nLin,025 PSAY TMP4->pref

               if mv_par22 = 2
                  @ nLin,030 PSAY TMP4->nat
               else
                  @ nLin,030 PSAY " "
               endif

               @ nLin,051 PSAY TMP4->vlr   Picture "@E 999,999,999.99"
               @ nLin,066 PSAY TMP4->saldo Picture "@E 999,999,999.99"

            else

               cSqt4 := " SELECT SUBSTR(E2_BAIXA,1,6) DTBAIXA ,SUM(E2_VALOR) VALOR "
               cSqt4 += "	 FROM "+RETSQLNAME("SE2")+" "
               cSqt4 += "	 WHERE D_E_L_E_T_<>'*'     "
               cSqt4 += "	 AND E2_FILIAL  = '"+xFilial("SE2")+"' "
               cSqt4 += "	 AND E2_ORIGEM = '"+cE2ORIGEM+"' "
               //cSqt4 += "	 AND E2_PREFIXO   = '"+cE2PREFIXO+"' "
               cSqt4 += " AND E2_BAIXA <> ' '     "
               cSqt4 += "	GROUP BY SUBSTR(E2_BAIXA,1,6)     "
               cSqt4 += "	ORDER BY SUBSTR(E2_BAIXA,1,6) DESC "

               memowrit("c:\temp\titanttmp4.sql",cSqt4)
               If ( Select("Q44") > 0 )
                  Q44->( dbCloseArea() )
               EndIf
               TcQuery cSqt4 Alias "Q44" New

               if !eof()
                  cE2_VENCREA    := space(8)
                  cE2_BAIXA      := space(8)
                  nE2_VALOR      := 0.00
                  ctit           := " "
                  X              := 1

                  cE2_BAIXA1     := space(8)
                  nE2_VALOR1     := 0.00

                  cE2_BAIXA2     := space(8)
                  nE2_VALOR2     := 0.00

                  cE2_BAIXA3     := space(8)
                  nE2_VALOR3     := 0.00

                  nE2tVALOR1     := 0.00
                  nE2tVALOR2     := 0.00
                  nE2tVALOR3     := 0.00

                  Do While !eof() .and. x < 4

                     if x = 1
                        cE2_BAIXA1   := substr    (Q44->DTBAIXA,5,2)+"/"+ substr(Q44->DTBAIXA,1,4)
                        nE2_VALOR1   := Transform (Q44->VALOR,"@e 9,999,999.99")
                        nE2tVALOR1   := Q44->VALOR
                     Endif

                     if x = 2
                        cE2_BAIXA2   := substr    (Q44->DTBAIXA,5,2)+"/"+ substr(Q44->DTBAIXA,1,4)
                        nE2_VALOR2   := Transform (Q44->VALOR,"@e 9,999,999.99")
                        nE2tVALOR2   := Q44->VALOR
                     Endif

                     if x = 3
                        cE2_BAIXA3   := substr    (Q44->DTBAIXA,5,2)+"/"+ substr(Q44->DTBAIXA,1,4)
                        nE2_VALOR3   := Transform (Q44->VALOR,"@e 9,999,999.99")
                        nE2tVALOR3   := Q44->VALOR
                     Endif

                     DBSELECTAREA("Q44")
                     x := x + 1

                     DBSKIP()
                  Enddo

                  Q44->( dbCloseArea() )

                  @ nLin,001 PSAY tmp4->Tit

                  if mv_par21 = 2

                     @ nLin,017 PSAY TMP4->origem

                  endif

                  //      @ nLin,025 PSAY TMP4->pref
                  @ nLin,105 PSAY TMP4->vlr   Picture "@E 9,999,999.99"
                  @ nLin,120 PSAY TMP4->saldo Picture "@E 9,999,999.99"

                  aadd (atit3a,{tmp4->Tit,nE2tVALOR3,cE2_BAIXA3,nE2tVALOR2,cE2_BAIXA2,nE2tVALOR1,cE2_BAIXA1})

               else

                  @ nLin,001 PSAY tmp4->Tit

                  @ nLin,105 PSAY TMP4->vlr   Picture "@E 9,999,999.99"
                  @ nLin,120 PSAY TMP4->saldo Picture "@E 9,999,999.99"

               endif

            endif
            nTotSal  +=TMP4->Saldo
            nTotVlr  +=TMP4->vlr

            tmp4->(dbSkip())
         EndDo

         nLin ++
         
         if mv_par23 = 2
            nLin ++
            @ nLin,000 PSay replicate("_",140)
            nLin ++
            @ nLin,078 PSAY "Total Geral  ---> "
            @ nLin,103 PSAY nTotVlr  Picture "@E 999,999,999.99"
            @ nLin,118 PSAY nTotSal  Picture "@E 999,999,999.99"
            nLin ++
            @ nLin,000 PSay replicate("_",140)

         else
            nLin ++
            @ nLin,000 PSay replicate("_",080)
            nLin ++

            @ nLin,025 PSAY "Total Geral "
            @ nlin,040 psay " ---> "

            @ nLin,051 PSAY nTotVlr  Picture "@E 999,999,999.99"
            @ nLin,066 PSAY nTotSal  Picture "@E 999,999,999.99"
            nLin ++
            @ nLin,000 PSay replicate("_",080)

         endif

         vltotger+=Vlcomp
         Vlcompt := 0.00
         Vlcomp  := 0.00
         nLin ++
         nTotSal := 0.00
         nTotVlr := 0.00

      EndIf
   EndIF

   if mv_par20 = 2
      DlgToExcel({{"ARRAY","Compossição dos Titulos " ,aCabec1,aSaidCom}})
   EndIf

   //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
   //³ Finaliza a execucao do relatorio...                                 ³
   //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

   SET DEVICE TO SCREEN

   //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
   //³ Se impressao em disco, chama o gerenciador de impressao...          ³
   //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

   If aReturn[5]==1
      dbCommitAll()
      SET PRINTER TO
      OurSpool(wnrel)
   Endif

   MS_FLUSH()

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ValidPerg º Autor ³ Jose Carlos Noronhaº Data ³ 01/08/07    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Parametros para selecao dos titulos do PLS                 º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³                                                            º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function ValidPerg()

   Local aAreaAtu := GetArea()
   Local aRegs    := {}
   Local i,j      := 0

   DbSelectArea("SX1")
   dbSetOrder(1)

   cPerg := PADR(cPerg,10)

   aAdd(aRegs,{cPerg,"01","Data De             ?","","","mv_ch01","D",08,0,0,"G","","mv_par01",""        ,"","","","",""         ,"","","","","","","","","","","","","","","","","","","US2","" })
   aAdd(aRegs,{cPerg,"02","Data Ate            ?","","","mv_ch02","D",08,0,0,"G","","mv_par02",""        ,"","","","",""         ,"","","","","","","","","","","","","","","","","","","US2","" })
   aAdd(aRegs,{cPerg,"03","Mostra Composição   ?","","","mv_ch03","N",01,0,0,"c","","mv_par03","Não Mostra" ,"","","","","Titulos","","","","","Bordero","","","","","Ambos","","","","","","","","","",""})
   aAdd(aRegs,{cPerg,"04","Tipo há  Não Sair    ","","","mv_ch04","C",60,0,0,"G","","mv_par04",""        ,"","","","",""         ,"","","","","","","","","","","","","","","","","","","",""})
   aAdd(aRegs,{cPerg,"05","Listar Bordero      ?","","","mv_ch05","N",01,0,0,"c","","mv_par05","Sim"     ,"","","","","Não"      ,"","","","","","","","","","","","","","","","","","","",""})
   aAdd(aRegs,{cPerg,"06","Sub-total           ?","","","mv_ch06","N",01,0,0,"c","","mv_par06","Sim"     ,"","","","","Não"      ,"","","","","","","","","","","","","","","","","","","",""})
   aAdd(aRegs,{cPerg,"07","Listar Cheques      ?","","","mv_ch07","N",01,0,0,"c","","mv_par07","Sim"     ,"","","","","Não"      ,"","","","","","","","","","","","","","","","","","","",""})
   aAdd(aRegs,{cPerg,"08","Bordero há Não Sair  ","","","mv_ch08","C",60,0,0,"G","","mv_par08",""        ,"","","","",""         ,"","","","","","","","","","","","","","","","","","","",""})
   aAdd(aRegs,{cPerg,"09","Bordero há  Sair     ","","","mv_ch09","C",60,0,0,"G","","mv_par09",""        ,"","","","",""         ,"","","","","","","","","","","","","","","","","","","",""})
   aAdd(aRegs,{cPerg,"10","Tipo há Sair         ","","","mv_ch10","C",60,0,0,"G","","mv_par10",""        ,"","","","",""         ,"","","","","","","","","","","","","","","","","","","",""})
   aAdd(aRegs,{cPerg,"11","Do Banco             ","","","mv_ch11","C",05,0,0,"G","","mv_par11",""        ,"","","","",""         ,"","","","","","","","","","","","","","","","","","","",""})
   aAdd(aRegs,{cPerg,"12","Resumo Gerencial    ?","","","mv_ch12","N",01,0,0,"c","","mv_par12","Sim"     ,"","","","","Não"      ,"","","","","","","","","","","","","","","","","","","",""})
   aAdd(aRegs,{cPerg,"13","Detalha Lançamentos ?","","","mv_ch13","N",01,0,0,"c","","mv_par13","Sim"     ,"","","","","Não"      ,"","","","","","","","","","","","","","","","","","","",""})
   aAdd(aRegs,{cPerg,"14","Bordero Já Baixado  ?","","","mv_ch14","N",01,0,0,"c","","mv_par14","Não"     ,"","","","","Sim"      ,"","","","","","","","","","","","","","","","","","","","" , "" , "", "", "" })
   aAdd(aRegs,{cPerg,"15","Lanç.Por Competencia?","","","mv_ch15","N",01,0,0,"c","","mv_par15","Não"     ,"","","","","Sim"      ,"","","","","","","","","","","","","","","","","","","",""})
   aAdd(aRegs,{cPerg,"16","Most. Valores Compet?","","","mv_ch16","N",01,0,0,"c","","mv_par16","Não"     ,"","","","","Sim"      ,"","","","","","","","","","","","","","","","","","","",""})
   aAdd(aRegs,{cPerg,"17","Mostrar impostos    ?","","","mv_ch17","N",01,0,0,"c","","mv_par17","Não"     ,"","","","","Sim"      ,"","","","","","","","","","","","","","","","","","","",""})
   aAdd(aRegs,{cPerg,"18","Mostrar Deb/cred    ?","","","mv_ch18","N",01,0,0,"c","","mv_par18","Não"     ,"","","","","Sim"      ,"","","","","","","","","","","","","","","","","","","",""})
   aAdd(aRegs,{cPerg,"19","Mostrar Resumo      ?","","","mv_ch19","N",01,0,0,"c","","mv_par19","Não"     ,"","","","","Sim"      ,"","","","","","","","","","","","","","","","","","","",""})
   aAdd(aRegs,{cPerg,"20","Gerar excel         ?","","","mv_ch20","N",01,0,0,"c","","mv_par20","Não"     ,"","","","","Sim"      ,"","","","","","","","","","","","","","","","","","","",""})

   For i:=1 to Len(aRegs)
      If !dbSeek(cPerg+aRegs[i,2])
         RecLock("SX1",.T.)
         For j:=1 to FCount()
            If j <= Len(aRegs[i])
               FieldPut(j,aRegs[i,j])
            Endif
         Next
         MsUnlock()
      Endif
   Next

   RestArea( aAreaAtu )

Return()
