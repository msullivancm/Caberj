 #include "PROTHEUS.CH"
#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'TOPCONN.CH'   
#INCLUDE 'UTILIDADES.CH'   


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NOVO5     ºAutor  ³Microsiga           º Data ³  01/06/08   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ PONTO DE ENTRADA PARA TRATAMENTO DE VALORES PAGOS A MAIOR
±±º          ³ ONDE O BANCO ITAU ATRIBUI O VALOR A MAIOR NA COLUNA JUROS
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßmarcela.ßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function F_INA200()

Local a_Area    := GetArea()
Local n_Juros	:= round(val(substr(aBuffer[1], 268,12)), 2)*.01

/*If n_Juros > 0
                                                  
	fGeraac( n_Juros )

EndIf
*/

// Rotina antiga
Local nValMaior := 0
Local lGrvMovBc := .F.       

//alert("PE"+1)

If nJuros > 0 //.AND. SE1->E1_VENCREA <= dDataCred
	IF !EOF()
		RecLock("SE1",.F.)
		SE1->E1_JUROS   := 0
	   //	SE1->E1_SDACRES -= nJuros
		//SE1->E1_VLACRES -= nJuros
		MsUnLock()
		lGrvMovBc := .T.
	Endif
	
	If lGrvMovBc
		fGeraPagMaior(nJuros)
	Endif
	
Endif  

**'Marcela Coimbra - 25/03/2013'**
                                  
//	fApagaBxAtr()


**'Marcela Coimbra - 25/03/2013'**
RestArea(a_Area)  
//alert("PE - fim")

Return  

Static Function fGeraac( n_Juros )   

Local c_Num 	:= SE1->E1_NUM
Local c_Tipo 	:= "RA"
Local c_Valor 	:= n_Juros
Local a_GerSe1	:= {}

a_GerSe1 	:={			{"E1_PREFIXO" 	,"RAC"			,Nil},;
						{"E1_NUM"     	,SE1->E1_NUM	,Nil},;
						{"E1_TIPO"    	,"RA"			,Nil},;  
						{'cBancoAdt'	, '341'	,NIL},;
						{'cAgenciaAdt'	, '6015' 	,NIL},;
						{'cNumCon'		, '017251'	,NIL},;						
						{"E1_VALOR"     ,n_Juros 			,Nil},;
						{"E1_CODINT"    ,SE1->E1_CODINT	,Nil},;
						{"E1_CODEMP"   , SE1->E1_CODEMP	,Nil},;
						{"E1_CONEMP"  ,SE1->E1_CONEMP	,Nil},;
						{"E1_VERCON"  ,SE1->E1_VERCON	,Nil},;
						{"E1_SUBCON"  ,SE1->E1_SUBCON	,Nil},;
						{"E1_VERSUB"  ,SE1->E1_VERSUB	,Nil},;
						{"E1_MATRIC"  ,SE1->E1_MATRIC	,Nil},;
						{"E1_NATUREZ" ,SE1->E1_NATUREZ	,Nil},;
						{"E1_CLIENTE" ,SE1->E1_CLIENTE	,Nil},;
						{"E1_LOJA"    ,SE1->E1_LOJA 	,Nil},;
						{"E1_EMISSAO" ,dDataBase	,Nil},;
						{"E1_HIST"    ,SE1->E1_HIST		,Nil},;
						{"E1_VENCTO"  ,dDataBase	,Nil},;
						{"E1_VENCREA" ,dDataBase	,Nil},;
						{"E1_MESBASE" ,SE1->E1_MESBASE	,Nil},;
						{"E1_ANOBASE" ,SE1->E1_ANOBASE	,Nil} 	}         
						
						
						
lMsErroAuto := .F.
MsExecAuto({|x,y| Fina040(x,y)},a_GerSe1,3)

If lMsErroAuto
	
	MostraErro()
		
Endif

Return     

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³TFINA070  ºAutor  ³    Suporte Rdmake  º Data ³  04/10/02   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Exemplo Utilizacao rotina automatica-Bx. Titulos a Receber º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP6                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
//Devem ser passados no array(s) todos os campos obrigatorios
User Function FCANCBX()
Local aVetor := {}

lMsErroAuto := .F.

aVetor := {     {"E1_PREFIXO"	 ,"   "            ,Nil},;
				{"E1_NUM"		 ,"000001"         ,Nil},;
				{"E1_PARCELA"	 ," "              ,Nil},;
				{"E1_TIPO"	    ,"DP "             ,Nil},;
				{"AUTMOTBX"	    ,"NOR"             ,Nil},;
				{"AUTDTBAIXA"	 ,dDataBase        ,Nil},;
				{"AUTDTCREDITO" ,dDataBase         ,Nil},;
				{"AUTHIST"	    ,'Baixa Automatica',Nil},;
				{"AUTVALREC"	 ,125              ,Nil }}
MSExecAuto({|x,y| fina070(x,y)},aVetor,3) //Inclusao

If lMsErroAuto
	Alert("Erro")
Else
	Alert("Ok")
Endif                  

Return    

/*User Function FA070CA4() 

	
cQuery := " UPDATE "+RetSqlName("BSQ")+" BSQ SET BSQ.D_E_L_E_T_ = '*' WHERE TRIM(BSQ_YNMSE1) = '" + SE1->E1_PREFIXO + SE1->E1_NUM + "'" 
 	
If TcSqlExec(cQuery) < 0
	lRet := .F.	
ENDIF	
	

RestArea(aArea)

Return  .T.
*/

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³FINA200   ºAutor  ³Microsiga           º Data ³  01/06/08   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Cria movimentacao bancaria para titulos pagos maior         º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
*****************************************
Static Function fGeraPagMaior(nValMaior)
*****************************************
Local _cNatTit := "34401" //Chumbada a pedido do usuario
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Grava o Identificador de <R>ecebimento							  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//posiciona no cadastro de naturezas.
DbSelectArea("SED")
DbSetOrder(1)
DbSeek(xFilial("SED") +_cNatTit) 

dbSelectArea("SE5")
DbSetOrder(10)

If !Dbseek(SE1->E1_PREFIXO+SE1->E1_NUM+se1->e1_PARCELA+SE1->E1_TIPO)
	RecLock("SE5",.T.)
	SE5->E5_FILIAL   := SE1->E1_FILIAL
	SE5->E5_RECPAG   := "R"
	SE5->E5_BANCO    := MV_PAR06
	SE5->E5_AGENCIA  := MV_PAR07
	SE5->E5_CONTA    := MV_PAR08
	SE5->E5_DATA     := dBaixa
	SE5->E5_VALOR    := nValMaior
	SE5->E5_MOEDA    := "M1"
	SE5->E5_NATUREZ  := _cNatTit
	SE5->E5_VENCTO   := SE1->E1_VENCREA
	SE5->E5_DTDIGIT  := dDataBase
	SE5->E5_DTDISPO  := dDataCred
	SE5->E5_CLIENTE  := SE1->E1_CLIENTE
	SE5->E5_DOCUMEN  := SE1->E1_PREFIXO+SE1->E1_NUM+se1->e1_PARCELA+SE1->E1_TIPO
	SE5->E5_TIPOLAN  := "X"
	SE5->E5_BENEF    := SE1->E1_NOMCLI
	SE5->E5_HISTOR   := "PAGTO. A MAIOR TIT.: " + SE1->E1_PREFIXO+SE1->E1_NUM	
	
	IF SE5->E5_VENCTO <= SE5->E5_DATA
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Atualiza Saldo Bancario												  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		AtuSalBco(SE5->E5_BANCO,SE5->E5_AGENCIA,SE5->E5_CONTA,SE5->E5_DATA,SE5->E5_VALOR,"+")
	Endif
	
	MsUnLock()
	
	*ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	*³Lan‡amento Contabil                                                ³
	*ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	cPadrao:= "563"
	lPadrao:=VerPadrao(cPadrao)
	
	If lPadrao
		nHdlPrv:=HeadProva(cLote,"FINA100",Substr(cUsuario,7,6),@cArquivo)
		nTotal+=DetProva(nHdlPrv,cPadrao,"FINA100",cLote)
		RodaProva(nHdlPrv,nTotal)
		lAglutina:=Iif(mv_par01==1,.t.,.f.)
		lMostra	:=Iif(mv_par02==1,.t.,.f.)
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Envia para Lancamento Contabil				 		³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		cA100Incl(cArquivo,nHdlPrv,3,cLote,lMostra,lAglutina)
		
		Reclock("SE5")
		SE5->E5_LA := "S" + SubStr( E5_LA,2,1 )
		MsUnLock()
		
	Endif
Endif
Return (.t.)


