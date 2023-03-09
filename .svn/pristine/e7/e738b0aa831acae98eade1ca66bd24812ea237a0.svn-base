#include "rwmake.ch" 

/*-----------------------------------------------------------------------
| Funcao   | MAPVTCC  | Autor | Otavio Pinto         | Data | 18/04/2013 |
|------------------------------------------------------------------------|
| Descricao| MAPA DE VALE TRANSPORTE POR CENTRO DE CUSTO                 |
|------------------------------------------------------------------------|
|          |     | Gerar este relatorio logo apos calculo da folha e     |
|          |     | passar para o financeiro.                             |
 -----------------------------------------------------------------------*/
user Function MAPVTCC()

Local   aRegs     := {}

private cNomRot   := "MAPVTCC" 
private cLIN      := ""
private cCRLF     := CHR(13)+CHR(10)
private nConta    := 0
*private cPerg     := "MAPVTCC"
private nLastKey  := 0   
private cCnt01    := "C:\TEMP\MAPVTCC.csv"
private nPos1     :=  9
private nPos2     := 40
private nPos3     := 15

if MSGBOX("Deseja executar a rotina MAPA DE VALE TRANSPORTE POR CENTRO DE CUSTO..: "+ cCRLF + cCRLF + " Confirma???","MAPA DE VALE TRANSPORTE","YESNO")
   *ValidPerg()
   *if Pergunte(cPerg,.T.)
       Processa({ ||IMP_REL2()},"Gerando Arquivo ...")
   *endIf    
endif

Return Nil

/*-----------------------------------------------------------------------
| Funcao   | IMP_REL2  | Autor | Otavio Pinto        | Data | 18/04/2013 |
|------------------------------------------------------------------------|
| Descricao| Rotina de impressao                                         |
 -----------------------------------------------------------------------*/
static function IMP_REL2()
Local _lCabec       := .T.	
Local cCabCSV       := ""

private _cDirDocs   := MsDocPath()
private _cPath		:= "C:\TEMP\"
private _cArquivo  	:= cNomRot+".csv"    // Alterada a extensão de TXT para CSV 
private cBuffer		:= ""
private oAbrArq 
private nHandle    

private nTotCCusto  := 0

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
cStrSQL := "SELECT R0_CC          CCUSTO " + cCRLF  
cStrSQL += "     , CTT_DESC01     DESCRICAO " + cCRLF  
cStrSQL += "     , Sum(R0_VALCAL) VALOR " + cCRLF  
cStrSQL += "FROM SR0010 SR0 " + cCRLF  
cStrSQL += "   , SRA010 SRA " + cCRLF  
cStrSQL += "   , CTT010 CTT " + cCRLF  
cStrSQL += "WHERE R0_CC      <> ' ' " + cCRLF  
cStrSQL += "  AND RA_FILIAL   = R0_FILIAL " + cCRLF  
cStrSQL += "  AND RA_MAT      = R0_MAT " + cCRLF  
cStrSQL += "  AND RA_SITFOLH <> 'D' " + cCRLF  
cStrSQL += "  AND CTT_FILIAL  = R0_FILIAL " + cCRLF  
cStrSQL += "  AND CTT_CUSTO   = R0_CC " + cCRLF  
cStrSQL += "  AND SR0.D_E_L_E_T_ = ' ' " + cCRLF  
cStrSQL += "  AND SRA.D_E_L_E_T_ = ' ' " + cCRLF  
cStrSQL += "  AND CTT.D_E_L_E_T_ = ' ' " + cCRLF  
cStrSQL += "GROUP BY R0_CC, CTT_DESC01 " + cCRLF  
cStrSQL += "ORDER BY R0_CC " + cCRLF  

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

//cDTIni := Substr(Dtos(mv_par01),7,2)+"/"+Substr(Dtos(mv_par01),5,2)+"/"+Substr(Dtos(mv_par01),1,4)
//cDTFIM := Substr(Dtos(mv_par02),7,2)+"/"+Substr(Dtos(mv_par02),5,2)+"/"+Substr(Dtos(mv_par02),1,4)

while TRB->( !Eof() )

    if _lCabec 
	   cCabCSV := PADR("",nPos1," ")+";"+PADR("DESCRICAO",nPos2," ")+";"+PADL("",nPos3," ")        

	   FWrite(nHandle, PADR("",nPos1,"=")+";"+PADR("",nPos2,"=")+";"+PADL("",nPos3,"=") ) ; FWrite(nHandle, cCRLF)  	
	   FWrite(nHandle, PADR("",nPos1," ")+";"+PADR("MAPA VALE TRANSPORTE P/C.CUSTO",nPos2 )+";"+PADL("",nPos3," ") )  ; FWrite(nHandle, cCRLF)       
	   FWrite(nHandle, PADR("CCUSTO",nPos1," ")+";"+PADR("",nPos2,"=")+";"+PADL("VALOR",nPos3," ") ) ; FWrite(nHandle, cCRLF)  	
	   FWrite(nHandle, cCabCSV)                                                             ; FWrite(nHandle, cCRLF)       
	   FWrite(nHandle, PADR("",nPos1,"=")+";"+PADR("",nPos2,"=")+";"+PADL("",nPos3,"=") ) ; FWrite(nHandle, cCRLF)  	   	

	   _lCabec := .F.
    Endif

    nTotCCusto  += TRB->VALOR
    
    cBuffer :=  TRB->( PADR(TRB->CCUSTO   ,nPos1," ")+";"+PADR(TRB->DESCRICAO,nPos2," ")+";"+PADL(TRANSFORM(TRB->VALOR,"@RE 999,999,999.99"),nPos3 ) )
    FWrite(nHandle, cBuffer) ; FWrite(nHandle, cCRLF)

    nConta ++
 	TRB->( DbSkip() )               
	
ENDDO          
if !Empty(nTotCCusto) 

    cBuffer :=  TRB->( PADR("",nPos1,"=")+";"+PADR("",nPos2,"=")+";"+PADL("",nPos3,"=") ) ; FWrite(nHandle, cBuffer) ; FWrite(nHandle, cCRLF)
    cBuffer :=  TRB->( PADR("TOTAL",nPos1," ")+";"+PADR("",nPos2," ")+";"+PADL(TRANSFORM(nTotCCusto,"@RE 999,999,999.99"),nPos3) ) ; FWrite(nHandle, cBuffer) ; FWrite(nHandle, cCRLF)
    cBuffer :=  TRB->( PADR("",nPos1,"=")+";"+PADR("",nPos2,"=")+";"+PADL("",nPos3,"=") ) ; FWrite(nHandle, cBuffer) ; FWrite(nHandle, cCRLF)

endif

cBuffer := "Fim "
FWrite(nHandle, cBuffer)
FClose(nHandle)

CpyS2T(_cDirDocs + "\" + _cArquivo, _cPath, .T.)

/*-----------------------------------------------------------------------
| Abre o arquivo no bloco de notas.                                      |
 -----------------------------------------------------------------------*/ 
oAbrArq := WinExec("NOTEPAD.EXE "+_cPath+_cArquivo)  // Abre o arquivo Log na Tela do usuario

MsgAlert("Foram listado " + alltrim(str(nConta)) + " registros!!!")

If Select("TRB") > 0 ; dbSelectArea("TRB") ; TRB->( dbCloseArea() ) ; Endif

return


/*-----------------------------------------------------------------------
| Funcao   | ValidPerg | Autor | Otavio Pinto        | Data | 18/04/2013 |
|------------------------------------------------------------------------|
| Descricao| Verifica a existencia das perguntas criando-as caso seja    | 
|          | necessario (caso nao existam).                              |
 -----------------------------------------------------------------------*/
Static Function ValidPerg

Local j := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
Local i := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

_sAlias := Alias()
aRegs   := {}

dbSelectArea("SX1")
dbSetOrder(1)
cPerg := PadR(cPerg,Len(SX1->X1_GRUPO))

// Grupo/Ordem/Pergunta/PerEsp/PerIng/Variavel/Tipo/Tamanho/Decimal/Presel/GSC/Valid/Var01/Def01///Cnt01/Var02/Def02/Cnt02/Var03/Def03/Cnt03/Var04/Def04/Cnt04/Var05/Def05/Cnt05

AAdd(aRegs,{cPerg , "01" , "Da Data Emissao          ?" ,"","", "mv_ch1" , "D" , 8 , 0 ,0 , "G" , "" , "mv_par01" , ""     , "" , "" , ""  , "" , ""     , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , ""    , "" })
AAdd(aRegs,{cPerg , "02" , "Ate Data Emissao         ?" ,"","", "mv_ch2" , "D" , 8 , 0 ,0 , "G" , "" , "mv_par02" , ""     , "" , "" , ""  , "" , ""     , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , ""    , "" })
Aadd(aRegs,{cPerg , "03" , "Informe endereco p/Query ?" ,"","", "mv_ch3" , "C" , 50 ,0 ,0 , "G" , "" , "mv_par03" , ""     , "" , "" , ""  , "" , ""     , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , ""    , "" })

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


// Fim do MAPVTCC.PRW
