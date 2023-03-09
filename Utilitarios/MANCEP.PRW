#INCLUDE "rwmake.ch"

/*/
+-------------------------------------------------------------------------+
|  Programa  |MANCEP    | Autor | Otavio Pinto       | Data |  10/09/2012 |  
+-------------------------------------------------------------------------+
|            |                                                            |  
|  Objetivo  | Atualizar a tabela de CEPs (BC9010)                        |
|            | Esta tabela e compartilhada                                |
|            |                                                            |  
|            | ========================================================== |  
|            | Arquivo temporario: BC9TMP.DBF                             |  
|            |                                                            |  
|            | Deve ser colocado na pasta \PROTHEUS_DATA\SYSTEM           |  
|            |                                                            |  
+-------------------------------------------------------------------------+
/*/

user function MANCEP
if MsgBox("Rotina de Manutencao"+Chr(13)+"Atualiza a tabela BC9 - CEPs",;
          "Selecione",;
          "YESNO")
   Processa( {|| RunProc() })
endif
return

/*
  RunProc()

  10.09.2012 - Otavio Pinto
*/
static function RunProc
FProcesso()
return

/*
  FProcesso()
  Rotina de Alteracao dos campos do arquivo de CEP.
  10.09.2012 - Otavio Pinto
*/
static function FProcesso()
local cTimeINI := Time()
dbSelectArea("BC9") ; dbSetOrder(1)

dbUseArea(.T.,,"BC9TMP","BC9TMP",.F.,.F.)
dbSelectArea("BC9TMP")

begin sequence

    // Busca dados importando para o arquivo BC9TMP.DBF
    ProcRegua( BC9TMP->( RecCount() ) )
    BC9TMP->( dbGotop() )

    if BC9TMP->( Eof() )
       MsgStop("O arquivo BC9TMP esta vazio... Verifique")
       break
    endif

    // Varre o TMP ate o final do arquivo
    do while BC9TMP->( !Eof() )
       IncProc( BC9TMP->(BC9_CEP+" / "+BC9_EST) )
       
       if RecLock("BC9",BC9->( !dbSeek(xFilial("BC9")+BC9TMP->BC9_CEP) ))   
          BC9->BC9_FILIAL   := BC9TMP->BC9_FILIAL
          BC9->BC9_CEP      := BC9TMP->BC9_CEP
          BC9->BC9_END      := BC9TMP->BC9_END
          BC9->BC9_CODMUN   := BC9TMP->BC9_CODMUN
          BC9->BC9_BAIRRO   := BC9TMP->BC9_BAIRRO
          BC9->BC9_MUN      := BC9TMP->BC9_MUN
          BC9->BC9_EST      := BC9TMP->BC9_EST
          BC9->BC9_YCOMP    := BC9TMP->BC9_YCOMP
          BC9->BC9_TIPLOG   := BC9TMP->BC9_TIPLOG
          BC9->BC9_YREGIA   := BC9TMP->BC9_YREGIA
          BC9->( MsUnLock() )
       endIf

       BC9TMP->( dbSkip() )

    enddo
    MsgStop( "Iniciado  em : " + cTimeINI + chr(13) + "Terminado em : " + Time() )
    
end sequence

if select("BC9TMP") > 0 ; BC9TMP->( dbCloseArea() ) ; endif

return

// FIM DO MANCEP.PRW

