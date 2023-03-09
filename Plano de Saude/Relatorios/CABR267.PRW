#INCLUDE "rwmake.ch"
#include "PROTHEUS.CH"                                                                                                                         
#include "TOPCONN.CH"
#Define CRLF Chr(13)+Chr(10)
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ CABR264  บ Autor ณ Altamiro Affonso   บ Data ณ  20/12/18  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Movimenta da Carteira no M๊s SIB                           บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP6 IDE                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
User Function CABR267()  

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Declaracao de Variaveis                                             ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

Local cDesc1         := "Este programa tem como objetivo imprimir relatorio "
Local cDesc2         := "Movimenta็ใo da Carteira no M๊s   caberj / integral"
Local cDesc3         := " Com Varias Vis๕es "
Local cPict          := ""
Local titulo         := "Movimenta็ใo da Carteira no M๊s "

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
Private cbtxt        := Space(10)
Private limite       := 100
Private tamanho      := "P"
Private nomeprog     := "CABR267"
Private nTipo        := 15
Private aReturn      := { "Zebrado", 1, "Administracao", 1, 2, 1, "", 1}
Private nLastKey     := 0
Private cbcont       := 00
Private CONTFL       := 01
Private m_pag        := 01
Private wnrel        := "CABR267"
Private cString      := "SE2"
Private cPerg        := "CABR267   "
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
private Z         := 0
private aExc      :={}
Private nBlqTemp  := 0         
Private nBloqMes  := 0
Private nCOMCCO   := 0                           
Private nSTCABEX  := 0                                
Private nSTCABNEX := 0
Private nNaoEnvia := 0                                                             
private nEmp004I  := 0

private cmes:= val(substr(mv_par01,1,2))
private cano:= val(substr(mv_par01,4,4))        
//Private cAnoMesant      :=fCCompAnt(cano,cmes)

Private cAnoMesa      := str(iif(cmes==01,cano-1, cano),4)+strzero(iif(cmes==01,12,(cmes-1)),2)  
Private cAnoMesa1     := strzero((cano-1),4)+strzero((cmes),2) 
PRIVATE cEmpresa      :=  Iif(cEmpAnt == '01', 'Caberj ', 'Integral')
private cUltdia       := substr(dtos(Lastday(Ctod('01'+'/'+mv_par01))),7,2)
private nAcmBT        := 0
private nAcmNE        := 0

private nEmp004C      := 0
        
Private nJaEnv        := 0
private aInc          := {}
private nBloqInc      := 0
private CCriInc       := 0
Private nCCIncAns     := 0
Private nAEnviar      := 0
                                                        


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
/// nova implementa 
/*
 SELECT pd5_tpenvi , 
        pd5_tpacao , 
        decode(pd5_critic,'F', 'Nao Criticado','Criticado' ) critica  ,   
        decode(pd5_enviad,'F', 'Nao Enviado' ,'Enviado') enviado      ,  
        PD5_CRICAB , 
        count(*)   
 FROM  SIGA.PD5020 PD5 
  WHERE PD5_filial = '  '
    AND d_E_L_E_T_ = ' ' 
  and pd5_compte  = '201812'
  and pd5_tpenvi  = 'Sib Global'
  group by pd5_tpenvi , pd5_tpacao , pd5_critic ,   pd5_ENVIAD, PD5_CRICAB 
  order by 1,2,3
  ;
  SELECT pd5_tpenvi , 
        pd5_tpacao , 
        decode(pd5_critic,'F', 'Nao Criticado','Criticado' ) critica  ,   
        decode(pd5_enviad,'F', 'Nao Enviado' ,'Enviado') enviado      ,  
        count(*)   
 FROM  SIGA.PD5020 PD5 
  WHERE PD5_filial = '  '
    AND d_E_L_E_T_ = ' ' 
  and pd5_compte  = '201812'
  and pd5_tpenvi  = 'Sib Global'
  group by pd5_tpenvi , pd5_tpacao , pd5_critic ,   pd5_ENVIAD
  order by 1,2,3
  
; 
  SELECT decode(trim(pd5_codcco),'',pd5_matric , pd5_codcco) ||'-'|| pd5_nomusr usuario ,
        pd5_tpenvi , 
        pd5_tpacao , 
        decode(pd5_critic,'F', 'Nao Criticado','Criticado' ) critica  ,   
        decode(pd5_enviad,'F', 'Nao Enviado' ,'Enviado') enviado      ,
        pd5_cricab , pd5_crians
       -- count(*)   
 FROM  SIGA.PD5020 PD5 
  WHERE PD5_filial = '  '
    AND d_E_L_E_T_ = ' ' 
  and pd5_compte  = '201812'
  and pd5_tpenvi  = 'Sib Global'
  and pd5_sequen  = '01'
 -- group by pd5_tpenvi , pd5_tpacao , pd5_critic ,   pd5_ENVIAD
  order by 3, 4 ,1 , 2

*/



 
///---- BASE bruta empresa     

cQuery := " select  Count(*) QtdaInc  from " + RetSqlName("BA1") +" BA1  where ba1_filial ='"+xFilial('BA1')+ "' and d_E_L_E_T_ = ' ' and ba1_datInc >= '"+cAnoMes+"01' and ba1_datInc <= '"+cAnoMes+"31'" 

cQuery1:= " select  Count(*) QtdaDel  from " + RetSqlName("BA1") +" BA1  where ba1_filial ='"+xFilial('BA1')+ "' and d_E_L_E_T_ = ' ' and ba1_datBlo >= '"+cAnoMes+"01' and ba1_datblo <= '"+cAnoMes+"31'"
      
//----- Bloqueios  

cQuery2 := CRLF+ " SELECT ba1_codemp codemp ,   decode(substr(ba1_datinc,1,6),substr(ba1_datblo,1,6),'2-Sim', '1-Nใo') No_Mes_Incl " 
cQuery2 += CRLF+ "        , decode(ba1_atusib,'0','NAO ENVIA',decode(ba1_infsib,'0','NAO ENVIA',decode(ba1_infans,'0','NAO ENVIA','ENVIA'))) envia " 
cQuery2 += CRLF+ "        , decode(trim(ba1_codcco),'', 'Sem CCo','Com CCo') comcco " 
cQuery2 += CRLF+ "        , decode(ba1_locsib,'0','0-Hแ ENVIAR' , " 
cQuery2 += CRLF+ "                            '1','1-ATIVO' , " 
cQuery2 += CRLF+ "                            '2','2-EXCLUอDO' , " 
cQuery2 += CRLF+ "                            '3','3-ENVIADO INCLUSรO' , "
cQuery2 += CRLF+ "                            '4','4-ENVIADO ALTERAวรO' , " 
cQuery2 += CRLF+ "                            '5','5-ENVIADO EXCLUSรO' , " 
cQuery2 += CRLF+ "                            '6','6-CRITICADO INCLUSรO (FORวAR INCLUSรO)' , " 
cQuery2 += CRLF+ "                            '7','7-CRITICADO ALTERAวรO (FORวAR ALTERAวรO)' , " 
cQuery2 += CRLF+ "                            '8','8-CRITICADO EXCLUSรO (FORวAR EXCLUSรO)' , " 
cQuery2 += CRLF+ "                            '9','9-ENVIADO MUDANวA CONTRATUAL' , " 
cQuery2 += CRLF+ "                            'A','A-ENVIADO REATIVAวรO' , " 
cQuery2 += CRLF+ "                            'B','B-CRITICADO MUDANวA CONTRATUAL' , " 
cQuery2 += CRLF+ "                            'C','C-CRITICADO REATIVAวรO' , " 
cQuery2 += CRLF+ "                            'Outros - Nใo Previsto')  stcab , "

cQuery2 += CRLF+ "CASE WHEN substr(ba1_datblo,1,6) = '"+cAnoMes+"' THEN 'Bloq Na Compt' "  
cQuery2 += CRLF+ "     WHEN substr(ba1_datblo,1,6) > '"+cAnoMes+"' THEN 'Bloq Na Compt Futura' "
cQuery2 += CRLF+ "     Else 'Bloq Na Compt Anterior' END  comp_bloq , "                     
 
cQuery2 += CRLF+ "decode(trim(CASE WHEN BA1_consid = 'U' THEN NVL(BLQU.blqans, ' ' ) " 
cQuery2 += CRLF+ "                 WHEN BA1_consid = 'F' THEN NVL(BLQF.blqans, ' ' ) "
cQuery2 += CRLF+ "                 WHEN BA1_consid = 'S' THEN NVL(BLQS.blqans, ' ' ) "
cQuery2 += CRLF+ "            Else 'S/Descri็ao' END),null,'Bloq Temp','Bloq Def') BLOANS , "  
//cQuery2 += CRLF+ "BA1.BA1_INCANS , BA1.BA1_EXCANS , BA1.BA1_ENVANS ENVANS ," 
cQuery2 += CRLF+ "  decode(ba1_locsib , '2' , BA1.BA1_ENVANS, ' ') ENVANS ," 
cQuery2 += CRLF+ " count(*) qtda " 

cQuery2 += CRLF+ "FROM " + RetSqlName("BA1") +" BA1 , " 
cQuery2 += CRLF+ "( select 'usuario' origem  , bg3_codblo codblo , bg3_desblo descri , bg3_blqans  blqans  from " + RetSqlName("BG3") +" BG3 WHERE BG3_FILIAL= '"+xFilial('BG3')+ "' AND BG3.d_e_l_e_t_ = ' ') blqu , "
cQuery2 += CRLF+ "( select 'familia' origem  , bg1_codblo codblo , bg1_desblo descri , bg1_blqans  blqans  from " + RetSqlName("BG1") +" BG1 WHERE BG1_FILIAL= '"+xFilial('BG1')+ "' AND BG1.d_e_l_e_t_ = ' ') blqf , "
cQuery2 += CRLF+ "( select 'sub_cont' origem , bqu_codblo codblo , bqu_desblo descri , bqu_blqans  blqans  from " + RetSqlName("BQU") +" BQU WHERE BQU_FILIAL= '"+xFilial('BQU')+ "' AND BQU.d_e_l_e_t_ = ' ') blqs , "
cQuery2 += CRLF+ "( select DISTINCT PD5_CODCCO from " + RetSqlName("PD5") +" PD5 where pd5_filial = ' ' and d_E_L_E_T_ = ' ' and pd5_compte = '"+cAnoMes+"' and pd5_tpacao = 'CANC' ) PD5 "

cQuery2 += CRLF+ " where ba1.D_E_L_E_T_ = ' ' and ba1_filial = '"+xFilial('BA1')+ "' "      
cQuery2 += CRLF+ " and ba1_datblo  >= '"+cAnoMes+"01' and ba1_datblo <= '"+cAnoMes+"31'"  

cQuery2 += CRLF+ " and ba1_motblo = BLQU.CODBLO(+) "
cQuery2 += CRLF+ " and ba1_motblo = BLQF.CODBLO(+) "
cQuery2 += CRLF+ " and ba1_motblo = BLQS.CODBLO(+) "
cQuery2 += CRLF+ " and ba1_codcco = PD5.PD5_CODCCO(+) "   

cQuery2 += CRLF+ " GROUP BY ba1_codemp , decode(substr(ba1_datinc,1,6),substr(ba1_datblo,1,6),'2-Sim', '1-Nใo') "
cQuery2 += CRLF+ "         , decode(ba1_atusib,'0','NAO ENVIA',decode(ba1_infsib,'0','NAO ENVIA',decode(ba1_infans,'0','NAO ENVIA','ENVIA')))" 
cQuery2 += CRLF+ "         , decode(trim(ba1_codcco),'', 'Sem CCo','Com CCo')"  
cQuery2 += CRLF+ "         , decode(ba1_locsib,'0','0-Hแ ENVIAR' ," 
cQuery2 += CRLF+ "                             '1','1-ATIVO' ," 
cQuery2 += CRLF+ "                             '2','2-EXCLUอDO' ," 
cQuery2 += CRLF+ "                             '3','3-ENVIADO INCLUSรO' ," 
cQuery2 += CRLF+ "                             '4','4-ENVIADO ALTERAวรO' ," 
cQuery2 += CRLF+ "                             '5','5-ENVIADO EXCLUSรO' ," 
cQuery2 += CRLF+ "                             '6','6-CRITICADO INCLUSรO (FORวAR INCLUSรO)' ," 
cQuery2 += CRLF+ "                             '7','7-CRITICADO ALTERAวรO (FORวAR ALTERAวรO)' ," 
cQuery2 += CRLF+ "                             '8','8-CRITICADO EXCLUSรO (FORวAR EXCLUSรO)' ," 
cQuery2 += CRLF+ "                             '9','9-ENVIADO MUDANวA CONTRATUAL' ," 
cQuery2 += CRLF+ "                             'A','A-ENVIADO REATIVAวรO' ," 
cQuery2 += CRLF+ "                             'B','B-CRITICADO MUDANวA CONTRATUAL' ," 
cQuery2 += CRLF+ "                             'C','C-CRITICADO REATIVAวรO' ," 
cQuery2 += CRLF+ "                             'Outros - Nใo Previsto') ,"

cQuery2 += CRLF+ "CASE WHEN substr(ba1_datblo,1,6) = '"+cAnoMes+"' THEN 'Bloq Na Compt' "  
cQuery2 += CRLF+ "     WHEN substr(ba1_datblo,1,6) > '"+cAnoMes+"' THEN 'Bloq Na Compt Futura' "
cQuery2 += CRLF+ "     Else 'Bloq Na Compt Anterior' END , "                     


cQuery2 += CRLF+ " decode(trim(CASE WHEN BA1_consid = 'U' THEN NVL(BLQU.blqans, ' ' ) " 
cQuery2 += CRLF+ "                 WHEN BA1_consid = 'F' THEN NVL(BLQF.blqans, ' ' ) "
cQuery2 += CRLF+ "                 WHEN BA1_consid = 'S' THEN NVL(BLQS.blqans, ' ' ) "
cQuery2 += CRLF+ "            Else 'S/Descri็ao' END),null,'Bloq Temp','Bloq Def')  , "
//cQuery2 += CRLF+ "BA1.BA1_INCANS , BA1.BA1_EXCANS , BA1.BA1_ENVANS " 
cQuery2 += CRLF+ " decode(ba1_locsib,'2', BA1.BA1_ENVANS,' ') "
cQuery2 += CRLF+ " ORDER BY 4"
 
 
//-----------inclusoes  

cQuery3 :=" select BA1_CODEMP codemp , "
cQuery3 += CRLF+ " DECODE(NVL(PD5_CRITIC,' ') ,'T', 'Com critica','F','Sem Critica' , 'Sem Reg')  CRIT_ENVIO, "
cQuery3 += CRLF+ " DECODE(TRIM(BA1_CODCCO),'' ,'Sem CCo', 'Com CCo') CCO   , " 
cQuery3 += CRLF+ " DECODE(trim(SUBSTR(BA1_DATBLO,1,6)), '', 'Nao Excl',TRIM(SUBSTR(BA1_DATINC,1,6)),'Excl no Mes','Excl fora do Mes') EXCL," 
cQuery3 += CRLF+ " NVL(PD5.PD5_TPENVI,'') TPENV," 
cQuery3 += CRLF+ " DECODE(NVL(SIB_SITUAC,' '),'1', 'Ans Ativo' ,'2', 'Ans Inativo' , 'Nใo Enviado') SIT_ANS ,"  
cQuery3 += CRLF+ " NVL(TRIM(PD5.PD5_TPENVI),'Nao Enviado') TPENVI ,    
cQuery3 += CRLF+ " nvl(PD5_CRIANS, 'Nao Enviado')  CRIANS , "           
cQuery3 += CRLF+ " DECODE(BA1_LOCSIB,'0','0-Hแ ENVIAR' ," 
cQuery3 += CRLF+ "                   '1','1-ATIVO' ," 
cQuery3 += CRLF+ "                   '2','2-EXCLUอDO' ," 
cQuery3 += CRLF+ "                   '3','3-ENVIADO INCLUSรO' ," 
cQuery3 += CRLF+ "                   '4','4-ENVIADO ALTERAวรO' ," 
cQuery3 += CRLF+ "                   '5','5-ENVIADO EXCLUSรO' ," 
cQuery3 += CRLF+ "                   '6','6-CRITICADO INCLUSรO (FORวAR INCLUSรO)' ," 
cQuery3 += CRLF+ "                   '7','7-CRITICADO ALTERAวรO (FORวAR ALTERAวรO)' ," 
cQuery3 += CRLF+ "                   '8','8-CRITICADO EXCLUSรO (FORวAR EXCLUSรO)' ," 
cQuery3 += CRLF+ "                   '9','9-ENVIADO MUDANวA CONTRATUAL' ," 
cQuery3 += CRLF+ "                   'A','A-ENVIADO REATIVAวรO' ," 
cQuery3 += CRLF+ "                   'B','B-CRITICADO MUDANวA CONTRATUAL' ," 
cQuery3 += CRLF+ "                   'C','C-CRITICADO REATIVAวรO' ," 
cQuery3 += CRLF+ "                   'Outros - Nใo Previsto') STCAB ,"
cQuery3 += CRLF+ " COUNT(*)"
cQuery3 += CRLF+ "  from " + RetSqlName("BA1") +"  BA1 , " + RetSqlName("PD5") +" PD5 ,"
If cEmpAnt == '01'                   
   cQuery3 += CRLF+ "  CONFSIB_CAB SIB "
Else          
   cQuery3 += CRLF+ "  CONFSIB_INT SIB "
EndIf     
cQuery3 += CRLF+ " where BA1_FILIAL = '"+xFilial('BA1')+ "'      and BA1.D_E_L_E_T_ = ' ' "
cQuery3 += CRLF+ "   and PD5_FILIAL(+) = '"+xFilial('PD5')+ "'   and PD5.D_E_L_E_T_(+) = ' '" 
cQuery3 += CRLF+ "   AND (BA1_DATINC  >= '"+cAnoMes+"01'  AND BA1_DATINC <= '"+cAnoMes+"31' ) " 
cQuery3 += CRLF+ "   and BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG||BA1_DIGITO = SIB_MATRIC(+)" 
cQuery3 += CRLF+ "   and BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG||BA1_DIGITO = PD5_MATRIC(+)"
cQuery3 += CRLF+ "   group by BA1_CODEMP ,"
cQuery3 += CRLF+ "            DECODE(NVL(PD5_CRITIC,' ') ,'T', 'Com critica','F','Sem Critica' , 'Sem Reg') ,"
cQuery3 += CRLF+ "            DECODE(TRIM(BA1_CODCCO),'' ,'Sem CCo', 'Com CCo') ,"  
cQuery3 += CRLF+ "            DECODE(trim(SUBSTR(BA1_DATBLO,1,6)), '', 'Nao Excl',TRIM(SUBSTR(BA1_DATINC,1,6)),'Excl no Mes','Excl fora do Mes')," 
cQuery3 += CRLF+ "            NVL(PD5.PD5_TPENVI,'') ,"
cQuery3 += CRLF+ "            DECODE(NVL(SIB_SITUAC,' '),'1', 'Ans Ativo' ,'2', 'Ans Inativo' , 'Nใo Enviado') ," 
//cQuery3 += CRLF+ "            DECODE(TRIM(PD5.PD5_CRITIC),'' , 'Nao Enviado','T','Com Critica', 'Sem Critica') ,"
cQuery3 += CRLF+ "            NVL(TRIM(PD5.PD5_TPENVI),'Nao Enviado'),"  
cQuery3 += CRLF+ "            nvl(PD5_CRIANS, 'Nao Enviado'), "                                                   
cQuery3 += CRLF+ "            DECODE(BA1_LOCSIB,'0','0-Hแ ENVIAR' ," 
cQuery3 += CRLF+ "                         '1','1-ATIVO' ," 
cQuery3 += CRLF+ "                         '2','2-EXCLUอDO' ," 
cQuery3 += CRLF+ "                         '3','3-ENVIADO INCLUSรO' ," 
cQuery3 += CRLF+ "                         '4','4-ENVIADO ALTERAวรO' ," 
cQuery3 += CRLF+ "                         '5','5-ENVIADO EXCLUSรO' ," 
cQuery3 += CRLF+ "                         '6','6-CRITICADO INCLUSรO (FORวAR INCLUSรO)' ," 
cQuery3 += CRLF+ "                         '7','7-CRITICADO ALTERAวรO (FORวAR ALTERAวรO)' ," 
cQuery3 += CRLF+ "                         '8','8-CRITICADO EXCLUSรO (FORวAR EXCLUSรO)' ," 
cQuery3 += CRLF+ "                         '9','9-ENVIADO MUDANวA CONTRATUAL' ," 
cQuery3 += CRLF+ "                         'A','A-ENVIADO REATIVAวรO' ," 
cQuery3 += CRLF+ "                         'B','B-CRITICADO MUDANวA CONTRATUAL' ," 
cQuery3 += CRLF+ "                         'C','C-CRITICADO REATIVAวรO' ," 
cQuery3 += CRLF+ "                         'Outros - Nใo Previsto')" 

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

TCQuery cQuery  New Alias (cAliastmp)   
TCQuery cQuery1 New Alias (cAliastmp1)   
TCQuery cQuery2 New Alias (cAliastmp2)   
TCQuery cQuery3 New Alias (cAliastmp3)   


(cAliastmp )->(dbGoTop()) 
(cAliastmp1)->(dbGoTop())
(cAliastmp2)->(dbGoTop())
(cAliastmp3)->(dbGoTop())

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
    @ nLin,001 PSAY "Movimemta็๕es da  Carteira da "+cEmpresa +" na Competencia " + canomes     
      nlin++
      nlin++
    @ nLin,001 PSAY ctraco80                         
      nlin++                                         
      
 While (cAliastmp3)->(!EOF())   
                   
       If Cempant =  '01' .and.(cAliastmp3)->codemp $ ('0004','0009')
          nEmp004C := nEmp004C + (cAliastmp3)->qtda
        
       ElseIf trim((cAliastmp3)->SIT_ANS) == 'Ja Enviado'  
          nJaEnv := nJaEnv+(cAliastmp3)->qtda         
             Z := Ascan(aInc, {|aInc| aInc[1] == (cAliastmp3)->TPENV})
          If Z == 0
             Aadd(aInc, {(cAliastmp3)->TPENV,(cAliastmp3)->qtda})
          Else
             aInc[Z][2] += (cAliastmp3)->qtda
          EndIf     
          
       ElseIf trim((cAliastmp3)->EXCL) == 'Excl no Mes' 
          nBloqInc := nBloqInc +(cAliastmp3)->qtda
          
       ElseIf trim((cAliastmp3)->CRITICA) == 'Com Critica'   
          nCCriInc := nCCriInc +(cAliastmp3)->qtda
             
       ElseIf trim((cAliastmp3)->CRIANS) != ''   
          nCCIncAns := nCCIncAns +(cAliastmp3)->qtda             
          
       Else
       //If trim((cAliastmp3)->SIT_ANS) == 'Nใo Enviado' 
          nAEnviar := nAEnviar +(cAliastmp3)->qtda                                     
          
       EndIf 
       
       (cAliastmp3)->(dbSkip())  
       
    EndDo                                                                  
                                                        
      @ nLin,002 PSAY "Total Incluidos   : " 
      @ nLin,025 PSAY (cAliastmp)->QtdaInc Picture "@ 999.999"      
        nlin++                
      @ nLin,001 PSAY ctraco80
        nlin++  


      nlin++                  
    @ nLin,005 PSAY "0 - Convenio de Receprocidade (Nใo Envia a Ans )        : " 
    @ nLin,065 PSAY nEmp004C Picture "@ 999.999"     
    
      nlin++                  
    @ nLin,005 PSAY "1 - Jแ Enviado                 : " 
    @ nLin,065 PSAY nJaEnv Picture "@ 999.999"     
                             
    If mv_par03 == 1

       For nI := 1 To Len(aInc)

           @ nLin,010 PSAY "Tipo de  : "  
           @ nLin,040 PSAY stod(aInc[nI][1])                  
           @ nLin,060 PSAY "Quant   : "                 
           @ nLin,070 PSAY aInc[nI][2] Picture "@ 999.999"                 
             nlin++ 
	   Next
    EndIf                                         
    
      nlin++                  
    @ nLin,005 PSAY "2 - Excluido  no Mes           : " 
    @ nLin,065 PSAY nBloqInc Picture "@ 999.999"      
                                             
      nlin++                  
    @ nLin,005 PSAY "3 - Com Critica de Envio       : " 
    @ nLin,065 PSAY nCCriInc Picture "@ 999.999"               
        
      nlin++                  
    @ nLin,005 PSAY "4 - Com Critica na ANS         : " 
    @ nLin,065 PSAY nCCIncAns Picture "@ 999.999"              

      nlin++                  
    @ nLin,005 PSAY "5 - Envia a Ans                : " 
    @ nLin,065 PSAY nAEnviar Picture "@ 999.999"                                 
      nlin++ 


  	  nlin++                                          
  	  nlin++                                           	  
 
   @ nLin,001 PSAY ctraco80  	                                                 
     nlin++
    If cempant =='01'
       @ nLin,005 PSAY "0 - Convenio de Receprocidade Empresa 0004 e 0009 na Caberj "    
         nlin++                                     
    EndIf      
    @ nLin,005 PSAY "1 - Jแ Enviado "   
      nlin++                                     
    @ nLin,005 PSAY "2 - Excluido  no Mes"    
      nlin++                                     
    @ nLin,005 PSAY "3 - Com Critica de Envio       "    
      nlin++                                     
    @ nLin,005 PSAY "4 - Com Critica na ANS         "   
      nlin++                                   
    @ nLin,005 PSAY "5 - Envia a Ans "       
      nlin++                                           
    @ nLin,001 PSAY ctraco80  	                 
      nlin++  
      
If mv_par02 == 1       
   Cabec1 := "Crit.Env     Crit ANS   Com Cco       Sts Cab              Tp Envio         Qtda"    
//            123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//                     1         2         3         4         5         6         7         8
//                          XXX       XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX   999.999.999,99 
    nlin:= 80                       
   (cAliastmp3)->(dbGoTop())                                                                  
   
    While (cAliastmp3)->(!EOF())   
       If nLin > 55 // Salto de Pแgina. Neste caso o formulario tem 55 linhas...
	      nLin :=	Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)        
	      nLin ++
	    Endif   

        @ nLin,001 PSAY (cAliastmp3)->CRIT_ENVIO       
        @ nLin,014 PSAY (cAliastmp3)->CRIANS                                     
        @ nLin,025 PSAY (cAliastmp3)->CCO                  
        @ nLin,039 PSAY substr((cAliastmp3)->stcab,1,20)                  
        @ nLin,060 PSAY (cAliastmp3)-TPENV     
        @ nLin,075 PSAY (cAliastmp3)->qtda Picture "@ 9.999"                 
          nlin++       

        (cAliastmp2)->(dbSkip())  
       
    EndDo
      nlin++
    @ nLin,001 PSAY ctraco80  	                 
    
      nlin++                                     
EndIf                                                                    
                     

        
 /////   Impressao das Exclusoes  
  
    @ nLin,002 PSAY "Total Exuidos   : " 
    @ nLin,025 PSAY (cAliastmp1)->Qtdadel Picture "@ 999.999"     
      nlin++        
    @ nLin,001 PSAY ctraco80
      nlin++        
  
    While (cAliastmp2)->(!EOF())   
                   
       If Cempant =  '01' .and.(cAliastmp2)->codemp $ ('0004','0009')
          nEmp004I := nEmp004I + (cAliastmp2)->qtda
        
       ElseIf trim((cAliastmp2)->BLOANS) == 'Bloq Temp'  
          nBlqTemp := nBlqTemp+(cAliastmp2)->qtda         
          
       ElseIf trim((cAliastmp2)->No_Mes_Incl) == '2-Sim' 
          nBloqMes := nBloqMes +(cAliastmp2)->qtda
          
       ElseIf trim((cAliastmp2)->COMCCO) == 'Sem CCo' 
          nComCco := nComCco +(cAliastmp2)->qtda 
          
       ElseIf trim((cAliastmp2)->Envia) == 'NAO ENVIA' 
          nNaoEnvia := nNaoEnvia +(cAliastmp2)->qtda                                     
          
       ElseIf trim((cAliastmp2)->STCAB) == '2-EXCLUอDO' 
          nSTCABEX := nSTCABEX +(cAliastmp2)->qtda                                                                   
          Z := Ascan(aExc, {|aExc| aExc[1] == (cAliastmp2)->ENVANS})
          If Z == 0
             Aadd(aExc, {(cAliastmp2)->ENVANS,(cAliastmp2)->qtda})
          Else
             aExc[Z][2] += (cAliastmp2)->qtda
          EndIf      
          
       Else             
           nSTCABNEX := nSTCABNEX +(cAliastmp2)->qtda  
       EndIf     

       (cAliastmp2)->(dbSkip())  
       
    EndDo                                            
    
      nlin++                  
    @ nLin,005 PSAY "0 - Convenio de Receprocidade (Nใo Envia a Ans )        : " 
    @ nLin,065 PSAY nEmp004I Picture "@ 999.999"     
    
      nlin++                  
    @ nLin,005 PSAY "1 - Bloqueios Temporaris (Nใo Envia a Ans - Bloq Temp)  : " 
    @ nLin,065 PSAY nBlqTemp Picture "@ 999.999"     
     
      nlin++                  
    @ nLin,005 PSAY "2 - Bloqueios No Mes da Incl (Nใo Envia a Ans - 2-Sim)  : " 
    @ nLin,065 PSAY nBloqMes Picture "@ 999.999"      
    
      nlin++                  
    @ nLin,005 PSAY "3 - Bloqueados Sem CCo (Nใo Envia a Ans - Sem CCo)      : " 
    @ nLin,065 PSAY nComCco Picture "@ 999.999"               
        
      nlin++                  
    @ nLin,005 PSAY "4 - Nใo Enviados (Nใo Envia a Ans - NAO ENVIA)          : " 
    @ nLin,065 PSAY nNaoEnvia Picture "@ 999.999"              

    nlin++                  
    @ nLin,005 PSAY "5 - Verificar Bloqueados ,(Nใo Envia a Ans - Variaveis ): " 
    @ nLin,065 PSAY nSTCABNEX Picture "@ 999.999"               
    
      nlin++                  
    @ nLin,005 PSAY "6 - Enviados Bloqueio (Envia a Ans)                     : " 
    @ nLin,065 PSAY nSTCABEX Picture "@ 999.999"                                 
      nlin++ 
                     
    If mv_par03 == 1
       For nI := 1 To Len(aExc)

           @ nLin,010 PSAY " Data de Envia a Ans   : "  
           @ nLin,040 PSAY stod(aExc[nI][1])                  
           @ nLin,060 PSAY "Quant   : "                 
           @ nLin,070 PSAY aExc[nI][2] Picture "@ 999.999"                 
             nlin++ 
	   Next
    EndIf 
/*      nlin++                  
    @ nLin,015 PSAY "Enviados Bloqueio (Envia a Ans)                       : " 
    @ nLin,071 PSAY nSTCABNEX Picture "@ 999.999"     
  */               
       
  	  nlin++                                          
  	  nlin++                                           	  
 
   @ nLin,001 PSAY ctraco80  	                                                 
     nlin++
    If cempant =='01'
       @ nLin,005 PSAY "0 - Convenio de Receprocidade Empresa 0004 e 0009 na Caberj "    
         nlin++                                     
    EndIf      
    @ nLin,005 PSAY "1 - Bloqueio temporario "   
      nlin++                                     
    @ nLin,005 PSAY "2 - Bloqueio no mesmo Mes Da Inclusใo"    
      nlin++                                     
    @ nLin,005 PSAY "3 - Sem Codigo de CCO       "    
      nlin++                                     
    @ nLin,005 PSAY "4 - Marcado para Nใo Enviar "   
      nlin++                                   
    @ nLin,005 PSAY "5 - Bom para Envio mas NรO  enviado , Verificar "       
      nlin++
    @ nLin,005 PSAY "6 - Envioado o Bloqueio "       
      nlin++                                           
    @ nLin,001 PSAY ctraco80  	                 
      nlin++  




      
If mv_par02 == 1       
   Cabec1 := "M.Incl   Envia ?    Com Cco   Sts Cab              Tipo bloq   Dt Env Ans   Qtda"    
//         1234567890123456789012345678901234567890123456789012345678901234567890012345678901234567890
//                  1         2         3         4         5         6          7         8
//                          XXX       XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX   999.999.999,99 
    nlin:= 80                       
   (cAliastmp2)->(dbGoTop())                                                                  
   
    While (cAliastmp2)->(!EOF())   
       If nLin > 55 // Salto de Pแgina. Neste caso o formulario tem 55 linhas...
	      nLin :=	Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)        
	      nLin ++
	    Endif   

        @ nLin,001 PSAY (cAliastmp2)->NO_MES_INCL         
        @ nLin,010 PSAY (cAliastmp2)->ENVIA                                     
        @ nLin,021 PSAY (cAliastmp2)->COMCCO                  
        @ nLin,031 PSAY substr((cAliastmp2)->stcab,1,20)                  
        @ nLin,052 PSAY (cAliastmp2)->bloans     
        @ nLin,064 PSAY stod((cAliastmp2)->Envans)                
        @ nLin,075 PSAY (cAliastmp2)->qtda Picture "@ 9.999"                 
          nlin++       

        (cAliastmp2)->(dbSkip())  
       
    EndDo
      nlin++
    @ nLin,001 PSAY ctraco80  	                 
    
      nlin++                                     
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
cPerg := PADR(cPerg,10)

aAdd(aRegs,{cPerg,"01","Mes/Ano                ?","","","mv_ch1","C",07,0,0,"G","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "99/9999", "" })
aadd(aRegs,{cPerg,"02","Detalhar Carteira      ?","","","mv_ch2","N", 1,0,0,"C","","mv_par02","Sim","","","","","Nao","","","","","","","","","","","","","","","","","" , "" ,""  , "", "", "" })
aadd(aRegs,{cPerg,"03","Detalhar Moviment      ?","","","mv_ch3","N", 1,0,0,"C","","mv_par03","Sim","","","","","Nao","","","","","","","","","","","","","","","","","" , "" ,""  , "", "", "" })

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

