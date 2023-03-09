#INCLUDE "FINR560.CH"
#INCLUDE "PROTHEUS.CH"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o	 ³ FINR560	³ Autor ³ Bruno Sobieski        ³ Data ³ 02.07.00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Movimento do Caixinha			 						  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ FINR560(void)											  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ Sigafin  												  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß                                       
/*/
USER Function MCAIXINHA()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Local cDesc1         := STR0001 //"Este programa tiene como objetivo imprimir un "
Local cDesc2         := STR0002 //"informe de movimientos de Caja Chica de acuerdo con"
Local cDesc3         := STR0003 //"los parametros informados por el usuario."
Local titulo       	:= STR0027 //"Movimiento de caja chica"
Local nLin         	:= 80
Local Cabec1       	:= ""
Local Cabec2       	:= ""

Private lEnd         := .F.
Private lAbortPrint  := .F.
Private limite       := 132
Private tamanho      := "M"
Private nomeprog     := "U_FINR560" // Coloque aqui o nome do programa para impressao no cabecalho
Private nTipo        := 18
Private aReturn      := { STR0005, 1, STR0006, 2, 2, 1, "", 1} //"Zebrado"###"Administracao"
Private nLastKey     := 0
Private cPerg        := "MCAIXA"
Private CONTFL     	:= 1
Private m_pag      	:= 1
Private wnrel      	:= "U_FINR560" // Coloque aqui o nome do arquivo usado para impressao em disco
Private cString := "SEU"

dbSelectArea("SEU")
dbSetOrder(11) // Estava com 9 passei para 11 em 20/12/2013-OSP

Pergunte(cPerg,.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta a interface padrao com o usuario...                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

// Paulo Motta 16/1/07 Habilitando opcao de filtro (Teste)
//wnrel := SetPrint(cString,NomeProg,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,,.F.,Tamanho,,.F.)
wnrel := SetPrint(cString,NomeProg,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,,.F.,Tamanho,,.T.)
//

If nLastKey == 27
	Return
Endif

SetDefault(aReturn,cString)
//          10        20        30        40        50        60        70        80        90        100       110
//01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678
Cabec1       	:= STR0007+IIf(mv_par05==1,STR0008,"") //"Descripcion                     Usuario          Comprobante  Nro. Interno  Numero de   Fecha de             Valor"###"           Rendido"
Cabec2       	:= STR0009       //"                                                              de Movimiento Anticipo    Tipeo                          "

If nLastKey == 27
	Return
Endif

nTipo := If(aReturn[4]==1,15,18)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Processamento. RPTSTATUS monta janela com a regua de processamento. ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

RptStatus({|| RunReport(Cabec1,Cabec2,Titulo,nLin) },Titulo)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Finaliza a execucao do relatorio...                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SET DEVICE TO SCREEN

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Se impressao em disco, chama o gerenciador de impressao...          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If aReturn[5]==1
	dbCommitAll()
	SET PRINTER TO
	OurSpool(wnrel)
Endif  


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Opcao de filtro Paulo Motta 16/1/07                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If !Empty(aReturn[7])
  SET FILTER TO &(aReturn[7])
Endif 

//

MS_FLUSH()

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFun‡„o    ³RUNREPORT º Autor ³ Bruno Sobieski     º Data ³  02/07/00   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescri‡„o ³ Funcao auxiliar chamada pela RPTSTATUS. A funcao RPTSTATUS º±±
±±º          ³ monta a janela com a regua de processamento.               º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Programa principal                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function RunReport(Cabec1,Cabec2,Titulo,nLin)
Local cAdia,lSaldo	:=	.T.
Local aArea
Local cCaixa		:=	""
Local lPrinted 	:=	.F.
Local cbtxt	      	:= Space(10)
Local cbcont	     	:= 1 
Local cConta  :=""        
Local cTESTE  :=""    
Local cCaixaTemp:="" //auxilia a escrever o total por conta Raquel
	                
Private cSaldo	:=0      //acumula o total por conta Raquel
Private nSaldo	:=	0
Private	nSaldoTot:= 0     
Private SaldoAnt:=0  //saldo anterior

dbSelectArea("SEU")
dbSetOrder(11)  //teste ESTAVA 9
SetRegua(RecCount())
           
DbSeek(xFilial()+mv_par01+mv_par07+DTOS(mv_par03),.T.)

While !EOF() .And.xFilial() == EU_FILIAL .And. EU_CAIXA <= MV_PAR02 .And. EU_CONTA <= MV_PAR08 
	IncRegua()  

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica o cancelamento pelo usuario...                             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	If lAbortPrint
		@nLin,00 PSAY STR0010 //"*** CANCELADO PELO OPERADOR ***"
		Exit
	Endif
	If mv_par05 <> 1 .And.(EU_TIPO	==	"01" .And. EU_SLDADIA == 0)
		DbSkip()
		Loop
	Endif
   	//If EU_TIPO == "02"    //Raquel
   //		DbSkip()        //Raquel
  //		Loop            //Raquel
 //	Endif                   //Raquel
	//Vou me posicionar no primeiro registro para porcessar de acordo com a data de inicio.
	If EU_DTDIGIT > mv_par04 .and. cConta>mv_par08 .And. cCaixa == EU_CAIXA  
		SET->(DbSetOrder(1))
		SET->(DbSeek(xFilial()+SEU->EU_CAIXA))
		SET->(DbSkip())                	
		If !SET->(EOF())  .and. SET->ET_FILIAL == xFilial("SET") .and. (SET->ET_CODIGO >= mv_par01 .and. SET->ET_CODIGO <= mv_par02)
			SEU->(DbSeek(xFilial()+SET->ET_CODIGO+DTOS(mv_par03),.T.))  
		Else                                 
			Exit                                             
		EndIf    
	Endif

	dbSelectArea("SEU")
	If EU_CAIXA < MV_PAR01 .or. EU_CAIXA > MV_PAR02  .OR. EU_CONTA < MV_PAR07 .or. EU_CONTA > MV_PAR08  
		Exit
	Endif

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Impressao do cabecalho do relatorio. . .                            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If nLin > 58 // Salto de Página. Neste caso o formulario tem 55 linhas...
		Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
		nLin := 8
	Endif
	
	//Posicionar no primeiro registro de acordo com a data escolhida.
	If cCaixa <> EU_CAIXA .And. mv_par06 == 1
		SEU->(DbSeek(xFilial()+EU_CAIXA+EU_CONTA+DTOS(mv_par03),.T.))
		If !lSaldo
			nLin++
			@nLin, 077 PSAY IIf(mv_par06==1,STR0013,STR0014) //"Saldo Caja ---->"###"Total Gastos ---->"
			@nLin, 098 PSAY nSaldo	PICTURE PesqPict("SEU","EU_VALOR",16) 
			nSaldoTot	+=	nSaldo
			nSaldo	:=	0    
			cSaldo:=0
			lSaldo	:=	.T.
			lPrinted :=	.F.
		Endif
	Endif
	
	If mv_par06 == 1 .And. !Empty(EU_NROADIA)
		aArea	:=	GetArea()
		DbSetOrder(3)
		DbSeek(xFilial()+EU_NROADIA+EU_NUM)
		If (EU_SLDADIA > 0 .and. mv_par05 == 1) .or. EU_TIPO=='00'  //RAQUEL TESTE TROQUEI .OR. POR .AND. e adicionei .or. EU_TIPO=='00'
			RestArea(aArea)
			DbSkip()
			Loop
		Endif
		RestArea(aArea)
	Endif
	
	If mv_par06 == 2 .And. EU_TIPO <> "00" //So listar despesas
		DbSkip()
		Loop
	Endif
	
	If !lPrinted    
		If !Empty(cCaixa)
			nLin+=2
		Else
			nLin++
		Endif
		SET->(DbSetOrder(1))
		SET->(DbSeek(xFilial()+SEU->EU_CAIXA))
	  	SZ3->(DbSetOrder(1))  
	    SZ3->(DbSeek(xFilial()+SEU->EU_CAIXA+DTOS(mv_par03-1)) )
	    @nLin, 05 PSAY STR0011+ SEU->EU_CAIXA + " - "+SET->ET_NOME //"Caja chica "   
	    SaldoAnt:=SZ3->Z3_SALDO
	 //  	@nLin, 77 PSAY "Saldo Anterior -> "
	 //	@nLin, 98 PSAY SZ3->Z3_SALDO PICTURE PesqPict("SZ3","Z3_SALDO",16) //"Saldo Anterior Raquel 26/01/06 "
		cCaixa	:=	EU_CAIXA   
		lPrinted	:=	.T.
	Endif
	lSaldo	:=	.F.

   	
	If SEU->EU_DTDIGIT >= mv_par03 .and. SEU->EU_DTDIGIT <= mv_par04
		nLin++ 
//	   	dbsetorder(9)      

		if cConta<>EU_CONTA    
		    if  cConta <> "" .and. cCaixaTemp==EU_CAIXA   
		    	@nLin, 77 PSAY "Total Conta --> "
		    	@nLin, 98 PSAY cSaldo	PICTURE PesqPict("SEU","EU_VALOR",16) //"Total Conta Contável" Raquel 
		    	cSaldo:=0
   		       	nLin++       		      	
		    endif	 
		    cConta:=EU_CONTA      
		    
		  	CT1->(DbSetOrder(1))
		    CT1->(DbSeek(xFilial()+SEU->EU_CONTA)) 
			@nLin, 07 PSAY "Conta --> "+RTRIM(SEU->EU_CONTA)+" - "+CT1->CT1_DESC01 //"Conta Contável" Raquel 
	    	nLin++         	
	    ENDIF	        
	    cCaixaTemp:=EU_CAIXA
		F560Print(@nLin,0,Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)     
		If mv_par05 == 1 .And.EU_TIPO =="01"
			@nLin,116	PSAY	EU_VALOR - EU_SLDADIA PICTURE PesqPict("SEU","EU_VALOR",16)
			If EU_VALOR <> EU_SLDADIA
				nLin++
				@nLin,002	PSAY	STR0012 //"Detalles del Anticipo"
				aArea	:=	GetArea()
				DbSetOrder(3)     //teste
				cAdia	:=	EU_NUM
				DbSeek(xFilial()+cAdia)
				While !EOF()	.And.	xFilial() == EU_FILIAL .And. EU_NROADIA == cAdia
					nLin++
					F560Print(@nLin,4,Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
					DbSkip()
				Enddo
				RestArea(aArea)
			Endif
		Endif
	EndIf
	dbSkip() // Avanca o ponteiro do registro no arquivo
	If cCaixa <> EU_CAIXA .And. !lSaldo
		nLin++               
	  //	if  cConta <> ""   
  		  @nLin, 77 PSAY "Total Conta --> "    
  		  @nLin, 98 PSAY cSaldo	PICTURE PesqPict("SEU","EU_VALOR",16) //"Total Conta Contável" Raquel 
 		  nLin++	 
 		  nLin++	    	
 	//	endif       
 	   	@nLin, 77 PSAY "Saldo Anterior --> "
		@nLin, 98 PSAY SaldoAnt PICTURE PesqPict("SZ3","Z3_SALDO",16) //"Saldo Anterior Raquel 26/01/06 "
	    nLin++     
	    @nLin, 077 PSAY IIf(mv_par06==1,STR0013,STR0014) //"Saldo Caja ----->"###"Total Gastos ----->"
		@nLin, 098 PSAY nSaldo	PICTURE PesqPict("SEU","EU_VALOR",16)    
		nLin++  
		@nLin, 77 PSAY "Saldo Final Caixinha --> "
		@nLin, 99 PSAY SaldoAnt+nSaldo	PICTURE PesqPict("SEU","EU_VALOR",16) 
	   	   	
		nSaldoTot	+=	nSaldo
		nSaldo	:=	0   
		cSaldo  :=0     
		lSaldo	:=	.T.
		lPrinted	:=	.F.
	Endif
EndDo
If nLin > 58 // Salto de Página. Neste caso o formulario tem 55 linhas...
	Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
	nLin := 8
Endif
If !lSaldo
	nLin++
	@nLin, 077 PSAY IIf(mv_par06==1,STR0013,STR0014) //"Saldo Caja ----->"###"Total Gastos ----->"
	@nLin, 098 PSAY nSaldo	PICTURE PesqPict("SEU","EU_VALOR",16)
	nSaldoTot	+=	nSaldo      
	cSaldo+=	nSaldo
Endif
If nLin > 58 // Salto de Página. Neste caso o formulario tem 55 linhas...
	Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
	nLin := 8
Endif
If mv_par06 == 2
	nLin++
	nLin++
	@nLin, 071 PSAY STR0015 //"Total General Gastos ----->"
	@nLin, 098 PSAY nSaldoTot	PICTURE PesqPict("SEU","EU_VALOR",16)
Endif
If nLin != 80
	Roda(cbcont,cbtxt,Tamanho)
endif
Return
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFun‡„o    ³F560Print º Autor ³ Bruno Sobieski     º Data ³  02/07/00   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescri‡„o ³ Imprime um item.                                           º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Programa principal                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function F560Print(nLin,nDesp,Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
Local cTipo	:=	""

Do Case
	Case EU_TIPO == "00"
		cTipo	:=	IIf(Empty(EU_HISTOR),STR0016,EU_HISTOR) //"Gasto"
	Case EU_TIPO == "01"
		cTipo	:=	IIf(Empty(EU_HISTOR),STR0017,STR0018+ Substr(EU_HISTOR,1,20)) //"Anticipo"###"Ant. "
	Case EU_TIPO == "02"
		cTipo	:=	STR0019 //"Dev. Anticipo"
	Case EU_TIPO == "10"
		cTipo	:=	STR0020 //"Reposicion"
	Case EU_TIPO == "11"
		cTipo	:=	IIf(Empty(EU_HISTOR),STR0021,EU_HISTOR) //"Transf. por cierre"
	Case EU_TIPO == "12"
		cTipo	:=	IIf(Empty(EU_HISTOR),STR0022,EU_HISTOR) //"Dev. por cierre Caja Menor"
	Case EU_TIPO == "13"
		cTipo	:=	IIf(Empty(EU_HISTOR),STR0023,EU_HISTOR) //"Repos. Caja Menor"
	Case EU_TIPO == "90"
		cTipo	:=	STR0024 //"Reposicao cancelada"
	Case EU_TIPO == "91"
		cTipo	:=	STR0025 //"Aguardando autorizacao para reposicao"
	Case EU_TIPO == "92"
		cTipo	:=	STR0026 //"Aguardando debito do titulo para reposicao"
Endcase
If nLin > 58 // Salto de Página. Neste caso o formulario tem 55 linhas...
	Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
	nLin := 9
Endif

@nLin,000+nDesp	PSAY	cTipo
If EU_TIPO<"90"
	@nLin,029			PSAY	Substr(EU_BENEF,1,19)
Endif
@nLin,049			PSAY	EU_NRCOMP 	PICTURE PesqPict("SEU","EU_NRCOMP")
@nLin,062			PSAY	EU_NUM		PICTURE PesqPict("SEU","EU_NUM")
@nLin,076			PSAY	EU_NROADIA	PICTURE PesqPict("SEU","EU_NROADIA")
@nLin,088			PSAY	DTOC(EU_DTDIGIT)        


If EU_TIPO<"90"
	nSigno	:=	IIf(mv_par06 == 2 .Or. !(EU_TIPO$"00|01|11|13"),1,-1)
	If nDesp == 0
		@nLin,098			PSAY	(EU_VALOR*nSigno)	PICTURE PesqPict("SEU","EU_VALOR",16)
	Else
		If EU_TIPO == "02" //Devolucao de adiantamento
			@nLin,098		PSAY	EU_VALOR	PICTURE PesqPict("SEU","EU_VALOR",16)
		Endif
		@nLin,116			PSAY	EU_VALOR	PICTURE PesqPict("SEU","EU_VALOR",16)
	Endif
	If nDesp == 0 .Or. EU_TIPO == "02"
		nSaldo		+=	(EU_VALOR*nSigno)
	Endif           
    cSaldo+=(EU_VALOR*nSigno)	//Soma o total por conta
ElseIf EU_TIPO>"90"
		@nLin,098			PSAY	EU_VALOR	PICTURE PesqPict("SEU","EU_VALOR",16)
Endif

Return
