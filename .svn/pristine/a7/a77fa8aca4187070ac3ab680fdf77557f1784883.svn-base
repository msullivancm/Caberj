#INCLUDE "protheus.ch"  
#INCLUDE 'UTILIDADES.CH'
#INCLUDE "topconn.ch"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ CABA110  º Autor ³ Altamiro Affonso   º Data ³  11/09/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ CALCULO DA COMISSÃO cUSTOMIZADO                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP6 IDE                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function CABA110

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Local cDesc1         := "Este programa tem como objetivo fazer o calculo da comissao customizado "
Local cDesc2         := " em virtude da demora do processo padrao  "
Local cDesc3         := " "
Local cPict          := ""
Local titulo         := "Calculo da Comisao   "
Local nLin           := 80 															
Local Cabec1         := " Vendedor                                   Empresa                                 Cliente                                 Vlr Base       %          Vlr Com.    Mes/Ano Cobr.  Mes/Ano Dev. "
//                       12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//                       0        1         2         3         4         5         6         7         8         9         10        11        12        13        14        15        16        17
//                       XXXX.XXXX.XXXXXX - XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX    XXX  XXXXXXXXX   XX  999.999.999,99 999.999.999,99  xx/xx/xxxx   XXXX      XX
//                      BK2_PROPRI||BK2_CODLAN,                                    Sum(BK2_SALDO) 
Local Cabec2         := ""
Local imprime        := .T.
Local aOrd           := {}
Private lEnd         := .F.
Private lAbortPrint  := .F.
Private CbTxt        := ""
Private limite       := 220
Private tamanho      := "G"
Private nomeprog     := "CABA110"
Private nTipo        := 15
Private aReturn      := { "Zebrado", 1, "Administracao", 1, 2, 1, "", 1}
Private nLastKey     := 0
Private cbtxt        := Space(10)
Private cbcont       := 00
Private CONTFL       := 01
Private m_pag        := 01
Private wnrel        := "CABA110"
Private cString      := "BXQ"
Private cPerg        := "CABA110   "
Private vlr_tot      := 0.00  
Private vlr_Sald     := 0.00                                                                      
Private cquebra      := " " 
Private lflagtot     :=.F.
private cNovGrpPag   := " "     

private  nMACob      := ' '                                                   
private  nMADev      := ' '                                                         
private  vlr_TotCom  := 0.00
private  vlr_TotBas  := 0.00  
private  cseq        :=' '    
private nQtdReg      := 0  
private Qtdcontr     := 0  
private lProces      := .T.

dbSelectArea("SE2")
dbSetOrder(1)

ValidPerg(cPerg)
If Pergunte(cPerg,.T.) = .F.
	Return
Endif
           
private cMesBase:= substr(MV_PAR01,1,2)      
private cAnoBase:= substr(MV_PAR01,4,4)        
private cOper   := MV_PAR02
private cEmpDe  := MV_PAR03
private cEmpAte := MV_PAR04
private cConDe  := MV_PAR05
private cConAte := MV_PAR06
private cSubDe  := MV_PAR07
private cSubAte := MV_PAR08
private cVenDe  := MV_PAR09
private cVenAte := MV_PAR10
private cEquDe  := MV_PAR11
private cEquAte := MV_PAR12 

private nAcao   := MV_PAR14
private dDtbxDe := dtos(MV_PAR15)
private dDtbxAte:= dtos(MV_PAR16)    

private cMatricD:= MV_PAR17 
private cMatricA:= MV_PAR18      
private cNumtit := MV_PAR19

private cMes    := substr(MV_PAR01,1,2)
private cAno    := substr(MV_PAR01,4,4)     


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta a interface padrao com o usuario...                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//wnrel := SetPrint(cString,NomeProg,"",@titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,.F.,Tamanho,,.T.)

If nLastKey == 27
	Return
Endif

//SetDefault(aReturn,cString)

If nLastKey == 27
	Return
Endif

//nTipo := If(aReturn[4]==1,15,18)           

 
Processa({||CalcCom() }, 'Calculando Programação de Comissões ...')    


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFun‡„o    ³CALCCOM   º Autor ³ AP6 IDE            º Data ³  11/09/2015 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescri‡„o ³ Funcao auxiliar chamada pela RPTSTATUS. A funcao RPTSTATUS º±±
±±º          ³ monta a janela com a regua de processamento.               º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Programa principal                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

               

Static Function CalcCom()
Local nOrdem
Local cQuery := ' '
Local nI := 0                                          

ProcRegua(0)

For nI := 1 to 5
 IncProc('Processando...')    
Next
 lProces := VerifSit()
if !lProces
   return()
EndIf   

dbSelectArea(cString)
dbSetOrder(1)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ SETREGUA -> Indica quantos registros serao processados para a regua ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//SetRegua(RecCount())    

 
cQuery := " select BM1_ANO    , BM1_MES    , '000018' BXO_CODVEN , "
cQuery += " ' ' BXO_CODEQU , BM1_PREFIX , BM1_NUMTIT , "
cQuery += " BM1_PARCEL , BM1_TIPTIT , BM1_CODINT  , "
cQuery += " BM1_CODEMP , BM1_MATRIC , BM1_TIPREG  , "
cQuery += " BM1_DIGITO , BM1_CONEMP , BM1_VERCON  , "
cQuery += " BM1_SUBCON , BM1_VERSUB , '999999' BXP_SEQBXO  , "
cQuery += " BM1_NUMPAR , (BM1_VALOR - VODO.VALOR_PARTE_DENTAL)   , 5   percon ,  "    

cQuery += " E1_VALOR , E1_SALDO , ba1.BA1_TIPUSU TIPUSU ,  BM1_CODPLA codpla , "            

cQuery += " trunc((bm1_valor - VODO.VALOR_PARTE_DENTAL ),2)vlrbase , "          
cQuery += " trunc((((bm1_valor  - VODO.VALOR_PARTE_DENTAL)* 5 )/100 ),2) vlrcomi   ,  count(*)    "

cQuery += " from " + RetSqlName('BM1') + " BM1 , " 
cQuery +=            RetSqlName('BFQ') + " BFQ , "
cQuery +=            RetSqlName('BA1') + " BA1 , "
cQuery +=            RetSqlName('SE1') + " SE1 , "  
cQuery += "          SIGA.VALOR_PARTE_ODONTO_PREFEITURA  VODO"

 
cQuery += "   where bm1_filial = '" + xFilial("BM1") + "' and bm1.D_E_L_E_T_ = ' ' "
cQuery += "   and ba1_filial = '" + xFilial("BA1") + "' and ba1.D_E_L_E_T_ = ' ' "   
cQuery += "   and  e1_filial = '" + xFilial("SE1") + "' and SE1.D_E_L_E_T_ = ' ' "  
      
cQuery += " and bm1_ano = '"+substr(mv_par01,4,4)+"' and  bm1_mes = '"+substr(mv_par01,1,2)+"' " 
cQuery += " and bm1_codemp >= '"+cEmpDe+"' and bm1_codemp <= '"+cEmpAte +"' "       
cQuery += " and BM1_CONEMP >= '"+cConDe+"' and BM1_CONEMP <= '"+cConAte+"'  
cQuery += " and BM1_SUBCON >= '"+cSubDe+"' and BM1_SUBCON <= '"+cSubAte+"'       

If !EMPTY(cMatricD)  
  cQuery += " AND BM1_MATRIC >= '"+cMatricD+"' AND  BM1_MATRIC <= '"+cMatricA+"' "      
EndIf  
                              
cQuery += " and ba1_codint = bm1_codint "
cQuery += " and ba1_codemp = bm1_codemp "
cQuery += " and ba1_matric = bm1_matric "
cQuery += " and ba1_tipreg = bm1_tipreg "

cQuery += " and BM1_PREFIX = e1_prefixo "   
cQuery += " and BM1_NUMTIT = e1_num     "
cQuery += " and BM1_PARCEL = e1_Parcela "  
cQuery += " and BM1_TIPTIT = e1_tipo    "     
cQuery += " and BM1_codtip = '101'      "    

cQuery += " and BM1_CODPLA  = VODO.COD_PLANO "

if  mv_par13 = 1
    cQuery += " and se1.e1_saldo = 0 "
EndIf           

if !empty(cNumtit)                    
    cQuery += " and se1.e1_prefixo ||se1.e1_num  = '"+cNumtit +"' "        
EndIf 

cQuery += " and se1.e1_Baixa >= '"+dDtbxDe+"' and se1.e1_Baixa <= '"+dDtbxate+"' "

cQuery += " and bm1_codtip = bfq_propri||bfq_codlan and bfq_comiss = '1' "
cQuery += " and bm1_numtit <> ' '      "
      
cQuery += "  group by BM1_ANO    , BM1_MES    , BM1_PREFIX , BM1_NUMTIT ,  BM1_PARCEL , "
cQuery += "        BM1_TIPTIT , BM1_CODINT  ,  BM1_CODEMP , BM1_MATRIC , BM1_TIPREG  ,  BM1_DIGITO , BM1_CONEMP , BM1_VERCON  ,  "
cQuery += "        BM1_SUBCON , BM1_VERSUB  ,  BM1_NUMPAR , (BM1_VALOR - VODO.VALOR_PARTE_DENTAL)   , "   
cQuery += "        E1_VALOR , E1_SALDO , ba1.BA1_TIPUSU  ,  BM1_CODPLA  ,VODO.VALOR_PARTE_DENTAL  "   

cQuery += " order by bm1_matric  , bxo_codven "

 If Select(("TMP")) <> 0 
       ("TMP")->(DbCloseArea())  
 Endif

    TCQuery cQuery Alias "TMP" New 
    dbSelectArea("TMP")
    tmp->(dbGoTop())           
       
    Qtdcontr := 0     
                             
  BXQ->(dBSetOrder(1))
                                          
 While !TMP->(EOF())         
  /*  
    If substr(mv_par01,4,4) + substr(mv_par01,1,2) > '201607'  

       nVlrpla := u_fRetVlrOdo( TMP->TIPUSU , TMP->CODPLA , TMP->E1_VALOR , TMP->E1_SALDO )         
       nASCOM  := TMP->BM1_VALOR - nVlrpla 
       nVLRCOM := BXQ_BASCOM * 0.05 
       
    EndIf    
*/
    
    If nQtdReg > 0    

       If BXQ->(msSeek(xFilial("BXQ")+;             
                      alltrim(TMP->BM1_ANO)+;
                      alltrim(TMP->BM1_MES)+;
                      alltrim(TMP->BXO_CODVEN)+;
                      alltrim(TMP->BM1_PREFIX)+;
                      Alltrim(TMP->BM1_NUMTIT)+;
                             (TMP->BM1_PARCEL)+;
                      Alltrim(TMP->BM1_CODINT)+;
                      Alltrim(TMP->BM1_CODEMP)+;
                      Alltrim(TMP->BM1_MATRIC)+;
                      Alltrim(TMP->BM1_TIPREG)))                               
                               
          If  BXQ->BXQ_NUMPAR == TMP->BM1_NUMPAR .and. BXQ->BXQ_PERCOM == TMP->percon
                
              TMP->(dbSkip())
            
              Qtdcontr++  
              
              nQtdReg-- 
              
              Loop
              
          EndIf      
            
       EndIf    
         
    EndIf     

    If lProces
    
       reclock("BXQ",.T.)                                                       
 
       cseq:=nextcodtab('BXQ', 'BXQ_SEQ',.T.)      
 
       BXQ->BXQ_FILIAL := xFilial("BXQ")   
       BXQ->BXQ_ANO    := TMP->BM1_ANO
       BXQ->BXQ_MES    := TMP->BM1_MES
       BXQ->BXQ_CODVEN := TMP->BXO_CODVEN
       BXQ->BXQ_CODEQU := TMP->BXO_CODEQU
	   BXQ->BXQ_PREFIX := TMP->BM1_PREFIX 
	   BXQ->BXQ_NUM    := TMP->BM1_NUMTIT
	   BXQ->BXQ_PARC   := TMP->BM1_PARCEL 
	   BXQ->BXQ_TIPO   := TMP->BM1_TIPTIT
	   BXQ->BXQ_CODINT := TMP->BM1_CODINT
	   BXQ->BXQ_CODEMP := TMP->BM1_CODEMP
	   BXQ->BXQ_MATRIC := TMP->BM1_MATRIC
	   BXQ->BXQ_TIPREG := TMP->BM1_TIPREG
	   BXQ->BXQ_DIGITO := TMP->BM1_DIGITO
       BXQ->BXQ_NUMCON := TMP->BM1_CONEMP
       BXQ->BXQ_VERCON := TMP->BM1_VERCON
       BXQ->BXQ_SUBCON := TMP->BM1_SUBCON
       BXQ->BXQ_VERSUB := TMP->BM1_VERSUB
       BXQ->BXQ_DATA   := dDataBase
       BXQ->BXQ_SEQBXO := TMP->BXP_SEQBXO
       BXQ->BXQ_SEQ    := cseq
       BXQ->BXQ_NUMPAR := TMP->BM1_NUMPAR
       BXQ->BXQ_BASCOM := TMP->vlrbase
       BXQ->BXQ_PERCOM := TMP->percon
       BXQ->BXQ_VLRCOM := TMP->vlrcomi 
       BXQ->BXQ_REFERE := '2'
       BXQ->BXQ_PAGCOM := '2'
       BXQ->BXQ_PAGPER := 100  
       
       BXQ->(MsUnlock())		
   
    EndIf   
   
    tmp->(dbSkip())   // Avanca o ponteiro do registro no arquivo

 EndDo    
   
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Finaliza a execucao do relatorio...                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//SET DEVICE TO SCREEN

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Se impressao em disco, chama o gerenciador de impressao...          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ


Return   
 
/*Static Function FverReg()
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
  	//³ Se já existir calculo, não calcular novamente para mesma parcela.		³
  	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
  	
	//BXQ_FILIAL+BXQ_ANO+BXQ_MES+BXQ_CODVEN+BXQ_PREFIX+BXQ_NUM+BXQ_PARC+BXQ_CODINT+BXQ_CODEMP+BXQ_MATRIC+BXQ_TIPREG+BXQ_DIGITO+BXQ_PAGCOM+BXQ_REFERE
    BXQ->(dBSetOrder(1))
    If BXQ->(msSeek(xFilial("BXQ")+ TMP->BM1_ANO+TMP->BM1_MES+TMP->BXO_CODVEN+TMP->BM1_PREFIX+Alltrim(TMP->BM1_NUMTIT)+TMP->BM1_PARCEL+Alltrim(TMP->BM1_CODINT)+Alltrim(TMP->BM1_CODEMP)+Alltrim(TMP->BM1_MATRIC)+Alltrim(TMP->BM1_TIPREG)))
         TMP->(dbSkip())
         Loop
    EndIf                                         
RETURN 
    
*/    

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ValidPerg º Autor ³ Jose Carlos Noronhaº Data ³ 01/08/07    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Parametros para selecao dos titulos do PLS                 º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³                                                            º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ValidPerg() 

Local aArea := GetArea()
Local aRegs := {}
Local i,j             

cPerg := PADR(cPerg,7)

dbSelectArea("SX1")
dbSetOrder(1)        


aAdd(aRegs,{cPerg,"01","Mes/Ano Comissao?","","","mv_ch1","C",07,0,0,"G","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "99/9999", "" })
aAdd(aRegs,{cPerg,"02","Cod operadora   ?","","","mv_ch2","C",04,0,0,"G","","mv_par02","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "", "" })
aAdd(aRegs,{cPerg,"03","Cod Empresa De  ?","","","mv_ch3","C",04,0,0,"G","","mv_par03","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "", "" })
aAdd(aRegs,{cPerg,"04","Cod Empresa Ate ?","","","mv_ch4","C",04,0,0,"G","","mv_par04","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "", "" })
aAdd(aRegs,{cPerg,"05","Contrato De     ?","","","mv_ch5","C",12,0,0,"G","","mv_par05","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "", "" })
aAdd(aRegs,{cPerg,"06","Contrato Ate    ?","","","mv_ch6","C",12,0,0,"G","","mv_par06","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "", "" })
aAdd(aRegs,{cPerg,"07","Sub Contr De    ?","","","mv_ch7","C",09,0,0,"G","","mv_par07","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "", "" })
aAdd(aRegs,{cPerg,"08","Sub Contr Ate   ?","","","mv_ch8","C",09,0,0,"G","","mv_par08","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "", "" })
aAdd(aRegs,{cPerg,"09","Vendedor De     ?","","","mv_ch9","C",06,0,0,"G","","mv_par09","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "", "" })
aAdd(aRegs,{cPerg,"10","Vendedor Ate    ?","","","mv_ch10","C",06,0,0,"G","","mv_par10","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "", "" }) 
aAdd(aRegs,{cPerg,"11","Equipe  De      ?","","","mv_ch11","C",03,0,0,"G","","mv_par11","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "", "" })
aAdd(aRegs,{cPerg,"12","Equipe  Ate     ?","","","mv_ch12","C",03,0,0,"G","","mv_par12","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "", "" })
Aadd(aRegs,{cPerg,"13","Só Tit Pagos    ?","","","mv_ch13","N",01,0,0,"C","","mv_par13","Sim","","","","","","Nao","","","","","","","","","","","","","","","","" , "", "", ""})
Aadd(aRegs,{cPerg,"14","Ação            ?","","","mv_ch14","N",01,0,0,"C","","mv_par14","Novo Calculo","","","","","Descalculo","","","Calculo Compl.","Calculo Compl.","Calculo Compl.","","","","","","","","","","","","" , "", "", ""})
aadd(aRegs,{cPerg,"15","Baixa De         ","","","mv_ch15","D",8,0,0,"G","","mv_par15","" ,"","","","","","","","","","","","","","","","","","","","","","","","",""})
aadd(aRegs,{cPerg,"16","Baixa Ate        ","","","mv_ch16","D",8,0,0,"G","NaoVazio() .And. mv_par16 >= mv_par15","mv_par16","" ,"","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"17","Matricula De    ?","","","mv_ch17","C",06,0,0,"G","","mv_par17","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "", "" })
aAdd(aRegs,{cPerg,"18","Matricula Ate   ?","","","mv_ch18","C",06,0,0,"G","","mv_par18","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "", "" }) 
aAdd(aRegs,{cPerg,"19","Tit.Rec.(Pref,Num)?","","","mv_ch19","C",12,0,0,"G","","mv_par19","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "", "" })


For i:=1 to Len(aRegs)
	If !dbSeek(cPerg+"   "+aRegs[i,2])
		RecLock("SX1",.T.)
		For j:=1 to FCount()
			If j <= Len(aRegs[i])
				FieldPut(j,aRegs[i,j])
			Endif
		Next
		MsUnlock()
	Endif
Next
RestArea(aArea)
Return(.T.)        


////////////               
Static Function VerifSit()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Query para verIficar se ja houve calculo                                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

dbSelectArea("BXQ")

cQuery1 := " SELECT COUNT(*) COUNT " 
cQuery1 += "  FROM " + RetSQLName("BXQ")  + " BXQ "
cQuery1 += "  WHERE BXQ.BXQ_FILIAL =  ' " + xFilial("BXQ")    + "' "
cQuery1 += "    AND BXQ.BXQ_CODINT =  '"  + cOper             + "' "
cQuery1 += "    AND BXQ.BXQ_CODEMP >= '"  + cEmpDe            + "' "
cQuery1 += "    AND BXQ.BXQ_CODEMP <= '"  + cEmpAte           + "' "   
      
cQuery1 += "    AND BXQ.BXQ_NUMCON >= '"  + cConDe            + "' "
cQuery1 += "    AND BXQ.BXQ_NUMCON <= '"  + cConAte           + "' "
cQuery1 += "    AND BXQ.BXQ_SUBCON >= '"  + cSubDe            + "' "
cQuery1 += "    AND BXQ.BXQ_SUBCON <= '"  + cSubAte           + "' "
cQuery1 += "    AND BXQ.BXQ_CODVEN >= '"  + cVenDe            + "' "
cQuery1 += "    AND BXQ.BXQ_CODVEN <= '"  + cVenAte           + "' "
cQuery1 += "    AND BXQ.BXQ_CODEQU >= '"  + cEquDe            + "' "
cQuery1 += "    AND BXQ.BXQ_CODEQU <= '"  + cEquAte           + "' "
cQuery1 += "    AND BXQ.BXQ_ANO    =  '"  + cAno              + "' "
cQuery1 += "    AND BXQ.BXQ_MES    =  '"  + cMes              + "' "   

if !empty(cNumtit)                    
    cQuery1 += " and bxq_prefix ||bxq_num  = '"+cNumtit +"' "        
EndIf 

cQuery1 += "    AND BXQ.D_E_L_E_T_ <> '*' " 
 If !EMPTY(cMatricD)  
     cQuery1 += " AND BXQ_MATRIC >= '"+cMatricD+"' AND  BXQ_MATRIC <= '"+cMatricA+"' "      
 EndIf  

cQuery1	:= ChangeQuery(cQuery1)
TcQuery cQuery1 New Alias "BXQTMP" 
TcSetField("BXQTMP","COUNT","N",15,0)
                   
nQtdReg := COUNT

dbCloseArea()          

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Novo Calculo   e   Ja Tem Calculo Realizado                                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If  nacao == 1 
    if  nQtdReg > 0 
    	Aviso("Cálculo de Comissões","Não será possível realizar novo cálculo, pois já existe comissão calculada para os parametros informados. Selecione Descálculo ou Reprocessar.", {"Ok"}) //"Cálculo de Comissões"###"Não será possível realizar novo cálculo, pois já existe comissão calculada para os parametros informados. Selecione Descálculo ou Reprocessar."
	    Return(.F.)     
    Else 	       
        Return(.T.)
    EndIf  
EndIf
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Cancelamento de Calculo                                                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If  nAcao == 2  // Quer cancelar calculo 
    If  nQtdReg == 0 // Nao Tem Calculo Realizado
  	    Aviso("Cálculo de Comissões","Não é possível fazer o descálculo pois não existem comissões cálculadas para os parametros informados.", {"Ok"}) //"Cálculo de Comissões"###"Não é possível fazer o descálculo pois não existem comissões cálculadas para os parametros informados."
	    Return(.F.)
    Else
        cQuery := " SELECT COUNT(*) COUNT " 
        cQuery += " FROM " + RetSQLName("BXQ") + " BXQ "
        cQuery += " WHERE BXQ.BXQ_FILIAL =  '"  + xFilial("BXQ")    + "' "
        cQuery += "    AND BXQ.BXQ_CODINT =  '"  + cOper             + "' "
        cQuery += "    AND BXQ.BXQ_CODEMP >= '"  + cEmpDe            + "' "
        cQuery += "    AND BXQ.BXQ_CODEMP <= '"  + cEmpAte           + "' "
        cQuery += "    AND BXQ.BXQ_NUMCON >= '"  + cConDe            + "' "
        cQuery += "    AND BXQ.BXQ_NUMCON <= '"  + cConAte           + "' "
        cQuery += "    AND BXQ.BXQ_SUBCON >= '"  + cSubDe            + "' "
        cQuery += "    AND BXQ.BXQ_SUBCON <= '"  + cSubAte           + "' "
        cQuery += "    AND BXQ.BXQ_CODVEN >= '"  + cVenDe            + "' "
        cQuery += "    AND BXQ.BXQ_CODVEN <= '"  + cVenAte           + "' "
        cQuery += "    AND BXQ.BXQ_CODEQU >= '"  + cEquDe            + "' "
        cQuery += "    AND BXQ.BXQ_CODEQU <= '"  + cEquAte           + "' "
        cQuery += "    AND BXQ.BXQ_ANO    =  '"  + cAno              + "' "
        cQuery += "    AND BXQ.BXQ_MES    =  '"  + cMes              + "' " 
      
        if !empty(cNumtit)                    
           cQuery += " and bxq_prefix ||bxq_num  = '"+cNumtit +"' "        
        EndIf 
        
        If  BXQ->(FieldPos("BXQ_LAGER")) > 0 .and. BXQ->(FieldPos("BXQ_LAPAG")) > 0
            cQuery += "    AND (BXQ.BXQ_DTGER  <> '        ' OR BXQ.BXQ_LAGER <> ' ' OR BXQ.BXQ_LAPAG <> ' ') "
        Else
            cQuery += "    AND BXQ.BXQ_DTGER  <> '        ' "
        EndIf 

        If !EMPTY(cMatricD)  
            cQuery += " AND BXQ_MATRIC >= '"+cMatricD+"' AND  BXQ_MATRIC <= '"+cMatricA+"' "      
        EndIf  

        cQuery += "    AND BXQ.D_E_L_E_T_ <> '*' "
        
		cQuery	:= ChangeQuery(cQuery)
		TcQuery cQuery New Alias "BXQTMP"
		TcSetField("BXQTMP","COUNT","N",15,0)
		
        
        nQtdReg := COUNT
                
        dbCloseArea()
        If  nQtdReg > 0 // Tem Calculo Realizado Ja Enviado para Pagamento
  	        Aviso("Cálculo de Comissões","Não é possível fazer o descálculo porque ja houve liberação para pagamento de comissões para os parametros informados.", {"Ok"}) //"Cálculo de Comissões"###"Não é possível fazer o descálculo porque ja houve liberação para pagamento de comissões para os parametros informados."
	        Return(.F.)
        EndIf
    EndIf
EndIf	
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ VerIfica se deve excluir comissoes calculadas                              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If  nAcao == 2
	If  Aviso("Cálculo de Comissões","Todas as comissões calculadas para os parametros informados serão apagadas.", {"Confirma","Cancelar"}) == 1 //"Cálculo de Comissões"###"Todas as comissões calculadas para os parametros informados serão apagadas."###"Confirma"###"Cancelar"
        //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
        //³ Efetuando a exclusao da comissao                                   ³
        //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		cQuery := " SELECT R_E_C_N_O_ RECBXQ FROM "+RetSqlName("BXQ")
	    cQuery += " WHERE BXQ_FILIAL = '"   + xFilial("BXQ")  + "' "
        cQuery += "    AND BXQ_CODINT =  '" + cOper   + "' "
        cQuery += "    AND BXQ_CODEMP >= '" + cEmpDe  + "' "
        cQuery += "    AND BXQ_CODEMP <= '" + cEmpAte + "' "
        cQuery += "    AND BXQ_NUMCON >= '" + cConDe  + "' "
        cQuery += "    AND BXQ_NUMCON <= '" + cConAte + "' "
        cQuery += "    AND BXQ_SUBCON >= '" + cSubDe  + "' "
        cQuery += "    AND BXQ_SUBCON <= '" + cSubAte + "' "
        cQuery += "    AND BXQ_CODVEN >= '" + cVenDe  + "' "
        cQuery += "    AND BXQ_CODVEN <= '" + cVenAte + "' "
        cQuery += "    AND BXQ_CODEQU >= '" + cEquDe  + "' "
        cQuery += "    AND BXQ_CODEQU <= '" + cEquAte + "' "
        cQuery += "    AND BXQ_ANO    =  '" + cAno    + "' "
        cQuery += "    AND BXQ_MES    =  '" + cMes    + "' " 
        
     if !empty(cNumtit)                    
        cQuery += " and bxq_prefix ||bxq_num  = '"+cNumtit +"' "        
     EndIf 
        CQUERY += "    AND BXQ_DTGER  = '        '"           
     If !EMPTY(cMatricD)  
        cQuery += " AND BXQ_MATRIC >= '"+cMatricD+"' AND  BXQ_MATRIC <= '"+cMatricA+"' "      
     EndIf  
        
        cQuery  += "    AND D_E_L_E_T_ <> '*' "
		cQuery	:= ChangeQuery(cQuery)
        dbusearea( .T. ,"TOPCONN",TCGenQry(,,cQuery),"TMPBXQ", .F. , .T. )
		TcSetField("TMPBXQ","RECBXQ","N",15,0) 
		
        TMPBXQ->(DbGoTop())
        Do While ! TMPBXQ->(Eof())
           BXQ->(DbGoTo(TMPBXQ->RECBXQ))
           RecLock("BXQ", .F.)
               BXQ->(DbDelete())
           BXQ->(MsUnlock())
           TMPBXQ->(DbSkip())
        EndDo
        TMPBXQ->(DbCloseArea())
		TCRefresh("BXQ")
		Return(.F.)
	EndIf    
EndIf        
If  nAcao == 3	
    Return(.T.)
EndIf    

