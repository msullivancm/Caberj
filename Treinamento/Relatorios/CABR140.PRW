#include "rwmake.ch" 

/*-----------------------------------------------------------------------
| Funcao   | CABR140  | Autor | Otavio Pinto         | Data | 11/04/2014 |
|------------------------------------------------------------------------|
| Descricao| Listagem quantitativa de treinamento por curso              |
|------------------------------------------------------------------------|
|          |     | UTILIZADO NO MÓDULO DE TREINAMENTO                    |
|          |     |                                                       |
 -----------------------------------------------------------------------*/
user function CABR140()

Local   aRegs     := {}

private cNomRot   := "CABR140" 
private cLIN      := ""
private cCRLF     := CHR(13)+CHR(10)
private nConta    := 0
private cPerg     := "CABR140"
private nLastKey  := 0   
private nPos1     :=  9
private nPos2     := 40
private nPos3     := 15
private _cDeli    := ';'

if MSGBOX("Deseja executar esta rotina... : "+ cCRLF + cCRLF + " Confirma???","Listagem quantitativa de treinamento por curso","YESNO")
   ValidPerg()
   if Pergunte(cPerg,.T.)
       Processa({ ||IMP_REL2()},"Gerando Arquivo ...")
   endIf    
endif

Return Nil

/*-----------------------------------------------------------------------
| Funcao   | IMP_REL2  | Autor | Otavio Pinto        | Data | 11/04/2014 |
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
	MsgStop("Erro na criacao do arquivo na estacao local. Verifique se a planilha encontra-se aberta.")
	return
EndIf

/*-----------------------------------------------------------------------
| Montagem da query                                                      |
 -----------------------------------------------------------------------*/

cStrSQL := " SELECT Trim (CTT_DESC01)  DEPTO " + cCRLF  
cStrSQL += "     , RA4_MAT MATRICULA " + cCRLF  
cStrSQL += "     , RA_NOME NOME " + cCRLF  
cStrSQL += "     , RA1_CURSO|| ' '||RA1_DESC CURSO " + cCRLF     
cStrSQL += "     ,     CASE " + cCRLF 
cStrSQL += "       WHEN RA2_XCODIS <> ' ' THEN  TRIM(RA2.RA2_XCODIS)|| '-' ||TRIM(RA2.RA2_XDEDIS) " + cCRLF 
cStrSQL += "       ELSE" + cCRLF 
cStrSQL += "       'SEM DISCIPLINA'" + cCRLF 
cStrSQL += "       END DISCIPLINA" + cCRLF 
cStrSQL += "     , RA2_CALEND|| ' ' ||RA2_DESC CALENDARIO " + cCRLF  
cStrSQL += "     , RA2_TURMA TURMA " + cCRLF  
cStrSQL += "     , RA4_NOTA NOTA " + cCRLF  
cStrSQL += "     , Decode ( RA4_PRESEN, '0','Nao','Sim') Fez_treinamento " + cCRLF  
cStrSQL += "     , SubStr(RA4_DATAIN,7,2)||'/'||SubStr(RA4_DATAIN,5,2)||'/'||SubStr(RA4_DATAIN,1,4) INICIAL " + cCRLF  
cStrSQL += "     , SubStr(RA4_DATAFI,7,2)||'/'||SubStr(RA4_DATAFI,5,2)||'/'||SubStr(RA4_DATAFI,1,4) FINAL " + cCRLF  
cStrSQL += "     , RA4_PRESEN PRESENCA " + cCRLF   
cStrSQL += "     , RA4.RA4_XDESFA MOT_FALTA" + cCRLF   

cStrSQL += "FROM RA4010 RA4 " + cCRLF 
cStrSQL += "   , RA1010 RA1 " + cCRLF 
cStrSQL += "   , RA2010 RA2 " + cCRLF 
cStrSQL += "   , SRA010 SRA " + cCRLF
cStrSQL += "   , CTT010 CTT " + cCRLF

cStrSQL += "WHERE RA4_FILIAL = '01' " + cCRLF  
cStrSQL += "  AND RA4_DATAIN BETWEEN '"+dtos(MV_PAR01)+"' AND '"+dtos(MV_PAR02)+"' " + cCRLF  

cStrSQL += "  AND RA_MAT     = RA4_MAT " + cCRLF  
cStrSQL += "  AND RA1_CURSO  = RA4_CURSO " + cCRLF  

cStrSQL += "  AND RA4_CALEND = RA2_CALEND " + cCRLF  
cStrSQL += "  AND RA4_CURSO  = RA2_CURSO " + cCRLF  
cStrSQL += "  AND RA4_TURMA  = RA2_TURMA " + cCRLF  

cStrSQL += "  AND RA_CC      = CTT_CUSTO " + cCRLF  
cStrSQL += "  AND CTT_CUSTO  BETWEEN '"+Alltrim(MV_PAR03)+"' AND '"+Alltrim(MV_PAR04)+"' " + cCRLF  

if MV_PAR05 == 1
   cStrSQL += "  AND RA2_REALIZ = 'S' " + cCRLF  
else
   cStrSQL += "  AND RA2_REALIZ <> 'S' " + cCRLF 
endif                 
if MV_PAR06 == 1
   cStrSQL += "  AND RA4_PRESEN > '0' " + cCRLF  
endif  
if MV_PAR06 == 2
   cStrSQL += "  AND RA4_PRESEN = '0' " + cCRLF  
endif     
cStrSQL += "  AND RA1.D_E_L_E_T_ = ' ' " + cCRLF  
cStrSQL += "  AND RA2.D_E_L_E_T_ = ' ' " + cCRLF  
cStrSQL += "  AND RA4.D_E_L_E_T_ = ' ' " + cCRLF  
cStrSQL += "  AND SRA.D_E_L_E_T_ = ' ' " + cCRLF  

cStrSQL += "ORDER BY NOME, TURMA, CALENDARIO, CURSO " + cCRLF  

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
   _cCabec  := PADR("DEPTO"           ,040," ")+_cDeli+""+;
               PADR("MATRICULA"       ,006," ")+_cDeli+""+;
               PADR("NOME"            ,040," ")+_cDeli+""+;
               PADR("CURSO"           ,035," ")+_cDeli+""+; 
               PADR("DISCIPLINA"      ,035," ")+_cDeli+""+; 
               PADR("CALENDARIO"      ,025," ")+_cDeli+""+;
               PADR("TURMA"           ,005," ")+_cDeli+""+;
               PADR("NOTA"            ,012," ")+_cDeli+""+;
               PADR("FEZ_TREINAMENTO" ,015," ")+_cDeli+""+;
               PADR("INICIAL"         ,012," ")+_cDeli+""+;
               PADR("FINAL"           ,012," ")+_cDeli+""+;
               PADR("PRESENCA"        ,008," ")+_cDeli+""+;   
               PADR("MOT_FALTA"       ,015," ")
               
   nCol1 := len(_cCabec) + 1  

   cBuffer :=  PADR( _cCabec ,nCol1,"") + cCRLF  
   FWrite(nHandle, cBuffer)

   while TRB->( !Eof() )
      lRet := .T.
      _cLinha := TRB->(PADL( DEPTO               ,040," ")+_cDeli+""+;
                       PADR( "'"+MATRICULA       ,006," ")+_cDeli+""+;
                       PADR( ALLTRIM(NOME)       ,040," ")+_cDeli+""+;
                       PADR( ALLTRIM(CURSO )     ,035," ")+_cDeli+""+;     
                       PADR( ALLTRIM(DISCIPLINA) ,035," ")+_cDeli+""+; 
                       PADR( ALLTRIM(CALENDARIO) ,025," ")+_cDeli+""+;
                       PADR( TURMA               ,005," ")+_cDeli+""+;                       
                       PADR( STR(NOTA,12,2)      ,012," ")+_cDeli+""+;
                       PADR( FEZ_TREINAMENTO     ,015," ")+_cDeli+""+;
                       PADR( INICIAL             ,012," ")+_cDeli+""+;
                       PADR( FINAL               ,012," ")+_cDeli+""+;  
                       PADL( STR(PRESENCA,6,2)   ,008," ")+_cDeli+""+;  
                       PADR( MOT_FALTA			 ,015," ") )
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
| Funcao   | ValidPerg | Autor | Otavio Pinto        | Data | 11/04/2014 |
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

AAdd(aRegs,{cPerg , "01" , "Data De                  ?" ,"","", "mv_ch1" , "D" , 08 , 0 ,0 , "G" , "" , "mv_par01" , ""     , "" , "" , ""  , "" , ""    , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , ""    , "" })
AAdd(aRegs,{cPerg , "02" , "Data Ate                 ?" ,"","", "mv_ch2" , "D" , 08 , 0 ,0 , "G" , "" , "mv_par02" , ""     , "" , "" , ""  , "" , ""    , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , ""    , "" })
AAdd(aRegs,{cPerg , "03" , "C.Custo De               ?" ,"","", "mv_ch3" , "C" , 09 , 0 ,0 , "G" , "" , "mv_par03" , ""     , "" , "" , ""  , "" , ""    , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "CTTBA"    , "" })
AAdd(aRegs,{cPerg , "04" , "C.Custo Ate              ?" ,"","", "mv_ch4" , "C" , 09 , 0 ,0 , "G" , "" , "mv_par04" , ""     , "" , "" , ""  , "" , ""    , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "CTTBA"    , "" })
Aadd(aRegs,{cPerg , "05" , "Realizado                ?" ,"","", "mv_ch5" , "N" , 01 , 0 ,0 , "C" , "" , "mv_par05" , "SIM"  , "" , "" , ""  , "" , "NAO" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , ""    , "" })
Aadd(aRegs,{cPerg , "06" , "Faltas	  			     ?" ,"","", "mv_ch6" , "N" , 01 , 0 ,0 , "C" , "" , "mv_par06" , "NÃO"  , "" , "" , ""  , "" , "SIM" , "" , "" , "" , "" , "AMBOS", "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , ""    , "" })

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


// Fim do CABR140.PRW
