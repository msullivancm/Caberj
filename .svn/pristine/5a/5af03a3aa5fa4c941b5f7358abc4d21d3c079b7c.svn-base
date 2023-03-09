#include "rwmake.ch" 

/*-----------------------------------------------------------------------
| Funcao   | CABR139  | Autor | Otavio Pinto         | Data | 10/04/2014 |
|------------------------------------------------------------------------|
| Descricao| CONTROLE DE PENDENCIAS                                      |
|------------------------------------------------------------------------|
|          |     | Gerar este relatorio de pendencias por faixa de data. |
|          |     |                                                       |
 -----------------------------------------------------------------------*/
user function CABR139()

Local   aRegs     := {}

private cNomRot   := "CABR139" 
private cLIN      := ""
private cCRLF     := CHR(13)+CHR(10)
private nConta    := 0
private cPerg     := "CABR139"
private nLastKey  := 0   
private nPos1     :=  9
private nPos2     := 40
private nPos3     := 15
private _cDeli    := ';'

if MSGBOX("Deseja executar esta rotina... : "+ cCRLF + cCRLF + " Confirma???","CONTROLE DE PENDENCIAS","YESNO")
   ValidPerg()
   if Pergunte(cPerg,.T.)
       Processa({ ||IMP_REL2()},"Gerando Arquivo ...")
   endIf    
endif

Return Nil

/*-----------------------------------------------------------------------
| Funcao   | IMP_REL2  | Autor | Otavio Pinto        | Data | 10/04/2014 |
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
FErase( Alltrim(_cPath)+_cArquivo )
	                      
/*-----------------------------------------------------------------------
| Cria novo arquivo                                                      |
 -----------------------------------------------------------------------*/
nHandle := FCreate(Alltrim(_cPath) + _cArquivo)
	
if nHandle == -1
	MsgStop("Erro na criacao do arquivo na estacao local. Contate o administrador do sistema")
	return
EndIf

/*-----------------------------------------------------------------------
| Montagem da query                                                      |
 -----------------------------------------------------------------------*/

cStrSQL := "SELECT SubStr(ZY_DTSERV,7,2)||'/'||SubStr(ZY_DTSERV,5,2)||'/'||SubStr(ZY_DTSERV,1,4)  DATA " + cCRLF  
cStrSQL += "     , ZX_SEQ     NPA " + cCRLF  
cStrSQL += "     , ZX_NOMUSR  ASSOCIADO " + cCRLF  
cStrSQL += "     , Trim(ZY_OBS)  ASSUNTO " + cCRLF   
cStrSQL += "     , ZX_RDA  RDA " + cCRLF  
cStrSQL += "     , (SELECT BAU_NOME " + cCRLF
cStrSQL += "        FROM "+RetSqlName("BAU")+" AU " + cCRLF
cStrSQL += "        WHERE BAU_FILIAL    = ZX_FILIAL " + cCRLF  
cStrSQL += "          AND BAU_CODIGO    = ZX_RDA " + cCRLF  
cStrSQL += "          AND AU.D_E_L_E_T_ = ' ' ) NOME_RDA " + cCRLF  
cStrSQL += "     , SubStr(ZX_DATDE,7,2)||'/'||SubStr(ZX_DATDE,5,2)||'/'||SubStr(ZX_DATDE,1,4)   DT_EMISSAO "  + cCRLF  
cStrSQL += "     , ZX_YAGENC  GERENCIA " + cCRLF  
cStrSQL += "     , Decode( ZX_TPINTEL,'1','Pendente','2','Encerrado') STATUS " + cCRLF  

cStrSQL += "FROM "+RetSqlName("SZX")+" ZX " + cCRLF  
cStrSQL += "   , "+RetSqlName("SZY")+" ZY " + cCRLF
cStrSQL += "   , "+RetSqlName("PBL")+" BL " + cCRLF 

cStrSQL += "WHERE ZX_SEQ        = ZY_SEQBA " + cCRLF     
cStrSQL += "  AND ZX_DATDE BETWEEN '"+DTOS(MV_PAR01)+"' AND '"+DTOS(MV_PAR02)+"' " + cCRLF  

if MV_PAR03 <> 3
   cStrSQL += "  AND ZX_TPINTEL    = '"+strzero(MV_PAR03,1)+"' " + cCRLF  
endif       

cStrSQL += "  AND PBL_FILIAL    = ZX_FILIAL " + cCRLF  
cStrSQL += "  AND PBL_YCDSRV    = ZY_TIPOSV " + cCRLF  
cStrSQL += "  AND TRIM(PBL_YDEPTO) = TRIM(ZX_YAGENC) " + cCRLF  

cStrSQL += "  AND ZX.D_E_L_E_T_ = ' ' " + cCRLF  
cStrSQL += "  AND ZY.D_E_L_E_T_ = ' ' " + cCRLF  
cStrSQL += "  AND BL.D_E_L_E_T_ = ' ' " + cCRLF  

cStrSQL += "ORDER BY ZY_DTSERV, ZX_SEQ " + cCRLF  
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

//+----------------------------------------------------------------+
//| Se tabela TRAB retornar VAZIO, não gera resumo e exibe mensagem |
//+----------------------------------------------------------------+
if TRB->( !Eof() )
   _nConta  := 0
   _cCabec  := PADR("DATA"     ,012," ")+_cDeli+""+;
               PADR("Nº PA"    ,006," ")+_cDeli+""+;
               PADR("ASSOCIADO",040," ")+_cDeli+""+;
               PADR("ASSUNTO"  ,150," ")+_cDeli+""+;
               PADR("RDA"      ,006," ")+_cDeli+""+;
               PADR("NOME RDA" ,040," ")+_cDeli+""+;
               PADR("DT_EMISSA",011," ")+_cDeli+""+;
               PADR("GERENCIA" ,020," ")+_cDeli+""+;
               PADR("STATUS"   ,009," ")
               
   nCol1 := len(_cCabec) + 1  

   cBuffer :=  PADR( _cCabec ,nCol1,"") + cCRLF  
   FWrite(nHandle, cBuffer)

   while TRB->( !Eof() )
      lRet := .T.
      _cLinha := TRB->(PADL( DATA               ,012," ")+_cDeli+""+;
                       PADR( NPA                ,006," ")+_cDeli+""+;
                       PADR( ALLTRIM(ASSOCIADO) ,040," ")+_cDeli+""+;
                       PADR( ALLTRIM(STRTRAN(ASSUNTO,";","-"))   ,150," ")+_cDeli+""+; 
                       PADR( RDA                ,006," ")+_cDeli+""+;
                       PADR( ALLTRIM(NOME_RDA)  ,040," ")+_cDeli+""+;                       
                       PADR( DT_EMISSAO         ,011," ")+_cDeli+""+;
                       PADR( ALLTRIM(GERENCIA)  ,020," ")+_cDeli+""+;
                       PADL( STATUS             ,009," ") )
      IncProc()
      _nConta ++    
      cBuffer :=  PADR( _cLinha ,nCol1,"") + cCRLF  
      FWrite(nHandle, cBuffer)                                         
      TRB->( DbSkip() )               	
      if TRB->( eof() )
         //+---------------------------------------------------------------------+
         //| Finaliza a listagem                                                 |
         //+---------------------------------------------------------------------+
         cBuffer := "Fim "
         FWrite(nHandle, cBuffer)
      endif
   ENDDO          
endif

FClose(nHandle)

/*-----------------------------------------------------------------------
| Abre o arquivo no bloco de notas.                                      |
 -----------------------------------------------------------------------*/ 
cArq := Alltrim(_cPath)+_cArquivo

oExcelApp := MsExcel():New()
oExcelApp:WorkBooks:Open( &("cArq" ) ) // Abre uma planilha
oExcelApp:SetVisible(.T.)              

If Select("TRB") > 0 ; dbSelectArea("TRB") ; TRB->( dbCloseArea() ) ; Endif

return


/*-----------------------------------------------------------------------
| Funcao   | ValidPerg | Autor | Otavio Pinto        | Data | 10/04/2014 |
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

AAdd(aRegs,{cPerg , "01" , "Da Data Emissao          ?" ,"","", "mv_ch1" , "D" , 08 , 0 ,0 , "G" , "" , "mv_par01" , ""          , "" , "" , ""  , "" , ""          , "" , "" , "" , "" , ""      , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , ""    , "" })
AAdd(aRegs,{cPerg , "02" , "Ate Data Emissao         ?" ,"","", "mv_ch2" , "D" , 08 , 0 ,0 , "G" , "" , "mv_par02" , ""          , "" , "" , ""  , "" , ""          , "" , "" , "" , "" , ""      , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , ""    , "" })
Aadd(aRegs,{cPerg , "03" , "Informe o Status         ?" ,"","", "mv_ch3" , "N" , 01 , 0 ,0 , "C" , "" , "mv_par03" , "Pendente"  , "" , "" , ""  , "" , "Encerrado" , "" , "" , "" , "" , "Ambos" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , ""    , "" })

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


// Fim do CABR139.PRW
