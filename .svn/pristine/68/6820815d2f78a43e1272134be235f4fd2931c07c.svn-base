#INCLUDE "PROTHEUS.CH"
#Include "TOPCONN.CH"   

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABR154   º Autor ³Altamiro              º Data ³ 26/09/14  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ OTIMIZADO DO PAGAMENTO MEDICO                              º±±
±±º          ³                                                            º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/                  

User Function CABR154

Local cMsg			:= ""
Private lAbortPrint :=.F.
Private cPerg       := "CABR154"
Private cTitulo     := "Otimizador do Pagamento Medico   "        

Private cAliastmp 	:= GetNextAlias()      
Private cAliastmp1 	:= GetNextAlias() 
Private cAliastmp2 	:= GetNextAlias()  
private cRelRda     :=  ' '              
private cRelRdaf    :=  ' '
private cRelRda1    :=  ' '     
private cRelRda2    :=  ' ' 
                                                                         
//SetPrvt("oDlg1","oGrp1","oSay1","oSBtn1","oSBtn2","oSBtn3")

cMsg += " Este programa  Otimiza o processo de pagamento medico por grupo de pagamento  "

***************************************************************************    
 
Private  aDados1     := {}       
Private  acabec1     :={"Lote Custo" , "Cod. Rda" , "Cod. Fornecedor" , "Nome Fornecedor" , "Nome Operador " , "Dt Geração" , "Hora geração", "Titulo" ,"Vlr bruto" , "Saldo","Dt. Baixa" }    
                                                                                                                                                     
private Descric := ' '                                                                                                         
	  
AjustaSX1(cPerg)

If !Pergunte(cPerg,.T.)
	Return
EndIf     
                                     
cAnomes     := mv_par01                         
cGrpRdas    := FormatIn(trim(mv_par02), ",")   
cFazOtm     := mv_par03 
cDFazOtm    := mv_par04
dDtprocd    := dtos(mv_par05) 
dDtproca    := dtos(mv_par06)    
nOtmSo35    := mv_par07
norder      := mv_par08 
nGeraEx     := mv_par09 
nConsRdaBlq := mv_par10
 
nVlrAtvP    := mv_par11             
nVlrConf    := mv_par12            
nVlrDigit   := mv_par13   
nVlrFat     := mv_par14      
nCritRda    := mv_par15    

if cFazOtm != cDFazOtm  

   Processa({||Processa1()}, cTitulo, "", .T.)

   //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
   //³ Libera impressao                                                         ³
   //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
   
   // faz ecxel   
   if nGeraEx == 1 
      DlgToExcel({{"ARRAY","Rdas retirados do grupo de pagamento " ,aCabec1,aDados1}})   
   EndIf 
   fGeraRel()
   MsgInfo("Processo finalizado")
Else
   MsgInfo("Opções de Otização Conflitantes !!! Processo finalizado")
EndIf 

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

Local nI := 0

ProcRegua(FT_FLASTREC()) 

nCont := 0
IncProc('Processando...')               

if cFazOtm == 2 .and. cDFazOtm  == 1
    

	cQuery := " SELECT  BAU_CODIGO , bau_nome nome , BAU_GRPPAG GRPPAG , BAU.r_e_c_n_o_ rec "
	cQuery += " FROM  "+RetSqlName("BAU")+" BAU WHERE BAU_FILIAL = '" + xFilial('BAU') + "' AND  SUBSTR(BAU_GRPPAG,2,1) = '9' AND D_e_l_e_t_ = ' ' AND BAU_GRPPAG <> '9999' order by BAU_CODigo "
		 
	If Select((cAliastmp)) <> 0 
	          (cAliastmp)->(DbCloseArea())  
	Endif
	TCQuery cQuery Alias (cAliastmp) New 
	dbSelectArea(cAliastmp)
		                           
	(cAliastmp)->(dbGoTop()) 
 //	cNovGrpPag := (substr((cAliastmp)->GRPPAG,1,1)+"0"+substr((cAliastmp)->GRPPAG,3,2))
	While !EOF()     
          cNovGrpPag := (substr((cAliastmp)->GRPPAG,1,1)+"0"+substr((cAliastmp)->GRPPAG,3,2))		
		  cQuery := " UPDATE "+RetSqlName("BAU")+" SET BAU_GRPPAG = '"+cNovGrpPag+"' " 
		  cQuery += " WHERE  BAU_FILIAL = '" + xFilial('BAU') + "' AND bau_grppag <> '9999' and  R_E_C_N_O_ = " + str((cAliastmp)->Rec) +" "
			
		  nSucesso := TcSqlExec(cQuery)
		
		  dbSkip()   // Avanca o ponteiro do registro no arquivo
	EndDo             

else 
//////////////////////        
	/// DE AKI 20190522 - ALTAMIRO	
	cquery := CRLF+"SELECT TAB.GRPPAG , TAB.CODIGO codigotab  " 

    cquery += CRLF+ " FROM (  SELECT '1' SEQ ,BAU_GRPPAG GRPPAG ,BAU_CODIGO  CODIGO, SUM (BD7_VLRPAG) VALOR_LOTE "          
	cquery += CRLF+         " FROM "+ RetSqlName("BD7") +" BD7, " + RetSqlName("BAU") +" BAU WHERE BD7_FILIAL = '"+xFilial("BD7")+ "' "  
	cquery += CRLF+          " AND BD7.D_E_L_E_T_ = ' ' AND BD7_FASE = '4' AND BD7.BD7_SITUAC = '1' AND BD7.BD7_CODEMP <>'9999' "
	cquery += CRLF+          " AND ( BD7.BD7_CONPAG = '1' OR BD7.BD7_CONPAG = ' ') AND BD7.BD7_LOTBLO = ' ' AND BD7.BD7_BLOPAG <> '1' AND substr(BD7_NUMLOT,1,6) = '"+cAnomes+"' "
	cquery += CRLF+          " AND BD7_YFAS35 = 'T' AND BAU_FILIAL = '"+xFilial("BAU")+ "' AND BAU.D_E_L_E_T_ = ' '  AND BD7_CODRDA  = BAU_CODIGO AND BD7_VLRPAG > 0 "
	cquery += CRLF+          " AND BD7.BD7_ANOPAG ||BD7.BD7_MESPAG  >= '201501' AND BD7.BD7_ANOPAG || BD7.BD7_MESPAG <= '"+cAnomes+"'"
	cquery += CRLF+          " AND BAU.BAU_GRPPAG IN "+cGrpRdas+" " 
	cquery += CRLF+          " AND BD7_DATPRO >= '"+dDtprocd+"' AND BD7_DATPRO <=  '"+dDtproca+"' " 
	cquery += CRLF+        " GROUP BY  BAU_GRPPAG, BAU_CODIGO "
	
	cquery += CRLF+" UNION ALL "
	                          
	cquery += CRLF+       " SELECT '2' SEQ ,BAU_GRPPAG GRPPAG ,BAU_CODIGO  CODIGO, SUM (BD7_VLRPAG) VALOR_LOTE "                                    
	cquery += CRLF+         " FROM "+ RetSqlName("BD7") +" BD7, " + RetSqlName("BAU") +" BAU WHERE BD7_FILIAL = '"+xFilial("BD7")+ "' "  
	cquery += CRLF+          " AND BD7.D_E_L_E_T_ = ' ' AND BD7_FASE = '3' AND BD7.BD7_SITUAC = '1' AND BD7.BD7_CODEMP <>'9999' "
	cquery += CRLF+          " AND ( BD7.BD7_CONPAG = '1' OR BD7.BD7_CONPAG = ' ') AND BD7.BD7_LOTBLO = ' ' AND BD7.BD7_BLOPAG <> '1' AND BD7_NUMLOT = ' ' "
	cquery += CRLF+          " AND BD7_YFAS35 = 'T' AND BAU_FILIAL = '"+xFilial("BAU")+ "' AND BAU.D_E_L_E_T_ = ' '  AND BD7_CODRDA  = BAU_CODIGO AND BD7_VLRPAG > 0 "
	cquery += CRLF+          " AND BD7.BD7_ANOPAG ||BD7.BD7_MESPAG  >= '201501' AND BD7.BD7_ANOPAG || BD7.BD7_MESPAG <= '"+cAnomes+"'"
	cquery += CRLF+          " AND BAU.BAU_GRPPAG IN "+cGrpRdas+" " 
	cquery += CRLF+          " AND BD7_DATPRO >= '"+dDtprocd+"' AND BD7_DATPRO <=  '"+dDtproca+"' " 
	cquery += CRLF+        " GROUP BY  BAU_GRPPAG, BAU_CODIGO "
	                            
	cquery += CRLF+" UNION ALL "
	
	cquery += CRLF+        "SELECT '3' SEQ ,  BAU_GRPPAG GRPPAG , BAU_CODIGO CODIGO ,  SUM (BD7_VLRPAG) VALOR_LOTE "
	cquery += CRLF+         " FROM "+ RetSqlName("BD7") +" BD7, " + RetSqlName("BAU") +" BAU WHERE BD7_FILIAL = '"+xFilial("BD7")+ "' "  
	cquery += CRLF+          " AND BD7.D_E_L_E_T_ = ' ' AND BD7_FASE = '3' AND BD7.BD7_SITUAC = '1' AND BD7.BD7_CODEMP <>'9999' "
	cquery += CRLF+          " AND ( BD7.BD7_CONPAG = '1' OR BD7.BD7_CONPAG = ' ')  AND BD7.BD7_LOTBLO = ' ' AND BD7.BD7_BLOPAG <> '1' AND BD7_NUMLOT = ' ' "
	cquery += CRLF+          " AND BD7_YFAS35 = 'F' AND BAU_FILIAL = '"+xFilial("BAU")+ "' AND BAU.D_E_L_E_T_ = ' '  AND BD7_CODRDA  = BAU_CODIGO AND BD7_VLRPAG > 0 "
	cquery += CRLF+          " AND BD7.BD7_ANOPAG ||BD7.BD7_MESPAG  >= '201501' AND BD7.BD7_ANOPAG || BD7.BD7_MESPAG <= '"+cAnomes+"'"
	cquery += CRLF+          " AND BAU.BAU_GRPPAG IN "+cGrpRdas+" " 
	cquery += CRLF+          " AND BD7_DATPRO >= '"+dDtprocd+"' AND BD7_DATPRO <=  '"+dDtproca+"' " 
	cquery += CRLF+        " GROUP BY  BAU_GRPPAG , BAU_CODIGO "
	
	cquery += CRLF+" UNION ALL "
	
	cquery += CRLF+        "SELECT '4' SEQ ,  BAU_GRPPAG GRPPAG,BAU_CODIGO CODIGO , SUM (BD7_VLRPAG) VALOR_LOTE "  
	cquery += CRLF+         " FROM "+ RetSqlName("BD7") +" BD7, " + RetSqlName("BAU") +" BAU WHERE BD7_FILIAL = '"+xFilial("BD7")+ "' "   
	cquery += CRLF+          " AND BD7.D_E_L_E_T_ = ' ' AND BD7_FASE = '2' AND BD7.BD7_SITUAC = '1' AND BD7.BD7_CODEMP <>'9999' "
	cquery += CRLF+          " AND ( BD7.BD7_CONPAG = '1' OR BD7.BD7_CONPAG = ' ') AND BD7.BD7_LOTBLO = ' ' AND BD7.BD7_BLOPAG <> '1' AND BD7_NUMLOT = ' ' " 
	cquery += CRLF+          " AND BD7_YFAS35 = 'F' AND BAU_FILIAL = '"+xFilial("BAU")+ "' AND BAU.D_E_L_E_T_ = ' ' AND BD7_CODRDA  = BAU_CODIGO AND BD7_VLRPAG > 0 "
	cquery += CRLF+          " AND BD7.BD7_ANOPAG ||BD7.BD7_MESPAG  >= '201501' AND BD7.BD7_ANOPAG || BD7.BD7_MESPAG <= '"+cAnomes+"'"
	cquery += CRLF+          " AND BAU.BAU_GRPPAG IN "+cGrpRdas+" " 
	cquery += CRLF+          " AND BD7_DATPRO >= '"+dDtprocd+"' AND BD7_DATPRO <=  '"+dDtproca+"' " 
	cquery += CRLF+        " GROUP BY  BAU_GRPPAG,  BAU_CODIGO "      
	
	cquery += CRLF+" UNION ALL "
	
	cquery += CRLF+        "SELECT '5' SEQ , BAU_GRPPAG GRPPAG ,BAU_CODIGO CODIGO , COUNT (*) VALOR_LOTE "                    
	cquery += CRLF+         " FROM "+ RetSqlName("BD7") +" BD7, " + RetSqlName("BAU") +" BAU WHERE BD7_FILIAL = '"+xFilial("BD7")+ "' "  
	cquery += CRLF+          " AND BD7.D_E_L_E_T_ = ' ' AND BD7_FASE = '2' AND BD7.BD7_SITUAC = '1' AND BD7.BD7_CODEMP <>'9999' "
	cquery += CRLF+          " AND ( BD7.BD7_CONPAG = '1' OR BD7.BD7_CONPAG = ' ') AND BD7.BD7_LOTBLO = ' ' AND BD7.BD7_BLOPAG <> '1' AND BD7_NUMLOT = ' ' "
	cquery += CRLF+          " AND BD7_YFAS35 = 'F' AND BAU_FILIAL = '"+xFilial("BAU")+ "' AND BAU.D_E_L_E_T_ = ' ' AND BD7_CODRDA  = BAU_CODIGO  "
	cquery += CRLF+          " AND BD7.BD7_ANOPAG ||BD7.BD7_MESPAG  >= '201501' AND BD7.BD7_ANOPAG || BD7.BD7_MESPAG <= '"+cAnomes+"'"
	cquery += CRLF+          " AND BAU.BAU_GRPPAG IN "+cGrpRdas+" "                                   
	
	
	cquery += CRLF+          " AND BD7_DATPRO >= '"+dDtprocd+"' AND BD7_DATPRO <=  '"+dDtproca+"' " 
	cquery += CRLF+        " GROUP BY  BAU_GRPPAG,  BAU_CODIGO  ) TAB "  
	
	cquery += CRLF+" HAVING SUM (DECODE (TAB.SEQ, '2', TAB.VALOR_LOTE, 0.00)) > 0 "// ATVPRT35 ,    
    if nVlrFat     == 2 
	   cquery += CRLF+   " AND SUM (DECODE (TAB.SEQ, '1', TAB.VALOR_LOTE, 0.00)) = 0 "//ATVFATURADA , 
	EndIf               
    if nVlrAtvP    == 2 
	   cquery += CRLF+   " AND SUM (DECODE (TAB.SEQ, '3', TAB.VALOR_LOTE, 0.00)) = 0 "//ATVPRONT , 
	EndIf               
	if nVlrConf    == 2 
	   cquery += CRLF+   " AND SUM (DECODE (TAB.SEQ, '4', TAB.VALOR_LOTE, 0.00)) = 0 "// CONFEREN , 
	EndIf               
	if nVlrDigit   == 2 
	   cquery += CRLF+   " AND SUM (DECODE (TAB.SEQ, '5', TAB.VALOR_LOTE, 0.00)) = 0 "// DIGITACA , 
	EndIf    
	cquery += CRLF+ " GROUP BY TAB.GRPPAG , TAB.CODIGO  "
	cquery += CRLF+ " ORDER BY TAB.GRPPAG , TAB.CODIGO  "  
	
	If Select((cAliastmp)) <> 0 
	   (cAliastmp)->(DbCloseArea())     
	Endif
	  
	TCQuery cQuery New Alias (cAliastmp)  
	                                                                                             
	dbSelectArea(cAliastmp)
	   
	(cAliastmp)->(dbGoTop())   
	     
	While (cAliastmp)->(!Eof())                 
	      If !empty(cRelRda)
	         cRelRda:= cRelRda + ','+ (cAliastmp)->codigotab
	      Else                                        
	         cRelRda:=cRelRda+(cAliastmp)->codigotab
	      EndIf 
	      (cAliastmp)->(dbSkip()) 
	Enddo          
	
	/// ATE AKI 20190522 - ALTAMIRO	
 cQuery1 := " select bau_codigo Rdaf , count(*) "
 cQuery1 += " from " + RetSqlName('BAU') + "  BAU  where bau_filial = '" +xFilial('BAU')+"' and BAU.d_E_L_E_T_ =  ' ' AND BAU_CODSA2 = ' ' "
 cQuery1 += " group by bau_codigo " 
 cQuery1 += " union all "

 cQuery1 += " select bau_codigo Rdaf , count(*) "
 cQuery1 += " from " + RetSqlName('BAU') + "  BAU , " + RetSqlName('SA2') + " SA2 "
 cQuery1 += " where bau_filial ='"+xFilial('BAU')+"' and BAU.d_E_L_E_T_ =  ' ' AND  A2_filial = '"+xFilial('SA2')+"' and SA2.d_E_L_E_T_ =  ' '  "
 cQuery1 += " AND BAU_CODSA2 = A2_COD and (bau_codret = ' ' or bau_grppag = ' ' or A2_NATUREZ = ' ' or A2_BANCO = ' ' or A2_AGENCIA = ' ' or A2_CONTA = ' ' or (bau_codret = '0588' and A2_NATUREZ <> '40002005')) "
 cQuery1 += " group by bau_codigo " 
 
 cQuery1 += " union all " 
 
 cQuery1 += " select E2_CODRDA  Rdaf  , count(*) "  
 cQuery1 += " from " + RetSqlName('SE2') + "  SE2 , " + RetSqlName('BAU') + "  BAU "
 cQuery1 += " where  E2_filial = '"+xFilial('SE2')+"' and SE2.d_E_L_E_T_ =  ' '  " 
 cQuery1 += " AND    BAU_filial = '"+xFilial('BAU')+"' and BAU.d_E_L_E_T_ =  ' '  AND BAU.R_E_C_D_E_L_ = 0 "
 cQuery1 += " AND E2_PLLOTE LIKE '"+cAnomes+"%' and  e2_tipo = 'FT' and e2_codret = '0588' "          
 cquery1 += " AND BAU_CODIGO = E2_CODRDA  AND BAU.BAU_GRPPAG IN "+cGrpRdas+"  "                                   
 cQuery1 += " having count(*) > 0 "                                    
 cQuery1 += " group by E2_CODRDA" 
 
 
 cQuery1 += " order by 1"  
 
	If Select((cAliastmp2)) <> 0 
	   (cAliastmp2)->(DbCloseArea())     
	Endif
	  
	TCQuery cQuery1 New Alias (cAliastmp2)  
	    
	dbSelectArea(cAliastmp2)
	   
	(cAliastmp2)->(dbGoTop())
	
	aRelRDA 	:= Separa(Replace(cRelRda,' ',''),',',.F.) //Leonardo Portella - 19/11/15 - Emergencial (REVER) - Tratamento do erro "Query greater than 15980 bytes"  
	a_RelRdaf 	:= {}
	     
	While (cAliastmp2)->(!Eof()) 
	
//		If nCritRda  != 1
      	                
		    If !empty(cRelRdaf)
		    	cRelRdaf := cRelRdaf + ',' + (cAliastmp2)->rdaf
		    Else                                        
		    	cRelRdaf := cRelRdaf + (cAliastmp2)->rdaf
		    EndIf 
		    
//		Else
		
			//Leonardo Portella - 19/11/15 - Emergencial (REVER) - Tratamento do erro "Query greater than 15980 bytes"
//	      	aAdd(a_RelRdaf,(cAliastmp2)->rdaf)
	      	
//		EndIf
	    
	    (cAliastmp2)->(dbSkip())
	     
	Enddo
	
	If !empty(cRelRdaf)   
	    cRelRda1 := FormatIn(trim(cRelRdaf), ",") 
//	    iF  !empty(cRelRdaf)
//	         cRelRda2 := FormatIn(trim(cRelRdaf), ",") 
//        EndIf
	 
	   cQuery :=  " SELECT BAU_CODIGO RDA , BAU_NOME NOME , BAU_GRPPAG GRPPGT , BAU.R_E_C_N_O_ REC "
	   cQuery +=  "   FROM " +RetSqlName('BAU')+ "  BAU "
	   cQuery +=  "  WHERE BAU_FILIAL = '" + xFilial('BAU') + "' AND BAU.D_E_L_E_T_ = ' ' "
	   if nConsRdaBlq != 1 
	      cQuery +=  "      AND BAU_DATBLO = ' ' 
	   EndIf
	   cQuery +=  "  AND bau_grppag <> '9999' AND BAU.BAU_GRPPAG IN "+cGrpRdas+" " 
//       if nCritRda  != 1
   	   //cQuery +=  "  AND BAU.BAU_CODIGO  IN "+cRelRda1+"  "
//       Else 
      
      		//Leonardo Portella - 19/11/15 - Inicio - Emergencial (REVER) - Tratamento do erro "Query greater than 15980 bytes"
	      	
			//Se encontro alguém nos itens do NOT IN ( mais abaixo ) que estão no OR do IN ( mais abaixo ), excluo do NOT IN 
			//e mato o IN da query para fazer com que a query fique menor.
			//Obs: Qualquer RDA, pela lógica implementada no original deste programa, que não esteja no NOT IN entrará na  
			//query. Os RDAs que estão no NOT IN aparecerão somente se estiverem no IN.
			//Retiro de cRelRda os RDAs que estariam em cRelRdaf. cRelRdaf sempre ficará vazio aqui  
// aki altamiro	22/05/2019		

 			For nI := 1 to len(aRelRDA) 
			
				If nI > len(aRelRDA)
					Exit
				EndIf
				
			  	If ( nPos := aScan(a_RelRdaf,aRelRDA[nI]) ) > 0
			  		aDel(aRelRDA,nI)
			  		aSize(aRelRDA,len(aRelRDA) - 1)
			  	EndIf 
			  	
			Next 
	      	
	      	cRelRda1 := '('
	      	
	      	For nI := 1 to len(aRelRDA)
      	  		cRelRda1 += "'" + aRelRDA[nI] + "',"
      	  	Next
      	  	
      	  	cRelRda1 := Left(cRelRda1,len(cRelRda1) - 1) + ')'
      	  	
      	  	cQuery += CRLF+ "  AND BAU.BAU_CODIGO NOT IN " + cRelRda1 + "  "
      	  		
//      	cQuery += CRLF+ "  AND (BAU.BAU_CODIGO NOT IN "+cRelRda1+"  "	   
// 	      	cQuery += CRLF+ " OR BAU.BAU_CODIGO IN "+cRelRda2+") "

			//Leonardo Portella - 19/11/15 - Fim - Emergencial (REVER) - Tratamento do erro "Query greater than 15980 bytes"
			        
//	   EndIf 
 //	ate aki 22/05/2019 altamiro   
	   if norder == 1
          cQuery +=  "  ORDER BY 1,3 "	   
	   else 
	      cQuery +=  "  ORDER BY 3,1 "   
	  EndIf                                   
	  
	/////////////////////////////////////////*
		   	
	    If Select((cAliastmp1)) <> 0 
	       (cAliastmp1)->(DbCloseArea()) 
	    Endif
	  
	    TCQuery cQuery New Alias (cAliastmp1)  
	    
	    dbSelectArea(cAliastmp1)
	   
	    (cAliastmp1)->(dbGoTop())   
	    While (cAliastmp1)->(!Eof())   
	      aaDD(aDados1,{(cAliastmp1)->RDA    ,;                
	                    (cAliastmp1)->NOME   ,;                
	                    (cAliastmp1)->GRPPGT ,;
	                    (cAliastmp1)->REC    })    
	                                                                                                                         
 	      if cFazOtm == 1 .and. cDFazOtm  == 2
	         cNovGrpPag := (substr((cAliastmp1)->GRPPGT,1,1)+"9"+substr((cAliastmp1)->GRPPGT,3,2))   
	       
		     cQuery := " UPDATE "+RetSqlName("BAU")+" SET BAU_GRPPAG = '"+cNovGrpPag+"' WHERE bau_grppag <> '9999' and R_E_C_N_O_ = " + str((cAliastmp1)->REC)  

		     nSucesso := TcSqlExec(cQuery)
	      EndIf 
  	      (cAliastmp1)->(dbSkip())    // Avanca o ponteiro do registro no arquivo
	    EndDo 
 EndIf	    
EndIf 	   
Return                    

*************************************************************************************************************  
Static Function fGeraRel

Local oReport 
Private cPerg		:= "CABR154"  
Private aOrdem 		:= {}//{'RDA','Ano/Mes'}              
 
 

oReport:= ReportDef()
oReport:PrintDialog()

Return

*************************************************************************************************************

********************************************************************************************************************************

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³ Leonardo Portella                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpO1: Objeto do relatorio                                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/                         

Static Function ReportDef()

Local oReport 
Local oDPJ    
oReport	:= TReport():New("CABR154","Listagem de log de geração de Lote pagamento X Rda    ",, {|oReport| ReportPrt(oReport)},"Listagem de log de geração de Lote pagamento X Rda   ")
oReport:SetTotalInLine(.F.)//Imprime na linha: .F. - Imprime abaixo da linha com o titulo de cada coluna: .T.
//oReport:SetTotalText('Total Geral') 

*'-----------------------------------------------------------------------------------'*
*'Solucao para impressao em que as colunas se truncam: "SetColSpace" e "SetLandScape"'* 
*'-----------------------------------------------------------------------------------'*

oReport:SetColSpace(1) //Espacamento entre colunas. 
oReport:SetLandscape() //Impressao em paisagem.  
//oReport:SetPortrait() //Impressao em retrato.  

oDPJ := TRSection():New(oReport,"Listagem de log de geração de Lote pagamento X Rda  ",,aOrdem)             

   TRCell():New(oDPJ ,'RDA'	        		,/*TABELA*/	,'Cod. Rda'	       ,/*Picture*/ 	    ,06				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		) 
   TRCell():New(oDPJ ,'NOME'	     		,/*TABELA*/	,'Nome Rda '       ,/*Picture*/ 	    ,40				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		) 
   TRCell():New(oDPJ ,'GRPPGT'	        	,/*TABELA*/	,'Grp Pgto'        ,/*Picture*/ 	    ,04				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
   TRCell():New(oDPJ ,'RECNO'				,/*TABELA*/	,'Num. R_E_C_N_O_' ,/*Picture*/  	    ,15			 	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
  
Return(oReport)

********************************************************************************************************************************

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrint³ Autor ³ Leonardo Portella                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function ReportPrt(oReport)

Local i := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

Local   cImp    :='Não'
Private oDPJ 	:= oReport:Section(1)

Private nCont	:= 0   

nCont := Len(aDados1)

//Se nao tiver esta linha, nao imprime os dados
oDPJ:init()

oReport:SetMeter(nCont) 

cTot	:= AllTrim(Transform(nCont,'@E 999,999,999,999'))
nCont 	:= 0       

For i := 1 To Len(aDados1)

	oReport:SetMsgPrint("Imprimindo linha " + AllTrim(Transform(++nCont,'@E 999,999,999,999')) + ' de ' + cTot)

	oReport:IncMeter()

	If oReport:Cancel()  
	    
	    oReport:FatLine()     
	    oReport:PrintText('Cancelado pelo operador!!!',,,CLR_RED,,,.T.)
		
	    exit
	    
	EndIf   
 
   oDPJ:Cell('RDA'  	 ):SetValue((aDados1[i][1]))     
   oDPJ:Cell('NOME'   	 ):SetValue((aDados1[i][2]))
   oDPJ:Cell('GRPPGT' 	 ):SetValue((aDados1[i][3]))       
   oDPJ:Cell('RECNO'     ):SetValue((aDados1[i][4]))
    
   oDPJ:PrintLine()
   
Next i

oDPJ:Finish()

Return   

******************************************************************************************

Static Function AjustaSX1(cPerg)

Local aHelpPor := {}

PutSx1(cPerg,"01",OemToAnsi("Ano,Mes Competencia")      ,"","","mv_ch01","C",06,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "999999", "" )
PutSx1(cPerg,"02",OemToAnsi("Grupos pagto Rdas ")       ,"","","mv_ch02","C",99,0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","","",{},{})    
PutSx1(cPerg,"03","faz Otimização Pagto Medico?"        ,"","","mv_ch03","N",01,0,0,"C","","","","","mv_par03","Sim ","","","","Não ","","","","","","","","","","","","",{},{})                                                                                                                                                                                
putSx1(cPerg,"04","Desfaze Otimização Pagto Medico?"    ,"","","mv_ch04","N",01,0,0,"C","","","","","mv_par04","Sim ","","","","Não ","","","","","","","","","","","","",{},{})                                                                                                                                                                                
PutSx1(cPerg,"05","Considera Procedimento De  : "       ,"","","mv_ch05","D",08,0,0,"G","","","","","mv_par05","","","","","","","","","","","","","","","","","",{},{}) 
PutSx1(cPerg,"06","Considera Procedimento Ate : "       ,"","","mv_ch06","D",08,0,0,"G","","","","","mv_par06","","","","","","","","","","","","","","","","","",{},{})
PutSx1(cPerg,"07","Otimizar Somente Com 3.5  ?"         ,"","","mv_ch07","N",01,0,0,"C","","","","","mv_par07","Sim ","","","","Não ","","","","","","","","","","","","",{},{})                                                                                                                                                                                
PutSx1(cPerg,"08","Ordena ?"                            ,"","","mv_ch08","N",01,0,0,"C","","","","","mv_par08","Rda/Grp","","","","Grp/Rda","","","","","","","","","","","","",{},{})                                                                                                                                                                                
PutSx1(cPerg,"09","Gera Excel ?"                        ,"","","mv_ch09","N",01,0,0,"C","","","","","mv_par09","Sim ","","","","Não ","","","","","","","","","","","","",{},{})                                                                                                                                                                                
PutSx1(cPerg,"10","Considera Rda Bloqueados ?"          ,"","","mv_ch10","N",01,0,0,"C","","","","","mv_par10","Sim ","","","","Não ","","","","","","","","","","","","",{},{})                                                                                                                                                                                

PutSx1(cPerg,"11","Com Vlr em Ativa pronta  ?"          ,"","","mv_ch11","N",01,0,0,"C","","","","","mv_par11","Sim ","","","","Não ","","","","","","","","","","","","",{},{})                                                                                                                                                                                
PutSx1(cPerg,"12","Com Vlr em Conferencia   ?"          ,"","","mv_ch12","N",01,0,0,"C","","","","","mv_par12","Sim ","","","","Não ","","","","","","","","","","","","",{},{})                                                                                                                                                                                
PutSx1(cPerg,"13","Com Vlr em Digitação     ?"          ,"","","mv_ch13","N",01,0,0,"C","","","","","mv_par13","Sim ","","","","Não ","","","","","","","","","","","","",{},{})                                                                                                                                                                                
PutSx1(cPerg,"14","Com Vlr em Faturadas     ?"          ,"","","mv_ch14","N",01,0,0,"C","","","","","mv_par14","Sim ","","","","Não ","","","","","","","","","","","","",{},{})                                                                                                                                                                                

PutSx1(cPerg,"15","Critica Rda's Validos    ?"          ,"","","mv_ch15","N",01,0,0,"C","","","","","mv_par15","Sim ","","","","Não ","","","","","","","","","","","","",{},{})                                                                                                                                                                                

PutSx1(cPerg,"16","Cons. somente Clase Rede :"          ,"","","mv_ch16","C",03,0,0,"G","","","","","mv_par16","","","","","","","","","","","","","","","","","",{},{}) 

Pergunte(cPerg,.F.)

Return

