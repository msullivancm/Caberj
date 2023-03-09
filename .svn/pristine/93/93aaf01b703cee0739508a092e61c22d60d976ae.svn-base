#Include "PROTHEUS.CH"
/*________________________________________________________________________________________
¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
¦¦+----------+--------------+-------+----------------------------+------+--------------+¦¦
¦¦¦ Programa ¦ AltParam   	¦ Autor ¦ MMT - Marcelo              ¦ Data ¦ 23/11/2022   ¦¦¦
¦¦+----------+--------------+-------+----------------------------+------+--------------+¦¦
¦¦¦Descrição ¦ Alteração de parametros em lote                                         ¦¦¦
¦¦¦          ¦ MV_XRECONC                                                              ¦¦¦
¦¦+----------+-------------------------------------------------------------------------+¦¦
¦¦¦ Uso      ¦  Caberj                                                                ¦¦¦
¦¦+----------+-------------------------------------------------------------------------+¦¦
¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
________________________________________________________________________________________*/


User Function AltParam(_cParam)

Local oGroup1
Local oSButton1
Local oSButton2
Static oDlg
Private oWBrowse1
Private aWBrowse1 := {}
Private cParam := _cParam


  DEFINE MSDIALOG oDlg TITLE "Alteração de parâmetro " + cParam FROM 000, 000  TO 500, 550 COLORS 0, 16777215 PIXEL

    @ 010, 012 GROUP oGroup1 TO 210, 260 PROMPT "Parâmetros" OF oDlg COLOR 0, 16777215 PIXEL
    fWBrowse1()
    
    @ 220, 012 BUTTON oButton1 PROMPT "Altera todos" SIZE 037, 012 OF oDlg ACTION Altera(.T.) PIXEL
    DEFINE SBUTTON oSButton1 FROM 220, 235 TYPE 01 OF oDlg ENABLE ACTION Grava()
    DEFINE SBUTTON oSButton2 FROM 220, 205 TYPE 02 OF oDlg ENABLE ACTION Cancela()

  ACTIVATE MSDIALOG oDlg CENTERED

Return

//------------------------------------------------ 
Static Function fWBrowse1()
//------------------------------------------------ 

Local aFil := FWLoadSM0()
Local nI
Local oOK := LoadBitmap(GetResources(),'br_verde') 
Local oNO := LoadBitmap(GetResources(),'br_vermelho')  


    cFilOri := cFilAnt

    For nI:=1 To Len(aFil)

        If aFil[nI,1] == cEmpAnt

            cFilAnt := aFil[nI,2]

//          xConteudo := GetMV(cParam,.T.,'DefSX6')
            xConteudo := xGetMV(cParam,.T.,'DefSX6')

            If !(Valtype(xConteudo) == "C" .And. xConteudo == 'DefSX6')

                Aadd(aWBrowse1,{.F.,aFil[nI,2] , aFil[nI,7] ,  xConteudo  , xConteudo  })

            EndIf

        EndIf

    Next

    cFilAnt := cFilOri    
    
    @ 023, 023 LISTBOX oWBrowse1 Fields HEADER "Alt", "Cod","Filial","Conteúdo","Novo Conteúdo" SIZE 230, 180 OF oDlg PIXEL ColSizes 5,5,50,50,50
    oWBrowse1:SetArray(aWBrowse1)
    oWBrowse1:bLine := {|| {;
      If(aWBrowse1[oWBrowse1:nAt,1],oNO,oOK),;
      aWBrowse1[oWBrowse1:nAt,2],;
      aWBrowse1[oWBrowse1:nAt,3],;
      aWBrowse1[oWBrowse1:nAt,4],;
      aWBrowse1[oWBrowse1:nAt,5];
    }}

    // DoubleClick event    
    oWBrowse1:bLDblClick := {|| Altera(.F.)  }
    

Return


Static Function Altera(lTipo) 

Local oGet1
Static oDlg2
Private xGet1 := aWBrowse1[oWBrowse1:nAt,5]


  DEFINE MSDIALOG oDlg2 TITLE "Novo Conteúdo" FROM 000, 000  TO 110, 200 COLORS 0, 16777215 PIXEL

    @ 015, 016 MSGET oGet1 VAR xGet1 SIZE 063, 010 OF oDlg2 COLORS 0, 16777215 PIXEL  HASBUTTON              
    DEFINE SBUTTON oSButton1 FROM 030, 053 TYPE 01 OF oDlg2 ENABLE ACTION Confirma(lTipo)

  ACTIVATE MSDIALOG oDlg2 CENTERED ON INIT "Novo Conteúdo"

Return



Static Function Confirma(lTipo)

Local nI

oDlg2:End()

If !lTipo //Apenas 1

    aWBrowse1[oWBrowse1:nAt,1] := .T.
    aWBrowse1[oWBrowse1:nAt,5] := xGet1
    
Else //Todos

    For nI:=1 To Len(aWBrowse1)

        aWBrowse1[nI,1] := .T.
        aWBrowse1[nI,5] := xGet1

    Next nI
EndIf

oWBrowse1:DrawSelect()

Return 


Static Function Cancela()
    oDlg:End()
Return


Static Function Grava()

Local nI
Local cFilOri := cFIlAnt
Local aLogZLG := {}
Local aInfoLog := {}
Local aInfFont := {}
Local _cCodUser := RetCodUsr()
Local _cObs
Local cTipoPar
Local cContDe
Local cContAte

aInfoLog := FWUsrUltLog(_cCodUser)
aInfFont := GetApoInfo("ALTPARAM.PRW")

For nI := 1 To Len(aWBrowse1)

    If !Empty(aWBrowse1[nI,5]) .And. aWBrowse1[nI,1] 

        cFilAnt := aWBrowse1[nI,2]
        PutMV(cParam,aWBrowse1[nI,5])

        cTipoPar := ValType(GetMV(cParam))

        If cTipoPar == "D"
            cContDe  := DToC(aWBrowse1[nI,4])
            cContAte := DToC(aWBrowse1[nI,5])
        ElseIf cTipoPar == "N"
            cContDe  := cValToChar(aWBrowse1[nI,4])
            cContAte := cValToChar(aWBrowse1[nI,5])
        Else
            cContDe  := aWBrowse1[nI,4]
            cContAte := aWBrowse1[nI,5]
        EndIf
/*
        _cObs := UsrRetName(_cCodUser) + " - ALTERACAO DE: " + cContDe + " PARA: " + cContAte

        aLogZLG := {}
        aadd(aLogZLG, {"ZLG_FILIAL"	, cFilAnt	    })			//1 - ZLG_FILIAL
        aadd(aLogZLG, {"ZLG_ALIAS" 	, "SX5"		    })			//2 - ZLG_ALIAS 
        aadd(aLogZLG, {"ZLG_CHAVE" 	, cParam	    })			//3 - ZLG_CHAVE
        aadd(aLogZLG, {"ZLG_OPERAC"	,"UPDATE"	    })			//4 - ZLG_OPERAC 
        aadd(aLogZLG, {"ZLG_RECNO"	, 0             })	        //5 - ZLG_RECNO 
        aadd(aLogZLG, {"ZLG_IP"		,aInfoLog[3]	})			//6 - ZLG_IP   
        aadd(aLogZLG, {"ZLG_DATA"	,aInfoLog[1]	})			//7 - ZLG_DATA 
        aadd(aLogZLG, {"ZLG_HORA"	,aInfoLog[2]	})			//8 - ZLG_HORA 
        aadd(aLogZLG, {"ZLG_OBS"	,_cObs 			})			//9 - ZLG_OBS 
        aadd(aLogZLG, {"ZLG_USUARI"	,_cCodUser  	})			//10 - ZLG_USUARI
        aadd(aLogZLG, {"ZLG_MAQUIN"	,aInfoLog[4]	})			//11 - ZLG_MAQUIN
        aadd(aLogZLG, {"ZLG_ROTINA"	,"ALTPARAM"		})			//12 - ZLG_ROTINA
        aadd(aLogZLG, {"ZLG_DTROTI"	,aInfFont[4]	})			//13 - ZLG_DTROTI
        aadd(aLogZLG, {"ZLG_HRROTI"	,aInfFont[5]	})			//14 - ZLG_HRROTI
        
        //-- Chamo funcao de gravacao na tabela ZLG
        lRet :=  StaticCall(CARGRVLOG, GRVLOGZLG, aLogZLG)
*/
    EndIf

Next nI

cFIlAnt := cFilOri

MsgInfo("Parêmetro " + cParam + " alterado com sucesso.")

oDlg:End()

Return

// 
Static Function xGetMv ( xParam , lLog , cDef )

    Local cRet :=  ""
    cRet := GetMV( xParam , lLog , cDef )

Return(cRet)

/*
Static Function CriaSX6()

Local nI

aFiliais := FWLoadSM0()

DbSelectArea("SX6")


//nPos := aScan( aFiliais, { |X| X[1]+x[2] == "0201" } ) 

X6_FIL     := "SX6->X6_FIL"     
X6_VAR     := "SX6->X6_VAR"     
X6_TIPO    := "SX6->X6_TIPO"    
X6_DESCRIC := "SX6->X6_DESCRIC" 
X6_DSCSPA  := "SX6->X6_DSCSPA"  
X6_DSCENG  := "SX6->X6_DSCENG"  
X6_CONTEUD := "SX6->X6_CONTEUD" 
X6_CONTSPA := "SX6->X6_CONTSPA" 
X6_CONTENG := "SX6->X6_CONTENG" 
X6_PROPRI  := "SX6->X6_PROPRI"  
X6_PYME    := "SX6->X6_PYME"    

For nI:=1 To Len(aFiliais)

    If aFiliais[nI,1] == cEmpAnt

        DbSelectArea("SX6")

//        If !SX6->(DbSeek(aFiliais[nI,2] + "MV_DATAFIS"))
        If !SX6->(DbSeek(aFiliais[nI,2] + "CA_TSTTST"))

            RecLock("SX6",.T.)
            &X6_FIL     := aFiliais[nI,2]
            &X6_VAR     := "MV_DATAFIS"
            &X6_TIPO    := "D"
            &X6_DESCRIC := "Ultima data de encerramento de operacoes fiscais  "
            &X6_DSCSPA  := "Última Fecha de Cierre de las Operaciones Fiscales"
            &X6_DSCENG  := "Last fiscal operation closing date.               "
            &X6_CONTEUD := "20201001"
            &X6_CONTSPA := "20201001"
            &X6_CONTENG := "20201001"
            &X6_PROPRI  := "S"
            &X6_PYME    := "S"
            SX6->(MsUnlock())

        EndIf

    EndIf

Next nI

Return
*/

/*---------------------------------------------------------------------*
 | Função : AltReconc                                                  |
 | Desc:  : Alteração parâmetro mv_xreconc                             |
 *---------------------------------------------------------------------*/

User Function AltReconc()

    U_ALTPARAM("MV_XRECONC")

Return

