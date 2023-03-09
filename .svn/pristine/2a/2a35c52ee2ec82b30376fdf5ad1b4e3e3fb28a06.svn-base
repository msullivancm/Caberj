#INCLUDE "PROTHEUS.CH"
#Include "TOPCONN.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABR261   º Autor ³Altamiro              º Data ³ 27/12/13  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Relatorio de Receita Vs Pagto de Comissao                  º±±
±±º          ³                                                            º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/                  

User Function CABR262()
Local cMsg			:= ""
Private lAbortPrint :=.F.
Private cPerg       := "CABR262"
Private cTitulo     := " "          
Private cAliastmp 	:= GetNextAlias()
                                                                         
//SetPrvt("oDlg1","oGrp1","oSay1","oSBtn1","oSBtn2","oSBtn3")

cMsg += " Este programa ira listar os titulos pagos de comissao nas ultomas competencias " + CRLF

***************************************************************************    
 
Private  aDados1     := {}       
Private  acabec1    :={"Competencia " ,"Empresa","Fornecedor ","Titulo", "Vlr Comissao" , "Impostos", "Vlr a Pagar","Saldo a Pagar", "Dt Baixa "}

private Descric := ' '
private cTitVar := ' '                                                                                                          
private cVend   := ' '
private cCmpI   := ' '
private cCmpF   := ' '
private ccodven := ' ' 
private nTprel  := ' ' 	  
private cSaldo  := 0.00


AjustaSX1(cPerg)

Pergunte(cPerg,.T.) 

ccodven  := mv_par01
cCmpI    := mv_par02 
cCmpF    := mv_par03
cGeraEx	 := mv_par04              
nTprel   := mv_par05    //==1,"Conferencia","Auditoria")
//Private cTitulo     := "Listagem de Conferencia de Pagto comissoe - Vendedor "+ cVend     

Processa({||Processa1()}, cTitulo, "", .T.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Libera impressao                                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
   
// faz ecxel
if cGeraEx == 1  
    if nTprel == 1 
       DlgToExcel({{"ARRAY","Listagem de Conferencia de Pagto comissoes - Vendedor "+ cVend   ,aCabec1,aDados1}})   
    Else                                                                                                            
       DlgToExcel({{"ARRAY","Listagem de Auditoria de Pagto comissoes - Vendedor "+ cVend   ,aCabec1,aDados1}})   
    EndIf 
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
cquery := CRLF+"select bxq_ano||bxq_mes , bxq_mes||'/'||bxq_ano compt , "
cquery += CRLF+"       bxq_codemp||' - ' ||bg9_descri empresa , "
cquery += CRLF+"       bxq_e2forn ||' - '||e2_nomfor fornecedor , "  
cquery += CRLF+"       bxq_e2pref||bxq_e2num || bxq_e2parc||bxq_e2tipo titulo ,"
cquery += CRLF+"       sum(bxq_vlrcom) vlrcom  ,"      
cquery += CRLF+"       (nvl( e2_irrf,0) + nvl( e2_iss,0) + nvl( e2_vretpis,0) + nvl( e2_vretcof,0) +nvl( e2_vretcsl,0)) impostos , " 
cquery += CRLF+"       nvl( e2_valor,0) vlrtit ," 
cquery += CRLF+"       nvl(e2_saldo,0)  saldo  ," 
cquery += CRLF+"       nvl((substr(e2_baixa,7,2)||'/'||substr(e2_baixa,5,2)||'/'||substr(e2_baixa,1,4)),'') baixa "   
cquery += CRLF+"  from " +RetSqlName('SE2')+ " SE2 , " +RetSqlName('BXQ')+ " BXQ , " +RetSqlName('BG9')+ " BG9  "
cquery += CRLF+" where bxq_filial    = '" + xFilial('BXQ') +"' and bxq.d_E_L_E_T_ = ' ' "
cquery += CRLF+"   and  e2_filial(+) = '" + xFilial('SE2') +"' and se2.d_E_L_E_T_(+)= ' ' "
cquery += CRLF+"   and bg9_filial(+) = '" + xFilial('BG9') +"' and bg9.d_E_L_E_T_(+)= ' ' "
cquery += CRLF+"   and bxq_codven = '"+ccodven+"'"
cquery += CRLF+"   and bxq_ano||bxq_mes >= '"+cCmpI+"' and bxq_ano||bxq_mes <= '"+cCmpF+"'" 
cquery += CRLF+"   and  bxq_refere = Bxq_Pagcom "
cquery += CRLF+"   and e2_fornece(+) = bxq_e2forn "
cquery += CRLF+"   and e2_prefixo(+) = bxq_e2pref "
cquery += CRLF+"   and e2_num(+)     = bxq_e2num "
cquery += CRLF+"   and e2_parcela(+) = bxq_e2parc "
cquery += CRLF+"   and e2_tipo(+)    = bxq_e2tipo " 
cquery += CRLF+"   and bg9_codigo(+) = bxq_codemp"
cquery += CRLF+" group by bxq_ano||bxq_mes , bxq_mes||'/'||bxq_ano , " 
cquery += CRLF+"       bxq_codemp||' - ' ||bg9_descri , " 
cquery += CRLF+"       bxq_e2forn ||' - '||e2_nomfor ,"  
cquery += CRLF+"       bxq_e2pref||bxq_e2num || bxq_e2parc||bxq_e2tipo ,"
cquery += CRLF+"       nvl(e2_valor,0)  ,"              
cquery += CRLF+"       (nvl( e2_irrf,0) + nvl( e2_iss,0) + nvl( e2_vretpis,0) + nvl( e2_vretcof,0) +nvl( e2_vretcsl,0)), " 
cquery += CRLF+"       nvl(e2_saldo,0) ," 
cquery += CRLF+"       nvl((substr(e2_baixa,7,2)||'/'||substr(e2_baixa,5,2)||'/'||substr(e2_baixa,1,4)),'')"  
cquery += CRLF+" Order By 3,1,2 "         
/////////////////////////////////////////*
	   	
If Select((cAliastmp)) <> 0 
  (cAliastmp)->(DbCloseArea()) 
Endif
  
TCQuery cQuery New Alias (cAliastmp)  
    
dbSelectArea(cAliastmp)
   
(cAliastmp)->(dbGoTop())                                                                              

cVend :=(cAliastmp)->fornecedor
if nTprel == 1 
   cTitulo     := "Listagem de Conferencia de Pagto comissões - Vendedor "+ cVend         
Else                                                                                      
   cTitulo     := "Listagem de Auditoria  de Pagto comissões - Vendedor "+ cVend         
EndIf                                    

While (cAliastmp)->(!Eof())             
                                                        
if (cAliastmp)->saldo >0 
     cSaldo  := (cAliastmp)->vlrcom 
     cDtbaixa:= '  /  /  '
Else
     cSaldo  := (cAliastmp)->saldo 
     cDtbaixa:= (cAliastmp)->baixa 
EndIf           
     
  If nTprel   == 2    //==1,"Conferencia","Auditoria")    
     aaDD(aDados1,{(cAliastmp)->compt      ,;
                   (cAliastmp)->empresa    ,;
                   (cAliastmp)->fornecedor ,; 
                   (cAliastmp)->titulo     ,;
                   (cAliastmp)->vlrcom     ,;
                   (cAliastmp)->vlrtit     ,;
                   (cAliastmp)->saldo      ,;
                   (cAliastmp)->baixa      ,;
                   (cAliastmp)->impostos   })     
  Else                                            
     aaDD(aDados1,{(cAliastmp)->compt      ,;
                   (cAliastmp)->empresa    ,;
                   (cAliastmp)->fornecedor ,; 
                   (cAliastmp)->titulo     ,;
                   (cAliastmp)->vlrcom     ,;
                   ((cAliastmp)->vlrcom -(cAliastmp)->impostos)     ,;
                    cSaldo      ,;
                    cDtbaixa    ,;
                   (cAliastmp)->impostos     })
  EndIf                    
       (cAliastmp)->(dbSkip()) 	   
EndDo	         
     
         
Return                    

*************************************************************************************************************  
Static Function fGeraRel2

Local oReport 
Private cPerg		:= "CABR262"  
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
                                                                     
If nTprel == 1 
   oReport	:= TReport():New("CABR262","Listagem de Conferencia de Pagto comissoes - Vendedor "+ cVend   ,, {|oReport| ReportPrt(oReport)},"Listagem de Conferencia de Pagto comissoe - Vendedor "+ cVend   )
Else                                                                                                                                                                                                         
   oReport	:= TReport():New("CABR262","Listagem de Auditoria de Pagto comissoes - Vendedor "+ cVend   ,, {|oReport| ReportPrt(oReport)},"Listagem de Conferencia de Pagto comissoe - Vendedor "+ cVend   )
EndIf 
oReport:SetTotalInLine(.F.)//Imprime na linha: .F. - Imprime abaixo da linha com o titulo de cada coluna: .T.
//oReport:SetTotalText('Total Geral') 

*'-----------------------------------------------------------------------------------'*
*'Solucao para impressao em que as colunas se truncam: "SetColSpace" e "SetLandScape"'* 
*'-----------------------------------------------------------------------------------'*

oReport:SetColSpace(1) //Espacamento entre colunas. 
//oReport:SetLandscape() //Impressao em paisagem.  
oReport:SetPortrait() //Impressao em retrato.  
               
If nTprel == 1 
   oDPJ := TRSection():New(oReport,"Listagem de Conferencia de Pagto comissoes - Vendedor "+ cVend  ,,aOrdem)              
Else
   oDPJ := TRSection():New(oReport,"Listagem de Auditoria de Pagto comissoes - Vendedor "+ cVend  ,,aOrdem)                 
EndIf 

   TRCell():New(oDPJ ,'COMPTE'	   		,/*TABELA*/	,'Competencia '       ,/*Picture*/   	    ,15				,,,,,"LEFT"		)
   TRCell():New(oDPJ ,'EMPRESA'	   		,/*TABELA*/	,'Empresa  '          ,/*Picture*/   	    ,60				,,,,,"LEFT"		)
// TRCell():New(oDPJ ,'FORNECE'	       	,/*TABELA*/	,'Fornecedor '        ,/*Picture*/   	    ,40				,,,,,"LEFT"		) 
   TRCell():New(oDPJ ,'TITULO'	       	,/*TABELA*/	,'Titulos  '          ,/*Picture*/   	    ,17				,,,,,"LEFT"		)
   TRCell():New(oDPJ ,'VLRCOM'	       	,/*TABELA*/	,'Vlr Comissão   '    ,"@E 99,999,999.99" 	,15				,,,,,"RIGHT"	)  
   TRCell():New(oDPJ ,'IMPOST'	       	,/*TABELA*/	,'Vlr Impostos   '    ,"@E 99,999,999.99" 	,15				,,,,,"RIGHT"	) 
   TRCell():New(oDPJ ,'VLRPAG'	       	,/*TABELA*/	,'Vlr Pagamento  '    ,"@E 99,999,999.99" 	,15				,,,,,"RIGHT"	) 
   TRCell():New(oDPJ ,'VLRSAL'	       	,/*TABELA*/	,'Saldo          '    ,"@E 99,999,999.99" 	,15				,,,,,"RIGHT"	)
   TRCell():New(oDPJ ,'DTBAIX'	       	,/*TABELA*/	,'Dt baixa  '         ,/*Picture*/   	    ,12				,,,,,"LEFT"		)  


//oBreak01 := TRBreak():New(oDPJ,oDPJ:Cell("EMPRESA"),"Total Geral  "	,.F.) 

lTotSecBrk01	:= .F.//Indica se totalizador sera impresso na quebra de secao
lTotFimBrk01	:= .T.//Indica se totalizador sera impresso no final do relatorio - Como o total eh o mesmo, basta que apenas um esteja ativado
                                                                                                                                  
TRFunction():New(oDPJ:Cell("VLRCOM")   		,NIL,"SUM"			, ,,"@E 999,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01)
TRFunction():New(oDPJ:Cell("IMPOST")   		,NIL,"SUM"			, ,,"@E 999,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01)   
TRFunction():New(oDPJ:Cell("VLRPAG")   		,NIL,"SUM"			, ,,"@E 999,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01)  
TRFunction():New(oDPJ:Cell("VLRSAL")   		,NIL,"SUM"			, ,,"@E 999,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01) 
     
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

       oDPJ:Cell('COMPTE' 		    ):SetValue((aDados1[i][01])) 
       oDPJ:Cell('EMPRESA' 		    ):SetValue((aDados1[i][02]))  
       oDPJ:Cell('TITULO' 		    ):SetValue((aDados1[i][04])) 
       oDPJ:Cell('VLRCOM' 		    ):SetValue((aDados1[i][05])) 
       oDPJ:Cell('VLRPAG'	 		):SetValue((aDados1[i][06])) 
       oDPJ:Cell('VLRSAL'        	):SetValue((aDados1[i][07])) 
       oDPJ:Cell('DTBAIX'        	):SetValue((aDados1[i][08]))       
       oDPJ:Cell('IMPOST'        	):SetValue((aDados1[i][09])) 

   oDPJ:PrintLine()
   
Next i

oDPJ:Finish()

Return                                                                                                                            
******************************************************************************************

Static Function AjustaSX1(cPerg)

Local aHelpPor := {}

PutSx1(cPerg,"01",OemToAnsi("Cod. Vendedor ")    		,"","","mv_ch1","C",06,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","","",{},{})    
PutSx1(cPerg,"02",OemToAnsi("Compet Inicial('AAAAMM')") ,"","","mv_ch2","C",06,0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","","",{},{})     
PutSx1(cPerg,"03",OemToAnsi("Compet Final  ('AAAAMM')") ,"","","mv_ch3","C",06,0,0,"G","","","","","mv_par03","","","","","","","","","","","","","","","","","",{},{})    
PutSx1(cPerg,"04",OemToAnsi("Gerar Excel ") 	        ,"","","mv_ch4","N",01,0,0,"C","","","","","mv_par04","Sim","","","","Não","","","","","","","","","","","",{},{},{}) 
PutSx1(cPerg,"05",OemToAnsi("Tipo Relatorio ") 	        ,"","","mv_ch5","N",01,0,0,"C","","","","","mv_par05","Conferencia","","","","Auditoria","","","","","","","","","","","",{},{},{})


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
