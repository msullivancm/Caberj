#Include "Protheus.ch"
#Include "Rwmake.ch"
#Include "Topconn.ch"        
#include "Msole.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CHAMVALID     º Autor ³ Christian Moura        ³ Data ³     ³±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Geração de documento Word para Impressão de Chamados do    º±±
±±º          ³ FILDSERVICE                                                º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CHAMVALID                                                  º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

************************************************************ 
//Leonardo Portella - 26/05/11 - Alterado o nome da funcao para colocar conforme o .PRW
User Function CABR108
//User Function cartadmed
************************************************************        
private cArquivo := "M:\Protheus_Data\IntegracaoProtheusOffice\CartaCPF4.dot" 
private cCodEmp  := ' '
private cMatric  := ' '
private ctipreg  := ' '
private nConta   := 0                            
private cValTot  := 0.00
private cValParc := 0.00 
private ccpf     := ' ' 
private cdtnasc  := ' ' 

	Processa({|| WORDIMP()})  // Chamada do Processamento// Substituido pelo assistente de conversao do AP5 IDE em 14/02/00 ==> 	Processa({|| Execute(WORDIMP)})  // Chamada do Processamento	

Return

**********************************************************************
Static FUNCTION WORDIMP()
**********************************************************************
Local cGrava   := 'M:\Protheus_Data\spool\altamiro\cartas\'
Local cItens   := ""
Local cItens2   := ""
Local cNomCli   := " " 
Local cCNPJ  
Local cQuery := ' '

//cArquivo := 'M:\RDMakes\configurador\Modelo Chamado.dot' 


// Inicia o Word 
nVez := 1

// Inicializa o Ole com o MS-Word 97 ( 8.0 )	
oWord := OLE_CreateLink('TMsOleWord97')		

OLE_NewFile(oWord,cArquivo)
OLE_SetProperty( oWord, oleWdVisible,   .F. )
OLE_SetProperty( oWord, oleWdPrintBack, .T. ) 


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ SETREGUA -> Indica quantos registros serao processados para a regua ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
    

cQuery :=" select b1.ba1_codint|| b1.ba1_codemp|| b1.ba1_matric|| b1.ba1_tipreg|| b1.ba1_digito Matricula1, "
cQuery +=" b1.ba1_nomusr,b1.ba1_tipusu, idade_s(b1.ba1_datnas) idade, b1.ba1_cpfusr, b1.ba1_cpfpre, b1.ba1_cpfmae, b1.ba1_cpfpai, "
cQuery +=" RETORNA_DESCRI_PLANO ( 'C', BA1_CODPLA )  , Trim(bts_email) email , "
cQuery +=" Trim ( ('('||Trim(BA1_DDD)||') '||Trim(BA1_TELEFO)) || ' ' || "
cQuery +=" Decode(Trim(BA1_YTEL2),NULL,'',('('||Trim(BA1_DDD)||') '||' '||Trim(BA1_YTEL2))) || ' ' || "
cQuery +=" Decode(Trim(BA1_YCEL),NULL,'',('('||Trim(BA1_DDD)||') '||' '||Trim(BA1_YCEL))) ) FONES , "
cQuery +=" BA3_END, BA3_NUMERO, BA3_COMPLE, BA3_BAIRRO, BA3_CEP, BA3_MUN, BA3_ESTADO , b1.BA1_DATNAS ,"    
cquery +=" A1_END , A1_BAIRRO , A1_MUN ,a1_est ,A1_ESTADO  , A1_CEP "
cQuery +=" from  ba1010 b1  ,bts010  b2   , ba3010 b3 , sa1010 sa1"
cQuery +=" where b1.ba1_filial=' ' AND b3.ba3_FILIAL = ' ' AND bts_filial=' ' and A1_FILIAL = ' '  "
cQuery +=" and b1.d_e_l_e_t_=' ' AND b2.d_e_l_e_t_=' ' AND b3.d_e_l_e_t_=' ' AND sa1.d_e_l_e_t_=' '"   
          
cQuery +=" and b1.ba1_codint|| b1.ba1_codemp|| b1.ba1_matric >= '00010001021768' "

cQuery +=" and b1.ba1_codint|| b1.ba1_codemp|| b1.ba1_matric <= '00010001021768' "  

cQuery +=" AND ba1_matvid=bts_matvid and (b1.ba1_datblo=' ' or b1.ba1_datblo> to_char (sysdate,'yyyymmdd')) "
cQuery +=" AND b1.ba1_codint = b3.ba3_codint AND b1.ba1_codemp = b3.ba3_codemp AND b1.ba1_matric = b3.ba3_matric and ba3_codcli = a1_cod "
cQuery +=" and b1.ba1_cpfusr IN (select ba1_cpfusr from  ba1010 b1 where b1.ba1_filial=' ' and b1.d_e_l_e_t_=' ' "
cQuery +=" and (b1.ba1_datblo=' ' or b1.ba1_datblo> to_char (sysdate,'yyyymmdd')) and b1.ba1_cpfusr<>' ' "
cQuery +=" and b1.ba1_codemp not in('0004','0006','0010','0009') GROUP by ba1_cpfusr HAVING Count(*)>1 ) "
cQuery +=" and b1.ba1_cpfusr<>' ' and b1.ba1_codemp not in('0004','0006','0010','0009') "
//ORDER BY BA1_CPFUSR
cQuery +=" ORDER BY  b1.ba1_codint, b1.ba1_codemp , b1.ba1_matric , b1.ba1_tipreg"                                                                                                                                        


If Select("TMP") > 0
	dbSelectArea("TMP")
	dbclosearea()
Endif

TCQuery cQuery Alias "TMP" New
dbSelectArea("TMP")
tmp->(dbGoTop())                                                                                                                         
//cMatric := substr (tmp->Matricula1,1,14)
//cNomCli := substr (tmp->ba1_nomusr,1,30)
While tmp->(!EOF())     
ccpf:= substr (tmp->ba1_cpfusr,1,3)+"."+substr (tmp->ba1_cpfusr,4,3)+"."+substr (tmp->ba1_cpfusr,7,3)+"-"+substr (tmp->ba1_cpfusr,10,2)   
cdtnasc:= substr (tmp->BA1_DATNAS,7,2)+"/"+substr (tmp->BA1_DATNAS,5,2)+"/"+substr (tmp->BA1_DATNAS,1,4)
   If ((tmp->ba1_tipusu == "T") .and. (cMatric != substr (tmp->Matricula1,1,14)))
      cMatric := substr (tmp->Matricula1,1,14)      
      cNomCli := substr (tmp->ba1_nomusr,1,30)
 //    OLE_UpDateFields(oWord)                                                        
 //     OLE_SaveAsFile( oWord, cGrava + cNomCli + cmatric+".doc" ) 
 //   Ole_PrintFile(oWord,"ALL",,,1) //ativar quando fro pra valer
 //-- Imprime as variaveis		
 //    Limpa variavel 	
	  
      OLE_SetDocumentVar(oWord,"w_nome1_assis"  ," ")  
      OLE_SetDocumentVar(oWord,"w_cpf1_assis"   ," ")
      OLE_SetDocumentVar(oWord,"w_dtn1_assis"   ," ") 

      OLE_SetDocumentVar(oWord,"w_nome2_assis"  ," ") 
      OLE_SetDocumentVar(oWord,"w_cpf2_assis"   ," ") 
      OLE_SetDocumentVar(oWord,"w_dtn2_assis"   ," ")
      
      OLE_SetDocumentVar(oWord,"w_nome3_assis"  ," ") 
      OLE_SetDocumentVar(oWord,"w_cpf3_assis"   ," ")
      OLE_SetDocumentVar(oWord,"w_dtn3_assis"   ," ") 
      
      OLE_SetDocumentVar(oWord,"w_nome4_assis"  ," ")
      OLE_SetDocumentVar(oWord,"w_cpf4_assis"   ," ")     
      OLE_SetDocumentVar(oWord,"w_dtn4_assis"   ," ")
      
      OLE_SetDocumentVar(oWord,"w_nome5_assis"  ," ")
      OLE_SetDocumentVar(oWord,"w_cpf5_assis"   ," ")     
      OLE_SetDocumentVar(oWord,"w_dtn5_assis"   ," ")
      
      OLE_SetDocumentVar(oWord,"w_nome6_assis"  ," ")
      OLE_SetDocumentVar(oWord,"w_cpf6_assis"   ," ") 
      OLE_SetDocumentVar(oWord,"w_dtn6_assis"   ," ")
 //////// A1_BAIRRO , A1_MUN ,a1_est ,A1_ESTADO  , A1_CEP
      OLE_SetDocumentVar(oWord,"w_nome_assis"   ,tmp->ba1_nomusr)                                                              
      OLE_SetDocumentVar(oWord,"w_end_assis"    ,trim (tmp->A1_END))
//	  OLE_SetDocumentVar(oWord,"w_end_assis"    ,trim (tmp->BA3_END)+" " + trim (TMP->BA3_NUMERO)+ " " +trim (TMP->BA3_COMPLE))
	  OLE_SetDocumentVar(oWord,"w_bairro_assis" ,trim (tmp->A1_BAIRRO) +"-"+trim (TMP->A1_MUN)+"-"+trim(TMP->A1_EST)+"-"+trim(TMP->A1_ESTADO)) 
//	  OLE_SetDocumentVar(oWord,"w_bairro_assis" ,trim (tmp->BA3_BAIRRO) +"-"+trim (TMP->BA3_MUN)+"-"+trim(TMP->BA3_ESTADO))
	  OLE_SetDocumentVar(oWord,"w_cep_assis"    ,tmp->A1_CEP)   
// 	  OLE_SetDocumentVar(oWord,"w_cep_assis"    ,tmp->BA3_CEP)  
	  OLE_SetDocumentVar(oWord,"w_cpf_assis"    ,"CPF.: " + ccpf) 
	  OLE_SetDocumentVar(oWord,"w_dtn_assis"    ,"Dta Nasc.: " + cdtnasc) 
	  OLE_SetDocumentVar(oWord,"w_mat_assis"    ,"Mat. " + tmp->Matricula1)
	  
      nConta:=1
   ElseIf cMatric = substr (tmp->Matricula1,1,14)                              
      if nConta = 1
         OLE_SetDocumentVar(oWord,"w_nome1_assis"   ,tmp->ba1_nomusr)   
         OLE_SetDocumentVar(oWord,"w_cpf1_assis"    ,"CPF.: " + ccpf )   
    	 OLE_SetDocumentVar(oWord,"w_dtn1_assis"     ,"Dta Nasc.: " + cdtnasc)
         nConta++
      elseif nConta = 2          
         OLE_SetDocumentVar(oWord,"w_nome2_assis"   ,tmp->ba1_nomusr) 
         OLE_SetDocumentVar(oWord,"w_cpf2_assis"    ,"CPF.: " + ccpf)
       	 OLE_SetDocumentVar(oWord,"w_dtn2assis"    ,"Dta Nasc.: " + cdtnasc)
         nConta++
      elseif nConta = 3   
         OLE_SetDocumentVar(oWord,"w_nome3_assis"   ,tmp->ba1_nomusr)
         OLE_SetDocumentVar(oWord,"w_cpf3_assis"    ,"CPF.: " + ccpf)  
   	     OLE_SetDocumentVar(oWord,"w_dtn3_assis"    ,"Dta Nasc.: " + cdtnasc)
         nConta++
      elseif nConta = 3            
         OLE_SetDocumentVar(oWord,"w_nome4_assis"   ,tmp->ba1_nomusr) 
         OLE_SetDocumentVar(oWord,"w_cpf4_assis"    ,"CPF.: " + ccpf) 
         OLE_SetDocumentVar(oWord,"w_dtn4_assis"    ,"Dta Nasc.: " + cdtnasc)
         nConta++
      elseif nConta = 4       
         OLE_SetDocumentVar(oWord,"w_nome5_assis"   ,tmp->ba1_nomusr)   
         OLE_SetDocumentVar(oWord,"w_cpf5_assis"    ,"CPF.: " + ccpf)  
         OLE_SetDocumentVar(oWord,"w_dtn5_assis"    ,"Dta Nasc.: " + cdtnasc)
         nConta++         
      elseif nConta = 5       
         OLE_SetDocumentVar(oWord,"w_nome6_assis"   ,tmp->ba1_nomusr)   
         OLE_SetDocumentVar(oWord,"w_cpf6_assis"    ,"CPF.: " + ccpf)    
         OLE_SetDocumentVar(oWord,"w_dtn6_assis"    ,"Dta Nasc.: " + cdtnasc)
      EndIf
   EndIf                           
   tmp->(dbSkip())   
   If cMatric != substr (tmp->Matricula1,1,14)                            
                                                                                                                   
      OLE_UpDateFields(oWord)
      Ole_PrintFile(oWord,"ALL",,,1)  //ativa quando for pra valer
                         
      WaitPrt(10)
 //-- Imprime as variaveis		
      OLE_SaveAsFile( oWord, cGrava  + cMatric + cNomCli +".doc" )		
     			// Fecha o Documento
   EndIf  
EndDo                     
  OLE_CloseFile( oWord )
  OLE_CloseLink( oWord )
Return
//Waint para carragar Spool do Word
Static Function WaitPRT(nTime)
Local oDlgPrt,oTimer
	DEFINE MSDIALOG oDlgPrt FROM 0,0 TO 50,500 TITLE "Imprimindo!" PIXEL
		oTimer := TTimer():New( nTime * 50, {|| oDlgPrt:END() }, oDlgPrt )
		@1,1  SAY "Aguarde..."+ cMatric + ".doc"
		oTimer:lActive   := .T.
	ACTIVATE MSDIALOG oDlgPrt CENTERED
Return                             
