#INCLUDE "RWMAKE.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ CABFTBRAD ³ Autor ³ Rafael Fernandes     ³ Data ³ 15/10/13 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Impressão de boleto Bradesco  - ROTINA BASEADA CABBOLFT    ³±±
±±³          ³ GERAÇÃO DE BOLETO TIPO FATURA                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Especifico para Clientes Microsiga                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
±±³ Atualiz. ³ 05/12/13 - Vitor Sbano                                     ³±±
±±³          ³ - adequação de Carteira de Cobranca (reimpressao = 06 )    ³±±
±±³          ³                                                            ³±±
±±³          ³                                                            ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Atualiz. ³ 13/12/13 - Vitor Sbano                                     ³±±
±±³          ³ - ajuste de calculo de DV Nosso NUmero                     ³±±
±±³          ³ chamado User Function CalcDVBrad                           ³±±
±±³          ³                                                            ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±

/*/
User Function CABFTBRAD()
	
	LOCAL	aPergs := {}
	PRIVATE lExec   	 := .F.
	PRIVATE cIndexName 	:= ''
	PRIVATE cIndexKey  	:= ''
	PRIVATE cFilter    	:= ''
	//Private cCart		:= "09"				&& Vitor Sbano -definição de Carteira - Reimpressao
	
	Tamanho  := "M"
	titulo   := "Impressao de Boleto com Codigo de Barras"
	cDesc1   := "Este programa destina-se a impressao do Boleto com Codigo de Barras."
	cDesc2   := ""
	cDesc3   := "Grupo CABERJ - Versão 13.12.2013"
	cString  := "SE1"
	wnrel    := "BOLETO"
	lEnd     := .F.
	cPerg     :="BLTITA"
	aReturn  := {"Zebrado", 1,"Administracao", 2, 2, 1, "",1 }
	nLastKey := 0
	
	dbSelectArea("SE1")
	
	cIndexName	:= Criatrab(Nil,.F.)
	cIndexKey	:= "E1_PORTADO+E1_CLIENTE+E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO+DTOS(E1_EMISSAO)"
	cFilter		+= "E1_FILIAL=='"+xFilial("SE1")+"'.And.E1_SALDO>0.And."
	cFilter		+= "E1_PREFIXO>='" + MV_PAR18 + "'.And.E1_PREFIXO<='" + MV_PAR19 + "'.And."
	cFilter		+= "E1_NUM>='" + MV_PAR20 + "'.And.E1_NUM<='" + MV_PAR21 + "'.And."
	cFilter		+= "E1_PORTADO ='" + MV_PAR30 + "'.And."
	cFilter		+= "E1_CLIENTE>='" + MV_PAR01 + "'.And.E1_CLIENTE<='" + MV_PAR03 + "'.And."
	cFilter		+= "E1_LOJA>='" + MV_PAR02 + "'.And.E1_LOJA<='"+MV_PAR04+"'.And."
	cFilter		+= "E1_NUMBOR>='" + MV_PAR27 + "'.And.E1_NUMBOR<='" + MV_PAR28 + "'.And."
	cFilter		+= "!(E1_TIPO$MVABATIM).And."
	cFilter		+= "E1_PORTADO<>'   '"
	cFilter		+= " .AND. E1_TIPO='FT '"
	
	IndRegua("SE1", cIndexName, cIndexKey,, cFilter, "Aguarde selecionando registros....")
	DbSelectArea("SE1")
	#IFNDEF TOP
		DbSetIndex(cIndexName + OrdBagExt())
	#ENDIF
	dbGoTop()
	@ 001,001 TO 400,700 DIALOG oDlg TITLE "Seleção de Titulos"
	@ 001,001 TO 170,350 BROWSE "SE1" MARK "E1_OK"
	@ 180,310 BMPBUTTON TYPE 01 ACTION (lExec := .T.,Close(oDlg))
	@ 180,280 BMPBUTTON TYPE 02 ACTION (lExec := .F.,Close(oDlg))
	ACTIVATE DIALOG oDlg CENTERED
	
	dbGoTop()
	If lExec
		Processa({|lEnd|u_FatBra(.T.)})
	Endif
	
	IndRegua("SE1", cIndexName, cIndexKey,, "E1_FILIAL=='" + XFILIAL("SE1") + "'" , "Aguarde selecionando registros....")
	
Return Nil

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³  MontaRel³ Autor ³ Microsiga             ³ Data ³ 13/10/03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ IMPRESSAO DO BOLETO LASER DO ITAU COM CODIGO DE BARRAS     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Especifico para Clientes Microsiga                         ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function FatBra( l_Local, l_Email)
	LOCAL oPrint
	LOCAL nX := 0
	Local cNroDoc :=  " "
	LOCAL aDadosEmp    := {	SM0->M0_NOMECOM                                    ,; //[1]Nome da Empresa
	SM0->M0_ENDCOB                                     ,; //[2]Endereço
	AllTrim(SM0->M0_BAIRCOB)+", "+AllTrim(SM0->M0_CIDCOB)+", "+SM0->M0_ESTCOB ,; //[3]Complemento
	"CEP: "+Subs(SM0->M0_CEPCOB,1,5)+"-"+Subs(SM0->M0_CEPCOB,6,3)             ,; //[4]CEP
	"PABX/FAX: "+SM0->M0_TEL                                                  ,; //[5]Telefones
	"CNPJ: "+Subs(SM0->M0_CGC,1,2)+"."+Subs(SM0->M0_CGC,3,3)+"."+          ; //[6]
	Subs(SM0->M0_CGC,6,3)+"/"+Subs(SM0->M0_CGC,9,4)+"-"+                       ; //[6]
	Subs(SM0->M0_CGC,13,2)                                                    ,; //[6]CGC
	"I.E.: "+Subs(SM0->M0_INSC,1,3)+"."+Subs(SM0->M0_INSC,4,3)+"."+            ; //[7]
	Subs(SM0->M0_INSC,7,3)+"."+Subs(SM0->M0_INSC,10,3)                        }  //[7]I.E
	
	LOCAL aDadosTit
	LOCAL aDadosBanco
	LOCAL aDatSacado
	
	LOCAL nI           	:= 1
	LOCAL aCB_RN_NN    	:= {}
	LOCAL nVlrAbat		:= 0
	
	Private aBolText 	:= {}
	Private cCart		:= "09"				&& Vitor Sbano -definição de Carteira - Reimpressao

	Default l_Email 	:= .F.
	
	oPrint:= TMSPrinter():New( "Boleto Laser" )
	oPrint:SetPortrait() // ou SetLandscape()
	oPrint:StartPage()   // Inicia uma nova página
	
	lMosNumBco := .F.		// Tratamento emergencial de Bug para retorno do SISDEB
	
	iF l_Local
		
		dbGoTop()
		ProcRegua(RecCount())
		
	EndIf
	
	Do While !EOF()
		
		// >> 23/11/2007
		// Tratamento emergencial de Bug para retorno do SISDEB
		IF LEN(Alltrim(SE1->E1_NUMBCO)) = 15
			If !lMosNumBco
				MsgAlert("Atencao! Número do banco inválido no título em questão! Informe equipe de TI! Esta mensagem será demonstrada apenas 1 vez!")
				lMosNumBco := .T.
			ENDIF
			dbSkip()
			IncProc()
			Loop
		ENDIF
		// << 23/11/2007
		
		//Posiciona o SA6 (Bancos)
		DbSelectArea("SA6")
		DbSetOrder(1)
		DbSeek(xFilial("SA6")+SE1->E1_PORTADO+SE1->E1_AGEDEP+SE1->E1_CONTA,.T.)
		
		DbSelectArea("SA1")
		DbSetOrder(1)
		DbSeek(xFilial()+SE1->E1_CLIENTE+SE1->E1_LOJA,.T.)
		
		DbSelectArea("SE1")
		/*           mbc
		// >> PH
		aDadosBanco  := {SA6->A6_COD                        ,; 							// [1]Numero do Banco
		SA6->A6_NOME      	            	                  ,; 	// [2]Nome do Banco
		SUBSTR(SA6->A6_AGENCIA, 1, 4)                        ,; 		// [3]Agência
		SUBSTR(SA6->A6_NUMCON,1,Len(AllTrim(SA6->A6_NUMCON))-1),; 	// [4]Conta Corrente
		SUBSTR(SA6->A6_NUMCON,Len(AllTrim(SA6->A6_NUMCON)),1) } // (*) ,; 	// [5]Dígito da conta corrente
		*/
		aDadosBanco  := {	SA6->A6_COD                                          	,;  //Numero do Banco
		SA6->A6_NOME                                        	,;  //Nome do Banco
		SA6->A6_AGENCIA					                       	,;  //Agencia
		SA6->A6_NUMCON											,; 	//Conta Corrente
		SA6->A6_DVCTA											}   //Dígito da conta corrente
		
		
		//cCart														}
		// (*) Alteração para ser idêntico ao boleto do PLS
		//" "                                              		}		// [6]Codigo da Carteira
		// << PH
		
		If Empty(SA1->A1_ENDCOB)
			aDatSacado   := {AllTrim(SA1->A1_NOME)           ,;      	// [1]Razão Social
			AllTrim(SA1->A1_COD )+"-"+SA1->A1_LOJA           ,;      	// [2]Código
			AllTrim(SA1->A1_END )+"-"+AllTrim(SA1->A1_BAIRRO),;      	// [3]Endereço
			AllTrim(SA1->A1_MUN )                            ,;  			// [4]Cidade
			SA1->A1_EST                                      ,;     		// [5]Estado
			SA1->A1_CEP                                      ,;      	// [6]CEP
			SA1->A1_CGC										          ,;  			// [7]CGC
			SA1->A1_PESSOA										}       				// [8]PESSOA
		Else
			aDatSacado   := {AllTrim(SA1->A1_NOME)            	 ,;   	// [1]Razão Social
			AllTrim(SA1->A1_COD )+"-"+SA1->A1_LOJA              ,;   	// [2]Código
			AllTrim(SA1->A1_ENDCOB)+"-"+AllTrim(SA1->A1_BAIRROC),;   	// [3]Endereço
			AllTrim(SA1->A1_MUNC)	                             ,;   	// [4]Cidade
			SA1->A1_ESTC	                                     ,;   	// [5]Estado
			SA1->A1_CEPC                                        ,;   	// [6]CEP
			SA1->A1_CGC												 		 ,;		// [7]CGC
			SA1->A1_PESSOA												 }				// [8]PESSOA
		Endif
		
		nVlrAbat   :=  SomaAbat(SE1->E1_PREFIXO,SE1->E1_NUM,SE1->E1_PARCELA,"R",1,,SE1->E1_CLIENTE,SE1->E1_LOJA)
		
		//Aqui defino parte do nosso numero. Sao 8 digitos para identificar o titulo.
		//Abaixo apenas uma sugestao
		
		cNroDoc	:= " " //StrZero(	Val(Alltrim(SE1->E1_NUM)+Alltrim(SE1->E1_PARCELA)),8)
		
		// >> PH - Cópia da rotina do Jean para utilizar a mesma sequência de numeração
		If Empty(E1_NUMBCO)
			
			SEE->(dbSetOrder(1))
			///altamiro refaz loop do parametro bancarios ---- altamiro ---- 18/09/10
			SEE->(DbGoTop())
			/////////////////////////////////////////////////////////////////////////
			// O Find abaixo não localizou o registro no Ambiente teste, por isso estou percorrendo para conta ='006'
			//		If SEE->(dbSeek(xFilial("SEE")+aDadosBanco[1]+aDadosBanco[3]+aDadosBanco[4]+aDadosBanco[5]+"006"))
			WHILE !SEE->(EOF())
				//IF SEE->EE_AGENCIA==aDadosBanco[3] .AND. SEE->EE_SUBCTA=="006"
				IF SEE->EE_SUBCTA=="006"
					cNumAtu := SEE->EE_FAXATU
					SE1->(RecLock("SE1",.F.))
					SE1->E1_NUMBCO := cNumAtu
					
					SE1->(MsUnlock())
					
					//INCREMENTA O NOSSO NUMERO
					cNumAtu := soma1(Substr(SEE->EE_FAXATU,1,Len(Alltrim(SEE->EE_FAXATU))))
					SEE->(RecLock("SEE",.F.))
					SEE->EE_FAXATU := cNumAtu
					SEE->(MsUnlock())
					
				Endif
				
				SEE->(DBSKIP())
			END
			//	 EndIf
		Else
			//************************************
			
			DbSelectArea("SEA")
			DbSetOrder(1)
			Dbseek(xFilial("SEA")+SE1->E1_NUMBOR+SE1->E1_PREFIXO+SE1->E1_NUM+SE1->E1_PARCELA+SE1->E1_TIPO)

			csubcon := Iif(Empty(SEA->EA_XSUBCON),"001", SEA->EA_XSUBCON) // Adicionado por Luiz Otavio 10/03/21 (possibilitar buscar qualquer sub-conta)
			
			DbSelectArea("SEE")
			DbSetOrder(1)
			// Início
			// Mateus Medeiros
			// Incluido em 21/09/2018 - Devido a inclusão de nova conta com uma carteira diferente da que estava pré-definida no codigo
			//If SEE->(dbSeek(xFilial("SEE")+aDadosBanco[1]+aDadosBanco[3]+aDadosBanco[4]+/*aDadosBanco[5]*/+"001"))
			If SEE->(dbSeek(xFilial("SEE")+aDadosBanco[1]+aDadosBanco[3]+aDadosBanco[4]+csubcon))
				//If Subs(aDadosBanco[1],1,3) == '001' //Banco do Brasil
				//cCart := '18'
				//ElseIf Subs(aDadosBanco[1],1,3) == '104' //CEF
				//cCart := '82'
				//ElseIf Subs(aDadosBanco[1],1,3) == '341' //Itau
				//cCart := '175'
				//ElseIf Subs(aDadosBanco[1],1,3) == '237' //Itau
				//cCart := '175'
				//EndIf
				
				cCart := SEE->EE_CODCART
			else
				cCart :="09"
			EndIf
			//************************************//
			// FIM - MATEUS MEDEIROS 			  //
			//************************************//
		ENDIF

		DbSelectArea("SE1") // Adicionado por Luiz Otávio em 05/04/2020 * Corrigir impressão na posição do usuario 
		
		cNroDoc := ALLTRIM(SE1->E1_NUMBCO)
		
		aCB_RN_NN    := 	Ret_cBarra(	Subs(aDadosBanco[1],1,3),;
			aDadosBanco[3],;
			aDadosBanco[4],;
			aDadosBanco[5],;
			Strzero(Val(Alltrim(E1_NUM)),6)+StrZERO(Val(Alltrim(E1_PARCELA)),2),;
			E1_SALDO - nVlrAbat,;
			E1_PREFIXO,;
			E1_NUM,;
			E1_PARCELA,;
			E1_TIPO,;
			cCart)
		
		aDadosTit   :=  {	AllTrim(E1_NUM)+AllTrim(E1_PARCELA),; 	// [1] Numero do título
		E1_EMISSAO,;             				// [2] Data da emissão do título
		dDataBase,;             				// [3] Data da emissão do boleto
		E1_VENCTO,;             				// [4] Data do vencimento
		(E1_SALDO - nVlrAbat)		,;			// [5] Valor do título
		cNroDoc				   ,; 				// [6] Nosso numero (Ver fórmula para calculo)
		E1_PREFIXO                         	,;  // [7] Prefixo da NF
		E1_TIPO	                           	}   // [8] Tipo do Titulo
		
		If l_Local .and. Marked("E1_OK")
			
			Impress(oPrint,aDadosEmp,aDadosTit,aDadosBanco,aDatSacado,aBolText,aCB_RN_NN)
			nX := nX + 1
			
		Else
			
			Impress(oPrint,aDadosEmp,aDadosTit,aDadosBanco,aDatSacado,aBolText,aCB_RN_NN)
			Exit
			
		EndIf
		dbSkip()
		IncProc()
		nI := nI + 1
		
	EndDo
	
	oPrint:EndPage()     // Finaliza a página
	oPrint:Preview()     // Visualiza antes de imprimir
	
Return nil



/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³  Impress ³ Autor ³ Microsiga             ³ Data ³ 13/10/03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ IMPRESSAO DO BOLETO LASERDO ITAU COM CODIGO DE BARRAS      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Especifico para Clientes Microsiga                         ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function Impress(oPrint,aDadosEmp,aDadosTit,aDadosBanco,aDatSacado,aBolText,aCB_RN_NN)
	
	LOCAL oFont8
	LOCAL oFont11c
	LOCAL oFont10
	LOCAL oFont14
	LOCAL oFont16n
	LOCAL oFont15
	LOCAL oFont14n
	LOCAL oFont24
	LOCAL nI := 0
	
	PRIVATE cRefFT := ""
	
	//Parametros de TFont.New()
	//1.Nome da Fonte (Windows)
	//3.Tamanho em Pixels
	//5.Bold (T/F)
	oFont8  := TFont():New("Arial",9,8,.T.,.F.,5,.T.,5,.T.,.F.)
	oFont11c := TFont():New("Courier New",9,11,.T.,.T.,5,.T.,5,.T.,.F.)
	oFont10  := TFont():New("Arial",9,10,.T.,.T.,5,.T.,5,.T.,.F.)
	oFont12  := TFont():New("Arial",9,12,.T.,.T.,5,.T.,5,.T.,.F.)
	
	oFont20  := TFont():New("Arial",9,20,.T.,.T.,5,.T.,5,.T.,.F.)
	oFont21  := TFont():New("Arial",9,21,.T.,.T.,5,.T.,5,.T.,.F.)
	oFont16n := TFont():New("Arial",9,16,.T.,.F.,5,.T.,5,.T.,.F.)
	oFont15  := TFont():New("Arial",9,15,.T.,.T.,5,.T.,5,.T.,.F.)
	oFont15n := TFont():New("Arial",9,15,.T.,.F.,5,.T.,5,.T.,.F.)
	
	oFont24  := TFont():New("Arial",9,24,.T.,.T.,5,.T.,5,.T.,.F.)
	
	oPrint:StartPage()   // Inicia uma nova página
	
	
	/*****************/
	/* SEGUNDA PARTE */
	/*****************/
	
	nRow2 := -600 //-550
	
	// Pontilhado separador
	// For nI := 100 to 2300 step 50
	//	oPrint:Line(nRow2+0580, nI,nRow2+0580, nI+30)
	//	Next nI
	
	oPrint:Line (nRow2+0710,100,nRow2+0710,2300)
	oPrint:Line (nRow2+0710,500,nRow2+0630, 500)
	oPrint:Line (nRow2+0710,710,nRow2+0630, 710)
	
	//oPrint:Say  (nRow2+0644,100,"BANCO BRADESCO",oFont10 )		// [2]Nome do Banco           12
	
	oPrint:SayBitmap(nRow2+0644,100, "system\logo_bradesco.jpg", 350, 65) // Tem que estar abaixo do RootPath
	
	oPrint:Say  (nRow2+0635,520,aDadosBanco[1] + iif(cEmpAnt == '01', "-2","-7"),oFont21 )	// [1]Numero do Banco
	
	oPrint:Say  (nRow2+0644,1800,"Recibo do Sacado",oFont10)
	
	oPrint:Line (nRow2+0810,100,nRow2+0810,2300 )
	oPrint:Line (nRow2+0910,100,nRow2+0910,2300 )
	oPrint:Line (nRow2+0980,100,nRow2+0980,2300 )
	oPrint:Line (nRow2+1050,100,nRow2+1050,2300 )
	
	oPrint:Line (nRow2+0910,500,nRow2+1050,500)
	oPrint:Line (nRow2+0980,750,nRow2+1050,750)
	oPrint:Line (nRow2+0910,1000,nRow2+1050,1000)
	oPrint:Line (nRow2+0910,1300,nRow2+0980,1300)
	oPrint:Line (nRow2+0910,1480,nRow2+1050,1480)
	
	oPrint:Say  (nRow2+0710,100 ,"Local de Pagamento",oFont8)
	
	oPrint:Say  (nRow2+0725,400 ,"ATÉ O VENCIMENTO, PREFERENCIALMENTE NO BRADESCO",oFont10)
	oPrint:Say  (nRow2+0765,400 ,"APÓS O VENCIMENTO, SOMENTE NO BRADESCO",oFont10)
	
	oPrint:Say  (nRow2+0710,1810,"Vencimento"                                     ,oFont8)
	cString	:= StrZero(Day(aDadosTit[4]),2) +"/"+ StrZero(Month(aDadosTit[4]),2) +"/"+ Right(Str(Year(aDadosTit[4])),4)
	nCol := 1815+(374-(len(cString)*22))
	oPrint:Say  (nRow2+0750,1815,cString,oFont11c)
	
	oPrint:Say  (nRow2+0810,100 ,"Cedente"                                        ,oFont8)
	oPrint:Say  (nRow2+0850,100 ,alltrim(aDadosEmp[1])+" - "+alltrim(aDadosEmp[6])	,oFont10) //Nome + CNPJ
	
	oPrint:Say  (nRow2+0810,1810,"Agência/Código Cedente",oFont8)
	cString := Alltrim(aDadosBanco[3]+"/"+alltrim(aDadosBanco[4])+"-"+alltrim(aDadosBanco[5]))
	nCol := 1815+(374-(len(cString)*22))
	oPrint:Say  (nRow2+0850,1815,cString,oFont11c)
	
	oPrint:Say  (nRow2+0910,100 ,"Data do Documento"                              ,oFont8)
	
	oPrint:Say  (nRow2+0940,100, StrZero(Day(aDadosTit[3]),2) +"/"+ StrZero(Month(aDadosTit[3]),2) +"/"+ Right(Str(Year(aDadosTit[3])),4),oFont10)
	
	oPrint:Say  (nRow2+0910,505 ,"Nro.Documento"                                  ,oFont8)
	
	oPrint:Say  (nRow2+0940,605 ,aDadosTit[1]						,oFont10) //Numero
	
	oPrint:Say  (nRow2+0910,1005,"Espécie Doc."                                   ,oFont8)
	oPrint:Say  (nRow2+0940,1005," DM "                                           ,oFont10)
	
	oPrint:Say  (nRow2+0910,1305,"Aceite"                                         ,oFont8)
	oPrint:Say  (nRow2+0940,1400,"N"                                             ,oFont10)
	
	oPrint:Say  (nRow2+0910,1485,"Data do Processamento"                          ,oFont8)
	
	oPrint:Say  (nRow2+0940,1550,StrZero(Day(aDadosTit[2]),2) +"/"+ StrZero(Month(aDadosTit[2]),2) +"/"+ Right(Str(Year(aDadosTit[2])),4),oFont10) // Data impressao
	
	oPrint:Say  (nRow2+0910,1810,"Nosso Número"                                   ,oFont8)
	
	//oPrint:Say  (nRow2+0940,nCol,cCart+"/"+aDadosTit[6]+"-"+U_Calc_DigCab(aDadosBanco[3]+aDadosBanco[4]+cCart+aDadosTit[6]),oFont11c)		&& Original 13/12/13 - Vitor
	oPrint:Say    (nRow2+0940,1815,cCart+"/"+aDadosTit[6]+"-"+U_CalcDVBrad(substr(cCart,2,2)+aDadosTit[6]),oFont11c)
	//oPrint:Say  (2230,1950,cCart+"/"+aDadosTit[6]+"-"+U_CalcDVBrad(substr(cCart,2,2)+aDadosTit[6])          ,oFont10)		&& Extraido Bol_Brades - Vitor Sbano 10/12/13
	
	oPrint:Say  (nRow2+0980,100 ,"Uso do Banco"                                   ,oFont8)
	
	oPrint:Say  (nRow2+0980,505 ,"Carteira"                                       ,oFont8)
	oPrint:Say  (nRow2+1010,555 ,cCart                                  	,oFont10)
	
	oPrint:Say  (nRow2+0980,755 ,"Espécie"                                        ,oFont8)
	oPrint:Say  (nRow2+1010,805 ,"R$"                                             ,oFont10)
	
	oPrint:Say  (nRow2+0980,1005,"Quantidade"                                     ,oFont8)
	oPrint:Say  (nRow2+0980,1485,"Valor"                                          ,oFont8)
	
	oPrint:Say  (nRow2+0980,1810,"Valor do Documento"                          	,oFont8)
	cString := Alltrim(Transform(aDadosTit[5],"@E 99,999,999.99"))
	nCol := 1815+(374-(len(cString)*22))
	oPrint:Say  (nRow2+1010,1815,cString ,oFont11c)
	
	oPrint:Say  (nRow2+1050,100 ,"Instruções (Todas informações deste bloqueto são de exclusiva responsabilidade do cedente)",oFont8)
	
	fCabFat(SE1->E1_PREFIXO, SE1->E1_NUM)
	
	nII := 1
	
	**'-Inicio Marcela Coimbra - 19/05/2010 ---Solicitado por Keila --'**
	//IF !EMPTY(cRefFT)
	IF !EMPTY(cRefFT) .and.  cEmpAnt != GetNewPar("MV_XPAREM","02")
		**'-Fim Marcela Coimbra - 19/05/2010 -----------------------------'**
		nII := 1
		oPrint:Say  (nRow2+1100,100 , "Ref.: Negociação: " + cRefFT + ".", oFont10)
	ENDIF
	
	For nI := 0 + nII To len(aBolText)
		IF nII > 0
			oPrint:Say  (nRow2+1100+(nI*50),100 ,aBolText[nI][1]                                        ,oFont10)
		ENDIF
	Next nI
	
	oPrint:Say  (nRow2+1050,1810,"(-)Desconto/Abatimento"                         ,oFont8)
	oPrint:Say  (nRow2+1120,1810,"(-)Outras Deduções"                             ,oFont8)
	oPrint:Say  (nRow2+1190,1810,"(+)Mora/Multa"                                  ,oFont8)
	oPrint:Say  (nRow2+1260,1810,"(+)Outros Acréscimos"                           ,oFont8)
	oPrint:Say  (nRow2+1330,1810,"(=)Valor Cobrado"                               ,oFont8)
	
	oPrint:Say  (nRow2+1400,100 ,"Sacado"                                         ,oFont8)
	oPrint:Say  (nRow2+1430,400 ,aDatSacado[1]+" ("+aDatSacado[2]+")"             ,oFont10)
	oPrint:Say  (nRow2+1483,400 ,aDatSacado[3]                                    ,oFont10)
	
	oPrint:Say  (nRow2+1536,400 ,Substr(aDatSacado[6],1,5) + "-" + Substr(aDatSacado[6],6,3) + "    " + aDatSacado[4] +" - " + aDatSacado[5],oFont10) // CEP+Cidade+Estado
	
	oPrint:Say  (nRow2+1605,100 ,"Sacador/Avalista",oFont8)
	oPrint:Say  (nRow2+1645,1500,"Autenticação Mecânica",oFont8)
	
	oPrint:Line (nRow2+0710,1800,nRow2+1400,1800 )
	oPrint:Line (nRow2+1120,1800,nRow2+1120,2300 )
	oPrint:Line (nRow2+1190,1800,nRow2+1190,2300 )
	oPrint:Line (nRow2+1260,1800,nRow2+1260,2300 )
	oPrint:Line (nRow2+1330,1800,nRow2+1330,2300 )
	oPrint:Line (nRow2+1400,100 ,nRow2+1400,2300 )
	oPrint:Line (nRow2+1640,100 ,nRow2+1640,2300 )
	
	
	/******************/
	/* TERCEIRA PARTE */
	/******************/
	
	nRow3 := -650
	
	For nI := 100 to 2300 step 50
		oPrint:Line(nRow3+1880, nI, nRow3+1880, nI+30)
	Next nI
	
	oPrint:Line (nRow3+2000,100,nRow3+2000,2300)
	oPrint:Line (nRow3+2000,500,nRow3+1920, 500)
	oPrint:Line (nRow3+2000,710,nRow3+1920, 710)
	
	IF (((VALTYPE(aDadosBanco[2])) <> "U" .or. (VALTYPE(aDadosBanco[1])) <> "U" .or.(VALTYPE(aCB_RN_NN[2])) <> "U" ) .or. !empty (e1_numbco))
		//     oPrint:Say  (nRow3+1934,100,"BANCO BRADESCO",oFont10 )		// 	[2]Nome do Banco
		oPrint:SayBitmap(nRow3+1934,100, "system\logo_bradesco.jpg", 350, 65) // Tem que estar abaixo do RootPath
		oPrint:Say  (nRow3+1925,520,aDadosBanco[1]+iif(cEmpAnt == '01', "-2","-7"),oFont21 )	// 	[1]Numero do Banco      -7
		oPrint:Say  (nRow3+1934,755,aCB_RN_NN[2],oFont15n)			//		Linha Digitavel do Codigo de Barras
	EndIf
	
	oPrint:Line (nRow3+2100,100,nRow3+2100,2300 )
	oPrint:Line (nRow3+2200,100,nRow3+2200,2300 )
	oPrint:Line (nRow3+2270,100,nRow3+2270,2300 )
	oPrint:Line (nRow3+2340,100,nRow3+2340,2300 )
	
	oPrint:Line (nRow3+2200,500 ,nRow3+2340,500 )
	oPrint:Line (nRow3+2270,750 ,nRow3+2340,750 )
	oPrint:Line (nRow3+2200,1000,nRow3+2340,1000)
	oPrint:Line (nRow3+2200,1300,nRow3+2270,1300)
	oPrint:Line (nRow3+2200,1480,nRow3+2340,1480)
	
	oPrint:Say  (nRow3+2000,100 ,"Local de Pagamento",oFont8)
	oPrint:Say  (nRow3+2015,400 ,"ATÉ O VENCIMENTO, PREFERENCIALMENTE NO BRADESCO ",oFont10)
	oPrint:Say  (nRow3+2055,400 ,"APÓS O VENCIMENTO, SOMENTE NO BRADESCO ",oFont10)
	
	oPrint:Say  (nRow3+2000,1810,"Vencimento",oFont8)
	cString := StrZero(Day(aDadosTit[4]),2) +"/"+ StrZero(Month(aDadosTit[4]),2) +"/"+ Right(Str(Year(aDadosTit[4])),4)
	nCol	 	 := 1815+(374-(len(cString)*22))
	oPrint:Say  (nRow3+2040,1815,cString,oFont11c)
	
	oPrint:Say  (nRow3+2100,100 ,"Cedente",oFont8)
	oPrint:Say  (nRow3+2140,100 ,aDadosEmp[1]+"- "+aDadosEmp[6]	,oFont10) //Nome + CNPJ
	
	oPrint:Say  (nRow3+2100,1810,"Agência/Código Cedente",oFont8)
	cString := Alltrim(aDadosBanco[3]+"/"+alltrim(aDadosBanco[4])+"-"+alltrim(aDadosBanco[5]))
	nCol 	 := 1815+(374-(len(cString)*22))
	oPrint:Say  (nRow3+2140,1815,cString ,oFont11c)
	
	
	oPrint:Say  (nRow3+2200,100 ,"Data do Documento"                              ,oFont8)
	
	oPrint:Say (nRow3+2230,100, StrZero(Day(aDadosTit[3]),2) +"/"+ StrZero(Month(aDadosTit[3]),2) +"/"+ Right(Str(Year(aDadosTit[3])),4), oFont10)
	
	oPrint:Say  (nRow3+2200,505 ,"Nro.Documento"                                  ,oFont8)
	oPrint:Say  (nRow3+2230,605 ,aDadosTit[1]						,oFont10) //Prefixo +Numero+Parcela
	
	oPrint:Say  (nRow3+2200,1005,"Espécie Doc."                                   ,oFont8)
	
	oPrint:Say  (nRow3+2200,1305,"Aceite"                                         ,oFont8)
	oPrint:Say  (nRow3+2230,1400,"N"                                             ,oFont10)
	
	oPrint:Say  (nRow3+2200,1485,"Data do Processamento"                          ,oFont8)
	
	oPrint:Say  (nRow3+2230,1550,StrZero(Day(aDadosTit[2]),2) +"/"+ StrZero(Month(aDadosTit[2]),2) +"/"+ Right(Str(Year(aDadosTit[2])),4)                               ,oFont10) // Data impressao
	
	oPrint:Say  (nRow3+2200,1810,"Nosso Número"                                   ,oFont8)
	
	oPrint:Say  (nRow3+2230,1815,cCart+"/"+aDadosTit[6]+"-"+U_Calc_DigCab(aDadosBanco[3]+aDadosBanco[4]+cCart+aDadosTit[6]),oFont11c)
	
	oPrint:Say  (nRow3+2270,100 ,"Uso do Banco"                                   ,oFont8)
	
	oPrint:Say  (nRow3+2270,505 ,"Carteira"                                       ,oFont8)
	oPrint:Say  (nRow3+2300,555 ,cCart                                  	,oFont10)
	
	oPrint:Say  (nRow3+2270,755 ,"Espécie"                                        ,oFont8)
	oPrint:Say  (nRow3+2300,805 ,"R$"                                             ,oFont10)
	
	oPrint:Say  (nRow3+2270,1005,"Quantidade"                                     ,oFont8)
	oPrint:Say  (nRow3+2270,1485,"Valor"                                          ,oFont8)
	
	oPrint:Say  (nRow3+2270,1810,"Valor do Documento"                          	,oFont8)
	cString := Alltrim(Transform(aDadosTit[5],"@E 99,999,999.99"))
	nCol 	 := 1815+(374-(len(cString)*22))
	oPrint:Say  (nRow3+2300,1815,cString,oFont11c)
	
	oPrint:Say  (nRow3+2340,100 ,"Instruções (Todas informações deste bloqueto são de exclusiva responsabilidade do cedente)",oFont8)
	
	nII := 1
	
	
	**'-Inicio Marcela Coimbra - 19/05/2010 ---Solicitado por Keila --'**
	//IF !EMPTY(cRefFT)
	IF !EMPTY(cRefFT) .and.  cEmpAnt != GetNewPar("MV_XPAREM","02")
		**'-Fim Marcela Coimbra - 19/05/2010 -----------------------------'**
		
		nII := 1
		oPrint:Say  (nRow3+2390,100 , "Ref.: Negociação: " + cRefFT + ".", oFont10)
	ENDIF
	
	For nI := 0 + nII To len(aBolText)
		IF nII > 0
			oPrint:Say  (nRow3+2390+(nI*50),100 ,aBolText[nI][1]                                        ,oFont10)
		ENDIF
	Next nI
	
	oPrint:Say  (nRow3+2340,1810,"(-)Desconto/Abatimento"                         ,oFont8)
	oPrint:Say  (nRow3+2410,1810,"(-)Outras Deduções"                             ,oFont8)
	oPrint:Say  (nRow3+2480,1810,"(+)Mora/Multa"                                  ,oFont8)
	oPrint:Say  (nRow3+2550,1810,"(+)Outros Acréscimos"                           ,oFont8)
	oPrint:Say  (nRow3+2620,1810,"(=)Valor Cobrado"                               ,oFont8)
	
	oPrint:Say  (nRow3+2690,100 ,"Sacado"                                         ,oFont8)
	oPrint:Say  (nRow3+2700,400 ,aDatSacado[1]+" ("+aDatSacado[2]+")"             ,oFont10)
	
	oPrint:Say  (nRow3+2753,400 ,aDatSacado[3]                                    ,oFont10)
	oPrint:Say  (nRow3+2806,400 ,aDatSacado[6]+"    "+aDatSacado[4]+" - "+aDatSacado[5],oFont10) // CEP+Cidade+Estado
	
	oPrint:Say  (nRow3+2815,100 ,"Sacador/Avalista"                               ,oFont8)
	oPrint:Say  (nRow3+2855,1500,"Autenticação Mecânica - Ficha de Compensação"                        ,oFont8)
	
	oPrint:Line (nRow3+2000,1800,nRow3+2690,1800 )
	oPrint:Line (nRow3+2410,1800,nRow3+2410,2300 )
	oPrint:Line (nRow3+2480,1800,nRow3+2480,2300 )
	oPrint:Line (nRow3+2550,1800,nRow3+2550,2300 )
	oPrint:Line (nRow3+2620,1800,nRow3+2620,2300 )
	oPrint:Line (nRow3+2690,100 ,nRow3+2690,2300 )
	
	oPrint:Line (nRow3+2850,100,nRow3+2850,2300  )
	
	//MSBAR3("INT25",19.7,1,aCB_RN_NN[1],oPrint,.F.,Nil,Nil,0.025,1.5,Nil,Nil,"A",.F.)
	MSBAR3("INT25",19,1,aCB_RN_NN[1],oPrint,.F.,Nil,Nil,0.025,1.5,Nil,Nil,"A",.F.)
	
	oPrint:EndPage() // Finaliza a página
	
	U_fLogBol()// Log de Impressao
	
Return Nil



/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ Modulo10 ³ Autor ³ Microsiga             ³ Data ³ 13/10/03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ IMPRESSAO DO BOLETO LASE DO ITAU COM CODIGO DE BARRAS      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Especifico para Clientes Microsiga                         ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function Modulo10(cData)
	
	LOCAL L,D,P := 0
	LOCAL B     := .F.
	L := Len(cData)
	B := .T.
	D := 0
	While L > 0
		P := Val(SubStr(cData, L, 1))
		If (B)
			P := P * 2
			If P > 9
				P := P - 9
			End
		End
		D := D + P
		L := L - 1
		B := !B
	End
	D := 10 - (Mod(D,10))
	If D = 10
		D := 0
	End
	
Return(D)



/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ Modulo11 ³ Autor ³ Microsiga             ³ Data ³ 13/10/03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ IMPRESSAO DO BOLETO LASER DO ITAU COM CODIGO DE BARRAS     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Especifico para Clientes Microsiga                         ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function Modulo11(cData)
	
	LOCAL L, D, P := 0
	L := Len(cdata)
	D := 0
	P := 1
	While L > 0
		P := P + 1
		D := D + (Val(SubStr(cData, L, 1)) * P)
		If P = 9
			P := 1
		End
		L := L - 1
	End
	
	D := 11 - (mod(D,11))
	If (D == 0 .Or. D == 1 .Or. D == 10 .Or. D == 11)
		D := 1
	End
	
Return(D)


Static Function Ret_cBarra(	cBanco	,cAgencia	,cConta		,cDacCC		,;
		cNroDoc	,nValor		,cPrefixo	,cNumero	,;
		cParcela	,cTipo	,cCart)
	Local cMsg     := ""
	Local aArea		:= GetArea()
	Local aCodBar	:= {}
	Local cMoeda	:= "9"
	
	DbSelectArea("SE1")
	DbSetOrder(1)
	If MsSeek(xFilial("SE1")+cPrefixo+cNumero+cParcela+cTipo)
		If !ExistBlock("RETDADOS")
			MsgInfo("O RDMAKE, RETDADOS, referente ao layout do boleto, não foi encontrado no repositório")
		Else
			aCodBar:=U_RetDados(	cPrefixo	,cNumero	,cParcela	,cTipo	,;
				cBanco		,cAgencia	,cConta		,cDacCC	,;
				cNroDoc		,nValor		,cCart		,cMoeda	)
			If Len(aCodBar)=3
				If Empty(aCodBar[1])
					cMsg     += "[1]codigo de barra "
				EndIf
				If Empty(aCodBar[2])
					cMsg     += "[2]linha digitavel "
				EndIf
				If Empty(aCodBar[3])
					cMsg     += "[3]nosso numero "
				EndIf
				If !empty(cMsg)
					MsgInfo("Erro no(s) campo(s): " + cMsg + " Do Titulo :"+cPrefixo+" "+cNumero+" "+cParcela+" "+cTipo)
					//				aCodBar	:= {}         altamiro // Ao Processar o proximo registro da erro no arai
				EndIf
			EndIf
		Endif
	EndIf
	RestArea(aArea)
Return aCodBar

/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ AjustaSx1    ³ Autor ³ Microsiga            	³ Data ³ 13/10/03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Verifica/cria SX1 a partir de matriz para verificacao          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Especifico para Clientes Microsiga                    	  		³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function AjustaSX1(cPerg, aPergs)
	
	Local _sAlias	:= Alias()
	Local aCposSX1	:= {}
	Local nX 		:= 0
	Local lAltera	:= .F.
	Local nCondicao
	Local cKey		:= ""
	Local nJ			:= 0
	
	aCposSX1:={"X1_PERGUNT","X1_PERSPA","X1_PERENG","X1_VARIAVL","X1_TIPO","X1_TAMANHO",;
		"X1_DECIMAL","X1_PRESEL","X1_GSC","X1_VALID",;
		"X1_VAR01","X1_DEF01","X1_DEFSPA1","X1_DEFENG1","X1_CNT01",;
		"X1_VAR02","X1_DEF02","X1_DEFSPA2","X1_DEFENG2","X1_CNT02",;
		"X1_VAR03","X1_DEF03","X1_DEFSPA3","X1_DEFENG3","X1_CNT03",;
		"X1_VAR04","X1_DEF04","X1_DEFSPA4","X1_DEFENG4","X1_CNT04",;
		"X1_VAR05","X1_DEF05","X1_DEFSPA5","X1_DEFENG5","X1_CNT05",;
		"X1_F3", "X1_GRPSXG", "X1_PYME","X1_HELP" }
	
	dbSelectArea("SX1")
	dbSetOrder(1)
	
	For nX:=1 to Len(aPergs)
		lAltera := .F.
		If MsSeek(cPerg+Right(aPergs[nX][11], 2))
			If (ValType(aPergs[nX][Len(aPergs[nx])]) = "B" .And.;
					Eval(aPergs[nX][Len(aPergs[nx])], aPergs[nX] ))
				aPergs[nX] := ASize(aPergs[nX], Len(aPergs[nX]) - 1)
				lAltera := .T.
			Endif
		Endif
		
		If ! lAltera .And. Found() .And. X1_TIPO <> aPergs[nX][5]
			lAltera := .T.		// Garanto que o tipo da pergunta esteja correto
		Endif
		
		If ! Found() .Or. lAltera
			RecLock("SX1",If(lAltera, .F., .T.))
			Replace X1_GRUPO with cPerg
			Replace X1_ORDEM with Right(aPergs[nX][11], 2)
			For nj:=1 to Len(aCposSX1)
				If 	Len(aPergs[nX]) >= nJ .And. aPergs[nX][nJ] <> Nil .And.;
						FieldPos(AllTrim(aCposSX1[nJ])) > 0
					Replace &(AllTrim(aCposSX1[nJ])) With aPergs[nx][nj]
				Endif
			Next nj
			MsUnlock()
			cKey := "P."+AllTrim(X1_GRUPO)+AllTrim(X1_ORDEM)+"."
			
			If ValType(aPergs[nx][Len(aPergs[nx])]) = "A"
				aHelpSpa := aPergs[nx][Len(aPergs[nx])]
			Else
				aHelpSpa := {}
			Endif
			
			If ValType(aPergs[nx][Len(aPergs[nx])-1]) = "A"
				aHelpEng := aPergs[nx][Len(aPergs[nx])-1]
			Else
				aHelpEng := {}
			Endif
			
			If ValType(aPergs[nx][Len(aPergs[nx])-2]) = "A"
				aHelpPor := aPergs[nx][Len(aPergs[nx])-2]
			Else
				aHelpPor := {}
			Endif
			
			PutSX1Help(cKey,aHelpPor,aHelpEng,aHelpSpa)
		Endif
	Next
	
Return



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³PLR240TEXTºAutor  ³Rafael M. Quadrotti º Data ³  02/04/04   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Retorna as mensagens para impressao.                        º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±º          ³ Esta funcao executa uma selecao em tres tabelas para       º±±
±±º          ³ encontrar a msg relacionada ao sacado.                     º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP6                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function PLR240TEXT(	nTipo	,cCodInt	,cCodEmp	,cConEmp,;
		cSubCon	,cMatric	,cBase	)//cBase = Ano+mes
	Local cQuery	:= ""
	Local cNTable1	:= "" // Nome da tabela no SQL
	Local cNTable2	:= "" // Nome da tabela no SQL
	Local cNTable3	:= "" // Nome da tabela no SQL
	Local aMsg		:= {} // Array de mensagens
	Local nCont		:= 0
	Local cMsg01    := ""
	Local nLimite   := 90 // limite linha msg Motta 16/8/07
	
	DbSelectArea("BH1")
	DbSetOrder(2)
	cNTable1 := RetSqlName("BH1")
	cNTable2 := RetSqlName("BA3")
	cNTable3 := RetSqlName("BH2")
	
	cQuery := "SELECT BH1.* ,BH2.* "
	If !Empty(cMatric)
		cQuery += " ,BA3.BA3_CODPLA,BA3.BA3_FILIAL,BA3.BA3_CODINT,BA3.BA3_CODEMP,BA3.BA3_MATRIC,BA3.BA3_CONEMP,BA3.BA3_VERCON,BA3.BA3_SUBCON,BA3.BA3_VERSUB "
	Endif
	cQuery += " FROM " +cNTable1+ " BH1 , " +cNTable3 +" BH2 "
	If !Empty(cMatric)
		cQuery += " , "+cNTable2 +" BA3 "
	Endif
	
	//BH1
	cQuery += "WHERE BH1.BH1_FILIAL='"	+	xFilial("BH1")		+	"'    AND "
	cQuery += "		 BH1.BH1_CODINT='"	+	cCodInt				+	"'    AND "
	cQuery += "		 BH1.BH1_TIPO='"	+	Transform(nTipo,"9")+	"'    AND "
	If !Empty(cCodEmp)
		cQuery += "(('"+cCodEmp +"' BETWEEN BH1.BH1_EMPDE   AND BH1.BH1_EMPATE) OR (BH1.BH1_EMPATE='' AND BH1.BH1_EMPDE='') ) AND "
	EndIf
	If !Empty(cConEmp)
		cQuery += "(('"+cConEmp +"' BETWEEN BH1.BH1_CONDE   AND BH1.BH1_CONATE)  OR (BH1.BH1_CONATE='' AND BH1.BH1_CONDE='') ) AND "
	EndIf
	If !Empty(cSubCon)
		cQuery += "(('"+cSuBCon +"' BETWEEN BH1.BH1_SUBDE   AND BH1.BH1_SUBATE)  OR (BH1.BH1_SUBATE='' AND BH1.BH1_SUBDE='') ) AND "
	EndIf
	If !Empty(cMatric)
		cQuery += "(('"+cMatric +"' BETWEEN BH1.BH1_MATDE   AND BH1.BH1_MATATE)  OR (BH1.BH1_MATATE='' AND BH1.BH1_MATDE='') ) AND "
	EndIf
	If !Empty(cBase)
		cQuery += "(('"+cBase   +"' BETWEEN BH1.BH1_BASEIN AND BH1.BH1_BASEFI) OR (BH1.BH1_BASEIN='' AND BH1.BH1_BASEFI='') ) AND "
	EndIf
	//BA3 PARA ENCONTRAR O PLANO, CASO MATRICULA SEJA INFORMADA!
	If !Empty(cMatric)
		cQuery += "		 BA3.BA3_FILIAL='"	+	xFilial("BA3")	+	"'    AND "
		cQuery += "		 BA3.BA3_CODINT='"	+	cCodInt  		+	"'    AND "
		cQuery += "		 BA3.BA3_CODEMP='"	+	cCodEmp  		+	"'    AND "
		cQuery += "		 BA3.BA3_MATRIC='"	+	cMatric  		+	"'    AND "
		cQuery += "		((BA3.BA3_CODPLA BETWEEN BH1.BH1_PLAINI AND BH1.BH1_PLAFIM) OR (BH1.BH1_PLAINI='' AND BH1.BH1_PLAFIM='') ) AND "
	Endif
	
	//BH2 MENSAGENS PARA IMPRESSAO
	cQuery += "		 BH2.BH2_FILIAL = '"	+	xFilial("BH2")	+	"'    AND "
	cQuery += "		 BH2.BH2_CODIGO = BH1.BH1_CODIGO  AND "
	
	cQuery += "		BH1.D_E_L_E_T_<>'*' AND BH2.D_E_L_E_T_<>'*' "
	
	If !Empty(cMatric)
		cQuery += " AND BA3.D_E_L_E_T_<>'*' "
	Endif
	
	cQuery += "ORDER BY " + BH1->(IndexKey())
	
	PLSQuery(cQuery,"MSG")
	
	
	If MSG->(Eof())
		MSG->(DbCloseArea())
		Aadd(aMSG,"")
	Else
		While MSG->(!Eof())
			//If Iif(BH1->(FieldPos("BH1_CONDIC")) > 0 , (Empty(MSG->BH1_CONDIC) .or. (&(MSG->BH1_CONDIC))), .T.)
			If MSG->BH1_TIPO == '2' // Observacao
				cMsg01 := &(MSG->BH2_MSG01)
				Aadd(aMSG,Substr(cMsg01,1,nLimite)) // Paulo Motta 16/8/7
				Aadd(aMSG,Substr(cMsg01,(nLimite + 1),nLimite))
				Aadd(aMSG,Substr(cMsg01,(2*nLimite + 1),nLimite))
				Aadd(aMSG,Substr(cMsg01,(3*nLimite + 1),nLimite))
				Aadd(aMSG,Substr(cMsg01,(4*nLimite + 1),nLimite))
			Else
				Aadd(aMSG,&(MSG->BH2_MSG01))
			Endif
			//Endif
			MSG->(DbSkip()) //DbSkip()
		Enddo
		If Len(aMSG) == 0
			Aadd(aMSG,"")
		Endif
		MSG->(DbCloseArea())
	EndIf
	
Return aMsg


Static Function fCabFat(_cPref, _cNum)
	
	Local nI := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
	
	Local aArea		:= GetArea()
	
	aBolText := {}
	
	cQry := " SELECT MIN(R_E_C_N_O_) NRECNOSE1 , E1_ANOBASE, E1_MESBASE " //, E1_CODEMP , E1_CONEMP,E1_MATRIC,E1_SUBCON,E1_CODINT "
	cQry += " FROM " + RetSqlName("SE1")
	cQry += " WHERE D_E_L_E_T_ <> '*' "
	cQry += "   AND E1_FILIAL     = '" + xFilial("SE1") + "'"
	cQry += "   AND E1_FATPREF    = '" + _cPref + "'"
	cQry += "   AND E1_FATURA     = '" + _cNum  + "'"
	cQry += " GROUP BY E1_ANOBASE, E1_MESBASE "
	cQry += " ORDER BY E1_ANOBASE, E1_MESBASE"
	
	If TcSqlExec(cQry) < 0
		Return
	Endif
	
	If Select("QRY1") > 0
		QRY1->(DbCloseArea())
	Endif
	
	DbUseArea(.T., "TOPCONN", TCGenQry(,,cQry), 'QRY1', .F., .T.)
	
	QRY1->(DbGoTop())
	
	//DbSelectArea("SE1")
	//DbGoTo(QRY1->nRecnoSE1)
	// Cópia da Função existente em BOL_ITAUQRY1
	aMsgBoleto   := PLR240TEXT(1					,SE1->E1_CODINT	,SE1->E1_CODEMP,SE1->E1_CONEMP	,;
		SE1->E1_SUBCON	,SE1->E1_MATRIC ,SE1->E1_ANOBASE+SE1->E1_MESBASE)
	
	For nI := 1 To len(aMsgBoleto)
		Aadd(aBolText, {aMsgBoleto[nI] })
		If nI > 6
			Exit
		EndIf
	Next nI
	
	//---------------------------------------------------------------------------------
	// Inicio - Angelo Henrique - Data: 24/10/2019
	//---------------------------------------------------------------------------------
	//Atendendo a nova rotina de Liquidação(Antiga Fatura) necessário
	//fazer novo relacionamento para exibir informações
	//---------------------------------------------------------------------------------
	If QRY1->(EOF())
		
		cQry := " SELECT                                                		" + CRLF
		cQry += "     MIN(SE1PAI.R_E_C_N_O_) NRECNOSE1 ,                		" + CRLF
		cQry += "     SE1PAI.E1_ANOBASE,                                		" + CRLF
		cQry += "     SE1PAI.E1_MESBASE                                 		" + CRLF
		cQry += " FROM                                                  		" + CRLF
		cQry += "     " + RetSqlName("SE1") + " SE1FAT							" + CRLF
		cQry += "                                                       		" + CRLF
		cQry += "     INNER JOIN                                        		" + CRLF
		cQry += "     " + RetSqlName("FO2") + " FO2								" + CRLF
		cQry += "     ON                                                		" + CRLF
		cQry += "         FO2.FO2_FILIAL          = SE1FAT.E1_FILIAL			" + CRLF
		cQry += "         AND FO2.FO2_PREFIX      = SE1FAT.E1_PREFIXO			" + CRLF
		cQry += "         AND FO2.FO2_NUM         = SE1FAT.E1_NUM       		" + CRLF
		cQry += "         AND FO2.D_E_L_E_T_      = ' '                 		" + CRLF
		cQry += "                                                       		" + CRLF
		cQry += "     INNER JOIN                                        		" + CRLF
		cQry += "     " + RetSqlName("FO0") + " FO0								" + CRLF
		cQry += "     ON                                                		" + CRLF
		cQry += "         FO0.FO0_FILIAL          = FO2_FILIAL          		" + CRLF
		cQry += "         AND FO0.FO0_PROCES      = FO2_PROCES          		" + CRLF
		cQry += "         AND FO0.D_E_L_E_T_      = ' '                 		" + CRLF
		cQry += "                                                       		" + CRLF
		cQry += "     INNER JOIN                                        		" + CRLF
		cQry += "     " + RetSqlName("SE5") + " SE5								" + CRLF
		cQry += "     ON                                                		" + CRLF
		cQry += "         SE5.E5_FILIAL           = FO0.FO0_FILIAL      		" + CRLF
		cQry += "         AND SE5.E5_DOCUMEN      = FO0.FO0_NUMLIQ      		" + CRLF
		cQry += "         AND SE5.E5_MOTBX        = 'LIQ'               		" + CRLF
		cQry += "         AND SE5.D_E_L_E_T_      = ' '                 		" + CRLF
		cQry += "                                                       		" + CRLF
		cQry += "     INNER JOIN                                        		" + CRLF
		cQry += "     " + RetSqlName("SE1") + " SE1PAI							" + CRLF
		cQry += "     ON                                                		" + CRLF
		cQry += "         SE1PAI.E1_FILIAL        = SE5.E5_FILIAL       		" + CRLF
		cQry += "         AND SE1PAI.E1_PREFIXO   = SE5.E5_PREFIXO      		" + CRLF
		cQry += "         AND SE1PAI.E1_NUM       = SE5.E5_NUMERO       		" + CRLF
		cQry += "         AND SE1PAI.D_E_L_E_T_   = ' '                 		" + CRLF
		cQry += "                                                       		" + CRLF
		cQry += " WHERE                                                 		" + CRLF
		cQry += "     SE1FAT.E1_FILIAL            = '" + xFilial("SE1") + "'    " + CRLF
		cQry += "     AND SE1FAT.E1_PREFIXO       = '" + _cPref 		+ "' 	" + CRLF
		cQry += "     AND SE1FAT.E1_NUM           = '" + _cNum  		+ "'	" + CRLF
		cQry += "     AND SE1FAT.D_E_L_E_T_       = ' '                 		" + CRLF
		cQry += "                                                       		" + CRLF
		cQry += " GROUP BY                                              		" + CRLF
		cQry += "     SE1PAI.E1_ANOBASE,                                		" + CRLF
		cQry += "     SE1PAI.E1_MESBASE                                 		" + CRLF
		cQry += "                                                       		" + CRLF
		cQry += " ORDER BY                                              		" + CRLF
		cQry += "     SE1PAI.E1_ANOBASE,                                		" + CRLF
		cQry += "     SE1PAI.E1_MESBASE                                 		" + CRLF
		
		If Select("QRY1") > 0
			QRY1->(DbCloseArea())
		Endif
		
		DbUseArea(.T., "TOPCONN", TCGenQry(,,cQry), 'QRY1', .F., .T.)
		
		QRY1->(DbGoTop())
				
	EndIf
	//---------------------------------------------------------------------------------
	// FIM - Angelo Henrique - Data: 24/10/2019
	//---------------------------------------------------------------------------------
	
	DO WHILE !QRY1->(EOF())
		
		//If At(cRefFT, ALLTRIM(QRY1->E1_MESBASE) + "/" + ALLTRIM(QRY1->E1_ANOBASE)) = 0
		
		IF !EMPTY(cRefFT)
			cRefFT += ", "
		ENDIF
		cRefFT += ALLTRIM(QRY1->E1_MESBASE) + "/" + SUBSTR(ALLTRIM(QRY1->E1_ANOBASE),3,2)
		//Endif
		
		QRY1->(DBSKIP())
		
	ENDDO
	
	RestArea(aArea)
	
Return

