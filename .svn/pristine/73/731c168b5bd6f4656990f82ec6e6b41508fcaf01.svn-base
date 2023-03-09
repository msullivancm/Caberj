//Data     : 25/11/08
//Autor    : Luiz Alves Felizardo (Korus Consultoria)
//Descrição: Relatório de títulos emitidos x valores baixados

#include "rwmake.ch"
#include "plsmger.ch"

***********************
User Function CABR091()
***********************

   Local cDesc1  := "Este programa tem como objetivo imprimir relatorio "
   Local cDesc2  := "de acordo com os parametros informados pelo usuario."
   Local cDesc3  := "Títulos Emitidos x Baixados"
   Local cPict   := ""
   Local titulo  := "Títulos Emitidos x Baixados"
   Local nLin    := 80
   Local Cabec1  := "Cliente                                                                                  Título    Emissão   Vencto.  Baixa                       Valor Original      Valor Recebido     Bx S/Mov Financ     Valor A Receber"
   Local Cabec2  := ""
   Local imprime := .T.
                   //         1         2         3         4         5         6         7         8         9         0         1         2         3         4         5         6         7         8         9         0         1         2
                   //1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
                                                                                                                                                                                                          
   Private cCriterio1  := ""
   Private cCriterio2  := ""
   Private aOrd        := {}
   Private lEnd        := .F.
   Private lAbortPrint := .F.
   Private CbTxt       := ""
   Private limite      := 220
   Private tamanho     := "G"
   Private nomeprog    := "CABR091" // Coloque aqui o nome do programa para impressao no cabecalho
   Private nTipo       := 18
   Private aReturn     := {"Zebrado", 1, "Administracao", 2, 2, 1, "", 1}
   Private nLastKey    := 0
   Private cbtxt       := Space(10)
   Private cbcont      := 00
   Private CONTFL      := 01
   Private m_pag       := 01
   Private wnrel       := "CABR091"
   Private cString     := "tBA1"
   Private cPerg       := "CABR91"
   Private cPrefixos   := ""
   Private nCont       := 0  
  
   CriaSX1()

	Pergunte(cPerg, .T.)   

   wnrel := SetPrint("SE1", NomeProg, cPerg, @titulo, cDesc1, cDesc2, cDesc3, .T., , .T., Tamanho,, .T.)

   If nLastKey == 27
	   Return(.F.)
   EndIf  

   Do Case
      Case !Empty(MV_PAR01) .AND. !Empty(MV_PAR02)
         cCriterio1 := " AND E1_EMISSAO BETWEEN '" + DtoS(MV_PAR01) + "' AND '" + DtoS(MV_PAR02) + "' "
      Case !Empty(MV_PAR01) .AND. Empty(MV_PAR02)
         cCriterio1 := " AND E1_EMISSAO >= '" + DtoS(MV_PAR01) + "' "
      Case Empty(MV_PAR01) .AND. !Empty(MV_PAR02)
         cCriterio1 := " AND E1_EMISSAO <= '" + DtoS(MV_PAR02) + "' "
   EndCase

   Do Case
      Case !Empty(MV_PAR03) .AND. !Empty(MV_PAR04)
         cCriterio1 += " AND E1_ANOBASE BETWEEN '" + MV_PAR03 + "' AND '" + MV_PAR04 + "' "
      Case !Empty(MV_PAR03) .AND. Empty(MV_PAR04)
         cCriterio1 += " AND E1_ANOBASE >= '" + MV_PAR03 + "' "
      Case Empty(MV_PAR03) .AND. !Empty(MV_PAR04)
         cCriterio1 += " AND E1_ANOBASE <= '" + MV_PAR04 + "' "
   EndCase

   Do Case
      Case !Empty(MV_PAR05) .AND. !Empty(MV_PAR06)
         cCriterio1 += " AND E1_MESBASE BETWEEN '" + MV_PAR05 + "' AND '" + MV_PAR06 + "' "
      Case !Empty(MV_PAR05) .AND. Empty(MV_PAR06)
         cCriterio1 += " AND E1_MESBASE >= '" + MV_PAR05 + "' "
      Case Empty(MV_PAR05) .AND. !Empty(MV_PAR06)
         cCriterio1 += " AND E1_MESBASE <= '" + MV_PAR06 + "' "
   EndCase
   
   Do Case
      Case !Empty(MV_PAR07) .AND. !Empty(MV_PAR08)
         cCriterio1 += " AND E1_BAIXA BETWEEN '" + DtoS(MV_PAR07) + "' AND '" + DtoS(MV_PAR08) + "' "
      Case !Empty(MV_PAR07) .AND. Empty(MV_PAR08)
         cCriterio1 += " AND E1_BAIXA >= '" + DtoS(MV_PAR07) + "' "
      Case Empty(MV_PAR07) .AND. !Empty(MV_PAR08)
         cCriterio1 += " AND E1_BAIXA <= '" + DtoS(MV_PAR08) + "' "
   EndCase
     
   Do Case
      Case !Empty(MV_PAR10) .AND. !Empty(MV_PAR11)
         cCriterio1 += " AND BA3_TIPPAG BETWEEN '" + MV_PAR10 + "' AND '" + MV_PAR11 + "' "
      Case !Empty(MV_PAR10) .AND. Empty(MV_PAR11)
         cCriterio1 += " AND BA3_TIPPAG >= '" + MV_PAR10 + "' "
      Case Empty(MV_PAR10) .AND. !Empty(MV_PAR11)
         cCriterio1 += " AND BA3_TIPPAG <= '" + MV_PAR11 + "' "
   EndCase   
   
	SX5->(DBSetOrder(1))
	cPrefixos := ""
	If SX5->(DBSeek(xFilial("SX5")+"BK"))
		Do While !SX5->(Eof()) .And. Alltrim(SX5->X5_TABELA) == "BK"
			cPrefixos += If(Empty(cPrefixos), "", ";") + AllTrim(SX5->X5_CHAVE)
			SX5->(dbSkip())
		EndDo                                                                              
	EndIf        

   PlsQuery("SELECT COUNT(E1_NUM) AS Cont FROM " + RetSqlName("SE1") + ", " + RetSqlName("BA3") + " WHERE E1_FILIAL = '" + xFilial("SE1") + "' AND BA3_FILIAL = '" + xFilial("BA3") + "' AND BA3_CODCLI = E1_CLIENTE AND E1_PREFIXO IN " + FormatIn(cPrefixos, ";") + cCriterio1, "tSE1")
   If !tSE1->(Eof())
      nCont := tSE1->Cont
      If nCont == 0
         MsgStop("Não foi possível gerar o relatório!" + Chr(10) + "Não foram encontrados dados em acordo com os parâmetros passados.", "Aviso")
         Return(.F.)
      EndIf
   EndIf
   tSE1->(DBCloseArea())

   PlsQuery("SELECT E1_NUM, E1_EMISSAO, E1_BAIXA, E1_MESBASE, E1_ANOBASE, E1_VALOR, E1_SALDO, E1_CLIENTE, E1_VENCTO, E1_FILIAL, E1_PREFIXO, E1_PARCELA, E1_TIPO FROM " + RetSqlName("SE1") + ", " + RetSqlName("BA3") + " WHERE E1_FILIAL = '" + xFilial("SE1") + "' AND BA3_FILIAL = '" + xFilial("BA3") + "' AND BA3_CODCLI = E1_CLIENTE AND E1_PREFIXO IN " + FormatIn(cPrefixos, ";") + cCriterio1 + " ORDER BY E1_ANOBASE, E1_MESBASE, E1_NUM", "tSE1")

   SetDefault(aReturn, cString)
                                                  		
   If nLastKey == 27
      Return(.F.)
   EndIf

   nTipo := If(aReturn[4] == 1, 15, 18)

   RptStatus({|| RunReport(Cabec1, Cabec2, Titulo, nLin)}, Titulo)
   
   tSE1->(DBCloseArea())
Return(.T.)

*******************************************************
Static Function RunReport(Cabec1, Cabec2, Titulo, nLin)
*******************************************************

   Local nQuant  := 0
   Local nOrdem  := aReturn[8]
   Local cAnoMes := ""
   Local aSoma   := {0, 0, 0, 0}

   SetRegua(nCont)
   
   Do While !tSE1->(EOF())

      If lAbortPrint
         @nLin,00 PSAY "*** CANCELADO PELO OPERADOR ***"
         Exit
      EndIf

      If nLin > 70 .Or. (70 - nLin) <= 8
         Cabec(Titulo, Cabec1, Cabec2, NomeProg, Tamanho, nTipo)
         nLin := 8
      EndIf

      If cAnoMes != tSE1->(E1_ANOBASE+E1_MESBASE)
         If !Empty(cAnoMes)
            @nLin,000 PSay Replicate("-", 220)
            nLin++
            @nLin,000 PSay "Totais :"
            @nLin,162 PSay aSoma[1] Picture "@E 999,999,999,999.99"
            @nLin,182 PSay aSoma[2] Picture "@E 999,999,999,999.99"
            @nLin,202 PSay aSoma[3] Picture "@E 999,999,999,999.99"
            nLin++
            @nLin,000 PSay Replicate("-", 220)      
            nLin+=2
            
            aSoma := {0, 0, 0, 0}
         EndIf
         
         cAnoMes := tSE1->(E1_ANOBASE+E1_MESBASE)
      
         @nLin,000 PSay Replicate("-", 220)
         nLin++
         @nLin,000 PSay "Mês/Ano : " + tSE1->E1_MESBASE + "/" + tSE1->E1_ANOBASE
         nLin++
         @nLin,000 PSay Replicate("-", 220)      
         nLin++         
      EndIf
      
      nBaixaMF  := 0 //Baixas com movimentação financeira
      nBaixaMNF := 0 //Baixas com movimentação não financeira
      
      PLSQuery("SELECT E5_VALOR, E5_MOTBX, E5_FILIAL, E5_PREFIXO, E5_PARCELA, E5_TIPO, E5_NUMERO, E5_SEQ FROM " + RetSqlName("SE5") + " WHERE E5_TIPODOC <> 'ES' AND E5_FILIAL = '" + tSE1->E1_FILIAL + "' AND E5_PREFIXO = '" + tSE1->E1_PREFIXO + "' AND E5_TIPO = '" + tSE1->E1_TIPO + "' AND E5_NUMERO = '" + tSE1->E1_NUM + "' AND E5_PARCELA = '" + tSE1->E1_PARCELA + "'", "tSE5")
      Do While !tSE5->(Eof())
         PLSQuery("SELECT R_E_C_N_O_ FROM " + RetSqlName("SE5") + " WHERE E5_FILIAL = '" + tSE5->E5_FILIAL + "' AND E5_PREFIXO = '" + tSE5->E5_PREFIXO + "' AND E5_TIPO = '" + tSE5->E5_TIPO + "' AND E5_NUMERO = '" + tSE5->E5_NUMERO + "' AND E5_PARCELA = '" + tSE5->E5_PARCELA + "' AND E5_SEQ = '" + tSE5->E5_SEQ + "' AND E5_TIPODOC = 'ES'", "tSE5CAN")
         If tSE5CAN->(Eof())
            If AllTrim(tSE5->E5_MOTBX) == "NOR"
               nBaixaMF  += tSE5->E5_VALOR
            Else
               nBaixaMNF += tSE5->E5_VALOR 
            EndIf
         EndIf
         tSE5CAN->(DBCloseArea())
         tSE5->(DBSkip())
      EndDo
      tSE5->(DBCloseArea())
      
      @nLin,000 PSay Left(tSE1->E1_CLIENTE + " " + Posicione("SA1", 1, xFilial("SA1")+tSE1->E1_CLIENTE, "A1_NOME"), 100)
      @nLin,090 PSay tSE1->E1_NUM     Picture "@E 999999"
      @nLin,100 PSay tSE1->E1_EMISSAO Picture "@D"
      @nLin,110 PSay tSE1->E1_VENCTO  Picture "@D"
      @nLin,120 PSay tSE1->E1_BAIXA   Picture "@D"
      @nLin,142 PSay tSE1->E1_VALOR   Picture "@E 999,999,999,999.99"
      @nLin,162 PSay nBaixaMF         Picture "@E 999,999,999,999.99"
      @nLin,182 PSay nBaixaMNF        Picture "@E 999,999,999,999.99"      
      @nLin,202 PSay tSE1->E1_SALDO   Picture "@E 999,999,999,999.99"  
      
      aSoma[1] += tSE1->E1_VALOR
      aSoma[2] += nBaixaMF
      aSoma[3] += nBaixaMNF     
      aSoma[4] += tSE1->E1_SALDO

      nLin++
      nQuant := 0
      tSE1->(DBSkip())
      IncRegua()
   EndDo

   @nLin,000 PSay Replicate("-", 220)
   nLin++
   @nLin,000 PSay "Totais :"
   @nLin,142 PSay aSoma[1] Picture "@E 999,999,999,999.99"
   @nLin,162 PSay aSoma[2] Picture "@E 999,999,999,999.99"
   @nLin,182 PSay aSoma[3] Picture "@E 999,999,999,999.99"
   @nLin,202 PSay aSoma[4] Picture "@E 999,999,999,999.99"   
   nLin++
   @nLin,000 PSay Replicate("-", 220)      
   nLin+=2

   SET DEVICE TO SCREEN

   If aReturn[5] == 1
      DBCommitAll()
      SET PRINTER TO
      OurSpool(wnrel)
   EndIf

   MS_FLUSH()

Return(.T.)

*************************
Static Function CriaSX1()
*************************

   Local aRegs	:=	{}

   Aadd(aRegs, {cPerg, "01", "Emissao De ?               ", "", "", "MV_CH1", "D", 08, 0, 0, "G", "", "MV_PAR01", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", ""   , ""})
   Aadd(aRegs, {cPerg, "02", "Emissao Ate?               ", "", "", "MV_CH2", "D", 08, 0, 0, "G", "", "MV_PAR02", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", ""   , ""})
   Aadd(aRegs, {cPerg, "03", "Ano De ?                   ", "", "", "MV_CH3", "C", 04, 0, 0, "G", "", "MV_PAR03", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", ""   , ""})
   Aadd(aRegs, {cPerg, "04", "Ano Ate?                   ", "", "", "MV_CH4", "C", 04, 0, 0, "G", "", "MV_PAR04", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", ""   , ""})
   Aadd(aRegs, {cPerg, "05", "Mes De ?                   ", "", "", "MV_CH5", "C", 02, 0, 0, "G", "", "MV_PAR05", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", ""   , ""})
   Aadd(aRegs, {cPerg, "06", "Mes Ate?                   ", "", "", "MV_CH6", "C", 02, 0, 0, "G", "", "MV_PAR06", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", ""   , ""})
   Aadd(aRegs, {cPerg, "07", "Baixa De ?                 ", "", "", "MV_CH7", "D", 08, 0, 0, "G", "", "MV_PAR07", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", ""   , ""})
   Aadd(aRegs, {cPerg, "08", "Baixa Ate?                 ", "", "", "MV_CH8", "D", 08, 0, 0, "G", "", "MV_PAR08", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", ""   , ""})
   Aadd(aRegs, {cPerg, "10", "Forma Pagto De?            ", "", "", "MV_CHA", "C", 03, 0, 0, "G", "", "MV_PAR10", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "BQL", ""})
   Aadd(aRegs, {cPerg, "11", "Forma Pagto Até?           ", "", "", "MV_CHB", "C", 03, 0, 0, "G", "", "MV_PAR11", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "BQL", ""})   

   PlsVldPerg(aRegs)
Return()