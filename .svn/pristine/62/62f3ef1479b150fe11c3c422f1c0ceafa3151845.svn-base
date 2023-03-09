#Include "rwmake.ch"
#Include "plsmger.ch"
#Include "plsmlib.ch"
#Include "colors.ch"
#Include "topconn.ch"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัอออออออออออออหอออออออัอออออออออออออออออออหออออออัอออออออออออปฑฑ
ฑฑบPrograma  ณ RELRIOPR    บ Autor ณ Jean Schulz       บ Data ณ 29/10/06  บฑฑ
ฑฑฬออออออออออุอออออออออออออสอออออออฯอออออออออออออออออออสออออออฯอออออออออออนฑฑ
ฑฑบDescricao ณ Relatorio para Rio Previdencia.                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/

User Function cabr165()                           

Private oLeTxt
Private lAbortPrint :=.F.

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Declaracao de Variaveis                                             ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
PRIVATE cNomeProg   := "RELRIOPR"
PRIVATE cPerg       := "RLRIOP"
PRIVATE nQtdLin     := 55
PRIVATE nLimite     := 210
PRIVATE cControle   := 15
PRIVATE cAlias      := "PBS"
PRIVATE cTamanho    := "G"
PRIVATE cTitulo     := "Rel. Analํtico Rio Prev."
PRIVATE cDesc1      := ""
PRIVATE cDesc2      := ""
PRIVATE cDesc3      := ""
PRIVATE nRel        := "RELRIOPR"
PRIVATE nlin        := 100
PRIVATE nOrdSel     := 1
PRIVATE m_pag       := 1
PRIVATE lCompres    := .F.
PRIVATE lDicion     := .F.
PRIVATE lFiltro     := .T.
PRIVATE lCrystal    := .F.
PRIVATE aOrdens     := {} 
PRIVATE aReturn     := { "", 1,"", 1, 1, 1, "",1 }
PRIVATE lAbortPrint := .F.
PRIVATE cCabecP     := "Relat๓rio de anแlise da exporta็ใo Rio Previd๊ncia"
PRIVATE cCabec1     := ""
PRIVATE cCabec2     := ""
PRIVATE nColuna     := 00
PRIVATE nOrdSel     := 0


@ 200,1 TO 380,380 DIALOG oLeTxt TITLE OemToAnsi("Relat๓rio Rio Previd๊ncia")
@ 02,10 TO 65,180
@ 10,018 Say " Este relat๓rio ้ destinado a exibir as informa็๕es sobre a ex- "
@ 18,018 Say " porta็ใo / importa็รo Rio Previd๊ncia, e seu status.           "
@ 70,098 BMPBUTTON TYPE 05 ACTION AjustaSX1(cPerg)
@ 70,128 BMPBUTTON TYPE 01 ACTION OkRelat()
@ 70,158 BMPBUTTON TYPE 02 ACTION Close(oLeTxt)

Activate Dialog oLeTxt Centered                      

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuno    ณ OkRelat  บ Autor ณ                    บ Data ณ  09/04/03   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescrio ณ Funcao chamada pelo botao OK na tela inicial de processamenบฑฑ
ฑฑบ          ณ to. Executa a rotina de relatorio...                       บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Programa principal                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static Function OkRelat
Local nCont := 0     

Private cPreRem		:= ""
Private cCodRem		:= ""
Private cStatus		:= ""
Private cCodErrDe	:= ""
Private cCodErrAt	:= ""

Pergunte(cPerg,.F.) 

cPreRem		:= mv_par01
cCodRem		:= mv_par02
cStatusDe	:= mv_par03
cStatusAte	:= mv_par04
cCodErrDe	:= mv_par05
cCodErrAt	:= mv_par06   
dDatBloAt 	:= mv_par07

PBR->(DbSetOrder(1))

If !PBR->(MsSeek(xFilial("PBR")+cPreRem+cCodRem))
	MsgAlert("C๓digo remessa nใo encontrado. Opera็ใo abortada!","Aten็ใo!")
	Return Nil
Endif                    

cCabec1	:= cCabecP+" Remessa: "+cCodRem
cCabec2 := "MATRICULA                  NOME                                                                     TITULO             COD_DES       VALOR  ERRO STATUS "		
nRel   := SetPrint(cAlias,nRel,cPerg,cTitulo,cDesc1,cDesc2,cDesc3,lDicion,aOrdens,lCompres,cTamanho,{},lFiltro,lCrystal)

If nLastKey == 27
	Return
Endif              

//Manda imprimir...
SetDefault(aReturn,"PBS")

Processa({|| Processa1() }, cTitulo, "", .T.)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Libera impressao                                                         ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
If  aReturn[5] == 1
	Set Printer To
	Ourspool(nRel)
End
MS_FLUSH()

Return                 



/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuno    ณ PROCESSA1บ Autor ณ Jean Schulz        บ Data ณ  30/10/05   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescrio ณ Funcao auxiliar chamada pela PROCESSA.  A funcao PROCESSA  บฑฑ
ฑฑบ          ณ monta a janela com a regua de processamento.               บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Programa principal                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static Function Processa1()
Local cSQL		:= ""
Local nCont		:= 0
Local nTotReg	:= 0
Local nLin		:= 0
Local nTotTit	:= 0
Local lPrima	:= .T.
Local nVlrDes	:= 0

Local aTotErr	:= {}

For nCont := 1 to 2        

	If nCont == 1
		cSQL := " SELECT COUNT(PBS.R_E_C_N_O_) AS TOTAL "
	Else
		cSQL := " SELECT PBS.*, BA1_DIGITO, BA1_NOMUSR, ba1_datblo,  X5_DESCRI "
	Endif                                                          
	
	cSQL += " FROM "+RetSQLName("PBS")+" PBS, "+RetSQLName("BA1")+" BA1, "+RetSQLName("SX5")+" SX5, "+RetSQLName("SE1")+" SE1 "
	cSQL += " WHERE PBS_FILIAL = '"+xFilial("PBS")+"' "
	cSQL += " AND PBS_PREREM = '"+cPreRem+"' "
	cSQL += " AND PBS_CODREM = '"+cCodRem+"' "
	cSQL += " AND PBS_STATUS >= '"+cStatusDe+"' " //1-ENVIADO / 2-ERRO ENVIO DETECTADO / 3-BAIXA AUTORIZADA / 4-BAIXA NAO AUTORIZADA
	cSQL += " AND PBS_STATUS <= '"+cStatusAte+"' " //1-ENVIADO / 2-ERRO ENVIO DETECTADO / 3-BAIXA AUTORIZADA / 4-BAIXA NAO AUTORIZADA
	cSQL += " AND PBS_CODERR >= '"+cCodErrDe+"' "
	cSQL += " AND PBS_CODERR <= '"+cCodErrAt+"' "
	cSQL += " AND BA1_FILIAL = '"+xFilial("BA1")+"' "
	cSQL += " AND BA1_CODINT = PBS_CODINT "
	cSQL += " AND BA1_CODEMP = PBS_CODEMP "
	cSQL += " AND BA1_MATRIC = PBS_MATRIC "
	cSQL += " AND BA1_TIPREG = PBS_TIPREG "
	cSQL += " AND BA1_DIGITO = PBS_DIGITO "
	cSQL += " AND E1_FILIAL = '"+xFilial("SE1")+"' "
	cSQL += " AND E1_PREFIXO = PBS_PRETIT "
	cSQL += " AND E1_NUM = PBS_NUMTIT "
	cSQL += " AND E1_PARCELA = PBS_PARTIT "
	cSQL += " AND E1_TIPO = PBS_TIPTIT "
	cSQL += " AND X5_FILIAL = '"+xFilial("SX5")+"' "
	cSQL += " AND X5_TABELA = 'K0' "
	cSQL += " AND X5_CHAVE = PBS_CODERR "
	cSQL += " AND BA1.D_E_L_E_T_ = ' ' "
	cSQL += " AND PBS.D_E_L_E_T_ = ' ' "
	cSQL += " AND SX5.D_E_L_E_T_ = ' ' "
	cSQL += " AND SE1.D_E_L_E_T_ = ' ' "
	If nCont == 1
		PLSQuery(cSQL,"TRB")
		nTotReg := TRB->TOTAL
		TRB->(DBCloseArea())
	Else
		cSQL += " ORDER BY PBS_PRETIT, PBS_NUMTIT, PBS_PARTIT, PBS_TIPTIT, PBS_CODDES "
	Endif
	
Next
	
PLSQuery(cSQL,"TRB")

ProcRegua(nTotReg)

TRB->(DbGotop())

Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,cControle)
nLin := 9  

nCont := 0

While !TRB->(Eof())
    if TRB->PBS_CODERR = '9' 
       if  dtos(trb->ba1_datblo) > dtos(dDatBloAt)    
       	   TRB->(DbSkip()) 
           loop 
       else
       a:= ' '    
       EndIf
    EndIf       
	nCont++
	IncProc("Imprimindo linha "+StrZero(nCont,6)+" / "+StrZero(nTotReg,6))

	If nLin+2 > nQtdLin
		Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,cControle)  
		nLin := 9
	Endif 	
	
	nVlrDes := Iif(TRB->PBS_CODDES=="RES",-1,1)*TRB->PBS_VLRDES	

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Imprime linha detalhe do relatorio...                               ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู		
	          
   //12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890	

	@ nLin, 005 PSay	TRB->PBS_CODINT+"."+TRB->PBS_CODEMP+"."+TRB->PBS_MATRIC+"."+TRB->PBS_TIPREG+"-"+TRB->BA1_DIGITO+Space(1)+;
						TRB->BA1_NOMUSR+Space(3)+TRB->(PBS_PRETIT+PBS_NUMTIT+PBS_PARTIT+PBS_TIPTIT)+space(3)+TRB->PBS_CODDES+Space(3)+Transform(nVlrDes,"@E 9,999,999.99")+;
						Space(3)+TRB->PBS_CODERR+Space(3)+Substr(TRB->X5_DESCRI,1,30)   // TRB->PBS_STATUS+ " "+
	nLin++    
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Monta matriz totalizadora por codigo de erro.                       ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู					
	nPos := Ascan(aTotErr,{|x| x[1]==TRB->PBS_CODERR})
	If nPos > 0
		aTotErr[nPos,2] += nVlrDes
	Else
		aadd(aTotErr,{TRB->PBS_CODERR,nVlrDes})	
	Endif
	nTotTit += nVlrDes
	
	TRB->(DbSkip()) 
	
Enddo

TRB->(DbCloseArea())

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Imprime totais por codigo de erro...                                ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู			
nLin++
If Len(aTotErr) > 0

	@ nLin, 005 PSay "Totais por tipo de erro"
	nLin++
	@ nLin, 005 PSay "-----------------------"
	nLin++	

	For nCont := 1 to Len(aTotErr)
		@ nLin, 005 PSay aTotErr[nCont,1]+space(2)+Transform(aTotErr[nCont,2],"@E 9,999,999.99")
		nLin++
	Next
	@ nLin, 005 PSay Replicate("-",38)
	nLin+=2	

Endif

aTotErr := {}

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Imprime totalizador da composicao do ultimo titulo...               ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู			
If nTotTit > 0
	@ nLin, 005 PSay "Total Composicao Titulo: "+Transform(nTotTit,"@E 9,999,999.99")
	nLin++                                                                         
	
	@ nLin, 005 PSay Replicate("-",38)
	nLin+=2	
Endif

nTotTit := 0

Return Nil


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ AjustaSX1บAutor  ณ Jean Schulz        บ Data ณ  24/10/05   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Ajusta os parametros                                       บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function AjustaSX1(cPerg)

Local aHelpPor := {}

aHelpPor := {}
PutSx1(cPerg,"01",OemToAnsi("Prefixo remessa: ")				,"","","mv_ch1","C",03,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","",aHelpPor,{},{})

aAdd( aHelpPor, "Informe a remessa a ser impressa...    " )
PutSx1(cPerg,"02",OemToAnsi("Nro da remessa: ")					,"","","mv_ch2","C",05,0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","",aHelpPor,{},{})

aAdd( aHelpPor, "Status possํveis: " )
aAdd( aHelpPor, "1-Enviado / 2 Err. Envio Detectado")
aAdd( aHelpPor, "3-Bx. Autorizada / 4-Bx. nใo autoriz." )
PutSx1(cPerg,"03",OemToAnsi("Status De: ")		  					,"","","mv_ch3","C",01,0,0,"G","","","","","mv_par03","","","","","","","","","","","","","","","","",aHelpPor,{},{})
PutSx1(cPerg,"04",OemToAnsi("Status Ate: ")		  					,"","","mv_ch4","C",01,0,0,"G","","","","","mv_par04","","","","","","","","","","","","","","","","",aHelpPor,{},{})


aHelpPor := {}
PutSx1(cPerg,"05",OemToAnsi("C๓digos de erro de: ")				,"","","mv_ch5","C",01,0,0,"G","","","","","mv_par05","","","","","","","","","","","","","","","","",aHelpPor,{},{})
PutSx1(cPerg,"06",OemToAnsi("C๓digos de erro at้: ")			,"","","mv_ch6","C",01,0,0,"G","","","","","mv_par06","","","","","","","","","","","","","","","","",aHelpPor,{},{})
PutSx1(cPerg,"07",OemToAnsi("Bloqueio At้      ? " )            ,"","","mv_ch7","D",10,0,0,"G","","","","","mv_par07","","","","","","","","","","","","","","","","",aHelpPor,{},{})

Pergunte(cPerg,.T.)

Return
