#Define CRLF Chr(13)+Chr(10)
#INCLUDE "rwmake.ch"
#INCLUDE "topconn.ch"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ CABR089  º Autor ³ Altamiro Affonso   º Data ³  20/08/08   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Relatorio de Conferencia de Notas Digitadas para RDA       º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP6 IDE                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function CABR089

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Local cDesc1         := "Este programa tem como objetivo imprimir relatorio "
Local cDesc2         := "de RDA com entregas de N.Fiscais atrasadas, sendo ."
Local cDesc3         := "levadas ao controle da direcao pela alcada de tempo"
Local cPict          := ""
Local titulo         := "Notas Fiscais entregues em atraso , retido pagto  "
Local nLin           := 80 
LOCAL pMoeda2	     := "@E 999,999,999.99"																									     // 10/09/2008 - ALTAMIRO
Local Cabec1         := "                                                               T I T U L O                                                                                                                D  a  t  a          "
Local Cabec2         := "Cod Form Cod Rda  Nome                            Compet. N.Titulo   Emissao   Vencimento.    Valor Bruto       ISS       IRRF     Cofins        PIS       CSLL   Valor Liquido  Digitacao Liberacao   Pagto     Status    banco"
//                       1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//                       0        1         2         3         4         5         6         7         8         9         0         1         2         3         4         5         6         7         8         9         0         1         2
//                       XXXXXX    XXXXXX  XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX  XX/XXXX XXXXXXXX 99/99/9999 99/99/9999 999.999.999,99 999.999,99 999.999,99 999.999,99 999.999,99 999.999,99 999.999.999,99 99/99/9999 99/99/9999 99/99/9999    X  
//                          1                           2                     3          4          5            6              7        8         9
////////////////////////////////////CAMPOS  DO RELATORIO (COLUNAS DA TABELA SE2 - CONTAS A PAGAR)/////////////////////////////////////////////////////////////////////////////////              
//                          1 = E2_FORNECE   -   codigo do  fornecedor
//                          2 = E2_NOMFOR    -   nome   do  fornecedor 
//                          3 = E2_NUM		   -   numero do  titulos  
//                          4 = E2_EMISSAO   -   data   de  emnissao do titulo 
//                          5 = E2_VENCREA   -   data   do  vencimento do titulo 
//                          6 = E2_VALOR     -   valor  do  titulos
//                          7 = E2_YDTDGNF   -   data   da  digitacao da nf
//                          8 = E2_DATALIB   -   data   da  liberacao
//                          9 = E2-YLIBPLS   -   status de  liberacao              
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Local Cabec2         := ""
Local imprime        := .T.
Local aOrd           := {}
Private lEnd         := .F.
Private lAbortPrint  := .F.
Private CbTxt        := ""
Private limite       := 221
Private tamanho      := "G"
Private nomeprog     := "CABR089"
Private nTipo        := 15
Private aReturn      := { "Zebrado", 1, "Administracao", 1, 2, 1, "", 1}
Private nLastKey     := 0
Private cbtxt        := Space(10)
Private cbcont       := 00
Private CONTFL       := 01
Private m_pag        := 01                         
Private wnrel        := "CABR089"
Private cString      := "SE2"
Private cPerg        := "CABS89"   
                                                                                                                                                                                                                                                                             
private aCabec1      := {"Cod Form","Cod Rda","Nome","Compet.", "N.Titulo","Emissao", "Vencimento" ,"Valor Bruto","ISS","IRRF","Cofins","PIS","CSLL","Valor Liquido","Emissao" ,"Liberacao","municipio","Lib.Pgto", "Pagto","Status", "Prefix Filial","Pref.Tit","Digitacao",;
	    	   	     "ddd" , "tel" , "fax" , "contato" , "status","GRPPAGTO " , "BANCO"}   
private aDados       := {}
private pMoeda2	     := "@E 999,999,999.99"	     
private cFornece     := ''                  
private cpreffil     := ''
dbSelectArea("SE2")
dbSetOrder(1)

ValidPerg(cPerg)
If Pergunte(cPerg,.T.) = .F.
	Return
Endif  
// so trata filial igual a da produção - ordem marcia em 27/11/2017 - altamiro 
 mv_par18 := 2
private nGeraExcel  := mv_par15
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
local cVlIss  := 0.00   
local cVlIrrf := 0.00 
local cVlSest := 0.00 
local cVlCof  := 0.00 
local cVlPis  := 0.00    
local cVlCls  := 0.00 
local cVlInss := 0.00 
local cVlTit  := 0.00  
Local nOrdem
Local cQuery := ' '
dbSelectArea(cString)
dbSetOrder(1)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ SETREGUA -> Indica quantos registros serao processados para a regua ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetRegua(RecCount())                    
 
cQuery := " SELECT SE2.E2_NUM, SE2.E2_FORNECE, SE2.E2_NOMFOR, SE2.E2_VALOR, SE2.E2_YDTDGNF, SE2.E2_EMISSAO , BAU.BAU_CODIGO , SE2.E2_BAIXA ,SE2.E2_prefixo,  "
cQuery += CRLF+ " SE2.E2_VENCREA , SE2.E2_YDTLBPG, SE2.E2_YLIBPLS , SA2.A2_YBLQPLS , BAU.BAU_CODSA2 , SE2.E2_ANOBASE , SE2.E2_MESBASE , SA2.A2_NOME , nvl(BID_DESCRI,'Erro Munic') BID_DESCRI ,"
cQuery += CRLF+ " SE2.E2_ISS     , SE2.E2_IRRF   , SE2.E2_COFINS  , SE2.E2_PIS     , SE2.E2_CSLL    , SE2.E2_INSS , E2_VRETCOF ,E2_VRETPIS, E2_VRETCSL , E2_SEST, SE2.E2_FILIAL  , se2.e2_pllote , "
cQuery += CRLF+ " Nvl(zb_emissao,' ') zb_emissao ,  Nvl(ZB_DTDIGIT,' ') ZB_DTDIGIT , "

cQuery += CRLF+ " Nvl(BB8_DDD,' ') BB8_DDD, Nvl(BB8_TEL,' ')BB8_TEL , Nvl(BB8_FAX,' ') BB8_FAX  , Nvl(bb8_contat,' ')bb8_contat ,"  
// zb_obs  ,
cQuery += CRLF+ " BAU.BAU_GRPPAG ||' - ' || NVL(B16_DESCRI, 'sem grupo' ) grpdesc , A2_BANCO BANCO "

//cQuery += " a2_ddd , a2_tel , a2_fax , a2_contato , a2_email , a2_hpage, bau_tel , bau_fax  , bau_ycel , bau_email  " 
cQuery += CRLF+ " FROM " + RetSqlName("SE2")+" SE2, "+ RetSQLName("BAU")+" BAU, " + RetSQLName("SA2")+" SA2 ,"  + RetSQLName("BID")+" BID ," + RetSQLName("SZB")+" SZB ," + RetSQLName("BB8")+" BB8 ,  "
cQuery += CRLF+ " "+ RetSQLName("B16")+" B16 ,  (select min(R_E_C_N_O_) recno , BB8_CODIGO cod_bb8 from bb8010 bb8 where bb8_filial = ' ' and d_E_L_E_T_ = ' '  group by  BB8_CODIGO order by 2) tabbb8 "

cQuery += CRLF+ " WHERE "
if mv_par18 == 2
   cQuery += CRLF+ "SE2.E2_FILIAL = '"+xFilial("SE2")+"' and " 
endif 
cQuery += CRLF+ "  E2_TIPO <> 'PA '" 

cQuery += CRLF+ " AND   E2_FORNECE  BETWEEN '" + Mv_Par01 + "' AND '" + Mv_Par02 + "'"
cQuery += CRLF+ " AND   E2_EMISSAO  BETWEEN '" + dTos(Mv_Par03) + "' AND '" + dTos(Mv_Par04) + "' " 

cQuery += CRLF+ " AND   SA2.A2_FILIAL = '"+xFilial("SA2")+"' "  
cQuery += CRLF+ " AND   (A2_TIPO = 'J' or A2_TIPO = 'j') AND A2_YBLQPLS <> 'N' "                
cQuery += CRLF+ " AND   SE2.E2_FORNECE = SA2.A2_COD " 

cQuery += CRLF+ " AND   BAU.BAU_FILIAL = '"+xFilial("BAU")+"' " 
cQuery += CRLF+ " AND   SE2.E2_FORNECE = BAU.BAU_CODSA2 " 
cQuery += CRLF+ " AND   BAU.BAU_CODIGO BETWEEN '"+mv_par08+"' AND '"+mv_par09+"' " 
                                                          
cQuery += CRLF+ " AND   BB8.BB8_FILIAL(+) = '"+xFilial("BR8")+"' " 
cQuery += CRLF+ " AND   tabbb8.cod_bb8(+)  = BAU.BAU_CODIGO " 
cQuery += CRLF+ " AND   tabbb8.recno = bb8.R_E_C_N_O_(+) "

cQuery += CRLF+ " AND   BID.BID_FILIAL(+) = '"+xFilial("BID")+"' " 
cQuery += CRLF+ " AND   BID.BID_CODMUN(+) = BAU.BAU_MUN " 
if !empty (mv_par14)             
   cQuery += CRLF+ " AND   BAU.BAU_GRPPAG in ("+mv_par14+") "
endIf                                                      
cQuery += CRLF+ " AND   B16.B16_FILIAL(+) = '"+xFilial("B16")+"' "
cQuery += CRLF+ " AND   BAU.BAU_GRPPAG = B16_CODIGO(+) "  

if dTos(MV_par20) != "        "   
   cQuery += CRLF+ " AND ZB_DTDIGIT (+)>=  '"+dTos(MV_par20)+"' and ZB_DTDIGIT(+) <= '"+dTos(MV_par21)+"' "   
EndIf 
cQuery += CRLF+ " AND   SE2.D_E_L_E_T_ = ' ' "
cQuery += CRLF+ " AND   BAU.D_E_L_E_T_ = ' ' "     
cQuery += CRLF+ " AND   B16.D_E_L_E_T_(+) = ' ' " 
cQuery += CRLF+ " AND   BB8.D_E_L_E_T_(+) = ' ' " 
cQuery += CRLF+ " AND   SA2.D_E_L_E_T_ = ' ' "    
cQuery += CRLF+ " AND   BID.D_E_L_E_T_(+) = ' ' "  
//cQuery += " AND   SZB.D_E_L_E_T_ = ' ' "   
cQuery += CRLF+ " AND   E2_ANOBASE || E2_MESBASE  BETWEEN '" + SUBSTR( MV_PAR10,4,4) + SUBSTR(MV_PAR10,1,2) + "'"    
cQuery += CRLF+ " AND   '" + SUBSTR( MV_PAR11,4,4) + SUBSTR(MV_PAR11,1,2) + "'"  
                
IF mv_par07 != 5  
   IF mv_par07 == 1              
     cQuery += CRLF+ " AND   (E2_YLIBPLS = 'S'" + " OR A2_YBLQPLS <> 'S' )"  
   elseIF mv_par07 == 2                        
      cQuery += CRLF+ " AND   E2_YLIBPLS = 'N'  " + " AND A2_YBLQPLS = 'S' "  
   elseIF mv_par07 == 3                        
      cQuery += CRLF+ " AND   E2_YLIBPLS = 'L' " + " AND A2_YBLQPLS = 'S' "     
      if dTos(Mv_Par05) != "        " 
         cQuery += CRLF+ " AND   E2_YDTDGNF BETWEEN '" + dTos(Mv_Par05) + "' AND '" + dTos(Mv_Par06) + "' "  
      endif
   elseIF mv_par07 == 4                       
      cQuery += CRLF+ " AND   E2_YLIBPLS = 'M'"  
      if dTos(Mv_Par05) != "        " 
         cQuery += CRLF+ " AND   E2_YDTLBPG BETWEEN '" + dTos(Mv_Par05) + "' AND '" + dTos(Mv_Par06) + "' "        
      endif   
   endif 
endif             
If mv_par13 == 1 
 //  cQuery += "   AND E2_SALDO = E2_VALOR AND E2_BAIXA = ' '"  linha abaixo so para atender solicitação contabil   
 cQuery += CRLF+ "   AND E2_SALDO > 0 " 
ElseIf mv_par13 == 2 
   cQuery += CRLF+ "   AND E2_SALDO <> E2_VALOR AND E2_saldo <> 0 "  
ElseIf mv_par13 == 3 
   cQuery += CRLF+ "   AND E2_SALDO <> E2_VALOR AND E2_saldo = 0 "  
EndIf   
If mv_par16 == 3 
   cQuery += CRLF+ "and exists(select * from  , "+ RetSQLName("SE2")+" SE22 where SE22.E2_FILIAL = '"+xFilial("SE2")+"' AND SE22.E2_TIPO =  'PA ' AND SE22.E2_FORNECE = SE2.E2_FORNECE and SE22.D_E_L_E_T_ = ' ' AND SE22.E2_SALDO > 0 )"  
EndIF 
  cQuery += CRLF+ " and e2_codrda  = ZB_CODRDA  (+) and e2_prefixo = ZB_PREFIXO (+) and e2_num = ZB_TITULO  (+) 
  cQuery += CRLF+ " and e2_tipo    = ZB_TIPO    (+) and e2_fornece = ZB_FORNECE (+) and szb.d_E_L_E_T_(+) = ' '  "
if empty(mv_par17) 
   cQuery += CRLF+ " ORDER BY BID_DESCRI ,SE2.E2_prefixo ,E2_FORNECE, E2_EMISSAO "
else 
cQuery += CRLF+ " ORDER BY " + mv_par17
EndIf
If Select("TMP") > 0
	dbSelectArea("TMP")
	dbclosearea()
Endif                
                                            

TCQuery cQuery Alias "TMP" New
dbSelectArea("TMP")
tmp->(dbGoTop())
valor_tot := 0.00 
cvlbrt    := 0.00 
IF ((mv_par07 = 2) .OR. (mv_par07 = 3))
   Cabec2         := "Cod Form Cod Rda  Nome                            Compet. N.Titulo   Emissao   Vencimento.    Valor Bruto       ISS       IRRF     Cofins        PIS       CSLL   Valor Liquido  Digitacao  Municipio            Status"
EndIf                                                                                                                                                                                                         
                // cabecalho inicial imprime tendo ou nao linhas de detalhe
	If nLin > 65 // Salto de Página. Neste caso o formulario tem 55 linhas...
		nLin := Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
		nLin++
	Endif
While TMP->( !Eof() )
	If nLin > 65 // Salto de Página. Neste caso o formulario tem 55 linhas...
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
	   
	  @ nLin,060 PSAY "Total Parcial ---> " 
	  	@ nLin,091 PSAY valor_tot  picture "@E 999,999,999.99"
		@ nLin,106 PSAY cVlIss     Picture "@E 999,999.99"
		@ nLin,116 PSAY cVlIrrf    Picture "@E 999,999.99"
		@ nLin,128 PSAY cVlCof     Picture "@E 999,999.99"
		@ nLin,139 PSAY cVlPis     Picture "@E 999,999.99"
		@ nLin,150 PSAY cVlCls     Picture "@E 999,999.99"
		@ nLin,161 PSAY cVlTit     Picture "@E 999,999,999.99"
       nLin := nLin + 1     
	  @ nLin,000 PSay replicate("_",220)  
	    nLin := nLin + 1
	Endif  
	If nLin > 70 // Salto de Página. Neste caso o formulario tem 55 linhas...
		nLin := Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
		nLin++
	Endif 
	if empty(cFornece) 
	   cFornece := tmp->e2_fornece 
    EndIf
	if ( empty(alltrim(MV_PAR12)) ) .or. (alltrim(upper(MV_PAR12)) != e2_prefixo)                                                           
        @ nLin,001 PSAY TMP->E2_FORNECE                                                         	
		@ nLin,011 PSAY TMP->BAU_CODIGO
		@ nLin,019 PSAY SUBSTR (TMP->A2_NOME,1,30) 
		if mv_par19  = 1
       	   @ nlin,050 PSAY TMP->E2_MESBASE +"/"+TMP->E2_ANOBASE
       	else   
  		   @ nlin,050 PSAY substr (TMP->e2_pllote,1,4)+"/"+substr (TMP->e2_pllote,5,6)	    
  		EndIf   
		@ nLin,058 PSAY TMP->E2_NUM        
	
		@ nLin,069 PSAY stod(TMP->zb_emissao)     
 
		@ nLin,080 PSAY stod(TMP->E2_VENCREA)     
     
    	 cvlbrt :=  (TMP->E2_VALOR + (TMP->E2_ISS + TMP->E2_IRRF + TMP->E2_SEST + TMP->E2_VRETCOF + TMP->E2_VRETPIS + TMP->E2_VRETCSL + TMP->E2_INSS)) 
	     
	     
		@ nLin,091 PSAY cvlbrt          Picture "@E 999,999,999.99"
		@ nLin,106 PSAY TMP->E2_iss     Picture "@E 99,999.99"
		@ nLin,117 PSAY TMP->E2_irrf    Picture "@E 99,999.99"
		@ nLin,128 PSAY TMP->E2_vretcof Picture "@E 99,999.99"
		@ nLin,139 PSAY TMP->E2_vretpis Picture "@E 99,999.99"
		@ nLin,150 PSAY TMP->E2_vretcsl Picture "@E 99,999.99"

		@ nLin,161 PSAY TMP->E2_VALOR  Picture "@E 999,999,999.99"
		
		@ nLin,176 PSAY stod(TMP->E2_YDTDGNF)
        IF ((mv_par07 = 2) .OR. (mv_par07 = 3))		
        	@ nLin,187 PSAY substr(TMP->BID_DESCRI,1,20)        
        Else
	    	@ nLin,187 PSAY stod(TMP->E2_YDTLBPG) 
	    	@ nLin,198 PSAY stod(TMP->E2_BAIXA)  
	    EndIf	
		@ nLin,212 PSAY TMP->E2_YLIBPLS    

		if  mv_par18 != 2           
		   If mv_par18 == 3 
              @ nLin,215 PSAY TMP->E2_PREFIXO+TMP->E2_filial 
                cpreffil :=TMP->E2_PREFIXO+TMP->E2_filial 
           elseif TMP->E2_filial != '01' 
              @ nLin,215 PSAY TMP->E2_PREFIXO+"*"       
                cpreffil :=TMP->E2_PREFIXO+"*" 
           else                                  
              @ nLin,215 PSAY TMP->E2_PREFIXO  
                cpreffil :=TMP->E2_PREFIXO 
           EndIf   
        else                            
           @ nLin,215 PSAY TMP->E2_PREFIXO
             cpreffil :=TMP->E2_PREFIXO
        EndIf    
		 		
		 valor_tot += cVlBrt 
	     cVlIss  += TMP->E2_ISS   
	     cVlIrrf += TMP->E2_IRRF
	     cVlSest += TMP->E2_SEST
	     cVlCof  += TMP->E2_VRETCOF
	     cVlPis  += TMP->E2_VRETPIS   
	     cVlCls  += TMP->E2_VRETCSL
	     cVlInss += TMP->E2_INSS
	     cVlTit  += TMP->E2_VALOR
	     
		nLin := nLin + 1 // Avanca a linha de impressao  
	 endif		
	   aaDD(aDados,{TMP->E2_FORNECE ,;      
	                TMP->BAU_CODIGO ,;
                    TMP->A2_NOME ,;
                    TMP->E2_MESBASE +"/"+TMP->E2_ANOBASE ,;
	                TMP->E2_NUM ,;       
	           stod(TMP->E2_EMISSAO),;     
               stod(TMP->E2_VENCREA),;     
	      Transform(cvlbrt ,  "@E 999,999,999.99"	),;
		  Transform(TMP->E2_iss,  "@E 999,999,999.99"	),; 
		  Transform(TMP->E2_irrf,  "@E 999,999,999.99"	),; 
		  Transform(TMP->E2_vretcof,  "@E 999,999,999.99"	),;
		  Transform(TMP->E2_vretpis,  "@E 999,999,999.99"	),;
		  Transform(TMP->E2_vretcsl,  "@E 999,999,999.99"	),;
		  Transform(TMP->E2_VALOR,  "@E 999,999,999.99"	),;
		       stod(tmp->zb_emissao),;
		       stod(TMP->E2_YDTDGNF),;
                    TMP->BID_DESCRI  ,;     
               stod(TMP->E2_YDTLBPG),; 
	    	   stod(TMP->E2_BAIXA)  ,;
	    	   	    TMP->E2_YLIBPLS ,;
	    	   	    cpreffil ,;
	    	   	    TMP->E2_prefixo ,;
	    	   	    stod(tmp->ZB_DTDIGIT),; 
	    	   	    TMP->BB8_DDD, TMP->BB8_TEL , TMP->BB8_FAX , tmp->bb8_contat ,  TMP->grpdesc , TMP->BANCO})   
	    	   	                     
   tmp->(dbSkip())   // Avanca o ponteiro do registro no arquivo
	if cFornece != tmp->e2_fornece .AND. mv_par16 != 1  

       cQuery1 := "select E2_PREFIXO , E2_NUM , E2_TIPO , E2_EMISSAO , E2_HIST , E2_VALOR "
       cQuery1 += " FROM " + RetSqlName("SE2")+" SE2 "
       cQuery1 += " WHERE SE2.E2_FILIAL = '"+xFilial("SE2")+"' and d_E_L_E_T_ = ' ' and e2_tipo = 'PA' AND E2_SALDO > 0 "
       cQuery1 += " AND E2_FORNECE = '"+ cFORNECE +"'" 

       If Select("TMP1") > 0
	      dbSelectArea("TMP1")
	      dbclosearea()
       Endif                

       TCQuery cQuery1 Alias "TMP1" New
       dbSelectArea("TMP1")
       tmp1->(dbGoTop())

       	While TMP1->( !Eof() )           
              @ nLin,060 PSAY " PA ---> " 
              @ nLin,070 PSAY TMP1->E2_PREFIXO +" "+ TMP1->E2_NUM +" "+ TMP1->E2_TIPO 
              @ nLin,090 PSAY SUBSTR(TMP1->E2_EMISSAO,7,2)+"/"+SUBSTR(TMP1->E2_EMISSAO,5,2)+"/"+SUBSTR(TMP1->E2_EMISSAO,1,4)
	  	      @ nLin,102 PSAY TMP1->E2_HIST
              @ nLin,161 PSAY TMP1->E2_VALOR     Picture "@E 999,999,999.99"
              nLin := nLin + 1     
              tmp1->(dbSkip())   
	   EndDo                     
	   cFornece := tmp->e2_fornece
	endIf
EndDo                                              

	  @ nLin,000 PSay replicate("_",220) // linhas de totais parcial
	    nLin := nLin + 1	
	  @ nLin,060 PSAY "Total Geral ---> "                        
	  	@ nLin,091 PSAY valor_tot  picture "@E 999,999,999.99"
		@ nLin,106 PSAY cVlIss     Picture "@E 999,999.99"
		@ nLin,116 PSAY cVlIrrf    Picture "@E 999,999.99"
		@ nLin,128 PSAY cVlCof     Picture "@E 999,999.99"
		@ nLin,139 PSAY cVlPis     Picture "@E 999,999.99"
		@ nLin,150 PSAY cVlCls     Picture "@E 999,999.99"
		@ nLin,161 PSAY cVlTit     Picture "@E 999,999,999.99"
       nLin := nLin + 1     
	  @ nLin,000 PSay replicate("_",220)      
 if nGeraExcel = 1	  
   DlgToExcel({{"ARRAY","Relação dos Titulos " ,aCabec1,aDados}})
 EndIf  
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

MS_FLUSH()

Return


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

aAdd(aRegs,{cPerg,"01","Do  Fornecedor    ?","","","mv_ch1","C",06,0,0,"G","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","","BAUNFE" , "" , "" , "", "", "" })
aAdd(aRegs,{cPerg,"02","Ate Fornecedor    ?","","","mv_ch2","C",06,0,0,"G","","mv_par02","","","","","","","","","","","","","","","","","","","","","","","","","BAUNFE" , "" , "" , "", "", "" })
aAdd(aRegs,{cPerg,"03","Da  Emissao       ?","","","mv_ch3","D",08,0,0,"G","","mv_par03","","","","","","","","","","","","","","","","","","","","","","","","","US2"    , "" , "" , "", "", "" })
aAdd(aRegs,{cPerg,"04","Ate Emissao       ?","","","mv_ch4","D",08,0,0,"G","","mv_par04","","","","","","","","","","","","","","","","","","","","","","","","","US2"    , "" , "" , "", "", "" })
aAdd(aRegs,{cPerg,"05","Da  Liberacao     ?","","","mv_ch5","D",08,0,0,"G","","mv_par05","","","","","","","","","","","","","","","","","","","","","","","","","US2"    , "" , "" , "", "", "" })
aAdd(aRegs,{cPerg,"06","Ate Liberacao     ?","","","mv_ch6","D",08,0,0,"G","","mv_par06","","","","","","","","","","","","","","","","","","","","","","","","","US2"    , "" , "" , "", "", "" })

aAdd(aRegs,{cPerg,"07","Bloqueado         ?","","","mv_ch7","C",01,0,0,"C","","mv_par07","Liberado PLS","","","","","NAO Lib S/NF","","","","","NAO Lib C/NF","","","","","Liberacao Manual","","","","","Todos","","","","","","","","",""       , "" , "" , "", "", "" })

aAdd(aRegs,{cPerg,"08","Do  RDA           ?","","","mv_ch8","C",06,0,0,"G","","mv_par08","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "", "" })
aAdd(aRegs,{cPerg,"09","Ate RDA           ?","","","mv_ch9","C",06,0,0,"G","","mv_par09","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "", "" })
aAdd(aRegs,{cPerg,"10","Da Competencia    ?","","","mv_ch10","C",07,0,0,"G","","mv_par10","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "99/9999", "" }) 
aAdd(aRegs,{cPerg,"11","Ate Competencia   ?","","","mv_ch11","C",07,0,0,"G","","mv_par11","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "99/9999", "" })
aAdd(aRegs,{cPerg,"12","Prefixo Não Listar?","","","mv_ch12","C",07,0,0,"G","","mv_par12","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "", "" })
aAdd(aRegs,{cPerg,"13","Em Relação a Baixa?","","","mv_ch13","C",01,0,0,"C","","mv_par13","Sem Baixa","","","","","Baixados Parcial ","","","","","Baixados Total","","","","","Todos","","","","","","","","","" , "" , "" , "", "", "" })
aAdd(aRegs,{cPerg,"14","Grupo de Pagamento?","","","mv_ch14","C",20,0,0,"G","","mv_par14","","","","","","","","","","","","","","" ,"","","","","","","","","","","BAUNFE" , "" , "" , "", "", "" })
aadd(aRegs,{cPerg,"15","Gerar Excel       ?","","","mv_ch15","N", 1,0,2,"C","","mv_par15","Sim","","","","","Nao","","","","","","" ,"","","","","","","","","","","","","",""})
aadd(aRegs,{cPerg,"16","Listar  Pa's      ?","","","mv_ch16","N", 1,0,2,"C","","mv_par16","Não"      ,"","","","","Todos "           ,"","","","","Só Com Pa's","","","","","","","","","","","","","","",""})
aadd(aRegs,{cPerg,"17","Ordenar Por       ?","","","mv_ch17","C", 20,0,2,"G","","mv_par17","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aadd(aRegs,{cPerg,"18","Listar todas as Filiais      ?","","","mv_ch18","N", 1,0,2,"C","","mv_par18","Sim"      ,"","","","","Nao"              ,"","","","","Mostrar","","","","","","","","","","","","","","",""})
aadd(aRegs,{cPerg,"19","Competencia guia  ?","","","mv_ch19","N", 1,0,2,"C","","mv_par19","Sim"      ,"","","","","Nao"              ,"","","","","Mostrar","","","","","","","","","","","","","","",""})

aAdd(aRegs,{cPerg,"20","Da  Digitação NF  ?","","","mv_ch20","D",08,0,0,"G","","mv_par20","","","","","","","","","","","","","","","","","","","","","","","","","US2"    , "" , "" , "", "", "" })
aAdd(aRegs,{cPerg,"21","Ate Digitação NF  ?","","","mv_ch21","D",08,0,0,"G","","mv_par21","","","","","","","","","","","","","","","","","","","","","","","","","US2"    , "" , "" , "", "", "" })

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

