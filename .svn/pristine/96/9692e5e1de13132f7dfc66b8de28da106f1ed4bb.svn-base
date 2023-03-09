#Define CRLF Chr(13)+Chr(10)
#Include "Protheus.Ch"
#Include "Colors.Ch"
#Include "TbiConn.Ch"
#Include  "FONT.CH"
#Include "TOPCONN.CH"
#INCLUDE "TCBrowse.ch"

//#Define cCampo1 "E2_CODRDA,E2_YLIBPLS,E2_FORNECE,E2_NOMFOR,E2_PREFIXO,E2_NUM,E2_PARCELA,E2_TIPO,E2_SALDO,E2_INSS,E2_ISS,E2_VRETPIS,E2_VRETCOF,E2_VRETCSL,E2_DECRESC,E2_MESBASE,E2_ANOBASE,E2_EMISSAO,E2_VENCREA,E2_HIST"

#xtranslate bSetGet(<uVar>) => {|u| If(PCount()== 0, <uVar>,<uVar> := u)}

**********************
User Function CABA080()
**********************

Local x := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

private aCampo1    :={"E2_CODRDA","E2_FORNECE","E2_NOMFOR","E2_PREFIXO","E2_NUM","E2_SALDO","E2_MESBASE","E2_ANOBASE","E2_EMISSAO","E2_VENCREA","E2_HIST"}
Private oFntAri13N :=  TFont():New( "Arial"       ,,-13,,.F.,,,,,.F. )
Private oFntAri11N :=  TFont():New( "Arial"       ,,-11,,.F.,,,,,.F. )
Private dVencDe    :=  Ctod("")
Private dVencAte   :=  Ctod("")
Private cNumRda    :=  Space(06)
Private cMesAnoDe  :=  Space(07)
Private cMesAnoAte :=  Space(07)
Private cStatusAt  :=  Space(25)
Private nCombo     
Private _nDias     := GETMV("MV_DIASPLS")
Private cAlias     := "SE2"
Private cCampoOk   := "E2_OK" 
Private cCampoVL   := "E2_VALOR"
Private aButtons   := {}
Private bOk        := {|| oDlgBord:End()}
Private bCancel    := {|| oDlgBord:End()}
Private cColunas   := ""
Private aCampos    := {}
Private oOk        := LoadBitMap(GetResources() , "LBOK_OCEAN" )
Private onOk       := LoadBitMap(GetResources() , "LBNO_OCEAN" )
Private cChave     := "E2_PREFIXO+E2_NUM+E2_PARCELA+E2_TIPO+E2_FORNECE+E2_LOJA"
Private aStruct    := {}
Private nTotReg    := 0
Private nTotVlr    := 0     
private lLimp      := .F.
//Private aFiltro    := {"Liberados" ,"Bloqueados - 90D","Bloquados + 90D"} 
Private aFiltro    := {"Liberados" ,"Bloqueados - "+ltrim(str(_nDias))+"D","Bloquados + "+ltrim(str(_nDias))+"D"} 
Private cAliasTmp  := "__Tmp"
Private oBrwBord

SX3->(DbSetOrder(1))
SX3->(DbSetOrder(2))
SX3->(DbSeek(cCampoOk))
Aadd(aCampos,{" ",cCampoOk,SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL,SX3->X3_PICTURE})
Aadd(aStruct,{cCampoOk,SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL                })

//SX3->(DbSetOrder(1))
//SX3->(DbSeek(cAlias)) 
//While SX3->(!Eof()) .And. SX3->X3_ARQUIVO == cAlias   
//If  Alltrim(SX3->X3_CAMPO) $ cCampo1 
for x:=1 to len(aCampo1)      
    If x =06 
       SX3->(DbSeek(cCampoVL))
       Aadd(aCampos,{"Valor","VALOR",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL,SX3->X3_PICTURE})
       Aadd(aStruct,{"Valor",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL                })     
    
     //  SX3->(DbSeek(cCampoVL))
       Aadd(aCampos,{"Deducoes","DEDUCOES",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL,SX3->X3_PICTURE})
       Aadd(aStruct,{"Deducoes",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL                })       
       
     //  SX3->(DbSeek(cCampoVL))
       Aadd(aCampos,{"Tx_Bco","Tx_Bco",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL,SX3->X3_PICTURE})
       Aadd(aStruct,{"Tx_Bco",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL                })                              
    EndIf 
    SX3->(DbSeek(aCampo1[X]))
//If  cCampo1[I] =Alltrim(SX3->X3_CAMPO)  
    Aadd(aCampos,{SX3->X3_TITULO,SX3->X3_CAMPO,SX3->X3_TIPO   ,SX3->X3_TAMANHO,SX3->X3_DECIMAL,SX3->X3_PICTURE})
	Aadd(aStruct,{SX3->X3_CAMPO,SX3->X3_TIPO ,SX3->X3_TAMANHO,SX3->X3_DECIMAL                                })
	cColunas += SX3->X3_CAMPO+","
next x
//SX3->(DbSkip())
//End

cColunas += " SE2.R_E_C_N_O_ "

oDlgBord:=TDialog():New(000,000,500,910,"Liberção de Pagamentos Atrasados",,,,,,,,,.T.)
oDlgBord:nClrPane:= RGB(255,255,254)

oDlgBord:bStart  := {||(EnchoiceBar(oDlgBord,bOk,bCancel,,aButtons))}

oSay01 := TSay():New(033,005,{|| "No.Rda"                           },oDlgBord,,oFntAri13N,,,,.T.,,,025,10)
oSay02 := TSay():New(033,085,{|| "Vencto De "                       },oDlgBord,,oFntAri13N,,,,.T.,,,035,10)
oSay03 := TSay():New(033,180,{|| "Vencto Ate"                       },oDlgBord,,oFntAri13N,,,,.T.,,,035,10)
oSay04 := TSay():New(033,280,{|| "Mes/Ano De?"                      },oDlgBord,,oFntAri13N,,,,.T.,,,035,10)
oSay08 := TSay():New(033,370,{|| "Ate ?"                            },oDlgBord,,oFntAri13N,,,,.T.,,,025,10)

oSay05 := TSay():New(050,380,{|| "Listar Titulos"                   },oDlgBord,,oFntAri13N,,,,.T.,,,100,10)
oSay06 := TSay():New(080,380,{|| "Reg. Selecionados"                },oDlgBord,,oFntAri13N,,,,.T.,,,100,10)
oSay07 := TSay():New(110,380,{|| "Valor Total"                      },oDlgBord,,oFntAri13N,,,,.T.,,,035,10)
oCom02 := TComboBox():New( 060,380,bSetGet(cStatusAt),aFiltro ,070,10,oDlgBord,,,,,,.T.,oFntAri13N,,,{||.T.             }                                                          )`

oGet01 := TGet():New(033,035,bSetGet(cNumRda )  ,oDlgBord,035,10,""                        ,{||.T.             },,,oFntAri13N,,,.T.,,,{||.T.},,,,.F.,,"BAUPLS","cNumRda" )
oGet02 := TGet():New(033,120,bSetGet(dVencDe )  ,oDlgBord,050,10,""                        ,{||.T.             },,,oFntAri13N,,,.T.,,,{||.T.},,,,.F.,,""   ,"dVencDe" )
oGet03 := TGet():New(033,215,bSetGet(dVencAte)  ,oDlgBord,050,10,""                        ,{||.T.             },,,oFntAri13N,,,.T.,,,{||.T.},,,,.F.,,""   ,"dVencAte")
oGet04 := TGet():New(033,320,bSetGet(cMesAnoDe) ,oDlgBord,035,10,"@e 99/9999"              ,{||.T.             },,,oFntAri13N,,,.T.,,,{||.T.},,,,.F.,,""  ,"cMesAnoDe" )  //{||Eval(bMontaBrw)}
oGet05 := TGet():New(033,395,bSetGet(cMesAnoAte),oDlgBord,035,10,"@e 99/9999"              ,{||.T.             },,,oFntAri13N,,,.T.,,,{||.T.},,,,.F.,,""  ,"cMesAnoAte")
oGet06 := TGet():New(090,380,bSetGet(nTotReg )  ,oDlgBord,070,10,""                        ,{||.T.             },,,oFntAri13N,,,.T.,,,{||.F.},,,,.F.,,""   ,"nToReg" )
oGet07 := TGet():New(120,380,bSetGet(nTotVlr )  ,oDlgBord,070,10,PesqPict("SE2","E2_SALDO"),{||.T.             },,,oFntAri13N,,,.T.,,,{||.F.},,,,.F.,,""   ,"nTotVlr")

TButton():New(150,380,"Executar" ,oDlgBord,{|| MsgRun("Aguarde... Selecionando Registros",,         {|| fMontaBrowse(.f.)})},50,20,,oDlgBord:oFont,.F.,.T.,.F.,,.F.,,,.F.)
TButton():New(180,380,"Limpar"   ,oDlgBord,{|| MsgRun("Aguarde... Atualizando Registros",,          {|| fLimp()})},50,20,,oDlgBord:oFont,.F.,.T.,.F.,,.F.,,,.F.)

oDlgBord:Activate(,,,.T.)

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABA080   ºAutor  ³Microsiga           º Data ³  10/31/08   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

***********************************************
Static function fMontaBrowse(lExcBord)
***********************************************

Local nI 	:= 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
Local nIt 	:= 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

Local cVencDe  := Dtos(dVencDe)
Local cVencAte := Dtos(dVencAte)
Local lRet     := .T.
Local cQuery   := ""

If Type("oBrwBord") <> "U" 
   oBrwBord:Refresh()
   oDlgBord:Refresh()
Endif

//Crio a tabela no banco de dados para exibição.
cQuery += " SELECT  distinct ' ' " + cCampoOk + " ,  (e2_saldo + e2_inss + e2_irrf + e2_iss + e2_vretpis + e2_vretcof  + e2_vretcsl ) VALOR ,  (e2_inss  + e2_irrf +  e2_iss + e2_vretpis + e2_vretcof  + e2_vretcsl ) DEDUCOES , e2_decresc Tx_Bco , " + cColunas + ",SE2.R_E_C_N_O_  RecnoE2 " 
cQuery += " FROM " + RetSqlName("SE2") + " SE2  ," + RetSqlName("SZB") + " SZB " 
cQuery += " WHERE  SE2.D_E_L_E_T_ = ' ' AND SZB.D_E_L_E_T_ = ' ' "         
//if                           
cQuery += " AND E2_filial = '" + xFilial("SE2") + "' AND ZB_filial = '" + xFilial("SZB") +"'"
cQuery += " AND E2_SALDO > 0 "  
cQuery += " AND E2_NUM = ZB_TITULO AND E2_PREFIXO = ZB_PREFIXO AND E2_TIPO = ZB_TIPO AND E2_CODRDA = ZB_CODRDA " 
cQuery += " AND SubStr(E2_ORIGEM,1,3) = 'PLS' "
cQuery += " AND E2_TIPO NOT IN ('TX','INS','ISS')"
if !lLimp 
//If Upper(Alltrim(cStatusAt)) <> "TODOS"
If Upper(Alltrim(cStatusAt)) == "LIBERADOS" //Liberados
	nCombo := 1
	cQuery += " AND E2_YLIBPLS IN ('S','M') "
ElseIf Upper(Alltrim(cStatusAt)) == "BLOQUEADOS - "+ltrim(str(_nDias))+"D"
	nCombo := 2
	cQuery += " AND  E2_YLIBPLS  = 'L' "
	cQuery += " AND (Trunc(To_date('" + dTos(dDataBase) + "','YYYYMMDD'))- Trunc( To_date(E2_VENCREA,'YYYYMMDD'))) <=  " + strzero(_nDias,3)
Else
	nCombo := 3
	cQuery += " AND  E2_YLIBPLS = 'L' "
	cQuery += " AND (Trunc(To_date('" + dTos(dDataBase) + "','YYYYMMDD'))- Trunc( To_date(E2_VENCREA,'YYYYMMDD'))) >=  " + strzero(_nDias,3)
Endif
Endif

If !empty(dVencDe) 
	cQuery += " AND E2_VENCREA BETWEEN '" + dTos(dVencDe) +"' And '" + dTos(dVencAte) + "'"
Endif

If !empty(cNumRda)
	cQuery += " AND E2_CODRDA = '" + cNumRda + "'"
Endif

If !empty(cMesAnoDe) .Or. !Empty(cMesAnoAte)
	cQuery += " AND (E2_ANOBASE||E2_MESBASE) BETWEEN '" + substr (cMesAnoDe,4,4) + substr (cMesAnoDe,1,2)  + "' AND  '" + substr (cMesAnoAte,4,4) + substr (cMesAnoAte,1,2) + "'"
Endif
//cQuery += " GROUP BY  " + cCampoOk +",e2_decresc ,"+ cColunas    //,R_E_C_N_O_  RecnoE2 " //+ If(!lExcBord,"' "+"'","'X"+"'")+

cQuery += " Order By E2_PREFIXO,E2_NUM " 

cQuery := ChangeQuery(cQuery)
If Select(cAliasTmp) <> 0 ; (cAliasTmp)->(DbCloseArea()) ; Endif
DbUseArea(.T.,"TopConn",TcGenQry(,,cQuery),cAliasTmp,.T.,.T.)
lLimp := .F.
For ni := 1 to Len(aStruct)
    If aStruct[ni,2] != 'C'
	   TCSetField(cAliasTmp, aStruct[ni,1], aStruct[ni,2],aStruct[ni,3],aStruct[ni,4])
	Endif
Next

cTmp2 := CriaTrab(NIL,.F.) //CriaTrab(aStruct,.T.)
Copy To &cTmp2

dbCloseArea()

dbUseArea(.T.,,cTmp2,cAliasTmp,.T.)

//DbSelectArea(cAliasTmp)
(cAliasTmp)->(DbGoTop())

If (cAliasTmp)->(Eof())
//	ApMsgInfo("Não foram encontrados registros com os parametros informados !")    altamiro 21/12/2009
	lRet := .F.
Else
	
	If !lExcBord
	   oGet01:bWhen := {|| .F.} ; oGet02:bWhen := {|| .F.} ; oGet03:bWhen := {|| .F.} ; oGet04:bWhen := {|| .F.}
	   oGet06:bWhen := {|| .F.} ; oGet05:bWhen := {|| .F.} ; oGet07:bWhen := {|| .F.} ; oCom02:bWhen := {|| .F.}//; oGet08:bWhen := {|| .F.}
	Endif
	
	IF Upper(Alltrim(cStatusAt)) == "LIBERADOS"
		TButton():New(210,380,"Bloquear Titulos",oDlgBord,{|| MsgRun("Aguarde... Bloqueando Registros Selecionados... ",,{|| CabBlqPls()})},50,20,,oDlgBord:oFont,.F.,.T.,.F.,,.F.,,,.F.)
	Else
		TButton():New(210,380,"Liberar Titulos" ,oDlgBord,{|| MsgRun("Aguarde... Liberando  Registros Selecionados... ",,{|| CabLibPls()})},50,20,,oDlgBord:oFont,.F.,.T.,.F.,,.F.,,,.F.)
	ENdif
	
Endif

oBrwBord := TcBrowse():New(050,005,365,190,,,,oDlgBord,,,,,,,oDlgBord:oFont,,,,,.T.,cAliasTmp,.T.,,.F.,,,.F.)

For nIt := 1 To Len(aCampos)
	c2 := If(nIt == 1," ",aCampos[nIt,1])
	c3 := If(nIt == 1,&("{|| If(Empty("+cAliasTmp+"->"+cCampoOk+"),onOk,oOk)}"),&("{||"+cAliasTmp+"->"+aCampos[nIt,2]+"  }"))
	c4 := If(nIt == 1,5,CalcFieldSize(aCampos[nIt,3],aCampos[nIt,4],aCampos[nIt,5],"",aCampos[nIt,1]))
	c5 := If(nIt == 1,"",aCampos[nIt,6])
	c6 := If(nIt == 1,.T.,.F.)
	oBrwBord:AddColumn(TCColumn():New(c2,c3,c5,,,"LEFT",c4,c6,.F.,,,,.F.))
	oBrwBord:bLDblClick   := {|| fAtuBrw(cAliasTmp,cCampoOk     )}
Next

oBrwBord:bHeaderClick := {|| fAtuBrw(cAliasTmp,cCampoOK,,.T.)}
oBrwBord:SetFocus()
//oBrwBord :Refresh()
//oDlgBord :Refresh()

Return(lRet)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABLibPLS  º Autor ³ Jose Carlos Noronhaº Data ³ 01/08/07   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Botao Liberar Titulos do PLS                               º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Caberj                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

****************************
Static Function CabLibPls()
****************************

Local aArea  := GetArea()
Local _cUser := RetCodUsr()

dbselectarea("SZA")
If dbseek(xFilial("SZA")+_cUser)
   If SZA->ZA_LIBPLS = "N" .Or. SZA->ZA_DIAS < (dDatabase - (cAliasTmp)->E2_VENCREA)
	  MsgALERT("Usuario Sem Permissao Para Liberar Titulos do PLS.","Atencao...")
	  Return
	Endif
Else
	MsgALERT("Usuario do sistema não cadastrado como Aprovador!!! Faça o cadastro deste usuario.")
	Return
EndIf

DbSelectArea(cAliasTmp)
DbGoTop()

While !eof()
	
	If !Empty((cAliasTmp)->&(cCampoOk))
		
		DbSelectArea("SE2")
		SE2->(DbGoto((cAliasTmp)->RecnoE2))
		
		nIndSZB := SZB->(IndexOrd())
		nRecSZB := SZB->(Recno())
		
		SZB->(DbSetOrder(4)) // Filial + AnoMes + CodRDA + Prefixo + Titulo
		If !SZB->(DbSeek(xFilial("SZB")+SE2->(E2_ANOBASE+E2_MESBASE+E2_CODRDA+E2_PREFIXO+E2_NUM) ))
			MsgALERT("Titulo sem Nota Fiscal!!! Impossivel Liberar.")
			SZB->(DbSetOrder(nIndSZB))
			SZB->(DbGoTo(nRecSZB))
			Return
		EndIf
		
		SZB->(DbSetOrder(nIndSZB))
		SZB->(DbGoTo(nRecSZB))
		
		FProcLibBloq("1")    
	    
	Endif

	DbSelectArea(cAliasTmp)
	DbSkip()
Enddo

RestArea(aArea)

fMontaBrowse(.F.)

ApMsgInfo(" Fim do Processamento !!! ")

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABBlqPLS  º Autor ³ Jose Carlos Noronhaº Data ³ 01/08/07   º±±
±7±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Botao Bloquear Titulos do PLS                              º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Caberj                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
***********************************
sTatic Function CabBlqPls(nRecnoE2)
***********************************

Local aArea  := GetArea()
Local _cUser := RetCodUsr()

dbselectarea("SZA")
If dbseek(xFilial("SZA")+_cUser)
	If SZA->ZA_BLQPLS = "N"
		MsgALERT("Usuario Sem Permissao Para Bloquear Titulos do PLS.","Atencao...")
	    Return
	Endif
Else
	Msgalert("Usuario do sistema não cadastrado como Aprovador!!! Faça o cadastro deste usuario.")
    Return
EndIf

DbSelectArea(cAliasTmp)
DbGoTop()

While !eof()
	
	If !Empty((cAliasTmp)->&(cCampoOk))
	   
		DbSelectArea("SE2")
		SE2->(DbGoto((cAliasTmp)->RecnoE2))
		
		FProcLibBloq("2")    
	
	Endif
	
	DbSelectArea(cAliasTmp)
	DbSkip()
Enddo

RestArea(aArea)

fMontaBrowse(.F.)

ApMsgInfo(" Fim do Processamento !!! ")

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABA080   ºAutor  ³Microsiga           º Data ³  11/04/08   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

********************************************************
Static Function fAtuBrw(cTmpAlias,cCampoOk,cGet,lTodos)
********************************************************

Local cMarca := Space(TamSx3(cCampoOk)[1])

SA1->(DbSetOrder(1))
If lTodos <> Nil .And. lTodos
	(cAliasTmp)->(DbGoTop())
	cMarca := If(Empty((cAliasTmp)->&(cCampoOk)),"X","")
	While (cAliasTmp)->(!Eof())
		(cAliasTmp)->(RecLock(cAliasTmp,.F.))
		(cAliasTmp)->&(cCampoOk) := cMarca
		(cAliasTmp)->(MsUnLock())
		If Empty((cAliasTmp)->&(cCampoOk))
		   nTotReg --
		   nTotVlr -= (cAliasTmp)->VALOR
	   Else
		   nTotReg ++
		   nTotVlr += (cAliasTmp)->VALOR
	   Endif
		(cAliasTmp)->(DbSkip())
	End
	(cTmpAlias)->(DbGoTop())
Else
	(cAliasTmp)->(RecLock(cAliasTmp,.F.))
	(cAliasTmp)->&(cCampoOk) := If(Empty((cAliasTmp)->&(cCampoOk)),"X","")
	(cAliasTmp)->(MsUnLock())
	If Empty((cAliasTmp)->&(cCampoOk))
		nTotReg --
		nTotVlr -= (cAliasTmp)->VALOR
	Else
		nTotReg ++
		nTotVlr += (cAliasTmp)->VALOR
	Endif
Endif

oGet06  :Refresh()
oGet07  :Refresh()
oBrwBord:Refresh()
oDlgBord:Refresh()

Return(.T.)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³FProcLibBloq³ Autor ³ Jose Carlos Noronha ³ Data ³ 02/08/07 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Rotina Para Liberar / Bloquear Titulos do PLS              ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ FProcLibBloq(cLibBlq)                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Caberj                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function FProcLibBloq(cLibBlq)

nmarcados := 1

If cLibBlq = "1"
   If SE2->E2_YLIBPLS = "S" .or. SE2->E2_YLIBPLS = "M"
       msgBox("Titulo Já Foi Liberado...","Liberação de Titulos","INFO") 
	    Return
   ElseIf SE2->E2_SALDO = 0
       msgBox("Titulo Baixado Não Pode Ser Liberado (Sem Saldo)...","Liberação de Titulos","INFO") 
	    Return
	Endif    
	//cMensgBx := "Confirma a Liberacao "+iif(nmarcados=1,"Deste Titulo ?","Destes Titulos ?")
Else
	If SE2->E2_YLIBPLS = "N" .or. SE2->E2_YLIBPLS = "L"
       msgBox("Titulo Já Foi Bloqueado...","Bloqueio de Titulos","INFO") 
	    Return
   ElseIf SE2->E2_SALDO = 0
       msgBox("Titulo Baixado Não Pode Ser Bloqueado (Sem Saldo)...","Bloqueio de Titulos","INFO") 
	    Return
	Endif    
	//cMensgBx := "Confirma o Bloqueio "+iif(nmarcados=1,"Deste Titulo ?","Destes Titulos ?")
Endif

//If MSGYESNO(cMensgBx)
   RecLock("SE2",.F.)
//	SE2->E2_YLIBPLS := Iif(cLibBlq="1","M","N")
	
	If cLibBlq = "1" .Or. cLibBlq = "2"
		SE2->E2_USUALIB := SZA->ZA_NOME                    // Usuario que Liberou/Bloqueou o Titulo 
		SE2->E2_YDTLBPG := dDataBase                       // Data da liberacao 
//		SE2->E2_YANLIBP := E2_YLIBPLS                      // Status anterior
	Endif	                                           
	SE2->E2_YLIBPLS := Iif(cLibBlq="1","M","L")
	SE2->E2_FLUXO   := Iif(cLibBlq="1","S","N")	
	MSunlock()
	
	VerImpostos(cLibBlq)
	
	dbSelectArea("SE2")
	If nCombo = 3
		cFilPLS := 'LEFT(E2_ORIGEM,3)="PLS" .and. E2_YLIBPLS $ "N|L" .And.(Date()-E2_VENCREA)<=GETMV("MV_DIASPLS")'     // Bloqueados
	ElseIf nCombo = 2
		cFilPLS := 'LEFT(E2_ORIGEM,3)="PLS" .and. E2_YLIBPLS $ "N|L" .and. (Date()-E2_VENCREA)>GETMV("MV_DIASPLS")'    // Bloqueados +60 Dias
	ElseIf nCombo = 1
		cFilPLS := 'LEFT(E2_ORIGEM,3)="PLS" .and. E2_YLIBPLS $ "S|M"'    // Liberados
	Endif
	cFilPLS += ' .And. (E2_EMISSAO >= mv_par02 .And. E2_EMISSAO <= mv_par03) .And. (E2_VENCREA >= mv_par04 .And. E2_VENCREA <= mv_par05) '
	cFilImp := cFilPLS +'.and. (!E2_TIPO $ GETMV("MV_TIPOPLS")) .And. E2_SALDO > 0'
	Set Filter To &cFilImp
	dbgotop()
//Endif
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³VerImpostos ³ Autor ³ Jose Carlos Noronha ³ Data ³ 02/08/07 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Verificar se Tem Titulos de Impostos do PLS                ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ VerImpostos(cLibBlq)                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Caberj                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static FuncTion VerImpostos(cLibBlq)

LOCAL cPrefixo := SE2->E2_PREFIXO    
LOCAL cNum	   := SE2->E2_NUM        
LOCAL cParcPai

DbSelectArea("SE2")
nReg := RECNO()
If SE2->E2_ISS > 0
	nValorPai := SE2->E2_ISS
	cParcPai  := SE2->E2_PARCISS
	cTipoPai  := MVISS
	AchaImpostos(nValorPai,cParcPai,cTipoPai,cFilial,cPrefixo,cNum,cLibBlq)
Endif
dbgoto(nReg)
If SE2->E2_INSS > 0
	nValorPai := SE2->E2_INSS
	cParcPai  := SE2->E2_PARCINS
	cTipoPai  := MVINSS
	AchaImpostos(nValorPai,cParcPai,cTipoPai,cFilial,cPrefixo,cNum,cLibBlq)
Endif
dbgoto(nReg)
If SE2->E2_SEST > 0
	nValorPai := SE2->E2_SEST
	cParcPai  := SE2->E2_PARCSES
	cTipoPai  := "SES"
	AchaImpostos(nValorPai,cParcPai,cTipoPai,cFilial,cPrefixo,cNum,cLibBlq)
Endif
dbgoto(nReg)
If SE2->E2_PIS > 0
	nValorPai := SE2->E2_PIS
	cParcPai  := SE2->E2_PARCPIS
	cTipoPai  := MVTAXA
	AchaImpostos(nValorPai,cParcPai,cTipoPai,cFilial,cPrefixo,cNum,cLibBlq)
Endif
dbgoto(nReg)
If SE2->E2_COFINS > 0
	nValorPai := SE2->E2_COFINS
	cParcPai  := SE2->E2_PARCCOF
	cTipoPai  := MVTAXA
	AchaImpostos(nValorPai,cParcPai,cTipoPai,cFilial,cPrefixo,cNum,cLibBlq)
Endif
dbgoto(nReg)
If SE2->E2_CSLL > 0
	nValorPai := SE2->E2_CSLL
	cParcPai  := SE2->E2_PARCSLL
	cTipoPai  := MVTAXA
	AchaImpostos(nValorPai,cParcPai,cTipoPai,cFilial,cPrefixo,cNum,cLibBlq)
Endif
dbgoto(nReg)
If SE2->E2_IRRF > 0
	nValorPai := SE2->E2_IRRF
	cParcPai  := SE2->E2_PARCIR
	cTipoPai  := MVTAXA
	AchaImpostos(nValorPai,cParcPai,cTipoPai,cFilial,cPrefixo,cNum,cLibBlq)
Endif
Return


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³AchaImpostos³ Autor ³ Jose Carlos Noronha ³ Data ³ 02/08/07 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Achar Titulos de Impostos do PLS                           ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Caberj                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function AchaImpostos(nValorPai,cParcPai,cTipoPai,xFilial,xPrefixo,cNum,cLibBlq)
dbSelectArea("SE2")
dbClearFilter()
If dbSeek(xFilial+xPrefixo+cNum)
	While !Eof() .and. SE2->(E2_FILIAL+E2_PREFIXO+E2_NUM) == xFilial+xPrefixo+cNum
		If cParcPai == SE2->E2_PARCELA .and. cTipoPai = SE2->E2_TIPO
			If nValorPai != 0
				RecLock("SE2",.F.)
				SE2->E2_YLIBPLS := Iif(cLibBlq="1","M","N")
				SE2->E2_USUALIB := SZA->ZA_NOME                    // Usuario que Liberou/Bloqueou o Titulo
				SE2->E2_FLUXO   := Iif(cLibBlq="1","S","N")
				MSunlock()
				Exit
			EndIf
		EndIf
		DbSkip()
	Enddo
EndIf
dbSelectArea("SE2")
dbgoto(nReg)
Return
      
***********************
Static Function fLimp()
***********************
Local cQuery := " "

//Limpa Variaveis   
cNumRda    :=  Space(06)
cMesAnoDe  :=  Space(07)
cMesAnoAte :=  Space(07)
llimp      := .T.
nTotReg    := 0
nTotVlr    := 0
dVencDe    := Ctod("  /  /    ")
dVencAte   := Ctod("  /  /    ")
//Atualiza objetos

oGet01  :Refresh()
oGet02  :Refresh()
oGet03  :Refresh()
oGet04  :Refresh()
oGet05  :Refresh()
oGet06  :Refresh()
oGet07  :Refresh()
oCom02  :Refresh()

//Habilita Campos para edição
oGet01:bWhen := {|| .T.} ; oGet02:bWhen := {|| .T.} ; oGet03:bWhen := {|| .T.} ; oGet04:bWhen := {|| .T.}
oGet06:bWhen := {|| .T.} ; oGet05:bWhen := {|| .T.} ; oGet07:bWhen := {|| .T.} ; oCom02:bWhen := {|| .T.}//; oGet08:bWhen := {|| .F.}

MsgRun("Aguarde... Selecionando Registros",,         {|| fMontaBrowse(.T.)})

//oBrwBord :Refresh()
//oDlgBord :Refresh()

Return
