User Function CONTLIVRO()

Private aRotina :={{"Pesquisar","AxPesqui",0,1},;
                   {"Visualizar","AxVisual",0,2},;
                   {"Incluir","AxInclui",0,3},;
                   {"Alterar","AxAltera",0,4},;
                   {"Excluir","AxDeleta",0,5},; 
                   {"Recibo","U_RECORI",0,7}}

Private cString := "ZZY"     
Private cCadastro:="Controle de Entrega de Livros"   

dbSelectArea("ZZY")
dbSetOrder(1)   
DbGotop()   

MBrowse(6,1,22,75,cString,,,,,2,)  
Set filter to    
Return()    

 

User function VLORIENT(titular,vqtd)  
LOCAL nValor := 0

LOCAL cSQL	    := ""    
LOCAL cRet      := 0 
LOCAL cValor    := 0          
LOCAL dEdicao   := GetNewPar("MV_YEDLIV","20081101")   
LOCAL nValor    := GetNewPar("MV_YVLLIV",0)  
local cEst      := ""

 
cSQL := "SELECT Sum(QTD) QTDTOT ,Sum(VALOR) VALTOT FROM ( "
cSQL += "SELECT NVL(SUM(ZZY_QTD),0)  QTD,NVL(SUM(ZZY_VALOR),0)  VALOR   FROM " + RetSqlName("ZZY") + " "
cSQL += " WHERE ZZY_FILIAL = '"+xFilial("ZZY")+"' "
cSQL += "   AND ZZY_CODINT= '"+Substr(titular,1,4)+"' "   
cSQL += "   AND ZZY_CODEMP= '"+Substr(titular,5,4)+"' "    
cSQL += "   AND ZZY_MATRIC= '"+Substr(titular,9,6)+"' "   
cSQL += "   AND ZZY_TIPREG= '"+Substr(titular,15,2)+"' "    
cSQL += "   AND ZZY_DIGITO= '"+Substr(titular,17)  +"' "    
cSQL += "   AND ZZY_EDICAO= TO_CHAR(TO_DATE('"+dtoc(dEdicao)+"','dd/mm/yy'),'yyyymmdd') "    
cSQL += "   AND D_E_L_E_T_ <> '*' " 
cSQL += " UNION  "
cSQL += "SELECT NVL(SUM(ZZY_QTD),0)  QTD,NVL(SUM(ZZY_VALOR),0)  VALOR   FROM   " + RetSqlName("ZZY") + " "
cSQL += " WHERE ZZY_FILIAL = '"+xFilial("ZZY")+"' "
//cSQL += "   AND VERIENDERECOLIV('"+titular+"',TO_CHAR(TO_DATE('"+dtoc(dEdicao)+"','dd/mm/yy'),'yyyymmdd'),ZZY_CODINT||ZZY_CODEMP||ZZY_MATRIC||ZZY_TIPREG||ZZY_DIGITO)=1   "    
cSQL += "   AND VERIENDERECOLIV('"+titular+"',TO_CHAR(TO_DATE('"+dtoc(dEdicao)+"','dd/mm/yy'),'yyyymmdd'))=1   " //Angelo Henrique - Data: 30/05/2017 - Raquel otimizou a query  
cSQL += "   AND D_E_L_E_T_ <> '*'  )   "
PLSQuery(cSQL,"LIV")
cRet   := (LIV->QTDTOT)+vqtd  
cValor := (LIV->VALTOT)

LIV->(DbCloseArea())   
   
dbSelectArea("BA1")
BA1->(DbSetOrder(2))
If BA1->(MsSeek(xFilial("BA1")+Substr(titular,1,4)+Substr(titular,5,4)+Substr(titular,9,6)+Substr(titular,15,2)))
  cEst:=BA1_ESTADO
END IF

IF BA1_ESTADO ="RJ"       
  if cRet != 1 
    cRet := (cRet-1)*nValor
  else
    cRet := 0  
  endif     
  M->ZZY_VALOR := cRet-cValor 
else  //fora do RJ cobra sempre
  cRet := cRet*nValor   
  M->ZZY_VALOR := cRet  
  M->ZZY_OBS   :="Assistido reside fora do Estado do Rio -> "+cEst
END IF

Return .T.           

User Function RECORI(cAlias,nReg,nOpc) 

Private cCRPar:="1;0;1;Recibo de Entrega de Orientador"        
Private nrecno:=0

dbSelectArea("ZZY")
dbSetOrder(1)  
/*Conjunto de opções para nao mostrar a tela da SetPrint, composta por x;y;z;w, onde 
  x = vídeo(1) ou impressora(3) 
  y = Atualiza(0) ou não(1) os dados
  z = Número de cópias 
  w = Título do relatorio.
*/
    
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ CHAMADA DO RELATORIO - PASSANDO O PARAMETRO DO REL.                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ  
     
nrecno := ZZY->( RECNO() ) 


CallCrys("RECORI",Str(nrecno),cCRPar) 

//MsgStop(nrecno)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fim da Rotina...                                                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Return      

User Function COBRA(cCob)      

if cCob== "1"  
  U_VLORIENT(M->ZZY_MATUSR,M->ZZY_QTD)
else
  M->ZZY_VALOR :=0  
end if
      
Return