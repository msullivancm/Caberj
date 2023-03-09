#Define CRLF Chr(13)+Chr(10)
#INCLUDE "PROTHEUS.CH"
#Include "TOPCONN.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABR168   º Autor ³Altamiro              º Data ³ 02/01/15  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Rotina para controle de Faturamento                        º±±
±±º          ³ Gerencia titulos e mitidos e a emitir , notas fiscais      º±±
±±º          ³emitidas/emitir confrontando com aruivo da receita municipalº±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/                  
//"@R !!!!.!!!!.!!!!!!.!!-!")
User Function CABR168

Local cMsg			:= ""
Private cDpj        := 'Não'   
private cImp        := 'Não'
Private oLeTxt
Private lAbortPrint :=.F.
Private cPerg       := "CABR168"
Private cTitulo     := "controle de Faturamento e emissao de NF de Saida"
Private lpvez       :=.T.   
Private cTpCrit     :=" "  
Private lImporta    := .F.  
Private f_ok        := .F. 
private lTmV        := .F. 
private lVmT        := .F.
private cCGCAnt     := ' '   
private cNfAnt      := ' '
Private nLocaliz    := 0 // 1 - zzq -- 2 se2  -- 0 nao localizado   

                                                                         
SetPrvt("oDlg1","oGrp1","oSay1","oSBtn1","oSBtn2","oSBtn3")

cMsg += " Este programa ira fazer o controle da emissao dos titulos do contas a receber emitidos e os que falta emitir ," + CRLF
cMsg += " tambem controlar as Notas Fiscais emitidas e a emitir por perfeitura atraves da leitura do arquivo CSV " + CRLF
cMsg += " relativo as   NF emitidas (Saida) de Caberj/Integral das prefeitura do rio de niteroi . " + CRLF
cMsg += " A origem dos dados é o arquivo no formato CSV baixador do site da Nota fiscal Carioca e Nota fiscal de Niteroi " + CRLF

oDlg1      := MSDialog():New( 095,232,368,705,"Leitura de Arquivo CVS",,,.F.,,,,,,.T.,,,.T. )

oGrp1      := TGroup():New( 008,012,100,224,"Arquivo CVS",oDlg1,CLR_BLACK,CLR_WHITE,.T.,.F. )
oSay1      := TSay():New( 020,020,{||cMsg},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,196,076)
oSBtn1     := SButton():New( 112,140,05,{||AjustaSX1(cPerg)}		,oDlg1,,"", )
oSBtn2     := SButton():New( 112,168,01,{||OkLeTxt(),oDlg1:End()}	,oDlg1,,"", )
oSBtn3     := SButton():New( 112,196,02,{||oDlg1:End()}			,oDlg1,,"", )

oDlg1:Activate(,,,.T.)

Return

*****************************************************************************

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFun‡„o    ³ OKLETXT  º Autor ³                    º Data ³  09/04/03   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescri‡„o ³ Funcao chamada pelo botao OK na tela inicial de processamenº±±
±±º          ³ to. Executa a leitura do arquivo texto.                    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Programa principal                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function OkLeTxt

Local nCont			:= 0     

Private  cNomeArq	:= ""
Private  cMesAdi	:= ""
Private  cAnoAdi	:= "" 
Private  cCritica   := " " 
Private  cCritImp   := " " 
//
Private  aErro		:= {}
Private  aDados     := {}     

Private  aErroN		:= {}
Private  aDadosN    := {}  
//
Private  adadosNf   := {} 
Private  aErroVlr	:= {} 
Private  aErroTit	:= {}
private  aCertosNT  := {}

Private  acabec1    :={"CGC Nf" , "Cliente" , "Valor Nf" , "Dta Emissao" , "Num. NF"  , "Situação", "Num.Tit" , "Emissao" , "Comp" , "CGC Tit" , "Nome Tit" , "Vlr Liq","Vlr Cheio" }

Private  cUsua      := SubStr(cUSUARIO,7,15)      

Private cAliastmp 	:= GetNextAlias()      
Private cAliastmp1 	:= GetNextAlias()    
private nContVet    := 1     
private sDtVet      := ' ' 

Pergunte(cPerg,.F.) 
                                 
cNomeArq	:= mv_par01 
cNomeArqN	:= mv_par02
cMesComp    := mv_par03
cAnoComp	:= mv_par04
cGExcel     := mv_par05      
cListCan    := mv_par06

if !Empty(cNomeArq)
   If !File(cNomeArq) 
       MsgStop("Arquivo Inválido! -- RJ -- Programa encerrado.")
	   Close(oLeTxt)
	   Return
   EndIf	   
EndIf         

if !Empty(cNomeArqN)
   If !File(cNomeArqN) 
       MsgStop("Arquivo Inválido! -- Niteroi -- Programa encerrado.")
	   Close(oLeTxt)
	   Return
   EndIf	   
EndIf        
  
Processa({||Processa1()}, cTitulo, "", .T.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Libera impressao                                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//   GeraRel1()   

MsgInfo("Processo finalizado")

Return                 

**************************************************************************

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFun‡„o    ³ PROCESSA1º Autor ³ Jean Schulz        º Data ³  11/11/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescri‡„o ³ Funcao auxiliar chamada pela PROCESSA.  A funcao PROCESSA  º±±
±±º          ³ monta a janela com a regua de processamento.               º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Programa principal                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function Processa1()        
/////////// NFe RJ //////////
if !Empty(cNomeArq)
   If !File(cNomeArq)
      MsgAlert("Arquivo(RJ) texto: "+cNomeArq +" não localizado","Atencao!")
      Return
   Endif

   FT_FUSE(cNomeArq)
   FT_FGOTOP()      
///////////////////////////
   ProcRegua(FT_FLASTREC()) 

   nCont := 0

   While !FT_FEOF()

       IncProc('Processando Rj ...')
   
   	   cBuffer := FT_FREADLN()		//joga o conteudo da linha na variavel
 	   FT_FSKIP() 
       aDados := separa(cBuffer,';',.T.)     
  
       if !(adados[01] $ "20|30") .OR. adados[03] = '2' .OR. trim(adados[02])=='0' .or. !(empty(adados[64]))
          loop
       EndIf  
    
       cTpCrit := " "        
       if len(adados) >= 51
          cvlr := noround(val(strtran(strtran(adados[51],'.',''),',','.')),2)  
          cCgcVet:=strtran(strtran(strtran(adados[27],'.',''),'/',''),'-','')

  		  Aadd(adadosNf, { adados[27],;
                           adados[30],;
				           cvlr,;		
						   substr(adados[05],1,10) ,; 	  
						   adados[02],;
					       adados[51],;
						   cCgcVet ,;
						   'Nfe Rio' })                                   
       EndIf
  EndDo     

 // aSort(adadosNF,,,{ |x,y| x[7]+x[6] <  y[7]+y[6] } )   
EndIf

//////// NFe Niteroi /////
if !Empty(cNomeArqN)
   If !File(cNomeArqN)
      MsgAlert("Arquivo(Niteroi) texto: "+cNomeArqN +" não localizado","Atencao!")
      Return
   Endif

   FT_FUSE(cNomeArqN)
   FT_FGOTOP()      
///////////////////////////
   ProcRegua(FT_FLASTREC()) 

   nCont := 0

   While !FT_FEOF()

       IncProc('Processando Niteroi ...')
   
   	   cBuffer := FT_FREADLN()		//joga o conteudo da linha na variavel
 	   FT_FSKIP() 
       aDadosN := separa(cBuffer,';',.T.)     
  
       if (substr(adadosN[36],4,4)) != cAnoComp
          loop
       EndIf  
    
       cTpCrit := " "        

       cvlr := noround(val(strtran(strtran(adadosN[19],'.',''),',','.')),2)  
       cCgcVet:=strtran(strtran(strtran(adadosN[12],'.',''),'/',''),'-','')

       Aadd(adadosNf, { adadosN[12] ,;
                        adadosN[7]  ,;
				        cvlr        ,;		
                        adadosN[33] ,; 	  
                        substr(adadosN[17],5,15) ,;
					    adadosN[19] ,;
						cCgcVet     ,;
						adadosN[1]})                                   
       
  EndDo     

//  aSort(adadosNF,,,{ |x,y| x[7]+x[6] <  y[7]+y[6] } )   
EndIf
///////////////////////////    
 aSort(adadosNF,,,{ |x,y| x[7]+x[6] <  y[7]+y[6] } )  
 

///////////////////////////          
cQuery :=CRLF+" SELECT distinct origem , munic , codemp , diavenc , a1_cod ||'-'|| a1_nome Cliente, a1_cgc , "      

cQuery +=CRLF+       " DECODE(A1_PESSOA ,'J',  "
cQuery +=CRLF+       " SUBSTR(A1_CGC,1,2)||'.'||SUBSTR(A1_CGC,3,3)||'.'||SUBSTR(A1_CGC,6,3)||'/'||SUBSTR(A1_CGC,9,4)||'-'||SUBSTR(A1_CGC,13,2), "
cQuery +=CRLF+       " SUBSTR(A1_CGC,1,3)||'.'||SUBSTR(A1_CGC,4,3)||'.'||SUBSTR(A1_CGC,7,3)||'-'||SUBSTR(A1_CGC,10,2))   CGCCPF , qtda , "

cQuery +=CRLF+" nVL(E1_PREFIXO||E1_NUM||E1_PARCELA||E1_TIPO,'Não Localizada') titulos , "
cQuery +=CRLF+" nvl(e1_emissao ,' ' ) emissao , nvl(e1_vencrea ,' ' ) vencto, e1_baixa , DATBLO, nVL(E1_VALOR,0.00) VlrTit  , nVL(E1_saldo,0.00) vlrsaldo, "
cQuery +=CRLF+" decode(nvl(TRIM(E5_HISTOR),' '),'Titulo cancelado pelo Plano de Saude.' ,TRIM(E5_HISTOR), ' ' )historico , NVL(E5_MOTBX, 'Nao Localizado') motbx "

cQuery +=CRLF+" FROM "+ RetSqlName("SE1") +" SE1 , " + RetSqlName("SA1") +" SA1 , " + RetSqlName("SE5") +" SE5 ,(" 
cQuery +=CRLF+          " select 'usuario' origem,ba1_munici munic, ba1_codemp ||'-'|| nvl(bg9_descri,' ') Codemp, ba1_vencto DiaVenc , BA1_CODCLI codcli , BA1_DATBLO DATBLO , 1 qtda "
cQuery +=CRLF+          "   FROM "+ RetSqlName("BA1") +" BA1 , " + RetSqlName("Bg9") +" Bg9 " 
cQuery +=CRLF+          "  where  ba1_filial = '"+(xFilial("BA1"))+"' and ba1.d_E_L_E_T_ = ' ' "
cQuery +=CRLF+          "    and bg9_filial(+) = '"+(xFilial("BG9"))+"' and bg9.d_E_L_E_T_ (+) = ' '  and bg9_codigo(+)= ba1_codemp "
cQuery +=CRLF+          "    and ba1_cobniv ='1' and (SUBSTR(BA1_DATBLO,1,6) > '"+cAnoComp+cMesComp+"' OR BA1_DATBLO = ' ' ) and ba1_codcli <> ' ' " 

cQuery +=CRLF+ " UNION ALL "
cQuery +=CRLF+          " select 'familia - '|| BA3_CODINT ||'.'||BA3_CODEMP ||'.'||BA3_MATRIC ORIGEM ,ba3_mun munic , ba3_codemp ||'-'|| nvl(bg9_descri,' ' ) Codemp, ba3_vencto DiaVenc , BA3_CODCLI codcli , BA3_DATBLO DATBLO , COUNT(*) QTDA"
cQuery +=CRLF+          "   FROM "+ RetSqlName("BA3") +" BA3 , " + RetSqlName("Bg9") +" Bg9 , " + RetSqlName("BA1") +" BA1  " 
cQuery +=CRLF+          "  where ba3_filial = '"+(xFilial("BA3"))+"' and ba3.d_E_L_E_T_ = ' ' "
cQuery +=CRLF+          "    and bg9_filial(+) = '"+(xFilial("BG9"))+"' and bg9.d_E_L_E_T_ (+) = ' '  and bg9_codigo(+)= ba3_codemp "
cQuery +=CRLF+          "    and ba3_cobniv = '1' and (SUBSTR(ba3_DATBLO,1,6) > '"+cAnoComp+cMesComp+"' OR BA3_DATBLO = ' ' ) and ba3_codcli <> ' ' "   

cQuery +=CRLF+          "    AND BA1_FILIAL = '  '  AND BA1.D_E_L_E_T_ =  ' '  AND BA3_CODINT = BA1_CODINT AND BA3_CODEMP = BA1_CODEMP   "
cQuery +=CRLF+          "    AND BA3_MATRIC = BA1_MATRIC AND ( SUBSTR(BA1_DATBLO,1,6) > '"+cAnoComp+cMesComp+"' OR BA1_DATBLO = ' ' ) "
cQuery +=CRLF+          "    GROUP BY  'familia - '|| BA3_CODINT ||'.'||BA3_CODEMP ||'.'||BA3_MATRIC , BA3_MUN  , BA3_CODEMP ||'-'|| NVL(BG9_DESCRI,' ' ) , "
cQuery +=CRLF+          "              BA3_VENCTO , BA3_CODCLI  , BA3_DATBLO   "

cQuery +=CRLF+ " UNION ALL "
cQuery +=CRLF+          " SELECT  'subcontrato - '||bqc_numcon||'.' ||bqc_subcon origem ,bqc_mun munic , bqc_codemp ||'-'|| nvl(bg9_descri, ' ' ) Codemp, bqc_vencto DiaVenc, BQC_CODCLI codcli , BQC_DATBLO DATBLO , count(*) qtda "
cQuery +=CRLF+          "   FROM "+ RetSqlName("BQC") +" BQC , " + RetSqlName("Bg9") +" Bg9 , " + RetSqlName("BA1") +" BA1  "
cQuery +=CRLF+          " WHERE BQC_FILIAL = '"+(xFilial("BQC"))+"' AND bqc.D_e_l_e_t_ =  ' ' "
cQuery +=CRLF+          " and bg9_filial(+) = '"+(xFilial("BG9"))+"' and bg9.d_E_L_E_T_ (+) = ' '  and bg9_codigo(+)= bqc_codemp "
cQuery +=CRLF+          " AND BQC_COBNIV = '1' and (SUBSTR(bQC_DATBLO,1,6) > '"+cAnoComp+cMesComp+"' OR BQC_DATBLO = ' ' ) and bqc_codcli <> ' ' "    

cQuery +=CRLF+          " and BA1_FILIAL = '  ' AND BA1.D_e_l_e_t_ =  ' ' AND ba1_codemp = bqc_codemp and ba1_conemp = bqc_numcon and ba1_vercon = bqc_vercon "
cQuery +=CRLF+          " and bqc_subcon = ba1_subcon and bqc_versub = ba1_versub and (SUBSTR(ba1_DATBLO,1,6) > '"+cAnoComp+cMesComp+"' OR ba1_DATBLO = ' ' ) "
   
cQuery +=CRLF+          " group by 'subcontrato - '||bqc_numcon ||'.'||bqc_subcon ,bqc_mun  , bqc_codemp ||'-'|| nvl(bg9_descri, ' ' ) , bqc_codcli , "
cQuery +=CRLF+          " bqc_vencto , BQC_CODCLI  , BQC_DATBLO " 

cQuery +=CRLF+ " UNION ALL "
cQuery +=CRLF+          " SELECT 'contrato' origem,'Não Informado' munic, bt5_codigo ||'-'|| nvl(bg9_descri,' ')Codemp, bt5_vencto DiaVenc ,BT5_CODCLI codcli , ' ' DATBLO , count(*) qtda "
cQuery +=CRLF+          "   FROM "+ RetSqlName("BT5") +" BT5 , " + RetSqlName("Bg9") +" Bg9 , " + RetSqlName("BA1") +" BA1  "
cQuery +=CRLF+          "  WHERE BT5_FILIAL = '"+(xFilial("BT5"))+"' AND bt5.D_e_l_e_t_ =  ' ' "
cQuery +=CRLF+          "    and bg9_filial(+) = '"+(xFilial("BG9"))+"' and bg9.d_E_L_E_T_ (+) = ' '  and bg9_codigo(+)= bt5_codigo "
cQuery +=CRLF+          "    AND BT5_COBNIV = '1'  and bt5_codcli <> ' ' " 
  
cQuery +=CRLF+          "    and BA1_FILIAL = '  ' AND BA1.D_e_l_e_t_ =  ' ' AND ba1_codemp = bt5_codigo and ba1_conemp = bt5_numcon and ba1_vercon = bt5_versao "
cQuery +=CRLF+          "    and (SUBSTR(ba1_DATBLO,1,6) > '"+cAnoComp+cMesComp+"' OR ba1_DATBLO = ' ' ) "
cQuery +=CRLF+          "    group by 'contrato '||bt5_numcon ,'Não Informado' , bt5_codigo ||'-'|| nvl(bg9_descri,' '), bt5_vencto ,BT5_CODCLI , ' ' " 

cQuery +=CRLF+          ") cliente "
cQuery +=CRLF+ " where a1_filial = '"+(xFilial("SA1"))+"'and sa1.d_E_L_E_T_ = ' ' " 
cQuery +=CRLF+   " and e1_filial(+) = '"+(xFilial("SE2"))+"' and se1.d_E_L_E_T_(+) = ' ' "   
cQuery +=CRLF+   " and E5_FILIAL(+) = '"+(xFilial("SE5"))+"' and se5.d_E_L_E_T_(+) = ' ' "
cQuery +=CRLF+   " and a1_cod = cliente.codcli and e1_prefixo(+ )not in ('RLE' , 'FAT' )"  

//cQuery +=CRLF+   " AND e1_prefixo = 'PLS' and e1_num = '000035873'     

if cListCan  == 2  
   cQuery +=CRLF+  "and  se5.e5_motbx(+) <> 'CAN' "
Endif   

cQuery +=CRLF+   " and E1_anoBASE(+) = '"+cAnoComp+"' and E1_mesBASE(+) = '"+cMesComp+"' AND  a1_cod = E1_CLIENTE(+) "
cQuery +=CRLF+   " and e5_prefixo(+) = e1_prefixo and e5_numero(+) = e1_num " 
cQuery +=CRLF+   " and nvl(se5.e5_seq,' ') = nvl((select max(e5_seq) "                          
cQuery +=CRLF+                                    " FROM "+ RetSqlName("SE5") +" se51 "
cQuery +=CRLF+                                   " where se51.E5_FILIAL = '"+(xFilial("SE5"))+"' and se51.d_E_L_E_T_ = ' ' "
cQuery +=CRLF+                                     " and se51.e5_prefixo = se1.e1_prefixo and se51.e5_numero = se1.e1_num) ,' ' ) "
cQuery +=CRLF+   " order by a1_cgc
              


 If Select((cAliastmp)) <> 0 
       (cAliastmp)->(DbCloseArea()) 
 Endif
  
 TCQuery cQuery New Alias (cAliastmp)  
    
 dbSelectArea(cAliastmp)
   
 (cAliastmp)->(dbGoTop())   
    
While (cAliastmp)->(!Eof()) .and. len(adadosNf) > nContVet       
                                                          
    cgcvet   := adadosNf[nContVet, 7]
    cgcarq   := A1_CGC // strtran(strtran(strtran((cAliastmp)->CGCCPF,'.',''),'/',''),'-','')
    sDtVet   := ( substr(adadosNf[nContVet, 4], 7,4) + substr(adadosNf[nContVet, 4], 4,2) + substr(adadosNf[nContVet, 4], 1,2) )
 if trim(cgcvet) ==  trim(cgcarq) .AND. (cAliastmp)->EMISSAO <=  sDtVet .and. (cAliastmp)->EMISSAO != ' '   ;
      .and. (cAliastmp)->(!Eof()) .AND. len(adadosNf) > nContVet    .AND. (cAliastmp)->MOTBX <> 'CAN'
 
   Aadd(aCertosNT, {(cAliastmp)->ORIGEM  ,;
					(cAliastmp)->MUNIC   ,;
					(cAliastmp)->CODEMP  ,;
					(cAliastmp)->DIAVENC ,;
					(cAliastmp)->CLIENTE ,;
					(cAliastmp)->CGCCPF  ,;
					(cAliastmp)->TITULOS ,;
					(cAliastmp)->EMISSAO ,;
					(cAliastmp)->VENCTO  ,;
					(cAliastmp)->E1_BAIXA,;
					(cAliastmp)->DATBLO  ,;
					(cAliastmp)->VlrTit  ,;
					(cAliastmp)->vlrsaldo,;
					(cAliastmp)->HISTORICO,;
					(cAliastmp)->MOTBX,; 
					(cAliastmp)->qtda ,;
		   		    '<=======> ',; 
  				    adadosNf[nContVet, 1],;
	                adadosNf[nContVet, 2],;
					adadosNf[nContVet, 3],;		
			        adadosNf[nContVet, 4] ,; 	  
					adadosNf[nContVet, 5] ,;
					adadosNf[nContVet, 8]})         
     
       (cAliasTmp)->(DbSkip())
        nContVet++  
        loop                                                          
 ElseIf trim(cgcarq) > trim(cgcvet)  .OR.((cAliastmp)->(Eof()) .AND. len(adadosNf) > nContVet )
   Aadd(aErroTit,{ ' '   ,;
					' '   ,;
					' '   ,;
					' '   ,;
					' '   ,;
					' '   ,;
					' '   ,;
					' '   ,;
					' '   ,;
					' '   ,;
					' '   ,;
					0.00  ,;
					0.00  ,;
					' '   ,;
					' '   ,;
		   		    '>>>>> ',; 
  				    adadosNf[nContVet, 1],;
	                adadosNf[nContVet, 2],;
					adadosNf[nContVet, 3],;		
			        adadosNf[nContVet, 4],; 	  
					adadosNf[nContVet, 5],;
					adadosNf[nContVet, 8]})             
        nContVet++  
        loop
 Elseif trim(cgcarq) < trim(cgcvet)  .or.(cAliastmp)->(!Eof()) .or. (cAliastmp)->EMISSAO == ' '              
  Aadd(aCertosNT, {(cAliastmp)->ORIGEM  ,;
					(cAliastmp)->MUNIC   ,;
					(cAliastmp)->CODEMP  ,;
					(cAliastmp)->DIAVENC ,;
					(cAliastmp)->CLIENTE ,;
					(cAliastmp)->CGCCPF ,;
					(cAliastmp)->TITULOS ,;
					(cAliastmp)->EMISSAO ,;
					(cAliastmp)->VENCTO  ,;
					(cAliastmp)->E1_BAIXA,;
					(cAliastmp)->DATBLO  ,;
					(cAliastmp)->VlrTit  ,;
					(cAliastmp)->vlrsaldo,;
					(cAliastmp)->HISTORICO,;
					(cAliastmp)->MOTBX,;
					(cAliastmp)->qtda ,;
		   		    '<<<<<<< ',; 
  				         ' '  ,;                                                                            
                         ' '  ,;
		                 0.00 ,;		
			      '  /  /  '  ,; 	  
		                  ' ' ,;
		                  ' ' })      
                 (cAliasTmp)->(DbSkip()) 
           loop    
 EndIf   
    
EndDo     

DlgToExcel({{"ARRAY","erro de Tit/Nf "   ,aCabec1,aErroTit}}) 
DlgToExcel({{"ARRAY","Processo  Tit/Nf " ,aCabec1,aCertosNT}}) 
//DlgToExcel({{"ARRAY","Processo  Tit/Nf " ,aCabec1,aErroVlr}})

Return  
/////////////////////////

******************************************************************************************

Static Function AjustaSX1(cPerg)

Local aHelpPor := {}

PutSx1(cPerg,"01",OemToAnsi("Arquivo Nf Rio de janeiro ")	,"","","mv_ch1","C",060,0,0,"G","U_fGetFile('csv (*.csv) | *.csv | ')","","","","mv_par01","","","","","","","","","","","","","","","","",aHelpPor,{},{}) 
PutSx1(cPerg,"02",OemToAnsi("Arquivo Nf RNiteroi")	,"","","mv_ch2","C",060,0,0,"G","U_fGetFile('csv (*.csv) | *.csv | ')","","","","mv_par02","","","","","","","","","","","","","","","","",aHelpPor,{},{})
PutSx1(cPerg,"03",OemToAnsi("Mes Competencia") 		        ,"","","mv_ch3","C",02,0,0,"G","","","","","mv_par03","","","","","","","","","","","","","","","","",aHelpPor,{},{})
PutSx1(cPerg,"04",OemToAnsi("Ano Competencia") 		        ,"","","mv_ch4","C",04,0,0,"G","","","","","mv_par04","","","","","","","","","","","","","","","","",aHelpPor,{},{})
PutSx1(cPerg,"05",OemToAnsi("Gerar Excel ") 	         	,"","","mv_ch5","N",01,0,0,"C","","","","","mv_par05","Sim","","","","Não","","","","","","","","","","","",{},{},{}) 
PutSx1(cPerg,"06",OemToAnsi("Listar Tit. Canc.Pelo Pls")  	,"","","mv_ch6","N",01,0,0,"C","","","","","mv_par06","Sim","","","","Não","","","","","","","","","","","",{},{},{}) 

Pergunte(cPerg,.T.)

Return

