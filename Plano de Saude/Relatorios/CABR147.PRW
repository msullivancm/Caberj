#include "rwmake.ch" 

/*-----------------------------------------------------------------------
| Funcao   | CABR147  | Autor | Otavio Pinto         | Data | 14/07/2014 |
|------------------------------------------------------------------------|
| Descricao| Relatório de Histórico de Carteirinhas                      |
|------------------------------------------------------------------------|
|          |     | UTILIZADO NO MÓDULO DE TREINAMENTO                    |
|          |     |                                                       |
 -----------------------------------------------------------------------*/
user function CABR147()

Local   aRegs     := {}

private cNomRot   := "CABR147" 
private cLIN      := ""
private cCRLF     := CHR(13)+CHR(10)
private nConta    := 0
private cPerg     := "CABR147"
private nLastKey  := 0   
private nPos1     :=  9
private nPos2     := 40
private nPos3     := 15
private _cDeli    := ';'

if MSGBOX("Deseja executar esta rotina... : "+ cCRLF + cCRLF + " Confirma???","Relatório de Histórico de Carteirinhas","YESNO")
   ValidPerg()
   if Pergunte(cPerg,.T.)
       Processa({ ||IMP_REL2()},"Gerando Arquivo ...")
   endIf    
endif

Return Nil

/*-----------------------------------------------------------------------
| Funcao   | IMP_REL2  | Autor | Otavio Pinto        | Data | 14/07/2014 |
|------------------------------------------------------------------------|
| Descricao| Rotina de impressao                                         |
 -----------------------------------------------------------------------*/
static function IMP_REL2()
Local _lCabec       := .T.	
Local cCabCSV       := ""

private _cDirDocs   := MsDocPath()
private _cPath		:= "C:\TEMP\"
private _cArquivo  	:= cNomRot+cValtoChar(Randomize(1,34000))+".csv"    // Alterada a extensão de TXT para CSV 
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
	MsgStop("Erro na criacao do arquivo na estacao local. Verifique se a planilha encontra-se aberta.")
	return
EndIf

/*-----------------------------------------------------------------------
| Montagem da query                                                      |
 -----------------------------------------------------------------------*/

cStrSQL := "  SELECT " + cCRLF  
cStrSQL += "        BED_CODINT  CODINT " + cCRLF  
cStrSQL += "      , BED_CODEMP  CODEMP " + cCRLF  
cStrSQL += "      , BED_MATRIC  MATRIC " + cCRLF  
cStrSQL += "      , BED_TIPREG  TIPREG " + cCRLF  
cStrSQL += "      , BED_DIGITO  DIGITO " + cCRLF  

cStrSQL += "      , BED_NOMUSR NOME_USUARIO " + cCRLF  

cStrSQL += "      , SubStr(BA1_DATNAS,7,2)||'/'||SubStr(BA1_DATNAS,5,2)||'/'||SubStr(BA1_DATNAS,1,4) DTNASC " + cCRLF  
cStrSQL += "      , (SELECT BRP_DESCRI " + cCRLF  
cStrSQL += "         FROM   BRP010 " + cCRLF  
cStrSQL += "         WHERE  BRP_CODIGO  = BA1_GRAUPA ) PARENTESCO " + cCRLF  

cStrSQL += "      , SubStr(BA3_VALID,7,2)||'/'||SubStr(BA3_VALID,5,2)||'/'||SubStr(BA3_VALID,1,4) DTVALID " + cCRLF  
cStrSQL += "      , SubStr(BA1_DATINC,7,2)||'/'||SubStr(BA1_DATINC,5,2)||'/'||SubStr(BA1_DATINC,1,4) DTINCLUSAO " + cCRLF  
cStrSQL += "      , SubStr(BA1_YDTLIM,7,2)||'/'||SubStr(BA1_YDTLIM,5,2)||'/'||SubStr(BA1_YDTLIM,1,4) DTLIMITE " + cCRLF  

// INICIO  - Mateus Medeiros 
// Incluido 28/11/2017 - Para atender a demanda do GLPI 45008 
cStrSQL += "      , BA1_CODPLA   PLANO " + cCRLF 
// FIM MATEUS MEDEIROS 

cStrSQL += "      , BED_VIACAR   VIA " + cCRLF  

cStrSQL += "      , SubStr(BED_DTSOLI,7,2)||'/'||SubStr(BED_DTSOLI,5,2)||'/'||SubStr(BED_DTSOLI,1,4) DTSOLICIT " + cCRLF  
cStrSQL += "      , BED_MOTIVO  MOTIVO " + cCRLF  
cStrSQL += "      , (SELECT BPX_DESCRI " + cCRLF  
cStrSQL += "         FROM   BPX010 " + cCRLF  
cStrSQL += "         WHERE  BPX_CODINT = BED_CODINT " + cCRLF  
cStrSQL += "           AND  BPX_MOTIVO  = BED_MOTIVO ) DESC_MOTIVO " + cCRLF  

cStrSQL += "      , BED_CDIDEN EXP_EMIS_ID " + cCRLF  
cStrSQL += "      , Decode( BED_MOTIVO, '4','PRIMEIRA VIA','2','RENOVACAO','3','RENOVACAO','AVULSA') NUM_COBRANCA " + cCRLF  
cStrSQL += "      , Decode( BED_BLOIDE, '1','Sim','Nao') BLOQUEADO " + cCRLF  
cStrSQL += "      , Decode(BED_STACAR,'1','Em aberto','2','Encerrado','') STAT_EMISSAO " + cCRLF  

cStrSQL += " FROM " + RetSQLName("BED")+" BED " + cCRLF  

cStrSQL += " INNER JOIN " + RetSQLName("BA1")+" BA1 ON BA1.D_E_L_E_T_ = ' ' " + cCRLF  
cStrSQL += "   AND BA1_FILIAL     = '  ' " + cCRLF  
cStrSQL += "   AND BA1_CODINT     = BED_CODINT " + cCRLF  
cStrSQL += "   AND BA1_CODEMP     = BED_CODEMP " + cCRLF  
cStrSQL += "   AND BA1_MATRIC     = BED_MATRIC " + cCRLF  
cStrSQL += "   AND BA1_TIPREG     = BED_TIPREG " + cCRLF  
cStrSQL += "   AND BA1_DIGITO     = BED_DIGITO " + cCRLF  
cStrSQL += " INNER JOIN " + RetSQLName("BA3")+" BA3 ON BA3.D_E_L_E_T_ = ' ' " + cCRLF  
cStrSQL += "   AND BA3_FILIAL     = '  ' " + cCRLF  
cStrSQL += "   AND BA3_CODINT     = BED_CODINT " + cCRLF  
cStrSQL += "   AND BA3_CODEMP     = BED_CODEMP " + cCRLF  
cStrSQL += "   AND BA3_MATRIC     = BED_MATRIC " + cCRLF  
cStrSQL += " INNER JOIN " + RetSQLName("BTS")+" BTS ON BTS.D_E_L_E_T_ = ' ' " + cCRLF  
cStrSQL += "   AND BA1_MATVID     = BTS_MATVID " + cCRLF  
cStrSQL += "   AND BTS_FILIAL     = '  ' " + cCRLF  

cStrSQL += " WHERE BED.D_E_L_E_T_ = ' ' " + cCRLF  
cStrSQL += "   AND BED_FILIAL     = '  ' " + cCRLF  
cStrSQL += "   AND BA1_MOTBLO     = ' ' " + cCRLF  

if ! Empty(MV_PAR01) 
   cStrSQL += "   AND BED_CODINT = '"+Alltrim(MV_PAR01)+"' " + cCRLF 
endif
if ! Empty(MV_PAR02) 
   cStrSQL += "   AND BED_CODEMP = '"+Alltrim(MV_PAR02)+"' " + cCRLF 
endif
if !( Empty(MV_PAR03) .and. empty(MV_PAR04) )
   cStrSQL += "   AND BED_MATRIC BETWEEN '"+SUBSTR(Alltrim(MV_PAR03),9,6)+"' AND '"+SUBSTR(Alltrim(MV_PAR04),9,6)+"' " + cCRLF 
endif
if !( Empty(MV_PAR05) .and. empty(MV_PAR06) )
   cStrSQL += "   AND BED_DTSOLI BETWEEN '"+DTOS(MV_PAR05)   +"' AND '"+DTOS(MV_PAR06)   +"' " + cCRLF 
endif
if !( Empty(MV_PAR07) .and. empty(MV_PAR08) )
   cStrSQL += "   AND BTS_CODMUN BETWEEN '"+Alltrim(MV_PAR07)+"' AND '"+Alltrim(MV_PAR08)+"' " + cCRLF 
endif   
if !( Empty(MV_PAR09) .and. empty(MV_PAR10) )
   cStrSQL += "   AND BTS_ESTADO BETWEEN '"+Alltrim(MV_PAR09)+"' AND '"+Alltrim(MV_PAR10)+"' " + cCRLF 
endif

cStrSQL += " ORDER BY BED_NOMUSR, BED_DTSOLI, BED_VIACAR " + cCRLF  

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

     _cCabec := PADR("MATRICULA"   ,022 ," ")+_cDeli+""+;
                PADR("NOME_USUARIO",050 ," ")+_cDeli+""+;
                PADR("DTNASC"      ,011 ," ")+_cDeli+""+;
                PADR("PARENTESCO"  ,014 ," ")+_cDeli+""+;
                PADR("DTVALID"     ,011 ," ")+_cDeli+""+;
                PADR("DTINCLUSAO"  ,011 ," ")+_cDeli+""+;
                PADR("DTLIMITE"    ,011 ," ")+_cDeli+""+;
                PADR("VIA"         ,003 ," ")+_cDeli+""+;
                PADR("DTSOLICIT"   ,011 ," ")+_cDeli+""+;
                PADR("MOTIVO"      ,006 ," ")+_cDeli+""+;
                PADR("DESC_MOTIVO" ,040 ," ")+_cDeli+""+;
                PADR("EXP_EMIS_ID" ,020 ," ")+_cDeli+""+;
                PADR("NUM_COBRANCA",013 ," ")+_cDeli+""+;
                PADR("BLOQUEADO"   ,010 ," ")+_cDeli+""+;
                PADR("STAT_EMISSAO",012 ," ")+_cDeli+""+;
                PADR("PLANO"       ,050 ," ")

   nCol1 := len(_cCabec) + 1  

   cBuffer :=  PADR( _cCabec ,nCol1,"") + cCRLF  
   FWrite(nHandle, cBuffer)

   while TRB->( !Eof() )
      lRet := .T.
      _cLinha := TRB->(PADR("'"+CODINT+"."+CODEMP+"."+MATRIC+"."+TIPREG+"-"+DIGITO ,022 ," ")+_cDeli+""+;
                       PADR(NOME_USUARIO,050 ," ")+_cDeli+""+;
                       PADR(DTNASC      ,011 ," ")+_cDeli+""+;
                       PADR(PARENTESCO  ,014 ," ")+_cDeli+""+;
                       PADR(DTVALID     ,011 ," ")+_cDeli+""+;
                       PADR(DTINCLUSAO  ,011 ," ")+_cDeli+""+;
                       PADR(DTLIMITE    ,011 ," ")+_cDeli+""+;
                       PADR(VIA         ,003 ," ")+_cDeli+""+;
                       PADR(DTSOLICIT   ,011 ," ")+_cDeli+""+;
                       PADR(MOTIVO      ,006 ," ")+_cDeli+""+;
                       PADR(DESC_MOTIVO ,040 ," ")+_cDeli+""+;
                       PADR("'"+EXP_EMIS_ID ,020 ," ")+_cDeli+""+;
                       PADR(NUM_COBRANCA,013 ," ")+_cDeli+""+;
                       PADR(BLOQUEADO   ,010 ," ")+_cDeli+""+;
                       PADR(STAT_EMISSAO,012 ," ")+_cDeli+""+;
                       PADR(Alltrim(GetAdvFVal("BI3","BI3_DESCRI",xFilial("BI3")+TRB->CODINT+TRB->PLANO,5)),50 ," "))

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
| Funcao   | ValidPerg | Autor | Otavio Pinto        | Data | 14/07/2014 |
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

AAdd(aRegs,{cPerg , "01" , "Operadora                ?" ,"","", "mv_ch1" , "C" , 04 , 0 ,0 , "G" , "" , "mv_par01" , ""     , "" , "" , ""  , "" , ""    , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , ""      , "" })
AAdd(aRegs,{cPerg , "02" , "Grupo Empresa            ?" ,"","", "mv_ch2" , "C" , 04 , 0 ,0 , "G" , "" , "mv_par02" , ""     , "" , "" , ""  , "" , ""    , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , ""      , "" })
Aadd(aRegs,{cPerg , "03" , "Matricula De             ?" ,"","", "mv_ch3" , "C" , 17 , 0 ,0 , "G" , "" , "mv_par03" , ""     , "" , "" , ""  , "" , ""    , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "MATUSR", "" })
AAdd(aRegs,{cPerg , "04" , "Matricula Ate            ?" ,"","", "mv_ch4" , "C" , 17 , 0 ,0 , "G" , "" , "mv_par04" , ""     , "" , "" , ""  , "" , ""    , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "MATUSR", "" })
AAdd(aRegs,{cPerg , "05" , "Dt Solicitacao De        ?" ,"","", "mv_ch5" , "D" , 08 , 0 ,0 , "G" , "" , "mv_par05" , ""     , "" , "" , ""  , "" , ""    , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , ""      , "" })
AAdd(aRegs,{cPerg , "06" , "Dt Solicitacao Ate       ?" ,"","", "mv_ch6" , "D" , 08 , 0 ,0 , "G" , "" , "mv_par06" , ""     , "" , "" , ""  , "" , ""    , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , ""      , "" })
AAdd(aRegs,{cPerg , "07" , "Cod Municipio De         ?" ,"","", "mv_ch7" , "C" , 07 , 0 ,0 , "G" , "" , "mv_par07" , ""     , "" , "" , ""  , "" , ""    , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "12"    , "" })
Aadd(aRegs,{cPerg , "08" , "Cod Municipio Ate        ?" ,"","", "mv_ch8" , "C" , 07 , 0 ,0 , "G" , "" , "mv_par08" , ""     , "" , "" , ""  , "" , ""    , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "12"    , "" })
Aadd(aRegs,{cPerg , "09" , "Estado De                ?" ,"","", "mv_ch9" , "C" , 02 , 0 ,0 , "G" , "" , "mv_par09" , ""     , "" , "" , ""  , "" , ""    , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "B57PLS", "" })
Aadd(aRegs,{cPerg , "10" , "Estado Ate               ?" ,"","", "mv_chA" , "C" , 02 , 0 ,0 , "G" , "" , "mv_par10" , ""     , "" , "" , ""  , "" , ""    , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "B57PLS", "" })


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


// Fim do CABR147.PRW
