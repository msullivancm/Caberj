#INCLUDE "rwmake.ch"
#INCLUDE "topconn.ch"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ CABR084  บ Autor ณ Altamiro Affonso   บ Data ณ  20/08/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Relatorio de Conferencia de Notas Digitadas para RDA       บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP6 IDE                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
User Function CABR084

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Declaracao de Variaveis                                             ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

Local cDesc1         := "Este programa tem como objetivo imprimir relatorio "
Local cDesc2         := "de acordo com os parametros informados pelo usuario."
Local cDesc3         := "CONFERENCIA DE DIGITACAO DE NOTA FISCAL DE RDA"
Local cPict          := ""
Local titulo         := "CONFERENCIA DE DIGITACAO DE NOTA FISCAL DE RDA "
Local nLin           := 80 																									     // 04/10/2007 - Noronha
Local Cabec1         := " NOTA  EMISSAO    HORA        VALOR TOTAL  PRESTADOR                                       COMPET. OBSERVACAO                                            USUARIO           Pref. Numero     Tipo "
//                       123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//                       0        1         2         3         4         5         6         7         8         9         10        11        12        13        14        15        16        17        18        19        20        21

Local Cabec2         := ""
Local imprime        := .T.
Local aOrd           := {}
Private lEnd         := .F.
Private lAbortPrint  := .F.
Private CbTxt        := ""
Private limite       := 221
Private tamanho      := "G"
Private nomeprog     := "CABR084"
Private nTipo        := 15
Private aReturn      := { "Zebrado", 1, "Administracao", 1, 2, 1, "", 1}
Private nLastKey     := 0
Private cbtxt        := Space(10)
Private cbcont       := 00
Private CONTFL       := 01
Private m_pag        := 01
Private wnrel        := "CABR084"
Private cString      := "SZB"
Private cPerg        := "CABS64"
dbSelectArea("SZB")
dbSetOrder(1)

ValidPerg(cPerg)
If Pergunte(cPerg,.T.) = .F.
	Return
Endif

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Monta a interface padrao com o usuario...                           ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

wnrel := SetPrint(cString,NomeProg,"",@titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,.F.,Tamanho,,.T.)

If nLastKey == 27
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
	Return
Endif

nTipo := If(aReturn[4]==1,15,18)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Processamento. RPTSTATUS monta janela com a regua de processamento. ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

RptStatus({|| RunReport(Cabec1,Cabec2,Titulo,nLin) },Titulo)
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuno    ณRUNREPORT บ Autor ณ AP6 IDE            บ Data ณ  31/08/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescrio ณ Funcao auxiliar chamada pela RPTSTATUS. A funcao RPTSTATUS บฑฑ
ฑฑบ          ณ monta a janela com a regua de processamento.               บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Programa principal                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/

Static Function RunReport(Cabec1,Cabec2,Titulo,nLin)

Local nOrdem
Local cQuery := ' '
dbSelectArea(cString)
dbSetOrder(1)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ SETREGUA -> Indica quantos registros serao processados para a regua ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

SetRegua(RecCount())

cQuery := " SELECT * FROM " + RetSqlName("SZB") 
cQuery += " WHERE D_E_L_E_T_ <> '*' "    
If !Empty(mv_par01) 
    cQuery += " AND   ZB_CODRDA  BETWEEN '" + Mv_Par01 + "' AND '" + Mv_Par02 + "'"
EndiF 
If !Empty(mv_par03) 
    cQuery += " AND   ZB_EMISSAO BETWEEN '" + dTos(Mv_Par03) + "' AND '" + dTos(Mv_Par04) + "'"
EndiF
If !Empty(mv_par07) 
cQuery += " AND   ZB_DTDIGIT BETWEEN '" + dTos(Mv_Par07) + "' AND '" + dTos(Mv_Par08) + "'"   
EndiF
If !Empty(SUBSTR( MV_PAR05,4,4)) 
   cQuery += " AND   ZB_ANOMES  = '" + SUBSTR( MV_PAR05,4,4)+SUBSTR(MV_PAR05,1,2) + "'"
Endif
If !Empty(mv_par06)
    cQuery += " AND '" + Upper(MV_PAR06) + "'  =  Upper(ZB_USUAR)"
Endif

cQuery += " ORDER BY ZB_DTDIGIT,ZB_USUAR "

If Select("TMP") > 0
	dbSelectArea("TMP")
	dbclosearea()
Endif

TCQuery cQuery Alias "TMP" New
dbSelectArea("TMP")
tmp->(dbGoTop())


//   total geral do relatorio
 nTotUG     := 0
 nTotVG     := 0
 nTotDtQt   := 0
 nTotDtVal  := 0
 ntotUsuqt  := 0
 ntotUsuVal := 0
	
While !EOF()
	
	xUsuario := TMP->ZB_USUAR
	dtDigita := TMP->ZB_DTDIGIT  
	
		If nLin > 55 // Salto de Pแgina. Neste caso o formulario tem 55 linhas...
			Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
			nLin := 8
		Endif
		
	@ nLin,000 PSAY " Data de Digitacao ...: "
	@ nLin,030 PSay  STOD(TMP->ZB_DTDIGIT)
	nLin += 1      
   @ nLin,000 PSay replicate("_",220)    	
	nLin += 2
	
	While !eof() .And. DtDigita == TMP->ZB_DTDIGIT
		
		If nLin > 55 // Salto de Pแgina. Neste caso o formulario tem 55 linhas...
			Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
			nLin := 8
		Endif
				
		@ nLin,000 PSAY " Usuario ...: "
		@ nLin,030 PSAY Upper(TMP->ZB_USUAR)
	
	   nLin += 2      
      //@ nLin,000 PSay replicate("_",220)    		
		//nLin += 1
		
		ntotUsuqt  := 0
		ntotUsuVal := 0
	
		While !eof() .And. xUsuario == TMP->ZB_USUAR .And. DtDigita == TMP->ZB_DTDIGIT
			
			
			//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
			//ณ Verifica o cancelamento pelo usuario...                             ณ
			//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
			
			If lAbortPrint
				@nLin,00 PSAY "*** CANCELADO PELO OPERADOR ***"
				Exit
			Endif
			
			//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
			//ณ Impressao do cabecalho do relatorio. . .                            ณ
			//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
			
			If nLin > 55 // Salto de Pแgina. Neste caso o formulario tem 55 linhas...
				Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
				nLin := 8
			   
			   @ nLin,000 PSAY " Usuario ...: "
		      @ nLin,030 PSAY Upper(TMP->ZB_USUAR)
		   	nLin += 2
			Endif
							
			@ nLin,000 PSAY TMP->ZB_NOTA
			@ nLin,007 PSAY Stod(TMP->ZB_EMISSAO)
			@ nLin,018 PSAY If(SUBSTR(TMP->ZB_OBS,3,1)+SUBSTR(TMP->ZB_OBS,6,1)="::",SUBSTR(TMP->ZB_OBS,1,8),space(8))
			@ nLin,027 PSAY TMP->ZB_VTOTAL Picture "@E 999,999,999.99"
			@ nLin,043 PSAY TMP->ZB_CODRDA+"-"+LEFT(Posicione("SA2",1,xFilial("SA2")+TMP->ZB_FORNECE+TMP->ZB_LOJA,"SA2->A2_NOME"),35)
            			            			
			@ nLin,090 PSAY SUBSTR(TMP->ZB_ANOMES,5,2)+"/"+LEFT(TMP->ZB_ANOMES,4)  // 04/10/2007 - Noronha
		//	@ nLin,098 PSAY If(SUBSTR(TMP->ZB_OBS,3,1)+SUBSTR(TMP->ZB_OBS,6,1)="::",ALLTRIM(SUBSTR(TMP->ZB_OBS,10,150)),ALLTRIM(TMP->ZB_OBS)) 
			@ nLin,098 PSAY If(SUBSTR(TMP->ZB_OBS,3,1)+SUBSTR(TMP->ZB_OBS,6,1)="::",ALLTRIM(SUBSTR(TMP->ZB_OBS,10,150)),ALLTRIM(TMP->ZB_OBS))
			@ nLin,152 PSAY TMP->ZB_USUAR
            @ nLin,171 PSAY TMP->ZB_prefixo			 
            @ nLin,176 PSAY TMP->ZB_titulo
            @ nLin,188 PSAY TMP->ZB_tipo			
			nLin := nLin + 1 // Avanca a linha de impressao
			
			ntotUsuqt  ++
			ntotUsuVal += TMP->ZB_VTOTAL 
		   nTotDtQt   ++
	   	nTotDtVal  += TMP->ZB_VTOTAL 
	   	nTotUG     ++ 
      	nTotVG     += TMP->ZB_VTOTAL 
			dbSkip()   // Avanca o ponteiro do registro no arquivo
		EndDo
		
		nLin++
		
		@ nLin,000 PSAY " Total do Usuario ...: "
		@ nLin,030 PSAY ntotUsuqt
		@ nLin,090 PSAY ntotUsuVal  Picture "@E 999,999,999.99"
			nLin += 1      
      @ nLin,000 PSay replicate("_",220)        
			nLin := nLin + 1	                  
	    	ntotUsuqt :=0
		   ntotUsuVal :=0  
		
		nLin := nLin +2 // Avanca a linha de impressao
		xUsuario := TMP->ZB_USUAR

	EndDo
	@ nLin,000 PSAY " Total do Data ......: "
	@ nLin,030 PSAY ntotDtqt
	@ nLin,090 PSAY ntotDtVal Picture "@E 999,999,999.99"
		nLin += 1      
   @ nLin,000 PSay replicate("_",220)    
       nTotDtQt   := 0
       nTotDtVal  := 0

		nLin := nLin + 2 // Avanca a linha de impressao
		dtDigita := TMP->ZB_DTDIGIT
EndDo

@ nLin,000 PSAY " Total do Geral  ......: "
@ nLin,030 PSAY nTotUG
@ nLin,090 PSAY nTotVg Picture "@E 999,999,999.99"

	nLin := nLin + 1 // Avanca a linha de impressao
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Finaliza a execucao do relatorio...                                 ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

SET DEVICE TO SCREEN

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Se impressao em disco, chama o gerenciador de impressao...          ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

If aReturn[5]==1
	dbCommitAll()
	SET PRINTER TO
	OurSpool(wnrel)
Endif

MS_FLUSH()

Return


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณValidPerg บ Autor ณ Jose Carlos Noronhaบ Data ณ 01/08/07    บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Parametros para selecao dos titulos do PLS                 บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ                                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static Function ValidPerg()

Local aAreaAtu := GetArea()
Local aRegs    := {}
Local i,j

DbSelectArea("SX1")
dbSetOrder(1)
cPerg := PADR(cPerg+"    ",6)

aAdd(aRegs,{cPerg,"01","De  RDA          ?","","","mv_ch1","C",06,0,0,"G","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","","BAUNFE" , "" , "" , "", "", "" })
aAdd(aRegs,{cPerg,"02","Ate RDA          ?","","","mv_ch2","C",06,0,0,"G","","mv_par02","","","","","","","","","","","","","","","","","","","","","","","","","BAUNFE" , "" , "" , "", "", "" })
aAdd(aRegs,{cPerg,"03","De Emissao       ?","","","mv_ch3","D",08,0,0,"G","","mv_par03","","","","","","","","","","","","","","","","","","","","","","","","","US2"    , "" , "" , "", "", "" })
aAdd(aRegs,{cPerg,"04","Ate Emissao      ?","","","mv_ch4","D",08,0,0,"G","","mv_par04","","","","","","","","","","","","","","","","","","","","","","","","","US2"    , "" , "" , "", "", "" })
aAdd(aRegs,{cPerg,"05","Competencia      ?","","","mv_ch5","C",07,0,0,"G","","mv_par05","","","","","","","","","","","","","","","","","","","","","","","","",""       , "" , "" , "", "99/9999", "" })
aAdd(aRegs,{cPerg,"06","Usuario          ?","","","mv_ch6","C",15,0,0,"G","","mv_par06","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "", "" })
aAdd(aRegs,{cPerg,"07","Dt.Digitacao De  ?","","","mv_ch7","D",08,0,0,"G","","mv_par07","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "", "" })
aAdd(aRegs,{cPerg,"08","Dt.Digitacao Ate ?","","","mv_ch8","D",08,0,0,"G","","mv_par08","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "", "" })

For i:=1 to Len(aRegs)
	If !dbSeek(cPerg+"    "+aRegs[i,2])
		RecLock("SX1",.T.)
		For j:=1 to FCount()
			If j <= Len(aRegs[i])
				FieldPut(j,aRegs[i,j])
			Endif
		Next
		MsUnlock()
	Endif
Next

RestArea( aAreaAtu )

Return(.T.)

