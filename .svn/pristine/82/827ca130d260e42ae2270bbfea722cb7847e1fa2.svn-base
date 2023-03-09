#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"

/*/                                                                                      
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออออหออออออัอออออออออออปฑฑ
ฑฑบPrograma  ณCABR189   บ Autor ณAltamiro              บ Data ณ 01/10/12  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออออสออออออฯอออออออออออนฑฑ
ฑฑบDescricao ณ Rotina para CONFERENCIA da METLIFE  contra a CABERJ       บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/                  
User Function CABR189B

Local cMsg           := ""

Private cDpj         := 'Nใo'
Private cImp         := 'Nใo'
Private oLeTxt
Private lAbortPrint  := .F.
Private cPerg        := "CABR189b"
Private cTitulo      := "Conferencia e criticas MetLife/Prima Vida"
Private lpvez        := .T.
Private cTpCrit      := " "
Private lImporta     := .F.
Private f_ok         := .F.
Private nLocaliz     := 0           // 1 - zzq -- 2 se2 -- 0 nao localizado
Private cEmpresa     := iif(cempant == '01', 'Caberj', 'Integral')
Private cpgto        := ' '
Private lFaturado    := .T.
Private ind          := 1
Private cTitCSald    := ' '
Private nVlrTitPri   := 0.00
Private nVlrTitcmp   := 0.00
Private cNomeArq1    := ' '

Private aDadosOk     := {}
Private aDadosSCabj  := {}
Private aDadosSlife  := {}
Private aDadoslife   := {}
Private aDadosCabj   := {}
Private aDadosCab1   := {}
Private aDadosCMF    := {}
Private aDadosECMF   := {}
Private aDadosECCB   := {}
Private aDadosCMF1   := {}

Private I            := 1
Private X            := 1

SetPrvt("oDlg1","oGrp1","oSay1","oSBtn1","oSBtn2","oSBtn3")

cMsg += " Este programa ira fazer a leitura do arquivo CSV relativo as"    + CRLF
cMsg += " matriculas odontologicas cobradas pela PRIMA VIDA/MET LIFE e"    + CRLF
cMsg += " cruza-las com o cadastro da CABERJ/INTEGRAL"                     + CRLF

oDlg1       := MSDialog():New( 095,232,368,705,"Leitura de Arquivo CVS",,,.F.,,,,,,.T.,,,.T. )

   oGrp1    := TGroup():New(  008,012,100,224,"Arquivo CVS",oDlg1,CLR_BLACK,CLR_WHITE,.T.,.F. )
   oSay1    := TSay():New(    020,020,{||cMsg},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,196,076)
   oSBtn1   := SButton():New( 112,140,05,{||AjustaSX1(cPerg)},       oDlg1,,"", )
   oSBtn2   := SButton():New( 112,168,01,{||OkLeTxt(),oDlg1:End()},  oDlg1,,"", )
   oSBtn3   := SButton():New( 112,196,02,{||oDlg1:End()},            oDlg1,,"", )

oDlg1:Activate(,,,.T.)

return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuno    ณ OKLETXT  บ Autor ณ                    บ Data ณ  09/04/03   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescrio ณ Funcao chamada pelo botao OK na tela inicial de processamenบฑฑ
ฑฑบ          ณ to. Executa a leitura do arquivo texto.                    บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Programa principal                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/                                                                                                                                      
Static Function OkLeTxt

Private cNomeArq     := ""
Private cMesAdi      := ""
Private cAnoAdi      := ""
Private cCritica     := " "
Private cCritImp     := " "

Private nPos         := 0
Private lfaz         := .F.
Private cUsua        := SubStr(cUSUARIO,7,15)
Private cRdaEmp      := 1

cNomeArq    := mv_par01
cCompMes    := SubStr(mv_par02, 1, 2)
cCompAno    := SubStr(mv_par02, 4, 4)
dDtInic     := cCompAno+cCompMes+'01'
dDtBloq     := cCompAno+cCompMes+'01'
nEfetConv   := mv_par03
nImport     := mv_par04
cTpTab      := iif(mv_par05 == 1, 'Pre', iif(mv_par05 == 2, 'Fat', 'Cad'))
cRdaEmp     := iif(mv_par06 == 1, '145246', '143260')

if !File(cNomeArq)
   MsgStop("Arquivo Invแlido! Programa encerrado.")
   Close(oLeTxt)
   return
endif

if cCompMes < '01' .or. cCompMes > '12'
   MsgAlert("M๊s da compet๊ncia invแlido!", "Atencao!")
   return
elseif cCompAno < '2018' .or.  cCompAno > '2099'
   MsgAlert("Ano da compet๊ncia invแlido!", "Atencao!")
   return
endif

Processa({|| Processa1()}, cTitulo, "", .T.)

MsgInfo("Processo finalizado")

return


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuno    ณ PROCESSA1บ Autor ณ Jean Schulz        บ Data ณ  11/11/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescrio ณ Funcao auxiliar chamada pela PROCESSA.  A funcao PROCESSA  บฑฑ
ฑฑบ          ณ monta a janela com a regua de processamento.               บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Programa principal                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static Function Processa1()

Local cQuery   := ""
Local nCont    := 0
Local ind      := 0

cQuery := " SELECT count(*) qtd"
cQuery += " FROM " + RetSqlName("PD1") + " PD1"
cQuery += " WHERE PD1.D_E_L_E_T_ = ' '"
cQuery +=   " AND PD1_FILIAL = '" +    xFilial("PD1")   + "'"
cQuery +=   " AND PD1_COMPTE = '" + cCompAno + cCompMes + "'"
cQuery +=   " AND PD1_STATUS = '" +       cTpTab        + "'"
cQuery +=   " AND PD1_CODRDA = '" +      cRdaEmp        + "'"

if Select(("TMP1")) <> 0
   ("TMP1")->(DbCloseArea())
endif

TCQuery cQuery Alias "TMP1" New

TMP1->(dbGoTop())

if TMP1->qtd > 0

   if mv_par05 == 1        // 'Pre'

      if nImport == 1

         if MsgYesNo("Arquivo de Pre-faturamento jแ importado." + CRLF + CRLF + "Deseja refazer a carga / confer๊ncia?")
            fLimpPD1()
            f_ok  := .T.
         else
            f_ok  := .F.
         endif
      
      else
         f_ok  := .F.
      endif
   
   elseif mv_par05 == 2    // 'Fat'

      if nImport == 1

         MsgAlert("Arquivo de confer๊ncia de faturamento jแ importado.", "Atencao!")

         if fVerfBgq()

            if lFaturado == .F.

               if MsgYesNo("Pagamento nใo processado. Deseja refazer a carga / confer๊ncia?")

                  flimpbgq()
                  fLimpPD1()
                  f_ok  := .T.
               
               else
                  f_ok  := .F.
               endif

            else
               MsgAlert("Faturamento jแ pago. Nใo serแ reporcessado!", "Atencao!")
               f_ok  := .F.
            endif

         else

            if MsgYesNo("Pagamento nใo processado. Deseja refazer a carga / confer๊ncia?")

               fLimpPD1()
               f_ok  := .T.
            
            endif

         endif

      else
         f_ok  := .F.
      endif

   elseif mv_par05 == 3       // 'Cad'

      if nImport == 1

         MsgAlert("Arquivo de confer๊ncia do cadastro jแ importado.", "Atencao!")

         if MsgYesNo("Deseja Refazer a carga / confer๊ncia?")

            fLimpPD1()
            f_ok  := .T.
         
         else
            f_ok  := .F.
         endif

      else
         f_ok  := .F.
      endif

   endif

else
   f_ok  := .T.
endif

if mv_par04 == 1 .and. f_ok == .T.

   if !File(cNomeArq)
      MsgAlert("Arquivo texto: CLIENTE.TXT nใo localizado", "Atencao!")
      return
   endif

   FT_FUSE(cNomeArq)
   FT_FGOTOP()

   ProcRegua(FT_FLASTREC())

   nCont := 0

   while !FT_FEOF()

      IncProc('Processando...')
      
      cBuffer  := FT_FREADLN()
      aDados   := separa(cBuffer,';',.T.)

      if SubStr(adados[01],1,7) <> 'CODIGO_' .and. SubStr(adados[01],1,7) <> 'COLIGAD'
         FGrvPD1(aDados)
      endif

      FT_FSKIP()
   
   end

endif

for ind := 1 to 3

   cQuery := " SELECT  NVL(TABC.CODEMP , ' ')                    TABCCODEMP,"
   cQuery +=         " NVL(TABC.MATRIC , ' ')                    TABCMATRIC,"
   cQuery +=         " NVL(TABC.TIPREG , ' ')                    TABCTIPREG,"
   cQuery +=         " NVL(TABC.NOMUSR , ' ')                    TABCNOMUSR,"
   cQuery +=         " NVL(TABC.DATINC , ' ')                    TABCDATINC,"
   cQuery +=         " NVL(TABC.DATBLO , ' ')                    TABCDATBLO,"
   cQuery +=         " NVL(TABC.CODPLA , ' ')                    TABCCODPLA,"
   cQuery +=         " NVL(LPAD(TRIM(TABC.YMTODO),14,'0') , ' ') TABCYMTODO,"
   cQuery +=         " NVL(TABC.VLRML  , 0  )                    TABCVLRML,"
   cQuery +=         " NVL(TABC.CODDC  , ' ')                    TABCCODDC,"
   cQuery +=         " NVL(TABC.DESCPL , ' ')                    TABCDESCPL,"
   cQuery +=         " NVL(TABC.INCVIG , ' ')                    TABCINCVIG,"
   cQuery +=         " NVL(TABC.FIMVIG , ' ')                    TABCFIMVIG,"
   cQuery +=         " NVL(LPAD(TRIM(TABM.MATODO),14,'0') , ' ') TABMMATODO,"
   cQuery +=         " NVL(TABM.NOMUSR , ' ')                    TABMNOMUSR,"
   cQuery +=         " NVL(TABM.DESCPL , ' ')                    TABMDESCPL,"
   cQuery +=         " NVL(TABM.TPUSUA , ' ')                    TABMTPUSUA,"
   cQuery +=         " NVL(TABM.VALOR  , 0  )                    TABMVALOR,"
   cQuery +=         " NVL(TABM.CONF   , ' ')                    TABMCONF,"
   cQuery +=         " NVL(TABM.MATCAB , ' ')                    TABMMATCAB,"
   cQuery +=         " NVL(TABM.VLCAB  , 0  )                    TABMVLCAB,"
   cQuery +=         " NVL(TABM.CRITIC , ' ')                    TABMCRITIC,"
   cQuery +=         " NVL(TABM.RECPD1 , 0  )                    TABMRECPD1,"
   cQuery +=         " NVL(TABM.DESC_CRITIC , ' ')               TABMDESCRI"
   cQuery += " FROM (SELECT  BA1_CODEMP CODEMP,"
   cQuery +=               " BA1_MATRIC MATRIC,"
   cQuery +=               " BA1_TIPREG TIPREG,"
   cQuery +=               " BA1_NOMUSR NOMUSR,"
   cQuery +=               " BA1_DATINC DATINC,"
   cQuery +=               " BA1_DATBLO DATBLO,"
   cQuery +=               " BA1_CODPLA CODPLA,"
   cQuery +=               " BA1_YMTODO YMTODO,"
   cQuery +=               " PAU_DESCML DESCPL,"
   cQuery +=               " PAU_VLRML VLRML,"
   cQuery +=               " PAU_CODDC CODDC,"
   cQuery +=               " PAU_INCVIG INCVIG,"
   cQuery +=               " PAU_FIMVIG FIMVIG"
   cQuery +=       " FROM " + RetSqlName("BA1") + " BA1"
   cQuery +=         " INNER JOIN " + RetSqlName("PAU") + " PAU"
   cQuery +=           " ON (    PAU_FILIAL = '" + xFilial("PAU") + "'"
   cQuery +=               " AND PAU_CODEMP = BA1_CODEMP"
   cQuery +=               " AND PAU_CONTRA = BA1_CONEMP"
   cQuery +=               " AND PAU_SUBCON = BA1_SUBCON"
   cQuery +=               " AND PAU_CODPLA = BA1_CODPLA)"
   cQuery +=       " WHERE BA1.D_E_L_E_T_ = ' ' AND PAU.D_E_L_E_T_ = ' '"
   cQuery +=         " AND BA1_FILIAL = '" + xFilial("BA1") + "'"
   cQuery +=         " AND BA1_YMTODO <> ' '"
   cQuery +=         " AND SUBSTR(BA1_DATINC,1,6)  <= '" + SubStr(dDtInic,1,6) + "'"
   cQuery +=         " AND (SUBSTR(BA1_DATBLO,1,6) >= '" + SubStr(dDtBloq,1,6) + "' OR BA1_MOTBLO = ' ')"
   cQuery +=         " AND SUBSTR(PAU_INCVIG,1,6)  <= '" + SubStr(dDtInic,1,6) + "'"
   cQuery +=         " AND (SUBSTR(PAU_FIMVIG,1,6) >= '" + SubStr(dDtBloq,1,6) + "' OR PAU_FIMVIG = ' ')"
   cQuery +=         " AND PAU_CODRDA = '" + cRdaEmp + "') TABC,"
   cQuery +=       "(SELECT  PD1_MATODO     MATODO,"
   cQuery +=               " PD1_NOMUSR     NOMUSR,"
   cQuery +=               " PD1_DESCPL     DESCPL,"
   cQuery +=               " PD1_TPUSUA     TPUSUA,"
   cQuery +=               " PD1_VALOR      VALOR,"
   cQuery +=               " PD1_CONF       CONF,"
   cQuery +=               " PD1_MATCAB     MATCAB,"
   cQuery +=               " PD1_VLCAB      VLCAB,"
   cQuery +=               " PD1_CRITIC     CRITIC,"
   cQuery +=               " PD1.R_E_C_N_O_ RECPD1,"
   cQuery +=               " PD1_DESCRI DESC_CRITIC"
   cQuery +=       " FROM " + RetSqlName("PD1") + " PD1"
   cQuery +=       " WHERE PD1.D_E_L_E_T_ = ' '"
   cQuery +=         " AND PD1_FILIAL = '" +    xFilial("PD1")   + "'"
   cQuery +=         " AND PD1_COMPTE = '" + cCompAno + cCompMes + "'"
   cQuery +=         " AND PD1_STATUS = '" +        cTpTab       + "'"
   cQuery +=         " AND PD1_CODRDA = '" +       cRdaEmp       + "') TABM"

   if ind == 1

      cQuery += " WHERE LPAD(TRIM(TABC.YMTODO), 14, '0') = LPAD(TRIM(TABM.MATODO), 14, '0')"
      cQuery += " ORDER BY TABM.MATODO"
   
   elseif ind == 2

      cQuery += " WHERE LPAD(TRIM(TABC.YMTODO(+)), 14, '0') = LPAD(TRIM(TABM.MATODO), 14, '0') AND TRIM(TABC.YMTODO) IS NULL"
      cQuery += " ORDER BY TABM.MATODO"
   
   elseif ind == 3

      cQuery += " WHERE LPAD(TRIM(TABC.YMTODO), 14, '0') = LPAD(TRIM(TABM.MATODO(+)), 14, '0') AND TRIM(TABC.YMTODO) IS NULL"
      cQuery += " ORDER BY TABC.YMTODO"
   
   endif

   if Select(("TMP")) <> 0
      ("TMP")->(DbCloseArea())
   endif

   TCQuery cQuery Alias "TMP" New

   dbSelectArea("TMP")
   TMP->(dbGoTop())

   if ind == 1

      while !(TMP->(Eof()))

         if ((TMP->TABCDatblo <> ' ' .and. SubStr(StrZero(val(TMP->TABMMATCAB),17),1,14) == '0001' + trim(TMP->TABCCodemp) + trim(TMP->TABCMatric)) .or. trim(TMP->TABCDatblo) == '')

            aAdd(aDadosCabj, {TMP->TABCCodemp      ,;
                              TMP->TABCMatric      ,;
                              TMP->TABCTipreg      ,;
                              TMP->TABCNomusr      ,;
                              TMP->TABCDatinc      ,;
                              TMP->TABCDatblo      ,;
                              TMP->TABCCodpla      ,;
                              TMP->TABCYmtodo      ,;
                              TMP->TABCVlrml       ,;
                              TMP->TABCCoddc       ,;
                              TMP->TABMMATODO      ,;
                              TMP->TABMDESCPL      ,;
                              TMP->TABMTPUSUA      ,;
                              TMP->TABMVALOR       ,;
                              TMP->TABMCONF        ,;
                              TMP->TABMMATCAB      ,;
                              TMP->TABMVLCAB       ,;
                              TMP->TABMDESCRI      })
            
            if mv_par03 == 1

               PD1->(dbGoTo(TMP->TABMRECPD1))

               if !EMPTY(TMP->TABCYMTODO)

                  RecLock("PD1",.F.)

                     if substr(TMP->TABCDescpl,1,20) != trim(TMP->TABMDESCPL)    // plano diferente

                        PD1->PD1_CONF     := 'CP'
                        PD1->PD1_CRITIC   := 'Plano Diferente'
                        PD1->PD1_DESCRI   := 'C->' + substr(TMP->TABCDescpl,1,20) + ' - M->' + trim(TMP->TABMDESCPL)
                     
                     endif
                     
                     if ((TMP->TABCDatblo < dDtBloq) .and. (TMP->TABCDatblo <> ' ') .and. SubStr(StrZero(val(TMP->TABMMATCAB),17),1,14) == '0001'+trim(TMP->TABCCodemp) + trim(TMP->TABCMatric) )  // bloqueio antrerior

                        PD1->PD1_CONF     := 'CB'
                        PD1->PD1_CRITIC   := 'Usu. bloq. em ' + substr(TMP->TABCDatblo,7,2)+'/'+substr(TMP->TABCDatblo,5,2)+'/'+substr(TMP->TABCDatblo,1,4)
                        PD1->PD1_DESCRI   := 'C->' + SUBSTR(TMP->TABCDatblo,1,10) +' Param->' + dDtBloq
                     
                     endif

                     if EMPTY(TMP->TABMMATCAB)

                        PD1->PD1_CONF     := 'CM'
                        PD1->PD1_CRITIC   := 'Matricula Caberj na MetLife em branco'
                        PD1->PD1_DESCRI   := 'M->' + TMP->TABMMATCAB
                     
                     endif

                     if substr(StrZero(val(TMP->TABMMATCAB),17),1,14) != '0001'+trim(TMP->TABCCodemp) + trim(TMP->TABCMatric) .and. PD1->PD1_CONF != 'CM'
                     
                        PD1->PD1_CONF     := 'CD'
                        PD1->PD1_CRITIC   := 'Matricula Caberj diferente da MetLife'
                        PD1->PD1_DESCRI   := 'C->' + '0001'+trim(TMP->TABCCodemp) + trim(TMP->TABCMatric) + ' - M->' + substr(TMP->TABMMATCAB,1,14)
                     
                     endif

                     if TMP->TABCVlrml < TMP->TABMVALOR

                        PD1->PD1_CONF     := 'V+'
                        PD1->PD1_CRITIC   := 'Valor da MetLife Maior que o Contratado'
                        PD1->PD1_DESCRI   := 'C->' + Transform(TMP->TABCVlrml,'@E 999,999,999.99') + ' - M->' + Transform(TMP->TABMVALOR,'@E  999,999,999.99')
                     
                     endif

                     if TMP->TABCVlrml > TMP->TABMVALOR

                        PD1->PD1_CONF     := 'V-'
                        PD1->PD1_CRITIC   := 'Valor da MetLife Menor que o Contratado'
                        PD1->PD1_DESCRI   := 'C->' + Transform(TMP->TABCVlrml,'@E  999,999,999.99') + ' - M->' + Transform(TMP->TABMVALOR,'@E  999,999,999.99')

                     endif

                     if TMP->TABCDATINC < TMP->TABCINCVIG

                        if SubStr(TMP->TABCINCVIG,1,6) > (cCompAno + cCompMes) .or. SubStr(TMP->TABCDATINC,1,6) > (cCompAno + cCompMes)

                           PD1->PD1_CONF     := 'CI'
                           PD1->PD1_CRITIC   := 'Usuario Incluido em ' + substr(TMP->TABCDatinc,7,2)+'/'+substr(TMP->TABCDatinc,5,2)+'/'+substr(TMP->TABCDatinc,1,4)
                           PD1->PD1_DESCRI   := 'C->' + TMP->TABCDatinc + ' - Param->' + TMP->TABCINCVIG
                        
                        endif
                     
                     endif

                     if empty(PD1->PD1_CONF)

                        PD1->PD1_CONF     := 'C '
                        PD1->PD1_DESCRI   := 'Sem criticas'
                     
                     endif

                     PD1->PD1_LANCDC   := TMP->TABCCoddc
                     PD1->PD1_CODPLA   := TMP->TABCCODPLA
                     PD1->PD1_CODEMP   := TMP->TABCCODEMP
                  
                  Msunlock("PD1")
               
               else
                  a  := 'b'
               endif

            endif

         endif

         TMP->(DbSkip())
      end

   elseif ind == 2

      while !(TMP->(Eof()))

         if ((TMP->TABCDatblo <> ' ' .and. substr(StrZero(val(TMP->TABMMATCAB),17),1,14) == '0001'+trim(TMP->TABCCodemp) + trim(TMP->TABCMatric)  ) .OR. trim(TMP->TABCDatblo) == '')

            aAdd(aDadosSCabj, {  TMP->TABMMATODO   ,;
                                 TMP->TABMNOMUSR   ,;
                                 TMP->TABMDESCPL   ,;
                                 TMP->TABMTPUSUA   ,;
                                 TMP->TABMVALOR    ,;
                                 TMP->TABMMATCAB   ,;
                                 TMP->TABMVLCAB    })
            
            if mv_par03 == 1

               PD1->(dbGoTo(TMP->TABMRECPD1))

               RecLock("PD1",.F.)

                  PD1->PD1_CONF     := 'CC'
                  PD1->PD1_CRITIC   := 'Sem registro Caberj'
                  PD1->PD1_LANCDC   := TMP->TABCCoddc
                  PD1->PD1_CODPLA   := ' '
                  PD1->PD1_CODEMP   := ' '
                  PD1->PD1_DESCRI   := 'Matric Caberj -->' + TMP->TABCMatric + 'Matric Met Life -->' + TMP->TABMMATCAB
               
               Msunlock("PD1")
            
            endif
         
         endif

         TMP->(DbSkip())
      end
   
   elseif ind == 3

      while !(TMP->(Eof()))

         if ((TMP->TABCDatblo <> ' ' .and. substr(StrZero(val(TMP->TABMMATCAB),17),1,14) == '0001' + trim(TMP->TABCCodemp) + trim(TMP->TABCMatric)  ) .OR. trim(TMP->TABCDatblo) == '')

            aAdd(aDadosSlife, {  TMP->TABCCodemp   ,;
                                 TMP->TABCMatric   ,;
                                 TMP->TABCTipreg   ,;
                                 TMP->TABCNomusr   ,;
                                 TMP->TABCDatinc   ,;
                                 TMP->TABCDatblo   ,;
                                 TMP->TABCCodpla   ,;
                                 TMP->TABCYmtodo   ,;
                                 TMP->TABCVlrml    ,;
                                 TMP->TABCCoddc    })
            
            if mv_par03 == 1

               FGrvPD1SM(  TMP->TABCCodemp   ,;
                           TMP->TABCMatric   ,;
                           TMP->TABCTipreg   ,;
                           TMP->TABCNomusr   ,;
                           TMP->TABCDatinc   ,;
                           TMP->TABCDatblo   ,;
                           TMP->TABCCodpla   ,;
                           TMP->TABCYmtodo   ,;
                           TMP->TABCVlrml    ,;
                           TMP->TABCCoddc    ,;
                           TMP->TABCDESCPL   )
            
            endif
         
         endif

         TMP->(DbSkip())
      end
   
   endif

next

fFazexcel()

return



Static Function AjustaSX1(cPerg)

PutSx1(cPerg,"01",OemToAnsi("Arquivo MetLife?")       ,"","","mv_ch1","C",60,0,0,"G","U_fGetFile('csv (*.csv) | *.csv | ')","","","","mv_par01","",""          ,"","","","",""         ,"","",""               ,"","","","","",""         ,{},{},{})
PutSx1(cPerg,"02",OemToAnsi("Mes/Ano Competencia?")   ,"","","mv_ch2","C",07,0,0,"G",""                                    ,"","","","mv_par02","",""          ,"","","","",""         ,"","",""               ,"","","","","","99/9999"  ,{},{},{})
PutSx1(cPerg,"03",OemToAnsi("Efetivar Conferencia?")  ,"","","mv_ch3","N",01,0,0,"C",""                                    ,"","","","mv_par03","Sim"          ,"","","","Nใo"         ,"","",""               ,"","","","","",""         ,{},{},{})
PutSx1(cPerg,"04",OemToAnsi("Importar?")              ,"","","mv_ch4","N",01,0,0,"C",""                                    ,"","","","mv_par04","Sim"          ,"","","","Nใo"         ,"","",""               ,"","","","","",""         ,{},{},{})
PutSx1(cPerg,"05",OemToAnsi("Planilha de?")           ,"","","mv_ch5","N",01,0,0,"C",""                                    ,"","","","mv_par05","Conf_Fatura"  ,"","","","Faturamento" ,"","","Conf_Cadastro"  ,"","","","","",""         ,{},{},{})

Pergunte(cPerg,.T.)

return



Static Function FGrvPD1(aDados)

Local COMP     := cCompAno+cCompMes

if mv_par05 == 1

   if empty(aDados[04])
      cCritica := 'Falta Matricula Caberj/Integral'
   else
      cCritica := 'Importa็ใo Sem Critica'
   endif

   PD1->(dbSetOrder(1))
   if PD1->(MsSeek(xFilial("PD1")+ COMP + aDados[07] + cTpTab +cRdaEmp ))

      PD1->(Reclock("PD1",.F.))

         PD1->PD1_VALOR    += VAL(Replace(SUBSTR(aDados[14],4,LEN(aDados[14])),',','.'))
         PD1->PD1_VLCAB    += 0.00
         PD1->PD1_QTDA     += 1
         PD1->PD1_CRITIC   := 'Mais de uma linha de Cobran็a'
      
      PD1->(MsUnlock())
   
   else

      // Necessario truncar casas decimais, lancando centavo no ultimo adic.
      PD1->(Reclock("PD1",.T.))

         PD1->PD1_FILIAL   := xFilial("PD1")
         PD1->PD1_COMPTE   := COMP
         PD1->PD1_MATODO   := aDados[07]
         PD1->PD1_NOMUSR   := aDados[06]
         PD1->PD1_TPUSUA   := aDados[11]
         PD1->PD1_DESCPL   := aDados[13]

         if cRdaEmp == '143260'
            PD1->PD1_VALOR := VAL(Replace(SUBSTR(aDados[14],1,LEN(aDados[14])),',','.'))
         else
            PD1->PD1_VALOR := VAL(Replace(SUBSTR(aDados[14],4,LEN(aDados[14])),',','.'))
         endif

         PD1->PD1_PARCEL   := '000'
         PD1->PD1_MATCAB   := aDados[04]
         PD1->PD1_VLCAB    := 0.00
         PD1->PD1_CONF     := '  '
         PD1->PD1_STATUS   := cTpTab
         PD1->PD1_QTDA     := 1
         PD1->PD1_CRITIC   := cCritica
         PD1->PD1_DESCRI   := cCritica
         PD1->PD1_CODRDA   := cRdaEmp
      
      PD1->(MsUnlock())
   
   endif

elseif mv_par05 == 2

   if empty(aDados[11])
      cCritica := 'Falta Matricula Caberj/Integral'
   else
      cCritica := 'Importa็ใo Sem Critica'
   endif

   if cRdaEmp == '145246'

      PD1->(dbSetOrder(1))
      if PD1->(MsSeek(xFilial("PD1")+ COMP + aDados[02] + cTpTab +cRdaEmp ))

         PD1->(Reclock("PD1",.F.))

            PD1->PD1_VALOR    += VAL(Replace(SUBSTR(aDados[07],4,LEN(aDados[07])),',','.'))
            PD1->PD1_VLCAB    += 0.00
            PD1->PD1_QTDA     += 1
         
         PD1->(MsUnlock())
      
      else

         // Necessario truncar casas decimais, lancando centavo no ultimo adic.
         PD1->(Reclock("PD1",.T.))	

            PD1->PD1_FILIAL   := xFilial("PD1")
            PD1->PD1_COMPTE   := COMP
            PD1->PD1_MATODO   := aDados[02]
            PD1->PD1_NOMUSR   := aDados[03]
            PD1->PD1_TPUSUA   := aDados[05]
            PD1->PD1_DESCPL   := aDados[06]
            PD1->PD1_VALOR    := VAL(Replace(SUBSTR(aDados[07],4,LEN(aDados[07])),',','.'))
            PD1->PD1_PARCEL   := '000'
            PD1->PD1_MATCAB   := aDados[11]
            PD1->PD1_VLCAB    := 0.00
            PD1->PD1_CONF     := '  '
            PD1->PD1_STATUS   := cTpTab
            PD1->PD1_QTDA     := 1
            PD1->PD1_CRITIC   := cCritica
            PD1->PD1_CODRDA   := cRdaEmp
         
         PD1->(MsUnlock())
      
      endif

   else

      if empty(aDados[07])
         cCritica := 'Falta Matricula Caberj/Integral'
      else
         cCritica := 'Importa็ใo Sem Critica'
      endif

      PD1->(dbSetOrder(1))
      if PD1->(MsSeek(xFilial("PD1")+ COMP + aDados[07] + cTpTab +cRdaEmp ))

         PD1->(Reclock("PD1",.F.))

            PD1->PD1_VALOR    += VAL(Replace(SUBSTR(aDados[14],4,LEN(aDados[14])),',','.'))
            PD1->PD1_VLCAB    += 0.00
            PD1->PD1_QTDA     += 1
            PD1->PD1_CRITIC   := 'Mais de uma linha de Cobran็a'
         
         PD1->(MsUnlock())
      
      else

         // Necessario truncar casas decimais, lancando centavo no ultimo adic.
         PD1->(Reclock("PD1",.T.))

            PD1->PD1_FILIAL   := xFilial("PD1")
            PD1->PD1_COMPTE   := COMP
            PD1->PD1_MATODO   := aDados[07]
            PD1->PD1_NOMUSR   := aDados[06]
            PD1->PD1_TPUSUA   := aDados[11]
            PD1->PD1_DESCPL   := aDados[13]
            PD1->PD1_VALOR    := VAL(Replace(SUBSTR(aDados[14],1,LEN(aDados[14])),',','.'))
            PD1->PD1_PARCEL   := '000'
            PD1->PD1_MATCAB   := aDados[04]
            PD1->PD1_VLCAB    := 0.00
            PD1->PD1_CONF     := '  '
            PD1->PD1_STATUS   := cTpTab
            PD1->PD1_QTDA     := 1
            PD1->PD1_CRITIC   := cCritica
            PD1->PD1_DESCRI   := cCritica
            PD1->PD1_CODRDA   := cRdaEmp
         
         PD1->(MsUnlock())
      
      endif

   endif

elseif mv_par05 == 3
   MsgAlert("Fun็ใo nใo implementada", "Atencao!")
endif

return



Static Function FGrvPD1SM( TABCCodemp  ,;
                           TABCMatric  ,;
                           TABCTipreg  ,;
                           TABCNomusr  ,;
                           TABCDatinc  ,;
                           TABCDatblo  ,;
                           TABCCodpla  ,;
                           TABCYmtodo  ,;
                           TABCVlrml   ,;
                           TABCCoddc   ,;
                           TABCDESCPL  )

Local COMP        := cCompAno+cCompMes
Local cCritica    := 'Falta Dados MetLife'

PD1->(dbSetOrder(1))
if PD1->(MsSeek(xFilial("PD1")+ COMP + TABCYmtodo + cTpTab +cRdaEmp ))

   PD1->(Reclock("PD1",.F.))

      PD1->PD1_VALOR    += TABCVlrml
      PD1->PD1_VLCAB    += 0.00
      PD1->PD1_QTDA     += 1
      PD1->PD1_CRITIC   := 'Mais de uma linha de Cobran็a'
   
   PD1->(MsUnlock())

elseif ((TMP->TABCDatblo > dDtBloq) .OR. (TMP->TABCDatblo == ' '))

   // Necessario truncar casas decimais, lancando centavo no ultimo adic.
   PD1->(Reclock("PD1",.T.))

      PD1->PD1_FILIAL   := xFilial("PD1")
      PD1->PD1_COMPTE   := COMP
      PD1->PD1_MATODO   := TABCYmtodo
      PD1->PD1_NOMUSR   := TABCNomusr
      PD1->PD1_TPUSUA   := iif (TABCTipreg == '00','T','D')
      PD1->PD1_DESCPL   := TABCDESCPL
      PD1->PD1_VALOR    := TABCVlrml
      PD1->PD1_PARCEL   := '000'                                                                         
      PD1->PD1_MATCAB   := '0001'+trim(TABCCodemp)+trim(TABCMatric)+trim(TABCTipreg)
      PD1->PD1_VLCAB    := 0.00
      PD1->PD1_CONF     := 'CR'
      PD1->PD1_STATUS   := cTpTab
      PD1->PD1_QTDA     := 1
      PD1->PD1_CRITIC   := cCritica
      PD1->PD1_LANCDC   := TABCCoddc
      PD1->PD1_CODPLA   := TABCCODPLA
      PD1->PD1_CODEMP   := TABCCODEMP
      PD1->PD1_DESCRI   := cCritica
      PD1->PD1_CODRDA   := cRdaEmp
   
   PD1->(MsUnlock())

endif

return



Static Function fVerfBgq()

Local cQuery   := ""

cQuery := " SELECT BGQ_ANO, BGQ_MES, BGQ_NUMLOT, COUNT(*) QTDA"
cQuery += " FROM " + RetSqlName("BGQ") + " BGQ"
cQuery += " WHERE D_E_L_E_T_ = ' '"
cQuery +=   " AND BGQ_FILIAL = '" + xFilial("BGQ") + "'"
cQuery +=   " AND BGQ_CODIGO = '" +     cRdaEmp    + "'"
cQuery +=   " AND BGQ_ANO	  = '" +    cCompAno    + "'"
cQuery +=   " AND BGQ_MES	  = '" +    cCompMes    + "'"
cQuery += "GROUP BY BGQ_ANO, BGQ_MES, BGQ_NUMLOT"

if Select(("TMP")) <> 0
   ("TMP")->(DbCloseArea())
endif

TCQuery cQuery Alias "TMP" New

if ("TMP")->QTDA > 0

   lRet  := .T.

   if EMPTY(TMP->BGQ_NUMLOT)
      lFaturado := .F.
   else
      lFaturado := .T.
   endif

else
   lRet := .F.
endif

return lRet



Static Function fLimpbgq()

Local cQuery   := ""
Local nSucesso := 0

cQuery := " UPDATE " + RetSqlName("BGQ") + " BGQ"
cQuery += " SET D_E_L_E_T_ = '*'"
cQuery += " WHERE D_E_L_E_T_ = ' '"
cQuery +=   " AND BGQ_FILIAL = '" + xFilial("BGQ") + "'"
cQuery +=   " AND BGQ_CODIGO = '" +     cRdaEmp    + "'"
cQuery +=   " AND BGQ_ANO	  = '" +    cCompAno    + "'"
cQuery +=   " AND BGQ_MES	  = '" +    cCompMes    + "'"
cQuery +=   " AND TRIM(BGQ_NUMLOT) IS NULL"

nSucesso := TcSqlExec(cQuery)

return



Static Function fLimpPD1()

Local cQuery   := ""
Local nSucesso := 0

cQuery := " UPDATE " + RetSqlName("PD1") + " PD1"
cQuery += " SET D_E_L_E_T_ = '*'"
cQuery += " WHERE D_E_L_E_T_ = ' '"
cQuery +=   " AND PD1_FILIAL = '" +   xFilial("PD1")  + "'"
cQuery +=   " AND PD1_COMPTE = '" + cCompAno+cCompMes + "'"
cQuery +=   " AND PD1_STATUS = '" +      cTpTab       + "'"
cQuery +=   " AND PD1_CODRDA = '" +     cRdaEmp       + "'"

nSucesso := TcSqlExec(cQuery)

return



static Function fFazexcel()

Local cQuery   := ""

cQuery := " SELECT PD1.*"
cQuery += " FROM " + RetSqlName("PD1") + " PD1"
cQuery += " WHERE PD1.D_E_L_E_T_ = ' '"
cQuery +=   " AND PD1_FILIAL = '" +   xFilial("PD1")  + "'"
cQuery +=   " AND PD1_COMPTE = '" + cCompAno+cCompMes + "'"
cQuery +=   " AND PD1_STATUS = '" +      cTpTab       + "'"
cQuery +=   " AND PD1_CODRDA = '" +     cRdaEmp       + "'"
cQuery += " ORDER BY PD1_CODEMP, PD1_CONF, PD1_CODPLA"

if Select(("TMP")) <> 0
   ("TMP")->(DbCloseArea())
endif

TCQuery cQuery Alias "TMP" New

dbSelectArea("TMP")

TMP->(dbGoTop())

while !(TMP->(Eof()))

   aAdd(aDadosCab1, {TMP->PD1_COMPTE                                                         ,;
                     TMP->PD1_MATODO                                                         ,;
                     TMP->PD1_CODEMP                                                         ,;
                     Posicione("BG9",1,xFilial("BG9")+'0001'+TMP->PD1_CODEMP,"BG9_DESCRI")   ,;
                     TMP->PD1_NOMUSR                                                         ,;
                     TMP->PD1_TPUSUA                                                         ,;
                     TMP->PD1_CODPLA                                                         ,;
                     TMP->PD1_DESCPL                                                         ,;
                     TMP->PD1_VALOR                                                          ,;
                     TMP->PD1_PARCEL                                                         ,;
                     TMP->PD1_MATCAB                                                         ,;
                     TMP->PD1_VLCAB                                                          ,;
                     TMP->PD1_CONF                                                           ,;
                     TMP->PD1_STATUS                                                         ,;
                     TMP->PD1_QTDA                                                           ,;
                     TMP->PD1_CRITIC                                                         ,;
                     TMP->PD1_LANCDC                                                         ,;
                     TMP->PD1_DESCRI                                                         })
   
   if (nAscan := aScan(aDadosCMF1, {|e| e[1]+e[2]+e[3]+e[4]+e[5]+e[6] == TMP->(PD1_CODEMP+PD1_CODPLA+PD1_CONF+PD1_CRITIC) + iif(TMP->PD1_TPUSUA == 'D', 'Dependent', 'Titular') + TMP->PD1_LANCDC })) == 0

      aAdd(aDadosCMF1, {TMP->PD1_CODEMP                                       ,;
                        TMP->PD1_CODPLA                                       ,;
                        TMP->PD1_CONF                                         ,;
                        TMP->PD1_CRITIC                                       ,;
                        iif(TMP->PD1_TPUSUA == 'D', 'Dependent', 'Titular')   ,;
                        TMP->PD1_LANCDC                                       ,;
                        TMP->PD1_VALOR                                        ,;
                        1                                                     })
   
   else

      aDadosCMF1[nAscan,7] += TMP->PD1_VALOR
      aDadosCMF1[nAscan,8] += 1
   
   endif

   TMP->(DbSkip())
end

FGrvPlan()

return



Static Function FGrvPlan()

Local nCount   := 0

cNomDadCab  := cTpTab + ' - 1 - Dados Analisados  '
cComp       := cCompMes +'/' + cCompAno
cNomPla     := 'Base Analisada '

cNomeArq    := "C:\TEMP\" + cCompAno+cCompMes + " - " + cEmpresa + " - " + cNomDadCab + "_" + SubStr(DtoS(date()),7,2)+"_"+SubStr(DtoS(date()),5,2) + "_" + SubStr(DtoS(date()),1,4) + "_" + STRTRAN(TIME(),":","_") + ".csv"
nHandle     := FCREATE(cNomeArq)

cMontaTxt   := cNomDadCab + CRLF
FWrite(nHandle, cMontaTxt)

cMontaTxt   := 'Competencia: ' + cComp + CRLF
FWrite(nHandle, cMontaTxt)

cMontaTxt   := 'Planilha: ' + cNomPla + CRLF
FWrite(nHandle, cMontaTxt)

cMontaTxt := "Compte       ;"
cMontaTxt += "Matric.Odonto;"
cMontaTxt += "Matric.Compl ;"
cMontaTxt += "Nome         ;"
cMontaTxt += "Tp Usuario   ;"
cMontaTxt += "Plano        ;"
cMontaTxt += "Vlr Caberj   ;"
cMontaTxt += "Vlr Met Life ;"
cMontaTxt += "Resultado    ;"
cMontaTxt += "Critica      ;"
cMontaTxt += "Desc Critica ;" + CRLF
FWrite(nHandle, cMontaTxt)

for nCount := 1 to len(aDadosCab1)

   cMontaTxt := trim(aDadosCab1[nCount][1])                                         + ";"
   cMontaTxt += trim(aDadosCab1[nCount][2])                                         + ";"
   cMontaTxt += trim(aDadosCab1[nCount][11])                                        + ";"
   cMontaTxt += trim(aDadosCab1[nCount][5])                                         + ";"
   cMontaTxt += trim(aDadosCab1[nCount][6])                                         + ";"
   cMontaTxt += trim(aDadosCab1[nCount][7]) + ' - ' + trim(aDadosCab1[nCount][8])   + ";"
   cMontaTxt += Transform(aDadosCab1[nCount][12],'@E  999,999,999.99')              + ";"
   cMontaTxt += Transform(aDadosCab1[nCount][9],'@E  999,999,999.99')               + ";"
   cMontaTxt += trim(aDadosCab1[nCount][13])                                        + ";"
   cMontaTxt += trim(aDadosCab1[nCount][16])                                        + ";"
   cMontaTxt += trim(aDadosCab1[nCount][18])                                        + ";" + CRLF
   FWrite(nHandle, cMontaTxt)

next

if nHandle > 0

   FClose(nHandle)
   
   cNomeArq1 += cNomeArq + CRLF
   MsgAlert("Relatorio(s) salvo(s) em: " + CRLF + cNomeArq1)

endif

cNomDadCab  := cTpTab + ' - 2 - Resumo da Conferencia '
cComp       := cCompMes+'/'+cCompAno
cNomPla     := ' BASE ANALISADA '

cNomeArq    := "C:\TEMP\" + cCompAno+cCompMes + " - " + cEmpresa + " - " + cNomDadCab + "_" + SubStr(DtoS(date()),7,2) + "_" + SubStr(DtoS(date()),5,2) + "_" + SubStr(DtoS(date()),1,4) + "_" + STRTRAN(TIME(),":","_") + ".csv"
nHandle     := FCREATE(cNomeArq)

cMontaTxt   := cNomDadCab + CRLF
FWrite(nHandle, cMontaTxt)

cMontaTxt := 'Competencia: ' + cComp + CRLF
FWrite(nHandle, cMontaTxt)

cMontaTxt := 'Planilha: ' + cNomPla + CRLF
FWrite(nHandle, cMontaTxt)

cMontaTxt := "Cod. Empresa ;"
cMontaTxt += "Cod Plano    ;"
cMontaTxt += "Status       ;"
cMontaTxt += "Critica      ;"
cMontaTxt += "Tp usuario   ;"
cMontaTxt += "Lanc D/C     ;"
cMontaTxt += "Valor        ;"
cMontaTxt += "Qtda         ;" + CRLF
FWrite(nHandle, cMontaTxt)

for nCount := 1 to len(aDadosCMF1)

   cMontaTxt := aDadosCMF1[nCount][1]                                   + ";"
   cMontaTxt += aDadosCMF1[nCount][2]                                   + ";"
   cMontaTxt += aDadosCMF1[nCount][3]                                   + ";"
   cMontaTxt += aDadosCMF1[nCount][4]                                   + ";"
   cMontaTxt += aDadosCMF1[nCount][5]                                   + ";"
   cMontaTxt += aDadosCMF1[nCount][6]                                   + ";"
   cMontaTxt += Transform(aDadosCMF1[nCount][7],'@E  999,999,999.99')   + ";"
   cMontaTxt += Transform(aDadosCMF1[nCount][8],'@E  99,999')           + ";" + CRLF
   FWrite(nHandle, cMontaTxt)

next

if nHandle > 0

   FClose(nHandle)

   cNomeArq1   += cNomeArq + CRLF
   MsgAlert("Relatorio salvo em: " + cNomeArq)

endif

return
