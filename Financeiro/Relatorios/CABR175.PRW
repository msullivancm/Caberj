#INCLUDE "PROTHEUS.CH"
#Include "TOPCONN.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABR086   º Autor ³Altamiro              º Data ³ 01/10/12  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³Critica Guias de coparticipação  Não cobradas               º±±
±±º          ³                                                            º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/                  

User Function CABR175      

Local cMsg			:= ""
Private lAbortPrint :=.F.
Private cPerg       := "CABR175"
Private cTitulo     := "Relação de Guias de coparticipação Convenio Não cobradas "        

Private cAliastmp 	:= GetNextAlias()
Private cAliastmp1 	:= GetNextAlias() 
Private cAliastmp2 	:= GetNextAlias() 
                                                                         


cMsg += " Este programa ira listar as guias de cooparticipação sem cobrança   " + CRLF
cMsg += " dos convenio de reciprocidade  " + CRLF


***************************************************************************    
private  nPrecReg    := 0
Private  aDados1     := {}       
Private  aDados2     := {} 
Private  aDados3     := {}     
Private  aDados4     := {}  

Private  acabec1    :={"Tipo","Convenio" , "Cod.Emp","Chv. Nivel ","Procedimento ","Projeto","Evento","Copart. Bloq","Copart. Cobrada","Vlr Copart" ,;
                       "Vlr Apresent.","Vlr Glosado","Vlr Aprov.",;
                       "Vlr Copart" ,"Qtda Guias" ,"% Copart." , "Descr. Grp Cobertura e Precent." }        
                        
Private  acabec2     := {"Tipo","Convenio" ,"Guia","Procedi","Data Procedim", "Copart Bloq","Clone","nomusr","Rda","Vlr Apresent.","Vlr Glosado","Vlr Aprov.","Vlr Copart" , "Num. Tit." , "Consolidado"}    


Private  acabec3    := {"Tipo","Cod. Emp/ N. Guia ","Chv. Niv / Proced.","Data Evento","Proj/Clone","Evento / Rda " ,"Copat. Bloq","Copat. Cobrado","Vlr Copart" ,"Vlr Apresent.","Vlr Glosado","Vlr Aprov.",;
                        "Vlr Copart" ,"Qtda Guias" ,"% Copart." , "Descr. Grp Cobertura e Precent."}  

Private  acabec4    := {"Tipo","Competencia" ,"Copat. Bloq","Copat. Cobrado","Vlr Copart" ,"Vlr Apresent.","Vlr Glosado","Vlr Aprov.",;
                        "Vlr Copart" ,"Qtda Guias" ,"% Copart." , "Tpo Cobranca " }  

private Descric := ' '  
  	  
AjustaSX1(cPerg)

Pergunte(cPerg,.T.)    


cMesCompInc := mv_par01
cAnoCompInc	:= mv_par02 
cMesCompFim := mv_par03
cAnoCompFim	:= mv_par04 
cEmpInc     := '0004'
cEmpFim     := '0004'
nGExcel     := Iif(mv_par05 == 1,.T.,.F.)  
nSint       := mv_par06     
nAnalG      := mv_par07        
cProcInc    := mv_par08
cProcFim    := mv_par09    
nListProc   := mv_par10     

nOpeOriInc  := mv_par11  
nOpeOriFim  := mv_par12  
 
cEmpresa    := Iif(cEmpAnt == '01','C','I')      

//If nNumMes  > 0 
  If 1 ==  2
     fGeraresumo()     
     fGeraResl()  
  if nGExcel          
     DlgToExcel({{"ARRAY","Guias Não Cobradas - Sintetico " ,aCabec4,aDados4}})  
  EndIf   
endIf     

 if nSint == 1 .or. nAnalG == 1 
  
    Processa({||Processa1()}, cTitulo, "", .T.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Libera impressao                                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
   
// faz ecxel       

 //   if nSint == 1
       DlgToExcel({{"ARRAY","Guias Não Cobradas - Sintetico " ,aCabec1,aDados1}})   
//    EndIF
//    if nAnalG == 1    
       DlgToExcel({{"ARRAY","Guias Não Cobradas - Analitico " ,aCabec2,aDados2}})
       //DlgToExcel({{"ARRAY","Opme Não Cobradas - Sintetico / Analitico " ,aCabec3,aDados3}})
 //   EndIf
 
///
 /*   if nSint == 1
       fGeraRel2()    
    EndIf
 */   if nAnalG == 1  
       fGeraRel1()   
       fGeraRel3()   
    EndIf   
EndIf
     
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

ProcRegua(FT_FLASTREC()) 

nCont := 0
a:=0
   	IncProc('Processando...')            
 /////////////////////////////////////////  
    cquery := " SELECT '1' , '-> Cab <-' TIPO, BD6_CODEMP ,bd6_chvniv, "
	if nListProc == 1 
	   cquery += " bd6f.bd6_codpro codpro, bd6f.bd6_despro descpro , "
    EndIf	   
	cquery += " BD6_YPROJ, BD6_YNEVEN  CODEVENTO , ZZT_EVENTO NOME_EVENTO,"   
	cquery += " DECODE(TRIM(BD6F.bd6_blocpa),'1','Sim','Não') Bloq_Cop , DECODE(TRIM(BD6F.BD6_PREFIX),'','nao cobrado','cobrado') COBRANDO ,"
	cquery += " Decode(BD6F.BD6_VLRTPF,0,'Sem Coopart','Com Coopart') coop , SUM(BD6F.BD6_VLRGLO) GLOSADO,SUM(BD7F.VLRPAG)  VL_APROV ," 
	cquery += " SUM(DECODE(BD6F.BD6_BLOCPA,'1',0,DECODE(SIGN(BD6F.BD6_VLRTPF),-1,0,DECODE(BD6_CODEMP,'0009',0,BD6F.BD6_VLRTPF)))) VL_PARTICIPACAO ,count (*) qtda , ' ' guia , "
	cquery += " RETORNA_DESC_CONTRATO('"+cEmpresa+"',BD6_OPEUSR,BD6_CODEMP,BD6_CONEMP) CONTRATO  "
	
	cquery += " FROM (SELECT BD7.BD7_FILIAL,BD7_CODPLA,SIGA_TIPO_EXPOSICAO_ANS(BD7_CODEMP,BD7_MATRIC,BD7_TIPREG,To_Date(Trim(BD7_DATPRO),'YYYYMMDD')) EXPOS, "
	cquery += " BD7.BD7_OPELOT,BD7.BD7_NUMLOT, BD7.BD7_CODOPE, BD7.BD7_CODLDP, BD7.BD7_CODPEG, BD7.BD7_NUMERO, BD7.BD7_ORIMOV, "
    if nListProc == 1 
    	cquery += " BD7_CODPRO, "
    EndIf	
	cquery += " BD7.BD7_SEQUEN,BD7.BD7_ANOPAG, BD7.BD7_MESPAG ,   Sum(BD7.BD7_VLRPAG) AS VLRPAG,COUNT(DISTINCT BD7_CODEMP||BD7_MATRIC||BD7_TIPREG) QTDE  "                                                                                  
	cquery += " FROM " + RetSqlName("BD7")+" BD7 WHERE BD7.BD7_FILIAL = '"+xFilial("BD7")+"'  AND BD7.BD7_CODOPE = '0001' AND BD7.BD7_SITUAC = '1' AND (BD7.BD7_FASE = '3' or BD7.BD7_FASE = '4') AND BD7.BD7_BLOPAG <> '1' "
	cquery += " AND (BD7.BD7_ANOPAG||BD7.BD7_MESPAG) >= '"+cAnoCompinc+cMesCompInc+"' AND (BD7.BD7_ANOPAG||BD7.BD7_MESPAG) <= '"+cAnoCompFim+cMesCompFim+"' "
	cquery += " and BD7.BD7_VLRPAG > 0 AND BD7_codemp >= '"+cEmpInc+"' and BD7_COdemp <='"+cEmpFim+"' "       

	cquery += " AND BD7.D_E_L_E_T_ = ' '  GROUP BY BD7_FILIAL, BD7_CODPLA, BD7.BD7_OPELOT,BD7.BD7_NUMLOT,"    
	if nListProc == 1 
	   cquery += " BD7_CODPRO, "
	EndIf   
	cquery += " SIGA_TIPO_EXPOSICAO_ANS(BD7_CODEMP,BD7_MATRIC,BD7_TIPREG,To_Date(Trim(BD7_DATPRO),'YYYYMMDD')), "
	cquery += " BD7_CODOPE, BD7_CODLDP, BD7_CODPEG, BD7_NUMERO, BD7_ORIMOV, BD7_SEQUEN, BD7_ANOPAG, BD7_MESPAG) BD7F,  " + RetSqlName("BD6")+" BD6f ," + RetSqlName("BI3")+" BI3 , " + RetSqlName("ZZT")+" ZZT "    
	
	cquery += " WHERE ZZT_FILIAL = '"+xFilial("ZZT")+"' AND BI3_FILIAL = '"+xFilial("BI3")+"' AND BD6F.BD6_FILIAL = '"+xFilial("BD6")+"' "
	cquery += " AND (BD7F.BD7_ANOPAG||BD7F.BD7_MESPAG) >= '"+cAnoCompinc+cMesCompInc+"' AND (BD7F.BD7_ANOPAG||BD7F.BD7_MESPAG) <= '"+cAnoCompFim+cMesCompFim+"' "

	cquery += " AND BD6F.BD6_codemp >='"+cEmpInc+"' and BD6F.BD6_COdemp <='"+cEmpFim+"' "    
	cquery += " AND BD6_OPEORI >= '"+nOpeOriInc+"'  AND BD6_OPEORI <= '"+nOpeOriFim +"' "
	cquery += " AND BD7F.BD7_FILIAL = BD6F.BD6_FILIAL AND BD7F.BD7_CODOPE = BD6F.BD6_CODOPE AND BD7F.BD7_CODLDP = BD6F.BD6_CODLDP AND BD7F.BD7_CODPEG = BD6F.BD6_CODPEG " 
	cquery += " AND BD7F.BD7_NUMERO = BD6F.BD6_NUMERO AND BD7F.BD7_ORIMOV = BD6F.BD6_ORIMOV AND BD7F.BD7_SEQUEN = BD6F.BD6_SEQUEN "
         
     if nListProc == 1   
       cquery += " AND bd6f.bd6_codpro >= '"+cProcInc+"' AND bd6f.bd6_codpro <= '"+cProcFim+"' "      
       cquery += " AND BD6F.BD6_CODPRO = BD7F.BD7_CODPRO "  
    EndIf     
	cquery += " AND BI3_FILIAL=BD7_FILIAL  AND BI3_CODINT=BD7_CODOPE AND BI3_CODIGO=BD7_CODPLA AND BD6_YNEVEN=ZZT_CODEV AND BD6F.D_E_L_E_T_ = ' ' AND BI3.D_E_L_E_T_ = ' ' AND ZZT.D_E_L_E_T_ = ' ' "
    cquery += " and BD6F.BD6_PREFIX =  ' ' " 
	
	cquery += " GROUP BY BD6_CODEMP,  BD6_CHVNIV, "
	If nListProc == 1   
	   cquery += " bd6f.bd6_codpro, bd6f.bd6_despro , "
	EndIf                

	cquery += " BD6_YPROJ , BD6_YNEVEN , ZZT_EVENTO , DECODE(TRIM(BD6F.bd6_blocpa),'1','Sim','Não') , "
	cquery += " DECODE(TRIM(BD6F.BD6_PREFIX),'','nao cobrado','cobrado')  , DECODE(BD6F.BD6_VLRTPF,0,'Sem Coopart','Com Coopart'), "
	cquery += " BD6_CONEMP, RETORNA_DESC_CONTRATO('"+cEmpresa+"',BD6_OPEUSR,BD6_CODEMP,BD6_CONEMP) "             
	                          
    cquery += " ORDER BY 1, 3 , 4 , 5 ,6 "  
				   	
    If Select((cAliastmp)) <> 0 
       (cAliastmp)->(DbCloseArea()) 
    Endif

    TCQuery cQuery New Alias (cAliastmp)  
    
    dbSelectArea(cAliastmp)
   
    (cAliastmp)->(dbGoTop())   
     
    While (cAliastmp)->(!Eof())
    
       if !empty(trim((cAliastmp)->bd6_chvniv))     
          cquery1 := " SELECT BHI_CODGRU grupo , BG7_DESCRI descri, BHI_PERCOP precent "
         
          cquery1 += " FROM " +RetSqlName("BI3")+" BI3, "+ RetSqlName("BRV")+" BRV, "+ RetSqlName("BHI")+" BHI, " +RetSqlName("BG7")+" BG7 "
          
          cquery1 += " WHERE BI3_FILIAL = '"+xFilial("BI3")+"' AND BRV_FILIAL = '"+xFilial("BRV")+"' and bhi_filial = '"+xFilial("BHI")+"'  and bg7_filial = '"+xFilial("Bg7")+"'     "
          cquery1 += " and bi3_codint || bi3_codigo || bi3_versao = brv_codpla || brv_versao   "
          cquery1 += " AND BRV_CODPLA || BRV_VERSAO||BRV_CODGRU = BHI_CODINT || BHI_CODPLA || BHI_VERSAO || BHI_CODGRU "
          cquery1 += " AND BRV_CODPLA || BRV_VERSAO||BRV_CODGRU = '"+(cAliastmp)->bd6_chvniv+"'  "
	   	  cquery1 += " AND BHI_VIGATE = ' ' AND BHI_SOMCOM = '0' and bhi_codint = bg7_codint and bhi_codgru = bg7_codgru  "
		  cquery1 += " AND BI3.D_E_L_E_T_ = ' ' AND BRV.D_E_L_E_T_ = ' 'and bhi.d_e_l_e_t_ = ' ' and bG7.d_e_l_e_t_ = ' ' "    
		  if Select(cAliastmp1) <> 0 
             (cAliastmp1)->(DbCloseArea()) 
          Endif
  
          TCQuery cQuery1 New  Alias (cAliastmp1) 
    
          dbSelectArea(cAliastmp1)
   
          (cAliastmp1)->(dbGoTop())   
          Descric := (cAliastmp1)->grupo + " - " + (cAliastmp1)->descri + " - " + cvaltochar((cAliastmp1)->precent)
          If Empty (Descric)     
             Descric := (cAliastmp)->bd6_chvniv 
          EndIf  
          nPrecReg := (cAliastmp1)->precent 
       else       
          nPrecReg := 0               
          Descric := ' ' 
       EndIf   
       
            
        If nListProc == 1
           cCodPro := (cAliastmp)->codpro+" - "+(cAliastmp)->descpro
        Else 
           cCodPro := "     -     "
        EndIf 
        aaDD(aDados1,{(cAliastmp)->tipo             ,;   
                      (cAliastmp)->CONTRATO         ,;
                      (cAliastmp)->BD6_CODEMP       ,;
	                  (cAliastmp)->bd6_chvniv       ,;
	                   cCodpro                       ,;
	                  (cAliastmp)->BD6_YPROJ        ,;
	                   cvaltochar((cAliastmp)->CODEVENTO) +' - '+ (cAliastmp)->NOME_EVENTO ,; 		                
	                  (cAliastmp)->Bloq_Cop         ,;
	                  (cAliastmp)->COBRANDO         ,;
	                  (cAliastmp)->coop             ,;  
	                 ((cAliastmp)->Glosado + (cAliastmp)->Vl_Aprov),; 
	   	              (cAliastmp)->Glosado 		     ,;
	   	              (cAliastmp)->Vl_Aprov 	     ,;
	   	              (cAliastmp)->VL_PARTICIPACAO  ,;
	   	              (cAliastmp)->qtda             ,;
	   	            (((cAliastmp)->VL_PARTICIPACAO *100) / (cAliastmp)->Vl_Aprov) ,;
	   	             Descric })  
	   	             
////////////////
       aaDD(aDados3,{(cAliastmp)->tipo             ,;
                     (cAliastmp)->BD6_CODEMP       ,; 
                     (cAliastmp)->CONTRATO         ,;
	                 (cAliastmp)->bd6_chvniv       ,;  
	                 (cAliastmp)->BD6_YPROJ        ,;
	                 cvaltochar((cAliastmp)->CODEVENTO) +' - '+ (cAliastmp)->NOME_EVENTO ,; 
	                 (cAliastmp)->Bloq_Cop         ,;
	                 (cAliastmp)->COBRANDO         ,;
	                 (cAliastmp)->coop             ,;  
	                ((cAliastmp)->Glosado + (cAliastmp)->Vl_Aprov),; 
	   	             (cAliastmp)->Glosado 		   ,;
	   	             (cAliastmp)->Vl_Aprov 	       ,;
	   	             (cAliastmp)->VL_PARTICIPACAO  ,;
	   	             (cAliastmp)->qtda             ,;
	   	           (((cAliastmp)->VL_PARTICIPACAO *100) / (cAliastmp)->Vl_Aprov) ,;
	   	             Descric }) 
	   	                               
///////////////	   	             
if nAnalG == 1  	 
   if trim((cAliastmp)->tipo)  == '-> Cab <-'            
       cquery := " SELECT '   -> Det <-'  TIPO ,"
       cquery += " BD6F.BD6_CODPRO|| ' - '|| BD6F.BD6_DESPRO  PROCEDI , " 
       cquery += " BD6F.BD6_CODOPE ||'-'|| BD6F.BD6_CODLDP ||'-'|| BD6F.BD6_CODPEG ||'-'|| BD6F.BD6_NUMERO ||'-'|| BD6F.BD6_SEQUEN ||'-'|| BD6F.BD6_ORIMOV  GUIA , "  
       cquery += " DECODE(BD6F.BD6_BLOCPA,'1',' Sim ', ' Não ' ) BLOQ_COPART , " 
//       cquery += " BD6F.BD6_NOMUSR NOMUSR , " 
 
       cquery += " BD6F.BD6_OPEUSR ||'.'|| BD6F.BD6_CODEMP ||'.'|| BD6F.BD6_MATRIC ||'.'|| BD6F.BD6_TIPREG ||'-'|| BD6F.BD6_NOMUSR NOMUSR , " 
 
       cquery += " BD6F.BD6_CODRDA||'-'||BD6F.BD6_NOMRDA RDA , "
       cquery += " BD6F.BD6_DATPRO DTPRO , " // MARCELA
       cquery += " SUM(BD6F.BD6_VLRGLO) GLOSADO , " 
       cquery += " SUM(BD7F.VLRPAG)  VL_APROV , " 
   //    cquery += " SUM(DECODE(BD6F.BD6_BLOCPA,'1',0,DECODE(SIGN(BD6F.BD6_VLRTPF),-1,0,DECODE(BD6F.BD6_CODEMP,'0004',0,'0009',0,BD6F.BD6_VLRTPF)))) VL_PARTICIPACAO , "   
       cquery += " SUM(DECODE(BD6F.BD6_BLOCPA,'1',0,DECODE(SIGN(BD6F.BD6_VLRTPF),-1,0,DECODE(BD6_CODEMP,'0009',0,BD6F.BD6_VLRTPF)))) VL_PARTICIPACAO , "

       cquery += " BD6F.BD6_PREFIX||BD6F.BD6_NUMTIT||BD6F.BD6_PARCEL||BD6F.BD6_TIPTIT NUMTIT , "

       cquery += " DECODE(trim(bd6f.bd6_seqpf), null, 'Não Consolidado' , 'Consolidado') consol , "
       cquery += " RETORNA_DESC_CONTRATO('"+cEmpresa+"',BD6F.BD6_OPEUSR,BD6F.BD6_CODEMP,BD6F.BD6_CONEMP) CONTRATO   "
       cquery += " FROM ( SELECT  BD7.BD7_FILIAL ,"
       cquery += " BD7.BD7_CODPLA, "
       cquery += " BD7.BD7_OPELOT, "
       cquery += " BD7.BD7_NUMLOT, " 
       cquery += " BD7.BD7_CODOPE, "
       cquery += " BD7.BD7_CODLDP, " 
       cquery += " BD7.BD7_CODPEG, "
       cquery += " BD7.BD7_NUMERO, "
       cquery += " BD7.BD7_ORIMOV, " 
       cquery += " BD7.BD7_SEQUEN, " 
       cquery += " BD7.BD7_CODPRO, "
       cquery += " SUM(BD7.BD7_VLRPAG) AS VLRPAG, "
       cquery += " COUNT(DISTINCT BD7.BD7_CODEMP||BD7.BD7_MATRIC||BD7.BD7_TIPREG) QTDE "  
       cquery += " FROM "+ RetSqlName("BD7") + " BD7  "
       cquery += " WHERE  BD7.BD7_FILIAL = '"+xFilial("BD7")+"'  "
       cquery += " AND  BD7.BD7_CODOPE = '0001' "           
       cquery += " AND  BD7.BD7_SITUAC = '1' "
       cquery += " AND  (BD7.BD7_FASE = '3' or BD7.BD7_FASE = '4') "
       cquery += " AND  BD7.BD7_BLOPAG <> '1' " 
       cquery += " AND  BD7.BD7_VLRPAG > 0 "
       cquery += " AND (BD7.BD7_ANOPAG||BD7.BD7_MESPAG) >= '"+cAnoCompinc+cMesCompInc+"' AND (BD7.BD7_ANOPAG||BD7.BD7_MESPAG) <= '"+cAnoCompFim+cMesCompFim+"' "

       cquery += " AND  BD7_codemp >= '"+cEmpInc+"' and BD7_COdemp <='"+cEmpFim+"' "   

       cquery += " AND  BD7.D_E_L_E_T_ = ' ' "
       cquery += " GROUP BY BD7.BD7_FILIAL, BD7.BD7_CODPLA, BD7.BD7_OPELOT,BD7.BD7_NUMLOT, " 
       cquery += " BD7.BD7_CODOPE, BD7.BD7_CODLDP, BD7.BD7_CODPEG, BD7.BD7_NUMERO, "
       cquery += " BD7.BD7_ORIMOV, BD7.BD7_SEQUEN , BD7.BD7_CODPRO ) BD7F, "+ RetSqlName("BD6") + " BD6F "   
	   cquery += " WHERE  BD6F.BD6_FILIAL='"+xFilial("BD6")+"'  "
	   cquery += " AND BD6F.D_E_L_E_T_ = ' '  "  
	   cquery += " AND BD7F.BD7_FILIAL = BD6F.BD6_FILIAL "
	   cquery += " AND BD7F.BD7_CODOPE = BD6F.BD6_CODOPE "
	   cquery += " AND BD7F.BD7_CODLDP = BD6F.BD6_CODLDP " 
	   cquery += " AND BD7F.BD7_CODPEG = BD6F.BD6_CODPEG "
	   cquery += " AND BD7F.BD7_NUMERO = BD6F.BD6_NUMERO "
   	   cquery += " AND BD7F.BD7_ORIMOV = BD6F.BD6_ORIMOV "
	   cquery += " AND BD7F.BD7_SEQUEN = BD6F.BD6_SEQUEN " 
	   cquery += " AND BD7F.BD7_CODPRO = BD6F.BD6_CODPRO "
	   cquery += " AND BD7F.VLRPAG > 0 " 
   	   cquery += " AND BD6F.BD6_codemp >= '"+cEmpInc+"'     and BD6F.BD6_COdemp <='"+cEmpFim+"' " 
 	   cquery += " AND BD6F.BD6_OPEORI >= '"+nOpeOriInc+"'  AND BD6F.BD6_OPEORI <='"+nOpeOriFim +"' "     
       cquery += " AND BD6F.BD6_CHVNIV = '"+(cAliastmp)->bd6_chvniv+ "' "
       cquery += " AND BD6F.BD6_YPROJ  = '"+(cAliastmp)->BD6_YPROJ + "' " 
       cquery += " AND BD6F.BD6_YNEVEN = " +cvaltochar((cAliastmp)->CODEVENTO) "
       cquery += " AND DECODE(TRIM(BD6F.BD6_BLOCPA),'1','Sim','Não') = '"+(cAliastmp)->Bloq_Cop +"' "
       cquery += " AND DECODE(TRIM(BD6F.BD6_PREFIX),'','nao cobrado','cobrado    ') = '"+(cAliastmp)->COBRANDO+"' "  
 //    cquery += " And DECODE((DECODE(BD6F.BD6_BLOCPA,'1',0,DECODE(SIGN(BD6F.BD6_VLRTPF),-1,0,DECODE(BD6_CODEMP,'0004',0,'0009',0,BD6F.BD6_VLRTPF)))),0,'Sem Coopart','Com Coopart') = '"+(cAliastmp)->coop +"' "
       if nListProc == 1                   
          cquery += " AND bd6f.bd6_codpro = '"+(cAliastmp)->codpro+ "' "                                                                  
       endIf                                                                         
       cquery += " GROUP BY BD6F.BD6_CODPRO|| ' - '|| BD6F.BD6_DESPRO , " 
       cquery += " BD6F.BD6_CODOPE ||'-'|| BD6F.BD6_CODLDP ||'-'|| BD6F.BD6_CODPEG ||'-'|| BD6F.BD6_NUMERO ||'-'|| BD6F.BD6_SEQUEN ||'-'|| BD6F.BD6_ORIMOV , " 
       cquery += " BD6F.BD6_BLOCPA , " 
       
//       cquery += " BD6F.BD6_NOMUSR, "
       
       cquery += "BD6F.BD6_OPEUSR ||'.'|| BD6F.BD6_CODEMP ||'.'|| BD6F.BD6_MATRIC ||'.'|| BD6F.BD6_TIPREG ||'-'|| BD6F.BD6_NOMUSR    ,
       cquery += " BD6F.BD6_CODRDA||'-'||BD6F.BD6_NOMRDA , "
       cquery += " BD6F.BD6_DATPRO , "
       cquery += " BD6F.BD6_PREFIX||BD6F.BD6_NUMTIT||BD6F.BD6_PARCEL||BD6F.BD6_TIPTIT ," 
       cquery += " DECODE(trim(bd6f.bd6_seqpf), null, 'Não Consolidado' , 'Consolidado'), RETORNA_DESC_CONTRATO('"+cEmpresa+"',BD6F.BD6_OPEUSR,BD6F.BD6_CODEMP,BD6F.BD6_CONEMP) " 
     	                               
 //////////
                                                           
    EndIf   
    If Select(("TMP1")) <> 0 
       ("TMP1")->(DbCloseArea()) 
    Endif
  
    TCQuery cQuery Alias "TMP1" New 
    
    dbSelectArea("TMP1")
   
    tmp1->(dbGoTop())  
    
    While Tmp1->(!Eof())           
        aaDD(aDados2,{tmp1->tipo         ,;  
        			  tmp1->CONTRATO     ,;
                      tmp1->Guia         ,;      
                      tmp1->procedi      ,; 
                      dtoc(stod(tmp1->dtpro))        ,;//marcela
	                  tmp1->Bloq_copart  ,; 	                  
	                  ' '                ,;
	                  tmp1->nomusr       ,; 
	                  tmp1->rda          ,;
	                 (tmp1->Glosado + tmp1->Vl_Aprov),; 
	                  tmp1->Glosado 	 ,;
	                  tmp1->Vl_Aprov 	 ,;
	                  tmp1->Vl_Participacao ,; 
	                  tmp1->numtit ,;
	                  tmp1->consol})                
	                  

////////////////
       aaDD(aDados3,{tmp1->tipo         ,; 
                     tmp1->CONTRATO     ,;
                     tmp1->Guia         ,; 
                     tmp1->procedi      ,; 
                     dtoc(stod(tmp1->dtpro))        ,;//marcela
	                 ' '                ,; 
	                 tmp1->nomusr       ,;     
	                 tmp1->rda          ,;
	                (tmp1->Glosado + tmp1->Vl_Aprov) ,;
	                 ' '               ,;  
	                (tmp1->Glosado + tmp1->Vl_Aprov),; 
	   	             tmp1->Glosado 	 		   ,;
	   	             tmp1->Vl_Aprov 	       ,;
	   	             tmp1->Vl_Participacao  ,;
	   	             0            ,;
	   	           ((tmp1->Vl_Participacao  *100) / tmp1->Vl_Aprov) ,;
	   	             ' ' , tmp1->numtit ,;
	   	             tmp1->consol }) 
	   	                               
///////////////	   	             
	    TMP1->(dbSkip()) 	       
     EndDo	                   
   endIf        
 (cAliastmp)->(dbSkip()) 	   
EndDo	                   
Return                    

*************************************************************************************************************  
Static Function fGeraRel2

Local oReport 
Private cPerg		:= "CABR175"  
Private aOrdem 		:= {}//{'RDA','Ano/Mes'}

//aSort( aDados1,,,{|x,y| x[10] < y[10]} )

oReport:= ReportDef2()
oReport:PrintDialog()

Return

*************************************************************************************************************
Static Function fGeraRel3

Local oReport 
Private cPerg		:= "CABR175"  
Private aOrdem 		:= {}//{'RDA','Ano/Mes'}

//aSort( aDados1,,,{|x,y| x[10] < y[10]} )

oReport:= ReportDef3()
oReport:PrintDialog()

Return
*************************************************************************************************************
  
Static Function fGeraresumo () 

local nCompMF:= val(cMesComp)   
local nCompAF:= val(cAnoComp)   
local cCompMF:= ' '   
local cCompAF:= ' '  
local i:= 1
  
For i := 1 To 999    
    if nCompMF > nNumMes
       nComPMF := nCompMF - nNumMes  
       EXIT       
    Elseif nCompMF == nNumMes      
       nComPMF := 12
       nCompAF:= nCompAF - 1 
       EXIT
    Elseif nCompMF < nNumMes   
       if nNumMes > 12
          nNumMes := nNumMes - 12
          nCompAF:= nCompAF - 1
       else                      
          nCompMF := ((nCompMF + 12)- nNumMes)
          nCompAF:= nCompAF - 1
          exit
       EndIf   
    EndiF                           
Next i
       
 cCompMF:= strzero((nCompMF),2)   
 cCompAF:= str(nCompAF)

    cquery := " SELECT 'GUIAS' tipo ,SUBSTR(BD7F.BD7_NUMLOT,1,6) competencia , "
	cquery += " DECODE(TRIM(BD6F.bd6_blocpa),'1','Sim','Não') Bloq_Cop , DECODE(TRIM(BD6F.BD6_PREFIX),'','nao cobrado','cobrado') COBRANDO ,"
	cquery += " Decode(BD6F.BD6_VLRTPF,0,'Sem Coopart','Com Coopart') coop , SUM(BD6F.BD6_VLRGLO) GLOSADO,SUM(BD7F.VLRPAG)  VL_APROV ," 
	cquery += " SUM(DECODE(BD6F.BD6_BLOCPA,'1',0,DECODE(SIGN(BD6F.BD6_VLRTPF),-1,0,DECODE(BD6_CODEMP,'0004',0,'0009',0,BD6F.BD6_VLRTPF)))) VL_PARTICIPACAO ,count (*) qtda , "
  
  	cquery += " CASE nvl(e1_formrec,'00') WHEN '01' THEN '01 - Mater Aposentado' "
   	cquery += " WHEN '08' THEN '08 - Mater Aposentado Vinc' WHEN '02' THEN '02 - Banco Liq ' "
	cquery += " WHEN '03' THEN '03 - Mater Empresa '  WHEN '04' THEN '04 - Boleto 112'"
	cquery += " WHEN '05' THEN '05 - Boleto 175 e SisDeb ' WHEN '07' THEN '07 - Emp. Itau '"
	cquery += " WHEN '00' THEN '00 - Não Cobrando ' ELSE e1_formrec||' - Não especf' END tpcob , "  

	cquery += " DECODE(trim(bd6f.bd6_seqpf), null, 'Não Consolidado' , 'Consolidado') consol "
	
		cquery += " FROM (SELECT BD7.BD7_FILIAL,BD7_CODPLA,SIGA_TIPO_EXPOSICAO_ANS(BD7_CODEMP,BD7_MATRIC,BD7_TIPREG,To_Date(Trim(BD7_DATPRO),'YYYYMMDD')) EXPOS, "
	cquery += " BD7.BD7_OPELOT,BD7.BD7_NUMLOT, BD7.BD7_CODOPE, BD7.BD7_CODLDP, BD7.BD7_CODPEG, BD7.BD7_NUMERO, BD7.BD7_ORIMOV, "
    if nListProc == 1 
    	cquery += " BD7_CODPRO, "
    EndIf	
	cquery += " BD7.BD7_SEQUEN,  Sum(BD7.BD7_VLRPAG) AS VLRPAG,COUNT(DISTINCT BD7_CODEMP||BD7_MATRIC||BD7_TIPREG) QTDE  "                                                                                  
	cquery += " FROM "+ RetSqlName("BD7") + " BD7 WHERE BD7.BD7_FILIAL = '"+xFilial("BD7")+"' AND BD7.BD7_CODOPE = '0001' AND BD7.BD7_SITUAC = '1' AND (BD7.BD7_FASE = '3' or BD7.BD7_FASE = '4') AND BD7.BD7_BLOPAG <> '1' "
	cquery += " AND SUBSTR(BD7.BD7_NUMLOT,1,6) <= '"+cAnoComp + cMesComp+"' AND SUBSTR(BD7.BD7_NUMLOT,1,6) >= '"+ltrim(cCompAF) + ltrim(cCompMF)+"' "
	cquery += " and BD7.BD7_VLRPAG > 0 AND BD7_codemp >= '"+cEmpInc+"' and BD7_COdemp <='"+cEmpFim+"'  "
	cquery += " AND BD7.D_E_L_E_T_ = ' '  GROUP BY BD7_FILIAL, BD7_CODPLA, BD7.BD7_OPELOT,BD7.BD7_NUMLOT, "    
	if nListProc == 1 
	   cquery += " BD7_CODPRO, "
	EndIf   
	cquery += " SIGA_TIPO_EXPOSICAO_ANS(BD7_CODEMP,BD7_MATRIC,BD7_TIPREG,To_Date(Trim(BD7_DATPRO),'YYYYMMDD')), "
	cquery += " BD7_CODOPE, BD7_CODLDP, BD7_CODPEG, BD7_NUMERO, BD7_ORIMOV, BD7_SEQUEN) BD7F, "+ RetSqlName("BD6") + " BD6F  , "+ RetSqlName("BI3") + " BI3 ,"+ RetSqlName("ZZT") + " ZZT 	,"+ RetSqlName("se1") + " se1 " 

	cquery += " WHERE ZZT_FILIAL = '"+xFilial("ZZT")+"' AND BI3_FILIAL = '"+xFilial("BI3")+"'   AND BD6F.BD6_FILIAL = '"+xFilial("BD6")+"'  "  
	
	cquery += " AND (BD7F.BD7_ANOPAG||BD7F.BD7_MESPAG) >= '"+cAnoCompinc+cMesCompInc+"' AND (BD7F.BD7_ANOPAG||BD7F.BD7_MESPAG) <= '"+cAnoCompFim+cMesCompFim+"' "


	cquery += " AND BD6F.BD6_codemp >='"+cEmpInc+"' and BD6F.BD6_COdemp <='"+cEmpFim+"'"    
	                      
	cquery += " AND BD7F.BD7_FILIAL = BD6F.BD6_FILIAL AND BD7F.BD7_CODOPE = BD6F.BD6_CODOPE AND BD7F.BD7_CODLDP = BD6F.BD6_CODLDP AND BD7F.BD7_CODPEG = BD6F.BD6_CODPEG " 
	cquery += " AND BD7F.BD7_NUMERO = BD6F.BD6_NUMERO AND BD7F.BD7_ORIMOV = BD6F.BD6_ORIMOV AND BD7F.BD7_SEQUEN = BD6F.BD6_SEQUEN "
  
	If nprojeto == 1                                                             
	   cquery += " AND BD6_YPROJ <> ' ' "
	ElseIf nprojeto == 2                                                            
	   cquery += " AND BD6_YPROJ = ' ' "
	EndIF    
         
    If nSemcoop == 1      
         cquery += "AND (DECODE(BD6F.BD6_BLOCPA,'1',0,DECODE(SIGN(BD6F.BD6_VLRTPF),-1,0,DECODE(BD6_CODEMP,'0004',0,'0009',0,BD6F.BD6_VLRTPF)))) <> 0 "
    ElseIf nSemcoop == 2                                                                                                                              
         cquery += "AND (DECODE(BD6F.BD6_BLOCPA,'1',0,DECODE(SIGN(BD6F.BD6_VLRTPF),-1,0,DECODE(BD6_CODEMP,'0004',0,'0009',0,BD6F.BD6_VLRTPF)))) =  0 "
    EndIf    
    
    If nblocoop  == 1                                                             
	   cquery += " AND TRIM(BD6F.bd6_blocpa) = '1' "
	ElseIf nblocoop  == 2                                                              
	   cquery += " AND TRIM(BD6F.bd6_blocpa) <> ' ' "
	EndIF      
              
    If cChaveNiv == 1
       cquery += " AND BD6F.bd6_chvniv <> ' ' "
    ElseIf cChaveNiv == 2
       cquery += " AND BD6F.bd6_chvniv = ' ' "
    EndIf              
    if nListProc == 1   
       cquery += " AND bd6f.bd6_codpro >= '"+cProcInc+"' AND bd6f.bd6_codpro <= '"+cProcFim+"' "      
       cquery += " AND BD6F.BD6_CODPRO = BD7F.BD7_CODPRO "  
    EndIf     
	cquery += " AND BI3_FILIAL=BD7_FILIAL  AND BI3_CODINT=BD7_CODOPE AND BI3_CODIGO=BD7_CODPLA AND BD6_YNEVEN=ZZT_CODEV AND BD6F.D_E_L_E_T_ = ' ' AND BI3.D_E_L_E_T_ = ' ' AND ZZT.D_E_L_E_T_ = ' ' "
      
    cquery += " and e1_filial(+) = '01' and se1.d_E_L_E_T_(+) = ' ' "
    cquery += " and bd6_prefix = e1_prefixo(+) and bd6_numtit = e1_num(+)  and bd6_parcel = e1_parcela(+) and bd6_tiptit = e1_tipo(+) "

	cquery += " GROUP BY SUBSTR(BD7F.BD7_NUMLOT,1,6), DECODE(TRIM(BD6F.bd6_blocpa),'1','Sim','Não') , "
	cquery += " DECODE(TRIM(BD6F.BD6_PREFIX),'','nao cobrado','cobrado')  , DECODE(BD6F.BD6_VLRTPF,0,'Sem Coopart','Com Coopart') , e1_formrec , " 
	cquery += " DECODE(trim(bd6f.bd6_seqpf), null, 'Não Consolidado' , 'Consolidado') "
	cquery += " ORDER BY  2 ,1, 3, 4 , 5  "  
			   	
    If Select((cAliastmp)) <> 0 
       (cAliastmp)->(DbCloseArea()) 
    Endif
  
    TCQuery cQuery New Alias (cAliastmp)  
    
    dbSelectArea(cAliastmp)
   
    (cAliastmp)->(dbGoTop())   
     
   While (cAliastmp)->(!Eof())


         aaDD(aDados4,{(cAliastmp)->tipo             				,;
                       (cAliastmp)->competencia      				,;
                       (cAliastmp)->Bloq_Cop         				,;
	                   (cAliastmp)->COBRANDO        				,;
	                   (cAliastmp)->coop             				,;  
	                  ((cAliastmp)->Glosado + (cAliastmp)->Vl_Aprov),; 
	   	               (cAliastmp)->Glosado 		   				,;
	   	               (cAliastmp)->Vl_Aprov 	       				,;
	   	               (cAliastmp)->VL_PARTICIPACAO  				,;
	   	               (cAliastmp)->qtda             				,;
	   	             (((cAliastmp)->VL_PARTICIPACAO *100) / (cAliastmp)->Vl_Aprov) ,;
     	               (cAliastmp)->tpcob ,;                                                          
     	               (cAliastmp)->Consol }) 

///////////////	   	             
        (cAliastmp)->(dbSkip()) 	   	    
     EndDo	                   
Return
*************************************************************************************************************
*************************************************************************************************************  
Static Function fGeraresl

Local oReport 
Private cPerg		:= "CABR175"  
Private aOrdem 		:= {}//{'RDA','Ano/Mes'}

//aSort( aDados1,,,{|x,y| x[10] < y[10]} )

oReport:= ReportDresl()
oReport:PrintDialog()

Return

*************************************************************************************************************

Static Function fGeraRel1

Local oReport 
Private cPerg		:= "CABR175"  
Private aOrdem 		:= {}//{'RDA','Ano/Mes'}

//aSort( aDados2,,,{|x,y| x[10] < y[10]} )

oReport:= ReportDef1()
oReport:PrintDialog()

Return
********************************************************************************************************************************

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
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
*/                         

Static Function ReportDef2()

Local oReport 
Local oDPJ    

oReport	:= TReport():New("CABR175","Analise de Cobradas de Convenio de reciprocidade  ",, {|oReport| ReportPrt(oReport)},"Este relatorio lista a cobranca de coparticipação de convenio de reciprocidade")
oReport:SetTotalInLine(.F.)//Imprime na linha: .F. - Imprime abaixo da linha com o titulo de cada coluna: .T.
oReport:SetTotalText('Total Geral') 

*'-----------------------------------------------------------------------------------'*
*'Solucao para impressao em que as colunas se truncam: "SetColSpace" e "SetLandScape"'* 
*'-----------------------------------------------------------------------------------'*

oReport:SetColSpace(1) //Espacamento entre colunas. 
oReport:SetLandscape() //Impressao em paisagem.  
//oReport:SetPortrait() //Impressao em retrato.  

*'-----------------------------------------------------------------------------------'*
                                                                
oDPJ := TRSection():New(oReport,"Analise de Cobradas de Convenio de reciprocidade",,aOrdem)             
     
//TRCell():New(oDPJ ,'TIPO '			    ,/*TABELA*/	,'Tipo '	 	   ,/*Picture*/   	    ,20				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oDPJ ,'CODEMP'	     		,/*TABELA*/	,'Empresa '	       ,/*Picture*/ 	    ,07				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oDPJ ,'PROJET'		        ,/*TABELA*/	,'Projeto '        ,/*Picture*/ 	    ,07			  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)  
TRCell():New(oDPJ ,'EVENTO'	      	    ,/*TABELA*/	,'Evento  '        ,/*Picture*/ 	    ,40			  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)  
TRCell():New(oDPJ ,'BLOCPA'		    	,/*TABELA*/	,'Blq.Copar'       ,/*Picture*/ 	    ,10			  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)   
TRCell():New(oDPJ ,'COBRAD'		    	,/*TABELA*/	,'Cobran'          ,/*Picture*/ 	    ,04			  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)   
TRCell():New(oDPJ ,'COPART'		    	,/*TABELA*/	,'copart'          ,/*Picture*/ 	    ,04			  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)  
TRCell():New(oDPJ ,'PROCEDI'      	    ,/*TABELA*/	,'Procedimento'    ,/*Picture*/ 	    ,40			  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)  
TRCell():New(oDPJ ,'VLAPR'			    ,/*TABELA*/	,'Val.Apresentado' ,"@E 99,999,999.99" 	,13			 	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"		) 
TRCell():New(oDPJ ,'VLGLO'			    ,/*TABELA*/	,'Glosa'           ,"@E 99,999,999.99" 	,13			 	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"		) 
TRCell():New(oDPJ ,'VLPRO'			    ,/*TABELA*/	,'Val.Analisado'   ,"@E 99,999,999.99" 	,13			 	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"		)  
TRCell():New(oDPJ ,'VLCOP'			    ,/*TABELA*/	,'Val.Copart'      ,"@E 99,999,999.99" 	,13			 	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"		)  
TRCell():New(oDPJ ,'QUANT'			    ,/*TABELA*/	,'Qtda'            ,"@E 999,999" 	    ,06			 	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"		) 
TRCell():New(oDPJ ,'%COBRA'			    ,/*TABELA*/	,'%Cobrado'        ,"@E 999.99" 	    ,06			 	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"		) 
TRCell():New(oDPJ ,'PARAM'			    ,/*TABELA*/	,'Parametro'       ,/*Picture*/  	    ,55			 	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"	) 


 
oBreak01 		:= TRBreak():New(oDPJ,oDPJ:Cell("EMPRESA"),"Subtotal por Empresa"	,.F.)  

lTotSecBrk01	:= .F.//Indica se totalizador sera impresso na quebra de secao
lTotFimBrk01	:= .T.//Indica se totalizador sera impresso no final do relatorio - Como o total eh o mesmo, basta que apenas um esteja ativado
                                                                   
TRFunction():New(oDPJ:Cell("VLAPR")    	    ,NIL,"SUM"			,oBreak01,,"@E 999,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01) 
TRFunction():New(oDPJ:Cell("VLGLO")  		,NIL,"SUM"			,oBreak01,,"@E 999,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01) 
TRFunction():New(oDPJ:Cell("VLPRO")  		,NIL,"SUM"			,oBreak01,,"@E 999,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01)  
TRFunction():New(oDPJ:Cell("VLCOP")  		,NIL,"SUM"			,oBreak01,,"@E 999,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01) 
 





Return(oReport)

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

Static Function ReportDef3()

Local oReport 
Local oDPJ    
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Ajusta o Grupo de Perguntas                                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//AjustaSX1()

//Pergunte(cPerg,.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao do componente de impressao                                      ³
//³                                                                        ³
//³TReport():New                                                           ³
//³ExpC1 : Nome do relatorio                                               ³
//³ExpC2 : Titulo                                                          ³
//³ExpC3 : Pergunte                                                        ³
//³ExpB4 : Bloco de codigo que sera executado na confirmacao da impressao  ³
//³ExpC5 : Descricao                                                       ³
//³                                                                        ³           
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ           

oReport	:= TReport():New("CABR175","Analise de Cobradas de Convenio de reciprocidade",, {|oReport| ReportPrt3(oReport)},"Este relatorio lista a cobranca de coparticipação de convenio de reciprocidade")
oReport:SetTotalInLine(.F.)//Imprime na linha: .F. - Imprime abaixo da linha com o titulo de cada coluna: .T.
oReport:SetTotalText('Total Geral') 

*'-----------------------------------------------------------------------------------'*
*'Solucao para impressao em que as colunas se truncam: "SetColSpace" e "SetLandScape"'* 
*'-----------------------------------------------------------------------------------'*

oReport:SetColSpace(1) //Espacamento entre colunas. 
oReport:SetLandscape() //Impressao em paisagem.  
//oReport:SetPortrait() //Impressao em retrato.  

*'-----------------------------------------------------------------------------------'*
                                                                
oDPJ := TRSection():New(oReport,"Analise de Cobradas de Convenio de reciprocidade ",,aOrdem)    
          

TRCell():New(oDPJ ,'TIPO '			    ,/*TABELA*/	,'Tipo '	 	   ,/*Picture*/   	    ,18				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oDPJ ,'FORNE'	   		    ,/*TABELA*/	,'Fornecedor'	   ,/*Picture*/ 	    ,40				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		) 
TRCell():New(oDPJ ,'NOTAF'	   	     	,/*TABELA*/	,'NFiscal'	       ,/*Picture*/ 	    ,13				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oDPJ ,'EMISS'		        ,/*TABELA*/	,'Dt.Emissao'      ,/*Picture*/ 	    ,10			  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)  
TRCell():New(oDPJ ,'DIGIT'	      	    ,/*TABELA*/	,'Dt.Digitção'     ,/*Picture*/ 	    ,10			  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)  
TRCell():New(oDPJ ,'BAIXA'		    	,/*TABELA*/	,'Dt.Baixa.'       ,/*Picture*/ 	    ,10			  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		) 
TRCell():New(oDPJ ,'TITUL'	   	     	,/*TABELA*/	,'Tit.Finan.'      ,/*Picture*/ 	    ,13				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		) 
TRCell():New(oDPJ ,'VLAPR'			    ,/*TABELA*/	,'Val.Apresentado' ,"@E 99,999,999.99" 	,13			 	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"		) 
TRCell():New(oDPJ ,'VLGLO'			    ,/*TABELA*/	,'Glosa'           ,"@E 99,999,999.99" 	,13			 	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"		) 
TRCell():New(oDPJ ,'VLPRO'			    ,/*TABELA*/	,'Val.Analisado'   ,"@E 99,999,999.99" 	,13			 	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"		) 
TRCell():New(oDPJ ,'EMPRESA'	    	,/*TABELA*/	,'Empresa'	       ,/*Picture*/ 	    ,40		    	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		) 

 
oBreak01 		:= TRBreak():New(oDPJ,oDPJ:Cell("EMPRESA"),"Subtotal por Empresa"	,.F.)  

lTotSecBrk01	:= .F.//Indica se totalizador sera impresso na quebra de secao
lTotFimBrk01	:= .T.//Indica se totalizador sera impresso no final do relatorio - Como o total eh o mesmo, basta que apenas um esteja ativado
                                                                   
 TRFunction():New(oDPJ:Cell("VLAPR")    	,NIL,"SUM"			,oBreak01,,"@E 999,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01) 
 TRFunction():New(oDPJ:Cell("VLGLO")  		,NIL,"SUM"			,oBreak01,,"@E 999,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01) 
 TRFunction():New(oDPJ:Cell("VLPRO")  		,NIL,"SUM"			,oBreak01,,"@E 999,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01) 
 

Return(oReport)

********************************************************************************************************************************
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

Static Function ReportPrt3(oReport)

Local   cImp    :='Não'

Local i := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

Private oDPJ 	:= oReport:Section(1)

Private nCont	:= 0   

nCont := Len(aDados3)

//Se nao tiver esta linha, nao imprime os dados
oDPJ:init()

oReport:SetMeter(nCont) 

cTot	:= AllTrim(Transform(nCont,'@E 999,999,999,999'))
nCont 	:= 0       

For i := 1 To Len(aDados3)

	oReport:SetMsgPrint("Imprimindo linha " + AllTrim(Transform(++nCont,'@E 999,999,999,999')) + ' de ' + cTot)
	oReport:IncMeter()

	If oReport:Cancel()  
	    
	    oReport:FatLine()     
	    oReport:PrintText('Cancelado pelo operador!!!',,,CLR_RED,,,.T.)
		
	    exit
	    
	EndIf           
	   	                  
	oDPJ:Cell('TIPO '	 		):SetValue(AllTrim(aDados3[i][1]))      
	oDPJ:Cell('FORNE'	 		):SetValue(AllTrim(aDados3[i][2]))
	oDPJ:Cell('NOTAF'	 		):SetValue(AllTrim(aDados3[i][3]))          
	oDPJ:Cell('EMISS'	 		):SetValue((aDados3[i][4]))    
  	oDPJ:Cell('DIGIT'	  		):SetValue((aDados3[i][5]))
    oDPJ:Cell('BAIXA'  		    ):SetValue((aDados3[i][7]))
    oDPJ:Cell('TITUL'	 		):SetValue(AllTrim(aDados3[i][6]))          
	oDPJ:Cell('VLAPR'	 		):SetValue((aDados3[i][9]))     
	oDPJ:Cell('VLGLO'	 		):SetValue((aDados3[i][10]))          
	oDPJ:Cell('VLPRO'	 		):SetValue((aDados3[i][11]))          
    oDPJ:Cell('EMPRESA'  		):SetValue((aDados3[i][12]))
	
	oDPJ:PrintLine()
Next i

oDPJ:Finish()

Return   
********************************************************************************************************************************

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
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
*/                         

Static Function ReportDresl()

Local oReport 
Local oDPJ    

oReport	:= TReport():New("CABR175","Analise de Cobradas de Convenio de reciprocidade" ,, {|oReport| ReportPtR1(oReport)},"Este relatorio lista a cobranca de coparticipação de convenio de reciprocidade")
oReport:SetTotalInLine(.F.)//Imprime na linha: .F. - Imprime abaixo da linha com o titulo de cada coluna: .T.
oReport:SetTotalText('Total Geral') 

*'-----------------------------------------------------------------------------------'*
*'Solucao para impressao em que as colunas se truncam: "SetColSpace" e "SetLandScape"'* 
*'-----------------------------------------------------------------------------------'*

oReport:SetColSpace(1) //Espacamento entre colunas. 
oReport:SetLandscape() //Impressao em paisagem.  
//oReport:SetPortrait() //Impressao em retrato.  

*'-----------------------------------------------------------------------------------'*
                                                                
oDPJ := TRSection():New(oReport,"Analise de Cobradas de Convenio de reciprocidade" ,,aOrdem)            
     
TRCell():New(oDPJ ,'TIPO'	     		,/*TABELA*/	,'Tipo    '	       ,/*Picture*/ 	    ,07				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oDPJ ,'COMPET'		        ,/*TABELA*/	,'Competencia '    ,/*Picture*/ 	    ,06			  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)  
TRCell():New(oDPJ ,'BLOCPA'		    	,/*TABELA*/	,'Blq.Copar'       ,/*Picture*/ 	    ,10			  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)   
TRCell():New(oDPJ ,'COBRAD'		    	,/*TABELA*/	,'Cobran'          ,/*Picture*/ 	    ,04			  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)   
TRCell():New(oDPJ ,'COPART'		    	,/*TABELA*/	,'copart'          ,/*Picture*/ 	    ,04			  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)  
TRCell():New(oDPJ ,'VLAPR'			    ,/*TABELA*/	,'Val.Apresentado' ,"@E 99,999,999.99" 	,13			 	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"		) 
TRCell():New(oDPJ ,'VLGLO'			    ,/*TABELA*/	,'Glosa'           ,"@E 99,999,999.99" 	,13 		 	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"		) 
TRCell():New(oDPJ ,'VLPRO'			    ,/*TABELA*/	,'Val.Analisado'   ,"@E 99,999,999.99" 	,13			 	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"		)  
TRCell():New(oDPJ ,'VLCOP'			    ,/*TABELA*/	,'Val.Copart'      ,"@E 99,999,999.99" 	,13			 	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"		)  
TRCell():New(oDPJ ,'QUANT'			    ,/*TABELA*/	,'Qtda'            ,"@E 999,999" 	    ,06			 	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"		) 
TRCell():New(oDPJ ,'%COBRA'			    ,/*TABELA*/	,'%Cobrado'        ,"@E 999.99" 	    ,06			 	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"		) 
TRCell():New(oDPJ ,'TPCOB'	            ,/*TABELA*/	,'Tpo Cobranca '   ,/*Picture*/ 	    ,17				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oDPJ ,'CONSOL'	            ,/*TABELA*/	,'Consolidado '    ,/*Picture*/ 	    ,17				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)

oBreak01 		:= TRBreak():New(oDPJ,oDPJ:Cell("COMPET"),"Subtotal por Competencia"	,.F.)  

lTotSecBrk01	:= .F.//Indica se totalizador sera impresso na quebra de secao
lTotFimBrk01	:= .T.//Indica se totalizador sera impresso no final do relatorio - Como o total eh o mesmo, basta que apenas um esteja ativado
                                                                   
TRFunction():New(oDPJ:Cell("VLAPR")    	    ,NIL,"SUM"			,oBreak01,,"@E 999,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01) 
TRFunction():New(oDPJ:Cell("VLGLO")  		,NIL,"SUM"			,oBreak01,,"@E 999,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01) 
TRFunction():New(oDPJ:Cell("VLPRO")  		,NIL,"SUM"			,oBreak01,,"@E 999,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01)  
TRFunction():New(oDPJ:Cell("VLCOP")  		,NIL,"SUM"			,oBreak01,,"@E 999,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01) 
 
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

Local   cImp    :='Não'

Local i := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

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
  
//	oDPJ:Cell('TIPO '	 		):SetValue(AllTrim(aDados1[i][1]))     
	oDPJ:Cell('CODEMP'	 		):SetValue(AllTrim(aDados1[i][2])) 
  	oDPJ:Cell('PROCEDI'	  		):SetValue((aDados1[i][4] ))         
  	oDPJ:Cell('PROJET'	  		):SetValue((aDados1[i][5] ))      
    oDPJ:Cell('EVENTO'   		):SetValue((aDados1[i][6]))   
   	oDPJ:Cell('BLOCPA'  	    ):SetValue((aDados1[i][7]))
	oDPJ:Cell('COBRAD'	 		):SetValue((aDados1[i][8]))     
    oDPJ:Cell('COPART'	 		):SetValue((aDados1[i][9]))     	  
  	oDPJ:Cell('VLAPR'	 		):SetValue((aDados1[i][10]))          
	oDPJ:Cell('VLGLO'	 		):SetValue((aDados1[i][11]))          
	oDPJ:Cell('VLPRO'	 		):SetValue((aDados1[i][12]))         
	oDPJ:Cell('VLCOP'	 		):SetValue((aDados1[i][13]))        
    oDPJ:Cell('QUANT'  		    ):SetValue((aDados1[i][14])) 
    oDPJ:Cell('%COBRA' 		    ):SetValue((aDados1[i][15]))
    oDPJ:Cell('PARAM'   		):SetValue((aDados1[i][16]))
	
	oDPJ:PrintLine()

Next i
 
oDPJ:Finish()

Return   

********************************************************************************************************************************      
Static Function ReportPtR1(oReport)

Local   cImp    :='Não'

Local i := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

Private oDPJ 	:= oReport:Section(1)

Private nCont	:= 0   

nCont := Len(aDados4)

//Se nao tiver esta linha, nao imprime os dados
oDPJ:init()

oReport:SetMeter(nCont) 

cTot	:= AllTrim(Transform(nCont,'@E 999,999,999,999'))
nCont 	:= 0       

For i := 1 To Len(aDados4)

	oReport:SetMsgPrint("Imprimindo linha " + AllTrim(Transform(++nCont,'@E 999,999,999,999')) + ' de ' + cTot)
	oReport:IncMeter()

	If oReport:Cancel()  
	    
	    oReport:FatLine()     
	    oReport:PrintText('Cancelado pelo operador!!!',,,CLR_RED,,,.T.)
		
	    exit
	    
	EndIf           
  
	oDPJ:Cell('TIPO'	 		):SetValue(AllTrim(aDados4[i][1]))     
	oDPJ:Cell('COMPET'	 		):SetValue(AllTrim(aDados4[i][2])) 
   	oDPJ:Cell('BLOCPA'  	    ):SetValue((aDados4[i][3]))
	oDPJ:Cell('COBRAD'	 		):SetValue((aDados4[i][4]))     
    oDPJ:Cell('COPART'	 		):SetValue((aDados4[i][5]))     	  
  	oDPJ:Cell('VLAPR'	 		):SetValue((aDados4[i][06]))          
	oDPJ:Cell('VLGLO'	 		):SetValue((aDados4[i][07]))          
	oDPJ:Cell('VLPRO'	 		):SetValue((aDados4[i][08]))         
	oDPJ:Cell('VLCOP'	 		):SetValue((aDados4[i][09]))        
    oDPJ:Cell('QUANT'  		    ):SetValue((aDados4[i][10])) 
    oDPJ:Cell('%COBRA' 		    ):SetValue((aDados4[i][11]))           
    oDPJ:Cell('TPCOB'	 		):SetValue(AllTrim(aDados4[i][12]))  
    oDPJ:Cell('CONSOL'	 		):SetValue(AllTrim(aDados4[i][13]))     

	oDPJ:PrintLine()

Next i
 
oDPJ:Finish()

Return   

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

Static Function ReportDef1()

Local oReport 
Local oDPJ    
//Local oDPJ2  

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Ajusta o Grupo de Perguntas                                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//AjustaSX1()

//Pergunte(cPerg,.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao do componente de impressao                                      ³
//³                                                                        ³
//³TReport():New                                                           ³
//³ExpC1 : Nome do relatorio                                               ³
//³ExpC2 : Titulo                                                          ³
//³ExpC3 : Pergunte                                                        ³
//³ExpB4 : Bloco de codigo que sera executado na confirmacao da impressao  ³
//³ExpC5 : Descricao                                                       ³
//³                                                                        ³           
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ           

oReport	:= TReport():New("CABR175","Analise de Cobradas de Convenio de reciprocidade",, {|oReport| ReportPrt1(oReport)},"Este relatorio lista a cobranca de coparticipação de convenio de reciprocidade")
oReport:SetTotalInLine(.F.)//Imprime na linha: .F. - Imprime abaixo da linha com o titulo de cada coluna: .T.
oReport:SetTotalText('Total Geral') 

*'-----------------------------------------------------------------------------------'*
*'Solucao para impressao em que as colunas se truncam: "SetColSpace" e "SetLandScape"'* 
*'-----------------------------------------------------------------------------------'*

oReport:SetColSpace(1) //Espacamento entre colunas. 
oReport:SetLandscape() //Impressao em paisagem.  
//oReport:SetPortrait() //Impressao em retrato.  

*'-----------------------------------------------------------------------------------'*
                                                                
oDPJ := TRSection():New(oReport,"Analise de Cobradas de Convenio de reciprocidade",,aOrdem)              

TRCell():New(oDPJ ,'GUIA'	     		,/*TABELA*/	,'Guias '	       ,/*Picture*/ 	    ,30				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oDPJ ,'COPART'		        ,/*TABELA*/	,'Blq. Copart?'    ,/*Picture*/ 	    ,03			  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)  
TRCell():New(oDPJ ,'CLONE'	      	    ,/*TABELA*/	,'Clone'           ,/*Picture*/ 	    ,30			  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)  
TRCell():New(oDPJ ,'USUAR'		    	,/*TABELA*/	,'Usuario '        ,/*Picture*/ 	    ,30			  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)   
TRCell():New(oDPJ ,'RDA'		    	,/*TABELA*/	,'Rda '            ,/*Picture*/ 	    ,30			  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)  

TRCell():New(oDPJ ,'VLAPR'			    ,/*TABELA*/	,'Val.Apresentado' ,"@E 99,999,999.99" 	,13			 	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"		) 
TRCell():New(oDPJ ,'VLGLO'			    ,/*TABELA*/	,'Glosa'           ,"@E 99,999,999.99" 	,13			 	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"		) 
TRCell():New(oDPJ ,'VLPRO'			    ,/*TABELA*/	,'Val.Analisado'   ,"@E 99,999,999.99" 	,13			 	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"		) 
TRCell():New(oDPJ ,'EMPRESA'	    	,/*TABELA*/	,'Empresa'	       ,/*Picture*/ 	    ,40		    	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		) 

 
oBreak01 		:= TRBreak():New(oDPJ,oDPJ:Cell("EMPRESA"),"Subtotal por Empresa"	,.F.)  

lTotSecBrk01	:= .F.//Indica se totalizador sera impresso na quebra de secao
lTotFimBrk01	:= .T.//Indica se totalizador sera impresso no final do relatorio - Como o total eh o mesmo, basta que apenas um esteja ativado
 TRFunction():New(oDPJ:Cell("VLAPR")    	,NIL,"SUM"			,oBreak01,,"@E 999,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01) 
 TRFunction():New(oDPJ:Cell("VLGLO")  		,NIL,"SUM"			,oBreak01,,"@E 999,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01) 
 TRFunction():New(oDPJ:Cell("VLPRO")  		,NIL,"SUM"			,oBreak01,,"@E 999,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01) 
 
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

Static Function ReportPrt1(oReport)

Local i := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

Local   cImp    :='Não'
Private oDPJ 	:= oReport:Section(1)

Private nCont	:= 0   

nCont := Len(aDados2)

//Se nao tiver esta linha, nao imprime os dados
oDPJ:init()

oReport:SetMeter(nCont) 

cTot	:= AllTrim(Transform(nCont,'@E 999,999,999,999'))
nCont 	:= 0       

For i := 1 To Len(aDados2)

	oReport:SetMsgPrint("Imprimindo linha " + AllTrim(Transform(++nCont,'@E 999,999,999,999')) + ' de ' + cTot)
	oReport:IncMeter()

	If oReport:Cancel()  
	    
	    oReport:FatLine()     
	    oReport:PrintText('Cancelado pelo operador!!!',,,CLR_RED,,,.T.)
		
	    exit
	    
	EndIf         
	oDPJ:Cell('GUIA'	 		):SetValue(AllTrim(aDados2[i][2]))    
  	oDPJ:Cell('COPART'	  		):SetValue((aDados2[i][4] ))      
    oDPJ:Cell('CLONE'   		):SetValue((aDados2[i][5]))   
   	oDPJ:Cell('USUAR'  		    ):SetValue((aDados2[i][6]))
    oDPJ:Cell('RDA'  		    ):SetValue((aDados2[i][7]))	
	oDPJ:Cell('VLAPR'	 		):SetValue((aDados2[i][8]))     
	oDPJ:Cell('VLGLO'	 		):SetValue((aDados2[i][9]))          
	oDPJ:Cell('VLPRO'	 		):SetValue((aDados2[i][10]))          
    oDPJ:Cell('EMPRESA'  		):SetValue((aDados2[i][12]))   
    
	oDPJ:PrintLine()
Next i

oDPJ:Finish()

Return   

********************************************************************************************************************************
******************************************************************************************

Static Function AjustaSX1(cPerg)

Local aHelpPor := {}

PutSx1(cPerg,"01",OemToAnsi("Mes Compcia Custo Inicial ") 		,"","","mv_ch01","C",02,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","",aHelpPor,{},{})
PutSx1(cPerg,"02",OemToAnsi("Ano Compcia Custo Inicial ") 		,"","","mv_ch02","C",04,0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","",aHelpPor,{},{}) 
PutSx1(cPerg,"03",OemToAnsi("Mes Compcia Custo Final   ") 		,"","","mv_ch03","C",02,0,0,"G","","","","","mv_par03","","","","","","","","","","","","","","","","",aHelpPor,{},{})
PutSx1(cPerg,"04",OemToAnsi("Ano Compcia Custo Final   ") 		,"","","mv_ch04","C",04,0,0,"G","","","","","mv_par04","","","","","","","","","","","","","","","","",aHelpPor,{},{})
   
PutSx1(cPerg,"05",OemToAnsi("Gerar Excel ") 	      		   	,"","","mv_ch05","N",01,0,0,"C","","","","","mv_par05","Sim","","","","Não","","","","","","","","","","","",{},{},{}) 
PutSx1(cPerg,"06",OemToAnsi("Sintetico   ")             		,"","","mv_ch06","N",01,0,0,"C","","","","","mv_par06","Sim","","","","Não","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"07",OemToAnsi("Analitico ")        	       		,"","","mv_ch07","N",01,0,0,"C","","","","","mv_par07","Sim ","","","","Não","","","","","","","","","","","",{},{},{})
                                          
PutSx1(cPerg,"08",OemToAnsi("Procedimento Inicial")       		,"","","mv_ch08","C",08,0,0,"G","","","","","mv_par08","","","","","","","","","","","","","","","","",aHelpPor,{},{})
PutSx1(cPerg,"09",OemToAnsi("Procedimento Final  ")     		,"","","mv_ch09","C",08,0,0,"G","","","","","mv_par09","","","","","","","","","","","","","","","","",aHelpPor,{},{})

PutSx1(cPerg,"10",OemToAnsi("Listar Codigo Procedimento?") 		,"","","mv_ch10","N",01,0,0,"C","","","","","mv_par10","Sim        ","","","","Não        ","","","","","","","","","","","",{},{},{}) 

PutSx1(cPerg,"11",OemToAnsi("Operadora de Origem Inic") 		,"","","mv_ch11","C",04,0,0,"G","","","","","mv_par11","","","","","","","","","","","","","","","","",aHelpPor,{},{})
PutSx1(cPerg,"12",OemToAnsi("Operadora de Origem Final ") 		,"","","mv_ch12","C",04,0,0,"G","","","","","mv_par12","","","","","","","","","","","","","","","","",aHelpPor,{},{})

Pergunte(cPerg,.F.)

Return

