#INCLUDE "PROTHEUS.CH"
#Include "TOPCONN.CH"    

                                                                                                                           
/*/                                                                                                            
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABR137   º Autor ³Altamiro              º Data ³ 01/10/12  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Rotina para Gerar planilha do custo para Gepla             º±±
±±º          ³                                                            º±±
±±º          ³ em 22/10/20 coluna grp cobertura Motta                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/                  

User Function CABA137

Local cMsg			:= ""
Private cDpj        := 'Não'   
private cImp        := 'Não'
Private oLeTxt
Private lAbortPrint :=.F.
Private cPerg       := "CABA137"
Private cTitulo     := "Extração Custo caberj / Integral	"
Private lpvez       :=.T.   
Private cTpCrit     :=" "  
Private lImporta    := .F.  
Private f_ok        := .F.
Private nLocaliz    := 0 // 1 - zzq -- 2 se2  -- 0 nao localizado         
private cqueryi     := ' ' 
private cpgto       := ' '     
private cpgtoI      := ' '    
private cpgtoF      := ' '    

private cTitCSald   := ' '   
PRIVATE nVlrTitPri  := 0.00
PRIVATE nVlrTitcmp  := 0.00   
private cNomeArq1   := ' '   

Private aDadosInt   := {}
Private cEmpresa    := Iif(cEmpAnt == '01','C','I') 

private cAliasCst   := GetNextAlias() 

PRIVATE I := 1
PRIVATE X := 1
AjustaSX1(cPerg)                                                                     

//If Pergunte(cPerg,.T.) = .F.

//	Return

//Endif 
                                                                             
cpgto  := mv_par01                 
cpgtoI := mv_par01    
cpgtoF := mv_par01     
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

 //AltaV12PRD-janela
 
Processa({||Processa1()}, cTitulo, "", .T.)

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
////  Intregral 
 cqueryi := CRLF+"SELECT "
 If cEmpresa== 'I'
    cqueryi += CRLF+" 'Integral' Emp, "
 Else          
    cqueryi += CRLF+" 'Caberj' Emp, "            
 endIF 
 cqueryi += CRLF+" refer, "  
                   
 cqueryi += CRLF+" matricula ," 
 cqueryi += CRLF+" nomusr ,"

 cqueryi += CRLF+" CODEMP,"  
 cqueryi += CRLF+" GRUPO_PLANO,"        
 cqueryi += CRLF+" NOME_PLANO,"  
 cqueryi += CRLF+" substr(DtEvent,7,2)||'/'|| substr(DtEvent,5,2)||'/'|| substr(DtEvent,1,4)  DtEvent, "
 cqueryi += CRLF+" GRP_COBERT, "//Motta 22/10/20   
 cqueryi += CRLF+" CodEvento, "           
 cqueryi += CRLF+" Nome_Evento, "           
 cqueryi += CRLF+" ZZT_TPCUST,  "            
 cqueryi += CRLF+" codrda , "
 cqueryi += CRLF+" nomrda , " 
 cqueryi += CRLF+" GRPPAG , " 
 cqueryi += CRLF+" DESCGRP, " 
 cqueryi += CRLF+" tippre , "      
 cqueryi += CRLF+" TIPO , anomespag , "
  cqueryi += CRLF+" substr(dtdigi,7,2)||'/'|| substr(dtdigi,5,2)||'/'|| substr(dtdigi,1,4) dtdigi , "    
 cqueryi += CRLF+" SUM(VL_APROV+GLOSADO) APRESENTADO , "            
 cqueryi += CRLF+" SUM(GLOSADO) GLOSADO , "           
 cqueryi += CRLF+" SUM(VL_APROV) PAGO , "         
 cqueryi += CRLF+" SUM(Vl_Participacao) COPART , " 
 cqueryi += CRLF+" NVL(RETORNA_QTD_FAIXA(SUBSTR(matricula,1,4),SUBSTR(matricula,5,4),SUBSTR(matricula,9,6),SUBSTR(matricula,15,2),substr(DTEVENT,1,4)),0) QTD_FAIXAS , TIPOloc , datnasusr "         
 cqueryi += CRLF+" FROM( "                      
 
 cqueryi += CRLF+" SELECT /*+first_rows index_asc(BD7 BD70205)*/ "  
 cqueryi += CRLF+" bd6_codope || bd6_codemp || bd6_matric || bd6_tipreg || bd6_digito  matricula , " 
 cqueryi += CRLF+" bd6_nomusr nomusr , "
 cqueryi += CRLF+" BD7_CODPLA PLANO,   "
 cqueryi += CRLF+" NVL(TRIM(SIGA.RETORNA_DESCRI_GRUPO_COBERT('"+cEmpresa+"', SIGA.RETORNA_GRUPO_COBERT('"+cEmpresa+"', BD6_CODPAD,BD6_CODPRO,'G'))), 'SEM GRUPO') GRP_COBERT,"//Motta 22/10/20   
 cqueryi += CRLF+" BD6_YNEVEN CodEvento, "
 cqueryi += CRLF+" ZZT_EVENTO Nome_Evento, "
 cqueryi += CRLF+" QTDE , "
 cqueryi += CRLF+" Sum(BD6F.BD6_QTDPRO) Ocorrencia , "    
 cqueryi += CRLF+" Sum(BD6F.BD6_VLRGLO) Glosado , " 
 cqueryi += CRLF+" Sum(BD7F.VLRPAG)  Vl_Aprov , " 
 cqueryi += CRLF+" sum(Decode(BD6F.BD6_BLOCPA,'1',0,Decode(Sign(BD6F.BD6_VLRTPF),-1,0,Decode(BD6_CODEMP,'0004',0,'0009',0,BD6F.BD6_VLRTPF)))) Vl_Participacao , "           
 cqueryi += CRLF+" EXPOS EXPOSICAO_ANS , "          
 cqueryi += CRLF+" RETORNA_DESC_GRUPO_PLANO ( TRIM(BI3_YGRPLA),'"+cEmpresa+"') GRUPO_PLANO, "           
 cqueryi += CRLF+" Decode(BD6_CODEMP,'0007',Trim(BI3_NREDUZ)||' (SEPE)',BI3_NREDUZ) NOME_PLANO, "          
 cqueryi += CRLF+" ZZT_TPCUST , "          
 cqueryi += CRLF+" BD6_YPROJ PROJ, "    
 cqueryi += CRLF+" decode(BD6_CODLDP,'0010','Recup Glosa','0019','Recup Glosa','0017','Rateio','Conta') TIPO, "       
 cqueryi += CRLF+" BD6_CODEMP CODEMP, "           
 cqueryi += CRLF+" RETORNA_DESCRI_GRUPOEMP('"+cEmpresa+"',BD6_CODEMP) NOME_EMP, "            
 cqueryi += CRLF+" BD6_DATPRO  DTEVENT ,"                       
 cqueryi += CRLF+" bd7f.refer refer ,bd7f.codrda , bd7f.nomrda , "          
 cqueryi += CRLF+" bd7f.GRPPAG GRPPAG , bd7f.DESCGRP DESCGRP , bd7f.tippre tippre , bd6_anopag || bd6_mespag anomespag , bd6_dtdigi dtdigi ,"       
 cqueryi += CRLF+" bcg_codldp ||'-'||bcg_descri  TIPOloc, substr(ba1_datnas,7,2)||'/'||substr(ba1_datnas,5,2)||'/'|| substr(ba1_datnas,1,4) datnasusr "          
 cqueryi += CRLF+" FROM "           
 cqueryi += CRLF+" (SELECT BD7.BD7_FILIAL,BD7_CODPLA,SIGA_TIPO_EXPOSICAO_ANS(BD7_CODEMP,BD7_MATRIC,BD7_TIPREG,To_Date(Trim(BD7_DATPRO),'YYYYMMDD')) EXPOS,"           
 cqueryi += CRLF+"  BD7.BD7_OPELOT,"           
 cqueryi += CRLF+"  BD7.BD7_CODOPE, BD7.BD7_CODLDP, BD7.BD7_CODPEG, BD7.BD7_NUMERO, BD7.BD7_ORIMOV, BD7_CODPRO,"           
 cqueryi += CRLF+"  BD7.BD7_SEQUEN,  Sum(BD7.BD7_VLRPAG) AS VLRPAG,"           
 cqueryi += CRLF+"  COUNT(DISTINCT BD7_CODEMP||BD7_MATRIC||BD7_TIPREG) QTDE ,"            
 cqueryi += CRLF+"  substr(BD7.BD7_NUMLOT,1,6) refer ,"            
 cqueryi += CRLF+"  bd7.bd7_codrda CODRDA , bd7.bd7_nomrda NOMRDA ,"           
 cqueryi += CRLF+"  BAU_GRPPAG GRPPAG , B16_DESCRI  DESCGRP , bau_tippre tippre"         
 cqueryi += CRLF+"  FROM "+RetSqlName("BD7") +" BD7 ,"+ RetSqlName("BAU") + " BAU , "+ RetSqlName("B16")+"  B16 "          
 cqueryi += CRLF+"  WHERE BD7.BD7_FILIAL='" + xFilial("BD7") +"' "           
 cqueryi += CRLF+"  AND BD7_OPELOT = '0001' "          
 cqueryi += CRLF+"  AND BD7.BD7_NUMLOT >= '"+cpgtoI+"0001' AND BD7.BD7_NUMLOT <= '"+cpgtoF+"9999' "       
 cqueryi += CRLF+"  AND BD7_SITUAC = '1' "         
 cqueryi += CRLF+"  AND BD7_OPEUSR >='0001'"          
 cqueryi += CRLF+"  AND BD7_CODEMP >= '0001'"          
 cqueryi += CRLF+"  AND BD7_MATRIC >= '000001'"          
 cqueryi += CRLF+"  AND BD7_TIPREG >= '00'"          
 cqueryi += CRLF+"  AND BAU_FILIAL ='" + xFilial("BAU") +"' AND BAU.D_e_l_e_t_ = ' ' and bau.R_E_C_D_E_L_ = 0 "          
 cqueryi += CRLF+"  AND B16_FILIAL ='" + xFilial("B16") +"' AND B16.D_E_L_E_T_ = ' '"           
 cqueryi += CRLF+"  AND BD7.BD7_CODOPE = '0001'"           
 cqueryi += CRLF+"  AND BD7.BD7_FASE = '4' "         
 cqueryi += CRLF+"  AND BD7.BD7_BLOPAG <> '1' "           
 cqueryi += CRLF+"  AND BAU_CODIGO = BD7.BD7_CODRDA"           
 cqueryi += CRLF+"  AND bau_grppag = B16_CODIGO"           
 cqueryi += CRLF+"  AND BD7.D_E_L_E_T_ = ' '"           
 cqueryi += CRLF+"  GROUP BY BD7_FILIAL, BD7_CODPLA, BD7.BD7_OPELOT,BD7_CODPRO,"           
 cqueryi += CRLF+"  SIGA_TIPO_EXPOSICAO_ANS(BD7_CODEMP,BD7_MATRIC,BD7_TIPREG,To_Date(Trim(BD7_DATPRO),'YYYYMMDD')),"           
 cqueryi += CRLF+"  BD7_FILIAL, BD7_CODOPE, BD7_CODLDP, BD7_CODPEG, BD7_NUMERO, BD7_ORIMOV, BD7_SEQUEN ,"          
 cqueryi += CRLF+"  bd7.bd7_codrda, bd7.bd7_nomrda ,BAU_GRPPAG, B16_DESCRI, bau_tippre ,"            
 cqueryi += CRLF+"  substr(BD7.BD7_NUMLOT,1,6)) BD7F,"           
 cqueryi += CRLF+"  "+RetSqlName("BD6")+" BD6F ,"+ RetSqlName("BI3")+" BI3 , "+RetSqlName("ZZT")+" ZZT, "+RetSqlName("BCG")+" BCG, "+RetSqlName("BA1")+" BA1"        
 cqueryi += CRLF+"  WHERE ZZT_FILIAL=' '"           
 cqueryi += CRLF+"  and BI3_FILIAL=' '"  
 cqueryi += CRLF+"  and BA1_FILIAL=' '"             
 cqueryi += CRLF+"  and BCG_FILIAL=' '"           
 cqueryi += CRLF+"  AND BD6F.BD6_FILIAL=' '"           
 cqueryi += CRLF+"  AND BD7F.BD7_FILIAL = BD6F.BD6_FILIAL"           
 cqueryi += CRLF+"  AND BD7F.BD7_CODOPE = BD6F.BD6_CODOPE"           
 cqueryi += CRLF+"  AND BD7F.BD7_CODLDP = BD6F.BD6_CODLDP"           
 cqueryi += CRLF+"  AND BD7F.BD7_CODPEG = BD6F.BD6_CODPEG"           
 cqueryi += CRLF+"  AND BD7F.BD7_NUMERO = BD6F.BD6_NUMERO"           
 cqueryi += CRLF+"  AND BD7F.BD7_ORIMOV = BD6F.BD6_ORIMOV"           
 cqueryi += CRLF+"  and BD7F.BD7_SEQUEN = BD6F.BD6_SEQUEN"           
 cqueryi += CRLF+"  AND BD6F.BD6_CODPRO = BD7F.BD7_CODPRO"           
 cqueryi += CRLF+"  AND BI3_FILIAL =BD7_FILIAL"           
 cqueryi += CRLF+"  AND BI3_CODINT=BD7_CODOPE"           
 cqueryi += CRLF+"  AND BI3_CODIGO=BD7_CODPLA"          
 cqueryi += CRLF+"  AND BD6_YNEVEN=ZZT_CODEV"           
 cqueryi += CRLF+"  AND BCG_CODLDP = BD6F.BD6_CODLDP" 
 cqueryi += CRLF+" and ba1_codint = bd6_codope "
 cqueryi += CRLF+" and ba1_codemp = bd6_codemp "
 cqueryi += CRLF+" and ba1_matric = bd6_matric "
 cqueryi += CRLF+" and ba1_tipreg = bd6_tipreg "
 cqueryi += CRLF+" and ba1_digito = bd6_digito "           
 cqueryi += CRLF+" AND BI3.D_E_L_E_T_ = ' '"   
 cqueryi += CRLF+" AND BA1.D_E_L_E_T_ = ' '"  
 cqueryi += CRLF+" AND ZZT.D_E_L_E_T_ = ' '"   
 cqueryi += CRLF+" AND BCG.D_E_L_E_T_ = ' '"   
 cqueryi += CRLF+" AND BD6F.D_E_L_E_T_ = ' '"   
 cqueryi += CRLF+" GROUP  BY"
 cqueryi += CRLF+" bd6_codope || bd6_codemp || bd6_matric || bd6_tipreg || bd6_digito ," 
 cqueryi += CRLF+" bd6_nomusr , BD7_CODPLA ,   "//Motta 22/10/20
 cqueryi += CRLF+" NVL(TRIM(SIGA.RETORNA_DESCRI_GRUPO_COBERT('"+cEmpresa+"', SIGA.RETORNA_GRUPO_COBERT('"+cEmpresa+"', BD6_CODPAD,BD6_CODPRO,'G'))), 'SEM GRUPO') ,"//Motta 22/10/20   
 cqueryi += CRLF+" BD6_YNEVEN , ZZT_EVENTO , QTDE , "//Motta 22/10/20 
 cqueryi += CRLF+" EXPOS , RETORNA_DESC_GRUPO_PLANO ( TRIM(BI3_YGRPLA),'"+cEmpresa+"') , "
 cqueryi += CRLF+" Decode(BD6_CODEMP,'0007',Trim(BI3_NREDUZ)||' (SEPE)',BI3_NREDUZ) , "
 cqueryi += CRLF+" ZZT_TPCUST , BD6_YPROJ , "
 cqueryi += CRLF+" decode(BD6_CODLDP,'0010','Recup Glosa','0019','Recup Glosa','0017','Rateio','Conta') , "
 cqueryi += CRLF+" BD6_CODEMP , RETORNA_DESCRI_GRUPOEMP('"+cEmpresa+"',BD6_CODEMP) , "
 cqueryi += CRLF+" BD6_DATPRO , bd7f.refer ,bd7f.codrda , bd7f.nomrda , "
 cqueryi += CRLF+" bd7f.GRPPAG  , bd7f.DESCGRP  , bd7f.tippre  , bd6_anopag || bd6_mespag  , bd6_dtdigi ,bcg_codldp ||'-'||bcg_descri ,"
 cqueryi += CRLF+" substr(ba1_datnas,7,2)||'/'||substr(ba1_datnas,5,2)||'/'|| substr(ba1_datnas,1,4)" 

 cqueryi += CRLF+"  UNION ALL"           

/// CONTINUA 
 cqueryi += CRLF+"  SELECT     ' '  matricula , " 
 cqueryi += CRLF+"             ' ' nomusr , "
 cqueryi += CRLF+" NVL( RETORNA_PLANO_USU_MS ('"+cEmpresa+"',BGQ_CODOPE,BGQ_CODEMP,BGQ_MATRIC,'00','N'),BBB_YCODPL) PLANO,"           
 cqueryi += CRLF+" 'SEM GRUPO' GRP_COBERT ,"//Motta 22/10/20 
 cqueryi += CRLF+" BGQ_YNEVEN CodEvento,"           
 cqueryi += CRLF+" ZZT_EVENTO Nome_Evento,"           
 cqueryi += CRLF+" Count(DISTINCT BGQ_CODSEQ)QTDE,"           
 cqueryi += CRLF+" Count(BGQ_CODSEQ) Ocorrencia,"           
 cqueryi += CRLF+" 0 Glosado,"           
 cqueryi += CRLF+" Sum(Decode(BBB_TIPSER,1,-1*BGQ_VALOR,BGQ_VALOR)) Vl_Aprov,"           
 cqueryi += CRLF+" 0 Vl_Participacao,"           
 cqueryi += CRLF+" decode(nvl(trim(BGQ_CODEMP),RETORNA_GRUPO_EMP(BI3_CODIGO)),'0004',2,'0009',2,0) EXPOSICAO_ANS,"            
 cqueryi += CRLF+" RETORNA_DESC_GRUPO_PLANO ( TRIM(BI3_YGRPLA),'"+cEmpresa+"') GRUPO_PLANO,"           
 cqueryi += CRLF+" BI3_NREDUZ NOME_PLANO,"           
 cqueryi += CRLF+" ZZT_TPCUST ,"           
 cqueryi += CRLF+" BGQ_YPROJ PROJ ,"           
 cqueryi += CRLF+" 'Lancamentos Deb/Cred' Tipo ,"           
 cqueryi += CRLF+" BGQ_CODEMP CODEMP,"           
 cqueryi += CRLF+" RETORNA_DESCRI_GRUPOEMP('"+cEmpresa+"',BGQ_CODEMP) ,"           
 cqueryi += CRLF+" BGQ_ANO||BGQ_MES||'01'  DTEVENT ,"               
 cqueryi += CRLF+" substr(BGQ_NUMLOT,1,6) refer ,"          
 cqueryi += CRLF+" bgq_codigo CODRDA , bgq_nome NOMRDA ,"           
 cqueryi += CRLF+" BAU_GRPPAG GRPPAG , B16_DESCRI  DESCGRP , bau_tippre tippre , BGQ_ANO||BGQ_MES ANOMESPAG , '19000101' dtdigi , "          
 cqueryi += CRLF+" 'Lancamentos Deb/Cred' Tipoloc ,  '  /  /   ' datnasusr"           
 cqueryi += CRLF+" FROM "+RetSqlName("BGQ") +" BGQ ,"+ RetSqlName("BBB") +" BBB ,"+  RetSqlName("BI3") + " BI3 , "+ RetSqlName("ZZT") +" ZZT , " +RetSqlName("BAU")+" BAU ,"+ RetSqlName("B16")+" B16"          
 cqueryi += CRLF+" WHERE BGQ_FILIAL = '" + xFilial("BGQ") +"'"           
 cqueryi += CRLF+"   AND BGQ_CODLAN <> '050'"           
 cqueryi += CRLF+"   AND BBB_FILIAL = '" + xFilial("BBB") +"' "           
 cqueryi += CRLF+"   AND BBB_CODSER = BGQ_CODLAN"           
 cqueryi += CRLF+"   AND ZZT_FILIAL = '" + xFilial("ZZT") +"'"           
 cqueryi += CRLF+"   AND BGQ_YNEVEN=ZZT_CODEV"           
 cqueryi += CRLF+"   AND BI3_FILIAL = '" + xFilial("BI3") +"'"           
 cqueryi += CRLF+"   AND BI3_CODIGO=NVL( RETORNA_PLANO_USU_MS ('"+cEmpresa+"',BGQ_CODOPE,BGQ_CODEMP,BGQ_MATRIC,'00','N'),BBB_YCODPL)"           
 cqueryi += CRLF+"   AND BGQ_NUMLOT >= '"+cpgtoI+"0001' AND BGQ_NUMLOT <= '"+cpgtoF+"9999'"           
 cqueryi += CRLF+"   AND BAU_FILIAL =' ' AND BAU.D_e_l_e_t_ = ' ' and bau.R_E_C_D_E_L_ = 0"           
 cqueryi += CRLF+"   AND B16_FILIAL =' ' AND B16.D_E_L_E_T_ = ' '"           
 cqueryi += CRLF+"   AND BAU_CODIGO = bgq_codigo"          
 cqueryi += CRLF+"   AND bau_grppag = B16_CODIGO"           
 cqueryi += CRLF+"   AND BI3.D_E_L_E_T_ = ' '"           
 cqueryi += CRLF+"   AND ZZT.D_E_L_E_T_ = ' '"           
 cqueryi += CRLF+"   AND BGQ.D_E_L_E_T_ = ' '"           
 cqueryi += CRLF+"   AND BBB.D_E_L_E_T_ = ' '"           
 cqueryi += CRLF+" GROUP BY NVL( RETORNA_PLANO_USU_MS ('"+cEmpresa+"',BGQ_CODOPE,BGQ_CODEMP,BGQ_MATRIC,'00','N'),BBB_YCODPL)  ,"            
 cqueryi += CRLF+"       'SEM GRUPO' ,"//Motta 22/10/20 
 cqueryi += CRLF+"       BGQ_YNEVEN ,  ZZT_EVENTO, ZZT_TPCUST,"           
 cqueryi += CRLF+"       decode(nvl(trim(BGQ_CODEMP),RETORNA_GRUPO_EMP(BI3_CODIGO)),'0004',2,'0009',2,0),"           
 cqueryi += CRLF+"       RETORNA_DESC_GRUPO_PLANO ( TRIM(BI3_YGRPLA),'"+cEmpresa+"'),BI3_NREDUZ ,"           
 cqueryi += CRLF+"       BGQ_YPROJ ,BGQ_CODEMP , RETORNA_DESCRI_GRUPOEMP('"+cEmpresa+"',BGQ_CODEMP) ,"            
 cqueryi += CRLF+"       BGQ_ANO||BGQ_MES||'01' ,"             
 cqueryi += CRLF+"       substr(BGQ_NUMLOT,1,6)  ,"          
 cqueryi += CRLF+"       bgq_codigo  , bgq_nome  ,"           
 cqueryi += CRLF+"       BAU_GRPPAG  , B16_DESCRI , bau_tippre, BGQ_ANO||BGQ_MES "           

 cqueryi += CRLF+"UNION ALL"           

 cqueryi += CRLF+" SELECT "
 cqueryi += CRLF+" matricula , " 
 cqueryi += CRLF+" nomusr , "
 cqueryi += CRLF+" PLANO , "    
 cqueryi += CRLF+" GRP_COBERT , "//Motta 22/10/20   
 cqueryi += CRLF+" CODEVENTO,"           
 cqueryi += CRLF+" NOME_EVENTO,"           
 cqueryi += CRLF+" SUM(QTDE),"           
 cqueryi += CRLF+" SUM(OCORRENCIA),"           
 cqueryi += CRLF+" SUM(GLOSADO),"           
 cqueryi += CRLF+" SUM(VL_APROV) VL_APROV,"           
 cqueryi += CRLF+" SUM(VL_PARTICIPACAO) VL_PARTICIPACAO,"           
 cqueryi += CRLF+" EXPOSICAO_ANS ,"           
 cqueryi += CRLF+" GRUPO_PLANO,"           
 cqueryi += CRLF+" NOME_PLANO,"           
 cqueryi += CRLF+" ZZT_TPCUST,"           
 cqueryi += CRLF+" PROJ,"           
 cqueryi += CRLF+" 'Material' Tipo, "              
 cqueryi += CRLF+" CODEMP,"           
 cqueryi += CRLF+" RETORNA_DESCRI_GRUPOEMP ('"+cEmpresa+"',CODEMP) NOME_EMP ,"             
 cqueryi += CRLF+" DTEVENT ,"            
 cqueryi += CRLF+" refer ,"           
 cqueryi += CRLF+" '000000' CODRDA , 'Material' NOMRDA ,"           
 cqueryi += CRLF+" '0000' GRPPAG , 'Material'  DESCGRP ,"       
 cqueryi += CRLF+" 'Material' tippre , ANOMESPAG , dtdigi,"
 cqueryi += CRLF+" 'Material' Tipoloc , datnasusr "             
 cqueryi += CRLF+"FROM("           
 cqueryi += CRLF+" SELECT "
 cqueryi += CRLF+" bd6_codope || bd6_codemp || bd6_matric || bd6_tipreg || bd6_digito  matricula , " 
 cqueryi += CRLF+" bd6_nomusr nomusr , "
 cqueryi += CRLF+" BD6_CODPLA PLANO , "         
 cqueryi += CRLF+" NVL(TRIM(SIGA.RETORNA_DESCRI_GRUPO_COBERT('"+cEmpresa+"', SIGA.RETORNA_GRUPO_COBERT('"+cEmpresa+"', BD6_CODPAD,BD6_CODPRO,'G'))), 'SEM GRUPO') GRP_COBERT,"//Motta 22/10/20   
 cqueryi += CRLF+" BD6_YNEVEN CodEvento,"           
 cqueryi += CRLF+" ZZT_EVENTO Nome_Evento,"           
 cqueryi += CRLF+" COUNT(DISTINCT BD6_CODEMP||BD6_MATRIC||BD6_TIPREG) QTDE,"           
 cqueryi += CRLF+" Sum(D1_QUANT) Ocorrencia,"           
 cqueryi += CRLF+" Sum(BD6_VLRGLO) Glosado,"           
 cqueryi += CRLF+" Sum(D1_TOTAL)-Sum(D1_VALDESC) Vl_Aprov,"           
 cqueryi += CRLF+" RETORNA_VL_COPART_OPME (BD6_CODOPE,BD6_CODLDP,BD6_CODPEG,BD6_NUMERO,'"+cEmpresa+"') Vl_Participacao,"           
 cqueryi += CRLF+" SIGA_TIPO_EXPOSICAO_ANS(BD6_CODEMP,BD6_MATRIC,BD6_TIPREG,To_Date(Trim(BD6_DATPRO),'YYYYMMDD')) EXPOSICAO_ANS ,"           
 cqueryi += CRLF+" RETORNA_DESC_GRUPO_PLANO ( TRIM(BI3_YGRPLA),'"+cEmpresa+"') GRUPO_PLANO,"           
 cqueryi += CRLF+" Decode(BD6_CODEMP,'0007',Trim(BI3_NREDUZ)||' (SEPE)',BI3_NREDUZ) NOME_PLANO,"           
 cqueryi += CRLF+" 0 Val_adiant , B19_DOC,"           
 cqueryi += CRLF+" ZZT_TPCUST ,"           
 cqueryi += CRLF+" BD6_YPROJ PROJ,"                                   
 cqueryi += CRLF+" BD6_CODEMP CODEMP,"            
 cqueryi += CRLF+" BD6_DATPRO DTEVENT ,  "               
 cqueryi += CRLF+" substr(F1_EMISSAO,1,6) refer , bd6_anopag || bd6_mespag anomespag , bd6_dtdigi dtdigi , "
 cqueryi += CRLF+" substr(ba1_datnas,7,2)||'/'||substr(ba1_datnas,5,2)||'/'|| substr(ba1_datnas,1,4) datnasusr "
 cqueryi += CRLF+" from "+ RetSqlName("B19")+" B19,"+ RetSqlName("SD1")+" SD1 ,"+ RetSqlName("SF1") +" SF1, "+RetSqlName("BD6")+" BD6 ,"           
 cqueryi += CRLF+"      "+RetSqlName("SA2") +" SA2,"+ RetSqlName("ZZT")+" ZZT ,"+ RetSqlName("BI3") +" BI3 ,"+ RetSqlName("BA1") +" BA1"            
 cqueryi += CRLF+" WHERE BI3_FILIAL='" + xFilial("BI3") +"'"           
 cqueryi += CRLF+" AND  A2_FILIAL='" + xFilial("SA2") +"'"   
 cqueryi += CRLF+" AND  BA1_FILIAL='" + xFilial("BA1") +"'"                             
 cqueryi += CRLF+" AND F1_YDTCON >= '"+cpgtoI+"01' AND F1_YDTCON <= '"+cpgtoF+"31' "        
 cqueryi += CRLF+" AND A2_COD = B19_FORNEC"           
 cqueryi += CRLF+" AND D1_FORNECE= A2_COD"           
 cqueryi += CRLF+" AND f1_FORNECE= A2_COD"           
 cqueryi += CRLF+" AND D1_DOC = F1_DOC "          
 cqueryi += CRLF+" AND B19_DOC = D1_DOC"           
 cqueryi += CRLF+" AND D1_ITEM = B19_ITEM"           
 cqueryi += CRLF+" and BD6_FILIAL = '" + xFilial("BD6") +"'"           
 cqueryi += CRLF+" AND ZZT_FILIAL = '" + xFilial("ZZT") +"'"            
 cqueryi += CRLF+" AND BD6_CODPLA=BI3_CODIGO"           
 cqueryi += CRLF+" AND BD6_CODOPE = SubStr(B19_GUIA,01,04)"           
 cqueryi += CRLF+" AND BD6_CODLDP = SubStr(B19_GUIA,05,04)"           
 cqueryi += CRLF+" AND BD6_CODPEG = SubStr(B19_GUIA,09,08)"           
 cqueryi += CRLF+" AND BD6_NUMERO = SubStr(B19_GUIA,17,08)"           
 cqueryi += CRLF+" AND BD6_ORIMOV = SubStr(B19_GUIA,25,01)"           
 cqueryi += CRLF+" AND BD6_SEQUEN = SubStr(B19_GUIA,26,03)"    
 cqueryi += CRLF+" and ba1_codint = bd6_codope "
 cqueryi += CRLF+" and ba1_codemp = bd6_codemp "
 cqueryi += CRLF+" and ba1_matric = bd6_matric "
 cqueryi += CRLF+" and ba1_tipreg = bd6_tipreg "
 cqueryi += CRLF+" and ba1_digito = bd6_digito "         
 cqueryi += CRLF+" AND BD6_FASE IN (3,4)"           
 cqueryi += CRLF+" AND BD6_CODLDP='0013'"           
 cqueryi += CRLF+" AND BD6_SITUAC = 1"           
 cqueryi += CRLF+" AND BD6_YNEVEN=ZZT_CODEV"           
 cqueryi += CRLF+" AND SA2.D_E_L_E_T_ = ' '"           
 cqueryi += CRLF+" AND B19.D_E_L_E_T_ = ' '"           
 cqueryi += CRLF+" AND SD1.D_E_L_E_T_ = ' '"           
 cqueryi += CRLF+" AND SF1.D_E_L_E_T_ = ' '"           
 cqueryi += CRLF+" AND BD6.D_E_L_E_T_ = ' '"           
 cqueryi += CRLF+" AND ZZT.D_E_L_E_T_ = ' '"           
 cqueryi += CRLF+" AND BI3.D_E_L_E_T_ = ' '"           
 cqueryi += CRLF+" AND BA1.D_E_L_E_T_ = ' '"           
 cqueryi += CRLF+" GROUP BY SIGA_TIPO_EXPOSICAO_ANS(BD6_CODEMP,BD6_MATRIC,BD6_TIPREG,To_Date(Trim(BD6_DATPRO),'YYYYMMDD')),"           
 cqueryi += CRLF+" BD6_CODEMP,"           
 cqueryi += CRLF+" BD6_CODPLA,"  
 cqueryi += CRLF+" NVL(TRIM(SIGA.RETORNA_DESCRI_GRUPO_COBERT('"+cEmpresa+"', SIGA.RETORNA_GRUPO_COBERT('"+cEmpresa+"', BD6_CODPAD,BD6_CODPRO,'G'))), 'SEM GRUPO') ,"//Motta 22/10/20   
 cqueryi += CRLF+" TRIM(BI3_YGRPLA),Decode(BD6_CODEMP,'0007',Trim(BI3_NREDUZ)||' (SEPE)',BI3_NREDUZ),"           
 cqueryi += CRLF+" BD6_YNEVEN, B19_DOC,"           
 cqueryi += CRLF+" ZZT_EVENTO,ZZT_TPCUST, "           
 cqueryi += CRLF+" BD6_YPROJ,bd6_dtdigi , "           
 cqueryi += CRLF+" RETORNA_VL_COPART_OPME (BD6_CODOPE,BD6_CODLDP,BD6_CODPEG,BD6_NUMERO,'"+cEmpresa+"'),"                            
 cqueryi += CRLF+" BD6_CODEMP ,"            
 cqueryi += CRLF+" BD6_DATPRO ,"                     
 cqueryi += CRLF+" substr(F1_EMISSAO,1,6) ,"           
 cqueryi += CRLF+" bd6_codope||bd6_codemp||bd6_matric || bd6_tipreg || bd6_digito , " 
 cqueryi += CRLF+" bd6_nomusr, bd6_anopag || bd6_mespag , substr(ba1_datnas,7,2)||'/'||substr(ba1_datnas,5,2)||'/'|| substr(ba1_datnas,1,4)) "
 cqueryi += CRLF+" GROUP BY  PLANO, GRP_COBERT , NOME_EVENTO, matricula , nomusr , "//Motta 22/10/20
 cqueryi += CRLF+" CODEVENTO, "           
 cqueryi += CRLF+" GRUPO_PLANO, "           
 cqueryi += CRLF+" NOME_PLANO, "           
 cqueryi += CRLF+" EXPOSICAO_ANS,ZZT_TPCUST,PROJ, "           
 cqueryi += CRLF+" CODEMP, "           
 cqueryi += CRLF+" RETORNA_DESCRI_GRUPOEMP ('"+cEmpresa+"',CODEMP), "            
 cqueryi += CRLF+" DTEVENT, dtdigi ,"            
 cqueryi += CRLF+" refer , anomespag , datnasusr"    
        
 cqueryi += CRLF+"UNION ALL"           
 
 cqueryi += CRLF+" SELECT "
 cqueryi += CRLF+" bd6_codope || bd6_codemp || bd6_matric || bd6_tipreg || bd6_digito matricula , " 
 cqueryi += CRLF+" bd6_nomusr  nomusr ,"
 cqueryi += CRLF+" Nvl(Trim(BA1_CODPLA),BA3_CODPLA)  Plano,"     
 cqueryi += CRLF+" NVL(TRIM(SIGA.RETORNA_DESCRI_GRUPO_COBERT('"+cEmpresa+"', SIGA.RETORNA_GRUPO_COBERT('"+cEmpresa+"', BD6_CODPAD,BD6_CODPRO,'G'))), 'SEM GRUPO') GRP_COBERT,"//Motta 22/10/20   
 cqueryi += CRLF+" BD6_YNEVEN CodEvento,"           
 cqueryi += CRLF+" ZZT_EVENTO Nome_Evento,"           
 cqueryi += CRLF+" COUNT(DISTINCT B44_OPEUSR||B44_CODEMP||B44_MATRIC||B44_TIPREG) Qtde, "          
 cqueryi += CRLF+" Sum(B45_QTDPRO) Ocorrencia,"           
 cqueryi += CRLF+" Sum(B45_VLRGLO) Glosado,"           
 cqueryi += CRLF+" Sum(B45_VLRPAG) Val_Aprov,"           
 cqueryi += CRLF+" 0 Vl_Participacao,"           
 cqueryi += CRLF+" SIGA_TIPO_EXPOSICAO_ANS(B44_CODEMP,B44_MATRIC,B44_TIPREG,To_Date(Trim(B44_DATPRO),'YYYYMMDD')) EXPOSICAO_ANS,"           
 cqueryi += CRLF+" RETORNA_DESC_GRUPO_PLANO ( TRIM(BI3_YGRPLA),'"+cEmpresa+"') GRUPO_PLANO,"           
 cqueryi += CRLF+" Decode(B44_CODEMP,'0007',Trim(BI3_NREDUZ)||' (SEPE)',BI3_NREDUZ) NOME_PLANO,"           
 cqueryi += CRLF+" ZZT_TPCUST ,"           
 cqueryi += CRLF+" BD6_YPROJ PROJ,"           
 cqueryi += CRLF+" 'Reembolso' Tipo,"                              
 cqueryi += CRLF+" B44_CODEMP CODEMP,"           
 cqueryi += CRLF+" RETORNA_DESCRI_GRUPOEMP('"+cEmpresa+"',B44_CODEMP) NOME_EMP ,"           
 cqueryi += CRLF+" BD6_DATPRO DTEVENT ,"              
 cqueryi += CRLF+" substr(E1_EMISSAO,1,6) refer ,"          
 cqueryi += CRLF+" '000000' CODRDA , 'Reembolso' NOMRDA ,"           
 cqueryi += CRLF+" '0000' GRPPAG , 'Reembolso' DESCGRP  ,"      
 cqueryi += CRLF+" 'Rembolso' tippre , bd6_anopag || bd6_mespag anomespag ,bd6_dtdigi dtdigi, "
 cqueryi += CRLF+" 'Reembolso' Tipoloc , substr(ba1_datnas,7,2)||'/'||substr(ba1_datnas,5,2)||'/'|| substr(ba1_datnas,1,4) datnasusr "          
 cqueryi += CRLF+" from "+ RetSqlName("B44")+" C , "+ RetSqlName("B45")+" D , "+ RetSqlName("SE1") +" T , "+ RetSqlName("BA1") +" U , "+ RetSqlName("BA3") +" F ,"+ RetSqlName("BI3")+ " BI3 , " +RetSqlName("BG9") +"  BG9 , "           
 cqueryi += CRLF+" "+ RetSqlName("ZZT")+" ZZT,"+ RetSqlName("BD6")+" BD6 , "+RetSqlName("ZZQ") +" ZZQ "          
 cqueryi += CRLF+" WHERE B45_FILIAL='" + xFilial("B45") +"'"           
 cqueryi += CRLF+" AND B44_FILIAL='" + xFilial("B44") +"'"           
 cqueryi += CRLF+" AND BI3_FILIAL='" + xFilial("BI3") +"'"           
 cqueryi += CRLF+" AND BA3_FILIAL='" + xFilial("BA3") +"'"           
 cqueryi += CRLF+" AND BA1_FILIAL='" + xFilial("BA1") +"'"           
 cqueryi += CRLF+" AND BG9_FILIAL='" + xFilial("BG9") +"'"           
 cqueryi += CRLF+" AND ZZT_FILIAL='" + xFilial("ZZT") +"'"           
 cqueryi += CRLF+" and BD6_FILIAL='" + xFilial("BD6") +"'"           
 cqueryi += CRLF+" AND ZZQ_FILIAL='" + xFilial("ZZQ") +"'"           
 cqueryi += CRLF+" AND E1_FILIAL='" + xFilial("SE1") +"'"           
 cqueryi += CRLF+" AND E1_PREFIXO='RLE' "           
 cqueryi += CRLF+" AND B44_CODLDP=B45_CODLDP"           
 cqueryi += CRLF+" AND B44_CODPEG=B45_CODPEG"           
 cqueryi += CRLF+" AND B44_NUMAUT=B45_NUMAUT"           
 cqueryi += CRLF+" AND B44_PREFIX =E1_PREFIXO"           
 cqueryi += CRLF+" AND B44_NUM=E1_NUM"           
 cqueryi += CRLF+" AND BA1_CODINT=BA3_CODINT"           
 cqueryi += CRLF+" AND BA1_CODEMP=BA3_CODEMP"           
 cqueryi += CRLF+" AND BA1_MATRIC=BA3_MATRIC"           
 cqueryi += CRLF+" AND BA1_CODINT=B44_OPEUSR"           
 cqueryi += CRLF+" AND BA1_CODEMP=B44_CODEMP"           
 cqueryi += CRLF+" AND BA1_MATRIC=B44_MATRIC"           
 cqueryi += CRLF+" AND BA1_TIPREG=B44_TIPREG"           
 cqueryi += CRLF+" AND BI3_CODINT=BA1_CODINT"           
 cqueryi += CRLF+" AND B44_OPEUSR=BG9_CODINT"           
 cqueryi += CRLF+" AND B44_CODEMP=BG9_CODIGO"          
 cqueryi += CRLF+" AND BI3_CODIGO=Nvl(Trim(BA1_CODPLA),BA3_CODPLA)"          
 cqueryi += CRLF+" AND B44_YDTCON >= '"+cpgtoI+"01' AND B44_YDTCON <= '"+cpgtoF+"31' "  
 cqueryi += CRLF+" AND BD6_CODOPE='0001'"           
 cqueryi += CRLF+" AND B45_CODLDP=BD6_CODLDP"           
 cqueryi += CRLF+" AND B45_CODPEG=BD6_CODPEG"           
 cqueryi += CRLF+" AND B45_NUMERO=BD6_NUMERO"           
 cqueryi += CRLF+" AND B45_SEQUEN=BD6_SEQUEN"           
 cqueryi += CRLF+" AND B45_CODPAD=BD6_CODPAD"           
 cqueryi += CRLF+" AND B45_CODPRO=BD6_CODPRO"           
 cqueryi += CRLF+" and BD6_YNEVEN=ZZT_CODEV"           
 cqueryi += CRLF+" AND ZZQ_SEQUEN = B44_YCDPTC"            
 cqueryi += CRLF+" AND C.D_E_L_E_T_=' '"          
 cqueryi += CRLF+" AND D.D_E_L_E_T_=' '"           
 cqueryi += CRLF+" AND T.D_E_L_E_T_=' '"           
 cqueryi += CRLF+" AND U.D_E_L_E_T_=' '"           
 cqueryi += CRLF+" AND F.D_E_L_E_T_=' '"           
 cqueryi += CRLF+" AND BI3.D_E_L_E_T_=' '"           
 cqueryi += CRLF+" AND BG9.D_E_L_E_T_=' '"           
 cqueryi += CRLF+" AND ZZT.D_E_L_E_T_=' '"           
 cqueryi += CRLF+" AND ZZQ.D_E_L_E_T_=' '"           
 cqueryi += CRLF+" AND BD6.D_E_L_E_T_=' '"           
 cqueryi += CRLF+" GROUP BY"                                       
 cqueryi += CRLF+" bd6_codope || bd6_codemp || bd6_matric || bd6_tipreg || bd6_digito , " 
 cqueryi += CRLF+" bd6_nomusr ,  "
 cqueryi += CRLF+" Nvl(Trim(BA1_CODPLA),BA3_CODPLA) ,"  
 cqueryi += CRLF+" NVL(TRIM(SIGA.RETORNA_DESCRI_GRUPO_COBERT('"+cEmpresa+"', SIGA.RETORNA_GRUPO_COBERT('"+cEmpresa+"', BD6_CODPAD,BD6_CODPRO,'G'))), 'SEM GRUPO') ,"//Motta 22/10/20   
 cqueryi += CRLF+" RETORNA_DESC_GRUPO_PLANO ( TRIM(BI3_YGRPLA),'"+cEmpresa+"') ,"           
 cqueryi += CRLF+" Decode(B44_CODEMP,'0007',Trim(BI3_NREDUZ)||' (SEPE)',BI3_NREDUZ),"           
 cqueryi += CRLF+" SIGA_TIPO_EXPOSICAO_ANS(B44_CODEMP,B44_MATRIC,B44_TIPREG,To_Date(Trim(B44_DATPRO),'YYYYMMDD')),B44_ANOAUT,B44_MESAUT,"           
 cqueryi += CRLF+" ZZT_EVENTO,ZZT_TPCUST ,"           
 cqueryi += CRLF+" BD6_YNEVEN , bd6_dtdigi  ,"           
 cqueryi += CRLF+" BD6_YPROJ,"           
 cqueryi += CRLF+" (CASE WHEN (B45_ZZZCOD NOT IN('04','11','21','29','37','45','53','75','83','91','99','9H','9O','9S','9V','00','9Z','AA','AI',"           
 cqueryi += CRLF+"       'AQ','AY','B6','BE','BM','BU','C4','C8','CB','CG','CN','CU','D1','DD','DW','E5','ED','EZ','F0')"           
 cqueryi += CRLF+"        AND ZZQ_TIPPRO<>'1')"           
 cqueryi += CRLF+" then '2'  else '1' end),"           
 cqueryi += CRLF+" B44_CODEMP ,"           
 cqueryi += CRLF+" RETORNA_DESCRI_GRUPOEMP('"+cEmpresa+"',B44_CODEMP),"           
 cqueryi += CRLF+" BD6_DATPRO ,"           
 cqueryi += CRLF+" substr(E1_EMISSAO,1,6) , bd6_anopag || bd6_mespag , substr(ba1_datnas,7,2)||'/'||substr(ba1_datnas,5,2)||'/'|| substr(ba1_datnas,1,4) "             
 cqueryi += CRLF+" )"           
 cqueryi += CRLF+" Group By"           
 cqueryi += CRLF+" refer,"            
 cqueryi += CRLF+" CODEMP,"           
 cqueryi += CRLF+" GRUPO_PLANO,"            
 cqueryi += CRLF+" NOME_PLANO,"               
 cqueryi += CRLF+" GRP_COBERT," //Motta 22/10/20
 cqueryi += CRLF+" substr(DtEvent,7,2)||'/'|| substr(DtEvent,5,2)||'/'|| substr(DtEvent,1,4),"
 cqueryi += CRLF+" CodEvento,"           
 cqueryi += CRLF+" Nome_Evento,"           
 cqueryi += CRLF+" ZZT_TPCUST ,"          
 cqueryi += CRLF+" codrda , nomrda ,"          
 cqueryi += CRLF+" GRPPAG , DESCGRP ,"       
 cqueryi += CRLF+" tippre , TIPO ,TIPOloc ,"
 cqueryi += CRLF+" matricula ,  substr(dtdigi,7,2)||'/'|| substr(dtdigi,5,2)||'/'|| substr(dtdigi,1,4) , " 
 cqueryi += CRLF+" nomusr , anomespag , datnasusr , "
 cqueryi += CRLF+" NVL(RETORNA_QTD_FAIXA(SUBSTR(matricula,1,4),SUBSTR(matricula,5,4),SUBSTR(matricula,9,6),SUBSTR(matricula,15,2),substr(DTEVENT,1,4)),0) "
  
  If Select((cAliasCst)) <> 0 
       (cAliasCst)->(DbCloseArea()) 
  Endif

  memowrite("C:\TEMP\sqla137.sql",cqueryi)  
    
  TcQuery cQueryi New Alias (cAliasCst)  

                                                                                           
  (cAliasCst)->(dbGoTop())                                                   

  While !((cAliasCst)->(Eof()))                                                                                                                                                                                                   
    
        aAdd(aDadosInt , {(cAliasCst)->Emp        ,;         
                          (cAliasCst)->refer      ,;  
                          (cAliasCst)->CODEMP     ,;      
                          (cAliasCst)->GRUPO_PLANO,; 
                          (cAliasCst)->NOME_PLANO ,;  
                          (cAliasCst)->DtEvent    ,;     
                          (cAliasCst)->CodEvento  ,;   
                          (cAliasCst)->Nome_Evento,; 
                          (cAliasCst)->ZZT_TPCUST ,;  
                          (cAliasCst)->codrda     ,;     
                          (cAliasCst)->nomrda     ,;     
                          (cAliasCst)->GRPPAG     ,;     
                          (cAliasCst)->DESCGRP    ,;    
                          (cAliasCst)->tippre     ,;     
                          (cAliasCst)->TIPO       ,;       
                          (cAliasCst)->APRESENTADO,;
                          (cAliasCst)->GLOSADO    ,;    
                          (cAliasCst)->PAGO       ,;       
                          (cAliasCst)->COPART     ,;
                          (cAliasCst)->matricula  ,;  
                          (cAliasCst)->nomusr     ,;
                          (cAliasCst)->anomespag  ,;
                          (cAliasCst)->QTD_FAIXAS ,;
                          (cAliasCst)->dtdigi     ,;
                          (cAliasCst)->TIPOloc    ,;
                          (cAliasCst)->datnasusr  ,;                          
                          (cAliasCst)->GRP_COBERT ,})//Motta 22/10/20   
        (cAliasCst)->(DbSkip())

    EndDo 

FGrvPlan1()    
     
Return()    


Static Function AjustaSX1(cPerg)

Local aHelpPor := {}

PutSx1(cPerg,"01",OemToAnsi("Comp do Custo Inicial(AAAAMM)") 	,"","","mv_ch1","C",06,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","",aHelpPor,{},{})
PutSx1(cPerg,"02",OemToAnsi("Comp do Custo Final  (AAAAMM)") 	,"","","mv_ch2","C",06,0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","",aHelpPor,{},{})



Pergunte(cPerg,.T.)

Return 



Static Function FGrvPlan1()     

   If cEmpAnt == '02'
      cNomDadCab:= '1 - Custo Integral'
   Else                                
      cNomDadCab:= '1 - Custo Caberj'
   EndIf 
   cComp     := cpgtoI + ' à ' + cpgtoF
   cNomPla   := ' '                   
 
     	cNomeArq := "C:\TEMP\"+cComp+" - "+cNomDadCab+"_"+SubStr(DtoS(date()),7,2)+"_"+SubStr(DtoS(date()),5,2)+"_"+SubStr(DtoS(date()),1,4)+"_"+STRTRAN(TIME(),":","_")+".csv"
		nHandle := FCREATE(cNomeArq)
        cMontaTxt := cNomDadCab
        cMontaTxt += CRLF
        FWrite(nHandle,cMontaTxt)        		 
        cMontaTxt := 'Competencia : '+cComp
        cMontaTxt += CRLF
        FWrite(nHandle,cMontaTxt)		 
        cMontaTxt := 'Planilha : '+cNomDadCab  
        cMontaTxt += CRLF
        FWrite(nHandle,cMontaTxt)		
        
        cMontaTxt := "Empresa ;"    
        cMontaTxt += "Referencia  ;"    
        cMontaTxt += "Matricula   ;"   
        cMontaTxt += "Nome Usuario;"   
        cMontaTxt += "Cod Empresa ;"    
        cMontaTxt += "Grupo Plano ;"
		cMontaTxt += "Nome Plan   ;" 
		cMontaTxt += "Dt Evento   ;"  
        cMontaTxt += "Cod Evento  ;"		 
		cMontaTxt += "Nome Evento ;"   
		cMontaTxt += "Tipo Custo  ;"   
		cMontaTxt += "Codigo Rda  ;"  		
		cMontaTxt += "Nome Rda    ;"      		  
		cMontaTxt += "Grupo de pagto ;"
        cMontaTxt += "Desc Grp Pagto ;"
		cMontaTxt += "Prefixo ;" 
		cMontaTxt += "Tipo       ;" 
		cMontaTxt += "Vlr Apresentado ;"   
		cMontaTxt += "Vlr Glosado     ;"   
		cMontaTxt += "Vlr Pago        ;"  		
		cMontaTxt += "Vlr Coparte     ;"      		 
		cMontaTxt += "Ano Mes guia    ;" 
		cMontaTxt += "Qtda Faixa      ;"
		cMontaTxt += "Data Digitação  ;"
		cMontaTxt += "Local Digitação ;"
		cMontaTxt += "Data Nascimento ;"
      cMontaTxt += "Grp Cobertura   ;"//Motta 22/10/20
		
		cMontaTxt += CRLF // Salto de linha para .csv (excel)
             
		FWrite(nHandle,cMontaTxt)
		
      For nCount:=1 to len(aDadosInt)
      
                               cMontaTxt := trim(aDadosInt[nCount][1])  + ";"	 
                               cMontaTxt += trim(aDadosInt[nCount][2])  + ";"	
              				   cMontaTxt += trim(aDadosInt[nCount][20])  + ";"	
					           cMontaTxt += trim(aDadosInt[nCount][21])  + ";"	                               
              				   cMontaTxt += trim(aDadosInt[nCount][3])  + ";"	
					           cMontaTxt += trim(aDadosInt[nCount][4])  + ";"	
              		  		   cMontaTxt += trim(aDadosInt[nCount][5])  + ";"	
              				   cMontaTxt += trim(aDadosInt[nCount][6])  + ";"	
              				   cMontaTxt += str(aDadosInt[nCount][7])  + ";"	
              				   cMontaTxt += aDadosInt[nCount][8]  + ";"	
				               cMontaTxt += trim(aDadosInt[nCount][9])  + ";"	
              				   cMontaTxt += trim(aDadosInt[nCount][10]) + ";"	
              		           cMontaTxt += trim(aDadosInt[nCount][11]) + ";"	
                               cMontaTxt += trim(aDadosInt[nCount][12]) + ";"	
                               cMontaTxt += trim(aDadosInt[nCount][13]) + ";"	 
                               cMontaTxt += trim(aDadosInt[nCount][14]) + ";"	
                               cMontaTxt += trim(aDadosInt[nCount][15]) + ";"	
                               cMontaTxt += Transform(aDadosInt[nCount][16],'@E  999,999,999.99')+ ";"                  
                               cMontaTxt += Transform(aDadosInt[nCount][17],'@E  999,999,999.99')+ ";" 
                               cMontaTxt += Transform(aDadosInt[nCount][18],'@E  999,999,999.99')+ ";"     
                               cMontaTxt += Transform(aDadosInt[nCount][19],'@E  999,999,999.99')+ ";"                    
                               cMontaTxt += trim(aDadosInt[nCount][22]) + ";"	 
                               cMontaTxt += Transform(aDadosInt[nCount][23],'@E 9,999')+ ";"
                               cMontaTxt += aDadosInt[nCount][24] + ";"
                               cMontaTxt += aDadosInt[nCount][25] + ";"
                               cMontaTxt += aDadosInt[nCount][26] + ";"
                               cMontaTxt += aDadosInt[nCount][27] + ";"//Motta 22/10/20
         
    	  cMontaTxt += CRLF // Salto de linha para .csv (excel)      
		      
		  FWrite(nHandle,cMontaTxt)
	
      Next 

	If nHandle > 0
		
		// encerra gravação no arquivo
		FClose(nHandle)
		cNomeArq1+= cNomeArq + CRLF
	  //	MsgAlert("Relatorio salvo em: "+cNomeArq)
		
   
	    MsgAlert("Relatorio(s) salvo(s) em: "+ CRLF +cNomeArq1)

	EndIf                                 
	  

	If nHandle > 0
		
		// encerra gravação no arquivo
		FClose(nHandle)
	//	cNomeArq1+= cNomeArq + CRLF
	//	MsgAlert("Relatorio salvo em: "+cNomeArq)
		
	EndIf           
	    

Return ()    
///////

/*

 SELECT 
 'Caberj' Emp,             
   refer, 
   matricula , 
   nomusr ,
   CODEMP,  
   GRUPO_PLANO,        
   NOME_PLANO,
   substr(DtEvent,7,2)||'/'|| substr(DtEvent,5,2)||'/'|| substr(DtEvent,1,4)  DtEvent, 
   CodEvento,            
   Nome_Evento,            
   ZZT_TPCUST,              
   codrda , 
   nomrda ,  
   GRPPAG ,  
   DESCGRP,  
   tippre ,       
   TIPO , anomespag , 
   substr(dtdigi,7,2)||'/'|| substr(dtdigi,5,2)||'/'|| substr(dtdigi,1,4) dtdigi ,     
   SUM(VL_APROV+GLOSADO) APRESENTADO ,             
   SUM(GLOSADO) GLOSADO ,            
   SUM(VL_APROV) PAGO ,          
   SUM(Vl_Participacao) COPART ,  
   NVL(RETORNA_QTD_FAIXA(SUBSTR(matricula,1,4),SUBSTR(matricula,5,4),SUBSTR(matricula,9,6),SUBSTR(matricula,15,2),substr(DTEVENT,1,4)),0) QTD_FAIXAS , TIPOloc          
   FROM(                       
SELECT /*+first_rows index_asc(BD7 BD70205)*/   
 /* bd6_codope || bd6_codemp || bd6_matric || bd6_tipreg || bd6_digito  matricula ,  
  bd6_nomusr nomusr , 
  BD7_CODPLA PLANO,   
  BD6_YNEVEN CodEvento, 
  ZZT_EVENTO Nome_Evento, 
  QTDE , 
  Sum(BD6F.BD6_QTDPRO) Ocorrencia ,     
  Sum(BD6F.BD6_VLRGLO) Glosado ,  
  Sum(BD7F.VLRPAG)  Vl_Aprov ,  
  sum(Decode(BD6F.BD6_BLOCPA,'1',0,Decode(Sign(BD6F.BD6_VLRTPF),-1,0,Decode(BD6_CODEMP,'0004',0,'0009',0,BD6F.BD6_VLRTPF)))) Vl_Participacao ,            
  EXPOS EXPOSICAO_ANS ,           
  RETORNA_DESC_GRUPO_PLANO ( TRIM(BI3_YGRPLA),'C') GRUPO_PLANO,            
  Decode(BD6_CODEMP,'0007',Trim(BI3_NREDUZ)||' (SEPE)',BI3_NREDUZ) NOME_PLANO,           
  ZZT_TPCUST ,           
  BD6_YPROJ PROJ,     
  decode(BD6_CODLDP,'0010','Recup Glosa','0019','Recup Glosa','0017','Rateio','Conta') TIPO,        
  BD6_CODEMP CODEMP,            
  RETORNA_DESCRI_GRUPOEMP('C',BD6_CODEMP) NOME_EMP,             
  BD6_DATPRO  DTEVENT ,            
  bd7f.refer refer ,bd7f.codrda , bd7f.nomrda ,           
  bd7f.GRPPAG GRPPAG , bd7f.DESCGRP DESCGRP , bd7f.tippre tippre , bd6_anopag || bd6_mespag anomespag , bd6_dtdigi dtdigi ,       
   bcg_codldp ||'-'||bcg_descri  TIPOloc           
  FROM            
  (SELECT BD7.BD7_FILIAL,BD7_CODPLA,SIGA_TIPO_EXPOSICAO_ANS(BD7_CODEMP,BD7_MATRIC,BD7_TIPREG,To_Date(Trim(BD7_DATPRO),'YYYYMMDD')) EXPOS,           
   BD7.BD7_OPELOT,           
   BD7.BD7_CODOPE, BD7.BD7_CODLDP, BD7.BD7_CODPEG, BD7.BD7_NUMERO, BD7.BD7_ORIMOV, BD7_CODPRO,           
   BD7.BD7_SEQUEN,  Sum(BD7.BD7_VLRPAG) AS VLRPAG,           
   COUNT(DISTINCT BD7_CODEMP||BD7_MATRIC||BD7_TIPREG) QTDE ,            
   substr(BD7.BD7_NUMLOT,1,6) refer ,            
   bd7.bd7_codrda CODRDA , bd7.bd7_nomrda NOMRDA ,           
   BAU_GRPPAG GRPPAG , B16_DESCRI  DESCGRP , bau_tippre tippre         
   FROM BD7010 BD7 ,BAU010  BAU , B16010 B16           
   WHERE BD7.BD7_FILIAL=' '            
   AND BD7_OPELOT = '0001'           
   --AND BD7.BD7_NUMLOT >= '"+cpgtoI+"0001' AND BD7.BD7_NUMLOT <= '"+cpgtoF+"9999'        
   
   
   and (bd7_codpeg in  ('00761244','00762503','00766788','00767070','00766921','00761251','00761252','00755763','00759526','00759699', '00759717','00755762') 
         OR 
         BD7_CODRDA||BD7_NUMLOT   IN
         ('1375102019010008',
          '1375102019020006',
          '1375102019030004',
          
          '0443692019010009',
          '0443692019020007',
          '0443692019030005', 
          
          '1069252019010002',
          '1069252019020001',
          '1069252019030001',
          
          '1077942019010003',
          '1077942019020002',
          '1077942019030002',
          
          '1342102019030009',
          '1422632019030010',
          '1422712019030008',
          '1401552019020012',
          '1401472019020011'
          
          )
          )
   
   
   
   
   AND BD7_SITUAC = '1'          
   AND BD7_OPEUSR >='0001'          
   AND BD7_CODEMP >= '0001'          
   AND BD7_MATRIC >= '000001'          
   AND BD7_TIPREG >= '00'          
   AND BAU_FILIAL =' ' AND BAU.D_e_l_e_t_ = ' ' and bau.R_E_C_D_E_L_ = 0           
   AND B16_FILIAL =' ' AND B16.D_E_L_E_T_ = ' '           
   AND BD7.BD7_CODOPE = '0001'           
   AND BD7.BD7_FASE = '4'          
   AND BD7.BD7_BLOPAG <> '1'            
   AND BAU_CODIGO = BD7.BD7_CODRDA           
   AND bau_grppag = B16_CODIGO           
   AND BD7.D_E_L_E_T_ = ' '           
   GROUP BY BD7_FILIAL, BD7_CODPLA, BD7.BD7_OPELOT,BD7_CODPRO,           
   SIGA_TIPO_EXPOSICAO_ANS(BD7_CODEMP,BD7_MATRIC,BD7_TIPREG,To_Date(Trim(BD7_DATPRO),'YYYYMMDD')),           
   BD7_FILIAL, BD7_CODOPE, BD7_CODLDP, BD7_CODPEG, BD7_NUMERO, BD7_ORIMOV, BD7_SEQUEN ,          
   bd7.bd7_codrda, bd7.bd7_nomrda ,BAU_GRPPAG, B16_DESCRI, bau_tippre ,            
   substr(BD7.BD7_NUMLOT,1,6)) BD7F,           
   BD6010 BD6F ,BI3010 BI3 , ZZT010 ZZT, BCG010 BCG        
   WHERE ZZT_FILIAL=' '           
     and BI3_FILIAL=' '           
     and BCG_FILIAL=' '           
     AND BD6F.BD6_FILIAL=' '           
     AND BD7F.BD7_FILIAL = BD6F.BD6_FILIAL           
     AND BD7F.BD7_CODOPE = BD6F.BD6_CODOPE           
     AND BD7F.BD7_CODLDP = BD6F.BD6_CODLDP           
     AND BD7F.BD7_CODPEG = BD6F.BD6_CODPEG           
     AND BD7F.BD7_NUMERO = BD6F.BD6_NUMERO           
     AND BD7F.BD7_ORIMOV = BD6F.BD6_ORIMOV           
     and BD7F.BD7_SEQUEN = BD6F.BD6_SEQUEN           
     AND BD6F.BD6_CODPRO = BD7F.BD7_CODPRO           
     AND BI3_FILIAL =BD7_FILIAL           
     AND BI3_CODINT=BD7_CODOPE           
     AND BI3_CODIGO=BD7_CODPLA          
     AND BD6_YNEVEN=ZZT_CODEV           
     AND BCG_CODLDP = BD6F.BD6_CODLDP           
     AND BI3.D_E_L_E_T_ = ' '           
     AND ZZT.D_E_L_E_T_ = ' '   
     AND BCG.D_E_L_E_T_ = ' '   
     AND BD6F.D_E_L_E_T_ = ' '   
   GROUP  BY
   bd6_codope || bd6_codemp || bd6_matric || bd6_tipreg || bd6_digito , 
   bd6_nomusr , BD7_CODPLA , BD6_YNEVEN , ZZT_EVENTO , QTDE , 
   EXPOS , RETORNA_DESC_GRUPO_PLANO ( TRIM(BI3_YGRPLA),'C') , 
   Decode(BD6_CODEMP,'0007',Trim(BI3_NREDUZ)||' (SEPE)',BI3_NREDUZ) , 
   ZZT_TPCUST , BD6_YPROJ , 
   decode(BD6_CODLDP,'0010','Recup Glosa','0019','Recup Glosa','0017','Rateio','Conta') , 
   BD6_CODEMP , RETORNA_DESCRI_GRUPOEMP('C',BD6_CODEMP) , 
   BD6_DATPRO , bd7f.refer ,bd7f.codrda , bd7f.nomrda , 
   bd7f.GRPPAG  , bd7f.DESCGRP  , bd7f.tippre  , bd6_anopag || bd6_mespag  , bd6_dtdigi ,bcg_codldp ||'-'||bcg_descri 
  )           
 Group By           
          refer,            
          CODEMP,           
          GRUPO_PLANO,            
          NOME_PLANO,           
          substr(DtEvent,7,2)||'/'|| substr(DtEvent,5,2)||'/'|| substr(DtEvent,1,4),
  CodEvento,           
  Nome_Evento,           
  ZZT_TPCUST ,          
  codrda , nomrda ,          
  GRPPAG , DESCGRP ,       
  tippre , TIPO ,TIPOloc ,
  matricula ,  substr(dtdigi,7,2)||'/'|| substr(dtdigi,5,2)||'/'|| substr(dtdigi,1,4) , 
  nomusr , anomespag ,
  NVL(RETORNA_QTD_FAIXA(SUBSTR(matricula,1,4),SUBSTR(matricula,5,4),SUBSTR(matricula,9,6),SUBSTR(matricula,15,2),substr(DTEVENT,1,4)),0) 
  */

*/
