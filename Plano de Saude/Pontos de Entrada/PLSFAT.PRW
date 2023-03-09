#include "PROTHEUS.CH"

#define RESETLIN nLinha := 550
#define DEB_CRED "111,113,128,129,130,131,132,135,136"

//Data     : 15/07/05
//Autor    : Claudio M. Goncalves
//Descricao: Emissao da Nota Fiscal
************************************************************************************************************************************************************************************************************************************************
User Function PLSFAT(cmv_par01, cmv_par02, cmv_par03, cmv_par04, cmv_par05, cmv_par06, cmv_par07, cmv_par08, cmv_par09, cmv_par10, cmv_par11, cmv_par12, cmv_par13, cmv_par14, cmv_par15, cmv_par16, cmv_par17, cmv_par18,	cmv_par19, cmv_par20)
************************************************************************************************************************************************************************************************************************************************
   
   Private cTamanho := "P"
   Private cNumNF   := "000001"
   Private cTitulo  := "Emissao de Notas Fiscais"
   Private cDesc1   := "Emissao de Notas Fiscais de acordo com os parametros selecionados."
   Private cDesc2   := cDesc3 := ""
   Private cAlias   := "SE1"
   Private cPerg    := "PLSRFATNFS"
   Private cRel     := "PLSFAT"
   Private nLinha   := 02
   Private nQtdLin  := 60
   Private nli      := 80
   Private m_pag    := 1
   Private lCompres := lDicion := lCrystal := lAbortPrint := .F.
   Private lFiltro  := .T.
   Private aOrderns := {}
   Private aPlanos  := {}
   Private aReturn  := {"", 1,"", 1, 1, 1, "", 1}
   
   DBSelectArea("SX6")
   SX6->(DBSetOrder(1))
   If SX6->(DBSeek(xFilial("SX6")+"MV_YNUMTIP"))
      If Empty(SX6->X6_CONTEUD)
         cNumNF := "000001"
      Else
	      cNumNF := SX6->X6_CONTEUD
	   EndIf
   Else
	   SX6->(RecLock("SX6", .T.))
	   cNumNF          := "000001"
	   SX6->X6_VAR     := "MV_YNUMTIP"
      SX6->X6_TIPO    := "C"
      SX6->X6_DESCRIC := "Seguencia do numero tipografico"
      SX6->X6_DESC2   := "da nota fiscal"
	   SX6->X6_CONTEUD := cNumNF
	   SX6->(MsUnLock())      
   EndIf

   //Testa ambiente do relatorio somente top
   If !PLSRelTop()
	   Return(.F.)
   EndIf

   //Chama SetPrint(padrao)
   ValidPerg(cPerg, .T.)

   If cmv_par01 != Nil
      cPerg    := ""
      mv_par01 := cmv_par01
      mv_par02 := cmv_par02
      mv_par03 := cmv_par03
      mv_par04 := cmv_par04
      mv_par05 := cmv_par05
      mv_par06 := cmv_par06
      mv_par07 := cmv_par07
      mv_par08 := cmv_par08
      mv_par09 := cmv_par09
      mv_par10 := cmv_par10
      mv_par11 := cmv_par11
      mv_par12 := cmv_par12
      mv_par13 := cmv_par13
      mv_par14 := cmv_par14
      mv_par15 := cmv_par15
      mv_par16 := cmv_par16
      mv_par17 := cmv_par17
      mv_par18 := cmv_par18
      mv_par19 := cmv_par19
      mv_par20 := cmv_par20
   Else
	   Pergunte(cPerg, .F.)
   Endif
   
   If !fNumNF()
      MsgStop("Não é possível continuar sem informar o número tipográfico da nota fiscal inicial!", "Atenção")
      Return(.F.)
   EndIf

   cRel := SetPrint(cAlias, cRel ,cPerg, @cTitulo, cDesc1, cDesc2 , cDesc3, lDicion, aOrderns, lCompres, cTamanho , {}, lFiltro,	lCrystal)

   //Verifica se foi cancelada a operacao
   If nLastKey == 27
	   Return(.F.)
   Endif

   //Configura impressora
   SetDefault(aReturn, cAlias)
   
   //Emite relatorio
   MsAguarde({|| R580Imp()}, cTitulo, "", .T.)
Return(.T.)

//Data     : 14/06/02
//Autor    : Rafael M. Quadrotti
//Descricao: Imprime detalhe do relatorio
//----------------------------------------------------
//Data     : 05/11/08
//Autor    : Luiz Alves Felizardo (Korus Consultoria)
//Descricao: Inclusão da captura de número tipográfico
Static Function R580Imp()
   Local cSQL         := ""                       // Select deste relatorio
   Local cSE1Name     := SE1->(RetSQLName("SE1")) // Retorna o nome do alias no TOP
   Local cPrefixo     := ""                       // Prefixo do titulo
   Local cTitulo      := ""                       // Titulo
   Local cParcela     := ""                       // Parcela do titulo
   Local cTipo        := ""                       // E1_TIPO
   Local aDadosEmp    := {}                       // Array com os dados da empresa.
   Local aDadosTit    := {}                       // Array com os dados do titulo
   Local aDadosBanco  := {}                       // Array com os dados do banco
   Local aDatSacado	 := {}                       // Array com os dados do Sacado.
   Local CB_RN_NN  	 := {}                       // Array com as informacoes do Nosso Numero, Codigo de Barras, e Linha digitavel.
   Local aBmp			 := {""}                     // Vetor para Bmp.
   Local cOperadora   := BX4->(PLSINTPAD())       // Retorna a operadora do usuario.
   Local aBfq			 := {}
   Local aDependentes := {}                       // Array com os dependentes do sacado.
   Local aOpenMonth	 := {}                       // Array com os meses em aberto.
   Local aObservacoes := {}                       // Array com as observacoes do extrato.
   Local aMsgCorpo    := {}                       // Array com as observacoes do corpo do boleto.
   Local aMsgBoleto   := {}                       // Array com as mensagens do boleto.
   Local nPos         := 0                        // Variavel auxiliar para ascan.
   Local cCart        := ""                       // Carteira do titulo
   Local cSA6Key      := ""                       // Chave de pesquisa do SA6 Cadastro de bancos,
   Local aUsrVlr      := {}
   Local cCodtip      := ""
   Local nImposto	  := 0
   //Variaveis totalizadoras
   Private _nQtdInscr := 0
   Private _nQtdMens	 := 0
   Private _aQtdMens	 := {}
   Private _nQtdOpc   := 0
   Private _cCodEmp   := " "

   //Ordena arquivos envolvidos
   SE1->(DbSetOrder(01))
   BBT->(dbSetorder(07))
   BM1->(DbSetOrder(04))
   BA1->(DbSetOrder(02))
   BA0->(DbSetorder(01))
   BI3->(DbSetorder(01))

   cSQL := "SELECT * FROM " + cSE1Name + " WHERE E1_FILIAL = '" + xFilial("SE1") + "' AND "
   cSQL += "E1_CLIENTE + E1_LOJA >= '" + mv_par01 + mv_par02 + "' AND "
   cSQL += "E1_CLIENTE + E1_LOJA <= '" + mv_par03 + mv_par04 + "' AND "
   cSQL += "E1_CODINT >= '" + mv_par05 + "' AND E1_CODINT <= '" + mv_par06 + "' AND "
   cSQL += "E1_CODEMP >= '" + mv_par07 + "' AND E1_CODEMP <= '" + mv_par08 + "' AND "
   cSQL += "E1_CONEMP >= '" + mv_par09 + "' AND E1_CONEMP <= '" + mv_par10 + "' AND "
   cSQL += "E1_SUBCON >= '" + mv_par11 + "' AND E1_SUBCON <= '" + mv_par12 + "' AND "
   cSQL += "E1_MATRIC >= '" + mv_par13 + "' AND E1_MATRIC <= '" + mv_par14 + "' AND "
   cSQL += "E1_ANOBASE + E1_MESBASE >= '" + mv_par16 + mv_par15 + "' AND "
   cSQL += "E1_ANOBASE + E1_MESBASE <= '" + mv_par18 + mv_par17 + "' AND E1_SALDO > 0 AND "
   cSQL += "E1_PREFIXO >= '" + mv_par26 + "' AND E1_PREFIXO <= '" + mv_par27 + "' AND "
   cSQL += "E1_NUM >= '" + mv_par28 + "' AND E1_NUM <= '" + mv_par29 + "' AND "
   cSQL += "E1_PARCELA >= '" + mv_par30 + "' AND E1_PARCELA <= '" + mv_par31 + "' AND "
   cSQL += "E1_TIPO >= '" + mv_par32 + "' AND E1_TIPO <= '" + mv_par33 + "' AND "
   cSQL += "E1_PARCELA <> '" + StrZero(0, Len(SE1->E1_PARCELA)) + "' AND "

   If !Empty(aReturn[7])
      cSQL += PLSParSQL(aReturn[7]) + " AND "
   EndIf

   cSQL += cSE1Name + ".D_E_L_E_T_ = ' ' "
   cSQL += "ORDER BY E1_FILIAL, E1_PREFIXO, E1_NUM, E1_PARCELA, E1_TIPO"

   PLSQuery(cSQL,"R580Imp")

   If R580Imp->(Eof())
	   R580Imp->(DbCloseArea())
	   Help("", 1, "RECNO")
	   Return(.F.)
   EndIf

   MsProcTxt(OemToAnsi("Buscando dados no servidor..."))

   //Posiciona a operadora padrao...
   BA0->(DBSeek(xFilial("BA0") + cOperadora))

   Do While !R580Imp->(Eof())
      aCobranca := {}       
      cPrefixo  := R580Imp->E1_PREFIXO
      cTitulo   := R580Imp->E1_NUM
      cParcela  := R580Imp->E1_PARCELA
      cTipo     := R580Imp->E1_TIPO

      //Posiciona tabelas envolvidas
      SE1->(DBSeek(xFilial("SE1") + cPrefixo + cTitulo + cParcela + cTipo))
      BBT->(DBSeek(xFilial("BBT") + cPrefixo + cTitulo + cParcela + cTipo))
      BG9->(DBSeek(xFilial("BG9") + BBT->BBT_CODOPE + BBT->BBT_CODEMP ))
      BA3->(DBSeek(xFilial("BA3") + BM1->BM1_CODINT + BM1->BM1_CODEMP + BM1->BM1_MATRIC))
      BI3->(DBSeek(xFilial("BI3") + BA3->BA3_CODPLA + BA3->BA3_VERSAO) )
      SA1->(DBSeek(xFilial("SA1") + R580Imp->E1_CLIENTE + R580Imp->E1_LOJA))

      aDependentes := {}

      //Gera lancamento para o faturamento de segunda via de boleto
      If mv_par20 == 2
         PLSUPT2BOL(BM1->(BM1_CODINT+BM1_CODEMP+BM1_MATRIC), dDataBase, 1)
      EndIf

      //Seleciona os BM1 envolvidos na fatura
      cFiltro := "SELECT BM1_CODINT, BM1_CODEMP, BM1_MATRIC, BM1_CODTIP, BM1_ATOCOO, BM1_VALOR, BM1_CODTIP, BM1_TIPO,"
      cFiltro += "BM1_DESTIP, BM1_CONEMP, BM1_VERCON, BM1_SUBCON, BM1_VERSUB, BM1_CODEVE, BM1_IDAINI, BM1_IDAFIN, BM1_DESEVE, "
      cFiltro += "BM1_LTOTAL, BM1_MATUSU, BM1_NOMUSR, BM1_PREFIX, BM1_NUMTIT, BM1_PARCEL FROM " + RetSqlName("BM1") + " WHERE "
      cFiltro += "BM1_FILIAL = ' ' AND "
      cFiltro += "BM1_PREFIX = '" + cPrefixo + "' AND "
      cFiltro += "BM1_NUMTIT = '" + cTitulo  + "' AND "
      cFiltro += "BM1_PARCEL = '" + cParcela + "' AND "
      cFiltro += "BM1_TIPTIT = '" + cTipo    + "' AND "
      cFiltro += "D_E_L_E_T_ <> '*' "
      cFiltro += "ORDER BY BM1_CODEMP, BM1_CONEMP, BM1_VERCON, BM1_SUBCON, BM1_VERSUB,BM1_CODEVE, BM1_IDAINI, BM1_IDAFIN "
      
      PlsQuery(cFiltro, "TRB2")
	
      //Em caso de pessoa juridica, nao emite os dependentes.
      If BG9->BG9_TIPO  == "1" //Pessoa Fisica
         //Busca de dependentes para impressao dos dados.
         DBSelectArea("BA1")
		   
		   If BA1->(DBSeek(xFilial("BA1")+TRB2->BM1_CODINT+TRB2->BM1_CODEMP+TRB2->BM1_MATRIC))
            Do While !BA1->(EOF()) .And. (xFilial("BA1")+TRB2->BM1_CODINT+TRB2->BM1_CODEMP+TRB2->BM1_MATRIC) == (BA1->BA1_FILIAL+BA1->BA1_CODINT+BA1->BA1_CODEMP+BA1->BA1_MATRIC)
               //Identifica os usuarios que fazem parte do titulo posicionado.
               If BG9->BG9_TIPO == "1" .And. (SubStr(DtoS(BA1->BA1_DATINC), 1, 6) <= R580Imp->E1_ANOBASE+R580Imp->E1_MESBASE) .And. Empty(BA1->BA1_MOTBLO)
                  Aadd(aDependentes, {BA1->BA1_TIPREG, BA1->BA1_NOMUSR})
               EndIf
				
				   BA1->(DBSkip())
            EndDo
         EndIf
      Else  
         _cCodEmp:= BG9->BG9_CODIGO    
         If 1 == 2
            RunPPG(_cCodEmp)	
         EndIf
      EndIf
      
      DBSelectArea("R580Imp")
	
      //Retorna os meses em aberto do sacado.
      aOpenMonth := PLR580MES(R580Imp->E1_CLIENTE, R580Imp->E1_LOJA, R580Imp->E1_MESBASE, R580Imp->E1_ANOBASE, cTipo)
      
      aUsrVlr := {}
	
      TRB2->(DBGotop())
      Do While !TRB2->(Eof())
         If MV_PAR24 == 2
            cCodtip := MV_PAR25
            cCodAto := "1"		 	
            cDesTip := Posicione("BFQ", 1, xFilial("BFQ")+TRB2->BM1_CODINT+cCodtip, "BFQ_DESCRI")
         Else
            cCodtip := TRB2->BM1_CODTIP
            cCodAto := TRB2->BM1_ATOCOO
            cDesTip := TRB2->BM1_DESTIP
         EndIf      
         
         //Padrao de boletos para UNIMED
         If BG9->BG9_TIPO == "2" //Se for Pessoa Juridica		
            If (Alltrim(BA3->BA3_MODPAG) == "1" .And. mv_par19 <> 3) .Or. Alltrim(BA3->BA3_MODPAG) <> "1"
               If (nPos := Ascan(aCobranca, {|x| x[1] = cCodtip .And. x[4] == cCodAto })) > 0
                  aCobranca[nPos][3] += TRB2->BM1_VALOR
               Else
                  Aadd(aCobranca, {cCodtip, cDesTip, TRB2->BM1_VALOR, cCodAto, TRB2->BM1_TIPO, TRB2->BM1_DESEVE})
               EndIf
				
               If TRB2->BM1_CODTIP == "101"
                  _nQtdMens++
               ElseIf TRB2->BM1_CODTIP == "103"
                 _nQtdInscr++
               EndIf
            Else
               aAcumula := {}
               cNumCon  := TRB2->BM1_CONEMP
               cVerCon  := TRB2->BM1_VERCON

               //Alimenta array com as faixas etarias
               //Quebra do contrato
               If !Empty(TRB2->BM1_CONEMP)
                  Aadd(aCobranca, {"01", "Contrato ->   " + TRB2->BM1_CONEMP + " / Versao -> " + TRB2->BM1_VERCON})
               EndIf
               
               Do While !TRB2->(Eof()) .And. (TRB2->BM1_CONEMP+TRB2->BM1_VERCON) == (cNumCon+cVerCon)
                  //Quebra do sub contrato
                  If !Empty(TRB2->BM1_SUBCON)
                     Aadd(aCobranca, {"02", "Sub Contrato ->         " + TRB2->BM1_SUBCON + " / Versao -> " + TRB2->BM1_VERSUB + " - " + Posicione("BQC",1,xFilial("BQC") + TRB2->BM1_CODINT+TRB2->BM1_CODEMP + TRB2->BM1_CONEMP+TRB2->BM1_VERCON + TRB2->BM1_SUBCON+TRB2->BM1_VERSUB, "BQC_DESCRI")})
                  EndIf
					
                  cSubCon := TRB2->BM1_SUBCON
                  cVerSub := TRB2->BM1_VERSUB
                  
                  Do While !TRB2->(Eof()) .And. (TRB2->BM1_CONEMP+TRB2->BM1_VERCON+TRB2->BM1_SUBCON+TRB2->BM1_VERSUB) == (cNumCon+cVerCon+cSubCon+cVerSub)
                     //Quebra do produto
                     If TRB2->BM1_CODTIP $ "101,102"
                        Aadd(aCobranca, {"03", "Produto ->                    " + Alltrim(TRB2->BM1_CODEVE) + " / Versao -> " + TRB2->BM1_VERCON + " - " + Posicione("BI3",1,xFilial("BI3")+TRB2->BM1_CODINT+Substr(TRB2->BM1_CODEVE,1,4), "BI3_DESCRI")})
                     ElseIf TRB2->BM1_CODTIP $ "103" //Taxa de adesao
                        Aadd(aCobranca, {"04", "Taxa de Inscricao ->"})
                     Else //Outros... Custo operacional, cartao, deb/cred, agravo
                        Aadd(aCobranca, {"04", TRB2->BM1_DESTIP + " -> "})
                     EndIf

                     cCodEve := TRB2->BM1_CODEVE
						
                     Do While !TRB2->(Eof()) .And. (TRB2->BM1_CONEMP+TRB2->BM1_VERCON+TRB2->BM1_SUBCON+TRB2->BM1_VERSUB+TRB2->BM1_CODEVE) == (cNumCon+cVerCon+cSubCon+cVerSub+cCodEve)
                        //Lancamentos por faixa etaria tem tratamento separado
                        If TRB2->BM1_CODTIP $ "101,102,103"
								   If (nPos := Ascan(aCobranca, {| x |	x[01] == "05" .And. x[03] == TRB2->BM1_VALOR .And.	x[06] == TRB2->BM1_CODINT .And. x[07] == TRB2->BM1_CODEMP .And. x[08] == TRB2->BM1_CONEMP .And. x[09] == TRB2->BM1_VERCON .And. x[10] == TRB2->BM1_SUBCON .And. x[11] == TRB2->BM1_VERSUB .And. x[04] == TRB2->BM1_IDAINI .And. x[05] == TRB2->BM1_IDAFIN })) == 0
									   //Obtem os valores de faixas, opcional e taxa de adesao, para o resumo final
                              If TRB2->BM1_CODTIP == "101"
                                 _nQtdMens  += TRB2->BM1_VALOR										
                              ElseIf TRB2->BM1_CODTIP == "102"
                                 _nQtdOpc   += TRB2->BM1_VALOR										
                              ElseIf TRB2->BM1_CODTIP == "103"
                                 _nQtdInscr += TRB2->BM1_VALOR										
                              EndIf
									
                              //Alimenta o array para impressao dos lancamentos por faixa etaria
                              Aadd(aCobranca, {"05", 1, TRB2->BM1_VALOR, TRB2->BM1_IDAINI, TRB2->BM1_IDAFIN, TRB2->BM1_CODINT, TRB2->BM1_CODEMP, TRB2->BM1_CONEMP, TRB2->BM1_VERCON, TRB2->BM1_SUBCON, TRB2->BM1_VERSUB, TRB2->BM1_CODTIP, TRB2->BM1_DESTIP})
                           Else
                              aCobranca[nPos][2] += 1									
                           EndIf
                        Else
                           //Alimenta o array para impressa do resumo final
                           If (nPos := Ascan(aCobranca, {| x |	 x[1] == "06" .And. x[12] == TRB2->BM1_CODTIP})) == 0
                              Aadd(aCobranca, {"05", 1, TRB2->BM1_VALOR, TRB2->BM1_IDAINI, TRB2->BM1_IDAFIN, TRB2->BM1_CODINT, TRB2->BM1_CODEMP, TRB2->BM1_CONEMP, TRB2->BM1_VERCON, TRB2->BM1_SUBCON, TRB2->BM1_VERSUB, TRB2->BM1_CODTIP, TRB2->BM1_DESTIP})
                           EndIf
                        EndIf

                        TRB2->(DBSkip())
                     EndDo
                  EndDo
               EndDo
            EndIf
         Else
            If mv_par19 == 1 .And. TRB2->BM1_LTOTAL == "0"
               nPos := Ascan(aUsrVlr,{|x| x[1] == TRB2->BM1_MATUSU })
               If nPos == 0
                  Aadd(aUsrVlr,{TRB2->BM1_MATUSU, TRB2->BM1_VALOR, TRB2->BM1_NOMUSR})
               Else
                  aUsrVlr[nPos,2] +=TRB2->BM1_VALOR
               EndIf
            ElseIf (mv_par19 == 2 .Or. mv_par19 == 3 ) .And. TRB2->BM1_LTOTAL == "0"
               If (nPos := Ascan(aCobranca, {|x| x[1] = TRB2->BM1_CODTIP})) > 0
                  aCobranca[nPos][3] += TRB2->BM1_VALOR
               Else
                  Aadd(aCobranca, {TRB2->BM1_CODTIP, TRB2->BM1_DESTIP, TRB2->BM1_VALOR, TRB2->BM1_ATOCOO, TRB2->BM1_TIPO, TRB2->BM1_DESEVE})
               EndIf
            EndIf
         EndIf
         TRB2->(DBSkip())
	   EndDo
	
	   For nPos := 1 To Len(aUsrVlr)
		   Aadd(aCobranca, Trans(aUsrVlr[nPos,1], pesqpict("BM1", "BM1_MATUSU") + ".!") + " - " + AllTrim(aUsrVlr[nPos,3]) + Trans(aUsrVlr[nPos,2], "@E 99,999.99"))
	   Next
	
	   aBfq := RetornaBfq(R580Imp->E1_CODINT, "199")
	                                 
	                                 
	                                 
      //Somente para pessoa juridica
      If BG9->BG9_TIPO == "2"                                
         If R580Imp->E1_IRRF > 0
            Aadd(aCobranca, {aBfq[1],aBfq[3],AllTrim(Transform(R580Imp->E1_IRRF, "@E 99,999,999.99")),"2","",""})
         EndIf
      Else
         If R580Imp->E1_IRRF > 0
            Aadd(aCobranca, {aBfq[1], aBfq[3], R580Imp->E1_IRRF, ""})                                     
         EndIf
      EndIf
	
      aDadosEmp := {BA0->BA0_NOMINT,;                                                                  //Nome da Empresa
                    BA0->BA0_END,;                                                                     //Endereço
                    AllTrim(BA0->BA0_BAIRRO) + ", " + AllTrim(BA0->BA0_CIDADE) + ", " + BA0->BA0_EST,; //Complemento
					     "CEP: " + Subs(BA0->BA0_CEP, 1, 5) + "-" + Subs(BA0->BA0_CEP, 6, 3),;              //CEP
					     "PABX/FAX: " + BA0->BA0_TELEF1,;                                                   //Telefones
                    "CNPJ.: " + Transform(BA0->BA0_CGC, "@R 99.999.999/9999-999"),;                    //CGC
                    "ANS : " + BA0->BA0_SUSEP}                                                         //I.E
	
      //Carrega mensagens de observacao
      If ExistBlock("PLR580MSGO")
         aObservacoes := ExecBlock("PLR580MSGO", .F., .F.)
      Else
         aObservacoes := PLR580TEXT(2, R580Imp->E1_CODINT,R580Imp->E1_CODEMP,R580Imp->E1_CONEMP, R580Imp->E1_SUBCON, R580Imp->E1_MATRIC, R580Imp->E1_ANOBASE + R580Imp->E1_MESBASE)
      EndIf

      //Carrega mensagens do boleto
      If ExistBlock("PLR580MSGB")
         aMsgBoleto := ExecBlock("PLR580MSGB", .F., .F.)
      Else
         aMsgBoleto := PLR580TEXT(1, R580Imp->E1_CODINT, R580Imp->E1_CODEMP, R580Imp->E1_CONEMP, R580Imp->E1_SUBCON, R580Imp->E1_MATRIC, R580Imp->E1_ANOBASE + R580Imp->E1_MESBASE)
      EndIf
	
      //Carrega mensagens do boleto
      If ExistBlock("PLR580MSGC")
         aMsgCorpo := ExecBlock("PLR580MSGC", .F., .F.)
      Else
         aMsgCorpo := PLR580TEXT(5, R580Imp->E1_CODINT, R580Imp->E1_CODEMP, R580Imp->E1_CONEMP, R580Imp->E1_SUBCON, R580Imp->E1_MATRIC, R580Imp->E1_ANOBASE + R580Imp->E1_MESBASE, AllTrim(BA3->BA3_MODPAG), BG9->BG9_TIPO)
      EndIf

      //Caso nao exita o banco e agencia no SE1 busca informacoes do SEA.
      If ((Empty(R580Imp->E1_PORTADO) .Or. Empty(R580Imp->E1_AGEDEP)) .And. !Empty(R580Imp->E1_NUMBOR))
         SEA->(DBSeek(xFilial("SEA") + R580Imp->E1_NUMBOR + cPrefixo + cTitulo + cParcela + cTipo))
         cSA6Key := SEA->EA_PORTADO+SEA->EA_AGEDEP+SEA->EA_NUMCON
      ElseIf !Empty(R580Imp->E1_PORTADO) .AND. !Empty(R580Imp->E1_AGEDEP)
         cSA6Key := R580Imp->E1_PORTADO+R580Imp->E1_AGEDEP+R580Imp->E1_CONTA
      EndIf

      //Dados do Titulo	
      aDadosTit := {AllTrim(SE1->E1_PREFIXO) + AllTrim(SE1->E1_NUM) + AllTrim(SE1->E1_PARCELA),; //Numero do título
                    SE1->E1_EMISSAO,;                                                            //Data da emissão do título
                    SE1->E1_EMIS1,;                                                              //Data da emissão do boleto
                    SE1->E1_VENCTO,;                                                             //Data do vencimento
                    SE1->E1_SALDO,; 				                                            //Valor do título
                    SE1->E1_NUMBCO,;                                                             //Nosso numero (Ver fórmula para calculo)
                    SE1->E1_ANOBASE + "/" + SE1->E1_MESBASE}                                     //Valor do título

      SE1->(RecLock("SE1", .F.))
      SE1->E1_NUMTPGR := cNumNF
      SE1->(MsUnlock())
      
      cNumNF := StrZero(cTon(cNumNF, 10) + 1, 6)
      
      //Dados Sacado
      aDatSacado := {AllTrim(SA1->A1_NOME),;                                                                                                    //Razao Social
                     AllTrim(SA1->A1_COD),;                                                                                                     //Codigo
                     AllTrim(SA1->A1_END),;                                                                                                     //Endereco	
                     Alltrim(SA1->A1_BAIRRO),;                                                                                                  //Endereco
                     AllTrim(SA1->A1_MUN),;                                                                                                     //Cidade
                     SA1->A1_EST,;                                                                                                              //Estado
                     Transform(SA1->A1_CEP, "@R 99999-999"),;                                                                                   //CEP
                     If(Len(SA1->A1_CGC) == 11, Transform(SA1->A1_CGC, "@R 999.999.999-99"), Transform(SA1->A1_CGC, "@R 99.999.999/9999-99")),; //CGC
                     SA1->A1_INSCR}	                                                                                                            //BAIRRO

      R580Txt02(aCobranca, aDadosTit, aDatSacado, aOpenMonth, aDependentes, aObservacoes, aMsgCorpo)

      TRB2->( dbCloseArea() )
      R580Imp->(DbSkip())
   EndDo

   R580Imp->(DbCloseArea())
   
   DBSelectArea("SX6")
   SX6->(DBSetOrder(1))
   If SX6->(DBSeek(xFilial("SX6")+"MV_YNUMTIP"))
	   SX6->(RecLock("SX6", .F.))
	   SX6->X6_CONTEUD := cNumNF
	   SX6->(MsUnLock())
   EndIf

   SET DEVICE TO SCREEN
   //Se impressao em disco, chama o gerenciador de impressao
   If aReturn[5]==1
      dbCommitAll()
      SET PRINTER TO
      OurSpool(cRel)
   EndIf

   MS_FLUSH()
Return(.T.)

//Data     : 02/04/04
//Autor    : Rafael M. Quadrotti
//Descricao: Retorna os meses em aberto do sacado.
*********************************************************************
Static Function PLR580MES(cCliente, cLoja, cMesBase, cAnoBase, cTipo)
*********************************************************************
   Local aMeses   := {}                         //Retorno da funcao.
   Local cSQL     := ""
   Local cSE1Name := SE1->(RetSQLName("SE1"))	//retorna o alias no TOP.

   SE1->(DBSetOrder(1))

   cSQL := "SELECT E1_CLIENTE, E1_LOJA, E1_MESBASE, E1_ANOBASE FROM " + cSE1Name
   cSQL += " WHERE E1_FILIAL = '" + xFilial("SE1") + "' AND "
   cSQL += " E1_CLIENTE + E1_LOJA = '" + cCliente + cLoja + "' AND "
   cSQL += " E1_SALDO > 0 AND "
   cSQL += " E1_PARCELA <> '" + StrZero(0, Len(SE1->E1_PARCELA)) + "' AND "
   cSql += " E1_TIPO = '" + cTipo + "' AND "
   cSQL += cSE1Name + ".D_E_L_E_T_ = '' "
   cSQL += "ORDER BY " + SE1->(IndexKey())

   PLSQuery(cSQL, "Meses")

   If Meses->(Eof())
      Meses->(DBCloseArea())
      Aadd(aMeses, "")
   Else
	   Do While Meses->(!Eof()) .And. Meses->E1_CLIENTE == cCliente .And. Meses->E1_LOJA == cLoja
         If cMesBase <> E1_MESBASE .And. cAnoBase <> E1_ANOBASE
            Aadd(aMeses, E1_MESBASE + "/" + E1_ANOBASE)
         EndIf
         Meses->(DbSkip())
      EndDo
   EndIf
   Meses->(DBCloseArea())
Return(aMeses)

//Data     : 02/04/04
//Autor    : Rafael M. Quadrotti
//Descricao: Retorna as mensagens para impressao.
//           Esta funcao executa uma selecao em tres tabelas para 
//           encontrar a msg relacionada ao sacado.
*******************************************************************************************************
Static Function PLR580TEXT(nTipo, cCodInt, cCodEmp, cConEmp, cSubCon, cMatric, cBase, cModPag, cTipoUS)
*******************************************************************************************************
   Local cQuery	:= cNTable1 := cNTable2 := cNTable3 := ""
   Local aMsg     := {} // Array de mensagens

   DBSelectArea("BH1")
   DBSetOrder(2)
   
   cNTable1 := RetSqlName("BH1")
   cNTable2 := RetSqlName("BA3")
   cNTable3 := RetSqlName("BH2")

   cQuery := "SELECT BH2.BH2_MSG01 FROM " + cNTable1 + " BH1, " + cNTable3 + " BH2 "
   cQuery += "WHERE BH1.BH1_FILIAL='" + xFilial("BH1") + "' AND "
   cQuery += "BH1.BH1_CODINT='" + cCodInt + "' AND "
   cQuery += "BH1.BH1_TIPO='" + Transform(nTipo, "9") + "' AND "

   If !Empty(cCodEmp)
      cQuery += "'" + cCodEmp + "' BETWEEN BH1.BH1_EMPDE AND BH1.BH1_EMPATE AND "
   EndIf

   If !Empty(cConEmp)
      cQuery += "'" + cConEmp + "' BETWEEN BH1.BH1_CONDE AND BH1.BH1_CONATE AND "
   EndIf

   If !Empty(cSubCon)
      cQuery += "'" + cSuBCon + "' BETWEEN BH1.BH1_SUBDE AND BH1.BH1_SUBATE AND "
   EndIf
   
   If !Empty(cMatric)
      cQuery += "'" + cMatric + "' BETWEEN BH1.BH1_MATDE AND BH1.BH1_MATATE AND "
   EndIf

   If !Empty(cBase)
      cQuery += "'" + cBase + "' BETWEEN BH1.BH1_BASEIN AND BH1.BH1_BASEFI AND "
   EndIf

   //Exclusivo para cooperativa medica
   If nTipo == 5
	   cQuery += "(BH1_MODPAG = '" + cModPag + "' OR BH1_MODPAG = '3') AND "
	   cQuery += "(BH1_TIPCON = '" + cTipoUS + "' OR BH1_TIPCON = '3') AND "
   EndIf

   //BH2 MENSAGENS PARA IMPRESSAO
   cQuery += " BH2.BH2_FILIAL = '" + xFilial("BH2") + "' AND "
   cQuery += " BH2.BH2_CODIGO = BH1.BH1_CODIGO AND "
   cQuery += " BH1.D_E_L_E_T_<>'*' AND BH2.D_E_L_E_T_<>'*' "
   cQuery += "ORDER BY " + BH1->(IndexKey())

   PLSQuery(cQuery, "MSG")

   If MSG->(Eof())
	   Aadd(aMSG, "")
   Else
	   Do While MSG->(!Eof())
         Aadd(aMSG,MSG->BH2_MSG01)
         MSG->(DbSkip())
      End      
   EndIf
   MSG->(DBCloseArea())

Return(aMsg)


//Data     : 08/11/04
//Autor    : Otacilio A.  Junior
//Descricao: Imprime Boleto em modo texto.
**************************************************************************************************************
Static Function R580Txt02(aCobranca, aDadosTit, aDatSacado,	aOpenMonth, aDependentes, aObservacoes, aMsgCorpo)
**************************************************************************************************************
   
Local nCnt := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
   
   Local bPrn1

   Local cPrn1		:= ""		// String com informacoes de cobranca para impresao
Local cPrn2		:= ""		// String com informacoes de cobranca para impresao
Local cAuxTxt	:= ""		// String auxiliar para formar a descricao do evento de faturamento.
Local nColuna	:= 1		// Contador para colunas
Local nLimCol	:= 0		// Limite de linhas por coluna do boleto!
Local nLinCon	:= 0		// Contador de linhas
LOCAL nControl 	:= 0		// Controle de linhas impressas no corpo do boleto
LOCAL nContAux	:= 0 		// Controle de linhas impressas no corpo do boleto

Local i 		:= 0    	// Contador
Local nMosCob 	:= 0		// Contador para for
Local nCobra 	:= 0		// Contador para cobranca
Local nI		:= 0		// Contador do laco para impressao de dependentes.
Local nMsg      := 0    	// Contador para as mensagens
Local nResto	:= 0
Local lMsg		:= .F.
Local aResumo   := {}
Local lPulaLinha:= .F.
Local lDividePag:= .F.
Local nCtImp	:= 0
Local nTotFat	:= 0
Local nContLn	:= 0


// Variaveis totalizadoras...
Private _nMensalidade 	:= 0
Private _nOpcionais 	:= 0
Private _nInscricao 	:= 0
Private _nTamanho		:= 0


For nCnt := 1 To Len(aCobranca)
	
	If aCobranca[nCnt][1] $ '05,06'
		If (nPos := Ascan(aResumo, {|x| x[1] == aCobranca[nCnt][12] } ) ) == 0
			Aadd(aResumo,{ aCobranca[nCnt][12], aCobranca[nCnt][13], aCobranca[nCnt][2], aCobranca[nCnt][3] })
		Else
			aResumo[nPos][3] +=  aCobranca[nCnt][2]
			aResumo[nPos][4] +=  (aCobranca[nCnt][2] * aCobranca[nCnt][3])
		Endif
		
		If aCobranca[nCnt][1] == '05'
			_nTamanho++
		Endif
	Endif
Next

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Corpo do boleto...                                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If (Alltrim(BA3->BA3_MODPAG) == '1' .and. mv_par19 <> 3) .or. Alltrim(BA3->BA3_MODPAG) <> '1'
    If nLinha != 02   //Alterado por gedilson, valor antigo 04
        nLinha := 02  //Alterado por gedilson, valor antigo 04
    Endif          	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Imprime os itens do Ato Cooperado principal...(Servicos medicos) ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	For nCnt := 1 To  Len(aCobranca)
       
		If aCobranca[nCnt][1] == "101"
			_nMensalidade += aCobranca[nCnt][3]
			
		Elseif aCobranca[nCnt][1] == "102"
			_nOpcionais   += aCobranca[nCnt][3]
			
		Elseif aCobranca[nCnt][1] == "103"
			_nInscricao   += aCobranca[nCnt][3]

		Endif
		
		If aCobranca[nCnt][4] <> '2' //.or. aCobranca[nCnt][4] <> '1' //Incluido por gedilson
			Loop
		Endif                                          
		
		If AllTrim(aCobranca[nCnt][1]) $ DEB_CRED
			cAuxTxt := AllTrim(aCobranca[nCnt][6])
		Else
			cAuxTxt := AllTrim(aCobranca[nCnt][2])
		Endif                    
		
		nImposto := AT("IMPOSTO",UPPER(aCobranca[nCnt][2]))
		If nImposto == 0
			cPrn1 := cAuxTxt
			cPrn2 :=  Trans(aCobranca[nCnt][3], "@E 999,999.99")  
			@ nLinha, 010 PSay AllTrim(aCobranca[nCnt][1])//chr(18)
			@ nLinha, 018 PSay cPrn1   // Descricao do Servico
			@ nLinha, 120 PSay cPrn2   // Valor do Servico
			nCtImp++
			nLinha ++ 
	    	nTotFat += aCobranca[nCnt][3]         
	    EndIf
	Next                            
             
    nLinha := nLinha + 10
    //Carrega Array com valores de impostos se for PJ
     
    If R580Imp->E1_IRRF > 0
    	@ nLinha, 010 PSay "Imposto de Renda:"
		@ nLinha, 040 PSay AllTrim(Transform(R580IMP->E1_IRRF,"@E 99,999,999.99"))
    	nLinha ++
    	nContLn ++
    EndIf
    
    If R580IMP->E1_ISS > 0
		@ nLinha, 010 PSay "ISS:"
		@ nLinha, 040 Psay AllTrim(Transform(R580IMP->E1_ISS,"@E 99,999,999.99"))
		nContLn ++
	EndIf
		 
    If R580IMP->E1_CSLL > 0
		@ nLinha, 010 PSay "CSLL:"
		@ nLinha, 040 Psay AllTrim(Transform(R580IMP->E1_CSLL,"@E 99,999,999.99"))
		nLinha ++
		nContLn ++
	EndIf	                    
	
    If R580IMP->E1_COFINS > 0
		@ nLinha, 010 PSay "COFINS:"
		@ nLinha, 040 Psay AllTrim(Transform(R580IMP->E1_COFINS,"@E 99,999,999.99"))
		nLinha ++
		nContLn ++
	EndIf                                                                              
	
    If R580IMP->E1_PIS > 0
		@ nLinha, 010 PSay "PIS:"
		@ nLinha, 040 PSay AllTrim(Transform(R580IMP->E1_PIS,"@E 99,999,999.99"))
		nLinha ++
		nContLn ++
	EndIf
		
		nLinha := nLinha - (10+nContLn)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Imprime os itens do Ato Cooperado Acessorio...(Servico Acessorio)      ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	For nCnt := 1 To  Len(aCobranca)
		If !(aCobranca[nCnt][4] $ '0, ')
			Loop
		Endif                                                        

		If AllTrim(aCobranca[nCnt][1]) $ DEB_CRED
			cAuxTxt := AllTrim(aCobranca[nCnt][6])
		Else
			cAuxTxt := AllTrim(aCobranca[nCnt][2])
		Endif
		@ nLinha, 010 PSay aCobranca[nCnt][1]//+"-"		
		@ nLinha, 017 PSay cAuxTxt				// Codigo e Descricao do servico

//		@ nLinha, 004 PSay aCobranca[nCnt][1]		// Codigo de cobrança
		If aCobranca[nCnt][1] == "101"			// Quantidade de Mensalidades
			//Aeval(_aQtdMens, {|x| _nQtdMens += Iif((x[1] = aDadosTit[1] ) , 1, 0)} )
			//@ nLinha, 000 PSay _nQtdMens	Picture "@E 9,999,999"
			@ nLinha, 070 PSay _nQtdMens	Picture "@E 9,999,999"    //TESTE
			_nQtdMens := 0
		Elseif aCobranca[nCnt][1] == "102"		// Quantidade de Opcionais
			//@ nLinha, 000 PSay _nQtdOpc		Picture "@E 9,999,999"    
			@ nLinha, 070 PSay _nQtdOpc		Picture "@E 9,999,999"	  //TESTE		
		Elseif aCobranca[nCnt][1] == "103"		// Quantidade de Inscricoes
			//@ nLinha, 000 PSay _nQtdInscr	Picture "@E 9,999,999"   
			@ nLinha, 070 PSay _nQtdInscr	Picture "@E 9,999,999"	  //TESTE		
		EndIf                                                                   
		
		//@ nLinha, 070 PSay aCobranca[nCnt][3] picture "@E 999,999.99"	// Valor do Servico
        @ nLinha, 120 PSay aCobranca[nCnt][3] picture "@E 999,999.99"	// Valor do Servico		//TESTE		

		nCtImp++
		nLinha ++
	 /*
		If aCobranca[nCnt][5] == '1'
			nTotFat += aCobranca[nCnt][3]
		Else
			nTotFat -= aCobranca[nCnt][3]
		Endif
	*/	
	
		nTotFat += aCobranca[nCnt][3]
	
	Next
	
	If !Empty(MV_PAR21) .OR. !Empty(MV_PAR22).OR. !Empty(MV_PAR23)
		@ nLinha, 017 PSay MV_PAR21
		nLinha++
		@ nLinha, 017 PSay MV_PAR22
		nLinha++
		@ nLinha, 017 PSay MV_PAR23	
	EndIf
Else 
	@ nLinha, 000 PSay chr(15)
	For nCnt := 1 To Len(aCobranca)
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Variavel que controla aquantidade de itens do array que ja foram impressas  |
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		nContAux ++
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Imprime contrato...                                              ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If aCobranca[nCnt][1]=='01'
			@ nLinha, 000 PSay chr(15)
			@ nLinha, 001 PSay aCobranca[nCnt][2]
			nCtImp++
			nLinha ++
		Endif
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Imprime sub contrato...                                          ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If aCobranca[nCnt][1]=='02'
			@ nLinha, 000 PSay chr(15)
			@ nLinha, 001 PSay aCobranca[nCnt][2]
			nCtImp++
			nLinha ++
		Endif
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Imprime Produto ou a taxa de adesao...                           ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If aCobranca[nCnt][1]=='03' .or. aCobranca[nCnt][1]=='04'
			@ nLinha, 000 PSay chr(15)
			@ nLinha, 001 PSay aCobranca[nCnt][2]
			nCtImp++
			nLinha ++
		Endif
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Imprime o detalhamento por faixa etaria...                       ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If aCobranca[nCnt][1] == '05'  
			If nContAux < Len(aCobranca)
				For i := nCnt To Len(aCobranca)
					If aCobranca[i][1] <> '05'
						nCtImp++
						nLinha ++
						nCnt := (i-1)
						Exit
					Endif
					
					If aCobranca[i][12] $ '101,102,103'
						@ nLinha, 000 PSay chr(18)
						@ nLinha, 001 PSay "Faixa de "+StrZero(aCobranca[i][4],3)+" a "+;
						StrZero(aCobranca[i][5],3)+"     -   "+;
						Transform(aCobranca[i][2], "@E 999999")+"      x   "+;
						Transform(aCobranca[i][3], "@E 999,999.99")+"      =   "+;
						Transform((aCobranca[i][3]*aCobranca[i][2]),"@E 999,999.99")
					Endif
					nCtImp++
					nLinha ++
					nContAux ++
				Next
			EndIf	
		Endif
	Next
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Imprime resumo da cobranca... 
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	nLinha ++
	For nCnt := 1 To Len(aResumo)
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Imprime a linha do resumo!                                            ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		@ nLinha, 001 PSay Left(aResumo[nCnt][2],30)
		@ nLinha, 030 PSay "   -   "+Transform(aResumo[nCnt][3], "@E 999999")
		@ nLinha, 043 PSay Transform(aResumo[nCnt][4],"@E 999,999.99")
		nCtImp++
		nLinha ++
		nContAux ++
	Next
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Imprime as mensagens do corpo do boleto...                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//nLinha:= 25
For nCnt := 1 To Len(aMsgCorpo)
	If ! Empty(aMsgCorpo[nCnt])
		cPrn1 := "{ ||"+aMsgCorpo[nCnt]+" }"
		bPrn1 := &cPrn1
		@ nLinha, 000 PSay Chr(15)
		@ nLinha, 001 PSay Eval(bPrn1)  // Texto totallizador
		@ nLinha, 080 PSay Chr(18)
		nCtImp++
		nLinha++
		lMsg:= .T.
	Endif
Next

// Ajusta o formulario para a impressao da proxima linha
//nLinha = 3+(nLinha-13)
nLinha += (15-nCtImp) 
nLinha += 9   //TESTE
nTotFat := SE1->E1_VALOR
@ nLinha,120 PSay Transform(nTotFat, "@E 999,999.99")
nLinha += 6
lMsg:= .F.               

// Impressao dos dados do sacado             
@ nLinha, 115 PSAY SE1->E1_EMISSAO
nLinha+=6
@ nLinha, 031 PSay substr(aDadosTit[1],4,9) // Nr. do documento (sem prefixo e parcela)
@ nLinha, 049 PSay AllTrim(Transform(aDadosTit[5],"@E 99,999,999.99")) //"Valor R$"
@ nLinha, 070 PSay substr(aDadosTit[1],4,9) //"Nro.do Documento"
@ nLinha, 090 PSay DTOC(aDadosTit[4])		// Vencimento
//@ nLinha, 115 PSay aDadosTit[7]				// Ano / Mes
nLinha += 05
@ nLinha, 045 PSay aDatSacado[1]			// Sacado
//@ nLinha, 104 PSay R580Imp->E1_CODEMP		// Numero Contrato
nLinha ++
@ nLinha, 045 PSay aDatSacado[3] 			//ENDERECO    
@ nLinha, 086 PSay aDatSacado[4]			//BAIRRO
nLinha++
@ nLinha, 045 PSay aDatSacado[5] 			//CIDADE    
@ nLinha, 090 PSay aDatSacado[6]			//ESTADO
//@ nLinha, 090 PSay aDatSacado[7]			//CEP
nLinha++
_cMunc	:=	IIf(Empty(SA1->A1_MUNC),SA1->A1_MUN, SA1->A1_MUNC)
_cEstc	:=	IIf(Empty(SA1->A1_ESTC),SA1->A1_EST, SA1->A1_ESTC)
_cCepc	:=	IIf(Empty(SA1->A1_CEPC),SA1->A1_CEP, SA1->A1_CEPC)
@ nLinha, 045 PSay _cMunc +" - "+ _cEstc +" - "+ TransForm(_cCepc,"@R 99999-999") //Praca de Pagto.
nLinha++              
@ nLinha, 045 PSay aDatSacado[8]			// CGC
@ nLinha, 108 PSay IIf(Empty(aDatSacado[9]),'ISENTO',aDatSacado[9])			// I.E.
nLinha+=2
@ nLinha,045 PSay Subs(Alltrim(SUBS(EXTENSO(aDadosTit[5]),001,069)) + REPLICATE("*",100),1,069)
nLinha++
@ nLinha,045 PSay Subs(Alltrim(SUBS(EXTENSO(aDadosTit[5]),070,069)) + REPLICATE("*",100),1,069)
nLinha++
@ nlinha,045 PSay Subs(Alltrim(SUBS(EXTENSO(aDadosTit[5]),139,069)) + REPLICATE("*",100),1,069)

// Calcula 80 % + 20 % -- Altamiro	
nLinha++ 
nLinha++
     
 @ nLinha,45 PSay "* * * * * * *   A T E N Ç Ã O   * * * * * * * *"    
   nLinha++        
   nLinha++                                                   
 @ nLinha,45 PSay " Redução da Base (80%) ----> " +  Transform((nTotFat*0.8), "@E 999,999.99")   
   nLinha++    
   nLinha++                                                       
 @ nLinha,45 PSay " Base Reduzida  (20%)  ----> " +  Transform((nTotFat*0.2), "@E 999,999.99")   
   nLinha++   
   nLinha++    
   nLinha++                                                       
 @ nLinha,45 PSay " VAL APROX DOS TRIBUTOS R$ " + Transform((nTotFat*0.163), "@E 999,999.99") + " (16.3%) "      
   nLinha++  
 @ nLinha,45 PSay "* * * * * * * * * * * * * * * * * * * * * * * *  "    
///////////////////

//nLinha += 15
nLinha += 3

Return(NIL)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFun‡„o    ³gera PPG  º Autor ³ AP6 IDE            º Data ³  27/05/03   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescri‡„o ³ Funcao auxiliar chamada pela RPTSTATUS. A funcao RPTSTATUS º±±
±±º          ³ monta a janela com a regua de processamento.               º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Programa principal                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function RunPPG(_cCodEmp)

Local nFor := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

Private nOrdem    
Private cBA1Name := RetSQLName("BA1")
Private cBI3Name := RetSQLName("BI3")

aPlanos:= {}  
nValor:= 0
nRetr := 0
nInc  := 0
nUsu  := 0

dbSelectArea("BA1")
dbSetOrder(1)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Faz filtro no arquivo...                                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

cSQL := " SELECT BA1_CODINT, BA1_CODEMP, BA1_MATRIC, BA1_TIPREG, BA1_DIGITO, BA1_CODPLA, BI3_MODPAG "
cSQL += " FROM "+cBA1Name+", "+cBI3Name
cSQL += " WHERE BA1_FILIAL = '"+xFilial("BA1")+"' AND "
cSQL += " BI3_FILIAL = '"+xFilial("BI3")+"' AND "
cSQL += " BA1_CODPLA = BI3_CODIGO AND "
cSQL += " BA1_VERSAO = BI3_VERSAO AND "
cSQL += " BA1_CODEMP ='"+_cCodEmp+"' AND "
cSQL += " BA1_MOTBLO ='   ' AND "
cSQL += cBA1Name+".D_E_L_E_T_ = ' ' AND "
cSQL += cBI3Name+".D_E_L_E_T_ = ' '"
cSQL += " Order by BA1_CODEMP, BA1_MATRIC, BA1_CODPLA, BA1_VERSAO"
PLSQuery(cSQL,"TA1")
TA1->(Dbgotop())

cMatric1:= TA1->BA1_CODINT+TA1->BA1_CODEMP+TA1->BA1_MATRIC
While !TA1->(Eof())
	
	If AllTrim(TA1->BI3_MODPAG) == "1"
		// busco valor do usuario
		cMatric:= Alltrim(TA1->BA1_CODINT)+Alltrim(TA1->BA1_CODEMP)+Alltrim(TA1->BA1_MATRIC)
		cAno   := "20"+substr(dtoc(ddatabase),07,02)
		cMes   := substr(dtoc(ddatabase),04,02)
		nMesUsr:= 0
		// Pesquiso Retroativo 
		DbSelectArea("BM1")
		DbSetOrder(1)

      //If !DbSeek(xFilial("BM1")+TA1->BA1_CODINT+TA1->BA1_CODEMP+TA1->BA1_MATRIC+cAno+cMes)
 		If !DbSeek(xFilial("BM1")+TA1->BA1_CODINT+TA1->BA1_CODEMP+TA1->BA1_MATRIC+cAno+cMes+TA1->BA1_TIPREG)
 		
 			aValor := PLSVLRFAM(cMatric,cAno,cMes)[2]
			If type("aValor[2]") = "A"
				For nFor := 1 to Len(aValor[2])
					If aValor[2,nFor,7] == TA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO) .And. aValor[2,nFor,9]
						If aValor[2,nFor,3] == "103"
							nInsUsr += aValor[2,nFor,2]
						Else
							nMesUsr += aValor[2,nFor,2] // mensalidade do usr
							If nFor > 1
								If  aValor[2,nFor,7] == aValor[2,(nFor-1),7]  // Retroativo
									If (nPos := Ascan(aPlanos, {|x| x[1]+ x[5] == TA1->BA1_CODPLA+nMesuSr } ) ) == 0
										Aadd(aPlanos, {TA1->BA1_CODPLA,nInc,1,1,nValor})
									Else
										aPlanos[nPos,3]++
										aPlanos[nPos,4]++
									EndIf
								Endif
							EndIf
						Endif
					EndIf
				Next
			Else
				nMesUsr := 0
			EndIf

			If nMesUsr = 0 //inclusao
				nValor := nMesUsr
				If (nPos := Ascan(aPlanos, {|x| x[1]+ Str(x[5]) == TA1->BA1_CODPLA+Str(BM1->BM1_VALOR) } ) ) == 0
					nInc++
					Aadd(aPlanos, {TA1->BA1_CODPLA,1,1,nRetr,nValor})
				Else
					aPlanos[nPos,2]++
					aPlanos[nPos,3]++
				EndIf
			Else // Ususario antigo
				nValor := nMesUsr
				If (nPos := Ascan(aPlanos, {|x| x[1]+ Str(x[5]) == TA1->BA1_CODPLA+Str(BM1->BM1_VALOR) } ) ) == 0
					Aadd(aPlanos,{TA1->BA1_CODPLA,nInc,1,nRetr,nValor})
				Else
					aPlanos[nPos,3]++
				EndIf
			EndIf
		Else	// Ususario antigo 
			// Pesquisa executada em BM1 para localizar o valor correto do usuario
			// Claudio 22/06/05
			
			
			nValor := BM1->BM1_VALOR
			If (nPos := Ascan(aPlanos, {|x| x[1]+ Str(x[5]) == TA1->BA1_CODPLA+Str(BM1->BM1_VALOR) } ) ) == 0
				Aadd(aPlanos, {TA1->BA1_CODPLA,nInc,1,nRetr,nValor})
			Else
				aPlanos[nPos,3]++
			EndIf
		EndIf
    EndIf
	TA1->(DbSkip())
End                 

TA1->(DbCloseArea())

Return()

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³GrvPlano  º Autor ³ Claudio Manoel     º Data ³  22/06/05    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescri‡„o ³ Funcao de verificacao da existencia dos parametros a serem  º±±
±±º          ³ informados                                                  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³                                                             º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
/*
Static Function grvplano(xPrefixo, xNum, xParcela, xPlanos)

for n := 1 to len(xPlano)
	if reclock("SZF",.T.)   
		SZF->ZF_YPREF	:= xPrefixo
		SZF->ZF_YNUM	:= xNum
		SZF->ZF_YPARC	:= xParc		
		SZF->ZF_YPLANO	:= xPlanos[n][1]	//caractere
		SZF->ZF_YINCL	:= xPlanos[n][2]	//numerico, 3 pos.
		SZF->ZF_YUSU	:= xPlanos[n][3]	//numerico, 3 pos.
		SZF->ZF_YRETRO	:= xPlanos[n][4]	//numerico, 3 pos.
		SZF->ZF_VALOR	:= xPlanos[n][5]	//numerico, 13 pos. 2 dec.
		dbunlock()
	EndIf   
next
return(.t.)
*/
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³ValidPeg  º Autor ³ Claudio Manoel     º Data ³  17/06/05    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescri‡„o ³ Funcao de verificacao da existencia dos parametros a serem  º±±
±±º          ³ informados                                                  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³                                                             º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function ValidPerg()

Local i := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
Local j := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ mv_par01    Da Data de Emissao                               ³
//³ mv_par02    Ate a data de Emissao                            ³
//³ mv_par03    Local a ser gerado o Arquivo                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

_sAlias := Alias()
cPerg   := PADR(cPerg,10)
aRegs   :={}
dbSelectArea("SX1")
dbSetOrder(1)
// Grupo/Ordem/Pergunta/Variavel/Tipo/Tamanho/Decimal/Presel/GSC/Valid/Var01/Def01/Cnt01/Var02/Def02/Cnt02/Var03/Def03/Cnt03/Var04/Def04/Cnt04/Var05/Def05/Cnt05

aAdd(aRegs,{cPerg,"01","Cliente de         ?","","","mv_ch1","C",6,0,0,"G","","mv_par01","","","","000390","","","","","","","","","","","","","","","","","","","","","SA1","","",""})
aAdd(aRegs,{cPerg,"02","Loja               ?","","","mv_ch2","C",2,0,0,"G","","mv_par02","","","","01","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"03","Cliente ate        ?","","","mv_ch3","C",6,0,0,"G","","mv_par03","","","","000390","","","","","","","","","","","","","","","","","","","","","SA1","","",""})
aAdd(aRegs,{cPerg,"04","Loja               ?","","","mv_ch4","C",2,0,0,"G","","mv_par04","","","","ZZ","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"05","Operadora de       ?","","","mv_ch5","C",4,0,0,"G","","mv_par05","","","","0055","","","","","","","","","","","","","","","","","","","","","B89","","",""})
aAdd(aRegs,{cPerg,"06","Operadora ate      ?","","","mv_ch6","C",4,0,0,"G","","mv_par06","","","","0055","","","","","","","","","","","","","","","","","","","","","B89","","",""})
aAdd(aRegs,{cPerg,"07","Empresa de         ?","","","mv_ch7","C",4,0,0,"G","","mv_par07","","","","0966","","","","","","","","","","","","","","","","","","","","","B7A","","",""})
aAdd(aRegs,{cPerg,"08","Empresa Ate        ?","","","mv_ch8","C",4,0,0,"G","","mv_par08","","","","0966","","","","","","","","","","","","","","","","","","","","","B7A","","",""})
aAdd(aRegs,{cPerg,"09","Contrato De        ?","","","mv_ch9","C",12,0,0,"G","","mv_par09","","","","","","","","","","","","","","","","","","","","","","","","","B7B","","",""})
aAdd(aRegs,{cPerg,"10","Contrato Ate       ?","","","mv_cha","C",12,0,0,"G","","mv_par10","","","","ZZZZZZZZZZZZ","","","","","","","","","","","","","","","","","","","","","B7B","","",""})
aAdd(aRegs,{cPerg,"11","Sub-Contrato De    ?","","","mv_chb","C",9,0,0,"G","","mv_par11","","","","","","","","","","","","","","","","","","","","","","","","","B7C","","",""})
aAdd(aRegs,{cPerg,"12","Sub-Contrato Ate   ?","","","mv_chc","C",9,0,0,"G","","mv_par12","","","","ZZZZZZZZZ","","","","","","","","","","","","","","","","","","","","","B7C","","",""})
aAdd(aRegs,{cPerg,"13","Matricula De       ?","","","mv_chd","C",6,0,0,"G","","mv_par13","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"14","Matricula Ate      ?","","","mv_che","C",6,0,0,"G","","mv_par14","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"15","Mes Base Inicial   ?","","","mv_chf","C",2,0,0,"G","","mv_par15","","","","05","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"16","Ano Base           ?","","","mv_chg","C",4,0,0,"G","","mv_par16","","","","2005","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"17","Mes Base Final     ?","","","mv_chh","C",2,0,0,"G","","mv_par17","","","","12","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"18","Ano Base           ?","","","mv_chi","C",4,0,0,"G","","mv_par18","","","","2005","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"19","Detalha Cobranca   ?","","","mv_chj","N",1,0,1,"C","","mv_par19","Por Usuario","","","","","P/Tipo Cobranca","","","","","P/Faixa Etaria","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"20","Cobra Segunda via  ?","","","mv_chl","N",2,0,1,"C","","mv_par20","Nao","","","","","Sim","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"21","Observacoes 1      ?","","","mv_chm","C",30,0,0,"G","","mv_par21","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"22","Observacoes 2      ?","","","mv_chn","C",30,0,0,"G","","mv_par22","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"23","Observacoes 3      ?","","","mv_cho","C",30,0,0,"G","","mv_par23","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"24","Aglutina Lanctos   ?","","","mv_chp","N",02,0,1,"C","","mv_par24","Nao","","","","","Sim","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"25","Lancto Aglut.      ?","","","mv_chq","C",03,0,0,"G","","mv_par25","","","","","","","","","","","","","","","","","","","","","","","","","BFR","","",""})
aAdd(aRegs,{cPerg,"26","Prefixo De         ?","","","mv_chr","C",03,0,1,"G","","mv_par26","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"27","Prefixo Ate        ?","","","mv_chs","C",03,0,0,"G","","mv_par27","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"28","Numero De          ?","","","mv_cht","C",09,0,1,"G","","mv_par28","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"29","Numero Ate         ?","","","mv_chu","C",09,0,0,"G","","mv_par29","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"30","Parcela De         ?","","","mv_chv","C",01,0,1,"G","","mv_par30","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"31","Parcela Ate        ?","","","mv_chw","C",01,0,0,"G","","mv_par31","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"32","Tipo De            ?","","","mv_chx","C",03,0,1,"G","","mv_par32","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"33","Tipo Ate           ?","","","mv_chy","C",03,0,0,"G","","mv_par33","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})

for i:=1 to Len(aRegs)
	If !dbSeek(cPerg+aRegs[i,2])
		RecLock("SX1",.T.)
		For j:=1 to FCount()
			If j <= Len(aRegs[i])
				FieldPut(j,aRegs[i,j])
			EndIf
		Next
		MsUnLock()
	EndIf
Next

dbSelectArea(_sAlias)
Return

//Alterado : 05/11/08
//Autor    : Luiz Alves Felizardo (Korus Consultoria)
//Descricao: Captura de número tipográfico da NF
Static Function fNumNF()
   Local oDlg01
   Local lRet  := .F.
   
   oDlg01 := MSdialog():New(000, 000, 070, 200, "Número Tipográfico",,,,,,,,, .T.)

      oSayNum := TSay():New(007, 007, {|| "Número"}, oDlg01,,,,,, .T.,,, 40, 10)
      oGetNum := TGet():New((oSayNum:nTop / 2) - 3, oSayNum:nRight / 2, bSetGet(cNumNF), oDlg01, 50, 10, "@!", {|| !Empty(cNumNF)},,,,,, .T.,,, {|| .T.},,,, .F.,,, "cNumNF")
      oBtnOk  := TBtnBmp2():New(040, oDlg01:nClientWidth - 70, 50, 30, "OK_MDI",,,, {|| lRet := !Empty(cNumNF), oDlg01:End()}, oDlg01,, {|| .T.}, .T., .T.)
         oBtnOk:cCaption := " Ok"
   
   oDlg01:Activate(,,, .T.)
   
   DBSelectArea("SE1")
   SE1->(DBOrderNickName("KNUMTIPOGR"))
   If SE1->(DBSeek(xFilial("SE1")+AllTrim(cNumNF)))
      lRet := .F.
      If MsgYesNo("O número tipográfico inicial informado já foi utilizado!" + Chr(13) + "Confirma o número tipográfico?", "Atenção")
         lRet := .T.
      EndIf   
   EndIf
   
Return(lRet)