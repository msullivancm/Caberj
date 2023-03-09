#Include "PROTHEUS.CH"

User Function RDMBA()

Private aRotina := {}
Private cCadastro := "Boletim de Atendimento"
Private cAlias1 := "SZX"                    // Alias da Enchoice.
Private cAlias2 := "SZY"                    // Alias da GetDados.  

PRIVATE aCdCores  	:= { 	{ 'BR_VERMELHO'    ,'Atendimento Caberj' },;
						      	{ 'BR_AMARELO'     ,'Atendimento Telefonico' },;
									{ 'BR_VERDE'       ,'Convocacao' },;
						  			{ 'BR_LARANJA'     ,'Visita Domiciliar' },;
						  			{ 'BR_PRETO'       ,'Visita A Instituicao' },;
									{ 'BR_AZUL'     	 ,'Visita Hospitalar' }}
PRIVATE aCores      := { { 'ZX_TPATEND = "1"',aCdCores[1,1] },;
                         { 'ZX_TPATEND = "3"',aCdCores[2,1] },;
                         { 'ZX_TPATEND = "4"',aCdCores[3,1] },;
                         { 'ZX_TPATEND = "5"',aCdCores[4,1] },;
                         { 'ZX_TPATEND = "6"',aCdCores[5,1] },;
                         { 'ZX_TPATEND = "7"',aCdCores[6,1] }}  

AAdd(aRotina, {"Pesquisar" , "AxPesqui"  , 0, 1})
AAdd(aRotina, {"Visualizar", "u_TM3Manut", 0, 2})
AAdd(aRotina, {"Incluir"   , "u_TM3Manut", 0, 3})
AAdd(aRotina, {"Alterar"   , "u_TM3Manut", 0, 4})
AAdd(aRotina, {"Excluir"   , "u_TM3Manut", 0, 5})
AAdd(aRotina, {"Legenda"   , "u_BAIMPLEG", 0, 6})  
                                               
dbSelectArea(cAlias1)
dbOrderNickName("SEQ")
dbGoTop()

mBrowse(,,,,cAlias1, , , , , Nil    , aCores)

Return Nil

//----------------------------------------------------------------------------------------------------------------//
// Modelo 3.
//----------------------------------------------------------------------------------------------------------------//

User Function TM3Manut(cAlias, nReg, nOpc)

Local i        := 0
Local cLinOK   := "AllwaysTrue"
Local cTudoOK  := "u_TM3TudOK"
Local nOpcE    := nOpc
Local nOpcG    := nOpc
Local cFieldOK := "AllwaysTrue"
Local lVirtual := .T.
Local nLinhas  := 99
Local nFreeze  := 0
Local lRet     := .T. 
Local nSizeHd  := 190 // Altura da area para os campos de header 

Local oGetDad
Local oDlg                 
Local aObjects  := {}
Local aPosObj   := {}
Local aSizeAut  := MsAdvSize()  
Local nOpcA     := 0


PRIVATE aGETS   := {}
PRIVATE aTELA   := {}


Private aCols        := {}
Private aHeader      := {}
Private aCpoEnchoice := {}
Private aAltEnchoice := {}
Private aAlt         := {}

// Cria variaveis de memoria dos campos da tabela Pai.
// 1o. parametro: Alias do arquivo --> é case-sensitive, ou seja precisa ser como está no Dic.Dados.
// 2o. parametro: .T.              --> cria variaveis em branco, preenchendo com o inicializador-padrao.
//                .F.              --> preenche com o conteudo dos campos.
RegToMemory(cAlias1, (nOpc==3))

// Cria variaveis de memoria dos campos da tabela Filho.
RegToMemory(cAlias2, (nOpc==3))

CriaHeader(nOpc)

CriaCols(nOpc)

aObjects := {}
AAdd( aObjects, { 315,  50, .T., .T. } )
AAdd( aObjects, { 100, 25, .T., .T. } )

aInfo := { aSizeAut[ 1 ], aSizeAut[ 2 ], aSizeAut[ 3 ], aSizeAut[ 4 ], 3, 3 }
aPosObj := MsObjSize( aInfo, aObjects, .T. )

DEFINE MSDIALOG oDlg TITLE cCadastro From aSizeAut[7],00 To aSizeAut[6],aSizeAut[5] OF oMainWnd PIXEL
EnChoice( cAlias,nReg, nOpc, , , , , aPosObj[1], , 3 )
oGetDad := MSGetDados():New (aPosObj[2,1], aPosObj[2,2], aPosObj[2,3], aPosObj[2,4], nOpc, "U_TM3TudOK" ,"AllwaysTrue","", (nopc = 3 .or. nopc = 4))

//ACTIVATE MSDIALOG oDlg ON INIT EnchoiceBar(oDlg,{ || IIF( OBRIGATORIO(AGETS,ATELA) .And. TudoOk() .and. ValidBA(), (nOpca := 1, oDlg:END()), nOpca := 0) }, { || oDlg:END() })  // em 08.08.2012 - OSP
ACTIVATE MSDIALOG oDlg ON INIT EnchoiceBar(oDlg,{ || IIF( OBRIGATORIO(AGETS,ATELA) .And. TudoOk() , (nOpca := 1, oDlg:END()), nOpca := 0) }, { || oDlg:END() })



If nOpca == 1
   If      nOpc == 3
           If MsgYesNo("Confirma a gravação dos dados?", cCadastro)
              Processa({||GrvDados()}, cCadastro, "Gravando os dados, aguarde...")
           EndIf
    ElseIf nOpc == 4
           If MsgYesNo("Confirma a alteração dos dados?", cCadastro)
              Processa({||AltDados()}, cCadastro, "Alterando os dados, aguarde...")
           EndIf
    ElseIf nOpc == 5
           If MsgYesNo("Confirma a exclusão dos dados?", cCadastro)
              Processa({||ExcDados()}, cCadastro, "Excluindo os dados, aguarde...")
           EndIf

   EndIf
 Else
   RollBackSX8()
EndIf

Return Nil

//----------------------------------------------------------------------------------------------------------------//
Static Function CriaHeader(nOpc)

aHeader      := {}
aCpoEnchoice := {}
aAltEnchoice := {}

// aHeader é igual ao do Modelo2.

dbSelectArea("SX3")
dbSetOrder(1)
dbSeek(cAlias2)

While !SX3->(EOF()) .And. SX3->X3_Arquivo == cAlias2

   If X3Uso(SX3->X3_Usado)    .And.;                  // O Campo é usado.
      cNivel >= SX3->X3_Nivel .And.;                  // Nivel do Usuario é maior que o Nivel do Campo.
      Trim(SX3->X3_Campo) $ "ZY_SEQBA/ZY_SEQSERV/ZY_DTSERV/ZY_HORASV/ZY_TIPOSV/ZY_SERV/ZY_OBS/ZY_USDIGIT"

      AAdd(aHeader, {Trim(SX3->X3_Titulo),;
                     SX3->X3_Campo       ,;
                     SX3->X3_Picture     ,;
                     SX3->X3_Tamanho     ,;
                     SX3->X3_Decimal     ,;
                     SX3->X3_Valid       ,;
                     SX3->X3_Usado       ,;
                     SX3->X3_Tipo        ,;
                     SX3->X3_Arquivo     ,;
                     SX3->X3_Context})

   EndIf

   SX3->(dbSkip())

End

// Campos da Enchoice.

dbSelectArea("SX3")
dbSetOrder(1)
dbSeek(cAlias1)

While !SX3->(EOF()) .And. SX3->X3_Arquivo == cAlias1

   If X3Uso(SX3->X3_Usado)    .And.;                  // O Campo é usado.
      cNivel >= SX3->X3_Nivel                         // Nivel do Usuario é maior que o Nivel do Campo.

      // Campos da Enchoice.
      AAdd(aCpoEnchoice, X3_Campo)

      // Campos da Enchoice que podem ser editadas.
      // Se tiver algum campo que nao deve ser editado, nao incluir aqui.
      AAdd(aAltEnchoice, X3_Campo)

   EndIf

   SX3->(dbSkip())

End  

If nOpc == 3
  M->ZX_SEQ := GetSx8Num("SZX","ZX_SEQ")
  ConfirmSx8()
Endif  

Return Nil

//----------------------------------------------------------------------------------------------------------------//
Static Function CriaCols(nOpc)

Local nQtdCpo := 0
Local i       := 0
Local nCols   := 0

nQtdCpo := Len(aHeader)
aCols   := {}
aAlt    := {}

If nOpc == 3       // Inclusao.

   AAdd(aCols, Array(nQtdCpo+1))

   For i := 1 To nQtdCpo
       aCols[1][i] := CriaVar(aHeader[i][2])
   Next

   aCols[1][nQtdCpo+1] := .F.

 Else

   dbSelectArea(cAlias2)
   dbOrderNickName("SEQBA")  // ZY_FILIAL+ZY_SEQBA                                                                                                                                             
   dbSeek(xFilial(cAlias2) + (cAlias1)->ZX_SEQ)

   While !EOF() .And. (cAlias2)->ZY_Filial == xFilial(cAlias2) .And. (cAlias2)->ZY_SEQBA == (cAlias1)->ZX_SEQ

      AAdd(aCols, Array(nQtdCpo+1))
      nCols++

      For i := 1 To nQtdCpo
          If aHeader[i][10] <> "V"
             aCols[nCols][i] := FieldGet(FieldPos(aHeader[i][2]))
           Else
             aCols[nCols][i] := CriaVar(aHeader[i][2], .T.)
          EndIf
      Next

      aCols[nCols][nQtdCpo+1] := .F.

      AAdd(aAlt, Recno())

      dbSelectArea(cAlias2)
      dbSkip()

   End

EndIf
 
Return Nil
 
//----------------------------------------------------------------------------------------------------------------//
Static Function GrvDados()

Local bCampo := {|nField| Field(nField)}
Local i      := 0
Local y      := 0
Local nItem  := 1//0

ProcRegua(Len(aCols) + FCount())


//+--------------------------------------------------------------------------------------------------------+
//|Conforme Chamado 2563, uma das solicitacoes pede para nao permitir gravar com o Tipo de Servicos VAZIO. |
//|por OSP em 18.06.2012 16:21                                                                             |
//+--------------------------------------------------------------------------------------------------------+

begin sequence

For i := 1 To len(aCols)
   if empty( aCols[i][5] )
      MsgInfo("O campo TIPO SERVICO nao esta preenchido... Verifique !!!", cCadastro + " nao gravado")       
      break
   endif 
next

// Grava o registro da tabela Pai, obtendo o valor de cada campo
// a partir da var. de memoria correspondente.

dbSelectArea(cAlias1)
RecLock(cAlias1, .T.)
For i := 1 To FCount()
    IncProc()
    //+--------------------------------------------------------------------------------------------------------+
    //|Alterei a rotina para forcar a gravacao da Data e Hora de saida do sistema (ZX_DATATE e ZX_HORATE)      |
    //|por OSP em 08.08.2012 11:46                                                                             |
    //+--------------------------------------------------------------------------------------------------------+
    do case 
       case "FILIAL"  $ FieldName(i) ; FieldPut(i, xFilial(cAlias1))
       case "DATATE"  $ FieldName(i) ; FieldPut(i, DATE() )		     
       case "HORATE"  $ FieldName(i) ; FieldPut(i, SUBSTR(TIME(),1,2)+SUBSTR(TIME(),4,2) )		     		   
       case "YCUSTO"  $ FieldName(i) ; FieldPut(i, BuscaCC( AllTrim (cUserName), 1 ) ) // Acrescentei esta linha Em 20.08.2012 - OSP	 
       case "YAGENC"  $ FieldName(i) ; FieldPut(i, BuscaCC( AllTrim (cUserName), 2 ) ) // Acrescentei esta linha Em 20.08.2012 - OSP		
    otherwise  
       FieldPut(i, M->&(Eval(bCampo,i)))
    end case    
   
   // Esta era a rotina original - OSP
   *If "FILIAL" $ FieldName(i)
   *   FieldPut(i, xFilial(cAlias1))
   *Else
   *   FieldPut(i, M->&(Eval(bCampo,i)))
   *EndIf 
Next
MSUnlock()

// Grava os registros da tabela Filho.

dbSelectArea(cAlias2)
dbOrderNickName("SEQBA")

For i := 1 To Len(aCols)

    IncProc()

    If !aCols[i][Len(aHeader)+1]       // A linha nao esta deletada, logo, pode gravar.

       RecLock(cAlias2, .T.)

       For y := 1 To Len(aHeader)
           FieldPut(FieldPos(Trim(aHeader[y][2])), aCols[i][y])
       Next
       
       SZY->ZY_Filial := xFilial("SZY")
       SZY->ZY_SEQBA   := SZX->ZX_SEQ 
       SZY->ZY_SEQSERV := StrZero(nItem, 6, 0)
       nItem++
       //SZY->ZY_SEQSERV := GetSx8Num("SZY","ZY_SEQSERV")
       //ConfirmSx8()

       MSUnlock()

    EndIf

Next

end sequence

Return Nil

//----------------------------------------------------------------------------------------------------------------//
Static Function AltDados()

Local i      := 0
Local y      := 0
Local nItem  := 0

ProcRegua(Len(aCols) + FCount())

//+--------------------------------------------------------------------------------------------------------+
//|Conforme Chamado 2563, uma das solicitacoes pede para nao permitir gravar com o Tipo de Servicos VAZIO. |
//|por OSP em 18.06.2012 16:21                                                                             |
//+--------------------------------------------------------------------------------------------------------+

begin sequence

For i := 1 To len(aCols)
   if empty( aCols[i][5] )
      MsgInfo("O campo TIPO SERVICO nao esta preenchido... Verifique !!!", cCadastro + " nao gravado")       
      break
   endif 
next

dbSelectArea(cAlias1)
RecLock(cAlias1, .F.)

For i := 1 To FCount()
    IncProc()
    If "FILIAL" $ FieldName(i)
       FieldPut(i, xFilial(cAlias1))
     Else
       FieldPut(i, M->&(fieldname(i)))
    EndIf
Next
MSUnlock()
    
dbSelectArea(cAlias2)
dbOrderNickName("SEQBA")

nItem := Len(aAlt) + 1

For i := 1 To Len(aCols)

    If i <= Len(aAlt)

       dbGoTo(aAlt[i])
       RecLock(cAlias2, .F.)

       If aCols[i][Len(aHeader)+1]
          dbDelete()
        Else
          For y := 1 To Len(aHeader)
              FieldPut(FieldPos(Trim(aHeader[y][2])), aCols[i][y])
          Next
       EndIf

       MSUnlock()

     Else

       If !aCols[i][Len(aHeader)+1]
          RecLock(cAlias2, .T.)
          For y := 1 To Len(aHeader)
              FieldPut(FieldPos(Trim(aHeader[y][2])), aCols[i][y])
          Next
          (cAlias2)->ZY_Filial := xFilial(cAlias2)
          (cAlias2)->ZY_SEQBA := (cAlias1)->ZX_SEQ
          (cAlias2)->ZY_SEQSERV := StrZero(nItem, 6, 0)
          MSUnlock()
          nItem++
       EndIf

    EndIf

Next

end sequence

Return Nil

//----------------------------------------------------------------------------------------------------------------//
Static Function ExcDados()

ProcRegua(Len(aCols)+1)   // +1 é por causa da exclusao do arq. de cabeçalho.

dbSelectArea(cAlias2)
dbOrderNickName("SEQBA")
dbSeek(xFilial(cAlias2) + (cAlias1)->ZX_SEQ)

While !EOF() .And. (cAlias2)->ZY_Filial == xFilial(cAlias2) .And. (cAlias2)->ZY_SEQBA == (cAlias1)->ZX_SEQ
   IncProc()
   RecLock(cAlias2, .F.)
   dbDelete()
   MSUnlock()
   dbSkip()
End

dbSelectArea(cAlias1)
dbOrderNickName("SEQ")
IncProc()
RecLock(cAlias1, .F.)
dbDelete()
MSUnlock()

Return Nil

//----------------------------------------------------------------------------------------------------------------//
User Function TM3TudOK()

Local lRet := .T.
Local i    := 0
Local nDel := 0

For i := 1 To Len(aCols)
    If aCols[i][Len(aHeader)+1]
       nDel++
    EndIf
Next

If nDel == Len(aCols)
   MsgInfo("Para excluir todos os itens, utilize a opção EXCLUIR", cCadastro)
   lRet := .F.
EndIf     

Return lRet 

//-------------------------------------------------------------------------------------------------------------//
Static Function ValidBA()

Local lRet := .T.

If (M->ZX_DATDE < M->ZX_DATATE) 
  lRet := .T.
Else       
  If (M->ZX_DATDE = M->ZX_DATATE)     
    If (M->ZX_HORADE <= M->ZX_HORATE)  
      lRet := .T.   
    Else  
      lRet := .F. 
    Endif  
  Else  
    lRet := .F.   
  Endif   
Endif

If !lRet
  MsgAlert("Data/Hora De posterior a Data/Hora Ate !!")
Endif  
      
      
Return lRet

//-------------------------------------------------------------------------------------------------------------//
User Function BAIMPLEG 
Local aLegenda                            


aLegenda := {  	{ aCdCores[1,1],aCdCores[1,2] },;
	            { aCdCores[2,1],aCdCores[2,2] },;
    	   	   	{ aCdCores[3,1],aCdCores[3,2] },;
    	   	   	{ aCdCores[4,1],aCdCores[4,2] },;
    	   	   	{ aCdCores[5,1],aCdCores[5,2] },;
    	   	   	{ aCdCores[6,1],aCdCores[6,2] }  }
       	               	
BrwLegenda(cCadastro,"Status" ,aLegenda)

Return



/*
    Funcao: BuscaCC
      Data: 20.08.2012
  Objetivo: Retornar Centro de Custo e Descricao, a partir do nome do usuario (login)
            para preenchimento dos campo ZX_YCUSTO e ZX_YAGENC. Estes campos estao sendo 
            utilizados no Relatorio de BA (Crystal)- RESBAS.RPT
    Author: Otavio Salvador Pinto
Parametros: <_cUsuario> Deve ser informado o login do usuario - Utilizar o cUserName que 
            retorna o login corrente.
            <_nRet> Se 1, retorna o Centro de Custo, do contrario retorna a Descricao
*/
static function BuscaCC( _cUsuario, _nRet )
local aArea := GetArea()
local cRet :=  cMat := cCC := " "
_nRet := if( _nRet == Nil, 1, _nRet )
if !Empty( _cUsuario )
   PswOrder(2)
   if PswSeek( _cUsuario, .T. )
      cMat := PSWRet(1)[1][22]
      cCC := Posicione ( "SRA" , 1 , substr(cMat,3,Len(cMat)-2) , "RA_CC" )   
      cRet := if ( _nRet == 1, cCC, Posicione ( "CTT" , 1 , xFilial("CTT")+cCC , "CTT_DESC01" ) )
   endif   
endif
RestArea(aArea)

return (cRet)
