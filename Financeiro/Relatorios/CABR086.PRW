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
User Function CABR086       

Local cMsg			:= ""
Private lAbortPrint :=.F.
Private cPerg       := "CABR086"
Private cTitulo     := "Critica Guias de coparticipação  Não cobradas "        

Private cAliastmp 	:= GetNextAlias()
Private cAliastmp1 	:= GetNextAlias() 
Private cAliastmp2 	:= GetNextAlias() 
                                                                         
//SetPrvt("oDlg1","oGrp1","oSay1","oSBtn1","oSBtn2","oSBtn3")

cMsg += " Este programa ira listar a critica de guias de cooparticipação sem  " + CRLF
cMsg += " numero de titulos de cobranca na tabela BD6 , assim caracterizando" + CRLF
cMsg += " a não cobrança da coparticipação                                   " + CRLF

//***************************************************************************    
private  nPrecReg    := 0
Private  aDados1     := {}       
Private  aDados2     := {} 
Private  aDados3     := {}     
Private  aDados4     := {}  

Private  acabec1    :={"Tipo","Cod.Emp","Chv. Nivel ","Procedimento ","Projeto","Evento","Copart. Bloq","Copart. Cobrada","Vlr Copart" ,"Vlr Apresent.","Vlr Glosado","Vlr Aprov.",;
                        "Vlr Copart" ,"Qtda Guias" ,"% Copart." , "Descr. Grp Cobertura e Precent." }                                        
                        
Private  acabec2     := {"Tipo","Guia","Procedi","Data Evento", "Copart Bloq","Clone","nomusr","Rda","Vlr Apresent.","Vlr Glosado","Vlr Aprov.","Vlr Copart"}    

Private  acabec3    := {"Tipo","Cod. Emp/ N. Guia ","Chv. Niv / Proced.","Data Evento","Proj/Clone","Evento / Rda " ,"Copat. Bloq","Copat. Cobrado","Vlr Copart" ,"Vlr Apresent.","Vlr Glosado","Vlr Aprov.",;
                        "Vlr Copart" ,"Qtda Guias" ,"% Copart." , "Descr. Grp Cobertura e Precent."}  

Private  acabec4    := {"Tipo","Competencia" ,"Copat. Bloq","Copat. Cobrado","Vlr Copart" ,"Vlr Apresent.","Vlr Glosado","Vlr Aprov.",;
                        "Vlr Copart" ,"Qtda Guias" ,"% Copart." , "Tpo Cobranca " }  

private Descric := ' '  
  	  
AjustaSX1(cPerg)

Pergunte(cPerg,.T.) 

cMesComp    := mv_par01
cAnoComp	  := mv_par02 
cEmpInc     := mv_par03
cEmpFim     := mv_par04
nGExcel     := Iif(mv_par05 == 1,.T.,.F.)  
nSint       := mv_par06     
nAnalG      := mv_par07     
cChaveNiv   := mv_par08 
nSemcoop    := mv_par09      
nprojeto    := mv_par10     
ndiverg     := mv_par11     
nblocoop    := mv_par12    
cProcInc    := mv_par14
cProcFim    := mv_par15    
clistar     := mv_par16 
nListProc   := mv_par17    
nNumMes     := mv_par18  
nCopCob     := mv_par19 // 1 cobrada 2 naocobrada 3 todas     
nTpCobCob   := iif(mv_par20==1,.T.,.F.)
nTpCobCab   := Iif(mv_par21==1,.T.,.F.)      
nLstRes     := mv_par22
cContInc    := '            ' 
cContFin    := 'ZZZZZZZZZZZZ'   
cEmpresa    := Iif(cEmpAnt == '01','C','I')      

//Se Numero de Meses > 0 E Listar Qualquer Opção <> de Analitico 
If nNumMes  > 0 .or. nLstRes != 2 
  fGeraresumo()     
  fGeraResl()  
  if nGExcel          
     DlgToExcel({{"ARRAY","Guias Não Cobradas - Sintetico " ,aCabec4,aDados4}})  
  EndIf   
endIf     
 //Se <> Resumos E (Seja Sintetico ou Analitico)
 if nLstRes != 1 .and. (nSint == 1 .or. nAnalG == 1) 
  
    Processa({||Processa1()}, cTitulo, "", .T.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Libera impressao                                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
   
// faz ecxel       

    if nSint == 1
       DlgToExcel({{"ARRAY","Guias Não Cobradas - Sintetico " ,aCabec1,aDados1}})   
    EndIF
    if nAnalG == 1    
       DlgToExcel({{"ARRAY","Guias Não Cobradas - Analitico " ,aCabec2,aDados2}})
       DlgToExcel({{"ARRAY","Opme Não Cobradas - Sintetico / Analitico " ,aCabec3,aDados3}})
    EndIf
 
///
    if nSint == 1
       fGeraRel2()    
    EndIf
    if nAnalG == 1  
         fGeraRel1()   
         fGeraRel3()   
      EndIf   
EndIf
     
MsgInfo("Processo finalizado")

Return                 

//**************************************************************************

Static Function fGeraresumo () 

local i:= 1
local nCompMF:= val(cMesComp)   
local nCompAF:= val(cAnoComp)   
Private cCompMF:= ' '   
Private cCompAF:= ' ' 
  
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
    
    if nTpCobCob 
    	cquery += " CASE nvl(e1_formrec,'00') WHEN '01' THEN '01 - Mater Aposentado' "
     	cquery += " WHEN '08' THEN '08 - Mater Aposentado Vinc' WHEN '02' THEN '02 - Banco Liq ' "
    	cquery += " WHEN '03' THEN '03 - Mater Empresa '  WHEN '04' THEN '04 - Boleto 112'"
    	cquery += " WHEN '05' THEN '05 - Boleto 175 ' WHEN '06' THEN '06 - SisDeb '	 WHEN '07' THEN '07 - Emp. Itau '"
    	cquery += " WHEN '00' THEN '00 - Não Cobrando ' ELSE e1_formrec||' - Não especf' END tpcob , "  
    else 
        cquery += " ' '  tpcob , "      	
    EndIf             
    
    if nTpCobCab
    	cquery += " CASE nvl(ba3_tippag ,'00') WHEN '01' THEN '01 - Mater Aposentado' "
     	cquery += " WHEN '08' THEN '08 - Mater Aposentado Vinc' WHEN '02' THEN '02 - Banco Liq ' "
    	cquery += " WHEN '03' THEN '03 - Mater Empresa '  WHEN '04' THEN '04 - Boleto 112'"
    	cquery += " WHEN '05' THEN '05 - Boleto 175 ' WHEN '06' THEN '06 - SisDeb '	 WHEN '07' THEN '07 - Emp. Itau '"
    	cquery += " WHEN '00' THEN '00 - Não Cobrando ' ELSE ba3_tippag ||' - Não especf' END tpcobcad , "
    Else 
      	cquery += " ' ' tpcobcad , "	  
    EndIf    
	cquery += " DECODE(trim(bd6f.bd6_seqpf), null, 'Não Consolidado' , 'Consolidado') consol "
	cquery += " FROM (SELECT BD7.BD7_FILIAL,BD7_CODPLA,SIGA_TIPO_EXPOSICAO_ANS(BD7_CODEMP,BD7_MATRIC,BD7_TIPREG,To_Date(Trim(BD7_DATPRO),'YYYYMMDD')) EXPOS, "
	cquery += " BD7.BD7_OPELOT,BD7.BD7_NUMLOT, BD7.BD7_CODOPE, BD7.BD7_CODLDP, BD7.BD7_CODPEG, BD7.BD7_NUMERO, BD7.BD7_ORIMOV, "
    if nListProc == 1 
    	cquery += " BD7_CODPRO, "
    EndIf	
	cquery += " BD7.BD7_SEQUEN,  Sum(BD7.BD7_VLRPAG) AS VLRPAG,COUNT(DISTINCT BD7_CODEMP||BD7_MATRIC||BD7_TIPREG) QTDE  "                                                                                  
	cquery += " FROM "+ RetSqlName("BD7") + " BD7 WHERE BD7.BD7_FILIAL = '"+xFilial("BD7")+"' AND BD7.BD7_CODOPE = '0001' AND BD7.BD7_SITUAC = '1' AND BD7.BD7_FASE = '4' AND BD7.BD7_BLOPAG <> '1' "
	cquery += " AND SUBSTR(BD7.BD7_NUMLOT,1,6) <= '"+cAnoComp + cMesComp+"' AND SUBSTR(BD7.BD7_NUMLOT,1,6) >= '"+ltrim(cCompAF) + ltrim(cCompMF)+"' "
	cquery += " and BD7.BD7_VLRPAG > 0 AND BD7_codemp >= '"+cEmpInc+"' and BD7_COdemp <='"+cEmpFim+"' and  BD7_CODEMP <> '0004' "
	cquery += " AND BD7.D_E_L_E_T_ = ' '  GROUP BY BD7_FILIAL, BD7_CODPLA, BD7.BD7_OPELOT,BD7.BD7_NUMLOT, "    
	if nListProc == 1 
	   cquery += " BD7_CODPRO, "
	EndIf   
	cquery += " SIGA_TIPO_EXPOSICAO_ANS(BD7_CODEMP,BD7_MATRIC,BD7_TIPREG,To_Date(Trim(BD7_DATPRO),'YYYYMMDD')), "
	cquery += " BD7_CODOPE, BD7_CODLDP, BD7_CODPEG, BD7_NUMERO, BD7_ORIMOV, BD7_SEQUEN) BD7F, "+ RetSqlName("BD6") + " BD6F  , "+ RetSqlName("BI3") + " BI3 ,"+ RetSqlName("ZZT") + " ZZT 	 " 
    if nTpCobCob 	
	   cquery += " ,"+ RetSqlName("se1") + " se1 " 
	EndIf
	if nTpCobCab
	   cquery += " ,"+ RetSqlName("ba3") + " ba3 " 
    EndIf
	cquery += " WHERE ZZT_FILIAL = '"+xFilial("ZZT")+"' AND BI3_FILIAL = '"+xFilial("BI3")+"'   AND BD6F.BD6_FILIAL = '"+xFilial("BD6")+"'  "  
	
	cquery += "	AND SUBSTR (BD7F.BD7_NUMLOT,1,6) <= '"+cAnoComp + cMesComp+"' AND SUBSTR (BD7F.BD7_NUMLOT,1,6) >= '"+ltrim(cCompAF) + ltrim(cCompMF)+"' "
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
    if nTpCobCob 	      
       cquery += " and e1_filial(+) = '"+xFilial("SE1")+"' and se1.d_E_L_E_T_(+) = ' ' "
       cquery += " and bd6_prefix = e1_prefixo(+) and bd6_numtit = e1_num(+)  and bd6_parcel = e1_parcela(+) and bd6_tiptit = e1_tipo(+) "      
    EndIf 
    if nTpCobCab 	
       cquery += " and ba3_filial(+) = '"+xFilial("ba3")+"' and BA3.d_E_L_E_T_(+) = ' '  and ba3_codint(+) ='0001'  and ba3_codemp(+) =bd6_codemp    and ba3_matric(+) = bd6_matric  "
    EndIf
	cquery += " GROUP BY SUBSTR(BD7F.BD7_NUMLOT,1,6), DECODE(TRIM(BD6F.bd6_blocpa),'1','Sim','Não') , "
	cquery += " DECODE(TRIM(BD6F.BD6_PREFIX),'','nao cobrado','cobrado')  , DECODE(BD6F.BD6_VLRTPF,0,'Sem Coopart','Com Coopart') ,"
	if nTpCobCob 	 
	   cquery += " e1_formrec , " 
	EndIf
	if nTpCobCab
    	cquery += " ba3_tippag , "
    EndIf	
	cquery += " DECODE(trim(bd6f.bd6_seqpf), null, 'Não Consolidado' , 'Consolidado') "
	                          
if clistar == 2                                                                                                                          

  	cquery +=  "union all"    
  	If nSemcoop == 1 .or. nSemcoop == 3
		cquery +=  " SELECT 'OPME' tipo ,competencia , "
		cquery +=  " DECODE(TRIM(BLOQ_COP1),'1','Sim','Não') BLOQ_COP , DECODE(TRIM(prefix1 ),'','nao cobrado','cobrado') COBRANDO , "
		cquery +=  " DECODE(VL_PARTICIPACAO,0,'Sem Coopart','Com Coopart') COOP , SUM(GLOSADO1) GLOSADO,SUM(VL_APROV1)  VL_APROV ,sum(VL_PARTICIPACAO)VL_PARTICIPACAO ,COUNT (*) QTDA ,"
        cquery +=  " tpcob , "   
		cquery +=  " tpcobcad , "
		cquery +=  " consol"
		cquery +=  " FROM( SELECT bd6.BD6_CODPLA PLANO, bd6.BD6_YNEVEN CodEvento,ZZT_EVENTO Nome_Evento, COUNT(DISTINCT bd6.BD6_CODEMP||bd6.BD6_MATRIC||bd6.BD6_TIPREG) QTDE , "
	 	cquery +=  " Sum(D1_QUANT) Ocorrencia, Sum(bd6.BD6_VLRGLO) Glosado1,Sum(D1_TOTAL)-Sum(D1_VALDESC)  Vl_Aprov1, "
	  	cquery +=  " RETORNA_VL_COPART_OPME (bd6.BD6_CODOPE,bd6.BD6_CODLDP,bd6.BD6_CODPEG,bd6.BD6_NUMERO,'"+cEmpresa+"') Vl_Participacao, "
	   	cquery +=  " SIGA_TIPO_EXPOSICAO_ANS(bd6.BD6_CODEMP,bd6.BD6_MATRIC,bd6.BD6_TIPREG,To_Date(Trim(bd6.BD6_DATPRO),'YYYYMMDD')) EXPOSICAO_ANS , "
		cquery +=  " DECODE(TRIM(BI3_YGRPLA),'4','MATER','2','AFINIDADE','3','EMPRESARIAL','1','ADMINISTRATIVO') GRUPO_PLANO, "
	 	cquery +=  " DECODE(bd6.BD6_CODEMP,'0007',TRIM(BI3_NREDUZ)||' (SEPE)',BI3_NREDUZ) NOME_PLANO, 0 VAL_ADIANT , B19_DOC , "
	  	cquery +=  " ZZT_TPCUST , bd6.BD6_CODEMP , bd6.BD6_YPROJ , bd6x.BD6_PREFIX PREFIX1 , bd6.BD6_BLOCPA BLOQ_COP1 ,  " 
	 	If nListProc == 1
	       cquery +=  " bd6.BD6_DESPRO , bd6.BD6_CODPRO ,  "   
        EndIf   
	   	cquery +=  " bd6.BD6_CHVNIV , SUBSTR(F1_EMISSAO,1,6) competencia , "
        if  nTpCobCob 	      		
    		cquery += " CASE nvl(e1_formrec,'00') WHEN '01' THEN '01 - Mater Aposentado' "
     	 	cquery += " WHEN '08' THEN '08 - Mater Aposentado Vinc' WHEN '02' THEN '02 - Banco Liq ' "
    		cquery += " WHEN '03' THEN '03 - Mater Empresa '  WHEN '04' THEN '04 - Boleto 112'"
    		cquery += " WHEN '05' THEN '05 - Boleto 175 e SisDeb ' WHEN '06' THEN '06 - SisDeb ' WHEN '07' THEN '07 - Emp. Itau '"
    		cquery += " WHEN '00' THEN '00 - Não Cobrando ' ELSE e1_formrec||' - Não especf' END tpcob ,   "  
    	else 	
    		cquery += " ' '  tpcob ,  "  
        EndIf 
         if  nTpCobCab 	      		
    		cquery += " CASE nvl(ba3_tippag ,'00') WHEN '01' THEN '01 - Mater Aposentado' "
     	 	cquery += " WHEN '08' THEN '08 - Mater Aposentado Vinc' WHEN '02' THEN '02 - Banco Liq ' "
    		cquery += " WHEN '03' THEN '03 - Mater Empresa '  WHEN '04' THEN '04 - Boleto 112'"
    		cquery += " WHEN '05' THEN '05 - Boleto 175 e SisDeb ' WHEN '06' THEN '06 - SisDeb ' WHEN '07' THEN '07 - Emp. Itau '"
    		cquery += " WHEN '00' THEN '00 - Não Cobrando ' ELSE ba3_tippag ||' - Não especf' END tpcobcad ,  "  
    	Else	
    		cquery += " ' ' tpcobcad  , "      		
        EndIf
        
	  	cquery +=  "  DECODE(trim(bd6x.bd6_seqpf), null, 'Não Consolidado' , 'Consolidado') consol "
   	
	    cquery += "	FROM "+ RetSqlName("B19") + " B19, "+ RetSqlName("SD1") + " SD1, "+ RetSqlName("SF1") + " SF1, "+ RetSqlName("BD6") + " BD6x , "+ RetSqlName("BD6") + " BD6 , "+ RetSqlName("SA2") + " SA2, "+ RetSqlName("ZZT") + " ZZT, "+ RetSqlName("BI3") + " BI3,"+ RetSqlName("BR8") + " BR8 " 
	    if nTpCobCob 	      		
	       cquery += ", " + RetSqlName("se1") + " se1 " 
	    EndIf
        if nTpCobCab 	      		   
 	       cquery += ", " + RetSqlName("ba3") + " ba3 " 
 	    EndIf   
	    cquery += " WHERE BI3_FILIAL='"+xFilial("BI3")+"'  AND A2_FILIAL='"+xFilial("SA2")+"' AND bd6.BD6_FILIAL = '"+xFilial("BD6")+"'  AND ZZT_FILIAL='"+xFilial("ZZT")+"' and BR8_FILIAL='"+xFilial("BR8")+"' AND b19_filial = '"+xFilial("B19")+"' and d1_FILIAL = '"+xFilial("SD1")+"' AND F1_FILIAL = '"+xFilial("SF1")+"'  "
		cquery += " AND bd6.BD6_codemp >='"+cEmpInc+"' and bd6.BD6_COdemp <='"+cEmpFim+"' "
		cquery += " AND SUBSTR(F1_EMISSAO,1,6) <= '"+cAnoComp + cMesComp+"' AND SUBSTR(F1_EMISSAO,1,6) >= '"+ltrim(cCompAF) + ltrim(cCompMF)+"' "     
		
		If nprojeto == 1                                                             
	       cquery += " AND bd6.BD6_YPROJ <> ' ' "
	    ElseIf nprojeto == 2                                                            
	       cquery += " AND bd6.BD6_YPROJ = ' ' "
	    EndIF                                                                                                          
	    
	    cquery += " and RETORNA_VL_COPART_OPME (bd6.BD6_CODOPE,bd6.BD6_CODLDP,bd6.BD6_CODPEG,bd6.BD6_NUMERO,'"+cEmpresa+"') <> 0 "  
	    
	    If nblocoop  == 1                                                             
		   cquery += " AND TRIM(bd6.bd6_blocpa) = '1' "
		ElseIf  nblocoop  == 2                                                             
		   cquery += " AND TRIM(bd6.bd6_blocpa) <> ' ' "
		EndIF      
	              
	    If cChaveNiv == 1
	       cquery += " AND bd6.bd6_chvniv <> ' ' " 
	    ElseIf cChaveNiv == 2
	       cquery += " AND bd6.bd6_chvniv = ' ' "
	    EndIf              
	    if nListProc == 1  
	       cquery += " AND bd6.bd6_codpro >= '"+cProcInc+"' AND bd6.bd6_codpro <= '"+cProcFim+"' "
	    EndIf                                                                            
	    
	    cquery += " AND A2_COD = B19_FORNEC AND D1_FORNECE= A2_COD AND F1_FORNECE= A2_COD AND D1_DOC = F1_DOC AND B19_DOC = D1_DOC AND D1_ITEM = B19_ITEM "
	    cquery += " AND bd6.BD6_CODPAD=BR8_CODPAD  AND bd6.BD6_CODPRO=BR8_CODPSA AND bd6.BD6_CODPLA=BI3_CODIGO   "
	    cquery += " AND bd6.BD6_CODOPE = SUBSTR(B19_GUIA,01,04) AND bd6.BD6_CODLDP = SUBSTR(B19_GUIA,05,04)AND bd6.BD6_CODPEG = SUBSTR(B19_GUIA,09,08) AND bd6.BD6_NUMERO = SUBSTR(B19_GUIA,17,08) "
	    cquery += " AND bd6.BD6_ORIMOV = SubStr(B19_GUIA,25,01) AND bd6.BD6_SEQUEN = SubStr(B19_GUIA,26,03)AND bd6.BD6_FASE IN (3,4) AND bd6.BD6_CODLDP='0013' AND bd6.BD6_SITUAC = 1 AND bd6.BD6_YNEVEN=ZZT_CODEV "
	     
	    cquery += " and BD6X.BD6_FILIAL ='"+xFilial("BD6")+"'    AND BD6X.BD6_CODPRO IN ('01990012','02990016','03990010')
	    cquery += " AND BD6X.BD6_CODOPE = SUBSTR(B19_GUIA,01,04) AND BD6X.BD6_CODLDP = SUBSTR(B19_GUIA,05,04)
	    cquery += " AND BD6X.BD6_CODPEG = SUBSTR(B19_GUIA,09,08) AND BD6X.BD6_NUMERO = SUBSTR(B19_GUIA,17,08) AND BD6X.D_E_L_E_T_ = ' '   
	    if nTpCobCob 	      			    
           cquery += " and e1_filial(+) = '"+xFilial("SE1")+"' and se1.d_E_L_E_T_(+) = ' ' "
           cquery += " and BD6X.bd6_prefix = e1_prefixo(+) and BD6X.bd6_numtit = e1_num(+)  and BD6X.bd6_parcel = e1_parcela(+) and BD6X.bd6_tiptit = e1_tipo(+) "
        EndIf 
    	if nTpCobCab
     	   cquery += " and ba3_filial(+) = '"+xFilial("ba3")+"' and BA3.d_E_L_E_T_(+) = ' '  and ba3_codint(+) ='0001'  and ba3_codemp(+) =bd6x.bd6_codemp    and ba3_matric(+) = bd6x.bd6_matric  "
    	EndIf  	      		
	    cquery += " AND SA2.D_E_L_E_T_ = ' ' AND B19.D_E_L_E_T_ = ' ' AND SD1.D_E_L_E_T_ = ' ' AND BR8.D_E_L_E_T_=' ' "
	    cquery += " AND SF1.D_E_L_E_T_ = ' ' AND BD6.D_E_L_E_T_ = ' ' AND ZZT.D_E_L_E_T_ = ' ' AND BI3.D_E_L_E_T_ = ' ' " 
	
	    cquery += " GROUP BY SIGA_TIPO_EXPOSICAO_ANS(bd6.BD6_CODEMP,bd6.BD6_MATRIC,bd6.BD6_TIPREG,TO_DATE(TRIM(bd6.BD6_DATPRO),'YYYYMMDD')), bd6.BD6_CODEMP, bd6.BD6_CODPLA, "
	    cquery += " TRIM(BI3_YGRPLA),DECODE(bd6.BD6_CODEMP,'0007',TRIM(BI3_NREDUZ)||' (SEPE)',BI3_NREDUZ), bd6.BD6_YNEVEN , B19_DOC, ZZT_EVENTO,ZZT_TPCUST,bd6.BD6_CODEMP, "
	     
	    cquery += " bd6.BD6_YPROJ,bd6x.BD6_PREFIX, bd6.BD6_BLOCPA , " 
	
	    If nListProc == 1
	       cquery += " bd6.BD6_DESPRO, bd6.BD6_CODPRO ,"
	    EndIf 
	    cquery += " bd6.BD6_CHVNIV , RETORNA_VL_COPART_OPME (bd6.BD6_CODOPE, bd6.BD6_CODLDP, bd6.BD6_CODPEG, bd6.BD6_NUMERO,'"+cEmpresa+"'), SUBSTR(F1_EMISSAO,1,6) , "
	    if nTpCobCob 
   	       cquery += " e1_formrec , " 
   	    EndIf       
   	    If nTpCobCab                 
     	   cquery += " ba3_tippag , "
   	    EndIf  
	  	cquery +=  "  DECODE(trim(bd6x.bd6_seqpf), null, 'Não Consolidado' , 'Consolidado') ) "
	 
	    cquery += " GROUP BY  competencia , "
	    cquery += " DECODE(TRIM(BLOQ_COP1),'1','Sim','Não') , DECODE(TRIM(PREFIX1 ),'','nao cobrado','cobrado')  , "    
	    cquery += " DECODE(VL_PARTICIPACAO,0,'Sem Coopart','Com Coopart')"
        cquery += " , tpcob "
        cquery += " , tpcobcad " 
	    cquery += " , consol " 
  EndIF	 
	 If nSemcoop == 2 .or. nSemcoop == 3                                     
  
            cquery +=  "union all"    

			cquery +=  " SELECT 'OPME' tipo ,competencia ,  "
			cquery +=  " DECODE(TRIM(BLOQ_COP1),'1','Sim','Não') BLOQ_COP , DECODE(TRIM(prefix1 ),'','nao cobrado','cobrado') COBRANDO , "
			cquery +=  " DECODE(VL_PARTICIPACAO,0,'Sem Coopart','Com Coopart') COOP , SUM(GLOSADO1) GLOSADO,SUM(VL_APROV1)  VL_APROV ,sum(VL_PARTICIPACAO)VL_PARTICIPACAO ,COUNT (*) QTDA , "
			cquery +=  " '00 - Não Cobrando'  tpcob , "
		    cquery +=  " tpcobcad , "
            cquery +=  " consol"

			cquery +=  " FROM( SELECT bd6.BD6_CODPLA PLANO, bd6.BD6_YNEVEN CodEvento,ZZT_EVENTO Nome_Evento, COUNT(DISTINCT bd6.BD6_CODEMP||bd6.BD6_MATRIC||bd6.BD6_TIPREG) QTDE ,  "
		 	cquery +=  " Sum(D1_QUANT) Ocorrencia, Sum(bd6.BD6_VLRGLO) Glosado1,Sum(D1_TOTAL)-Sum(D1_VALDESC)  Vl_Aprov1, "
		  	cquery +=  " RETORNA_VL_COPART_OPME (bd6.BD6_CODOPE,bd6.BD6_CODLDP,bd6.BD6_CODPEG,bd6.BD6_NUMERO,'"+cEmpresa+"') Vl_Participacao, "
		   	cquery +=  " SIGA_TIPO_EXPOSICAO_ANS(bd6.BD6_CODEMP,bd6.BD6_MATRIC,bd6.BD6_TIPREG,To_Date(Trim(bd6.BD6_DATPRO),'YYYYMMDD')) EXPOSICAO_ANS , "
			cquery +=  " DECODE(TRIM(BI3_YGRPLA),'4','MATER','2','AFINIDADE','3','EMPRESARIAL','1','ADMINISTRATIVO') GRUPO_PLANO, "
		 	cquery +=  " DECODE(bd6.BD6_CODEMP,'0007',TRIM(BI3_NREDUZ)||' (SEPE)',BI3_NREDUZ) NOME_PLANO, 0 VAL_ADIANT , B19_DOC , "
		  	cquery +=  " ZZT_TPCUST , bd6.BD6_CODEMP , bd6.BD6_YPROJ , ' '  PREFIX1 , bd6.BD6_BLOCPA BLOQ_COP1 ,  "
		 	If nListProc == 1
		       cquery +=  " bd6.BD6_DESPRO , bd6.BD6_CODPRO ,  "   
		    EndIf   
    	   	cquery += " bd6.BD6_CHVNIV , SUBSTR(F1_EMISSAO,1,6) competencia  ,    "
    	   	
         if  nTpCobCab 	      		
    		cquery += " CASE nvl(ba3_tippag ,'00') WHEN '01' THEN '01 - Mater Aposentado' "
     	 	cquery += " WHEN '08' THEN '08 - Mater Aposentado Vinc' WHEN '02' THEN '02 - Banco Liq ' "
    		cquery += " WHEN '03' THEN '03 - Mater Empresa '  WHEN '04' THEN '04 - Boleto 112'"
    		cquery += " WHEN '05' THEN '05 - Boleto 175 e SisDeb ' WHEN '06' THEN '06 - SisDeb ' WHEN '07' THEN '07 - Emp. Itau '"
    		cquery += " WHEN '00' THEN '00 - Não Cobrando ' ELSE ba3_tippag ||' - Não especf' END tpcobcad  , "  
    	 else 	 
    		cquery += "  ' '  tpcobcad ,  "      		
        EndIf

	  	    cquery +=  "   'Não Consolidado'  consol " 
	  	  
    	    cquery += "	FROM "+ RetSqlName("B19") + " B19, "+ RetSqlName("SD1") + " SD1, "+ RetSqlName("SF1") + " SF1, "+ RetSqlName("BD6") + " BD6, "+ RetSqlName("SA2") + " SA2, "+ RetSqlName("ZZT") + " ZZT, "+ RetSqlName("BI3") + " BI3, "+ RetSqlName("BR8") + " BR8 "
    	   	if nTpCobCab 	      		   
 	           cquery += ", " + RetSqlName("ba3") + " ba3 " 
 	        EndIf   
    	   
    	    cquery += " WHERE BI3_FILIAL='"+xFilial("BI3")+"'  AND A2_FILIAL='"+xFilial("SA2")+"' AND bd6.BD6_FILIAL = '"+xFilial("BD6")+"'  AND ZZT_FILIAL='"+xFilial("ZZT")+"' and BR8_FILIAL='"+xFilial("BR8")+"' AND b19_filial = '"+xFilial("B19")+"' and d1_FILIAL = '"+xFilial("SD1")+"' AND F1_FILIAL = '"+xFilial("SF1")+"'  "
			
			cquery += " AND bd6.BD6_codemp >='"+cEmpInc+"' and bd6.BD6_COdemp <='"+cEmpFim+"' "
			cquery += " AND SUBSTR(F1_EMISSAO,1,6) <= '"+cAnoComp + cMesComp+"' AND SUBSTR(F1_EMISSAO,1,6) >= '"+ltrim(cCompAF) + ltrim(cCompMF)+"' "     
			
			If nprojeto == 1                                                             
		       cquery += " AND bd6.BD6_YPROJ <> ' ' "
		    ElseIf nprojeto == 2                                                            
		       cquery += " AND bd6.BD6_YPROJ = ' ' "
		    EndIF         
	    
		    cquery += " and RETORNA_VL_COPART_OPME (bd6.BD6_CODOPE,bd6.BD6_CODLDP,bd6.BD6_CODPEG,bd6.BD6_NUMERO,'"+cEmpresa+"') =  0 "
		    
		    If nblocoop  == 1                                                             
			   cquery += " AND TRIM(bd6.bd6_blocpa) = '1' "
			ElseIf  nblocoop  == 2                                                             
			   cquery += " AND TRIM(bd6.bd6_blocpa) <> ' ' "
			EndIF      
		              
		    If cChaveNiv == 1
		       cquery += " AND bd6.bd6_chvniv <> ' ' " 
		    ElseIf cChaveNiv == 2
		       cquery += " AND bd6.bd6_chvniv = ' ' "
		    EndIf              
		    if nListProc == 1  
		       cquery += " AND bd6.bd6_codpro >= '"+cProcInc+"' AND bd6.bd6_codpro <= '"+cProcFim+"' "
		    EndIf                                                                            
		    
		    cquery += " AND A2_COD = B19_FORNEC AND D1_FORNECE= A2_COD AND F1_FORNECE= A2_COD AND D1_DOC = F1_DOC AND B19_DOC = D1_DOC AND D1_ITEM = B19_ITEM "
		    cquery += " AND bd6.BD6_CODPAD=BR8_CODPAD  AND bd6.BD6_CODPRO=BR8_CODPSA AND bd6.BD6_CODPLA=BI3_CODIGO   "
		    cquery += " AND bd6.BD6_CODOPE = SUBSTR(B19_GUIA,01,04) AND bd6.BD6_CODLDP = SUBSTR(B19_GUIA,05,04)AND bd6.BD6_CODPEG = SUBSTR(B19_GUIA,09,08) AND bd6.BD6_NUMERO = SUBSTR(B19_GUIA,17,08) "
		    cquery += " AND bd6.BD6_ORIMOV = SubStr(B19_GUIA,25,01) AND bd6.BD6_SEQUEN = SubStr(B19_GUIA,26,03)AND bd6.BD6_FASE IN (3,4) AND bd6.BD6_CODLDP='0013' AND bd6.BD6_SITUAC = 1 AND bd6.BD6_YNEVEN=ZZT_CODEV "
		     
		    cquery += " AND SA2.D_E_L_E_T_ = ' ' AND B19.D_E_L_E_T_ = ' ' AND SD1.D_E_L_E_T_ = ' ' AND BR8.D_E_L_E_T_=' ' "
		    cquery += " AND SF1.D_E_L_E_T_ = ' ' AND BD6.D_E_L_E_T_ = ' ' AND ZZT.D_E_L_E_T_ = ' ' AND BI3.D_E_L_E_T_ = ' ' " 
		    
			if nTpCobCab
        	   cquery += " and ba3_filial(+) = '"+xFilial("ba3")+"' and BA3.d_E_L_E_T_(+) = ' '  and ba3_codint(+) ='0001'  and ba3_codemp(+) =bd6.bd6_codemp    and ba3_matric(+) = bd6.bd6_matric  "
         	EndIf  	      		
		
		    cquery += " GROUP BY SIGA_TIPO_EXPOSICAO_ANS(bd6.BD6_CODEMP,bd6.BD6_MATRIC,bd6.BD6_TIPREG,TO_DATE(TRIM(bd6.BD6_DATPRO),'YYYYMMDD')), bd6.BD6_CODEMP, bd6.BD6_CODPLA, "
		    cquery += " TRIM(BI3_YGRPLA),DECODE(bd6.BD6_CODEMP,'0007',TRIM(BI3_NREDUZ)||' (SEPE)',BI3_NREDUZ), bd6.BD6_YNEVEN , B19_DOC, ZZT_EVENTO,ZZT_TPCUST,bd6.BD6_CODEMP, "
		     
		    cquery += " bd6.BD6_YPROJ,' ', bd6.BD6_BLOCPA , " 
		    cquery +=  "   'Não Consolidado' ,  " 
		    If nListProc == 1
		       cquery += " bd6.BD6_DESPRO, bd6.BD6_CODPRO ,"
		    EndIf 
		    cquery += " bd6.BD6_CHVNIV , RETORNA_VL_COPART_OPME (bd6.BD6_CODOPE, bd6.BD6_CODLDP, bd6.BD6_CODPEG, bd6.BD6_NUMERO,'"+cEmpresa+"'), SUBSTR(F1_EMISSAO,1,6)"
		    
		    if nTpCobCab
		       cquery += ", ba3_tippag"
		    EndIF 
		    cquery += ")"

		    cquery += " GROUP BY  competencia , "
		    cquery += " DECODE(TRIM(BLOQ_COP1),'1','Sim','Não') , DECODE(TRIM(PREFIX1 ),'','nao cobrado','cobrado')  , "    
		    cquery += " DECODE(VL_PARTICIPACAO,0,'Sem Coopart','Com Coopart')  
  		    cquery += " , tpcobcad " 		    
		    cquery += " , consol " 
     EndIF
   EndIF 

	cquery += " ORDER BY  2 ,1, 3, 4 , 5 " 
	cquery += " --Query Salva de: CABR086 - Linha 477 "
	 
    memowrite('c:\temp\CABR086RES.SQL',cquery)
    
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
     	                (cAliastmp)->tpcobcad ,;                                                     
     	               (cAliastmp)->Consol }) 

///////////////	   	             
        (cAliastmp)->(dbSkip()) 	   	    
     EndDo	                   
Return

//*************************************************************************************************************  
Static Function fGeraresl

Local oReport 
Private cPerg		:= "CABR086"  
Private aOrdem 		:= {}//{'RDA','Ano/Mes'}

//aSort( aDados1,,,{|x,y| x[10] < y[10]} )

oReport:= ReportDresl()
oReport:PrintDialog()

Return

//**************************************************************************

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
	cquery += " SUM(DECODE(BD6F.BD6_BLOCPA,'1',0,DECODE(SIGN(BD6F.BD6_VLRTPF),-1,0,DECODE(BD6_CODEMP,'0004',0,'0009',0,BD6F.BD6_VLRTPF)))) VL_PARTICIPACAO ,count (*) qtda , ' ' guia"
	cquery += " FROM (SELECT BD7.BD7_FILIAL,BD7_CODPLA,SIGA_TIPO_EXPOSICAO_ANS(BD7_CODEMP,BD7_MATRIC,BD7_TIPREG,To_Date(Trim(BD7_DATPRO),'YYYYMMDD')) EXPOS, "
	cquery += " BD7.BD7_OPELOT,BD7.BD7_NUMLOT, BD7.BD7_CODOPE, BD7.BD7_CODLDP, BD7.BD7_CODPEG, BD7.BD7_NUMERO, BD7.BD7_ORIMOV, "
    if nListProc == 1 
    	cquery += " BD7_CODPRO, "
    EndIf	
	cquery += " BD7.BD7_SEQUEN,  Sum(BD7.BD7_VLRPAG) AS VLRPAG,COUNT(DISTINCT BD7_CODEMP||BD7_MATRIC||BD7_TIPREG) QTDE  "                                                                                  
	cquery += " FROM " + RetSqlName("BD7")+" BD7 WHERE BD7.BD7_FILIAL = '"+xFilial("BD7")+"'  AND BD7.BD7_CODOPE = '0001' AND BD7.BD7_SITUAC = '1' AND BD7.BD7_FASE = '4' AND BD7.BD7_BLOPAG <> '1' "
	cquery += " AND SUBSTR (BD7.BD7_NUMLOT,1,6) = '"+cAnoComp + cMesComp+"' and BD7.BD7_VLRPAG > 0 AND BD7_codemp >= '"+cEmpInc+"' and BD7_COdemp <='"+cEmpFim+"' and  BD7_CODEMP <> '0004' "
	cquery += " AND BD7.D_E_L_E_T_ = ' '  GROUP BY BD7_FILIAL, BD7_CODPLA, BD7.BD7_OPELOT,BD7.BD7_NUMLOT, "    
	if nListProc == 1 
	   cquery += " BD7_CODPRO, "
	EndIf   
	cquery += " SIGA_TIPO_EXPOSICAO_ANS(BD7_CODEMP,BD7_MATRIC,BD7_TIPREG,To_Date(Trim(BD7_DATPRO),'YYYYMMDD')), "
//	cquery += " BD7_CODOPE, BD7_CODLDP, BD7_CODPEG, BD7_NUMERO, BD7_ORIMOV, BD7_SEQUEN) BD7F,  BD6010  BD6F  , BI3010 BI3 ,ZZT010  ZZT "     
	cquery += " BD7_CODOPE, BD7_CODLDP, BD7_CODPEG, BD7_NUMERO, BD7_ORIMOV, BD7_SEQUEN) BD7F,  " + RetSqlName("BD6")+" BD6f ," + RetSqlName("BI3")+" BI3 , " + RetSqlName("ZZT")+" ZZT "    
	
	cquery += " WHERE ZZT_FILIAL = '"+xFilial("ZZT")+"' AND BI3_FILIAL = '"+xFilial("BI3")+"' AND BD6F.BD6_FILIAL = '"+xFilial("BD6")+"' AND SUBSTR (BD7F.BD7_NUMLOT,1,6) = '"+cAnoComp + cMesComp+"' "
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
  	if nCopCob == 1                                       
	   cquery += " and BD6F.BD6_PREFIX =  'PLS' "
	elseif nCopCob == 2                    
	   cquery += " and BD6F.BD6_PREFIX <> 'PLS' " 
	EndIf 
	
		cquery += " GROUP BY BD6_CODEMP,  BD6_CHVNIV, "
	If nListProc == 1   
	   cquery += " bd6f.bd6_codpro, bd6f.bd6_despro , "
	EndIf                

	cquery += " BD6_YPROJ , BD6_YNEVEN , ZZT_EVENTO , DECODE(TRIM(BD6F.bd6_blocpa),'1','Sim','Não') , "
	cquery += " DECODE(TRIM(BD6F.BD6_PREFIX),'','nao cobrado','cobrado')  , DECODE(BD6F.BD6_VLRTPF,0,'Sem Coopart','Com Coopart'), "
	cquery += " BD6_CONEMP, RETORNA_DESC_CONTRATO('"+cEmpresa+"',BD6_OPEUSR,BD6_CODEMP,BD6_CONEMP) "             
	                          
if clistar == 2
  	cquery +=  "union all"  
  	If nSemcoop == 1 .or. nSemcoop == 3
		cquery +=  " SELECT '2' , '-> OPME <-' TIPO, BD6_CODEMP ,BD6_CHVNIV, "
	 	if nListProc == 1
		    cquery +=  "BD6_CODPRO CODPRO, BD6_DESPRO DESCPRO , "
		EndIf                   
	 // cquery += " BD6_YPROJ, BD6_YNEVEN , ZZT_EVENTO ,"
		cquery += " BD6_YPROJ, CODEVENTO , NOME_EVENTO , "
		cquery +=  " DECODE(TRIM(BLOQ_COP1),'1','Sim','Não') BLOQ_COP , DECODE(TRIM(prefix1 ),'','nao cobrado','cobrado') COBRANDO , "
		cquery +=  " DECODE(VL_PARTICIPACAO,0,'Sem Coopart','Com Coopart') COOP , SUM(GLOSADO1) GLOSADO,SUM(VL_APROV1)  VL_APROV ,sum(VL_PARTICIPACAO)VL_PARTICIPACAO ,COUNT (*) QTDA , guia "
		cquery +=  " FROM( SELECT BD6.BD6_CODPLA PLANO, BD6.BD6_YNEVEN CodEvento,ZZT_EVENTO Nome_Evento, COUNT(DISTINCT BD6.BD6_CODEMP||BD6.BD6_MATRIC||BD6.BD6_TIPREG) QTDE, "
	 	cquery +=  " Sum(D1_QUANT) Ocorrencia, Sum(BD6.BD6_VLRGLO) Glosado1,Sum(D1_TOTAL)-Sum(D1_VALDESC)  Vl_Aprov1, "
	  	cquery +=  " RETORNA_VL_COPART_OPME (BD6.BD6_CODOPE,BD6.BD6_CODLDP,BD6.BD6_CODPEG,BD6.BD6_NUMERO,'"+cEmpresa+"') Vl_Participacao, "
	   	cquery +=  " SIGA_TIPO_EXPOSICAO_ANS(BD6.BD6_CODEMP,BD6.BD6_MATRIC,BD6.BD6_TIPREG,To_Date(Trim(BD6.BD6_DATPRO),'YYYYMMDD')) EXPOSICAO_ANS , "
		cquery +=  " DECODE(TRIM(BI3_YGRPLA),'4','MATER','2','AFINIDADE','3','EMPRESARIAL','1','ADMINISTRATIVO') GRUPO_PLANO, "
	 	cquery +=  " DECODE(BD6.BD6_CODEMP,'0007',TRIM(BI3_NREDUZ)||' (SEPE)',BI3_NREDUZ) NOME_PLANO, 0 VAL_ADIANT , B19_DOC , "
	  	cquery +=  " ZZT_TPCUST , BD6.BD6_CODEMP , BD6.BD6_YPROJ , bd6x.BD6_PREFIX PREFIX1 , BD6.BD6_BLOCPA BLOQ_COP1 ,  "
	 	If nListProc == 1
	       cquery +=  " BD6.BD6_DESPRO , BD6.BD6_CODPRO ,  "   
	    EndIf   
//	   	cquery +=  " BD6.BD6_CHVNIV , B19_GUIA guia FROM SIGA.B19010 B19, SIGA.SD1010 SD1, SIGA.SF1010 SF1, SIGA.BD6010 BD6 , SIGA.SA2010 SA2, ZZT010 ZZT  ,BI3010 BI3,BR8010 BR8 , bd6010 bd6x " 
	   	cquery +=  " BD6.BD6_CHVNIV , B19_GUIA guia FROM " +RetSqlName("B19")+" B19, "+ RetSqlName("SD1")+" SD1, " + RetSqlName("SF1")+" SF1, " + RetSqlName("BD6")+" BD6, "+ RetSqlName("SA2")+" SA2, " + RetSqlName("ZZT")+" ZZT, " + RetSqlName("BI3")+" BI3, " + RetSqlName("BR8")+" BR8, " + RetSqlName("BD6")+" BD6x "
// 	    cquery +=  " WHERE BI3_FILIAL=' ' AND A2_FILIAL=' 'AND BD6.BD6_FILIAL = ' ' AND ZZT_FILIAL=' ' and BR8_FILIAL=' ' AND b19_filial = ' ' and d1_FILIAL = '01' AND F1_FILIAL = '01' " 
 	    cquery +=  " WHERE BI3_FILIAL='"+xFilial("BI3")+"' AND A2_FILIAL= '"+xFilial("SA2")+"' AND BD6.BD6_FILIAL = '"+xFilial("BD6")+"' AND ZZT_FILIAL='"+xFilial("ZZT")+"' and BR8_FILIAL='"+xFilial("BR8")+"' AND b19_filial = '"+xFilial("B19")+"' and d1_FILIAL = '"+xFilial("SD1")+"' AND F1_FILIAL = '"+xFilial("SF1")+"' "
		cquery += " AND BD6.BD6_codemp >='"+cEmpInc+"' and BD6.BD6_COdemp <='"+cEmpFim+"' AND SUBSTR (F1_EMISSAO,1,6) = '"+cAnoComp + cMesComp+"' "      
		
		If nprojeto == 1                                                             
	       cquery += " AND BD6.BD6_YPROJ <> ' ' "
	    ElseIf nprojeto == 2                                                            
	       cquery += " AND BD6.BD6_YPROJ = ' ' "
	    EndIF    
	         
        cquery += " and RETORNA_VL_COPART_OPME (BD6.BD6_CODOPE,BD6.BD6_CODLDP,BD6.BD6_CODPEG,BD6.BD6_NUMERO,'"+cEmpresa+"') <> 0 "    
	    
	    If nblocoop  == 1                                                             
		   cquery += " AND TRIM(BD6.bd6_blocpa) = '1' "
		ElseIf  nblocoop  == 2                                                             
		   cquery += " AND TRIM(BD6.bd6_blocpa) <> ' ' "
		EndIF      
	              
	    If cChaveNiv == 1
	       cquery += " AND BD6.bd6_chvniv <> ' ' " 
	    ElseIf cChaveNiv == 2
	       cquery += " AND BD6.bd6_chvniv = ' ' "
	    EndIf              
	    if nListProc == 1  
	       cquery += " AND BD6.bd6_codpro >= '"+cProcInc+"' AND BD6.bd6_codpro <= '"+cProcFim+"' "
	    EndIf                                                                            
	    
	    cquery += " AND A2_COD = B19_FORNEC AND D1_FORNECE= A2_COD AND F1_FORNECE= A2_COD AND D1_DOC = F1_DOC AND B19_DOC = D1_DOC AND D1_ITEM = B19_ITEM "
	    cquery += " AND BD6.BD6_CODPAD=BR8_CODPAD  AND BD6.BD6_CODPRO=BR8_CODPSA AND BD6.BD6_CODPLA=BI3_CODIGO   "
	    cquery += " AND BD6.BD6_CODOPE = SUBSTR(B19_GUIA,01,04) AND BD6.BD6_CODLDP = SUBSTR(B19_GUIA,05,04)AND BD6.BD6_CODPEG = SUBSTR(B19_GUIA,09,08) AND BD6.BD6_NUMERO = SUBSTR(B19_GUIA,17,08) "
	    cquery += " AND BD6.BD6_ORIMOV = SubStr(B19_GUIA,25,01) AND BD6.BD6_SEQUEN = SubStr(B19_GUIA,26,03)AND BD6.BD6_FASE IN (3,4) AND BD6.BD6_CODLDP='0013' AND BD6.BD6_SITUAC = 1 AND BD6.BD6_YNEVEN=ZZT_CODEV "
	
	    cquery += " AND SA2.D_E_L_E_T_ = ' ' AND B19.D_E_L_E_T_ = ' ' AND SD1.D_E_L_E_T_ = ' ' AND BR8.D_E_L_E_T_=' ' "
	    cquery += " AND SF1.D_E_L_E_T_ = ' ' AND BD6.D_E_L_E_T_ = ' ' AND ZZT.D_E_L_E_T_ = ' ' AND BI3.D_E_L_E_T_ = ' ' "    
	    
	    cquery += " and BD6X.BD6_FILIAL='"+xFilial("BD6")+"' AND BD6X.BD6_CODPRO IN ('01990012','02990016','03990010') "
	    cquery += " AND BD6X.BD6_CODOPE = SUBSTR(B19_GUIA,01,04) AND BD6X.BD6_CODLDP = SUBSTR(B19_GUIA,05,04) "
	    cquery += " AND BD6X.BD6_CODPEG = SUBSTR(B19_GUIA,09,08) AND BD6X.BD6_NUMERO = SUBSTR(B19_GUIA,17,08) AND BD6X.D_E_L_E_T_ = ' ' "

        if nCopCob == 1                                       
	       cquery += " and BD6X.BD6_PREFIX =  'PLS' "  
	    elseif nCopCob == 2                    
	       cquery += " and BD6X.BD6_PREFIX <>  'PLS' "  
	    EndIf   	                                                                              
	
	    cquery += " GROUP BY SIGA_TIPO_EXPOSICAO_ANS(BD6.BD6_CODEMP,BD6.BD6_MATRIC,BD6.BD6_TIPREG,TO_DATE(TRIM(BD6.BD6_DATPRO),'YYYYMMDD')), BD6.BD6_CODEMP, BD6.BD6_CODPLA, "
	    cquery += " TRIM(BI3_YGRPLA),DECODE(BD6.BD6_CODEMP,'0007',TRIM(BI3_NREDUZ)||' (SEPE)',BI3_NREDUZ), BD6.BD6_YNEVEN , B19_DOC, ZZT_EVENTO,ZZT_TPCUST,BD6.BD6_CODEMP, "
       
	    cquery += " BD6.BD6_YPROJ,BD6X.BD6_PREFIX, BD6.BD6_BLOCPA , B19_GUIA, " 
	
	    If nListProc == 1
	       cquery += " BD6.BD6_DESPRO, BD6.BD6_CODPRO ,"
	    EndIf 
	    cquery += " BD6.BD6_CHVNIV , RETORNA_VL_COPART_OPME (BD6.BD6_CODOPE,BD6.BD6_CODLDP,BD6.BD6_CODPEG,BD6.BD6_NUMERO,'"+cEmpresa+"') )"     
	 
	    cquery += " GROUP BY BD6_CODEMP , BD6_CHVNIV , "
	    If nListProc == 1
	       cquery += " BD6_CODPRO , BD6_DESPRO ," 
	    EndIf 
                                                 
	    cquery += "  BD6_YPROJ  ,CODEVENTO , NOME_EVENTO , "
	    cquery += " DECODE(TRIM(BLOQ_COP1),'1','Sim','Não') , DECODE(TRIM(PREFIX1 ),'','nao cobrado','cobrado')  , "    
	    cquery += " DECODE(VL_PARTICIPACAO,0,'Sem Coopart','Com Coopart') , VL_PARTICIPACAO , guia " 
	EndIF 
    If nSemcoop == 2 .or. nSemcoop == 3
        cquery +=  "union all"    
		cquery +=  " SELECT '2' , '-> OPME <-' TIPO, BD6_CODEMP ,BD6_CHVNIV, "
	 	if nListProc == 1
		    cquery +=  "BD6_CODPRO CODPRO, BD6_DESPRO DESCPRO , "
		EndIf                   
		cquery += " BD6_YPROJ, CODEVENTO , NOME_EVENTO , "
		cquery +=  " DECODE(TRIM(BLOQ_COP1),'1','Sim','Não') BLOQ_COP , DECODE(TRIM(prefix1 ),'','nao cobrado','cobrado') COBRANDO , "
		cquery +=  " DECODE(VL_PARTICIPACAO,0,'Sem Coopart','Com Coopart') COOP , SUM(GLOSADO1) GLOSADO,SUM(VL_APROV1)  VL_APROV ,sum(VL_PARTICIPACAO)VL_PARTICIPACAO ,COUNT (*) QTDA , guia "
		cquery +=  " FROM( SELECT BD6.BD6_CODPLA PLANO, BD6.BD6_YNEVEN CodEvento,ZZT_EVENTO Nome_Evento, COUNT(DISTINCT BD6.BD6_CODEMP||BD6.BD6_MATRIC||BD6.BD6_TIPREG) QTDE , "
	 	cquery +=  " Sum(D1_QUANT) Ocorrencia, Sum(BD6.BD6_VLRGLO) Glosado1,Sum(D1_TOTAL)-Sum(D1_VALDESC)  Vl_Aprov1, "
	  	cquery +=  " RETORNA_VL_COPART_OPME (BD6.BD6_CODOPE,BD6.BD6_CODLDP,BD6.BD6_CODPEG,BD6.BD6_NUMERO,'"+cEmpresa+"') Vl_Participacao, "
	   	cquery +=  " SIGA_TIPO_EXPOSICAO_ANS(BD6.BD6_CODEMP,BD6.BD6_MATRIC,BD6.BD6_TIPREG,To_Date(Trim(BD6.BD6_DATPRO),'YYYYMMDD')) EXPOSICAO_ANS , "
		cquery +=  " DECODE(TRIM(BI3_YGRPLA),'4','MATER','2','AFINIDADE','3','EMPRESARIAL','1','ADMINISTRATIVO') GRUPO_PLANO, "
	 	cquery +=  " DECODE(BD6.BD6_CODEMP,'0007',TRIM(BI3_NREDUZ)||' (SEPE)',BI3_NREDUZ) NOME_PLANO, 0 VAL_ADIANT , B19_DOC , "
	  	cquery +=  " ZZT_TPCUST , BD6.BD6_CODEMP , BD6.BD6_YPROJ  , BD6.BD6_BLOCPA BLOQ_COP1 , ' ' prefix1 ,  "
	 	If nListProc == 1
	       cquery +=  " BD6.BD6_DESPRO , BD6.BD6_CODPRO ,  "   
	    EndIf   
//	   	cquery +=  " BD6.BD6_CHVNIV , B19_GUIA guia FROM SIGA.B19010 B19,              SIGA.SD1010 SD1,           SIGA.SF1010 SF1,           SIGA.BD6010 BD6 ,          SIGA.SA2010 SA2,           ZZT010 ZZT  ,              BI3010 BI3,                 BR8010 BR8 ,               bd6010 bd6x " 
  		cquery +=  " BD6.BD6_CHVNIV , B19_GUIA guia FROM " +RetSqlName("B19")+" B19, " + RetSqlName("SD1")+" SD1, "+ RetSqlName("SF1")+" SF1, "+RetSqlName("BD6")+" BD6, " +RetSqlName("SA2")+" SA2, "+ RetSqlName("ZZT")+" ZZT, " +RetSqlName("BI3")+" BI3, " +RetSqlName("BR8")+" BR8" //, "+RetSqlName("BD6")+" BD6x "

	   // cquery +=  " WHERE BI3_FILIAL=' '                  AND A2_FILIAL=' '                   AND BD6.BD6_FILIAL = ' '                  AND ZZT_FILIAL=' '                  and BR8_FILIAL=' '                  AND b19_filial = ' '                  and d1_FILIAL = '01'                 AND F1_FILIAL = '01' "
 	    cquery +=  " WHERE BI3_FILIAL='"+xFilial("BI3")+"' AND A2_FILIAL= '"+xFilial("SA2")+"' AND BD6.BD6_FILIAL = '"+xFilial("BD6")+"' AND ZZT_FILIAL='"+xFilial("ZZT")+"' and BR8_FILIAL='"+xFilial("BR8")+"' AND b19_filial = '"+xFilial("B19")+"' and d1_FILIAL = '"+xFilial("SD1")+"' AND F1_FILIAL = '"+xFilial("SF1")+"' "	
		cquery += " AND BD6.BD6_codemp >='"+cEmpInc+"' and BD6.BD6_COdemp <='"+cEmpFim+"' AND SUBSTR (F1_EMISSAO,1,6) = '"+cAnoComp + cMesComp+"' "      
		
		If nprojeto == 1                                                             
	       cquery += " AND BD6.BD6_YPROJ <> ' ' "
	    ElseIf nprojeto == 2                                                            
	       cquery += " AND BD6.BD6_YPROJ = ' ' "
	    EndIF    
	         
        cquery += " and RETORNA_VL_COPART_OPME (BD6.BD6_CODOPE,BD6.BD6_CODLDP,BD6.BD6_CODPEG,BD6.BD6_NUMERO,'"+cEmpresa+"') =  0 "
	    
	    If nblocoop  == 1                                                             
		   cquery += " AND TRIM(BD6.bd6_blocpa) = '1' "
		ElseIf  nblocoop  == 2                                                             
		   cquery += " AND TRIM(BD6.bd6_blocpa) <> ' ' "
		EndIF      
	              
	    If cChaveNiv == 1
	       cquery += " AND BD6.bd6_chvniv <> ' ' " 
	    ElseIf cChaveNiv == 2
	       cquery += " AND BD6.bd6_chvniv = ' ' "
	    EndIf              
	    if nListProc == 1  
	       cquery += " AND BD6.bd6_codpro >= '"+cProcInc+"' AND BD6.bd6_codpro <= '"+cProcFim+"' "
	    EndIf                                                                            
	    
	    cquery += " AND A2_COD = B19_FORNEC AND D1_FORNECE= A2_COD AND F1_FORNECE= A2_COD AND D1_DOC = F1_DOC AND B19_DOC = D1_DOC AND D1_ITEM = B19_ITEM "
	    cquery += " AND BD6.BD6_CODPAD=BR8_CODPAD  AND BD6.BD6_CODPRO=BR8_CODPSA AND BD6.BD6_CODPLA=BI3_CODIGO   "
	    cquery += " AND BD6.BD6_CODOPE = SUBSTR(B19_GUIA,01,04) AND BD6.BD6_CODLDP = SUBSTR(B19_GUIA,05,04)AND BD6.BD6_CODPEG = SUBSTR(B19_GUIA,09,08) AND BD6.BD6_NUMERO = SUBSTR(B19_GUIA,17,08) "
	    cquery += " AND BD6.BD6_ORIMOV = SubStr(B19_GUIA,25,01) AND BD6.BD6_SEQUEN = SubStr(B19_GUIA,26,03)AND BD6.BD6_FASE IN (3,4) AND BD6.BD6_CODLDP='0013' AND BD6.BD6_SITUAC = 1 AND BD6.BD6_YNEVEN=ZZT_CODEV "
	
	    cquery += " AND SA2.D_E_L_E_T_ = ' ' AND B19.D_E_L_E_T_ = ' ' AND SD1.D_E_L_E_T_ = ' ' AND BR8.D_E_L_E_T_=' ' "
	    cquery += " AND SF1.D_E_L_E_T_ = ' ' AND BD6.D_E_L_E_T_ = ' ' AND ZZT.D_E_L_E_T_ = ' ' AND BI3.D_E_L_E_T_ = ' ' "    
	    
	   /* cquery += " and BD6X.BD6_FILIAL='"+xFilial("BD6")+"'  " 
	    cquery += " AND BD6X.BD6_CODOPE = SUBSTR(B19_GUIA,01,04) AND BD6X.BD6_CODLDP = SUBSTR(B19_GUIA,05,04) "
	    cquery += " AND BD6X.BD6_CODPEG = SUBSTR(B19_GUIA,09,08) AND BD6X.BD6_NUMERO = SUBSTR(B19_GUIA,17,08) AND BD6X.D_E_L_E_T_ = ' ' "
	    
        if nCopCob == 1                                       
	       cquery += " and bd6x.BD6_PREFIX =  'PLS' "
	    elseif nCopCob == 2                    
	       cquery += " and bd6x.BD6_PREFIX <>  'PLS' " 
	    EndIf   
	   */
	    cquery += " GROUP BY SIGA_TIPO_EXPOSICAO_ANS(BD6.BD6_CODEMP,BD6.BD6_MATRIC,BD6.BD6_TIPREG,TO_DATE(TRIM(BD6.BD6_DATPRO),'YYYYMMDD')), BD6.BD6_CODEMP, BD6.BD6_CODPLA, "
	    cquery += " TRIM(BI3_YGRPLA),DECODE(BD6.BD6_CODEMP,'0007',TRIM(BI3_NREDUZ)||' (SEPE)',BI3_NREDUZ), BD6.BD6_YNEVEN , B19_DOC, ZZT_EVENTO,ZZT_TPCUST,BD6.BD6_CODEMP, "       
	    cquery += " BD6.BD6_YPROJ, BD6.BD6_BLOCPA , B19_GUIA, " 
	
	    If nListProc == 1
	       cquery += " BD6.BD6_DESPRO, BD6.BD6_CODPRO ,"
	    EndIf 
	    cquery += " BD6.BD6_CHVNIV , RETORNA_VL_COPART_OPME (BD6.BD6_CODOPE,BD6.BD6_CODLDP,BD6.BD6_CODPEG,BD6.BD6_NUMERO,'"+cEmpresa+"') )"            

	    cquery += " GROUP BY BD6_CODEMP , BD6_CHVNIV , "
	    If nListProc == 1
	       cquery += " BD6_CODPRO , BD6_DESPRO ," 
	    EndIf                                               
	    cquery += "  BD6_YPROJ  ,CODEVENTO , NOME_EVENTO , "
	    cquery += " DECODE(TRIM(BLOQ_COP1),'1','Sim','Não') , DECODE(TRIM(PREFIX1 ),'','nao cobrado','cobrado')  , "    
	    cquery += " DECODE(VL_PARTICIPACAO,0,'Sem Coopart','Com Coopart') , VL_PARTICIPACAO , guia " 
	EndIF 
EndIF	

cquery += " ORDER BY 1, 3 , 4 , 5 ,6 "  
cquery += " --Query Salva de: CABR086 - Linha 799 "
	
memowrite('c:\temp\CABR086RES.SQL',cquery)				   	
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
       
        If ((ndiverg == 1) .and. (nPrecReg == ((cAliastmp)->VL_PARTICIPACAO *100) / (cAliastmp)->Vl_Aprov))      
           (cAliastmp)->(dbSkip()) 
           LOOP       
        ElseIf ((ndiverg == 2) .and. ((cAliastmp1)->precent != ((cAliastmp)->VL_PARTICIPACAO *100) / (cAliastmp)->Vl_Aprov))  
           (cAliastmp)->(dbSkip()) 
           LOOP                                              
        EndIf    
            
        If nListProc == 1
           cCodPro := (cAliastmp)->codpro+" - "+(cAliastmp)->descpro
        Else 
           cCodPro := "     -     "
        EndIf 
        aaDD(aDados1,{(cAliastmp)->tipo            ,;
                     (cAliastmp)->BD6_CODEMP       ,;
	                 (cAliastmp)->bd6_chvniv       ,;
	                 cCodpro                       ,;
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
	   	             
////////////////
       aaDD(aDados3,{(cAliastmp)->tipo             ,;
                     (cAliastmp)->BD6_CODEMP       ,;
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
       cquery += " SUM(DECODE(BD6F.BD6_BLOCPA,'1',0,DECODE(SIGN(BD6F.BD6_VLRTPF),-1,0,DECODE(BD6F.BD6_CODEMP,'0004',0,'0009',0,BD6F.BD6_VLRTPF)))) VL_PARTICIPACAO , "  
       cquery += " BD6F.BD6_PREFIX||BD6F.BD6_NUMTIT||BD6F.BD6_PARCEL||BD6F.BD6_TIPTIT NUMTIT , "

       cquery += " DECODE(trim(bd6f.bd6_seqpf), null, 'Não Consolidado' , 'Consolidado') consol "
       
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
       cquery += " AND  BD7.BD7_FASE = '4' "
       cquery += " AND  BD7.BD7_BLOPAG <> '1' " 
       cquery += " AND  BD7.BD7_VLRPAG > 0 "
       cquery += " AND  SUBSTR (BD7.BD7_NUMLOT,1,6) = '"+cAnoComp + cMesComp+"' "  
       //cquery += " AND  SUBSTR(BD7.BD7_NUMLOT,1,6) <= '"+cAnoComp + cMesComp+"' AND SUBSTR(BD7.BD7_NUMLOT,1,6) >= '"+ltrim(cCompAF) + ltrim(cCompMF)+"' "
       cquery += " AND  BD7_codemp >= '"+cEmpInc+"' and BD7_COdemp <='"+cEmpFim+"' and  BD7_CODEMP <> '0004' "
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
   	   cquery += " AND BD6F.BD6_codemp >= '"+cEmpInc+"' and BD6F.BD6_COdemp <='"+cEmpFim+"' and  BD6F.BD6_CODEMP <> '0004' "      
       cquery += " AND BD6F.BD6_CHVNIV = '"+(cAliastmp)->bd6_chvniv+ "' "
       cquery += " AND BD6F.BD6_YPROJ  = '"+(cAliastmp)->BD6_YPROJ + "' " 
       cquery += " AND BD6F.BD6_YNEVEN = '"+cvaltochar((cAliastmp)->CODEVENTO)+ "' "
       cquery += " AND DECODE(TRIM(BD6F.BD6_BLOCPA),'1','Sim','Não') = trim('"+(cAliastmp)->Bloq_Cop +"') "
       cquery += " AND DECODE(TRIM(BD6F.BD6_PREFIX),'','nao cobrado','cobrado') = trim('"+(cAliastmp)->COBRANDO+"') "  
       cquery += " And DECODE((DECODE(BD6F.BD6_BLOCPA,'1',0,DECODE(SIGN(BD6F.BD6_VLRTPF),-1,0,DECODE(BD6_CODEMP,'0004',0,'0009',0,BD6F.BD6_VLRTPF)))),0,'Sem Coopart','Com Coopart') = trim('"+(cAliastmp)->coop +"') "
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
       cquery += " DECODE(trim(bd6f.bd6_seqpf), null, 'Não Consolidado' , 'Consolidado') " 
       
   ElseIf trim((cAliastmp)->tipo)  == '-> OPME <-'                      
       cquery := " SELECT '   -> Det <-'  TIPO , "
       cquery += " BD6.BD6_CODPRO ||'-'|| BD6.BD6_DESPRO procedi  ,   "
       cquery += " BD6.BD6_CODOPE ||'-'|| BD6.BD6_CODLDP ||'-'|| BD6.BD6_CODPEG ||'-'|| BD6.BD6_NUMERO ||'-'|| BD6.BD6_SEQUEN ||'-'|| BD6.BD6_ORIMOV  GUIA , "
       cquery += " DECODE(BD6.BD6_BLOCPA,'1',' Sim ', ' Não ' ) BLOQ_COPART , "    
//       cquery += " BD6.BD6_NOMUSR NOMUSR , " 

      cquery += " BD6.BD6_OPEUSR ||'.'|| BD6.BD6_CODEMP ||'.'|| BD6.BD6_MATRIC ||'.'|| BD6.BD6_TIPREG ||'-'|| BD6.BD6_NOMUSR NOMUSR , " 

       cquery += " BD6.BD6_CODRDA||'-'||BD6.BD6_NOMRDA RDA , "
       cquery += " BD6.BD6_PREFIX||BD6.BD6_NUMTIT||BD6.BD6_PARCEL||BD6.BD6_TIPTIT NUMTIT , "
       cquery += " BD6.BD6_DATPRO DTPRO, " // MARCELA
       cquery += " SUM(BD6.BD6_VLRGLO) GLOSADO , " 
       cquery += " SUM(D1_TOTAL)-SUM(D1_VALDESC) VL_APROV , " 
      
       cquery += " SUM((RETORNA_VL_COPART_OPME (BD6.BD6_CODOPE,BD6.BD6_CODLDP,BD6.BD6_CODPEG,BD6.BD6_NUMERO,'"+cEmpresa+"'))) VL_PARTICIPACAO ,"
       
       cquery += " DECODE(trim(bd6.bd6_seqpf), null, 'Não Consolidado' , 'Consolidado') consol "

       //cquery += " SUM(DECODE(RETORNA_VL_COPART_OPME (BD6.BD6_CODOPE,BD6.BD6_CODLDP,BD6.BD6_CODPEG,BD6.BD6_NUMERO,'"+cEmpresa+"'))) VL_PARTICIPACAO "
       //cquery += " SUM(DECODE(BD6.BD6_BLOCPA,'1',0,DECODE(SIGN(BD6.BD6_VLRTPF),-1,0,DECODE(BD6.BD6_CODEMP,'0004',0,'0009',0,BD6.BD6_VLRTPF)))) VL_PARTICIPACAO
       cquery += " FROM "+ RetSqlName("B19") + " B19 , "+ RetSqlName("SD1") + " SD1 , "+ RetSqlName("SF1") + " SF1 , "+ RetSqlName("BD6") + " BD6 , "+ RetSqlName("SA2") + " SA2 "
       cquery += " WHERE A2_FILIAL='"+xFilial("SA2")+"'  "
       cquery += " AND BD6.BD6_FILIAL = '"+xFilial("BD6")+"'  "
   
       cquery += " AND BD6.BD6_codemp >= '"+cEmpInc+"' and BD6.BD6_COdemp <='"+cEmpFim+"' and  BD6.BD6_CODEMP <> '0004' "  
       
       If  (cAliastmp)->VL_PARTICIPACAO > 0  
           cquery += " AND RETORNA_VL_COPART_OPME (BD6.BD6_CODOPE,BD6.BD6_CODLDP,BD6.BD6_CODPEG,BD6.BD6_NUMERO,'"+cEmpresa+"') <> 0 " 
       Else                                                                                                               
           cquery += " AND RETORNA_VL_COPART_OPME (BD6.BD6_CODOPE,BD6.BD6_CODLDP,BD6.BD6_CODPEG,BD6.BD6_NUMERO,'"+cEmpresa+"') = 0 "
       EndIf            
       
       cquery += " AND B19_FILIAL = '"+xFilial("B19")+"'  " 
       cquery += " AND D1_FILIAL = '"+xFilial("SD1")+"'  " 
       cquery += " AND F1_FILIAL = '"+xFilial("SF1")+"'  "    
       
       cquery += " AND SUBSTR (F1_EMISSAO,1,6) = '"+cAnoComp + cMesComp+"' "   
       
       cquery += " AND A2_COD = B19_FORNEC "
       cquery += " AND D1_FORNECE= A2_COD "
       cquery += " AND F1_FORNECE= A2_COD "
       cquery += " AND D1_DOC = F1_DOC "
       cquery += " AND B19_DOC = D1_DOC "
       cquery += " AND D1_ITEM = B19_ITEM " 
       cquery += " AND BD6.BD6_CODOPE = SUBSTR(B19_GUIA,01,04) "
       cquery += " AND BD6.BD6_CODLDP = SUBSTR(B19_GUIA,05,04) "
       cquery += " AND BD6.BD6_CODPEG = SUBSTR(B19_GUIA,09,08) "
       cquery += " AND BD6.BD6_NUMERO = SUBSTR(B19_GUIA,17,08) " 
       
       If  (cAliastmp)->VL_PARTICIPACAO > 0
           cquery += " AND BD6.BD6_ORIMOV <> ' ' "
           cquery += " AND BD6.BD6_SEQUEN <> ' ' "  
           cquery += " AND BD6.BD6_CODPRO IN ('01990012','02990016','03990010')" 
       Else       
           cquery += " AND BD6.BD6_ORIMOV = SUBSTR(B19_GUIA,25,01) " 
           cquery += " AND BD6.BD6_SEQUEN = SUBSTR(B19_GUIA,26,03) "
       EndIf
               
       cquery += " AND BD6.BD6_CHVNIV = Trim('"+(cAliastmp)->bd6_chvniv+"') "
       cquery += " AND BD6.BD6_YPROJ  = '"+(cAliastmp)->BD6_YPROJ + "' " 
       cquery += " AND BD6.BD6_YNEVEN = " +cvaltochar((cAliastmp)->CODEVENTO) "
       cquery += " AND DECODE(TRIM(BD6.BD6_BLOCPA),'1','Sim','Não') = trim('"+(cAliastmp)->Bloq_Cop+"') "
            
       cquery += " AND DECODE(TRIM(BD6.BD6_PREFIX),'','nao cobrado','cobrado') = trim('"+(cAliastmp)->COBRANDO+"') "  
       cquery += " and DECODE(RETORNA_VL_COPART_OPME (BD6.BD6_CODOPE,BD6.BD6_CODLDP,BD6.BD6_CODPEG,BD6.BD6_NUMERO,'"+cEmpresa+"') ,0,'Sem Coopart','Com Coopart') = trim('"+(cAliastmp)->coop +"') " 
       
       If nListProc == 1                   
           cquery += " AND bd6.bd6_codpro = trim('"+(cAliastmp)->codpro+ "') "                                                                  
       EndIf    
       cquery += "  AND BD6.BD6_FASE IN (3,4) "
       cquery += "  AND BD6.BD6_CODLDP='0013' "
       cquery += "  AND BD6.BD6_SITUAC = 1 "
       cquery += "  AND SA2.D_E_L_E_T_ = ' ' "
       cquery += "  AND B19.D_E_L_E_T_ = ' ' " 
       cquery += "  AND SD1.D_E_L_E_T_ = ' ' "
       cquery += "  AND SF1.D_E_L_E_T_ = ' ' " 
       cquery += "  AND BD6.D_E_L_E_T_ = ' ' "
       cquery += "  GROUP BY BD6.BD6_CODPRO ||'-'|| BD6.BD6_DESPRO , "  
       cquery += "  BD6.BD6_CODOPE ||'-'|| BD6.BD6_CODLDP ||'-'|| BD6.BD6_CODPEG ||'-'|| BD6.BD6_NUMERO ||'-'|| BD6.BD6_SEQUEN ||'-'|| BD6.BD6_ORIMOV , " 
       cquery += "  DECODE(BD6.BD6_BLOCPA,'1',' Sim ', ' Não ' ) , "    
//       cquery += "  BD6.BD6_NOMUSR , "
       cquery += " BD6.BD6_OPEUSR ||'.'|| BD6.BD6_CODEMP ||'.'|| BD6.BD6_MATRIC ||'.'|| BD6.BD6_TIPREG ||'-'|| BD6.BD6_NOMUSR ,   "
       cquery += "  BD6.BD6_CODRDA||'-'||BD6.BD6_NOMRDA , "
       cquery += "  BD6.BD6_PREFIX||BD6.BD6_NUMTIT||BD6.BD6_PARCEL||BD6.BD6_TIPTIT , "
       cquery += "  BD6F.BD6_DATPRO , " // MARCELA
       cquery += " DECODE(trim(bd6.bd6_seqpf), null, 'Não Consolidado' , 'Consolidado')  "
     	                               
 //////////
                                                           
    EndIf 
    cquery += " --Query Salva de: CABR086 - Linha 1062 "
    memowrite('c:\temp\CABR086AN.SQL',cquery)  
    
    If Select(("TMP1")) <> 0 
       ("TMP1")->(DbCloseArea()) 
    Endif
  
    TCQuery cQuery Alias "TMP1" New 
    
    dbSelectArea("TMP1")
   
    tmp1->(dbGoTop())  
    
    While Tmp1->(!Eof())           
        aaDD(aDados2,{tmp1->tipo         ,;
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
Private cPerg		:= "CABR086"  
Private aOrdem 		:= {}//{'RDA','Ano/Mes'}

//aSort( aDados1,,,{|x,y| x[10] < y[10]} )

oReport:= ReportDef2()
oReport:PrintDialog()

Return

*************************************************************************************************************
Static Function fGeraRel3

Local oReport 
Private cPerg		:= "CABR086"  
Private aOrdem 		:= {}//{'RDA','Ano/Mes'}

//aSort( aDados1,,,{|x,y| x[10] < y[10]} )

oReport:= ReportDef3()
oReport:PrintDialog()

Return
*************************************************************************************************************
  
*************************************************************************************************************
*************************************************************************************************************

Static Function fGeraRel1

Local oReport 
Private cPerg		:= "CABR086"  
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

oReport	:= TReport():New("CABR086","Analise de Cobradas de Coparticipação - Visão Custo - Competencia : "+cMesComp+"/"+cAnoComp,, {|oReport| ReportPrt(oReport)},"Este relatorio lista a cobranca de coparticipação")
oReport:SetTotalInLine(.F.)//Imprime na linha: .F. - Imprime abaixo da linha com o titulo de cada coluna: .T.
oReport:SetTotalText('Total Geral') 

*'-----------------------------------------------------------------------------------'*
*'Solucao para impressao em que as colunas se truncam: "SetColSpace" e "SetLandScape"'* 
*'-----------------------------------------------------------------------------------'*

oReport:SetColSpace(1) //Espacamento entre colunas. 
oReport:SetLandscape() //Impressao em paisagem.  
//oReport:SetPortrait() //Impressao em retrato.  

*'-----------------------------------------------------------------------------------'*
                                                                
oDPJ := TRSection():New(oReport,"Analise de Cobradas de Coparticipação - Visão Custo - Competencia :  "+cMesComp+"/"+cAnoComp,,aOrdem)             
     
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

oReport	:= TReport():New("CABR086","Analise de Cobradas de Convenios - Visão Custo - Competencia : "+cMesComp+"/"+cAnoComp,, {|oReport| ReportPrt3(oReport)},"Este relatorio lista a cobranca de contas medicas dos convenios")
oReport:SetTotalInLine(.F.)//Imprime na linha: .F. - Imprime abaixo da linha com o titulo de cada coluna: .T.
oReport:SetTotalText('Total Geral') 

*'-----------------------------------------------------------------------------------'*
*'Solucao para impressao em que as colunas se truncam: "SetColSpace" e "SetLandScape"'* 
*'-----------------------------------------------------------------------------------'*

oReport:SetColSpace(1) //Espacamento entre colunas. 
oReport:SetLandscape() //Impressao em paisagem.  
//oReport:SetPortrait() //Impressao em retrato.  

*'-----------------------------------------------------------------------------------'*
                                                                
oDPJ := TRSection():New(oReport,"Analise de Cobradas de Convenios - Visão Custo - Competencia :  "+cMesComp+"/"+cAnoComp,,aOrdem)    
          

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

oReport	:= TReport():New("CABR086","Resumo de Cobradas de Coparticipação  " ,, {|oReport| ReportPtR1(oReport)},"Este relatorio lista a cobranca de coparticipação")
oReport:SetTotalInLine(.F.)//Imprime na linha: .F. - Imprime abaixo da linha com o titulo de cada coluna: .T.
oReport:SetTotalText('Total Geral') 

*'-----------------------------------------------------------------------------------'*
*'Solucao para impressao em que as colunas se truncam: "SetColSpace" e "SetLandScape"'* 
*'-----------------------------------------------------------------------------------'*

oReport:SetColSpace(1) //Espacamento entre colunas. 
oReport:SetLandscape() //Impressao em paisagem.  
//oReport:SetPortrait() //Impressao em retrato.  

*'-----------------------------------------------------------------------------------'*
                                                                
oDPJ := TRSection():New(oReport,"Resumo de Cobradas de Coparticipação  " ,,aOrdem)            
     
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
TRCell():New(oDPJ ,'TPCOB'	            ,/*TABELA*/	,'Tpo Cobranca Cob'   ,/*Picture*/ 	    ,17				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		) 
TRCell():New(oDPJ ,'TPCOBCAD'	        ,/*TABELA*/	,'Tpo Cobranca Cad'   ,/*Picture*/ 	    ,17				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
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
    oDPJ:Cell('TPCOBCAD'	 	):SetValue(AllTrim(aDados4[i][13]))  
    oDPJ:Cell('CONSOL'	 		):SetValue(AllTrim(aDados4[i][14]))     

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

oReport	:= TReport():New("CABR086","Cobranca de coparticipação - Visão Custo - Competencia : "+cMesComp+"/"+cAnoComp,, {|oReport| ReportPrt1(oReport)},"Este relatorio lista a cobranca de coparticipação  ")
oReport:SetTotalInLine(.F.)//Imprime na linha: .F. - Imprime abaixo da linha com o titulo de cada coluna: .T.
oReport:SetTotalText('Total Geral') 

*'-----------------------------------------------------------------------------------'*
*'Solucao para impressao em que as colunas se truncam: "SetColSpace" e "SetLandScape"'* 
*'-----------------------------------------------------------------------------------'*

oReport:SetColSpace(1) //Espacamento entre colunas. 
oReport:SetLandscape() //Impressao em paisagem.  
//oReport:SetPortrait() //Impressao em retrato.  

*'-----------------------------------------------------------------------------------'*
                                                                
oDPJ := TRSection():New(oReport,"Cobranca de coparticipação - Visão Custo - Competencia :  "+cMesComp+"/"+cAnoComp,,aOrdem)              

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

PutSx1(cPerg,"01",OemToAnsi("Mes Competencia Custo") 		,"","","mv_ch01","C",02,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","",aHelpPor,{},{})
PutSx1(cPerg,"02",OemToAnsi("Ano Competencia Custo") 		,"","","mv_ch02","C",04,0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","",aHelpPor,{},{})    
PutSx1(cPerg,"03",OemToAnsi("Empresa inicial") 	        	,"","","mv_ch03","C",04,0,0,"G","","","","","mv_par03","","","","","","","","","","","","","","","","",aHelpPor,{},{})
PutSx1(cPerg,"04",OemToAnsi("Empresa Final  ") 				,"","","mv_ch04","C",04,0,0,"G","","","","","mv_par04","","","","","","","","","","","","","","","","",aHelpPor,{},{})

PutSx1(cPerg,"05",OemToAnsi("Gerar Excel ") 	         	,"","","mv_ch05","N",01,0,0,"C","","","","","mv_par05","Sim","","","","Não","","","","","","","","","","","",{},{},{}) 
PutSx1(cPerg,"06",OemToAnsi("Sintetico   ")             	,"","","mv_ch06","N",01,0,0,"C","","","","","mv_par06","Sim","","","","Não","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"07",OemToAnsi("Analitico ")        	        ,"","","mv_ch07","N",01,0,0,"C","","","","","mv_par07","Sim ","","","","Não","","","","","","","","","","","",{},{},{})

PutSx1(cPerg,"08",OemToAnsi("Chave de Nivel ?")            ,"","","mv_ch08","N",01,0,0,"C","","","","","mv_par08","Com Chave","","","","Sem Chave.","","","Todos","","","","","","","","",{},{},{}) 

PutSx1(cPerg,"09",OemToAnsi("Listar Coopartic.")            ,"","","mv_ch09","N",01,0,0,"C","","","","","mv_par09","Com Copartic.","","","","Sem Copartic.","","","Todos","","","","","","","","",{},{},{}) 
PutSx1(cPerg,"10",OemToAnsi("Projeto     ")                 ,"","","mv_ch10","C",01,0,0,"C","","","","","mv_par10","Com Projeto","","","","Sem Projeto","","","Todos","","","","","","","","",{},{},{})    
PutSx1(cPerg,"11",OemToAnsi("Divergentes ")         	    ,"","","mv_ch11","N",01,0,0,"C","","","","","mv_par11","Sim        ","","","","Não        ","","","Todos","","","","","","","","",{},{},{}) 
PutSx1(cPerg,"12",OemToAnsi("Coparticipação ")             ,"","","mv_ch12","N",01,0,0,"C","","","","","mv_par12","Bloqueada  ","","","","Não Bloqueada","","","Todos","","","","","","","","",{},{},{}) 
PutSx1(cPerg,"13",OemToAnsi("Dif. limite ")                 ,"","","mv_ch13","C",01,0,0,"G","","","","","mv_par13","","","","","","","","","","","","","","","","",{},{},{})
                                          
PutSx1(cPerg,"14",OemToAnsi("Procedimento Inicial")       	,"","","mv_ch14","C",08,0,0,"G","","","","","mv_par14","","","","","","","","","","","","","","","","",aHelpPor,{},{})
PutSx1(cPerg,"15",OemToAnsi("Procedimento Final  ")     	,"","","mv_ch15","C",08,0,0,"G","","","","","mv_par15","","","","","","","","","","","","","","","","",aHelpPor,{},{})

PutSx1(cPerg,"16",OemToAnsi("Listar    ")                   ,"","","mv_ch16","N",01,0,0,"C","","","","","mv_par16","Guias ","","","","Guias/Opme ","","","","","","","","","","","",{},{},{}) 

PutSx1(cPerg,"17",OemToAnsi("Listar Codigo Procedimento?")  ,"","","mv_ch17","N",01,0,0,"C","","","","","mv_par17","Sim        ","","","","Não        ","","","","","","","","","","","",{},{},{}) 

PutSx1(cPerg,"18",OemToAnsi("Conferir Custo Qtda Meses")    ,"","","mv_ch018","N",08,0,0,"G","","","","","mv_par18","","","","","","","","","","","","","","","","",aHelpPor,{},{})

PutSx1(cPerg,"19",OemToAnsi("Coparticipação ")             ,"","","mv_ch19","N",01,0,0,"C","","","","","mv_par19","Cobrada  ","","","","Não Cobrada  ","","","Todos","","","","","","","","",{},{},{}) 

PutSx1(cPerg,"20",OemToAnsi("Listar Tipo Cobrança Cobrado?") ,"","","mv_ch20","N",01,0,0,"C","","","","","mv_par20","Sim        ","","","","Não        ","","","","","","","","","","","",{},{},{})  

PutSx1(cPerg,"21",OemToAnsi("Listar Tipo Cobrança Cadast?"),"","","mv_ch21","N",01,0,0,"C","","","","","mv_par21","Sim        ","","","","Não        ","","","","","","","","","","","",{},{},{}) 

PutSx1(cPerg,"22",OemToAnsi("Listar   ")                   ,"","","mv_ch22","N",01,0,0,"C","","","","","mv_par22","Resumos ","","","","Analit/Sint  ","","","Todos","","","","","","","","",{},{},{}) 

Pergunte(cPerg,.F.)

Return

