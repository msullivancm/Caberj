#INCLUDE "TOPCONN.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOTVS.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍfÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  PLS720DOP  ºAutor  ³Fabio Bianchini     º Data ³  23/12/2020 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Ponto de Entrada para tratar o valor de COPART de Conv.     º±±
±±º          ³Recipr. O valor Apresentado prioritário nos casos de Recipr.º±±
±±º          ³é Reforçado no P.E.  PLSCOMEV. Aqui tratamos somente a TAXA º±±
±±º          ³ADM para cobrança de coparticipação                         º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function PLS720DOP()

Local lDOP    := ParamIXB[1]
Local nVlrTPF := ParamIXB[2] 
Local nVlrTAD := ParamIXB[3] 
Local nVlrBPF := ParamIXB[4]
Local nTaxaP  := 0
Local nTaxaR  := 0

Local aRet := {}

//FABIO BIANCHINI - 22/12/2020
//Pegando os Percentuais de TAXA a PAGAR E A COBRAR.  No ato desta implementação não houve necessidade 
//de alteração da taxa sobre o Pagamento
If ( (BA1->BA1_CODEMP $ '0004|0009') .and. (cEmpAnt == '01') ) 
    
    If Trim(BAU->BAU_CODOPE) <> "0001" .and. !EMPTY(Trim(BAU->BAU_CODOPE))  
        nTaxaP := u_fCalcTx( BD6->BD6_VLRAPR, BD6->BD6_CODEMP, BD6->BD6_MATRIC, BD6->BD6_TIPREG, 'P', BD6->BD6_CODRDA )
    Endif
    nTaxaR := u_fCalcTx( BD6->BD6_VLRAPR, BD6->BD6_CODEMP, BD6->BD6_MATRIC, BD6->BD6_TIPREG, 'R', BD6->BD6_CODRDA )

    nVlrTAD := BD6->BD6_VLRPAG * (nTaxaR/100)
    nVlrBPF := BD6->BD6_VLRPAG 
    nVlrTPF := BD6->BD6_VLRPAG + nVlrTAD

    BD6->(Reclock("BD6",.F.))
        BD6->BD6_VLRPF  := BD6->BD6_VLRPAG
        BD6->BD6_PERTAD := nTaxaR 
        BD6->BD6_VLRTAD := nVlrTAD
        BD6->BD6_VLRBPF := nVlrBPF
        BD6->BD6_VLRTPF := nVlrTPF
        BD6->BD6_TPPF   := "2" //1-Co-participação;2-Custo Operacional ==> Para guias de convenio precisa estar com "2" para não ir zerado para consolidação
        BD6->BD6_ALIAPF := "BGI"
    BD6->(MsUnlock())

Endif

aRet := {nVlrTPF,nVlrTAD,nVlrBPF} 

return aRet