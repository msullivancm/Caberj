#INCLUDE "rwmake.ch"
#INCLUDE "topconn.ch"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ CABR079  บ Autor ณ Altamiro Affonso   บ Data ณ  28/05/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Relatorio de Auditotia de PA's                             บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP6 IDE                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
User Function CABR079

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Declaracao de Variaveis                                             ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

Local cDesc1         := "Este programa tem como objetivo imprimir relatorio "
Local cDesc2         := "de auditoria de PA e seus lastros , financeiros    "
Local cDesc3         := "Tit. a Pagar-Guias cont. medicas bloqueadas ou nao "
Local cPict          := ""
Local titulo         := "AUDITORIA - PA e seus lastros financeiros         "
Local nLin           := 80 
LOCAL pMoeda2	     := "@E 99,999,999.99"																									     // 10/09/2008 - ALTAMIRO
Local Cabec1         := "   - - - - - - - - - - - - - - - - - - - - - P A - - - - - - - - - - - - - - - - - - - -        - - - - - - - - - FINANCEIRO - - - - - - - - -       - - - - Contas Medicas - - - -     - - - - - - Deb/Cred - - - - - -  "
Local Cabec2         := "Cod Form Cod Rda  Nome                            Titulo              Emissao         Saldo  Titulo              Emissao     Vencto         Saldo  Lot Bl Fase  F31/2        Valor    Comp Desc                      Valor"
//                       1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//                       0        1         2         3         4         5         6         7         8         9        100        1         2         3         4         5         6         7         8         9        200        1         2
//                       XXXXXX    XXXXXX  XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX XXX-XXXXXXXXX-XX 99/99/9999 99.999.999,99  XXX-XXXXXXXXX-XX 99/99/9999 99/99/9999 99.999.999,99  XXXXXX   X   XXX  99.999.999,99 XX/XXXX XXXXXXXXXXXXXXXXXXXXX 999.999,99
Local imprime        := .T.
Local aOrd           := {}
Private lEnd         := .F.
Private lAbortPrint  := .F.
Private CbTxt        := ""
Private limite       := 221
Private tamanho      := "G"
Private nomeprog     := "CABR079"
Private nTipo        := 15
Private aReturn      := { "Zebrado", 1, "Administracao", 1, 2, 1, "", 1}
Private nLastKey     := 0
Private cbtxt        := Space(10)
Private cbcont       := 00
Private CONTFL       := 01
Private m_pag        := 01                         
Private wnrel        := "CABR079"
Private cString      := "SE2"
Private cPerg        := "CABR79"   
private aCabec1      := {"Cod Form","Cod Rda","Nome","N.Titulo","Emissao", "Saldo" ,"Titulo","Emissao","Vencto","Saldo","Lot Bl","Fase","F31/2","Valor " ,"Comp","Desc","Valor"}
private aDados       := {}
private pMoeda2	     := "@E 99,999,999.99"	     
private cFornece     := ''                  
private cpreffil     := '' 
private cCodRdaC     := ' ' 

private cCodFor      := ' '
private cCodRda      := ' '  
private cNome        := ' '
private cTitp        := ' '
private cEmisp       := ' '
private nSaldp       := 0.00        
private cTitf        := ' '
private cEmisf       := ' ' 
private cVenctf      := ' '
private nSaldf       := 0.00
private clotblo      := ' ' 
private cFase        := ' '
private cfase3       := ' '
private nValorPM     := 0.00
private cComp        := ' ' 
private cDesc        := ' '
private nValordB     := 0.00

PRIVATE VlrTotPa     := 0.00 
PRIVATE VlrTotFi     := 0.00 
PRIVATE VlrTotCm     := 0.00 
PRIVATE VlrTotDb     := 0.00 

PRIVATE VlrGPa       := 0.00 
PRIVATE VlrGFi       := 0.00 
PRIVATE VlrGCm       := 0.00 
PRIVATE VlrGDb       := 0.00

dbSelectArea("SE2")
dbSetOrder(1)

ValidPerg(cPerg)
If Pergunte(cPerg,.T.) = .F.
	Return
Endif
private nGeraExcel  := mv_par11
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Monta a interface padrao com o usuario...                           ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

wnrel := SetPrint(cString,NomeProg,"",@titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,.F.,Tamanho,,.T.)

If nLastKey == 27
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
	Return
Endif

nTipo := If(aReturn[4]==1,15,18)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Processamento. RPTSTATUS monta janela com a regua de processamento. ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

RptStatus({|| RunReport(Cabec1,Cabec2,Titulo,nLin) },Titulo)
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuno    ณRUNREPORT บ Autor ณ AP6 IDE            บ Data ณ  31/08/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescrio ณ Funcao auxiliar chamada pela RPTSTATUS. A funcao RPTSTATUS บฑฑ
ฑฑบ          ณ monta a janela com a regua de processamento.               บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Programa principal                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/

Static Function RunReport(Cabec1,Cabec2,Titulo,nLin)
Local nOrdem
Local cQuery := ' '
dbSelectArea(cString)
dbSetOrder(1)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ SETREGUA -> Indica quantos registros serao processados para a regua ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

SetRegua(RecCount())                    
                 
cQuery := " select SE2.e2_prefixo , SE2.e2_num , SE2.e2_tipo ,sE2.e2_codrda , SE2.e2_fornece , SE2.e2_nomfor , SE2.e2_saldo , se2.e2_emissao, BAU_CODIGO , bau_tippre , BID_DESCRI  "   
cQuery += " FROM " + RetSqlName("SE2")+" SE2, "+ RetSQLName("BAU")+" BAU, " +  RetSQLName("BID")+" BID , " +  RetSQLName("sa2")+" sa2 " 
cQuery += " WHERE SE2.E2_FILIAL = '"+xFilial("SE2")+"' AND BAU.BAU_FILIAL = '"+xFilial("BAU")+"' AND   BID.BID_FILIAL = '"+xFilial("BID")+"' AND sa2.a2_FILIAL = '"+xFilial("SA2")+"' " 
cQuery += "   AND SE2.D_E_L_E_T_ = ' '         AND BAU.D_E_L_E_T_ = ' ' AND   BID.D_E_L_E_T_ = ' ' AND   SA2.D_E_L_E_T_ = ' ' and se2.e2_codrda <> ' ' and se2.e2_fornece = a2_cod "   
cQuery += "   and SE2.e2_tipo IN  ('PA','NDF') AND SE2.E2_SALDO > 0     And  bau_codigo = e2_codrda   AND BID.BID_CODMUN = BAU.BAU_MUN " 
if !empty (mv_par01)             
   cQuery += " AND e2_FORNECE  >= '"+mv_par01+"' AND e2_codrda <= '"+mv_par02+"'"
endIf   
if !empty (mv_par03)             
   cQuery += " AND e2_codrda >= '"+mv_par03+"' AND e2_codrda <= '"+mv_par04+"'"
endIf                                                                        
if !empty (mv_par05)             
   cQuery += " AND e2_EMISSAO >= '"+DtoS(mv_par05)+"'"  
   cQuery += " AND e2_EMISSAO <= '"+DtoS(mv_par06)+"'"      
endIf                                                                        
If mv_par09 <> 3 
   If mv_par09 = 1            
      cQuery += " AND a2_ytptitu = '6' "
   Else    
      cQuery += " AND a2_ytptitu <> '6' "
  EndIf
EndIf  
   cQuery += " order by e2_codrda " 
If Select("TMP") > 0
	dbSelectArea("TMP")
	dbclosearea()
Endif                

TCQuery cQuery Alias "TMP" New
dbSelectArea("TMP")
tmp->(dbGoTop()) 
ccodrdaC := tmp->e2_codrda  	
While TMP->( !Eof() )
      cQrE2  := " select SE2.e2_prefixo , SE2.e2_num , SE2.e2_tipo ,sE2.e2_codrda , SE2.e2_fornece , SE2.e2_nomfor , SE2.e2_saldo ,se2.e2_emissao , se2.e2_vencrea , E2_YLIBPLS , E2_ORIGEM , BAU_CODIGO , bau_tippre , BAU_TIPPE , BID_DESCRI "   
      cQrE2  += " FROM " + RetSqlName("SE2")+" SE2, "+ RetSQLName("BAU")+" BAU, " +  RetSQLName("BID")+" BID " 
      cQrE2  += " WHERE SE2.E2_FILIAL = '"+xFilial("SE2")+"' AND BAU.BAU_FILIAL = '"+xFilial("BAU")+"' AND   BID.BID_FILIAL = '"+xFilial("BID")+"' " 
      cQrE2  += " AND SE2.D_E_L_E_T_ = ' ' AND BAU.D_E_L_E_T_ = '  ' AND   BID.D_E_L_E_T_ = ' ' AND e2_codrda = '"+TMP->E2_CODRDA+" '"        
      cQrE2  += " and SE2.e2_tipo = 'FT'   AND SE2.E2_SALDO > 0      And  bau_codigo = e2_codrda AND BID.BID_CODMUN = BAU.BAU_MUN " 
      If Select("TMPE2") > 0
	     dbSelectArea("TMPE2")
	     dbclosearea()
      Endif                
      TCQuery cQrE2 Alias "TMPE2" New
      dbSelectArea("TMPE2")
      tmpE2->(dbGoTop())

      cQrBD7 := " select bd7_codrda , bd7_lotblo , bd7_fase , bd7_situac , Decode (bd7_yfas35  ,'T'  ,'Sim','Nใo')  faz35   , sum (bd7_vlrpag) valor " 
      cQrBD7 += " FROM " + RetSqlName("BD7")+" BD7 " 
      cQrBD7 += " where bd7_filial = ' ' and bd7.d_E_L_E_T_ = ' ' AND BD7_FASE <> '4' AND BD7_SITUAC = '1'  and bd7_codrda = '"+TMP->E2_CODRDA+" '"
      cQrBD7 += " AND BD7_VLRPAG > 0 AND ((bd7_lotblo = ' ' and  BD7_BLOPAG <> '1' AND ( BD7_CONPAG = '1' OR BD7_CONPAG = ' ' )) or (bd7_lotblo <>  ' ')) "
      
      if !empty (mv_par07)                                                                                        
         cQrBD7 += " AND bd7_datpro >= '"+dtos(mv_par07)+"'"  
         cQrBD7 += " AND bd7_datpro <= '"+dtos(mv_par08)+"'" 
      endIf                              
      If mv_par10 <> 3 
         If mv_par10 = 1            
           cQrBD7 += " AND BD7_FASE =  '3' "
         Else    
           cQrBD7 += " AND BD7_FASE <> '3' "
         EndIf
      EndIf  
      cQrBD7 += " group by bd7_codrda , bd7_lotblo , bd7_fase , bd7_situac , Decode (bd7_yfas35  ,'T'  ,'Sim','Nใo') "  
      cQrBD7 += " order by bd7_codrda , bd7_lotblo , bd7_fase , bd7_situac , Decode (bd7_yfas35  ,'T'  ,'Sim','Nใo') "    
      
      If Select("TMPBD7") > 0
	     dbSelectArea("TMPBD7")
	     dbclosearea()
      Endif                
      TCQuery cQrBD7 Alias "TMPBD7" New
      dbSelectArea("TMPBD7")
      TMPBD7->(dbGoTop())        
      
      cQrDC := " select bgq_codigo, bgq_mes ||'/'||bgq_ano comp, bgq_codlan ||'-'||bbb_descri  lanc , Sum (Decode (BGQ_TIPO , '2' ,BGQ_VALOR,(BGQ_VALOR *-1))) valor "
      cQrDC += " from  " + RetSqlName("BGQ")+" BGQ , "  + RetSqlName("BBB")+" BBB  " 
      cQrDC += " where bgq_filial = ' '        and bgq.d_E_L_E_T_ = ' '    and bbb_filial = ' ' and bbb.d_E_L_E_T_ = ' '   "
      cQrDC += " and bgq_codlan = bbb_codser and bgq_codlan    <> '050'  and bgq_numlot = ' ' and bgq_codigo = '"+TMP->E2_CODRDA+" '"   
      cQrDC += " group by bgq_codigo , bgq_mes ||'/'||bgq_ano , bgq_codlan ||'-'||bbb_descri  "
      If Select("TMPDC") > 0
	     dbSelectArea("TMPDC")
	     dbclosearea()
      Endif                
      TCQuery cQrDc Alias "TMPDC" New
      dbSelectArea("TMPDC")
      TMPDC->(dbGoTop())        
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Verifica o cancelamento pelo usuario...                             ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	
	If lAbortPrint
		@nLin,00 PSAY "*** CANCELADO PELO OPERADOR ***"
		Exit
	Endif
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Impressao do cabecalho do relatorio. . .                            ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	If nLin > 65 // Salto de Pแgina. Neste caso o formulario tem 55 linhas...
		nLin := Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
		nLin++
	Endif                                  

    While (TMPE2->( !Eof() ) .or. TMPBD7->( !Eof() ) .or. TMPDC->( !Eof() ) .or. (ccodrdaC == tmp->e2_codrda .AND. TMP->( !Eof() ) ) )                  
 
      	If ((ccodrdaC == tmp->e2_codrda) .and. (TMP->( !Eof() ) ) )                                   
      	   cCodFor      := tmp->e2_fornece
           cCodRda      := tmp->e2_codrda  
           cNome        := substr(tmp->e2_nomfor,1,30)
           cTitp        := tmp->e2_prefixo +'-'+ tmp->e2_num  +'-'+ tmp->e2_tipo
           cEmisp       := substr(tmp->e2_emissao,7,2)+'/'+substr(tmp->e2_emissao,5,2)+'/'+substr(tmp->e2_emissao,1,4)
           nSaldp       := tmp->e2_saldo              
           VlrTotPa     += tmp->e2_saldo 
           VlrGPa       += tmp->e2_saldo  
           dbSelectArea("TMP")
           TMP->(dbSkip())
               
        Else    
      	   cCodFor      := ' '
           cCodRda      := ' '  
           cNome        := space(30)
           cTitp        := ' '
           cEmisp       := ' '
           nSaldp       := 0.00                        
        EndIf   
 
        If TMPE2->( !Eof() )                                                   
           If tmpe2->E2_YLIBPLS $ "N|L" .and. tmpe2->E2_ORIGEM = 'PLSMPAG' .AND. tmpe2->BAU_TIPPE = 'J'
              cTitf        := tmpe2->E2_YLIBPLS //'*'
           Else
              cTitf        := ' '
           EndIf   
           cTitf        += tmpe2->e2_prefixo +'-'+ tmpe2->e2_num  +'-'+ tmpe2->e2_tipo
           cEmisf       := substr(tmpe2->e2_emissao,7,2)+'/'+substr(tmpe2->e2_emissao,5,2)+'/'+substr(tmpe2->e2_emissao,1,4) 
           cVenctf      := substr(tmpe2->e2_vencrea,7,2)+'/'+substr(tmpe2->e2_vencrea,5,2)+'/'+substr(tmpe2->e2_vencrea,1,4)
           nSaldf       := tmpe2->e2_saldo             
	  	   VlrTotFi     += tmpe2->e2_saldo
   	  	   VlrGFi       += tmpe2->e2_saldo  
   	  	   	dbSelectArea("TMPE2")
           TMPE2->(dbSkip())
        Else                                            
           cTitf        := ' '
           cEmisf       := ' ' 
           cVenctf      := ' '
           nSaldf       := 0.00                                           
        EndIf   
 
        If TMPBD7->( !Eof() )  
           clotblo      := TMPBD7->bd7_lotblo 
           cFase        := TMPBD7->bd7_fase
           cfase3       := TMPBD7->faz35
           nValorPm     := TMPBD7->valor        
	  	   VlrTotCm     += TMPBD7->valor  
	  	   VlrGCm       += TMPBD7->valor 
     	   dbSelectArea("TMPBD7")
           TMPBD7->(dbSkip())
        Else                  
           clotblo      := ' ' 
           cFase        := ' '
           cfase3       := ' '
           nValorPm     := 0.00 
        EndIf   
        If TMPDC->( !Eof() )                             
           cComp        := TMPDC->comp 
           cDesc        := SUBSTR(TMPDC->lanc,1,21)
           nValorDb     := TMPDC->valor  
           VlrTotDb     += TMPDC->valor  
	  	   VlrGDb       += TMPDC->valor 
  	   	   dbSelectArea("TMPDC")
           TMPDC->(dbSkip())
        Else 
           cComp        := ' ' 
           cDesc        := space(21)
           nValorDb     := 0.00 
        EndIf                                                                    
     
        @ nLin,001 PSAY cCodFor      
        @ nLin,011 PSAY cCodRda        
        @ nLin,019 PSAY cNome        
        @ nLin,051 PSAY cTitp        
        @ nLin,068 PSAY cEmisp 
        
       	If nSaldp != 0.00    
           @ nLin,078 PSAY nSaldp picture "@E 99,999,999.99"                                 
        else                                                 
           @ nLin,078 PSAY "             "         
        EndIf 
        
        @ nLin,094 PSAY cTitf        
        @ nLin,111 PSAY cEmisf        
        @ nLin,122 PSAY cVenctf      
      	
      	If nSaldf != 0.00       
           @ nLin,132 PSAY nSaldf picture "@E 99,999,999.99"                                                     
        else                                                 
           @ nLin,132 PSAY "             "         
        EndIf 
         
        @ nLin,148 PSAY clotblo      
        @ nLin,157 PSAY cFase        
        @ nLin,161 PSAY cfase3  
        If nValorPm != 0.00        
           @ nLin,165 PSAY nValorPm picture "@E 99,999,999.99"  
        Else                                                 
           @ nLin,165 PSAY "             "         
        EndIf         
        @ nLin,180 PSAY cComp
        @ nLin,188 PSAY cDesc   
        If nValorDb != 0.00       	   
           @ nLin,209 PSAY nValorDb picture "@E -999,999.99" 
        Else                                                 
           @ nLin,209 PSAY "          "         
        EndIf                                        
		nLin := nLin + 1 // Avanca a linha de impressao  

	   aaDD(aDados,{  cCodFor ,;      
                      cCodRda ,;        
                      cNome   ,;      
                      cTitp   ,;      
                      cEmisp  ,;      
            Transform(nSaldp ,  "@E 99,999,999.99"	),;
                      cTitf   ,;      
					  cEmisf  ,;       
					  cVenctf ,;                                               
            Transform(nSaldf ,  "@E 99,999,999.99"	),;
                      clotblo ,;     
          		      cFase   ,;     
                      cfase3  ,;     
            Transform(nValorPm ,  "@E 99,999,999.99"	),;
                      cComp   ,;
                      cDesc   ,;
            Transform(nValorDb ,  "@E -999,999.99"	)} )
   EndDo                                                       
         
        nLin := nLin + 1	  	
      @ nLin,060 PSAY "Total DO Rda ---> "                        
      @ nLin,078 PSAY VlrTotPa  picture "@E 99,999,999.99"             
      @ nLin,132 PSAY VlrTotFi  picture "@E 99,999,999.99" 
      @ nLin,165 PSAY VlrTotCm  picture "@E 99,999,999.99" 
      @ nLin,209 PSAY VlrTotDb  picture "@E -999,999.99"
        nLin := nLin + 1     
      @ nLin,000 PSay replicate("_",220)  
       nLin := nLin + 1        
      VlrTotPa     := 0.00 
      VlrTotFi     := 0.00 
      VlrTotCm     := 0.00 
      VlrTotDb     := 0.00    
     ccodrdaC := tmp->e2_codrda  
EndDo                                              
    nLin := nLin + 1	
  @ nLin,060 PSAY "Total Geral ---> "                        
  @ nLin,078 PSAY VlrGPa  picture "@E 999,999,999.99" 
  @ nLin,132 PSAY VlrGFi  picture "@E 999,999,999.99" 
  @ nLin,165 PSAY VlrGCm  picture "@E 999,999,999.99" 
  @ nLin,209 PSAY VlrGDb  picture "@E -999,999.99"
    nLin := nLin + 1     
  @ nLin,000 PSay replicate("_",220)  
    nLin := nLin + 1       
 if nGeraExcel = 1	  
   DlgToExcel({{"ARRAY","Rela็ใo dos Titulos " ,aCabec1,aDados}})
 EndIf  
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Finaliza a execucao do relatorio...                                 ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

SET DEVICE TO SCREEN

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Se impressao em disco, chama o gerenciador de impressao...          ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

If aReturn[5]==1
	dbCommitAll()
	SET PRINTER TO
	OurSpool(wnrel)
Endif

MS_FLUSH()

Return


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณValidPerg บ Autor ณ Jose Carlos Noronhaบ Data ณ 01/08/07    บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Parametros para selecao dos titulos do PLS                 บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ                                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static Function ValidPerg()

Local aAreaAtu := GetArea()
Local aRegs    := {}
Local i,j

DbSelectArea("SX1")
dbSetOrder(1)     
cPerg := PADR(cPerg,6)

aAdd(aRegs,{cPerg,"01","Do  Fornecedor    ?","","","mv_ch1","C",06,0,0,"G","","mv_par01",""   ,"","","","",""   ,"","","","","","","","","","","","","","","","","","","BAUNFE" , "" , "" , "", "", "" })
aAdd(aRegs,{cPerg,"02","Ate Fornecedor    ?","","","mv_ch2","C",06,0,0,"G","","mv_par02",""   ,"","","","",""   ,"","","","","","","","","","","","","","","","","","","BAUNFE" , "" , "" , "", "", "" })
aAdd(aRegs,{cPerg,"03","Do  Rda           ?","","","mv_ch3","C",06,0,0,"G","","mv_par03",""   ,"","","","",""   ,"","","","","","","","","","","","","","","","","","","BAUNFE" , "" , "" , "", "", "" })
aAdd(aRegs,{cPerg,"04","Ate Rda           ?","","","mv_ch4","C",06,0,0,"G","","mv_par04",""   ,"","","","",""   ,"","","","","","","","","","","","","","","","","","","BAUNFE" , "" , "" , "", "", "" })
aAdd(aRegs,{cPerg,"05","Da  Emissao       ?","","","mv_ch5","D",08,0,0,"G","","mv_par05",""   ,"","","","",""   ,"","","","","","","","","","","","","","","","","","","US2"    , "" , "" , "", "", "" })
aAdd(aRegs,{cPerg,"06","Ate Emissao       ?","","","mv_ch6","D",08,0,0,"G","","mv_par06",""   ,"","","","",""   ,"","","","","","","","","","","","","","","","","","","US2"    , "" , "" , "", "", "" })
aAdd(aRegs,{cPerg,"07","Dt procedimento DE ?","","","mv_ch7","D",08,0,0,"G","","mv_par07",""   ,"","","","",""   ,"","","","","","","","","","","","","","","","","","","US2"    , "" , "" , "", "", "" })
aAdd(aRegs,{cPerg,"08","Dt procedimento Ate?","","","mv_ch8","D",08,0,0,"G","","mv_par08",""   ,"","","","",""   ,"","","","","","","","","","","","","","","","","","","US2"    , "" , "" , "", "", "" })
aadd(aRegs,{cPerg,"09","Listar             ?","","","mv_ch9","N",01,0,0,"C","","mv_par09","Convenios","","","","","Prestadores","","","","","Todos","","","","","","","","","","","","","",""       , "" ,""  , "", "", "" })
aadd(aRegs,{cPerg,"10","Cons. Guias        ?","","","mv_ch10","N",01,0,0,"C","","mv_par10","Ativ/Pront","","","","","Conf/Diga็ใo","","","","","Todos","","","","","","","","","","","","","",""       , "" ,""  , "", "", "" })
aadd(aRegs,{cPerg,"11","Gerar Excel        ?","","","mv_ch11","N",01,0,0,"C","","mv_par11","Sim","","","","","Nao","","","","","","","","","","","","","","","","","","",""       , "" ,""  , "", "", "" })

For i:=1 to Len(aRegs)
    If !dbSeek(cPerg+"    "+aRegs[i,2])
		RecLock("SX1",.T.)
		For j:=1 to FCount()
			If j <= Len(aRegs[i])
				FieldPut(j,aRegs[i,j])
			Endif
		Next
		MsUnlock()        
	Endif
Next

RestArea( aAreaAtu )

Return(.T.)

