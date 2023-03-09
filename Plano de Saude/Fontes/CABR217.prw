#INCLUDE "PROTHEUS.CH"
#Include "TOPCONN.CH"
                             
/*/                                                                                      
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABR217   º Autor ³Altamiro              º Data ³ 01/10/12  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Rotina para CONFERENCIA da Analise Analista X RDA          º±±
±±º          ³                                                            º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/                  

User Function CABR217()

Local   nCont		:= 0    
Local   cMsg		:= ""
Private cDpj        := 'Não'   
private cImp        := 'Não'
Private oLeTxt
Private lAbortPrint :=.F.
Private cPerg       := "CABR217"
Private cTitulo     := "Analise Analista X RDA "
Private lpvez       :=.T.   
Private cTpCrit     :=" "  
Private lImporta    := .F.  
Private f_ok        := .F.
Private nLocaliz    := 0 // 1 - zzq -- 2 se2  -- 0 nao localizado         

private cpgto       := ' '    

private cTitCSald   := ' '   
PRIVATE nVlrTitPri  := 0.00
PRIVATE nVlrTitcmp  := 0.00   
private cNomeArq1   := ' '      
private i           := 1                     
 
 AjustaSX1(cPerg)

cCompMes    := SUBSTR(mv_par01,1,2) 
cCompAno    := SUBSTR(mv_par01,4,4)   
  
Processa({||Processa1()}, cTitulo, "", .T.)   

/*  If tmp1->QTDPROC == 0 .and.  nListar == 2 
     FGrvPlan() 
  EndIf  */
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Libera impressao                                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ


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
For i:= 1 to 4

cQuery :=       " select "

If i == 1  
// rda
     cQuery += CRLF +"          BAU_GRPPAG||' - ' || B16_DESCRI  GRPPAG ,
     cQuery += CRLF +"          BD7.BD7_CODRDA ||'-'|| BD7.BD7_NOMRDA RDA, 
ElseIf i == 2        
// Tec analista            
     cQuery += CRLF +"          PBN.PBN_CODANA ||'-'|| PBN.PBN_NOMANA ANALISTA , 
ElseIf i == 3
// tec analista rda
     cQuery += CRLF +"          PBN.PBN_CODANA ||'-'|| PBN.PBN_NOMANA ANALISTA ,  
     cQuery += CRLF +"          BD7.BD7_CODRDA ||'-'|| BD7.BD7_NOMRDA RDA , 
ElseIf i == 4
// rda tec analista       
     cQuery += CRLF +"          BAU_GRPPAG||' - ' || B16_DESCRI  GRPPAG ,
     cQuery += CRLF +"          BD7.BD7_CODRDA ||'-'|| BD7.BD7_NOMRDA RDA ,  
     cQuery += CRLF +"          PBN.PBN_CODANA ||'-'|| PBN.PBN_NOMANA ANALISTA ,  
//       
EndIf 
cQuery += CRLF +"          SUM(CASE WHEN  BD7_VLRPAG > 0 THEN  BD7_VLRPAG ELSE 0 END) Vlr_PAGO ,    
cQuery += CRLF +"          SUM(CASE WHEN  BD7_VLRPAG > 0 THEN  1 ELSE 0 END) QTDA_PAGO ,             
cQuery += CRLF +"          SUM(CASE WHEN  BD7_VLRGLO > 0 THEN  BD7_VLRGLO ELSE 0 END) VLR_GLO , 
cQuery += CRLF +"          SUM(CASE WHEN  BD7_VLRGLO > 0 THEN  1 ELSE 0 END) QTDA_GLO , 
cQuery += CRLF +"          SUM(CASE WHEN (BD7_VLRPAG + BD7_VLRGLO) > 0  THEN  (BD7_VLRPAG+BD7_VLRglo) ELSE 0 END) VLR_APRE ,            
cQuery += CRLF +"          SUM(CASE WHEN (BD7_VLRPAG + BD7_VLRGLO) > 0  THEN  1 ELSE 0 END) QTDA_APRE       
cQuery += CRLF +"     FROM "+RetSqlName('PBN')+ " PBN , "+RetSqlName('BD7')+ " BD7 ,  "     
cQuery += CRLF +"          "+RetSqlName('BAU')+ " BAU , "+RetSqlName('B16')+ " B16 "  
cQuery += CRLF +"    where PBN_filial = '" + xFilial('PBN') + "' AND PBN.d_E_L_E_T_ = ' ' and  PBN_conant = 'N'  
cQuery += CRLF +"      AND BD7_FILIAL = '" + xFilial('BD7') + "' AND BD7.D_e_l_e_t_ = ' '     
cQuery += CRLF +"      AND B16_FILIAL = '" + xFilial('B16') + "' AND B16.D_E_L_E_T_ = ' ' " + CRLF
cQuery += CRLF +"      AND BAU_FILIAL = '" + xFilial('BAU') + "' AND BAU.D_E_L_E_T_ = ' ' AND BAU.R_E_C_D_E_L_ = 0" + CRLF
If mv_par02 == 1
   cQuery += CRLF +"      AND BD7_NUMLOT LIKE  '"+cCompAno+cCompMes+"%' "
else                
   cQuery += CRLF +"      AND BD7_ANOPAG || BD7_MESPAG = '"+cCompAno+cCompMes+"' "
   cQuery += CRLF +"      AND BD7_FASE = '3' AND BD7_YFAS35 = 'T' "
EndIf 
cQuery += CRLF +"         AND BAU_GRPPAG  = B16_CODIGO  " + CRLF  
cQuery += CRLF +"         AND BD7_CODRDA  = BAU_CODIGO  " + CRLF 

cQuery += CRLF +"      AND PBN_FILBD7 = BD7_FILIAL "    
cQuery += CRLF +"      AND PBN_CODOPE = BD7_CODOPE "    
cQuery += CRLF +"      AND PBN_CODLDP = BD7_CODLDP "
cQuery += CRLF +"      AND PBN_CODPEG = BD7_CODPEG " 
cQuery += CRLF +"      AND PBN_NUMERO = BD7_NUMERO " 
cQuery += CRLF +"      AND PBN_ORIMOV = BD7_ORIMOV "
cQuery += CRLF +"      AND PBN_SEQUEN = BD7_SEQUEN "
cQuery += CRLF +"      AND PBN_CODUNM = BD7_CODUNM " 
cQuery += CRLF +"      AND PBN_SEQALT =( SELECT MAX(PBN1.PBN_SEQALT) " 
cQuery += CRLF +"                          FROM "+RetSqlName('PBN')+ " PBN1 "  
cQuery += CRLF +"                         WHERE PBN1.PBN_filial = '" + xFilial('PBN') + "' AND PBN1.d_E_L_E_T_ = ' ' and  PBN1.PBN_conant = 'N'  "
cQuery += CRLF +"                           AND PBN1.PBN_FILBD7 = PBN.PBN_FILBD7   "
cQuery += CRLF +"                           AND PBN1.PBN_CODOPE = PBN.PBN_CODOPE   "  
cQuery += CRLF +"                           AND PBN1.PBN_CODLDP = PBN.PBN_CODLDP   "
cQuery += CRLF +"                           AND PBN1.PBN_CODPEG = PBN.PBN_CODPEG   "
cQuery += CRLF +"                           AND PBN1.PBN_NUMERO = PBN.PBN_NUMERO   "
cQuery += CRLF +"                           AND PBN1.PBN_ORIMOV = PBN.PBN_ORIMOV   "
cQuery += CRLF +"                           AND PBN1.PBN_SEQUEN = PBN.PBN_SEQUEN   "
cQuery += CRLF +"                           AND PBN1.PBN_CODUNM = PBN.PBN_CODUNM ) " 
cQuery += CRLF +"   GROUP BY "
If i == 1
// rda
     cQuery += CRLF +"          BAU_GRPPAG||' - ' || B16_DESCRI   ,     "
     cQuery += CRLF +"          BD7.BD7_CODRDA ||'-'|| BD7.BD7_NOMRDA   "
ElseIf i == 2
// Tec analista 
     cQuery += CRLF +"          PBN.PBN_CODANA ||'-'|| PBN.PBN_NOMANA   "
ElseIf i == 3
// tec analista rda
     cQuery += CRLF +"          PBN.PBN_CODANA ||'-'|| PBN.PBN_NOMANA , "
     cQuery += CRLF +"          BD7.BD7_CODRDA ||'-'|| BD7.BD7_NOMRDA   "
ElseIf i == 4
// rda tec analista       
     cQuery += CRLF +"          BAU_GRPPAG||' - ' || B16_DESCRI   ,     "
     cQuery += CRLF +"          BD7.BD7_CODRDA ||'-'|| BD7.BD7_NOMRDA,  "
     cQuery += CRLF +"          PBN.PBN_CODANA ||'-'|| PBN.PBN_NOMANA   "    
EndIf
     cQuery += CRLF +"   ORDER BY    "
If i == 1     
// rda
     cQuery += CRLF +"          BAU_GRPPAG||' - ' || B16_DESCRI   ,     " 
     cQuery += CRLF +"          BD7.BD7_CODRDA ||'-'|| BD7.BD7_NOMRDA   "
ElseIf i == 2     
// Tec analista 
     cQuery += CRLF +"          PBN.PBN_CODANA ||'-'|| PBN.PBN_NOMANA   "
ElseIf i == 3
// tec analista rda
     cQuery += CRLF +"          PBN.PBN_CODANA ||'-'|| PBN.PBN_NOMANA , "
     cQuery += CRLF +"          BD7.BD7_CODRDA ||'-'|| BD7.BD7_NOMRDA   "
ElseIf i == 4     
// rda tec analista       
     cQuery += CRLF +"          BAU_GRPPAG||' - ' || B16_DESCRI   ,     "
     cQuery += CRLF +"          BD7.BD7_CODRDA ||'-'|| BD7.BD7_NOMRDA , "
     cQuery += CRLF +"          PBN.PBN_CODANA ||'-'|| PBN.PBN_NOMANA   "    
EndIf 
   
   If Select(("TMP")) <> 0 
      ("TMP")->(DbCloseArea()) 
   Endif
    
    TCQuery cQuery Alias "TMP" New 
                                                                                           
    dbSelectArea("TMP")

    tmp->(dbGoTop())  

    FGrvPlan()  

Next i


Return()               


Static Function AjustaSX1(cPerg)

Local aHelpPor := {}

PutSx1(cPerg,"01",OemToAnsi("Mes/Ano Custo?  ") 		,"","","mv_ch1","C",07,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","99/9999",aHelpPor,{},{})
PutSx1(cPerg,"02",OemToAnsi("Custo Fechado / 3 1/2 ?  ") ,"","","mv_ch1","N",01,0,0,"C","","","","","mv_par02","Fechado","","","","3 1/2","","","","","","","","","","","99/9999",aHelpPor,{},{}) 

Pergunte(cPerg,.T.)

Return 

Static Function FGrvPlan()

   If I = 1 
       If  mv_par02 == 1           
           cNomDadCab:= '1 - Rda - Faturado  '   
           cNomPla   := '1 - Rda - Faturado  ' 
       Else                                  
           cNomDadCab:= '1 - Rda - 3 1_2  '   
           cNomPla   := '1 - Rda - 3 1_2  ' 
       EndIf     
   ElseIf I = 2                    
       If  mv_par02 == 1           
           cNomDadCab:= '2 - Analista - Faturado   '   
           cNomPla   := '2 - Analista - Faturado   '
       Else 
           cNomDadCab:= '2 - Analista - 3 1_2  '   
           cNomPla   := '2 - Analista - 3 1_2  '       
       EndIf      
   ElseIf I = 3                          
       If  mv_par02 == 1           
           cNomDadCab:= '3 - Analista  -  Rda - Faturado  '   
           cNomPla   := '3 - Analista  -  Rda - Faturado  ' 
       Else                                   
          cNomDadCab:= '3 - Analista  -  Rda - 3 1_2  '   
          cNomPla   := '3 - Analista  -  Rda - 3 1_2  '        
       EndIf    
   ElseIf I = 4 
       If  mv_par02 == 1           
           cNomDadCab:= '4 - Rda  -  Analista - Faturado  '   
           cNomPla   := '4 - Rda  -  Analista - Faturado  '                   
       Else                                                      
           cNomDadCab:= '4 - Rda  -  Analista - 3 1_2  '   
           cNomPla   := '4 - Rda  -  Analista - 3 1_2  '                   
       EndIf      
   EndIf                    
   cComp     :=  cCompMes+'/'+cCompAno 
   cNomeArq := "C:\TEMP\"+cCompAno+cCompMes+" - "+cNomDadCab+"_"+SubStr(DtoS(date()),7,2)+"_"+SubStr(DtoS(date()),5,2)+"_"+SubStr(DtoS(date()),1,4)+"_"+STRTRAN(TIME(),":","_")+".csv"

   nHandle := FCREATE(cNomeArq)
   cMontaTxt := cNomDadCab
   cMontaTxt += CRLF
   FWrite(nHandle,cMontaTxt)       		 
   cMontaTxt := 'Competencia : ' + cComp
   cMontaTxt += CRLF
   FWrite(nHandle,cMontaTxt)		 
   cMontaTxt := 'Planilha : '+cNomPla  
   cMontaTxt += CRLF
   FWrite(nHandle,cMontaTxt)	        
                                 
        
   If I = 1 
      cMontaTxt := "Grp Pagto ;" 
      cMontaTxt += "Rda ;"   
   ElseIf I = 2              
      cMontaTxt := "Analista ;"   
   ElseIf I = 3                   
      cMontaTxt := "Analista ;"
      cMontaTxt += "Rda  ;"
   ElseIf I = 4                               
      cMontaTxt := "Grp Pagto ;" 
      cMontaTxt += "Rda ;" 
      cMontaTxt += "Analista  ;"     
   EndIf                    
   
   cMontaTxt += "Vlr Pagto   ;"  
   cMontaTxt += "Qtda Pgto   ;"   
   cMontaTxt += "Vlr Glosado ;"
   cMontaTxt += "Qtda Glosado ;" 
   cMontaTxt += "Vlr Apresentado ;"
   cMontaTxt += "Qtda Apresentado;"  		  		 		  		
		
   cMontaTxt += CRLF // Salto de linha para .csv (excel)
             
   FWrite(nHandle,cMontaTxt)
   
   tmp->(dbGoTop())                    
   
   While !(TMP->(Eof()))    

	   If I = 1           
          cMontaTxt := tmp->GRPPAG +";" 
	      cMontaTxt += tmp->RDA +";"   
	   ElseIf I = 2              
	      cMontaTxt := tmp->ANALISTA +";"   
	   ElseIf I = 3                   
	      cMontaTxt := tmp->ANALISTA +";"
	      cMontaTxt += tmp->RDA +";"         
	   ElseIf I = 4               
	      cMontaTxt := tmp->GRPPAG  +";"               
	      cMontaTxt += tmp->RDA +";"         
	      cMontaTxt += tmp->ANALISTA +";"
	   EndIf                                                                                                                                                                                                                   

	  cMontaTxt += Transform(tmp->Vlr_PAGO  ,'@E  999,999,999.99') + ";"
  	  cMontaTxt += Transform(tmp->qtda_PAGO ,'@E          99,999') + ";"
	  cMontaTxt += Transform(tmp->Vlr_GLO   ,'@E  999,999,999.99') + ";"
  	  cMontaTxt += Transform(tmp->qtda_GLO  ,'@E          99,999') + ";"       
	  cMontaTxt += Transform(tmp->Vlr_APRE  ,'@E  999,999,999.99') + ";"
	  cMontaTxt += Transform(tmp->qtda_APRE ,'@E          99,999') + ";"       
		  
	  cMontaTxt += CRLF // Salto de linha para .csv (excel)      
		      
	  FWrite(nHandle,cMontaTxt)


      tmp->(DbSkip())

    EndDo       

	If nHandle > 0
		
		// encerra gravação no arquivo
		FClose(nHandle)
		cNomeArq1+= cNomeArq + CRLF
     	//	MsgAlert("Relatorio salvo em: "+cNomeArq)
		
	EndIf                

    If I = 4 		
     	MsgAlert("Relatorio salvo em: " + CRLF +cNomeArq1)
    EndIf           
    
Return () 
