#INCLUDE "rwmake.ch"
#INCLUDE "topconn.ch"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ CABR095  บ Autor ณ Altamiro Affonso   บ Data ณ  01/08/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Relatorio apura็ใo de base de caldulo dos impostos         บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP6 IDE                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
User Function CABR068

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Declaracao de Variaveis                                             ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

Local cDesc1         := "Este programa tem como objetivo imprimir relatorio "
Local cDesc2         := "e emitir planilhas com os valores dos titulos      "
Local cDesc3         := "e dos seus impostos dos titulos baixados           "
Local cPict          := ""
Local titulo         := "Acompanhamento de Base e impostos de titulos baixados "
Local nLin           := 80 															
Local Cabec1         := "Pref. Num       Tipo  Fornecedor                              Base              Pis         Cofins           Csll           Irrf            Inss           Iss        Descres       Tot Base  Inss Patronal Tp Origem    "
Local Cabec2         := ""
//                       12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789001234567890
//                       0        1         2         3         4         5         6         7         8         9         10        11        12        13         14        15        16        17        18        19        20        21        22        23        24
//                        XXX  XXXXXXXXX  XX   XXXXXX - XXXXXXXXXXXXXXXXXXXXX  99.999.999,99   99.999.999,99  99.999.999,99  99.999.999,99  99.999.999,99  99.999.999,99  99.999.999,99  99.999.999,99  99.999.999,99  99.999.999,99  X XXXXXXXXXX   
//                      BK2_PROPRI||BK2_CODLAN,                                    Sum(BK2_SALDO) 
Local Cabec2         := ""
Local imprime        := .T.
Local aOrd           := {}
Private lEnd         := .F.
Private lAbortPrint  := .F.
Private CbTxt        := ""
Private limite       := 220
Private tamanho      := "G"
Private nomeprog     := "CABR68"
Private nTipo        := 15
Private aReturn      := { "Zebrado", 1, "Administracao", 1, 2, 1, "", 1}
Private nLastKey     := 0
Private cbtxt        := Space(10)
Private cbcont       := 00
Private CONTFL       := 01
Private m_pag        := 01
Private wnrel        := "CABR068"
Private cString      := "se2"
Private cPerg        := "CAB068    "
Private cquebra      := " " 
Private lflagtot     :=.F.
private cNovGrpPag   := " "      
private aDados       := {}  
private acabec1      := {'Pref.','Num','Tipo','Fornecedor','Base','Pis','Cofins','Csll','Irrf','Inss','Iss','Descres','Tot Base', 'Inss Patronal', 'Tp' , 'Origem' }
Private nTbase       := 0.00
Private	 nTpis       := 0.00
Private	 nTCofins    := 0.00
Private	 nTCsll      := 0.00
Private	 nTIrrf      := 0.00
Private	 nTInss      := 0.00
Private	 nTIss       := 0.00
Private	 nTDecresc   := 0.00
Private  nTTot_b     := 0.00   
private nTTot_biss   := 0.00 
private nZeros       := 0.00 

dbSelectArea("B44")
dbSetOrder(1)              
ValidPerg(cPerg)
If Pergunte(cPerg,.T.) = .F.
	Return
Endif
    
Private dDtinic    := dtos(mv_par01) 
Private dDtFim     := dtos(mv_par02) 
Private nGeraExc   := Iif(mv_par03==1,.T.,.F.)   
 
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

cQuery  := " SELECT e2_prefixo pref , e2_num Num , e2_tipo tipo, A2_COD Cod, A2_NOME Nome , e2_valor  Base, e2_vretpis Pis , "
cQuery  += " E2_VRETCOF Cofins, E2_VRETCSL Csll,  E2_IRRF Irrf, E2_INSS Inss, E2_ISS Iss ,E2_DECRESC Decresc , e2_origem origem , "
cQuery  += " (e2_valor + e2_vretpis +  E2_VRETCOF + E2_VRETCSL +  E2_IRRF + E2_INSS + E2_ISS + E2_DECRESC) Tot_base , a2_tipo Pessoa , "
cQuery  += " decode(a2_tipo ,'F',(e2_valor + e2_vretpis +  E2_VRETCOF + E2_VRETCSL +  E2_IRRF + E2_INSS + E2_ISS )*0.2,0.00 ) Inss_patronal "
cQuery  += " FROM "+ RetSqlName('SE2') +" SE2 "
cQuery  += " LEFT JOIN "+ RetSqlName('SA2') +" SA2 " 
cQuery  += " ON E2_FORNECE = A2_COD  and a2_filial = '"+xFilial("SA2")+"' AND E2_LOJA   = A2_LOJA  AND SA2.d_e_l_e_t_ = ' ' " 
cQuery  += " WHERE E2_FILIAL   = '"+xFilial("SE2")+"' " 
if mv_par04 = 1                                              
   cQuery  += " AND E2_origem  =  'PLSMPAG' " 
elseif mv_par04 = 2                                         
   cQuery  += " AND E2_origem  <> 'PLSMPAG' " 
EndIF                     
if mv_par05 = 1                                              
   cQuery  += " AND a2_tipo = 'F' " 
elseif mv_par04 = 2                                         
   cQuery  += " AND a2_tipo = 'J' " 
EndIF

cQuery  += " And e2_origem <> 'CAB007' AND SE2.D_E_L_E_T_ = ' ' AND E2_BAIXA BETWEEN '"+dDtinic+"' AND '"+dDtFim +"' "
cQuery  += " And E2_SALDO    = 0 " //and ((e2_prefixo = 'OPE' AND e2_ylibpls <>  'P') or (e2_prefixo = 'COM' AND e2_ylibpls <>  'P') or (a2_tipo = 'F' AND e2_ylibpls <>  'P') OR  e2_ylibpls  <> 'N' )"
cQuery  += " AND E2_TIPO NOT IN  ('ISS', 'TXA','TX','INS', 'DEV' , 'REM', 'PA', 'NDF', 'RC' , 'BOL')   " 
cQuery  += " ORDER BY  A2_NOME "  

 If Select(("TMP")) <> 0 
    ("TMP")->(DbCloseArea())  
 Endif
 TCQuery cQuery Alias "TMP" New 
 dbSelectArea("TMP")
 tmp->(dbGoTop())      
 
 	Do While !EOF()                                                            
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
//Local Cabec1         := "Pref. Num       Tipo  Fornecedor                              Base              Pis         Cofins           Csll           Irrf            Inss           Iss        Descres       Tot Base  Inss Patronal Tp Origem    "
//                       12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789001234567890
//                       0        1         2         3         4         5         6         7         8         9         10        11        12        13         14        15       16        17        18        19        20        21        22        23        24
//                        XXX  XXXXXXXXX  XX   XXXXXX - XXXXXXXXXXXXXXXXXXXXX  99.999.999,99   99.999.999,99  99.999.999,99  99.999.999,99  99.999.999,99  99.999.999,99  99.999.999,99  99.999.999,99  99.999.999,99  99.999.999,99  X XXXXXXXXXX   
                                                                                                  
     if tmp->tipo  $("DPJ|RLE|DEV")  
        nVlInssP := 0.00               
     else 
        nVlInssP := tmp->Inss_patronal
     Endif   
	 @ nLin,002 PSay tmp->pref 
	 @ nLin,007 PSay tmp->Num 
 	 @ nLin,018 PSay tmp->tipo 
	 @ nLin,023 PSay tmp->Cod + ' - ' + SUBSTR (tmp->Nome,01,20) 
     @ nLin,055 PSay Transform(tmp->Base,"@E 99,999,999.99")          
     nTbase +=tmp->Base
	 @ nLin,071 PSay Transform(tmp->Pis,"@E 99,999,999.99")  
	 nTpis  += tmp->Pis
	 @ nLin,086 PSay Transform(tmp->COFINS,"@E 99,999,999.99")
	 nTCofins += tmp->COFINS
	 @ nLin,101 PSay Transform(tmp->CSLL,"@E 99,999,999.99")
	 nTCsll += tmp->CSLL
	 @ nLin,116 PSay Transform(tmp->IRRF,"@E 99,999,999.99")
	 nTIrrf += tmp->IRRF
	 @ nLin,131 PSay Transform(tmp->INSS,"@E 99,999,999.99")
	 nTInss += tmp->INSS
	 @ nLin,146 PSay Transform(tmp->ISS,"@E 99,999,999.99") 
	 nTIss += tmp->ISS
	 @ nLin,161 PSay Transform(tmp->DECRESC,"@E 99,999,999.99") 
	 nTDecresc += tmp->DECRESC
 	 @ nLin,176 PSay Transform(tmp->TOT_BASE,"@E 99,999,999.99") 
 	 nTTot_b += tmp->TOT_BASE       
     @ nLin,191 PSay Transform(nVlInssP,"@E 99,999,999.99") 
 	 nTTot_biss += nVlInssP   
 	 @ nLin,206 PSay tmp->Pessoa  
 	 @ nLin,208 PSay tmp->origem
 	 nlin++
   If nGeraExc	
	aaDD(aDados,{tmp->pref,; 
                 tmp->Num,; 
                 tmp->tipo,; 
                 tmp->Cod + ' - ' + SUBSTR (tmp->Nome,01,40),; 
                 Transform(tmp->Base,"@E 99,999,999.99"),; 
                 Transform(tmp->Pis,"@E 99,999,999.99"),;
                 Transform(tmp->COFINS,"@E 99,999,999.99"),;
              	 Transform(tmp->CSLL,"@E 99,999,999.99"),;
	             Transform(tmp->IRRF,"@E 99,999,999.99"),;
	             Transform(tmp->INSS,"@E 99,999,999.99"),;
                 Transform(tmp->ISS,"@E 99,999,999.99"),; 
	             Transform(tmp->DECRESC,"@E 99,999,999.99"),; 
 	             Transform(tmp->TOT_BASE,"@E 99,999,999.99"),;
                 Transform(nVlInssP,"@E 99,999,999.99"),; 
 	             tmp->Pessoa,;  
 	             tmp->origem})          
  EndIf 
     tmp->(dbSkip())                
EndDo    
    @ nLin,000 PSay replicate("_",220)
    nlin++                         
     @ nLin,008 PSay  'Totais ---> ' 
     @ nLin,055  PSay Transform(nTbase,"@E 99,999,999.99")          
	 @ nLin,071 PSay Transform(nTpis,"@E 99,999,999.99")  
	 @ nLin,086 PSay Transform(nTCofins,"@E 99,999,999.99")
	 @ nLin,101 PSay Transform(nTCsll,"@E 99,999,999.99")
	 @ nLin,116 PSay Transform(nTIrrf,"@E 99,999,999.99")
	 @ nLin,131 PSay Transform(nTInss,"@E 99,999,999.99")
	 @ nLin,146 PSay Transform(nTIss,"@E 99,999,999.99") 
	 @ nLin,161 PSay Transform(nTDecresc,"@E 99,999,999.99") 
 	 @ nLin,176 PSay Transform(nTTot_b,"@E 99,999,999.99")      
 	 @ nLin,191 PSay Transform(nTTot_biss,"@E 99,999,999.99")       
 	 
     
    nlin++                         	 
                                          
 If nGeraExc	
  @ nLin,000 PSay replicate("_",220)            
   
	DlgToExcel({{"ARRAY"," Acompanhamento de Base e impostos de titulos baixados" ,aCabec1,aDados}}) 
 EndIf	
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

cPerg := PADR(cPerg,6)    

                                                                                                                                                                                           
PutSx1(cPerg,"01","Data inicial  " ,"","","mv_ch01","D",08,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","") 
PutSx1(cPerg,"02","Data Final    " ,"","","mv_ch02","D",08,0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","")   
PutSx1(cPerg,"03","Geral Excel   " ,"","","mv_ch03","N",01,0,0,"C","","","","","mv_par03","Sim     ","","","","Nใo        ","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"04","Origem        " ,"","","mv_ch04","N",01,0,0,"C","","","","","mv_par04","PLS     ","","","","Financeiro ","","","Ambos ","","","","","","","","",{},{},{})
PutSx1(cPerg,"05","Tipo Pessoal  " ,"","","mv_ch05","N",01,0,0,"C","","","","","mv_par05","Fisica  ","","","","Juridica   ","","","Ambos ","","","","","","","","",{},{},{})

Return(.T.)


