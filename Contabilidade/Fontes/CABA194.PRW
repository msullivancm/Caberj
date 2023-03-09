#INCLUDE "RWMAKE.CH"
#INCLUDE "TOTVS.CH"                                                                                                                       
#Include "TopConn.ch"
#Include "TbiConn.ch"
#include "PLSMGER.CH"

#Define cCodigosPF "104,116,117,123,124,125,127,134,137,138,139,140,141,142,143,144,145,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,177"
// Static cCodDB     := PLSRETLADC()        

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ CTB_PLS  ºAutor  ³ altamiro         º Data ³  23/07/2021   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Contabilizacao CABERJ - plano dos colaboradores            ¹±±
±±º          ³                                                            ¹±±                                                                 
±±º          ³                                                            ¹±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Protheus 10 - Contabilidade - Miscelanea - Ctb. Folha View ¹±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function CABA194()

Private l_sai       := .T.
Private _ddatabase  := DDATABASE
Private _nTotal     := 0
Private _cChave     := ""
Private _cNumLote   := ""
Private l_mostra    := .T.
Private lAglutina	:= .F.
Private _dDataAnt	:= dDataBase
Private _cFilOri	:= cFilAnt
Private _cQtdlin	:= 0
Private   nContx    := 0
Private aItens      := {}
Private aCab        := {}
Private	cLote    	:= "009995"
Private cPadrao  	:= "995"
Private cPerg		:= "CABA323X"     
private cEmpresa    := Iif(cEmpAnt == '01','C','I') 

//
Public    _C_ClaVal  
Public    _C_Item     
Public    _C_cCusto   
Public    _C_VlrCol   
Public 	_cProcDoc	 

//
cHrIni	:=	time()
//
ALERT("Integracao Folha - Protheus- V. 29/Jul/2021  ")
//
//
//PutSx1( cPerg,"01","Contabilizar (Cust/Rec.)"  ,"","","mv_ch1","N",01,0,0,"C","",""   	,"","","mv_par01" ,"1 Custo     ","1 Custo"     ,"1 Custo"     ,"","2 Receita"  ,"2 Receita" ,"2 Receita",   "","3 Cancel Receita"  ,"3 Cancel Receita" ,"3 Cancel Receita" )


	Processa ({||CTBCAB194()})			
	//	
//
    dDatabase	:=	_ddatabase
//
Return()
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ CTBCAB4  º Autor ³ Altamiro        º Data ³  28/04/2020    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Contablizacao de Comissoes - provisionamento               º±±
±±º          ³                                                            º±±
±±º          ³                                                            º±±
±±º          ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SIGAFIN -                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
static Function CTBCAB194()
//
Local 	cQueryVW
Local 	cArqTMP		:= GetNextAlias()
// Local 	cQueryEv
// Local 	cArqEve		:= GetNextAlias()  
// Local 	nProc	    := 0
Private cPerg2		:= "CABA323B"
//
PutSx1( cPerg2,"01","Mostra Lancamentos?"       ,"","","mv_ch1","N",01,0,0,"C","",""   	,"","","mv_par01" ,"Sim"         ,"Sim"         ,"Sim"         ,"","Não"        ,"Não"       ,"Não" )
PutSx1( cPerg2,"02","Aglutina Lancto ?"         ,"","","mv_ch2","N",01,0,0,"C","",""   	,"","","mv_par02" ,"Sim"         ,"Sim"         ,"Sim"         ,"","Nao"        ,"Nao"       ,"Nao" )
PutSx1( cPerg2,"03","Tipo de Lancamento?"       ,"","","mv_ch3","N",01,0,0,"C","",""   	,"","","mv_par03" ,"1 Do Mes"    ,"1 Do Mes"    ,"1 Do Mes"    ,"","2 Fora Mes" ,"2 Fora Mes" ,"2 Fora Mes"," 3 Ambos"," 3 Ambos"," 3 Ambos" )
PutSx1( cPerg2,"04","Ano/Mes (AAAAMM)?"         ,"","","mv_ch4","C",06,0,0,"C","",""   	,"","","mv_par04" ,"            ",""            ,""            ,"",""           ,""          ,""         ,""         ,""         ,""      ) 
PutSx1( cPerg2,"05","Do Plano? (somente Custo)" ,"","","mv_ch5","C",04,0,0,"C","",""   	,"","","mv_par05" ,"            ",""            ,""            ,"",""           ,""          ,""         ,""         ,""         ,""      )
PutSx1( cPerg2,"06","Ate o Plano"               ,"","","mv_ch6","C",04,0,0,"C","",""   	,"","","mv_par06" ,"            ",""            ,""            ,"",""           ,""          ,""         ,""         ,""         ,""      )
//
//CHAMA OS PARAMETROS
If !Pergunte( cPerg2 , .T. )
	Return
Endif
//
cMesAno		:= MV_PAR04
cTipoMov	:= alltrim(str(MV_PAR03))
dMesProc	:= lastday(stod(mv_par04+"01"))
cPadrao     := "995"
lPadrao     := VerPadrao(cPadrao)
cMesant     := iif(substr(mv_par04,5,2)=='01','12',str(val(substr(mv_par04,5,2))-1))
cAnoant     := iif(substr(mv_par04,5,2)=='01',str(val(substr(mv_par04,1,4))-1),substr(mv_par04,1,4))
cMesant     := strzero(val(alltrim(cMesant)),2)
cAnoant     := trim(cAnoant)
dDatabase	:= lastday(stod(cAnoant+cMesant+"01"))
_cProcDoc   := 'PLN_COL'
//dDatabase	:=	stod(mv_par04+"01")

cLote       := "009995"
//
//MOSTRA LANÇAMENTO
IIF(MV_PAR01 == 1,l_Mostra := .T.,l_Mostra := .F.)  

//AGLUTINA LANÇAMENTO
IIF(MV_PAR02 == 1,lAglutina := .T.,lAglutina := .F.)     

cQueryVW := "  SELECT  BA1_CODPLA CODPLANO, "+CRLF                                         
cQueryVW += "          sum(CALCULA_DESCONTO_MENS_COLAB('C',BA1_CODINT,BA1_CODEMP,BA1_MATRIC,BA1_TIPREG,TO_CHAR(LAST_DAY(TO_DATE('"+substr(cMesAno,1,4)+"'||'"+substr(cMesAno,5,2)+"','YYYYMM')),'YYYYMMDD'))) VALOR , "+CRLF
cQueryVW += "          RA_CC cCusto"+CRLF       

cQueryVW += "   from "+RetSQLName('BA1')+" BA1, " +RetSQLName('BA3')+" BA3, " +RetSQLName('SRA')+" SRA " +CRLF  

cQueryVW += "  WHERE BA1_FILIAL='"+xfilial("BA1")+"' "+CRLF
cQueryVW += "    and BA3_FILIAL='"+xfilial("BA3")+"' "+CRLF
cQueryVW += "    and  RA_FILIAL='"+xfilial("SRA")+"' "+CRLF
cQueryVW += "    AND  BA1_CODINT=BA3_CODINT  "+CRLF
cQueryVW += "    AND    BA1_CODEMP=BA3_CODEMP"+CRLF
cQueryVW += "    AND    BA1_MATRIC=BA3_MATRIC"+CRLF
cQueryVW += "    AND    (BA1_DATBLO = ' ' OR BA1_DATBLO > TO_CHAR(LAST_DAY(TO_DATE('"+substr(cMesAno,1,4)+"'||'"+substr(cMesAno,5,2)+"','YYYYMM')),'YYYYMMDD'))"+CRLF
cQueryVW += "    AND    BA1_CODEMP = '0003'"+CRLF
cQueryVW += "    AND    BA1_CONEMP IN ('000000000001','000000000002')"+CRLF
cQueryVW += "    AND    RA_MAT     = BA3_AGMTFU"+CRLF
cQueryVW += "    AND    BA1.D_E_L_E_T_= ' '  "+CRLF
cQueryVW += "    AND    BA3.D_E_L_E_T_= ' '  "+CRLF 
cQueryVW += "    AND    SRA.D_E_L_E_T_= ' '  "+CRLF
cQueryVW += "    and    CALCULA_DESCONTO_MENS_COLAB('C',BA1_CODINT,BA1_CODEMP,BA1_MATRIC,BA1_TIPREG,TO_CHAR(LAST_DAY(TO_DATE('"+substr(cMesAno,1,4)+"'||'"+substr(cMesAno,5,2)+"','YYYYMM')),'YYYYMMDD')) > 0 "+CRLF
cQueryVW += "    group by  BA1_CODPLA , RA_CC "+CRLF      
cQueryVW += "    ORDER BY 3,1 "+CRLF
//
If Select(cArqTMP) > 0
	dbSelectArea(cArqTMP)
	dbCloseArea()
EndIf
MemoWrite("C:\Temp1\CTB_COM.txt",cQueryVW)
//DbUseArea(.T., 'TOPCONN', TCGenQry(,,cQueryVW), cArqTMP, .F., .T.) 
TcQuery cQueryVW New Alias (cArqTMP) New  
//
dbSelectArea(cArqTMP)
dbGoTop()
//
cArquivo := ""
nHdlPrv  := HeadProva(cLote,"PLS",Substr(cUsuario,7,6),@cArquivo)
_aArea	:=	GetArea()
//
nTotReg	:= 0                                                                              
nValLan	:= 0
nSeq	:= 0
_cANOMES	:=	MV_PAR04
//
Do While (cArqTMP)->(!Eof())
 	
    _C_ClaVal  :=  '0003'
    _C_Item    := (cArqTMP)->CODPLANO
    _C_cCusto  := (cArqTMP)->cCusto
    _C_VlrCol  := (cArqTMP)->VALOR 
    _cProcDoc   := 'PLN_COL'

	dbSelectArea(cArqTMP)
 	nTotReg	++
 	//  
 	IncProc(" Processando ..." + _cProcDoc )
 	//
 	_nVALOR		:=	0  
 	//
 	_nTotal    += DetProva(nHdlPrv,cPadrao,"PLN_COL",cLote)  
 	nSeq ++
 	//  
 	(cArqTMP)->(DbSkip())
 	//
 Enddo
//
RodaProva(nHdlPrv,_nTotal)
cA100Incl(cArquivo,nHdlPrv,3,cLote,l_Mostra,lAglutina)
nSeq := 0

If Select(cArqTMP) > 0
	dbSelectArea(cArqTMP)
	dbCloseArea()
EndIf
// gera excel 
  fGerExc()
return 
//

STATIC FUNCTION fGerExc()

Local 	cQuery      :=  ' '
Local 	cArqExc		:= GetNextAlias()
private aTConvXls      := {"Plano ","NOME USUARIO","MATRICULA","C CUSTO","VALOR "}
private aDadosConv     := {}

If MsgYesNo("Deseja Gerar planilha dos Dados dos Colaboradores ???")

   A := 'b'

Else 
				
    Return()		

Endif


cQuery := "  SELECT  BA1_CODPLA CODPLANO , BA1_NOMUSR NOMUSR ,BA3_AGMTFU MATFUN , "+CRLF                                         
cQuery += "          sum(CALCULA_DESCONTO_MENS_COLAB('C',BA1_CODINT,BA1_CODEMP,BA1_MATRIC,BA1_TIPREG,TO_CHAR(LAST_DAY(TO_DATE('"+substr(cMesAno,1,4)+"'||'"+substr(cMesAno,5,2)+"','YYYYMM')),'YYYYMMDD'))) VALOR , "+CRLF
cQuery += "          RA_CC cCusto"+CRLF       

cQuery += "   from "+RetSQLName('BA1')+" BA1, " +RetSQLName('BA3')+" BA3, " +RetSQLName('SRA')+" SRA " +CRLF  

cQuery += "  WHERE BA1_FILIAL='"+xfilial("BA1")+"' "+CRLF
cQuery += "    and BA3_FILIAL='"+xfilial("BA3")+"' "+CRLF
cQuery += "    and  RA_FILIAL='"+xfilial("SRA")+"' "+CRLF

cQuery += "    AND  BA1_CODINT=BA3_CODINT  "+CRLF
cQuery += "    AND    BA1_CODEMP=BA3_CODEMP"+CRLF
cQuery += "    AND    BA1_MATRIC=BA3_MATRIC"+CRLF
cQuery += "    AND    (BA1_DATBLO = ' ' OR BA1_DATBLO > TO_CHAR(LAST_DAY(TO_DATE('"+substr(cMesAno,1,4)+"'||'"+substr(cMesAno,5,2)+"','YYYYMM')),'YYYYMMDD'))"+CRLF
cQuery += "    AND    BA1_CODEMP = '0003'"+CRLF
cQuery += "    AND    BA1_CONEMP IN ('000000000001','000000000002')"+CRLF
cQuery += "    AND    RA_MAT     = BA3_AGMTFU"+CRLF
cQuery += "    AND    BA1.D_E_L_E_T_= ' '  "+CRLF
cQuery += "    AND    BA3.D_E_L_E_T_= ' '  "+CRLF 
cQuery += "    AND    SRA.D_E_L_E_T_= ' '  "+CRLF
cQuery += "    and    CALCULA_DESCONTO_MENS_COLAB('C',BA1_CODINT,BA1_CODEMP,BA1_MATRIC,BA1_TIPREG,TO_CHAR(LAST_DAY(TO_DATE('"+substr(cMesAno,1,4)+"'||'"+substr(cMesAno,5,2)+"','YYYYMM')),'YYYYMMDD')) > 0 "+CRLF
cQuery += "    group by BA1_CODPLA , RA_CC , BA1_NOMUSR , BA3_AGMTFU "+CRLF      
cQuery += "    ORDER BY 3 , 1 "+CRLF

If Select(cArqExc) > 0
	dbSelectArea(cArqExc)
	dbCloseArea()
EndIf
MemoWrite("C:\Temp1\CTBCOMEXC.txt",cQuery)
//DbUseArea(.T., 'TOPCONN', TCGenQry(,,cQueryVW), cArqTMP, .F., .T.) 
TcQuery cQuery New Alias (cArqExc) New  
//
dbSelectArea(cArqExc)
dbGoTop()
//

Do While (cArqExc)->(!Eof())

 Aadd(aDadosConv,{(cArqExc)->CODPLANO    , ; // 01 Cod. Fornecedor  
                  (cArqExc)->NOMUSR      , ; // 02 Cod RDA  
                  (cArqExc)->MATFUN      , ; // 03 Nome fornecedor  
                  (cArqExc)->cCusto     , ; // 04 Prefixo do titulo    
                  Transform(((cArqExc)->Valor ),"@E 99,999,999.99")})	

	(cArqExc)->(DbSkip())

EndDo 
DlgToExcel({{"ARRAY","Convenio Colaborador " , aTConvXls , aDadosConv}})
// ******************************************************************************************************************
// ******************************************************************************************************************
//
//   ********************            FIM PROCESSAMENTO - CONTABILIZACAO COMISSAO      *************************
//
// ******************************************************************************************************************
// ******************************************************************************************************************
//   
//
/*/             
