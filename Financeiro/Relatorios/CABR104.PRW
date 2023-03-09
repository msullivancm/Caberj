#Include "RWMAKE.CH"
#Include "TOPCONN.CH"
#INCLUDE "Protheus.ch"
#INCLUDE "Tbiconn.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ CABR104  º Autor ³ Altamiro Affonso   º Data ³  05/10/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±                                            
±±ºDescricao ³ Relatorio De Bordero de pagamento customizado              º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP6 IDE                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/              
 
 
User Function CABR104

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Local cDesc1         := "Este programa tem como objetivo imprimir relatorio "
Local cDesc2         := "de bordero de pagamento ordenado e grupados pelo motivo"
Local cDesc3         := " "
Local cPict          := " "
Local titulo         := "Bordero de Pagamento por Tipo "
Local nLin           := 80 			

Local Cabec1         := "Tipo                                             Data                Valor"
//                       1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//                       0        1         2         3         4         5         6         7         8         9         0         1         2         3         4         5         6         7         8         9         0         1         2
                      
Local Cabec2         := "   "
Local imprime        := .T.
Local aOrd           := {}
Private lEnd         := .F.
Private lAbortPrint  := .F.
Private CbTxt        := ""
Private limite       := 80
Private tamanho      := "P"
Private nomeprog     := "CABR104"
Private nTipo        := 15
Private aReturn      := { "Zebrado", 1, "Administracao", 1, 2, 1, "", 1}
Private nLastKey     := 0
Private cbtxt        := Space(10)
Private cbcont       := 00
Private CONTFL       := 01
Private m_pag        := 01
Private wnrel        := "CABR104"
Private cString      := "SEA"
Private cPerg        := "CABR104   "    
private cComp        := " "                 
private cCompd       := 'Competencias--> '
private aComPg       := {}
private aSaidCom     := {}  
private aCabec1      := {'Prefixo' ,'Numero' , 'Tipo' , 'Saldo' , 'Impostos' , 'Descontos' , 'Cod.Rda' , 'Fornecedor' , 'Comp Pagto' , 'Mes/Ano Guias'  , 'Valor Guias'}
private Cvlrtita     := 0.00      
private cImposto     := 0.00                 
private VlData       := 0.00  
private VlDatat      := 0.00
private nValliq      := 0.00 
private nsaldo       := 0.00
private dData        := " "    
private cCompAnt     := " " 
private Vltotger     :=0.00 
private lCritica     :=.F.
private cNumbor      := ' '
private ctit         :=' ' 
dbSelectArea("SEA")
dbSetOrder(1)

ValidPerg(cPerg)
If Pergunte(cPerg,.T.) = .F.
	Return
Endif


dDtInc   := mv_par01
dDtFim   := mv_par02
nMosMov  := mv_par03
cTNãoSair:= mv_par04
cListBord:= mv_par05
cSubTot  := mv_par06
cListCheq:= mv_par07
cBNãoSair:= mv_par08          
cBSair   := mv_par09
cTSair   := mv_par10       
cProtador:= mv_par11   

nResGer  := Mv_Par12
nDetMed  := Mv_Par13   
private  aTitXls        := {"Tp Movimento","Data","Valor"}


private  aTitulo        := {}    
                                        
//If nMosMov = 1  
//   Cabec2 := " "              
//else                                                                                                           
private Cabecal2 := "Border Pref  Numero     Tipo             Valor"    
//            1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//            0        1         2         3         4         5         6         7         8         9         0         1         2         3         4         5         6         7         8         9         0         1         2
//
//EndIf                                                                                                                                            


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

Local nOrdem
Local cQuery   := ' '      
Local cArqQry  := GetNextAlias() 
local cPrefixo := ' ' 
local cNum     := ' '
local cCodrda  := ' '
local lVaz     := .T.           
local lImposto := .T.   
local nVlrTit  := 0.00  
local i        := 1 
dbSelectArea(cString)
dbSetOrder(1)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ SETREGUA -> Indica quantos registros serao processados para a regua ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetRegua(RecCount())    
If cListBord = 1
cQuery :=" SELECT case when sea.EA_MODELO = '01' then '01 - Credito C/C Itau' "
cQuery +=" when sea.EA_MODELO = '02' then '02 - Cheque Pagamento Administrativo' "
cQuery +=" when sea.EA_MODELO = '03' then '03 - DOC ' "
cQuery +=" when sea.EA_MODELO = '04' then '04 - OP a Disposição Com Aviso Para o Favorecido' "
cQuery +=" when sea.EA_MODELO = '05' then '05 - Credito em Conta Poupança' "
cQuery +=" when sea.EA_MODELO = '10' then '10 - OP a Disposição Sem Aviso Para o Favorecido' "
cQuery +=" when sea.EA_MODELO = '13' then '13 - Pagamento a Concessionarias' "        
cQuery +=" when sea.EA_MODELO = '16' then '16 - Pagamento de Tributos - DARF Normal' "
cQuery +=" when sea.EA_MODELO = '17' then '17 - Pagamento de Tributos GPS' "
cQuery +=" when sea.EA_MODELO = '18' then '18 - Pagamento de Tributos - DARF Simples' "
cQuery +=" when sea.EA_MODELO = '21' then '21 - Pagamento de Tributos - DARF' "
//cQuery +=" when sea.EA_MODELO = '30' then '30 - Pagamento de Titulos Em Cobrança no Itau' "
cQuery +=" when sea.EA_MODELO = '30' then '30 - Pagamento de Titulos Itau' " //Angelo Henrique - Data:14/0519
cQuery +=" when sea.EA_MODELO = '31' then '31 - Pagamento de Titulos Em Outros Bancos' "
cQuery +=" when sea.EA_MODELO = '41' then '41 - TED - Outro Titular' "
cQuery +=" when sea.EA_MODELO = '43' then '43 - TED - Mesmo Titular' "
cQuery +=" else 'Outros'  end descricao, "

//cQuery +=" sea.EA_DATABOR  , SUM (ROUND(E2_VALLIQ,2)) VALLIQ1,  Sum (ROUND(E2_SALDO-e2_SDDECRE,2)) Saldo " //MArcela
cQuery +=" sea.EA_DATABOR  , SUM (ROUND(E2_VALLIQ,2)) VALLIQ1,  trunc(Sum (E2_SALDO-e2_SDDECRE+E2_SDACRES),2) Saldo " //Angelo - Removido um dos Rounds e acrescentado Trunc
// cQuery +=" sea.EA_DATABOR  , Sum (e2_saldo) Saldo " Marcela
cQuery +=" FROM "+RetSqlName("SE2")+" SE2  ,(select DISTINCT EA_NUMBOR,  EA_DATABOR ,EA_MODELO FROM "+RetSqlName("SEA")+" SEA "
cQuery +=" WHERE EA_FILIAL = '"+xFilial("SEA")+"' AND sea.d_E_L_E_T_ = ' ' AND EA_DATABOR >= '" +dtos(dDtInc)+"' "
cQuery +=" AND EA_DATABOR <= '"+dtos(dDtFim) +"' AND EA_CART = 'P' "
If !empty (cProtador)
    cQuery +="and  EA_PORTADO = '"+cProtador+"'"
EndIf    
If !empty (cTNãoSair) 
    cQuery +=" AND EA_MODELO NOT IN "+FormatIn(cTNãoSair, ",")
EndIF
If !empty (cTSair) 
    cQuery +=" AND EA_MODELO IN "+FormatIn(cTSair, ",") 
EndIF              
              
If !empty (cBNãoSair) 
    cQuery +=" AND EA_NUMBOR NOT IN "+FormatIn(cBNãoSair, ",")
EndIF 
If !empty (cBSair) 
    cQuery +=" AND EA_NUMBOR IN "+FormatIn(cBSair, ",") 
EndIF
cQuery +=" ) sea WHERE e2_filial =  '"+xFilial("SE2")+"' AND d_e_L_E_T_ = ' ' AND e2_numbor In ( sea.EA_NUMBOR ) " 
cQuery +=" group BY sea.EA_DATABOR , sea.EA_MODELO " 
cQuery +=" ORDER BY sea.EA_DATABOR , sea.EA_MODELO "

If Select("TMP") > 0
	dbSelectArea("TMP")
	dbclosearea()
Endif

TCQuery cQuery Alias "TMP" New
dbSelectArea("TMP")
tmp->(dbGoTop())

If  (nMosMov = 2 .OR. nMosMov = 4)                              
       cQuery :=" SELECT  sea.EA_MODELO ,  sea.EA_DATABOR , e2_numbor , e2_PREFIXO , e2_num  ,e2_Tipo ,(E2_VALLIQ) VALLIQ1,(E2_SALDO - e2_SDDECRE +E2_SDACRES) saldo , 
       cQuery +=" e2_nomfor ,(e2_inss+e2_irrf+e2_iss+e2_vretpis+e2_vretcof+e2_vretcsl) imp , e2_origem , e2_pllote , e2_codrda "
       if mv_par15 = 2
          cQuery +=", bd7_mespag , bd7_anopag , e2_sddecre, e2_decresc , sum (bd7_vlrpag) vlrpag "   
       EndIf   
       cQuery +=" FROM "+RetSqlName("SE2")+" SE2 , "
       if mv_par15 = 2
          cQuery +="bd7010 bd7 , "
       EndIf   
       cQuery +="                       ( select DISTINCT EA_NUMBOR,  EA_DATABOR ,EA_MODELO "
       cQuery +="                           FROM "+RetSqlName("SEA")+" SEA  "
       cQuery +="                          WHERE EA_FILIAL = '"+xFilial("SEA")+"' AND sea.d_E_L_E_T_ = ' ' 
       cQuery +="                            AND EA_DATABOR >= '" +dtos(dDtInc)+"' "
       cQuery +="                            AND EA_DATABOR <= '"+dtos(dDtFim) +"' AND EA_CART = 'P' 
       If !empty (cTNãoSair) 
          cQuery +="                         AND EA_MODELO NOT IN "+FormatIn(cTNãoSair, ",")
       EndIF 
       If !empty (cTSair) 
          cQuery +="                         AND EA_MODELO IN "+FormatIn(cTSair, ",") 
       EndIF
       If !empty (cBNãoSair) 
          cQuery +="                         AND EA_numbor NOT IN "+FormatIn(cBNãoSair, ",") 
       EndIF                                              
       If !empty (cBSair) 
          cQuery +="                         AND EA_numbor IN "+FormatIn(cBSair, ",")  
       EndIF
       If !empty (cProtador)
          cQuery +="                         and  EA_PORTADO = '"+cProtador+"'"
       EndIf    
       cQuery +="                       ) sea "
       cQuery +=" WHERE e2_filial =  '"+xFilial("SE2")+"' AND se2.d_e_L_E_T_ = ' '  AND e2_numbor In ( sea.EA_NUMBOR ) " 
       if Mv_par15 = 2
          cQuery +=" and bd7_filial =  '"+xFilial("bd7")+"' AND bd7.d_e_L_E_T_ = ' ' "
          cQuery +=" and SUBSTR(bd7_numlot,1,6) >= SUBSTR(E2_pllOte,1,6) and SUBSTR(bd7_numlot,1,6) <= SUBSTR(E2_pllOte,1,6) "
          cQuery +=" and bd7_codrda = E2_codrda and bd7_codope = '0001' AND E2_ORIGEM = 'PLSMPAG' "
       EndIf   
       cQuery +=" group by  sea.EA_MODELO ,  sea.EA_DATABOR , e2_numbor , e2_PREFIXO , e2_num , e2_Tipo ,(E2_VALLIQ) , "
       cQuery +=" (E2_SALDO-e2_SDDECRE +E2_SDACRES) , e2_nomfor ,(e2_inss+e2_irrf+e2_iss+e2_vretpis++e2_vretcof+e2_vretcsl) ,      "
       cQuery +=" e2_origem , e2_pllote , e2_codrda "
       if mv_par15 = 2
          cQuery +=", bd7_mespag , bd7_anopag  , e2_sddecre, e2_decresc    " 
              
          cQuery +=" union "
       
          cQuery +=" SELECT  sea.EA_MODELO ,  sea.EA_DATABOR , e2_numbor , e2_PREFIXO , e2_num  ,e2_Tipo ,(E2_VALLIQ) VALLIQ1,(E2_SALDO - e2_SDDECRE+E2_SDACRES) saldo , 
          cQuery +=" e2_nomfor ,(e2_inss+e2_irrf+e2_iss+e2_vretpis+e2_vretcof+e2_vretcsl) imp , e2_origem , e2_pllote , e2_codrda , '00' , '0000' , e2_sddecre, e2_decresc , 0.00 "   
          cQuery +=" FROM "+RetSqlName("SE2")+" SE2 , "
          cQuery +="                       ( select DISTINCT EA_NUMBOR,  EA_DATABOR ,EA_MODELO "
          cQuery +="                           FROM "+RetSqlName("SEA")+" SEA  "
          cQuery +="                          WHERE EA_FILIAL = '"+xFilial("SEA")+"' AND sea.d_E_L_E_T_ = ' ' 
          cQuery +="                            AND EA_DATABOR >= '" +dtos(dDtInc)+"' "
          cQuery +="                            AND EA_DATABOR <= '"+dtos(dDtFim) +"' AND EA_CART = 'P' 
          If !empty (cTNãoSair) 
             cQuery +="                         AND EA_MODELO NOT IN "+FormatIn(cTNãoSair, ",")
          EndIF 
          If !empty (cTSair) 
             cQuery +="                         AND EA_MODELO IN "+FormatIn(cTSair, ",") 
          EndIF
          If !empty (cBNãoSair) 
             cQuery +="                         AND EA_numbor NOT IN "+FormatIn(cBNãoSair, ",") 
          EndIF                                              
          If !empty (cBSair) 
             cQuery +="                         AND EA_numbor IN "+FormatIn(cBSair, ",")  
          EndIF
          If !empty (cProtador)
             cQuery +="                         and  EA_PORTADO = '"+cProtador+"'"
          EndIf    
             cQuery +="                       ) sea "
             cQuery +=" WHERE e2_filial =  '"+xFilial("SE2")+"' AND se2.d_e_L_E_T_ = ' '  AND e2_numbor In ( sea.EA_NUMBOR ) " 
             cQuery +="  AND E2_ORIGEM <> 'PLSMPAG' "                                                                              
             cQuery +=" group by  sea.EA_MODELO ,  sea.EA_DATABOR , e2_numbor , e2_PREFIXO , e2_num , e2_Tipo ,(E2_VALLIQ) , "
             cQuery +=" (E2_SALDO-e2_SDDECRE) , e2_nomfor ,(e2_inss+e2_irrf+e2_iss+e2_vretpis++e2_vretcof+e2_vretcsl) ,      "
             cQuery +=" e2_origem , e2_pllote , e2_codrda  ,  e2_sddecre, e2_decresc    " 
       EndIf
       cQuery +=" ORDER BY 2,1 , 4 , 5 "
       if mv_par15 = 2
          cQuery += ",13  "
       EndIf   
       
 
       If Select("TMP1") > 0
          dbSelectArea("TMP1")
	      dbclosearea()
       Endif
       TCQuery cQuery Alias "TMP1" New  
       dbSelectArea("TMP1")
       tmp1->(dbGoTop())
EndIf  
If  (nMosMov = 3 .OR. nMosMov = 4)                     
       cQuery :=" SELECT  EA_NUMBOR, EA_DATABOR, EA_MODELO, SUM (ROUND(E2_VALLIQ , 2)) VALLIQ1 ,Sum(E2_SALDO - e2_SDDECRE +E2_SDACRES) saldo ," ///Sum(E2_SALDO+E2_DECRESC-e2_SDDECRE) saldo ," // Marcela
       // cQuery :=" SELECT  EA_NUMBOR, EA_DATABOR, EA_MODELO, Sum(E2_SALDO) saldo " Marcela                                 
       cQuery +="  case when sea.EA_MODELO = '01' then '01 - Credito C/C Itau' "
       cQuery +=" when sea.EA_MODELO = '02' then '02 - Cheque Pagamento Administrativo' "
       cQuery +=" when sea.EA_MODELO = '03' then '03 - DOC ' "
       cQuery +=" when sea.EA_MODELO = '04' then '04 - OP a Disposição Com Aviso Para o Favorecido' "
       cQuery +=" when sea.EA_MODELO = '05' then '05 - Credito em Conta Poupança' "
       cQuery +=" when sea.EA_MODELO = '10' then '10 - OP a Disposição Sem Aviso Para o Favorecido' "
       cQuery +=" when sea.EA_MODELO = '13' then '13 - Pagamento a Concessionarias' "        
       cQuery +=" when sea.EA_MODELO = '16' then '16 - Pagamento de Tributos - DARF Normal' "
       cQuery +=" when sea.EA_MODELO = '17' then '17 - Pagamento de Tributos GPS' "
       cQuery +=" when sea.EA_MODELO = '18' then '18 - Pagamento de Tributos - DARF Simples' "
       cQuery +=" when sea.EA_MODELO = '21' then '21 - Pagamento de Tributos - DARF' "
       //cQuery +=" when sea.EA_MODELO = '30' then '30 - Liquidação de Titulos Em Cobrança no Itau' "
       cQuery +=" when sea.EA_MODELO = '30' then '30 - Pagamento de Titulos Itau' " //Angelo Henrique - Data:14/0519
       cQuery +=" when sea.EA_MODELO = '31' then '31 - Pagamento de Titulos Em Outros Bancos' "
       cQuery +=" when sea.EA_MODELO = '41' then '41 - TED - Outro Titular' "
       cQuery +=" when sea.EA_MODELO = '43' then '43 - TED - Mesmo Titular' "
       cQuery +=" else 'Outros'  end descricao "    
       cQuery +=" FROM "+RetSqlName("SE2")+" SE2 ,(select DISTINCT EA_NUMBOR,  EA_DATABOR ,EA_MODELO FROM "+RetSqlName("SEA")+" SEA "
       cQuery +=" WHERE EA_FILIAL = '"+xFilial("SEA")+"' AND sea.d_E_L_E_T_ = ' ' AND EA_DATABOR >= '" +dtos(dDtInc)+"' "
       cQuery +=" AND EA_DATABOR <= '"+dtos(dDtFim) +"' AND EA_CART = 'P' 
       If !empty (cTNãoSair) 
          cQuery +=" AND EA_MODELO NOT IN "+FormatIn(cTSair, ",")  
       EndIF  
       If !empty (cTSair) 
          cQuery +=" AND EA_MODELO IN "+FormatIn(cTSair, ",")
       EndIF 
       If !empty (cBNãoSair) 
          cQuery +=" AND EA_numbor NOT IN "+FormatIn(cBNãoSair, ",")
       EndIF 
       If !empty (cBSair) 
          cQuery +=" AND EA_numbor IN "+FormatIn(cBSair, ",")
       EndIF
       If !empty (cProtador)
          cQuery +="and  EA_PORTADO = '"+cProtador+"'"
       EndIf    

       cQuery +=" ) sea WHERE e2_filial = '"+xFilial("SE2")+"' AND d_e_L_E_T_ = ' ' AND e2_numbor In ( sea.EA_NUMBOR ) "      
       cQuery +=" group BY  EA_DATABOR , EA_MODELO , EA_NUMBOR " 
       cQuery +=" ORDER BY sea.EA_DATABOR , sea.EA_MODELO  "
 
       If Select("TMP2") > 0
          dbSelectArea("TMP2")
	      dbclosearea()
       Endif
       TCQuery cQuery Alias "TMP2" New  
       dbSelectArea("TMP2")
       tmp2->(dbGoTop())
EndIf      

While tmp->(!EOF()) 
	If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
	   nLin  := Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo) 
	   dData := TMP->EA_DATABOR                                         
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
	If nLin > 58 .and. cSubTot = 1
	  @ nLin,000 PSay replicate("_",080)
	    nLin := nLin + 1	          
      @ nLin,025 PSAY "Sub-Total Data "
      @ nlin,042 psay stod(dData)
      @ nlin,053 psay " ---> "  
      @ nLin,062 PSAY VlData     Picture "@E 99,999,999.99"   
        nLin := nLin + 1  
	  @ nLin,000 PSay replicate("_",080)  
        dData:= TMP->EA_DATABOR   
    endif  
                                                 
	if (cSubTot = 1 .and. TMP->EA_DATABOR  != dData )  
	   @ nLin,000 PSay replicate("_",080)
	     nLin := nLin + 1	         
       @ nLin,030 PSAY "Total Data "
       @ nlin,042 psay stod(dData)
       @ nlin,053 psay " ---> "  
       @ nLin,062 PSAY VlData     Picture "@E 99,999,999.99"  
         nLin := nLin + 1 
       @ nLin,000 PSay replicate("_",080)
 	     nLin := nLin + 1	       
         dData:= TMP->EA_DATABOR     	  
         VlData := 0.00
  	EndIf      
      nLin++
    @ nLin,001 PSAY trim (TMP->descricao)           
	 @ nLin,045 PSAY stod(TMP->EA_DATABOR)   
	if mv_par14 = 1              
       @ nLin,061 PSAY TMP->Saldo   Picture "@E 999,999,999.99" 
    else                                                      
       @ nLin,061 PSAY TMP->valliq1 Picture "@E 999,999,999.99" 
    EndIf   
   if nMosMov  <> 1                                       
       @ nLin,002 PSAY trim (TMP->descricao)           
	   @ nLin,046 PSAY stod(TMP->EA_DATABOR)                 
	if mv_par14 = 1              
       @ nLin,062 PSAY TMP->Saldo   Picture "@E 999,999,999.99" 
    else                                                      
       @ nLin,062 PSAY TMP->valliq1 Picture "@E 999,999,999.99" 
    EndIf   
   EndIf      
   nLin++   
    If  (nMosMov = 3 .OR. nMosMov = 4)                                           
      @ nLin,000 PSay replicate("_",080)
	    nLin := nLin + 1	         
       While (tmp2->(!EOF()) .and. tmp2->EA_MODELO = substr (TMP->descricao,1,2) .and. tmp2->EA_DATABOR = tmp->EA_DATABOR .and. (nMosMov = 3 .OR. nMosMov = 4) )
             
              @ nLin,001 PSAY trim (TMP2->EA_NUMBOR)              
              @ nLin,008 PSAY  stod(TMP2->EA_DATABOR)             
           	  @ nLin,020 PSAY TMP2->descricao   
              if mv_par14 = 1              
                 @ nLin,062 PSAY TMP2->Saldo   Picture "@E 999,999,999.99" 
              else                                                      
                 @ nLin,062 PSAY TMP2->valliq1 Picture "@E 999,999,999.99" 
              EndIf  
                nLin++      
              	If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
		          nLin  := Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)   
	            Endif                                           
	            nLin++ 
              tmp2->(dbSkip())   // Avanca o ponteiro do registro no arquivo  
       EndDo
    EndIf   
    If (nMosMov = 2 .OR. nMosMov = 3 .OR. nMosMov = 4)                                          
       @ nLin,000 PSay replicate("_",080)
	   nLin++	 
	   @ nLin,000 PSAY  Cabecal2    
       nLin++       
       @ nLin,000 PSay replicate("_",080)
       nLin++        
    EndIf      
    If (nMosMov = 2 .OR. nMosMov = 4)                                           
       While (tmp1->(!EOF()) .and. tmp1->EA_MODELO = substr (TMP->descricao,1,2) .and. tmp1->EA_DATABOR = tmp->EA_DATABOR .and.  (nMosMov = 2 .OR. nMosMov = 4))
              @ nLin,001 PSAY TMP1->e2_numbor              
              @ nLin,008 PSAY TMP1->e2_PREFIXO             
           	  @ nLin,013 PSAY TMP1->e2_num  
              @ nLin,025 PSAY TMP1->e2_Tipo 
          if mv_par14 = 1              
              @ nLin,031 PSAY TMP1->saldo    Picture "@E 999,999,999.99" 
          else                                                      
              @ nLin,031 PSAY TMP1->valliq1 Picture "@E 999,999,999.99" 
          EndIf 
              @ nLin,045 PSAY TMP1->E2_codrda + ' - ' + substr (TMP1->e2_nomfor, 1,30)
                nLin++      
              	If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
		           nLin  := Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)    
	            Endif    
///////          
          if tmp1->(!EOF())
             cPrefixo := tmp1->e2_prefixo 
             cNum     := tmp1->e2_num 
             cCodrda  := tmp1->E2_CODRDA 
          EndIf   

//         If mv_par15 == 1 .and. tmp1->e2_prefixo == cPrefixo .and. tmp1->e2_num == cNum .and. tmp1->E2_CODRDA == cCodrda .and. trim(tmp1->e2_origem) == 'PLSMPAG' .and. tmp1->e2_prefixo != 'COM'           
            lvaz    := .T.           
            imposto := iif (mv_par17==1,.F.,.T.)     

            While mv_par15 == 2 .and. tmp1->e2_prefixo == cPrefixo .and. tmp1->e2_num == cNum .and. tmp1->E2_CODRDA == cCodrda .and. trim(tmp1->e2_origem) == 'PLSMPAG' .and. tmp1->e2_prefixo != 'COM'           
              if mv_par16 = 2
                  if imposto                                            
                     @  nLin,008 PSAY "Impostos Retidos "           
                     @  nLin,040 PSAY (tmp1->imp) Picture "@E 999,999,999.99"     
                     nLin++                  
                     imposto := .F.                                      
                     If tmp1->e2_decresc  > 0 
                        @  nLin,008 PSAY "Decrescimo  "           
                        @  nLin,040 PSAY (tmp1->e2_decresc) Picture "@E 999,999,999.99"  
                        nLin++ 
                     EndIf         
                  EndIf               
              
                 @  nLin,008 PSAY tmp1->bd7_mespag+'/'+tmp1->bd7_anopag           
                 @  nLin,040 PSAY tmp1->vlrpag Picture "@E 999,999,999.99"   
                 nLin++                                  
                 nVlrTit += tmp1->vlrpag  
              else 
                 cCompd+= tmp1->bd7_mespag+'/'+tmp1->bd7_anopag +' , '
                 nVlrTit +=  tmp1->vlrpag  
              EndIf                
              
              If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
		         nLin  := Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)    
	          Endif          
	          Aadd(aSaidCom,{tmp1->e2_prefixo, tmp1->e2_num, tmp1->e2_tipo , tmp1->saldo ,tmp1->imp ,tmp1->e2_decresc,   tmp1->e2_codrda , tmp1->e2_nomfor, substr(tmp1->e2_pllote,1,6) , tmp1->bd7_mespag+'/'+tmp1->bd7_anopag,tmp1->vlrpag })
       	      If (nAscan:=Ascan(aComPg , {|e| e[2]+e[3] ==  tmp1->bd7_mespag + tmp1->bd7_anopag  })) == 0    
                   Aadd(aComPg, { tmp1->bd7_anopag + tmp1->bd7_mespag ,; 
                                   tmp1->bd7_mespag     ,;
                                   tmp1->bd7_anopag     ,;
   	                               tmp1->vlrpag})
              Else 
                  aComPg[nAscan,04]+= tmp1->vlrpag
 	          EndIf    
	          Cvlrtita := tmp1->saldo   
	          cImposto := tmp1->imp
	          cpllote  := SUBSTR(TMP1->E2_pllOte,1,6)
	          tmp1->(dbSkip())                                                                                 
	          if tmp1->e2_prefixo != cPrefixo .or. tmp1->e2_num != cNum .or. tmp1->E2_CODRDA != cCodrda
	             if mv_par16 = 1          
	             	If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
		               nLin  := Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)   
	                Endif   
                    @ nLin,008 PSAY cCompd
                    cCompd := 'Competencias--> '   
                    nLin++
                 EndIf    
	             lvaz := .F.
	          EndIf   
             if mv_par18 = 2  .and. nVlrTit!=  (Cvlrtita + cImposto)
               cQuery := "select bgq_ano , bgq_mes , bgq_numlot ,  SUM(DECODE(bgq_tipo,1,-1*BGQ_VALOR,BGQ_VALOR)) Vl_Informado "
               cQuery += " from Bgq010 bgq "
               cQuery += " where bgq_filial = '  ' and bgq.d_E_L_E_T_ = ' ' and bgq_codlan <> '050' "
               cQuery += " and  SUBSTR(bgq_numlot,1,6) >= '"+cpllote+"' and SUBSTR(bgq_numlot,1,6) <= '"+cpllote+"' and bgq_codigo  = '"+cCodrda +"' "
               cQuery += " group by  bgq_ano, bgq_mes,bgq_numlot "   
            
               nVlrTit := 0.00 
               If Select("TMP6") > 0
                  dbSelectArea("TMP6")
	              dbclosearea()
               Endif
               TCQuery cQuery Alias "TMP6" New  
               dbSelectArea("TMP6")
               tmp6->(dbGoTop())  
               While tmp6->(!EOF()) 
	             If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
	                nLin  := Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo) 
	             Endif     
                 @  nLin,008 PSAY "Cred/Debito  "
                 @  nLin,030 PSAY tmp6->bgq_ano +'/'+ tmp6->bgq_mes +' - '+ tmp6->bgq_numlot                
                 @  nLin,040 PSAY tmp6->Vl_Informado Picture "@E 999,999,999.99"                
               Enddo                     
             EndIf 
        EndDo             

         If mv_par15 != 2  .or. lvaz == .T. 
            tmp1->(dbSkip())   // Avanca o ponteiro do registro no arquivo  
         EndIf
    EndDo   
  
                
  EndIf                  
   If  (nMosMov = 2 .OR. nMosMov = 4)                                          
      @ nLin,000 PSay replicate("_",080)
	    nLin := nLin + 1	         
    EndIf           
                 
     	if mv_par14 = 1                                       
     	    VlDatat +=TMP->saldo 
            VlData  +=TMP->saldo
        else                                                      
            VlDatat +=TMP->valliq1  
            VlData  +=TMP->valliq1
        EndIf                   

    tmp->(dbSkip())
EndDo           
                        
//	  @ nLin,000 PSay replicate("_",080)
	    nLin := nLin + 1	  
      If cSubTot = 1 	              
         @ nLin,030 PSAY "Total Data "
         @ nlin,042 psay stod(dData)
         @ nlin,053 psay " ---> "  
         @ nLin,062 PSAY VlData     Picture "@E 99,999,999.99"  
           nLin := nLin + 1 
         @ nLin,000 PSay replicate("_",080)
           nLin := nLin + 1	       
      EndIf     
      @ nLin,040 PSAY "Total   -----> "  
      @ nLin,062 PSAY VlDatat     Picture "@E 99,999,999.99"  
        nLin := nLin + 1  
	  @ nLin,000 PSay replicate("_",080)
EndIf	  
 If (nMosMov = 2 .OR. nMosMov = 4) 
  	aSort( aComPg,,,{|x,y| x[1] < y[1]} )                
    @ nLin,000 PSay replicate("_",080)         
      nliN++                       
    @ nLiN, 015 Psay '    '  
    @ nLiN, 038 Psay '  Valor  '    
      nliN++ 
    @ nLin,000 PSay replicate("_",080)         
      nliN++                       
    While  i <= len(aComPg) 
          @ nLiN, 015 Psay aComPg[i][2]+'/'+aComPg[i][3] 
          @ nLiN, 038 Psay aComPg[i][4] Picture "@E 999,999,999.99"    
            nliN++   
            i++                                                                                              
    Enddo                          
 EndIf
If cListCheq == 1
   nLin := 80                               
   Cabec1:= "   Data    Bco  Ag   Conta    Num.Chq         Valor  Prf    Numero tipo Benefic" 
//         123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//                  1         2         3         4         5         6         7         8
   Cabec2:= ' ' 
   VlDatat :=0.00    
   VlData  :=0.00   
   cQuery :=" SELECT EF_DATA,EF_BANCO,EF_AGENCIA,EF_CONTA,EF_NUM,EF_VALOR,EF_PREFIXO,EF_TITULO,EF_TIPO,EF_BENEF,EF_HIST "
   cQuery +=" FROM "+RetSqlName("SEF")+" SEF  WHERE EF_FILIAL  = '"+xFilial("SEF")+"' AND d_E_L_E_T_ = ' ' "
   cQuery +=" AND EF_DATA >= '"+dtos(dDtInc) +"' AND  EF_DATA <= '"+dtos(dDtFim)+"' " 
   If !empty (cProtador)
      cQuery +="and  EF_BANCO = '"+cProtador+"'"
   EndIf                                        
   cQuery +="order by EF_DATA,EF_BANCO,EF_AGENCIA,EF_CONTA,EF_NUM,EF_VALOR,EF_PREFIXO,EF_TITULO,EF_TIPO"
   If Select("TMP3") > 0
      dbSelectArea("TMP3")
  	  dbclosearea()
   Endif                                                                                                          
   TCQuery cQuery Alias "TMP3" New
   dbSelectArea("TMP3")
   tmp3->(dbGoTop())                      
   cnumChq:= " "  
   While tmp3->(!EOF()) 
    	 If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
	        nLin  := Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo) 
	        dData := TMP3->EF_DATA                                        
	     Endif                                           
	     If nLin > 58 .and. cSubTot = 1
	        @ nLin,000 PSay replicate("_",080)
	        nLin := nLin + 1	          
            @ nLin,025 PSAY "Sub-Total Data "
            @ nlin,042 psay stod(dData)
            @ nlin,053 psay " ---> "  
            @ nLin,062 PSAY VlData     Picture "@E 99,999,999.99"   
            nLin := nLin + 1  
	        @ nLin,000 PSay replicate("_",080)  
            dData:= TMP3->EF_DATA    
         endif                                        
   	     if (cSubTot = 1 .and.  TMP3->EF_DATA  != dData )  
	        @ nLin,000 PSay replicate("_",080)
	        nLin := nLin + 1	         
            @ nLin,030 PSAY "Total Data "
            @ nlin,042 psay stod(dData)
            @ nlin,053 psay " ---> "  
            @ nLin,062 PSAY VlData     Picture "@E 99,999,999.99"  
            nLin := nLin + 1 
            @ nLin,000 PSay replicate("_",080)
 	        nLin := nLin + 1	       
            dData:= TMP3->EF_DATA     	  
            VlData := 0.00
  	     EndIf      
  	     nLin++
  	     if cnumChq != substr (TMP3->EF_NUM,1,8)
            @ nLin,000 PSAY STOD(TMP3->EF_DATA)           
       	    @ nLin,011 PSAY TMP3->EF_BANCO                        
	        @ nLin,015 PSAY TMP3->EF_AGENCIA      
	        @ nLin,020 PSAY TMP3->EF_CONTA    
	        @ nLin,031 PSAY substr (TMP3->EF_NUM,1,8)      
            @ nLin,040 PSAY TMP3->EF_VALOR   Picture "@E 999,999,999.99"    
            @ nLin,053 PSAY substr (TMP3->EF_hist,1,20)   
            VlDatat +=TMP3->EF_VALOR 
            VlData  +=TMP3->EF_VALOR
         Else      
            @ nLin,001 PSAY "*** Baixar o titulos --> "
            @ nLin,026 PSAY TMP3->EF_PREFIXO      
            @ nLin,030 PSAY TMP3->EF_TITULO      
            @ nLin,040 PSAY TMP3->EF_TIPO 
            @ nLin,045 PSAY substr (TMP3->EF_BENEF,1,20)        
         EndIf             
         cnumChq := substr (TMP3->EF_NUM,1,8)                                       
         tmp3->(dbSkip()) 
   EndDo                                   
   @ nLin,000 PSay replicate("_",080)
   nLin := nLin + 1	  
   If cSubTot = 1 	              
      @ nLin,030 PSAY "Total Data "
      @ nlin,042 psay stod(dData)
      @ nlin,053 psay " ---> "  
      @ nLin,062 PSAY VlData     Picture "@E 99,999,999.99"  
      nLin := nLin + 1 
      @ nLin,000 PSay replicate("_",080)
      nLin := nLin + 1	       
   EndIf     
      @ nLin,040 PSAY "Total   -----> "  
      @ nLin,062 PSAY VlDatat     Picture "@E 99,999,999.99"  
      nLin := nLin + 1  
	  @ nLin,000 PSay replicate("_",080)
EndIf                  
////////aki agora altamiro 25/08/2011
If nResGer  = 1             
   Titulo := " Visão Gerencia "
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Geração do demonstrativo gerencia......                             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
 If nDetMed = 1  
    //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
    //³ Competencia  - analitica         ......                             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
   nLin := 80                               
   cabec1:= "Pgto Med Grupo                           Especialidade                    Valor" 
//           123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//                    1         2         3         4         5         6         7         8
   Cabec2:= ' '                                    
   VlCompt :=0.00    
   VlComp  :=0.00        
  
   //cQuery :=" select substr (e2_pllote, 1,6) Competencia , BAU_GRPPAG||' - ' || B16_DESCRI  GRPPAG  , e2_prefixo Espialidade , SUM (ROUND(E2_VALLIQ , 2)) VALLIQ1, SUM (ROUND(E2_SALDO-e2_SDDECRE,2)) Saldo " //Sum (E2_SALDO+E2_ACRESC-E2_DECRESC) Saldo " //ALTAMIRO
   cQuery :=" select substr (e2_pllote, 1,6) Competencia , BAU_GRPPAG||' - ' || B16_DESCRI  GRPPAG  , e2_prefixo Espialidade , SUM (ROUND(E2_VALLIQ , 2)) VALLIQ1, SUM (E2_SALDO-e2_SDDECRE+E2_SDACRES) Saldo " //Sum (E2_SALDO+E2_ACRESC-E2_DECRESC) Saldo " //ALTAMIRO
   cQuery +=" from "+RetSqlName("SE2")+" SE2 , "+RetSqlName('BAU')+ " BAU , "+RetSqlName('B16')+ " B16 ,   (select DISTINCT EA_NUMBOR,  EA_DATABOR ,EA_MODELO FROM "+RetSqlName("SEA")+" SEA "
   cQuery +=" WHERE EA_FILIAL = '"+xFilial("SEA")+"' AND sea.d_E_L_E_T_ = ' ' AND EA_DATABOR >= '" +dtos(dDtInc)+"' "
   cQuery +=" AND EA_DATABOR <= '"+dtos(dDtFim) +"' AND EA_CART = 'P' "
   If !empty (cProtador)
      cQuery +="and  EA_PORTADO = '"+cProtador+"'"
   EndIf    
   If !empty (cTNãoSair) 
      cQuery +=" AND EA_MODELO NOT IN "+FormatIn(cTNãoSair, ",")
   EndIF
   If !empty (cTSair) 
      cQuery +=" AND EA_MODELO IN "+FormatIn(cTSair, ",") 
   EndIF                      
   If !empty (cBNãoSair) 
      cQuery +=" AND EA_NUMBOR NOT IN "+FormatIn(cBNãoSair, ",")
   EndIF 
   If !empty (cBSair) 
      cQuery +=" AND EA_NUMBOR IN "+FormatIn(cBSair, ",") 
   EndIF
   cQuery +=" ) sea WHERE e2_filial =  '"+xFilial("SE2")+"' AND se2.d_e_L_E_T_ = ' ' AND e2_numbor In ( sea.EA_NUMBOR ) "      
   
   cQuery +="            AND B16_FILIAL = '" + xFilial('B16') + "'  AND B16.D_E_L_E_T_ = ' ' "
   cQuery +="            AND BAU_FILIAL = '" + xFilial('BAU') + "'  AND BAU.D_E_L_E_T_ = ' ' AND BAU.R_E_C_D_E_L_ = 0" 

   cQuery +=" and e2_origem = 'PLSMPAG' and e2_prefixo <> 'COM' "      
   cQuery +=" AND BAU_GRPPAG = B16_CODIGO and e2_codrda  = bau_codigo "
   cQuery +=" and e2_tipo not in ('TX' , 'INS','ISS','NDF', 'TXA', 'REM', 'SPA' ) "
   cQuery +=" group by substr (e2_pllote, 1,6) , e2_prefixo  ,  BAU_GRPPAG||' - ' || B16_DESCRI "
   cQuery +=" order by substr (e2_pllote, 1,6) , e2_prefixo  ,  BAU_GRPPAG||' - ' || B16_DESCRI " 
   If Select("TMP4") > 0
      dbSelectArea("TMP4")
      dbclosearea()
   Endif                                                                                                          
   TCQuery cQuery Alias "TMP4" New
   dbSelectArea("TMP4")
   tmp4->(dbGoTop())     
 if tmp4->(!EOF())   
    nLin  := Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)            
    cCompAnt := tmp4->Competencia 
   While tmp4->(!EOF())
	 If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
	    nLin  := Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)                                         
     Endif                                           
	 If cCompAnt == tmp4->Competencia .and. nLin > 57   
	      nLin ++
        @ nLin,000 PSay replicate("_",080)          
	      nLin ++	          
        @ nLin,025 PSAY "Total Parcial Competencia" 
        cComp:=trim(substr(tmp4->Competencia,5,2)+'/'+substr(tmp4->Competencia,1,4)) 
        @ nlin,052 psay cComp     
        @ nlin,059 psay " ---> "  
        @ nLin,066 PSAY VlComp    Picture "@E 99,999,999.99"   
          nLin ++  
	    @ nLin,000 PSay replicate("_",080)  
	      nLin ++
        cCompAnt := tmp4->Competencia   
     endif                                         
	 If cCompAnt != tmp4->Competencia  
	      nLin ++
        @ nLin,000 PSay replicate("_",080)
	    nLin ++	                       
	    ccomp :=substr(cCompAnt,5,2)+'/'+substr(cCompAnt,1,4) 
        @ nLin,025 PSAY "Total  Competencia"
        @ nlin,052 psay ccomp 
        @ nlin,059 psay " ---> "  
        @ nLin,066 PSAY Vlcomp     Picture "@E 99,999,999.99"   
          nLin++  
	    @ nLin,000 PSay replicate("_",080)  
        cCompAnt := tmp4->Competencia
        Vlcompt += Vlcomp                	  
        Vlcomp := 0.00
        nLin ++
     EndIf             
      cComp := trim(substr(tmp4->Competencia,5,2)+"/"+substr(tmp4->Competencia,1,4))   
       nLin ++	  
    @ nLin,000 PSAY cComp           
    @ nLin,010 PSAY substr(GRPPAG,1,30)
    @ nLin,042 PSAY trim (TMP4->Espialidade)                        
   if mv_par14 = 1              
      @ nLin,065 PSAY TMP4->Saldo   Picture "@E 999,999,999.99" 
   else                                                      
      @ nLin,065 PSAY TMP4->valliq1 Picture "@E 999,999,999.99" 
   EndIf                                                                                                
   if mv_par14 = 1                                       
      Vlcomp +=TMP4->Saldo  
   else                                                      
      Vlcomp +=TMP4->valliq1  
   EndIf                   
      cCompAnt := tmp4->Competencia 
      nLin ++
      tmp4->(dbSkip()) 
  EndDo                                 
  @ nLin,000 PSay replicate("_",080)
    nLin ++	                                          
    ccomp :=substr(cCompAnt,5,2)+'/'+substr(cCompAnt,1,4) 
  @ nLin,025 PSAY "Total  Competencia"                        
  @ nlin,052 psay ccomp
  @ nlin,059 psay " ---> "  
  @ nLin,065 PSAY Vlcomp     Picture "@E 999,999,999.99"   
  nLin ++ 
  @ nLin,000 PSay replicate("_",080)  
  Vlcompt += Vlcomp                	  
  Vlcomp := 0.00                     
  nLin ++
  @ nLin,000 PSay replicate("_",080)    
  nLin ++       
  @ nLin,040 PSAY "Total   -----> "  
  @ nLin,066 PSAY Vlcompt     Picture "@E 999,999,999.99"  
  nLin ++ 
  @ nLin,000 PSay replicate("_",080)  
  vltotger+=Vlcompt 
 EndIF  
 ///conferencia pagamento medico 
 
                                        
    //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
    //³Fim  Competencia  - analitica         ......                         ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ  
	
    //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
    //³ Incicio Spa  - analitica         ......                             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
   cabec1:= "Spa                 Tipo Prest                         Valor    " 
//           123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//                    1         2         3         4         5         6         7         8
   Cabec2:= ' '                                    
   VlCompt :=0.00    
   VlComp  :=0.00      
  
   cQuery :="  select  'SPA' Tit, BAU_TIPPRE , SUM (ROUND(E2_VALLIQ + E2_SDACRES, 2)) VALLIQ1, SUM (ROUND(E2_SALDO-e2_SDDECRE+E2_SDACRES,2)) Saldo " // --Sum (E2_VALOR+E2_ACRESC-E2_DECRESC) Saldo  " // ALTAMIRO 
   cQuery +=" from "+RetSqlName("SE2")+" SE2,"+RetSqlName("BAU")+" BAU  ,(select DISTINCT EA_NUMBOR,  EA_DATABOR ,EA_MODELO FROM "+RetSqlName("SEA")+" SEA "
   cQuery +=" WHERE EA_FILIAL = '"+xFilial("SEA")+"' AND sea.d_E_L_E_T_ = ' ' AND EA_DATABOR >= '" +dtos(dDtInc)+"' "
   cQuery +=" AND EA_DATABOR <= '"+dtos(dDtFim) +"' AND EA_CART = 'P' "
   If !empty (cProtador)
      cQuery +="and  EA_PORTADO = '"+cProtador+"'"
   EndIf    
   If !empty (cTNãoSair) 
      cQuery +=" AND EA_MODELO NOT IN "+FormatIn(cTNãoSair, ",")
   EndIF
   If !empty (cTSair) 
      cQuery +=" AND EA_MODELO IN "+FormatIn(cTSair, ",") 
   EndIF                      
   If !empty (cBNãoSair) 
      cQuery +=" AND EA_NUMBOR NOT IN "+FormatIn(cBNãoSair, ",")
   EndIF 
   If !empty (cBSair) 
      cQuery +=" AND EA_NUMBOR IN "+FormatIn(cBSair, ",") 
   EndIF
   cQuery +=" ) sea WHERE e2_filial =  '"+xFilial("SE2")+"' AND SE2.d_e_L_E_T_ = ' ' and  bau_filial =  '"+xFilial("BAU")+"' AND BAU.d_e_L_E_T_ = ' ' AND e2_numbor In ( sea.EA_NUMBOR ) " 
   cQuery +=" and e2_PREFIXO  = 'SPA'   AND E2_CODRDA = BAU_CODIGO "
   cQuery +=" group by BAU_TIPPRE order by BAU_TIPPRE " 
   If Select("TMP4") > 0
      dbSelectArea("TMP4")
      dbclosearea()
   Endif                                                                                                          
   TCQuery cQuery Alias "TMP4" New
   dbSelectArea("TMP4")
   tmp4->(dbGoTop())     
  if  tmp4->(!EOF())     
        nLin ++
      @ nLin,000 PSay replicate("_",080)     
        nLin ++
      @ nLin,000 PSay "Spa       Tipo Prest                    Valor    " 
        nLin ++
      @ nLin,000 PSay replicate("_",080)
   While tmp4->(!EOF()) 
   	 If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
	    nLin  := Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)                                         
     Endif                                           
	 If nLin > 57 
	      nLin ++
        @ nLin,000 PSay replicate("_",080)
	    nLin ++	          
        @ nLin,025 PSAY "Total Parcial SPA"
        @ nlin,059 psay " ---> "  
        @ nLin,066 PSAY VlComp    Picture "@E 999,999,999.99"   
        nLin ++
	    @ nLin,000 PSay replicate("_",080)  
     endif                                         
 	  nLin++                                                                        
    @ nLin,000 PSAY tmp4->Tit           
    @ nLin,011 PSAY TMP4->BAU_TIPPRE                        
	if mv_par14 = 1              
      @ nLin,040 PSAY TMP4->Saldo   Picture "@E 999,999,999.99" 
    else                                                      
      @ nLin,040 PSAY TMP4->valliq1 Picture "@E 999,999,999.99" 
    EndIf                                                                                                
    if mv_par14 = 1                                       
      Vlcomp +=TMP4->Saldo  
    else                                                      
      Vlcomp +=TMP4->valliq1  
    EndIf                   
      tmp4->(dbSkip()) 
  EndDo                                   
  nLin ++
  @ nLin,000 PSay replicate("_",080)
  nLin ++	          
  @ nLin,025 PSAY "Total  Spa"
  @ nlin,059 psay " ---> "  
  @ nLin,066 PSAY Vlcomp     Picture "@E 999,999,999.99"   
  nLin ++  
  @ nLin,000 PSay replicate("_",080)  
    vltotger+=Vlcomp 
    Vlcompt := 0.00               	  
    Vlcomp  := 0.00           
    nLin ++          
 endIf
    //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
    //³ Incicio Tributos  - analitica         ......                        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
   Cabec2:= ' ' 
   VlCompt :=0.00    
   VlComp  :=0.00      
  
   cQuery :="  select 'Tributos' tit , e2_naturez   ,e2_tipo , SUM (ROUND(E2_VALLIQ + E2_SDACRES , 2)) VALLIQ1,  SUM (E2_SALDO-e2_SDDECRE+E2_SDACRES) Saldo " //Sum (E2_VALOR+E2_ACRESC-E2_DECRESC) Saldo  "  
   cQuery +=" from "+RetSqlName("SE2")+" SE2,(select DISTINCT EA_NUMBOR,  EA_DATABOR ,EA_MODELO FROM "+RetSqlName("SEA")+" SEA "
   cQuery +=" WHERE EA_FILIAL = '"+xFilial("SEA")+"' AND sea.d_E_L_E_T_ = ' ' AND EA_DATABOR >= '" +dtos(dDtInc)+"' "
   cQuery +=" AND EA_DATABOR <= '"+dtos(dDtFim) +"' AND EA_CART = 'P' "
   If !empty (cProtador)
      cQuery +="and  EA_PORTADO = '"+cProtador+"'"
   EndIf    
   If !empty (cTNãoSair) 
      cQuery +=" AND EA_MODELO NOT IN "+FormatIn(cTNãoSair, ",")
   EndIF
   If !empty (cTSair) 
      cQuery +=" AND EA_MODELO IN "+FormatIn(cTSair, ",") 
   EndIF                      
   If !empty (cBNãoSair) 
      cQuery +=" AND EA_NUMBOR NOT IN "+FormatIn(cBNãoSair, ",")
   EndIF 
   If !empty (cBSair) 
      cQuery +=" AND EA_NUMBOR IN "+FormatIn(cBSair, ",") 
   EndIF
   cQuery +=" ) sea WHERE e2_filial =  '"+xFilial("SE2")+"' AND SE2.d_e_L_E_T_ = ' ' AND e2_numbor In ( sea.EA_NUMBOR ) " 
   
    //-----------------------------------------------------------------------------------------------------------------
   //Angelo Henrique - Data: 16/01/2020
   //-----------------------------------------------------------------------------------------------------------------
   //Conforme colicitação da Marcia Victer é necessário que sejam exibidas todos os tipos de impostos, 
   //para que a capa do relatório esteja com o mesmo valor apresentado aqui
   //-----------------------------------------------------------------------------------------------------------------
   
   //cQuery +=" AND E2_TIPO in ('TX' , 'INS','ISS') "   
   cQuery +=" AND E2_TIPO in ('TX' , 'INS','ISS', 'IRF', 'FGT') "
   
   //-----------------------------------------------------------------------------------------------------------------
   
   cQuery +=" group by e2_naturez , e2_tipo  order by e2_naturez , e2_tipo "

   If Select("TMP4") > 0
      dbSelectArea("TMP4")
      dbclosearea()
   Endif                                                                                                          
   TCQuery cQuery Alias "TMP4" New
   dbSelectArea("TMP4")
   tmp4->(dbGoTop())     
 if tmp4->(!EOF())                      
      nLin ++
    @ nLin,000 PSay replicate("_",080)     
      nLin ++
    @ nLin,000 PSay "Tributos      Natureza      Tipo             Valor    " 
      nLin ++
    @ nLin,000 PSay replicate("_",080)
      
   While tmp4->(!EOF()) 
	 If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
	    nLin  := Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)                                         
     Endif                                           
	 If nLin > 57 
	      nLin ++
        @ nLin,000 PSay replicate("_",080)
	      nLin ++	          
        @ nLin,025 PSAY "Total Parcial Tributos"
        @ nlin,059 psay " ---> "  
        @ nLin,066 PSAY VlComp    Picture "@E 999,999,999.99"   
        nLin ++
	    @ nLin,000 PSay replicate("_",080)  
     endif                                         
 	  nLin++                                                                        
    @ nLin,000 PSAY tmp4->Tit           
    @ nLin,015 PSAY TMP4->e2_naturez     
    @ nLin,029 PSAY TMP4->e2_tipo       
	if mv_par14 = 1              
      @ nLin,040 PSAY TMP4->Saldo   Picture "@E 999,999,999.99" 
    else                                                      
      @ nLin,040 PSAY TMP4->valliq1 Picture "@E 999,999,999.99" 
    EndIf                                                                                                
    if mv_par14 = 1                                       
      Vlcomp +=TMP4->Saldo  
    else                                                      
      Vlcomp +=TMP4->valliq1  
    EndIf                   
      tmp4->(dbSkip()) 
  EndDo             
     nLin ++                      
  @ nLin,000 PSay replicate("_",080)
    nLin ++	          
  @ nLin,025 PSAY "Total  Tributo"
  @ nlin,059 psay " ---> "  
  @ nLin,066 PSAY Vlcomp     Picture "@E 999,999,999.99"   
    nLin ++  
  @ nLin,000 PSay replicate("_",080)  
    nLin ++
    vltotger+=Vlcomp
    Vlcompt := 0.00                	  
    Vlcomp  := 0.00 
                      
 EndIf
Else 
    //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
    //³ Competencia  - sintetica        ......                             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
   nLin := 80                                

        cabec1:= "Pgto Medico                                    Valor    " 
//                123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//                         1         2         3         4         5         6         7         8
   Cabec2:= ' ' 
   VlCompt :=0.00    
   VlComp  :=0.00        
  
   cQuery :=" select substr (e2_pllote, 1,6) Competencia  , SUM (ROUND(E2_VALLIQ + E2_SDACRES, 2)) VALLIQ1, SUM (ROUND(E2_SALDO-e2_SDDECRE+E2_SDACRES,2)) Saldo " //Sum (E2_SALDO+E2_ACRESC-E2_DECRESC) Saldo "
   cQuery +=" from "+RetSqlName("SE2")+" SE2 ,(select DISTINCT EA_NUMBOR,  EA_DATABOR ,EA_MODELO FROM "+RetSqlName("SEA")+" SEA "
   cQuery +=" WHERE EA_FILIAL = '"+xFilial("SEA")+"' AND sea.d_E_L_E_T_ = ' ' AND EA_DATABOR >= '" +dtos(dDtInc)+"' "
   cQuery +=" AND EA_DATABOR <= '"+dtos(dDtFim) +"' AND EA_CART = 'P' "
   If !empty (cProtador)
      cQuery +="and  EA_PORTADO = '"+cProtador+"'"
   EndIf    
   If !empty (cTNãoSair) 
      cQuery +=" AND EA_MODELO NOT IN "+FormatIn(cTNãoSair, ",")
   EndIF
   If !empty (cTSair) 
      cQuery +=" AND EA_MODELO IN "+FormatIn(cTSair, ",") 
   EndIF                      
   If !empty (cBNãoSair) 
      cQuery +=" AND EA_NUMBOR NOT IN "+FormatIn(cBNãoSair, ",")
   EndIF 
   If !empty (cBSair) 
      cQuery +=" AND EA_NUMBOR IN "+FormatIn(cBSair, ",") 
   EndIF
   cQuery +=" ) sea WHERE e2_filial =  '"+xFilial("SE2")+"' AND d_e_L_E_T_ = ' ' AND e2_numbor In ( sea.EA_NUMBOR ) " 
   cQuery +=" and e2_origem = 'PLSMPAG' AND E2_PREFIXO <> 'COM' "
   cQuery +=" and e2_tipo not in ('TX' , 'INS','ISS','NDF', 'TXA', 'REM', 'SPA' ) group by substr (e2_pllote, 1,6)  order by substr (e2_pllote, 1,6)" 
   If Select("TMP4") > 0
      dbSelectArea("TMP4")
      dbclosearea()
   Endif                                                                                                          
   TCQuery cQuery Alias "TMP4" New
   dbSelectArea("TMP4")
   tmp4->(dbGoTop())     
if tmp4->(!EOF())                    
    @ nLin,000 PSay replicate("_",080)   
    nLin++  
    @ nLin,000 PSay "Pgto medico                                    Valor    " 
    nLin++
    @ nLin,000 PSay replicate("_",080)                                 
  While tmp4->(!EOF())
	 If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
	    nLin  := Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)                                         
     Endif                                           
  	  nLin++
    @ nLin,000 PSAY "Competencia " + substr (tmp4->Competencia,1,4) +"/" + substr(tmp4->Competencia,5,2)           
  	if mv_par14 = 1              
      @ nLin,040 PSAY TMP4->Saldo   Picture "@E 999,999,999.99" 
    else                                                      
      @ nLin,040 PSAY TMP4->valliq1 Picture "@E 999,999,999.99" 
    EndIf                                                                                                
    if mv_par14 = 1                                       
      Vlcomp +=TMP4->Saldo  
    else                                                      
      Vlcomp +=TMP4->valliq1  
    EndIf                     
    tmp4->(dbSkip()) 
  EndDo                                   
  nLin++
  @ nLin,000 PSay replicate("_",080)           
  nLin++
  @ nLin,040 PSAY "Total   -----> "  
  @ nLin,062 PSAY Vlcompt     Picture "@E 999,999,999.99"  
  nLin++
  @ nLin,000 PSay replicate("_",080) 
  vltotger+=Vlcompt 
EndIf  
    //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
    //³ Incicio Spa  - Sintetico         ......                             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
   cabec1:= "Spa                                            Valor    " 
//           123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//                  1         2         3         4         5         6         7         8
   Cabec2:= ' ' 
   VlCompt :=0.00    
   VlComp  :=0.00      
  
   cQuery :="  select  'SPA' Tit,  SUM (ROUND(E2_VALLIQ + E2_SDACRES, 2)) VALLIQ1, SUM (ROUND(E2_SALDO-e2_SDDECRE+E2_SDACRES,2)) Saldo " //Sum (E2_VALOR+E2_ACRESC-E2_DECRESC) Saldo  "  
   cQuery +=" from "+RetSqlName("SE2")+" SE2,(select DISTINCT EA_NUMBOR,  EA_DATABOR ,EA_MODELO FROM "+RetSqlName("SEA")+" SEA "
   cQuery +=" WHERE EA_FILIAL = '"+xFilial("SEA")+"' AND sea.d_E_L_E_T_ = ' ' AND EA_DATABOR >= '" +dtos(dDtInc)+"' "
   cQuery +=" AND EA_DATABOR <= '"+dtos(dDtFim) +"' AND EA_CART = 'P' "
   If !empty (cProtador)
      cQuery +="and  EA_PORTADO = '"+cProtador+"'"
   EndIf    
   If !empty (cTNãoSair) 
      cQuery +=" AND EA_MODELO NOT IN "+FormatIn(cTNãoSair, ",")
   EndIF
   If !empty (cTSair) 
      cQuery +=" AND EA_MODELO IN "+FormatIn(cTSair, ",") 
   EndIF                      
   If !empty (cBNãoSair) 
      cQuery +=" AND EA_NUMBOR NOT IN "+FormatIn(cBNãoSair, ",")
   EndIF 
   If !empty (cBSair) 
      cQuery +=" AND EA_NUMBOR IN "+FormatIn(cBSair, ",") 
   EndIF
   cQuery +=" ) sea WHERE e2_filial =  '"+xFilial("SE2")+"' AND SE2.d_e_L_E_T_ = ' '  AND e2_numbor In ( sea.EA_NUMBOR ) " 
   cQuery +=" and e2_PREFIXO  = 'SPA'   AND E2_TIPO = 'PA' "
   
   If Select("TMP4") > 0
      dbSelectArea("TMP4")
      dbclosearea()
   Endif                                                                                                          
   TCQuery cQuery Alias "TMP4" New
   dbSelectArea("TMP4")
   tmp4->(dbGoTop())     
if tmp4->(!EOF())   
   While tmp4->(!EOF()) 
	 If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
	    nLin  := Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)                                         
     Endif                                           
	  nLin++                                                                        
    @ nLin,000 PSAY tmp4->Tit           
    if mv_par14 = 1              
      @ nLin,040 PSAY TMP4->Saldo   Picture "@E 999,999,999.99" 
    else                                                      
      @ nLin,040 PSAY TMP4->valliq1 Picture "@E 999,999,999.99" 
    EndIf                                                                                                
    if mv_par14 = 1                                       
      Vlcomp +=TMP4->Saldo  
    else                                                      
      Vlcomp +=TMP4->valliq1  
    EndIf                   
      Vlcomp += TMP4->saldo 
      tmp4->(dbSkip()) 
  EndDo  
   vltotger+=Vlcomp                                  
EndIf                                                
   //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
    //³ Incicio tributos - Sintetico         ......                             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
   cabec1:= "Tributos                                       Valor    " 
//           123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//                  1         2         3         4         5         6         7         8
   Cabec2:= ' ' 
   VlCompt :=0.00    
   VlComp  :=0.00      
  
    cQuery :="  select 'Tributos' tit , SUM (ROUND(E2_VALLIQ + E2_SDACRES, 2)) VALLIQ1, SUM (E2_SALDO-e2_SDDECRE+E2_SDACRES) Saldo " //Sum (E2_VALOR+E2_ACRESC-E2_DECRESC) Saldo  "  
   cQuery +=" from "+RetSqlName("SE2")+" SE2,(select DISTINCT EA_NUMBOR,  EA_DATABOR ,EA_MODELO FROM "+RetSqlName("SEA")+" SEA "
   cQuery +=" WHERE EA_FILIAL = '"+xFilial("SEA")+"' AND sea.d_E_L_E_T_ = ' ' AND EA_DATABOR >= '" +dtos(dDtInc)+"' "
   cQuery +=" AND EA_DATABOR <= '"+dtos(dDtFim) +"' AND EA_CART = 'P' "
   If !empty (cProtador)
      cQuery +="and  EA_PORTADO = '"+cProtador+"'"
   EndIf    
   If !empty (cTNãoSair) 
      cQuery +=" AND EA_MODELO NOT IN "+FormatIn(cTNãoSair, ",")
   EndIF
   If !empty (cTSair) 
      cQuery +=" AND EA_MODELO IN "+FormatIn(cTSair, ",") 
   EndIF                      
   If !empty (cBNãoSair) 
      cQuery +=" AND EA_NUMBOR NOT IN "+FormatIn(cBNãoSair, ",")
   EndIF 
   If !empty (cBSair) 
      cQuery +=" AND EA_NUMBOR IN "+FormatIn(cBSair, ",") 
   EndIF
   cQuery +=" ) sea WHERE e2_filial =  '"+xFilial("SE2")+"' AND SE2.d_e_L_E_T_ = ' ' AND e2_numbor In ( sea.EA_NUMBOR ) " 
   
   //-----------------------------------------------------------------------------------------------------------------
   //Angelo Henrique - Data: 16/01/2020
   //-----------------------------------------------------------------------------------------------------------------
   //Conforme colicitação da Marcia Victer é necessário que sejam exibidas todos os tipos de impostos, 
   //para que a capa do relatório esteja com o mesmo valor apresentado aqui
   //-----------------------------------------------------------------------------------------------------------------
   
   //cQuery +=" AND E2_TIPO in ('TX' , 'INS','ISS') "
   //cQuery +=" AND E2_TIPO in ('TX' , 'INS','ISS', 'IRF', 'FGT') "
   cQuery +=" AND E2_TIPO in ('TX' , 'INS','ISS', 'IRF', 'FGT') "
   
   //-----------------------------------------------------------------------------------------------------------------
    
   If Select("TMP4") > 0
      dbSelectArea("TMP4")
      dbclosearea()
   Endif                                                                                                          
   TCQuery cQuery Alias "TMP4" New
   dbSelectArea("TMP4")
   tmp4->(dbGoTop())     
 if tmp4->(!EOF())  
   While tmp4->(!EOF()) 
	 If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
	    nLin  := Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)                                         
     Endif                                           
	  nLin++                                                                        
    @ nLin,000 PSAY tmp4->Tit           
    if mv_par14 = 1              
      @ nLin,040 PSAY TMP4->Saldo   Picture "@E 999,999,999.99" 
    else                                                      
      @ nLin,040 PSAY TMP4->valliq1 Picture "@E 999,999,999.99" 
    EndIf                                                                                                
    if mv_par14 = 1                                       
      Vlcomp +=TMP4->Saldo  
    else                                                      
      Vlcomp +=TMP4->valliq1  
    EndIf                   
      tmp4->(dbSkip()) 
  EndDo    
 vltotger+=Vlcomp                                                                     
 EndIf    
EndIf 
    //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
    //³ Reembolso   -   sintetica        ......                             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
                             
   cabec1:= "Reembolso                                      Valor    " 
//           123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//                    1         2         3         4         5         6         7         8
   Cabec2:= ' ' 
   VlCompt :=0.00    
   VlComp  :=0.00      
       
   cQuery :="  select  'Reembolso' ,  SUM (ROUND(E2_VALLIQ + E2_SDACRES, 2)) VALLIQ1, SUM (E2_SALDO-e2_SDDECRE+E2_SDACRES) Saldo " // Sum (E2_VALOR+E2_ACRESC-E2_DECRESC) Saldo "
   cQuery +=" from "+RetSqlName("SE2")+" SE2 ,(select DISTINCT EA_NUMBOR,  EA_DATABOR ,EA_MODELO FROM "+RetSqlName("SEA")+" SEA "
   cQuery +=" WHERE EA_FILIAL = '"+xFilial("SEA")+"' AND sea.d_E_L_E_T_ = ' ' AND EA_DATABOR >= '" +dtos(dDtInc)+"' "
   cQuery +=" AND EA_DATABOR <= '"+dtos(dDtFim) +"' AND EA_CART = 'P' "
   If !empty (cProtador)
      cQuery +="and  EA_PORTADO = '"+cProtador+"'"
   EndIf    
   If !empty (cTNãoSair) 
      cQuery +=" AND EA_MODELO NOT IN "+FormatIn(cTNãoSair, ",")
   EndIF
   If !empty (cTSair) 
      cQuery +=" AND EA_MODELO IN "+FormatIn(cTSair, ",") 
   EndIF                      
   If !empty (cBNãoSair) 
      cQuery +=" AND EA_NUMBOR NOT IN "+FormatIn(cBNãoSair, ",")
   EndIF 
   If !empty (cBSair) 
      cQuery +=" AND EA_NUMBOR IN "+FormatIn(cBSair, ",") 
   EndIF
   cQuery +=" ) sea WHERE e2_filial =  '"+xFilial("SE2")+"' AND d_e_L_E_T_ = ' ' AND e2_numbor In ( sea.EA_NUMBOR ) " 
   cQuery +=" and e2_PREFIXO  IN   ('RLE','DEV') AND E2_TIPO = 'REM' group by substr (e2_pllote, 1,6) , e2_prefixo  order by substr (e2_pllote, 1,6) , e2_prefixo " 
   If Select("TMP4") > 0
      dbSelectArea("TMP4")
      dbclosearea()
   Endif                                                                                                          
   TCQuery cQuery Alias "TMP4" New
   dbSelectArea("TMP4")
   tmp4->(dbGoTop())   
   
 if tmp4->(!EOF())  
   
  While tmp4->(!EOF())
	 If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
	    nLin  := Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)                                         
     Endif                                           
  	  nLin++
    @ nLin,000 PSAY "Reembolso "           
    if mv_par14 = 1              
      @ nLin,040 PSAY TMP4->Saldo   Picture "@E 999,999,999.99" 
    else                                                      
      @ nLin,040 PSAY TMP4->valliq1 Picture "@E 999,999,999.99" 
    EndIf                                                                                                
    if mv_par14 = 1                                       
      Vlcomp +=TMP4->Saldo  
    else                                                      
      Vlcomp +=TMP4->valliq1  
    EndIf                   

    tmp4->(dbSkip()) 
  EndDo   
   vltotger+=Vlcomp                                 
EndIf  
    //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
    //³ Incicio pa  - Sintetico         ......                             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
   cabec1:= "Tipo                                              Valor    " 
//           123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//                    1         2         3         4         5         6         7         8
   Cabec2:= ' '   
   VlCompt :=0.00    
   VlComp  :=0.00      

   cQuery :="  select  'PA' Tit, SUM (ROUND(E2_VALLIQ + E2_SDACRES , 2)) VALLIQ1, SUM (E2_SALDO-e2_SDDECRE+E2_SDACRES) Saldo " // Sum (E2_VALOR+E2_ACRESC-E2_DECRESC) Saldo  "  
   cQuery +=" from "+RetSqlName("SE2")+" SE2,(select DISTINCT EA_NUMBOR,  EA_DATABOR ,EA_MODELO FROM "+RetSqlName("SEA")+" SEA "
   cQuery +=" WHERE EA_FILIAL = '"+xFilial("SEA")+"' AND sea.d_E_L_E_T_ = ' ' AND EA_DATABOR >= '" +dtos(dDtInc)+"' "
   cQuery +=" AND EA_DATABOR <= '"+dtos(dDtFim) +"' AND EA_CART = 'P' "
   If !empty (cProtador)
      cQuery +="and  EA_PORTADO = '"+cProtador+"'"
   EndIf    
   If !empty (cTNãoSair) 
      cQuery +=" AND EA_MODELO NOT IN "+FormatIn(cTNãoSair, ",")
   EndIF
   If !empty (cTSair) 
      cQuery +=" AND EA_MODELO IN "+FormatIn(cTSair, ",") 
   EndIF                      
   If !empty (cBNãoSair) 
      cQuery +=" AND EA_NUMBOR NOT IN "+FormatIn(cBNãoSair, ",")
   EndIF 
   If !empty (cBSair) 
      cQuery +=" AND EA_NUMBOR IN "+FormatIn(cBSair, ",") 
   EndIF
   cQuery +=" ) sea WHERE e2_filial =  '"+xFilial("SE2")+"' AND SE2.d_e_L_E_T_ = ' '  AND e2_numbor In ( sea.EA_NUMBOR ) " 
   cQuery +=" and e2_tipo = 'PA'   AND E2_PREFIXO <> 'SPA' "
   
   If Select("TMP4") > 0
      dbSelectArea("TMP4")
      dbclosearea()
   Endif                                                                                                          
   TCQuery cQuery Alias "TMP4" New
   dbSelectArea("TMP4")
   tmp4->(dbGoTop())     
 If tmp4->(!EOF())  
   While tmp4->(!EOF()) 
     If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
	    nLin  := Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)                                         
     Endif                                           
	  nLin++                                                                        
    @ nLin,000 PSAY tmp4->Tit           
	if mv_par14 = 1              
      @ nLin,040 PSAY TMP4->Saldo   Picture "@E 999,999,999.99" 
    else                                                      
      @ nLin,040 PSAY TMP4->valliq1 Picture "@E 999,999,999.99" 
    EndIf                                                                                                
    if mv_par14 = 1                                       
      Vlcomp +=TMP4->Saldo  
    else                                                      
      Vlcomp +=TMP4->valliq1  
    EndIf                   

      tmp4->(dbSkip()) 
  EndDo     
    vltotger+=Vlcomp                               
EndIF  
////////

   cabec1:= "GPE                Valor    " 
//           123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//                  1         2         3         4         5         6         7         8
   Cabec2:= ' '   
   VlCompt :=0.00    
   VlComp  :=0.00      

   cQuery :="  select  'GPE' Tit, SUM (ROUND(E2_VALLIQ + E2_SDACRES, 2)) VALLIQ1, SUM (E2_SALDO-e2_SDDECRE+E2_SDACRES) Saldo " // Sum (E2_VALOR+E2_ACRESC-E2_DECRESC) Saldo  "  
   cQuery +=" from "+RetSqlName("SE2")+" SE2,(select DISTINCT EA_NUMBOR,  EA_DATABOR ,EA_MODELO FROM "+RetSqlName("SEA")+" SEA "
   cQuery +=" WHERE EA_FILIAL = '"+xFilial("SEA")+"' AND sea.d_E_L_E_T_ = ' ' AND EA_DATABOR >= '" +dtos(dDtInc)+"' "
   cQuery +=" AND EA_DATABOR <= '"+dtos(dDtFim) +"' AND EA_CART = 'P' "
   If !empty (cProtador)
      cQuery +="and  EA_PORTADO = '"+cProtador+"'"
   EndIf    
   If !empty (cTNãoSair) 
      cQuery +=" AND EA_MODELO NOT IN "+FormatIn(cTNãoSair, ",")   
   EndIF
   If !empty (cTSair)   
      cQuery +=" AND EA_MODELO IN "+FormatIn(cTSair, ",") 
   EndIF                      
   If !empty (cBNãoSair) 
      cQuery +=" AND EA_NUMBOR NOT IN "+FormatIn(cBNãoSair, ",")  
   EndIF 
   If !empty (cBSair) 
      cQuery +=" AND EA_NUMBOR IN "+FormatIn(cBSair, ",") 
   EndIF
   cQuery +=" ) sea WHERE e2_filial =  '"+xFilial("SE2")+"' AND SE2.d_e_L_E_T_ = ' '  AND e2_numbor In ( sea.EA_NUMBOR ) " 
   //cQuery +=" and e2_tipo IN ('PEN', 'RES')   AND E2_PREFIXO = 'GPE' "
   cQuery +=" and e2_tipo not in ('FGT','TX', 'IRF', 'INS')
   cQuery +=" AND E2_PREFIXO = 'GPE' "
   If Select("TMP4") > 0
      dbSelectArea("TMP4")
      dbclosearea()
   Endif                                                                                                          
   TCQuery cQuery Alias "TMP4" New
   dbSelectArea("TMP4")
   tmp4->(dbGoTop())     
 If tmp4->(!EOF())  
   While tmp4->(!EOF()) 
     If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
	    nLin  := Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)                                         
     Endif                                           
	  nLin++                                                                        
    @ nLin,000 PSAY tmp4->Tit           
	if mv_par14 = 1              
      @ nLin,040 PSAY TMP4->Saldo   Picture "@E 999,999,999.99" 
    else                                                      
      @ nLin,040 PSAY TMP4->valliq1 Picture "@E 999,999,999.99" 
    EndIf                                                                                                
    if mv_par14 = 1                                       
      Vlcomp +=TMP4->Saldo  
    else                                                      
      Vlcomp +=TMP4->valliq1  
    EndIf                   

      tmp4->(dbSkip()) 
  EndDo     
    vltotger+=Vlcomp                               
EndIF  


////// TAXA ADMINSTRATIVA 

  cabec1:= "TAXA ADM.          Valor    " 
//           123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//                  1         2         3         4         5         6         7         8
   Cabec2:= ' '   
   VlCompt :=0.00    
   VlComp  :=0.00      

   cQuery :="  select  'TAXA ADM' Tit, SUM (ROUND(E2_VALLIQ + E2_SDACRES, 2)) VALLIQ1, SUM (E2_SALDO-e2_SDDECRE+E2_SDACRES) Saldo " // Sum (E2_VALOR+E2_ACRESC-E2_DECRESC) Saldo  "  
   cQuery +=" from "+RetSqlName("SE2")+" SE2,(select DISTINCT EA_NUMBOR,  EA_DATABOR ,EA_MODELO FROM "+RetSqlName("SEA")+" SEA "
   cQuery +=" WHERE EA_FILIAL = '"+xFilial("SEA")+"' AND sea.d_E_L_E_T_ = ' ' AND EA_DATABOR >= '" +dtos(dDtInc)+"' "
   cQuery +=" AND EA_DATABOR <= '"+dtos(dDtFim) +"' AND EA_CART = 'P' "
   If !empty (cProtador)
      cQuery +="and  EA_PORTADO = '"+cProtador+"'"
   EndIf    
   If !empty (cTNãoSair) 
      cQuery +=" AND EA_MODELO NOT IN "+FormatIn(cTNãoSair, ",")   
   EndIF
   If !empty (cTSair)   
      cQuery +=" AND EA_MODELO IN "+FormatIn(cTSair, ",") 
   EndIF                      
   If !empty (cBNãoSair) 
      cQuery +=" AND EA_NUMBOR NOT IN "+FormatIn(cBNãoSair, ",")  
   EndIF 
   If !empty (cBSair) 
      cQuery +=" AND EA_NUMBOR IN "+FormatIn(cBSair, ",") 
   EndIF
   cQuery +=" ) sea WHERE e2_filial =  '"+xFilial("SE2")+"' AND SE2.d_e_L_E_T_ = ' '  AND e2_numbor In ( sea.EA_NUMBOR ) " 
   //cQuery +=" and e2_tipo IN ('PEN', 'RES')   AND E2_PREFIXO = 'GPE' "
   --cQuery +=" and e2_tipo not in ('FGT','TX')
   cQuery +=" AND E2_PREFIXO = 'TAD' "
   If Select("TMP4") > 0
      dbSelectArea("TMP4")
      dbclosearea()
   Endif                                                                                                          
   TCQuery cQuery Alias "TMP4" New
   dbSelectArea("TMP4")
   tmp4->(dbGoTop())     
 If tmp4->(!EOF())  
   While tmp4->(!EOF()) 
     If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
	    nLin  := Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)                                         
     Endif                                           
	  nLin++                                                                        
    @ nLin,000 PSAY tmp4->Tit           
	if mv_par14 = 1              
      @ nLin,040 PSAY TMP4->Saldo   Picture "@E 999,999,999.99" 
    else                                                      
      @ nLin,040 PSAY TMP4->valliq1 Picture "@E 999,999,999.99" 
    EndIf                                                                                                
    if mv_par14 = 1                                       
      Vlcomp +=TMP4->Saldo  
    else                                                      
      Vlcomp +=TMP4->valliq1  
    EndIf                   

      tmp4->(dbSkip()) 
  EndDo     
    vltotger+=Vlcomp                               
EndIF  


/////////////////////////
////// JURIDICO  

  cabec1:= "JURIDICO                   .          Valor    " 
//           123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//                  1         2         3         4         5         6         7         8
   Cabec2:= ' '   
   VlCompt :=0.00    
   VlComp  :=0.00      

   cQuery :="  select  'JURIDICO' Tit, SUM (ROUND(E2_VALLIQ  + E2_SDACRES , 2)) VALLIQ1, SUM (E2_SALDO-e2_SDDECRE+E2_SDACRES) Saldo " // Sum (E2_VALOR+E2_ACRESC-E2_DECRESC) Saldo  "  
   cQuery +=" from "+RetSqlName("SE2")+" SE2,(select DISTINCT EA_NUMBOR,  EA_DATABOR ,EA_MODELO FROM "+RetSqlName("SEA")+" SEA "
   cQuery +=" WHERE EA_FILIAL = '"+xFilial("SEA")+"' AND sea.d_E_L_E_T_ = ' ' AND EA_DATABOR >= '" +dtos(dDtInc)+"' "
   cQuery +=" AND EA_DATABOR <= '"+dtos(dDtFim) +"' AND EA_CART = 'P' "
   If !empty (cProtador)
      cQuery +="and  EA_PORTADO = '"+cProtador+"'"
   EndIf    
   If !empty (cTNãoSair) 
      cQuery +=" AND EA_MODELO NOT IN "+FormatIn(cTNãoSair, ",")   
   EndIF
   If !empty (cTSair)   
      cQuery +=" AND EA_MODELO IN "+FormatIn(cTSair, ",") 
   EndIF                      
   If !empty (cBNãoSair) 
      cQuery +=" AND EA_NUMBOR NOT IN "+FormatIn(cBNãoSair, ",")   
   EndIF 
   If !empty (cBSair) 
      cQuery +=" AND EA_NUMBOR IN "+FormatIn(cBSair, ",") 
   EndIF
   cQuery +=" ) sea WHERE e2_filial =  '"+xFilial("SE2")+"' AND SE2.d_e_L_E_T_ = ' '  AND e2_numbor In ( sea.EA_NUMBOR ) " 
   //cQuery +=" and e2_tipo IN ('PEN', 'RES')   AND E2_PREFIXO = 'GPE' "
   //cQuery +=" and e2_tipo not in ('FGT','TX') '
   cQuery +=" and e2_origem in ('CABA412') "
   cQuery +=" AND E2_PREFIXO IN ('JUD', 'JUT', 'RPD') "  
   If Select("TMP4") > 0
      dbSelectArea("TMP4")
      dbclosearea()
   Endif                                                                                                          
   TCQuery cQuery Alias "TMP4" New
   dbSelectArea("TMP4")
   tmp4->(dbGoTop())        
 If tmp4->(!EOF())  
   While tmp4->(!EOF()) 
     If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
	    nLin  := Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)                                         
     Endif                                           
	  nLin++                                                                        
    @ nLin,000 PSAY tmp4->Tit           
	if mv_par14 = 1              
      @ nLin,040 PSAY TMP4->Saldo   Picture "@E 999,999,999.99" 
    else                                                      
      @ nLin,040 PSAY TMP4->valliq1 Picture "@E 999,999,999.99" 
    EndIf                                                                                                
    if mv_par14 = 1                                       
      Vlcomp +=TMP4->Saldo    
    else                                                      
      Vlcomp +=TMP4->valliq1  
    EndIf                   

      tmp4->(dbSkip())   
  EndDo     
    vltotger+=Vlcomp                               
EndIF  


/////////////////////////
////// CADASTRO   
             
  cabec1:= "CADASTRO                   .          Valor    " 
//           123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//                  1         2         3         4         5         6         7         8
   Cabec2:= ' '   
   VlCompt :=0.00    
   VlComp  :=0.00      

   cQuery :="  select  'CADASTRO ' Tit, SUM (ROUND(E2_VALLIQ +E2_SDACRES , 2)) VALLIQ1, SUM (E2_SALDO-e2_SDDECRE+E2_SDACRES) Saldo " // Sum (E2_VALOR+E2_ACRESC-E2_DECRESC) Saldo  "  
   cQuery +=" from "+RetSqlName("SE2")+" SE2,(select DISTINCT EA_NUMBOR,  EA_DATABOR ,EA_MODELO FROM "+RetSqlName("SEA")+" SEA "
   cQuery +=" WHERE EA_FILIAL = '"+xFilial("SEA")+"' AND sea.d_E_L_E_T_ = ' ' AND EA_DATABOR >= '" +dtos(dDtInc)+"' "
   cQuery +=" AND EA_DATABOR <= '"+dtos(dDtFim) +"' AND EA_CART = 'P' "
   If !empty (cProtador)
      cQuery +="and  EA_PORTADO = '"+cProtador+"'"
   EndIf    
   If !empty (cTNãoSair) 
      cQuery +=" AND EA_MODELO NOT IN "+FormatIn(cTNãoSair, ",")   
   EndIF
   If !empty (cTSair)   
      cQuery +=" AND EA_MODELO IN "+FormatIn(cTSair, ",") 
   EndIF                      
   If !empty (cBNãoSair) 
      cQuery +=" AND EA_NUMBOR NOT IN "+FormatIn(cBNãoSair, ",")   
   EndIF 
   If !empty (cBSair) 
      cQuery +=" AND EA_NUMBOR IN "+FormatIn(cBSair, ",")   
   EndIF
   cQuery +=" ) sea WHERE e2_filial =  '"+xFilial("SE2")+"' AND SE2.d_e_L_E_T_ = ' '  AND e2_numbor In ( sea.EA_NUMBOR ) " 
   //cQuery +=" and e2_tipo IN ('PEN', 'RES')   AND E2_PREFIXO = 'GPE' "
   //cQuery +=" and e2_tipo not in ('FGT','TX') '
   cQuery +=" and e2_origem in ('CABA412') "
   cQuery +=" AND E2_PREFIXO = 'CAT' "
   If Select("TMP4") > 0
      dbSelectArea("TMP4")
      dbclosearea()
   Endif                                                                                                          
   TCQuery cQuery Alias "TMP4" New
   dbSelectArea("TMP4")
   tmp4->(dbGoTop())     
 If tmp4->(!EOF())  
   While tmp4->(!EOF()) 
     If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
	    nLin  := Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)                                         
     Endif                                           
	  nLin++                                                                        
    @ nLin,000 PSAY tmp4->Tit           
	if mv_par14 = 1              
      @ nLin,040 PSAY TMP4->Saldo   Picture "@E 999,999,999.99" 
    else                                                      
      @ nLin,040 PSAY TMP4->valliq1 Picture "@E 999,999,999.99" 
    EndIf                                                                                                
    if mv_par14 = 1                                       
      Vlcomp +=TMP4->Saldo    
    else                                                      
      Vlcomp +=TMP4->valliq1  
    EndIf                   

      tmp4->(dbSkip())   
  EndDo     
    vltotger+=Vlcomp                               
EndIF


////////
    //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
    //³ Incicio Financeiro  - Sintetico     .....                           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
   cabec1:= "Financeiro                Valor    " 
//           123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//                  1         2         3         4         5         6         7         8
   Cabec2:= ' ' 
   VlCompt :=0.00    
   VlComp  :=0.00        
    
   cQuery :="select  'Financeiro' Tit, SUM (ROUND(E2_VALLIQ + E2_SDACRES , 2)) VALLIQ1 ,  SUM (E2_SALDO-e2_SDDECRE+E2_SDACRES) Saldo " //Sum (E2_VALOR+E2_ACRESC-E2_DECRESC) Saldo  "  
   cQuery +=" from "+RetSqlName("SE2")+" SE2,(select DISTINCT EA_NUMBOR,  EA_DATABOR ,EA_MODELO FROM "+RetSqlName("SEA")+" SEA "
   cQuery +=" WHERE EA_FILIAL = '"+xFilial("SEA")+"' AND sea.d_E_L_E_T_ = ' ' AND EA_DATABOR >= '" +dtos(dDtInc)+"' "
   cQuery +=" AND EA_DATABOR <= '"+dtos(dDtFim) +"' AND EA_CART = 'P' "
   If !empty (cProtador)
      cQuery +="and  EA_PORTADO = '"+cProtador+"'"
   EndIf    
   If !empty (cTNãoSair) 
      cQuery +=" AND EA_MODELO NOT IN "+FormatIn(cTNãoSair, ",")
   EndIF
   If !empty (cTSair) 
      cQuery +=" AND EA_MODELO IN "+FormatIn(cTSair, ",") 
   EndIF                      
   If !empty (cBNãoSair) 
      cQuery +=" AND EA_NUMBOR NOT IN "+FormatIn(cBNãoSair, ",")
   EndIF 
   If !empty (cBSair) 
      cQuery +=" AND EA_NUMBOR IN "+FormatIn(cBSair, ",") 
   EndIF   
   
   cQuery +=" ) sea WHERE e2_filial =  '"+xFilial("SE2")+"' AND SE2.d_e_L_E_T_ = ' '  AND e2_numbor In ( sea.EA_NUMBOR ) " 
   cQuery +=" and e2_origem in ('FINA050')  and e2_tipo not in ('TX' , 'INS','ISS','NDF', 'TXA', 'RLE', 'PA') "
   cQuery +=" AND E2_NATUREZ <> 'OPME'
   If Select("TMP4") > 0
      dbSelectArea("TMP4")
      dbclosearea()
   Endif                                                                                                          
   TCQuery cQuery Alias "TMP4" New
   dbSelectArea("TMP4")
   tmp4->(dbGoTop())     
 if tmp4->(!EOF())  
   While tmp4->(!EOF()) 
     If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
	    nLin  := Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)                                         
     Endif                                           
	  nLin++                                                                        
    @ nLin,000 PSAY tmp4->Tit           
    if mv_par14 = 1              
      @ nLin,040 PSAY TMP4->Saldo   Picture "@E 999,999,999.99" 
    else                                                      
      @ nLin,040 PSAY TMP4->valliq1 Picture "@E 999,999,999.99" 
    EndIf                                                                                                
    if mv_par14 = 1                                       
      Vlcomp +=TMP4->Saldo  
    else                                                      
      Vlcomp +=TMP4->valliq1  
    EndIf                   

      tmp4->(dbSkip()) 
  EndDo    
    vltotger+=Vlcomp                                
EndIF
   //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
    //³ Incicio Financeiro  - Sintetico     .....                           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
   cabec1:= "Compras                   Valor    " 
//           123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//                  1         2         3         4         5         6         7         8
   Cabec2:= ' ' 
   VlCompt :=0.00    
   VlComp  :=0.00        
    
   cQuery :="select  'Compras' Tit, SUM (ROUND(E2_VALLIQ + E2_SDACRES , 2)) VALLIQ1 ,  SUM (E2_SALDO-e2_SDDECRE+E2_SDACRES) Saldo " //Sum (E2_VALOR+E2_ACRESC-E2_DECRESC) Saldo  "  
   cQuery +=" from "+RetSqlName("SE2")+" SE2,(select DISTINCT EA_NUMBOR,  EA_DATABOR ,EA_MODELO FROM "+RetSqlName("SEA")+" SEA "
   cQuery +=" WHERE EA_FILIAL = '"+xFilial("SEA")+"' AND sea.d_E_L_E_T_ = ' ' AND EA_DATABOR >= '" +dtos(dDtInc)+"' "
   cQuery +=" AND EA_DATABOR <= '"+dtos(dDtFim) +"' AND EA_CART = 'P' "
   If !empty (cProtador)
      cQuery +="and  EA_PORTADO = '"+cProtador+"'"
   EndIf    
   If !empty (cTNãoSair) 
      cQuery +=" AND EA_MODELO NOT IN "+FormatIn(cTNãoSair, ",")
   EndIF
   If !empty (cTSair) 
      cQuery +=" AND EA_MODELO IN "+FormatIn(cTSair, ",") 
   EndIF                      
   If !empty (cBNãoSair) 
      cQuery +=" AND EA_NUMBOR NOT IN "+FormatIn(cBNãoSair, ",")
   EndIF 
   If !empty (cBSair) 
      cQuery +=" AND EA_NUMBOR IN "+FormatIn(cBSair, ",") 
   EndIF   
   
   cQuery +=" ) sea WHERE e2_filial =  '"+xFilial("SE2")+"' AND SE2.d_e_L_E_T_ = ' '  AND e2_numbor In ( sea.EA_NUMBOR ) " 
   cQuery +=" and e2_origem in ('MATA100')  and e2_tipo not in ('TX' , 'INS','ISS','NDF', 'TXA', 'RLE', 'PA') "
   cQuery +=" AND E2_NATUREZ <> 'OPME'
   If Select("TMP4") > 0
      dbSelectArea("TMP4")
      dbclosearea()
   Endif                                                                                                          
   TCQuery cQuery Alias "TMP4" New
   dbSelectArea("TMP4")
   tmp4->(dbGoTop())     
 if tmp4->(!EOF())  
   While tmp4->(!EOF()) 
     If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
	    nLin  := Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)                                         
     Endif                                           
	  nLin++                                                                        
    @ nLin,000 PSAY tmp4->Tit           
    if mv_par14 = 1              
      @ nLin,040 PSAY TMP4->Saldo   Picture "@E 999,999,999.99" 
    else                                                      
      @ nLin,040 PSAY TMP4->valliq1 Picture "@E 999,999,999.99" 
    EndIf                                                                                                
    if mv_par14 = 1                                       
      Vlcomp +=TMP4->Saldo  
    else                                                      
      Vlcomp +=TMP4->valliq1  
    EndIf                   

      tmp4->(dbSkip()) 
  EndDo    
    vltotger+=Vlcomp                                
EndIF
    //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
    //³ Incicio OPME  - Sintetico     .....                                 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
   cabec1:= "OPME                Valor    " 
//           123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//                  1         2         3         4         5         6         7         8
   Cabec2:= ' ' 
   VlCompt :=0.00    
   VlComp  :=0.00        
    
   cQuery :="select  'OPME' Tit, SUM (ROUND(E2_VALLIQ + E2_SDACRES, 2)) VALLIQ1, SUM (E2_SALDO-e2_SDDECRE+E2_SDACRES) Saldo " //Sum (E2_VALOR+E2_ACRESC-E2_DECRESC) Saldo  "  
   cQuery +=" from "+RetSqlName("SE2")+" SE2,(select DISTINCT EA_NUMBOR,  EA_DATABOR ,EA_MODELO FROM "+RetSqlName("SEA")+" SEA "
   cQuery +=" WHERE EA_FILIAL = '"+xFilial("SEA")+"' AND sea.d_E_L_E_T_ = ' ' AND EA_DATABOR >= '" +dtos(dDtInc)+"' "
   cQuery +=" AND EA_DATABOR <= '"+dtos(dDtFim) +"' AND EA_CART = 'P' "
   If !empty (cProtador)
      cQuery +="and  EA_PORTADO = '"+cProtador+"'"
   EndIf    
   If !empty (cTNãoSair) 
      cQuery +=" AND EA_MODELO NOT IN "+FormatIn(cTNãoSair, ",")
   EndIF
   If !empty (cTSair) 
      cQuery +=" AND EA_MODELO IN "+FormatIn(cTSair, ",") 
   EndIF                      
   If !empty (cBNãoSair) 
      cQuery +=" AND EA_NUMBOR NOT IN "+FormatIn(cBNãoSair, ",")
   EndIF 
   If !empty (cBSair) 
      cQuery +=" AND EA_NUMBOR IN "+FormatIn(cBSair, ",") 
   EndIF   
   
   cQuery +=" ) sea WHERE e2_filial =  '"+xFilial("SE2")+"' AND SE2.d_e_L_E_T_ = ' '  AND e2_numbor In ( sea.EA_NUMBOR ) " 
   cQuery +=" and e2_origem in ('FINA050','MATA100')  and e2_tipo not in ('TX' , 'INS','ISS','NDF', 'TXA', 'RLE', 'PA') "
   cQuery +=" AND E2_NATUREZ = 'OPME' "
   If Select("TMP4") > 0
      dbSelectArea("TMP4")
      dbclosearea()
   Endif                                                                                                          
   TCQuery cQuery Alias "TMP4" New
   dbSelectArea("TMP4")
   tmp4->(dbGoTop())     
 if tmp4->(!EOF())  
   While tmp4->(!EOF()) 
     If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
	    nLin  := Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)                                         
     Endif                                           
	  nLin++                                                                        
    @ nLin,000 PSAY tmp4->Tit           
    if mv_par14 = 1              
      @ nLin,040 PSAY TMP4->Saldo   Picture "@E 999,999,999.99" 
    else                                                      
      @ nLin,040 PSAY TMP4->valliq1 Picture "@E 999,999,999.99" 
    EndIf                                                                                                
    if mv_par14 = 1                                       
      Vlcomp +=TMP4->Saldo  
    else                                                      
      Vlcomp +=TMP4->valliq1  
    EndIf                   

      tmp4->(dbSkip()) 
  EndDo                                   
    vltotger+=Vlcomp  
    
EndIF
    //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
    //³ Incicio Comissao  - Sintetico     .....                                 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
   cabec1:= "Comissao                Valor    " 
//           123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//                  1         2         3         4         5         6         7         8
   Cabec2:= ' ' 
   VlCompt :=0.00    
   VlComp  :=0.00        
    
   cQuery :="select  'Comissao' Tit, SUM (ROUND(E2_VALLIQ + E2_SDACRES , 2)) VALLIQ1 , SUM (E2_SALDO-e2_SDDECRE+E2_SDACRES) Saldo " //Sum (E2_VALOR+E2_ACRESC-E2_DECRESC) Saldo  "  
   cQuery +=" from "+RetSqlName("SE2")+" SE2,(select DISTINCT EA_NUMBOR,  EA_DATABOR ,EA_MODELO FROM "+RetSqlName("SEA")+" SEA "
   cQuery +=" WHERE EA_FILIAL = '"+xFilial("SEA")+"' AND sea.d_E_L_E_T_ = ' ' AND EA_DATABOR >= '" +dtos(dDtInc)+"' "
   cQuery +=" AND EA_DATABOR <= '"+dtos(dDtFim) +"' AND EA_CART = 'P' "
   If !empty (cProtador)
      cQuery +="and  EA_PORTADO = '"+cProtador+"'"
   EndIf    
   If !empty (cTNãoSair) 
      cQuery +=" AND EA_MODELO NOT IN "+FormatIn(cTNãoSair, ",")
   EndIF
   If !empty (cTSair) 
      cQuery +=" AND EA_MODELO IN "+FormatIn(cTSair, ",") 
   EndIF                      
   If !empty (cBNãoSair) 
      cQuery +=" AND EA_NUMBOR NOT IN "+FormatIn(cBNãoSair, ",")
   EndIF 
   If !empty (cBSair) 
      cQuery +=" AND EA_NUMBOR IN "+FormatIn(cBSair, ",") 
   EndIF   
   
   cQuery +=" ) sea WHERE e2_filial =  '"+xFilial("SE2")+"' AND SE2.d_e_L_E_T_ = ' '  AND e2_numbor In ( sea.EA_NUMBOR ) " 
   cQuery +=" and (e2_origem in ('PLSM152') OR E2_PREFIXO = 'COM') and e2_tipo not in ('TX' , 'INS','ISS','NDF', 'TXA', 'RLE', 'PA') "
   cQuery +=" AND E2_PREFIXO = 'COM' "
   If Select("TMP4") > 0
      dbSelectArea("TMP4")
      dbclosearea()
   Endif                                                                                                          
   TCQuery cQuery Alias "TMP4" New
   dbSelectArea("TMP4")
   tmp4->(dbGoTop())     
 if tmp4->(!EOF())  
   While tmp4->(!EOF()) 
     If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
	    nLin  := Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)                                         
     Endif                                           
	  nLin++                                                                        
    @ nLin,000 PSAY tmp4->Tit           
    if mv_par14 = 1              
      @ nLin,040 PSAY TMP4->Saldo   Picture "@E 999,999,999.99" 
    else                                                      
      @ nLin,040 PSAY TMP4->valliq1 Picture "@E 999,999,999.99" 
    EndIf                                                                                                
    if mv_par14 = 1                                       
      Vlcomp +=TMP4->Saldo  
    else                                                      
      Vlcomp +=TMP4->valliq1  
    EndIf                   
      tmp4->(dbSkip()) 
  EndDo                                   
    vltotger+=Vlcomp    
EndIF  
//////altamiro 26/06/19 começo 

    //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
    //³ Incicio Financeiro  - Sintetico     .....                           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
   cabec1:= "Financeiro                Valor    " 
//           123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//                  1         2         3         4         5         6         7         8
   Cabec2:= ' ' 
   VlCompt :=0.00    
   VlComp  :=0.00        
   nValliq := 0.00 
   nsaldo  := 0.00 
   //cQuery :="select  'Fatura ' Tit, SUM (ROUND(E2_VALLIQ , 2)) VALLIQ1 ,  SUM (ROUND(E2_SALDO-e2_SDDECRE,2)) Saldo " //Sum (E2_VALOR+E2_ACRESC-E2_DECRESC) Saldo  "  
   cQuery :="select  'Fatura ' Tit, E2_VALLIQ valliq1 , E2_SDACRES  SDACRES , E2_SALDO saldo , e2_SDDECRE SDDECRE "
   cQuery +=" from "+RetSqlName("SE2")+" SE2,(select DISTINCT EA_NUMBOR,  EA_DATABOR ,EA_MODELO FROM "+RetSqlName("SEA")+" SEA "
   cQuery +=" WHERE EA_FILIAL = '"+xFilial("SEA")+"' AND sea.d_E_L_E_T_ = ' ' AND EA_DATABOR >= '" +dtos(dDtInc)+"' "
   cQuery +=" AND EA_DATABOR <= '"+dtos(dDtFim) +"' AND EA_CART = 'P' "
   If !empty (cProtador)
      cQuery +="and  EA_PORTADO = '"+cProtador+"'"  
   EndIf    
   If !empty (cTNãoSair) 
      cQuery +=" AND EA_MODELO NOT IN "+FormatIn(cTNãoSair, ",")
   EndIF
   If !empty (cTSair) 
      cQuery +=" AND EA_MODELO IN "+FormatIn(cTSair, ",") 
   EndIF                      
   If !empty (cBNãoSair) 
      cQuery +=" AND EA_NUMBOR NOT IN "+FormatIn(cBNãoSair, ",")
   EndIF 
   If !empty (cBSair) 
      cQuery +=" AND EA_NUMBOR IN "+FormatIn(cBSair, ",") 
   EndIF   
   
   cQuery +=" ) sea WHERE e2_filial =  '"+xFilial("SE2")+"' AND SE2.d_e_L_E_T_ = ' '  AND e2_numbor In ( sea.EA_NUMBOR ) " 
   cQuery +=" and e2_origem in ('FINA290','FINA290M','FINA565')  and e2_tipo not in ('TX' , 'INS','ISS','NDF', 'TXA', 'RLE', 'PA') "
   cQuery +=" AND E2_NATUREZ <> 'OPME'
   If Select("TMP4") > 0
      dbSelectArea("TMP4")
      dbclosearea()
   Endif                                                                                                          
   TCQuery cQuery Alias "TMP4" New
   dbSelectArea("TMP4")
   tmp4->(dbGoTop())     
   ctit:= tmp4->Tit
 if tmp4->(!EOF())    
  While tmp4->(!EOF())
     nValliq += (tmp4->VALLIQ1 + tmp4->SDACRES) - tmp4->SDDECRE 
     nsaldo  += (tmp4->saldo  + tmp4->SDACRES) - tmp4->SDDECRE
     tmp4->(dbSkip())
   EndDo    
     If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
	    nLin  := Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)                                         
     Endif                                           
	  nLin++                                                                        
    @ nLin,000 PSAY ctit         
    if mv_par14 = 1              
      @ nLin,040 PSAY nSaldo   Picture "@E 999,999,999.99" 
    else                                                      
      @ nLin,040 PSAY nvalliq Picture "@E 999,999,999.99" 
    EndIf                                                                                                
    if mv_par14 = 1                                       
      Vlcomp +=nSaldo  
    else                                                      
      Vlcomp +=nvalliq  
    EndIf                    
  
    vltotger+=Vlcomp                                
EndIF

////// Fim altamiro 25/06/19
    nLin++
  @ nLin,000 PSay replicate("_",080)      
    nLin++       
  @ nLin,040 PSAY "Total Geral   -----> "  
  @ nLin,062 PSAY vltotger     Picture "@E 999,999,999.99"  
  nLin++  
  @ nLin,000 PSay replicate("_",080) 
  vltotger:=0.00     
  nLin++
 
EndIf                    
                 
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Conferencia Pagamento Medico...                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ       
    cabec1:= "Origem     Titulo           Fornecedor                                    Valor" 
//           123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//                    1         2         3         4         5         6         7         8         
//           PLSMPAGMED.xxxxxxxxxxxxxxx.xxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx.999,999,999.99
   Cabec2:= ' '   
   VlCompt :=0.00    
   VlComp  :=0.00      

   cQuery :="  select E2_ORIGEM , E2_PREFIXO ,e2_Num,  E2_TIPO , E2_EMISSAO , e2_fornece , e2_nomfor, SUM (ROUND(E2_VALLIQ +E2_SDACRES , 2)) VALLIQ1, SUM (ROUND(E2_SALDO-e2_SDDECRE+E2_SDACRES,2)) Saldo " 

   cQuery +=" from "+RetSqlName("SE2")+" SE2,(select DISTINCT EA_NUMBOR,  EA_DATABOR ,EA_MODELO FROM "+RetSqlName("SEA")+" SEA "
   cQuery +=" WHERE EA_FILIAL = '"+xFilial("SEA")+"' AND sea.d_E_L_E_T_ = ' ' AND EA_DATABOR >= '" +dtos(dDtInc)+"' "
   cQuery +=" AND EA_DATABOR <= '"+dtos(dDtFim) +"' AND EA_CART = 'P' "
   If !empty (cProtador)
      cQuery +="and  EA_PORTADO = '"+cProtador+"'"
   EndIf    
   If !empty (cTNãoSair) 
      cQuery +=" AND EA_MODELO NOT IN "+FormatIn(cTNãoSair, ",")
   EndIF
   If !empty (cTSair) 
      cQuery +=" AND EA_MODELO IN "+FormatIn(cTSair, ",") 
   EndIF                      
   If !empty (cBNãoSair) 
      cQuery +=" AND EA_NUMBOR NOT IN "+FormatIn(cBNãoSair, ",")
   EndIF 
   If !empty (cBSair) 
      cQuery +=" AND EA_NUMBOR IN "+FormatIn(cBSair, ",") 
   EndIF
   cQuery +=" ) sea WHERE e2_filial =  '"+xFilial("SE2")+"' AND SE2.d_e_L_E_T_ = ' '  AND e2_numbor In ( sea.EA_NUMBOR ) " 

   cQuery +=" and trim(e2_ORIGEM)||trim(E2_PREFIXO) not in ('CAB007RLE' , 'GPEM670GPE' , 'FINA050FIN' ,'FINA050JUD' ,  'FINA050SPA' , 'FINA050DPJ' , 'FINA050BO' , 'FINA050AXF' , 'MATA100UNI' ,"	 
   cQuery +=" 'PLSMPAGCLI' , 'PLSMPAGODN' , 'PLSMPAGOPE' , 'PLSMPAGLAB' , 'PLSMPAGMED' , 'PLSMPAGCOM' , 'PLSMPAGINT' , 'PLSMPAGNUP' , 'PLSMPAGCON' , 'PLSMPAGREM' ,  "  
  
   cQuery +=" 'PLSMPAGMAT' , 'CABADEV' , 'FINA280FAT' , 'FINA290FAT' , 'FINA290MFAT' , 'FIN' , "  
   
   //------------------------------------------------------------------------------------------
   //Angelo Henrique - Data: 24/03/2020
   //------------------------------------------------------------------------------------------
   //Após virada para a versão 12 do PROTHEUS, esta sendo utilizada a rotina
   //de liquidação por fatura, acrescentando aqui sua chamada para que não demonstre a 
   //fatura em local errado
   //------------------------------------------------------------------------------------------
    cQuery +=" 'FINA565' , "
  
   cQuery +=" 'PLSMPAGSVD' , 'PLSMPAGHOS' , 'PLSM152COM' , 'PLSMPAGAED', 'PLSMPAGPOL' , 'PLSMPAGCOJ', 'PLSMPAGCOA') AND  e2_tipo not in ('TX' , 'INS','ISS','NDF', 'TXA', 'FT')    "

   cQuery +="  group by E2_ORIGEM , E2_PREFIXO ,e2_Num,  E2_TIPO , E2_EMISSAO , e2_fornece , e2_nomfor "


   If Select("TMP4") > 0
      dbSelectArea("TMP4")
      dbclosearea()
   Endif                                                                                                          
   TCQuery cQuery Alias "TMP4" New
   dbSelectArea("TMP4")
   tmp4->(dbGoTop())     
 If tmp4->(!EOF())      
    lCritica := .T.
    if nLin < 55   
       nLin++
       @ nLin,000 PSAY cabec1
       nLin++
       @ nLin,000 PSay replicate("_",080) 
    EndIf 
   While tmp4->(!EOF()) 
     If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
	    nLin  := Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)                                         
     Endif                                           
	  nLin++                                                                        
    @ nLin,000 PSAY '***  '+tmp4->E2_ORIGEM+" "+tmp4->E2_PREFIXO+" "+tmp4->e2_Num+" "+tmp4->E2_TIPO+" "+tmp4->e2_fornece+"-"+Substr(tmp4->e2_nomfor,1,30)          
	if mv_par14 = 1              
      @ nLin,067 PSAY TMP4->Saldo   Picture "@E 999,999,999.99" 
    else                                                      
      @ nLin,067 PSAY TMP4->valliq1 Picture "@E 999,999,999.99" 
    EndIf                                                                                                
      tmp4->(dbSkip())  
  EndDo     
EndIF   
nLin++           
If !lCritica     
     @ nLin,000 PSAY "     ** Titulos Destes Bordero de Pagamento Foram Certificados ** "
else                                                                                 
     @ nLin,000 PSAY "     ** Titulos Destes Bordero de Pagamento NÃO Certificados ** "
EndIf           
if mv_par20 = 2	  
   DlgToExcel({{"ARRAY","Compossição dos Titulos " ,aCabec1,aSaidCom}})
 EndIf 
/* Static Function ConfPgtoMed() */             
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

cBNãoSair:= mv_par08          
cBSair   := mv_par09
                 

Static Function ValidPerg()

Local aAreaAtu := GetArea()
Local aRegs    := {}
Local i,j

DbSelectArea("SX1")
dbSetOrder(1)
           
/*c_Perg := PADR(cPerg,10)      

PutSx1( c_Perg ,"01","Data De           ?","","","mv_ch1","D",08,0,0,"G","                                     ","      ","S","","mv_par01","        ","","","    ","           ","","","         ","","","","","","","","",{},{},{},"")
PutSx1( c_Perg ,"02","Data Ate          ?","","","mv_ch2","D",08,0,0,"G","                                     ","      ","S","","mv_par02","        ","","","    ","           ","","","         ","","","","","","","","",{},{},{},"")
PutSx1( c_Perg ,"03","Mostra Composição ?","","","mv_ch3","N",01,0,0,"G","                                     ","      ","S","","mv_par03","        ","","","    ","           ","","","         ","","","","","","","","",{},{},{},"")
PutSx1( c_Perg ,"04","Movimen. Não Sair  ","","","mv_ch4","C",02,0,0,"G","                                     ","      ","S","","mv_par04","        ","","","    ","           ","","","         ","","","","","","","","",{},{},{},"")
PutSx1( c_Perg ,"05","Carteira          ?","","","mv_ch5","C",06,0,0,"G","                                     ","BAUPLS","S","","mv_par05","        ","","","    ","           ","","","         ","","","","","","","","",{},{},{},"")
*/
cPerg := PADR(cPerg,10)

aAdd(aRegs,{cPerg,"01","Data De             ?","","","mv_ch01","D",08,0,0,"G","","mv_par01",""        ,"","","","",""         ,"","","","","","","","","","","","","","","","","","","US2","" })
aAdd(aRegs,{cPerg,"02","Data Ate            ?","","","mv_ch02","D",08,0,0,"G","","mv_par02",""        ,"","","","",""         ,"","","","","","","","","","","","","","","","","","","US2","" })
aAdd(aRegs,{cPerg,"03","Mostra Composição   ?","","","mv_ch03","N",01,0,0,"c","","mv_par03","Não Mostra" ,"","","","","Titulos","","","","","Bordero","","","","","Ambos","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"04","Tipo há  Não Sair    ","","","mv_ch04","C",60,0,0,"G","","mv_par04",""        ,"","","","",""         ,"","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"05","Listar Bordero      ?","","","mv_ch05","N",01,0,0,"c","","mv_par05","Sim"     ,"","","","","Não"      ,"","","","","","","","","","","","","","","","","","","",""}) 
aAdd(aRegs,{cPerg,"06","Sub-total           ?","","","mv_ch06","N",01,0,0,"c","","mv_par06","Sim"     ,"","","","","Não"      ,"","","","","","","","","","","","","","","","","","","",""}) 
aAdd(aRegs,{cPerg,"07","Listar Cheques      ?","","","mv_ch07","N",01,0,0,"c","","mv_par07","Sim"     ,"","","","","Não"      ,"","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"08","Bordero há Não Sair  ","","","mv_ch08","C",60,0,0,"G","","mv_par08",""        ,"","","","",""         ,"","","","","","","","","","","","","","","","","","","",""})  
aAdd(aRegs,{cPerg,"09","Bordero há  Sair     ","","","mv_ch09","C",60,0,0,"G","","mv_par09",""        ,"","","","",""         ,"","","","","","","","","","","","","","","","","","","",""}) 
aAdd(aRegs,{cPerg,"10","Tipo há Sair         ","","","mv_ch10","C",60,0,0,"G","","mv_par10",""        ,"","","","",""         ,"","","","","","","","","","","","","","","","","","","",""}) 
aAdd(aRegs,{cPerg,"11","Do Banco             ","","","mv_ch11","C",05,0,0,"G","","mv_par11",""        ,"","","","",""         ,"","","","","","","","","","","","","","","","","","","",""}) 
aAdd(aRegs,{cPerg,"12","Resumo Gerencial    ?","","","mv_ch12","N",01,0,0,"c","","mv_par12","Sim"     ,"","","","","Não"      ,"","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"13","Detalha Lançamentos ?","","","mv_ch13","N",01,0,0,"c","","mv_par13","Sim"     ,"","","","","Não"      ,"","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"14","Bordero Já Baixado  ?","","","mv_ch14","N",01,0,0,"c","","mv_par14","Não"     ,"","","","","Sim"      ,"","","","","","","","","","","","","","","","","","","","" , "" , "", "", "" }) 
aAdd(aRegs,{cPerg,"15","Lanç.Por Competencia?","","","mv_ch15","N",01,0,0,"c","","mv_par15","Não"     ,"","","","","Sim"      ,"","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"16","Most. Valores Compet?","","","mv_ch16","N",01,0,0,"c","","mv_par16","Não"     ,"","","","","Sim"      ,"","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"17","Mostrar impostos    ?","","","mv_ch17","N",01,0,0,"c","","mv_par17","Não"     ,"","","","","Sim"      ,"","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"18","Mostrar Deb/cred    ?","","","mv_ch18","N",01,0,0,"c","","mv_par18","Não"     ,"","","","","Sim"      ,"","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"19","Mostrar Resumo      ?","","","mv_ch19","N",01,0,0,"c","","mv_par19","Não"     ,"","","","","Sim"      ,"","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"20","Gerar excel         ?","","","mv_ch20","N",01,0,0,"c","","mv_par20","Não"     ,"","","","","Sim"      ,"","","","","","","","","","","","","","","","","","","",""})


//aadd(aRegs,{cPerg,"15","Conf. Pagto Medico   ?","","","mv_ch15" ,"N",01,0,0,"c","","mv_par15","Não"     ,"","","","","Sim"        ,"","","","","","","","","","","","","","","","","","","" ,"" , "" , "", "", "" })
For i:=1 to Len(aRegs)
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
