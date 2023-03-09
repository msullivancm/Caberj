#INCLUDE "RWMAKE.CH"
#include "PLSMGER.CH"
#include "TOPCONN.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PLS260AGR ºAutor  ³ Frederico O. C. jr º Data ³  14/06/22   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Ponto de Entrada a ser executado antes da gravacao da      º±±
±±º          ³  familia/usuario.                                          º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±º          ³   PE acionado antes da gravacao da BA1 e BA3 na familia/   º±±
±±º          ³   usuario para passar dados ao outro PE PLS260DGR (apos a  º±±
±±º          ³   gravacao).                                               º±±
±±º          ³   Novos beneficiários (inclusão ou alteração incluindo     º±±
±±º          ³   dependente) terão suas carências (re)calculadas.         º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function PLS260AGR

Local aArea       := GetArea()
Local aAreaBA1    := BA1->(GetArea())
Local aRet        := {}

Local nPosTpR     := aScan(oBrwUsr:aHeader, {|x| AllTrim(Upper(x[2])) == 'BA1_TIPREG'})
Local nPosDig     := aScan(oBrwUsr:aHeader, {|x| AllTrim(Upper(x[2])) == 'BA1_DIGITO'})
Local cMatUsu     := ""
Local nNumBene    := len(oBrwUsr:aCols)                  // Quantidade de benef. na família
Local nPosDel     := len(oBrwUsr:aHeader) + 1            // Posição se registro está ativo/deletado
Local aInclus     := {}                                  // Benef. que estão sendo inseridos
Local aAlterac    := {}
Local i           := 0
Local lInclusao   := AllTrim(M->BA3_MATRIC) == 'AUTO'    // Se é inclusão ou alteração

// Verifica se a Grupo de Cobrança é igual 0001 que indica como sendo usuários RIOPREV ou nao esta preenchido
if val(M->BA3_GRPCOB) == 1 .or. Empty(M->BA3_GRPCOB)

   // Verifica se a matricula na empresa do usuaro esta vazia no BA3 e no BA1 para cada usuario cadastrado
   if Empty(M->BA3_MATEMP)

      // Preenche o campo BA3_MATEMP com 999999 para evitar rejeicao na geracao do arquivo de envio ao Itau
      M->BA3_MATEMP := '999999'
      MsgAlert("Atenção! Para beneficiários da RIOPREV é necessário informar a matricula funcional no campo Matric. Empr. da aba Dados Cadastrais da família.","Atenção")
   
   endif

endif

if !lInclusao

   // Pegar beneficiários que estão sendo incluídos nesta interação
   for i := 1 to nNumBene

      if !oBrwUsr:aCols[i][nPosDel]    // Se linha está habilitada

         cMatUsu  := M->(BA3_CODINT + BA3_CODEMP + BA3_MATRIC) + AllTrim(oBrwUsr:aCols[i][nPosTpR]) + AllTrim(oBrwUsr:aCols[i][nPosDig])

         if len(cMatUsu) >= 16

            BA1->(DbSetOrder(2))    // BA1_FILIAL + BA1_CODINT + BA1_CODEMP + BA1_MATRIC + BA1_TIPREG + BA1_DIGITO
            if !BA1->(DbSeek(xFilial('BA1') + cMatUsu))
            
               // Se não existe na BA1 - Nova inclusão - Salvo a matricula do usuário
               aAdd(aInclus, cMatUsu)
            
            else

               // Se já existe BA1 - armazenar data de inclusão / carência / tipo de carência (para confrontar após a gravação)
               aAdd(aAlterac, {cMatUsu, {BA1->BA1_DATINC, BA1->BA1_DATCAR, BA1->BA1_XTPCAR} })
            
            endif
         
         endif
      
      endif

   next

endif

aRet  := {lInclusao, aInclus, aAlterac}

RestArea(aArea)
RestArea(aAreaBA1)

return aRet
