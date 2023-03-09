#include "PROTHEUS.CH"
#include "PLSMGER.CH"
#define cCodigosPF "104,116,117,123,124,125,127,134,137,138,139,140,141,142,143,144,145,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,177"

Static cCodDB     := PLSRETLADC()        

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±±
±±³Funcao    ³ RELDIOPS³ Autor ³ Jean Schulz            ³ Data ³ 28.04.04 ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±±
±±³Descricao ³ Relatorio para DIOPS Caberj							      ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±±
±±³Sintaxe   ³ RELDIOPS                                                   ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±±
±±³ Uso      ³ Advanced Protheus                                          ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±±
±±³ Alteracoes desde sua construcao inicial                               ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±±
±±³ Data     ³ BOPS ³ Programador ³ Breve Descricao                       ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define nome da funcao                                                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
USER Function RELDIOPS()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define variaveis locais para o relatorio...			                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define variaveis padroes para todos os relatorios...                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE nQtdLin     := 60
PRIVATE nLimite     := 220
PRIVATE cTamanho    := "G"
PRIVATE cTitulo     := "Relatorio referente a DIOPS"
PRIVATE cDesc1      := "Este Relatorio tem como objetivo emitir relatório da DIOPS"
PRIVATE cDesc2      := "conforme parâmetros fornecidos pelo usuário."
PRIVATE cDesc3      := ""
PRIVATE cAlias      := "SE1"
PRIVATE cPerg       := "PLRDIO"
PRIVATE cRel        := "PLSRDIOPS"
PRIVATE nli         := 80
PRIVATE m_pag       := 1    
PRIVATE lCompres    := .F. 
PRIVATE lDicion     := .F. 
PRIVATE lFiltro     := .F. 
PRIVATE lCrystal    := .F. 
PRIVATE aOrderns    := {}
PRIVATE aReturn     := { "", 1,"", 1, 1, 1, "",1 } 
PRIVATE lAbortPrint := .F.
PRIVATE cCabec1     := "Informacoes / classificacoes                               Contraprestacao      Tx.Admin     Co-part."
PRIVATE cCabec2		:= ""


private dDatDe	:= CtoD("")
private dDatAte	:= CtoD("")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Testa ambiente do relatorio somente top...                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If ! PLSRelTop()
   Return
Endif    

AjustaSX1(cPerg)
BE4->(DbSetOrder(1))

Pergunte(cPerg,.T.)


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Chama SetPrint (padrao)                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cRel := SetPrint(cAlias,cRel,cPerg,@cTitulo,cDesc1,cDesc2,cDesc3,lDicion,aOrderns,lCompres,cTamanho,{},lFiltro,lCrystal)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se foi cancelada a operacao (padrao)                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If nLastKey  == 27 
   Return
Endif

Pergunte(cPerg,.F.)

_cMes	:= mv_par01
_cAno	:= mv_par02   

cTitulo += " - Trimestre: "+_cMes+" / "+_cAno

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Configura impressora (padrao)                                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
SetDefault(aReturn,cAlias) 

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Emite relat¢rio                                                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
MsAguarde({|| RImpDIOPS() }, cTitulo, "", .T.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Libera threads                                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Ms_Flush()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fim da rotina                                                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Return
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa   ³ RImpDIOPS³ Autor ³Jean Schulz            ³ Data ³ 28.04.04 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao  ³ Imprime detalhe do relatorio...                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/
Static Function RImpDIOPS()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define variaveis...                                                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE cBM1Name 	:= BM1->(RetSQLName("BM1"))
PRIVATE cSE1Name 	:= SE1->(RetSQLName("SE1"))
PRIVATE cBA1Name 	:= BA1->(RetSQLName("BA1"))
PRIVATE cBA3Name 	:= BA3->(RetSQLName("BA3"))

Private _cChave := ""     

Processa( {|| Proc01() }, "Imprimindo...")

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³Proc01    ºAutor  ³Microsiga           º Data ³  02/20/08   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function Proc01()

Local nLi 		:= 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
Local nContAv 	:= 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
Local nCont 	:= 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

LOCAL cSQL1		:= ""
Local cAux		:= ""
Local cAnoD		:= ""
Local cMesD		:= ""
Local aPlaUsr	:= {}
Local aResumo	:= {}
Local aVetByPass:= {}
Local aLegGrupo	:= {{'1','A Vencer'},{'2','Até 30'},{'3','31 a 60'},{'4','61 a 90'},{'5','91 a 120'},{'6','121 a 365'},{'7','Maior que 365'}}
Local cDesGru := ""
Local cLegStr := ""
Local nMultipl := 1


//Legenda:
//1-Classificacao
//2-Familiar
//3-COL_PRE
//4-TOTAL
//5-PARTICIPA
//6-TX ADM.
//7-Valor Baixado...
Local aArray := {{'A Vencer     ',0,0,0,0,0,0},{'Até 30       ',0,0,0,0,0,0},{'31 a 60      ',0,0,0,0,0,0},{'61 a 90      ',0,0,0,0,0,0},{'91 a 120     ',0,0,0,0,0,0},{'121 a 365    ',0,0,0,0,0,0},{'Maior que 365',0,0,0,0,0,0}}

SE5->(DbSetOrder(7)) //E5_FILIAL+E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO+E5_CLIFOR+E5_LOJA+E5_SEQ                                                                                      
BM1->(DbSetOrder(4)) //BM1_FILIAL + BM1_PREFIX + BM1_NUMTIT + BM1_PARCEL + BM1_TIPTIT + BM1_CODINT + BM1_CODEMP + BM1_MATRIC + BM1_TIPREG + BM1_CODTIP

cNameSE5 := RetSQLName("SE5")
cNameSE1 := RetSQLName("SE1")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicio da impressao dos detalhes...                                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nReg := 0
lAnalit := .F.

nLi := Cabec(cTitulo,cCabec1,cCabec2,cRel,cTamanho,IIF(aReturn[4]==1,GetMv("MV_COMP"),GetMv("MV_NORM")))
nLi ++
SE1->(DbSetOrder(1))

cAnoD := _cAno
cMesD := _cMes
lAVenc := .F.

dDatAte	:= LastDay(StoD(cAnoD+cMesD+"01"))

For nContAv := 1 to 2
 
	lAVenc := !lAVenc
	nTotReg := BuscaRegs(cAnoD,cMesD,lAVenc)
	nReg := 0   	
	cChaveSE1 := ""
	
	ProcRegua(nTotReg)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Laco relativo aos BM1 do sistema.										 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	While ! TRB1->(Eof())
	
		nReg++
		IncProc("Registro: "+StrZero(nReg,9)+" De: "+StrZero(nTotReg,9)+" Proc: "+StrZero(nContAv,1)+" de 2")
		
		If cChaveSE1 <> TRB1->(BM1_PREFIX+BM1_NUMTIT+BM1_PARCEL+BM1_TIPTIT)
		
			cChaveSE1 := TRB1->(BM1_PREFIX+BM1_NUMTIT+BM1_PARCEL+BM1_TIPTIT)
			aPlaUsr := {}

			/*			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Verificar se o titulo ja esta baixado, e dt.bx fora do periodo solicitado³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If TRB1->E1_SALDO = 0 .And. TRB1->E1_BAIXA < dDatAte
				ByPassTRB(cChaveSE1)
				Loop
			Endif
			*/
				
			nVlrTotBx := 0
			nVlrBxPer := 0 
		
			nQtdDias := dDatAte-TRB1->E1_VENCORI
			
			//Comentado para fins de desempenho. 
			//Obter do SE1
			/*
			cSQLSE5 := " SELECT E1_VALOR, E5_PREFIXO, E5_NUMERO, E5_PARCELA, E5_TIPO, Sum(Decode(E5_RECPAG,'R',1,-1)*E5_VALOR) AS VLRTOTBX"
			cSQLSE5 += " FROM "+cNameSE5+" RIGHT OUTER JOIN "+cNameSE1
			cSQLSE5 += " ON E5_FILIAL = '"+xFilial("SE5")+"' "
			cSQLSE5 += " AND E1_PREFIXO = E5_PREFIXO "
			cSQLSE5 += " AND E1_NUM = E5_NUMERO "			 
			cSQLSE5 += " AND E1_PARCELA = E5_PARCELA "
			cSQLSE5 += " AND E1_TIPO = E5_TIPO "
			cSQLSE5 += " AND E5_MOTBX <> 'CAN' "
			cSQLSE5 += " AND E5_DATA <= '"+DtoS(dDatAte)+"' "
			cSQLSE5 += " AND SE5010.D_E_L_E_T_ = ' ' "			
			cSQLSE5 += " WHERE E1_FILIAL = '"+xFilial("SE1")+"' "
			cSQLSE5 += " AND E1_PREFIXO = '"+TRB1->BM1_PREFIXO+"' "
			cSQLSE5 += " AND E1_NUM = '"+TRB1->BM1_NUMTIT+"' "
			cSQLSE5 += " AND E1_PARCELA = '"+TRB1->BM1_PARCEL+"' "
			cSQLSE5 += " AND E1_TIPO = '"+TRB1->BM1_TIPTIT+"' "
			cSQLSE5 += " AND ((E1_SALDO = 0 AND E1_BAIXA >= '"+DtoS(dDatDe)+"') OR E1_SALDO > 0 ) "
			cSQLSE5 += " AND SE1010.D_E_L_E_T_ = ' ' "
			cSQLSE5 += " GROUP BY E1_VALOR, E5_PREFIXO, E5_NUMERO, E5_PARCELA, E5_TIPO "
			
			PLSQuery(cSQLSE5,"TRBSE5")
			
			nVlrTotBX := TRBSE5->VLRTOTBX
			*/
			
		
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Validar quando o titulo esta baixado, porem fora do periodo...           ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			/*
			If !Empty(SE1->E1_BAIXA)
				If SE5->(MsSeek(xFilial("SE5")+SE1->(E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO)))		
					While !SE5->(Eof()) .And. SE5->(E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO)==SE1->(E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO)
						If SE5->E5_DATA <= dDatAte
						
							nVlrTotBx += Iif(SE5->E5_RECPAG=="R",1,-1)*SE5->E5_VALOR   
							
							
							//If SE5->E5_DATA >= dDatDe         			
							//	nVlrBxPer += SE5->E5_VALOR
							//Endif
							
						
						Endif		
						SE5->(DbSkip())
					Enddo
				Endif
		
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Caso completamente baixado na data final, nao listar...                  ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	
				If nVlrTotBx >= SE1->E1_VALOR
					ByPassTRB(cChaveSE1)
					Loop
				Endif
				
			Endif
			*/

			//Apurar valor somente quando a baixa for menor que a competencia final..
			If !Empty(TRB1->E1_BAIXA) .And. TRB1->E1_BAIXA <= LastDay(dDatAte-35)
				nVlrTotBX := TRB1->(E1_VALOR-E1_SALDO)
			Endif
						
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Caso completamente baixado na data final, nao listar...                  ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	
			//Comentado para fins de desempenho. 
			//Obter do SE1.
			/*
			If nVlrTotBx >= TRB1->E1_VALOR
				aadd(aVetByPass,{TRBSE5->(E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO),TRBSE5->E1_VALOR})
				ByPassTRB(cChaveSE1)
				TRBSE5->(DbCloseArea())
				Loop
			Endif
			
			nVlrAberto	:= TRBSE5->E1_VALOR-nVlrTotBx
			*/
					                                                                   
			nVlrAberto	:= TRB1->E1_VALOR-nVlrTotBX
			nPerAberto	:= 100-((nVlrTotBx*100)/TRB1->E1_VALOR)
			
			nVlrMenFam	:= 0
			nVlrMenCol	:= 0
			nVlrCopart	:= 0
			nVlrTxAdm	:= 0
			
			//TRBSE5->(DbCloseArea())
					
		Endif
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Define qual o plano do usuario...                                  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		_cCodPla := ''
		_cVerPla := ''
		
		// Regra numero um: Utiliza o plano do BM1.
		If !Empty(TRB1->BM1_CODPLA) .and. !Empty(TRB1->BM1_VERPLA)
			_cCodPla := TRB1->BM1_CODPLA
			_cVerPla := TRB1->BM1_VERPLA
			
		Else
			// Regra numero dois: Utiliza o plano informado na mensalidade para os demais eventos.
			If TRB1->BM1_CODTIP $ '101'		// Mensalidade
				_cCodPla := Alltrim(TRB1->BM1_CODEVE)
				_cVerPla := '001'
				
				// Guarda o plano do usuario
				Aadd(aPlaUsr, {TRB1->(BM1_CODINT+BM1_CODEMP+BM1_MATRIC+BM1_TIPREG), '101', Alltrim(TRB1->BM1_CODEVE)})
				
			Else
				// Considera o plano informado no BM1_CODEVE da mensalidade 101...
				If (nPosPla := Ascan(aPlaUsr, {|x| x[1] == TRB1->(BM1_CODINT+BM1_CODEMP+BM1_MATRIC+BM1_TIPREG) .and.;
					x[2] == '101'})) > 0
					_cCodPla := aPlaUsr[nPosPla][3]
					_cVerPla := '001'
				Endif
			Endif
		Endif
		
		// Regra numero tres: Utiliza o plano do usuario ou da familia.
		If Empty(_cCodPla)
			If !Empty(TRB1->BA1_CODPLA)
				_cCodPla := TRB1->BA1_CODPLA
				_cVerPla := TRB1->BA1_VERSAO
			Else
				_cCodPla := BA3->BA3_CODPLA
				_cVerPla := BA3->BA3_VERSAO
			Endif
		Endif
		
		nVlrTmpTAd := 0
		nVlrTmpMen := 0
		nVlrTmpCop := 0   
		
		nMultipl := Iif(TRB1->BM1_TIPO=="1",1,-1)
		
		If TRB1->BM1_CODTIP $ "101,118" //Mensalidade, separar conforme plano..
			nVlrTmpMen := nMultipl*(TRB1->BM1_VALOR*nPerAberto)/100
			
		ElseIf TRB1->BM1_CODTIP == "117" //Taxa Administrativa...
			nVlrTmpTAd := nMultipl*(TRB1->BM1_VALOR*nPerAberto)/100
			
		ElseIf TRB1->BM1_CODTIP $ cCodigosPF .And. TRB1->BM1_CODTIP <> "117"
			nVlrTmpCop := nMultipl*(TRB1->BM1_VALOR*nPerAberto)/100
			
		Endif		
		
		Do Case
			Case nQtdDias < 0 //A vencer
				cGrupo := '1'
				
			Case nQtdDias <= 30
				cGrupo := '2'    
				
			Case nQtdDias <= 60
				cGrupo := '3'    

			Case nQtdDias <= 90
				cGrupo := '4'    

			Case nQtdDias <= 120
				cGrupo := '5'

			Case nQtdDias <= 365
				cGrupo := '6'

			Otherwise
				cGrupo := '7'
				
		EndCase
		
		_nPos := ascan(aResumo,{|x| x[1]==_cCodPla .And. x[2]==cGrupo})
				
		If _nPos == 0
			aadd(aResumo,{_cCodPla,cGrupo,nVlrTmpMen,nVlrTmpTAd,nVlrTmpCop})
		Else
			aResumo[_nPos,3] += nVlrTmpMen
			aResumo[_nPos,4] += nVlrTmpTAd
			aResumo[_nPos,5] += nVlrTmpCop
		Endif	
			                
	 	TRB1->(DbSkip())
	 	
	Enddo
	
	TRB1->(DbCloseArea())
	
Next
	
nTotFam := 0
nTotCol := 0
nTotTot := 0
nTotPar := 0
nTotTax := 0
nTotBai := 0

nTotTmpMen := 0
nTotTmpTAd := 0
nTotTmpCop := 0

BI3->(DbSetOrder(1))
Asort( aResumo,,, { |x,y| x[1]+x[2] < y[1]+y[2] } )

For nCont := 1 to Len(aResumo)

	cLegStr := aLegGrupo[ascan(aLegGrupo,{|x| x[1]==aResumo[nCont,2]}),2]
	
	@ nLi, 000 PSAY 'Plano:  '+space(1)+;
					aResumo[nCont,1]+" - "+Substr(Posicione("BI3",1,xFilial("BI3")+PLSINTPAD()+aResumo[nCont,1],"BI3_DESCRI"),1,30)+space(1)+;
					cLegStr+Space(13-Len(cLegStr))+space(1)+;
					Transform(aResumo[nCont,3],"@E 99,999,999.99")+space(1)+;
					Transform(aResumo[nCont,4],"@E 99,999,999.99")+space(1)+;
					Transform(aResumo[nCont,5],"@E 99,999,999.99")+space(1)

	nTotTmpMen += aResumo[nCont,3] 
	nTotTmpTAd += aResumo[nCont,4] 
	nTotTmpCop += aResumo[nCont,5] 
	nLi ++						

	If nLi > 60
		nLi := Cabec(cTitulo,cCabec1,cCabec2,cRel,cTamanho,IIF(aReturn[4]==1,GetMv("MV_COMP"),GetMv("MV_NORM")))
		nLi ++
	Endif
		
Next

@ nLi, 000 PSAY Replicate("-",102)
nLi++

@ nLi, 000 PSAY space(61)+Transform(nTotTmpMen,"@E 99,999,999.99")+space(1)+;
				Transform(nTotTmpTAd,"@E 99,999,999.99")+space(1)+;
				Transform(nTotTmpCop,"@E 99,999,999.99")+space(1)
nLi++

nLi := Cabec(cTitulo,cCabec1,cCabec2,cRel,cTamanho,IIF(aReturn[4]==1,GetMv("MV_COMP"),GetMv("MV_NORM")))
nLi ++		
nTotByPass := 0

For nCont := 1 to len(aVetByPass)
	@ nLi, 000 PSAY aVetByPass[nCont,1]+"Valor Titulo: "+Transform(aVetByPass[nCont,2],"@E 9,999,999.99")
	nLi++
	If nLi > 60
		nLi := Cabec(cTitulo,cCabec1,cCabec2,cRel,cTamanho,IIF(aReturn[4]==1,GetMv("MV_COMP"),GetMv("MV_NORM")))
		nLi ++		
	Endif
	nTotByPass += aVetByPass[nCont,2]
Next

@ nLi, 000 PSAY "Valor ByPassado: "+Transform(nTotByPass,"@E 999,999,999.99")
nLi++

nTotFam := 0
nTotCol := 0
nTotTot := 0
nTotPar := 0
nTotTax := 0
nTotBai := 0

aArray := {}

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Libera impressao                                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If  aReturn[5] == 1 
    Set Printer To
    Ourspool(cRel)
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fim do Relat¢rio                                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DbSelectArea("SE5")

Return



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³BuscaRegs ºAutor  ³Microsiga           º Data ³  03/03/08   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Busca registros em BM1 conforme parametro repassado.        º±±
±±º          ³Retorno: quantidade de registros selecionados...            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function BuscaRegs(cAnoFun,cMesFun,lAVenc)

Local aArray	:= {}
Local cCodBM1	:= "101,"+cCodigosPF
Local nCont		:= 1


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta query...                                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
For nCont := 1 to 2

	If nCont == 1
		cSQL := " SELECT COUNT(BM1.R_E_C_N_O_) AS TOTREG  "
	Else
		cSQL := " SELECT BM1_PREFIX, BM1_NUMTIT, BM1_PARCEL, BM1_TIPTIT, BM1_CODEMP, BM1_CODTIP, BM1_VALOR, BM1_CODPLA, BM1_VERPLA, E1_SALDO, E1_VALOR, E1_STATUS, "
		cSQL += " BM1_CODINT, BM1_CODEMP, BM1_MATRIC, BM1_TIPREG, BM1_CODEVE, BA3_CODPLA, BA3_VERSAO, BA1_CODPLA, BA1_VERSAO, E1_VENCORI, E1_BAIXA, BM1_TIPO "
	Endif	
	cSQL += " FROM "+cBM1Name+" BM1, "+cBA1Name+" BA1, "+cBA3Name+" BA3, "+cSE1Name+" SE1 "
	cSQL += " WHERE BM1.BM1_FILIAL = '"+xFilial("BM1")+"' "
	cSQL += " AND BM1.BM1_CODINT = '"+PLSINTPAD()+"' "
	
	cSQL += " AND SE1.E1_FILIAL = '"+xFilial("SE1")+"' "
	cSQL += " AND SE1.E1_PREFIXO = BM1.BM1_PREFIX "
	cSQL += " AND SE1.E1_NUM = BM1.BM1_NUMTIT "
	cSQL += " AND SE1.E1_PARCELA = BM1.BM1_PARCEL "
	cSQL += " AND SE1.E1_TIPO = BM1.BM1_TIPTIT "
	
	If lAVenc
		cSQL += " AND BM1.BM1_ANO||BM1.BM1_MES <= '"+PLSDIMAM(cAnoFun,cMesFun,"1")+"' " //conforme Motta, aumentar um mes para os A VENCER
		cSQL += " AND SE1.E1_VENCORI > '"+DtoS(dDatAte)+"' "
		cSQL += " AND SE1.E1_EMISSAO <= '"+DtoS(dDatAte)+"' "
	Else
		cSQL += " AND SE1.E1_VENCORI <= '"+DtoS(dDatAte)+"' "
	Endif		

	cSQL += " AND (SE1.E1_STATUS = 'A' OR (SE1.E1_STATUS = 'B' AND SE1.E1_BAIXA > '"+DtoS(dDatAte)+"')) "	
	cSQL += " AND BM1.BM1_CODTIP IN "+FormatIn(cCodBM1,",")
	
	cSQL += " AND BA1.BA1_FILIAL = '"+xFilial("BA1")+"' "
	cSQL += " AND BA1.BA1_CODINT = BM1.BM1_CODINT
	cSQL += " AND BA1.BA1_CODEMP = BM1.BM1_CODEMP
	cSQL += " AND BA1.BA1_MATRIC = BM1.BM1_MATRIC
	cSQL += " AND BA1.BA1_TIPREG = BM1.BM1_TIPREG
	
	cSQL += " AND BA3.BA3_CODINT = BM1.BM1_CODINT
	cSQL += " AND BA3.BA3_CODEMP = BM1.BM1_CODEMP
	cSQL += " AND BA3.BA3_MATRIC = BM1.BM1_MATRIC
		
	cSQL += " AND BM1.D_E_L_E_T_ = ' ' "
	cSQL += " AND BA1.D_E_L_E_T_ = ' ' "
	cSQL += " AND BA3.D_E_L_E_T_ = ' ' "	
	cSQL += " AND SE1.D_E_L_E_T_ = ' ' "		
	
//	cSQL += " AND BM1_PREFIX = 'PLS' "
//	cSQL += " AND BM1_NUMTIT <= '006000' "	

//	cSQL += " AND BM1_CODEMP = '0006' "	
	
	If nCont == 1
		PLSQuery(cSQL,"TRB1")
		nTotReg := TRB1->(TOTREG)
		TRB1->(DbCloseArea())
	Endif
	
Next
	
PLSQuery(cSQL,"TRB1")

//MsgAlert("ATENCAO! ROTINA NAO ESTA SENDO EXECUTADA POR COMPLETO! AVISE SETOR DE TI DA EMPRESA!")

Return nTotReg


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ByPassTRB ºAutor  ³Microsiga           º Data ³  03/03/08   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Passa pelos registros conforme solicitado pelo programa.    º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ByPassTRB(cChaveBy)                                 

	While !TRB1->(Eof()) .And. TRB1->(BM1_PREFIX+BM1_NUMTIT+BM1_PARCEL+BM1_TIPTIT) == cChaveBy
		TRB1->(DbSkip())	
	Enddo

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ AjustaSX1ºAutor  ³ Jean Schulz        º Data ³  24/10/05   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Ajusta os parametros                                       º±±
±±º          ³                                                            º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function AjustaSX1(cPerg)

PutSx1(cPerg,"01",OemToAnsi("Mes Base:") 		 ,"","","mv_ch1","C",02,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"02",OemToAnsi("Ano Base:") 		 ,"","","mv_ch2","C",04,0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","",{},{},{})

Return