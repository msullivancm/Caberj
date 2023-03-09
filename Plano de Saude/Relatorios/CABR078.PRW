#include "protheus.ch"
#include "rwmake.ch"
#include "topconn.ch"

#DEFINE  nColMax 2200
#DEFINE  nLinMax 3100 //2220
#DEFINE  nPosCol 0080

#DEFINE  CLR_GRAY   RGB(192,192,192)

/*-----------------------------------------------------------------------
|Funcao    | CABR078  | Autor | Joany Peres          | Data | 26/03/2013 |
|------------------------------------------------------------------------|
| Descricao| CAPA DE EXCLUSAO                                            |
|------------------------------------------------------------------------|
|          | Solicitado pela usuária Ana Paula - CADASTRO                |
|          |                                                             |
 -----------------------------------------------------------------------*/
user function CABR078(pcCodInt,pcCodEmp,pcConEmp,pcSubCon,pcMatric,pcTipUsu,pcTipReg)

local aAreaBA1  := BA1->( GetArea() )


// Variaveis passadas por parametro - TESTE      

*cCodInt = '0001'
*cCodEmp = '0001'
*cConEmp = '000000000001'
*cSubCon = '000000001'
*cMatric = '001034'
*cTipUsu = 'T'
*cTipReg = '00'

SetPrvt("CTITULO,WNREL,ARETURN,TAMANHO,NLIN","LRET")
SetPrvt("NLASTKEY,CABEC1,CABEC2,CBTEXT,X1,X2")
SetPrvt("CCABEC1,CCABEC2,NCOL,PRIMEIRO,DATA,HORA,NREGS")

private aChave    := {}

cFilial   := ' '
cCodInt   := pcCodInt
cCodEmp   := pcCodEmp
cConEmp   := pcConEmp
cSubCon   := pcSubCon
cMatric   := pcMatric
cTipUsu   := pcTipUsu
cTipReg   := pcTipReg

cString  := "BA1"
nLin     := 0
nLastKey := 0
cTitulo  := "CAPA DE BLOQUEIO"
nTLin    := 50
lRet     := .F.
lSai     := .F.      

dbSelectArea("BA1")

begin sequence 
   if nLastKey == 27 ; break ; endif
   Processa({ |lEnd| lSai := Imprime() }, OemToAnsi( cTitulo ), OemToAnsi('Aguarde...'), .T.)
end sequence
BA1->( RestArea(aAreaBA1) )

return lSai

static function Imprime()

Local x := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

private  nLin      := nLinMax,;
         cCabec1   := cabec1 ,;
         primeiro  := .t.    ,;
         nCol      := 0      ,;
         nQtdReg   := 0      ,;
         nPag      := 0      ,;
         nPag      := 0      ,;
         cbText    := ""     ,;
         cCabec2   := ""     ,;
         cSelect   := ''     ,;
         cFrom     := ''     ,;
         cWhere    := ''     ,;
         cOrder    := ''     ,;
         cTexto    := ''     ,;
         cCompleta := ''     ,;
         cTitCol   := ''
private oPrint   := TMSPrinter():New(OemToAnsi(cTitulo)),;
        oFont08T := TFont():New("Tahoma",08,08,,.F.,,,,.T.,.F.),;
        oFont09T := TFont():New("Tahoma",09,09,,.F.,,,,.T.,.F.),;
        oFont10T := TFont():New("Tahoma",10,10,,.F.,,,,.T.,.F.),;
        oFont11T := TFont():New("Tahoma",11,11,,.F.,,,,.T.,.F.),; 
        oFont12T := TFont():New("Tahoma",12,12,,.F.,,,,.T.,.F.),;        
        oFont08C := TFont():New("Courier New",08,08,,.F.,,,,.T.,.F.),;		
        oFont09C := TFont():New("Courier New",09,09,,.F.,,,,.T.,.F.),;
        oFont10C := TFont():New("Courier New",10,10,,.F.,,,,.T.,.F.),; 
        oFont18C := TFont():New("Courier New",18,18,,.F.,,,,.T.,.F.)        
//oPrint:SetLandsCape()                
oPrint:SetPortrait() 
private oBrush   := TBrush():New( ,CLR_GRAY )               
private aCAPA    := {}

/*-----------------------------------------------------------------------
| Posicionamento dos campos                                              | 
 -----------------------------------------------------------------------*/
 _nCol1 := 0100
 _nCol2 := 0900  

/*-------------------------------------------------------------------------
| Esta query monta a familia flegada.                                      |              
 -------------------------------------------------------------------------*/
beginsql Alias "BA1TMP"
SELECT BA1_FILIAL
     , BA1_CODINT
     , BA1_CODEMP
     , BA1_CONEMP
     , BA1_SUBCON
     , BA1_MATRIC
     , BA1_TIPUSU
     , BA1_TIPREG  
     , BA1_DIGITO 
     , BA1_YIMPCA
FROM %table:BA1%
WHERE D_E_L_E_T_ = ' ' 
  AND BA1_YIMPCA = '1'                 
  AND BA1_CODINT = %Exp:cCodInt%
  AND BA1_CODEMP = %Exp:cCodEmp%
  AND BA1_MATRIC = %Exp:cMatric%
  
endsql                
   
dbSelectArea("BA1TMP")

BA1TMP->( dbGoTop() )  

while BA1TMP->( !EOF() )
                  
    cFilial := BA1TMP->BA1_FILIAL
    cCodInt := BA1TMP->BA1_CODINT
    cCodEmp := BA1TMP->BA1_CODEMP
    cConEmp := BA1TMP->BA1_CONEMP
    cSubCon := BA1TMP->BA1_SUBCON
    cMatric := BA1TMP->BA1_MATRIC
    cTipUsu := BA1TMP->BA1_TIPUSU
    cTipReg := BA1TMP->BA1_TIPREG
    cDigito := BA1TMP->BA1_DIGITO

    /*-------------------------------------------------------------------------
    | Monta array com chave para ser usado na gravacao do FLAG de SIM para NAO |
     -------------------------------------------------------------------------*/
    aADD( aChave,{cFilial+cCodInt+cCodEmp+cMatric+cTipUsu+cTipReg+cDigito} )      

    if SELECT("CAPA") > 0 ; CAPA->( dbCloseArea() ) ; endif	
	
	beginSql alias "CAPA"
	  
	SELECT 'FAMILIA' X1,' ' X2
	  FROM  DUAL
	UNION ALL 
	SELECT 'EMPRESA' X1,BG9_CODIGO X2   
	  FROM  %table:BG9% 
	 WHERE BG9_CODINT = %Exp:cCodInt% 
	   AND BG9_CODIGO = %Exp:cCodEmp% 
	   AND BG9_TIPO   = '2'   
	   AND D_E_L_E_T_ = ' '
	   AND BG9_FILIAL = ' '
	UNION ALL
	SELECT 'CONTRATO' X1,BT5_NUMCON X2
	FROM  %table:BT5% 
	WHERE BT5_NUMCON = %Exp:cConEmp%
	  AND BT5_CODIGO = %Exp:cCodEmp%
	  AND D_E_L_E_T_ = ' '
	  AND BT5_FILIAL = ' '
	UNION ALL
	SELECT 'SUBCONTRATO' X1,BQC_SUBCON||' - '||Trim(BQC_DESCRI) X2
	FROM  %table:BQC% 
	WHERE BQC_NUMCON = %Exp:cConEmp%
	  AND BQC_CODIGO = %Exp:cCodInt+cCodEmp%
	  AND BQC_SUBCON = %Exp:cSubCon%
	  AND D_E_L_E_T_ = ' '
	  AND BQC_FILIAL = ' '
	UNION ALL
	SELECT 'MATRICULA' X1,BA1_MATRIC||' - '||Trim(BA1_NOMUSR) X2
	FROM  %table:BA1%  BA1
	WHERE BA1_CODINT = %Exp:cCodInt%
	  AND BA1_CODEMP = %Exp:cCodEmp%
	  AND BA1_MATRIC = %Exp:cMatric%
	  AND BA1_TIPUSU = %Exp:cTipUsu%
	  AND BA1_TIPREG = %Exp:cTipReg%
	  AND BA1.D_E_L_E_T_ = ' '
	  AND BA1_FILIAL = ' '
	UNION ALL
	SELECT 'DATA EXCLUSAO' X1,SubStr(BC3_DATA,7,2)||'/'||SubStr(BC3_DATA,5,2)||'/'||SubStr(BC3_DATA,1,4) X2
    FROM  %table:BC3% 
	WHERE BC3_MATRIC = %Exp:cCodInt%+%Exp:cCodEmp%+%Exp:cMatric%
	  AND D_E_L_E_T_ = ' '
	  AND BC3_FILIAL = ' '
	UNION ALL
	SELECT 'MOTIVO EXCLUSAO' X1,BC3_OBS X2
    FROM  %table:BC3% 
	WHERE BC3_MATRIC = %Exp:cCodInt%+%Exp:cCodEmp%+%Exp:cMatric%
	  AND D_E_L_E_T_ = ' '
	  AND BC3_FILIAL = ' '
	UNION ALL	
	SELECT 'COD PLANO' X1,BA1_CODPLA||' - '||Trim(BI3_DESCRI) X2
	FROM  %table:BA1%  BA1, %table:BI3%  BI3
	WHERE BA1_CODINT = %Exp:cCodInt%
	  AND BA1_CODEMP = %Exp:cCodEmp%
	  AND BA1_MATRIC = %Exp:cMatric%
	  AND BA1_TIPUSU = %Exp:cTipUsu%
	  AND BA1_TIPREG = %Exp:cTipReg%
	  AND BI3_CODINT = BA1_CODINT
	  AND BI3_CODIGO = BA1_CODPLA
	  AND BA1_FILIAL = ' '
	  AND BI3_FILIAL = ' '
	  AND BA1.D_E_L_E_T_ = ' '
	  AND BI3.D_E_L_E_T_ = ' '
	UNION ALL
	SELECT 'COBRANCA' X1,' ' X2
	FROM  DUAL
	UNION ALL
	SELECT 'GRUPO COBRANCA' X1,BA3_GRPCOB X2
	FROM  %table:BA3% 
	WHERE BA3_CONEMP = %Exp:cConEmp%
	  AND BA3_CODINT = %Exp:cCodInt%
	  AND BA3_CODEMP = %Exp:cCodEmp%
	  AND BA3_SUBCON = %Exp:cSubCon%
	  AND BA3_MATRIC = %Exp:cMatric%
	  AND D_E_L_E_T_ = ' '
	  AND BA3_FILIAL = ' '
	UNION ALL
	SELECT 'FORMA DE PAGAMENTO' X1, BA3_TIPPAG||' - '||Trim(BQL_DESCRI) X2
	FROM  %table:BA3% BA3, %table:BQL% BQL   
	WHERE BA3_CONEMP = %Exp:cConEmp%
	  AND BA3_CODINT = %Exp:cCodInt%
	  AND BA3_CODEMP = %Exp:cCodEmp%
	  AND BA3_SUBCON = %Exp:cSubCon%
	  AND BA3_MATRIC = %Exp:cMatric%     
      AND BQL_FILIAL = BA3_FILIAL
      AND BQL_CODIGO = BA3_TIPPAG
	  AND BQL.D_E_L_E_T_ = ' '
	  AND BA3.D_E_L_E_T_ = ' '
	  AND BA3_FILIAL     = ' '
	UNION ALL
	SELECT 'BCO - AGENCIA - CONTA' X1, Trim(BA3_BCOCLI)||' - '||Trim(BA3_AGECLI)||' - '||Trim(BA3_CTACLI) X2
	FROM  %table:BA3% 
	WHERE BA3_CONEMP = %Exp:cConEmp%
	  AND BA3_CODINT = %Exp:cCodInt%
	  AND BA3_CODEMP = %Exp:cCodEmp%
	  AND BA3_SUBCON = %Exp:cSubCon%
	  AND BA3_MATRIC = %Exp:cMatric%
	  AND D_E_L_E_T_ = ' '
	  AND BA3_FILIAL = ' '
	UNION ALL
	SELECT 'COD CLIENTE - NOME CLIENTE' X1,Trim(BA3_CODCLI)||' - '||Trim(A1_NOME) X2
	FROM  %table:BA3%  BA3, %table:SA1%  SA1
	WHERE BA3_CODCLI = A1_COD
	  AND BA3_CONEMP = %Exp:cConEmp%
	  AND BA3_CODINT = %Exp:cCodInt%
	  AND BA3_CODEMP = %Exp:cCodEmp%
	  AND BA3_SUBCON = %Exp:cSubCon%
	  AND BA3_MATRIC = %Exp:cMatric%
	  AND SA1.D_E_L_E_T_ = ' '
	  AND BA3.D_E_L_E_T_ = ' '
	  AND A1_FILIAL  = ' '
	  AND BA3_FILIAL = ' '
	UNION ALL
	SELECT 'ENDEREÇO CLIENTE' X1,Trim(A1_END) X2
	FROM  %table:BA3%  BA3, %table:SA1%  SA1
	WHERE BA3_CODCLI = A1_COD
	  AND BA3_CONEMP = %Exp:cConEmp%
	  AND BA3_CODINT = %Exp:cCodInt%
	  AND BA3_CODEMP = %Exp:cCodEmp%
	  AND BA3_SUBCON = %Exp:cSubCon%
	  AND BA3_MATRIC = %Exp:cMatric%
	  AND BA3.D_E_L_E_T_ = ' '
	  AND SA1.D_E_L_E_T_ = ' '
	  AND A1_FILIAL  = ' '
	  AND BA3_FILIAL = ' '
	UNION ALL
	SELECT 'BAIRRO - ESTADO - CEP' X1,Trim(A1_BAIRRO)||' - '||Trim(A1_EST)||' - '||A1_CEP X2
	FROM  %table:BA3%  BA3, %table:SA1%  SA1
	WHERE BA3_CODCLI = A1_COD
	  AND BA3_CONEMP = %Exp:cConEmp%
	  AND BA3_CODINT = %Exp:cCodInt%
	  AND BA3_CODEMP = %Exp:cCodEmp%
	  AND BA3_SUBCON = %Exp:cSubCon%
	  AND BA3_MATRIC = %Exp:cMatric%
	  AND BA3.D_E_L_E_T_ = ' '
	  AND SA1.D_E_L_E_T_ = ' '
	  AND A1_FILIAL  = ' '
	  AND BA3_FILIAL = ' '
	UNION ALL
	SELECT 'VLR MENSALIDADE USUARIO' X1, 'R$ '||Trim(to_char(BDK_VALOR, '9,999.99') ) X2
	FROM  %table:BA1%  BA1, %table:BDK%  BDK
	WHERE BA1_CODINT = %Exp:cCodInt%
	  AND BA1_CODEMP = %Exp:cCodEmp%
	  AND BA1_MATRIC = %Exp:cMatric%
	  AND BA1_TIPUSU = %Exp:cTipUsu%
	  AND BA1_TIPREG = %Exp:cTipReg%
	  AND BDK_CODINT = BA1_CODINT
	  AND BDK_CODEMP = BA1_CODEMP
	  AND BDK_MATRIC = BA1_MATRIC
	  AND BDK_TIPREG = BA1_TIPREG        
	  AND ( ( BA1_MUDFAI = 0 and BA1_FAICOB = BDK_CODFAI ) or ( BA1_MUDFAI <> 0 and IDADE_S(BA1_DATNAS) >= BDK_IDAINI AND IDADE_S(BA1_DATNAS) <= BDK_IDAFIN  ))             
	  AND BA1.D_E_L_E_T_ = ' '
	  AND BDK.D_E_L_E_T_ = ' '
	  AND BA1_FILIAL = ' '
	  AND BDK_FILIAL = ' '
	UNION ALL
	SELECT 'VLR MENSALIDADE FAMILIA' X1, 'R$ '||Trim(to_char(BBU_VALFAI, '999,999.99') ) X2
	FROM  %table:BA1%  BA1, %table:BBU%  BBU
	WHERE BA1_CODINT = %Exp:cCodInt%
	  AND BA1_CODEMP = %Exp:cCodEmp%
	  AND BA1_MATRIC = %Exp:cMatric%
	  AND BA1_TIPUSU = %Exp:cTipUsu%
	  AND BA1_TIPREG = %Exp:cTipReg%
	  AND BBU_CODOPE = BA1_CODINT
	  AND BBU_CODEMP = BA1_CODEMP
	  AND BBU_MATRIC = BA1_MATRIC
	  AND ( ( BA1_MUDFAI = 0 and BA1_FAICOB = BBU_CODFAI ) or ( BA1_MUDFAI <> 0 and IDADE_S(BA1_DATNAS) >= BBU_IDAINI AND IDADE_S(BA1_DATNAS) <= BBU_IDAFIN  ))             
	  AND BA1.D_E_L_E_T_ = ' '
	  AND BBU.D_E_L_E_T_ = ' '
	  AND BA1_FILIAL = ' '
	  AND BBU_FILIAL = ' '
	UNION ALL
	SELECT 'COBRANCA RETROATIVA' X1,BA1_COBRET X2
	FROM  %table:BA1% 
	WHERE BA1_CODINT = %Exp:cCodInt%
	  AND BA1_CODEMP = %Exp:cCodEmp%
	  AND BA1_MATRIC = %Exp:cMatric%
	  AND BA1_TIPUSU = %Exp:cTipUsu%
	  AND BA1_TIPREG = %Exp:cTipReg%
	  AND D_E_L_E_T_ = ' '
	  AND BA1_FILIAL = ' '
	UNION ALL
	SELECT 'TAXA DE ADESÃO' X1, BRX_CODFAI||' - R$ '||
                              Trim(to_char(BRX_VLRADE, '999,999.99'))||' - '||
                              'IDADE DE '||BRX_IDAINI||' ATE '||BRX_IDAFIN  X2
	FROM   %table:BA1%   BA1,  %table:BRX1%  BRX,  %table:BA3%  BA3
	WHERE BA1_CODINT = %Exp:cCodInt%
	  AND BA1_CODEMP = %Exp:cCodEmp%
	  AND BA1_MATRIC = %Exp:cMatric%
	  AND BA1_TIPUSU = %Exp:cTipUsu%
	  AND BA1_TIPREG = %Exp:cTipReg%

      AND BA3_CODINT = BA1_CODINT  
      AND BA3_CODEMP = BA1_CODEMP
      AND BA3_MATRIC = BA1_MATRIC
      AND BA3_CONEMP = BA1_CONEMP
      AND BA3_VERCON = BA1_VERCON
      AND BA3_SUBCON = BA1_SUBCON
      AND BA3_VERSUB = BA1_VERSUB

      AND BRX_CODOPE = BA1_CODINT 
      AND BRX_CODEMP = BA1_CODEMP 
      AND BRX_MATRIC = BA1_MATRIC
      
	  AND BA1.D_E_L_E_T_ = ' '
	  AND BRX.D_E_L_E_T_ = ' '
	  AND BA3.D_E_L_E_T_ = ' '
	  AND BA1_FILIAL = ' '
	  AND BRX_FILIAL = ' '
      AND BA3_FILIAL = ' '
	UNION ALL             
	SELECT 'DESCONTO DE MENSALIDADE' X1,BDQ_CODFAI||' - '||
                                      Trim(CASE WHEN BDQ_PERCEN = 0 THEN 'R$' ELSE '%' END)||' '||Trim(CASE WHEN BDQ_PERCEN = 0 THEN BDQ_VALOR ELSE BDQ_PERCEN END)||' - '||
                                      'DE '||SubStr(BDQ_DATDE,7,2)||'/'||SubStr(BDQ_DATDE,5,2)||'/'||SubStr(BDQ_DATDE,1,4)||' '||
                                      'ATE '||SubStr(BDQ_DATATE,7,2)||'/'||SubStr(BDQ_DATATE,5,2)||'/'||SubStr(BDQ_DATATE,1,4)  X2
	FROM  %table:BA1%  BA1, %table:BDQ% BDQ
	WHERE BA1_CODINT = %Exp:cCodInt%
	  AND BA1_CODEMP = %Exp:cCodEmp%
	  AND BA1_MATRIC = %Exp:cMatric%
	  AND BA1_TIPUSU = %Exp:cTipUsu%
	  AND BA1_TIPREG = %Exp:cTipReg%
      AND BDQ_CODINT = BA1_CODINT
      AND BDQ_CODEMP = BA1_CODEMP
      AND BDQ_MATRIC = BA1_MATRIC
      AND BDQ_TIPREG = BA1_TIPREG
      AND BDQ_TIPUSR = BA1_TIPUSU
	  AND BA1.D_E_L_E_T_ = ' '
      AND BDQ.D_E_L_E_T_ = ' '
	  AND BA1_FILIAL = ' '
      AND BDQ_FILIAL = ' '
	UNION ALL             
	SELECT 'USUARIO' X1,' ' X2
	FROM  DUAL
	UNION ALL
	SELECT 'VIDA - NOME' X1, BA1_MATVID ||' - '|| BTS_NOMUSR X2
	FROM  %table:BA1%  BA1, %table:BTS%  BTS
	WHERE BA1_MATVID = BTS_MATVID
	  AND BA1_CODINT = %Exp:cCodInt%
	  AND BA1_CODEMP = %Exp:cCodEmp%
	  AND BA1_MATRIC = %Exp:cMatric%
	  AND BA1_TIPUSU = %Exp:cTipUsu%
	  AND BA1_TIPREG = %Exp:cTipReg%
	  AND BA1.D_E_L_E_T_ = ' '
	  AND BTS.D_E_L_E_T_ = ' '
	  AND BA1_FILIAL = ' '
	  AND BTS_FILIAL = ' '
	UNION ALL
	SELECT 'CPF' X1, BTS_CPFUSR X2
	FROM  %table:BA1%  BA1, %table:BTS%  BTS
	WHERE BA1_MATVID = BTS_MATVID
	  AND BA1_CODINT = %Exp:cCodInt%
	  AND BA1_CODEMP = %Exp:cCodEmp%
	  AND BA1_MATRIC = %Exp:cMatric%
	  AND BA1_TIPUSU = %Exp:cTipUsu%
	  AND BA1_TIPREG = %Exp:cTipReg%
	  AND BA1.D_E_L_E_T_ = ' '
	  AND BTS.D_E_L_E_T_ = ' '
	  AND BA1_FILIAL = ' '
	  AND BTS_FILIAL = ' '
	UNION ALL
	SELECT 'SEXO - DATA NASCIMENTO - IDADE' X1, Upper(Decode(BA1_SEXO,'2','FEMININO','MASCULINO' ))||' - ' ||
	                                    SubStr(BA1_DATNAS,7,2)||'/'||SubStr(BA1_DATNAS,5,2)||'/'||SubStr(BA1_DATNAS,1,4) ||' - ' ||
	                                    IDADE_S(BA1_DATNAS)  X2
	FROM  %table:BA1%  BA1, %table:BTS%  BTS
	WHERE BA1_MATVID = BTS_MATVID
	  AND BA1_CODINT = %Exp:cCodInt%
	  AND BA1_CODEMP = %Exp:cCodEmp%
	  AND BA1_MATRIC = %Exp:cMatric%
	  AND BA1_TIPUSU = %Exp:cTipUsu%
	  AND BA1_TIPREG = %Exp:cTipReg%
	  AND BA1.D_E_L_E_T_ = ' '
	  AND BTS.D_E_L_E_T_ = ' '
	  AND BA1_FILIAL = ' '
	  AND BTS_FILIAL = ' '
	UNION ALL
	SELECT 'NOME DA MAE' X1, Trim(BTS_MAE) X2
	FROM  %table:BA1%  BA1, %table:BTS%  BTS
	WHERE BA1_MATVID = BTS_MATVID
	  AND BA1_CODINT = %Exp:cCodInt%
	  AND BA1_CODEMP = %Exp:cCodEmp%
	  AND BA1_MATRIC = %Exp:cMatric%
	  AND BA1_TIPUSU = %Exp:cTipUsu%
	  AND BA1_TIPREG = %Exp:cTipReg%
	  AND BA1.D_E_L_E_T_ = ' '
	  AND BTS.D_E_L_E_T_ = ' '
	  AND BA1_FILIAL = ' '
	  AND BTS_FILIAL = ' '
	UNION ALL
	SELECT 'TP USUÁRIO-EST.CIVIL-GRAU PARENTE' X1, BA1_TIPUSU||'-'||Decode(BA1_TIPUSU,'T','TITULAR','D','DEPENDENTE','A','AGREGADO','OUTROS')||' - '||
	                                               BTS_ESTCIV||'-'||Trim(Upper((SELECT X5_DESCRI FROM SIGA.SX5010 WHERE D_E_L_E_T_ = ' '  AND X5_TABELA = '33' AND X5_CHAVE = BTS_ESTCIV )))||' - '||
	                                               BA1_GRAUPA||'-'||Trim(Upper((SELECT BRP_DESCRI FROM BRP010 WHERE D_E_L_E_T_ = ' ' AND BRP_CODIGO = BA1_GRAUPA))) X2
	FROM  %table:BA1%  BA1, %table:BTS%  BTS
	WHERE BA1_MATVID = BTS_MATVID
	  AND BA1_CODINT = %Exp:cCodInt%
	  AND BA1_CODEMP = %Exp:cCodEmp%
	  AND BA1_MATRIC = %Exp:cMatric%
	  AND BA1_TIPUSU = %Exp:cTipUsu%
	  AND BA1_TIPREG = %Exp:cTipReg%
	  AND BA1.D_E_L_E_T_ = ' '
	  AND BTS.D_E_L_E_T_ = ' '
	  AND BA1_FILIAL = ' '
	  AND BTS_FILIAL = ' '
	UNION ALL
	SELECT 'ENDERECO' X1, Trim(BTS_ENDERE)||', '||BTS_NR_END||' '||Trim(BTS_COMEND) X2
	FROM  %table:BA1%  BA1, %table:BTS%  BTS
	WHERE BA1_MATVID = BTS_MATVID
	  AND BA1_CODINT = %Exp:cCodInt%
	  AND BA1_CODEMP = %Exp:cCodEmp%
	  AND BA1_MATRIC = %Exp:cMatric%
	  AND BA1_TIPUSU = %Exp:cTipUsu%
	  AND BA1_TIPREG = %Exp:cTipReg%
	  AND BA1.D_E_L_E_T_ = ' '
	  AND BTS.D_E_L_E_T_ = ' '
	  AND BA1_FILIAL = ' '
	  AND BTS_FILIAL = ' '
	UNION ALL
	SELECT 'BAIRRO-MUNICIPIO-ESTADO-CEP' X1, Trim(BTS_BAIRRO)||' - '||Trim(BTS_MUNICI)||' - '||Trim(BTS_ESTADO)||' - '||Trim(BTS_CEPUSR) X2
	FROM  %table:BA1%  BA1, %table:BTS%  BTS
	WHERE BA1_MATVID = BTS_MATVID
	  AND BA1_CODINT = %Exp:cCodInt%
	  AND BA1_CODEMP = %Exp:cCodEmp%
	  AND BA1_MATRIC = %Exp:cMatric%
	  AND BA1_TIPUSU = %Exp:cTipUsu%
	  AND BA1_TIPREG = %Exp:cTipReg%
	  AND BA1.D_E_L_E_T_ = ' '
	  AND BTS.D_E_L_E_T_ = ' '
	  AND BA1_FILIAL = ' '
	  AND BTS_FILIAL = ' '
	UNION ALL
	SELECT 'DDD TELEFONE CELULAR' X1, Trim(BTS_DDD)||' - '||Trim(BA1_TELEFO)||' - '||Trim(BA1_YCEL) X2
	FROM  %table:BA1%  BA1, %table:BTS%  BTS
	WHERE BA1_MATVID = BTS_MATVID
	  AND BA1_CODINT = %Exp:cCodInt%
	  AND BA1_CODEMP = %Exp:cCodEmp%
	  AND BA1_MATRIC = %Exp:cMatric%
	  AND BA1_TIPUSU = %Exp:cTipUsu%
	  AND BA1_TIPREG = %Exp:cTipReg%
	  AND BA1.D_E_L_E_T_ = ' '
	  AND BTS.D_E_L_E_T_ = ' '
	  AND BA1_FILIAL = ' '
	  AND BTS_FILIAL = ' '
	UNION ALL
	SELECT 'DATA INCLUSAO' X1, SubStr(BA1_DATINC,7,2)||'/'||SubStr(BA1_DATINC,5,2)||'/'||SubStr(BA1_DATINC,1,4) X2
	FROM  %table:BA1%  BA1, %table:BTS%  BTS
	WHERE BA1_MATVID = BTS_MATVID
	  AND BA1_CODINT = %Exp:cCodInt%
	  AND BA1_CODEMP = %Exp:cCodEmp%
	  AND BA1_MATRIC = %Exp:cMatric%
	  AND BA1_TIPUSU = %Exp:cTipUsu%
	  AND BA1_TIPREG = %Exp:cTipReg%
	  AND BA1.D_E_L_E_T_ = ' '
	  AND BTS.D_E_L_E_T_ = ' '
	  AND BA1_FILIAL = ' '
	  AND BTS_FILIAL = ' '
	UNION ALL
	SELECT 'DATA CARENCIA' X1, SubStr(BA1_DATCAR,7,2)||'/'||SubStr(BA1_DATCAR,5,2)||'/'||SubStr(BA1_DATCAR,1,4) X2
	FROM  %table:BA1%  BA1, %table:BTS%  BTS
	WHERE BA1_MATVID = BTS_MATVID
	  AND BA1_CODINT = %Exp:cCodInt%
	  AND BA1_CODEMP = %Exp:cCodEmp%
	  AND BA1_MATRIC = %Exp:cMatric%
	  AND BA1_TIPUSU = %Exp:cTipUsu%
	  AND BA1_TIPREG = %Exp:cTipReg%
	  AND BA1.D_E_L_E_T_ = ' '
	  AND BTS.D_E_L_E_T_ = ' '
	  AND BA1_FILIAL = ' '
	  AND BTS_FILIAL = ' '
	UNION ALL
	SELECT 'CODIGO DESCRICAO PLANO' X1, Trim(BA1_CODPLA)||' - '||Trim(BI3_DESCRI) X2
	FROM  %table:BA1%  BA1, %table:BI3%  BI3
	WHERE BI3_CODINT = BA1_CODINT
	  AND BI3_CODIGO = BA1_CODPLA
	  AND BI3_VERSAO = BA1_VERSAO
	  AND BA1_CODINT = %Exp:cCodInt%
	  AND BA1_CODEMP = %Exp:cCodEmp%
	  AND BA1_MATRIC = %Exp:cMatric%
	  AND BA1_TIPUSU = %Exp:cTipUsu%
	  AND BA1_TIPREG = %Exp:cTipReg%
	  AND BA1.D_E_L_E_T_ = ' '
	  AND BI3.D_E_L_E_T_ = ' '
	  AND BA1_FILIAL = ' '
	  AND BI3_FILIAL = ' '
	UNION ALL
	SELECT 'DATA LIMITE' X1,SubStr(BA1_YDTLIM,7,2)||'/'||SubStr(BA1_YDTLIM,5,2)||'/'||SubStr(BA1_YDTLIM,1,4) X2
	FROM  %table:BA1%  
	WHERE BA1_CODINT = %Exp:cCodInt%
	  AND BA1_CODEMP = %Exp:cCodEmp%
	  AND BA1_MATRIC = %Exp:cMatric%
	  AND BA1_TIPUSU = %Exp:cTipUsu%
	  AND BA1_TIPREG = %Exp:cTipReg%
	  AND D_E_L_E_T_ = ' '
	  AND BA1_FILIAL = ' '
	UNION ALL
	SELECT 'OPERADOR ORIGEM' X1,BA1_OPEORI X2
	FROM  %table:BA1%  
	WHERE BA1_CODINT = %Exp:cCodInt%
	  AND BA1_CODEMP = %Exp:cCodEmp%
	  AND BA1_MATRIC = %Exp:cMatric%
	  AND BA1_TIPUSU = %Exp:cTipUsu%
	  AND BA1_TIPREG = %Exp:cTipReg%
	  AND D_E_L_E_T_ = ' '
	  AND BA1_FILIAL = ' '
	UNION ALL
	SELECT 'OPERADOR DESTINO' X1,BA1_OPEDES X2
	FROM  %table:BA1%  
	WHERE BA1_CODINT = %Exp:cCodInt%
	  AND BA1_CODEMP = %Exp:cCodEmp%
	  AND BA1_MATRIC = %Exp:cMatric%
	  AND BA1_TIPUSU = %Exp:cTipUsu%
	  AND BA1_TIPREG = %Exp:cTipReg%
	  AND D_E_L_E_T_ = ' '
	  AND BA1_FILIAL = ' '
	UNION ALL
	SELECT 'OPCIONAIS' X1,' ' X2
	FROM  DUAL
	UNION ALL
	SELECT 'OPCIONAL USUARIO' X1,SubStr(BF4_DATBAS,7,2)||'/'||SubStr(BF4_DATBAS,5,2)||'/'||SubStr(BF4_DATBAS,1,4)||' - '||
	                             BF4_CODPRO||' / '||BI3_NREDUZ X2
	FROM  %table:BA1%   BA1, %table:BF4%   BF4, %table:BI3%   BI3
	WHERE BA1_CODINT = %Exp:cCodInt%
	  AND BA1_CODEMP = %Exp:cCodEmp%
	  AND BA1_MATRIC = %Exp:cMatric%
	  AND BA1_TIPUSU = %Exp:cTipUsu%
	  AND BA1_TIPREG = %Exp:cTipReg%
	  AND BF4_CODINT = BA1_CODINT
	  AND BF4_CODEMP = BA1_CODEMP
	  AND BF4_MATRIC = BA1_MATRIC
	  AND BF4_TIPREG = BA1_TIPREG
	  AND BI3_CODINT = BF4_CODINT
      AND BI3_CODIGO = BF4_CODPRO
      AND BI3_VERSAO = BF4_VERSAO
	  AND BA1.D_E_L_E_T_ = ' '
	  AND BF4.D_E_L_E_T_ = ' '
	  AND BI3.D_E_L_E_T_ = ' '
	  AND BA1_FILIAL = ' '
	  AND BF4_FILIAL = ' '
	  AND BI3_FILIAL = ' '
	UNION ALL
	SELECT 'VALOR OPCIONAL' X1,Trim(to_char(BZX_VALFAI, '9,999.99') )  X2
	FROM  %table:BZX%   BZX, %table:BA1%   BA1
	WHERE BA1_CODINT = %Exp:cCodInt%
	  AND BA1_CODEMP = %Exp:cCodEmp%
	  AND BA1_MATRIC = %Exp:cMatric%
	  AND BA1_TIPUSU = %Exp:cTipUsu%
	  AND BA1_TIPREG = %Exp:cTipReg%
	  AND BZX_CODOPE = BA1_CODINT
	  AND BZX_CODEMP = BA1_CODEMP
	  AND BZX_MATRIC = BA1_MATRIC
	  AND BZX_TIPREG = BA1_TIPREG
	  AND BZX_CODOPC = BA1_CODPLA
	  AND BZX_VEROPC = BA1_VERSAO
	  AND BZX_CODFOR = BA1_CODFOR
	  AND BZX_CODFAI = BA1_CODFAI
	  AND BZX.D_E_L_E_T_ = ' '
	  AND BA1.D_E_L_E_T_ = ' '
	  AND BA1_FILIAL = ' '
	  AND BZX_FILIAL = ' '
	UNION ALL
	SELECT 'SITUACOES ADVERSAS' X1,' ' X2
	FROM  DUAL
	UNION ALL
	SELECT 'CODIGO / DESCRICAO' X1,BHH_CODSAD||' / '||Trim(BGX_DESCRI)||CASE WHEN BGX_OBS1 <> ' ' THEN ' -> '||Trim(BGX_OBS1) ELSE ' ' END X2
	FROM  %table:BA1%   BA1, %table:BHH%   BHH, %table:BGX%   BGX
	WHERE BA1_CODINT = %Exp:cCodInt%
	  AND BA1_CODEMP = %Exp:cCodEmp%
	  AND BA1_MATRIC = %Exp:cMatric%
	  AND BA1_TIPREG = %Exp:cTipReg%
      AND BHH_CODINT = BA1_CODINT
	  AND BHH_CODEMP = BA1_CODEMP
	  AND BHH_MATRIC = BA1_MATRIC
	  AND BHH_TIPREG = BA1_TIPREG
      AND BGX_CODINT = BHH_CODINT
      AND BGX_CODSAD = BHH_CODSAD
      AND BHH.D_E_L_E_T_ = ' '
	  AND BA1.D_E_L_E_T_ = ' '
      AND BGX.D_E_L_E_T_ = ' '
	  AND BHH_FILIAL = ' '
	  AND BA1_FILIAL = ' '
      AND BGX_FILIAL = ' '
	 
	EndSql
	
	dbSelectArea("CAPA")
	
	CAPA->( dbGoTop() )  

    aCAPA := {}
    while CAPA->( !EOF() )
       aADD( aCAPA,{CAPA->X1, CAPA->X2} )             
       CAPA->( dbSkip() )
	enddo
    
	ProcRegua( CAPA->( LastRec() ) )
		
	for x := 1 to len(aCAPA)
	   IncProc()
	   if lEnd
	      Impr( "Cancelada pelo operador",'C') // Ctrl+A Cancela a impressao
	      exit
	   endif 
	  
	   N := 0          
	    
	   *-------------------------------------------------------------------------------------------
	   * Corpo do relatório
	   *
	   * Ex: DESCRICAO SUBCONTRATO MATER (PENSIONISTAS)
	   *
	   *-------------------------------------------------------------------------------------------   
	   Q_PAG() 
	
	   if AllTrim( aCAPA[x][1] ) $ 'COBRANCA,USUARIO,OPCIONAIS,SITUACOES ADVERSAS'
	      nLin += nTLin
	      oPrint:Line(nLin, _nCol1, nLin ,nColMax)
	   endif
	
	   if AllTrim( aCAPA[x][1] ) $ 'FAMILIA,COBRANCA,USUARIO,OPCIONAIS,SITUACOES ADVERSAS'
	      aCoords1 := {nLin+5,_nCol1,nLin+40,nColMax}
	      oPrint:FillRect(aCoords1, oBrush )  
	   endIf
	
	   oPrint:say (nLin, _nCol1, OemToAnsi(aCAPA[x][1]), oFont11T)
	   oPrint:say (nLin, _nCol2, OemToAnsi(aCAPA[x][2]), oFont11T)
	   nLin += nTLin
	   
	   if AllTrim( aCAPA[x][1] ) $ 'FAMILIA,COBRANCA,USUARIO,OPCIONAIS,SITUACOES ADVERSAS'
	      oPrint:Line(nLin, _nCol1, nLin ,nColMax)
	      nLin += nTLin
	   endif                          
	   lRet := .T.
       
	next
	// Final de impressao         
	nLin += nTLin
	oPrint:Line(nLin, _nCol1, nLin ,nColMax)
	nLin += nTLin
	oPrint:say (nLin, _nCol1, OemToAnsi( "Usuário: "+AllTrim( SubStr(cUsuario,7,15) ) ) + "   em " + DtoC(dDataBase) , oFont11T) 


    nLin := nLinMax
    BA1TMP->( dbSkip() )
enddo

/*-------------------------------------------------------------------------
| Bloco de codigo destinado a alterar de SIM para NAO se o doc foi gerado. |                                              | 
 -------------------------------------------------------------------------*/
if lRet     
   BA1->( dbSetOrder(1) ) //BA1_FILIAL + BA1_CODINT + BA1_CODEMP + BA1_MATRIC + BA1_TIPUSU + BA1_TIPREG + BA1_DIGITO
   for x := 1 to Len(aChave)         
      if BA1->( dbSeek( aChave[x][1] ) )
         BA1->( Reclock("BA1",.F.) )         
         BA1->BA1_YIMPCA := '0'                           
         BA1->( MsUnlock() )
      endif 
   next
endif

BA1TMP->( dbCloseArea() )

if SELECT("CAPA") > 0 ; CAPA->( dbCloseArea() ) ; endif	
//Imprime em Video e finaliza a impressao.
oPrint:Preview()
oPrint:End()
SetPgEject(.F.)
Ms_Flush()

return  lRet

static function Q_Pag()
if nLin >= nLinMax .or. primeiro
	oPrint:EndPage()
	oPrint:StartPage()
	nPag++
	
	nLin := nTLin
	oPrint:say (nLin, _nCol1, if (SM0->M0_CODIGO='01','CABERJ','INTEGRAL'), oFont12T)
	nLin += nTLin
	oPrint:say (nLin, _nCol1, 'Data Ref.: ' + dtoc(DATE())  , oFont09T)	
    oPrint:say (nLin, nColMax-235, OemToAnsi("Emissão: ") + dtoc(date()), oFont09T)
    nLin += nTLin
    oPrint:say (nLin, _nCol1, OemToAnsi('Prog: CABR078'), oFont09T)
    oPrint:say (nLin, 0800, OemToAnsi(cTitulo), oFont18C)
	oPrint:say (nLin, nColMax-180, OemToAnsi("Página:     ") + strzero(nPag,3), oFont09T)
	nLin += ( nTLin + 20 )
	oPrint:Line(nLin, _nCol1, nLin, nColMax)
	nLin += nTLin
	cabecalho()
	nLin += nTLin
	oPrint:Line(nLin, _nCol1, nLin ,nColMax)
	*nLin += nTLin
	*oPrint:say (nlin, _nCol1, AllTrim(SA5->A5_FORNECE) + ' - ' + AllTrim(SA5->A5_NOMEFOR) +;
	*            ' - ' + 'Tel.: ' + SA2->A2_TEL, oFont09T)
    primeiro := .f.
endIf
return

static function Cabecalho()
oPrint:say (nlin, _nCol1, 'DADOS'          , oFont10T)
oPrint:say (nlin, _nCol2, 'CONTEUDO'       , oFont10T)
//                       CONTRATO                                  00000000001
//                       XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX  XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX 
// --AND idade_xxx ( BA1_DATNAS ) >= BDK_IDAINI AND idade_xxx ( BA1_DATNAS ) <= BDK_IDAFIN
return
