#INCLUDE "PROTHEUS.CH"  
#INCLUDE 'UTILIDADES.CH'
#INCLUDE "TOPCONN.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ CABA104  บ Autor ณ Altamiro Affonso   บ Data ณ  10/11/09   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ DEBITO DE COMISSรO                                         บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP6 IDE                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ               
ฑฑบAltera็ใo ณ Angelo Henrique - Data: 12/08/2019                         บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบDescri็ใo ณ Corre็ใo de variaveis nใo utilizadas.                      บฑฑ
ฑฑบ          ณ Mudan็a na chamada do fonte RunReport por dar conflito P12 บฑฑ
ฑฑบ          ณalterado para CABA104A                                      บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
User Function CABA104()

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Declaracao de Variaveis                                             ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

Local cDesc1         := "Este programa tem como objetivo fazer A libera็ใo dos titulos de Reembolso para exclusao  "
Local cDesc2         := "Trocando a SE2_e2_origem de cab007 para FINA050 , e assim liberando-o para manuten็ใo pelo financeiro "
Local cDesc3         := " "
Local titulo         := "libera็ใo para exclusใo de Titulos Financeiro de Reembolso "
Local nLin           := 220 															

Local Cabec1         := " Ident. Titulo        Fornecedor                                          Emissao     Venc.Real   Origem De  Origem Para            Saldo  Tit. Origem                                 Vlr Base       %          Vlr Com.    Mes/Ano Cobr.  Mes/Ano Dev. "
//                       12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//                       0        1         2         3         4         5         6         7         8         9         10        11        12        13        14        15        16        17
//                       XXX-XXXXXXXXX-X-XXX   XXXXXX - XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX  XX/XX/XXXX  XX/XX/XXXX   XXXXXXX     XXXXXXX     999.999.999,99  XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX


Local Cabec2         := ""
Local aOrd           := {}
Private lAbortPrint  := .F.
Private limite       := 220
Private tamanho      := "G"
Private nomeprog     := "CABA104"
Private nTipo        := 15
Private aReturn      := { "Zebrado", 1, "Administracao", 1, 2, 1, "", 1}
Private nLastKey     := 0
Private wnrel        := "CABA104"
Private cString      := "SE2"
Private cPerg        := "CABA104"                                                                               
PRIVATE nSucesso     := 0

dbSelectArea("SE2")
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

RptStatus({|| CABA104A(Cabec1,Cabec2,Titulo,nLin) },Titulo)

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuno    ณCABA104A  บ Autor ณ AP6 IDE            บ Data ณ  31/08/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescrio ณ Funcao auxiliar chamada pela RPTSTATUS. A funcao RPTSTATUS บฑฑ
ฑฑบ          ณ monta a janela com a regua de processamento.               บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Programa principal                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/

Static Function CABA104A(Cabec1,Cabec2,Titulo,nLin)

Local cQuery := ''
                                          
dbSelectArea(cString)
dbSetOrder(1)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ SETREGUA -> Indica quantos registros serao processados para a regua ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

SetRegua(RecCount())       

cQuery := "select E2_PREFIXO , E2_NUM , E2_PARCELA , E2_TIPO , E2_FORNECE , e2_nomfor , E2_EMISSAO , E2_VENCREA , E2_ORIGEM , E2_VALOR , e2_saldo, E2_TITORIG , E2_LA"
cQuery += " from " + RetSqlName('SE2') + " SE2  where E2_FILIAL = '" + xFilial("SE2") +"' and d_E_L_E_T_  = ' ' AND E2_BAIXA    = ' ' "
cQuery += " AND E2_SALDO = E2_VALOR and e2_prefixo  = '"+mv_par01+"' AND E2_NUM      = '"+mv_par02+"' AND E2_PARCELA  = '"+mv_par03+"'"
cQuery += " AND E2_TIPO  = '"+mv_par04+"' AND E2_FORNECE  = '"+mv_par05+"' "
IF mv_par01 == 'RLE'  
   cQuery += " AND E2_ORIGEM = 'CAB007' "
EndIf               
IF mv_par01 == 'COM'                    
   cQuery += " AND E2_LA  = 'S' "
EndIF                                  
                                                                                                                                                                        
If Select(("TMP")) <> 0 
     ("TMP")->(DbCloseArea())  
 Endif
    TCQuery cQuery Alias "TMP" New 
    dbSelectArea("TMP")
    tmp->(dbGoTop())                  

If mv_par06 = 1 .and. (mv_par01 = 'RLE' .or.  mv_par01 = 'COM')
   IF mv_par01 == 'RLE' 
      cQuery1 := " UPDATE "+RetSqlName("SE2")+ " SET E2_ORIGEM = 'FINA050' "
      cQuery1 += " Where  E2_FILIAL = '" + xFilial("SE2") +"' and d_E_L_E_T_  = ' ' AND E2_BAIXA    = ' ' "
      cQuery1 += " AND E2_SALDO = E2_VALOR and e2_prefixo  = '"+mv_par01+"' AND E2_NUM      = '"+mv_par02+"' AND E2_PARCELA  = '"+mv_par03+"'"
      cQuery1 += " AND E2_TIPO  = '"+mv_par04+"' AND E2_FORNECE  = '"+mv_par05+"' AND E2_ORIGEM = 'CAB007'  "
   ElseIF mv_par01 == 'COM'                                                                                                                                                 
      cQuery1 := " UPDATE "+RetSqlName("SE2")+ " SET E2_LA = ' ' "
      cQuery1 += " Where  E2_FILIAL = '" + xFilial("SE2") +"' and d_E_L_E_T_  = ' ' AND E2_BAIXA    = ' ' "
      cQuery1 += " AND E2_SALDO = E2_VALOR and e2_prefixo  = '"+mv_par01+"' AND E2_NUM      = '"+mv_par02+"' AND E2_PARCELA  = '"+mv_par03+"'"
      cQuery1 += " AND E2_TIPO  = '"+mv_par04+"' AND E2_FORNECE  = '"+mv_par05+"' AND E2_LA = 'S'  "
   EndIf  
 
   If tmp->E2_NUM     == mv_par02
       BEGIN TRANSACTION
		
       nSucesso := TcSqlExec(cQuery1)       

       MsgAlert("Titulo "+mv_par01+' '+mv_par02+' ' +mv_par03+' '+mv_par04+' do Fornecedor '+mv_par05+" Foi Liberado Com Sucesso ","Concluido","INFO")                                
       
       End TRANSACTION
    ElseIf mv_par06 = 1 
      MsgAlert("Titulo "+mv_par01+' '+mv_par02+' ' +mv_par03+' '+mv_par04+' do Fornecedor '+mv_par05+" Nใo e de Reembolso ou de Comissใo  ou nao foi encontrado , verifique","Concluido","INFO")                                   
    EndIf 
endIF                       
                       
// MsgAlert("Titulo "+mv_par01+' '+mv_par02+' ' +mv_par03+' '+mv_par04+' do Fornecedor '+mv_par05+" Foi Liberado Com Sucesso ","Concluido","INFO")                                
  
    While !TMP->(EOF()) .and. (mv_par01 = 'RLE' .or.  mv_par01 = 'COM')                                                                
	  If nLin > 65 // Salto de Pแgina. Neste caso o formulario tem 55 linhas...
   	     nLin :=	Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
	     nLin ++
	  Endif
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
	 @ nLin,000 PSay  E2_PREFIXO + '-' + E2_NUM + '-' + E2_PARCELA + '-' + E2_TIPO
	 @ nLin,023 PSay  tmp-> E2_FORNECE  + ' - ' + tmp->e2_nomfor
	 @ nLin,075 PSay  stod(tmp->E2_EMISSAO)
	 @ nLin,087 PSay  stod(tmp->E2_VENCREA) 
	  IF mv_par01 = 'RLE' 
   	     @ nLin,099 PSay  tmp->E2_ORIGEM   
         @ nLin,110 PSay  'FINA050'   
      else                            
         @ nLin,099 PSay  tmp->E2_la   
         @ nLin,110 PSay  ' '   
      EndIf   
         
	 @ nLin,124 PSay  tmp->E2_SALDO   Picture "@E 999,999.99"
	 @ nLin,140 PSAY  TMP->E2_TITORIG        

	nLin ++     // Avanca a linha de impressao
	dbSkip()   // Avanca o ponteiro do registro no arquivo
EndDo    
    @ nLin,000 PSay replicate("_",220)  
    		
			  


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

cPerg := PADR(cPerg,7)    

PutSx1(cPerg,"01","Prefixo Do Titulo    "  ,"","","mv_ch01","C",03,0,0,"G","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "", "" )   
PutSx1(cPerg,"02","Numero  Do Titulo    "  ,"","","mv_ch02","C",09,0,0,"G","","mv_par02","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "", "" )  
PutSx1(cPerg,"03","Parcela Do Titulo    "  ,"","","mv_ch03","C",01,0,0,"G","","mv_par03","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "", "" )  
PutSx1(cPerg,"04","Tipo do Titulo       "  ,"","","mv_ch04","C",03,0,0,"G","","mv_par04","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "", "" ) 
PutSx1(cPerg,"05","Fornecedor do Titulo "  ,"","","mv_ch05","C",06,0,0,"G","","mv_par05","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "", "" )  
PutSx1(cPerg,"06","Grava Altera็ใo      "  ,"","","mv_ch06","N",01,0,0,"C","","","","","mv_par06","Sim ","","","","Nใo ","","","","","","","","","","","",{},{},{})

Return(.T.)
