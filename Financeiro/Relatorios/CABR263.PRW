#Define CRLF Chr(13)+Chr(10)
#INCLUDE "rwmake.ch"
#include "PROTHEUS.CH"                                                                                                                         
#include "TOPCONN.CH"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ CABR2635  บ Autor ณ Altamiro Affonso   บ Data ณ  20/12/18  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Relatorio de Evolu็ใo da Movimenta do Sib - Mensal         บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP6 IDE                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
User Function CABR263()  

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Declaracao de Variaveis                                            ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

Local cDesc1         := "Este programa tem como objetivo imprimir relatorio "
Local cDesc2         := "Evolucao da movimenta็ใo ANS X caberj / integral"
Local cDesc3         := " "
Local cPict          := ""
Local titulo         := "Evolucao da movimentacao ANS "

Local Cabec1         := "  " //Codigo     Descri็ใo                                            Saldo"
//                       12345678901234567890123456789012345678901234567890123456789001234567890
//                       0        1         2         3         4         5         6          7
//                          XXX       XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX   999.999.999,99 
//                      BK2_PROPRI||BK2_CODLAN,                                    Sum(BK2_SALDO) 
Local Cabec2         := " "
Local imprime        := .T.
Local aOrd           := {}
Private nLin         := 220  
Private lEnd         := .F.
Private lAbortPrint  := .F.
Private CbTxt        := ""
Private limite       := 100
Private tamanho      := "P"
Private nomeprog     := "CABR263"
Private nTipo        := 15
Private aReturn      := { "Zebrado", 1, "Administracao", 1, 2, 1, "", 1}
Private nLastKey     := 0
Private cbtxt        := Space(10)
Private cbcont       := 00
Private CONTFL       := 01
Private m_pag        := 01
Private wnrel        := "CABR263"
Private cString      := "SE2"
Private cPerg        := "CABR263   "
Private valor_tot    := 0.00  
Private valor_col    := 0.00                                                                      
Private cquebra      := " "        
Private cttitpgto    :=' '   
private cqtdavend    := 0 
private ctraco80     := replicate("_",080)  
Private lflagtot     :=.F.    
private lflagMM      :=.F.
private nTtotAti     := 0 
Private cAliastmp    := GetNextAlias()
Private cAliastmp1 	 := GetNextAlias()
Private cAliastmp2 	 := GetNextAlias()      
Private cAliastmp3 	 := GetNextAlias()
Private cAliastmp4 	 := GetNextAlias()    
Private cAliastmp5 	 := GetNextAlias()
Private cAliastmp6 	 := GetNextAlias() 
Private cAliastmp7 	 := GetNextAlias()
Private cAliastmp8 	 := GetNextAlias() 
Private cAliastmp9 	 := GetNextAlias()

Private cQuery        := " "   
Private cQuery1       := " "  
Private cQuery2       := " "  
Private cQuery3       := " "  
Private cQuery4       := " "  
Private cQuery5       := " "    
Private cQuery6       := " "  
Private cQuery7       := " "  
Private cQuery8       := " "   
Private cQuery9       := " "  

ValidPerg(cPerg)
If Pergunte(cPerg,.T.) = .F.
	Return
Endif                                     

Private cAnoMes      := substr(mv_par01,4,4)+substr(mv_par01,1,2)  
Private nDetbas      := mv_par02     

private nTotIncAt := 0 
private nTotIncRj := 0
private nTotCancAt:= 0
private nTotCancRj:= 0    

 

private cmes:= val(substr(mv_par01,1,2))
private cano:= val(substr(mv_par01,4,4))        
//Private cAnoMesant      :=fCCompAnt(cano,cmes)

Private cAnoMesa      := str(iif(cmes==01,cano-1, cano),4)+strzero(iif(cmes==01,12,(cmes-1)),2)  
Private cAnoMesa1     := strzero((cano-1),4)+strzero((cmes),2) 
PRIVATE cEmpresa      :=  Iif(cEmpAnt == '01', 'Caberj ', 'Integral')
private cUltdia       := substr(dtos(Lastday(Ctod('01'+'/'+mv_par01))),7,2)
private nAcmBT        := 0
private nAcmNE        := 0

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
/****************************************************/
/* CQUERY  - QUERY DE CARGA DE CALCULO DA COMISSAO  */
/* CQYERY1 - Dados do(s) Titulo(S) a receber        */
/* CQYERY2 - compossi็ใo da cobran็a                */
/****************************************************/   
///-----------------------------------------------------------    
///---- BASE ANS     

If cEmpAnt == '02'
   cQuery := "select count(*) qtda from confsib_int where  sib_situac = '1'    " 
Else 
   cQuery := "select count(*) qtda  from confsib_cab where  sib_situac = '1'    "
EndIf    
//----- ajustes de base - quando ao envio      
      
cQuery1 := "select  pd5_compte, pd5_tpenvi , pd5_tpacao , pd5_envia , pd5_critic ,pd5_enviad,  pd5_CriAns , count(*)" 
cQuery1 += CRLF+ " from  " + RetSqlName("PD5") +" PD5  "
cQuery1 += CRLF+ " where PD5_FILIAL = '"+xFilial('PD5')+ "' and PD5.D_E_L_E_T_ = ' '"
cQuery1 += CRLF+ " and PD5_COMPTE  = '"+ canomes+"' " 
cQuery1 += CRLF+ "group by PD5_COMPTE, PD5_TPENVI , PD5_TPACAO , PD5_ENVIA , PD5_CRITIC ,PD5_ENVIAD,  PD5_CRIANS "

  
//-----------base caberj  seus status compossicao da carteira  ----
                       
cQuery2 :=" select BA1_LOCSIB , "
cQuery2 += CRLF+ " decode(BA1_LOCSIB,'0','0-Hแ ENVIAR' , "
cQuery2 += CRLF+ " '1','1-ATIVO' , "
cQuery2 += CRLF+ " '2','2-EXCLUอDO' , "
cQuery2 += CRLF+ " '3','3-ENVIADO INCLUSรO' , "
cQuery2 += CRLF+ " '4','4-ENVIADO ALTERAวรO' , " 
cQuery2 += CRLF+ " '5','5-ENVIADO EXCLUSรO' , "
cQuery2 += CRLF+ " '6','6-CRITICADO INCLUSรO (FORวAR INCLUSรO)' , "
cQuery2 += CRLF+ " '7','7-CRITICADO ALTERAวรO (FORวAR ALTERAวรO)' , "
cQuery2 += CRLF+ " '8','8-CRITICADO EXCLUSรO (FORวAR EXCLUSรO)' , "
cQuery2 += CRLF+ " '9','9-ENVIADO MUDANวA CONTRATUAL' , "
cQuery2 += CRLF+ " 'A','A-ENVIADO REATIVAวรO' , "
cQuery2 += CRLF+ " 'B','B-CRITICADO MUDANวA CONTRATUAL' , "
cQuery2 += CRLF+ " 'C','C-CRITICADO REATIVAวรO' , "
cQuery2 += CRLF+ "    'Outros - Nใo Previsto') LOCSIB , " 
cQuery2 += CRLF+ " decode(ba1_Infans,'0',(decode(ba1_Infsib,'0', (decode(ba1_atusib,'0', 'Nao','Sim')),'Sim')),'Sim') envia_ans , "
cQuery2 += CRLF+ " decode(trim(ba1_codcco),null,'Sem', 'Com') codcco , "
cQuery2 += CRLF+ " decode(TRIM(ba1_datblo),null,'Nao','Sim') bloq , "
cQuery2 += CRLF+ " Decode(TRIM(SIB_SITUAC), NULL ,'Sem', '1' , 'Ativo', '3', 'Inativo') situac_ans , "
//cQuery2 += CRLF+ " , ba1_datblo , BA1_LOCSIB , ba1_Infans , ba1_Infsib , ba1_atusib 
cQuery2 += CRLF+ "  Count (*) qtda "
cQuery2 += CRLF+ " From " + RetSqlName("BA1") +" BA1 ,"

If cEmpAnt == '01'
   cQuery2 += CRLF+ " CONFSIB_CAB SIB "
Else
   cQuery2 += CRLF+ " CONFSIB_INT SIB "
EndIf
        
cQuery2 += CRLF+ " Where ba1.D_E_L_E_T_ = ' ' and ba1_filial = '"+xFilial('BM1')+ "'"
cQuery2 += CRLF+ " and (ba1_datblo = ' ' or ba1_datblo > '"+ canomes+cUltdia +"' "
cQuery2 += CRLF+ " and ba1_datinc  <= '"+ canomes+"31' "             

If cEmpAnt == '01'
   cQuery2 += CRLF+ " and ba1_codemp not in ('0004','0009') "
EndIf    

cQuery2 += CRLF+ " group by BA1_LOCSIB , "
cQuery2 += CRLF+ "       decode(BA1_LOCSIB,'0','0-Hแ ENVIAR' , "
cQuery2 += CRLF+ "                         '1','1-ATIVO' , "
cQuery2 += CRLF+ "                         '2','2-EXCLUอDO' , "
cQuery2 += CRLF+ "                         '3','3-ENVIADO INCLUSรO' , "
cQuery2 += CRLF+ "                         '4','4-ENVIADO ALTERAวรO' , "
cQuery2 += CRLF+ "                         '5','5-ENVIADO EXCLUSรO' , "
cQuery2 += CRLF+ "                         '6','6-CRITICADO INCLUSรO (FORวAR INCLUSรO)' , "
cQuery2 += CRLF+ "                         '7','7-CRITICADO ALTERAวรO (FORวAR ALTERAวรO)' , "
cQuery2 += CRLF+ "                         '8','8-CRITICADO EXCLUSรO (FORวAR EXCLUSรO)' , "
cQuery2 += CRLF+ "                         '9','9-ENVIADO MUDANวA CONTRATUAL' , "
cQuery2 += CRLF+ "                         'A','A-ENVIADO REATIVAวรO' , "
cQuery2 += CRLF+ "                         'B','B-CRITICADO MUDANวA CONTRATUAL' , "
cQuery2 += CRLF+ "                         'C','C-CRITICADO REATIVAวรO' , "
cQuery2 += CRLF+ "                         'Outros - Nใo Previsto') , " 
cQuery2 += CRLF+ "                         decode(ba1_Infans,'0',(decode(ba1_Infsib,'0', (decode(ba1_atusib,'0', 'Nao','Sim')),'Sim')),'Sim') , "
cQuery2 += CRLF+ "                         decode(trim(ba1_codcco),null,'Sem', 'Com') , "
cQuery2 += CRLF+ "                         decode(TRIM(ba1_datblo),null,'Nao','Sim') "
cQuery2 += CRLF+ "                         order by 1,2,3,4,5 "

//-----caberj bloqueadas   

    
cQuery3 := CRLF+ " select bloq.comp_bloq  COMP_bloq , "
cQuery3 += CRLF+ " decode(trim(bloq.BLOANS), null,'Suspensใo Temporแrias', 'Bloqueios Definitivos') descr , count(*) qtda  "
cQuery3 += CRLF+ " from "
cQuery3 += CRLF+ " (select  ba1_motblo ,  ba1_consid ,"

cQuery3 += CRLF+ " CASE WHEN substr(ba1_datblo,1,6) >= '"+canomes+"' THEN 'Bloq na Competencia' "
cQuery3 += CRLF+ " Else 'Bloq Competencia Anterior' END  comp_bloq , "                    

cQuery3 += CRLF+ " CASE WHEN BA1_consid = 'U' THEN NVL(BLQU.DESCRI, ' ' )"
cQuery3 += CRLF+ "  WHEN BA1_consid = 'F' THEN NVL(BLQF.DESCRI, ' ' )"
cQuery3 += CRLF+ "  WHEN BA1_consid = 'S' THEN NVL(BLQS.DESCRI, ' ' )"
cQuery3 += CRLF+ "  Else 'S/Descri็ao' END  DESCBLO ,"                     

cQuery3 += CRLF+ "  CASE WHEN BA1_consid = 'U' THEN NVL(BLQU.blqans, ' ' )"
cQuery3 += CRLF+ "  WHEN BA1_consid = 'F' THEN NVL(BLQF.blqans, ' ' )"
cQuery3 += CRLF+ "  WHEN BA1_consid = 'S' THEN NVL(BLQS.blqans, ' ' )"
cQuery3 += CRLF+ "  Else 'S/Descri็ao' END  BLOANS ," 

cQuery3 += CRLF+ "  CASE WHEN BA1_consid = 'U' THEN NVL(BLQU.codblo, ' ' )"
cQuery3 += CRLF+ "  WHEN BA1_consid = 'F' THEN NVL(BLQF.codblo, ' ' )"
cQuery3 += CRLF+ "  WHEN BA1_consid = 'S' THEN NVL(BLQS.codblo, ' ' )"
cQuery3 += CRLF+ "  Else 'S/Descri็ao' END  BLOCAB"                                           
cQuery3 += CRLF+ "from  "+ RetSqlName("BA1") +" BA1 ," 
cQuery3 += CRLF+ "( select 'usuario' origem  , bg3_codblo codblo , bg3_desblo descri , bg3_blqans  blqans , decode(bg3_tipblo,'0','Bloq', 'Desbloq') tpblo from "+ RetSqlName("BG3") +" BG3 WHERE BG3_FILIAL= '"+xFilial('BG3')+ "' AND BG3.d_e_l_e_t_ = ' ') blqu ," 
cQuery3 += CRLF+ "( select 'familia' origem  , bg1_codblo codblo , bg1_desblo descri , bg1_blqans  blqans , decode(bg1_tipblo,'0','Bloq', 'Desbloq') tpblo from "+ RetSqlName("BG1") +" BG1 WHERE BG1_FILIAL= '"+xFilial('BG1')+ "' AND BG1.d_e_l_e_t_ = ' ') blqf ," 
cQuery3 += CRLF+ "( select 'sub_cont' origem , bqu_codblo codblo , bqu_desblo descri , bqu_blqans  blqans , decode(bqu_tipblo,'0','Bloq', 'Desbloq') tpblo from "+ RetSqlName("BQU") +" BQU WHERE BQU_FILIAL= '"+xFilial('BQU')+ "' AND BQU.d_e_l_e_t_ = ' ') blqs  "

cQuery3 += CRLF+ "  where ba1.D_E_L_E_T_ = ' ' and ba1_filial = '  ' "
cQuery3 += CRLF+ "and (ba1_datblo  >= '"+canomesa1+"01'  and ba1_datblo <= '"+ canomes+cUltdia +"' ) " 
If cEmpAnt == '01' 
   cQuery3 += CRLF+ " and ba1_codemp not in ('0004','0009')"
EndIf     
cQuery3 += CRLF+ "  and ba1_motblo = BLQU.CODBLO(+)"
cQuery3 += CRLF+ "  and ba1_motblo = BLQF.CODBLO(+)"
cQuery3 += CRLF+ "  and ba1_motblo = BLQS.CODBLO(+) ) bloq "

cQuery3 += CRLF+ "  group by bloq.comp_bloq , "
cQuery3 += CRLF+ "  decode(trim(bloq.BLOANS), null,'Suspensใo Temporแrias', 'Bloqueios Definitivos')" 
cQuery3 += CRLF+ "  order by 1 " 

/*
cQuery3 :="select decode(trim(bloq.BLOANS), null,'Susp. Temporaria', 'Bloq Definitivo') descr , bloq.TPBLO  , count(*) qtda  from "
cQuery3 += CRLF+ "(select  ba1_motblo ,  ba1_consid ,"

cQuery3 += CRLF+ " CASE WHEN BA1_consid = 'U' THEN NVL(BLQU.DESCRI, ' ' )" 
cQuery3 += CRLF+ " WHEN BA1_consid = 'F' THEN NVL(BLQF.DESCRI, ' ' )"
cQuery3 += CRLF+ " WHEN BA1_consid = 'S' THEN NVL(BLQS.DESCRI, ' ' )"
cQuery3 += CRLF+ " Else 'S/Descri็ao' END  DESCBLO ,                     
"
cQuery3 += CRLF+ " CASE WHEN BA1_consid = 'U' THEN NVL(BLQU.blqans, ' ' )" 
cQuery3 += CRLF+ " WHEN BA1_consid = 'F' THEN NVL(BLQF.blqans, ' ' )"
cQuery3 += CRLF+ " WHEN BA1_consid = 'S' THEN NVL(BLQS.blqans, ' ' )"
cQuery3 += CRLF+ " Else 'S/Descri็ao' END  BLOANS , "                     

cQuery3 += CRLF+ " CASE WHEN BA1_consid = 'U' THEN NVL(BLQU.codblo, ' ' )" 
cQuery3 += CRLF+ " WHEN BA1_consid = 'F' THEN NVL(BLQF.codblo, ' ' )"
cQuery3 += CRLF+ " WHEN BA1_consid = 'S' THEN NVL(BLQS.codblo, ' ' )"
cQuery3 += CRLF+ " Else 'S/Descri็ao' END  BLOCAB ,"

cQuery3 += CRLF+ " CASE WHEN BA1_consid = 'U' THEN NVL(BLQU.tpblo, ' ' ) "
cQuery3 += CRLF+ " WHEN BA1_consid = 'F' THEN NVL(BLQF.tpblo, ' ' ) "
cQuery3 += CRLF+ " WHEN BA1_consid = 'S' THEN NVL(BLQS.tpblo, ' ' ) "
cQuery3 += CRLF+ " Else 'S/Descri็ao' END  TPBLO "      
     
cQuery3 += CRLF+ "from  "+ RetSqlName("BA1") +" BA1 ," 
cQuery3 += CRLF+ "( select 'usuario' origem  , bg3_codblo codblo , bg3_desblo descri , bg3_blqans  blqans , decode(bg3_tipblo,'0','Bloq', 'Desbloq') tpblo from "+ RetSqlName("BG3") +" BG3 WHERE BG3_FILIAL= '"+xFilial('BG3')+ "' AND BG3.d_e_l_e_t_ = ' ') blqu ," 
cQuery3 += CRLF+ "( select 'familia' origem  , bg1_codblo codblo , bg1_desblo descri , bg1_blqans  blqans , decode(bg3_tipblo,'0','Bloq', 'Desbloq') tpblo from "+ RetSqlName("BG1") +" BG1 WHERE BG1_FILIAL= '"+xFilial('BG1')+ "' AND BG1.d_e_l_e_t_ = ' ') blqf ," 
cQuery3 += CRLF+ "( select 'sub_cont' origem , bqu_codblo codblo , bqu_desblo descri , bqu_blqans  blqans , decode(bg3_tipblo,'0','Bloq', 'Desbloq') tpblo from "+ RetSqlName("BQU") +" BQU WHERE BQU_FILIAL= '"+xFilial('BQU')+ "' AND BQU.d_e_l_e_t_ = ' ') blqs  "
cQuery3 += CRLF+ " where ba1.D_E_L_E_T_ = ' ' and ba1_filial = '"+xFilial('BM1')+ "'"
cQuery3 += CRLF+ "and (ba1_datblo  >= '"+ canomes+"01'  and ba1_datblo <= '"+ canomes+"31' ) "
If cEmpAnt == '01'
   cQuery3 += CRLF+ " and ba1_codemp not in ('0004','0009')"
EndIf     
cQuery3 += CRLF+ " and ba1_motblo = BLQU.CODBLO(+)" 
cQuery3 += CRLF+ " and ba1_motblo = BLQF.CODBLO(+)" 
cQuery3 += CRLF+ " and ba1_motblo = BLQS.CODBLO(+) ) bloq "
//cQuery3 += CRLF+ "  where trim(bloq.BLOANS) is not null "
cQuery3 += CRLF+ "group by decode(trim(bloq.BLOANS), null,'Susp. Temporaria', 'Bloq Definitivo'), bloq.TPBLO "
              */


///---------------- INCLUSOES NO PERIODO CABERJ 
                                      
cQuery4 := CRLF+" select decode(trim(ba1_codcco), null,'Nao Enviados', 'Enviados') enviados , count(*) qtda"
cQuery4 += CRLF+"   from  "+ RetSqlName("BA1") +" BA1 "  
cQuery4 += CRLF+"  where ba1_filial = ' ' and d_E_L_E_T_ =' ' "
cQuery4 += CRLF+"    and (ba1_datblo = ' ' or ba1_datblo > '"+ canomes+cUltdia +"' ) "
If cEmpAnt == '01'   
   cQuery4 += CRLF+"   and ba1_codemp not in ('0004','0009')"
EndIf 
cQuery4 += CRLF+"   and ba1_datinc  >= '"+ canomes+"01' AND ba1_datinc  <= '"+ canomes+cUltdia +"' "
cQuery4 += CRLF+" group by decode(trim(ba1_codcco), null,'Nao Enviados', 'Enviados') "


/*
cQuery4 := CRLF+" SELECT COUNT(*) qtda"
cQuery4 += CRLF+"   from  "+ RetSqlName("BA1") +" BA1 " 
cQuery4 += CRLF+"  where ba1.D_E_L_E_T_ = ' ' and ba1_filial = '"+xFilial('BA1')+ "'"
cQuery4 += CRLF+"    and (ba1_datblo = ' ' or ba1_datblo > '"+ canomes+"31' ) "
cQuery4 += CRLF+"    and ba1_datinc  >= '"+ canomes+"01' AND ba1_datinc  <= '"+ canomes+"31' "
If cEmpAnt == '01'   
   cQuery4 += CRLF+"   and ba1_codemp not in ('0004','0009')"
EndIf 
*/
//------CONTROLE DE ENVIO ------------------------------------------------------
cQuery5 :=" SELECT PD5_COMPTE COMPT, PD5_TPENVI TPENVI , PD5_TPACAO TPACAO, DECODE(PD5_ENVIAD,'F', 'NAO','SIM') ENVIADO ,DECODE(TRIM(PD5_CRIANS),'F', 'NAO','SIM') CRIANS,  COUNT(*) QTDA  "
cQuery5 += CRLF+ "  FROM "+ RetSqlName("PD5") +" PD5 " 
cQuery5 += CRLF+ " WHERE PD5_FILIAL= ' 'AND D_E_L_E_T_= ' '" 
cQuery5 += CRLF+ "   AND ((PD5_COMPTE =  '"+ canomes+ "' and PD5_TPENVI = 'Sib Mensal' ) "
cQuery5 += CRLF+ "    or  (PD5_COMPTE =  '"+ canomesa+"' and PD5_TPENVI = 'Sib Global' ))"
//cQuery5 += CRLF+ "   AND PD5_COMPTE IN ('201811','201810')"
cQuery5 += CRLF+ "   AND PD5_TPACAO IN ('INCL', 'CANC')"
cQuery5 += CRLF+ " GROUP BY PD5_COMPTE , PD5_TPACAO , DECODE(PD5_ENVIAD,'F', 'NAO','SIM') ,DECODE(TRIM(PD5_CRIANS),'F', 'NAO','SIM'),PD5_TPENVI  "
cQuery5 += CRLF+ " ORDER BY 1,2,3 "

                  
///---------------- ATIVOS NO PERIODO ATE O FIM DA COMPETENCIA 

cQuery6 := CRLF+" SELECT COUNT(*) qtda"
cQuery6 += CRLF+"   from  "+ RetSqlName("BA1") +" BA1 " 
cQuery6 += CRLF+"  where ba1.D_E_L_E_T_ = ' ' and ba1_filial = '"+xFilial('BA1')+ "'"
cQuery6 += CRLF+"    AND (ba1_datblo = ' ' or ba1_datblo > '"+ canomes+cUltdia +"' ) "
cQuery6 += CRLF+"    AND ba1_datinc  <= '"+ canomes+"31' "
If cEmpAnt == '01'   
   cQuery6 += CRLF+"   and ba1_codemp not in ('0004','0009')"
EndIf 

//------------------------------------


If Select((cAliastmp)) <> 0 
   (cAliastmp)->(DbCloseArea())  
Endif 
If Select((cAliastmp1)) <> 0 
   (cAliastmp1)->(DbCloseArea())  
Endif
If Select((cAliastmp2)) <> 0 
   (cAliastmp2)->(DbCloseArea())  
Endif
If Select((cAliastmp3)) <> 0 
   (cAliastmp3)->(DbCloseArea())  
Endif                
If Select((cAliastmp4)) <> 0 
   (cAliastmp4)->(DbCloseArea())  
Endif
If Select((cAliastmp5)) <> 0 
   (cAliastmp5)->(DbCloseArea())  
Endif                     
If Select((cAliastmp6)) <> 0 
   (cAliastmp6)->(DbCloseArea())  
Endif                    

TCQuery cQuery  New Alias (cAliastmp)   
TCQuery cQuery1 New Alias (cAliastmp1)   
//TCQuery cQuery2 New Alias (cAliastmp2)   
TCQuery cQuery3 New Alias (cAliastmp3)   
TCQuery cQuery4 New Alias (cAliastmp4)    
TCQuery cQuery5 New Alias (cAliastmp5)  
TCQuery cQuery6 New Alias (cAliastmp6)    


(cAliastmp )->(dbGoTop()) 
(cAliastmp1)->(dbGoTop())
//(cAliastmp2)->(dbGoTop())
(cAliastmp3)->(dbGoTop())
(cAliastmp4)->(dbGoTop()) 
(cAliastmp5)->(dbGoTop())     
(cAliastmp6)->(dbGoTop()) 

//While (cAliastmp)->(!EOF()) .and. (cAliastmp1)->(!EOF()) .and. (cAliastmp2)->(!EOF()) .and. (cAliastmp3)->(!EOF()) .and. (cAliastmp4)->(!EOF())
	If nLin > 55 // Salto de Pแgina. Neste caso o formulario tem 55 linhas...
	   nLin :=	Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)        
	   nLin ++
	Endif
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Verifica o cancelamento pelo usuario...                             ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	
	If lAbortPrint
		@nLin,00 PSAY "*** CANCELADO PELO OPERADOR ***"
	 //	Exit
	Endif
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Impressao do cabecalho do relatorio. . .                            ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู  
	//identificacao da empresa (contratante)
   @ nLin,001 PSAY "Conferencia da Carteira "+cEmpresa +"  X ANS  "     
    nlin++
    nlin++
	@ nLin,002 PSAY "Competencia (Sib Mensal) : " +  canomes
	  nlin++          
    @ nLin,001 PSAY ctraco80
      nlin++        
                                                        
    @ nLin,002 PSAY "Qtda Ativo Ans   : " 
    @ nLin,025 PSAY (cAliastmp)->qtda Picture "@ 999.999"     
    @ nLin,035 PSAY "Na comptencia (Arq. ANS Confer๊ncia)"+canomesa    
      nlin++  
    @ nLin,001 PSAY ctraco80
      nlin++        
    
    While (cAliastmp5)->(!EOF())   
                
           @ nLin,002 PSAY (cAliastmp5)->COMPT+"  -- "+(cAliastmp5)->TPENVI+"  -- "+(cAliastmp5)->TPACAO   
           if (cAliastmp5)->TPACAO == 'INCL'                  
               if TRIM((cAliastmp5)->CRIANS) == 'NAO'           
                  @ nLin,045 PSAY "(+)"  
                    nTotIncAt += (cAliastmp5)->QTDA 
               Else                    
                  @ nLin,045 PSAY "( )"  
                  @ nLin,055 PSAY "Rejeitada ANS"   
                    nTotIncRj += (cAliastmp5)->QTDA 
               EndIf   
               @ nLin,050 PSAY (cAliastmp5)->QTDA Picture "@ 999.999"  
           Elseif (cAliastmp5)->TPACAO == 'CANC' 
               If TRIM((cAliastmp5)->CRIANS) == 'NAO' 
                  @ nLin,045 PSAY "(-)"             
                    nTotCancAt += (cAliastmp5)->QTDA  
               Else                       
                  @ nLin,045 PSAY "( )"               
                  @ nLin,055 PSAY "Rejeitada ANS"     
                    nTotCancRj += (cAliastmp5)->QTDA  
               EndIf    
               @ nLin,050 PSAY (cAliastmp5)->QTDA Picture "@ 999.999"      
           EndIf 
      	  (cAliastmp5)->(dbSkip())                     
   
           nlin++           	    
    EndDo              
             
    @ nLin,005 PSAY "                              _______________________" 

      nlin++           	    
    @ nLin,005 PSAY "Saldo -->             " 
    @ nLin,045 PSAY ((cAliastmp)->qtda + nTotIncAt - nTotCancAt) Picture "@ 999.999"

  	  nlin++                
	  nlin++          
    @ nLin,001 PSAY ctraco80
      nlin++                                                                         
    @ nLin,001 PSAY ctraco80
  	  nlin++
      nlin++                                                                              
    @ nLin,025 PSAY "      Movimenta็ใo "+cEmpresa +" "   
      nlin++                                                                        
    @ nLin,001 PSAY ctraco80
      nlin++            
      @ nLin,025 PSAY "      Ativos na  "+cEmpresa +" "                                                             
      nlin++      
      nlin++     
      @ nLin,002 PSAY " Ativos Ate  " 
      @ nLin,015 PSAY stod(canomes+ cUltdia) 
      @ nLin,030 PSAY "Qtda -->  "       	    
      @ nLin,045 PSAY (cAliastmp6)->qtda  Picture "@ 999.999"              	      
      nlin++                
      @ nLin,001 PSAY ctraco80                                                              
      nlin++
    @ nLin,025 PSAY "      Bloqueios e Suspens๕es "                                   
      nlin++                                                                                     
      nlin++                                                                                        
    While (cAliastmp3)->(!EOF())                                                                             
       
       If  ((TRIM((cAliastmp3)->COMP_BLOQ) == 'Bloq Competencia Anterior'	.and.   TRIM((cAliastmp3)->DESCR) == 'Bloqueios Definitivos' ))
            a:= 'b'
       Else     
           @ nLin,002 PSAY (cAliastmp3)->COMP_BLOQ
           @ nLin,030 PSAY (cAliastmp3)->DESCR
           @ nLin,055 PSAY (cAliastmp3)->QTDA Picture "@ 999.999"  
           nlin++  
           if TRIM((cAliastmp3)->DESCR) == 'Suspensใo Temporแrias'
              nAcmBT+=(cAliastmp3)->QTDA              	                      
           EndIf                     	    
       EndIf       
      	  (cAliastmp3)->(dbSkip())                     
   

    EndDo                           
    nlin++                
    
    @ nLin,001 PSAY ctraco80  
      nlin++                                              
      nlin++                
    @ nLin,031 PSAY "Inclusaos Na Competencia  "        	                     
      nlin++                
    While (cAliastmp4)->(!EOF())  
        nlin++           	                                        
        @ nLin,012 PSAY (cAliastmp4)->enviados        	    
        @ nLin,035 PSAY (cAliastmp4)->qtda  Picture "@ 999.999"              	
        If trim((cAliastmp4)->enviados)=='Nao Enviados'          
           nAcmNE+=(cAliastmp4)->qtda
        endIf  
       (cAliastmp4)->(dbSkip())                     

    EndDo
        
  	  nlin++                
    
      @ nLin,001 PSAY ctraco80  	    
    
  	  nlin++                                              
      @ nLin,031 PSAY " Ativos na "+cEmpresa +" "   
      nlin++ 
  	  nlin++                                                	  
      @ nLin,002 PSAY " Ativos                              -->  " 
      @ nLin,045 PSAY (cAliastmp6)->qtda  Picture "@ 999.999"        
    
      nlin++                                                	  
      @ nLin,002 PSAY " Bloq. Temporario(Nใo Enviado a ANS) -->  " 
      @ nLin,045 PSAY nAcmBT  Picture "@ 999.999"       
    
      nTtotAti:= (cAliastmp6)->qtda  + nAcmBT	                                                                
  	
  	  nlin++                                                	  
      @ nLin,002 PSAY " Total de Ativos                     -->  " 
      @ nLin,045 PSAY nTtotAti  Picture "@ 999.999"       
  	
  	  nlin++                                     
    
    @ nLin,001 PSAY ctraco80  	      
      
                                                               

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
cPerg := PADR(cPerg,10)

aAdd(aRegs,{cPerg,"01","Mes/Ano Comissao       ?","","","mv_ch1","C",07,0,0,"G","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "99/9999", "" })
aadd(aRegs,{cPerg,"02","Detalhar Carteira      ?","","","mv_ch2","N", 1,0,0,"C","","mv_par02","Sim","","","","","Nao","","","","","","","","","","","","","","","","","" , "" ,""  , "", "", "" })

For i:=1 to Len(aRegs)
	If !dbSeek(cPerg+aRegs[i,2])
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
/*
STATIC FUNCTION fCCompAnt(cAnocmp,cMesCmp)
local cAnoCmpAnt := ' ' 
local cMesCmpAnt := ' ' 
   
If cMesCmp == 01
   cMesCmpAnt:='12'
   cAnoCmpAnt:= strzero((cAnocmp-1),4)
else               
   cMesCmpAnt:= strzero((cMescmp-1),2)
   cAnoCmpAnt:= strzero((cAnocmp),4)
endIf    
return (cAnoCmpAnt+cMesCmpAnt)
  */

