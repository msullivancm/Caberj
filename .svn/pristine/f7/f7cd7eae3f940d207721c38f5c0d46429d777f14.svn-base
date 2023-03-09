#Include "PROTHEUS.CH"

User Function RDMPRTPRJ()

Private aRotina := {}
Private cCadastro := "Protocolo de Projeto"
Private cAlias1 := "PA8"                    // Alias da Enchoice.
Private cAlias2 := "PA9"                    // Alias da GetDados.

PRIVATE aCdCores  	:= { 	{ 'BR_VERMELHO'    ,'Nao Autorizado ' },;
							{ 'BR_VERDE'       ,'Autorizado ' },;
							{ 'BR_AMARELO'     ,'Em Andamento ' },;
							{ 'BR_LARANJA'     ,'Projeto(Opcional) Bloqueado ' },;     
							{ 'BR_AZUL'        ,'AED ' }}

PRIVATE aCores      := { { '!(PA8_PRODES $ "0024,0038") .AND. PA8_AUTORI == "N"',aCdCores[1,1] },;
                         { '!(PA8_PRODES $ "0024,0038") .AND. (PA8_AUTORI == "S" .AND. EMPTY(PA8_DTBLOQ))',aCdCores[2,1] },;
                         { '!(PA8_PRODES $ "0024,0038") .AND. PA8_AUTORI == " "',aCdCores[3,1] },;
                         { '!(PA8_PRODES $ "0024,0038") .AND. !EMPTY(PA8_DTBLOQ)',aCdCores[4,1] },;
                         { 'PA8_PRODES $ "0024,0038"',aCdCores[5,1] }}

AAdd(aRotina, {"Pesquisar" , "AxPesqui"  , 0, 1})
AAdd(aRotina, {"Visualizar", "u_PPJManut", 0, 2})
AAdd(aRotina, {"Incluir"   , "u_PPJManut", 0, 3})
AAdd(aRotina, {"Alterar"   , "u_PPJManut", 0, 4})                               

AAdd(aRotina, {"Excluir"   , "u_PPJManut", 0, 5})
AAdd(aRotina, {"Bloquear"  , "u_PPJBloqu", 0, 6})   

AAdd(aRotina, {"Marc. Risco AED"  , "u_PPJMRAED", 0, 7})   // Motta Abril/16                 
AAdd(aRotina, {"Legenda"   , "u_PPIMPLEG", 0, 8})   // Motta Abril/16   

dbSelectArea(cAlias1)
dbOrderNickName("NUMPRO")
dbGoTop()

mBrowse(,,,,cAlias1, , , , , Nil    , aCores)

Return Nil

//----------------------------------------------------------------------------------------------------------------//
// Modelo 3.
//----------------------------------------------------------------------------------------------------------------//

User Function PPJManut(cAlias, nReg, nOpc)

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

//lRet := Modelo3(cCadastro, cAlias1, cAlias2, aCpoEnchoice, cLinOK, cTudoOK, nOpcE, nOpcG, cFieldOK, lVirtual, nLinhas, aAltEnchoice, nFreeze,,,nSizeHd) 

aObjects := {}
AAdd( aObjects, { 315,  50, .T., .T. } )
AAdd( aObjects, { 100, 25, .T., .T. } )

aInfo := { aSizeAut[ 1 ], aSizeAut[ 2 ], aSizeAut[ 3 ], aSizeAut[ 4 ], 3, 3 }
aPosObj := MsObjSize( aInfo, aObjects, .T. )

DEFINE MSDIALOG oDlg TITLE cCadastro From aSizeAut[7],00 To aSizeAut[6],aSizeAut[5] OF oMainWnd PIXEL
EnChoice( cAlias,nReg, nOpc, , , , , aPosObj[1], , 3 )
oGetDad := MSGetDados():New (aPosObj[2,1], aPosObj[2,2], aPosObj[2,3], aPosObj[2,4], nOpc, "AllwaysTrue" ,"AllwaysTrue","", (nopc = 3 .or. nopc = 4))

ACTIVATE MSDIALOG oDlg ON INIT EnchoiceBar(oDlg,{ || IIF( OBRIGATORIO(AGETS,ATELA) .And. u_PPJTudOK(), (nOpca := 1, oDlg:END()), nOpca := 0) }, { || oDlg:END() })

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
      Trim(SX3->X3_Campo) $ "PA9_FILIAL,PA9_NUMPRO,PA9_NUMSE,PA9_TAREFA,PA9_DESTAR,PA9_USUDE,PA9_USUATE,PA9_DATA,PA9_STATUS,PA9_PRIORI,PA9_RESP1,PA9_RESP2,PA9_RESP3,PA9_RESP4,PA9_RESP5"
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
  M->PA8_NUMPRO := GetSx8Num("PA8","PA8_NUMPRO")
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
   dbOrderNickName("PROSEQ")  // PA9_FILIAL,PA9_NUMPRO,PA9_NUMSEQ
   dbSeek(xFilial(cAlias2) + (cAlias1)->PA8_NUMPRO)

   While !EOF() .And. (cAlias2)->PA9_FILIAL == xFilial(cAlias2) .And. (cAlias2)->PA9_NUMPRO == (cAlias1)->PA8_NUMPRO

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

// Grava o registro da tabela Pai, obtendo o valor de cada campo
// a partir da var. de memoria correspondente.

dbSelectArea(cAlias1)
RecLock(cAlias1, .T.)
For i := 1 To FCount()
    IncProc()
    If "FILIAL" $ FieldName(i)
       FieldPut(i, xFilial(cAlias1))
     Else
       FieldPut(i, M->&(Eval(bCampo,i)))
    EndIf
Next
MSUnlock()

// Grava os registros da tabela Filho.

dbSelectArea(cAlias2)
dbOrderNickName("PROSEQ")

For i := 1 To Len(aCols)

    IncProc()

    If !aCols[i][Len(aHeader)+1]       // A linha nao esta deletada, logo, pode gravar.

       RecLock(cAlias2, .T.)

       For y := 1 To Len(aHeader)
           FieldPut(FieldPos(Trim(aHeader[y][2])), aCols[i][y])
       Next

       PA9->PA9_FILIAL := xFilial("PA9")
       PA9->PA9_NUMPRO   := PA8->PA8_NUMPRO
       PA9->PA9_NUMSEQ := StrZero(nItem, 3, 0)
       nItem++

       MSUnlock()

    EndIf

Next

Return Nil

//----------------------------------------------------------------------------------------------------------------//
Static Function AltDados()

Local i      := 0
Local y      := 0
Local nItem  := 0

ProcRegua(Len(aCols) + FCount())

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
dbOrderNickName("PROSEQ")

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
          (cAlias2)->PA9_FILIAL := xFilial(cAlias2)
          (cAlias2)->PA9_NUMPRO := (cAlias1)->PA8_NUMPRO
          (cAlias2)->PA9_NUMSEQ := StrZero(nItem, 3, 0)
          MSUnlock()
          nItem++
       EndIf

    EndIf

Next

Return Nil

//----------------------------------------------------------------------------------------------------------------//
Static Function ExcDados()

//-- VERIFICA SE ESTA ENCERRADO 
If M->PA8_NUMPRO == PA8->PA8_NUMPRO
  If PA8->PA8_AUTORI != " "
    Alert("Protocolo ja encerrado, não permite exclusao")
    Return Nil
  Endif
Endif  

ProcRegua(Len(aCols)+1)   // +1 é por causa da exclusao do arq. de cabeçalho.

dbSelectArea(cAlias2)
dbOrderNickName("PROSEQ")
dbSeek(xFilial(cAlias2) + (cAlias1)->PA8_NUMPRO)

While !EOF() .And. (cAlias2)->PA9_FILIAL == xFilial(cAlias2) .And. (cAlias2)->PA9_NUMPRO == (cAlias1)->PA8_NUMPRO
   IncProc()
   RecLock(cAlias2, .F.)
   dbDelete()
   MSUnlock()
   dbSkip()
End

dbSelectArea(cAlias1)
dbOrderNickName("NUMPRO")
IncProc()
RecLock(cAlias1, .F.)
dbDelete()
MSUnlock()

Return Nil

//----------------------------------------------------------------------------------------------------------------//
User Function PPJTudOK()

Local lRet := .T.
Local i    := 0
Local nDel := 0
Local aMatVal := {}    

For i := 1 To Len(aCols)
    If aCols[i][Len(aHeader)+1]
       nDel++
    EndIf
Next

If nDel == Len(aCols)
   MsgInfo("Para excluir todos os itens, utilize a opção EXCLUIR", cCadastro)
   lRet := .F.
EndIf

//-- VERIFICA SE ESTA ENCERRADO 
If M->PA8_NUMPRO == PA8->PA8_NUMPRO
  If PA8->PA8_AUTORI != " "
    Alert("Protocolo ja encerrado ("+PA8->PA8_AUTORI+"), nao permite edicao ")
    lRet := .F.
  Endif
Endif  

//-- INCLUINDO NO PROJETO
If lRet
  If M->PA8_AUTORI == "S"
    //Obtendo a mat atual
    aMatVal := U_RetMatVal(M->PA8_MATVID) 
    If Empty(aMatVal)     
      lRet := .F.   
    Else
	    //-Checando o Nupre
	    If !U_ValPrjNpr(aMatVal,M->PA8_PRODES)  //22/06/2011
	      lRet := .F.
	    Endif
	    //Insere no Projeto
	    If lRet
	      If Len(aMatVal) > 0 
	        If (U_VlPrjPla(aMatVal[1][7],M->PA8_PRODES)) /*motta dez/19 PLANO , PROJETO*/
	          U_InsPrtProj (aMatVal,M->PA8_PRODES,M->PA8_VPRDES,M->PA8_NUPRE,M->PA8_DTAUTO,M->PA8_CODLOC)
	        Else
	          lRet := .F. 
	        Endif  
	      Else
	        Alert("Vida sem contrato valido")
	        lRet := .F.                                                                             
	      Endif
	    Endif
	    If lRet
	      If !(u_pa8dtat())
	        Alert("Data invalida")
	        lRet := .F.    
	      Endif
	    Endif 
	Endif    
  Endif
Endif

Return lRet

//-------------------------------------------------------------------------------------------------------------//
User Function PPIMPLEG
Local aLegenda


aLegenda := {   	{ aCdCores[1,1],aCdCores[1,2] },;
	                { aCdCores[2,1],aCdCores[2,2] } ,;
	                { aCdCores[3,1],aCdCores[3,2] } ,;
	                { aCdCores[4,1],aCdCores[4,2] } ,;
	                { aCdCores[5,1],aCdCores[5,2] } }

BrwLegenda(cCadastro,"Status" ,aLegenda)

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³VldAltTar ºMotta  ³CABERJ              º Data ³  06/08/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Valida alteração de campos de Tarefa                       º±±
±±º          ³ Chamada no Edicao dos campos                               º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/


User Function VldAltTar

Local lVldAltTar := .F.
Local nLinTar    := 0


nLinTar := Len(aCols)
//PERMITE A EDICAO APENAS SE O USUATE DO REGISTRO ANTERIOR FOR DO USER OU A 1@ INCLUSAO  
//NOPADO POIS A USUÁRIO NÃO QUER ESTE CONTROLE
//If nLinTar > 1
//  cUserAnt := Alltrim(ACOLS[(nLinTar-1),aScan(aHeader,{|x| AllTrim(x[2]) == "PA9_USUATE"})])
//  lVldIncTar := (cUserAnt = Alltrim(cusername))
//Else
  lVldIncTar := .T.
//Endif

//PERMITE A ALTERACAO/EXCLUSAO APENAS AO USUARIO DIGITADOR (USUDE)
If lVldIncTar
  lVldAltTar := ((!ALTERA) .OR. (Alltrim(M->PA9_USUDE) = Alltrim(CUSERNAME)) .OR. (Upper(Alltrim(cusername)) $ "ADMINISTRADOR"))
Endif

Return (lVldIncTar .OR. lVldAltTar)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ VldUsuTarºMotta  ³Caberj              º Data ³  11/08/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Verifica se o usuario informado e valido                   º±±
±±º          ³ Chamada no valid do campo                                  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function VldUsuTar(cUserTar)

Local aUserTar := {}
Local lUsuVal     := .T.

PswOrder(2)
If PswSeek(cUserTar, .T. )
  aUserTar := PswRet() // Retorna vetor com informacoes do usuario
EndIf
lUsuVal := (Len(aUserTar) > 0)
If !lUsuVal
  Alert("Usuario nao existe")
Endif

Return lUsuVal


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ RetMatValºMotta  ³Caberj              º Data ³  12/08/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Localiza Mat (ba1) valida para insersao no                 º±±
±±º          ³ Projeto(Produto)                                           º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±ºem out/21 tratar data futura                                           º±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function RetMatVal (cMatVid)

Local aMatVal := {}  
LOCAL cProjeto := Space(0)
LOCAL lTemAED := .F. 
LOCAL lMigMatOk := .T.    

BA1->(DbSetOrder(7))
BA1->(dbSeek(xFilial("BA1")+cMatVid))
While BA1->BA1_MATVID == cMatVid .and. ! BA1->(Eof())
	If AllTrim(cEmpAnt) == "01"  //Inicio alteração Renato Peixoto. So vai fazer a validacao de planos abaixo se a empresa for a Caberj ("01")
		If (Empty(BA1->BA1_DATBLO) .OR. BA1->BA1_DATBLO > dDataBase) .AND. Empty(BA1->BA1_YMTODO)//Motta out/21
			aAdd(aMatVal,{BA1->BA1_CODINT,BA1->BA1_CODEMP,BA1->BA1_MATRIC,BA1->BA1_TIPREG,BA1->BA1_DIGITO,BA1->BA1_DATINC,BA1->BA1_CODPLA})//Motta 5/4/12
			If BF4->(MsSeek(xFilial("BF4")+BA1->BA1_CODINT+BA1->BA1_CODEMP+BA1->BA1_MATRIC+BA1->BA1_TIPREG))
				While BF4->(BF4_CODINT+BF4_CODEMP+BF4_MATRIC+BF4_TIPREG) == BA1->BA1_CODINT+BA1->BA1_CODEMP+BA1->BA1_MATRIC+BA1->BA1_TIPREG .And. !BF4->(Eof())
					If ((BF4->BF4_CODPRO $ GetNewPar("MV_YPLAED","0024,0038,0041") ) .OR.; 
				        (BF4->BF4_CODPRO == "0060") .OR. ;//0060 AAG INTERIOR (agora eh o novo VDS)
					    (BF4->BF4_CODPRO == GetNewPar("MV_XCODMT","0083"))) //MATURIDADE 06/14
						If Empty(BF4->BF4_DATBLO) .Or. (!Empty(BF4->BF4_DATBLO) .And. (BF4->BF4_DATBLO > dDataBase))
							If BI3->(MsSeek(xFilial("BI3")+BF4->BF4_CODINT+BF4->BF4_CODPRO))
								cProjeto := AllTrim(BI3->BI3_NREDUZ)+", "
							EndIf
							lTemAED := .T.     
							If M->PA8_PRODES == GetNewPar("MV_XCODMT","0083")
								If lMigMatOk 
								    //verifica se não está no aag na inclusão do maturidade 
									lMigMatOk := !((Empty(BF4->BF4_DATBLO) .Or. (!Empty(BF4->BF4_DATBLO) .And. (BF4->BF4_DATBLO > M->PA8_DTAUTO))))    
								Endif 
							Endif			               
						Endif
					Endif
					BF4->(DbSkip())
				Enddo
			Endif
			
		Else
			//inicio alteração Renato Peixoto em 27/07/12. Tratamento para beneficiarios itau, que passaram a ter o opcional 0060
			If (Empty(BA1->BA1_DATBLO) .OR. BA1->BA1_DATBLO > dDataBase) .AND. Empty(BA1->BA1_YMTODO)//Motta out/21
				aAdd(aMatVal,{BA1->BA1_CODINT,BA1->BA1_CODEMP,BA1->BA1_MATRIC,BA1->BA1_TIPREG,BA1->BA1_DIGITO,BA1->BA1_DATINC,BA1->BA1_CODPLA})//Motta 5/4/12
				If BF4->(MsSeek(xFilial("BF4")+BA1->BA1_CODINT+BA1->BA1_CODEMP+BA1->BA1_MATRIC+BA1->BA1_TIPREG))
					While BF4->(BF4_CODINT+BF4_CODEMP+BF4_MATRIC+BF4_TIPREG) == BA1->BA1_CODINT+BA1->BA1_CODEMP+BA1->BA1_MATRIC+BA1->BA1_TIPREG .And. !BF4->(Eof())
						If BF4->BF4_CODPRO == "0060" //0060 AAG INTERIOR (agora eh o novo VDS
							If Empty(BF4->BF4_DATBLO) .Or. (!Empty(BF4->BF4_DATBLO) .And. (BF4->BF4_DATBLO > dDataBase))
								If BI3->(MsSeek(xFilial("BI3")+BF4->BF4_CODINT+BF4->BF4_CODPRO))
									cProjeto := AllTrim(BI3->BI3_NREDUZ)+", "
								EndIf
								lTemAED := .T.
							Endif
						Endif
						BF4->(DbSkip())
					Enddo
				Endif
				
			EndIf
			//Fim alteração Renato Peixoto.
		EndIf
		
		If lTemAED 
		    //Gerar erro somente na autorizacao (caso esteja em projeto)  
		    //verifica maturidade
		    If ((M->PA8_AUTORI == "S") .AND. (M->PA8_PRODES == GetNewPar("MV_XCODMT","0083")))
		    	If !lMigMatOk 
		     		Aviso( "Usuario Cadastrado em Projeto","A T E N C A O! Este usuario e participante do projeto "+cProjeto+"!!! "+;
		     	           " Inclusao no Maturidade não permitida !!!",{ "Ok" }, 2 )  
		     		Return {} 
		    	else
					Aviso( "Usuario Cadastrado em Projeto","A T E N C A O! Este usuario e participante do projeto "+cProjeto+"!!!",{ "Ok" }, 2 )
		    	Endif
		    else
				Aviso( "Usuario Cadastrado em Projeto","A T E N C A O! Este usuario e participante do projeto "+cProjeto+"!!!",{ "Ok" }, 2 )
		    Endif
		Endif
		
		BA1->(DbSkip())
	Else //caso seja Integral Saude nao precisa fazer essa validacao de plano abaixo...  Renato Peixoto em 11/05/12 Corrigido por Motta em 15/6/12
		If (Empty(BA1->BA1_DATBLO) .OR. BA1->BA1_DATBLO > dDataBase) .AND. Empty(BA1->BA1_YMTODO)//Motta 16/12/20
			aAdd(aMatVal,{BA1->BA1_CODINT,BA1->BA1_CODEMP,BA1->BA1_MATRIC,BA1->BA1_TIPREG,BA1->BA1_DIGITO,BA1->BA1_DATINC,BA1->BA1_CODPLA})//Motta 5/4/12
			If BF4->(MsSeek(xFilial("BF4")+BA1->BA1_CODINT+BA1->BA1_CODEMP+BA1->BA1_MATRIC+BA1->BA1_TIPREG))
				While BF4->(BF4_CODINT+BF4_CODEMP+BF4_MATRIC+BF4_TIPREG) == BA1->BA1_CODINT+BA1->BA1_CODEMP+BA1->BA1_MATRIC+BA1->BA1_TIPREG .And. !BF4->(Eof())
					BF4->(DbSkip())
				Enddo
			Endif
			
			//If lTemAED
			//  Aviso( "Usuario Cadastrado em Projeto","A T E N C A O! Este usuario e participante do projeto "+cProjeto+"!!!",{ "Ok" }, 2 )
		Endif

		BA1->(DbSkip())

	Endif
	
EndDo


Return aMatVal

User Function VlPrjPla(cCodPla,cCodPrj)
//
// valida plano x projeto 
// Motta DEZ/19
// 
Local lRet := .F.
  
  BT3->(DbSetOrder(1))	
  If !BT3->(DbSeek(xFilial("BT3")+"0001"+cCodPla+"001"+cCodPrj+"001"))
	lRet := .F.
	Aviso( "Plano Usuario Projeto","A T E N C A O! Plano Usuario "+cCodPla+" nao permite Projeto "+cCodPrj+"!!!",{ "Ok" }, 2 )
  Else
  	lRet := .T.
  EndIf

Return lRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³InsPrtProjºMotta  ³Caberj              º Data ³  12/08/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Insersao no Projeto(Produto)                               º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function InsPrtProj (aMatVal,cCodPro,cVerPro,cNupre,dDataInc,cCodLoc)//Motta 10/7/14   

Local dDataHist := CTOD("  /  /  ")
Local cNupreOld    := " "


DbSelectArea("BF4")
BF4->(DbSetOrder(1))
BF4->(dbSeek(xFilial("BF4")+aMatVal[1][1]+aMatVal[1][2]+aMatVal[1][3]+aMatVal[1][4]+cCodPro))
If BF4->(BF4_CODINT+BF4_CODEMP+BF4_MATRIC+BF4_TIPREG+BF4_CODPRO) == aMatVal[1][1]+aMatVal[1][2]+aMatVal[1][3]+aMatVal[1][4]+cCodPro
  BF4->( RecLock("BF4", .F.) )
  BF4->BF4_RGIMP  := "1"
  BF4->BF4_MOTBLO := "047" // Alterar para o Motivo de Cancelamento de Mudança de Nupre  
  dDataHist       := BF4->BF4_DATBLO 
  cNupreOld       := BF4->BF4_YNUPRE
  BF4->BF4_DATBLO := CTOD("  /  /  ") 
  // Historico
  DbSelectArea("BGU")
  RecLock("BGU", .T.)
  BGU->BGU_FILIAL := xFilial("BGU")   
  BGU->BGU_MATRIC      := aMatVal[1][1]+aMatVal[1][2]+aMatVal[1][3]
  BGU->BGU_TIPREG      := aMatVal[1][4] 
  If Empty(dDataHist)
    BGU->BGU_TIPO        := "0"
    BGU->BGU_DATA        := dDataHist
    BGU->BGU_MOTBLO      := "029"
    If AllTrim(cEmpAnt) == "01" //so alimentar esse campo se a empresa for Caberj, pois o campo ainda sera criado na integral... Renato Peixoto em 15/05/12
    	BGU->BGU_YNUPRE      := cNupreOld   // 22/06/2011
    EndIf //Fim alteracao Renato Peixoto
  Else     
    BGU->BGU_TIPO        := "1"
    BGU->BGU_DATA        := FirstDay(dDataInc) // Primeiro dia do Mes // 11/abril/2011
    BGU->BGU_MOTBLO      := "047" // Alterar para o Motivo de Cancelamento de Mudança de Nupre   
    If AllTrim(cEmpAnt) == "01" //so alimentar esse campo se a empresa for Caberj, pois o campo ainda sera criado na integral... Renato Peixoto em 15/05/12
    	BGU->BGU_YNUPRE      := cNupre     // 22/06/2011
    EndIf //Fim alteracao Renato Peixoto
  Endif
  BGU->BGU_USUOPE      := cUsername
  BGU->BGU_CODPRO      := cCodPro
  BGU->BGU_VERSAO      := cVerPro      
  
  
  BGU->( MsUnlock() )
Else
  BF4->( RecLock("BF4", .T.) )
Endif
BF4->BF4_FILIAL := xFilial("BF4")
BF4->BF4_CODINT := aMatVal[1][1]
BF4->BF4_CODEMP := aMatVal[1][2]
BF4->BF4_MATRIC := aMatVal[1][3]
BF4->BF4_TIPREG := aMatVal[1][4]
// manter BF4->BF4_DATBAS 27/04/2011 
If Empty(dDataHist)   
  //IF cCodPro $ "0024/0038"  
  IF !(cCodPro $ "0041") /* Motta 7/1/20*/
    BF4->BF4_DATBAS	:= dDataInc // Data informada  
  Else
    BF4->BF4_DATBAS	:= FirstDay(dDataInc) // Primeiro dia do Mes    
  End If  
Endif
BF4->BF4_CODPRO := cCodPro
BF4->BF4_VERSAO := cVerPro
BF4->BF4_TIPVIN := "0"
BF4->BF4_RGIMP  := "1"
BF4->BF4_YNUPRE := cNupre
BF4->BF4_YCODLC := cCodLoc // Motta 10/7/15      
//pdg     ABRIR A DIGITAÇÃO ? 
If AllTrim(cEmpAnt) == "01"  
  IF cCodPro = "0137" 
    BF4->BF4_CODRDA  := GetNewPar("MV_XRDAPDG","133205") 
  Endif
Else  
  IF cCodPro = "0116"       
    BF4->BF4_CODRDA  := GetNewPar("MV_XRDAPDG","133205") 
  Endif
Endif 
	
BF4->( MsUnlock() ) 

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ValPrtPrj ºMotta  ³Caberj              º Data ³  12/08/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Validar Produto                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function ValPrtPrj(cCodPro,cVersao)

Local lRet := .F.

BI3->(DbSetOrder(1))
BI3->(dbSeek(xFilial("BI3")+"0001"+cCodPro+cVersao))
While BI3->BI3_CODIGO+BI3->BI3_VERSAO == cCodPro+cVersao .and. ! BA1->(Eof())
  lRet := (BI3->BI3_CODIGO+BI3->BI3_VERSAO == cCodPro+cVersao)     
  If lRet
    lRet := (BI3->BI3_GRUPO == "002")  //MATURIDADE 06/14 ESTE TESTE FALTAVA TODAVIA    
  Endif
  BI3->(DbSkip())
EndDo

If !lRet
  Alert("Produto/versao ("+cCodPro+"/"+cVersao+") invalidos ")
Endif

Return lRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ValPrjNpr ºMotta  ³Caberj              º Data ³  13/08/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Validar Nupre x Produto                                    º±±
±±º          ³ 22/06/2011 cCodPro                                         º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±        
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function ValPrjNpr (aMat,cCodPro)   

Local lRet := .T.
Local lQue := .F. 
Local cSQL := " " 
Local nQTD := 0

 // Para o produto AAG obriga EXISTIR O QUESTIONARIO RESPONDIDO
 If M->PA8_PRODES == GetNewPar("MV_XCODAAG","0041") 
   BXA->(DbSetOrder(3))
   BXA->(dbSeek(xFilial("BXA")+aMat[1][1]+aMat[1][2]+aMat[1][3]+aMat[1][4]+aMat[1][5]))
   While BXA->(BXA_USUARI) == aMat[1][1]+aMat[1][2]+aMat[1][3]+aMat[1][4]+aMat[1][5] .OR. ! BXA->(Eof())
  	 If BXA->(BXA_USUARI) == aMat[1][1]+aMat[1][2]+aMat[1][3]+aMat[1][4]+aMat[1][5]
    	If BXA->(BXA_PROQUE+BXA_CODQUE) == GetNewPar("MV_XQUEAAG","20002")
      		lQue := .T.
   		Endif
   Endif          
   BXA->(DbSkip())
  EndDo

  If !lQue
    Alert("Para o Projeto AAG é obrigatorio o usuario ja ter respondido a Ficha !!") 
    lRet := lQue 
  Endif
  //  
  
  If lRet
    DbSelectArea("BF4")
    BF4->(DbSetOrder(1))
    BF4->(dbSeek(xFilial("BF4")+aMat[1][1]+aMat[1][2]+aMat[1][3]+aMat[1][4]+cCodPro))
      If BF4->(BF4_CODINT+BF4_CODEMP+BF4_MATRIC+BF4_TIPREG+BF4_CODPRO) == aMat[1][1]+aMat[1][2]+aMat[1][3]+aMat[1][4]+cCodPro
        If EMPTY(BF4->BF4_DATBLO) 
          Alert("Projeto ativo para o Assistido !!") 
          lRet := .F.
        Endif   
      Endif      
  Endif   
  
  If lRet    
  //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
  //³verifica se faturamento do NUPRE foi carregada, caso positivo não permite mais a inclusão no Projeto pois o mesmo                                     ³
  //|já foi fechado na referencia                                                                                                                          ³
  //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
 
	cSQL := "SELECT SIGN(COUNT(*)) QTD " 
  	cSQL += "FROM   BD6010  , PA6010 " 
  	cSQL += "WHERE  BD6_FILIAL = '  ' " 
  	cSQL += "AND    BD6_OPEUSR = '0001' " 
  	cSQL += "AND    BD6_ANOPAG = '" + Substr(DTOS(M->PA8_DTAUTO),1,4) + "' " 
  	cSQL += "AND    BD6_MESPAG = '" + Substr(DTOS(M->PA8_DTAUTO),5,2) + "' "  
  	cSQL += "AND    BD6_CODPAD = '01' "
  	cSQL += "AND    BD6_CODPRO = '" + GETMV("MV_XPROAAG") + "' "  
  	cSQL += "AND    BD6_FASE = '4' " 
  	cSQL += "AND    PA6_FILIAL = '  ' " 
  	cSQL += "AND    PA6_CODNUP = '" + M->PA8_NUPRE + "' "
  	cSQL += "AND    BD6_CODRDA = PA6_CODRDA " 
  	cSQL += "AND    BD6010.D_E_L_E_T_ = ' ' " 
  	cSQL += "AND    PA6010.D_E_L_E_T_ = ' ' " 
  	cSQL := ChangeQuery(cSQL)
  	PLSQuery(cSQL,"BDAAG")  
  	DbSelectArea("BDAAG")
  	BDAAG->(DbGotop())
  	While ! BDAAG->( Eof() )  
    	nQTD := BDAAG->QTD
    	BDAAG->(DbSkip())
  	Enddo
  	BDAAG->(DbCloseArea())   
  	If nQTD == 1
    	Alert("Para este Nupre não é mais possível incluir nesta data !!") 
    	lRet := .F.
  	Endif 
  Endif
Endif
// Para o produto AAG obriga informar o Nupre
If lRet
  lRet := ((M->PA8_PRODES != GetNewPar("MV_XCODAAG","0041")) .OR. (M->PA8_PRODES == GetNewPar("MV_XCODAAG","0041") .AND. M->PA8_NUPRE $ "1,2,3"))
  If !lRet 
    Alert("Informe o Nupre !!")
  Endif    
Endif  

// Motta 20/7/15
// Para o produto MAT obriga informar o Local
If lRet
  lRet := ((M->PA8_PRODES != GetNewPar("MV_XCODMT","0083")) .OR. (M->PA8_PRODES == GetNewPar("MV_XCODMT","0083") .AND. M->PA8_CODLOC $ "056|058|059|" ))
  If !lRet 
    Alert("Informe um Local valido !!")
  Endif    
Endif      
// Fim Motta 20/7/15

// VALIDA DATA PROJETO X DATA USUARIO - Motta 5/4/12
If lRet
  lRet := ((aMat[1][6] <= M->PA8_DTAUTO).OR. (Upper(Alltrim(cusername)) $ "ADMINISTRADOR"))
  If !lRet 
    Alert("Data do Opcional " + DToC(M->PA8_DTAUTO) + " anterior a Data de Inclusao do Usuario " + DToC(aMat[1][6]) + " !!")
  Endif    
Endif

Return lRet


/*BEGINDOC
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄH¿
//³Chamadas deos Inicializadores padrao dos campos de descrição³
//³dos projetos (tamanho)                                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄHÙ
ENDDOC*/

User Function IPDPSOL

cRet := ""

cRet := IIF(INCLUI,"",POSICIONE("BI3",1,XFILIAL("BI3")+"0001"+PA8->PA8_PROSOL+PA8->PA8_VPRSOL,"BI3_NREDUZ"))

Return cRet

User Function IBWPSOL

cRet := ""

cRet := POSICIONE("BI3",1,XFILIAL("BI3")+"0001"+PA8->PA8_PROSOL+PA8->PA8_VPRSOL,"BI3_NREDUZ")

Return cRet


User Function IPDPDES

cRet := ""

cRet := IIF(INCLUI,"",POSICIONE("BI3",1,XFILIAL("BI3")+"0001"+PA8_PRODES+PA8_VPRDES,"BI3_NREDUZ"))

Return cRet

//
User Function IBWPDES

cRet := ""

cRet := POSICIONE("BI3",1,XFILIAL("BI3")+"0001"+PA8->PA8_PRODES+PA8_VPRDES,"BI3_NREDUZ")

Return cRet 

//
// Bloqueia o Opcional
//
User Function PPJBloqu()

Local dDatBlo := LastDay(dDataBase)
Local cMotBlo := "   "    
Local dDtCheck

Local o_MotBlo
Local o_DatBlo
Local c_Opc := 0   

Static oDlg
                    

// Cria variaveis de memoria dos campos da tabela Pai.
// 1o. parametro: Alias do arquivo --> é case-sensitive, ou seja precisa ser como está no Dic.Dados.
// 2o. parametro: .T.              --> cria variaveis em branco, preenchendo com o inicializador-padrao.
//                .F.              --> preenche com o conteudo dos campos.
RegToMemory(cAlias1, .F.)

If ! (MsgYesNo("Confirma bloqueio do Projeto(Opcional) para " + trim(M->PA8_NOMUSR) + " ?", cCadastro))
  Return Nil
End if

If M->PA8_AUTORI != "S"
  MsgAlert("Apenas Protocolos Migrados podem ser bloqueados !")
  Return Nil
End If    

If M->PA8_PRODES == " "
  MsgAlert("Apenas Protocolos Migrados com produto destino podem ser bloqueados !")
  Return Nil
End If                           

BA1->(DbSetOrder(7))
BA1->(dbSeek(xFilial("BA1")+M->PA8_MATVID))
While BA1->BA1_MATVID == M->PA8_MATVID .and. ! BA1->(Eof())
  If AllTrim(cEmpAnt) == "01" //Inicio da alteracao Renato Peixoto em 11/05/12
   //	If ((Empty(BA1->BA1_DATBLO)) .AND. (BA1->BA1_CODPLA $ "0001,0002,0003,0004,0005,0006,0007,0008,0018,0042,0043,0063,0064,0065,0092,0094,0095,0098,0099,0096,0097")) // Produtos validos para Projeto
   	If ((BA1->BA1_CODPLA $ "0001,0002,0003,0004,0005,0006,0007,0008,0018,0042,0043,0063,0064,0071,0072,0073,0065,0092,0094,0095,0098,0099,0096,0097,0088")) // Produtos validos para Projeto
		 If BF4->(MsSeek(xFilial("BF4")+BA1->BA1_CODINT+BA1->BA1_CODEMP+BA1->BA1_MATRIC+BA1->BA1_TIPREG))
			While BF4->(BF4_CODINT+BF4_CODEMP+BF4_MATRIC+BF4_TIPREG) == BA1->BA1_CODINT+BA1->BA1_CODEMP+BA1->BA1_MATRIC+BA1->BA1_TIPREG .And. !BF4->(Eof())
				If BF4->BF4_CODPRO == M->PA8_PRODES
					If Empty(BF4->BF4_DATBLO) 
					
					    //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³pesquisa a ultima fatura do nupre, adiciona um mes (padrao faturamento) p/ verificar se pode  ³
						//³bloquear o opcional/programa                                                                  ³
						//|alterado em maio/2013 mudança pgto CP                                                         ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						
						cSQL := "SELECT TO_CHAR(ADD_MONTHS(TO_DATE(MAX(SUBSTR(PAE_COMPET,3,4)||SUBSTR(PAE_COMPET,1,2)),'YYYYMM'),1),'DD/MM/YY') DTBSBL " 
						cSQL += "FROM   PAE010 PAE, PA6010 PA6  " 
						cSQL += "WHERE  PAE_FILIAL = '  '  " 
						cSQL += "AND    PA6_FILIAL = '  '  " 
						cSQL += "AND    PA6_CODNUP =   '" + BF4->BF4_YNUPRE + "' "
						cSQL += "AND    PAE_CODNUP = PA6_CODRDA  " 
						cSQL += "AND    PA6_CODRDA <> '136204' "  //--TRATAR MILHAS , POIS NAO E CP
						cSQL += "AND    PAE.D_E_L_E_T_ = ' '  " 
						cSQL += "AND    PA6.D_E_L_E_T_ = ' '  " 
						cSQL += "  " 
						cSQL := ChangeQuery(cSQL)
						PLSQuery(cSQL,"BLOQ")  
						DbSelectArea("BLOQ")
						BLOQ->(DbGotop())
						While ! BLOQ->( Eof() )  
						 dDtCheck := ctod(BLOQ->DTBSBL)
						 BLOQ->(DbSkip())
					    Enddo   
						BLOQ->(DbCloseArea()) 
    	
						DEFINE MSDIALOG oDlg FROM 0,0 TO 300,600 TITLE OemToAnsi("Data e Motivo de Bloqueio.") PIXEL  //"Liberacao do PC"
    	
    					@ 026, 006 GROUP oGroup1 TO 191, 291 OF oDlg COLOR 0, 12632256 PIXEL
  		  				@ 037, 012 SAY oSay1  PROMPT "Mt.Bloq."             SIZE 025, 007 OF oDlg COLORS 0, 12632256 PIXEL
  		  				@ 051, 012 SAY oSay2  PROMPT "Dt.Bloq."          SIZE 025, 007 OF oDlg COLORS 0, 16777215 PIXEL

  		  				@ 036, 061 MSGET o_MotBlo  VAR cMotBlo  F3 "BG3TRA" VALID EXISTCPO("BG3",cMotBlo,1)                                           SIZE 060, 010 OF oDlg PIXEL
  		                //@ 050, 061 MSGET o_DatBlo  VAR dDatBlo              VALID ((dDatBlo >= dDtCheck .AND. dDatBlo <= Lastday(dDtCheck)) .OR. (Upper(Alltrim(cusername)) == "ADMINISTRADOR")) SIZE 087, 010 OF oDlg  PIXEL
    	                @ 050, 061 MSGET o_DatBlo  VAR dDatBlo              VALID ((dDatBlo >= dDtCheck .AND. dDatBlo <= Lastday(dDtCheck)) .OR. Upper(AllTrim(GetNewPar('MV_XPRJDAT','ADMINISTRADOR')))) SIZE 087, 010 OF oDlg  PIXEL
    	                //SOLUCAO PROVISORIA PARA PERMITIR MIGRACAO MATURIDADE+
    	                
    	                
    	                EnchoiceBar(oDlg, {|| c_Opc:= 1, oDlg:End()}, {||c_Opc:= 2, oDlg:End()},,)

  	    	            ACTIVATE MSDIALOG oDlg CENTERED  
  	                                    
        	            If c_Opc == 1
	        	            BF4->( RecLock("BF4", .F.) )              
	        	            BF4->BF4_MOTBLO := cMotBlo
	        	            BF4->BF4_DATBLO := dDatBlo
		 			        DbSelectArea("BGU")
	        	            RecLock("BGU", .T.)
	        	            BGU->BGU_FILIAL := xFilial("BGU")
	        	            BGU->BGU_MATRIC := BA1->BA1_CODINT+BA1->BA1_CODEMP+BA1->BA1_MATRIC
	        	            BGU->BGU_TIPREG := BA1->BA1_TIPREG
	  					    BGU->BGU_TIPO   := "0"
	        	            BGU->BGU_DATA   := dDatBlo
	        	            BGU->BGU_MOTBLO := cMotBlo
	  					    BGU->BGU_USUOPE := cUsername
	        	            BGU->BGU_CODPRO := M->PA8_PRODES
	        	            BGU->BGU_VERSAO := M->PA8_VPRDES
	        	            If AllTrim(cEmpAnt) == "01" //so alimentar esse campo se a empresa for Caberj, pois o campo ainda sera criado na integral... Renato Peixoto em 15/05/12
	        	            	BGU->BGU_YNUPRE := BF4->BF4_YNUPRE 
	        	            EndIf //Fim alteracao Renato Peixoto
	        	            BGU->( MsUnlock() )  
	        	            BF4->( MsUnlock() )
	                    
	        	            dbSelectArea(cAlias1)
							RecLock(cAlias1, .F.)
							PA8->PA8_DTBLOQ := dDataBase  
	        	            MSUnlock()
	        	            MsgAlert("Projeto(Opcional) bloqueado !")  
	        	       Endif     
                    
			   		Endif
				Endif
				BF4->(DbSkip())                                                          
			Enddo
	 	Endif
	  Endif
	  BA1->(DbSkip())
	Else//nao precisa fazer a validacao de plano abaixo quando a empresa for a Integral Saude. Renato Peixoto em 11/10/12
	//If ((Empty(BA1->BA1_DATBLO)) .AND. (BA1->BA1_CODPLA $ "0001,0002,0003,0004,0005,0006,0007,0008,0018,0042,0043")) // Produtos validos para Projeto
		If BF4->(MsSeek(xFilial("BF4")+BA1->BA1_CODINT+BA1->BA1_CODEMP+BA1->BA1_MATRIC+BA1->BA1_TIPREG))
			While BF4->(BF4_CODINT+BF4_CODEMP+BF4_MATRIC+BF4_TIPREG) == BA1->BA1_CODINT+BA1->BA1_CODEMP+BA1->BA1_MATRIC+BA1->BA1_TIPREG .And. !BF4->(Eof())
				If BF4->BF4_CODPRO == M->PA8_PRODES
					If Empty(BF4->BF4_DATBLO)
        	
						DEFINE MSDIALOG oDlg FROM 0,0 TO 300,600 TITLE OemToAnsi("Data e Motivo de Bloqueio.") PIXEL  //"Liberacao do PC"
        	
    					@ 026, 006 GROUP oGroup1 TO 191, 291 OF oDlg COLOR 0, 12632256 PIXEL
    					@ 037, 012 SAY oSay1  PROMPT "Mt.Bloq."             SIZE 025, 007 OF oDlg COLORS 0, 12632256 PIXEL
    					@ 051, 012 SAY oSay2  PROMPT "Dt.Bloq."          SIZE 025, 007 OF oDlg COLORS 0, 16777215 PIXEL
        	
    					@ 036, 061 MSGET o_MotBlo  VAR cMotBlo  F3 "BG3TRA" VALID EXISTCPO("BG3",cMotBlo,1)                                           SIZE 060, 010 OF oDlg PIXEL
        	            @ 050, 061 MSGET o_DatBlo  VAR dDatBlo              VALID ((dDatBlo >= FirstDay(dDatabase) .AND. dDatBlo <= LastDay(dDatabase)) .OR. (Upper(Alltrim(cusername)) == "ADMINISTRADOR")) SIZE 087, 010 OF oDlg  PIXEL
        	            EnchoiceBar(oDlg, {|| c_Opc:= 1, oDlg:End()}, {||c_Opc:= 2, oDlg:End()},,)

  	    	            ACTIVATE MSDIALOG oDlg CENTERED  
  	                                    
        	            If c_Opc == 1
	    	                BF4->( RecLock("BF4", .F.) )              
	    	                BF4->BF4_MOTBLO := cMotBlo
	    	                BF4->BF4_DATBLO := dDatBlo
			 		        DbSelectArea("BGU")
	    	                RecLock("BGU", .T.)
	    	                BGU->BGU_FILIAL := xFilial("BGU")
	    	                BGU->BGU_MATRIC := BA1->BA1_CODINT+BA1->BA1_CODEMP+BA1->BA1_MATRIC
	    	                BGU->BGU_TIPREG := BA1->BA1_TIPREG
	  					    BGU->BGU_TIPO   := "0"
	    	                BGU->BGU_DATA   := dDatBlo
	    	                BGU->BGU_MOTBLO := cMotBlo
	  					    BGU->BGU_USUOPE := cUsername
	    	                BGU->BGU_CODPRO := M->PA8_PRODES
	    	                BGU->BGU_VERSAO := M->PA8_VPRDES
	    	                If AllTrim(cEmpAnt) == "01" //so alimentar esse campo se a empresa for Caberj, pois o campo ainda sera criado na integral... Renato Peixoto em 15/05/12
	    	                	BGU->BGU_YNUPRE := BF4->BF4_YNUPRE 
	    	                EndIf //Fim alteracao Renato Peixoto
	    	                BGU->( MsUnlock() )  
	    	                BF4->( MsUnlock() )
	                    
	    	                dbSelectArea(cAlias1)
							RecLock(cAlias1, .F.)
							PA8->PA8_DTBLOQ := dDataBase  
	    	                MSUnlock()
	    	                MsgAlert("Projeto(Opcional) bloqueado !")  
	    	           Endif     
                    
					Endif
				Endif
				BF4->(DbSkip())                                                          
			Enddo
		Endif
  	//Endif
  		BA1->(DbSkip())
  	EndIf //Fim alteração Renato Peixoto
EndDo

Return Nil                       


//valida pa8_dtauto
User Function pa8dtat                                                

Local lRet := .T.  

// 05/03/2012 Paulo Motta permitir ao Admin inserir outras datas                      

// SOLUCAOO PROVISÓRIA PARA PERMITIR A MIGRAÇÃO DO MATURIDADE  - MOTTA

If ((M->PA8_PRODES == GetNewPar("MV_XCODAAG","0041")) .OR.;
    (M->PA8_PRODES == GetNewPar("MV_XCODMT","0083"))) //MATURIDADE 06/14
  //lRet := (M->PA8_DTAUTO == FirstDay(LastDay(DDATABASE) + 1)) .OR. (Upper(Alltrim(cusername)) == "ADMINISTRADOR")  //1 DIA PROXIMO MES 
  //lRet := (M->PA8_DTAUTO == FirstDay(LastDay(DDATABASE) + 1)) .OR. (Upper(Alltrim(cusername)) $ "ADMINISTRADOR/ANDREA.LEAO/SERGIO.CUNHA/MOTTA/LARISSA.LOBO/MARTHA/MARCELA.SANTOS/MARCUS.VINICIUS/VINICIUS.COSTA/ANNE.ROSA")  //1 DIA PROXIMO MES
   //SERGIO CUNHA - 10/10/2019 - CHAMADO 62647 
   lRet := (M->PA8_DTAUTO == FirstDay(LastDay(DDATABASE) + 1)) .OR. AllTrim(Upper(cUserName)) $ Upper((GetNewPar('MV_XPRJDAT','ADMINISTRADOR'))) //1 DIA PROXIMO MES
Else  
  //lRet := (M->PA8_DTAUTO == FirstDay(LastDay(DDATABASE) + 1)) .OR. (Upper(Alltrim(cusername)) == "ADMINISTRADOR")  //1 DIA PROXIMO MES 
  //lRet := (M->PA8_DTAUTO == FirstDay(LastDay(DDATABASE) + 1)) .OR. (Upper(Alltrim(cusername)) $ "ADMINISTRADOR/ANDREA.LEAO/SERGIO.CUNHA/MOTTA/LARISSA.LOBO/MARTHA/MARCELA.SANTOS/MARCUS.VINICIUS/VINICIUS.COSTA/ANNE.ROSA")  //1 DIA PROXIMO MES 
  //SERGIO CUNHA - 10/10/2019 - CHAMADO 62647 
  lRet := (M->PA8_DTAUTO == FirstDay(LastDay(DDATABASE) + 1)) .OR.  AllTrim(Upper(cUserName)) $ Upper(AllTrim(GetNewPar('MV_XPRJDAT','ADMINISTRADOR'))) //1 DIA PROXIMO MES
 // 1 DIA MES ATUAL
End If      

Return lRet         

User Function PPJMRAED()    

Local cCompl := " "

Local c_Opc := 0   
//------------------------------------
//Variaveis para o Combo
//------------------------------------
Private _aItems	:= {}  
Private _cCombo	:= "" 
Private _oCombo	:= Nil    
Private _cTGet 	:= space(TamSx3("BAU_CODIGO")[1])
Private _oTGet 	:= Nil    
Private _cDesTGet := space(TamSx3("BAU_NOME")[1])

Static oDlg                    

// Cria variaveis de memoria dos campos da tabela Pai.
// 1o. parametro: Alias do arquivo --> é case-sensitive, ou seja precisa ser como está no Dic.Dados.
// 2o. parametro: .T.              --> cria variaveis em branco, preenchendo com o inicializador-padrao.
//                .F.              --> preenche com o conteudo dos campos.
RegToMemory(cAlias1, .F.)


If (Upper(Alltrim(cusername)) $ GetNewPar("MV_YCPXAED","MOTTA;SANDROT;JOAO.GOMES;ADMINISTRADOR;ANDREA.LEAO;MOTTA;LARISSA.LOBO;MARTHA;MARCELA.SANTOS;SERGIO.CUNHA;FELIPE.DIAS;MARCUS.VINICIUS;VINICIUS.COSTA/ANNE.ROSA/DANIEL.SILVA"))    
  _aItems	:= {'B=BAIXA','M-MEDIA','A=ALTA'} 
Else
  _aItems	:= {'B=BAIXA','M-MEDIA'}   
Endif 
_cCombo	:= _aItems[1]  

If !(M->PA8_PRODES $ "0024/0038/0138/0137/0116/0129") 
  MsgAlert("Projeto nao e AED/Palliare/PGD !!")
  Return Nil
Endif

If ! (MsgYesNo("Confirma Alteracao nivel de Risco AED/Palliare/PGD " + trim(M->PA8_NOMUSR) + " ?", cCadastro))
  Return Nil
Endif                          

BA1->(DbSetOrder(7))
BA1->(dbSeek(xFilial("BA1")+M->PA8_MATVID))
While BA1->BA1_MATVID == M->PA8_MATVID .and. ! BA1->(Eof())
  If AllTrim(cEmpAnt) == "01" 
  	If ((Empty(BA1->BA1_DATBLO))) // Produtos validos para Projeto
		 If BF4->(MsSeek(xFilial("BF4")+BA1->BA1_CODINT+BA1->BA1_CODEMP+BA1->BA1_MATRIC+BA1->BA1_TIPREG))
			While BF4->(BF4_CODINT+BF4_CODEMP+BF4_MATRIC+BF4_TIPREG) == BA1->BA1_CODINT+BA1->BA1_CODEMP+BA1->BA1_MATRIC+BA1->BA1_TIPREG .And. !BF4->(Eof())
				If BF4->BF4_CODPRO == M->PA8_PRODES
					If Empty(BF4->BF4_DATBLO) 
					
					    //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³pesquisa a ultima AED paga               ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						
						cSQL := "SELECT TO_CHAR(ADD_MONTHS(TO_DATE(MAX(SUBSTR(PB2_COMPET,3,4)||SUBSTR(PB2_COMPET,1,2)),'YYYYMM'),1),'DD/MM/YY') DTAED " 
						cSQL += "FROM   PB2010 PB2  " 
						cSQL += "WHERE  PB2_FILIAL = '  '  " 
						cSQL += "AND    PB2.D_E_L_E_T_ = ' '  " 
						cSQL += "  " 
						cSQL := ChangeQuery(cSQL)
						PLSQuery(cSQL,"AED")  
						DbSelectArea("AED")
						AED->(DbGotop())
						While ! AED->( Eof() )  
						 dDtCheck := ctod(AED->DTAED)
						 AED->(DbSkip())
						Enddo   
						AED->(DbCloseArea())
						
						// check de data ? 
    	
						DEFINE MSDIALOG oDlg FROM 0,0 TO 300,600 TITLE OemToAnsi("Nivel de Risco") PIXEL  //"Liberacao do PC"   
						
						_oCombo:= tComboBox():New(47,006,{|u|if(PCount()>0,_cCombo:=u,_cCombo)},_aItems,100,20,oDlg,,,,,,.T.,,,,,,,,,'_cCombo')        
					
					    _oTGet    := TGet():New( 070,010,{|u| If( PCount() == 0, 	_cTGet	, _cTGet := u  )}	,nil,040,008,"@!",{||If(empty(_cTGet) .or. U_ValAED(_cTGet),.T.,.F.)},CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,,"_cTGet",,)
 					   	_oTGet:bF3 := &('{|| IIf(ConPad1(,,,"BAUPLS",,,.F.),Eval({|| _cTGet := BAU->BAU_CODIGO,_cDesTGet := BAU->BAU_NOME ,_oTGet:Refresh(),_oDesTGet:Refresh()}),.T.)}')
				 		_oDesTGet    := TGet():New( 090,006,{|u| If( PCount() == 0, 	_cDesTGet	, _cDesTGet := u  )}	,nil,151,008, ,,CLR_BLACK,CLR_GRAY,,,,.T.,"",,,.F.,.F.,,.T.,.F.,,"_cDesTGet",,)	
		
						    	
    					@ 026, 006 GROUP oGroup1 TO 191, 291 OF oDlg COLOR 0, 12632256 PIXEL
  		  				@ 037, 012 SAY oSay1  PROMPT "Nv Risco"          SIZE 025, 007 OF oDlg COLORS 0, 12632256 PIXEL      
  		  				
  		  				@ 060, 012 SAY oSay1  PROMPT "RDA"               SIZE 025, 007 OF oDlg COLORS 0, 12632256 PIXEL//motta 

  		  				//@ 036, 061 MSGET o_Compl  VAR cCompl             SIZE 060, 010 OF oDlg PIXEL  		               
    	                
    	                EnchoiceBar(oDlg, {|| c_Opc:= 1, oDlg:End()}, {||c_Opc:= 2, oDlg:End()},,)

  	    	            ACTIVATE MSDIALOG oDlg CENTERED     
  	    	            
  	    	            cCompl := Substr(_cCombo,1,1)     
  	    	            
  	                                    
        	            If c_Opc == 1
	        	            BF4->( RecLock("BF4", .F.) )              
	        	            BF4->BF4_YCOMPL := cCompl    
	        	            BF4->BF4_CODRDA := _cTGet
		 			        BF4->( MsUnlock() )
	                    
	        	            dbSelectArea(cAlias1)
							RecLock(cAlias1, .F.)
							//PA8->PA8_DTBLOQ := dDataBase ?! 
	        	            MSUnlock()
	        	            MsgAlert("Projeto(Opcional) alterado !")  
	        	        Endif     
                    
			   		Endif
				Endif
				BF4->(DbSkip())                                                          
			Enddo
	 	 Endif
  	EndIf         
  	BA1->(DbSkip())
  Else
    If ((Empty(BA1->BA1_DATBLO))) // Produtos validos para Projeto
		 If BF4->(MsSeek(xFilial("BF4")+BA1->BA1_CODINT+BA1->BA1_CODEMP+BA1->BA1_MATRIC+BA1->BA1_TIPREG))
			While BF4->(BF4_CODINT+BF4_CODEMP+BF4_MATRIC+BF4_TIPREG) == BA1->BA1_CODINT+BA1->BA1_CODEMP+BA1->BA1_MATRIC+BA1->BA1_TIPREG .And. !BF4->(Eof())
				If BF4->BF4_CODPRO == M->PA8_PRODES
					If Empty(BF4->BF4_DATBLO) 				
					    
						
						// check de data ? 
    	
						DEFINE MSDIALOG oDlg FROM 0,0 TO 300,600 TITLE OemToAnsi("Nivel de Risco") PIXEL  //"Liberacao do PC"   
						
						_oCombo:= tComboBox():New(47,006,{|u|if(PCount()>0,_cCombo:=u,_cCombo)},_aItems,100,20,oDlg,,,,,,.T.,,,,,,,,,'_cCombo')        
					
					    _oTGet    := TGet():New( 070,010,{|u| If( PCount() == 0, 	_cTGet	, _cTGet := u  )}	,nil,040,008,"@!",{||If(empty(_cTGet) .or. U_ValAED(_cTGet),.T.,.F.)},CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,,"_cTGet",,)
 					   	_oTGet:bF3 := &('{|| IIf(ConPad1(,,,"BAUPLS",,,.F.),Eval({|| _cTGet := BAU->BAU_CODIGO,_cDesTGet := BAU->BAU_NOME ,_oTGet:Refresh(),_oDesTGet:Refresh()}),.T.)}')
				 		_oDesTGet    := TGet():New( 090,006,{|u| If( PCount() == 0, 	_cDesTGet	, _cDesTGet := u  )}	,nil,151,008, ,,CLR_BLACK,CLR_GRAY,,,,.T.,"",,,.F.,.F.,,.T.,.F.,,"_cDesTGet",,)	
		
						    	
    					@ 026, 006 GROUP oGroup1 TO 191, 291 OF oDlg COLOR 0, 12632256 PIXEL
  		  				@ 037, 012 SAY oSay1  PROMPT "Nv Risco"          SIZE 025, 007 OF oDlg COLORS 0, 12632256 PIXEL      
  		  				
  		  				@ 060, 012 SAY oSay1  PROMPT "RDA"               SIZE 025, 007 OF oDlg COLORS 0, 12632256 PIXEL//motta 

  		  				//@ 036, 061 MSGET o_Compl  VAR cCompl             SIZE 060, 010 OF oDlg PIXEL  		               
    	                
    	                EnchoiceBar(oDlg, {|| c_Opc:= 1, oDlg:End()}, {||c_Opc:= 2, oDlg:End()},,)

  	    	            ACTIVATE MSDIALOG oDlg CENTERED     
  	    	            
  	    	            cCompl := Substr(_cCombo,1,1)       	    	            
  	                                    
        	            If c_Opc == 1
	        	            BF4->( RecLock("BF4", .F.) )              
	        	            BF4->BF4_YCOMPL := cCompl    
	        	            BF4->BF4_CODRDA := _cTGet
		 			        BF4->( MsUnlock() )
	                    
	        	            dbSelectArea(cAlias1)
							RecLock(cAlias1, .F.)
							//PA8->PA8_DTBLOQ := dDataBase ?! 
	        	            MSUnlock()
	        	            MsgAlert("Projeto(Opcional) alterado !")  
	        	        Endif     
                    
			   		Endif
				Endif
				BF4->(DbSkip())                                                          
			Enddo
	 	 Endif
  	EndIf         
  	BA1->(DbSkip())
  Endif 
EndDo

Return Nil                                                                                                                                                     

User Function ValNCpxAED()  

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ4¿
//³Checa o Campo BE4_YCOMPL                ³
//³SE E AED                                ³
//³E SE FOR "ALTA" CHECA LISTA DE PERMISSAO³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ4Ù

Local lRet := .T.                                                                                                                   

If M->BF4_CODPRO $ "0024;0038"    
   // MV_YCPXAED LISTA DE USUARIOS A AUTORIZAR A COLOCAR O BENEFICIARIO NO NIVEL DE RISCO "A-ALTO" 
     lRet :=  ((M->BF4_YCOMPL <> "A") .OR. (M->BF4_YCOMPL = "A" .AND. (Upper(Alltrim(cusername)) $ GetNewPar("MV_YCPXAED","MOTTA;SANDROT;JOAO.GOMES;ADMINISTRADOR;ANDREA.LEAO;MOTTA;LARISSA.LOBO;MARTHA;MARCELA.SANTOS;SERGIO.CUNHA;FELIPE.;MARCUS.VINICIUS;VINICIUS.COSTA/ANNE.ROSA/DANIEL.SILVA"))))
Else
  lRet := .F.   
Endif

Return lRetaed

// 
//³valida se a RDA existe e se é AED³
// 
User Function ValAED (cCodRDA)  

lRet := .F.

BAU->(DbSetOrder(1))
   BAU->(dbSeek(xFilial("BAU")+cCodRDA))
   While BAU->(BAU_CODIGO) == cCodRDA .OR. !BAU->(Eof())
  	 If BAU->(BAU_CODIGO) == cCodRDA
    	lRet := .T.
     Endif          
   BAU->(DbSkip())
   EndDo     
   
   If !lRet 
     MsgAlert('RDA nao localizada ou nao e AED !!')
   Endif

Return lRet
