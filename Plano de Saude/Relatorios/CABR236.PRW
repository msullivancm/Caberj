#INCLUDE "PROTHEUS.CH"
#Include "TOPCONN.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออออหออออออัอออออออออออปฑฑ
ฑฑบPrograma  ณCABR236   บ Autor ณAltamiro              บ Data ณ 20/02/14  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออออสออออออฯอออออออออออนฑฑ
ฑฑบDescricao ณ Relatorio de conferencia das informa็๕es de pagamento dos  บฑฑ
ฑฑบ          ณ Assistidos informados para IR                              บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/                  

User Function CABR236

Local cMsg			:= ""
Private lAbortPrint :=.F.
Private cPerg       := "CABR236"
Private cTitulo     := "Planilha Excel de Reembolsos Pendendes de Pagamento "        

Private cAliastmp 	:= GetNextAlias()            
Private cAliastmp2 	:= GetNextAlias() 
Private cAlias2016 	:= GetNextAlias()
                                                                         

cMsg += " Este programa gerara planilha excel com os reembolsos pendentes de pagamento "  

***************************************************************************    
 
Private  aDados1     := {}      
 
//Private  acabec1     :={"Empresa","Cliente","Nome Cliente ","Cpf/Cgc","Protocolo","banco","Agencia","Conta","Digito","Data Dig","Dat Prev","Vlr pagto","Digitor","filial ","Cod. Int","Cod Emp","Matricula","Tip Reg","Sequencia","tit e2","Cpf Exe ","Reg Exe","Sig Exe ","Est Exe","Nome Exec","Data Baixa","status ","Plano"} 
Private  acabec1     :={"Empresa",	"CLIENTE","NOME"	,"CGC" ,	"PROTOCOLO" , 	"BANCO","AGENCIA"	,"CONTA","DIGITO","DAT_DIG","DAT_PREV","VL_APRES","VL_PAGTO","DIGITADOR","ZZQ_FILIAL","ZZQ_CODINT","ZZQ_CODEMP","ZZQ_MATRIC","ZZQ_TIPREG","ZZQ_SEQUEN","B44CHVSE1","CPFEXE","REGEXE","SIGEXE","ESTEXE","NOMEXE","E2_BAIXA","ZZQ_STATUS","BA1_FILIAL","EMPRESA","MATRICULA","USUARIO","PLANO","VERSAO","OPERADORA","TIPO"}
private  Descric     := ' '  
private  cRelmatric  := ' ' 
private  cRelmatric1 := ' '                                                                                                   
private  cSairIr 	 := 'Sim'  
private cStatus      := ' '
private cTipRee		 := ""
AjustaSX1(cPerg)

Pergunte(cPerg,.T.) 

DatInc     	:= dtos(mv_par01)  
DatFim      := dtos(mv_par02)    
cStatus     := str(mv_par03)
cTipRee		:= str(mv_par04) //1-RLE 2-AXF 3-AMBOS

cEmpresa    := Iif(cEmpAnt == '01','C','I') 
  
Processa({||Processa1()}, cTitulo, "", .T.)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Libera impressao                                                         ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
   
// faz ecxel
    DlgToExcel({{"ARRAY","Listagem de Conferencia das Informa็๕es de Ir dos Assistidos por familia ",aCabec1,aDados1}})   
    
MsgInfo("Processo finalizado")        
          
Return                 

**************************************************************************

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuno    ณ PROCESSA1บ Autor ณ Jean Schulz        บ Data ณ  11/11/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescrio ณ Funcao auxiliar chamada pela PROCESSA.  A funcao PROCESSA  บฑฑ
ฑฑบ          ณ monta a janela com a regua de processamento.               บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Programa principal                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static Function Processa1()        

ProcRegua(FT_FLASTREC()) 

nCont := 0
IncProc('Processando...')      
///////////////////////////////////       
If cEmpresa == 'C'
   cemp := 'Caberj'
Else               
   cemp := 'Integral'
EndIf    
cquery := CRLF+"SELECT *  "
cquery += CRLF+"       FROM (  "    
cquery += CRLF+"             SELECT '"+cemp+"' emp , "
cquery += CRLF+"                     A1_COD CLIENTE, "
cquery += CRLF+"                     A1_NOME NOME ,  "
cquery += CRLF+"                     A1_CGC CGC,     "
cquery += CRLF+"                     ZZQ_SEQUEN PROTOCOLO , " 
cquery += CRLF+"                     A1_XBANCO BANCO, A1_XAGENC AGENCIA,A1_XCONTA CONTA,A1_XDGCON DIGITO, "
cquery += CRLF+"                     ZZQ_DATDIG DAT_DIG , "
cquery += CRLF+"                     ZZQ_DATPRE DAT_PREV, "
cquery += CRLF+"                     ZZQ_VLRTOT VL_PAGO , " 
cquery += CRLF+"                     0 VALOR ,            "
cquery += CRLF+"                     ZZQ_USRDIG DIGITADOR , "
cquery += CRLF+"                     ZZQ_FILIAL,ZZQ_CODINT,ZZQ_CODEMP,ZZQ_MATRIC,ZZQ_TIPREG , " 
cquery += CRLF+"                     ZZQ_SEQUEN,  "
cquery += CRLF+"                     ' ' B44CHVSE1 , "     
cquery += CRLF+"                     zzq_cpfexe cpfexe, zzq_regexe regexe, zzq_sigexe sigexe, zzq_estexe estexe, zzq_nomexe nomexe , "
cquery += CRLF+"                     ' ' E2_BAIXA , " 
cquery += CRLF+"    				CASE ZZQ.ZZQ_STATUS 
cquery += CRLF+"    				 	WHEN '1' THEN 'ATIVO' " 
cquery += CRLF+"  						WHEN '2' THEN 'CANCELADO'" 
cquery += CRLF+"     					ELSE 'CALCULADO' END STATUS_1" 
cquery += CRLF+"                FROM " +RetSqlName('ZZQ') + " ZZQ , " +RetSqlName('SA1')+ " SA1  "      

If ltrim(cStatus) == '3' //VINCULADO(TITULO GERADO)
	cquery += CRLF+"                   , " +RetSqlName('B44') + " B44 "
Endif

cquery += CRLF+"               WHERE ZZQ.D_E_L_E_T_ = ' ' AND SA1.D_E_L_E_T_ = ' ' AND SA1.A1_FILIAL = '" + xFilial('SA1') +"'"     

If ltrim(cStatus) == '3' //VINCULADO(TITULO GERADO)
	cquery += CRLF+"				 AND B44.D_E_L_E_T_ = ' ' AND B44.B44_FILIAL = '" + xFilial('B44') +"'"
	cquery += CRLF+"				 AND B44.B44_YCDPTC = ZZQ.ZZQ_SEQUEN "
Endif

cquery += CRLF+"                 AND ZZQ.ZZQ_FILIAL = SA1.A1_FILIAL  AND ZZQ.ZZQ_CODCLI = SA1.A1_COD AND ZZQ.ZZQ_LOJCLI = SA1.A1_LOJA "      

If ltrim(cStatus) $ '1|2|' //1 = PROTOCOLADO / 2 = CANCELADO 
	If AllTrim(cTipRee) == '1' //RLE - Reembolsos
		cquery += CRLF+"				 AND ZZQ.ZZQ_TIPPRO <> '4' "
	ElseIf AllTrim(cTipRee) == '2' // AXF - Auxilio Funeral
		cquery += CRLF+"				 AND ZZQ.ZZQ_TIPPRO = '4' "
	Endif 
Endif

If ltrim(cStatus) == '3' //VINCULADO(TITULO GERADO)
	If AllTrim(cTipRee) == '1' //RLE - Reembolsos
		cquery += CRLF+"				 AND B44.B44_PREFIX = 'RLE' "
	ElseIf AllTrim(cTipRee) == '2' // AXF - Auxilio Funeral
		cquery += CRLF+"				 AND B44.B44_PREFIX = 'AXF' "
	Endif 
Endif
If ltrim(cStatus) <> '4'
   cquery += CRLF+"                 AND ZZQ.ZZQ_status ='"+ltrim(cstatus)+"' "      
EndIf   

cquery += CRLF+"                 AND ZZQ.ZZQ_DATDIG BETWEEN '"+DatInc+"' AND '"+DatFim+"' ) TAB1 , "
 
cquery += CRLF+"                     (SELECT BA1_FILIAL ,BA1_CODEMP EMPRESA ,BA1_MATRIC MATRICULA, ba1_nomusr usuario , BA1_CODPLA ||' - '||BI3_DESCRI PLANO , BA1_VERSAO VERSAO , "         
cquery += CRLF+"                             BA1_CODINT OPERADORA,BA1_TIPREG TIPO  "          
cquery += CRLF+"                        FROM " +RetSqlName('BA1')+ " BA1 , " +RetSqlName('BI3')+ " BI3 "
cquery += CRLF+"                       WHERE BA1_FILIAL  = '" + xFilial('BA1') +"' and  BA1.D_E_L_E_T_ = ' '  " 
cquery += CRLF+"                         AND BI3_FILIAL  = '" + xFilial('BI3') +"' and  BI3.D_E_L_E_T_ = ' ' "
cquery += CRLF+"                         AND BI3_CODIGO = BA1_CODPLA ) BA1   "
cquery += CRLF+"               WHERE TAB1.ZZQ_FILIAL = ba1.BA1_FILIAL  "
cquery += CRLF+"                 AND TAB1.ZZQ_CODINT = BA1.OPERADORA   "
cquery += CRLF+"                 AND TAB1.ZZQ_CODEMP = BA1.EMPRESA     "
cquery += CRLF+"                 AND TAB1.ZZQ_MATRIC = BA1.MATRICULA   "
cquery += CRLF+"                 AND TAB1.ZZQ_TIPREG = BA1.TIPO        "
cquery += CRLF+"                 ORDER BY  DAT_PREV,ZZQ_CODINT||ZZQ_CODEMP||ZZQ_MATRIC||ZZQ_TIPREG, PROTOCOLO             "      

memowrite("C:\temp\cabr236.sql",cQuery)
///////////////////////////////////                                
	   	
    If Select((cAliastmp)) <> 0 
       (cAliastmp)->(DbCloseArea()) 
    Endif
  
    TCQuery cQuery New Alias (cAliastmp)  
    
    dbSelectArea(cAliastmp)
   
    (cAliastmp)->(dbGoTop())       
    
    While (cAliastmp)->(!Eof())                                                        

          aaDD(aDados1,{(cAliastmp)->emp       ,;
					   	(cAliastmp)->CLIENTE   ,;
					   	(cAliastmp)->NOME      ,;
					   	(cAliastmp)->CGC       ,;
					   	(cAliastmp)->PROTOCOLO ,; 
					   	(cAliastmp)->BANCO     ,;
					   	(cAliastmp)->AGENCIA   ,;
						(cAliastmp)->CONTA     ,;
					   	(cAliastmp)->DIGITO    ,; 
					   	(cAliastmp)->DAT_DIG   ,;
					   	(cAliastmp)->DAT_PREV  ,; 
                        (cAliastmp)->VL_PAGO   ,;  
                        (cAliastmp)->VALOR     ,;            
                        (cAliastmp)->DIGITADOR ,; 
                        (cAliastmp)->ZZQ_FILIAL,;
                        (cAliastmp)->ZZQ_CODINT,;
                        (cAliastmp)->ZZQ_CODEMP,;
                        (cAliastmp)->ZZQ_MATRIC,;
                        (cAliastmp)->ZZQ_TIPREG,;  
                        (cAliastmp)->ZZQ_SEQUEN,; 
                        (cAliastmp)->B44CHVSE1 ,;    
                        (cAliastmp)->cpfexe    ,; 
                        (cAliastmp)->regexe    ,;  
                        (cAliastmp)->sigexe    ,; 
                        (cAliastmp)->estexe    ,; 
                        (cAliastmp)->nomexe    ,;  
                        (cAliastmp)->E2_BAIXA  ,; 
                        (cAliastmp)->status_1   ,;
                        (cAliastmp)->BA1_FILIAL,;
                        (cAliastmp)->EMPRESA   ,;
                        (cAliastmp)->MATRICULA ,;
                        (cAliastmp)->USUARIO   ,;
                        (cAliastmp)->PLANO     ,;
                        (cAliastmp)->VERSAO    ,;
                        (cAliastmp)->OPERADORA ,;
                        (cAliastmp)->TIPO      })                
						
			(cAliastmp)->(dbSkip()) 	   
     EndDo	                   
Return                    

********************************************************************************************************************************

Static Function AjustaSX1(cPerg)

Local aHelpPor := {}

PutSx1(cPerg,"01",OemToAnsi("Data Inicial ?") ,"","","mv_ch1","D",08,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","","",{},{})
PutSx1(cPerg,"02",OemToAnsi("Data Final?")    ,"","","mv_ch2","D",08,0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","","",{},{})     
PutSx1(cPerg,"03",OemToAnsi("Status ?") 	  ,"","","mv_ch3","N",01,0,0,"C","","","","","mv_par03","Protocolado","","","","Cancelado","","","Pagos",""," ","Todos","","","","","",{},{},{}) 
PutSx1(cPerg,"04",OemToAnsi("RLE ou AXF ?")   ,"","","mv_ch4","N",01,0,0,"C","","","","","mv_par04","RLE"        ,"","","","AXF","","","Ambos",""," ","","","","","","",{},{},{}) 
//PutSx1(cPerg,"04",OemToAnsi("Baixados  ") 	        ,"","","mv_ch4","N",01,0,0,"C","","","","","mv_par04","Sim","","","","Nใo","","","Todos","","","","","","","","",{},{},{}) 

Pergunte(cPerg,.F.)

Return                                      
