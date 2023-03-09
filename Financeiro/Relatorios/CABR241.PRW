#INCLUDE "rwmake.ch"                                                                                                                               
#INCLUDE "topconn.ch"                                                                                                                 
#Define CRLF Chr(13)+Chr(10)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ CABR240  บ Autor ณ Altamiro Affonso   บ Data ณ  12/09/17   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Conferencia de antecipa็ใo do convenio                     บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP6 IDE                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
User Function CABR241( cMesBase1 , cAnoBase1 , cNumTit1 , cOpeInc1 , nTpRel1, lFecham )

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Declaracao de Variaveis                                             ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

Local cDesc1         := "Este programa tem como objetivo imprimir relatorio "
Local cDesc2         := "de conferencia de antecipa็ใo de convenio de reciprocidad "
Local cDesc3         := " "
Local nLin           := 88 	                                                              
LOCAL cCabec1        := "                                                                                   ---------------- Guias --------------    --------------------- Antecipa็ใo ----------------------"
LOCAL cCabec2        := "Red Tp  Num Fat   Cod Emp  Loc Dig  Cod Peg   Numero    Sequen  Fase   Cobrado     Vlr pago   %       Vlr Tx   Vlr Total    Vlr pago    Vlr Base    Vlr Taxa     Vlr Tot    Vlr Inss     Status               Diferen็a "
  //                     123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
  //                                1         2         3         4         5         6         7         8         9         10        11        12        13        14        15        16        17        18        19        20        21        22
Local aOrd           := {} 
local   titulo       := "Rel de Anal de Dif / Conf  de antecip de Conv Recipr"

Private lEnd         := .F.
private lFechamen    := lFecham
Private lAbortPrint  := .F.
Private limite       := 220
Private tamanho      := "G"
Private nomeprog     := "CABR241"
Private nTipo        := 15
Private aReturn      := { "Zebrado", 1, "Administracao", 1, 2, 1, "", 1}
Private nLastKey     := 0
Private cbtxt        := Space(10)
Private cbcont       := 00
Private CONTFL       := 01
Private m_pag        := 01
Private wnrel        := "CABR241"
Private cString      := "SE2"
Private cPerg        := "CABR241"
Private vlr_tot      := 0.00  
Private vlr_Sald     := 0.00                                                                      
Private cquebra      := " " 
Private lflagtot     :=.F.
private cNovGrpPag   := " "    
private cAliasCT     := GetNextAlias()  

    Private cMesBase     := ' '  
    Private cAnoBase     := ' ' 
    Private cNumTit      := ' '  
    Private cOpeInc      := ' '
    Private nTprel       := 0 
                            

    private VlrApr_bt  := 0
    private VlrTx_bt   := 0
    private VlrTpf_bt  := 0
    private VLRPAG_pt  := 0
    private VLRBPF_pt  := 0
    private VLRTAD_pt  := 0
    private VLRTPF_pt  := 0
    private VLRINS_pt  := 0 
    private Dift       := 0
           


private _nTotUsrValor := 0
Private _nTotUsrTaxa  := 0
Private _nTotUsrINSS  := 0
												
Private _nTotValor := 0
Private _nTotTaxa  := 0
Private _nTotINSS  := 0   

private cOpe       := ' ' 
private cTit       := ' ' 

private cOpeori    := ''         
  

//cMesBase1 , cAnoBase1 , cNumTit1 , cOpeInc1 , nTpRel1 
private mv_par01 := cMesBase1 
private mv_par02 := cAnoBase1
private mv_par03 := cNumTit1 
private mv_par04 := cOpeInc1
private mv_par05 := nTpRel1        
				
dbSelectArea("SE2")
dbSetOrder(1)                   

 If empty(cMesBase1)

    ValidPerg()
    If Pergunte(cPerg,.T.) = .F.
	   Return
    Endif
                                
    cMesBase     := mv_par01 
    cAnoBase     := mv_par02
    cNumTit      := mv_par03 
    cOpeInc      := mv_par04
    nTprel       := mv_par05                                    
  //  nTprel       := 2  
Else
     
    cMesBase     := cMesBase1 
    cAnoBase     := cAnoBase1
    cNumTit      := cNumTit1 
    cOpeInc      := cOpeInc1
    nTprel       := nTpRel1        
                           
    If nTprel   == 2 
       If MsgYesNo("Listar Somente Divergencia de Valor ?","Aten็ใo")
           nTprel       := 3
       EndIf       
    EndIf

   mv_par01 :=  cMesBase  
   mv_par02 :=  cAnoBase
   mv_par03 :=  cNumTit      
   mv_par04 :=  cOpeInc      
   mv_par05 :=  nTprel                                          
    
EndIf 
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Monta a interface padrao com o usuario...                           ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู


If nTprel == 1
   titulo         := "Relat๓rio de Conferencia de antecipa็ใo de Conv๊nios Reciprocidade"
Else                                                                                                
   titulo         := "Relat๓rio de Analise de Difergencia de antecipa็ใo de Conv๊nios Reciprocidade"
EndIf                                          

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

RptStatus({|| RunReport(cCabec1,cCabec2, nomeprog,Titulo,nLin) },Titulo)
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

Static Function RunReport(cCabec1,cCabec2, nomeprog ,Titulo,nLin)

Local cQuery := ' ' 

dbSelectArea(cString)
dbSetOrder(1)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ SETREGUA -> Indica quantos registros serao processados para a regua ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู


//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Busca a movimentacao da operadora por usuarios... somente analiticoณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู	 
        
 
cQuery := "SELECT NVL(trim(BD6F.opeori),'0000 - ') opeori_bd6 , " + CRLF  
cQuery += "       trim(pcsopeori) opeori_pcs ,                  " + CRLF  
cQuery += "       nvl(BD6F.ClsRd, ' ' )  ClsRd ,                " + CRLF  
cQuery += "       nvl(BD6F.Tippe,' ')  Tippe ,                  " + CRLF  
cQuery += "       NVL( BD6f.Vlrpag   ,0.00) VlrAprov_bd6   ,    " + CRLF  
cQuery += "       NVL( BD6F.PRECTX   ,0.00) PRECTX_bd6   ,      " + CRLF  
cQuery += "       NVL( BD6F.Vlrtad   ,0.00) VlrTx_bd6    ,      " + CRLF  
cQuery += "       NVL( BD6F.VlrTpf   ,0.00) VlrTpf_bd6   ,      " + CRLF  
cQuery += "       nvl(trim(pcsCODEMP),'')  codemp_pcs   ,       " + CRLF  
cQuery += "       nvl(trim(pcsCODLDP),'')  codldp_pcs   ,       " + CRLF  
cQuery += "       nvl(trim(pcsCODPEG),'')  codpeg_pcs   ,       " + CRLF  
cQuery += "       nvl(trim(pcsNUMERO),'')  numero_pcs   ,       " + CRLF  
cQuery += "       nvl(trim(pcsSEQUEN),'')  sequen_pcs   ,       " + CRLF  
cQuery += "       nvl(PCSVLRPAG,0.00) VLRPAG_pcs  ,             " + CRLF  
cQuery += "       nvl(PCSVLRBPF,0.00) VLRBPF_pcs  ,             " + CRLF  
cQuery += "       nvl(PCSVLRTAD,0.00) VLRTAD_pcs  ,             " + CRLF  
cQuery += "       nvl(PCSVLRTPF,0.00) VLRTPF_pcs  ,             " + CRLF  
cQuery += "       nvl(PCSVLRINS,0.00) VLRINS_pcs  ,             " + CRLF  
cQuery += "       nvl(PCSTIT,' ') TIT_pcs      ,                " + CRLF  
cQuery += "       nvl(PCSCLIEN,' ') CLIEN_pcs  ,                " + CRLF  
cQuery += "       nvl(PCSCOMP,' ') COMP_pcs    ,                " + CRLF  
cQuery += "       NVL(BD6F.NUMFAT,'            ') NUMFAT ,      " + CRLF  
cQuery += "       NVL(BD6F.fase, ' - - - ') FASE ,              " + CRLF  
cQuery += "       decode(NVL(trim(BD6F.NUMFAT),''),'','Nใo Cob' ,'Cobrada') St_fat , " + CRLF     

cQuery += "      Recnopcs RecnoPcs ,              " + CRLF  

cQuery += "  CASE WHEN Trim(pcsCODPEG)      = ' '                  THEN 'Nใo Cobr. Antec' " + CRLF  
cQuery += "       WHEN trim(nvl(bd6f.Delet,'*')) = '*'             THEN 'Delet. PLS'      " + CRLF  
cQuery += "       WHEN nvl(bd6f.CODPEG,' ')      = ' '             THEN 'Nใo Exist PLS'   " + CRLF  
cQuery += "       WHEN trim(nvl(BD6F.BLOCPA,'1'))= '1'             THEN 'G. Bloq Cob'     " + CRLF  
cQuery += "       WHEN trim(nvl(BD6F.SITUAC,'0'))<> '1'            THEN 'G. Nใo Ativa'    " + CRLF  
cQuery += "       WHEN SUBSTR(trim(nvl(BD6F.fase,'1')),1,1) < '3'  THEN 'G. Fase 1 ou 2'  " + CRLF  
cQuery += "       WHEN trim(nvl(BD6F.fase,'1'))  <> '4-Fat'        THEN 'G. Nใo Paga'     " + CRLF  
cQuery += "       WHEN NVL(BD6F.NUMFAT,'            ') = '            ' THEN 'G. Nใo Cobrd'    " + CRLF  
cQuery += "       WHEN PCSVLRTPF     <>  nvl(BD6f.VLRTPF,0.00)     THEN 'Div Vlr Cobrd'   " + CRLF  
cQuery += "       WHEN PCSVLRBPF     <>  nvl(BD6f.VLRBPF,0.00)     THEN 'Div Vlr Pagto'   " + CRLF  
cQuery += "       WHEN PCSVLRTAD     <>  nvl(BD6f.VLRTAD,0.00)     THEN 'Div Vlr Taxa'    " + CRLF  
cQuery += "       Else 'Ok' END  statuspeg  , " + CRLF  
cQuery += "        (nvl(BD6f.VLRTPF,0.00) - PCSVLRTPF)    Dif " + CRLF  
cQuery += "  FROM ( SELECT /*+FIRST_ROWS INDEX_ASC(BD7 BD70105)*/ " + CRLF  
cQuery += "                distinct BD6F.r_e_c_n_o_ recbd6 , " + CRLF  
cQuery += "                bd6F.r_e_c_n_o_ ,  pcs_RECBD6  ,  " + CRLF  
cQuery += "                BD6_NUMFAT NUMFAT,  BD6_NUMLOT ,  " + CRLF  
cQuery += "                trim(BD6F.BD6_ANOPAG)||'/'|| trim(BD6F.BD6_MESPAG) AnoMes , " + CRLF  
cQuery += "                nvl(OPE.OPEORI,'0000') ||' - '|| nvl(OPE.NOMOPE, '')  OPEORI , " + CRLF  
cQuery += "                decode(trim(BD6F.BD6_FASE),'4','4-Fat','1','1-Dig','2','2-Conf','3', '3-Prt', 'N-Prt') fase , " + CRLF  
cQuery += "                trim(BD6F.BD6_CODEMP) codemp ," + CRLF  
cQuery += "                trim(BD6F.BD6_CODLDP) codldp ," + CRLF  
cQuery += "                trim(BD6F.BD6_CODPEG) codpeg ," + CRLF  
cQuery += "                trim(BD6F.BD6_NUMERO) numero ," + CRLF  
cQuery += "                trim(BD6F.BD6_ORIMOV) orimov ," + CRLF  
cQuery += "                trim(BD6F.BD6_SEQUEN) sequen ," + CRLF  
cQuery += "                trim(DECODE(BD6_CODLDP,'0010','RECUP GLOSA','0017','RATEIO','CONTA')) tipo , " + CRLF  
cQuery += "                BD6F.BD6_VLRBPF VLRPAG , " + CRLF  
cQuery += "                BD6F.BD6_PERTAD PRECTX ," + CRLF  
cQuery += "                BD6F.BD6_VLRTAD VLRTAD ," + CRLF  
cQuery += "                BD6F.BD6_VLRTPF VLRTPF ," + CRLF  
cQuery += "                BD6F.BD6_VLRBPF VLRBPF ," + CRLF  
cQuery += "                BD6F.BD6_DATPRO DatPro ," + CRLF  
cQuery += "                BAU.BAU_TIPPRE  ClsRd  ," + CRLF  
cQuery += "                BAU.BAU_codigo  CODRda ," + CRLF  
cQuery += "                BAU.BAU_tippe   Tippe  ," + CRLF  
cQuery += "                BD6F.D_e_l_e_t_ DELET  ," + CRLF  
cQuery += "                BD6F.BD6_BLOCPA BLOCPA,  BD6F.BD6_SITUAC SITUAC , " + CRLF  
cQuery += "                PCS_RECBD6 PCSRECBD6 , " + CRLF  
cQuery += "                trim(PCS_opeori) PCSopeori ," + CRLF  
cQuery += "                trim(PCS_CODEMP) PCScodemp ," + CRLF  
cQuery += "                trim(PCS_CODLDP) PCScodldp ," + CRLF  
cQuery += "                trim(PCS_CODPEG) PCScodpeg ," + CRLF  
cQuery += "                trim(PCS_NUMERO) PCSnumero ," + CRLF  
cQuery += "                trim(PCS_SEQUEN) PCSsequen ," + CRLF  
cQuery += "                pcs_numtit       PCSnumtit ," + CRLF  
cQuery += "                PCS_VLRPAG       PCSVLRPAG ," + CRLF  
cQuery += "                PCS_VLRBPF       PCSVLRBPF ," + CRLF  
cQuery += "                PCS_VLRTAD       PCSVLRTAD ," + CRLF  
cQuery += "                PCS_VLRTPF       PCSVLRTPF ," + CRLF  
cQuery += "                PCS_VLRINS       PCSVLRINS ," + CRLF  
cQuery += "                PCS_PREFIX ||' '||PCS_NUMTIT||' '||PCS_TIPO PCSTIT , " + CRLF  
cQuery += "                PCS_CLIENT ||' - '|| A1_NOME PCSCLIEN ," + CRLF  
cQuery += "                PCS_MESPAG ||'/'|| PCS_ANOPAG  PCSCOMP , " + CRLF  
cQuery += "                PCS.R_E_C_N_O_ RecnoPcs " + CRLF

cQuery += "           FROM " + CRLF  
cQuery += "                ( SELECT '10'||BGH_GRUOPE OPEORI , BA2_DESCRI NOMOPE ,  BGH_VLRTRC VLRCOB " + CRLF  
cQuery += "                    FROM "+RetSqlName('BGH')+ " BGH,"+RetSqlName('BA2')+ " BA2 " + CRLF
cQuery += "                   WHERE BA2_FILIAL = '"+xFilial("BA2")+"'  AND BA2.D_E_L_E_T_ = ' ' " + CRLF
cQuery += "                     AND BGH_FILIAL = '"+xFilial("BGH")+"'  AND BGH.D_E_L_E_T_ = ' ' " + CRLF
cQuery += "                     AND BGH_DATFIN = ' ' AND BA2_GRUOPE = BGH_GRUOPE ) OPE , " + CRLF  

cQuery += "               "+RetSqlName('PCS')+ " PCS  ,"+RetSqlName('SA1')+ " SA1 , " + CRLF
cQuery += "               "+RetSqlName('BD6')+ " BD6F ,"+RetSqlName('BAU')+ " BAU   " + CRLF

cQuery += "          WHERE BAU_FILIAL='"+xFilial("BAU")+"'  AND BAU.D_E_L_E_T_=' '  AND BAU.R_E_C_D_E_L_ = 0 " + CRLF  
cQuery += "            AND bau.bau_codigo = bd6f.bd6_codrda " + CRLF  
cQuery += "            AND BD6F.BD6_FILIAL='"+xFilial("BD6")+"'" + CRLF
cQuery += "            AND bd6F.r_e_c_n_o_(+) = pcs_RECBD6 " + CRLF  
cQuery += "            AND PCS_FILIAL = '"+xFilial("PCS")+"'  AND pcs.D_e_l_e_t_ =' ' " + CRLF  
cQuery += "            AND  A1_FILIAL = '"+xFilial("SA1")+"'  AND SA1.D_e_l_e_t_ =' ' " + CRLF   

cQuery += "            AND PCS_ANOPAG = '"+cAnoBase+"' " + CRLF
cQuery += "            AND PCS_MESPAG = '"+cMesBase+"' " + CRLF
cQuery += "            AND PCS_OPEORI = '"+cOpeInc +"' " + CRLF
cQuery += "            AND PCS_NUMTIT = '"+cNumTit +"' " + CRLF  

cQuery += "            AND PCS_CLIENT = A1_COD " + CRLF  
cQuery += "            AND PCS_OPEORI = OPE.OPEORI(+) " + CRLF  

If nTpRel == 2     

    cQuery += "       AND ( Trim(pcs_CODPEG)              = ' '                 " + CRLF
    cQuery += "        OR trim(bd6f.D_e_l_e_t_)           = '*'                 " + CRLF
    cQuery += "        OR nvl(bd6f.bd6_CODPEG,' ')        = ' '                 " + CRLF    
    cQuery += "        OR trim(BD6F.bd6_BLOCPA)           = '1'                 " + CRLF       
    cQuery += "        OR trim(BD6F.bd6_SITUAC)           <> '1'                " + CRLF 
    cQuery += "        OR trim(BD6F.bd6_fase)             <> '4'                " + CRLF 
    cQuery += "        OR NVL(BD6F.bd6_NUMFAT,'            ') = '            '  " + CRLF     
	cQuery += "        OR (nvl(BD6f.bd6_VLRTPF,0.00) <> PCS_VLRTPF) )" + CRLF           
ElseIf nTpRel == 3     
	cQuery += "        and (nvl(BD6f.bd6_VLRTPF,0.00) <> PCS_VLRTPF) " + CRLF          	
EndIf 

cQuery += "  ) BD6F " + CRLF         
cQuery += " ORDER BY 1, 4 " + CRLF   
   
            		                              
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Imprime a movimentacao...                                          ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู			        	            		
//Modificada logica para Caberj.
  
   If Select((cAliasCT)) <> 0 

      (cAliasCT)->(DbCloseArea()) 

   Endif           
                        
   TcQuery cQuery New Alias (cAliasCT)

   If nLin > 65 // Salto de Pแgina. Neste caso o formulario tem 55 linhas...
  
        nLin :=	Cabec(Titulo,cCabec1,cCabec2,NomeProg,Tamanho,nTipo)
        nLin ++         		
  
   EndIf        
  
   @ nLin, 000 PSAY 'Operadora   : '+(cAliasCT)->opeori_bd6      		
    nLin ++      
   @ nLin, 000 PSAY 'Titulo      : '+(cAliasCT)->TIT_pcs 
    nLin ++      
   @ nLin, 000 PSAY 'Cliente     : '+(cAliasCT)->CLIEN_pcs 
    nLin ++      
   @ nLin, 000 PSAY 'Competencia : '+(cAliasCT)->COMP_pcs  
    nLin ++
   @ nLin, 000 PSAY Replicate('-',220)                        
    
    nLin ++ 

  While !(cAliasCT)->( Eof() )   
               		 
           @ nLin, 000 PSAY trim((cAliasCT)->ClsRd)
           @ nLin, 005 PSAY trim((cAliasCT)->Tippe)     
           @ nLin, 009 PSAY substr((cAliasCT)->numfat,5,8)                                                                                                                                       
           @ nLin, 019 PSAY trim((cAliasCT)->codemp_pcs)
           @ nLin, 028 PSAY trim((cAliasCT)->codldp_pcs)
           @ nLin, 037 PSAY trim((cAliasCT)->codpeg_pcs)
           @ nLin, 046 PSAY trim((cAliasCT)->numero_pcs)
           @ nLin, 056 PSAY trim((cAliasCT)->sequen_pcs)       
           @ nLin, 064 PSAY trim((cAliasCT)->FASE)
           @ nLin, 071 PSAY trim((cAliasCT)->St_fat)
           @ nLin, 081 PSAY Transform((cAliasCT)->VlrAprov_bd6,"@E 9999,999.99")    
           VlrApr_bt += (cAliasCT)->VlrAprov_bd6
           @ nLin, 093 PSAY Transform((cAliasCT)->PRECTX_bd6  ,"@E 999")+'%'
           @ nLin, 098 PSAY Transform((cAliasCT)->VlrTx_bd6   ,"@E 9999,999.99") 
           VlrTx_bt  += (cAliasCT)->VlrTx_bd6
           @ nLin, 110 PSAY Transform((cAliasCT)->VlrTpf_bd6  ,"@E 9999,999.99")  
           VlrTpf_bt += (cAliasCT)->VlrTpf_bd6
                      
           @ nLin, 122 PSAY Transform((cAliasCT)->VLRPAG_pcs  ,"@E 9999,999.99")
           VLRPAG_pt += (cAliasCT)->VLRPAG_pcs
           @ nLin, 134 PSAY Transform((cAliasCT)->VLRBPF_pcs  ,"@E 9999,999.99")
           VLRBPF_pt += (cAliasCT)->VLRBPF_pcs
           @ nLin, 146 PSAY Transform((cAliasCT)->VLRTAD_pcs  ,"@E 9999,999.99") 
           VLRTAD_pt += (cAliasCT)->VLRTAD_pcs
           @ nLin, 158 PSAY Transform((cAliasCT)->VLRTPF_pcs  ,"@E 9999,999.99")  
           VLRTPF_pt += (cAliasCT)->VLRTPF_pcs
           @ nLin, 170 PSAY Transform((cAliasCT)->VLRINS_pcs  ,"@E 9999,999.99")            
           VLRINS_pt += (cAliasCT)->VLRINS_pcs
           @ nLin, 185 PSAY trim((cAliasCT)->statuspeg)
           @ nLin, 205 PSAY Transform((cAliasCT)->Dif  ,"@E 9999,999.99")   
           Dift += (cAliasCT)->Dif              

          // If (cAliasCT)->Dif > 0 .and. nTpRel != 1 .and. lFechamen != .T.             
           If nTpRel != 1 .and. lFechamen != .T.            
              FGrvDif( (cAliasCT)->RecnoPcs , (cAliasCT)->Dif )
           EndIf    
       nLin ++

       If nLin > 65 // Salto de Pแgina. Neste caso o formulario tem 55 linhas...
	      nLin :=	Cabec(Titulo,cCabec1,cCabec2,NomeProg,Tamanho,nTipo)
	      nLin ++            		
       EndIf        
        		
       (cAliasCT)->( dbSkip() )         
            			
  Enddo


//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ 12/2/08: Imprime o ultimo totalizador por usuario. ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู			        	            												
//Imprime totalizador somatorio / batimento de valores...
  
             nLin ++
           @ nLin, 000 PSAY Replicate('-',220)
             nLin ++                         
           @ nLin, 000 PSAY  '      T O T  A I S  - - - - - >>>'              
           @ nLin, 000 PSAY  '      T O T  A I S  - - - - - >>>'             
           @ nLin, 081 PSAY Transform(VlrApr_bt  ,"@E 9999,999.99")    
           @ nLin, 098 PSAY Transform(VlrTx_bt   ,"@E 9999,999.99") 
           @ nLin, 110 PSAY Transform(VlrTpf_bt  ,"@E 9999,999.99")  
                      
           @ nLin, 122 PSAY Transform(VLRPAG_pt  ,"@E 9999,999.99")
           @ nLin, 134 PSAY Transform(VLRBPF_pt  ,"@E 9999,999.99")
           @ nLin, 146 PSAY Transform(VLRTAD_pt  ,"@E 9999,999.99") 
           @ nLin, 158 PSAY Transform(VLRTPF_pt  ,"@E 9999,999.99")  
           @ nLin, 170 PSAY Transform(VLRINS_pt  ,"@E 9999,999.99")         
           @ nLin, 205 PSAY Transform(Dift       ,"@E 9999,999.99")      
					
    

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

static function FGrvDif( RecnoPcs , Dif )
			         
			         DbSelectArea("PCS")                        
                     DbGoto(RecnoPcs)

               //      If R_e_c_n_o_ == RecnoPcs 			         
		                PCS->(RecLock("PCS",.F.))
			             PCS->PCS_VLRDIF := Dif
			             PCS->(MsUnlock())    			         
                //     EndIf    
                        

Return ( )


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

PutSx1(cPerg,"01",OemToAnsi("Mes Compencia     " ) 		,"","","mv_ch1","C",02,0,0,"G","","","","","mv_par01","   ","","","","   ","","","","","","","","","","","",{},{},{}) 
PutSx1(cPerg,"02",OemToAnsi("Ano Compencia     " ) 		,"","","mv_ch2","C",04,0,0,"G","","","","","mv_par02","   ","","","","   ","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"03",OemToAnsi("Num Titulo        " ) 	    ,"","","mv_ch3","C",09,0,0,"G","","","","","mv_par03","   ","","","","   ","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"04",OemToAnsi("Ope Origem        " ) 		,"","","mv_ch4","C",04,0,0,"G","","","","","mv_par04","   ","","","","   ","","","","","","","","","","","",{},{},{}) 
PutSx1(cPerg,"05",OemToAnsi("Tipo de Relatorio " ) 	    ,"","","mv_ch5","N",01,0,0,"C","","","","","mv_par07","Conferencia","","","","Divergencia","","","Diverg. Valor","","","","","","","","",{},{},{}) 

Pergunte(cPerg,.F.)

Return(.T.)




