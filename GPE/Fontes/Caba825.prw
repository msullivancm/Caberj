#include "PLSA825.CH"
#include "PROTHEUS.CH"

#DEFINE BASEINSSPF	1
#DEFINE INSSPF		   2
#DEFINE BASEINSSPJ	3
#DEFINE INSSPJ		   4                               
#DEFINE VLRFATURA	   5
#DEFINE SALCONTRIB	6  
#DEFINE PROLAB   	   7 
#DEFINE INSSPROLAB 	8 

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±±
±±³Funcao    ³ PLSA825 ³ Autor ³ Sandro Hoffman Lopes   ³ Data ³ 05.12.05 ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±±
±±³Descricao ³ Gera dados referentes aos pagamentos efetuados aos RDA's   ³±±±
±±³          ³ nos seguintes arquivos:                                    ³±±±
±±³          ³ SRA - Funcionarios                                         ³±±±
±±³          ³ SI3 - Centro de Custos                                     ³±±±
±±³          ³ SRC - Lancamentos Mensais                                  ³±±±
±±³          ³ Objetivo: Integracao com GPE - Gerar arquivo SEFIP.RE      ³±±±
±±³          ³           aproveitando a rotina GPEM610                    ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±±
±±³Sintaxe   ³ PLSA825                                                    ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±±
±±³ Uso      ³ Advanced Protheus                                          ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±±
±±³ Alteracoes desde sua construcao inicial                               ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±±
±±³ Data     ³ BOPS ³ Programador ³ Breve Descricao                       ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±±
±±³15-04-08  ³ 		| Luciano Ap. | ALterações codigo trabalhador		  ³±±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function CABA825a
   
   Local cPath
   Local cSRA
   Local cSRC
   Local cSI3
   Local aSays     := {}
   Local aButtons  := {}
   Local cCadastro   
   Local nOpca     := 0
   Local cPerg     := "CAB825"
   // Em 15/10/2014 - OSP - Acrescentei um zero à esquerda devido à nova estrutura de 4 digitos.
   Local aIdCalc   := {  "0350", ; // Base INSS Autonomo PF e JF
                         "0351", ; // INSS Autonomo PF
                         "0353", ; // Base INSS Autonomo PJ
                         "0354", ; // INSS Autonomo PJ
                         "0314", ; // Valor de Fatura Prestacao de Servicos 
                         "0288", ; // Salario de Contribuicao Inss Outras Empresas
                         "0221",; // Sal.Contr.Aut./Pro-Lab. 15%
                         "0064"}  // desconto de INSS
   Local aCodPD    := { "", "", "", "", "", "", "", "" }
   Local i		   := 0	
   
   //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
   //³ Verifica indices da tabela BA0                                               ³
   //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
   If  SIX->(msSeek("BA03"))
       If  alltrim(SIX->CHAVE) <> "BA0_FILIAL+BA0_CODCLI+BA0_LOJCLI"
           msgstop("O índice 3 da tabela BA0 não está correto. Favor executar os procedimentos conforme descrito no bops n. 116339.")
           Return()
       Endif
   Else
       msgstop("Não foi encontrado o índice 3 na tabela BA0. Favor executar os procedimentos conforme descrito no bops n. 116339.")
       Return()
   Endif
   If  SIX->(msSeek("BA04"))
       If  alltrim(SIX->CHAVE) <> "BA0_FILIAL+BA0_CGC"
           msgstop("O índice 4 da tabela BA0 não está correto. Favor executar os procedimentos conforme descrito no bops n. 116339.")
           Return()
       Endif
   Else
       msgstop("Não foi encontrado o índice 4 na tabela BA0. Favor executar os procedimentos conforme descrito no bops n. 116339.")
       Return()
   Endif

//   msgstop("teste")
   
   //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
   //³ Funcao cadastrada na tabela SRJ que sera utilizada para gerar dados na SEFIP ³
   //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
   If Empty(GetNewPar("MV_PLSFNSF",""))
      MsgStop(STR0012) // "Antes de prosseguir, favor cadastrar o parametro MV_PLSFNSF informando o codigo da funcao utilizada para gerar a SEFIP"
      Return
   EndIf

   For i := 1 To Len(aCodPD)
       aCodPD[i] := Posicione("SRV", 2, xFilial("SRV")+aIdCalc[i], "RV_COD")
       If Empty(aCodPD[i])
          Aviso(STR0005, STR0006 + aIdCalc[i] + " - " + AllTrim(Tabela("35", aIdCalc[i])),{"Ok"} ) // Verba nao Cadastrada
          Return
       EndIf
   Next i

   fCriaSX1(cPerg)
   Pergunte(cPerg, .F.)

   cCadastro := OemtoAnsi(STR0001) // "Geracao SEFIP por Tomadores"

   aAdd(aSays, OemToAnsi(STR0002) ) // "Este programa gera os arquivos que servirao de base ..."
   aAdd(aSays, OemToAnsi(STR0003) )
                                            
   aAdd(aButtons, { 5,.T.,{|| Pergunte(cPerg,.T. ) } } )
   aAdd(aButtons, { 1,.T.,{|o| nOpca := 1,If(PLA825OK(), FechaBatch(), nOpca:=0) }} )
   aAdd(aButtons, { 2,.T.,{|o| FechaBatch() }} )

   FormBatch( cCadastro, aSays, aButtons )

   If nOpca <> 1                      
      Return
   EndIf
   
   cSRA := GetNewPar("MV_SRAPLS","SRAX")
   cSRC := GetNewPar("MV_SRCPLS","SRCX")
   cSI3 := GetNewPar("MV_SI3PLS","SI3X")

   // Deleta Tabelas que deverao ser gravadas para gerar SEFIP
   TCSQLEXEC("DROP TABLE " + cSRA)
   TCSQLEXEC("DROP TABLE " + cSRC)
   TCSQLEXEC("DROP TABLE " + cSI3)

   // Cria Tabelas que deverao ser gravadas para gerar SEFIP
   fCriaArq("SRA", cSRA)
   fCriaArq("SRC", cSRC)
   fCriaArq("SI3", cSI3)

   //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
   //³ Processa B15                                                             ³
   //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
   MsAguarde({|| A825Gera(aCodPD) }, STR0007, "", .T.) // "Gerando base para SEFIP"
   
   SRAX->(DbCloseArea())
   SRCX->(DbCloseArea())
   SI3X->(DbCloseArea())

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³A825Gera   ³ Autor ³ Sandro Hoffman Lopes  ³ Data ³ 08/12/05³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Processa "B15" para gravar "SRAX", "SRCX" e "SI3X"         ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function A825Gera(aCodPD)

   Local cB15Name := RetSQLName("B15") // BASES PGTO RDAS - SEFIP
   Local cBAUName := RetSQLName("BAU") // Redes de Atendimento
   Local cSE2Name := RetSqlName("SE2") // COntas a Pagar
   
   Local cSQL, cJoinBAU, cWhere, cChaveSA1, cCodOpe, aDadosSA1, cCodRDA, aDadosBAU, aCodFun := {}, i
   
   Private cCodOpeDe, cCodOpeAte, cAnoPag, cMesPag, cRDAPad, cCopCre, cCopCrePar
   
   cCodOpeDe  := mv_par01
   cCodOpeAte := mv_par02
   cAnoPag    := mv_par03
   cMesPag    := mv_par04
   cRDAPad    := mv_par05                                                       
   cCopCrePar := mv_par06
   cCopCre    := "("
   dDtBxDe    := mv_par07
   dDtBxAte   := mv_par08  
   
   For i := 1 To Len(mv_par06)
       If ! SubStr(mv_par06, i, 1) $ " *"
	       cCopCre += IIf(Len(cCopCre) > 1, ",", "") + "'" + SubStr(mv_par06, i, 1) + "'"
	   EndIf
   Next i
   cCopCre    += ")"
   
   //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
   //³ Funcao cadastrada na tabela SRJ que sera utilizada para gerar dados na SEFIP ³
   //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
   aAdd(aCodFun, GetMV("MV_PLSFNSF"))
   
 /*	IF SRJ->(FieldPos("RJ_CODCBO")) > 0
    	aAdd(aCodFun, Posicione("SRJ", 1, xFilial("SRJ")+aCodFun[1], "RJ_CODCBO"))
 	Else
    	aAdd(aCodFun, Posicione("SRJ", 1, xFilial("SRJ")+aCodFun[1], "RJ_CBO"))
 	Endif                                                                  
   */
   	 	aAdd(aCodFun,'02231')
   
   cSQL := " SELECT TAB.* FROM " + RetSqlName("SE2") + " SE2 , ( "
   cSQL += "    SELECT   B15_OPERDA, B15_CODRDA, B15_CLIENT, B15_LOJA,   B15_BASEPF, B15_BASEPJ, B15_BASEJF,  B15_INSSPF, B15_INSSPJ, "
   cSQL += "         B15_MESLOT,B15_ANOLOT,B15_NUMLOT  , BAU_NOME,   BAU_INSS,BAU_END, BAU_BAIRRO, BAU_MUN, BAU_EST,BAU_CEP,         "
//   cSQL += "         BAU_COPCRE,    BAU_CBO  " 
   cSQL += "         BAU_COPCRE,    '02231'  "
   cSQL += "    FROM " + RetSqlName("B15") + " LEFT OUTER JOIN " + RetSqlName("BAU")
   cSQL += "         ON "
   cSQL += "         BAU_FILIAL =  '"  + xFilial("BAU") + "' AND "
   cSQL += "         BAU_CODIGO = B15_CODRDA                 AND "
   cSQL +=           RetSqlName("B15") + ".D_E_L_E_T_    <> '*'  "
   cSQL += "    WHERE  "
   cSQL += "       B15_FILIAL  = '" + xFilial("B15") + "'  AND "
   cSQL += "      (B15_OPERDA >= '" + cCodOpeDe      + "'  AND "
   cSQL += "       B15_OPERDA <= '" + cCodOpeAte     + "') AND "
   cSQL += "       B15_ANOLOT >= '" + cAnoPag        + "'  AND "
   cSQL += "       B15_MESLOT >= '" + cMesPag        + "'  AND "
   cSQL +=         RetSqlName("B15") + ".D_E_L_E_T_ <> '*' ) TAB "  
   cSQL += " WHERE  TAB.B15_ANOLOT||TAB.B15_MESLOT||TAB.B15_NUMLOT = SE2.E2_PLLOTE  AND    " 
   cSQL += "        SE2.E2_BAIXA <> ' ' AND                                                "
   cSQL += "        SE2.E2_BAIXA BETWEEN '" + dTos(dDtBxDe) + "'  AND '" + dTos(dDtBxAte) + "' AND "
   cSQL += "        SE2.E2_SALDO = 0 AND SE2.E2_CODRDA = TAB.B15_CODRDA AND E2_TIPO <> 'TX' " 
  
   //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
   //³ Exibe mensagem...                                                        ³
   //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
   MsProcTxt(STR0004) // "Buscando dados no servidor..."

   PLSQuery(cSQL, "Trb825") // Igual ao TCQuery
   
   Trb825->(DbGotop()) 
   Do While ! Trb825->(Eof())
   
      MsProcTxt(STR0008 + Trb825->B15_CODRDA + "... ") // "Processando RDA "
      ProcessMessages()
      If  !Trb825->BAU_COPCRE $ cCopCrePar
          Trb825->(DbSkip())
          Loop
      Endif
      
      If cCodOpe <> Trb825->B15_OPERDA
         cCodOpe := Trb825->B15_OPERDA
         // Indice 1 - BA0_FILIAL+BA0_CODIDE+BA0_CODINT
         BA0->(DbSetOrder(1))
         BA0->(MsSeek(xFilial("BA0")+cCodOpe, .F.))
      EndIf              

      // Somente gera SI3 e SRA se houver algum valor a gravar no SRC, pois se gravar SI3 e SRA e nao gravar 
      // SRC, caso haja valor de fatura para o Tomador de Servico (CLIENTE), nao ira gravar o SRC com R$ 0.01 
      // na rotina "fGr_SRX". Isso fazia com que o GPEM610 gravasse um registro TIPO 20 sem o TIPO 30 no arquivo 
      // da SEFIP e gerava um erro na validacao da SEFIP 
      // BOPS: 94817
      If Trb825->B15_BASEPF > 0 .Or. ;
      	 Trb825->B15_BASEPJ > 0 .Or. ;
      	 Trb825->B15_BASEJF > 0
	      cCodRDA   := Trb825->B15_CODRDA
	      cChaveSA1 := Trb825->(B15_CLIENT+B15_LOJA)
	      aDadosSA1 := GetAdvFVal("SA1", { "A1_NOME", "A1_END", "A1_BAIRRO", "A1_CEP", "A1_MUN", "A1_EST", "A1_CGC", "A1_CEINSS", "A1_PESSOA" }, xFilial("SA1")+cChaveSA1, 1, { "", "", "", "", "", "", "", "", "" })
	      aDadosBAU := { Trb825->BAU_NOME, Trb825->BAU_INSS, Trb825->BAU_END, Trb825->BAU_BAIRRO, Trb825->BAU_MUN, Trb825->BAU_EST, Trb825->BAU_CEP, "02231" }
	               
	      fGr_SI3(@cChaveSA1, aDadosSA1)       
	      
	      fGr_SRA(cChaveSA1, aDadosSA1, cCodRDA, aDadosBAU, aCodFun)
	      	       
	      //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		   //³ Ponto de Entrada - Para alterar a Chave qdo for federação e for pago para o mesmo CGC  |                           ³
		   //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		  
 		  If ExistBlock("PLSA825CC")
		   	cChaveSA1:= ExecBlock("PLSA825CC",.F.,.F.,{Trb825->B15_CLIENT,Trb825->B15_LOJA})
		  EndIf
		  //Gera a base Unica Pessoa Física + Jurídica
		  If GetNewPar("MV_PLCATEG","") == "13"//Contribuinte individual - Trabalhador autônomo ou a este equiparado
	         fGr_SRC(aCodPD[PROLAB], cChaveSA1, cCodRDA, Trb825->(B15_BASEPF+B15_BASEPJ+B15_BASEJF))
		      fGr_SRC(aCodPD[INSSPROLAB], cChaveSA1, cCodRDA, Trb825->(B15_INSSPF+B15_INSSPJ))
		  Else
		      If Trb825->B15_BASEPF <> 0 // Base INSS Pessoa Fisica
		         fGr_SRC(aCodPD[BASEINSSPF], cChaveSA1, cCodRDA, Trb825->B15_BASEPF)
		      EndIf
		      If Trb825->B15_BASEPJ <> 0 // Base INSS Pessoa Juridica
		         fGr_SRC(aCodPD[BASEINSSPJ], cChaveSA1, cCodRDA, Trb825->B15_BASEPJ)
		      EndIf
		      If Trb825->B15_BASEJF <> 0 // Base INSS Juridica Filantropica
		         fGr_SRC(aCodPD[BASEINSSPF], cChaveSA1, cCodRDA, Trb825->B15_BASEJF)
		      EndIf
		      If Trb825->B15_INSSPF > 0 // INSS Pessoa Fisica
		         fGr_SRC(aCodPD[INSSPF], cChaveSA1, cCodRDA, Trb825->B15_INSSPF)
		      EndIf
		      If Trb825->B15_INSSPJ > 0 // INSS Pessoa Juridica
		         fGr_SRC(aCodPD[INSSPJ], cChaveSA1, cCodRDA, Trb825->B15_INSSPJ)
		      EndIf   
		  Endif
		   // Grava um centavo para o ID Calc 288 (INSS Outras Empresas) para que a SEFIP seja gerada com
	      // ocorrencia "05", onde sera possivel informar o valor de INSS retido para cada RDA
          fGr_SRC(aCodPD[SALCONTRIB], cChaveSA1, cCodRDA, 0.01)
	  EndIf
      
      Trb825->(DbSkip())
      
   EndDo
   
   Trb825->(DbCloseArea())
   
   fProcBBT(aCodPD)
   
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³fGr_SI3    ³ Autor ³ Sandro Hoffman Lopes  ³ Data ³ 08/12/05³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Grava o arquivo "SI3X"                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function fGr_SI3(cChaveSA1, aDadosSA1)

	/*ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	  ³ aDadosSA1[8] - Numero do CEI                                  ³
	  ³ aDadosSA1[9] - Tipo Pessoa: F-Fisica / J-Juridica             ³
	  ³                                                               ³
	  ³1) Se cliente eh Pessoa Fisica e NAO POSSUI CEI, deve constar  ³
	  ³   como TOMADOR DE SERVICOS a propria OPERADORA.               ³
	  ³                                                               ³
	  ³2) Se cliente eh Pessoa Fisica e POSSUI CEI, deve constar como ³
	  ³   TOMADOR DE SERVICOS o proprio cliente. Ex.: Escritorios de  ³
	  ³   Contabilidade onde o contador se cadastra no INSS (CEI) pa- ³
	  ³   ra ter empregados e paga os impostos devidos.               ³
	  ³                                                               ³
	  ³3) Se CGC do Cliente eh o mesmo da OPERADORA, deve constar como³
	  ³   OPERADORA para evitar duplicidade de registros na geracao   ³
	  ³   do SRC.                                                     ³
	  ³                                                               ³
	  ³4) Se o cliente eh uma operadora (atendimentos de intercambio) ³
	  ³   deve constar como TOMADOR DE SERVICOS a propria OPERADORA.  ³
	  ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
   Local lOper := .F. 
   If  (aDadosSA1[9] == "F" .or. Empty(aDadosSA1[9])) .and. Empty(aDadosSA1[8])
       lOper := .T.
   Endif
   If  aDadosSA1[7] == BA0->BA0_CGC
       lOper := .T.
   Endif
   If  fInterc(aDadosSA1[7])
       lOper := .T.
   Endif
   If lOper
      aDadosSA1[1] := BA0->BA0_NOMINT
      aDadosSA1[2] := BA0->BA0_END
      aDadosSA1[3] := BA0->BA0_BAIRRO
      aDadosSA1[4] := BA0->BA0_CEP
      aDadosSA1[5] := BA0->BA0_CIDADE
      aDadosSA1[6] := BA0->BA0_EST
      aDadosSA1[7] := BA0->BA0_CGC
      aDadosSA1[8] := ""
      cChaveSA1    := "OPERADORA"
   EndIf

   // Indice 1: I3_FILIAL+I3_CUSTO+I3_CONTA+I3_MOEDA
   SI3X->(DbSetOrder(1))
   If ! SI3X->(MsSeek(xFilial("SI3")+PadR(cChaveSA1, 9), .F.))
      SI3X->(RecLock("SI3X", .T.))
       SI3X->I3_FILIAL  := xFilial("SI3")
       SI3X->I3_CUSTO   := cChaveSA1
       SI3X->I3_DESC    := "CC PLS"
       SI3X->I3_NOME    := aDadosSA1[1]
       SI3X->I3_ENDEREC := aDadosSA1[2]
       SI3X->I3_BAIRRO  := aDadosSA1[3]
       SI3X->I3_CEP     := aDadosSA1[4]
       SI3X->I3_MUNICIP := aDadosSA1[5]
       SI3X->I3_ESTADO  := aDadosSA1[6]
       SI3X->I3_TIPO    := IIf(Empty(aDadosSA1[8]), "1", "2") // 1-CNPJ , 2-CEI
       SI3X->I3_CEI     := IIf(Empty(aDadosSA1[8]), aDadosSA1[7], PadL(AllTrim(aDadosSA1[8]), 14, "0"))
      SI3X->(MsUnlock())
   EndIf

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³fGr_SRA    ³ Autor ³ Sandro Hoffman Lopes  ³ Data ³ 08/12/05³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Grava o arquivo "SRAX"                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function fGr_SRA(cChaveSA1, aDadosSA1, cCodRDA, aDadosBAU, aCodFun)

                    
   SRAX->(DbSetOrder(1))
   If ! SRAX->(MsSeek(xFilial("SRA")+cCodRDA, .F.))
      SRAX->(RecLock("SRAX", .T.))
       SRAX->RA_FILIAL  := xFilial("SRA")
       SRAX->RA_CC      := cChaveSA1
       SRAX->RA_MAT     := cCodRDA
       SRAX->RA_NOME    := aDadosBAU[1]
       SRAX->RA_PIS     := aDadosBAU[2] // Nr da inscricao do contribuinte individual (CI) - INSS
       SRAX->RA_ENDEREC := aDadosBAU[3]
       SRAX->RA_BAIRRO  := aDadosBAU[4]
       SRAX->RA_MUNICIP := Posicione("BID", 1, xFilial("BID")+aDadosBAU[5], "BID_DESCRI")
       SRAX->RA_ESTADO  := aDadosBAU[6]
       SRAX->RA_CEP     := aDadosBAU[7]
	    SRAX->RA_CATFUNC := "A"
	    SRAX->RA_TIPOPGT := "M"
	    SRAX->RA_CODFUNC := aCodFun[1]
///	    SRAX->RA_CBO     := IIF(Empty(aDadosBAU[8]),aCodFun[2],aDadosBAU[8]) 
	    SRAX->RA_CBO     := "02231"    //altamiro 04/03/10
	  SRAX->(MsUnlock())
   EndIf
   
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³fGr_SRC    ³ Autor ³ Sandro Hoffman Lopes  ³ Data ³ 08/12/05³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Grava o arquivo "SRCX"                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function fGr_SRC(cCodPD, cChaveSA1, cCodRDA, nVlrPag)

   // Indice 2: RC_FILIAL+RC_CC+RC_MAT+RC_PD+RC_SEMANA+RC_SEQ
   SRCX->(DbSetOrder(2))
   If ! SRCX->(MsSeek(xFilial("SRC")+PadR(cChaveSA1, 9)+cCodRDA+cCodPD, .F.))
      SRCX->(RecLock("SRCX", .T.))
       SRCX->RC_FILIAL := xFilial("SRC")
       SRCX->RC_MAT    := cCodRDA
       SRCX->RC_PD     := cCodPD
       SRCX->RC_TIPO1  := "V"
       SRCX->RC_CC     := cChaveSA1
       SRCX->RC_TIPO2  := "G"
    Else
      SRCX->(RecLock("SRCX", .F.))
   EndIf
   SRCX->RC_VALOR  += nVlrPag
   SRCX->(MsUnlock())
   
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³fCriaArq   ³ Autor ³ Sandro Hoffman Lopes  ³ Data ³ 08/12/05³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³Cria os arquivos "SRAX", "SRCX" e "SI3X" que serao gravados ³±±
±±³          ³com os dados para gerar a SEFIP ref PLS                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function fCriaArq( cAlias, cAliasMov )

Local aDbStruct := {}
Local cPath		:= ""
Local cSvAlias	:= Alias()
Local lRet		:= .F.
Local nBag		:= 0
Local nLenBag	:= 0
Local cArqMov   := ""
Local aOrdBag   := {}

/*
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³Verifica se o Arquivo foi Aberto.                             ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
IF ( Select( cAlias ) == 0 )
	ChkFile( cAlias )	
EndIF

/*
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³Salva a Estrutura e Fecha o Arquivo                           ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
//( dbSelectArea( cAlias ) , aDbStruct := ( cAlias )->( dbStruct() ) , ( cAlias )->( dbCloseArea() ) )
( dbSelectArea( cAlias ) , aDbStruct := ( cAlias )->( dbStruct() ) )

/*
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Retorna o Path do Arquivo                                    ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
dbSelectArea("SX6")
IF Empty( cPath := AllTrim( GetMv( "MV_DGPESRC" ) ) )
	SX2->( MsSeek( cAlias ) )
	cPath := AllTrim( SX2->X2_PATH )
Else
	IF SubStr( cPath , -1 ) != "\"
		cPath += "\"
	EndIF
EndIF

/*
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Carrega a Bolsa de Ordens                                    ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
IF SIX->( MsSeek( cAlias ) ) 
	While SIX->( !Eof() .and. cAlias == INDICE )
		 SIX->( aAdd( aOrdBag , {				 ;
		 						 CHAVE 			,; // 01 - Chave do Indice 
		 						 Space(01)		,; // 02 - Nome Fisico do Arquivo de Indice
		 						 ORDEM			,; // 03 - Ordem do Indice
		 						 NICKNAME		,; // 04 - Apelido do Indice
		 					   }				 ;
		 			 )							 ;
		 	   )
		 SIX->( dbSkip() )
	End While
	nLenBag := Len( aOrdBag )
EndIF

#IFNDEF TOP
	cArqMov := RetArq( __cRdd , cPath + cAliasMov , .T. )
#ELSE
	cArqMov := RetArq( __cRdd , cPath + cAliasMov , .F. )
#ENDIF

MsCreate( cArqMov , aDbStruct , __cRdd )
MsOpenDbf( .T. , __cRDD , cArqMov , cAliasMov , .T. , .F. )

IF ( lRet := ( Select( cAliasMov ) > 0 ) )

	/*
	ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	³Retorna Nomes Validos Para os Arquivos de Indices             ³
	ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
	For nBag := 1 To nLenBag
	   	#IFNDEF TOP
	   		aOrdBag[ nBag , 2 ] := ( RetArq( "TOPCONN" , cArqMov , .F. ) + AllTrim( aOrdBag[ nBag , 3 ] ) )
	   	#ELSE
			aOrdBag[ nBag , 2 ] := Upper( AllTrim( ( cArqMov + AllTrim( aOrdBag[nBag,3] ) ) ) )
    	#ENDIF
    Next nBag

	/*
	ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	³Compara e Atualiza a Estrutura dos Arquivos                   ³
	ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
	IF ( lRet := fStructArq( aDbStruct , cAliasMov , cArqMov , aOrdBag , .T. , .F. ) )

		/*
		ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		³Cria Indices                                                  ³
		ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
		fArqMovCreateIndex( cAliasMov , cArqMov , aOrdBag )
	    
		/*
		ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		³ Verifica se Todas as Ordens foram Carregadas	               ³
		ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
		For nBag := 1 To nLenBag
			IF !( lRet := fContemStr( ( cAliasMov )->( IndexKey( nBag ) ) , aOrdBag[  nBag , 01 ] , .T. ) )
				/*
				ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				³ Exclui os Indices para que possam ser Recriados              ³
				ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
				IF ( lRet := fFimArqMov( cAliasMov , aOrdBag , cArqMov , .T. , .F.  ) )
					/*
					ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					³Recria os Indices se Houver Diferencas nas Chaves			   ³
					ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
					fArqMovCreateIndex( cAliasMov , cArqMov , aOrdBag )
					/*
					ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					³ Verifica Novamente se Todas as Ordens foram Carregadas	   ³
					ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
					For nBag := 1 To nLenBag
						IF !( lRet := fContemStr( ( cAliasMov )->( IndexKey( nBag ) ) , aOrdBag[  nBag , 01 ] , .T. ) )
							Exit
						EndIF
					Next nBag
				EndIF	
				Exit
			EndIF
		Next nBag

		IF ( lRet )

			/*
			ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			³ Mapeia 1 Campo no TOP										   ³
			ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
			#IFDEF TOP
				IF RddName() == "TOPCONN" .and. TCSrvType() != "AS/400" .and. HasMapper()
					TcSrvMap( cAliasMov , AllTrim( FieldName(1) ) )
				EndIF
			#ENDIF

			/*
			ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			³ Carrega as Variaveis que serao passadas por Referencia       ³
			ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
//			( cAliasMov := cAlias , cNomeArqMov := RetArq( __cRdd , cArqMov , .F. )  )
	
			/*
			ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			³ Seta Ordem 1 para o novo arquivo aberto                      ³
			ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
			( cAliasMov )->( dbSetOrder( 01 ) )
		
		EndIF
	
	EndIF

EndIF

/*
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³Restaura Arquivo Atual  caso nao tenha conseguido abrir³
³Arquivos de Meses Anteriores ( RC ou RI )		        ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
IF !( lRet )          


	IF ( Select( cAlias ) > 0 )
		( cAlias )->( dbCloseArea( ) )
	EndIF
	ChkFile( cAlias , .F. )


EndIF

dbSelectArea( cSvAlias )

Return( lRet )

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ fCriaSX1  ³ Autor ³ Sandro Hoffman Lopes  ³ Data ³ 08/12/05³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Verifica Grupo do Pergunte no SX1 e cria se necessario     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function fCriaSX1(cPerg)

   Local aRegs	:=	{}

   aadd(aRegs,{cPerg,"01","Operadora De           ?","","","mv_ch1","C", 4,0,0,"G","",          "mv_par01","","","","","","","","","","","","","","","","","","","","","","","","","BBB","","",""})
   aadd(aRegs,{cPerg,"02","Operadora Ate          ?","","","mv_ch2","C", 4,0,0,"G","",          "mv_par02","","","","zzzz","","","","","","","","","","","","","","","","","","","","","BBB","","",""})
   aadd(aRegs,{cPerg,"03","Ano Lote Pagamento     ?","","","mv_ch3","C", 4,0,0,"G","",          "mv_par03","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
   aadd(aRegs,{cPerg,"04","Mes Lote Pagamento     ?","","","mv_ch4","C", 2,0,0,"G","",          "mv_par04","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
   aadd(aRegs,{cPerg,"05","RDA Padrao             ?","","","mv_ch5","C", 6,0,0,"G","",          "mv_par05","","","","","","","","","","","","","","","","","","","","","","","","","BAU","","",""})
   aadd(aRegs,{cPerg,"06","Tp Prestador           ?","","","mv_ch6","C", 4,0,0,"G","fTpPrest()","mv_par06","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
   aadd(aRegs,{cPerg,"07","Baixa De               ?","","","mv_ch7","D", 4,0,0,"G","",          "mv_par07","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
   aadd(aRegs,{cPerg,"08","Baixa Ate              ?","","","mv_ch8","D", 4,0,0,"G","",          "mv_par08","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})

   PlsVldPerg( aRegs )
     
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ PLA825Ok  ³ Autor ³ Sandro Hoffman Lopes  ³ Data ³ 08/12/05³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Confirma parametros antes de continuar processamento       ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function PLA825Ok()
Return (MsgYesNo(OemToAnsi(STR0009),OemToAnsi(STR0010))) // "Confirma configura‡„o dos parƒmetros?" ## "Atencao"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³fProcBBT   ³ Autor ³ Sandro Hoffman Lopes  ³ Data ³ 04/01/06³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Le tabela BBT (Titulo Gerados pelo PLS) e grava tabela     ³±±
±±³Descri‡„o ³ "SRX" com o Valor das Faturas por Tomador                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function fProcBBT(aCodPD)

   Local cSQL, aDadosSA1, cChaveSA1, aCC
   Local cBBTName := RetSQLName("BBT") // Titulos Gerados pelo PLS

   cSQL     := " SELECT BBT_CLIFOR, BBT_LOJA, BBT_BASINS "
   cSQL     += " FROM " + cBBTName 
   cSQL     += " WHERE (BBT_CODOPE >= '" + cCodOpeDe  + "'  AND "
   cSQL     += "        BBT_CODOPE <= '" + cCodOpeAte + "') AND "
   cSQL     += "        BBT_MESTIT =  '" + cMesPag + "'     AND "
   cSQL     += "        BBT_ANOTIT =  '" + cAnoPag + "'     AND "
   cSQL     += "        BBT_INTERC =  '0' AND "
   cSQL     += "        BBT_RECPAG =  '0' AND "
   cSQL     += "        " + cBBTName + ".D_E_L_E_T_ <> '*' "

   //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
   //³ Exibe mensagem...                                                        ³
   //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
   MsProcTxt(STR0004) // "Buscando dados no servidor..."
   ProcessMessages()

   PLSQuery(cSQL, "Trb825") // Igual ao TCQuery

   Trb825->(DbGotop()) 
   aCC := {}
   
   Do While ! Trb825->(Eof())
   
      MsProcTxt(STR0011 + Trb825->(BBT_CLIFOR+BBT_LOJA) + "... ") // "Processando Cliente "
      ProcessMessages()  
      aDadosSA1 := GetAdvFVal("SA1", { "A1_CEINSS", "A1_PESSOA", "A1_CGC" }, xFilial("SA1")+Trb825->(BBT_CLIFOR+BBT_LOJA), 1, { "", "" })
      If (aDadosSA1[2] == "F" .Or. Empty(aDadosSA1[2])) .And. Empty(aDadosSA1[1]) .Or. ; // Cliente pagador eh Pessoa Fisica e nao possui CEI
         (fInterc(aDadosSA1[3]))
         cChaveSA1 := "OPERADORA"                        
         // Nao deve gerar o valor da Fatura qdo o Tomador for a propria OPERADORA
         Trb825->(DbSkip())
         Loop
       Else
         cChaveSA1 := Trb825->(BBT_CLIFOR+BBT_LOJA)
      EndIf
       
      nInd := aScan(aCC, {|x| x[1] == cChaveSA1})
      If nInd == 0
         aAdd(aCC, { cChaveSA1, 0 })
         nInd := Len(aCC)
      EndIf
      aCC[nInd, 2] += Trb825->BBT_BASINS
      
      Trb825->(DbSkip())
      
   EndDo      
                       
   Trb825->(DbCloseArea())
   
   fGr_SRX(aCC, SubStr(cAnoPag, 3, 2), cMesPag, aCodPD)
   
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³fGr_SRX    ³ Autor ³ Sandro Hoffman Lopes  ³ Data ³ 04/01/06³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Grava o arquivo "SRX" com o Valor das Faturas por Tomador  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function fGr_SRX(aCC, cAnoPag, cMesPag, aCodPD)

    Local   i
    Local   nRegistros
	Local   nCnt
	Local   nItens
	Local   cTip       := "15"
	Local   cCodPD     := aCodPD[VLRFATURA]
    Local   cChaveSA1  := ""
    Local   cCodRDA    := ""
    Local   aDadosSA1  := {}
    Local   aDadosBAU  := {}
    Local   aCodFun    := {}
	Private nUsado     := 0
	Private aHeader    := {}
	Private aCols      := {}
	Private nOpcx      := 4    
	
	Private lUsadoGP := IF(Empty(X3USADO("RE_TPDATO")),.F.,X3USADO("RE_TPDATO"))   
	
	Private lAdmin  	:= FWIsAdmin( __cUserID )       

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Funcao cadastrada na tabela SRJ que sera utilizada para gerar dados na SEFIP ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
    aAdd(aCodFun, GetMV("MV_PLSFNSF"))
    IF SRJ->(FieldPos("RJ_CODCBO")) > 0
    	aAdd(aCodFun, Posicione("SRJ", 1, xFilial("SRJ")+aCodFun[1], "RJ_CODCBO"))
 	Else
    	aAdd(aCodFun, Posicione("SRJ", 1, xFilial("SRJ")+aCodFun[1], "RJ_CBO"))
 	Endif
    
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Monta o cabecalho                                            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	DbSelectArea("SX2")
	DbSeek("SRX")
	DbSelectArea("SR5")
	DbSetOrder(2)
	DbSeek("            X"+cTip)
	nRegistros := IIf(SR5->R5_TAMANHO <= 0, 1, SR5->R5_TAMANHO)
	Do While ! SR5->(Eof()) .And. SR5->R5_ARQUIVO == "X"+cTip
		If SR5->R5_USADO != " " .And. cNivel >= Val(SR5->R5_NIVEL)
			nUsado++
			aAdd(aHeader,{ Trim(SR5->R5_TITULO),SR5->R5_CAMPO,SR5->R5_PICTURE,SR5->R5_TAMANHO,SR5->R5_DECIMAL,;
			               SR5->R5_VALID,SR5->R5_USADO,SR5->R5_TIPO,SR5->R5_F3,SR5->R5_RESERV,Val(SR5->R5_ORDEM),Val(R5_POSICAO),SR5->R5_CHAVE } )
		EndIf
		DbSkip()
	EndDo

	DbSetOrder(1)
	If Len(aHeader) == 0
		Help(" ", 1, "A150SSR5")
		Return
	EndIf

	nCnt := 0
	DbSelectArea("SRX")
	DbSetOrder(2)
	DbSeek(cTip)
	Do While ! SRX->(Eof()) .And. SRX->RX_TIP == cTip
		nCnt ++
		DbSkip()
	EndDo

	nCnt   := Int(nCnt/nRegistros)
	nCnt   := IIf(nOpcx == 3, 1, nCnt)
	aCols  := Array(nCnt, nUsado+IIf(nOpcx=2 .Or. nOpcx=6, 0, 1))
	nItens := 0
	nCnt   := 0                                             

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Monta o aCols com os dados gravados no SRX - Tipo 15         ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
 	fCarrega15(nRegistros, @nItens, nOpcx)
 	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Zera valores no array aCols pois, se nao houver mais fatura   ³
	//³ para um determinado TOMADOR, geraria com o valor ja gravado.  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
 	For i := 1 To Len(aCols)
 	   aCols[i, fPosCpo("X15_BASE  ")] := 0
 	Next i

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Inclui/Altera todos os CC's do array aCC no array aCols      ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
    For i := 1 To Len(aCC) 	
        // Pesquisa se ja existe dados para o CC (TOMADOR) em questao, caso nao exista, grava SI3, SRA e SRC para 
        // que o programa gere o TIPO 20/30 referente a este CC (TOMADOR) com o valor das faturas emitidas
        // Neste caso o SRC e gravado com R$ 0,01 de base de INSS apenas para gerar o arquivo da SEFIP
        cChaveSA1 := aCC[i, 1]
        SI3X->(DbSetOrder(1))
        If ! SI3X->(MsSeek(xFilial("SI3")+PadR(cChaveSA1, 9), .F.)) .And. aCC[i, 2] > 0
           cCodRDA   := cRDAPad
           aDadosSA1 := GetAdvFVal("SA1", { "A1_NOME", "A1_END", "A1_BAIRRO", "A1_CEP", "A1_MUN", "A1_EST", "A1_CGC", "A1_CEINSS", "A1_PESSOA" }, xFilial("SA1")+cChaveSA1, 1, { "", "", "", "", "", "", "", "", "" })
           aDadosBAU := GetAdvFVal("BAU", { "BAU_NOME", "BAU_INSS", "BAU_END", "BAU_BAIRRO", "BAU_MUN", "BAU_EST", "BAU_CEP","BAU_CBO" }, xFilial("BAU")+cCodRDA, 1, { "", "", "", "", "", "", "", "" })
           fGr_SI3(@cChaveSA1, aDadosSA1)       
           fGr_SRA(cChaveSA1, aDadosSA1, cCodRDA, aDadosBAU, aCodFun)
           fGr_SRC(aCodPD[BASEINSSPJ], cChaveSA1, cCodRDA, 0.01) // Base INSS Pessoa Juridica
   	       // Grava um centavo para o ID Calc 288 (INSS Outras Empresas) para que a SEFIP seja gerada com
 	       // ocorrencia "05", onde sera possivel informar o valor de INSS retido para cada RDA
           fGr_SRC(aCodPD[SALCONTRIB], cChaveSA1, cCodRDA, 0.01) // Inss Outras Empresas
        EndIf
        
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Pesquisa se ja existe a chave no SRX - Tipo 15               ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	 	nInd := aScan(aCols, {|x| AllTrim(x[fPosCpo("X15_EMPRE1")]) == SM0->M0_CODFIL .And. ;
 		                          AllTrim(x[fPosCpo("X15_CC    ")]) == aCC[i, 1]      .And. ;
 	    	                       AllTrim(x[fPosCpo("X15_MM1   ")]) == cMesPag        .And. ;
 	        	                    AllTrim(x[fPosCpo("X15_AA1   ")]) == cAnoPag        .And. ;
 	            	              AllTrim(x[fPosCpo("X15_PD    ")]) == cCodPD         .And. ; 
	 	                          AllTrim(x[fPosCpo("X15_TPCONT")]) == "1" })
 		If nInd == 0
	 	   aAdd(aCols, Array(nUsado + 1))     
 		   nInd := Len(aCols)
	 	   aEval(aHeader, { |x| aCols[nInd, fPosCpo(x[2])] := IIf(x[8] == "N", 0, Space(x[4])) })
    	   aCols[nInd, fPosCpo("X15_EMPRE1")] := SM0->M0_CODFIL
	       aCols[nInd, fPosCpo("X15_CC    ")] := PadR(aCC[i, 1], aHeader[fPosCpo("X15_CC"), 4])
    	   aCols[nInd, fPosCpo("X15_MM1   ")] := cMesPag
	       aCols[nInd, fPosCpo("X15_AA1   ")] := cAnoPag
    	   aCols[nInd, fPosCpo("X15_PD    ")] := cCodPD
	       aCols[nInd, fPosCpo("X15_TPCONT")] := "1"
    	   aCols[nInd, nUsado + 1]            := .F.
       
	 	EndIf
	    aCols[nInd, fPosCpo("X15_BASE  ")] := aCC[i, 2]
	Next i
    
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Grava o array aCols no SRX - Tipo 15                         ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
    DbSelectArea("SRX") 
	DbSetOrder(2)
	//--Alteracao
	If nOpcx = 4
		DbSeek(cTip)
		Do While ! SRX->(Eof()) .And. SRX->RX_TIP == cTip
			RecLock("SRX", .F., .T.)
			nCnt ++
 			DbDelete()
			MsUnlock()
			DbSkip()
		Enddo
	EndIf
	//--Gravacao na Inclusao e Alteracao        
	If nOpcx == 3 .Or. nOpcx == 4
		GP150Grava("SRX", cTip)
	EndIf	
 	                  
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ fPosCpo   ³ Autor ³ Sandro Hoffman Lopes  ³ Data ³ 04/01/06³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Retorna posicao de determinado campo dentro de aHeader     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function fPosCpo(cCampo)
Return aScan(aHeader, {|x| AllTrim(x[2]) == AllTrim(cCampo) })



/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Funcao    ³ fTpPrest  ³ Autor ³ Sandro Hoffman Lopes ³ Data ³ 20.06.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Descricao ³ Selecionar os Tipos de Prestador que serao gerados.        ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function fTpPrest(l1Elem,lTipoRet)

   Local cTitulo  := ""
   Local MvPar
   Local MvParDef := ""
   Local aCBOX    := {}
   Local aTpPrest := {}
   Local cAlias

   DEFAULT lTipoRet := .T.

   l1Elem := If (l1Elem = Nil , .F. , .T.)

   cAlias := Alias()

   If lTipoRet
	  MvPar := &(Alltrim(ReadVar()))		 // Carrega Nome da Variavel do Get em Questao
	  MvRet := Alltrim(ReadVar())			 // Iguala Nome da Variavel ao Nome variavel de Retorno
   EndIf
                                         
   aCBOX := RetSx3Box(X3CBox(Posicione('SX3', 2, "BAU_COPCRE", 'X3_CBOX')),,,1)
   aEval(aCBOX, {|x| IIf(!Empty(x[1]), aAdd(aTpPrest, x[1]),) })
   MvParDef := "1234"
   cTitulo  := "Tipo de Prestador"
   If lTipoRet
      If f_Opcoes(@MvPar, cTitulo, aTpPrest, MvParDef, 12, 49, l1Elem)  // Chama funcao f_Opcoes
         &MvRet := MvPar // Devolve Resultado
      EndIf
   EndIf	

   DbSelectArea(cAlias) // Retorna Alias

Return(If(lTipoRet, .T., MvParDef))
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ fInterc   ³ Autor ³ Angelo Sperandio      ³ Data ³ 26/12/06³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Verifica se o cliente eh uma operadora                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function fInterc(cCGC)

Local lRet    := .F.
Local nPosBA0 := BA0->(Recno())

SIX->(dbSetOrder(1))
BA0->(dbSetOrder(4))
If  BA0->(msSeek(xFilial("BA0")+cCGC))
    lRet := .T.
Endif
BA0->(dbSetOrder(1))
BA0->(dbGoTo(nPosBA0))

Return(lRet)
