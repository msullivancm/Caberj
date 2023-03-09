#include "rwmake.ch" 

/*-----------------------------------------------------------------------
| Funcao   | CABR146  | Autor | Otavio Pinto         | Data | 21/05/2014 |
|------------------------------------------------------------------------|
| Descricao| LEVANTAMENTO 24 ANOS                                        |
|------------------------------------------------------------------------|
|          |     | Gerar rel. Data Limite e dep 24 anos sem bloqueio.    |
|          |     |                                                       |
 -----------------------------------------------------------------------*/
user function CABR146()

Local   aRegs     := {}

private cNomRot   := "CABR146" 
private cLIN      := ""
private cCRLF     := CHR(13)+CHR(10)
private nConta    := 0
private cPerg     := "CABR146"
private nLastKey  := 0   
private nPos1     :=  9
private nPos2     := 40
private nPos3     := 15
private _cDeli    := ';'

if MSGBOX("Deseja executar esta rotina... : "+ cCRLF + cCRLF + " Confirma???","LEVANTAMENTO 24 ANOS","YESNO")
   ValidPerg()
   if Pergunte(cPerg,.T.)
       Processa({ ||IMP_REL2()},"Gerando Arquivo ...")
   endIf    
endif

Return Nil

/*-----------------------------------------------------------------------
| Funcao   | IMP_REL2  | Autor | Otavio Pinto        | Data | 21/05/2014 |
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

cStrSQL := " SELECT BA1_CODINT " + cCRLF  
cStrSQL += "      , BA1_CODEMP " + cCRLF  
cStrSQL += "      , BA1_MATRIC " + cCRLF  
cStrSQL += "      , BA1_TIPREG " + cCRLF  
cStrSQL += "      , BA1_DIGITO " + cCRLF  
cStrSQL += "      , idade_xxx ( BA1_DATNAS ) IDADE " + cCRLF  
cStrSQL += "      , SubStr(BA1_DATBLO,7,2)||'/'||SubStr(BA1_DATBLO,5,2)||'/'||SubStr(BA1_DATBLO,1,4)   BA1_DATBLO " + cCRLF  
cStrSQL += "      , BA1_MOTBLO " + cCRLF  
cStrSQL += "      , SubStr(BA1_YDTLIM,7,2)||'/'||SubStr(BA1_YDTLIM,5,2)||'/'||SubStr(BA1_YDTLIM,1,4)   BA1_YDTLIM " + cCRLF  
cStrSQL += "      , BA1_CODPLA " + cCRLF  
cStrSQL += "      , CASE WHEN Length(Trim(BA1_MATEMP)) = 11 THEN SubStr(BA1_MATEMP,4,6) " + cCRLF  
cStrSQL += "             WHEN Length(Trim(BA1_MATEMP)) = 8 THEN SubStr(BA1_MATEMP,1,6) " + cCRLF  
cStrSQL += "             ELSE '' " + cCRLF  
cStrSQL += "             END BA1_MATEMP  " + cCRLF  
cStrSQL += "      , BA1_IMAGE " + cCRLF  
cStrSQL += "      , BA1_CPFUSR " + cCRLF  
cStrSQL += "      , BA1_MATVID " + cCRLF  
cStrSQL += "      , BA1_NOMUSR " + cCRLF  
cStrSQL += "      , BA1_NREDUZ " + cCRLF  
cStrSQL += "      , SubStr(BA1_DATNAS,7,2)||'/'||SubStr(BA1_DATNAS,5,2)||'/'||SubStr(BA1_DATNAS,1,4)   BA1_DATNAS " + cCRLF  
cStrSQL += "      , BA1_SEXO " + cCRLF  
cStrSQL += "      , BA1_TIPUSU " + cCRLF  
cStrSQL += "      , BA1_ESTCIV " + cCRLF  
cStrSQL += "      , BA1_GRAUPA " + cCRLF  
cStrSQL += "      , SubStr(BA1_DATINC,7,2)||'/'||SubStr(BA1_DATINC,5,2)||'/'||SubStr(BA1_DATINC,1,4)    BA1_DATINC " + cCRLF  
cStrSQL += " FROM "+RetSqlName("BA1")+" ZX " + cCRLF 
cStrSQL += " WHERE D_E_L_E_T_ = ' ' " + cCRLF  

DO CASE
   CASE mv_par01 == 1 ; cStrSQL += "   AND idade_xxx ( BA1_DATNAS ) >= '" + ALLTRIM(str(MV_PAR02)) +"' "+ cCRLF  
   CASE mv_par01 == 2 ; cStrSQL += "   AND idade_xxx ( BA1_DATNAS ) <= '" + ALLTRIM(str(MV_PAR02)) +"' "+ cCRLF  
   CASE mv_par01 == 3 ; cStrSQL += "   AND idade_xxx ( BA1_DATNAS ) =  '" + ALLTRIM(str(MV_PAR02)) +"' "+ cCRLF  
ENDCASE

cStrSQL += " ORDER BY BA1_CODINT,BA1_CODEMP,BA1_MATRIC,BA1_TIPREG " + cCRLF  


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

   _cCabec  := PADR("CODINT"   ,006," ")+_cDeli+;
               PADR("CODEMP"   ,006," ")+_cDeli+;
               PADR("MATRIC"   ,006," ")+_cDeli+;
               PADR("TIPREG"   ,006," ")+_cDeli+; 
               PADR("DIGITO"   ,006," ")+_cDeli+;
               PADR("IDADE"    ,005," ")+_cDeli+;               
               PADL("DATBLO"   ,013," ")+_cDeli+;
               PADR("MOTBLO"   ,006," ")+_cDeli+;
               PADL("YDTLIM"   ,013," ")+_cDeli+;
               PADR("CODPLA"   ,006," ")+_cDeli+;
               PADL("MATEMP"   ,006," ")+_cDeli+;
               PADR("IMAGE"    ,007," ")+_cDeli+;
               PADL("CPFUSR"   ,013," ")+_cDeli+;
               PADR("MATVID"   ,006," ")+_cDeli+;
               PADL("NOMUSR"   ,070," ")+_cDeli+;
               PADR("NREDUZ"   ,020," ")+_cDeli+;
               PADL("DATNAS"   ,013," ")+_cDeli+;
               PADR("SEXO"     ,004," ")+_cDeli+;
               PADL("TIPUSU"   ,013," ")+_cDeli+;
               PADR("ESTCIV"   ,006," ")+_cDeli+;
               PADL("GRAUPA"   ,006," ")+_cDeli+;
               PADR("DATINC"   ,013," ")+_cDeli
               
   nCol1 := len(_cCabec) + 1  

   cBuffer :=  PADR( _cCabec ,nCol1,"") + cCRLF  
   FWrite(nHandle, cBuffer)

   while TRB->( !Eof() )
      lRet := .T.
      
      _cLinha := TRB->(PADR("'"+BA1_CODINT   ,006," ")+_cDeli+""+;
                       PADR("'"+BA1_CODEMP   ,006," ")+_cDeli+""+;
                       PADR("'"+BA1_MATRIC   ,006," ")+_cDeli+""+;
                       PADR("'"+BA1_TIPREG   ,006," ")+_cDeli+""+; 
                       PADR("'"+BA1_DIGITO   ,006," ")+_cDeli+""+;
                       PADR(IDADE            ,005," ")+_cDeli+""+;               
                       PADL(BA1_DATBLO       ,013," ")+_cDeli+""+;
                       PADR("'"+BA1_MOTBLO   ,006," ")+_cDeli+""+;
                       PADL(BA1_YDTLIM       ,013," ")+_cDeli+""+;
                       PADR("'"+BA1_CODPLA   ,006," ")+_cDeli+""+;
                       PADL("'"+BA1_MATEMP   ,006," ")+_cDeli+""+;
                       PADR(BA1_IMAGE        ,007," ")+_cDeli+""+;
                       PADL("'"+BA1_CPFUSR   ,013," ")+_cDeli+""+;
                       PADR("'"+BA1_MATVID   ,006," ")+_cDeli+""+;
                       PADL(BA1_NOMUSR       ,070," ")+_cDeli+""+;
                       PADR(BA1_NREDUZ       ,020," ")+_cDeli+""+;
                       PADL(BA1_DATNAS       ,013," ")+_cDeli+""+;
                       PADR(BA1_SEXO         ,004," ")+_cDeli+""+;
                       PADL("'"+BA1_TIPUSU   ,013," ")+_cDeli+""+;
                       PADR(BA1_ESTCIV       ,006," ")+_cDeli+""+;
                       PADL("'"+BA1_GRAUPA   ,006," ")+_cDeli+""+;
                       PADR(BA1_DATINC       ,013," ")+_cDeli )
                       
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
| Funcao   | ValidPerg | Autor | Otavio Pinto        | Data | 21/05/2014 |
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

AAdd(aRegs,{cPerg , "01" , "Operador                 ?" ,"","", "mv_ch1" , "C" , 01 , 0 ,0 , "C" , "" , "mv_par01" , "Maior que"   , "" , "" , ""  , "" , "Menor que"   , "" , "" , "" , "" , "Igual a" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , ""    , "" })
AAdd(aRegs,{cPerg , "02" , "Idade                    ?" ,"","", "mv_ch2" , "N" , 06 , 0 ,0 , "G" , "" , "mv_par02" , ""            , "" , "" , ""  , "" , ""            , "" , "" , "" , "" , ""        , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , ""    , "" })

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


// Fim do CABR146.PRW
