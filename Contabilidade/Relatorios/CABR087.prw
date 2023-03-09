#INCLUDE "rwmake.ch"
#INCLUDE "topconn.ch"     


#Define CRLF Chr(13)+Chr(10)
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ CABR089  º Autor ³ Altamiro Affonso   º Data ³  05/11/08   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Relatorio de Conferencia de Notas Fiscais para Dief        º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP6 IDE                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function CABR087

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Local cDesc1         := "Este programa tem como objetivo imprimir relatorio "
Local cDesc2         := "NF de que tenhao retencao de ISS para infornar a   "
Local cDesc3         := "secretaria de receita municipal pela Dief          "
Local cPict          := ""
Local titulo         := "Notas Fiscais que tenham retencao de ISS para informar a DIEF  "
Local nLin           := 80 																									     // 05/10/2008 - ALTAMIRO
Local Cabec1         := "Razao Social                             Endereco                                 Bairro              Est Municipio        Cep       Cnpj           Ins.Munic.  Dt.Emis. Num.NF    Valor Bruto     Valor ISS    
Local Cabec2         := " "
//                       123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//                       0        1         2         3         4         5         6         7         8         9         0         1         2         3         4         5         6         7         8         9         0         1         2         3
//                       XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX XXXXXXXXXXXXXXXXXXXX XX XXXXXXXXXXXXXXXX XXXXX-XXX XXXXXXXXXXXXXX XXXXXXXXXX  XX/XX/XX XXXXXX XXXXXXXXXXXXXX XXXXXXXXXXXXX XXXXXXXXXXXXX
//                       1                                       2                              3             4              5              6          7              8              9          10     11             12
////////////////////////////////////CAMPOS  DO RELATORIO (COLUNAS DA TABELA SE2 - CONTAS A PAGAR)/////////////////////////////////////////////////////////////////////////////////              
//                          1 = A2_MONE      -   nome      do fornecedor     40
//                          2 = A2_END       -   endereco  do fornecedor (Rua , Av. , Est., etc . . . )
//                          3 = A2_BAIRRO    -   bairro    do endereco do fornecedor  
//                          4 = A2_EST       -   estado    do endereco do fornecedor 
//                          5 = A2_MUNICIPIO -   municipio do endereco do fornecedor  
//                          6 = A2_CEP       -   cep       do endereco do fornecedor 
//                          7 = A2_CGC       -   cnpj      do fornecedor 
//                          8 = A2_INSCR     -   inscricao municipal do fornecedor 
//                          9 = ZB_EMISSAO   -   data da emissao da NF do fornecedor 
//                          10= ZB_NOTA      -   numero da NF do fornecedor 
//                          11= ZB_VTOTAL    -   valor total da NF do fornecedor 
//                          12= E2_ISS       -   valor do iss do total da nf do fornecedor
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Local Cabec2         := ""           
Local imprime        := .T.
Local aOrd           := {}
Private lEnd         := .F.
Private lAbortPrint  := .F.
Private CbTxt        := ""
Private limite       := 221
Private tamanho      := "G"
Private nomeprog     := "CABR087"
Private nTipo        := 15
Private aReturn      := { "Zebrado", 1, "Administracao", 1, 2, 1, "", 1}
Private nLastKey     := 0
Private cbtxt        := Space(10)
Private cbcont       := 00
Private CONTFL       := 01
Private m_pag        := 01
Private wnrel         := "CABR087"
Private cString       := "SE2"
Private cPerg         := "CABS87" 
private valor_tot     := 0   
private valor_tot_iss := 0 
private valor_iss     := 0.00    
private valor_t_i_a   := 0.00
private vlr_tot       := 0.00 
private vlr_tot_iss   := 0.00
private vlr_t_i_a     := 0.00 
   
private VlTotTr       := 0.00
private VlTotDF       := 0.00
  
private nHdl          := ""

private qtdnf         := 0 
private qtdanft       := 0 
private nreg          := 0  
private fim           := "nao"
private tm_a2nom      := " "
private tm_e2iss      := 0.00
private tm_e2num      := " "
private tm_e2ems      := " "
private tm_a2cod      := " "  

private tm1_a2nom      := " "
private tm1_e2iss      := 0.00
private tm1_e2num      := " "
private tm1_e2ems      := " "
private tm1_a2cod      := " "
private vlbrt          := 0.00  
conexcel:= 1

dbSelectArea("SE2")
dbSetOrder(1)

ValidPerg(cPerg)
If Pergunte(cPerg,.T.) = .F.
	Return
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta a interface padrao com o usuario...                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

wnrel := SetPrint(cString,NomeProg,"",@titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,.F.,Tamanho,,.T.)

If nLastKey == 27
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
	Return
Endif               

private aArray1 := {{"01", StrZero(mv_par08,8),StrZero(mv_par09,4), StrZero(mv_par10,2)," "," "," "," "," "," "," "}}

nTipo := If(aReturn[4]==1,15,18)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Processamento. RPTSTATUS monta janela com a regua de processamento. ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

RptStatus({|| RunReport(Cabec1,Cabec2,Titulo,nLin) },Titulo)
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFun‡„o    ³RUNREPORT º Autor ³ AP6 IDE            º Data ³  31/08/07   º±±
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

Local nOrdem
Local cQuery := ' '
dbSelectArea(cString)
dbSetOrder(1)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ SETREGUA -> Indica quantos registros serao processados para a regua ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetRegua(RecCount())                     
////////////////////////////////////////////////////////////////

cQuery := " SELECT  a2_nome , a2_end , a2_bairro, a2_est  , a2_estado, a2_mun ,  a2_cep, zb_emissao, zb_nota, a2_cgc   , a2_inscrm, zb_vtotal,e2_valliq, "
cQuery += "  e2_iss    , e2_tipo, zb_tipo  , zb_anomes, BAU_YALISS "
cQuery += " FROM " + RetSqlName("SE2")+" SE2, "+ RetSQLName("")+" SZB, " + RetSQLName("SA2")+" SA2,"  + RetSQLName("BAU")+" BAU"

cQuery += " WHERE SE2.E2_FILIAL = '"+xFilial("SE2")+"' "  
cQuery += " AND   SA2.A2_FILIAL = '"+xFilial("SA2")+"' " 
cQuery += " AND   SZB.ZB_FILIAL = '"+xFilial("SZB")+"' " 
cQuery += " AND   BAU.BAU_FILIAL = '"+xFilial("BAU")+"' " 

cQuery += " AND   SE2.D_E_L_E_T_ <> '*' "
cQuery += " AND   SZB.D_E_L_E_T_ = ' ' " 
cQuery += " AND   SA2.D_E_L_E_T_ = ' ' "   
cQuery += " AND   BAU.D_E_L_E_T_ = ' ' " 

cQuery += " AND   E2_TIPO <> 'PA '" 
cQuery += " AND   A2_TIPO = 'J'" 

cQuery += " AND   zb_titulo   = e2_num "
cQuery += " AND   E2_PREFIXO  = ZB_PREFIXO " 

cQuery += " AND   E2_PARCELA = ZB_PARCELA" 
cQuery += " AND   ZB_TIPO    = E2_TIPO" 

cQuery += " AND   SE2.E2_FORNECE = SA2.A2_COD "   
cQuery += " AND   zb_fornece = a2_cod "    
cQuery += " AND   BAU_CODSA2 = a2_cod " 
cQuery += " AND   e2_iss > 0 and e2_baixa <> ' ' "                     

//cQuery += " AND (a2_mun <> 'RIO DE JANEIRO' )" 
//cQuery += " AND   zb_emissao BETWEEN '" + dTos(Mv_Par01) + "' AND '" + dTos(Mv_Par02) + "' " 
//cQuery += " AND   e2_baixa BETWEEN '" + dTos(Mv_Par01) + "' AND '" + dTos(Mv_Par02) + "' " 


 if mv_par04  == 1
    cQuery += " AND   zb_emissao BETWEEN '" + dTos(Mv_Par01) + "' AND '" + dTos(Mv_Par02) + "' " 
 else	  
    cQuery += " AND   e2_baixa BETWEEN '" + dTos(Mv_Par01) + "' AND '" + dTos(Mv_Par02) + "' " 
 endif 
    cQuery += " ORDER BY a2_nome , ZB_EMISSAO "
If Select("TMP") > 0
	dbSelectArea("TMP")
	dbclosearea()
Endif                

                                                

TCQuery cQuery Alias "TMP" New
dbSelectArea("TMP")
tmp->(dbGoTop())
valor_tot := 0   
valor_tot_iss := 0
qtdanf := 0 
// cabecalho inicial imprime tendo ou nao linhas de detalhe
	If nLin > 70 // Salto de Página. Neste caso o formulario tem 69 linhas...
		nLin := Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
		nLin++
	Endif
While !EOF()
	If nLin > 70 // Salto de Página. Neste caso o formulario tem 69 linhas...
		nLin := Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
		nLin++
	Endif
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica o cancelamento pelo usuario...                             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	If lAbortPrint
		@nLin,00 PSAY "*** CANCELADO PELO OPERADOR ***"
		Exit
	Endif
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Impressao do cabecalho do relatorio. . .                            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	if nLin = 68     // linhas de sub totais
	  @ nLin,000 PSay replicate("_",220)
	    nLin := nLin + 1
	   
	
	  @ nLin,003 PSAY "Qtda Parcial "
	  @ nlin,015 PSAY qtdanf  Picture "@E 999,999" 
	  @ nLin,060 PSAY "Total Parcial ---> " 
      @ nLin,177 PSAY valor_tot  Picture "@E 999,999,999.99" 
   	  @ nLin,192 PSAY valor_tot_iss  Picture "@E 999,999,999.99"  
 // 	  @ nLin,191 PSAY valor_t_i_a  Picture "@E 999,999,999.99" 
  	    nLin := nLin + 1     
	  @ nLin,000 PSay replicate("_",220)  
	    nLin := nLin + 1
	Endif  
	If nLin > 70 // Salto de Página. Neste caso o formulario tem 69 linhas...
		nLin := Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
		nLin++
	Endif                   
	  qtdanf++
	@ nLin,001 PSAY SUBSTR (TMP->A2_NOME,1,40) 
	@ nLin,042 PSAY SUBSTR (TMP->A2_END,1,45)
	@ nLin,083 PSAY SUBSTR (TMP->A2_BAIRRO,1,20) 
	@ nlin,104 PSAY TMP->A2_EST 
	@ nlin,107 PSAY SUBSTR (TMP->A2_MUN,1,16)
                       
	@ nLin,124 PSAY TMP->A2_CEP        
	         
	@ nLin,134 PSAY TMP->A2_CGC     
             
 
	@ nLin,149 PSAY TMP->A2_INSCRM  

	@ nLin,161 PSAY stod(TMP->ZB_EMISSAO)
	@ nLin,170 PSAY (TMP->ZB_NOTA)    

	@ nLin,177 PSAY TMP->ZB_VTOTAL  Picture "@E 999,999,999.99"
	  
	  Valor_iss := noround (((tmp->zb_vtotal * tmp->BAU_YALISS) / 100),2)    
	@ nLin,192 PSAY valor_ISS    Picture "@E 999,999,999.99" 	  
	if valor_iss != e2_iss
       @ nLin,205 PSAY '*'   
       @ nLin,207 psay e2_iss  Picture "@E 999,999.99"
    endif   
	

	 
	valor_tot := (valor_tot + TMP->ZB_VTOTAL) 
	valor_tot_iss := (valor_tot_iss + Valor_ISS) 
	//valor_t_i_a  := valor_t_i_a +TMP->E2_ISS
	nLin := nLin + 1 // Avanca a linha de impressao
	dbSkip()   // Avanca o ponteiro do registro no arquivo
EndDo
                          
////////////////////sub-total do RDAs///////////////////////////////////////////////////////////////////////////
	  @ nLin,000 PSay replicate("_",220)
	    nLin := nLin + 1
	   
	 
	  @ nLin,003 PSAY "Qtda RDA'S "
  	  @ nlin,015 PSAY qtdanf  Picture "@E 999,999"    
  	  @ nLin,060 PSAY "Total Parcial RDA's---> " 
     @ nLin,177 PSAY valor_tot  Picture "@E 999,999,999.99" 
 	  @ nLin,192 PSAY valor_tot_iss  Picture "@E 999,999,999.99"  
 // 	  @ nLin,191 PSAY valor_t_i_a  Picture "@E 999,999,999.99" 
  	    nLin := nLin + 1     
	  @ nLin,000 PSay replicate("_",220)  
	    nLin := nLin + 1
	qtdanft:= qtdanf                               
	qtdanf:= qtdanf + 2
///////////////////////////////////          
conexcel := 1
excel87()
qtdanf:=0
//////////////////////////////////trata NF nao RDAs////////////////////////////////////////////////////////////////
cQuery := " SELECT  a2_nome , a2_end , a2_bairro, a2_est, a2_mun, a2_estado, a2_cep, e2_emissao, e2_num, a2_cgc , a2_inscrm, e2_valor , e2_valliq, e2_iss, e2_tipo, "
cQuery += " E2_ISS , E2_IRRF , E2_SEST , E2_VRETCOF , E2_VRETPIS , E2_VRETCSL , E2_INSS" 

cQuery += " FROM " + RetSqlName("SE2")+" SE2, " + RetSQLName("SA2")+" SA2"
cQuery += " WHERE SE2.E2_FILIAL = '"+xFilial("SE2")+"' "  
cQuery += " AND   SA2.A2_FILIAL = '"+xFilial("SA2")+"' " 
cQuery += " AND   SE2.D_E_L_E_T_ <> '*' "
cQuery += " AND   SA2.D_E_L_E_T_ = ' ' "   
cQuery += " AND   E2_TIPO <> 'ISS'" 
cQuery += " AND   (E2_PREFIXO = 'COM'"  
cQuery += " OR   E2_TIPO = 'NF ')" 

cQuery += " AND   SE2.E2_FORNECE = SA2.A2_COD "   
cQuery += " AND   e2_iss > 0 and e2_baixa <> ' ' "
          //AND a2_mun = 'RIO DE JANEIRO' " 
 if mv_par04  == 1
	 cQuery += " AND   e2_emissao BETWEEN '" + dTos(Mv_Par01) + "' AND '" + dTos(Mv_Par02) + "' " 
	 cQuery += " ORDER BY a2_nome , e2_EMISSAO "
 else	  
    cQuery += " AND   e2_baixa BETWEEN '" + dTos(Mv_Par01) + "' AND '" + dTos(Mv_Par02) + "' " 
    cQuery += " ORDER BY a2_nome , e2_baixa "
 endif    

If Select("TMP") > 0
	dbSelectArea("TMP")
	dbclosearea()
Endif                

TCQuery cQuery Alias "TMP" New
dbSelectArea("TMP")
tmp->(dbGoTop())

vlr_tot     := 0.00 
vlr_tot_iss := 0.00
vlr_t_i_a   := 0.00 
 
// cabecalho inicial imprime tendo ou nao linhas de detalhe
	If nLin > 70 // Salto de Página. Neste caso o formulario tem 69 linhas...
		nLin := Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
		nLin++
	Endif
While !EOF()
	If nLin > 70 // Salto de Página. Neste caso o formulario tem 69 linhas...
		nLin := Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
		nLin++
	Endif
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica o cancelamento pelo usuario...                             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	If lAbortPrint
		@nLin,00 PSAY "*** CANCELADO PELO OPERADOR ***"
		Exit
	Endif
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Impressao do cabecalho do relatorio. . .                            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	if nLin = 68     // linhas de sub totais
	  @ nLin,000 PSay replicate("_",220)
	    nLin := nLin + 1
	   
	  @ nLin,003 PSAY "Qtda Parcial "
      @ nlin,015 PSAY qtdanf  Picture "@E 999,999" 
	  @ nLin,060 PSAY "Total Parcial Nao RDA's---> "   
      @ nLin,177 PSAY vlr_tot  Picture "@E 999,999,999.99" 
  	  @ nLin,192 PSAY vlr_tot_iss  Picture "@E 999,999,999.99"  
 // 	  @ nLin,191 PSAY vlr_t_i_a  Picture "@E 999,999,999.99" 
  	    nLin := nLin + 1     
	  @ nLin,000 PSay replicate("_",220)  
	    nLin := nLin + 1
	Endif  
	If nLin > 70 // Salto de Página. Neste caso o formulario tem 69 linhas...
		nLin := Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
		nLin++
	Endif                   
	qtdanf++
	@ nLin,001 PSAY SUBSTR (TMP->A2_NOME,1,40) 
	@ nLin,042 PSAY SUBSTR (TMP->A2_END,1,40)
	@ nLin,083 PSAY SUBSTR (TMP->A2_BAIRRO,1,16) 
	@ nlin,104 PSAY TMP->A2_EST 
	@ nlin,107 PSAY SUBSTR (TMP->A2_MUN,1,16)
                       
	@ nLin,124 PSAY TMP->A2_CEP        
	
	@ nLin,134 PSAY TMP->A2_CGC     
 
	@ nLin,149 PSAY TMP->A2_INSCRM  

	@ nLin,161 PSAY stod(TMP->e2_EMISSAO)
	@ nLin,170 PSAY (TMP->e2_num)    
  	  vlbrt :=  (TMP->E2_VALOR + (TMP->E2_ISS + TMP->E2_IRRF + TMP->E2_SEST + TMP->E2_VRETCOF + TMP->E2_VRETPIS + TMP->E2_VRETCSL + TMP->E2_INSS)) 

  //	@ nLin,177 PSAY TMP->e2_valor  Picture "@E 999,999,999.99"
	@ nLin,177 PSAY vlbrt  Picture "@E 999,999,999.99"	
      
     
//   @ nLin,191 PSAY tmp->E2_ISS     Picture "@E 999,999,999.99"
	@ nLin,192 PSAY TMP->E2_ISS    Picture "@E 999,999,999.99" 		

//	@ nLin,120 PSAY stod(TMP->E2_YDTLBPG) 
//	@ nLin,130 PSAY stod(TMP->E2_BAIXA)
//	@ nLin,143 PSAY TMP->E2_YLIBPLS
	 
	vlr_tot := (vlr_tot + vlbrt) 
	vlr_tot_iss := (vlr_tot_iss + tmp->e2_ISS) 
//	vlr_t_i_a  := vlr_t_i_a +TMP->E2_ISS
	nLin := nLin + 1 // Avanca a linha de impressao
	dbSkip()   // Avanca o ponteiro do registro no arquivo  
	vlbrt := 0
EndDo                          
	  @ nLin,000 PSay replicate("_",220)
	    nLin := nLin + 1
	   
	   
	  @ nLin,003 PSAY "Qtda NAO RDA's "
	  @ nlin,015 PSAY qtdanf  Picture "@E 999,999"  
	  @ nLin,060 PSAY "Total Parcial Nao RDA's---> "
     @ nLin,177 PSAY vlr_tot  Picture "@E 999,999,999.99" 
  	  @ nLin,192 PSAY vlr_tot_iss  Picture "@E 999,999,999.99"  
 // 	  @ nLin,191 PSAY vlr_t_i_a  Picture "@E 999,999,999.99" 
  	    nLin := nLin + 1     
	  @ nLin,000 PSay replicate("_",220)  
	    nLin := nLin + 1
      qtdanft := qtdanft + qtdanf
//////////////////////////////////////////////////////////////////////////////////////////////////
       valor_tot :=(valor_tot + vlr_tot) 
       valor_tot_iss :=(valor_tot_iss + vlr_tot_iss)
 //      valor_t_i_a  := (valor_t_i_a + vlr_t_i_a)
	  @ nLin,000 PSay replicate("_",220) // linhas de totais parcial
	    nLin := nLin + 1	
	  
  	  @ nLin,003 PSAY "Total Qtda "
	  @ nlin,015 PSAY qtdanft  Picture "@E 999.999" 
	  @ nLin,060 PSAY "Total Geral ---> " 
	  @ nLin,177 PSAY valor_tot  Picture "@E 999,999,999.99" 
  	  @ nLin,192 PSAY valor_tot_iss  Picture "@E 999,999,999.99" 
 // 	  @ nLin,191 PSAY valor_t_i_a  Picture "@E 999,999,999.99" 
       nLin := nLin + 1     
	  @ nLin,000 PSay replicate("_",220)     
/////////////////////////////////////gera excel ////////////////////////////////////////////////////
conexcel := 2
excel87()	  
/////////////////////////////////////conferencia automatica ////////////////////////////////////////
//  gerardo consulta pelo e2 ordenado por valor do iss e o cgc e gerado consulta pala szb na mesma//
//  ordenacao , construido loop de confornto entre as 2 consultas buscando diferencas             //
////////////////////////////////////////////////////////////////////////////////////////////////////  

//////////////////////////////////////consulta szb X se2////////////////////////////////////////////

cQuery := " SELECT e2_fornece, e2_iss  , E2_NUM, E2_FILIAL, E2_BAIXA ,a2_nome ,  SZB.ZB_titulo , zb_fornece, zb_emissao  
cQuery += " FROM "+ RetSqlName("Sa2")+" Sa2 ," + RetSqlName("SE2")+" SE2 "
cQuery += " FULL OUTER JOIN "+ RetSQLName("SZB")+" SZB  ON "
cQuery += " zb_titulo   = e2_num "
cQuery += " AND   E2_PREFIXO  = ZB_PREFIXO "
cQuery += " AND   E2_PARCELA  = ZB_PARCELA "
cQuery += " AND   ZB_TIPO     = E2_TIPO "
cQuery += " AND   SZB.ZB_FILIAL = '"+xFilial("SZB")+"' " 
cQuery += " AND   SZB.D_E_L_E_T_ = ' '    "

cQuery += " WHERE SE2.E2_FILIAL = '"+xFilial("SE2")+"' " 
cQuery += " And Sa2.a2_FILIAL = '"+xFilial("Sa2")+"' " 
cQuery += " And SE2.D_E_L_E_T_ <> '*'   " 
cQuery += " And Sa2.D_E_L_E_T_ <> '*'   "
if mv_par03  == 1
	 cQuery += " AND   e2_emissao BETWEEN '" + dTos(Mv_Par01) + "' AND '" + dTos(Mv_Par02) + "' " 
 else	  
    cQuery += " AND   e2_baixa BETWEEN '" + dTos(Mv_Par01) + "' AND '" + dTos(Mv_Par02) + "' " 
 endif    
cQuery += " And E2_SALDO    = 0           "
cQuery += " And E2_ORIGEM = 'PLSMPAG'     "
cQuery += " And E2_ISS > 0                " 
cQuery += " And E2_fornece = a2_cod       "
cQuery += " ORDER BY E2_ISS,e2_fornece    "

If Select("TMP") > 0
	dbSelectArea("TMP")
	dbclosearea()
Endif                

TCQuery cQuery Alias "TMP" New
dbSelectArea("TMP")
tmp->(dbGoTop())               

////////////////////////////////////////////////////////////////////////////////////////////////////

While !EOF()

 if  empty( tmp->ZB_titulo )
     if fim = "nao"
        Cabec1         := "Cod.Forn. Nome Fornecedor                            Valor Iss       Num. NF   Dt Baixa"
        Cabec2         := " "
        titulo         := " critica de pagamentos de Iss sem Notas Fiscais "
        nLin           := 80 															
        fim := "sim"
     endif   
     If nLin > 65 // Salto de Página. Neste caso o formulario tem 69 linhas...
	     nLin := Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
	     nLin++
     Endif
                                                
      @ nLin,000 PSAY (TMP->e2_fornece) 
	  @ nLin,010 PSAY SUBSTR (TMP->A2_NOME,1,40)      
	  @ nLin,052 PSAY (TMP->E2_ISS) Picture "@E 999.999" 
	  @ nLin,070 PSAY (TMP->E2_NUM)
      @ nLin,080 PSAY  stod(TMP->E2_baixa)  
 	    nLin++
 endif
    	dbSkip()
 
EndDo                          
////////////////////////////////////////////////////////////////////////////////////////////////////
SET DEVICE TO SCREEN

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Se impressao em disco, chama o gerenciador de impressao...          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If aReturn[5]==1
	dbCommitAll()
	SET PRINTER TO
	OurSpool(wnrel)
Endif

MS_FLUSH()

Return       

************************
Static Function  excel87()
************************   
local Dtarrec  	:= dtos(mv_par11)
Local lprimer 	:= .F. 
local cEmpresa 	:= iif (SubStr(cNumEmp,1,2) = "01","Cab", "Int")
Local cEOL	  	:= CHR(13)+CHR(10) 

Local I 		:= 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
Local nCont1	:= 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

If  mv_par05  == 1 

    If conexcel == 1 .and.  mv_par06  == 1 
       DbSelectArea("TMP") 
       tmp->(dbGoTop())
	   Do While TMP->(!Eof())     					
          Valor_iss := noround (((tmp->zb_vtotal * tmp->BAU_YALISS) / 100),2)                                                                                                                                          
          aAdd(aArray1,{"05", substr (TMP->ZB_EMISSAO,7,8)+ substr (TMP->ZB_EMISSAO,5,2) + substr (TMP->ZB_EMISSAO,1,4),"01", "   ",;
                      Alltrim(StrZero(val(TMP->ZB_NOTA),8)), "2", substr(TMP->A2_CGC,1,14),  Alltrim(StrZero(TMP->ZB_vtotal*100,14)),;
                      Alltrim(StrZero(TMP->ZB_vtotal*100,14)), Alltrim(StrZero(Valor_iss*100,14)), substr(Dtarrec,7,2)+substr(Dtarrec,5,2)+substr(Dtarrec,1,4)})
          TMP->(DbSkip())                   
       EndDo                                                                                                                            
    EndIf                
    If conexcel == 2 .and. mv_par07  == 1     
           DbSelectArea("TMP") 
           tmp->(dbGoTop())
	       Do While TMP->(!Eof()) 
               vlbrt :=  (TMP->E2_VALOR + (TMP->E2_ISS + TMP->E2_IRRF + TMP->E2_SEST + TMP->E2_VRETCOF + TMP->E2_VRETPIS + TMP->E2_VRETCSL + TMP->E2_INSS)) 
                                                                                                                                  
              aAdd(aArray1,{"05", substr (TMP->e2_EMISSAO,7,8)+ substr (TMP->e2_EMISSAO,5,2) + substr (TMP->e2_EMISSAO,1,4),"01", "   ",;
                Alltrim(StrZero(val(e2_num),8)), "2", substr(TMP->A2_CGC,1,14),  Alltrim(StrZero(vlbrt*100,14)),;
                Alltrim(StrZero(vlbrt*100,14)), Alltrim(StrZero(tmp->e2_iss*100,14)), substr(Dtarrec,7,2)+substr(Dtarrec,5,2)+substr(Dtarrec,1,4)})
              TMP->(DbSkip())                   
           EndDo 
    EndIF                                
    If (conexcel == 2 .and. (mv_par07  == 1 .or. mv_par06  == 1))
       cNomeArq := "C:\Dief\" + "DIEF_"+cEmpresa + StrZero(mv_par09,4) + StrZero(mv_par10,2)                                                                                            
       cNomeArq += ".TXT"
       //nReg += len(aArray1)

       If U_Cria_TXT(cNomeArq)
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Impressao das linhas do arquivo...        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
    // cArray := aArray1[len]
    
           cElemImp :=  aArray1[1][1] + aArray1[1][2] + aArray1[1][3] + aArray1[1][4]
           cLin := Space(1)+cEOL
		   if !(U_GrLinha_TXT(cElemImp,cLin))
		      MsgAlert("ATENÇÃO! NÃO FOI POSSÍVEL GRAVAR CORRETAMENTE O CABEÇALHO! OPERAÇÃO ABORTADA!")
		      Return
	       EndIf
    
	       For nCont1 := 2 to Len(aArray1) 
	        
               For I  := 1 To 11		
                  If I = 1 
      		         cElemImp :=  aArray1[nCont1][I] 
      		      else                                
      		         cElemImp :=  cElemImp + aArray1[nCont1][I]
      		      EndIf   
      	       Next 	              
      		   cLin := Space(1)+cEOL
		       If !(U_GrLinha_TXT(cElemImp,cLin))
			       MsgAlert("ATENÇÃO! NÃO FOI POSSÍVEL GRAVAR CORRETAMENTE O CABEÇALHO! OPERAÇÃO ABORTADA!")
			       Return
		       Endif
		
           Next
	   
	       cElemImp := "11" + Alltrim(StrZero(1+(len(aArray1)) ,8))
	       U_GrLinha_TXT(cElemImp,cLin)  
	    
	       U_Fecha_TXT()
	
       Endif
    EndIf
EndIf


if mv_par03  == 1
   aArray := { {"Nome ",;
                "Endereco ",;
                "Bairro "   ,;
                "Estado " ,;
                "Municipio",;
                "CEP ",;
                "CGC                              ",;
                "Insc. Munic",;
                "Emissao ",;
                "Num. Nf. ",;
                "Val Nf " ,;
                "Valor Iss"}  }   
                
	DbSelectArea("TMP") 
	tmp->(dbGoTop())
	Do While TMP->(!Eof())  
	If conexcel = 1
	   Valor_iss := noround (((tmp->zb_vtotal * tmp->BAU_YALISS) / 100),2) 
	Else
      Valor_iss :=TMP->E2_ISS
    Endif   	   
    If conexcel = 1 
       aAdd(aArray,{SUBSTR(TMP->A2_NOME,1,40),;
                 SUBSTR(TMP->A2_END,1,45),;
                 SUBSTR(TMP->A2_BAIRRO,1,20),;
                 TMP->A2_EST ,;
                 SUBSTR(TMP->A2_MUN,1,20),;
                 TMP->A2_CEP,;
                 substr(TMP->A2_CGC,1,20),; 
                 TMP->A2_INSCRM,;
                 stod(TMP->ZB_EMISSAO),;
                 (TMP->ZB_NOTA),;       
                 (TMP->ZB_vtotal),;
                 valor_ISS})
   Else            
      aAdd(aArray,{SUBSTR(TMP->A2_NOME,1,40),;
                 SUBSTR(TMP->A2_END,1,45),;
                 SUBSTR(TMP->A2_BAIRRO,1,20),;
                 TMP->A2_EST ,;
                 SUBSTR(TMP->A2_MUN,1,20),;
                 TMP->A2_CEP,;
                 substr(TMP->A2_CGC,1,20),; 
                 TMP->A2_INSCRM,;
                 stod(TMP->e2_EMISSAO),;
                 (TMP->e2_num),;    
                 (TMP->e2_valor),;  
                 valor_ISS})
   EndIf                               
                                 
/////////////////////////////////
                 
	TMP->(DbSkip())                   

EndDo                               
DlgToExcel({{"ARRAY","","",aArray}})  

endif


Return()



/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ValidPerg º Autor ³ Jose Carlos Noronhaº Data ³ 01/08/07    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Parametros para selecao dos titulos do PLS                 º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³                                                            º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ValidPerg()

Local aAreaAtu := GetArea()
Local aRegs    := {}
Local i,j

DbSelectArea("SX1")
dbSetOrder(1)
cPerg := PADR(cPerg,6)

aAdd(aRegs,{cPerg,"01","Data inicial :","","","mv_ch1","D",10,0,0,"G","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","","US2"    , "" , "" , "", "", "" })
aAdd(aRegs,{cPerg,"02","Data Final   :","","","mv_ch2","D",10,0,0,"G","","mv_par02","","","","","","","","","","","","","","","","","","","","","","","","","US2"    , "" , "" , "", "", "" })
aAdd(aRegs,{cPerg,"03","Gera Excel  ?:","","","mv_ch3","C",01,0,0,"C","","mv_par03","Sim","","","","","NAO","","","","","","","","","","","","","","","","","","","","","","","","", "" , "" , "", "", "" })
aAdd(aRegs,{cPerg,"04","Pela Data   ?:","","","mv_ch4","C",01,0,0,"C","","mv_par04","Emissao","","","","","Pagamento","","","","","","","","","","","","","","","","","","","","","","","","", "" , "" , "", "", "" })
////////                                                                                                                                                                                                                           
aAdd(aRegs,{cPerg,"05","Gera TXT    ?:","","","mv_ch5","C",01,0,0,"C","","mv_par05","Sim"    ,"","","","","Não"      ,"","","","","","","","","","","","","","","","","","","","","","","","", "" , "" , "", "", "" })
aAdd(aRegs,{cPerg,"06","Gera Importação RDA ?","","","mv_ch5","C",01,0,0,"C","","mv_par06","Sim"    ,"","","","","Não"      ,"","","","","","","","","","","","","","","","","","","","","","","","", "" , "" , "", "", "" })
aAdd(aRegs,{cPerg,"07","Gera Importação Fin ?","","","mv_ch5","C",01,0,0,"C","","mv_par07","Sim"    ,"","","","","Não"      ,"","","","","","","","","","","","","","","","","","","","","","","","", "" , "" , "", "", "" })

aAdd(aRegs,{cPerg,"08","Insc. Municipal :","","","mv_ch6","N",8,0,0,"G","","mv_par08",""       ,"","","","",""         ,"","","","","","","","","","","","","","","","","","","","","","","","", "" , "" , "", "", "" })
aAdd(aRegs,{cPerg,"09","Ano Competencia :","","","mv_ch7","N",04,0,0,"G","","mv_par09",""       ,"","","","",""         ,"","","","","","","","","","","","","","","","","","","","","","","","", "" , "" , "", "", "" })
aAdd(aRegs,{cPerg,"10","Mes Competencia :","","","mv_ch8","N",02,0,0,"G","","mv_par10",""       ,"","","","",""         ,"","","","","","","","","","","","","","","","","","","","","","","","", "" , "" , "", "", "" })
aAdd(aRegs,{cPerg,"11","Data da Retenção:","","","mv_ch9","D",10,0,0,"G","","mv_par11","","","","","","","","","","","","","","","","","","","","","","","","","US2"    , "" , "" , "", "", "" })
////////

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
 

