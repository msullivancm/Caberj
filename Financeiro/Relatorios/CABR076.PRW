#INCLUDE "PROTHEUS.CH"
#Include "TOPCONN.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABR076   º Autor ³Altamiro              º Data ³ 01/10/12  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Rotina para importacao e Critica de NF carioca             º±±
±±º          ³ conforme arquivo importado do site da receita municipal    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/                  

User Function CABR076

Local cMsg			:= ""
Private lAbortPrint :=.F.
Private cPerg       := "CABR076"
Private cTitulo     := "Critica Guias de convenios Não cobradas "
                                                                         
//SetPrvt("oDlg1","oGrp1","oSay1","oSBtn1","oSBtn2","oSBtn3")

cMsg += " Este programa ira listar a critica de guias de reciprocidade sem  " + CRLF
cMsg += " numero de titulos de cobranca na tabela BD6 , assim caracterizando" + CRLF
cMsg += " a não cobrança da reciprocidade                                   " + CRLF

***************************************************************************    
 
Private  aDados1     := {}       
Private  aDados2     := {} 
Private  aDados3     := {} 
Private  acabec1    :={"Ano/mes Comp","Operara usuario", "Usuaruio" ,  "Operara Origem ","Vlr Pagto Rda","Loc Digit","Num Peg " , "Num Guia", ;
                        "Sequenc" , "Contrato Empressa ","Bloqueado Pgto ","Bloqueado Participação ","Dt Bloq. Usuario" ,"Mes/Ano base" , ;
                        "dt.Digit" , "Dt.Pagto", "Dt.Proced", "Clone","Vlr.Taxa" ,  "Vlr.Copart"  , "Vlr.Tot.Copart" , 'Ope. Pagto', ; 
                        "Loc. Dig. Pagto" , "Num. PEG Pagto" , "Num. Guia Pagto" , "Sequen. Pagto" , "Mov. Orig. Pagto" , "Vlr Glosa " ,"Vlr Pagto" , "Projeto" }
   	  
AjustaSX1(cPerg)               

Pergunte(cPerg,.T.) 

cMesCompI   := mv_par01
cAnoCompI	:= mv_par02   
cMesCompF   := mv_par03
cAnoCompF	:= mv_par04 
cContInc    := mv_par05
cContFin    := mv_par06
nGExcel     := mv_par07
nSint       := mv_par08     
nAnalG      := mv_par09     
nAnalO      := mv_par10     
nFase       := mv_par11    

cEmpresa    := Iif(cEmpAnt == '01','C','I') 
  
Processa({||Processa1()}, cTitulo, "", .T.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Libera impressao                                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
   
// faz ecxel 
 if nSint == 1
    DlgToExcel({{"ARRAY","Guias Não Cobradas " ,aCabec1,aDados1}})   
 EndIF
 if nAnalG == 1    
    DlgToExcel({{"ARRAY","Guias Não Cobradas " ,aCabec1,aDados2}})
 EndIf
 if nAnalO == 1
    DlgToExcel({{"ARRAY","Opme Não Cobradas " ,aCabec1,aDados3}})
 EndIf
///
 if nSint == 1
    fGeraRel2()    
 EndIf
 if nAnalG == 1    
    fGeraRel1()   
 EndIf         
  if nAnalO == 1   
    fGeraRel3()   
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

   	IncProc('Processando...')            
 /////////////////////////////////////////
 if nSint == 1
 
cquery := "SELECT '1', '--->> Guias <<---' tipo " 
cquery += " ,BD6F.bd6_prefix || BD6F.bd6_numtit  ||bd6f.bd6_parcel || BD6F.bd6_tiptit  titulo "
cquery += " ,Sum(BD6F.BD6_VLRGLO) Glosado "
cquery += " ,Sum(BD7F.VLRPAG)  Vl_Aprov, "
// mbc cquery += " sum(Decode(BD6F.BD6_BLOCPA,'1',0,Decode(Sign(BD6F.BD6_VLRTPF),-1,0,Decode(BD6_CODEMP,'0004',0,'0009',0,BD6F.BD6_VLRTPF)))) Vl_Participacao, " 
cquery += " sum(Decode(BD6F.BD6_BLOCPA,'1',0,decode(BD6_CONCOB,'0',0,Decode(Sign(BD6F.BD6_VLRTPF),-1,0,Decode(BD6_CODEMP,'0004',0,'0009',0,BD6F.BD6_VLRTPF))))) Vl_Participacao, " 
cquery += " BD6_CONEMP||'-'||RETORNA_DESC_CONTRATO('C',BD6_OPEUSR,BD6_CODEMP,BD6_CONEMP) CONTRATO , substr (BD7F.BD7_NUMLOT,1,6) compt " 
//cquery += " BD6_Anopag||BD6_MESPAG COMPETENCIA_COB" 
cquery += " FROM (SELECT BD7.BD7_FILIAL,BD7_CODPLA,SIGA_TIPO_EXPOSICAO_ANS(BD7_CODEMP,BD7_MATRIC,BD7_TIPREG,To_Date(Trim(BD7_DATPRO),'YYYYMMDD')) EXPOS," 
cquery += " BD7.BD7_OPELOT,BD7.BD7_NUMLOT, BD7.BD7_CODOPE, BD7.BD7_CODLDP, BD7.BD7_CODPEG, BD7.BD7_NUMERO, BD7.BD7_ORIMOV, BD7_CODPRO," 
cquery += " BD7.BD7_SEQUEN,  Sum(BD7.BD7_VLRPAG) AS VLRPAG,COUNT(DISTINCT BD7_CODEMP||BD7_MATRIC||BD7_TIPREG) QTDE "                                                                                   
cquery += " FROM " + RetSqlName("BD7") + "  BD7 WHERE BD7.BD7_FILIAL = '" + xFilial("Bd7") +"'" 
cquery += " AND BD7.BD7_CODOPE = '0001' AND BD7.BD7_SITUAC = '1' AND BD7.BD7_BLOPAG <> '1' " 
If nFase == 2
   cquery += " AND BD7.BD7_FASE = '4' "                                
ElseIf nFase == 1
   cquery += " AND BD7.BD7_YFAS35  = 'T' "
else 
   cquery += " AND BD7.BD7_FASE IN ( '3','2','1')  "          
EndIf     
cquery += " AND substr (BD7.BD7_NUMLOT,1,6) >= '"+cAnoCompI + cMesCompI+"' AND substr(BD7.BD7_NUMLOT,1,6) <= '"+cAnoCompF + cMesCompF+"' AND BD7_CODEMP = '0004' AND BD7.D_E_L_E_T_ = ' ' " 
cquery += " GROUP BY BD7_FILIAL, BD7_CODPLA, BD7.BD7_OPELOT,BD7.BD7_NUMLOT,BD7_CODPRO, SIGA_TIPO_EXPOSICAO_ANS(BD7_CODEMP,BD7_MATRIC,BD7_TIPREG,To_Date(Trim(BD7_DATPRO),'YYYYMMDD')), " 
cquery += " BD7_FILIAL, BD7_CODOPE, BD7_CODLDP, BD7_CODPEG, BD7_NUMERO, BD7_ORIMOV, BD7_SEQUEN) BD7F," 
cquery += " " + RetSqlName("BD6") + " BD6F  ," + RetSqlName("BI3") + "  BI3 ," + RetSqlName("ZZT") + " ZZT " 
cquery += " WHERE ZZT_FILIAL= '" + xFilial("ZZT") +"' AND BI3_FILIAL='" + xFilial("BI3")+"' AND BD6F.BD6_FILIAL='" + xFilial("Bd6")+"' " 

cquery += " AND substr (BD7F.BD7_NUMLOT,1,6) >=  '"+cAnoCompI + cMesCompI+"' AND substr (BD7F.BD7_NUMLOT,1,6) <=  '"+cAnoCompF + cMesCompF+"' and BD6F.BD6_CONEMP >='" +cContInc +"' and  BD6F.BD6_CONEMP <='" +cContFin +"' and BD6F.BD6_COdemp = '0004' "    

cquery += " AND BD7F.BD7_FILIAL = BD6F.BD6_FILIAL AND BD7F.BD7_CODOPE = BD6F.BD6_CODOPE AND BD7F.BD7_CODLDP = BD6F.BD6_CODLDP AND BD7F.BD7_CODPEG = BD6F.BD6_CODPEG " 
cquery += " AND BD7F.BD7_NUMERO = BD6F.BD6_NUMERO AND BD7F.BD7_ORIMOV = BD6F.BD6_ORIMOV AND BD7F.BD7_SEQUEN = BD6F.BD6_SEQUEN AND BD6F.BD6_CODPRO = BD7F.BD7_CODPRO "                                                                                            
/*If nBlqCoop = 2
   cQuery += " and BD6F.bd6_blocpa <> '1' "
EndIf     */
cquery += " AND BI3_FILIAL=BD7_FILIAL AND BI3_CODINT=BD7_CODOPE and bi3_codigo=BD7_CODPLA AND BD6_YNEVEN=ZZT_CODEV AND BD6F.D_E_L_E_T_ = ' ' AND BI3.D_E_L_E_T_ = ' ' AND ZZT.D_E_L_E_T_ = ' ' "                                                                     
//mbc cquery += " GROUP BY BD6F.bd6_prefix ,BD6F.bd6_numtit ,BD6F.bd6_parcel ,BD6F.bd6_tiptit ,BD6_CONEMP, RETORNA_DESC_CONTRATO('C',BD6_OPEUSR,BD6_CODEMP,BD6_CONEMP), substr (BD7F.BD7_NUMLOT,1,6) " 
cquery += " GROUP BY BD6F.bd6_prefix ,BD6F.bd6_numtit ,BD6F.bd6_parcel ,BD6F.bd6_tiptit ,BD6_CONEMP, RETORNA_DESC_CONTRATO('C',BD6_OPEUSR,BD6_CODEMP,BD6_CONEMP), substr (BD7F.BD7_NUMLOT,1,6) " 

cquery += " union ALL "                                                                                                                                            

CQUERY += " SELECT  '2','--->> Deb/Cred <<---' tipo , bgq_prefix || Bgq_numtit  ||  bgq_parcel || bgq_tiptit titulo ,  0 Glosado, "                                                                                                                                   
cquery += " Sum(Decode(BBB_TIPSER,1,-1*BGQ_VALOR,BGQ_VALOR)) Vl_Aprov, 0 Vl_Participacao,BGQ_CONEMP||'-'||RETORNA_DESC_CONTRATO('C',BGQ_CODOPE,BGQ_CODEMP,BGQ_CONEMP) CONTRATO , substr(BGQ_NUMLOT,1,6) compt  " 
cquery += " FROM " + RetSqlName("BGQ") + "," + RetSqlName("BBB") + ", " + RetSqlName("BI3") + " BI3 ," + RetSqlName("ZZT") + " ZZT "
cquery += " WHERE BGQ_FILIAL = '" + xFilial("BGQ") +"' "                                                                                                     
cquery += " AND BGQ_CODLAN <> '050' AND BBB_FILIAL = '" + xFilial("BBB") +"' AND BBB_CODSER = BGQ_CODLAN AND ZZT_FILIAL = '" + xFilial("ZZT") +"' AND BGQ_YNEVEN=ZZT_CODEV "                                                                                                                         
cquery += " AND BI3_FILIAL = '" + xFilial("BI3") +"' AND BI3_CODIGO=NVL( RETORNA_PLANO_USU_MS ('C',BGQ_CODOPE,BGQ_CODEMP,BGQ_MATRIC,'00','N'),BBB_YCODPL) AND substr(BGQ_NUMLOT,1,6) >= '"+cAnoCompI + cMesCompI+"' AND substr(BGQ_NUMLOT,1,6) <= '"+cAnoCompF + cMesCompF+"' " 
cquery += " AND BI3.D_E_L_E_T_ = ' ' AND ZZT.D_E_L_E_T_ = ' ' AND BGQ010.D_E_L_E_T_ = ' ' AND BBB010.D_E_L_E_T_ = ' '  AND RETORNA_GRUPO_EMP(BI3_CODIGO)='0004' "

cquery += " and BGQ_CONEMP >='" +cContInc +"' and  BGQ_CONEMP <='" +cContFin +"' " 

cquery += " GROUP BY bgq_prefix , Bgq_numtit, bgq_parcel  ,  bgq_tiptit , BGQ_CONEMP , RETORNA_DESC_CONTRATO('C',BGQ_CODOPE,BGQ_CODEMP,BGQ_CONEMP), substr(BGQ_NUMLOT,1,6) " 

cquery += "UNION ALL " 

//cquery += "-- MATERIAL MICROSIGA                                                                                                                                   
cquery += " SELECT '3','--->> Opme <<---' tipo , bd6_prefix || bd6_numtit || bd6_parcel || bd6_tiptit titulo, SUM(GLOSADO)  Glosado, SUM(VL_APROV) VL_APROV,SUM(VL_PARTICIPACAO) VL_PARTICIPACAO, CONTRATO , compt " 
cquery += " FROM( SELECT BD6_CODPLA PLANO, BD6_YNEVEN CodEvento, ZZT_EVENTO Nome_Evento, COUNT(DISTINCT BD6_CODEMP||BD6_MATRIC||BD6_TIPREG) QTDE, Sum(D1_QUANT) Ocorrencia, Sum(BD6_VLRGLO) Glosado, Sum(D1_TOTAL)-Sum(D1_VALDESC)  Vl_Aprov, 0 Taxa , " 
cquery += " RETORNA_VL_COPART_OPME (BD6_CODOPE,BD6_CODLDP,BD6_CODPEG,BD6_NUMERO,'C') Vl_Participacao, 0 Vl_Informado, 0 Vl_Recuperado, 0 Vl_Protocolado, 0 Vl_Total_Prot, "                                                                                                                         
cquery += " SIGA_TIPO_EXPOSICAO_ANS(BD6_CODEMP,BD6_MATRIC,BD6_TIPREG,To_Date(Trim(BD6_DATPRO),'YYYYMMDD')) EXPOSICAO_ANS , DECODE(BI3_YGRPLA,4,'MATER',2,'AFINIDADE',3,'EMPRESARIAL',1,'ADMINISTRATIVO') GRUPO_PLANO, " 
cquery += " Decode(BD6_CODEMP,'0007',Trim(BI3_NREDUZ)||' (SEPE)',BI3_NREDUZ) NOME_PLANO, 0 Val_adiant , ZZT_TPCUST ,BD6_CONEMP||'-'||RETORNA_DESC_CONTRATO('C',BD6_OPEUSR,BD6_CODEMP,BD6_CONEMP) CONTRATO,B19_DOC, bd6_prefix , bd6_numtit, bd6_parcel , bd6_tiptit , substr (F1_EMISSAO,1,6) compt"                                                                                                     
//cquery += " BD6_Anopag||BD6_MESPAG COMPETENCIA_COB" 
cquery += " FROM " + RetSqlName("B19") + " B19, " + RetSqlName("SD1") + " SD1, " + RetSqlName("SF1") + " SF1, " + RetSqlName("BD6") + " BD6 , " + RetSqlName("SA2") + " SA2, " + RetSqlName("ZZT") + " ZZT  ," + RetSqlName("BI3") + " BI3 " 
cquery += " WHERE BI3_FILIAL='" + xFilial("BI3") +"' AND A2_FILIAL='" + xFilial("SA2") +"' AND BD6_FILIAL = '" + xFilial("BD6") +"' AND ZZT_FILIAL='" + xFilial("ZZT") +"' "  
cquery += " AND substr (F1_EMISSAO,1,6) >= '"+cAnoCompI + cMesCompI +"' AND substr (F1_EMISSAO,1,6) <= '"+cAnoCompF + cMesCompF +"' AND A2_COD = B19_FORNEC AND D1_FORNECE= A2_COD AND f1_FORNECE= A2_COD AND D1_DOC = F1_DOC AND B19_DOC = D1_DOC AND D1_ITEM = B19_ITEM " 
cquery += " AND BD6_CODPLA=BI3_CODIGO AND BD6_CODOPE = SubStr(B19_GUIA,01,04) AND BD6_CODLDP = SubStr(B19_GUIA,05,04) AND BD6_CODPEG = SubStr(B19_GUIA,09,08) AND BD6_NUMERO = SubStr(B19_GUIA,17,08) AND BD6_ORIMOV = SubStr(B19_GUIA,25,01) AND BD6_SEQUEN = SubStr(B19_GUIA,26,03) " 
cquery += " AND BD6_FASE IN (3,4) AND BD6_CODLDP='0013' AND BD6_CODEMP='0004' and BD6_CONEMP >='" +cContInc +"' and  BD6_CONEMP <='" +cContFin +"' AND BD6_SITUAC = 1 AND BD6_YNEVEN = ZZT_CODEV "                                                                                                                                 
cquery += " AND SA2.D_E_L_E_T_ = ' ' AND B19.D_E_L_E_T_ = ' ' AND SD1.D_E_L_E_T_ = ' ' AND SF1.D_E_L_E_T_ = ' ' AND BD6.D_E_L_E_T_ = ' ' AND ZZT.D_E_L_E_T_ = ' ' AND BI3.D_E_L_E_T_ = ' ' " 
cquery += " GROUP BY SIGA_TIPO_EXPOSICAO_ANS(BD6_CODEMP,BD6_MATRIC,BD6_TIPREG,To_Date(Trim(BD6_DATPRO),'YYYYMMDD')), BD6_CODEMP, BD6_CODPLA, " 
cquery += " BI3_YGRPLA,Decode(BD6_CODEMP,'0007',Trim(BI3_NREDUZ)||' (SEPE)',BI3_NREDUZ), BD6_YNEVEN, ZZT_EVENTO,ZZT_TPCUST,BD6_CONEMP , RETORNA_DESC_CONTRATO('C',BD6_OPEUSR,BD6_CODEMP,BD6_CONEMP), RETORNA_VL_COPART_OPME (BD6_CODOPE,BD6_CODLDP,BD6_CODPEG,BD6_NUMERO,'C') ,B19_DOC , bd6_prefix , bd6_numtit ,bd6_parcel, bd6_tiptit , substr (F1_EMISSAO,1,6)) " 
cquery += " GROUP BY bd6_prefix , bd6_numtit , bd6_parcel , bd6_tiptit , CONTRATO , compt " 
//cquery += "--FIM MATERIAL MICROSIGA                                                                                                                               " 
cquery += "UNION ALL                                                                                                                                              " 
//cquery += "--REEMBOLSO MICROSIGA                                                                                                                                  " 
cquery += " SELECT  '4','--->> Reemb <<---' tipo , bd6_prefix || Bd6_numtit || bd6_parcel || bd6_tiptit titulo, Sum(B45_VLRGLO) Glosado , Sum(B45_VLRPAG) Val_Aprov , Sum(B45_VLRMAN) Vl_informado , B44_CONEMP||'-'||RETORNA_DESC_CONTRATO('C',B44_OPEUSR,B44_CODEMP,B44_CONEMP) CONTRATO , SubStr(E1_VENCREA,1,6) compt "
cquery += " FROM  "+ RetSqlName("B44") +" C  ,"+ RetSqlName("B45") +" D ,"+ RetSqlName("SE1") +" T ,"+ RetSqlName("BA1") +" U,"+ RetSqlName("BA3") +" F ,"+ RetSqlName("BI3") +" BI3 ,"+ RetSqlName("BG9") +" BG9 ," + RetSqlName("ZZT") +" ZZT,"+ RetSqlName("BD6") + " bd6 " 
cquery += " WHERE B45_FILIAL='" + xFilial("B45") +"' AND B44_FILIAL='" + xFilial("B44") +"' AND BI3_FILIAL='" + xFilial("BI3") +"' AND BA3_FILIAL='" + xFilial("BA3") +"' " 
cquery += " AND BA1_FILIAL='" + xFilial("BA1") +"' AND BG9_FILIAL='" + xFilial("BG9") +"' AND ZZT_FILIAL='" + xFilial("ZZT") +"' AND E1_FILIAL= '" + xFilial("SE1") +"' " 
cquery += " AND E1_PREFIXO='RLE' AND B44_CODLDP=B45_CODLDP AND B44_CODPEG=B45_CODPEG AND B44_NUMAUT=B45_NUMAUT AND B44_PREFIX =E1_PREFIXO AND B44_NUM=E1_NUM  " 
cquery += " AND BA1_CODINT=BA3_CODINT AND BA1_CODEMP=BA3_CODEMP AND BA1_MATRIC=BA3_MATRIC AND BA1_CODINT=B44_OPEUSR AND BA1_CODEMP=B44_CODEMP AND BA1_MATRIC=B44_MATRIC " 
cquery += " AND BA1_TIPREG=B44_TIPREG AND BI3_CODINT=BA1_CODINT AND B44_OPEUSR=BG9_CODINT AND B44_CODEMP=BG9_CODIGO AND B44_CODEMP='0004' and B44_CONEMP >='" +cContInc +"' and  B44_CONEMP <='" +cContFin +"' " 
cquery += " AND BI3_CODIGO=Nvl(Trim(BA1_CODPLA),BA3_CODPLA) AND ((('"+cAnoCompI + cMesCompI+"' < '201006') AND (SubStr(E1_VENCREA,1,6)>='"+cAnoCompI + cMesCompI+"')) OR (('201304' >='201006') AND (SubStr(E1_EMISSAO,1,6)<='"+cAnoCompI + cMesCompI+"')))" 


cquery += " AND BD6_CODOPE='0001' AND B45_CODLDP=BD6_CODLDP AND B45_CODPEG=BD6_CODPEG AND B45_NUMERO=BD6_NUMERO AND B45_SEQUEN=BD6_SEQUEN AND B45_CODPAD=BD6_CODPAD AND B45_CODPRO=BD6_CODPRO AND BD6_YNEVEN=ZZT_CODEV " 
cquery += " AND C.D_E_L_E_T_= ' ' AND D.D_E_L_E_T_= ' '    AND T.D_E_L_E_T_= ' '   AND U.D_E_L_E_T_= ' 'AND F.D_E_L_E_T_= ' ' AND BI3.D_E_L_E_T_ = ' ' AND BG9.D_E_L_E_T_= ' ' AND ZZT.D_E_L_E_T_= ' ' AND BD6.D_E_L_E_T_ =' ' " 
cquery += " GROUP BY bd6_prefix , Bd6_numtit  ,bd6_parcel ,  bd6_tiptit , B44_CONEMP , RETORNA_DESC_CONTRATO('C',B44_OPEUSR,B44_CODEMP,B44_CONEMP) , SubStr(E1_VENCREA,1,6) " 
cquery += "order by 7,1,2,3   "   	
   	
 If Select(("TMP")) <> 0 
       ("TMP")->(DbCloseArea()) 
 Endif
  
    TCQuery cQuery Alias "TMP" New 
    
    dbSelectArea("TMP")
   
    tmp->(dbGoTop())  
    
  While Tmp->(!Eof())     
     if !empty (tmp->titulo)                                                       
        dbSelectArea("SE1")
        SE1->(DbSetOrder(1))
		
		If SE1->(DbSeek(xFilial("SE1")+tmp->titulo))
            aaDD(aDados1,{tmp->tipo             ,;
                          tmp->titulo           ,;
	                      se1->e1_emissao ,; 
	                      se1->e1_vencto ,;
	                      se1->e1_baixa ,;   
	                      (tmp->Glosado + tmp->Vl_Aprov),; 
	   	                  tmp->Glosado 		    ,;
	   	                  tmp->Vl_Aprov 		,;
	   	                  tmp->CONTRATO 	    ,;
	   	                  tmp->compt})                
	    EndIf               
     Else 
            aaDD(aDados1,{tmp->tipo             ,;
                          tmp->titulo           ,;
	                      stod(' ')             ,; 
	                      stod(' ')             ,;                                             
	                      stod(' ')             ,; 
                         (tmp->Glosado + tmp->Vl_Aprov)  ,;  
	   	                  tmp->Glosado 		    ,;
	   	                  tmp->Vl_Aprov 		,;
	   	                  tmp->CONTRATO 	    ,;
	   	                  tmp->compt})                
     
	 EndIf
	TMP->(dbSkip()) 	   
  EndDo	                   
EndIf  
if nAnalG == 1      
  cquery := " SELECT '--->> Guias <<---'  Tipo ,"
  cquery += " BD6F.BD6_CODOPE ||'-'|| BD6F.BD6_CODLDP ||'-'|| BD6F.BD6_CODPEG ||'-'|| BD6F.BD6_NUMERO ||'-'|| BD6F.BD6_SEQUEN ||'-'|| BD6F.BD6_ORIMOV  Guia , " 
  cquery += " decode(BD6F.bd6_blocpa,'1',' Sim ', ' Não ' ) Bloq_copart   , "
  cquery += " decode(BD6F.BD6_CONCOB,'0',' Sim ', ' Não ' ) Cob_Estornada , "
  cquery += " OBTER_NUMERO_GUIA_ESTORNO('C', BD6F.bd6_codope,BD6F.bd6_codldp,BD6F.bd6_codpeg,BD6F.BD6_NUMERO) Clone , "  
//mbc  cquery += " BD6F.BD6_NOMUSR nomusr, BD6F.BD6_CODRDA||'-'||BD6F.BD6_NOMRDA rda,substr (BD7F.BD7_NUMLOT,1,6) compt  ,Sum(BD6F.BD6_VLRGLO) Glosado ,  Sum(BD7F.VLRPAG)  Vl_Aprov , " 
  cquery += " BD6F.BD6_NOMUSR nomusr, BD6F.BD6_CODRDA||'-'||BD6F.BD6_NOMRDA rda," 
  cquery += " substr (BD7F.BD7_NUMLOT,1,6) compt  ,BD6_Anopag||BD6_MESPAG COMPETENCIA_COB, Sum(BD6F.BD6_VLRGLO) Glosado ,  Sum(BD7F.VLRPAG)  Vl_Aprov , " 

  cquery += " sum(Decode(BD6F.BD6_BLOCPA,'1',0,Decode(Sign(BD6F.BD6_VLRTPF),-1,0,Decode(BD6_CODEMP,'0004',0,'0009',0,BD6F.BD6_VLRTPF)))) Vl_Participacao , "
  cquery += " BD6_CONEMP||'-'||RETORNA_DESC_CONTRATO('C',BD6_OPEUSR,BD6_CODEMP,BD6_CONEMP) CONTRATO "
  
  cquery += " FROM (SELECT BD7.BD7_FILIAL,BD7_CODPLA,SIGA_TIPO_EXPOSICAO_ANS(BD7_CODEMP,BD7_MATRIC,BD7_TIPREG,To_Date(Trim(BD7_DATPRO),'YYYYMMDD')) EXPOS , "
  cquery += " BD7.BD7_OPELOT,BD7.BD7_NUMLOT, BD7.BD7_CODOPE, BD7.BD7_CODLDP, BD7.BD7_CODPEG, BD7.BD7_NUMERO, BD7.BD7_ORIMOV, BD7_CODPRO , " 
  cquery += " BD7.BD7_SEQUEN,  Sum(BD7.BD7_VLRPAG) AS VLRPAG, COUNT(DISTINCT BD7_CODEMP||BD7_MATRIC||BD7_TIPREG) QTDE , "     
  
 cquery += " Decode(BD7.BD7_FASE ,'1','Digitação','2','Conferencia','3', 'Ponta','4', 'Faturada','Outras') Fase ,  
 cquery += " Decode(BD7.BD7_YFAS35 ,'T','Fas35Ok','Fas35NOk') Fase35  
 
   
  cquery += " FROM "+ RetSqlName("BD7") +" BD7  WHERE BD7.BD7_FILIAL='" + xFilial("Bd7")+"' AND BD7.BD7_CODOPE = '0001' AND BD7.BD7_SITUAC = '1'  AND BD7.BD7_BLOPAG <> '1' AND BD7_CODEMP='0004' AND BD7.D_E_L_E_T_ = ' '  "

If nFase == 2
   cquery += " AND BD7.BD7_FASE = '4' "                                
ElseIf nFase == 1
   cquery += " AND BD7.BD7_YFAS35  = 'T' "   
else 
   cquery += " AND BD7.BD7_FASE IN ( '3','2','1')  "          
EndIf     

  cquery += " AND substr (BD7.BD7_NUMLOT,1,6) >=  '"+cAnoCompI + cMesCompI+"' AND substr (BD7.BD7_NUMLOT,1,6) <=  '"+cAnoCompF + cMesCompF+"'"  
  cquery += " GROUP BY BD7_FILIAL, BD7_CODPLA, BD7.BD7_OPELOT,BD7.BD7_NUMLOT,BD7_CODPRO , "
  cquery += " SIGA_TIPO_EXPOSICAO_ANS(BD7_CODEMP,BD7_MATRIC,BD7_TIPREG,To_Date(Trim(BD7_DATPRO),'YYYYMMDD')) , " 
  cquery += " BD7_FILIAL, BD7_CODOPE, BD7_CODLDP, BD7_CODPEG, BD7_NUMERO, BD7_ORIMOV, BD7_SEQUEN, 
  cquery += " Decode(BD7.BD7_FASE ,'1','Digitação','2','Conferencia','3', 'Ponta','4', 'Faturada','Outras'),  
  cquery += " Decode(BD7.BD7_YFAS35 ,'T','Fas35Ok','Fas35NOk')  ) BD7F, "
  cquery +=   RetSqlName("BD6") + " BD6F , " + RetSqlName("BI3") + " BI3 , "+ RetSqlName("ZZT") + "  ZZT "
  cquery += " WHERE ZZT_FILIAL= '" + xFilial("ZZT")+"' AND BI3_FILIAL= '" + xFilial("BI3")+"' AND BD6F.BD6_FILIAL='" + xFilial("Bd6")+"' AND BD6F.D_E_L_E_T_ = ' ' AND BI3.D_E_L_E_T_ = ' ' AND ZZT.D_E_L_E_T_ = ' ' "
 
  cquery += " AND substr (BD7F.BD7_NUMLOT,1,6) >= '"+cAnoCompI + cMesCompI+"' AND substr (BD7F.BD7_NUMLOT,1,6) <= '"+cAnoCompF + cMesCompF+"' and BD6F.BD6_CONEMP >='" +cContInc +"' and  BD6F.BD6_CONEMP <='" +cContFin +"' "    
  
  cquery += " AND BD7F.BD7_FILIAL = BD6F.BD6_FILIAL AND BD7F.BD7_CODOPE = BD6F.BD6_CODOPE AND BD7F.BD7_CODLDP = BD6F.BD6_CODLDP AND BD6F.BD6_CODEMP = '0004' And BD6F.bd6_numtit = ' ' "  
  cquery += " AND BD7F.BD7_CODPEG = BD6F.BD6_CODPEG AND BD7F.BD7_NUMERO = BD6F.BD6_NUMERO AND BD7F.BD7_ORIMOV = BD6F.BD6_ORIMOV AND BD7F.BD7_SEQUEN = BD6F.BD6_SEQUEN "
  cquery += " AND BD6F.BD6_CODPRO = BD7F.BD7_CODPRO AND BI3_FILIAL = BD7_FILIAL AND BI3_CODINT=BD7_CODOPE  AND BI3_CODIGO=BD7_CODPLA   AND BD6_YNEVEN=ZZT_CODEV  AND BD7F.VLRPAG > 0 "
 
  cquery += " GROUP BY BD6F.BD6_CODOPE ||'-'|| BD6F.BD6_CODLDP ||'-'|| BD6F.BD6_CODPEG ||'-'|| BD6F.BD6_NUMERO ||'-'|| BD6F.BD6_SEQUEN ||'-'|| BD6F.BD6_ORIMOV , "   
  cquery += " BD6F.bd6_blocpa , BD6F.BD6_CONCOB, OBTER_NUMERO_GUIA_ESTORNO('C', BD6F.bd6_codope,BD6F.bd6_codldp,BD6F.bd6_codpeg,BD6F.BD6_NUMERO) , "  
//  cquery += " BD6_CONEMP||'-'||RETORNA_DESC_CONTRATO('C',BD6_OPEUSR,BD6_CODEMP,BD6_CONEMP) , BD6F.BD6_NOMUSR, BD6F.BD6_CODRDA||'-'||BD6F.BD6_NOMRDA , substr (BD7F.BD7_NUMLOT,1,6)" 
  cquery += " BD6_Anopag||BD6_MESPAG, BD6_CONEMP||'-'||RETORNA_DESC_CONTRATO('C',BD6_OPEUSR,BD6_CODEMP,BD6_CONEMP) , BD6F.BD6_NOMUSR, BD6F.BD6_CODRDA||'-'||BD6F.BD6_NOMRDA , substr (BD7F.BD7_NUMLOT,1,6), BD6_Anopag||BD6_MESPAG " 
  /*
  cquery += " Decode(BD7F.BD7_FASE ,'1','Digitação','2','Conferencia','3', 'Ponta','4', 'Faturada','Outras')  ,  
  cquery += " Decode(BD7F.BD7_YFAS35 ,'T','Fas35Ok','Fas35NOk')
  */  

  cquery += "order by BD6_CONEMP||'-'||RETORNA_DESC_CONTRATO('C',BD6_OPEUSR,BD6_CODEMP,BD6_CONEMP) "   
 
 If Select(("TMP1")) <> 0 
       ("TMP1")->(DbCloseArea()) 
 Endif
  
    TCQuery cQuery Alias "TMP1" New 
    
    dbSelectArea("TMP1")
   
    tmp1->(dbGoTop())  
    
   aCabec1 := 			 {"Tipo"             ,;
                          "Guia"         ,;
	                      "Bloqueada Participação"  ,; 
	                      "Participação Estornada"  ,;
	                      "Clone"            ,; 
	                      "Nome Usuário"            ,; 
	                      "RDA"          ,;
	                      "Total Apresentado",; 
	   	                  "Glosado" 	 ,;
	   	                  "Valor Aprovado" 	 ,;	   	                  
	   	                  "Valor Participação"  ,;  
	   	                  "Contrato" 	 ,;
	   	                  "Competencia Pagamento",;
	   	                  "Competencia para cobrança"}            

  While Tmp1->(!Eof())     
        aaDD(aDados2,{tmp1->tipo             ,;
                          tmp1->Guia         ,;
	                      tmp1->Bloq_copart  ,; 
	                      tmp1->Cob_Estornada  ,; 
	                      tmp1->Clone        ,;
	                      tmp1->nomusr       ,; 
	                      tmp1->rda          ,;
	                     (tmp1->Glosado + tmp1->Vl_Aprov),; 
	   	                  tmp1->Glosado 	 ,;
	   	                  tmp1->Vl_Aprov 	 ,;
	   	                  tmp1->Vl_Participacao  ,; 
   	   	                  tmp1->CONTRATO 	 ,;
	   	                  tmp1->compt,;
	   	                  tmp1->COMPETENCIA_COB})                
	TMP1->(dbSkip()) 	   
  EndDo	      
EndIf
if  nAnalO == 1   
	cquery := " SELECT '--->> Opme <<---' Tipo, fornece , nf , emissao , digit ,titse2 , baixase2, bd6_prefix ||' ' || bd6_numtit ||' ' || bd6_tiptit  tit, "
	cquery += " SUM(GLOSADO) GLOSADO,  SUM(VL_APROV)  VL_APROV, SUM(VL_PARTICIPACAO) VL_PARTICIPACAO, CONTRATO , substr (Emissao,1,6) compt " 
	cquery += " FROM(  SELECT  DISTINCT f1_fornece ||' - '|| a2_nome Fornece , f1_serie ||'-'|| f1_doc   Nf, f1_emissao Emissao ,  f1_dtdigit Digit , "
	cquery += " E2_prefixo ||' - '|| e2_num  ||' - '|| e2_tipo  titse2, e2_baixa baixase2 , BD6_CODPLA PLANO, BD6_YNEVEN CodEvento, ZZT_EVENTO Nome_Evento, "
//	cquery += " COUNT(DISTINCT BD6_CODEMP||BD6_MATRIC||BD6_TIPREG) QTDE, Sum(D1_QUANT) Ocorrencia, Sum(BD6_VLRGLO) Glosado, Sum(D1_TOTAL)-Sum(D1_VALDESC)  Vl_Aprov, 0 Taxa , "

	cquery += " 1 QTDE, D1_QUANT Ocorrencia, BD6_VLRGLO Glosado, D1_TOTAL - D1_VALDESC  Vl_Aprov, 0 Taxa , "

	cquery += " RETORNA_VL_COPART_OPME (BD6_CODOPE,BD6_CODLDP,BD6_CODPEG,BD6_NUMERO,'C') Vl_Participacao, 0 Vl_Informado, 0 Vl_Recuperado, 0 Vl_Protocolado, 0 Vl_Total_Prot, "
	cquery += " SIGA_TIPO_EXPOSICAO_ANS(BD6_CODEMP,BD6_MATRIC,BD6_TIPREG,To_Date(Trim(BD6_DATPRO),'YYYYMMDD')) EXPOSICAO_ANS , "
	cquery += " DECODE(BI3_YGRPLA,4,'MATER',2,'AFINIDADE',3,'EMPRESARIAL',1,'ADMINISTRATIVO') GRUPO_PLANO, Decode(BD6_CODEMP,'0007',Trim(BI3_NREDUZ)||' (SEPE)',BI3_NREDUZ) NOME_PLANO, "
	cquery += " 0 Val_adiant , ZZT_TPCUST  , BD6_CONEMP ||'-'|| RETORNA_DESC_CONTRATO('C',BD6_OPEUSR,BD6_CODEMP,BD6_CONEMP) CONTRATO,B19_DOC, bd6_prefix , bd6_numtit , bd6_tiptit "
	cquery += " FROM " +RetSqlName("B19")+ " B19 ," +RetSqlName("SD1")+ " SD1," +RetSqlName("SF1")+ " SF1, " +RetSqlName("BD6") + " BD6 ," +RetSqlName("SA2") +" SA2," +RetSqlName("ZZT") + " ZZT ," +RetSqlName("BI3") + " BI3 ," +RetSqlName("SE2") + " SE2 "
	cquery += " WHERE BI3_FILIAL='" + xFilial("BI3")+"' AND A2_FILIAL ='" + xFilial("SA2")+"' and e2_filial = '" + xFilial("SE2")+"' AND BD6_FILIAL = '" + xFilial("BD6")+"' AND ZZT_FILIAL='" + xFilial("ZZT")+"' "
	cquery += " AND A2_COD = B19_FORNEC AND D1_FORNECE= A2_COD AND f1_FORNECE= A2_COD AND D1_DOC = F1_DOC AND B19_DOC = D1_DOC    AND D1_ITEM = B19_ITEM "
	cquery += " AND BD6_CODPLA = BI3_CODIGO AND BD6_CODOPE = SubStr(B19_GUIA,01,04) AND BD6_CODLDP = SubStr(B19_GUIA,05,04) AND BD6_CODPEG = SubStr(B19_GUIA,09,08) "
	cquery += " AND BD6_NUMERO = SubStr(B19_GUIA,17,08) AND BD6_ORIMOV = SubStr(B19_GUIA,25,01) AND BD6_SEQUEN = SubStr(B19_GUIA,26,03) AND BD6_FASE IN (3,4) "
	cquery += " AND BD6_CODLDP='0013' AND BD6_CODEMP='0004' AND BD6_SITUAC = 1 AND BD6_YNEVEN=ZZT_CODEV "
	cquery += " and BD6_CONEMP >= '" +cContInc +"' and BD6_CONEMP <= '" +cContFin +"'  AND substr (F1_EMISSAO,1,6) >=  '"+cAnoCompI + cMesCompI +"' AND substr (F1_EMISSAO,1,6) <=  '"+cAnoCompF + cMesCompF +"'"     
	cquery += " and f1_prefixo = e2_prefixo  and f1_doc = e2_num  and f1_fornece = e2_fornece "
	cquery += " AND SA2.D_E_L_E_T_ = ' ' AND B19.D_E_L_E_T_ = ' ' AND SD1.D_E_L_E_T_ = ' ' AND SF1.D_E_L_E_T_ = ' ' AND BD6.D_E_L_E_T_ = ' ' AND ZZT.D_E_L_E_T_ = ' ' AND BI3.D_E_L_E_T_ = ' ' and se2.d_E_L_E_T_ = ' ' "
//	cquery += " GROUP BY SIGA_TIPO_EXPOSICAO_ANS(BD6_CODEMP,BD6_MATRIC,BD6_TIPREG,To_Date(Trim(BD6_DATPRO),'YYYYMMDD')), BD6_CODEMP, E2_prefixo ,e2_num  ,e2_tipo  , e2_baixa , "
//	cquery += " f1_fornece , a2_nome , f1_doc , f1_serie, f1_emissao ,  f1_dtdigit , BD6_CODPLA, BI3_YGRPLA,Decode(BD6_CODEMP,'0007',Trim(BI3_NREDUZ)||' (SEPE)',BI3_NREDUZ), "
//	cquery += " BD6_YNEVEN, ZZT_EVENTO,ZZT_TPCUST, BD6_CONEMP , RETORNA_DESC_CONTRATO('C',BD6_OPEUSR,BD6_CODEMP,BD6_CONEMP),"
//	cquery += " RETORNA_VL_COPART_OPME (BD6_CODOPE,BD6_CODLDP,BD6_CODPEG,BD6_NUMERO,'C') ,B19_DOC , bd6_prefix , bd6_numtit , bd6_tiptit ) "
	cquery += " ) GROUP BY   fornece , nf , emissao , digit ,titse2 , baixase2, bd6_prefix ||' ' || bd6_numtit ||' ' || bd6_tiptit , CONTRATO , substr (Emissao,1,6) order by contrato"
	
  If Select(("TMP2")) <> 0 
       ("TMP2")->(DbCloseArea()) 
 Endif
  
    TCQuery cQuery Alias "TMP2" New 
    
    dbSelectArea("TMP2")
   
    tmp2->(dbGoTop())  
    
  While Tmp2->(!Eof())                   
  
            aaDD(aDados3,{tmp2->tipo           ,;
                          tmp2->Fornece        ,;
	                      tmp2->nf             ,;     
	                      stod(tmp2->emissao)  ,; 
	                      stod(tmp2->digit)    ,;
	                      tmp2->titse2         ,;
	                      stod(tmp2->baixase2) ,; 
	                      tmp2->tit            ,;
	                     (tmp2->Glosado + tmp2->Vl_Aprov),; 
	   	                  tmp2->Glosado 	   ,;
	   	                  tmp2->Vl_Aprov 	   ,;
	   	                  tmp2->CONTRATO 	   ,;
	   	                  tmp2->Vl_Participacao  ,;
	   	                  tmp2->compt})                
	TMP2->(dbSkip()) 	   
  EndDo	      
EndIf
Return                    

*************************************************************************************************************  
Static Function fGeraRel2

Local oReport 
Private cPerg		:= "CABR076"  
Private aOrdem 		:= {}//{'RDA','Ano/Mes'}

//aSort( aDados1,,,{|x,y| x[10] < y[10]} )

oReport:= ReportDef2()
oReport:PrintDialog()

Return

*************************************************************************************************************
Static Function fGeraRel3

Local oReport 
Private cPerg		:= "CABR076"  
Private aOrdem 		:= {}//{'RDA','Ano/Mes'}

//aSort( aDados1,,,{|x,y| x[10] < y[10]} )

oReport:= ReportDef3()
oReport:PrintDialog()

Return
*************************************************************************************************************

Static Function fGeraRel1

Local oReport 
Private cPerg		:= "CABR076"  
Private aOrdem 		:= {}//{'RDA','Ano/Mes'}

//aSort( aDados2,,,{|x,y| x[10] < y[10]} )

oReport:= ReportDef1()
oReport:PrintDialog()

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

oReport	:= TReport():New("CABR076","Analise de Cobradas de Convenios - Visão Custo - Da Competencia : "+cMesCompI+"/"+cAnoCompI+" A "+cMesCompF+"/"+cAnoCompF,, {|oReport| ReportPrt3(oReport)},"Este relatorio lista a cobranca de contas medicas dos convenios")
oReport:SetTotalInLine(.F.)//Imprime na linha: .F. - Imprime abaixo da linha com o titulo de cada coluna: .T.
oReport:SetTotalText('Total Geral') 

*'-----------------------------------------------------------------------------------'*
*'Solucao para impressao em que as colunas se truncam: "SetColSpace" e "SetLandScape"'* 
*'-----------------------------------------------------------------------------------'*

oReport:SetColSpace(1) //Espacamento entre colunas. 
oReport:SetLandscape() //Impressao em paisagem.  
//oReport:SetPortrait() //Impressao em retrato.  

*'-----------------------------------------------------------------------------------'*
                                                                
oDPJ := TRSection():New(oReport,"Analise de Cobradas de Convenios - Visão Custo - Da Competencia : "+cMesCompI+"/"+cAnoCompI+" A "+cMesCompF+"/"+cAnoCompF,,aOrdem)    
          

TRCell():New(oDPJ ,'TIPO '			    ,/*TABELA*/	,'Tipo '	 	   ,/*Picture*/   	    ,18				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oDPJ ,'FORNE'	   		    ,/*TABELA*/	,'Fornecedor'	   ,/*Picture*/ 	    ,40				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		) 
TRCell():New(oDPJ ,'NOTAF'	   	     	,/*TABELA*/	,'NFiscal'	       ,/*Picture*/ 	    ,13				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oDPJ ,'EMISS'		        ,/*TABELA*/	,'Dt.Emissao'      ,/*Picture*/ 	    ,10			  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)  
TRCell():New(oDPJ ,'DIGIT'	      	    ,/*TABELA*/	,'Dt.Digitção'     ,/*Picture*/ 	    ,10			  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)  
TRCell():New(oDPJ ,'BAIXA'		    	,/*TABELA*/	,'Dt.Baixa.'       ,/*Picture*/ 	    ,10			  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		) 
TRCell():New(oDPJ ,'TITUL'	   	     	,/*TABELA*/	,'Tit.Finan.'      ,/*Picture*/ 	    ,13				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		) 
TRCell():New(oDPJ ,'VLAPR'			    ,/*TABELA*/	,'Val.Apresentado' ,"@E 9,999,999.99" 	,11			 	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"		) 
TRCell():New(oDPJ ,'VLGLO'			    ,/*TABELA*/	,'Glosa'           ,"@E 9,999,999.99" 	,11			 	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"		) 
TRCell():New(oDPJ ,'VLPRO'			    ,/*TABELA*/	,'Val.Analisado'   ,"@E 9,999,999.99" 	,11			 	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"		) 
TRCell():New(oDPJ ,'EMPRESA'	    	,/*TABELA*/	,'Empresa'	       ,/*Picture*/ 	    ,40		    	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		) 

 
oBreak01 		:= TRBreak():New(oDPJ,oDPJ:Cell("EMPRESA"),"Subtotal por Convenio"	,.F.)  

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

oReport	:= TReport():New("CABR076","Analise de Cobradas de Convenios - Visão Custo - Da Competencia : "+cMesCompI+"/"+cAnoCompI+" A "+cMesCompF+"/"+cAnoCompF,, {|oReport| ReportPrt(oReport)},"Este relatorio lista a cobranca de contas medicas dos convenios")
oReport:SetTotalInLine(.F.)//Imprime na linha: .F. - Imprime abaixo da linha com o titulo de cada coluna: .T.
oReport:SetTotalText('Total Geral') 

*'-----------------------------------------------------------------------------------'*
*'Solucao para impressao em que as colunas se truncam: "SetColSpace" e "SetLandScape"'* 
*'-----------------------------------------------------------------------------------'*

oReport:SetColSpace(1) //Espacamento entre colunas. 
oReport:SetLandscape() //Impressao em paisagem.  
//oReport:SetPortrait() //Impressao em retrato.  

*'-----------------------------------------------------------------------------------'*
                                                                
oDPJ := TRSection():New(oReport,"Analise de Cobradas de Convenios - Visão Custo - Da Competencia : "+cMesCompI+"/"+cAnoCompI+" A "+cMesCompF+"/"+cAnoCompF,,aOrdem)              

TRCell():New(oDPJ ,'TIPO '			    ,/*TABELA*/	,'Tipo '	 	   ,/*Picture*/   	    ,20				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oDPJ ,'TITUL'	     		,/*TABELA*/	,'Titulo'	       ,/*Picture*/ 	    ,17				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oDPJ ,'EMISS'		        ,/*TABELA*/	,'Dt.Emissao'      ,/*Picture*/ 	    ,10			  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)  
TRCell():New(oDPJ ,'VENCI'	      	    ,/*TABELA*/	,'Dt.Vencto'       ,/*Picture*/ 	    ,10			  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)  
TRCell():New(oDPJ ,'BAIXA'		    	,/*TABELA*/	,'Dt.Receb.'       ,/*Picture*/ 	    ,10			  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)  
TRCell():New(oDPJ ,'VLAPR'			    ,/*TABELA*/	,'Val.Apresentado' ,"@E 9,999,999.99" 	,11			 	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"		) 
TRCell():New(oDPJ ,'VLGLO'			    ,/*TABELA*/	,'Glosa'           ,"@E 9,999,999.99" 	,11			 	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"		) 
TRCell():New(oDPJ ,'VLPRO'			    ,/*TABELA*/	,'Val.Analisado'   ,"@E 9,999,999.99" 	,11			 	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"		) 
TRCell():New(oDPJ ,'EMPRESA'	    	,/*TABELA*/	,'Empresa'	       ,/*Picture*/ 	    ,40		    	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		) 

 
oBreak01 		:= TRBreak():New(oDPJ,oDPJ:Cell("EMPRESA"),"Subtotal por Convenio"	,.F.)  

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
  
	oDPJ:Cell('TIPO '	 		):SetValue(AllTrim(aDados1[i][1]))     
	oDPJ:Cell('TITUL'	 		):SetValue(AllTrim(aDados1[i][2]))    
  	oDPJ:Cell('EMISS'	  		):SetValue((aDados1[i][3] ))      
    oDPJ:Cell('VENCI'   		):SetValue((aDados1[i][4]))   
   	oDPJ:Cell('BAIXA'  		    ):SetValue((aDados1[i][5]))
	oDPJ:Cell('VLAPR'	 		):SetValue((aDados1[i][6]))     
	oDPJ:Cell('VLGLO'	 		):SetValue((aDados1[i][7]))          
	oDPJ:Cell('VLPRO'	 		):SetValue((aDados1[i][8]))          
    oDPJ:Cell('EMPRESA'  		):SetValue((aDados1[i][9]))
	
	oDPJ:PrintLine()
Next i

oDPJ:Finish()

Return   

********************************************************************************************************************************      
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

oReport	:= TReport():New("CABR076","Guias Não Cobradas de Convenios - Visão Custo - Da Competencia : "+cMesCompI+"/"+cAnoCompI+" A "+cMesCompF+"/"+cAnoCompF,, {|oReport| ReportPrt1(oReport)},"Este relatorio lista a cobranca de contas medicas dos convenios")
oReport:SetTotalInLine(.F.)//Imprime na linha: .F. - Imprime abaixo da linha com o titulo de cada coluna: .T.
oReport:SetTotalText('Total Geral') 

*'-----------------------------------------------------------------------------------'*
*'Solucao para impressao em que as colunas se truncam: "SetColSpace" e "SetLandScape"'* 
*'-----------------------------------------------------------------------------------'*

oReport:SetColSpace(1) //Espacamento entre colunas. 
oReport:SetLandscape() //Impressao em paisagem.  
//oReport:SetPortrait() //Impressao em retrato.  

*'-----------------------------------------------------------------------------------'*
                                                                
oDPJ := TRSection():New(oReport,"Guias Não Cobradas de Convenios - Visão Custo - Da Competencia : "+cMesCompI+"/"+cAnoCompI+" A "+cMesCompF+"/"+cAnoCompF,,aOrdem)              

TRCell():New(oDPJ ,'GUIA'	     		,/*TABELA*/	,'Guias '	       ,/*Picture*/ 	    ,30				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oDPJ ,'COPART'		        ,/*TABELA*/	,'Blq. Copart?'    ,/*Picture*/ 	    ,03			  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)  
TRCell():New(oDPJ ,'CLONE'	      	    ,/*TABELA*/	,'Clone'           ,/*Picture*/ 	    ,30			  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)  
TRCell():New(oDPJ ,'ESTORNO'      	    ,/*TABELA*/	,'Estorno'         ,/*Picture*/ 	    ,30			  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)  
TRCell():New(oDPJ ,'USUAR'		    	,/*TABELA*/	,'Usuario '        ,/*Picture*/ 	    ,30			  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)   
TRCell():New(oDPJ ,'RDA'		    	,/*TABELA*/	,'Rda '            ,/*Picture*/ 	    ,30			  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)  

TRCell():New(oDPJ ,'VLAPR'			    ,/*TABELA*/	,'Val.Apresentado' ,"@E 9,999,999.99" 	,11			 	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"		) 
TRCell():New(oDPJ ,'VLGLO'			    ,/*TABELA*/	,'Glosa'           ,"@E 9,999,999.99" 	,11			 	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"		) 
TRCell():New(oDPJ ,'VLPRO'			    ,/*TABELA*/	,'Val.Analisado'   ,"@E 9,999,999.99" 	,11			 	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"		) 
TRCell():New(oDPJ ,'VLPART'			    ,/*TABELA*/	,'Val.Particip'    ,"@E 9,999,999.99" 	,11			 	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"		) 
TRCell():New(oDPJ ,'CONTRATO'	    	,/*TABELA*/	,'Empresa'	       ,/*Picture*/ 	    ,40		    	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		) 
TRCell():New(oDPJ ,'COMPCUS'	    	,/*TABELA*/	,'Comp.Custo'	   ,/*Picture*/         ,06		    	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		) 
TRCell():New(oDPJ ,'COMPCOB'	    	,/*TABELA*/	,'Comp.Cob'	       ,/*Picture*/ 	    ,06		    	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		) 


	

 
oBreak01 		:= TRBreak():New(oDPJ,oDPJ:Cell("EMPRESA"),"Subtotal por Convenio"	,.F.)  

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

Local   cImp    :='Não'

Local i := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

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
  	oDPJ:Cell('COPART'	  		):SetValue((aDados2[i][3] ))      
    oDPJ:Cell('ESTORNO'   		):SetValue((aDados2[i][4]))   
    oDPJ:Cell('CLONE'   		):SetValue((aDados2[i][5]))   
   	oDPJ:Cell('USUAR'  		    ):SetValue((aDados2[i][6]))
    oDPJ:Cell('RDA'  		    ):SetValue((aDados2[i][7]))	
	oDPJ:Cell('VLAPR'	 		):SetValue((aDados2[i][8]))     
	oDPJ:Cell('VLGLO'	 		):SetValue((aDados2[i][9]))          
	oDPJ:Cell('VLPRO'	 		):SetValue((aDados2[i][10]))          
	oDPJ:Cell('VLPART'	 		):SetValue((aDados2[i][11]))          
    oDPJ:Cell('CONTRATO'  		):SetValue((aDados2[i][12]))
    oDPJ:Cell('COMPCUS'  		):SetValue((aDados2[i][13]))
    oDPJ:Cell('COMPCOB'  		):SetValue((aDados2[i][14]))
	
	oDPJ:PrintLine()
Next i

oDPJ:Finish()

Return   

********************************************************************************************************************************
******************************************************************************************

Static Function AjustaSX1(cPerg)

Local aHelpPor := {}

PutSx1(cPerg,"01",OemToAnsi("Mes Comp Custo Inic") 		,"","","mv_ch1","C",02,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","",aHelpPor,{},{})
PutSx1(cPerg,"02",OemToAnsi("Ano Comp Custo Inic") 		,"","","mv_ch2","C",04,0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","",aHelpPor,{},{})    
PutSx1(cPerg,"03",OemToAnsi("Mes Comp Custo Fim") 		,"","","mv_ch3","C",02,0,0,"G","","","","","mv_par03","","","","","","","","","","","","","","","","",aHelpPor,{},{})
PutSx1(cPerg,"04",OemToAnsi("Ano Comp Custo Fim") 		,"","","mv_ch4","C",04,0,0,"G","","","","","mv_par04","","","","","","","","","","","","","","","","",aHelpPor,{},{})    
PutSx1(cPerg,"05",OemToAnsi("Contr. Empresa inicial") 	,"","","mv_ch5","C",12,0,0,"G","","","","","mv_par05","","","","","","","","","","","","","","","","",aHelpPor,{},{})
PutSx1(cPerg,"06",OemToAnsi("Contr. Empresa Final  ") 	,"","","mv_ch6","C",12,0,0,"G","","","","","mv_par06","","","","","","","","","","","","","","","","",aHelpPor,{},{})
PutSx1(cPerg,"07",OemToAnsi("Gerar Excel ") 	        ,"","","mv_ch7","N",01,0,0,"C","","","","","mv_par07","Sim","","","","Não","","","","","","","","","","","",{},{},{}) 
PutSx1(cPerg,"08",OemToAnsi("Sintetico   ")             ,"","","mv_ch8","N",01,0,0,"C","","","","","mv_par08","Sim","","","","Não","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"09",OemToAnsi("Analitico de Guias")       ,"","","mv_ch9","N",01,0,0,"C","","","","","mv_par09","Sim ","","","","Não","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"10",OemToAnsi("Analitico de Opme")        ,"","","mv_ch10","N",01,0,0,"C","","","","","mv_par10","Sim ","","","","Não","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"11",OemToAnsi("Fase ")        	        ,"","","mv_ch11","N",01,0,0,"C","","","","","mv_par11","31/2","","",""," 4 ","",""," 3 ou menor ","","","","","","","","",{},{},{})
Pergunte(cPerg,.F.)

Return

