#INCLUDE "protheus.ch"  
#INCLUDE 'UTILIDADES.CH'
#INCLUDE "topconn.ch"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ CABA104  º Autor ³ Altamiro Affonso   º Data ³  10/11/09   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ manutenção automatica do cadastro de assistido             º±±
±±º          ³                 BA1 BA3                                    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP6 IDE                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function CABA105

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Local cDesc1         := "Este programa tem como objetivo fazer a manutencao dos cadastro de assitidos (BA1 e BA3) "
Local cDesc2         := "Podendo a suas funcionaliadde serem extendidas para Troca de contrato e sub_contrado "
Local cDesc3         := " ou qualquer outra manutençcao em massa nestes cadastros "
Local cPict          := ""
Local titulo         := "Manutencao nos cadastros de assistidos "
Local nLin           := 220 															

Local Cabec1         := " Matricula completa   Nome                                         Contrato   Versao   Sub Contr.  Versao   Vendedor     Novo Vend. CPF          CPF PREPOSTO   Dt Nasc     Nome da Mãer"
//                       12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//                       0        1         2         3         4         5         6         7         8         9         10        11        12        13        14        15        16        17        18        19        20
//                       XXX-XXXXXXXXX-X-XXX   XXXXXX - XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX  XX/XX/XXXX  XX/XX/XXXX   XXXXXXX     XXXXXXX     .999,99  XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX


Local Cabec2         := ""
Local imprime        := .T.
Local aOrd           := {}
Private lEnd         := .F.
Private lAbortPrint  := .F.
Private CbTxt        := ""
Private limite       := 220
Private tamanho      := "G"
Private nomeprog     := "CABA105"
Private nTipo        := 15
Private aReturn      := { "Zebrado", 1, "Administracao", 1, 2, 1, "", 1}
Private nLastKey     := 0
Private cbtxt        := Space(10)
Private cbcont       := 00
Private CONTFL       := 01
Private m_pag        := 01
Private wnrel        := "CABA105"
Private cString      := "SE2"
Private cPerg        := "CABA105   "
Private vlr_tot      := 0.00  
Private vlr_Sald     := 0.00                                                                      
Private cquebra      := " " 
Private lflagtot     :=.F.
private cNovGrpPag   := " "      
PRIVATE nSucesso     := 0

private  nMACob      := ' '                                                   
private  nMADev      := ' '                                                         
private  vlr_TotCom  := 0.00                                                                                
private  ncont       := 0
private  vlr_TotBas  := 0.00  
private  cseq        :=' '

dbSelectArea("SE2")
dbSetOrder(1)

ValidPerg(cPerg)
If Pergunte(cPerg,.T.) = .F.
	Return
Endif
                                

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta a interface padrao com o usuario...                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

wnrel := SetPrint(cString,NomeProg,"",@titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,.F.,Tamanho,,.T.)

If nLastKey == 27
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
	Return
Endif

nTipo := If(aReturn[4]==1,15,18)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Processamento. RPTSTATUS monta janela com a regua de processamento. ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

RptStatus({|| RunReport(Cabec1,Cabec2,Titulo,nLin) },Titulo)
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFun‡„o    ³RUNREPORT º Autor ³ AP6 IDE            º Data ³  31/08/07   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescri‡„o ³ Funcao auxiliar chamada pela RPTSTATUS. A funcao RPTSTATUS º±±
±±º          ³ monta a janela com a regua de processamento.               º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Programa principal                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function RunReport(Cabec1,Cabec2,Titulo,nLin)

Local nOrdem
Local cQuery := ' '                                          
dbSelectArea(cString)
dbSetOrder(1)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ SETREGUA -> Indica quantos registros serao processados para a regua ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetRegua(RecCount())       
                                                                
cQuery := " select * from " + RetSqlName('BA1') + " BA1 where ba1_codint = '0001' and ba1_codemp = '"+mv_par01+"'"
cQuery += " and ba1_conemp = '"+mv_par02+"' and ba1_vercon = '"+mv_par03+"' and ba1_subcon = '"+mv_par04+"' and ba1_versub = '"+mv_par05+"' "
If !Empty  (mv_par06)                         
   cQuery += " and ba1_matric in "+FormatIn(mv_par06, ",")
EndIf 
/*
If !Empty  (mv_par07) 
   cQuery += " and ba1_tipreg = '"+mv_par07+"' "
EndIf                 

If !Empty  (mv_par08)
   cQuery += "  and ba1_digito = '"+mv_par08+"' " 
EndIf
*/                             
If mv_par09  = 1 
   cQuery += " and ba1_image  = 'ENABLE'
EndIf                                                                                                                           

If mv_par10 = 1  // .or. !empty (mv_par12).or. !empty (mv_par13))
// ba1
      cQuery1 := " UPDATE "+RetSqlName("ba1")+ " SET "
      If !empty (mv_par11)
          cQuery1 += " ba1_codven = '"+mv_par11+"'"
      EndIf                                                                                
/*      If !empty (mv_par12)
          cQuery1 := " , ba1_conemp  = '"+mv_par12+"'"
      EndIf                                                                                 
      If !empty (mv_par13)
          cQuery1 := " , ba1_subcon  = '"+mv_par13+"'"
      EndIf
*/                                                                                           
      cQuery1 += " Where  ba1_codint = '0001' and ba1_codemp = '"+mv_par01+"'"
      cQuery1 += " and ba1_conemp = '"+mv_par02+"' and ba1_vercon = '"+mv_par03+"' and ba1_subcon = '"+mv_par04+"' and ba1_versub = '"+mv_par05+"' "
      If !Empty  (mv_par06)                         
         cQuery += " and ba1_matric in "+FormatIn(mv_par06, ",")
      EndIf 
/*
If !Empty  (mv_par07) 
   cQuery += " and ba1_tipreg = '"+mv_par07+"' "
EndIf                 

If !Empty  (mv_par08)
   cQuery += "  and ba1_digito = '"+mv_par08+"' " 
EndIf
*/ 
      If mv_par09  = 1 
         cQuery1 += " and ba1_image  = 'ENABLE'
      EndIf                                                    
// ba3
      cQuery2 := " UPDATE "+RetSqlName("ba3")+ " SET "
      If !empty (mv_par11)
          cQuery2 += " ba3_codven = '"+mv_par11+"'"
      EndIf                                                                                
/*      If !empty (mv_par12)
          cQuery2 := " , ba3_conemp  = '"+mv_par12+"'"
      EndIf                                                                                 
      If !empty (mv_par13)
          cQuery2 := " , ba3_subcon  = '"+mv_par13+"'"
      EndIf                                                                                     
*/   
      cQuery2 += " Where  ba3_codint = '0001' and ba3_codemp = '"+mv_par01+"'"
      cQuery2 += " and ba3_conemp = '"+mv_par02+"' and ba3_vercon = '"+mv_par03+"' and ba3_subcon = '"+mv_par04+"' and ba3_versub = '"+mv_par05+"' "
      If !Empty  (mv_par06)                         
         cQuery += " and ba1_matric in "+FormatIn(mv_par06, ",")
      EndIf 
/*
If !Empty  (mv_par07) 
   cQuery += " and ba1_tipreg = '"+mv_par07+"' "
EndIf                 

If !Empty  (mv_par08)
   cQuery += "  and ba1_digito = '"+mv_par08+"' " 
EndIf
*/       If mv_par09  = 1 
         cQuery2 += " and ba3_image  = 'ENABLE'
      EndIf                                                          
   EndIf                                                                                                             
   
 If Select(("TMP")) <> 0 
     ("TMP")->(DbCloseArea())  
 Endif
    TCQuery cQuery Alias "TMP" New 
    dbSelectArea("TMP")
    tmp->(dbGoTop())                  

If Select(("TMP")) <> 0 
   If mv_par10 = 1
    BEGIN TRANSACTION
		
         nSucesso1 := TcSqlExec(cQuery1)        
         
         nSucesso2 := TcSqlExec(cQuery2)       

    End TRANSACTION
   EndIf
    While !TMP->(EOF())                                                                 
	  If nLin > 65 // Salto de Página. Neste caso o formulario tem 55 linhas...
   	     nLin :=	Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
	     nLin ++
	  Endif
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica o cancelamento pelo usuario...                             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If lAbortPrint
		@nLin,00 PSAY "*** CANCELADO PELO OPERADOR ***"
		Exit
	Endif                                                     

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Impressao do cabecalho do relatorio. . .                            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ    
//Local Cabec1         := " Matricula completa   Nome                                         Contrato   Versao   Sub Contr.  Versao   Vendedor   Novo Vend. CPF          CPF PREPOSTO   Dt Nasc     Nome da Mãe"
//                       1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//                       0        1         2         3         4         5         6         7         8         9         10        11        12        13        14        15        16        17        18        19        20        21        22
//                       XXX-XXXXXXXXX-X-XXX   XXXXXX - XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX  XX/XX/XXXX  XX/XX/XXXX   XXXXXXX     XXXXXX     XXXXXX    XXXXXXXXXXXX XXXXXXXXXXXX  99/99/9999  XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

	
	
	 @ nLin,000 PSay  tmp->ba1_codint+'.'+tmp->ba1_codemp+'.'+tmp->ba1_matric+'.'+tmp->ba1_tipreg+'.'+tmp->ba1_digito 
     @ nLin,023 PSay  tmp->ba1_nomusr
	 @ nLin,065 PSay  tmp->ba1_conemp  
 	 @ nLin,080 PSay  tmp->ba1_vercon  
  	 @ nLin,087 PSay  tmp->ba1_subcon   
 	 @ nLin,101 PSay  tmp->ba1_versub   	 
 	 @ nLin,111 PSay  tmp->ba1_CODVEN     
  	 @ nLin,123 PSay  mv_par11 	          
  	 @ nLin,133 PSay  tmp->ba1_CPFUSR      
  	 @ nLin,146 PSay  tmp->ba1_CPFPRE    
	 @ nLin,160 PSay  sTOd(tmp->ba1_DATNAS)
  	 @ nLin,172 PSay  tmp->ba1_MAE    	      	   	 
  	 
  	 
  	 ncont:=ncont + 1
 	 	 

         
	nLin ++     // Avanca a linha de impressao
	dbSkip()   // Avanca o ponteiro do registro no arquivo
  EndDo    
    @ nLin,000 PSay replicate("_",220) 
    	nLin ++ 
      If mv_par10  == 1          
           @ nLin,023 PSay  ncont 
           @ nLin,028 PSay  "Registros alterados Sucesso !! " 
      Else                                                            
           @ nLin,023 PSay  ncont 
           @ nLin,028 PSay  "Registros listados , NÃO ALTERADOS !! " 
      EndIf      
	nLin ++
    @ nLin,000 PSay replicate("_",220)           
      
    		
 Else
      MsgAlert("Assistido(s)  informado(s)  Não encontrado , verifique","ATENÇÃO","INFO")                                   
 EndIf 
  
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Finaliza a execucao do relatorio...                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SET DEVICE TO SCREEN

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Se impressao em disco, chama o gerenciador de impressao...          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If aReturn[5]==1
	dbCommitAll()
	SET PRINTER TO
	OurSpool(wnrel)
Endif

MS_FLUSH()

Return


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

cPerg := PADR(cPerg,7)    

PutSx1(cPerg,"01","Cod. Empresa         "  ,"","","mv_ch01","C",06,0,0,"G","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "", "" )   
PutSx1(cPerg,"02","Numero do Contrato   "  ,"","","mv_ch02","C",12,0,0,"G","","mv_par02","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "", "" )  
PutSx1(cPerg,"03","Versão do Contrato   "  ,"","","mv_ch03","C",03,0,0,"G","","mv_par03","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "", "" )  
PutSx1(cPerg,"04","Num. do Sub Contrato "  ,"","","mv_ch04","C",09,0,0,"G","","mv_par04","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "", "" ) 
PutSx1(cPerg,"05","Versão do subContrato"  ,"","","mv_ch05","C",03,0,0,"G","","mv_par05","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "", "" )  
PutSx1(cPerg,"06","Matricula            "  ,"","","mv_ch06","C",70,0,0,"G","","mv_par06","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "", "" )  
PutSx1(cPerg,"07","Tip reg              "  ,"","","mv_ch07","C",02,0,0,"G","","mv_par07","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "", "" ) 
PutSx1(cPerg,"08","Digito               "  ,"","","mv_ch08","C",01,0,0,"G","","mv_par08","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "", "" )  
PutSx1(cPerg,"09","So Desbloqueado      "  ,"","","mv_ch09","N",01,0,0,"C","","","","","mv_par09","Sim ","","","","Não ","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"10","Grava Alteração      "  ,"","","mv_ch10","N",01,0,0,"C","","","","","mv_par10","Sim ","","","","Não ","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"11","Novo Cod. Vendedor   "  ,"","","mv_ch11","C",06,0,0,"G","","mv_par11","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "", "" )  
PutSx1(cPerg,"12","Novo Num. Contrato   "  ,"","","mv_ch12","C",12,0,0,"G","","mv_par12","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "", "" ) 
PutSx1(cPerg,"13","Novo num. Subcontrato"  ,"","","mv_ch13","C",09,0,0,"G","","mv_par13","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "", "" )  

Return(.T.)         
