#INCLUDE "PROTHEUS.CH"
#Include "TOPCONN.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABR138   º Autor ³Altamiro              º Data ³ 20/02/14  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Relatorio de conferencia das informações de pagamento dos  º±±
±±º          ³ Assistidos informados para IR                              º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/                  

User Function CABR138

Local cMsg			:= ""
Private lAbortPrint :=.F.
Private cPerg       := "CABR138"
Private cTitulo     := "Listagem de Conferencia das Informações de Ir dos Assistidos por familia "        

Private cAliastmp 	:= GetNextAlias()            
Private cAliastmp2 	:= GetNextAlias() 
Private cAlias2016 	:= GetNextAlias()
                                                                         
//SetPrvt("oDlg1","oGrp1","oSay1","oSBtn1","oSBtn2","oSBtn3")

cMsg += " Este programa ira fazer Listagem de Conferencia das Informações de Ir  "  
cMsg += " dos Assistidos por familia "  

***************************************************************************    
 
Private  aDados1     := {}       
Private  acabec1     :={"Competencia","Matric - Nome Usuario","Tipo","Evento","Valor","Ano Ir","Dt. Vencto","Dt. Baixa","Ident. Tit.","Resp. Pagto","Nvl Cobrança","Part.IR S/N"}
private  Descric     := ' '  
private  cRelmatric  := ' ' 
private  cRelmatric1 := ' '                                                                                                   
private  cSairIr 	 := 'Sim'
AjustaSX1(cPerg)

Pergunte(cPerg,.T.) 

cAno    	:= mv_par01  
cEmpres     := mv_par02   
cMatric     := mv_par03
cGeraEx     := mv_par04 

nParc       := 1 // mv_par05 


cEmpresa    := Iif(cEmpAnt == '01','C','I') 
  
Processa({||Processa1()}, cTitulo, "", .T.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Libera impressao                                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
   
// faz ecxel
if cGeraEx == 1 
    DlgToExcel({{"ARRAY","Listagem de Conferencia das Informações de Ir dos Assistidos por familia ",aCabec1,aDados1}})   
EndIF
fGeraRel2()    
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
///////////////////////////////////
///////////////////////////////////    
cquery := "      SELECT ANOBASE , MESBASE , MATANT , CODINT , CODEMP , MATRIC , TIPREG , DIGITO , "
cquery += CRLF+"        decode(SIGA.SIGA_RET_SIT_TIT_DMED('C',TIT),'BNF','NAO','NEG','NAO',( "
cquery += CRLF+"        decode(trim(substr(event,1,4)),'0031','Não','0038','Não',( "
cquery += CRLF+"        decode(trim(substr(TIPO,1,4)),'102','Não','103','Não','107','Não','108','Não','908','Não','927','Não','937','Não','940','Não','948','Não','950','Não','956','Não','Sim'))))) part_Ir , "
cquery += CRLF+"        tipo , EVENT ,  SUM(VALOR) VALOR , '"+cAno+"' ANOBASEIR , E1_VENCREA, E1_BAIXA, E1_SALDO , E1_NOMCLI ,tit , NOMUSR , NIVCOB "

cquery += CRLF+" FROM ( "
// --->> BAIXA NORNAL , COMPENSAÇÃO , BAIXA DE SALDO "
cquery += CRLF+"       SELECT BM1_ANO ANOBASE,     "
cquery += CRLF+"              BM1_MES MESBASE,     "
cquery += CRLF+"              0 AS MATANT,         "
cquery += CRLF+"              BM1_CODINT CODINT,   "
cquery += CRLF+"              BM1_CODEMP CODEMP,   "
cquery += CRLF+"              BM1_MATRIC MATRIC,   "
cquery += CRLF+"              BM1_TIPREG TIPREG,   "
cquery += CRLF+"              BM1_DIGITO DIGITO ,  "
cquery += CRLF+"              BM1_CODTIP||' - ' || BM1_DESTIP TIPO , "
cquery += CRLF+"              BM1_CODEVE ||'-'||BM1_DESEVE EVENT , "
cquery += CRLF+"            ((DECODE(BM1_TIPO,1,1,-1)*BM1_VALOR)) VALOR , "
cquery += CRLF+"             '"+cAno+"', "
cquery += CRLF+"              E1_VENCREA," 
cquery += CRLF+"              E1_BAIXA,  "
cquery += CRLF+"              E1_SALDO , "
cquery += CRLF+"              E1_NOMCLI ," 
cquery += CRLF+"              e1_PREFIXO||E1_num||e1_parcela||e1_tipo tit , "
cquery += CRLF+"              BM1_NOMUSR NOMUSR , "
cquery += CRLF+"              DECODE (BA3_COBNIV,1,'Familia', 'Empresa') NIVCOB "
cquery += CRLF+"         FROM SIGA.SE1010, SIGA.BM1010 , siga.ba3010 BA3 , "
cquery += CRLF+"              (  select ba11.Ba1_CODEMP cod_emp , "
cquery += CRLF+"                        ba11.Ba1_MATRIC mat_fam "
cquery += CRLF+"                   from ba1010 ba11 , "
cquery += CRLF+"                        ba1010 ba12   "
cquery += CRLF+"                  where ba12.ba1_filial = ' ' " 
cquery += CRLF+"                    and ba12.d_E_L_E_T_ = ' ' "
cquery += CRLF+"                    and ba11.ba1_filial = ' ' "
cquery += CRLF+"                    and ba11.d_E_L_E_T_ = ' ' "  

cquery += CRLF+"                    and ba12.Ba1_CODINT = '0001' "
cquery += CRLF+"                    and ba12.Ba1_CODEMP = '"+CEMPRES+"' "
cquery += CRLF+"                    and ba12.Ba1_MATRIC = '"+CMATRIC+"' " 
cquery += CRLF+"                    and ba12.ba1_tipusu = 'T' "

cquery += CRLF+"                    and ba11.ba1_matvid = ba12.ba1_matvid) mattot "
cquery += CRLF+"        WHERE E1_FILIAL  = '01' "
cquery += CRLF+"          AND E1_STATUS  = 'B'  "
cquery += CRLF+"          AND E1_PREFIXO <> 'AXF' " 
cquery += CRLF+"          AND BM1_CODINT = '0001' "
cquery += CRLF+"          AND SUBSTR(E1_BAIXA,1,4) = '"+cAno+"' " 
cquery += CRLF+"          AND BM1_CODEMP = mattot.cod_emp "
cquery += CRLF+"          and BM1_MATRIC = mattot.mat_fam "
cquery += CRLF+"          AND BA3_FILIAL = ' ' "
cquery += CRLF+"          AND BA3.D_e_l_e_t_ =' ' "
cquery += CRLF+"          AND BA3_CODINT = BM1_CODINT "
cquery += CRLF+"          AND BA3_CODEMP = BM1_CODEMP " 
cquery += CRLF+"          AND BA3_MATRIC =  BM1_MATRIC " 
cquery += CRLF+"          AND (SELECT SUM(DECODE( E5_MOTBX, " 
cquery += CRLF+"                                 'CAN', E5_VALOR *-1,'FAT', E5_VALOR *-1, 'BNF', E5_VALOR *-1, "
cquery += CRLF+"                                 'DAC', E5_VALOR *-1,'NEG', E5_VALOR *-1, 'BNC', E5_VALOR *-1, "
cquery += CRLF+"                                 'NOR', E5_VALOR ,'CMP', E5_VALOR , "
cquery += CRLF+"                                 'SLD', E5_VALOR , 0 )) BM1VLR_EVENTO " 
cquery += CRLF+"                 FROM siga.SE5010 "
cquery += CRLF+"                WHERE E5_FILIAL  = E1_FILIAL  "
cquery += CRLF+"                  AND E5_PREFIXO = E1_PREFIXO " 
cquery += CRLF+"                  AND E5_NUMERO  = E1_NUM     "
cquery += CRLF+"                  AND E5_PARCELA = E1_PARCELA "
cquery += CRLF+"                  AND E5_TIPO = E1_TIPO       "
cquery += CRLF+"                  AND E5_MOTBX IN ('CAN', 'FAT' , 'BNF' , 'DAC' , 'NEG', 'BNC', 'NOR','CMP','SLD')"
cquery += CRLF+"                  AND SE5010.D_E_L_E_T_ = ' ' ) > 0 "
cquery += CRLF+"          AND SE1010.D_E_L_E_T_ = ' ' "
cquery += CRLF+"          AND BM1_FILIAL = '  ' "
cquery += CRLF+"          AND BM1_PREFIX = E1_PREFIXO "
cquery += CRLF+"          AND BM1_NUMTIT = E1_NUM "
cquery += CRLF+"          AND BM1_PARCEL = E1_PARCELA "
cquery += CRLF+"          AND BM1_TIPTIT = E1_TIPO "
cquery += CRLF+"          AND BM1_CODEMP NOT IN  ('0004','0009') "
cquery += CRLF+"          AND BM1_CODTIP <> '108' "
cquery += CRLF+"          AND BM1010.D_E_L_E_T_ = ' ' "
cquery += CRLF+"          
cquery += CRLF+"       UNION ALL "
       
//--->> BAIXA FATURA 
       
cquery += CRLF+"        SELECT BM1_ANO ANOBASE , "
cquery += CRLF+"               BM1_MES MESBASE , "
cquery += CRLF+"               0 AS MATANT,      "
cquery += CRLF+"               BM1_CODINT CODINT,"
cquery += CRLF+"               BM1_CODEMP CODEMP," 
cquery += CRLF+"               BM1_MATRIC MATRIC," 
cquery += CRLF+"               BM1_TIPREG TIPREG , "
cquery += CRLF+"               BM1_DIGITO DIGITO , "
cquery += CRLF+"               BM1_CODTIP||' - ' || BM1_DESTIP TIPO , "
cquery += CRLF+"               BM1_CODEVE ||'-'||BM1_DESEVE EVENT , "
cquery += CRLF+"               ((DECODE(BM1_TIPO,1,1,-1)*BM1_VALOR)) VALOR , "
cquery += CRLF+"               '"+cAno+"' ANOBASEIR , "
cquery += CRLF+"               E1_VENCREA , "
cquery += CRLF+"               E1_BAIXA , "
cquery += CRLF+"               E1_SALDO , "
cquery += CRLF+"               E1_NOMCLI , "
cquery += CRLF+"               e1_PREFIXO||E1_num||e1_parcela||e1_tipo tit , "
cquery += CRLF+"               BM1_NOMUSR NOMUSR ,                           "
cquery += CRLF+"               DECODE (BA3_COBNIV,1,'Familia', 'Empresa') NIVCOB "
cquery += CRLF+"          FROM SIGA.SE1010, SIGA.BM1010 , siga.ba3010 BA3 ,      "
cquery += CRLF+"               ( select ba11.Ba1_CODEMP cod_emp ,                "
cquery += CRLF+"                        ba11.Ba1_MATRIC mat_fam                  "
cquery += CRLF+"                   from ba1010 ba11 , "
cquery += CRLF+"                        ba1010 ba12   "
cquery += CRLF+"                  where ba12.ba1_filial = ' ' " 
cquery += CRLF+"                    and ba12.d_E_L_E_T_ = ' ' "
cquery += CRLF+"                    and ba11.ba1_filial = ' ' "
cquery += CRLF+"                    and ba11.d_E_L_E_T_ = ' ' " 

cquery += CRLF+"                    and ba12.Ba1_CODINT = '0001' "
cquery += CRLF+"                    and ba12.Ba1_CODEMP = '"+CEMPRES+"' "
cquery += CRLF+"                    and ba12.Ba1_MATRIC = '"+CMATRIC+"' "
//cquery += CRLF+"                    and ba12.ba1_tipusu = 'T'      "

cquery += CRLF+"                    and ba11.ba1_matvid = ba12.ba1_matvid) mattot "
cquery += CRLF+"         WHERE E1_FILIAL = '01'    "
cquery += CRLF+"           AND E1_STATUS = 'B'     "
cquery += CRLF+"           AND E1_PREFIXO <> 'AXF' "
cquery += CRLF+"           AND BM1_CODINT = '0001' "
cquery += CRLF+"           AND SUBSTR(E1_BAIXA,1,4) = '"+cAno+"' "
cquery += CRLF+"           AND BM1_CODEMP = mattot.cod_emp   "
cquery += CRLF+"           and BM1_MATRIC = mattot.mat_fam   "
cquery += CRLF+"           AND BA3_FILIAL = ' ' "
cquery += CRLF+"           AND BA3.D_e_l_e_t_ = ' ' "
cquery += CRLF+"           AND BA3_CODINT = BM1_CODINT "
cquery += CRLF+"           AND BA3_CODEMP = BM1_CODEMP " 
cquery += CRLF+"           AND BA3_MATRIC = BM1_MATRIC " 
cquery += CRLF+"           AND (SELECT Count(*) AS TOTREG "
cquery += CRLF+"                  FROM siga.SE5010 "
cquery += CRLF+"                 WHERE E5_FILIAL  = E1_FILIAL " 
cquery += CRLF+"                   AND E5_PREFIXO = E1_PREFIXO "
cquery += CRLF+"                   AND E5_NUMERO  = E1_NUM   "
cquery += CRLF+"                   AND E5_PARCELA = E1_PARCELA "  
cquery += CRLF+"                   AND E5_TIPO    = E1_TIPO  "
cquery += CRLF+"                   AND E5_MOTBX   = 'CAN'  "
cquery += CRLF+"                   AND SE5010.D_E_L_E_T_ = ' ' ) = 0 "
cquery += CRLF+"           AND (SELECT COUNT(*) AS TOTREG "
cquery += CRLF+"                  FROM SIGA.SE5010 "  
cquery += CRLF+"                 WHERE E5_FILIAL  = E1_FILIAL  "
cquery += CRLF+"                   AND E5_PREFIXO = E1_PREFIXO "
cquery += CRLF+"                   AND E5_NUMERO  = E1_NUM     "
cquery += CRLF+"                   AND E5_PARCELA = E1_PARCELA " 
cquery += CRLF+"                   AND E5_TIPO    = E1_TIPO    "
cquery += CRLF+"                   AND E5_MOTBX   = 'FAT'      "
cquery += CRLF+"                   AND SE5010.D_E_L_E_T_ = ' ' ) > 0 "
                 
cquery += CRLF+"           AND SE1010.D_E_L_E_T_ = ' ' "
          
cquery += CRLF+"           AND EXISTS (SELECT NULL    "
cquery += CRLF+"             FROM   siga.SE1010 E1FAT "
cquery += CRLF+"             WHERE  /*E1FAT.E1_PREFIXO = 'FAT'*/  E1FAT.E1_tipo  = 'FT' "
cquery += CRLF+"             AND    E1FAT.E1_FILIAL = '01' "
cquery += CRLF+"             AND    E1FAT.E1_PREFIXO = SE1010.E1_FATPREF "
cquery += CRLF+"             AND    E1FAT.E1_NUM = SE1010.E1_FATURA "
cquery += CRLF+"             AND    E1FAT.E1_SALDO = 0 "
cquery += CRLF+"             AND    E1FAT.D_E_L_E_T_ = ' ' "
cquery += CRLF+"             AND (( SELECT Count(*) AS TOTREG "
cquery += CRLF+"                     FROM siga.SE5010 E5FAT "
cquery += CRLF+"                    WHERE E5FAT.E5_FILIAL  = E1FAT.E1_FILIAL "
cquery += CRLF+"                      AND E5FAT.E5_PREFIXO = SE1010.E1_FATPREF "
cquery += CRLF+"                      AND E5FAT.E5_NUMERO  = SE1010.E1_FATURA  " 
cquery += CRLF+"                      AND E5FAT.E5_MOTBX  IN ('NOR','CMP','SLD') "
cquery += CRLF+"                      AND E5FAT.D_E_L_E_T_ = ' ' ) > 0 "
cquery += CRLF+"            OR  ( SELECT Count(*) AS TOTREG
cquery += CRLF+"                       FROM siga.SE5010 E5FAT
cquery += CRLF+"                      WHERE E5FAT.E5_FILIAL  = E1FAT.E1_FILIAL
cquery += CRLF+"                        AND E5FAT.E5_PREFIXO = SE1010.E1_FATPREF
cquery += CRLF+"                        AND E5FAT.E5_NUMERO  = SE1010.E1_FATURA
cquery += CRLF+"                        AND E5FAT.E5_MOTBX NOT IN ('NOR','CMP','SLD')
cquery += CRLF+"                        AND E5FAT.D_E_L_E_T_ = ' ' ) = 0)
cquery += CRLF+"            AND (SELECT Count(*) AS TOTREG  "
cquery += CRLF+"                   FROM siga.SE5010 E5FAT "
cquery += CRLF+"                  WHERE E5FAT.E5_FILIAL  = '01' "
cquery += CRLF+"                   AND E5FAT.E5_PREFIXO  = SE1010.E1_PREFIXO " 
cquery += CRLF+"                   AND E5FAT.E5_NUMERO   = SE1010.E1_NUM "
cquery += CRLF+"                   AND E5FAT.E5_PARCELA  = SE1010.E1_PARCELA "
cquery += CRLF+"                   AND E5FAT.E5_TIPO     = SE1010.E1_TIPO "
cquery += CRLF+"                   AND E5FAT.E5_MOTBX IN ('NOR','CMP','SLD') "
cquery += CRLF+"                   AND E5FAT.D_E_L_E_T_  = ' ') = 0 )"
cquery += CRLF+"           AND BM1_FILIAL = '  ' "
cquery += CRLF+"           AND BM1_PREFIX = E1_PREFIXO " 
cquery += CRLF+"           AND BM1_NUMTIT = E1_NUM "
cquery += CRLF+"           AND BM1_PARCEL = E1_PARCELA " 
cquery += CRLF+"           AND BM1_TIPTIT = E1_TIPO "
cquery += CRLF+"           AND BM1_CODEMP NOT IN  ('0004','0009') " 
cquery += CRLF+"           AND BM1_CODTIP <> '108' "
cquery += CRLF+"           AND BM1010.D_E_L_E_T_ = ' ' "

cquery += CRLF+"        UNION ALL "

//cquery += CRLF+" --->> BAIXA LIQUIDAÇÃO   "

cquery += CRLF+"  SELECT BM1_ANO ANOBASE,    "
cquery += CRLF+"         BM1_MES MESBASE,    "
cquery += CRLF+"         0 AS MATANT,        "
cquery += CRLF+"         BM1_CODINT CODINT,  "
cquery += CRLF+"         BM1_CODEMP CODEMP,  "
cquery += CRLF+"         BM1_MATRIC MATRIC,  "
cquery += CRLF+"         BM1_TIPREG TIPREG , "
cquery += CRLF+"         BM1_DIGITO DIGITO , "
cquery += CRLF+"         BM1_CODTIP||' - ' || BM1_DESTIP TIPO , "
cquery += CRLF+"         BM1_CODEVE ||'-'||BM1_DESEVE EVENT , "
cquery += CRLF+"         ((DECODE(BM1_TIPO,1,1,-1)*BM1_VALOR)) VALOR , " 
cquery += CRLF+"         '"+cAno+"' ANOBASEIR , "
cquery += CRLF+"         E1_VENCREA , "
cquery += CRLF+"         E1_BAIXA ,   "
cquery += CRLF+"         E1_SALDO ,   "
cquery += CRLF+"         E1_NOMCLI ,  "
cquery += CRLF+"         e1_PREFIXO||E1_num||e1_parcela||e1_tipo tit , "
cquery += CRLF+"         BM1_NOMUSR NOMUSR , "
cquery += CRLF+"         DECODE (BA3_COBNIV,1,'Familia', 'Empresa') NIVCOB "
cquery += CRLF+"    FROM SIGA.SE1010 se1 , SIGA.BM1010 bm1 , siga.ba3010 BA3 , BA1010 ba1  , SA1010 sa1 , "
cquery += CRLF+" (SELECT DISTINCT (SE1PAI.E1_NUM) NUMPAI ,"   
cquery += CRLF+"         SE1PAI.E1_PREFIXO PREFPAI, "
cquery += CRLF+"         SE1PAI.E1_PARCELA PARCPAI , "
cquery += CRLF+"         SE1PAI.E1_TIPO    TIPOPAI , "  
cquery += CRLF+"         SE1FAT.E1_PREFIXO PREFFAT , "
cquery += CRLF+"         SE1FAT.E1_NUM     NUMFAT  , "
cquery += CRLF+"         SE51.E5_MOTBX      MOTBX    "
cquery += CRLF+"    FROM SE1010 SE1FAT "
cquery += CRLF+"     INNER JOIN FO2010 FO2 "
cquery += CRLF+"     ON "
cquery += CRLF+"         FO2.FO2_FILIAL     = SE1FAT.E1_FILIAL  "
cquery += CRLF+"         AND FO2.FO2_PREFIX = SE1FAT.E1_PREFIXO "
cquery += CRLF+"         AND FO2.FO2_NUM    = SE1FAT.E1_NUM     "
cquery += CRLF+"         AND FO2.D_E_L_E_T_ = ' '  "
cquery += CRLF+"     INNER JOIN FO0010 FO0  "
cquery += CRLF+"     ON "
cquery += CRLF+"         FO0.FO0_FILIAL          = FO2_FILIAL "
cquery += CRLF+"         AND FO0.FO0_PROCES      = FO2_PROCES "
cquery += CRLF+"         AND FO0.D_E_L_E_T_      = ' '        "
cquery += CRLF+"     INNER JOIN SE5010 SE51                   "
cquery += CRLF+"     ON "
cquery += CRLF+"         SE51.E5_FILIAL           = FO0.FO0_FILIAL "
cquery += CRLF+"         AND SE51.E5_DOCUMEN      = FO0.FO0_NUMLIQ "
cquery += CRLF+"         AND SE51.E5_MOTBX        = 'LIQ'          "
cquery += CRLF+"         AND SE51.D_E_L_E_T_      = ' '  "
cquery += CRLF+"     INNER JOIN SE1010 SE1PAI "
cquery += CRLF+"     ON "
cquery += CRLF+"         SE1PAI.E1_FILIAL        = SE51.E5_FILIAL  "
cquery += CRLF+"         AND SE1PAI.E1_PREFIXO   = SE51.E5_PREFIXO "
cquery += CRLF+"         AND SE1PAI.E1_NUM       = SE51.E5_NUMERO  "
cquery += CRLF+"         AND SE1PAI.D_E_L_E_T_   = ' ' "

cquery += CRLF+"    WHERE SE1FAT.E1_FILIAL        = '01' "
cquery += CRLF+"      AND SE1FAT.D_E_L_E_T_   = ' ' "
cquery += CRLF+"      AND SE1PAI.E1_BAIXA >= '"+cAno+"0101' AND SE1PAI.E1_BAIXA <= '"+cAno+"1231' ) FATLIQ "
cquery += CRLF+" WHERE E1_FILIAL = '01' "
cquery += CRLF+" AND E1_STATUS = 'B' "
cquery += CRLF+" AND E1_PREFIXO <>  'AXF' "
cquery += CRLF+" AND SubStr(E1_BAIXA,1,4) = ('"+cAno+"') "

cquery += CRLF+" and ba1_codint = '0001' "
cquery += CRLF+" and ba1_codemp = '"+CEMPRES+"'"
cquery += CRLF+" and ba1_matric = '"+CMATRIC+"' "
//cquery += CRLF+" and ba1_tipusu = 'T' "

cquery += CRLF+" AND ( SELECT SUM(DECODE( E5_MOTBX, 'CAN', E5_VALOR *-1,"
cquery += CRLF+"                                    'FAT', E5_VALOR *-1," 
cquery += CRLF+"                                    'LIQ', E5_VALOR *-1," 
cquery += CRLF+"                                    'BNF', E5_VALOR *-1,"
cquery += CRLF+"                                    'DAC', E5_VALOR *-1,"
cquery += CRLF+"                                    'NEG', E5_VALOR *-1,"
cquery += CRLF+"                                    'BNC', E5_VALOR *-1,"  
cquery += CRLF+"                                    'NOR', E5_VALOR ,   "
cquery += CRLF+"                                    'CMP', E5_VALOR ,   "
cquery += CRLF+"                                    'REE', E5_VALOR ,   "
cquery += CRLF+"                                    'SLD', E5_VALOR , 0 )) BM1VLR_EVENTO "

cquery += CRLF+"         FROM siga.SE5010 "
cquery += CRLF+"        WHERE E5_FILIAL  = E1_FILIAL "
cquery += CRLF+"          AND E5_PREFIXO = E1_PREFIXO "
cquery += CRLF+"          AND E5_NUMERO  = E1_NUM "
cquery += CRLF+"          AND E5_PARCELA = E1_PARCELA "
cquery += CRLF+"          AND E5_TIPO = E1_TIPO "
cquery += CRLF+"          AND E5_MOTBX in ('CAN', 'FAT' , 'BNF' , 'DAC' , 'NEG', 'BNC', 'NOR','CMP','LIQ','SLD','REE')"
cquery += CRLF+"          AND SE5010.D_E_L_E_T_ = ' ') <= 0 "

cquery += CRLF+" AND ( SELECT Count(*) AS TOTREG "
cquery += CRLF+"         FROM siga.SE5010 "
cquery += CRLF+"        WHERE E5_FILIAL  = E1_FILIAL  "
cquery += CRLF+"          AND E5_PREFIXO = E1_PREFIXO "
cquery += CRLF+"          AND E5_NUMERO  = E1_NUM     "
cquery += CRLF+"          AND E5_PARCELA = E1_PARCELA "
cquery += CRLF+"          AND E5_TIPO    = E1_TIPO    "
cquery += CRLF+"          AND E5_MOTBX IN ('LIQ') -- FATURA "
cquery += CRLF+"          AND SE5010.D_E_L_E_T_ = ' ') > 0 "

cquery += CRLF+" AND SE1.D_E_L_E_T_ = ' ' "
cquery += CRLF+" AND EXISTS (SELECT NULL "
cquery += CRLF+"               FROM siga.SE1010 E1FAT "
cquery += CRLF+"              WHERE E1FAT.E1_tipo  = 'FT' "
cquery += CRLF+"                AND    E1FAT.E1_FILIAL = '01' "
cquery += CRLF+"                AND    E1FAT.E1_PREFIXO = FATLIQ.PREFFAT " 
cquery += CRLF+"                AND    E1FAT.E1_NUM = FATLIQ.NUMFAT "
cquery += CRLF+"                AND    E1FAT.E1_SALDO = 0 "
cquery += CRLF+"                AND    E1FAT.D_E_L_E_T_ = ' ' "
cquery += CRLF+"                AND (( SELECT Count(*) AS TOTREG "
cquery += CRLF+"                         FROM siga.SE5010 E5FAT  "
cquery += CRLF+"                        WHERE E5FAT.E5_FILIAL = '01' "
cquery += CRLF+"                          AND E5FAT.E5_PREFIXO = FATLIQ.PREFFAT " 
cquery += CRLF+"                          AND E5FAT.E5_NUMERO = FATLIQ.NUMFAT "
cquery += CRLF+"                          AND E5FAT.E5_MOTBX  IN ('NOR','CMP','SLD') "
cquery += CRLF+"                          AND E5FAT.D_E_L_E_T_ = ' ' ) > 0 "
//cquery += CRLF+"                     OR "  ALTERADO EM 12/03/2021 ALTAMIRO
cquery += CRLF+"                     AND  "    
cquery += CRLF+"                     ( SELECT Count(*) AS TOTREG "
cquery += CRLF+"                         FROM siga.SE5010 E5FAT  "
cquery += CRLF+"                        WHERE E5FAT.E5_FILIAL = '01' "
cquery += CRLF+"                          AND E5FAT.E5_PREFIXO = FATLIQ.PREFFAT " 
cquery += CRLF+"                          AND E5FAT.E5_NUMERO = FATLIQ.NUMFAT "
cquery += CRLF+"                          AND E5FAT.E5_MOTBX  NOT IN ('NOR','CMP','SLD') "
cquery += CRLF+"                          AND E5FAT.D_E_L_E_T_ = ' ') = 0 ) "
cquery += CRLF+"                          AND ( SELECT Count(*) AS TOTREG "
cquery += CRLF+"                                  FROM siga.SE5010 E5FAT "
cquery += CRLF+"                                 WHERE E5FAT.E5_FILIAL  = E1FAT.E1_FILIAL "
cquery += CRLF+"                                   AND E5FAT.E5_PREFIXO = FATLIQ.PREFPAI  "
cquery += CRLF+"                                   AND E5FAT.E5_NUMERO  = FATLIQ.NUMPAI   "
cquery += CRLF+"                                   AND E5FAT.E5_PARCELA = FATLIQ.PARCPAI  "
cquery += CRLF+"                                   AND E5FAT.E5_TIPO    = FATLIQ.TIPOPAI  "
cquery += CRLF+"                                   AND E5FAT.E5_MOTBX IN ('NOR','CMP','SLD') "
cquery += CRLF+"                                   AND E5FAT.D_E_L_E_T_ = ' ') = 0) "
cquery += CRLF+" 
cquery += CRLF+" AND BM1_FILIAL = '  ' "
cquery += CRLF+" AND BM1_PREFIX = E1_PREFIXO "
cquery += CRLF+" AND BM1_NUMTIT = E1_NUM "
cquery += CRLF+" AND BM1_PARCEL = E1_PARCELA "
cquery += CRLF+" AND BM1_TIPTIT = E1_TIPO "
cquery += CRLF+" AND BM1_FILIAL = '  ' "
cquery += CRLF+" AND FATLIQ.PREFPAI = E1_PREFIXO "   
cquery += CRLF+" AND FATLIQ.NUMPAI  = E1_NUM "
cquery += CRLF+" AND FATLIQ.PARCPAI = E1_PARCELA "
cquery += CRLF+" AND FATLIQ.TIPOPAI = E1_TIPO "
cquery += CRLF+" AND NOT (BM1_CODEMP = '0006' AND BM1_CONEMP <> '000000000003') "
cquery += CRLF+" AND NOT (BM1_CODEMP = '0001' AND BM1_CONEMP = '000000000004')  "
cquery += CRLF+" AND NOT (BM1_CODEMP = '0001' AND BM1_CONEMP = '000000000006')  "
cquery += CRLF+" AND NOT (BM1_CODEMP = '0002' AND BM1_CONEMP = '000000000008')  "
cquery += CRLF+" AND NOT (BM1_CODEMP = '0010' AND BM1_CONEMP <> '000000000003') "
//cquery += CRLF+" and bm1_codtip not in('108','103','107','908','932','937','948','950')"
cquery += CRLF+" and bm1_codtip not in('108','103','107','908','932','937','948','950','903')"
cquery += CRLF+" AND ba3.D_E_L_E_T_ = ' '"
cquery += CRLF+" AND ba3_codint = bm1_codint "
cquery += CRLF+" AND ba3_codemp = bm1_codemp "
cquery += CRLF+" AND ba3_matric = bm1_matric "
 // cquery += CRLF+" AND BM1_CODEMP NOT IN  ('0004','0009') "
cquery += CRLF+" AND (ba3_cobniv = '1' or  BM1_CODEMP = '0013') "
cquery += CRLF+" AND BM1_CODTIP <> '108' "

//cquery += CRLF+" and ba1_codemp = '0001' and  ba1_matric  = '002463'"

cquery += CRLF+" AND ba1.D_E_L_E_T_ = ' '"
cquery += CRLF+" AND ba1_codint = bm1_codint "
cquery += CRLF+" AND ba1_codemp = bm1_codemp "
cquery += CRLF+" AND ba1_matric = bm1_matric "
cquery += CRLF+" AND ba1_tipreg = bm1_tipreg "

cquery += CRLF+" AND BM1.D_E_L_E_T_ = ' ' "
cquery += CRLF+" AND A1_COD = E1_CLIENTE "
cquery += CRLF+" AND SA1.D_e_l_e_t_ = ' ' )  "

cquery += CRLF+"  where  decode(trim(substr(event,1,4)),'0031','Não','0038','Não',( "
cquery += CRLF+"         decode(trim(substr(TIPO,1,4)),'102','Não','103','Não','107','Não','108','Não','908','Não','927','Não','937','Não','940','Não','948','Não','950','Não','956','Não','Sim'))) =  'Sim' "
cquery += CRLF+"  GROUP BY ANOBASE , MESBASE , MATANT , CODINT , CODEMP , MATRIC , TIPREG , DIGITO , '"+cAno+"' , tipo , EVENT  ,E1_VENCREA, E1_BAIXA, E1_SALDO , E1_NOMCLI , tit , NOMUSR , NIVCOB order by 5,6,7,1,2 "

/*


If cEmpresa == 'C'
   cquery :=      " SELECT ANOBASE , MESBASE , MATANT , CODINT , CODEMP , MATRIC , TIPREG , DIGITO , "
   

 cquery += CRLF+" decode(SIGA.SIGA_RET_SIT_TIT_DMED('C',TIT),'BNF','NAO','NEG','NAO',( "

 cquery += CRLF+" decode(trim(substr(event,1,4)),'0031','Não','0038','Não',( "
 cquery += CRLF+"       decode(trim(substr(TIPO,1,4)),'102','Não','103','Não','107','Não','108','Não','908','Não','927','Não','937','Não','940','Não','948','Não','950','Não','956','Não','Sim'))))) part_Ir ,"

   cquery += CRLF+" tipo , EVENT ,  SUM(VALOR) VALOR , '"+cAno+"' ANOBASEIR , E1_VENCREA, E1_BAIXA, E1_SALDO , E1_NOMCLI ,tit , NOMUSR , NIVCOB"  
   cquery += CRLF+" FROM ( SELECT BM1_ANO ANOBASE, BM1_MES MESBASE, 0 AS MATANT, BM1_CODINT CODINT, BM1_CODEMP CODEMP, BM1_MATRIC MATRIC, BM1_TIPREG TIPREG, BM1_DIGITO DIGITO , "  
   cquery += CRLF+" BM1_CODTIP||' - ' || BM1_DESTIP TIPO , BM1_CODEVE ||'-'||BM1_DESEVE EVENT ,((DECODE(BM1_TIPO,1,1,-1)*BM1_VALOR)) VALOR , '"+cAno+"' , E1_VENCREA, E1_BAIXA, E1_SALDO , E1_NOMCLI , "  
   cquery += CRLF+" e1_PREFIXO||E1_num||e1_parcela||e1_tipo tit , BM1_NOMUSR NOMUSR , DECODE (BA3_COBNIV,1,'Familia', 'Empresa') NIVCOB"  
   
   cquery += CRLF+" FROM SIGA.SE1010, SIGA.BM1010 , siga.ba3010 BA3 , (select ba11.Ba1_CODEMP cod_emp ,ba11.Ba1_MATRIC mat_fam from ba1010 ba11  , ba1010 ba12 where ba12.ba1_filial = ' ' and ba12.d_E_L_E_T_ = ' ' "  
   cquery += CRLF+" and ba11.ba1_filial = ' ' and ba11.d_E_L_E_T_ = ' '   and ba12.Ba1_CODINT = '0001' and ba12.Ba1_CODEMP = '"+CEMPRES+"' "  
   cquery += CRLF+" and  ba12.Ba1_MATRIC = '"+CMATRIC+"' and ba12.ba1_tipusu = 'T' and ba11.ba1_matvid = ba12.ba1_matvid) mattot "  
   
   cquery += CRLF+" WHERE E1_FILIAL = '01' AND E1_STATUS = 'B' AND E1_PREFIXO <> 'AXF' AND BM1_CODINT = '0001' "  

   cquery += CRLF+" AND SUBSTR(E1_BAIXA,1,4) = '"+cAno+"'  
   
   cquery += CRLF+" AND  BM1_CODEMP = mattot.cod_emp and BM1_MATRIC = mattot.mat_fam "  
   
   cquery += CRLF+" AND  BA3_FILIAL = ' ' AND BA3.D_e_l_e_t_ =' ' AND BA3_CODINT = BM1_CODINT AND  BA3_CODEMP = BM1_CODEMP  AND BA3_MATRIC =  BM1_MATRIC  "

   cquery += CRLF+" AND (SELECT  SUM(DECODE( E5_MOTBX, 'CAN', E5_VALOR *-1,'FAT', E5_VALOR *-1, 'BNF', E5_VALOR *-1,'DAC', "  
   cquery += CRLF+" E5_VALOR *-1, 'NEG', E5_VALOR *-1,'BNC', E5_VALOR *-1, 'NOR', E5_VALOR ,'CMP', E5_VALOR , 0 )) BM1VLR_EVENTO "  
   cquery += CRLF+" FROM siga.SE5010 WHERE E5_FILIAL = E1_FILIAL  AND E5_PREFIXO = E1_PREFIXO  AND E5_NUMERO = E1_NUM  AND E5_PARCELA = E1_PARCELA "  
   cquery += CRLF+" AND E5_TIPO = E1_TIPO AND E5_MOTBX IN ('CAN', 'FAT' , 'BNF' , 'DAC' , 'NEG', 'BNC', 'NOR','CMP')AND SE5010.D_E_L_E_T_ = ' ' ) > 0 "  
   cquery += CRLF+" AND SE1010.D_E_L_E_T_ = ' ' AND BM1_FILIAL = '  ' AND BM1_PREFIX = E1_PREFIXO AND BM1_NUMTIT = E1_NUM "  
   cquery += CRLF+" AND BM1_PARCEL = E1_PARCELA AND BM1_TIPTIT = E1_TIPO AND BM1_CODEMP <> '0004'" 

   cquery += CRLF+" AND BM1_CODTIP <> '108' AND BM1010.D_E_L_E_T_ = ' ' "   
 
   cquery += CRLF+" UNION ALL "  
   
   cquery += CRLF+" SELECT BM1_ANO ANOBASE, BM1_MES MESBASE, 0 AS MATANT, BM1_CODINT CODINT, BM1_CODEMP CODEMP, BM1_MATRIC MATRIC, BM1_TIPREG TIPREG , BM1_DIGITO DIGITO , "
   
//    cquery += CRLF+" decode(SIGA.SIGA_RET_SIT_TIT_DMED('C',TIT),'BNF','NAO','NEG','NAO') part_Ir ,"
   
   cquery += CRLF+" BM1_CODTIP||' - ' || BM1_DESTIP TIPO, BM1_CODEVE ||'-'||BM1_DESEVE EVENT ,((DECODE(BM1_TIPO,1,1,-1)*BM1_VALOR)) VALOR , '"+cAno+"' ANOBASEIR "  
   cquery += CRLF+" , E1_VENCREA, E1_BAIXA, E1_SALDO , E1_NOMCLI , e1_PREFIXO||E1_num||e1_parcela||e1_tipo tit , BM1_NOMUSR NOMUSR , DECODE (BA3_COBNIV,1,'Familia', 'Empresa') NIVCOB"   
                                                                            
   cquery += CRLF+" FROM SIGA.SE1010, SIGA.BM1010 , siga.ba3010 BA3 , (select ba11.Ba1_CODEMP cod_emp ,ba11.Ba1_MATRIC mat_fam from ba1010 ba11  , ba1010 ba12 where ba12.ba1_filial = ' ' and ba12.d_E_L_E_T_ = ' ' "  
   cquery += CRLF+" and ba11.ba1_filial = ' ' and ba11.d_E_L_E_T_ = ' '   and ba12.Ba1_CODINT = '0001' and ba12.Ba1_CODEMP = '"+CEMPRES+"' "  
   cquery += CRLF+" and  ba12.Ba1_MATRIC = '"+CMATRIC+"' and ba12.ba1_tipusu = 'T' and ba11.ba1_matvid = ba12.ba1_matvid) mattot "  

   cquery += CRLF+" WHERE E1_FILIAL = '01' AND E1_STATUS = 'B' AND E1_PREFIXO <> 'AXF' AND BM1_CODINT = '0001' "  

   cquery += CRLF+" AND SUBSTR(E1_BAIXA,1,4) = '"+cAno+"' "  

   cquery += CRLF+" AND  BM1_CODEMP = mattot.cod_emp and BM1_MATRIC = mattot.mat_fam "  
   
   cquery += CRLF+" AND  BA3_FILIAL = ' ' AND BA3.D_e_l_e_t_ =' ' AND BA3_CODINT = BM1_CODINT AND  BA3_CODEMP = BM1_CODEMP  AND BA3_MATRIC =  BM1_MATRIC  "
    
   cquery += CRLF+" AND (SELECT Count(*) AS TOTREG FROM siga.SE5010 WHERE E5_FILIAL = E1_FILIAL  AND E5_PREFIXO = E1_PREFIXO "  
   cquery += CRLF+" AND E5_NUMERO = E1_NUM  AND E5_PARCELA = E1_PARCELA  AND E5_TIPO = E1_TIPO  AND E5_MOTBX = 'CAN'  AND SE5010.D_E_L_E_T_ = ' ' ) = 0 "  
   cquery += CRLF+" AND (SELECT COUNT(*) AS TOTREG FROM SIGA.SE5010   WHERE E5_FILIAL = E1_FILIAL  AND E5_PREFIXO = E1_PREFIXO "  
   cquery += CRLF+" AND E5_NUMERO = E1_NUM  AND E5_PARCELA = E1_PARCELA  AND E5_TIPO = E1_TIPO AND E5_MOTBX = 'FAT' AND SE5010.D_E_L_E_T_ = ' ' )> 0 "  
   
if nParc == 1
   cquery += CRLF+" AND SE1010.D_E_L_E_T_ = ' 'AND EXISTS (SELECT NULL FROM   SIGA.SE1010 E1FAT WHERE  E1FAT.E1_PREFIXO = 'FAT' AND E1FAT.E1_FILIAL = '01' "   
else
   cquery += CRLF+" AND SE1010.D_E_L_E_T_ = ' 'AND EXISTS (SELECT NULL FROM   SIGA.SE1010 E1FAT WHERE  E1FAT.E1_tipo = 'FT' AND E1FAT.E1_FILIAL = '01' "  
EndIf   
   cquery += CRLF+" AND E1FAT.E1_PREFIXO = SE1010.E1_FATPREF AND E1FAT.E1_NUM = SE1010.E1_FATURA AND E1FAT.E1_SALDO = 0 AND E1FAT.D_E_L_E_T_ = ' ' "  
   cquery += CRLF+" AND ( SELECT Count(*) AS TOTREG  FROM siga.SE5010 E5FAT  WHERE E5FAT.E5_FILIAL = E1FAT.E1_FILIAL AND E5FAT.E5_PREFIXO = E1FAT.E1_PREFIXO  AND E5FAT.E5_NUMERO = E1FAT.E1_NUM "  
             
if nParc == 1
   cquery += CRLF+" AND E5FAT.E5_MOTBX IN ('NOR','CMP')  
else 
   cquery += CRLF+" AND E5FAT.E5_MOTBX IN ('NEG','NOR','CMP')  
EndIf      

   cquery += CRLF+" AND E5FAT.E5_PARCELA = E1FAT.E1_PARCELA  AND E5FAT.E5_TIPO = E1FAT.E1_TIPO  AND E5FAT.D_E_L_E_T_ = ' ') > 0) "  
   cquery += CRLF+" AND BM1_FILIAL = '  ' AND BM1_PREFIX = E1_PREFIXO AND BM1_NUMTIT = E1_NUM AND BM1_PARCEL = E1_PARCELA AND BM1_TIPTIT = E1_TIPO AND BM1_CODEMP <> '0004' "  
 
   cquery += CRLF+" AND BM1_CODTIP <> '108' AND BM1010.D_E_L_E_T_ = ' ' ) "     
   cquery += CRLF+" where  decode(trim(substr(event,1,4)),'0031','Não','0038','Não',( "
   cquery += CRLF+"        decode(trim(substr(TIPO,1,4)),'102','Não','103','Não','107','Não','108','Não','908','Não','927','Não','937','Não','940','Não','948','Não','950','Não','956','Não','Sim'))) =  'Sim' "   
   cquery += CRLF+" GROUP BY ANOBASE , MESBASE , MATANT , CODINT , CODEMP , MATRIC , TIPREG , DIGITO , '"+cAno+"' , tipo , EVENT  ,E1_VENCREA, E1_BAIXA, E1_SALDO , E1_NOMCLI , tit , NOMUSR , NIVCOB order by 5,6,7,1,2  "  

 Else 

   cquery :=      " SELECT ANOBASE , MESBASE , MATANT , CODINT , CODEMP , MATRIC , TIPREG , DIGITO , "
   cquery += CRLF+"  tipo , EVENT ,  SUM(VALOR) VALOR , '"+cAno+"' ANOBASEIR , E1_VENCREA, E1_BAIXA, E1_SALDO , E1_NOMCLI ,tit , NOMUSR , NIVCOB , " 
   cquery += CRLF+" FROM ( SELECT BM1_ANO ANOBASE, BM1_MES MESBASE, 0 AS MATANT, BM1_CODINT CODINT, BM1_CODEMP CODEMP, BM1_MATRIC MATRIC, BM1_TIPREG TIPREG, BM1_DIGITO DIGITO , "  
   cquery += CRLF+" BM1_CODTIP||' - ' || BM1_DESTIP TIPO , BM1_CODEVE ||'-'||BM1_DESEVE EVENT ,((DECODE(BM1_TIPO,1,1,-1)*BM1_VALOR)) VALOR , '"+cAno+"' , E1_VENCREA, E1_BAIXA, E1_SALDO , E1_NOMCLI , "
   cquery += CRLF+" e1_PREFIXO||E1_num||e1_parcela||e1_tipo tit , BM1_NOMUSR NOMUSR , DECODE (BA3_COBNIV,1,'Familia', 'Empresa') NIVCOB"  
   cquery += CRLF+" FROM SE1020, BM1020 , BA3020  , (select ba11.Ba1_CODEMP cod_emp ,ba11.Ba1_MATRIC mat_fam from ba1020 ba11  , ba1020 ba12 where ba12.ba1_filial = ' ' and ba12.d_E_L_E_T_ = ' ' "  
   cquery += CRLF+" and ba11.ba1_filial = ' ' and ba11.d_E_L_E_T_ = ' '   and ba12.Ba1_CODINT = '0001' and ba12.Ba1_CODEMP = '"+CEMPRES+"' "  
   cquery += CRLF+" and  ba12.Ba1_MATRIC = '"+CMATRIC+"' and ba12.ba1_tipusu = 'T' and ba11.ba1_matvid = ba12.ba1_matvid) mattot "  
   
   cquery += CRLF+" WHERE E1_FILIAL = '01'  AND E1_STATUS = 'B' "  
               
   CQUERY += CRLF+" AND SUBSTR(E1_BAIXA,1,4) = '"+CANO+"' "  
     
   cquery += CRLF+" AND  BM1_CODEMP = mattot.cod_emp and BM1_MATRIC = mattot.mat_fam "  
                
   cquery += CRLF+" AND (SELECT Count(*) AS TOTREG FROM SE5020   WHERE E5_FILIAL = E1_FILIAL   AND E5_PREFIXO = E1_PREFIXO AND E5_NUMERO = E1_NUM "  
   cquery += CRLF+" AND E5_PARCELA = E1_PARCELA   AND E5_TIPO = E1_TIPO AND E5_MOTBX IN ('CAN', 'FAT' , 'BNF' , 'DAC' , 'NEG', 'BNC') AND SE5020.D_E_L_E_T_ = ' ' ) = 0 "  
   cquery += CRLF+" AND (SELECT COUNT(*) AS TOTREG   FROM SE5020   WHERE E5_FILIAL = E1_FILIAL   AND E5_PREFIXO = E1_PREFIXO AND E5_NUMERO = E1_NUM "  
   cquery += CRLF+" AND E5_PARCELA = E1_PARCELA   AND E5_TIPO = E1_TIPO   AND E5_MOTBX IN ('NOR','CMP')  AND SE5020.D_E_L_E_T_ = ' ') > 0 "  
   cquery += CRLF+" AND SE1020.D_E_L_E_T_ = ' ' AND BM1_FILIAL = '  ' AND BM1_PREFIX = E1_PREFIXO AND BM1_NUMTIT = E1_NUM AND BM1_PARCEL = E1_PARCELA "  
   cquery += CRLF+" AND BM1_TIPTIT = E1_TIPO "                                         
   
   //cquery += CRLF+" AND BM1_CODEVE NOT IN ('998','053', '012','064','013','066','040','041','993', '048','103','107') "   
   
 //  cquery += CRLF+" AND BM1_CODtip NOT IN ('103','108','903','906','907','909','911') "
 //  cquery += CRLF+" AND BM1_CODEVE NOT IN ('996','999') "
    
   cquery += CRLF+"    and bm1_codtip not in('108','103','107','908','932','937','948','950') " 
   
   cquery += CRLF+" AND BM1_CODTIP NOT IN('108') AND BA3020.D_E_L_E_T_ = ' ' AND BA3_CODINT = BM1_CODINT AND BA3_CODEMP = BM1_CODEMP "  
   cquery += CRLF+" AND ba3_matric = bm1_matric  AND BM1020.D_E_L_E_T_ = ' ' "  
 
   cquery += CRLF+" union all "  
 
   cquery += CRLF+" SELECT BM1_ANO ANOBASE, BM1_MES MESBASE, 0 AS MATANT, BM1_CODINT CODINT, BM1_CODEMP CODEMP, BM1_MATRIC MATRIC, BM1_TIPREG TIPREG, BM1_DIGITO DIGITO , "  
   cquery += CRLF+" BM1_CODTIP||' - ' || BM1_DESTIP TIPO , BM1_CODEVE ||'-'||BM1_DESEVE EVENT ,((DECODE(BM1_TIPO,1,1,-1)*BM1_VALOR)) VALOR , '"+cAno+"' , E1_VENCREA, E1_BAIXA, E1_SALDO , E1_NOMCLI , "  
   cquery += CRLF+" E1_PREFIXO||E1_NUM||E1_PARCELA||E1_TIPO TIT , BM1_NOMUSR NOMUSR , DECODE (BA3_COBNIV,1,'Familia', 'Empresa') NIVCOB FROM SE1020, BM1020 , BA3020 , (select ba11.Ba1_CODEMP cod_emp ,ba11.Ba1_MATRIC mat_fam from ba1020 ba11  , ba1020 ba12 where ba12.ba1_filial = ' ' and ba12.d_E_L_E_T_ = ' ' "  
   cquery += CRLF+" and ba11.ba1_filial = ' ' and ba11.d_E_L_E_T_ = ' '   and ba12.Ba1_CODINT = '0001' and ba12.Ba1_CODEMP = '"+CEMPRES+"' "  
   cquery += CRLF+" and  ba12.Ba1_MATRIC = '"+CMATRIC+"' and ba12.ba1_tipusu = 'T' and ba11.ba1_matvid = ba12.ba1_matvid) mattot "  
   
   cquery += CRLF+" WHERE E1_FILIAL = '01' AND E1_STATUS = 'B' "  

   cQUERY += CRLF+" AND SUBSTR(E1_BAIXA,1,4) = '"+CANO+"' "                            
   
   cquery += CRLF+" AND  BM1_CODEMP = mattot.cod_emp and BM1_MATRIC = mattot.mat_fam "  
   
   cquery += CRLF+" AND ( SELECT COUNT(*) AS TOTREG FROM SE5020 WHERE E5_FILIAL = E1_FILIAL AND E5_PREFIXO = E1_PREFIXO AND E5_NUMERO = E1_NUM "  
   cquery += CRLF+" AND E5_PARCELA = E1_PARCELA   AND E5_TIPO = E1_TIPO  AND E5_MOTBX = 'CAN'   AND SE5020.D_E_L_E_T_ = ' ' ) = 0 "  
   cquery += CRLF+" AND ( SELECT COUNT(*) AS TOTREG FROM SE5020   WHERE E5_FILIAL = E1_FILIAL AND E5_PREFIXO = E1_PREFIXO AND E5_NUMERO = E1_NUM "  
   cquery += CRLF+" AND E5_PARCELA = E1_PARCELA  AND E5_TIPO = E1_TIPO  AND E5_MOTBX = 'FAT'   AND SE5020.D_E_L_E_T_ = ' ' ) > 0 "  
//   cquery += CRLF+" AND EXISTS (SELECT NULL  FROM   SE1020 E1FAT WHERE  E1FAT.E1_PREFIXO = 'FAT' AND E1FAT.E1_FILIAL = '01'  AND E1FAT.E1_PREFIXO = SE1020.E1_FATPREF "   
   cquery += CRLF+" AND EXISTS (SELECT NULL  FROM   SE1020 E1FAT WHERE  E1FAT.E1_tipo  = 'FT' AND E1FAT.E1_FILIAL = '01'  AND E1FAT.E1_PREFIXO = SE1020.E1_FATPREF "  
   
   cquery += CRLF+" AND E1FAT.E1_NUM = SE1020.E1_FATURA   AND    E1FAT.E1_SALDO = 0  AND    E1FAT.D_E_L_E_T_ = ' ' "  
   cquery += CRLF+" AND ( SELECT COUNT(*) AS TOTREG FROM SE5020 E5FAT WHERE E5FAT.E5_FILIAL = E1FAT.E1_FILIAL AND E5FAT.E5_PREFIXO = E1FAT.E1_PREFIXO "  
   cquery += CRLF+" AND E5FAT.E5_NUMERO = E1FAT.E1_NUM  AND E5FAT.E5_PARCELA = E1FAT.E1_PARCELA AND E5FAT.E5_TIPO = E1FAT.E1_TIPO "  
   cquery += CRLF+" AND E5FAT.E5_MOTBX IN ('NEG','NOR','CMP')  AND E5FAT.D_E_L_E_T_ = ' '  ) > 0) "  
   cquery += CRLF+" AND BM1_FILIAL = '  ' AND BM1_PREFIX = E1_PREFIXO AND BM1_NUMTIT = E1_NUM AND BM1_PARCEL = E1_PARCELA AND BM1_TIPTIT = E1_TIPO "  
//   cquery += CRLF+" AND BM1_CODEVE NOT IN ('998','053', '012','064','013','066','040','041','993', '048','103' , '107') "

   cquery += CRLF+"    and bm1_codtip not in('108','103','107','908','932','937','948','950') " 

   cquery += CRLF+" AND BA3020.D_E_L_E_T_ = ' ' AND BA3_CODINT = BM1_CODINT AND BA3_CODEMP = BM1_CODEMP AND BA3_MATRIC = BM1_MATRIC "  
   cquery += CRLF+" AND BM1020.D_E_L_E_T_ = ' ' AND SE1020.D_E_L_E_T_ = ' '  ) "       
   
   
   cquery += CRLF+" GROUP BY ANOBASE , MESBASE , MATANT , CODINT , CODEMP , MATRIC , TIPREG , DIGITO , '"+cAno+"' , TIPO , EVENT  ,E1_VENCREA, E1_BAIXA, E1_SALDO , E1_NOMCLI , TIT , NOMUSR , NIVCOB ORDER BY 5,6,7,1,2  "  


EndIf  
*/
//////////////////////////////     
//////////////////////////////
	   	
    If Select((cAliastmp)) <> 0 
       (cAliastmp)->(DbCloseArea()) 
    Endif
  
    TCQuery cQuery New Alias (cAliastmp)  
    
    dbSelectArea(cAliastmp)
   
    (cAliastmp)->(dbGoTop())   
     
    While (cAliastmp)->(!Eof())    
       VENC:=STOD((cAliastmp)->E1_VENCREA)
       BAIX:=STOD((cAliastmp)->E1_BAIXA) 
          
       If cEmpresa    == 'C' .and.  (cAliastmp)->CODEMP $ ('0001|0002|0005')
       
          If fVBx201601((cAliastmp)->tit ) == 1  
             cSairIr := (cAliastmp)->part_Ir  
          Else                              
             cSairIr := 'Não'
          endIf   
       else
          cSairIr := (cAliastmp)->part_Ir  
       EndIf       
       aaDD(aDados1,{(cAliastmp)->ANOBASE+'/'+(cAliastmp)->MESBASE ,;
						(cAliastmp)->CODINT+'.'+(cAliastmp)->CODEMP+'.'+(cAliastmp)->MATRIC+'.'+(cAliastmp)->TIPREG + '-' + (cAliastmp)->DIGITO + ' - ' + (cAliastmp)->NOMUSR ,; 
						(cAliastmp)->tipo                             ,;
						(cAliastmp)->EVENT                            ,; 
						(cAliastmp)->VALOR                            ,;
						(cAliastmp)->ANOBASEIR                        ,;
						 VENC              ,;  
						 BAIX              ,;
						(cAliastmp)->tit  ,;
						 substr((cAliastmp)->E1_NOMCLI,1,45),;
						(cAliastmp)->NIVCOB ,;
					     cSairIr                          })                
						
			(cAliastmp)->(dbSkip()) 	   
     EndDo	                   
Return                    

*************************************************************************************************************  
Static Function fGeraRel2

Local oReport 
Private cPerg		:= "CABR138"  
Private aOrdem 		:= {}//{'RDA','Ano/Mes'}

//aSort( aDados1,,,{|x,y| x[10] < y[10]} )

oReport:= ReportDef2()
oReport:PrintDialog()

Return

*************************************************************************************************************

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
oReport	:= TReport():New("CABR138","Listagem de Conferencia das Informações de Ir dos Assistidos por familia ",, {|oReport| ReportPrt(oReport)},"Listagem de Conferencia das Informações de Ir dos Assistidos por familia ")
oReport:SetTotalInLine(.F.)//Imprime na linha: .F. - Imprime abaixo da linha com o titulo de cada coluna: .T.
//oReport:SetTotalText('Total Geral') 

*'-----------------------------------------------------------------------------------'*
*'Solucao para impressao em que as colunas se truncam: "SetColSpace" e "SetLandScape"'* 
*'-----------------------------------------------------------------------------------'*

oReport:SetColSpace(1) //Espacamento entre colunas. 
oReport:SetLandscape() //Impressao em paisagem.  
//oReport:SetPortrait() //Impressao em retrato.  

oDPJ := TRSection():New(oReport,"Listagem de Conferencia das Informações de Ir dos Assistidos por familia ",,aOrdem)             

//If cEmpresa  == 'C' 
   TRCell():New(oDPJ ,'COMPET'	    		,/*TABELA*/	,'Competencia' 	         ,/*Picture*/   ,08				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
   TRCell():New(oDPJ ,'IDENT'	     		,/*TABELA*/	,'Matric - Nome Titular' ,/*Picture*/ 	,45				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		) 
   TRCell():New(oDPJ ,'USUARI'	     		,/*TABELA*/	,'Resp. Financeiro '     ,/*Picture*/ 	,30				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)  
   TRCell():New(oDPJ ,'NIVCOB'	     		,/*TABELA*/	,'Nivel Cobranca '       ,/*Picture*/ 	,20				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)  
   TRCell():New(oDPJ ,'PARTIR'		        ,/*TABELA*/	,'Part. Ir'              ,/*Picture*/ 	,05			  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)     
   TRCell():New(oDPJ ,'TIPO'		        ,/*TABELA*/	,'Tipo '                 ,/*Picture*/ 	,30			  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)  
   TRCell():New(oDPJ ,'EVENT'	      	    ,/*TABELA*/	,'Evento '               ,/*Picture*/ 	,30			  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)  
   TRCell():New(oDPJ ,'VALOR'	      	    ,/*TABELA*/	,'Valor  '         ,"@E 99,999,999.99" 	,14				,,,,,"RIGHT"	) 
   TRCell():New(oDPJ ,'ANOIR'		    	,/*TABELA*/	,'Ano Ir '         ,/*Picture*/ 	    ,04			  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)   
   TRCell():New(oDPJ ,'TITULO'	     		,/*TABELA*/	,'Ident. Tit. '	   ,/*Picture*/ 	    ,17				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)                                                                                             
   TRCell():New(oDPJ ,'VENCTO'		    	,/*TABELA*/	,'Dt. Vencto '     ,/*Picture*/ 	    ,10			  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
   TRCell():New(oDPJ ,'BAIXA'	     		,/*TABELA*/	,'Dt. Baixa  '	   ,/*Picture*/ 	    ,10				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)  

//EndIf 
 
oBreak01 		:= TRBreak():New(oDPJ,oDPJ:Cell("IDENT"),"Total por Usuario "	,.F.)  

lTotSecBrk01	:= .T.//Indica se totalizador sera impresso na quebra de secao
lTotFimBrk01	:= .T.//Indica se totalizador sera impresso no final do relatorio - Como o total eh o mesmo, basta que apenas um esteja ativado

                                                                   
TRFunction():New(oDPJ:Cell("VALOR")    	    ,NIL,"SUM"		,oBreak01,,"@E 999,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01) 

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
         
       oDPJ:Cell('COMPET'	 		):SetValue((aDados1[i][1]))     
       oDPJ:Cell('IDENT'	 		):SetValue((aDados1[i][2]))    
       oDPJ:Cell('USUARI'	 		):SetValue((aDados1[i][10]))    
       oDPJ:Cell('NIVCOB'	 		):SetValue((aDados1[i][11]))  
       oDPJ:Cell('PARTIR'           ):SetValue((aDados1[i][12]))
       oDPJ:Cell('TIPO'  	  		):SetValue((aDados1[i][3]))       
       oDPJ:Cell('EVENT'  	    	):SetValue((aDados1[i][4]))   
       oDPJ:Cell('VALOR'  	        ):SetValue((aDados1[i][5]))
       oDPJ:Cell('ANOIR'	 		):SetValue((aDados1[i][6]))     
       oDPJ:Cell('TITULO'	 		):SetValue((aDados1[i][9]))     	  
       oDPJ:Cell('VENCTO'	 		):SetValue((aDados1[i][7]))          
       oDPJ:Cell('BAIXA'	 		):SetValue((aDados1[i][8]))           
             

   oDPJ:PrintLine()
   
Next i

oDPJ:Finish()

Return   

******************************************************************************************

Static Function AjustaSX1(cPerg)

Local aHelpPor := {}

PutSx1(cPerg,"01",OemToAnsi("Ano Referencia  ") 		,"","","mv_ch1","C",04,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","","",{},{})
PutSx1(cPerg,"02",OemToAnsi("Cod. Empresa   ") 	    	,"","","mv_ch2","C",04,0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","","",{},{})     
PutSx1(cPerg,"03",OemToAnsi("Cod. Matricula  ") 		,"","","mv_ch3","C",06,0,0,"G","","","","","mv_par03","","","","","","","","","","","","","","","","","",{},{})    
PutSx1(cPerg,"04",OemToAnsi("Gerar Excel ") 	        ,"","","mv_ch4","N",01,0,0,"C","","","","","mv_par04","Sim","","","","Não","","","","","","","","","","","",{},{},{}) 

PutSx1(cPerg,"05",OemToAnsi("Sem Parcelamento? ") 	    ,"","","mv_ch5","N",01,0,0,"C","","","","","mv_par05","Sim","","","","Não","","","","","","","","","","","",{},{},{}) 

Pergunte(cPerg,.F.)

Return                                      

STATIC Function fVBx201601(cTit)
 
local Ret:= 1

cquery2016 := "SELECT Count(*) AS TOTREG "
cquery2016 += CRLF+"  FROM SE5010 SE5 "
cquery2016 += CRLF+"  WHERE E5_FILIAL = '01' "
cquery2016 += CRLF+"  AND E5_PREFIXO ||E5_NUMERO || E5_PARCELA ||E5_TIPO = '"+cTit+"' "
cquery2016 += CRLF+"  AND e5_motbx='NOR'      "
cquery2016 += CRLF+"  and trim(e5_histor) = 'BX. AUTOM. RIO PREV' "
cquery2016 += CRLF+"  and e5_data = '20160105' "
//cquery2016 += CRLF+"  and e1_codemp in ('0001', '0002','0005')) "
cquery2016 += CRLF+"  AND SE5.D_E_L_E_T_ = ' ' "
    
    If Select((cAlias2016)) <> 0 
       (cAlias2016)->(DbCloseArea()) 
    Endif
  
    TCQuery cQuery2016 New Alias (cAlias2016)  
    
    If (cAlias2016)->TOTREG >  0
    
       Ret:= 2
       
    else                   
    
      Ret:= 1

    EndIf   
                                            
Return(Ret)                                      
