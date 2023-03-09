#Include "rwmake.ch"
#Include "plsmger.ch"

***********************
User Function CABR090()
***********************

   Local cDesc1     := "Este programa tem como objetivo imprimir relatorio "
   Local cDesc2     := "de acordo com os parametros informados pelo usuario."
   Local cDesc3     := "Bloqueados com títulos gerados"
   Local cPict      := ""
   Local titulo     := "Bloqueados com títulos gerados"
   Local nLin       := 80
   Local Cabec1     := "Cliente                                 Plano                           Bloqueio"
   Local Cabec2     := "Título    Emissão        Vencimento     Baixa              Valor           Saldo"
   Local imprime    := .T.
   
   Private cCriterio1  := ""
   Private cCriterio2  := ""
   Private aOrd        := {}
   Private lEnd        := .F.
   Private lAbortPrint := .F.
   Private CbTxt       := ""
   Private limite      := 80
   Private tamanho     := "P"
   Private nomeprog    := "CABR090" // Coloque aqui o nome do programa para impressao no cabecalho
   Private nTipo       := 18
   Private aReturn     := {"Zebrado", 1, "Administracao", 2, 2, 1, "", 1}
   Private nLastKey    := 0
   Private cbtxt       := Space(10)
   Private cbcont      := 00
   Private CONTFL      := 01
   Private m_pag       := 01
   Private wnrel       := "rCABR090" // Coloque aqui o nome do arquivo usado para impressao em disco
   Private cString     := "tBA1"
   Private cPerg       := "CABR09"
   Private cPrefixos   := ""
   
   CriaSX1()

	//Recebe parametros
	Pergunte(cPerg, .F.)   

   wnrel := SetPrint("SE1", NomeProg, cPerg, @titulo, cDesc1, cDesc2, cDesc3, .T., , .T., Tamanho,, .T.)

   If nLastKey == 27
	   Return(.F.)
   EndIf
   
	SX5->(DBSetOrder(1))
	If SX5->(DBSeek(xFilial("SX5")+"BK"))
		Do While !SX5->(Eof()) .And. Alltrim(SX5->X5_TABELA) == 'BK'
			cPrefixos += If(Empty(cPrefixos), "", ";") + AllTrim(SX5->X5_CHAVE)
			SX5->(dbSkip())
		EndDo
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
      Case !Empty(MV_PAR06) .AND. !Empty(MV_PAR07)
         cCriterio1 += " AND E1_ANOBASE BETWEEN '" + MV_PAR06 + "' AND '" + MV_PAR07 + "' "
      Case !Empty(MV_PAR06) .AND. Empty(MV_PAR07)
         cCriterio1 += " AND E1_ANOBASE >= '" + MV_PAR06 + "' "
      Case Empty(MV_PAR06) .AND. !Empty(MV_PAR07)
         cCriterio1 += " AND E1_ANOBASE <= '" + MV_PAR07 + "' "
   EndCase

   Do Case
      Case !Empty(MV_PAR08) .AND. !Empty(MV_PAR09)
         cCriterio1 += " AND E1_MESBASE BETWEEN '" + MV_PAR08 + "' AND '" + MV_PAR09 + "' "
      Case !Empty(MV_PAR08) .AND. Empty(MV_PAR09)
         cCriterio1 += " AND E1_MESBASE >= '" + MV_PAR08 + "' "
      Case Empty(MV_PAR08) .AND. !Empty(MV_PAR09)
         cCriterio1 += " AND E1_MESBASE <= '" + MV_PAR09 + "' "
   EndCase   

   Do Case
      Case MV_PAR10 == 1
         cCriterio1 += " AND E1_SALDO > 0 "
      Case MV_PAR10 == 2
         cCriterio1 += " AND E1_SALDO = 0 "
   EndCase   
   
   Do Case
      Case !Empty(MV_PAR03) .AND. !Empty(MV_PAR04)
         cCriterio2 := " AND BA1_DATBLO BETWEEN '" + DtoS(MV_PAR03) + "' AND '" + DtoS(MV_PAR04) + "' "
      Case !Empty(MV_PAR03) .AND. Empty(MV_PAR04)
         cCriterio2 := " AND BA1_DATBLO >= '" + DtoS(MV_PAR03) + "' "
      Case Empty(MV_PAR03) .AND. !Empty(MV_PAR04)
         cCriterio2 := " AND BA1_DATBLO <= '" + DtoS(MV_PAR04) + "' "
   EndCase
   
   If !Empty(MV_PAR11)
      cCriterio2 += " AND BA3_TIPPAG = '" + MV_PAR11 + "' "
   EndIf

   PlsQuery("SELECT BA3_CODCLI, BA1_DATBLO, BA3_CODPLA, BA3_CODINT, BA1_CODPLA, BA1_CODINT FROM " + RetSqlName("BA1") + ", " + RetSqlName("BA3") + " WHERE BA1_FILIAL = '" + xFilial("BA1") + "' AND BA3_FILIAL = '" + xFilial("BA3") + "' AND BA1_CODINT = BA3_CODINT AND BA1_CODEMP = BA3_CODEMP AND BA1_MATRIC = BA3_MATRIC AND " + RetSqlName("BA3") + ".D_E_L_E_T_ = ' ' AND " + RetSqlName("BA1") + ".D_E_L_E_T_ = ' ' " + cCriterio2 + " AND EXISTS (SELECT R_E_C_N_O_ FROM " + RetSqlName("SE1") + " WHERE E1_FILIAL = '" + xFilial("SE1") + "' AND E1_PREFIXO IN " + FormatIn(cPrefixos, ";") + " AND E1_CLIENTE = BA3_CODCLI AND E1_EMISSAO > BA1_DATBLO  AND " + RetSqlName("SE1") + ".D_E_L_E_T_ = ' ' " + cCriterio1 + ")", "tBA1")

   SetDefault(aReturn, cString)
                                                  		
   If nLastKey == 27
      Return(.F.)
   EndIf

   nTipo := If(aReturn[4] == 1, 15, 18)

   RptStatus({|| RunReport(Cabec1, Cabec2, Titulo, nLin)}, Titulo)
   
   tBA1->(DBCloseArea())
Return(.T.)

*******************************************************
Static Function RunReport(Cabec1, Cabec2, Titulo, nLin)
*******************************************************

   Local nQuant := 0
   Local nOrdem := aReturn[8]
   
   SetRegua(tBA1->(RecCount()))

   DBSelectArea("SE1")
   SE1->(DBSetOrder(2))
   
   Do While !tBA1->(EOF())

      If lAbortPrint
         @nLin,00 PSAY "*** CANCELADO PELO OPERADOR ***"
         Exit
      EndIf

      If nLin > 70 .Or. (70 - nLin) <= 8
         Cabec(Titulo, Cabec1, Cabec2, NomeProg, Tamanho, nTipo)
         nLin := 8
      EndIf
      
      @nLin,000 PSay Replicate("-", 80)
      nLin++
      @nLin,000 PSay Left(Posicione("SA1", 1, xFilial("SA1")+tBA1->BA3_CODCLI, "A1_NOME"), 39)
      
      If !Empty(BA1->BA1_CODPLA)
         @nLin,040 PSay Left(Posicione("BI3", 1, xFilial("BI3")+tBA1->BA1_CODINT+tBA1->BA1_CODPLA, "BI3_DESCRI"), 30)
      Else
         @nLin,040 PSay Left(Posicione("BI3", 1, xFilial("BI3")+tBA1->BA3_CODINT+tBA1->BA3_CODPLA, "BI3_DESCRI"), 30)
      EndIf      

      @nLin,072 PSay DtoC(tBA1->BA1_DATBLO)
      nLin++
      @nLin,000 PSay Replicate("-", 80)      
      nLin++
      
      PlsQuery("SELECT E1_NUM, E1_EMISSAO, E1_VENCTO, E1_BAIXA, E1_VALOR, E1_SALDO FROM " + RetSqlName("SE1") + " WHERE E1_FILIAL = '" + xFilial("SE1") + "' AND E1_PREFIXO IN " + FormatIn(cPrefixos, ";") + " AND E1_CLIENTE = '" + tBA1->BA3_CODCLI + "' AND E1_EMISSAO > '" + DtoS(tBA1->BA1_DATBLO) + "' AND D_E_L_E_T_ = ' ' " + cCriterio1 + " ORDER BY E1_EMISSAO, E1_NUM", "tSE1")
      
      Do While !tSE1->(Eof())
         If lAbortPrint
            @nLin,00 PSAY "*** CANCELADO PELO OPERADOR ***"
            Exit
         EndIf
         
         If nLin > 70
            Cabec(Titulo, Cabec1, Cabec2, NomeProg, Tamanho, nTipo)
            nLin := 8
         EndIf

         If MV_PAR05 == 1
            @nLin,000 PSay tSE1->E1_NUM
            @nLin,010 PSay tSE1->E1_EMISSAO Picture "@D"
            @nLin,025 PSay tSE1->E1_VENCTO  Picture "@D"
            @nLin,040 PSay tSE1->E1_BAIXA   Picture "@D"
            @nLin,050 PSay tSE1->E1_VALOR   Picture "@E 999,999,999.99"
            @nLin,066 PSay tSE1->E1_SALDO   Picture "@E 999,999,999.99"
            nLin++
         EndIf

         nQuant++
         tSE1->(DBSkip())
      EndDo
      tSE1->(DBCloseArea())
      
      nLin++
      nQuant := 0
      tBA1->(DBSkip())
      IncRegua()
   EndDo

   SET DEVICE TO SCREEN

   If aReturn[5] == 1
      DBCommitAll()
      SET PRINTER TO
      OurSpool(wnrel)
   EndIf

   MS_FLUSH()

Return(.T.)

Static Function CriaSX1()
   Local aRegs	:=	{}

   Aadd(aRegs, {cPerg, "01", "Emissao De ?    ", "", "", "MV_CH1", "D", 08, 0, 0, "G", "", "MV_PAR01", ""         , "", "", "", "", ""         , "", "", "", "", ""     , "", "", "", "", "", "", "", "", "", "", "", "", "", ""   , ""})
   Aadd(aRegs, {cPerg, "02", "Emissao Ate?    ", "", "", "MV_CH2", "D", 08, 0, 0, "G", "", "MV_PAR02", ""         , "", "", "", "", ""         , "", "", "", "", ""     , "", "", "", "", "", "", "", "", "", "", "", "", "", ""   , ""})
   Aadd(aRegs, {cPerg, "03", "Bloqueado De ?  ", "", "", "MV_CH3", "D", 08, 0, 0, "G", "", "MV_PAR03", ""         , "", "", "", "", ""         , "", "", "", "", ""     , "", "", "", "", "", "", "", "", "", "", "", "", "", ""   , ""})
   Aadd(aRegs, {cPerg, "04", "Bloqueado Ate?  ", "", "", "MV_CH4", "D", 08, 0, 0, "G", "", "MV_PAR04", ""         , "", "", "", "", ""         , "", "", "", "", ""     , "", "", "", "", "", "", "", "", "", "", "", "", "", ""   , ""})
   Aadd(aRegs, {cPerg, "05", "Tipo Relatorio? ", "", "", "MV_CH5", "N", 01, 0, 0, "C", "", "MV_PAR05", "Analitico", "", "", "", "", "Sintetico", "", "", "", "", ""     , "", "", "", "", "", "", "", "", "", "", "", "", "", ""   , ""})
   Aadd(aRegs, {cPerg, "06", "Ano De ?        ", "", "", "MV_CH6", "C", 04, 0, 0, "G", "", "MV_PAR06", ""         , "", "", "", "", ""         , "", "", "", "", ""     , "", "", "", "", "", "", "", "", "", "", "", "", "", ""   , ""})
   Aadd(aRegs, {cPerg, "07", "Ano Ate?        ", "", "", "MV_CH7", "C", 04, 0, 0, "G", "", "MV_PAR07", ""         , "", "", "", "", ""         , "", "", "", "", ""     , "", "", "", "", "", "", "", "", "", "", "", "", "", ""   , ""})
   Aadd(aRegs, {cPerg, "08", "Mes De ?        ", "", "", "MV_CH8", "C", 02, 0, 0, "G", "", "MV_PAR08", ""         , "", "", "", "", ""         , "", "", "", "", ""     , "", "", "", "", "", "", "", "", "", "", "", "", "", ""   , ""})
   Aadd(aRegs, {cPerg, "09", "Mes Ate?        ", "", "", "MV_CH9", "C", 02, 0, 0, "G", "", "MV_PAR09", ""         , "", "", "", "", ""         , "", "", "", "", ""     , "", "", "", "", "", "", "", "", "", "", "", "", "", ""   , ""})
   Aadd(aRegs, {cPerg, "10", "Situacao Titulo?", "", "", "MV_CHA", "N", 01, 0, 0, "C", "", "MV_PAR10", "Em Aberto", "", "", "", "", "Baixado"  , "", "", "", "", "Ambos", "", "", "", "", "", "", "", "", "", "", "", "", "", ""   , ""})
   Aadd(aRegs, {cPerg, "11", "Forma Pagto.?   ", "", "", "MV_CHB", "C", 03, 0, 0, "G", "", "MV_PAR11", ""         , "", "", "", "", ""         , "", "", "", "", ""     , "", "", "", "", "", "", "", "", "", "", "", "", "", "BQL", ""})

   PlsVldPerg(aRegs)
Return()