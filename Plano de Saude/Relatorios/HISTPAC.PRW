#include "rwmake.ch" 

/*-----------------------------------------------------------------------
| Funcao   | HISTPAC  | Autor | Otavio Pinto         | Data | 18/04/2013 |
|------------------------------------------------------------------------|
| Descricao| Acompanhamento Medico do Historico do Paciente              |
|------------------------------------------------------------------------|
|          |                                                             |
|          |                                                             |
 -----------------------------------------------------------------------*/
user Function HISTPAC()

Local   aRegs     := {}

private cNomRot   := "HISTPAC" 
private cLIN      := ""
private cCRLF     := CHR(13)+CHR(10)
private nConta    := 0
private cPerg     := "HISTPAC"
private nLastKey  := 0   
private cCnt01    := "C:\TEMP\HISTPAC.csv"
private nCol1     := 136 // Dados do Paciente
private nCol2     := 40  // Coluna 1
private nCol3     := 54  // Coluna 2

private nPos1     := 10 // Data
private nPos2     := 05 // Hora Ini
private nPos3     := 05 // Hora Fim
private nPos4     := 21 // Diagnostico
private nPos5     := 50 // Memo
private nPos6     := 52 // Cod.Medico 
private cStrSQL   := "" 
private cQrySQL   := ""
private cMv_par01 := ""
private cMv_par02 := ""

begin sequence
   /*-----------------------------------------------------------------------
   | NOTA     | Para o PROFISSIONAL DA SAUDE estar habilitado a esta rotina |
   |          | o mesmo devera estar cadastrado do RDA-Cadastro e na aba    | 
   |          | "Atendimento", na opcao "Usr.Config", campo BAU_CODCFG      | 
   |          | devera estar o ID (Microsiga) do profissional.              |
    -----------------------------------------------------------------------*/
   cQry := "SELECT BAU_CODCFG FROM "+RetSQLName("BAU")+" WHERE D_E_L_E_T_ = ' ' AND BAU_CODCFG = '"+__cUserID+"' AND BAU_DATBLO = ' '"   
   PlsQuery(cQry ,"TRB")            
   if __cUserID <> TRB->BAU_CODCFG 
      MsgAlert("Acesso a esta rotina, somente aos PROFISSIONAIS DA SAUDE."+CHR(13)+CHR(13)+"Verifique com sua gerencia !", "AVISO" )
      break
   endif

   ValidPerg()
   if Pergunte(cPerg,.T.)
   
      cMv_par01   := Substr(DtoS(mv_par01),7,2)+"/"+Substr(DtoS(mv_par01),5,2)+"/"+Substr(DtoS(mv_par01),1,4)
      cMv_par02   := Substr(DtoS(mv_par02),7,2)+"/"+Substr(DtoS(mv_par02),5,2)+"/"+Substr(DtoS(mv_par02),1,4)

      Processa({ ||IMP_REL2()},"Gerando Arquivo ...")
   endIf    

end sequence                                                 

Return Nil

/*-----------------------------------------------------------------------
| Funcao   | IMP_REL2  | Autor | Otavio Pinto        | Data | 18/04/2013 |
|------------------------------------------------------------------------|
| Descricao| Rotina de impressao                                         |
 -----------------------------------------------------------------------*/
static function IMP_REL2()

Local LinCorrX 	:= 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
Local xx 		:= 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

Local _lCabec1      := .T.	 
Local _lCabec2      := .T.	 
Local cCabCSV       := ""

private _cDirDocs   := MsDocPath()
private _cPath		:= "C:\TEMP\"
private _cArquivo  	:= cNomRot+".csv"    // Alterada a extensão de TXT para CSV 
private cBuffer		:= ""
private oAbrArq 
private nHandle    

private nTotCCusto  := 0

private aCpoMemo    := {}
private _cDATA      
private _cDTRET     

private cBTH_YINDC  
private cBTH_CID    
private cBTH_DESCID 
private cBTH_ESP_A    
private cBTH_DES_A 
private cBTH_ESP_B    
private cBTH_DES_B 

/*-----------------------------------------------------------------------
| Apaga arquivo se existir                                               |
 -----------------------------------------------------------------------*/
FErase( _cPath+_cArquivo )
	                      
/*-----------------------------------------------------------------------
| Cria novo arquivo                                                      |
 -----------------------------------------------------------------------*/
nHandle := FCreate(_cDirDocs + "\" + _cArquivo)
	
if nHandle == -1
	MsgStop("Erro na criacao do arquivo na estacao local. Contate o administrador do sistema")
	return
EndIf

/*-----------------------------------------------------------------------
| Montagem da query                                                      |
 -----------------------------------------------------------------------*/

cStrSQL := "  SELECT BTH_FILIAL " + cCRLF    
cStrSQL += "       , BTH_CODATE " + cCRLF   
cStrSQL += "       , BTH_DATA " + cCRLF  
cStrSQL += "       , BTH_HORINI " + cCRLF  
cStrSQL += "       , BTH_HORFIN " + cCRLF  
cStrSQL += "       , BTH_TEMPO " + cCRLF  
cStrSQL += "       , BTH_CODPAC " + cCRLF  
cStrSQL += "       , BTH_NOMPAC " + cCRLF  
cStrSQL += "       , BTH_IDADE " + cCRLF  
cStrSQL += "       , BTH_DATRET " + cCRLF  
cStrSQL += "       , BTH_PESO " + cCRLF  
cStrSQL += "       , BTH_ALTURA " + cCRLF  
cStrSQL += "       , BTH_QUEPRI " + cCRLF     
cStrSQL += "       , OBTER_TEXTO_ATENDIMENTO(BTH.R_E_C_N_O_) BTH_QUEPRI " + cCRLF      
cStrSQL += "       , OBTER_TEXTO_BS7('BTH',BTH_CODATE,'BTH_QUEDOE') BTH_QUEDOE " + cCRLF      
cStrSQL += "       , OBTER_TEXTO_BS7('BTH',BTH_CODATE,'BTH_QUECLI') BTH_QUECLI " + cCRLF      
cStrSQL += "       , OBTER_TEXTO_BS7('BTH',BTH_CODATE,'BTH_QUIFAM') BTH_QUIFAM " + cCRLF      
cStrSQL += "       , OBTER_TEXTO_BS7('BTH',BTH_CODATE,'BTH_DESREC') BTH_DESREC " + cCRLF      
cStrSQL += "       , OBTER_TEXTO_BS7('BTH',BTH_CODATE,'BTH_QUEEXA') BTH_QUEEXA " + cCRLF      
cStrSQL += "       , OBTER_TEXTO_BS7('BTH',BTH_CODATE,'BTH_QUECON') BTH_QUECON " + cCRLF      
cStrSQL += "       , BTH_SOLICI " + cCRLF  
cStrSQL += "       , BTH_RECEIT " + cCRLF  
cStrSQL += "       , BTH_CODCRE " + cCRLF  
cStrSQL += "       , BTH_NOMCRE " + cCRLF  
cStrSQL += "       , BTH_CODINT " + cCRLF  
cStrSQL += "       , BTH_CODLOC " + cCRLF  
cStrSQL += "       , BTH_DESLOC " + cCRLF  
cStrSQL += "       , BTH_PREART " + cCRLF  
cStrSQL += "       , BTH_FRECAR " + cCRLF  
cStrSQL += "       , BTH_TEMPER " + cCRLF  
cStrSQL += "       , BTH_CID " + cCRLF         //--> CID
cStrSQL += "       , ( SELECT BA9_DOENCA FROM "+RetSQLName("BA9")+ " BA9  WHERE D_E_L_E_T_ = ' ' AND BA9_FILIAL = ' ' AND BA9_CODDOE = BTH_CID) BTH_DESCID " + cCRLF 
cStrSQL += "       , BTH_MATANT " + cCRLF  
cStrSQL += "       , BTH_MATVID " + cCRLF  
cStrSQL += "       , BTH_YCINT " + cCRLF  
cStrSQL += "       , BTH_YQUADR " + cCRLF  
cStrSQL += "       , (CASE WHEN BTH_YQUADR > 0 THEN Round((BTH_YCINT/(BTH_YQUADR*BTH_YQUADR)),3) ELSE NULL END) BTH_RCQ " + cCRLF   
cStrSQL += "       , (CASE WHEN BTH_ALTURA > 0 THEN Round((BTH_PESO/(BTH_ALTURA*BTH_ALTURA)),3) ELSE NULL END) BTH_YIMC " + cCRLF   
cStrSQL += "       , BTH_YINDC " + cCRLF       //--> Ind.Clinica
cStrSQL += "       , BTH_YEESP1 " + cCRLF      //--> Especialidades indicadas
cStrSQL += "       , ( SELECT BAQ_DESCRI FROM "+RetSQLName("BAQ")+ " BAQ WHERE D_E_L_E_T_ = ' ' AND BAQ_FILIAL = ' ' AND BAQ_CODINT = '0001' AND BAQ_CODESP = BTH_YEESP1) BTH_YDEES1 " + cCRLF 
cStrSQL += "       , BTH_YEESP2 " + cCRLF      //--> Especialidades indicadas
cStrSQL += "       , ( SELECT BAQ_DESCRI FROM "+RetSQLName("BAQ")+ " BAQ WHERE D_E_L_E_T_ = ' ' AND BAQ_FILIAL = ' ' AND BAQ_CODINT = '0001' AND BAQ_CODESP = BTH_YEESP2) BTH_YDEES2 " + cCRLF 
cStrSQL += "       , BTH_PREART " + cCRLF  
cStrSQL += "       , BTH_FRECAR " + cCRLF  
cStrSQL += "       , BTH_TEMPER " + cCRLF  
cStrSQL += "       , BAU_CPFCGC " + cCRLF  
cStrSQL += "       , BAU_NOME " + cCRLF   
cStrSQL += "       , BAU_CODIGO " + cCRLF  
cStrSQL += "       , BAU_SIGLCR " + cCRLF  
cStrSQL += "       , BAU_ESTCR " + cCRLF  
cStrSQL += "       , BAU_TIPPRE " + cCRLF    
cStrSQL += "       , BA1_CODPLA " + cCRLF    
cStrSQL += "       , ( SELECT DISTINCT BBI_DESPRO  FROM "+RetSQLName("BBI")+ " BBI  WHERE BBI.D_E_L_E_T_ = ' ' AND BBI_CODPRO = BA1.BA1_CODPLA) BA1_DESPLA " + cCRLF   
cStrSQL += "       , ( SELECT BAQ_DESCRI " + cCRLF
cStrSQL += "           FROM "+RetSQLName("BAQ")+ " BAQX " + cCRLF
cStrSQL += "           WHERE BAQX.R_E_C_N_O_ = ( SELECT Max(BAQZ.R_E_C_N_O_) " + cCRLF
cStrSQL += "                                     FROM BBF010 BBFZ " + cCRLF
cStrSQL += "                                        , BAQ010 BAQZ " + cCRLF
cStrSQL += "                                     WHERE BBF_CODIGO     = BTH_CODCRE " + cCRLF
cStrSQL += "                                       AND BBF_CODINT     = BAQ_CODINT " + cCRLF
cStrSQL += "                                       AND BBF_CDESP      = BAQ_CODESP " + cCRLF
cStrSQL += "                                       AND BBF_DATBLO     = ' ' " + cCRLF
cStrSQL += "                                       AND BBF_FILIAL     = ' '  AND BAQ_FILIAL     = ' ' " + cCRLF
cStrSQL += "                                       AND BBFZ.D_E_L_E_T_ = ' ' AND BAQZ.D_E_L_E_T_ = ' ' ) ) BAQ_DESCRI  " + cCRLF
cStrSQL += "  FROM "+RetSQLName("BTH")+ " BTH " + cCRLF  
cStrSQL += "     , "+RetSQLName("BAU")+ " BAU " + cCRLF   
cStrSQL += "     , "+RetSQLName("BA1")+ " BA1 " + cCRLF  
cStrSQL += "    WHERE BTH_DATA BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " + cCRLF  
cStrSQL += "    AND BTH_CODPAC  = '"+mv_par03+"' " + cCRLF  
cStrSQL += "    AND BTH_CODCRE  = BAU_CODIGO " + cCRLF  
cStrSQL += "    AND BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG||BA1_DIGITO = BTH_CODPAC " + cCRLF  
cStrSQL += "    AND BTH_FILIAL  = ' ' " + cCRLF   
cStrSQL += "    AND BAU_FILIAL  = ' ' " + cCRLF   
cStrSQL += "    AND BA1_FILIAL  = ' ' " + cCRLF     
cStrSQL += "    AND BTH.D_E_L_E_T_ = ' ' " + cCRLF  
cStrSQL += "    AND BAU.D_E_L_E_T_ = ' ' " + cCRLF   
cStrSQL += "    AND BA1.D_E_L_E_T_ = ' ' " + cCRLF  
cStrSQL += "  ORDER BY BTH_DATA DESC, BTH_NOMCRE " + cCRLF  

/*-----------------------------------------------------------------------
| Escreve a query na pasta TEMP                                          |
 -----------------------------------------------------------------------*/

 MemoWrite(Alltrim(_cPath)+cNomRot+".SQL", cStrSQL)
                               
/*-----------------------------------------------------------------------
| Otimiza a query                                                        |
 -----------------------------------------------------------------------*/
cStrSQL := ChangeQuery( cStrSQL )                            

If Select("TRB") > 0 ; dbSelectArea("TRB") ; TRB->( dbCloseArea() ) ; Endif

dbUseArea(.T., "TOPCONN", TcGenQry(,, cStrSQL), "TRB", .T., .F.)                        

lUltLinha := .F.

while TRB->( !Eof() )

    _cDATA      := TRB->( Substr(BTH_DATA,7,2)+"/"+Substr(BTH_DATA,5,2)+"/"+Substr(BTH_DATA,1,4) )
    _cDTRET     := TRB->( Substr(BTH_DATRET,7,2)+"/"+Substr(BTH_DATRET,5,2)+"/"+Substr(BTH_DATRET,1,4) )

    cBTH_YINDC  := TRB->BTH_YINDC
    cBTH_CID    := TRB->BTH_CID
    cBTH_DESCID := TRB->BTH_DESCID 

    cBTH_ESP_A  := TRB->BTH_YEESP1 
    cBTH_DES_A  := TRB->BTH_YDEES1                  

    cBTH_ESP_B  := TRB->BTH_YEESP2    
    cBTH_DES_B  := TRB->BTH_YDEES2    

    if _lCabec1 

	   FWrite(nHandle, PADR("",nCol1,"=")    ) ; FWrite(nHandle, cCRLF)  	   	
	   FWrite(nHandle, PADR("",nCol2," ")    +" "+PADC("DADOS DO PACIENTE",nCol3 )+" "+PADR("",nCol2," ")           ) ; FWrite(nHandle, cCRLF)       
	   FWrite(nHandle, PADR("",nCol2," ")    +" "+PADC("Periodo de: "+cMv_par01+" Ate "+cMv_par02,nCol3 )+" "+PADR("",nCol2," ")           ) ; FWrite(nHandle, cCRLF)       
	   FWrite(nHandle, PADR("",nCol1,"=")    ) ; FWrite(nHandle, cCRLF)  	   	   
       cBuffer :=  TRB->( PADR("Matricula: "+TRANSFORM(BTH_CODPAC,"@R 9999.9999.999999.99-9"),nCol2," ")+"     "+PADR("Nome: "+UPPER(BTH_NOMPAC),nCol2," ") ) ; FWrite(nHandle, cBuffer) ; FWrite(nHandle, cCRLF)
	   FWrite(nHandle, PADR(" ",nCol1," ")    ) ; FWrite(nHandle, cCRLF)  	   	              
       cBuffer :=  TRB->( PADR("Plano contratado: "+TRANSFORM(BA1_CODPLA,"@ 9999")+"   "+PADR(TRANSFORM(BA1_DESPLA,"@!","."),30)+Space(41)+"Data Retorno: "+ _cDTRET ,nCol1," ") ) ; FWrite(nHandle, cBuffer) ; FWrite(nHandle, cCRLF)       
            
	   FWrite(nHandle, PADR("",nCol1,"=")    ) ; FWrite(nHandle, cCRLF)  	   	       
       cBuffer :=  TRB->( PADR("Idade..................: "+TRANSFORM(BTH_IDADE ,"@ 999") ,nCol2," ")   +Space(5)+PADR("Altura..................: "+TRANSFORM(BTH_ALTURA,"@RE 9.99"),nCol3-4," ")  +" "+PADR("Peso...................: "+TRANSFORM(BTH_PESO,"@RE 999.9"),nCol2," ") ) ; FWrite(nHandle, cBuffer) ; FWrite(nHandle, cCRLF)
       cBuffer :=  TRB->( PADR("I M C..................: "+TRANSFORM(BTH_YIMC ,"@ 999.99") ,nCol2," ")+Space(5)+PADR("Cintura.................: "+TRANSFORM(BTH_YCINT,"@RE 999.99"),nCol3-4," ")+" "+PADR("Quadril................: "+TRANSFORM(BTH_YQUADR,"@RE 999.99"),nCol2," ") ) ; FWrite(nHandle, cBuffer) ; FWrite(nHandle, cCRLF)
       cBuffer :=  TRB->( PADR("Relacao Cintura Quadril: "+TRANSFORM(BTH_RCQ ,"@RE 999.99") ,nCol2," ") ) ; FWrite(nHandle, cBuffer) ; FWrite(nHandle, cCRLF)
       cBuffer :=  TRB->( PADR("Pressao Arterial.......: "+TRANSFORM(BTH_PREART ,"@R 99/99") ,nCol2," ")     +Space(5)+PADR("Freq.Cardiaca...........: "+ALLTRIM(BTH_FRECAR),nCol3-4," ")               +" "+PADR("Temperatura............: "+TRANSFORM(BTH_TEMPER,"@RE 999.99"),nCol2," ") ) ; FWrite(nHandle, cBuffer) ; FWrite(nHandle, cCRLF)       
	   _lCabec1 := .F.	   
    Endif

    if _lCabec2 
	   FWrite(nHandle, PADR("",nPos1,"=")    +";"+PADR("",nPos4,"=")           +";"+PADR("",nPos5,"=")                  +";"+PADR("",nPos6,"=")        ) ; FWrite(nHandle, cCRLF)  	   	
	   FWrite(nHandle, PADR("",nPos1," ")    +";"+PADR("",nPos4," ")           +";"+PADC("HISTORICO DO PACIENTE",nPos5 )+";"+PADR("",nPos6," ")        ) ; FWrite(nHandle, cCRLF)       
	   FWrite(nHandle, PADR("DATA",nPos1," ")+";"+PADR("DIAGNOSTICO",nPos4," ")+";"+PADC("DESCRITIVO",nPos5," ")        +";"+PADR("MEDICO",nPos6," ") ) ; FWrite(nHandle, cCRLF)  	
	   FWrite(nHandle, PADR("",nPos1,"=")    +";"+PADR("",nPos4,"=")           +";"+PADR("",nPos5,"=")                  +";"+PADR("",nPos6,"=")       ) ; FWrite(nHandle, cCRLF)  	   	
	   _lCabec2 := .F.
    Endif       
    
    // Imprime campos MEMO...
	For xx:= 1 to 7        
	    DO CASE    
           CASE XX == 1 ; cMemoX := Alltrim(TRB->BTH_QUEPRI) ; cRet := 'Queixa Principal'        
           CASE XX == 2 ; cMemoX := Alltrim(TRB->BTH_QUEDOE) ; cRet := 'HDA-Hist.Doenca Atual'
           CASE XX == 3 ; cMemoX := Alltrim(TRB->BTH_QUECLI) ; cRet := 'HCC-Hist.Clinico Cir.'
           CASE XX == 4 ; cMemoX := Alltrim(TRB->BTH_QUIFAM) ; cRet := 'HF-Historico Familiar' 
           CASE XX == 5 ; cMemoX := Alltrim(TRB->BTH_DESREC) ; cRet := 'Receita'
           CASE XX == 6 ; cMemoX := Alltrim(TRB->BTH_QUEEXA) ; cRet := 'Exame Fisico'
           CASE XX == 7 ; cMemoX := Alltrim(TRB->BTH_QUECON) ; cRet := 'Conduta Medica'
        ENDCASE 
		if !Empty(cMemoX)
			nLinMemoX := MLCOUNT(cMemoX,nPos5)
			If nLinMemoX > 0
			   For LinCorrX := 1 To nLinMemoX    
			       cCpoMemoX := MemoLine(cMemoX,nPos5,LinCorrX)
			       If LinCorrX == 1
			          cBuffer :=  TRB->( PADR(_cDATA,nPos1," ")+";"+PADR(cRet,nPos4," ")+";"+PADR(cCpoMemoX,nPos5," ")+";"+PADR(Alltrim(BTH_NOMCRE)+" - "+Alltrim(BAQ_DESCRI),nPos6 ) )
			          FWrite(nHandle, cBuffer) ; FWrite(nHandle, cCRLF)
			       else
			          cBuffer :=  TRB->( PADR(" ",nPos1," ")+";"+PADR(" ",nPos4," ")+";"+PADR(cCpoMemoX,nPos5," ")+";"+PADR(" ",nPos6 ) )
			          FWrite(nHandle, cBuffer) ; FWrite(nHandle, cCRLF) 
			       Endif           
			   Next LinCorrX     
			Endif		
    	endif
	Next	

    nConta ++

    cBTH_CODATE := TRB->BTH_CODATE
 	
 	TRB->( DbSkip() )               
 
    if TRB->( EOF() )               
        FWrite(nHandle, PADR("",nCol1,"=")    ) ; FWrite(nHandle, cCRLF)  	   	   
	    // Inclicacao Clinica
	    If !empty(cBTH_YINDC)
	       FWrite(nHandle, PADR(" ",nCol1," ")    ) ; FWrite(nHandle, cCRLF)  	   	              
	       cBuffer :=  PADR("Ind.Clinica.............: "+TRANSFORM(Alltrim(cBTH_YINDC),"@!"),nCol1," ") ; FWrite(nHandle, cBuffer) ; FWrite(nHandle, cCRLF)       
	       lUltLinha := .T.
	    endif
	    // CID
	    If !empty(cBTH_CID)
	       FWrite(nHandle, PADR(" ",nCol1," ")    ) ; FWrite(nHandle, cCRLF)  	   	              
	       cBuffer :=  PADR("C I D...................: "+TRANSFORM(Alltrim(cBTH_CID) + " - " + Alltrim(cBTH_DESCID),"@!"),nCol1," ") ; FWrite(nHandle, cBuffer) ; FWrite(nHandle, cCRLF)       
	       lUltLinha := .T.	       
	    endif
	    // Especialidades indicadas
	    If !empty(cBTH_ESP_A) .or. !empty(cBTH_ESP_B)
	       FWrite(nHandle, PADR(" ",nCol1," ")    ) ; FWrite(nHandle, cCRLF)  	   	              
	       cBuffer :=  "Especialidades Indicadas: "
	       lUltLinha := .T.	       
	       If !empty(cBTH_ESP_A)
	          cBuffer +=  PADR( TRANSFORM(cBTH_ESP_A + " - " + Alltrim(cBTH_DES_A),"@!"),nCol1," ") 
              FWrite(nHandle, cBuffer) ; FWrite(nHandle, cCRLF)          
              cBuffer := "" 
           endif   
	       If !empty(cBTH_ESP_B)
	          cBuffer +=  if (empty(cBTH_ESP_A),"", space(26)) + PADR( TRANSFORM(cBTH_ESP_B + " - " + Alltrim(cBTH_DES_B),"@!"),nCol1," ") 
              FWrite(nHandle, cBuffer) ; FWrite(nHandle, cCRLF)          
	       endif            	     
	    endif                        
    endif   

ENDDO          
if lUltLinha 
   FWrite(nHandle, PADR("",nCol1,"=")    ) ; FWrite(nHandle, cCRLF)  	   	
endif   
cBuffer := "Fim "
FWrite(nHandle, cBuffer)
FClose(nHandle)

CpyS2T(_cDirDocs + "\" + _cArquivo, _cPath, .T.)

/*-----------------------------------------------------------------------
| Abre o arquivo no bloco de notas.                                      |
 -----------------------------------------------------------------------*/ 
oAbrArq := WinExec("NOTEPAD.EXE "+_cPath+_cArquivo)  // Abre o arquivo Log na Tela do usuario

MsgAlert(if(nConta>1,"Foram","Foi")+" listado"+if(nConta>1,"s"," ")+ alltrim(str(nConta)) + " periodo"+if(nConta>1,"s","")+" !!!")

If Select("TRB") > 0 ; dbSelectArea("TRB") ; TRB->( dbCloseArea() ) ; Endif 

return


/*-----------------------------------------------------------------------
| Funcao   | ValidPerg | Autor | Otavio Pinto        | Data | 18/04/2013 |
|------------------------------------------------------------------------|
| Descricao| Verifica a existencia das perguntas criando-as caso seja    | 
|          | necessario (caso nao existam).                              |
 -----------------------------------------------------------------------*/
Static Function ValidPerg

Local i := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
Local j := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

_sAlias := Alias()
aRegs   := {}

dbSelectArea("SX1")
dbSetOrder(1)
cPerg := PadR(cPerg,Len(SX1->X1_GRUPO))

// Grupo/Ordem/Pergunta/PerEsp/PerIng/Variavel/Tipo/Tamanho/Decimal/Presel/GSC/Valid/Var01/Def01///Cnt01/Var02/Def02/Cnt02/Var03/Def03/Cnt03/Var04/Def04/Cnt04/Var05/Def05/Cnt05

AAdd(aRegs,{cPerg , "01" , "Da Data consulta         ?" ,"","", "mv_ch1" , "D" , 8 , 0 ,0 , "G" , "" , "mv_par01" , ""     , "" , "" , ""  , "" , ""     , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , ""    , "" })
AAdd(aRegs,{cPerg , "02" , "Ate Data consulta        ?" ,"","", "mv_ch2" , "D" , 8 , 0 ,0 , "G" , "" , "mv_par02" , ""     , "" , "" , ""  , "" , ""     , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , ""    , "" })
Aadd(aRegs,{cPerg , "03" , "Matricula do paciente    ?" ,"","", "mv_ch3" , "C" , 17 ,0 ,0 , "G" , "" , "mv_par03" , ""     , "" , "" , ""  , "" , ""     , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "B92PLS", "" })

For i:=1 to Len(aRegs)
    If !dbSeek(cPerg+aRegs[i,2])
        RecLock("SX1",.T.)
        For j:=1 to FCount()
            If j <= Len(aRegs[i])
                FieldPut(j,aRegs[i,j])
            Endif
        Next
        MsUnlock()
    Endif
Next
dbSelectArea(_sAlias)
Return




// Fim do HISTPAC.PRW

