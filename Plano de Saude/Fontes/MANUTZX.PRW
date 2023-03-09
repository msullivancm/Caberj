#INCLUDE "rwmake.ch"

/*/
+-------------------------------------------------------------------------+
|  Programa  |MANUTZX    | Autor | Otavio Pinto      | Data |  13/11/2014 |  
+-------------------------------------------------------------------------+
|            |                                                            |  
|  Objetivo  | Grava a data e hora de encerramento do PA.                 |
|            | Utiliza a tabela PBL010 para pegar o tempo maximo de       |
|            | atendimento para cada tipo de servico e somar com a data   |  
|            | inicial para gravar na data final, encerrando o PA.        |  
|            |                                                            |  
|            | ========================================================== |  
|            |                                                            |  
|            |                                                            |  
|            |                                                            |  
|            |                                                            |  
+-------------------------------------------------------------------------+
/*/

user function MANUTZX
private cPerg   := "MANUTZX"
private cLibera := GetNewPar("MV_YFECHPA","000024,000064,000668,000674,000786")
/*
  000024 Piumbim
  000064 Carlos
  000668 Otavio
  000674 Cristiane
  000786 Bellio
*/
   
begin sequence
    if MsgBox("Rotina de Manutencao"+Chr(13)+"Encerra PAs abertos - Tabela SZX - Protocolo de Atendimentos",;
              "Selecione",;
              "YESNO")             
       Processa( {|| RunProc() })
    endif
end sequence

return

/*
  RunProc()

  13.11.2014 - Otavio Pinto
*/
static function RunProc
FProcesso()
return

/*
  FProcesso()
  Rotina de Encerramento de PAs.
  13.11.2014 - Otavio Pinto
*/
static function FProcesso()
local cTimeINI := Time()
private cStrSQL := ""

dbSelectArea("PBL") ; dbSetOrder(1)
dbSelectArea("SZY") ; dbSetOrder(1)
dbSelectArea("SZX") ; dbSetOrder(1)

/*
+-----------------------------------------------+
| PARAMETROS UTILIZADOS                         |
+-----------------------------------------------+
|  01 |  Filial De ?                |  mv_par01 |  
|  02 |  Filial Ate ?               |  mv_par02 |  
|  03 |  Nº PA De ?                 |  mv_par03 |  
|  04 |  Nº PA Ate ?                |  mv_par04 |  
|  05 |  Centro de Custo ?          |  mv_par05 |  
+-----------------------------------------------+
*/

begin sequence

    if !( __cUserID $ AllTrim(cLibera) )
       MsgAlert("Acesso permitido somente aos usuarios habilitados a executar esta rotina!"+CHR(13)+CHR(13)+; 
                "SOLUCAO: Incluir ID do usuario no parametro MV_YFECHPA."+CHR(13)+CHR(13)+;
                "Verifique com sua gerencia.", "AVISO" )
       break
    endif

    ValidPerg()
    If ! Pergunte(cPerg,.T.) ; Break ; EndIf    
    nLim := 0

    ////////////////////////////////////////////////////////////////////////INICIO DA QUERY//////////////////    
    cStrSQL += " SELECT ZX_FILIAL " 
    cStrSQL += "      , ZX_SEQ " 
    cStrSQL += "      , ZX_DATDE " 
    cStrSQL += "      , ZX_HORADE " 
    cStrSQL += "      , ZX_DATATE " 
    cStrSQL += "      , ZX_HORATE " 
    cStrSQL += "      , ZX_TPINTEL " 
    cStrSQL += "      , ZX_YCUSTO " 
    cStrSQL += "      , ZX_TPDEM " 
    cStrSQL += "      , ZX_VATEND " 
    cStrSQL += " FROM "+RetSQLName("SZX") 
    cStrSQL += " WHERE D_E_L_E_T_ = ' ' " 
    cStrSQL += "   AND ZX_FILIAL BETWEEN '"+mv_par01+"' AND '"+mv_par02+"' " 
    cStrSQL += "   AND ZX_SEQ    BETWEEN '"+mv_par03+"' AND '"+mv_par04+"' " 
    if !Empty(mv_par05)
       cStrSQL += "   AND ZX_YCUSTO = '"+mv_par05+"' " 
    endif   
    cStrSQL += "   AND ZX_TPINTEL = '1' " 
    cStrSQL += " ORDER BY ZX_FILIAL,ZX_SEQ,ZX_YCUSTO " 
    ////////////////////////////////////////////////////////////////////////FINAL DA QUERY//////////////////
    
    cStrSQL := ChangeQuery( cStrSQL )                            
    If Select("TRB") > 0 ; dbSelectArea("TRB") ; TRB->( dbCloseArea() ) ; Endif
    dbUseArea(.T., "TOPCONN", TcGenQry(,, cStrSQL), "TRB", .T., .F.)                        
   
    ProcRegua( TRB->( RecCount() ) )
    TRB->( dbGotop() )
   
    do while TRB->( !Eof() )
       IncProc( "PA : "+TRB->ZX_SEQ )       
       if SZX->( dbSeek(TRB->(ZX_FILIAL+ZX_SEQ) )  )        
          if SZY->( dbSeek(xFilial("SZY")+SZX->ZX_SEQ) )   
             nZY_SEQ := SZY->ZY_SEQBA
             do while SZY->( nZY_SEQ == ZY_SEQBA .AND. !Eof() )           
                if PBL->( dbSeek(xFilial("PBL")+SZY->ZY_TIPOSV+AllTrim(SZX->ZX_YAGENC)) )             
                   nLim += VAL(PBL->PBL_YMETDA)
                else   
                   /*Esta condição é para os casos em que não encontre o tipo de serviço (casos muito antigos) */
                   nLim += 1
                endIf
                SZY->( dbSkip() )
             enddo
                
             RecLock("SZX",.F.)   
              
             SZX->ZX_DATATE  := SZX->ZX_DATDE + nLim
             SZX->ZX_HORATE  := SZX->ZX_HORADE
             SZX->ZX_TPINTEL := "2"
             
             /*Estes IFs são para preencher os campos vazios (casos anteriores à 01/04/2014) */
             if  Empty(SZX->ZX_TPDEM ) ; SZX->ZX_TPDEM  := "N" ; endif
             if  Empty(SZX->ZX_VATEND) ; SZX->ZX_VATEND := "3" ; endif
       
             SZX->( MsUnlock() )
             
             nLim := 0
          else
             MsgAlert("PA "+SZX->ZX_SEQ+" nao possui item de serviço... Verificar !", "A V I S O")   
          endif   
       endif
       
       TRB->( dbSkip() )
    enddo
    MsgAlert( "Iniciado  em : " + cTimeINI + chr(13) + "Terminado em : " + Time() )
    
end sequence
If Select("TRB") > 0 ; dbSelectArea("TRB") ; TRB->( dbCloseArea() ) ; Endif
return

/*--------------------------------------------------------------------------*
* Funcao | ValidPerg     | Autor | Otavio Pinto          | Data | 31/01/2011*
*---------------------------------------------------------------------------*
* Descricao: Verifica a existencia das perguntas criando-as caso seja       *
*            necessario (caso nao existam).                                 *
*---------------------------------------------------------------------------*/
Static Function ValidPerg

_sAlias := Alias()
aRegs   := {}

dbSelectArea("SX1")
dbSetOrder(1)
cPerg := PadR(cPerg,Len(SX1->X1_GRUPO))

// Grupo/Ordem/Pergunta/PerEsp/PerIng/Variavel/Tipo/Tamanho/Decimal/Presel/GSC/Valid/Var01/Def01///Cnt01/Var02/Def02/Cnt02/Var03/Def03/Cnt03/Var04/Def04/Cnt04/Var05/Def05/Cnt05
/*
+-----------------------------------------------+
| PARAMETROS UTILIZADOS                         |
+-----------------------------------------------+
|  01 |  Filial De ?                  |  mv_ch1 |  
|  02 |  Filial Ate ?                 |  mv_ch2 |  
|  03 |  Nº PA De ?                   |  mv_ch3 |  
|  04 |  Nº PA Ate ?                  |  mv_ch4 |  
|  05 |  Centro de Custo ?            |  mv_ch5 |  
+-----------------------------------------------+
*/

aadd(aRegs,{cPerg,"01","Filial De ?                 ","","","mv_ch1","C", 2,0,0,"G",""                ,"mv_par01",""   ,"","","","",""   ,"","","","",""     ,"","","","","","","","","","","","","","SM0",""})
aadd(aRegs,{cPerg,"02","Filial Ate ?                ","","","mv_ch2","C", 2,0,0,"G",""                ,"mv_par02",""   ,"","","","",""   ,"","","","",""     ,"","","","","","","","","","","","","","SM0",""})
aadd(aRegs,{cPerg,"03","Nº PA De ?                  ","","","mv_ch3","C", 6,0,0,"G",""                ,"mv_par03",""   ,"","","","",""   ,"","","","",""     ,"","","","","","","","","","","","","","",""})
aadd(aRegs,{cPerg,"04","Nº PA Ate ?                 ","","","mv_ch4","C", 6,0,0,"G","naovazio() .and. mv_par04 >= mv_par03","mv_par04",""   ,"","","","",""   ,"","","","",""     ,"","","","","","","","","","","","","","",""})
aadd(aRegs,{cPerg,"05","Centro de Custo ?           ","","","mv_ch5","C", 9,0,0,"G",""                ,"mv_par05",""   ,"","","","",""   ,"","","","",""     ,"","","","","","","","","","","","","","CTTBA",""})

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



// FIM DO MANUTZX.PRW

