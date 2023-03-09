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
User Function CABR263a()  

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Declaracao de Variaveis                                             ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

Local cDesc1         := "Este programa tem como objetivo imprimir relatorio "
Local cDesc2         := "Evolucao da movimenta็ใo ANS X caberj / integral"
Local cDesc3         := " "
Local cPict          := ""
Local titulo         := "Evolucao da movimentacao ANS  "

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
Private nomeprog     := "CABR263a"
Private nTipo        := 15
Private aReturn      := { "Zebrado", 1, "Administracao", 1, 2, 1, "", 1}
Private nLastKey     := 0
Private cbtxt        := Space(10)
Private cbcont       := 00
Private CONTFL       := 01
Private m_pag        := 01
Private wnrel        := "CABR263a"
Private cString      := "SE2"
Private cPerg        := "CABR263A  "
Private valor_tot    := 0.00  
Private valor_col    := 0.00                                                                      
Private cquebra      := " "        
Private cttitpgto    := ' '   
private cqtdavend    := 0 
private ctraco80     := replicate("_",080)  
Private lflagtot     :=.F.    
private lflagMM      :=.F.
private nTtotAti     := 0             
Private cAliastmp    := GetNextAlias()
Private cAliastmp0   := GetNextAlias()
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
Private cQuery0       := " "   
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

private nTotIncAt := 0 
private nTotIncRj := 0
private nTotCancAt:= 0
private nTotCancRj:= 0                             

private nCancEnv :=0 
private nCancNEnv:=0                                    
private nCancTot :=0                                   

private nInclEnv :=0 
private nInclNEnv:=0 
private nInclTot :=0

private nAcatado := 0
private nNAcatado:= 0
private nTotInc  := 0
 
private nAcatadob := 0
private nNAcatadob:= 0
private nTotIncb  := 0

private nTotintC   := 0
private nTotintA   := 0

private cmes:= val(substr(mv_par01,4,2))
private cano:= val(substr(mv_par01,7,4))   
Private cAnoMesatu      :=substr(mv_par01,7,4)+substr(mv_par01,4,2)      
Private cAnoMesant      :=fCCompAnt(cano,cmes)

Private cAnoMesa      := str(iif(cmes==01,cano-1, cano),4)+strzero(iif(cmes==01,12,(cmes-1)),2)  
Private cAnoMesa1     := strzero((cano-1),4)+strzero((cmes),2) 
PRIVATE cEmpresa      :=  Iif(cEmpAnt == '01', 'Caberj ', 'Integral')
PRIVATE cCodEmp       :=  Iif(cEmpAnt == '01', 'C', 'I')
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
///--------------------Valida Competencia ---------------------                                                    
    
     
///---- BASE ANS     

If cEmpAnt == '02'
   cQuery := "select count(*) qtda from confsib_int , BA1020 BA1  where  sib_situac = '1'    " 
   cQuery += "  AND BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG||BA1_DIGITO = SIB_MATRIC " 
   cQuery += "  and ba1.D_E_L_E_T_ = ' ' and ba1_filial = ' ' "  
Else 
   cQuery := "select count(*) qtda from confsib_CAB , BA1010 BA1  where  sib_situac = '1'    " 
   cQuery += "  AND BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG||BA1_DIGITO = SIB_MATRIC " 
   cQuery += "  and ba1.D_E_L_E_T_ = ' ' and ba1_filial = ' ' "  
EndIf              
   cQuery4:= " select * from siga.SOMA_CONF_ANS where sca_emp = '"+cEmpAnt+"' and  sca_comp = '"+ cAnoMesant +"'  " 

//----- base total operara inicial --  

cQuery1 := "SELECT count(*)	QTDA "
cQuery1 += CRLF+ " from  " + RetSqlName("BA1") +" BA1 ," + RetSqlName("BA3") +" BA3  "
cQuery1 += CRLF+ " where BA1_FILIAL = '"+xFilial('BA1')+ "' and BA1.D_E_L_E_T_ = ' ' "    
cQuery1 += CRLF+ " AND   BA3_FILIAL = '"+xFilial('BA3')+ "' and BA3.D_E_L_E_T_ = ' ' "    
 
cQuery1 += CRLF+ " AND  BA1_CODINT=BA3_CODINT"  
cQuery1 += CRLF+ " AND  BA1_CODEMP=BA3_CODEMP"  
cQuery1 += CRLF+ " AND  BA1_MATRIC=BA3_MATRIC"

If cEmpAnt == '01'
   cQuery1 += CRLF+ " AND  ba1_codemp not in ('0004','0009')"  
EndIf 
                                                                                                      
cQuery1 += CRLF+ " AND  VERIFBLOQANS_MS (BA1_CODINT, BA1_CODEMP, BA1_MATRIC, BA1_TIPREG,To_Char(to_date('"+Mv_par02+"','dd/mm/yyyy'),'YYYYMMDD'),'"+cCodEmp+"')=0  
cQuery1 += CRLF+ " AND  TO_DATE(Trim(BA1_DATINC),'YYYYMMDD') < to_date('"+Mv_par02+"','dd/mm/yyyy')   

cQuery1 += CRLF+ " AND   decode(ba1_atusib,'0','NAO ENVIA',decode(ba1_infsib,'0','NAO ENVIA',decode(ba1_infans,'0','NAO ENVIA','ENVIA')))='ENVIA' "


cQuery1 += CRLF+ " AND  BA1_CONEMP<>' '  
            
      
//-----------base caberj  seus status compossicao da carteira  ----

cQuery2 :=" SELECT decode(PD5_ENVIAD,'F', 'Nao Enviado', 'T','Enviado' , 'nao classif') titulo , count(*) qtda"
cQuery2 += CRLF+ " from  " + RetSqlName("BA1") +" BA1 ," + RetSqlName("BA3") +" BA3  , " + RetSqlName("PD5") +" PD5 "

cQuery2 += CRLF+ " where BA1_FILIAL = '"+xFilial('BA1')+ "' and BA1.D_E_L_E_T_ = ' ' "    
cQuery2 += CRLF+ " AND   BA3_FILIAL = '"+xFilial('BA3')+ "' and BA3.D_E_L_E_T_ = ' ' "     
cQuery2 += CRLF+ " AND   PD5_FILIAL = '"+xFilial('PD5')+ "' and PD5.D_E_L_E_T_ = ' ' "    
cQuery2 += CRLF+ " AND   BA1_CODINT=BA3_CODINT  
cQuery2 += CRLF+ " AND   BA1_CODEMP=BA3_CODEMP  
cQuery2 += CRLF+ " AND   BA1_MATRIC=BA3_MATRIC  
cQuery2 += CRLF+ " AND   VERIFBLOQANS_MS (BA1_CODINT, BA1_CODEMP, BA1_MATRIC, BA1_TIPREG,To_Char(to_date('"+Mv_par02+"','dd/mm/yyyy'),'YYYYMMDD'),'"+cCodEmp+"')=0  
cQuery2 += CRLF+ " AND   TO_DATE(Trim(BA1_DATINC),'YYYYMMDD') >= to_date('"+Mv_par01+"','dd/mm/yyyy')   
cQuery2 += CRLF+ " AND   TO_DATE(Trim(BA1_DATINC),'YYYYMMDD') < to_date('"+Mv_par02+"','dd/mm/yyyy') 
cQuery2 += CRLF+ " AND   BA1_CONEMP<>' '
            
cQuery2 += CRLF+ " AND   PD5_MATRIC = BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG||BA1_DIGITO
cQuery2 += CRLF+ " AND   PD5_COMPTE >= '"+cAnoMesant+"'" 
cQuery2 += CRLF+ " AND   PD5_TPENVI = 'Sib Mensal' 
cQuery2 += CRLF+ " AND   pd5_tpacao = 'INCL'
cQuery2 += CRLF+ " AND   BA1.D_E_L_E_T_= ' '  
cQuery2 += CRLF+ " AND   BA3.D_E_L_E_T_= ' '
cQuery2 += CRLF+ " AND   PD5.D_E_L_E_T_= ' '
cQuery2 += CRLF+ " group by decode(PD5_ENVIAD,'F', 'Nao Enviado', 'T','Enviado' , 'nao classif')
 
//-----opera-- bloqueadas     

cQuery3 := CRLF+ " SELECT  decode(nvl(sib_situac,''),'1' ,'Nใo Acatado' ,'3', 'Acatado','Sem Ans') estatus,"
cQuery3 += CRLF+ " count(*)  qtda"                                                                                   
cQuery3 += CRLF+ " from  " + RetSqlName("BA1") +" BA1 ," + RetSqlName("BA3") +" BA3  , "

If cEmpAnt == '02'
   cQuery3 += CRLF+ " confsib_int" 
Else    
   cQuery3 += CRLF+ " confsib_cab" 
EndIf   
cQuery3 += CRLF+ " where BA1_FILIAL = '"+xFilial('BA1')+ "' and BA1.D_E_L_E_T_ = ' ' "    
cQuery3 += CRLF+ " AND   BA3_FILIAL = '"+xFilial('BA3')+ "' and BA3.D_E_L_E_T_ = ' ' "     

cQuery3 += CRLF+ " AND  BA1_CODINT=BA3_CODINT  "
cQuery3 += CRLF+ " AND  BA1_CODEMP=BA3_CODEMP  "
cQuery3 += CRLF+ " AND  BA1_MATRIC=BA3_MATRIC  "
cQuery3 += CRLF+ " and ba1_codcco = sib_codcco(+) "
cQuery3 += CRLF+ " AND  VERIFBLOQANS_MS (BA1_CODINT, BA1_CODEMP, BA1_MATRIC, BA1_TIPREG,To_Char(to_date('"+Mv_par01+"','dd/mm/yyyy'),'YYYYMMDD'),'"+cCodEmp+"')=0  "
cQuery3 += CRLF+ " AND  TO_DATE(Trim(BA1_DATblo),'YYYYMMDD') >= to_date('"+Mv_par01+"','dd/mm/yyyy')   "
cQuery3 += CRLF+ " AND  TO_DATE(Trim(BA1_DATblo),'YYYYMMDD') < to_date('"+Mv_par02+"','dd/mm/yyyy')    "
cQuery3 += CRLF+ " AND  BA1_CONEMP<>' '                                                                "
cQuery3 += CRLF+ " AND  BA1.D_E_L_E_T_= ' '                                                            "
cQuery3 += CRLF+ " AND  BA3.D_E_L_E_T_= ' '                                                            "
cQuery3 += CRLF+ " group by sib_situac , decode(nvl(sib_situac,''),'1' ,'Nใo Acatado' ,'3', 'Acatado','Sem Ans') "  

cQuery4:= " select * from siga.SOMA_CONF_ANS where sca_emp = '"+cEmpAnt+"' and  sca_comp = '"+ cAnoMesant +"'  " 
    
//------------------------------------    
cQuery5 := CRLF+ "select pd5_tpacao , pd5_critic ,pd5_crians, decode(trim(pd5_datret),'','NEnv','Env') enviad , count(*) qtda "
cQuery5 += CRLF+ "  from " + RetSqlName("PD5") +" PD5  where PD5_FILIAL = '"+xFilial('PD5')+ "' and PD5.D_E_L_E_T_ = ' ' "  
cQuery5 += CRLF+ "  and pd5_compte = '"+ cAnoMesatu+"' and pd5_tpacao in ('INCL','CANC','REAT') "
cQuery5 += CRLF+ " group by pd5_tpacao , pd5_critic ,pd5_crians, decode(trim(pd5_datret),'','NEnv','Env') "
cQuery5 += CRLF+ " order by 1,2,4 "       
                                                                                                                 
cQuery6:= " select * from siga.SOMA_CONF_ANS where sca_emp = '"+cEmpAnt+"' and  sca_comp = '"+ cAnoMesatu +"'  " 

///////////////////////////////

cQuery7 := CRLF+ " SELECT SIB_MATRIC Matric , SIB_CODCCO CODCCO ,BA1_LOCSIB , BA1_DATBLO  , BA1_INFANS " 
cQuery7 += CRLF+ "   FROM  " 
If cEmpAnt == '02'
   cQuery7 += CRLF+ " confsib_int" 
Else    
   cQuery7 += CRLF+ " confsib_cab" 
EndIf   
cQuery7 += CRLF+ " ," + RetSqlName("BA1") +" BA1 "
cQuery7 += CRLF+ "  WHERE SIB_SITUAC = '1' "
cQuery7 += CRLF+ "    AND BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG||BA1_DIGITO = SIB_MATRIC " 
cQuery7 += CRLF+ "    AND BA1.D_E_L_E_T_ = ' ' AND BA1_FILIAL = '"+xFilial('BA1')+ "'  "
cQuery7 += CRLF+ "          
cQuery7 += CRLF+ "         MINUS "
cQuery7 += CRLF+ "          
cQuery7 += CRLF+ " SELECT  BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG||BA1_DIGITO  MATRIC_CABERJ , BA1_CODCCO   ,BA1_LOCSIB , BA1_DATBLO , BA1_INFANS "
cQuery7 += CRLF+ "   FROM  " + RetSqlName("BA1") +" BA1 , " + RetSqlName("BA3") +" BA3 " 
cQuery7 += CRLF+ "  WHERE  BA1_FILIAL='"+xFilial('BA1')+ "'  "
cQuery7 += CRLF+ "    AND  BA3_FILIAL='"+xFilial('BA3')+ "'  "
cQuery7 += CRLF+ "    AND  BA1_CODINT=BA3_CODINT " 
cQuery7 += CRLF+ "    AND  BA1_CODEMP=BA3_CODEMP " 
cQuery7 += CRLF+ "    AND  BA1_MATRIC=BA3_MATRIC " 
cQuery7 += CRLF+ "    
If cEmpAnt == '01'
   cQuery7 += CRLF+ "         AND BA1_CODEMP NOT IN ('0004','0009') "
EndIf 	  
cQuery7 += CRLF+ "    AND  DECODE(BA1_ATUSIB,'0','NAO ENVIA',DECODE(BA1_INFSIB,'0','NAO ENVIA',DECODE(BA1_INFANS,'0','NAO ENVIA','ENVIA')))='ENVIA' "
cQuery7 += CRLF+ "    AND  VERIFBLOQANS_MS (BA1_CODINT, BA1_CODEMP, BA1_MATRIC, BA1_TIPREG,TO_CHAR(TO_DATE('"+Mv_par02+"','dd/mm/yyyy'),'YYYYMMDD'),'"+cCodEmp+"')=0  "
cQuery7 += CRLF+ "    AND  TO_DATE(TRIM(BA1_DATINC),'YYYYMMDD') <= TO_DATE('"+Mv_par02+"','dd/mm/yyyy') " 
cQuery7 += CRLF+ "    AND  BA1_CONEMP<>' '  "
cQuery7 += CRLF+ "    AND  BA1.D_E_L_E_T_= ' ' " 
cQuery7 += CRLF+ "    AND  BA3.D_E_L_E_T_= ' ' "

//////
cQuery8 := CRLF+ " SELECT  BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG||BA1_DIGITO  MATRIC , BA1_CODCCO  CODCCO ,BA1_LOCSIB , BA1_DATBLO , BA1_INFANS "
cQuery8 += CRLF+ "   FROM  " + RetSqlName("BA1") +" BA1 , " + RetSqlName("BA3") +" BA3 " 
cQuery8 += CRLF+ "  WHERE  BA1_FILIAL='"+xFilial('BA1')+ "'  "
cQuery8 += CRLF+ "    AND  BA3_FILIAL='"+xFilial('BA3')+ "'  "
cQuery8 += CRLF+ "    AND  BA1_CODINT=BA3_CODINT " 
cQuery8 += CRLF+ "    AND  BA1_CODEMP=BA3_CODEMP " 
cQuery8 += CRLF+ "    AND  BA1_MATRIC=BA3_MATRIC " 
cQuery8 += CRLF+ "    
If cEmpAnt == '01'
   cQuery8 += CRLF+ "         AND BA1_CODEMP NOT IN ('0004','0009') "
EndIf 	  
cQuery8 += CRLF+ "    AND  DECODE(BA1_ATUSIB,'0','NAO ENVIA',DECODE(BA1_INFSIB,'0','NAO ENVIA',DECODE(BA1_INFANS,'0','NAO ENVIA','ENVIA')))='ENVIA' "
cQuery8 += CRLF+ "    AND  VERIFBLOQANS_MS (BA1_CODINT, BA1_CODEMP, BA1_MATRIC, BA1_TIPREG,TO_CHAR(TO_DATE('"+Mv_par02+"','dd/mm/yyyy'),'YYYYMMDD'),'"+cCodEmp+"')=0  "
cQuery8 += CRLF+ "    AND  TO_DATE(TRIM(BA1_DATINC),'YYYYMMDD') <= TO_DATE('"+Mv_par02+"','dd/mm/yyyy') " 
cQuery8 += CRLF+ "    AND  BA1_CONEMP<>' '  "
cQuery8 += CRLF+ "    AND  BA1.D_E_L_E_T_= ' ' " 
cQuery8 += CRLF+ "    AND  BA3.D_E_L_E_T_= ' ' "

cQuery8 += CRLF+ "         MINUS "

cQuery8 += CRLF+ " SELECT SIB_MATRIC , SIB_CODCCO ,BA1_LOCSIB , BA1_DATBLO  , BA1_INFANS " 
cQuery8 += CRLF+ "   FROM  " 
If cEmpAnt == '02'
   cQuery8 += CRLF+ " confsib_int" 
Else    
   cQuery8 += CRLF+ " confsib_cab" 
EndIf   
cQuery8 += CRLF+ " ," + RetSqlName("BA1") +" BA1 "
cQuery8 += CRLF+ "  WHERE SIB_SITUAC = '1' "
cQuery8 += CRLF+ "    AND BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG||BA1_DIGITO = SIB_MATRIC " 
cQuery8 += CRLF+ "    AND BA1.D_E_L_E_T_ = ' ' AND BA1_FILIAL = '"+xFilial('BA1')+ "'  "




//////
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

If Select((cAliastmp7)) <> 0 
   (cAliastmp6)->(DbCloseArea())  
Endif                          

If Select((cAliastmp8)) <> 0 
   (cAliastmp6)->(DbCloseArea())  
Endif                          
TCQuery cQuery  New Alias (cAliastmp)   
TCQuery cQuery1 New Alias (cAliastmp1)   
TCQuery cQuery2 New Alias (cAliastmp2)   
TCQuery cQuery3 New Alias (cAliastmp3)    
TCQuery cQuery4 New Alias (cAliastmp4)    
TCQuery cQuery5 New Alias (cAliastmp5)   
TCQuery cQuery6 New Alias (cAliastmp6)  
TCQuery cQuery7 New Alias (cAliastmp7) 
TCQuery cQuery8 New Alias (cAliastmp8)  

(cAliastmp )->(dbGoTop()) 
(cAliastmp1)->(dbGoTop())
(cAliastmp2)->(dbGoTop())
(cAliastmp3)->(dbGoTop())  
(cAliastmp4)->(dbGoTop()) 
(cAliastmp5)->(dbGoTop()) 
(cAliastmp6)->(dbGoTop())
(cAliastmp7)->(dbGoTop())
(cAliastmp8)->(dbGoTop())

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
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ         &
	//ณ Impressao do cabecalho do relatorio. . .                            ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู  
	//identificacao da empresa (contratante)
	
	fCargaVlr()
	
    
   @ nLin,001 PSAY     "                               EXTRATO SIB   "     
    nlin++
    @ nLin,001 PSAY ctraco80 
    nlin++   
   //                          1         2         3         4         5         6         7
//                      12345678901234567890123456789012345678901234567890123456789012345678901234567890
   if cEmpAnt == '01'      
	  @ nLin,001  PSAY "            CABERJ                                     ANS                      " 
	Else                                                                                                  
	  @ nLin,001  PSAY "           INTEGRAL                                    ANS                      " 
	EndIf   	                   

	  nlin++ 
      nlin++   	           
                                                        
    @ nLin,001 PSAY "Compet๊ncia: "
    @ nLin,032 PSAY  substr(mv_par01,4,2)+'/'+substr(mv_par01,7,4)          
    @ nLin,040 PSAY "Compet๊ncia: "
    @ nLin,073 PSAY  substr(mv_par01,4,2)+'/'+substr(mv_par01,7,4)         
    
      nlin++  
    
    @ nLin,001 PSAY "Posi็ใo inicial ATIVOS:"  
    @ nLin,034 PSAY (cAliastmp1)->QTDA Picture "@ 999.999" 
    @ nLin,040 PSAY "Posi็ใo inicial ATIVOS:"
    @ nLin,075 PSAY (cAliastmp4)->SCA_QTDA Picture "@ 999.999"
    
      nlin++             

    @ nLin,001 PSAY "Inclus๕es:"
    @ nLin,034 PSAY nTotInc Picture "@ 999.999"
    @ nLin,040 PSAY "Inclus๕es:"
    @ nLin,074 PSAY  nInclTot Picture "@ 999.999"
      
      nlin++                       

    @ nLin,001 PSAY "Enviadas:"
    @ nLin,034 PSAY nAcatado Picture "@ 999.999"
    @ nLin,040 PSAY "Acatados : "
    @ nLin,074 PSAY  nInclEnv Picture "@ 999.999"

      nlin++  
      
    @ nLin,001 PSAY "Nใo Enviadas:"
    @ nLin,034 PSAY nNAcatado Picture "@ 999.999"
    @ nLin,040 PSAY "Nใo Acatados:"
    @ nLin,074 PSAY nInclNEnv Picture "@ 999.999"

      nlin++   
      
    @ nLin,001 PSAY "Exclus๕es:"
    @ nLin,034 PSAY nTotIncb Picture "@ 999.999"
    @ nLin,040 PSAY "Exclus๕es: " 
    @ nLin,074 PSAY nCancTot Picture "@ 999.999"
    
      nlin++                       

    @ nLin,001 PSAY "Enviadas:"
    @ nLin,034 PSAY nAcatadob Picture "@ 999.999"
    @ nLin,040 PSAY "Acatados : "
    @ nLin,074 PSAY nCancEnv Picture "@ 999.999"
    
      nlin++  
      
    @ nLin,001 PSAY "Nใo Enviadas:"
    @ nLin,034 PSAY nNAcatadob Picture "@ 999.999"
    @ nLin,040 PSAY "Nใo Acatados:  "
    @ nLin,074 PSAY nCancNEnv Picture "@ 999.999"
    
      nlin++                      
                                  
    @ nLin,001 PSAY "Posi็ใo Final:" 
    @ nLin,034 PSAY ((cAliastmp1)->QTDA + nAcatado )- nAcatadob Picture "@ 999.999"
    @ nLin,040 PSAY "Posi็ใo Final:"
    @ nLin,075 PSAY (cAliastmp6)->SCA_QTDA Picture "@ 999.999"
      nlin++           
  /*    
    @ nLin,001 PSAY "Bloqueios  Definitivos:"
    @ nLin,034 PSAY "    0" 
    @ nLin,040 PSAY "Bloqueios  Definitivos:"
    @ nLin,075 PSAY "    0"
      nlin++              
  */    
    @ nLin,001 PSAY ctraco80 
      nlin++
nLin := 56    

titulo         := "Ativos ANS - Inativos "+cEmpresa   

Cabec1         := "Matricula           Nome                                   Cod CCo"                                           
//                       12345678901234567890123456789012345678901234567890123456789001234567890
//                       0        1         2         3         4         5         6          7
//                          XXX       XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX   999.999.999,99 
//                      BK2_PROPRI||BK2_CODLAN,                                    Sum(BK2_SALDO) 
Cabec2         := " "
 
While (cAliastmp7)->(!EOF()) 
	
	If nLin > 55 // Salto de Pแgina. Neste caso o formulario tem 55 linhas...
	   nLin :=	Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)        
	   nLin ++
	Endif
      
    @ nLin,001 PSAY (cAliastmp7)->Matric
    @ nLin,021 PSAY U_fNomBa1((cAliastmp7)->Codcco,(cAliastmp7)->Matric)
    @ nLin,060 PSAY (cAliastmp7)->Codcco
    
     (cAliastmp7)->(dbSkip())                     
      nTotintA++

      nlin++           	    
    EndDo

      nlin++            
      @ nLin,001 PSAY ctraco80             
      nlin++

    @ nLin,010 PSAY "Total de Vidas ------> "
    @ nLin,035 PSAY nTotintA Picture "@ 999.999"

nLin := 56    

titulo         := "Inativos "+cEmpresa +" - Ativos ANS "   

Cabec1         := "Matricula           Nome                                   Cod CCo"                                           
//                       12345678901234567890123456789012345678901234567890123456789001234567890
//                       0        1         2         3         4         5         6          7
//                          XXX       XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX   999.999.999,99 
//                      BK2_PROPRI||BK2_CODLAN,                                    Sum(BK2_SALDO) 
Cabec2         := " "
 
While (cAliastmp8)->(!EOF()) 
	
	If nLin > 55 // Salto de Pแgina. Neste caso o formulario tem 55 linhas...
	   nLin :=	Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)        
	   nLin ++
	Endif
      
    @ nLin,001 PSAY (cAliastmp8)->Matric
    @ nLin,021 PSAY U_fNomBa1((cAliastmp8)->Codcco,(cAliastmp8)->Matric)
    @ nLin,060 PSAY (cAliastmp8)->Codcco
    
     (cAliastmp8)->(dbSkip())                     
      nTotintC++
      nlin++           	    
    EndDo
      nlin++            
      @ nLin,001 PSAY ctraco80 
      nlin++
     
                 
    @ nLin,010 PSAY "Total de Vidas ------> "
    @ nLin,035 PSAY nTotintC Picture "@ 999.999"
      
                        
                                                               

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

static function fCargaVlr()  

 nCancEnv :=0 
 nCancNEnv:=0                                    
 nCancTot :=0                                   

 nInclEnv :=0 
 nInclNEnv:=0 
 nInclTot :=0             
 
 nAcatadob  := 0             
 nNAcatadob := 0       
 nTotIncb   := 0
 
 nAcatado  :=  0
 nNAcatado :=  0      
 nTotInc   :=  0
 
    While (cAliastmp2)->(!EOF())   
           If trim((cAliastmp2)->titulo) =='Enviado'
              nAcatado := (cAliastmp2)->Qtda
           Else
              nNAcatado := (cAliastmp2)->Qtda     
           EndIf    
           nTotInc := nTotInc + (cAliastmp2)->Qtda     
           (cAliastmp2)->(dbSkip())                     
    Enddo   

    While (cAliastmp3)->(!EOF())   
    
           If trim((cAliastmp3)->estatus) =='Acatado'
              nAcatadob += (cAliastmp3)->Qtda
           Else
              nNAcatadob += (cAliastmp3)->Qtda     
           EndIf    
    
           nTotIncb := nTotIncb+ (cAliastmp3)->Qtda 
           (cAliastmp3)->(dbSkip())                     
    
    Enddo                                          

    While (cAliastmp5)->(!EOF())                    
    
           If trim((cAliastmp5)->pd5_tpacao) =='CANC' 
    
              If trim((cAliastmp5)->pd5_CRIANS) == '' 
                 nCancEnv+=(cAliastmp5)->qtda 
              Else                                     
                nCancNEnv+=(cAliastmp5)->qtda
              EndIf   
    
              nCancTot += (cAliastmp5)->Qtda
              
           ElseIf (trim((cAliastmp5)->pd5_tpacao) =='INCL' .OR.trim((cAliastmp5)->pd5_tpacao) =='REAT')
    
              If trim((cAliastmp5)->pd5_CRIANS) == '' 
                 nInclEnv+=(cAliastmp5)->qtda 
              Else                                     
                nInclNEnv+=(cAliastmp5)->qtda
              EndIf   
    
              nInclTot += (cAliastmp5)->Qtda
    
           EndIf    
    
           (cAliastmp5)->(dbSkip())                     
    
    Enddo   
                      
return()


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

aAdd(aRegs,{cPerg,"01","Data Inicial       ","","","mv_ch1","C",10,0,0,"G","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "", "" }) 
aAdd(aRegs,{cPerg,"02","Data Final         ","","","mv_ch2","C",10,0,0,"G","","mv_par02","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "", "" })

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


