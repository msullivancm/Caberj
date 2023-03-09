#include "PROTHEUS.CH"
#include "RWMAKE.CH"
#include "UTILIDADES.CH" 

/*------------------------------------------------------------------------
| Funcao    | MATSRA   | Otavio Pinto                  | Data | 16/03/15  |
|-------------------------------------------------------------------------|
| Descricao | Le alguns dados de colaboradores na Folha (SRA )Protheus.   |
|-------------------------------------------------------------------------|
| Uso       | Usuarios na SRA                                             |
|           |                                                             |
|-------------------------------------------------------------------------|
| ID        | Login                                                       |
|           |                                                             |
| 000891    | alexandre                                                   |
| 000340    | bianchini                                                   |
| 000304    | casemiro                                                    |
| 000791    | fabiosantos                                                 |
| 000395    | infra                                                       |
| 000525    | leonardo.portel                                             |
| 000786    | marco.bellio                                                |
| 000305    | motta                                                       |
| 000668    | otavio                                                      |
| 000064    | piumbim                                                     |
| 000843    | sergio.cunha                                                |
|           |                                                             |
|           |                                                             |
 ------------------------------------------------------------------------*/
user function MATSRA()
private cLibOpc   := GetNewPar("MV_YACCES2","000891,000340,000304,000791,000395,000525,000786,000305,000668,000064,000843")   
private cPerg     := "MATSRA"
private _cPath	  := "C:\TEMP\"
private _cArquivo := cPerg+".CSV"


begin sequence
if ( __cUserID $ AllTrim(cLibOpc) )              
   if MsgBox("Exporta alguns dados dos colaboradores na FOLHA (SRA) do Protheus"+Chr(13)+;
             "O arquivo "+upper(_cArquivo)+" estará disponível na pasta "+_cPath,;
             "Selecione",;
             "YESNO")
      ValidPerg()

      If ! Pergunte(cPerg,.T.) ; break ; EndIf    
             
      Processa({|| F_EXPORT() }) 
   endif
else
   msgstop("Voce não está habilitado a executar esta rotina..."+Chr(13)+Chr(13)+;
           "Procure sua chefia e peça para cadastrá-lo no parametro"+Chr(13)+;
           "MV_YACCES2 com o ID utilizado no Protheus."            )
endif   
endsequence        

return


/*------------------------------------------------------------------------
|  F_EXPORT()                                                             |
|  Faz leitura do arquivo SRA e monta uma lista com alguns dados          |
|  dos colaboradores cadastrados no Protheus.                             |
 ------------------------------------------------------------------------*/
static function F_EXPORT()
local cRet  := " "
local cQry  := " "

private cEol        := CHR(13)+CHR(10)
private cBuffer		:= ""
private nHandle    
private nQtdRg      := 1200
private lGerou      := .F.

FErase( _cPath+_cArquivo )

nHandle := FCreate( _cPath + _cArquivo)

begin sequence

    if nHandle == -1
        MsgStop("Erro na criacao do arquivo na estacao local. Contate o administrador do sistema")
        return
    EndIf

if  Select("TMP") > 0  ; ("TMP")->( dbCloseArea() ) ; endif      

cQry := " SELECT  "+cEol
cQry += "        RA_FILIAL "+cEol
cQry += "      , RA_MAT "+cEol
cQry += "      , RA_NOME "+cEol
cQry += "      , RA_CC "+cEol
cQry += "      , RA_SITFOLH "+cEol
cQry += "      , SUBSTR(RA_ADMISSA,7,2)||'/'||SUBSTR(RA_ADMISSA,5,2)||'/'||SUBSTR(RA_ADMISSA,1,4) RA_ADMISSA "+cEol
cQry += "      , SUBSTR(RA_DEMISSA,7,2)||'/'||SUBSTR(RA_DEMISSA,5,2)||'/'||SUBSTR(RA_DEMISSA,1,4) RA_DEMISSA "+cEol
cQry += "      , RA_CODFUNC "+cEol
cQry += "      , (SELECT RJ_DESC FROM "+RetSqlName("SRJ")+" RJ WHERE RJ_FILIAL = '  ' AND RJ_FUNCAO = RA.RA_CODFUNC AND RJ.D_E_L_E_T_ = ' ' ) RJ_DESC "+cEol
cQry += " FROM "+RetSqlName("SRA")+" RA "+cEol
cQry += " WHERE RA_FILIAL = '01' " +cEol

if MV_PAR01 <= MV_PAR02 .and. !Empty(MV_PAR02)
   cQry += "   AND RA_MAT    BETWEEN '"+MV_PAR01+"' AND '"+MV_PAR02+"' " +cEol
endif

if !Empty(MV_PAR03)
   cQry += "   AND ( RA_NOME   LIKE '"+UPPER(ALLTRIM(MV_PAR03))+"%'  OR   RA_NOME   LIKE '%"+UPPER(ALLTRIM(MV_PAR03))+"%' ) " +cEol
endif
   
cQry += "   AND RA.D_E_L_E_T_ = ' ' "+cEol

TCQuery cQry Alias "TMP" New
dbSelectArea("TMP")
TMP->( dbGoTop() )

    
    ProcRegua( TMP->( RecCount() ) )

    cLinha  := PADR("FILIAL"         ,006," ")+";"+;
               PADR("MATRIC"         ,007," ")+";"+;   
               PADR("NOME"           ,040," ")+";"+;                         
               PADR("CCUSTO"         ,010," ")+";"+;   
               PADR("SIT"            ,003," ")+";"+;   
               PADR("ADMISSA"        ,010," ")+";"+;                  
               PADR("DEMISSA"        ,010," ")+";"+;                                 
               PADR("FUNCAO"         ,006," ")+";"+;                                                
               PADR("DESCRICAO"      ,020," ")       
    FWrite(nHandle, cLinha) ; FWrite(nHandle, cEol)

    while TMP->( !Eof() )

        IncProc( "Lendo a Matricula... "+TMP->RA_MAT )
    
        lGerou      := .T.
         
        cLinha  := PADR("'"+TMP->RA_FILIAL ,007," ")+";"+;
                   PADR("'"+TMP->RA_MAT    ,007," ")+";"+;   
                   PADR(TMP->RA_NOME       ,040," ")+";"+;                         
                   PADR("'"+TMP->RA_CC     ,010," ")+";"+;                         
                   PADR(TMP->RA_SITFOLH    ,003," ")+";"+;                         
                   PADR(TMP->RA_ADMISSA    ,010," ")+";"+;                         
                   PADR(TMP->RA_DEMISSA    ,010," ")+";"+;                         
                   PADR("'"+TMP->RA_CODFUNC,006," ")+";"+;                         
                   PADR(TMP->RJ_DESC       ,020," ")
                             
        FWrite(nHandle, cLinha) ; FWrite(nHandle, cEol)
        TMP->( dbSkip() )
    end
    cFinal := "Fim "
    FWrite(nHandle, cFinal) 
    

end sequence
FClose(nHandle)

if lGerou
    zArq := _cPath+_cArquivo
    oExcelApp := MsExcel():New()
    oExcelApp:WorkBooks:Open( &("zArq") ) // Abre uma planilha
    oExcelApp:SetVisible(.T.)              
endif

return

/*-------------------------------------------------------------------------- 
| Funcao | ValidPerg     | Autor | Otavio Pinto          | Data | 16/03/2015|
|---------------------------------------------------------------------------|
| Descricao: Verifica a existencia das perguntas criando-as caso seja       |
|            necessario (caso nao existam).                                 |
 --------------------------------------------------------------------------*/
Static Function ValidPerg

_sAlias := Alias()
aRegs   := {}

dbSelectArea("SX1")
dbSetOrder(1)
cPerg := PadR(cPerg,Len(SX1->X1_GRUPO))

// Grupo/Ordem/Pergunta/PerEsp/PerIng/Variavel/Tipo/Tamanho/Decimal/Presel/GSC/Valid/Var01/Def01///Cnt01/Var02/Def02/Cnt02/Var03/Def03/Cnt03/Var04/Def04/Cnt04/Var05/Def05/Cnt05

AAdd(aRegs,{cPerg , "01" , "Matricula De               ?" ,"","", "mv_ch1" , "C" ,06  , 0 ,0 , "G" , "" , "mv_par01" , ""      , "" , "" , ""      , "" , ""           , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "SRA05" , "" })
AAdd(aRegs,{cPerg , "02" , "Matricula Ate              ?" ,"","", "mv_ch2" , "C" ,06  , 0 ,0 , "G" , "" , "mv_par02" , ""      , "" , "" , ""      , "" , ""           , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "SRA05" , "" })
AAdd(aRegs,{cPerg , "03" , "Nome                       ?" ,"","", "mv_ch3" , "C" ,40  , 0 ,0 , "G" , "" , "mv_par03" , ""      , "" , "" , ""      , "" , ""           , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , ""       , "" })

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



// Fim da rotina MATSRA.PRW

