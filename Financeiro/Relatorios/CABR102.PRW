#INCLUDE "rwmake.ch"
#INCLUDE "topconn.ch"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ CABR102  º Autor ³ Altamiro Affonso   º Data ³  05/10/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Relatorio De possição de clientes - customizado            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP6 IDE                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±fe±±±±±±±±±±±±±±n±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function CABR102

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Local cDesc1         := "Este programa tem como objetivo imprimir relatorio   "
Local cDesc2         := "de titulos a pagar - posição de fornecedores           ."
Local cDesc3         := " "
Local cPict          := " "
Local titulo         := "POSIÇÃO DE FORNECEDORES E TITULOS  "
Local nLin           := 80 			
/*																						     // 04/10/2007 - Noronha 
                         E2_FORNECE	
                         E2_CODRDA	
                         SUBSTR(E2_NOMFOR,1,25)	
                         E2_PREFIXO	
                         E2_NUM	
                         E2_TIPO	
                         E2_EMISSAO	
                         E2_VENCREA	
                         E2_BAIXA	
                         E2_VALOR	
                         E2_ISS	
                         E2_IRRF	
                         E2_VRETPIS	
                         E2_VRETCOF	
                         E2_VRETCSL	
                         E2_INSS	
                         E2_DECRESC	
                         E2_SALDO
*/
Local Cabec1         := "Fornec. RDA    NOME                       Pref. Numero     Tipo  Emissão    Vencimento  Baixa        Vl Titulo        Vl ISS      Vl IRRF       Vl PIS    Vl COFINS      Vl CSLL       Vl INSS      Vl Desc.         Saldo"
//                       1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//                       0        1         2         3         4         5         6         7         8         9         0         1         2         3         4         5         6         7         8         9         0         1         2
                       
Local Cabec2         := "    Dt.Movim.  Vl.Movim.     Tp Mot.Bx Historico     Grupo de Pagamento    Grupo de Prefixo     Num. Bordero    Dt. Agend"
Local aOrd           := {}
Private lEnd         := .F.
Private lAbortPrint  := .F.
Private CbTxt        := ""
Private limite       := 222
Private tamanho      := "G"
Private nomeprog     := "CABR102"
Private nTipo        := 15
Private aReturn      := { "Zebrado", 1, "Administracao", 1, 2, 1, "", 1}
Private nLastKey     := 0
Private cbtxt        := Space(10)
Private cbcont       := 00
Private CONTFL       := 01
Private m_pag        := 01
Private wnrel        := "CABR102"
Private cString      := "SE2"
Private cPerg        := "CABR102   " 

private VlTit        := 0.00 
private VlIss        := 0.00
private VlIrrf       := 0.00                             
private VlPis        := 0.00
private VlCofins     := 0.00
private VlCsll       := 0.00
private VlInss       := 0.00
private VlDesc       := 0.00
private VlSaldo      := 0.00  
private cNfPrest     := ' ' 

dbSelectArea("SE2")
dbSetOrder(1)

ValidPerg(cPerg)

If Pergunte(cPerg,.T.) = .F.
	Return
Endif
private nE2_SALDO    := 0.00       
private dbaixa       := stod('20010101') 
private cFornDE      := mv_par01 
Private cFornAte     := mv_par02
Private cRdaDe       := mv_par03 
Private cRdaAte      := mv_par04
Private cPrefixo     := mv_par05
Private cNumero      := mv_par06 
Private cTipo        := mv_par07
Private dEmisDe      := mv_par08  
Private dEmisAte     := mv_par09  
Private dBaixDe      := mv_par10  
Private dBaixAte     := mv_par11  
Private dVencDe      := mv_par12  
Private dVencAte     := mv_par13
Private dCompet      := mv_par14   
Private nMostMov     := mv_par15
Private dHist        := mv_par16                                           
Private nSaldo       := mv_par17  
Private nSubTot      := mv_par18  //1 -sim, 2- Nao 
Private nFazXls      := mv_par19  //1 -sim, 2- Nao        
Private nFazpls      := mv_par20  //1 -sim, 2- Nao
Private nGruPag      := mv_par22  //1 - Interior, 2 - Grande Rio, 3 - Ambos
Private cGruPre      := alltrim(mv_par23)
//altamiro 23/12/2021
private cBordInc     := mv_par24
private cBordFim     := mv_par25
////
//altamiro 27/12/2021
Private dDatAgInc    := mv_par26  
Private dDatAgFim    := mv_par27  
//

Private cFornece1    := " " 
Private cFornece     := " "  
Private VlTitt       := 0.00
Private VlIsst       := 0.00
Private VlIrrft      := 0.00
Private VlPist       := 0.00
Private VlCofint     := 0.00
Private VlCsllt      := 0.00
Private VlInsst      := 0.00
Private VlDesct      := 0.00
Private VlSaldot     := 0.00
Private VlTit        := 0.00
Private VlIss        := 0.00
Private VlIrrf       := 0.00
Private VlPis        := 0.00
Private VlCofins     := 0.00
Private VlCsll       := 0.00
Private VlInss       := 0.00
Private VlDesc       := 0.00
Private VlSaldo      := 0.00
private aTitXls      := {"Fornec","RDA","NOME","Pref.","Numero","Tipo","Emissão","Vencimento","Baixa","Competência","Vl Titulo","Vl ISS","Vl IRRF","Vl PIS","Vl COFINS","Vl CSLL","Vl INSS","Vl Desc.","Valor Liquido","Saldo", "Historico","Tit Pai","Fornecedor ","Dt baixa" , "CCusto", "Desc CCusto","Data Digitação","Grupo Pagamento","Grupo Prefixo","N.Bordero","Nota Fiscal","Liberação Nota Rda", "Data Agendamento"}

Private nVlTotal     := 0      
Private nVlInform    := 0    
Private nVlBruto     := 0                     

private  aTitulo     := {}

Private cGrupag := Replace(GETMV("MV_XGRPPLS"),"|","','")
                                        
If nMostMov <> 1  
   Cabec2 := " "
EndIf   

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

If Select("TMP") > 0
	dbSelectArea("TMP")
	dbclosearea()
Endif         
If Select("TMP1") > 0
	dbSelectArea("TMP1")
	dbclosearea()
Endif                 
If Select("TMP2") > 0
	dbSelectArea("TMP2")
	dbclosearea()
Endif                 
If Select("TMP3") > 0
	dbSelectArea("TMP3")
	dbclosearea()
Endif

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

if empty(cFornAte) .and. empty(cRdaAte)
    MsgAlert('Informe Fornecedor ate valido ou Rda ate Valido , processo será encerrado' ,"Atencao!")     
    Return()
EndIf 

cQuery := "SELECT * FROM (SELECT E2_FORNECE , E2_CODRDA , E2_NOMFOR  , e2_prefixo , E2_NUM ,E2_PARCELA,  E2_TIPO , E2_LOJA , E2_EMISSAO , E2_VENCREA , E2_BAIXA , E2_VALOR , E2_ISS , "
cQuery += " E2_IRRF, e2_vretpis , e2_vretcof , E2_VRETCSL , E2_INSS ,  E2_DECRESC , E2_SALDO  , a2_nome , E2_HIST , e2_titpai , " 


// MMT ALterado para exibir a data de emissao (E2_EMISSAO) em substituição a data de contabilização
//cQuery += " E2_anobase||'/'||e2_mesbase AMBase , e2_pllote LotPgto ,e2_emis1 emissao , " 
cQuery += " E2_anobase||'/'||e2_mesbase AMBase , e2_pllote LotPgto ,e2_YDTDGNF emissao , " 


cQuery += " nvl(ctt_custo, ' ') CCusto , Nvl(ctt.CTT_DESC01, 'CC Não Cadastrado') Desc_CTT, "

// Inclusão do Grupo de Pagamento - ANDERSON - GLPI 77038 - JULHO 2021
cQuery += " (case when BAU.BAU_GRPPAG IN ('" + cGrupag +"') then 'Interior' else 'Grande Rio' end) desc_grp, " 

cQuery += " E2_YLIBPLS, INITCAP(TRIM(ZUO_GRUPO)) GRP_PREF "
///altamiro 23/12/2021
cQuery += " , e2_numbor numbor , E2_DATAAGE "
///// 					 
cQuery += " FROM " + RetSqlName("SE2")+" SE2 , " + RetSqlName("Sa2")+" Sa2, " + RetSqlName("CTT")+" CTT, " + RetSqlName("BAU")+" BAU, " + RetSqlName("ZUO")+" ZUO "       
cQuery += " WHERE SE2.E2_FILIAL = '"+xFilial("SE2")+"' "
cQuery += " AND   SE2.D_E_L_E_T_ <> '*'  and  Sa2.D_E_L_E_T_ <> '*' and bau.d_e_l_e_t_(+) <> '*'"                                  
cQuery += " AND   SE2.e2_fornece = Sa2.a2_cod and se2.e2_codrda = bau.bau_codigo(+) "
cQuery += " AND ((E2_ORIGEM = 'PLSMPAG' and e2_tipo in ('DP','FT', 'NDF')) OR (E2_ORIGEM <>  'PLSMPAG' ))"            

cQuery += " and  ctt.ctt_filial(+) = '"+xFilial("CTT")+"'  and ctt.D_E_L_E_T_(+) <> '*'  "
cQuery += " and  trim(se2.e2_ccd) = trim(ctt.CTT_CUSTO(+))  "  
                       

cQuery += " AND E2_PREFIXO = ZUO_PREF AND E2_ORIGEM = ZUO_ORIGEM  "
If !empty (cGruPre)
   cQuery += " AND TRIM(ZUO_GRUPO) = '"+cGruPre+"' " 
EndIf


If !empty (cFornDe) .and. !empty (cFornAte)         
   cQuery += " AND   E2_FORNECE  BETWEEN '" + cFornDe + "' AND '" + cFornAte + "'"
EndIf                


If !empty (cRdaDe) .and. !empty (cRdaAte)         
   cQuery += " AND   E2_CODRDA  BETWEEN '" + cRdaDe + "' AND '" + cRdaAte + "'"
EndIf     
/// altamiro 23/12/2021
if !empty (cBordInc) .and. !empty (cBordFim)
   cQuery += " AND   E2_numbor BETWEEN '" + cBordInc + "' AND '" + cBordFim + "'"
EndIf
/////
                      
// cQuery += " AND   E2_CODRDA in ('111406','111414','124796','134210','140040','140139','140147','140155','140171')    
// cQuery += " AND   E2_CODRDA in ('137774') 

 // cQuery += " AND   E2_CODRDA in ('138460','138851')

If !empty (cPrefixo)          
   cQuery += " AND   E2_prefixo =  '" + cPrefixo + "'"
EndIf                            
If !empty (cNumero)          
   cQuery += " AND   E2_num =  '" + cNumero + "'"
EndIf                            
If !empty (cTipo)          
   cQuery += " AND   E2_tipo =  '" + cTipo + "'"
EndIf                           
If !empty (dEmisDe) .and. !empty (dEmisAte)         
   cQuery += " AND   E2_emissao BETWEEN '" + dtos(dEmisDe) + "' AND '" + dtos(dEmisAte) + "'"
EndIf                           
If !empty (dBaixDe) .and. !empty (dBaixAte)         
   cQuery += " AND   E2_baixa  BETWEEN '" + dtos(dBaixDe) + "' AND '" + dtos(dBaixAte) + "'"
EndIf                                                         
If !empty (dVencDe) .and. !empty (dVencAte)         
   cQuery += " AND   E2_Vencrea BETWEEN '" + dtos(dVencDe) + "' AND '" + dtos(dVencAte) + "'"
EndIf          

//// altamiro  28/12/2021
If !empty (dDatAgInc) .and. !empty (dDatAgFim)         
   cQuery += " AND   E2_DATAAGE BETWEEN '" + dtos(dDatAgInc) + "' AND '" + dtos(dDatAgFim) + "'"
EndIf          
/////
                                                            
If !empty (SUBSTR(dCompet,1,2))
   cQuery += " AND   E2_mesbase ||'/'|| e2_anobase = '" + dCompet +"'"
EndIf                                                             
If empty (dHist) 
   If nsaldo = 1 
      cQuery += " AND   E2_saldo > 0.00 "  
   elseIf nsaldo = 2 
      cQuery += " AND   E2_saldo = 0.00 "  
   EndIf
EndIf         
if nFazpls = 2
   cQuery += " AND   E2_origem  <> 'PLSMPAG' " 
ENDiF   
cQuery += " ORDER BY E2_FORNECE, E2_EMISSAO "

if nGruPag = 1
   cQuery += " ) WHERE desc_grp = 'Interior' "
elseif nGruPag = 2
   cQuery += " ) WHERE desc_grp = 'Grande Rio' "
elseif nGruPag = 3
   cQuery += " ) "
ENDIF

 // MsgAlert(cQuery ,"Atencao!")      
 
 MemoWrite("c:\microsiga\cabr102.sql",cQuery)
If Select("TMP") > 0
	dbSelectArea("TMP")
	dbclosearea()
Endif

TCQuery cQuery Alias "TMP" New
dbSelectArea("TMP")
tmp->(dbGoTop())

While tmp->(!EOF()) 
   If nLin = 80
	   cFornece := TMP->E2_FORNECE 
	EndIf    
	If nLin > 60 // Salto de Página. Neste caso o formulario tem 55 linhas...
		Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
	    nLin := 9
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
	if nLin > 58 .or. (nSubTot = 1 .and. TMP->E2_FORNECE != cFornece) 
	   @ nLin,000 PSay replicate("_",220)
	   nLin := nLin + 1	          
	   if (nSubTot = 1 .and. TMP->E2_FORNECE != cFornece) 
	      @ nLin,010 PSAY "Total Fornecedor ---> "  
	   Else
	      @ nLin,010 PSAY "Total Parcial ---> "                                   
	   endif  
	   @ nLin,098 PSAY VlTit      Picture "@E 99,999,999.99"  
      @ nLin,112 PSAY VlIss      Picture "@E 99,999,999.99"
	   @ nLin,125 PSAY VlIrrf     Picture "@E 99,999,999.99"
	   @ nLin,138 PSAY VlPis      Picture "@E 99,999,999.99"
	   @ nLin,151 PSAY VlCofins   Picture "@E 99,999,999.99"
	   @ nLin,164 PSAY VlCsll     Picture "@E 99,999,999.99"
	   @ nLin,178 PSAY VlInss     Picture "@E 99,999,999.99"
	   @ nLin,192 PSAY VlDesc     Picture "@E 99,999,999.99"    
      @ nLin,206 PSAY VlSaldo    Picture "@E 99,999,999.99" 
      nLin := nLin + 1     
	   @ nLin,000 PSay replicate("_",220)  
	   nLin := nLin + 1                                           
	   if (nSubTot = 1 .and. TMP->E2_FORNECE != cFornece)
  	      cFornece := TMP->E2_FORNECE  	       
         VlTit        := 0.00
         VlIss        := 0.00
   	   VlIrrf       := 0.00
   	   VlPis        := 0.00
   	   VlCofins     := 0.00
         VlCsll       := 0.00
         VlInss       := 0.00
         VlDesc       := 0.00
         VlSaldo      := 0.00
  	   EndIf      
	     
	Endif  
	If nLin > 60 // Salto de Página. Neste caso o formulario tem 55 linhas...
      Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo) 
	   nLin := 9
	Endif                         

   nE2_SALDO := TMP->E2_VALOR
   dbaixa    := stod(tmp->E2_BAIXA)           
    
	
   If  nMostMov  = 1  .or. !empty (dHist)    
 	   cQuery1 := " SELECT E5_DATA , E5_VALOR , E5_RECPAG , E5_HISTOR ,E5_MOTBX , E5_DOCUMEN "
      cQuery1 += " FROM " + RetSqlName("SE5")+" SE5 "      
      cQuery1 += " WHERE SE5.E5_FILIAL = '"+xFilial("SE5")+"' "                    
      cQuery1 += " AND   E5_PREFIXO    = '" + TMP->e2_prefixo + "'"  
      cQuery1 += " AND   E5_NUMERO     = '" + TMP->e2_num  + "'"   
      cQuery1 += " AND   E5_PARCELA    = '" + TMP->e2_PARCELA  + "'"   
      cQuery1 += " AND   E5_TIPO       = '" + TMP->E2_TIPO  + "'"     
      cQuery1 += " AND   E5_CLIFOR     = '" + TMP->E2_FORNECE + "'" 
      cQuery1 += " AND   E5_LOJA       = '" + TMP->e2_LOJA  + "'"  
      cQuery1 += " AND   E5_tipodoc    <>'PA'" 
            
      If !empty (dHist)		
         cQuery1 += " AND    E5_DATA <=   '" + dtos(dHist) + "'"   
      EndIF   
      
      cQuery1 += " AND   SE5.D_E_L_E_T_ <> '*' "    
      cQuery1 += " ORDER BY  E5_DATA "
		
      MemoWrite("c:\microsiga\cabr102_2.sql",cQuery)    
      
      If Select("TMP1") > 0
         dbSelectArea("TMP1")
	      dbclosearea()
      Endif
      
      TCQuery cQuery1 Alias "TMP1" New           
      
      If !empty (dHist)	  
         dbaixa    := '  /  /  '
         dbSelectArea("TMP1")
         tmp1->(dbGoTop())  
         nE2_SALDO := nE2_SALDO - TMP->E2_DECRESC       
         While tmp1->(!EOF()) 
            dbaixa    := stod(TMP1->E5_DATA)    
            If  TMP1->E5_recpag  = "P"
               nE2_SALDO := nE2_SALDO - TMP1->E5_VALOR 
            Else                                        
               nE2_SALDO := nE2_SALDO + TMP1->E5_VALOR 
            EndIf                             
 
            tmp1->(dbSkip())   // Avanca o ponteiro do registro no arquivo  
         EndDo   
      EndIf    
   EndIF  

   // altamiro 070613
   If  mv_par21  == 1  
      cQuery3 := " select ZB_EMISSAO , ZB_NOTA , ZB_VTOTAL , ZB_VINFORM , ZB_VBRUTO  , ZB_USUAR , ZB_DTDIGIT ,ZB_OBS, E2_YLIBPLS 
      cQuery3 += " FROM " + RetSqlName("SZB")+" SZB, " + RetSqlName("SE2")+" SE2 " 
      cQuery3 += " WHERE ZB_FILIAL     = '"+xFilial("SZB")+"' "  
      cQuery3 += " AND   E2_FILIAL     = '"+xFilial("SE2")+"' "                  
      //cQuery3 += " AND ZB_CODRDA = E2_CODRDA "
      cQuery3 += " AND ZB_PREFIXO = E2_PREFIXO "
      cQuery3 += " AND ZB_TITULO = E2_NUM "
      cQuery3 += " AND ZB_TIPO = E2_TIPO "
      cQuery3 += " AND ZB_PARCELA = E2_PARCELA "
      cQuery3 += " AND ZB_FORNECE = E2_FORNECE "
      cQuery3 += " AND   ZB_PREFIXO    = '" + TMP->e2_prefixo + "'"  
      cQuery3 += " AND   ZB_TITULO     = '" + TMP->e2_num  + "'"   
      cQuery3 += " AND   ZB_PARCELA    = '" + TMP->e2_PARCELA  + "'"   
      cQuery3 += " AND   ZB_TIPO       = '" + TMP->E2_TIPO  + "'"     
      cQuery3 += " AND   ZB_FORNECE    = '" + TMP->E2_FORNECE + "'" 
      cQuery3 += " AND   ZB_LOJA       = '" + TMP->e2_LOJA  + "'"  
      cQuery3 += " AND   SZB.D_E_L_E_T_ <> '*' " 
      cQuery3 += " AND   SE2.D_E_L_E_T_ <> '*' "   
      cQuery3 += " ORDER BY  ZB_EMISSAO "
      MemoWrite("c:\microsiga\cabr102_3.sql",cQuery)
      If Select("TMP3") > 0
         dbSelectArea("TMP3")
         dbclosearea()
      Endif
      TCQuery cQuery3 Alias "TMP3" New           
      dbSelectArea("TMP3")
      tmp3->(dbGoTop())  
      /*        nE2_SALDO := nE2_SALDO - TMP->E2_DECRESC       
               While tmp1->(!EOF()) 
                  dbaixa    := stod(TMP1->E5_DATA)    
                  If  TMP1->E5_recpag  = "P"
                     nE2_SALDO := nE2_SALDO - TMP1->E5_VALOR 
                  Else                                        
                     nE2_SALDO := nE2_SALDO + TMP1->E5_VALOR 
                  EndIf                             
      
                  tmp1->(dbSkip())   // Avanca o ponteiro do registro no arquivo  
               EndDo   */ 
   EndIF

/////////////////////////////////    
    
    
// impressao do detalhe principal 
   lflag := .T.
	If !empty (dHist) 
	   If nsaldo = 1 .and. nE2_SALDO >  0.00
	      lflag := .F.
	   EndIf          
	   If nsaldo = 2 .and. nE2_SALDO =  0.00
	      lflag := .F.                  
	   endif      
	EndIf    
   If lflag
      @ nLin,000 PSAY TMP->E2_FORNECE             
      @ nLin,009 PSAY TMP->E2_CODRDA 
      @ nLin,016 PSAY SUBSTR (TMP->a2_nome , 1,25)
      @ nLin,043 PSAY TMP->e2_prefixo 
      @ nlin,049 PSAY TMP->E2_NUM     
      @ nlin,059 PSAY TMP->E2_TIPO       
      @ nLin,064 PSAY stod(TMP->E2_EMISSAO) 
      @ nLin,075 PSAY stod(TMP->E2_VENCREA)
      @ nLin,087 PSAY dBaixa //stod(TMP->E2_BAIXA)
      @ nLin,098 PSAY (TMP->E2_VALOR + TMP->E2_ISS + TMP->E2_IRRF + TMP->e2_vretpis + TMP->e2_vretcof + TMP->E2_VRETCSL + TMP->E2_INSS ) Picture "@E 9,999,999.99"  
      @ nLin,112 PSAY TMP->E2_ISS       Picture "@E 9,999,999.99"
      @ nLin,125 PSAY TMP->E2_IRRF      Picture "@E 9,999,999.99"
      @ nLin,138 PSAY TMP->e2_vretpis   Picture "@E 9,999,999.99"
      @ nLin,151 PSAY TMP->e2_vretcof   Picture "@E 9,999,999.99"
      @ nLin,164 PSAY TMP->E2_VRETCSL   Picture "@E 9,999,999.99"
      @ nLin,178 PSAY TMP->E2_INSS      Picture "@E 9,999,999.99"
      @ nLin,192 PSAY TMP->E2_DECRESC   Picture "@E 9,999,999.99"    
      If !empty (dHist)
         @ nLin,206 PSAY     nE2_SALDO Picture "@E 9,999,999.99"
         nE2_SALDO1 := nE2_SALDO
      Else    
         @ nLin,206 PSAY  TMP->E2_SALDO Picture "@E 9,999,999.99"                                               
         nLin := nLin + 1 
         nE2_SALDO1 := TMP->E2_SALDO
      EndIf             
       
      cfornece1 := ' '   
      cbaixa   := '  /  /  '                                                                      
      if !empty (tmp->e2_titpai)        
         cQuery2 := " select  E2_BAIXA ,  e2_FORNECE ||' - '||e2_NOMFOR Fornece from " + RetSqlName("SE2")+" SE2 " 
         cQuery2 += " where e2_filial = '"+xFilial("SE5")+"'  and d_E_L_E_T_ = ' ' "
         cQuery2 += " and ((e2_emissao  > '20100212' and substr('"+tmp->e2_titpai+"',1,3) = e2_prefixo and substr('"+tmp->e2_titpai+"',4,9) = e2_num and substr('"+tmp->e2_titpai+"',13,1) = e2_parcela and substr('"+tmp->e2_titpai+"',14,3) = e2_tipo AND substr('"+tmp->e2_titpai+"',17,6) = e2_fornece AND substr('"+tmp->e2_titpai+"',23,2) = e2_loja )"  
         cQuery2 += "  or  (e2_emissao <= '20100212' and substr('"+tmp->e2_titpai+"',1,3) = e2_prefixo and substr('"+tmp->e2_titpai+"',4,6) = e2_num and substr('"+tmp->e2_titpai+"',10,1) = e2_parcela and substr('"+tmp->e2_titpai+"',11,3) = e2_tipo AND substr('"+tmp->e2_titpai+"',14,6) = e2_fornece AND substr('"+tmp->e2_titpai+"',20,2) = e2_loja ))" 
         MemoWrite("c:\microsiga\cabr102_4.sql",cQuery)
         If Select("TMP2") > 0
            dbSelectArea("TMP2")
            dbclosearea()
         Endif
         TCQuery cQuery2 Alias "TMP2" New           
         dbSelectArea("TMP2")
         tmp2->(dbGoTop())  

         if tmp2->(!EOF())  .and. !empty (tmp->e2_titpai)                   
            cfornece1 :=tmp2->Fornece   
            cbaixa   :=stod(tmp2->E2_baixa)          
         Endif   
      Endif   
      //if (nFazXls = 1 .and. nMostmov = 2) altamiro
      If  mv_par21  == 1  // trata opção de Não considera NF  

          cNfPrest := IIF(empty(TMP3->ZB_NOTA),'SEM NOTA(S) FISCAL(IS) ',(TMP3->ZB_NOTA))
      
      Else     

          cNfPrest := ' ' 

      EndIf

      if nFazXls = 1 
         Aadd(aTitulo,{ TMP->E2_FORNECE     , ; // 01 Cod. Fornecedor  
               TMP->E2_CODRDA      , ; // 02 Cod RDA  
               SUBSTR (TMP->a2_nome , 1,25), ; // 03 Nome fornecedor  
               TMP->e2_prefixo     , ; // 04 Prefixo do titulo    
               TMP->E2_NUM         , ; // 05 Numero do titulo 
               TMP->E2_TIPO        , ; // 06 Tipo do titulo      
               stod(TMP->E2_EMISSAO)    , ; // 07 Dt Emissao         
               stod(TMP->E2_VENCREA)    , ; // 08 Dt Vencimento     
               dBaixa              , ; // 09 baixa
               TMP->AMBase         ,;
               (TMP->(E2_VALOR + E2_ISS + E2_IRRF + e2_vretpis + e2_vretcof + E2_VRETCSL + E2_INSS )  ),;	//+ E2_DECRESC ,  10 Vl. Total 
               (TMP->E2_ISS       ),; // 11 iss
               (TMP->E2_IRRF      ),; // 12 Irrf
               (TMP->e2_vretpis   ),; // 13 pis 
               (TMP->e2_vretcof   ),; // 14 cofins  
               (TMP->E2_VRETCSL   ),; // 15 Csll 
               (TMP->E2_INSS      ),; // 16 Inss
               (TMP->E2_DECRESC   ),; // 17 Descresc 
                TMP->E2_VALOR      ,;
               (nE2_SALDO1        ),; // 18 saldo
               (tmp->e2_hist      ),; // 19 historico 
               (tmp->e2_titpai    ),;
               (cFornece1         ),;
               (cbaixa            ),;
               (TMP->CCusto       ),;
               (TMP->Desc_CTT     ),;
               stod(TMP->emissao  ) ,; // E2_YDTDGNF
               (TMP->desc_grp     ),;
               (TMP->GRP_PREF     ),;
               (TMP->numbor       ),;
               cNfPrest            ,;
               (TMP->E2_YLIBPLS   ),;
               stod(TMP->E2_DATAAGE)})	 
               //incluido acima em 23/12/21  -->   (TMP->numbor       ),;
         //IIF(empty(TMP3->ZB_NOTA),'SEM NOTA(S) FISCAL(IS) ',(TMP3->ZB_NOTA)),;
      endIf     
   	nLin := nLin + 1 // Avanca a linha de impressao 
      // FAZ TOTAL        
      VlTit        += (TMP->E2_VALOR + TMP->E2_ISS + TMP->E2_IRRF + TMP->e2_vretpis + TMP->e2_vretcof + TMP->E2_VRETCSL + TMP->E2_INSS )   
      VlTitt       += (TMP->E2_VALOR + TMP->E2_ISS + TMP->E2_IRRF + TMP->e2_vretpis + TMP->e2_vretcof + TMP->E2_VRETCSL + TMP->E2_INSS )      
      VlIss        += TMP->E2_ISS   
      VlIsst       += TMP->E2_ISS
      VlIrrf       += TMP->E2_IRRF 
      VlIrrft      += TMP->E2_IRRF
      VlPis        += TMP->e2_vretpis
      VlPist       += TMP->e2_vretpis
      VlCofins     += TMP->e2_vretcof  
      VlCofint     += TMP->e2_vretcof
      VlCsll       += TMP->E2_VRETCSL 
      VlCsllt      += TMP->E2_VRETCSL
      VlInss       += TMP->E2_INSS   
      VlInsst      += TMP->E2_INSS
      VlDesc       += TMP->E2_DECRESC 
      VlDesct      += TMP->E2_DECRESC
      If !empty (dHist)
         VlSaldo      += nE2_SALDO  
         VlSaldot     +=     nE2_SALDO
      Else                         
         VlSaldot     +=  TMP->E2_SALDO
         VlSaldo      += TMP->E2_SALDO    
      EndIf                              
 
      If nMostMov = 1
         tmp1->(dbGoTop())
         While tmp1->(!EOF())
            @ nLin,004 PSAY stod(TMP1->E5_data)                    
            @ nLin,016 PSAY TMP1->E5_VALOR  Picture "@E 9,999,999.99"                          
            @ nLin,030 PSAY TMP1->E5_recpag 
            @ nLin,033 PSAY TMP1->E5_motbx  
            @ nLin,038 PSAY TMP1->E5_histor + "  " + subst (TMP1->E5_DOCUMEN, 1,16)
            nLin := nLin + 1 // Avanca a linha de impressao   
               if nLin > 58 .or. (nSubTot = 1 .and. TMP->E2_FORNECE != cFornece)         
                  @ nLin,000 PSay replicate("_",220)
                  nLin := nLin + 1	                                   
                  if (nSubTot = 1 .and. TMP->E2_FORNECE != cFornece) 
                     @ nLin,010 PSAY "Total Fornecedor ---> "  
                  Else
                     @ nLin,010 PSAY "Total Parcial ---> "                                   
                  EndIf                    
                  @ nLin,098 PSAY VlTit      Picture "@E 99,999,999.99"  
                  @ nLin,112 PSAY VlIss      Picture "@E 99,999,999.99"
                  @ nLin,125 PSAY VlIrrf     Picture "@E 99,999,999.99"
                  @ nLin,138 PSAY VlPis      Picture "@E 99,999,999.99"
                  @ nLin,151 PSAY VlCofins   Picture "@E 99,999,999.99"
                  @ nLin,164 PSAY VlCsll     Picture "@E 99,999,999.99"
                  @ nLin,178 PSAY VlInss     Picture "@E 99,999,999.99"
                  @ nLin,192 PSAY VlDesc     Picture "@E 99,999,999.99"    
                  @ nLin,206 PSAY VlSaldo    Picture "@E 99,999,999.99" 

                  if (nSubTot = 1 .and. TMP->E2_FORNECE != cFornece)
                     cFornece := TMP->E2_FORNECE  	       
                     VlTit        := 0.00
                     VlIss        := 0.00
                     VlIrrf       := 0.00
                     VlPis        := 0.00
                     VlCofins     := 0.00
                     VlCsll       := 0.00
                     VlInss       := 0.00
                     VlDesc       := 0.00
                     VlSaldo      := 0.00  
                  //       nLin         := 61
                  EndIf      
            
                  nLin := nLin + 1     
                  @ nLin,000 PSay replicate("_",220)  
                  nLin := nLin + 1
                  
               Endif  
            
            If nLin > 60 // Salto de Página. Neste caso o formulario tem 55 linhas... 
               Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
               nLin := 9
            Endif
            tmp1->(dbSkip())   // Avanca o ponteiro do registro no arquivo
         EndDo                                            
      EndIf
      @ nlin,053 PSAY TMP->desc_grp
      //altamiro 23/12/2021
      @ nlin,100 PSAY TMP->Numbor 
      @ nlin,112 PSAY stod(TMP->E2_DATAAGE)
      ///
      nLin := nLin + 1	 
   EndIf                

   nVlTotal  := 0      
   nVlInform := 0    
   nVlBruto  := 0
  
   If  mv_par21  = 1  
      If empty(tmp3->zb_nota)                        
         @ nLin,010 PSAY "  --->    SEM NOTA(S) FISCAI(S)"                                                                      
      else           
      //       @ nLin,003 PSAY  "Nta Fiscal  Emissao     Vlr Total  Vlr Informado     Vlr Bruto   Digitador  Dt Digit  Observação"          
         While tmp3->(!EOF())                                                                                                       
            nLin := nLin + 1	   
            @ nLin,003 PSAY "NF : " + tmp3->ZB_NOTA 
            @ nLin,015 PSAY "Emissao : " + substr(tmp3->ZB_EMISSAO,7,2)+'/'+substr(tmp3->ZB_EMISSAO,5,2)+'/'+substr(tmp3->ZB_EMISSAO,3,2) 
            @ nLin,035 PSAY "Vlr Total : " 
            @ nLin,047 PSAY tmp3->ZB_VTOTAL   Picture "@E 9,999,999.99"  
            @ nLin,060 PSAY "Vlr Inform : " 
            @ nLin,073 PSAY tmp3->ZB_VINFORM  Picture "@E 9,999,999.99"  
            @ nLin,086 PSAY "Vlr Bruto : " 
            @ nLin,099 PSAY tmp3->ZB_VBRUTO   Picture "@E 9,999,999.99"  
            @ nLin,112 PSAY "Libera Pgt : " + tmp3->E2_YLIBPLS
            @ nLin,128 PSAY "Digit : " + substr(tmp3->ZB_USUAR,1,10)                                                                                   
            @ nLin,147 PSAY "Dt Digit : " + substr(tmp3->ZB_DTDIGIT,7,2)+'/'+substr(tmp3->ZB_DTDIGIT,5,2)+'/'+substr(tmp3->ZB_DTDIGIT,3,2)              
            @ nLin,167 PSAY "Obs : " + tmp3->ZB_OBS
            If Trim(tmp3->ZB_OBS) $ ('NF Digitada com sucesso|Nf Digitada com sucesso|NF Digitada com sucesso - Web')
               
               nVlTotal  += tmp3->ZB_VTOTAL      
               nVlInform += tmp3->ZB_VINFORM   
               nVlBruto  += tmp3->ZB_VBRUTO    
            
            EndIf

               tmp3->(dbSkip()) 
             
         EndDo                             
         nLin := nLin + 2      
 
         @ nLin,003 PSAY "Totais Gerais NF(s) : "
         @ nLin,040 PSAY "Vlr Total : " 
         @ nLin,051 PSAY nVlTotal    Picture "@E 9,999,999.99"  
         @ nLin,064 PSAY "Vlr Inform : " 
         @ nLin,079 PSAY nVlInform  Picture "@E 9,999,999.99"  
         @ nLin,092 PSAY "Vlr Bruto : " 
         @ nLin,105 PSAY nVlBruto   Picture "@E 9,999,999.99"  

         nLin := nLin + 1     
      EndIf     
      nLin := nLin + 1 // Avanca a linha de impressao   
   	@ nLin,003 PSAY 'Ano/Mes base :' +  TMP->AMBase 
	   @ nlin,049 PSAY 'Lote de Pagto:' +  TMP->LotPgto 
	   nLin := nLin + 2 // Avanca a linha de impressao          
   EndIf     
   tmp->(dbSkip())   // Avanca o ponteiro do registro no arquivo
EndDo
	@ nLin,000 PSay replicate("_",220)
	nLin := nLin + 1	
	if (nSubTot = 1 ) 
	   @ nLin,010 PSAY "Total Fornecedor ---> "  
    	@ nLin,098 PSAY VlTit      Picture "@E 99,999,999.99"  
      @ nLin,112 PSAY VlIss      Picture "@E 99,999,999.99"
  	   @ nLin,125 PSAY VlIrrf     Picture "@E 99,999,999.99"
	   @ nLin,138 PSAY VlPis      Picture "@E 99,999,999.99"
	   @ nLin,151 PSAY VlCofins   Picture "@E 99,999,999.99"
	   @ nLin,164 PSAY VlCsll     Picture "@E 99,999,999.99"
	   @ nLin,178 PSAY VlInss     Picture "@E 99,999,999.99"
	   @ nLin,192 PSAY VlDesc     Picture "@E 99,999,999.99"    
      @ nLin,206 PSAY VlSaldo    Picture "@E 99,999,999.99" 
      nLin := nLin + 1     
	   @ nLin,000 PSay replicate("_",220)
	EndIF
	nLin := nLin + 1     
  	@ nLin,000 PSay replicate("_",220) 
	nLin := nLin + 1       	    
	@ nLin,010 PSAY "Total Geral ---> "                   
	@ nLin,098 PSAY VlTitt      Picture "@E 99,999,999.99"  
   @ nLin,112 PSAY VlIsst      Picture "@E 99,999,999.99"
  	@ nLin,125 PSAY VlIrrft     Picture "@E 99,999,999.99"
	@ nLin,138 PSAY VlPist      Picture "@E 99,999,999.99"
	@ nLin,151 PSAY VlCofint    Picture "@E 99,999,999.99"
	@ nLin,164 PSAY VlCsllt     Picture "@E 99,999,999.99"
	@ nLin,178 PSAY VlInsst     Picture "@E 99,999,999.99"
	@ nLin,192 PSAY VlDesct     Picture "@E 99,999,999.99"    
   @ nLin,206 PSAY VlSaldot    Picture "@E 99,999,999.99"                                   
   nLin := nLin + 1     
   @ nLin,000 PSay replicate("_",220)
	if nFazXls = 1 //.and. nMostmov = 2

      //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
      //³ Gera excel                                                         ³
      //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

      //--------------------------------------------------------------------------
      //Angelo Henrique - Data: 25/04/2022
      //--------------------------------------------------------------------------
      //Chamado: 84966
      //--------------------------------------------------------------------------
      aAdd(atitulo ,{"Relatório Extraído em: " + DToC(dDataBase) + ", Horário: " + TIME()} )
      //--------------------------------------------------------------------------

      DlgToExcel({{"ARRAY","Gravações da Filial" , aTitXls  ,atitulo}})           
      //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ		        
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
cPerg := PADR(cPerg,10)

aAdd(aRegs,{cPerg,"01","Do Fornecedor   ?","","","mv_ch1" ,"C",06,0,0,"G","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "", "" })
aAdd(aRegs,{cPerg,"02","Ate Fornecedor  ?","","","mv_ch2" ,"C",06,0,0,"G","","mv_par02","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "", "" })
aAdd(aRegs,{cPerg,"03","Do RDA          ?","","","mv_ch3" ,"C",06,0,0,"G","","mv_par03","","","","","","","","","","","","","","","","","","","","","","","","","BAUNFE" , "" , "" , "", "", "" })
aAdd(aRegs,{cPerg,"04","Ate RDA         ?","","","mv_ch4" ,"C",06,0,0,"G","","mv_par04","","","","","","","","","","","","","","","","","","","","","","","","","BAUNFE" , "" , "" , "", "", "" })

aAdd(aRegs,{cPerg,"05","Prefixo Titulo  ?","","","mv_ch5" ,"C",06,0,0,"G","","mv_par05","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "", "" })
aAdd(aRegs,{cPerg,"06","Numero Titulo   ?","","","mv_ch6" ,"C",09,0,0,"G","","mv_par06","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "", "" })
aAdd(aRegs,{cPerg,"07","Tipo Titulo     ?","","","mv_ch7" ,"C",06,0,0,"G","","mv_par07","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "", "" })

aAdd(aRegs,{cPerg,"08","De Emissao      ?","","","mv_ch8" ,"D",08,0,0,"G","","mv_par08","","","","","","","","","","","","","","","","","","","","","","","","","US2"    , "" , "" , "", "", "" })
aAdd(aRegs,{cPerg,"09","Ate Emissao     ?","","","mv_ch9" ,"D",08,0,0,"G","","mv_par09","","","","","","","","","","","","","","","","","","","","","","","","","US2"    , "" , "" , "", "", "" }) 
aAdd(aRegs,{cPerg,"10","De Baixa        ?","","","mv_ch10","D",08,0,0,"G","","mv_par10","","","","","","","","","","","","","","","","","","","","","","","","","US2"    , "" , "" , "", "", "" })
aAdd(aRegs,{cPerg,"11","Ate Baixa       ?","","","mv_ch11","D",08,0,0,"G","","mv_par11","","","","","","","","","","","","","","","","","","","","","","","","","US2"    , "" , "" , "", "", "" })
aAdd(aRegs,{cPerg,"12","De Vencimeto    ?","","","mv_ch12","D",08,0,0,"G","","mv_par12","","","","","","","","","","","","","","","","","","","","","","","","","US2"    , "" , "" , "", "", "" })
aAdd(aRegs,{cPerg,"13","Ate Vencimento  ?","","","mv_ch13","D",08,0,0,"G","","mv_par13","","","","","","","","","","","","","","","","","","","","","","","","","US2"    , "" , "" , "", "", "" })
aAdd(aRegs,{cPerg,"14","Competencia     ?","","","mv_ch14","C",07,0,0,"G","","mv_par14","","","","","","","","","","","","","","","","","","","","","","","","",""       , "" , "" , "", "99/9999", "" })
aAdd(aRegs,{cPerg,"15","Mostra Movimen. ?","","","mv_ch15","N",01,0,0,"c","","mv_par15","Sim","","","","","Não","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "", "" })
aAdd(aRegs,{cPerg,"16","Dt.historica Ate?","","","mv_ch16","D",08,0,0,"G","","mv_par16","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "", "" })
aAdd(aRegs,{cPerg,"17","Quanto Ao Saldo ?","","","mv_ch17","N",01,0,0,"c","","mv_par17","> 0.00","","","","","= 0.00","","","","","Ambos","","","","","","","","","","","","","","" , "" , "" , "", "", "" })
aAdd(aRegs,{cPerg,"18","Sub-total       ?","","","mv_ch18","N",01,0,0,"c","","mv_par18","Sim","","","","","Não","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "", "" }) 
aAdd(aRegs,{cPerg,"19","Gera Excel      ?","","","mv_ch19","N",01,0,0,"c","","mv_par19","Sim","","","","","Não","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "", "" })
aAdd(aRegs,{cPerg,"20","Considerar Pls's?","","","mv_ch20","N",01,0,0,"c","","mv_par20","Sim","","","","","Não","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "", "" })
aAdd(aRegs,{cPerg,"21","Listar N.F        ?","","","mv_ch21","N",01,0,0,"c","","mv_par21","Sim","","","","","Não","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "", "" })
aAdd(aRegs,{cPerg,"22","Grupo de Pagamento ?","","","mv_ch22","N",01,0,0,"c","","mv_par22","Interior","","","","","Grande Rio","","","","","Ambos","","","","","","","","","","","","","","" , "" , "" , "", "", "" })
                
For i:=1 to (aRegs)
	If !dbSeek(cPerg+aRegs[i,2])
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
