#include "PLSMGER.CH"
#include "PROTHEUS.CH"
#include "COLORS.CH"
#IFDEF TOP
	#include "TOPCONN.CH"
#ENDIF       
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ PLSA586 ³ Autor ³ Tulio Cesar          ³ Data ³ 31.03.2003 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Cadastro de Pacotes                                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Advanced Protheus                                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Nenhum                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³            ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data   ³ BOPS ³  Motivo da Altera‡„o                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function PLA586

Local aAliasItem := { 	{"BLE","Comp. Pacote", "U_PL586VrPc(1)","U_PL586VrPc(1,.t.)"} } 

Local aKeyItem := {"BLD->(BLD_CODINT+BLD_CODPAD+BLD_CODPRO+BLD_CODPAC)+'0'" }

Local aCondItem := {"BLE->(BLE_CODINT+BLE_CODPAD+BLE_CODPRO+BLE_CODPAC+BLE_TIPO)" }
Local aChavCab := { {  {"BLE_CODINT","M->BLD_CODINT"},{"BLE_CODPAD","M->BLD_CODPAD"},{"BLE_CODPRO","M->BLD_CODPRO"},{"BLE_CODPAC","M->BLD_CODPAC"},{"BLE_TIPO","'0'"}} }
                     
PRIVATE aCols   := {}
PRIVATE aHeader := {}
Private oSay01
Private cCodInt := ""

PlsCabItem("BLD","Pacotes",aAliasItem,{1},aKeyItem,aCondItem,aChavCab,nil,nil,nil,nil,nil,nil,nil,nil,{{"RELATORIO",{|| PLA586ITD(M->BLD_CODINT,M->BLD_CODPAC) },"Valorizar Pacote"} }, { |oDlg| U_Pl586SayPc(oDlg) }) 

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PLSA586   ºAutor  ³Microsiga           º Data ³  04/14/03   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP6                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function PLA586Cd()
LOCAL nRet    := 0
LOCAL nOrdBLD := BLD->(IndexOrd())

BLD->(DbSetOrder(1))

BLD->(DbSeek(xFilial("BLD")+M->BLD_CODINT+M->BLD_CODPAD+M->BLD_CODPRO+Replicate("9",Len(BLD->BLD_CODPAC)),.T.))
BLD->(DbSkip(-1))

If BLD->(BLD_FILIAL+BLD_CODINT+BLD_CODPAD+BLD_CODPRO) <> xFilial("BLD")+M->(BLD_CODINT+BLD_CODPAD+BLD_CODPRO)
   nRet := StrZero(1,6)
Else
   nRet := StrZero(Val(BLD->BLD_CODPAC)+1,6)
Endif

BLD->(DbSetOrder(nOrdBLD))

M->BLD_CODPAC := nRet
cCodInt := M->BLD_CODINT
                    
Return(.T.)



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PL586ITD  ºAutor  ³Geraldo Felix Juniorº Data ³  14/04/03   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Pega itens do procedimento na TDE para pode ativa-lo ou    º±±
±±º          ³ desativa-los.                                              º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ PLA586                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function PLA586ITD(cCodint,cCodPac)
LOCAL oGetDados 	:= aObjGD[xnFolder]
LOCAL cCodPsa 		:= oGetDados:aCols[oGetDados:Linha(),oGetDados:PLRETPOS("BLE_CODOPC")]
LOCAL cCodTab 		:= (M->BLD_CODINT+Alltrim(oGetDados:aCols[oGetDados:Linha(),oGetDados:PLRETPOS("BLE_CODTAB")]))
LOCAL oDlgIt
LOCAL nOpca       	:= 0
LOCAL cTipo			:= ""
LOCAL aOldCols   := aClone(aCols)
LOCAL aOldHeader := aClone(aHeader)
LOCAL nOld       := n 

cCodTab += Space(Len(BD4->BD4_CODTAB)-Len(Alltrim(cCodTab)))
       
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Itens do procedimento...                                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE oBrwBWM 
PRIVATE aCabBWM  := {}
PRIVATE aDadBWM  := {}
PRIVATE aTrbBWM  := {}
                      
PRIVATE aCols    := {}
PRIVATE aHeader  := {}
PRIVATE n        := 1

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta a GetDados do Folder Usuarios                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Store Header "BWM" TO aCabBWM For .T.
               
dbSelectArea("BWM")
If nOpcx == K_Incluir
	MsgStop("Opcao disponivel somente em modo ALTERACAO!")
	Return()
Else                                                     
	cTipo := Alltrim(Str(xnFolder-1))
	If BWM->( dbSeek(xFilial("BWM")+cCodInt+cCodPac+cCodPsa+cCodTab+cTipo) )
		Store COLS "BWM" TO aDadBWM FROM aCabBWM VETTRAB aTrbBWM While xFilial("BWM")+cCodInt+cCodPac+cCodPsa+cCodTab+cTipo == BWM->(BWM_FILIAL+BWM_CODINT+BWM_CODPAC+BWM_CODPSA+BWM_CODTAB+BWM_TIPO)
	Else
		BD4->( dbSetorder(02) )
		If !BD4->( dbSeek(xFilial("BD4")+cCodPsa+cCodTab) )
			MsgStop("Nao itens cadastrados na TDE para este procedimento")
			Return()
		Else
			U_AddNItens(nOpcx, cCodPsa, cCodTab)
		Endif
	Endif
Endif

DEFINE MSDIALOG oDlgIt TITLE "Itens do Procedimento:  "+cCodPsa FROM 009,000 TO 029,060 OF GetWndDefault() //+" - "+cDesGruQtd  
oDlgIt:lEscClose := .F.

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta o Browse dos Procedimentos                                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oBrwBWM:= TPLSBrw():New(0013,001,237,150,nil  ,oDlgIt,nil    , nil      ,nil    ,nil  , nil, .T.  ,nil   ,.T.   ,nil   ,aCabBWM ,aDadBWM ,.F. ,"BWM" ,nOpcx,"Itens do Procedimento: "+cCodPsa,nil,nil,nil,aTrbBWM)  //+" - "+cDesGruQtd

ACTIVATE DIALOG oDlgIt CENTERED ON INIT ( EnchoiceBar(oDlgIt, {|| nOpca:=1,oDlgIt:End()},{|| nOpca:= 0,oDlgIt:End()} ))

If nOpca == 1
	aChave := {}
	aadd(aChave,{"BWM_CODINT",M->BLD_CODINT})
	aadd(aChave,{"BWM_CODPRO",M->BLD_CODPRO})
	aadd(aChave,{"BWM_CODPAC",M->BLD_CODPAC})
    oBrwBWM:Grava(aChave,.F.)
Endif

aCols     := aClone(aOldCols)
aHeader   := aClone(aOldHeader)
n         := nOld

Return()


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ADDITENS  ºAutor  ³Geraldo Felix Juniorº Data ³  14/04/03   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Complemento da funcao PLA586ITD()                          º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ PLA586ITD()                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function AddNItens(nOpcx, cCodPsa, cCodTab)

//LOCAL nPosInt	:= GdFieldPos("BWM_CODINT",aCabBWM)
//LOCAL nPosPct	:= GdFieldPos("BWM_CODPAC",aCabBWM)
//LOCAL nPosPro	:= GdFieldPos("BWM_CODPRO",aCabBWM)
LOCAL nPosPsa	:= GdFieldPos("BWM_CODPSA",aCabBWM)
LOCAL nPosTab	:= GdFieldPos("BWM_CODTAB",aCabBWM)
LOCAL nPosAdp	:= GdFieldPos("BWM_CDPADP",aCabBWM)
LOCAL nPosCod	:= GdFieldPos("BWM_CODIGO",aCabBWM)
LOCAL nPosDes	:= GdFieldPos("BWM_DESCRI",aCabBWM)
LOCAL nPosRef	:= GdFieldPos("BWM_VALREF",aCabBWM)
LOCAL nPosUnd	:= GdFieldPos("BWM_UNIDAD",aCabBWM)
LOCAL nPosVlm	:= GdFieldPos("BWM_VLMED",aCabBWM)
LOCAL nPosAci	:= GdFieldPos("BWM_PERACI",aCabBWM)
LOCAL nPosAtv	:= GdFieldPos("BWM_ATIVO",aCabBWM)
LOCAL nPosTip	:= GdFieldPos("BWM_TIPO",aCabBWM)
LOCAL nPosLgc	:= (Len(aCabBWM)+1)

aDadBWM	:= {}
nLin 	:= 1
While !BD4->( Eof() ) .and. BD4->( BD4_CODPRO+BD4_CODTAB ) == cCodPsa+cCodTab
	Aadd(aDadBWM, Array((Len(aCabBWM)+1)))
	
	aDadBWM[nLin,nPosPsa] := BD4->BD4_CODPRO
	aDadBWM[nLin,nPosTab] := BD4->BD4_CODTAB
	aDadBWM[nLin,nPosAdp] := BD4->BD4_CDPADP
	aDadBWM[nLin,nPosCod] := BD4->BD4_CODIGO
	aDadBWM[nLin,nPosDes] := CriaVar("BD4_DESCRI")
	aDadBWM[nLin,nPosRef] := BD4->BD4_VALREF
	aDadBWM[nLin,nPosUnd] := CriaVar("BD4_UNIDAD")
	aDadBWM[nLin,nPosVlm] := BD4->BD4_VLMED
	aDadBWM[nLin,nPosAci] := BD4->BD4_PERACI
	aDadBWM[nLin,nPosAtv] := ""
	aDadBWM[nLin,nPosTip] := Alltrim(Str((XNFOLDER-1)))
	aDadBWM[nLin,nPosLgc] := .F.
	
	Aadd(aTrbBWM, 0)
	
	nLin++
	BD4->( dbSkip() )
Enddo
                    
aHeader := aClone(aCabBWM)
aCols 	:= aClone(aDadBWM)	
n		:= 1

Return

/*                   
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ PLS586VlPc ³ Autor ³ Wagner Mobile Costa ³ Data ³ 26.06.03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Recalcula o valor do pacote [BLD_VALOR]                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ cCampo - Campo que vai ser retornado                       ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function PL586VrPc(nFolder,lDel)

Local nValor := M->BLD_VALOR, nLinha
Static nCont := 0   // contador criado porque quando se deleta entra duas vezes

Default lDel := .F.

If lDel
   If nCont # 0
      nCont := 0
   Else   
      If aObjGd[nFolder]:FieldGet("BLE_ATIVO")=="1"
      /*
         If !aObjGd[nFolder]:aCols[aObjGd[nFolder]:Linha(),Len(aObjGd[nFolder]:aHeader)+1]
            If aObjGd[nFolder]:FieldGet("BLE_VALCH") > 0
	           nValor -= aObjGd[nFolder]:FieldGet("BLE_VALCH")
            Else
	           nValor -= aObjGd[nFolder]:FieldGet("BLE_VALFIX")
            EndIf
         Else
            If aObjGd[nFolder]:FieldGet("BLE_VALCH") > 0
	           nValor += aObjGd[nFolder]:FieldGet("BLE_VALCH")
            Else
	           nValor += aObjGd[nFolder]:FieldGet("BLE_VALFIX")
            EndIf
         EndIf   
      */
      EndIf
      nCont++
   EndIf   
Else   
   nCont := 0
   If M->BLE_ATIVO=="1"
   /*
      If M->BLE_VALCH > 0
	     nValor += M->BLE_VALCH
      Else
	     nValor += M->BLE_VALFIX
      EndIf
   */
   EndIf	  
   If aObjGd[nFolder]:lInAddLine==NIL .or. !aObjGd[nFolder]:lInAddLine
      If aObjGd[nFolder]:FieldGet("BLE_ATIVO",nLinha)=="1"
      /*
         If aObjGd[nFolder]:FieldGet("BLE_VALCH") > 0
            nValor -= aObjGd[nFolder]:FieldGet("BLE_VALCH")
         Else
       	    nValor -= aObjGd[nFolder]:FieldGet("BLE_VALFIX")
         EndIf	  
      */
      EndIf   
   EndIf	  
EndIf

//M->BLD_VALOR := nValor
oEnchoice:Refresh()

Return .T.

/*                   
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ PLS586VlPc ³ Autor ³ Wagner Mobile Costa ³ Data ³ 02.07.03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Apresenta o valor do pacote [BLD_VALOR]                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function PL586SayPc(oDlg)

DEFINE FONT oFont NAME "Arial" SIZE 000,-014 BOLD

//@ 100,05 SAY oSay01 Var "VALOR TOTAL PACOTE:   "+Transform(M->BLD_VALOR,"@E 999,999,999.99") SIZE 200,010 OF oDlg PIXEL FONT oFont COLOR CLR_HBLUE


Return .T.
