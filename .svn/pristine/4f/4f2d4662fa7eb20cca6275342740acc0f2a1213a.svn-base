#Define CRLF Chr(13)+Chr(10)
#INCLUDE "PROTHEUS.CH"
#Include "TOPCONN.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABR162   º Autor ³Altamiro              º Data ³ 21/11/14  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Rotina para  Critica de NF carioca de saida                º±±
±±º          ³ conforme arquivo importado do site da receita municipal    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/                  

User Function CABR162

Local cMsg			:= ""
Private cDpj        := 'Não'   
private cImp        := 'Não'
Private oLeTxt
Private lAbortPrint :=.F.
Private cPerg       := "CABR162"
Private cTitulo     := "Critica NF Carioca de Saida"
Private lpvez       :=.T.   
Private cTpCrit     :=" "  
Private lImporta    := .F.  
Private f_ok        := .F. 
private lTmV        := .F. 
private lVmT        := .F.
private cCGCAnt     := ' '   
private cNfAnt      := ' '
Private nLocaliz    := 0 // 1 - zzq -- 2 se2  -- 0 nao localizado       
PRIVATE lCancel     := .F.

                                                                         
SetPrvt("oDlg1","oGrp1","oSay1","oSBtn1","oSBtn2","oSBtn3")

cMsg += " Este programa ira fazer a leitura do arquivo CSV  relativo as   " + CRLF
cMsg += " NF emitidas (Saida) de Caberj/Integral . A origem dos dados é o " + CRLF
cMsg += " arquivo no formato CSV baixador do site da NOTA FISCAL CARIOCA  " + CRLF

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

Pergunte(cPerg,.F.) 

cNomeArq	:= mv_par01     
cNomeArqN	:= mv_par02
dDtInic		:= dtos(mv_par03)
dDtFim		:= dtos(mv_par04) 
cMesComp    := mv_par05
cAnoComp	:= mv_par06
cGExcel     := mv_par07                     

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
       if adadosN[01] == 'Cancelada'
          lCancel:= .T.
       EndIf  
       if adadosN[01] == 'Emitida'
          lCancel:= .F.
       EndIf 
       if (substr(adadosN[33],7,4)) != substr(dDtInic,1,4) .or. lCancel
          loop
       EndIf  
    
       cTpCrit := " "        

       cvlr := noround(val(strtran(strtran(adadosN[19],'.',''),',','.')),2)  
       cCgcVet:=strtran(strtran(strtran(adadosN[12],'.',''),'/',''),'-','')

       Aadd(adadosNf, { adadosN[12] ,;
                        adadosN[7]  ,;
				        cvlr        ,;		
                        adadosN[33] ,; 	  
                        substr(adadosN[17],5,11) ,;
					    adadosN[19] ,;
						cCgcVet     ,;
						adadosN[1]})                                   
       
  EndDo     

//  aSort(adadosNF,,,{ |x,y| x[7]+x[6] <  y[7]+y[6] } )   
EndIf
///////////////////////////    
 aSort(adadosNF,,,{ |x,y| x[7]+x[6] <  y[7]+y[6] } )  
 
cQuery :=CRLF+" SELECT E1_PREFIXO || E1_NUM || E1_TIPO tit, " 
cQuery +=CRLF+       " SUBSTR(E1_EMISSAO,7,2) ||'/'||SUBSTR(E1_EMISSAO,5,2) ||'/'||SUBSTR(E1_EMISSAO,1,4) EMISSAO, "   
cQuery +=CRLF+       " E1_ANOBASE||E1_MESBASE comp ,  A1_CGC , " 
cQuery +=CRLF+       " DECODE(A1_PESSOA ,'J',  "
cQuery +=CRLF+       " SUBSTR(A1_CGC,1,2)||'.'||SUBSTR(A1_CGC,3,3)||'.'||SUBSTR(A1_CGC,6,3)||'/'||SUBSTR(A1_CGC,9,4)||'-'||SUBSTR(A1_CGC,13,2), "
cQuery +=CRLF+       " SUBSTR(A1_CGC,1,3)||'.'||SUBSTR(A1_CGC,4,3)||'.'||SUBSTR(A1_CGC,7,3)||'-'||SUBSTR(A1_CGC,10,2))   CGCCPF  , A1_NOME nome , " 
cQuery +=CRLF+       " SUM (DECODE ( BM1_TIPO , 1 ,BM1_VALOR, (BM1_VALOR*-1))) vlsbx , e1_valor  VlrCheio  "      
cQuery +=CRLF+  " FROM "+ RetSqlName("SE1") +" SE1 , " + RetSqlName("SA1") +" SA1 , " + RetSqlName("BM1") +" BM1 " 
cQuery +=CRLF+ " WHERE E1_FILIAL  = '"+(xFilial("SE2"))+"' AND SE1.D_e_l_e_t_ = ' ' "  
cQuery +=CRLF+   " AND BM1_FILIAL = '"+(xFilial("BM1"))+"' AND BM1.D_e_l_e_t_ = ' ' "    
cQuery +=CRLF+   " AND A1_FILIAL  = '"+(xFilial("SA1"))+"' AND SA1.D_e_l_e_t_ = ' ' "
cQuery +=CRLF+   " AND BM1_CODTIP <> '903' AND BM1_PREFIX = E1_PREFIXO AND BM1_NUMTIT = E1_NUM  "
cQuery +=CRLF+   " AND E1_ANOBASE||E1_MESBASE = '"+cAnoComp+cMesComp+"' " 
cQuery +=CRLF+   " AND A1_COD = E1_CLIENTE AND E1_PREFIXO = 'PLS' "
cQuery +=CRLF+   " AND A1_FILIAL = ' ' AND SA1.D_e_l_e_t_ = ' ' "
cQuery +=CRLF+   " AND NOT EXISTS (SELECT * FROM "+ RetSqlName("SE5") +" SE5 WHERE E5_FILIAL = '"+(xFilial("SE5"))+"' and d_E_L_E_T_ = ' ' and e5_prefixo = e1_prefixo "
cQuery +=CRLF+                      " and e5_numero = e1_num  AND TRIM(E5_HISTOR) = 'Titulo cancelado pelo Plano de Saude.' ) "
cQuery +=CRLF+   " group by E1_PREFIXO , E1_NUM , E1_TIPO , e1_valor , E1_EMISSAO, E1_ANOBASE||E1_MESBASE, A1_CGC ,A1_PESSOA , A1_NOME "
cQuery +=CRLF+   " order by 4,8 "


 If Select((cAliastmp)) <> 0 
       (cAliastmp)->(DbCloseArea()) 
 Endif
  
 TCQuery cQuery New Alias (cAliastmp)  
    
 dbSelectArea(cAliastmp)
   
 (cAliastmp)->(dbGoTop())   
    
While (cAliastmp)->(!Eof()) .and. len(adadosNf) > nContVet       
                                                          
    cgcvet:= adadosNf[nContVet, 7]
    cgcarq:= A1_CGC // strtran(strtran(strtran((cAliastmp)->CGCCPF,'.',''),'/',''),'-','')
    
 if trim(cgcvet) ==  trim(cgcarq) .AND. (cAliastmp)->(!Eof()) .AND. len(adadosNf) > nContVet 
    if adadosNf[nContVet, 3] == (cAliastmp)->vlsbx  
    
       Aadd(aCertosNT, { adadosNf[nContVet, 1],; 
             		     adadosNf[nContVet, 2],;
				         adadosNf[nContVet, 3],;		
						 adadosNf[nContVet, 4] ,; 	  
						 adadosNf[nContVet, 5],; 
					 	 adadosNf[nContVet, 8],;
						  '======= ',; 
						 (cAliastmp)->tit ,;
						 (cAliastmp)->emissao ,;
						 (cAliastmp)->comp ,;
						 (cAliastmp)->CGCCPF ,;
						 (cAliastmp)->Nome ,;
						 (cAliastmp)->Vlsbx	 , ;
						 (cAliastmp)->VlrCheio})         
     
       (cAliasTmp)->(DbSkip())
        nContVet++  
        loop                                                          
    ElseIf adadosNf[nContVet, 3] > (cAliastmp)->vlsbx     
           Aadd(aErroVlr, {adadosNf[nContVet, 1] ,;
                        adadosNf[nContVet, 2] ,;
				        adadosNf[nContVet, 3] ,;		
						adadosNf[nContVet, 4] ,; 	  
						adadosNf[nContVet, 5] ,;    
						adadosNf[nContVet, 8] ,;
					    ' >>>>>>> ',; 
					   (cAliastmp)->tit ,;
				       (cAliastmp)->emissao ,;
				       (cAliastmp)->comp ,;
				       (cAliastmp)->CGCCPF ,;
				       (cAliastmp)->Nome ,;
				       (cAliastmp)->Vlsbx , ;
					   (cAliastmp)->VlrCheio})                                       

		  if cCGCAnt  ==  trim(cgcvet)  .and. cNfAnt == adadosNf[nContVet, 5]                           
             Aadd(aCertosNT, {  ' '  ,;
                                ' '  ,;
		                        0.00 ,;		
			   		     '  /  /  '  ,; 	  
		                        ' '  ,; 
								' '  ,; 		                        
						     '>>>>> ',; 
						 (cAliastmp)->tit ,;
						 (cAliastmp)->emissao ,;
						 (cAliastmp)->comp ,;
						 (cAliastmp)->CGCCPF ,;
						 (cAliastmp)->Nome ,;
						 (cAliastmp)->Vlsbx, ;
						 (cAliastmp)->VlrCheio })                
           else 
               Aadd(aCertosNT, { adadosNf[nContVet, 1],;
             		     adadosNf[nContVet, 2],;
				         adadosNf[nContVet, 3],;		
						 adadosNf[nContVet, 4] ,; 	  
						 adadosNf[nContVet, 5],;
 						 adadosNf[nContVet, 8],;
						  '>>>>> ',; 
						 (cAliastmp)->tit ,;
						 (cAliastmp)->emissao ,;
						 (cAliastmp)->comp ,;
						 (cAliastmp)->CGCCPF ,;
						 (cAliastmp)->Nome ,;
						 (cAliastmp)->Vlsbx , ;
						 (cAliastmp)->VlrCheio})         
			     cCGCAnt :=  trim(cgcvet)	  
			     cNfAnt  := adadosNf[nContVet, 5] 	 
		  EndIf				 
              (cAliasTmp)->(DbSkip())
           loop  
    Else      
     	Aadd(aErroVlr, {adadosNf[nContVet, 1],;
             		     adadosNf[nContVet, 2],;
				         adadosNf[nContVet, 3],;		
						 adadosNf[nContVet, 4] ,; 	  
						 adadosNf[nContVet, 5],;
					 	 adadosNf[nContVet, 8],;
					    ' >>>>>>> ',; 
					   (cAliastmp)->tit ,;
				       (cAliastmp)->emissao ,;
				       (cAliastmp)->comp ,;
				       (cAliastmp)->CGCCPF ,;
				       (cAliastmp)->Nome ,;
				       (cAliastmp)->Vlsbx, ;
				       (cAliastmp)->VlrCheio })         
				                                     
				                              
        if cCGCAnt  ==  trim(cgcarq)
       	      Aadd(aCertosNT, {adadosNf[nContVet, 1],;
             		     adadosNf[nContVet, 2],;
				         adadosNf[nContVet, 3],;		
						 adadosNf[nContVet, 4] ,; 	  
						 adadosNf[nContVet, 5],; 
						 adadosNf[nContVet, 8],;						 
						  '>>>>> ',; 
					   	 	  ' ' ,;
					   '  /  /  ' ,;
					         ' '  ,;
					          ' ' ,;
					         ' '  ,;
				             0.00 ,;
				             0.00 }) 
          
          else 
               Aadd(aCertosNT, { adadosNf[nContVet, 1],;
             		     adadosNf[nContVet, 2],;
				         adadosNf[nContVet, 3],;		
						 adadosNf[nContVet, 4] ,; 	  
						 adadosNf[nContVet, 5],;
						 adadosNf[nContVet, 8],;						 
						  '<<<<< ',; 
						 (cAliastmp)->tit ,;
						 (cAliastmp)->emissao ,;
						 (cAliastmp)->comp ,;
						 (cAliastmp)->CGCCPF ,;
						 (cAliastmp)->Nome ,;
						 (cAliastmp)->Vlsbx , ;
						 (cAliastmp)->VlrCheio})         
			            
			     cCGCAnt  :=  trim(cgcarq)		 
		  EndIf	
                nContVet++                                                            
                loop
    EndIf          
 ElseIf  trim(cgcarq) > trim(cgcvet) .OR. ((cAliastmp)->(Eof()) .AND. len(adadosNf) > nContVet )
    If cCGCAnt != trim(cgcvet) 
	 	Aadd(aErroTit, {adadosNf[nContVet, 1],;
	                    adadosNf[nContVet, 2],;
					    adadosNf[nContVet, 3],;		
			            adadosNf[nContVet, 4] ,; 	  
						adadosNf[nContVet, 5],;
						adadosNf[nContVet, 8],;						
			            '>>>>> ',; 
						 ' ' ,;
						 '  /  /  ' ,;
						 ' '  ,;
						 ' ' ,;
						 ' '  ,;
						 0.00 ,;
						 0.00 })       
						   
    EndIf  
                              
       nContVet++  
       loop
 
 ElseiF trim(cgcarq) < trim(cgcvet)  .or.(cAliastmp)->(!Eof()) .AND. len(adadosNf) < nContVet                 
        If cCGCAnt != trim(cgcarq) 
    	   Aadd(aErroTit, { ' '  ,;
                         ' '  ,;
		                 0.00 ,;		
			      '  /  /  '  ,; 	  
		                 ' '  ,;
	                     ' '  ,;
					  '<<<<< ',; 
					 (cAliastmp)->tit ,;
					 (cAliastmp)->emissao ,;
					 (cAliastmp)->comp ,;
					 (cAliastmp)->CGCCPF ,;
					 (cAliastmp)->Nome ,;
					 (cAliastmp)->Vlsbx	 , ;
					 (cAliastmp)->VlrCheio})         
        EndIf                                                                                               
        
           (cAliasTmp)->(DbSkip()) 
           loop    
 EndIf   
    
EndDo     

DlgToExcel({{"ARRAY","erro de Tit/Nf " ,aCabec1,aErroTit}}) 
DlgToExcel({{"ARRAY","Processo  Tit/Nf " ,aCabec1,aCertosNT}}) 
DlgToExcel({{"ARRAY","Processo  Tit/Nf " ,aCabec1,aErroVlr}})

Return  
/////////////////////////

******************************************************************************************

Static Function AjustaSX1(cPerg)

Local aHelpPor := {}

PutSx1(cPerg,"01",OemToAnsi("Arquivo Nfe RJ ")		     	,"","","mv_ch1","C",060,0,0,"G","U_fGetFile('csv     (*.csv)            | *.csv | ')","","","","mv_par01","","","","","","","","","","","","","","","","",aHelpPor,{},{})
PutSx1(cPerg,"02",OemToAnsi("Arquivo Nfe Niteroi ")	     	,"","","mv_ch2","C",060,0,0,"G","U_fGetFile('csv     (*.csv)            | *.csv | ')","","","","mv_par02","","","","","","","","","","","","","","","","",aHelpPor,{},{})
PutSx1(cPerg,"03",OemToAnsi("Data Inicio Emissao Nf ") 		,"","","mv_ch3","D",10,0,0,"G","","","","","mv_par03","","","","","","","","","","","","","","","","",aHelpPor,{},{})
PutSx1(cPerg,"04",OemToAnsi("Data Fim Emissao Nf "   ) 		,"","","mv_ch4","D",10,0,0,"G","","","","","mv_par04","","","","","","","","","","","","","","","","",aHelpPor,{},{})
PutSx1(cPerg,"05",OemToAnsi("Mes Competencia") 		        ,"","","mv_ch5","C",02,0,0,"G","","","","","mv_par05","","","","","","","","","","","","","","","","",aHelpPor,{},{})
PutSx1(cPerg,"06",OemToAnsi("Ano Competencia") 		        ,"","","mv_ch6","C",04,0,0,"G","","","","","mv_par06","","","","","","","","","","","","","","","","",aHelpPor,{},{})
PutSx1(cPerg,"07",OemToAnsi("Gerar Excel ") 	         	,"","","mv_ch7","N",01,0,0,"C","","","","","mv_par07","Sim","","","","Não","","","","","","","","","","","",{},{},{}) 

Pergunte(cPerg,.T.)

Return

