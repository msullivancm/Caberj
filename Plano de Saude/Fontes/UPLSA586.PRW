#include "PLSMGER.CH"
#include "PROTHEUS.CH"
#include "COLORS.CH"
#IFDEF TOP
	#include "TOPCONN.CH"
#ENDIF       
/*/
苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
北谀哪哪哪哪穆哪哪哪哪穆哪哪哪穆哪哪哪哪哪哪哪哪哪哪哪履哪哪穆哪哪哪哪哪哪勘�
北砅rograma  � PLSA586 � Autor � Tulio Cesar          � Data � 31.03.2003 潮�
北媚哪哪哪哪呐哪哪哪哪牧哪哪哪牧哪哪哪哪哪哪哪哪哪哪哪聊哪哪牧哪哪哪哪哪哪幢�
北矰escri噭o � Cadastro de Pacotes                                        潮�
北媚哪哪哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北砋so       � Advanced Protheus                                          潮�
北媚哪哪哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北砅arametros� Nenhum                                                     潮�
北媚哪哪哪哪牧哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北�            ATUALIZACOES SOFRIDAS DESDE A CONSTRU�AO INICIAL           潮�
北媚哪哪哪哪哪穆哪哪哪哪履哪哪穆哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北砅rogramador � Data   � BOPS �  Motivo da Altera噭o                     潮�
北媚哪哪哪哪哪呐哪哪哪哪拍哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北滥哪哪哪哪哪牧哪哪哪哪聊哪哪牧哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪俦�
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌�
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
苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘�
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
北赏屯屯屯屯脱屯屯屯屯屯送屯屯屯淹屯屯屯屯屯屯屯屯屯退屯屯屯淹屯屯屯屯屯屯槐�
北篜rograma  砅LSA586   篈utor  矼icrosiga           � Data �  04/14/03   罕�
北掏屯屯屯屯拓屯屯屯屯屯释屯屯屯贤屯屯屯屯屯屯屯屯屯褪屯屯屯贤屯屯屯屯屯屯贡�
北篋esc.     �                                                            罕�
北�          �                                                            罕�
北掏屯屯屯屯拓屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯贡�
北篣so       � AP6                                                        罕�
北韧屯屯屯屯拖屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯急�
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌�
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
苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘�
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
北赏屯屯屯屯脱屯屯屯屯屯送屯屯屯淹屯屯屯屯屯屯屯屯屯退屯屯屯淹屯屯屯屯屯屯槐�
北篜rograma  砅L586ITD  篈utor  矴eraldo Felix Junior� Data �  14/04/03   罕�
北掏屯屯屯屯拓屯屯屯屯屯释屯屯屯贤屯屯屯屯屯屯屯屯屯褪屯屯屯贤屯屯屯屯屯屯贡�
北篋esc.     � Pega itens do procedimento na TDE para pode ativa-lo ou    罕�
北�          � desativa-los.                                              罕�
北掏屯屯屯屯拓屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯贡�
北篣so       � PLA586                                                     罕�
北韧屯屯屯屯拖屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯急�
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌�
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
       
//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪�
//� Itens do procedimento...                                            �
//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪�
PRIVATE oBrwBWM 
PRIVATE aCabBWM  := {}
PRIVATE aDadBWM  := {}
PRIVATE aTrbBWM  := {}
                      
PRIVATE aCols    := {}
PRIVATE aHeader  := {}
PRIVATE n        := 1

//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪�
//� Monta a GetDados do Folder Usuarios                                 �
//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪�
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

//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪�
//� Monta o Browse dos Procedimentos                                    �
//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪�
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
苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘�
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
北赏屯屯屯屯脱屯屯屯屯屯送屯屯屯淹屯屯屯屯屯屯屯屯屯退屯屯屯淹屯屯屯屯屯屯槐�
北篜rograma  矨DDITENS  篈utor  矴eraldo Felix Junior� Data �  14/04/03   罕�
北掏屯屯屯屯拓屯屯屯屯屯释屯屯屯贤屯屯屯屯屯屯屯屯屯褪屯屯屯贤屯屯屯屯屯屯贡�
北篋esc.     � Complemento da funcao PLA586ITD()                          罕�
北�          �                                                            罕�
北掏屯屯屯屯拓屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯贡�
北篣so       � PLA586ITD()                                                罕�
北韧屯屯屯屯拖屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯急�
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌�
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
苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘�
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
北谀哪哪哪哪穆哪哪哪哪哪哪履哪哪哪履哪哪哪哪哪哪哪哪哪哪履哪哪穆哪哪哪哪哪勘�
北矲uncao    � PLS586VlPc � Autor � Wagner Mobile Costa � Data � 26.06.03 潮�
北媚哪哪哪哪呐哪哪哪哪哪哪聊哪哪哪聊哪哪哪哪哪哪哪哪哪哪聊哪哪牧哪哪哪哪哪幢�
北矰escricao � Recalcula o valor do pacote [BLD_VALOR]                    潮�
北媚哪哪哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北砅arametros� cCampo - Campo que vai ser retornado                       潮�
北滥哪哪哪哪牧哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪俦�
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌�
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
苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘�
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
北谀哪哪哪哪穆哪哪哪哪哪哪履哪哪哪履哪哪哪哪哪哪哪哪哪哪履哪哪穆哪哪哪哪哪勘�
北矲uncao    � PLS586VlPc � Autor � Wagner Mobile Costa � Data � 02.07.03 潮�
北媚哪哪哪哪呐哪哪哪哪哪哪聊哪哪哪聊哪哪哪哪哪哪哪哪哪哪聊哪哪牧哪哪哪哪哪幢�
北矰escricao � Apresenta o valor do pacote [BLD_VALOR]                    潮�
北滥哪哪哪哪牧哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪俦�
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌�
/*/

User Function PL586SayPc(oDlg)

DEFINE FONT oFont NAME "Arial" SIZE 000,-014 BOLD

//@ 100,05 SAY oSay01 Var "VALOR TOTAL PACOTE:   "+Transform(M->BLD_VALOR,"@E 999,999,999.99") SIZE 200,010 OF oDlg PIXEL FONT oFont COLOR CLR_HBLUE


Return .T.
