#INCLUDE "PROTHEUS.CH"
#Include "TOPCONN.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABR237   º Autor ³Altamiro              º Data ³ 27/12/13  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Relatorio de Receita Vs Pagto de Comissao                  º±±
±±º          ³                                                            º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/                  

User Function CABR237
Local cMsg			:= ""
Private lAbortPrint := .F.
Private cPerg       := "CABR237"
Private cTitulo     := "Listagem de cobrança de coparticipação , convenios de reciprocidade e repasse caberj/integral"        

Private cAliastmp 	:= GetNextAlias()
                                                                         
//SetPrvt("oDlg1","oGrp1","oSay1","oSBtn1","oSBtn2","oSBtn3")

cMsg += " Este programa ira fazer Listagem de cobrança de coparticipação , convenios de reciprocidade e repasse caberj/integral conforme parametros " + CRLF

//***************************************************************************    
 
Private  aDados1     := {}       
Private  acabec1    := { "Copart Bloq.","Num. Fat","Cpt.Entrada","Num. Lote","Fase","Cod. Empresa","Ope.Origem","Cod. Operadora","Local Digita.","Cod. Peg","Numero","Origem Mov.","Sequen." ,"Cod. Proced.","Tipo","Matric","Tip Registro","Nome Usurario","Vlr Aprovado","Vlr Base Part","Vlr Total Part","VLr Taxa","Perc Taxa","Bloq Pagto", "Codrda" ,"Consolidado", "Nome RDA", "Nome Operadora","Taxa","Analista ","Cod Evento","Desc Evento","Tp Evento", "Dt Inc" , "Dt Proc",  "Vlr Glosa","vlr Apresentado", "Desc. Procedimento"}  
                                
private Descric := ' '
private cTitVar := ' '              
                                                                                         
private nDiasSrvPrt := GetNewPar("MV_PLDIAPZ",150)
  	  
AjustaSX1(cPerg)

Pergunte(cPerg,.T.) 
cCodEmpI    := mv_par01 
cCodEmpF    := mv_par02 
cCodRdaI    := mv_par03 
cCodRdaF    := mv_par04
cMesBase    := mv_par05
cAnoBase	:= mv_par06
cNumFat     := mv_par07 
cCompCusto  := mv_par08
cFase       := mv_par09
cCopatBloq  := mv_par10
cpgtBloq    := mv_par11 
cConfDif    := mv_par12 
cCodAnals   := mv_par13

cCodPeg     := mv_par14

cOdenar     := mv_par15             
cGeraEx	    := mv_par16         
cLocDig     := mv_par17
cOpeOri     := mv_par18

//Private cTitulo     := "Cobrança de coparticipação , convenios de reciprocidade e repasse caberj/integral"     

Processa({||Processa1()}, cTitulo, "", .T.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Libera impressao                                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
   
// faz ecxel
if cGeraEx == 1 
    DlgToExcel({{"ARRAY","Cobrança de coparticipação , convenios de reciprocidade e repasse caberj/integral" ,aCabec1,aDados1}})   
EndIF
fGeraRel2()    
MsgInfo("Processo finalizado")

Return                 

//**************************************************************************

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFun‡„o    ³ PROCESSA1º Autor ³ altamiro           º Data ³  11/02/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescri‡„o ³ Funcao auxiliar chamada pela PROCESSA.  A funcao PROCESSA  º±±
±±º          ³ Listagem Receita Vs Pagto de Comissao .                    º±±
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
////////////////////////////////////        
cquery := CRLF+" SELECT /*+FIRST_ROWS INDEX_ASC(BD7 BD70105)*/ "
cquery += CRLF+"        trim(DECODE(BD6F.BD6_BLOCPA ,'1','Sim','Não')) Copart , " 
cquery += CRLF+"        trim(DECODE(BD7F.BD7_BLOPAG ,'1','Sim','Não')) pagto , "
cquery += CRLF+"        trim(BD6F.BD6_NUMFAT) numfat , "      
cquery += CRLF+"        trim(decode(trim(BD6F.BD6_seqpf), '', 'Não' , 'Sim')) seqpf  , "
cquery += CRLF+"        trim(BD6F.BD6_ANOPAG) anopag , "
cquery += CRLF+"        trim(BD6F.BD6_MESPAG) mespag , "
cquery += CRLF+"        trim(BD6F.BD6_CODRDA) codrda , "   
cquery += CRLF+"        trim(BD7F.BD7_NUMLOT) numlot , "   
cquery += CRLF+"        decode(trim(BD7F.BD7_FASE),'4','Fat','1','Dig','2','Conf','3',(decode(trim(BD7F.BD7_YFAS35),'T','31/2','Prt')),  'NAO PRONTA') fase   , "
cquery += CRLF+"        trim(BD7F.BD7_FASE  ) fase   , "
cquery += CRLF+"        trim(BD6F.BD6_CODEMP) codemp , "
cquery += CRLF+"        trim(BD6F.BD6_OPEORI) opeori , "
cquery += CRLF+"        trim(BD6F.BD6_CODOPE) codope , "
cquery += CRLF+"        trim(BD6F.BD6_CODLDP) codldp , "
cquery += CRLF+"        trim(BD6F.BD6_CODPEG) codpeg , "
cquery += CRLF+"        trim(BD6F.BD6_NUMERO) numero , "
cquery += CRLF+"        trim(BD6F.BD6_ORIMOV) orimov , "
cquery += CRLF+"        trim(BD6F.BD6_SEQUEN) sequen , "
cquery += CRLF+"        trim(BD7F.BD7_CODPRO) codpro , BD6F.BD6_DESPRO DESPRO ," 

cquery += CRLF+"        trim(BD7F.BD7_DATPRO) DATpro , " 
cquery += CRLF+"        trim(BA1.BA1_DATINC)  DATINC , "

cquery += CRLF+"        trim(DECODE(BD6_CODLDP,'0010','RECUP GLOSA','0017','RATEIO','CONTA')) tipo , "  
cquery += CRLF+"        trim(BD6F.BD6_MATRIC) matric , "
cquery += CRLF+"        trim(BD6F.BD6_TIPREG) tipreg , "
cquery += CRLF+"        substr(BD6F.BD6_NOMUSR,1,20) nomusr  , "

cquery += CRLF+"        SUM(BD7F.VLRPAG)  VlrAprov ,  SUM(BD7F.VLRGLO)  VlrGLOSA , SUM(BD7F.VLRAPR)  VLRAPR , " 
cquery += CRLF+"        SUM(DECODE(BD6F.BD6_BLOCPA,'1',0,BD6F.BD6_VLRBPF)) VlrBPart , "
cquery += CRLF+"        SUM(DECODE(BD6F.BD6_BLOCPA,'1',0,BD6F.BD6_VLRTPF)) VlrTotPart , "        
cquery += CRLF+"        decode(bd6f.bd6_codemp,'0004',(SUM(DECODE(BD6F.BD6_BLOCPA,'1',0,BD6F.BD6_VLRTPF)) - SUM(DECODE(BD6F.BD6_BLOCPA,'1',0,BD6F.BD6_VLRBPF))),0) Vlrtx ,"

cquery += CRLF+"        trim(BD6F.BD6_NOMRDA) NOMRDA , "          
cquery += CRLF+"        nvl(OPE.OPEORI,'0000') OPEORI , nvl(OPE.NOMOPE, '')NOMOPE , nvl(OPE.VLRCOB,'0') VLRCOB ,TRIM(Bqc.Bqc_Descri) OPECONV , " 
cquery += CRLF+"        ZZT_CODEV , ZZT_EVENTO , ZZT_TPCUST "    
If  !EMPTY (cCodAnals) 
  cquery += CRLF+"      , trim(BD7F.CODANA) CODANA  "          
EndIf 
cquery += CRLF+"   FROM ( "    
cquery += CRLF+"           SELECT '10'||BGH_GRUOPE OPEORI , BA2_DESCRI NOMOPE ,  BGH_VLRTRC VLRCOB  "
cquery += CRLF+"             FROM "+RetSqlName("BGH")+" BGH ,"+ RetSqlName("BA2") +" BA2" 
cquery += CRLF+"            WHERE BA2_FILIAL = '"+ xFilial('BA2') + "'  AND BA2.D_E_L_E_T_ = ' ' 
cquery += CRLF+"              AND BGH_FILIAL = '"+ xFilial('BGH') + "'  AND BGH.D_E_L_E_T_ = ' ' 
cquery += CRLF+"              AND BGH_DATFIN = ' ' AND BA2_GRUOPE = BGH_GRUOPE ) OPE  , ("

cquery += CRLF+"          SELECT BD7.BD7_FILIAL,BD7_CODPLA,SIGA_TIPO_EXPOSICAO_ANS(BD7_CODEMP,BD7_MATRIC,BD7_TIPREG,TO_DATE(TRIM(BD7_DATPRO),'YYYYMMDD')) EXPOS, " 
cquery += CRLF+"                 BD7.BD7_OPELOT, BD7.BD7_YFAS35 , BD7.BD7_FASE , BD7.BD7_NUMLOT ,  BD7.BD7_DATPRO , " 
cquery += CRLF+"                 BD7.BD7_CODOPE, BD7.BD7_CODLDP, BD7.BD7_CODPEG, BD7.BD7_NUMERO, BD7.BD7_ORIMOV, BD7_CODPRO , "
cquery += CRLF+"                 BD7.BD7_SEQUEN,  SUM(BD7.BD7_VLRPAG) AS VLRPAG , SUM(BD7.BD7_VLRGLO) AS VLRGLO , SUM(BD7.BD7_VLRMAN) AS VLRAPR  , BD7.BD7_BLOPAG , "//BD7.BD7_CODRDA  , bd7.bd7_nomrda , " 
cquery += CRLF+"                 COUNT(DISTINCT BD7_CODEMP||BD7_MATRIC||BD7_TIPREG) QTDE "  

If !EMPTY (cCodAnals)        
   cquery += CRLF+"              , NVL(SZN.ZN_CODANA,' ') CODANA  "  
EndIf    

cquery += CRLF+"            FROM "+ RetSqlName("BD7") + " BD7 " 

If !EMPTY (cCodAnals)                                           
    cquery += CRLF+" , "+ RetSqlName("SZN") + " SZN " 
EndIf

cquery += CRLF+"           WHERE BD7.BD7_FILIAL='"+ xFilial('BD7') + "' "

If !EMPTY (cCodAnals)                                                    
   cquery += CRLF+" AND SZN.ZN_FILIAL='"+ xFilial('SZN') + "' "
   cquery += CRLF+" AND SZN.D_E_L_E_T_ = ' ' "
EndIf                      

cquery += CRLF+"             AND BD7.BD7_CODOPE = '0001' "
cquery += CRLF+"             AND BD7.BD7_SITUAC = '1'  "

If  cpgtBloq == 1
    cquery += CRLF+"             AND BD7.BD7_BLOPAG = '1' " 
ElseIf  cpgtBloq  == 2
    cquery += CRLF+"             AND BD7.BD7_BLOPAG <> '1' "  
EndIf  

If !empty(cLocDig)
    cquery += CRLF+"             AND BD7.BD7_CODLDP =  '"+cLocDig+"' "       
EndIf 

If cFase == 1
   cquery += CRLF+"             AND BD7.BD7_FASE = '3' and BD7.BD7_yfas35 = 'T' "   
ElseIf cFase == 2 
   cquery += CRLF+"             AND BD7.BD7_FASE = '4' "                          
ElseIf cFase == 3 
   cquery += CRLF+"             AND ((BD7.BD7_FASE ='1' or BD7.BD7_FASE ='2') and BD7.BD7_yfas35 = 'F') "      
ElseIf cFase == 4 
   cquery += CRLF+"             AND (BD7.BD7_FASE = '3' or BD7.BD7_FASE  = '4') "         
EndIf    

If !EMPTY (cCodEmpI)
   cquery += CRLF+"             AND BD7.BD7_CODEMP  >= '"+cCodEmpI+"' " 
   cquery += CRLF+"             AND BD7.BD7_CODEMP  <= '"+cCodEmpF+"' "
EndIf         

If !EMPTY (cMesBase)
   cquery += CRLF+"             AND BD7.BD7_MESPAG  = '"+cMesBase+"' "
EndIf                                                         

If !EMPTY (cAnoBase)
   cquery += CRLF+"             AND BD7.BD7_ANOPAG  = '"+cAnoBase+"' "
EndIf    

If !EMPTY (cCodRdaI)                                                  
   cquery += CRLF+"             AND BD7.BD7_CODRDA >= '"+cCodRdaI+"' " 
   cquery += CRLF+"             AND BD7.BD7_CODRDA <= '"+cCodRdaF+"' "
EndIf                                                                  

If !EMPTY (cCodAnals)                                                   
    If cCodAnals != '999999'
   	   cQuery += CRLF+" AND ZN_CODANA  = '" +cCodAnals +"' "  
   	EndIf 
   	cQuery += CRLF+" AND ZN_CODRDA  = BD7.BD7_CODRDA " 	    		 
   	cQuery += CRLF+" AND (ZN_VIGFIM = ' ' OR ZN_VIGFIM >= BD7.BD7_MESPAG||BD7.BD7_ANOPAG) " 	    		
EndIf

If !EMPTY (cCompCusto)
   cquery += CRLF+"             AND BD7.BD7_NUMLOT LIKE '"+cCompCusto + '%'+"' "
EndIf

cquery += CRLF+"             AND BD7.D_E_L_E_T_ = ' ' "
cquery += CRLF+"           GROUP BY BD7_FILIAL, BD7_CODPLA, BD7.BD7_OPELOT,BD7_CODPRO , bd7.BD7_DATPRO ," 
cquery += CRLF+"                 SIGA_TIPO_EXPOSICAO_ANS(BD7_CODEMP,BD7_MATRIC,BD7_TIPREG,TO_DATE(TRIM(BD7_DATPRO),'YYYYMMDD')) ,BD7.BD7_NUMLOT , "//BD7.BD7_CODRDA , bd7.bd7_nomrda , "
cquery += CRLF+"                 BD7_FILIAL, BD7_CODOPE, BD7_CODLDP, BD7_CODPEG, BD7_NUMERO, BD7_ORIMOV, BD7_SEQUEN, BD7.BD7_YFAS35 , BD7.BD7_FASE ,BD7.BD7_BLOPAG  "
If !EMPTY (cCodAnals)        
   cquery += CRLF+"              , NVL(SZN.ZN_CODANA,' ')  "  
EndIf    


cquery += CRLF+"              ) BD7F, "+ RetSqlName("BD6") + " BD6F ,"+ RetSqlName("BI3") + " BI3 ,"+ RetSqlName("ZZT") + " ZZT ,"+ RetSqlName("BR8") + " BR8  , "+ RetSqlName("BA1") + " BA1, "+ RetSqlName("BQC") + " BQC"   
cquery += CRLF+"           WHERE ZZT_FILIAL='"+ xFilial('ZZT') + "' "
cquery += CRLF+"             AND BI3_FILIAL='"+ xFilial('BI3') + "' "
cquery += CRLF+"             AND BR8_FILIAL='"+ xFilial('BR8') + "' "
cquery += CRLF+"             AND BQC_FILIAL='"+ xFilial('BQC') + "' "
cquery += CRLF+"             AND BD6F.BD6_CODPAD=BR8_CODPAD "
cquery += CRLF+"             AND BD6F.BD6_CODPRO=BR8_CODPSA "
cquery += CRLF+"             AND BR8.D_E_L_E_T_=' ' " 
cquery += CRLF+"             AND BQC.D_E_L_E_T_=' ' " 
cquery += CRLF+"             AND BD6F.BD6_FILIAL='"+ xFilial('BD6') + "' " 
cquery += CRLF+"             AND BD7F.BD7_FILIAL = BD6F.BD6_FILIAL " 
cquery += CRLF+"             AND BD7F.BD7_CODOPE = BD6F.BD6_CODOPE " 
cquery += CRLF+"             AND BD7F.BD7_CODLDP = BD6F.BD6_CODLDP " 
cquery += CRLF+"             AND BD7F.BD7_CODPEG = BD6F.BD6_CODPEG " 
cquery += CRLF+"             AND BD7F.BD7_NUMERO = BD6F.BD6_NUMERO " 
cquery += CRLF+"             AND BD7F.BD7_ORIMOV = BD6F.BD6_ORIMOV " 
cquery += CRLF+"             AND BD7F.BD7_SEQUEN = BD6F.BD6_SEQUEN " 
cquery += CRLF+"             AND BD6F.BD6_CODPRO = BD7F.BD7_CODPRO " 
cquery += CRLF+"             AND BI3_FILIAL =BD7_FILIAL " 
cquery += CRLF+"             AND BI3_CODINT=BD7_CODOPE "
cquery += CRLF+"             AND BI3_CODIGO=BD7_CODPLA "    

cquery += CRLF+" AND siga.RETORNA_EVENTO_BD5(BD6_OPEUSR,BD6_CODLDP, BD6_CODPEG,BD6_NUMERO,BD6_ORIMOV,BD6_CODPAD,BD6_CODPRO,'"+ iif(cEmpAnt=='01','C','I') + "' ) = ZZT_CODEV "
//cquery += CRLF+"             AND BD6_YNEVEN=ZZT_CODEV "    

if !Empty( cCodPeg )
   cquery += CRLF+"             AND BD6F.BD6_CODPEG like '%"+trim(cCodPeg)+"' " 
EndIf 
        
If  cCopatBloq == 1
    cquery += CRLF+"             AND BD6F.BD6_BLOCPA = '1' " 
ElseIf  cCopatBloq == 2
    cquery += CRLF+"             AND BD6F.BD6_BLOCPA <> '1' "  
EndIf       
   
cquery += CRLF+"             AND BD6F.BD6_OPEORI = OPE.OPEORI(+) "

cquery += CRLF+"             AND BD6F.D_E_L_E_T_ = ' ' " 
cquery += CRLF+"             AND BI3.D_E_L_E_T_ = ' ' " 
cquery += CRLF+"             AND ZZT.D_E_L_E_T_ = ' ' "   

cquery += CRLF+"             AND BA1.BA1_FILIAL = ' ' "
cquery += CRLF+"             AND BA1.D_e_l_e_t_ = ' ' "
cquery += CRLF+"             AND BA1.BA1_CODEMP = BD6F.BD6_CODEMP "
cquery += CRLF+"             AND BA1.BA1_MATRIC = BD6F.BD6_MATRIC "
cquery += CRLF+"             AND BA1.BA1_TIPREG = BD6F.BD6_TIPREG "

cquery += CRLF+"             AND BQC_CODIGO = '0001'||BD6_CODEMP" 
cquery += CRLF+"             AND BQC_NUMCON = BD6_CONEMP"
cquery += CRLF+"             AND BQC_SUBCON = BD6_SUBCON"

If !Empty (cNumFat)    
   cquery += CRLF+"          AND BD6F.BD6_NUMFAT = '0001"+cNumFat+"' "
EndIf 

If !Empty (cOpeOri)                                                   
   cquery += CRLF+"          AND BD6F.BD6_OPEORI= '"+cOpeOri+"' "
EndIf    
   
If cConfDif = 1       

   cquery += CRLF+"   HAVING  SUM(BD7F.VLRPAG) <> SUM(DECODE(BD6F.BD6_BLOCPA,'1',0,BD6F.BD6_VLRBPF)) " 

EndIf 

cquery += CRLF+"           GROUP BY BD6F.BD6_NUMFAT , "
cquery += CRLF+"                    BD6F.BD6_ANOPAG , "
cquery += CRLF+"                    BD6F.BD6_MESPAG , "
cquery += CRLF+"                    BD7F.BD7_NUMLOT , "
cquery += CRLF+"                    decode(trim(BD7F.BD7_FASE),'4','Fat','1','Dig','2','Conf','3',(decode(trim(BD7F.BD7_YFAS35),'T','31/2','Prt')),  'NAO PRONTA') , "
cquery += CRLF+"                    BD6F.BD6_CODEMP , "
cquery += CRLF+"                    BD6F.BD6_opeori , "
cquery += CRLF+"                    BD6F.BD6_CODOPE , "
cquery += CRLF+"                    BD6F.BD6_CODLDP , "
cquery += CRLF+"                    BD6F.BD6_CODPEG , "
cquery += CRLF+"                    BD6F.BD6_NUMERO , " 
cquery += CRLF+"                    BD6F.BD6_ORIMOV , "
cquery += CRLF+"                    BD6F.BD6_SEQUEN , "    

cquery += CRLF+"                    BD6F.BD6_DESPRO , "   

cquery += CRLF+"                    BD7F.BD7_CODPRO , BD6F.BD6_CODRDA , "
cquery += CRLF+"                    DECODE(BD6_CODLDP,'0010','RECUP','0017','RATEIO','CONTA') ,BD7F.BD7_FASE , bd6f.bd6_NOMRDA , OPE.OPEORI , OPE.NOMOPE , OPE.VLRCOB ,  "
cquery += CRLF+"                    BD6F.BD6_MATRIC , BD6F.BD6_TIPREG , BD6F.BD6_NOMUSR , BD6F.BD6_BLOCPA , BD7F.BD7_BLOPAG , decode(trim(BD6F.BD6_seqpf), '', 'Não' , 'Sim') ,  "

cquery += CRLF+"                    ZZT_CODEV , ZZT_EVENTO , ZZT_TPCUST ,BD7_DATPRO , BA1_DATINC , Bqc.Bqc_Descri "      

If  !EMPTY (cCodAnals) 
  cquery += CRLF+"      , trim(BD7F.CODANA)  "    
EndIf       
////////////////////////////////////   
If cCodAnals == '999999'
   cquery += CRLF+" order by 35,7 , 1 , 2 , 8 , 18  "
Else
   If cOdenar = 1 
      cquery += CRLF+" order by 12 , 1 , 2 , 8 , 18  "
   Else 
      cquery += CRLF+" order by 7 , 1 , 2 , 8 , 18  "
   EndIf    
EndIf          
                                                                                   
/////////////////////////////////////////*                                         	
memowrite('C:\TEMP\CABR237.SQL',cquery)   	
If Select((cAliastmp)) <> 0 
  (cAliastmp)->(DbCloseArea()) 
Endif

TCQuery cQuery New Alias (cAliastmp)  
    
dbSelectArea(cAliastmp)
   
(cAliastmp)->(dbGoTop())   
     
While (cAliastmp)->(!Eof())             


Perctx:= 0
If  (cAliastmp)->Copart == 'Não' .or. (cAliastmp)->VlrTotPart == 0
   
    Perctx:= 0

Else     

    Perctx:= ROUND((((cAliastmp)->VlrTotPart * 100) / (cAliastmp)->VlrBPart  ),1)    
        
EndIf 
 Perctx := IIf(Perctx >= 100 , Perctx - 100 , Perctx)       
 
 If  !EMPTY (cCodAnals) 
     cAnalista:=  (cAliastmp)->CODANA  
 Else 
     cAnalista:=' '                 
EndIf 
      aaDD(aDados1,{(cAliastmp)->Copart ,;
				    (cAliastmp)->numfat ,;
					(cAliastmp)->mespag +'/'+(cAliastmp)->anopag ,;
					(cAliastmp)->numlot ,;
					(cAliastmp)->fase   ,;
					(cAliastmp)->codemp ,;
					(cAliastmp)->opeori ,;
					(cAliastmp)->codope ,;
					(cAliastmp)->codldp ,;
					(cAliastmp)->codpeg ,;
					(cAliastmp)->numero ,;
					(cAliastmp)->orimov ,;
					(cAliastmp)->sequen ,;
					(cAliastmp)->codpro ,;
					(cAliastmp)->tipo   ,; 
					(cAliastmp)->matric ,;
					(cAliastmp)->tipreg    ,;
					(cAliastmp)->nomusr    ,;      
					(cAliastmp)->VlrAprov  ,; 
					(cAliastmp)->VlrBPart  ,;
					(cAliastmp)->VlrTotPart,;
					(cAliastmp)->Vlrtx     ,;  
                    Perctx                 ,;
                    (cAliastmp)->pagto     ,;  
                    (cAliastmp)->CODRDA    ,;
                    (cAliastmp)->seqpf     ,; 
                    (cAliastmp)->NOMRDA    ,;  
                    (cAliastmp)->NOMOPE    ,;
                    (cAliastmp)->VLRCOB    ,;
                     cAnalista             ,;
                    (cAliastmp)->ZZT_CODEV ,;
                    (cAliastmp)->ZZT_EVENTO,;
                    (cAliastmp)->ZZT_TPCUST,; 
                    (cAliastmp)->DATINC    ,;
                    (cAliastmp)->DATPRO    ,;
                    (cAliastmp)->VLRGLOSA  ,;
                    (cAliastmp)->VLRAPR    ,;
                    (cAliastmp)->DESPRO    ,;
                    (cAliastmp)->OPECONV})    
					                     
                  cData := StoD( (cAliastmp)->DATPRO)
  //  cData := DtoS( ( (cAliastmp)->DATPRO + nDiasSrvPrt ) ) 
/*	If M->BTF_RETROA <> '1'   
		cData := (M->BTF_DATGER-val(nDiasSrvPrt))
		cSql += "AND BD5_DATPRO >= '"+Dtos(cData)+"' "
	Endif    
*/
       (cAliastmp)->(dbSkip()) 	   
EndDo	         
     
         
Return                    

//*************************************************************************************************************  
Static Function fGeraRel2

Local oReport 
Private cPerg		:= "CABR237"  
Private aOrdem 		:= {}//{'RDA','Ano/Mes'}

//aSort( aDados1,,,{|x,y| x[10] < y[10]} )

oReport:= ReportDef2()
oReport:PrintDialog()

Return

//*************************************************************************************************************

//********************************************************************************************************************************

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
oReport	:= TReport():New("CABR237","Cobrança de coparticipação , convenios de reciprocidade e repasse caberj/integral" ,, {|oReport| ReportPrt(oReport)},"Cobrança de coparticipação , convenios de reciprocidade e repasse caberj/integral" )
oReport:SetTotalInLine(.F.)//Imprime na linha: .F. - Imprime abaixo da linha com o titulo de cada coluna: .T.
//oReport:SetTotalText('Total Geral')    


//*'-----------------------------------------------------------------------------------'*
//*'Solucao para impressao em que as colunas se truncam: "SetColSpace" e "SetLandScape"'* 
//*'-----------------------------------------------------------------------------------'*

oReport:SetColSpace(1) //Espacamento entre colunas. 
oReport:SetLandscape() //Impressao em paisagem.  codemp
//oReport:SetPortrait() //Impressao em retrato.  
oReport:oPage:setPaperSize(9)  

oDPJ := TRSection():New(oReport,"Cobrança de coparticipação , convenios de reciprocidade e repasse caberj/integral"  ,,aOrdem)             

   TRCell():New(oDPJ ,'CPTENTRA'	     	 ,/*TABELA*/	,'Comp Ent'               ,/*Picture*/   	    ,07				,,,,,"LEFT"		) 
   TRCell():New(oDPJ ,'CPTCUSTO'		    ,/*TABELA*/	,'Comp Cust'              ,/*Picture*/   	    ,10				,,,,,"LEFT"		)
   TRCell():New(oDPJ ,'NUMFAT'		    ,/*TABELA*/	,'Num Fatura'             ,/*Picture*/   	    ,12				,,,,,"LEFT"		)  
   TRCell():New(oDPJ ,'CONSOL'		    ,/*TABELA*/	,'Consol '                ,/*Picture*/   	    ,03				,,,,,"LEFT"		)  
   TRCell():New(oDPJ ,'CODRDA'		    ,/*TABELA*/	,'RDA '                   ,/*Picture*/   	    ,06				,,,,,"LEFT"		)    
   TRCell():New(oDPJ ,'FASECUST'	       ,/*TABELA*/	,'Fase'                   ,/*Picture*/   	    ,04				,,,,,"LEFT"		)    
   TRCell():New(oDPJ ,'CODEMP'		    ,/*TABELA*/	,'Emp.'                   ,/*Picture*/   	    ,04				,,,,,"LEFT"		) 
   TRCell():New(oDPJ ,'OPEORI'		    ,/*TABELA*/	,'Op.Orig '               ,/*Picture*/   	    ,04				,,,,,"LEFT"		)
   TRCell():New(oDPJ ,'CODOPE'		    ,/*TABELA*/	,'Cod Ope.'               ,/*Picture*/   	    ,04				,,,,,"LEFT"		)
   TRCell():New(oDPJ ,'CODLDP'	       ,/*TABELA*/	,'Loc Digt'               ,/*Picture*/   	    ,04				,,,,,"LEFT"		)  
   TRCell():New(oDPJ ,'CODPEG'		    ,/*TABELA*/	,'Cod Peg'                ,/*Picture*/   	    ,08				,,,,,"LEFT"		) 
   TRCell():New(oDPJ ,'NUMERO'		    ,/*TABELA*/	,'Numero'                 ,/*Picture*/   	    ,08				,,,,,"LEFT"		)
   TRCell():New(oDPJ ,'ORIMOV'		    ,/*TABELA*/	,'Org'                    ,/*Picture*/   	    ,01				,,,,,"LEFT"		)
   TRCell():New(oDPJ ,'SEQUEN'	       ,/*TABELA*/	,'Seq'                    ,/*Picture*/   	    ,03				,,,,,"LEFT"		)                                                                                                                                   
   TRCell():New(oDPJ ,'CODPRO'		    ,/*TABELA*/	,'Cod Proc'               ,/*Picture*/   	    ,10				,,,,,"LEFT"		) 
   TRCell():New(oDPJ ,'TIPO'		       ,/*TABELA*/	,'Tipo'                   ,/*Picture*/   	    ,06				,,,,,"LEFT"		)
   TRCell():New(oDPJ ,'MATRIC'		    ,/*TABELA*/	,'Matric'                 ,/*Picture*/   	    ,06				,,,,,"LEFT"		)
   TRCell():New(oDPJ ,'TIPREG'	       ,/*TABELA*/	,'TReg'                   ,/*Picture*/   	    ,02				,,,,,"LEFT"		)                                                                                                                                    
   TRCell():New(oDPJ ,'NOMUSR'		    ,/*TABELA*/	,'Nome Usuario'           ,/*Picture*/   	    ,15				,,,,,"LEFT"		) 
   TRCell():New(oDPJ ,'VLRAPRS'	       ,/*TABELA*/	,'Vlr Aprtdo'             ,"@E  999,999.99" 	 ,10				,,,,,"RIGHT"	) 
   TRCell():New(oDPJ ,'VLRAPR'	       ,/*TABELA*/	,'Vlr Pago '              ,"@E  999,999.99" 	 ,10				,,,,,"RIGHT"	)     
   TRCell():New(oDPJ ,'VLRGLO'	       ,/*TABELA*/	,'Vlr Glosad'             ,"@E  999,999.99" 	 ,10				,,,,,"RIGHT"	)
   TRCell():New(oDPJ ,'VLBPAR'	       ,/*TABELA*/	,'Vl B. Part'             ,"@E  999,999.99" 	 ,10				,,,,,"RIGHT"	) 
   TRCell():New(oDPJ ,'VLTPAR'	       ,/*TABELA*/	,'Vl Tt Part'             ,"@E  999,999.99" 	 ,10				,,,,,"RIGHT"	)     
   TRCell():New(oDPJ ,'VLRTX'	       	 ,/*TABELA*/	,'Vl Taxa '               ,"@E   99,999.99" 	 ,09				,,,,,"RIGHT"	)
   TRCell():New(oDPJ ,'PRCTX'	          ,/*TABELA*/	,'% Taxa'                 ,"@E      999.99" 	 ,06				,,,,,"RIGHT"	)
   TRCell():New(oDPJ ,'COPSN'		       ,/*TABELA*/	,'B.Cop?'                 ,/*Picture*/   	    ,03				,,,,,"LEFT"		) 
   TRCell():New(oDPJ ,'PGTSN'		       ,/*TABELA*/	,'B.Pgt?'                 ,/*Picture*/   	    ,03				,,,,,"LEFT"		) 
  // TRCell():New(oDPJ ,'CONVIO'  	       ,/*TABELA*/	,'Convenio'               ,/*Picture*/   	    ,15				,,,,,"LEFT"		) 

If cOdenar = 1                                                 
   oBreak01 		:= TRBreak():New(oDPJ,oDPJ:Cell("OPEORI"),"Subtotal "	,.F.)    
else 
   oBreak01 		:= TRBreak():New(oDPJ,oDPJ:Cell("CODRDA"),"Subtotal "	,.F.)    
endIf     

lTotSecBrk01	:= .T.//Indica se totalizador sera impresso na quebra de secao
lTotFimBrk01	:= .T.//Indica se totalizador sera impresso no final do relatorio - Como o total eh o mesmo, basta que apenas um esteja ativado


TRFunction():New(oDPJ:Cell("VLRAPR")   		,NIL,"SUM"			,oBreak01,,"@E  99,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01) 
TRFunction():New(oDPJ:Cell("VLBPAR")   		,NIL,"SUM"			,oBreak01,,"@E  99,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01)  
TRFunction():New(oDPJ:Cell("VLTPAR")   		,NIL,"SUM"			,oBreak01,,"@E  99,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01) 
TRFunction():New(oDPJ:Cell("VLRTX")   		,NIL,"SUM"			,oBreak01,,"@E   9,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01) 

     
Return(oReport)

//********************************************************************************************************************************

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

       oDPJ:Cell('CPTENTRA'	    ):SetValue(aDados1[i][03])
       oDPJ:Cell('CPTCUSTO'    	):SetValue(aDados1[i][04])
       oDPJ:Cell('NUMFAT' 		):SetValue(aDados1[i][02])
       oDPJ:Cell('CONSOL' 		):SetValue(aDados1[i][26])
       oDPJ:Cell('FASECUST'	    ):SetValue(aDados1[i][05]) 
       oDPJ:Cell('CODRDA'	    ):SetValue(aDados1[i][25])
       oDPJ:Cell('CODEMP'    	):SetValue(aDados1[i][06])
       oDPJ:Cell('OPEORI' 		):SetValue(aDados1[i][07])       
       oDPJ:Cell('CODOPE'	    ):SetValue(aDados1[i][08]) 
       oDPJ:Cell('CODLDP'    	):SetValue(aDados1[i][09])
       oDPJ:Cell('CODPEG' 		):SetValue(aDados1[i][10]) 
       oDPJ:Cell('NUMERO'	    ):SetValue(aDados1[i][11]) 
       oDPJ:Cell('ORIMOV'    	):SetValue(aDados1[i][12])
       oDPJ:Cell('SEQUEN' 		):SetValue(aDados1[i][13])        
       oDPJ:Cell('CODPRO'	    ):SetValue(aDados1[i][14]) 
    //   oDPJ:Cell('UNM'	        ):SetValue(aDados1[i][25])
       oDPJ:Cell('TIPO'      	):SetValue(aDados1[i][15])
       oDPJ:Cell('MATRIC' 		):SetValue(aDados1[i][16]) 
       oDPJ:Cell('TIPREG'	    ):SetValue(aDados1[i][17]) 
       oDPJ:Cell('NOMUSR'    	):SetValue(aDados1[i][18])      
       oDPJ:Cell('VLRAPRS'		):SetValue(aDados1[i][37])                
       
       oDPJ:Cell('VLRAPR' 		):SetValue(aDados1[i][19])      
       oDPJ:Cell('VLRGLO'	    ):SetValue(aDados1[i][36]) 
       oDPJ:Cell('VLBPAR'	    ):SetValue(aDados1[i][20]) 
       oDPJ:Cell('VLTPAR'    	):SetValue(aDados1[i][21])
       oDPJ:Cell('VLRTX' 		):SetValue(aDados1[i][22]) 
       oDPJ:Cell('PRCTX'	    ):SetValue(aDados1[i][23]) 
       oDPJ:Cell('COPSN'	    ):SetValue(aDados1[i][01]) 
       oDPJ:Cell('PGTSN'	    ):SetValue(aDados1[i][24]) 
    //   oDPJ:Cell('CONVIO'	    ):SetValue(aDados1[i][39]) 

   oDPJ:PrintLine()
   
Next i

oDPJ:Finish()

Return   

//******************************************************************************************

Static Function AjustaSX1(cPerg)

Local aHelpPor := {}

PutSx1(cPerg,"01",OemToAnsi("Cod. Empresa De ")    		,"","","mv_ch1","C",04,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","","",{},{})    
PutSx1(cPerg,"02",OemToAnsi("Cod. Empresa Ate ")   		,"","","mv_ch2","C",04,0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","","",{},{})    
PutSx1(cPerg,"03",OemToAnsi("Cod. Rda De ")      		,"","","mv_ch3","C",06,0,0,"G","","","","","mv_par03","","","","","","","","","","","","","","","","","",{},{})    
PutSx1(cPerg,"04",OemToAnsi("Cod. Rda Ate")     		,"","","mv_ch4","C",06,0,0,"G","","","","","mv_par04","","","","","","","","","","","","","","","","","",{},{})    
PutSx1(cPerg,"05",OemToAnsi("Mes Base  ")       		,"","","mv_ch5","C",02,0,0,"G","","","","","mv_par05","","","","","","","","","","","","","","","","","",{},{})
PutSx1(cPerg,"06",OemToAnsi("Ano Base  ")       		,"","","mv_ch6","C",04,0,0,"G","","","","","mv_par06","","","","","","","","","","","","","","","","","",{},{})    
PutSx1(cPerg,"07",OemToAnsi("Num. Fatura  ")       		,"","","mv_ch7","C",08,0,0,"G","","","","","mv_par07","","","","","","","","","","","","","","","","","",{},{})    
PutSx1(cPerg,"08",OemToAnsi("Compt. Custo ")       		,"","","mv_ch8","C",06,0,0,"G","","","","","mv_par08","","","","","","","","","","","","","","","","","",{},{})    
PutSx1(cPerg,"09",OemToAnsi("Fase         ") 	        ,"","","mv_ch9","N",01,0,0,"C","","","","","mv_par09","3 1/2","","",""," 4 ","","","Antes da 3 ","","","apartir 3","","","","","",{},{},{}) 
PutSx1(cPerg,"10",OemToAnsi("Copat Bloq ? ") 	        ,"","","mv_ch10","N",01,0,0,"C","","","","","mv_par10","Sim","","","","Não","","","Todos","","","","","","","","",{},{},{})  
PutSx1(cPerg,"11",OemToAnsi("Pagto Bloq ? ") 	        ,"","","mv_ch11","N",01,0,0,"C","","","","","mv_par11","Sim","","","","Não","","","Todos","","","","","","","","",{},{},{}) 
PutSx1(cPerg,"12",OemToAnsi("Lista Só Dif?") 	        ,"","","mv_ch12","N",01,0,0,"C","","","","","mv_par12","Sim","","","","Não","","","","","","","","","","","",{},{},{})              
PutSx1(cPerg,"13",OemToAnsi("Analista responsavel ")    ,"","","mv_ch13","C",06,0,0,"G","","","","","mv_par13","","","","","","","","","","","","","","","","","",{},{})    

PutSx1(cPerg,"14",OemToAnsi("Codigo Peg  ")       		,"","","mv_ch14","C",08,0,0,"G","","","","","mv_par14","","","","","","","","","","","","","","","","","",{},{})
PutSx1(cPerg,"15",OemToAnsi("Ordenar por  ") 	        ,"","","mv_ch15","N",01,0,0,"C","","","","","mv_par15"," Convenio","","","","Rda ","",""," ","","","","","","","","",{},{},{}) 
PutSx1(cPerg,"16",OemToAnsi("Gerar Excel ") 	        ,"","","mv_ch16","N",01,0,0,"C","","","","","mv_par16","Sim","","","","Não","","","","","","","","","","","",{},{},{}) 
PutSx1(cPerg,"17",OemToAnsi("Local de Digitação")       ,"","","mv_ch17","C",04,0,0,"G","","","","","mv_par17","","","","","","","","","","","","","","","","","",{},{})    
PutSx1(cPerg,"18",OemToAnsi("Operadora Origem  ")       ,"","","mv_ch18","C",04,0,0,"G","","","","","mv_par18","","","","","","","","","","","","","","","","","",{},{})    

Pergunte(cPerg,.F.)

Return()                 
