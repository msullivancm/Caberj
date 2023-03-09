//Data      : 16/02/09
//Analista  : Luiz Alves Felizardo (Korus Consultoria)
//Descrição : Programa que atribui o último salário da 
//            tabela de Alteração Salarial (SR3) para
//            ficha do funcionário (SRA).
#include "rwmake.ch"

***********************
User Function CABA087()
***********************

   If !MsgYesNo("Deseja sincroniza as fichas de funcionários(SRA) com as Alterações Saláriais(SR3)?")
      Return(.F.)
   EndIF

   Processa({|| CABA087RUN()}, "Sincroniza Fichas(SRA)/Alterações Saláriais(SR3)")

Return(.T.)

****************************
Static Function CABA087RUN()
****************************

   Private nLastKey := 0
   Private cArq     := GetSrvProfString("Startpath", "") + "CABA087.dbf"
   
   If !File(cArq)
      MsgStop("Não foi possível localizar o arquivo CABA087.dbf !!!", "Atenção")
      Return(.F.)
   EndIf   

   DBUseArea(.T., "DBFCDXADS", cArq, "TRB", .F., .F.)
   TRB->(DBSetIndex(Left(cArq, Len(cArq)-3)+"cdx"))
   
   TRB->(DBSetOrder(1))

   SRA->(DBSetOrder(1))
   SRA->(DBGoTop())
   
   SR3->(DBSetOrder(1))
   SR3->(DBGoTop())
   
   SR7->(DBSetOrder(2)) //R7_FILIAL+R7_MAT+DTOS(R7_DATA)+R7_SEQ+R7_TIPO
   SR7->(DBGoTop())   
   
   ProcRegua(SRA->(RecCount()))
   
   Begin Transaction
         While !SRA->(Eof())
               IncProc(SRA->("Filial: " + RA_FILIAL + " Matrícula: " + RA_MAT))
            
               If nLastKey == 27
                  MsgStop("Operação cancelada pelo usuário !!!", "Atenção")
                  DisarmTransaction()
                  Return(.F.)
               EndIf
   
               nSalario := SRA->RA_SALARIO
               
               If Empty(SRA->RA_DEMISSA)
                  If TRB->(DBSeek(NToC(Val(SRA->RA_CODFUNC), 10)))
                     nSalario := TRB->VLRSAL
                  
                     SR3->(RecLock("SR3", .T.))
                     SR3->R3_FILIAL  := SRA->RA_FILIAL
                     SR3->R3_MAT     := SRA->RA_MAT
                     SR3->R3_DATA    := DDataBase
                     SR3->R3_PD      := "000"
                     SR3->R3_TIPO    := "004"
                     SR3->R3_DESCPD  := "SALARIO BASE"
                     SR3->R3_SEQ     := "1"
                     SR3->R3_ANTEAUM := 0
                     SR3->R3_VALOR   := TRB->VLRSAL
                     SR3->(MsUnLock())
            
                     SR7->(RecLock("SR7", .T.))
                     SR7->R7_FILIAL  := SRA->RA_FILIAL
                     SR7->R7_MAT     := SRA->RA_MAT
                     SR7->R7_DATA    := DDataBase
                     SR7->R7_TIPO    := "004"
                     SR7->R7_FUNCAO  := SRA->RA_CODFUNC
                     SR7->R7_DESCFUN := Posicione("SRJ", 1, xFilial("SRJ")+SRA->RA_CODFUNC, "RJ_DESC")
                     SR7->R7_TIPOPGT := "M"
                     SR7->R7_CATFUNC := SRA->RA_CATEG
                     SR7->R7_USUARIO := "DISSIDI2"
                     SR7->R7_SEQ     := "1"
                     SR7->R7_CARGO   := SRA->RA_CARGO
                     SR7->R7_DESCCAR := Posicione("SQ3", 1, xFilial("SQ3")+SRA->RA_CARGO, "Q3_DESCSUM")
                     SR7->(MsUnLock())                  
                  Else
                     MsgAlert(SRA->RA_CODFUNC, "Função não cadastrada na tabela auxiliar!!!")
                  EndIf
               Else
                  If SR3->(DBSeek(SRA->(RA_FILIAL+RA_MAT)))
                     While !SR3->(Eof()) .And. SR3->(R3_FILIAL+R3_MAT) == SRA->(RA_FILIAL+RA_MAT)
                           nSalario := SR3->R3_VALOR
                           SR3->(DBSkip())
                     End
                  EndIf
               EndIf
         
               SRA->(RecLock("SRA", .F.))
               SRA->RA_SALARIO := nSalario
               SRA->(MsUnLock())
         
               SRA->(DBSkip())
         End
   End Transaction
   
   TRB->(DBCloseArea())

Return(.T.)