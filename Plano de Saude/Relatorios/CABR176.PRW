#include "PROTHEUS.CH"
#include "RWMAKE.CH"
#include "UTILIDADES.CH" 

/*------------------------------------------------------------------------
| Funcao    | CABR176   | Otavio Pinto                  | Data | 16/03/15 |
|-------------------------------------------------------------------------|
| Descricao | Le alguns CADASTRO DE DADOS UNIFICADOS.                     |
|-------------------------------------------------------------------------|
| Uso       |                                                             |
|           |                                                             |
|-------------------------------------------------------------------------|
|           |                                                             |
|           |                                                             |
 ------------------------------------------------------------------------*/
user function CABR176()

private cPerg     := "CABR176"
private _cPath	  := "C:\TEMP\"
private _cArquivo := cPerg+".CSV"
private cLinha    := ""
private cDados    := ""

begin sequence
   if MsgBox("Exporta alguns informações do Cadastro de Dados Unificados."+Chr(13)+;
             "O arquivo "+upper(_cArquivo)+" estará disponível na pasta "+_cPath,;
             "Selecione",;
             "YESNO")
      ValidPerg()

      If ! Pergunte(cPerg,.T.) ; break ; EndIf    
             
      Processa({|| F_EXPORT() }) 
   endif
endsequence        

return


/*------------------------------------------------------------------------
|  F_EXPORT()                                                             |
|  Faz leitura do arquivo SZZ e monta uma lista com informações do        |
|  Cadastro de Dados Unificados.                                          |
 ------------------------------------------------------------------------*/
static function F_EXPORT()
local cRet  := " "
local cQry  := " "

private cEol        := CHR(13)+CHR(10)
private cBuffer		:= ""
private nHandle    
private lGerou      := .F.
private cAlias      := "TMP"

FErase( _cPath+_cArquivo )

nHandle := FCreate( _cPath + _cArquivo)

MV_PAR01 := if ( Empty(MV_PAR01), 3, MV_PAR01 )

begin sequence

    if nHandle == -1
        MsgStop("Erro na criacao do arquivo na estacao local. Contate o administrador do sistema")
        return
    EndIf

	if  Select(cAlias) > 0  ; (cAlias)->( dbCloseArea() ) ; endif      
	
	cQry := " SELECT  "+cEol
	cQry += "        '1' CONTA "+cEol
	cQry += "      , ZZ_SEQUEN "+cEol
	cQry += "      , ZZ_TIPALT "+cEol
	cQry += "      , ZZ_CODCLI "+cEol
	cQry += "      , ZZ_CODVID "+cEol
	cQry += "      , ZZ_NOME   "+cEol
	cQry += "      , ZZ_CEPUSR "+cEol
	cQry += "      , ZZ_ENDERE "+cEol
	cQry += "      , ZZ_NR_END "+cEol
	cQry += "      , ZZ_COMEND "+cEol
	cQry += "      , ZZ_BAIRRO "+cEol
	cQry += "      , ZZ_CODMUN "+cEol
	cQry += "      , ZZ_MUNICI "+cEol
	cQry += "      , ZZ_ESTADO "+cEol
	cQry += "      , ZZ_MAE    "+cEol
	cQry += "      , ZZ_CPFMAE "+cEol
	cQry += "      , SUBSTR(ZZ_DATMAE,7,2)||'/'||SUBSTR(ZZ_DATMAE,5,2)||'/'||SUBSTR(ZZ_DATMAE,1,4) ZZ_DATMAE "+cEol
	cQry += "      , ZZ_NOMPRE "+cEol
	cQry += "      , ZZ_CPFPRE "+cEol
	cQry += "      , ZZ_DDI    "+cEol
	cQry += "      , ZZ_DDD    "+cEol
	cQry += "      , ZZ_TELEFO "+cEol
	cQry += "      , ZZ_TELEX  "+cEol
	cQry += "      , ZZ_NROCEL "+cEol
	cQry += "      , ZZ_SEGTEL "+cEol
	cQry += "      , ZZ_FAX    "+cEol
	cQry += "      , ZZ_CONTAT "+cEol
	//cQry += "      , ZZ_TPPES  Tp_Pessoa  "+cEol
	cQry += "      , ZZ_CGC    "+cEol
	cQry += "      , ZZ_INSCR  "+cEol
  	cQry += "      , SUBSTR(ZZ_DTABNA,7,2)||'/'||SUBSTR(ZZ_DTABNA,5,2)||'/'||SUBSTR(ZZ_DTABNA,1,4) ZZ_DTABNA "+cEol
	cQry += "      , ZZ_EMAIL  "+cEol
	cQry += "      , ZZ_STATUS "+cEol
	cQry += "      , ZZ_USRCAD "+cEol
  	cQry += "      , SUBSTR(ZZ_DATCAD,7,2)||'/'||SUBSTR(ZZ_DATCAD,5,2)||'/'||SUBSTR(ZZ_DATCAD,1,4) ZZ_DATCAD "+cEol	
    cQry += "      , ZZ_HORCAD "+cEol
	cQry += "      , ZZ_USRCON "+cEol
  	cQry += "      , SUBSTR(ZZ_DATCON,7,2)||'/'||SUBSTR(ZZ_DATCON,5,2)||'/'||SUBSTR(ZZ_DATCON,1,4) ZZ_DATCON "+cEol	
	cQry += "      , ZZ_HORCON "+cEol
	
	cQry += " FROM "+RetSqlName("SZZ")+" ZZ "+cEol
	
	cQry += " WHERE ZZ_FILIAL = '  ' " +cEol
	
	if MV_PAR01 <> 3
	   cQry += "   AND ZZ_STATUS = '"+strzero(MV_PAR01,1)+"' "+cEol 
	endif   
    
    if MV_PAR02 <= MV_PAR03 .and. !Empty(MV_PAR03)
        do case
           case MV_PAR01 == 1
               cQry += "   AND ZZ_DATCAD BETWEEN '"+DTOS(MV_PAR02)+"' AND '"+DTOS(MV_PAR03)+"' "+cEol 
           case MV_PAR01 == 2
               cQry += "   AND ZZ_DATCON BETWEEN '"+DTOS(MV_PAR02)+"' AND '"+DTOS(MV_PAR03)+"' "+cEol        
           case MV_PAR01 == 3
               cQry += "   AND ( ( ZZ_DATCAD BETWEEN '"+DTOS(MV_PAR02)+"' AND '"+DTOS(MV_PAR03)+"')   "+cEol 
               cQry += "   OR    ( ZZ_DATCON BETWEEN '"+DTOS(MV_PAR02)+"' AND '"+DTOS(MV_PAR03)+"') ) "+cEol                    
        endcase
    endif
	
    cQry += "   AND ZZ.D_E_L_E_T_ = ' ' "+cEol
	
	cQry += " ORDER BY 1, 2 "+cEol
	
	Memowrit( _cPath+cPerg+".sql", cQry )
	
	TCQuery cQry Alias (cAlias) New
	dbSelectArea(cAlias)
	(cAlias)->( dbGoTop() )
	   
    ProcRegua( (cAlias)->( RecCount() ) )

    cLinha :=   PADR("Conta"       ,06 ," ")+";"+;	
                PADR("Sequencial"  ,10 ," ")+";"+;	
                PADR("Tipo"        ,01 ," ")+";"+;	
                PADR("Cliente"     ,06 ," ")+";"+;	
                PADR("Vida"        ,08 ," ")+";"+;	
                PADR("Nome"        ,50 ," ")+";"+;
                PADR("CEP"         ,08 ," ")+";"+;	
                PADR("Endereco"    ,40 ," ")+";"+;
                PADR("Numero"      ,06 ," ")+";"+;	
                PADR("Complemento" ,20 ," ")+";"+;
                PADR("Bairro"      ,30 ," ")+";"+;
                PADR("Cd_Muninipio",12 ," ")+";"+;	
                PADR("Municipio"   ,30 ," ")+";"+;
                PADR("Estado"      ,06 ," ")+";"+;	
                PADR("Mae"         ,120," ")+";"+;
                PADR("CPF_Mae"     ,11 ," ")+";"+;
                PADR("Dt_Nasc_Mae" ,12 ," ")+";"+;	
                PADR("Nm_Preposto" ,30 ," ")+";"+;
                PADR("CPF_Preposto",12 ," ")+";"+;
                PADR("DDI"         ,06 ," ")+";"+;	
                PADR("DDD"         ,03 ," ")+";"+;	
                PADR("Telefone"    ,15 ," ")+";"+;
                PADR("Telex"       ,10 ," ")+";"+;
                PADR("Celular"     ,15 ," ")+";"+;
                PADR("Telefone2"   ,15 ," ")+";"+;
                PADR("Fax"         ,15 ," ")+";"+;
                PADR("Contato"     ,15 ," ")+";"+;
                PADR("CNPJ_CPF"    ,14 ," ")+";"+;
                PADR("Ins_Estad"   ,18 ," ")+";"+;
                PADR("Dt_Aber-Nasc",10 ," ")+";"+;	
                PADR("E-Mail"      ,60 ," ")+";"+;
                PADR("Status"      ,10 ," ")+";"+;	
                PADR("Usr_Cadastro",15 ," ")+";"+;
                PADR("Dt_Cadastro" ,11 ," ")+";"+;	
                PADR("Hr_Cadastro" ,11 ," ")+";"+;	
                PADR("Usr_Confirm" ,15 ," ")+";"+;
                PADR("Dt_Confirm"  ,10 ," ")+";"+;
                PADR("Hr_Confirm"  ,10 ," ")    

//                PADR("Tp_Pessoa"   ,10 ," ")+";"+;	

            FWrite(nHandle, cLinha) ; FWrite(nHandle, cEol)

    while (cAlias)->( !Eof() )

        IncProc( "Lendo a Matricula... "+(cAlias)->ZZ_SEQUEN )
    
        lGerou      := .T.
         
        cDados :=   PADR((cAlias)->CONTA        ,06 ," ")+";"+;	
                    PADR((cAlias)->ZZ_SEQUEN 	,10 ," ")+";"+;	
                    PADR((cAlias)->ZZ_TIPALT 	,01 ," ")+";"+;	
                    PADR((cAlias)->ZZ_CODCLI 	,06 ," ")+";"+;	
                    PADR((cAlias)->ZZ_CODVID 	,08 ," ")+";"+;	
                    PADR((cAlias)->ZZ_NOME   	,50 ," ")+";"+;
                    PADR((cAlias)->ZZ_CEPUSR 	,08 ," ")+";"+;	
                    PADR((cAlias)->ZZ_ENDERE 	,40 ," ")+";"+;
                    PADR((cAlias)->ZZ_NR_END 	,06 ," ")+";"+;	
                    PADR((cAlias)->ZZ_COMEND 	,20 ," ")+";"+;
                    PADR((cAlias)->ZZ_BAIRRO 	,30 ," ")+";"+;
                    PADR((cAlias)->ZZ_CODMUN 	,12 ," ")+";"+;	
                    PADR((cAlias)->ZZ_MUNICI 	,30 ," ")+";"+;
                    PADR((cAlias)->ZZ_ESTADO 	,06 ," ")+";"+;	
                    PADR((cAlias)->ZZ_MAE    	,120," ")+";"+;
                    PADR((cAlias)->ZZ_CPFMAE 	,11 ," ")+";"+;
                    PADR((cAlias)->ZZ_DATMAE 	,12 ," ")+";"+;	
                    PADR((cAlias)->ZZ_NOMPRE 	,30 ," ")+";"+;
                    PADR((cAlias)->ZZ_CPFPRE 	,12 ," ")+";"+;
                    PADR((cAlias)->ZZ_DDI    	,06 ," ")+";"+;	
                    PADR((cAlias)->ZZ_DDD    	,03 ," ")+";"+;	
                    PADR((cAlias)->ZZ_TELEFO 	,15 ," ")+";"+;
                    PADR((cAlias)->ZZ_TELEX  	,10 ," ")+";"+;
                    PADR((cAlias)->ZZ_NROCEL 	,15 ," ")+";"+;
                    PADR((cAlias)->ZZ_SEGTEL 	,15 ," ")+";"+;
                    PADR((cAlias)->ZZ_FAX    	,15 ," ")+";"+;
                    PADR((cAlias)->ZZ_CONTAT 	,15 ," ")+";"+;
                    PADR((cAlias)->ZZ_CGC    	,14 ," ")+";"+;
                    PADR((cAlias)->ZZ_INSCR  	,18 ," ")+";"+;
                    PADR((cAlias)->ZZ_DTABNA 	,10 ," ")+";"+;	
                    PADR((cAlias)->ZZ_EMAIL  	,60 ," ")+";"+;
                    PADR((cAlias)->ZZ_STATUS 	,10 ," ")+";"+;	
                    PADR((cAlias)->ZZ_USRCAD 	,15 ," ")+";"+;
                    PADR((cAlias)->ZZ_DATCAD 	,11 ," ")+";"+;	
                    PADR((cAlias)->ZZ_HORCAD 	,11 ," ")+";"+;	
                    PADR((cAlias)->ZZ_USRCON 	,15 ," ")+";"+;
                    PADR((cAlias)->ZZ_DATCON     ,10 ," ")+";"+;
                    PADR((cAlias)->ZZ_HORCON     ,10 ," ")                             

//                    PADR((cAlias)->ZZ_TPPES  	,10 ," ")+";"+;	

        FWrite(nHandle, cDados) ; FWrite(nHandle, cEol)
        (cAlias)->( dbSkip() )
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

AAdd(aRegs,{cPerg , "01" , "Status               ?" ,"","", "mv_ch1" , "C" ,01  , 0 ,0 , "C" , "" , "mv_par01" , "Cadastrado" , "" , "" , "" , "" , "Confirmado" , "" , "" , "" , "" , "Ambos"         , "" , "" , "" , "" , ""             , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" })
AAdd(aRegs,{cPerg , "02" , "Data Inicial         ?" ,"","", "mv_ch2" , "D" ,08  , 0 ,0 , "G" , "" , "mv_par02" , ""           , "" , "" , "" , "" , ""           , "" , "" , "" , "" , ""              , "" , "" , "" , "" , ""             , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" })
AAdd(aRegs,{cPerg , "03" , "Data Final           ?" ,"","", "mv_ch3" , "D" ,08  , 0 ,0 , "G" , "" , "mv_par03" , ""           , "" , "" , "" , "" , ""           , "" , "" , "" , "" , ""              , "" , "" , "" , "" , ""             , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" })
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




// Fim da rotina CABR176.PRW

