#Include "PROTHEUS.CH"
#Include "UTILIDADES.CH"
#INCLUDE "rwmake.ch"

/*------------------------------------------------------------------------
| Funcao    | CABA568  | Otavio Pinto                  | Data | 26/12/14  |
|-------------------------------------------------------------------------|
| Descricao | MBrowse para a tabela ZRE (Baixa estoque farmacia)          |
|-------------------------------------------------------------------------|
| Uso       |                                                             |
|           |                                                             |
|-------------------------------------------------------------------------|
| Alterado  | Rel.4.1                                  | Data   29/12/14  |
|           |     4.11                                 |        05/01/15  |
|           |     4.12                                 |        07/01/15  |
|           |     4.13                                 |        09/01/15  | 
|           |     4.14 CP=ZRESB2/ZRESD3                |        13/01/15  |
|           |     4.15 aCores / u_fStatus              |        14/01/15  |
|           |     4.16 u_fSaldo (nova funcao)          |        16/01/15  |
|           |     4.17 Inicial. cpos DTLIB/DTVAL       |        19/01/15  | 
|           |          Relatorio u_ZRImpri             |           "      |
|           |     4.18 Implement.Filtro rel.acimaOSP   |        21/01/15  | 
|           |     5.06 Ajustes das rotinas de valida   |                  |
|           |          çao estoque e gravaçao.         |        09/03/15  | 
|           |          Campos na ZRE so visualizar     |        09/03/15  | 
|           |          Acerto na exclusao de registro  |        09/03/15  | 
 ------------------------------------------------------------------------*/
user function CABA568()
local aIndex       := {}
local cFiltro      := "( ( u_fCodAge( ZRD_CODATE ) == u_RetInfUsr( cUserName, 5 ) .AND. u_RetInfUsr( cUserName, 6 ) == '01' ) .or. u_RetInfUsr( cUserName, 5 ) == '01' ) .AND. u_RetInfUsr( cUserName, 7 ) <> 'S'" //Expressao do Filtro

private cEol       := CHR(13)+CHR(10)
private aRotina    := {}
private cCadastro  := "Baixa Estoque Farmácia"
private cAlias1    := "ZRD"     // Alias da Enchoice.
private cAlias2    := "ZRE"     // Alias da GetDados.  
private cLibOpc    := GetNewPar("MV_YESTFAR","000668")   

private aCdCores   := { { 'BR_VERDE'      ,'Não Baixado'    },;
                        { 'BR_VERMELHO'   ,'Baixado'        },;
                        { 'BR_AZUL'       ,'Sem Movimento'  } }
private aCores     := { { ' u_fStatus( ZRD_CODATE, ZRD_CODPRO ) .and. u_fMovim( ZRD_CODATE, ZRD_CODPRO )',aCdCores[1,1] },;
                        { '!u_fStatus( ZRD_CODATE, ZRD_CODPRO ) .and. u_fMovim( ZRD_CODATE, ZRD_CODPRO )',aCdCores[2,1] },;
                        { '!u_fMovim( ZRD_CODATE, ZRD_CODPRO )  ',aCdCores[3,1] } }

private bFiltraBrw := { || FilBrowse( cAlias1 , @aIndex , @cFiltro ) } //Determina a Expressao do Filtro

private cCadastro  := "Estoque Farmacia" //Exemplo de Filtro da mBrowse usando FilBrowse

Eval( bFiltraBrw )                       //Efetiva o Filtro antes da Chamada a mBrowse
                         
aAdd(aRotina, {"Pesquisar" , "AxPesqui" , 0, 1})
aAdd(aRotina, {"Visualizar", "u_DEManut", 0, 2})
aAdd(aRotina, {"Alterar"   , "u_DEManut", 0, 3})
aAdd(aRotina, {"Baixar"    , "u_BaixaB2", 0, 4})

/*-------------------------------------------------------------------------------------------------------
| Com permissão, o usuário poderá executar a opção de ESTORNO na tabela de saldos (SB2).                 |
| Ver parametro GetNewPar("MV_YESTFAR","000668")                                                         |
| Para iserir novos usuários, criar o parametro na tabela SX6 e inserir os IDs dos usuarios no Protheus. |
 -------------------------------------------------------------------------------------------------------*/
if ( __cUserID $ AllTrim(cLibOpc) )              
   aAdd(aRotina, {"Excluir"   , "u_DEManut", 0, 5}) 
   aAdd(aRotina, {"Estorno"   , "u_EstorB2", 0, 6})
endif   

aAdd(aRotina, {"Legenda"   , "u_ZRLegen", 0, 7})  
aAdd(aRotina, {"Imprime"   , "u_ZRImpri", 0, 8})  


dbSelectArea(cAlias1) ; (cAlias1)->( dbSetOrder(1)  )
(cAlias1)->( dbGoTop() )

(cAlias1)->( mBrowse(,,,,cAlias1, , , , , Nil    , aCores)  )

EndFilBrw( cAlias1 , @aIndex ) //Finaliza o Filtro

return Nil


/*------------------------------------------------------------------------
| Funcao    | DEManut  | Otavio Pinto                  | Data | 26/12/14  |
|-------------------------------------------------------------------------|
| Descricao | Rotina de manutençaõ na tabela ZRE                          |
|           |                                                             |
 ------------------------------------------------------------------------*/
user function DEManut(cAlias, nRecno, nOpc)

local i        := 0
local cLinOK   := "AllwaysTrue"
local cTudoOK  := "u_DETudOK"
local nOpcE    := nOpc
local nOpcG    := nOpc
local cFieldOK := "AllwaysTrue"
local lVirtual := .T.
local nLinhas  := 99
local nFreeze  := 0
local lRet     := .T. 
local nSizeHd  := 190 // Altura da area para os campos de header

private aCols        := {}
private aHeader      := {}
private aCpoEnchoice := {}
private aAltEnchoice := {}
private aAlt         := {}

/*-------------------------------------------------------------------------------------------------------
|  Cria variaveis de memoria dos campos da tabela Pai.                                                   |
|  1o. parametro: Alias do arquivo --> é case-sensitive, ou seja precisa ser como está no Dic.Dados.     |
|  2o. parametro: .T.              --> cria variaveis em branco, preenchendo com o inicializador-padrao. |
|                 .F.              --> preenche com o conteudo dos campos.                               |
 -------------------------------------------------------------------------------------------------------*/
RegToMemory(cAlias1, .F.)
/*-------------------------------------------------------------------------------------------------------
| Cria variaveis de memoria dos campos da tabela Filho.                                                  |
 -------------------------------------------------------------------------------------------------------*/
RegToMemory(cAlias2, .f.,.f.,(nOpc==3) )

CriaHeader(nOpc)
CriaCols(nOpc)
/*
//----------------------------Bloco de código usado para teste

msgstop(  "ID........: "+u_RetInfUsr( cUserName, 1 )+chr(13)+;
          "Login.....: "+u_RetInfUsr( cUserName, 2 )+chr(13)+;
          "CC........: "+u_RetInfUsr( cUserName, 3 )+chr(13)+;
          "Descricao.: "+u_RetInfUsr( cUserName, 4 )+chr(13)+;
          "Armazem...: "+u_RetInfUsr( cUserName, 5 )+chr(13)+;
          "Tipo Reg..: "+u_RetInfUsr( cUserName, 6 ) )
*/
         
lRet := Modelo3(cCadastro, cAlias1, cAlias2, aCpoEnchoice, cLinOK, cTudoOK, nOpcE , nOpcG , cFieldOK, lVirtual, nLinhas, aAltEnchoice, nFreeze,,,nSizeHd)

if lRet
   do case
      case nOpc == 3 // Inclui                 
           if ( !u_fStatus( (cAlias1)->ZRD_CODATE, (cAlias1)->ZRD_CODPRO ) .AND. ( M->ZRE_QTDLIB <= 0 ) )
              MsgAlert("ATENDIMENTO COM ESTOQUE TOTALMENTE BAIXADO... "+CHR(13)+CHR(13)+"**** NAO PODE SER ALTERADO! ****", cCadastro)               
           ELSE   
              //if ( __cUserID $ AllTrim(cLibOpc) )  
                 if MsgYesNo("CONFIRMA ALTERAÇÃO DOS DADOS?", cCadastro)
                    Processa({||AltDados()}, cCadastro, "Alterando os dados, aguarde...")
                 endIf
              //endIf
           endif   
      case nOpc == 4 // Altera
      case nOpc == 5 // Exclusao
           if MsgYesNo("CONFIRMA EXCLUSÃO DOS DADOS?", cCadastro)
              Processa({||ExcDados()}, cCadastro, "Excluindo os dados, aguarde...")
           endIf
   endcase
endIf

return Nil


/*------------------------------------------------------------------------
| Funcao    | CriaHeader | Otavio Pinto                | Data | 26/12/14  |
|-------------------------------------------------------------------------|
| Descricao | Rotina CRIA CABEÇALHO                                       |
|           |                                                             |
 ------------------------------------------------------------------------*/
static function CriaHeader(nOpc)

aHeader      := {}
aCpoEnchoice := {}
aAltEnchoice := {}

// aHeader é igual ao do Modelo2.
dbSelectArea("SX3") ; SX3->( dbSetOrder(1) )
SX3->( dbSeek(cAlias2) )

while SX3->( !EOF() .And. X3_Arquivo == cAlias2 )

   if X3Uso(SX3->X3_Usado)    .And.;                  // O Campo é usado.
      cNivel >= SX3->X3_Nivel .And.;                  // Nivel do Usuario é maior que o Nivel do Campo.
      Trim(SX3->X3_Campo) $ "ZRE_FILIAL/ZRE_CODATE/ZRE_CODPRO/ZRE_SEQ/ZRE_QTDLIB/ZRE_DTLIB/ZRE_LOTE/ZRE_NUMLOT/ZRE_DTVAL/ZRE_USLIB/ZRE_OBS"
//                                 1          2         3          4       5         6         7        8          9         10        11 
      aAdd(aHeader, {Trim(SX3->X3_Titulo)  /*1*/  ,;
                          SX3->X3_Campo    /*2*/  ,;
                          SX3->X3_Picture  /*3*/  ,;
                          SX3->X3_Tamanho  /*4*/  ,;
                          SX3->X3_Decimal  /*5*/  ,;
                          SX3->X3_Valid    /*6*/  ,;
                          SX3->X3_Usado    /*7*/  ,;
                          SX3->X3_Tipo     /*8*/  ,;
                          SX3->X3_Arquivo  /*9*/  ,;
                          SX3->X3_Context  /*0*/  })

   endIf

   SX3->( dbSkip() )

end
/*-------------------------------------------------------------------------------------------------------
| Campos da Enchoice.                                                                                    |
 -------------------------------------------------------------------------------------------------------*/
dbSelectArea("SX3") ; SX3->( dbSetOrder(1) )
SX3->( dbSeek(cAlias1) )

while SX3->( !EOF() .And. X3_Arquivo == cAlias1 )

   /*-------------------------------------------------------------------------------------------------------
   | Verifica se o Campo é usado e se o Nivel do Usuario é maior ou igual ao Nivel do Campo.                |
    -------------------------------------------------------------------------------------------------------*/
   if X3Uso(SX3->X3_Usado)    .And.    cNivel >= SX3->X3_Nivel       

      /*-------------------------------------------------------------------------------------------------------
      | Campos da Enchoice.                                                                                    |
       -------------------------------------------------------------------------------------------------------*/
      aAdd(aCpoEnchoice, SX3->X3_Campo )

      /*-------------------------------------------------------------------------------------------------------
      | Campos da Enchoice que podem ser editadas.                                                             |
      | Se tiver algum campo que nao deve ser editado, nao incluir aqui.                                       |
      | Bloqueia a edição dos campos da tabela pai (ZRD)                                                       |  
       -------------------------------------------------------------------------------------------------------*/
      //aAdd(aAltEnchoice, SX3->X3_Campo) 
 
   endIf

   SX3->( dbSkip() )

end  

return Nil


/*------------------------------------------------------------------------
| Funcao    | CriaCols   | Otavio Pinto                | Data | 26/12/14  |
|-------------------------------------------------------------------------|
| Descricao | Rotina cria os aCols                                        |
|           |                                                             |
 ------------------------------------------------------------------------*/
static function CriaCols(nOpc)

local nQtdCpo := 0
local i       := 0
local nCols   := 0

nQtdCpo := Len(aHeader)
aCols   := {}
aAlt    := {}

dbSelectArea(cAlias2) ; (cAlias2)->( dbSetOrder(1) )
if (cAlias2)->( dbSeek(xFilial(cAlias2) + (cAlias1)->(ZRD_CODATE+ZRD_CODPRO) )  )
   while  (cAlias2)->( !EOF() ) //.AND. EMPTY(ZRE_DTLIB) )
       if (cAlias2)->ZRE_CODATE == (cAlias1)->ZRD_CODATE .And. (cAlias2)->ZRE_CODPRO == (cAlias1)->ZRD_CODPRO 
          aAdd(aCols, Array(nQtdCpo+1))           
          nCols++
          for i := 1 To nQtdCpo
             if aHeader[i][10] <> "V" //.AND. aHeader[i][2] $ "ZRE_FILIAL,ZRE_CODATE,ZRE_CODPRO,ZRE_SEQ" //,ZRE_DTLIB,ZRE_DTVAL"
                aCols[nCols][i] := FieldGet(FieldPos(aHeader[i][2]))
             else                                                     
                aCols[nCols][i] := CriaVar(aHeader[i][2], .F. ) 
             endIf
          next
          aCols[nCols][nQtdCpo+1] := .F.
          aAdd(aAlt, (cAlias2)->( Recno() ) )
       endif
       (cAlias2)->( dbSkip() )
   end

else
   aAdd(aCols, Array(nQtdCpo+1))
   nCols++
   for i := 1 To nQtdCpo
      do case
         case aHeader[i][10] <> "V" .AND. aHeader[i][2] $ "ZRE_FILIAL,ZRE_CODATE,ZRE_CODPRO,ZRE_SEQ"  
              if aHeader[i][2] == "ZRE_FILIAL" ; aCols[nCols][i] := (cAlias1)->ZRD_FILIAL ; endif
              if aHeader[i][2] == "ZRE_CODATE" ; aCols[nCols][i] := (cAlias1)->ZRD_CODATE ; endif
              if aHeader[i][2] == "ZRE_CODPRO" ; aCols[nCols][i] := (cAlias1)->ZRD_CODPRO ; endif
              if aHeader[i][2] == "ZRE_SEQ"    ; aCols[nCols][i] := (cAlias2)->ZRE_SEQ    ; endif 
         case aHeader[i][10] <> "V" .AND. ! aHeader[i][2] $ "ZRE_FILIAL,ZRE_CODATE,ZRE_CODPRO,ZRE_SEQ" 
              aCols[nCols][i] := FieldGet(FieldPos(aHeader[i][2]))
      otherwise
         aCols[nCols][i] := CriaVar(aHeader[i][2], .F.)
      endcase      
   next
   aCols[nCols][nQtdCpo+1] := .F.
   aAdd(aAlt, (cAlias2)->( Recno() ) )
endif
 
return Nil
 


/*------------------------------------------------------------------------
| Funcao    | AltDados   | Otavio Pinto                | Data | 26/12/14  |
|-------------------------------------------------------------------------|
| Descricao | Rotina altera dados na tabela filho (ZRE)                   |
|           |                                                             |
 ------------------------------------------------------------------------*/
static function AltDados()

local bCampo := {|nField| Field(nField)}
local i      := 0
local y      := 0
local nItem  := 0
local lAchou := .F. 
local cRet   := ""

xx := ctod("")

begin sequence  
    ProcRegua( Len(aCols) + FCount() )
    dbSelectArea(cAlias2) ; (cAlias2)->( dbSetOrder(1) )
    
    nItem := Len(aAlt) + 1   
    
    //- nItem := VAL( u_NUMSEQ( (cAlias1)->ZRD_FILIAL,(cAlias1)->ZRD_CODATE,(cAlias1)->ZRD_CODPRO ) ) + 1     
    for i := 1 To Len(aCols)
        lAchou := .F. 

        if (cAlias2)->( dbSeek( xFilial(cAlias2)+(cAlias1)->ZRD_CODATE+(cAlias1)->ZRD_CODPRO ) )
           lAchou := .T. 
        else
           nItem := 1        
        endif 

        if i <= Len(aAlt) .AND. lAchou   
           (cAlias2)->( dbGoTo( aAlt[i] )  )        
           RecLock(cAlias2, .F.)
           if aCols[i][Len(aHeader)+1]
              (cAlias2)->( dbDelete() )
           else
              for y := 1 To Len(aHeader)
                 do case
                    case aHeader[y][2] $ "ZRE_FILIAL"
                         FieldPut(FieldPos(Trim(aHeader[y][2])), xFilial(cAlias2) )
                    case aHeader[y][2] $ "ZRE_CODATE"
                         FieldPut(FieldPos(Trim(aHeader[y][2])), (cAlias1)->ZRD_CODATE )
                    case aHeader[y][2] $ "ZRE_CODPRO"
                         FieldPut(FieldPos(Trim(aHeader[y][2])), (cAlias1)->ZRD_CODPRO )
                    case aHeader[y][2] $ "ZRE_SEQ"
                         FieldPut(FieldPos(Trim(aHeader[y][2])), (cAlias2)->ZRE_SEQ )
                         //FieldPut(FieldPos(Trim(aHeader[y][2])), StrZero(nItem, 2, 0) )
                    case aHeader[y][2] $ "ZRE_NUMLOT"
                         FieldPut(FieldPos(Trim(aHeader[y][2])), u_fLeLote( 1, (cAlias1)->ZRD_CODPRO, (cAlias2)->ZRE_LOTE, (cAlias1)->ZRD_CODATE))                            
                    case (aHeader[y][2] $ "ZRE_DTVAL") .or. (y == 8)                    
                         FieldPut(FieldPos(Trim(aHeader[y][2])), u_fLeLote( 2, (cAlias1)->ZRD_CODPRO, (cAlias2)->ZRE_LOTE, (cAlias1)->ZRD_CODATE))   
                 otherwise
                    FieldPut(FieldPos(Trim(aHeader[y][2])), aCols[i][y])
                 endcase
              next
              
           endIf      
           (cAlias2)->( MSUnlock() )
        else   
           if !aCols[i][Len(aHeader)+1]
              RecLock(cAlias2, .T.)      
              
              for y := 1 To Len(aHeader)              
                 do case
                    case aHeader[y][2] $ "ZRE_FILIAL"
                         FieldPut(FieldPos(Trim(aHeader[y][2])), xFilial(cAlias2) )
                    case aHeader[y][2] $ "ZRE_CODATE"
                         FieldPut(FieldPos(Trim(aHeader[y][2])), (cAlias1)->ZRD_CODATE )
                    case aHeader[y][2] $ "ZRE_CODPRO"
                         FieldPut(FieldPos(Trim(aHeader[y][2])), (cAlias1)->ZRD_CODPRO )
                    case aHeader[y][2] $ "ZRE_SEQ"
                         FieldPut(FieldPos(Trim(aHeader[y][2])), StrZero(nItem, 2, 0) )
                    case aHeader[y][2] $ "ZRE_NUMLOT"
                         FieldPut(FieldPos(Trim(aHeader[y][2])), u_fLeLote( 1, (cAlias1)->ZRD_CODPRO, M->ZRE_LOTE, (cAlias1)->ZRD_CODATE))
                    case (aHeader[y][2] $ "ZRE_DTVAL") .or. (y == 8)
                         FieldPut(FieldPos(Trim(aHeader[y][2])), u_fLeLote( 2, (cAlias1)->ZRD_CODPRO, M->ZRE_LOTE, (cAlias1)->ZRD_CODATE))
                 otherwise
                    FieldPut(FieldPos(Trim(aHeader[y][2])), aCols[i][y])
                 endcase
              next
              (cAlias2)->ZRE_SEQ    := StrZero(nItem, 2, 0)           
              nItem++
              (cAlias2)->( MSUnlock() )
              
            endIf
        endIf
    next

endsequence

return Nil


/*------------------------------------------------------------------------
| Funcao    | ExcDados   | Otavio Pinto                | Data | 26/12/14  |
|-------------------------------------------------------------------------|
| Descricao | Rotina exclui dados na tabela filho (ZRE)                   |
|           |                                                             |
 ------------------------------------------------------------------------*/
static function ExcDados()

/*-------------------------------------------------------------------------------------------------------
| +1 é por causa da exclusao do arq. de cabeçalho.                                                       |
 -------------------------------------------------------------------------------------------------------*/
ProcRegua(Len(aCols)+1)   
begin sequence

    if !MsgBox("A opção de Exclusão 'Deleta o registro' sem repor o estoque."+Chr(13)+Chr(13)+;
               "A Diferente para o 'Estorno' e´ que o 'Estorno' volta as quantidades para"+chr(13)+;
               "o Estoque e apaga apenas a data de liberação, permitindo que seja feita"+CHR(13)+;
               "alteração na(s) quantidade(s) e/ou no(s) lote(s).",;
               "A T E N Ç A O",;
               "YESNO")                                                             
       break
    endif

    dbSelectArea(cAlias2) ; (cAlias2)->( dbSetOrder(1) )
    dbSeek(xFilial(cAlias2) + (cAlias1)->(ZRD_CODATE+ZRD_CODPRO) ) 

    while (cAlias2)->( !EOF() .And. ZRE_Filial == xFilial(cAlias2) .And. ZRE_CODATE == (cAlias1)->ZRD_CODATE .And. ZRE_CODPRO == (cAlias1)->ZRD_CODPRO  )
       (cAlias2)->( IncProc() )
       if Empty((cAlias2)->ZRE_DTLIB)
          //u_EstorB2() // Desabilitei esta linha, porque Exclusão é diferente de Estorno - Excluir registro não deve movimentar estoque.
          RecLock(cAlias2, .F.)     
          (cAlias2)->( dbDelete() )
          (cAlias2)->( MSUnlock() )
       endif   
       (cAlias2)->( dbSkip() )
    end

endsequence
return Nil


/*------------------------------------------------------------------------
| Funcao    | DETudOK    | Otavio Pinto                | Data | 26/12/14  |
|-------------------------------------------------------------------------|
| Descricao | Rotina verifica condição para excluir dados na tabela filho |
|           | (ZRE)                                                       |
 ------------------------------------------------------------------------*/
user function DETudOK()

local lRet := .T.
local i    := 0
local nDel := 0

for i := 1 To Len(aCols)
    if aCols[i][Len(aHeader)+1]
       nDel++
    endIf
next

if nDel == Len(aCols)
  //- RecLock(cAlias2, .F.)     
  //- (cAlias2)->( dbDelete() )
  //- (cAlias2)->( MSUnlock() )
   
   MsgInfo("Para excluir todos os itens, utilize a opção EXCLUIR", cCadastro)
   lRet := .F.
endIf     

return lRet 



/*------------------------------------------------------------------------
| Funcao    | NUMSEQ     | Otavio Pinto                | Data | 26/12/14  |
|-------------------------------------------------------------------------|
| Descricao | Rotina pega ultima sequencia da chave na tabela filho (ZRE) |
|           |                                                             |
|           |                                                             |
 ------------------------------------------------------------------------*/
user function NUMSEQ(cZRD_FILIAL,cZRD_CODATE,cZRD_CODPRO)
local cRet  := " "
local cQry  := " "

if  Select("TMP") > 0  ; ("TMP")->( dbCloseArea() ) ; endif      

cQry := " SELECT ( CASE WHEN MAX(ZRE_SEQ) IS NOT NULL THEN MAX(ZRE_SEQ) "+cEol
cQry += "               ELSE '00'              "+cEol
cQry += "               END        )   ZRE_SEQ "+cEol
cQry += " FROM "+RetSqlName(cAlias2)+" RE "+cEol
cQry += " WHERE ZRE_FILIAL = '"+cZRD_FILIAL+"'" +cEol
cQry += "   AND ZRE_CODATE = '"+cZRD_CODATE+"'" +cEol
cQry += "   AND ZRE_CODPRO = '"+cZRD_CODPRO+"'" +cEol
cQry += "   AND RE.D_E_L_E_T_ = ' ' "+cEol
TCQuery cQry Alias "TMP" New
dbSelectArea("TMP")
TMP->( dbGoTop() )
cRet :=  TMP->ZRE_SEQ
TMP->( dbCloseArea() )  
return cRet 


/*------------------------------------------------------------------------
| Funcao    | BaixEst  | Otavio Pinto                  | Data | 26/12/14  |
|-------------------------------------------------------------------------|
| Descricao | Rotina de baixa no estoque na tabela SD3                    |
|           |                                                             |
|           | SEM USO *************************************               |
 ------------------------------------------------------------------------*/

user function BaixEst()
local   cArea    := GetArea()
private cQuery   := ""
private cQry     := "TMP"
private cTM      := ""
private cUM      := ""
private cGrpProd := ""
private cTpProd  := ""
private cConta   := ""
private cCC      := ""
private cDoc     := ""
private cEol     := CHR(13)+CHR(10)

private cLocal   := " " 
private lFeito   := .F.

private lMsHelpAuto    := .T.
private lAutoErrNoFile := .F.

/*  ==========================================================================
    FIXADO VALORES PARA SIMPLES TESTE DE GRAVAÇÃO... 
    ESTAS VARIÁVEIS DEVEM RECEBER VALORES DO POSICIONAMENTO DA LINHA DO BROWSE*/
c_FILIAL := " "
c_CODATE := "000000121595"
c_CODPRO := "90013"                                                                        
cLocal   := '01' // --> precisa ver como traremos o LOCAL quando for de agencia....
/*  ==========================================================================*/

begin sequence
    dbSelectArea("SD3") ; SD3->( dbSetOrder(7) )
    dbSelectArea("SB1") ; SB1->( dbSetOrder(1) )
       
    cQuery := " SELECT ZRE_FILIAL,ZRE_CODATE,ZRE_CODPRO,SUM( ZRE_QTDLIB ) ZRE_QTDLIB "+cEol   
    cQuery += " FROM "+RetSqlName(cAlias2)+" "+cEol
    cQuery += " WHERE ZRE_FILIAL = '"+c_FILIAL+"' "+cEol
    cQuery += "   AND ZRE_CODATE = '"+c_CODATE+"' "+cEol
    cQuery += "   AND ZRE_CODPRO = '"+c_CODPRO+"' "+cEol    
    cQuery += "   AND D_E_L_E_T_ = ' '  "+cEol
    cQuery += " GROUP BY ZRE_FILIAL,ZRE_CODATE,ZRE_CODPRO "+cEol
    cQuery += " ORDER BY ZRE_FILIAL,ZRE_CODATE,ZRE_CODPRO "+cEol
   
	TcQuery cQuery New Alias (cQry)
	dbSelectArea(cQry)
    
	while (cQry)->( !Eof() )
        cDoc     := ""
        cTM      := ""        
        cUM      := ""
        cGrpProd := ""
        cTpProd  := ""
        cConta   := ""
        cCC      := ""
    
        /*    
		if substr(alltrim((cQry)->D3_TM),1,3) == "EMI" <------------------
			cTM := SuperGetMV("MV_QGMXTMB",.F.,"501")
		elseif substr(alltrim((cQry)->D3_TM),1,3) == "RET" <------------------
			cTM := SuperGetMV("MV_QGMXTME",.F.,"002")
		endif
		*/
        
        // Somente para ser usado em testes -----------------------------//
        cTM := SuperGetMV("MV_QGMXTME",.F.,"002")                        // --> Definir como traremos o cTM....
        //---------------------------------------------------------------//
        
		if SB1->( dbSeek(xFilial("SB1")+(cQry)->ZRE_CODPRO) ) 
		   cUM      := SB1->B1_UM
		   cGrpProd := SB1->B1_GRUPO
		   cTpProd  := SB1->B1_TIPO
		   cConta   := SB1->B1_CONTA
           cCC      := SB1->B1_CC
		endif

        aMata240 := {}

        AADD(aMata240,{"D3_TM"     ,cTM														 ,Nil})
        AADD(aMata240,{"D3_COD"    ,padr(alltrim((cQry)->ZRE_CODPRO),TamSX3("ZRE_CODPRO")[1]),Nil})
        AADD(aMata240,{"D3_UM"     ,cUM       												 ,Nil})
        AADD(aMata240,{"D3_GRUPO"  ,cGrpProd 												 ,Nil})
        AADD(aMata240,{"D3_TIPO"   ,cTpProd    												 ,Nil})
        AADD(aMata240,{"D3_QUANT"  ,(cQry)->ZRE_QTDLIB										 ,Nil}) 
        AADD(aMata240,{"D3_LOCAL"  ,cLocal                                              	 ,Nil}) 
        AADD(aMata240,{"D3_EMISSAO",dDataBase                            					 ,Nil})
        AADD(aMata240,{"D3_DOC"    ,cDoc									  				 ,Nil})
        AADD(aMata240,{"D3_CONTA"  ,cConta													 ,Nil})
        AADD(aMata240,{"D3_CC"     ,cCC             										 ,Nil})
        AADD(aMata240,{"D3_NUMSEQ" ," "         	        								 ,Nil})

        begintran()

        lMsErroAuto := .F.

        if SD3->( !dbSeek( (cQry)->(ZRE_FILIAL+ZRE_CODPRO+cLocal)   ) )
           /*--------------------------------------------------------------------------------------*/
            MsExecAuto({|x,y| MATA240(x,y)}, aMata240, 3)
           /*--------------------------------------------------------------------------------------*/
        endif
        if lMsErroAuto
           MostraErro()
           DisarmTransaction()
        else
           EndTran()
        endif
        (cQry)->( MsUnlockAll() )
        (cQry)->( dbSkip() )
	enddo
end sequence    
dbSelectArea(cQry) ; (cQry)->( dbCloseArea() )
RestArea(cArea)

return



/*------------------------------------------------------------------------
| Funcao    | BaixaB2  | Otavio Pinto                  | Data | 26/12/14  |
|-------------------------------------------------------------------------|
| Descricao | Rotina de baixa o estoque na tabela SB2                     |
|           | (Cadastro de Saldos em Estoque)                             |
|           |                                                             |
|           |  B2_TIPO : 1=Padrao; 2=Proprio; 3=Terceiros  (Tipo Armazem) |
|           |  B2_LOCAL: 56=NITEROI; 57/55=TIJUCA; 58=BANGU  (Armazem)    |
|           |                                                             |
|           |                                                             |
|           |                                                             |
 ------------------------------------------------------------------------*/
user function BaixaB2()
local cArea   := GetArea()
local lBaixou := .F. 
private cQry     := " "                        
private _cCOD    := " " 
private _cATE    := " "
private _cLOCAL  := " " 
private _dDTLIB  := CTOD("")
private _nQATU   := 0
                        
begin sequence
    dbSelectArea("SB8") ; SB8->( dbSetOrder(3) )

    cQry := " SELECT ZRE_FILIAL,ZRE_CODATE,ZRE_CODPRO,ZRE_DTLIB,SUM( ZRE_QTDLIB ) ZRE_QTDLIB "
    cQry += " FROM "+RetSqlName(cAlias2)+" "
    cQry += " WHERE ZRE_FILIAL = '"+(cAlias1)->ZRD_FILIAL+"' "
    cQry += "   AND ZRE_CODATE = '"+(cAlias1)->ZRD_CODATE+"' "
    cQry += "   AND ZRE_CODPRO = '"+(cAlias1)->ZRD_CODPRO+"' "
    cQry += "   AND D_E_L_E_T_ = ' '  " 
    cQry += "   AND ZRE_DTLIB  = ' '  "
    cQry += " GROUP BY ZRE_FILIAL,ZRE_CODATE,ZRE_CODPRO,ZRE_DTLIB "
    cQry += " ORDER BY ZRE_FILIAL,ZRE_CODATE,ZRE_CODPRO,ZRE_DTLIB "

    TcQuery cQry New Alias "TMP2"
    dbSelectArea("TMP2")
                            
     _cCOD    := TMP2->ZRE_CODPRO    
     _cATE    := TMP2->ZRE_CODATE    
     _cLOCAL  := u_fCodAge( TMP2->ZRE_CODATE )
     _nQATU   := TMP2->ZRE_QTDLIB       
     _dDTLIB  := TMP2->ZRE_DTLIB       

    if ! MsgBox("Baixar Estoque ?"+Chr(13)+Chr(13)+;
                "Codigo________ = "+_cCOD+chr(13)+;
                "Armazem______ = "+_cLOCAL+CHR(13)+;
                "Quantidade____ = "+AllTrim(STR(_nQATU,0)),;
                "A T E N Ç A O",;
                "YESNO")                                                             
       break
    endif

    zArea := GetArea()
    dbSelectArea("SB2")                                                           
    if dbSeek( xFilial("SB2")+ _cCOD+ _cLOCAL )

       if SB2->B2_QATU >= _nQATU .AND. EMPTY( _dDTLIB )
          // Baixa estoque na tabela SB2 (SALDOS FISICO E FINANCEIRO)
          RecLock("SB2",.F.)   
          SB2->B2_QATU -= _nQATU       
          SB2->( MsUnLock() )  
          (cAlias2)->( dbSetOrder(1) )
          lBaixou := .F.
          if (cAlias2)->( dbSeek( xFilial(cAlias2) + _cATE +  _cCOD  )  )

             while (cAlias2)->( ZRE_FILIAL == xFilial(cAlias2) .AND. ZRE_CODATE == _cATE .AND. ZRE_CODPRO == _cCOD .AND. !EOF() )             

                 if (cAlias2)->( EMPTY(ZRE_DTLIB) )
                    RecLock(cAlias2,.F.)     
                    (cAlias2)->ZRE_DTLIB := dDataBase
                    (cAlias2)->( MsUnLock() )                                                                    
                    lBaixou := .T. 
                    cAreaB8 := GetArea()
                    if SB8->( dbSeek( xFilial("SB8")+ _cCOD+ _cLOCAL + (cAlias2)->ZRE_LOTE + (cAlias2)->ZRE_NUMLOTE ) )
                       // Baixa estoque na tabela SB8 (SALDOS POR LOTE)         
                       RecLock("SB8",.F.)                     
                       SB8->B8_SALDO -=  (cAlias2)->ZRE_QTDLIB //_nQATU
                       SB8->( MsUnLock() )                            
                    endif                         
                    RestArea(cAreaB8)                   
                    
                 endif        
                (cAlias2)->( dbSkip() ) 
             end  
          endif                  
          if lBaixou
             MsgStop("Atualizado com sucesso!") 
          endif   
       else                      
          if EMPTY( _dDTLIB )
             MsgStop("NÃO HÁ ITENS A SEREM BAIXADOS!!" )           
          else                         
             MsgAlert("Erro na baixa do estoque!!"+chr(13)+chr(13)+;
                      "Quantidade a Baixar = "+AllTrim(STR(_nQATU,0))+chr(13)+;
                      "Quantidade em Estoque = "+AllTrim(STR(SB2->B2_QATU,0))+chr(13)+chr(13)+;
                      "Verificar !!!","A V I S O" )      
          endif            
       endif  
    endif
    RestArea(zArea)

end sequence
TMP2->( dbCloseArea() )
RestArea(cArea)


return



/*------------------------------------------------------------------------
| Funcao    | EstorB2  | Otavio Pinto                  | Data | 09/01/15  |
|-------------------------------------------------------------------------|
| Descricao | Rotina de Estorno da baixa no estoque na tabela SB2         |
|           | (Cadastro de Saldos em Estoque)                             |
|           |                                                             |
|           |  B2_TIPO : 1=Padrao; 2=Proprio; 3=Terceiros  (Tipo Armazem) |
|           |                                                             |
|           |  B2_LOCAL: 01= Armazem CENTRAL                              |
|           |            53= Nupre TIJUCA                                 |
|           |            54= Nupre NITEROI                                |
|           |            55= Nupre BANGU                                  |
|           |            56= MATURIDADE                                   |
|           |            57= CENTRO MEDICO TIJUCA                         |
|           |                                                             |
 ------------------------------------------------------------------------*/
user function EstorB2()
local cArea := GetArea()
local lEstorno := .F. 
private cQry     := " "                        
private _cCOD    := " " 
private _cATE    := " "
private _cLOCAL  := " " 
private _dDTLIB  := CTOD("")
private _nQATU   := 0

begin sequence
    dbSelectArea("SB8") ; SB8->( dbSetOrder(3) )
    
    cQry := " SELECT ZRE_FILIAL,ZRE_CODATE,ZRE_CODPRO,ZRE_DTLIB,SUM( ZRE_QTDLIB ) ZRE_QTDLIB "
    cQry += " FROM "+RetSqlName(cAlias2)+" "
    cQry += " WHERE ZRE_FILIAL = '"+(cAlias1)->ZRD_FILIAL+"' "
    cQry += "   AND ZRE_CODATE = '"+(cAlias1)->ZRD_CODATE+"' "
    cQry += "   AND ZRE_CODPRO = '"+(cAlias1)->ZRD_CODPRO+"' "
    cQry += "   AND D_E_L_E_T_ = ' '  " 
    cQry += "   AND ZRE_DTLIB  <> ' '  "
    cQry += " GROUP BY ZRE_FILIAL,ZRE_CODATE,ZRE_CODPRO,ZRE_DTLIB "
    cQry += " ORDER BY ZRE_FILIAL,ZRE_CODATE,ZRE_CODPRO,ZRE_DTLIB "

    TcQuery cQry New Alias "TMP2"
    dbSelectArea("TMP2")

    _cCOD    := TMP2->ZRE_CODPRO    
    _cATE    := TMP2->ZRE_CODATE    
    _cLOCAL  := u_fCodAge( TMP2->ZRE_CODATE )
    _nQATU   := TMP2->ZRE_QTDLIB       
    _dDTLIB  := TMP2->ZRE_DTLIB       

    if ! MsgBox("Estornar Movimentação ?"+Chr(13)+Chr(13)+;
                "Codigo________ = "+_cCOD+chr(13)+;
                "Armazem______ = "+_cLOCAL+CHR(13)+;
                "Quantidade____ = "+AllTrim(STR(_nQATU,0)),;
                "A T E N Ç A O",;
                "YESNO")                                                             
       break
    endif

    zArea := GetArea()
    dbSelectArea("SB2") ; SB2->( dbSetOrder(1) )                                                           
    if dbSeek( xFilial("SB2")+ _cCOD+ _cLOCAL )
       //if SB2->B2_QATU >= _nQATU .AND. !EMPTY( _dDTLIB )
       if !EMPTY( _dDTLIB )
          // Baixa estoque na tabela SB2 (SALDOS FISICO E FINANCEIRO)
          RecLock("SB2",.F.)   
          SB2->B2_QATU += _nQATU       
          SB2->( MsUnLock() )  
          lEstorno := .F.          
          (cAlias2)->( dbSetOrder(1) )
          if (cAlias2)->( dbSeek( xFilial(cAlias2) + _cATE +  _cCOD  )  )

             while (cAlias2)->( ZRE_FILIAL == xFilial(cAlias2) .AND. ZRE_CODATE == _cATE .AND. ZRE_CODPRO == _cCOD .AND. !EOF() )

                 if (cAlias2)->( !EMPTY(ZRE_DTLIB) )                 
                    RecLock(cAlias2,.F.)     
                    (cAlias2)->ZRE_DTLIB := ctod(" ")  //Torna registro pronto para nova baixa.
                    (cAlias2)->( MsUnLock() ) 
                    lEstorno := .F.          
                    cAreaB8 := GetArea()
                    if SB8->( dbSeek( xFilial("SB8")+ _cCOD+ _cLOCAL + (cAlias2)->ZRE_LOTE + (cAlias2)->ZRE_NUMLOTE ) )
                       // Estorna estoque na tabela SB8 (SALDOS POR LOTE)         
                       RecLock("SB8",.F.)                     
                       SB8->B8_SALDO +=  (cAlias2)->ZRE_QTDLIB //_nQATU
                       SB8->( MsUnLock() )                            
                    endif                         
                    RestArea(cAreaB8)

                 endif        
                (cAlias2)->( dbSkip() ) 
             end  
          endif                 
          if lEstorno
             MsgStop("Atualizado com sucesso!") 
          endif   
       else                      
          if EMPTY( _dDTLIB )
             MsgStop("NÃO HÁ ITENS A SEREM ESTORNADOS!!" )           
          else                         
             MsgAlert("Erro no Estorno do Movimento!!"+chr(13)+chr(13)+;
                      "Quantidade a Estornar = "+AllTrim(STR(_nQATU,0))+chr(13)+;
                      "Quantidade em Estoque = "+AllTrim(STR(SB2->B2_QATU,0))+chr(13)+chr(13)+;
                      "Verificar !!!","A V I S O" )      
          endif            
       endif  
    endif
    RestArea(zArea)

end sequence
TMP2->( dbCloseArea() )
RestArea(cArea)

return



/*------------------------------------------------------------------------
| Funcao    | vldQtd   | Otavio Pinto                  | Data | 07/01/15  |
|-------------------------------------------------------------------------|
| Descricao | Rotina para validar se há estoque disponível na tabela SB2  |
|           | (Cadastro de Saldos em Estoque)                             |
|           |                                                             |
|           |                                                             |
|           |                                                             |
 ------------------------------------------------------------------------*/
user function vldBxa( _nQuantLiber )
local cArea := GetArea()
private cQry     := " "                        
private _cCOD    := " "
private _cLOCAL  := " "
private _nQATU   := 0     
private lRet     := .T.         

_nQATU := _nQuantLiber := if ( _nQuantLiber == nil , M->ZRE_QTDLIB, _nQuantLiber )

begin sequence

     _cCOD    := (cAlias1)->ZRD_CODPRO
     _cLOCAL  := SUBSTR( posicione( "BTH",1, xFilial("BTH")+(cAlias1)->ZRD_CODATE, "BTH_CODLOC" ) ,2,2 )
     //_nQATU   := M->ZRE_QTDLIB

    zArea := GetArea()
    dbSelectArea("SB2")                                                           
    if SB2->( dbSeek( xFilial("SB2")+ _cCOD+ _cLOCAL ) )
       if SB2->B2_QATU < _nQATU .OR. SB2->B2_QATU = 0
          MsgAlert("Estoque baixo ou zerado!!"+chr(13)+chr(13)+;
                   "Quantidade a Baixar = "+AllTrim(STR(_nQATU,0))+chr(13)+;
                   "Quantidade em Estoque = "+AllTrim(STR(SB2->B2_QATU,0))+chr(13)+chr(13)+;
                   "Verificar !!!","A V I S O" )      
          lRet := .F.         
       endif  
    endif 
    RestArea(zArea)

end sequence

RestArea(cArea)

return lRet


/*------------------------------------------------------------------------
| Funcao    | fCodAge  | Otavio Pinto                  | Data | 08/01/15  |
|-------------------------------------------------------------------------|
| Descricao | Rotina para pegar o código da Agencia(Armazém)              |
|           |                                                             |
|           |                                                             |
|           |                                                             |
|           |                                                             |
 ------------------------------------------------------------------------*/
user function fCodAge( cCodAte )
local cArea      := GetArea()
private cQry     := " "                        
private cRet     := SPACE(2)         

begin sequence

    cQry := " SELECT BBD_LOCAL "
    cQry += " FROM "+RetSqlName("BBD")+" "
    cQry += " WHERE  BBD_FILIAL = '  ' "
    cQry += " AND    BBD_NUMATE = '"+cCodAte+"' "   //codate
    cQry += " AND    D_E_L_E_T_ = ' ' "

    TcQuery cQry New Alias "TMP3"
    dbSelectArea("TMP3")

    cRet := SUBSTR(TMP3->BBD_LOCAL,2,2)

end sequence           

TMP3->( dbCloseArea() )
RestArea(cArea)

return cRet




/*------------------------------------------------------------------------
| Funcao    | fLeLote     | Otavio Pinto               | Data | 12/01/15  |
|-------------------------------------------------------------------------|
| Descricao | Rotina para buscar informações referente ao lote.           |
|           |                                                             |
| Parametro | nTipo: 1 - Retorna Numero do Lote                           |
|           |        2 - Retorna a Data de Validade do Lote               |
|           |                                                             |
 ------------------------------------------------------------------------*/
user function fLeLote( nTipo, cCodpro, cLote, cCodAte )
local cArea    := GetArea()
local cRet4    := SPACE(6)
local dRet4    := CTOD("")

private cQry4    := " "               

begin sequence

    cQry4 := " SELECT D3_NUMLOTE, D3_DTVALID "
    cQry4 += " FROM "+RetSqlName("SD3")+" "                                                            
    cQry4 += " WHERE  D3_COD      = '"+cCodPro+"' "
    cQry4 += "   AND  D3_LOCAL    = '"+u_fCodAge( cCodAte )+"' "   
    cQry4 += "   AND  D3_LOTECTL  = '"+cLote+"' "   
    cQry4 += "   AND  D3_GRUPO    = '11' "   // Medicamentos
    cQry4 += "   AND  SUBSTR(D3_CF,1,1) = 'D' "   // Classificação Fiscal 
    cQry4 += "   AND  D_E_L_E_T_  = ' ' "

    TcQuery cQry4 New Alias "TMP4"
    dbSelectArea("TMP4")

    if nTipo == 1
       cRet4 := TMP4->D3_NUMLOTE
    else   
       dRet4 := CTOD(SUBSTR(TMP4->D3_DTVALID,7,2)+"/"+SUBSTR(TMP4->D3_DTVALID,5,2)+"/"+SUBSTR(TMP4->D3_DTVALID,1,4))
    endif   

end sequence           

TMP4->( dbCloseArea() )
RestArea(cArea)

return if(nTipo == 1,cRet4,dRet4)

/*------------------------------------------------------------------------
| Funcao    | ZRLegen   | Otavio Pinto                 | Data | 14/01/15  |
|-------------------------------------------------------------------------|
| Descricao | Rotina para exibir a janela da legenda.                     |
|           | Específico para o programa AXCADZRE.PRW                     |
|           |                                                             |
+------------------------------------------------------------------------*/
user function ZRLegen()
local aLegenda := { { aCdCores[1,1],aCdCores[1,2] },;
	                { aCdCores[2,1],aCdCores[2,2] },; 
	                { aCdCores[3,1],aCdCores[3,2] } }

BrwLegenda(cCadastro,"Estoque" ,aLegenda)

return


/*------------------------------------------------------------------------
| Funcao    | fStatus  | Otavio Pinto                  | Data | 14/01/15  |
|-------------------------------------------------------------------------|
| Descricao | Rotina para verificar se há quantidades não baixadas.       |
|           |                                                             |
|           | Logica:                                                     |
|           |     Se retornar .T. é porque há quantidade a ser baixada.   |
|           |     Se retornar .F. é porque todos foram baixados.          |
|           |                                                             |
 ------------------------------------------------------------------------*/
user function fStatus( cCodAte, cCodPro )
local cArea      := GetArea()
local nSoma      := 0
private cQryX    := " "                        
private lRet     := .F.

begin sequence

    cQryX := " SELECT ZRE_DTLIB, ZRE_QTDLIB "
    cQryX += " FROM "+RetSqlName("ZRE")+" "
    cQryX += " WHERE  ZRE_FILIAL = '  ' "
    cQryX += " AND    ZRE_CODATE = '"+cCodAte+"' "   
    cQryX += " AND    ZRE_CODPRO = '"+cCodPro+"' "       
    cQryX += " AND    D_E_L_E_T_ = ' ' "

    TcQuery cQryX New Alias "TMP5"
    dbSelectArea("TMP5")
    TMP5->( dbGoTop() )

    while TMP5->( ! Eof() )
       if TMP5->( Empty( TMP5->ZRE_DTLIB ) .AND. ZRE_QTDLIB > 0  )
          lRet  := .T.     
       endif   
       if !Empty( TMP5->ZRE_DTLIB )
          nSoma += TMP5->ZRE_QTDLIB
       endif   
       TMP5->( dbSkip() )
    end
    if nSoma >=  (cAlias1)->ZRD_QTDSOL
       lRet  := .F.       
    endif
    nSoma := 0
end sequence           

TMP5->( dbCloseArea() )
RestArea(cArea)

return lRet

/*------------------------------------------------------------------------
| Funcao    | fQuant   | Otavio Pinto                  | Data | 14/01/15  |
|-------------------------------------------------------------------------|
| Descricao | Rotina para verificar se há quantidades a serem baixadas.   |
|           |                                                             |
|           | Logica:                                                     |
|           |     Se retornar .T. é porque há quantidade a ser baixada.   |
|           |     Se retornar .F. é porque todos foram baixados.          |
|           |                                                             |
|           | Funcao usada na Consulta Padrao ZRESB2                      |
 ------------------------------------------------------------------------*/
user function fQuant( cCodAte, cCodPro )
local cArea      := GetArea()
private cQryX    := " "                        
private lMov     := .F.

begin sequence

    cQryX := " SELECT ZRE_QTDLIB "
    cQryX += " FROM "+RetSqlName("ZRE")+" "
    cQryX += " WHERE  ZRE_FILIAL = '  ' "
    cQryX += " AND    ZRE_CODATE = '"+cCodAte+"' "   
    cQryX += " AND    ZRE_CODPRO = '"+cCodPro+"' "       
    cQryX += " AND    D_E_L_E_T_ = ' ' "

    TcQuery cQryX New Alias "TMP6"
    dbSelectArea("TMP6")
    TMP6->( dbGoTop() )
    
    while TMP6->( !Eof() )
       if TMP6->ZRE_QTDLIB == 0
          lMov  := .T.     
       endif
       TMP6->( dbSkip() )       
    end

end sequence           

TMP6->( dbCloseArea() )
RestArea(cArea)

return lMov



/*------------------------------------------------------------------------
| Funcao    | fMovim   | Otavio Pinto                  | Data | 14/01/15  |
|-------------------------------------------------------------------------|
| Descricao | Rotina para verificar se há quantidades a serem baixadas.   |
|           |                                                             |
|           | Logica:                                                     |
|           |     Se retornar .T. é porque há quantidade a ser baixada.   |
|           |     Se retornar .F. é porque todos foram baixados.          |
|           |                                                             |
 ------------------------------------------------------------------------*/
user function fMovim( cCodAte, cCodPro )
local cArea      := GetArea()
private cQryX    := " "                        
private lMov     := .F.

begin sequence

    cQryX := " SELECT ZRE_QTDLIB "
    cQryX += " FROM "+RetSqlName("ZRE")+" "
    cQryX += " WHERE  ZRE_FILIAL = '  ' "
    cQryX += " AND    ZRE_CODATE = '"+cCodAte+"' "   
    cQryX += " AND    ZRE_CODPRO = '"+cCodPro+"' "       
    cQryX += " AND    D_E_L_E_T_ = ' ' "

    TcQuery cQryX New Alias "TMP7"
    dbSelectArea("TMP7")
    TMP7->( dbGoTop() )
    
    if TMP7->( !Eof() )
       lMov  := .T.     
    end

end sequence           

TMP7->( dbCloseArea() )
RestArea(cArea)

return lMov



/*------------------------------------------------------------------------
| Funcao    | fSaldo   | Otavio Pinto                  | Data | 16/01/15  |
|-------------------------------------------------------------------------|
| Descricao | Rotina para verificar se há quantidades a serem baixadas.   |
|           |                                                             |
|           | Logica:                                                     |
|           |     Se retornar .T. é porque há quantidade a ser baixada.   |
|           |     Se retornar .F. é porque todos foram baixados.          |
|           |                                                             |
|           | Funcao usada na Consulta Padrao ZRESB2                      |
 ------------------------------------------------------------------------*/
user function fSaldo( cCodAte, cCodPro, cLote )
local cArea      := GetArea()
private cQryX    := " "                        
private nRet     := 0  

begin sequence

    cQryX := " SELECT B8_PRODUTO, B8_NUMLOTE, B8_SALDO  "
    cQryX += " FROM "+RetSqlName("SB8")+" "
    cQryX += " WHERE  B8_FILIAL    = '"+xFILIAL("SB8")+"' "
    cQryX += "   AND  B8_PRODUTO   = '"+cCodPro+"' "   
    cQryX += "   AND  B8_LOCAL     = '"+u_fCodAge( cCodAte )+"' "
    cQryX += "   AND  B8_LOTECTL   = '"+cLote+"' "       
    cQryX += "   AND  D_E_L_E_T_   = ' ' "

    TcQuery cQryX New Alias "TMP8"
    dbSelectArea("TMP8")
    TMP8->( dbGoTop() )
    
    do case 
       case TMP8->( !Eof() )
            if TMP8->B8_SALDO > 0
               nRet  := TMP8->B8_SALDO
            endif
    endcase

end sequence           

TMP8->( dbCloseArea() )
RestArea(cArea)

return nRet




/*------------------------------------------------------------------------
| Funcao    | ZRImpri  | Otavio Pinto                  | Data | 19/01/15  |
|-------------------------------------------------------------------------|
| Descricao | Relatorio para Controle de Estoque da Farmacia.             |
|           |                                                             |
 ------------------------------------------------------------------------*/

user function ZRImpri
private cPerg   := "CADZRD" 

ValidPerg()

If ! Pergunte(cPerg,.T.) ; 	Return(Nil) ; EndIf    

Processa({ ||IMP_REL2()},"Gerando Arquivo ... ")

Return Nil

/*
  IMP_REL2  
  Rotina de impressao
*/

static function IMP_REL2()
/*--------------------------------------------------------------------------
|  Define Variaveis                                                         |
 --------------------------------------------------------------------------*/
local wnrel
local cDesc1  := "Este programa tem como objetivo imprimir o cadastro"
local cDesc2  := "das movimentações do Estoque da Farmácia (ZRD/ZRE)"
local cDesc3  := ""
local cString := "ZRD"
local Tamanho := "M"

private cTitulo := "Controle do Estoque da Farmácia"
private cabec1
private cabec2
private aReturn := { "Zebrado", 1,"Administracao", 2, 2, 1, "",1 }
private cPerg   := ""
private nomeprog:= "CADZRD" 
private nLastKey:= 0


/*
+--------------------------------------------------+
| PARAMETROS UTILIZADOS                            |
+--------------------------------------------------+
|  01  |  Atendimento De      | mv_par01           |
|  02  |  Atendimento Ate     | mv_par02           |
|  03  |  Produto De          | mv_par03           |
|  04  |  Produto Ate         | mv_par04           |
+--------------------------------------------------+
*/

/*--------------------------------------------------------------------------
|  Definicao dos cabecalhos                                                 |
 --------------------------------------------------------------------------*/

cabec1:= "CODPRO          DESCRIÇÃO                                         QT.SOLIC. POSOL. QT.POSOL. UN.POSOL."
//        999999999999 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX   9999      XX      XX     9-XXXXXX 

//        XXXX>12<XXXX 999999>17<9999999  XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX>70<XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX   9999      99      99     9-XXXXXX     
cabec2:= "SEQ QT.LIB DT.LIB.  LOTE        NUMLOTE VALID   USUARIO              OBS. "  // QT.SOLIC. POSOL. QT.POSOL. UN.POSOL."
//        99  9999   99/99/99 XXXXXXXXXXX XXXXXX  99/99/99 XXXXXXXXXXXXXXXXXXXX XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX>100<XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

/*--------------------------------------------------------------------------
|  Envia controle para a funcao SETPRINT                                    |
 --------------------------------------------------------------------------*/
wnrel := "CADZRD"

wnrel := SetPrint(cString,wnrel,cPerg,@cTitulo,cDesc1,cDesc2,cDesc3,.F.,"",,Tamanho,,.F.)

If nLastKey == 27 ; return ; End

SetDefault(aReturn,cString)

If nLastKey == 27 ; return ( NIL ) ; End

RptStatus({|lEnd| ImpTipInt(@lEnd,wnRel,cString)},cTitulo)
Return


/*--------------------------------------------------------------------------
| Programa  | ImpTipInt | Autor | Otavio Pinto        | Data |  19/01/2015  |
|---------------------------------------------------------------------------|
| Descricao | Impressao do Controle do Estoque da Farmácia                  |
|           |                                                               |
|---------------------------------------------------------------------------|
| Uso       |                                                               | 
 --------------------------------------------------------------------------*/
static function ImpTipInt(lEnd,wnRel,cString)
local cbcont,cbtxt
local tamanho:= "M"
local nTipo 

/*--------------------------------------------------------------------------
|  Variaveis utilizadas para Impressao do Cabecalho e Rodape                |
 --------------------------------------------------------------------------*/
cbtxt    := SPACE(10)
cbcont   := 0
li       := 80
m_pag    := 1

nTipo    := GetMv("MV_COMP")
cMatric  := ""
cNomAss  := ""

dbSelectArea("BTH")
BTH->( dbSetOrder(1) )

dbSelectArea("ZRE")
ZRE->( dbSetOrder(1) )

dbSelectArea("ZRD")
ZRD->( dbSetOrder(1) )
SetRegua( ZRD->( RecCount() ) )
ZRD->( dbGotop() )
lTitulo := .T.

while ZRD->( !Eof() )
		
	IncRegua()

    // Filtro Atendimento
    if ! ZRD->(  ZRD_CODATE >= mv_par01 .AND. ZRD_CODATE <= mv_par02 )
       ZRD->( dbSkip() )
       Loop
    endif       
          
    // Filtro Codigo do Medicamento      
    if ! ZRD->(  ZRD_CODPRO >= mv_par03 .AND. ZRD_CODPRO <= mv_par04 )
       ZRD->( dbSkip() )
       Loop
    endif       

    /* Filtro Matricula
    if ! ZRD->(  ZRD_CODPRO >= mv_par03 .AND. ZRD_CODPRO <= mv_par04 )
       ZRD->( dbSkip() )
       Loop
    endif       
    */
    
    IF li > 58 ; CABEC(cTitulo,cabec1,cabec2,nomeprog,tamanho,nTipo) ; End

    /*--------------------------------------------------------------------------
    |  Vai na tabela BTH - Atendimento de Consultas para pegar a matricula e o  |
    |  nome do associado.                                                       |
     --------------------------------------------------------------------------*/

    if BTH->( dbSeek(xFILIAL("BTH")+ZRD->ZRD_CODATE) )
       cMatric  := BTH->BTH_CODPAC
       cNomAss  := BTH->BTH_NOMPAC
    endif   
    
    @ li,  000 PSAY PADR(ZRD->ZRD_CODATE       ,012," ") +Space(1)+ ;
                    PADR(cMatric               ,017," ") +Space(2)+ ;
                    PADR(cNomAss               ,070," ")
    li++	                
    zCODATE := ZRD->ZRD_CODATE               
    
    while  ZRD->( ZRD_CODATE == zCODATE .AND. !EOF() )
        // Filtro Codigo do Medicamento      
        if ! ZRD->(  ZRD_CODPRO >= mv_par03 .AND. ZRD_CODPRO <= mv_par04 )
           ZRD->( dbSkip() )
           Loop
        endif       
   
        cDescricao := ""
        if SB1->( dbSeek(xFILIAL("SB1")+ZRD->ZRD_CODPRO)  )
           cDescricao := SB1->B1_DESC
        endif
        @ li,  000 PSAY PADR(ZRD->ZRD_CODPRO       ,015," ") +Space(1)+ ;
                        PADR(cDescricao            ,050," ") +Space(3)+ ;        
                        PADR(STR(ZRD->ZRD_QTDSOL,4),004," ") +Space(6)+ ;
                        PADR(STR(ZRD->ZRD_POSOL ,2),002," ") +Space(6)+ ;
                        PADR(STR(ZRD->ZRD_QTDPOS,2),002," ") +Space(5)+ ;
                        PADR(IF ( ZRD->ZRD_UNIPOS == "1","1-Dia"   ,;
                             IF ( ZRD->ZRD_UNIPOS == "2","2-Hora"  ,;
                             IF ( ZRD->ZRD_UNIPOS == "3","3-Semana",;
                             IF ( ZRD->ZRD_UNIPOS == "4","4-Mes"   ,"" )))),008," ") 
 	    li ++
        if ZRE->( dbSeek(xFILIAL("ZRE")+ZRD->( ZRD_CODATE+ZRD_CODPRO) ) )   
           cCODATE := ZRE->ZRE_CODATE
           cCODPRO := ZRE->ZRE_CODPRO
           li++	
           nSoma := 0
           while ZRE->( cCODATE == ZRE_CODATE .AND. cCODPRO == ZRE_CODPRO .AND. !EOF() )
         
               // Filtro Codigo do Medicamento      
               if ! ZRE->(  ZRE_CODPRO >= mv_par03 .AND. ZRE_CODPRO <= mv_par04 )
                  ZRE->( dbSkip() )
                  Loop
               endif       
           
               @ li,  000 PSAY PADR(ZRE->ZRE_SEQ          ,002," ") +Space(2)+ ;
                               PADR(STR(ZRE->ZRE_QTDLIB,4),004," ") +Space(3)+ ;
                               PADR(DTOC(ZRE->ZRE_DTLIB)  ,008," ") +Space(1)+ ;
                               PADR(ZRE->ZRE_LOTE         ,010," ") +Space(1)+ ;
                               PADR(ZRE->ZRE_NUMLOTE      ,006," ") +Space(2)+ ;
                               PADR(DTOC(ZRE->ZRE_DTVAL)  ,008," ") +Space(1)+ ;
                               PADR(ZRE->ZRE_USLIB        ,020," ") +Space(1)+ ;
                               PADR(ZRE->ZRE_OBS          ,100," ")                           
               nSoma += ZRE->ZRE_QTDLIB 
               ZRE->( dbSkip() ) 
               li++	
           end        
           @ li,  000 PSAY "TOT "+PADR(STR(nSoma,4),004," ")
           li+=2
        else   
           @ li,  029 PSAY PADR("*** Não há movimentação para este atendimento... ***"  ,053," ")
           li+=2	
   	    endif
    
   	    ZRD->( dbSkip() )
    end
    @ li,  000 PSAY PADR("",220,"-") 
    li+=2
    
end

if li != 80 ; roda(cbcont,cbtxt,tamanho) ; End

/*--------------------------------------------------------------------------
|  Recupera a Integridade dos dados                                         |
 --------------------------------------------------------------------------*/
dbSelectArea("ZRD")

set device to Screen

if aReturn[5] == 1
   Set Printer To
   dbCommitAll()
   OurSpool(wnrel)
endif

MS_FLUSH()

return


/*-------------------------------------------------------------------------- 
| Funcao | ValidPerg     | Autor | Otavio Pinto          | Data | 31/01/2011|
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

AAdd(aRegs,{cPerg , "01" , "Atendimento De           ?" ,"","", "mv_ch1" , "C" ,12  , 0 ,0 , "G" , "" , "mv_par01" , ""      , "" , "" , ""      , "" , ""           , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "BTHMED" , "" })
AAdd(aRegs,{cPerg , "02" , "Atendimento Ate          ?" ,"","", "mv_ch2" , "C" ,12  , 0 ,0 , "G" , "" , "mv_par02" , ""      , "" , "" , ""      , "" , ""           , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "BTHMED" , "" })
AAdd(aRegs,{cPerg , "03" , "Produto De               ?" ,"","", "mv_ch3" , "C" ,15  , 0 ,0 , "G" , "" , "mv_par03" , ""      , "" , "" , ""      , "" , ""           , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "PLSB1M" , "" })
AAdd(aRegs,{cPerg , "04" , "Produto Ate              ?" ,"","", "mv_ch4" , "C" ,15  , 0 ,0 , "G" , "" , "mv_par04" , ""      , "" , "" , ""      , "" , ""           , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "PLSB1M" , "" })

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

/*----------------------------------------------------------------------------
|      Funcao: RetInfUsr()                                                    | 
|        Data: 04.03.2015                                                     | 
|    Objetivo: Retornar Dados do usuário copmo Id, Centro de Custo e Armazem  |
|      Author: Otavio Salvador Pinto                                          |
|  Parametros: <_cUsuario> Deve ser informado o login do usuario              |
|              Utilizar o cUserName que retorna o login corrente.             | 
|              <_nRet> Retorna Se 1 ID                                        |
|                                 2 Login                                     |
|                                 3 CCusto                                    | 
|                                 4 Descricao                                 |
|                                 5 Armazem                                   | 
|                                 6 Tipo Registro                             | 
|                                 7 Bloqueio                                  | 
 ----------------------------------------------------------------------------*/
user function RetInfUsr( _cUsuario, _nRet )
local aArea := GetArea()
local cRet :=  cMat := cCC := " "
_nRet := if( _nRet == Nil, 1, _nRet )
do case
   case _nRet == 1 //------------------ ID
        cRet := __cUserID
   case _nRet == 2 //------------------ Login
        cRet := _cUsuario 
   case _nRet == 3 .or. _nRet == 4 //--------------- 3 = CC / 4 = Descricao
        if !Empty( _cUsuario )
           PswOrder(2)
           if PswSeek( _cUsuario, .T. )
              cMat := substr(PSWRet(1)[1][22],3,8)
              cQry := "SELECT RA_CC FROM SRA010 WHERE D_E_L_E_T_ = ' ' AND RA_FILIAL||RA_MAT = '"+cMat+"'"    
              TCQuery cQry Alias "TMP" New
              dbSelectArea("TMP")
              TMP->( dbGoTop() )
              cCC := TMP->RA_CC
              TMP->( dbCloseArea() )

              cQry := " SELECT CTT_DESC01 FROM CTT010 WHERE D_E_L_E_T_ = ' ' AND CTT_FILIAL = '01' AND CTT_CUSTO = '"+cCC+"'"    
              TCQuery cQry Alias "TMP" New
              dbSelectArea("TMP")
              TMP->( dbGoTop() )
              cCCDesc := TMP->CTT_DESC01
              TMP->( dbCloseArea() )
              do case
                 case _nRet == 3 ; cRet := cCC
                 case _nRet == 4 ; cRet := cCCDesc
              endcase                            
           endif   
        endif
   case _nRet == 5 //------------------ Armazem
        cQry := "SELECT ZRK_ARMAZ FROM "+RetSQLName("ZRK")+" WHERE D_E_L_E_T_ = ' ' AND ZRK_ID = '"+__cUserID+"'"    
        TCQuery cQry Alias "TMP" New
        dbSelectArea("TMP")
        TMP->( dbGoTop() )
        cRet :=  TMP->ZRK_ARMAZ
        TMP->( dbCloseArea() )
   case _nRet == 6 //------------------ TIPO DE REGISTRO
        cQry := "SELECT ZRK_TIPO FROM "+RetSQLName("ZRK")+" WHERE D_E_L_E_T_ = ' ' AND ZRK_ID = '"+__cUserID+"'"    
        TCQuery cQry Alias "TMP" New
        dbSelectArea("TMP")
        TMP->( dbGoTop() )
        cRet :=  TMP->ZRK_TIPO
        TMP->( dbCloseArea() )
   case _nRet == 7 //------------------ Bloqueio
        cQry := "SELECT ZRK_BLOQ FROM "+RetSQLName("ZRK")+" WHERE D_E_L_E_T_ = ' ' AND ZRK_ID = '"+__cUserID+"'"    
        TCQuery cQry Alias "TMP" New
        dbSelectArea("TMP")
        TMP->( dbGoTop() )
        cRet :=  TMP->ZRK_BLOQ
        TMP->( dbCloseArea() )
        
endcase        
RestArea(aArea)

return (cRet)


// Fim da rotina CABA568.PRW
