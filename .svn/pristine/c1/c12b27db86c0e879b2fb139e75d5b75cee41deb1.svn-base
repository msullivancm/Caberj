#INCLUDE "PROTHEUS.CH"
#Include "TOPCONN.CH"
                                              
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABR135a  º Autor ³Altamiro              º Data ³ 01/10/12  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Rotina para listagem de saldo de rdas - por guias          º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/                  

User Function CABR135a

Local cMsg			:= ""
Private lAbortPrint :=.F.
Private cPerg       := "CABR135a"
Private cTitulo     := "Listagem de Saldos dos RDAs - por Competencia de Faturamento -  "        
private aDados1     := {} 
private aDados2     := {}
Private cAliastmp 	:= GetNextAlias()             

Private cFATURADA   := 0         
Private cATVPRT35   := 0    
Private cATVPRONT   := 0
Private cCONFEREN   := 0
Private cDIGITACA   := 0
Private cDBCRENFA   := 0
Private cDBCREFAT   := 0   
Private nTotQtda    := 0
                                                                         
//SetPrvt("oDlg1","oGrp1","oSay1","oSBtn1","oSBtn2","oSBtn3")

cMsg += " Este programa ira fazer listagem de assitidos que iram completar 18 anos na data " + CRLF
cMsg += " Passada por paramentro " + CRLF

***************************************************************************    
 
Private  aDados1     := {}       
//Private  acabec1    :={"Matricula","Nome Usuario", "Data Nasc." , "Cpf usuario ","Nome Mãe ","Telefone ","Celilar ","Cod. Plano","Nome Plano","Municipio", "E_mail" }     
Private  acabec1    :={"GRPPAG" , "NOME",  "TPESSOA" , "FATURADA" ,"Qtda", "%", "ATVPRT35" ,"Qtda","%", "ATVPRONT" ,"Qtda", "%", "CONFEREN" ,"Qtda","%", "DIGITACA","%", "DBCRENFA" ,"DBCREFAT","Tot. Qtda"  } 
Private  acabec2    :={"GRPPAG"  , "FATURADA" ,"Qtda" ,"%",  "ATVPRT35" ,"Qtda", "%","ATVPRONT" ,"Qtda",  "%","CONFEREN" ,"Qtda", "%","DIGITACA" , "%","DBCRENFA" ,"DBCREFAT", "Tot. Qtda" }
Private  acabec3    :={"GRPPAG" , "NOME",  "TPESSOA", "Peg", "Loc.Dig" ,"Numero", "Sequencia" ,"ANALISTA", "FATURADA" ,"Qtda", "%", "ATVPRT35" ,"Qtda","%", "ATVPRONT" ,"Qtda", "%", "CONFEREN" ,"Qtda","%", "DIGITACA","%", "DBCRENFA" ,"DBCREFAT","Tot. Qtda"  } 

private Descric := ' '                                                                                                         

//   "   	
  	  
AjustaSX1(cPerg)

Pergunte(cPerg,.T.)

cMesbase    := mv_par01
cAnobase	:= mv_par02 
if !empty(mv_par03) 
   cGrpRdas    := FormatIn(trim(mv_par03), ",") 
Else                                            
   cGrpRdas    := " " 
EndIf
dDtprocd    := dtos(mv_par04) 
dDtproca    := dtos(mv_par05)
lsintet	    := Iif(mv_par06 == 1,.T.,.F.)    
lordena	    := Iif(mv_par07 == 1,.T.,.F.)   
lexcel	    := Iif(mv_par08 == 1,.T.,.F.)    
lGerenc     := Iif(mv_par09 == 1,.T.,.F.)  

lGerCmpEnt  := Iif(mv_par10 == 1,.T.,.F.)     

lGerRecGlo  := Iif(mv_par11 == 1,.T.,.F.)      
lGerSConv   := Iif(mv_par12 == 1,.T.,.F.)     

nContInc    := mv_par13  
nContFim    := mv_par14  
nClasEmp    := mv_par15
  
Processa({||Processa1()}, cTitulo, "", .T.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Libera impressao                                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
  
// faz ecxel
if lexcel      
   if !lsintet   
      If !lGerenc 
         DlgToExcel({{"ARRAY","Mapa de Pagto medico " ,aCabec1,aDados2}})   
      else 
         DlgToExcel({{"ARRAY","Mapa de Pagto medico " ,aCabec3,aDados2}})          
      EndIf   
   Else                                                                            
       DlgToExcel({{"ARRAY","Mapa de Pagto medico " ,aCabec2,aDados1}})   
   EndIF    
EndIF
//fGeraRel2()    
MsgInfo("Processo finalizado")

Return                 

**************************************************************************

/*
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
*/
Static Function Processa1() 

Local cquery := ''       

ProcRegua(FT_FLASTREC()) 

nCont := 0
IncProc('Processando...')      
///////////////////////////////////
  
cquery := CRLF+" SELECT TAB.GRPPAG GRPPAG ,"
if !lsintet
    cquery +=" SUBSTR(TAB.NOME,1,40) NOME, TAB.TPESSOA  TPESSOA , "
    if lGerenc 
       cquery += "  TAB.PEG PEG , TAB.LOCDIG LOCDIG , TAB.numero numero , TAB.sequen sequen , TAB.CODANA CODANA , TAB.NOMANA NOMANA ,"
    EndIf 
endIf 
If nClasEmp == 1 
   cquery += "  TAB.Empresa Empresa ,"
endIf 
cquery += CRLF+" SUM (DECODE (TAB.SEQ, '1', TAB.VALOR_LOTE, 0.00)) FATURADA , SUM (DECODE (TAB.SEQ, '1', TAB.qtda, 0)) qFATURADA ,"
cquery += CRLF+" SUM (DECODE (TAB.SEQ, '2', TAB.VALOR_LOTE, 0.00)) ATVPRT35 , SUM (DECODE (TAB.SEQ, '2', TAB.qtda, 0)) qATVPRT35 ,"
cquery += CRLF+" SUM (DECODE (TAB.SEQ, '3', TAB.VALOR_LOTE, 0.00)) ATVPRONT , SUM (DECODE (TAB.SEQ, '3', TAB.qtda, 0)) qATVPRONT ,"
cquery += CRLF+" SUM (DECODE (TAB.SEQ, '4', TAB.VALOR_LOTE, 0.00)) CONFEREN , SUM (DECODE (TAB.SEQ, '4', TAB.qtda, 0)) qCONFEREN ," 
cquery += CRLF+" SUM (DECODE (TAB.SEQ, '5', TAB.VALOR_LOTE, 0.00)) DIGITACA , SUM (DECODE (TAB.SEQ, '5', TAB.qtda, 0)) qDIGITACA ,"
cquery += CRLF+" SUM (DECODE (TAB.SEQ, '6', TAB.VALOR_LOTE, 0.00)) DBCRENFA , SUM (DECODE (TAB.SEQ, '6', TAB.qtda, 0)) qDBCRENFA ,"
cquery += CRLF+" SUM (DECODE (TAB.SEQ, '7', TAB.VALOR_LOTE, 0.00)) DBCREFAT , SUM (DECODE (TAB.SEQ, '7', TAB.qtda, 0)) qDBCREFAT ,"    

cquery += CRLF+" SUM (TAB.glosa)    qGLOSA    ,"   
cquery += CRLF+" SUM (TAB.apresent) qAPRESENT ,"   
cquery += CRLF+" SUM (TAB.Previa)   qPREVIA   "   

cquery += CRLF+" FROM (SELECT '1' SEQ ,'faturada ' TIPO , BAU_GRPPAG||' - ' || b16_descri  GRPPAG ,bau_CODIGO ||' - ' ||nvl(trim(bau_nfanta), bau_nome)  NOME, "
cquery += CRLF+" DECODE(TRIM(BAU_CODRET),'1708','P_JURIDICA','0588','P_FISICA','Nao Especificado') Tpessoa , SUM (BD7_VLRPAG) VALOR_LOTE  ,count(*) qtda  , "
cquery += CRLF+" BD7_CODPEG PEG , BD7_CODLDP LOCDIG  , bd7_numero numero , bd7_sequen sequen , NVL(ZN_CODANA,' ') CODANA , NVL(ZN_NOMANA,' ') NOMANA , "  
 
cquery += CRLF+"   CASE WHEN bd7_codemp = '0024' THEN 'Prefeitura' "
cquery += CRLF+"        WHEN bd7_codemp = '0025' THEN 'Prefeitura' "
cquery += CRLF+"        WHEN bd7_codemp = '0026' THEN 'Prefeitura' "            
cquery += CRLF+"        WHEN bd7_codemp = '0027' THEN 'Prefeitura' "
cquery += CRLF+"        WHEN bd7_codemp = '0028' THEN 'Prefeitura' "
cquery += CRLF+"   Else 'Rede' "  
cquery += CRLF+"   End empresa ,"  
cquery += CRLF+"   sum(bd7_vlrglo) glosa , sum(bd7_vlrapr) apresent , 0 previa  " 
  
cquery += CRLF+" FROM " + RetSqlName("BD7")+" BD7 ," + RetSqlName("BAU")+" BAU ," + RetSqlName("B16")+" B16 ,SZN010 SZN WHERE BD7_FILIAL = '"+xFilial("BD7")+"' "
cquery += CRLF+" AND BD7.D_E_L_E_T_ = ' ' AND BD7_FASE = '4' AND BD7.BD7_SITUAC = '1' AND BD7.BD7_CODEMP <>'9999' "
if lGerCmpEnt 
   cquery += CRLF+" AND BD7.BD7_MESPAG = '"+cMesbase+"' AND BD7.BD7_ANOPAG = '"+cAnobase+"'" 
   cquery += CRLF+" AND BD7_NUMLOT >= '"+cAnobase+cMesbase+"0001' AND BD7_NUMLOT <= '"+cAnobase+cMesbase+"9999' "
else    
   cquery += CRLF+" AND BD7.BD7_MESPAG >= '01' AND BD7.BD7_ANOPAG >= '2001' " 
   cquery += CRLF+" AND BD7_NUMLOT >= '"+cAnobase+cMesbase+"0001' AND BD7_NUMLOT <= '"+cAnobase+cMesbase+"9999' "
   cquery += CRLF+" AND BD7_DATPRO >= '"+dDtprocd+"' AND BD7_DATPRO <= '"+dDtproca+"' "
EndIf      
if !lGerRecGlo 
      cquery += CRLF+" AND BD7_CODLDP <> '0010' "    
EndIf  
if lGerSConv
    cquery += CRLF+" AND BD7_CODEMP  = '0004' " 
    cquery += CRLF+" AND BD7_CONEMP  >= '"+ nContInc +"' "
    cquery += CRLF+" AND BD7_CONEMP  <= '"+ nContFim +"' "  
EndIf
cquery += CRLF+" AND ( BD7.BD7_CONPAG = '1' OR BD7.BD7_CONPAG = ' ') AND BD7.BD7_LOTBLO = ' ' AND BD7.BD7_BLOPAG <> '1' "
cquery += CRLF+" AND BD7_YFAS35 = 'T' AND BAU_FILIAL = '"+xFilial("BAU")+"' AND BAU.D_E_L_E_T_ = ' ' AND B16_FILIAL = '"+xFilial("B16")+"' AND B16.D_E_L_E_T_ = ' ' "
cquery += CRLF+" AND bau_grppag = b16_codigo AND BD7_CODRDA  = BAU_CODIGO AND BD7_VLRPAG > 0 "  

cquery += CRLF+" AND ZN_FILIAL(+) = '"+xFilial("SZN")+"' AND SZN.D_E_L_E_T_(+) = ' ' AND BAU_CODIGO = ZN_CODRDA(+) AND (ZN_VIGFIM(+) = ' ' OR ZN_VIGFIM(+) >= '"+cAnobase+cMesbase+"' )"

if !empty(mv_par03) 
    cquery += CRLF+"  AND BAU.BAU_GRPPAG IN "+cGrpRdas+" "
EndIf  
cquery += CRLF+" GROUP BY  BAU_GRPPAG, b16_descri , bau_CODIGO ||' - ' ||nvl(trim(bau_nfanta), bau_nome) , BAU_CODRET , BD7_CODPEG, BD7_CODLDP  , bd7_numero , bd7_sequen , ZN_CODANA , ZN_NOMANA , bd7_codemp  "

cquery += CRLF+" UNION ALL "

cquery += CRLF+" SELECT '2' SEQ ,'Pronta_Conferida '  TIPO ,BAU_GRPPAG||' - ' || B16_DESCRI GRPPAG ,BAU_CODIGO ||' - ' ||nvl(trim(bau_nfanta), bau_nome) NOME, "
cquery += CRLF+" DECODE(TRIM(BAU_CODRET),'1708','P_JURIDICA','0588','P_FISICA','Nao Especificado') TPESSOA ,SUM (BD7_VLRPAG) VALOR_LOTE  ,count(*) qtda , "
cquery += CRLF+" BD7_CODPEG PEG , BD7_CODLDP LOCDIG  ,  bd7_numero numero , bd7_sequen sequen , NVL(ZN_CODANA,' ') CODANA , NVL(ZN_NOMANA,' ') NOMANA , "      
 
cquery += CRLF+"   CASE WHEN bd7_codemp = '0024' THEN 'Prefeitura' "
cquery += CRLF+"        WHEN bd7_codemp = '0025' THEN 'Prefeitura' "
cquery += CRLF+"        WHEN bd7_codemp = '0026' THEN 'Prefeitura' "            
cquery += CRLF+"        WHEN bd7_codemp = '0027' THEN 'Prefeitura' "
cquery += CRLF+"        WHEN bd7_codemp = '0028' THEN 'Prefeitura' "
cquery += CRLF+"   Else 'Rede' "  
cquery += CRLF+"   End empresa ," 
cquery += CRLF+"   sum(bd7_vlrglo) glosa , sum(bd7_vlrapr) apresent , 0 previa  " 

cquery += CRLF+" FROM " + RetSqlName("BD7")+" BD7, " + RetSqlName("BAU")+" BAU, " + RetSqlName("B16")+" B16, SZN010 SZN WHERE BD7_FILIAL = '"+xFilial("BD7")+"' "
cquery += CRLF+" AND BD7.D_E_L_E_T_ = ' ' AND BD7_FASE = '3' AND BD7.BD7_SITUAC = '1' AND BD7.BD7_CODEMP <>'9999'  " 
if lGerCmpEnt 
   cquery += CRLF+" AND BD7.BD7_MESPAG = '"+cMesbase+"' AND BD7.BD7_ANOPAG = '"+cAnobase+"'" 
else 
   cquery += CRLF+" AND BD7.BD7_ANOPAG || BD7.BD7_MESPAG <= '"+cAnobase+cMesbase+"' " 
   cquery += CRLF+" AND BD7_DATPRO >= '"+dDtprocd+"' AND BD7_DATPRO <= '"+dDtproca+"' "
EndIF  
if !lGerRecGlo 
    cquery += CRLF+" AND BD7_CODLDP <> '0010' "    
EndIf       
if lGerSConv
    cquery += CRLF+" AND BD7_CODEMP  = '0004' " 
    cquery += CRLF+" AND BD7_CONEMP  >= '"+ nContInc +"' "
    cquery += CRLF+" AND BD7_CONEMP  <= '"+ nContFim +"' "  
EndIf
cquery += CRLF+" AND ( BD7.BD7_CONPAG = '1' OR BD7.BD7_CONPAG = ' ') AND BD7.BD7_LOTBLO = ' ' AND BD7.BD7_BLOPAG <> '1' AND BD7_NUMLOT >= ' ' "
cquery += CRLF+" AND BD7_YFAS35 = 'T' AND BAU_FILIAL = '"+xFilial("BAU")+"' AND BAU.D_E_L_E_T_ = ' ' AND B16_FILIAL = '"+xFilial("B16")+"' AND B16.D_E_L_E_T_ = ' ' "
cquery += CRLF+" AND bau_grppag = b16_codigo AND BD7_CODRDA  = BAU_CODIGO AND BD7_VLRPAG > 0 "        

cquery += CRLF+" AND ZN_FILIAL(+) = '"+xFilial("SZN")+"' AND SZN.D_E_L_E_T_(+) = ' ' AND BAU_CODIGO = ZN_CODRDA(+) AND (ZN_VIGFIM(+) = ' ' OR ZN_VIGFIM(+) >= '"+cAnobase+cMesbase+"' )"

if !empty(mv_par03) 
    cquery += CRLF+"  AND BAU.BAU_GRPPAG IN "+cGrpRdas+" "
EndIf 
cquery += CRLF+" GROUP BY  BAU_GRPPAG, b16_descri , BAU_CODIGO ||' - ' ||nvl(trim(bau_nfanta), bau_nome) , BAU_CODRET , BD7_CODPEG, bd7_numero , bd7_sequen , BD7_CODLDP , ZN_CODANA , ZN_NOMANA , bd7_codemp  "

cquery += CRLF+"  UNION ALL "

cquery += CRLF+" SELECT '3' SEQ , 'Pronta_Nao_Conferida_SEM_35' TIPO , BAU_GRPPAG||' - ' || b16_descri GRPPAG , Bau_CODIGO ||' - ' ||nvl(trim(bau_nfanta), bau_nome)  NOME, "
cquery += CRLF+" DECODE(TRIM(BAU_CODRET),'1708','P_JURIDICA','0588','P_FISICA','Nao Especificado') Tpessoa , SUM (BD7_VLRPAG) VALOR_LOTE  ,count(*) qtda , "
cquery += CRLF+" BD7_CODPEG PEG , BD7_CODLDP LOCDIG ,bd7_numero numero , bd7_sequen sequen ,  NVL(ZN_CODANA,' ') CODANA , NVL(ZN_NOMANA,' ') NOMANA , "  
 
cquery += CRLF+"   CASE WHEN bd7_codemp = '0024' THEN 'Prefeitura' "
cquery += CRLF+"        WHEN bd7_codemp = '0025' THEN 'Prefeitura' "
cquery += CRLF+"        WHEN bd7_codemp = '0026' THEN 'Prefeitura' "            
cquery += CRLF+"        WHEN bd7_codemp = '0027' THEN 'Prefeitura' "
cquery += CRLF+"        WHEN bd7_codemp = '0028' THEN 'Prefeitura' "
cquery += CRLF+"   Else 'Rede' "  
cquery += CRLF+"   End empresa , " 
cquery += CRLF+"   sum(bd7_vlrglo) glosa , sum(bd7_vlrapr) apresent , 0 previa  " 
  
cquery += CRLF+" FROM " + RetSqlName("BD7")+" BD7 ," + RetSqlName("BAU")+" BAU ," + RetSqlName("B16")+" B16 , SZN010 SZN WHERE BD7_FILIAL = '"+xFilial("BD7")+"' "
cquery += CRLF+" AND BD7.D_E_L_E_T_ = ' ' AND BD7_FASE = '3' AND BD7.BD7_SITUAC = '1' AND BD7.BD7_CODEMP <>'9999' " 
if lGerCmpEnt 
   cquery += CRLF+" AND BD7.BD7_MESPAG = '"+cMesbase+"' AND BD7.BD7_ANOPAG = '"+cAnobase+"'" 
else 
   cquery += CRLF+" AND BD7.BD7_ANOPAG || BD7.BD7_MESPAG <= '"+cAnobase+cMesbase+"' " 
   cquery += CRLF+" AND BD7_DATPRO >= '"+dDtprocd+"' AND BD7_DATPRO <= '"+dDtproca+"' "
EndIF
if !lGerRecGlo 
      cquery += CRLF+" AND BD7_CODLDP <> '0010' "    
EndIf
if lGerSConv
    cquery += CRLF+" AND BD7_CODEMP  = '0004' " 
    cquery += CRLF+" AND BD7_CONEMP  >= '"+ nContInc +"' "
    cquery += CRLF+" AND BD7_CONEMP  <= '"+ nContFim +"' "  
EndIf  
cquery += CRLF+" AND ( BD7.BD7_CONPAG = '1' OR BD7.BD7_CONPAG = ' ')  AND BD7.BD7_LOTBLO = ' ' AND BD7.BD7_BLOPAG <> '1' AND BD7_NUMLOT >= ' ' "
cquery += CRLF+" AND BD7_YFAS35 = 'F' AND BAU_FILIAL = '"+xFilial("BAU")+"' AND BAU.D_E_L_E_T_ = ' ' AND B16_FILIAL = '"+xFilial("B16")+"'AND B16.D_E_L_E_T_ = ' ' "
cquery += CRLF+" AND bau_grppag = b16_codigo AND BD7_CODRDA  = BAU_CODIGO AND BD7_VLRPAG > 0 "                          

cquery += CRLF+" AND ZN_FILIAL(+) = '"+xFilial("SZN")+"' AND SZN.D_E_L_E_T_(+) = ' ' AND BAU_CODIGO = ZN_CODRDA(+) AND (ZN_VIGFIM(+) = ' ' OR ZN_VIGFIM(+) >= '"+cAnobase+cMesbase+"' )"

if !empty(mv_par03) 
    cquery += CRLF+"  AND BAU.BAU_GRPPAG IN "+cGrpRdas+" "
EndIf 
cquery += CRLF+" GROUP BY  BAU_GRPPAG, b16_descri ,Bau_CODIGO ||' - ' ||nvl(trim(bau_nfanta), bau_nome), BAU_CODRET , BD7_CODPEG, BD7_CODLDP ,bd7_numero , bd7_sequen , ZN_CODANA , ZN_NOMANA , bd7_codemp  "

cquery += CRLF+" UNION ALL "
   
cquery += CRLF+" SELECT '4' SEQ , 'Em_Conferencia_FASE2' TIPO , BAU_GRPPAG||' - ' || B16_DESCRI GRPPAG ,BAU_CODIGO ||' - ' ||nvl(trim(bau_nfanta), bau_nome)  NOME, "
cquery += CRLF+" DECODE(TRIM(BAU_CODRET),'1708','P_JURIDICA','0588','P_FISICA','Nao Especificado') Tpessoa , SUM (BD7_VLRPAG) VALOR_LOTE    ,count(*) qtda , "
cquery += CRLF+" BD7_CODPEG PEG , BD7_CODLDP LOCDIG ,bd7_numero numero , bd7_sequen sequen , NVL(ZN_CODANA,' ') CODANA , NVL(ZN_NOMANA,' ') NOMANA , "  
 
cquery += CRLF+"   CASE WHEN bd7_codemp = '0024' THEN 'Prefeitura' "
cquery += CRLF+"        WHEN bd7_codemp = '0025' THEN 'Prefeitura' "
cquery += CRLF+"        WHEN bd7_codemp = '0026' THEN 'Prefeitura' "            
cquery += CRLF+"        WHEN bd7_codemp = '0027' THEN 'Prefeitura' "
cquery += CRLF+"        WHEN bd7_codemp = '0028' THEN 'Prefeitura' "
cquery += CRLF+"   Else 'Rede' "  
cquery += CRLF+"   End empresa , " 
cquery += CRLF+"   sum(bd7_vlrglo) glosa , sum(bd7_vlrapr) apresent , 0 previa  " 

cquery += CRLF+" FROM " + RetSqlName("BD7")+" BD7 ," + RetSqlName("BAU")+" BAU ," + RetSqlName("B16")+" B16 , SZN010 SZN WHERE BD7_FILIAL = '"+xFilial("BD7")+"' "
cquery += CRLF+" AND BD7.D_E_L_E_T_ = ' ' AND BD7_FASE = '2' AND BD7.BD7_SITUAC = '1' AND BD7.BD7_CODEMP <>'9999' " 

if lGerCmpEnt 
   cquery += CRLF+" AND BD7.BD7_MESPAG = '"+cMesbase+"' AND BD7.BD7_ANOPAG = '"+cAnobase+"'" 
else 
   cquery += CRLF+" AND BD7.BD7_ANOPAG || BD7.BD7_MESPAG <= '"+cAnobase+cMesbase+"' " 
   cquery += CRLF+" AND BD7_DATPRO >= '"+dDtprocd+"' AND BD7_DATPRO <= '"+dDtproca+"' "
EndIF
if !lGerRecGlo 
      cquery += CRLF+" AND BD7_CODLDP <> '0010' "    
EndIf
if lGerSConv
    cquery += CRLF+" AND BD7_CODEMP  = '0004' " 
    cquery += CRLF+" AND BD7_CONEMP  >= '"+ nContInc +"' "
    cquery += CRLF+" AND BD7_CONEMP  <= '"+ nContFim +"' "  
EndIf   
cquery += CRLF+" AND ( BD7.BD7_CONPAG = '1' OR BD7.BD7_CONPAG = ' ') AND BD7.BD7_LOTBLO = ' ' AND BD7.BD7_BLOPAG <> '1' AND BD7_NUMLOT >= ' ' "
cquery += CRLF+" AND BD7_YFAS35 = 'F' AND BAU_FILIAL = '"+xFilial("BAU")+"' AND BAU.D_E_L_E_T_ = ' ' AND B16_FILIAL = '"+xFilial("B16")+"'AND B16.D_E_L_E_T_ = ' ' "
cquery += CRLF+" AND bau_grppag = b16_codigo AND BD7_CODRDA  = BAU_CODIGO AND BD7_VLRPAG > 0 "

cquery += CRLF+" AND ZN_FILIAL(+) = '"+xFilial("SZN")+"' AND SZN.D_E_L_E_T_(+) = ' ' AND BAU_CODIGO = ZN_CODRDA(+) AND (ZN_VIGFIM(+) = ' ' OR ZN_VIGFIM(+) >= '"+cAnobase+cMesbase+"' )"

if !empty(mv_par03) 
    cquery += CRLF+"  AND BAU.BAU_GRPPAG IN "+cGrpRdas+" "
EndIf 
cquery += CRLF+" GROUP BY  BAU_GRPPAG, b16_descri ,BAU_CODIGO ||' - ' ||nvl(trim(bau_nfanta), bau_nome), BAU_CODRET , BD7_CODPEG, BD7_CODLDP ,bd7_numero , bd7_sequen , ZN_CODANA , ZN_NOMANA , bd7_codemp "

cquery += CRLF+"  UNION ALL "
 
cquery += CRLF+" SELECT '5' SEQ ,'Em_Digitação_FASE1 ' TIPO , BAU_GRPPAG||' - ' || b16_descri GRPPAG ,BAU_CODIGO ||' - ' || nvl(trim(bau_nfanta), bau_nome)  NOME,  "
cquery += CRLF+" DECODE(TRIM(BAU_CODRET),'1708','P_JURIDICA','0588','P_FISICA','Nao Especificado') TPESSOA , COUNT (*) VALOR_LOTE  ,count(*) qtda  , "
cquery += CRLF+" BD7_CODPEG PEG , BD7_CODLDP LOCDIG ,bd7_numero numero , bd7_sequen sequen, NVL(ZN_CODANA,' ') CODANA , NVL(ZN_NOMANA,' ') NOMANA , "                     

cquery += CRLF+"   CASE WHEN bd7_codemp = '0024' THEN 'Prefeitura' "
cquery += CRLF+"        WHEN bd7_codemp = '0025' THEN 'Prefeitura' "
cquery += CRLF+"        WHEN bd7_codemp = '0026' THEN 'Prefeitura' "            
cquery += CRLF+"        WHEN bd7_codemp = '0027' THEN 'Prefeitura' "
cquery += CRLF+"        WHEN bd7_codemp = '0028' THEN 'Prefeitura' "
cquery += CRLF+"   Else 'Rede' "  
cquery += CRLF+"   End empresa , "
cquery += CRLF+"   sum(bd7_vlrglo) glosa , sum(bd7_vlrapr) apresent , 0 previa  "  

cquery += CRLF+" FROM " + RetSqlName("BD7")+" BD7 ," + RetSqlName("BAU")+" BAU ," + RetSqlName("B16")+" B16 , SZN010 SZN WHERE BD7_FILIAL = '"+xFilial("BD7")+"' "
cquery += CRLF+" AND BD7.D_E_L_E_T_ = ' ' AND BD7_FASE = '1' AND BD7.BD7_SITUAC = '1' AND BD7.BD7_CODEMP <>'9999' "
if lGerCmpEnt 
   cquery += CRLF+" AND BD7.BD7_MESPAG = '"+cMesbase+"' AND BD7.BD7_ANOPAG = '"+cAnobase+"'" 
else 
   cquery += CRLF+" AND BD7.BD7_ANOPAG || BD7.BD7_MESPAG <= '"+cAnobase+cMesbase+"' " 
   cquery += CRLF+" AND BD7_DATPRO >= '"+dDtprocd+"' AND BD7_DATPRO <= '"+dDtproca+"' "
EndIF 
if !lGerRecGlo 
      cquery += CRLF+" AND BD7_CODLDP <> '0010' "    
EndIf
if lGerSConv
    cquery += CRLF+" AND BD7_CODEMP  = '0004' " 
    cquery += CRLF+" AND BD7_CONEMP  >= '"+ nContInc +"' "
    cquery += CRLF+" AND BD7_CONEMP  <= '"+ nContFim +"' "  
EndIf  
cquery += CRLF+" AND ( BD7.BD7_CONPAG = '1' OR BD7.BD7_CONPAG = ' ') AND BD7.BD7_LOTBLO = ' ' AND BD7.BD7_BLOPAG <> '1' AND BD7_NUMLOT >= ' ' "
cquery += CRLF+" AND BD7_YFAS35 = 'F' AND BAU_FILIAL = '"+xFilial("BAU")+"' AND BAU.D_E_L_E_T_ = ' ' AND B16_FILIAL = '"+xFilial("B16")+"'AND B16.D_E_L_E_T_ = ' ' "
cquery += CRLF+" AND bau_grppag = b16_codigo AND BD7_CODRDA  = BAU_CODIGO  "

cquery += CRLF+" AND ZN_FILIAL(+) = '"+xFilial("SZN")+"' AND SZN.D_E_L_E_T_(+) = ' ' AND BAU_CODIGO = ZN_CODRDA(+) AND (ZN_VIGFIM(+) = ' ' OR ZN_VIGFIM(+) >= '"+cAnobase+cMesbase+"' )"

if !empty(mv_par03) 
    cquery += CRLF+"  AND BAU.BAU_GRPPAG IN "+cGrpRdas+" "
EndIf 
cquery += CRLF+" GROUP BY  BAU_GRPPAG, b16_descri , BAU_CODIGO ||' - ' ||nvl(trim(bau_nfanta), bau_nome) , BAU_CODRET, BD7_CODPEG , BD7_CODLDP ,bd7_numero , bd7_sequen , ZN_CODANA , ZN_NOMANA , bd7_codemp  "

cquery += CRLF+"  UNION ALL "       
    
cquery += CRLF+" SELECT '6' SEQ ,'Deb_Cred_Nao_faturado ' TIPO , BAU_GRPPAG||' - ' || b16_descri GRPPAG ,BAU_CODIGO  ||' - ' || nvl(trim(bau_nfanta), bau_nome) NOME, "
cquery += CRLF+" DECODE(TRIM(BAU_CODRET),'1708','P_JURIDICA','0588','P_FISICA','Nao Especificado') TPESSOA , "
cquery += CRLF+" SUM (DECODE(BGQ.BGQ_TIPO,'2',BGQ.BGQ_VALOR,(BGQ.BGQ_VALOR * -1))) VALOR_LOTE  ,count(*) qtda , "
cquery += CRLF+" ' ' PEG , ' ' LOCDIG  , ' ' numero ,' ' sequen , ' ' CODANA , ' ' NOMANA , "    

cquery += CRLF+"   CASE WHEN bgq_codemp = '0024' THEN 'Prefeitura' "
cquery += CRLF+"        WHEN bgq_codemp = '0025' THEN 'Prefeitura' "
cquery += CRLF+"        WHEN bgq_codemp = '0026' THEN 'Prefeitura' "            
cquery += CRLF+"        WHEN bgq_codemp = '0027' THEN 'Prefeitura' " 
cquery += CRLF+"        WHEN bgq_codemp = '0028' THEN 'Prefeitura' "
cquery += CRLF+"   Else 'Rede'  "
cquery += CRLF+"   End empresa  , "
cquery += CRLF+"   0 glosa , 0 apresent , 0 previa " 

cquery += CRLF+" FROM " + RetSqlName("Bgq")+" Bgq ," + RetSqlName("BAU")+" BAU ," + RetSqlName("B16")+" B16 WHERE Bgq_FILIAL = '"+xFilial("Bgq")+"' "
cquery += CRLF+" AND BGQ.D_E_L_E_T_ = ' ' AND BAU_FILIAL = '"+xFilial("BAU")+"' AND BAU.D_E_L_E_T_ = ' ' AND B16_FILIAL = '"+xFilial("B16")+"'AND B16.D_E_L_E_T_ = ' ' "    
cquery += CRLF+" AND BGQ.BGQ_ANO = '"+cAnobase+"' AND BGQ.BGQ_MES = '"+cMesbase+"' AND BGQ.BGQ_CODLAN <> '050' AND BGQ.BGQ_NUMLOT = ' ' "
cquery += CRLF+" AND BGQ.BGQ_CODIGO = BAU_CODIGO   AND BAU_GRPPAG = B16_CODIGO "
if !empty(mv_par03) 
    cquery += CRLF+"  AND BAU.BAU_GRPPAG IN "+cGrpRdas+" "
EndIf
cquery += CRLF+" GROUP BY BAU_GRPPAG, b16_descri ,BAU_CODIGO ||' - ' ||nvl(trim(bau_nfanta), bau_nome), BAU_CODRET , bgq_codemp"
    
cquery += CRLF+"  UNION ALL "
  
cquery += CRLF+"  SELECT '7' SEQ,'Deb_Cred_faturado ' TIPO , BAU_GRPPAG||' - ' || b16_descri GRPPAG ,BAU_CODIGO  ||' - ' ||  nvl(trim(bau_nfanta), bau_nome)  NOME, "
cquery += CRLF+" DECODE(TRIM(BAU_CODRET),'1708','P_JURIDICA','0588','P_FISICA','Nao Especificado') TPESSOA , "
cquery += CRLF+" SUM (DECODE(BGQ.BGQ_TIPO,'2',BGQ.BGQ_VALOR,(BGQ.BGQ_VALOR * -1))) VALOR_LOTE  ,count(*) qtda , 
cquery += CRLF+" ' ' PEG , ' ' LOCDIG  , ' ' numero ,' ' sequen , ' ' CODANA , ' ' NOMANA , "    

cquery += CRLF+"   CASE WHEN bgq_codemp = '0024' THEN 'Prefeitura' "
cquery += CRLF+"        WHEN bgq_codemp = '0025' THEN 'Prefeitura' "
cquery += CRLF+"        WHEN bgq_codemp = '0026' THEN 'Prefeitura' "            
cquery += CRLF+"        WHEN bgq_codemp = '0027' THEN 'Prefeitura' "
cquery += CRLF+"        WHEN bgq_codemp = '0028' THEN 'Prefeitura' "
cquery += CRLF+"   Else 'Rede'  "
cquery += CRLF+"   End empresa , "
cquery += CRLF+"   0 glosa , 0 apresent  , 0 Previa " 

cquery += CRLF+" FROM " + RetSqlName("Bgq")+" Bgq ," + RetSqlName("BAU")+" BAU ," + RetSqlName("B16")+" B16 WHERE Bgq_FILIAL = '"+xFilial("Bgq")+"' "
cquery += CRLF+" AND BGQ.D_E_L_E_T_ = ' ' AND BAU_FILIAL = '"+xFilial("BAU")+"' AND BAU.D_E_L_E_T_ = ' ' AND B16_FILIAL = '"+xFilial("B16")+"'AND B16.D_E_L_E_T_ = ' ' "    
cquery += CRLF+" AND BGQ.BGQ_ANO = '"+cAnobase+"' AND BGQ.BGQ_MES = '"+cMesbase+"' AND BGQ.BGQ_CODLAN <> '050' AND BGQ.BGQ_NUMLOT >= '"+cAnobase+cMesbase+"0001' AND BGQ.BGQ_NUMLOT <= '"+cAnobase+cMesbase+"9999'"
cquery += CRLF+" AND BGQ.BGQ_CODIGO = BAU_CODIGO   AND BAU_GRPPAG = B16_CODIGO  "
if !empty(mv_par03) 
    cquery += CRLF+"  AND BAU.BAU_GRPPAG IN "+cGrpRdas+" "
EndIf
cquery += CRLF+" GROUP BY BAU_GRPPAG, b16_descri ,BAU_CODIGO ||' - ' ||nvl(trim(bau_nfanta), bau_nome), BAU_CODRET , bgq_codemp "

cquery += CRLF+"  UNION ALL "                                                                      

cquery += CRLF+"  SELECT '8' SEQ,'Prev/Protocolo  ' TIPO , BAU_GRPPAG||' - ' || b16_descri GRPPAG ,BAU_CODIGO ||' - ' ||nvl(trim(bau_nfanta), bau_nome)  NOME, "
cquery += CRLF+"  DECODE(TRIM(BAU_CODRET),'1708','P_JURIDICA','0588','P_FISICA','Nao Especificado') TPESSOA , "
cquery += CRLF+"   0 VALOR_LOTE  ,count(*) qtda , 
cquery += CRLF+" ' ' PEG , ' ' LOCDIG  ,  ' ' numero ,' ' sequen , ' ' CODANA , ' ' NOMANA , "        

cquery += CRLF+"   CASE WHEN ZZP_TIPREM = '3' THEN 'Prefeitura' "            
cquery += CRLF+"   Else 'Rede'  "
cquery += CRLF+"   End empresa ,"
cquery += CRLF+"   0 glosa , 0 apresent ,  (SUM(ZZP_VLINHO) + SUM(ZZP_VLINAM)+ SUM(ZZP_VLINOD)) Previa " 

cquery += CRLF+" FROM " + RetSqlName("ZZP")+" ZZP ," + RetSqlName("BAU")+" BAU ," + RetSqlName("B16")+" B16 WHERE ZZP_FILIAL = '"+xFilial("ZZP")+"' "
cquery += CRLF+" AND ZZP.D_E_L_E_T_ = ' ' AND BAU_FILIAL = '"+xFilial("BAU")+"' AND BAU.D_E_L_E_T_ = ' ' AND B16_FILIAL = '"+xFilial("B16")+"'AND B16.D_E_L_E_T_ = ' ' "    
cquery += CRLF+" AND ZZP.ZZP_ANOPAG = '"+cAnobase+"' AND ZZP.ZZP_MESPAG = '"+cMesbase+"' "
cquery += CRLF+" AND ZZP.ZZP_CODRDA  = BAU_CODIGO   AND BAU_GRPPAG = B16_CODIGO  "
if !empty(mv_par03) 
    cquery += CRLF+"  AND BAU.BAU_GRPPAG IN "+cGrpRdas+" "
EndIf
cquery += CRLF+" GROUP BY BAU_GRPPAG, b16_descri ,BAU_CODIGO ||' - ' ||nvl(trim(bau_nfanta), bau_nome), BAU_CODRET , ZZP_TIPREM " 

cquery += CRLF+" ) TAB "   

If !lsintet
    cquery += CRLF+" GROUP BY TAB.GRPPAG , TAB.NOME , TAB.TPESSOA "
    if lGerenc 
       cquery += " , TAB.PEG , TAB.LOCDIG , TAB.numero , TAB.sequen , TAB.CODANA , TAB.NOMANA " "
    EndIf 
    If nClasEmp == 1 
       cquery += " , TAB.Empresa "
    endIf                               
    If mv_par07 = 1 
       cquery += CRLF+" ORDER BY TAB.GRPPAG  ,  TAB.NOME   "
    Else                                                    
       cquery += CRLF+" ORDER BY TAB.GRPPAG  ,  TAB.NOME   "
    EndIf

Else  
    cquery += CRLF+" GROUP BY TAB.GRPPAG  "      
    If nClasEmp == 1 
       cquery += " , TAB.Empresa "
    endIf                                 
    cquery += CRLF+" ORDER BY TAB.GRPPAG  "
EndIf 




////////////////////////////////////////       
	   	
    TCQuery cQuery New Alias (cAliastmp)
      
    dbSelectArea (cAliastmp)
   
    (cAliastmp)->(dbGoTop())   
     
    While (cAliastmp)->(!Eof())   
    nTotQtda := (cAliastmp)->qFATURADA +(cAliastmp)->qATVPRT35 + (cAliastmp)->qATVPRONT +(cAliastmp)->qCONFEREN + (cAliastmp)->DIGITACA 
    If nClasEmp == 1 
       cEmpresa:= (cAliastmp)->Empresa 
    Else    
       cEmpresa:= ' ' 
    EndIf      
    if !lsintet 
       If !lGerenc 
           aaDD(aDados2,{(cAliastmp)->GRPPAG           ,;      
                  (cAliastmp)->NOME                    ,;      
                  (cAliastmp)->TPESSOA                 ,;                 
                  (cAliastmp)->FATURADA                ,;         
                  (cAliastmp)->qFATURADA               ,;          
                  (((cAliastmp)->qFATURADA * 100) / nTotQtda) ,;      
                  (cAliastmp)->ATVPRT35                ,;            
                  (cAliastmp)->qATVPRT35               ,;             
                  (((cAliastmp)->qATVPRT35 * 100) / nTotQtda) ,;        
                  (cAliastmp)->ATVPRONT                ,;              
                  (cAliastmp)->qATVPRONT               ,;              
                  (((cAliastmp)->qATVPRONT * 100) / nTotQtda) ,;                        
                  (cAliastmp)->CONFEREN                ,;                   
                  (cAliastmp)->qCONFEREN               ,;                     
                  (((cAliastmp)->qCONFEREN * 100) / nTotQtda) ,;                        
                  (cAliastmp)->DIGITACA                ,;                         
                  (((cAliastmp)->DIGITACA * 100) / nTotQtda)  ,;                       
                  (cAliastmp)->DBCRENFA                ,;                             
                  (cAliastmp)->DBCREFAT                ,;                               
                   nTotQtda                            ,;
                   cEmpresa })                                 
       Else                                   
           aaDD(aDados2,{(cAliastmp)->GRPPAG           ,;      
                  (cAliastmp)->NOME                    ,;      
                  (cAliastmp)->TPESSOA                 ,;                  
                  (cAliastmp)->PEG                     ,;                 
                  (cAliastmp)->LOCDIG                  ,;                       
                  (cAliastmp)->numero                  ,;
                  (cAliastmp)->sequen                  ,;
                  (cAliastmp)->CODANA +" - "+(cAliastmp)->NOMANA  ,;                  
                  (cAliastmp)->FATURADA                ,;         
                  (cAliastmp)->qFATURADA               ,;          
                  (((cAliastmp)->qFATURADA * 100) / nTotQtda) ,;      
                  (cAliastmp)->ATVPRT35                ,;            
                  (cAliastmp)->qATVPRT35               ,;             
                  (((cAliastmp)->qATVPRT35 * 100) / nTotQtda) ,;        
                  (cAliastmp)->ATVPRONT                ,;              
                  (cAliastmp)->qATVPRONT               ,;              
                  (((cAliastmp)->qATVPRONT * 100) / nTotQtda) ,;                        
                  (cAliastmp)->CONFEREN                ,;                   
                  (cAliastmp)->qCONFEREN               ,;                     
                  (((cAliastmp)->qCONFEREN * 100) / nTotQtda) ,;                        
                  (cAliastmp)->DIGITACA                ,;                         
                  (((cAliastmp)->DIGITACA * 100) / nTotQtda)  ,;                       
                  (cAliastmp)->DBCRENFA                ,;                             
                  (cAliastmp)->DBCREFAT                ,;                               
                   nTotQtda                            ,;
                   cEmpresa })                
       EndIf           
                  if (cAliastmp)->FATURADA != 0
                     cFATURADA ++         
                  EndIf       
                  If (cAliastmp)->ATVPRT35 != 0          
                     cATVPRT35 ++    
                  EndIf   
                  If (cAliastmp)->ATVPRONT != 0               
                     cATVPRONT ++
                  EndIf
                  If (cAliastmp)->CONFEREN != 0 
                     cCONFEREN ++
                  EndIf
                  If(cAliastmp)->DIGITACA  != 0
                     cDIGITACA ++
                  EndIf
                  If(cAliastmp)->DBCRENFA  != 0 
                     cDBCRENFA ++
                  EndIf
                  If(cAliastmp)->DBCREFAT  != 0     
                     cDBCREFAT ++
                  EndIf
    Else                    
        aaDD(aDados1,{(cAliastmp)->GRPPAG              ,;
                  (cAliastmp)->FATURADA                ,;  
                  (cAliastmp)->qFATURADA               ,;        
                   (((cAliastmp)->qFATURADA * 100) / nTotQtda) ,;   
                  (cAliastmp)->ATVPRT35                ,; 
                  (cAliastmp)->qATVPRT35               ,;        
                   (((cAliastmp)->qATVPRT35 * 100) / nTotQtda) ,;  
                  (cAliastmp)->ATVPRONT                ,; 
                  (cAliastmp)->qATVPRONT               ,;         
                   (((cAliastmp)->qATVPRONT * 100) / nTotQtda) ,;                    
                  (cAliastmp)->CONFEREN                ,; 
                  (cAliastmp)->qCONFEREN               ,;
                   (((cAliastmp)->qCONFEREN * 100) / nTotQtda) ,;                                      
                  (cAliastmp)->DIGITACA                ,; 
                   (((cAliastmp)->DIGITACA * 100) / nTotQtda)  ,;                                     
                  (cAliastmp)->DBCRENFA                ,; 
                  (cAliastmp)->DBCREFAT                ,;
                   nTotQtda                            ,;
                   cEmpresa})   
    EndIf            

       (cAliastmp)->(dbSkip()) 	   
    EndDo	                   
 
Return    

*************************************************************************************************************  
Static Function fGeraRel2

Local oReport 
Private cPerg		:= "CABR135"                                                           ¦

Private aOrdem 		:= {}//{'RDA','Ano/Mes'}            
Private lTPageBreak := .T.         


//aSort( aDados1,,,{|x,y| x[10] < y[10]} )

oReport:= ReportDef2()
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

Static Function ReportDef2()

Local oReport 
Local oDPJ        
Local oDPJ1                
oReport	:= TReport():New("CABR135","Listagem de Saldos dos RDAs - por Competencia de Faturamento - "+cMesbase+"/"+cAnobase  ,, {|oReport| ReportPrt(oReport)},"Listagem de Saldos dos RDAs - por Competencia de Faturamento -  " +cMesbase+"/"+cAnobase )
oReport:SetTotalInLine(.F.)//Imprime na linha: .F. - Imprime abaixo da linha com o titulo de cada coluna: .T.
//oReport:SetTotalText('Total Geral') 

*'-----------------------------------------------------------------------------------'*
*'Solucao para impressao em que as colunas se truncam: "SetColSpace" e "SetLandScape"'* 
*'-----------------------------------------------------------------------------------'*

oReport:SetColSpace(1) //Espacamento entre colunas. 
oReport:SetLandscape() //Impressao em paisagem.  
//oReport:SetPortrait() //Impressao em retrato.  

oReport:SetTotalPageBreak(lTPageBreak)

oDPJ := TRSection():New(oReport,"Listagem de Saldos dos RDAs - por Competencia de Faturamento - Sintetico " ,,aOrdem)              

   TRCell():New(oDPJ ,'GRPPAG'	        		,	,'Grupo Pagto    '      ,   	             ,40		,,,,,"LEFT"		) 
   TRCell():New(oDPJ ,'FATURADA'         		,	,'Faturada       '      ,"@E 99,999,999.99"  ,13     	,,,,,"RIGHT"	) 
   TRCell():New(oDPJ ,'qFATURADA'         		,	,'Qtda '                ,"@E 9999,999"       ,08     	,,,,,"RIGHT"	)  
   TRCell():New(oDPJ ,'%FATURADA'         		,	,' % '                  ,"@E 999,99"         ,06     	,,,,,"RIGHT"	) 
   TRCell():New(oDPJ ,'CONF35'	     	        ,	,'Conferida 3.5  '      ,"@E 99,999,999.99"  ,13	  	,,,,,"RIGHT"	)   
   TRCell():New(oDPJ ,'qCONF35'	     	        ,	,'Qtda '                ,"@E 9999,999"       ,08	  	,,,,,"RIGHT"	) 
   TRCell():New(oDPJ ,'%CONF35'         		,	,' % '                  ,"@E 999,99"         ,06     	,,,,,"RIGHT"	)  
   TRCell():New(oDPJ ,'CONFS35'		            ,	,'Conferida S/3.5'      ,"@E 99,999,999.99"  ,13	  	,,,,,"RIGHT"	)   
   TRCell():New(oDPJ ,'qCONFS35'		        ,	,'Qtda '                ,"@E 9999,999"       ,08	  	,,,,,"RIGHT"	)  
   TRCell():New(oDPJ ,'%CONFS35'         		,	,' % '                  ,"@E 999,99"         ,06     	,,,,,"RIGHT"	)     
   TRCell():New(oDPJ ,'EMCONF'	      	        ,	,'Em Conferencia '      ,"@E 99,999,999.99"  ,13	  	,,,,,"RIGHT"	)    
   TRCell():New(oDPJ ,'qEMCONF'	      	        ,	,'Qtda '                ,"@E 9999,999"       ,08	  	,,,,,"RIGHT"	)   
   TRCell():New(oDPJ ,'%EMCONF'         		,	,' % '                  ,"@E 999,99"         ,06     	,,,,,"RIGHT"	)   
   TRCell():New(oDPJ ,'EMDIG'	      	        ,	,'Em Digitação   '      ,"@E 9999,999"       ,08	  	,,,,,"RIGHT"	)   
   TRCell():New(oDPJ ,'%EMDIG'           		,	,' % '                  ,"@E 999,99"         ,06     	,,,,,"RIGHT"	)  
   TRCell():New(oDPJ ,'DBCRDFAT'	      	    ,	,'Deb/Cred Fat   '      ,"@E 99,999,999.99"  ,13     	,,,,,"RIGHT"	)   
   TRCell():New(oDPJ ,'DBCRDNFA'	      	    ,	,'Deb/Cred NaoFat'      ,"@E 99,999,999.99"  ,13     	,,,,,"RIGHT"	)   
   TRCell():New(oDPJ ,'TOTGUIA'	         	    ,	,'tot. Guias'           ,"@E 9999,999"       ,08     	,,,,,"RIGHT"	)

oBreak   		:= TRBreak():New(oDPJ,oDPJ:Cell("GRPPAG"),"Total por Grupo"	,.F.)       


lTotSecBrk	:= .F.//Indica se totalizador sera impresso na quebra de secao
lTotFimBrk	:= .F.//Indica se totalizador sera impresso no final do relatorio - Como o total eh o mesmo, basta que apenas um esteja ativado
                                                                   
TRFunction():New(oDPJ:Cell("FATURADA") 		,NIL,"SUM"			,oBreak,,"@E 999,999,999.99"	, 	,lTotSecBrk,lTotFimBrk)  
TRFunction():New(oDPJ:Cell("qFATURADA") 	,NIL,"SUM"			,oBreak,,"@E 9999,999"	        , 	,lTotSecBrk,lTotFimBrk)
TRFunction():New(oDPJ:Cell("CONF35")  		,NIL,"SUM"			,oBreak,,"@E 999,999,999.99"	, 	,lTotSecBrk,lTotFimBrk)   
TRFunction():New(oDPJ:Cell("qCONF35")  		,NIL,"SUM"			,oBreak,,"@E 9999,999"	        , 	,lTotSecBrk,lTotFimBrk)  
TRFunction():New(oDPJ:Cell("CONFS35")  		,NIL,"SUM"			,oBreak,,"@E 999,999,999.99"	, 	,lTotSecBrk,lTotFimBrk)  
TRFunction():New(oDPJ:Cell("qCONFS35")  	,NIL,"SUM"			,oBreak,,"@E 9999,999"	        , 	,lTotSecBrk,lTotFimBrk) 
TRFunction():New(oDPJ:Cell("EMCONF") 		,NIL,"SUM"			,oBreak,,"@E 999,999,999.99"	, 	,lTotSecBrk,lTotFimBrk)   
TRFunction():New(oDPJ:Cell("qEMCONF") 		,NIL,"SUM"			,oBreak,,"@E 9999,999"	        , 	,lTotSecBrk,lTotFimBrk)  
TRFunction():New(oDPJ:Cell("EMDIG")  		,NIL,"SUM"			,oBreak,,"@E 99,999,999"     	, 	,lTotSecBrk,lTotFimBrk)  
TRFunction():New(oDPJ:Cell("DBCRDFAT") 		,NIL,"SUM"			,oBreak,,"@E 999,999,999.99"	, 	,lTotSecBrk,lTotFimBrk)  
TRFunction():New(oDPJ:Cell("DBCRDNFA") 		,NIL,"SUM"			,oBreak,,"@E 999,999,999.99"	, 	,lTotSecBrk,lTotFimBrk)   

//TRFunction():New(oDPJ:Cell("%FATURADA") 	,NIL,,oBreak,,"@E 9999,999"	        ,{||oDPJ:Cell("FATURADA"):GetValue()},lTotSecBrk,lTotFimBrk) 
 
TRFunction():New(oDPJ:Cell("TOTGUIA") 		,NIL,"SUM"			,oBreak,,"@E 9999,999"	        , 	,lTotSecBrk,lTotFimBrk)  
  
  
  
**********************  
  
                                                                                                                         
oDPJ1 := TRSection():New(oReport,"Listagem de Saldos dos RDAs - por Competencia de Faturamento - Analitico " ,,aOrdem)    

   TRCell():New(oDPJ1 ,'GRPPAG'	         		,	,'Grupo Pagto    '      ,   	             ,50		,,,,,"LEFT"		) 
   TRCell():New(oDPJ1 ,'NOME'	         		,	,'Nome Rda       '      ,   	             ,50		,,,,,"LEFT"		) 
   TRCell():New(oDPJ1 ,'TPESSOA'	    		,	,'Tpessoa        '      ,   	             ,15		,,,,,"LEFT"		) 
   TRCell():New(oDPJ1 ,'CODPEG'	    	    	,	,'Cod. Peg       '      ,   	             ,(TamSX3("BD7_CODPEG")[1])+(TamSX3("BD7_CODLDP")[1])	,,,,,"LEFT"		) 
   TRCell():New(oDPJ1 ,'FATURADA'	     	    ,	,'Faturada       '      ,"@E 99,999,999.99"  ,13	  	,,,,,"RIGHT"	)   
   TRCell():New(oDPJ1 ,'qFATURADA'         		,	,'Qtda '                ,"@E 9999,999"       ,08     	,,,,,"RIGHT"	)  
   TRCell():New(oDPJ1 ,'%FATURADA'         		,	,' % '                  ,"@E 999,99"         ,06     	,,,,,"RIGHT"	) 
   TRCell():New(oDPJ1 ,'CONF35'	     	        ,	,'Conferida 3.5  '      ,"@E 99,999,999.99"  ,13	  	,,,,,"RIGHT"	)   
   TRCell():New(oDPJ1 ,'qCONF35'	     	    ,	,'Qtda '                ,"@E 9999,999"       ,08	  	,,,,,"RIGHT"	) 
   TRCell():New(oDPJ1 ,'%CONF35'         		,	,' % '                  ,"@E 999,99"         ,06     	,,,,,"RIGHT"	)  
   TRCell():New(oDPJ1 ,'CONFS35'		        ,	,'Conferida S/3.5'      ,"@E 99,999,999.99"  ,13	  	,,,,,"RIGHT"	)   
   TRCell():New(oDPJ1 ,'qCONFS35'		        ,	,'Qtda '                ,"@E 9999,999"       ,08	  	,,,,,"RIGHT"	)  
   TRCell():New(oDPJ1 ,'%CONFS35'         		,	,' % '                  ,"@E 999,99"         ,06     	,,,,,"RIGHT"	)     
   TRCell():New(oDPJ1 ,'EMCONF'	      	        ,	,'Em Conferencia '      ,"@E 99,999,999.99"  ,13	  	,,,,,"RIGHT"	)    
   TRCell():New(oDPJ1 ,'qEMCONF'	      	    ,	,'Qtda '                ,"@E 9999,999"       ,08	  	,,,,,"RIGHT"	)   
   TRCell():New(oDPJ1 ,'%EMCONF'         		,	,' % '                  ,"@E 999,99"         ,06     	,,,,,"RIGHT"	)   
   TRCell():New(oDPJ1 ,'EMDIG'	      	        ,	,'Em Digitação   '      ,"@E 9999,999"       ,08	  	,,,,,"RIGHT"	)   
   TRCell():New(oDPJ1 ,'%EMDIG'           		,	,' % '                  ,"@E 999,99"         ,06     	,,,,,"RIGHT"	)  
   TRCell():New(oDPJ1 ,'DBCRDFAT'	      	    ,	,'Deb/Cred Fat   '      ,"@E 99,999,999.99"  ,13     	,,,,,"RIGHT"	)   
   TRCell():New(oDPJ1 ,'DBCRDNFA'	      	    ,	,'Deb/Cred NaoFat'      ,"@E 99,999,999.99"  ,13     	,,,,,"RIGHT"	)   
   TRCell():New(oDPJ1 ,'TOTGUIA'	         	,	,'tot. Guias'           ,"@E 9999,999"       ,08     	,,,,,"RIGHT"	)

  
   
oBreak01   		:= TRBreak():New(oDPJ1,oDPJ1:Cell("GRPPAG"),"Total Por Grupo de Pagamento  "	,.F.)  

lTotSecBrk01	:= .F.//Indica se totalizador sera impresso na quebra de secao
lTotFimBrk01	:= .F.//Indica se totalizador sera impresso no final do relatorio - Como o total eh o mesmo, basta que apenas um esteja ativado
                                      
TRFunction():New(oDPJ1:Cell("FATURADA") 		,NIL,"SUM"			,oBreak,,"@E 999,999,999.99"	, 	,lTotSecBrk,lTotFimBrk)  
TRFunction():New(oDPJ1:Cell("qFATURADA") 		,NIL,"SUM"			,oBreak,,"@E 9999,999"	        , 	,lTotSecBrk,lTotFimBrk)
TRFunction():New(oDPJ1:Cell("CONF35")  			,NIL,"SUM"			,oBreak,,"@E 999,999,999.99"	, 	,lTotSecBrk,lTotFimBrk)   
TRFunction():New(oDPJ1:Cell("qCONF35")  		,NIL,"SUM"			,oBreak,,"@E 9999,999"	        , 	,lTotSecBrk,lTotFimBrk)  
TRFunction():New(oDPJ1:Cell("CONFS35")  		,NIL,"SUM"			,oBreak,,"@E 999,999,999.99"	, 	,lTotSecBrk,lTotFimBrk)  
TRFunction():New(oDPJ1:Cell("qCONFS35")  		,NIL,"SUM"			,oBreak,,"@E 9999,999"	        , 	,lTotSecBrk,lTotFimBrk) 
TRFunction():New(oDPJ1:Cell("EMCONF") 			,NIL,"SUM"			,oBreak,,"@E 999,999,999.99"	, 	,lTotSecBrk,lTotFimBrk)   
TRFunction():New(oDPJ1:Cell("qEMCONF") 			,NIL,"SUM"			,oBreak,,"@E 9999,999"	        , 	,lTotSecBrk,lTotFimBrk)  
TRFunction():New(oDPJ1:Cell("EMDIG")  		    ,NIL,"SUM"			,oBreak,,"@E 99,999,999"     	, 	,lTotSecBrk,lTotFimBrk)  
TRFunction():New(oDPJ1:Cell("DBCRDFAT") 		,NIL,"SUM"			,oBreak,,"@E 999,999,999.99"	, 	,lTotSecBrk,lTotFimBrk)  
TRFunction():New(oDPJ1:Cell("DBCRDNFA") 		,NIL,"SUM"			,oBreak,,"@E 999,999,999.99"	, 	,lTotSecBrk,lTotFimBrk)   

//TRFunction():New(oDPJ:Cell("%FATURADA") 	,NIL,,oBreak,,"@E 9999,999"	        ,{||oDPJ:Cell("FATURADA"):GetValue()},lTotSecBrk,lTotFimBrk) 
 
TRFunction():New(oDPJ1:Cell("TOTGUIA") 			,NIL,"SUM"			,oBreak,,"@E 9999,999"	        , 	,lTotSecBrk,lTotFimBrk)  
                                                                     

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
Private oDPJ1 	:= oReport:Section(2)

Private nCont	:= 0   

nCont := Len(aDados1)

//Se nao tiver esta linha, nao imprime os dados     
If !lsintet
  oDPJ1:init()         
  nCont := Len(aDados2)
Else          
  oDPJ:init()
  nCont := Len(aDados1)
EndIf
oReport:SetMeter(nCont) 

cTot	:= AllTrim(Transform(nCont,'@E 999,999,999,999'))
nCont 	:= 0       
If lsintet
   For i := 1 To Len(aDados1)

    oReport:SetMsgPrint("Imprimindo linha " + AllTrim(Transform(++nCont,'@E 999,999,999,999')) + ' de ' + cTot)

	oReport:IncMeter()

	If oReport:Cancel()  
	    
	    oReport:FatLine()     
	    oReport:PrintText('Cancelado pelo operador!!!',,,CLR_RED,,,.T.)
		
	    exit
	    
	EndIf          

       oDPJ:Cell('GRPPAG'	 		):SetValue((aDados1[i][1]))     
       oDPJ:Cell('FATURADA'   		):SetValue((aDados1[i][2]))  
       oDPJ:Cell('qFATURADA'   		):SetValue((aDados1[i][3])) 
       oDPJ:Cell('%FATURADA'   		):SetValue((aDados1[i][4]))
       oDPJ:Cell('CONF35'	  		):SetValue((aDados1[i][5]))        
       oDPJ:Cell('qCONF35'	  		):SetValue((aDados1[i][6]))        
       oDPJ:Cell('%CONF35'	  		):SetValue((aDados1[i][7]))       
       oDPJ:Cell('CONFS35'	    	):SetValue((aDados1[i][8]))    
       oDPJ:Cell('qCONFS35'	    	):SetValue((aDados1[i][9]))   
       oDPJ:Cell('%CONFS35'	    	):SetValue((aDados1[i][10]))   
       oDPJ:Cell('EMCONF'	        ):SetValue((aDados1[i][11])) 
       oDPJ:Cell('qEMCONF'	        ):SetValue((aDados1[i][12])) 
       oDPJ:Cell('%EMCONF'	        ):SetValue((aDados1[i][13]))
       oDPJ:Cell('EMDIG'	 		):SetValue((aDados1[i][14]))      
       oDPJ:Cell('%EMDIG'	 		):SetValue((aDados1[i][15]))     
       oDPJ:Cell('DBCRDFAT'	 		):SetValue((aDados1[i][16]))  
       oDPJ:Cell('DBCRDNFA'	 		):SetValue((aDados1[i][17]))  
       oDPJ:Cell('TOTGUIA'	        ):SetValue((aDados1[i][18]))  
           
  	  
       
       oDPJ:PrintLine()
   
   Next i

   oDPJ:Finish()      

Else    
   For i := 1 To Len(aDados2)

    oReport:SetMsgPrint("Imprimindo linha " + AllTrim(Transform(++nCont,'@E 999,999,999,999')) + ' de ' + cTot)

	oReport:IncMeter()

	If oReport:Cancel()  
	    
	    oReport:FatLine()     
	    oReport:PrintText('Cancelado pelo operador!!!',,,CLR_RED,,,.T.)
		
	    exit
	    
	EndIf          

       oDPJ1:Cell('GRPPAG'	 		):SetValue((aDados2[i][1]))  
       oDPJ1:Cell('NOME'	 	    ):SetValue((aDados2[i][2]))     
       oDPJ1:Cell('TPESSOA'	 	    ):SetValue((aDados2[i][3]))  
       oDPJ1:Cell('FATURADA'   	    ):SetValue((aDados2[i][4]))   
       oDPJ1:Cell('qFATURADA'   	):SetValue((aDados2[i][5]))   
       oDPJ1:Cell('%FATURADA'   	):SetValue((aDados2[i][6]))  
       oDPJ1:Cell('CONF35'	     	):SetValue((aDados2[i][7]))        
       oDPJ1:Cell('qCONF35'	        ):SetValue((aDados2[i][8]))       
       oDPJ1:Cell('%CONF35'	        ):SetValue((aDados2[i][9]))       
       oDPJ1:Cell('CONFS35'	     	):SetValue((aDados2[i][10]))    
       oDPJ1:Cell('qCONFS35'	   	):SetValue((aDados2[i][11]))    
       oDPJ1:Cell('%CONFS35'	   	):SetValue((aDados2[i][12]))   
       oDPJ1:Cell('EMCONF'	        ):SetValue((aDados2[i][13])) 
       oDPJ1:Cell('qEMCONF'	        ):SetValue((aDados2[i][14]))
       oDPJ1:Cell('%EMCONF'	        ):SetValue((aDados2[i][15]))
       oDPJ1:Cell('EMDIG'	    	):SetValue((aDados2[i][16]))     
       oDPJ1:Cell('%EMDIG'	    	):SetValue((aDados2[i][17]))     
       oDPJ1:Cell('DBCRDFAT'	    ):SetValue((aDados2[i][18]))  
       oDPJ1:Cell('DBCRDNFA'		):SetValue((aDados2[i][19])) 
       oDPJ:Cell('TOTGUIA'	        ):SetValue((aDados1[i][20]))   	  

       oDPJ1:PrintLine()
   
   Next i

   oDPJ1:Finish()      
EndIf
*********************************************************************************


Return  
*********************************************************************************


Static Function AjustaSX1(cPerg)

Local aHelpPor := {}

PutSx1(cPerg,"01",OemToAnsi("Mes Compet Entrega ") 		      ,"","","mv_ch1","C",02,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","","",{},{})
PutSx1(cPerg,"02",OemToAnsi("Ano Compet Entrega ") 		      ,"","","mv_ch2","C",04,0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","","",{},{})    
PutSx1(cPerg,"03",OemToAnsi("Grupos pagto Rdas ")            ,"","","mv_ch3","C",99,0,0,"G","","","","","mv_par03","","","","","","","","","","","","","","","","","",{},{})    
PutSx1(cPerg,"04",OemToAnsi("Procedimento De  ") 	     	  ,"","","mv_ch4","D",08,0,0,"G","","","","","mv_par04","","","","","","","","","","","","","","","","","",{},{})
PutSx1(cPerg,"05",OemToAnsi("Procedimento Ate ") 		      ,"","","mv_ch5","D",08,0,0,"G","","","","","mv_par05","","","","","","","","","","","","","","","","","",{},{})       
PutSx1(cPerg,"06",OemToAnsi("Listagem  ")                    ,"","","mv_ch6","N",01,0,0,"C","","","","","mv_par06","Sintetica","","","","Analitica","","","","","","","","","","","",{},{},{}) 
PutSx1(cPerg,"07",OemToAnsi("Ordernar  ")                    ,"","","mv_ch7","N",01,0,0,"C","","","","","mv_par07","Grupo/Rda","","","","Rda/Grupo","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"08",OemToAnsi("Gerar Excel ")                  ,"","","mv_ch8","N",01,0,0,"C","","","","","mv_par08","Sim","","","","Não","","","","","","","","","","","",{},{},{})  
PutSx1(cPerg,"09",OemToAnsi("Gerar Gerencial ")              ,"","","mv_ch9","N",01,0,0,"C","","","","","mv_par09","Sim","","","","Não","","","","","","","","","","","",{},{},{})  
PutSx1(cPerg,"10",OemToAnsi("Referencia ")                   ,"","","mv_ch10","N",01,0,0,"C","","","","","mv_par10","Comp.Entrada","","","","Comp.Pagto","","","","","","","","","","","",{},{},{})  
PutSx1(cPerg,"11",OemToAnsi("Com Recurso de Glosa ")         ,"","","mv_ch11","N",01,0,0,"C","","","","","mv_par11","Sim ","","","","Não","","","","","","","","","","","",{},{},{})  
PutSx1(cPerg,"12",OemToAnsi("Listar Só Convenio de Recip.")  ,"","","mv_ch12","N",01,0,0,"C","","","","","mv_par12","Sim ","","","","Não","","","","","","","","","","","",{},{},{})  

PutSx1(cPerg,"13","Contrato de:  "  ,"","","mv_ch13","C",12,0,0,"C","","","","","mv_par13","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"14","Contrato ate:  "  ,"","","mv_ch14","C",12,0,0,"C","","","","","mv_par14","","","","","","","","","","","","","","","","",{},{},{})

PutSx1(cPerg,"15",OemToAnsi("Classif. Empressas ")                   ,"","","mv_ch15","N",01,0,0,"C","","","","","mv_par15","Sim","","","","Não","","","","","","","","","","","",{},{},{})  

Pergunte(cPerg,.F.)

Return

