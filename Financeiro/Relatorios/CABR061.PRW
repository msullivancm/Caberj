#INCLUDE "protheus.ch"  
//#INCLUDE 'UTILIDADES.CH'
#INCLUDE "topconn.ch"
//#INCLUDE "rwmake.ch"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ CABA061  บ Autor ณ Altamiro Affonso   บ Data ณ  16/11/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Criticas de pagamento de comiss~ใo                         บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP6 IDE                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
User Function CABR061

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Declaracao de Variaveis                                             ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

Local cDesc1         := "Este programa tem como objetivo fazer A critica das inconsist๊ncias no pagamento de comissao  "
Local cDesc2         := "listando todos os registro que tenham nivel de cobran็a na familia , que nao tenhan vendedor peenchido  "
Local cDesc3         := " "
Local cPict          := ""
Local titulo         := "Critica de pagamento da comissao " 
Local nLin           := 220 															

Local Cabec1         := " Matricula            Nome / Idade                         Parc   Vlr.Base   Vlr.Com.  %Com.   Num.Titulo          Niv. Cobran็a     Cod.Vend   Cod.Vend2  Cod.Equ  TipInc Comissao  Plano  Titulo a Pagar       Dt Inclusใo"
//                       1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//                       0        1         2         3         4         5         6         7         8         9         10        11        12        13        14        15        16        17        18        19        20        21        22
//                       XXXX.XXXX.XXXXXX.XX-X XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX       XXX  999.999,99  99.999,99  999,99  XXX-99999999-X-XXX  XXXXXXXXXX        XXXXXX      XXXXXX      XXX            XXX
                                                                                                                                                                 
Local Cabec2         := " "
Local imprime        := .T.
Local aOrd           := {}
Private lEnd         := .F.
Private lAbortPrint  := .F.
Private CbTxt        := ""
Private limite       := 220
Private tamanho      := "G"
Private nomeprog     := "CABR061"
Private nTipo        := 15
Private aReturn      := { "Zebrado", 1, "Administracao", 1, 2, 1, "", 1}
Private nLastKey     := 0
Private cbtxt        := Space(10)
Private cbcont       := 00
Private CONTFL       := 01
Private m_pag        := 01
Private wnrel        := "CABR061"
Private cString      := "BM1"
Private cPerg        := "CABR061"
Private vlr_tot      := 0.00  
Private vlr_Sald     := 0.00                                                                      
Private cquebra      := " " 
Private lflagtot     :=.F.
private cNovGrpPag   := " "     
private cnome        := ' '
private nMACob      := ' '                                                   
private nMADev      := ' '                                                         
private Ntotcob     := 0.00
private Ntotcom     := 0.00  
private Nttotcob    := 0.00
private Nttotcom    := 0.00        
private NEtotcob    := 0.00
private NEtotcom    := 0.00 
private NTcontTit   := 0
private NEcontTit   := 0     
private NtotNf      := 0.00
private totDevbas   := 0.00  
private totDevcom   := 0.00    
private contDev     := 0       
private NnumTit     := ' '
private cseq        := ' '                  
private Ncont       := 0        
private NcontTit    := 0  
private CNomEmp     := ' '   
private lPVez       := .F. 
private atotal      := {}

private NTotES      := 0     
private NTotAnES    := 0    
private sDtCont     := ' '      

Private vlrtotCom   := 0.00  
Private vlrTotSCom  := 0.00    
Private NVarIncES   := 0.00                                                                  


dbSelectArea("BM1")
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

Local cQuery 	:= ' '
Local n_I		:= 0    

Local x := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
                                      
dbSelectArea(cString)
dbSetOrder(1)

SetRegua(0)

For n_I := 1 to 5
	IncRegua()
Next
     
//pega titulos de cobran็a
If Mv_Par14 = 1
   cQuery1 := " select distinct e1_prefixo , e1_num , e1_tipo , e1_cliente ,e1_nomcli ,e1_EMISSAO , E1_VENCREA,  e1_baixa , e1_valor , e1_saldo "
   cQuery1 += " from "+ RetSqlName('SE1') +" SE1 , "+ RetSqlName('BXQ') +" bxq "
   cQuery1 += " where e1_filial =  '"+xFilial("SE1")+"'  and se1.d_E_L_E_T_ = ' ' and bxq_filial =  '"+xFilial("BXQ")+"' and bxq.d_E_L_E_T_ = ' ' " 
   If !empty (mv_par01)
       cQuery1 += " and bxq_codemp = '"+mv_par01+"' "
   EndIf               
   If !empty (mv_par02)
       cQuery1 += " and bXQ_ano = '"+mv_par02+"' "
   EndIf               
   If !empty (mv_par03)    
       cQuery1 += " and bXQ_mes = '"+mv_par03+"'" 
   EndIf                           
   
   If !Empty(mv_par19)
    cQuery1 += "   AND BXQ_NUMCON = '" + mv_par19 + "'" 					 																						
   EndIf   
 
   If !Empty(mv_par20)
    cQuery1 += "   AND BXQ_subcon = '" + mv_par20 + "'" 					 																						
   EndIf   

   cQuery1 += "and bxq_prefix = e1_prefixo and bxq_num = e1_num  and bxq_tipo = e1_tipo  and bxq_numpar <> '999' "

   If Select(("TMP1")) <> 0 
       ("TMP1")->(DbCloseArea())  
   Endif
   
   TCQuery cQuery1 Alias "TMP1" New 
   dbSelectArea("TMP1")
   tmp1->(dbGoTop())                                         
 
   While !TMP1->(EOF())                                                           
     	  If nLin > 65 // Salto de Pแgina. Neste caso o formulario tem 55 linhas...
     	     nLin :=	Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
	         nLin ++                                   
	         @ nLin,000 psay "Prefixo    Numero     Tipo  Cliente                                            Dt Emissao  Dt Vencim.    Dt Baixa           Valor          Saldo"
//                             XXX      XXXXXXXXX   XX   XXXXXX - XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX  XX/XX/XXXX  XX/XX/XXXX    XX/XX/XXXX  99.999,999.99  99.999,999.99
//                            1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//                            0        1         2         3         4         5         6         7         8         9         10        11        12        13        14        15        16        17        18        19        20        21        22
             nLin ++
             @ nLin,000 PSay replicate("_",220)                                                                                                                 
             nLin ++                                                                                                                             
          Endif  
          @ nLin,002 PSay tmp1->e1_prefixo 
          @ nLin,011 PSay tmp1->e1_num 
          @ nLin,023 PSay tmp1->e1_tipo                                                                                 
          @ nLin,028 PSay tmp1->e1_cliente+' - '+tmp1->e1_nomcli                                                         
          @ nlin,079 psay substr(tmp1->e1_emissao,7,2)+'/'+substr(tmp1->e1_emissao,5,2)+'/'+substr(tmp1->e1_emissao,1,4)    
          @ nlin,091 psay substr(tmp1->e1_vencrea,7,2)+'/'+substr(tmp1->e1_vencrea,5,2)+'/'+substr(tmp1->e1_vencrea,1,4)   
          @ nlin,105 psay substr(tmp1->e1_baixa,7,2)+'/'+substr(tmp1->e1_baixa,5,2)+'/'+substr(tmp1->e1_baixa,1,4)   
          @ nLin,117 PSay  tmp1->e1_valor  Picture "@E 99999,999.99"  
  	      @ nLin,129 PSay  tmp1->e1_saldo Picture "@E 9999,999.99" 
          tmp1->(dbSkip())  
         nLin ++       
   EndDo                                                                                                                                                                                                                                                                  
   @ nLin,000 PSay replicate("_",220)                                                                                                                 
   nLin ++                                                                                                                             
EndIf               

///////   
if mv_par15 = 1  
 cQuery1 := " Select distinct bxo_codemp   , bxo_codequ, bxo_codven , bxp_qtdde , bxp_qtdate , bxp_percon , bxj_Yidisn  idadLim  "
 cQuery1 +=CRLF+ " From "+ RetSqlName('BXP') +" bxp , "+ RetSqlName('BXO') +" bxO , "+ RetSqlName('BXQ') +" bxq , " + RetSqlName("BXJ") +" BXJ  "


 cQuery1 += " Where bxo_filial = '"+xFilial("BXO")+"' and bxo.d_E_L_E_T_ = ' ' and bxp_filial = '"+xFilial(+"BXP")+"' and bxp.d_E_L_E_T_ = ' ' "
 cQuery1 += "   and bxq_filial = '"+xFilial("BXQ")+"' and bxq.d_E_L_E_T_ = ' ' and bxp_seqbxo = bxo_seq and bxq_seqbxo = bxo_seq "
 cQuery1 +="    and BXJ_filial = '"+xFilial('BXJ')+ "'  and bxj.d_E_L_E_T_ = ' ' "
 
/*	cQuery +=CRLF+"            and bxo_codemp = '"+cCodEmpM+"' "
	cQuery +=CRLF+"            and bxo_codven = '"+cCodVenM+"' " */

	cQuery1 += "            and bxj_seq    = bxo_seqbxj  AND BXQ_REFERE = BXQ_PAGCOM"
	

 if !empty (mv_par01)
     cQuery1 += " and bxq_codemp = '"+mv_par01+"' "
 EndIf               
 if !empty (mv_par02)
     cQuery1 += " and bxq_ano = '"+mv_par02+"' "
 EndIf               
 if !empty (mv_par03)    
     cQuery1 += " and bxq_mes = '"+mv_par03+"'" 
 EndIf    
          
  If !Empty(mv_par19)
    cQuery1 += "   AND BXQ_NUMCON = '" + mv_par19 + "'" 					 																						
   EndIf   
 
If !Empty(mv_par20)
    cQuery1 += "   AND BXQ_subcon = '" + mv_par20 + "'" 					 																						
EndIf 
         
 cQuery1 += " order by  bxo_codemp   , bxo_codequ, bxo_codven ,   bxp_qtdde "

 If Select(("TMP1")) <> 0 
       ("TMP1")->(DbCloseArea())  
 Endif
    TCQuery cQuery1 Alias "TMP1" New 
    dbSelectArea("TMP1")
    tmp1->(dbGoTop())                                         
    While !TMP1->(EOF())                                                           
     	  If nLin > 65 // Salto de Pแgina. Neste caso o formulario tem 55 linhas...
     	     nLin :=	Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
	         nLin ++         
	      EndIf   
	      If !lPVez
	         @ nLin,000 psay "                             Empresa   Vendedor  Equipe  Parc de    Parc ate                 %  "
//                                                           XXXX     XXXXXX     XXX      XXX         XXX     XXX
//                            1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//                            0        1         2         3         4         5         6         7         8         9         10        11        12        13        14        15        16        17        18        19        20        21        22
             nLin ++
             @ nLin,000 PSay replicate("_",220)                                                                                                                 
             nLin ++        
             lPVez :=.T.                                                                                                                     
          Endif  
          @ nLin,032 PSay tmp1->bxo_codemp 
          @ nLin,041 PSay tmp1->bxo_codven
          @ nLin,052 PSay tmp1->bxo_codequ                                                                                 
          @ nLin,061 PSay StrZero(tmp1->bxp_qtdde,3)                                                         
          @ nlin,073 psay StrZero(tmp1->bxp_qtdate,3)
          @ nlin,091 psay tmp1->bxp_percon 
          @ nlin,093 psay "%" 
          tmp1->(dbSkip())
            
         nLin ++       
    EndDo                                                                                                                                                                                                                                                                  
    @ nLin,000 PSay replicate("_",220)                                                                                                                 
    nLin ++    
/////////////////nova aba 
lPVez :=.F.   

cQuery1 := " SELECT BXQ_CODEMP   , BXQ_CODEQU , BXQ_CODVEN , BXQ_MES||'/'|| BXQ_ANO REFER , BXQ_NUMPAR, BXQ_PERCOM  , "
cQuery1 += " SUM (CASE WHEN BXQ_BASCOM <  0  THEN 1 ELSE 0 END ) QTDA_MENOR ,  SUM (CASE WHEN BXQ_BASCOM >= 0  THEN 1 ELSE 0 END ) QTDA_MAIOR  , "   
cQuery1 += " SUM (CASE WHEN BXQ_BASCOM <  0  THEN BXQ_BASCOM ELSE 0 END ) BAS_MENOR ,  SUM (CASE WHEN BXQ_BASCOM >= 0  THEN BXQ_BASCOM ELSE 0 END ) BAS_MAIOR  ,"
cQuery1 += " SUM (CASE WHEN BXQ_BASCOM <  0  THEN BXQ_VLRCOM ELSE 0 END ) COM_MENOR ,  SUM (CASE WHEN BXQ_VLRCOM >= 0  THEN BXQ_VLRCOM ELSE 0 END ) COM_MAIOR  "
cQuery1 += " From "+ RetSqlName('BXq') +" bxq  Where bxq_filial = '"+xFilial("BXq")+"' and bxq.d_E_L_E_T_ = ' ' and bxq_refere = bxq_pagcom "
 if !empty (mv_par01)
     cQuery1 += " and bxq_codemp = '"+mv_par01+"' "
 EndIf               
 if !empty (mv_par02)
     cQuery1 += " and bxq_ano = '"+mv_par02+"' "
 EndIf               
 if !empty (mv_par03)    
     cQuery1 += " and bxq_mes = '"+mv_par03+"'" 
 EndIf    
  If !Empty(mv_par19)
    cQuery1 += "   AND BXQ_NUMCON = '" + mv_par19 + "'" 					 																						
   EndIf   
If !Empty(mv_par20)
    cQuery1 += "   AND BXQ_subcon = '" + mv_par20 + "'" 					 																						
EndIf 
    cQuery1 += " GROUP BY BXQ_CODEMP   , BXQ_CODEQU , BXQ_CODVEN , BXQ_MES||'/'|| BXQ_ANO ,  BXQ_NUMPAR, BXQ_PERCOM ORDER BY 1,3,4,5 "
       

 If Select(("TMP1")) <> 0 
       ("TMP1")->(DbCloseArea())  
 Endif
    TCQuery cQuery1 Alias "TMP1" New 
    dbSelectArea("TMP1")
    tmp1->(dbGoTop())                                         
    While !TMP1->(EOF())                                                           
     	  If nLin > 65 // Salto de Pแgina. Neste caso o formulario tem 55 linhas...
     	     nLin :=	Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
	         nLin ++         
	      EndIf   
	      If !lPVez    
	         @ nLin,000 psay "                             Empresa   Vendedor  Equipe     Refer       Num. Parc        %          Qtde                   Base          Comissใo           "
//                                                           XXXX     XXXXXX     XXX      XX\XXXX        XXX      XXX     9.XXX
//                            1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//                            0        1         2         3         4         5         6         7         8         9         10        11        12        13        14        15        16        17        18        19        20        21        22
             nLin ++
             @ nLin,000 PSay replicate("_",220)                                                                                                                 
             nLin ++        
             lPVez :=.T.                                                                                                                     
          Endif                   
          If  tmp1->QTDA_MENOR > 0
	          @ nLin,032 PSay tmp1->bxQ_codemp 
	          @ nLin,041 PSay tmp1->bxQ_codven
	          @ nLin,052 PSay tmp1->bxQ_codequ                                                                                 
	          @ nLin,061 PSay tmp1->REFER   
	          @ nLin,077 PSay tmp1->BXQ_NUMPAR
	          @ nlin,086 psay '-' 
	          @ nlin,087 psay tmp1->bxQ_percom 
	          @ nlin,091 psay "%"       
              @ nlin,099 psay tmp1->QTDA_MENOR Picture "@E 9,999"+"-"           
              @ nlin,117 psay tmp1->BAS_MENOR Picture "@E 999,999.99" 
              @ nlin,135 psay tmp1->COM_MENOR Picture "@E 999,999.99" 
              nLin ++
	      EndIf 
	      If  tmp1->QTDA_MAIOR > 0
	          @ nLin,032 PSay tmp1->bxQ_codemp 
	          @ nLin,041 PSay tmp1->bxQ_codven
	          @ nLin,052 PSay tmp1->bxQ_codequ                                                                                 
	          @ nLin,061 PSay tmp1->REFER   
	          @ nLin,077 PSay tmp1->BXQ_NUMPAR
	          @ nlin,087 psay tmp1->bxQ_percom 
	          @ nlin,091 psay "%"       
              @ nlin,099 psay tmp1->QTDA_MAIOR Picture "@E 9,999"
              @ nlin,117 psay tmp1->BAS_MAIOR Picture "@E 999,999.99" 
              @ nlin,135 psay tmp1->COM_MAIOR Picture "@E 999,999.99" 

              nLin ++
	      EndIf     
          tmp1->(dbSkip())  
    EndDo                                                                                                                                                                                                                                                                  
    @ nLin,000 PSay replicate("_",220)                                                                                                                 
    nLin ++    
EndIf               
                
/// evolu็ใo do contrato vidas 
if mv_par21 = 1
	lPVez :=.F.  
	cQuery1 := "  SELECT BA1_DATBLO DAT, ba1_motblo motblo , ( COUNT( * )*-1) QTDA FROM "+ RetSqlName('Ba1') +" ba1  ,"+ RetSqlName('Ba3') +" ba3 "  
	cQuery1 += "   WHERE  ba1_filial = '"+xFilial("Ba1")+"' and ba1.d_E_L_E_T_ = ' ' and ba3_filial = '"+xFilial("Ba3")+"' and ba3.d_E_L_E_T_ = ' ' "
	if !empty (mv_par01)
	    cQuery1 += " and ba1_codemp = '"+mv_par01+"' "
	EndIf   
	If !Empty(mv_par19)
	    cQuery1 += "   AND Ba1_CONemp = '" + mv_par19 + "'" 					 																						
	EndIf   
	If !Empty(mv_par20)
	    cQuery1 += "   AND Ba1_subcon = '" + mv_par20 + "'" 					 																						
	EndIf                                                   
	cQuery1 += " AND BA1_CODINT = BA3_CODINT and BA1_CODEMP = BA3_CODEMP and BA1_MATRIC = BA3_MATRIC "
	cQuery1 += " AND BA1_DATBLO <> ' ' and ba1_motblo  <> ' '  and BA3_COBNIV = '0' GROUP BY BA1_DATBLO, ba1_motblo  "
		 
	cQuery1 += "UNION 
		
	cQuery1 += "  SELECT BA1_DATINC DAT, ba1_motblo motblo ,  COUNT( * ) QTDA FROM "+ RetSqlName('Ba1') +" ba1  ,"+ RetSqlName('Ba3') +" ba3 " 
	cQuery1 += "   WHERE  ba1_filial = '"+xFilial("Ba1")+"' and ba1.d_E_L_E_T_ = ' ' and ba3_filial = '"+xFilial("Ba3")+"' and ba3.d_E_L_E_T_ = ' '
	if !empty (mv_par01)
	    cQuery1 += " and ba1_codemp = '"+mv_par01+"' "
	EndIf   
	If !Empty(mv_par19)
	    cQuery1 += "   AND Ba1_CONemp = '" + mv_par19 + "'" 					 																						
	EndIf   
	If !Empty(mv_par20)
	    cQuery1 += "   AND Ba1_subcon = '" + mv_par20 + "'" 					 																						
	EndIf  
	cQuery1 += " AND BA1_CODINT = BA3_CODINT and BA1_CODEMP = BA3_CODEMP and BA1_MATRIC = BA3_MATRIC and BA3_COBNIV = '0' " 
 	cQuery1 += " AND BA1_DATBLO =  ' ' 	 "
	cQuery1 += " GROUP BY BA1_DATINC , ba1_motblo  order by 1,2 "                                                    
	
		
	If Select(("TMP1")) <> 0 
	          ("TMP1")->(DbCloseArea())  
	Endif
	TCQuery cQuery1 Alias "TMP1" New 
	dbSelectArea("TMP1")
	tmp1->(dbGoTop())                                         
	While !TMP1->(EOF())  
	      cdata := tmp1->dat          
	      If tmp1->QTDA > 0 
	         qtdapos:=tmp1->QTDA
	         qtdaneg:=0
	      Else                  
		     qtdaneg:=tmp1->QTDA
		     qtdapos:=0
	      EndIf           
		  If (nAscan:=Ascan(atotal , {|e| e[1]+e[2] == cdata+tmp1->motblo })) == 0     
		      Aadd(atotal , {tmp1->dat   ,;               
              tmp1->motblo ,;		      
		      qtdapos ,;
		      qtdaneg })   
	      Else     
		    If qtdapos > 0
		       atotal[nAscan,3]+=qtdapos
		    EndIf       
		    If qtdaneg > 0
		       atotal[nAscan,4]+=qtdaneg
		    EndIf                       
	      EndIf  
		  tmp1->(dbSkip())  
	EndDo                                                                                                                                                                                                                                                                  
		                      
	For x := 1 To Len(atotal)                                                  
	 	  If nLin > 65 // Salto de Pแgina. Neste caso o formulario tem 55 linhas...      
/*	 	     if  NTotES > 0    
	 	         If sDtCont == substr( atotal[(x+1),1],1,6)
	               @ (nlin-1),084 psay NTotES Picture "@E 9,999"   
                   @ (nlin-1),96 psay ((NTotES /NTotAnES)-1 )*100 Picture "@E 999.99"      
    	        EndIf 
	         EndIf */
	   	     nLin :=	Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
	         nLin ++      
	         lPVez :=.F. 
	         
	      EndIf   
	      If !lPVez    
	         @ nLin,000 psay "                             Data    Qtda Entrada          Qtda Saida              Tot.Vidas      Varia็ใo Mensal %   Var.Inicial/Final %  "
		//                                                      XX/XX/XXXX         XXXX              XXXX
		//                    1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
		//                    0        1         2         3         4         5         6         7         8         9         10        11        12        13        14        15        16        17        18        19        20        21        22
	           nLin ++
		     @ nLin,000 PSay replicate("_",220)                                                                                                                 
		       nLin ++        
		       lPVez   := .T.    
		       if Len( atotal ) != x    
		          sDtCont := substr(atotal[x,1],1,6)                                                                                                             
		       Else          
		          sDtCont := ' ' 
		       Endif    
		       
		  Endif  
   		  @ nLin,010 PSay atotal[x,2]     		     
   		  @ nLin,026 PSay stod(atotal[x,1])     
		  @ nlin,044 psay atotal[x,3] Picture "@E 99,999"
		  @ nlin,064 psay atotal[x,4] Picture "@E 99,999"  
		    NTotES := NTotES + (atotal[x,3] + atotal[x,4])     
		  if Len( atotal ) != x    
      	     If sDtCont != substr( atotal[(x+1),1],1,6)   .or. nLin = 65
                @ nlin,084 psay NTotES Picture "@E 99,999"    
                If  NTotAnES > 0                             
                    @ nlin,96 psay ((NTotES /NTotAnES) - 1 )*100 Picture "@E 9999.99%"     
                    NTotAnES := NTotES                                     
                Else
                    @ nlin,96 psay 0.00000  Picture "@E 9999.99%" 
                    NVarIncES :=  NTotES   
                EndIf      
                NTotAnES := NTotES                 
                sDtCont := substr(atotal[(x+1),1] ,1,6)         	 
             EndIf   
          Else                                        
             @ nlin,084 psay NTotES Picture "@E 99,999" 
             @ nlin,96 psay ((NTotES /NTotAnES) - 1 )*100 Picture "@E 9999.99%"       
             @ (nlin),120 psay ((NTotES /NVarIncES)-1 )*100 Picture "@E 99999.99%" 
          EndIf	 
		       
		  nLin ++  
	Next                                                                                                                                                                                                                                                                  
	@ nLin,000 PSay replicate("_",220)                                                                                                                 
	  nLin ++ 
    @ nLin,000 psay " * Varia็ใo Mensal ้ o percentual de varia็ใo de um m๊s para o seguinte"
      nLin ++ 
    @ nLin,000 psay " ** Var.Inicial/Final ้ o percentual de varia็ใo do primeiro m๊s comparado com o ultimo m๊s "
  	  nLin ++                                                                                                                                                                                                                                                                                   
  	@ nLin,000 PSay replicate("_",220)                                                                                                                 
	  
EndIf   

/////// totaliza codigos de faturamento    
If mv_par17 == 1   
   
	 lPVez        := .F. 
	 
	 //Leonardo Portella - 23/01/14 - Inicio - Quando for Credito devera ter valor negativo na Comissao, conforme o relatorio Crystal ANACON - Chamado ID 9579
	
	 //cQuery1 := "SELECT BM1_CODEMP, BM1_NUMTIT, BM1_ANO, BM1_MES ,BM1_CODTIP ,BM1_DESTIP ,DECODE (BFQ_COMISS, '1','SIM','NAO') COMISSAO ,SUM (BM1_VALOR) TOTAL" 	+ CRLF
	 cQuery1 := "SELECT BM1_CODEMP, BM1_NUMTIT, BM1_ANO, BM1_MES ,BM1_CODTIP ,BM1_DESTIP ,DECODE (BFQ_COMISS, '1','SIM','NAO') COMISSAO ,DECODE(BA3_COBNIV,'0',' EMPRESA','1',' FAMILIA',' EMPRESA' ) NVL_COB , "
	 cQuery1 += " SUM(BM1_VALOR * DECODE(BM1_TIPO,'2',-1,1)) TOTAL " 																		+ CRLF
	 
 	 //ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	 //ณBM1_TIPO = '1' -- DEBITO ณ
	 //ณBM1_TIPO = '2' -- CREDITOณ
	 //ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		 
	 //Leonardo Portella - 23/01/14 - Fim
	 	 
	 cQuery1 += " FROM "+ RetSqlName('BM1') +" BM1 , "+ RetSqlName('BFQ') +" BFQ , " + RetSqlName('BA3') +" BA3 "							+ CRLF
	 cQuery1 += " WHERE BM1_FILIAL = '" + xFilial("BM1") + "'" 																				+ CRLF 
	 cQuery1 += "  AND BM1.D_E_L_E_T_ = ' '" 																								+ CRLF  
	 cQuery1 += "  AND BFQ_FILIAL = '" + xFilial("BFQ") + "'" 																				+ CRLF  
	 cQuery1 += "  AND BFQ.D_E_L_E_T_ = ' ' " 																								+ CRLF
	 
	 
	 cQuery1 += "  AND Ba3_FILIAL = '" + xFilial("BFQ") + "'" 																				+ CRLF  
	 cQuery1 += "  AND Ba3.D_E_L_E_T_ = ' ' " 																								+ CRLF
	 
	 cQuery1 += "  AND BM1_CODEMP = '" + mv_par01 + "'" 																					+ CRLF  
	 cQuery1 += "  AND BM1_ANO = '" + mv_par02 + "'" 																						+ CRLF  
	 cQuery1 += "  AND BM1_MES = '" + mv_par03 + "'" 																						+ CRLF  
	 cQuery1 += "  AND BM1_CODTIP NOT IN ('108')" 																							+ CRLF    
	 cQuery1 += "  AND BM1_CODTIP = BFQ_PROPRI||BFQ_CODLAN " 																				+ CRLF  
	 
	 cQuery1 += "  AND BM1_CODINT||BM1_CODEMP||BM1_MATRIC = BA3_CODINT||BA3_CODEMP||BA3_MATRIC" 											+ CRLF 
	
	 If mv_par18 == 1      
	     cQuery1 += "   AND BFQ_COMISS = '1'"																								+ CRLF
	 EndIf     
	 
	 If !Empty(mv_par19)
        cQuery1 += "   AND BM1_conemp = '" + mv_par19 + "'" 					 															+ CRLF
     EndIf   
 
     If !Empty(mv_par20)
        cQuery1 += "   AND BM1_subcon = '" + mv_par20 + "'" 					 															+ CRLF
     EndIf   
	
	 cQuery1 += "GROUP BY BM1_CODEMP, BM1_NUMTIT, BM1_ANO ,BM1_MES  ,BM1_CODTIP ,BM1_DESTIP, BFQ_COMISS , BA3_COBNIV "						+ CRLF
	 cQuery1 += "ORDER BY 1,2,5"																											+ CRLF
	 
	 If Select(("TMP1")) <> 0 
	       ("TMP1")->(DbCloseArea())  
	 EndIf 
 
    TcQuery cQuery1 Alias "TMP1" New 
    DbSelectArea("TMP1")
    tmp1->(dbGoTop()) 
                                            
    While !TMP1->(EOF())
                                                          
     	  If nLin > 65 // Salto de Pแgina. Neste caso o formulario tem 55 linhas...
     	     nLin :=	Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
	         nLin ++ 
	         lPVez := .F.        
	      EndIf
	       
	      If !lPVez      
	 
	         @ nLin,000 psay "                             Empresa     Num. Tit.   Ano/Mes    Cod     Descri็ใo              Cod.Comissใo               total      Nivel Cob "
//                                                           XXXX     XXXXXX     XXX     XXX         XXX     XXX
//                            1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//                            0        1         2         3         4         5         6         7         8         9         10        11        12        13        14        15        16        17        18        19        20        21        22
             nLin ++
             @ nLin,000 PSay replicate("_",220)                                                                                                                 
             nLin ++        
             lPVez :=.T.                                                                                                                     
          Endif   
          @ nLin,032 PSay tmp1->bm1_codemp                            
          @ nLin,042 PSay tmp1->bm1_numtit                            
          @ nLin,054 PSay tmp1->bm1_ano +'/'+ tmp1->bm1_mes  
          @ nLin,065 PSay tmp1->bm1_codtip                                                                                
          @ nLin,073 PSay substr(tmp1->bm1_DESTIP,1,20)  
          @ nLin,104 PSay tmp1->COMISSAO                                                              
          @ nlin,114 psay tmp1->total Picture "@E 99999,999.99"     
          @ nLin,131 PSay tmp1->NVL_COB     
          NtotNf += tmp1->total   
          if tmp1->COMISSAO == 'SIM'.and. tmp1->NVL_COB == ' EMPRESA'      
             vlrtotCom      := vlrtotCom  + tmp1->total  
          Else 
             vlrTotSCom     := vlrTotSCom + tmp1->total  
          EndIf    
           
          tmp1->(dbSkip())  
          nLin ++       
    EndDo       
    
    @ nLin,000 PSay replicate("_",220)   
     nLin ++                                                                                                                                                                                                                                                                                
    @ nLin,020 PSAY  'Totais Geral Valores Nf '
    @ nLin,055 PSay  NtotNf     Picture "@E 99,999,999.99" 
    @ nLin,070 PSAY  'Totais Com Comissao'               
    @ nLin,095 PSay  vlrtotCom  Picture "@E 99,999,999.99"      
    @ nLin,110 PSAY  'Totais Sem Comissao'               
    @ nLin,130 PSay  vlrtotSCom Picture "@E 99,999,999.99" 
   	nLin ++     // Avanca a linha de impressao    
    @ nLin,000 PSay replicate("_",220)                                                                                                                 
    nLin ++  
                                                                                                                               
EndIf               
          
///// discrimina็ใo da comissใo 
If Mv_Par22 == 1         // endif linha 1103
cQuery := "SELECT DISTINCT " 																																	+ CRLF
cQuery += "NVL(BXQ_CODINT,'')||'.'||NVL(BXQ_CODEMP,'')||'.'||NVL(BXQ_MATRIC,'')||'.'||NVL(BXQ_TIPREG,'')||'-'|| NVL(BXQ_DIGITO,'FALTA BXQ') MATRIC_COMISSAO," 	+ CRLF
cQuery += "BM1_CODINT ||'.'||BM1_CODEMP||'.'||BM1_MATRIC||'.'||BM1_TIPREG||'-'||BM1_DIGITO MATRIC_CADSTRO, BA1_NOMUSR NOME_USURARIO, SUM(BM1_VALOR * DECODE(BM1_TIPO,'2',-1,1)) VLR_COB," 	+ CRLF
//cQuery += "SUM(NVL(BXQ_VLRCOM,0.0)) VLR_COM, NVL(BXQ_PERCOM,0.0)||'%' PREC, BM1_PREFIX ||'-'||BM1_NUMTIT||'-'||BM1_PARCEL ||'-'||BM1_TIPO TIP_COM," 			+ CRLF  

cQuery += " NVL(BXQ_VLRCOM,0.0) VLR_COM, NVL(BXQ_PERCOM,0.0)||'%' PREC, BM1_PREFIX ||'-'||BM1_NUMTIT||'-'||BM1_PARCEL ||'-'|| BM1_TIPO TIP_COM," 			+ CRLF 

cQuery += " IDADE_S(TRIM(BA1.BA1_DATNAS),'" + mv_par02 + mv_par03 +"01') BA1IDADE ,

cQuery += "BM1_CODEMP COD_EMP,nvl(Bxq_NUMPAR,' ' ) PARC, DECODE(BA3_COBNIV,'0',' EMPRESA','1',' FAMILIA',' EMPRESA' ) NVL_COB," 										+ CRLF 
cQuery += "NVL(BA1_CODVEN, BA1_EQUIPE) VEND, BA1_CODVE2 VEND2, BA1_EQUIPE EQUIP, BXQ_E2PREF||'-'|| BXQ_E2NUM||'-'||BXQ_E2PARC||'-'||BXQ_E2TIPO TIT_E2," 							        + CRLF
cQuery += "BG9_DESCRI NOM_EMP, BA1_DATINC DT_INIC, BM1_ANO ANO, BM1_MES MES, BA1.BA1_CODPLA CODPLA, ba1.ba1_tipinc tipinc ," 											+ CRLF
//cQuery += "NVL(BXQ_REFERE,' ') BXQ_REFERE, NVL(BXQ_PAGCOM,' ') BXQ_PAGCOM, SUM (NVL(BXQ_BASCOM,0.0)) VLR_BASCOM ,  BM1_MATRIC , BM1_TIPREG" 					        + CRLF
cQuery += "NVL(BXQ_REFERE,' ') BXQ_REFERE, NVL(BXQ_PAGCOM,' ') BXQ_PAGCOM, NVL(BXQ_BASCOM,0.0) VLR_BASCOM, BM1_MATRIC, BM1_TIPREG, DECODE(trim(BQC_YSTSCO),'',' ','X') ART" 	+ CRLF
cQuery += "FROM "+ RetSqlName('BXQ') +" BXQ ," 				  																									+ CRLF
cQuery += RetSqlName('BM1') +" BM1 ," 							 																								+ CRLF
cQuery += RetSqlName('BA3') +" BA3 ," 																															+ CRLF
cQuery += RetSqlName('BA1') +" BA1 ," 					 																										+ CRLF
cQuery += RetSqlName('BG9') +" BG9 ,"                          
cQuery += RetSqlName('BQC') +" BQC "                                                                                                                            + CRLF    
cQuery += "WHERE BXQ_FILIAL(+) = '" + xFilial("BXQ") + "'" 				  																					    + CRLF
cQuery += "   AND BXQ.D_E_L_E_T_ (+) = ' '" 				  																									+ CRLF 
cQuery += "   AND BM1.D_E_L_E_T_  = ' '" 				  																										+ CRLF 
cQuery += "   AND BM1_FILIAL = '" + xFilial("BM1") + "'" 				  																						+ CRLF 
cQuery += "   AND BG9_FILIAL = '" + xFilial("BG9") + "'" 				  																						+ CRLF  
cQuery += "   AND BQC_FILIAL = '" + xFilial("BQC") + "'" 				  																						+ CRLF  
cQuery += "   AND BG9.D_E_L_E_T_ = ' '" 				  																										+ CRLF 
cQuery += "   AND BQC.D_E_L_E_T_ = ' '" 				  																										+ CRLF 
cQuery += "   AND BA3.D_E_L_E_T_ = ' '" 				  																										+ CRLF 
cQuery += "   AND BA1.D_E_L_E_T_ = ' '" 				  																										+ CRLF
cQuery += "   AND BXQ_CODINT (+) = BM1_CODINT" 				  																									+ CRLF 
cQuery += "   AND BXQ_CODEMP (+) = BM1_CODEMP" 				  																									+ CRLF 
cQuery += "   AND BXQ_MATRIC (+) = BM1_MATRIC" 				  																									+ CRLF 
cQuery += "   AND BXQ_TIPREG (+) = BM1_TIPREG" 				  																									+ CRLF 
cQuery += "   AND BXQ_DIGITO (+) = BM1_DIGITO" 				  																									+ CRLF 
cQuery += "   and NVL(BXQ_REFERE,' ') = NVL(BXQ_PAGCOM,' ')" + CRLF

if !empty (Mv_par23)
    cQuery += "   AND BM1_matric = '"+ Mv_par23+" ' " 				  																							+ CRLF
EndIf    
cQuery += "   AND BXQ_ANO (+) = BM1_ANO" 				  																										+ CRLF 
cQuery += "   AND BXQ_MES (+) = BM1_MES" 				  																										+ CRLF 
cQuery += "   AND BG9_CODINT = '0001'" 				  																											+ CRLF 
cQuery += "   AND BG9_CODIGO = BM1_CODEMP" 				  																										+ CRLF 
--cQuery += "   AND BM1_NUMPAR = BXQ_NUMPAR(+)" 				  																									+ CRLF
cQuery += "   AND BM1_CODTIP IN" 				  																												+ CRLF 
cQuery += "       (" 				  																															+ CRLF
cQuery += "       SELECT BFQ_PROPRI||BFQ_CODLAN" 				  																								+ CRLF 
cQuery += "       FROM "+ RetSqlName('BFQ') +" BFQ" 				  																							+ CRLF 
cQuery += "       WHERE BFQ_FILIAL = '"+xFilial("BFQ")+"'" 				  																						+ CRLF 
cQuery += "          AND BFQ.D_E_L_E_T_ = ' '" 				  																									+ CRLF 
cQuery += "          AND BFQ_COMISS = '1'" 				  																										+ CRLF 
cQuery += "          AND BFQ_ATIVO = '1'" 				  																										+ CRLF
cQuery += "       )" 				  																															+ CRLF
//cQuery += "   AND BM1_CODINT||BM1_CODEMP||BM1_MATRIC = BA3_CODINT||BA3_CODEMP||BA3_MATRIC" 				  														+ CRLF
cQuery += "     AND BM1_CODINT = BA3_CODINT "
cQuery += "     AND BM1_CODEMP = BA3_CODEMP "
cQuery += "     AND BM1_MATRIC = BA3_MATRIC "

cQuery += "     AND BA1_CODINT||BA1_CODEMP = BQC_CODIGO "
cQuery += "     AND BA1_CONEMP = BQC_NUMCON"
cQuery += "     AND BA1_VERCON = BQC_VERCON"
cQuery += "     AND BA1_SUBCON = BQC_SUBCON"
cQuery += "     AND BA1_VERSUB = BQC_VERSUB"

If mv_par04 == 1       
   cQuery += "   AND NOT EXISTS" 																		  														+ CRLF
   cQuery += "      (" 				  													  																		+ CRLF
   cQuery += "      SELECT NULL" 				  													  															+ CRLF  
   cQuery += "      FROM "+ RetSqlName("BXO") +" BXO" 				  													 										+ CRLF 
   cQuery += "      WHERE BXO_FILIAL = '"+xFilial("BXO")+"'" 				  																					+ CRLF 
   cQuery += "         AND BXO.D_E_L_E_T_ = ' '" 				  													  											+ CRLF  
   cQuery += "         AND BXO_CODEMP = BM1_CODEMP" 				  												  											+ CRLF 
   cQuery += "         AND BXO_MATRIC = BM1_MATRIC" 				  													 										+ CRLF 
   cQuery += "         AND BXO_TIPREG = BM1_TIPREG" 				  												   											+ CRLF 
   cQuery += "      )" 				  													  																		+ CRLF
EndIf
   
//cQuery += "   AND BM1_CODINT||BM1_CODEMP||BM1_MATRIC||BM1_TIPREG||BM1_DIGITO = BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG||BA1_DIGITO" 						+ CRLF
cQuery += "   AND BM1_CODINT = BA1_CODINT "
cQuery += "   AND BM1_CODEMP = BA1_CODEMP "
cQuery += "   AND BM1_MATRIC = BA1_MATRIC "
cQuery += "   AND BM1_TIPREG = BA1_TIPREG "
cQuery += "   AND BM1_DIGITO = BA1_DIGITO "
If !Empty(mv_par01)
    cQuery += "   AND BM1_CODEMP = '" + mv_par01 + "'" 				   																							+ CRLF
EndIf               
   
If !Empty(mv_par02)
    cQuery += "   AND BM1_ANO = '" + mv_par02 + "'" 					 																						+ CRLF
EndIf   
               
If !Empty(mv_par03)    
    cQuery += "   AND BM1_MES = '" + mv_par03 + "'"  					   																						+ CRLF
EndIf     

If !Empty(mv_par19)
    cQuery += "   AND BM1_conemp = '" + mv_par19 + "'" 					 																						+ CRLF
EndIf   
 
If !Empty(mv_par20)
    cQuery += "   AND BM1_subcon = '" + mv_par20 + "'" 					 																						+ CRLF
EndIf   
              
If mv_par05 != 3                   
    If mv_par05 == 1
       cQuery += "   AND BA3_COBNIV = '1'" 																														+ CRLF 
    Else
       cQuery += "   AND BA3_COBNIV != '1'" 				  																									+ CRLF 
    EndIf   
EndIf  
   
If !Empty(mv_par06)   
    cQuery += "   AND BXQ_CODVEN(+) = '" + mv_par06 + "'" 			 																								+ CRLF 
EndIf  
   
If !Empty(mv_par07)    
    cQuery += "   AND BXQ_E2NUM(+)  = '" + mv_par07 + "'" 
EndIf  
   
If mv_par08 != 3                   
    If mv_par08 == 1
       cQuery += "   AND BXQ_E2NUM(+) != ' '" 				   																										+ CRLF 
    Else
       cQuery += "   AND BXQ_E2NUM(+) = ' '" 			 																											+ CRLF
    EndIf   
EndIf 
   
cQuery += "GROUP BY   NVL(BXQ_CODINT,'') ||'.'||NVL(BXQ_CODEMP,'')||'.'||NVL(BXQ_MATRIC,'')||'.'||NVL(BXQ_TIPREG,'')|| '-'|| NVL(BXQ_DIGITO,'FALTA BXQ'),"		+ CRLF  
cQuery += "BM1_CODINT ||'.'||BM1_CODEMP||'.'||BM1_MATRIC||'.'||BM1_TIPREG||'-'||BM1_DIGITO, BA1_NOMUSR, NVL(BXQ_REFERE,' '), NVL(BXQ_PAGCOM,' '),"				+ CRLF 
cQuery += "NVL(BXQ_BASCOM,0.0), NVL(BXQ_VLRCOM,0.0) , NVL(BXQ_PERCOM,0.0)||'%', BM1_PREFIX||'-'||BM1_NUMTIT||'-'||BM1_PARCEL||'-'||BM1_TIPO, "					+ CRLF
cQuery += "BM1_CODEMP, nvl(Bxq_NUMPAR,' ' ), DECODE(BA3_COBNIV,'0',' EMPRESA','1',' FAMILIA',' EMPRESA' ), NVL(BA1_CODVEN, BA1_EQUIPE), ba1.ba1_tipinc ,"						+ CRLF
cQuery += "BA1_CODVE2, BA1_EQUIPE, BXQ_E2PREF||'-'||BXQ_E2NUM||'-'||BXQ_E2PARC||'-'||BXQ_E2TIPO, "																+ CRLF
cQuery += "BG9_DESCRI, BA1_DATINC, BM1_ANO, BM1_MES, BA1.BA1_CODPLA, BM1_MATRIC, BM1_TIPREG, DECODE(trim(BQC_YSTSCO),'',' ','X') , "									+ CRLF                  
cQuery += " IDADE_S(TRIM(BA1.BA1_DATNAS),'" + mv_par02 + mv_par03 +"01') "

cQuery += " UNION ALL "

cQuery += " SELECT DISTINCT " 
cQuery += " NVL(BXQ_CODINT,'')||'.'||NVL(BXQ_CODEMP,'')||'.'||NVL(BXQ_MATRIC,'')||'.'||NVL(BXQ_TIPREG,'')||'-'|| NVL(BXQ_DIGITO,'FALTA BXQ') MATRIC_COMISSAO,  "
cQuery += " BXQ_CODINT||'.'||BXQ_CODEMP||'.'||BXQ_MATRIC||'.'||BXQ_TIPREG||'-'|| BXQ_DIGITO MATRIC_CADSTRO, BA1_NOMUSR NOME_USURARIO, SUM(BXQ_BASCOM) VLR_COB, "
//cQuery += " SUM(NVL(BXQ_VLRCOM,0.0)) VLR_COM, NVL(BXQ_PERCOM,0.0)||'%' PREC, BXQ_PREFIX ||'-'||BXQ_NUM||'-'||BXQ_PARC ||'-'||BXQ_TIPO TIP_COM, "  

cQuery += " NVL(BXQ_VLRCOM,0.0) VLR_COM, NVL(BXQ_PERCOM,0.0)||'%' PREC, BXQ_PREFIX ||'-'||BXQ_NUM||'-'||BXQ_PARC ||'-'||BXQ_TIPO TIP_COM, "

cQuery += " IDADE_S(TRIM(BA1.BA1_DATNAS),'" + mv_par02 + mv_par03 +"01') BA1IDADE ,"

cQuery += " Bxq_CODEMP COD_EMP, Bxq_NUMPAR PARC, DECODE(BA3_COBNIV,'0',' EMPRESA','1',' FAMILIA',' EMPRESA' ) NVL_COB, "
cQuery += " NVL(BA1_CODVEN, BA1_EQUIPE) VEND, BA1_CODVE2 VEND2, BA1_EQUIPE EQUIP, BXQ_E2PREF||'-'|| BXQ_E2NUM||'-'||BXQ_E2PARC||'-'||BXQ_E2TIPO TIT_E2, "
cQuery += " BG9_DESCRI NOM_EMP, BA1_DATINC DT_INIC, Bxq_ANO ANO, Bxq_MES MES, BA1.BA1_CODPLA CODPLA , ba1.ba1_tipinc tipinc ,"
cQuery += " NVL(BXQ_REFERE,' ') BXQ_REFERE, NVL(BXQ_PAGCOM,' ') BXQ_PAGCOM, SUM(NVL(BXQ_BASCOM,0.0)) VLR_BASCOM, Bxq_MATRIC, Bxq_TIPREG , DECODE(trim(BQC_YSTSCO),'',' ','X') ART "      

cQuery += " FROM "+ RetSqlName('BXQ') +" BXQ ," + CRLF
cQuery += RetSqlName('BA3') +" BA3 ," + CRLF
cQuery += RetSqlName('BA1') +" BA1 ," + CRLF
cQuery += RetSqlName('BG9') +" BG9 ," + CRLF
cQuery += RetSqlName('BQC') +" BQC" 
cQuery += " WHERE BXQ_FILIAL(+) = ' ' "
cQuery += " AND BXQ.D_E_L_E_T_  = ' ' "
cQuery += " AND BG9_FILIAL = '  '     "
cQuery += " AND BG9.D_E_L_E_T_ = ' '  "
cQuery += " AND BQC_FILIAL = '  '     "
cQuery += " AND BQC.D_E_L_E_T_ = ' '  "
cQuery += " AND BA3.D_E_L_E_T_ = ' '  "
cQuery += " AND BA1.D_E_L_E_T_ = ' '  "
cQuery += " AND BG9_CODINT = '0001'   "
cQuery += " AND BG9_CODIGO = BXQ_CODEMP "
cQuery += " AND BXQ_NUMPAR = '999'    "

cQuery += " AND BXQ_CODINT = BA3_CODINT "
cQuery += " AND BXQ_CODEMP = BA3_CODEMP "
cQuery += " AND BXQ_MATRIC = BA3_MATRIC "   
cQuery += " AND BXQ_CODINT = BA1_CODINT "
cQuery += " AND BXQ_CODEMP = BA1_CODEMP "
cQuery += " AND BXQ_MATRIC = BA1_MATRIC "
cQuery += " AND BXQ_TIPREG = BA1_TIPREG "
cQuery += " AND BXQ_DIGITO = BA1_DIGITO "

cQuery += " AND BA1_CODINT||BA1_CODEMP = BQC_CODIGO "
cQuery += " AND BA1_CONEMP = BQC_NUMCON"
cQuery += " AND BA1_VERCON = BQC_VERCON"
cQuery += " AND BA1_SUBCON = BQC_SUBCON"
cQuery += " AND BA1_VERSUB = BQC_VERSUB"


//cQuery += "   AND BXQ_CODINT||BXQ_CODEMP||BXQ_MATRIC = BA3_CODINT||BA3_CODEMP||BA3_MATRIC "
//cQuery += "   AND BXQ_CODINT||BXQ_CODEMP||BXQ_MATRIC||BXQ_TIPREG||BXQ_DIGITO = BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG||BA1_DIGITO "

If !Empty(mv_par01)
    cQuery += "   AND BXQ_CODEMP(+) = '" + mv_par01 + "'" 				   																							+ CRLF
EndIf               
   
If !Empty(mv_par02)
    cQuery += "   AND BXQ_ANO(+) = '" + mv_par02 + "'" 					 																						+ CRLF
EndIf   
               
If !Empty(mv_par03)    
    cQuery += "   AND BXQ_MES(+) = '" + mv_par03 + "'"  					   																						+ CRLF
EndIf     

If !Empty(mv_par19)
    cQuery += "   AND BXQ_NUMcon(+) = '" + mv_par19 + "'" 					 																						+ CRLF
EndIf   
 
If !Empty(mv_par20)
    cQuery += "   AND BXQ_subcon = '" + mv_par20 + "'" 					 																						+ CRLF
EndIf   
              
If mv_par05 != 3                   
    If mv_par05 == 1
       cQuery += "   AND BA3_COBNIV = '1'" 																														+ CRLF 
    Else
       cQuery += "   AND BA3_COBNIV != '1'" 				  																									+ CRLF 
    EndIf   
EndIf  
   
If !Empty(mv_par06)   
    cQuery += "   AND BXQ_CODVEN = '" + mv_par06 + "'" 			 																								+ CRLF 
EndIf  
   
If !Empty(mv_par07)    
    cQuery += "   AND BXQ_E2NUM  = '" + mv_par07 + "'" 
EndIf  
   
If mv_par08 != 3                   
    If mv_par08 == 1
       cQuery += "   AND BXQ_E2NUM != ' '" 				   																										+ CRLF 
    Else
       cQuery += "   AND BXQ_E2NUM = ' '" 			 																											+ CRLF
    EndIf   
EndIf 
cQuery += " group by NVL(BXQ_CODINT,'')||'.'||NVL(BXQ_CODEMP,'')||'.'||NVL(BXQ_MATRIC,'')||'.'||NVL(BXQ_TIPREG,'')||'-'|| NVL(BXQ_DIGITO,'FALTA BXQ') , "
cQuery += " BXQ_CODINT||'.'||BXQ_CODEMP||'.'||BXQ_MATRIC||'.'||BXQ_TIPREG||'-'|| BXQ_DIGITO , BA1_NOMUSR , "
cQuery += " NVL(BXQ_VLRCOM,0.0) ,NVL(BXQ_PERCOM,0.0), BXQ_PREFIX ||'-'||BXQ_NUM||'-'||BXQ_PARC ||'-'||BXQ_TIPO ,                "
cQuery += " Bxq_CODEMP , Bxq_NUMPAR , DECODE(BA3_COBNIV,'0',' EMPRESA','1',' FAMILIA',' EMPRESA' ) ,              "
cQuery += " NVL(BA1_CODVEN, BA1_EQUIPE) , BA1_CODVE2 , BA1_EQUIPE , BXQ_E2PREF||'-'|| BXQ_E2NUM||'-'||BXQ_E2PARC||'-'||BXQ_E2TIPO , "
cQuery += " BG9_DESCRI , BA1_DATINC , BXQ_ANO , BXQ_MES , BA1.BA1_CODPLA , ba1.ba1_tipinc  ,"
cQuery += " NVL(BXQ_REFERE,' ') , NVL(BXQ_PAGCOM,' ') , NVL(BXQ_BASCOM,0.0) , Bxq_MATRIC, Bxq_TIPREG , DECODE(trim(BQC_YSTSCO),'',' ','X') ,"

cQuery += " IDADE_S(TRIM(BA1.BA1_DATNAS),'" + mv_par02 + mv_par03 +"01') "

If mv_par13 = 1     
	cQuery += "ORDER BY 9,8,3 "    
ElseIf mv_par13 = 2  
	cQuery += "ORDER BY 9,15,3 "    
Else
	cQuery += "ORDER BY 9,10,3 "    
EndIf
   
If Select(("TMP")) <> 0 
	("TMP")->(DbCloseArea())  
EndIf        
   
TcQuery cQuery Alias "TMP" New 
dbSelectArea("TMP")
tmp->(dbGoTop()) 
                                           
While !TMP->(EOF())  
                                                         
    If tmp->bxq_refere <> ' ' .and. tmp->bxq_refere <> tmp->bxq_pagcom     
        tmp->(dbSkip())
        loop
    EndIf   

	If nLin > 55 // Salto de Pแgina. Neste caso o formulario tem 55 linhas...
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
	cnome := substr (tmp->nome_usurario, 1,20)                                        
//Local Cabec1       := " Matricula            Nome                                 Parc   Vlr.Cobr.   Vlr.Com.  %Com.   Num.Titulo          Niv. Cobran็a     Cod.Vend   Cod.Vend2  Cod. Equipe  Comisao   Plano
//                       1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//                       0        1         2         3         4         5         6         7         8         9         10        11        12        13        14        15        16        17        18        19        20        21        22
//                       XXXX.XXXX.XXXXXX.XX-X XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX      XXX   999.999,99  99.999,99  999,99  XXX-99999999-X-XXX  XXXXXXXXXX        XXXXXX      XXXXXX      XXX            XXX                              
     if Empty(NnumTit) 
	    NnumTit := tmp->Tip_Com           
	    CcodEmp := tmp->Cod_emp  
	    CNuTitE2:= tmp->Tit_e2
	    cNumParc:= tmp->parc      
     EndIf    
     cQuery := "SELECT sum(BM1_VALOR) vlr FROM "+ RetSqlName('BM1') +" bm1 ,"+ RetSqlName('Bfq') +" bfq WHERE bfq.d_E_L_E_T_  = ' ' and bm1.d_E_L_E_T_  = ' ' and bm1_filial = '"+xFilial("BM1")+"'and bfq_filial = '"+xFilial("Bfq")+"' "
     cQuery += " and bm1_codint ||'.'||bm1_codemp||'.'||bm1_matric||'.'||bm1_tipreg||'-'||bm1_digito = '"+TMP->Matric_Cadstro+"' AND BM1_ANO = '"+TMP->ano+"' AND BM1_MES = '"+TMP->MES+"' and bm1_codtip = bfq_propri||bfq_codlan and bm1_numpar ='"+tmp->Parc+"' "
     if mv_par10 = 2
        cQuery += "  and bfq_comiss = '1' and bfq_ativo = '1' "   	 
     EndIf
     If Select(("TMP2")) <> 0 
        ("TMP2")->(DbCloseArea())  
     EndIf
     TCQuery cQuery Alias "TMP2" New     
     if mv_par12 <>  3  
        If TMP->Matric_Comissao <> TMP->Matric_Cadstro   
           if mv_par12 =  1  
              tmp->(dbSkip())
              loop 
           EndIf   
        Else       
          if mv_par12 =  2
             tmp->(dbSkip())
             loop 
          EndIf   
        EndIf                     
     EndIf  
	 @ nLin,000 PSay   alltrim(TMP->Matric_Cadstro) + ' - ' +cnome+' - ' +trim(strzero(TMP->BA1IDADE,3))  
	 @ nLin,060 PSay  TMP->Parc
  	 @ nLin,066 PSay  tmp->Vlr_basCom Picture "@E 999,999.99"  
  	 @ nLin,078 PSay  tmp->Vlr_Com    Picture "@E 99,999.99" 
  	 if TMP->Parc < "999"
  	    @ nLin,089 PSay  tmp->Prec            
  	 Else                                                      
  	   @ nLin,089 PSay  tmp->Prec+'-'             
  	 EndIf  
   	 @ nLin,097 PSay  tmp->Tip_Com
	 @ nLin,117 PSay  tmp->Nvl_Cob
     @ nLin,135 PSay  tmp->Vend
     @ nLin,147 PSay  tmp->Vend2
	 @ nLin,159 PSay  tmp->EQUIP                                                          
	 @ nLin,165 PSay  tmp->tipinc
     @ nLin,172 PSAY  tmp->ART
     If TMP->Matric_Comissao <> TMP->Matric_Cadstro  
	    @ nLin,174 PSAY   'NรO' 
     Else  
 	    @ nLin,174 PSAY   'SIM' 
     EndIf                     
     @ nLin,180 PSAY  tmp->codpla   
  	 @ nLin,188 PSay  tmp->TIT_E2    
  	 @ nlin, 210 psay substr(tmp->dt_inic,7,2)+'/'+substr(tmp->dt_inic,5,2)+'/'+substr(tmp->dt_inic,1,4) 
/////
if mv_par16 = 1  .and. TMP->Matric_Comissao == TMP->Matric_Cadstro 
 cQuery1 := " Select distinct bxo_codemp   , bxo_codequ, bxo_codven , bxp_qtdde , bxp_qtdate , bxp_percon  "
 cQuery1 += " From "+ RetSqlName('BXP') +" bxp , "+ RetSqlName('BXO') +" bxO , "+ RetSqlName('BXQ') +" bxq "
 cQuery1 += " Where bxo_filial = '"+xFilial("BXO")+"' and bxo.d_E_L_E_T_ = ' ' and bxp_filial = '"+xFilial(+"BXP")+"' and bxp.d_E_L_E_T_ = ' ' "
 cQuery1 += "   and bxq_filial = '"+xFilial("BXQ")+"' and bxq.d_E_L_E_T_ = ' ' and bxp_seqbxo = bxo_seq and bxq_seqbxo = bxo_seq "
 if !empty (mv_par01)
     cQuery1 += " and bxq_codemp = '"+mv_par01+"' "
 EndIf               
 if !empty (mv_par02)
     cQuery1 += " and bxq_ano = '"+mv_par02+"' "
 EndIf               
 if !empty (mv_par03)    
     cQuery1 += " and bxq_mes = '"+mv_par03+"'" 
 EndIf                             
 cQuery1 += " and bxp_qtdde <= "+str(VAL(TMP->Parc))+"  and bxp_qtdate >="+str(VAL(TMP->Parc))
 cQuery1 += "  and bxo_matric = '"+tmp->bm1_matric+"' and bxo_tipreg = '"+tmp->bm1_tipreg+"' order by  bxo_codemp   , bxo_codequ, bxo_codven ,   bxp_qtdde "
 If Select(("TMP1")) <> 0 
    ("TMP1")->(DbCloseArea())  
 Endif
 TCQuery cQuery1 Alias "TMP1" New 
 dbSelectArea("TMP1")
 tmp1->(dbGoTop())                                         
 While !TMP1->(EOF())    
       nLin ++               
       @ nLin,006 PSay 'Regra Para Matricula -->> '                                         
       @ nLin,032 PSay tmp1->bxo_codemp 
       @ nLin,041 PSay tmp1->bxo_codven
       @ nLin,052 PSay tmp1->bxo_codequ                                                                                 
       @ nLin,061 PSay StrZero(tmp1->bxp_qtdde,3)                                                         
       @ nlin,073 psay StrZero(tmp1->bxp_qtdate,3)
       @ nlin,091 psay tmp1->bxp_percon  
       @ nlin,093 psay "%" 
       tmp1->(dbSkip())    
 EndDo 
endIf  
 
////  	 	 
	nLin ++     // Avanca a linha de impressao                                    
	If mv_par09 == 1
       cQuery := "SELECT BM1_CODTIP ||' - '||bfq_descri codtip , BM1_VALOR  vlr  , BM1_CONEMP , BM1_SUBCON FROM "+ RetSqlName('BM1') +" bm1 ,"+ RetSqlName('Bfq') +" bfq WHERE bfq.d_E_L_E_T_  = ' ' and bm1.d_E_L_E_T_  = ' ' and bm1_filial = '"+xFilial("BM1")+"'and bfq_filial = '"+xFilial("Bfq")+"' and "
//       cQuery += " bm1_codint ||'.'||bm1_codemp||'.'||bm1_matric||'.'||bm1_tipreg||'-'||bm1_digito = '"+TMP->Matric_Cadstro+"' AND BM1_ANO = '"+TMP->ano+"' AND BM1_MES = '"+TMP->MES+"' and bm1_codtip = bfq_propri||bfq_codlan and bm1_numpar ='"+tmp->Parc+"' " 
       cQuery += " bm1_codint ||'.'||bm1_codemp||'.'||bm1_matric||'.'||bm1_tipreg||'-'||bm1_digito = '"+TMP->Matric_Cadstro+"' AND BM1_ANO = '"+TMP->ano+"' AND BM1_MES = '"+TMP->MES+"' and bm1_codtip = bfq_propri||bfq_codlan "       
   	   if mv_par10 = 2
          cQuery += "  and bfq_comiss = '1' and bfq_ativo = '1' "   	 
       EndIf
   	   If Select(("TMP1")) <> 0 
          ("TMP1")->(DbCloseArea())  
       Endif
       TCQuery cQuery Alias "TMP1" New 
       dbSelectArea("TMP1")
       tmp1->(dbGoTop())                                         
       While !TMP1->(EOF())
           @ nLin,013 PSay  tmp1->CODTIP 
           @ nLin,046 PSay  tmp1->VLR   Picture "@E 999,999.99" 

           @ nLin,060 PSay tmp1->BM1_CONEMP 
           @ nLin,075 PSay tmp1->BM1_SUBCON

           TMP1->(dbSkip())   // Avanca o ponteiro do registro no arquivo
           nLin ++    
       EndDo                          
    EndIf      	          
                                                
//	Nttotcob+= tmp->Vlr_cob  
	Nttotcob+= tmp->Vlr_basCom 
    Nttotcom+= tmp->Vlr_com 	      
    Ncont++        
    NcontTit++
//    Ntotcob+= tmp->Vlr_cob 	  
    Ntotcob+= tmp->Vlr_basCom 	 
    Ntotcom+= tmp->Vlr_com 	
    CNomEmp:= TMP->NOM_EMP 
    tmp->(dbSkip())   // Avanca o ponteiro do registro no arquivo 
	if mv_par13 = 1
	   if NnumTit != tmp->Tip_Com //.and. !TMP->(EOF())   
       	  @ nLin,000 PSay replicate("_",220)           
   	        nLin ++     // Avanca a linha de impressao    
          @ nLin,040 PSAY  'Total do Titulo A Receber  '
          @ nLin,066 PSay  Nttotcob    Picture "@E 9,999,999.99" 
          @ nLin,078 PSay  NttotCom    Picture "@E 999,999.99" 
          @ nLin,0118 PSay  NcontTit    
   	        nLin ++     // Avanca a linha de impressao    
          @ nLin,000 PSay replicate("_",220)   
            NEtotcob    += Nttotcob
            NEtotcom    += Nttotcom 
            NEcontTit   += NcontTit
            Nttotcob:= 0.00 	              
            Nttotcom:= 0.00                
            NcontTit:=0        
            NnumTit := tmp->Tip_Com   
            nLin ++    
       EndIf
    ElseIf mv_par13 = 2       
       If  CNuTitE2!= tmp->Tit_e2
    	@ nLin,000 PSay replicate("_",220)           
   	      nLin ++     // Avanca a linha de impressao    
        @ nLin,040 PSAY  'Total do Titulo a Receber '
        @ nLin,066 PSay  Nttotcob    Picture "@E 9,999,999.99" 
        @ nLin,078 PSay  NttotCom    Picture "@E 999,999.99" 
        @ nLin,0118 PSay  NcontTit    
   	      nLin ++     // Avanca a linha de impressao    
        @ nLin,000 PSay replicate("_",220)   
          NEtotcob    += Nttotcob
          NEtotcom    += Nttotcom 
          NEcontTit   += NcontTit
          Nttotcob:= 0.00 	              
          Nttotcom:= 0.00                
          NcontTit:=0        
          CNuTitE2:= tmp->Tit_e2               
          nLin ++    
       EndIf 
    Else      
      If  cNumParc != tmp->parc   
    	@ nLin,000 PSay replicate("_",220)           
   	      nLin ++     // Avanca a linha de impressao    
        @ nLin,040 PSAY  'Total da Parcela  '
        @ nLin,066 PSay  Nttotcob    Picture "@E 9,999,999.99" 
        @ nLin,078 PSay  NttotCom    Picture "@E 999,999.99" 

        @ nLin,0118 PSay  NcontTit    

   	      nLin ++     // Avanca a linha de impressao    
        @ nLin,000 PSay replicate("_",220)   
          NEtotcob    += Nttotcob
          NEtotcom    += Nttotcom 
          NEcontTit   += NcontTit
          Nttotcob:= 0.00 	              
          Nttotcom:= 0.00                
          NcontTit:=0 
          cNumParc:= tmp->parc         
        nLin ++    
       EndIf
     EndIf      
                                                    
if CcodEmp != tmp->Cod_emp .or. TMP->(EOF())     
    cQuery := " select bxq_codint ||'.'|| bxq_codemp ||'.'|| bxq_matric ||'.'|| bxq_tipreg ||'-'|| bxq_digito||'-'|| BA1_NOMUSR  Matric_Comissao,"
    cQuery += " bxq_vlrcom Vlr_Com ,bxq_percom ||'%' Prec , bxq_bascom Vlr_basCom , bxq_numpar parc , "    
    cQuery += " bxq_prefix ||'-'||bxq_num||'-'||bxq_parc ||'-'||bxq_tipo Tit_Com , bxq_codven codven "
    cQuery += " from "+ RetSqlName('BXQ') +" bxq  , "+ RetSqlName('BA1') +" BA1   where bxq_filial = '"+xFilial("BXO")+"' AND BA1_filial = '"+xFilial("BA1")+"'"
    cQuery += " AND  BA1_CODINT ||'.'||BA1_CODEMP||'.'||BA1_MATRIC||'.'||BA1_TIPREG||'-'||BA1_DIGITO = BXQ_CODINT ||'.'||BXQ_CODEMP||'.'||BXQ_MATRIC||'.'||BXQ_TIPREG||'-'||BXQ_DIGITO 
    cQuery += " and BXQ.d_E_L_E_T_ = ' ' and BA1.d_E_L_E_T_ = ' ' and BXQ_NUMPAR = '999'and bxq_refere = bxq_pagcom  "
    
    if !empty (mv_par01)
        cQuery += " and bXQ_codemp = '"+mv_par01+"' "
    EndIf               
    if !empty (mv_par02)
        cQuery += " and bXQ_ano = '"+mv_par02+"' "
    EndIf               
    if !empty (mv_par03)    
        cQuery += " and bXQ_mes = '"+mv_par03+"'" 
    EndIf         
     if !empty (mv_par06)   
       cQuery += " and bxq_codven  = '"+mv_par06+"'" 
   EndIf      
   If !Empty(mv_par19)
      cQuery += "   AND BXQ_NUMcon = '" + mv_par19 + "'" 					 																						+ CRLF
   EndIf   
 
   If !Empty(mv_par20)
      cQuery += "   AND BXQ_subcon = '" + mv_par20 + "'" 					 																						+ CRLF
   EndIf                 
   cQuery += " order by  bxq_codint , bxq_codemp , bxq_matric , bxq_tipreg , bxq_digito , bxq_codven "   
    If Select(("TMP4")) <> 0 
       ("TMP4")->(DbCloseArea())  
   Endif
     
    TCQuery cQuery Alias "TMP4" New 
    dbSelectArea("TMP4")
    tmp2->(dbGoTop())                                
    if !TMP4->(EOF())                    
        If nLin > 65 // Salto de Pแgina. Neste caso o formulario tem 55 linhas...
   	       nLin :=	Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
           nLin ++
 	    Endif

        @ nLin,060 PSay  'Devolu็๕es de Comiss๕es'
          nLin ++                 
    	@ nLin,000 PSay replicate("_",220)    
    	  nLin ++         
         
    While !TMP4->(EOF())     
        If nLin > 65 // Salto de Pแgina. Neste caso o formulario tem 55 linhas...
   	       nLin :=	Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
           nLin ++        
         @ nLin,060 PSay  'Devolu็๕es de Comiss๕es'
           nLin ++                 
      	 @ nLin,000 PSay replicate("_",220)    
    	   nLin ++         
 	    Endif
    	 @ nLin,000 PSay  TMP4->Matric_Comissao                                
         @ nLin,080 PSay  TMP4->Tit_Com                                   	 
   	     @ nLin,112 PSay  TMP4->Parc
     	 @ nLin,118 PSay  tmp4->Vlr_basCom  Picture "@E 999,999.99"  
  	     @ nLin,130 PSay  tmp4->Vlr_Com     Picture "@E 99,999.99"  
	     @ nLin,160 PSay  tmp4->codven      
  	     
  	     totDevbas +=tmp4->Vlr_basCom     
  	     TotDevcom +=tmp4->Vlr_Com  
  	     
  	     contDev++              
  	   
	     TMP4->(dbSkip())   // Avanca o ponteiro do registro no arquivo
         nLin ++    
    EndDo                                    
       	@ nLin,000 PSay replicate("_",220)           
   	      nLin ++     // Avanca a linha de impressao    
        @ nLin,005 PSAY  'Total das Devolu็๕s :' + substr(CNomEmp,1,35)  
        @ nLin,118 PSay  TotDevbas   Picture "@E 9,999,999.99" 
        @ nLin,130 PSay  TotDevcom   Picture "@E 999,999.99" 

        @ nLin,0118 PSay  contDev  

   	      nLin ++     // Avanca a linha de impressao    
        @ nLin,000 PSay replicate("_",220)
  EndIf 
EndIf
    if CcodEmp != tmp->Cod_emp .or. TMP->(EOF())
    	@ nLin,000 PSay replicate("_",220)           
   	      nLin ++     // Avanca a linha de impressao    
        @ nLin,005 PSAY  'Total da Empresa :' + substr(CNomEmp,1,35)  
        @ nLin,066 PSay  NEtotcob   Picture "@E 9,999,999.99" 
        @ nLin,078 PSay  NEtotcom   Picture "@E 999,999.99" 

        @ nLin,0118 PSay  NEcontTit           
        
   	      nLin ++     // Avanca a linha de impressao    
        @ nLin,000 PSay replicate("_",220)
          NTcontTit+=NEcontTit
          NEtotcob:= 0.00 	              
          NEtotcom:= 0.00                
          NEcontTit:=0
          CcodEmp := tmp->Cod_emp  
        nLin ++    
    EndIf      	                 
EndDo    
    @ nLin,000 PSay replicate("_",220)           
   	nLin ++     // Avanca a linha de impressao    
    @ nLin,040 PSAY  'Totais Geral  '
    @ nLin,066 PSay  Ntotcob    Picture "@E 9,999,999.99" 
    @ nLin,078 PSay  NtotCom    Picture "@E 999,999.99" 
    @ nLin,118 PSay  NTcontTit           
   	nLin ++     // Avanca a linha de impressao    
    @ nLin,000 PSay replicate("_",220)           
    nLin ++   
 EndIf   
 if mv_par11 = 1              
Cabec1               := " Matricula            Nome                                                 Tipo  Descri็ใo                         Vlr.Cobr.          Lanc. Origem "
//                       1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//                       0        1         2         3         4         5         6         7         8         9         10        11        12        13        14        15        16        17        18        19        20        21        22
//                       XXXX.XXXX.XXXXXX.XX-X XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX                                           999.999,99  99.999,99  999,99  XXX-99999999-X-XXX  XXXXXXXXXX        XXXXXX      XXXXXX      XXX            XXX

    nLin := 99    
    cQuery := "SELECT bm1_codint ||'.'||bm1_codemp||'.'||bm1_matric||'.'||bm1_tipreg||'-'||bm1_digito||'-'||bm1_NOMUSR Matric_Cadstro , bm1_origem , BM1_CODTIP ||' - '||bfq_descri codtip , BM1_VALOR  vlr , bm1_origem origem FROM "+ RetSqlName('BM1') +" bm1 ,"+ RetSqlName('Bfq') +" bfq WHERE bfq.d_E_L_E_T_  = ' ' and bm1.d_E_L_E_T_  = ' ' and bm1_filial = '"+xFilial("BM1")+"'and bfq_filial = '"+xFilial("Bfq")+"'  "
    cQuery += " and bm1_codemp = '"+mv_par01+"' and  BM1_ANO = '"+mv_par02+"' AND BM1_MES = '"+mv_par03+"' and bm1_codtip = bfq_propri||bfq_codlan "
    if mv_par10 = 2
       cQuery += "  and bfq_comiss = '1' and bfq_ativo = '1' "   	 
    EndIf
    If !Empty(mv_par19)
      cQuery += "   AND Bm1_conemp = '" + mv_par19 + "'" 					 																						+ CRLF
    EndIf   
 
    If !Empty(mv_par20)
      cQuery += "   AND Bm1_subcon = '" + mv_par20 + "'" 					 																						+ CRLF
    EndIf    
                                                            
       cQuery += "  order by 1 "   	 
    

    If Select(("TMP3")) <> 0 
       ("TMP3")->(DbCloseArea())  
    Endif
    TCQuery cQuery Alias "TMP3" New 
    dbSelectArea("TMP3")
    tmp3->(dbGoTop())                                         
    While !TMP3->(EOF())    
  	  If nLin > 65 // Salto de Pแgina. Neste caso o formulario tem 55 linhas...
   	     nLin :=	Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
	     nLin ++
	  Endif

      @ nLin,001 PSay  tmp3->Matric_Cadstro    
      @ nLin,075 PSay  tmp3->CODTIP 
      @ nLin,0116 PSay  tmp3->VLR   Picture "@E 999,999.99" 
      @ nLin,0133 PSay  tmp3->origem 
      TMP3->(dbSkip())   // Avanca o ponteiro do registro no arquivo
       nLin ++    
       
    EndDo                          
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

cPerg := PADR(cPerg,7)    

U_CABASX1(cPerg,"01","Codigo Empresa      "  ,"","","mv_ch01","C",04,0,0,"G","","","","","mv_par01","        ","","","","        ","","","      ","","","","","","","","",{},{},{})   
U_CABASX1(cPerg,"02","Ano Competencia     "  ,"","","mv_ch02","C",04,0,0,"G","","","","","mv_par02","        ","","","","        ","","","      ","","","","","","","","",{},{},{}) 
U_CABASX1(cPerg,"03","Mes Competencia     "  ,"","","mv_ch03","C",02,0,0,"G","","","","","mv_par03","        ","","","","        ","","","      ","","","","","","","","",{},{},{})
U_CABASX1(cPerg,"04","Crit Comissao       "  ,"","","mv_ch04","N",01,0,0,"C","","","","","mv_par04","Sim     ","","","","Nใo     ","","","      ","","","","","","","","",{},{},{})
U_CABASX1(cPerg,"05","Niv. Cobranca       "  ,"","","mv_ch05","N",01,0,0,"C","","","","","mv_par05","Familia ","","","","Empresa ","","","Ambos ","","","","","","","","",{},{},{})
U_CABASX1(cPerg,"06","Codigo Vendedor     "  ,"","","mv_ch06","C",06,0,0,"G","","","","","mv_par06","        ","","","","        ","","","      ","","","","","","","","",{},{},{}) 
U_CABASX1(cPerg,"07","Nun Titulo          "  ,"","","mv_ch07","C",09,0,0,"G","","","","","mv_par07","        ","","","","        ","","","      ","","","","","","","","",{},{},{})
U_CABASX1(cPerg,"08","Faturado            "  ,"","","mv_ch08","N",01,0,0,"C","","","","","mv_par08","Sim     ","","","","Nใo     ","","","ambos ","","","","","","","","",{},{},{})
U_CABASX1(cPerg,"09","Mostrar Comp. Tit.  "  ,"","","mv_ch09","N",01,0,0,"C","","","","","mv_par09","Sim     ","","","","Nใo     ","","","","","","","","","","","",{},{},{})
U_CABASX1(cPerg,"10","Mostra toda Comp.   "  ,"","","mv_ch10","N",01,0,0,"C","","","","","mv_par10","Sim     ","","","","Nใo     ","","","","","","","","","","","",{},{},{})
U_CABASX1(cPerg,"11","Mostra toda BM1     "  ,"","","mv_ch11","N",01,0,0,"C","","","","","mv_par11","Sim     ","","","","Nใo     ","","","","","","","","","","","",{},{},{})
U_CABASX1(cPerg,"12","Participa da Comissใo   "  ,"","","mv_ch12","N",01,0,0,"C","","","","","mv_par12","SIm ","","","","Nใo ","","","Ambos ","","","","","","","","",{},{},{})
U_CABASX1(cPerg,"13","Ordenar por         "  ,"","","mv_ch13","N",01,0,0,"C","","","","","mv_par13","Tit.PLS ","","","","TitComissใo","","","Num.Parcela","","","","","","","","",{},{},{})
U_CABASX1(cPerg,"14","Mostrar Situac. Tit."  ,"","","mv_ch14","N",01,0,0,"C","","","","","mv_par14","Sim     ","","","","Nใo     ","","","","","","","","","","","",{},{},{})
U_CABASX1(cPerg,"15","Mostrar Regra Comis."  ,"","","mv_ch15","N",01,0,0,"C","","","","","mv_par15","Sim     ","","","","Nใo     ","","","","","","","","","","","",{},{},{})
U_CABASX1(cPerg,"16","Most.Detalhe Comis."  ,"","","mv_ch16","N",01,0,0,"C","","","","","mv_par16","Sim      ","","","","Nใo     ","","","","","","","","","","","",{},{},{})
U_CABASX1(cPerg,"17","Most.Tot por codigo"  ,"","","mv_ch17","N",01,0,0,"C","","","","","mv_par17","Sim      ","","","","Nใo     ","","","","","","","","","","","",{},{},{})
U_CABASX1(cPerg,"18","Most. s๓ Cod. Participa Comissใo"  ,"","","mv_ch18","N",01,0,0,"C","","","","","mv_par18","Sim     ","","","","Nใo     ","","","","","","","","","","","",{},{},{})
U_CABASX1(cPerg,"19","Listar Contrato    "  ,"","","mv_ch19","C",12,0,0,"G","","","","","mv_par19","         ","","","","       ","","","","","","","","","","","",{},{},{}) 
U_CABASX1(cPerg,"20","Listar Sub-Contrato"  ,"","","mv_ch20","C",09,0,0,"G","","","","","mv_par20","         ","","","","       ","","","","","","","","","","","",{},{},{})
U_CABASX1(cPerg,"21","Listar Mov.de Vidas" ,"","","mv_ch21","N",01,0,0,"C","","","","","mv_par21","Sim      ","","","","Nใo     ","","","","","","","","","","","",{},{},{})
U_CABASX1(cPerg,"22","Listar Analit comis" ,"","","mv_ch22","N",01,0,0,"C","","","","","mv_par22","Sim     ","","","","Nใo     ","","","","","","","","","","","",{},{},{})
U_CABASX1(cPerg,"23","Matricula          "  ,"","","mv_ch23","C",06,0,0,"G","","","","","mv_par23","        ","","","","        ","","","      ","","","","","","","","",{},{},{})   
U_CABASX1(cPerg,"24","Codigo Equipe      "  ,"","","mv_ch24","C",03,0,0,"G","","","","","mv_par24","        ","","","","        ","","","      ","","","","","","","","",{},{},{}) 
Return(.T.)


C
