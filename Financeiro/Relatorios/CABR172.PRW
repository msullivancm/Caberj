#INCLUDE "PROTHEUS.CH"
#Include "TOPCONN.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABR192   º Autor ³Altamiro              º Data ³ 27/12/13  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Relatorio de Receita Vs Pagto de Comissao                  º±±
±±º          ³                                                            º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/                  

User Function CABR172
Local cMsg			:= ""
Private lAbortPrint :=.F.
Private cPerg       := "CABR172"
Private cTitulo     := "Listagem Receita Vs Pagto de Comissao  "        

Private cAliastmp 	:= GetNextAlias()
                                                                         
//SetPrvt("oDlg1","oGrp1","oSay1","oSBtn1","oSBtn2","oSBtn3")

cMsg += " Este programa ira fazer listagem de de Controle de Pagto de Comissao  " + CRLF

***************************************************************************    
 
Private  aDados1     := {}       
Private  acabec1    :={"Empresa " ,"Vlr Recebido ","Comissao Paga"}

private Descric := ' '
private cTitVar := ' '                                                                                                          
  	  
AjustaSX1(cPerg)

Pergunte(cPerg,.T.) 
cCodEmpI    := mv_par01 
cCodEmpF    := mv_par02
cMesBase    := mv_par03
cAnoBase	:= mv_par04  
cGeraEx	    := mv_par05              

Private cTitulo     := "Listagem Receita Vs Pagto de Comissao - Ref "+cMesBase+"/"+cAnoBase     

Processa({||Processa1()}, cTitulo, "", .T.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Libera impressao                                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
   
// faz ecxel
if cGeraEx == 1 
    DlgToExcel({{"ARRAY","Listagem Receita Vs Pagto de Comissao - Ref "+cMesBase+"/"+cAnoBase  ,aCabec1,aDados1}})   
EndIF
fGeraRel2()    
MsgInfo("Processo finalizado")

Return                 

**************************************************************************

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFun‡„o    ³ PROCESSA1º Autor ³ altamiro           º Data ³  11/02/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescri‡„o ³ Funcao auxiliar chamada pela PROCESSA.  A funcao PROCESSA  º±±
±±º          ³ Listagem Receita Vs Pagto de Comissao .                    º±±
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
////////////////////////////////////        
cquery := CRLF+"  select emp.COD codigo  , emp.empresa empre , NVL(rec.Vlrrec, 0.00) Vlrrec , NVL(PAG.VLRPAG,0.00) VLRPAG from "
cquery += CRLF+" (select BG9_CODIGO COD ,BG9_DESCRI empresa from "+ RetSqlName("Bg9") + " Bg9 where  BG9_FILIAL = '" + xFilial('bg9') + "' "
cquery += CRLF+"      AND BG9.D_E_L_E_T_ = ' ' and BG9_CODIGO >= '"+cCodEmpI+"' AND BG9_CODIGO <= '"+cCodEmpF+"' ORDER BY 1) emp , "
cquery += CRLF+" (SELECT e1_codemp , sum(e1_valor) Vlrrec FROM "+ RetSqlName("se1") + " se1 where E1_FILIAL = '"+ xFilial('SE1') +"' AND se1.D_E_L_E_T_ = ' ' "
cquery += CRLF+"     and e1_codemp >= '"+cCodEmpI+"' AND e1_codemp <= '"+cCodEmpF+"' "
cquery += CRLF+"     and e1_prefixo = 'PLS' AND E1_ORIGEM = 'PLSA510' "
cquery += CRLF+"     AND E1_NUM IN (SELECT DISTINCT  BXQ_NUM FROM "+ RetSqlName("Bxq") + " Bxq " 
cquery += CRLF+                   " WHERE BXQ_FILIAL = '" + xFilial('BXQ') + "' AND BXQ.D_e_l_e_t_= ' ' " 
cquery += CRLF+                     " AND BXQ_CODEMP >= '"+cCodEmpI+"' AND BXQ_CODEMP <= '"+cCodEmpF+"' AND BXQ_MES = '"+cMesBase+"'  AND BXQ_ANO = '"+ cAnoBase +"' " 
cquery += CRLF+                     " AND BXQ_REFERE = BXQ_PAGCOM ) GROUP BY e1_codemp ) REC, "
cquery += CRLF+" (SELECT BXQ_CODEMP , SUM(BXQ_VLRCOM) VLRPAG FROM "+ RetSqlName("Bxq") + " Bxq " 
cquery += CRLF+"   WHERE BXQ_FILIAL = '" + xFilial('BXQ') + "' AND BXQ.D_e_l_e_t_= ' ' AND BXQ_CODEMP >= '"+cCodEmpI+"' "
cquery += CRLF+"     AND BXQ_CODEMP <= '"+cCodEmpF+"' AND BXQ_MES = '"+cMesBase+"'  AND BXQ_ANO = '"+ cAnoBase +"' AND BXQ_REFERE = BXQ_PAGCOM "
cquery += CRLF+"   GROUP BY BXQ_CODEMP ) PAG "
cquery += CRLF+"   WHERE emp.COD  = e1_codemp (+) AND emp.COD  = BXQ_CODEMP (+)"   

cquery += CRLF+" order by 1"

/////////////////////////////////////////*
	   	
If Select((cAliastmp)) <> 0 
  (cAliastmp)->(DbCloseArea()) 
Endif
  
TCQuery cQuery New Alias (cAliastmp)  
    
dbSelectArea(cAliastmp)
   
(cAliastmp)->(dbGoTop())   
     
While (cAliastmp)->(!Eof())             
     
       aaDD(aDados1,{(cAliastmp)->codigo     ,; 
                     (cAliastmp)->empre        ,; 
                     (cAliastmp)->Vlrrec        ,;
                     (cAliastmp)->VLRPAG      })    
                     
       (cAliastmp)->(dbSkip()) 	   
EndDo	         
     
         
Return                    

*************************************************************************************************************  
Static Function fGeraRel2

Local oReport 
Private cPerg		:= "CABR172"  
Private aOrdem 		:= {}//{'RDA','Ano/Mes'}

//aSort( aDados1,,,{|x,y| x[10] < y[10]} )

oReport:= ReportDef2()
oReport:PrintDialog()

Return

*************************************************************************************************************

********************************************************************************************************************************

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
oReport	:= TReport():New("CABR172","Listagem Receita Vs Pagto de Comissao - Ref "+cMesBase+"/"+cAnoBase ,, {|oReport| ReportPrt(oReport)},"Listagem Receita Vs Pagto de Comissao - Ref "+cMesBase+"/"+cAnoBase )
oReport:SetTotalInLine(.F.)//Imprime na linha: .F. - Imprime abaixo da linha com o titulo de cada coluna: .T.
//oReport:SetTotalText('Total Geral') 

*'-----------------------------------------------------------------------------------'*
*'Solucao para impressao em que as colunas se truncam: "SetColSpace" e "SetLandScape"'* 
*'-----------------------------------------------------------------------------------'*

oReport:SetColSpace(1) //Espacamento entre colunas. 
//oReport:SetLandscape() //Impressao em paisagem.  
oReport:SetPortrait() //Impressao em retrato.  

oDPJ := TRSection():New(oReport,"Listagem Receita Vs Pagto de Comissao - Ref "+cMesBase+"/"+cAnoBase ,,aOrdem)             

   TRCell():New(oDPJ ,'EMPRESA'	   		,/*TABELA*/	,'Empresa  '          ,/*Picture*/   	    ,60				,,,,,"LEFT"		)
   TRCell():New(oDPJ ,'VLRREC'	       	,/*TABELA*/	,'Vlr. Receber  '     ,"@E 99,999,999.99" 	,24				,,,,,"RIGHT"	)
   TRCell():New(oDPJ ,'VLRPAG'	       	,/*TABELA*/	,'Vlr Comissão  '     ,"@E 99,999,999.99" 	,24				,,,,,"RIGHT"	) 

//oBreak01 := TRBreak():New(oDPJ,oDPJ:Cell("EMPRESA"),"Total Geral  "	,.F.) 

lTotSecBrk01	:= .F.//Indica se totalizador sera impresso na quebra de secao
lTotFimBrk01	:= .T.//Indica se totalizador sera impresso no final do relatorio - Como o total eh o mesmo, basta que apenas um esteja ativado

TRFunction():New(oDPJ:Cell("VLRREC")   		,NIL,"SUM"			,,,"@E 999,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01) 
TRFunction():New(oDPJ:Cell("VLRPAG")   		,NIL,"SUM"			, ,,"@E 999,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01) 
     
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

       oDPJ:Cell('EMPRESA' 		    ):SetValue((aDados1[i][01])+' - '+(aDados1[i][2])) 
       oDPJ:Cell('VLRREC'        	):SetValue((aDados1[i][03]))
       oDPJ:Cell('VLRPAG'	 		):SetValue((aDados1[i][04]))

   oDPJ:PrintLine()
   
Next i

oDPJ:Finish()

Return   

******************************************************************************************

Static Function AjustaSX1(cPerg)

Local aHelpPor := {}

PutSx1(cPerg,"01",OemToAnsi("Cod. Empresa De ")    		,"","","mv_ch1","C",04,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","","",{},{})    
PutSx1(cPerg,"02",OemToAnsi("Cod. Empresa Ate ")   		,"","","mv_ch2","C",04,0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","","",{},{})    
PutSx1(cPerg,"03",OemToAnsi("Mes Base  ")       		,"","","mv_ch3","C",02,0,0,"G","","","","","mv_par03","","","","","","","","","","","","","","","","","",{},{})
PutSx1(cPerg,"04",OemToAnsi("Ano Base  ")       		,"","","mv_ch4","C",04,0,0,"G","","","","","mv_par04","","","","","","","","","","","","","","","","","",{},{})    
PutSx1(cPerg,"05",OemToAnsi("Gerar Excel ") 	        ,"","","mv_ch5","N",01,0,0,"C","","","","","mv_par05","Sim","","","","Não","","","","","","","","","","","",{},{},{}) 

Pergunte(cPerg,.F.)

Return()                 

Static Function fcomp(cMesComp,cAnoComp ) 

local nCompMF:= val(cMesComp)   
local nCompAF:= val(cAnoComp)   
local cCompMF:= ' '   
local cCompAF:= ' '  
local i      := 1   
nNumMes      := 12  
  
For i := 1 To 999    
    if nCompMF > nNumMes
       nComPMF := nCompMF - nNumMes  
       EXIT       
    Elseif nCompMF == nNumMes      
       nComPMF := 12
       nCompAF:= nCompAF - 1 
       EXIT
    Elseif nCompMF < nNumMes   
       if nNumMes > 12
          nNumMes := nNumMes - 12
          nCompAF:= nCompAF - 1
       else                      
          nCompMF := ((nCompMF + 12)- nNumMes)
          nCompAF:= nCompAF - 1
          exit
       EndIf   
    EndiF                           
Next i
       
 cCompMF:= strzero((nCompMF),2)   
 cCompAF:= str(nCompAF)        
 return(cCompAF+cCompMF )
