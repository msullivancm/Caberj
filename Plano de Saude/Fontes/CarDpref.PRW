#INCLUDE "PROTHEUS.CH"
#Include "TOPCONN.CH"
                             
/*/                                                                                      
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออออหออออออัอออออออออออปฑฑ
ฑฑบPrograma  ณCardPref  บ Autor ณAltamiro              บ Data ณ 01/10/12  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออออสออออออฯอออออออออออนฑฑ
ฑฑบDescricao ณ Rotina para Carga das Planilhas de conferencia para o      บฑฑ
ฑฑบ          ณ arquivo da Dmed de carga e trabalho                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/                  

User Function CardPref 

Local cMsg			:= ""

Private oLeTxt
Private lAbortPrint :=.F.
Private cPerg       := "CardPref"
Private cTitulo     := "Carga dados Prefeitora para Dmed"
                                                                         
SetPrvt("oDlg1","oGrp1","oSay1","oSBtn1","oSBtn2","oSBtn3")

cMsg += " Este programa ira fazer a leitura do arquivo CSV  relativo aos  " + CRLF
cMsg += " Dados de Pagamento da Prefeitura para a base da Dmed Caberj     " + CRLF
cMsg += "                                        " + CRLF
oDlg1      := MSDialog():New( 095,232,368,705,"Leitura de Arquivo CVS",,,.F.,,,,,,.T.,,,.T. )
oGrp1      := TGroup():New( 008,012,100,224,"Arquivo CVS",oDlg1,CLR_BLACK,CLR_WHITE,.T.,.F. )
oSay1      := TSay():New( 020,020,{||cMsg},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,196,076)
oSBtn1     := SButton():New( 112,140,05,{||AjustaSX1(cPerg)}		,oDlg1,,"", )
oSBtn2     := SButton():New( 112,168,01,{||OkLeTxt(),oDlg1:End()}	,oDlg1,,"", )
oSBtn3     := SButton():New( 112,196,02,{||oDlg1:End()}			,oDlg1,,"", )
oDlg1:Activate(,,,.T.)
Return
*****************************************************************************
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuno    ณ OKLETXT  บ Autor ณ                    บ Data ณ  09/04/03   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescrio ณ Funcao chamada pelo botao OK na tela inicial de processamenบฑฑ
ฑฑบ          ณ to. Executa a leitura do arquivo texto.                    บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Programa principal                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function OkLeTxt

//Local nCont			:= 0     
Private  cNomeArq	:= ""

private  ncontc     := 0 
private  nconte     := 0

Private  aDados     := {}    

Private cAliasTmp 	:= GetNextAlias()

Private  cUsua    := SubStr(cUSUARIO,7,15)     
              

cNomeArq	:= mv_par01
nproces     := mv_par02        
nProces     := 2
// 1 - inclui na pc9
// 2 - inclui na ir_benef-separ-fat 
// 3 - exclui da pc9 e da ir_benef_separ-=fat

if nproces == 1 .or. nproces == 3 
   If !File(cNomeArq) 
      MsgStop("Arquivo Invแlido! Programa encerrado.")
	  Close(oLeTxt)
	  Return
   EndIf 
EndIf         
  
Processa({||Processa1()}, cTitulo, "", .T.)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Libera impressao                                                         ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู


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

If nProces == 1 .or.  nProces == 3 
   If !File(cNomeArq)
      MsgAlert("Arquivo texto: CLIENTE.TXT nใo localizado","Atencao!")
      Return
   Endif  
   
   FT_FUSE(cNomeArq)
   FT_FGOTOP()

   ProcRegua(FT_FLASTREC()) 

   nCont := 0

   While !FT_FEOF() 

     	 IncProc('Processando...')
   
   	     cBuffer := FT_FREADLN()		//joga o conteudo da linha na variavel
 	
 	     FT_FSKIP() 
             
         aDados := separa(cBuffer,';',.T.)        
     
         if (trim(aDados[06]) == 'R$ -' .or. trim(aDados[06]) == '-')
 
            cval:= 0

         Else    
     
            cval:=replace( replace(Replace(aDados[06],',','.'),'R',''),'$','')  
        
        EndIf     
  
	    cQuery1 := CRLF+" SELECT COUNT(*) QTDA  "
	    cQuery1 += CRLF+" FROM PC9010 "
	    cQuery1 += CRLF+" WHERE PC9_FILIAL = '"+ xFilial("PC9") +"' and D_E_L_E_T_ = ' '  "
	    cQuery1 += CRLF+"   AND PC9_CPF    = '"+ adados[03] +"' "
	    cQuery1 += CRLF+"   AND PC9_ANO    = '"+ adados[01] +"' "
	    cQuery1 += CRLF+"   AND PC9_MES    = '"+ adados[02] +"' "
	    cQuery1 += CRLF+"   AND PC9_CODINT = '0001' "  
	    cQuery1 += CRLF+"   AND PC9_CODEMP = '0024' " 
	    cQuery1 += CRLF+"   AND PC9_MATRIC = '"+ adados[04] +"' "
	    cQuery1 += CRLF+"   AND PC9_TIPREG = '"+ adados[05] +"' "
      
        If Select((cAliasTmp)) <> 0 
          (cAliasTmp)->(DbCloseArea()) 
        Endif
 
        TCQuery cQuery1 New Alias (cAliasTmp)  
    
        (cAliasTmp)->(dbGoTop())  	   
    
        If (cAliasTmp)->QTDA == 0 
        
           if nProces == 1   	     
   	
	           ncontc := ncontc + 1
   	         	     
	  	       reclock("PC9",.T.)                                                       
	 
				PC9->PC9_FILIAL := xFilial("PC9")   
				PC9->PC9_CPF    := adados[03] 
				PC9->PC9_ANO    := adados[01]  
				PC9->PC9_MES    := adados[02]  
				PC9->PC9_CODINT := '0001'  
				PC9->PC9_CODEMP := '0024'  
				PC9->PC9_MATRIC := adados[04]  
				PC9->PC9_TIPREG := adados[05]  
				PC9->PC9_VALOR  := Val(cval) //Val(Replace(cValToChar(aDados[06]),',','.'))   
				PC9->PC9_USUARI := substr(cNomeArq,12,19)
				PC9->PC9_LIBERA := '1' 
				PC9->PC9_PROCES := '2' 
		        
		       PC9->(MsUnlock())		    
		       
		     endIf  
	    Else                
	       if nProces == 1  
   	   	      MsgAlert("matricula mes/ano  existe na base , Cpf:"+adados[03]+"!!!","Atencao!")
   	   	   EndIF    
	   	   nconte := nconte + 1          
	   	   
	   	   If nProces == 3 
	   	   
	    	   cQuery := "DELETE IR_BENEF_SEPAR_FAT WHERE ANOBASE  = '"+adados[01]+"' "            
	    	   cQuery += "   and MESBASE = '"+adados[02] +"' "       
	    	   cQuery += "   and CODINT = '0001' "        
	    	   cQuery += "   and CODEMP = '0024' "        
	    	   cQuery += "   and MATRIC = '"+adados[04]+"' "               
	    	   cQuery += "   and TIPREG = '"+adados[05]+"' "             
	    	   cQuery += "   and ANOBASEIR = '2016'      
	    	   cQuery += "   and CPF ='"+ adados[03]+"' "
	    	   
               If Select((cAliasTmp)) <> 0 
                 (cAliasTmp)->(DbCloseArea()) 
               EndIf
 
               If TcSqlExec(cQuery) < 0
		          TcSqlError()
               Endif 
   
		        cQuery := CRLF+" DELETE   "
			    cQuery += CRLF+" FROM PC9010 "
			    cQuery += CRLF+" WHERE PC9_FILIAL = '"+ xFilial("PC9") +"' and D_E_L_E_T_ = ' '  "
			    cQuery += CRLF+"   AND PC9_CPF    = '"+ adados[03] +"' "
			    cQuery += CRLF+"   AND PC9_ANO    = '"+ adados[01] +"' "
			    cQuery += CRLF+"   AND PC9_MES    = '"+ adados[02] +"' "
			    cQuery += CRLF+"   AND PC9_CODINT = '0001' "  
			    cQuery += CRLF+"   AND PC9_CODEMP = '0024' " 
			    cQuery += CRLF+"   AND PC9_MATRIC = '"+ adados[04] +"' "
			    cQuery += CRLF+"   AND PC9_TIPREG = '"+ adados[05] +"' "
		    
                 If Select((cAliasTmp)) <> 0 
                    (cAliasTmp)->(DbCloseArea()) 
                 EndIf
 
                 If TcSqlExec(cQuery) < 0
		          TcSqlError()
                 Endif 
  
          
             endIf 
	   	EndIf       
       EndDo   

    Else    

 cQuery := "INSERT INTO IR_BENEF_SEPAR_FAT ( "
 cQuery += " SELECT pc9_ano anobase   , pc9_mes mesbase   , 0 MATANT, pc9_codint codint , "
 cQuery += "        PC9_CODEMP CODEMP , pc9_matric matric , pc9_tipreg tipreg , "
 cQuery += "        (select ba1_digito from ba1010 where ba1_filial =' ' and ba1_codint = '0001' and ba1_codemp = '0024' and ba1_matric = pc9_matric and ba1_tipreg = pc9_tipreg and d_E_L_E_T_ = ' ' ) digito , "
 cQuery += "        pc9_valor valor , '2016' anoseir ,  pc9_cpf cpf "
 cQuery += "        from pc9010 "
 cQuery += "        where pc9_usuari =  '"+substr(cNomeArq,12,19)+ "'" 
 cQuery += "        and pc9_ano||pc9_mes <> '201612' ) "


       ncontc := ncontc + 1
      
       nconte := ncontE + 1
       
       
       	If TcSqlExec(cQuery) < 0
		   TcSqlError()
	    Endif
   	
EndIf
   	
Return 
//////////////////////////////////////    

Static Function AjustaSX1(cPerg)

Local aHelpPor := {}

PutSx1(cPerg,"01",OemToAnsi("Arquivo Primavida  ")	    ,"","","mv_ch1","C",060,0,0,"G","U_fGetFile('csv     (*.csv)            | *.csv | ')","","","","mv_par01","","","","","","","","","","","","","","","","",aHelpPor,{},{})
PutSx1(cPerg,"02",OemToAnsi("Processar          ")     	,"","","mv_ch2","N",01,0,0,"C","","","","","mv_par02","Carga Planilha ","","","","Carga Arquivo","","","","Limpa arquivos","","","","","","","","",{},{},{})    
PutSx1(cPerg,"03",OemToAnsi("Cod. Empresa   ") 	    	,"","","mv_ch3","C",04,0,0,"G","","","","","mv_par03","","","","","","","","","","","","","","","","","",{},{})     
PutSx1(cPerg,"04",OemToAnsi("Cod. Matricula  ") 		,"","","mv_ch4","C",06,0,0,"G","","","","","mv_par04","","","","","","","","","","","","","","","","","",{},{})    
PutSx1(cPerg,"05",OemToAnsi("Ano a Importar  ") 		,"","","mv_ch5","C",04,0,0,"G","","","","","mv_par05","","","","","","","","","","","","","","","","","",{},{})    

Pergunte(cPerg,.T.)

RETURN()      
      
