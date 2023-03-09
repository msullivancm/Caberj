#INCLUDE "protheus.ch"
#INCLUDE "UTILIDADES.CH"  

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCPADBAU   บMotta  ณCABERJ              บ Data ณ  julho/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ CHAMADA DE CONSULTA PADRAO COM CHECK BOX PARA A BAU        บฑฑ
ฑฑบ          ณ F3 BAULIS                                                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/   

User Function CPADBAU() 

Local c_Tabela   := "BAU"
Local c_Cabec    := "BAU_CODIGO|BAU_NOME|BAU_YCTHOS"
Local c_CpoRet   := "BAU_CODIGO"
Local cTitulo    := "HOSPITAIS"
Local c_FilSql   := "BAU_TIPPRE = 'HOS' AND BAU_TIPPE = 'J' AND BAU_YCTHOS<> ' ' AND BAU_EST='RJ'"   
Local c_OrderSql := "BAU_NOME"        
Local c_CPADBAU := " "

c_CPADBAU := F3Select(c_Tabela,c_Cabec,c_CpoRet,cTitulo,c_FilSql,c_OrderSql) 

Return c_CPADBAU                 


//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณF3 da consulta do rel. comparativo hospitais ณ
//ณ                                             ณ
//ณCirurgico >>Procedimento                     ณ
//ณClinico >> CID                               ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

User Function RelHospFil(cOpc)

Local aVetBx := {}        
Local lConfirm := .F.
Local cLog   := ""
Local nOpca  := 0    
Local aCab := {}
Local aTam := {}        
Local lPalChave := .F. 
Local nRet  := 0    
Local cTit  := ""   
Local aBuffer := {}
    
Default cOpc := "1"        

Private oDlg  := nil
Private oBrowse := nil

If cOpc == "1" 
  cTit := "Selecao de CIDs" 
Else
  cTit := "Selecao de Procedimentos"
Endif

Processa({||aBuffer := ExecSql(cOpc)})

aVetBx 	:= aBuffer[1]
aCab	:= aBuffer[2]
aTam 	:= aBuffer[3]
  
oDlg := MSDialog():New(0,0,510,850,cTit,,,.F.,,,,,,.T.,,,.T. )
     
oBrowse := TCBrowse():New(030,010,410,190,,aCab,aTam,oDlg,,,,,{||nRet := oBrowse:nAt, oDlg:End()},,,,,,,.F.,,.T.,,.F.,,, )
oBrowse:SetArray(aVetBx)

oBrowse:bLine := {||{aVetBx[oBrowse:nAt,1]      ,;
                     aVetBx[oBrowse:nAt,2]} }
     
oBrowse:nScrollType := 1 // Scroll VCR       
   
oSBtn1     := SButton():New(230,365,1,{||lConfirm := .T.,oDlg:End()} ,oDlg,,"", )
oSBtn2     := SButton():New(230,395,2,{||oDlg:End()}     ,oDlg,,"", )
       
oDlg:Activate(,,,.T.,,,EnchoiceBar(oDlg,{||nRet := oBrowse:nAt,oDlg:End()},{||nRet := oBrowse:nAt,ODlg:End()}))  

Return aVetBx[nRet,1]                             

*********************************************************************************************************

Static Function ExecSql(cOpca)

Local i := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

ProcRegua(0)

For i := 1 to 5
 IncProc('Selecionando registros...')
Next

aRet := {}
aCab := {"Cod","Descricao"}
aTam := {20,100}      

If cOpca == "1"
  cQuery:="SELECT BA9_CODDOE COD, BA9_DOENCA DESCRI "
  cQuery+="FROM "+RetSqlName("BA9")+" BA9  "   
  cQuery+="WHERE  BA9_FILIAL = '  '  "  
  cQuery+="AND    D_E_L_E_T_ = ' '   "     
  cQuery+="ORDER BY 1  "      
else
  cQuery:="SELECT SUBSTR(BR8_DESCRI,1,INSTR(TRANSLATE(BR8_DESCRI,'-(`/,','    ,'),' ')-1) COD,TRIM(BR8_DESCRI)||' '||TRIM(BR8_CODPAD)||'/'||TRIM(BR8_CODPSA) DESCRI "
  cQuery+="FROM "+RetSqlName("BR8")+" BR8  "   
  cQuery+="WHERE  BR8_FILIAL = '  '  "       
  cQuery+="AND    BR8_TPPROC = '0'  "    
  cQuery+="AND    BR8_YTPITM = 'H'  "    
  cQuery+="AND    BR8_NIVEL >= '3'  "    
  cQuery+="AND    BR8_REGATD <> '1'   "    
  cQuery+="AND    D_E_L_E_T_ = ' '   "  
  cQuery+="ORDER BY 2  " 
EndIf   


TCQUERY cQuery ALIAS "QRY" NEW         
dbselectarea("QRY")  
QRY->(DbGoTop())       
while !(QRY->(eof())) 
    aAdd(aRet,{QRY->COD,QRY->DESCRI})
    QRY->(dbskip())
enddo// !(QRY->(eof()))
dbclosearea()

Return {aRet, aCab, aTam}                                  

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCPADBG7   บMotta  ณCABERJ              บ Data ณ  MARCO/2014 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ CHAMADA DE CONSULTA PADRAO COM CHECK BOX PARA A BG7        บฑฑ
ฑฑบ          ณ F3                                                         บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/   

User Function CPADBG7() 

Local c_Tabela   := "BG7"
Local c_Cabec    := "BG7_CODGRU|BG7_DESCRI"
Local c_CpoRet   := "BG7_CODGRU"
Local cTitulo    := "GRUPO DE COBERTURA"
Local c_FilSql   := "BG7_CODINT = '0001'"   
Local c_OrderSql := "BG7_CODGRU"        
Local c_CPADBG7 := " "

c_CPADBG7 := F3Select(c_Tabela,c_Cabec,c_CpoRet,cTitulo,c_FilSql,c_OrderSql) 

Return c_CPADBG7   


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCPADBE4   บRAQUEL  ณCABERJ              บ Data ณ  ABRIL/2014 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ CHAMADA DE CONSULTA PADRAO COM CHECK BOX PARA A BE4        บฑฑ
ฑฑบ          ณ F3                                                         บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ MODINT.RPT                                                 บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/   

User Function CPADBE4(cRDA) 

Local c_Tabela   := "BE4"
Local c_Cabec    := "BE4_SENHA|BE4_NOMUSR|BE4_DATPRO|BE4_CODRDA"
Local c_CpoRet   := "BE4_SENHA"
Local cTitulo    := "SENHAS"
Local c_FilSql   := "BE4_SITUAC<> '3' AND BE4_TIPGUI='03' AND BE4_CANCEL <> '1' AND BE4_SENHA<>' ' AND BE4_CODRDA="+cRDA   
Local c_OrderSql := "BE4_NOMUSR|BE4_DATPRO"        
Local c_CPADBE4 := " " 

c_CpoRet:=c_CpoRet

c_CPADBE4 := F3Select(c_Tabela,c_Cabec,c_CpoRet,cTitulo,c_FilSql,c_OrderSql,.F.,',')

Return replace(c_CPADBE4,' ','' )    


//*************************************Relat๓rio Internista****************************************

User Function MODINT() 

Private cCRPar:="1;0;1;Relat๓rio Internista"      
Private cParam1     := ""    
Private cParam2     := ""     
Private cParam3     := ""      
Private cPerg       := "MODINT"   

If !Pergunte(cPerg,.T.)
	Return
Endif

/*Conjunto de op็๕es para nao mostrar a tela da SetPrint, composta por x;y;z;w, onde 
  x = vํdeo(1) ou impressora(3) 
  y = Atualiza(0) ou nใo(1) os dados
  z = N๚mero de c๓pias 
  w = Tํtulo do relatorio.
*/              


asenhas := U_CPADBE4(mv_par01)  

cParam1:=mv_par01+";"+asenhas

CallCrys("MODINT",cParam1,cCRPar) 

Return         

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCPADBAG   บMotta  ณCABERJ              บ Data ณ  JUNHO/2014 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ CHAMADA DE CONSULTA PADRAO COM CHECK BOX PARA A BAG        บฑฑ
ฑฑบ          ณ F3                                                         บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/   

User Function CPADBAG() 

Local c_Tabela   := "BAG"
Local c_Cabec    := "BAG_CODIGO|BAG_DESCRI"   
Local c_CpoRet   := "BAG_CODIGO"
Local cTitulo    := "CLASSE DE REDE"
Local c_FilSql   := " "   
Local c_OrderSql := "BAG_DESCRI"        
Local c_CPADBAG := " "

c_CPADBAG := F3Select(c_Tabela,c_Cabec,c_CpoRet,cTitulo,c_FilSql,c_OrderSql) 

Return c_CPADBAG     