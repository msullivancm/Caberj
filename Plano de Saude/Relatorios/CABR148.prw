/*************************************************************************************************************
* Programa....: CABR148    																				      *
* Tipo........: RELATORIO USUARIOS POR SUBCONTRATO                                                            *
* Autor.......: Otavio Pinto                                                                                  *
* Criaçao.....: 29/07/2014                                                                                    *
* Modificado..: Otavio Pinto                                                                                  *
* Alteração...:                                                                                               *	
* Solicitante.: Amanda Gonçalves (cadastro)                                                                   *
* Módulo......: PLS - Plano de Saude                                                                          *
* Chamada.....:                                                                                               *
* Objetivo....: Listar usuários por contrato/subcontrato.                                                     *
 *************************************************************************************************************/
#include "rwmake.ch"

user function CABR148()

local   aRegs     := {}
private cLIN      := ""
private cCRLF     := CHR(13)+CHR(10)
private nConta    := 0
private cPerg     := "CABR148"
private nLastKey  := 0   
private cCnt01    := GetMv("MV_CABINTE")

ValidPerg()

If ! Pergunte(cPerg,.T.) ; 	Return(Nil) ; EndIf    

Processa({ ||IMP_REL2()},"Gerando Arquivo ... ")

Return Nil

/*
  IMP_REL2  
  Rotina de impressao
*/

static function IMP_REL2()
local _lCabec       := .T.	
local cCabCSV       := ""

private _cDirDocs   := MsDocPath()
private _cPath		:= Alltrim(cCnt01)+if(right(AllTrim(cCnt01),1) <> "\","\","" )            // "C:\TEMP\"
private _cArquivo  	:= "CABR148.csv"    // Alterada a extensão de TXT para CSV 
private cBuffer		:= ""
private oAbrArq 
private nHandle    

FErase( _cPath+_cArquivo )
	
nHandle := FCreate(_cDirDocs + "\" + _cArquivo)
	
if nHandle == -1
	MsgStop("Erro na criacao do arquivo na estacao local. Contate o administrador do sistema")
	return
EndIf

/*
+--------------------------------------------------+
| PARAMETROS UTILIZADOS                            |
+--------------------------------------------------+
|  01  |  Operadora           | mv_par01           |
|  02  |  Empresa             | mv_par02           |
|  03  |  Contrato            | mv_par03           |
|  04  |  Sub-Contrato        | mv_par04           |
|  05  |  Matricula           | mv_par05           |
|  06  |  Data Inclusão       | mv_par06           |
|  07  |  Tipo de Impressao   | mv_par07           |
|  08  |  Status              | mv_par08           |
+--------------------------------------------------+
*/

////////////////////////////////////////////////////////////////////////INICIO DA QUERY//////////////////

cStrSQL := " SELECT BA1_CONEMP CONTRATO " + cCRLF  
cStrSQL += "      , BA1_SUBCON SUBCONTRATO " + cCRLF  
cStrSQL += "      , (SELECT BQC_DESCRI " + cCRLF  
cStrSQL += "         FROM "+RetSQLName("BQC") + " BQC " + cCRLF
cStrSQL += "         WHERE BQC.D_E_L_E_T_ = ' ' " + cCRLF  
cStrSQL += "           AND BQC_NUMCON = BA1_CONEMP " + cCRLF  
cStrSQL += "           AND BQC_VERCON = BA1_VERCON " + cCRLF  
cStrSQL += "           AND BQC_SUBCON = BA1_SUBCON " + cCRLF  
cStrSQL += "           AND BQC_VERSUB = BA1_VERSUB " + cCRLF  
cStrSQL += "           AND BQC_CODEMP = BA1_CODEMP " + cCRLF  
cStrSQL += "           AND BQC_CODINT = BA1_CODINT) DESCRICAO " + cCRLF  
cStrSQL += "      , BA1_CODINT||'.'||BA1_CODEMP||'.'||BA1_MATRIC||'.'||BA1_TIPREG||'-'||BA1_DIGITO MATRICULA " + cCRLF  
cStrSQL += "      , BA1_NOMUSR NOME " + cCRLF  
cStrSQL += " FROM "+RetSQLName("BA1") + " BA1 " + cCRLF

if !empty(mv_par01) ; cStrSQL += " WHERE BA1_CODINT  = '"+ mv_par01 +"' " + cCRLF  ; endif   
if !empty(mv_par02) ; cStrSQL += "   AND BA1_CODEMP  = '"+ mv_par02 +"' " + cCRLF  ; endif
if !empty(mv_par03) ; cStrSQL += "   AND BA1_CONEMP  = '"+ mv_par03 +"' " + cCRLF  ; endif
if !empty(mv_par04) ; cStrSQL += "   AND BA1_SUBCON  = '"+ mv_par04 +"' " + cCRLF  ; endif
if !empty(mv_par05) ; cStrSQL += "   AND BA1_MATRIC  = '"+ mv_par05 +"' " + cCRLF  ; endif

cStrSQL += "   AND BA1_DATINC <= '"+ Dtos(mv_par06) +"'" + cCRLF  
cStrSQL += "   AND BA1.D_E_L_E_T_ = ' ' " + cCRLF  

IF mv_par08 == 1
   cStrSQL += "   AND (BA1_DATBLO = '        ' OR BA1_DATBLO > '"+ Dtos(mv_par06) +"') -- ativos " + cCRLF      
ELSE
   cStrSQL += "   AND (BA1_DATBLO <> '        ' AND BA1_DATBLO <= '"+ Dtos(mv_par06) +"') -- bloqueados "+ cCRLF   
ENDIF

cStrSQL += " ORDER BY BA1_CONEMP, BA1_SUBCON, BA1_CODEMP, BA1_MATRIC, BA1_TIPREG " + cCRLF  

////////////////////////////////////////////////////////////////////////FINAL DA QUERY//////////////////

//*-----------------------------------------------------------------------*
//* Grava a query com o conteudo dos parametros.                          *
//*-----------------------------------------------------------------------*
MemoWrite(Alltrim(_cPath)+"CABR148.SQL", cStrSQL)
 
cStrSQL := ChangeQuery( cStrSQL )                            

//cEndereco := ALLTRIM(MV_PAR03)+IF( RIGHT(ALLTRIM(MV_PAR03),1) == '\' , "" ,"\"   )

If Select("TRB") > 0 ; dbSelectArea("TRB") ; TRB->( dbCloseArea() ) ; Endif

dbUseArea(.T., "TOPCONN", TcGenQry(,, cStrSQL), "TRB", .T., .F.)                        

lGerou := .F.
while TRB->( !Eof() )

    if _lCabec 
       lGerou := .T.
	   cCabCSV := PADR("CONTRATO"    ,LEN(TRB->( CONTRATO ))+1," ")+";"+;
	              PADR("SUBCONTRATO" ,012," ")+";"+;
				  PADR("DESCRICAO"   ,040," ")+";"+;
				  PADR("MATRICULA"   ,LEN(TRB->( MATRICULA ))+1," ")+";"+;
				  PADR("NOME"        ,050," ")   
		
       FWrite(nHandle, cCabCSV) ; FWrite(nHandle, cCRLF)       
	   
	   _lCabec := .F.
    Endif
	
	cBuffer :=  TRB->( PADR("'"+CONTRATO     ,LEN(TRB->( CONTRATO ))+1," ")+";"+;
	                   PADR("'"+SUBCONTRATO  ,012," ")+";"+;
			           PADR(DESCRICAO        ,040," ")+";"+;
                       PADR("'"+MATRICULA    ,LEN(TRB->( MATRICULA ))+1," ")+";"+;
                       PADR(NOME             ,050," ")  ) 

	nConta ++
    FWrite(nHandle, cBuffer)                                
    FWrite(nHandle, cCRLF)

 	TRB->( DbSkip() )               
	
ENDDO          

if lGerou
   FClose(nHandle) 

   CpyS2T(_cDirDocs + "\" + _cArquivo, _cPath, .T.)

   if mv_par07 == 1 
      //+---------------------------------------------------------------------+
      //| Gera em planilha                                                    |
      //+---------------------------------------------------------------------+  
              
      //msgstop(_cPath+_cArquivo)
      
      oExcelApp := MsExcel():New()
      oExcelApp:WorkBooks:Open( &( "_cPath+_cArquivo" ) ) // Abre uma planilha
      oExcelApp:SetVisible(.T.)              
   else
      //+---------------------------------------------------------------------+
      //| Gera dados no BBloco de Notas                                       |
      //+---------------------------------------------------------------------+    
      oAbrArq := WinExec("NOTEPAD.EXE "+_cPath+_cArquivo)  // Abre o arquivo Log na Tela do usuario
   endif   
                                                                   
   MsgAlert("Foram listado " + alltrim(str(nConta)) + " registros!!!")
else
   MsgAlert("Nao houve movimento para estes parametros. Verifique!!!")   
endif

If Select("TRB") > 0 ; dbSelectArea("TRB") ; TRB->( dbCloseArea() ) ; Endif

return

/*--------------------------------------------------------------------------*
* Funcao | ValidPerg     | Autor | Otavio Pinto          | Data | 31/01/2011*
*---------------------------------------------------------------------------*
* Descricao: Verifica a existencia das perguntas criando-as caso seja       *
*            necessario (caso nao existam).                                 *
*---------------------------------------------------------------------------*/
Static Function ValidPerg

Local i := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
Local j := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

_sAlias := Alias()
aRegs   := {}

dbSelectArea("SX1")
dbSetOrder(1)
cPerg := PadR(cPerg,Len(SX1->X1_GRUPO))

// Grupo/Ordem/Pergunta/PerEsp/PerIng/Variavel/Tipo/Tamanho/Decimal/Presel/GSC/Valid/Var01/Def01///Cnt01/Var02/Def02/Cnt02/Var03/Def03/Cnt03/Var04/Def04/Cnt04/Var05/Def05/Cnt05

/*
+--------------------------------------------------+
| PARAMETROS UTILIZADOS                            |
+--------------------------------------------------+
|  01  |  Operadora           | mv_par01           |
|  02  |  Empresa             | mv_par02           |
|  03  |  Contrato            | mv_par03           |
|  04  |  Sub-Contrato        | mv_par04           |
|  05  |  Matricula           | mv_par05           |
|  06  |  Data Inclusão       | mv_par06           |
|  07  |  Tipo de Impressao   | mv_par07           |
|  08  |  Status              | mv_par08           |
+--------------------------------------------------+
*/



AAdd(aRegs,{cPerg , "01" , "Operadora                ?" ,"","", "mv_ch1" , "C" , 4  , 0 ,0 , "G" , "" , "mv_par01" , ""      , "" , "" , ""      , "" , ""           , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , ""       , "" })
AAdd(aRegs,{cPerg , "02" , "Empresa                  ?" ,"","", "mv_ch2" , "C" , 4  , 0 ,0 , "G" , "" , "mv_par02" , ""      , "" , "" , ""      , "" , ""           , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "BJLPLS" , "" })
AAdd(aRegs,{cPerg , "03" , "Contrato                 ?" ,"","", "mv_ch3" , "C" , 12 , 0 ,0 , "G" , "" , "mv_par03" , ""      , "" , "" , ""      , "" , ""           , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "B7BPLS" , "" })
AAdd(aRegs,{cPerg , "04" , "Sub-Contrato             ?" ,"","", "mv_ch4" , "C" , 9  , 0 ,0 , "G" , "" , "mv_par04" , ""      , "" , "" , ""      , "" , ""           , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "BA6PLS" , "" })
AAdd(aRegs,{cPerg , "05" , "Matricula                ?" ,"","", "mv_ch5" , "C" , 17 , 0 ,0 , "G" , "" , "mv_par05" , ""      , "" , "" , ""      , "" , ""           , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "MATUSR" , "" })
Aadd(aRegs,{cPerg , "06" , "Data Inclusao            ?" ,"","", "mv_ch6" , "D" , 8  , 0 ,0 , "G" , "" , "mv_par06" , ""      , "" , "" , ""      , "" , ""           , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , ""      , "" })
Aadd(aRegs,{cPerg , "07" , "Tipo de Impressao        ?" ,"","", "mv_ch7" , "N" , 1  , 0 ,0 , "C" , "" , "mv_par07" , "Excel" , "" , "" , ""      , "" , "NotePad"    , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , ""      , "" })
Aadd(aRegs,{cPerg , "08" , "Status                   ?" ,"","", "mv_ch8" , "N" , 1  , 0 ,0 , "C" , "" , "mv_par08" , "Ativos", "" , "" , ""      , "" , "Bloqueados" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , ""      , "" })
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

/*--------------------------------------------------------------------------*
* Funcao | Parse         | Autor | Otavio Pinto          | Data | 31/01/2011*
*---------------------------------------------------------------------------*
*  Sintaxe....:  PARSE(<@Frase>,<cDelimitador>)                             *
*  Exemplo....:  Frase := 'Otavio|Manoel|Joao|Ana|Paula|Sonia'              *
*                WHIL LEN(Frase)>0                                          *
*                  Nomes := PARSE(@Frase,'|')                               *
*                  ?Nomes                                                   *
*                ENDDO                                                      *
*  Resultado..:                                                             *
*                Otavio                                                     *
*                Manoel                                                     *
*                Joao                                                       *
*                Ana                                                        *
*                Paula                                                      *
*                Sonia                                                      *
*---------------------------------------------------------------------------*/
static function Parse(cFrase, cDelimit)
local LocaVar1, LocaVar2
if (PCOUNT() < 2) ; cDelimit:= [,] ; endif
LocaVar2:= AT(cDelimit, cFrase)
if (LocaVar2 > 0)
   LocaVar1:= LEFT(cFrase, LocaVar2 - 1)
   cFrase  := substr(cFrase, LocaVar2 + len(cDelimit))
else
   LocaVar1:= cFrase
   cFrase  := ""
endif
return LocaVar1

/*--------------------------------------------------------------------------*
* Funcao | ParseHoriz    | Autor | Otavio Pinto          | Data | 31/01/2011*
*---------------------------------------------------------------------------*
* Descricao: Retorna a string na horizontal com aspas, separado por virgula.*
*            Exemplo de retorno: ('DUP','NF')                               *
*---------------------------------------------------------------------------*/
static function ParseHoriz()
private cCodigo := mv_par09
private _cTexto := "("
   cCodigo  := Alltrim( cCodigo )        
   while LEN(cCodigo)>0
      cTexto += ( "'"+PARSE(@cCodigo,',')+"'"+iif( LEN(cCodigo)>0,",","") )
   enddo                                   
   cTexto +=")"
return Alltrim(cTexto)



// Fim do CABR148.PRW
