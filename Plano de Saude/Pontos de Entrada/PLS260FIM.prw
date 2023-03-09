#include "protheus.ch"
#include "rwmake.ch"
#include "topconn.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ PLS260FIM ºAutor ³ Fred O. C. Jr     º Data ³  15/10/21    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³  Executado ao final da gravação do cadastro do benef.      º±±
±±º          ³    Tratamento: gravação de regra propria de carencia       º±±
±±º          ³                                                            º±±
±±º          ³  27/11/12 - Luiz Otávio: Impressão de Capa de Inclusão     º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function PLS260FIM

Local aArea    := GetArea()
Local nRecBA1  := BA1->(RECNO())
Local nRecBA3  := BA3->(RECNO())

// Ponto de Entrada entra ponteirado na Família (BA3), porém entra no próximo beneficiário ao editado (BA1)
// * Por isso reposiciono no primeiro benef. da família editada
BA1->(DbSetOrder(1))    // BA3_FILIAL+BA3_CODINT+BA3_CODEMP+BA3_MATRIC+BA3_CONEMP+BA3_VERCON+BA3_SUBCON+BA3_VERSUB
BA1->(DbSeek(xFilial("BA1") + BA3->(BA3_CODINT+BA3_CODEMP+BA3_MATRIC) ))

nRecBA1     := BA1->(RECNO())

if inclui .or. altera

   // Chamada de relatório para impressão de capa de inclusão
   U_CABR124(BA1->BA1_CODINT,BA1->BA1_CODEMP,BA1->BA1_CONEMP,BA1->BA1_SUBCON,BA1->BA1_MATRIC,BA1->BA1_TIPUSU,BA1->BA1_TIPREG)

endif

BA3->(DbGoTo(nRecBA3))
BA1->(DbGoTo(nRecBA1))

RestArea(aArea)

return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ GerCarBen ºAutor ³ Fred O. C. Jr     º Data ³  19/11/21    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³   Tratamento: gravação de regra propria de carencia        º±±
±±º          ³                                                            º±±
±±º          ³ nOrig -> 1 (ponto de entrada PLS260DGR - inclusão da       º±±
±±º          ³                família - tratar todos os beneficiários)    º±±
±±º          ³       -> 2 (importação do CBI - tratar somente             º±±
±±º          ³                beneficiário posicionado)                   º±±
±±º          ³       -> 3 (rotina de processamento em lote - tratar)      º±±
±±º          ³               somente beneficiário posicionado)            º±±
±±º          ³       -> 4 (ponto de entrada PLS260DGR - alteração de      º±±
±±º          ³               usuário - tratar somente ponteirado)         º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function GerCarBen( nRecBA1, nOrig )

Local aArea       := GetArea()
Local nRet        := 0           // qtde de registros processados (para o processamento em lote)
Local cChavFam    := ""
Local cChavBen    := ""
Local cQuery	   := ""
Local cAliasQry	:= GetNextAlias()
Local cQtDias     := "0"
Local nDiasNasc   := -1
Local nDiasCasa   := -1
Local nDiasAdmi   := -1
Local lZeraCare   := .F.
Local lCarSub     := .F.
Local nBA1Aux     := 0

BA1->(DbGoTo(nRecBA1))

cChavFam := BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC)
cChavBen := BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG)

BQC->(DbSetOrder(1))    // BQC_FILIAL+BQC_CODIGO+BQC_NUMCON+BQC_VERCON+BQC_SUBCON+BQC_VERSUB
if BQC->(DbSeek( xFilial("BQC") + BA1->(BA1_CODINT+BA1_CODEMP+BA1_CONEMP+BA1_VERCON+BA1_SUBCON+BA1_VERSUB) ))

   // 1º regra: isenção de carencia por prazo determinado no subcontrato (ver campo: BQC_XDIASC)
   if (BA1->BA1_DATINC - BQC->BQC_DATCON) <= BQC->BQC_XDIASC .and. BQC->BQC_XDIASC > 0
      lCarSub   := .T.
   endif

   // 2º regra: isenção no mês do reajuste
   if !lCarSub .and. BQC->BQC_XCARAN == '1' .and. !empty(BQC->BQC_MESREA) .and. month(BA1->BA1_DATINC) == val(BQC->BQC_MESREA)
      lCarSub   := .T.
   endif

endif

// Demais tratamentos da carência (checar um ou todos os beneficiários da família - dependendo da origem)
while BA1->(!EOF()) .and. BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC) == cChavFam

   nDiasNasc   := -1
   nDiasCasa   := -1
   nDiasAdmi   := -1
   lZeraCare   := lCarSub
   nBA1Aux     := BA1->(RECNO())

   // se vier da inclusão protheus (1), tratar todos os membros da familia... se vier do CBI (2), tratar só o beneficiário especifico
   if nOrig == 1 .or. (nOrig <> 1 .and. BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG) == cChavBen)

      nRet++

      // Visando garantir que qualquer mudança seja refletida nas alterações, sempre se limpará a BFO e a criará novamente
      BFO->(DbSetOrder(1))    // BFO_FILIAL+BFO_CODINT+BFO_CODEMP+BFO_MATRIC+BFO_TIPREG+BFO_CLACAR
      if BFO->(DbSeek(xFilial("BFO") + BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG) ))

         while BFO->(!EOF()) .and. BFO->(BFO_CODINT+BFO_CODEMP+BFO_MATRIC+BFO_TIPREG) == BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG)

            BFO->(Reclock('BFO',.F.))
               BFO->(DbDelete())
            BFO->(MsUnlock())

            BFO->(DbSkip())
         end

      endif

      if !lZeraCare

         if !empty(BA1->BA1_DATINC)

            nDiasNasc   := iif( !empty(BA1->BA1_DATNAS), BA1->BA1_DATINC - BA1->BA1_DATNAS, -1)
            nDiasCasa   := iif( !empty(BA1->BA1_DATCAS), BA1->BA1_DATINC - BA1->BA1_DATCAS, -1)
            nDiasAdmi   := iif( !empty(BA1->BA1_DATADM), BA1->BA1_DATINC - BA1->BA1_DATADM, -1)

         endif

         // Verificar se possui carência para novos beneficiários parametrizado
         BEY->(DbSetOrder(1)) // BEY_FILIAL+BEY_CODINT+BEY_CODIGO+BEY_NUMCON+BEY_VERCON+BEY_SUBCON+BEY_VERSUB+BEY_CODPRO
         if BEY->(DbSeek( xFilial("BEY") + BA1->(BA1_CODINT+BA1_CODEMP+BA1_CONEMP+BA1_VERCON+BA1_SUBCON+BA1_VERSUB+BA1_CODPLA) ))

            while !BEY->(EOF()) .and.  BEY->(BEY_CODINT+BEY_CODIGO+BEY_NUMCON+BEY_VERCON+BEY_SUBCON+BEY_VERSUB+BEY_CODPRO) ==;
                                       BA1->(BA1_CODINT+BA1_CODEMP+BA1_CONEMP+BA1_VERCON+BA1_SUBCON+BA1_VERSUB+BA1_CODPLA)

               // BEY_TIPO -> 1=Novo funcionario;2=Recem-nascido;3=Casamento
               
               if BEY->BEY_TIPO == '1' .and. nDiasAdmi <> -1

                  if (BEY->BEY_TIPUSU == BA1->BA1_TIPUSU .or. empty(BEY->BEY_TIPUSU)) .and. (BEY->BEY_GRAUPA == BA1->BA1_GRAUPA .or. empty(BEY->BEY_GRAUPA))

                     if BEY->BEY_LIMITE >= nDiasAdmi

                        lZeraCare   := .T.
                        exit
                     
                     endif
                  
                  endif
               
               endif

               if BEY->BEY_TIPO == '2' .and. nDiasNasc <> -1

                  if (BEY->BEY_TIPUSU == BA1->BA1_TIPUSU .or. empty(BEY->BEY_TIPUSU)) .and. (BEY->BEY_GRAUPA == BA1->BA1_GRAUPA .or. empty(BEY->BEY_GRAUPA))

                     if BEY->BEY_LIMITE >= nDiasNasc

                        lZeraCare   := .T.
                        exit
                     
                     endif
                  
                  endif

               endif

               if BEY->BEY_TIPO == '3' .and. nDiasCasa <> -1

                  if (BEY->BEY_TIPUSU == BA1->BA1_TIPUSU .or. empty(BEY->BEY_TIPUSU)) .and. (BEY->BEY_GRAUPA == BA1->BA1_GRAUPA .or. empty(BEY->BEY_GRAUPA))

                     if BEY->BEY_LIMITE >= nDiasCasa

                        lZeraCare   := .T.
                        exit
                     
                     endif
                  
                  endif

               endif

               BEY->(DbSkip())
            end

         endif

      endif

      if lZeraCare .and. BA1->BA1_XTPCAR <> '0'

         // beneficiário se enquadrou em regra de isenção de carência
         RecLock("BA1", .F.)
            BA1->BA1_XTPCAR   := '0'
         BA1->(MsUnLock())

      endif

      if empty(BA1->BA1_XTPCAR)

         // beneficiário se enquadrou em regra de isenção de carência
         RecLock("BA1", .F.)
            BA1->BA1_XTPCAR   := '1'   // se não for informado - sempre considerada carência padrão
         BA1->(MsUnLock())

      endif

      // 0 = Sem carência / 1 = Carência Padrão / 2 = Carência Novos Beneficiários
      if BA1->BA1_XTPCAR == '0' .or. BA1->BA1_XTPCAR == '1' .or. BA1->BA1_XTPCAR == '2'

         BA6->(DbSetOrder(1))    // BA6_FILIAL+BA6_CODINT+BA6_CODIGO+BA6_NUMCON+BA6_VERCON+BA6_SUBCON+BA6_VERSUB+BA6_CODPRO+BA6_VERPRO+BA6_CLACAR
         if BA6->(DbSeek( xFilial("BA6") + BA1->(BA1_CODINT+BA1_CODEMP+BA1_CONEMP+BA1_VERCON+BA1_SUBCON+BA1_VERSUB+BA1_CODPLA+BA1_VERSAO) ))

            while BA6->(!EOF()) .and. BA6->(BA6_CODINT+BA6_CODIGO+BA6_NUMCON+BA6_VERCON+BA6_SUBCON+BA6_VERSUB+BA6_CODPRO+BA6_VERPRO) ==;
                                       BA1->(BA1_CODINT+BA1_CODEMP+BA1_CONEMP+BA1_VERCON+BA1_SUBCON+BA1_VERSUB+BA1_CODPLA+BA1_VERSAO)

               RecLock("BFO", .T.)
                  BFO->BFO_FILIAL   := xFilial("BFO")
                  BFO->BFO_CODINT   := BA1->BA1_CODINT
                  BFO->BFO_CODEMP   := BA1->BA1_CODEMP
                  BFO->BFO_MATRIC   := BA1->BA1_MATRIC
                  BFO->BFO_TIPREG   := BA1->BA1_TIPREG
                  BFO->BFO_CLACAR   := BA6->BA6_CLACAR
                  BFO->BFO_CARENC   := iif(BA1->BA1_XTPCAR <> '0', iif(BA1->BA1_XTPCAR == '1' .or. BA6->BA6_XCANBE == 0, BA6->BA6_CARENC, BA6->BA6_XCANBE ), 0  )
                  BFO->BFO_UNICAR   := iif(BA1->BA1_XTPCAR <> '0', iif(BA1->BA1_XTPCAR == '1' .or. BA6->BA6_XCANBE == 0, BA6->BA6_UNICAR, BA6->BA6_XUNNBE ), "2")
                  BFO->BFO_DATCAR   := BA1->BA1_DATCAR
                  BFO->BFO_YRGIMP   := "1"
               BFO->(MsUnLock())
               
               BA6->(DbSkip())
            end

         endif

      elseif BA1->BA1_XTPCAR == '3'    // Carência Beneficiários Concorrência

         cQtDias  := AllTrim(Str( iif( (BA1->BA1_DATCAR - BA1->BA1_XDTCON) > 0, BA1->BA1_DATCAR - BA1->BA1_XDTCON, 1) ))
         
         // Buscar parametrizações das classes de carência
         cQuery := " select  ZS0_CLASSE as CLASSE,"
         cQuery +=         " case when   (ZS0_CODEMP <> ' ' and ZS0_NUMCON <> ' ' and ZS0_SUBCON <> ' ')                      then 1 else" +;   // SUBCONTRATO
                              " case when (ZS0_CODEMP <> ' ' and ZS0_NUMCON <> ' ' and ZS0_SUBCON = ' ')                       then 2 else" +;   // CONTRATO
                              " case when (ZS0_CODEMP <> ' ' and ZS0_NUMCON = ' '  and ZS0_SUBCON = ' ')                       then 3 else" +;   // EMPRESA
                              " case when (ZS0_CODEMP = ' '  and ZS0_NUMCON = ' '  and ZS0_SUBCON = ' ' and ZS0_PRODUT <> ' ') then 4"      +;   // PRODUTO
                              " else 5 end end end end as REGRA,"                                                                                // GENERICO
         cQuery +=         " ZS0_CARENC as CARENC,"
         cQuery +=         " ZS0_UNICAR as UNICAR,"
         cQuery +=         " 0 as CAR_DEF,"
         cQuery +=         " '2' as UNI_DEF"
         cQuery += " from " + RetSqlName("ZS0") + " ZS0"
         cQuery += " where ZS0.D_E_L_E_T_ = ' '"
         cQuery +=   " and ZS0_FILIAL = '" + xFilial("ZS0") + "'"
         cQuery +=   " and ZS0_TMPINI <= " + cQtDias + " and ZS0_TMPFIM >= " + cQtDias
         cQuery +=   " and ((ZS0_PRODUT = '    ' and ZS0_VERPRO = '   ') or (ZS0_PRODUT = '" + BA1->BA1_CODPLA + "' and ZS0_VERPRO = '" + BA1->BA1_VERSAO + "'))"
         cQuery +=   " and ((ZS0_CODEMP = '    ') or (ZS0_CODEMP = '"+ BA1->BA1_CODEMP + "'))"
         cQuery +=   " and ((ZS0_NUMCON = '    ' and ZS0_VERCON = '   ') or (ZS0_NUMCON = '" + BA1->BA1_CONEMP + "' and ZS0_VERCON = '" + BA1->BA1_VERCON + "'))"
         cQuery +=   " and ((ZS0_SUBCON = '    ' and ZS0_VERSUB = '   ') or (ZS0_SUBCON = '" + BA1->BA1_SUBCON + "' and ZS0_VERSUB = '" + BA1->BA1_VERSUB + "'))"

         cQuery += " union all"

         cQuery += " select  BA6_CLACAR as CLASSE,"
         cQuery +=         " 6 as REGRA,"
         cQuery +=         " BA6_XCABEC as CARENC,"
         cQuery +=         " BA6_XUNBEC as UNICAR,"
         cQuery +=         " BA6_CARENC as CAR_DEF,"
         cQuery +=         " BA6_UNICAR as UNI_DEF"
         cQuery += " from " + RetSqlName("BA6") + " BA6"
         cQuery += " where BA6.D_E_L_E_T_ = ' '"
         cQuery +=   " and BA6_FILIAL = '" + xFilial("BA6") + "'"
         cQuery +=   " and BA6_CODINT = '" + BA1->BA1_CODINT + "'"
         cQuery +=   " and BA6_CODIGO = '" + BA1->BA1_CODEMP + "'"
         cQuery +=   " and BA6_NUMCON = '" + BA1->BA1_CONEMP + "'"
         cQuery +=   " and BA6_VERCON = '" + BA1->BA1_VERCON + "'"
         cQuery +=   " and BA6_SUBCON = '" + BA1->BA1_SUBCON + "'"
         cQuery +=   " and BA6_VERSUB = '" + BA1->BA1_VERSUB + "'"
         cQuery +=   " and BA6_CODPRO = '" + BA1->BA1_CODPLA + "'"
         cQuery +=   " and BA6_VERPRO = '" + BA1->BA1_VERSAO + "'"

         cQuery += " order by CLASSE, REGRA"

         TcQuery cQuery New Alias (cAliasQry)

         while (cAliasQry)->(!EOF())

            BFO->(DbSetOrder(1))    // BFO_FILIAL+BFO_CODINT+BFO_CODEMP+BFO_MATRIC+BFO_TIPREG+BFO_CLACAR
            if !BFO->(DbSeek(xFilial("BFO") + BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG) + (cAliasQry)->CLASSE ))

               RecLock("BFO", .T.)
                  BFO->BFO_FILIAL   := xFilial("BFO")
                  BFO->BFO_CODINT   := BA1->BA1_CODINT
                  BFO->BFO_CODEMP   := BA1->BA1_CODEMP
                  BFO->BFO_MATRIC   := BA1->BA1_MATRIC
                  BFO->BFO_TIPREG   := BA1->BA1_TIPREG
                  BFO->BFO_CLACAR   := (cAliasQry)->CLASSE
                  BFO->BFO_CARENC   := iif((cAliasQry)->REGRA == 6 .and. (cAliasQry)->CARENC == 0, (cAliasQry)->CAR_DEF, (cAliasQry)->CARENC )
                  BFO->BFO_UNICAR   := iif((cAliasQry)->REGRA == 6 .and. (cAliasQry)->CARENC == 0, (cAliasQry)->UNI_DEF, (cAliasQry)->UNICAR )
                  BFO->BFO_DATCAR   := BA1->BA1_DATCAR
                  BFO->BFO_YRGIMP   := "1"
               BFO->(MsUnLock())

            endif

            (cAliasQry)->(DbSkip())
         end
         (cAliasQry)->(DbCloseArea())

      endif

      if nOrig == 1 .or. nOrig == 4
         PLSVSCLACAR(BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG))
      endif

      BA1->(DbGoTo(nBA1Aux))

   endif

   BA1->(DbSkip())
end

BA1->(DbGoTo(nRecBA1))

RestArea(aArea)

return nRet



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ GerDtLim  ºAutor ³ Fred O. C. Jr     º Data ³  19/11/21    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³   Tratamento: calcular a data limite                       º±±
±±º          ³                                                            º±±
±±º          ³ nOrig -> 1 (ponto de entrada PLS260DGR - inclusão          º±±
±±º          ³                da família - tratar todos os beneficiários) º±±
±±º          ³          2 (ponto de entrada PLS260DGR - alteração)        º±±
±±º          ³                somente beneficiario ponteirado.            º±±
±±º          ³                * perguntar se deve executar)               º±±
±±º          ³       -> 3 (importação do CBI - tratar somente             º±±
±±º          ³                beneficiário posicionado)                   º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function GerDtLim( nRecBA1, nTp )

Local cQuery		   := ""
Local cAliasBA1		:= NIL
Local lAtuReg        := .T.

BA1->(DbGoTo(nRecBA1))

cQuery := " select BA1.R_E_C_N_O_ as BA1REC, trim(BA1_NOMUSR) as BA1_NOMUSR,"
cQuery +=		 " TO_DATE(TRIM(BA1_YDTLIM),'YYYYMMDD') as BA1_YDTLIM,"
cQuery +=		 " LAST_DAY(ADD_MONTHS(TO_DATE(TRIM( case when BT0_XIDALI <> 999 then BA1_DATNAS else ' ' end ),'YYYYMMDD'),(BT0_XIDALI*12))) AS BA1_DATINC"
cQuery += " from " + RetSqlName("BA1") + " BA1"
cQuery +=	" left join " + RetSqlName("BT0") + " BT0"
cQuery +=		" on (    BT0.D_E_L_E_T_ = ' '"
cQuery +=			" and BT0_FILIAL = BA1_FILIAL"
cQuery +=			" and BT0_CODIGO = BA1_CODINT||BA1_CODEMP"
cQuery +=			" and BT0_NUMCON = BA1_CONEMP"
cQuery +=			" and BT0_VERCON = BA1_VERCON"
cQuery +=			" and BT0_SUBCON = BA1_SUBCON"
cQuery +=			" and BT0_VERSUB = BA1_VERSUB"
cQuery +=			" and BT0_CODPRO = BA1_CODPLA"
cQuery +=			" and BT0_VERSAO = BA1_VERSAO"
cQuery +=			" and BT0_ATIVO = '1'"
cQuery +=			" and (BT0_TIPUSR = BA1_TIPUSU or BT0_TIPUSR = ' ')"
cQuery +=			" and (BT0_GRAUPA = BA1_GRAUPA or BT0_GRAUPA = ' ')"
cQuery +=			" and (BT0_ESTCIV = BA1_ESTCIV or BT0_ESTCIV = ' ')"
cQuery +=			" and (BT0_SEXO   = BA1_SEXO   or BT0_SEXO   = ' ' or BT0_SEXO = '3') )"
cQuery += " where BA1.D_E_L_E_T_ = ' '"
cQuery +=	" and BA1_FILIAL = '" + xFilial("BA1") + "'"
cQuery +=	" and BA1_CODINT = '" + BA1->BA1_CODINT + "'"
cQuery +=	" and BA1_CODEMP = '" + BA1->BA1_CODEMP + "'"
cQuery +=	" and BA1_MATRIC = '" + BA1->BA1_MATRIC + "'"

if nTp == 2 .or. nTp == 3    // PE (alteração) ou vindo do CBI (só o usuário)
   cQuery += " and BA1_TIPREG = '" + BA1->BA1_TIPREG + "'"
endif

cQuery +=   " and BA1_MOTBLO = ' '"
cQuery +=   " and BT0_XIDALI <> 0 and BT0_XIDALI <> 999"
cQuery +=   " and BA1_TIPUSU <> 'T'"

cAliasBA1	:= MpSysOpenQuery(cQuery)

while (cAliasBA1)->(!EOF())

   lAtuReg        := .T.

   if (cAliasBA1)->BA1_YDTLIM <> (cAliasBA1)->BA1_DATINC

      if nTp == 2    // Alteração no sistema do beneficiário

         if !MsgYesNo("A data limite do beneficiário: " + (cAliasBA1)->BA1_NOMUSR +;
                     iif(empty((cAliasBA1)->BA1_YDTLIM), " não está preenchida.", " está divergente da parametrizada nos usuários permitidos.") +;
                     CHR(13)+CHR(10) + CHR(13)+CHR(10) + " Deseja atualizá-la?" )
            
            lAtuReg  := .F.
         
         endif

      endif

      BA1->(DBGoTo( (cAliasBA1)->BA1REC) )

      if lAtuReg

         RecLock("BA1", .F.)
            BA1->BA1_YDTLIM   := (cAliasBA1)->BA1_DATINC
         BA1->(MsUnLock())
      
      endif

   endif

   (cAliasBA1)->(DbSkip())
end

return











user function grdsdfrd

if MsgYesNo("Confirma geração do seed?")

   BA1->(DbSetOrder(1))
   BA1->(DbGoTop())

   while BA1->(!EOF())

      if empty(BA1->BA1_TKSEED) .and. ( empty(BA1->BA1_MOTBLO) .or. BA1->BA1_DATBLO >= StoD('20180101') )

         PLSTKSEEDG( BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO), .T.)

      endif

      BA1->(DbSkip())
   end

endif

return
