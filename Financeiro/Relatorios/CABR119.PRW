#INCLUDE "protheus.ch"  
#INCLUDE 'UTILIDADES.CH'
#INCLUDE "topconn.ch"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ CABA104  บ Autor ณ Altamiro Affonso   บ Data ณ  16/11/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Consutla titulo em outras filias <> 01                     บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP6 IDE                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
User Function CABR119

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Declaracao de Variaveis                                             ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

Local cDesc1         := "Este programa tem como objetivo fazer A consutla de titulos de ou mas RDA's em filiais diferentes da  "
Local cDesc2         := "01 , totalizando os impostos e saldo a pagar  "
Local cDesc3         := " "
Local cPict          := ""
Local titulo         := "Consulta Titulos em outras filiais - empresa - " + (iif(cEmpAnt == "01", "CABERJ", "INTEGRAL" )) 
Local nLin           := 220 															

Local Cabec1         := "Fil Pref  Num       Tpo   Rda     Codigo  Fornecedor                                    Emissใo       Venc.      Vlr Tit.    VLr.INSS     VLr.ISS     VLr.IRRF  VLr.COFINS     VLr.PIS    VLr.CSLL         SALDO    TOT_PAGTO"
//                       1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//                       0        1         2         3         4         5         6         7         8         9         10        11        12        13        14        15        16        17        18        19        20        21        22
//                       XX  XXX   XXXXXXXXX XXX   XXXXXX  XXXXXX  XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX  XX/XX/XXXX  XX/XX/XXXX 9.999.999,99  999.999,99  999.999,99   999.999,99  999.999,99  999.999,99  999.999,99  9.999.999,99 9.999.999,99                    


Local Cabec2         := ""
Local imprime        := .T.
Local aOrd           := {}
Private lEnd         := .F.
Private lAbortPrint  := .F.
Private CbTxt        := ""
Private limite       := 220
Private tamanho      := "G"
Private nomeprog     := "CABR119"
Private nTipo        := 15
Private aReturn      := { "Zebrado", 1, "Administracao", 1, 2, 1, "", 1}
Private nLastKey     := 0
Private cbtxt        := Space(10)
Private cbcont       := 00
Private CONTFL       := 01
Private m_pag        := 01
Private wnrel        := "CABR119"
Private cString      := "SE2"
Private cPerg        := "CABR119   "
Private vlr_tot      := 0.00  
Private vlr_Sald     := 0.00                                                                      
Private cquebra      := " " 
Private lflagtot     :=.F.
private cNovGrpPag   := " "     
private cnome        := ' '
private  nMACob      := ' '                                                   
private  nMADev      := ' '                                                         
private  vlr_TotCom  := 0.00
private  vlr_TotBas  := 0.00  
private  cseq        :=' '      
private  aCabec1     := {"Fil","Pref","Num","Tpo","Rda","Codigo","Fornecedor","Emissใo","Venc.","Vlr Tit.","VLr.INSS","VLr.ISS","VLr.IRRF","VLr.COFINS","VLr.PIS","VLr.CSLL","SALDO","TOT_PAGTO"}
private  aDados      := {}

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

cQuery := "select  e2_filial , e2_prefixo , e2_num     , e2_tipo    , e2_codrda , e2_fornece , e2_nomfor  , "
cQuery += " SUBSTR (e2_Emissao,7,2)||'/'||SUBSTR (e2_Emissao,5,2)||'/'||SUBSTR (e2_Emissao,1,4) emissao,    "
cQuery += " SUBSTR (e2_vencrea,7,2)||'/'||SUBSTR (e2_vencrea,5,2)||'/'||SUBSTR (e2_vencrea,1,4) venc,       "
cQuery += " e2_vencrea , e2_valor , e2_inss , e2_iss , e2_irrf , e2_vretcof , e2_vretpis , e2_vretcsl , e2_saldo , "
cQuery += " (e2_inss + e2_iss + e2_irrf + e2_vretcof + e2_vretpis + e2_vretcsl + e2_saldo ) tot_pagto "  
cQuery += " from  "+ RetSqlName('SE2') +"  where d_E_L_E_T_ = ' ' " 
If !empty (mv_par01) 
  //  cQuery +=" AND e2_codrda IN " + FormatIn(mv_par01, ",")          

  cQuery +=" AND e2_codrda >=  '" + mv_par01 +"' AND e2_codrda <=  '" + mv_par02 +"'"          

EndIF
cQuery += " and e2_saldo > 0 and e2_tipo = 'FT' and e2_filial <> '" + xFilial("SE2") +"' order by  e2_codrda "
 
 
 If Select(("TMP")) <> 0 
       ("TMP")->(DbCloseArea())  
 Endif
    TCQuery cQuery Alias "TMP" New 
    dbSelectArea("TMP")
    tmp->(dbGoTop())                                         
// MsgAlert("Titulo "+mv_par01+' '+mv_par02+' ' +mv_par03+' '+mv_par04+' do Fornecedor '+mv_par05+" Foi Liberado Com Sucesso ","Concluido","INFO")                                
  
    While !TMP->(EOF())                                                           
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
	cnome := substr (tmp->e2_nomfor, 1,40)                                        
//Local Cabec1         := "Fil Pref  Num       Tpo   Rda     Codigo  Fornecedor                                 Emissใo        Venc.     Vlr Tit. 	 VLr.INSS     VLr.ISS	  VLr.IRRF  VLr.COFINS	   VLr.PIS    VLr.CSLL	       SALDO   TOT_PAGTO"
//                         1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//                         0        1         2         3         4         5         6         7         8         9         10        11        12        13        14        15        16        17        18        19        20        21        22
//                         XX  XXX   XXXXXXXXX XXX   XXXXXX  XXXXXX  XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX  XX/XX/XXXX  XX/XX/XXXX 9.999.999,99  999.999,99  999.999,99   999.999,99  999.999,99  999.999,99  999.999,99  9.999.999,99 9.999.999,99                    
	
	
	 @ nLin,000 PSay  tmp->e2_filial + '  ' + tmp->E2_PREFIXO + '   ' + tmp->E2_NUM + '  ' + tmp->E2_TIPO + '   ' + tmp->e2_CODRDA  + '  ' + tmp->E2_FORNECE  + '  ' +	cnome
	 @ nLin,086 PSay  TRIM(tmp->EMISSAO) + '  ' + TRIM(TMP->VENC)       
 	 @ nLin,109 PSay  tmp->E2_VALOR   Picture "@E 9,999,999.99" 
  	 @ nLin,123 PSay  tmp->E2_INSS    Picture "@E 999,999.99" 
	 @ nLin,135 PSay  tmp->E2_ISS     Picture "@E 999,999.99"
   	 @ nLin,148 PSay  tmp->E2_IRRF    Picture "@E 999,999.99"
	 @ nLin,160 PSay  tmp->E2_VRETCOF Picture "@E 999,999.99"
     @ nLin,172 PSay  tmp->E2_VRETPIS Picture "@E 999,999.99"
     @ nLin,184 PSay  tmp->E2_VRETCSL Picture "@E 999,999.99"

	 @ nLin,196 PSay  tmp->E2_SALDO   Picture "@E 9,999,999.99"
	 @ nLin,209 PSAY  TMP->tot_pagto  Picture "@E 9,999,999.99"      

	nLin ++     // Avanca a linha de impressao    
	if mv_par03	= 1
	 aaDD(aDados,{  tmp->e2_filial ,;
	                tmp->E2_PREFIXO ,;
                    tmp->E2_NUM ,;
                    tmp->E2_TIPO ,;
                    tmp->e2_CODRDA ,;
                    tmp->E2_FORNECE ,;
                    cnome ,;       
                    tmp->EMISSAO ,;
                    TMP->VENC ,; 
 	      Transform(tmp->E2_VALOR    ,"@E 999,999,999.99"	),; 
      	  Transform(tmp->E2_INSS     ,"@E 999,999.99" 	),;
	      Transform(tmp->E2_ISS      ,"@E 999,999.99"	),;
   	      Transform(tmp->E2_IRRF     ,"@E 999,999.99"	),;
	      Transform(tmp->E2_VRETCOF  ,"@E 999,999.99"	),;
          Transform(tmp->E2_VRETPIS  ,"@E 999,999.99"	),;	
          Transform(tmp->E2_VRETCSL  ,"@E 999,999.99"),;
	      Transform(tmp->E2_SALDO    ,"@E 999,999,999.99"),;
	      Transform(TMP->tot_pagto   ,"@E 999,999,999.99" )} )                 
    EndIF	
	dbSkip()   // Avanca o ponteiro do registro no arquivo
EndDo    
    @ nLin,000 PSay replicate("_",220)  
    		
if mv_par03	= 1		  
   DlgToExcel({{"ARRAY","Rela็ใo dos Titulos da Empresa - " + iif(cEmpAnt == "01", "CABERJ", "INTEGRAL" ) ,aCabec1,aDados}})
EndIF
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

PutSx1(cPerg,"01","Codigo do RDA De "  ,"","","mv_ch01","C",06,0,0,"G","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "", "" )   
PutSx1(cPerg,"02","Codigo do RDA Ate"  ,"","","mv_ch02","C",06,0,0,"G","","mv_par02","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "", "" )   
PutSx1(cPerg,"03","Gerar Excel      "  ,"","","mv_ch03","N",01,0,0,"C","","","","","mv_par03","Sim ","","","","Nใo ","","","","","","","","","","","",{},{},{})

Return(.T.)
