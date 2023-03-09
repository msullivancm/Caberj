#include "rwmake.ch"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ F080FIL  º Autor ³Jose Carlos Noronha º Data ³  01/08/2007 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Filtrar Titulos Bloqueados no Contas a Pagar Gerados no PLSº±±
±±º          ³ na Rotina de Baixas a Pagar Manual Por Lote.(FINA080)      º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Caberj                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function F080FIL 
Local cFil080
// "N" - Titulos Bloqueados
// "S" - Titulos Liberados por NF
// "M" - Titulos Liberados Manualmente
// A2_YBLQPLS = "N" - Fornecedor Sem Bloqueio
//if se2->e2_prefixo == 'COM'
//User Function APROVCOM(cPref, cNum, cParc, cTipo , cFornec)

cFil080 := '(SE2->E2_YLIBPLS $ "S|M") .or. (!Substr(E2_ORIGEM,1,3) $ "PLS") .or. (POSICIONE("SA2",1,xFilial("SA2")+SE2->E2_FORNECE+SE2->E2_LOJA,"A2_YBLQPLS") = "N")'
        //  .or. (SE2->E2_PREFIXO = 'COM' .AND. (SE2->E2_NUM  $ "S|M")
  //      .or. (SE2->E2_PREFIXO = 'COM' .AND. SE2->E2_SALDO > 0 .AND. SE2->E2_tipo = 'DP' .and. E2_NUM $ u_fFltCom() ) // liberação de comissao
            //.And. Posicione("SZA",1,xFilial("SZA")+SE2->E2_USUALIB, "ZA_DIAS") <= (dDataBase - SE2->E2_VENCREA)                               
Return cFil080 