#INCLUDE "rwmake.ch"
#INCLUDE "PROTHEUS.CH"
#Include "TOPCONN.CH"   

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ CABR098  บ Autor ณ Altamiro Affonso   บ Data ณ  20/08/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Relatorio de diferen็a de reembolso paga e restituido      บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP6 IDE                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
User Function CABR098                                                       

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Declaracao de Variaveis                                             ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

Local cDesc1         := "Este programa tem como objetivo imprimir relatorio "
Local cDesc2         := "de declara็ใo de despesas medico - hospitalares (reembolso)"
Local cDesc3         := "do micrisiga e saude "
Local cPict          := ""
Local titulo         := "DECLARAวรO DE DESPESAS MษDICO - HOSPITALARES (REEMBOLSO) "
Local nLin           := 80 																									     // 04/10/2007 - Noronha
//Local Cabec1         := " Matricula do Usuario   Prestador                                           Evento                                              Dt. Evento    Vl.Solic  N.Protoc    Dt. Pgto    Bco/Ag/Conta       Vl. Pgto  Vl.Nao Reembols  "         

//                       12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//                       0        1         2         3         4         5         6         7         8         9         0         1         2         3         4         5         6         7         8         9         0         1         2         3
//                       XXXX.XXXX.XXXXXX-XX-X   XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX  99/99/9999  999.999,99  99999999  99/99/9999  XXXX/XXXX/XXXXXX   999.999,99       999.999,99      
Local Cabec1         := ""
Local Cabec2         := ""                                                                                                                                                                                                                                 
Local imprime        := .T.                                                                                                                                                                                                                              
Local aOrd           := {}                                                                                                                                                                                                                               
private Cabc1        := trim ("Matricula do Usuario   Prestador                                           Evento                                            Dt. Evento    Vl.Solic  N.Protoc    Dt. Pgto    Bco/Ag/Conta       Vl. Pgto  Vl.Nao Reembols")         
Private lEnd         := .F.
Private lAbortPrint  := .F.
Private CbTxt        := ""
Private limite       := 221
Private tamanho      := "G"
Private nomeprog     := "CABR098"
Private nTipo        := 15
Private aReturn      := { "Zebrado", 1, "Administracao", 1, 2, 1, "", 1}
Private nLastKey     := 0
Private cbtxt        := Space(10)
Private cbcont       := 00
Private CONTFL       := 01
Private m_pag        := 01
Private wnrel        := "CABR098"
Private cString      := "SE2"
Private cPerg        := "CABS98"     

Private nvltotap     := 0.00  
Private nvltotdv     := 0.00 
Private nvltotre     := 0.00 

Private nvlparap     := 0.00  
Private nvlpardv     := 0.00 
Private nvlparre     := 0.00 
 
Private nvlparap1    := 0.00  
Private nvlpardv1    := 0.00 
Private nvlparre1    := 0.00  
private cMatric      := " "

private cCpfante     := "" 
private cCpfdep      := ""  
private lFazrel      := .F.

dbSelectArea("SE2")
dbSetOrder(1)

ValidPerg(cPerg)
If Pergunte(cPerg,.T.) = .F.
	Return
Endif

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
/// novo sql 
//--saude 
/*                                
if !empty (mv_par01)  
   cQuery := "SELECT  SAUDE.FORMATA_MATRICULA_MS@PROD(SAUDE.RETORNA_MATRICULA_MS@PROD(NVL(B.NUM_ASSOCIADO_RESP,B.NUM_ASSOCIADO),'C')) TITULAR, "
   cQuery += " C.NOME_ASSOCIADO NOME, NVL(A.NUM_REEMB_COMPL,0) COMPLEMENTO, SAUDE.FORMATA_MATRICULA_MS@PROD(SAUDE.RETORNA_MATRICULA_MS@PROD(A.NUM_ASSOCIADO,'C')) MATRICULA, "
   cQuery += " NOME_PRESTADOR prestador , Trim (IM.NOME_ITEM) PROCEDIMENTO, to_char(DAT_EVENTO, 'DD/MM/YYYY') DAT_EVENTO, "
   cQuery += " decode  (A.NUM_REEMB_COMPL,NULL,R.VAL_RECIBO,0) VAL_RECIBO,VAL_CALCULADO_REEMB, "         
   cQuery += " Decode  (A.NUM_REEMB_COMPL,NULL,To_Char (A.NUM_REEMBOLSO,'00000000'),'*  '||TO_CHAR(A.NUM_REEMB_COMPL,'00000000')) NUM_REEMBOLSO  , "
   cQuery += " To_Char (DAT_PAGAMENTO, 'DD/MM/YYYY') DAT_PAGAMENTO, A.COD_BANCO||'/'||A.COD_AGENCIA||'/'||A.NOVA_CONTA CONTA, "
   cQuery += " (Decode (A.NUM_REEMB_COMPL,NULL,R.VAL_RECIBO,0) - VAL_CALCULADO_REEMB) DIFERENCA_RECIBO "   
   cQuery += " FROM  SAUDE.PEDIDO_REEMBOLSO@PROD A, SAUDE.CADASTRO_UNICO@PROD C, SAUDE.MATRICULAS@PROD B , SAUDE.RECIBO_PEDIDO@PROD R, "
   cQuery += " SAUDE.MATRICULAS@PROD B2, SAUDE.ITENS_RECIBO_REEMB@PROD IR, SAUDE.ITENS_MEDICOS@PROD IM "
   cQuery += " WHERE  IR.ITEM_MEDICO = IM.ITEM_MEDICO  "
   cQuery += " AND  IR.NUM_REEMBOLSO = R.NUM_REEMBOLSO "
   cQuery += " AND  IR.NUM_RECIBO = R.NUM_RECIBO "
   cQuery += " AND  A.NUM_ASSOCIADO = B.num_associado "
   cQuery += " AND  Nvl (B.NUM_ASSOCIADO_RESP,B.NUM_ASSOCIADO)=B2.NUM_ASSOCIADO "
   cQuery += " AND  B2.CODIGO_UNICO = C.CODIGO_UNICO "
   cQuery += " AND  A.IND_SITUACAO_PEDIDO in (4,8) "
   cQuery += " AND  A.NUM_REEMBOLSO=R.NUM_REEMBOLSO "
   cQuery += " AND  R.COD_TIPO_REEMBOLSO<>5 "
   cQuery += " AND  R.IND_DEVOLUCAO=0 "
   cQuery += " AND  A.DAT_PAGAMENTO BETWEEN  '01-jan-09'  AND  LAST_DAY('01-dec-09') "  
   cQuery += " AND  B2.NUM_ASSOCIADO  = '"+mv_par01+"'" 
   cQuery += " AND ( SELECT Count(NUM_SEQ_ITEM) "
   cQuery += " FROM SAUDE.ITENS_RECIBO_REEMB@PROD IR2 "
   cQuery += " WHERE IR2.NUM_REEMBOLSO = R.NUM_REEMBOLSO "
   cQuery += " AND IR2.NUM_RECIBO = R.NUM_RECIBO ) = 1 "
                                                           
   cQuery += " UNION ALL "

   cQuery += " SELECT SAUDE.FORMATA_MATRICULA_MS@PROD(SAUDE.RETORNA_MATRICULA_MS@PROD(Nvl (B.NUM_ASSOCIADO_RESP,B.NUM_ASSOCIADO),'C')) TITULAR, "
   cQuery += " C.NOME_ASSOCIADO NOME, Nvl (A.NUM_REEMB_COMPL,0) COMPLEMENTO, "                              
   cQuery += " SAUDE.FORMATA_MATRICULA_MS@PROD(SAUDE.RETORNA_MATRICULA_MS@PROD(A.NUM_ASSOCIADO,'C')) MATRICULA, "
   cQuery += " NOME_PRESTADOR prestador , 'PROCEDIMENTOS DIVERSOS' PROCEDIMENTO, to_char(DAT_EVENTO, 'DD/MM/YYYY') DAT_EVENTO, "
   cQuery += " Decode  (A.NUM_REEMB_COMPL,NULL,R.VAL_RECIBO,0) VAL_RECIBO, VAL_CALCULADO_REEMB, "
   cQuery += " decode  (A.NUM_REEMB_COMPL,NULL,TO_CHAR(A.NUM_REEMBOLSO,'00000000'),'*  '||TO_CHAR (A.NUM_REEMB_COMPL,'00000000')) NUM_REEMBOLSO  ,  "
   cQuery += " To_Char (DAT_PAGAMENTO, 'DD/MM/YYYY') DAT_PAGAMENTO, A.COD_BANCO||'/'||A.COD_AGENCIA||'/'||A.NOVA_CONTA CONTA, "
   cQuery += " (Decode  (A.NUM_REEMB_COMPL,NULL,R.VAL_RECIBO,0) - VAL_CALCULADO_REEMB) DIFERENCA_RECIBO  "  
   cQuery += " FROM SAUDE.PEDIDO_REEMBOLSO@PROD A, SAUDE.CADASTRO_UNICO@PROD C, SAUDE.MATRICULAS@PROD B , SAUDE.RECIBO_PEDIDO@PROD R, SAUDE.MATRICULAS@PROD B2 "
   cQuery += " WHERE A.NUM_ASSOCIADO = B.num_associado                         "
   cQuery += " AND Nvl (B.NUM_ASSOCIADO_RESP,B.NUM_ASSOCIADO)=B2.NUM_ASSOCIADO "
   cQuery += " AND  B2.CODIGO_UNICO = C.CODIGO_UNICO "
   cQuery += " AND  A.IND_SITUACAO_PEDIDO in (4,8)  "
   cQuery += " AND  A.NUM_REEMBOLSO=R.NUM_REEMBOLSO "
   cQuery += " AND  R.COD_TIPO_REEMBOLSO <>5 "
   cQuery += " AND  R.IND_DEVOLUCAO=0 "
   cQuery += " AND  A.DAT_PAGAMENTO BETWEEN  '01-jan-09'  AND  LAST_DAY('01-dec-09') "        
   cQuery += " AND  B2.NUM_ASSOCIADO  = '"+mv_par01+"'"   
   cQuery += " AND (SELECT Count(NUM_SEQ_ITEM)         "
   cQuery += " FROM SAUDE.ITENS_RECIBO_REEMB@PROD IR2 WHERE IR2.NUM_REEMBOLSO = R.NUM_REEMBOLSO "
                                       
   cQuery += " AND IR2.NUM_RECIBO = R.NUM_RECIBO ) > 1 "
                              
   cQuery += " UNION ALL  "
EndIf */
//microsiga
cQuery := CRLF+ " SELECT  SIGA.FORMATA_MATRICULA_MS (F.BA1_CODINT||F.BA1_CODEMP||F.BA1_MATRIC||F.BA1_TIPREG||F.BA1_DIGITO) TITULAR, "
cQuery += CRLF+ " Trim (F.BA1_NOMUSR) NOME, To_Number (Nvl (trim (ZZQ_PROORI),'0')) COMPLEMENTO, "
cQuery += CRLF+ " SIGA.FORMATA_MATRICULA_MS (U.BA1_CODINT||U.BA1_CODEMP||U.BA1_MATRIC||U.BA1_TIPREG||U.BA1_DIGITO) MATRICULA, "
cQuery += CRLF+ " Trim(B44_NOMEXE) PRESTADOR, BR8_DESCRI PROCEDIMENTO, To_char(To_Date (B45_DATPRO, 'YYYYMMDD'),'DD/MM/YYYY') DAT_EVENTO, "
cQuery += CRLF+ " decode(Trim (ZZQ_PROORI),NULL,(b45_qtdpro*B45_VLRAPR),0) VAL_RECIBO, B45_VLRPAG VAL_CALCULADO_REEMB, Trim(B44_YCDPTC) NUM_REEMBOLSO, " 
cQuery += CRLF+ " To_char(To_Date (E1_BAIXA,'YYYYMMDD'),'DD/MM/YYYY') DAT_PAGAMENTO, Trim(A1_XBANCO)|| '/' || Trim(A1_XAGENC) || '/' || Trim(A1_XCONTA) || Trim(A1_XDGCON) CONTA, " 

//cQuery += " (decode(trim (ZZQ_PROORI),NULL,B45_VLRAPR,0) - B45_VLRPAG) DIFERENCA_RECIBO ,b44_regexe regexe , trim(B440_CPFEXE) CPFCGCex, REM_TODOS_CARACTERS_ESPEC(trim (B44_NOMEXE)) NOMEex "                                                                        
cQuery += CRLF+ " (decode(trim (ZZQ_PROORI),NULL,(B45_QTDPRO*B45_VLRAPR),0) - B45_VLRPAG) DIFERENCA_RECIBO ,b44_regexe regexe , trim(B44_CPFEXE) CPFCGCex, trim (B44_NOMEXE) NOMEex ,"                                                                         
                                            
//cQuery += " (decode(trim (ZZQ_PROORI),NULL,B45_VLRAPR,0) - B45_VLRPAG) DIFERENCA_RECIBO ,b44_regexe regexe , trim(B44_CPFEXE) CPFCGCex, trim (B44_NOMEXE) NOMEex ,"                                                                        
 
cQuery += CRLF+ " decode(trim (ZZQ_PROORI),NULL,' ','*') VINCULADO "
//cQuery += " FROM  "+RetSQLName("ZZQ")+" P, "+RetSQLName("B44")+" C, "+RetSQLName("B45")+" D, "+RetSQLName("SA1")+" SA1, "+RetSQLName("SE1")+" SE1, "+RetSQLName("BA1")+"  U, "+RetSQLName("BA1")+" F, "+RetSQLName("BG9")+" BG9, "+RetSQLName("BR8")+"  BR8 " 
cQuery += CRLF+ " FROM "+RetSQLName("ZZQ")+" P, "
cquery += CRLF+" " +RetSQLName("B44")+" C, "
cquery += CRLF+" " +RetSQLName("B45")+" D, " 
cquery += CRLF+" " +RetSQLName("SA1")+" SA1, " 
cquery += CRLF+" " +RetSQLName("SE1")+" SE1, " 
cquery += CRLF+" " +RetSQLName("BA1")+" U, "
cquery += CRLF+" " +RetSQLName("BA1")+" F, "                            
cquery += CRLF+" " +RetSQLName("BG9")+" BG9, "
cquery += CRLF+" " +RetSQLName("BR8")+" BR8 "
//cQuery += " FROM           SIGA.ZZQ010 P,           SIGA.B44010 C,            SIGA.B45010 D,           SIGA.SA1010 SA1,            SIGA.SE1010 SE1,            SIGA.BA1010 U,            SIGA.BA1010 F,           SIGA.BG9010 BG9    ,         SIGA.BR8010 BR8 "
cQuery += CRLF+  " WHERE ZZQ_FILIAL   = '"+xFilial("ZZQ")+ "'"

cQuery += CRLF+  "   AND B44_FILIAL   = '"+xFilial("B44")+ "'"
cQuery += CRLF+  "   AND B45_FILIAL   = '"+xFilial("B45")+ "'"
cQuery += CRLF+  "   AND F.BA1_FILIAL = '"+xFilial("BA1")+ "'"
cQuery += CRLF+  "   AND U.BA1_FILIAL = '"+xFilial("BA1")+ "'"
cQuery += CRLF+  "   AND BG9_FILIAL   = '"+xFilial("BG9")+ "'"
cQuery += CRLF+  "   AND BR8_FILIAL   = '"+xFilial("BR8")+ "'"
cQuery += CRLF+  "   AND E1_FILIAL    = '"+xFilial("SE1")+ "'" 
cQuery += CRLF+  "   AND A1_FILIAL    = '"+xFilial("SA1")+ "'"
cQuery += CRLF+  "   AND ZZQ_SEQUEN = B44_YCDPTC "        
cQuery += CRLF+  "   AND ZZQ_STATUS = '3' "               

cQuery += CRLF+  " and d.B45_OPEMOV = c.B44_OPEMOV and D.B45_ANOAUT = C.B44_ANOAUT  and D.B45_MESAUT = C.B44_MESAUT and D.B45_NUMAUT = c.B44_NUMAUT  

//cQuery += "   AND B45_CODLDP = B44_CODLDP "
//cQuery += "   AND B45_CODPEG = B44_CODPEG "      
//cQuery += "   AND B45_NUMAUT = B44_NUMAUT
//cQuery += "   AND B45_NUMERO = B44_NUMGUI "                 
cQuery += CRLF+  "   AND B44_PREFIX <> 'AXF' "       
cQuery += CRLF+  "   AND B44_PREFIX = E1_PREFIXO "       
cQuery += CRLF+  "   AND B44_NUM = E1_NUM "
cQuery += CRLF+  "   AND A1_COD = E1_CLIENTE       "
cQuery += CRLF+  "   AND U.BA1_CODINT=F.BA1_CODINT "
cQuery += CRLF+  "   AND U.BA1_CODEMP=F.BA1_CODEMP "
cQuery += CRLF+  "   AND U.BA1_MATRIC=F.BA1_MATRIC "
//cQuery += "   AND F.BA1_TIPREG='00'       "  
cQuery += CRLF+  "   AND F.BA1_TIPUSU='T'       "
cQuery += CRLF+  "   AND U.BA1_CODINT=B44_OPEUSR "
cQuery += CRLF+  "   AND U.BA1_CODEMP=B44_CODEMP "
cQuery += CRLF+  "   AND U.BA1_MATRIC=B44_MATRIC "
cQuery += CRLF+  "   AND U.BA1_TIPREG=B44_TIPREG "
cQuery += CRLF+  "   AND B44_OPEUSR=BG9_CODINT "
cQuery += CRLF+  "   AND B44_CODEMP=BG9_CODIGO "                                        
cQuery += CRLF+  "   AND E1_BAIXA BETWEEN  '"+dtos(mv_par05)+"'  AND '" + dtos(mv_par06) + "'"   
//cQuery += "   AND F.BA1_CODINT||F.BA1_CODEMP||F.BA1_MATRIC||F.BA1_TIPREG = '"+mv_par02+mv_par03+mv_par04+"00' AND B45_CODPAD = BR8_CODPAD " 
if Trim(mv_par04) == ''  
     cQuery += CRLF+  "   AND F.BA1_CODINT||F.BA1_CODEMP||F.BA1_MATRIC in (select BA1_CODINT||BA1_CODEMP||BA1_MATRIC from ba1010 where ba1_cpfusr = '"+mv_par07+"')"                                                                                      
else                                                                                                               
     cQuery += CRLF+  "   AND F.BA1_CODINT||F.BA1_CODEMP||F.BA1_MATRIC = '"+mv_par02+mv_par03+mv_par04+"'"
EndIf 
cQuery += CRLF+  "   AND B45_CODPAD = BR8_CODPAD "
cQuery += CRLF+  "   AND B45_CODPRO = BR8_CODPSA "
cQuery += CRLF+  "   AND P.D_E_L_E_T_= ' '   "
cQuery += CRLF+  "   AND C.D_E_L_E_T_= ' '   "
cQuery += CRLF+  "   AND D.D_E_L_E_T_= ' '   "
cQuery += CRLF+  "   AND SA1.D_E_L_E_T_ = ' '"
cQuery += CRLF+  "   AND SE1.D_E_L_E_T_ = ' '"
cQuery += CRLF+  "   AND U.D_E_L_E_T_= ' '   "
cQuery += CRLF+  "   AND F.D_E_L_E_T_= ' '   "
cQuery += CRLF+  "   AND BG9.D_E_L_E_T_= ' ' "
cQuery += CRLF+  "   AND BR8.D_E_L_E_T_= ' ' "  

//cQuery += CRLF+  "   AND B44_YCDPTC = '00107288'

//trata materiais especiais que nใo podem sair no ir   
cQuery += CRLF+  "and not exists (SELECT NULL from "
cquery += CRLF+  RetSQLName("B44")+" b441, "
cquery += CRLF+  RetSQLName("B45")+" b451 " 
cquery += CRLF+  " where b441.d_E_L_E_T_ = ' ' and  b451.d_E_L_E_T_ = ' '"    
cQuery += CRLF+  " AND b441.B44_FILIAL   = '"+xFilial("B44")+ "'"
cQuery += CRLF+  " AND b451.B45_FILIAL   = '"+xFilial("B45")+ "'"      
cQuery += CRLF+  " and b451.B45_FILIAL = b441.B44_FILIAL "
cQuery += CRLF+  " and b451.B45_OPEMOV = b441.B44_OPEMOV "
cQuery += CRLF+  " and b451.B45_ANOAUT = b441.B44_ANOAUT "
cQuery += CRLF+  " and b451.B45_MESAUT = b441.B44_MESAUT "
cQuery += CRLF+  " and b451.B45_NUMAUT = b441.B44_NUMAUT "
//cQuery += CRLF+  " and b451.b45_codpro  IN ('83000011','83000020','82000050', '03000206','82000204','50020021','80940030', '83000062') "          
//cQuery += CRLF+  " and b451.b45_codpro  IN ('83000011','83000020','82000050', '03000206','82000204','50020021','80940030', '83000062','03000206','80760023','83000097','20101074','83000089') " 
//'80760023','83000097','20101074','83000089'

//cQuery += CRLF+  " and BR8_CODPAD||BR8_CODPSA
cQuery += CRLF+  " and B451.B45_CODPAD || b451.b45_codpro   IN "  
cQuery += CRLF+  " ('0603000206' , '0220101074' , '1520101074' , '1620101074' , '0150020021' , '0180760023' , '9880760023' , '0180940030' , " 
cQuery += CRLF+  "  '9880940030' , '0182000050' , '9882000050' , '0182000204' , '9882000204' , '0183000011' , '0183000020' , '9883000020' , " 
cQuery += CRLF+  "  '0183000062' , '9883000062' , '0183000089' , '0183000097' , '9883000097') "      

//cQuery += CRLF+  " and b451.b45_codpad = '01' "    
cQuery += CRLF+  " and b441.b44_ycdptc = c.b44_ycdptc ) "      
//cQuery += " order by 4 "

// FIM DO TRATAMENTO 
cQuery += CRLF+  " ORDER BY TITULAR, MATRICULA ,  DAT_PAGAMENTO, NUM_REEMBOLSO, DAT_EVENTO " 

memowrite("C:\Microsiga\cabr098.TXT",cQuery)
/////

If Select("TMP") > 0
	dbSelectArea("TMP")
	dbclosearea()
Endif

TCQuery cQuery Alias "TMP" New
dbSelectArea("TMP")
tmp->(dbGoTop())    
   
nvltotap := 0.00 
nvltotdv := 0.00 
nvltotre := 0.00      

nvlparap1     := 0.00  
nvlpardv1     := 0.00 
nvlparre1     := 0.00       

lFazrel  := .F.
While tmp->(!EOF())   
  //  IF TMP->NUM_REEMBOLSO = "00010025"                                 
  //     nvlpardv += (15480 * 0.01) 
  //     nvlparre -= (15480 * 0.01) 
  //  Else 
/*                                     
    IF !empty (tmp->regexe)
        cCpfante := fbuscpf(tmp->regexe)
	else                                          
        cCpfante := " "
    EndIf          
*/    
    cCpfante := tmp->CPFCGCex  
 
    
//  IF !empty (tmp->regexe) .and. cCpfante != " "


    If cCpfante != " " .and. tmp->NOMEex != " "
        nvltotap += tmp->VAL_RECIBO 
        nvltotdv += tmp->DIFERENCA_RECIBO 
        nvltotre += tmp->VAL_CALCULADO_REEMB 
        lFazrel  := .T.
    Endif               
   dbSelectArea("TMP")
   tmp->(dbSkip())
Enddo 
tmp->(dbGoTop())
While tmp->(!EOF()) .and. lFazrel   
	If nLin > 65 // Salto de Pแgina. Neste caso o formulario tem 55 linhas...
		nLin :=	Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
		nLin ++
		@nLin,050 PSAY "Periodo :    De "    
		@nLin,070 PSAY  mv_par05
		@nLin,080 PSAY "    ม   " 
		@nLin,090 PSAY  mv_par06 	
		nlin ++
   	    @ nLin,000 PSay replicate("_",220)    
   	    nlin ++
//   	                 1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//   	                          1         2         3         4         5         6         7         8         9        10         11        12        13        14        15
   	    @ nLin,000 PSay "Declaramos para o devidos fins , que o(a) Sr(a)"+ TRIM( TMP->NOME ) + " MATRICULA : " + trim (TMP->TITULAR) 
   	    @ nLin,153 PSay ",nos entregou recibos e comprovantes de pagamentos  " 
   	    nlin ++   
        @ nLin,000 PSay "de Honorแrios M้dicos abaixo discriminado no valor de R$ " 
   	    @ nLin,058 PSAY nvltotap Picture "@E 999,999.99"            
   	    @ nLin,068 PSAY " Sendo-lhe restituido o valor de R$ "
   	    @ nLin,104 PSAY nvltotre Picture "@E 999,999.99" 
   	    @ nLin,115 PSAY " cujo calculos foram efetivados com base na tabela mencionada em seu contrato "
   	    nlin ++
   	    @ nLin,000 PSay replicate("_",220)    
        nlin ++                 
        @ nLin,000 PSAY trim (cabc1)   
        @ nLin,000 PSay replicate("_",220)    
        nlin ++                         
        
	Endif
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Verifica o cancelamento pelo usuario...                             ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	
	If lAbortPrint
		@nLin,00 PSAY "*** CANCELADO PELO OPERADOR ***"
		Exit
	Endif
	
    
/*	                                                                                     
    IF !empty (tmp->regexe)
      cCpfante := fbuscpf(tmp->regexe)
	else                                          
       cCpfante := " "
    EndIf   
    */           
    cCpfante := tmp->CPFCGCex       
    If  cMatric  == ' '
           cMatric  := TMP->MATRICULA   
    endif
    
//  IF !empty (tmp->regexe) .and. cCpfante != " "  
    If cCpfante != " " .and. tmp->NOMEex != " "     
                                                   
       If  cMatric  != TMP->MATRICULA
           cMatric  := TMP->MATRICULA    
           @ nLin,000 PSay replicate("_",220)
      	    nLin ++	
	       @ nLin,010 PSAY "Total Parcial ---> "   
           @ nLin,141 PSAY nvlparap1 Picture "@E 999,999.99"   
      	   @ nLin,195 PSAY nvlparre1 Picture "@E 999,999.99" 
       	   @ nLin,209 PSAY nvlpardv1 Picture "@E 999,999.99" 
       	   
             nvlparap1     := 0.00  
             nvlpardv1     := 0.00 
             nvlparre1     := 0.00       

            nLin ++     
   	       @ nLin,000 PSay replicate("_",220)   
   	       nLin ++ 
       Endif  

   	   @ nLin,001 PSAY trim (TMP->MATRICULA)             
    
	   @ nLin,025 PSAY trim (SUBSTR (TMP->prestador,1,30)) 
	                                                                                     
       /*IF !empty (tmp->regexe)
            cCpfante := fbuscpf(tmp->regexe)
	   else                                          
          cCpfante := "Nใo Cadstrado"
       EndIf */   
	@ nLin,056 PSAY trim (substr (cCpfante,1,14))  
	@ nLin,077 PSAY trim (substr(TMP->PROCEDIMENTO,1,50))
   
	@ nLin,129 PSAY trim (TMP->DAT_EVENTO)                  
 //	IF TMP->NUM_REEMBOLSO = "00010025"
 //        @ nLin,147 PSAY "0,00"
 //   ELSE      
         @ nLin,141 PSAY TMP->VAL_RECIBO  Picture "@E 999,999.99"   
 //	EndIf 
	@ nlin,153 PSAY trim (TMP->NUM_REEMBOLSO)  
	
	@ nlin,163 PSAY  trim (TMP->DAT_PAGAMENTO)    
	
	@ nlin,175 PSAY trim (TMP->CONTA)       
  //	IF TMP->NUM_REEMBOLSO = "00010025"                                  
//	 	@ nLin,198 PSAY "154,80" 
// 	 	@ nLin,212 PSAY "-154,80"
  //	Else  	
	    @ nLin,194 PSAY TMP->VAL_CALCULADO_REEMB  Picture "@E 999,999.99"                                                            
    	@ nLin,209 PSAY TMP->DIFERENCA_RECIBO     Picture "@E 999,999.99"   
        @ nLin,220 PSAY TMP->VINCULADO  
//    endif 
//IF TMP->NUM_REEMBOLSO = "00010025"                                  
//    nvlpardv += (15480 * 0.01) 
//    nvlparre -= (15480 * 0.01)  
//else
    nvlparap += tmp->VAL_RECIBO 
    nvlpardv += tmp->DIFERENCA_RECIBO 
    nvlparre += tmp->VAL_CALCULADO_REEMB  
    
    nvlparap1 += tmp->VAL_RECIBO 
    nvlpardv1 += tmp->DIFERENCA_RECIBO 
    nvlparre1 += tmp->VAL_CALCULADO_REEMB 
//Endif    
	nLin ++  // Avanca a linha de impressao     
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Impressao do cabecalho do relatorio. . .                            ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
/*
   if nLin = 65     
	  @ nLin,000 PSay replicate("_",220)
	    nLin ++	
	  @ nLin,010 PSAY "Total Parcial ---> "   
      @ nLin,141 PSAY nvlparap Picture "@E 999,999.99"  
 	  @ nLin,195 PSAY nvlpardv Picture "@E 999,999.99" 
  	  @ nLin,209 PSAY nvlparre Picture "@E 999,999.99" 
       nLin ++     
	  @ nLin,000 PSay replicate("_",220)  
   Endif  
*/   
   EndIf 
    tmp->(dbSkip())   // Avanca o ponteiro do registro no arquivo

EndDo    
   if lFazrel  
   	  @ nLin,000 PSay replicate("_",220)
	    nLin ++
	  @ nLin,010 PSAY "Total Geral ---> " 
      @ nLin,141 PSAY nvlparap1 Picture "@E 999,999.99"  
  	  @ nLin,195 PSAY nvlparre1 Picture "@E 999,999.99"  
  	  @ nLin,209 PSAY nvlpardv1 Picture "@E 999,999.99" 
        nLin ++     
	  @ nLin,000 PSay replicate("_",220)  
   	    nlin ++
	  @ nLin,000 PSay replicate("_",220)
	    nLin ++
	  @ nLin,010 PSAY "Total Geral ---> " 
      @ nLin,141 PSAY nvlparap Picture "@E 999,999.99"  
  	  @ nLin,195 PSAY nvlparre Picture "@E 999,999.99"  
  	  @ nLin,209 PSAY nvlpardv Picture "@E 999,999.99" 
        nLin ++     
	  @ nLin,000 PSay replicate("_",220)  
   	    nlin ++
	  
	  @ nLin,000 PSay "* complemento do reembolso anterior " 
	    nLin ++ 
	    nLin ++    
	  @ nLin,000 PSay replicate("_",220)     
	    nlin ++               
	  @ nLin,100 PSay "*** ATENวรO ***" 
	    nlin ++
 //                    12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
 //                             1         2         3         4         5         6         7         8         9        10         11        12        13        14        15        16        17        18        19        20        21        22
	  @ nLin,000 PSay "Prezado assistido , o relatorio acima demonstra todos os reembolsos pagos no periodo selecionado. Porem , nem todos os procedimentos m้dicos  reembolsados sใo dedutiveis do IR (Imposto de Renda)" 
   	    nlin ++    
      @ nLin,000 PSay "Portanto , sua dedutibilidade , ou nใo , devera ser verificada no site da Receita federal (www.fazenda.receita.gov.br) ou no programa do imposto de renda pessoa fisica "
        nlin ++   
	  @ nLin,000 PSay replicate("_",220)    
        nlin ++ 
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

Static Function  fbuscpf(regexe)

cQuery := " SELECT  BB0_CGC , BB0_CODBLO , BB0_DATBLO FROM "+RetSQLName("BB0")+" BB0 "
// VERIFICADO QUEBRA DE INTEGRIDADE ENTRE A TABELA BBO E A TABELA B44  -- ALTAMIRO 11/01/10
//cQuery += " where  BB0_FILIAL =  '"+xFilial("BB0")+ "' AND d_E_L_E_T_ = ' ' AND  BB0_NUMCR  = '" + regexe +"'"  
cQuery += " where  BB0_FILIAL =  '"+xFilial("BB0")+ "' AND  BB0_NUMCR  = '" + regexe +"' and bb0_cgc <> ' ' and d_E_L_E_T_ = ' '" 
cQuery += " ORDER BY  BB0_DATBLO "

If Select("TMP1") > 0
	dbSelectArea("TMP1")
	dbclosearea("TMP1")
Endif
TCQuery cQuery Alias "TMP1" New


If tmp1->(EOF())  
 //  cCpfdep      := "Cpf/Cgc Nao Encont."  
     cCpfdep      := " " 
else 
//--   tmp1->(dbGoTop())   
//--   While tmp1->(!EOF())                                        
//--         if tmp1->BB0_DATBLO >= TMP->DAT_EVENTO .or. empty (tmp1->BB0_DATBLO)
//            cCpfdep:= tmp1->BB0_CGC 
     cCpfdep:= tmp->CPFCGCex
//--         EndIf
//--         tmp1->(dbSkip())       
//   EndDo                                                                    
   if empty (cCpfdep)
      cCpfdep:=" "
   EndIf   
EndIf       
dbclosearea("TMP1")
Return(cCpfdep)                                                                 


/*
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
*/
Static Function ValidPerg()

Local aAreaAtu := GetArea()
Local aRegs    := {}
Local i,j

DbSelectArea("SX1")
dbSetOrder(1)
cPerg := PADR(cPerg,6)

aAdd(aRegs,{cPerg,"01","Matricula do Saude  ?","","","mv_ch1","C",15,0,0,"G","",""      ,"","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "", "" })
aAdd(aRegs,{cPerg,"02","Cod. Int do Pls     ?","","","mv_ch2","C",04,0,0,"G","",""      ,"","","mv_par02","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "", "" })
aAdd(aRegs,{cPerg,"03","Cod. Emp do Pls     ?","","","mv_ch3","C",04,0,0,"G","",""      ,"","","mv_par03","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "", "" })
aAdd(aRegs,{cPerg,"04","Matricula do Pls    ?","","","mv_ch4","C",06,0,0,"G","","BA1NUS","","","mv_par04","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "", "" })
//aAdd(aRegs,{cPerg,"05","Tip. Reg Do Pls     ?","","","mv_ch5","C",02,0,0,"G","","mv_par05","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "", "" })
//aAdd(aRegs,{cPerg,"06","Digdo do Pls        ?","","","mv_ch6","C",01,0,0,"G","","mv_par06","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "", "" })
aAdd(aRegs,{cPerg,"05","De                  ?","","","mv_ch5","D",08,0,0,"G","",""      ,"","","mv_par05","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "99/99/9999", "" }) 
aAdd(aRegs,{cPerg,"06","Ate                 ?","","","mv_ch6","D",08,0,0,"G","",""      ,"","","mv_par06","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "99/99/9999", "" })
aAdd(aRegs,{cPerg,"07","Cpf(com 11 Digitos)  ","","","mv_ch7","C",11,0,0,"G","",""      ,"","","mv_par07","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "", "" })

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

